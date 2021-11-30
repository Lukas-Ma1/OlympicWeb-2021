/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 100422
 Source Host           : localhost:3306
 Source Schema         : syd

 Target Server Type    : MySQL
 Target Server Version : 100422
 File Encoding         : 65001

 Date: 01/12/2021 00:03:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_assignment
-- ----------------------------
DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE `auth_assignment`  (
  `item_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`item_name`, `user_id`) USING BTREE,
  INDEX `idx-auth_assignment-user_id`(`user_id`) USING BTREE,
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_assignment
-- ----------------------------
INSERT INTO `auth_assignment` VALUES ('superboss', '4', 1638287618);

-- ----------------------------
-- Table structure for auth_item
-- ----------------------------
DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE `auth_item`  (
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `rule_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `data` blob NULL,
  `created_at` int NULL DEFAULT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE,
  INDEX `rule_name`(`rule_name`) USING BTREE,
  INDEX `idx-auth_item-type`(`type`) USING BTREE,
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_item
-- ----------------------------
INSERT INTO `auth_item` VALUES ('admin', 1, NULL, NULL, NULL, 1638287594, 1638287594);
INSERT INTO `auth_item` VALUES ('author', 1, NULL, NULL, NULL, 1638287594, 1638287594);
INSERT INTO `auth_item` VALUES ('controlAuthority', 2, 'can control authority', NULL, NULL, 1638287594, 1638287594);
INSERT INTO `auth_item` VALUES ('deleteComment', 2, 'can delete a comment', NULL, NULL, 1638287594, 1638287594);
INSERT INTO `auth_item` VALUES ('makeComment', 2, 'can make a comment', NULL, NULL, 1638287594, 1638287594);
INSERT INTO `auth_item` VALUES ('superboss', 1, NULL, NULL, NULL, 1638287594, 1638287594);

-- ----------------------------
-- Table structure for auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE `auth_item_child`  (
  `parent` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`, `child`) USING BTREE,
  INDEX `child`(`child`) USING BTREE,
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_item_child
-- ----------------------------
INSERT INTO `auth_item_child` VALUES ('admin', 'author');
INSERT INTO `auth_item_child` VALUES ('admin', 'deleteComment');
INSERT INTO `auth_item_child` VALUES ('author', 'makeComment');
INSERT INTO `auth_item_child` VALUES ('superboss', 'admin');
INSERT INTO `auth_item_child` VALUES ('superboss', 'author');
INSERT INTO `auth_item_child` VALUES ('superboss', 'controlAuthority');

-- ----------------------------
-- Table structure for auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule`  (
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `data` blob NULL,
  `created_at` int NULL DEFAULT NULL,
  `updated_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_rule
-- ----------------------------

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `comments` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, 4, '互联网数据库！！！');
INSERT INTO `comments` VALUES (2, 4, '互联网数据库！！！');
INSERT INTO `comments` VALUES (3, 4, '12313123131');

-- ----------------------------
-- Table structure for migration
-- ----------------------------
DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration`  (
  `version` varchar(180) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL,
  `apply_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`version`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migration
-- ----------------------------
INSERT INTO `migration` VALUES ('m000000_000000_base', 1638104811);
INSERT INTO `migration` VALUES ('m130524_201442_init', 1638104813);
INSERT INTO `migration` VALUES ('m140506_102106_rbac_init', 1638287085);
INSERT INTO `migration` VALUES ('m170907_052038_rbac_add_index_on_auth_assignment_user_id', 1638287085);
INSERT INTO `migration` VALUES ('m180523_151638_rbac_updates_indexes_without_prefix', 1638287086);
INSERT INTO `migration` VALUES ('m190124_110200_add_verification_token_column_to_user_table', 1638104813);
INSERT INTO `migration` VALUES ('m200409_110543_rbac_update_mssql_trigger', 1638287087);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint NOT NULL DEFAULT 10,
  `created_at` int NOT NULL,
  `updated_at` int NOT NULL,
  `verification_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `password_reset_token`(`password_reset_token`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'xYCgOvs5oauDGZRKDjanG_kdo8JKXmjC', '$2y$13$Or5n.tokcnXy0a8JQqfOAu3mPK8Rf1DBL41cH3.vbKjDPstceVpUi', NULL, '1026758184@qq.com', 9, 1638104830, 1638104830, 'Szy2XeAKTUyWyjmmbX-NeG-sbnGyrHxE_1638104830');
INSERT INTO `user` VALUES (2, 'adminmin', '0eAqpSyHTqWnfDMujT1bFqrl6CzyAeCf', '$2y$13$FDXBWdK2ve2il.LE5UH2Xe2k4iHyIgA4sMFlnV35o9ORzR9N9tP9O', NULL, '1@qq.com', 10, 1638104909, 1638104909, '5EFhkNHsKLHttoq06L4NnPOy40X6IvSM_1638104909');
INSERT INTO `user` VALUES (3, 'adminminmin', 'bewiWbGnHSgjucKi94J8mc9vhtwWNr85', '$2y$13$MEt6/9LdD1BJmKeIM0vWie.Na4ReeAepZRQES13ivn7DUwqnYwDEy', NULL, '999@qq.com', 10, 1638287294, 1638287294, '3FW7plUXALDcc58KKCVA7KCo1S088tQG_1638287294');
INSERT INTO `user` VALUES (4, 'admin123', 'sOZ60_tbrJPJvSYKd_kNI4LON1gp8SXw', '$2y$13$sQEubYLOK4X6Qvv1lEhneu8R7xzYdej.l8ff76jl1jYVjGYcnGH0y', NULL, '99999@qq.com', 10, 1638287618, 1638287618, 'bNtuzb2ERFL7vpOBOnlQHXXxXbhBW5xh_1638287618');

-- ----------------------------
-- Table structure for world_medal_show
-- ----------------------------
DROP TABLE IF EXISTS `world_medal_show`;
CREATE TABLE `world_medal_show`  (
  `排名` int NOT NULL,
  `国家` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `金牌` int NULL DEFAULT NULL,
  `银牌` int NULL DEFAULT NULL,
  `铜牌` int NULL DEFAULT NULL,
  `总数` int NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`排名`, `国家`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of world_medal_show
-- ----------------------------
INSERT INTO `world_medal_show` VALUES (1, '美国', 39, 41, 33, 113, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/USA.png');
INSERT INTO `world_medal_show` VALUES (2, '中国', 38, 32, 18, 88, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CHN.png');
INSERT INTO `world_medal_show` VALUES (3, '日本', 27, 14, 17, 58, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JPN.png');
INSERT INTO `world_medal_show` VALUES (4, '英国', 22, 21, 22, 65, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GBR.png');
INSERT INTO `world_medal_show` VALUES (5, 'ROC', 20, 28, 23, 71, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROC.png');
INSERT INTO `world_medal_show` VALUES (6, '澳大利亚', 17, 7, 22, 46, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUS.png');
INSERT INTO `world_medal_show` VALUES (7, '意大利', 10, 10, 20, 40, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ITA.png');
INSERT INTO `world_medal_show` VALUES (8, '德国', 10, 11, 16, 37, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GER.png');
INSERT INTO `world_medal_show` VALUES (9, '法国', 10, 12, 11, 33, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FRA.png');
INSERT INTO `world_medal_show` VALUES (10, '荷兰', 10, 12, 14, 36, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NED.png');
INSERT INTO `world_medal_show` VALUES (11, '古巴', 7, 3, 5, 15, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CUB.png');
INSERT INTO `world_medal_show` VALUES (12, '新西兰', 7, 6, 7, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NZL.png');
INSERT INTO `world_medal_show` VALUES (13, '巴西', 7, 6, 8, 21, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRA.png');
INSERT INTO `world_medal_show` VALUES (14, '加拿大', 7, 6, 11, 24, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CAN.png');
INSERT INTO `world_medal_show` VALUES (15, '匈牙利', 6, 7, 7, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/HUN.png');
INSERT INTO `world_medal_show` VALUES (16, '韩国', 6, 4, 10, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KOR.png');
INSERT INTO `world_medal_show` VALUES (17, '牙买加', 4, 1, 4, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JAM.png');
INSERT INTO `world_medal_show` VALUES (18, '挪威', 4, 2, 2, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NOR.png');
INSERT INTO `world_medal_show` VALUES (19, '肯尼亚', 4, 4, 2, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KEN.png');
INSERT INTO `world_medal_show` VALUES (20, '捷克', 4, 4, 3, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CZE.png');
INSERT INTO `world_medal_show` VALUES (21, '波兰', 4, 5, 5, 14, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POL.png');
INSERT INTO `world_medal_show` VALUES (22, '乌兹别克斯坦', 3, 0, 2, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UZB.png');
INSERT INTO `world_medal_show` VALUES (23, '斯洛文尼亚', 3, 1, 1, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show` VALUES (24, '保加利亚', 3, 1, 2, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show` VALUES (25, '比利时', 3, 1, 3, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BEL.png');
INSERT INTO `world_medal_show` VALUES (26, '塞尔维亚', 3, 1, 5, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SRB.png');
INSERT INTO `world_medal_show` VALUES (27, '伊朗', 3, 2, 2, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRI.png');
INSERT INTO `world_medal_show` VALUES (28, '克罗地亚', 3, 3, 2, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CRO.png');
INSERT INTO `world_medal_show` VALUES (29, '丹麦', 3, 4, 4, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DEN.png');
INSERT INTO `world_medal_show` VALUES (30, '瑞士', 3, 4, 6, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SUI.png');

-- ----------------------------
-- Table structure for world_medal_show_2008
-- ----------------------------
DROP TABLE IF EXISTS `world_medal_show_2008`;
CREATE TABLE `world_medal_show_2008`  (
  `排名` int NOT NULL,
  `国家` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `金牌` int NULL DEFAULT NULL,
  `银牌` int NULL DEFAULT NULL,
  `铜牌` int NULL DEFAULT NULL,
  `总数` int NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`排名`, `国家`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of world_medal_show_2008
-- ----------------------------
INSERT INTO `world_medal_show_2008` VALUES (1, '中国', 51, 21, 28, 100, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CHN.png');
INSERT INTO `world_medal_show_2008` VALUES (2, '美国', 36, 38, 36, 110, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/USA.png');
INSERT INTO `world_medal_show_2008` VALUES (3, '俄罗斯', 23, 21, 28, 72, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROC.png');
INSERT INTO `world_medal_show_2008` VALUES (4, '英国', 19, 13, 15, 47, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GBR.png');
INSERT INTO `world_medal_show_2008` VALUES (5, '德国', 16, 10, 15, 41, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GER.png');
INSERT INTO `world_medal_show_2008` VALUES (6, '澳大利亚', 14, 15, 17, 46, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUS.png');
INSERT INTO `world_medal_show_2008` VALUES (7, '韩国', 13, 10, 8, 31, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KOR.png');
INSERT INTO `world_medal_show_2008` VALUES (8, '日本', 9, 6, 10, 25, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JPN.png');
INSERT INTO `world_medal_show_2008` VALUES (9, '意大利', 8, 10, 10, 28, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ITA.png');
INSERT INTO `world_medal_show_2008` VALUES (10, '法国', 7, 16, 17, 40, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FRA.png');
INSERT INTO `world_medal_show_2008` VALUES (11, '乌克兰', 7, 5, 15, 27, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UKR.png');
INSERT INTO `world_medal_show_2008` VALUES (12, '荷兰', 7, 5, 4, 16, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NED.png');
INSERT INTO `world_medal_show_2008` VALUES (13, '牙买加', 6, 3, 2, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JAM.png');
INSERT INTO `world_medal_show_2008` VALUES (14, '西班牙', 5, 10, 3, 18, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PHI.png');
INSERT INTO `world_medal_show_2008` VALUES (15, '肯尼亚', 5, 5, 4, 14, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KEN.png');
INSERT INTO `world_medal_show_2008` VALUES (16, '白俄罗斯', 4, 5, 10, 19, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BLR.png');
INSERT INTO `world_medal_show_2008` VALUES (17, '罗马尼亚', 4, 1, 3, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROU.png');
INSERT INTO `world_medal_show_2008` VALUES (18, '埃塞俄比亚', 4, 1, 2, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ETH.png');
INSERT INTO `world_medal_show_2008` VALUES (19, '加拿大', 3, 9, 6, 18, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CAN.png');
INSERT INTO `world_medal_show_2008` VALUES (20, '波兰', 3, 6, 1, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POL.png');
INSERT INTO `world_medal_show_2008` VALUES (21, '匈牙利', 3, 5, 2, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/HUN.png');
INSERT INTO `world_medal_show_2008` VALUES (21, '挪威', 3, 5, 2, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NOR.png');
INSERT INTO `world_medal_show_2008` VALUES (23, '巴西', 3, 4, 8, 15, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRA.png');
INSERT INTO `world_medal_show_2008` VALUES (24, '捷克', 3, 3, 0, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CZE.png');
INSERT INTO `world_medal_show_2008` VALUES (25, '斯洛伐克', 3, 2, 1, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SVK.png');
INSERT INTO `world_medal_show_2008` VALUES (26, '新西兰', 3, 1, 5, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NZL.png');
INSERT INTO `world_medal_show_2008` VALUES (27, '格鲁吉亚', 3, 0, 3, 6, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/GEO.jpg');
INSERT INTO `world_medal_show_2008` VALUES (28, '古巴', 2, 11, 11, 24, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CUB.png');
INSERT INTO `world_medal_show_2008` VALUES (29, '哈萨克斯坦', 2, 4, 7, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KAZ.png');
INSERT INTO `world_medal_show_2008` VALUES (30, '丹麦', 2, 2, 3, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DEN.png');
INSERT INTO `world_medal_show_2008` VALUES (31, '泰国', 2, 2, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/THA.png');
INSERT INTO `world_medal_show_2008` VALUES (31, '蒙古', 2, 2, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MGL.png');
INSERT INTO `world_medal_show_2008` VALUES (33, '朝鲜', 2, 1, 3, 6, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/PRK.jpg');
INSERT INTO `world_medal_show_2008` VALUES (34, '瑞士', 2, 0, 4, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SUI.png');
INSERT INTO `world_medal_show_2008` VALUES (34, '阿根廷', 2, 0, 4, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARG.png');
INSERT INTO `world_medal_show_2008` VALUES (36, '墨西哥', 2, 0, 1, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MEX.png');
INSERT INTO `world_medal_show_2008` VALUES (37, '土耳其', 1, 4, 3, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUR.png');
INSERT INTO `world_medal_show_2008` VALUES (38, '津巴布韦', 1, 3, 0, 4, 'http://www.xinhuanet.com/olympics/aytq/delegation/Zimbabwe.gif');
INSERT INTO `world_medal_show_2008` VALUES (39, '阿塞拜疆', 1, 2, 4, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AZE.png');
INSERT INTO `world_medal_show_2008` VALUES (40, '乌兹别克斯坦', 1, 2, 3, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UZB.png');
INSERT INTO `world_medal_show_2008` VALUES (41, '斯洛文尼亚', 1, 2, 2, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2008` VALUES (42, '保加利亚', 1, 1, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show_2008` VALUES (42, '印度尼西亚', 1, 1, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2008` VALUES (44, '芬兰', 1, 1, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FIN.png');
INSERT INTO `world_medal_show_2008` VALUES (45, '拉脱维亚', 1, 1, 1, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/LAT.png');
INSERT INTO `world_medal_show_2008` VALUES (46, '多米尼加共和国', 1, 1, 0, 2, 'http://www.xinhuanet.com/olympics/aytq/delegation/DOM.gif');
INSERT INTO `world_medal_show_2008` VALUES (46, '比利时', 1, 1, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BEL.png');
INSERT INTO `world_medal_show_2008` VALUES (46, '爱沙尼亚', 1, 1, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EST.png');
INSERT INTO `world_medal_show_2008` VALUES (46, '葡萄牙', 1, 1, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POR.png');
INSERT INTO `world_medal_show_2008` VALUES (50, '印度', 1, 0, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IND.png');
INSERT INTO `world_medal_show_2008` VALUES (51, '伊朗', 1, 0, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRI.png');
INSERT INTO `world_medal_show_2008` VALUES (52, '喀麦隆', 1, 0, 0, 1, 'http://www.xinhuanet.com/olympics/aytq/delegation/Cameroon.gif');
INSERT INTO `world_medal_show_2008` VALUES (52, '巴拿马', 1, 0, 0, 1, 'http://www.xinhuanet.com/olympics/aytq/delegation/Panama.gif');
INSERT INTO `world_medal_show_2008` VALUES (52, '巴林', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRN.png');
INSERT INTO `world_medal_show_2008` VALUES (52, '突尼斯', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUN.png');
INSERT INTO `world_medal_show_2008` VALUES (56, '瑞典', 0, 4, 1, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SWE.png');
INSERT INTO `world_medal_show_2008` VALUES (57, '克罗地亚', 0, 2, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CRO.png');
INSERT INTO `world_medal_show_2008` VALUES (57, '立陶宛', 0, 2, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/LTU.png');
INSERT INTO `world_medal_show_2008` VALUES (59, '希腊', 0, 2, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GRE.png');
INSERT INTO `world_medal_show_2008` VALUES (60, '特立尼达和多巴哥', 0, 2, 0, 2, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TRI.jpg');
INSERT INTO `world_medal_show_2008` VALUES (61, '尼日利亚', 0, 1, 3, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NGR.png');
INSERT INTO `world_medal_show_2008` VALUES (62, '塞尔维亚', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SRB.png');
INSERT INTO `world_medal_show_2008` VALUES (62, '奥地利', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUT.png');
INSERT INTO `world_medal_show_2008` VALUES (62, '爱尔兰', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRL.png');
INSERT INTO `world_medal_show_2008` VALUES (65, '吉尔吉斯斯坦', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KGZ.png');
INSERT INTO `world_medal_show_2008` VALUES (65, '哥伦比亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/COL.png');
INSERT INTO `world_medal_show_2008` VALUES (65, '塔吉克斯坦', 0, 1, 1, 2, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TJK.jpg');
INSERT INTO `world_medal_show_2008` VALUES (65, '巴哈马', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BAH.png');
INSERT INTO `world_medal_show_2008` VALUES (65, '摩洛哥', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAR.png');
INSERT INTO `world_medal_show_2008` VALUES (65, '阿尔及利亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AZE.png');
INSERT INTO `world_medal_show_2008` VALUES (71, '冰岛', 0, 1, 0, 1, 'http://www.xinhuanet.com/olympics/aytq/delegation/ISL.gif');
INSERT INTO `world_medal_show_2008` VALUES (71, '南非', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/RSA.png');
INSERT INTO `world_medal_show_2008` VALUES (71, '厄瓜多尔', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ECU.png');
INSERT INTO `world_medal_show_2008` VALUES (71, '新加坡', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/SIN.jpg');
INSERT INTO `world_medal_show_2008` VALUES (71, '智利', 0, 1, 0, 1, 'http://www.xinhuanet.com/olympics/aytq/delegation/Chile.gif');
INSERT INTO `world_medal_show_2008` VALUES (71, '苏丹', 0, 1, 0, 1, 'http://www.xinhuanet.com/olympics/aytq/delegation/Sudan.gif');
INSERT INTO `world_medal_show_2008` VALUES (71, '越南', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POR.png');
INSERT INTO `world_medal_show_2008` VALUES (71, '马来西亚', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAS.png');
INSERT INTO `world_medal_show_2008` VALUES (79, '亚美尼亚', 0, 0, 6, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARM.png');
INSERT INTO `world_medal_show_2008` VALUES (80, '中华台北', 0, 0, 4, 4, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TPE.jpg');
INSERT INTO `world_medal_show_2008` VALUES (81, '以色列', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ISR.png');
INSERT INTO `world_medal_show_2008` VALUES (81, '埃及', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EGY.png');
INSERT INTO `world_medal_show_2008` VALUES (81, '多哥', 0, 0, 1, 1, 'http://www.xinhuanet.com/olympics/aytq/delegation/Togo.gif');
INSERT INTO `world_medal_show_2008` VALUES (81, '委内瑞拉', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/VEN.png');
INSERT INTO `world_medal_show_2008` VALUES (81, '摩尔多瓦', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MDA.png');
INSERT INTO `world_medal_show_2008` VALUES (81, '毛里求斯', 0, 0, 1, 1, 'http://www.xinhuanet.com/olympics/aytq/delegation/Mauritius.gif');
INSERT INTO `world_medal_show_2008` VALUES (81, '阿富汗', 0, 0, 1, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/AFG.jpg');

-- ----------------------------
-- Table structure for world_medal_show_2012
-- ----------------------------
DROP TABLE IF EXISTS `world_medal_show_2012`;
CREATE TABLE `world_medal_show_2012`  (
  `排名` int NOT NULL,
  `国家` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `金牌` int NULL DEFAULT NULL,
  `银牌` int NULL DEFAULT NULL,
  `铜牌` int NULL DEFAULT NULL,
  `总数` int NULL DEFAULT NULL,
  `Icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`排名`, `国家`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of world_medal_show_2012
-- ----------------------------
INSERT INTO `world_medal_show_2012` VALUES (1, '美国', 46, 29, 29, 104, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/USA.png');
INSERT INTO `world_medal_show_2012` VALUES (2, '中国 ', 38, 27, 23, 88, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CHN.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (3, '英国 ', 29, 17, 19, 65, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GBR.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (4, '俄罗斯', 24, 26, 32, 82, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROC.png');
INSERT INTO `world_medal_show_2012` VALUES (5, '韩国 ', 13, 8, 7, 28, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KOR.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (6, '德国 ', 11, 19, 14, 44, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GER.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (7, '法国 ', 11, 11, 12, 34, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FRA.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (8, '意大利', 8, 9, 11, 28, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ITA.png');
INSERT INTO `world_medal_show_2012` VALUES (9, '匈牙利', 8, 4, 5, 17, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/HUN.png');
INSERT INTO `world_medal_show_2012` VALUES (10, '澳大利亚', 7, 16, 12, 35, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUS.png');
INSERT INTO `world_medal_show_2012` VALUES (11, '日本 ', 7, 14, 17, 38, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JPN.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (12, '哈萨克', 7, 1, 5, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KAZ.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (13, '荷兰 ', 6, 6, 8, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NED.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (14, '乌克兰', 6, 5, 9, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UKR.png');
INSERT INTO `world_medal_show_2012` VALUES (15, '新西兰', 6, 2, 5, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NZL.png');
INSERT INTO `world_medal_show_2012` VALUES (16, '古巴 ', 5, 3, 6, 14, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CUB.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (17, '伊朗 ', 4, 5, 3, 12, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRI.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (18, '牙买加', 4, 4, 4, 12, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JAM.png');
INSERT INTO `world_medal_show_2012` VALUES (19, '捷克 ', 4, 3, 3, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CZE.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (20, '朝鲜 ', 4, 0, 2, 6, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/PRK.jpg');
INSERT INTO `world_medal_show_2012` VALUES (21, '西班牙', 3, 10, 4, 17, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PHI.png');
INSERT INTO `world_medal_show_2012` VALUES (22, '巴西 ', 3, 5, 9, 17, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRA.png\r\n');
INSERT INTO `world_medal_show_2012` VALUES (23, '南非 ', 3, 2, 1, 6, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/RSA.jpg');
INSERT INTO `world_medal_show_2012` VALUES (24, '埃塞俄比亚', 3, 1, 3, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ETH.png');
INSERT INTO `world_medal_show_2012` VALUES (25, '克罗地亚 ', 3, 1, 2, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CRO.png');
INSERT INTO `world_medal_show_2012` VALUES (26, '白俄罗斯 ', 2, 5, 5, 12, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BLR.png');
INSERT INTO `world_medal_show_2012` VALUES (27, '罗马尼亚 ', 2, 5, 2, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROU.png');
INSERT INTO `world_medal_show_2012` VALUES (28, '肯尼亚', 2, 4, 5, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KEN.png');
INSERT INTO `world_medal_show_2012` VALUES (29, '丹麦 ', 2, 4, 3, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DEN.png');
INSERT INTO `world_medal_show_2012` VALUES (30, '波兰 ', 2, 2, 6, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POL.png');
INSERT INTO `world_medal_show_2012` VALUES (31, '阿塞拜疆', 2, 2, 6, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AZE.png');
INSERT INTO `world_medal_show_2012` VALUES (32, '土耳其', 2, 2, 1, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUR.png');
INSERT INTO `world_medal_show_2012` VALUES (33, '瑞士 ', 2, 2, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SUI.png');
INSERT INTO `world_medal_show_2012` VALUES (34, '立陶宛', 2, 1, 2, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/LTU.png');
INSERT INTO `world_medal_show_2012` VALUES (35, '挪威 ', 2, 1, 1, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NOR.png');
INSERT INTO `world_medal_show_2012` VALUES (36, '加拿大', 1, 5, 12, 18, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CAN.png');
INSERT INTO `world_medal_show_2012` VALUES (37, '瑞典 ', 1, 4, 3, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SWE.png');
INSERT INTO `world_medal_show_2012` VALUES (38, '哥伦比亚 ', 1, 3, 4, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/COL.png');
INSERT INTO `world_medal_show_2012` VALUES (39, '格鲁吉亚 ', 1, 3, 3, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GEO.png');
INSERT INTO `world_medal_show_2012` VALUES (40, '墨西哥 ', 1, 3, 3, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MEX.png');
INSERT INTO `world_medal_show_2012` VALUES (41, '爱尔兰 ', 1, 1, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRL.png');
INSERT INTO `world_medal_show_2012` VALUES (42, '塞尔维亚 ', 1, 1, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SRB.png');
INSERT INTO `world_medal_show_2012` VALUES (43, '斯洛文尼亚', 1, 1, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2012` VALUES (44, '阿根廷 ', 1, 1, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARG.png');
INSERT INTO `world_medal_show_2012` VALUES (45, '突尼斯', 1, 1, 1, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUN.png');
INSERT INTO `world_medal_show_2012` VALUES (46, '多米尼加 ', 1, 1, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show_2012` VALUES (47, '乌兹别克斯坦 ', 1, 0, 3, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UZB.png');
INSERT INTO `world_medal_show_2012` VALUES (48, '特立尼达和多巴哥', 1, 0, 3, 4, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TRI.jpg');
INSERT INTO `world_medal_show_2012` VALUES (49, '拉脱维亚 ', 1, 0, 1, 2, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/LAT.jpg');
INSERT INTO `world_medal_show_2012` VALUES (50, '格林纳达', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GRN.png');
INSERT INTO `world_medal_show_2012` VALUES (51, '巴哈马', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BAH.png');
INSERT INTO `world_medal_show_2012` VALUES (52, '乌干达', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UGA.png');
INSERT INTO `world_medal_show_2012` VALUES (53, '委内瑞拉', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/VEN.png');
INSERT INTO `world_medal_show_2012` VALUES (54, '阿尔及利亚', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AZE.png');
INSERT INTO `world_medal_show_2012` VALUES (55, '印度', 0, 2, 4, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IND.png');
INSERT INTO `world_medal_show_2012` VALUES (56, '蒙古', 0, 2, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MGL.png');
INSERT INTO `world_medal_show_2012` VALUES (57, '泰国', 0, 2, 1, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/THA.png');
INSERT INTO `world_medal_show_2012` VALUES (58, '埃及', 0, 2, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EGY.png');
INSERT INTO `world_medal_show_2012` VALUES (59, '斯洛伐克', 0, 1, 3, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SVK.png');
INSERT INTO `world_medal_show_2012` VALUES (60, '比利时', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BEL.png');
INSERT INTO `world_medal_show_2012` VALUES (61, '芬兰', 0, 1, 2, 3, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/FIN.jpg');
INSERT INTO `world_medal_show_2012` VALUES (62, '亚美尼亚', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARM.png');
INSERT INTO `world_medal_show_2012` VALUES (63, '马来西亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAS.png');
INSERT INTO `world_medal_show_2012` VALUES (64, '中华台北', 0, 1, 1, 2, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TPE.jpg');
INSERT INTO `world_medal_show_2012` VALUES (65, '爱沙尼亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EST.png');
INSERT INTO `world_medal_show_2012` VALUES (66, '保加利亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show_2012` VALUES (67, '印度尼西亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2012` VALUES (68, '波多黎各', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PUR.png');
INSERT INTO `world_medal_show_2012` VALUES (69, '黑山', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/MNE.jpg');
INSERT INTO `world_medal_show_2012` VALUES (70, '博茨瓦纳', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/BOT.jpg');
INSERT INTO `world_medal_show_2012` VALUES (71, '塞浦路斯', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/CYP.jpg');
INSERT INTO `world_medal_show_2012` VALUES (72, '葡萄牙', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POR.png');
INSERT INTO `world_medal_show_2012` VALUES (73, '加蓬', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/GAB.jpg');
INSERT INTO `world_medal_show_2012` VALUES (74, '危地马拉', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/GUA.jpg');
INSERT INTO `world_medal_show_2012` VALUES (75, '卡塔尔', 0, 0, 2, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/QAT.png');
INSERT INTO `world_medal_show_2012` VALUES (76, '新加坡', 0, 0, 2, 2, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/SIN.jpg');
INSERT INTO `world_medal_show_2012` VALUES (77, '希腊', 0, 0, 2, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GRE.png');
INSERT INTO `world_medal_show_2012` VALUES (78, '摩尔多瓦', 0, 0, 2, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MDA.png');
INSERT INTO `world_medal_show_2012` VALUES (79, '巴林', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRN.png');
INSERT INTO `world_medal_show_2012` VALUES (80, '塔吉克斯坦', 0, 0, 1, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TJK.jpg');
INSERT INTO `world_medal_show_2012` VALUES (81, '中国香港', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/HKG.png');
INSERT INTO `world_medal_show_2012` VALUES (82, '摩洛哥', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAR.png');
INSERT INTO `world_medal_show_2012` VALUES (83, '沙特阿拉伯', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KSA.png');
INSERT INTO `world_medal_show_2012` VALUES (84, '科威特', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KUW.png');
INSERT INTO `world_medal_show_2012` VALUES (85, '阿富汗', 0, 0, 1, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/AFG.jpg');

-- ----------------------------
-- Table structure for world_medal_show_2016
-- ----------------------------
DROP TABLE IF EXISTS `world_medal_show_2016`;
CREATE TABLE `world_medal_show_2016`  (
  `排名` int NOT NULL,
  `国家` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `金牌` int NULL DEFAULT NULL,
  `银牌` int NULL DEFAULT NULL,
  `铜牌` int NULL DEFAULT NULL,
  `总数` int NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`排名`, `国家`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of world_medal_show_2016
-- ----------------------------
INSERT INTO `world_medal_show_2016` VALUES (1, '美国', 46, 37, 38, 121, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/USA.png');
INSERT INTO `world_medal_show_2016` VALUES (2, '英国', 27, 23, 17, 67, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GBR.png');
INSERT INTO `world_medal_show_2016` VALUES (3, '中国', 26, 18, 26, 70, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CHN.png');
INSERT INTO `world_medal_show_2016` VALUES (4, '俄罗斯', 19, 18, 19, 56, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROC.png');
INSERT INTO `world_medal_show_2016` VALUES (5, '德国', 17, 10, 15, 42, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GER.png');
INSERT INTO `world_medal_show_2016` VALUES (6, '日本', 12, 8, 21, 41, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JPN.png');
INSERT INTO `world_medal_show_2016` VALUES (7, '法国', 10, 18, 14, 42, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FRA.png');
INSERT INTO `world_medal_show_2016` VALUES (8, '韩国', 9, 3, 9, 21, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KOR.png');
INSERT INTO `world_medal_show_2016` VALUES (9, '意大利', 8, 12, 8, 28, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ITA.png');
INSERT INTO `world_medal_show_2016` VALUES (10, '澳大利亚', 8, 11, 10, 29, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUS.png');
INSERT INTO `world_medal_show_2016` VALUES (11, '荷兰', 8, 7, 4, 19, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NED.png');
INSERT INTO `world_medal_show_2016` VALUES (12, '匈牙利', 8, 3, 4, 15, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/HUN.png');
INSERT INTO `world_medal_show_2016` VALUES (13, '巴西', 7, 6, 6, 19, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRA.png');
INSERT INTO `world_medal_show_2016` VALUES (14, '西班牙', 7, 4, 6, 17, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PHI.png');
INSERT INTO `world_medal_show_2016` VALUES (15, '肯尼亚', 6, 6, 1, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KEN.png');
INSERT INTO `world_medal_show_2016` VALUES (16, '牙买加', 6, 3, 2, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JAM.png');
INSERT INTO `world_medal_show_2016` VALUES (17, '克罗地亚', 5, 3, 2, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CRO.png');
INSERT INTO `world_medal_show_2016` VALUES (18, '古巴', 5, 2, 4, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CUB.png');
INSERT INTO `world_medal_show_2016` VALUES (19, '新西兰', 4, 9, 5, 18, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NZL.png');
INSERT INTO `world_medal_show_2016` VALUES (20, '加拿大', 4, 3, 15, 22, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CAN.png');
INSERT INTO `world_medal_show_2016` VALUES (21, '乌兹别克斯坦', 4, 2, 7, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UZB.png');
INSERT INTO `world_medal_show_2016` VALUES (22, '哈萨克斯坦', 3, 5, 9, 17, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KAZ.png');
INSERT INTO `world_medal_show_2016` VALUES (23, '哥伦比亚', 3, 2, 3, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/COL.png');
INSERT INTO `world_medal_show_2016` VALUES (24, '瑞士', 3, 2, 2, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SUI.png');
INSERT INTO `world_medal_show_2016` VALUES (25, '伊朗', 3, 1, 4, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRI.png');
INSERT INTO `world_medal_show_2016` VALUES (26, '希腊', 3, 1, 2, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GRE.png');
INSERT INTO `world_medal_show_2016` VALUES (27, '阿根廷', 3, 1, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARG.png');
INSERT INTO `world_medal_show_2016` VALUES (28, '丹麦', 2, 6, 7, 15, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DEN.png');
INSERT INTO `world_medal_show_2016` VALUES (29, '瑞典', 2, 6, 3, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SWE.png');
INSERT INTO `world_medal_show_2016` VALUES (30, '南非', 2, 6, 2, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/RSA.png');
INSERT INTO `world_medal_show_2016` VALUES (31, '乌克兰', 2, 5, 4, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UKR.png');
INSERT INTO `world_medal_show_2016` VALUES (32, '塞尔维亚', 2, 4, 2, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SRB.png');
INSERT INTO `world_medal_show_2016` VALUES (33, '波兰', 2, 3, 6, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POL.png');
INSERT INTO `world_medal_show_2016` VALUES (34, '朝鲜', 2, 3, 2, 7, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/PRK.jpg');
INSERT INTO `world_medal_show_2016` VALUES (35, '比利时', 2, 2, 2, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BEL.png');
INSERT INTO `world_medal_show_2016` VALUES (35, '泰国', 2, 2, 2, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/THA.png');
INSERT INTO `world_medal_show_2016` VALUES (37, '斯洛伐克', 2, 2, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SVK.png');
INSERT INTO `world_medal_show_2016` VALUES (38, '格鲁吉亚', 2, 1, 4, 7, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/GEO.jpg');
INSERT INTO `world_medal_show_2016` VALUES (39, '阿塞拜疆', 1, 7, 10, 18, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AZE.png');
INSERT INTO `world_medal_show_2016` VALUES (40, '白俄罗斯', 1, 4, 4, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BLR.png');
INSERT INTO `world_medal_show_2016` VALUES (41, '土耳其', 1, 3, 4, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUR.png');
INSERT INTO `world_medal_show_2016` VALUES (42, '亚美尼亚', 1, 3, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARM.png');
INSERT INTO `world_medal_show_2016` VALUES (43, '捷克', 1, 2, 7, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CZE.png');
INSERT INTO `world_medal_show_2016` VALUES (44, '埃塞俄比亚', 1, 2, 5, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ETH.png');
INSERT INTO `world_medal_show_2016` VALUES (45, '斯洛文尼亚', 1, 2, 1, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2016` VALUES (46, '印度尼西亚', 1, 2, 0, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2016` VALUES (47, '罗马尼亚', 1, 1, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROU.png');
INSERT INTO `world_medal_show_2016` VALUES (48, '巴林', 1, 1, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRN.png');
INSERT INTO `world_medal_show_2016` VALUES (48, '越南', 1, 1, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POR.png');
INSERT INTO `world_medal_show_2016` VALUES (50, '中华台北', 1, 0, 2, 3, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TPE.jpg');
INSERT INTO `world_medal_show_2016` VALUES (51, '巴哈马', 1, 0, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BAH.png');
INSERT INTO `world_medal_show_2016` VALUES (51, '独立奥林匹克运动员', 1, 0, 1, 2, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/VEN.jpg');
INSERT INTO `world_medal_show_2016` VALUES (51, '科特迪瓦', 1, 0, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CIV.png');
INSERT INTO `world_medal_show_2016` VALUES (54, '塔吉克斯坦', 1, 0, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TJK.jpg');
INSERT INTO `world_medal_show_2016` VALUES (54, '斐济', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FIJ.png');
INSERT INTO `world_medal_show_2016` VALUES (54, '新加坡', 1, 0, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/SIN.jpg');
INSERT INTO `world_medal_show_2016` VALUES (54, '波多黎各', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PUR.png');
INSERT INTO `world_medal_show_2016` VALUES (54, '科索沃', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KOS.png');
INSERT INTO `world_medal_show_2016` VALUES (54, '约旦', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JOR.png');
INSERT INTO `world_medal_show_2016` VALUES (60, '马来西亚', 0, 4, 1, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAS.png');
INSERT INTO `world_medal_show_2016` VALUES (61, '墨西哥', 0, 3, 2, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MEX.png');
INSERT INTO `world_medal_show_2016` VALUES (62, '爱尔兰', 0, 2, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRL.png');
INSERT INTO `world_medal_show_2016` VALUES (62, '阿尔及利亚', 0, 2, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AZE.png');
INSERT INTO `world_medal_show_2016` VALUES (64, '立陶宛', 0, 1, 3, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/LTU.png');
INSERT INTO `world_medal_show_2016` VALUES (65, '保加利亚', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show_2016` VALUES (65, '委内瑞拉', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/VEN.png');
INSERT INTO `world_medal_show_2016` VALUES (67, '印度', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IND.png');
INSERT INTO `world_medal_show_2016` VALUES (67, '蒙古', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MGL.png');
INSERT INTO `world_medal_show_2016` VALUES (69, '卡塔尔', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/QAT.png');
INSERT INTO `world_medal_show_2016` VALUES (69, '尼日尔', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TUN.jpg');
INSERT INTO `world_medal_show_2016` VALUES (69, '布隆迪', 0, 1, 0, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/UGA.jpg');
INSERT INTO `world_medal_show_2016` VALUES (69, '格林纳达', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GRN.png');
INSERT INTO `world_medal_show_2016` VALUES (69, '菲律宾', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PHI.png');
INSERT INTO `world_medal_show_2016` VALUES (74, '挪威', 0, 0, 4, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NOR.png');
INSERT INTO `world_medal_show_2016` VALUES (75, '埃及', 0, 0, 3, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EGY.png');
INSERT INTO `world_medal_show_2016` VALUES (75, '突尼斯', 0, 0, 3, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUN.png');
INSERT INTO `world_medal_show_2016` VALUES (77, '以色列', 0, 0, 2, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ISR.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '多米尼加', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '奥地利', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUT.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '尼日利亚', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NGR.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '摩尔多瓦', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MDA.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '摩洛哥', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAR.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '爱沙尼亚', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EST.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '特立尼达和多巴哥', 0, 0, 1, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/TRI.jpg');
INSERT INTO `world_medal_show_2016` VALUES (78, '芬兰', 0, 0, 1, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/FIN.jpg');
INSERT INTO `world_medal_show_2016` VALUES (78, '葡萄牙', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POR.png');
INSERT INTO `world_medal_show_2016` VALUES (78, '阿联酋', 0, 0, 1, 1, 'http://www.sinaimg.cn/ty/08ay/data/logo/new/KSA.jpg');

-- ----------------------------
-- Table structure for world_medal_show_2020
-- ----------------------------
DROP TABLE IF EXISTS `world_medal_show_2020`;
CREATE TABLE `world_medal_show_2020`  (
  `排名` int NOT NULL,
  `国家` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `金牌` int NULL DEFAULT NULL,
  `银牌` int NULL DEFAULT NULL,
  `铜牌` int NULL DEFAULT NULL,
  `总数` int NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`排名`, `国家`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of world_medal_show_2020
-- ----------------------------
INSERT INTO `world_medal_show_2020` VALUES (1, '美国', 39, 41, 33, 113, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/USA.png');
INSERT INTO `world_medal_show_2020` VALUES (2, '中国', 38, 32, 18, 88, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CHN.png');
INSERT INTO `world_medal_show_2020` VALUES (3, '日本', 27, 14, 17, 58, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JPN.png');
INSERT INTO `world_medal_show_2020` VALUES (4, '英国', 22, 21, 22, 65, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GBR.png');
INSERT INTO `world_medal_show_2020` VALUES (5, 'ROC', 20, 28, 23, 71, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROC.png');
INSERT INTO `world_medal_show_2020` VALUES (6, '澳大利亚', 17, 7, 22, 46, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUS.png');
INSERT INTO `world_medal_show_2020` VALUES (7, '意大利', 10, 10, 20, 40, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ITA.png');
INSERT INTO `world_medal_show_2020` VALUES (8, '德国', 10, 11, 16, 37, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GER.png');
INSERT INTO `world_medal_show_2020` VALUES (9, '法国', 10, 12, 11, 33, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FRA.png');
INSERT INTO `world_medal_show_2020` VALUES (10, '荷兰', 10, 12, 14, 36, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NED.png');
INSERT INTO `world_medal_show_2020` VALUES (11, '古巴', 7, 3, 5, 15, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CUB.png');
INSERT INTO `world_medal_show_2020` VALUES (12, '新西兰', 7, 6, 7, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NZL.png');
INSERT INTO `world_medal_show_2020` VALUES (13, '巴西', 7, 6, 8, 21, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRA.png');
INSERT INTO `world_medal_show_2020` VALUES (14, '加拿大', 7, 6, 11, 24, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CAN.png');
INSERT INTO `world_medal_show_2020` VALUES (15, '韩国', 6, 4, 10, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KOR.png');
INSERT INTO `world_medal_show_2020` VALUES (16, '匈牙利', 6, 7, 7, 20, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/HUN.png');
INSERT INTO `world_medal_show_2020` VALUES (17, '牙买加', 4, 1, 4, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JAM.png');
INSERT INTO `world_medal_show_2020` VALUES (18, '挪威', 4, 2, 2, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NOR.png');
INSERT INTO `world_medal_show_2020` VALUES (19, '肯尼亚', 4, 4, 2, 10, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KEN.png');
INSERT INTO `world_medal_show_2020` VALUES (20, '捷克', 4, 4, 3, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CZE.png');
INSERT INTO `world_medal_show_2020` VALUES (21, '波兰', 4, 5, 5, 14, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POL.png');
INSERT INTO `world_medal_show_2020` VALUES (22, '乌兹别克斯坦', 3, NULL, 2, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UZB.png');
INSERT INTO `world_medal_show_2020` VALUES (23, '斯洛文尼亚', 3, 1, 1, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2020` VALUES (24, '保加利亚', 3, 1, 2, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show_2020` VALUES (25, '比利时', 3, 1, 3, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BEL.png');
INSERT INTO `world_medal_show_2020` VALUES (26, '塞尔维亚', 3, 1, 5, 9, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SRB.png');
INSERT INTO `world_medal_show_2020` VALUES (27, '伊朗', 3, 2, 2, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRI.png');
INSERT INTO `world_medal_show_2020` VALUES (28, '克罗地亚', 3, 3, 2, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CRO.png');
INSERT INTO `world_medal_show_2020` VALUES (29, '丹麦', 3, 4, 4, 11, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DEN.png');
INSERT INTO `world_medal_show_2020` VALUES (30, '瑞士', 3, 4, 6, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SUI.png');
INSERT INTO `world_medal_show_2020` VALUES (31, '斯洛文尼亚', 3, 1, 1, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2020` VALUES (32, '中国台北', 2, 4, 6, 12, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TPE.png');
INSERT INTO `world_medal_show_2020` VALUES (33, '土耳其', 2, 2, 9, 13, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUR.png');
INSERT INTO `world_medal_show_2020` VALUES (34, '希腊', 2, 1, 1, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GRE.png');
INSERT INTO `world_medal_show_2020` VALUES (35, '乌干达', 2, 1, 1, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UGA.png');
INSERT INTO `world_medal_show_2020` VALUES (36, '以色列', 2, 0, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ISR.png');
INSERT INTO `world_medal_show_2020` VALUES (36, '厄瓜多尔', 2, 1, 0, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ECU.png');
INSERT INTO `world_medal_show_2020` VALUES (38, '爱尔兰', 2, 0, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IRL.png');
INSERT INTO `world_medal_show_2020` VALUES (39, '卡塔尔', 2, 0, 1, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/QAT.png');
INSERT INTO `world_medal_show_2020` VALUES (39, '科索沃', 2, 0, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KOS.png');
INSERT INTO `world_medal_show_2020` VALUES (41, '巴哈马', 2, 0, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BAH.png');
INSERT INTO `world_medal_show_2020` VALUES (42, '乌克兰', 1, 6, 12, 19, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/UKR.png');
INSERT INTO `world_medal_show_2020` VALUES (42, '白俄罗斯', 1, 3, 3, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BLR.png');
INSERT INTO `world_medal_show_2020` VALUES (44, '罗马尼亚', 1, 3, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ROU.png');
INSERT INTO `world_medal_show_2020` VALUES (45, '委内瑞拉', 1, 3, 0, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/VEN.png');
INSERT INTO `world_medal_show_2020` VALUES (46, '中国香港', 1, 2, 3, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/HKG.png');
INSERT INTO `world_medal_show_2020` VALUES (46, '印度', 1, 2, 4, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/IND.png');
INSERT INTO `world_medal_show_2020` VALUES (48, '菲律宾', 1, 2, 1, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PHI.png');
INSERT INTO `world_medal_show_2020` VALUES (49, '斯洛伐克', 1, 2, 1, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SVK.png');
INSERT INTO `world_medal_show_2020` VALUES (50, '南非', 1, 2, 0, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/RSA.png');
INSERT INTO `world_medal_show_2020` VALUES (50, '奥地利', 1, 1, 5, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AUT.png');
INSERT INTO `world_medal_show_2020` VALUES (52, '埃及', 1, 1, 4, 6, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EGY.png');
INSERT INTO `world_medal_show_2020` VALUES (53, '印度尼西亚', 1, 1, 3, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/INA.png');
INSERT INTO `world_medal_show_2020` VALUES (54, '葡萄牙', 1, 1, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/POR.png');
INSERT INTO `world_medal_show_2020` VALUES (55, '埃塞俄比亚', 1, 1, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ETH.png');
INSERT INTO `world_medal_show_2020` VALUES (56, '爱沙尼亚', 1, 0, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/EST.png');
INSERT INTO `world_medal_show_2020` VALUES (56, '突尼斯', 1, 1, 0, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TUN.png');
INSERT INTO `world_medal_show_2020` VALUES (58, '泰国', 1, 0, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/THA.png');
INSERT INTO `world_medal_show_2020` VALUES (59, '拉脱维亚', 1, 0, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/LAT.png');
INSERT INTO `world_medal_show_2020` VALUES (59, '斐济', 1, 0, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FIJ.png');
INSERT INTO `world_medal_show_2020` VALUES (59, '波多黎各', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/PUR.png');
INSERT INTO `world_medal_show_2020` VALUES (59, '百慕大', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BER.png');
INSERT INTO `world_medal_show_2020` VALUES (63, '哥伦比亚', 0, 4, 1, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/COL.png');
INSERT INTO `world_medal_show_2020` VALUES (63, '摩洛哥', 1, 0, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAR.png');
INSERT INTO `world_medal_show_2020` VALUES (63, '阿塞拜疆', 0, 3, 4, 7, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/AZE.png');
INSERT INTO `world_medal_show_2020` VALUES (66, '多米尼加', 0, 3, 2, 5, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/DOM.png');
INSERT INTO `world_medal_show_2020` VALUES (67, '亚美尼亚', 0, 2, 2, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARM.png');
INSERT INTO `world_medal_show_2020` VALUES (68, '吉尔吉斯斯坦', 0, 2, 1, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KGZ.png');
INSERT INTO `world_medal_show_2020` VALUES (69, '蒙古', 0, 1, 3, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MGL.png');
INSERT INTO `world_medal_show_2020` VALUES (70, '阿根廷', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/ARG.png');
INSERT INTO `world_medal_show_2020` VALUES (71, '圣马力诺', 0, 1, 2, 3, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SMR.png');
INSERT INTO `world_medal_show_2020` VALUES (72, '约旦', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/JOR.png');
INSERT INTO `world_medal_show_2020` VALUES (72, '马来西亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MAS.png');
INSERT INTO `world_medal_show_2020` VALUES (74, '北马其顿', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MKD.png');
INSERT INTO `world_medal_show_2020` VALUES (74, '土库曼斯坦', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/TKM.png');
INSERT INTO `world_medal_show_2020` VALUES (74, '尼日利亚', 0, 1, 1, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NGR.png');
INSERT INTO `world_medal_show_2020` VALUES (77, '哈萨克斯坦', 0, 0, 8, 8, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KAZ.png');
INSERT INTO `world_medal_show_2020` VALUES (77, '墨西哥', 0, 0, 4, 4, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MEX.png');
INSERT INTO `world_medal_show_2020` VALUES (77, '巴林', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BRN.png');
INSERT INTO `world_medal_show_2020` VALUES (77, '沙特阿拉伯', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KSA.png');
INSERT INTO `world_medal_show_2020` VALUES (77, '立陶宛', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/LTU.png');
INSERT INTO `world_medal_show_2020` VALUES (77, '纳米比亚', 0, 1, 0, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/NAM.png');
INSERT INTO `world_medal_show_2020` VALUES (83, '芬兰', 0, 0, 2, 2, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/FIN.png');
INSERT INTO `world_medal_show_2020` VALUES (84, '科威特', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/KUW.png');
INSERT INTO `world_medal_show_2020` VALUES (85, '科特迪瓦', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/CIV.png');
INSERT INTO `world_medal_show_2020` VALUES (86, '加纳', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GHA.png');
INSERT INTO `world_medal_show_2020` VALUES (86, '叙利亚', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/SYR.png');
INSERT INTO `world_medal_show_2020` VALUES (86, '布基纳法索', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/BUR.png');
INSERT INTO `world_medal_show_2020` VALUES (86, '摩尔多瓦', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/MDA.png');
INSERT INTO `world_medal_show_2020` VALUES (86, '格林纳达', 0, 0, 1, 1, 'http://p1.img.cctvpic.com/sports/data/olympic/teamImg/GRN.png');

