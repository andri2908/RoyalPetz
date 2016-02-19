CREATE DATABASE  IF NOT EXISTS `sys_pos` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sys_pos`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: sys_pos
-- ------------------------------------------------------
-- Server version	5.5.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `master_branch`
--

DROP TABLE IF EXISTS `master_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_branch` (
  `BRANCH_ID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `BRANCH_NAME` varchar(50) NOT NULL,
  `BRANCH_ADDRESS_1` varchar(50) DEFAULT NULL,
  `BRANCH_ADDRESS_2` varchar(50) DEFAULT NULL,
  `BRANCH_ADDRESS_CITY` varchar(50) DEFAULT NULL,
  `BRANCH_TELEPHONE` varchar(15) DEFAULT NULL,
  `BRANCH_IP4` varchar(15) NOT NULL,
  `BRANCH_ACTIVE` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`BRANCH_ID`),
  UNIQUE KEY `BRANCH_NAME_UNIQUE` (`BRANCH_NAME`),
  UNIQUE KEY `BRANCH_IP4_UNIQUE` (`BRANCH_IP4`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_branch`
--

LOCK TABLES `master_branch` WRITE;
/*!40000 ALTER TABLE `master_branch` DISABLE KEYS */;
INSERT INTO `master_branch` VALUES (1,'cabang 1','1111','','','123','1921681  100',1);
/*!40000 ALTER TABLE `master_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_category`
--

DROP TABLE IF EXISTS `master_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_category` (
  `CATEGORY_ID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `CATEGORY_NAME` varchar(50) DEFAULT NULL,
  `CATEGORY_DESCRIPTION` varchar(100) DEFAULT NULL,
  `CATEGORY_ACTIVE` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`CATEGORY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_category`
--

LOCK TABLES `master_category` WRITE;
/*!40000 ALTER TABLE `master_category` DISABLE KEYS */;
INSERT INTO `master_category` VALUES (1,'promo','promo category 22',1),(2,'aaaa','aaaa',1);
/*!40000 ALTER TABLE `master_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_customer`
--

DROP TABLE IF EXISTS `master_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_customer` (
  `CUSTOMER_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `CUSTOMER_FULL_NAME` varchar(50) DEFAULT NULL,
  `CUSTOMER_ADDRESS1` varchar(50) DEFAULT NULL,
  `CUSTOMER_ADDRESS2` varchar(50) DEFAULT NULL,
  `CUSTOMER_ADDRESS_CITY` varchar(50) DEFAULT NULL,
  `CUSTOMER_PHONE` varchar(15) DEFAULT NULL,
  `CUSTOMER_FAX` varchar(15) DEFAULT NULL,
  `CUSTOMER_EMAIL` varchar(50) DEFAULT NULL,
  `CUSTOMER_ACTIVE` tinyint(3) unsigned DEFAULT NULL,
  `CUSTOMER_JOINED_DATE` date DEFAULT NULL,
  `CUSTOMER_TOTAL_SALES_COUNT` int(11) DEFAULT NULL,
  `CUSTOMER_GROUP` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`CUSTOMER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_customer`
--

LOCK TABLES `master_customer` WRITE;
/*!40000 ALTER TABLE `master_customer` DISABLE KEYS */;
INSERT INTO `master_customer` VALUES (1,'name 1','address 1','address 2','city','phone','fax','aa.aa.aa',1,'0000-00-00',123,1),(2,'name 1234','address 1','address 2','city','123','123','aa.aa.aa',1,'2016-02-16',123,1),(3,'andri111','andri','andri','andri','123','123','aa.aa.aa',1,'2016-02-15',123,2),(4,'andri 1234','andri 1','andri 1','andri 1234','123','56','andri 1123',1,'2016-02-17',0,3);
/*!40000 ALTER TABLE `master_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_group`
--

DROP TABLE IF EXISTS `master_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_group` (
  `GROUP_ID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `GROUP_USER_NAME` varchar(50) NOT NULL,
  `GROUP_USER_DESCRIPTION` varchar(100) NOT NULL,
  `GROUP_USER_ACTIVE` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`GROUP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_group`
--

LOCK TABLES `master_group` WRITE;
/*!40000 ALTER TABLE `master_group` DISABLE KEYS */;
INSERT INTO `master_group` VALUES (1,'group 1','group 1 test group',0),(2,'GLOBAL_ADMIN','GLOBAL ADMIN GROUP',1),(3,'group test','test group',1),(4,'aaa','aaaaa',1),(5,'bbbb','bbbbbb',1),(6,'cccc','ccccccc',1),(7,'sdadsadas','sadadsadasdas',1),(8,'aaaaaaaaaaassssaaaaaa','aaaaaaaa',1),(9,'123','123',1),(10,'asdfg','asdfgh',1),(11,'asdfg','asdfgh',1);
/*!40000 ALTER TABLE `master_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_module`
--

DROP TABLE IF EXISTS `master_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_module` (
  `MODULE_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `MODULE_NAME` varchar(50) DEFAULT NULL,
  `MODULE_DESCRIPTION` varchar(100) DEFAULT NULL,
  `MODULE_FEATURES` tinyint(3) unsigned DEFAULT NULL,
  `MODULE_ACTIVE` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`MODULE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_module`
--

LOCK TABLES `master_module` WRITE;
/*!40000 ALTER TABLE `master_module` DISABLE KEYS */;
INSERT INTO `master_module` VALUES (1,'CHANGE PASSWORD',NULL,1,1),(2,'PENGATURAN LOKASI DATABASE',NULL,1,1),(3,'BACKUP / RESTORE DATABASE',NULL,1,1),(4,'TAMBAH / HAPUS GRUP',NULL,7,1),(5,'PENGATURAN GRUP AKSES',NULL,1,1),(6,'TAMBAH / HAPUS USER',NULL,7,1),(7,'PENGATURAN ALAMAT IP PUSAT',NULL,1,1),(8,'TAMBAH / HAPUS CABANG',NULL,7,1);
/*!40000 ALTER TABLE `master_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_product`
--

DROP TABLE IF EXISTS `master_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_product` (
  `ID` int(10) unsigned NOT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_BARCODE` int(10) unsigned DEFAULT NULL,
  `PRODUCT_NAME` varchar(50) DEFAULT NULL,
  `PRODUCT_DESCRIPTION` varchar(100) DEFAULT NULL,
  `PRODUCT_BASE_PRICE` double DEFAULT NULL,
  `PRODUCT_RETAIL_PRICE` double DEFAULT NULL,
  `PRODUCT_BULK_PRICE` double DEFAULT NULL,
  `PRODUCT_WHOLESALE_PRICE` double DEFAULT NULL,
  `PRODUCT_PHOTO_1` varchar(50) DEFAULT NULL,
  `UNIT_ID` smallint(5) unsigned DEFAULT NULL,
  `PRODUCT_STOCK_QTY` double DEFAULT NULL,
  `PRODUCT_LIMIT_STOCK` double DEFAULT NULL,
  `PRODUCT_SHELVES` varchar(5) DEFAULT NULL,
  `PRODUCT_ACTIVE` tinyint(3) unsigned DEFAULT NULL,
  `PRODUCT_BRAND` varchar(50) DEFAULT NULL,
  `PRODUCT_IS_SERVICE` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PRODUCT_ID_UNIQUE` (`PRODUCT_ID`),
  UNIQUE KEY `PRODUCT_BARCODE_UNIQUE` (`PRODUCT_BARCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_product`
--

LOCK TABLES `master_product` WRITE;
/*!40000 ALTER TABLE `master_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_supplier`
--

DROP TABLE IF EXISTS `master_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_supplier` (
  `SUPPLIER_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `SUPPLIER_FULL_NAME` varchar(50) DEFAULT NULL,
  `SUPPLIER_ADDRESS1` varchar(50) DEFAULT NULL,
  `SUPPLIER_ADDRESS2` varchar(50) DEFAULT NULL,
  `SUPPLIER_ADDRESS_CITY` varchar(50) DEFAULT NULL,
  `SUPPLIER_PHONE` varchar(15) DEFAULT NULL,
  `SUPPLIER_FAX` varchar(15) DEFAULT NULL,
  `SUPPLIER_EMAIL` varchar(50) DEFAULT NULL,
  `SUPPLIER_ACTIVE` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`SUPPLIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_supplier`
--

LOCK TABLES `master_supplier` WRITE;
/*!40000 ALTER TABLE `master_supplier` DISABLE KEYS */;
INSERT INTO `master_supplier` VALUES (1,'supplier baru','aaaannnnn','aaaa','aaaa','aaaaa','aaaaaa','aaaa',1);
/*!40000 ALTER TABLE `master_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_unit`
--

DROP TABLE IF EXISTS `master_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_unit` (
  `UNIT_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `UNIT_NAME` varchar(50) DEFAULT NULL,
  `UNIT_DESCRIPTION` varchar(100) DEFAULT NULL,
  `UNIT_ACTIVE` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`UNIT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_unit`
--

LOCK TABLES `master_unit` WRITE;
/*!40000 ALTER TABLE `master_unit` DISABLE KEYS */;
INSERT INTO `master_unit` VALUES (1,'aa','aa',1),(2,'vv','vv',1),(3,'aaa','aaaa',1);
/*!40000 ALTER TABLE `master_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_user`
--

DROP TABLE IF EXISTS `master_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_user` (
  `ID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(15) DEFAULT NULL,
  `USER_PASSWORD` varchar(15) DEFAULT NULL,
  `USER_FULL_NAME` varchar(50) DEFAULT NULL,
  `USER_PHONE` varchar(15) DEFAULT NULL,
  `USER_ACTIVE` tinyint(1) unsigned DEFAULT NULL,
  `GROUP_ID` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_NAME_UNIQUE` (`USER_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_user`
--

LOCK TABLES `master_user` WRITE;
/*!40000 ALTER TABLE `master_user` DISABLE KEYS */;
INSERT INTO `master_user` VALUES (1,'admin','admin','ADMIN','1',1,2);
/*!40000 ALTER TABLE `master_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_convert`
--

DROP TABLE IF EXISTS `unit_convert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_convert` (
  `CONVERT_UNIT_ID_1` smallint(5) unsigned NOT NULL,
  `CONVERT_UNIT_ID_2` smallint(5) unsigned NOT NULL,
  `CONVERT_MULTIPLIER` float DEFAULT NULL,
  PRIMARY KEY (`CONVERT_UNIT_ID_1`,`CONVERT_UNIT_ID_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_convert`
--

LOCK TABLES `unit_convert` WRITE;
/*!40000 ALTER TABLE `unit_convert` DISABLE KEYS */;
INSERT INTO `unit_convert` VALUES (1,2,50.5);
/*!40000 ALTER TABLE `unit_convert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_access_management`
--

DROP TABLE IF EXISTS `user_access_management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_access_management` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `GROUP_ID` tinyint(3) unsigned DEFAULT NULL,
  `MODULE_ID` smallint(5) unsigned DEFAULT NULL,
  `USER_ACCESS_OPTION` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_access_management`
--

LOCK TABLES `user_access_management` WRITE;
/*!40000 ALTER TABLE `user_access_management` DISABLE KEYS */;
INSERT INTO `user_access_management` VALUES (1,2,1,0),(2,2,2,1),(3,1,1,1),(4,1,2,1),(5,2,4,6),(6,2,3,0),(7,2,5,0),(8,2,6,0),(9,2,7,0),(10,2,8,0),(11,11,1,0),(12,11,2,0),(13,11,3,0),(14,11,4,0),(15,11,5,0),(16,11,6,4),(17,11,7,1),(18,11,8,0);
/*!40000 ALTER TABLE `user_access_management` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-17  0:07:49