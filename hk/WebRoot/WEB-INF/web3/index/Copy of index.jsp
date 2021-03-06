<%@ page language="java" pageEncoding="UTF-8"%><%@page import="com.hk.web.util.Hkcss2Util"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="/WEB-INF/waphk.tld" prefix="hk"%>
<%String path = request.getContextPath();%>
<c:set var="html_title" scope="request">火酷网</c:set>
<c:set var="body_hk_content" scope="request">
	<table class="frame-3" cellpadding="0" cellspacing="0">
		<tr>
			<td class="l">
			<div class="mod_left">
				<div class="mod innermenu2">
<br class="linefix"/>
<div class="menu2">
<div class="menu2_tit">火酷导航</div>
<ul>
<c:forEach var="pk" items="${parentKindList}">
<li>
<a href="<%=path %>/cmp_pklist.do?parentId=${pk.kindId}">${pk.name}<!--[if IE 7]><!--></a><!--<![endif]-->
<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul>
		<c:forEach var="k" items="${pk.kindlist}" varStatus="idx">
			<li class="<c:if test="${idx.index==0}">first</c:if>">
				<a href="<%=path %>/cmp_klist.do?kindId=${k.kindId}" class="first">${k.name}</a>
			</li>
		</c:forEach>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
</c:forEach>
</ul>
<div class="clr"></div>
</div>
					</div>
				<c:if test="${fn:length(circlelist)>0}">
					<div class="mod">
						<div class="mod-4">
							<%=Hkcss2Util.rd_bg%>
							<div class="tit">
								商圈
							</div>
							<div class="cont text_14">
								<div class="innercon">
									<c:forEach var="b" items="${circlelist}">
									<a class="split-r" href="<%=path %>/cmp_bzcmplist.do?circleId=${b.circleId}">${b.name }</a>
									</c:forEach>
								</div>
							</div>
							<%=Hkcss2Util.rd_bg_bottom%>
						</div>
					</div>
				</c:if>
			</div>
			<div class="clr"></div>
			</td>
			<td class="mid">
			<div class="mid_con">
				<div class="mod">
					<div id="mainpic" class="main_img">
					</div>
					<div>
						<c:forEach var="cmp" items="${cmdcmplist}" varStatus="idx">
							<div class="imgcmp2">
							<a href="<%=path %>/cmp.do?companyId=${cmp.companyId}" onclick="changemainpic(${idx.index});return false;"><img alt="${cmp.name }" src="${cmp.head240 }"></a>
							</div>
						</c:forEach>
						<div class="clr"></div>
					</div>
				</div>
				<div class="mod">
					<h2 class="title">热门足迹</h2>
					<div class="innercon">
						<br style="line-height: 0px;" />
						<c:forEach var="cmp" items="${hotcmplist}">
							<div class="imgcmp">
							<a href="<%=path %>/cmp.do?companyId=${cmp.companyId}"><img alt="${cmp.name }" src="${cmp.head240 }"><br/>
							${cmp.name }</a>
							</div>
						</c:forEach>
						<div class="clr"></div>
					</div>
				</div>
				<c:if test="${fn:length(cmdproductlist)>0}">
					<div class="mod">
						<h2 class="title2">产品展示</h2>
						<div class="innercon">
						<br style="line-height: 0px;" />
							<c:forEach var="p" items="${randomproductlist}">
							<c:set var="p_url"><%=path %>/product.do?pid=${p.productId}</c:set>
								<div class="imgproduct">
								<a href="${p_url }"><span>${p.name }</span></a>
								<a href="${p_url }"><img class="phead" alt="${p.name }" src="${p.head240 }"></a>
								<a href="${p_url }"><c:if test="${p.score>0}"><img class="imgd" src="<%=path %>/webst3/img/stars/star${p.starsLevel }.gif" /><br/></c:if>
								<c:if test="${p.money>0}">￥${p.money}</c:if></a>
								</div>
							</c:forEach>
							<div class="clr"></div>
						</div>
					</div>
				</c:if>
				<c:if test="${fn:length(randomproductlist)>0}">
					<div class="mod">
						<h2 class="title2">产品展示</h2>
						<div class="innercon">
						<br style="line-height: 0px;" />
							<c:forEach var="p" items="${randomproductlist}">
							<c:set var="p_url"><%=path %>/product.do?pid=${p.productId}</c:set>
								<div class="imgproduct">
								<a href="${p_url }"><span>${p.name }</span></a>
								<a href="${p_url }"><img class="phead" alt="${p.name }" src="${p.head240 }"></a>
								<a href="${p_url }"><c:if test="${p.score>0}"><img class="imgd" src="<%=path %>/webst3/img/stars/star${p.starsLevel }.gif" /><br/></c:if>
								<c:if test="${p.money>0}">￥${p.money}</c:if></a>
								</div>
							</c:forEach>
							<div class="clr"></div>
						</div>
					</div>
				</c:if>
			</div>
			</td>
			<td class="r">
				<div class="f_r">
					<c:if test="${fn:length(userlikecmplist)>0}">
						<div class="mod">
							<div class="mod-4 r_mod3">
								<%=Hkcss2Util.rd_bg%>
								<div class="tit">
									大家喜欢去
								</div>
								<div class="cont">
									<br style="line-height: 0px;" />
									<c:forEach var="c" items="${userlikecmplist}">
										<div class="simple_product" style="width:205px">
											<div class="image">
												<a href="<%=path%>/cmp.do?companyId=${c.companyId }"><img src="${c.head60 }" /> </a>
											</div>
											<div class="content" style="width:130px;">
												<c:if test="${c.totalScore>0}">
													<img src="<%=path%>/webst3/img/stars/star${c.starsLevel }.gif" /><br />
												</c:if>
												<a href="<%=path%>/cmp.do?companyId=${c.companyId }">${c.name }</a>
											</div>
											<div class="clr"></div>
										</div>
									</c:forEach>
								</div>
								<%=Hkcss2Util.rd_bg_bottom%>
							</div>
							<div class="clr"></div>
						</div>
					</c:if>
					<c:if test="${fn:length(userlikeproductlist)>0}">
						<div class="mod">
							<div class="mod-4 r_mod3">
								<%=Hkcss2Util.rd_bg%>
								<div class="tit">
									大家喜欢买
								</div>
								<div class="cont">
									<br style="line-height: 0px;" />
									<c:forEach var="p" items="${userlikeproductlist}">
										<div class="simple_product">
											<div class="image">
												<a href="<%=path%>/product.do?pid=${p.productId }"><img src="${p.head60 }" /> </a>
											</div>
											<div class="content">
												<c:if test="${p.score>0}">
													<img src="<%=path%>/webst3/img/stars/star${p.starsLevel }.gif" /><br />
												</c:if>
												<a href="<%=path%>/product.do?pid=${p.productId }">${p.name }</a>
											</div>
											<div class="clr"></div>
										</div>
									</c:forEach>
								</div>
								<%=Hkcss2Util.rd_bg_bottom%>
							</div>
							<div class="clr"></div>
						</div>
					</c:if>
				</div>
			</td>
		</tr>
	</table>
<script type="text/javascript">
var path='<%=path%>';
var img=new Array();
<c:forEach var="cmp" items="${cmdcmplist}" varStatus="idx">
img[${idx.index }]=new Array(${cmp.companyId },'${cmp.head60 }','${cmp.head240 }','${cmp.name}');
</c:forEach>
function changemainpic(idx){
	if(idx>img.length){
		idx=0;
	}
	var url=path+'/cmp.do?companyId='+img[idx][0];
	setHtml('mainpic','<table class="imgtable" cellpadding="0" cellspacing="0"><tr><td><a href="'+url+'"><img title="'+img[idx][3]+'" alt="'+img[idx][3]+'" src="'+img[idx][2]+'" /></a></td></tr></table><a href="'+url+'">'+img[idx][3]+'</a>');
}
</script>
</c:set>
<jsp:include page="../inc/frame.jsp"></jsp:include>