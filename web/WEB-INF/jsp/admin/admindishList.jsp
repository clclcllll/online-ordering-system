<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>

<style>
    /* 自定义表格样式 */
    .table thead th {
        background-color: rgb(86, 199, 170);
        font-weight: bold;
        color: white;
    }

    .table tbody tr:hover {
        background-color: #f1f1f1;
    }

    .table tbody td {
        padding: 15px; /* 增加内边距 */
    }

    /* 自定义提示信息样式 */
    .alert {
        margin-bottom: 20px;
    }

    /* 页面内容样式 */
    .content {
        margin-left: 00px; /* 与侧边栏宽度相同，避免内容被覆盖 */
        padding: 20px;
    }

    /* 操作链接样式 */
    .action-links a {
        margin-right: 10px;
        text-decoration: none;
        color:#007bff;
    }

    .action-links a:hover {
        text-decoration: underline;
    }
</style>

<div class="content">
    <h2>菜品管理</h2>

    <!-- 显示更新成功的提示 -->
    <c:if test="${not empty sessionScope.successMsg}">
        <div class="alert alert-success" role="alert">
                ${sessionScope.successMsg}
        </div>
        <c:remove var="successMsg" scope="session"/>
    </c:if>

    <!-- 显示错误提示 -->
    <c:if test="${not empty sessionScope.errorMsg}">
        <div class="alert alert-danger" role="alert">
                ${sessionScope.errorMsg}
        </div>
        <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>菜品ID</th>
            <th>名称</th>
            <th>价格</th>
            <th>描述</th>
            <th>库存</th>
            <th>图片</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="dish" items="${dishes}">
            <tr>
                <td>${dish.dishID}</td>
                <td>${dish.name}</td>
                <td>${dish.price}</td>
                <td>${dish.description}</td>
                <td>${dish.stock}</td>
                <td><img src="${pageContext.request.contextPath}/images/${dish.image}" alt="${dish.name}" width="50"></td>
                <td class="action-links">
                    <a href="${pageContext.request.contextPath}/admin?action=editDish&dishID=${dish.dishID}">编辑</a>
                    <a href="${pageContext.request.contextPath}/admin?action=deleteDish&dishID=${dish.dishID}">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <p>
        <a href="${pageContext.request.contextPath}/admin?action=addDish" class="btn btn-primary">添加新菜品</a>
    </p>
</div>
