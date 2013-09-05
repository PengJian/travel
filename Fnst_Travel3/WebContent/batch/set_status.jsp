<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<base target="_self"> 
<head>
<%
  String path = request.getContextPath();  
%>
  <c:if test="${empty manager}">
   <%
      response.sendRedirect(path + "/back/login.jsp");
   %>
</c:if>
<tx:head parseContent="true"/> 
<link href="../style/oa.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/jquery-1.5.2.js"></script>
<script type="text/javascript">
function setStatus(object,flag)
{         
		  var id = $("#IdFlag").val(); 
		  var onOrOff;
		  if(object.checked){
		   onOrOff = 1;
		  }
		  else{
		   onOrOff = 0;
		  }
		  $.post("<%=path%>/back/setStatusBatch.action",
			     {'id':id,'flag':flag,'onOrOff':onOrOff},
			     function(returnData,status)
			     {
			    	if("success"==status)
			    	{
			    		alert('设置成功');
			    		reload.click();
			    	}
			    });
}

function closewindow(){
	if(window){
		window.returnValue='refresh';
		window.close();
	}
}
</script>
<title>设置批次状态</title>


</head>
   <a id="reload" href="<%=path%>/back/toSetBatch.action?id=${batch.id}" style="display:none"></a>
<body>
<center>
<form >
<input type="hidden" id="IdFlag" value="${batch.id}">
<TABLE class="tableEdit" border="0" cellspacing="1" cellpadding="0" style="width:150px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">设置批次【${batch.name}】的状态</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->

<table class="tableEdit" style="width:150px;" cellspacing="2"  border="2" cellpadding="2">
	<tr>
	    <c:if test="${my:ifCanOpen(batch.id)}">
               <td class="tdEditLabel" ><input onclick="setStatus(this,1)" type="checkbox" <c:if test="${batch.internalStatus == 1}"> checked="checked" </c:if> >开启境内线</td> 
        </c:if>	 
		<c:if test="${!my:ifCanOpen(batch.id)}">
		  <c:if test="${batch.internalStatus == 1 }">
               <td class="tdEditLabel" ><input type="checkbox" onclick="setStatus(this,1)" <c:if test="${batch.internalStatus == 1}"> checked="checked" </c:if> >开启境内线</td>
          </c:if>
           <c:if test="${batch.internalStatus == 0 }">
               <td class="tdEditLabel" ><input disabled="disabled" type="checkbox" >开启境内线</td>
          </c:if>	 
        </c:if>					
	</tr>
	
	<tr>
	 <c:if test="${my:ifCanOpen(batch.id)}">
              <td class="tdEditLabel" ><input onclick="setStatus(this,2)" type="checkbox" <c:if test="${batch.abroadStatus == 1}"> checked="checked" </c:if> >开启境外线</td> 
      </c:if>
      
      <c:if test="${!my:ifCanOpen(batch.id)}">
            <c:if test="${batch.abroadStatus == 1 }">
              <td class="tdEditLabel" ><input type="checkbox" onclick="setStatus(this,2)" <c:if test="${batch.abroadStatus == 1}"> checked="checked" </c:if> >开启境外线</td>
            </c:if> 
            <c:if test="${batch.abroadStatus == 0 }">
              <td class="tdEditLabel" ><input disabled="disabled" type="checkbox" >开启境外线</td>
            </c:if> 
      </c:if>	
	   
	</tr>
	
	<tr>
	   	<td class="tdEditLabel" ><input onclick="setStatus(this,3)" type="checkbox" <c:if test="${batch.status == 1}"> checked="checked" </c:if>>归档入库</td>
	</tr>
	
</table>

			<!-- 主输入域结束 -->
			</td>
		</TR>
	</TBODY>
</TABLE>

<TABLE>
		<TR align="center">
			<TD colspan="3" bgcolor="#EFF3F7">
			<input type="button" class="MyButton"
				value="关闭窗口" onclick="closewindow();">
			</TD>
		</TR>
</TABLE>
</form>
</center>
</body>
</html>