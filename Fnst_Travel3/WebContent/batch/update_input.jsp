<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
  String path = request.getContextPath(); 
%>

    <c:if test="${empty manager}">
   <%
      response.sendRedirect(path + "/back/login.jsp");
   %>
</c:if>
<tx:head parseContent="true"/> 
<link href="../style/oa.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/public.js"></script>
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript">
$(function () {

	$.fn.numeral = function () {
	        $(this).css("ime-mode", "disabled");
	        this.bind("keypress", function (e) {
	            var code = (e.keyCode ? e.keyCode : e.which);  //兼容火狐 IE   
	            if (!$.browser.msie && (e.keyCode == 0x8))  //火狐下 不能使用退格键  
	            {
	                return;
	            }
	            return code >= 48 && code <= 57 || code == 46;

	        });
	        this.bind("blur", function () {

	            if (this.value.lastIndexOf(".") == (this.value.length - 1)) {
	                this.value = this.value.substr(0, this.value.length - 1);
	            } else if (isNaN(this.value)) {
	                this.value = " ";
	            } 
	        });
	        this.bind("paste", function () {
	            var s = clipboardData.getData('text');
	            if (!/\D/.test(s));
	            value = s.replace(/^0*/, '');
	            return false;
	        });
	        this.bind("dragenter", function () {
	            return false;
	        });
	        this.bind("keyup", function () {
	            this.value = this.value.replace(/[^\d.]/g, "");
	            //必须保证第一个为数字而不是.
	            this.value = this.value.replace(/^\./g, "");
	            //保证只有出现一个.而没有多个.
	            this.value = this.value.replace(/\.{2,}/g, ".");
	            //保证.只出现一次，而不能出现两次以上
	            this.value = this.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
	        });
	    };
	    
	    $("#subsidyID").numeral();
	});
	
	</script>
<title>修改批次信息</title>

<style type="text/css">
.inputinfo
{
margin-right:4px;
width:200px;
}
</style>
</head>
<base target="_self"/>
<body>
<center>
<form action="<%=path%>/back/updateBatch.action" method="post">
<input type="hidden" name="id" value="${batch.id}">
<input type="hidden" name="status" value="${batch.status}">
<input type="hidden" name="internalStatus" value="${batch.internalStatus}">
<input type="hidden" name="abroadStatus" value="${batch.abroadStatus}">
<TABLE class="tableEdit" border="0" cellspacing="1" cellpadding="0" style="width:500px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">修改批次信息</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->

<table class="tableEdit" style="width:500px;" cellspacing="0" border="0" cellpadding="3">

<tr>
		<td width="80px" class="tdEditLabel" >所属年份</td>			
		<td align="left" class="tdEditContent"><input style="float:left;margin-left:4px;width:140px" type="text" 
		id="YearthNameId" disabled="disabled" value="${batch.travelYearth.year }">
		<input type="hidden" value="${batch.travelYearth.id}" name="yearId" id="YearthIdId">
		<input type="button" style="width:60px" value="选择" 
		onclick="openWin('<%=path%>/back/listYearth.action?select=true','selectOrgs',600,600,1);">
		</td>
	</tr>
	<tr>
	    <td class="tdEditLabel" width="80px">编号</td>			
		<td align="left" class="tdEditContent"><input class="inputinfo"  type="text" 
		name="batchNo" readonly="readonly" value="${batch.batchNo}" id="batchNoId"></td>
	</tr>
	
	
	<tr>	
		<td  width="80px" class="tdEditLabel" >名称</td>			
		<td align="left" class="tdEditContent"><input class="inputinfo"  type="text" value="${batch.name}"
		name="name"></td>
	</tr>
	
	<tr>	
		<td width="80px" class="tdEditLabel" >开始日期</td>			
		<td align="left" class="tdEditContent">
		 <tx:datetimepicker displayFormat="yyyy-MM-dd"  name="startDate" value="#request.batch.startDate"></tx:datetimepicker>
	</td>

    <tr>	
		<td width="80px" class="tdEditLabel" >结束日期</td>			
		<td align="left" class="tdEditContent">
		 <tx:datetimepicker displayFormat="yyyy-MM-dd"  name="endDate" value="#request.batch.endDate" ></tx:datetimepicker>
	  </td>
	</tr>
	
	<tr>	
		<td width="80px" class="tdEditLabel" >补贴金额</td>			
		<td align="left" class="tdEditContent"><input type="text" class="inputinfo"
		name="subsidy" id="subsidyID" value="${batch.subsidy}" ></td>
	</tr>
	
	<tr>	
		<td width="80px" class="tdEditLabel" >关联批次</td>			
		<td align="left" class="tdEditContent"><input type="text" 
		name="relationBatch" class="inputinfo" value="${batch.relationBatch}"></td>
	</tr>
	
	<tr>
	   		<td width="80px" class="tdEditLabel" >备注</td>			
		<td align="left" class="tdEditContent"><textarea class="inputinfo" name="remarks" rows="6" cols="16">${batch.remarks}</textarea></td>
	</tr>
</table>

			<!-- 主输入域结束 -->
			</td>
		</TR>
	</TBODY>
</TABLE>

<TABLE>
		<TR align="center">
			<TD colspan="3" bgcolor="#EFF3F7">
			<input type="submit" name="saveButton"
				class="MyButton" value="保存批次信息"> 
			<input type="button" class="MyButton"
				value="关闭窗口" onclick="window.close()">
			</TD>
		</TR>
</TABLE>
</form>
</center>
</body>
</html>