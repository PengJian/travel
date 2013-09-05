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
<title>批次管理</title>

</head>
<BODY bgColor=#dee7ff leftMargin=0 background="" topMargin=0 marginheight="0" marginwidth="0">
<center>
      <TABLE  width="880"  cellPadding=0 cellSpacing=0 borderColor=#ffffff bgColor=#dee7ff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR height=35>
            <TD align=middle width=20 background=../images/title_left.gif 
          bgColor=#dee7ff></TD>
            <TD align=middle width=120 background=../images/title_left.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7> 批次管理<font color="#FFFFFF">&nbsp;</font></FONT> </TD>
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
            <TD style="margin-bottom:10px" width="90%" height=14 align=left vAlign=center noWrap>
            <c:if test="${my:ifCanAdd()}">
               <a href="#" style="margin-left:10px"  onclick="openWin('<%=path%>/back/addInputBatch.action','addperson',600,400);">添加批次</a> 
            </c:if>
            <c:if test="${!my:ifCanAdd()}">
               <span style="margin-left:10px">添加批次</span> 
            </c:if>
            </TD>
            <TD width="10%" align=right vAlign=center noWrap>　</TD>
          </TR>
          <TR>
            <TD height=14 align=left >
            	<!-- 在这里插入查询表单 -->
            	<form style="margin-left:10px" action="<%=path %>/back/selectBatch.action" method="post">
            	 年份：<input name="str1" value="${str1}" type="text">&nbsp;&nbsp;批次号：<input value="${str2}" name="str2" type="text">
            	 &nbsp;&nbsp;批次名：<input value="${str3}" name="str3" type="text">
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
	      <td width="6%" height="37" align="center"><b>编号</b></td>
	       <td width="8%" height="37" align="center"><b>名称</b></td>
	      <td width="10%" height="37" align="center"><b>开始日期</b></td>
	      <td width="10%" height="37" align="center"><b>结束日期</b></td>
	      <td width="10%" height="37" align="center"><b>补贴金额</b></td>
		  <td width="6%" height="37" align="center"><b>关联批次</b></td>
		  <td width="10%" height="37" align="center"><b>线路设定</b></td>
		  <td width="9%" height="37" align="center"><B>活动状态</B></td>
		  <td width="8%" height="37" align="center"><B>国内线</B></td>
		  <td width="8%" height="37" align="center"><B>国外线</B></td>
		  <td width="15%" height="37" align="center"><B>操作</B></td>
          </tr>
          <!-- 列表数据栏 -->
          <c:if test="${!empty pm.datas}">
          <c:forEach items="${pm.datas }" var="batch">
	      <tr bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">${batch.batchNo }</td>
		      <td align="center" vAlign="center">${batch.name }</td>
	          <td align="center" vAlign="center">${batch.startDate }</td>
	          <td align="center" vAlign="center">${batch.endDate }</td>
	          <td align="center" vAlign="center">${batch.subsidy }</td>
	          <td align="center" vAlign="center">
	             <c:if test="${batch.relationBatch == ''}">无</c:if>
	             <c:if test="${batch.relationBatch != ''}">${batch.relationBatch}</c:if>
	          </td>
	          
	          <td align="center" vAlign="center">
	          <c:if test="${my:ifCanEdit(batch.id)}">
                 <a href="<%=path%>/back/setOneBatch.action?id=${batch.id}">设定</a>
              </c:if>
	          <c:if test="${!my:ifCanEdit(batch.id)}">
                <span>设定</span>
              </c:if> 
	          
	          </td>
	          <td align="center" vAlign="center">
	             <c:if test="${batch.status == 0}">激活</c:if>
	             <c:if test="${batch.status == 1}">归档</c:if>
	         </td>
	          <td align="center" vAlign="center"> 
	            <c:if test="${batch.internalStatus  == 0}">停止</c:if>
	             <c:if test="${batch.internalStatus == 1}">启动</c:if>
	           </td>
	         
	          <td align="center" vAlign="center"> 
	            <c:if test="${batch.abroadStatus == 0}">停止</c:if>
	             <c:if test="${batch.abroadStatus == 1}">启动</c:if>
	           </td>
	          <td align="center" vAlign="center">
	          
	          <c:if test="${my:ifCanEdit(batch.id)}">
               <a href="#" onclick="openWin('<%=path%>/back/updateInputBatch.action?id=${batch.id}','addperson',600,400);">更新</a>
              </c:if>
	          <c:if test="${!my:ifCanEdit(batch.id)}">
               <span>更新</span>
              </c:if> 
	          
	           <c:if test="${my:ifCanDel(batch.id)}">
                  <a href="#" onclick="del('<%=path%>/back/delBatch.action?id=${batch.id }');">删除</a>
              </c:if>
	           
	           <c:if test="${!my:ifCanDel(batch.id)}">
                 <span>删除</span>
              </c:if>
             
	           <a href="#" onclick="openWin('<%=path%>/back/toSetBatch.action?id=${batch.id}','updateEmp',200,200);">状态设置</a>
	          </td>
        </tr>
        </c:forEach>
		</c:if>
        <!-- 在列表数据为空的时候，要显示的提示信息 -->
	    <c:if test="${empty pm.datas}">
	    <tr>
	    	<td colspan="11" align="center" bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
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
   <pg:pager url="../back/listBatch.action" items="${pm.total}"  maxPageItems="${pageSize}"  export="currentPageNumber=pageNumber">

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
