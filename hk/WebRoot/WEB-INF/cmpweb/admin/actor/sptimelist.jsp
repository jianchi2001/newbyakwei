<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><%String path = request.getContextPath();%>
<c:set var="html_title" scope="request">${o.name}</c:set>
<c:set var="html_body_content" scope="request">
<div class="hcenter" style="width: 820px;">
	<jsp:include page="../inc/mgrleft.jsp"></jsp:include>
	<div class="mgrright">
		<div class="mod">
		<div class="mod_title">${cmpActor.name } 假期管理
		<a class="more" href="<%=path %>/epp/web/op/webadmin/actor.do?companyId=${companyId}&actorId=${actorId}">返回</a>
		</div>
		<div class="mod_content">
			<div class="divrow">
				<input value="申请假期" type="button" class="btn split-r" onclick="tourl('<%=path %>/epp/web/op/webadmin/actor_createactorsptime.do?companyId=${companyId}&actorId=${actorId }')"/>
			</div>
			<c:if test="${fn:length(list)>0}">
				<c:forEach var="n" items="${list}">
					<div class="divrow bdtm" onmouseover="this.className='divrow bdtm bg2'" onmouseout="this.className='divrow bdtm'">
						<div class="f_l" style="width:150px">
							<hk:data key="epp.cmpactorsptime.spflg${n.spflg}"/>
						</div>
						<div class="f_l" style="width:250px">
							<fmt:formatDate value="${n.beginTime}" pattern="yyyy-MM-dd HH:mm"/>
							-
							<fmt:formatDate value="${n.endTime}" pattern="yyyy-MM-dd HH:mm"/>
						</div>
						<div class="f_l" style="width:160px;padding-left: 20px">
							<a href="javascript:updatesptime(${n.oid })">修改</a> / 
							<a href="javascript:delsptime(${n.oid })">删除</a>
						</div>
						<div class="clr"></div>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(list)==0}">
				<div class="nodata">还没有数据</div>
			</c:if>
			<div>
				<c:set var="page_url" scope="request"><%=path %>/epp/web/op/webadmin/sptimelist.do?companyId=${companyId}&actorId=${actorId}</c:set>
				<jsp:include page="../inc/pagesupport_inc.jsp"></jsp:include>
			</div>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function delsptime(oid){
	if(window.confirm('确实要删除？')){
		$.ajax({
			type:"POST",
			url:"<%=path%>/epp/web/op/webadmin/actor_delactorsptime.do?companyId=${companyId}&oid="+oid,
			cache:false,
	    	dataType:"html",
			success:function(data){
				refreshurl();
			}
		});
	}
}
function updatesptime(oid){
	tourl("<%=path%>/epp/web/op/webadmin/actor_updateactorsptime.do?companyId=${companyId}&actorId=${actorId}&oid="+oid+"&return_url="+encodeLocalURL());
}
</script>
</c:set><jsp:include page="../inc/frame.jsp"></jsp:include>