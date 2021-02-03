-- MySQL dump 10.17  Distrib 10.3.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: zabbix
-- ------------------------------------------------------
-- Server version	10.3.25-MariaDB-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `dashboard`
--

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;
REPLACE INTO `dashboard` VALUES (1,'Global view',1,0),(2,'Zabbix server health',1,1),(4,'Armen Matevosyan',1,1);
/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dashboard_user`
--

LOCK TABLES `dashboard_user` WRITE;
/*!40000 ALTER TABLE `dashboard_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dashboard_usrgrp`
--

LOCK TABLES `dashboard_usrgrp` WRITE;
/*!40000 ALTER TABLE `dashboard_usrgrp` DISABLE KEYS */;
REPLACE INTO `dashboard_usrgrp` VALUES (1,2,7,3);
/*!40000 ALTER TABLE `dashboard_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `widget`
--

LOCK TABLES `widget` WRITE;
/*!40000 ALTER TABLE `widget` DISABLE KEYS */;
REPLACE INTO `widget` VALUES (1,1,'systeminfo','',0,0,8,4,0),(2,1,'hostavail','',8,0,12,2,1),(3,1,'problemsbysv','',8,2,12,2,1),(4,1,'clock','',20,0,4,4,1),(5,1,'problems','',0,4,20,10,0),(6,1,'favmaps','',20,4,4,5,0),(7,1,'favgraphs','',20,9,4,5,0),(8,2,'problems','Zabbix server problems',0,0,20,4,0),(9,2,'clock','Local time',20,0,4,4,1),(10,2,'svggraph','Values processed per second',0,4,8,5,0),(11,2,'svggraph','Utilization of data collectors',8,4,8,5,0),(12,2,'svggraph','Utilization of internal processes',16,4,8,5,0),(13,2,'svggraph','Cache usage',0,9,8,5,0),(14,2,'svggraph','Value cache effectiveness',8,9,8,5,0),(15,2,'svggraph','Queue size',16,9,8,5,0),(21,4,'graph','CPU',0,0,12,5,0),(22,4,'graph','Memory',12,0,12,5,0),(24,4,'graph','Network trafic',12,5,12,5,0),(25,4,'graph','',0,5,12,5,0);
/*!40000 ALTER TABLE `widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `widget_field`
--

LOCK TABLES `widget_field` WRITE;
/*!40000 ALTER TABLE `widget_field` DISABLE KEYS */;
REPLACE INTO `widget_field` VALUES (1,2,0,'interface_type',1,'',NULL,NULL,NULL,NULL,NULL),(2,3,0,'show_type',1,'',NULL,NULL,NULL,NULL,NULL),(3,5,0,'show',3,'',NULL,NULL,NULL,NULL,NULL),(4,5,0,'show_tags',3,'',NULL,NULL,NULL,NULL,NULL),(5,8,3,'hostids',0,'',NULL,10084,NULL,NULL,NULL),(6,10,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(7,10,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(8,10,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(9,10,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(10,10,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(11,10,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(12,10,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(13,10,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(14,10,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(15,10,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(16,10,1,'ds.color.0',0,'00BFFF',NULL,NULL,NULL,NULL,NULL),(17,10,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(18,10,1,'ds.items.0.0',0,'Number of processed *values per second',NULL,NULL,NULL,NULL,NULL),(19,10,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(20,10,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(21,10,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(22,11,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(23,11,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(24,11,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(25,11,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(26,11,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(27,11,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(28,11,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(29,11,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(30,11,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(31,11,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(32,11,1,'ds.color.0',0,'E57373',NULL,NULL,NULL,NULL,NULL),(33,11,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(34,11,1,'ds.items.0.0',0,'Utilization of * data collector *',NULL,NULL,NULL,NULL,NULL),(35,11,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(36,11,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(37,11,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(38,11,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(39,12,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(40,12,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(41,12,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(42,12,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(43,12,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(44,12,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(45,12,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(46,12,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(47,12,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(48,12,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(49,12,1,'ds.color.0',0,'E57373',NULL,NULL,NULL,NULL,NULL),(50,12,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(51,12,1,'ds.items.0.0',0,'Utilization of * internal *',NULL,NULL,NULL,NULL,NULL),(52,12,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(53,12,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(54,12,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(55,12,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(56,13,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(57,13,0,'ds.fill.0',0,'',NULL,NULL,NULL,NULL,NULL),(58,13,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(59,13,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(60,13,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(61,13,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(62,13,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(63,13,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(64,13,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(65,13,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(66,13,1,'ds.color.0',0,'4DB6AC',NULL,NULL,NULL,NULL,NULL),(67,13,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(68,13,1,'ds.items.0.0',0,'Zabbix*cache*% used',NULL,NULL,NULL,NULL,NULL),(69,13,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(70,13,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(71,13,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(72,13,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(73,14,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(74,14,0,'ds.axisy.1',0,'',NULL,NULL,NULL,NULL,NULL),(75,14,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(76,14,0,'ds.fill.1',3,'',NULL,NULL,NULL,NULL,NULL),(77,14,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(78,14,0,'ds.missingdatafunc.1',0,'',NULL,NULL,NULL,NULL,NULL),(79,14,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(80,14,0,'ds.transparency.1',0,'',NULL,NULL,NULL,NULL,NULL),(81,14,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(82,14,0,'ds.type.1',0,'',NULL,NULL,NULL,NULL,NULL),(83,14,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(84,14,0,'ds.width.1',2,'',NULL,NULL,NULL,NULL,NULL),(85,14,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(86,14,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(87,14,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(88,14,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(89,14,1,'ds.color.0',0,'9CCC65',NULL,NULL,NULL,NULL,NULL),(90,14,1,'ds.color.1',0,'FF465C',NULL,NULL,NULL,NULL,NULL),(91,14,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(92,14,1,'ds.hosts.1.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(93,14,1,'ds.items.0.0',0,'Zabbix value cache hits',NULL,NULL,NULL,NULL,NULL),(94,14,1,'ds.items.1.0',0,'Zabbix value cache misses',NULL,NULL,NULL,NULL,NULL),(95,14,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(96,14,1,'ds.timeshift.1',0,'',NULL,NULL,NULL,NULL,NULL),(97,14,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(98,14,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(99,15,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(100,15,0,'ds.axisy.1',0,'',NULL,NULL,NULL,NULL,NULL),(101,15,0,'ds.axisy.2',0,'',NULL,NULL,NULL,NULL,NULL),(102,15,0,'ds.fill.0',0,'',NULL,NULL,NULL,NULL,NULL),(103,15,0,'ds.fill.1',0,'',NULL,NULL,NULL,NULL,NULL),(104,15,0,'ds.fill.2',0,'',NULL,NULL,NULL,NULL,NULL),(105,15,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(106,15,0,'ds.missingdatafunc.1',0,'',NULL,NULL,NULL,NULL,NULL),(107,15,0,'ds.missingdatafunc.2',0,'',NULL,NULL,NULL,NULL,NULL),(108,15,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(109,15,0,'ds.transparency.1',0,'',NULL,NULL,NULL,NULL,NULL),(110,15,0,'ds.transparency.2',0,'',NULL,NULL,NULL,NULL,NULL),(111,15,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(112,15,0,'ds.type.1',0,'',NULL,NULL,NULL,NULL,NULL),(113,15,0,'ds.type.2',0,'',NULL,NULL,NULL,NULL,NULL),(114,15,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(115,15,0,'ds.width.1',2,'',NULL,NULL,NULL,NULL,NULL),(116,15,0,'ds.width.2',2,'',NULL,NULL,NULL,NULL,NULL),(117,15,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(118,15,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(119,15,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(120,15,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(121,15,1,'ds.color.0',0,'B0AF07',NULL,NULL,NULL,NULL,NULL),(122,15,1,'ds.color.1',0,'E53935',NULL,NULL,NULL,NULL,NULL),(123,15,1,'ds.color.2',0,'0275B8',NULL,NULL,NULL,NULL,NULL),(124,15,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(125,15,1,'ds.hosts.1.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(126,15,1,'ds.hosts.2.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(127,15,1,'ds.items.0.0',0,'Zabbix queue',NULL,NULL,NULL,NULL,NULL),(128,15,1,'ds.items.1.0',0,'Zabbix queue over 10 minutes',NULL,NULL,NULL,NULL,NULL),(129,15,1,'ds.items.2.0',0,'Zabbix preprocessing queue',NULL,NULL,NULL,NULL,NULL),(130,15,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(131,15,1,'ds.timeshift.1',0,'',NULL,NULL,NULL,NULL,NULL),(132,15,1,'ds.timeshift.2',0,'',NULL,NULL,NULL,NULL,NULL),(133,15,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(134,15,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(140,21,0,'dynamic',1,'',NULL,NULL,NULL,NULL,NULL),(141,21,0,'rf_rate',10,'',NULL,NULL,NULL,NULL,NULL),(142,21,6,'graphid',0,'',NULL,NULL,NULL,910,NULL),(143,22,0,'dynamic',1,'',NULL,NULL,NULL,NULL,NULL),(144,22,0,'rf_rate',10,'',NULL,NULL,NULL,NULL,NULL),(145,22,6,'graphid',0,'',NULL,NULL,NULL,919,NULL),(149,24,0,'dynamic',1,'',NULL,NULL,NULL,NULL,NULL),(150,24,0,'rf_rate',10,'',NULL,NULL,NULL,NULL,NULL),(151,24,6,'graphid',0,'',NULL,NULL,NULL,1392,NULL),(152,25,6,'graphid',0,'',NULL,NULL,NULL,1390,NULL);
/*!40000 ALTER TABLE `widget_field` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-02 14:45:35