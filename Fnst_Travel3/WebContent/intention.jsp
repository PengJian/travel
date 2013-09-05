<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
    int currentYear = Calendar.getInstance().get(Calendar.YEAR);
    pageContext.setAttribute("currentYear", currentYear, pageContext.PAGE_SCOPE);
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:if test="${empty user}">
   <%
       response.sendRedirect(path + "/login.jsp");
   %>
</c:if>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<meta name="keywords" content="" />
<meta name="description" content="" />
<head>
<base href="<%=basePath%>">
<title>FNST社内旅游报名系统</title>
<link href="css/front.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=path%>/script/jquery-1.5.2.js"></script>
<script type="text/javascript"> 

function apply(batchNo, object)
{
	if(!confirm('确定提交')){
		return;
	}
	$(object).attr("disabled","disabled");
    $.post("<%=path%>/front/applyIntention.action",
         {'id': batchNo},
         function(returnData,status)
         {
            if("success"==status)
            {
                if(returnData.length > 50){
                    window.location.href="<%=path%>/login.jsp";
                    return false;
                }
                alert(returnData);
                window.location.reload(true);
            }
        });

return false;
}

function loadGraph()
{
	window.location.reload(true);
}

</script>
<script language="javascript" src="<%=path%>/js/front.js"></script>
<script type="text/javascript">
//var now = new Date(2012, 08, 06, 15, 54, 25);//在此处填写服务器当前时间即可 
var now ;
$.post("<%=path%>/front/getCurrentTime.action",
         {},
         function(returnData,status)
         {
            if("success"==status)
            {   var array = returnData.split(":");
                now = new Date(array[0],array[1],array[2],array[3],array[4],array[5]);
            }
        });
    function CurentTime() {
        var mm = now.getMinutes();
        var ss = now.getTime() % 60000;
        ss = (ss - (ss % 1000)) / 1000;
        var clock = now.getHours() + ':';
        if (mm < 10)
            clock += '0';
        clock += mm + ':';
        if (ss < 10)
            clock += '0';
        return (clock + ss);
    }
    function refresh() {
        document.getElementById("clock").innerHTML = now.getFullYear() + "年"
                + now.getMonth() + "月" + now.getDate() + "日 <br>" + CurentTime();
        now.setSeconds(now.getSeconds() + 1);
    }
    setInterval('refresh()', 1000);
</script>
</head>
<body>

    <div id="content">

        <div id="content_inner">
            <div id="logo">
                <img style="width: 900px; height: 140px" src="images/9.jpg"></img>
            </div>
            <div id="left_box">
                    <div id="search">
                        <h2>北京时间</h2>
                        <form method="get" action="http://www.baidu.com">
                            <div id="clock"></div>
                        </form></div>
                    <div>
                        <div id="left_menu">
                            <h2>批次选择</h2>              
                            <div id="left_memu_div">
                            <c:forEach items="${batches}" var="item">
                                <div class="route">
                                    <span class="route_a">${item.name}</span>
                                    <c:if test="${user.intentionFlag != currentYear}">
                                        <a class="baoming_a" href="javascript:void(0)"
                                        onclick="apply(${item.id},this)">选择</a>
                                    </c:if>
                                    <c:if test="${user.intentionFlag == currentYear}">                           
                                      <a class="baoming_b" href="javascript:void(0)">已投</a>
                                    </c:if>
                                </div>
                            </c:forEach>                            
                            </div>
                        </div></div>
            </div>




            <div id="main_box">

                <div class="baby example_type">
                    <div class="nav">
                        <a href="<%=path%>/index.jsp" class="links"> <span class="intro">报名首页</span> <span
                            class="bg"></span> </a> <a href="<%=path%>/front/listResult.action" class="links"> <span
                            class="intro">报名结果</span> <span class="bg"></span> </a> <a
                            href="<%=path%>/front/listFamily.action" class="links"> <span
                            class="intro">账户管理</span> <span class="bg"></span> </a> <a
                            href="<%=path%>/front/help.jsp" class="links"> <span class="intro">报名说明</span>
                            <span class="bg"></span> </a> <a href="<%=path%>/front/logout.action" class="links"> <span
                            class="intro">注销</span> <span class="bg"></span> </a>
                    </div>
                </div>

                   <br>
                <div id="post">
                <div> <h2 class="title">
                        <a href="javascript:void(0)" onclick="loadGraph()">批次选择统计</a>
                    </h2></div>
                    <div id="vertgraph" style="clear:both;">
                   
                    <ul>
                        <c:forEach items="${batches}" var="item" varStatus="status"> 
                              <li style="background-position: ${-(status.count-1)*28}px bottom;
                                   left:${480*(status.count/(fn:length(batches)+1))}px; 
                                   height:${440*(item.intentionNum/1000)+20 }px;">
                                        ${item.intentionNum}
                                </li>
                        </c:forEach>
                    </ul>
                    <c:forEach items="${batches}" var="item" varStatus="status"> 
                    <ul class="nav" style="left:${480*(status.count/(fn:length(batches)+1))}px;"><p class="bg">${item.name}</p></ul>
                    </c:forEach>
        
    </div>
                </div>
            </div>




        </div>
    </div>


    <div id="foot">
        <p id="foot_inner">
            Copyright &copy; 2012  FNST. All Rights Reserved. Designed by <a
                href="http://www.fujitsu.com/cn/fnst/">Nanjing Fujitsu Nanda
                Software Technology Co., Ltd</a>.
        </p>
        <p id="foot_inner">
            <a href="#">Privacy Policy</a> | <a href="#">Terms of Use</a>
        </p>
    </div>

</body>
</html>
