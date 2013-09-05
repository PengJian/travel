<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@include file="/common/common.jsp" %>
<%
    String path = request.getContextPath();
%>
    <c:if test="${empty manager}">
   <%
      response.sendRedirect(path + "/back/login.jsp");
   %>
   </c:if>
<html>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/menu.css">
<head>
<title>主菜单</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body class="panel" topmargin="0" leftmargin="0">
<div id="body">
<!-- OA树开始-->
<ul id="menu">
<li class="L1"><a href="javascript:c(m01);" id="m01"><span><img src="images/ico/2.gif" align="absMiddle"/>员工管理</span></a></li>
<ul id="m01d" style="display:none;" class="U1">
<li class="L22"><a href="<%=path %>/back/listEmployee.action" target="main" id="f1001"><span><img src="images/ico/2.gif" align="absMiddle"/>员工管理</span></a></li>
</ul>
<li class="L1"><a href="javascript:c(m03);" id="m03"><span><img src="images/ico/2.gif" align="absMiddle"/>旅游批次线路管理</span></a></li>
<ul id="m03d" style="display:none;" class="U1">
<li class="L22"><a href="<%=path%>/back/listYearth.action" target="main" id="f131"><span><img src="images/ico/2.gif" align="absMiddle"/>年份管理</span></a></li>
<li class="L22"><a href="<%=path%>/back/listBatch.action" target="main" id="f132"><span><img src="images/ico/2.gif" align="absMiddle"/>批次线路管理</span></a></li>
<li class="L22"><a href="<%=path%>/back/searchRoute.action" target="main" id="f133"><span><img src="images/ico/2.gif" align="absMiddle"/>旅游线路查询</span></a></li>
<li class="L22"><a href="<%=path%>/back/startIntentionYearth.action" target="main" id="f134"><span><img src="images/ico/2.gif" align="absMiddle"/>开启意向调查</span></a></li>
</ul>

<li class="L1"><a href="javascript:c(m05);" id="m05"><span><img src="images/ico/2.gif" align="absMiddle"/>报名信息管理</span></a></li>
<ul id="m05d" style="display:none;" class="U1">
<li class="L22"><a href="<%=path%>/back/listActiveEmployeeRoute.action"  target="main" id="f43"><span><img src="images/ico/2.gif" align="absMiddle"/>报名信息一览（激活）</span></a></li>
<li class="L22"><a href="javascript:c(f44);" target="main" id="f44"><span><img src="images/ico/2.gif" align="absMiddle"/>报名信息一览（历史）</span></a></li>
</ul>

<li class="L1"><a href="javascript:c(m04);" id="m04"><span><img src="images/ico/2.gif" align="absMiddle"/>旅游费用管理</span></a></li>
<ul id="m04d" style="display:none;" class="U1">
<li class="L22"><a href="javascript:c(f43);" target="main" id="f141"><span><img src="images/ico/2.gif" align="absMiddle"/>费用信息一览</span></a></li>
<li class="L22"><a href="javascript:c(f44);" target="main" id="f142"><span><img src="images/ico/2.gif" align="absMiddle"/>批次费用一览</span></a></li>
<li class="L22"><a href="<%=path%>/back/toListExpense.action" target="main" id="f143"><span><img src="images/ico/2.gif" align="absMiddle"/>线路费用一览</span></a></li>
<li class="L22"><a href="javascript:c(f44);" target="main" id="f144"><span><img src="images/ico/2.gif" align="absMiddle"/>个人费用一览</span></a></li>
</ul>

<li class="L1"><a href="javascript:c(m09);" id="m09"><span><img src="images/ico/2.gif" align="absMiddle"/>权限管理</span></a></li>
<ul id="m09d" style="display:none;" class="U1">
<li class="L22"><a href="<%=path%>/back/listUser.action" target="main" id="f12"><span><img src="images/ico/2.gif" align="absMiddle"/>管理员管理</span></a></li>
<li class="L22"><a href="javascript:c(f13);" id="f13"><span><img src="images/ico/2.gif" align="absMiddle"/> 管理员权限</span></a></li>
</ul>

<li class="L1"><a href="javascript:c(m60);" id="m60"><span><img src="images/ico/2.gif" align="absMiddle"/>系统管理</span></a></li>
<ul id="m60d" style="display:none;" class="U1">
<li class="L22"><a href="<%=path %>/back/toSetApplyTime.action" target="main" id="f1105"><span><img src="images/ico/2.gif" align="absMiddle"/>报名时间设置</span></a></li>
<li class="L22"><a href="<%=path %>/back/searchAllLog.action" id="f1106"  target="main"><span><img src="images/ico/2.gif" align="absMiddle"/>用户记录查询</span></a></li>
<li class="L22"><a href="javascript:a('training/train/leave_word','1106');"  target="main" id="f1107"><span><img src="images/ico/2.gif" align="absMiddle"/>数据归档管理</span></a></li>
</ul>
<li class="L1"><a href="<%=path%>/back/logout.action" target="main" id="m30"><span><img src="images/ico/2.gif" align="absMiddle"/>注销</span></a></li>
</div>
<div id="bottom"></div>

