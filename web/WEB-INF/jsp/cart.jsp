<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>我的购物车</h2>

<c:if test="${cart != null && not empty cart}">
    <form action="${pageContext.request.contextPath}/cart?action=update" method="post">
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>菜品名称</th>
                <th>价格</th>
                <th>数量</th>
                <th>小计</th>
                <th>操作</th>
            </tr>
            <c:forEach var="item" items="${cart.values()}">
                <tr>
                    <td>${item.dish.name}</td>
                    <td>￥${item.dish.price}</td>
                    <td>
                        <input type="number" name="quantity_${item.dish.dishID}" value="${item.quantity}" min="1" max="${item.dish.stock}">
                    </td>
                    <td>￥${item.dish.price * item.quantity}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/cart?action=remove&dishID=${item.dish.dishID}">移除</a>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="3">总金额：</td>
                <td colspan="2">￥${totalAmount}</td>
            </tr>
        </table>
        <input type="submit" value="更新购物车">
        <a href="${pageContext.request.contextPath}/order?action=create">去结算</a>
    </form>
</c:if>
<c:if test="${cart == null || empty cart}">
    <p>您的购物车为空。</p>
</c:if>
<%@ include file="footer.jsp" %>


