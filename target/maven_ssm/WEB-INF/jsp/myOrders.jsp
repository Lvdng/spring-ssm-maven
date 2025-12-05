<%-- 用户订单列表页面 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <html>

            <head>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>我的订单</title>
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
                        max-width: 1200px;
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

                    /* 表格样式 */
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin: 20px 0;
                        font-size: 16px;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                        border-radius: 8px;
                        overflow: hidden;
                    }

                    th,
                    td {
                        padding: 12px 15px;
                        text-align: left;
                        border-bottom: 1px solid #ddd;
                    }

                    th {
                        background-color: #007bff;
                        color: white;
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 14px;
                        letter-spacing: 0.5px;
                    }

                    tr:nth-child(even) {
                        background-color: #f8f9fa;
                    }

                    tr:hover {
                        background-color: #e9ecef;
                        transition: background-color 0.3s ease;
                    }

                    /* 按钮样式 */
                    .btn {
                        display: inline-block;
                        padding: 8px 16px;
                        margin: 0 5px;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 14px;
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

                    /* 导航样式 */
                    .nav {
                        margin-bottom: 20px;
                        padding: 10px;
                        background-color: #f8f9fa;
                        border-radius: 5px;
                    }

                    .nav a {
                        margin-right: 15px;
                        color: #007bff;
                        text-decoration: none;
                        font-weight: 500;
                    }

                    .nav a:hover {
                        text-decoration: underline;
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
                    <h3>我的订单</h3>

                    <!-- 用户信息 -->
                    <div class="user-info">
                        欢迎，<span>${user.nickname}</span>！您的余额：<span>${user.balance}</span> 元
                    </div>

                    <!-- 导航 -->
                    <div class="nav">
                        <a href="${pageContext.request.contextPath}/item/queryItemList">商品列表</a>
                        <a href="${pageContext.request.contextPath}/shopping/myOrders">我的订单</a>
                        <a href="${pageContext.request.contextPath}/user/profile">个人中心</a>
                    </div>

                    <!-- 订单列表 -->
                    <table>
                        <thead>
                            <tr>
                                <th>订单ID</th>
                                <th>商品名称</th>
                                <th>数量</th>
                                <th>总价</th>
                                <th>状态</th>
                                <th>创建时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>${order.id}</td>
                                    <td>${order.itemName}</td>
                                    <td>${order.quantity}</td>
                                    <td>${order.totalPrice}</td>
                                    <td>
                                        <c:if test="${order.status == 1}">已完成</c:if>
                                        <c:if test="${order.status == 0}">已取消</c:if>
                                    </td>
                                    <td>${order.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 如果没有订单 -->
                    <c:if test="${empty orders}">
                        <div style="text-align: center; color: #666; padding: 20px;">
                            暂无订单
                        </div>
                    </c:if>
                </div>
            </body>

            </html>