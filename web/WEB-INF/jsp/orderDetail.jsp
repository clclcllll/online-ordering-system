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

    h2, h3 {
        text-align: center;
        margin-top: 20px;
    }

    .order-container {
        background: white;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 30px;
        max-width: 900px; /* 增大宽度 */
        margin: 40px auto; /* 增加上下边距 */
        text-align: left;
    }

    .order-container p {
        margin: 10px 0; /* 增加行间距 */
    }

    .order-container a {
        display: inline-block;
        margin-top: 10px;
        text-decoration: none;
        color: #007BFF;
        font-weight: bold;
    }

    .order-container a:hover {
        text-decoration: underline;
    }

    .order-container hr {
        border: 0;
        border-top: 1px solid #eee;
        margin: 20px 0; /* 增加边距 */
    }

    .order-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .order-table th, .order-table td {
        padding: 15px; /* 增加内边距 */
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .order-table th {
        background-color: #f8f8f8;
        font-weight: bold;
    }

    .no-order {
        text-align: center;
        margin: 50px;
        font-size: 18px;
        color: #777;
    }
</style>

<h2>订单详情</h2>

<c:if test="${not empty order}">
    <div class="order-container">
        <p>订单号：${order.orderID}</p>
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

        <h3>订单明细：</h3>
        <table class="order-table">
            <tr>
                <th>菜品名称</th>
                <th>价格</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
            <c:forEach var="item" items="${order.orderItems}">
                <tr>
                    <td>${item.dish.name}</td>
                    <td>￥${item.dish.price}</td>
                    <td>${item.quantity}</td>
                    <td>￥${item.subtotal}</td>
                </tr>
            </c:forEach>
        </table>

        <c:if test="${order.orderStatus == 0}">
            <a href="${pageContext.request.contextPath}/order?action=pay&orderID=${order.orderID}">去支付</a>
        </c:if>
    </div>
</c:if>

<c:if test="${empty order}">
    <p class="no-order">订单不存在或无法访问。</p>
</c:if>

<%@ include file="footer.jsp" %>