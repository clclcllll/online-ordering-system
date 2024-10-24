<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    h2 {
        text-align: center;
        margin-top: 20px;
    }

    .order-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
        padding: 20px;
    }

    .order-item {
        background: white;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 20px;
        width: 300px;
        max-width: 100%;
        text-align: left;
    }

    .order-item h3 {
        margin-top: 0;
    }

    .order-item p {
        margin: 5px 0;
    }

    .order-item a {
        display: inline-block;
        margin-top: 10px;
        text-decoration: none;
        color: #007BFF;
        font-weight: bold;
    }

    .order-item a:hover {
        text-decoration: underline;
    }

    .order-item hr {
        border: 0;
        border-top: 1px solid #eee;
        margin: 10px 0;
    }

    .no-orders {
        text-align: center;
        margin: 50px;
        font-size: 18px;
        color: #777;
    }
</style>

<h2>我的订单列表</h2>

<c:if test="${not empty orders}">
    <div class="order-list">
        <c:forEach var="order" items="${orders}">
            <div class="order-item">
                <h3>订单号：${order.orderID}</h3>
                <p>下单日期：<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                <p>总金额：￥${order.totalAmount}</p>
                <p>订单状态：
                    <c:choose>
                        <c:when test="${order.orderStatus == 0}">待支付</c:when>
                        <c:when test="${order.orderStatus == 1}">已支付</c:when>
                        <c:when test="${order.orderStatus == 2}">已完成</c:when>
                        <c:when test="${order.orderStatus == 3}">已取消</c:when>
                    </c:choose>
                </p>

                <!-- 查看详细链接 -->
                <a href="${pageContext.request.contextPath}/order?action=detail&orderID=${order.orderID}">查看详细</a>

                <c:if test="${order.orderStatus == 0}">
                    <a href="${pageContext.request.contextPath}/order?action=pay&orderID=${order.orderID}">去支付</a>
                </c:if>

                <hr />
            </div>
        </c:forEach>
    </div>
</c:if>

<c:if test="${empty orders}">
    <p class="no-orders">您目前没有任何订单。</p>
</c:if>

<%@ include file="footer.jsp" %>