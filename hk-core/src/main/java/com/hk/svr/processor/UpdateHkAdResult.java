package com.hk.svr.processor;

public class UpdateHkAdResult {

	/**
	 * 临时数据的id
	 */
	private long oid;

	/**
	 * 在省表中找到
	 */
	private int provinceId;

	private int remainHkb;

	private int errorCode;

	public int getRemainHkb() {
		return remainHkb;
	}

	public void setRemainHkb(int remainHkb) {
		this.remainHkb = remainHkb;
	}

	public int getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}

	public long getOid() {
		return oid;
	}

	public void setOid(long oid) {
		this.oid = oid;
	}

	public int getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(int provinceId) {
		this.provinceId = provinceId;
	}
}