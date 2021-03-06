package iwant.dao.impl;

import halo.dao.query.BaseDao;
import iwant.bean.UserNotice;
import iwant.dao.UserNoticeDao;

import java.util.List;

import org.springframework.stereotype.Component;

@Component("userNoticeDao")
public class UserNoticeDaoImpl extends BaseDao<UserNotice> implements
		UserNoticeDao {

	@Override
	public Class<UserNotice> getClazz() {
		return UserNotice.class;
	}

	@Override
	public void deleteByNoticeid(long noticeid) {
		this.delete(null, "noticeid=?", new Object[] { noticeid });
	}

	@Override
	public boolean isExistByUseridAndNoticeid(long userid, long noticeid) {
		if (this.count(null, "userid=? and noticeid=?", new Object[] { userid,
				noticeid }) > 0) {
			return true;
		}
		return false;
	}

	@Override
	public List<UserNotice> getList(int begin, int size) {
		return this.getList(null, null, null, "noticeid asc", begin, size);
	}

	@Override
	public UserNotice getByUseridAndNoticeid(long userid, long noticeid) {
		return this.getObject(null, "userid=? and noticeid=?", new Object[] {
				userid, noticeid });
	}
}