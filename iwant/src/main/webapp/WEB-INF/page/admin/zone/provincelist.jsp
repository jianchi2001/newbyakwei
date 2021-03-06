<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"
%><c:set scope="request" var="mgr_body_content">
<div class="mod">
	<div class="mod_title">省列表</div>
	<div class="mod_content">
		<div>
		<input type="button" class="btn" value="创建省" onclick="tocreate()"/>
		</div>
		<ul class="rowlist">
			<li>
				<div class="f_l" style="width: 150px;margin-right: 20px">名称</div>
				<div class="f_l" style="width: 80px;margin-right: 20px">顺序</div>
				<div class="clr"></div>
			</li>
			<c:forEach var="p" items="${list }" varStatus="idx">
			<li>
				<div class="f_l" style="width: 150px;margin-right: 20px">
					<hk:value value="${p.name }" onerow="true"/>
					<c:if test="${p.hidden}"><span class="ruo">隐藏中</span></c:if>
				</div>
				<div class="f_l" style="width: 240px;margin-right: 20px">
					<a href="${appctx_path}/mgr/zone_citylist.do?provinceid=${p.provinceid}" class="split-r">查看城市</a>
					<c:if test="${!p.hidden}">
					<a id="ophide_${p.provinceid}" href="javascript:hideprovince(${p.provinceid})" class="split-r">隐藏</a>
					</c:if>
					<c:if test="${p.hidden}">
					<a id="opshow_${p.provinceid}" href="javascript:showprovince(${p.provinceid})" class="split-r">显示</a>
					</c:if>
					<a href="javascript:toupdate(${p.provinceid })" class="split-r" id="op_update_${p.provinceid }">修改</a>
					<a href="javascript:opdel(${p.provinceid })" class="split-r" id="op_delete_${p.provinceid }">删除</a>
				</div>
				<div class="f_l" style="width: 80px;margin-right: 20px">
					<c:if test="${idx.index>0}">
						<a id="optoup_${p.provinceid}" class="split-r" href="javascript:toup(${p.provinceid})">上移</a>
					</c:if>
					<c:if test="${idx.index<fn:length(list)-1}">
						<a id="optoup_${p.provinceid}" class="split-r" href="javascript:todown(${p.provinceid})">下移</a>
					</c:if>
				</div>
				<div class="clr"></div>
			</li>
			</c:forEach>
			<c:if test="${(fn:length(list)==0)}">
				<li><div class="nodata">本页没有数据</div></li>
			</c:if>
		</ul>
	</div>
</div>
<script type="text/javascript">
var parr=new Array();
<c:forEach var="p" items="${list }" varStatus="idx">
parr[${idx.index}]=${p.provinceid};
</c:forEach>
$(document).ready(function(){
	$('ul.rowlist li').bind('mouseenter', function(){
		$(this).addClass('enter');
	}).bind('mouseleave', function(){
		$(this).removeClass('enter');
	});
});
function tocreate(){
	tourl('${appctx_path}/mgr/zone_createprovince.do');
}
function toupdate(pid){
	tourl('${appctx_path}/mgr/zone_updateprovince.do?provinceid='+pid);
}
function opdel(pid){
	if(window.confirm('确实要删除？')){
		var glassid_op=addGlass('op_delete_'+pid,false);
		$.ajax({
			type:"POST",
			url:"${appctx_path}/mgr/zone_deleteprovince.do?provinceid="+pid,
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
function getPrevId(pid){
	var prev_idx=-1;
	for(var i=0;i<parr.length;i++){
		if(parr[i]==pid){
			prev_idx=i-1;
			break;
		}
	}
	if(prev_idx>-1){
		return parr[prev_idx];
	}
	return 0;
}
function getNextId(pid){
	var prev_idx=-1;
	for(var i=0;i<parr.length;i++){
		if(parr[i]==pid){
			prev_idx=i+1;
			break;
		}
	}
	if(prev_idx<parr.length){
		return parr[prev_idx];
	}
	return 0;
}
function toup(pid){
	changePos(pid,getPrevId(pid));
}
function todown(pid){
	changePos(pid,getNextId(pid));
}
function changePos(pid,toid){
	var glassid_op=addGlass('optoup_'+pid,false);
	$.ajax({
		type:"POST",
		url:"${appctx_path}/mgr/zone_changeposprovince.do?provinceid="+pid+"&toid="+toid,
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
function hideprovince(pid){
	var glassid_op=addGlass('ophide_'+pid,false);
	$.ajax({
		type:"POST",
		url:"${appctx_path}/mgr/zone_hideprovince.do?provinceid="+pid,
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
function showprovince(pid){
	var glassid_op=addGlass('opshow_'+pid,false);
	$.ajax({
		type:"POST",
		url:"${appctx_path}/mgr/zone_showprovince.do?provinceid="+pid,
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
</script>
</c:set><jsp:include page="../inc/mgrframe.jsp"></jsp:include>