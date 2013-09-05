<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    <%@include file="/common/common.jsp" %>
     <%
       String path = request.getContextPath();
    %>
    <c:if test="${empty manager}">
   <%
      response.sendRedirect(path + "/back/login.jsp");
   %>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body bgcolor="" background="">
   1、帐号自由设置，用户数量不限<br>
　　2、 永久性使用，不限使用期限，终身免费的技术支持<br>
　　3、完全独立的管理平台，不需要租用任何的服务器，可以将期安装在您需要的任何地方<br>
　　4、基于B/S架构，互联网、局域网、本地电脑皆可使用，不需安装客户端，可无限范围覆盖<br>
　　5、强大的数据管理和统计分析功能，可根据建立的各种不同的信息，并快速查询出所需要的<br>
              统计信息和相对应的柱状图、折线图、饼图<br>
　　6、独立的团队管理系统，使您对整个企业、整个团队情况一目了然。<br>
　　      CRM为企业构建了一整套以客户为中心的有关客户、营销、销售、服务与支持信息的数据<br>
              库，帮助企业了解管理渠道，建立和优化了前端业务流程，包括市场营销、销售、产品的<br>
              服务与支持、呼叫中心等。该系统可以进行深层次分析和挖掘，从而发现最有价值的客户<br>
              、新的市场和潜在的客户，创造业务良机。该系统可扩展、可连接的特性可以与企业的SCM、<br>
     ERP系统无缝集成，实现实时的数据交换，增强企业与供应商、合作伙伴、客户间的关系，<br>
              加快客户服务与支持响应速度，增强企业在电子商务时代的竞争优势。<br>
　　7、销售机会的跟踪，可以方便了解每一个销售机会目前的跟进情况。快速制定客户的跟进策略<br>。
     ——并且在销售机会的详细页可以看到联系活动、报价单、签约单、服务单的明细情况
</body>
</html>