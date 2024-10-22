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
<h2>菜品详情</h2>

<c:if test="${not empty dish}">
    <div class="dish-detail">
        <img src="${pageContext.request.contextPath}/images/${dish.image}" alt="${dish.name}" width="300">
        <h3>${dish.name}</h3>
        <p>价格：￥${dish.price}</p>
        <p>库存：${dish.stock}</p>
        <p>${dish.description}</p>
        <form action="${pageContext.request.contextPath}/cart?action=add" method="get">
            <input type="hidden" name="dishID" value="${dish.dishID}">
            <input type="number" name="quantity" value="1" min="1" max="${dish.stock}">
            <input type="submit" value="加入购物车">
        </form>
    </div>
</c:if>
<%@ include file="footer.jsp" %>
