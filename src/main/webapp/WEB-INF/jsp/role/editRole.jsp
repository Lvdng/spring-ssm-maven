<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑角色</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        .checkbox-group {
            margin-bottom: 15px;
        }
        .permission-section {
            margin-top: 30px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }
        .permission-category {
            margin-bottom: 15px;
        }
        .permission-category h3 {
            margin-top: 0;
            color: #333;
            border-bottom: 1px solid #ddd;
            padding-bottom: 5px;
        }
        .permission-list {
            padding-left: 20px;
        }
        .permission-item {
            margin: 8px 0;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
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
        .error {
            color: #a94442;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>编辑角色</h1>
        
        <form action="${pageContext.request.contextPath}/role/edit" method="post">
            <input type="hidden" name="id" value="${role.id}">
            
            <div class="form-group">
                <label for="name">角色名称 *</label>
                <input type="text" id="name" name="name" value="${role.name}" required>
                <c:if test="${not empty errors.name}"><div class="error">${errors.name}</div></c:if>
            </div>
            
            <div class="form-group">
                <label for="description">角色描述</label>
                <textarea id="description" name="description">${role.description}</textarea>
            </div>
            
            <div class="form-group">
                <label>
                    <input type="checkbox" name="status" value="1" <c:if test="${role.status == 1}">checked</c:if>> 启用角色
                </label>
            </div>
            
            <!-- 权限分配部分 -->
            <div class="permission-section">
                <h2>权限分配</h2>
                
                <div class="permission-list">
                    <c:forEach items="${permissions}" var="permission">
                        <div class="permission-item">
                            <label>
                                <input type="checkbox" name="permissionIds" value="${permission.id}" 
                                       <c:forEach items="${rolePermissions}" var="rolePermission">
                                           <c:if test="${rolePermission.id == permission.id}">checked</c:if>
                                       </c:forEach>>
                                ${permission.name} - ${permission.description}
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <div>
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="${pageContext.request.contextPath}/role/list" class="btn btn-default">取消</a>
            </div>
        </form>
    </div>
</body>
</html>