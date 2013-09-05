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
<link rel="stylesheet" type="text/css" href="../js/editor/themes/simple/simple.css" />
<script charset="utf-8" src="../js/editor/kindeditor.js"></script>
<script charset="utf-8" src="../js/editor/lang/zh_CN.js"></script>
<script>
function initKindEditor(expr) {
    KindEditor.ready(function(K) {
     editor = K.create('textarea[name="'+expr+'"]', {
            resizeType : 1,
                    themeType: 'simple',
                    allowPreviewEmoticons : false,
                    allowImageUpload : false,
                    items : [
                        'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                        'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                        'insertunorderedlist', '|', 'emoticons', 'image', 'link','|','undo','redo','fullscreen','|', 'selectall', 'source','about']
        });
    });
}
initKindEditor('detail'); //


</script>
<title>添加线路信息</title>

</head>
<body>
<center>
<form action="<%=path%>/back/updateRouteDetail.action" method="post">
<input type="hidden" name="routeId" value="${routeId}">
<TABLE class="tableEdit" border="0" cellspacing="1" cellpadding="0" style="width:500px;">
	<TBODY>
		<TR>
			<!-- 这里是添加、编辑界面的标题 -->
			<td align="center" class="tdEditTitle">为线路【${route.name}】添加详情</TD>
		</TR>
		<TR>
			<td>
			<!-- 主输入域开始 -->

<table class="tableEdit" style="width:500px;" cellspacing="0" border="0" cellpadding="0">
<tr><td>
<textarea id="detail" name="details" style="width:600px;height:300px">${rd.details}</textarea>
</td></tr>

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
				class="MyButton" value="保存路线详情"> 
			<input type="button" class="MyButton"
				value="关闭窗口" onclick="window.close()">
			</TD>
		</TR>
</TABLE>
</form>
</center>
</body>
</html>