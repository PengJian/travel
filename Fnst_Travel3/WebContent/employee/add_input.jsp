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
<style type="text/css">

.inputinfo
{
margin-right:4px;
width:200px;
}
</style>
<link href="../style/oa.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/public.js"></script>
<title>添加员工信息</title>
</head>
<base target="_self"/>
<body>
<center>
<form action="<%=path%>/back/addEmployee.action" method="post">
<TABLE class="tableEdit" border="0" cellspacing="1" cellpadding="0" style="width:380px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">添加员工信息</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->

<table class="tableEdit" style="width:380px;" cellspacing="0" border="0" cellpadding="3">
	<tr>
	    <td class="tdEditLabel" >姓名</td>			
		<td class="tdEditContent"><input class="inputinfo" type="text" 
		name="name"></td>
	</tr>
	<tr>	
		<td class="tdEditLabel" >性别</td>			
		<td class="tdEditContent">
		<select name="sex" class="inputinfo">
		      <option value="男" selected="selected">男</option>
		      <option value="女">女</option>
		       </select> 
		
		</td>
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >用户名</td>			
		<td class="tdEditContent"><input class="inputinfo" type="text" name="username">
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >密码</td>			
		<td class="tdEditContent"><input class="inputinfo" type="password" name="password" value="fnst1234">
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >手机号</td>			
		<td class="tdEditContent"><input class="inputinfo"  type="text" name="telephone">
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >证件号</td>			
		<td class="tdEditContent"><input class="inputinfo" type="text" name="identityNo">
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
				class="MyButton" value="保存员工信息"> 
			<input type="button" class="MyButton"
				value="关闭窗口" onclick="window.close()">
			</TD>
		</TR>
</TABLE>
</form>
</center>
</body>
</html>