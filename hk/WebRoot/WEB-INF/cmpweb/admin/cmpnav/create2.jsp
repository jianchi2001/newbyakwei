<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.hk.bean.CmpNav"%>
<%@page import="com.hk.svr.pub.Err"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><%String path = request.getContextPath();%>
<c:set var="html_title" scope="request">${o.name}</c:set>
<c:set var="html_body_content" scope="request">
<div class="hcenter" style="width: 820px;">
	<jsp:include page="../inc/mgrleft.jsp"></jsp:include>
	<div class="mgrright">
		<div class="mod">
		<div class="mod_title">创建二级栏目</div>
		<div class="mod_content">
			<br/>
			<div>
				<c:set var="cmpnav_form_action" scope="request"><%=path %>/epp/web/op/webadmin/admincmpnav_create2.do</c:set>
				<jsp:include page="form2.jsp"></jsp:include>
			</div>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function createerror(error,msg,v){
	setHtml(getoidparam(error),msg);hideGlass();
}
function createok(error,msg,v){
	tourl("<%=path %>/epp/web/op/webadmin/admincmpnav_list2.do?parentId=${parentId}&companyId=${companyId}");
}
function check_navcontentref(v){
	if(parseInt(v)==<%=CmpNav.REFFUNC_LISTCONTENT %>){
		getObj('_navcontentref').style.cssText="display:block";
	}
	else{
		getObj('_navcontentref').style.cssText="display:none";
	}
	if(parseInt(v)==<%=CmpNav.REFFUNC_LINK %>){
		$('#reffunc_link_div').css('display','block');
	}
	else{
		$('#reffunc_link_div').css('display','none');
	}
}
</script>
</c:set><jsp:include page="../inc/frame.jsp"></jsp:include>