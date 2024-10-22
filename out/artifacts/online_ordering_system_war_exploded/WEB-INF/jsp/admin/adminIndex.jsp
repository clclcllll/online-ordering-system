<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>
<h2>欢迎来到后台管理系统</h2>
<ul>
    <li><a href="${pageContext.request.contextPath}/admin?action=userList">用户管理</a></li>
    <li><a href="${pageContext.request.contextPath}/admin?action=dishList">菜品管理</a></li>
    <li><a href="${pageContext.request.contextPath}/admin?action=orderList">订单管理</a></li>
    <li><a href="${pageContext.request.contextPath}/admin?action=addDish">添加菜品</a></li>
</ul>
<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>

