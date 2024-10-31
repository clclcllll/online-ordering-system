<%--
  Created by IntelliJ IDEA.
  User: zhangsir
  Date: 2024/10/22
  Time: 20:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .content {
        flex-grow: 1; /* 占据剩余空间 */
    }

    .footer {
        color: #292929;
        background: rgba(224, 226, 235, 0);
        display: flex;
        justify-content: center; /* 水平居中 */
        align-items: center;     /* 垂直居中 */
        height: 60px;            /* 固定高度，可以根据需要调整 */
    }
</style>


<div class="content"></div>
<footer class="footer">
    <p style="">&copy; 2024 网上订餐系统. All rights reserved.</p>
</footer>
<!-- 引入 JavaScript -->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
