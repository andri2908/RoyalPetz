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
-- Table structure for table `account_credit`
--

DROP TABLE IF EXISTS `account_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_credit` (
  `credit_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `credit_sales_id` int(10) unsigned NOT NULL,
  `credit_duedate` date NOT NULL,
  `credit_nominal` double NOT NULL,
  `credit_paid` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`credit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_credit`
--

LOCK TABLES `account_credit` WRITE;
/*!40000 ALTER TABLE `account_credit` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_debt`
--

DROP TABLE IF EXISTS `account_debt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_debt` (
  `debt_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debt_purchase_id` int(10) unsigned NOT NULL,
  `debt_duedate` date NOT NULL,
  `debt_nominal` double NOT NULL,
  `debt_paid` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`debt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_debt`
--

LOCK TABLES `account_debt` WRITE;
/*!40000 ALTER TABLE `account_debt` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_debt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_journal`
--

DROP TABLE IF EXISTS `account_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_journal` (
  `journal_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` smallint(5) unsigned NOT NULL,
  `journal_date` date NOT NULL,
  `account_nominal` double NOT NULL,
  `branch_id` tinyint(3) unsigned NOT NULL,
  `journal_description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_journal`
--

LOCK TABLES `account_journal` WRITE;
/*!40000 ALTER TABLE `account_journal` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit`
--

DROP TABLE IF EXISTS `credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit` (
  `CREDIT_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SALES_INVOICE` varchar(30) DEFAULT NULL,
  `PM_INVOICE` varchar(30) DEFAULT NULL,
  `CREDIT_DUE_DATE` date DEFAULT NULL,
  `CREDIT_NOMINAL` double DEFAULT '0',
  `CREDIT_PAID` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`CREDIT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit`
--

LOCK TABLES `credit` WRITE;
/*!40000 ALTER TABLE `credit` DISABLE KEYS */;
INSERT INTO `credit` VALUES (1,'201603100000000008',NULL,'2016-03-10',20,1),(2,'201603100000000009',NULL,'2016-03-20',20,1),(3,'201603160000000001',NULL,'2016-03-26',4000,1),(4,'201603160000000003',NULL,'2016-04-15',4000,1),(5,'201603230000000002',NULL,'2016-04-12',4000,1),(6,NULL,'1','2016-03-25',0,0),(7,NULL,'12','2016-03-25',2,1),(8,NULL,'123456','2016-03-25',2,1),(9,'SLO-3',NULL,'2016-03-26',20,1),(10,'SLO-4',NULL,'2016-03-26',20,1),(11,'SLO00001-1',NULL,'2016-04-09',10,1),(12,'SLO00001-2',NULL,'2016-04-09',10,0),(13,'SLO00001-3',NULL,'2016-04-10',12000,1),(14,'SLO00001-4',NULL,'2016-04-10',50000,1),(15,'SLO00001-5',NULL,'2016-04-20',20000,1),(16,NULL,'123','2016-03-31',3200,1),(17,NULL,'1234','2016-03-31',400,1),(18,NULL,'11','2016-03-31',4780,1),(19,NULL,'PM-1','2016-04-02',22000,1),(20,NULL,'PM-2','2016-04-02',22000,1),(21,NULL,'PM-3','2016-04-02',22000,1),(22,NULL,'PM-4','2016-04-02',600,1),(23,NULL,'PM-5','2016-04-02',4400,1),(24,NULL,'PM-5','2016-04-02',4400,1),(25,NULL,'PM-6','2016-04-03',4400,1),(26,'SLO00001-6',NULL,'2016-04-04',22000,1),(27,'SLO00001-7',NULL,'2016-04-28',66,0),(28,'SLO00001-8',NULL,'2016-04-08',192.08,1),(29,'SLO00001-9',NULL,'2016-04-08',14.2,1),(30,'SLO00001-10',NULL,'2016-04-13',40,1),(31,'SLO00001-10',NULL,'2016-04-13',9,1),(32,'SLO00001-8',NULL,'2016-04-13',300,1),(33,'SLO00001-9',NULL,'2016-04-13',30,1),(34,'SLO00001-10',NULL,'2016-04-13',30,1),(35,'SLO00001-2',NULL,'2016-04-13',40,1),(36,'SLO00001-3',NULL,'2016-04-13',110,1),(37,'SLO00001-4',NULL,'2016-04-13',10,1),(38,'SLO00001-5',NULL,'2016-04-13',110,1),(39,'SLO00001-6',NULL,'2016-04-13',110,1),(40,'SLO00001-7',NULL,'2016-04-13',40,1),(41,'SLO00001-8',NULL,'2016-04-13',9,1),(42,'SLO00001-9',NULL,'2016-04-13',321,1),(43,'SLO00001-2',NULL,'2016-04-13',101,1),(44,'SLO00001-3',NULL,'2016-04-13',101,1),(45,'SLO00001-4',NULL,'2016-04-14',275,1),(46,'SLO00001-5',NULL,'2016-04-14',3027.2,1),(47,NULL,'PM-457','2016-04-14',23200,0),(48,NULL,'PM-458','2016-04-14',200,0),(49,'SLO00001-6',NULL,'2016-04-14',2200,1);
/*!40000 ALTER TABLE `credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_product_disc`
--

DROP TABLE IF EXISTS `customer_product_disc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_product_disc` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CUSTOMER_ID` smallint(6) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `DISC_1` double unsigned DEFAULT '0',
  `DISC_2` double unsigned DEFAULT '0',
  `DISC_RP` double unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_product_disc`
--

LOCK TABLES `customer_product_disc` WRITE;
/*!40000 ALTER TABLE `customer_product_disc` DISABLE KEYS */;
INSERT INTO `customer_product_disc` VALUES (1,5,'KRG002',10,10,2),(2,4,'213',10,0,0),(3,4,'KRG002',5,0,0),(4,4,'123',10,0,0),(5,4,'12345',15,0,0);
/*!40000 ALTER TABLE `customer_product_disc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_journal`
--

DROP TABLE IF EXISTS `daily_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_journal` (
  `journal_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` smallint(5) unsigned NOT NULL,
  `journal_datetime` date NOT NULL,
  `journal_nominal` double NOT NULL,
  `branch_id` tinyint(3) unsigned DEFAULT NULL,
  `journal_description` varchar(100) DEFAULT NULL,
  `user_id` tinyint(3) unsigned NOT NULL,
  `pm_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`journal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_journal`
--

LOCK TABLES `daily_journal` WRITE;
/*!40000 ALTER TABLE `daily_journal` DISABLE KEYS */;
INSERT INTO `daily_journal` VALUES (1,1,'2016-04-04',2,0,'aa',1,1),(2,1,'2016-04-04',22000,0,'PEMBAYARAN PIUTANG SLO00001-6',1,1),(3,1,'2016-04-04',20000,0,'PEMBAYARAN PIUTANG SLO00001-5',1,1),(4,1,'2016-04-05',620,2,'SISA PIUTANG MUTASI123',1,1),(5,1,'2016-04-05',620,0,'SISA PIUTANG MUTASI1234',1,1),(6,1,'2016-04-05',620,4,'SISA PIUTANG MUTASI11',1,1),(7,1,'2016-04-05',200,5,'SISA PIUTANG MUTASI',1,1),(8,1,'2016-04-05',12000,0,'PEMBAYARAN PIUTANG SLO00001-3',1,1),(9,1,'2016-04-05',50000,0,'PEMBAYARAN PIUTANG SLO00001-4',1,1),(10,1,'2016-04-08',66,0,'PEMBAYARAN SLO00001-7',1,1),(11,1,'2016-04-08',192.08,0,'PEMBAYARAN SLO00001-8',1,1),(12,1,'2016-04-08',14.2,0,'PEMBAYARAN SLO00001-9',1,1),(13,7,'2016-04-12',1000000,5,'123',1,1),(14,3,'2016-04-12',1200000,5,'Cust 2',1,4),(15,4,'2016-04-12',-1550000,5,'Maret 2016',1,4),(16,1,'2016-04-13',40,NULL,'PEMBAYARAN SLO00001-10',1,1),(17,1,'2016-04-13',9,NULL,'PEMBAYARAN SLO00001-10',1,1),(18,1,'2016-04-13',300,NULL,'PEMBAYARAN SLO00001-8',1,1),(19,1,'2016-04-13',30,NULL,'PEMBAYARAN SLO00001-9',1,1),(20,1,'2016-04-13',30,NULL,'PEMBAYARAN SLO00001-10',1,1),(21,1,'2016-04-13',40,NULL,'PEMBAYARAN SLO00001-2',1,1),(22,1,'2016-04-13',110,NULL,'PEMBAYARAN SLO00001-3',1,1),(23,1,'2016-04-13',10,NULL,'PEMBAYARAN SLO00001-4',1,1),(24,1,'2016-04-13',110,NULL,'PEMBAYARAN SLO00001-5',1,1),(25,1,'2016-04-13',110,NULL,'PEMBAYARAN SLO00001-6',1,1),(26,1,'2016-04-13',40,NULL,'PEMBAYARAN SLO00001-7',1,1),(27,1,'2016-04-13',9,NULL,'PEMBAYARAN SLO00001-8',1,1),(28,1,'2016-04-13',321,NULL,'PEMBAYARAN SLO00001-9',1,1),(29,1,'2016-04-13',101,NULL,'PEMBAYARAN SLO00001-2',1,1),(30,1,'2016-04-13',101,NULL,'PEMBAYARAN SLO00001-3',1,1),(31,1,'2016-04-14',275,NULL,'PEMBAYARAN SLO00001-4',1,1),(32,1,'2016-04-14',3027.2,NULL,'PEMBAYARAN SLO00001-5',1,1),(33,1,'2016-04-14',2200,NULL,'PEMBAYARAN SLO00001-6',1,1);
/*!40000 ALTER TABLE `daily_journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debt`
--

DROP TABLE IF EXISTS `debt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debt` (
  `DEBT_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PURCHASE_INVOICE` varchar(30) DEFAULT NULL,
  `DEBT_DUE_DATE` date DEFAULT NULL,
  `DEBT_NOMINAL` double DEFAULT '0',
  `DEBT_PAID` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`DEBT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debt`
--

LOCK TABLES `debt` WRITE;
/*!40000 ALTER TABLE `debt` DISABLE KEYS */;
INSERT INTO `debt` VALUES (1,'PO001','2016-04-08',2000000000,0),(2,'PO002','2016-04-09',320,1),(3,'PO-1','2016-04-11',2000,1),(4,'PO-2','2016-04-11',100000,1),(5,'PO-3','2016-05-09',4000,1),(6,'PO-4','2016-04-12',22000,1),(7,'PO-7','2016-04-16',44400,1),(8,'PO-8','2016-04-19',10000,1),(9,'PO-9','2016-04-19',15000,0),(10,'PR-9','2016-04-24',100000,0);
/*!40000 ALTER TABLE `debt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_account`
--

DROP TABLE IF EXISTS `master_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_account` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `account_name` varchar(50) NOT NULL,
  `account_type_id` tinyint(3) unsigned NOT NULL,
  `account_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_name_UNIQUE` (`account_name`),
  UNIQUE KEY `account_id_UNIQUE` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_account`
--

LOCK TABLES `master_account` WRITE;
/*!40000 ALTER TABLE `master_account` DISABLE KEYS */;
INSERT INTO `master_account` VALUES (1,1,'PENDAPATAN TUNAI PENJUALAN',1,1),(2,2,'PENDAPATAN BCA PENJUALAN',1,1),(3,3,'PIUTANG PENJUALAN',1,1),(4,4,'BEBAN GAJI PUSAT',2,1),(5,5,'BEBAN LISTRIK PUSAT',2,1),(6,6,'BEBAN AIR',2,1),(7,7,'PENDAPATAN LAIN-LAIN',1,1),(8,8,'BEBAN LAIN-LAIN',2,1),(9,10,'BEBAN',2,1);
/*!40000 ALTER TABLE `master_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_account_type`
--

DROP TABLE IF EXISTS `master_account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_account_type` (
  `account_type_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `account_type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`account_type_id`),
  UNIQUE KEY `account_type_name_UNIQUE` (`account_type_name`),
  UNIQUE KEY `account_type_id_UNIQUE` (`account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_account_type`
--

LOCK TABLES `master_account_type` WRITE;
/*!40000 ALTER TABLE `master_account_type` DISABLE KEYS */;
INSERT INTO `master_account_type` VALUES (2,'CREDIT'),(1,'DEBET');
/*!40000 ALTER TABLE `master_account_type` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_branch`
--

LOCK TABLES `master_branch` WRITE;
/*!40000 ALTER TABLE `master_branch` DISABLE KEYS */;
INSERT INTO `master_branch` VALUES (1,'cabang 1','1111','','','123','192.168.1.100',1),(2,'cabang 2','1111','','','','111.111.111.111',1),(4,'CABANG TEST LUMPSUM','','','','','123.123.123.132',1),(5,'CABANG TES USB EXPORT \'\'//\\\\','','','','','122.122.122.1',1),(6,'\\\\\\CABANG TEST ESCAPE CHAR \'\'/','','','','','192.168.191.2',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_category`
--

LOCK TABLES `master_category` WRITE;
/*!40000 ALTER TABLE `master_category` DISABLE KEYS */;
INSERT INTO `master_category` VALUES (1,'promo','promo category 22',1),(2,'AAAA','AAAA',1),(3,'KARUNG','KARUNG - KARUNG !!!!',1),(4,'A\\','\\',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_customer`
--

LOCK TABLES `master_customer` WRITE;
/*!40000 ALTER TABLE `master_customer` DISABLE KEYS */;
INSERT INTO `master_customer` VALUES (1,'name 1','address 1','address 2','city','phone','fax','aa.aa.aa',1,'0000-00-00',123,1),(2,'name 1234','address 1','address 2','city','123','123','aa.aa.aa',1,'2016-02-16',123,1),(3,'andri111','andri','andri','andri','123','123','aa.aa.aa',1,'2016-02-15',123,2),(4,'andri 1234','andri 1','andri 1','andri 1234','123','56','andri 1123',1,'2016-02-17',0,3),(5,'ANDRI TES LUMPSUM',' ',' ',' ',' ',' ',' ',1,'2016-03-31',0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_group`
--

LOCK TABLES `master_group` WRITE;
/*!40000 ALTER TABLE `master_group` DISABLE KEYS */;
INSERT INTO `master_group` VALUES (1,'group 1','group 1 test group',0),(2,'GLOBAL_ADMIN \\\\\\ \'\'**//','GLOBAL ADMIN GROUP //\\\\\'\'::\"\"@@',1),(3,'group test','test group',1),(4,'AAA','AAAAA',1),(5,'bbbb','bbbbbb',1),(6,'cccc','ccccccc',1),(7,'sdadsadas','sadadsadasdas',1),(8,'aaaaaaaaaaassssaaaaaa','aaaaaaaa',1),(9,'123','123',1),(10,'asdfg','asdfgh',1),(11,'asdfg','asdfgh',1),(12,'KASIR GROUP','',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_module`
--

LOCK TABLES `master_module` WRITE;
/*!40000 ALTER TABLE `master_module` DISABLE KEYS */;
INSERT INTO `master_module` VALUES (1,'MANAJEMEN SISTEM',NULL,1,1),(2,'DATABASE',NULL,1,1),(3,'MANAJEMEN USER',NULL,3,1),(4,'MANAJEMEN CABANG',NULL,3,1),(5,'SINKRONISASI INFORMASI',NULL,1,1),(6,'PENGATURAN PRINTER',NULL,1,1),(7,'PENGATURAN GAMBAR LATAR',NULL,1,1),(8,'GUDANG',NULL,1,1),(9,'PRODUK',NULL,1,1),(10,'TAMBAH / UPDATE PRODUK',NULL,3,1),(11,'PENGATURAN HARGA PRODUK',NULL,1,1),(12,'PENGATURAN LIMIT STOK',NULL,1,1),(13,'PENGATURAN KATEGORI PRODUK',NULL,1,1),(14,'PECAH SATUAN PRODUK',NULL,1,1),(15,'PENGATURAN NOMOR RAK',NULL,1,1),(16,'KATEGORI PRODUK',NULL,3,1),(17,'SATUAN PRODUK',NULL,1,1),(18,'TAMBAH / UPDATE SATUAN',NULL,1,1),(19,'PENGATURAN KONVERSI SATUAN',NULL,1,1),(20,'STOK OPNAME',NULL,1,1),(21,'PENYESUAIAN STOK',NULL,1,1),(22,'MUTASI BARANG',NULL,1,1),(23,'TAMBAH / UPDATE MUTASI BARANG',NULL,3,1),(24,'CEK PERMINTAAN BARANG',NULL,1,1),(25,'PENERIMAAN BARANG',NULL,1,1),(26,'PENERIMAAN BARANG DARI MUTASI',NULL,1,1),(27,'PENERIMAAN BARANG DARI PO',NULL,1,1),(28,'PEMBELIAN',NULL,1,1),(29,'SUPPLIER',NULL,1,1),(30,'REQUEST ORDER',NULL,3,1),(31,'PURCHASE ORDER',NULL,3,1),(32,'REPRINT REQUEST ORDER',NULL,1,1),(33,'RETUR PEMBELIAN KE SUPPLIER',NULL,1,1),(34,'RETUR PERMINTAAN KE PUSAT',NULL,1,1),(35,'PENJUALAN',NULL,1,1),(36,'PELANGGAN',NULL,3,1),(37,'TRANSAKSI PENJUALAN',NULL,1,1),(38,'SET NO FAKTUR',NULL,1,1),(39,'RETUR PENJUALAN',NULL,1,1),(40,'RETUR PENJUALAN BY INVOICE',NULL,1,1),(41,'RETUR PENJUALAN BY STOK',NULL,1,1),(42,'KEUANGAN',NULL,1,1),(43,'PENGATURAN NO AKUN',NULL,3,1),(44,'TRANSAKSI HARIAN',NULL,1,1),(45,'TAMBAH TRANSAKSI HARIAN',NULL,1,1),(46,'PEMBAYARAN PIUTANG',NULL,1,1),(47,'PEMBAYARAN PIUTANG MUTASI',NULL,1,1),(48,'PEMBAYARAN HUTANG KE SUPPLIER',NULL,1,1);
/*!40000 ALTER TABLE `master_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_product`
--

DROP TABLE IF EXISTS `master_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_product` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PRODUCT_ID` varchar(50) DEFAULT '',
  `PRODUCT_BARCODE` int(10) unsigned DEFAULT '0',
  `PRODUCT_NAME` varchar(50) DEFAULT '',
  `PRODUCT_DESCRIPTION` varchar(100) DEFAULT '',
  `PRODUCT_BASE_PRICE` double DEFAULT '0',
  `PRODUCT_RETAIL_PRICE` double DEFAULT '0',
  `PRODUCT_BULK_PRICE` double DEFAULT '0',
  `PRODUCT_WHOLESALE_PRICE` double DEFAULT '0',
  `PRODUCT_PHOTO_1` varchar(50) DEFAULT '',
  `UNIT_ID` smallint(5) unsigned DEFAULT '0',
  `PRODUCT_STOCK_QTY` double DEFAULT '0',
  `PRODUCT_LIMIT_STOCK` double DEFAULT '0',
  `PRODUCT_SHELVES` varchar(5) DEFAULT '--00',
  `PRODUCT_ACTIVE` tinyint(3) unsigned DEFAULT '0',
  `PRODUCT_BRAND` varchar(50) DEFAULT '',
  `PRODUCT_IS_SERVICE` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PRODUCT_ID_UNIQUE` (`PRODUCT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_product`
--

LOCK TABLES `master_product` WRITE;
/*!40000 ALTER TABLE `master_product` DISABLE KEYS */;
INSERT INTO `master_product` VALUES (2,'213',1111,'abab','aaaaaa',0,10,10,10,'213.jpg',0,100,1,'--00',1,' ',0),(3,'KRG001',123,'KARUNG SAK',' ',100,3,1,1,' ',6,100,23,'2200',1,' ',0),(5,'SAK001',1234,'SAK \\\\  /\"',' ',1000,3333,10,10,' ',5,100,1,'--11',1,' ',0),(7,'KRG002',0,'KARUNG 2','KARUNG 2',1000,10,10,10,'KRG002.jpg',4,200,0,'AA00',1,'1',0),(9,'KRG003',0,'KARUNG 3',' ',0,10,110,10,'KRG003.jpg',5,100,0,'--00',1,' ',0),(13,'12345',1,'aaaa','aaaaa',0,110,1110,110,'',0,80,0,'--00',1,'',0),(14,'123',111,'AAA','AAA',0,101,99,98,'',1,100,0,'--00',1,'',0),(15,'SAK002',0,'SAK KECIL',' ',10,10,10,10,'SAK002.jpg',5,100,0,'--00',1,' ',0),(16,'SAK003',0,'SAK MINI',' ',10,10,10,10,'SAK003.jpg',5,1000,0,'--00',1,' ',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_supplier`
--

LOCK TABLES `master_supplier` WRITE;
/*!40000 ALTER TABLE `master_supplier` DISABLE KEYS */;
INSERT INTO `master_supplier` VALUES (1,'SUPPLIER BARU -- \'\' \\\\','AAAANNNNN \'\'','AAAA','AAAA',' ',' ','AAAA',1),(2,'SUPPLIER 2','AAA','AAAA',' ',' ',' ',' ',1),(3,'SUPPLIER 3',' ',' ',' ',' ',' ',' ',1),(4,'SUPPLIER TEST LUMPSUM',' ',' ',' ',' ',' ',' ',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_unit`
--

LOCK TABLES `master_unit` WRITE;
/*!40000 ALTER TABLE `master_unit` DISABLE KEYS */;
INSERT INTO `master_unit` VALUES (1,'aa','aa',1),(2,'vv','vv',1),(3,'aaa','aaaa',1),(4,'KARUNG','KARUNG',1),(5,'SAK\\\\','SAK',1),(6,'karung','karung',1),(7,'PCS','PIECES',1);
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
  `USER_NAME` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_PASSWORD` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_FULL_NAME` varchar(50) DEFAULT NULL,
  `USER_PHONE` varchar(15) DEFAULT NULL,
  `USER_ACTIVE` tinyint(1) unsigned DEFAULT NULL,
  `GROUP_ID` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_NAME_UNIQUE` (`USER_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_user`
--

LOCK TABLES `master_user` WRITE;
/*!40000 ALTER TABLE `master_user` DISABLE KEYS */;
INSERT INTO `master_user` VALUES (1,'ADMIN','admin','ADMIN \\\\\'\'//@@','1',1,2),(2,'ANDRI','andri','ANDRI','12345',1,2);
/*!40000 ALTER TABLE `master_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_credit`
--

DROP TABLE IF EXISTS `payment_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_credit` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `credit_id` int(11) NOT NULL,
  `payment_date` date NOT NULL,
  `pm_id` tinyint(3) NOT NULL,
  `payment_nominal` double NOT NULL,
  `payment_description` varchar(100) DEFAULT NULL,
  `payment_confirmed` tinyint(3) DEFAULT NULL,
  `payment_invalid` tinyint(4) DEFAULT '0',
  `payment_confirmed_date` date DEFAULT NULL,
  `payment_due_date` date DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_credit`
--

LOCK TABLES `payment_credit` WRITE;
/*!40000 ALTER TABLE `payment_credit` DISABLE KEYS */;
INSERT INTO `payment_credit` VALUES (1,2,'2016-03-23',5,20,'aa',0,0,NULL,NULL),(2,5,'2016-03-23',1,100,'',1,0,NULL,NULL),(3,5,'2016-03-23',5,2000,'test BG',0,1,NULL,NULL),(4,5,'2016-03-23',6,1900,'cair tgl 20',1,0,NULL,NULL),(5,10,'2016-03-26',1,10,'',1,0,NULL,NULL),(6,10,'2016-03-26',2,10,'',1,0,NULL,NULL),(7,5,'2016-03-26',1,2000,'',1,0,NULL,NULL),(8,7,'2016-03-29',1,2,'',1,0,NULL,NULL),(9,8,'2016-03-29',1,2,'',1,0,NULL,NULL),(10,11,'2016-03-30',1,10,'RETUR [1]',1,0,NULL,NULL),(11,12,'2016-03-30',1,0,'RETUR [12]',1,0,NULL,NULL),(12,15,'2016-04-04',1,20000,'',1,0,NULL,NULL),(14,16,'2016-04-05',1,3200,'',1,0,NULL,NULL),(15,17,'2016-04-05',1,400,'',1,0,NULL,NULL),(16,18,'2016-04-05',1,4780,'',1,0,NULL,NULL),(17,19,'2016-04-05',1,22000,'',1,0,NULL,NULL),(18,20,'2016-04-05',1,22000,'',1,0,NULL,NULL),(19,21,'2016-04-05',1,22000,'',1,0,NULL,NULL),(20,22,'2016-04-05',1,600,'',1,0,NULL,NULL),(21,23,'2016-04-05',1,4400,'',1,0,NULL,NULL),(22,24,'2016-04-05',1,4400,'',1,0,NULL,NULL),(23,25,'2016-04-05',1,4400,'',1,0,NULL,NULL),(24,13,'2016-04-05',1,12000,'',1,0,NULL,NULL),(25,14,'2016-04-05',1,50000,'',1,0,NULL,NULL),(26,9,'2016-04-05',1,20,'',1,0,'2016-04-05',NULL);
/*!40000 ALTER TABLE `payment_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_debt`
--

DROP TABLE IF EXISTS `payment_debt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_debt` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debt_id` int(11) NOT NULL,
  `payment_date` date NOT NULL,
  `pm_id` tinyint(3) NOT NULL,
  `payment_nominal` double NOT NULL,
  `payment_description` varchar(100) DEFAULT NULL,
  `payment_confirmed` tinyint(3) DEFAULT '0',
  `payment_invalid` tinyint(4) DEFAULT '0',
  `payment_confirmed_date` date DEFAULT NULL,
  `payment_due_date` date DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_debt`
--

LOCK TABLES `payment_debt` WRITE;
/*!40000 ALTER TABLE `payment_debt` DISABLE KEYS */;
INSERT INTO `payment_debt` VALUES (1,0,'2016-03-29',1,1,'',0,0,NULL,NULL),(2,0,'2016-03-29',1,19,'',0,0,NULL,NULL),(3,2,'2016-03-30',1,10,'',0,0,NULL,NULL),(4,2,'2016-03-30',1,310,'',0,0,NULL,NULL),(5,3,'2016-04-06',1,2000,'',1,0,NULL,NULL),(6,4,'2016-04-06',1,100000,'',1,0,NULL,NULL),(7,5,'2016-04-06',1,4000,'',1,0,NULL,NULL),(8,6,'2016-04-06',1,14000,'',1,0,NULL,NULL),(9,6,'2016-04-06',1,8000,'',1,0,NULL,NULL),(10,7,'2016-04-06',1,42000,'',1,0,NULL,NULL),(11,7,'2016-04-06',1,2000,'',1,0,'2016-04-06',NULL),(12,7,'2016-04-06',1,100,'',0,1,NULL,NULL),(13,7,'2016-04-06',1,400,'',1,0,NULL,NULL),(14,8,'2016-04-09',1,5000,'',1,0,NULL,NULL),(15,8,'2016-04-09',1,1000,'',1,0,NULL,NULL),(16,8,'2016-04-09',1,500,'',1,0,NULL,NULL),(17,8,'2016-04-09',1,500,'',1,0,'2016-04-09',NULL),(18,8,'2016-04-09',1,3000,'',1,0,'2016-04-09',NULL),(19,10,'2016-04-14',1,1000,'',0,0,NULL,'2016-04-14'),(20,10,'2016-04-14',1,1000,'',0,0,NULL,'2016-04-22');
/*!40000 ALTER TABLE `payment_debt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_method` (
  `pm_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `pm_name` varchar(15) NOT NULL,
  `pm_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1,'TUNAI','TUNAI'),(2,'KARTU KREDIT','KARTU KREDIT'),(3,'KARTU DEBIT','KARTU DEBIT'),(4,'TRANSFER','TRANSFER BANK'),(5,'BG','BILYET GIRO'),(6,'CEK','CEK');
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_adjustment`
--

DROP TABLE IF EXISTS `product_adjustment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_adjustment` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PRODUCT_ID` varchar(30) DEFAULT NULL,
  `PRODUCT_ADJUSTMENT_DATE` date DEFAULT NULL,
  `PRODUCT_OLD_STOCK_QTY` double DEFAULT NULL,
  `PRODUCT_NEW_STOCK_QTY` double DEFAULT NULL,
  `PRODUCT_ADJUSTMENT_DESCRIPTION` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_adjustment`
--

LOCK TABLES `product_adjustment` WRITE;
/*!40000 ALTER TABLE `product_adjustment` DISABLE KEYS */;
INSERT INTO `product_adjustment` VALUES (1,'KRG001','2016-03-26',983,100,' \''),(2,'12345','2016-03-26',123,100,' \''),(3,'KRG002','2016-03-26',222221,100,' \''),(4,'KRG001','2016-03-26',100,0,'ss'),(5,'12345','2016-03-26',100,0,'sss sss ss '),(6,'KRG002','2016-03-26',100,0,'aaaa'),(7,'213','2016-04-14',80,100,'tes\'\''),(8,'KRG001','2016-04-14',968,100,'aa//\'\'\'\'\'\'\'\'\'\'\'\''),(9,'SAK001','2016-04-14',85,100,'ss#$'),(10,'KRG002','2016-04-14',90,100,'dd'),(11,'12345','2016-04-14',76,100,'gg'),(12,'123','2016-04-14',86,100,'hh'),(13,'SAK002','2016-04-14',5,100,'rr'),(14,'SAK003','2016-04-14',10,100,'dd'),(15,'SAK003','2016-04-14',100,1000,'\'-\'-\'-\'-\'-@@!!@#$%^&*()_+');
/*!40000 ALTER TABLE `product_adjustment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_category` (
  `PRODUCT_ID` varchar(50) NOT NULL,
  `CATEGORY_ID` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`PRODUCT_ID`,`CATEGORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES ('123',1),('123',2),('213',2),('KRG001',1),('KRG001',2),('KRG002',3),('KRG003',1),('KRG003',2),('SAK001',1),('SAK002',3),('SAK003',3);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_loss`
--

DROP TABLE IF EXISTS `product_loss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_loss` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PL_DATETIME` date DEFAULT NULL,
  `PRODUCT_ID` int(10) unsigned DEFAULT NULL,
  `PRODUCT_QTY` double DEFAULT NULL,
  `NEW_PRODUCT_ID` int(10) unsigned DEFAULT NULL,
  `NEW_PRODUCT_QTY` double DEFAULT NULL,
  `TOTAL_LOSS` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_loss`
--

LOCK TABLES `product_loss` WRITE;
/*!40000 ALTER TABLE `product_loss` DISABLE KEYS */;
INSERT INTO `product_loss` VALUES (1,'2016-03-02',3,1,5,10,2);
/*!40000 ALTER TABLE `product_loss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_mutation_detail`
--

DROP TABLE IF EXISTS `products_mutation_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_mutation_detail` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PM_INVOICE` varchar(30) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_BASE_PRICE` double DEFAULT NULL,
  `PRODUCT_QTY` double DEFAULT NULL,
  `PM_SUBTOTAL` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_mutation_detail`
--

LOCK TABLES `products_mutation_detail` WRITE;
/*!40000 ALTER TABLE `products_mutation_detail` DISABLE KEYS */;
INSERT INTO `products_mutation_detail` VALUES (1,'11111','KRG001',110,1,110),(2,'11111','SAK001',10,2,20),(3,'123','213',10,1,10),(6,'1234','KRG001',110,12,1320),(7,'12345','KRG001',110,2,220),(8,'12','KRG001',1,2,2),(9,'123456','KRG001',1,2,2),(10,'123','TL001',10,20,200),(11,'PM-2','TL001',1000,22,22000),(12,'PM-3','TL001',1000,22,22000),(13,'PM-4','TL002',200,3,600),(19,'PM-5','TL002',200,22,4400),(21,'PM-6','TL002',200,22,4400),(22,'PM-457','KRG001',100,2,200),(23,'PM-457','KRG002',1000,23,23000),(24,'PM-458','KRG001',100,2,200);
/*!40000 ALTER TABLE `products_mutation_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_mutation_header`
--

DROP TABLE IF EXISTS `products_mutation_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_mutation_header` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PM_INVOICE` varchar(30) DEFAULT NULL,
  `BRANCH_ID_FROM` tinyint(3) unsigned DEFAULT NULL,
  `BRANCH_ID_TO` tinyint(3) unsigned DEFAULT NULL,
  `PM_DATETIME` date DEFAULT NULL,
  `PM_TOTAL` double DEFAULT NULL,
  `RO_INVOICE` varchar(30) DEFAULT NULL,
  `PM_RECEIVED` tinyint(4) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_mutation_header`
--

LOCK TABLES `products_mutation_header` WRITE;
/*!40000 ALTER TABLE `products_mutation_header` DISABLE KEYS */;
INSERT INTO `products_mutation_header` VALUES (4,'11111',2,1,'2016-02-24',130,'1111',1),(5,'123',1,2,'2016-02-25',230,'11',0),(8,'1234',0,0,'2016-02-26',1320,'',0),(9,'12345',0,0,'2016-02-26',220,'',0),(10,'1',0,0,'2016-03-25',0,'',1),(12,'12',1,1,'2016-03-25',2,'',1),(13,'123456',1,1,'2016-03-25',2,'',1),(14,'123',2,4,'2016-03-31',3200,'1234',0),(15,'1234',2,4,'2016-03-31',400,'123456',0),(16,'11',2,4,'2016-03-31',4780,'1',0),(17,'PM-1',0,5,'2016-04-02',22000,'RO-1',0),(18,'PM-2',0,5,'2016-04-02',22000,'',0),(20,'PM-3',0,5,'2016-04-02',22000,'RO-2',1),(21,'PM-4',0,5,'2016-04-02',600,'',0),(26,'PM-5',0,5,'2016-04-02',4400,'RO-3',0),(28,'PM-6',0,5,'2016-04-03',4400,NULL,0),(29,'PM-457',0,0,'2016-04-14',23200,'',0),(30,'PM-458',0,1,'2016-04-14',200,'',1);
/*!40000 ALTER TABLE `products_mutation_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_received_detail`
--

DROP TABLE IF EXISTS `products_received_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_received_detail` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PR_INVOICE` varchar(30) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_BASE_PRICE` double DEFAULT NULL,
  `PRODUCT_QTY` double DEFAULT NULL,
  `PRODUCT_ACTUAL_QTY` double DEFAULT NULL,
  `PR_SUBTOTAL` varchar(45) DEFAULT NULL,
  `PRODUCT_PRICE_CHANGE` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_received_detail`
--

LOCK TABLES `products_received_detail` WRITE;
/*!40000 ALTER TABLE `products_received_detail` DISABLE KEYS */;
INSERT INTO `products_received_detail` VALUES (5,'123','KRG001',2000,1,1,'2000',1),(6,'123','SAK001',1,2,2,'2',-1),(7,'','KRG001',1,2,2,'2',0),(8,'12321','KRG001',3,2,5,'15',1),(9,'1234','KRG002',1000000000,2,222222,'222222000000000',1),(10,'1','KRG002',1,12,12,'12',-1),(11,'PR001','KRG002',1,20,20,'20',0),(12,'PR001','KRG003',10,30,30,'300',0),(13,'PR-1','TL001',10,100,100,'1000',0),(14,'PR-1','TL002',100,10,10,'1000',1),(15,'PR-2','TL001',1000,100,100,'100000',1),(16,'PR-3','TL002',200,20,20,'4000',1),(17,'PR-4','TL001',1000,22,22,'22000',0),(18,'PR-5','TL001',1000,22,22,'22000',0),(19,'PR-6','TL002',200,222,222,'44400',0),(22,'PR-7','KRG001',100,222,100,'10000',1),(23,'PR-8','KRG002',1000,30,15,'15000',1),(24,'PR-9','KRG002',1000,100,100,'100000',0);
/*!40000 ALTER TABLE `products_received_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_received_header`
--

DROP TABLE IF EXISTS `products_received_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_received_header` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PR_INVOICE` varchar(30) DEFAULT NULL,
  `PR_FROM` tinyint(3) unsigned DEFAULT NULL,
  `PR_TO` tinyint(3) unsigned DEFAULT NULL,
  `PR_DATE` date DEFAULT NULL,
  `PR_TOTAL` double DEFAULT NULL,
  `PM_INVOICE` varchar(30) DEFAULT NULL,
  `PURCHASE_INVOICE` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PR_INVOICE_UNIQUE` (`PR_INVOICE`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_received_header`
--

LOCK TABLES `products_received_header` WRITE;
/*!40000 ALTER TABLE `products_received_header` DISABLE KEYS */;
INSERT INTO `products_received_header` VALUES (7,'123',2,1,'2016-03-03',2002,'11111',NULL),(8,'',1,1,'2016-03-25',2,'12',NULL),(9,'12',0,0,'2016-03-25',0,'1',NULL),(10,'12321',1,1,'2016-03-25',15,'123456',NULL),(11,'1234',1,0,'2016-03-25',222222000000000,NULL,'1234'),(12,'1',1,0,'2016-03-30',12,NULL,'1'),(13,'PR001',2,0,'2016-03-30',320,NULL,'PO002'),(14,'PR-1',4,0,'2016-04-01',2000,NULL,'PO-1'),(15,'PR-2',4,0,'2016-04-01',100000,NULL,'PO-2'),(16,'PR-3',4,0,'2016-04-01',4000,NULL,'PO-3'),(17,'PR-4',0,5,'2016-04-02',22000,'PM-3',NULL),(18,'PR-5',4,0,'2016-04-02',22000,NULL,'PO-4'),(19,'PR-6',4,0,'2016-04-06',44400,NULL,'PO-7'),(22,'PR-7',4,0,'2016-04-09',10000,NULL,'PO-8'),(23,'PR-8',4,0,'2016-04-09',15000,NULL,'PO-9'),(24,'PR-9',1,0,'2016-04-14',100000,NULL,'PR-9');
/*!40000 ALTER TABLE `products_received_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_detail`
--

DROP TABLE IF EXISTS `purchase_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_detail` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PURCHASE_INVOICE` varchar(30) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_PRICE` double DEFAULT NULL,
  `PRODUCT_QTY` double DEFAULT NULL,
  `PURCHASE_SUBTOTAL` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_detail`
--

LOCK TABLES `purchase_detail` WRITE;
/*!40000 ALTER TABLE `purchase_detail` DISABLE KEYS */;
INSERT INTO `purchase_detail` VALUES (1,'1234','KRG002',10,2,20),(2,'PO001','KRG002',1000000000,2,2000000000),(3,'1','KRG002',1000000000,12,12000000000),(4,'PO002','KRG002',1,20,20),(5,'PO002','KRG003',10,30,300),(6,'PO-1','TL001',10,100,1000),(7,'PO-1','TL002',100,10,1000),(8,'PO-2','TL001',1000,100,100000),(9,'PO-3','TL002',200,20,4000),(10,'PO-4','TL001',1000,22,22000),(11,'PO-5','TL001',1000,22,22000),(12,'PO-6','KRG002',1,222,222),(13,'PO-7','TL002',200,222,44400),(14,'PO-8','KRG001',100,222,22200),(15,'PO-9','KRG002',1000,30,30000),(16,'PO-10','KRG003',100,21,2100),(17,'PR-9','KRG002',1000,100,100000);
/*!40000 ALTER TABLE `purchase_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_header`
--

DROP TABLE IF EXISTS `purchase_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_header` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PURCHASE_INVOICE` varchar(30) DEFAULT NULL,
  `SUPPLIER_ID` smallint(5) unsigned DEFAULT NULL,
  `PURCHASE_DATETIME` date DEFAULT NULL,
  `PURCHASE_TOTAL` double DEFAULT NULL,
  `PURCHASE_TERM_OF_PAYMENT` tinyint(3) unsigned DEFAULT NULL,
  `PURCHASE_TERM_OF_PAYMENT_DURATION` double unsigned DEFAULT '0',
  `PURCHASE_DATE_RECEIVED` date DEFAULT NULL,
  `PURCHASE_TERM_OF_PAYMENT_DATE` date DEFAULT NULL,
  `PURCHASE_PAID` tinyint(3) unsigned DEFAULT '0',
  `PURCHASE_SENT` tinyint(3) unsigned DEFAULT '0',
  `PURCHASE_RECEIVED` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PURCHASE_INVOICE_UNIQUE` (`PURCHASE_INVOICE`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_header`
--

LOCK TABLES `purchase_header` WRITE;
/*!40000 ALTER TABLE `purchase_header` DISABLE KEYS */;
INSERT INTO `purchase_header` VALUES (1,'1234',1,'2016-03-25',20,0,0,NULL,'2016-03-25',1,1,1),(3,'PO001',1,'2016-03-29',2000000000,1,0,NULL,'2016-04-08',0,1,0),(6,'1',1,'2016-03-30',12000000000,0,0,NULL,'2016-03-30',1,1,1),(7,'PO002',2,'2016-03-30',320,1,0,NULL,'2016-04-09',1,1,1),(8,'PO-1',4,'2016-04-01',2000,1,0,NULL,'2016-04-11',1,1,1),(9,'PO-2',4,'2016-04-01',100000,1,0,NULL,'2016-04-11',1,1,1),(10,'PO-3',4,'2016-04-01',4000,1,0,NULL,'2016-05-09',1,1,1),(11,'PO-4',4,'2016-04-02',22000,1,0,NULL,'2016-04-12',1,1,1),(12,'PO-5',4,'2016-04-06',22000,1,0,NULL,'2016-04-06',0,1,1),(13,'PO-6',1,'2016-04-06',222,1,0,NULL,'2016-04-06',0,1,1),(14,'PO-7',4,'2016-04-06',44400,1,0,NULL,'2016-04-16',1,1,1),(15,'PO-8',4,'2016-04-09',22200,1,10,'2016-04-09','2016-04-19',1,1,1),(16,'PO-9',4,'2016-04-09',30000,1,10,'2016-04-09','2016-04-19',0,1,1),(17,'PO-10',4,'2016-04-09',2100,1,10,NULL,NULL,0,0,0),(18,'PR-9',1,'2016-04-14',100000,1,10,'2016-04-14','2016-04-24',0,1,1);
/*!40000 ALTER TABLE `purchase_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_order_detail`
--

DROP TABLE IF EXISTS `request_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_order_detail` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RO_INVOICE` varchar(30) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_BASE_PRICE` double DEFAULT NULL,
  `RO_QTY` double DEFAULT NULL,
  `RO_SUBTOTAL` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_order_detail`
--

LOCK TABLES `request_order_detail` WRITE;
/*!40000 ALTER TABLE `request_order_detail` DISABLE KEYS */;
INSERT INTO `request_order_detail` VALUES (24,'1111','KRG001',110,1,110),(25,'1111','SAK001',10,2,20),(26,'1111','KRG001',110,1,110),(27,'1111','SAK001',10,2,20),(28,'1111','KRG001',110,1,110),(29,'1111','SAK001',10,2,20),(31,'132','KRG001',110,4,440),(32,'11','213',10,1,10),(34,'11a','KRG003',10,20,200),(35,'123','213',10,22,220),(36,'A1234','KRG002',1000000000,2,2000000000),(37,'A123','KRG002',1000000000,2,2000000000),(38,'A1','213',10,2,20),(39,'1234','TL001',10,20,200),(40,'1234','TL002',10,300,3000),(41,'123456','TL001',10,100,1000),(42,'1','TL002',10,1000,10000),(44,'RO-1','TL001',1000,22,22000),(45,'RO-2','TL001',1000,22,22000),(47,'RO-3','TL002',200,22,4400),(49,'RO-4','KRG002',1000,20,20000),(50,'RO-6','KRG001',100,2,200);
/*!40000 ALTER TABLE `request_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_order_header`
--

DROP TABLE IF EXISTS `request_order_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_order_header` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RO_INVOICE` varchar(30) DEFAULT NULL,
  `RO_BRANCH_ID_FROM` tinyint(3) unsigned DEFAULT NULL,
  `RO_BRANCH_ID_TO` tinyint(3) unsigned DEFAULT NULL,
  `RO_DATETIME` date DEFAULT NULL,
  `RO_TOTAL` double DEFAULT NULL,
  `RO_EXPIRED` date DEFAULT NULL,
  `RO_ACTIVE` tinyint(4) DEFAULT NULL,
  `RO_EXPORTED` tinyint(4) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RO_INVOICE_UNIQUE` (`RO_INVOICE`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_order_header`
--

LOCK TABLES `request_order_header` WRITE;
/*!40000 ALTER TABLE `request_order_header` DISABLE KEYS */;
INSERT INTO `request_order_header` VALUES (1,'123',1,2,'2016-02-23',220,'2016-02-25',1,1),(3,'11',1,2,'2016-02-23',230,'2016-02-25',1,1),(4,'1111',2,1,'2016-02-23',0,'2016-02-24',1,1),(5,'132',1,2,'2016-02-26',0,'2016-02-27',1,1),(6,'111',1,2,'2016-03-25',0,'2016-03-25',1,1),(7,'11a',1,2,'2016-03-25',200,'2016-04-04',1,1),(8,'A1234',1,2,'2016-03-25',2000000000,'2016-04-04',1,1),(9,'A123',1,2,'2016-03-25',2000000000,'2016-04-04',1,1),(10,'A1',1,2,'2016-03-25',20,'2016-04-04',1,1),(11,'1234',2,4,'2016-03-31',3200,'2016-04-10',0,0),(12,'123456',2,4,'2016-03-31',1000,'2016-04-20',0,0),(13,'1',2,4,'2016-03-31',10000,'2016-04-11',0,0),(14,'RO-1',0,5,'2016-04-02',22000,'2016-04-12',0,1),(15,'RO-2',0,5,'2016-04-02',22000,'2016-04-03',0,0),(16,'RO-3',0,5,'2016-04-02',4400,'2016-04-12',0,1),(17,'RO-4',0,5,'2016-04-14',20000,'2016-04-24',1,1),(18,'RO-6',0,5,'2016-04-12',200,'2016-04-22',1,0);
/*!40000 ALTER TABLE `request_order_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_purchase_detail`
--

DROP TABLE IF EXISTS `return_purchase_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `return_purchase_detail` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RP_ID` varchar(30) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_BASEPRICE` double DEFAULT '0',
  `PRODUCT_QTY` double DEFAULT '0',
  `RP_DESCRIPTION` varchar(100) DEFAULT NULL,
  `RP_SUBTOTAL` double DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_purchase_detail`
--

LOCK TABLES `return_purchase_detail` WRITE;
/*!40000 ALTER TABLE `return_purchase_detail` DISABLE KEYS */;
INSERT INTO `return_purchase_detail` VALUES (1,'123','KRG001',2000,2,' ',4000),(2,'123','KRG001',2000,2,' ',4000),(3,'1234','KRG001',2000,2,' ',4000),(4,'1234','KRG001',2000,2,' ',4000),(5,'111','KRG001',2000,2,' ',4000),(6,'12','KRG001',3,2,' ',6),(7,'12345','KRG001',3,2,' ',6);
/*!40000 ALTER TABLE `return_purchase_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_purchase_header`
--

DROP TABLE IF EXISTS `return_purchase_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `return_purchase_header` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RP_ID` varchar(30) DEFAULT NULL,
  `SUPPLIER_ID` smallint(5) unsigned DEFAULT NULL,
  `RP_DATE` date DEFAULT NULL,
  `RP_TOTAL` double DEFAULT '0',
  `RP_PROCESSED` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RP_INVOICE_UNIQUE` (`RP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_purchase_header`
--

LOCK TABLES `return_purchase_header` WRITE;
/*!40000 ALTER TABLE `return_purchase_header` DISABLE KEYS */;
INSERT INTO `return_purchase_header` VALUES (1,'123',1,'2016-03-06',4000,1),(2,'111',1,'2016-03-07',4000,1),(3,'132',1,'2016-03-28',0,1),(5,'1234',1,'2016-03-29',0,1),(6,'12',1,'2016-03-29',6,1),(8,'12345',0,'2016-03-28',6,1);
/*!40000 ALTER TABLE `return_purchase_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_sales_detail`
--

DROP TABLE IF EXISTS `return_sales_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `return_sales_detail` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RS_INVOICE` varchar(30) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_SALES_PRICE` double DEFAULT '0',
  `PRODUCT_SALES_QTY` double DEFAULT '0',
  `PRODUCT_RETURN_QTY` double DEFAULT '0',
  `RS_DESCRIPTION` varchar(100) DEFAULT NULL,
  `RS_SUBTOTAL` double DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_sales_detail`
--

LOCK TABLES `return_sales_detail` WRITE;
/*!40000 ALTER TABLE `return_sales_detail` DISABLE KEYS */;
INSERT INTO `return_sales_detail` VALUES (1,'123','KRG001',2000,20,2,' ',4000),(2,'123','SAK001',10,20,2,' ',20),(3,'1234','KRG001',2000,20,2,' ',4000),(4,'1','KRG002',10,1,1,' ',10),(5,'12','KRG002',10,1,0,' ',0);
/*!40000 ALTER TABLE `return_sales_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_sales_header`
--

DROP TABLE IF EXISTS `return_sales_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `return_sales_header` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RS_INVOICE` varchar(30) DEFAULT NULL,
  `SALES_INVOICE` varchar(30) DEFAULT NULL,
  `CUSTOMER_ID` smallint(5) unsigned DEFAULT NULL,
  `RS_DATETIME` date DEFAULT NULL,
  `RS_TOTAL` double DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_sales_header`
--

LOCK TABLES `return_sales_header` WRITE;
/*!40000 ALTER TABLE `return_sales_header` DISABLE KEYS */;
INSERT INTO `return_sales_header` VALUES (1,'123','201603140000000001',0,'2016-03-14',4020),(2,'1234','201603140000000001',2,'2016-03-14',4000),(3,'1','SLO00001-1',0,'2016-03-30',10),(4,'12','SLO00001-2',0,'2016-03-30',0);
/*!40000 ALTER TABLE `return_sales_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_detail`
--

DROP TABLE IF EXISTS `sales_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_detail` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SALES_INVOICE` varchar(30) DEFAULT NULL,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_SALES_PRICE` double DEFAULT '0',
  `PRODUCT_QTY` double DEFAULT '0',
  `PRODUCT_DISC1` double DEFAULT '0',
  `PRODUCT_DISC2` double DEFAULT '0',
  `PRODUCT_DISC_RP` double DEFAULT '0',
  `SALES_SUBTOTAL` double DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_detail`
--

LOCK TABLES `sales_detail` WRITE;
/*!40000 ALTER TABLE `sales_detail` DISABLE KEYS */;
INSERT INTO `sales_detail` VALUES (1,'201603100000000008','KRG001',10,2,0,0,0,20),(2,'201603100000000009','KRG001',10,2,0,0,0,20),(3,'201603140000000001','KRG001',2000,20,0,0,0,40000),(4,'201603140000000001','SAK001',10,20,0,0,0,200),(5,'201603230000000001','KRG001',20,20,0,0,0,400),(6,'201603230000000002','KRG001',20,200,0,0,0,4000),(7,'SLO001-1','KRG002',10,1,0,0,0,10),(8,'SLO001-2','KRG002',10,2,0,0,0,20),(9,'SLO00-1','KRG002',10,2,0,0,0,20),(10,'SLO-1','KRG002',10,1,0,0,0,10),(11,'SLO-2','KRG002',10,1,0,0,0,10),(12,'SLO-3','KRG002',10,2,0,0,0,20),(13,'SLO-4','KRG002',10,2,0,0,0,20),(14,'SLO00001-1','KRG002',10,1,0,0,0,10),(38,'SLO00001-2','123',101,1,0,0,0,101),(39,'SLO00001-3','123',101,1,0,0,0,101),(40,'SLO00001-4','213',10,20,10,0,0,180),(41,'SLO00001-4','KRG002',10,10,5,0,0,95),(42,'SLO00001-5','123',98,11,10,0,0,970.2),(43,'SLO00001-5','12345',110,22,15,0,0,2057),(44,'SLO00001-6','12345',110,20,0,0,0,2200);
/*!40000 ALTER TABLE `sales_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_header`
--

DROP TABLE IF EXISTS `sales_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_header` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SALES_INVOICE` varchar(30) DEFAULT NULL,
  `CUSTOMER_ID` smallint(5) unsigned DEFAULT '0',
  `SALES_DATE` date DEFAULT NULL,
  `SALES_TOTAL` double DEFAULT '0',
  `SALES_DISCOUNT_FINAL` double DEFAULT '0',
  `SALES_TOP` tinyint(3) unsigned DEFAULT '0',
  `SALES_TOP_DATE` date DEFAULT NULL,
  `SALES_PAID` tinyint(3) unsigned DEFAULT '0',
  `SALES_PAYMENT` double unsigned DEFAULT '0',
  `SALES_PAYMENT_CHANGE` double unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SALES_INVOICE_UNIQUE` (`SALES_INVOICE`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_header`
--

LOCK TABLES `sales_header` WRITE;
/*!40000 ALTER TABLE `sales_header` DISABLE KEYS */;
INSERT INTO `sales_header` VALUES (1,'201603100000000007',1,'2016-03-10',20,0,1,'2016-03-10',1,0,0),(4,'201603100000000001',1,'2016-03-10',20,0,1,'2016-03-10',1,0,0),(5,'201603100000000002',1,'2016-03-10',20,0,1,'2016-03-10',1,0,0),(7,'201603100000000003',2,'2016-03-10',20,0,1,'2016-03-10',1,0,0),(8,'201603100000000008',2,'2016-03-10',20,0,0,'2016-03-10',0,0,0),(9,'201603100000000009',2,'2016-03-10',20,0,0,'2016-03-20',0,0,0),(10,'201603140000000001',2,'2016-03-14',40200,0,1,'2016-03-14',0,0,0),(11,'201603230000000001',4,'2016-03-23',400,0,1,'2016-03-23',1,0,0),(12,'201603230000000002',4,'2016-03-23',4000,0,0,'2016-04-12',1,0,0),(13,'SLO001-1',4,'2016-03-26',10,0,1,'2016-03-26',1,0,0),(14,'SLO001-2',4,'2016-03-26',20,0,1,'2016-03-26',1,0,0),(15,'SLO00-1',4,'2016-03-26',20,0,1,'2016-03-26',1,0,0),(16,'SLO-1',0,'2016-03-26',10,0,1,'2016-03-26',1,0,0),(18,'SLO-2',0,'2016-03-26',10,0,1,'2016-03-26',1,0,0),(19,'SLO-3',4,'2016-03-26',20,0,1,'2016-03-26',1,0,0),(20,'SLO-4',0,'2016-03-26',20,0,1,'2016-03-26',1,0,0),(21,'SLO00001-1',0,'2016-03-30',10,0,0,'2016-04-09',1,0,0),(44,'SLO00001-2',0,'2016-04-13',101,1,1,'2016-04-13',1,0,0),(45,'SLO00001-3',0,'2016-04-13',101,1,1,'2016-04-13',1,0,0),(46,'SLO00001-4',4,'2016-04-14',275,0,1,'2016-04-14',1,0,0),(47,'SLO00001-5',4,'2016-04-14',3027.2,27,1,'2016-04-14',1,0,0),(48,'SLO00001-6',0,'2016-04-14',2200,0,1,'2016-04-14',1,3000,800);
/*!40000 ALTER TABLE `sales_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `id` tinyint(3) unsigned NOT NULL,
  `no_faktur` varchar(30) NOT NULL DEFAULT '',
  `branch_id` tinyint(3) unsigned DEFAULT NULL,
  `HQ_IP4` varchar(15) DEFAULT NULL,
  `store_name` varchar(50) DEFAULT NULL,
  `store_address` varchar(100) DEFAULT NULL,
  `store_phone` varchar(20) DEFAULT NULL,
  `store_email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'SLO00001',0,'127.0.0.1',NULL,NULL,NULL,NULL),(2,'',5,'127.0.0.1','TOKO PUSAT','JALAN PUSAT','12345','pusat@pusat.com');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_master_product`
--

DROP TABLE IF EXISTS `temp_master_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_master_product` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PRODUCT_ID` varchar(50) DEFAULT NULL,
  `PRODUCT_BARCODE` int(10) unsigned DEFAULT NULL,
  `PRODUCT_NAME` varchar(50) DEFAULT NULL,
  `PRODUCT_DESCRIPTION` varchar(100) DEFAULT NULL,
  `PRODUCT_BASE_PRICE` double DEFAULT NULL,
  `PRODUCT_RETAIL_PRICE` double DEFAULT NULL,
  `PRODUCT_BULK_PRICE` double DEFAULT NULL,
  `PRODUCT_WHOLESALE_PRICE` double DEFAULT NULL,
  `UNIT_ID` smallint(5) unsigned DEFAULT '0',
  `PRODUCT_IS_SERVICE` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PRODUCT_ID_UNIQUE` (`PRODUCT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_master_product`
--

LOCK TABLES `temp_master_product` WRITE;
/*!40000 ALTER TABLE `temp_master_product` DISABLE KEYS */;
INSERT INTO `temp_master_product` VALUES (1,'213',1111,'abab','aaaaaa',0,10,10,10,0,0),(2,'KRG001',123,'KARUNG SAK',' ',100,3,1,1,6,0),(3,'SAK001',1234,'SAK \\\\  /',' ',1000,3333,10,10,5,0),(4,'KRG002',0,'KARUNG 2','KARUNG 2',1000,10,10,10,4,0),(5,'KRG003',0,'KARUNG 3',' ',0,10,110,10,5,0),(6,'12345',1,'aaaa','aaaaa',0,110,1110,110,0,0),(7,'123',111,'AAA','AAA',0,101,99,98,1,0);
/*!40000 ALTER TABLE `temp_master_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_product_category`
--

DROP TABLE IF EXISTS `temp_product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_product_category` (
  `PRODUCT_ID` varchar(50) NOT NULL,
  `CATEGORY_ID` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`PRODUCT_ID`,`CATEGORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_product_category`
--

LOCK TABLES `temp_product_category` WRITE;
/*!40000 ALTER TABLE `temp_product_category` DISABLE KEYS */;
INSERT INTO `temp_product_category` VALUES ('123',1),('123',2),('213',2),('KRG001',2),('KRG002',3),('SAK001',1);
/*!40000 ALTER TABLE `temp_product_category` ENABLE KEYS */;
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
INSERT INTO `unit_convert` VALUES (1,2,50.5),(3,1,5),(3,6,4),(4,1,0.35),(4,5,10);
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
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_access_management`
--

LOCK TABLES `user_access_management` WRITE;
/*!40000 ALTER TABLE `user_access_management` DISABLE KEYS */;
INSERT INTO `user_access_management` VALUES (67,2,1,1),(68,2,2,1),(69,2,3,6),(70,2,4,6),(71,2,5,1),(72,2,6,1),(73,2,7,1),(74,2,8,1),(75,2,9,1),(76,2,10,6),(77,2,11,1),(78,2,12,1),(79,2,13,1),(80,2,14,1),(81,2,15,1),(82,2,16,6),(83,2,17,1),(84,2,18,1),(85,2,19,1),(86,2,20,1),(87,2,21,1),(88,2,22,1),(89,2,23,6),(90,2,24,1),(91,2,25,1),(92,2,26,1),(93,2,27,1),(94,2,28,1),(95,2,29,1),(96,2,30,6),(97,2,31,6),(98,2,32,1),(99,2,33,1),(100,2,34,1),(101,2,35,1),(102,2,36,6),(103,2,37,1),(104,2,38,1),(105,2,39,1),(106,2,40,1),(107,2,41,1),(108,2,42,1),(109,2,43,6),(110,2,44,1),(111,2,45,1),(112,2,46,1),(113,2,47,1),(114,2,48,1);
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

-- Dump completed on 2016-04-14 22:36:13
