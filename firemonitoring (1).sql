-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Окт 10 2019 г., 04:01
-- Версия сервера: 10.1.39-MariaDB
-- Версия PHP: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `firemonitoring`
--

-- --------------------------------------------------------

--
-- Структура таблицы `bti_files`
--

CREATE TABLE `bti_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `bti_files`
--

INSERT INTO `bti_files` (`id`, `object_id`, `created_user_id`, `filename`, `deleted_at`, `created_at`, `updated_at`, `description`) VALUES
(1, 6, 3, 'plan-bti-3.jpg', NULL, '2019-06-24 06:23:04', '2019-06-24 06:23:04', ''),
(2, 6, 3, 'plan-bti-2.jpg', NULL, '2019-06-24 06:23:04', '2019-06-24 06:23:04', ''),
(3, 6, 3, 'plan-bti.jpg', NULL, '2019-06-24 06:23:04', '2019-06-24 06:23:04', ''),
(4, 6, 3, 'plan-bti-3.jpg', '2019-07-30 10:47:41', '2019-07-30 10:00:27', '2019-07-30 10:47:41', 'floor 3'),
(5, 6, 3, 'plan-bti-2.jpg', '2019-07-30 10:47:36', '2019-07-30 10:02:53', '2019-07-30 10:47:36', 'floor 2'),
(6, 6, 3, 'plan-bti.jpg', '2019-07-30 10:45:45', '2019-07-30 10:04:04', '2019-07-30 10:45:45', 'floor 1'),
(7, 6, 3, 'plan-bti.jpg', '2019-07-30 10:51:41', '2019-07-30 10:49:53', '2019-07-30 10:51:41', 'floor 1'),
(8, 4, 3, 'plan-bti.jpg', NULL, '2019-08-15 05:43:53', '2019-08-15 05:43:53', '1 этаж');

-- --------------------------------------------------------

--
-- Структура таблицы `calendar`
--

CREATE TABLE `calendar` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `technic_id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED DEFAULT NULL,
  `work_type` set('repair','reglament','setup') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reglament_dev_type` set('sensor','wire','device') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reglament_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `planned_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `calendar`
--

INSERT INTO `calendar` (`id`, `admin_id`, `technic_id`, `object_id`, `device_id`, `work_type`, `reglament_dev_type`, `reglament_id`, `comment`, `created_at`, `updated_at`, `deleted_at`, `planned_at`) VALUES
(2, 3, 5, 1, NULL, 'setup', NULL, NULL, '', '2019-09-11 13:30:09', '2019-09-11 13:30:09', NULL, '2019-09-11'),
(3, 3, 5, 1, NULL, 'repair', NULL, NULL, '', '2019-09-11 13:30:09', '2019-09-11 13:30:09', NULL, '2019-09-11'),
(4, 3, 5, 1, NULL, 'reglament', NULL, NULL, '', '2019-09-11 13:30:10', '2019-09-11 13:30:10', NULL, '2019-09-11');

-- --------------------------------------------------------

--
-- Структура таблицы `device_alerts`
--

CREATE TABLE `device_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` set('sound','voice','light') COLLATE utf8mb4_unicode_ci NOT NULL,
  `power` double NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_alerts`
--

INSERT INTO `device_alerts` (`id`, `name`, `type`, `power`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`, `instruction`) VALUES
(1, 'AL-S58 (VS-85)', 'sound', 30, 3, NULL, '2019-06-23 09:58:56', '2019-06-23 09:58:56', NULL),
(2, 'Соната-М', 'voice', 3, 3, NULL, '2019-06-23 10:14:15', '2019-06-23 11:04:11', NULL),
(3, 'Свет-1', 'light', 5, 3, NULL, '2019-07-01 06:47:38', '2019-07-01 06:47:38', NULL),
(4, 'al-851', 'sound', 30, 3, '2019-09-13 05:20:43', '2019-09-13 05:14:01', '2019-09-13 05:20:43', '4306649.pdf');

-- --------------------------------------------------------

--
-- Структура таблицы `device_antenna`
--

CREATE TABLE `device_antenna` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_antenna`
--

INSERT INTO `device_antenna` (`id`, `name`, `instruction`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Антенна-1', '/tmp/php9SEp0O', 3, NULL, '2019-06-23 06:44:15', '2019-06-23 07:15:07'),
(2, 'Антенна-2', NULL, 3, '2019-06-23 06:44:45', '2019-06-23 06:44:28', '2019-06-23 06:44:45'),
(3, 'Антенна-22', NULL, 3, NULL, '2019-06-23 06:45:02', '2019-09-13 05:27:24'),
(4, 'Антенна 3', NULL, 3, '2019-08-27 06:56:52', '2019-08-27 06:31:37', '2019-08-27 06:56:52'),
(5, 'Антенна 3', NULL, 3, '2019-08-27 06:42:20', '2019-08-27 06:40:20', '2019-08-27 06:42:20'),
(6, 'Antenna 4', 'dns adguard', 3, '2019-08-27 06:56:49', '2019-08-27 06:48:32', '2019-08-27 06:56:49'),
(7, 'Antenna 5', '084-69-05-19-0012975.pdf', 3, '2019-08-27 06:56:44', '2019-08-27 06:52:21', '2019-08-27 06:56:44'),
(8, 'www', NULL, 3, '2019-09-13 05:27:13', '2019-09-13 05:27:06', '2019-09-13 05:27:13');

-- --------------------------------------------------------

--
-- Структура таблицы `device_antenna_params`
--

CREATE TABLE `device_antenna_params` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `setup_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mast_isset` tinyint(1) NOT NULL DEFAULT '0',
  `mast_height` double(4,2) DEFAULT NULL,
  `cable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_antenna_params`
--

INSERT INTO `device_antenna_params` (`id`, `device_id`, `setup_place`, `mast_isset`, `mast_height`, `cable_type`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 16, 'Roof2', 1, 40.00, 'RK 50', 3, NULL, '2019-07-10 07:24:01', '2019-07-10 08:26:45'),
(3, 68, 'roof', 1, 2.00, 'RK 50', 3, NULL, '2019-09-05 05:41:09', '2019-09-05 05:41:09');

-- --------------------------------------------------------

--
-- Структура таблицы `device_aps`
--

CREATE TABLE `device_aps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wires_count` tinyint(4) NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_aps`
--

