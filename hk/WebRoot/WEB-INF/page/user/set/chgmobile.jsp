<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%><hk:wap title="绑定手机号 - 火酷" rm="false" bodyId="thepage">
	<jsp:include page="../../inc/top.jsp"></jsp:include>
	<div class="hang">
		<c:if test="${userOtherInfo.mobileAlreadyBind}">
		<hk:data key="view.userotherinfo.currentmobileforbind" arg0="${userOtherInfo.mobile}"/><br/>
		</c:if>
		您的手机验证码是<span class="orange">yz${ran.randvalue}</span>(本验证码10分钟内有效).<br/>
		请通过手机发送<span class="orange">yz${ran.randvalue}</span>到1066916025完成本帐号的手机号绑定,10分钟之内有效.发送完毕后请耐心等待1分钟,1分钟后再次点击下面发送完毕链接.<br/>
		不操作不会对已经绑定的手机号有任何影像<br/>
		<hk:a href="/user/set/set_reChgMobile.do">重新获取验证码</hk:a>
	</div>
	<div class="hang"><hk:a href="/user/set/set.do">回到设置</hk:a></div>
	<jsp:include page="../../inc/foot.jsp"></jsp:include>
</hk:wap>