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
<title>员工管理</title>

</head>
<BODY bgColor=#dee7ff leftMargin=0 background="" topMargin=0 marginheight="0" marginwidth="0">
<center>
      <TABLE width="778" border=0 cellPadding=0 cellSpacing=0 borderColor=#ffffff bgColor=#dee7ff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR height=35>
            <TD align=middle width=20 background=../images/title_left.gif 
          bgColor=#dee7ff></TD>
            <TD align=middle width=120 background=../images/title_left.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7> 员工管理<font color="#FFFFFF">&nbsp;</font></FONT> </TD>
            <TD align=middle width=11 background=../images/title_middle.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
            <TD align=middle background=../images/title_right.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
          </TR>
        </TBODY>
      </TABLE>
      <TABLE width="778" style="border:solid 1px #abcabc;" align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD width="90%" style="margin-left:10px;padding-top:20px" height=14 align=left vAlign=center>
            	<!-- 在这里插入查询表单 -->
            	<form action="<%=path %>/back/selectEmployee.action" method="post">
            	  用户名：<input type="text" name="str1" value="${str1}">&nbsp;
            	 姓名：<input type="text" name="str2" value="${str2}">&nbsp;
            	 &nbsp;&nbsp;<input type="submit" value="查询">
            	</form>
            </TD>
            <TD height=14 align="right" vAlign=center noWrap>
            <% 
            /**
            * 在这里定义“添加”，“查询”等按钮
            * <input type="image" name="find" value="find" src="images/cz.gif">
            * &nbsp;&nbsp;&nbsp;&nbsp; 
            * <a href="#" onClick="BeginOut('document.do?method=addInput','470')">
            * <img src="images/addpic.gif" border=0 align=absMiddle style="CURSOR: hand"></a>
            */
            %>
            
            <a href="#" onclick="openWin('<%=path%>/back/toImportEmployee.action','ImportEmployee',400,200);">导入</a> &nbsp;&nbsp;
            <a href="<%=path%>/back/exportEmployee.action">导出</a> &nbsp;&nbsp;
            <a href="#" onclick="openWin('<%=path%>/back/addInputEmployee.action','addperson',400,250);">添加人员信息</a>
            
            </TD>
          </TR>
          <TR>
            <TD height=28 colspan="2" align=right vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
            </TD>
          </TR>
        </TBODY>
      </TABLE>
      <table width="778" border="0" cellPadding="0" cellSpacing="1" bgcolor="#6386d6">
          <!-- 列表标题栏 -->
	      <tr bgcolor="#EFF3F7" class="TableBody1">
		      <td width="5%" height="37" align="center"><b>序号</b></td>
		      <td width="12%" height="37" align="center"><B>用户名</B></td>
		      <td width="12%" height="37" align="center"><B>姓名</B></td>
		      <td width="10%" height="37" align="center"><b>性别</b></td>
              <td width="18%" height="37" align="center"><b>电话</b></td>
              <td width="18%" height="37" align="center"><b>身份证号</b></td>
              <td width="20%" height="37" align="center"><b>操作</b></td>
          </tr>
          <!-- 列表数据栏 -->
          <c:if test="${!empty pm.datas}">
          <c:forEach items="${pm.datas }" var="employeee" varStatus="status">
	      <tr bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">${status.count }</td>
		      <td align="center" vAlign="center">${employeee.username }</td>
	          <td align="center" vAlign="center">${employeee.name }</td>
	          <td align="center" vAlign="center">${employeee.sex }</td>
	          <td align="center" vAlign="center">${employeee.telephone }</td>
	          <td align="center" vAlign="center">${employeee.identityNo}</td>
	          <td align="center" vAlign="center">
	           <a href="#" onclick="openWin('<%=path%>/back/updateInputEmployee.action?id=${employeee.id}','updateEmp',400,240);">更新</a>
	           
	          <a href="#" onclick="del('<%=path%>/back/delEmployee.action?id=${employeee.id }');">删除</a>
	          <a href="#" onclick="reset('<%=path%>/back/resetPasswordEmployee.action?id=${employeee.id }');">重置密码</a>
	          
	          </td>
        </tr>
        </c:forEach>
		</c:if>
        <!-- 在列表数据为空的时候，要显示的提示信息 -->
	    <c:if test="${empty pm.datas}">
	    <tr>
	    	<td colspan="7" align="center" bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
	    	没有找到相应的记录
	    	</td>
	    </tr>
	    </c:if>
      </table>
      <TABLE width="778" border=0 align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD height=28 align=right vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
   <pg:pager url="../back/listEmployee.action" items="${pm.total}"  maxPageItems="${pageSize}"  export="currentPageNumber=pageNumber">

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
