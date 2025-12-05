<%-- Created by IntelliJ IDEA. User: Administrator Date: 2025/11/29 Time: 8:05 To change this template use File |
  Settings | File Templates. --%>
  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
      <title>重定向到登录页面</title>
      <script>
        // 页面加载时自动重定向到登录页面
        window.location.href = "${pageContext.request.contextPath}/user/toLogin";
      </script>
    </head>

    <body>
      <p>正在重定向到登录页面...</p>
    </body>

    </html>