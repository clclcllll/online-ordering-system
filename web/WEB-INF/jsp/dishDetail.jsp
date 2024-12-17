<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .dish-detail {
        display: flex;
        max-width: 1200px;
        margin: 40px auto;
        background-color: #ffffff;
        border-radius: 10px;
    }

    .dish-image {
        flex: 1;
        max-width: 50%;
    }

    .dish-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 10px 0 0 10px;
    }

    .dish-content {
        flex: 1;
        max-width: 50%;
        padding: 40px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .dish-content h2 {
        font-size: 28px;
        color: #000000;
        margin-bottom: 20px;
        font-weight: bold;
        padding-bottom: 10px;
        border-bottom: 2px solid #000000;
    }

    .dish-info {
        margin-bottom: 30px;
    }

    .dish-info p {
        color: #000000;
        margin: 15px 0;
        font-size: 18px;
        padding-bottom: 5px;
    }

    form {
        display: flex;
        flex-direction: column;
        gap: 15px;
        padding-top: 20px;
        border-top: 1px solid #000000;
    }

    form label {
        font-size: 18px;
        color: #000000;
    }

    form input[type="number"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #000000;
        border-radius: 5px;
        font-size: 16px;
    }

    form input[type="submit"] {
        padding: 12px 20px;
        background: #000000;
        color: #ffffff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.2s;
        font-size: 18px;
        width: 100%;
    }

    form input[type="submit"]:hover {
        background: #333333;
    }

</style>

<div class="dish-detail">
    <c:if test="${not empty dish}">
        <div class="dish-image">
            <img src="${dish.image}" alt="${dish.name}">
        </div>
        <div class="dish-content">
            <div>
                <h2>${dish.name}</h2>
                <div class="dish-info">
                    <p>价格：￥${dish.price}</p>
                    <p>库存：${dish.stock}</p>
                    <p>简介：${dish.description}</p>
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/cart" method="get">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="dishID" value="${dish.dishID}">
                <label for="quantity">数量：</label>
                <input type="number" id="quantity" name="quantity" value="1" min="1" max="${dish.stock}">
                <input type="submit" value="加入购物车">
            </form>
        </div>
    </c:if>
</div>

<%@ include file="footer.jsp" %>

