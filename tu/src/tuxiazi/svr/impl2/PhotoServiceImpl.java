package tuxiazi.svr.impl2;

import halo.util.DataUtil;
import halo.util.ResourceConfig;
import halo.util.image.ImageException;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import tuxiazi.bean.Api_user_sina;
import tuxiazi.bean.Friend_photo_feed;
import tuxiazi.bean.HotPhoto;
import tuxiazi.bean.Lasted_photo;
import tuxiazi.bean.Notice;
import tuxiazi.bean.Photo;
import tuxiazi.bean.PhotoLikeLog;
import tuxiazi.bean.PhotoUserLike;
import tuxiazi.bean.UploadPhoto;
import tuxiazi.bean.User;
import tuxiazi.bean.benum.NoticeEnum;
import tuxiazi.bean.benum.NoticeReadEnum;
import tuxiazi.dao.HotPhotoDao;
import tuxiazi.dao.Lasted_photoDao;
import tuxiazi.dao.NoticeDao;
import tuxiazi.dao.PhotoCmtDao;
import tuxiazi.dao.PhotoDao;
import tuxiazi.dao.PhotoLikeLogDao;
import tuxiazi.dao.PhotoLikeReport;
import tuxiazi.dao.PhotoLikeUserDao;
import tuxiazi.dao.PhotoUserLikeDao;
import tuxiazi.dao.User_photoDao;
import tuxiazi.svr.exception.ImageSizeOutOfLimitException;
import tuxiazi.svr.iface.FeedService;
import tuxiazi.svr.iface.PhotoService;
import tuxiazi.svr.impl.jms.HkMsgProducer;
import tuxiazi.svr.impl.jms.JmsMsg;
import tuxiazi.svr.impl.jms.JsonKey;
import tuxiazi.util.FileCnf;
import tuxiazi.web.util.SinaUtil;
import weibo4j.WeiboException;

@Component("photoService")
public class PhotoServiceImpl implements PhotoService {

	@Autowired
	private FileCnf fileCnf;

	private int lasted_photo_max_count = 100;

	@Autowired
	private PhotoDao photoDao;

	@Autowired
	private FeedService feedService;

	@Autowired
	private HkMsgProducer hkMsgProducer;

	@Autowired
	private User_photoDao user_photoDao;

	@Autowired
	private Lasted_photoDao lasted_photoDao;

	@Autowired
	private HotPhotoDao hotPhotoDao;

	@Autowired
	private PhotoUserLikeDao photoUserLikeDao;

	@Autowired
	private PhotoLikeUserDao photoLikeUserDao;

	@Autowired
	private NoticeDao noticeDao;

	@Autowired
	private PhotoCmtDao photoCmtDao;

	@Autowired
	private PhotoLikeLogDao photoLikeLogDao;

	private final Log log = LogFactory.getLog(PhotoServiceImpl.class);

	@Override
	public Photo createPhoto(UploadPhoto uploadPhoto, boolean withweibo,
			User user, Api_user_sina apiUserSina)
			throws ImageSizeOutOfLimitException, ImageException, IOException {
		Photo photo = new Photo();
		photo.upload(uploadPhoto, fileCnf, user);
		user.setPic_num(user.getPic_num() + 1);
		user.update();
		Lasted_photo lastedPhoto = new Lasted_photo(photo.getPhotoid());
		lastedPhoto.save();
		this.processLastedPhotoLimit();
		this.processFriend_photo_feed(photo);
		if (withweibo) {
			this.processWeibo(photo, apiUserSina);
		}
		return photo;
	}

	private void processFriend_photo_feed(Photo photo) {
		Friend_photo_feed feed = new Friend_photo_feed(photo.getUserid(),
				photo.getPhotoid(), photo.getCreate_time(), photo.getUserid());
		List<Friend_photo_feed> friendPhotoFeeds = new ArrayList<Friend_photo_feed>();
		friendPhotoFeeds.add(feed);
		// 先把图片创建到自己的队列中
		this.feedService.createFriend_photo_feed(friendPhotoFeeds);
		// 发布图片创建的消息到其他粉丝中
		JmsMsg jmsMsg = new JmsMsg();
		jmsMsg.setHead(JmsMsg.HEAD_PHOTO_CREATEPHOTO);
		// 添加图片创建人，为了获取图片创建人的粉丝数据
		jmsMsg.addData(JsonKey.userid, String.valueOf(photo.getUserid()));
		StringBuilder sb = new StringBuilder();
		// 添加图片id，创建人id
		sb.append(photo.getPhotoid()).append(":").append(photo.getUserid());
		jmsMsg.addData(JsonKey.photos, sb.toString());
		jmsMsg.buildBody();
		this.hkMsgProducer.send(jmsMsg.toMessage());
	}

	private void processLastedPhotoLimit() {
		int count = this.lasted_photoDao.count();
		if (count > this.lasted_photo_max_count) {
			List<Lasted_photo> tmplist = this.lasted_photoDao.getList(
					this.lasted_photo_max_count - 1, count
							- this.lasted_photo_max_count);
			for (Lasted_photo o : tmplist) {
				o.delete();
			}
		}
	}

