<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<h2>支付订单</h2>

<c:if test="${not empty order}">
    <p>订单号：${order.orderID}</p>
    <p>总金额：￥${order.totalAmount}</p>
    <p>请确认支付。</p>
    <form action="${pageContext.request.contextPath}/order?action=pay" method="post">
        <input type="hidden" name="orderID" value="${order.orderID}">
        <input type="submit" value="确认支付">
    </form>
</c:if>

<%@ include file="footer.jsp" %>

