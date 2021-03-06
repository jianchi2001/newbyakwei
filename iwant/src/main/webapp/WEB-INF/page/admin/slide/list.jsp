<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"
%><c:set var="html_head_title" scope="request"><hk:value value="${project.name}"/></c:set>
<c:set var="html_head_value" scope="request">
<script type="text/javascript">

</script>
</c:set>
<c:set scope="request" var="mgr_body_content">
<div class="mod">
	<div class="mod_title">
		图片
		<a class="more" href="${appctx_path }/mgr/project_view.do?projectid=${projectid}">返回</a>
	</div>
	<div class="mod_content">
		<c:if test="${canaddslide}">
			<div>
				<input type="button" class="btn" onclick="tocreateslide()" value="添加图片"/>
			</div>
		</c:if>
		<ul class="rowlist">
			<c:forEach var="slide" items="${list }" varStatus="idx">
			<li id="row_${slide.slideid}">
				<div>
					<p align="center"><hk:value value="${slide.title }"/></p>
					<p align="center" style="width: 700px;overflow: hidden;"><img id="img_${slide.slideid}" src="${slide.pic2Url}"/></p>
					<p align="center">
					<c:if test="${idx.index>0}"><a href="javascript:chgposup(${slide.slideid })" class="split-r" id="op_chgposup${slide.slideid }">上移</a></c:if>
					<c:if test="${idx.index<fn:length(list)-1}"><a href="javascript:chgposdown(${slide.slideid })" class="split-r" id="op_chgposdown${slide.slideid }">下移</a></c:if>
					<a href="javascript:toupdateslide(${slide.slideid })" class="split-r" id="op_updateslide_${slide.slideid }">修改</a>
					<c:if test="${project.path != slide.pic_path }">
						<a href="javascript:setprojectpic(${slide.slideid })" class="split-r" id="op_setprojectpic_${slide.slideid }">设为项目主图</a>
					</c:if>
					<a href="javascript:opdelslide(${slide.slideid })" class="split-r" id="op_deleteslide_${slide.slideid }">删除</a>
					</p>
				</div>
				<div class="clr"></div>
			</li>
			</c:forEach>
			<c:if test="${(fn:length(list)==0) }">
				<li><div class="nodata">目前还没有添加内容</div></li>
			</c:if>
		</ul>
		<div>
		<div class="page3" align="center">
			<a class="p_center" href="${appctx_path }/mgr/project_view.do?projectid=${projectid}">返回</a>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var slideidarr=new Array();
<c:forEach var="slide" items="${list }" varStatus="idx">
slideidarr[${idx.index}]=${slide.slideid};
</c:forEach>
var submited=false;
var glassid=null;
function writenotice(){
	submited=false;
	var title = "填写通知内容";
	var html = "<div>";
	html+='<form id="noticefrm" method="post" onsubmit="return subnoticefrm(this.id);" action="${appctx_path}/mgr/notice_create.do" target="hideframe">';
	html+='<input type="hidden" name="pptid" value="${pptid}"/>';
	html+='<div class="row"><textarea id="id_content" name="content" style="width: 410px;height: 100px"></textarea></div>';
	html+='<div class="infowarn" id="err_content"></div>';
	html+='<div class="row" align="right"><input type="submit" value="发送" class="btn"/></div>';
	html+='</form>';
	html += '</div>';
	createWin('write_notice', 480, 300, title, html, "hidenoticewin()");
}

function subnoticefrm(frmid){
	if(submited){
		return false;
	}
	glassid=addGlass(frmid,false);
	submited=true;
	setHtml('err_content','');
	return true;
}

function createnoticeok(err,err_msg,v){
	submited=false;
	removeGlass(glassid);
	hidenoticewin()
	var title = "提醒";
	var html = "<div>";
	html += '通知已经提交，稍后会发送到用后手机中';
	html += '</div>';
	createWin('alertview', 400, 180, title, html, "hidealertwin()");
}

function createnoticeerr(err,err_msg,v){
	setHtml('err_content',err_msg);
	submited=false;
	removeGlass(glassid);
}

function hidenoticewin(){
	submited=false;
	hideWindow('write_notice');
}

function hidealertwin(){
	submited=false;
	hideWindow('alertview');
}

function chgimgwidth(imgid){
	var img=new Image();
	img.src=getObj(imgid).src;
	if(img.width>700){
		var height=img.height*700/img.width;
		$('#'+imgid).attr('width',700);
		$('#'+imgid).attr('height',height);
	}
}
$(document).ready(function(){
	<c:forEach var="slide" items="${list }" varStatus="idx">
	chgimgwidth('img_${slide.slideid}');
	</c:forEach>
	$('ul.rowlist li').bind('mouseenter', function(){
		$(this).addClass('enter');
	}).bind('mouseleave', function(){
		$(this).removeClass('enter');
	});
});
function chgposup(slideid){
	chgpos(slideid,getPrevSlideid(slideid),'op_chgposup'+slideid);
}
function chgposdown(slideid){
	chgpos(slideid,getNextSlideid(slideid),'op_chgposdown'+slideid);
}
function chgpos(slideid,pos_slideid,opobjid){
	var glassid_op=addGlass(opobjid,true);
	$.ajax({
		type:"POST",
		url:"${appctx_path}/mgr/slide_chgpos.do?slideid="+slideid+"&pos_slideid="+pos_slideid,
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
function setprojectpic(slideid){
	var glassid_op=addGlass("op_setprojectpic_"+slideid,true);
	$.ajax({
		type:"POST",
		url:"${appctx_path}/mgr/slide_setprojectpic.do?slideid="+slideid,
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
function getPrevSlideid(slideid){
	var prev_idx=-1;
	for(var i=0;i<slideidarr.length;i++){
		if(slideidarr[i]==slideid){
			prev_idx=i-1;
			break;
		}
	}
	if(prev_idx>-1){
		return slideidarr[prev_idx];
	}
	return 0;
}
function getNextSlideid(slideid){
	var next_idx=-1;
	for(var i=0;i<slideidarr.length;i++){
		if(slideidarr[i]==slideid){
			next_idx=i+1;
			break;
		}
	}
	if(next_idx>-1 && next_idx<slideidarr.length ){
		return slideidarr[next_idx];
	}
	return 0;
}
function toupdate(){
	tourl('${appctx_path}/mgr/slide.do?projectid=${projectid}');
}
function opdel(){
	if(window.confirm('确实要删除？')){
		var glassid_op=addGlass('op_delete',true);
		$.ajax({
			type:"POST",
			url:"${appctx_path}/mgr/ppt_delete.do?pptid=${pptid}",
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
function tocreateslide(){
	tourl('${appctx_path}/mgr/slide_create.do?projectid=${projectid}');
}
function toupdateslide(slideid){
	tourl('${appctx_path}/mgr/slide_update.do?slideid='+slideid+'&projectid=${projectid}');
}
function opdelslide(slideid){
	if(window.confirm('确实要删除？')){
		var glassid_op=addGlass('op_deleteslide_'+slideid,true);
		$.ajax({
			type:"POST",
			url:"${appctx_path}/mgr/slide_delete.do?slideid="+slideid,
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
<c:if test="${myslideid>0}">
scrollToPos('row_${myslideid}');
</c:if>
</script>
</c:set><jsp:include page="../inc/mgrframe.jsp"></jsp:include>