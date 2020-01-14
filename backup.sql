-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: app
-- ------------------------------------------------------
-- Server version	5.7.26

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
-- Table structure for table `bti_files`
--

DROP TABLE IF EXISTS `bti_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bti_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bti_files_created_user_id_foreign` (`created_user_id`),
  KEY `bti_files_object_id_foreign` (`object_id`),
  CONSTRAINT `bti_files_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `bti_files_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bti_files`
--

LOCK TABLES `bti_files` WRITE;
/*!40000 ALTER TABLE `bti_files` DISABLE KEYS */;
INSERT INTO `bti_files` VALUES (1,6,3,'plan-bti-3.jpg',NULL,'2019-06-24 06:23:04','2019-06-24 06:23:04',''),(2,6,3,'plan-bti-2.jpg',NULL,'2019-06-24 06:23:04','2019-06-24 06:23:04',''),(3,6,3,'plan-bti.jpg',NULL,'2019-06-24 06:23:04','2019-06-24 06:23:04',''),(4,6,3,'plan-bti-3.jpg','2019-07-30 10:47:41','2019-07-30 10:00:27','2019-07-30 10:47:41','floor 3'),(5,6,3,'plan-bti-2.jpg','2019-07-30 10:47:36','2019-07-30 10:02:53','2019-07-30 10:47:36','floor 2'),(6,6,3,'plan-bti.jpg','2019-07-30 10:45:45','2019-07-30 10:04:04','2019-07-30 10:45:45','floor 1'),(7,6,3,'plan-bti.jpg','2019-07-30 10:51:41','2019-07-30 10:49:53','2019-07-30 10:51:41','floor 1'),(8,4,3,'plan-bti.jpg',NULL,'2019-08-15 05:43:53','2019-08-15 05:43:53','1 этаж');
/*!40000 ALTER TABLE `bti_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cable_types`
--

DROP TABLE IF EXISTS `cable_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cable_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cable_types`
--

LOCK TABLES `cable_types` WRITE;
/*!40000 ALTER TABLE `cable_types` DISABLE KEYS */;
INSERT INTO `cable_types` VALUES (1,'RK 50',NULL,NULL),(2,'RG 213',NULL,NULL),(3,'rj 45','2019-10-20 17:48:06','2019-10-20 17:48:06');
/*!40000 ALTER TABLE `cable_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) unsigned NOT NULL,
  `technic_id` bigint(20) unsigned NOT NULL,
  `object_id` bigint(20) unsigned NOT NULL,
  `device_id` bigint(20) unsigned DEFAULT NULL,
  `work_type` set('repair','reglament','setup') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reglament_dev_type` set('sensor','wire','device') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reglament_id` bigint(20) unsigned DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `planned_at` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_admin_id_foreign` (`admin_id`),
  KEY `calendar_technik_id_foreign` (`technic_id`),
  KEY `calendar_object_id_foreign` (`object_id`),
  KEY `calendar_device_id_foreign` (`device_id`),
  CONSTRAINT `calendar_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`),
  CONSTRAINT `calendar_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `device_aps` (`id`),
  CONSTRAINT `calendar_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  CONSTRAINT `calendar_technik_id_foreign` FOREIGN KEY (`technic_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar`
--

LOCK TABLES `calendar` WRITE;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
INSERT INTO `calendar` VALUES (2,3,5,1,NULL,'setup',NULL,NULL,'','2019-09-11 13:30:09','2019-09-11 13:30:09',NULL,'2019-09-11'),(3,3,5,1,NULL,'repair',NULL,NULL,'','2019-09-11 13:30:09','2019-09-11 13:30:09',NULL,'2019-09-11'),(4,3,5,1,NULL,'reglament',NULL,NULL,'','2019-09-11 13:30:10','2019-09-11 13:30:10',NULL,'2019-09-11');
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `completed_works`
--

DROP TABLE IF EXISTS `completed_works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completed_works` (
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL,
  `object_device_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `work_type` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completed_works`
--

LOCK TABLES `completed_works` WRITE;
/*!40000 ALTER TABLE `completed_works` DISABLE KEYS */;
INSERT INTO `completed_works` VALUES (NULL,1,1,74,3,0,'2020-01-06 18:33:20','2020-01-06 18:33:20');
/*!40000 ALTER TABLE `completed_works` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_alerts`
--

DROP TABLE IF EXISTS `device_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_alerts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` set('sound','voice','light') COLLATE utf8mb4_unicode_ci NOT NULL,
  `power` double NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_alerts_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `device_alerts_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_alerts`
--

