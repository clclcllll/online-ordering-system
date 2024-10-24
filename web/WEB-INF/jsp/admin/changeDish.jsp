<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>

<c:if test="${not empty errorMsg}">
    <script>
        alert("${errorMsg}");
    </script>
</c:if>


<h2><c:choose>
    <c:when test="${not empty dish}">编辑菜品</c:when>
    <c:otherwise>添加新菜品</c:otherwise>
</c:choose></h2>

<form action="${pageContext.request.contextPath}/admin?action=saveDish" method="post">
    <table>
        <c:if test="${not empty dish}">
            <!-- 如果是编辑菜品，隐藏菜品ID字段 -->
            <input type="hidden" name="dishID" value="${dish.dishID}">
        </c:if>

        <tr>
            <td>名称：</td>
            <td><input type="text" name="name" value="${dish.name}" required></td>
        </tr>
        <tr>
            <td>价格：</td>
            <td><input type="number" name="price" step="0.01" value="${dish.price}" required></td>
        </tr>
        <tr>
            <td>描述：</td>
            <td><textarea name="description" rows="5" cols="30">${dish.description}</textarea></td>
        </tr>
        <tr>
            <td>库存：</td>
            <td><input type="number" name="stock" value="${dish.stock}" required></td>
        </tr>
<%--        <tr>--%>
<%--            <td>图片：</td>--%>
<%--            <td><input type="file" name="image" accept="image/*" <c:if test="${empty dish}">required</c:if>></td>--%>
<%--        </tr>--%>
        <c:if test="${not empty dish.image}">
            <!-- 如果是编辑模式，显示当前图片 -->
            <tr>
                <td>当前图片：</td>
                <td><img src="${pageContext.request.contextPath}/images/${dish.image}" alt="${dish.name}" width="100"></td>
            </tr>
        </c:if>
        <tr>
            <td colspan="2">
                <input type="submit" value="<c:choose>
                    <c:when test='${not empty dish}'>更新</c:when>
                    <c:otherwise>添加</c:otherwise>
                </c:choose>">
                <input type="reset" value="重置">
            </td>
        </tr>
    </table>
</form>

<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>
