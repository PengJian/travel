<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<base target="_self"/>
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
<script language="javascript" src="../script/public.js"></script>
<script language="javascript" src="../script/jquery-1.5.2.js"></script>
<title>添加线路信息</title>
<script type="text/javascript">

$(function(){	
	var batchId = $("#BatchID").val(); 
	 $.post("<%=path%>/back/generateNoRoute.action",
		     {'batchId':batchId,'isBoard':1},
		     function(returnData,status)
		     {
		    	 if("success"==status)
		          {
			    	    $("#RouteNoId").val(returnData);			    	    
		          }
		     
		     });
	 
	 $.fn.numeral = function () {
	        $(this).css("ime-mode", "disabled");
	        this.bind("keypress", function (e) {
	            var code = (e.keyCode ? e.keyCode : e.which);  //兼容火狐 IE   
	            if (!$.browser.msie && (e.keyCode == 0x8))  //火狐下 不能使用退格键  
	            {
	                return;
	            }
	            return code >= 48 && code <= 57 || code == 46;

	        });
	        this.bind("blur", function () {

	            if (this.value.lastIndexOf(".") == (this.value.length - 1)) {
	                this.value = this.value.substr(0, this.value.length - 1);
	            } else if (isNaN(this.value)) {
	                this.value = " ";
	            } 
	        });
	        this.bind("paste", function () {
	            var s = clipboardData.getData('text');
	            if (!/\D/.test(s));
	            value = s.replace(/^0*/, '');
	            return false;
	        });
	        this.bind("dragenter", function () {
	            return false;
	        });
	        this.bind("keyup", function () {
	            this.value = this.value.replace(/[^\d.]/g, "");
	            //必须保证第一个为数字而不是.
	            this.value = this.value.replace(/^\./g, "");
	            //保证只有出现一个.而没有多个.
	            this.value = this.value.replace(/\.{2,}/g, ".");
	            //保证.只出现一次，而不能出现两次以上
	            this.value = this.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
	        });
	    };
	    
	    $("#priceID").numeral();
	    
	    $("#maxAmountID").keyup(function(){  //keyup事件处理 
	      $(this).val($(this).val().replace(/\D|^0/g,''));  
	    	 }).bind("paste",function(){  //CTR+V事件处理 
	      $(this).val($(this).val().replace(/\D|^0/g,''));  
	     }).css("ime-mode", "disabled");  //CSS设置输入法不可用

 });
 
 function select()
 {
	 var batchId = $("#BatchID").val(); 
	 var isBoard = $("#BroadID option:selected").val();
	 $.post("<%=path%>/back/generateNoRoute.action",
		     {'batchId':batchId,'isBoard':isBoard},
		     function(returnData,status)
		     {
		    	 if("success"==status)
		          {
			    	    $("#RouteNoId").val(returnData);			    	    
		          }
		     
		     });
 }
</script>

<style type="text/css">

.inputinfo
{
margin-right:4px;
width:200px;
}
</style>

</head>

<body>
<center>
<form action="<%=path%>/back/addRoute.action" method="post">
<input type="hidden" name="batchId" id="BatchID" value="${batchId}">
<TABLE class="tableEdit" border="0" cellspacing="1" cellpadding="0" style="width:500px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">为批次【${batch.name}】添加路线</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->

<table class="tableEdit" style="width:500px;" cellspacing="0" border="0" cellpadding="3">

<tr>
		<td  class="tdEditLabel" >境外/内线</td>			
		<td class="tdEditContent">
		<select class="inputinfo" name="isBoard" id="BroadID" onchange="select()">
		      <option value="1" selected="selected">境外线</option>
		      <option value="0">境内线</option>
		       </select> 

		</td>
	</tr>
	<tr>
	    <td class="tdEditLabel">编号</td>			
		<td align="left" class="tdEditContent"><input class="inputinfo" type="text" 
		name="routeNo" readonly="readonly" id="RouteNoId"></td>
	</tr>
	
	
	<tr>	
		<td  class="tdEditLabel" >名称</td>			
		<td align="left" class="tdEditContent"><input class="inputinfo" type="text" 
		name="name"></td>
	</tr>
	
	<tr>	
		<td width="80px" class="tdEditLabel" >开始日期</td>			
		<td align="left" class="tdEditContent">
		 <tx:datetimepicker displayFormat="yyyy-MM-dd" name="startDate" ></tx:datetimepicker>
	</td>

    <tr>	
		<td width="80px" class="tdEditLabel" >结束日期</td>			
		<td align="left" class="tdEditContent">
		 <tx:datetimepicker displayFormat="yyyy-MM-dd" name="endDate" ></tx:datetimepicker>
	  </td>
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >金额</td>			
		<td align="left" class="tdEditContent"><input class="inputinfo" type="text" 
		name="price" id ="priceID" value="5000"></td>
	</tr>
	
	<tr>	
		<td class="tdEditLabel" >最多人数</td>			
		<td align="left" class="tdEditContent"><input class="inputinfo" type="text" 
		name="maxAmount" id="maxAmountID" value="40"></td>
	</tr>
	
	<tr>
	   		<td class="tdEditLabel" >相关信息</td>			
		<td align="left" class="tdEditContent"><textarea class="inputinfo" name="description" rows="6" cols="16"></textarea></td>
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
			<input type="submit" name="saveButton"
				class="MyButton" value="保存路线信息"> 
			<input type="button" class="MyButton"
				value="关闭窗口" onclick="window.close()">
			</TD>
		</TR>
</TABLE>
</form>
</center>
</body>
</html>