INSERT INTO `device_aps` (`id`, `name`, `wires_count`, `instruction`, `created_user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-22 19:02:19', '2019-05-22 19:31:22', '2019-05-22 19:31:22'),
(2, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-22 19:11:52', '2019-05-22 19:31:26', '2019-05-22 19:31:22'),
(3, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-22 19:14:15', '2019-05-22 19:31:31', '2019-05-22 19:31:22'),
(4, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-22 19:31:45', '2019-05-23 04:34:01', '2019-05-22 19:31:22'),
(5, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-23 04:34:18', '2019-05-23 04:36:21', '2019-05-22 19:31:22'),
(6, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-23 04:36:31', '2019-05-23 04:47:52', '2019-05-22 19:31:22'),
(7, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-23 04:46:04', '2019-05-23 04:47:53', '2019-05-22 19:31:22'),
(8, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-23 04:47:00', '2019-05-23 04:47:55', '2019-05-22 19:31:22'),
(9, 'АМП-4', 4, 'amp4.pdf', 3, '2019-05-23 04:47:39', '2019-05-23 08:59:27', NULL),
(10, 'АМП-20', 12, NULL, 3, '2019-05-27 16:47:37', '2019-09-13 05:29:46', NULL),
(11, 'FVG-6', 5, NULL, 3, '2019-06-20 07:19:51', '2019-09-13 05:29:36', '2019-09-13 05:29:36'),
(16, 'qwe', 7, 'Промышленность ЧО', 3, '2019-08-26 10:44:43', '2019-08-27 06:23:18', '2019-08-27 06:23:18'),
(17, 'FVG-6', 6, NULL, 3, '2019-09-13 05:30:22', '2019-09-13 05:30:22', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `device_class`
--

CREATE TABLE `device_class` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_class`
--

INSERT INTO `device_class` (`id`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'РСПИ', 1, '2019-05-22 09:44:41', '2019-05-22 09:47:50'),
(2, 'Охранно-пожарная сигнализация', 1, '2019-05-22 18:19:26', '2019-05-22 18:19:26'),
(3, 'Антенна', 1, '2019-05-27 05:16:49', '2019-05-27 05:16:49');

-- --------------------------------------------------------

--
-- Структура таблицы `device_limitations`
--

CREATE TABLE `device_limitations` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isCritical` tinyint(4) DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tbl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_limitations`
--

INSERT INTO `device_limitations` (`id`, `device_id`, `text`, `isCritical`, `created_user_id`, `created_at`, `updated_at`, `deleted_at`, `tbl_name`) VALUES
(1, 1, 'Недостаток 112', 1, 3, NULL, '2019-09-27 05:39:24', NULL, 'App\\device_antenna'),
(2, 1, 'Недостаток 21', NULL, 3, NULL, '2019-08-07 04:19:28', NULL, 'App\\device_antenna'),
(3, 1, 'Недостаток 3', NULL, 3, '2019-08-07 05:14:37', '2019-08-07 05:14:37', NULL, 'App\\device_antenna'),
(4, 1, 'Недостаток 4', NULL, 3, '2019-08-07 05:15:56', '2019-08-07 05:15:56', NULL, 'App\\device_antenna'),
(5, 1, 'Недостаток 51', NULL, 3, '2019-08-07 05:28:19', '2019-09-16 05:42:00', NULL, 'App\\device_antenna'),
(6, 1, 'Недостаток 6', NULL, 3, '2019-08-07 05:30:40', '2019-08-07 05:56:42', '2019-08-07 05:56:42', 'App\\device_antenna'),
(7, 1, 'Недостаток 7', NULL, 3, '2019-08-07 05:41:41', '2019-08-07 05:56:35', '2019-08-07 05:56:35', 'App\\device_antenna'),
(8, 1, 'Недостаток 8', NULL, 3, '2019-08-07 05:49:08', '2019-08-07 05:55:15', '2019-08-07 05:55:15', 'App\\device_antenna'),
(9, 1, 'Недостаток 8', NULL, 3, '2019-08-07 05:49:08', '2019-08-07 05:54:06', '2019-08-07 05:54:06', 'App\\device_antenna'),
(10, 3, 'Недостаток 1', NULL, 3, '2019-08-07 05:56:59', '2019-08-07 05:56:59', NULL, 'App\\device_antenna'),
(11, 9, 'Недостаток 1', NULL, 3, '2019-08-07 06:03:15', '2019-08-07 06:03:15', NULL, 'App\\device_aps'),
(12, 9, 'Недостаток 2', NULL, 3, '2019-08-07 06:03:15', '2019-08-07 06:03:15', NULL, 'App\\device_aps'),
(13, 9, 'Недостаток 3', NULL, 3, '2019-08-07 06:03:15', '2019-08-07 06:03:15', NULL, 'App\\device_aps'),
(14, 1, 'Неисправность извещателя', NULL, 3, NULL, NULL, NULL, 'App\\Sensor'),
(15, 2, 'Неисправность извещателя', NULL, 3, NULL, NULL, NULL, 'App\\Sensor'),
(16, 3, 'Неисправность извещателя', NULL, 3, NULL, NULL, NULL, 'App\\Sensor'),
(17, 4, 'Неисправность извещателя', NULL, 3, NULL, NULL, NULL, 'App\\Sensor'),
(18, 5, 'Неисправность извещателя', NULL, 3, NULL, NULL, NULL, 'App\\Sensor'),
(19, 6, 'Неисправность извещателя', NULL, 3, NULL, NULL, NULL, 'App\\Sensor'),
(20, 8, 'Неисправность извещателя', NULL, 3, '2019-08-29 12:26:19', '2019-08-29 12:26:19', NULL, 'App\\Sensor'),
(21, 1, 'rrr', NULL, 3, '2019-09-13 05:42:42', '2019-09-13 05:43:29', '2019-09-13 05:43:29', 'App\\Sensor'),
(22, 1, 'qqq', NULL, 3, '2019-09-13 05:43:44', '2019-09-13 05:43:44', NULL, 'App\\Sensor'),
(23, 1, '3', NULL, 3, '2019-09-13 05:48:55', '2019-09-13 05:53:09', NULL, 'App\\device_system_voice_alert'),
(24, 2, 'Недостаток 1', NULL, 3, '2019-09-23 07:17:56', '2019-09-23 07:17:56', NULL, 'App\\device_alert'),
(25, 2, 'Недостаток 2', NULL, 3, '2019-09-23 07:17:59', '2019-09-23 07:17:59', NULL, 'App\\device_alert');

-- --------------------------------------------------------

--
-- Структура таблицы `device_reglament`
--

CREATE TABLE `device_reglament` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day` tinyint(4) DEFAULT NULL,
  `year` tinyint(4) DEFAULT NULL,
  `month` tinyint(4) DEFAULT NULL,
  `week` tinyint(4) DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tbl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_reglament`
--

INSERT INTO `device_reglament` (`id`, `name`, `day`, `year`, `month`, `week`, `created_user_id`, `device_id`, `created_at`, `updated_at`, `deleted_at`, `tbl_name`, `duration`) VALUES
(63, 'Ежемесячный', NULL, NULL, 1, NULL, 3, 9, '2019-08-20 08:22:08', '2019-08-21 08:28:12', '2019-08-21 08:28:12', 'App\\device_aps', 0),
(64, 'Еженедельный', NULL, NULL, NULL, NULL, 3, 9, '2019-08-20 08:22:56', '2019-08-21 08:28:14', '2019-08-21 08:28:14', 'App\\device_aps', 0),
(65, '1', 1, NULL, NULL, NULL, 3, 9, '2019-08-20 08:26:18', '2019-08-21 08:28:16', '2019-08-21 08:28:16', 'App\\device_aps', 0),
(66, '2', 2, NULL, NULL, NULL, 3, 9, '2019-08-20 08:26:59', '2019-08-21 08:28:18', '2019-08-21 08:28:18', 'App\\device_aps', 0),
(67, '3', NULL, NULL, NULL, NULL, 3, 9, '2019-08-20 08:27:38', '2019-08-21 08:28:20', '2019-08-21 08:28:20', 'App\\device_aps', 0),
(68, '1', NULL, NULL, NULL, NULL, 3, 1, '2019-08-20 08:31:09', '2019-08-20 08:35:33', '2019-08-20 08:35:33', 'App\\device_antenna', 0),
(69, '2', NULL, NULL, NULL, NULL, 3, 1, '2019-08-20 08:33:22', '2019-08-20 08:35:31', '2019-08-20 08:35:31', 'App\\device_antenna', 0),
(70, '1', NULL, NULL, NULL, 2, 3, 1, '2019-08-20 08:35:53', '2019-09-16 04:50:07', NULL, 'App\\device_antenna', 10),
(71, '2', NULL, NULL, NULL, NULL, 3, 1, '2019-08-20 08:36:45', '2019-08-20 08:36:45', NULL, 'App\\device_antenna', 0),
(72, '3', NULL, NULL, NULL, NULL, 3, 1, '2019-08-20 08:37:53', '2019-08-20 08:37:53', NULL, 'App\\device_antenna', 0),
(73, '4', NULL, NULL, NULL, NULL, 3, 9, '2019-08-20 08:39:14', '2019-08-21 08:28:21', '2019-08-21 08:28:21', 'App\\device_aps', 0),
(74, '5', NULL, NULL, NULL, 2, 3, 9, '2019-08-20 08:39:50', '2019-08-21 09:39:26', NULL, 'App\\device_aps', 0),
(75, '4', NULL, NULL, NULL, NULL, 3, 1, '2019-08-20 08:41:01', '2019-08-20 08:41:01', NULL, 'App\\device_antenna', 0),
(76, '5', NULL, NULL, NULL, NULL, 3, 1, '2019-08-20 08:42:58', '2019-08-20 08:42:58', NULL, 'App\\device_antenna', 0),
(77, '6', NULL, NULL, NULL, NULL, 3, 1, '2019-08-20 08:49:23', '2019-08-20 08:49:23', NULL, 'App\\device_antenna', 0),
(78, '7', NULL, NULL, NULL, 2, 3, 1, '2019-08-20 08:51:17', '2019-08-20 08:51:31', NULL, 'App\\device_antenna', 0),
(79, 'test', NULL, NULL, 2, NULL, 3, 9, '2019-08-21 09:41:14', '2019-08-21 09:41:14', NULL, 'App\\device_aps', 0),
(80, 'Test', NULL, NULL, NULL, 2, 3, 1, '2019-08-29 11:15:50', '2019-08-29 11:15:50', NULL, 'App\\Sensor', 0),
(81, 'asd reglament 1', NULL, NULL, NULL, 2, 3, 1, '2019-09-13 06:02:45', '2019-09-13 06:02:45', NULL, 'App\\Sensor', 0),
(82, 'Ежемесячный', NULL, NULL, 1, NULL, 3, 2, '2019-09-23 07:18:50', '2019-09-23 07:18:50', NULL, 'App\\device_alert', 50);

-- --------------------------------------------------------

--
-- Структура таблицы `device_reglament_element`
--

CREATE TABLE `device_reglament_element` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_reglament_id` smallint(5) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_reglament_element`
--

INSERT INTO `device_reglament_element` (`id`, `text`, `device_reglament_id`, `created_user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(23, 'Сделать то', 63, 3, '2019-08-20 08:22:40', '2019-08-21 08:28:12', '2019-08-21 08:28:12'),
(24, '1', 74, 3, '2019-08-20 08:39:52', '2019-08-20 08:39:52', NULL),
(25, '2', 74, 3, '2019-08-20 08:39:52', '2019-08-20 08:39:52', NULL),
(26, '2', 75, 3, '2019-08-20 08:41:11', '2019-08-20 08:41:11', NULL),
(27, '3', 75, 3, '2019-08-20 08:41:11', '2019-08-20 08:41:11', NULL),
(28, '1', 76, 3, '2019-08-20 08:43:00', '2019-08-20 08:43:00', NULL),
(29, '2', 76, 3, '2019-08-20 08:43:09', '2019-08-20 08:43:09', NULL),
(30, '3', 76, 3, '2019-08-20 08:45:28', '2019-08-20 08:45:28', NULL),
(31, '4', 76, 3, '2019-08-20 08:49:05', '2019-08-20 08:49:05', NULL),
(32, '3', 76, 3, '2019-08-20 08:49:05', '2019-08-20 08:49:05', NULL),
(33, '1', 77, 3, '2019-08-20 08:49:29', '2019-08-20 08:49:29', NULL),
(34, '1', 78, 3, '2019-08-20 08:51:19', '2019-08-20 08:51:19', NULL),
(35, '2', 78, 3, '2019-08-20 08:51:23', '2019-08-20 08:51:23', NULL),
(36, 'Работа 1', 79, 3, '2019-08-21 09:41:14', '2019-08-21 09:41:14', NULL),
(37, 'Работа 2', 79, 3, '2019-08-21 09:41:14', '2019-08-21 09:41:14', NULL),
(38, '222', 80, 3, '2019-08-29 11:15:51', '2019-08-29 11:15:51', NULL),
(39, '111', 80, 3, '2019-08-29 11:15:51', '2019-08-29 11:15:51', NULL),
(40, 'option 1', 81, 3, '2019-09-13 06:03:11', '2019-09-13 06:03:11', NULL),
(41, 'option 2', 81, 3, '2019-09-13 06:03:11', '2019-09-13 06:03:11', NULL),
(42, 'option 35', 81, 3, '2019-09-13 06:03:11', '2019-09-13 06:03:53', NULL),
(43, 'Работа 2', 82, 3, '2019-09-23 07:18:51', '2019-09-23 07:18:51', NULL),
(44, 'Работа 1', 82, 3, '2019-09-23 07:18:51', '2019-09-23 07:18:51', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `device_rspi`
--

CREATE TABLE `device_rspi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_rspi`
--

INSERT INTO `device_rspi` (`id`, `name`, `instruction`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'ffgg-up-1', 'Таблиа общих сведений по АПС.xlsx', 3, NULL, '2019-06-23 07:06:16', '2019-06-23 07:43:27'),
(2, 'РСПИ-2-1', 'ResearchPal.zip', 3, '2019-06-23 07:45:47', '2019-06-23 07:44:10', '2019-06-23 07:45:47'),
(3, 'РСПИ-1', 'Таблиа общих сведений по АПС.xlsx', 3, NULL, '2019-06-23 08:03:21', '2019-06-23 08:03:21'),
(4, 'РСПИ-2', 'Таблиа общих сведений по АПС.xlsx', 3, '2019-06-23 08:04:45', '2019-06-23 08:04:03', '2019-06-23 08:04:45'),
(5, 'РСПИ-2', 'Таблиа общих сведений по АПС.xlsx', 3, NULL, '2019-06-23 08:04:56', '2019-06-23 08:04:56'),
(6, 'РСПИ 32', 'dns adguard', 3, NULL, '2019-08-27 06:57:06', '2019-09-13 05:25:39'),
(7, 'fff', NULL, 3, '2019-09-13 05:25:34', '2019-09-13 05:25:28', '2019-09-13 05:25:34');

-- --------------------------------------------------------

--
-- Структура таблицы `device_rspi_params`
--

CREATE TABLE `device_rspi_params` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `setup_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `battery` tinyint(1) NOT NULL,
  `power_supply` tinyint(1) NOT NULL,
  `capacity` double(8,2) DEFAULT NULL,
  `coupling` set('fire','fault') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_rspi_params`
--

INSERT INTO `device_rspi_params` (`id`, `setup_place`, `battery`, `power_supply`, `capacity`, `coupling`, `created_user_id`, `device_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, '1 cabinet', 0, 0, 600.00, 'fault', 3, 17, NULL, '2019-07-25 07:42:55', '2019-07-25 07:47:30'),
(4, 'cabinet 1', 1, 1, 120.00, 'fire', 3, 70, NULL, '2019-09-05 05:58:31', '2019-09-05 05:58:31');

-- --------------------------------------------------------

--
-- Структура таблицы `device_system_voice_alerts`
--

CREATE TABLE `device_system_voice_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_system_voice_alerts`
--

INSERT INTO `device_system_voice_alerts` (`id`, `name`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`, `instruction`) VALUES
(1, 'СРО-12', 3, NULL, '2019-06-23 07:59:03', '2019-06-23 08:00:17', 'Таблиа общих сведений по АПС.xlsx'),
(2, 'СРО-25', 3, NULL, '2019-06-23 08:00:48', '2019-09-13 05:22:06', 'Таблиа общих сведений по АПС.xlsx'),
(3, 'СРО-3-2', 3, '2019-09-13 05:21:30', '2019-06-23 08:02:16', '2019-09-13 05:21:30', 'Промышленность ЧО'),
(4, 'rrr', 3, NULL, '2019-09-13 05:24:32', '2019-09-13 05:24:32', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `device_system_voice_alerts_devs`
--

CREATE TABLE `device_system_voice_alerts_devs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `device_system_voice_alerts_id` bigint(20) UNSIGNED NOT NULL,
  `device_alerts_id` bigint(20) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bti_files_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_system_voice_alerts_devs`
--

INSERT INTO `device_system_voice_alerts_devs` (`id`, `device_system_voice_alerts_id`, `device_alerts_id`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`, `bti_files_id`, `lng`, `lat`) VALUES
(3, 19, 1, 3, NULL, '2019-07-16 11:00:54', '2019-08-07 10:40:49', 1, '179.9549702', '-176.0000000');

-- --------------------------------------------------------

--
-- Структура таблицы `districts`
--

CREATE TABLE `districts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `districts`
--

INSERT INTO `districts` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Калининский', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `districtsobjects`
--

CREATE TABLE `districtsobjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `districtsusers`
--

CREATE TABLE `districtsusers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_05_15_055415_raions', 2),
(4, '2019_05_15_060541_objects', 2),
(7, '2019_05_15_060035_device_class', 3),
(8, '2019_05_15_061317_devices', 4),
(9, '2019_05_15_061835_device_reglament', 4),
(10, '2019_05_15_065432_device_reglament_element', 5),
(11, '2019_05_15_065712_device_limitations', 6),
(12, '2019_05_15_065946_object_devices', 7),
(13, '2019_05_15_070921_wires', 7),
(15, '2019_05_15_071538_sensors', 8),
(16, '2019_05_15_080205_wire_sensor', 9),
(17, '2019_05_15_080205_wire_sensor_previous_state', 10),
(18, '2019_05_15_081024_wire_sensor_reglament', 10),
(19, '2019_05_15_081306_wire_previous_state', 10),
(20, '2019_05_15_082055_object_device_reglament', 11),
(21, '2019_05_15_082057_object_device_reglament_limitations', 12),
(22, '2019_05_15_083012_object_repair_queue', 12),
(23, '2019_05_15_084106_calendar', 12),
(24, '2019_05_19_121046_user', 13),
(25, '2016_06_01_000001_create_oauth_auth_codes_table', 14),
(26, '2016_06_01_000002_create_oauth_access_tokens_table', 14),
(27, '2016_06_01_000003_create_oauth_refresh_tokens_table', 14),
(28, '2016_06_01_000004_create_oauth_clients_table', 14),
(29, '2016_06_01_000005_create_oauth_personal_access_clients_table', 14),
(31, '2019_05_26_091713_add_objects_documentation', 15),
(32, '2019_05_27_110628_change_device', 16),
(33, '2019_06_07_110528_add_sensor_name', 17),
(34, '2019_06_10_080205_wire_sensor_previous_state_change', 18),
(35, '2019_06_10_225405_user_add_raion', 19),
(36, '2019_06_12_091544_wire_sensor_add_comment', 19),
(37, '2019_06_12_151353_mediafiles_for_object', 20),
(38, '2019_06_13_064804_add_setup_place_device', 21),
(39, '2019_06_15_124504_create_device_rspis_table', 22),
(40, '2019_06_15_124534_create_device_antennas_table', 22),
(41, '2019_06_15_124544_create_device_aps_table', 22),
(42, '2019_06_15_124555_create_device_alerts_table', 22),
(43, '2019_06_15_213344_object_add_souetype', 23),
(44, '2019_06_16_082729_create_device_system_voice_alerts_table', 23),
(45, '2019_06_19_070206_create_device_system_voice_alerts_devs_table', 24),
(46, '2019_06_19_080458_device_aps_softdelete', 24),
(47, '2019_06_19_084014_od_device_tabl', 25),
(48, '2019_06_23_084014_as_device_tbl_chng', 26),
(49, '2019_06_23_112635_create_bti_files_table', 27),
(50, '2019_06_09_044231_users_add_fk_raions', 28),
(51, '2019_07_04_065531_wiresensor_add_soft_delete', 29),
(52, '2019_07_04_112337_wiresensor_add_lonlat', 30),
(53, '2019_07_10_065258_change_antenna_cable', 31),
(54, '2019_07_01_071526_add_od_ll', 32),
(55, '2019_07_16_120204_d_s_v_a_d_add_params', 32),
(56, '2019_07_25_075351_add__o_d_isgood', 33),
(57, '2019_10_09_140955_create_districts_table', 34);

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('3ecbc4ac564bfa299f18e75082da23be0c6bcd190b4d4962d7af1cebda4584e6c9a337c9c07f9424', 3, 1, 'MyApp', '[]', 0, '2019-05-21 18:40:30', '2019-05-21 18:40:30', '2020-05-21 18:40:30'),
('bacded2c5923ef0d2f7196afcb09a67bbb5e56d05d9bf3e5a31e82cb9deb3e579bef7f078e7a5aae', 3, 1, 'MyApp', '[]', 0, '2019-05-21 10:11:58', '2019-05-21 10:11:58', '2020-05-21 10:11:58');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'firemonitoring Personal Access Client', 'fhazxWx3qD5M2Kdobe8adxjSHswsfIVdJ9jegjUS', 'http://localhost', 1, 0, 0, '2019-05-21 09:40:24', '2019-05-21 09:40:24'),
(2, NULL, 'firemonitoring Password Grant Client', '52L7wvgVG9SFw5avqLsW6JHJCvAfycqkyk1wVWeM', 'http://localhost', 0, 1, 0, '2019-05-21 09:40:24', '2019-05-21 09:40:24'),
(3, NULL, 'Firemonitoring Personal Access Client', 'yr4iEvEQ92s4g5yiHk48AD78k5UnYuUo7Yhhmzlm', 'http://localhost', 1, 0, 0, '2019-10-09 05:30:46', '2019-10-09 05:30:46'),
(4, NULL, 'Firemonitoring Password Grant Client', 'yXrv0AUhE0xMoHHC6gmNIV53Au2TbrEuHaynNgR3', 'http://localhost', 0, 1, 0, '2019-10-09 05:30:46', '2019-10-09 05:30:46');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-05-21 09:40:24', '2019-05-21 09:40:24'),
(2, 3, '2019-10-09 05:30:46', '2019-10-09 05:30:46');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `objects`
--

CREATE TABLE `objects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `raion_id` bigint(20) UNSIGNED NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` decimal(10,7) NOT NULL,
  `lat` decimal(10,7) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `director_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `director_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project_isset` tinyint(1) DEFAULT '0',
  `project_cipher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_year` year(4) DEFAULT NULL,
  `soue_type` set('1','2','3','4','5') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `objects`
--

INSERT INTO `objects` (`id`, `name`, `raion_id`, `address`, `lng`, `lat`, `is_active`, `contact_name`, `contact_phone`, `director_name`, `director_phone`, `created_user_id`, `created_at`, `updated_at`, `project_isset`, `project_cipher`, `project_year`, `soue_type`, `deleted_at`) VALUES
(1, 'Детский сад', 42, 'Сталеваров 16', '61.4012117', '55.2661825', 1, 'Петров', '654321', 'Иванов', '123456', NULL, '2019-05-19 17:18:00', '2019-09-05 06:14:06', 0, NULL, NULL, '1', NULL),
(4, 'кккк', 42, 'Пушкина 68', '61.4096140', '55.1567490', 1, 'ЕЕЕ', '645', 'РРР', '123', NULL, '2019-05-19 17:54:28', '2019-05-19 17:54:28', 0, NULL, NULL, '1', NULL),
(5, 'Иванов Иван', 1, 'erwer', '58.2225649', '54.6835573', 1, 'qwerea', '2342', 'werw', '23423', 3, '2019-05-22 08:49:40', '2019-08-15 07:57:01', 1, NULL, 1987, '1', NULL),
(6, 'Школа №70', 42, '60 лет Октября, 46', '61.3828879', '55.2625390', 1, 'аврвар', '456456', 'првар', '45645', 3, '2019-05-26 11:23:19', '2019-09-07 17:25:59', 1, 'ш-21б-56', 2010, '3', NULL),
(7, 'Детский сад \"Березка\"', 1, 'с. Агаповка , ул Советская, 45', '59.1301774', '53.2955676', 1, 'Петров Петр', '123456', 'Иванов Иван', '123456', 3, '2019-07-26 10:14:32', '2019-07-26 10:14:32', 1, 'Ш-125-1987', 1984, '1', NULL),
(13, 'test', 2, 'г Челябинск, ул Невская', '61.2618009', '55.1549263', 1, 'qwerea', '1231', 'wefa', '123123', 3, '2019-09-12 17:57:31', '2019-10-09 06:17:28', 1, NULL, 0000, '1,2', '2019-10-09 06:17:28'),
(14, 'test', 2, 'г Челябинск, ул Невская', '61.2618009', '55.1549263', 1, 'qwerea', '1231', 'wefa', '123123', 3, '2019-09-12 17:58:40', '2019-10-09 06:17:27', 1, NULL, 0000, '1,2', '2019-10-09 06:17:27'),
(15, 'test', 2, 'г Челябинск, ул Невская', '61.2618009', '55.1549263', 1, 'qwerea', '1231', 'wefa', '123123', 3, '2019-09-12 17:59:00', '2019-10-09 06:17:26', 1, NULL, 0000, '1,2', '2019-10-09 06:17:26'),
(16, 'test', 2, 'г Челябинск, ул Невская', '61.2618009', '55.1549263', 1, 'qwerea', '1231', 'wefa', '123123', 3, '2019-09-12 17:59:24', '2019-10-09 06:17:25', 1, NULL, 0000, '1,2', '2019-10-09 06:17:25'),
(17, 'test', 2, 'г Челябинск, ул Невская', '61.2618009', '55.1549263', 1, 'qwerea', '1231', 'wefa', '123123', 3, '2019-09-12 17:59:37', '2019-10-09 06:17:23', 1, NULL, 0000, '1,2', '2019-10-09 06:17:23'),
(18, 'test', 2, 'г Челябинск, ул Невская', '61.2618009', '55.1549263', 1, 'qwerea', '1231', 'wefa', '123123', 3, '2019-09-12 18:00:11', '2019-10-09 06:17:20', 1, NULL, 0000, '1,2', '2019-10-09 06:17:20'),
(19, 'test', 42, 'г Челябинск, ул Невская', '61.2618009', '55.1549263', 1, 'qwerea', '1231', 'werw', '123123', 3, '2019-09-12 18:02:11', '2019-10-09 06:17:08', 1, NULL, 0000, '3', '2019-10-09 06:17:08'),
(20, 'Иванов Иван', 2, 'Челябинская обл, село Аргаяш', '60.8761286', '55.4885837', 1, 'sfasdf', '1231', 'Иванов Иван', '123123', 3, '2019-09-12 18:05:00', '2019-10-09 06:17:19', 1, NULL, 0000, '1,2', '2019-10-09 06:17:19'),
(21, 'test', 42, 'г Челябинск, наб Николая Патоличева', '61.4008078', '55.1602624', 1, 'qwerea', '1231', 'werw', '123123', 3, '2019-09-12 18:13:22', '2019-10-09 06:17:21', 1, NULL, 0000, '1,2', '2019-10-09 06:17:21'),
(22, 'test', 2, 'г Челябинск, ул Некрасовская', '61.3432421', '55.1115275', 1, 'sfasdf', '123456', 'Иванов Иван', '123123', 3, '2019-09-12 18:15:01', '2019-10-09 06:17:17', 1, 'Ш-125-1987', 1987, '2', '2019-10-09 06:17:17'),
(23, 'test', 2, 'г Челябинск, ул Неглинная', '61.3632015', '55.1879987', 1, 'sfasdf', '123456', 'wefa', '123123', 3, '2019-09-12 18:17:00', '2019-09-13 03:36:06', 1, NULL, 0000, '3', '2019-09-13 03:36:06'),
(24, 'test', 2, 'Челябинская обл, село Аргаяш', '60.8761286', '55.4885837', 1, 'qwerea', '1231', 'wefa', '123123', 3, '2019-09-12 18:21:08', '2019-09-13 03:35:21', 1, NULL, 0000, '1,2', '2019-09-13 03:35:21');

-- --------------------------------------------------------

--
-- Структура таблицы `objects_mediafiles`
--

CREATE TABLE `objects_mediafiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `objects_mediafiles`
--

INSERT INTO `objects_mediafiles` (`id`, `object_id`, `filename`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 6, '084-69-05-19-0012975.pdf', '084-69-05-19-0012975.pdf', '2019-06-13 05:32:29', '2019-06-13 05:32:29', NULL),
(3, 6, '084-69-05-19-0012975.pdf', 'Русский текст', '2019-06-13 05:33:20', '2019-06-13 05:33:20', NULL),
(4, 6, '084-69-05-19-0012975.pdf', '084-69-05-19-0012975.pdf', '2019-06-13 05:40:34', '2019-06-13 05:40:34', NULL),
(5, 6, 'Таблиа общих сведений по АПС.xlsx', 'Ntcn', '2019-06-19 07:27:08', '2019-06-19 07:27:08', NULL),
(6, 6, 'Таблиа общих сведений по АПС.xlsx', '123', '2019-06-19 07:29:49', '2019-06-19 07:29:49', NULL),
(7, 6, 'plan-bti.jpg', 'План 1го этажа', '2019-07-30 08:45:40', '2019-07-30 10:47:50', '2019-07-30 10:47:50'),
(8, 6, 'plan-bti-2.jpg', 'План 2го этажа', '2019-07-30 10:04:18', '2019-07-30 10:47:47', '2019-07-30 10:47:47'),
(9, 6, 'plan-bti.jpg', 'floor 1', '2019-07-30 10:51:52', '2019-07-30 10:51:57', '2019-07-30 10:51:57');

-- --------------------------------------------------------

--
-- Структура таблицы `object_devices`
--

CREATE TABLE `object_devices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `setup_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tbl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `bti_files_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `is_good` tinyint(1) DEFAULT '1',
  `setup_year` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `object_devices`
--

INSERT INTO `object_devices` (`id`, `object_id`, `device_id`, `parent_id`, `created_user_id`, `created_at`, `updated_at`, `setup_place`, `tbl_name`, `deleted_at`, `bti_files_id`, `lng`, `lat`, `is_good`, `setup_year`) VALUES
(1, 6, 9, NULL, 3, '2019-05-27 17:05:27', '2019-09-03 10:03:25', '', 'App\\device_aps', '2019-09-03 10:03:25', 1, '234.9871043', '-184.1250000', 0, NULL),
(13, 6, 9, NULL, 3, '2019-06-19 08:31:43', '2019-09-03 10:02:50', '', 'App\\device_aps', '2019-09-03 10:02:50', 3, '41.3594979', '-98.8750000', 0, NULL),
(14, 6, 10, NULL, 3, '2019-06-20 06:24:46', '2019-06-20 06:28:16', '', 'App\\device_aps', '2019-06-20 06:28:16', 0, '0.0000000', '0.0000000', 1, NULL),
(15, 6, 10, NULL, 3, '2019-06-20 06:28:19', '2019-09-04 13:33:21', '', 'App\\device_aps', '2019-09-04 13:33:21', 1, '59.8525665', '-119.0000000', 1, NULL),
(16, 6, 1, NULL, 3, '2019-06-28 06:49:25', '2019-09-04 13:33:50', '', 'App\\device_antenna', '2019-09-04 13:33:50', 1, '127.9245888', '-182.8750000', 1, NULL),
(17, 6, 3, NULL, 3, '2019-06-28 07:08:08', '2019-10-09 07:05:29', '', 'App\\device_rspi', NULL, 1, '32.8690844', '-183.8750000', 1, 2014),
(18, 6, 1, NULL, 3, '2019-06-28 07:08:14', '2019-08-07 10:40:33', '', 'App\\device_alert', NULL, 1, '97.9070611', '-229.0000000', 1, NULL),
(19, 6, 1, NULL, 3, '2019-06-28 07:08:21', '2019-08-07 10:40:04', '', 'App\\device_system_voice_alert', NULL, 1, '37.3717136', '-296.2500000', 1, NULL),
(20, 6, 3, NULL, 3, '2019-07-01 11:01:33', '2019-08-07 10:40:37', '', 'App\\device_alert', NULL, 1, '182.4564308', '-214.5000000', 1, NULL),
(21, 6, 2, NULL, 3, '2019-07-01 11:01:40', '2019-08-07 10:40:43', '', 'App\\device_alert', NULL, 1, '99.4079375', '-281.0000000', 1, NULL),
(22, 4, 9, NULL, 3, '2019-08-15 05:20:47', '2019-08-15 05:20:47', '', 'App\\device_aps', NULL, NULL, NULL, NULL, 1, NULL),
(23, 4, 1, NULL, 3, '2019-08-15 05:26:20', '2019-08-15 06:02:09', '', 'App\\device_antenna', NULL, NULL, NULL, NULL, 0, NULL),
(24, 1, 9, NULL, 3, '2019-08-18 10:09:16', '2019-09-04 13:16:55', '', 'App\\device_aps', '2019-09-04 13:16:55', NULL, NULL, NULL, 1, NULL),
(28, 6, 1, NULL, 3, '2019-09-03 09:58:27', '2019-09-03 10:01:56', '', 'App\\device_antenna', '2019-09-03 10:01:56', NULL, NULL, NULL, 1, NULL),
(29, 6, 9, NULL, 3, '2019-09-03 10:05:09', '2019-09-03 10:16:12', '', 'App\\device_aps', '2019-09-03 10:16:12', NULL, NULL, NULL, 1, NULL),
(30, 6, 9, NULL, 3, '2019-09-03 10:16:21', '2019-09-03 11:48:39', '', 'App\\device_aps', '2019-09-03 11:48:39', NULL, NULL, NULL, 1, NULL),
(31, 6, 9, NULL, 3, '2019-09-03 10:49:10', '2019-09-03 11:49:48', '', 'App\\device_aps', '2019-09-03 11:49:48', NULL, NULL, NULL, 1, NULL),
(32, 6, 9, NULL, 3, '2019-09-03 11:04:35', '2019-09-03 11:49:48', '', 'App\\device_aps', '2019-09-03 11:49:48', NULL, NULL, NULL, 1, NULL),
(33, 6, 9, NULL, 3, '2019-09-03 11:37:32', '2019-09-03 11:49:48', '', 'App\\device_aps', '2019-09-03 11:49:48', NULL, NULL, NULL, 1, NULL),
(34, 6, 9, NULL, 3, '2019-09-03 11:41:49', '2019-09-03 11:49:51', '', 'App\\device_aps', '2019-09-03 11:49:51', NULL, NULL, NULL, 1, NULL),
(35, 6, 9, NULL, 3, '2019-09-03 11:44:21', '2019-09-03 11:49:52', '', 'App\\device_aps', '2019-09-03 11:49:52', NULL, NULL, NULL, 1, NULL),
(36, 6, 9, NULL, 3, '2019-09-03 11:48:06', '2019-09-03 11:49:53', '', 'App\\device_aps', '2019-09-03 11:49:53', NULL, NULL, NULL, 1, NULL),
(37, 6, 9, NULL, 3, '2019-09-03 11:50:12', '2019-09-04 12:08:10', '', 'App\\device_aps', '2019-09-04 12:08:10', NULL, NULL, NULL, 1, NULL),
(38, 6, 9, NULL, 3, '2019-09-04 11:14:18', '2019-09-04 12:35:22', '', 'App\\device_aps', '2019-09-04 12:35:22', NULL, NULL, NULL, 1, NULL),
(39, 6, 9, NULL, 3, '2019-09-04 11:58:53', '2019-09-04 12:35:14', '', 'App\\device_aps', '2019-09-04 12:35:14', NULL, NULL, NULL, 1, NULL),
(40, 6, 9, NULL, 3, '2019-09-04 12:01:03', '2019-09-04 12:34:10', '', 'App\\device_aps', '2019-09-04 12:34:10', NULL, NULL, NULL, 1, NULL),
(41, 6, 9, NULL, 3, '2019-09-04 12:05:28', '2019-09-04 12:35:08', '', 'App\\device_aps', '2019-09-04 12:35:08', NULL, NULL, NULL, 1, NULL),
(42, 6, 9, NULL, 3, '2019-09-04 12:06:24', '2019-09-04 12:30:52', '', 'App\\device_aps', '2019-09-04 12:30:52', NULL, NULL, NULL, 1, NULL),
(43, 6, 9, NULL, 3, '2019-09-04 12:06:56', '2019-09-04 12:28:14', '', 'App\\device_aps', '2019-09-04 12:28:14', NULL, NULL, NULL, 1, NULL),
(44, 6, 9, NULL, 3, '2019-09-04 12:07:42', '2019-09-04 12:24:48', '', 'App\\device_aps', '2019-09-04 12:24:48', NULL, NULL, NULL, 1, NULL),
(45, 6, 9, NULL, 3, '2019-09-04 12:45:18', '2019-09-13 06:20:08', '', 'App\\device_aps', NULL, 1, '237.2994145', '-302.6666641', 1, NULL),
(46, 6, 9, NULL, 3, '2019-09-04 13:05:14', '2019-09-04 13:10:58', '', 'App\\device_aps', '2019-09-04 13:10:58', NULL, NULL, NULL, 1, NULL),
(47, 1, 9, NULL, 3, '2019-09-04 13:17:02', '2019-09-04 13:34:03', '', 'App\\device_aps', '2019-09-04 13:34:03', NULL, NULL, NULL, 1, NULL),
(48, 1, 9, NULL, 3, '2019-09-04 13:17:37', '2019-09-04 13:21:43', '', 'App\\device_aps', '2019-09-04 13:21:43', NULL, NULL, NULL, 1, NULL),
(49, 1, 9, NULL, 3, '2019-09-04 13:33:10', '2019-09-04 13:34:06', '', 'App\\device_aps', '2019-09-04 13:34:06', NULL, NULL, NULL, 1, NULL),
(50, 1, 9, NULL, 3, '2019-09-04 13:33:26', '2019-09-04 13:34:09', '', 'App\\device_aps', '2019-09-04 13:34:09', NULL, NULL, NULL, 1, NULL),
(51, 1, 9, NULL, 3, '2019-09-04 13:33:38', '2019-09-04 13:34:11', '', 'App\\device_aps', '2019-09-04 13:34:11', NULL, NULL, NULL, 1, NULL),
(52, 1, 9, NULL, 3, '2019-09-04 13:34:18', '2019-09-04 13:40:20', '', 'App\\device_aps', '2019-09-04 13:40:20', NULL, NULL, NULL, 1, NULL),
(53, 1, 9, NULL, 3, '2019-09-04 13:36:27', '2019-09-04 13:40:17', '', 'App\\device_aps', '2019-09-04 13:40:17', NULL, NULL, NULL, 1, NULL),
(54, 1, 9, NULL, 3, '2019-09-04 13:39:31', '2019-09-04 13:40:14', '', 'App\\device_aps', '2019-09-04 13:40:14', NULL, NULL, NULL, 1, NULL),
(55, 1, 9, NULL, 3, '2019-09-04 13:39:57', '2019-09-04 13:40:11', '', 'App\\device_aps', '2019-09-04 13:40:11', NULL, NULL, NULL, 1, NULL),
(56, 1, 9, NULL, 3, '2019-09-04 13:40:24', '2019-09-04 13:40:50', '', 'App\\device_aps', '2019-09-04 13:40:50', NULL, NULL, NULL, 1, NULL),
(57, 1, 9, NULL, 3, '2019-09-04 13:40:27', '2019-09-23 07:04:53', '', 'App\\device_aps', '2019-09-23 07:04:53', NULL, NULL, NULL, 1, NULL),
(58, 1, 9, NULL, 3, '2019-09-04 13:40:46', '2019-09-05 05:35:01', '', 'App\\device_aps', '2019-09-05 05:35:01', NULL, NULL, NULL, 1, NULL),
(59, 1, 9, NULL, 3, '2019-09-04 13:40:53', '2019-09-05 05:34:55', '', 'App\\device_aps', '2019-09-05 05:34:55', NULL, NULL, NULL, 1, NULL),
(60, 1, 9, NULL, 3, '2019-09-04 13:51:56', '2019-09-05 05:34:58', '', 'App\\device_aps', '2019-09-05 05:34:58', NULL, NULL, NULL, 1, NULL),
(61, 6, 9, NULL, 3, '2019-09-04 15:29:24', '2019-09-05 05:24:59', '', 'App\\device_aps', '2019-09-05 05:24:59', NULL, NULL, NULL, 1, NULL),
(62, 6, 9, NULL, 3, '2019-09-04 15:39:26', '2019-09-05 05:24:57', '', 'App\\device_aps', '2019-09-05 05:24:57', NULL, NULL, NULL, 1, NULL),
(63, 6, 9, NULL, 3, '2019-09-04 15:45:25', '2019-09-05 05:24:55', '', 'App\\device_aps', '2019-09-05 05:24:55', NULL, NULL, NULL, 1, NULL),
(64, 6, 9, NULL, 3, '2019-09-05 05:25:02', '2019-09-13 06:21:32', '', 'App\\device_aps', NULL, 1, '195.7828469', '-302.2333298', 1, NULL),
(65, 1, 10, NULL, 3, '2019-09-05 05:31:53', '2019-09-05 05:34:53', '', 'App\\device_aps', '2019-09-05 05:34:53', NULL, NULL, NULL, 1, NULL),
(66, 1, 10, NULL, 3, '2019-09-05 05:35:04', '2019-09-23 07:04:57', '', 'App\\device_aps', '2019-09-23 07:04:57', NULL, NULL, NULL, 1, NULL),
(67, 1, 10, NULL, 3, '2019-09-05 05:39:02', '2019-09-05 05:39:17', '', 'App\\device_aps', '2019-09-05 05:39:17', NULL, NULL, NULL, 1, NULL),
(68, 1, 1, NULL, 3, '2019-09-05 05:40:30', '2019-09-23 07:05:00', '', 'App\\device_antenna', '2019-09-23 07:05:00', NULL, NULL, NULL, 1, NULL),
(69, 6, 1, NULL, 3, '2019-09-05 05:48:35', '2019-09-18 05:32:18', '', 'App\\device_antenna', NULL, 1, '72.7337429', '-181.6666641', 0, NULL),
(70, 1, 3, NULL, 3, '2019-09-05 05:58:06', '2019-09-23 07:05:04', '', 'App\\device_rspi', '2019-09-23 07:05:04', NULL, NULL, NULL, 1, NULL),
(71, 24, 2, NULL, 3, '2019-09-12 18:27:33', '2019-09-12 18:27:33', '', 'App\\device_system_voice_alert', NULL, NULL, NULL, NULL, 1, NULL),
(73, 6, 2, 19, 3, '2019-09-23 06:45:54', '2019-09-23 06:45:54', '', 'App\\device_alert', NULL, NULL, NULL, NULL, 1, NULL),
(74, 1, 1, NULL, 3, '2019-09-23 07:05:12', '2019-10-09 08:03:21', '', 'App\\device_system_voice_alert', NULL, NULL, NULL, NULL, 1, 2009),
(75, 1, 2, 74, 3, '2019-09-23 07:05:20', '2019-09-27 06:08:38', '', 'App\\device_alert', NULL, NULL, NULL, NULL, 0, NULL),
(76, 1, 1, NULL, 3, '2019-09-23 07:25:00', '2019-09-23 07:25:00', '', 'App\\device_alert', NULL, NULL, NULL, NULL, 1, NULL),
(77, 1, 1, NULL, 3, '2019-09-27 07:16:45', '2019-09-27 07:22:14', '', 'App\\device_antenna', '2019-09-27 07:22:14', NULL, NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `object_device_reglament`
--

CREATE TABLE `object_device_reglament` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_device_id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `technik_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `object_device_reglament_limitations`
--

CREATE TABLE `object_device_reglament_limitations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_device_id` bigint(20) UNSIGNED NOT NULL,
  `ODR_id` bigint(20) UNSIGNED DEFAULT NULL,
  `DL_id` smallint(5) UNSIGNED DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `additional_limitation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_limitation_critical` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `object_device_reglament_limitations`
--

INSERT INTO `object_device_reglament_limitations` (`id`, `object_device_id`, `ODR_id`, `DL_id`, `created_user_id`, `additional_limitation`, `additional_limitation_critical`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, NULL, 11, 3, NULL, NULL, NULL, '2019-08-30 10:33:28', NULL),
(2, 1, NULL, NULL, 3, 'Какая-то неисправность 3', NULL, NULL, '2019-08-30 10:35:02', NULL),
(3, 1, NULL, 12, 3, NULL, NULL, '2019-08-14 07:48:33', '2019-08-30 10:35:02', '2019-08-30 10:35:02'),
(4, 1, NULL, 13, 3, NULL, NULL, '2019-08-14 07:48:33', '2019-08-30 10:33:29', NULL),
(5, 13, NULL, 11, 3, NULL, NULL, '2019-08-14 08:30:52', '2019-09-02 10:49:38', '2019-09-02 10:49:38'),
(6, 13, NULL, 12, 3, NULL, NULL, '2019-08-14 08:30:52', '2019-09-02 10:49:38', '2019-09-02 10:49:38'),
(7, 13, NULL, 13, 3, NULL, NULL, '2019-08-14 08:30:52', '2019-09-02 10:49:38', '2019-09-02 10:49:38'),
(8, 23, NULL, 1, 3, NULL, NULL, '2019-08-15 05:44:38', '2019-08-15 06:02:06', '2019-08-15 06:02:06'),
(9, 23, NULL, 2, 3, NULL, NULL, '2019-08-15 05:44:39', '2019-08-15 06:02:07', '2019-08-15 06:02:07'),
(10, 23, NULL, 3, 3, NULL, NULL, '2019-08-15 05:44:39', '2019-08-15 06:02:07', NULL),
(11, 23, NULL, 4, 3, NULL, NULL, '2019-08-15 05:44:40', '2019-08-15 06:02:07', NULL),
(12, 23, NULL, 5, 3, NULL, NULL, '2019-08-15 05:44:40', '2019-08-15 06:02:07', '2019-08-15 06:02:07'),
(13, 13, NULL, NULL, 3, '4456', NULL, '2019-09-02 08:12:54', '2019-09-02 10:19:51', NULL),
(14, 69, NULL, 1, 3, NULL, NULL, '2019-09-18 05:12:12', '2019-09-18 05:12:12', NULL),
(15, 69, NULL, 2, 3, NULL, NULL, '2019-09-18 05:13:59', '2019-09-18 05:15:52', '2019-09-18 05:15:52'),
(16, 69, NULL, 3, 3, NULL, NULL, '2019-09-18 05:13:59', '2019-09-18 05:15:52', '2019-09-18 05:15:52'),
(17, 69, NULL, 4, 3, NULL, NULL, '2019-09-18 05:14:00', '2019-09-18 05:15:52', '2019-09-18 05:15:52'),
(18, 69, NULL, 5, 3, NULL, NULL, '2019-09-18 05:14:00', '2019-09-18 05:15:52', '2019-09-18 05:15:52'),
(19, 69, NULL, 14, 3, NULL, NULL, '2019-09-18 05:14:00', '2019-09-18 05:15:52', '2019-09-18 05:15:52'),
(20, 69, NULL, 22, 3, NULL, NULL, '2019-09-18 05:14:00', '2019-09-18 05:15:52', '2019-09-18 05:15:52'),
(21, 69, NULL, 23, 3, NULL, NULL, '2019-09-18 05:14:00', '2019-09-18 05:15:53', '2019-09-18 05:15:53'),
(22, 75, NULL, 24, 3, NULL, NULL, '2019-09-23 07:31:38', '2019-09-27 06:17:20', '2019-09-27 06:17:20'),
(23, 75, NULL, 25, 3, NULL, NULL, '2019-09-23 07:31:39', '2019-09-27 06:17:20', '2019-09-27 06:17:20'),
(24, 75, NULL, NULL, 3, 'eeee', 1, '2019-09-27 06:08:37', '2019-09-27 06:11:48', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `object_repair_queue`
--

CREATE TABLE `object_repair_queue` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `type` set('sensor','wire','device') COLLATE utf8mb4_unicode_ci NOT NULL,
  `technik_comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `finder_id` bigint(20) UNSIGNED NOT NULL,
  `repairer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `limitation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `done_at` timestamp NULL DEFAULT NULL,
  `additional_limitation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_limitation_critical` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `object_repair_queue`
--

INSERT INTO `object_repair_queue` (`id`, `object_id`, `device_id`, `type`, `technik_comment`, `finder_id`, `repairer_id`, `limitation_id`, `created_at`, `updated_at`, `deleted_at`, `done_at`, `additional_limitation`, `additional_limitation_critical`) VALUES
(38, 6, 13, 'device', NULL, 3, 3, NULL, '2019-09-02 10:19:22', '2019-09-02 10:19:52', NULL, '2019-09-02 10:19:52', '44567', NULL),
(39, 6, 13, 'device', NULL, 3, NULL, NULL, '2019-09-02 10:19:52', '2019-09-02 10:19:52', NULL, NULL, '4456', NULL),
(40, 6, 13, 'device', NULL, 3, 3, 11, '2019-09-02 10:20:06', '2019-09-02 10:42:38', NULL, '2019-09-02 10:42:38', NULL, NULL),
(42, 6, 13, 'device', NULL, 3, 3, 12, '2019-09-02 10:39:55', '2019-09-02 10:49:38', NULL, '2019-09-02 10:49:38', NULL, NULL),
(43, 6, 13, 'device', NULL, 3, 3, 11, '2019-09-02 10:42:26', '2019-09-02 10:48:52', NULL, '2019-09-02 10:48:52', NULL, NULL),
(44, 6, 13, 'device', NULL, 3, 3, 11, '2019-09-02 10:49:10', '2019-09-02 10:49:20', NULL, '2019-09-02 10:49:20', NULL, NULL),
(45, 1, 16, 'sensor', NULL, 3, NULL, 14, '2019-09-06 07:46:33', '2019-09-06 07:46:33', NULL, NULL, NULL, NULL),
(46, 6, 69, 'device', NULL, 3, NULL, 1, '2019-09-18 05:12:12', '2019-09-18 05:12:12', NULL, NULL, NULL, NULL),
(47, 6, 69, 'device', NULL, 3, 3, 2, '2019-09-18 05:13:59', '2019-09-18 05:13:59', NULL, '2019-09-18 05:13:59', NULL, NULL),
(48, 6, 69, 'device', NULL, 3, 3, 3, '2019-09-18 05:13:59', '2019-09-18 05:14:00', NULL, '2019-09-18 05:14:00', NULL, NULL),
(49, 6, 69, 'device', NULL, 3, 3, 4, '2019-09-18 05:14:00', '2019-09-18 05:14:00', NULL, '2019-09-18 05:14:00', NULL, NULL),
(50, 6, 69, 'device', NULL, 3, 3, 5, '2019-09-18 05:14:00', '2019-09-18 05:14:00', NULL, '2019-09-18 05:14:00', NULL, NULL),
(51, 6, 69, 'device', NULL, 3, 3, 14, '2019-09-18 05:14:00', '2019-09-18 05:14:00', NULL, '2019-09-18 05:14:00', NULL, NULL),
(52, 6, 69, 'device', NULL, 3, 3, 22, '2019-09-18 05:14:00', '2019-09-18 05:14:00', NULL, '2019-09-18 05:14:00', NULL, NULL),
(53, 6, 69, 'device', NULL, 3, 3, 23, '2019-09-18 05:14:00', '2019-09-18 05:14:00', NULL, '2019-09-18 05:14:00', NULL, NULL),
(54, 1, 75, 'device', NULL, 3, 3, 24, '2019-09-23 07:31:38', '2019-09-23 07:31:39', NULL, '2019-09-23 07:31:39', NULL, NULL),
(55, 1, 75, 'device', NULL, 3, 3, 25, '2019-09-23 07:31:39', '2019-09-23 07:31:39', NULL, '2019-09-23 07:31:39', NULL, NULL),
(56, 1, 75, 'device', NULL, 3, NULL, NULL, '2019-09-27 06:08:37', '2019-09-27 06:08:37', NULL, NULL, 'eeee', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `raions`
--

CREATE TABLE `raions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` decimal(10,7) NOT NULL,
  `lat` decimal(10,7) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `raions`
--

INSERT INTO `raions` (`id`, `name`, `lng`, `lat`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Агаповский муниципальный район', '59.2974060', '53.2702650', 1, '2019-05-18 14:51:15', '2019-07-26 10:10:10', NULL),
(2, 'Аргаяшский муниципальный район', '60.7585870', '55.4137190', 1, '2019-05-18 14:51:15', '2019-07-26 10:10:10', NULL),
(3, 'Ашинский муниципальный район', '57.5703410', '55.0506640', 0, '2019-05-18 14:51:16', '2019-09-13 04:24:46', NULL),
(4, 'Брединский муниципальный район', '60.3067080', '52.4326830', 0, '2019-05-18 14:51:16', '2019-08-23 06:32:55', '2019-08-23 06:32:55'),
(5, 'Варненский муниципальный район', '61.3553920', '53.1380460', 0, '2019-05-18 14:51:17', '2019-08-23 06:33:04', '2019-08-23 06:33:04'),
(6, 'Верхнеуральский муниципальный район', '59.1980970', '53.8143360', 0, '2019-05-18 14:51:17', '2019-08-23 06:33:04', '2019-08-23 06:33:04'),
(7, 'Еманжелинский муниципальный район', '61.3269150', '54.7427410', 0, '2019-05-18 14:51:18', '2019-08-23 06:33:05', '2019-08-23 06:33:05'),
(8, 'Еткульский муниципальный район', '61.5793420', '54.7634150', 0, '2019-05-18 14:51:18', '2019-08-23 06:33:06', '2019-08-23 06:33:06'),
(9, 'Карталинский муниципальный район', '60.3992790', '53.0443540', 0, '2019-05-18 14:51:18', '2019-08-23 06:33:07', '2019-08-23 06:33:07'),
(10, 'Каслинский муниципальный район', '61.4167830', '56.1570470', 0, '2019-05-18 14:51:18', '2019-08-23 06:33:08', '2019-08-23 06:33:08'),
(11, 'Катав-Ивановский муниципальный район', '58.2114860', '54.6961840', 0, '2019-05-18 14:51:19', '2019-08-23 06:33:09', '2019-08-23 06:33:09'),
(12, 'Кизильский муниципальный район', '59.2993640', '52.7499710', 0, '2019-05-18 14:51:19', '2019-08-23 06:33:09', '2019-08-23 06:33:09'),
(13, 'Коркинский муниципальный район', '61.3768800', '54.9151870', 0, '2019-05-18 14:51:20', '2019-08-23 06:33:11', '2019-08-23 06:33:11'),
(14, 'Красноармейский муниципальный район', '62.0510920', '55.4430210', 0, '2019-05-18 14:51:20', '2019-08-23 06:33:12', '2019-08-23 06:33:12'),
(15, 'Кунашакский муниципальный район', '61.6226950', '55.8362820', 0, '2019-05-18 14:51:21', '2019-08-23 06:33:13', '2019-08-23 06:33:13'),
(16, 'Кусинский муниципальный район', '59.5826030', '55.4120120', 0, '2019-05-18 14:51:21', '2019-08-23 06:33:14', '2019-08-23 06:33:14'),
(17, 'Нагайбакский муниципальный район', '59.8283190', '53.5595940', 0, '2019-05-18 14:51:21', '2019-08-23 06:33:15', '2019-08-23 06:33:15'),
(18, 'Нязепетровский муниципальный район ', '59.5755150', '55.9682770', 0, '2019-05-18 14:51:22', '2019-08-23 06:33:15', '2019-08-23 06:33:15'),
(19, 'Октябрьский муниципальный район', '62.7072580', '54.3837140', 0, '2019-05-18 14:51:22', '2019-08-23 06:33:17', '2019-08-23 06:33:17'),
(20, 'Пластовский муниципальный район', '60.6766610', '54.3747470', 0, '2019-05-18 14:51:22', '2019-08-23 06:33:17', '2019-08-23 06:33:17'),
(21, 'Саткинский муниципальный район', '58.9971080', '54.9784520', 0, '2019-05-18 14:51:23', '2019-08-23 06:33:20', '2019-08-23 06:33:20'),
(22, 'Сосновский муниципальный район', '61.1986450', '55.2309900', 0, '2019-05-18 14:51:23', '2019-08-23 06:33:19', '2019-08-23 06:33:19'),
(23, 'Троицкий муниципальный район', '61.2930670', '54.1754920', 0, '2019-05-18 14:51:24', '2019-08-23 06:33:20', '2019-08-23 06:33:20'),
(24, 'Увельский муниципальный район', '61.4957540', '54.4851620', 0, '2019-05-18 14:51:24', '2019-08-23 06:33:21', '2019-08-23 06:33:21'),
(25, 'Уйский муниципальный район', '60.0910580', '54.3855650', 0, '2019-05-18 14:51:24', '2019-08-23 06:33:22', '2019-08-23 06:33:22'),
(26, 'Чебаркульский муниципальный район', '60.5207130', '54.8279980', 0, '2019-05-18 14:51:25', '2019-08-23 06:34:14', '2019-08-23 06:34:14'),
(27, 'Чесменский муниципальный район', '60.5706960', '53.7258610', 0, '2019-05-18 14:51:25', '2019-08-23 06:34:15', '2019-08-23 06:34:15'),
(28, 'Верхнеуфалейский городской округ', '60.2319500', '56.0487210', 0, '2019-05-18 14:58:20', '2019-08-23 06:34:16', '2019-08-23 06:34:16'),
(29, 'Златоустовский городской округ', '59.6724250', '55.1731080', 0, '2019-05-18 14:58:20', '2019-08-23 06:34:17', '2019-08-23 06:34:17'),
(30, 'Карабашский городской округ', '60.2030420', '55.4907890', 0, '2019-05-18 14:58:21', '2019-08-23 06:34:21', '2019-08-23 06:34:21'),
(31, 'Копейский городской округ', '61.6179700', '55.1167320', 0, '2019-05-18 14:58:21', '2019-08-23 06:34:22', '2019-08-23 06:34:22'),
(32, 'Кыштымский городской округ', '60.5389490', '55.7078770', 0, '2019-05-18 14:58:22', '2019-08-23 06:34:23', '2019-08-23 06:34:23'),
(33, 'Локомотивный городской округ', '60.6139230', '53.0452210', 0, '2019-05-18 14:58:22', '2019-08-23 06:34:24', '2019-08-23 06:34:24'),
(34, 'Магнитогорский городской округ', '58.9802820', '53.4071580', 0, '2019-05-18 14:58:23', '2019-08-23 06:34:25', '2019-08-23 06:34:25'),
(35, 'Миасский городской округ', '60.1080810', '55.0464140', 0, '2019-05-18 14:58:23', '2019-08-23 06:34:30', '2019-08-23 06:34:30'),
(36, 'Озерский городской округ', '60.7075990', '55.7631840', 0, '2019-05-18 14:58:23', '2019-08-23 06:34:31', '2019-08-23 06:34:31'),
(37, 'Снежинский городской округ', '60.7325360', '56.0852090', 0, '2019-05-18 14:58:24', '2019-08-23 06:34:32', '2019-08-23 06:34:32'),
(38, 'Трехгорный городской округ', '58.4464230', '54.8178420', 0, '2019-05-18 14:58:24', '2019-08-23 06:34:33', '2019-08-23 06:34:33'),
(39, 'Троицкий городской округ', '61.5597590', '54.0832170', 0, '2019-05-18 14:58:25', '2019-08-23 06:34:34', '2019-08-23 06:34:34'),
(40, 'Усть-Катавский городской округ', '58.1747000', '54.9302890', 0, '2019-05-18 14:58:25', '2019-08-23 06:34:37', '2019-08-23 06:34:37'),
(41, 'Чебаркульский городской округ', '60.3701200', '54.9777850', 0, '2019-05-18 14:58:25', '2019-08-23 06:34:38', '2019-08-23 06:34:38'),
(42, 'Челябинский городской округ', '61.4025540', '55.1598970', 1, '2019-05-18 14:58:26', '2019-05-18 14:58:26', NULL),
(43, 'Южноуральский городской округ', '61.2682290', '54.4424550', 0, '2019-05-18 14:58:26', '2019-08-23 06:34:39', '2019-08-23 06:34:39');

-- --------------------------------------------------------

--
-- Структура таблицы `reglament_works`
--

CREATE TABLE `reglament_works` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reglament_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `tbl_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `done_at` timestamp NULL DEFAULT NULL,
  `planned_reglament_at` timestamp NULL DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `reglament_works`
--

INSERT INTO `reglament_works` (`id`, `reglament_id`, `device_id`, `tbl_name`, `deleted_at`, `done_at`, `planned_reglament_at`, `created_user_id`, `updated_at`) VALUES
(138, 74, 45, NULL, NULL, NULL, '2019-09-04 12:45:18', 3, NULL),
(139, 79, 45, NULL, NULL, NULL, '2019-09-04 12:45:18', 3, NULL),
(176, 74, 64, NULL, NULL, NULL, '2019-09-05 05:25:03', 3, NULL),
(177, 79, 64, NULL, NULL, NULL, '2019-09-05 05:25:03', 3, NULL),
(185, 70, 69, NULL, NULL, NULL, '2019-09-05 05:48:36', 3, NULL),
(186, 71, 69, NULL, NULL, NULL, '2019-09-05 05:48:36', 3, NULL),
(187, 72, 69, NULL, NULL, NULL, '2019-09-05 05:48:36', 3, NULL),
(188, 75, 69, NULL, NULL, NULL, '2019-09-05 05:48:36', 3, NULL),
(189, 76, 69, NULL, NULL, NULL, '2019-09-05 05:48:36', 3, NULL),
(190, 77, 69, NULL, NULL, NULL, '2019-09-05 05:48:36', 3, NULL),
(191, 78, 69, NULL, NULL, NULL, '2019-09-05 05:48:36', 3, NULL),
(192, 80, 26, 'App/Sensor', NULL, '2019-09-07 17:36:55', '2019-09-08 17:36:55', 3, '2019-09-07 17:36:55'),
(193, 80, 26, 'App/Sensor', NULL, '2019-09-07 17:36:57', '2019-09-08 17:36:57', 3, '2019-09-07 17:36:57'),
(194, 80, 27, 'App/Sensor', NULL, '2019-09-07 17:30:40', '2019-09-08 17:30:40', 3, '2019-09-07 17:30:40'),
(195, 80, 28, 'App/Sensor', NULL, NULL, '2019-09-07 17:46:17', 3, NULL),
(196, 80, 29, 'App/Sensor', NULL, NULL, '2019-09-07 17:50:45', 3, NULL),
(197, 82, 21, NULL, NULL, NULL, '2019-09-23 07:18:50', 3, NULL),
(198, 82, 73, NULL, NULL, NULL, '2019-09-23 07:18:50', 3, NULL),
(199, 82, 75, NULL, NULL, '2019-09-23 07:31:32', '2019-10-23 07:31:32', 3, '2019-09-23 07:31:32');

-- --------------------------------------------------------

--
-- Структура таблицы `sensors`
--

CREATE TABLE `sensors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `is_automate` tinyint(1) NOT NULL DEFAULT '1',
  `power_supply` set('wire','separate wire','stand-alone') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_address` tinyint(1) NOT NULL,
  `standalon_function` set('smoke','fire') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `standalon_smoke_is_radioisotop` tinyint(1) DEFAULT NULL,
  `automate_attribute` set('heat','smoke','fire','gas','combine') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `automate_reaction` set('maximal','differincial','max-diff') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sensors`
--

INSERT INTO `sensors` (`id`, `is_automate`, `power_supply`, `is_address`, `standalon_function`, `standalon_smoke_is_radioisotop`, `automate_attribute`, `automate_reaction`, `created_user_id`, `is_active`, `created_at`, `updated_at`, `name`, `instruction`, `deleted_at`) VALUES
(1, 1, 'wire', 1, 'smoke', NULL, 'heat', 'maximal', 3, 1, '2019-06-08 10:29:11', '2019-08-28 07:10:51', 'asd', 'dns adguard', NULL),
(2, 0, 'separate wire', 0, NULL, NULL, NULL, NULL, 3, 0, '2019-06-08 11:51:43', '2019-06-08 11:52:48', 'dsa', NULL, NULL),
(3, 0, 'wire', 0, NULL, NULL, NULL, NULL, 3, 0, '2019-06-08 11:55:02', '2019-08-29 11:33:40', 'qwe', NULL, NULL),
(4, 0, 'wire', 0, NULL, NULL, 'combine', 'differincial', 3, 1, '2019-06-11 08:42:01', '2019-08-29 11:33:45', 'qwe', NULL, NULL),
(5, 0, 'stand-alone', 0, 'smoke', 0, NULL, NULL, 3, 1, '2019-06-11 08:44:36', '2019-06-11 08:44:36', 'qwesd', NULL, NULL),
(6, 0, 'wire', 1, NULL, NULL, NULL, NULL, 3, 1, '2019-08-27 10:36:07', '2019-08-27 10:36:07', 'Regul', NULL, NULL),
(7, 0, 'wire', 0, NULL, NULL, NULL, NULL, 3, 1, '2019-08-29 12:04:53', '2019-08-29 12:26:56', '111', NULL, NULL),
(8, 1, 'wire', 1, NULL, NULL, 'gas', 'differincial', 3, 1, '2019-08-29 12:26:18', '2019-09-13 05:28:39', '1112', NULL, '2019-09-13 05:28:39');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `raion_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `password`, `api_token`, `is_active`, `is_admin`, `remember_token`, `created_at`, `updated_at`, `raion_id`, `deleted_at`) VALUES
(3, 'Иванов Иван', '1234567890', '$2y$10$UinZZ0DpOt3BKrrt3odbpeK9rsDXcMvfuU6tFO6VBT.Fg5dXDYRX.', 'i2buhDy4VFeAddHbaN9XtVGINHaBRnjUifqIxJQ4Q8x0UakU9CPDUj0zTTL0', 1, 1, NULL, '2019-05-19 12:52:18', '2019-05-19 12:52:18', 42, NULL),
(5, 'Simonov Sergey', '1523456789', '$2y$10$7J81Ux1M9mkgW8auFFMV1e7tmDyJlVtie9xps.TwacmJELtzN9RVO', NULL, 1, 0, NULL, '2019-06-12 08:14:24', '2019-08-23 05:58:12', 1, NULL),
(6, 'test', '1234', '$2y$10$jl.Gx16IkO5Dtrg.K0OZBunyvoQqUQzxjvBI4SDZNa1GYk7k.dXpW', NULL, 1, 0, NULL, '2019-08-23 05:58:42', '2019-09-13 04:25:45', 2, '2019-09-13 04:25:45'),
(7, 'Иванов', 'Иван', '$2y$10$wanJ13U6gLkWO9qGKsArQeMWmVD59OULeloLpELY.mPlcXCTUkRkq', NULL, 1, 0, NULL, '2019-09-13 04:25:33', '2019-09-13 04:25:33', 42, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `wires`
--

CREATE TABLE `wires` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_device_id` bigint(20) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sertificate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` set('safe','unsafe','radio') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unsafe',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `wires`
--

INSERT INTO `wires` (`id`, `object_device_id`, `created_user_id`, `is_good`, `description`, `sertificate`, `type`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 1, 'ПБ1', 'ПБ-12-1987', 'safe', 1, '2019-06-07 11:38:47', '2019-07-03 11:19:41'),
(2, 1, 3, 1, 'Пожароопасный', NULL, 'unsafe', 1, '2019-06-13 08:07:07', '2019-06-13 08:07:07'),
(5, 1, 3, 1, 'radio', NULL, 'radio', 1, '2019-06-13 08:16:45', '2019-06-13 08:16:45'),
(6, 22, 3, 1, '1', NULL, 'unsafe', 1, '2019-08-15 07:22:45', '2019-08-15 07:22:45'),
(7, 24, 3, 1, '1', NULL, 'unsafe', 1, '2019-08-27 08:55:35', '2019-08-27 08:55:35'),
(8, 45, 3, 1, '1', NULL, 'unsafe', 1, '2019-09-04 15:14:18', '2019-09-04 15:14:18'),
(9, 45, 3, 1, '2', NULL, 'unsafe', 1, '2019-09-04 15:15:12', '2019-09-04 15:15:12'),
(10, 45, 3, 1, '3', NULL, 'unsafe', 1, '2019-09-04 15:25:53', '2019-09-04 15:25:53'),
(11, 45, 3, 1, '4', NULL, 'unsafe', 1, '2019-09-04 15:27:52', '2019-09-04 15:27:52'),
(12, 61, 3, 1, '1', NULL, 'unsafe', 1, '2019-09-04 15:30:02', '2019-09-04 15:30:02'),
(13, 61, 3, 1, '2', NULL, 'unsafe', 1, '2019-09-04 15:31:53', '2019-09-04 15:31:53'),
(14, 61, 3, 1, '3', NULL, 'unsafe', 1, '2019-09-04 15:32:39', '2019-09-04 15:32:39'),
(15, 61, 3, 1, '4', NULL, 'unsafe', 1, '2019-09-04 15:39:13', '2019-09-04 15:39:13');

-- --------------------------------------------------------

--
-- Структура таблицы `wire_previous_state`
--

CREATE TABLE `wire_previous_state` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wire_id` bigint(20) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sertificate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_fire_safety` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `wire_sensor`
--

CREATE TABLE `wire_sensor` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wire_id` bigint(20) UNSIGNED NOT NULL,
  `sensor_id` bigint(20) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` tinyint(4) NOT NULL,
  `cabinet_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SP5_valid` tinyint(1) NOT NULL DEFAULT '1',
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `bti_files_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `wire_sensor`
--

INSERT INTO `wire_sensor` (`id`, `wire_id`, `sensor_id`, `created_user_id`, `name`, `floor`, `cabinet_name`, `SP5_valid`, `is_good`, `created_at`, `updated_at`, `comment`, `deleted_at`, `bti_files_id`, `lng`, `lat`) VALUES
(1, 1, 5, 3, '1', 3, '32', 1, 1, '2019-06-11 07:56:34', '2019-08-29 13:29:57', NULL, NULL, 1, '75.3879883', '-186.1250000'),
(2, 1, 1, 3, '2', 1, '11', 1, 0, '2019-06-12 12:48:39', '2019-08-14 08:37:41', 'Перенесен из 12 кабинета', NULL, 1, '73.8890529', '-218.6250000'),
(3, 1, 1, 3, '3', 1, '12', 1, 1, '2019-06-12 12:48:46', '2019-08-14 08:37:45', 'После ремонта', NULL, 1, '74.3886980', '-297.6250000'),
(4, 1, 1, 3, '4', 1, '14', 1, 1, '2019-06-12 12:52:20', '2019-06-12 12:52:20', '', NULL, NULL, NULL, NULL),
(5, 1, 1, 3, '5', 1, '15', 1, 1, '2019-06-12 12:54:23', '2019-06-12 12:54:23', '', NULL, NULL, NULL, NULL),
(6, 1, 1, 3, '6', 1, '16', 1, 1, '2019-06-12 12:56:01', '2019-06-12 12:56:01', '', NULL, NULL, NULL, NULL),
(7, 1, 1, 3, '7', 1, 'ddd', 1, 1, '2019-07-04 04:45:37', '2019-07-04 07:08:28', NULL, '2019-07-04 07:08:28', NULL, NULL, NULL),
(8, 1, 1, 3, '8', 1, 'qqq', 0, 0, '2019-07-04 06:28:35', '2019-07-04 07:03:04', NULL, '2019-07-04 07:03:04', NULL, NULL, NULL),
(9, 1, 1, 3, '7', 1, '16', 1, 0, '2019-07-04 10:26:23', '2019-07-04 10:34:12', 'Проба пера', '2019-07-04 10:34:12', NULL, NULL, NULL),
(10, 1, 1, 3, '7', 3, 'Кабинет директора', 0, 1, '2019-08-14 08:38:38', '2019-08-14 08:39:12', NULL, NULL, 1, '202.2703484', '-188.8750000'),
(11, 6, 1, 3, '1', 1, '12', 0, 1, '2019-08-15 07:23:09', '2019-08-15 07:23:09', NULL, NULL, NULL, NULL, NULL),
(12, 6, 4, 3, '2', 1, '13', 0, 1, '2019-08-15 07:24:08', '2019-08-15 07:24:08', NULL, NULL, NULL, NULL, NULL),
(13, 20, 2, 3, '1', 1, 'dsss', 1, 1, '2019-09-05 10:36:27', '2019-09-05 11:15:26', NULL, '2019-09-05 11:15:26', NULL, NULL, NULL),
(14, 20, 5, 3, '2', 23, 'awe', 1, 1, '2019-09-05 11:09:01', '2019-09-05 11:35:01', NULL, '2019-09-05 11:35:01', NULL, NULL, NULL),
(15, 8, 2, 3, '1', 0, 'qwe', 1, 1, '2019-09-06 06:51:16', '2019-09-18 05:41:57', NULL, NULL, 1, '251.8046043', '-240.6333313'),
(16, 20, 1, 3, '1', 2, 'cabinet 1', 1, 0, '2019-09-06 07:03:52', '2019-09-06 07:46:34', NULL, NULL, NULL, NULL, NULL),
(17, 20, 2, 3, '2', 2, 'cabinet 2', 1, 1, '2019-09-06 07:05:19', '2019-09-06 07:05:19', NULL, NULL, NULL, NULL, NULL),
(18, 20, 1, 3, '3', 3, 'cabinet 3', 1, 1, '2019-09-06 07:08:47', '2019-09-06 07:08:47', NULL, NULL, NULL, NULL, NULL),
(19, 20, 6, 3, '4', 1, 'cabinet 4', 1, 0, '2019-09-06 07:14:53', '2019-09-06 07:14:53', NULL, NULL, NULL, NULL, NULL),
(20, 20, 1, 3, '5', 1, '5', 0, 1, '2019-09-06 07:35:09', '2019-09-06 07:35:09', NULL, NULL, NULL, NULL, NULL),
(21, 20, 1, 3, '6', 1, '6', 1, 1, '2019-09-06 08:35:07', '2019-09-06 08:35:07', NULL, NULL, NULL, NULL, NULL),
(22, 20, 1, 3, '7', 1, '7', 1, 0, '2019-09-06 10:16:59', '2019-09-06 10:16:59', NULL, NULL, NULL, NULL, NULL),
(23, 20, 1, 3, '8', 1, '8', 0, 0, '2019-09-06 10:22:10', '2019-09-06 10:22:10', NULL, NULL, NULL, NULL, NULL),
(24, 20, 1, 3, '9', 1, '9', 0, 0, '2019-09-06 10:25:40', '2019-09-06 10:25:40', NULL, NULL, NULL, NULL, NULL),
(25, 20, 1, 3, '10', 1, '10', 0, 0, '2019-09-06 10:28:36', '2019-09-06 10:28:36', NULL, NULL, NULL, NULL, NULL),
(26, 20, 1, 3, '11', 1, '11', 0, 0, '2019-09-06 12:40:14', '2019-09-06 12:40:14', NULL, NULL, NULL, NULL, NULL),
(27, 8, 1, 3, '2', -1, '2', 1, 0, '2019-09-07 12:14:47', '2019-09-18 05:40:45', NULL, NULL, 1, '243.8020094', '-267.5833359'),
(28, 20, 1, 3, '12', 1, '12', 0, 0, '2019-09-07 17:46:16', '2019-09-07 17:46:16', NULL, NULL, NULL, NULL, NULL),
(29, 8, 1, 3, '3', 3, '3', 0, 0, '2019-09-07 17:50:45', '2019-09-07 17:50:45', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `wire_sensor_previous_state`
--

CREATE TABLE `wire_sensor_previous_state` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wire_sensor_id` bigint(20) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` tinyint(4) NOT NULL,
  `cabinet_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SP5_valid` tinyint(1) NOT NULL DEFAULT '1',
  `is_good` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `wire_id` bigint(20) UNSIGNED NOT NULL,
  `sensor_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `wire_sensor_previous_state`
--

INSERT INTO `wire_sensor_previous_state` (`id`, `wire_sensor_id`, `created_user_id`, `name`, `floor`, `cabinet_name`, `SP5_valid`, `is_good`, `is_active`, `created_at`, `updated_at`, `wire_id`, `sensor_id`) VALUES
(1, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:25:06', '2019-06-11 09:25:06', 1, 1),
(2, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:25:47', '2019-06-11 09:25:47', 1, 1),
(3, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:28:20', '2019-06-11 09:28:20', 1, 1),
(4, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:32:26', '2019-06-11 09:32:26', 1, 1),
(5, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:35:14', '2019-06-11 09:35:14', 1, 1),
(6, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:35:59', '2019-06-11 09:35:59', 1, 1),
(7, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:38:20', '2019-06-11 09:38:20', 1, 1),
(8, 1, 3, '1', 12, '321', 1, 1, 1, '2019-06-11 09:39:59', '2019-06-11 09:39:59', 1, 1),
(9, 1, 3, '15', 126, '3217', 1, 1, 1, '2019-06-11 09:40:51', '2019-06-11 09:40:51', 1, 4),
(10, 1, 3, '2', 3, '32', 1, 1, 1, '2019-06-12 12:59:04', '2019-06-12 12:59:04', 1, 5),
(11, 3, 3, '2', 1, '12', 1, 1, 1, '2019-06-12 13:00:14', '2019-06-12 13:00:14', 1, 1),
(12, 2, 3, '2', 1, '11', 0, 1, 1, '2019-06-12 13:19:21', '2019-06-12 13:19:21', 1, 1),
(13, 2, 3, '2', 1, '11', 0, 1, 1, '2019-06-12 13:21:18', '2019-06-12 13:21:18', 1, 1),
(14, 3, 3, '3', 1, '12', 1, 1, 1, '2019-06-12 13:21:36', '2019-06-12 13:21:36', 1, 1),
(15, 2, 3, '2', 1, '11', 0, 1, 1, '2019-07-04 04:35:46', '2019-07-04 04:35:46', 1, 1),
(16, 8, 3, '8', 1, 'qqq', 1, 1, 1, '2019-07-04 06:38:44', '2019-07-04 06:38:44', 1, 1),
(17, 8, 3, '8', 1, 'qqq', 1, 1, 1, '2019-07-04 06:38:50', '2019-07-04 06:38:50', 1, 1),
(18, 8, 3, '8', 1, 'qqq', 0, 1, 1, '2019-07-04 06:40:34', '2019-07-04 06:40:34', 1, 1),
(19, 8, 3, '8', 1, 'qqq', 0, 0, 1, '2019-07-04 06:54:36', '2019-07-04 06:54:36', 1, 1),
(20, 8, 3, '8', 1, 'qqq', 0, 0, 1, '2019-07-04 06:58:57', '2019-07-04 06:58:57', 1, 1),
(21, 8, 3, '8', 1, 'qqq', 0, 0, 1, '2019-07-04 07:03:04', '2019-07-04 07:03:04', 1, 1),
(22, 7, 3, '7', 1, 'ddd', 1, 1, 1, '2019-07-04 07:08:28', '2019-07-04 07:08:28', 1, 1),
(23, 2, 3, '2', 1, '11', 0, 0, 1, '2019-07-04 09:19:46', '2019-07-04 09:19:46', 1, 1),
(24, 2, 3, '2', 1, '11', 1, 0, 1, '2019-07-04 10:23:55', '2019-07-04 10:23:55', 1, 1),
(25, 9, 3, '7', 1, '16', 1, 0, 1, '2019-07-04 10:29:56', '2019-07-04 10:29:56', 1, 1),
(26, 9, 3, '7', 1, '16', 1, 0, 1, '2019-07-04 10:34:12', '2019-07-04 10:34:12', 1, 1),
(27, 1, 3, '1', 3, '32', 1, 1, 1, '2019-07-16 11:43:54', '2019-07-16 11:43:54', 1, 5),
(28, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-14 08:36:59', '2019-08-14 08:36:59', 1, 5),
(29, 10, 3, '7', 5, 'Кабинет директора', 1, 1, 1, '2019-08-14 08:38:53', '2019-08-14 08:38:53', 1, 1),
(30, 10, 3, '7', 3, 'Кабинет директора', 1, 1, 1, '2019-08-14 08:39:03', '2019-08-14 08:39:03', 1, 1),
(31, 1, 3, '1', 3, '32', 1, 0, 1, '2019-08-29 11:31:48', '2019-08-29 11:31:48', 1, 5),
(32, 2, 3, '2', 1, '11', 1, 0, 1, '2019-08-29 12:58:59', '2019-08-29 12:58:59', 1, 1),
(33, 3, 3, '3', 1, '12', 1, 1, 1, '2019-08-29 13:17:20', '2019-08-29 13:17:20', 1, 1),
(34, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-29 13:22:05', '2019-08-29 13:22:05', 1, 5),
(35, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-29 13:22:45', '2019-08-29 13:22:45', 1, 5),
(36, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-29 13:24:36', '2019-08-29 13:24:36', 1, 5),
(37, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-29 13:25:09', '2019-08-29 13:25:09', 1, 5),
(38, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-29 13:26:12', '2019-08-29 13:26:12', 1, 5),
(39, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-29 13:28:05', '2019-08-29 13:28:05', 1, 5),
(40, 1, 3, '1', 3, '32', 1, 1, 1, '2019-08-29 13:29:02', '2019-08-29 13:29:02', 1, 5),
(41, 1, 3, '1', 3, '32', 1, 0, 1, '2019-08-29 13:29:56', '2019-08-29 13:29:56', 1, 5),
(42, 13, 3, '1', 1, 'dsss', 1, 1, 1, '2019-09-05 11:15:25', '2019-09-05 11:15:25', 20, 2),
(43, 14, 3, '2', 2, 'awe', 1, 1, 1, '2019-09-05 11:34:34', '2019-09-05 11:34:34', 20, 5),
(44, 14, 3, '2', 23, 'awe', 1, 1, 1, '2019-09-05 11:35:01', '2019-09-05 11:35:01', 20, 5),
(45, 18, 3, '3', 3, 'cabinet 3', 1, 1, 1, '2019-09-06 07:35:26', '2019-09-06 07:35:26', 20, 1),
(46, 16, 3, '1', 2, 'cabinet 1', 1, 1, 1, '2019-09-06 07:42:59', '2019-09-06 07:42:59', 20, 1),
(47, 16, 3, '1', 2, 'cabinet 1', 1, 1, 1, '2019-09-06 07:46:33', '2019-09-06 07:46:33', 20, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `wire_sensor_reglament`
--

CREATE TABLE `wire_sensor_reglament` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wire_sensor_id` bigint(20) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `bti_files`
--
ALTER TABLE `bti_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bti_files_created_user_id_foreign` (`created_user_id`),
  ADD KEY `bti_files_object_id_foreign` (`object_id`);

--
-- Индексы таблицы `calendar`
--
ALTER TABLE `calendar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `calendar_admin_id_foreign` (`admin_id`),
  ADD KEY `calendar_technik_id_foreign` (`technic_id`),
  ADD KEY `calendar_object_id_foreign` (`object_id`),
  ADD KEY `calendar_device_id_foreign` (`device_id`);

--
-- Индексы таблицы `device_alerts`
--
ALTER TABLE `device_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_alerts_created_user_id_foreign` (`created_user_id`);

--
-- Индексы таблицы `device_antenna`
--
ALTER TABLE `device_antenna`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_antenna_created_user_id_foreign` (`created_user_id`);

--
-- Индексы таблицы `device_antenna_params`
--
ALTER TABLE `device_antenna_params`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_antenna_params_created_user_id_foreign` (`created_user_id`),
  ADD KEY `device_antenna_params_device_antenna_id_foreign_idx` (`device_id`);

--
-- Индексы таблицы `device_aps`
--
ALTER TABLE `device_aps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `devices_created_user_id_foreign` (`created_user_id`);

--
-- Индексы таблицы `device_class`
--
ALTER TABLE `device_class`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `device_limitations`
--
ALTER TABLE `device_limitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_limitations_created_user_id_foreign` (`created_user_id`),
  ADD KEY `device_limitations_device_id_foreign` (`device_id`);

--
-- Индексы таблицы `device_reglament`
--
ALTER TABLE `device_reglament`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_reglament_created_user_id_foreign` (`created_user_id`),
  ADD KEY `device_reglament_dvice_id_foreign` (`device_id`);

--
-- Индексы таблицы `device_reglament_element`
--
ALTER TABLE `device_reglament_element`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_reglament_element_created_user_id_foreign` (`created_user_id`),
  ADD KEY `device_reglament_element_dvice_reglament_id_foreign` (`device_reglament_id`);

--
-- Индексы таблицы `device_rspi`
--
ALTER TABLE `device_rspi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_rspi_created_user_id_foreign` (`created_user_id`);

--
-- Индексы таблицы `device_rspi_params`
--
ALTER TABLE `device_rspi_params`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_rspi_params_created_user_id_foreign` (`created_user_id`),
  ADD KEY `device_id` (`device_id`);

--
-- Индексы таблицы `device_system_voice_alerts`
--
ALTER TABLE `device_system_voice_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_system_voice_alerts_created_user_id_foreign` (`created_user_id`);

--
-- Индексы таблицы `device_system_voice_alerts_devs`
--
ALTER TABLE `device_system_voice_alerts_devs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_system_voice_alerts_devs_device_alerts_id_foreign` (`device_alerts_id`),
  ADD KEY `device_system_voice_alerts_devs_created_user_id_foreign` (`created_user_id`),
  ADD KEY `device_system_voice_alerts_devs_bti_files_id_foreign` (`bti_files_id`);

--
-- Индексы таблицы `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `districtsobjects`
--
ALTER TABLE `districtsobjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `districtsobjects_district_id_foreign` (`district_id`),
  ADD KEY `districtsobjects_object_id_foreign` (`object_id`);

--
-- Индексы таблицы `districtsusers`
--
ALTER TABLE `districtsusers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `districtsusers_district_id_foreign` (`district_id`),
  ADD KEY `districtsusers_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Индексы таблицы `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Индексы таблицы `objects`
--
ALTER TABLE `objects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `objects_raion_id_foreign` (`raion_id`),
  ADD KEY `objects_created_user_id_foreign` (`created_user_id`);

--
-- Индексы таблицы `objects_mediafiles`
--
ALTER TABLE `objects_mediafiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `objects_mediafiles_object_id_foreign` (`object_id`);

--
-- Индексы таблицы `object_devices`
--
ALTER TABLE `object_devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_devices_created_user_id_foreign` (`created_user_id`),
  ADD KEY `object_devices_object_id_foreign` (`object_id`);

--
-- Индексы таблицы `object_device_reglament`
--
ALTER TABLE `object_device_reglament`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_device_reglament_admin_id_foreign` (`admin_id`),
  ADD KEY `object_device_reglament_technik_id_foreign` (`technik_id`),
  ADD KEY `object_device_reglament_object_device_id_foreign` (`object_device_id`);

--
-- Индексы таблицы `object_device_reglament_limitations`
--
ALTER TABLE `object_device_reglament_limitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_device_reglament_limitations_created_user_id_foreign` (`created_user_id`),
  ADD KEY `object_device_reglament_limitations_object_device_id_foreign` (`object_device_id`),
  ADD KEY `object_device_reglament_limitations_odr_id_foreign` (`ODR_id`),
  ADD KEY `object_device_reglament_limitations_dl_id_foreign` (`DL_id`);

--
-- Индексы таблицы `object_repair_queue`
--
ALTER TABLE `object_repair_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_repair_queue_finder_id_foreign` (`finder_id`),
  ADD KEY `object_repair_queue_repairer_id_foreign` (`repairer_id`),
  ADD KEY `object_repair_queue_object_id_foreign` (`object_id`),
  ADD KEY `object_repair_queue_device_id_foreign` (`device_id`);

--
-- Индексы таблицы `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`(191));

--
-- Индексы таблицы `raions`
--
ALTER TABLE `raions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `reglament_works`
--
ALTER TABLE `reglament_works`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sensors`
--
ALTER TABLE `sensors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sensors_created_user_id_foreign` (`created_user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`),
  ADD KEY `users_raion_id_foreign` (`raion_id`);

--
-- Индексы таблицы `wires`
--
ALTER TABLE `wires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wires_created_user_id_foreign` (`created_user_id`),
  ADD KEY `wires_object_device_id_foreign` (`object_device_id`);

--
-- Индексы таблицы `wire_previous_state`
--
ALTER TABLE `wire_previous_state`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wire_previous_state_created_user_id_foreign` (`created_user_id`),
  ADD KEY `wire_previous_state_wire_id_foreign` (`wire_id`);

--
-- Индексы таблицы `wire_sensor`
--
ALTER TABLE `wire_sensor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wire_sensor_created_user_id_foreign` (`created_user_id`),
  ADD KEY `wire_sensor_wire_id_foreign` (`wire_id`),
  ADD KEY `wire_sensor_sensor_id_foreign` (`sensor_id`),
  ADD KEY `wire_sensor_bti_files_id_foreign` (`bti_files_id`);

--
-- Индексы таблицы `wire_sensor_previous_state`
--
ALTER TABLE `wire_sensor_previous_state`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wire_sensor_previous_state_created_user_id_foreign` (`created_user_id`),
  ADD KEY `wire_sensor_previous_state_wire_sensor_id_foreign` (`wire_sensor_id`);

--
-- Индексы таблицы `wire_sensor_reglament`
--
ALTER TABLE `wire_sensor_reglament`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wire_sensor_reglament_created_user_id_foreign` (`created_user_id`),
  ADD KEY `wire_sensor_reglament_wire_sensor_id_foreign` (`wire_sensor_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `bti_files`
--
ALTER TABLE `bti_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `calendar`
--
ALTER TABLE `calendar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `device_alerts`
--
ALTER TABLE `device_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `device_antenna`
--
ALTER TABLE `device_antenna`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `device_antenna_params`
--
ALTER TABLE `device_antenna_params`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `device_aps`
--
ALTER TABLE `device_aps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `device_class`
--
ALTER TABLE `device_class`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `device_limitations`
--
ALTER TABLE `device_limitations`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `device_reglament`
--
ALTER TABLE `device_reglament`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT для таблицы `device_reglament_element`
--
ALTER TABLE `device_reglament_element`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT для таблицы `device_rspi`
--
ALTER TABLE `device_rspi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `device_rspi_params`
--
ALTER TABLE `device_rspi_params`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `device_system_voice_alerts`
--
ALTER TABLE `device_system_voice_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `device_system_voice_alerts_devs`
--
ALTER TABLE `device_system_voice_alerts_devs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `districts`
--
ALTER TABLE `districts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `districtsobjects`
--
ALTER TABLE `districtsobjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `districtsusers`
--
ALTER TABLE `districtsusers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT для таблицы `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `objects`
--
ALTER TABLE `objects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `objects_mediafiles`
--
ALTER TABLE `objects_mediafiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `object_devices`
--
ALTER TABLE `object_devices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT для таблицы `object_device_reglament`
--
ALTER TABLE `object_device_reglament`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `object_device_reglament_limitations`
--
ALTER TABLE `object_device_reglament_limitations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `object_repair_queue`
--
ALTER TABLE `object_repair_queue`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT для таблицы `raions`
--
ALTER TABLE `raions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT для таблицы `reglament_works`
--
ALTER TABLE `reglament_works`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- AUTO_INCREMENT для таблицы `sensors`
--
ALTER TABLE `sensors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `wires`
--
ALTER TABLE `wires`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `wire_previous_state`
--
ALTER TABLE `wire_previous_state`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `wire_sensor`
--
ALTER TABLE `wire_sensor`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT для таблицы `wire_sensor_previous_state`
--
ALTER TABLE `wire_sensor_previous_state`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT для таблицы `wire_sensor_reglament`
--
ALTER TABLE `wire_sensor_reglament`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `bti_files`
--
ALTER TABLE `bti_files`
  ADD CONSTRAINT `bti_files_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bti_files_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`);

--
-- Ограничения внешнего ключа таблицы `calendar`
--
ALTER TABLE `calendar`
  ADD CONSTRAINT `calendar_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `calendar_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `device_aps` (`id`),
  ADD CONSTRAINT `calendar_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  ADD CONSTRAINT `calendar_technik_id_foreign` FOREIGN KEY (`technic_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_alerts`
--
ALTER TABLE `device_alerts`
  ADD CONSTRAINT `device_alerts_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_antenna`
--
ALTER TABLE `device_antenna`
  ADD CONSTRAINT `device_antenna_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_antenna_params`
--
ALTER TABLE `device_antenna_params`
  ADD CONSTRAINT `device_antenna_params_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `device_antenna_params_device_antenna_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `object_devices` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_aps`
--
ALTER TABLE `device_aps`
  ADD CONSTRAINT `devices_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_limitations`
--
ALTER TABLE `device_limitations`
  ADD CONSTRAINT `device_limitations_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_reglament`
--
ALTER TABLE `device_reglament`
  ADD CONSTRAINT `device_reglament_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_reglament_element`
--
ALTER TABLE `device_reglament_element`
  ADD CONSTRAINT `device_reglament_element_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `device_reglament_element_dvice_reglament_id_foreign` FOREIGN KEY (`device_reglament_id`) REFERENCES `device_reglament` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_rspi`
--
ALTER TABLE `device_rspi`
  ADD CONSTRAINT `device_rspi_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_rspi_params`
--
ALTER TABLE `device_rspi_params`
  ADD CONSTRAINT `device_rspi_params_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `device_rspi_params_object_devices_FK` FOREIGN KEY (`device_id`) REFERENCES `object_devices` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_system_voice_alerts`
--
ALTER TABLE `device_system_voice_alerts`
  ADD CONSTRAINT `device_system_voice_alerts_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_system_voice_alerts_devs`
--
ALTER TABLE `device_system_voice_alerts_devs`
  ADD CONSTRAINT `device_system_voice_alerts_devs_bti_files_id_foreign` FOREIGN KEY (`bti_files_id`) REFERENCES `bti_files` (`id`),
  ADD CONSTRAINT `device_system_voice_alerts_devs_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `device_system_voice_alerts_devs_device_alerts_id_foreign` FOREIGN KEY (`device_alerts_id`) REFERENCES `device_alerts` (`id`);

--
-- Ограничения внешнего ключа таблицы `districtsobjects`
--
ALTER TABLE `districtsobjects`
  ADD CONSTRAINT `districtsobjects_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `districtsobjects_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `districtsusers`
--
ALTER TABLE `districtsusers`
  ADD CONSTRAINT `districtsusers_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`),
  ADD CONSTRAINT `districtsusers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `objects`
--
ALTER TABLE `objects`
  ADD CONSTRAINT `objects_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `objects_raion_id_foreign` FOREIGN KEY (`raion_id`) REFERENCES `raions` (`id`);

--
-- Ограничения внешнего ключа таблицы `objects_mediafiles`
--
ALTER TABLE `objects_mediafiles`
  ADD CONSTRAINT `objects_mediafiles_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`);

--
-- Ограничения внешнего ключа таблицы `object_devices`
--
ALTER TABLE `object_devices`
  ADD CONSTRAINT `object_devices_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `object_devices_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`);

--
-- Ограничения внешнего ключа таблицы `object_device_reglament`
--
ALTER TABLE `object_device_reglament`
  ADD CONSTRAINT `object_device_reglament_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `object_device_reglament_object_device_id_foreign` FOREIGN KEY (`object_device_id`) REFERENCES `object_devices` (`id`),
  ADD CONSTRAINT `object_device_reglament_technik_id_foreign` FOREIGN KEY (`technik_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `object_device_reglament_limitations`
--
ALTER TABLE `object_device_reglament_limitations`
  ADD CONSTRAINT `object_device_reglament_limitations_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `object_device_reglament_limitations_dl_id_foreign` FOREIGN KEY (`DL_id`) REFERENCES `device_limitations` (`id`),
  ADD CONSTRAINT `object_device_reglament_limitations_object_device_id_foreign` FOREIGN KEY (`object_device_id`) REFERENCES `object_devices` (`id`),
  ADD CONSTRAINT `object_device_reglament_limitations_odr_id_foreign` FOREIGN KEY (`ODR_id`) REFERENCES `object_device_reglament` (`id`);

--
-- Ограничения внешнего ключа таблицы `object_repair_queue`
--
ALTER TABLE `object_repair_queue`
  ADD CONSTRAINT `object_repair_queue_finder_id_foreign` FOREIGN KEY (`finder_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `object_repair_queue_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  ADD CONSTRAINT `object_repair_queue_repairer_id_foreign` FOREIGN KEY (`repairer_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `sensors`
--
ALTER TABLE `sensors`
  ADD CONSTRAINT `sensors_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_raion_id_foreign` FOREIGN KEY (`raion_id`) REFERENCES `raions` (`id`);

--
-- Ограничения внешнего ключа таблицы `wires`
--
ALTER TABLE `wires`
  ADD CONSTRAINT `wires_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `wire_previous_state`
--
ALTER TABLE `wire_previous_state`
  ADD CONSTRAINT `wire_previous_state_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `wire_previous_state_wire_id_foreign` FOREIGN KEY (`wire_id`) REFERENCES `wires` (`id`);

--
-- Ограничения внешнего ключа таблицы `wire_sensor`
--
ALTER TABLE `wire_sensor`
  ADD CONSTRAINT `wire_sensor_bti_files_id_foreign` FOREIGN KEY (`bti_files_id`) REFERENCES `bti_files` (`id`),
  ADD CONSTRAINT `wire_sensor_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `wire_sensor_sensor_id_foreign` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`);

--
-- Ограничения внешнего ключа таблицы `wire_sensor_previous_state`
--
ALTER TABLE `wire_sensor_previous_state`
  ADD CONSTRAINT `wire_sensor_previous_state_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `wire_sensor_previous_state_wire_sensor_id_foreign` FOREIGN KEY (`wire_sensor_id`) REFERENCES `wire_sensor` (`id`);

--
-- Ограничения внешнего ключа таблицы `wire_sensor_reglament`
--
ALTER TABLE `wire_sensor_reglament`
  ADD CONSTRAINT `wire_sensor_reglament_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `wire_sensor_reglament_wire_sensor_id_foreign` FOREIGN KEY (`wire_sensor_id`) REFERENCES `wire_sensor` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
