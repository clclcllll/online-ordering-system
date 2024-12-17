<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* 保持与 dishList.jsp 相同的CSS样式 */
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background: rgba(255, 255, 255, 0.9); /* 半透明背景 */
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #333;
        margin-top: 20px;
    }

    .dish-list {
        display: flex;
        flex-wrap: wrap; /* 允许换行 */
        gap: 20px;
        margin-top: 20px;
    }

    .dish-item {
        flex: 1 1 250px; /* 每个 item 最小宽度为 250px */
        background: rgba(255, 255, 255, 0.8);
        border-radius: 2px;

        /*边框*/
        border: 1px solid #e8e8e8;
        overflow: hidden;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .dish-item:hover {
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
    }

    .dish-item img {
        width: 100%;
        height: 200px;
        object-fit: cover;
        object-position: center;
        display: block;
    }

    .dish-item h3 {
        margin: 10px 0;
        color: #333;
    }

    .dish-item p {
        margin: 5px 0;
        color: #666;
    }

    .dish-item form {
        margin: 10px 0;
        text-align: center;
    }

    .dish-item input[type="number"] {
        width: 50px;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .dish-item input[type="submit"] {
        padding: 10px 20px;
        background: #000000;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 10px;
        transition: background 0.2s;
    }

    .dish-item input[type="submit"]:hover {
        background: #535353;
    }

    .pagination {
        text-align: center;
        margin-top: 20px;
    }

    .pagination a {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 5px;
        background: #000000;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .pagination a:hover {
        background: #535353;
    }

    .pagination span {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 5px;
        color: #333;
    }
</style>

<div class="container">
    <h2>搜索结果</h2>

    <!-- 调试信息：显示传递过来的请求属性 -->
    <c:if test="${not empty searchKeyword}">
        <p>搜索关键词: ${searchKeyword}</p>
    </c:if>
    <c:if test="${not empty currentPage}">
        <p>当前页码: ${currentPage}</p>
    </c:if>
    <c:if test="${not empty totalPage}">
        <p>总页数: ${totalPage}</p>
    </c:if>
    <c:if test="${not empty dishes}">
        <p>找到菜品数量: ${dishes.size()}</p>
    </c:if>

    <!-- 判断是否有 successMsg 并弹出提示 -->
<%--    <c:if test="${not empty successMsg}">--%>
<%--        <script>--%>
<%--            alert("${successMsg}");--%>
<%--        </script>--%>
<%--    </c:if>--%>

    <!-- 显示搜索关键词 -->
    <c:if test="${not empty searchKeyword}">
        <p style="text-align: center; color: #333;">搜索结果：<strong>${searchKeyword}</strong></p>
    </c:if>

    <c:if test="${not empty dishes}">
        <div class="dish-list">
            <c:forEach var="dish" items="${dishes}">
                <div class="dish-item">
                    <a href="${pageContext.request.contextPath}/dish?action=detail&dishID=${dish.dishID}">
                        <img src="${dish.image}" alt="${dish.name}" width="200" class="dishimage">
                    </a>
                    <h3>${dish.name}</h3>
                    <p>价格：￥${dish.price}</p>
                    <p>${dish.description}</p>
                    <form action="${pageContext.request.contextPath}/cart" method="get">
                        <input type="text" name="action" value="add" style="display: none;">
                        <input type="hidden" name="dishID" value="${dish.dishID}">
                        <input type="number" name="quantity" value="1" min="1" max="${dish.stock}">
                        <input type="submit" value="加入购物车">
                    </form>
                </div>
            </c:forEach>
        </div>
<%--        <!-- 分页导航 -->--%>
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/dish?action=search&pageNum=${currentPage - 1}&keyword=${searchKeyword}">上一页</a>
            </c:if>
            <span>第 ${currentPage} 页，共 ${totalPage} 页</span>
            <c:if test="${currentPage < totalPage}">
                <a href="${pageContext.request.contextPath}/dish?action=search&pageNum=${currentPage + 1}&keyword=${searchKeyword}">下一页</a>
            </c:if>
        </div>
    </c:if>

    <!-- 如果没有搜索结果，显示提示信息 -->
    <c:if test="${empty dishes && not empty searchKeyword}">
        <p style="text-align: center; color: #333;">未找到与 "<strong>${searchKeyword}</strong>" 相关的菜品。</p>
    </c:if>
</div>

<%@ include file="footer.jsp" %>