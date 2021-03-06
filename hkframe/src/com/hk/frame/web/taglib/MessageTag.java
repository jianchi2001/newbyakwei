package com.hk.frame.web.taglib;

import java.io.IOException;
import javax.servlet.jsp.JspWriter;
import com.hk.frame.util.HkUtil;

public class MessageTag extends BaseBodyTag {
	private static final long serialVersionUID = -6623958898546113511L;

	@Override
	protected void adapter(JspWriter writer) throws IOException {
		String msg = (String) this.getRequest().getAttribute(
				HkUtil.MESSAGE_NAME);
		if (msg == null) {
			msg = (String) this.getRequest().getSession().getAttribute(
					HkUtil.MESSAGE_NAME);
			this.getRequest().getSession().removeAttribute(HkUtil.MESSAGE_NAME);
		}
		if (msg != null) {
			writer.append(msg);
		}
	}
}