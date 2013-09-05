<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@include file="/common/common.jsp" %>
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
<script type="text/javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript" src="<%=path %>/applymsg/js/jquery-calendar.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path %>/back/css/jquery-calendar.css" />


<title>报名时间设定</title>

</head>

	<script type="text/javascript">
   function ajaxupload()
   { $.blockUI({message:"<img src='imgs/loading.gif'/>"});
   }
  </script>
	<script type="text/javascript">
		 
			$(document).ready(function (){ 
				$("#startTime, #endTime").calendar();
			});
	
			function setTime()
			{
				var startTime = $("#startTime").val();
				var endTime = $("#endTime").val();
				if(startTime==""){
					alert('开始时间不能为空');
					return;
				}
				if(endTime==""){
					alert('结束时间不能为空');
					return;
				}
				
				$.post("<%=path%>/back/setApplyTime.action",
					     {'startTime':startTime,'endTime':endTime},
					     function(returnData,status)
					     {
					    	if("success"==status)
					    	{
					    		alert(returnData);
					    	}
				 });		
			}
	</script>
	<body>
<BODY bgColor=#dee7ff leftMargin=0 background="" topMargin=0 marginheight="0" marginwidth="0">
<center>
      <TABLE width="800" border=0 cellPadding=0 cellSpacing=0 borderColor=#ffffff bgColor=#dee7ff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR height=35>
            <TD align=middle width=20 background=../images/title_left.gif 
          bgColor=#dee7ff></TD>
            <TD align=middle width=120 background=../images/title_left.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>报名时间设定<font color="#FFFFFF">&nbsp;</font></FONT> </TD>
            <TD align=middle width=11 background=../images/title_middle.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
            <TD align=middle background=../images/title_right.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
          </TR>
        </TBODY>
      </TABLE>
      <TABLE width="800" style="border:solid 1px #abcabc;" align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD style="margin-bottom:10px" width="90%" height=14 align=right vAlign=center noWrap>
            </TD>
            <TD width="10%" align=right vAlign=center noWrap>　</TD>
          </TR>
          <TR>
            <TD height=14 align=left vAlign=center noWrap>
            	<form style="margin-left:10px" method="post">
            	开始时间：<input type="text" readonly="readonly" id="startTime" name="startTime" value="${startTime}" class="calendarFocus" />
            	 &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结束时间：<input readonly="readonly" type="text" value="${endTime}" id="endTime" name="endTime" class="calendarFocus" />
            	 &nbsp;&nbsp;<input type="button" onclick="setTime()" value="设定">
            	</form>
            </TD>
          </TR>
          <TR>
            <TD height=28 colspan="2" align=right vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
            </TD>
          </TR>
        </TBODY>
      </TABLE>
</center>

</body>

</html>
