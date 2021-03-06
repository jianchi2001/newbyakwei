package com.hk.frame.web.interceptor;

import java.util.List;
import org.springframework.beans.factory.InitializingBean;

public class HkInterceprotStack extends HkAbstractInterceptor implements
		InitializingBean {
	private boolean freeze;

	private List<HkInterceptor> list;

	public void setList(List<HkInterceptor> list) {
		if (this.freeze) {
			throw new RuntimeException("interceptor list is freeze");
		}
		this.list = list;
	}

	public List<HkInterceptor> getList() {
		return list;
	}

	public void afterPropertiesSet() throws Exception {
		this.freeze = true;
	}
}