LOCK TABLES `device_alerts` WRITE;
/*!40000 ALTER TABLE `device_alerts` DISABLE KEYS */;
INSERT INTO `device_alerts` VALUES (1,'AL-S58 (VS-85)','sound',30,3,NULL,'2019-06-23 09:58:56','2019-06-23 09:58:56',NULL),(2,'Соната-М','voice',3,3,NULL,'2019-06-23 10:14:15','2019-06-23 11:04:11',NULL),(3,'Свет-1','light',5,3,NULL,'2019-07-01 06:47:38','2019-07-01 06:47:38',NULL),(4,'al-851','sound',30,3,'2019-09-13 05:20:43','2019-09-13 05:14:01','2019-09-13 05:20:43','4306649.pdf');
/*!40000 ALTER TABLE `device_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_antenna`
--

DROP TABLE IF EXISTS `device_antenna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_antenna` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_antenna_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `device_antenna_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_antenna`
--

LOCK TABLES `device_antenna` WRITE;
/*!40000 ALTER TABLE `device_antenna` DISABLE KEYS */;
INSERT INTO `device_antenna` VALUES (1,'Антенна-1','/tmp/php9SEp0O',3,NULL,'2019-06-23 06:44:15','2019-06-23 07:15:07'),(2,'Антенна-2',NULL,3,'2019-06-23 06:44:45','2019-06-23 06:44:28','2019-06-23 06:44:45'),(3,'Антенна-22',NULL,3,NULL,'2019-06-23 06:45:02','2019-09-13 05:27:24'),(4,'Антенна 3',NULL,3,'2019-08-27 06:56:52','2019-08-27 06:31:37','2019-08-27 06:56:52'),(5,'Антенна 3',NULL,3,'2019-08-27 06:42:20','2019-08-27 06:40:20','2019-08-27 06:42:20'),(6,'Antenna 4','dns adguard',3,'2019-08-27 06:56:49','2019-08-27 06:48:32','2019-08-27 06:56:49'),(7,'Antenna 5','084-69-05-19-0012975.pdf',3,'2019-08-27 06:56:44','2019-08-27 06:52:21','2019-08-27 06:56:44'),(8,'www',NULL,3,'2019-09-13 05:27:13','2019-09-13 05:27:06','2019-09-13 05:27:13');
/*!40000 ALTER TABLE `device_antenna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_antenna_params`
--

DROP TABLE IF EXISTS `device_antenna_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_antenna_params` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) unsigned NOT NULL,
  `setup_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mast_isset` tinyint(1) NOT NULL DEFAULT '0',
  `mast_height` double(4,2) DEFAULT NULL,
  `cable_type` int(10) unsigned DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_antenna_params_created_user_id_foreign` (`created_user_id`),
  KEY `device_antenna_params_device_antenna_id_foreign_idx` (`device_id`),
  CONSTRAINT `device_antenna_params_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `device_antenna_params_device_antenna_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `object_devices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_antenna_params`
--

LOCK TABLES `device_antenna_params` WRITE;
/*!40000 ALTER TABLE `device_antenna_params` DISABLE KEYS */;
INSERT INTO `device_antenna_params` VALUES (2,16,'Roof2',1,40.00,1,3,NULL,'2019-07-10 07:24:01','2019-07-10 08:26:45'),(3,68,'roof',1,2.00,2,3,NULL,'2019-09-05 05:41:09','2019-09-05 05:41:09'),(4,91,'roof',1,10.00,3,3,NULL,'2019-10-20 18:09:45','2019-10-20 18:52:19');
/*!40000 ALTER TABLE `device_antenna_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_aps`
--

DROP TABLE IF EXISTS `device_aps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_aps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wires_count` tinyint(4) NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devices_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `devices_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_aps`
--

LOCK TABLES `device_aps` WRITE;
/*!40000 ALTER TABLE `device_aps` DISABLE KEYS */;
INSERT INTO `device_aps` VALUES (1,'АМП-4',4,'amp4.pdf',3,'2019-05-22 19:02:19','2019-05-22 19:31:22','2019-05-22 19:31:22'),(2,'АМП-4',4,'amp4.pdf',3,'2019-05-22 19:11:52','2019-05-22 19:31:26','2019-05-22 19:31:22'),(3,'АМП-4',4,'amp4.pdf',3,'2019-05-22 19:14:15','2019-05-22 19:31:31','2019-05-22 19:31:22'),(4,'АМП-4',4,'amp4.pdf',3,'2019-05-22 19:31:45','2019-05-23 04:34:01','2019-05-22 19:31:22'),(5,'АМП-4',4,'amp4.pdf',3,'2019-05-23 04:34:18','2019-05-23 04:36:21','2019-05-22 19:31:22'),(6,'АМП-4',4,'amp4.pdf',3,'2019-05-23 04:36:31','2019-05-23 04:47:52','2019-05-22 19:31:22'),(7,'АМП-4',4,'amp4.pdf',3,'2019-05-23 04:46:04','2019-05-23 04:47:53','2019-05-22 19:31:22'),(8,'АМП-4',4,'amp4.pdf',3,'2019-05-23 04:47:00','2019-05-23 04:47:55','2019-05-22 19:31:22'),(9,'АМП-4',4,'amp4.pdf',3,'2019-05-23 04:47:39','2019-05-23 08:59:27',NULL),(10,'АМП-20',12,NULL,3,'2019-05-27 16:47:37','2019-09-13 05:29:46',NULL),(11,'FVG-6',5,NULL,3,'2019-06-20 07:19:51','2019-09-13 05:29:36','2019-09-13 05:29:36'),(16,'qwe',7,'Промышленность ЧО',3,'2019-08-26 10:44:43','2019-08-27 06:23:18','2019-08-27 06:23:18'),(17,'FVG-6',6,NULL,3,'2019-09-13 05:30:22','2019-09-13 05:30:22',NULL);
/*!40000 ALTER TABLE `device_aps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_aps_params`
--

DROP TABLE IF EXISTS `device_aps_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_aps_params` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) unsigned NOT NULL,
  `accumulator_isset` int(11) DEFAULT NULL,
  `accumulator_count` int(11) DEFAULT NULL,
  `battery_capacity` double(8,2) DEFAULT NULL,
  `output_voltage` int(11) DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_aps_params_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `device_aps_params_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_aps_params`
--

LOCK TABLES `device_aps_params` WRITE;
/*!40000 ALTER TABLE `device_aps_params` DISABLE KEYS */;
INSERT INTO `device_aps_params` VALUES (1,92,1,1,7.00,12,3,NULL,'2019-10-29 05:49:14','2019-10-29 05:49:14');
/*!40000 ALTER TABLE `device_aps_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_class`
--

DROP TABLE IF EXISTS `device_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_class` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_class`
--

LOCK TABLES `device_class` WRITE;
/*!40000 ALTER TABLE `device_class` DISABLE KEYS */;
INSERT INTO `device_class` VALUES (1,'РСПИ',1,'2019-05-22 09:44:41','2019-05-22 09:47:50'),(2,'Охранно-пожарная сигнализация',1,'2019-05-22 18:19:26','2019-05-22 18:19:26'),(3,'Антенна',1,'2019-05-27 05:16:49','2019-05-27 05:16:49');
/*!40000 ALTER TABLE `device_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_limitations`
--

DROP TABLE IF EXISTS `device_limitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_limitations` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) unsigned NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isCritical` tinyint(4) DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tbl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_limitations_created_user_id_foreign` (`created_user_id`),
  KEY `device_limitations_device_id_foreign` (`device_id`),
  CONSTRAINT `device_limitations_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_limitations`
--

LOCK TABLES `device_limitations` WRITE;
/*!40000 ALTER TABLE `device_limitations` DISABLE KEYS */;
INSERT INTO `device_limitations` VALUES (1,1,'Недостаток 112',1,3,NULL,'2019-09-27 05:39:24',NULL,'App\\device_antenna'),(2,1,'Недостаток 21',NULL,3,NULL,'2019-08-07 04:19:28',NULL,'App\\device_antenna'),(3,1,'Недостаток 3',NULL,3,'2019-08-07 05:14:37','2019-08-07 05:14:37',NULL,'App\\device_antenna'),(4,1,'Недостаток 4',NULL,3,'2019-08-07 05:15:56','2019-08-07 05:15:56',NULL,'App\\device_antenna'),(5,1,'Недостаток 51',NULL,3,'2019-08-07 05:28:19','2019-09-16 05:42:00',NULL,'App\\device_antenna'),(6,1,'Недостаток 6',NULL,3,'2019-08-07 05:30:40','2019-08-07 05:56:42','2019-08-07 05:56:42','App\\device_antenna'),(7,1,'Недостаток 7',NULL,3,'2019-08-07 05:41:41','2019-08-07 05:56:35','2019-08-07 05:56:35','App\\device_antenna'),(8,1,'Недостаток 8',NULL,3,'2019-08-07 05:49:08','2019-08-07 05:55:15','2019-08-07 05:55:15','App\\device_antenna'),(9,1,'Недостаток 8',NULL,3,'2019-08-07 05:49:08','2019-08-07 05:54:06','2019-08-07 05:54:06','App\\device_antenna'),(10,3,'Недостаток 1',NULL,3,'2019-08-07 05:56:59','2019-08-07 05:56:59',NULL,'App\\device_antenna'),(11,9,'Недостаток 1',NULL,3,'2019-08-07 06:03:15','2019-08-07 06:03:15',NULL,'App\\device_aps'),(12,9,'Недостаток 2',NULL,3,'2019-08-07 06:03:15','2019-08-07 06:03:15',NULL,'App\\device_aps'),(13,9,'Недостаток 3',NULL,3,'2019-08-07 06:03:15','2019-08-07 06:03:15',NULL,'App\\device_aps'),(14,1,'Неисправность извещателя',NULL,3,NULL,NULL,NULL,'App\\Sensor'),(15,2,'Неисправность извещателя',NULL,3,NULL,NULL,NULL,'App\\Sensor'),(16,3,'Неисправность извещателя',NULL,3,NULL,NULL,NULL,'App\\Sensor'),(17,4,'Неисправность извещателя',NULL,3,NULL,NULL,NULL,'App\\Sensor'),(18,5,'Неисправность извещателя',NULL,3,NULL,NULL,NULL,'App\\Sensor'),(19,6,'Неисправность извещателя',NULL,3,NULL,NULL,NULL,'App\\Sensor'),(20,8,'Неисправность извещателя',NULL,3,'2019-08-29 12:26:19','2019-08-29 12:26:19',NULL,'App\\Sensor'),(21,1,'rrr',NULL,3,'2019-09-13 05:42:42','2019-09-13 05:43:29','2019-09-13 05:43:29','App\\Sensor'),(22,1,'qqq',NULL,3,'2019-09-13 05:43:44','2019-09-13 05:43:44',NULL,'App\\Sensor'),(23,1,'3',NULL,3,'2019-09-13 05:48:55','2019-09-13 05:53:09',NULL,'App\\device_system_voice_alert'),(24,2,'Недостаток 1',NULL,3,'2019-09-23 07:17:56','2019-09-23 07:17:56',NULL,'App\\device_alert'),(25,2,'Недостаток 2',NULL,3,'2019-09-23 07:17:59','2019-09-23 07:17:59',NULL,'App\\device_alert'),(26,9,'Неисправность извещателя',NULL,3,'2019-11-11 07:43:24','2019-11-11 07:43:24',NULL,'App\\Sensor');
/*!40000 ALTER TABLE `device_limitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_power_supplies`
--

DROP TABLE IF EXISTS `device_power_supplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_power_supplies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accumulator_count` int(11) DEFAULT NULL,
  `battery_capacity` double(8,2) DEFAULT NULL,
  `output_voltage` double(8,2) DEFAULT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_power_supplies`
--

LOCK TABLES `device_power_supplies` WRITE;
/*!40000 ALTER TABLE `device_power_supplies` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_power_supplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_reglament`
--

DROP TABLE IF EXISTS `device_reglament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_reglament` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day` tinyint(4) DEFAULT NULL,
  `year` tinyint(4) DEFAULT NULL,
  `month` tinyint(4) DEFAULT NULL,
  `week` tinyint(4) DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `device_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tbl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_reglament_created_user_id_foreign` (`created_user_id`),
  KEY `device_reglament_dvice_id_foreign` (`device_id`),
  CONSTRAINT `device_reglament_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_reglament`
--

LOCK TABLES `device_reglament` WRITE;
/*!40000 ALTER TABLE `device_reglament` DISABLE KEYS */;
INSERT INTO `device_reglament` VALUES (63,'Ежемесячный',NULL,NULL,1,NULL,3,9,'2019-08-20 08:22:08','2019-08-21 08:28:12','2019-08-21 08:28:12','App\\device_aps',0),(64,'Еженедельный',NULL,NULL,NULL,NULL,3,9,'2019-08-20 08:22:56','2019-08-21 08:28:14','2019-08-21 08:28:14','App\\device_aps',0),(65,'1',1,NULL,NULL,NULL,3,9,'2019-08-20 08:26:18','2019-08-21 08:28:16','2019-08-21 08:28:16','App\\device_aps',0),(66,'2',2,NULL,NULL,NULL,3,9,'2019-08-20 08:26:59','2019-08-21 08:28:18','2019-08-21 08:28:18','App\\device_aps',0),(67,'3',NULL,NULL,NULL,NULL,3,9,'2019-08-20 08:27:38','2019-08-21 08:28:20','2019-08-21 08:28:20','App\\device_aps',0),(68,'1',NULL,NULL,NULL,NULL,3,1,'2019-08-20 08:31:09','2019-08-20 08:35:33','2019-08-20 08:35:33','App\\device_antenna',0),(69,'2',NULL,NULL,NULL,NULL,3,1,'2019-08-20 08:33:22','2019-08-20 08:35:31','2019-08-20 08:35:31','App\\device_antenna',0),(70,'1234567',NULL,NULL,NULL,2,3,1,'2019-08-20 08:35:53','2020-01-09 20:09:11',NULL,'App\\device_antenna',10),(71,'2',NULL,NULL,NULL,NULL,3,1,'2019-08-20 08:36:45','2019-08-20 08:36:45',NULL,'App\\device_antenna',0),(72,'3',NULL,NULL,NULL,NULL,3,1,'2019-08-20 08:37:53','2019-08-20 08:37:53',NULL,'App\\device_antenna',0),(73,'4',NULL,NULL,NULL,NULL,3,9,'2019-08-20 08:39:14','2019-08-21 08:28:21','2019-08-21 08:28:21','App\\device_aps',0),(74,'5',NULL,NULL,NULL,2,3,9,'2019-08-20 08:39:50','2020-01-08 18:23:35','2020-01-08 18:23:35','App\\device_aps',0),(75,'4',NULL,NULL,NULL,NULL,3,1,'2019-08-20 08:41:01','2019-08-20 08:41:01',NULL,'App\\device_antenna',0),(76,'5',NULL,NULL,NULL,NULL,3,1,'2019-08-20 08:42:58','2019-08-20 08:42:58',NULL,'App\\device_antenna',0),(77,'61',NULL,1,NULL,NULL,3,1,'2019-08-20 08:49:23','2020-01-09 19:55:26',NULL,'App\\device_antenna',50),(78,'7',NULL,NULL,NULL,2,3,1,'2019-08-20 08:51:17','2019-08-20 08:51:31',NULL,'App\\device_antenna',0),(79,'test',NULL,NULL,2,NULL,3,9,'2019-08-21 09:41:14','2020-01-08 18:23:55',NULL,'App\\device_aps',50),(80,'Test',NULL,NULL,NULL,2,3,1,'2019-08-29 11:15:50','2019-08-29 11:15:50',NULL,'App\\Sensor',0),(81,'asd reglament 1',NULL,NULL,NULL,2,3,1,'2019-09-13 06:02:45','2019-09-13 06:02:45',NULL,'App\\Sensor',0),(82,'Ежемесячный',NULL,NULL,1,NULL,3,2,'2019-09-23 07:18:50','2019-09-23 07:18:50',NULL,'App\\device_alert',50),(83,'Полугодовой',NULL,NULL,6,NULL,3,9,'2019-11-11 07:44:27','2019-11-11 07:44:27',NULL,'App\\Sensor',20),(84,'Перыый',NULL,NULL,6,NULL,3,3,'2020-01-08 18:23:02','2020-01-08 18:23:02',NULL,'App\\device_rspi',45);
/*!40000 ALTER TABLE `device_reglament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_reglament_element`
--

DROP TABLE IF EXISTS `device_reglament_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_reglament_element` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_reglament_id` smallint(5) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_reglament_element_created_user_id_foreign` (`created_user_id`),
  KEY `device_reglament_element_dvice_reglament_id_foreign` (`device_reglament_id`),
  CONSTRAINT `device_reglament_element_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `device_reglament_element_dvice_reglament_id_foreign` FOREIGN KEY (`device_reglament_id`) REFERENCES `device_reglament` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_reglament_element`
--

LOCK TABLES `device_reglament_element` WRITE;
/*!40000 ALTER TABLE `device_reglament_element` DISABLE KEYS */;
INSERT INTO `device_reglament_element` VALUES (23,'Сделать то',63,3,'2019-08-20 08:22:40','2019-08-21 08:28:12','2019-08-21 08:28:12'),(24,'1',74,3,'2019-08-20 08:39:52','2020-01-08 18:23:35','2020-01-08 18:23:35'),(25,'2',74,3,'2019-08-20 08:39:52','2020-01-08 18:23:35','2020-01-08 18:23:35'),(26,'2',75,3,'2019-08-20 08:41:11','2019-08-20 08:41:11',NULL),(27,'3',75,3,'2019-08-20 08:41:11','2019-08-20 08:41:11',NULL),(28,'1',76,3,'2019-08-20 08:43:00','2019-08-20 08:43:00',NULL),(29,'2',76,3,'2019-08-20 08:43:09','2019-08-20 08:43:09',NULL),(30,'3',76,3,'2019-08-20 08:45:28','2019-08-20 08:45:28',NULL),(31,'4',76,3,'2019-08-20 08:49:05','2019-08-20 08:49:05',NULL),(32,'3',76,3,'2019-08-20 08:49:05','2019-08-20 08:49:05',NULL),(33,'1',77,3,'2019-08-20 08:49:29','2019-08-20 08:49:29',NULL),(34,'1',78,3,'2019-08-20 08:51:19','2019-08-20 08:51:19',NULL),(35,'2',78,3,'2019-08-20 08:51:23','2019-08-20 08:51:23',NULL),(36,'Работа 1',79,3,'2019-08-21 09:41:14','2019-08-21 09:41:14',NULL),(37,'Работа 2',79,3,'2019-08-21 09:41:14','2019-08-21 09:41:14',NULL),(38,'222',80,3,'2019-08-29 11:15:51','2019-08-29 11:15:51',NULL),(39,'111',80,3,'2019-08-29 11:15:51','2019-08-29 11:15:51',NULL),(40,'option 1',81,3,'2019-09-13 06:03:11','2019-09-13 06:03:11',NULL),(41,'option 2',81,3,'2019-09-13 06:03:11','2019-09-13 06:03:11',NULL),(42,'option 35',81,3,'2019-09-13 06:03:11','2019-09-13 06:03:53',NULL),(43,'Работа 2',82,3,'2019-09-23 07:18:51','2019-09-23 07:18:51',NULL),(44,'Работа 1',82,3,'2019-09-23 07:18:51','2019-09-23 07:18:51',NULL),(45,'Закрыть',83,3,'2019-11-11 07:44:27','2019-11-11 07:44:27',NULL),(46,'Протереть',83,3,'2019-11-11 07:44:27','2019-11-11 07:44:27',NULL),(47,'Открыть',83,3,'2019-11-11 07:44:27','2019-11-11 07:44:27',NULL),(48,'1',70,3,'2020-01-09 19:46:17','2020-01-09 19:46:17',NULL),(49,'2',70,3,'2020-01-09 19:46:17','2020-01-09 19:46:17',NULL),(50,'3',70,3,'2020-01-09 19:46:17','2020-01-09 19:46:17',NULL),(51,'4',70,3,'2020-01-09 19:46:17','2020-01-09 19:46:17',NULL),(52,'5',70,3,'2020-01-09 19:46:17','2020-01-09 19:46:17',NULL),(53,'6',70,3,'2020-01-09 19:46:18','2020-01-09 19:46:18',NULL),(54,'2',77,3,'2020-01-09 20:44:49','2020-01-09 20:44:49',NULL),(55,'3',77,3,'2020-01-09 20:44:50','2020-01-09 20:44:50',NULL),(56,'6',77,3,'2020-01-09 20:44:50','2020-01-09 20:44:50',NULL),(57,'5',77,3,'2020-01-09 20:44:50','2020-01-09 20:44:50',NULL),(58,'4',77,3,'2020-01-09 20:44:51','2020-01-09 20:44:51',NULL),(59,'7',77,3,'2020-01-09 20:44:51','2020-01-09 20:44:51',NULL),(60,'8',77,3,'2020-01-09 20:44:51','2020-01-09 20:44:51',NULL);
/*!40000 ALTER TABLE `device_reglament_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_rspi`
--

DROP TABLE IF EXISTS `device_rspi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_rspi` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_rspi_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `device_rspi_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_rspi`
--

LOCK TABLES `device_rspi` WRITE;
/*!40000 ALTER TABLE `device_rspi` DISABLE KEYS */;
INSERT INTO `device_rspi` VALUES (1,'ffgg-up-1','Таблиа общих сведений по АПС.xlsx',3,NULL,'2019-06-23 07:06:16','2019-06-23 07:43:27'),(2,'РСПИ-2-1','ResearchPal.zip',3,'2019-06-23 07:45:47','2019-06-23 07:44:10','2019-06-23 07:45:47'),(3,'РСПИ-1','Таблиа общих сведений по АПС.xlsx',3,NULL,'2019-06-23 08:03:21','2019-06-23 08:03:21'),(4,'РСПИ-2','Таблиа общих сведений по АПС.xlsx',3,'2019-06-23 08:04:45','2019-06-23 08:04:03','2019-06-23 08:04:45'),(5,'РСПИ-2','Таблиа общих сведений по АПС.xlsx',3,NULL,'2019-06-23 08:04:56','2019-06-23 08:04:56'),(6,'РСПИ 32','dns adguard',3,NULL,'2019-08-27 06:57:06','2019-09-13 05:25:39'),(7,'fff',NULL,3,'2019-09-13 05:25:34','2019-09-13 05:25:28','2019-09-13 05:25:34');
/*!40000 ALTER TABLE `device_rspi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_rspi_params`
--

DROP TABLE IF EXISTS `device_rspi_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_rspi_params` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `setup_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `battery` tinyint(1) NOT NULL,
  `power_supply` tinyint(1) NOT NULL,
  `capacity` double(8,2) DEFAULT NULL,
  `coupling` set('fire','fault','fire/fault') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `device_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_rspi_params_created_user_id_foreign` (`created_user_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `device_rspi_params_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `device_rspi_params_object_devices_FK` FOREIGN KEY (`device_id`) REFERENCES `object_devices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_rspi_params`
--

LOCK TABLES `device_rspi_params` WRITE;
/*!40000 ALTER TABLE `device_rspi_params` DISABLE KEYS */;
INSERT INTO `device_rspi_params` VALUES (3,'1 cabinet',0,0,600.00,'fault',3,17,NULL,'2019-07-25 07:42:55','2019-07-25 07:47:30'),(4,'cabinet 1',1,1,120.00,'fire',3,70,NULL,'2019-09-05 05:58:31','2019-09-05 05:58:31'),(5,'roof',1,1,20.00,'fire/fault',3,87,NULL,'2019-10-20 17:56:17','2019-10-29 04:37:21');
/*!40000 ALTER TABLE `device_rspi_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_system_voice_alerts`
--

DROP TABLE IF EXISTS `device_system_voice_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_system_voice_alerts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_system_voice_alerts_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `device_system_voice_alerts_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_system_voice_alerts`
--

LOCK TABLES `device_system_voice_alerts` WRITE;
/*!40000 ALTER TABLE `device_system_voice_alerts` DISABLE KEYS */;
INSERT INTO `device_system_voice_alerts` VALUES (1,'СРО-12',3,NULL,'2019-06-23 07:59:03','2019-06-23 08:00:17','Таблиа общих сведений по АПС.xlsx'),(2,'СРО-25',3,NULL,'2019-06-23 08:00:48','2019-09-13 05:22:06','Таблиа общих сведений по АПС.xlsx'),(3,'СРО-3-2',3,'2019-09-13 05:21:30','2019-06-23 08:02:16','2019-09-13 05:21:30','Промышленность ЧО'),(4,'rrr',3,NULL,'2019-09-13 05:24:32','2019-09-13 05:24:32',NULL);
/*!40000 ALTER TABLE `device_system_voice_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_system_voice_alerts_devs`
--

DROP TABLE IF EXISTS `device_system_voice_alerts_devs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_system_voice_alerts_devs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_system_voice_alerts_id` bigint(20) unsigned NOT NULL,
  `device_alerts_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bti_files_id` bigint(20) unsigned DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_system_voice_alerts_devs_device_alerts_id_foreign` (`device_alerts_id`),
  KEY `device_system_voice_alerts_devs_created_user_id_foreign` (`created_user_id`),
  KEY `device_system_voice_alerts_devs_bti_files_id_foreign` (`bti_files_id`),
  CONSTRAINT `device_system_voice_alerts_devs_bti_files_id_foreign` FOREIGN KEY (`bti_files_id`) REFERENCES `bti_files` (`id`),
  CONSTRAINT `device_system_voice_alerts_devs_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `device_system_voice_alerts_devs_device_alerts_id_foreign` FOREIGN KEY (`device_alerts_id`) REFERENCES `device_alerts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_system_voice_alerts_devs`
--

LOCK TABLES `device_system_voice_alerts_devs` WRITE;
/*!40000 ALTER TABLE `device_system_voice_alerts_devs` DISABLE KEYS */;
INSERT INTO `device_system_voice_alerts_devs` VALUES (3,19,1,3,NULL,'2019-07-16 11:00:54','2019-08-07 10:40:49',1,179.9549702,-176.0000000);
/*!40000 ALTER TABLE `device_system_voice_alerts_devs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_system_voice_alerts_params`
--

DROP TABLE IF EXISTS `device_system_voice_alerts_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_system_voice_alerts_params` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) unsigned NOT NULL,
  `accumulator_isset` int(11) DEFAULT NULL,
  `accumulator_count` int(11) DEFAULT NULL,
  `battery_capacity` double(8,2) DEFAULT NULL,
  `output_voltage` int(11) DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_system_voice_alerts_params_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `device_system_voice_alerts_params_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_system_voice_alerts_params`
--

LOCK TABLES `device_system_voice_alerts_params` WRITE;
/*!40000 ALTER TABLE `device_system_voice_alerts_params` DISABLE KEYS */;
INSERT INTO `device_system_voice_alerts_params` VALUES (1,74,1,1,2.00,13,3,NULL,'2019-10-29 05:51:02','2019-10-29 05:59:48');
/*!40000 ALTER TABLE `device_system_voice_alerts_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `districts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (1,'Калининский1',NULL,'2019-10-14 10:44:18',NULL),(9,'123','2019-10-14 07:30:39','2019-10-14 10:52:38','2019-10-14 10:52:38'),(10,'Курчатовский','2019-10-14 11:47:01','2019-10-14 11:47:01',NULL);
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districtsobjects`
--

DROP TABLE IF EXISTS `districtsobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `districtsobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `district_id` bigint(20) unsigned NOT NULL,
  `object_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districtsobjects`
--

LOCK TABLES `districtsobjects` WRITE;
/*!40000 ALTER TABLE `districtsobjects` DISABLE KEYS */;
INSERT INTO `districtsobjects` VALUES (1,1,1,NULL,'2019-10-14 09:13:55','2019-10-14 09:13:55'),(2,1,4,'2019-10-14 11:25:39','2019-10-14 11:25:39',NULL),(3,1,1,'2019-10-14 11:29:15','2019-10-14 11:29:15',NULL),(4,10,4,'2019-10-14 11:47:20','2019-10-14 11:47:20',NULL);
/*!40000 ALTER TABLE `districtsobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districtsusers`
--

DROP TABLE IF EXISTS `districtsusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `districtsusers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `district_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districtsusers`
--

LOCK TABLES `districtsusers` WRITE;
/*!40000 ALTER TABLE `districtsusers` DISABLE KEYS */;
INSERT INTO `districtsusers` VALUES (5,1,3,'2019-10-14 08:39:11','2019-10-14 08:39:11',NULL),(6,1,5,'2019-10-14 08:40:39','2019-10-14 08:57:12','2019-10-14 08:57:12'),(7,1,5,'2019-10-17 05:43:17','2019-10-17 05:43:17',NULL),(8,1,7,'2019-10-17 05:43:20','2020-01-08 16:09:20','2020-01-08 16:09:20'),(9,10,7,'2020-01-08 16:09:24','2020-01-08 16:09:24',NULL);
/*!40000 ALTER TABLE `districtsusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_05_15_055415_raions',2),(4,'2019_05_15_060541_objects',2),(7,'2019_05_15_060035_device_class',3),(8,'2019_05_15_061317_devices',4),(9,'2019_05_15_061835_device_reglament',4),(10,'2019_05_15_065432_device_reglament_element',5),(11,'2019_05_15_065712_device_limitations',6),(12,'2019_05_15_065946_object_devices',7),(13,'2019_05_15_070921_wires',7),(15,'2019_05_15_071538_sensors',8),(16,'2019_05_15_080205_wire_sensor',9),(17,'2019_05_15_080205_wire_sensor_previous_state',10),(18,'2019_05_15_081024_wire_sensor_reglament',10),(19,'2019_05_15_081306_wire_previous_state',10),(20,'2019_05_15_082055_object_device_reglament',11),(21,'2019_05_15_082057_object_device_reglament_limitations',12),(22,'2019_05_15_083012_object_repair_queue',12),(23,'2019_05_15_084106_calendar',12),(24,'2019_05_19_121046_user',13),(25,'2016_06_01_000001_create_oauth_auth_codes_table',14),(26,'2016_06_01_000002_create_oauth_access_tokens_table',14),(27,'2016_06_01_000003_create_oauth_refresh_tokens_table',14),(28,'2016_06_01_000004_create_oauth_clients_table',14),(29,'2016_06_01_000005_create_oauth_personal_access_clients_table',14),(31,'2019_05_26_091713_add_objects_documentation',15),(32,'2019_05_27_110628_change_device',16),(33,'2019_06_07_110528_add_sensor_name',17),(34,'2019_06_10_080205_wire_sensor_previous_state_change',18),(35,'2019_06_10_225405_user_add_raion',19),(36,'2019_06_12_091544_wire_sensor_add_comment',19),(37,'2019_06_12_151353_mediafiles_for_object',20),(38,'2019_06_13_064804_add_setup_place_device',21),(39,'2019_06_15_124504_create_device_rspis_table',22),(40,'2019_06_15_124534_create_device_antennas_table',22),(41,'2019_06_15_124544_create_device_aps_table',22),(42,'2019_06_15_124555_create_device_alerts_table',22),(43,'2019_06_15_213344_object_add_souetype',23),(44,'2019_06_16_082729_create_device_system_voice_alerts_table',23),(45,'2019_06_19_070206_create_device_system_voice_alerts_devs_table',24),(46,'2019_06_19_080458_device_aps_softdelete',24),(47,'2019_06_19_084014_od_device_tabl',25),(48,'2019_06_23_084014_as_device_tbl_chng',26),(49,'2019_06_23_112635_create_bti_files_table',27),(50,'2019_06_09_044231_users_add_fk_raions',28),(51,'2019_07_04_065531_wiresensor_add_soft_delete',29),(52,'2019_07_04_112337_wiresensor_add_lonlat',30),(53,'2019_07_10_065258_change_antenna_cable',31),(54,'2019_07_01_071526_add_od_ll',32),(55,'2019_07_16_120204_d_s_v_a_d_add_params',32),(56,'2019_07_25_075351_add__o_d_isgood',33),(57,'2019_10_25_051519_create_power_supplies_table',34),(58,'2019_10_27_051519_create_device_aps_params_table',35),(59,'2019_10_27_102918_add_object_contract',36),(60,'2019_10_27_102918_create_dsva_params_table',37),(61,'2019_12_28_121013_vocations',38),(62,'2019_12_31_035635_create_completed_works_table',39);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('3ecbc4ac564bfa299f18e75082da23be0c6bcd190b4d4962d7af1cebda4584e6c9a337c9c07f9424',3,1,'MyApp','[]',0,'2019-05-21 18:40:30','2019-05-21 18:40:30','2020-05-21 18:40:30'),('bacded2c5923ef0d2f7196afcb09a67bbb5e56d05d9bf3e5a31e82cb9deb3e579bef7f078e7a5aae',3,1,'MyApp','[]',0,'2019-05-21 10:11:58','2019-05-21 10:11:58','2020-05-21 10:11:58');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'firemonitoring Personal Access Client','fhazxWx3qD5M2Kdobe8adxjSHswsfIVdJ9jegjUS','http://localhost',1,0,0,'2019-05-21 09:40:24','2019-05-21 09:40:24'),(2,NULL,'firemonitoring Password Grant Client','52L7wvgVG9SFw5avqLsW6JHJCvAfycqkyk1wVWeM','http://localhost',0,1,0,'2019-05-21 09:40:24','2019-05-21 09:40:24');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2019-05-21 09:40:24','2019-05-21 09:40:24');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_device_reglament`
--

DROP TABLE IF EXISTS `object_device_reglament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_device_reglament` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_device_id` bigint(20) unsigned NOT NULL,
  `admin_id` bigint(20) unsigned NOT NULL,
  `technik_id` bigint(20) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_device_reglament_admin_id_foreign` (`admin_id`),
  KEY `object_device_reglament_technik_id_foreign` (`technik_id`),
  KEY `object_device_reglament_object_device_id_foreign` (`object_device_id`),
  CONSTRAINT `object_device_reglament_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`),
  CONSTRAINT `object_device_reglament_object_device_id_foreign` FOREIGN KEY (`object_device_id`) REFERENCES `object_devices` (`id`),
  CONSTRAINT `object_device_reglament_technik_id_foreign` FOREIGN KEY (`technik_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_device_reglament`
--

LOCK TABLES `object_device_reglament` WRITE;
/*!40000 ALTER TABLE `object_device_reglament` DISABLE KEYS */;
/*!40000 ALTER TABLE `object_device_reglament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_device_reglament_limitations`
--

DROP TABLE IF EXISTS `object_device_reglament_limitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_device_reglament_limitations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_device_id` bigint(20) unsigned NOT NULL,
  `ODR_id` bigint(20) unsigned DEFAULT NULL,
  `DL_id` smallint(5) unsigned DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `additional_limitation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_limitation_critical` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_device_reglament_limitations_created_user_id_foreign` (`created_user_id`),
  KEY `object_device_reglament_limitations_object_device_id_foreign` (`object_device_id`),
  KEY `object_device_reglament_limitations_odr_id_foreign` (`ODR_id`),
  KEY `object_device_reglament_limitations_dl_id_foreign` (`DL_id`),
  CONSTRAINT `object_device_reglament_limitations_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `object_device_reglament_limitations_dl_id_foreign` FOREIGN KEY (`DL_id`) REFERENCES `device_limitations` (`id`),
  CONSTRAINT `object_device_reglament_limitations_object_device_id_foreign` FOREIGN KEY (`object_device_id`) REFERENCES `object_devices` (`id`),
  CONSTRAINT `object_device_reglament_limitations_odr_id_foreign` FOREIGN KEY (`ODR_id`) REFERENCES `object_device_reglament` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_device_reglament_limitations`
--

LOCK TABLES `object_device_reglament_limitations` WRITE;
/*!40000 ALTER TABLE `object_device_reglament_limitations` DISABLE KEYS */;
INSERT INTO `object_device_reglament_limitations` VALUES (1,1,NULL,11,3,NULL,NULL,NULL,'2019-08-30 10:33:28',NULL),(2,1,NULL,NULL,3,'Какая-то неисправность 3',NULL,NULL,'2019-08-30 10:35:02',NULL),(3,1,NULL,12,3,NULL,NULL,'2019-08-14 07:48:33','2019-08-30 10:35:02','2019-08-30 10:35:02'),(4,1,NULL,13,3,NULL,NULL,'2019-08-14 07:48:33','2019-08-30 10:33:29',NULL),(5,13,NULL,11,3,NULL,NULL,'2019-08-14 08:30:52','2019-09-02 10:49:38','2019-09-02 10:49:38'),(6,13,NULL,12,3,NULL,NULL,'2019-08-14 08:30:52','2019-09-02 10:49:38','2019-09-02 10:49:38'),(7,13,NULL,13,3,NULL,NULL,'2019-08-14 08:30:52','2019-09-02 10:49:38','2019-09-02 10:49:38'),(8,23,NULL,1,3,NULL,NULL,'2019-08-15 05:44:38','2019-08-15 06:02:06','2019-08-15 06:02:06'),(9,23,NULL,2,3,NULL,NULL,'2019-08-15 05:44:39','2019-08-15 06:02:07','2019-08-15 06:02:07'),(10,23,NULL,3,3,NULL,NULL,'2019-08-15 05:44:39','2019-08-15 06:02:07',NULL),(11,23,NULL,4,3,NULL,NULL,'2019-08-15 05:44:40','2019-08-15 06:02:07',NULL),(12,23,NULL,5,3,NULL,NULL,'2019-08-15 05:44:40','2019-08-15 06:02:07','2019-08-15 06:02:07'),(13,13,NULL,NULL,3,'4456',NULL,'2019-09-02 08:12:54','2019-09-02 10:19:51',NULL),(14,69,NULL,1,3,NULL,NULL,'2019-09-18 05:12:12','2019-09-18 05:12:12',NULL),(15,69,NULL,2,3,NULL,NULL,'2019-09-18 05:13:59','2019-09-18 05:15:52','2019-09-18 05:15:52'),(16,69,NULL,3,3,NULL,NULL,'2019-09-18 05:13:59','2019-09-18 05:15:52','2019-09-18 05:15:52'),(17,69,NULL,4,3,NULL,NULL,'2019-09-18 05:14:00','2019-09-18 05:15:52','2019-09-18 05:15:52'),(18,69,NULL,5,3,NULL,NULL,'2019-09-18 05:14:00','2019-09-18 05:15:52','2019-09-18 05:15:52'),(19,69,NULL,14,3,NULL,NULL,'2019-09-18 05:14:00','2019-09-18 05:15:52','2019-09-18 05:15:52'),(20,69,NULL,22,3,NULL,NULL,'2019-09-18 05:14:00','2019-09-18 05:15:52','2019-09-18 05:15:52'),(21,69,NULL,23,3,NULL,NULL,'2019-09-18 05:14:00','2019-09-18 05:15:53','2019-09-18 05:15:53'),(22,75,NULL,24,3,NULL,NULL,'2019-09-23 07:31:38','2019-09-27 06:17:20','2019-09-27 06:17:20'),(23,75,NULL,25,3,NULL,NULL,'2019-09-23 07:31:39','2019-09-27 06:17:20','2019-09-27 06:17:20'),(24,75,NULL,NULL,3,'eeee',1,'2019-09-27 06:08:37','2019-09-27 06:11:48',NULL),(25,74,NULL,23,3,NULL,NULL,'2020-01-06 12:04:51','2020-01-06 18:37:31','2020-01-06 18:37:31'),(26,74,NULL,NULL,3,'ggg',1,'2020-01-06 12:44:15','2020-01-06 18:34:55','2020-01-06 18:34:55');
/*!40000 ALTER TABLE `object_device_reglament_limitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_devices`
--

DROP TABLE IF EXISTS `object_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL,
  `device_id` bigint(20) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `setup_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tbl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `bti_files_id` bigint(20) unsigned DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `is_good` tinyint(1) DEFAULT '1',
  `setup_year` year(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_devices_created_user_id_foreign` (`created_user_id`),
  KEY `object_devices_object_id_foreign` (`object_id`),
  CONSTRAINT `object_devices_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `object_devices_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_devices`
--

LOCK TABLES `object_devices` WRITE;
/*!40000 ALTER TABLE `object_devices` DISABLE KEYS */;
INSERT INTO `object_devices` VALUES (1,6,9,NULL,3,'2019-05-27 17:05:27','2019-09-03 10:03:25','','App\\device_aps','2019-09-03 10:03:25',1,234.9871043,-184.1250000,0,NULL),(13,6,9,NULL,3,'2019-06-19 08:31:43','2019-09-03 10:02:50','','App\\device_aps','2019-09-03 10:02:50',3,41.3594979,-98.8750000,0,NULL),(14,6,10,NULL,3,'2019-06-20 06:24:46','2019-06-20 06:28:16','','App\\device_aps','2019-06-20 06:28:16',0,0.0000000,0.0000000,1,NULL),(15,6,10,NULL,3,'2019-06-20 06:28:19','2019-09-04 13:33:21','','App\\device_aps','2019-09-04 13:33:21',1,59.8525665,-119.0000000,1,NULL),(16,6,1,NULL,3,'2019-06-28 06:49:25','2019-09-04 13:33:50','','App\\device_antenna','2019-09-04 13:33:50',1,127.9245888,-182.8750000,1,NULL),(17,6,3,NULL,3,'2019-06-28 07:08:08','2019-08-07 10:40:24','','App\\device_rspi',NULL,1,32.8690844,-183.8750000,1,NULL),(18,6,1,NULL,3,'2019-06-28 07:08:14','2019-08-07 10:40:33','','App\\device_alert',NULL,1,97.9070611,-229.0000000,1,NULL),(19,6,1,NULL,3,'2019-06-28 07:08:21','2019-08-07 10:40:04','','App\\device_system_voice_alert',NULL,1,37.3717136,-296.2500000,1,NULL),(20,6,3,NULL,3,'2019-07-01 11:01:33','2019-08-07 10:40:37','','App\\device_alert',NULL,1,182.4564308,-214.5000000,1,NULL),(21,6,2,NULL,3,'2019-07-01 11:01:40','2019-08-07 10:40:43','','App\\device_alert',NULL,1,99.4079375,-281.0000000,1,NULL),(22,4,9,NULL,3,'2019-08-15 05:20:47','2019-08-15 05:20:47','','App\\device_aps',NULL,NULL,NULL,NULL,1,NULL),(23,4,1,NULL,3,'2019-08-15 05:26:20','2019-08-15 06:02:09','','App\\device_antenna',NULL,NULL,NULL,NULL,0,NULL),(24,1,9,NULL,3,'2019-08-18 10:09:16','2019-09-04 13:16:55','','App\\device_aps','2019-09-04 13:16:55',NULL,NULL,NULL,1,NULL),(28,6,1,NULL,3,'2019-09-03 09:58:27','2019-09-03 10:01:56','','App\\device_antenna','2019-09-03 10:01:56',NULL,NULL,NULL,1,NULL),(29,6,9,NULL,3,'2019-09-03 10:05:09','2019-09-03 10:16:12','','App\\device_aps','2019-09-03 10:16:12',NULL,NULL,NULL,1,NULL),(30,6,9,NULL,3,'2019-09-03 10:16:21','2019-09-03 11:48:39','','App\\device_aps','2019-09-03 11:48:39',NULL,NULL,NULL,1,NULL),(31,6,9,NULL,3,'2019-09-03 10:49:10','2019-09-03 11:49:48','','App\\device_aps','2019-09-03 11:49:48',NULL,NULL,NULL,1,NULL),(32,6,9,NULL,3,'2019-09-03 11:04:35','2019-09-03 11:49:48','','App\\device_aps','2019-09-03 11:49:48',NULL,NULL,NULL,1,NULL),(33,6,9,NULL,3,'2019-09-03 11:37:32','2019-09-03 11:49:48','','App\\device_aps','2019-09-03 11:49:48',NULL,NULL,NULL,1,NULL),(34,6,9,NULL,3,'2019-09-03 11:41:49','2019-09-03 11:49:51','','App\\device_aps','2019-09-03 11:49:51',NULL,NULL,NULL,1,NULL),(35,6,9,NULL,3,'2019-09-03 11:44:21','2019-09-03 11:49:52','','App\\device_aps','2019-09-03 11:49:52',NULL,NULL,NULL,1,NULL),(36,6,9,NULL,3,'2019-09-03 11:48:06','2019-09-03 11:49:53','','App\\device_aps','2019-09-03 11:49:53',NULL,NULL,NULL,1,NULL),(37,6,9,NULL,3,'2019-09-03 11:50:12','2019-09-04 12:08:10','','App\\device_aps','2019-09-04 12:08:10',NULL,NULL,NULL,1,NULL),(38,6,9,NULL,3,'2019-09-04 11:14:18','2019-09-04 12:35:22','','App\\device_aps','2019-09-04 12:35:22',NULL,NULL,NULL,1,NULL),(39,6,9,NULL,3,'2019-09-04 11:58:53','2019-09-04 12:35:14','','App\\device_aps','2019-09-04 12:35:14',NULL,NULL,NULL,1,NULL),(40,6,9,NULL,3,'2019-09-04 12:01:03','2019-09-04 12:34:10','','App\\device_aps','2019-09-04 12:34:10',NULL,NULL,NULL,1,NULL),(41,6,9,NULL,3,'2019-09-04 12:05:28','2019-09-04 12:35:08','','App\\device_aps','2019-09-04 12:35:08',NULL,NULL,NULL,1,NULL),(42,6,9,NULL,3,'2019-09-04 12:06:24','2019-09-04 12:30:52','','App\\device_aps','2019-09-04 12:30:52',NULL,NULL,NULL,1,NULL),(43,6,9,NULL,3,'2019-09-04 12:06:56','2019-09-04 12:28:14','','App\\device_aps','2019-09-04 12:28:14',NULL,NULL,NULL,1,NULL),(44,6,9,NULL,3,'2019-09-04 12:07:42','2019-09-04 12:24:48','','App\\device_aps','2019-09-04 12:24:48',NULL,NULL,NULL,1,NULL),(45,6,9,NULL,3,'2019-09-04 12:45:18','2019-09-13 06:20:08','','App\\device_aps',NULL,1,237.2994145,-302.6666641,1,NULL),(46,6,9,NULL,3,'2019-09-04 13:05:14','2019-09-04 13:10:58','','App\\device_aps','2019-09-04 13:10:58',NULL,NULL,NULL,1,NULL),(47,1,9,NULL,3,'2019-09-04 13:17:02','2019-09-04 13:34:03','','App\\device_aps','2019-09-04 13:34:03',NULL,NULL,NULL,1,NULL),(48,1,9,NULL,3,'2019-09-04 13:17:37','2019-09-04 13:21:43','','App\\device_aps','2019-09-04 13:21:43',NULL,NULL,NULL,1,NULL),(49,1,9,NULL,3,'2019-09-04 13:33:10','2019-09-04 13:34:06','','App\\device_aps','2019-09-04 13:34:06',NULL,NULL,NULL,1,NULL),(50,1,9,NULL,3,'2019-09-04 13:33:26','2019-09-04 13:34:09','','App\\device_aps','2019-09-04 13:34:09',NULL,NULL,NULL,1,NULL),(51,1,9,NULL,3,'2019-09-04 13:33:38','2019-09-04 13:34:11','','App\\device_aps','2019-09-04 13:34:11',NULL,NULL,NULL,1,NULL),(52,1,9,NULL,3,'2019-09-04 13:34:18','2019-09-04 13:40:20','','App\\device_aps','2019-09-04 13:40:20',NULL,NULL,NULL,1,NULL),(53,1,9,NULL,3,'2019-09-04 13:36:27','2019-09-04 13:40:17','','App\\device_aps','2019-09-04 13:40:17',NULL,NULL,NULL,1,NULL),(54,1,9,NULL,3,'2019-09-04 13:39:31','2019-09-04 13:40:14','','App\\device_aps','2019-09-04 13:40:14',NULL,NULL,NULL,1,NULL),(55,1,9,NULL,3,'2019-09-04 13:39:57','2019-09-04 13:40:11','','App\\device_aps','2019-09-04 13:40:11',NULL,NULL,NULL,1,NULL),(56,1,9,NULL,3,'2019-09-04 13:40:24','2019-09-04 13:40:50','','App\\device_aps','2019-09-04 13:40:50',NULL,NULL,NULL,1,NULL),(57,1,9,NULL,3,'2019-09-04 13:40:27','2019-09-23 07:04:53','','App\\device_aps','2019-09-23 07:04:53',NULL,NULL,NULL,1,NULL),(58,1,9,NULL,3,'2019-09-04 13:40:46','2019-09-05 05:35:01','','App\\device_aps','2019-09-05 05:35:01',NULL,NULL,NULL,1,NULL),(59,1,9,NULL,3,'2019-09-04 13:40:53','2019-09-05 05:34:55','','App\\device_aps','2019-09-05 05:34:55',NULL,NULL,NULL,1,NULL),(60,1,9,NULL,3,'2019-09-04 13:51:56','2019-09-05 05:34:58','','App\\device_aps','2019-09-05 05:34:58',NULL,NULL,NULL,1,NULL),(61,6,9,NULL,3,'2019-09-04 15:29:24','2019-09-05 05:24:59','','App\\device_aps','2019-09-05 05:24:59',NULL,NULL,NULL,1,NULL),(62,6,9,NULL,3,'2019-09-04 15:39:26','2019-09-05 05:24:57','','App\\device_aps','2019-09-05 05:24:57',NULL,NULL,NULL,1,NULL),(63,6,9,NULL,3,'2019-09-04 15:45:25','2019-09-05 05:24:55','','App\\device_aps','2019-09-05 05:24:55',NULL,NULL,NULL,1,NULL),(64,6,9,NULL,3,'2019-09-05 05:25:02','2019-09-13 06:21:32','','App\\device_aps',NULL,1,195.7828469,-302.2333298,1,NULL),(65,1,10,NULL,3,'2019-09-05 05:31:53','2019-09-05 05:34:53','','App\\device_aps','2019-09-05 05:34:53',NULL,NULL,NULL,1,NULL),(66,1,10,NULL,3,'2019-09-05 05:35:04','2019-09-23 07:04:57','','App\\device_aps','2019-09-23 07:04:57',NULL,NULL,NULL,1,NULL),(67,1,10,NULL,3,'2019-09-05 05:39:02','2019-09-05 05:39:17','','App\\device_aps','2019-09-05 05:39:17',NULL,NULL,NULL,1,NULL),(68,1,1,NULL,3,'2019-09-05 05:40:30','2019-09-23 07:05:00','','App\\device_antenna','2019-09-23 07:05:00',NULL,NULL,NULL,1,NULL),(69,6,1,NULL,3,'2019-09-05 05:48:35','2019-09-18 05:32:18','','App\\device_antenna',NULL,1,72.7337429,-181.6666641,0,NULL),(70,1,3,NULL,3,'2019-09-05 05:58:06','2019-09-23 07:05:04','','App\\device_rspi','2019-09-23 07:05:04',NULL,NULL,NULL,1,NULL),(71,24,2,NULL,3,'2019-09-12 18:27:33','2019-09-12 18:27:33','','App\\device_system_voice_alert',NULL,NULL,NULL,NULL,1,NULL),(73,6,2,19,3,'2019-09-23 06:45:54','2019-09-23 06:45:54','','App\\device_alert',NULL,NULL,NULL,NULL,1,NULL),(74,1,1,NULL,3,'2019-09-23 07:05:12','2020-01-06 18:37:32','','App\\device_system_voice_alert',NULL,NULL,NULL,NULL,1,2012),(75,1,2,74,3,'2019-09-23 07:05:20','2019-09-27 06:08:38','','App\\device_alert',NULL,NULL,NULL,NULL,0,NULL),(76,1,1,NULL,3,'2019-09-23 07:25:00','2020-01-07 15:52:07','','App\\device_alert',NULL,NULL,NULL,NULL,1,2006),(77,1,1,NULL,3,'2019-09-27 07:16:45','2019-09-27 07:22:14','','App\\device_antenna','2019-09-27 07:22:14',NULL,NULL,NULL,1,NULL),(78,1,9,NULL,3,'2019-10-16 07:13:11','2019-10-17 08:22:28','','App\\device_aps','2019-10-17 08:22:28',NULL,NULL,NULL,1,NULL),(79,1,2,74,3,'2019-10-16 08:04:33','2019-10-16 08:04:33','','App\\device_alert',NULL,NULL,NULL,NULL,1,NULL),(80,1,3,NULL,3,'2019-10-16 08:05:09','2019-10-17 08:34:36','','App\\device_alert','2019-10-17 08:34:36',NULL,NULL,NULL,1,NULL),(81,1,3,NULL,3,'2019-10-16 08:11:16','2019-10-17 08:34:31','','App\\device_antenna','2019-10-17 08:34:31',NULL,NULL,NULL,1,NULL),(82,1,9,NULL,5,'2019-10-17 08:22:39','2019-10-17 08:23:54','','App\\device_aps','2019-10-17 08:23:54',NULL,NULL,NULL,1,NULL),(83,1,9,NULL,5,'2019-10-17 08:27:35','2019-10-17 08:55:36','','App\\device_aps','2019-10-17 08:55:36',NULL,NULL,NULL,1,NULL),(84,1,9,NULL,5,'2019-10-17 08:57:55','2019-10-17 08:59:09','','App\\device_aps','2019-10-17 08:59:09',NULL,NULL,NULL,1,NULL),(85,1,9,NULL,5,'2019-10-17 09:04:20','2019-10-17 09:32:21','','App\\device_aps','2019-10-17 09:32:21',NULL,NULL,NULL,1,NULL),(86,1,1,74,5,'2019-10-17 10:02:55','2019-10-17 10:02:55','','App\\device_alert',NULL,NULL,NULL,NULL,1,NULL),(87,1,5,NULL,3,'2019-10-20 14:53:01','2019-10-20 14:53:01','','App\\device_rspi',NULL,NULL,NULL,NULL,1,NULL),(88,1,1,74,3,'2019-10-20 17:01:51','2019-10-20 17:01:51','','App\\device_alert',NULL,NULL,NULL,NULL,1,NULL),(89,1,1,87,3,'2019-10-20 18:03:30','2019-10-20 18:03:30','','App\\device_antenna',NULL,NULL,NULL,NULL,1,NULL),(90,1,1,87,3,'2019-10-20 18:07:52','2019-10-20 18:07:52','','App\\device_antenna',NULL,NULL,NULL,NULL,1,NULL),(91,1,3,87,3,'2019-10-20 18:09:43','2019-10-20 18:09:43','','App\\device_antenna',NULL,NULL,NULL,NULL,1,NULL),(92,1,9,NULL,3,'2019-10-29 04:37:36','2019-10-29 04:37:36','','App\\device_aps',NULL,NULL,NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `object_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_repair_queue`
--

DROP TABLE IF EXISTS `object_repair_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_repair_queue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL,
  `device_id` bigint(20) unsigned NOT NULL,
  `type` set('sensor','wire','device') COLLATE utf8mb4_unicode_ci NOT NULL,
  `technik_comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `finder_id` bigint(20) unsigned NOT NULL,
  `repairer_id` bigint(20) unsigned DEFAULT NULL,
  `limitation_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `done_at` timestamp NULL DEFAULT NULL,
  `additional_limitation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_limitation_critical` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_repair_queue_finder_id_foreign` (`finder_id`),
  KEY `object_repair_queue_repairer_id_foreign` (`repairer_id`),
  KEY `object_repair_queue_object_id_foreign` (`object_id`),
  KEY `object_repair_queue_device_id_foreign` (`device_id`),
  CONSTRAINT `object_repair_queue_finder_id_foreign` FOREIGN KEY (`finder_id`) REFERENCES `users` (`id`),
  CONSTRAINT `object_repair_queue_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  CONSTRAINT `object_repair_queue_repairer_id_foreign` FOREIGN KEY (`repairer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_repair_queue`
--

LOCK TABLES `object_repair_queue` WRITE;
/*!40000 ALTER TABLE `object_repair_queue` DISABLE KEYS */;
INSERT INTO `object_repair_queue` VALUES (38,6,13,'device',NULL,3,3,NULL,'2019-09-02 10:19:22','2019-09-02 10:19:52',NULL,'2019-09-02 10:19:52','44567',NULL),(39,6,13,'device',NULL,3,NULL,NULL,'2019-09-02 10:19:52','2019-09-02 10:19:52',NULL,NULL,'4456',NULL),(40,6,13,'device',NULL,3,3,11,'2019-09-02 10:20:06','2019-09-02 10:42:38',NULL,'2019-09-02 10:42:38',NULL,NULL),(42,6,13,'device',NULL,3,3,12,'2019-09-02 10:39:55','2019-09-02 10:49:38',NULL,'2019-09-02 10:49:38',NULL,NULL),(43,6,13,'device',NULL,3,3,11,'2019-09-02 10:42:26','2019-09-02 10:48:52',NULL,'2019-09-02 10:48:52',NULL,NULL),(44,6,13,'device',NULL,3,3,11,'2019-09-02 10:49:10','2019-09-02 10:49:20',NULL,'2019-09-02 10:49:20',NULL,NULL),(45,1,16,'sensor',NULL,3,NULL,14,'2019-09-06 07:46:33','2019-09-06 07:46:33',NULL,NULL,NULL,NULL),(46,6,69,'device',NULL,3,NULL,1,'2019-09-18 05:12:12','2019-09-18 05:12:12',NULL,NULL,NULL,NULL),(47,6,69,'device',NULL,3,3,2,'2019-09-18 05:13:59','2019-09-18 05:13:59',NULL,'2019-09-18 05:13:59',NULL,NULL),(48,6,69,'device',NULL,3,3,3,'2019-09-18 05:13:59','2019-09-18 05:14:00',NULL,'2019-09-18 05:14:00',NULL,NULL),(49,6,69,'device',NULL,3,3,4,'2019-09-18 05:14:00','2019-09-18 05:14:00',NULL,'2019-09-18 05:14:00',NULL,NULL),(50,6,69,'device',NULL,3,3,5,'2019-09-18 05:14:00','2019-09-18 05:14:00',NULL,'2019-09-18 05:14:00',NULL,NULL),(51,6,69,'device',NULL,3,3,14,'2019-09-18 05:14:00','2019-09-18 05:14:00',NULL,'2019-09-18 05:14:00',NULL,NULL),(52,6,69,'device',NULL,3,3,22,'2019-09-18 05:14:00','2019-09-18 05:14:00',NULL,'2019-09-18 05:14:00',NULL,NULL),(53,6,69,'device',NULL,3,3,23,'2019-09-18 05:14:00','2019-09-18 05:14:00',NULL,'2019-09-18 05:14:00',NULL,NULL),(54,1,75,'device',NULL,3,3,24,'2019-09-23 07:31:38','2019-09-23 07:31:39',NULL,'2019-09-23 07:31:39',NULL,NULL),(55,1,75,'device',NULL,3,3,25,'2019-09-23 07:31:39','2019-09-23 07:31:39',NULL,'2019-09-23 07:31:39',NULL,NULL),(56,1,75,'device',NULL,3,NULL,NULL,'2019-09-27 06:08:37','2019-09-27 06:08:37',NULL,NULL,'eeee',NULL),(57,4,11,'sensor',NULL,5,NULL,14,'2019-10-17 14:34:39','2019-10-17 14:34:39',NULL,NULL,NULL,NULL),(58,1,74,'device',NULL,3,3,23,'2020-01-06 12:04:52','2020-01-06 12:04:53',NULL,'2020-01-06 12:04:53',NULL,NULL),(59,1,74,'device',NULL,3,3,NULL,'2020-01-06 12:44:16','2020-01-06 18:34:55',NULL,'2020-01-06 18:34:55','ggg',NULL),(60,1,87,'sensor',NULL,3,NULL,26,'2020-01-07 16:00:39','2020-01-07 16:00:39',NULL,NULL,NULL,NULL),(61,1,88,'sensor',NULL,3,NULL,26,'2020-01-07 16:06:06','2020-01-07 16:06:06',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `object_repair_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `raion_id` bigint(20) unsigned NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` decimal(10,7) NOT NULL,
  `lat` decimal(10,7) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `director_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `director_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project_isset` tinyint(1) DEFAULT '0',
  `project_cipher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_year` year(4) DEFAULT NULL,
  `soue_type` set('1','2','3','4','5') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `contract_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contract_created_at` date DEFAULT NULL,
  `contract_ends_at` date DEFAULT NULL,
  `contract_path` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `objects_raion_id_foreign` (`raion_id`),
  KEY `objects_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `objects_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `objects_raion_id_foreign` FOREIGN KEY (`raion_id`) REFERENCES `raions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,'Детский сад',42,'Сталеваров 16',61.4012117,55.2661825,1,'Петров','654321','Иванов','123456',NULL,'2019-05-19 17:18:00','2019-09-05 06:14:06',0,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL),(4,'кккк',42,'Пушкина 68',61.4096140,55.1567490,1,'ЕЕЕ','645','РРР','123',NULL,'2019-05-19 17:54:28','2019-05-19 17:54:28',0,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL),(5,'Иванов Иван',1,'erwer',58.2225649,54.6835573,1,'qwerea','2342','werw','23423',3,'2019-05-22 08:49:40','2019-08-15 07:57:01',1,NULL,1987,'1',NULL,NULL,NULL,NULL,NULL),(6,'Школа №70',42,'60 лет Октября, 46',61.3828879,55.2625390,1,'аврвар','456456','првар','45645',3,'2019-05-26 11:23:19','2019-09-07 17:25:59',1,'ш-21б-56',2010,'3',NULL,NULL,NULL,NULL,NULL),(7,'Детский сад \"Березка\"',1,'с. Агаповка , ул Советская, 45',59.1301774,53.2955676,1,'Петров Петр','123456','Иванов Иван','123456',3,'2019-07-26 10:14:32','2019-07-26 10:14:32',1,'Ш-125-1987',1984,'1',NULL,NULL,NULL,NULL,NULL),(13,'test',2,'г Челябинск, ул Невская',61.2618009,55.1549263,1,'qwerea','1231','wefa','123123',3,'2019-09-12 17:57:31','2019-09-12 17:57:31',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(14,'test',2,'г Челябинск, ул Невская',61.2618009,55.1549263,1,'qwerea','1231','wefa','123123',3,'2019-09-12 17:58:40','2019-09-12 17:58:40',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(15,'test',2,'г Челябинск, ул Невская',61.2618009,55.1549263,1,'qwerea','1231','wefa','123123',3,'2019-09-12 17:59:00','2019-09-12 17:59:00',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(16,'test',2,'г Челябинск, ул Невская',61.2618009,55.1549263,1,'qwerea','1231','wefa','123123',3,'2019-09-12 17:59:24','2019-09-12 17:59:24',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(17,'test',2,'г Челябинск, ул Невская',61.2618009,55.1549263,1,'qwerea','1231','wefa','123123',3,'2019-09-12 17:59:37','2019-09-12 17:59:37',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(18,'test',2,'г Челябинск, ул Невская',61.2618009,55.1549263,1,'qwerea','1231','wefa','123123',3,'2019-09-12 18:00:11','2019-09-12 18:00:11',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(19,'test',42,'г Челябинск, ул Невская',61.2618009,55.1549263,1,'qwerea','1231','werw','123123',3,'2019-09-12 18:02:11','2019-09-12 18:02:11',1,NULL,0000,'3',NULL,NULL,NULL,NULL,NULL),(20,'Иванов Иван',2,'Челябинская обл, село Аргаяш',60.8761286,55.4885837,1,'sfasdf','1231','Иванов Иван','123123',3,'2019-09-12 18:05:00','2019-09-12 18:05:00',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(21,'test',42,'г Челябинск, наб Николая Патоличева',61.4008078,55.1602624,1,'qwerea','1231','werw','123123',3,'2019-09-12 18:13:22','2019-09-12 18:13:22',1,NULL,0000,'1,2',NULL,NULL,NULL,NULL,NULL),(22,'test',2,'г Челябинск, ул Некрасовская',61.3432421,55.1115275,1,'sfasdf','123456','Иванов Иван','123123',3,'2019-09-12 18:15:01','2019-09-13 03:36:32',1,'Ш-125-1987',1987,'2',NULL,NULL,NULL,NULL,NULL),(23,'test',2,'г Челябинск, ул Неглинная',61.3632015,55.1879987,1,'sfasdf','123456','wefa','123123',3,'2019-09-12 18:17:00','2019-09-13 03:36:06',1,NULL,0000,'3','2019-09-13 03:36:06',NULL,NULL,NULL,NULL),(24,'test',2,'Челябинская обл, село Аргаяш',60.8761286,55.4885837,1,'qwerea','1231','wefa','123123',3,'2019-09-12 18:21:08','2019-09-13 03:35:21',1,NULL,0000,'1,2','2019-09-13 03:35:21',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_mediafiles`
--

DROP TABLE IF EXISTS `objects_mediafiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects_mediafiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `objects_mediafiles_object_id_foreign` (`object_id`),
  CONSTRAINT `objects_mediafiles_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_mediafiles`
--

LOCK TABLES `objects_mediafiles` WRITE;
/*!40000 ALTER TABLE `objects_mediafiles` DISABLE KEYS */;
INSERT INTO `objects_mediafiles` VALUES (2,6,'084-69-05-19-0012975.pdf','084-69-05-19-0012975.pdf','2019-06-13 05:32:29','2019-06-13 05:32:29',NULL),(3,6,'084-69-05-19-0012975.pdf','Русский текст','2019-06-13 05:33:20','2019-06-13 05:33:20',NULL),(4,6,'084-69-05-19-0012975.pdf','084-69-05-19-0012975.pdf','2019-06-13 05:40:34','2019-06-13 05:40:34',NULL),(5,6,'Таблиа общих сведений по АПС.xlsx','Ntcn','2019-06-19 07:27:08','2019-06-19 07:27:08',NULL),(6,6,'Таблиа общих сведений по АПС.xlsx','123','2019-06-19 07:29:49','2019-06-19 07:29:49',NULL),(7,6,'plan-bti.jpg','План 1го этажа','2019-07-30 08:45:40','2019-07-30 10:47:50','2019-07-30 10:47:50'),(8,6,'plan-bti-2.jpg','План 2го этажа','2019-07-30 10:04:18','2019-07-30 10:47:47','2019-07-30 10:47:47'),(9,6,'plan-bti.jpg','floor 1','2019-07-30 10:51:52','2019-07-30 10:51:57','2019-07-30 10:51:57'),(10,1,'Акт исправности 08-01-2020.docx','Акт исправности 08-01-2020.docx','2020-01-08 15:43:22','2020-01-08 15:50:27','2020-01-08 15:50:27'),(11,1,'Акт исправности 08-01-2020.docx','Акт исправности 08-01-2020.docx','2020-01-08 15:49:33','2020-01-08 15:49:33',NULL),(12,1,'Акт исправности 08-01-2020.docx','Акт исправности 08-01-2020.docx','2020-01-08 15:49:58','2020-01-08 15:49:58',NULL);
/*!40000 ALTER TABLE `objects_mediafiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raions`
--

DROP TABLE IF EXISTS `raions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` decimal(10,7) NOT NULL,
  `lat` decimal(10,7) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raions`
--

LOCK TABLES `raions` WRITE;
/*!40000 ALTER TABLE `raions` DISABLE KEYS */;
INSERT INTO `raions` VALUES (1,'Агаповский муниципальный район',59.2974060,53.2702650,1,'2019-05-18 14:51:15','2019-07-26 10:10:10',NULL),(2,'Аргаяшский муниципальный район',60.7585870,55.4137190,1,'2019-05-18 14:51:15','2019-07-26 10:10:10',NULL),(3,'Ашинский муниципальный район',57.5703410,55.0506640,0,'2019-05-18 14:51:16','2019-09-13 04:24:46',NULL),(4,'Брединский муниципальный район',60.3067080,52.4326830,0,'2019-05-18 14:51:16','2019-08-23 06:32:55','2019-08-23 06:32:55'),(5,'Варненский муниципальный район',61.3553920,53.1380460,0,'2019-05-18 14:51:17','2019-08-23 06:33:04','2019-08-23 06:33:04'),(6,'Верхнеуральский муниципальный район',59.1980970,53.8143360,0,'2019-05-18 14:51:17','2019-08-23 06:33:04','2019-08-23 06:33:04'),(7,'Еманжелинский муниципальный район',61.3269150,54.7427410,0,'2019-05-18 14:51:18','2019-08-23 06:33:05','2019-08-23 06:33:05'),(8,'Еткульский муниципальный район',61.5793420,54.7634150,0,'2019-05-18 14:51:18','2019-08-23 06:33:06','2019-08-23 06:33:06'),(9,'Карталинский муниципальный район',60.3992790,53.0443540,0,'2019-05-18 14:51:18','2019-08-23 06:33:07','2019-08-23 06:33:07'),(10,'Каслинский муниципальный район',61.4167830,56.1570470,0,'2019-05-18 14:51:18','2019-08-23 06:33:08','2019-08-23 06:33:08'),(11,'Катав-Ивановский муниципальный район',58.2114860,54.6961840,0,'2019-05-18 14:51:19','2019-08-23 06:33:09','2019-08-23 06:33:09'),(12,'Кизильский муниципальный район',59.2993640,52.7499710,0,'2019-05-18 14:51:19','2019-08-23 06:33:09','2019-08-23 06:33:09'),(13,'Коркинский муниципальный район',61.3768800,54.9151870,0,'2019-05-18 14:51:20','2019-08-23 06:33:11','2019-08-23 06:33:11'),(14,'Красноармейский муниципальный район',62.0510920,55.4430210,0,'2019-05-18 14:51:20','2019-08-23 06:33:12','2019-08-23 06:33:12'),(15,'Кунашакский муниципальный район',61.6226950,55.8362820,0,'2019-05-18 14:51:21','2019-08-23 06:33:13','2019-08-23 06:33:13'),(16,'Кусинский муниципальный район',59.5826030,55.4120120,0,'2019-05-18 14:51:21','2019-08-23 06:33:14','2019-08-23 06:33:14'),(17,'Нагайбакский муниципальный район',59.8283190,53.5595940,0,'2019-05-18 14:51:21','2019-08-23 06:33:15','2019-08-23 06:33:15'),(18,'Нязепетровский муниципальный район ',59.5755150,55.9682770,0,'2019-05-18 14:51:22','2019-08-23 06:33:15','2019-08-23 06:33:15'),(19,'Октябрьский муниципальный район',62.7072580,54.3837140,0,'2019-05-18 14:51:22','2019-08-23 06:33:17','2019-08-23 06:33:17'),(20,'Пластовский муниципальный район',60.6766610,54.3747470,0,'2019-05-18 14:51:22','2019-08-23 06:33:17','2019-08-23 06:33:17'),(21,'Саткинский муниципальный район',58.9971080,54.9784520,0,'2019-05-18 14:51:23','2019-08-23 06:33:20','2019-08-23 06:33:20'),(22,'Сосновский муниципальный район',61.1986450,55.2309900,0,'2019-05-18 14:51:23','2019-08-23 06:33:19','2019-08-23 06:33:19'),(23,'Троицкий муниципальный район',61.2930670,54.1754920,0,'2019-05-18 14:51:24','2019-08-23 06:33:20','2019-08-23 06:33:20'),(24,'Увельский муниципальный район',61.4957540,54.4851620,0,'2019-05-18 14:51:24','2019-08-23 06:33:21','2019-08-23 06:33:21'),(25,'Уйский муниципальный район',60.0910580,54.3855650,0,'2019-05-18 14:51:24','2019-08-23 06:33:22','2019-08-23 06:33:22'),(26,'Чебаркульский муниципальный район',60.5207130,54.8279980,0,'2019-05-18 14:51:25','2019-08-23 06:34:14','2019-08-23 06:34:14'),(27,'Чесменский муниципальный район',60.5706960,53.7258610,0,'2019-05-18 14:51:25','2019-08-23 06:34:15','2019-08-23 06:34:15'),(28,'Верхнеуфалейский городской округ',60.2319500,56.0487210,0,'2019-05-18 14:58:20','2019-08-23 06:34:16','2019-08-23 06:34:16'),(29,'Златоустовский городской округ',59.6724250,55.1731080,0,'2019-05-18 14:58:20','2019-08-23 06:34:17','2019-08-23 06:34:17'),(30,'Карабашский городской округ',60.2030420,55.4907890,0,'2019-05-18 14:58:21','2019-08-23 06:34:21','2019-08-23 06:34:21'),(31,'Копейский городской округ',61.6179700,55.1167320,0,'2019-05-18 14:58:21','2019-08-23 06:34:22','2019-08-23 06:34:22'),(32,'Кыштымский городской округ',60.5389490,55.7078770,0,'2019-05-18 14:58:22','2019-08-23 06:34:23','2019-08-23 06:34:23'),(33,'Локомотивный городской округ',60.6139230,53.0452210,0,'2019-05-18 14:58:22','2019-08-23 06:34:24','2019-08-23 06:34:24'),(34,'Магнитогорский городской округ',58.9802820,53.4071580,0,'2019-05-18 14:58:23','2019-08-23 06:34:25','2019-08-23 06:34:25'),(35,'Миасский городской округ',60.1080810,55.0464140,0,'2019-05-18 14:58:23','2019-08-23 06:34:30','2019-08-23 06:34:30'),(36,'Озерский городской округ',60.7075990,55.7631840,0,'2019-05-18 14:58:23','2019-08-23 06:34:31','2019-08-23 06:34:31'),(37,'Снежинский городской округ',60.7325360,56.0852090,0,'2019-05-18 14:58:24','2019-08-23 06:34:32','2019-08-23 06:34:32'),(38,'Трехгорный городской округ',58.4464230,54.8178420,0,'2019-05-18 14:58:24','2019-08-23 06:34:33','2019-08-23 06:34:33'),(39,'Троицкий городской округ',61.5597590,54.0832170,0,'2019-05-18 14:58:25','2019-08-23 06:34:34','2019-08-23 06:34:34'),(40,'Усть-Катавский городской округ',58.1747000,54.9302890,0,'2019-05-18 14:58:25','2019-08-23 06:34:37','2019-08-23 06:34:37'),(41,'Чебаркульский городской округ',60.3701200,54.9777850,0,'2019-05-18 14:58:25','2019-08-23 06:34:38','2019-08-23 06:34:38'),(42,'Челябинский городской округ',61.4025540,55.1598970,1,'2019-05-18 14:58:26','2019-05-18 14:58:26',NULL),(43,'Южноуральский городской округ',61.2682290,54.4424550,0,'2019-05-18 14:58:26','2019-08-23 06:34:39','2019-08-23 06:34:39');
/*!40000 ALTER TABLE `raions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reglament_works`
--

DROP TABLE IF EXISTS `reglament_works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reglament_works` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reglament_id` bigint(20) unsigned NOT NULL,
  `device_id` bigint(20) unsigned NOT NULL,
  `tbl_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `done_at` timestamp NULL DEFAULT NULL,
  `planned_reglament_at` date DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reglament_works`
--

LOCK TABLES `reglament_works` WRITE;
/*!40000 ALTER TABLE `reglament_works` DISABLE KEYS */;
INSERT INTO `reglament_works` VALUES (139,79,45,NULL,NULL,NULL,'2019-09-04',3,NULL),(177,79,64,NULL,NULL,NULL,'2019-09-05',3,NULL),(185,70,69,NULL,NULL,NULL,'2019-09-05',3,NULL),(186,71,69,NULL,NULL,NULL,'2019-09-05',3,NULL),(187,72,69,NULL,NULL,NULL,'2019-09-05',3,NULL),(188,75,69,NULL,NULL,NULL,'2019-09-05',3,NULL),(189,76,69,NULL,NULL,NULL,'2019-09-05',3,NULL),(190,77,69,NULL,NULL,NULL,'2019-09-05',3,NULL),(191,78,69,NULL,NULL,NULL,'2019-09-05',3,NULL),(192,80,26,'App/Sensor',NULL,'2019-09-07 17:36:55','2019-09-08',3,'2019-09-07 17:36:55'),(193,80,26,'App/Sensor',NULL,'2019-09-07 17:36:57','2019-09-08',3,'2019-09-07 17:36:57'),(194,80,27,'App/Sensor',NULL,'2019-09-07 17:30:40','2019-09-08',3,'2019-09-07 17:30:40'),(195,80,28,'App/Sensor',NULL,NULL,'2019-09-07',3,NULL),(196,80,29,'App/Sensor',NULL,NULL,'2019-09-07',3,NULL),(197,82,21,NULL,NULL,NULL,'2019-09-23',3,NULL),(198,82,73,NULL,NULL,NULL,'2019-09-23',3,NULL),(199,82,75,NULL,NULL,'2019-09-23 07:31:32','2019-10-23',3,'2019-09-23 07:31:32'),(202,80,30,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(203,81,30,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(204,80,31,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(205,81,31,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(206,80,32,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(207,81,32,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(208,80,33,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(209,81,33,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(210,80,34,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(211,81,34,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(212,80,35,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(213,81,35,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(214,80,36,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(215,81,36,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(216,80,37,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(217,81,37,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(218,80,38,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(219,81,38,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(220,80,39,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(221,81,39,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(222,80,40,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(223,81,40,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(224,80,41,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(225,81,41,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(226,80,42,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(227,81,42,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(228,80,43,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(229,81,43,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(230,80,44,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(231,81,44,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(232,80,45,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(233,81,45,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(234,80,46,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(235,81,46,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(236,80,47,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(237,81,47,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(238,80,48,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(239,81,48,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(240,80,49,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(241,81,49,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(242,80,50,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(243,81,50,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(244,80,51,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(245,81,51,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(246,80,52,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(247,81,52,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(248,80,53,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(249,81,53,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(250,80,54,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(251,81,54,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(252,80,55,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(253,81,55,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(254,80,56,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(255,81,56,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(256,80,57,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(257,81,57,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(258,80,58,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(259,81,58,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(260,80,59,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(261,81,59,'App/Sensor',NULL,NULL,'2019-10-16',3,NULL),(262,82,79,NULL,NULL,NULL,'2019-10-16',3,NULL),(263,70,89,NULL,NULL,NULL,'2019-10-20',3,NULL),(264,71,89,NULL,NULL,NULL,'2019-10-20',3,NULL),(265,72,89,NULL,NULL,NULL,'2019-10-20',3,NULL),(266,75,89,NULL,NULL,NULL,'2019-10-20',3,NULL),(267,76,89,NULL,NULL,NULL,'2019-10-20',3,NULL),(268,77,89,NULL,NULL,NULL,'2019-10-20',3,NULL),(269,78,89,NULL,NULL,NULL,'2019-10-20',3,NULL),(270,70,90,NULL,NULL,NULL,'2019-10-20',3,NULL),(271,71,90,NULL,NULL,NULL,'2019-10-20',3,NULL),(272,72,90,NULL,NULL,NULL,'2019-10-20',3,NULL),(273,75,90,NULL,NULL,NULL,'2019-10-20',3,NULL),(274,76,90,NULL,NULL,NULL,'2019-10-20',3,NULL),(275,77,90,NULL,NULL,NULL,'2019-10-20',3,NULL),(276,78,90,NULL,NULL,NULL,'2019-10-20',3,NULL),(278,79,92,NULL,NULL,NULL,'2019-10-29',3,NULL),(279,83,87,'App/Sensor',NULL,NULL,'2019-11-11',3,NULL),(280,83,88,'App/Sensor',NULL,NULL,'2019-11-11',3,NULL),(281,83,89,'App/Sensor',NULL,NULL,'2020-01-07',3,NULL),(282,83,90,'App/Sensor',NULL,NULL,'2020-01-07',3,NULL),(283,84,17,NULL,NULL,NULL,'2020-01-08',3,NULL);
/*!40000 ALTER TABLE `reglament_works` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensors`
--

DROP TABLE IF EXISTS `sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `is_automate` tinyint(1) NOT NULL DEFAULT '1',
  `power_supply` set('wire','separate wire','stand-alone') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_address` tinyint(1) NOT NULL,
  `standalon_function` set('smoke','fire') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `standalon_smoke_is_radioisotop` tinyint(1) DEFAULT NULL,
  `automate_attribute` set('heat','smoke','fire','gas','combine') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `automate_reaction` set('maximal','differincial','max-diff') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sensors_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `sensors_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
INSERT INTO `sensors` VALUES (1,1,'wire',1,'smoke',NULL,'heat','maximal',3,1,'2019-06-08 10:29:11','2019-11-11 07:42:10','asd','dns adguard','2019-11-11 07:42:10'),(2,0,'separate wire',0,NULL,NULL,NULL,NULL,3,0,'2019-06-08 11:51:43','2019-11-11 07:42:08','dsa',NULL,'2019-11-11 07:42:08'),(3,0,'wire',0,NULL,NULL,NULL,NULL,3,0,'2019-06-08 11:55:02','2019-11-11 07:42:06','qwe',NULL,'2019-11-11 07:42:06'),(4,0,'wire',0,NULL,NULL,'combine','differincial',3,1,'2019-06-11 08:42:01','2019-11-11 07:42:04','qwe',NULL,'2019-11-11 07:42:04'),(5,0,'stand-alone',0,'smoke',0,NULL,NULL,3,1,'2019-06-11 08:44:36','2019-11-11 07:42:02','qwesd',NULL,'2019-11-11 07:42:02'),(6,0,'wire',1,NULL,NULL,NULL,NULL,3,1,'2019-08-27 10:36:07','2019-11-11 07:42:00','Regul',NULL,'2019-11-11 07:42:00'),(7,0,'wire',0,NULL,NULL,NULL,NULL,3,1,'2019-08-29 12:04:53','2019-11-11 07:41:57','111',NULL,'2019-11-11 07:41:57'),(8,1,'wire',1,NULL,NULL,'gas','differincial',3,1,'2019-08-29 12:26:18','2019-09-13 05:28:39','1112',NULL,'2019-09-13 05:28:39'),(9,1,'wire',0,NULL,NULL,'smoke','differincial',3,1,'2019-11-11 07:43:24','2019-11-11 07:43:24','RUBETEK KR-SD02',NULL,NULL);
/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `raion_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_phone_unique` (`phone`),
  UNIQUE KEY `users_api_token_unique` (`api_token`),
  KEY `users_raion_id_foreign` (`raion_id`),
  CONSTRAINT `users_raion_id_foreign` FOREIGN KEY (`raion_id`) REFERENCES `raions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'Иванов Иван','1234567890','$2y$10$UinZZ0DpOt3BKrrt3odbpeK9rsDXcMvfuU6tFO6VBT.Fg5dXDYRX.','i2buhDy4VFeAddHbaN9XtVGINHaBRnjUifqIxJQ4Q8x0UakU9CPDUj0zTTL0',1,1,NULL,'2019-05-19 12:52:18','2019-05-19 12:52:18',42,NULL),(5,'Simonov Sergey','12345','$2y$10$yk8RkxYkUCLj0PFoeheP2OPtNKcSIb0qN77t/TYLphR/2238UOBe.','i2buhDy4VFeAddHbaN9XtVGINHaBRnjUifqIxJQ4Q8x0UakU9CPDUj0zT123',1,0,NULL,'2019-06-12 08:14:24','2019-10-17 07:33:55',1,NULL),(6,'test','1234','$2y$10$jl.Gx16IkO5Dtrg.K0OZBunyvoQqUQzxjvBI4SDZNa1GYk7k.dXpW',NULL,1,0,NULL,'2019-08-23 05:58:42','2019-09-13 04:25:45',2,'2019-09-13 04:25:45'),(7,'Иванов','Иван','$2y$10$wanJ13U6gLkWO9qGKsArQeMWmVD59OULeloLpELY.mPlcXCTUkRkq',NULL,1,0,NULL,'2019-09-13 04:25:33','2019-09-13 04:25:33',42,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vocations`
--

DROP TABLE IF EXISTS `vocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vocations` (
  `vocation_date` date NOT NULL,
  UNIQUE KEY `vocations_vocation_date_unique` (`vocation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vocations`
--

LOCK TABLES `vocations` WRITE;
/*!40000 ALTER TABLE `vocations` DISABLE KEYS */;
INSERT INTO `vocations` VALUES ('2020-01-01'),('2020-01-02'),('2020-01-03'),('2020-01-04'),('2020-01-05'),('2020-01-06'),('2020-01-07'),('2020-01-08'),('2020-01-11'),('2020-01-12'),('2020-01-18'),('2020-01-19'),('2020-01-25'),('2020-01-26'),('2020-02-01'),('2020-02-02'),('2020-02-08'),('2020-02-09'),('2020-02-15'),('2020-02-16'),('2020-02-22'),('2020-02-23'),('2020-02-24'),('2020-02-29'),('2020-03-01'),('2020-03-07'),('2020-03-08'),('2020-03-09'),('2020-03-14'),('2020-03-15'),('2020-03-21'),('2020-03-22'),('2020-03-28'),('2020-03-29'),('2020-04-04'),('2020-04-05'),('2020-04-11'),('2020-04-12'),('2020-04-18'),('2020-04-19'),('2020-04-25'),('2020-04-26'),('2020-05-01'),('2020-05-02'),('2020-05-03'),('2020-05-04'),('2020-05-05'),('2020-05-09'),('2020-05-10'),('2020-05-11'),('2020-05-16'),('2020-05-17'),('2020-05-23'),('2020-05-24'),('2020-05-30'),('2020-05-31'),('2020-06-06'),('2020-06-07'),('2020-06-12'),('2020-06-13'),('2020-06-14'),('2020-06-20'),('2020-06-21'),('2020-06-27'),('2020-06-28'),('2020-07-04'),('2020-07-05'),('2020-07-11'),('2020-07-12'),('2020-07-18'),('2020-07-19'),('2020-07-25'),('2020-07-26'),('2020-08-01'),('2020-08-02'),('2020-08-08'),('2020-08-09'),('2020-08-15'),('2020-08-16'),('2020-08-22'),('2020-08-23'),('2020-08-29'),('2020-08-30'),('2020-09-05'),('2020-09-06'),('2020-09-12'),('2020-09-13'),('2020-09-19'),('2020-09-20'),('2020-09-26'),('2020-09-27'),('2020-10-03'),('2020-10-04'),('2020-10-10'),('2020-10-11'),('2020-10-17'),('2020-10-18'),('2020-10-24'),('2020-10-25'),('2020-10-31'),('2020-11-01'),('2020-11-04'),('2020-11-07'),('2020-11-08'),('2020-11-14'),('2020-11-15'),('2020-11-21'),('2020-11-22'),('2020-11-28'),('2020-11-29'),('2020-12-05'),('2020-12-06'),('2020-12-12'),('2020-12-13'),('2020-12-19'),('2020-12-20'),('2020-12-26'),('2020-12-27'),('2021-01-01'),('2021-01-02'),('2021-01-03'),('2021-01-04'),('2021-01-05'),('2021-01-06'),('2021-01-07'),('2021-01-08'),('2021-01-09'),('2021-01-10'),('2021-01-16'),('2021-01-17'),('2021-01-23'),('2021-01-24'),('2021-01-30'),('2021-01-31'),('2021-02-06'),('2021-02-07'),('2021-02-13'),('2021-02-14'),('2021-02-20'),('2021-02-21'),('2021-02-23'),('2021-02-27'),('2021-02-28'),('2021-03-06'),('2021-03-07'),('2021-03-13'),('2021-03-14'),('2021-03-20'),('2021-03-21'),('2021-03-27'),('2021-03-28'),('2021-04-03'),('2021-04-04'),('2021-04-10'),('2021-04-11'),('2021-04-17'),('2021-04-18'),('2021-04-24'),('2021-04-25'),('2021-05-01'),('2021-05-02'),('2021-05-03'),('2021-05-08'),('2021-05-09'),('2021-05-10'),('2021-05-15'),('2021-05-16'),('2021-05-22'),('2021-05-23'),('2021-05-29'),('2021-05-30'),('2021-06-05'),('2021-06-06'),('2021-06-12'),('2021-06-13'),('2021-06-14'),('2021-06-19'),('2021-06-20'),('2021-06-26'),('2021-06-27'),('2021-07-03'),('2021-07-04'),('2021-07-10'),('2021-07-11'),('2021-07-17'),('2021-07-18'),('2021-07-24'),('2021-07-25'),('2021-07-31'),('2021-08-01'),('2021-08-07'),('2021-08-08'),('2021-08-14'),('2021-08-15'),('2021-08-21'),('2021-08-22'),('2021-08-28'),('2021-08-29'),('2021-09-04'),('2021-09-05'),('2021-09-11'),('2021-09-12'),('2021-09-18'),('2021-09-19'),('2021-09-25'),('2021-09-26'),('2021-10-02'),('2021-10-03'),('2021-10-09'),('2021-10-10'),('2021-10-16'),('2021-10-17'),('2021-10-23'),('2021-10-24'),('2021-10-30'),('2021-10-31'),('2021-11-04'),('2021-11-06'),('2021-11-07'),('2021-11-13'),('2021-11-14'),('2021-11-20'),('2021-11-21'),('2021-11-27'),('2021-11-28'),('2021-12-04'),('2021-12-05'),('2021-12-11'),('2021-12-12'),('2021-12-18'),('2021-12-19'),('2021-12-25'),('2021-12-26'),('2022-01-01'),('2022-01-02'),('2022-01-03'),('2022-01-04'),('2022-01-05'),('2022-01-06'),('2022-01-07'),('2022-01-08'),('2022-01-09'),('2022-01-15'),('2022-01-16'),('2022-01-22'),('2022-01-23'),('2022-01-29'),('2022-01-30'),('2022-02-05'),('2022-02-06'),('2022-02-12'),('2022-02-13'),('2022-02-19'),('2022-02-20'),('2022-02-23'),('2022-02-26'),('2022-02-27'),('2022-03-05'),('2022-03-06'),('2022-03-08'),('2022-03-12'),('2022-03-13'),('2022-03-19'),('2022-03-20'),('2022-03-26'),('2022-03-27'),('2022-04-02'),('2022-04-03'),('2022-04-09'),('2022-04-10'),('2022-04-16'),('2022-04-17'),('2022-04-23'),('2022-04-24'),('2022-04-30'),('2022-05-01'),('2022-05-02'),('2022-05-07'),('2022-05-08'),('2022-05-09'),('2022-05-14'),('2022-05-15'),('2022-05-21'),('2022-05-22'),('2022-05-28'),('2022-05-29'),('2022-06-04'),('2022-06-05'),('2022-06-11'),('2022-06-12'),('2022-06-13'),('2022-06-18'),('2022-06-19'),('2022-06-25'),('2022-06-26'),('2022-07-02'),('2022-07-03'),('2022-07-09'),('2022-07-10'),('2022-07-16'),('2022-07-17'),('2022-07-23'),('2022-07-24'),('2022-07-30'),('2022-07-31'),('2022-08-06'),('2022-08-07'),('2022-08-13'),('2022-08-14'),('2022-08-20'),('2022-08-21'),('2022-08-27'),('2022-08-28'),('2022-09-03'),('2022-09-04'),('2022-09-10'),('2022-09-11'),('2022-09-17'),('2022-09-18'),('2022-09-24'),('2022-09-25'),('2022-10-01'),('2022-10-02'),('2022-10-08'),('2022-10-09'),('2022-10-15'),('2022-10-16'),('2022-10-22'),('2022-10-23'),('2022-10-29'),('2022-10-30'),('2022-11-04'),('2022-11-05'),('2022-11-06'),('2022-11-12'),('2022-11-13'),('2022-11-19'),('2022-11-20'),('2022-11-26'),('2022-11-27'),('2022-12-03'),('2022-12-04'),('2022-12-10'),('2022-12-11'),('2022-12-17'),('2022-12-18'),('2022-12-24'),('2022-12-25'),('2022-12-31'),('2023-01-01'),('2023-01-02'),('2023-01-03'),('2023-01-04'),('2023-01-05'),('2023-01-06'),('2023-01-07'),('2023-01-08'),('2023-01-14'),('2023-01-15'),('2023-01-21'),('2023-01-22'),('2023-01-28'),('2023-01-29'),('2023-02-04'),('2023-02-05'),('2023-02-11'),('2023-02-12'),('2023-02-18'),('2023-02-19'),('2023-02-23'),('2023-02-25'),('2023-02-26'),('2023-03-04'),('2023-03-05'),('2023-03-08'),('2023-03-11'),('2023-03-12'),('2023-03-18'),('2023-03-19'),('2023-03-25'),('2023-03-26'),('2023-04-01'),('2023-04-02'),('2023-04-08'),('2023-04-09'),('2023-04-15'),('2023-04-16'),('2023-04-22'),('2023-04-23'),('2023-04-29'),('2023-04-30'),('2023-05-01'),('2023-05-06'),('2023-05-07'),('2023-05-09'),('2023-05-13'),('2023-05-14'),('2023-05-20'),('2023-05-21'),('2023-05-27'),('2023-05-28'),('2023-06-03'),('2023-06-04'),('2023-06-10'),('2023-06-11'),('2023-06-12'),('2023-06-17'),('2023-06-18'),('2023-06-24'),('2023-06-25'),('2023-07-01'),('2023-07-02'),('2023-07-08'),('2023-07-09'),('2023-07-15'),('2023-07-16'),('2023-07-22'),('2023-07-23'),('2023-07-29'),('2023-07-30'),('2023-08-05'),('2023-08-06'),('2023-08-12'),('2023-08-13'),('2023-08-19'),('2023-08-20'),('2023-08-26'),('2023-08-27'),('2023-09-02'),('2023-09-03'),('2023-09-09'),('2023-09-10'),('2023-09-16'),('2023-09-17'),('2023-09-23'),('2023-09-24'),('2023-09-30'),('2023-10-01'),('2023-10-07'),('2023-10-08'),('2023-10-14'),('2023-10-15'),('2023-10-21'),('2023-10-22'),('2023-10-28'),('2023-10-29'),('2023-11-04'),('2023-11-05'),('2023-11-06'),('2023-11-11'),('2023-11-12'),('2023-11-18'),('2023-11-19'),('2023-11-25'),('2023-11-26'),('2023-12-02'),('2023-12-03'),('2023-12-09'),('2023-12-10'),('2023-12-16'),('2023-12-17'),('2023-12-23'),('2023-12-24'),('2023-12-30'),('2023-12-31'),('2024-01-01'),('2024-01-02'),('2024-01-03'),('2024-01-04'),('2024-01-05'),('2024-01-06'),('2024-01-07'),('2024-01-08'),('2024-01-13'),('2024-01-14'),('2024-01-20'),('2024-01-21'),('2024-01-27'),('2024-01-28'),('2024-02-03'),('2024-02-04'),('2024-02-10'),('2024-02-11'),('2024-02-17'),('2024-02-18'),('2024-02-23'),('2024-02-24'),('2024-02-25'),('2024-03-02'),('2024-03-03'),('2024-03-08'),('2024-03-09'),('2024-03-10'),('2024-03-16'),('2024-03-17'),('2024-03-23'),('2024-03-24'),('2024-03-30'),('2024-03-31'),('2024-04-06'),('2024-04-07'),('2024-04-13'),('2024-04-14'),('2024-04-20'),('2024-04-21'),('2024-04-27'),('2024-04-28'),('2024-05-01'),('2024-05-04'),('2024-05-05'),('2024-05-09'),('2024-05-11'),('2024-05-12'),('2024-05-18'),('2024-05-19'),('2024-05-25'),('2024-05-26'),('2024-06-01'),('2024-06-02'),('2024-06-08'),('2024-06-09'),('2024-06-12'),('2024-06-15'),('2024-06-16'),('2024-06-22'),('2024-06-23'),('2024-06-29'),('2024-06-30'),('2024-07-06'),('2024-07-07'),('2024-07-13'),('2024-07-14'),('2024-07-20'),('2024-07-21'),('2024-07-27'),('2024-07-28'),('2024-08-03'),('2024-08-04'),('2024-08-10'),('2024-08-11'),('2024-08-17'),('2024-08-18'),('2024-08-24'),('2024-08-25'),('2024-08-31'),('2024-09-01'),('2024-09-07'),('2024-09-08'),('2024-09-14'),('2024-09-15'),('2024-09-21'),('2024-09-22'),('2024-09-28'),('2024-09-29'),('2024-10-05'),('2024-10-06'),('2024-10-12'),('2024-10-13'),('2024-10-19'),('2024-10-20'),('2024-10-26'),('2024-10-27'),('2024-11-02'),('2024-11-03'),('2024-11-04'),('2024-11-09'),('2024-11-10'),('2024-11-16'),('2024-11-17'),('2024-11-23'),('2024-11-24'),('2024-11-30'),('2024-12-01'),('2024-12-07'),('2024-12-08'),('2024-12-14'),('2024-12-15'),('2024-12-21'),('2024-12-22'),('2024-12-28'),('2024-12-29'),('2025-01-01'),('2025-01-02'),('2025-01-03'),('2025-01-04'),('2025-01-05'),('2025-01-06'),('2025-01-07'),('2025-01-08'),('2025-01-11'),('2025-01-12'),('2025-01-18'),('2025-01-19'),('2025-01-25'),('2025-01-26'),('2025-02-01'),('2025-02-02'),('2025-02-08'),('2025-02-09'),('2025-02-15'),('2025-02-16'),('2025-02-22'),('2025-02-23'),('2025-02-24'),('2025-03-01'),('2025-03-02'),('2025-03-08'),('2025-03-09'),('2025-03-10'),('2025-03-15'),('2025-03-16'),('2025-03-22'),('2025-03-23'),('2025-03-29'),('2025-03-30'),('2025-04-05'),('2025-04-06'),('2025-04-12'),('2025-04-13'),('2025-04-19'),('2025-04-20'),('2025-04-26'),('2025-04-27'),('2025-05-01'),('2025-05-03'),('2025-05-04'),('2025-05-09'),('2025-05-10'),('2025-05-11'),('2025-05-17'),('2025-05-18'),('2025-05-24'),('2025-05-25'),('2025-05-31'),('2025-06-01'),('2025-06-07'),('2025-06-08'),('2025-06-12'),('2025-06-14'),('2025-06-15'),('2025-06-21'),('2025-06-22'),('2025-06-28'),('2025-06-29'),('2025-07-05'),('2025-07-06'),('2025-07-12'),('2025-07-13'),('2025-07-19'),('2025-07-20'),('2025-07-26'),('2025-07-27'),('2025-08-02'),('2025-08-03'),('2025-08-09'),('2025-08-10'),('2025-08-16'),('2025-08-17'),('2025-08-23'),('2025-08-24'),('2025-08-30'),('2025-08-31'),('2025-09-06'),('2025-09-07'),('2025-09-13'),('2025-09-14'),('2025-09-20'),('2025-09-21'),('2025-09-27'),('2025-09-28'),('2025-10-04'),('2025-10-05'),('2025-10-11'),('2025-10-12'),('2025-10-18'),('2025-10-19'),('2025-10-25'),('2025-10-26'),('2025-11-01'),('2025-11-02'),('2025-11-04'),('2025-11-08'),('2025-11-09'),('2025-11-15'),('2025-11-16'),('2025-11-22'),('2025-11-23'),('2025-11-29'),('2025-11-30'),('2025-12-06'),('2025-12-07'),('2025-12-13'),('2025-12-14'),('2025-12-20'),('2025-12-21'),('2025-12-27'),('2025-12-28');
/*!40000 ALTER TABLE `vocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wire_previous_state`
--

DROP TABLE IF EXISTS `wire_previous_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wire_previous_state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wire_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sertificate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_fire_safety` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wire_previous_state_created_user_id_foreign` (`created_user_id`),
  KEY `wire_previous_state_wire_id_foreign` (`wire_id`),
  CONSTRAINT `wire_previous_state_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wire_previous_state_wire_id_foreign` FOREIGN KEY (`wire_id`) REFERENCES `wires` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wire_previous_state`
--

LOCK TABLES `wire_previous_state` WRITE;
/*!40000 ALTER TABLE `wire_previous_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `wire_previous_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wire_sensor`
--

DROP TABLE IF EXISTS `wire_sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wire_sensor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wire_id` bigint(20) unsigned NOT NULL,
  `sensor_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` tinyint(4) NOT NULL,
  `cabinet_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SP5_valid` tinyint(1) NOT NULL DEFAULT '1',
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `bti_files_id` bigint(20) unsigned DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wire_sensor_created_user_id_foreign` (`created_user_id`),
  KEY `wire_sensor_wire_id_foreign` (`wire_id`),
  KEY `wire_sensor_sensor_id_foreign` (`sensor_id`),
  KEY `wire_sensor_bti_files_id_foreign` (`bti_files_id`),
  CONSTRAINT `wire_sensor_bti_files_id_foreign` FOREIGN KEY (`bti_files_id`) REFERENCES `bti_files` (`id`),
  CONSTRAINT `wire_sensor_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wire_sensor_sensor_id_foreign` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wire_sensor`
--

LOCK TABLES `wire_sensor` WRITE;
/*!40000 ALTER TABLE `wire_sensor` DISABLE KEYS */;
INSERT INTO `wire_sensor` VALUES (1,1,5,3,'1',3,'32',1,1,'2019-06-11 07:56:34','2019-08-29 13:29:57',NULL,NULL,1,75.3879883,-186.1250000),(2,1,1,3,'2',1,'11',1,0,'2019-06-12 12:48:39','2019-08-14 08:37:41','Перенесен из 12 кабинета',NULL,1,73.8890529,-218.6250000),(3,1,1,3,'3',1,'12',1,1,'2019-06-12 12:48:46','2019-08-14 08:37:45','После ремонта',NULL,1,74.3886980,-297.6250000),(4,1,1,3,'4',1,'14',1,1,'2019-06-12 12:52:20','2019-06-12 12:52:20','',NULL,NULL,NULL,NULL),(5,1,1,3,'5',1,'15',1,1,'2019-06-12 12:54:23','2019-06-12 12:54:23','',NULL,NULL,NULL,NULL),(6,1,1,3,'6',1,'16',1,1,'2019-06-12 12:56:01','2019-06-12 12:56:01','',NULL,NULL,NULL,NULL),(7,1,1,3,'7',1,'ddd',1,1,'2019-07-04 04:45:37','2019-07-04 07:08:28',NULL,'2019-07-04 07:08:28',NULL,NULL,NULL),(8,1,1,3,'8',1,'qqq',0,0,'2019-07-04 06:28:35','2019-07-04 07:03:04',NULL,'2019-07-04 07:03:04',NULL,NULL,NULL),(9,1,1,3,'7',1,'16',1,0,'2019-07-04 10:26:23','2019-07-04 10:34:12','Проба пера','2019-07-04 10:34:12',NULL,NULL,NULL),(10,1,1,3,'7',3,'Кабинет директора',0,1,'2019-08-14 08:38:38','2019-08-14 08:39:12',NULL,NULL,1,202.2703484,-188.8750000),(11,6,1,5,'1',1,'12',0,0,'2019-08-15 07:23:09','2019-10-17 14:34:40',NULL,NULL,NULL,NULL,NULL),(12,6,4,3,'2',1,'13',0,1,'2019-08-15 07:24:08','2019-08-15 07:24:08',NULL,NULL,NULL,NULL,NULL),(13,20,2,3,'1',1,'dsss',1,1,'2019-09-05 10:36:27','2019-09-05 11:15:26',NULL,'2019-09-05 11:15:26',NULL,NULL,NULL),(14,20,5,3,'2',23,'awe',1,1,'2019-09-05 11:09:01','2019-09-05 11:35:01',NULL,'2019-09-05 11:35:01',NULL,NULL,NULL),(15,8,2,3,'1',0,'qwe',1,1,'2019-09-06 06:51:16','2019-09-18 05:41:57',NULL,NULL,1,251.8046043,-240.6333313),(16,20,1,3,'1',2,'cabinet 1',1,0,'2019-09-06 07:03:52','2019-10-17 08:55:28',NULL,'2019-10-17 08:55:28',NULL,NULL,NULL),(17,20,2,3,'2',2,'cabinet 2',1,1,'2019-09-06 07:05:19','2019-10-17 08:55:28',NULL,'2019-10-17 08:55:28',NULL,NULL,NULL),(18,20,1,3,'3',3,'cabinet 3',1,1,'2019-09-06 07:08:47','2019-09-06 07:08:47',NULL,NULL,NULL,NULL,NULL),(19,20,6,3,'4',1,'cabinet 4',1,0,'2019-09-06 07:14:53','2019-09-06 07:14:53',NULL,NULL,NULL,NULL,NULL),(20,20,1,3,'5',1,'5',0,1,'2019-09-06 07:35:09','2019-09-06 07:35:09',NULL,NULL,NULL,NULL,NULL),(21,20,1,3,'6',1,'6',1,1,'2019-09-06 08:35:07','2019-09-06 08:35:07',NULL,NULL,NULL,NULL,NULL),(22,20,1,3,'7',1,'7',1,0,'2019-09-06 10:16:59','2019-09-06 10:16:59',NULL,NULL,NULL,NULL,NULL),(23,20,1,3,'8',1,'8',0,0,'2019-09-06 10:22:10','2019-09-06 10:22:10',NULL,NULL,NULL,NULL,NULL),(24,20,1,3,'9',1,'9',0,0,'2019-09-06 10:25:40','2019-09-06 10:25:40',NULL,NULL,NULL,NULL,NULL),(25,20,1,3,'10',1,'10',0,0,'2019-09-06 10:28:36','2019-09-06 10:28:36',NULL,NULL,NULL,NULL,NULL),(26,20,1,3,'11',1,'11',0,0,'2019-09-06 12:40:14','2019-09-06 12:40:14',NULL,NULL,NULL,NULL,NULL),(27,8,1,3,'2',-1,'2',1,0,'2019-09-07 12:14:47','2019-09-18 05:40:45',NULL,NULL,1,243.8020094,-267.5833359),(28,20,1,3,'12',1,'12',0,0,'2019-09-07 17:46:16','2019-09-07 17:46:16',NULL,NULL,NULL,NULL,NULL),(29,8,1,3,'3',3,'3',0,0,'2019-09-07 17:50:45','2019-09-07 17:50:45',NULL,NULL,NULL,NULL,NULL),(30,16,1,3,'1',2,NULL,1,1,'2019-10-16 07:46:12','2019-10-16 07:46:12',NULL,NULL,NULL,NULL,NULL),(31,16,1,3,'2',2,NULL,1,1,'2019-10-16 07:46:15','2019-10-16 07:46:15',NULL,NULL,NULL,NULL,NULL),(32,16,1,3,'3',2,NULL,1,1,'2019-10-16 07:46:15','2019-10-16 07:46:15',NULL,NULL,NULL,NULL,NULL),(33,16,1,3,'4',2,NULL,1,1,'2019-10-16 07:46:15','2019-10-16 07:46:15',NULL,NULL,NULL,NULL,NULL),(34,16,1,3,'5',2,NULL,1,1,'2019-10-16 07:46:15','2019-10-16 07:46:15',NULL,NULL,NULL,NULL,NULL),(35,16,1,3,'6',2,NULL,1,1,'2019-10-16 07:46:15','2019-10-16 07:46:15',NULL,NULL,NULL,NULL,NULL),(36,16,1,3,'7',2,NULL,1,1,'2019-10-16 07:46:16','2019-10-16 07:46:16',NULL,NULL,NULL,NULL,NULL),(37,16,1,3,'8',2,NULL,1,1,'2019-10-16 07:46:16','2019-10-16 07:46:16',NULL,NULL,NULL,NULL,NULL),(38,16,1,3,'9',2,NULL,1,1,'2019-10-16 07:46:16','2019-10-16 07:46:16',NULL,NULL,NULL,NULL,NULL),(39,16,1,3,'10',2,NULL,1,1,'2019-10-16 07:46:16','2019-10-16 07:46:16',NULL,NULL,NULL,NULL,NULL),(40,16,1,3,'11',2,NULL,1,1,'2019-10-16 07:46:16','2019-10-16 07:46:16',NULL,NULL,NULL,NULL,NULL),(41,16,1,3,'12',2,NULL,1,1,'2019-10-16 07:46:16','2019-10-16 07:46:16',NULL,NULL,NULL,NULL,NULL),(42,16,1,3,'13',2,NULL,1,1,'2019-10-16 07:46:17','2019-10-16 07:46:17',NULL,NULL,NULL,NULL,NULL),(43,16,1,3,'14',2,NULL,1,1,'2019-10-16 07:46:17','2019-10-16 07:46:17',NULL,NULL,NULL,NULL,NULL),(44,16,1,3,'15',2,NULL,1,1,'2019-10-16 07:46:17','2019-10-16 07:46:17',NULL,NULL,NULL,NULL,NULL),(45,16,1,3,'16',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(46,16,1,3,'17',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(47,16,1,3,'18',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(48,16,1,3,'19',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(49,16,1,3,'20',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(50,16,1,3,'21',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(51,16,1,3,'22',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(52,16,1,3,'23',2,NULL,1,1,'2019-10-16 07:46:18','2019-10-16 07:46:18',NULL,NULL,NULL,NULL,NULL),(53,16,1,3,'24',2,NULL,1,1,'2019-10-16 07:46:19','2019-10-16 07:46:19',NULL,NULL,NULL,NULL,NULL),(54,16,1,3,'25',2,NULL,1,1,'2019-10-16 07:46:19','2019-10-16 07:46:19',NULL,NULL,NULL,NULL,NULL),(55,16,1,3,'26',2,NULL,1,1,'2019-10-16 07:46:19','2019-10-16 07:46:19',NULL,NULL,NULL,NULL,NULL),(56,16,1,3,'27',2,NULL,1,1,'2019-10-16 07:46:19','2019-10-16 07:46:19',NULL,NULL,NULL,NULL,NULL),(57,16,1,3,'28',2,NULL,1,1,'2019-10-16 07:46:19','2019-10-16 07:46:19',NULL,NULL,NULL,NULL,NULL),(58,16,1,3,'29',2,NULL,1,1,'2019-10-16 07:46:19','2019-10-16 07:46:19',NULL,NULL,NULL,NULL,NULL),(59,16,1,3,'30',2,NULL,1,1,'2019-10-16 07:46:19','2019-10-16 07:46:19',NULL,NULL,NULL,NULL,NULL),(60,19,2,5,'1',2,NULL,1,1,'2019-10-17 08:23:32','2019-10-17 08:23:32',NULL,NULL,NULL,NULL,NULL),(61,19,2,5,'2',2,NULL,1,1,'2019-10-17 08:23:33','2019-10-17 08:23:33',NULL,NULL,NULL,NULL,NULL),(62,19,2,5,'3',2,NULL,1,1,'2019-10-17 08:23:33','2019-10-17 08:23:33',NULL,NULL,NULL,NULL,NULL),(63,19,2,5,'4',2,NULL,1,1,'2019-10-17 08:23:33','2019-10-17 08:23:33',NULL,NULL,NULL,NULL,NULL),(64,19,2,5,'5',2,NULL,1,1,'2019-10-17 08:23:33','2019-10-17 08:23:33',NULL,NULL,NULL,NULL,NULL),(65,19,2,5,'6',2,NULL,1,1,'2019-10-17 08:23:34','2019-10-17 08:23:34',NULL,NULL,NULL,NULL,NULL),(66,19,2,5,'7',2,NULL,1,1,'2019-10-17 08:23:34','2019-10-17 08:23:34',NULL,NULL,NULL,NULL,NULL),(67,19,2,5,'8',2,NULL,1,1,'2019-10-17 08:23:34','2019-10-17 08:23:34',NULL,NULL,NULL,NULL,NULL),(68,19,2,5,'9',2,NULL,1,1,'2019-10-17 08:23:34','2019-10-17 08:23:34',NULL,NULL,NULL,NULL,NULL),(69,19,2,5,'10',2,NULL,1,1,'2019-10-17 08:23:35','2019-10-17 08:23:35',NULL,NULL,NULL,NULL,NULL),(80,25,2,5,'1',1,NULL,1,1,'2019-10-17 09:05:07','2019-10-17 09:38:24',NULL,'2019-10-17 09:38:24',NULL,NULL,NULL),(81,25,2,5,'2',1,NULL,1,1,'2019-10-17 09:05:07','2019-10-17 09:38:24',NULL,'2019-10-17 09:38:24',NULL,NULL,NULL),(82,25,2,5,'3',1,NULL,1,1,'2019-10-17 09:05:07','2019-10-17 09:38:24',NULL,'2019-10-17 09:38:24',NULL,NULL,NULL),(83,25,2,5,'4',1,NULL,1,1,'2019-10-17 09:05:07','2019-10-17 09:38:24',NULL,'2019-10-17 09:38:24',NULL,NULL,NULL),(84,25,2,5,'5',1,NULL,1,1,'2019-10-17 09:05:07','2019-10-17 09:38:24',NULL,'2019-10-17 09:38:24',NULL,NULL,NULL),(85,10,3,3,'1',1,'111',1,1,'2019-11-11 07:40:37','2019-11-11 07:41:34',NULL,'2019-11-11 07:41:34',NULL,NULL,NULL),(86,10,2,3,'2',1,'222',1,1,'2019-11-11 07:40:59','2019-11-11 07:41:37',NULL,'2019-11-11 07:41:37',NULL,NULL,NULL),(87,26,9,3,'1',1,'111',1,0,'2019-11-11 07:45:00','2020-01-07 16:00:40',NULL,NULL,NULL,NULL,NULL),(88,26,9,3,'2',1,'222',1,0,'2019-11-11 07:45:10','2020-01-07 16:06:06',NULL,NULL,NULL,NULL,NULL),(89,26,9,3,'3',1,'Столовая',1,1,'2020-01-07 16:01:25','2020-01-07 16:04:17',NULL,NULL,NULL,NULL,NULL),(90,26,9,3,'4',1,'Спальня',1,1,'2020-01-07 16:01:49','2020-01-07 16:01:49',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `wire_sensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wire_sensor_previous_state`
--

DROP TABLE IF EXISTS `wire_sensor_previous_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wire_sensor_previous_state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wire_sensor_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` tinyint(4) NOT NULL,
  `cabinet_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SP5_valid` tinyint(1) NOT NULL DEFAULT '1',
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `wire_id` bigint(20) unsigned NOT NULL,
  `sensor_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wire_sensor_previous_state_created_user_id_foreign` (`created_user_id`),
  KEY `wire_sensor_previous_state_wire_sensor_id_foreign` (`wire_sensor_id`),
  CONSTRAINT `wire_sensor_previous_state_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wire_sensor_previous_state_wire_sensor_id_foreign` FOREIGN KEY (`wire_sensor_id`) REFERENCES `wire_sensor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wire_sensor_previous_state`
--

LOCK TABLES `wire_sensor_previous_state` WRITE;
/*!40000 ALTER TABLE `wire_sensor_previous_state` DISABLE KEYS */;
INSERT INTO `wire_sensor_previous_state` VALUES (1,1,3,'1',12,'321',1,1,1,'2019-06-11 09:25:06','2019-06-11 09:25:06',1,1),(2,1,3,'1',12,'321',1,1,1,'2019-06-11 09:25:47','2019-06-11 09:25:47',1,1),(3,1,3,'1',12,'321',1,1,1,'2019-06-11 09:28:20','2019-06-11 09:28:20',1,1),(4,1,3,'1',12,'321',1,1,1,'2019-06-11 09:32:26','2019-06-11 09:32:26',1,1),(5,1,3,'1',12,'321',1,1,1,'2019-06-11 09:35:14','2019-06-11 09:35:14',1,1),(6,1,3,'1',12,'321',1,1,1,'2019-06-11 09:35:59','2019-06-11 09:35:59',1,1),(7,1,3,'1',12,'321',1,1,1,'2019-06-11 09:38:20','2019-06-11 09:38:20',1,1),(8,1,3,'1',12,'321',1,1,1,'2019-06-11 09:39:59','2019-06-11 09:39:59',1,1),(9,1,3,'15',126,'3217',1,1,1,'2019-06-11 09:40:51','2019-06-11 09:40:51',1,4),(10,1,3,'2',3,'32',1,1,1,'2019-06-12 12:59:04','2019-06-12 12:59:04',1,5),(11,3,3,'2',1,'12',1,1,1,'2019-06-12 13:00:14','2019-06-12 13:00:14',1,1),(12,2,3,'2',1,'11',0,1,1,'2019-06-12 13:19:21','2019-06-12 13:19:21',1,1),(13,2,3,'2',1,'11',0,1,1,'2019-06-12 13:21:18','2019-06-12 13:21:18',1,1),(14,3,3,'3',1,'12',1,1,1,'2019-06-12 13:21:36','2019-06-12 13:21:36',1,1),(15,2,3,'2',1,'11',0,1,1,'2019-07-04 04:35:46','2019-07-04 04:35:46',1,1),(16,8,3,'8',1,'qqq',1,1,1,'2019-07-04 06:38:44','2019-07-04 06:38:44',1,1),(17,8,3,'8',1,'qqq',1,1,1,'2019-07-04 06:38:50','2019-07-04 06:38:50',1,1),(18,8,3,'8',1,'qqq',0,1,1,'2019-07-04 06:40:34','2019-07-04 06:40:34',1,1),(19,8,3,'8',1,'qqq',0,0,1,'2019-07-04 06:54:36','2019-07-04 06:54:36',1,1),(20,8,3,'8',1,'qqq',0,0,1,'2019-07-04 06:58:57','2019-07-04 06:58:57',1,1),(21,8,3,'8',1,'qqq',0,0,1,'2019-07-04 07:03:04','2019-07-04 07:03:04',1,1),(22,7,3,'7',1,'ddd',1,1,1,'2019-07-04 07:08:28','2019-07-04 07:08:28',1,1),(23,2,3,'2',1,'11',0,0,1,'2019-07-04 09:19:46','2019-07-04 09:19:46',1,1),(24,2,3,'2',1,'11',1,0,1,'2019-07-04 10:23:55','2019-07-04 10:23:55',1,1),(25,9,3,'7',1,'16',1,0,1,'2019-07-04 10:29:56','2019-07-04 10:29:56',1,1),(26,9,3,'7',1,'16',1,0,1,'2019-07-04 10:34:12','2019-07-04 10:34:12',1,1),(27,1,3,'1',3,'32',1,1,1,'2019-07-16 11:43:54','2019-07-16 11:43:54',1,5),(28,1,3,'1',3,'32',1,1,1,'2019-08-14 08:36:59','2019-08-14 08:36:59',1,5),(29,10,3,'7',5,'Кабинет директора',1,1,1,'2019-08-14 08:38:53','2019-08-14 08:38:53',1,1),(30,10,3,'7',3,'Кабинет директора',1,1,1,'2019-08-14 08:39:03','2019-08-14 08:39:03',1,1),(31,1,3,'1',3,'32',1,0,1,'2019-08-29 11:31:48','2019-08-29 11:31:48',1,5),(32,2,3,'2',1,'11',1,0,1,'2019-08-29 12:58:59','2019-08-29 12:58:59',1,1),(33,3,3,'3',1,'12',1,1,1,'2019-08-29 13:17:20','2019-08-29 13:17:20',1,1),(34,1,3,'1',3,'32',1,1,1,'2019-08-29 13:22:05','2019-08-29 13:22:05',1,5),(35,1,3,'1',3,'32',1,1,1,'2019-08-29 13:22:45','2019-08-29 13:22:45',1,5),(36,1,3,'1',3,'32',1,1,1,'2019-08-29 13:24:36','2019-08-29 13:24:36',1,5),(37,1,3,'1',3,'32',1,1,1,'2019-08-29 13:25:09','2019-08-29 13:25:09',1,5),(38,1,3,'1',3,'32',1,1,1,'2019-08-29 13:26:12','2019-08-29 13:26:12',1,5),(39,1,3,'1',3,'32',1,1,1,'2019-08-29 13:28:05','2019-08-29 13:28:05',1,5),(40,1,3,'1',3,'32',1,1,1,'2019-08-29 13:29:02','2019-08-29 13:29:02',1,5),(41,1,3,'1',3,'32',1,0,1,'2019-08-29 13:29:56','2019-08-29 13:29:56',1,5),(42,13,3,'1',1,'dsss',1,1,1,'2019-09-05 11:15:25','2019-09-05 11:15:25',20,2),(43,14,3,'2',2,'awe',1,1,1,'2019-09-05 11:34:34','2019-09-05 11:34:34',20,5),(44,14,3,'2',23,'awe',1,1,1,'2019-09-05 11:35:01','2019-09-05 11:35:01',20,5),(45,18,3,'3',3,'cabinet 3',1,1,1,'2019-09-06 07:35:26','2019-09-06 07:35:26',20,1),(46,16,3,'1',2,'cabinet 1',1,1,1,'2019-09-06 07:42:59','2019-09-06 07:42:59',20,1),(47,16,3,'1',2,'cabinet 1',1,1,1,'2019-09-06 07:46:33','2019-09-06 07:46:33',20,1),(48,16,3,'1',2,'cabinet 1',1,0,1,'2019-10-17 08:55:27','2019-10-17 08:55:27',20,1),(49,17,3,'2',2,'cabinet 2',1,1,1,'2019-10-17 08:55:27','2019-10-17 08:55:27',20,2),(50,11,3,'1',1,'12',0,1,1,'2019-10-17 14:34:39','2019-10-17 14:34:39',6,1),(51,85,3,'1',1,'111',1,1,1,'2019-11-11 07:41:34','2019-11-11 07:41:34',10,3),(52,86,3,'2',1,'222',1,1,1,'2019-11-11 07:41:37','2019-11-11 07:41:37',10,2),(53,87,3,'1',1,'111',1,1,1,'2020-01-07 16:00:39','2020-01-07 16:00:39',26,9),(54,89,3,'3',1,'Столовая',1,0,1,'2020-01-07 16:01:58','2020-01-07 16:01:58',26,9),(55,89,3,'3',1,'Столовая',1,0,1,'2020-01-07 16:02:34','2020-01-07 16:02:34',26,9),(56,89,3,'3',1,'Столовая',1,0,1,'2020-01-07 16:04:17','2020-01-07 16:04:17',26,9),(57,88,3,'2',1,'222',1,1,1,'2020-01-07 16:06:06','2020-01-07 16:06:06',26,9);
/*!40000 ALTER TABLE `wire_sensor_previous_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wire_sensor_reglament`
--

DROP TABLE IF EXISTS `wire_sensor_reglament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wire_sensor_reglament` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wire_sensor_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wire_sensor_reglament_created_user_id_foreign` (`created_user_id`),
  KEY `wire_sensor_reglament_wire_sensor_id_foreign` (`wire_sensor_id`),
  CONSTRAINT `wire_sensor_reglament_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wire_sensor_reglament_wire_sensor_id_foreign` FOREIGN KEY (`wire_sensor_id`) REFERENCES `wire_sensor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wire_sensor_reglament`
--

LOCK TABLES `wire_sensor_reglament` WRITE;
/*!40000 ALTER TABLE `wire_sensor_reglament` DISABLE KEYS */;
/*!40000 ALTER TABLE `wire_sensor_reglament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wires`
--

DROP TABLE IF EXISTS `wires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wires` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_device_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sertificate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` set('safe','unsafe','radio') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unsafe',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wires_created_user_id_foreign` (`created_user_id`),
  KEY `wires_object_device_id_foreign` (`object_device_id`),
  CONSTRAINT `wires_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wires`
--

LOCK TABLES `wires` WRITE;
/*!40000 ALTER TABLE `wires` DISABLE KEYS */;
INSERT INTO `wires` VALUES (1,1,3,1,'ПБ1','ПБ-12-1987','safe',1,'2019-06-07 11:38:47','2019-07-03 11:19:41',NULL),(2,1,3,1,'Пожароопасный',NULL,'unsafe',1,'2019-06-13 08:07:07','2019-06-13 08:07:07',NULL),(5,1,3,1,'radio',NULL,'radio',1,'2019-06-13 08:16:45','2019-06-13 08:16:45',NULL),(6,22,3,1,'1',NULL,'unsafe',1,'2019-08-15 07:22:45','2019-08-15 07:22:45',NULL),(7,24,3,1,'1',NULL,'unsafe',1,'2019-08-27 08:55:35','2019-08-27 08:55:35',NULL),(8,45,3,1,'1',NULL,'unsafe',1,'2019-09-04 15:14:18','2019-09-04 15:14:18',NULL),(9,45,3,1,'2',NULL,'unsafe',1,'2019-09-04 15:15:12','2019-09-04 15:15:12',NULL),(10,45,3,1,'3',NULL,'unsafe',1,'2019-09-04 15:25:53','2019-09-04 15:25:53',NULL),(11,45,3,1,'4',NULL,'unsafe',1,'2019-09-04 15:27:52','2019-09-04 15:27:52',NULL),(12,61,3,1,'1',NULL,'unsafe',1,'2019-09-04 15:30:02','2019-09-04 15:30:02',NULL),(13,61,3,1,'2',NULL,'unsafe',1,'2019-09-04 15:31:53','2019-09-04 15:31:53',NULL),(14,61,3,1,'3',NULL,'unsafe',1,'2019-09-04 15:32:39','2019-09-04 15:32:39',NULL),(15,61,3,1,'4',NULL,'unsafe',1,'2019-09-04 15:39:13','2019-09-04 15:39:13',NULL),(25,85,3,1,'4',NULL,'unsafe',1,'2019-09-04 15:39:13','2019-10-17 09:40:18','2019-10-17 09:40:18'),(26,92,3,1,'1',NULL,'unsafe',1,'2019-11-11 07:44:47','2019-11-11 07:44:47',NULL),(27,92,3,1,'2',NULL,'unsafe',1,'2020-01-07 13:12:59','2020-01-07 13:12:59',NULL);
/*!40000 ALTER TABLE `wires` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-14 16:47:00
