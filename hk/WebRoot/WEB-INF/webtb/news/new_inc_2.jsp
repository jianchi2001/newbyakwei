<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"
%><a href="/p/${vo.last.dataMap.userid }">${vo.last.dataMap.nick }</a> 点评了 <a href="${ctx_path }/tb/item?itemid=${vo.last.dataMap.itemid}">${vo.last.dataMap.itemtitle }</a>： ${vo.last.dataMap.item_cmt_content }<a class="b" href="${ctx_path }/tb/item?itemid=${vo.last.dataMap.itemid}"> ...</a>