<%-- 错误页面 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <html>

            <head>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>错误页面</title>
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
                        text-align: center;
                    }

                    h3 {
                        color: #dc3545;
                        margin-bottom: 20px;
                        padding-bottom: 10px;
                        border-bottom: 2px solid #dc3545;
                    }

                    .error-message {
                        font-size: 18px;
                        color: #666;
                        margin-bottom: 30px;
                    }

                    .btn {
                        display: inline-block;
                        padding: 10px 20px;
                        margin: 0 10px;
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
                </style>
            </head>

            <body>
                <div class="container">
                    <h3>操作失败</h3>
                    <div class="error-message">
                        <c:if test="${not empty error}">
                            ${error}
                        </c:if>
                        <c:if test="${empty error}">
                            未知错误，请稍后重试
                        </c:if>
                    </div>
                    <div>
                        <a href="javascript:history.back()" class="btn btn-primary">返回上一页</a>
                        <a href="${pageContext.request.contextPath}/item/queryItemList"
                            class="btn btn-secondary">返回商品列表</a>
                    </div>
                </div>
            </body>

            </html>