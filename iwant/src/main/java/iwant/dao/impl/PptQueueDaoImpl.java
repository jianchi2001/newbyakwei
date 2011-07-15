package iwant.dao.impl;

import halo.dao.query.BaseDao;
import iwant.bean.PptQueue;
import iwant.dao.PptQueueDao;

import java.util.List;

import org.springframework.stereotype.Component;

@Component("pptQueueDao")
public class PptQueueDaoImpl extends BaseDao<PptQueue> implements PptQueueDao {

	@Override
	public Class<PptQueue> getClazz() {
		return PptQueue.class;
	}

	@Override
	public List<PptQueue> getList(int begin, int size) {
		return this.getList(null, null, null, "pptid asc", begin, size);
	}
}