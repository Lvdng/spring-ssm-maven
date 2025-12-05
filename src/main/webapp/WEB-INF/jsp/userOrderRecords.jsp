<%-- 用户购买记录查询页面 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <html>

            <head>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>用户购买记录查询</title>
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

                    /* 搜索筛选样式 */
                    .filter-container {
                        margin: 20px 0;
                        padding: 20px;
                        background-color: #f0f7ff;
                        border-radius: 5px;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                    }

                    .filter-form {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                        flex-wrap: wrap;
                    }

                    .form-group {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .form-group label {
                        font-weight: 500;
                        color: #333;
                    }

                    .form-control {
                        padding: 8px 12px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        font-size: 14px;
                    }

                    .form-control:focus {
                        outline: none;
                        border-color: #007bff;
                        box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
                    }

                    /* 排序链接样式 */
                    .sort-link {
                        color: white;
                        text-decoration: none;
                        display: flex;
                        align-items: center;
                        gap: 5px;
                    }

                    .sort-link:hover {
                        text-decoration: underline;
                    }

                    /* 排序指示器样式 */
                    .sort-indicator {
                        font-size: 12px;
                        opacity: 0.8;
                    }

                    /* 空数据提示 */
                    .empty-message {
                        text-align: center;
                        padding: 40px;
                        color: #6c757d;
                        font-size: 16px;
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
                </style>
            </head>

            <body>
                <div class="container">
                    <h3>用户购买记录查询</h3>

                    <!-- 导航 -->
                    <div class="nav">
                        <a href="${pageContext.request.contextPath}/item/queryItemList">商品列表</a>
                        <a href="${pageContext.request.contextPath}/user/queryAllUsers">用户管理</a>
                        <a href="${pageContext.request.contextPath}/shopping/viewIncome">收入管理</a>
                        <a href="${pageContext.request.contextPath}/shopping/allOrders">所有订单</a>
                        <a href="${pageContext.request.contextPath}/shopping/orderStatistics">订单统计</a>
                        <a href="${pageContext.request.contextPath}/shopping/userOrderRecords">购买记录查询</a>
                    </div>

                    <!-- 搜索筛选 -->
                    <div class="filter-container">
                        <form action="${pageContext.request.contextPath}/shopping/userOrderRecords" method="get"
                            class="filter-form">
                            <div class="form-group">
                                <label for="keyword">搜索关键字：</label>
                                <input type="text" id="keyword" name="keyword" value="${keyword}" class="form-control"
                                    placeholder="用户名或商品名称">
                            </div>
                            <div class="form-group">
                                <label for="pageSize">每页显示：</label>
                                <select id="pageSize" name="pageSize" class="form-control"
                                    onchange="this.form.submit()">
                                    <option value="5" ${pageSize==5 ? 'selected' : '' }>5</option>
                                    <option value="10" ${pageSize==10 ? 'selected' : '' }>10</option>
                                    <option value="20" ${pageSize==20 ? 'selected' : '' }>20</option>
                                    <option value="50" ${pageSize==50 ? 'selected' : '' }>50</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">查询</button>
                            </div>
                        </form>
                    </div>

                    <!-- 订单记录列表 -->
                    <table>
                        <thead>
                            <tr>
                                <th>用户名</th>
                                <th>商品名称</th>
                                <th>购买数量</th>
                                <th>
                                    <a href="${pageContext.request.contextPath}/shopping/userOrderRecords?keyword=${keyword}&pageNum=${pageNum}&pageSize=${pageSize}&orderBy=total_price&orderDir=${orderBy=='total_price' && orderDir=='asc' ? 'desc' : 'asc'}"
                                        class="sort-link">
                                        支付金额
                                        <span class="sort-indicator">
                                            <c:if test="${orderBy=='total_price'}">
                                                <c:if test="${orderDir=='asc'}">↑</c:if>
                                                <c:if test="${orderDir=='desc'}">↓</c:if>
                                            </c:if>
                                        </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="${pageContext.request.contextPath}/shopping/userOrderRecords?keyword=${keyword}&pageNum=${pageNum}&pageSize=${pageSize}&orderBy=created_at&orderDir=${orderBy=='created_at' && orderDir=='asc' ? 'desc' : 'asc'}"
                                        class="sort-link">
                                        购买时间
                                        <span class="sort-indicator">
                                            <c:if test="${orderBy=='created_at'}">
                                                <c:if test="${orderDir=='asc'}">↑</c:if>
                                                <c:if test="${orderDir=='desc'}">↓</c:if>
                                            </c:if>
                                        </span>
                                    </a>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="5" class="empty-message">暂无购买记录</td>
                                </tr>
                            </c:if>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>${order.username}</td>
                                    <td>${order.itemName}</td>
                                    <td>${order.quantity}</td>
                                    <td>${order.totalPrice}</td>
                                    <td>${order.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 分页 -->
                    <div class="pagination-container">
                        <div class="pagination-info">
                            共 ${totalCount} 条记录，第 ${pageNum}/${totalPage} 页
                        </div>
                        <div class="pagination">
                            <a href="${pageContext.request.contextPath}/shopping/userOrderRecords?keyword=${keyword}&pageNum=1&pageSize=${pageSize}&orderBy=${orderBy}&orderDir=${orderDir}"
                                class="pagination-link ${pageNum == 1 ? 'disabled' : ''}">首页</a>
                            <a href="${pageContext.request.contextPath}/shopping/userOrderRecords?keyword=${keyword}&pageNum=${pageNum - 1}&pageSize=${pageSize}&orderBy=${orderBy}&orderDir=${orderDir}"
                                class="pagination-link ${pageNum == 1 ? 'disabled' : ''}">上一页</a>

                            <!-- 页码 -->
                            <c:forEach var="i" begin="${pageNum > 3 ? pageNum - 3 : 1}"
                                end="${pageNum + 3 > totalPage ? totalPage : pageNum + 3}">
                                <a href="${pageContext.request.contextPath}/shopping/userOrderRecords?keyword=${keyword}&pageNum=${i}&pageSize=${pageSize}&orderBy=${orderBy}&orderDir=${orderDir}"
                                    class="pagination-link ${pageNum == i ? 'active' : ''}">${i}</a>
                            </c:forEach>

                            <a href="${pageContext.request.contextPath}/shopping/userOrderRecords?keyword=${keyword}&pageNum=${pageNum + 1}&pageSize=${pageSize}&orderBy=${orderBy}&orderDir=${orderDir}"
                                class="pagination-link ${pageNum == totalPage ? 'disabled' : ''}">下一页</a>
                            <a href="${pageContext.request.contextPath}/shopping/userOrderRecords?keyword=${keyword}&pageNum=${totalPage}&pageSize=${pageSize}&orderBy=${orderBy}&orderDir=${orderDir}"
                                class="pagination-link ${pageNum == totalPage ? 'disabled' : ''}">末页</a>
                        </div>
                    </div>
                </div>
            </body>

            </html>