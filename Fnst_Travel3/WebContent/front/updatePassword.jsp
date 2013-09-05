<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
 
<c:if test="${empty temp}">
   <%
      response.sendRedirect(path + "/login.jsp");
   %>
</c:if>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
    <script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript">
function validate()
{
	var password = $("#password").val();
	var password1 = $("#password1").val();
	
	if(password == "")
		{
		   alert('密码不能为空');
		   return false;
		}
	
	if(password.length < 6 || password.length > 8)
		{
		   alert('密码的长度在6到8之间');
		   return false;
		}
	if(password!=password1)
		{
		   alert('密码两次输入不一致');
		   return false;
		}
}
</script>
        <title>密码修改</title>
        <style>
html,body {
    height: 100%;
}

body {
    font: 15px 'Microsoft YaHei', 'Trebuchet MS', Arial, Helvetica;
    margin: 0;
    background-color: #d9dee2;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebeef2),
        to(#d9dee2) );
    background-image: -webkit-linear-gradient(top, #ebeef2, #d9dee2);
    background-image: -moz-linear-gradient(top, #ebeef2, #d9dee2);
    background-image: -ms-linear-gradient(top, #ebeef2, #d9dee2);
    background-image: -o-linear-gradient(top, #ebeef2, #d9dee2);
    background-image: linear-gradient(top, #ebeef2, #d9dee2);
}

/*--------------------*/
#login {
    background-color: #fff;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#fff),
        to(#eee) );
    background-image: -webkit-linear-gradient(top, #fff, #eee);
    background-image: -moz-linear-gradient(top, #fff, #eee);
    background-image: -ms-linear-gradient(top, #fff, #eee);
    background-image: -o-linear-gradient(top, #fff, #eee);
    background-image: linear-gradient(top, #fff, #eee);
    height: 240px;
    width: 400px;
    margin: -150px 0 0 -230px;
    padding: 30px;
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 0;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    border-radius: 3px;
}

#login:before {
    content: '';
    position: absolute;
    z-index: -1;
    border: 1px dashed #ccc;
    top: 5px;
    bottom: 5px;
    left: 5px;
    right: 5px;
    -moz-box-shadow: 0 0 0 1px #fff;
    -webkit-box-shadow: 0 0 0 1px #fff;
    box-shadow: 0 0 0 1px #fff;
}

/*--------------------*/
h1 {
    text-transform: uppercase;
    text-align: center;
    color: #666;
    margin: 0 0 30px 0;
    letter-spacing: 4px;
    font: normal 26px/ 1 Verdana, Helvetica;
    position: relative;
}

/*--------------------*/
fieldset {
    border: 0;
    padding: 0;
    margin: 0;
}

/*--------------------*/
input {
    padding: 15px 15px 15px 30px;
    margin: 0 0 10px 0;
    width: 220px;
    border: 1px solid #ccc;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
}

#username {
    background-position: 5px -2px !important;
}

#password {
    background-position: 5px -52px !important;
}

/*--------------------*/
#actions {
    margin: 25px 0 0 0;
}

#submit {
    background-color: #226DC7;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    border-radius: 3px;
    border-width: 1px;
    border-style: solid;
    float: left;
    height: 35px;
    margin: 0px 0px 0px 30px;
    padding:0;
    width: 120px;
    cursor: pointer;
    font: bold 15px Arial, Helvetica;
    color: white;
}

#submit:hover,#submit:focus {
    background-color: #226DC7;
}

#submit:active {
    outline: none;
    -moz-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.5) inset;
    -webkit-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.5) inset;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.5) inset;
}

#submit::-moz-focus-inner {
    border: none;
}

#actions a {
    color: #3151A2;
    float: right;
    line-height: 35px;
    margin-left: 10px;
}

/*--------------------*/
#back {
    display: block;
    text-align: center;
    position: relative;
    top: 60px;
    color: #999;
}
</style>
  

    </head>

    <body>
        <form id="login" action="<%=path%>/front/updatePwd" method="post" onsubmit="return validate();">
        <input type="hidden" value="${temp}" name="userId">
            <h1>修改密码</h1>
            <table align="center" valign="center">
            <tr> <td>密码：</td> <td><input id="password" name="password" type="password" type="text"></td></tr>
     <tr> <td> 重复密码：</td> <td>          <input id="password1" name="password1" type="password" ></td></tr>
      </table>
            <fieldset id="actions">
                <input type="submit" id="submit"  value="更改密码">
            </fieldset>
        </form>

    </body>
</html>

