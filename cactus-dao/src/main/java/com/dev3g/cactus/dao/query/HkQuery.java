package com.dev3g.cactus.dao.query;

import java.util.List;

import org.springframework.jdbc.core.RowMapper;

import com.dev3g.cactus.dao.sql.DataSourceStatus;

/**
 * 操作数据的工具类。调用daosupport进行数据库处理
 * 
 * @author akwei
 */
public class HkQuery {

	protected QuerySupport querySupport;

	protected ResultSetDataInfoCreater resultSetDataInfoCreater = new ResultSetDataInfoCreater();

	public void setQuerySupport(QuerySupport querySupport) {
		this.querySupport = querySupport;
	}

	/**
	 * 获rowmapper，先从表映射的对象开始匹配，如果没有，就到结果集resultsetdata中进行查找
	 * 
	 * @param <T>
	 * @param clazz
	 * @return
	 */
	public <T> RowMapper<T> getRowMapper(Class<T> clazz) {
		ResultSetDataInfo<T> resultSetDataInfo = this.resultSetDataInfoCreater
				.getResultSetDataInfo(clazz);
		if (resultSetDataInfo != null) {
			return resultSetDataInfo.getRowMapper();
		}
		throw new RuntimeException("no rowmapper for " + clazz.getName());
	}

	/**
	 * sql执行 insert
	 * 
	 * @param dsKey
	 *            数据库 key，配置datasource时，map中的key
	 * @param sql
	 *            需要执行的sql，完整的sql语句
	 * @param values
	 *            参数
	 * @return
	 */
	public Object insertBySQL(String dsKey, String sql, Object[] values) {
		DataSourceStatus.setCurrentDsKey(dsKey);
		return this.querySupport.insertBySQL(sql, values);
	}

	/**
	 * sql 执行 select
	 * 
	 * @param <T>
	 * @param partitionTableInfos
	 *            分区信息
	 * @param sql
	 *            需要执行的sql，完整的sql语句
	 * @param values
	 *            参数
	 * @param rm
	 *            返回值封装对象
	 * @return
	 */
	public <T> List<T> getListBySQL(String dsKey, String sql, Object[] values,
			int begin, int size, RowMapper<T> rm) {
		DataSourceStatus.setCurrentDsKey(dsKey);
		return this.querySupport.getListBySQL(sql, values, begin, size, rm);
	}

	public <T> List<T> getListBySQL(String dsKey, String sql, Object[] values,
			int begin, int size, Class<T> clazz) {
		return this.getListBySQL(dsKey, sql, values, begin, size, this
				.getRowMapper(clazz));
	}

	public int countBySQL(String dsKey, String sql, Object[] values) {
		DataSourceStatus.setCurrentDsKey(dsKey);
		return this.querySupport.getNumberBySQL(sql, values).intValue();
	}

	/**
	 * 执行sql并返回数值类型
	 * 
	 * @param partitionTableInfos
	 *            分区信息
	 * @param sql
	 *            需要执行的sql，完整的sql语句
	 * @param values
	 *            参数
	 * @return
	 */
	public Number getNumberBySQL(String dsKey, String sql, Object[] values) {
		DataSourceStatus.setCurrentDsKey(dsKey);
		return this.querySupport.getNumberBySQL(sql, values);
	}

	/**
	 * 执行sql，返回对象
	 * 
	 * @param <T>
	 * @param partitionTableInfos
	 *            分区信息
	 * @param sql
	 *            需要执行的sql，完整的sql语句
	 * @param values
	 *            参数
	 * @param rm
	 *            返回值封装对象
	 * @return
	 */
	public <T> T getObjectBySQL(String dsKey, String sql, Object[] values,
			RowMapper<T> rm) {
		DataSourceStatus.setCurrentDsKey(dsKey);
		return this.querySupport.getObjectBySQL(sql, values, rm);
	}

	public <T> T getObjectBySQL(String dsKey, String sql, Object[] values,
			Class<T> clazz) {
		return this
				.getObjectBySQL(dsKey, sql, values, this.getRowMapper(clazz));
	}

	/**
	 * sql update
	 * 
	 * @param partitionTableInfo
	 *            分区信息
	 * @param sql
	 *            需要执行的sql，完整的sql语句
	 * @param values
	 *            参数
	 * @return
	 */
	public int updateBySQL(String dsKey, String sql, Object[] values) {
		DataSourceStatus.setCurrentDsKey(dsKey);
		return this.querySupport.updateBySQL(sql, values);
	}
}