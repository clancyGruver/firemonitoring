-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Авг 01 2019 г., 05:28
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
(7, 6, 3, 'plan-bti.jpg', '2019-07-30 10:51:41', '2019-07-30 10:49:53', '2019-07-30 10:51:41', 'floor 1');

-- --------------------------------------------------------

--
-- Структура таблицы `calendar`
--

CREATE TABLE `calendar` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `technik_id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED DEFAULT NULL,
  `job_type` set('repair','reglament','installation') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reglament_dev_type` set('sensor','wire','device') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reglament_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_alerts`
--

INSERT INTO `device_alerts` (`id`, `name`, `type`, `power`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'AL-S58 (VS-85)', 'sound', 30, 3, NULL, '2019-06-23 09:58:56', '2019-06-23 09:58:56'),
(2, 'Соната-М', 'voice', 3, 3, NULL, '2019-06-23 10:14:15', '2019-06-23 11:04:11'),
(3, 'Свет-1', 'light', 5, 3, NULL, '2019-07-01 06:47:38', '2019-07-01 06:47:38');

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
(3, 'Антенна-2', NULL, 3, NULL, '2019-06-23 06:45:02', '2019-06-23 06:45:02');

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
(2, 16, 'Roof2', 1, 40.00, 'RK 50', 3, NULL, '2019-07-10 07:24:01', '2019-07-10 08:26:45');

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
(10, 'АМП-20', 20, NULL, 3, '2019-05-27 16:47:37', '2019-05-27 16:47:37', NULL),
(11, 'FVG-6', 6, NULL, 3, '2019-06-20 07:19:51', '2019-06-20 07:19:51', NULL);

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
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `device_reglament`
--

CREATE TABLE `device_reglament` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` tinyint(4) NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `dvice_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `device_reglament_element`
--

CREATE TABLE `device_reglament_element` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dvice_reglament_id` smallint(5) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(5, 'РСПИ-2', 'Таблиа общих сведений по АПС.xlsx', 3, NULL, '2019-06-23 08:04:56', '2019-06-23 08:04:56');

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
(3, '1 cabinet', 0, 0, 600.00, 'fault', 3, 17, NULL, '2019-07-25 07:42:55', '2019-07-25 07:47:30');

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
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `device_system_voice_alerts`
--

INSERT INTO `device_system_voice_alerts` (`id`, `name`, `created_user_id`, `deleted_at`, `created_at`, `updated_at`, `instruction`) VALUES
(1, 'СРО-12', 3, NULL, '2019-06-23 07:59:03', '2019-06-23 08:00:17', 'Таблиа общих сведений по АПС.xlsx'),
(2, 'СРО-2', 3, NULL, '2019-06-23 08:00:48', '2019-06-23 08:00:48', 'Таблиа общих сведений по АПС.xlsx'),
(3, 'СРО-3-1', 3, NULL, '2019-06-23 08:02:16', '2019-06-23 08:02:38', 'Таблиа общих сведений по АПС.xlsx');

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
(3, 19, 1, 3, NULL, '2019-07-16 11:00:54', '2019-07-19 07:37:10', 1, '72.7836186', '-178.6250000');

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
(56, '2019_07_25_075351_add__o_d_isgood', 33);

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
(2, NULL, 'firemonitoring Password Grant Client', '52L7wvgVG9SFw5avqLsW6JHJCvAfycqkyk1wVWeM', 'http://localhost', 0, 1, 0, '2019-05-21 09:40:24', '2019-05-21 09:40:24');

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
(1, 1, '2019-05-21 09:40:24', '2019-05-21 09:40:24');

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
  `soue_type` set('1','2','3','4','5') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `objects`
--

