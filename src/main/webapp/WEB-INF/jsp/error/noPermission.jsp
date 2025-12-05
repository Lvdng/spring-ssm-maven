<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>无权限访问</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
            color: #333;
        }
        h1 {
            color: #d9534f;
            font-size: 36px;
        }
        p {
            font-size: 18px;
            margin: 20px 0;
        }
        a {
            color: #5bc0de;
            text-decoration: none;
            font-size: 16px;
        }
        a:hover {
            text-decoration: underline;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>403 - 无权限访问</h1>
        <p>抱歉，您没有权限访问此页面。</p>
        <p>请联系管理员获取相应权限。</p>
        <p><a href="${pageContext.request.contextPath}/">返回首页</a> | <a href="${pageContext.request.contextPath}/user/logout">退出登录</a></p>
    </div>
</body>
</html>