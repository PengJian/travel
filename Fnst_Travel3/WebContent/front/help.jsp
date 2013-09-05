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

$(document).ready(function(){
	var flag = $("#flag").val();
	if('true' == flag){
	   alert("请务必报名之前，在【帐户管理】中添加好【家属信息】");	
	}
});

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
	    		//window.location.reload(true);
	    	}
	    });
  
return false;
}

function loadRoute()
{
	 $("#left_memu_div").load("<%=path%>/"+"secret/s1.jsp?rand=" + Math.random());
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
<script type="text/javascript" src="js/front.js"></script>
</head>
<body>
    <input type="hidden" value="${flag}" id="flag"/>
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
							<h2>时间段报名</h2>
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
                                </c:if><!--
                            <c:forEach items="${offRoutes}" var="item1"> 
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
                        <a href="<%=path%>/index.jsp" class="links"> <span class="intro">数据统计</span> <span
                            class="bg"></span> </a> <a href="<%=path%>/front/listResult.action" class="links"> <span
                            class="intro">报名结果</span> <span class="bg"></span> </a> <a
                            href="<%=path %>/front/listFamily.action" class="links"> <span
                            class="intro">账户管理</span> <span class="bg"></span> </a> <a
                            href="<%=path%>/front/help.jsp" class="links"> <span class="intro_b">报名说明</span>
                            <span class="bg"></span> </a>
                             <a href="<%=path%>/front/schedule.jsp" class="links"> <span class="intro">行程安排</span>
                            <span class="bg"></span> </a>
                             <a href="<%=path%>/front/logout.action" class="links"> <span
                            class="intro">注销</span> <span class="bg"></span> </a>
                    </div>
				</div>


				<div id="post">
					<div id="west" style="padding:0px 0px 0px 20px">
                        <div style="color:red;font-size:18px">一、参加对象：</div>
                        2013年8月31日（含8月31日）之前，在册的正式员工。
                        <br>该时点在册的临时工，可参照员工家属补贴标准参加公司旅游。
                        <br>员工家属（配偶及子女）须是2013年8月31日前在人事登记备案，并能提供合法证明。 <br>
                        
                        <div style="color: red;font-size:18px">二、关于费用负担：</div>
                                                                         本次旅游参照历年春游补贴标准：
                        <br>标准内的费用按实报销，超过标准的费用全部个人承担。
                        <br><b>员工旅游补贴3500元+900元现金（税金补贴）/人</b>
                        <br><b>家属(限配偶及子女) 旅游补贴1750元+450元现金（税金补贴）/人</b> 
                        <br>※注：1、旅游补贴按实际旅游发生的费用进行补助；
                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、超过旅游补贴标准的费用全部由个人承担；
                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、结算时，配偶和子女的费用，将分开结算。
                        <div style="color: red;font-size:18px">三、旅游时间：</div>
                         2013年度秋季旅游拟分以下三次进行：
                        <br><b>1、2013年国庆节期间</b>
                        <br><b>2、2014年元旦期间</b>
                        <br><b>3、2014年春节期间</b>
                        <br>※注：1、2014年元旦、春节的公休计划将另行通知；
                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、旅游对象只可以任选一次参加。具体旅游线路将另行公告。    
                        
                        <br>★由于旅游具体线路，需根据实际参加人数而定。
                        <br>&nbsp;&nbsp;&nbsp;届时将通过旅游报名网站以预报名方式确定参加人数。
                        <br> &nbsp;&nbsp;&nbsp;预报名的起始时间将另行通知。
                        
                        <div style="color: red;font-size:18px">四、其他事项：</div>
                        1、关于其他费用报销事宜。 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正式员工本次旅游办理的护照，因为考虑到公司将来有工作需要，
                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工本费可以报销，但其他交通等费用不能报销；
                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本次办理的港澳台等通行证费用，按照以前的做法不能报销。
                        <br>2、关于个人原因取消旅游费用承担问题。 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已经申报旅游，但因为个人原因而取消的，由于退票等原因发生的实际费用，将由个人承担。
                        <br>3、关于旅游其他未尽事宜： <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp 按照旅游事务局的有关公告执行。
                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 如有问题，请与公司旅游事务局（fnstml-travel@cn.fujitsu.com）联系。
                        <br> <br>以上。 <br> <br>FNST旅游事务局  07/30 <br>
                    </div>
				</div>
			</div>




		</div>
	</div>


	<!-- foot -->
<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>