INSERT INTO `objects` (`id`, `name`, `raion_id`, `address`, `lng`, `lat`, `is_active`, `contact_name`, `contact_phone`, `director_name`, `director_phone`, `created_user_id`, `created_at`, `updated_at`, `project_isset`, `project_cipher`, `project_year`, `soue_type`) VALUES
(1, 'Детский сад', 42, 'Сталеваров 16', '61.4012139', '55.2661825', 1, 'Петров', '654321', 'Иванов', '123456', NULL, '2019-05-19 17:18:00', '2019-05-23 10:00:57', 0, NULL, NULL, '1'),
(2, 'ТЕст2', 42, 'Сталеваров, 15', '61.4034160', '55.2575960', 0, 'ПППП', '456', 'ИИИ', '123', NULL, '2019-05-19 17:51:42', '2019-05-22 06:05:58', 0, NULL, NULL, '1'),
(3, 'Ntcn 3', 42, 'Худякова 15', '61.3739600', '55.1473250', 0, 'ЙЙЙЙ', '654', 'ККК', '123', NULL, '2019-05-19 17:52:40', '2019-05-22 19:27:19', 0, NULL, NULL, '1'),
(4, 'кккк', 42, 'Пушкина 68', '61.4096140', '55.1567490', 1, 'ЕЕЕ', '645', 'РРР', '123', NULL, '2019-05-19 17:54:28', '2019-05-19 17:54:28', 0, NULL, NULL, '1'),
(5, 'Иванов Иван', 11, 'erwer', '58.2225649', '54.6835573', 1, 'qwerea', '2342', 'werw', '23423', 3, '2019-05-22 08:49:40', '2019-05-22 08:49:40', 0, NULL, NULL, '1'),
(6, 'Школа №137', 42, 'прапврп', '61.3854861', '55.1857041', 1, 'аврвар', '456456', 'првар', '45645', 3, '2019-05-26 11:23:19', '2019-07-31 06:37:14', 1, 'ш-21б-56', 2010, '3'),
(7, 'Детский сад \"Березка\"', 1, 'с. Агаповка , ул Советская, 45', '59.1301774', '53.2955676', 1, 'Петров Петр', '123456', 'Иванов Иван', '123456', 3, '2019-07-26 10:14:32', '2019-07-26 10:14:32', 1, 'Ш-125-1987', 1984, '1');

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
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `setup_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tbl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `bti_files_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `is_good` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `object_devices`
--

INSERT INTO `object_devices` (`id`, `object_id`, `device_id`, `created_user_id`, `created_at`, `updated_at`, `setup_place`, `tbl_name`, `deleted_at`, `bti_files_id`, `lng`, `lat`, `is_good`) VALUES
(1, 6, 9, 3, '2019-05-27 17:05:27', '2019-07-31 06:40:48', '', 'App\\device_aps', NULL, 1, '17.2530893', '-43.0000000', 1),
(13, 6, 9, 3, '2019-06-19 08:31:43', '2019-07-01 10:20:20', '', 'App\\device_aps', NULL, 3, '41.3594979', '-98.8750000', 1),
(14, 6, 10, 3, '2019-06-20 06:24:46', '2019-06-20 06:28:16', '', 'App\\device_aps', '2019-06-20 06:28:16', 0, '0.0000000', '0.0000000', 1),
(15, 6, 10, 3, '2019-06-20 06:28:19', '2019-07-01 10:27:20', '', 'App\\device_aps', NULL, 1, '59.8525665', '-119.0000000', 1),
(16, 6, 1, 3, '2019-06-28 06:49:25', '2019-07-19 07:37:22', '', 'App\\device_antenna', NULL, 1, '16.7528143', '-70.1250000', 1),
(17, 6, 3, 3, '2019-06-28 07:08:08', '2019-07-25 09:23:51', '', 'App\\device_rspi', NULL, 1, '71.7830685', '-87.7500000', 0),
(18, 6, 1, 3, '2019-06-28 07:08:14', '2019-07-25 09:23:46', '', 'App\\device_alert', NULL, 1, '104.3358936', '-94.5000000', 1),
(19, 6, 1, 3, '2019-06-28 07:08:21', '2019-07-19 07:37:10', '', 'App\\device_system_voice_alert', NULL, 1, '125.3124976', '-150.6250000', 1),
(20, 6, 3, 3, '2019-07-01 11:01:33', '2019-07-01 11:02:39', '', 'App\\device_alert', NULL, 1, '98.3381416', '-146.8750000', 1),
(21, 6, 2, 3, '2019-07-01 11:01:40', '2019-07-01 11:02:43', '', 'App\\device_alert', NULL, 1, '26.8649307', '-140.8750000', 1);

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
  `ODR_id` bigint(20) UNSIGNED NOT NULL,
  `DL_id` smallint(5) UNSIGNED NOT NULL,
  `created_user_id` bigint(20) UNSIGNED NOT NULL,
  `additional_limitation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `repairer_id` bigint(20) UNSIGNED NOT NULL,
  `broken_object_id` bigint(20) UNSIGNED NOT NULL,
  `limitation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `raions`
