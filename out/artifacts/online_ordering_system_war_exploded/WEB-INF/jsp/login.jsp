<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<h2>用户登录</h2>

<c:if test="${not empty errorMsg}">
    <div class="alert alert-danger">${errorMsg}</div>
</c:if>

<form action="${pageContext.request.contextPath}/login" method="post">
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
                <a href="${pageContext.request.contextPath}/register">注册新用户</a>
            </td>
        </tr>
    </table>
</form>
<%@ include file="footer.jsp" %>
