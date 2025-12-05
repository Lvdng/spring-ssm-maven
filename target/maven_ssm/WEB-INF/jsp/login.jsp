<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-CN">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>用户登录</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            /* 全局重置样式 */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', 'Microsoft YaHei', Arial, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: #333;
                line-height: 1.6;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }

            /* 登录容器样式 */
            .login-container {
                width: 100%;
                max-width: 420px;
                background-color: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
                padding: 48px 40px;
                margin: 20px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .login-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 50px rgba(0, 0, 0, 0.25);
            }

            /* 标题样式 */
            .login-title {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 36px;
                font-size: 28px;
                font-weight: 700;
                letter-spacing: -0.5px;
            }

            /* 表单样式 */
            .login-form .form-group {
                margin-bottom: 28px;
                position: relative;
            }

            .login-form label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 600;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* 输入框容器 */
            .input-wrapper {
                position: relative;
            }

            .login-form input[type="text"],
            .login-form input[type="password"] {
                width: 100%;
                padding: 14px 16px 14px 44px;
                border: 2px solid #e1e5e9;
                border-radius: 10px;
                font-size: 15px;
                transition: all 0.3s ease;
                background-color: #fafbfc;
            }

            .login-form input[type="text"]:focus,
            .login-form input[type="password"]:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                background-color: #fff;
            }

            /* 输入框图标 */
            .input-icon {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                color: #9ca3af;
                font-size: 18px;
                transition: color 0.3s ease;
            }

            .login-form input:focus+.input-icon {
                color: #667eea;
            }

            /* 密码切换按钮 */
            .password-toggle {
                position: absolute;
                right: 16px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: #9ca3af;
                font-size: 18px;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .password-toggle:hover,
            .login-form input:focus+.input-icon+.password-toggle {
                color: #667eea;
            }

            /* 按钮样式 */
            .login-button {
                width: 100%;
                padding: 15px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }

            .login-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }

            .login-button:active {
                transform: translateY(0);
            }

            /* 错误提示样式 */
            .error-message {
                color: #dc2626;
                background-color: #fef2f2;
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 24px;
                font-size: 14px;
                border-left: 4px solid #dc2626;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            /* 成功提示样式 */
            .success-message {
                color: #059669;
                background-color: #f0fdf4;
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 24px;
                font-size: 14px;
                border-left: 4px solid #059669;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            /* 注册链接样式 */
            .register-link {
                text-align: center;
                margin-top: 28px;
                font-size: 14px;
                color: #6b7280;
            }

            .register-link a {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                position: relative;
            }

            .register-link a:hover {
                color: #5a67d8;
            }

            .register-link a::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 0;
                height: 2px;
                background-color: #667eea;
                transition: width 0.3s ease;
            }

            .register-link a:hover::after {
                width: 100%;
            }

            /* 响应式设计 */
            @media (max-width: 480px) {
                body {
                    padding: 10px;
                }

                .login-container {
                    padding: 36px 28px;
                    margin: 10px;
                    border-radius: 12px;
                }

                .login-title {
                    font-size: 24px;
                    margin-bottom: 28px;
                }

                .login-form .form-group {
                    margin-bottom: 24px;
                }

                .login-form input[type="text"],
                .login-form input[type="password"] {
                    padding: 13px 14px 13px 40px;
                    font-size: 14px;
                    border-radius: 8px;
                }

                .login-button {
                    padding: 14px;
                    font-size: 15px;
                    border-radius: 8px;
                }
            }
        </style>
    </head>

    <body>
        <div class="login-container">
            <h2 class="login-title">用户登录</h2>

            <!-- 错误信息展示 -->
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <!-- 成功信息展示 -->
            <c:if test="${not empty message}">
                <div class="success-message">${message}</div>
            </c:if>

            <form class="login-form" action="${pageContext.request.contextPath}/user/login" method="post">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <div class="input-wrapper">
                        <input type="text" id="username" name="username" value="${username}" placeholder="请输入用户名"
                            required>
                        <span class="input-icon"><i class="fas fa-user"></i></span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">密码</label>
                    <div class="input-wrapper">
                        <input type="password" id="password" name="password" placeholder="请输入密码" required>
                        <span class="input-icon"><i class="fas fa-lock"></i></span>
                        <button type="button" class="password-toggle" onclick="togglePassword('password')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="login-button">登录</button>

                <div class="register-link">
                    还没有账号？<a href="${pageContext.request.contextPath}/user/toRegister">立即注册</a>
                </div>
            </form>

            <!-- 密码切换脚本 -->
            <script>
                function togglePassword(inputId) {
                    const input = document.getElementById(inputId);
                    const icon = input.nextElementSibling.nextElementSibling.querySelector('i');
                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        input.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                }
            </script>
        </div>
    </body>

    </html>