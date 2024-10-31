<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:33
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
        padding: 40px; /* 增加内边距 */
    }

    /* 自定义按钮样式 */
    .btn-sm {
        padding: 5px 10px;
        font-size: 12px;
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
</style>

<div class="content">
    <h2>用户管理</h2>

    <%-- 成功提示 --%>
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success" role="alert">
                ${successMsg}
        </div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>用户ID</th>
            <th>用户名</th>
            <th>邮箱</th>
            <th>电话</th>
            <th>地址</th>
            <th>用户类型</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.userID}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.address}</td>
                <td>
                    <c:choose>
                        <c:when test="${user.userType == 0}">普通用户</c:when>
                        <c:when test="${user.userType == 1}">管理员</c:when>
                    </c:choose>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin?action=deleteUser&userID=${user.userID}" class="btn btn-danger btn-sm">删除</a>
                    <c:choose>
                        <c:when test="${user.userType == 0}">
                            <a href="${pageContext.request.contextPath}/admin?action=setAdmin&userID=${user.userID}" class="btn btn-primary btn-sm">设为管理员</a>
                        </c:when>
                        <c:when test="${user.userType == 1}">
                            <a href="${pageContext.request.contextPath}/admin?action=removeAdmin&userID=${user.userID}" class="btn btn-warning btn-sm">取消管理员</a>
                        </c:when>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
