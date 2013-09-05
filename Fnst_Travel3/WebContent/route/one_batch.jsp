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
<title>${batch.name}</title>

</head>
<BODY bgColor=#dee7ff leftMargin=0 background="" topMargin=0 marginheight="0" marginwidth="0">
<center>
      <TABLE width="880" border=0 cellPadding=0 cellSpacing=0 borderColor=#ffffff bgColor=#dee7ff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR height=35>
            <TD align=middle width=20 background=../images/title_left.gif 
          bgColor=#dee7ff></TD>
            <TD align=middle width=150 background=../images/title_left.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>批次【${batch.name}】<font color="#FFFFFF">&nbsp;</font></FONT> </TD>
            <TD align=middle width=11 background=../images/title_middle.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
            <TD align=middle background=../images/title_right.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
          </TR>
        </TBODY>
      </TABLE>
      <br>
      <TABLE width="880" style="border:solid 1px #abcabc;" align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD width="90%" style="margin-bottom:10px" height=14 align=left vAlign=center noWrap>
            <c:if test="${my:ifCanEdit(batch.id)}">
               <a href="#" style="margin-left:10px" onclick="openWin('<%=path%>/back/addInputRoute.action?batchId=${batch.id}','addperson',600,400);">添加旅游线路</a> 
            </c:if>
            <c:if test="${!my:ifCanEdit(batch.id)}">
               <span style="margin-left:10px">添加旅游线路</span> 
            </c:if>   
            </TD>
            <TD width="10%" align=left vAlign=center noWrap>　</TD>
          </TR>
          <TR>
            <TD height=14 align=left vAlign=center noWrap>
            	<form style="margin-left:10px" action="<%=path %>/back/selectRoute.action" method="post">
            	<input type="hidden" value="${batch.id}" name="batchId">
            	 线路编号：<input name="str1" value="${str1}" type="text">&nbsp;&nbsp;旅游批次名称：<input value="${str2}" name="str2" type="text">
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
         
        </TBODY>
      </TABLE>

      <br/>
      <div><h3>【${batch.name}】境内线</h3></div>
      <table width="880" border="0" cellPadding="0" cellSpacing="1" bgcolor="#6386d6">
       <TR>
            <TD height=28 colspan="8" align=right  vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
            </TD>
          </TR>
          <!-- 列表标题栏 -->
	      <tr bgcolor="#EFF3F7" class="TableBody1">
	      <td width="10%" height="37" align="center"><b>编号</b></td>
	      <td width="10%" height="37" align="center"><b>名称</b></td>
	      <td width="10%" height="37" align="center"><b>开始日期</b></td>
	      <td width="10%" height="37" align="center"><b>结束日期</b></td>
	      <td width="10%" height="37" align="center"><b>线路价格</b></td>
		  <td width="20%" height="37" align="center"><b>旅游线路信息</b></td>
		  <td width="10%" height="37" align="center"><B>上线人数</B></td>
		  <td width="20%" height="37" align="center"><B>操作</B></td>
          </tr>
          <!-- 列表数据栏 -->
          <c:if test="${!empty datas1}">
          <c:forEach items="${datas1 }" var="route1">
	      <tr bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">${route1.routeNo }</td>
		       <td align="center" vAlign="center">${route1.name }</td>
	          <td align="center" vAlign="center">${route1.startDate }</td>
	          <td align="center" vAlign="center">${route1.endDate }</td>
	          <td align="center" vAlign="center">${route1.price }</td>
	          <td align="center" vAlign="center">${route1.description}</td>
	          <td align="center" vAlign="center">${route1.maxAmount}</td>
	          <td align="center" vAlign="center">
	           <a href="#" onclick="openWin('<%=path%>/back/updateInputRoute.action?id=${route1.id}','addperson',600,400);">更新</a>
	           <a href="#" onclick="del('<%=path%>/back/delRoute.action?id=${route1.id }');">删除</a>
	          </td>
        </tr>
        </c:forEach>
		</c:if>
        <!-- 在列表数据为空的时候，要显示的提示信息 -->
	    <c:if test="${empty datas1}">
	    <tr>
	    	<td colspan="9" align="center" bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
	    	没有找到相应的记录
	    	</td>
	    </tr>
	    </c:if>
	  <TR>
            <TD height=28 colspan="8" align=right  vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
            </TD>
          </TR>
      </table>
      
      <br>
      <br>
      <div><h3>【${batch.name}】境外线</h3></div>
      <table width="880" border="0" cellPadding="0" cellSpacing="1" bgcolor="#6386d6">
      <TR>
            <TD height=28 colspan="8" align=right  vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
            </TD>
          </TR>
          <!-- 列表标题栏 -->
	      <tr bgcolor="#EFF3F7" class="TableBody1">
	      <td width="10%" height="37" align="center"><b>编号</b></td>
	      <td width="10%" height="37" align="center"><b>名称</b></td>
	      <td width="10%" height="37" align="center"><b>开始日期</b></td>
	      <td width="10%" height="37" align="center"><b>结束日期</b></td>
	      <td width="10%" height="37" align="center"><b>线路价格</b></td>
		  <td width="20%" height="37" align="center"><b>旅游线路信息</b></td>
		  <td width="10%" height="37" align="center"><B>上线人数</B></td>
		  <td width="20%" height="37" align="center"><B>操作</B></td>
          </tr>
          <!-- 列表数据栏 -->
          <c:if test="${!empty datas2}">
          <c:forEach items="${datas2 }" var="route2">
	      <tr bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">${route2.routeNo }</td>
		       <td align="center" vAlign="center">${route2.name }</td>
	          <td align="center" vAlign="center">${route2.startDate }</td>
	          <td align="center" vAlign="center">${route2.endDate }</td>
	          <td align="center" vAlign="center">${route2.price }</td>
	          <td align="center" vAlign="center">${route2.description}</td>
	          <td align="center" vAlign="center">${route2.maxAmount}</td>
	          <td align="center" vAlign="center">
	           <a href="#" onclick="openWin('<%=path%>/back/updateInputRoute.action?id=${route2.id}','addperson',600,400);">更新</a>
	           <a href="#" onclick="del('<%=path%>/back/delRoute.action?id=${route2.id }');">删除</a>
	          </td>
        </tr>
        </c:forEach>
		</c:if>
        <!-- 在列表数据为空的时候，要显示的提示信息 -->
	    <c:if test="${empty datas2}">
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
    		</TD>
          </TR>
        </TBODY>
      </TABLE>
</center>

</body>

</html>
