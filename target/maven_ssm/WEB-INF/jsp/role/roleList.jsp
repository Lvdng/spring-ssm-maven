<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>角色管理</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 20px;
                    background-color: #f5f5f5;
                }

                .container {
                    max-width: 1200px;
                    margin: 0 auto;
                    background-color: #fff;
                    padding: 20px;
                    border-radius: 5px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                }

                h1 {
                    color: #333;
                    margin-bottom: 20px;
                    border-bottom: 1px solid #ddd;
                    padding-bottom: 10px;
                }

                .message {
                    padding: 10px;
                    margin-bottom: 20px;
                    background-color: #dff0d8;
                    border: 1px solid #d6e9c6;
                    color: #3c763d;
                    border-radius: 4px;
                }

                .error {
                    padding: 10px;
                    margin-bottom: 20px;
                    background-color: #f2dede;
                    border: 1px solid #ebccd1;
                    color: #a94442;
                    border-radius: 4px;
                }

                .action-bar {
                    margin-bottom: 20px;
                    text-align: right;
                }

                .btn {
                    padding: 8px 16px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                    font-size: 14px;
                    text-decoration: none;
                    display: inline-block;
                }

                .btn-primary {
                    background-color: #337ab7;
                    color: white;
                }

                .btn-primary:hover {
                    background-color: #286090;
                }

                .btn-success {
                    background-color: #5cb85c;
                    color: white;
                }

                .btn-success:hover {
                    background-color: #4cae4c;
                }

                .btn-warning {
                    background-color: #f0ad4e;
                    color: white;
                }

                .btn-warning:hover {
                    background-color: #eea236;
                }

                .btn-danger {
                    background-color: #d9534f;
                    color: white;
                }

                .btn-danger:hover {
                    background-color: #c9302c;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                th,
                td {
                    padding: 12px;
                    text-align: left;
                    border-bottom: 1px solid #ddd;
                }

                th {
                    background-color: #f8f9fa;
                    font-weight: bold;
                }

                tr:hover {
                    background-color: #f5f5f5;
                }

                .status-active {
                    color: #5cb85c;
                }

                .status-inactive {
                    color: #d9534f;
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
                            <!-- 管理员角色管理入口 -->
                            <c:if test="${sessionScope.user.username eq 'admin'}">
                                <a href="${pageContext.request.contextPath}/role/list">角色管理</a>
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
                                <a href="${pageContext.request.contextPath}/user/toRegister" class="btn btn-default">注册</a>
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
                <h1>角色管理</h1>

                <!-- 消息提示 -->
                <c:if test="${not empty message}">
                    <div class="message">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <!-- 操作栏 -->
                <div class="action-bar">
                    <a href="${pageContext.request.contextPath}/role/toAdd" class="btn btn-primary">添加角色</a>
                    <a href="${pageContext.request.contextPath}/role/assignUserRole" class="btn btn-success">分配用户角色</a>
                </div>

                <!-- 角色列表 -->
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>角色名称</th>
                            <th>描述</th>
                            <th>状态</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${roles}" var="role">
                            <tr>
                                <td>${role.id}</td>
                                <td>${role.name}</td>
                                <td>${role.description}</td>
                                <td
                                    class="<c:if test='${role.status == 1}'>status-active</c:if><c:if test='${role.status != 1}'>status-inactive</c:if>">
                                    ${role.status == 1 ? '启用' : '禁用'}
                                </td>
                                <td>${role.createdAt}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/role/toEdit?id=${role.id}"
                                        class="btn btn-warning">编辑</a>
                                    <a href="${pageContext.request.contextPath}/role/delete?id=${role.id}"
                                        class="btn btn-danger" onclick="return confirm('确定要删除该角色吗？');">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:if test="${empty roles}">
                    <div style="text-align: center; padding: 20px; color: #999;">暂无角色数据</div>
                </c:if>
            </div>
        </body>

        </html>