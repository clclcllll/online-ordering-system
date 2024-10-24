<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>网上订餐系统</title>
    <!-- 引入 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/dish?action=index">首页</a> |
    <a href="${pageContext.request.contextPath}/dish?action=list">菜品列表</a> |
    <a href="${pageContext.request.contextPath}/cart?action=view">购物车</a> |
    <a href="${pageContext.request.contextPath}/order?action=list">我的订单</a> |
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <span>欢迎，${sessionScope.user.username}</span> |
            <a href="${pageContext.request.contextPath}/login">退出登录</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/login">登录</a> |
            <a href="${pageContext.request.contextPath}/register">注册</a>
        </c:otherwise>
    </c:choose>
</nav>
<hr>