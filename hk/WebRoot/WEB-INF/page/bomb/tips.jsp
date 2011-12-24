<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.hk.web.util.HkWebConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%>
<hk:wap title="爆破日志 - 火酷" rm="false" style="/page/css/b.css">
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="hang">爆破日志</div>
	<c:if test="${fn:length(bomblabavoList)==0}">没有数据显示</c:if>
	<c:if test="${fn:length(list)>0}">
		<c:forEach var="t" items="${list}" varStatus="idx">
			<c:if test="${idx.index%2==0}"><c:set var="clazz_var" value="odd" /></c:if>
			<c:if test="${idx.index%2!=0}"><c:set var="clazz_var" value="even" /></c:if>
			<div class="hang ${clazz_var}">
				<hk:a href="/home.do?userId=${t.userId}">${t.user.nickName}</hk:a> 
				${t.content } 
				<span class="ruo"><fmt:formatDate value="${t.createTime}" pattern="yy-MM-dd HH:mm"/></span> 
				<hk:a clazz="s" href="/bomb/bomb_recovertip.do?tipId=${t.tipId}" page="true">恢复</hk:a>
			</div>
		</c:forEach>
		<c:if test="${userId>0}">
		<div class="hang">剩余${bomber.remainCount }个炸弹,累计${bomber.bombCount }个炸弹</div>
		</c:if>
		<hk:simplepage clazz="page" href="/bomb/bomb_list.do?userId=${userId}"/>
	</c:if>
	<c:if test="${admin || superAdmin}">
	<div class="hang"><hk:a href="/adminbomb/bomb_back.do?${queryString}">返回</hk:a></div>
	</c:if>
	<jsp:include page="../inc/foot.jsp"></jsp:include>
</hk:wap>