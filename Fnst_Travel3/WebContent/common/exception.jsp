<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@taglib prefix="s" uri="/struts-tags"%>
 <%
    String path = request.getContextPath();
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=path %>/style/style.css" /> 
<title>操作错误</title>
</head>
<body>
操作错误！<br>
<b><s:property value="exception.message"/></b><a href="javascript:history.go(-1)">返回</a>
</body>
</html>