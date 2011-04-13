<%@ page language="java" pageEncoding="UTF-8"
%><%@page import="iwant.web.admin.util.Err"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"
%>
<form id="frm" method="post" onsubmit="subfrm(this.id)" target="hideframe" action="${form_action }">
<hk:hide name="ch" value="1"/>
<hk:hide name="catid" value="${catid }"/>
<table class="formt" cellpadding="0" cellspacing="0">
	<tr>
		<td width="90" align="right">名称</td>
		<td>
			<input maxlength="20" id="catname" name="name" value="<hk:value value="${cat.name }" onerow="true"/>" class="text"/>
			<div class="infowarn" id="err_name"></div>
		</td>
	</tr>
	<tr>
		<td width="90" align="right"></td>
		<td>
			<input type="submit" value="提交" class="btn split-r"/>
			<a href="${appctx_path }/mgr/cat.do">返回</a>
		</td>
	</tr>
</table>
</form>
<script type="text/javascript">
var err_code_<%=Err.PROJECT_NAME_ERR %>={objid:"err_name"};
var err_code_<%=Err.PROJECT_ADDR_ERR%>={objid:"err_addr"};
var err_code_<%=Err.PROJECT_TEL_ERR%>={objid:"err_tel"};
var err_code_<%=Err.PROJECT_DESCR_ERR%>={objid:"err_descr"};
var err_code_<%=Err.PROJECT_CATID_ERR%>={objid:"err_catid"};
var err_code_<%=Err.PROJECT_IMAGEFILE_FORMAT_ERR%>={objid:"err_f"};
var err_code_<%=Err.PROJECT_IMAGEFILE_SIZE_ERR%>={objid:"err_f"};
var err_code_<%=Err.PROCESS_IMAGEFILE_ERR%>={objid:"err_f"};

var glassid=null;
var submited=false;
function subfrm(frmid){
	if(submited){
		return false;
	}
	glassid=addGlass(frmid,false);
	submited=true;
	setHtml('err_name','');
	setHtml('err_addr','');
	setHtml('err_tel','');
	setHtml('err_descr','');
	setHtml('err_catid','');
	setHtml('err_f','');
	return true;
}

function createerr(json,errorlist){
	var errorcode_arr=errorlist.split(',');
	for(var i=0;i<errorcode_arr.length;i++){
		setHtml(getoidparam(errorcode_arr[i]),getmsgfromlist(errorcode_arr[i],json));
	}
	removeGlass(glassid);
	submited=false;
}

function updateerr(err,err_msg,v){
	var errorcode_arr=errorlist.split(',');
	for(var i=0;i<errorcode_arr.length;i++){
		setHtml(getoidparam(errorcode_arr[i]),getmsgfromlist(errorcode_arr[i],json));
	}
	removeGlass(glassid);
	submited=false;
}

function createok(err,err_msg,v){
	tourl('${appctx_path}/mgr/cat.do');
}

function updateok(err,err_msg,v){
	tourl('${appctx_path}/mgr/cat.do');
}
</script>