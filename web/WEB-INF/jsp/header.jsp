<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>网上订餐系统</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }

        .navbar {
            color: #292929;
            justify-content: center;
            align-items: center;
            display: flex;
            background: #f1f3f5;
            height: 7vh;
        }

        /* 原始导航栏样式 */
        .navbar a {
            margin-right: 10px;
            margin-left: 10px;
            width: 80px;
            height: 26px;
            font-size: 18px;
            color: #292929;
            font-family: inherit;
            font-weight: 800;
            cursor: pointer;
            position: relative;
            border: none;
            background: none;
            text-transform: uppercase;
            display: flex;
            justify-content: center;
            align-items: center;
            text-decoration: none;
            transition-timing-function: cubic-bezier(0.25, 0.8, 0.25, 1);
            transition-duration: 400ms;
            transition-property: color;
        }

        /* 悬浮效果 */
        .navbar a:focus, .navbar a:hover {
            color: #292929;
        }

        /* 普通的下划线悬浮效果 */
        .navbar a:after {
            content: "";
            pointer-events: none;
            bottom: -2px;
            left: 50%;
            position: absolute;
            width: 0%;
            height: 2px;
            background-color: #292929;
            transition-timing-function: cubic-bezier(0.25, 0.8, 0.25, 1);
            transition-duration: 400ms;
            transition-property: width, left;
        }

        .navbar a:hover:after {
            width: 100%;
            left: 0;
        }

        /* 选中状态：继承原样式 + 下划线 */
        .navbar a.active {
            color: #292929; /* 保持原颜色 */
            font-weight: 800; /* 保持加粗 */
            position: relative; /* 确保下划线相对父元素定位 */
        }

        /* active 状态额外下划线 */
        .navbar a.active:after {
            content: "";
            position: absolute;
            bottom: -2px; /* 下划线位置 */
            left: 0;
            width: 100%; /* 全宽 */
            height: 2px; /* 下划线高度 */
            background-color: #292929; /* 下划线颜色与文字一致 */
        }


        .name {
            font-size: 30px;
            font-family: "华文中宋", STSong;
            padding-right: 3vw;
        }

        .logo {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }

        /* 消息图标和红点样式 */
        .message-icon {
            position: relative;
            font-size: 22px;
        }

        .message-icon .notification-dot {
            position: absolute;
            top: -5px;
            right: -5px;
            width: 12px;
            height: 12px;
            background-color: red;
            border-radius: 50%;
            color: white;
            font-size: 10px;
            text-align: center;
        }

        .separator {
            height: 17px;
            width: 4.16px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <svg t="1730303952183" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1014" width="30" height="30">
        <path d="M170.666667 410.538667V127.786667c0-19.328 24.106667-28.48 37.184-14.101334l112.064 123.178667a344.490667 344.490667 0 0 1 384.149333 0l112.085333-123.178667C829.226667 99.328 853.333333 108.48 853.333333 127.786667V896H170.666667V410.538667z" fill="#F7DBB0" p-id="1015"></path>
        <path d="M170.666667 413.781333V128.042667c0-19.541333 24.106667-28.8 37.184-14.272l112.064 124.522666a341.205333 341.205333 0 0 1 61.461333-33.194666C422.784 187.946667 499.2 192 544 192c0 0-48.298667 163.968-106.666667 256-70.058667 110.464-192 181.333333-266.666666 202.666667V413.781333z" fill="#BF7722" p-id="1016"></path>
        <path d="M853.333333 413.781333V128.042667c0-19.541333-24.106667-28.8-37.184-14.272l-112.064 124.522666a341.184 341.184 0 0 0-61.461333-33.194666C601.216 187.946667 524.8 192 480 192c0 0 48.298667 163.968 106.666667 256 70.058667 110.442667 192 181.333333 266.666666 202.666667V413.781333z" fill="#BF7722" p-id="1017"></path>
    </svg>

    <div class="name">网上订餐系统</div>
    <span style="padding-right: 0.5vw">欢迎，${sessionScope.user.username}</span>

    <%
        String uri = request.getRequestURI(); // 获取请求路径，如 /lcy/dish 或 /lcy/order
        String action = request.getParameter("action");
    %>


    <a href="${pageContext.request.contextPath}/dish?action=index"
       class="${param.action == 'index' ? 'active' : ''}">首页</a>
    <span class="separator">|</span>
    <a href="${pageContext.request.contextPath}/dish?action=list"
       class="${param.action == 'list' && pageContext.request.requestURI.contains('/dish') ? 'active' : ''}">菜品列表</a>
    <span class="separator">|</span>
    <a href="${pageContext.request.contextPath}/cart?action=view"
       class="${param.action == 'view' ? 'active' : ''}">购物车</a>
    <span class="separator">|</span>
    <a href="${pageContext.request.contextPath}/order?action=list"
       class="${param.action == 'list' && pageContext.request.requestURI.contains('/order') ? 'active' : ''}">我的订单</a>



    <!-- 消息图标 -->
    <c:choose>
        <c:when test="${not empty sessionScope.messages and sessionScope.hasNewMessages}">
            <!-- 显示有新消息的红点 -->
            <a href="${pageContext.request.contextPath}/messages" class="message-icon">
                <span>🔔</span>
                <span class="notification-dot">●</span>
            </a>
        </c:when>
        <c:otherwise>
            <!-- 显示普通警报器图标 -->
            <a href="${pageContext.request.contextPath}/messages" class="message-icon">
                <span>🔔</span>
            </a>
        </c:otherwise>
    </c:choose>


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
</body>
</html>
