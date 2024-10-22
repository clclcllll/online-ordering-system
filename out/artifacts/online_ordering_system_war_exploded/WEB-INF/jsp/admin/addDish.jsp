<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/jsp/admin/adminHeader.jsp" %>

<h2>添加新菜品</h2>

<form action="${pageContext.request.contextPath}/admin?action=saveDish" method="post" enctype="multipart/form-data">
    <table>
        <tr>
            <td>名称：</td>
            <td><input type="text" name="name" required></td>
        </tr>
        <tr>
            <td>价格：</td>
            <td><input type="number" name="price" step="0.01" required></td>
        </tr>
        <tr>
            <td>描述：</td>
            <td><textarea name="description" rows="5" cols="30"></textarea></td>
        </tr>
        <tr>
            <td>库存：</td>
            <td><input type="number" name="stock" required></td>
        </tr>
        <tr>
            <td>图片：</td>
            <td><input type="file" name="image" accept="image/*" required></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="添加">
                <input type="reset" value="重置">
            </td>
        </tr>
    </table>
</form>

<%@ include file="/WEB-INF/jsp/admin/adminFooter.jsp" %>