--

INSERT INTO `raions` (`id`, `name`, `lng`, `lat`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Агаповский муниципальный район', '59.2974060', '53.2702650', 1, '2019-05-18 14:51:15', '2019-07-26 10:10:10'),
(2, 'Аргаяшский муниципальный район', '60.7585870', '55.4137190', 1, '2019-05-18 14:51:15', '2019-07-26 10:10:10'),
(3, 'Ашинский муниципальный район', '57.5703410', '55.0506640', 0, '2019-05-18 14:51:16', '2019-05-19 08:49:52'),
(4, 'Брединский муниципальный район', '60.3067080', '52.4326830', 0, '2019-05-18 14:51:16', '2019-05-19 08:49:53'),
(5, 'Варненский муниципальный район', '61.3553920', '53.1380460', 0, '2019-05-18 14:51:17', '2019-05-19 08:49:55'),
(6, 'Верхнеуральский муниципальный район', '59.1980970', '53.8143360', 0, '2019-05-18 14:51:17', '2019-05-19 08:49:57'),
(7, 'Еманжелинский муниципальный район', '61.3269150', '54.7427410', 0, '2019-05-18 14:51:18', '2019-05-27 05:17:03'),
(8, 'Еткульский муниципальный район', '61.5793420', '54.7634150', 0, '2019-05-18 14:51:18', '2019-05-27 05:17:04'),
(9, 'Карталинский муниципальный район', '60.3992790', '53.0443540', 0, '2019-05-18 14:51:18', '2019-05-27 05:17:05'),
(10, 'Каслинский муниципальный район', '61.4167830', '56.1570470', 0, '2019-05-18 14:51:18', '2019-05-27 05:17:07'),
(11, 'Катав-Ивановский муниципальный район', '58.2114860', '54.6961840', 0, '2019-05-18 14:51:19', '2019-05-27 05:17:07'),
(12, 'Кизильский муниципальный район', '59.2993640', '52.7499710', 0, '2019-05-18 14:51:19', '2019-05-27 05:17:08'),
(13, 'Коркинский муниципальный район', '61.3768800', '54.9151870', 0, '2019-05-18 14:51:20', '2019-05-27 05:17:09'),
(14, 'Красноармейский муниципальный район', '62.0510920', '55.4430210', 0, '2019-05-18 14:51:20', '2019-05-27 05:17:10'),
(15, 'Кунашакский муниципальный район', '61.6226950', '55.8362820', 0, '2019-05-18 14:51:21', '2019-05-27 05:17:13'),
(16, 'Кусинский муниципальный район', '59.5826030', '55.4120120', 0, '2019-05-18 14:51:21', '2019-05-27 05:17:14'),
(17, 'Нагайбакский муниципальный район', '59.8283190', '53.5595940', 0, '2019-05-18 14:51:21', '2019-05-27 05:17:16'),
(18, 'Нязепетровский муниципальный район ', '59.5755150', '55.9682770', 0, '2019-05-18 14:51:22', '2019-05-27 05:17:16'),
(19, 'Октябрьский муниципальный район', '62.7072580', '54.3837140', 0, '2019-05-18 14:51:22', '2019-05-27 05:17:17'),
(20, 'Пластовский муниципальный район', '60.6766610', '54.3747470', 0, '2019-05-18 14:51:22', '2019-05-27 05:17:18'),
(21, 'Саткинский муниципальный район', '58.9971080', '54.9784520', 0, '2019-05-18 14:51:23', '2019-05-27 05:17:18'),
(22, 'Сосновский муниципальный район', '61.1986450', '55.2309900', 0, '2019-05-18 14:51:23', '2019-05-27 05:17:19'),
(23, 'Троицкий муниципальный район', '61.2930670', '54.1754920', 0, '2019-05-18 14:51:24', '2019-05-27 05:17:20'),
(24, 'Увельский муниципальный район', '61.4957540', '54.4851620', 0, '2019-05-18 14:51:24', '2019-05-27 05:17:20'),
(25, 'Уйский муниципальный район', '60.0910580', '54.3855650', 0, '2019-05-18 14:51:24', '2019-05-27 05:17:22'),
(26, 'Чебаркульский муниципальный район', '60.5207130', '54.8279980', 0, '2019-05-18 14:51:25', '2019-05-27 05:17:23'),
(27, 'Чесменский муниципальный район', '60.5706960', '53.7258610', 0, '2019-05-18 14:51:25', '2019-05-27 05:17:23'),
(28, 'Верхнеуфалейский городской округ', '60.2319500', '56.0487210', 0, '2019-05-18 14:58:20', '2019-05-27 05:17:26'),
(29, 'Златоустовский городской округ', '59.6724250', '55.1731080', 0, '2019-05-18 14:58:20', '2019-05-27 05:17:28'),
(30, 'Карабашский городской округ', '60.2030420', '55.4907890', 0, '2019-05-18 14:58:21', '2019-05-27 05:17:28'),
(31, 'Копейский городской округ', '61.6179700', '55.1167320', 0, '2019-05-18 14:58:21', '2019-05-27 05:17:29'),
(32, 'Кыштымский городской округ', '60.5389490', '55.7078770', 0, '2019-05-18 14:58:22', '2019-05-27 05:17:29'),
(33, 'Локомотивный городской округ', '60.6139230', '53.0452210', 0, '2019-05-18 14:58:22', '2019-05-27 05:17:30'),
(34, 'Магнитогорский городской округ', '58.9802820', '53.4071580', 0, '2019-05-18 14:58:23', '2019-05-27 05:17:31'),
(35, 'Миасский городской округ', '60.1080810', '55.0464140', 0, '2019-05-18 14:58:23', '2019-05-27 05:17:32'),
(36, 'Озерский городской округ', '60.7075990', '55.7631840', 0, '2019-05-18 14:58:23', '2019-05-27 05:17:33'),
(37, 'Снежинский городской округ', '60.7325360', '56.0852090', 0, '2019-05-18 14:58:24', '2019-05-27 05:17:41'),
(38, 'Трехгорный городской округ', '58.4464230', '54.8178420', 0, '2019-05-18 14:58:24', '2019-05-27 05:17:40'),
(39, 'Троицкий городской округ', '61.5597590', '54.0832170', 0, '2019-05-18 14:58:25', '2019-05-27 05:17:40'),
(40, 'Усть-Катавский городской округ', '58.1747000', '54.9302890', 0, '2019-05-18 14:58:25', '2019-05-27 05:17:39'),
(41, 'Чебаркульский городской округ', '60.3701200', '54.9777850', 0, '2019-05-18 14:58:25', '2019-05-27 05:17:38'),
(42, 'Челябинский городской округ', '61.4025540', '55.1598970', 1, '2019-05-18 14:58:26', '2019-05-18 14:58:26'),
(43, 'Южноуральский городской округ', '61.2682290', '54.4424550', 0, '2019-05-18 14:58:26', '2019-05-22 04:51:51');

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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sensors`
--

INSERT INTO `sensors` (`id`, `is_automate`, `power_supply`, `is_address`, `standalon_function`, `standalon_smoke_is_radioisotop`, `automate_attribute`, `automate_reaction`, `created_user_id`, `is_active`, `created_at`, `updated_at`, `name`) VALUES
(1, 0, 'stand-alone', 0, NULL, NULL, NULL, NULL, 3, 1, '2019-06-08 10:29:11', '2019-06-08 10:29:11', 'asd'),
(2, 0, 'separate wire', 0, NULL, NULL, NULL, NULL, 3, 0, '2019-06-08 11:51:43', '2019-06-08 11:52:48', 'dsa'),
(3, 0, 'wire', 0, NULL, NULL, NULL, NULL, 3, 0, '2019-06-08 11:55:02', '2019-06-08 11:55:07', 'qwe'),
(4, 0, 'wire', 0, NULL, NULL, 'combine', 'differincial', 3, 1, '2019-06-11 08:42:01', '2019-06-11 08:42:01', 'qwe'),
(5, 0, 'stand-alone', 0, 'smoke', 0, NULL, NULL, 3, 1, '2019-06-11 08:44:36', '2019-06-11 08:44:36', 'qwesd');

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
  `raion_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `password`, `api_token`, `is_active`, `is_admin`, `remember_token`, `created_at`, `updated_at`, `raion_id`) VALUES
