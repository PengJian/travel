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
<title>修改线路信息</title>
</head>
<body>
<center>
<form action="<%=path%>/back/updateRoute.action" method="post">
<textarea id="detail" name="detail" style="width:600px;height:300px"></textarea>
</form>
</center>
</body>
</html>