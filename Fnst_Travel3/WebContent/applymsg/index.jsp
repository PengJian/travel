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
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript">
  function reLoadRoute()
  {
	  var flag = $("#routeFlag option:selected").val();
	  $.post("<%=path%>/back/getRouteListEmployeeRoute.action",
			     {'flag':flag},
			     function(returnData,status)
			     {
			    	if("success"==status)
			    	{
			    		var str= "<option value='0'>--选择线路--</option>";
			    		for(var i=0;i<returnData.length;i++){
			    			str = str + "<option value='"+returnData[i].id;
			    			str = str +" '>"+returnData[i].name+"</option>";
			    		}
			    		$('#routeID').html(str);
			    	}
			    });

  }
</script>
<title>报名信息查询</title>

</head>
<BODY bgColor=#dee7ff leftMargin=0 background="" topMargin=0 marginheight="0" marginwidth="0">
<center>
      <TABLE width="1000" border=0 cellPadding=0 cellSpacing=0 borderColor=#ffffff bgColor=#dee7ff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR height=35>
            <TD align=middle width=20 background=../images/title_left.gif 
          bgColor=#dee7ff></TD>
            <TD align=middle width=120 background=../images/title_left.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>报名信息查询<font color="#FFFFFF">&nbsp;</font></FONT> </TD>
            <TD align=middle width=11 background=../images/title_middle.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
            <TD align=middle background=../images/title_right.gif 
          bgColor=#dee7ff><FONT color=#f7f7f7>&nbsp;</FONT> </TD>
          </TR>
        </TBODY>
      </TABLE>
      <TABLE width="1000" style="border:solid 1px #abcabc;" align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD style="margin-bottom:10px" width="90%" height=14 align=right vAlign=center noWrap>
            </TD>
            <TD width="10%" align=right vAlign=center noWrap>　</TD>
          </TR>
          <TR>
            <TD height=14 align=left vAlign=center noWrap>
            	<form style="margin-left:10px" action="<%=path %>/back/selectActiveEmployeeRoute.action" method="post">
            	境外/内线：<select name="flag" id="routeFlag" onchange="reLoadRoute()">
            	            <option value="-1">--选择境内/外线--</option>
            	            <option value="1" <c:if test="${flag == 1}">selected="selected"</c:if>>境外线</option>
            	            <option value="0" <c:if test="${flag == 0}">selected="selected"</c:if>>境内线</option>
            	         </select>
            	旅游线路：<select name="id" id="routeID">
            	          <option value="0">--选择线路--</option>
            	          <c:forEach items="${routes}" var="route">
            	             <option value="${route.id}" <c:if test="${route.id == id}">selected="selected"</c:if>>${route.name}</option>
            	          </c:forEach>
                       	</select> &nbsp;&nbsp;
            	        
            	 员工工号：<input name="str1" value="${str1}" type="text">&nbsp;&nbsp;员工姓名：<input value="${str2}" name="str2" type="text">
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
            </TD>
          </TR>
          <TR>
            <TD height=28 colspan="2" align=right vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
                                 员工总计：<b>${sub}</b> &nbsp;&nbsp; 家属总计：<b>${total-sub}</b> &nbsp;&nbsp; 人数总计：<b>${total}</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <a href="<%=path%>/back/exportEmployeeRoute.action?id=${id}&flag=${flag}"><b>导出</b></a> &nbsp;&nbsp;
            </TD>
          </TR>
        </TBODY>
      </TABLE>
      <table width="1000" border="0" cellPadding="0" cellSpacing="1" bgcolor="#6386d6">
          <!-- 列表标题栏 -->
	      <tr bgcolor="#EFF3F7" class="TableBody1">
	      <td width="10%" height="37" align="center"><b>编号</b></td>
	      <td width="10%" height="37" align="center"><b>线路名</b></td>
	      <td width="7%" height="37" align="center"><b>姓名</b></td>
	      <td width="6%" height="37" align="center"><b>工号</b></td>
		  <td width="2%" height="37" align="center"><B>人数</B></td>
		  <td width="20%" height="37" align="center"><B>报名时间</B></td>
		  <td width="30%" height="37" align="center"><B>家属信息(关系-姓名-性别-证件号-备注)</B></td>
		  <td width="15%" height="37" align="center"><B>操作</B></td>
          </tr>
       
          <!-- 列表数据栏 -->
         <c:if test="${!empty datas}">
          <c:forEach items="${datas }" var="item" varStatus="status">
	      <tr bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">${status.count }</td>
		      <td align="center" vAlign="center">${item.data.travelRoute.name }</td>
		      <td align="center" vAlign="center">${item.data.employee.name }</td>
	          <td align="center" vAlign="center">${item.data.employee.username }</td>
	          <td align="center" vAlign="center">${item.data.participants}</td>
	            <td align="center" vAlign="center">${item.data.date }</td>
	          <td align="left" vAlign="center">
	          
	              <c:forEach items="${item.families }" var="item2">
	                 <c:if test="${item2.isTravel == 1 }">
	                 <b> ${item2.relation}-${item2.name}-${item2.sex}-${item2.identityNo}-${item2.remarks}</b><br>
	                 </c:if>
	              </c:forEach>
	          </td>
	        
	            <td align="center" vAlign="center"><!--
	           <a href="<%=path%>/back/findDetailEmployeeRoute.action?id=${item.data.id}" disabled="disabled" target="main">详情</a>
	           
	          <a href="<%=path%>/back/updateEmployeeRoute.action?id=${item.data.id }" target="main">修改</a>-->
	          <a href="#" onclick="del('<%=path%>/back/delEmployeeRoute.action?id=${item.data.id }');">删除</a>
	          
	          </td>
        </tr>
        </c:forEach>
		</c:if>
        <!-- 在列表数据为空的时候，要显示的提示信息 -->
	    <c:if test="${empty datas}">
	    <tr>
	     <td colspan="8" align="center" bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
	    	没有找到相应的记录
	    	</td>
	  
	    <!--<td width="3%" height="37" align="center">1</td>
	      <td height="37" align="center">台湾</td>
	      <td  height="37" align="center">李爱武</td>
	      <td height="37" align="center">014001</td>
		  <td  height="37" align="center">3</td>
		  <td height="37" align="center">430581198808123559</td>
		  <td>
		   <a href="<%=path%>/back/findActiveEmployeeRoute.action?id=${item.id}" target="main">详情</a>
	            &nbsp;&nbsp;
	          <a href="<%=path%>/back/updateEmployeeRoute.action?id=${item.id }" target="main">修改</a>
	           &nbsp;&nbsp;
	          <a href="#" onclick="del('<%=path%>/back/delEmployeeRoute.action?id=${item.id }');">删除</a>
	      </td>
	    </tr>
	    
	    <tr>
	  <td width="3%" height="37" align="center">2</td>
	      <td height="37" align="center">台湾</td>
	      <td  height="37" align="center">李爱武</td>
	      <td height="37" align="center">014001</td>
		  <td  height="37" align="center">3</td>
		  <td height="37" align="center">430581198808123559</td>
		  <td>
		   <a href="<%=path%>/back/findActiveEmployeeRoute.action?id=${item.id}" target="main">详情</a>
	            &nbsp;&nbsp;
	          <a href="<%=path%>/back/updateEmployeeRoute.action?id=${item.id }" target="main">修改</a>
	           &nbsp;&nbsp;
	          <a href="#" onclick="del('<%=path%>/back/delEmployeeRoute.action?id=${item.id }');">删除</a>
	      </td>
	    </tr>
	    -->
	    </c:if>
      </table>
      <TABLE width="1000" border=0 align=center cellPadding=0 cellSpacing=0 borderColor=#ffffff style="FONT-SIZE: 10pt">
        <TBODY>
          <TR>
            <TD height=28 align=right vAlign=center noWrap background=../images/list_middle.jpg>&nbsp;&nbsp;
            <!-- 可以在这里插入分页导航条 
   <pg:pager url="../back/searchRoute.action" items="${pm.total}"  maxPageItems="${pageSize}"  export="currentPageNumber=pageNumber">
   <pg:param name="str1" value="${str1}"/>
   <pg:param name="str2" value="${str2}"/>
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

    		--></TD>
          </TR>
        </TBODY>
      </TABLE>
</center>

</body>

</html>
