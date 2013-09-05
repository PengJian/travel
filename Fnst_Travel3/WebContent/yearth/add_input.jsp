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
<link href="<%=path %>/style/oa.css" rel="stylesheet" type="text/css">
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
	    
	    $("#employeeOffID").numeral();
	    $("#familyOffID").numeral();
	});
	
	</script>

<title>添加年份信息</title>
</head>
<base target="_self"/>
<body>
<center>
<form action="<%=path%>/back/addYearth.action" method="post">
<TABLE class="tableEdit" border="0" cellspacing="1" style="width:380px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">添加年份信息</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->

<table class="tableEdit" style="width:380px;" cellspacing="0" border="0" cellpadding="3">
	<tr>
	    <td class="tdEditLabel" >年份</td>			
		<td class="tdEditContent" align="left"><input  style="width:220px" type="text" 
		name="year"></td>
	</tr>
	<tr>
	    <td class="tdEditLabel" >员工补贴</td>			
		<td class="tdEditContent" align="left"><input id="employeeOffID" style="width:220px" type="text" 
		name="employeeOff"></td>
	</tr>
	<tr>
	    <td class="tdEditLabel" >家属补贴</td>			
		<td class="tdEditContent" align="left"><input id="familyOffID"  style="width:220px" type="text" 
		name="familyOff"></td>
	</tr>
	<tr>	
		<td class="tdEditLabel" >备注</td>			
		<td class="tdEditContent" align="left"><textarea name="remarks"  style="width:220px" rows="6" cols="16"></textarea></td>
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
				class="MyButton" value="保存年份信息"> 
			<input type="button" class="MyButton"
				value="关闭窗口" onclick="window.close()">
			</TD>
		</TR>
</TABLE>
</form>
</center>
</body>
</html>