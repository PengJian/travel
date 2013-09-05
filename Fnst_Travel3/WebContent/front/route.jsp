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
<title>ITSUS</title>
<link href="css/front.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
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

	<div id="content">

		<div id="content_inner">
			<div id="logo">
				<img style="width: 900px; height: 140px" src="images/9.jpg"></img>
			</div>
			<div id="left_box">
                    <div id="search">
                        <h2>北京時間</h2>
                        <form method="get" action="http://www.baidu.com">
                            <div id="clock"></div>
                        </form></div>
                    <div>
                        <div id="left_menu">
                            <h2>时间段报名</h2>
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
										  	 <a class="baoming_a" href="javascript:void(0)" onclick= "apply(${item.value.routeID})">报名</a>
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
                        <div class="nav">
                        <a href="<%=path%>/index.jsp" class="links"> <span class="intro">数据统计</span> <span
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


				<div id="post">
					<!-- <div id="changePassword">
						<div class="modify">修改密码</div>
						<div>
							新 密 码：<input type="password" name="newPassword" id="newPassword1" /><br>
							确认密码：<input type="password" name="newPassword" id="newPassword2" /><br>
							<a href="javascript:doChangePassword('ChangePassword.do')">提交修改</a>

						</div>
					</div>
					<div id="changeFamily">
						<div class="modify" style="float:left">人数选择：</div>
						<SELECT id="registrationPersonNum" title="人数选择"
							style="WIDTH: 90px;;"
							name="registrationPersonNum"
							onchange="javascript:registrationInfo();">
							<OPTION value="1">1人参加</OPTION>
							<OPTION value="2">2人参加</OPTION>
							<OPTION value="3">3人参加</OPTION>
						</SELECT>

						<div id="registrationInfoValue">
							本人姓名：<input type="text" name="myName" id='myName' />
							身份证号码：<input
								type="text" name="myNameIDnumber" id='myNameIDnumber'
								style="width: 140px" />
								移动电话：<input
								type="text" name="myNamePhonenumber" id='myNamePhonenumber' /><br>
							<br>
						</div>
						<div id="registrationInfoValue2"></div>
						<div id="registrationInfoValue3"></div>
					</div>  -->

					 <h2 class="title">
						<a href="#">实时数据统计</a>
					</h2>
					<h2 class="byline">
						<a href="#">刷新</a>
					</h2>
					<div class="entry">
						<div id="tongji"></div>
					</div> 
				</div>
			</div>




		</div>
	</div>


<!-- foot -->
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>
