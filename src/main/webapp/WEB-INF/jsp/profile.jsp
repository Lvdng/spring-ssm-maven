<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>个人信息</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            h1 {
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }

            .nav {
                margin-bottom: 20px;
                text-align: right;
            }

            .nav a {
                color: #0066cc;
                text-decoration: none;
                margin-left: 15px;
            }

            .nav a:hover {
                text-decoration: underline;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #555;
            }

            input[type="text"],
            input[type="email"],
            input[type="tel"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="tel"]:focus,
            input[type="password"]:focus {
                border-color: #0066cc;
                outline: none;
            }

            .password-hint {
                font-size: 14px;
                color: #666;
                margin-top: 5px;
            }

            .btn {
                background-color: #0066cc;
                color: white;
                border: none;
                padding: 12px 20px;
                font-size: 16px;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
            }

            .btn:hover {
                background-color: #0052a3;
            }

            .message {
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 4px;
                text-align: center;
            }

            .success {
                background-color: #dff0d8;
                color: #3c763d;
                border: 1px solid #d6e9c6;
            }

            .error {
                background-color: #f2dede;
                color: #a94442;
                border: 1px solid #ebccd1;
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
            <div class="nav">
                <a href="${pageContext.request.contextPath}/item/queryItemList">返回商品列表</a>
            </div>

            <h1>个人信息</h1>

            <!-- 消息提示区域 -->
            <c:if test="${not empty successMsg}">
                <div class="message success">${successMsg}</div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="message error">${errorMsg}</div>
            </c:if>

            <!-- 个人信息表单 -->
            <form action="${pageContext.request.contextPath}/user/updateProfile" method="post">
                <!-- 隐藏字段，用于传递用户ID -->
                <input type="hidden" name="id" value="${user.id}">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" name="username" value="${user.username}" readonly>
                </div>

                <div class="form-group">
                    <label for="nickname">昵称</label>
                    <input type="text" id="nickname" name="nickname" value="${user.nickname}" required>
                </div>

                <div class="form-group">
                    <label for="email">邮箱</label>
                    <input type="email" id="email" name="email" value="${user.email}" required>
                </div>

                <div class="form-group">
                    <label for="phone">手机号</label>
                    <input type="tel" id="phone" name="phone" value="${user.phone}" required>
                </div>
                
                <div class="form-group">
                    <label for="balance">余额</label>
                    <input type="text" id="balance" value="${user.balance} 元" readonly>
                </div>

                <div class="form-group">
                    <label for="oldPassword">原密码</label>
                    <input type="password" id="oldPassword" name="oldPassword">
                    <div class="password-hint">如果需要修改密码，请填写原密码和新密码</div>
                </div>

                <div class="form-group">
                    <label for="newPassword">新密码</label>
                    <input type="password" id="newPassword" name="newPassword">
                    <div class="password-hint">新密码长度至少为6位</div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">确认新密码</label>
                    <input type="password" id="confirmPassword" name="confirmPassword">
                </div>

                <button type="submit" class="btn">更新个人信息</button>
            </form>
        </div>
    </body>

    </html>