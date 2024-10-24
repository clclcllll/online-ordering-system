<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>

    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh; /* 至少占据视口的高度 */
        margin: 0; /* 移除默认的边距 */
    }
    .navbar {
        color: #ffffff;
        justify-content: center;
        align-items: center;
        display: flex;
        background: rgb(78, 171, 255);
        height: 7vh;
    }

    .name{
        font-size: 30px;
        fontfamily: STSong;
        padding-right: 3vw
    }

    .content {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-container {
        background: rgba(255, 255, 255, 0.8);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        max-width: 400px;
        width: 100%;
    }

    .login-container h2 {
        margin-bottom: 20px;
    }

    .login-container .alert {
        margin-bottom: 20px;
    }

    .login-container table {
        margin: 0 auto;
    }

    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .login-container input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .login-container input[type="submit"]:hover {
        background-color: #0056b3;
    }

    .login-container a {
        display: block;
        margin-top: 10px;
        text-decoration: none;
        color: #007BFF;
    }

</style>

<div class="navbar" style="display: flex;">
    <div class="name">网上订餐系统</div>
</div>

<div class="content">
    <div class="login-container">
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
    </div>
</div>

<%@ include file="footer.jsp" %>