<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>
<h2>订单管理</h2>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>订单ID</th>
        <th>用户ID</th>
        <th>下单日期</th>
        <th>总金额</th>
        <th>订单状态</th>
        <th>操作</th>
    </tr>
    <c:forEach var="order" items="${orders}">
        <tr>
            <td>${order.orderID}</td>
            <td>${order.userID}</td>
            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${order.totalAmount}</td>
            <td>
                <c:choose>
                    <c:when test="${order.orderStatus == 0}">待支付</c:when>
                    <c:when test="${order.orderStatus == 1}">已支付</c:when>
                    <c:when test="${order.orderStatus == 2}">已完成</c:when>
                    <c:when test="${order.orderStatus == 3}">已取消</c:when>
                </c:choose>
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/admin?action=viewOrder&orderID=${order.orderID}">查看</a>
                <a href="${pageContext.request.contextPath}/admin?action=deleteOrder&orderID=${order.orderID}">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>


