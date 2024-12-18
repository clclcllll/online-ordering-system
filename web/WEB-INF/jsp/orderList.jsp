<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    .order-table-container {
        padding: 20px;
        overflow-x: auto;
    }

    .order-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .order-table th, .order-table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }

    .order-table th {
        background-color: #f2f2f2;
        font-weight: bold;
    }

    .order-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .order-table tr:hover {
        background-color: #f5f5f5;
    }

    .order-table a {
        text-decoration: none;
        color: #007BFF;
        margin-right: 10px;
    }

    .order-table a:hover {
        text-decoration: underline;
    }

    .no-orders {
        text-align: center;
        margin: 50px;
        font-size: 18px;
        color: #777;
    }
</style>

<div class="order-table-container">
    <c:if test="${not empty orders}">
        <table class="order-table">
            <thead>
            <tr>
                <th>订单号</th>
                <th>下单日期</th>
                <th>总金额</th>
                <th>订单状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.orderID}</td>
                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>￥${order.totalAmount}</td>
                    <td>
                        <c:choose>
                            <c:when test="${order.orderStatus == 0}">待支付</c:when>
                            <c:when test="${order.orderStatus == 1}">已支付</c:when>
                            <c:when test="${order.orderStatus == 2}">已完成</c:when>
                            <c:when test="${order.orderStatus == 3}">已取消</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/order?action=detail&orderID=${order.orderID}">查看详细</a>
                        <c:if test="${order.orderStatus == 0}">
                            <a href="${pageContext.request.contextPath}/order?action=pay&orderID=${order.orderID}">去支付</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty orders}">
        <p class="no-orders">您目前没有任何订单。</p>
    </c:if>
</div>

<%@ include file="footer.jsp" %>

