package com.hk.frame.dao.query2;

import java.util.List;

import org.springframework.jdbc.core.RowMapper;

/**
 * DB2数据库分页查询写法
 * 
 * @author fire9
 */
public class DB2DaoSupport extends MysqlDaoSupport {

	@Override
	public <T> List<T> getListBySQL(String sql, int begin, int size, RowMapper<T> rm,
			Object[] values) {
//		select * from (
//
//		         select ROW_NUMBER() OVER(ORDER BY DOC_UUID DESC) AS ROWNUM, DOC_UUID, DOC_DISPATCHORG,       DOC_SIGNER, DOC_TITLE    from DT_DOCUMENT  ) a 
//
//		where ROWNUM > 20 and ROWNUM <=30
//		String db2sql="select ";
		return super.getListBySQL(sql, begin, size, rm, values);
	}
}