<script language="JavaScript">
var cur_id="";
var flag=0,sflag=0;

//-------- 菜单点击事件 -------
function c(srcelement)
{
  var targetid,srcelement,targetelement;
  var strbuf;

  //-------- 如果点击了展开或收缩按钮---------
  targetid=srcelement.id+"d";
  targetelement=document.getElementById(targetid);

  if (targetelement.style.display=="none")
  {
     srcelement.className="active";
     targetelement.style.display='';

     menu_flag=0;
     expand_text.innerHTML="收缩";
  }
  else
  {
     srcelement.className="";
     targetelement.style.display="none";

     menu_flag=1;
     expand_text.innerHTML="展开";
     var links=document.getElementsByTagName("A");
     for (i=0; i<links.length; i++)
     {
       srcelement=links[i];
       if(srcelement.parentNode.className.toUpperCase()=="L1" && srcelement.className=="active" && srcelement.id.substr(0,1)=="m")
       {
          menu_flag=0;
          expand_text.innerHTML="收缩";
          break;
       }
     }
  }
}
function set_current(id)
{
   cur_link=document.getElementById("f"+cur_id)
   if(cur_link)
      cur_link.className="";
   cur_link=document.getElementById("f"+id);
   if(cur_link)
      cur_link.className="active";
   cur_id=id;
}
//-------- 打开网址 -------
function a(URL,id)
{
   set_current(id);
   if(URL.substr(0,7)!="http://" && URL.substr(0,6)!="ftp://")
      URL = "/general/"+URL;
    parent.openURL(URL,0);
}
function b(URL,id)
{
   set_current(id);
   URL = "/app/"+URL;
    parent.openURL(URL,0);
}
//add by YZQ 2008-03-05 begin
function bindFunc() {
  var args = [];
  for (var i = 0, cnt = arguments.length; i < cnt; i++) {
    args[i] = arguments[i];
  }
  var __method = args.shift();
  var object = args.shift();
  return (
    function(){
      var argsInner = [];
		  for (var i = 0, cnt = arguments.length; i < cnt; i++) {
		    argsInner[i] = arguments[i];
		  }
      return __method.apply(object, args.concat(argsInner));
    });
}
var timerId = null;
var firstTime = true;
//add by YZQ 2008-03-05 end
function d(URL,id)
{
   //add by YZQ 2008-03-05 begin
   var winMgr = parent.parent.table_index.main.winManager;
	 if (!winMgr) {
	   if (firstTime) {
	     parent.openURL("/fis/common/frame.jsp",0);
	     firstTime = false;
	   }
	   timerId = setTimeout(bindFunc(d, window, URL, id), 100);
	   return;
	 }
	 firstTime = true;
	 if (timerId) {
	   clearTimeout(timerId);
	 }
	 if (winMgr) {
	   winMgr.openActionPort("/fis/"+URL, document.getElementById("f" + id).innerText);
	   return;
	 }
   //add by YZQ 2008-03-05 end

   set_current(id);
   URL = "/fis/"+URL;
    parent.openURL(URL,0);
}
//-------- 菜单全部展开/收缩 -------
var menu_flag=1;
function menu_expand()
{
  if(menu_flag==1)
     expand_text.innerHTML="收缩";
  else
     expand_text.innerHTML="展开";

  menu_flag=1-menu_flag;

  var links=document.getElementsByTagName("A");
  for (i=0; i<links.length; i++)
  {
    srcelement=links[i];
    if(srcelement.parentNode.className.toUpperCase()=="L1" || srcelement.parentNode.className.toUpperCase()=="L21")
    {
      targetelement=document.getElementById(srcelement.id+"d");
      if(menu_flag==0)
      {
        targetelement.style.display='';
        srcelement.className="active";
      }
      else
      {
        targetelement.style.display="none";
        srcelement.className="";
      }
    }
  }
}

//-------- 打开windows程序 -------
function winexe(NAME,PROG)
{
   URL="/general/winexe?PROG="+PROG+"&NAME="+NAME;
   window.open(URL,"winexe","height=100,width=350,status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,top=0,left=0,resizable=no");
}
</script>

</body>
</html>