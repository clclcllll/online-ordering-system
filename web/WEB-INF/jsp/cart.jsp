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

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background: url('${pageContext.request.contextPath}/images/cartbackground.jpg') no-repeat center center fixed;
        background-size: cover;
        height: 100vh;
        display: flex;
        flex-direction: column;
        position: relative; /* 确保 body 是相对定位 */
    }

    .navbar {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        background: rgba(255, 255, 255, 0.8);
        padding: 10px;
        text-align: center;
        z-index: 1000; /* 确保导航栏在背景图片之上 */
    }

    .navbar a, .navbar span {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 5px;
        background: #007BFF;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .navbar a:hover, .navbar span:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
    }

    .navbar a:active, .navbar span:active {
        transform: translateY(2px);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    hr {
        margin: 10px 0;
    }

    .content {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .cart-container {
        background: rgba(255, 255, 255, 0.8);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        max-width: 800px;
        width: 100%;
    }

    .cart-container h2 {
        margin-bottom: 20px;
    }

    .cart-container table {
        width: 100%;
        border-collapse: collapse;
        margin: 0 auto;
    }

    .cart-container th, .cart-container td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: center;
    }

    .cart-container th {
        background-color: #f8f8f8;
        font-weight: bold;
    }

    .cart-container input[type="number"] {
        width: 50px;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .cart-container a {
        display: inline-block;
        padding: 5px 10px;
        margin: 5px;
        background-color: #007BFF;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .cart-container a:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
    }

    .cart-container a:active {
        transform: translateY(2px);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .cart-container input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 20px;
    }

    .cart-container input[type="submit"]:hover {
        background-color: #0056b3;
    }

    .footer {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        background: rgba(255, 255, 255, 0.8);
        padding: 10px;
        text-align: center; /* 确保文本居中 */
        z-index: 1000; /* 确保脚注在背景图片之上 */
        color: #333; /* 深灰色文字 */
    }

    .footer p {
        margin: 0; /* 移除默认的段落间距 */
    }
</style>

<div class="content">
    <div class="cart-container">
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
    </div>
</div>

<%@ include file="footer.jsp" %>
