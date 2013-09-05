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
<link href="../style/oa.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/public.js"></script>
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript">
 
 function check()
 {
	 var password = $("#password").val();
	 var repassword = $("#repassword").val();
	 if(password == ""){
		 alert('密码不能为空');
		 return false;
	 }
	 if(password != repassword){
		 alert('两次输入密码不一致！')
		 return false;
	 }
 }
 
</script>
<title>添加管理员信息</title>

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
<form action="<%=path%>/back/addUser.action" method="post" onsubmit="return check();">
<TABLE class="tableEdit" border="0" cellspacing="1" cellpadding="0" style="width:380px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">添加管理员信息</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->

<table class="tableEdit" style="width:380px;" cellspacing="0" border="0" cellpadding="3">
	<tr>
	    <td class="tdEditLabel" >姓名</td>			
		<td class="tdEditContent"><input class="inputinfo" type="text" name="name"></td>
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >用户名</td>			
		<td class="tdEditContent"><input class="inputinfo" type="text" name="username">
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >密码</td>			
		<td class="tdEditContent"><input class="inputinfo" type="password" id="password" name="password">
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >重复密码</td>			
		<td class="tdEditContent"><input class="inputinfo" type="password" id="repassword" name="repassword">
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
				class="MyButton" value="保存管理员信息"> 
			<input type="button" class="MyButton"
				value="关闭窗口" onclick="window.close()">
			</TD>
		</TR>
</TABLE>
</form>
</center>
</body>
</html>