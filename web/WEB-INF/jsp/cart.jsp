<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    body {
        background: #ffffff;
        color: #333;
        font-family: 'Arial', sans-serif;
    }

    .content {
        display: flex;
        justify-content: center;
        align-items: flex-start;
        min-height: calc(100vh - 100px);
    }

    .cart-container {
        background: #ffffff;
        padding: 10px;
        border-radius: 8px;
        max-width: 900px;
        width: 100%;
    }

    .cart-container h2 {
        margin-bottom: 30px;
        font-size: 28px;
        color: #000;
        text-align: center;
        font-weight: 600;
    }

    .cart-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 10px;
    }

    .cart-table th {
        background-color: #f0f0f0;
        color: #333;
        font-weight: 600;
        padding: 15px;
        text-transform: uppercase;
        font-size: 14px;
        letter-spacing: 0.5px;
    }

    .cart-table td {
        background-color: #fff;
        padding: 15px;
        vertical-align: middle;
        border-top: 1px solid #e0e0e0;
        border-bottom: 1px solid #e0e0e0;
    }

    .cart-table tr td:first-child {
        border-left: 1px solid #e0e0e0;
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
    }

    .cart-table tr td:last-child {
        border-right: 1px solid #e0e0e0;
        border-top-right-radius: 5px;
        border-bottom-right-radius: 5px;
    }

    .cart-table input[type="number"] {
        width: 60px;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        text-align: center;
    }

    .btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #000;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .btn:hover {
        background-color: #333;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }

    .btn-remove {
        background-color: #ff4444;
        padding: 8px 15px;
        font-size: 12px;
    }

    .btn-remove:hover {
        background-color: #cc0000;
    }

    .cart-summary {
        margin-top: 30px;
        text-align: right;
        font-size: 18px;
        font-weight: 600;
    }

    .cart-actions {
        display: flex;
        justify-content: space-between;
        margin-top: 30px;
    }

    .empty-cart {
        text-align: center;
        padding: 40px 0;
        font-size: 18px;
        color: #666;
    }

    .footer {
        background: #000;
        color: #fff;
        text-align: center;
        padding: 20px 0;
        font-size: 14px;
    }
</style>

<div class="content">
    <div class="cart-container">
        <h3>我的购物车</h3>

        <c:if test="${cart != null && not empty cart}">
            <form action="${pageContext.request.contextPath}/cart?action=update" method="post">
                <table class="cart-table">
                    <thead>
                    <tr>
                        <th>菜品名称</th>
                        <th>价格</th>
                        <th>数量</th>
                        <th>小计</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${cart.values()}">
                        <tr>
                            <td>${item.dish.name}</td>
                            <td>￥${item.dish.price}</td>
                            <td>
                                <input type="number" name="quantity_${item.dish.dishID}" value="${item.quantity}" min="1" max="${item.dish.stock}">
                            </td>
                            <td>￥${item.dish.price * item.quantity}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/cart?action=remove&dishID=${item.dish.dishID}" class="btn btn-remove">移除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="cart-summary">
                    总金额：￥${totalAmount}
                </div>

                <div class="cart-actions">
                    <input type="submit" value="更新购物车" class="btn">
                    <a href="${pageContext.request.contextPath}/order?action=create" class="btn">去结算</a>
                </div>
            </form>
        </c:if>
        <c:if test="${cart == null || empty cart}">
            <div class="empty-cart">
                <p>您的购物车为空。</p>
                <a href="${pageContext.request.contextPath}/dish?action=list" class="btn">继续购物</a>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="footer.jsp" %>

