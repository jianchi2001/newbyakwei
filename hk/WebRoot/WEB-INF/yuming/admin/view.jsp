<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/webtb/js/jquery-1.3.2.min.js">
</script>
		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/webtb/js/pub.js">
</script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/yuming/a.css" />
		<title>域名管理 - 更新</title>
	</head>
	<body>
	<div id="hk">
		${o.name }<br/><br/>
		${o.descr }<br/><br/>
		<a class="split-r" href="javascript:toupdate(${o.domainid})">修改</a>
		<a class="split-r" href="javascript:todel(${o.domainid})">删除</a>
	</div>
<script>
function toupdate(domainid){
	tourl('<%=request.getContextPath() %>/yuming/ymmgr/domain_update.do?domainid='+domainid);
}
function todel(domainid){
	if(window.confirm("确实要删除？")){
		tourl('<%=request.getContextPath() %>/yuming/ymmgr/domain_delete.do?domainid='+domainid);
	}
}
</script>
	</body>
</html>