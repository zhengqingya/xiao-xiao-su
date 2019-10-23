/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : demo

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 23/10/2019 17:27:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_log`;
CREATE TABLE `t_sys_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接口名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接口地址',
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '访问人IP',
  `user_id` int(11) DEFAULT 0 COMMENT '访问人ID 0:未登录用户操作',
  `status` int(2) DEFAULT 1 COMMENT '访问状态',
  `execute_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接口执行时间',
  `gmt_create` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1078 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理 - 日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for t_sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_menu`;
CREATE TABLE `t_sys_menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上级资源ID',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'url',
  `resources` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '资源编码',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '资源名称',
  `level` int(11) DEFAULT NULL COMMENT '资源级别',
  `sort_no` int(11) DEFAULT NULL COMMENT '排序',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '资源图标',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类型 menu、button',
  `remarks` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `gmt_create` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理-权限资源表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_menu
-- ----------------------------
INSERT INTO `t_sys_menu` VALUES (1, '0', NULL, 'systemManage', '系统管理', 1, 3, 'component', 'menu', '', '2019-03-28 18:51:08', '2019-03-28 18:51:10');
INSERT INTO `t_sys_menu` VALUES (2, '1', '/system/user/listPage', 'user', '用户管理', 2, 1, 'my-user', 'menu', '', '2019-03-28 18:52:13', '2019-08-31 21:26:57');
INSERT INTO `t_sys_menu` VALUES (3, '2', '/system/user/save', 'sys:user:add', '添加', 3, 1, 'el-icon-edit', 'button', '', '2019-03-28 18:53:31', '2019-04-01 20:19:55');
INSERT INTO `t_sys_menu` VALUES (4, '2', '/system/user/save', 'sys:user:edit', '编辑', 3, 2, NULL, 'button', '', '2019-03-28 18:54:26', '2019-04-01 20:20:16');
INSERT INTO `t_sys_menu` VALUES (5, '2', '/system/user/delete', 'sys:user:delete', '删除', 3, 3, NULL, 'button', '', '2019-03-28 18:55:25', '2019-04-01 20:20:09');
INSERT INTO `t_sys_menu` VALUES (16, '1', '/system/role/listPage', 'role', '角色管理', 2, 2, 'my-role', 'menu', '', '2019-03-30 14:00:03', '2019-03-30 14:20:59');
INSERT INTO `t_sys_menu` VALUES (17, '1', '/system/menu/treeMenu', 'menu', '菜单管理', 2, 3, 'my-sysmenu', 'menu', '', '2019-03-30 14:00:53', '2019-03-30 14:21:10');
INSERT INTO `t_sys_menu` VALUES (43, '16', '/system/role/saveOrUpdate', 'sys:role:add', '添加', 3, 1, '', 'button', '', '2019-04-01 20:20:46', '2019-04-01 20:20:46');
INSERT INTO `t_sys_menu` VALUES (44, '16', '/system/role/saveOrUpdate', 'sys:role:edit', '编辑', 3, 2, '', 'button', '', '2019-04-01 20:21:03', '2019-04-01 20:21:03');
INSERT INTO `t_sys_menu` VALUES (45, '16', NULL, 'roleSetting', '权限设置', 3, 3, '', 'button', '', '2019-04-01 20:21:24', '2019-04-01 20:21:24');
INSERT INTO `t_sys_menu` VALUES (46, '16', '/system/role/delete', 'sys:role:delete', '删除', 3, 4, '', 'button', '', '2019-04-01 20:21:55', '2019-04-01 20:21:55');
INSERT INTO `t_sys_menu` VALUES (47, '17', '/system/menu/save', 'sys:menu:add', '添加', 3, 1, '', 'button', '', '2019-04-01 20:22:31', '2019-04-01 20:22:31');
INSERT INTO `t_sys_menu` VALUES (48, '17', '/system/menu/save', 'sys:menu:addsub', '添加下级', 3, 2, '', 'button', '', '2019-04-01 20:23:00', '2019-04-01 20:23:00');
INSERT INTO `t_sys_menu` VALUES (49, '17', '/system/menu/save', 'sys:menu:edit', '编辑', 3, 3, '', 'button', '', '2019-04-01 20:23:28', '2019-04-01 20:23:28');
INSERT INTO `t_sys_menu` VALUES (50, '17', '/system/menu/delete', 'sys:menu:delete', '删除', 3, 4, '', 'button', '', '2019-04-01 20:23:46', '2019-04-01 20:23:46');
INSERT INTO `t_sys_menu` VALUES (79, '1', '/system/log/listPage', 'log', '系统日志', 2, 4, 'my-sysmenu', 'menu', '', '2019-03-30 14:00:53', '2019-09-18 14:21:38');
INSERT INTO `t_sys_menu` VALUES (80, '16', '/system/user/treeUser', 'sys:user:treeUser', '获取用户树', 3, 5, NULL, 'menu', NULL, '2019-10-20 14:33:37', '2019-10-20 14:33:37');
INSERT INTO `t_sys_menu` VALUES (81, '16', '/system/role/detail', 'sys:role:detail', '获取角色详情', 3, 6, NULL, 'menu', NULL, '2019-10-20 14:34:59', '2019-10-20 14:34:59');
INSERT INTO `t_sys_menu` VALUES (82, '16', '/system/userRole/list', 'sys:userRole:list', '获取系统管理 - 用户角色关联表 列表', 3, 7, NULL, 'menu', NULL, '2019-10-20 14:35:53', '2019-10-20 14:35:53');
INSERT INTO `t_sys_menu` VALUES (83, '17', '/system/menu/treeMenu', 'sys:menu:treeMenu', '获取菜单树', 3, 5, NULL, 'menu', NULL, '2019-10-20 14:36:33', '2019-10-20 14:36:33');
INSERT INTO `t_sys_menu` VALUES (84, '2', '/system/roleMenu/list', 'sys:roleMenu:list', '获取系统管理 - 角色-菜单关联表 列表', 3, 4, NULL, 'menu', NULL, '2019-10-20 14:39:37', '2019-10-20 14:39:37');
INSERT INTO `t_sys_menu` VALUES (85, '17', '/system/roleMenu/saveRoleMenu', 'sys:roleMenu:saveRoleMenu', '保存角色相关联菜单', 3, 6, NULL, 'button', NULL, '2019-10-20 14:42:12', '2019-10-20 14:42:12');

-- ----------------------------
-- Table structure for t_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色名称',
  `remarks` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色描述',
  `gmt_create` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理-角色表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_role
-- ----------------------------
INSERT INTO `t_sys_role` VALUES (1, 'admin', '系统管理员', '系统管理员', '2019-03-28 15:51:56', '2019-03-28 15:51:59');
INSERT INTO `t_sys_role` VALUES (2, 'visitor', '访客', '访客', '2019-03-28 20:17:04', '2019-09-09 16:32:15');

-- ----------------------------
-- Table structure for t_sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role_menu`;
CREATE TABLE `t_sys_role_menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(10) DEFAULT NULL COMMENT '角色ID',
  `menu_id` int(10) DEFAULT NULL COMMENT '菜单ID',
  `gmt_create` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1636 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理 - 角色-权限资源关联表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_role_menu
-- ----------------------------
INSERT INTO `t_sys_role_menu` VALUES (1571, 1, 1, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1572, 1, 2, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1573, 1, 3, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1574, 1, 4, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1575, 1, 5, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1576, 1, 84, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1577, 1, 16, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1578, 1, 43, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1579, 1, 44, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1580, 1, 45, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1581, 1, 46, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1582, 1, 80, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1583, 1, 81, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1584, 1, 82, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1585, 1, 17, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1586, 1, 47, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1587, 1, 48, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1588, 1, 49, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1589, 1, 50, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1590, 1, 83, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1591, 1, 85, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1592, 1, 79, '2019-10-20 14:44:12', '2019-10-20 14:44:12');
INSERT INTO `t_sys_role_menu` VALUES (1615, 2, 1, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1616, 2, 2, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1617, 2, 3, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1618, 2, 4, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1619, 2, 5, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1620, 2, 84, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1621, 2, 16, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1622, 2, 43, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1623, 2, 44, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1624, 2, 45, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1625, 2, 46, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1626, 2, 80, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1627, 2, 81, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1628, 2, 82, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1629, 2, 17, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1630, 2, 47, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1631, 2, 48, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1632, 2, 49, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1633, 2, 50, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1634, 2, 83, '2019-10-22 15:11:37', '2019-10-22 15:11:37');
INSERT INTO `t_sys_role_menu` VALUES (1635, 2, 85, '2019-10-22 15:11:37', '2019-10-22 15:11:37');

-- ----------------------------
-- Table structure for t_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录密码',
  `nick_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '昵称',
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别 0:男 1:女',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号码',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '状态',
  `salt` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盐值',
  `token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'token',
  `qq_oppen_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'QQ 第三方登录Oppen_ID唯一标识',
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '明文密码',
  `gmt_create` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理-用户基础信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_user
