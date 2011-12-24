<%@ page language="java" pageEncoding="UTF-8"%><%@page import="com.hk.bean.UserNoticeInfo"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><hk:wap title="消息提醒 - 火酷" rm="false" bodyId="thepage">
	<jsp:include page="../../inc/top.jsp"></jsp:include>
	<div class="hang">
		<hk:form action="/user/set/set_setNoticeInfo.do">
			<hk:checkbox name="labaReplyNotice" checkedvalue="${info.labaReplyNotice}" value="<%=UserNoticeInfo.NOTICE_Y %>" data="view.user.mgr.msgnotice.labaReplyNotice" res="true"/><br/>
					<hk:checkbox name="labaReplyIMNotice" checkedvalue="${info.labaReplyIMNotice}" value="<%=UserNoticeInfo.NOTICE_Y %>" data="view.user.mgr.msgnotice.labaReplyIMNotice" res="true"/><br/>
					<hk:checkbox name="labaReplySysNotice" checkedvalue="${info.labaReplySysNotice}" value="<%=UserNoticeInfo.NOTICE_Y %>" data="view.user.mgr.msgnotice.labaReplySysNotice" res="true"/><br/>
					<hk:checkbox name="msgNotice" checkedvalue="${info.msgNotice}" value="<%=UserNoticeInfo.NOTICE_Y %>" data="view.user.mgr.msgnotice.msgNotice" res="true"/><br/>
					<hk:checkbox name="followNotice" checkedvalue="${info.followNotice}" value="<%=UserNoticeInfo.NOTICE_Y %>" data="view.user.mgr.msgnotice.followNotice" res="true"/><br/>
					<hk:checkbox name="followIMNotice" checkedvalue="${info.followIMNotice}" value="<%=UserNoticeInfo.NOTICE_Y %>" data="view.user.mgr.msgnotice.followIMNotice" res="true"/><br/>
					<hk:checkbox name="followSysNotice" checkedvalue="${info.followSysNotice}" value="<%=UserNoticeInfo.NOTICE_Y %>" data="view.user.mgr.msgnotice.followSysNotice" res="true"/><br/>
			<hk:submit value="确定"/>
		</hk:form>
	</div>
	<div class="hang"><hk:a href="/user/set/set.do">回到设置</hk:a></div>
	<jsp:include page="../../inc/foot.jsp"></jsp:include>
</hk:wap>