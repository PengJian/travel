<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/common/common.jsp" %>
    <%
    String path = request.getContextPath();
    %>
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
                            </c:forEach>-->