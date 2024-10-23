<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background: url('${pageContext.request.contextPath}/images/background.jpg') no-repeat center center fixed;
        background-size: cover;
        height: 100vh;
        display: flex;
        flex-direction: column;
        position: relative; /* 确保 body 是相对定位 */
    }

    .navbar {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        background: rgba(255, 255, 255, 0.8);
        padding: 10px;
        text-align: center;
        z-index: 1000; /* 确保导航栏在背景图片之上 */
    }

    .navbar a, .navbar span {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 5px;
        background: #007BFF;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .navbar a:hover, .navbar span:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
    }

    .navbar a:active, .navbar span:active {
        transform: translateY(2px);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    hr {
        margin: 10px 0;
    }

    .content {
        flex: 1;
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

    .footer {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        background: rgba(255, 255, 255, 0.8);
        padding: 10px;
        text-align: center; /* 确保文本居中 */
        z-index: 1000; /* 确保脚注在背景图片之上 */
        color: #333; /* 深灰色文字 */
    }

    .footer p {
        margin: 0; /* 移除默认的段落间距 */
    }
</style>

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