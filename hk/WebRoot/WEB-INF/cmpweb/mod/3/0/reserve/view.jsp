<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache"%>
<%String path = request.getContextPath();%>
<c:set scope="request" var="html_body_content">
	<div class="tpad">
	<ul class="actorlist">
		<li>
			<div class="head">
				<c:if test="${not empty cmpActor.picPath}">
				<a href="/actor/${companyId }/${cmpActor.actorId }/"><img src="${cmpActor.pic240Url }"/></a>
				</c:if>
			</div>
			<div class="info">
				<a href="/actor/${companyId }/${cmpActor.actorId }/" class="b">${cmpActor.name }</a><br/>
				<table class="nt all" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right" width="90px" class="b">预约时间</td>
						<td>
							<fmt:formatDate value="${cmpReserve.reserveTime}" pattern="yyyy-MM-dd HH:mm"/>
							<c:if test="${!cmpReserve.expire}">
								<c:if test="${!cmpReserve.cancel && !cmpReserve.success}">
									<a class="split-r" href="javascript:cancelreserve(${cmpReserve.reserveId })">取消预约</a>
									<a class="split-r" href="javascript:update(${cmpReserve.reserveId },${cmpReserve.actorId })">修改预约</a>
								</c:if>
							</c:if>
							<c:if test="${cmpReserve.cancel || cmpReserve.success}">
								<hk:data key="epp.cmpreserve.reservestatus${cmpReserve.reserveStatus}"/>
							</c:if>
						</td>
					</tr>
					<c:if test="${fn:length(svrlist)>0}">
						<tr>
							<td align="right" width="90px" class="b">预约的服务</td>
							<td>
								<div class="usersvr">
									<ul class="datalist">
										<c:forEach var="svr" items="${svrlist}">
											<li>${svr.name }</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
					</c:if>
				</table>
				<div align="right">
					<input type="button" class="btn" value="回到我的预约" onclick="tourl('<%=path %>/epp/web/op/reserve.do?companyId=${companyId }')"/>
				</div>
			</div>
			<div class="clr"></div>
		</li>
	</ul>
	</div>
<script type="text/javascript">
function cancelreserve(reserveId){
	if(window.confirm('确实要取消此预约？')){
		$.ajax({
			type:"POST",
			url:"<%=path%>/epp/web/op/reserve_cancelreserve.do?companyId=${companyId}&reserveId="+reserveId,
			cache:false,
	    	dataType:"html",
			success:function(data){
				refreshurl();
			}
		});
	}
}
function update(reserveId,actorId){
	tourl("<%=path%>/epp/web/op/reserve_sel.do?companyId=${companyId}&update=1&actorId="+actorId+"&reserveId="+reserveId+"&return_url="+encodeLocalURL());
}
</script>
</c:set><jsp:include page="../inc/frame.jsp"></jsp:include>