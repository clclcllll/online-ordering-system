<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>

<h2>菜品管理</h2>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>菜品ID</th>
        <th>名称</th>
        <th>价格</th>
        <th>描述</th>
        <th>库存</th>
        <th>图片</th>
        <th>操作</th>
    </tr>
    <c:forEach var="dish" items="${dishes}">
        <tr>
            <td>${dish.dishID}</td>
            <td>${dish.name}</td>
            <td>${dish.price}</td>
            <td>${dish.description}</td>
            <td>${dish.stock}</td>
            <td><img src="${pageContext.request.contextPath}/images/${dish.image}" alt="${dish.name}" width="50"></td>
            <td>
                <a href="${pageContext.request.contextPath}/admin?action=editDish&dishID=${dish.dishID}">编辑</a>
                <a href="${pageContext.request.contextPath}/admin?action=deleteDish&dishID=${dish.dishID}">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
<p>
    <a href="${pageContext.request.contextPath}/admin?action=addDish">添加新菜品</a>
</p>

<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>
