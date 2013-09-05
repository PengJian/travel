<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
  <%@include file="/common/common.jsp" %>
     <%
       String path = request.getContextPath();
    %>
    <c:if test="${empty manager}">
   <%
      response.sendRedirect(path + "/back/login.jsp");
   %>
   </c:if>
<html>
<head>
<title>旅游后台管理</title>
</head>
<div style="align:center;width:800px" >
  <FRAMESET  cols = "180,*" name="ALL" frameborder=yes bordercolor=silver>
     <FRAME SRC="left_menu.jsp" NAME="Links" SCROLLING= "No">
     <FRAME SRC="main.jsp" NAME="main" SCROLLING="AUTO">
  </FRAMESET>
</div>
<NOFRAMES>
<BODY>
</BODY>

</NOFRAMES>
</html>