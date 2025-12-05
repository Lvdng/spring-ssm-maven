<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>分配用户角色</title>
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

                .btn-default {
                    background-color: #f0f0f0;
                    color: #333;
                }

                .btn-default:hover {
                    background-color: #e0e0e0;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 20px;
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

                select {
                    padding: 6px 10px;
                    border: 1px solid #ddd;
                    border-radius: 4px;
                    min-width: 150px;
                }

                .save-section {
                    text-align: right;
                    margin-top: 20px;
                    padding-top: 20px;
                    border-top: 1px solid #ddd;
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
            <div class="container">
                <h1>分配用户角色</h1>

                <!-- 消息提示 -->
                <c:if test="${not empty message}">
                    <div class="message">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/role/updateUserRole" method="post">
                    <table>
                        <thead>
                            <tr>
                                <th>选择</th>
                                <th>ID</th>
                                <th>用户名</th>
                                <th>昵称</th>
                                <th>邮箱</th>
                                <th>状态</th>
                                <th>当前角色</th>
                                <th>余额</th>
                                <th>分配角色</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td>
                                        <input type="checkbox" name="selectedUserIds" value="${user.id}"
                                            id="user-${user.id}">
                                    </td>
                                    <td>${user.id}</td>
                                    <td>${user.username}</td>
                                    <td>${user.nickname}</td>
                                    <td>${user.email}</td>
                                    <td
                                        class="<c:if test='${user.status == 1}'>status-active</c:if><c:if test='${user.status != 1}'>status-inactive</c:if>">
                                        ${user.status == 1 ? '启用' : '禁用'}
                                    </td>
                                    <td>${user.role.name}</td>
                                    <td>${user.balance} 元</td>
                                    <td>
                                        <select name="roleId-${user.id}">
                                            <option value="">-- 请选择角色 --</option>
                                            <c:forEach items="${roles}" var="role">
                                                <option value="${role.id}" <c:if test="${user.roleId == role.id}">
                                                    selected</c:if>>
                                                    ${role.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/shopping/toRecharge?userId=${user.id}"
                                            class="btn btn-primary">充值</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="save-section">
                        <button type="submit" class="btn btn-primary">保存所选用户的角色分配</button>
                        <a href="${pageContext.request.contextPath}/role/list" class="btn btn-default">返回角色列表</a>
                    </div>
                </form>

                <c:if test="${empty users}">
                    <div style="text-align: center; padding: 20px; color: #999;">暂无用户数据</div>
                </c:if>
            </div>
        </body>

        </html>