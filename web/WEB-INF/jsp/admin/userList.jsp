<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>
<h2>用户管理</h2>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>用户ID</th>
        <th>用户名</th>
        <th>邮箱</th>
        <th>电话</th>
        <th>地址</th>
        <th>用户类型</th>
        <th>操作</th>
    </tr>
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
                <a href="${pageContext.request.contextPath}/admin?action=deleteUser&userID=${user.userID}">删除</a>
                <c:choose>
                    <c:when test="${user.userType == 0}">
                        <a href="${pageContext.request.contextPath}/admin?action=setAdmin&userID=${user.userID}">设为管理员</a>
                    </c:when>
                    <c:when test="${user.userType == 1}">
                        <a href="${pageContext.request.contextPath}/admin?action=removeAdmin&userID=${user.userID}">取消管理员</a>
                    </c:when>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>