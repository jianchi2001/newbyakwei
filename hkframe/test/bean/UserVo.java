package bean;

import com.hk.frame.dao.annotation.Column;

public class UserVo {

	@Column("testuser.userid")
	private long userid;

	@Column("member.nick")
	private String nick;

	public long getUserid() {
		return userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}
}