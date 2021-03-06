package iwant.dao;

import halo.dao.query.IDao;
import iwant.bean.District;

import java.util.List;

public interface DistrictDao extends IDao<District> {

	List<District> getListByCityid(int cityid);

	void deleteByProvinceid(int provinceid);

	void deleteByCityid(int cityid);

	boolean isExistByCityidAndName(int cityid, String name);

	boolean isExistByCityidAndNameAndNotDid(int cityid, String name, int did);

	District getByCityidAndNameLike(int cityid, String name);
}
