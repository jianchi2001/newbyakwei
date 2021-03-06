package com.hk.svr.processor;

import com.hk.svr.pub.Err;

public class UpdateBoxResult {

	private int errorCode;

	/**
	 * 在省表中找到
	 */
	private int provinceId;

	public void setProvinceId(int provinceId) {
		this.provinceId = provinceId;
	}

	public int getProvinceId() {
		return provinceId;
	}

	/**
	 * @return 成功会返回 {@link Err.SUCCESS},错误包括 {@link Err.ZONE_NAME_ERROR},
	 *         {@link Err.BOX_NOENOUGH_HKB_CREATEBOX} 2010-4-24
	 */
	public int getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}
}