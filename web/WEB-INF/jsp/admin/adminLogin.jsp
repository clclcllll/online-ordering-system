<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/24
  Time: 00:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>
<h2>管理员登录</h2>

<!-- 显示错误提示 -->
<c:if test="${not empty errorMsg}">
    <div class="alert alert-danger">${errorMsg}</div>
</c:if>

<form action="${pageContext.request.contextPath}/admin" method="post">
    <input type="hidden" name="action" value="login">
    <table>
        <tr>
            <td>用户名：</td>
            <td><input type="text" name="username" required></td>
        </tr>
        <tr>
            <td>密码：</td>
            <td><input type="password" name="password" required></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="登录">
            </td>
        </tr>
    </table>
</form>
<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>
