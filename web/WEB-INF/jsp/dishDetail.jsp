<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .dish-detail {
        max-width: 1200px; /* 增大容器宽度 */
        margin: 0 auto;
        padding: 40px; /* 增加内边距 */
        background: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .dish-detail img {
        max-width: 100%;
        height: auto;
        border-radius: 10px;
        margin-bottom: 40px; /* 增加图片与标题之间的间距 */
    }

    .dish-detail h3 {
        color: #333;
        margin: 0 0 20px; /* 增加标题与信息之间的间距 */
        font-size: 24px;
    }

    .dish-detail p {
        color: #666;
        margin: 10px 0;
        font-size: 16px;
    }

    .dish-detail form {
        margin-top: 40px; /* 增加表单与信息之间的间距 */
    }

    .dish-detail input[type="number"] {
        width: 70px; /* 增加输入框宽度 */
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-right: 20px;
    }

    .dish-detail input[type="submit"] {
        padding: 15px 30px;
        background: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.2s;
        font-size: 18px;
    }

    .dish-detail input[type="submit"]:hover {
        background: #0056b3;
    }

    .dish-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 30px 0; /* 增加信息区域的上下间距 */
    }

    .dish-info div {
        flex: 1;
        text-align: left;
    }

    .dish-info div:first-child {
        text-align: right;
    }

    .dish-info p {
        margin: 10px 0;
    }

    .dish-description {
        margin-top: 30px; /* 增加描述与信息之间的间距 */
    }
</style>

<h2 style="text-align: center">菜品详情</h2>

<c:if test="${not empty dish}">
    <div class="dish-detail">
        <img src="${dish.image}" alt="${dish.name}" width="300">
        <h3>${dish.name}</h3>
        <div class="dish-info">
            <div style="text-align: left;">
                <p>价格：￥${dish.price}</p>
                <p>库存：${dish.stock}</p>
                <p>简介：${dish.description}</p><br /><br />
            </div>
        </div>
        <form action="${pageContext.request.contextPath}/cart" method="get">
            <input type="text" name="action" value="add" style="display: none;">
            <input type="hidden" name="dishID" value="${dish.dishID}">
            <input type="number" name="quantity" value="1" min="1" max="${dish.stock}">
            <input type="submit" value="加入购物车">
        </form>
    </div>
</c:if>

<%@ include file="footer.jsp" %>