<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
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
<link href="<%=path %>/css/front.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=path %>/script/jquery-1.5.2.js"></script>
<script type="text/javascript">
function select()
{  
	  var routeId = $("#selectID option:selected").val();
	  if(-1 == routeId){
		  return;
	  }
	  window.location.href="<%=path%>/front/selectResult.action?routeId=" + routeId;
	  
}
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

function changeInfo()
{   
	var name = $("#name1").val();
	var sex = $("#sex1 option:selected").val();
	var telephone = $("#telephoneID").val();
	var identityNo = $("#identityNo").val();
	
	if(name==""){
		alert('姓名不能为空');
		return false;
	}
	
	if(sex==""){
		alert('性别不能为空');
		return false;
	}
		
	if(telephone=="" || identityNo=="")
		{
		alert('身份证或电话不能为空');
		return false;
		}
	$.post("<%=path%>/front/updateInfo.action",
		     {'name':name,'sex':sex,'telephone':telephone,'identityNo':identityNo},
		     function(returnData,status)
		     {
		    	if("success"==status)
		    	{
		    		  alert(returnData);
		    	}
	 });
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
<script language="javascript" src="<%=path%>/script/public.js"></script>
<script type="text/javascript"> 
  function myOpenWin(f,n,w,h,s){
		$.post("<%=path%>/front/seeStatusFamily.action",
			     {},
			     function(returnData,status)
			     {
			    	if("success"==status)
			    	{
			    		if(returnData==1){
			    			openWin(f,n,w,h,s);
			    		}else{
			    			window.location.href="<%=path%>/login.jsp";
			    		}
			    	}
		 });		 
  }
  
	  function myDel(url,info){
			$.post("<%=path%>/front/seeStatusFamily.action",
				     {},
				     function(returnData,status)
				     {
				    	if("success"==status)
				    	{
				    		if(returnData==1){
				    			del(url,info);
				    		}else{
				    			window.location.href="<%=path%>/login.jsp";
				    		}
				    	}
			 });		 
	  }
</script>
</head>
<body>
	<div id="content"  style="min-height:590px;">

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
                            class="intro_b">报名结果</span> <span class="bg"></span> </a> <a
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
				         <div><span>${userMsg}</span></div>
				                      各线路报名结果:&nbsp;&nbsp;
				         <select name="routeId" id="selectID" onchange="select()">
				            <option value="0">--选择路线查询结果--</option>
				         <c:forEach items="${Routes}" var="item" >
				            <option value="${item.value.routeID}" <c:if test="${item.value.routeID == routeId}"> selected="selected"</c:if>>${item.value.name}</option> 
				         </c:forEach>
				           <option value="-1">---------------------</option>
				           <c:forEach items="${offRoutes}" var="item" >
				            <option value="${item.id}" <c:if test="${item.id == routeId}"> selected="selected"</c:if>>${item.name}</option> 
				         </c:forEach>
				       </select>
				
					   <table width="620" style="font-size: 12px;line-height:150%" border="0" cellSpacing="1" cellSpacing='0' style="text-align:center">
          
       
          <!-- 列表数据栏 -->
         <c:if test="${!empty datas}">
         <!-- 列表标题栏 -->
          <tr class="TableBody1">
          <td width="15%"  align="center"><b>名字</b></td>
          <td width="15%"  align="center"><b>工号</b></td>
          <td width="5%"  align="center"><b>人数</b></td>
          <td width="25%" align="center"><b>线路</b></td>
          <td width="40%" align="center"><b>报名时间</b></td>
          </tr>
          <c:forEach items="${datas }" var="item">
	      <tr bgcolor="#EFF3F7" style="padding-top:0px;padding-bottom:0px;"  class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
		      <td align="center" vAlign="center">${item.employee.name }</td>
		       <td align="center" vAlign="center">${item.employee.username }</td>
		        <td align="center" vAlign="center">${item.participants}</td>
	          <td align="center" vAlign="center">${item.travelRoute.name }</td>
	           <td align="center" vAlign="center">${item.date }</td>
        </tr>
        </c:forEach>
		</c:if>
        <!-- 在列表数据为空的时候，要显示的提示信息 -->
	    <c:if test="${empty datas}">
	    <tr>
	    	<td colspan="4" align="center" bgcolor="#EFF3F7" class="TableBody1" onmouseover="this.bgColor = '#DEE7FF';" onmouseout="this.bgColor='#EFF3F7';">
	    	没有找到相应的记录
	    	</td>
	    </tr>
	    </c:if>
      </table>
					</div> 

					
				</div>
			</div>




		 </div>


	<!-- foot -->
<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>
