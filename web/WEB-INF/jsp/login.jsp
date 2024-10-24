<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
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

        .content {
            flex-grow: 1; /* 占据剩余空间 */
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
            color: #ffffff;
            background: rgb(78, 171, 255);
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center;     /* 垂直居中 */
            height: 60px;            /* 固定高度，可以根据需要调整 */
        }
    </style>
</head>
<body>
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
<footer class="footer">
    <p>&copy; 2024 网上订餐系统. All rights reserved.</p>
</footer>
<!-- 引入 JavaScript -->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>