	private void processWeibo(Photo photo, Api_user_sina apiUserSina) {
		String content = "";
		if (DataUtil.isNotEmpty(photo.getName())) {
			content = photo.getName();
		}
		content = content
				+ " "
				+ ResourceConfig.getTextFromResource("i18n", "photourl",
						photo.getPhotoid() + "");
		String filepath = this.fileCnf.getFilePath(photo.getPath());
		File imgFile = FileCnf.getFile(filepath + Photo.p4_houzhui);
		try {
			SinaUtil.updateStatus(apiUserSina.getAccess_token(),
					apiUserSina.getToken_secret(), content, imgFile);
		}
		catch (WeiboException e) {
			log.error("error when share to weibo upload photo");
			log.error(e.toString());
		}
	}

	@Override
	public void deletePhoto(Photo photo, User user) {
		this.photoCmtDao.deleteByPhotoid(photo.getPhotoid());
		this.photoLikeUserDao.deleteByPhotoid(photo.getPhotoid());
		this.photoUserLikeDao.deleteByPhotoid(photo.getPhotoid());
		String filePath = this.fileCnf.getFilePath(photo.getPath());
		FileCnf.delPhotoFile(filePath);
		this.user_photoDao.deleteByUseridAndPhotoid(photo.getUserid(),
				photo.getPhotoid());
		this.photoDao.deleteById(photo.getPhotoid());
		this.hotPhotoDao.deleteByPhotoid(photo.getPhotoid());
		user.updatePic_num(this.user_photoDao.countByUserid(photo.getUserid()));
		this.feedService.deleteFriend_photo_feedByPhotoid(photo.getPhotoid());
	}

	@Override
	public void updatePhoto(Photo photo) {
		photo.update();
	}

	@Override
	public PhotoUserLike createPhotoUserLike(User user, Photo photo) {
		if (this.photoUserLikeDao.getByUseridAndPhotoid(user.getUserid(),
				photo.getPhotoid()) != null) {
			return null;
		}
		PhotoUserLike photoUserLike = new PhotoUserLike();
		photoUserLike.save(user.getUserid(), photo.getPhotoid(), new Date());
		// 更新图片喜欢数量，更新喜欢此图片的人信息
		photo.addLikeUser(user.getUserid(), user.getNick());
		photo.setLike_num(this.photoLikeUserDao.countByPhotoid(photo
				.getPhotoid()));
		photo.update();
		// 记录日志，便于进行热度分析
		PhotoLikeLog photoLikeLog = new PhotoLikeLog(photoUserLike.getOid(),
				photo.getPhotoid(), user.getUserid(),
				photoUserLike.getCreatetime());
		photoLikeLog.save();
		// 发送通知给图片所有者,如果是自己就不发送通知
		if (user.getUserid() != photo.getUserid()) {
			// 对用户图片打分进行特殊处理。只要通知存在，就不添加新通知
			Notice notice = this.noticeDao.getLastByUseridAndSenderidAndRefoid(
					photo.getUserid(), user.getUserid(), photo.getPhotoid());
			if (notice == null) {
				notice = new Notice();
				notice.setUserid(photo.getUserid());
				notice.setCreatetime(new Date());
				notice.setNotice_flg(NoticeEnum.ADD_PHOTOLIKE.getValue());
				notice.setReadflg(NoticeReadEnum.UNREAD.getValue());
				notice.setRefoid(photo.getPhotoid());
				notice.setSenderid(user.getUserid());
				notice.setData("");
				notice.save();
			}
		}
		return photoUserLike;
	}

	@Override
	public void deletePhotoUserLike(User user, Photo photo) {
		long photoid = photo.getPhotoid();
		long userid = user.getUserid();
		PhotoUserLike photoUserLike = this.photoUserLikeDao
				.getByUseridAndPhotoid(userid, photoid);
		if (photoUserLike != null) {
			photoUserLike.delete();
			// 删除热度日志
			this.photoLikeLogDao.deleteById(photoUserLike.getOid());
		}
		photo.removeLikeUser(userid);
		photo.setLike_num(this.photoLikeUserDao.countByPhotoid(photo
				.getPhotoid()));
		photo.update();
		// 进行通知数据处理,如果通知未读，就删除，否则不删除
		Notice notice = this.noticeDao.getLastByUseridAndSenderidAndRefoid(
				photo.getUserid(), userid, photoid);
		if (notice != null && !notice.isReaded()) {
			this.noticeDao.deleteById(notice.getNoticeid());
		}
	}

	@Override
	public void createHotPhotos(Date begin, Date end) {
		List<PhotoLikeReport> list = this.photoLikeLogDao
				.buildPhotoLikeReportListByTime(begin, end);
		// 获取新的热门大于50才进行全部删除
		if (list.size() > 50) {
			this.hotPhotoDao.deleteAll();
		}
		for (PhotoLikeReport o : list) {
			this.hotPhotoDao.deleteByPhotoid(o.getPhotoid());
			Photo photo = this.photoDao.getById(o.getPhotoid());
			if (photo != null) {
				HotPhoto hotPhoto = new HotPhoto();
				hotPhoto.setPhotoid(o.getPhotoid());
				hotPhoto.setPath(photo.getPath());
				hotPhoto.save();
			}
		}
	}

	@Override
	public void sharePhoto(Photo photo, Api_user_sina api_user_sina,
			String content) throws WeiboException {
		String path = this.fileCnf.getFilePath(photo.getPath());
		File file = new File(path);
		SinaUtil.updateStatus(api_user_sina.getAccess_token(),
				api_user_sina.getToken_secret(), content, file);
	}
}