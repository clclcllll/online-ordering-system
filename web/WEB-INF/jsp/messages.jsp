<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    h2 {
        text-align: center;
        margin-top: 20px;
        color: #333;
    }

    .message-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
        padding: 20px;
    }

    .message-item {
        background: white;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 20px;
        width: 300px;
        max-width: 100%;
        text-align: left;
        transition: transform 0.3s;
    }

    .message-item:hover {
        transform: translateY(-10px);
    }

    .message-item h3 {
        margin-top: 0;
        font-size: 18px;
        color: #555;
    }

    .message-item p {
        margin: 5px 0;
        color: #777;
        font-size: 14px;
    }

    .message-item p strong {
        color: #333;
    }

    .no-messages {
        text-align: center;
        margin: 50px;
        font-size: 18px;
        color: #777;
    }

    .message-item hr {
        border: 0;
        border-top: 1px solid #eee;
        margin: 10px 0;
    }

</style>

<h2>售罄消息列表</h2>

<c:if test="${not empty messages}">
    <div class="message-list">
        <c:forEach var="message" items="${messages}">
            <div class="message-item">
                <h3>消息内容：</h3>
                <p>${message}</p>
                <hr />
            </div>
        </c:forEach>
    </div>
</c:if>

<c:if test="${empty messages}">
    <p class="no-messages">目前没有售罄消息。</p>
</c:if>

<%@ include file="footer.jsp" %>
