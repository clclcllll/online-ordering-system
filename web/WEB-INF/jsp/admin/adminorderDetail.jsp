<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/24
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    /* 自定义表格样式 */
    .table thead th {
        background-color: rgb(86, 199, 170);
        font-weight: bold;
    }

    .table tbody tr:hover {
        background-color: #f1f1f1;
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

    /* 订单信息样式 */
    .order-info p {
        margin: 5px 0;
    }

    .order-info h3 {
        margin-top: 20px;
    }
</style>

<div class="content">
    <h2>订单详情</h2>

    <c:if test="${not empty order}">
        <div class="order-info">
            <p>订单号：${order.orderID}</p>
            <p>下单日期：<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
            <p>总金额：￥${order.totalAmount}</p>
            <p>订单状态：<c:choose>
                <c:when test="${order.orderStatus == 0}">待支付</c:when>
                <c:when test="${order.orderStatus == 1}">已支付</c:when>
                <c:when test="${order.orderStatus == 2}">已完成</c:when>
                <c:when test="${order.orderStatus == 3}">已取消</c:when>
            </c:choose></p>
        </div>

        <h3>订单明细：</h3>
        <table class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>菜品名称</th>
                <th>价格</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${order.orderItems}">
                <tr>
                    <td>${item.dish.name}</td>
                    <td>￥${item.dish.price}</td>
                    <td>${item.quantity}</td>
                    <td>￥${item.subtotal}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <hr />
        <div class="action-links">
            <a href="${pageContext.request.contextPath}/admin?action=orderList" class="btn btn-secondary">返回订单列表</a>
        </div>
    </c:if>

    <c:if test="${empty order}">
        <p>未找到该订单的详细信息。</p>
    </c:if>
</div>
