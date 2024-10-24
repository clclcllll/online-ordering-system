<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>网上订餐系统</title>
</head>
<style>
    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh; /* 至少占据视口的高度 */
        margin: 0; /* 移除默认的边距 */
    }
    .navbar {
        color: #ffffff;
        justify-content: center;
        align-items: center;
        display: flex;
        background: rgb(78, 171, 255);
        height: 7vh;
    }

    .navbar a {
        margin-right: 10px;
        margin-left: 10px;
        width: 80px;
        font-size: 18px;
        color: #ffffff;
        font-family: inherit;
        font-weight: 800;
        cursor: pointer;
        position: relative;
        border: none;
        background: none;
        text-transform: uppercase;
        display: flex;          /* 使用 Flexbox 布局 */
        justify-content: center; /* 水平居中 */
        align-items: center;    /* 垂直居中 */
        text-decoration: none;  /* 去掉下划线 */
        transition-timing-function: cubic-bezier(0.25, 0.8, 0.25, 1);
        transition-duration: 400ms;
        transition-property: color;
    }

    .navbar a:focus,
    .navbar a:hover {
        color: #ffffff;
    }

    .navbar a:focus:after,
    .navbar a:hover:after {
        width: 100%;
        left: 0%;
    }

    .navbar a:after {
        content: "";
        pointer-events: none;
        bottom: -2px;
        left: 50%;
        position: absolute;
        width: 0%;
        height: 2px;
        background-color: #ffffff;
        transition-timing-function: cubic-bezier(0.25, 0.8, 0.25, 1);
        transition-duration: 400ms;
        transition-property: width, left;
    }

    .name{
        font-size: 30px;
        fontfamily: STSong;
        padding-right: 3vw
    }



</style>
<body>
<div class="navbar" style="display: flex;">
    <div class="name">网上订餐系统</div>
    <span style="padding-right: 0.5vw">欢迎，${sessionScope.user.username}</span>
    <a href="${pageContext.request.contextPath}/dish?action=index">首页</a> |
    <a href="${pageContext.request.contextPath}/dish?action=list">菜品列表</a> |
    <a href="${pageContext.request.contextPath}/cart?action=view">购物车</a> |
    <a href="${pageContext.request.contextPath}/order?action=list">我的订单</a> |
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/login">退出登录</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/login">登录</a> |
            <a href="${pageContext.request.contextPath}/register">注册</a>
        </c:otherwise>
    </c:choose>
</div>