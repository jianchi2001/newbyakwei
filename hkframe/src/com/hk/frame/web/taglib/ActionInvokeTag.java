package com.hk.frame.web.taglib;

import javax.servlet.jsp.JspWriter;

import com.hk.frame.util.HkUtil;
import com.hk.frame.web.action.ActionExe;

public class ActionInvokeTag extends BaseBodyTag {

	private static final long serialVersionUID = -1283364414996755943L;

	private String mappinguri;

	public void setMappinguri(String mappinguri) {
		this.mappinguri = mappinguri;
	}

	public String getMappinguri() {
		return mappinguri;
	}

	@Override
	protected void adapter(JspWriter writer) throws Exception {
		ActionExe actionExe = (ActionExe) this.getRequest().getAttribute(
				HkUtil.ACTION_EXE_ATTR_KEY);
		if (actionExe == null) {
			return;
		}
		actionExe.invokeInterceptor(this.mappinguri, this.getRequest(), this
				.getResponse());
	}
}