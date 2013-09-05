<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
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
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript"> 

function apply(routeId,object)
{   
	$(object).attr("disabled","disabled");
    $.post("<%=path%>/front/apply.action",
	     {'routeId':routeId},
	     function(returnData,status)
	     {
	    	if("success"==status)
	    	{
	    		if(returnData.length > 50){
	    			window.location.href="<%=path%>/login.jsp";
	    			return false;
	    		}
	    		alert(returnData);
	    	    loadRoute();
	    		//window.location.reload(true);
	    	}
	    });

return false;
}



function applyOut()
{
	if(!confirm('确定退报?')){
		return;
	}
    $.post("<%=path%>/front/applyOut.action",
	     {},
	     function(returnData,status)
	     {
	    	if("success"==status)
	    	{
	    		if(returnData.length > 50){
	    			window.location.href="<%=path%>/login.jsp";
	    			return false;
	    		}
	    		alert(returnData);
	    		loadRoute();
	    	}
	    });
  
return false;
}

function loadRoute()
{	
	 $("#left_memu_div").load("<%=path%>/"+"secret/s1.jsp?rand=" + Math.random());
	 loadGraph();
}
function loadGraph()
{
	 $("#vertgraph").load("<%=path%>/"+"secret/s2.jsp?rand=" + Math.random());
}

</script>
<script language="javascript" src="<%=path %>/js/front.js"></script>
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
						<!--<h2>北京时间&nbsp;&nbsp;&nbsp;<a href="<%=path %>/front/listIntention.action" style="width: 900px; height: 140px; color:red;font-size:14px;text-decoration:underline;" >旅游意向调查</a></h2>
						--><form method="get" action="http://www.baidu.com">
							<div id="clock"></div>
						</form></div>
					<div>
						<div id="left_menu">
							<h2>时间段报名 </h2>
							<a href="javascript:void(0)" onclick="loadRoute()" class="refresh">刷新</a>					
							<div id="left_memu_div">
							  
							   <c:if test="${my:isDuringApplyTime()}">						   
								   	<c:forEach items="${Routes}" var="item"> 
								      <div class="route">
										<a class="route_a"
											href="javascript:doTravelChoose('<%=path %>/front/findRouteDetail.action','${item.value.routeID}')">${item.value.name}</a>
										<c:if test="${applyStatus == item.value.routeID}">
										   <a class="baoming_a" href="javascript:void(0)" onclick= "applyOut()">退报</a>
										</c:if>
										<c:if test="${applyStatus != item.value.routeID}">
										   <c:if test="${applyStatus != 0}">
										  	 <a class="baoming_b" href="javascript:void(0)")">报名</a>
											</c:if>
											<c:if test="${applyStatus == 0}">
										  	   <c:if test="${item.value.count < item.value.maxPersons}">
                                                  <a class="baoming_a" href="javascript:void(0)" onclick= "apply(${item.value.routeID},this)">报名</a>
										  	    </c:if>
                                                <c:if test="${item.value.count >= item.value.maxPersons}">
                                                  <a class="baoming_b" href="javascript:void(0)")">已满</a>
										  	   </c:if>
											</c:if>
										</c:if>
								    	</div>
	                                </c:forEach>
                                </c:if>
						     
						        <c:if test="${!my:isDuringApplyTime()}">						   
								   	<c:forEach items="${Routes}" var="item"> 
								      <div class="route">
										<a class="route_a"
										href="javascript:doTravelChoose('<%=path %>/front/findRouteDetail.action','${item.value.routeID}')">${item.value.name}</a>
								    	<a class="baoming_b" href="javascript:void(0)">报名</a>
								    	</div>
	                            </c:forEach>
                                </c:if>
						     
                            <!--<c:forEach items="${offRoutes}" var="item1"> 
							  <div class="route">
									<a class="route_a"
										href="javascript:doTravelChoose('<%=path %>/front/findRouteDetail.action','${item1.id}')">${item1.name}</a>
									<a class="baoming_b" href="javascript:void(0)">报名</a>
								</div>
                            </c:forEach>
						    --></div>
						</div></div>
			</div>




			<div id="main_box">

				<div class="baby example_type">
					<div class="nav">
                        <a href="<%=path%>/index.jsp" class="links"> <span class="intro_b">数据统计</span> <span
                            class="bg"></span> </a> <a href="<%=path%>/front/listResult.action" class="links"> <span
                            class="intro">报名结果</span> <span class="bg"></span> </a> <a
                            href="<%=path %>/front/listFamily.action" class="links"> <span
                            class="intro">账户管理</span> <span class="bg"></span> </a> <a
                            href="<%=path%>/front/help.jsp" class="links"> <span class="intro">报名说明</span>
                            <span class="bg"></span> </a>
                             <a href="<%=path%>/front/schedule.jsp" class="links"> <span class="intro">行程安排</span>
                            <span class="bg"></span> </a>  
                            <a href="<%=path%>/front/logout.action" class="links"> <span
                            class="intro">注销</span> <span class="bg"></span> </a>
                    </div>
				</div>

                   <br>
				<div id="post">
				<div> <h2 class="title">
                        <a href="javascript:void(0)" onclick="loadGraph()">实时数据统计</a>
                    </h2></div>
				    <div id="vertgraph" style="clear:both;">
				   
                    <ul>
                  
                    
                        <c:forEach items="${Routes}" var="item" varStatus="status"> 
                              <li style="background-position: ${-(status.count-1)*28}px bottom;
                                   left:${480*(status.count/(fn:length(Routes)+1))}px; 
                                   height:${440*(item.value.count/1500)+20 }px;">
                                        ${item.value.count}
                                </li>
                        </c:forEach>
                    </ul>
                    <c:forEach items="${Routes}" var="item" varStatus="status"> 
                    <ul class="nav" style="left:${480*(status.count/(fn:length(Routes)+1))}px;"><p class="bg">${item.value.name}</p></ul>
                    </c:forEach>
        
    </div>
				</div>
			</div>




		</div>
	</div>


	<jsp:include page="front/foot.jsp"></jsp:include>

</body>
</html>
