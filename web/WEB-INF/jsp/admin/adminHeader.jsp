<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>后台管理系统</title>
    <!-- 引入 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<nav>
    <a href="${pageContext.request.contextPath}/admin?action=index">首页</a> |
    <a href="${pageContext.request.contextPath}/admin?action=userList">用户管理</a> |
    <a href="${pageContext.request.contextPath}/admin?action=dishList">菜品管理</a> |
    <a href="${pageContext.request.contextPath}/admin?action=orderList">订单管理</a> |
    <a href="${pageContext.request.contextPath}/admin?action=logout">退出登录</a>
</nav>
<hr>
