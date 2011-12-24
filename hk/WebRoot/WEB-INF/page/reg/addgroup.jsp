<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><hk:wap title="火酷" rm="false" bodyId="thepage">
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<hk:form action="/next/op/op_addgroup.do">
		<div class="hang">加入最热的圈子</div>
		<table class="list" cellpadding="0" cellspacing="0"><tbody>
			<c:forEach var="group" items="${list}" varStatus="idx"><c:if test="${idx.index%2==0}"><c:set var="clazz_var" value="odd" /></c:if><c:if test="${idx.index%2!=0}"><c:set var="clazz_var" value="even" /></c:if>
				<tr class="${clazz_var }"><td>
					<hk:a href="/group/op/op_adduser.do?gid=${group.groupId}">${group.name} (${group.ucount }人)</hk:a> 
				</td></tr>
			</c:forEach>
		</tbody></table>
		<div class="hang">
			<hk:submit name="jump" value="跳过" />
		</div>
	</hk:form>
	<jsp:include page="../inc/foot.jsp"></jsp:include>
</hk:wap>