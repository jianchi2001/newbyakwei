<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"
%>
<c:set var="html_head_title" scope="request">PPT管理</c:set>
<c:set scope="request" var="mgr_body_content">
<div class="mod">
	<div class="mod_title">PPT管理</div>
	<div class="mod_content">
		<div>
		<input type="button" class="btn" value="创建PPT" onclick="tocreate()"/>
		</div>
		<div style="padding-left: 50">
		<form method="get" action="${appctx_path}/mgr/ppt.do">
			<input type="hidden" name="projectid" value="${projectid}"/>
			<input type="text" class="text" name="name" value="<hk:value value="${pptSearchCdn.title}" onerow="true"/>"/>
			<input type="button" value="模糊搜索" class="btn"/>
		</form>
		</div>
		<ul class="rowlist">
			<li>
				<div class="f_l" style="width: 150px;margin-right: 20px">名称</div>
				<div class="clr"></div>
			</li>
			<c:forEach var="ppt" items="${list }" varStatus="idx">
			<li>
				<div class="f_l" style="width: 150px;margin-right: 20px">
					<a href="javascript:view(${ppt.pptid})"><hk:value value="${ppt.title }" onerow="true"/></a>
				</div>
				<div class="f_l">
					<a href="javascript:toupdate(${ppt.pptid })" class="split-r" id="op_update_${ppt.pptid }">修改</a>
					<a href="javascript:opdel(${ppt.pptid })" class="split-r" id="op_delete_${ppt.pptid }">删除</a>
				</div>
				<div class="clr"></div>
			</li>
			</c:forEach>
			<c:if test="${(fn:length(list)==0 && page==1) || (fn:length(list)==0 && page==null) }">
				<li><div class="nodata">本页没有数据</div></li>
			</c:if>
		</ul>
		<div>
			<c:set var="page_url" scope="request">${appctx_path }/mgr/project.do?projectid=${projectid }&amp;name=${pptSearchCdn.encTitle }</c:set>
			<jsp:include page="../../inc/pagesupport_inc.jsp"></jsp:include>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('ul.rowlist li').bind('mouseenter', function(){
		$(this).addClass('enter');
	}).bind('mouseleave', function(){
		$(this).removeClass('enter');
	});
});
function tocreate(){
	tourl('${appctx_path}/mgr/ppt_create.do');
}
function toupdate(pptid){
	tourl('${appctx_path}/mgr/ppt_update.do?pptid='+pptid+"&back_url="+encodeLocalURL());
}
function view(projectid){
	tourl('${appctx_path}/mgr/project_view.do?pptid='+pptid+"&back_url="+encodeLocalURL());
}
function opdel(pptid){
	if(window.confirm('确实要删除？')){
		var glassid_op=addGlass('op_delete_'+pptid,false);
		$.ajax({
			type:"POST",
			url:"${appctx_path}/mgr/ppt_delete.do?pptid="+pptid,
			cache:false,
	    	dataType:"html",
			success:function(data){
				refreshurl();
			},
			error:function(data){
				removeGlass(glassid_op);
				alert('服务器出错，请刷新页面稍后继续操作');
			}
		});
	}
}
</script>
</c:set><jsp:include page="../inc/mgrframe.jsp"></jsp:include>