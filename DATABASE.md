# 数据库设计文档

## 1. 数据库概述

本系统使用 MySQL 9.0 数据库，数据库名称为 `ssm`。数据库采用 InnoDB 存储引擎，支持事务和外键约束，确保数据的完整性和一致性。

## 2. 数据库表结构

### 2.1 用户表 (`user`)

| 字段名 | 数据类型 | 长度 | 约束 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| `id` | `int` | - | `PRIMARY KEY, AUTO_INCREMENT` | 用户ID |
| `username` | `varchar` | 50 | `NOT NULL, UNIQUE` | 用户名 |
| `password` | `varchar` | 100 | `NOT NULL` | 密码（加密存储） |
| `nickname` | `varchar` | 50 | `NULL` | 昵称 |
| `email` | `varchar` | 100 | `NULL, UNIQUE` | 邮箱 |
| `phone` | `varchar` | 20 | `NULL, UNIQUE` | 手机号 |
| `created_at` | `datetime` | - | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `datetime` | - | `NOT NULL, DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` | 更新时间 |
| `status` | `tinyint` | - | `NOT NULL, DEFAULT 1` | 状态（1：启用，0：禁用） |
| `role_id` | `int` | - | `NULL` | 角色ID |
| `balance` | `decimal` | 10,2 | `NOT NULL, DEFAULT 0.00` | 用户余额 |

**索引**：
- `idx_username` (username) - 唯一索引
- `idx_email` (email) - 唯一索引
- `idx_phone` (phone) - 唯一索引
- `idx_role_id` (role_id) - 普通索引

### 2.2 角色表 (`role`)

| 字段名 | 数据类型 | 长度 | 约束 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| `id` | `int` | - | `PRIMARY KEY, AUTO_INCREMENT` | 角色ID |
| `name` | `varchar` | 50 | `NOT NULL, UNIQUE` | 角色名称 |
| `description` | `varchar` | 200 | `NULL` | 角色描述 |
| `status` | `tinyint` | - | `NOT NULL, DEFAULT 1` | 状态（1：启用，0：禁用） |
| `created_at` | `datetime` | - | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `datetime` | - | `NOT NULL, DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` | 更新时间 |

**索引**：
- `idx_name` (name) - 唯一索引

### 2.3 权限表 (`permission`)

| 字段名 | 数据类型 | 长度 | 约束 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| `id` | `int` | - | `PRIMARY KEY, AUTO_INCREMENT` | 权限ID |
| `name` | `varchar` | 50 | `NOT NULL, UNIQUE` | 权限名称 |
| `url` | `varchar` | 200 | `NULL` | 权限对应的URL |
| `description` | `varchar` | 200 | `NULL` | 权限描述 |
| `status` | `tinyint` | - | `NOT NULL, DEFAULT 1` | 状态（1：启用，0：禁用） |
| `created_at` | `datetime` | - | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

**索引**：
- `idx_name` (name) - 唯一索引

### 2.4 角色-权限关联表 (`role_permission`)

| 字段名 | 数据类型 | 长度 | 约束 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| `role_id` | `int` | - | `PRIMARY KEY, FOREIGN KEY` | 角色ID |
| `permission_id` | `int` | - | `PRIMARY KEY, FOREIGN KEY` | 权限ID |

**索引**：
- `PRIMARY KEY` (role_id, permission_id) - 联合主键
- `idx_permission_id` (permission_id) - 普通索引

**外键约束**：
- `role_id` 引用 `role.id`，级联删除和更新
- `permission_id` 引用 `permission.id`，级联删除和更新

### 2.5 商品表 (`item`)

| 字段名 | 数据类型 | 长度 | 约束 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| `id` | `int` | - | `PRIMARY KEY, AUTO_INCREMENT` | 商品ID |
| `name` | `varchar` | 32 | `NULL` | 商品名称 |
| `price` | `float` | - | `NULL` | 商品价格 |
| `detail` | `varchar` | 32 | `NULL` | 商品详情 |

### 2.6 订单表 (`order`)

| 字段名 | 数据类型 | 长度 | 约束 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| `id` | `int` | - | `PRIMARY KEY, AUTO_INCREMENT` | 订单ID |
| `user_id` | `int` | - | `NOT NULL, FOREIGN KEY` | 用户ID |
| `item_id` | `int` | - | `NOT NULL, FOREIGN KEY` | 商品ID |
| `quantity` | `int` | - | `NOT NULL, DEFAULT 1` | 购买数量 |
| `total_price` | `decimal` | 10,2 | `NOT NULL` | 总价格 |
| `status` | `tinyint` | - | `NOT NULL, DEFAULT 1` | 订单状态（1：已完成，0：已取消） |
| `created_at` | `datetime` | - | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

**索引**：
- `idx_user_id` (user_id) - 普通索引
- `idx_item_id` (item_id) - 普通索引

