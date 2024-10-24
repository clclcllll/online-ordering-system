<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/24
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<h2>订单详情</h2>

<c:if test="${not empty order}">
    <p>订单号：${order.orderID}</p>
    <p>下单日期：<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
    <p>总金额：￥${order.totalAmount}</p>
    <p>订单状态：<c:choose>
        <c:when test="${order.orderStatus == 0}">待支付</c:when>
        <c:when test="${order.orderStatus == 1}">已支付</c:when>
        <c:when test="${order.orderStatus == 2}">已完成</c:when>
        <c:when test="${order.orderStatus == 3}">已取消</c:when>
    </c:choose></p>

    <h3>订单明细：</h3>
    <table border="1" cellpadding="5" cellspacing="0">
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

    <hr />
    <a href="${pageContext.request.contextPath}/admin?action=orderList">返回订单列表</a>
</c:if>

<c:if test="${empty order}">
    <p>未找到该订单的详细信息。</p>
</c:if>

<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>

