# SSM电商管理系统

## 项目介绍

这是一个基于SSM（Spring+SpringMVC+MyBatis）框架的电商管理系统，包含了用户管理、商品管理、订单管理、角色权限管理等功能模块。

## 技术栈

- **后端框架**: Spring 5.0.2 + SpringMVC + MyBatis 3.4.5
- **数据库**: MySQL 9.0
- **前端技术**: JSP + Bootstrap 3 + jQuery
- **构建工具**: Maven 3
- **开发工具**: IntelliJ IDEA / Eclipse

## 项目结构

```
spring-ssm-maven/
├── src/main/
│   ├── java/com/sxd/
│   │   ├── annotation/         # 自定义注解
│   │   ├── controller/         # 控制器层
│   │   ├── interceptor/        # 拦截器
│   │   ├── mapper/             # DAO层接口
│   │   ├── pojo/               # 实体类
│   │   ├── service/            # 业务逻辑层
│   │   │   └── impl/           # 业务逻辑实现
│   │   └── test/               # 测试类
│   ├── resources/              # 资源文件
│   │   ├── com/sxd/mapper/     # MyBatis映射文件
│   │   ├── sql/                # SQL脚本
│   │   └── *.xml               # 配置文件
│   └── webapp/                 # Web应用目录
│       ├── WEB-INF/
│       │   ├── jsp/            # JSP页面
│       │   └── web.xml         # Web配置
│       ├── css/                # 样式文件
│       ├── fonts/              # 字体文件
│       └── js/                 # JavaScript文件
├── pom.xml                     # Maven配置
└── README.md                   # 项目说明文档
```

## 功能模块

### 1. 用户管理
- 用户注册、登录
- 用户信息管理
- 用户余额充值

### 2. 商品管理
- 商品列表查询
- 商品添加、编辑、删除
- 商品详情查看

### 3. 订单管理
- 订单创建
- 订单列表查询
- 订单统计

### 4. 角色权限管理
- 角色管理
- 权限管理
- 角色-权限关联
- 用户-角色关联
- 基于注解的权限控制

### 5. 管理员功能
- 收入管理
- 订单统计分析

## 核心功能实现

### 权限控制

系统使用自定义注解 `@RequiredPermission` 实现基于角色的权限控制，通过拦截器 `PermissionInterceptor` 进行权限验证。

### 数据库设计

- `user` - 用户表
- `role` - 角色表
- `permission` - 权限表
- `role_permission` - 角色-权限关联表
- `item` - 商品表
- `order` - 订单表
- `admin_income` - 管理员收入表

## 安装部署

### 1. 环境准备

- JDK 11+
- MySQL 9.0+
- Maven 3.6+
- Tomcat 7+

### 2. 数据库配置

1. 创建数据库 `ssm`
2. 执行 `src/main/resources/sql/ssm.sql` 脚本导入表结构和初始数据
3. 修改 `src/main/resources/db.properties` 文件，配置数据库连接信息

### 3. 项目构建

```bash
# 编译项目
mvn clean compile

# 打包项目
mvn clean package
```

### 4. 部署运行

1. 将打包生成的 `target/maven_ssm.war` 文件复制到 Tomcat 的 `webapps` 目录
2. 启动 Tomcat 服务器
3. 访问 `http://localhost:8080/maven_ssm`

## 初始账号

- 管理员账号：admin / 123456
- 普通用户：testuser / 123456

## 项目特点

1. **分层架构**: 清晰的分层设计，便于维护和扩展
2. **权限控制**: 基于角色的细粒度权限管理
3. **响应式设计**: 前端使用 Bootstrap，支持多种设备访问
4. **代码规范**: 遵循 Java 编码规范，代码结构清晰
5. **易于扩展**: 模块化设计，便于功能扩展

## 技术亮点

- 使用 Spring AOP 实现日志记录和权限控制
- MyBatis 动态 SQL 优化数据库操作
- 自定义注解实现灵活的权限控制
- 拦截器实现统一的请求处理

## 注意事项

1. 确保数据库服务已启动
2. 检查数据库连接配置是否正确
3. 首次运行请先执行 SQL 脚本
4. 开发环境建议使用 Tomcat 7 或以上版本

## 开发说明

### 代码生成

本项目使用 MyBatis 逆向工程生成实体类、Mapper 接口和映射文件，提高开发效率。

### 日志配置

项目使用 Log4j 进行日志记录，配置文件位于 `src/main/resources/log4j.properties`。

## 许可证

MIT License

## 联系方式

如有问题或建议，欢迎联系项目开发者。

---

**感谢使用 SSM 电商管理系统！**