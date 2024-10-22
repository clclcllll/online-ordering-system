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
<h2>菜品列表</h2>

<c:if test="${not empty dishes}">
    <div class="dish-list">
        <c:forEach var="dish" items="${dishes}">
            <div class="dish-item">
                <a href="${pageContext.request.contextPath}/dish?action=detail&dishID=${dish.dishID}">
                    <img src="${pageContext.request.contextPath}/images/${dish.image}" alt="${dish.name}" width="200">
                </a>
                <h3>${dish.name}</h3>
                <p>价格：￥${dish.price}</p>
                <p>${dish.description}</p>
                <form action="${pageContext.request.contextPath}/cart?action=add" method="get">
                    <input type="hidden" name="dishID" value="${dish.dishID}">
                    <input type="number" name="quantity" value="1" min="1" max="${dish.stock}">
                    <input type="submit" value="加入购物车">
                </form>
            </div>
        </c:forEach>
    </div>
    <!-- 分页导航 -->
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/dish?action=list&pageNum=${currentPage - 1}">上一页</a>
        </c:if>
        <span>第 ${currentPage} 页，共 ${totalPage} 页</span>
        <c:if test="${currentPage < totalPage}">
            <a href="${pageContext.request.contextPath}/dish?action=list&pageNum=${currentPage + 1}">下一页</a>
        </c:if>
    </div>
</c:if>
<%@ include file="footer.jsp" %>