-- ----------------------------
INSERT INTO `t_sys_user` VALUES (1, 'admin', '97ba1ef7f148b2aec1c61303a7d88d0967825495', '郑清', '0', '15183303003', '10086@qq.com', 'http://qzapp.qlogo.cn/qzapp/101536330/86F96F92387D69BD7659C4EC3CD6BD69/100', '1', 'zhengqing', 'f78a977744d587b335d611f23fa25d8fd1352df6', '', '123456', '2019-05-05 16:09:06', '2019-10-23 17:26:30');
INSERT INTO `t_sys_user` VALUES (2, 'test', '97ba1ef7f148b2aec1c61303a7d88d0967825495', '测试号', '0', '10000', '10000@qq.com', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', '1', 'zhengqing', '2425fb04b4bcb140e05d22d46baa9c257ceed879', NULL, '123456', '2019-05-05 16:15:06', '2019-10-23 16:56:38');

-- ----------------------------
-- Table structure for t_sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_role`;
CREATE TABLE `t_sys_user_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(10) DEFAULT NULL COMMENT '角色ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `gmt_create` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理 - 用户角色关联表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_user_role
-- ----------------------------
INSERT INTO `t_sys_user_role` VALUES (12, 1, 1, '2019-08-21 10:49:41', '2019-08-21 10:49:41');
INSERT INTO `t_sys_user_role` VALUES (27, 2, 2, '2019-09-07 21:50:33', '2019-09-07 21:50:33');

SET FOREIGN_KEY_CHECKS = 1;
