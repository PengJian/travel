<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    <title>FNST旅游报名登录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<LINK href="<%=path %>/css/frontLogin.css" type=text/css rel=stylesheet>
	<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script language="javascript" src="<%=path %>/js/md5.js"></script>
<script type="text/javascript">

function validate(){
    var username = $("#TxtUserName").val();
    var password = $("#TxtPassword").val();
    var code = $("#Code").val();
    if(username=="" || password=="" || code==""){
        alert('请填写完整');
        return false;
    }
    var pp = hex_md5(password);
    $("#TxtPassword").val(pp);
}

        
</script>
  </head>
   <span style="position: relative;"><font color="red"><s:actionmessage /></font></span>
  <BODY id=userlogin_body style="text-align:center">
     <DIV></DIV>
      <DIV id=user_login>
      <DL>
       
	  <DD id=user_top>
	 
	  <UL>
	    <LI class=user_top_l>
	     
	    </LI>
	    <LI class=user_top_c></LI>
	    <LI class=user_top_r></LI></UL>
	  <DD id=user_main>
	    
      <UL>
	    <LI class=user_main_l>
	   
	    </LI>
	    <LI class=user_main_c>
	     
	    <form action="<%=path %>/front/login.action" method="post" onsubmit="return validate();">     
	    <DIV class=user_main_box>
	      <UL>
	       <LI >  </LI>
	      </UL>
		  <UL>
		      <LI class=user_main_text>用户名： </LI>
		      <LI class=user_main_input><INPUT class=TxtUserNameCssClass id="TxtUserName" maxLength=20 name="username"> 
		      </LI></UL>
	      <UL>
		      <LI class=user_main_text>密&nbsp;码： </LI>
		      <LI class=user_main_input><INPUT class=TxtPasswordCssClass id="TxtPassword" 
		      type=password name="password"> </LI></UL>
	      <UL>
		      <LI class=user_main_text>验证码： </LI>
		      <LI class=user_main_input><INPUT class=TxtPasswordCssClass id="Code" 
		      maxLength=20 name="rand"> </LI></UL>
		  <UL>
		      <LI class=user_main_text></LI>
		      <LI class=user_main_text><img src='<%=path %>/authImg.jpg' name='d'/></LI></UL>
		  </DIV></LI>
		      <LI class=user_main_r><INPUT class=IbtnEnterCssClass id=IbtnEnter style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px" 
		               type=image src="<%=path %>/images/login/user_botton.gif" name=IbtnEnter> 
		               </LI></UL>
            <DD id=user_bottom>
         <UL>
         </form>
    <LI class=user_bottom_l></LI>
    <LI class=user_bottom_c><SPAN style="MARGIN-TOP: 40px"></SPAN> </LI>
    <LI class=user_bottom_r></LI></UL></DD></DL></DIV>
    <DIV></DIV>
 
   
</BODY></html>
