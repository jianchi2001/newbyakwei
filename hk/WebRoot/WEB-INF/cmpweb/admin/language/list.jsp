<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><%String path = request.getContextPath();%>
<c:set var="html_title" scope="request">${o.name}</c:set>
<c:set var="html_body_content" scope="request">
<div class="hcenter" style="width: 820px;">
	<jsp:include page="../inc/mgrleft.jsp"></jsp:include>
	<div class="mgrright">
		<div class="mod">
		<div class="mod_title">多语言版本</div>
		<div class="mod_content">
			<div>
				<form if="frm" method="post" onsubmit="return subfrm(this.id)" action="<%=path %>/epp/web/op/webadmin/cmplanguage_create.do" target="hideframe">
					<hk:hide name="companyId" value="${companyId}"/>
					域名：<hk:text name="domain" clazz="text"/>
					<hk:submit value="添加" clazz="btn"/>
					<div class="infowarn" id="errmsg"></div>
				</form>
			</div>
			<c:if test="${fn:length(list)>0}">
				<table class="nt" cellpadding="0" cellspacing="0">
					<c:forEach var="n" items="${list}">
						<div class="divrow bdtm" onmouseover="this.className='divrow bdtm bg2'" onmouseout="this.className='divrow bdtm'">
							<div class="f_l" style="width:300px">
								<span class="b split-r"><hk:data key="epp.language${n.refCmpInfo.language}"/></span>
								<a target="_blank" href="http://${n.refCmpInfo.domain }">${n.refCmpInfo.domain }</a>
							</div>
							<div class="f_l" style="width:80px;padding-left: 20px">
								<a href="javascript:delcmplanguage(${n.oid })">删除</a>
							</div>
							<div class="clr"></div>
						</div>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${fn:length(list)==0}">
				<div class="nodata">还没有添加其他语言</div>
			</c:if>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function delcmplanguage(oid){
	if(window.confirm('确实要删除？')){
		$.ajax({
			type:"POST",
			url:"<%=path%>/epp/web/op/webadmin/cmplanguage_del.do?companyId=${companyId}&oid="+oid,
			cache:false,
	    	dataType:"html",
			success:function(data){
				refreshurl();
			}
		});
	}
}
function createerror(error,msg,v){
	setHtml('errmsg',msg);
}
function createok(error,msg,v){
	refreshurl();
}
function subfrm(frmid){
	setHtml('errmsg','');
	return true;
}
</script>
</c:set><jsp:include page="../inc/frame.jsp"></jsp:include>