/*
 Navicat Premium Data Transfer

 Source Server         : localhost 
 Source Server Type    : MySQL
 Source Server Version : 50635
 Source Host           : localhost
 Source Database       : bamazon_db

 Target Server Type    : MySQL
 Target Server Version : 50635
 File Encoding         : utf-8

 Date: 02/18/2017 07:43:12 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `departments`
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(30) NOT NULL,
  `over_head_costs` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `departments`
-- ----------------------------
BEGIN;
INSERT INTO `departments` VALUES ('1', 'electronics', '1'), ('2', 'cat_apparel', '1'), ('3', 'kitchen', '1');
COMMIT;

-- ----------------------------
--  Table structure for `products`
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(30) NOT NULL,
  `department_id` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `products`
-- ----------------------------
BEGIN;
INSERT INTO `products` VALUES ('1', 'kitty_slippers', '2', '9.00', '184'), ('2', 'feline_good_sweater', '2', '20.00', '4'), ('3', 'kitten_mittens', '2', '30.00', '7'), ('4', 'obnoxious_cat_bag', '2', '8.00', '1'), ('5', 'oven_mit', '3', '10.50', '54'), ('6', 'food_processor', '3', '34.99', '4'), ('7', 'cast_iron_skillet', '3', '30.00', '5'), ('8', 'fitbit', '1', '99.99', '500'), ('9', '4k_monitor', '1', '450.00', '11'), ('10', 'hdmi_cable', '1', '9.00', '1000');
COMMIT;

-- ----------------------------
--  Table structure for `sales`
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `quantity_purchased` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sales`
-- ----------------------------
BEGIN;
INSERT INTO `sales` VALUES ('1', '1', '2', '2017-02-17 20:10:11'), ('2', '1', '3', '2017-02-17 20:19:52'), ('3', '1', '4', '2017-02-17 20:20:35'), ('4', '1', '3', '2017-02-17 20:21:28'), ('5', '3', '4', '2017-02-17 20:23:43');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
