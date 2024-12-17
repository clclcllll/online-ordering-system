<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
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
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }

        .register-container h2 {
            margin-bottom: 20px;
        }

        .register-container .alert {
            margin-bottom: 20px;
        }

        .register-container table {
            margin: 0 auto;
        }

        .register-container input[type="text"],
        .register-container input[type="password"],
        .register-container input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .register-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .register-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .register-container a {
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
    <div class="register-container">
        <h2>用户注册</h2>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger">${errorMsg}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <table>
                <tr>
                    <td>用户名：</td>
                    <td><input type="text" name="username" placeholder="请输入英文或数字" required></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" name="password" placeholder="请输入不小于6位的英文或数字" required></td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td><input type="password" name="confirmPassword" placeholder="请确认密码" required></td>
                </tr>
                <tr>
                    <td>邮箱：</td>
                    <td><input type="email" name="email" placeholder="请输入真实邮箱" required></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="注册">
                        <a href="${pageContext.request.contextPath}/login">已有账号？登录</a>
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