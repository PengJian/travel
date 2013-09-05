<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/common/common.jsp" %>
    <%
    String path = request.getContextPath();
    %>

 
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