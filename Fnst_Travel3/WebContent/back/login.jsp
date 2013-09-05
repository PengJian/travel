<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@include file="/common/common.jsp" %>
    <%
       String path = request.getContextPath();
    %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<LINK href="<%=path %>/style/login.css" type=text/css rel=stylesheet>
<title>FNST旅游管理系统</title>
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script language="javascript" src="<%=path %>/js/md5.js"></script>
<script type="text/javascript">
function validate(){
	var username = $("#username").val();
	var password = $("#password").val();
	if(username=="" || password==""){
        alert('请填写完整');
        return false;
    }
	var pp = hex_md5(password);
	$("#password").val(pp);
}
</script>
</head>
<body>
<BODY class=PageBody leftMargin=0 topMargin=0 MARGINHEIGHT="0" 
MARGINWIDTH="0">
<CENTER>
<form action="<%=path %>/back/login.action" method="post" onsubmit="return validate();">
<TABLE height="100%" cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR>
    <TD></TD></TR>
  <TR>
    <TD>
      <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR class=UpTr height=20>
          <TD></TD>
          <TD></TD> 
          <TD class=VersionTitle align=right>版本:1.0
          </TD></TR>
        <TR class=UpTr height=65>
          <TD width=20></TD>
          <TD colSpan=2><h1 style="color:#baafff">FNST 旅游管理系统</h1></TD></TR>
        <TR height=3>
          <TD background="<%=path %>/images/login/logo_under_line.gif" 
          colSpan=3></TD></TR>
        <TR class=DownTr>
          <TD></TD>
          <TD>
            <TABLE height=204 cellSpacing=0 cellPadding=0 border=0>
              <TBODY>
              <TR height=50>
                <TD colSpan=3> <font color="red"><s:actionerror/><s:actionmessage/></font> </TD></TR>
              <TR height=18>
                <TD width=290 
                background="<%=path %>/images/login/userLogin.gif" 
                colSpan=3></TD></TR>
              <TR>
                <TD class=LoginLine width=2></TD>
                <TD width=286>
                  <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" 
                  border=0>
                    <TBODY>
                    <TR height=10>
                      <TD colSpan=6></TD></TR>
                    <TR>
                      <TD class=ItemTitleFont align=right width=80 
                        height=25>用户名：</TD>
                      <TD width=100><INPUT class=inputFrm name=username id="username"></TD>
                      <TD align=middle rowSpan=2><input type="image" src="<%=path %>/images/login/userLogin_button.gif" 
                        border=0></TD></TR>
                    <TR>
                      <TD class=ItemTitleFont align=right height=25>密 &nbsp;&nbsp;码：</TD>
                      <TD><INPUT class=inputFrm type=password 
                    name=password id="password"></TD></TR>
                    
                    <TR>
                      <TD></TD>
                      <TD></TD>
                      <TD></TD></TR></TBODY></TABLE></TD>
                <TD class=LoginLine width=2></TD></TR>
              <TR height=11>
                <TD width=290 
                background="<%=path %>/images/login/userLogin_down.gif" 
                colSpan=3></TD></TR></TBODY></TABLE></TD>
          <TD width=228><IMG src="<%=path %>/images/login/logo_bg.gif" 
            border=0></TD></TR>
        <TR class=DownTr height=24>
          <TD></TD>
          <TD class=VersionTitle vAlign=bottom align=right 
          background="<%=path %>/images/login/logo_copyright_bg.gif" 
          colSpan=2><A class=close 
            target=_blank>FNST 旅游开发团队 版权所有</A></TD></TR></TBODY></TABLE></TD></TR>
  <TR height="3%">
    <TD></TD></TR></TBODY></TABLE></form></CENTER></BODY>
</html>