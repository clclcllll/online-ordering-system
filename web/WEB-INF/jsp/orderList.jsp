<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    .order-list {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px; /* 增加内边距 */
        background: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .order-item {
        margin-bottom: 30px; /* 增加间距 */
        padding: 30px; /* 增加内边距 */
        background: #f9f9f9;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .order-item h3 {
        color: #333;
        margin: 0 0 15px;
        font-size: 20px;
    }

    .order-item p {
        color: #666;
        margin: 5px 0;
        font-size: 16px;
    }

    .order-item table {
        width: 100%; /* 使表格占据整个容器宽度 */
        border-collapse: collapse;
        margin-top: 15px;
    }

    .order-item th, .order-item td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
    }

    .order-item th {
        background: #f1f1f1;
    }

    .order-item a {
        display: inline-block;
        padding: 10px 20px;
        margin-top: 10px;
        background: #007BFF;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: background 0.2s, box-shadow 0.2s;
    }

    .order-item a:hover {
        background: #0056b3;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    }

    .order-item hr {
        border: 0;
        height: 1px;
        background: #ddd;
        margin: 20px 0;
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

                <h4>订单明细：</h4>
                <table>
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

                <hr />
            </div>
        </c:forEach>
    </div>
</c:if>

<c:if test="${empty orders}">
    <p>您目前没有任何订单。</p>
</c:if>

<%@ include file="footer.jsp" %>