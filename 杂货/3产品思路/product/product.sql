/*
 Navicat MySQL Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50646
 Source Host           : localhost:3306
 Source Schema         : test1

 Target Server Type    : MySQL
 Target Server Version : 50646
 File Encoding         : 65001

 Date: 30/10/2020 16:00:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pro_core_info
-- ----------------------------
DROP TABLE IF EXISTS `pro_core_info`;
CREATE TABLE `pro_core_info`  (
  `pro_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品ID',
  `shop_id` int(11) UNSIGNED NOT NULL COMMENT '店铺信息',
  `video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品视频信息',
  `img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品图片信息',
  `tmplate` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品在详情页中展示的模板ID',
  `spec_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品是否以规格形式展示。规格包的ID',
  `article_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '详情信息',
  `is_virtual` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1-实物；2-虚拟物品(无需物流等)',
  `purchase_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '进货价',
  `purchase_price_currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '进货价的货币符',
  PRIMARY KEY (`pro_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_core_info
-- ----------------------------

-- ----------------------------
-- Table structure for pro_core_list
-- ----------------------------
DROP TABLE IF EXISTS `pro_core_list`;
CREATE TABLE `pro_core_list`  (
  `pro_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) UNSIGNED NOT NULL COMMENT '店铺信息',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '封面(一个链接，可图片可视频)',
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 2 COMMENT '商品状态。1-正常；2-下架中；3-删除',
  `show_list` tinyint(2) UNSIGNED NOT NULL DEFAULT 2 COMMENT '在list中是否显示,1-显示；2-不显示',
  `sku` bigint(20) UNSIGNED NOT NULL COMMENT 'sku',
  `inventory_status` tinyint(2) UNSIGNED NOT NULL DEFAULT 2 COMMENT '库存状态。如果库存有则为1-没有则为2',
  `inventory_id` int(11) NOT NULL COMMENT '库存ID',
  `comment_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数量-用于排序',
  `sale_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销售数量-用于排序',
  `price` decimal(10, 2) NOT NULL,
  `origin_price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`pro_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_core_list
-- ----------------------------

-- ----------------------------
-- Table structure for pro_core_sku
-- ----------------------------
DROP TABLE IF EXISTS `pro_core_sku`;
CREATE TABLE `pro_core_sku`  (
  `sku` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pro_id` bigint(20) UNSIGNED NOT NULL,
  `attr_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`sku`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_core_sku
-- ----------------------------

-- ----------------------------
-- Table structure for pro_info_article
-- ----------------------------
DROP TABLE IF EXISTS `pro_info_article`;
CREATE TABLE `pro_info_article`  (
  `article_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `last_at` int(11) NULL DEFAULT 0 COMMENT '最新更新时间',
  PRIMARY KEY (`article_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_info_article
-- ----------------------------

-- ----------------------------
-- Table structure for pro_info_attr
-- ----------------------------
DROP TABLE IF EXISTS `pro_info_attr`;
CREATE TABLE `pro_info_attr`  (
  `attr_id` bigint(20) NOT NULL,
  `shop_id` int(11) NOT NULL COMMENT '店铺信息',
  `pro_id` bigint(20) NOT NULL COMMENT '商品信息',
  `detail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '当type=color时red/blue',
  `type` tinyint(3) NOT NULL COMMENT '1-color;2-size',
  `last_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`attr_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_info_attr
-- ----------------------------

-- ----------------------------
-- Table structure for pro_info_inventory
-- ----------------------------
DROP TABLE IF EXISTS `pro_info_inventory`;
CREATE TABLE `pro_info_inventory`  (
  `inventory_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) UNSIGNED NOT NULL COMMENT '店铺信息',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `inventory` decimal(10, 2) UNSIGNED NOT NULL COMMENT '真实库存',
  `top_inventory_id` int(11) UNSIGNED NOT NULL COMMENT '顶级库存ID',
  `parent_inventory_id` int(11) UNSIGNED NOT NULL COMMENT '上级库存ID',
  `parent_num` decimal(10, 2) UNSIGNED NOT NULL COMMENT '一个[上级库存] = parent_num个[当前库存]',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单位',
  `last_at` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最新更新时间',
  PRIMARY KEY (`inventory_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_info_inventory
-- ----------------------------

-- ----------------------------
-- Table structure for pro_info_spec
-- ----------------------------
DROP TABLE IF EXISTS `pro_info_spec`;
CREATE TABLE `pro_info_spec`  (
  `spec_id` int(11) NOT NULL,
  `shop_id` int(11) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '[{\"pro_id\":1,\"title\":\"规格描述\",\"img\":\"规格小图\"}]',
  `last_at` int(11) NULL DEFAULT 0 COMMENT '最新更新时间',
  PRIMARY KEY (`spec_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_info_spec
-- ----------------------------

-- ----------------------------
-- Table structure for pro_info_video
-- ----------------------------
DROP TABLE IF EXISTS `pro_info_video`;
CREATE TABLE `pro_info_video`  (
  `video_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL COMMENT '店铺信息',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '本条video的标题',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'video连接',
  `last_at` int(11) NOT NULL DEFAULT 0 COMMENT '最新更新时间',
  PRIMARY KEY (`video_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_info_video
-- ----------------------------

-- ----------------------------
-- Table structure for pro_log_inventory
-- ----------------------------
DROP TABLE IF EXISTS `pro_log_inventory`;
CREATE TABLE `pro_log_inventory`  (
  `id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `pro_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `type` tinyint(2) NOT NULL COMMENT '1-add;2-sub',
  `num` decimal(10, 0) NOT NULL,
  `create_at` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of pro_log_inventory
-- ----------------------------

-- ----------------------------
-- Table structure for pro_log_list
-- ----------------------------
DROP TABLE IF EXISTS `pro_log_list`;
CREATE TABLE `pro_log_list`  (
  `id` bigint(20) NOT NULL,
  `pro_id` bigint(20) NOT NULL COMMENT '商品ID',
  `shop_id` int(11) NOT NULL,
  `type` tinyint(2) NOT NULL COMMENT '1-insert;2-update;3-delete\'',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作具体内容{\"title\":{\"old\":\"it is old\",\"new\":\"it is new\"}}',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作员ip',
  `role_id` int(11) NOT NULL DEFAULT 0 COMMENT '操作员的ID',
  `create_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pro_log_list
-- ----------------------------

-- ----------------------------
-- Table structure for shop_set_currency
-- ----------------------------
DROP TABLE IF EXISTS `shop_set_currency`;
CREATE TABLE `shop_set_currency`  (
  `id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `radio` decimal(10, 10) NOT NULL COMMENT '1USD=7CNY,若main_currency=CNY,currency=USD;此处填写值为7',
  `status` tinyint(2) NOT NULL DEFAULT 2 COMMENT '1-正常；2-暂停；3-删除',
  `last_at` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_set_currency
-- ----------------------------

-- ----------------------------
-- Table structure for static_currency
-- ----------------------------
DROP TABLE IF EXISTS `static_currency`;
CREATE TABLE `static_currency`  (
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货币英文简写',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '货币符号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '货币中文称呼',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '货币备注',
  PRIMARY KEY (`currency`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '记录全世界的货币简称及其符号' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of static_currency
-- ----------------------------
INSERT INTO `static_currency` VALUES ('CNY', '¥', '人民币', '');
INSERT INTO `static_currency` VALUES ('USD', '$', '美元', '');
INSERT INTO `static_currency` VALUES ('GBP', '￡', '英镑', '');
INSERT INTO `static_currency` VALUES ('FRF', '', '法郎', '');
INSERT INTO `static_currency` VALUES ('HKD', '', '港元', '');
INSERT INTO `static_currency` VALUES ('JPY', '', '日元', '');
INSERT INTO `static_currency` VALUES ('CHF', '', '瑞士法郎', '');
INSERT INTO `static_currency` VALUES ('CAD', '', '加拿大元', '');
INSERT INTO `static_currency` VALUES ('NLG', '', '荷兰盾', '');
INSERT INTO `static_currency` VALUES ('DEM', '', '德国马克', '');
INSERT INTO `static_currency` VALUES ('BEF', '', '比利时法郎', '');
INSERT INTO `static_currency` VALUES ('AUD', '', '澳大利亚元', '');
INSERT INTO `static_currency` VALUES ('INR', '', '卢布', '印度');
INSERT INTO `static_currency` VALUES ('THP', '฿', '泰铢', '');
INSERT INTO `static_currency` VALUES ('SGD', '', '新加坡元', '');
INSERT INTO `static_currency` VALUES ('BUK', '', '缅元', '缅甸');
INSERT INTO `static_currency` VALUES ('LKR', '', '斯里兰卡卢比', '');
INSERT INTO `static_currency` VALUES ('MVR', '', '马尔代夫卢比', '');
INSERT INTO `static_currency` VALUES ('IDR', '', '盾', '印度尼西亚');
INSERT INTO `static_currency` VALUES ('PRK', '', '巴基斯坦卢比', '');
INSERT INTO `static_currency` VALUES ('NPR', '', '尼泊尔卢比', '');
INSERT INTO `static_currency` VALUES ('AFA', '', '阿富汗尼', '阿富汗');
INSERT INTO `static_currency` VALUES ('IRR', '', '伊朗尼亚尔', '伊朗');
INSERT INTO `static_currency` VALUES ('IQD', '', '伊拉克第纳尔', '伊拉克');
INSERT INTO `static_currency` VALUES ('SYP', '', '叙利亚镑', '叙利亚');
INSERT INTO `static_currency` VALUES ('LBP', '', '黎巴嫩镑', '黎巴嫩');
INSERT INTO `static_currency` VALUES ('SAR', '', '亚尔', '沙特阿拉伯');
INSERT INTO `static_currency` VALUES ('EUR', '€', '欧元', '');
INSERT INTO `static_currency` VALUES ('KRW', '', '韩国元', '');
INSERT INTO `static_currency` VALUES ('SUR', '', '俄罗斯卢布', '');
INSERT INTO `static_currency` VALUES ('PHP', '', '菲律宾比索', '');
INSERT INTO `static_currency` VALUES ('ITL', '', '意大利里拉', '');
INSERT INTO `static_currency` VALUES ('ATS', '', '奥地利先令', '');
INSERT INTO `static_currency` VALUES ('a', '₫', '越南盾', '');

-- ----------------------------
-- Table structure for tb_shop
-- ----------------------------
DROP TABLE IF EXISTS `tb_shop`;
CREATE TABLE `tb_shop`  (
  `shop_id` int(10) UNSIGNED NOT NULL,
  `main_currency` tinyint(2) UNSIGNED NOT NULL COMMENT '主货币。填写商品信息都是用的主货币。包括进销存都同一使用主货币',
  PRIMARY KEY (`shop_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of tb_shop
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
