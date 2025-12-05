<%-- Created by IntelliJ IDEA. User: lenovo Date: 2025/11/30 Time: 下午1:12 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <html>

        <head>
            <!-- 指定字符集 -->
            <meta charset="utf-8">
            <!-- 使用Edge最新的浏览器的渲染方式 -->
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <!-- viewport视口：网页可以根据设置的宽度自动进行适配 -->
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>修改商品</title>
            <!-- 引用自定义样式文件 -->
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            <!-- 内联CSS作为备用 -->
            <style>
                /* 全局重置 */
                * { margin: 0; padding: 0; box-sizing: border-box; }
                
                body {
                    font-family: 'Microsoft YaHei', Arial, sans-serif;
                    background-color: #f8f9fa;
                    line-height: 1.6;
                    padding: 20px;
                }
                
                .container {
                    max-width: 800px;
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
                
                .form-group {
                    margin-bottom: 20px;
                }
                
                label {
                    display: block;
                    margin-bottom: 8px;
                    font-weight: 600;
                    color: #555;
                }
                
                .form-control {
                    width: 100%;
                    padding: 10px 12px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    font-size: 16px;
                    transition: border-color 0.3s ease;
                }
                
                .form-control:focus {
                    border-color: #007bff;
                    outline: none;
                    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
                }
                
                .form-actions {
                    text-align: center;
                    margin-top: 30px;
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
                    transform: translateY(-2px);
                    box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
                }
                
                .btn-default {
                    background-color: #6c757d;
                    color: white;
                }
                
                .btn-default:hover {
                    background-color: #545b62;
                    transform: translateY(-2px);
                    box-shadow: 0 4px 8px rgba(108, 117, 125, 0.3);
                }
                
                /* 响应式设计 */
                @media (max-width: 768px) {
                    .container {
                        padding: 20px;
                    }
                    
                    h3 {
                        font-size: 20px;
                    }
                    
                    .btn {
                        display: block;
                        width: 100%;
                        margin: 10px 0;
                    }
                }
                
                @media (max-width: 480px) {
                    body {
                        padding: 10px;
                    }
                    
                    .container {
                        padding: 15px;
                    }
                    
                    .form-control {
                        padding: 8px 10px;
                        font-size: 14px;
                    }
                }
            </style>
        </head>

        <body>
            <div class="container">
                <h3>修改商品页面</h3>
                <form action="${pageContext.request.contextPath}/item/updateItem" method="post">
                    <input type="hidden" name="id" value="${item.id}">
                    <div class="form-group">
                        <label for="name">商品名称：</label>
                        <input type="text" class="form-control" id="name" name="name" value="${item.name}">
                    </div>

                    <div class="form-group">
                        <label for="price">商品价格：</label>
                        <input type="text" class="form-control" id="price" name="price" value="${item.price}">
                    </div>

                    <div class="form-group">
                        <label for="detail">商品详情：</label>
                        <input type="text" class="form-control" id="detail" name="detail" value="${item.detail}">
                    </div>

                    <div class="form-actions">
                        <input class="btn btn-primary" type="submit" value="提交" />
                        <input class="btn btn-default" type="reset" value="重置" />
                        <input class="btn btn-default" type="button" onclick="history.go(-1)" value="返回" />
                    </div>
                </form>
            </div>
        </body>

        </html>