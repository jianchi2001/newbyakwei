package tuxiazi.bean;

import com.hk.frame.dao.annotation.Column;
import com.hk.frame.dao.annotation.Id;
import com.hk.frame.dao.annotation.Table;

/**
 * 用户的图片
 * 
 * @author Administrator
 */
@Table(name = "user_photo")
public class User_photo {

	/**
	 * 系统id
	 */
	@Id
	private long oid;

	/**
	 * 图片id
	 */
	@Column
	private long photoid;

	/**
	 * 用户id
	 */
	@Column
	private long userid;

	/**
	 * 图片隐私属性
	 */
	@Column
	private byte privacy_flg;

	private Photo photo;

	private User user;

	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}

	public long getOid() {
		return oid;
	}

	public void setOid(long oid) {
		this.oid = oid;
	}

	public long getPhotoid() {
		return photoid;
	}

	public void setPhotoid(long photoid) {
		this.photoid = photoid;
	}

	public long getUserid() {
		return userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public Photo getPhoto() {
		return photo;
	}

	public void setPhoto(Photo photo) {
		this.photo = photo;
	}

	public byte getPrivacy_flg() {
		return privacy_flg;
	}

	public void setPrivacy_flg(byte privacyFlg) {
		privacy_flg = privacyFlg;
	}
}