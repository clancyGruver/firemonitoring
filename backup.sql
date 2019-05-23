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
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) unsigned NOT NULL,
  `technik_id` bigint(20) unsigned NOT NULL,
  `object_id` bigint(20) unsigned NOT NULL,
  `device_id` bigint(20) unsigned DEFAULT NULL,
  `job_type` set('repair','reglament','installation') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reglament_dev_type` set('sensor','wire','device') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reglament_id` bigint(20) unsigned DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_admin_id_foreign` (`admin_id`),
  KEY `calendar_technik_id_foreign` (`technik_id`),
  KEY `calendar_object_id_foreign` (`object_id`),
  KEY `calendar_device_id_foreign` (`device_id`),
  CONSTRAINT `calendar_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`),
  CONSTRAINT `calendar_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `calendar_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  CONSTRAINT `calendar_technik_id_foreign` FOREIGN KEY (`technik_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar`
--

LOCK TABLES `calendar` WRITE;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_class`
--

LOCK TABLES `device_class` WRITE;
/*!40000 ALTER TABLE `device_class` DISABLE KEYS */;
INSERT INTO `device_class` VALUES (1,'РСПИ',1,'2019-05-22 09:44:41','2019-05-22 09:47:50'),(2,'Охранно-пожарная сигнализация',1,'2019-05-22 18:19:26','2019-05-22 18:19:26');
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
  `created_user_id` bigint(20) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_limitations_created_user_id_foreign` (`created_user_id`),
  KEY `device_limitations_device_id_foreign` (`device_id`),
  CONSTRAINT `device_limitations_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `device_limitations_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_limitations`
--

LOCK TABLES `device_limitations` WRITE;
/*!40000 ALTER TABLE `device_limitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_limitations` ENABLE KEYS */;
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
  `period` tinyint(4) NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `dvice_id` bigint(20) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_reglament_created_user_id_foreign` (`created_user_id`),
  KEY `device_reglament_dvice_id_foreign` (`dvice_id`),
  CONSTRAINT `device_reglament_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `device_reglament_dvice_id_foreign` FOREIGN KEY (`dvice_id`) REFERENCES `devices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_reglament`
--

LOCK TABLES `device_reglament` WRITE;
/*!40000 ALTER TABLE `device_reglament` DISABLE KEYS */;
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
  `dvice_reglament_id` smallint(5) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_reglament_element_created_user_id_foreign` (`created_user_id`),
  KEY `device_reglament_element_dvice_reglament_id_foreign` (`dvice_reglament_id`),
  CONSTRAINT `device_reglament_element_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `device_reglament_element_dvice_reglament_id_foreign` FOREIGN KEY (`dvice_reglament_id`) REFERENCES `device_reglament` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_reglament_element`
--

LOCK TABLES `device_reglament_element` WRITE;
/*!40000 ALTER TABLE `device_reglament_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_reglament_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wires_count` tinyint(4) NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `class_id` tinyint(3) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devices_created_user_id_foreign` (`created_user_id`),
  KEY `devices_class_id_foreign` (`class_id`),
  CONSTRAINT `devices_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `device_class` (`id`),
  CONSTRAINT `devices_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,'АМП-4',4,'amp4.pdf',3,2,0,'2019-05-22 19:02:19','2019-05-22 19:31:22'),(2,'АМП-4',4,'amp4.pdf',3,2,0,'2019-05-22 19:11:52','2019-05-22 19:31:26'),(3,'АМП-4',4,'amp4.pdf',3,2,0,'2019-05-22 19:14:15','2019-05-22 19:31:31'),(4,'АМП-4',4,'amp4.pdf',3,1,0,'2019-05-22 19:31:45','2019-05-23 04:34:01'),(5,'АМП-4',4,'amp4.pdf',3,2,0,'2019-05-23 04:34:18','2019-05-23 04:36:21'),(6,'АМП-4',4,'amp4.pdf',3,2,0,'2019-05-23 04:36:31','2019-05-23 04:47:52'),(7,'АМП-4',4,'amp4.pdf',3,2,0,'2019-05-23 04:46:04','2019-05-23 04:47:53'),(8,'АМП-4',4,'amp4.pdf',3,2,0,'2019-05-23 04:47:00','2019-05-23 04:47:55'),(9,'АМП-4',4,'amp4.pdf',3,2,1,'2019-05-23 04:47:39','2019-05-23 08:59:27');
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_05_15_055415_raions',2),(4,'2019_05_15_060541_objects',2),(7,'2019_05_15_060035_device_class',3),(8,'2019_05_15_061317_devices',4),(9,'2019_05_15_061835_device_reglament',4),(10,'2019_05_15_065432_device_reglament_element',5),(11,'2019_05_15_065712_device_limitations',6),(12,'2019_05_15_065946_object_devices',7),(13,'2019_05_15_070921_wires',7),(15,'2019_05_15_071538_sensors',8),(16,'2019_05_15_080205_wire_sensor',9),(17,'2019_05_15_080205_wire_sensor_previous_state',10),(18,'2019_05_15_081024_wire_sensor_reglament',10),(19,'2019_05_15_081306_wire_previous_state',10),(20,'2019_05_15_082055_object_device_reglament',11),(21,'2019_05_15_082057_object_device_reglament_limitations',12),(22,'2019_05_15_083012_object_repair_queue',12),(23,'2019_05_15_084106_calendar',12),(24,'2019_05_19_121046_user',13),(25,'2016_06_01_000001_create_oauth_auth_codes_table',14),(26,'2016_06_01_000002_create_oauth_access_tokens_table',14),(27,'2016_06_01_000003_create_oauth_refresh_tokens_table',14),(28,'2016_06_01_000004_create_oauth_clients_table',14),(29,'2016_06_01_000005_create_oauth_personal_access_clients_table',14);
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
  `ODR_id` bigint(20) unsigned NOT NULL,
  `DL_id` smallint(5) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `additional_limitation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_device_reglament_limitations_created_user_id_foreign` (`created_user_id`),
  KEY `object_device_reglament_limitations_object_device_id_foreign` (`object_device_id`),
  KEY `object_device_reglament_limitations_odr_id_foreign` (`ODR_id`),
  KEY `object_device_reglament_limitations_dl_id_foreign` (`DL_id`),
  CONSTRAINT `object_device_reglament_limitations_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `object_device_reglament_limitations_dl_id_foreign` FOREIGN KEY (`DL_id`) REFERENCES `device_limitations` (`id`),
  CONSTRAINT `object_device_reglament_limitations_object_device_id_foreign` FOREIGN KEY (`object_device_id`) REFERENCES `object_devices` (`id`),
  CONSTRAINT `object_device_reglament_limitations_odr_id_foreign` FOREIGN KEY (`ODR_id`) REFERENCES `object_device_reglament` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_device_reglament_limitations`
