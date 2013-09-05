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
<script language="javascript" src="../script/public.js"></script>
<title>旅游线路管理</title>

</head>
<BODY bgColor=#dee7ff leftMargin=0 background="" topMargin=0 marginheight="0" marginwidth="0">
<center>
      <TABLE width="880" border=0 cellPadding=0 cellSpacing=0 borderColor=#ffffff bgColor=#dee7ff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR height=35>
            <TD align=middle width=20 background=../images/title_left.gif 
          bgColor=#dee7ff></TD>
            <TD align=middle width=120 background=../images/title_left.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>旅游线路查询<font color="#FFFFFF">&nbsp;</font></FONT> </TD>
            <TD align=middle width=11 background=../images/title_middle.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
            <TD align=middle background=../images/title_right.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
          </TR>
        </TBODY>
      </TABLE>
      <TABLE width="880" style="border:solid 1px #abcabc;" align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD style="margin-bottom:10px" width="90%" height=14 align=right vAlign=center noWrap>
            </TD>
            <TD width="10%" align=right vAlign=center noWrap>　</TD>
          </TR>
          <TR>
            <TD height=14 align=left vAlign=center noWrap>
            	<form style="margin-left:10px" action="<%=path %>/back/searchRoute.action" method="post">
            	 批次名：<input name="str1" value="${str1}" type="text">&nbsp;&nbsp;线路名：<input value="${str2}" name="str2" type="text">
            	 &nbsp;&nbsp;线路号：<input value="${str3}" name="str3" type="text">
            	 &nbsp;&nbsp;<input type="submit" value="查询">
            	</form>
            </TD>
            <TD height=14 align="left" vAlign=center noWrap>
            <% 
            /**
            * 在这里定义“添加”，“查询”等按钮
            * <input type="image" name="find" value="find" src="images/cz.gif">
            * &nbsp;&nbsp;&nbsp;&nbsp; 
            * <a href="#" onClick="BeginOut('document.do?method=addInput','470')">
            * <img src="images/addpic.gif" border=0 align=absMiddle style="CURSOR: hand"></a>
            */
            %>
            
            </TD>
          </TR>
          <TR>
            <TD height=28 colspan="2" align=right vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
            </TD>
          </TR>
        </TBODY>
      </TABLE>
      <table width="880" border="0" cellPadding="0" cellSpacing="1" bgcolor="#6386d6">
          <!-- 列表标题栏 -->
	      <tr bgcolor="#EFF3F7" class="TableBody1">
	      <td width="10%" height="37" align="center"><b>编号</b></td>
	      <td width="10%" height="37" align="center"><b>名称</b></td>
	      <td width="14%" height="37" align="center"><b>所属批次名称</b></td>
	      <td width="13%" height="37" align="center"><b>开始日期</b></td>
	      <td width="13%" height="37" align="center"><b>结束日期</b></td>
	      <td width="10%" height="37" align="center"><b>线路价格</b></td>
		  <td width="18%" height="37" align="center"><b>旅游线路信息</b></td>
		  <td width="7%" height="37" align="center"><B>上线人数</B></td>
		  <td width="5%" height="37" align="center"><B>详情</B></td>
          </tr>
       
          <!-- 列表数据栏 -->
         <c:if test="${!empty pm.datas}">
          <c:forEach items="${pm.datas }" var="route">
	      <tr bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">${route.routeNo }</td>
		       <td align="center" vAlign="center">${route.name }</td>
		        <td align="center" vAlign="center">${route.travelBatch.name }</td>
	          <td align="center" vAlign="center">${route.startDate }</td>
	          <td align="center" vAlign="center">${route.endDate }</td>
	          <td align="center" vAlign="center">${route.price }</td>
	          <td align="center" vAlign="center">${route.description}</td>
	          <td align="center" vAlign="center">${route.maxAmount}</td>
	          <td align="center" vAlign="center"><a href="#" onclick="openWin('<%=path%>/back/updateInputRouteDetail.action?routeId=${route.id}','addperson',700,400);">详情</a></td>
        </tr>
        </c:forEach>
		</c:if>
        <!-- 在列表数据为空的时候，要显示的提示信息 -->
	    <c:if test="${empty pm.datas}">
	    <tr>
	    	<td colspan="9" align="center" bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
	    	没有找到相应的记录
	    	</td>
	    </tr>
	    </c:if>
      </table>
      <TABLE width="880" border=0 align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD height=28 align=right vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
   <pg:pager url="../back/searchRoute.action" items="${pm.total}"  maxPageItems="${pageSize}"  export="currentPageNumber=pageNumber">
   <pg:param name="str1" value="${str1}"/>
   <pg:param name="str2" value="${str2}"/>
   <pg:param name="str3" value="${str3}"/>
	<pg:first>
		<a href="${pageUrl}">首页</a>
	</pg:first>
	<pg:prev>
	<a href="${pageUrl }">前页</a>
	</pg:prev>
	<pg:pages>
		<c:choose>
			<c:when test="${currentPageNumber eq pageNumber}">
				<font color="red">${pageNumber }</font>
			</c:when>
			<c:otherwise>
				<a href="${pageUrl }">${pageNumber }</a>
			</c:otherwise>
		</c:choose>
	</pg:pages>
	<pg:next>
	<a href="${pageUrl }">后页</a>
	</pg:next>
	<pg:last>
	<a href="${pageUrl }">尾页</a>
	</pg:last>
</pg:pager>

    		</TD>
          </TR>
        </TBODY>
      </TABLE>
</center>

</body>

</html>
