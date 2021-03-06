<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%>
<%String path=request.getContextPath(); %>
<c:set var="html_title" scope="request">${cmpUnion.name}</c:set>
<c:set var="html_main_content" scope="request">
	<div class="row">
		<hk:form action="/union/reg.do">
			<hk:hide name="uid" value="${uid}"/>
			<div class="row">Email或手机号:<br/>
			<hk:text name="input" value="${input}"/></div>
			<div class="row s">用于登录网站或找回密码,完全保密</div>
			<div class="row">密码:<br/>
			<hk:pwd name="password" maxlength="16" /></div>
			<div class="row s">4-16位以上数字或字母</div>
			<div class="row">重复输入密码:<br/>
			<hk:pwd name="password1" maxlength="16"/></div>
			<div class="row"><hk:submit name="n" value="提交"/></div>
			<div class="row s">贴士:火酷帐号可以直接<hk:a href="/union/login_tologin.do">登录</hk:a></div>
		</hk:form>
	</div>
	<div class="row">
	<hk:a href="/union/union.do?uid=${uid}">返回首页</hk:a>
	</div>
</c:set>
<jsp:include page="inc/frame.jsp"></jsp:include>