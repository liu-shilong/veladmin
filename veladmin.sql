/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : veladmin

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 19/06/2024 22:59:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for vel_admin
-- ----------------------------
DROP TABLE IF EXISTS `vel_admin`;
CREATE TABLE `vel_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `realname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '人员姓名',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10008 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_admin
-- ----------------------------
INSERT INTO `vel_admin` VALUES (10000, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超管', '1', '超级管理员', '2024-06-18 10:50:56', '2024-06-18 15:49:00');
INSERT INTO `vel_admin` VALUES (10007, 'test', 'e10adc3949ba59abbe56e057f20f883e', 'test', '1', NULL, '2024-06-18 23:55:46', '2024-06-19 20:43:56');

-- ----------------------------
-- Table structure for vel_admin_pos
-- ----------------------------
DROP TABLE IF EXISTS `vel_admin_pos`;
CREATE TABLE `vel_admin_pos`  (
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `pos_id` int(11) NOT NULL COMMENT '职位ID',
  UNIQUE INDEX `admin_id`(`admin_id`, `pos_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和职位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_admin_pos
-- ----------------------------
INSERT INTO `vel_admin_pos` VALUES (10000, 1);
INSERT INTO `vel_admin_pos` VALUES (10007, 4);

-- ----------------------------
-- Table structure for vel_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `vel_admin_role`;
CREATE TABLE `vel_admin_role`  (
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  UNIQUE INDEX `admin_id`(`admin_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_admin_role
-- ----------------------------
INSERT INTO `vel_admin_role` VALUES (10000, 1);
INSERT INTO `vel_admin_role` VALUES (10007, 3);

-- ----------------------------
-- Table structure for vel_admin_struct
-- ----------------------------
DROP TABLE IF EXISTS `vel_admin_struct`;
CREATE TABLE `vel_admin_struct`  (
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `struct_id` int(11) NOT NULL COMMENT '组织ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与组织架构关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_admin_struct
-- ----------------------------
INSERT INTO `vel_admin_struct` VALUES (10000, 100);
INSERT INTO `vel_admin_struct` VALUES (10007, 113);

-- ----------------------------
-- Table structure for vel_app_token
-- ----------------------------
DROP TABLE IF EXISTS `vel_app_token`;
CREATE TABLE `vel_app_token`  (
  `token` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '平台类型',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户ID',
  `exp_time` int(11) NOT NULL DEFAULT 0 COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE,
  UNIQUE INDEX `token`(`token`) USING BTREE,
  UNIQUE INDEX `type`(`type`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_app_token
-- ----------------------------
INSERT INTO `vel_app_token` VALUES ('804e919a041bb63d99aff25545671487', 'app', 122, 1651199565);

-- ----------------------------
-- Table structure for vel_config
-- ----------------------------
DROP TABLE IF EXISTS `vel_config`;
CREATE TABLE `vel_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置标识',
  `style` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置类型',
  `is_sys` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '是否系统内置 0否 1是',
  `groups` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置分组',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配置值',
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置项',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置说明',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_config
-- ----------------------------
INSERT INTO `vel_config` VALUES (1, '配置分组', 'sys_config_group', 'array', '1', '', 'site:基本设置\r\nwx:微信设置\r\nsms:短信配置\r\nemail:邮箱配置\r\nimgwater:图片水印', '', '', '2020-12-31 14:01:18', '2022-03-22 20:45:21');
INSERT INTO `vel_config` VALUES (2, '系统名称', 'sys_config_sysname', 'text', '1', 'site', 'VelAdmin', '', '系统后台显示的名称', '2020-12-31 14:01:18', '2024-06-18 10:33:57');
INSERT INTO `vel_config` VALUES (4, '阿里accessKeyId', 'sms_ali_key', 'text', '0', 'sms', '', '', '阿里短信-AccessKey ID', '2021-01-11 19:26:13', '2021-01-17 21:27:04');
INSERT INTO `vel_config` VALUES (5, '阿里accessSecret', 'sms_ali_secret', 'text', '0', 'sms', '', '', '阿里短信-AccessKey Secret', '2021-01-11 19:26:45', '2021-01-17 21:27:04');
INSERT INTO `vel_config` VALUES (6, '阿里signName', 'sms_ali_signname', 'text', '0', 'sms', '', '', '阿里短信-签名', '2021-01-11 19:27:53', '2021-01-17 21:27:04');
INSERT INTO `vel_config` VALUES (7, '阿里tempId', 'sms_ali_temp', 'text', '0', 'sms', '', '', '阿里短信-tempId模板', '2021-01-11 19:30:21', '2021-01-17 21:27:04');
INSERT INTO `vel_config` VALUES (10, '公众号appid', 'wechat_appid', 'text', '0', 'wx', 'test', '', '微信公众号的AppId', '2021-01-12 11:05:50', '2024-06-18 10:35:21');
INSERT INTO `vel_config` VALUES (11, '公众号secret', 'wechat_appsecret', 'text', '0', 'wx', '123456', '', '微信公众号-AppSecret', '2021-01-12 11:06:24', '2024-06-18 10:35:21');
INSERT INTO `vel_config` VALUES (12, '服务地址', 'sys_email_host', 'text', '0', 'email', 'smtp.163.com', '', '类似:smtp.163.com', '2021-01-22 15:28:10', '2024-06-18 10:35:41');
INSERT INTO `vel_config` VALUES (13, '邮箱地址', 'sys_email_username', 'text', '0', 'email', 'test@163.com', '', '发送邮件的邮箱地址', '2021-01-22 15:28:39', '2024-06-18 10:35:41');
INSERT INTO `vel_config` VALUES (14, '授权密码', 'sys_email_password', 'text', '0', 'email', 'IUGTRIWERIW', '', '', '2021-01-22 15:29:34', '2024-06-18 10:35:41');
INSERT INTO `vel_config` VALUES (15, '服务端口', 'sys_email_port', 'text', '0', 'email', '465', '', '', '2021-01-22 15:30:05', '2024-06-18 10:35:41');
INSERT INTO `vel_config` VALUES (16, '是否SSL', 'sys_email_ssl', 'select', '0', 'email', '1', '0:否\r\n1:是', '', '2021-01-22 15:31:23', '2024-06-18 10:35:41');
INSERT INTO `vel_config` VALUES (17, '网站标题', 'web_site_name', 'text', '0', 'site', 'VelAdmin', '', '', '2021-03-24 15:09:24', '2024-06-18 10:33:57');
INSERT INTO `vel_config` VALUES (18, '水印文字', 'img_water_text', 'text', '0', 'imgwater', 'VelAdmin', '', '', '2021-07-29 20:44:32', '2024-06-19 20:50:42');
INSERT INTO `vel_config` VALUES (19, '水印文字大小', 'img_water_text_font', 'text', '0', 'imgwater', '20', '', '', '2021-07-29 20:44:48', '2024-06-19 20:50:42');
INSERT INTO `vel_config` VALUES (20, '水印文字颜色', 'img_water_text_color', 'text', '0', 'imgwater', 'ff0000', '', '', '2021-07-29 20:45:03', '2024-06-19 20:50:42');
INSERT INTO `vel_config` VALUES (21, '水印位置', 'img_water_text_position', 'select', '0', 'imgwater', '1', '1:左上角\r\n3:右上角\r\n5:垂直水平居中\r\n7:左下角\r\n9:右下角', '对应think-image的水印位置 1-9', '2021-07-29 20:45:28', '2024-06-19 20:50:42');
INSERT INTO `vel_config` VALUES (22, '是否演示模式', 'demo_mode', 'select', '0', '', '1', '1:是\r\n0:否', '', '2022-03-21 16:17:48', '2022-03-21 16:17:48');

-- ----------------------------
-- Table structure for vel_login_log
-- ----------------------------
DROP TABLE IF EXISTS `vel_login_log`;
CREATE TABLE `vel_login_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `net` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_login_log
-- ----------------------------
INSERT INTO `vel_login_log` VALUES (1, 'admin', '127.0.0.1', '本机地址', 'Chrome 126.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2024-06-18 22:09:59', '2024-06-18 22:09:59');
INSERT INTO `vel_login_log` VALUES (2, 'admin', '127.0.0.1', '本机地址', 'Chrome 126.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2024-06-18 22:15:09', '2024-06-18 22:15:09');
INSERT INTO `vel_login_log` VALUES (3, 'admin', '127.0.0.1', '本机地址', 'Chrome 126.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2024-06-18 22:33:34', '2024-06-18 22:33:34');
INSERT INTO `vel_login_log` VALUES (4, 'admin', '127.0.0.1', '本机地址', 'Chrome 126.0.0.0', 'Windows 10.0', '', '0', '验证码错误', '2024-06-19 08:31:06', '2024-06-19 08:31:06');
INSERT INTO `vel_login_log` VALUES (5, 'admin', '127.0.0.1', '本机地址', 'Chrome 126.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2024-06-19 08:31:17', '2024-06-19 08:31:17');
INSERT INTO `vel_login_log` VALUES (6, 'admin', '127.0.0.1', '本机地址', 'Chrome 126.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2024-06-19 18:40:21', '2024-06-19 18:40:21');
INSERT INTO `vel_login_log` VALUES (7, 'admin', '127.0.0.1', '本机地址', 'Chrome 126.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2024-06-19 22:13:39', '2024-06-19 22:13:39');

-- ----------------------------
-- Table structure for vel_media
-- ----------------------------
DROP TABLE IF EXISTS `vel_media`;
CREATE TABLE `vel_media`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单图',
  `imgs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '多图',
  `crop` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '裁剪图片',
  `video` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频',
  `file` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单文件',
  `files` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '多文件',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_media
-- ----------------------------

-- ----------------------------
-- Table structure for vel_menu
-- ----------------------------
DROP TABLE IF EXISTS `vel_menu`;
CREATE TABLE `vel_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父菜单ID',
  `listsort` int(11) NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '请求地址',
  `target` tinyint(1) NOT NULL DEFAULT 0 COMMENT '打开方式（0页签 1新窗口）',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '菜单状态（1显示 0隐藏）',
  `is_refresh` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否刷新（0不刷新 1刷新）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parent_id`(`parent_id`) USING BTREE,
  INDEX `listsort`(`listsort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15225 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_menu
-- ----------------------------
INSERT INTO `vel_menu` VALUES (1, '系统管理', 0, 10, '', 0, 'M', '1', '0', '', 'fa fa-cog', '2021-01-03 07:25:11', '2022-03-20 16:00:14', '系统管理');
INSERT INTO `vel_menu` VALUES (2, '权限管理', 0, 20, '', 0, 'M', '1', '0', '', 'fa fa-id-card-o', '2021-01-03 07:25:11', '2022-03-20 16:00:10', '权限管理');
INSERT INTO `vel_menu` VALUES (3, '系统工具', 0, 30, '', 0, 'M', '1', '0', '', 'fa fa-cloud', '2021-07-29 20:28:41', '2022-03-20 15:59:55', '');
INSERT INTO `vel_menu` VALUES (100, '人员管理', 2, 1, 'system/admin/index', 0, 'C', '1', '0', 'system:admin:index', 'fa fa-user-o', '2021-01-03 07:25:11', '2022-03-20 16:02:24', '人员管理');
INSERT INTO `vel_menu` VALUES (101, '角色管理', 2, 2, 'system/role/index', 0, 'C', '1', '0', 'system:role:index', 'fa fa-address-book-o', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色管理');
INSERT INTO `vel_menu` VALUES (102, '组织架构', 2, 3, 'system/struct/index', 0, 'C', '1', '0', 'system:struct:index', 'fa fa-sitemap', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织架构');
INSERT INTO `vel_menu` VALUES (103, '菜单管理', 2, 4, 'system/menu/index', 0, 'C', '1', '0', 'system:menu:index', 'fa fa-server', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单管理');
INSERT INTO `vel_menu` VALUES (104, '登录日志', 2, 5, 'system/loginlog/index', 0, 'C', '1', '0', 'system:loginlog:index', 'fa fa-paw', '2021-01-03 07:25:11', '2021-01-07 12:54:43', '登录日志');
INSERT INTO `vel_menu` VALUES (105, '参数配置', 1, 1, 'system/config/index', 0, 'C', '1', '0', 'system:config:index', 'fa fa-sliders', '2021-01-03 07:25:11', '2021-01-05 12:20:56', '参数配置');
INSERT INTO `vel_menu` VALUES (106, '网站设置', 1, 0, 'system/config/site', 0, 'C', '1', '0', 'system:config:site', 'fa fa-object-group', '2021-01-11 22:17:31', '2021-01-11 22:39:46', '网站设置');
INSERT INTO `vel_menu` VALUES (107, '通知公告', 1, 10, 'system/notice/index', 0, 'C', '1', '0', 'system:notice:index', 'fa fa-bullhorn', '2021-01-03 07:25:11', '2021-03-17 14:05:34', '通知公告');
INSERT INTO `vel_menu` VALUES (108, '岗位管理', 1, 2, 'system/position/index', 0, 'C', '1', '0', 'system:position:index', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (150, '代码生成', 3, 3, 'tool/gen/create', 0, 'C', '1', '0', 'tool:gen:create', '', '2021-07-29 20:29:15', '2022-04-12 13:40:34', '');
INSERT INTO `vel_menu` VALUES (151, '表单构建', 3, 2, 'tool/form/build', 0, 'C', '1', '0', 'tool:form:build', '', '2021-07-29 20:29:15', '2022-04-12 13:39:59', '');
INSERT INTO `vel_menu` VALUES (152, '图片操作', 3, 1, 'tool/upload/index', 0, 'C', '0', '0', 'tool:upload:index', NULL, '2021-07-29 20:29:15', '2024-06-19 22:13:56', NULL);
INSERT INTO `vel_menu` VALUES (10000, '用户新增', 100, 1, '', 0, 'F', '1', '0', 'system:admin:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '用户新增');
INSERT INTO `vel_menu` VALUES (10001, '用户修改', 100, 2, '', 0, 'F', '1', '0', 'system:admin:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '用户修改');
INSERT INTO `vel_menu` VALUES (10002, '用户删除', 100, 3, '', 0, 'F', '1', '0', 'system:admin:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '用户删除');
INSERT INTO `vel_menu` VALUES (10004, '用户状态', 100, 4, '', 0, 'F', '1', '0', 'system:admin:setstatus', '', '2021-01-03 07:25:11', '2021-01-08 10:47:09', '用户状态');
INSERT INTO `vel_menu` VALUES (10100, '角色新增', 101, 1, '', 0, 'F', '1', '0', 'system:role:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色新增');
INSERT INTO `vel_menu` VALUES (10101, '角色修改', 101, 2, '', 0, 'F', '1', '0', 'system:role:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色修改');
INSERT INTO `vel_menu` VALUES (10102, '角色删除', 101, 3, '', 0, 'F', '1', '0', 'system:role:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色删除');
INSERT INTO `vel_menu` VALUES (10104, '角色状态', 101, 4, '', 0, 'F', '1', '0', 'system:role:setstatus', '', '2021-01-03 07:25:11', '2021-01-08 10:47:31', '角色状态');
INSERT INTO `vel_menu` VALUES (10105, '菜单授权', 101, 10, '', 0, 'F', '1', '0', 'system:role:auth', '', '2021-01-03 07:25:11', '2021-01-07 13:32:41', '菜单授权');
INSERT INTO `vel_menu` VALUES (10106, '数据权限', 101, 11, '', 0, 'F', '1', '0', 'system:role:datascope', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '数据权限');
INSERT INTO `vel_menu` VALUES (10200, '组织新增', 102, 1, '', 0, 'F', '1', '0', 'system:struct:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织新增');
INSERT INTO `vel_menu` VALUES (10201, '组织修改', 102, 2, '', 0, 'F', '1', '0', 'system:struct:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织修改');
INSERT INTO `vel_menu` VALUES (10202, '组织删除', 102, 3, '', 0, 'F', '1', '0', 'system:struct:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织删除');
INSERT INTO `vel_menu` VALUES (10300, '菜单新增', 103, 1, '', 0, 'F', '1', '0', 'system:menu:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单新增');
INSERT INTO `vel_menu` VALUES (10301, '菜单修改', 103, 2, '', 0, 'F', '1', '0', 'system:menu:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单修改');
INSERT INTO `vel_menu` VALUES (10302, '菜单删除', 103, 3, '', 0, 'F', '1', '0', 'system:menu:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单删除');
INSERT INTO `vel_menu` VALUES (10400, '日志删除', 104, 0, '', 0, 'F', '1', '0', 'system:loginlog:drop', '', '2021-01-07 13:03:15', '2021-01-07 13:03:15', '日志删除');
INSERT INTO `vel_menu` VALUES (10401, '日志清空', 104, 0, '', 0, 'F', '1', '0', 'system:loginlog:trash', '', '2021-01-07 13:04:06', '2021-01-07 13:04:06', '日志清空');
INSERT INTO `vel_menu` VALUES (10500, '参数新增', 105, 1, '', 0, 'F', '1', '0', 'system:config:add', '', '2021-01-03 07:25:11', '2021-01-05 06:00:02', '参数新增');
INSERT INTO `vel_menu` VALUES (10501, '参数修改', 105, 2, '', 0, 'F', '1', '0', 'system:config:edit', '', '2021-01-03 07:25:11', '2021-01-05 06:00:25', '参数修改');
INSERT INTO `vel_menu` VALUES (10502, '参数删除', 105, 3, '', 0, 'F', '1', '0', 'system:config:drop', '', '2021-01-03 07:25:11', '2021-01-05 06:00:59', '参数删除');
INSERT INTO `vel_menu` VALUES (10503, '参数批量删除', 105, 4, '', 0, 'F', '1', '0', 'system:config:dropall', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '参数批量删除');
INSERT INTO `vel_menu` VALUES (10504, '清除缓存', 105, 5, '', 0, 'F', '1', '0', 'system:config:delcache', '', '2021-01-03 07:25:11', '2021-01-08 10:46:47', '清除缓存');
INSERT INTO `vel_menu` VALUES (10700, '公告新增', 107, 1, '', 0, 'F', '1', '0', 'system:notice:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告新增');
INSERT INTO `vel_menu` VALUES (10701, '公告修改', 107, 2, '', 0, 'F', '1', '0', 'system:notice:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告修改');
INSERT INTO `vel_menu` VALUES (10702, '公告删除', 107, 3, '', 0, 'F', '1', '0', 'system:notice:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告删除');
INSERT INTO `vel_menu` VALUES (10703, '公告批量删除', 107, 4, '', 0, 'F', '1', '0', 'system:notice:dropall', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告批量删除');
INSERT INTO `vel_menu` VALUES (10801, '添加岗位', 108, 1, '', 0, 'F', '1', '0', 'system:position:index', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (10802, '编辑岗位', 108, 2, '', 0, 'F', '1', '0', 'system:position:add', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (10803, '删除岗位', 108, 3, '', 0, 'F', '1', '0', 'system:position:dropall', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (15201, '图片添加', 152, 1, '', 0, 'F', '1', '0', 'tool:upload:add', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (15202, '图片编辑', 152, 2, '', 0, 'F', '1', '0', 'tool:upload:edit', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (15203, '图片删除', 152, 3, '', 0, 'F', '1', '0', 'tool:upload:drop', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (15204, '图片批量删除', 152, 4, '', 0, 'F', '1', '0', 'tool:upload:dropall', '', NULL, NULL, '');
INSERT INTO `vel_menu` VALUES (15205, '订单', 0, 0, 'order/order/index', 0, 'C', '1', '0', 'order:order:index', 'fa fa-sitemap', '2024-06-19 22:26:35', '2024-06-19 22:26:35', '订单');
INSERT INTO `vel_menu` VALUES (15206, '订单新增', 15205, 1, '', 0, 'F', '1', '0', 'order:order:add', '', '2024-06-19 22:26:36', '2024-06-19 22:26:36', '订单新增');
INSERT INTO `vel_menu` VALUES (15207, '订单修改', 15205, 2, '', 0, 'F', '1', '0', 'order:order:edit', '', '2024-06-19 22:26:36', '2024-06-19 22:26:36', '订单修改');
INSERT INTO `vel_menu` VALUES (15208, '订单删除', 15205, 3, '', 0, 'F', '1', '0', 'order:order:drop', '', '2024-06-19 22:26:36', '2024-06-19 22:26:36', '订单删除');
INSERT INTO `vel_menu` VALUES (15209, '订单', 0, 0, 'order/order/index', 0, 'C', '1', '0', 'order:order:index', 'fa fa-sitemap', '2024-06-19 22:44:20', '2024-06-19 22:44:20', '订单');
INSERT INTO `vel_menu` VALUES (15210, '订单新增', 15209, 1, '', 0, 'F', '1', '0', 'order:order:add', '', '2024-06-19 22:44:20', '2024-06-19 22:44:20', '订单新增');
INSERT INTO `vel_menu` VALUES (15211, '订单修改', 15209, 2, '', 0, 'F', '1', '0', 'order:order:edit', '', '2024-06-19 22:44:20', '2024-06-19 22:44:20', '订单修改');
INSERT INTO `vel_menu` VALUES (15212, '订单删除', 15209, 3, '', 0, 'F', '1', '0', 'order:order:drop', '', '2024-06-19 22:44:20', '2024-06-19 22:44:20', '订单删除');
INSERT INTO `vel_menu` VALUES (15213, '订单', 0, 0, '/order/index', 0, 'C', '1', '0', ':order:index', 'fa fa-sitemap', '2024-06-19 22:46:37', '2024-06-19 22:46:37', '订单');
INSERT INTO `vel_menu` VALUES (15214, '订单新增', 15213, 1, '', 0, 'F', '1', '0', ':order:add', '', '2024-06-19 22:46:37', '2024-06-19 22:46:37', '订单新增');
INSERT INTO `vel_menu` VALUES (15215, '订单修改', 15213, 2, '', 0, 'F', '1', '0', ':order:edit', '', '2024-06-19 22:46:37', '2024-06-19 22:46:37', '订单修改');
INSERT INTO `vel_menu` VALUES (15216, '订单删除', 15213, 3, '', 0, 'F', '1', '0', ':order:drop', '', '2024-06-19 22:46:37', '2024-06-19 22:46:37', '订单删除');
INSERT INTO `vel_menu` VALUES (15217, '订单', 0, 0, '/order/index', 0, 'C', '1', '0', ':order:index', 'fa fa-sitemap', '2024-06-19 22:49:10', '2024-06-19 22:49:10', '订单');
INSERT INTO `vel_menu` VALUES (15218, '订单新增', 15217, 1, '', 0, 'F', '1', '0', ':order:add', '', '2024-06-19 22:49:10', '2024-06-19 22:49:10', '订单新增');
INSERT INTO `vel_menu` VALUES (15219, '订单修改', 15217, 2, '', 0, 'F', '1', '0', ':order:edit', '', '2024-06-19 22:49:10', '2024-06-19 22:49:10', '订单修改');
INSERT INTO `vel_menu` VALUES (15220, '订单删除', 15217, 3, '', 0, 'F', '1', '0', ':order:drop', '', '2024-06-19 22:49:10', '2024-06-19 22:49:10', '订单删除');
INSERT INTO `vel_menu` VALUES (15221, '订单', 0, 0, '/order/index', 0, 'C', '1', '0', ':order:index', 'fa fa-sitemap', '2024-06-19 22:51:04', '2024-06-19 22:51:04', '订单');
INSERT INTO `vel_menu` VALUES (15222, '订单新增', 15221, 1, '', 0, 'F', '1', '0', ':order:add', '', '2024-06-19 22:51:04', '2024-06-19 22:51:04', '订单新增');
INSERT INTO `vel_menu` VALUES (15223, '订单修改', 15221, 2, '', 0, 'F', '1', '0', ':order:edit', '', '2024-06-19 22:51:04', '2024-06-19 22:51:04', '订单修改');
INSERT INTO `vel_menu` VALUES (15224, '订单删除', 15221, 3, '', 0, 'F', '1', '0', ':order:drop', '', '2024-06-19 22:51:04', '2024-06-19 22:51:04', '订单删除');

-- ----------------------------
-- Table structure for vel_notice
-- ----------------------------
DROP TABLE IF EXISTS `vel_notice`;
CREATE TABLE `vel_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公告标题',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公告类型（1通知 2公告）',
  `desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '公告状态（1正常 0关闭）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_notice
-- ----------------------------

-- ----------------------------
-- Table structure for vel_order
-- ----------------------------
DROP TABLE IF EXISTS `vel_order`;
CREATE TABLE `vel_order`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vel_order
-- ----------------------------

-- ----------------------------
-- Table structure for vel_position
-- ----------------------------
DROP TABLE IF EXISTS `vel_position`;
CREATE TABLE `vel_position`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位名称',
  `poskey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位标识',
  `listsort` int(11) NULL DEFAULT 100 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_position
-- ----------------------------
INSERT INTO `vel_position` VALUES (1, '总经理', 'ceo', 1, 1, '', '2022-04-04 23:04:49', '2022-04-08 12:44:52');
INSERT INTO `vel_position` VALUES (2, '部门经理', 'cpo', 2, 1, '', '2022-04-04 23:25:34', '2022-04-08 13:24:04');
INSERT INTO `vel_position` VALUES (3, '组长', 'cgo', 3, 1, '', '2022-04-04 23:26:08', '2022-04-08 12:53:33');
INSERT INTO `vel_position` VALUES (4, '员工', 'user', 4, 1, '12', '2022-04-04 23:26:50', '2022-04-13 00:45:11');

-- ----------------------------
-- Table structure for vel_role
-- ----------------------------
DROP TABLE IF EXISTS `vel_role`;
CREATE TABLE `vel_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `rolekey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色权限字符串',
  `data_scope` mediumint(5) NOT NULL DEFAULT 1 COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `listsort` int(11) NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '角色状态（1正常 0停用）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `rolekey`(`rolekey`) USING BTREE,
  INDEX `listsort`(`listsort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_role
-- ----------------------------
INSERT INTO `vel_role` VALUES (1, '超级管理员', 'administrator', 1, 0, '1', '2020-12-28 07:42:31', '2022-04-11 15:15:15', '超级管理员');
INSERT INTO `vel_role` VALUES (3, '测试角色', 'test', 8, 0, '1', '2022-03-19 23:43:03', '2022-04-13 02:00:11', '');

-- ----------------------------
-- Table structure for vel_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `vel_role_menu`;
CREATE TABLE `vel_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_role_menu
-- ----------------------------
INSERT INTO `vel_role_menu` VALUES (3, 1);
INSERT INTO `vel_role_menu` VALUES (3, 107);
INSERT INTO `vel_role_menu` VALUES (3, 3);
INSERT INTO `vel_role_menu` VALUES (3, 152);
INSERT INTO `vel_role_menu` VALUES (3, 15201);
INSERT INTO `vel_role_menu` VALUES (3, 15202);
INSERT INTO `vel_role_menu` VALUES (3, 15203);
INSERT INTO `vel_role_menu` VALUES (3, 15204);
INSERT INTO `vel_role_menu` VALUES (3, 151);
INSERT INTO `vel_role_menu` VALUES (3, 150);
INSERT INTO `vel_role_menu` VALUES (3, 90);

-- ----------------------------
-- Table structure for vel_role_struct
-- ----------------------------
DROP TABLE IF EXISTS `vel_role_struct`;
CREATE TABLE `vel_role_struct`  (
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  `struct_id` int(10) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `struct_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_role_struct
-- ----------------------------
INSERT INTO `vel_role_struct` VALUES (3, 103);
INSERT INTO `vel_role_struct` VALUES (3, 104);

-- ----------------------------
-- Table structure for vel_struct
-- ----------------------------
DROP TABLE IF EXISTS `vel_struct`;
CREATE TABLE `vel_struct`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `parent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父部门id',
  `levels` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `listsort` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '部门状态（1正常 0停用）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组织架构' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_struct
-- ----------------------------
INSERT INTO `vel_struct` VALUES (100, '深圳某某科技公司', '', 0, '0', 0, '张总', '18600000000', NULL, '1', '2024-06-19 19:05:23', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (101, '总裁办', '深圳某某科技公司', 100, '0,100', 0, '李小姐', '18611111111', NULL, '1', '2024-06-19 19:07:23', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (102, '总裁助理', '深圳某某科技公司,总裁办', 101, '0,100,101', 0, NULL, NULL, NULL, '1', '2024-06-19 19:10:24', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (103, '财务部', '深圳某某科技公司', 100, '0,100', 0, NULL, NULL, NULL, '1', '2024-06-19 19:10:49', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (104, '技术部', '深圳某某科技公司', 100, '0,100', 0, NULL, NULL, NULL, '1', '2024-06-19 19:11:19', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (105, '销售部', '深圳某某科技公司', 100, '0,100', 0, NULL, NULL, NULL, '1', '2024-06-19 19:11:29', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (106, '客服部', '深圳某某科技公司', 100, '0,100', 0, NULL, NULL, NULL, '1', '2024-06-19 19:12:48', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (107, '供应链部', '深圳某某科技公司', 100, '0,100', 0, NULL, NULL, NULL, '1', '2024-06-19 19:13:47', '2024-06-19 19:15:18');
INSERT INTO `vel_struct` VALUES (108, '行政部', '深圳某某科技公司', 100, '0,100', 0, NULL, NULL, NULL, '1', '2024-06-19 19:15:35', '2024-06-19 19:17:34');
INSERT INTO `vel_struct` VALUES (109, '会计', '深圳某某科技公司,财务部', 103, '0,100,103', 0, NULL, NULL, NULL, '1', '2024-06-19 19:18:21', '2024-06-19 19:18:21');
INSERT INTO `vel_struct` VALUES (110, '出纳', '深圳某某科技公司,财务部', 103, '0,100,103', 0, NULL, NULL, NULL, '1', '2024-06-19 19:21:02', '2024-06-19 19:22:51');
INSERT INTO `vel_struct` VALUES (111, '前端开发', '深圳某某科技公司,技术部', 104, '0,100,104', 0, NULL, NULL, NULL, '1', '2024-06-19 19:21:19', '2024-06-19 19:22:56');
INSERT INTO `vel_struct` VALUES (112, '后端开发', '深圳某某科技公司,技术部', 104, '0,100,104', 0, NULL, NULL, NULL, '1', '2024-06-19 19:21:33', '2024-06-19 19:21:33');
INSERT INTO `vel_struct` VALUES (113, '测试', '深圳某某科技公司,技术部', 104, '0,100,104', 0, NULL, NULL, NULL, '1', '2024-06-19 19:22:19', '2024-06-19 19:23:01');
INSERT INTO `vel_struct` VALUES (114, '运维', '深圳某某科技公司,技术部', 104, '0,100,104', 0, NULL, NULL, NULL, '1', '2024-06-19 19:22:40', '2024-06-19 19:23:07');

-- ----------------------------
-- Table structure for vel_wechat_access
-- ----------------------------
DROP TABLE IF EXISTS `vel_wechat_access`;
CREATE TABLE `vel_wechat_access`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `jsapi_ticket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `access_token_add` int(11) NOT NULL DEFAULT 0,
  `jsapi_ticket_add` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `appid`(`appid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信jsapi和access' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_wechat_access
-- ----------------------------
INSERT INTO `vel_wechat_access` VALUES (1, 'wx2ba634598c7df708', '56_1rs0VzqcoQD17nyWWUQMzhzRkrGgm8aYR2f6zS2Bpx22SYu7YqrsUdAf5Vd0GULJFQ1CKMaWfIqAplnP8Ks8GeYlAzbe8cgYoUF9kUVV-OQ2dJXr-BSBn50XqI0xScTCctMLRRJEComk1SvZTIPdADACRY', 'sM4AOVdWfPE4DxkXGEs8VEHh_EQ4eLTYEqfB5PSBsfjeivfj4e6h5yEFTVP-_EIn78RGwPetriPcft2bevEGcg', 1650606511, 1650606511);

-- ----------------------------
-- Table structure for vel_wechat_users
-- ----------------------------
DROP TABLE IF EXISTS `vel_wechat_users`;
CREATE TABLE `vel_wechat_users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '唯一标识',
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公众号参数',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `headimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像地址',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所属活动',
  `update_time` datetime NULL DEFAULT NULL COMMENT '资料更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  `sex` tinyint(1) NOT NULL DEFAULT 0 COMMENT '性别',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '城市',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '国家',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '省份',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`openid`, `appid`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vel_wechat_users
-- ----------------------------
INSERT INTO `vel_wechat_users` VALUES (1, 'oBi_at-f8RORVDzNs-DY42Gx2Z5Y', 'wx2ba634598c7df708', '李先生', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo5thwrUYkscpLLpLc8gx4q6CL8nxm7Ciaicjc9icMYCYEsXWaGsbkjETycFAZMVUIGmiazSDiaib7XKOgw/132', '', '2022-04-22 05:44:41', '2022-04-22 05:44:41', 0, '', '', '', 1);

SET FOREIGN_KEY_CHECKS = 1;
