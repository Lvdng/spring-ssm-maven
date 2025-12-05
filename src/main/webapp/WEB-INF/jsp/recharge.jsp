<%-- 充值页面 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <html>

            <head>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>充值余额</title>
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
                <style>
                    /* 全局重置 */
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Microsoft YaHei', Arial, sans-serif;
                        background-color: #f8f9fa;
                        line-height: 1.6;
                        padding: 20px;
                    }

                    .container {
                        max-width: 600px;
                        margin: 0 auto;
                        background-color: white;
                        padding: 30px;
                        border-radius: 10px;
                        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                    }

                    h3 {
                        color: #333;
                        margin-bottom: 20px;
                        padding-bottom: 10px;
                        border-bottom: 2px solid #007bff;
                        text-align: center;
                    }

                    /* 表单样式 */
                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-group label {
                        display: block;
                        margin-bottom: 8px;
                        font-weight: 600;
                        color: #555;
                    }

                    .form-group input {
                        width: 100%;
                        padding: 10px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        font-size: 16px;
                    }

                    .form-group input:focus {
                        outline: none;
                        border-color: #007bff;
                        box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
                    }

                    /* 按钮样式 */
                    .btn {
                        display: inline-block;
                        padding: 10px 20px;
                        margin-right: 10px;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 16px;
                        transition: all 0.3s ease;
                        text-decoration: none;
                    }

                    .btn-primary {
                        background-color: #007bff;
                        color: white;
                    }

                    .btn-primary:hover {
                        background-color: #0056b3;
                        transform: translateY(-1px);
                    }

                    .btn-secondary {
                        background-color: #6c757d;
                        color: white;
                    }

                    .btn-secondary:hover {
                        background-color: #545b62;
                        transform: translateY(-1px);
                    }

                    /* 用户信息样式 */
                    .user-info {
                        margin-bottom: 20px;
                        padding: 15px;
                        background-color: #e3f2fd;
                        border-radius: 5px;
                        font-size: 16px;
                    }

                    .user-info span {
                        font-weight: 600;
                        color: #1976d2;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <h3>充值余额</h3>

                    <!-- 用户信息 -->
                    <div class="user-info">
                        用户名：<span>${user.username}</span> | 昵称：<span>${user.nickname}</span> |
                        当前余额：<span>${user.balance}</span> 元
                    </div>

                    <!-- 充值表单 -->
                    <form action="${pageContext.request.contextPath}/shopping/rechargeBalance" method="post">
                        <input type="hidden" name="userId" value="${user.id}">

                        <div class="form-group">
                            <label for="amount">充值金额（元）</label>
                            <input type="number" id="amount" name="amount" step="0.01" min="0.01" required>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">确认</button>
                            <a href="${pageContext.request.contextPath}/user/queryAllUsers" class="btn btn-secondary">取消</a>
                        </div>
</body>
</html>