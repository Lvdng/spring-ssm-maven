/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 90001 (9.0.1)
 Source Host           : localhost:3306
 Source Schema         : ssm

 Target Server Type    : MySQL
 Target Server Version : 90001 (9.0.1)
 File Encoding         : 65001

 Date: 05/12/2025 14:53:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_income
-- ----------------------------
DROP TABLE IF EXISTS `admin_income`;
CREATE TABLE `admin_income`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL COMMENT '订单ID',
  `amount` decimal(10, 2) NOT NULL COMMENT '收入金额',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  CONSTRAINT `fk_income_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员收入表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_income
-- ----------------------------
INSERT INTO `admin_income` VALUES (1, 7, 148999.00, '2025-12-02 14:32:01');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `detail` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES (9, '华为', 7999, '中国国产手机之光');
INSERT INTO `item` VALUES (10, 'xiaomi SU7', 148999, '小米旗下首个轿车');
INSERT INTO `item` VALUES (11, 'xiaomi YU7', 234899, '小米首个SUV汽车');
INSERT INTO `item` VALUES (12, '特斯拉', 499999, '外国纯电汽车');
INSERT INTO `item` VALUES (13, '帽子', 299, '超级时尚');
INSERT INTO `item` VALUES (14, '测试商品1', 10, '这是测试商品1的详细描述');
INSERT INTO `item` VALUES (15, '杯子', 20, '这是测试商品2的详细描述');
INSERT INTO `item` VALUES (16, '测试商品3', 30, '这是测试商品3的详细描述');
INSERT INTO `item` VALUES (17, '测试商品4', 40, '这是测试商品4的详细描述');
INSERT INTO `item` VALUES (18, '测试商品5', 50, '这是测试商品5的详细描述');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `item_id` int NOT NULL COMMENT '商品ID',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '购买数量',
  `total_price` decimal(10, 2) NOT NULL COMMENT '总价格',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '订单状态（1：已完成，0：已取消）',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_item_id`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_item_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 1, 15, 1, 20.00, 1, '2025-12-02 13:33:43');
INSERT INTO `order` VALUES (2, 4, 15, 1, 20.00, 1, '2025-12-02 13:34:45');
INSERT INTO `order` VALUES (3, 4, 16, 1, 30.00, 1, '2025-12-02 13:34:46');
INSERT INTO `order` VALUES (4, 1, 15, 1, 20.00, 1, '2025-12-02 14:20:38');
INSERT INTO `order` VALUES (5, 4, 16, 1, 30.00, 1, '2025-12-02 14:21:02');
INSERT INTO `order` VALUES (6, 4, 14, 1, 10.00, 1, '2025-12-02 14:22:09');
INSERT INTO `order` VALUES (7, 1, 10, 1, 148999.00, 1, '2025-12-02 14:32:01');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限对应的URL',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限描述',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态（1：启用，0：禁用）',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'USER_MANAGE', '/user/*', '用户管理权限', 1, '2025-12-01 21:13:08');
INSERT INTO `permission` VALUES (2, 'ITEM_MANAGE', '/item/*', '商品管理权限', 1, '2025-12-01 21:13:08');
INSERT INTO `permission` VALUES (3, 'ROLE_MANAGE', '/role/*', '角色管理权限', 1, '2025-12-01 21:13:08');
INSERT INTO `permission` VALUES (4, 'PERMISSION_MANAGE', '/permission/*', '权限管理权限', 1, '2025-12-01 21:13:08');
INSERT INTO `permission` VALUES (5, 'ITEM_QUERY', '/item/queryItemList', '查询商品列表权限', 1, '2025-12-01 21:13:08');
INSERT INTO `permission` VALUES (6, '商品查看', 'item:view', '查看商品列表和详情', 1, '2025-12-01 21:22:18');
INSERT INTO `permission` VALUES (7, '商品添加', 'item:add', '添加新商品', 1, '2025-12-01 21:22:18');
INSERT INTO `permission` VALUES (8, '商品编辑', 'item:update', '编辑商品信息', 1, '2025-12-01 21:22:18');
INSERT INTO `permission` VALUES (9, '商品删除', 'item:delete', '删除商品', 1, '2025-12-01 21:22:18');
INSERT INTO `permission` VALUES (10, '用户查看', 'user:view', '查看用户列表和信息', 1, '2025-12-01 21:22:18');
INSERT INTO `permission` VALUES (11, '用户编辑', 'user:update', '编辑用户信息', 1, '2025-12-01 21:22:18');
INSERT INTO `permission` VALUES (12, '角色管理', 'role:manage', '管理系统角色', 1, '2025-12-01 21:22:18');
INSERT INTO `permission` VALUES (13, '权限管理', 'permission:manage', '管理系统权限', 1, '2025-12-01 21:22:18');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色描述',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态（1：启用，0：禁用）',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ADMIN', '管理员角色，拥有所有权限', 1, '2025-12-01 21:13:08', '2025-12-01 21:13:08');
INSERT INTO `role` VALUES (2, 'USER', '普通用户角色，拥有基本权限', 1, '2025-12-01 21:13:08', '2025-12-01 21:13:08');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `role_id` int NOT NULL COMMENT '角色ID',
  `permission_id` int NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE,
  INDEX `idx_permission_id`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `fk_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色-权限关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1, 1);
INSERT INTO `role_permission` VALUES (1, 2);
INSERT INTO `role_permission` VALUES (1, 3);
INSERT INTO `role_permission` VALUES (1, 4);
INSERT INTO `role_permission` VALUES (1, 5);
INSERT INTO `role_permission` VALUES (2, 5);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码（加密存储）',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态（1：启用，0：禁用）',
  `role_id` int NULL DEFAULT NULL COMMENT '角色ID',
  `balance` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '用户余额',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `idx_email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `idx_phone`(`phone` ASC) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 'admin@example.com', '13800138000', '2025-12-01 21:03:32', '2025-12-02 14:32:01', 1, 1, 9851061.00);
INSERT INTO `user` VALUES (4, 'testuser', 'e10adc3949ba59abbe56e057f20f883e', '测试用户', 'user@example.com', '13900139000', '2025-12-01 21:22:18', '2025-12-02 14:22:09', 1, 1, 10.00);

SET FOREIGN_KEY_CHECKS = 1;
