<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>

<style>
    /* 自定义表单样式 */
    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        font-weight: bold;
    }

    .form-group input,
    .form-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #1AABD7;
        border-radius: 4px;
    }

    .form-group img {
        max-width: 100px;
        margin-top: 10px;
    }

    .btn {
        padding: 10px 20px;
        margin-right: 10px;
        border-radius: 4px;
    }

    .btn-primary {
        background-color: #007bff;
        color: white;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: white;
    }

    .content {
        margin-left: 00px; /* 与侧边栏宽度相同，避免内容被覆盖 */
        padding: 20px;
    }
</style>

<div class="content">
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger" role="alert">
                ${errorMsg}
        </div>
    </c:if>

    <h2><c:choose>
        <c:when test="${not empty dish}">编辑菜品</c:when>
        <c:otherwise>添加新菜品</c:otherwise>
    </c:choose></h2>

    <form action="${pageContext.request.contextPath}/admin?action=saveDish" method="post">
        <c:if test="${not empty dish}">
            <!-- 如果是编辑菜品，隐藏菜品ID字段 -->
            <input type="hidden" name="dishID" value="${dish.dishID}">
        </c:if>

        <div class="form-group">
            <label for="name">名称：</label>
            <input type="text" id="name" name="name" value="${dish.name}" required>
        </div>

        <div class="form-group">
            <label for="price">价格：</label>
            <input type="number" id="price" name="price" step="0.01" value="${dish.price}" required>
        </div>

        <div class="form-group">
            <label for="description">描述：</label>
            <textarea id="description" name="description" rows="5" cols="30">${dish.description}</textarea>
        </div>

        <div class="form-group">
            <label for="stock">库存：</label>
            <input type="number" id="stock" name="stock" value="${dish.stock}" required>
        </div>

        <c:if test="${not empty dish.image}">
            <!-- 如果是编辑模式，显示当前图片 -->
            <div class="form-group">
                <label>当前图片：</label>
                <img src="${pageContext.request.contextPath}/images/${dish.image}" alt="${dish.name}" width="100">
            </div>
        </c:if>

        <div class="form-group">
            <label for="image">图片：</label>
            <input type="file" id="image" name="image" accept="image/*" <c:if test="${empty dish}">required</c:if>>
        </div>

        <div class="form-group">
            <input type="submit" value="<c:choose>
                <c:when test='${not empty dish}'>更新</c:when>
                <c:otherwise>添加</c:otherwise>
            </c:choose>" class="btn btn-primary">
            <input type="reset" value="重置" class="btn btn-secondary">
        </div>
    </form>
</div>
