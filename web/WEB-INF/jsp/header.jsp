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


    .logo {
        width: 20px; /* 根据需要调整大小 */
        height: 20px; /* 根据需要调整大小 */
        margin-right: 10px; /* 右边距，使图标与文字之间有间距 */


</style>
<body>
<div class="navbar" style="display: flex;">
    <svg t="1730277653340" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1477" width="70" height="70"><path d="M170.666667 410.538667V127.786667c0-19.328 24.106667-28.48 37.184-14.101334l112.064 123.178667a344.490667 344.490667 0 0 1 384.149333 0l112.085333-123.178667C829.226667 99.328 853.333333 108.48 853.333333 127.786667V896H170.666667V410.538667z" fill="#F7DBB0" p-id="1478"></path><path d="M170.666667 413.781333V128.042667c0-19.541333 24.106667-28.8 37.184-14.272l112.064 124.522666a341.205333 341.205333 0 0 1 61.461333-33.194666C422.784 187.946667 499.2 192 544 192c0 0-48.298667 163.968-106.666667 256-70.058667 110.464-192 181.333333-266.666666 202.666667V413.781333z" fill="#BF7722" p-id="1479"></path><path d="M853.333333 413.781333V128.042667c0-19.541333-24.106667-28.8-37.184-14.272l-112.064 124.522666a341.184 341.184 0 0 0-61.461333-33.194666C601.216 187.946667 524.8 192 480 192c0 0 48.298667 163.968 106.666667 256 70.058667 110.442667 192 181.333333 266.666666 202.666667V413.781333z" fill="#BF7722" p-id="1480"></path><path d="M438.314667 294.805333L384 213.333333l53.333333-21.333333 20.266667 94.656c2.474667 11.498667-12.757333 17.92-19.285333 8.149333zM500.202667 286.293333l-20.096-95.829333 57.429333 0.042667-16.384 95.402666c-2.005333 11.605333-18.56 11.904-20.949333 0.384zM568.725333 284.373333L584.533333 187.733333l53.546667 20.778667-49.706667 83.050667c-6.037333 10.090667-21.568 4.416-19.669333-7.189334z" fill="#403017" p-id="1481"></path><path d="M362.666667 458.666667a32 32 0 1 1-64 0 32 32 0 0 1 64 0zM725.333333 458.666667a32 32 0 1 1-64 0 32 32 0 0 1 64 0zM524.928 673.536a10.666667 10.666667 0 0 0-11.242667-12.629333 10.666667 10.666667 0 0 0-11.264 12.586666c-5.12 10.453333-17.109333 15.957333-32.341333 17.066667a72.042667 72.042667 0 0 1-22.933333-1.941333 34.218667 34.218667 0 0 1-7.36-2.773334c-1.109333-0.597333-1.6-1.002667-1.706667-1.109333h-0.021333a10.666667 10.666667 0 0 0-18.048 11.349333c2.432 3.989333 6.250667 6.698667 9.6 8.533334 3.562667 1.92 7.722667 3.456 12.074666 4.608 8.725333 2.304 19.306667 3.413333 29.952 2.624 14.229333-1.045333 30.72-5.76 41.941334-17.408 10.837333 11.562667 26.773333 16.362667 40.853333 17.408 10.474667 0.789333 20.949333-0.32 29.781333-2.602667 8.234667-2.133333 17.024-5.845333 22.122667-11.754667a10.666667 10.666667 0 0 0-16.192-13.909333c-0.682667 0.810667-4.138667 3.157333-11.306667 5.013333-6.613333 1.706667-14.72 2.581333-22.826666 1.984-14.592-1.109333-26.048-6.506667-31.082667-17.066666z" fill="#000000" p-id="1482"></path><path d="M316.544 264.896l15.296-10.304a323.157333 323.157333 0 0 1 360.32 0l15.296 10.304L832 127.978667v471.658666l-74.752 18.346667a10.666667 10.666667 0 1 0 5.077333 20.714667L832 621.589333V661.333333h-74.666667a10.666667 10.666667 0 0 0 0 21.333334H832v40.682666l-71.658667-12.224a10.666667 10.666667 0 0 0-3.584 21.013334l75.242667 12.864V896H192v-150.954667l75.264-12.522666a10.666667 10.666667 0 1 0-3.498667-21.034667L192 723.413333V682.666667h74.666667a10.666667 10.666667 0 0 0 0-21.333334H192v-40.533333l71.338667 13.098667a10.666667 10.666667 0 1 0 3.84-20.992L192 599.104V128l124.544 136.917333zM853.333333 594.389333V128c0-19.498667-24-28.8-37.12-14.357333l-112.128 123.285333a344.512 344.512 0 0 0-384.149333 0L207.786667 113.578667C194.666667 99.2 170.666667 108.501333 170.666667 128v467.2l-71.338667-13.077333a10.666667 10.666667 0 0 0-3.84 20.992L170.666667 616.896V661.333333H96a10.666667 10.666667 0 0 0 0 21.333334H170.666667v44.288l-75.264 12.522666a10.666667 10.666667 0 1 0 3.498666 21.034667L170.666667 748.586667V896h682.666666v-147.349333l71.658667 12.224a10.666667 10.666667 0 1 0 3.584-21.013334L853.333333 726.997333V682.666667h74.666667a10.666667 10.666667 0 0 0 0-21.333334H853.333333v-44.970666l74.752-18.346667a10.666667 10.666667 0 0 0-5.077333-20.714667L853.333333 594.389333z" fill="#000000" p-id="1483"></path></svg>
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