<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

<%--                <h4>订单明细：</h4>--%>
<%--                <table border="1" cellpadding="5" cellspacing="0">--%>
<%--                    <tr>--%>
<%--                        <th>菜品名称</th>--%>
<%--                        <th>价格</th>--%>
<%--                        <th>数量</th>--%>
<%--                        <th>小计</th>--%>
<%--                    </tr>--%>
<%--                    <c:forEach var="item" items="${order.orderItems}">--%>
<%--                        <tr>--%>
<%--                            <td>${item.dish.name}</td>--%>
<%--                            <td>￥${item.dish.price}</td>--%>
<%--                            <td>${item.quantity}</td>--%>
<%--                            <td>￥${item.subtotal}</td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                </table>--%>

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
    <p>您目前没有任何订单。</p>
</c:if>

<%@ include file="footer.jsp" %>


