<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>

<style>
    /* 自定义表格样式 */
    .table thead th {
        background-color: rgb(86, 199, 170);
        font-weight: bold;
        color: white;
    }
    .table tbody tr {
        border-bottom: 1px solid #ddd; /* 添加行分割线 */
    }

    .table tbody tr:hover {
        background-color: #f1f1f1;
    }

    .table tbody td {
        padding: 30px; /* 增加内边距 */
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
        color: #007bff;
    }

    .action-links a:hover {
        text-decoration: underline;
    }
</style>

<div class="content">
    <h2>订单管理</h2>

    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>订单ID</th>
            <th>用户ID</th>
            <th>下单日期</th>
            <th>总金额</th>
            <th>订单状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.orderID}</td>
                <td>${order.userID}</td>
                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${order.totalAmount}</td>
                <td>
                    <c:choose>
                        <c:when test="${order.orderStatus == 0}">待支付</c:when>
                        <c:when test="${order.orderStatus == 1}">已支付</c:when>
                        <c:when test="${order.orderStatus == 2}">已完成</c:when>
                        <c:when test="${order.orderStatus == 3}">已取消</c:when>
                    </c:choose>
                </td>
                <td class="action-links">
                    <a href="${pageContext.request.contextPath}/admin?action=viewOrder&orderID=${order.orderID}">查看</a>
                    <a href="${pageContext.request.contextPath}/admin?action=deleteOrder&orderID=${order.orderID}">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>


