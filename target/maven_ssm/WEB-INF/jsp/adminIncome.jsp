<%-- 管理员收入页面 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <html>

            <head>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>管理员收入</title>
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

                    /* 收入统计样式 */
                    .income-stat {
                        margin-bottom: 20px;
                        padding: 20px;
                        background-color: #e8f5e8;
                        border-radius: 5px;
                        font-size: 18px;
                        text-align: center;
                    }

                    .income-stat span {
                        font-weight: 600;
                        color: #2e7d32;
                        font-size: 24px;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <h3>管理员收入</h3>

                    <!-- 收入统计 -->
                    <div class="income-stat">
                        总收入：<span>${totalIncome}</span> 元
                    </div>

                    <!-- 导航 -->
                    <div class="nav">
                        <a href="${pageContext.request.contextPath}/item/queryItemList">商品列表</a>
                        <a href="${pageContext.request.contextPath}/user/queryAllUsers">用户管理</a>
                        <a href="${pageContext.request.contextPath}/shopping/viewIncome">收入管理</a>
                        <a href="${pageContext.request.contextPath}/shopping/allOrders">所有订单</a>
                        <a href="${pageContext.request.contextPath}/shopping/orderStatistics">订单统计</a>
                    </div>

                    <!-- 收入记录列表 -->
                    <table>
                        <thead>
                            <tr>
                                <th>收入ID</th>
                                <th>订单ID</th>
                                <th>金额</th>
                                <th>创建时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${incomes}" var="income">
                                <tr>
                                    <td>${income.id}</td>
                                    <td>${income.orderId}</td>
                                    <td>${income.amount}</td>
                                    <td>${income.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 如果没有收入记录 -->
                    <c:if test="${empty incomes}">
                        <div style="text-align: center; color: #666; padding: 20px;">
                            暂无收入记录
                        </div>
                    </c:if>
                </div>
            </body>

            </html>