<%-- Created by IntelliJ IDEA. User: lenovo Date: 2025/11/30 Time: 下午1:11 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <html>

            <head>
                <!-- 指定字符集 -->
                <meta charset="utf-8">
                <!-- 使用Edge最新的浏览器的渲染方式 -->
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <!-- viewport视口：网页可以根据设置的宽度自动进行适配 -->
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>商品列表</title>
                <!-- 引用自定义样式文件 -->
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
                <!-- 内联CSS作为备用 -->
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
                        box-shadow: 0 2px 6px rgba(0, 123, 255, 0.3);
                    }

                    .btn-danger {
                        background-color: #dc3545;
                        color: white;
                    }

                    .btn-danger:hover {
                        background-color: #c82333;
                        transform: translateY(-1px);
                        box-shadow: 0 2px 6px rgba(220, 53, 69, 0.3);
                    }

                    .btn-success {
                        background-color: #28a745;
                        color: white;
                    }

                    .btn-success:hover {
                        background-color: #218838;
                        transform: translateY(-1px);
                        box-shadow: 0 2px 6px rgba(40, 167, 69, 0.3);
                    }

                    /* 按钮区域 */
                    .button-container {
                        text-align: right;
                        margin-bottom: 20px;
                    }

                    /* 空数据提示 */
                    .empty-message {
                        text-align: center;
                        padding: 40px;
                        color: #6c757d;
                        font-size: 16px;
                    }

                    /* 搜索框样式 */
                    .search-container {
                        margin: 20px 0;
                        text-align: center;
                    }

                    .search-form {
                        display: inline-block;
                        width: 100%;
                        max-width: 600px;
                    }

                    .search-input-group {
                        display: flex;
                        gap: 10px;
                    }

                    .search-input {
                        flex: 1;
                        padding: 10px 15px;
                        border: 2px solid #ddd;
                        border-radius: 5px;
                        font-size: 16px;
                        transition: border-color 0.3s ease;
                    }

                    .search-input:focus {
                        outline: none;
                        border-color: #007bff;
                    }

                    .search-btn {
                        padding: 10px 25px;
                        font-size: 16px;
                    }

                    /* 操作按钮区域 */
                    .action-buttons {
                        margin-bottom: 20px;
                        text-align: right;
                    }

                    /* 用户导航样式 */
                    .user-nav {
                        margin-bottom: 20px;
                        padding: 15px 0;
                        border-bottom: 1px solid #eee;
                    }

                    .user-info {
                        text-align: right;
                    }

                    .user-info span {
                        margin-right: 15px;
                        font-weight: 500;
                        color: #333;
                    }

                    .btn-sm {
                        padding: 6px 12px;
                        font-size: 14px;
                    }

                    .btn-outline-primary {
                        background-color: transparent;
                        border: 2px solid #007bff;
                        color: #007bff;
                    }

                    .btn-outline-primary:hover {
                        background-color: #007bff;
                        color: white;
                    }

                    .btn-outline-secondary {
                        background-color: transparent;
                        border: 2px solid #6c757d;
                        color: #6c757d;
                    }

                    .btn-outline-secondary:hover {
                        background-color: #6c757d;
                        color: white;
                    }

                    .btn-outline-danger {
                        background-color: transparent;
                        border: 2px solid #dc3545;
                        color: #dc3545;
                    }

                    .btn-outline-danger:hover {
                        background-color: #dc3545;
                        color: white;
                    }

                    /* 分页样式 */
                    .pagination-container {
                        margin-top: 30px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: 15px;
                    }

                    .pagination-info {
                        color: #6c757d;
                        font-size: 14px;
                    }

                    .pagination {
                        display: flex;
                        gap: 5px;
                        flex-wrap: wrap;
                        justify-content: center;
                    }

                    .pagination-link {
                        display: inline-block;
                        padding: 8px 16px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        text-decoration: none;
                        color: #007bff;
                        background-color: white;
                        transition: all 0.3s ease;
                    }

                    .pagination-link:hover:not(.disabled) {
                        background-color: #007bff;
                        color: white;
                        border-color: #007bff;
                    }

                    .pagination-link.active {
                        background-color: #007bff;
                        color: white;
                        border-color: #007bff;
                        font-weight: 600;
                    }

                    .pagination-link.disabled {
                        opacity: 0.5;
                        cursor: not-allowed;
                    }

                    .pagination-link.disabled:hover {
                        background-color: white;
                        color: #007bff;
                        border-color: #ddd;
                    }

                    /* 每页显示条数选择器 */
                    .page-size-selector {
                        font-size: 14px;
                        color: #6c757d;
                    }

                    .page-size-form {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .page-size-form select {
                        padding: 6px 10px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        font-size: 14px;
                        cursor: pointer;
                    }

                    /* 响应式设计 */
                    @media (max-width: 768px) {
                        .container {
                            padding: 20px;
                        }

                        table {
                            font-size: 14px;
                        }

                        th,
                        td {
                            padding: 8px 10px;
                        }

                        .btn {
                            padding: 6px 12px;
                            font-size: 12px;
                            margin: 0 3px;
                        }

                        .button-container {
                            text-align: center;
                        }
                    }

                    @media (max-width: 480px) {
                        body {
                            padding: 10px;
                        }

                        .container {
                            padding: 15px;
                        }

                        h3 {
                            font-size: 18px;
                        }

                        table {
                            font-size: 12px;
                        }

                        th,
                        td {
                            padding: 6px 8px;
                        }

                        .btn {
                            display: block;
                            margin: 5px auto;
                            width: 100%;
                            max-width: 120px;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- 导航栏 -->
                <div class="top-nav">
                    <div class="nav-content">
                        <!-- 系统名称 -->
                        <div class="nav-brand">
                            <a href="${pageContext.request.contextPath}/item/queryItemList">商品管理系统</a>
                        </div>

                        <!-- 功能模块导航 -->
                        <div class="nav-menu">
                            <a href="${pageContext.request.contextPath}/item/queryItemList">商品管理</a>
                            <a href="${pageContext.request.contextPath}/shopping/myOrders">已购买商品</a>
                            <!-- 管理员角色管理入口 -->
                            <c:if test="${sessionScope.user.username eq 'admin'}">
                                <a href="${pageContext.request.contextPath}/role/list">角色管理</a>
                                <a href="${pageContext.request.contextPath}/shopping/userOrderRecords">购买记录查询</a>
                            </c:if>
                        </div>

                        <!-- 用户信息和操作 -->
                        <div class="nav-user">
                            <c:if test="${not empty sessionScope.user}">
                                <span class="user-greeting">欢迎您，${sessionScope.user.username}</span>
                                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-blue">个人信息</a>
                                <a href="${pageContext.request.contextPath}/user/logout" class="btn btn-red">退出登录</a>
                            </c:if>
                            <c:if test="${empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/user/toLogin" class="btn btn-blue">登录</a>
                                <a href="${pageContext.request.contextPath}/user/toRegister"
                                    class="btn btn-default">注册</a>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- 导航栏样式 -->
                <style>
                    .top-nav {
                        background-color: white;
                        padding: 15px 0;
                        margin-bottom: 20px;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                    }

                    .nav-content {
                        max-width: 1000px;
                        margin: 0 auto;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        padding: 0 20px;
                    }

                    .nav-brand a {
                        font-size: 1.5rem;
                        font-weight: bold;
                        color: #3498db;
                        text-decoration: none;
                    }

                    .nav-menu {
                        display: flex;
                        gap: 20px;
                    }

                    .nav-menu a {
                        color: #6c5ce7;
                        font-size: 1.1rem;
                        text-decoration: none;
                        transition: color 0.3s ease;
                    }

                    .nav-menu a:hover {
                        color: #3498db;
                    }

                    .nav-user {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                    }

                    .user-greeting {
                        color: #2c3e50;
                        font-size: 1rem;
                    }

                    .btn-blue {
                        background-color: #3498db;
                        color: white;
                        border: none;
                        padding: 6px 15px;
                        border-radius: 4px;
                        cursor: pointer;
                        text-decoration: none;
                        font-size: 1rem;
                        transition: all 0.3s ease;
                    }

                    .btn-blue:hover {
                        background-color: #2980b9;
                    }

                    .btn-red {
                        background-color: #e74c3c;
                        color: white;
                        border: none;
                        padding: 6px 15px;
                        border-radius: 4px;
                        cursor: pointer;
                        text-decoration: none;
                        font-size: 1rem;
                        transition: all 0.3s ease;
                    }

                    .btn-red:hover {
                        background-color: #c0392b;
                    }
                </style>

                <div class="container">

                    <h3>商品信息管理</h3>
                    
                    <!-- 用户信息和余额显示 -->
                    <div class="user-info">
                        欢迎，<span>${sessionScope.user.username}</span>！您的余额：<span>${sessionScope.user.balance}</span> 元
                    </div>

                    <!-- 搜索框 -->
                    <div class="search-container">
                        <form action="${pageContext.request.contextPath}/item/queryItemList" method="get"
                            class="search-form">
                            <div class="form-group search-input-group">
                                <input type="text" name="keyword" value="${keyword}" placeholder="请输入商品名称、价格或描述进行搜索"
                                    class="search-input">
                                <button type="submit" class="btn btn-primary search-btn">搜索</button>
                            </div>
                        </form>
                    </div>

                    <!-- 添加商品按钮 - 仅管理员可见 -->
                    <div class="action-buttons">
                        <c:if test="${sessionScope.user.username eq 'admin'}">
                            <a href="${pageContext.request.contextPath}/item/toAddItem" class="btn btn-primary">添加商品</a>
                        </c:if>
                    </div>

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>商品编号</th>
                                <th>商品名称</th>
                                <th>商品价格</th>
                                <th>商品描述</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty items}">
                                <tr>
                                    <td colspan="5" class="empty-message">暂无商品数据</td>
                                </tr>
                            </c:if>
                            <c:forEach items="${items}" var="item">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.name}</td>
                                    <td>${item.price}</td>
                                    <td>${item.detail}</td>
                                    <td>
                                        <!-- 管理员可以修改和删除商品 -->
                                        <c:if test="${sessionScope.user.username eq 'admin'}">
                                            <a href="${pageContext.request.contextPath}/item/tooUpdate?id=${item.id}"
                                                class="btn btn-success">修改</a>
                                            <a href="${pageContext.request.contextPath}/item/deleteItem?id=${item.id}"
                                                class="btn btn-danger">删除</a>
                                        </c:if>
                                        <!-- 所有用户都可以购买商品 -->
                                        <a href="${pageContext.request.contextPath}/shopping/buyItem?itemId=${item.id}"
                                            class="btn btn-primary">购买</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 分页组件 -->
                    <div class="pagination-container">
                        <div class="pagination-info">
                            共 ${totalCount} 条记录，第 ${pageNum}/${totalPage} 页
                        </div>
                        <div class="pagination">
                            <a href="${pageContext.request.contextPath}/item/queryItemList?keyword=${keyword}&pageNum=1&pageSize=${pageSize}"
                                class="pagination-link ${pageNum == 1 ? 'disabled' : ''}">首页</a>

                            <a href="${pageContext.request.contextPath}/item/queryItemList?keyword=${keyword}&pageNum=${pageNum - 1}&pageSize=${pageSize}"
                                class="pagination-link ${pageNum == 1 ? 'disabled' : ''}">上一页</a>

                            <!-- 页码 -->
                            <c:forEach var="i" begin="${pageNum > 3 ? pageNum - 3 : 1}"
                                end="${pageNum + 3 > totalPage ? totalPage : pageNum + 3}">
                                <a href="${pageContext.request.contextPath}/item/queryItemList?keyword=${keyword}&pageNum=${i}&pageSize=${pageSize}"
                                    class="pagination-link ${pageNum == i ? 'active' : ''}">${i}</a>
                            </c:forEach>

                            <a href="${pageContext.request.contextPath}/item/queryItemList?keyword=${keyword}&pageNum=${pageNum + 1}&pageSize=${pageSize}"
                                class="pagination-link ${pageNum == totalPage ? 'disabled' : ''}">下一页</a>

                            <a href="${pageContext.request.contextPath}/item/queryItemList?keyword=${keyword}&pageNum=${totalPage}&pageSize=${pageSize}"
                                class="pagination-link ${pageNum == totalPage ? 'disabled' : ''}">末页</a>
                        </div>

                        <!-- 每页显示条数选择器 -->
                        <div class="page-size-selector">
                            <form action="${pageContext.request.contextPath}/item/queryItemList" method="get"
                                class="page-size-form">
                                <input type="hidden" name="keyword" value="${keyword}">
                                <input type="hidden" name="pageNum" value="1">
                                <label for="pageSize">每页显示：</label>
                                <select name="pageSize" id="pageSize" onchange="this.form.submit()">
                                    <option value="5" ${pageSize==5 ? 'selected' : '' }>5</option>
                                    <option value="10" ${pageSize==10 ? 'selected' : '' }>10</option>
                                    <option value="20" ${pageSize==20 ? 'selected' : '' }>20</option>
                                    <option value="50" ${pageSize==50 ? 'selected' : '' }>50</option>
                                </select>
                            </form>
                        </div>
                    </div>
                </div>
            </body>

            </html>