**外键约束**：
- `user_id` 引用 `user.id`，级联删除和更新
- `item_id` 引用 `item.id`，级联删除和更新

### 2.7 管理员收入表 (`admin_income`)

| 字段名 | 数据类型 | 长度 | 约束 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| `id` | `int` | - | `PRIMARY KEY, AUTO_INCREMENT` | 收入ID |
| `order_id` | `int` | - | `NOT NULL, UNIQUE, FOREIGN KEY` | 订单ID |
| `amount` | `decimal` | 10,2 | `NOT NULL` | 收入金额 |
| `created_at` | `datetime` | - | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

**索引**：
- `idx_order_id` (order_id) - 唯一索引

**外键约束**：
- `order_id` 引用 `order.id`，级联删除和更新

## 3. 表关系图

```
+--------+       +--------+       +------------------+
|  user  |-------|  role  |-------| role_permission  |
+--------+       +--------+       +------------------+
                                      |
                                      |
                                      v
                                +-------------+
                                | permission |
                                +-------------+
+--------+       +--------+
|  item  |-------|  order |-------+---------------+
+--------+       +--------+       | admin_income  |
                                   +---------------+
```

## 4. 数据字典

| 表名 | 描述 | 主要功能 |
| :--- | :--- | :--- |
| `user` | 用户表 | 存储系统用户信息 |
| `role` | 角色表 | 存储系统角色信息 |
| `permission` | 权限表 | 存储系统权限信息 |
| `role_permission` | 角色-权限关联表 | 存储角色与权限的关联关系 |
| `item` | 商品表 | 存储系统商品信息 |
| `order` | 订单表 | 存储系统订单信息 |
| `admin_income` | 管理员收入表 | 存储管理员收入信息 |

## 5. 初始数据

系统提供了以下初始数据：

### 5.1 角色数据

| ID | 名称 | 描述 | 状态 |
| :--- | :--- | :--- | :--- |
| 1 | `ADMIN` | 管理员角色，拥有所有权限 | 1 |
| 2 | `USER` | 普通用户角色，拥有基本权限 | 1 |

### 5.2 权限数据

| ID | 名称 | URL | 描述 | 状态 |
| :--- | :--- | :--- | :--- | :--- |
| 1 | `USER_MANAGE` | `/user/*` | 用户管理权限 | 1 |
| 2 | `ITEM_MANAGE` | `/item/*` | 商品管理权限 | 1 |
| 3 | `ROLE_MANAGE` | `/role/*` | 角色管理权限 | 1 |
| 4 | `PERMISSION_MANAGE` | `/permission/*` | 权限管理权限 | 1 |
| 5 | `ITEM_QUERY` | `/item/queryItemList` | 查询商品列表权限 | 1 |

### 5.3 角色-权限关联数据

| 角色ID | 权限ID |
| :--- | :--- |
| 1 | 1 |
| 1 | 2 |
| 1 | 3 |
| 1 | 4 |
| 1 | 5 |
| 2 | 5 |

### 5.4 用户数据

| ID | 用户名 | 密码 | 昵称 | 邮箱 | 手机号 | 角色ID | 余额 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | `admin` | `e10adc3949ba59abbe56e057f20f883e` | 系统管理员 | `admin@example.com` | `13800138000` | 1 | 9851061.00 |
| 4 | `testuser` | `e10adc3949ba59abbe56e057f20f883e` | 测试用户 | `user@example.com` | `13900139000` | 1 | 10.00 |

**密码说明**：初始密码为 `123456`，存储的是 MD5 加密后的字符串。

## 6. 数据库优化建议

1. **索引优化**：根据查询需求，为频繁查询的字段添加适当的索引，提高查询效率。
2. **分表分库**：当数据量达到一定规模时，考虑采用分表分库策略，提高系统的扩展性和性能。
3. **读写分离**：采用主从复制架构，实现读写分离，提高系统的并发处理能力。
4. **缓存机制**：对于频繁访问的数据，使用缓存机制（如 Redis），减少数据库查询次数。
5. **事务优化**：合理设计事务范围，避免长时间占用数据库连接。

## 7. 数据库备份与恢复

### 7.1 备份策略

- 每天凌晨执行全量备份
- 每小时执行增量备份
- 备份文件保存到安全的存储介质

### 7.2 恢复流程

1. 停止应用服务
2. 恢复最新的全量备份
3. 恢复所有的增量备份
4. 启动应用服务
5. 验证数据完整性

## 8. 注意事项

1. 所有数据库操作必须通过事务进行，确保数据的完整性和一致性。
2. 避免在生产环境中直接执行 DDL 语句，以免影响系统的正常运行。
3. 定期清理过期数据，优化数据库性能。
4. 加强数据库的安全防护，包括访问控制、数据加密等。
5. 定期监控数据库性能，及时发现和解决问题。