--

LOCK TABLES `object_device_reglament_limitations` WRITE;
/*!40000 ALTER TABLE `object_device_reglament_limitations` DISABLE KEYS */;
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
  `created_user_id` bigint(20) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_devices_created_user_id_foreign` (`created_user_id`),
  KEY `object_devices_device_id_foreign` (`device_id`),
  KEY `object_devices_object_id_foreign` (`object_id`),
  CONSTRAINT `object_devices_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `object_devices_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `object_devices_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_devices`
--

LOCK TABLES `object_devices` WRITE;
/*!40000 ALTER TABLE `object_devices` DISABLE KEYS */;
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
  `repairer_id` bigint(20) unsigned NOT NULL,
  `broken_object_id` bigint(20) unsigned NOT NULL,
  `limitation_id` bigint(20) unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_repair_queue_finder_id_foreign` (`finder_id`),
  KEY `object_repair_queue_repairer_id_foreign` (`repairer_id`),
  KEY `object_repair_queue_object_id_foreign` (`object_id`),
  KEY `object_repair_queue_device_id_foreign` (`device_id`),
  CONSTRAINT `object_repair_queue_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `object_repair_queue_finder_id_foreign` FOREIGN KEY (`finder_id`) REFERENCES `users` (`id`),
  CONSTRAINT `object_repair_queue_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  CONSTRAINT `object_repair_queue_repairer_id_foreign` FOREIGN KEY (`repairer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_repair_queue`
--

LOCK TABLES `object_repair_queue` WRITE;
/*!40000 ALTER TABLE `object_repair_queue` DISABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `objects_raion_id_foreign` (`raion_id`),
  KEY `objects_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `objects_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `objects_raion_id_foreign` FOREIGN KEY (`raion_id`) REFERENCES `raions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,'Детский сад',42,'Сталеваров 16',61.4012139,55.2661825,1,'Петров','654321','Иванов','123456',NULL,'2019-05-19 17:18:00','2019-05-23 10:00:57'),(2,'ТЕст2',42,'Сталеваров, 15',61.4034160,55.2575960,0,'ПППП','456','ИИИ','123',NULL,'2019-05-19 17:51:42','2019-05-22 06:05:58'),(3,'Ntcn 3',42,'Худякова 15',61.3739600,55.1473250,0,'ЙЙЙЙ','654','ККК','123',NULL,'2019-05-19 17:52:40','2019-05-22 19:27:19'),(4,'кккк',42,'Пушкина 68',61.4096140,55.1567490,1,'ЕЕЕ','645','РРР','123',NULL,'2019-05-19 17:54:28','2019-05-19 17:54:28'),(5,'Иванов Иван',11,'erwer',58.2225649,54.6835573,1,'qwerea','2342','werw','23423',3,'2019-05-22 08:49:40','2019-05-22 08:49:40');
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
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
  KEY `password_resets_email_index` (`email`)
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raions`
--

LOCK TABLES `raions` WRITE;
/*!40000 ALTER TABLE `raions` DISABLE KEYS */;
INSERT INTO `raions` VALUES (1,'Агаповский муниципальный район',59.2974060,53.2702650,0,'2019-05-18 14:51:15','2019-05-22 04:51:48'),(2,'Аргаяшский муниципальный район',60.7585870,55.4137190,0,'2019-05-18 14:51:15','2019-05-19 08:49:51'),(3,'Ашинский муниципальный район',57.5703410,55.0506640,0,'2019-05-18 14:51:16','2019-05-19 08:49:52'),(4,'Брединский муниципальный район',60.3067080,52.4326830,0,'2019-05-18 14:51:16','2019-05-19 08:49:53'),(5,'Варненский муниципальный район',61.3553920,53.1380460,0,'2019-05-18 14:51:17','2019-05-19 08:49:55'),(6,'Верхнеуральский муниципальный район',59.1980970,53.8143360,0,'2019-05-18 14:51:17','2019-05-19 08:49:57'),(7,'Еманжелинский муниципальный район',61.3269150,54.7427410,1,'2019-05-18 14:51:18','2019-05-18 14:51:18'),(8,'Еткульский муниципальный район',61.5793420,54.7634150,1,'2019-05-18 14:51:18','2019-05-18 14:51:18'),(9,'Карталинский муниципальный район',60.3992790,53.0443540,1,'2019-05-18 14:51:18','2019-05-18 14:51:18'),(10,'Каслинский муниципальный район',61.4167830,56.1570470,1,'2019-05-18 14:51:18','2019-05-18 14:51:18'),(11,'Катав-Ивановский муниципальный район',58.2114860,54.6961840,1,'2019-05-18 14:51:19','2019-05-18 14:51:19'),(12,'Кизильский муниципальный район',59.2993640,52.7499710,1,'2019-05-18 14:51:19','2019-05-18 14:51:19'),(13,'Коркинский муниципальный район',61.3768800,54.9151870,1,'2019-05-18 14:51:20','2019-05-18 14:51:20'),(14,'Красноармейский муниципальный район',62.0510920,55.4430210,1,'2019-05-18 14:51:20','2019-05-18 14:51:20'),(15,'Кунашакский муниципальный район',61.6226950,55.8362820,1,'2019-05-18 14:51:21','2019-05-18 14:51:21'),(16,'Кусинский муниципальный район',59.5826030,55.4120120,1,'2019-05-18 14:51:21','2019-05-18 14:51:21'),(17,'Нагайбакский муниципальный район',59.8283190,53.5595940,1,'2019-05-18 14:51:21','2019-05-18 14:51:21'),(18,'Нязепетровский муниципальный район ',59.5755150,55.9682770,1,'2019-05-18 14:51:22','2019-05-18 14:51:22'),(19,'Октябрьский муниципальный район',62.7072580,54.3837140,1,'2019-05-18 14:51:22','2019-05-18 14:51:22'),(20,'Пластовский муниципальный район',60.6766610,54.3747470,1,'2019-05-18 14:51:22','2019-05-18 14:51:22'),(21,'Саткинский муниципальный район',58.9971080,54.9784520,1,'2019-05-18 14:51:23','2019-05-18 14:51:23'),(22,'Сосновский муниципальный район',61.1986450,55.2309900,1,'2019-05-18 14:51:23','2019-05-18 14:51:23'),(23,'Троицкий муниципальный район',61.2930670,54.1754920,1,'2019-05-18 14:51:24','2019-05-18 14:51:24'),(24,'Увельский муниципальный район',61.4957540,54.4851620,1,'2019-05-18 14:51:24','2019-05-18 14:51:24'),(25,'Уйский муниципальный район',60.0910580,54.3855650,1,'2019-05-18 14:51:24','2019-05-18 14:51:24'),(26,'Чебаркульский муниципальный район',60.5207130,54.8279980,1,'2019-05-18 14:51:25','2019-05-18 14:51:25'),(27,'Чесменский муниципальный район',60.5706960,53.7258610,1,'2019-05-18 14:51:25','2019-05-18 14:51:25'),(28,'Верхнеуфалейский городской округ',60.2319500,56.0487210,1,'2019-05-18 14:58:20','2019-05-18 14:58:20'),(29,'Златоустовский городской округ',59.6724250,55.1731080,1,'2019-05-18 14:58:20','2019-05-18 14:58:20'),(30,'Карабашский городской округ',60.2030420,55.4907890,1,'2019-05-18 14:58:21','2019-05-18 14:58:21'),(31,'Копейский городской округ',61.6179700,55.1167320,1,'2019-05-18 14:58:21','2019-05-18 14:58:21'),(32,'Кыштымский городской округ',60.5389490,55.7078770,1,'2019-05-18 14:58:22','2019-05-18 14:58:22'),(33,'Локомотивный городской округ',60.6139230,53.0452210,1,'2019-05-18 14:58:22','2019-05-18 14:58:22'),(34,'Магнитогорский городской округ',58.9802820,53.4071580,1,'2019-05-18 14:58:23','2019-05-18 14:58:23'),(35,'Миасский городской округ',60.1080810,55.0464140,1,'2019-05-18 14:58:23','2019-05-18 14:58:23'),(36,'Озерский городской округ',60.7075990,55.7631840,1,'2019-05-18 14:58:23','2019-05-18 14:58:23'),(37,'Снежинский городской округ',60.7325360,56.0852090,1,'2019-05-18 14:58:24','2019-05-18 14:58:24'),(38,'Трехгорный городской округ',58.4464230,54.8178420,1,'2019-05-18 14:58:24','2019-05-18 14:58:24'),(39,'Троицкий городской округ',61.5597590,54.0832170,1,'2019-05-18 14:58:25','2019-05-18 14:58:25'),(40,'Усть-Катавский городской округ',58.1747000,54.9302890,1,'2019-05-18 14:58:25','2019-05-18 14:58:25'),(41,'Чебаркульский городской округ',60.3701200,54.9777850,1,'2019-05-18 14:58:25','2019-05-18 14:58:25'),(42,'Челябинский городской округ',61.4025540,55.1598970,1,'2019-05-18 14:58:26','2019-05-18 14:58:26'),(43,'Южноуральский городской округ',61.2682290,54.4424550,0,'2019-05-18 14:58:26','2019-05-22 04:51:51');
/*!40000 ALTER TABLE `raions` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `sensors_created_user_id_foreign` (`created_user_id`),
  CONSTRAINT `sensors_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_phone_unique` (`phone`),
  UNIQUE KEY `users_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'Иванов Иван','1234567890','$2y$10$UinZZ0DpOt3BKrrt3odbpeK9rsDXcMvfuU6tFO6VBT.Fg5dXDYRX.','i2buhDy4VFeAddHbaN9XtVGINHaBRnjUifqIxJQ4Q8x0UakU9CPDUj0zTTL0',1,1,NULL,'2019-05-19 12:52:18','2019-05-19 12:52:18');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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
  `cabinet_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SP5_valid` tinyint(1) NOT NULL DEFAULT '1',
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wire_sensor_created_user_id_foreign` (`created_user_id`),
  KEY `wire_sensor_wire_id_foreign` (`wire_id`),
  KEY `wire_sensor_sensor_id_foreign` (`sensor_id`),
  CONSTRAINT `wire_sensor_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wire_sensor_sensor_id_foreign` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`),
  CONSTRAINT `wire_sensor_wire_id_foreign` FOREIGN KEY (`wire_id`) REFERENCES `wires` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wire_sensor`
--

LOCK TABLES `wire_sensor` WRITE;
/*!40000 ALTER TABLE `wire_sensor` DISABLE KEYS */;
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
  `wire_sensor_reglament_id` bigint(20) unsigned NOT NULL,
  `created_user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` tinyint(4) NOT NULL,
  `cabinet_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SP5_valid` tinyint(1) NOT NULL DEFAULT '1',
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wire_sensor_previous_state_created_user_id_foreign` (`created_user_id`),
  KEY `wire_sensor_previous_state_wire_sensor_id_foreign` (`wire_sensor_id`),
  CONSTRAINT `wire_sensor_previous_state_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wire_sensor_previous_state_wire_sensor_id_foreign` FOREIGN KEY (`wire_sensor_id`) REFERENCES `wire_sensor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wire_sensor_previous_state`
--

LOCK TABLES `wire_sensor_previous_state` WRITE;
/*!40000 ALTER TABLE `wire_sensor_previous_state` DISABLE KEYS */;
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
  `sertificate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_fire_safety` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wires_created_user_id_foreign` (`created_user_id`),
  KEY `wires_object_device_id_foreign` (`object_device_id`),
  CONSTRAINT `wires_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `wires_object_device_id_foreign` FOREIGN KEY (`object_device_id`) REFERENCES `object_devices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wires`
--

LOCK TABLES `wires` WRITE;
/*!40000 ALTER TABLE `wires` DISABLE KEYS */;
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

-- Dump completed on 2019-05-23 10:55:09
