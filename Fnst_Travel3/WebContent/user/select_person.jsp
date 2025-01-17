<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
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
<link href="../style/oa.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/public.js"></script>
<title>请选择业务员</title>
<script type="text/javascript">
function selectPerson(oid,oname,v1,v2,v3,v4){
	if(window.opener){
		window.opener.document.getElementById('PersonIdId').value = oid;
		window.opener.document.getElementById('PersonNameId').value = oname;
	    window.opener.document.getElementById('ContactPhoneId').value = "";
	    window.opener.document.getElementById('ContactOrgId').value = "";
	    window.opener.document.getElementById('ContactAddrId').value = "";
	    window.opener.document.getElementById('ContactRemarkId').value = "";
		if(v1)
		   window.opener.document.getElementById('ContactPhoneId').value = v1;
		if(v2)
		   window.opener.document.getElementById('ContactOrgId').value = v2;
		if(v3)
		   window.opener.document.getElementById('ContactAddrId').value = v3;
		if(v4)
		   window.opener.document.getElementById('ContactRemarkId').value = v4;
		window.close();
	}
}
</script>
</head>
<body>
<center>
<TABLE class="tableEdit" border="0" cellspacing="1" cellpadding="0" style="width:580px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">请选择业务员</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->
      <TABLE width="778" border=0 align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD width="82%" height=14 align=right vAlign=center noWrap>
            </TD>
            <TD width="18%" align=right vAlign=center noWrap>　</TD>
          </TR>
          <TR>
            <TD height=14 align=right vAlign=center noWrap><!-- 在这里插入查询表单 -->
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
            <TD height=28 colspan="2" align=right vAlign=center noWrap background=images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 -->
            </TD>
          </TR>
        </TBODY>
      </TABLE>
      <table width="100%" border="0" cellPadding="0" cellSpacing="1" bgcolor="#6386d6">
          <!-- 列表标题栏 -->
	      <tr bgcolor="#EFF3F7" class="TableBody1">
		      <td width="20%" height="37" align="center"><b>选择</b></td>
		      <td width="40%" height="37" align="center"><B>业务员姓名</B></td>
		      <td width="40%" height="37" align="center"><b>所属部门</b></td>
		      
          </tr>
          <!-- 列表数据栏 -->
          
          <c:if test="${!empty pm.datas}">
          <c:forEach items="${pm.datas }" var="person">
	      <tr bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">
		      <input type="radio" name="orgid" onclick="selectPerson('${person.id}','${person.name}','${person.phone}','${person.org.name}','${person.address}','${person.description}')">
		      </td>
	          <td align="center" vAlign="center">${person.name }</td>
	          <td align="center" vAlign="center">${person.org.name}</td>
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
    <pg:pager url="person.action" items="${pm.total}" maxPageItems="${pageSize}" export="currentPageNumber=pageNumber">
	<pg:param name="select" value="true"/>
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

			<!-- 主输入域结束 -->
			</td>
		</TR>
	</TBODY>
</TABLE>

</center>
</body>
</html>