(3, 'Иванов Иван', '1234567890', '$2y$10$UinZZ0DpOt3BKrrt3odbpeK9rsDXcMvfuU6tFO6VBT.Fg5dXDYRX.', 'i2buhDy4VFeAddHbaN9XtVGINHaBRnjUifqIxJQ4Q8x0UakU9CPDUj0zTTL0', 1, 1, NULL, '2019-05-19 12:52:18', '2019-05-19 12:52:18', 42),
(5, 'Simonov Sergey', '1523456789', '$2y$10$2ljpt1zqxF3ib95ATFJlc.CFrhbL0W07Wwm4CkHPRPDQpGVQISlv.', NULL, 1, 0, NULL, '2019-06-12 08:14:24', '2019-06-12 08:40:33', 42);

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
(5, 1, 3, 1, 'radio', NULL, 'radio', 1, '2019-06-13 08:16:45', '2019-06-13 08:16:45');

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
(1, 1, 5, 3, '1', 3, '32', 1, 1, '2019-06-11 07:56:34', '2019-07-19 07:37:36', NULL, NULL, 1, '117.3768158', '-46.5000000'),
(2, 1, 1, 3, '2', 1, '11', 1, 0, '2019-06-12 12:48:39', '2019-07-04 09:19:46', 'Перенесен из 12 кабинета', NULL, NULL, NULL, NULL),
(3, 1, 1, 3, '3', 1, '12', 1, 1, '2019-06-12 12:48:46', '2019-06-12 13:21:36', 'После ремонта', NULL, NULL, NULL, NULL),
(4, 1, 1, 3, '4', 1, '14', 1, 1, '2019-06-12 12:52:20', '2019-06-12 12:52:20', '', NULL, NULL, NULL, NULL),
(5, 1, 1, 3, '5', 1, '15', 1, 1, '2019-06-12 12:54:23', '2019-06-12 12:54:23', '', NULL, NULL, NULL, NULL),
(6, 1, 1, 3, '6', 1, '16', 1, 1, '2019-06-12 12:56:01', '2019-06-12 12:56:01', '', NULL, NULL, NULL, NULL),
(7, 1, 1, 3, '7', 1, 'ddd', 1, 1, '2019-07-04 04:45:37', '2019-07-04 07:08:28', NULL, '2019-07-04 07:08:28', NULL, NULL, NULL),
(8, 1, 1, 3, '8', 1, 'qqq', 0, 0, '2019-07-04 06:28:35', '2019-07-04 07:03:04', NULL, '2019-07-04 07:03:04', NULL, NULL, NULL),
(9, 1, 1, 3, '7', 1, '16', 1, 0, '2019-07-04 10:26:23', '2019-07-04 10:34:12', 'Проба пера', '2019-07-04 10:34:12', NULL, NULL, NULL);

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
(27, 1, 3, '1', 3, '32', 1, 1, 1, '2019-07-16 11:43:54', '2019-07-16 11:43:54', 1, 5);

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
  ADD KEY `calendar_technik_id_foreign` (`technik_id`),
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
  ADD KEY `device_reglament_dvice_id_foreign` (`dvice_id`);

