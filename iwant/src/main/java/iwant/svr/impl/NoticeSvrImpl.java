package iwant.svr.impl;

import halo.util.NumberUtil;
import iwant.bean.Notice;
import iwant.bean.NoticeQueue;
import iwant.bean.NoticeidCreator;
import iwant.bean.UserNotice;
import iwant.dao.NoticeDao;
import iwant.dao.NoticeQueueDao;
import iwant.dao.NoticeidCreatorDao;
import iwant.dao.UserNoticeDao;
import iwant.svr.NoticeSvr;
import iwant.util.apns.ApnsTool;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javapns.data.PayLoad;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("noticeSvr")
public class NoticeSvrImpl implements NoticeSvr {

	@Autowired
	private NoticeidCreatorDao noticeidCreatorDao;

	@Autowired
	private NoticeDao noticeDao;

	@Autowired
	private UserNoticeDao userNoticeDao;

	@Autowired
	private ApnsTool apnsTool;

	@Autowired
	private NoticeQueueDao noticeQueueDao;

	@Override
	public void createNotice(Notice notice) {
		long noticeid = NumberUtil.getLong(this.noticeidCreatorDao
				.save(new NoticeidCreator()));
		notice.setNoticeid(noticeid);
		this.noticeDao.save(notice);
		NoticeQueue noticeQueue = new NoticeQueue();
		noticeQueue.setNoticeid(noticeid);
		this.noticeQueueDao.save(noticeQueue);
	}

	@Override
	public void deleteNotice(long noticeid) {
		this.noticeDao.deleteById(noticeid);
		this.userNoticeDao.deleteByNoticeid(noticeid);
		this.noticeQueueDao.deleteById(noticeid);
	}

	@Override
	public Notice getNotice(long noticeid) {
		return this.noticeDao.getById(noticeid);
	}

	@Override
	public List<Notice> getNoticeList(int begin, int size) {
		return this.noticeDao.getList(begin, size);
	}

	@Override
	public UserNotice createUserNotice(long noticeid, long userid) {
		if (this.userNoticeDao.isExistByUseridAndNoticeid(userid, noticeid)) {
			return null;
		}
		UserNotice userNotice = new UserNotice();
		userNotice.setUserid(userid);
		userNotice.setNoticeid(noticeid);
		long sysid = NumberUtil.getLong(this.userNoticeDao.save(userNotice));
		userNotice.setSysid(sysid);
		return userNotice;
	}

	@Override
	public List<UserNotice> getUserNoticeList(boolean buildNotice, int begin,
			int size) {
		List<UserNotice> list = this.userNoticeDao.getList(begin, size);
		if (buildNotice) {
			List<Long> idList = new ArrayList<Long>();
			for (UserNotice o : list) {
				idList.add(o.getNoticeid());
			}
			Map<Long, Notice> map = this.noticeDao.getNoticeMapInId(idList);
			for (UserNotice o : list) {
				o.setNotice(map.get(o.getNoticeid()));
			}
		}
		return list;
	}

	@Override
	public void deleteUserNotice(UserNotice userNotice) {
		this.userNoticeDao.deleteById(userNotice.getSysid());
	}

	@Override
	public void sendApnsNotice(String deviceToken, PayLoad payLoad)
			throws Exception {
		this.apnsTool.sendNotification(
				"iphone_id" + System.currentTimeMillis(), deviceToken, payLoad);
	}

	@Override
	public UserNotice getUserNoticeByUseridAndNoticeid(long userid,
			long noticeid) {
		return this.userNoticeDao.getByUseridAndNoticeid(userid, noticeid);
	}

	@Override
	public void deleteNoticeQueue(NoticeQueue noticeQueue) {
		this.noticeQueueDao.deleteById(noticeQueue.getNoticeid());
	}

	@Override
	public List<NoticeQueue> getNoticeQueueList(int begin, int size) {
		return this.noticeQueueDao.getList(begin, size);
	}
}