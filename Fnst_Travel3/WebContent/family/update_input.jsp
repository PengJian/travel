<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    String path = request.getContextPath();
%>
<meta http-equiv="Pragma"   content="no-cache"> 
<link href="../css/front.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/public.js"></script>
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript">
    function validate(){
       var name = $("#name").val();
       var sex = $("#sex option:selected").val();
       var identityNo = $("#identityNo").val();
       var relation = $("#relation option:selected").val();
       var identityNo = $("#identityNo").val();
       var remarks = $("#remarks").val();
       var isTravel = $("#isTravel").val();
       
       if(name==""){
    	   alert('姓名不能为空');
    	   return false;
       }
       if(sex=="") {
    	   alert('性别不能为空');
           return false;
    	   }
       if(relation==""){
    	   alert('关系不能为空');
           return false;
    	   }
       if(isTravel==""){
    	   alert('是否参加旅游不能为空');
           return false;
    	   }
       }

  
</script>
<title>修改家属信息</title>
</head>
<base target="_self"/>
<body>
	
		<form action="<%=path%>/front/updateFamily.action" method="post">
			<!-- 这里是添加、编辑界面的标题 -->
			<center><div style="font-size: 25px; margin: 10px 0px 20px 0px;">修改家属信息</div></center>

			<input type="hidden" name='id' value="${family.id}">
			<table align="center">
				<tr>
					<td>姓名：</td>
					<td><input type="text" name='name' id='name'
						style='width: 180px;' value='${family.name }' />
					</td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><select name="sex" id="sex" style='width:80px;'>
		                  <option value="男" <c:if test="${family.sex == '男'}">selected="selected"</c:if>>男</option>
		                  <option value="女" <c:if test="${family.sex == '女'}">selected="selected"</c:if>>女</option>
	                   </select> 	
					</td>
				</tr>
				<tr>
                    <td>关系：</td>
                    <td><select name='relation' id='relation' style='width:80px;'>
                            <option value="夫妻" <c:if test="${family.relation == '夫妻'}">selected="selected"</c:if>>夫妻</option>
                            <option value="父子" <c:if test="${family.relation == '父子'}">selected="selected"</c:if>>父子</option>
                            <option value="父女" <c:if test="${family.relation == '父女'}">selected="selected"</c:if>>父女</option>
                            <option value="母子" <c:if test="${family.relation == '母子'}">selected="selected"</c:if>>母子</option>
                            <option value="母女" <c:if test="${family.relation == '母女'}">selected="selected"</c:if>>母女</option>
                    </select>
                    </td>
                </tr>
				<tr>
					<td>身份证号码：</td>
					<td><input type='text' name='identityNo' id='identityNo'
						style='width: 180px;' value='${family.identityNo }' />
					</td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input type='text' name='remarks' id='remarks'
						style='width: 180px;' value='${family.remarks }' />
					</td>
				</tr>
				<tr>
					<td>是否参加旅游</td>
					<td><select name='isTravel' id='isTravel' style='width:80px;'>
					        <option value="1" <c:if test="${family.isTravel == 1 }">selected="selected"</c:if>>是</option>
							<option value="0" <c:if test="${family.isTravel == 0 }">selected="selected"</c:if>>否</option>
					</select>
					</td>
				</tr>
			</table>
			<br>
			<TABLE align="center">
				<TR align="center">
					<TD colspan="3" bgcolor="#EFF3F7"><input type="submit"
						name="saveButton" class="button3" onclick="return validate();" value="保存家属信息"></TD>
				</TR>
			</TABLE>
		</form>
</body>
</html>