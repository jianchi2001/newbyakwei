package tuxiazi.dao;

import tuxiazi.bean.Notice;

import com.hk.frame.dao.query2.BaseDao;

public class NoticeDao extends BaseDao<Notice> {

	@Override
	public Class<Notice> getClazz() {
		return Notice.class;
	}
}
