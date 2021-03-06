<%@ page language="java" pageEncoding="UTF-8"%><%@page import="com.hk.web.util.HkWebConfig"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><hk:wap title="发送私信 - 火酷" rm="false" bodyId="thepage">
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="hang" onkeydown="submitMsg(event)">
		<hk:form name="msgfrm" action="/op/sms.do">
			<c:if test="${!enoughhkb}">
				<hk:data key="view.sms.cannot_sendsms" arg0="${userport}"/><br/>
			</c:if>
			<c:if test="${enoughhkb}">
				<hk:data key="func.msg.force_msg_send"/><br/>
				<hk:hide name="receiverId" value="${receiverId}"/>
				发短信至 <hk:a href="/home.do?userId=${receiver.userId}">${receiver.nickName }</hk:a><br/>
				<hk:textarea name="content" rows="3" cols="30" value="${content}"/><br/>
				<hk:submit name="msgandsms_submit" value="发送短信"/> 
				<script type="text/javascript">
					function submitMsg(event){
						if((event.ctrlKey)&&(event.keyCode==13)){
							document.msgfrm.submit();
						}
					}
				</script>
			</c:if>
		</hk:form>
	</div>
	<div class="hang even"><hk:a href="/home.do?userId=${receiverId}"><hk:data key="view.return"/></hk:a>
	</div>
	<jsp:include page="../inc/foot.jsp"></jsp:include>
</hk:wap>