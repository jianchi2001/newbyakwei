<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><%String path = request.getContextPath();%>
<c:set var="html_title" scope="request">${o.name}</c:set>
<c:set var="html_body_content" scope="request">
<div class="hcenter" style="width: 820px;">
	<jsp:include page="../inc/mgrleft.jsp"></jsp:include>
	<div class="mgrright">
		<div class="mod">
		<div class="mod_title">${cmpNav.name } 二级栏目</div>
		<div class="mod_content">
			<div>
				<input value="创建二级栏目" type="button" class="btn" onclick="tourl('<%=path %>/epp/web/op/webadmin/admincmpnav_create2.do?parentId=${parentId }&companyId=${companyId}')"/>
			</div>
			<c:if test="${fn:length(list)>0}">
				<table class="nt" cellpadding="0" cellspacing="0">
					<c:forEach var="n" items="${list}" varStatus="idx">
						<div class="divrow bdtm" onmouseover="this.className='divrow bdtm bg2'" onmouseout="this.className='divrow bdtm'">
							<div class="f_l" style="width:120px">
								${n.name }
							</div>
							<div class="f_l" style="width:150px;padding-left: 20px">
								<a href="<%=path %>/epp/web/op/webadmin/admincmpnav_update2.do?oid=${n.oid }&parentId=${parentId }&companyId=${companyId}">修改</a> / 
								<a href="javascript:delcmpnav(${n.oid })">删除</a>
							</div>
							<div class="f_l" style="width:70px;">
								<c:if test="${idx.index>0}">
									<a href="<%=path %>/epp/web/op/webadmin/admincmpnav_chgpos2.do?oid=${n.oid }&parentId=${parentId }&companyId=${companyId}">位置上移</a>
								</c:if>&nbsp;
							</div>
							<div class="f_l">
								<c:if test="${o.cmpEdu && n.articleList}">
									<a href="javascript:selkind(${n.oid })">设置专业</a>
									<c:if test="${n.kindId>0}">
									<div>${n.cmpStudyKind.name }</div>
									</c:if>
								</c:if>
							</div>
							<div class="clr"></div>
						</div>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${fn:length(list)==0}">
				<div class="nodata">还没有添加任何栏目</div>
			</c:if>
			<div>
			<a class="more2" href="<%=path %>/epp/web/op/webadmin/admincmpnav.do?companyId=${companyId}">返回</a>
			</div>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function setcssdata(oid){
	tourl("<%=path %>/epp/web/op/webadmin/admincmpnav_setcssdata.do?oid="+oid+"&companyId=${companyId}&return_url="+encodeLocalURL());
}
function selkind(oid){
	tourl('<%=path %>/epp/web/op/webadmin/admincmpnav_selkind.do?companyId=${companyId}&oid='+oid+'&return_url='+encodeLocalURL());
}
function delcmpnav(oid){
	if(window.confirm('确实要删除？')){
		$.ajax({
			type:"POST",
			url:"<%=path%>/epp/web/op/webadmin/admincmpnav_del.do?companyId=${companyId}&oid="+oid,
			cache:false,
	    	dataType:"html",
			success:function(data){
				refreshurl();
			}
		});
	}
}
</script>
</c:set><jsp:include page="../inc/frame.jsp"></jsp:include>