--
-- Индексы таблицы `device_reglament_element`
--
ALTER TABLE `device_reglament_element`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_reglament_element_created_user_id_foreign` (`created_user_id`),
  ADD KEY `device_reglament_element_dvice_reglament_id_foreign` (`dvice_reglament_id`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `calendar`
--
ALTER TABLE `calendar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `device_alerts`
--
ALTER TABLE `device_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `device_antenna`
--
ALTER TABLE `device_antenna`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `device_antenna_params`
--
ALTER TABLE `device_antenna_params`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `device_aps`
--
ALTER TABLE `device_aps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `device_class`
--
ALTER TABLE `device_class`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `device_limitations`
--
ALTER TABLE `device_limitations`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `device_reglament`
--
ALTER TABLE `device_reglament`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `device_reglament_element`
--
ALTER TABLE `device_reglament_element`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `device_rspi`
--
ALTER TABLE `device_rspi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `device_rspi_params`
--
ALTER TABLE `device_rspi_params`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `device_system_voice_alerts`
--
ALTER TABLE `device_system_voice_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `device_system_voice_alerts_devs`
--
ALTER TABLE `device_system_voice_alerts_devs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT для таблицы `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `objects`
--
ALTER TABLE `objects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `objects_mediafiles`
--
ALTER TABLE `objects_mediafiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `object_devices`
--
ALTER TABLE `object_devices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `object_device_reglament`
--
ALTER TABLE `object_device_reglament`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `object_device_reglament_limitations`
--
ALTER TABLE `object_device_reglament_limitations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `object_repair_queue`
--
ALTER TABLE `object_repair_queue`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `raions`
--
ALTER TABLE `raions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT для таблицы `sensors`
--
ALTER TABLE `sensors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `wires`
--
ALTER TABLE `wires`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `wire_previous_state`
--
ALTER TABLE `wire_previous_state`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `wire_sensor`
--
ALTER TABLE `wire_sensor`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `wire_sensor_previous_state`
--
ALTER TABLE `wire_sensor_previous_state`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
  ADD CONSTRAINT `calendar_technik_id_foreign` FOREIGN KEY (`technik_id`) REFERENCES `users` (`id`);

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
  ADD CONSTRAINT `device_limitations_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `device_limitations_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `device_aps` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_reglament`
--
ALTER TABLE `device_reglament`
  ADD CONSTRAINT `device_reglament_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `device_reglament_dvice_id_foreign` FOREIGN KEY (`dvice_id`) REFERENCES `device_aps` (`id`);

--
-- Ограничения внешнего ключа таблицы `device_reglament_element`
--
ALTER TABLE `device_reglament_element`
  ADD CONSTRAINT `device_reglament_element_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `device_reglament_element_dvice_reglament_id_foreign` FOREIGN KEY (`dvice_reglament_id`) REFERENCES `device_reglament` (`id`);

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
  ADD CONSTRAINT `object_repair_queue_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `device_aps` (`id`),
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
  ADD CONSTRAINT `wires_created_user_id_foreign` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `wires_object_device_id_foreign` FOREIGN KEY (`object_device_id`) REFERENCES `object_devices` (`id`);

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
  ADD CONSTRAINT `wire_sensor_sensor_id_foreign` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`),
  ADD CONSTRAINT `wire_sensor_wire_id_foreign` FOREIGN KEY (`wire_id`) REFERENCES `wires` (`id`);

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
