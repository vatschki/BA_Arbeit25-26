-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Erstellungszeit: 11. Mrz 2026 um 14:17
-- Server-Version: 8.0.35
-- PHP-Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `ESG_ETL_BA_local`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auditors`
--

CREATE TABLE `auditors` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `auditors`
--

INSERT INTO `auditors` (`id`, `name`, `description`, `type`, `timestamp`) VALUES
(1, 'KPMG', 'KPMG - TEST', 'Prüfer', '2025-12-23 15:30:37'),
(2, 'DELOITTE', 'Deloitte ist eines der weltweit führenden Prüfungs- und Beratungsunternehmen (Teil der „Big Four“) mit über 460.000 Mitarbeitern in mehr als 150 Ländern. Das Unternehmen bietet Dienstleistungen in den Bereichen Audit & Assurance, Risk Advisory, Tax & Legal, Financial Advisory und Consulting an.', 'Prüfer', '2026-01-29 14:17:26'),
(3, 'test', '', NULL, '2026-02-02 15:45:50');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `audit_report`
--

CREATE TABLE `audit_report` (
  `ID` int NOT NULL,
  `auditor_id` int NOT NULL,
  `report_id` int NOT NULL,
  `description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auth_groups_users`
--

CREATE TABLE `auth_groups_users` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `auth_groups_users`
--

INSERT INTO `auth_groups_users` (`id`, `user_id`, `group`, `created_at`) VALUES
(2, 1, 'admin', '2026-01-21 13:50:42'),
(3, 5, 'sub_admin', '2026-01-28 16:43:01'),
(4, 6, 'sub_admin', '2026-01-28 19:39:59');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auth_identities`
--

CREATE TABLE `auth_identities` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `secret` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `secret2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `extra` text COLLATE utf8mb4_general_ci,
  `force_reset` tinyint(1) NOT NULL DEFAULT '0',
  `last_used_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `auth_identities`
--

INSERT INTO `auth_identities` (`id`, `user_id`, `type`, `name`, `secret`, `secret2`, `expires`, `extra`, `force_reset`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'email_password', NULL, 'test@gmx.de', '$2y$12$pphXNhsbVMtuQg0KkYTm7uUMAonHxY/cAGMbHGyXO6kaPDbvuVxye', NULL, NULL, 0, '2026-03-11 13:26:56', '2026-01-21 13:49:48', '2026-03-11 13:26:56'),
(5, 5, 'email_password', NULL, 'testolino@gmail.com', '$2y$12$YhKNVP3F.PS8ryuPzBKtHuLRjaFhwiSgRWx3VyDUL2VjWvUfdls36', NULL, NULL, 0, NULL, '2026-01-28 16:43:00', '2026-01-28 16:43:01'),
(6, 6, 'email_password', NULL, 'test2@gmail.de', '$2y$12$Q/M1k416VZJ0Z9V1aflA3O2RTiXko4wvcSRV207p/Yi7TLdWD/qie', NULL, NULL, 0, '2026-01-28 19:42:14', '2026-01-28 19:39:58', '2026-01-28 19:42:14');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auth_logins`
--

CREATE TABLE `auth_logins` (
  `id` int UNSIGNED NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `auth_logins`
--

INSERT INTO `auth_logins` (`id`, `ip_address`, `user_agent`, `id_type`, `identifier`, `user_id`, `date`, `success`) VALUES
(1, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-21 16:51:27', 1),
(2, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', NULL, '2026-01-21 21:37:17', 0),
(3, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-21 21:37:38', 1),
(4, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-22 12:43:43', 1),
(5, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-23 14:07:22', 1),
(6, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-23 16:38:24', 1),
(7, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-25 14:31:25', 1),
(8, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-26 09:13:59', 1),
(9, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-26 15:08:22', 1),
(10, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-27 20:12:38', 1),
(11, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-28 11:06:19', 1),
(12, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-28 15:48:56', 1),
(13, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-28 19:32:02', 1),
(14, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test2@gmail.de', 6, '2026-01-28 19:42:14', 1),
(15, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-29 11:43:55', 1),
(16, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-29 11:44:07', 1),
(17, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-29 18:45:50', 1),
(18, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-30 13:12:41', 1),
(19, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-30 16:57:22', 1),
(20, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-01-31 10:10:53', 1),
(21, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-01 15:58:07', 1),
(22, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-02 10:22:04', 1),
(23, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-02 13:46:26', 1),
(24, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-02 14:33:13', 1),
(25, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-02 17:13:24', 1),
(26, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-03 11:27:31', 1),
(27, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-11 14:55:13', 1),
(28, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-19 09:58:34', 1),
(29, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-19 15:30:08', 1),
(30, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-19 21:10:33', 1),
(31, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-26 09:30:18', 1),
(32, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-02-28 10:48:54', 1),
(33, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-01 11:47:40', 1),
(34, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-03 10:31:34', 1),
(35, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-03 10:42:49', 1),
(36, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-03 12:02:18', 1),
(37, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-03 12:06:27', 1),
(38, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-06 17:29:00', 1),
(39, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-10 16:25:49', 1),
(40, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'email_password', 'test@gmx.de', 1, '2026-03-11 13:26:56', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auth_permissions_users`
--

CREATE TABLE `auth_permissions_users` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `permission` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auth_remember_tokens`
--

CREATE TABLE `auth_remember_tokens` (
  `id` int UNSIGNED NOT NULL,
  `selector` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `hashedValidator` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `expires` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auth_token_logins`
--

CREATE TABLE `auth_token_logins` (
  `id` int UNSIGNED NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `companies`
--

CREATE TABLE `companies` (
  `id` int NOT NULL,
  `industry_id` int NOT NULL,
  `country_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `companies`
--

INSERT INTO `companies` (`id`, `industry_id`, `country_id`, `name`, `description`, `timestamp`) VALUES
(1, 2, 1, 'Henkel', 'Die Henkel AG & Co. KGaA mit Hauptsitz in Düsseldorf-Holthausen ist ein börsennotiertes deutsches Unternehmen der Konsumgüter- und Klebstoffindustrie mit weltweiten Marken und Technologien in den Geschäftsfeldern Consumer Brands und Adhesive Technologies.', '2025-12-08 17:24:20'),
(4, 2, 7, 'L\'Oréal', 'Die L\'Oréal S.A. ist ein französischer Konsumgüterkonzern mit Hauptsitz in Paris und derzeit der größte Kosmetikhersteller der Welt.\r\n                                            ', '2025-12-10 20:06:41'),
(8, 4, 1, 'Deutsche Telekom', 'Die Deutsche Telekom AG ist Europas größter Telekommunikationsanbieter mit Hauptsitz in Bonn, der aus der Privatisierung der Deutschen Bundespost hervorging und Produkte für Festnetz, Mobilfunk, Internet (DSL, Glasfaser) und MagentaTV anbietet.', '2026-01-21 23:20:52'),
(31, 14, 1, 'BASF', 'Die BASF SE, 1865 gegründet und mit Hauptsitz in Ludwigshafen am Rhein, ist der weltweit größte Chemiekonzern.', '2026-01-29 14:15:24'),
(32, 14, 2, 'Lenzing', 'Die Lenzing Gruppe ist ein weltweit führender österreichischer Hersteller von nachhaltigen, holzbasierten Cellulosefasern (Viskose, Lyocell, Modal) für Textilien, Vliesstoffe und Schutzbekleidung. Das Unternehmen setzt auf umweltfreundliche Technologien, biologische Abbaubarkeit und eine Bioraffinerie-Produktion, bei der Holz zu 100 % genutzt wird. Bekannte Marken sind TENCEL™, LENZING™ ECOVERO™ und VEOCEL™.', '2026-02-02 21:06:54'),
(33, 14, 15, 'Yara international', 'Yara International ASA, mit Hauptsitz in Oslo, Norwegen, ist ein weltweit führendes Unternehmen für Pflanzenernährung, das 1905 gegründet wurde. Es produziert und vertreibt Stickstoffdünger, Ammoniak und industrielle Produkte. Mit ca. 17.000 Mitarbeitern ist Yara in über 60 Ländern aktiv und wandelt Erdgas in umweltfreundliche Lösungen für Landwirtschaft und Industrie um.', '2026-02-02 21:09:30'),
(34, 17, 17, 'Orsted', 'Ørsted, mit Hauptsitz in Dänemark, ist der weltweit führende Entwickler und Betreiber von Offshore-Windparks und eines der führenden Unternehmen für grüne Energie. Das Unternehmen wandelt sich aktiv vom einst fossilen Energiekonzern (ehemals DONG Energy) zum Pionier der erneuerbaren Energien, der Offshore- und Onshore-Windparks, Solarparks, Bioenergieanlagen und Speicherlösungen baut, um die Welt vollständig auf grüne Energie umzustellen.', '2026-02-26 10:34:42');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `countries`
--

CREATE TABLE `countries` (
  `id` int NOT NULL,
  `code` varchar(100) NOT NULL,
  `name_de` varchar(200) NOT NULL,
  `name_eng` varchar(200) NOT NULL,
  `region` varchar(200) DEFAULT NULL,
  `eu_member` tinyint(1) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `countries`
--

INSERT INTO `countries` (`id`, `code`, `name_de`, `name_eng`, `region`, `eu_member`, `timestamp`) VALUES
(1, 'DEU', 'Deutschland', 'Germany', 'Westliches-Europa', 1, '2025-12-02 19:45:18'),
(2, 'AUT', 'Österreich', 'Austria', 'Westliches-Europa', 1, '2025-12-02 19:45:18'),
(3, 'LUX', 'Luxemburg', 'Luxembourg', 'Westliches-Europa', 1, '2025-12-02 19:45:18'),
(4, 'ITA', 'Italien', 'Italy', 'Südliches-Europa', 1, '2025-12-02 19:45:18'),
(5, 'ESP', 'Spanien', 'Spain', 'Südliches-Europa', 1, '2025-12-02 19:45:18'),
(6, 'PRT', 'Portugal ', 'Portugal', 'Südliches-Europa', 1, '2025-12-02 19:45:18'),
(7, 'FRA', 'Frankreich', 'France', 'Westliches-Europa', 1, '2025-12-02 19:45:18'),
(8, 'CHE', 'Schweiz', 'Swiss', 'Westliches-Europa', 0, '2025-12-02 19:45:18'),
(9, 'SE', 'Schweden', 'Sweden', 'Nördliches-Europa', 1, '2025-12-02 19:45:18'),
(10, 'HU', 'Ungarn', 'Hungary', 'Östliches-Europa', 1, '2025-12-02 19:45:18'),
(15, 'NOR', 'Norwegen', 'Norway', 'Nördliches-europa', 1, '2026-02-02 21:08:42'),
(17, 'DNK', 'Dänemark', 'Dennmark', 'Nördliches-Europa', 1, '2026-02-25 19:07:47');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `esrs_reportvalue`
--

CREATE TABLE `esrs_reportvalue` (
  `id` int NOT NULL,
  `requirement_id` int NOT NULL,
  `report_id` int NOT NULL,
  `job_id` int NOT NULL,
  `page_id` varchar(500) NOT NULL,
  `page` int NOT NULL,
  `text` varchar(1000) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `esrs_reportvalue`
--

INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(597, 12, 36, 29, '192-1-1', 192, 'Sites relevant to biodiversity', '2026-01-12 14:08:51'),
(598, 12, 36, 29, '192-1-2', 192, 'Cannon Falls (MN), USA', '2026-01-12 14:08:51'),
(599, 12, 36, 29, '192-1-3', 192, 'Dammam, Saudi Arabia', '2026-01-12 14:08:51'),
(600, 12, 36, 29, '192-1-4', 192, 'Drogenbos, Belgium', '2026-01-12 14:08:51'),
(601, 12, 36, 29, '192-1-5', 192, 'Düsseldorf- Holthausen, Germany', '2026-01-12 14:08:51'),
(602, 12, 36, 29, '192-1-6', 192, 'Elgin (IL), USA Climate change', '2026-01-12 14:08:51'),
(603, 12, 36, 29, '192-1-7', 192, 'Enoree (SC), USA', '2026-01-12 14:08:51'),
(604, 12, 36, 29, '192-1-8', 192, 'Jundiaí, Brazil', '2026-01-12 14:08:51'),
(605, 12, 36, 29, '192-1-9', 192, 'Környe- Tatabánya, Hungary', '2026-01-12 14:08:51'),
(606, 12, 36, 29, '193-1-10', 193, 'Maribor, Slovenia', '2026-01-12 14:08:51'),
(607, 12, 36, 29, '193-1-11', 193, 'Montornès, Spain', '2026-01-12 14:08:51'),
(608, 12, 36, 29, '193-1-12', 193, 'Pantelimon, Romania', '2026-01-12 14:08:51'),
(609, 13, 36, 29, '189-2-1', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(610, 14, 36, 29, '189-3-1', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(611, 15, 36, 29, '189-4-1', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(612, 16, 36, 29, '191-5-1', 191, 'Impacts related to land degradation, desertification or soil sealing in own operations (ESRS 2, SBM-3_16b) The materiality analysis that was performed did not identify any material impacts regarding land degradation, desertification or soil sealing in Henkel’s own operations or in the downstream value chain. In the upstream value chain, material impacts regarding land degradation from the extraction of biological raw materials were identified. Cultivation of these raw materials can lead to clearcutting of forests and destruction of natural habitats, which is a form of land degradation.', '2026-01-12 14:08:51'),
(613, 17, 36, 29, '191-6-1', 191, 'Operations impacting threatened species (ESRS 2, SBM-3_16c) Sites relevant to biodiversity identified by Henkel may also affect threatened species in their surrounding areas. Threatened species are defined according to the United Nations Red List as species categorized as “critically endangered,” “endangered” and “regionally extinct” (see International Union for Conservation of Nature, IUCN Red List of Threatened Species). Threatened species impacted by sites relevant to biodiversity are identified using the Species Threat Abatement and Restoration Metric (STAR). Potentially affected threat- ened species are listed in the table “Impacts of sites relevant to biodiversity on threatened species.”', '2026-01-12 14:08:51'),
(614, 18, 36, 29, '189-7-2', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(615, 31, 36, 29, '189-10-1', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(616, 32, 36, 29, '189-11-2', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(617, 42, 36, 29, '189-12-2', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(618, 49, 36, 29, '191-13-2', 191, 'Operations impacting threatened species (ESRS 2, SBM-3_16c) Sites relevant to biodiversity identified by Henkel may also affect threatened species in their surrounding areas. Threatened species are defined according to the United Nations Red List as species categorized as “critically endangered,” “endangered” and “regionally extinct” (see International Union for Conservation of Nature, IUCN Red List of Threatened Species). Threatened species impacted by sites relevant to biodiversity are identified using the Species Threat Abatement and Restoration Metric (STAR). Potentially affected threat- ened species are listed in the table “Impacts of sites relevant to biodiversity on threatened species.”', '2026-01-12 14:08:51'),
(619, 52, 36, 29, '189-14-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(620, 54, 36, 29, '189-15-2', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(621, 55, 36, 29, '189-16-2', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(622, 57, 36, 29, '189-17-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(623, 59, 36, 29, '189-18-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(624, 69, 36, 29, '189-19-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(625, 69, 36, 29, '189-19-2', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(626, 70, 36, 29, '189-20-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(627, 72, 36, 29, '189-21-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(628, 73, 36, 29, '189-22-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(629, 86, 36, 29, '189-23-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(630, 87, 36, 29, '189-24-1', 189, 'Henkel acknowledges these impacts and is committed to protecting and restoring biodiversity as part of its strategic orientation, with a particular focus on forests, land and water. In addition to applying these princi- ples to the activities at our own sites, we also promote the responsible management of raw materials and the use of ingredients based on renewable raw materials. The focus is particularly on the responsible sourcing of palm (kernel) oil and timber products, which have been identified as critical raw materials in relation to deforestation.', '2026-01-12 14:08:51'),
(631, 101, 36, 29, '189-25-1', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(632, 101, 36, 29, '192-25-2', 192, 'Sites relevant to biodiversity', '2026-01-12 14:08:51'),
(633, 101, 36, 29, '192-25-3', 192, 'Cannon Falls (MN), USA', '2026-01-12 14:08:51'),
(634, 101, 36, 29, '192-25-4', 192, 'Dammam, Saudi Arabia', '2026-01-12 14:08:51'),
(635, 101, 36, 29, '192-25-5', 192, 'Drogenbos, Belgium', '2026-01-12 14:08:51'),
(636, 101, 36, 29, '192-25-6', 192, 'Düsseldorf- Holthausen, Germany', '2026-01-12 14:08:51'),
(637, 101, 36, 29, '192-25-7', 192, 'Elgin (IL), USA Climate change', '2026-01-12 14:08:51'),
(638, 101, 36, 29, '192-25-8', 192, 'Enoree (SC), USA', '2026-01-12 14:08:51'),
(639, 101, 36, 29, '192-25-9', 192, 'Jundiaí, Brazil', '2026-01-12 14:08:51'),
(640, 101, 36, 29, '192-25-10', 192, 'Környe- Tatabánya, Hungary', '2026-01-12 14:08:51'),
(641, 101, 36, 29, '193-25-11', 193, 'Maribor, Slovenia', '2026-01-12 14:08:51'),
(642, 101, 36, 29, '193-25-12', 193, 'Montornès, Spain', '2026-01-12 14:08:51'),
(643, 101, 36, 29, '193-25-13', 193, 'Pantelimon, Romania', '2026-01-12 14:08:51'),
(644, 104, 36, 29, '189-26-2', 189, 'Activities and locations in biodiversity-sensitive areas (SBM-3_16a, 16a i, 16a ii, 16a iii) Henkel has identified sites within its own operations that may materially impact nearby areas with biodi- versity-sensitive areas (sites with relevance to biodiversity). The identification of these sites with relevance to biodiversity is based on proximity to biodiversity-sensitive areas and the two direct drivers of biodiversity loss identified in Henkel’s materiality analysis: Climate change and freshwater-use change. Direct exploitation of water is addressed through the assessment of freshwater-use change for identifying sites relevant to bio- diversity. The direct exploitation of biological resources, pollution, seawater use change and the introduction of invasive species were not identified as material within Henkel’s own operations and were therefore not considered in the identification of sites relevant to biodiversity.', '2026-01-12 14:08:51'),
(645, 117, 36, 29, '191-27-1', 191, 'Operations impacting threatened species (ESRS 2, SBM-3_16c) Sites relevant to biodiversity identified by Henkel may also affect threatened species in their surrounding areas. Threatened species are defined according to the United Nations Red List as species categorized as “critically endangered,” “endangered” and “regionally extinct” (see International Union for Conservation of Nature, IUCN Red List of Threatened Species). Threatened species impacted by sites relevant to biodiversity are identified using the Species Threat Abatement and Restoration Metric (STAR). Potentially affected threat- ened species are listed in the table “Impacts of sites relevant to biodiversity on threatened species.”', '2026-01-12 14:08:51'),
(646, 121, 36, 29, '191-28-1', 191, 'Operations impacting threatened species (ESRS 2, SBM-3_16c) Sites relevant to biodiversity identified by Henkel may also affect threatened species in their surrounding areas. Threatened species are defined according to the United Nations Red List as species categorized as “critically endangered,” “endangered” and “regionally extinct” (see International Union for Conservation of Nature, IUCN Red List of Threatened Species). Threatened species impacted by sites relevant to biodiversity are identified using the Species Threat Abatement and Restoration Metric (STAR). Potentially affected threat- ened species are listed in the table “Impacts of sites relevant to biodiversity on threatened species.”', '2026-01-12 14:08:51'),
(647, 122, 36, 29, '191-29-1', 191, 'Operations impacting threatened species (ESRS 2, SBM-3_16c) Sites relevant to biodiversity identified by Henkel may also affect threatened species in their surrounding areas. Threatened species are defined according to the United Nations Red List as species categorized as “critically endangered,” “endangered” and “regionally extinct” (see International Union for Conservation of Nature, IUCN Red List of Threatened Species). Threatened species impacted by sites relevant to biodiversity are identified using the Species Threat Abatement and Restoration Metric (STAR). Potentially affected threat- ened species are listed in the table “Impacts of sites relevant to biodiversity on threatened species.”', '2026-01-12 14:08:51'),
(648, 13, 36, 29, '195-34-1', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(649, 13, 36, 29, '195-34-2', 195, 'General threats to species in this region', '2026-01-12 14:08:51'),
(650, 13, 36, 29, '195-34-3', 195, 'Renewable energy generation, timber industry, livestock farming, hunting, animal', '2026-01-12 14:08:51'),
(651, 13, 36, 29, '195-34-4', 195, 'Identified negative impacts from Henkel’s activities', '2026-01-12 14:08:51'),
(652, 13, 36, 29, '195-34-5', 195, 'Hunting, livestock farming, animal diseases, habitat changes, pollutants from', '2026-01-12 14:08:51'),
(653, 13, 36, 29, '195-34-6', 195, 'industry and the military, other threats', '2026-01-12 14:08:51'),
(654, 13, 36, 29, '195-34-7', 195, 'Pollutants from agriculture and forestry, deforestation, hunting, industry, leisure time activities, transportation routes, grain farming, animal diseases, livestock farming, other, economic development, other changes to the ecosystem, timber industry, extreme temperatures, other threats', '2026-01-12 14:08:51'),
(655, 13, 36, 29, '195-34-8', 195, 'No negative impact identified', '2026-01-12 14:08:51'),
(656, 13, 36, 29, '195-34-9', 195, 'contribution to extreme tempera- tures by emitting GHG', '2026-01-12 14:08:51'),
(657, 15, 36, 29, '193-35-1', 193, 'Kooli tänav 3 tamm, Pärnu jõe hoiuala (Pärnu), Kooli tänav', '2026-01-12 14:08:51'),
(658, 15, 36, 29, '193-35-2', 193, 'Réserve Naturelle du Lac de Réghaïa', '2026-01-12 14:08:51'),
(659, 15, 36, 29, '194-35-3', 194, 'Chouteau Island Fish and Wildlife Area', '2026-01-12 14:08:51'),
(660, 15, 36, 29, '194-35-4', 194, 'Bosque El Nixticuil – San Esteban', '2026-01-12 14:08:51'),
(661, 15, 36, 29, '195-35-5', 195, 'Impacts of sites relevant to biodiversity on threatened species', '2026-01-12 14:08:51'),
(662, 15, 36, 29, '195-35-6', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(663, 15, 36, 29, '195-35-7', 195, 'General threats to species in this region', '2026-01-12 14:08:51'),
(664, 15, 36, 29, '195-35-8', 195, 'Renewable energy generation, timber industry, livestock farming, hunting, animal', '2026-01-12 14:08:51'),
(665, 15, 36, 29, '195-35-9', 195, 'Identified negative impacts from Henkel’s activities', '2026-01-12 14:08:51'),
(666, 15, 36, 29, '195-35-10', 195, 'No negative impact identified', '2026-01-12 14:08:51'),
(667, 15, 36, 29, '195-35-11', 195, 'contribution to extreme tempera- tures by emitting GHG', '2026-01-12 14:08:51'),
(668, 17, 36, 29, '195-36-1', 195, 'Impacts of sites relevant to biodiversity on threatened species', '2026-01-12 14:08:51'),
(669, 17, 36, 29, '195-36-2', 195, 'Threatened species', '2026-01-12 14:08:51'),
(670, 17, 36, 29, '195-36-3', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(671, 17, 36, 29, '195-36-4', 195, 'General threats to species in this region', '2026-01-12 14:08:51'),
(672, 17, 36, 29, '195-36-5', 195, 'Renewable energy generation, timber industry, livestock farming, hunting, animal', '2026-01-12 14:08:51'),
(673, 17, 36, 29, '195-36-6', 195, 'Identified negative impacts from Henkel’s activities', '2026-01-12 14:08:51'),
(674, 31, 36, 29, '193-37-1', 193, 'Pärnu, Estonia', '2026-01-12 14:08:51'),
(675, 31, 36, 29, '193-37-2', 193, 'Kooli tänav 3 tamm, Pärnu jõe hoiuala (Pärnu), Kooli tänav', '2026-01-12 14:08:51'),
(676, 31, 36, 29, '193-37-3', 193, '3c tamm, Kooli tänav 5 tamm, Pärnu jõe, Pärnu jõgi', '2026-01-12 14:08:51'),
(677, 31, 36, 29, '193-37-4', 193, 'Réghaïa, Algeria', '2026-01-12 14:08:51'),
(678, 31, 36, 29, '193-37-5', 193, 'Réserve Naturelle du Lac de Réghaïa', '2026-01-12 14:08:51'),
(679, 31, 36, 29, '194-37-6', 194, 'Chouteau Island Fish and Wildlife Area', '2026-01-12 14:08:51'),
(680, 31, 36, 29, '194-37-7', 194, 'Bosque El Nixticuil – San Esteban', '2026-01-12 14:08:51'),
(681, 31, 36, 29, '195-37-8', 195, 'Impacts of sites relevant to biodiversity on threatened species', '2026-01-12 14:08:51'),
(682, 31, 36, 29, '195-37-9', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(683, 31, 36, 29, '195-37-10', 195, 'Düsseldorf-Holthausen, Germany', '2026-01-12 14:08:51'),
(684, 31, 36, 29, '195-37-11', 195, 'Elgin (IL), USA', '2026-01-12 14:08:51'),
(685, 31, 36, 29, '195-37-12', 195, 'Kornye-Tatabánya, Hungary', '2026-01-12 14:08:51'),
(686, 31, 36, 29, '196-37-13', 196, 'Puffinus mauretanicus, Oryctolagus cuniculus, Neophron percnopterus, Falco cherrug', '2026-01-12 14:08:51'),
(687, 32, 36, 29, '195-38-1', 195, 'Impacts of sites relevant to biodiversity on threatened species', '2026-01-12 14:08:51'),
(688, 32, 36, 29, '195-38-2', 195, 'Threatened species', '2026-01-12 14:08:51'),
(689, 32, 36, 29, '195-38-3', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(690, 32, 36, 29, '195-38-4', 195, 'General threats to species in this region', '2026-01-12 14:08:51'),
(691, 32, 36, 29, '195-38-5', 195, 'Renewable energy generation, timber industry, livestock farming, hunting, animal', '2026-01-12 14:08:51'),
(692, 32, 36, 29, '195-38-6', 195, 'Identified negative impacts from Henkel’s activities', '2026-01-12 14:08:51'),
(693, 32, 36, 29, '195-38-7', 195, 'Hunting, livestock farming, animal diseases, habitat changes, pollutants from', '2026-01-12 14:08:51'),
(694, 32, 36, 29, '195-38-8', 195, 'industry and the military, other threats', '2026-01-12 14:08:51'),
(695, 32, 36, 29, '195-38-9', 195, 'Pollutants from agriculture and forestry, deforestation, hunting, industry, leisure time activities, transportation routes, grain farming, animal diseases, livestock farming, other, economic development, other changes to the ecosystem, timber industry, extreme temperatures, other threats', '2026-01-12 14:08:51'),
(696, 32, 36, 29, '195-38-10', 195, 'No negative impact identified', '2026-01-12 14:08:51'),
(697, 32, 36, 29, '195-38-11', 195, 'contribution to extreme tempera- tures by emitting GHG', '2026-01-12 14:08:51'),
(698, 32, 36, 29, '195-38-12', 195, 'Dams and water management, leisure time activities, animal diseases, pollutants from agriculture and forestry, habitat changes, tourism, deforestation, hunting, industry, grain farming, transportation routes, economic development, timber industry, other changes to the ecosystem, other threats', '2026-01-12 14:08:51'),
(699, 104, 36, 29, '194-39-1', 194, 'Climate change, fresh- water-use change', '2026-01-12 14:08:51'),
(700, 104, 36, 29, '195-39-2', 195, 'Usage of the infrastructure of', '2026-01-12 14:08:51'),
(701, 104, 36, 29, '195-39-3', 195, 'industrial areas', '2026-01-12 14:08:51'),
(702, 104, 36, 29, '195-39-4', 195, 'influencing water management by freshwater use', '2026-01-12 14:08:51'),
(703, 117, 36, 29, '195-40-1', 195, 'Impacts of sites relevant to biodiversity on threatened species', '2026-01-12 14:08:51'),
(704, 117, 36, 29, '195-40-2', 195, 'Threatened species', '2026-01-12 14:08:51'),
(705, 117, 36, 29, '195-40-3', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(706, 117, 36, 29, '195-40-4', 195, 'Calidris tenuirostris, Aquila nipalensis, Falco cherrug', '2026-01-12 14:08:51'),
(707, 117, 36, 29, '195-40-5', 195, 'Cricetus cricetus', '2026-01-12 14:08:51'),
(708, 117, 36, 29, '195-40-6', 195, 'Myotis lucifugus, Grus americana', '2026-01-12 14:08:51'),
(709, 117, 36, 29, '195-40-7', 195, 'Campephilus principalis, Myotis leibii, Myotis lucifugus', '2026-01-12 14:08:51'),
(710, 117, 36, 29, '195-40-8', 195, 'Cricetus cricetus, Spermophilus citellus, Otis tarda, Falco cherrug', '2026-01-12 14:08:51'),
(711, 117, 36, 29, '196-40-9', 196, 'Puffinus mauretanicus, Oryctolagus cuniculus, Neophron percnopterus, Falco cherrug', '2026-01-12 14:08:51'),
(712, 122, 36, 29, '195-41-1', 195, 'Impacts of sites relevant to biodiversity on threatened species', '2026-01-12 14:08:51'),
(713, 122, 36, 29, '195-41-2', 195, 'Threatened species', '2026-01-12 14:08:51'),
(714, 122, 36, 29, '195-41-3', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(715, 122, 36, 29, '195-41-4', 195, 'General threats to species in this region', '2026-01-12 14:08:51'),
(716, 122, 36, 29, '195-41-5', 195, 'Renewable energy generation, timber industry, livestock farming, hunting, animal', '2026-01-12 14:08:51'),
(717, 122, 36, 29, '195-41-6', 195, 'Identified negative impacts from Henkel’s activities', '2026-01-12 14:08:51'),
(718, 122, 36, 29, '195-41-7', 195, 'Hunting, livestock farming, animal diseases, habitat changes, pollutants from', '2026-01-12 14:08:51'),
(719, 122, 36, 29, '195-41-8', 195, 'industry and the military, other threats', '2026-01-12 14:08:51'),
(720, 122, 36, 29, '195-41-9', 195, 'Pollutants from agriculture and forestry, deforestation, hunting, industry, leisure time activities, transportation routes, grain farming, animal diseases, livestock farming, other, economic development, other changes to the ecosystem, timber industry, extreme temperatures, other threats', '2026-01-12 14:08:51'),
(721, 122, 36, 29, '195-41-10', 195, 'Storms and flooding, supply routes, hunting, pollutants from industry and the military, timber industry, animal diseases, generation of renewable energies, grain farming, pollutants from agriculture and forestry, livestock farming, industry, other threats', '2026-01-12 14:08:51'),
(722, 122, 36, 29, '195-41-11', 195, 'Grain farming, deforestation, livestock farming, economic development, timber industry, invasive species, hunting, mining, transportation routes, fires, industrial areas, leisure time activities, other threats', '2026-01-12 14:08:51'),
(723, 122, 36, 29, '195-41-12', 195, 'Dams and water management, leisure time activities, animal diseases, pollutants from agriculture and forestry, habitat changes, tourism, deforestation, hunting, industry, grain farming, transportation routes, economic development, timber industry, other changes to the ecosystem, other threats', '2026-01-12 14:08:51'),
(724, 126, 36, 29, '195-42-1', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(725, 126, 36, 29, '195-42-2', 195, 'Düsseldorf-Holthausen, Germany', '2026-01-12 14:08:51'),
(726, 126, 36, 29, '195-42-3', 195, 'Calidris tenuirostris, Aquila nipalensis, Falco cherrug', '2026-01-12 14:08:51'),
(727, 126, 36, 29, '195-42-4', 195, 'Elgin (IL), USA', '2026-01-12 14:08:51'),
(728, 126, 36, 29, '195-42-5', 195, 'Myotis lucifugus, Grus americana', '2026-01-12 14:08:51'),
(729, 126, 36, 29, '195-42-6', 195, 'Campephilus principalis, Myotis leibii, Myotis lucifugus', '2026-01-12 14:08:51'),
(730, 126, 36, 29, '195-42-7', 195, 'Kornye-Tatabánya, Hungary', '2026-01-12 14:08:51'),
(731, 126, 36, 29, '195-42-8', 195, 'Cricetus cricetus, Spermophilus citellus, Otis tarda, Falco cherrug', '2026-01-12 14:08:51'),
(732, 126, 36, 29, '196-42-9', 196, 'Puffinus mauretanicus, Oryctolagus cuniculus, Neophron percnopterus, Falco cherrug', '2026-01-12 14:08:51'),
(733, 130, 36, 29, '194-43-1', 194, 'Dependency of', '2026-01-12 14:08:51'),
(734, 130, 36, 29, '194-43-2', 194, 'ecosystem services to provide re- sources and mitiga- tion or regulation of environmental in- fluences', '2026-01-12 14:08:51'),
(735, 130, 36, 29, '194-43-3', 194, 'Zapopan- Tesistán, Mexico', '2026-01-12 14:08:51'),
(736, 130, 36, 29, '194-43-4', 194, 'ecosystem services to mitigate or regu- late environmental influences', '2026-01-12 14:08:51'),
(737, 130, 36, 29, '195-43-5', 195, 'Impacts of sites relevant to biodiversity on threatened species', '2026-01-12 14:08:51'),
(738, 130, 36, 29, '195-43-6', 195, 'Threatened species', '2026-01-12 14:08:51'),
(739, 130, 36, 29, '195-43-7', 195, 'Cannon Falls (MN), USA Myotis lucifugus, Grus', '2026-01-12 14:08:51'),
(740, 130, 36, 29, '195-43-8', 195, 'General threats to species in this region', '2026-01-12 14:08:51'),
(741, 130, 36, 29, '195-43-9', 195, 'Renewable energy generation, timber industry, livestock farming, hunting, animal', '2026-01-12 14:08:51'),
(742, 130, 36, 29, '195-43-10', 195, 'Identified negative impacts from Henkel’s activities', '2026-01-12 14:08:51'),
(743, 130, 36, 29, '195-43-11', 195, 'Hunting, livestock farming, animal diseases, habitat changes, pollutants from', '2026-01-12 14:08:51'),
(744, 130, 36, 29, '195-43-12', 195, 'industry and the military, other threats', '2026-01-12 14:08:51'),
(745, 130, 36, 29, '195-43-13', 195, 'Pollutants from agriculture and forestry, deforestation, hunting, industry, leisure time activities, transportation routes, grain farming, animal diseases, livestock farming, other, economic development, other changes to the ecosystem, timber industry, extreme temperatures, other threats', '2026-01-12 14:08:51'),
(746, 130, 36, 29, '195-43-14', 195, 'No negative impact identified', '2026-01-12 14:08:51'),
(747, 130, 36, 29, '195-43-15', 195, 'contribution to extreme tempera- tures by emitting GHG', '2026-01-12 14:08:51'),
(748, 130, 36, 29, '195-43-16', 195, 'Storms and flooding, supply routes, hunting, pollutants from industry and the military, timber industry, animal diseases, generation of renewable energies, grain farming, pollutants from agriculture and forestry, livestock farming, industry, other threats', '2026-01-12 14:08:51'),
(749, 130, 36, 29, '195-43-17', 195, 'Grain farming, deforestation, livestock farming, economic development, timber industry, invasive species, hunting, mining, transportation routes, fires, industrial areas, leisure time activities, other threats', '2026-01-12 14:08:51'),
(750, 130, 36, 29, '195-43-18', 195, 'Dams and water management, leisure time activities, animal diseases, pollutants from agriculture and forestry, habitat changes, tourism, deforestation, hunting, industry, grain farming, transportation routes, economic development, timber industry, other changes to the ecosystem, other threats', '2026-01-12 14:08:51'),
(751, 34, 36, 29, '197-44-1', 197, 'Transition plan and consideration of biodiversity and ecosystems in strategy and business model (E4-1) Resilience of business model and risk mitigation strategy (E4-1_13a, AR 2, AR 3) The materiality analysis performed by Henkel included a risk assessment regarding financial effects. No material transition, physical or systemic risks related to biodiversity and ecosystems were identified. It was concluded on this basis that Henkel’s business model overall is resilient to risks related to biodiversity be- cause no biodiversity-related risks are material for Henkel.', '2026-01-12 14:08:51'),
(752, 35, 36, 29, '197-45-1', 197, 'Resilience analysis (E4-1_13b, 13c, 13e, AR 2, AR 3) As part of the materiality analysis, no material risks were identified in Henkel’s own operations or its up- stream and downstream value chain. As a result, no resilience analysis was conducted.', '2026-01-12 14:08:51'),
(753, 37, 36, 29, '197-46-1', 197, 'Time horizons (E4-1_13d, AR 2, AR 3) The risk assessment was generally conducted for a short-term time horizon, because no significant differ- ences regarding biodiversity are expected in the medium-term or long-term.', '2026-01-12 14:08:51'),
(754, 38, 36, 29, '197-47-1', 197, 'Resilience analysis (E4-1_13b, 13c, 13e, AR 2, AR 3) As part of the materiality analysis, no material risks were identified in Henkel’s own operations or its up- stream and downstream value chain. As a result, no resilience analysis was conducted.', '2026-01-12 14:08:51'),
(755, 39, 36, 29, '198-48-1', 198, 'Stakeholder involvement (E4-1_13f, AR 2, AR 3) External stakeholders were not involved in the assessment. Internally, stakeholders from Henkel’s business units and its Procurement team were consulted, and financial sustainability data was used.', '2026-01-12 14:08:51'),
(756, 40, 36, 29, '197-49-1', 197, 'Transition plan and consideration of biodiversity and ecosystems in strategy and business model (E4-1) Resilience of business model and risk mitigation strategy (E4-1_13a, AR 2, AR 3) The materiality analysis performed by Henkel included a risk assessment regarding financial effects. No material transition, physical or systemic risks related to biodiversity and ecosystems were identified. It was concluded on this basis that Henkel’s business model overall is resilient to risks related to biodiversity be- cause no biodiversity-related risks are material for Henkel.', '2026-01-12 14:08:51'),
(757, 52, 36, 29, '198-50-1', 198, 'Impact, risk and opportunity management Policies related to biodiversity and ecosystems (E4-2) Key content of the policy (E4-2_22, MDR-P_65a, E4-2_23a, 23b, AR 4, E4-2_23e, E4-2_24a, 24d) Globally, human activities have changed nature and ecosystems, including land surfaces and ocean areas. This has led to a rapid decline of biodiversity on earth with more than 1 million species facing extinction. Henkel recognizes its responsibility toward the protection of biodiversity on earth and is committed to protecting and restoring biodiversity with a focus on forests, land and water. The policy sets the guiding principles for our biodiversity targets and ambitions, as well as general principles for the selection of actions and the transition strategy toward our targets and ambitions.', '2026-01-12 14:08:51'),
(758, 53, 36, 29, '198-51-1', 198, 'Impact, risk and opportunity management Policies related to biodiversity and ecosystems (E4-2) Key content of the policy (E4-2_22, MDR-P_65a, E4-2_23a, 23b, AR 4, E4-2_23e, E4-2_24a, 24d) Globally, human activities have changed nature and ecosystems, including land surfaces and ocean areas. This has led to a rapid decline of biodiversity on earth with more than 1 million species facing extinction. Henkel recognizes its responsibility toward the protection of biodiversity on earth and is committed to protecting and restoring biodiversity with a focus on forests, land and water. The policy sets the guiding principles for our biodiversity targets and ambitions, as well as general principles for the selection of actions and the transition strategy toward our targets and ambitions.', '2026-01-12 14:08:51'),
(759, 54, 36, 29, '198-52-1', 198, 'Impact, risk and opportunity management Policies related to biodiversity and ecosystems (E4-2) Key content of the policy (E4-2_22, MDR-P_65a, E4-2_23a, 23b, AR 4, E4-2_23e, E4-2_24a, 24d) Globally, human activities have changed nature and ecosystems, including land surfaces and ocean areas. This has led to a rapid decline of biodiversity on earth with more than 1 million species facing extinction. Henkel recognizes its responsibility toward the protection of biodiversity on earth and is committed to protecting and restoring biodiversity with a focus on forests, land and water. The policy sets the guiding principles for our biodiversity targets and ambitions, as well as general principles for the selection of actions and the transition strategy toward our targets and ambitions.', '2026-01-12 14:08:51'),
(760, 54, 36, 29, '198-52-2', 198, 'Henkel is driving the transition to renewable raw materials, including recycled materials, bio-based materials and materials derived from carbon capture and utilization. To avoid, reduce and minimize potential negative impacts on the environment and people in the upstream value chain, Henkel is committed to responsible sourcing of raw materials. Henkel is also committed to zero net deforestation and has an ambition of defor- estation- and conversion-free sourcing of high-volume commodities with a high risk for deforestation, con- version, or human rights violations. This applies in particular to timber, pulp and paper, palm oil, palm kernel oil and their derivatives, and other commodities falling under relevant national and international legislation.', '2026-01-12 14:08:51'),
(761, 55, 36, 29, '198-53-1', 198, 'Impact, risk and opportunity management Policies related to biodiversity and ecosystems (E4-2) Key content of the policy (E4-2_22, MDR-P_65a, E4-2_23a, 23b, AR 4, E4-2_23e, E4-2_24a, 24d) Globally, human activities have changed nature and ecosystems, including land surfaces and ocean areas. This has led to a rapid decline of biodiversity on earth with more than 1 million species facing extinction. Henkel recognizes its responsibility toward the protection of biodiversity on earth and is committed to protecting and restoring biodiversity with a focus on forests, land and water. The policy sets the guiding principles for our biodiversity targets and ambitions, as well as general principles for the selection of actions and the transition strategy toward our targets and ambitions.', '2026-01-12 14:08:51'),
(762, 55, 36, 29, '198-53-2', 198, 'Henkel aims to support the efforts toward the global Nature Positive goal (defined by the Nature Positive Initiative and WWF and in line with the United Nations Kunming-Montreal Agreement) to strengthen resili- ence to climate change. This support for environmental protection and restoration can extend to activities along and beyond the value chain. Henkel strives to avoid negative impacts on threatened and protected species, especially on own operation sites located in or near sensitive ecosystems. In alignment, Henkel does not trade with species listed in the Convention on International Trade in Endangered Species of Wild Fauna and Flora (CITES) and respects legally designated protected areas.', '2026-01-12 14:08:51'),
(763, 56, 36, 29, '201-54-1', 201, 'Traceability of products, components and raw materials (E4-2_23d) Henkel strives to trace supplies upstream to the point where compliance can be ascertained using several approaches varying according to commodities: tracing material to the production unit (agricultural or forestry land), or via a third-party certification scheme that is aligned with the company via supplier systems that provide control back to the production unit level; or sourcing from areas documented to be low risk.', '2026-01-12 14:08:51'),
(764, 57, 36, 29, '201-55-1', 201, 'Sustainable land/agriculture practices or policies (E4-2_24b) Henkel expects its suppliers to undertake best efforts to aim for sustainable production or sourcing of agri- cultural or forestry feedstocks. This includes using agroforestry and other regenerative practices, wherever possible.', '2026-01-12 14:08:51'),
(765, 58, 36, 29, '201-56-1', 201, 'Social consequences of biodiversity and ecosystems-related impacts (E4-2_23f, AR 14, AR 15) Human beings are strongly dependent on nature and biodiversity, e.g. in terms of natural pollination, formation, protection and decontamination of soils and sediments and regulation of detrimental organisms. Moreover, the natural world is an invaluable source of medicinal, biochemical, and genetic resources. Henkel is committed to conducting its business in a manner that minimizes its environmental footprint and supports the preservation and enhancement of biodiversity to also support social sustainability and improve livelihood of communities. Henkel also aims to contribute to the societal net-zero goal by mitigating emissions beyond the own value chains (known as “beyond value chain mitigation”).', '2026-01-12 14:08:51'),
(766, 59, 36, 29, '198-57-1', 198, 'Henkel is driving the transition to renewable raw materials, including recycled materials, bio-based materials and materials derived from carbon capture and utilization. To avoid, reduce and minimize potential negative impacts on the environment and people in the upstream value chain, Henkel is committed to responsible sourcing of raw materials. Henkel is also committed to zero net deforestation and has an ambition of defor- estation- and conversion-free sourcing of high-volume commodities with a high risk for deforestation, con- version, or human rights violations. This applies in particular to timber, pulp and paper, palm oil, palm kernel oil and their derivatives, and other commodities falling under relevant national and international legislation.', '2026-01-12 14:08:51'),
(767, 60, 36, 29, '198-58-1', 198, 'Henkel aims to support the efforts toward the global Nature Positive goal (defined by the Nature Positive Initiative and WWF and in line with the United Nations Kunming-Montreal Agreement) to strengthen resili- ence to climate change. This support for environmental protection and restoration can extend to activities along and beyond the value chain. Henkel strives to avoid negative impacts on threatened and protected species, especially on own operation sites located in or near sensitive ecosystems. In alignment, Henkel does not trade with species listed in the Convention on International Trade in Endangered Species of Wild Fauna and Flora (CITES) and respects legally designated protected areas.', '2026-01-12 14:08:51'),
(768, 61, 36, 29, '200-59-1', 200, 'Commitment to third-party standards or initiatives (E4-2_22, MDR-P_65d) Henkel respects the planetary boundaries related to biosphere integrity, overloading with novel entities and land-system change.', '2026-01-12 14:08:51'),
(769, 61, 36, 29, '200-59-2', 200, 'Henkel supports the goals of the “Convention on Biological Diversity” together with its two supplementary agreements, the Cartagena Protocol and the Nagoya Protocol. Henkel supports the four global goals and 23 targets of the Kunming-Montreal Global Biodiversity Framework (GBF).', '2026-01-12 14:08:51'),
(770, 61, 36, 29, '200-59-3', 200, 'Henkel operates in alignment with the international conventions on the emission of potentially hazardous chemical substances, such as the Vienna Convention/Montreal Protocol on the avoidance of ozone-depleting substances, the Basel Convention on trade with hazardous wastes, the Stockholm Convention on persistent organic pollutants and the Minamata Convention on mercury emissions. Henkel recognizes the Sustainable Development Goals (SDGs) of the United Nations, in terms of the protection of ecosystems and biodiversity especially SDG 14 “Life below Water” and SDG 15 “Life on Land” as crucial goals toward the preservation of ecosystems and biodiversity.', '2026-01-12 14:08:51'),
(771, 61, 36, 29, '200-59-4', 200, 'Furthermore, Henkel acknowledges climate change, land use change, pollution, direct exploitation and inva- sive species as the main drivers for biodiversity loss in accordance with the Intergovernmental Science-Policy Platform on Biodiversity and Ecosystem Services (IPBES). Henkel supports the EU Biodiversity Strategy for 2030 together with its relevant objectives and targets as European frameworks for the protection, preserva- tion and restoration of natural habitats and biodiversity.', '2026-01-12 14:08:51');
INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(772, 69, 36, 29, '198-60-1', 198, 'Henkel aims to support the efforts toward the global Nature Positive goal (defined by the Nature Positive Initiative and WWF and in line with the United Nations Kunming-Montreal Agreement) to strengthen resili- ence to climate change. This support for environmental protection and restoration can extend to activities along and beyond the value chain. Henkel strives to avoid negative impacts on threatened and protected species, especially on own operation sites located in or near sensitive ecosystems. In alignment, Henkel does not trade with species listed in the Convention on International Trade in Endangered Species of Wild Fauna and Flora (CITES) and respects legally designated protected areas.', '2026-01-12 14:08:51'),
(773, 69, 36, 29, '199-60-2', 199, 'Scope (E4-2_22, MDR-P_65b) The provisions in this policy apply to the Henkel Group worldwide, including all operations and subsidiaries as well as their upstream and downstream value chain. This includes sites managed in or near a biodiversity- sensitive area. No business units, regions, specific activities or stakeholders are excluded.', '2026-01-12 14:08:51'),
(774, 70, 36, 29, '201-61-1', 201, 'Sustainable land/agriculture practices or policies (E4-2_24b) Henkel expects its suppliers to undertake best efforts to aim for sustainable production or sourcing of agri- cultural or forestry feedstocks. This includes using agroforestry and other regenerative practices, wherever possible.', '2026-01-12 14:08:51'),
(775, 72, 36, 29, '198-62-1', 198, 'Henkel is driving the transition to renewable raw materials, including recycled materials, bio-based materials and materials derived from carbon capture and utilization. To avoid, reduce and minimize potential negative impacts on the environment and people in the upstream value chain, Henkel is committed to responsible sourcing of raw materials. Henkel is also committed to zero net deforestation and has an ambition of defor- estation- and conversion-free sourcing of high-volume commodities with a high risk for deforestation, con- version, or human rights violations. This applies in particular to timber, pulp and paper, palm oil, palm kernel oil and their derivatives, and other commodities falling under relevant national and international legislation.', '2026-01-12 14:08:51'),
(776, 74, 36, 29, '202-64-1', 202, 'The aim of this action is to prevent land-use changes and land degradation caused by deforestation in the procurement of relevant raw materials, while also promoting social sustainability. Within the mitigation hier- archy, this relates to the aspect of avoidance. This action is also aimed at net-zero deforestation. For further information, please refer to the section “Key content of the policy” (E4-2, MDR-P_65a) in this chapter. For further information about the most important actions regarding the direct causes of biodiversity loss and about the change in freshwater usage, please refer to the chapters “Climate change” (ESRS E1) and “Water and marine resources“ (ESRS E3). The existing actions will be continued in the future.', '2026-01-12 14:08:51'),
(777, 75, 36, 29, '203-65-1', 203, 'Usage of biodiversity offsets (E4-3_28b, 28b i, AR 18, E4-3_28b iii, E4-3_29b ii) No biodiversity offsets or other compensation was undertaken for the described action.', '2026-01-12 14:08:51'),
(778, 82, 36, 29, '203-66-1', 203, 'Incorporation of local, indigenous knowledge and nature-based solutions (E4-3_28c) No actions were implemented based on indigenous knowledge or nature-based solutions.', '2026-01-12 14:08:51'),
(779, 86, 36, 29, '202-67-1', 202, 'Time horizons (E4-3_27, MDR-A_68c) The described action was implemented during the reporting year, and plans have been made to continue this in the short-term, medium-term and long-term.', '2026-01-12 14:08:51'),
(780, 88, 36, 29, '202-68-1', 202, 'Scope (E4-3_27, MDR-A_68b) The scope of the described action encompasses Henkel’s global upstream value chain. The stakeholders involved include suppliers, smallholder farmers, small-scale entrepreneurs along the value chain, affected communities and indigenous peoples in the relevant sourcing regions.', '2026-01-12 14:08:51'),
(781, 90, 36, 29, '203-69-1', 203, 'Metrics and targets Targets related to biodiversity and ecosystems (E4-4) Description of targets (E4-4_31) Henkel has set targets for the responsible sourcing of palm (kernel) oil and wood-based packaging materials, as these are considered critical raw materials associated with a deforestation risk. Responsible sourcing includes the use of certification systems that document deforestation-free procurement or responsible forestry management. These targets address the identified material impacts of land-use change as a direct driver of biodiversity loss and land degradation as an impact on biodiversity and ecosystems in the upstream value chain.', '2026-01-12 14:08:51'),
(782, 96, 36, 29, '203-70-1', 203, 'Metrics and targets Targets related to biodiversity and ecosystems (E4-4) Description of targets (E4-4_31) Henkel has set targets for the responsible sourcing of palm (kernel) oil and wood-based packaging materials, as these are considered critical raw materials associated with a deforestation risk. Responsible sourcing includes the use of certification systems that document deforestation-free procurement or responsible forestry management. These targets address the identified material impacts of land-use change as a direct driver of biodiversity loss and land degradation as an impact on biodiversity and ecosystems in the upstream value chain.', '2026-01-12 14:08:51'),
(783, 97, 36, 29, '204-71-1', 204, 'Scope (E4-4_31, MDR-T_80c, AR 24, AR 25, AR 26) The targets apply to Henkel’s global upstream value chain.', '2026-01-12 14:08:51'),
(784, 12, 36, 29, '210-72-1', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:51'),
(785, 13, 36, 29, '210-73-1', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:51'),
(786, 14, 36, 29, '210-74-1', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:51'),
(787, 15, 36, 29, '208-75-1', 208, ' Areas with sensitive biodiversity include Key Biodiversity Areas (KBA) and the protected areas listed in the World Database of Protected Areas (WDPA). Proximity to these areas has been assessed using the Inte- grated Biodiversity Assessment Tool (IBAT).', '2026-01-12 14:08:51'),
(788, 15, 36, 29, '210-75-2', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:51'),
(789, 16, 36, 29, '207-76-1', 207, 'Relationship with impacts, dependencies, risks and opportunities (E4-4_32c) For a description of the targets addressing the direct drivers of biodiversity loss, such as “climate change,” “freshwater-use change” and “direct water use,” please refer to chapters “Climate change” (ESRS E1) and “Water and marine resources” (ESRS E3). The three targets in this section relate to the identified material impacts: “direct drivers of biodiversity loss – land-use changes,” “direct drivers of biodiversity loss – direct exploitation of biological resources” and “impacts on the extent and condition of ecosystems – land degra- dation” in the upstream value chain. No attribution of impacts was made during the target-setting process.', '2026-01-12 14:08:51'),
(790, 18, 36, 29, '207-77-1', 207, 'Relationship with impacts, dependencies, risks and opportunities (E4-4_32c) For a description of the targets addressing the direct drivers of biodiversity loss, such as “climate change,” “freshwater-use change” and “direct water use,” please refer to chapters “Climate change” (ESRS E1) and “Water and marine resources” (ESRS E3). The three targets in this section relate to the identified material impacts: “direct drivers of biodiversity loss – land-use changes,” “direct drivers of biodiversity loss – direct exploitation of biological resources” and “impacts on the extent and condition of ecosystems – land degra- dation” in the upstream value chain. No attribution of impacts was made during the target-setting process.', '2026-01-12 14:08:51'),
(791, 18, 36, 29, '210-77-2', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:51'),
(792, 31, 36, 29, '210-78-1', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:51'),
(793, 39, 36, 29, '205-79-1', 205, 'Involvement of stakeholders (E4-4_31, MDR-T_80h, AR 24, AR 25, AR 26) Internal stakeholders, including procurement and sustainability managers from the business units and the global Sustainability team, were involved in the target-setting process. Targets were developed in 2021 with consideration given to the perspectives of external stakeholders. Steps were taken to ensure this, including a stakeholder survey.(cid:2825)', '2026-01-12 14:08:51'),
(794, 42, 36, 29, '204-80-1', 204, 'Period (E4-4_3, MDR-T_80e, AR 24, AR 25, AR 26) The period for achieving the targets extends until 2025. No milestones or interim targets have been established.', '2026-01-12 14:08:51'),
(795, 42, 36, 29, '204-80-2', 204, 'Methodologies and significant assumptions (E4-4_31, MDR-T_80f, AR 24, AR 25, AR 26) The set targets are supported by scientific findings based on the concept of planetary boundaries. They also take into account current research on the ecological and social impacts of palm (kern) oil, the European Deforestation Regulation (EUDR), which includes timber products and palm (kern) oil products, and stake- holder requirements for sustainable palm (kern) oil products. No additional significant assumptions were made when setting the targets.', '2026-01-12 14:08:51'),
(796, 42, 36, 29, '205-80-3', 205, 'Scientific evidence (E4-4_31, MDR-T_80g, AR 24, AR 25, AR 26) The set targets address the environmental issue of land system change, as outlined in research on planetary boundaries. For further information, please refer to the section “Application of ecological thresholds” (E4-4_32a) in this chapter.', '2026-01-12 14:08:51'),
(797, 42, 36, 29, '205-80-4', 205, 'Involvement of stakeholders (E4-4_31, MDR-T_80h, AR 24, AR 25, AR 26) Internal stakeholders, including procurement and sustainability managers from the business units and the global Sustainability team, were involved in the target-setting process. Targets were developed in 2021 with consideration given to the perspectives of external stakeholders. Steps were taken to ensure this, including a stakeholder survey.(cid:2825)', '2026-01-12 14:08:51'),
(798, 42, 36, 29, '205-80-5', 205, 'Changes to targets and metrics (E4-4_31, MDR-T_80i, AR 24, AR 25, AR 26) To date, Henkel has made no changes to the targets, corresponding metrics, underlying measurement methods, significant assumptions, limitations, sources or processes within the defined timeframe.', '2026-01-12 14:08:51'),
(799, 42, 36, 29, '206-80-8', 206, 'E4-T3: In 2023, the total amount of wood-based packaging materials purchased was 222.4 metric kilotons, with 64 percent comprising recycled materials and 34 percent certified non-recycled materials. Target achievement is at 98 percent. Progress toward achieving the target is determined in collaboration with suppliers and is based on their self-disclosures as part of the annual Pulp-Paper-Packaging (PPP) survey. The recognized certifications are FSC, PEFC, SFI, CSA, AFS and/or equivalent certifications. The values for the full year 2024 will be published in the Sustainability Statement 2025.', '2026-01-12 14:08:52'),
(800, 42, 36, 29, '206-80-9', 206, 'We are confident that we will achieve the targets according to the plan. Progress toward achieving the targets is monitored and reviewed by the Sustainability Council. No significant changes were identified.', '2026-01-12 14:08:52'),
(801, 42, 36, 29, '207-80-10', 207, 'Relationship with impacts, dependencies, risks and opportunities (E4-4_32c) For a description of the targets addressing the direct drivers of biodiversity loss, such as “climate change,” “freshwater-use change” and “direct water use,” please refer to chapters “Climate change” (ESRS E1) and “Water and marine resources” (ESRS E3). The three targets in this section relate to the identified material impacts: “direct drivers of biodiversity loss – land-use changes,” “direct drivers of biodiversity loss – direct exploitation of biological resources” and “impacts on the extent and condition of ecosystems – land degra- dation” in the upstream value chain. No attribution of impacts was made during the target-setting process.', '2026-01-12 14:08:52'),
(802, 42, 36, 29, '210-80-11', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:52'),
(803, 44, 36, 29, '207-81-1', 207, 'Relationship with impacts, dependencies, risks and opportunities (E4-4_32c) For a description of the targets addressing the direct drivers of biodiversity loss, such as “climate change,” “freshwater-use change” and “direct water use,” please refer to chapters “Climate change” (ESRS E1) and “Water and marine resources” (ESRS E3). The three targets in this section relate to the identified material impacts: “direct drivers of biodiversity loss – land-use changes,” “direct drivers of biodiversity loss – direct exploitation of biological resources” and “impacts on the extent and condition of ecosystems – land degra- dation” in the upstream value chain. No attribution of impacts was made during the target-setting process.', '2026-01-12 14:08:52'),
(804, 44, 36, 29, '208-81-2', 208, 'Layer of the mitigation hierarchy (E4-4_32f) Within the mitigation hierarchy, all targets are assigned to the “avoidance” layer. This refers to the avoidance of deforestation.', '2026-01-12 14:08:52'),
(805, 49, 36, 29, '208-82-1', 208, 'Impact metrics related to biodiversity and ecosystems change (E4-5) Metrics used (MDR-M_75) For relevant metrics for the identified material impacts of climate change as a direct driver of biodiversity loss, please refer to the chapter “Climate change” (ESRS E1). Relevant metrics for the identified material impacts of freshwater-use change and direct exploitation of freshwater in Henkel’s operations as direct drivers of biodiversity loss are included in the chapter “Water and marine resources” (ESRS E3). For relevant metrics related to the direct exploitation of biological resources in the upstream value chain, please refer to the chapter “Resource use and circular economy” (ESRS E5).', '2026-01-12 14:08:52'),
(806, 49, 36, 29, '209-82-2', 209, 'Three entity-specific metrics are also collected to measure progress toward the targets. These are:', '2026-01-12 14:08:52'),
(807, 49, 36, 29, '209-82-3', 209, ' Percentage of recycled and certified wood-based packaging materials purchased  Percentage of certified palm oil, palm kernel oil and their derivatives purchased  Percentage of purchased palm oil, palm kernel oil and their derivatives traceable to the refinery, mill or', '2026-01-12 14:08:52'),
(808, 49, 36, 29, '209-82-4', 209, 'plantation', '2026-01-12 14:08:52'),
(809, 49, 36, 29, '209-82-6', 209, 'The percentage of certified palm oil, palm kernel oil and their derivatives purchased is calculated by first determining the actual quantity of palm oil and palm kernel oil used. This is done by multiplying the total volume of purchased raw materials containing palm oil or palm kernel oil by their respective mass-based content of palm oil or palm kernel oil. The amount of certified palm oil and palm kernel oil purchased is then divided by this total quantity. The certified quantities are determined for all suppliers delivering more than 25 metric tons of material annually, which covers 99 percent of the palm oil and palm kernel oil-based raw material volumes. The calculated figure is extrapolated to 100 percent. The recognized certifications are those provided by the Roundtable on Sustainable Palm Oil (RSPO), either mass balance (MB) or segregated (SG).', '2026-01-12 14:08:52'),
(810, 49, 36, 29, '209-82-7', 209, 'The percentage of palm oil, palm kernel oil and their derivatives traceable to the refinery, mill or plantation is determined by ASD. The assessment is based on Henkel’s agreed baseline volume of 97.5 percent of the total procurement volume and is extrapolated to the full volume. To calculate the traceable percentage, traceability to plantations, mills and refineries is assessed and then divided by the total volume of purchased palm oil, palm kernel oil and their derivatives. The ASD process includes the steps “data collection from direct and indirect suppliers,” “supply chain mapping,” “mapping of sourcing areas” and “assessment of the level of transparency.” Each year, data from the supply chain is examined and collected through consultations with direct and indirect suppliers, conducted by an independent third party, to identify sourcing areas and compile a list of refineries and mills within the supply chain. This metric is reported with a one-year delay, meaning', '2026-01-12 14:08:52'),
(811, 49, 36, 29, '210-82-8', 210, 'it is included in this report for the year 2023, as the analysis and verification of data are completed annually in the third quarter for the previous year.', '2026-01-12 14:08:52'),
(812, 67, 36, 29, '210-83-1', 210, 'External validation (MDR-M_77b) Regarding the percentage of certified palm oil, palm kernel oil and their derivatives purchased, Henkel is certi- fied by SCS Global Services. The certification confirms compliance with the “RSPO Supply Chain Certification Standard, version February 2020.” This guarantees that the criteria for processing RSPO-certified palm products have been met through one or more supply chain models defined in the RSPO supply chain certification systems. The metrics that are normally disclosed have been verified exclusively by our auditor as part of the audit of this Sustainability Report with limited assurance.', '2026-01-12 14:08:52'),
(813, 74, 36, 29, '208-84-1', 208, 'Layer of the mitigation hierarchy (E4-4_32f) Within the mitigation hierarchy, all targets are assigned to the “avoidance” layer. This refers to the avoidance of deforestation.', '2026-01-12 14:08:52'),
(814, 83, 36, 29, '205-85-1', 205, 'Involvement of stakeholders (E4-4_31, MDR-T_80h, AR 24, AR 25, AR 26) Internal stakeholders, including procurement and sustainability managers from the business units and the global Sustainability team, were involved in the target-setting process. Targets were developed in 2021 with consideration given to the perspectives of external stakeholders. Steps were taken to ensure this, including a stakeholder survey.(cid:2825)', '2026-01-12 14:08:52'),
(815, 92, 36, 29, '206-88-1', 206, 'Application of ecological thresholds (E4-4_32a) The planetary boundaries regarding “land system change” form the ecological threshold for the targets, and the remaining forest area relative to the potential forest area during the Holocene is described for the three different forest types: “tropical,” “temperate” and “boreal.”', '2026-01-12 14:08:52'),
(816, 92, 36, 29, '207-88-2', 207, 'Identified ecological thresholds and method (E4-4_32a i) The target for palm oil and palm kernel oil pertains to tropical forests (ecological threshold: 85 percent of the tropical forest area compared to the potential tropical forest area during the Holocene). The target for certified paper and cardboard applies to all three forest types, with ecological thresholds of 50 percent for temperate and 85 percent for boreal and tropical forest area relative to the potential forest area during the Holocene. The methodology for these thresholds is described in the Stockholm Resilience Centre’s planetary boundaries concept.', '2026-01-12 14:08:52'),
(817, 93, 36, 29, '207-89-1', 207, 'Entity-specific thresholds (E4-4_32a ii) The threshold used is a global value and not entity-specific.', '2026-01-12 14:08:52'),
(818, 94, 36, 29, '207-90-1', 207, 'Responsibility for respecting ecological thresholds (E4-4_32a iii) Henkel is not responsible for adherence to the ecological threshold because land system change is outside of Henkel’s area of influence. However, we do view it as our responsibility to achieve net-zero deforestation in our upstream value chain.', '2026-01-12 14:08:52'),
(819, 95, 36, 29, '207-91-1', 207, 'Alignment with the EU Biodiversity Strategy for 2030', '2026-01-12 14:08:52'),
(820, 95, 36, 29, '207-91-2', 207, 'Target 1, 2, 8 and 15', '2026-01-12 14:08:52'),
(821, 96, 36, 29, '207-92-1', 207, 'Relationship with impacts, dependencies, risks and opportunities (E4-4_32c) For a description of the targets addressing the direct drivers of biodiversity loss, such as “climate change,” “freshwater-use change” and “direct water use,” please refer to chapters “Climate change” (ESRS E1) and “Water and marine resources” (ESRS E3). The three targets in this section relate to the identified material impacts: “direct drivers of biodiversity loss – land-use changes,” “direct drivers of biodiversity loss – direct exploitation of biological resources” and “impacts on the extent and condition of ecosystems – land degra- dation” in the upstream value chain. No attribution of impacts was made during the target-setting process.', '2026-01-12 14:08:52'),
(822, 97, 36, 29, '208-93-1', 208, 'Geographical scope (E4-4_32d) The geographical scope of all targets is global.', '2026-01-12 14:08:52'),
(823, 99, 36, 29, '208-94-1', 208, 'Layer of the mitigation hierarchy (E4-4_32f) Within the mitigation hierarchy, all targets are assigned to the “avoidance” layer. This refers to the avoidance of deforestation.', '2026-01-12 14:08:52'),
(824, 101, 36, 29, '210-95-1', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:52'),
(825, 102, 36, 29, '210-96-1', 210, 'Sites located in or near biodiversity-sensitive areas (E4-5_35) 18 sites relevant to biodiversity have been identified, meaning locations among Henkel’s own operations that contribute to the identified material drivers of biodiversity loss within its own operations (climate change and/or freshwater-use change) and are located within a two-kilometer radius of a biodiversity-sensitive area. The identified sites relevant to biodiversity encompass an area of 15,857 hectares.', '2026-01-12 14:08:52'),
(826, 104, 36, 29, '207-97-1', 207, 'Relationship with impacts, dependencies, risks and opportunities (E4-4_32c) For a description of the targets addressing the direct drivers of biodiversity loss, such as “climate change,” “freshwater-use change” and “direct water use,” please refer to chapters “Climate change” (ESRS E1) and “Water and marine resources” (ESRS E3). The three targets in this section relate to the identified material impacts: “direct drivers of biodiversity loss – land-use changes,” “direct drivers of biodiversity loss – direct exploitation of biological resources” and “impacts on the extent and condition of ecosystems – land degra- dation” in the upstream value chain. No attribution of impacts was made during the target-setting process.', '2026-01-12 14:08:52'),
(827, 104, 36, 29, '208-97-2', 208, 'Impact metrics related to biodiversity and ecosystems change (E4-5) Metrics used (MDR-M_75) For relevant metrics for the identified material impacts of climate change as a direct driver of biodiversity loss, please refer to the chapter “Climate change” (ESRS E1). Relevant metrics for the identified material impacts of freshwater-use change and direct exploitation of freshwater in Henkel’s operations as direct drivers of biodiversity loss are included in the chapter “Water and marine resources” (ESRS E3). For relevant metrics related to the direct exploitation of biological resources in the upstream value chain, please refer to the chapter “Resource use and circular economy” (ESRS E5).', '2026-01-12 14:08:52'),
(828, 104, 36, 29, '209-97-3', 209, ' Percentage of recycled and certified wood-based packaging materials purchased  Percentage of certified palm oil, palm kernel oil and their derivatives purchased  Percentage of purchased palm oil, palm kernel oil and their derivatives traceable to the refinery, mill or', '2026-01-12 14:08:52'),
(829, 118, 36, 29, '208-98-1', 208, 'Impact metrics related to biodiversity and ecosystems change (E4-5) Metrics used (MDR-M_75) For relevant metrics for the identified material impacts of climate change as a direct driver of biodiversity loss, please refer to the chapter “Climate change” (ESRS E1). Relevant metrics for the identified material impacts of freshwater-use change and direct exploitation of freshwater in Henkel’s operations as direct drivers of biodiversity loss are included in the chapter “Water and marine resources” (ESRS E3). For relevant metrics related to the direct exploitation of biological resources in the upstream value chain, please refer to the chapter “Resource use and circular economy” (ESRS E5).', '2026-01-12 14:08:52'),
(830, 18, 57, 43, '144-1-1', 144, 'Wesentliches Thema: Biologische Vielfalt und Ökosysteme', '2026-02-02 23:07:26'),
(831, 18, 57, 43, '144-1-3', 144, 'Potenzielle negative Auswirkungen', '2026-02-02 23:07:26'),
(832, 18, 57, 43, '144-1-4', 144, 'Landnutzungsänderungen als Ursache des Biodiversitätsverlusts: Mögli- che negative Auswirkungen auf die Ökosysteme durch Lieferanten, die möglicherweise Landnutzungsänderungen durchführen (vorgelagerte Wertschöpfungskette)', '2026-02-02 23:07:26'),
(833, 19, 57, 43, '144-2-1', 144, 'Wesentliches Thema: Biologische Vielfalt und Ökosysteme', '2026-02-02 23:07:26'),
(834, 20, 57, 43, '144-3-1', 144, 'Wesentliches Thema: Biologische Vielfalt und Ökosysteme', '2026-02-02 23:07:26'),
(835, 17, 57, 43, '144-4-1', 144, 'Tatsächliche und potenzielle negative Auswirkungen', '2026-02-02 23:07:26'),
(836, 17, 57, 43, '144-4-2', 144, 'Invasive nichtheimische Arten als Ursache des Biodiversitätsverlusts: Mögliche negative Auswirkungen auf die Biodiversität durch die Einfüh- rung invasiver nichtheimischer Arten beim Holztransport (eigene Tätig- keiten, vorgelagerte Wertschöpfungskette)', '2026-02-02 23:07:26'),
(837, 17, 57, 43, '144-4-3', 144, 'Auswirkungen auf den Zustand der Arten – Risiko des weltweiten Aus- sterbens von Arten: Negative Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung (eigene Tätigkeiten, vorgelagerte Wertschöpfungskette)', '2026-02-02 23:07:26'),
(838, 57, 57, 43, '144-5-1', 144, 'Wesentliches Thema: Biologische Vielfalt und Ökosysteme', '2026-02-02 23:07:26'),
(839, 57, 57, 43, '144-5-3', 144, 'Weitere Maßnahmen (nicht näher beschrieben in E4-3)', '2026-02-02 23:07:26'),
(840, 57, 57, 43, '144-5-4', 144, 'Lenzing wendet zum Erhalt der Biodiversität in ihrer Lieferkette je nach Region einen der folgenden zwei Ansätze an:', '2026-02-02 23:07:26'),
(841, 57, 57, 43, '144-5-5', 144, 'In der nördlichen Hemisphäre setzen die Holz- und Faser- zellstofflieferanten von Lenzing in Europa und Nordamerika auf nachhaltige Forstwirtschaft: Die Verwendung von Holz aus nachhaltig bewirtschafteten naturnahen Wäldern unter- stützt die Biodiversität.', '2026-02-02 23:07:26'),
(842, 122, 57, 43, '144-6-1', 144, 'Tatsächliche und potenzielle negative Auswirkungen', '2026-02-02 23:07:26'),
(843, 122, 57, 43, '144-6-2', 144, 'Invasive nichtheimische Arten als Ursache des Biodiversitätsverlusts: Mögliche negative Auswirkungen auf die Biodiversität durch die Einfüh- rung invasiver nichtheimischer Arten beim Holztransport (eigene Tätig- keiten, vorgelagerte Wertschöpfungskette)', '2026-02-02 23:07:26'),
(844, 122, 57, 43, '144-6-3', 144, 'Auswirkungen auf den Zustand der Arten – Risiko des weltweiten Aus- sterbens von Arten: Negative Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung (eigene Tätigkeiten, vorgelagerte Wertschöpfungskette)', '2026-02-02 23:07:26'),
(845, 31, 57, 43, '144-7-1', 144, 'Lenzing und die ÖBf (Österreichische Bundesforste) haben sich auf ei- nen Aktionsplan für das Engagement zum Schutz und Erhalt der Torf- moore im Ausseerland in der Steiermark (Österreich) geeinigt. Feucht- wiesen mit ihrer außergewöhnlich hohen biologischen Vielfalt und Am- phibienteiche werden wiederhergestellt.', '2026-02-02 23:07:26'),
(846, 33, 57, 43, '144-8-1', 144, 'Lenzing und die ÖBf (Österreichische Bundesforste) haben sich auf ei- nen Aktionsplan für das Engagement zum Schutz und Erhalt der Torf- moore im Ausseerland in der Steiermark (Österreich) geeinigt. Feucht- wiesen mit ihrer außergewöhnlich hohen biologischen Vielfalt und Am- phibienteiche werden wiederhergestellt.', '2026-02-02 23:07:26'),
(847, 39, 57, 43, '144-9-1', 144, 'Lenzing arbeitet mit Nichtregierungsorganisationen, Kunden und Part- nern entlang der nachgelagerten Wertschöpfungskette zusammen, um das öffentliche Bewusstsein für die Biodiversität zu schärfen und Maß- nahmen für ihren Erhalt zu ergreifen', '2026-02-02 23:07:26'),
(848, 39, 57, 43, '144-9-2', 144, 'Lenzing hat Projekte mit CDP, Canopy und ÖBf abgestimmt.', '2026-02-02 23:07:26'),
(849, 42, 57, 43, '144-10-1', 144, 'Klimawandel als Ursache des Biodiversitätsverlusts: Positive Auswirkun- gen auf die Biodiversität durch nachhaltige Holzbeschaffung und Betei- ligung an Aufforstungsprojekten (eigene Tätigkeiten, vorgelagerte Wert- schöpfungskette)', '2026-02-02 23:07:26'),
(850, 49, 57, 43, '144-11-1', 144, 'CDP (früher: Carbon Disclosure Project) 2024: Lenzing wurde mit „Klima A“ vier Jahre in Folge bewertet, und mit „Wald A-“ und „Wasser B“ aus- gezeichnet, was eine hohe Transparenz und die Integration von Umwelt- aspekten in die Unternehmensstrategie belegt.', '2026-02-02 23:07:26'),
(851, 52, 57, 43, '145-12-1', 145, 'Policy für Biodiversität', '2026-02-02 23:07:26'),
(852, 70, 57, 43, '144-13-1', 144, 'Klimawandel als Ursache des Biodiversitätsverlusts: Positive Auswirkun- gen auf die Biodiversität durch nachhaltige Holzbeschaffung und Betei- ligung an Aufforstungsprojekten (eigene Tätigkeiten, vorgelagerte Wert- schöpfungskette)', '2026-02-02 23:07:26'),
(853, 72, 57, 43, '144-14-1', 144, 'Lenzing erreicht zum vierten Mal die höchste Hot Button-Kategorie „Dark Green Shirt“ der CanopyStyle-Initiative', '2026-02-02 23:07:26'),
(854, 72, 57, 43, '144-14-2', 144, 'Klimawandel als Ursache des Biodiversitätsverlusts: Positive Auswirkun- gen auf die Biodiversität durch nachhaltige Holzbeschaffung und Betei- ligung an Aufforstungsprojekten (eigene Tätigkeiten, vorgelagerte Wert- schöpfungskette)', '2026-02-02 23:07:26'),
(855, 73, 57, 43, '144-15-1', 144, 'Lenzing erreicht zum vierten Mal die höchste Hot Button-Kategorie „Dark Green Shirt“ der CanopyStyle-Initiative', '2026-02-02 23:07:26'),
(856, 73, 57, 43, '144-15-2', 144, 'Klimawandel als Ursache des Biodiversitätsverlusts: Positive Auswirkun- gen auf die Biodiversität durch nachhaltige Holzbeschaffung und Betei- ligung an Aufforstungsprojekten (eigene Tätigkeiten, vorgelagerte Wert- schöpfungskette)', '2026-02-02 23:07:26'),
(857, 73, 57, 43, '144-15-3', 144, 'Lenzing schließt sich der „Circular Fashion Partnership“ an', '2026-02-02 23:07:26'),
(858, 73, 57, 43, '144-15-4', 144, 'CDP (früher: Carbon Disclosure Project) 2024: Lenzing wurde mit „Klima A“ vier Jahre in Folge bewertet, und mit „Wald A-“ und „Wasser B“ aus- gezeichnet, was eine hohe Transparenz und die Integration von Umwelt- aspekten in die Unternehmensstrategie belegt.', '2026-02-02 23:07:26'),
(859, 73, 57, 43, '144-15-5', 144, 'Lenzing und die ÖBf (Österreichische Bundesforste) haben sich auf ei- nen Aktionsplan für das Engagement zum Schutz und Erhalt der Torf- moore im Ausseerland in der Steiermark (Österreich) geeinigt. Feucht- wiesen mit ihrer außergewöhnlich hohen biologischen Vielfalt und Am- phibienteiche werden wiederhergestellt.', '2026-02-02 23:07:26'),
(860, 73, 57, 43, '144-15-6', 144, 'Lenzing hat Projekte mit CDP, Canopy und ÖBf abgestimmt.', '2026-02-02 23:07:26'),
(861, 73, 57, 43, '144-15-7', 144, 'Lenzing veröffentlicht zum ersten Mal Informationen gemäß den Emp- fehlungen der Task Force on Nature-Related Financial Disclosures (TNFD)', '2026-02-02 23:07:26'),
(862, 73, 57, 43, '145-15-8', 145, 'Lenzing unterstützte die „Business for Nature“-Erklärung für die UN- Vertragsstaatenkonferenz zur biologischen Vielfalt (COP16) (Oktober 2024)', '2026-02-02 23:07:26'),
(863, 83, 57, 43, '144-16-1', 144, 'Lenzing arbeitet mit Nichtregierungsorganisationen, Kunden und Part- nern entlang der nachgelagerten Wertschöpfungskette zusammen, um das öffentliche Bewusstsein für die Biodiversität zu schärfen und Maß- nahmen für ihren Erhalt zu ergreifen', '2026-02-02 23:07:26'),
(864, 83, 57, 43, '144-16-2', 144, 'Lenzing hat Projekte mit CDP, Canopy und ÖBf abgestimmt.', '2026-02-02 23:07:26'),
(865, 88, 57, 43, '144-17-1', 144, 'Lenzing arbeitet mit Nichtregierungsorganisationen, Kunden und Part- nern entlang der nachgelagerten Wertschöpfungskette zusammen, um das öffentliche Bewusstsein für die Biodiversität zu schärfen und Maß- nahmen für ihren Erhalt zu ergreifen', '2026-02-02 23:07:26'),
(866, 88, 57, 43, '144-17-2', 144, 'Lenzing schließt sich der „Circular Fashion Partnership“ an', '2026-02-02 23:07:26'),
(867, 88, 57, 43, '144-17-3', 144, 'Lenzing und die ÖBf (Österreichische Bundesforste) haben sich auf ei- nen Aktionsplan für das Engagement zum Schutz und Erhalt der Torf- moore im Ausseerland in der Steiermark (Österreich) geeinigt. Feucht- wiesen mit ihrer außergewöhnlich hohen biologischen Vielfalt und Am- phibienteiche werden wiederhergestellt.', '2026-02-02 23:07:26'),
(868, 88, 57, 43, '145-17-4', 145, 'Lenzing unterstützte die „Business for Nature“-Erklärung für die UN- Vertragsstaatenkonferenz zur biologischen Vielfalt (COP16) (Oktober 2024)', '2026-02-02 23:07:26'),
(869, 89, 57, 43, '144-18-1', 144, 'Lenzing und die ÖBf (Österreichische Bundesforste) haben sich auf ei- nen Aktionsplan für das Engagement zum Schutz und Erhalt der Torf- moore im Ausseerland in der Steiermark (Österreich) geeinigt. Feucht- wiesen mit ihrer außergewöhnlich hohen biologischen Vielfalt und Am- phibienteiche werden wiederhergestellt.', '2026-02-02 23:07:26'),
(870, 90, 57, 43, '144-19-1', 144, 'Lenzing erreicht zum vierten Mal die höchste Hot Button-Kategorie „Dark Green Shirt“ der CanopyStyle-Initiative', '2026-02-02 23:07:26'),
(871, 90, 57, 43, '144-19-2', 144, 'CDP (früher: Carbon Disclosure Project) 2024: Lenzing wurde mit „Klima A“ vier Jahre in Folge bewertet, und mit „Wald A-“ und „Wasser B“ aus- gezeichnet, was eine hohe Transparenz und die Integration von Umwelt- aspekten in die Unternehmensstrategie belegt.', '2026-02-02 23:07:26'),
(872, 13, 57, 43, '149-20-1', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(873, 15, 57, 43, '149-21-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(874, 15, 57, 43, '149-21-2', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(875, 16, 57, 43, '151-22-1', 151, 'Maßnahme(n) Lenzing forstet 20 ha degradierte Flächen in Albanien auf', '2026-02-02 23:07:26'),
(876, 17, 57, 43, '149-23-1', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(877, 18, 57, 43, '148-24-1', 148, 'Bei der Darstellung der Maßnahmen von Lenzing im Bereich Bio- diversität und Ökosysteme wird der AR3T-Rahmen (Vermeiden, Reduzieren, Wiederherstellen, Regenerieren, Transformieren, engl. Avoid, Reduce, Restore, Regenerate, Transform) als nützliches Ordnungsschema angesehen. Entwickelt wurde er ausgehend von der Abhilfemaßnahmenhierarchie, die in der Leistungsnorm 6 der', '2026-02-02 23:07:26'),
(878, 18, 57, 43, '149-24-2', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(879, 18, 57, 43, '149-24-3', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(880, 18, 57, 43, '149-24-4', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(881, 18, 57, 43, '150-24-5', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26'),
(882, 19, 57, 43, '149-25-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(883, 20, 57, 43, '149-26-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(884, 26, 57, 43, '148-27-1', 148, 'Bei der Darstellung der Maßnahmen von Lenzing im Bereich Bio- diversität und Ökosysteme wird der AR3T-Rahmen (Vermeiden, Reduzieren, Wiederherstellen, Regenerieren, Transformieren, engl. Avoid, Reduce, Restore, Regenerate, Transform) als nützliches Ordnungsschema angesehen. Entwickelt wurde er ausgehend von der Abhilfemaßnahmenhierarchie, die in der Leistungsnorm 6 der', '2026-02-02 23:07:26'),
(885, 26, 57, 43, '149-27-2', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(886, 26, 57, 43, '149-27-3', 149, 'Reduce (Reduzieren): Kreislaufwirtschaft und Klimaziele', '2026-02-02 23:07:26'),
(887, 26, 57, 43, '149-27-4', 149, 'Diese Maßnahmen zielen auf die Auswirkungen des Klimawandels als Ursache des Biodiversitätsverlusts ab. Das Ziel ist es hier, weni- ger natürliche Ressourcen zu verbrauchen und die Auswirkungen von THG-Emissionen und Umweltverschmutzung zu minimieren.', '2026-02-02 23:07:26'),
(888, 26, 57, 43, '149-27-5', 149, 'Vermeiden von Umweltverschmutzung Im Einklang mit dem strategischen Kernbereich „Ökologisierung der Wertschöpfungskette“ hat die Lenzing Gruppe Ziele und lau- fende Programme zur Reduktion von Emissionen (einschließlich THG-Emissionen) in Gewässer und in die Luft eingeführt. Erreicht wird dies durch Investitionen in sauberere Energie oder die Schaf- fung geschlossener Kreisläufe, z. B. bei Chemikalien. Weitere Infor- mationen finden Sie in den Kapiteln „E1 Klimawandel“ und „E2 Um- weltverschmutzung“.', '2026-02-02 23:07:26'),
(889, 26, 57, 43, '149-27-6', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(890, 26, 57, 43, '150-27-7', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26');
INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(891, 31, 57, 43, '149-28-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(892, 31, 57, 43, '149-28-2', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(893, 32, 57, 43, '149-29-1', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(894, 33, 57, 43, '148-30-1', 148, 'Bei der Darstellung der Maßnahmen von Lenzing im Bereich Bio- diversität und Ökosysteme wird der AR3T-Rahmen (Vermeiden, Reduzieren, Wiederherstellen, Regenerieren, Transformieren, engl. Avoid, Reduce, Restore, Regenerate, Transform) als nützliches Ordnungsschema angesehen. Entwickelt wurde er ausgehend von der Abhilfemaßnahmenhierarchie, die in der Leistungsnorm 6 der', '2026-02-02 23:07:26'),
(895, 33, 57, 43, '149-30-2', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(896, 33, 57, 43, '149-30-3', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(897, 39, 57, 43, '149-31-1', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(898, 42, 57, 43, '149-32-1', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(899, 42, 57, 43, '149-32-2', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(900, 42, 57, 43, '149-32-3', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(901, 42, 57, 43, '150-32-4', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26'),
(902, 44, 57, 43, '148-33-1', 148, 'Bei der Darstellung der Maßnahmen von Lenzing im Bereich Bio- diversität und Ökosysteme wird der AR3T-Rahmen (Vermeiden, Reduzieren, Wiederherstellen, Regenerieren, Transformieren, engl. Avoid, Reduce, Restore, Regenerate, Transform) als nützliches Ordnungsschema angesehen. Entwickelt wurde er ausgehend von der Abhilfemaßnahmenhierarchie, die in der Leistungsnorm 6 der', '2026-02-02 23:07:26'),
(903, 44, 57, 43, '149-33-2', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(904, 44, 57, 43, '150-33-3', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26'),
(905, 49, 57, 43, '150-34-1', 150, 'der Ökosysteme zum Schutz von Flora und Fauna findet ein oder zwei Mal jährlich statt und deckt die gesamte Plantagenfläche ab. Weitere Informationen finden Sie unter „Naturschutzfläche inner- halb der Plantagen von LD Celulose” im Abschnitt „Management der Auswirkungen, Risiken und Chancen” in diesem Kapitel.', '2026-02-02 23:07:26'),
(906, 51, 57, 43, '149-35-1', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(907, 52, 57, 43, '148-36-1', 148, 'Nachhaltigkeits-Policy Lenzings Nachhaltigkeits-Policy behandelt die negativen Auswir- kungen von Lenzing und ihrer Wertschöpfungskette auf Klimawan- del und Biodiversitätsverlust, indem sie die Dekarbonisierung ent- lang der gesamten Wertschöpfungskette fördert und die Erhaltung der natürlichen Ressourcen, Energieeinsparung und Biodiversität unterstützt. Weitere Informationen über die ESRS 2 MDR-P der Nachhaltigkeits-Policy finden Sie im Abschnitt „Nachhaltigkeits- strategie“, Kapitel „ESRS 2 Allgemeine Angaben“.', '2026-02-02 23:07:26'),
(908, 54, 57, 43, '148-37-1', 148, 'Nachhaltigkeits-Policy Lenzings Nachhaltigkeits-Policy behandelt die negativen Auswir- kungen von Lenzing und ihrer Wertschöpfungskette auf Klimawan- del und Biodiversitätsverlust, indem sie die Dekarbonisierung ent- lang der gesamten Wertschöpfungskette fördert und die Erhaltung der natürlichen Ressourcen, Energieeinsparung und Biodiversität unterstützt. Weitere Informationen über die ESRS 2 MDR-P der Nachhaltigkeits-Policy finden Sie im Abschnitt „Nachhaltigkeits- strategie“, Kapitel „ESRS 2 Allgemeine Angaben“.', '2026-02-02 23:07:26'),
(909, 57, 57, 43, '148-38-1', 148, 'Nachhaltigkeits-Policy Lenzings Nachhaltigkeits-Policy behandelt die negativen Auswir- kungen von Lenzing und ihrer Wertschöpfungskette auf Klimawan- del und Biodiversitätsverlust, indem sie die Dekarbonisierung ent- lang der gesamten Wertschöpfungskette fördert und die Erhaltung der natürlichen Ressourcen, Energieeinsparung und Biodiversität unterstützt. Weitere Informationen über die ESRS 2 MDR-P der Nachhaltigkeits-Policy finden Sie im Abschnitt „Nachhaltigkeits- strategie“, Kapitel „ESRS 2 Allgemeine Angaben“.', '2026-02-02 23:07:26'),
(910, 57, 57, 43, '149-38-2', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(911, 57, 57, 43, '149-38-4', 149, 'Die Forstzertifikate der Lenzing Gruppe decken in ihren internatio- nalen Standards allgemeine Kriterien zum Schutz der Biodiversität und der Wald-Ökosysteme ab. Zusätzliche Kriterien finden sich in den nationalen Standards, die sich von Land zu Land unterscheiden. So ist beispielsweise der Prozentsatz der vorgesehenen Natur- schutzflächen in den einzelnen Ländern und sogar in verschiede- nen Regionen innerhalb der Länder unterschiedlich.', '2026-02-02 23:07:26'),
(912, 58, 57, 43, '151-39-2', 151, 'Umsetzung von Maßnahmen zur Walderhaltung für 20 ha in Albanien in Kombination mit einem Social-Impact- Projekt bis 2024', '2026-02-02 23:07:26'),
(913, 59, 57, 43, '148-40-1', 148, 'Nachhaltigkeits-Policy Lenzings Nachhaltigkeits-Policy behandelt die negativen Auswir- kungen von Lenzing und ihrer Wertschöpfungskette auf Klimawan- del und Biodiversitätsverlust, indem sie die Dekarbonisierung ent- lang der gesamten Wertschöpfungskette fördert und die Erhaltung der natürlichen Ressourcen, Energieeinsparung und Biodiversität unterstützt. Weitere Informationen über die ESRS 2 MDR-P der Nachhaltigkeits-Policy finden Sie im Abschnitt „Nachhaltigkeits- strategie“, Kapitel „ESRS 2 Allgemeine Angaben“.', '2026-02-02 23:07:26'),
(914, 59, 57, 43, '149-40-2', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(915, 60, 57, 43, '149-41-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(916, 61, 57, 43, '149-42-2', 149, 'Die Forstzertifikate der Lenzing Gruppe decken in ihren internatio- nalen Standards allgemeine Kriterien zum Schutz der Biodiversität und der Wald-Ökosysteme ab. Zusätzliche Kriterien finden sich in den nationalen Standards, die sich von Land zu Land unterscheiden. So ist beispielsweise der Prozentsatz der vorgesehenen Natur- schutzflächen in den einzelnen Ländern und sogar in verschiede- nen Regionen innerhalb der Länder unterschiedlich.', '2026-02-02 23:07:26'),
(917, 62, 57, 43, '149-43-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(918, 62, 57, 43, '149-43-2', 149, 'Die Forstzertifikate der Lenzing Gruppe decken in ihren internatio- nalen Standards allgemeine Kriterien zum Schutz der Biodiversität und der Wald-Ökosysteme ab. Zusätzliche Kriterien finden sich in den nationalen Standards, die sich von Land zu Land unterscheiden. So ist beispielsweise der Prozentsatz der vorgesehenen Natur- schutzflächen in den einzelnen Ländern und sogar in verschiede- nen Regionen innerhalb der Länder unterschiedlich.', '2026-02-02 23:07:26'),
(919, 62, 57, 43, '150-43-3', 150, 'der Ökosysteme zum Schutz von Flora und Fauna findet ein oder zwei Mal jährlich statt und deckt die gesamte Plantagenfläche ab. Weitere Informationen finden Sie unter „Naturschutzfläche inner- halb der Plantagen von LD Celulose” im Abschnitt „Management der Auswirkungen, Risiken und Chancen” in diesem Kapitel.', '2026-02-02 23:07:26'),
(920, 69, 57, 43, '148-44-1', 148, 'Nachhaltigkeits-Policy Lenzings Nachhaltigkeits-Policy behandelt die negativen Auswir- kungen von Lenzing und ihrer Wertschöpfungskette auf Klimawan- del und Biodiversitätsverlust, indem sie die Dekarbonisierung ent- lang der gesamten Wertschöpfungskette fördert und die Erhaltung der natürlichen Ressourcen, Energieeinsparung und Biodiversität unterstützt. Weitere Informationen über die ESRS 2 MDR-P der Nachhaltigkeits-Policy finden Sie im Abschnitt „Nachhaltigkeits- strategie“, Kapitel „ESRS 2 Allgemeine Angaben“.', '2026-02-02 23:07:26'),
(921, 69, 57, 43, '149-44-2', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(922, 69, 57, 43, '149-44-3', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(923, 70, 57, 43, '149-45-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(924, 70, 57, 43, '149-45-2', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(925, 72, 57, 43, '149-46-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(926, 72, 57, 43, '150-46-2', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26'),
(927, 73, 57, 43, '148-47-1', 148, 'Lenzings Maßnahmen', '2026-02-02 23:07:26'),
(928, 73, 57, 43, '148-47-2', 148, '[ESRS E4-3; GRI 3-3d]', '2026-02-02 23:07:26'),
(929, 73, 57, 43, '148-47-3', 148, 'Bei der Darstellung der Maßnahmen von Lenzing im Bereich Bio- diversität und Ökosysteme wird der AR3T-Rahmen (Vermeiden, Reduzieren, Wiederherstellen, Regenerieren, Transformieren, engl. Avoid, Reduce, Restore, Regenerate, Transform) als nützliches Ordnungsschema angesehen. Entwickelt wurde er ausgehend von der Abhilfemaßnahmenhierarchie, die in der Leistungsnorm 6 der', '2026-02-02 23:07:26'),
(930, 73, 57, 43, '149-47-4', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(931, 73, 57, 43, '149-47-5', 149, 'Avoid (Vermeiden): Sorgfaltspflicht in Bezug auf Biodiversität durch nachhaltige Beschaffung', '2026-02-02 23:07:26'),
(932, 73, 57, 43, '149-47-6', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:26'),
(933, 73, 57, 43, '149-47-8', 149, 'Reduce (Reduzieren): Kreislaufwirtschaft und Klimaziele', '2026-02-02 23:07:26'),
(934, 73, 57, 43, '149-47-9', 149, 'Diese Maßnahmen zielen auf die Auswirkungen des Klimawandels als Ursache des Biodiversitätsverlusts ab. Das Ziel ist es hier, weni- ger natürliche Ressourcen zu verbrauchen und die Auswirkungen von THG-Emissionen und Umweltverschmutzung zu minimieren.', '2026-02-02 23:07:26'),
(935, 73, 57, 43, '149-47-10', 149, 'Vermeiden von Umweltverschmutzung Im Einklang mit dem strategischen Kernbereich „Ökologisierung der Wertschöpfungskette“ hat die Lenzing Gruppe Ziele und lau- fende Programme zur Reduktion von Emissionen (einschließlich THG-Emissionen) in Gewässer und in die Luft eingeführt. Erreicht wird dies durch Investitionen in sauberere Energie oder die Schaf- fung geschlossener Kreisläufe, z. B. bei Chemikalien. Weitere Infor- mationen finden Sie in den Kapiteln „E1 Klimawandel“ und „E2 Um- weltverschmutzung“.', '2026-02-02 23:07:26'),
(936, 73, 57, 43, '149-47-11', 149, 'Ressourcennutzung [Ressourcennutzung in Verbindung zu Biodiversität nur GRI 3-3d]', '2026-02-02 23:07:26'),
(937, 73, 57, 43, '149-47-12', 149, 'Lenzing setzt sich für die Kaskadennutzung von Holz ein. Das be- deutet, dass verschiedene Holzqualitäten je nach ihrer Wertigkeit für verschiedene Anwendungen genutzt werden. Lenzing verwen- det vor allem Holz, das aus kleinen Bäumen mittels Durchforstung und aus Teilen von großen Bäumen gewonnen wird, die für hoch- wertige Produkte wie Möbel oder das Bauwesen ungeeignet sind. Außerdem werden Hackschnitzel verwendet, die als Nebenpro- dukt in Sägewerken anfallen. Lenzing bemüht sich somit kontinu- ierlich, Holz bewusst zu verwenden und so wenig natürliche Res- sourcen wie möglich einzusetzen.', '2026-02-02 23:07:26'),
(938, 73, 57, 43, '149-47-13', 149, 'Die Bioraffinerien von Lenzing erzeugen Faserzellstoff als Haupt- produkt, aber auch mehrere Bioraffinerie- und Co-Produkte sowie erneuerbare Energie. Das Holz wird also zu 100 Prozent verwertet.', '2026-02-02 23:07:26'),
(939, 73, 57, 43, '149-47-14', 149, 'Das Recycling von Cellulosetextilien und die Umwandlung in neue Fasern kann die Ökosysteme, zum Beispiel in Bezug auf die Land- und Wassernutzung, entlasten und steht deshalb relativ hoch auf Lenzings Innovationsagenda. Der REFIBRA™-Prozess wurde ent- wickelt, um Baumwolle in Lyocell- oder Viscosefasern zu recyceln, und die Abteilung für Forschung und Entwicklung von Lenzing ar- beitet an ständigen Verbesserungen der Technologie. Das industri- elle Upscaling des Prozesses geht weiter, obgleich das Marktum- feld für Recyclingtextilien schwierig ist.', '2026-02-02 23:07:26'),
(940, 73, 57, 43, '149-47-15', 149, 'Die Forstzertifikate der Lenzing Gruppe decken in ihren internatio- nalen Standards allgemeine Kriterien zum Schutz der Biodiversität und der Wald-Ökosysteme ab. Zusätzliche Kriterien finden sich in den nationalen Standards, die sich von Land zu Land unterscheiden. So ist beispielsweise der Prozentsatz der vorgesehenen Natur- schutzflächen in den einzelnen Ländern und sogar in verschiede- nen Regionen innerhalb der Länder unterschiedlich.', '2026-02-02 23:07:26'),
(941, 73, 57, 43, '149-47-16', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(942, 73, 57, 43, '149-47-17', 149, '19 Carle, J., und Holmgren, P. (2003). Working Paper 79. Definitions Related to Planted Forests. In: Food and Agriculture Organization of the United Nations (2003). Forest Resources Assessment Program Working paper series. Verfügbar unter:', '2026-02-02 23:07:26'),
(943, 73, 57, 43, '149-47-18', 149, 'https://www.fao.org/forestry-fao/25853- 0d4f50dd8626f4bd6248009fc68f892fb.pdf', '2026-02-02 23:07:26'),
(944, 73, 57, 43, '150-47-19', 150, 'der Ökosysteme zum Schutz von Flora und Fauna findet ein oder zwei Mal jährlich statt und deckt die gesamte Plantagenfläche ab. Weitere Informationen finden Sie unter „Naturschutzfläche inner- halb der Plantagen von LD Celulose” im Abschnitt „Management der Auswirkungen, Risiken und Chancen” in diesem Kapitel.', '2026-02-02 23:07:26'),
(945, 73, 57, 43, '150-47-20', 150, 'Weitere Informationen über Aktionen in Bezug auf die “Negativen Auswirkungen von Lenzing und ihrer Wertschöpfungskette auf- grund ihres Beitrags zum Klimawandel und dementsprechend zum Verlust der Biodiversität” finden Sie im Abschnitt „Klimaaktionsplan” im Kapitel „E1 Klimawandel”.', '2026-02-02 23:07:26'),
(946, 73, 57, 43, '150-47-21', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26'),
(947, 74, 57, 43, '148-48-1', 148, 'Bei der Darstellung der Maßnahmen von Lenzing im Bereich Bio- diversität und Ökosysteme wird der AR3T-Rahmen (Vermeiden, Reduzieren, Wiederherstellen, Regenerieren, Transformieren, engl. Avoid, Reduce, Restore, Regenerate, Transform) als nützliches Ordnungsschema angesehen. Entwickelt wurde er ausgehend von der Abhilfemaßnahmenhierarchie, die in der Leistungsnorm 6 der', '2026-02-02 23:07:26'),
(948, 74, 57, 43, '149-48-2', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(949, 74, 57, 43, '150-48-3', 150, 'AR3T Aktionsrahmen von SBTN, 2020a', '2026-02-02 23:07:26'),
(950, 74, 57, 43, '150-48-4', 150, 'Avoid (Vermeiden)', '2026-02-02 23:07:26'),
(951, 74, 57, 43, '150-48-5', 150, 'Auswirkungen von vornherein verhindern: die Auswirkungen vollständig vermeiden', '2026-02-02 23:07:26'),
(952, 74, 57, 43, '150-48-6', 150, 'Reduce (Reduzieren)', '2026-02-02 23:07:26'),
(953, 74, 57, 43, '150-48-7', 150, 'Minimieren der Auswirkungen, ohne sie jedoch unbedingt zu beseitigen', '2026-02-02 23:07:26'),
(954, 74, 57, 43, '150-48-8', 150, 'Restore (Wiederherstellen)', '2026-02-02 23:07:26'),
(955, 74, 57, 43, '150-48-9', 150, 'Initiierung oder Beschleunigung der Wiederherstellung eines Ökosystems im Hinblick auf seine Gesundheit, Integrität und Nachhaltigkeit, wobei der Schwerpunkt auf dauerhaften Zustandsänderungen liegt', '2026-02-02 23:07:26'),
(956, 74, 57, 43, '150-48-10', 150, 'Regenerate (Verbessern)', '2026-02-02 23:07:26'),
(957, 74, 57, 43, '150-48-11', 150, 'Ergreifen von Maßnahmen, die im Rahmen der bestehenden Landnutzung zur Verbesserung der biophysikalischen Funktion und/oder ökologischen Produktivität eines Ökosystems oder seiner Bestandteile führen sollen, oft mit Schwerpunkt auf einigen wenigen spezifischen Beiträgen der Natur für den Menschen ( z. B. konzentriert sich die regenerative Landwirtschaft oft auf die CO2-Abscheidung, die Nahrungsmittelproduktion und die Stickstoff- und Phosphorrückhaltung)', '2026-02-02 23:07:26'),
(958, 74, 57, 43, '150-48-12', 150, 'Transform (Transformieren)', '2026-02-02 23:07:26'),
(959, 74, 57, 43, '150-48-13', 150, 'Ergreifen von Maßnahmen, die zu einem systemweiten Wandel beitragen, insbesondere um die Ursachen des Naturverlusts zu verändern, z. B. durch technologische, wirtschaftliche, institutionelle und soziale Faktoren und Veränderungen der zugrunde liegenden Werte und Verhaltensweisen', '2026-02-02 23:07:26'),
(960, 82, 57, 43, '149-49-1', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(961, 86, 57, 43, '150-50-2', 150, 'der Ökosysteme zum Schutz von Flora und Fauna findet ein oder zwei Mal jährlich statt und deckt die gesamte Plantagenfläche ab. Weitere Informationen finden Sie unter „Naturschutzfläche inner- halb der Plantagen von LD Celulose” im Abschnitt „Management der Auswirkungen, Risiken und Chancen” in diesem Kapitel.', '2026-02-02 23:07:26'),
(962, 87, 57, 43, '149-51-1', 149, 'International Financial Corporation beschrieben ist. Nachfolgend wird dargelegt, wie Lenzing diesen Rahmen in ihrem eigenen Ein- flussbereich implementiert. Lenzing unterstützt weltweit mehrere Wiederherstellungs- und Regenerationsprojekte innerhalb und au- ßerhalb ihrer Wertschöpfungskette, führt aber keine Kompensati- onsmaßnahmen für Biodiversität durch. Die Einbeziehung von In- teressensgruppen findet statt, bisher wurde noch kein lokales oder indigenes Wissen über naturbasierte Lösungen und andere rele- vante Aspekte in interne Prozesse eingebunden.', '2026-02-02 23:07:26'),
(963, 87, 57, 43, '149-51-2', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(964, 88, 57, 43, '150-52-1', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26'),
(965, 89, 57, 43, '151-53-1', 151, 'Umsetzung von Maßnahmen zur Walderhaltung für 20 ha in Albanien in Kombination mit einem Social-Impact- Projekt bis 2024', '2026-02-02 23:07:26'),
(966, 89, 57, 43, '151-53-2', 151, 'Maßnahme(n) Lenzing forstet 20 ha degradierte Flächen in Albanien auf', '2026-02-02 23:07:26'),
(967, 89, 57, 43, '151-53-3', 151, 'Maßnahme(n) Lenzing erhöht die Naturschutzfläche am Standort in Indianópolis (Brasilien) von 13.000 ha auf 20.000 ha', '2026-02-02 23:07:26'),
(968, 89, 57, 43, '151-53-4', 151, 'Status in 2024 Lenzing hat das ursprüngliche Ziel von 15.000 ha im Jahr 2022 erreicht und die Gesamtschutzfläche in Brasilien sogar über das Ziel', '2026-02-02 23:07:26'),
(969, 89, 57, 43, '151-53-5', 151, 'hinaus auf mehr als 20.000 ha im Jahr 2024 erhöht. Im Jahr 2024 wurde das Ziel und die Maßnahme auf 20.000 ha erhöht.', '2026-02-02 23:07:26'),
(970, 89, 57, 43, '151-53-6', 151, 'Status in 2024 Lenzing unterstützte 2024 mehrere Projekte außerhalb seiner Wertschöpfungskette, zum Beispiel ein Projekt in Österreich zur', '2026-02-02 23:07:26'),
(971, 90, 57, 43, '150-54-1', 150, 'Lenzings Biodiversitätsziele', '2026-02-02 23:07:26'),
(972, 90, 57, 43, '150-54-2', 150, '[ESRS E4-4; GRI 3-3e]', '2026-02-02 23:07:26'),
(973, 90, 57, 43, '150-54-3', 150, 'Siehe „Nachhaltigkeitsziele“ im Abschnitt Managementansatz am Anfang dieses Kapitels. Sämtliche Nachhaltigkeitsziele von Lenzing und der Prozess für deren Festlegung und Überwachung finden Sie im Abschnitt „Nachhaltigkeitsziele, Maßnahmen und Fortschritte“ im Kapitel „ESRS 2 Allgemeine Angaben”', '2026-02-02 23:07:26'),
(974, 96, 57, 43, '151-55-1', 151, 'Umsetzung von Maßnahmen zur Walderhaltung für 20 ha in Albanien in Kombination mit einem Social-Impact- Projekt bis 2024', '2026-02-02 23:07:26'),
(975, 96, 57, 43, '151-55-2', 151, 'Maßnahme(n) Lenzing erhöht die Naturschutzfläche am Standort in Indianópolis (Brasilien) von 13.000 ha auf 20.000 ha', '2026-02-02 23:07:26'),
(976, 96, 57, 43, '151-55-3', 151, 'hinaus auf mehr als 20.000 ha im Jahr 2024 erhöht. Im Jahr 2024 wurde das Ziel und die Maßnahme auf 20.000 ha erhöht.', '2026-02-02 23:07:26'),
(977, 97, 57, 43, '151-56-1', 151, 'Umsetzung von Maßnahmen zur Walderhaltung für 20 ha in Albanien in Kombination mit einem Social-Impact- Projekt bis 2024', '2026-02-02 23:07:26'),
(978, 97, 57, 43, '151-56-2', 151, 'Maßnahme(n) Lenzing erhöht die Naturschutzfläche am Standort in Indianópolis (Brasilien) von 13.000 ha auf 20.000 ha', '2026-02-02 23:07:26'),
(979, 99, 57, 43, '151-57-1', 151, 'Umsetzung von Maßnahmen zur Walderhaltung für 20 ha in Albanien in Kombination mit einem Social-Impact- Projekt bis 2024', '2026-02-02 23:07:26'),
(980, 99, 57, 43, '151-57-2', 151, 'Maßnahme(n) Lenzing forstet 20 ha degradierte Flächen in Albanien auf', '2026-02-02 23:07:26'),
(981, 99, 57, 43, '151-57-3', 151, 'Maßnahme(n) Lenzing erhöht die Naturschutzfläche am Standort in Indianópolis (Brasilien) von 13.000 ha auf 20.000 ha', '2026-02-02 23:07:26'),
(982, 106, 57, 43, '150-58-1', 150, 'der Ökosysteme zum Schutz von Flora und Fauna findet ein oder zwei Mal jährlich statt und deckt die gesamte Plantagenfläche ab. Weitere Informationen finden Sie unter „Naturschutzfläche inner- halb der Plantagen von LD Celulose” im Abschnitt „Management der Auswirkungen, Risiken und Chancen” in diesem Kapitel.', '2026-02-02 23:07:26'),
(983, 106, 57, 43, '151-58-2', 151, 'Maßnahme(n) Lenzing erhöht die Naturschutzfläche am Standort in Indianópolis (Brasilien) von 13.000 ha auf 20.000 ha', '2026-02-02 23:07:26'),
(984, 106, 57, 43, '151-58-3', 151, 'hinaus auf mehr als 20.000 ha im Jahr 2024 erhöht. Im Jahr 2024 wurde das Ziel und die Maßnahme auf 20.000 ha erhöht.', '2026-02-02 23:07:26'),
(985, 112, 57, 43, '151-59-1', 151, 'Maßnahme(n) Lenzing erhöht die Naturschutzfläche am Standort in Indianópolis (Brasilien) von 13.000 ha auf 20.000 ha', '2026-02-02 23:07:26'),
(986, 112, 57, 43, '151-59-2', 151, 'hinaus auf mehr als 20.000 ha im Jahr 2024 erhöht. Im Jahr 2024 wurde das Ziel und die Maßnahme auf 20.000 ha erhöht.', '2026-02-02 23:07:26'),
(987, 113, 57, 43, '151-60-1', 151, 'Umsetzung von Maßnahmen zur Walderhaltung für 20 ha in Albanien in Kombination mit einem Social-Impact- Projekt bis 2024', '2026-02-02 23:07:26'),
(988, 113, 57, 43, '151-60-2', 151, 'Maßnahme(n) Lenzing forstet 20 ha degradierte Flächen in Albanien auf', '2026-02-02 23:07:26'),
(989, 113, 57, 43, '151-60-3', 151, 'Status in 2024 Lenzing unterstützte 2024 mehrere Projekte außerhalb seiner Wertschöpfungskette, zum Beispiel ein Projekt in Österreich zur', '2026-02-02 23:07:26'),
(990, 114, 57, 43, '149-61-1', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(991, 117, 57, 43, '149-62-1', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:26'),
(992, 117, 57, 43, '150-62-2', 150, 'der Ökosysteme zum Schutz von Flora und Fauna findet ein oder zwei Mal jährlich statt und deckt die gesamte Plantagenfläche ab. Weitere Informationen finden Sie unter „Naturschutzfläche inner- halb der Plantagen von LD Celulose” im Abschnitt „Management der Auswirkungen, Risiken und Chancen” in diesem Kapitel.', '2026-02-02 23:07:26'),
(993, 117, 57, 43, '150-62-3', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:26'),
(994, 119, 57, 43, '150-63-1', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:27'),
(995, 121, 57, 43, '150-64-1', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:27'),
(996, 122, 57, 43, '149-65-1', 149, 'Naturschutz /Walderhaltung, Aufforstung, Wiederherstellung und Wiederaufforstung Lenzing ergreift in den Plantagen von LD Celulose Naturschutz- maßnahmen. Diese richten sich auf die Auswirkungen auf Ökosys- temleistungen, den Zustand gefährdeter oder bedrohter Arten in Plantagen und Wäldern und die (unbeabsichtigte) Einführung inva- siver gebietsfremder Arten durch den Holztransport. Lenzings Plantage in Brasilien wird von LD Celulose bewirtschaftet und be- inhaltet Naturschutzflächen, die dem Schutz der biologischen Viel- falt gewidmet sind. Das Monitoring der biologischen Vielfalt und', '2026-02-02 23:07:27'),
(997, 122, 57, 43, '150-65-2', 150, 'Lenzing unterstützt außerdem mehrere Projekte zur Erhaltung, Wiederherstellung, Wiederaufforstung und Aufforstung sowie Lö- sungen in ihrer Lieferkette und in anderen Regionen außerhalb der eigenen Lieferkette, wie etwa Aufforstungsprojekte in Albanien, im Kongo und in den USA. Mit diesen Aktionen und der Unterstützung solcher Wiederherstellungs- und Aufforstungsprojekte adressiert Lenzing die Auswirkungen auf den Zustand der Arten, das globale Ausrottungsrisiko von Arten, Ökosystemleistungen sowie Landnut- zungsänderungen und Klimawandel als Ursachen des Biodiversi- tätsverlusts.', '2026-02-02 23:07:27'),
(998, 124, 57, 43, '151-66-1', 151, 'Maßnahme(n) Lenzing erhöht die Naturschutzfläche am Standort in Indianópolis (Brasilien) von 13.000 ha auf 20.000 ha', '2026-02-02 23:07:27'),
(999, 124, 57, 43, '151-66-2', 151, 'hinaus auf mehr als 20.000 ha im Jahr 2024 erhöht. Im Jahr 2024 wurde das Ziel und die Maßnahme auf 20.000 ha erhöht.', '2026-02-02 23:07:27'),
(1000, 126, 57, 43, '150-67-1', 150, 'der Ökosysteme zum Schutz von Flora und Fauna findet ein oder zwei Mal jährlich statt und deckt die gesamte Plantagenfläche ab. Weitere Informationen finden Sie unter „Naturschutzfläche inner- halb der Plantagen von LD Celulose” im Abschnitt „Management der Auswirkungen, Risiken und Chancen” in diesem Kapitel.', '2026-02-02 23:07:27'),
(1001, 129, 57, 43, '149-68-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:27'),
(1002, 130, 57, 43, '149-69-1', 149, 'Holz und Faserzellstoff sind die wichtigsten Rohstoffe für Lenzing. Die Lenzing Gruppe übernimmt Verantwortung, indem sie kontinu- ierlich auf nachhaltige Beschaffung setzt. Lenzing bezieht Holz und Faserzellstoff ausschließlich aus naturnahen Wäldern und Planta- gen (gemäß der Definition der Ernährungs- und Landwirtschafts- organisation der Vereinten Nationen, FAO19) Lenzing bezieht weder Holz noch Faserzellstoff aus Urwäldern, geschützten oder gefähr- deten Wäldern. Diese Aktionen richten sich auf Lenzings wesentli- che Auswirkungen auf Wald-Ökosysteme und Biodiversität sowie auf das Risiko von Holzknappheit und hohen Holzpreisen durch Biodiversitätsverlust; und die Chance durch positive Positionierung aufgrund von vorbildlicher Praxis bei der Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen.', '2026-02-02 23:07:27'),
(1003, 12, 57, 43, '153-70-1', 153, 'Quantitative Beschreibung der von LD Celulose bewirtschafteten und verwalteten Flächen', '2026-02-02 23:07:27'),
(1004, 12, 57, 43, '153-70-2', 153, 'Naturschutzfläche innerhalb der Plantagen von LD Celulose Die wichtigste direkte Landnutzungsfläche der Lenzing Gruppe sind die Plantagen in Brasilien (Indianópolis) mit einer Gesamtflä- che von 93.908 Hektar (939,08 km2). Diese Fläche wurde vor meh- reren Jahrzehnten in Agrarflächen umgewandelt. In der Nähe be- finden sich große Flächen, die für den Anbau von Soja und Kaffee oder als Weideflächen für Vieh genutzt werden. Bei den Baumarten innerhalb der Plantage handelt es sich hauptsächlich um Eukalyp- tus. Ein Zucht- und Klonselektionsprogramm wird fortgesetzt, um die Widerstandsfähigkeit und den Ertrag der Bäume weiter zu ver- bessern. LD Celulose verwendet keine gentechnisch veränderten Organismen (GVOs).', '2026-02-02 23:07:27');
INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(1005, 13, 57, 43, '151-71-1', 151, 'Das Ziel „Naturschutzfläche Brasilien“ einschließlich der Umset- zung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Zellstoffproduktionsstandort in Indianópolis (Brasilien) auf 15.000 ha wurde erstmals 2020 (Basisjahr) festgelegt, ausgehend von einem Ausgangswert von 13.000 ha Naturschutzfläche in Bra- silien (Basiswert), für die Lenzing in dem Jahr verantwortlich war. Darüber hinaus wurde das Ziel „Naturschutzprojekte“ zur Auswei- tung des Engagements für Walderhaltung, Schutz der Biodiversität und Aufforstung in Regionen mit gefährdeten Wäldern erstmals 2020 (Basisjahr) festgelegt. Das Ziel „Schutzgebiet Brasilien“ um- fasst die „positiven Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“ und die „negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“.', '2026-02-02 23:07:27'),
(1006, 13, 57, 43, '151-71-2', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1007, 13, 57, 43, '152-71-3', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1008, 13, 57, 43, '152-71-4', 152, 'Lenzing hat zwar keine quantitativen Ziele in Bezug auf die „Mög- lichen negativen Auswirkungen auf die Biodiversität durch die Ein- führung invasiver nichtheimischer Arten beim Holztransport“, ver- traut aber bei ihrer Lieferkette auf die Ziele ihrer eigenen Holzliefe- ranten und der nationalen Programme. Für die eigenen Forstbe- triebe wurden im Forstbewirtschaftungsplan (Forest Management Plan) von LD Celulose (Brasilien)20 sowie im Aktionsplan für biolo- gische Vielfalt (noch nicht veröffentlicht) von LD Celulose Maßnah- men bestimmt, die zurzeit umgesetzt werden, um so eine Einfüh- rung invasiver gebietsfremder Arten zu verhindern. Die Wirksam- keit dieser Maßnahmen wird mit Blick auf die Beseitigung exoti- scher Bäume in Naturschutzflächen (Erhaltungsflächen) überwacht.', '2026-02-02 23:07:27'),
(1009, 13, 57, 43, '153-71-5', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1010, 13, 57, 43, '153-71-7', 153, 'Diese Maßnahme adressiert die Auswirkungen auf Ökosystemleis- tungen, den Zustand gefährdeter oder bedrohter Arten in Planta-', '2026-02-02 23:07:27'),
(1011, 14, 57, 43, '153-72-1', 153, 'Naturschutzfläche innerhalb der Plantagen von LD Celulose Die wichtigste direkte Landnutzungsfläche der Lenzing Gruppe sind die Plantagen in Brasilien (Indianópolis) mit einer Gesamtflä- che von 93.908 Hektar (939,08 km2). Diese Fläche wurde vor meh- reren Jahrzehnten in Agrarflächen umgewandelt. In der Nähe be- finden sich große Flächen, die für den Anbau von Soja und Kaffee oder als Weideflächen für Vieh genutzt werden. Bei den Baumarten innerhalb der Plantage handelt es sich hauptsächlich um Eukalyp- tus. Ein Zucht- und Klonselektionsprogramm wird fortgesetzt, um die Widerstandsfähigkeit und den Ertrag der Bäume weiter zu ver- bessern. LD Celulose verwendet keine gentechnisch veränderten Organismen (GVOs).', '2026-02-02 23:07:27'),
(1012, 14, 57, 43, '153-72-2', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1013, 15, 57, 43, '153-73-2', 153, 'Das Gebiete mit schutzbedürftiger Biodiversität und das Natur- schutzgebiet Parque Estadual do Páu Furado befindet sich außer- halb der eigenen Naturschutzflächen aber in der Nähe des LD Celulose Anbaugebietes, etwa 30 Kilometer von der LD Celulose- Plantage entfernt. Dieses Naturschutzgebiet ist von den Aktivitäten von LD Celulose nicht betroffen. Die Plantage liegt etwa 800 km vom Amazonas entfernt.', '2026-02-02 23:07:27'),
(1014, 16, 57, 43, '153-74-1', 153, 'In Bezug auf Landnutzungsänderungen wurden keine Primärwäl- der, natürlich nachwachsende (Sekundär-) Wälder, Savannen, Grasländer oder natürliche Süßwasserökosysteme für eine andere Landnutzung umgewandelt. 2024 wurden jedoch 55 Hektar de- gradierte ehemalige landwirtschaftliche Grünflächen in Forstplan- tagen umgewandelt.', '2026-02-02 23:07:27'),
(1015, 17, 57, 43, '153-75-2', 153, 'Diese Maßnahme adressiert die Auswirkungen auf Ökosystemleis- tungen, den Zustand gefährdeter oder bedrohter Arten in Planta-', '2026-02-02 23:07:27'),
(1016, 18, 57, 43, '151-76-2', 151, 'Das Ziel „Naturschutzfläche Brasilien“ einschließlich der Umset- zung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Zellstoffproduktionsstandort in Indianópolis (Brasilien) auf 15.000 ha wurde erstmals 2020 (Basisjahr) festgelegt, ausgehend von einem Ausgangswert von 13.000 ha Naturschutzfläche in Bra- silien (Basiswert), für die Lenzing in dem Jahr verantwortlich war. Darüber hinaus wurde das Ziel „Naturschutzprojekte“ zur Auswei- tung des Engagements für Walderhaltung, Schutz der Biodiversität und Aufforstung in Regionen mit gefährdeten Wäldern erstmals 2020 (Basisjahr) festgelegt. Das Ziel „Schutzgebiet Brasilien“ um- fasst die „positiven Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“ und die „negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“.', '2026-02-02 23:07:27'),
(1017, 18, 57, 43, '151-76-3', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1018, 18, 57, 43, '152-76-4', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1019, 18, 57, 43, '152-76-5', 152, 'Lenzing hat zwar keine quantitativen Ziele in Bezug auf die „Mög- lichen negativen Auswirkungen auf die Biodiversität durch die Ein- führung invasiver nichtheimischer Arten beim Holztransport“, ver- traut aber bei ihrer Lieferkette auf die Ziele ihrer eigenen Holzliefe- ranten und der nationalen Programme. Für die eigenen Forstbe- triebe wurden im Forstbewirtschaftungsplan (Forest Management Plan) von LD Celulose (Brasilien)20 sowie im Aktionsplan für biolo- gische Vielfalt (noch nicht veröffentlicht) von LD Celulose Maßnah- men bestimmt, die zurzeit umgesetzt werden, um so eine Einfüh- rung invasiver gebietsfremder Arten zu verhindern. Die Wirksam- keit dieser Maßnahmen wird mit Blick auf die Beseitigung exoti- scher Bäume in Naturschutzflächen (Erhaltungsflächen) überwacht.', '2026-02-02 23:07:27'),
(1020, 18, 57, 43, '153-76-6', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1021, 18, 57, 43, '153-76-8', 153, 'Diese Maßnahme adressiert die Auswirkungen auf Ökosystemleis- tungen, den Zustand gefährdeter oder bedrohter Arten in Planta-', '2026-02-02 23:07:27'),
(1022, 20, 57, 43, '151-77-1', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1023, 20, 57, 43, '152-77-2', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1024, 20, 57, 43, '152-77-3', 152, 'Bei der „Chance durch positive Positionierung mit Best-Practice- Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen“ wurden quantitative Ziele erwogen aber noch nicht', '2026-02-02 23:07:27'),
(1025, 20, 57, 43, '153-77-4', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1026, 26, 57, 43, '152-78-2', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1027, 26, 57, 43, '152-78-3', 152, 'Lenzing hat zwar keine quantitativen Ziele in Bezug auf die „Mög- lichen negativen Auswirkungen auf die Biodiversität durch die Ein- führung invasiver nichtheimischer Arten beim Holztransport“, ver- traut aber bei ihrer Lieferkette auf die Ziele ihrer eigenen Holzliefe- ranten und der nationalen Programme. Für die eigenen Forstbe- triebe wurden im Forstbewirtschaftungsplan (Forest Management Plan) von LD Celulose (Brasilien)20 sowie im Aktionsplan für biolo- gische Vielfalt (noch nicht veröffentlicht) von LD Celulose Maßnah- men bestimmt, die zurzeit umgesetzt werden, um so eine Einfüh- rung invasiver gebietsfremder Arten zu verhindern. Die Wirksam- keit dieser Maßnahmen wird mit Blick auf die Beseitigung exoti- scher Bäume in Naturschutzflächen (Erhaltungsflächen) überwacht.', '2026-02-02 23:07:27'),
(1028, 26, 57, 43, '153-78-4', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1029, 26, 57, 43, '153-78-6', 153, 'Bei der von LD Celulose praktizierten verantwortungsbewussten Plantagenbewirtschaftung und beim Umgang mit den Natur- schutzflächen werden Verfahren genutzt, die auf den Schutz der Biodiversität sowie auf den Schutz der Boden- und Gewässerqua- lität abzielen. Beispiele für diese Maßnahmen sind:', '2026-02-02 23:07:27'),
(1030, 31, 57, 43, '153-79-2', 153, 'Das Gebiete mit schutzbedürftiger Biodiversität und das Natur- schutzgebiet Parque Estadual do Páu Furado befindet sich außer- halb der eigenen Naturschutzflächen aber in der Nähe des LD Celulose Anbaugebietes, etwa 30 Kilometer von der LD Celulose- Plantage entfernt. Dieses Naturschutzgebiet ist von den Aktivitäten von LD Celulose nicht betroffen. Die Plantage liegt etwa 800 km vom Amazonas entfernt.', '2026-02-02 23:07:27'),
(1031, 33, 57, 43, '152-80-2', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1032, 33, 57, 43, '152-80-3', 152, 'Lenzing hat zwar keine quantitativen Ziele in Bezug auf die „Mög- lichen negativen Auswirkungen auf die Biodiversität durch die Ein- führung invasiver nichtheimischer Arten beim Holztransport“, ver- traut aber bei ihrer Lieferkette auf die Ziele ihrer eigenen Holzliefe- ranten und der nationalen Programme. Für die eigenen Forstbe- triebe wurden im Forstbewirtschaftungsplan (Forest Management Plan) von LD Celulose (Brasilien)20 sowie im Aktionsplan für biolo- gische Vielfalt (noch nicht veröffentlicht) von LD Celulose Maßnah- men bestimmt, die zurzeit umgesetzt werden, um so eine Einfüh- rung invasiver gebietsfremder Arten zu verhindern. Die Wirksam- keit dieser Maßnahmen wird mit Blick auf die Beseitigung exoti- scher Bäume in Naturschutzflächen (Erhaltungsflächen) überwacht.', '2026-02-02 23:07:27'),
(1033, 33, 57, 43, '153-80-4', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1034, 33, 57, 43, '153-80-6', 153, 'Bei der von LD Celulose praktizierten verantwortungsbewussten Plantagenbewirtschaftung und beim Umgang mit den Natur- schutzflächen werden Verfahren genutzt, die auf den Schutz der Biodiversität sowie auf den Schutz der Boden- und Gewässerqua- lität abzielen. Beispiele für diese Maßnahmen sind:', '2026-02-02 23:07:27'),
(1035, 52, 57, 43, '152-81-2', 152, 'Lenzing bekennt sich explizit in den Beschaffungskriterien der Policy für Holz und Zellstoff dazu, keine Entwaldung zu verursachen', '2026-02-02 23:07:27'),
(1036, 52, 57, 43, '153-81-3', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1037, 54, 57, 43, '153-82-2', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1038, 55, 57, 43, '151-83-2', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1039, 55, 57, 43, '152-83-3', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1040, 57, 57, 43, '153-84-2', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1041, 57, 57, 43, '153-84-4', 153, 'Bei der von LD Celulose praktizierten verantwortungsbewussten Plantagenbewirtschaftung und beim Umgang mit den Natur- schutzflächen werden Verfahren genutzt, die auf den Schutz der Biodiversität sowie auf den Schutz der Boden- und Gewässerqua- lität abzielen. Beispiele für diese Maßnahmen sind:', '2026-02-02 23:07:27'),
(1042, 59, 57, 43, '152-85-2', 152, 'Lenzing bekennt sich explizit in den Beschaffungskriterien der Policy für Holz und Zellstoff dazu, keine Entwaldung zu verursachen', '2026-02-02 23:07:27'),
(1043, 59, 57, 43, '153-85-3', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1044, 61, 57, 43, '153-86-1', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1045, 62, 57, 43, '153-87-1', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1046, 62, 57, 43, '153-87-3', 153, 'Bei der von LD Celulose praktizierten verantwortungsbewussten Plantagenbewirtschaftung und beim Umgang mit den Natur- schutzflächen werden Verfahren genutzt, die auf den Schutz der Biodiversität sowie auf den Schutz der Boden- und Gewässerqua- lität abzielen. Beispiele für diese Maßnahmen sind:', '2026-02-02 23:07:27'),
(1047, 69, 57, 43, '153-88-3', 153, 'Das Gebiete mit schutzbedürftiger Biodiversität und das Natur- schutzgebiet Parque Estadual do Páu Furado befindet sich außer- halb der eigenen Naturschutzflächen aber in der Nähe des LD Celulose Anbaugebietes, etwa 30 Kilometer von der LD Celulose- Plantage entfernt. Dieses Naturschutzgebiet ist von den Aktivitäten von LD Celulose nicht betroffen. Die Plantage liegt etwa 800 km vom Amazonas entfernt.', '2026-02-02 23:07:27'),
(1048, 70, 57, 43, '153-89-1', 153, 'Bei der von LD Celulose praktizierten verantwortungsbewussten Plantagenbewirtschaftung und beim Umgang mit den Natur- schutzflächen werden Verfahren genutzt, die auf den Schutz der Biodiversität sowie auf den Schutz der Boden- und Gewässerqua- lität abzielen. Beispiele für diese Maßnahmen sind:', '2026-02-02 23:07:27'),
(1049, 72, 57, 43, '152-90-1', 152, 'Lenzing bekennt sich explizit in den Beschaffungskriterien der Policy für Holz und Zellstoff dazu, keine Entwaldung zu verursachen', '2026-02-02 23:07:27'),
(1050, 73, 57, 43, '151-91-1', 151, 'Wiederherstellung und zum Schutz von Mooren und Torfgebieten sowie Projekte zur Erhaltung der Wälder durch soziale Auswirkungen in der DR Kongo, Burundi und Tansania. Eine detaillierte Beschreibung aller Projekte finden Sie im Kapitel \"E4 Biodiversität und Ökosysteme\".', '2026-02-02 23:07:27'),
(1051, 73, 57, 43, '151-91-3', 151, 'ten in diesem Kapitel. Das Ziel „Naturschutzprojekt Albanien“ um- fasst die „positive Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“.', '2026-02-02 23:07:27'),
(1052, 73, 57, 43, '151-91-4', 151, 'Das Ziel „Naturschutzfläche Brasilien“ einschließlich der Umset- zung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Zellstoffproduktionsstandort in Indianópolis (Brasilien) auf 15.000 ha wurde erstmals 2020 (Basisjahr) festgelegt, ausgehend von einem Ausgangswert von 13.000 ha Naturschutzfläche in Bra- silien (Basiswert), für die Lenzing in dem Jahr verantwortlich war. Darüber hinaus wurde das Ziel „Naturschutzprojekte“ zur Auswei- tung des Engagements für Walderhaltung, Schutz der Biodiversität und Aufforstung in Regionen mit gefährdeten Wäldern erstmals 2020 (Basisjahr) festgelegt. Das Ziel „Schutzgebiet Brasilien“ um- fasst die „positiven Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“ und die „negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“.', '2026-02-02 23:07:27'),
(1053, 73, 57, 43, '151-91-5', 151, 'Lenzing legte das Ziel „Naturschutzprojekt Albanien“ erstmals 2017 (Basisjahr) fest, damals mit einem Ausgangswert von null (Basis- wert). Weitere Informationen über den Umfang des „Naturschutz- projekts Albanien“ finden Sie in der Projektbeschreibung weiter un-', '2026-02-02 23:07:27'),
(1054, 73, 57, 43, '152-91-6', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1055, 73, 57, 43, '152-91-7', 152, 'festgelegt. Lenzing hat keine Ziele in Bezug auf die Aspekte der vorgelagerten Wertschöpfungskette der „Positiven Auswirkungen auf die Biodiversität durch nachhaltige Holzbeschaffung und Betei- ligung an Aufforstungsprojekten“, denkt aber über Optionen nach. In den letzten Jahren wurden jedoch über die eigene Wertschöp- fungskette hinaus mehrere Aufforstungsprojekte unterstützt.', '2026-02-02 23:07:27'),
(1056, 73, 57, 43, '152-91-8', 152, 'Lenzing hat zwar keine quantitativen Ziele in Bezug auf die „Mög- lichen negativen Auswirkungen auf die Biodiversität durch die Ein- führung invasiver nichtheimischer Arten beim Holztransport“, ver- traut aber bei ihrer Lieferkette auf die Ziele ihrer eigenen Holzliefe- ranten und der nationalen Programme. Für die eigenen Forstbe- triebe wurden im Forstbewirtschaftungsplan (Forest Management Plan) von LD Celulose (Brasilien)20 sowie im Aktionsplan für biolo- gische Vielfalt (noch nicht veröffentlicht) von LD Celulose Maßnah- men bestimmt, die zurzeit umgesetzt werden, um so eine Einfüh- rung invasiver gebietsfremder Arten zu verhindern. Die Wirksam- keit dieser Maßnahmen wird mit Blick auf die Beseitigung exoti- scher Bäume in Naturschutzflächen (Erhaltungsflächen) überwacht.', '2026-02-02 23:07:27'),
(1057, 73, 57, 43, '152-91-9', 152, 'Umsetzung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Faserzellstoffstandort in Indianópolis (Brasilien) auf 15.000 ha bis 2030', '2026-02-02 23:07:27'),
(1058, 73, 57, 43, '153-91-10', 153, 'Die von LD Celulose bewirtschafteten Plantagen stehen ganz im Einklang mit den einschlägigen Richtlinien und den hohen Stan- dards von Lenzing für die Beschaffung von Holz und Faserzellstoff. Bei der Planung wurden die intensive Nutzung der Holzressourcen und die möglichen negativen Auswirkungen auf die Biodiversität in die Risikoanalyse einbezogen. Um diese potenziellen Risiken zu vermeiden, arbeitet LD Celulose mit Naturschutzprogrammen zu- sammen und baut auf die FSC®-Standards.', '2026-02-02 23:07:27'),
(1059, 73, 57, 43, '153-91-12', 153, 'Bei der von LD Celulose praktizierten verantwortungsbewussten Plantagenbewirtschaftung und beim Umgang mit den Natur- schutzflächen werden Verfahren genutzt, die auf den Schutz der Biodiversität sowie auf den Schutz der Boden- und Gewässerqua- lität abzielen. Beispiele für diese Maßnahmen sind:', '2026-02-02 23:07:27'),
(1060, 83, 57, 43, '151-94-1', 151, 'Die Inspiring Cooperation Empowering People (ICEP), die Öster- reichischen Bundesforste (ÖBf), die Canopy Initiative und der Um- weltdachverband wirkten durch ständigen Dialog und Beratungen als Stakeholder maßgeblich an der Festlegung dieser Ziele mit. CDP dient als Plattform für die Berichterstattung über diese The- men. Auch interne Stakeholder wie das Wood and Pulp Team und das Commercial Team spielten bei der Definition dieser Ziele eine entscheidende Rolle.', '2026-02-02 23:07:27'),
(1061, 86, 57, 43, '152-95-2', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1062, 86, 57, 43, '152-95-3', 152, 'Lenzing hat zwar keine quantitativen Ziele in Bezug auf die „Mög- lichen negativen Auswirkungen auf die Biodiversität durch die Ein- führung invasiver nichtheimischer Arten beim Holztransport“, ver- traut aber bei ihrer Lieferkette auf die Ziele ihrer eigenen Holzliefe- ranten und der nationalen Programme. Für die eigenen Forstbe- triebe wurden im Forstbewirtschaftungsplan (Forest Management Plan) von LD Celulose (Brasilien)20 sowie im Aktionsplan für biolo- gische Vielfalt (noch nicht veröffentlicht) von LD Celulose Maßnah- men bestimmt, die zurzeit umgesetzt werden, um so eine Einfüh- rung invasiver gebietsfremder Arten zu verhindern. Die Wirksam- keit dieser Maßnahmen wird mit Blick auf die Beseitigung exoti- scher Bäume in Naturschutzflächen (Erhaltungsflächen) überwacht.', '2026-02-02 23:07:27'),
(1063, 88, 57, 43, '151-96-1', 151, 'Wiederherstellung und zum Schutz von Mooren und Torfgebieten sowie Projekte zur Erhaltung der Wälder durch soziale Auswirkungen in der DR Kongo, Burundi und Tansania. Eine detaillierte Beschreibung aller Projekte finden Sie im Kapitel \"E4 Biodiversität und Ökosysteme\".', '2026-02-02 23:07:27'),
(1064, 88, 57, 43, '152-96-2', 152, 'festgelegt. Lenzing hat keine Ziele in Bezug auf die Aspekte der vorgelagerten Wertschöpfungskette der „Positiven Auswirkungen auf die Biodiversität durch nachhaltige Holzbeschaffung und Betei- ligung an Aufforstungsprojekten“, denkt aber über Optionen nach. In den letzten Jahren wurden jedoch über die eigene Wertschöp- fungskette hinaus mehrere Aufforstungsprojekte unterstützt.', '2026-02-02 23:07:27'),
(1065, 89, 57, 43, '151-97-1', 151, 'Wiederherstellung und zum Schutz von Mooren und Torfgebieten sowie Projekte zur Erhaltung der Wälder durch soziale Auswirkungen in der DR Kongo, Burundi und Tansania. Eine detaillierte Beschreibung aller Projekte finden Sie im Kapitel \"E4 Biodiversität und Ökosysteme\".', '2026-02-02 23:07:27'),
(1066, 89, 57, 43, '151-97-2', 151, 'ten in diesem Kapitel. Das Ziel „Naturschutzprojekt Albanien“ um- fasst die „positive Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“.', '2026-02-02 23:07:27'),
(1067, 89, 57, 43, '151-97-3', 151, 'Das Ziel „Naturschutzfläche Brasilien“ einschließlich der Umset- zung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Zellstoffproduktionsstandort in Indianópolis (Brasilien) auf 15.000 ha wurde erstmals 2020 (Basisjahr) festgelegt, ausgehend von einem Ausgangswert von 13.000 ha Naturschutzfläche in Bra- silien (Basiswert), für die Lenzing in dem Jahr verantwortlich war. Darüber hinaus wurde das Ziel „Naturschutzprojekte“ zur Auswei- tung des Engagements für Walderhaltung, Schutz der Biodiversität und Aufforstung in Regionen mit gefährdeten Wäldern erstmals 2020 (Basisjahr) festgelegt. Das Ziel „Schutzgebiet Brasilien“ um- fasst die „positiven Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“ und die „negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“.', '2026-02-02 23:07:27'),
(1068, 89, 57, 43, '151-97-4', 151, 'Lenzing legte das Ziel „Naturschutzprojekt Albanien“ erstmals 2017 (Basisjahr) fest, damals mit einem Ausgangswert von null (Basis- wert). Weitere Informationen über den Umfang des „Naturschutz- projekts Albanien“ finden Sie in der Projektbeschreibung weiter un-', '2026-02-02 23:07:27'),
(1069, 89, 57, 43, '152-97-5', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1070, 90, 57, 43, '151-98-2', 151, 'Das Ziel „Naturschutzfläche Brasilien“ einschließlich der Umset- zung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Zellstoffproduktionsstandort in Indianópolis (Brasilien) auf 15.000 ha wurde erstmals 2020 (Basisjahr) festgelegt, ausgehend von einem Ausgangswert von 13.000 ha Naturschutzfläche in Bra- silien (Basiswert), für die Lenzing in dem Jahr verantwortlich war. Darüber hinaus wurde das Ziel „Naturschutzprojekte“ zur Auswei- tung des Engagements für Walderhaltung, Schutz der Biodiversität und Aufforstung in Regionen mit gefährdeten Wäldern erstmals 2020 (Basisjahr) festgelegt. Das Ziel „Schutzgebiet Brasilien“ um- fasst die „positiven Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“ und die „negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“.', '2026-02-02 23:07:27'),
(1071, 90, 57, 43, '151-98-3', 151, 'Lenzing legte das Ziel „Naturschutzprojekt Albanien“ erstmals 2017 (Basisjahr) fest, damals mit einem Ausgangswert von null (Basis- wert). Weitere Informationen über den Umfang des „Naturschutz- projekts Albanien“ finden Sie in der Projektbeschreibung weiter un-', '2026-02-02 23:07:27'),
(1072, 90, 57, 43, '151-98-4', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1073, 90, 57, 43, '152-98-5', 152, 'Angebot von Viscose-, Modal- und Lyocell-Stapelfasern mit bis zu 50 Prozent Alttextilien-Recyclinganteil im industriellen Maßstab bis 2025', '2026-02-02 23:07:27'),
(1074, 90, 57, 43, '152-98-6', 152, 'Umsetzung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Faserzellstoffstandort in Indianópolis (Brasilien) auf 15.000 ha bis 2030', '2026-02-02 23:07:27'),
(1075, 96, 57, 43, '151-101-2', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1076, 96, 57, 43, '152-101-3', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1077, 97, 57, 43, '151-102-1', 151, 'Wiederherstellung und zum Schutz von Mooren und Torfgebieten sowie Projekte zur Erhaltung der Wälder durch soziale Auswirkungen in der DR Kongo, Burundi und Tansania. Eine detaillierte Beschreibung aller Projekte finden Sie im Kapitel \"E4 Biodiversität und Ökosysteme\".', '2026-02-02 23:07:27'),
(1078, 97, 57, 43, '151-102-2', 151, 'ten in diesem Kapitel. Das Ziel „Naturschutzprojekt Albanien“ um- fasst die „positive Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“.', '2026-02-02 23:07:27'),
(1079, 97, 57, 43, '151-102-3', 151, 'Das Ziel „Naturschutzfläche Brasilien“ einschließlich der Umset- zung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Zellstoffproduktionsstandort in Indianópolis (Brasilien) auf 15.000 ha wurde erstmals 2020 (Basisjahr) festgelegt, ausgehend von einem Ausgangswert von 13.000 ha Naturschutzfläche in Bra- silien (Basiswert), für die Lenzing in dem Jahr verantwortlich war. Darüber hinaus wurde das Ziel „Naturschutzprojekte“ zur Auswei- tung des Engagements für Walderhaltung, Schutz der Biodiversität und Aufforstung in Regionen mit gefährdeten Wäldern erstmals 2020 (Basisjahr) festgelegt. Das Ziel „Schutzgebiet Brasilien“ um- fasst die „positiven Auswirkungen auf die Biodiversität durch nach- haltige Holzbeschaffung und Beteiligung an Aufforstungsprojek- ten“ und die „negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“.', '2026-02-02 23:07:27'),
(1080, 97, 57, 43, '151-102-4', 151, 'Lenzing legte das Ziel „Naturschutzprojekt Albanien“ erstmals 2017 (Basisjahr) fest, damals mit einem Ausgangswert von null (Basis- wert). Weitere Informationen über den Umfang des „Naturschutz- projekts Albanien“ finden Sie in der Projektbeschreibung weiter un-', '2026-02-02 23:07:27'),
(1081, 97, 57, 43, '152-102-5', 152, 'Umsetzung von Maßnahmen zum Naturschutz und zur Walderhaltung am neuen Faserzellstoffstandort in Indianópolis (Brasilien) auf 15.000 ha bis 2030', '2026-02-02 23:07:27'),
(1082, 104, 57, 43, '153-105-1', 153, 'In Bezug auf Landnutzungsänderungen wurden keine Primärwäl- der, natürlich nachwachsende (Sekundär-) Wälder, Savannen, Grasländer oder natürliche Süßwasserökosysteme für eine andere Landnutzung umgewandelt. 2024 wurden jedoch 55 Hektar de- gradierte ehemalige landwirtschaftliche Grünflächen in Forstplan- tagen umgewandelt.', '2026-02-02 23:07:27'),
(1083, 104, 57, 43, '154-105-2', 154, 'Monitoring der biologischen Vielfalt und der Ökosysteme Versuche, die Auswirkungen der Landnutzung auf die Biodiversität zu quantifizieren, bestehen in der Regel aus zwei Komponenten: die Größe der genutzten Land- bzw. Waldfläche und die Intensität der Nutzung.', '2026-02-02 23:07:27'),
(1084, 104, 57, 43, '154-105-3', 154, 'Die Fläche der von LD Celulose in Brasilien bewirtschafteten Plan- tagen ist in genauen Messungen dokumentiert (Tabelle 42). Die Be- wertung der für die Holzbeschaffung von Lenzing genutzten ande- ren Flächen ist Teil des initiierten Projektes „Biodiversitätskonzept“. Je nach Waldtyp, Landbesitz, Beschaffungsgebiet und Position in der Lieferkette (Holz- oder Faserzellstoffbeschaffung von Lenzing, Tabelle 43) können Unterschiede in der Datenverfügbarkeit und - qualität auftreten. 2023 wurden erste Versuche gestartet, die Nut- zung der Waldflächen für die direkte Holzversorgung von Lenzings europäischen Zellstoffwerken zu schätzen. Die Schätzungen laufen noch, sodass derzeit noch keine Ergebnisse mitgeteilt werden kön- nen.', '2026-02-02 23:07:27'),
(1085, 105, 57, 43, '153-106-1', 153, 'In Bezug auf Landnutzungsänderungen wurden keine Primärwäl- der, natürlich nachwachsende (Sekundär-) Wälder, Savannen, Grasländer oder natürliche Süßwasserökosysteme für eine andere Landnutzung umgewandelt. 2024 wurden jedoch 55 Hektar de- gradierte ehemalige landwirtschaftliche Grünflächen in Forstplan- tagen umgewandelt.', '2026-02-02 23:07:27'),
(1086, 110, 57, 43, '153-107-1', 153, 'Naturschutzfläche innerhalb der Plantagen von LD Celulose Die wichtigste direkte Landnutzungsfläche der Lenzing Gruppe sind die Plantagen in Brasilien (Indianópolis) mit einer Gesamtflä- che von 93.908 Hektar (939,08 km2). Diese Fläche wurde vor meh- reren Jahrzehnten in Agrarflächen umgewandelt. In der Nähe be- finden sich große Flächen, die für den Anbau von Soja und Kaffee oder als Weideflächen für Vieh genutzt werden. Bei den Baumarten innerhalb der Plantage handelt es sich hauptsächlich um Eukalyp- tus. Ein Zucht- und Klonselektionsprogramm wird fortgesetzt, um die Widerstandsfähigkeit und den Ertrag der Bäume weiter zu ver- bessern. LD Celulose verwendet keine gentechnisch veränderten Organismen (GVOs).', '2026-02-02 23:07:27'),
(1087, 112, 57, 43, '153-108-1', 153, 'Naturschutzfläche innerhalb der Plantagen von LD Celulose Die wichtigste direkte Landnutzungsfläche der Lenzing Gruppe sind die Plantagen in Brasilien (Indianópolis) mit einer Gesamtflä- che von 93.908 Hektar (939,08 km2). Diese Fläche wurde vor meh- reren Jahrzehnten in Agrarflächen umgewandelt. In der Nähe be- finden sich große Flächen, die für den Anbau von Soja und Kaffee oder als Weideflächen für Vieh genutzt werden. Bei den Baumarten innerhalb der Plantage handelt es sich hauptsächlich um Eukalyp- tus. Ein Zucht- und Klonselektionsprogramm wird fortgesetzt, um die Widerstandsfähigkeit und den Ertrag der Bäume weiter zu ver- bessern. LD Celulose verwendet keine gentechnisch veränderten Organismen (GVOs).', '2026-02-02 23:07:27'),
(1088, 112, 57, 43, '153-108-2', 153, 'Das brasilianische Umweltrecht schreibt permanente Naturschutz- flächen (Permanent Preservation Areas (APPs)) und gesetzliche Re- servate (Legal Reserve (LR)) vor. Die APPs beinhalten besondere Vegetationsflächen, z. B. Auwälder, sowie Vegetationsflächen an Wasserläufen und Hängen. LR-Flächen müssen mindestens 20 Prozent eines Grundstückes im ländlichen Raum abdecken. Zum jetzigen Zeitpunkt sind 22.980 Hektar des von LD Celulose genutz- ten Landes Naturschutzfläche (Tabelle 42).', '2026-02-02 23:07:27'),
(1089, 113, 57, 43, '153-109-1', 153, 'Das Gebiete mit schutzbedürftiger Biodiversität und das Natur- schutzgebiet Parque Estadual do Páu Furado befindet sich außer- halb der eigenen Naturschutzflächen aber in der Nähe des LD Celulose Anbaugebietes, etwa 30 Kilometer von der LD Celulose- Plantage entfernt. Dieses Naturschutzgebiet ist von den Aktivitäten von LD Celulose nicht betroffen. Die Plantage liegt etwa 800 km vom Amazonas entfernt.', '2026-02-02 23:07:27'),
(1090, 114, 57, 43, '152-110-1', 152, 'Lenzing hat zwar keine quantitativen Ziele in Bezug auf die „Mög- lichen negativen Auswirkungen auf die Biodiversität durch die Ein- führung invasiver nichtheimischer Arten beim Holztransport“, ver- traut aber bei ihrer Lieferkette auf die Ziele ihrer eigenen Holzliefe- ranten und der nationalen Programme. Für die eigenen Forstbe- triebe wurden im Forstbewirtschaftungsplan (Forest Management Plan) von LD Celulose (Brasilien)20 sowie im Aktionsplan für biolo- gische Vielfalt (noch nicht veröffentlicht) von LD Celulose Maßnah- men bestimmt, die zurzeit umgesetzt werden, um so eine Einfüh- rung invasiver gebietsfremder Arten zu verhindern. Die Wirksam- keit dieser Maßnahmen wird mit Blick auf die Beseitigung exoti- scher Bäume in Naturschutzflächen (Erhaltungsflächen) überwacht.', '2026-02-02 23:07:27'),
(1091, 122, 57, 43, '153-112-2', 153, 'Diese Maßnahme adressiert die Auswirkungen auf Ökosystemleis- tungen, den Zustand gefährdeter oder bedrohter Arten in Planta-', '2026-02-02 23:07:27'),
(1092, 124, 57, 43, '153-113-1', 153, 'Naturschutzfläche innerhalb der Plantagen von LD Celulose Die wichtigste direkte Landnutzungsfläche der Lenzing Gruppe sind die Plantagen in Brasilien (Indianópolis) mit einer Gesamtflä- che von 93.908 Hektar (939,08 km2). Diese Fläche wurde vor meh- reren Jahrzehnten in Agrarflächen umgewandelt. In der Nähe be- finden sich große Flächen, die für den Anbau von Soja und Kaffee oder als Weideflächen für Vieh genutzt werden. Bei den Baumarten innerhalb der Plantage handelt es sich hauptsächlich um Eukalyp- tus. Ein Zucht- und Klonselektionsprogramm wird fortgesetzt, um die Widerstandsfähigkeit und den Ertrag der Bäume weiter zu ver- bessern. LD Celulose verwendet keine gentechnisch veränderten Organismen (GVOs).', '2026-02-02 23:07:27'),
(1093, 124, 57, 43, '153-113-2', 153, 'Das brasilianische Umweltrecht schreibt permanente Naturschutz- flächen (Permanent Preservation Areas (APPs)) und gesetzliche Re- servate (Legal Reserve (LR)) vor. Die APPs beinhalten besondere Vegetationsflächen, z. B. Auwälder, sowie Vegetationsflächen an Wasserläufen und Hängen. LR-Flächen müssen mindestens 20 Prozent eines Grundstückes im ländlichen Raum abdecken. Zum jetzigen Zeitpunkt sind 22.980 Hektar des von LD Celulose genutz- ten Landes Naturschutzfläche (Tabelle 42).', '2026-02-02 23:07:27'),
(1094, 129, 57, 43, '151-115-1', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1095, 129, 57, 43, '152-115-2', 152, 'Bei der „Chance durch positive Positionierung mit Best-Practice- Holzbeschaffung aus nachhaltig bewirtschafteten Wäldern und Plantagen“ wurden quantitative Ziele erwogen aber noch nicht', '2026-02-02 23:07:27'),
(1096, 130, 57, 43, '151-116-1', 151, 'Das Ziel „Naturschutzprojekte“ ist nicht mit einer quantitativen Kennzahl verknüpft. Dennoch trägt es zur Bewältigung des „Risikos von Holzknappheit und hohen Holzpreisen aufgrund von Biodiver- sitätsverlusten“, der „Möglichen negativen Auswirkungen auf die', '2026-02-02 23:07:27'),
(1097, 130, 57, 43, '152-116-2', 152, 'Ökosystemleistungen aufgrund der Auswirkungen auf Biodiversi- tät“ und der „Negativen Auswirkungen auf bedrohte Arten im Falle mangelnder Überwachung und Bewirtschaftung“ bei, indem es Projekte zur Erhaltung, zum Schutz der biologischen Vielfalt und zur Wiederherstellung unterstützt. Das Ziel steht im Einklang mit den Zielvorgaben von Lenzings Policy für Biodiversität. Die Ergeb- nisse der zielbezogenen Aktionen werden überwiegend qualitativ und in gewissem Umfang auch quantitativ bewertet. Weitere Infor- mationen über die Projekte finden Sie in den Projektbeschreibun- gen weiter unten in diesem Kapitel.', '2026-02-02 23:07:27'),
(1098, 18, 57, 43, '155-117-1', 155, 'Kennzahlen für die naturbezogene Bewertung – Taskforce on Nature-related Financial Disclosures (TNFD)', '2026-02-02 23:07:27'),
(1099, 18, 57, 43, '155-117-2', 155, 'Die von der TNFD empfohlenen Kennzahlen und Indikatoren wur- den für die Lenzing Gruppe erstmals 2024 bewertet und sind auf der Berichts-Website von Lenzing zu finden. Die Angaben für die gesamte Lenzing Gruppe konzentrieren sich auf die Faktoren, die Veränderungen in Bezug auf die Natur, einschließlich Klimawandel, Änderungen der Landnutzung/Süßwassernutzung, Umweltver- schmutzung und Ressourcennutzung, verursachen. Detailliertere Indikatoren zum Zustand der Natur sind in einer separaten Tabelle zu Lenzings eigenen Forstbetrieben enthalten.', '2026-02-02 23:07:27'),
(1100, 18, 57, 43, '155-117-3', 155, 'Schnittstellen zur Natur wurden an den Produktionsstandorten, in Lenzings eigenen Forstplantagen und bei der Holz- und Zellstoff- beschaffung ermittelt. Die Abhängigkeiten und potenziellen nega- tiven und positiven Auswirkungen wurden ermittelt und bewertet. Der TNFD-Anhang des Nachhaltigkeitsberichts 2024 enthält hauptsächlich naturbezogene Informationen. Klimabezogene In- formationen gemäß TCFD stehen im Klimakapitel des Berichts be- reit und können den sonstigen Angaben in den jeweiligen Kapiteln des Berichts entnommen werden.', '2026-02-02 23:07:27'),
(1101, 19, 57, 43, '155-118-1', 155, 'Kennzahlen für die naturbezogene Bewertung – Taskforce on Nature-related Financial Disclosures (TNFD)', '2026-02-02 23:07:27'),
(1102, 19, 57, 43, '155-118-2', 155, 'Die von der TNFD empfohlenen Kennzahlen und Indikatoren wur- den für die Lenzing Gruppe erstmals 2024 bewertet und sind auf der Berichts-Website von Lenzing zu finden. Die Angaben für die gesamte Lenzing Gruppe konzentrieren sich auf die Faktoren, die Veränderungen in Bezug auf die Natur, einschließlich Klimawandel, Änderungen der Landnutzung/Süßwassernutzung, Umweltver- schmutzung und Ressourcennutzung, verursachen. Detailliertere Indikatoren zum Zustand der Natur sind in einer separaten Tabelle zu Lenzings eigenen Forstbetrieben enthalten.', '2026-02-02 23:07:27'),
(1103, 19, 57, 43, '155-118-3', 155, 'Schnittstellen zur Natur wurden an den Produktionsstandorten, in Lenzings eigenen Forstplantagen und bei der Holz- und Zellstoff- beschaffung ermittelt. Die Abhängigkeiten und potenziellen nega- tiven und positiven Auswirkungen wurden ermittelt und bewertet. Der TNFD-Anhang des Nachhaltigkeitsberichts 2024 enthält hauptsächlich naturbezogene Informationen. Klimabezogene In- formationen gemäß TCFD stehen im Klimakapitel des Berichts be- reit und können den sonstigen Angaben in den jeweiligen Kapiteln des Berichts entnommen werden.', '2026-02-02 23:07:27');
INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(1104, 31, 57, 43, '154-119-1', 154, 'Dexco begann in den 1970er-Jahren mit Forschungsprojekten zur Biodiversität in den bewirtschafteten Gebieten. LD Celulose hat das Monitoring von Flora und Fauna in den eigenen bewirtschaf- teten Gebieten und in Gebieten rund um das Werksgelände durch Partnerschaften mit Universitäten 23 sowie durch interne Pro- gramme fortgesetzt. Diese Programme werden jährlich in der Tro- cken- und Regenzeit durchgeführt und zielen darauf ab, mögliche Auswirkungen auf die regionale Biodiversität zu überwachen. Diese Programme werden auch von der brasilianischen Umweltbe- hörde gefordert.', '2026-02-02 23:07:27'),
(1105, 31, 57, 43, '154-119-2', 154, 'In den Forstwirtschaftsgebieten von LD Celulose gibt es etwa 200 Pflanzen- und 450 Tierarten. Unter diesen Arten sind der Mähnen- wolf und der Große Ameisenbär, die für die Region charakteristisch sind, von besonderer Bedeutung. Seit Beginn dieses konsequenten Monitorings wurde in der Plantage von LD Celulose kein erhebli- cher Artenrückgang verzeichnet (der erste Bericht war im Dezem- ber 2020).', '2026-02-02 23:07:27'),
(1106, 39, 57, 43, '155-120-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1107, 39, 57, 43, '156-120-3', 156, 'nach 2024 fortgesetzt. Das grenzüberschreitende Wassereinzugs- gebiet des Flusses Drin erstreckt sich auf die Länder Albanien, Ko- sovo, Nordmazedonien und Montenegro. In dem Einzugsgebiet liegen große Wald- und Weideflächen sowie Ökosysteme mit gro-ßer biologischer Vielfalt. Zudem ist es mit Blick auf Süßwasseröko- systeme eines der wasserreichsten Gebiete Europas. In den letzten drei Jahrzehnten wurde die Waldfläche in den vier Zielländern ent- lang des Flussbeckens stark ausgebeutet. Daneben ist es durch zu- nehmende illegale Abholzung und die Folgen des Klimawandels bedroht.', '2026-02-02 23:07:27'),
(1108, 39, 57, 43, '156-120-4', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1109, 39, 57, 43, '156-120-5', 156, 'Das Projekt verwendet einen Multi-Stakeholder-Ansatz, der natio- nale und internationale Expert:innen und auch die lokale Bevölke- rung, zentrale und lokale Behörden sowie laufende Initiativen ein- bindet.', '2026-02-02 23:07:27'),
(1110, 49, 57, 43, '155-121-1', 155, 'Kennzahlen für die naturbezogene Bewertung – Taskforce on Nature-related Financial Disclosures (TNFD)', '2026-02-02 23:07:27'),
(1111, 49, 57, 43, '155-121-2', 155, 'Die von der TNFD empfohlenen Kennzahlen und Indikatoren wur- den für die Lenzing Gruppe erstmals 2024 bewertet und sind auf der Berichts-Website von Lenzing zu finden. Die Angaben für die gesamte Lenzing Gruppe konzentrieren sich auf die Faktoren, die Veränderungen in Bezug auf die Natur, einschließlich Klimawandel, Änderungen der Landnutzung/Süßwassernutzung, Umweltver- schmutzung und Ressourcennutzung, verursachen. Detailliertere Indikatoren zum Zustand der Natur sind in einer separaten Tabelle zu Lenzings eigenen Forstbetrieben enthalten.', '2026-02-02 23:07:27'),
(1112, 49, 57, 43, '155-121-3', 155, 'Schnittstellen zur Natur wurden an den Produktionsstandorten, in Lenzings eigenen Forstplantagen und bei der Holz- und Zellstoff- beschaffung ermittelt. Die Abhängigkeiten und potenziellen nega- tiven und positiven Auswirkungen wurden ermittelt und bewertet. Der TNFD-Anhang des Nachhaltigkeitsberichts 2024 enthält hauptsächlich naturbezogene Informationen. Klimabezogene In- formationen gemäß TCFD stehen im Klimakapitel des Berichts be- reit und können den sonstigen Angaben in den jeweiligen Kapiteln des Berichts entnommen werden.', '2026-02-02 23:07:27'),
(1113, 73, 57, 43, '155-122-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1114, 73, 57, 43, '155-122-3', 155, '2024 unterstützte Lenzing die „Business for Nature“-Erklärung für die COP16 im Rahmen des Übereinkommens über die biologische Vielfalt in Kolumbien (Oktober 2024), in der die Verantwortlichen in der Politik dringend aufgefordert wurden, die „ambitionierte Um- setzung des Biodiversitätsplans (Globaler Biodiversitätsrahmen) gemäß dem Kumning-Montreal-Protokoll und den Stopp und die Umkehr des Naturverlusts in diesem Jahrzehnt“ zu unterstützen.24.', '2026-02-02 23:07:27'),
(1115, 73, 57, 43, '155-122-4', 155, 'Lenzing hat sich zum Ziel gesetzt, weitere Maßnahmen zur Walder- haltung, zur Erhaltung der Biodiversität und zur Aufforstung in ge- fährdeten Regionen zu setzen (Ziel „Naturschutzprojekte“). Um dieses Ziel weiter voranzutreiben, hat Lenzing 2022 definiert, wie sie Projekte identifizieren kann, zu denen Lenzing einen Beitrag leisten möchte:', '2026-02-02 23:07:27'),
(1116, 73, 57, 43, '155-122-5', 155, 'Lenzing hat die 2024 identifizierten Projekte mit CDP, Canopy und ÖBf abgestimmt.', '2026-02-02 23:07:27'),
(1117, 73, 57, 43, '156-122-7', 156, 'nach 2024 fortgesetzt. Das grenzüberschreitende Wassereinzugs- gebiet des Flusses Drin erstreckt sich auf die Länder Albanien, Ko- sovo, Nordmazedonien und Montenegro. In dem Einzugsgebiet liegen große Wald- und Weideflächen sowie Ökosysteme mit gro-ßer biologischer Vielfalt. Zudem ist es mit Blick auf Süßwasseröko- systeme eines der wasserreichsten Gebiete Europas. In den letzten drei Jahrzehnten wurde die Waldfläche in den vier Zielländern ent- lang des Flussbeckens stark ausgebeutet. Daneben ist es durch zu- nehmende illegale Abholzung und die Folgen des Klimawandels bedroht.', '2026-02-02 23:07:27'),
(1118, 73, 57, 43, '156-122-8', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1119, 73, 57, 43, '156-122-9', 156, 'Das Projekt verwendet einen Multi-Stakeholder-Ansatz, der natio- nale und internationale Expert:innen und auch die lokale Bevölke- rung, zentrale und lokale Behörden sowie laufende Initiativen ein- bindet.', '2026-02-02 23:07:27'),
(1120, 73, 57, 43, '156-123-1', 156, 'Erfolge im Jahr 2024', '2026-02-02 23:07:27'),
(1121, 73, 57, 43, '156-123-2', 156, 'Erhalt und Förderung von Ökosystemleistungen in Österreich Seit 2023 setzt sich Lenzing aktiv für den Erhalt und die Förderung von Ökosystemleistungen der Wälder von Lenzings Holzlieferanten in Österreich ein. Das hängt mit dem „Risiko von Holzknappheit & hoher Holzpreise“ zusammen, das Lenzing durch eine Zusammen- arbeit mit der Österreichischen Bundesforste AG (ÖBf) bewältigen will. Dadurch sollen vor allem die Ökosystemleistungen der Wälder verbessert werden oder erhalten bleiben. 2023 hat Lenzing bei- spielsweise die Anpflanzung von 200 bienen- und bestäuber- freundlichen Sträuchern entlang eines etwa ein Kilometer langen Waldweges unterstützt. Damit wird dem Rückgang der Bestäube- rinsekten entgegengewirkt, indem ihre Lebensräume wiederher- gestellt werden, die zunehmend durch intensive Landwirtschaft und Pestizideinsatz beeinträchtigt werden.', '2026-02-02 23:07:27'),
(1122, 83, 57, 43, '155-124-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1123, 83, 57, 43, '156-124-3', 156, 'nach 2024 fortgesetzt. Das grenzüberschreitende Wassereinzugs- gebiet des Flusses Drin erstreckt sich auf die Länder Albanien, Ko- sovo, Nordmazedonien und Montenegro. In dem Einzugsgebiet liegen große Wald- und Weideflächen sowie Ökosysteme mit gro-ßer biologischer Vielfalt. Zudem ist es mit Blick auf Süßwasseröko- systeme eines der wasserreichsten Gebiete Europas. In den letzten drei Jahrzehnten wurde die Waldfläche in den vier Zielländern ent- lang des Flussbeckens stark ausgebeutet. Daneben ist es durch zu- nehmende illegale Abholzung und die Folgen des Klimawandels bedroht.', '2026-02-02 23:07:27'),
(1124, 83, 57, 43, '156-124-4', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1125, 83, 57, 43, '156-124-5', 156, 'Das Projekt verwendet einen Multi-Stakeholder-Ansatz, der natio- nale und internationale Expert:innen und auch die lokale Bevölke- rung, zentrale und lokale Behörden sowie laufende Initiativen ein- bindet.', '2026-02-02 23:07:27'),
(1126, 88, 57, 43, '155-125-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1127, 88, 57, 43, '156-125-3', 156, 'nach 2024 fortgesetzt. Das grenzüberschreitende Wassereinzugs- gebiet des Flusses Drin erstreckt sich auf die Länder Albanien, Ko- sovo, Nordmazedonien und Montenegro. In dem Einzugsgebiet liegen große Wald- und Weideflächen sowie Ökosysteme mit gro-ßer biologischer Vielfalt. Zudem ist es mit Blick auf Süßwasseröko- systeme eines der wasserreichsten Gebiete Europas. In den letzten drei Jahrzehnten wurde die Waldfläche in den vier Zielländern ent- lang des Flussbeckens stark ausgebeutet. Daneben ist es durch zu- nehmende illegale Abholzung und die Folgen des Klimawandels bedroht.', '2026-02-02 23:07:27'),
(1128, 88, 57, 43, '156-125-4', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1129, 88, 57, 43, '156-125-5', 156, 'Das Projekt verwendet einen Multi-Stakeholder-Ansatz, der natio- nale und internationale Expert:innen und auch die lokale Bevölke- rung, zentrale und lokale Behörden sowie laufende Initiativen ein- bindet.', '2026-02-02 23:07:27'),
(1130, 88, 57, 43, '156-126-1', 156, 'Erfolge im Jahr 2024', '2026-02-02 23:07:27'),
(1131, 88, 57, 43, '156-126-2', 156, 'Erhalt und Förderung von Ökosystemleistungen in Österreich Seit 2023 setzt sich Lenzing aktiv für den Erhalt und die Förderung von Ökosystemleistungen der Wälder von Lenzings Holzlieferanten in Österreich ein. Das hängt mit dem „Risiko von Holzknappheit & hoher Holzpreise“ zusammen, das Lenzing durch eine Zusammen- arbeit mit der Österreichischen Bundesforste AG (ÖBf) bewältigen will. Dadurch sollen vor allem die Ökosystemleistungen der Wälder verbessert werden oder erhalten bleiben. 2023 hat Lenzing bei- spielsweise die Anpflanzung von 200 bienen- und bestäuber- freundlichen Sträuchern entlang eines etwa ein Kilometer langen Waldweges unterstützt. Damit wird dem Rückgang der Bestäube- rinsekten entgegengewirkt, indem ihre Lebensräume wiederher- gestellt werden, die zunehmend durch intensive Landwirtschaft und Pestizideinsatz beeinträchtigt werden.', '2026-02-02 23:07:27'),
(1132, 89, 57, 43, '155-127-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1133, 89, 57, 43, '156-127-3', 156, 'nach 2024 fortgesetzt. Das grenzüberschreitende Wassereinzugs- gebiet des Flusses Drin erstreckt sich auf die Länder Albanien, Ko- sovo, Nordmazedonien und Montenegro. In dem Einzugsgebiet liegen große Wald- und Weideflächen sowie Ökosysteme mit gro-ßer biologischer Vielfalt. Zudem ist es mit Blick auf Süßwasseröko- systeme eines der wasserreichsten Gebiete Europas. In den letzten drei Jahrzehnten wurde die Waldfläche in den vier Zielländern ent- lang des Flussbeckens stark ausgebeutet. Daneben ist es durch zu- nehmende illegale Abholzung und die Folgen des Klimawandels bedroht.', '2026-02-02 23:07:27'),
(1134, 89, 57, 43, '156-127-4', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1135, 89, 57, 43, '156-127-5', 156, 'Das Projekt verwendet einen Multi-Stakeholder-Ansatz, der natio- nale und internationale Expert:innen und auch die lokale Bevölke- rung, zentrale und lokale Behörden sowie laufende Initiativen ein- bindet.', '2026-02-02 23:07:27'),
(1136, 89, 57, 43, '156-128-1', 156, 'Erfolge im Jahr 2024', '2026-02-02 23:07:27'),
(1137, 89, 57, 43, '156-128-2', 156, 'Erhalt und Förderung von Ökosystemleistungen in Österreich Seit 2023 setzt sich Lenzing aktiv für den Erhalt und die Förderung von Ökosystemleistungen der Wälder von Lenzings Holzlieferanten in Österreich ein. Das hängt mit dem „Risiko von Holzknappheit & hoher Holzpreise“ zusammen, das Lenzing durch eine Zusammen- arbeit mit der Österreichischen Bundesforste AG (ÖBf) bewältigen will. Dadurch sollen vor allem die Ökosystemleistungen der Wälder verbessert werden oder erhalten bleiben. 2023 hat Lenzing bei- spielsweise die Anpflanzung von 200 bienen- und bestäuber- freundlichen Sträuchern entlang eines etwa ein Kilometer langen Waldweges unterstützt. Damit wird dem Rückgang der Bestäube- rinsekten entgegengewirkt, indem ihre Lebensräume wiederher- gestellt werden, die zunehmend durch intensive Landwirtschaft und Pestizideinsatz beeinträchtigt werden.', '2026-02-02 23:07:27'),
(1138, 90, 57, 43, '155-129-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1139, 90, 57, 43, '155-129-3', 155, 'Lenzing hat sich zum Ziel gesetzt, weitere Maßnahmen zur Walder- haltung, zur Erhaltung der Biodiversität und zur Aufforstung in ge- fährdeten Regionen zu setzen (Ziel „Naturschutzprojekte“). Um dieses Ziel weiter voranzutreiben, hat Lenzing 2022 definiert, wie sie Projekte identifizieren kann, zu denen Lenzing einen Beitrag leisten möchte:', '2026-02-02 23:07:27'),
(1140, 90, 57, 43, '156-129-4', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1141, 96, 57, 43, '155-130-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1142, 96, 57, 43, '155-130-3', 155, 'Lenzing hat sich zum Ziel gesetzt, weitere Maßnahmen zur Walder- haltung, zur Erhaltung der Biodiversität und zur Aufforstung in ge- fährdeten Regionen zu setzen (Ziel „Naturschutzprojekte“). Um dieses Ziel weiter voranzutreiben, hat Lenzing 2022 definiert, wie sie Projekte identifizieren kann, zu denen Lenzing einen Beitrag leisten möchte:', '2026-02-02 23:07:27'),
(1143, 96, 57, 43, '156-130-4', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1144, 97, 57, 43, '155-131-1', 155, 'Wiederherstellung und Wiederaufforstung', '2026-02-02 23:07:27'),
(1145, 97, 57, 43, '155-131-3', 155, 'Lenzing hat sich zum Ziel gesetzt, weitere Maßnahmen zur Walder- haltung, zur Erhaltung der Biodiversität und zur Aufforstung in ge- fährdeten Regionen zu setzen (Ziel „Naturschutzprojekte“). Um dieses Ziel weiter voranzutreiben, hat Lenzing 2022 definiert, wie sie Projekte identifizieren kann, zu denen Lenzing einen Beitrag leisten möchte:', '2026-02-02 23:07:27'),
(1146, 97, 57, 43, '156-131-5', 156, 'nach 2024 fortgesetzt. Das grenzüberschreitende Wassereinzugs- gebiet des Flusses Drin erstreckt sich auf die Länder Albanien, Ko- sovo, Nordmazedonien und Montenegro. In dem Einzugsgebiet liegen große Wald- und Weideflächen sowie Ökosysteme mit gro-ßer biologischer Vielfalt. Zudem ist es mit Blick auf Süßwasseröko- systeme eines der wasserreichsten Gebiete Europas. In den letzten drei Jahrzehnten wurde die Waldfläche in den vier Zielländern ent- lang des Flussbeckens stark ausgebeutet. Daneben ist es durch zu- nehmende illegale Abholzung und die Folgen des Klimawandels bedroht.', '2026-02-02 23:07:27'),
(1147, 97, 57, 43, '156-131-6', 156, 'Langfristig soll durch das Projekt ein Beitrag zum Klimaschutz und zur nachhaltigen Entwicklung entlang des Drin durch integrierte Waldbewirtschaftung (integrated forest management, IFM) geleis- tet werden. Geplant sind die Aufforstung von 45 Hektar degradier- ter Flächen und die Wiederherstellung weiterer 75 Hektar in dem Gebiet. Hierfür sollen unter anderem 110.000 Bäume gepflanzt werden. Durch die beschlossenen Maßnahmen werden die Le- bensbedingungen der ländlichen Gemeinden in den Zielgebieten durch bessere Ökosystemleistungen verbessert.', '2026-02-02 23:07:27'),
(1148, 104, 57, 43, '155-132-1', 155, 'Kennzahlen für die naturbezogene Bewertung – Taskforce on Nature-related Financial Disclosures (TNFD)', '2026-02-02 23:07:27'),
(1149, 104, 57, 43, '155-132-2', 155, 'Die von der TNFD empfohlenen Kennzahlen und Indikatoren wur- den für die Lenzing Gruppe erstmals 2024 bewertet und sind auf der Berichts-Website von Lenzing zu finden. Die Angaben für die gesamte Lenzing Gruppe konzentrieren sich auf die Faktoren, die Veränderungen in Bezug auf die Natur, einschließlich Klimawandel, Änderungen der Landnutzung/Süßwassernutzung, Umweltver- schmutzung und Ressourcennutzung, verursachen. Detailliertere Indikatoren zum Zustand der Natur sind in einer separaten Tabelle zu Lenzings eigenen Forstbetrieben enthalten.', '2026-02-02 23:07:27'),
(1150, 104, 57, 43, '155-132-3', 155, 'Schnittstellen zur Natur wurden an den Produktionsstandorten, in Lenzings eigenen Forstplantagen und bei der Holz- und Zellstoff- beschaffung ermittelt. Die Abhängigkeiten und potenziellen nega- tiven und positiven Auswirkungen wurden ermittelt und bewertet. Der TNFD-Anhang des Nachhaltigkeitsberichts 2024 enthält hauptsächlich naturbezogene Informationen. Klimabezogene In- formationen gemäß TCFD stehen im Klimakapitel des Berichts be- reit und können den sonstigen Angaben in den jeweiligen Kapiteln des Berichts entnommen werden.', '2026-02-02 23:07:27'),
(1151, 117, 57, 43, '155-133-1', 155, 'Kennzahlen für die naturbezogene Bewertung – Taskforce on Nature-related Financial Disclosures (TNFD)', '2026-02-02 23:07:27'),
(1152, 117, 57, 43, '155-133-2', 155, 'Die von der TNFD empfohlenen Kennzahlen und Indikatoren wur- den für die Lenzing Gruppe erstmals 2024 bewertet und sind auf der Berichts-Website von Lenzing zu finden. Die Angaben für die gesamte Lenzing Gruppe konzentrieren sich auf die Faktoren, die Veränderungen in Bezug auf die Natur, einschließlich Klimawandel, Änderungen der Landnutzung/Süßwassernutzung, Umweltver- schmutzung und Ressourcennutzung, verursachen. Detailliertere Indikatoren zum Zustand der Natur sind in einer separaten Tabelle zu Lenzings eigenen Forstbetrieben enthalten.', '2026-02-02 23:07:27'),
(1153, 117, 57, 43, '155-133-3', 155, 'Schnittstellen zur Natur wurden an den Produktionsstandorten, in Lenzings eigenen Forstplantagen und bei der Holz- und Zellstoff- beschaffung ermittelt. Die Abhängigkeiten und potenziellen nega- tiven und positiven Auswirkungen wurden ermittelt und bewertet. Der TNFD-Anhang des Nachhaltigkeitsberichts 2024 enthält hauptsächlich naturbezogene Informationen. Klimabezogene In- formationen gemäß TCFD stehen im Klimakapitel des Berichts be- reit und können den sonstigen Angaben in den jeweiligen Kapiteln des Berichts entnommen werden.', '2026-02-02 23:07:27'),
(1154, 126, 57, 43, '154-134-1', 154, 'Dexco begann in den 1970er-Jahren mit Forschungsprojekten zur Biodiversität in den bewirtschafteten Gebieten. LD Celulose hat das Monitoring von Flora und Fauna in den eigenen bewirtschaf- teten Gebieten und in Gebieten rund um das Werksgelände durch Partnerschaften mit Universitäten 23 sowie durch interne Pro- gramme fortgesetzt. Diese Programme werden jährlich in der Tro- cken- und Regenzeit durchgeführt und zielen darauf ab, mögliche Auswirkungen auf die regionale Biodiversität zu überwachen. Diese Programme werden auch von der brasilianischen Umweltbe- hörde gefordert.', '2026-02-02 23:07:27'),
(1155, 126, 57, 43, '154-134-2', 154, 'In den Forstwirtschaftsgebieten von LD Celulose gibt es etwa 200 Pflanzen- und 450 Tierarten. Unter diesen Arten sind der Mähnen- wolf und der Große Ameisenbär, die für die Region charakteristisch sind, von besonderer Bedeutung. Seit Beginn dieses konsequenten Monitorings wurde in der Plantage von LD Celulose kein erhebli- cher Artenrückgang verzeichnet (der erste Bericht war im Dezem- ber 2020).', '2026-02-02 23:07:27'),
(1156, 130, 57, 43, '155-135-1', 155, 'Kennzahlen für die naturbezogene Bewertung – Taskforce on Nature-related Financial Disclosures (TNFD)', '2026-02-02 23:07:27'),
(1157, 130, 57, 43, '155-135-2', 155, 'Die von der TNFD empfohlenen Kennzahlen und Indikatoren wur- den für die Lenzing Gruppe erstmals 2024 bewertet und sind auf der Berichts-Website von Lenzing zu finden. Die Angaben für die gesamte Lenzing Gruppe konzentrieren sich auf die Faktoren, die Veränderungen in Bezug auf die Natur, einschließlich Klimawandel, Änderungen der Landnutzung/Süßwassernutzung, Umweltver- schmutzung und Ressourcennutzung, verursachen. Detailliertere Indikatoren zum Zustand der Natur sind in einer separaten Tabelle zu Lenzings eigenen Forstbetrieben enthalten.', '2026-02-02 23:07:27'),
(1158, 130, 57, 43, '155-135-3', 155, 'Schnittstellen zur Natur wurden an den Produktionsstandorten, in Lenzings eigenen Forstplantagen und bei der Holz- und Zellstoff- beschaffung ermittelt. Die Abhängigkeiten und potenziellen nega- tiven und positiven Auswirkungen wurden ermittelt und bewertet. Der TNFD-Anhang des Nachhaltigkeitsberichts 2024 enthält hauptsächlich naturbezogene Informationen. Klimabezogene In- formationen gemäß TCFD stehen im Klimakapitel des Berichts be- reit und können den sonstigen Angaben in den jeweiligen Kapiteln des Berichts entnommen werden.', '2026-02-02 23:07:27'),
(1159, 18, 57, 43, '157-136-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1160, 19, 57, 43, '157-137-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1161, 25, 57, 43, '157-138-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1162, 26, 57, 43, '157-139-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1163, 31, 57, 43, '156-140-1', 156, '2024 haben sich Lenzing und die ÖBf auf einen Aktionsplan für das Engagement zum Schutz und Erhalt der Torfmoore im Ausseerland in der Steiermark (Österreich) geeinigt. Im Herbst 2024 wurde mit den Maßnahmen begonnen. Feuchtwiesen mit ihrer außerge- wöhnlich hohen biologischen Vielfalt und Amphibienteiche wer- den wiederhergestellt.', '2026-02-02 23:07:27'),
(1164, 31, 57, 43, '157-140-2', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1165, 33, 57, 43, '156-141-1', 156, '2024 haben sich Lenzing und die ÖBf auf einen Aktionsplan für das Engagement zum Schutz und Erhalt der Torfmoore im Ausseerland in der Steiermark (Österreich) geeinigt. Im Herbst 2024 wurde mit den Maßnahmen begonnen. Feuchtwiesen mit ihrer außerge- wöhnlich hohen biologischen Vielfalt und Amphibienteiche wer- den wiederhergestellt.', '2026-02-02 23:07:27'),
(1166, 33, 57, 43, '157-141-2', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1167, 39, 57, 43, '157-142-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1168, 39, 57, 43, '157-142-2', 157, 'Morgan Stanley Capital International (MSCI) Lenzing wurde 2023 von MSCI mit einem „AA“-Rating ausgezeich- net. Im Rahmen seiner Verantwortung hat das Unternehmen die Einsparungen aus den MSCI/Green Bonds für Walderhaltungspro- jekte gemeinnütziger Organisationen gespendet. 2024 erhielt Lenzing das niedrigere „A“-Rating. Grund hierfür war nicht eine schlechtere Nachhaltigkeitsleistung sondern eine Neueinstufung in eine andere Industriesparte für Vergleichszwecke.', '2026-02-02 23:07:27'),
(1169, 39, 57, 43, '157-142-3', 157, 'Lenzing hat beschlossen, gemeinsam mit ICEP/SAT Sustainable Agriculture Tanzania und Caritas Steiermark/ODAG- Caritas Gitega/Burundi/Universität von Burundi zwei separate Projekte zu finanzieren:', '2026-02-02 23:07:27'),
(1170, 39, 57, 43, '158-142-5', 158, 'Fashion Forest Afforestation Project Lenzing Fiber (Shanghai) Co., Ltd. (LFS) arbeitet zusammen mit dem China National Textile and Apparel Council (CNTAC) und der China Green Carbon Foundation (CGCF) am Fashion Forest – Ecologic Carbon Neutral Forest Projekt im Suochong Village, Sangdui Township im Kreis Daocheng in der Provinz Sichuan. Bei dem Projekt wird die Aufforstung mit heimischen Fichten erforscht, um die Wiederherstellung eines hoch gelegenen Wald-Ökosys- tems zu demonstrieren. Die Aufforstungsarbeiten werden vom Fo- restry and Grassland Bureau des Kreises Daocheng in der Tibeti- schen Autonomen Präfektur Ganzi ausgeführt und Lenzing stellt ei- nen Teil der notwendigen finanziellen Mittel bereit. Das Projekt soll nach dem offiziellen Start 2025 vier Jahre dauern. Im Berichtszeit- raum 2024 fand eine Auftaktveranstaltung statt.', '2026-02-02 23:07:27'),
(1171, 39, 57, 43, '158-142-7', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:27'),
(1172, 42, 57, 43, '156-143-1', 156, '2024 haben sich Lenzing und die ÖBf auf einen Aktionsplan für das Engagement zum Schutz und Erhalt der Torfmoore im Ausseerland in der Steiermark (Österreich) geeinigt. Im Herbst 2024 wurde mit den Maßnahmen begonnen. Feuchtwiesen mit ihrer außerge- wöhnlich hohen biologischen Vielfalt und Amphibienteiche wer- den wiederhergestellt.', '2026-02-02 23:07:27'),
(1173, 42, 57, 43, '156-143-2', 156, 'Albanien und Westbalkan/Drin-Flusstal Von 2019 bis 2024 wurde ein Walderhaltungs- und Social-Impact- Projekt in Albanien unter Leitung der österreichischen Entwick- lungsorganisation ICEP umgesetzt, das von der ADA (Austrian De- velopment Agency) und der Lenzing Gruppe finanziert wurde. Das ursprüngliche Ziel war die Entwicklung ländlicher Regionen in Al- banien in der Großregion Shkodёr (Ana e Malit) und Dibёr (Pesh- kopi) durch nachhaltigen Einsatz natürlicher Ressourcen, unter an- derem durch Maßnahmen zum Naturschutz in einem Gebiet von 20 Hektar sowie Schulungen und Social-Impact-Programme.', '2026-02-02 23:07:27'),
(1174, 42, 57, 43, '157-143-3', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1175, 42, 57, 43, '158-143-7', 158, 'Fashion Forest Afforestation Project Lenzing Fiber (Shanghai) Co., Ltd. (LFS) arbeitet zusammen mit dem China National Textile and Apparel Council (CNTAC) und der China Green Carbon Foundation (CGCF) am Fashion Forest – Ecologic Carbon Neutral Forest Projekt im Suochong Village, Sangdui Township im Kreis Daocheng in der Provinz Sichuan. Bei dem Projekt wird die Aufforstung mit heimischen Fichten erforscht, um die Wiederherstellung eines hoch gelegenen Wald-Ökosys- tems zu demonstrieren. Die Aufforstungsarbeiten werden vom Fo- restry and Grassland Bureau des Kreises Daocheng in der Tibeti- schen Autonomen Präfektur Ganzi ausgeführt und Lenzing stellt ei- nen Teil der notwendigen finanziellen Mittel bereit. Das Projekt soll nach dem offiziellen Start 2025 vier Jahre dauern. Im Berichtszeit- raum 2024 fand eine Auftaktveranstaltung statt.', '2026-02-02 23:07:27'),
(1176, 42, 57, 43, '158-143-9', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:27'),
(1177, 49, 57, 43, '157-144-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1178, 54, 57, 43, '156-145-1', 156, '2024 haben sich Lenzing und die ÖBf auf einen Aktionsplan für das Engagement zum Schutz und Erhalt der Torfmoore im Ausseerland in der Steiermark (Österreich) geeinigt. Im Herbst 2024 wurde mit den Maßnahmen begonnen. Feuchtwiesen mit ihrer außerge- wöhnlich hohen biologischen Vielfalt und Amphibienteiche wer- den wiederhergestellt.', '2026-02-02 23:07:27'),
(1179, 54, 57, 43, '156-145-2', 156, 'Albanien und Westbalkan/Drin-Flusstal Von 2019 bis 2024 wurde ein Walderhaltungs- und Social-Impact- Projekt in Albanien unter Leitung der österreichischen Entwick- lungsorganisation ICEP umgesetzt, das von der ADA (Austrian De- velopment Agency) und der Lenzing Gruppe finanziert wurde. Das ursprüngliche Ziel war die Entwicklung ländlicher Regionen in Al- banien in der Großregion Shkodёr (Ana e Malit) und Dibёr (Pesh- kopi) durch nachhaltigen Einsatz natürlicher Ressourcen, unter an- derem durch Maßnahmen zum Naturschutz in einem Gebiet von 20 Hektar sowie Schulungen und Social-Impact-Programme.', '2026-02-02 23:07:27'),
(1180, 54, 57, 43, '157-145-3', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1181, 54, 57, 43, '158-145-7', 158, 'Fashion Forest Afforestation Project Lenzing Fiber (Shanghai) Co., Ltd. (LFS) arbeitet zusammen mit dem China National Textile and Apparel Council (CNTAC) und der China Green Carbon Foundation (CGCF) am Fashion Forest – Ecologic Carbon Neutral Forest Projekt im Suochong Village, Sangdui Township im Kreis Daocheng in der Provinz Sichuan. Bei dem Projekt wird die Aufforstung mit heimischen Fichten erforscht, um die Wiederherstellung eines hoch gelegenen Wald-Ökosys- tems zu demonstrieren. Die Aufforstungsarbeiten werden vom Fo- restry and Grassland Bureau des Kreises Daocheng in der Tibeti- schen Autonomen Präfektur Ganzi ausgeführt und Lenzing stellt ei- nen Teil der notwendigen finanziellen Mittel bereit. Das Projekt soll nach dem offiziellen Start 2025 vier Jahre dauern. Im Berichtszeit- raum 2024 fand eine Auftaktveranstaltung statt.', '2026-02-02 23:07:27'),
(1182, 57, 57, 43, '157-146-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1183, 57, 57, 43, '158-146-3', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:27'),
(1184, 58, 57, 43, '157-147-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1185, 58, 57, 43, '158-147-4', 158, 'Die Umsetzung des Projekts trägt dazu bei, dass die lokalen Öko- systeme und Gemeinschaften sich besser an den Klimawandel an- passen können, indem es die Bevölkerung für Naturschutz sensibi- lisiert und ihnen mehr Beschäftigungsmöglichkeiten in der Forst- wirtschaft und der Walderhaltung bietet, sowie ihre Fähigkeiten in diesen Bereichen stärkt.', '2026-02-02 23:07:27'),
(1186, 59, 57, 43, '157-148-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1187, 61, 57, 43, '156-149-1', 156, 'Klimaschutz-, Waldschutz- und Aufforstungsprojekte in Verbindung mit Fasermarken im Jahr 2024 Lenzing hat unter dem Markennamen TENCEL™ und VEOCEL™ weitere Lyocell- und Modalfasern mit verringertem CO2- Fußabdruck für Anwendungen in der Textil- und Vliesstoffindustrie eingeführt. Basierend auf dem Konzept „Reduzieren – Engagieren – Ausgleichen“ hat sich Lenzing auf niedrige THG-Emissionen durch verschiedene Reduktionsmaßnahmen konzentriert und die restlichen THG-Emissionen dieser Fasern durch Kohlenstoffkom- pensationsprojekte ausgeglichen. Die neuen Fasern sind von Cli- matePartner nach dem Greenhouse Gas Protocol zertifiziert – dem weltweit führenden Rahmenwerk zur Messung von THG- Emissionen. Alle ausgewählten und unterstützten Klima- und Waldschutz- sowie Aufforstungsprojekte sind nach dem Gold Standard VER oder Verified Carbon Standard zertifiziert.', '2026-02-02 23:07:27'),
(1188, 61, 57, 43, '157-149-2', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1189, 61, 57, 43, '158-149-4', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:27'),
(1190, 62, 57, 43, '157-150-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1191, 62, 57, 43, '158-150-3', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:27'),
(1192, 64, 57, 43, '156-151-1', 156, 'Klimaschutz-, Waldschutz- und Aufforstungsprojekte in Verbindung mit Fasermarken im Jahr 2024 Lenzing hat unter dem Markennamen TENCEL™ und VEOCEL™ weitere Lyocell- und Modalfasern mit verringertem CO2- Fußabdruck für Anwendungen in der Textil- und Vliesstoffindustrie eingeführt. Basierend auf dem Konzept „Reduzieren – Engagieren – Ausgleichen“ hat sich Lenzing auf niedrige THG-Emissionen durch verschiedene Reduktionsmaßnahmen konzentriert und die restlichen THG-Emissionen dieser Fasern durch Kohlenstoffkom- pensationsprojekte ausgeglichen. Die neuen Fasern sind von Cli- matePartner nach dem Greenhouse Gas Protocol zertifiziert – dem weltweit führenden Rahmenwerk zur Messung von THG- Emissionen. Alle ausgewählten und unterstützten Klima- und Waldschutz- sowie Aufforstungsprojekte sind nach dem Gold Standard VER oder Verified Carbon Standard zertifiziert.', '2026-02-02 23:07:27'),
(1193, 64, 57, 43, '157-151-2', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1194, 64, 57, 43, '158-151-4', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:27'),
(1195, 65, 57, 43, '157-152-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1196, 65, 57, 43, '158-152-4', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:27'),
(1197, 67, 57, 43, '156-153-1', 156, 'Klimaschutz-, Waldschutz- und Aufforstungsprojekte in Verbindung mit Fasermarken im Jahr 2024 Lenzing hat unter dem Markennamen TENCEL™ und VEOCEL™ weitere Lyocell- und Modalfasern mit verringertem CO2- Fußabdruck für Anwendungen in der Textil- und Vliesstoffindustrie eingeführt. Basierend auf dem Konzept „Reduzieren – Engagieren – Ausgleichen“ hat sich Lenzing auf niedrige THG-Emissionen durch verschiedene Reduktionsmaßnahmen konzentriert und die restlichen THG-Emissionen dieser Fasern durch Kohlenstoffkom- pensationsprojekte ausgeglichen. Die neuen Fasern sind von Cli- matePartner nach dem Greenhouse Gas Protocol zertifiziert – dem weltweit führenden Rahmenwerk zur Messung von THG- Emissionen. Alle ausgewählten und unterstützten Klima- und Waldschutz- sowie Aufforstungsprojekte sind nach dem Gold Standard VER oder Verified Carbon Standard zertifiziert.', '2026-02-02 23:07:27'),
(1198, 69, 57, 43, '156-154-1', 156, '2024 haben sich Lenzing und die ÖBf auf einen Aktionsplan für das Engagement zum Schutz und Erhalt der Torfmoore im Ausseerland in der Steiermark (Österreich) geeinigt. Im Herbst 2024 wurde mit den Maßnahmen begonnen. Feuchtwiesen mit ihrer außerge- wöhnlich hohen biologischen Vielfalt und Amphibienteiche wer- den wiederhergestellt.', '2026-02-02 23:07:27'),
(1199, 69, 57, 43, '157-154-2', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1200, 70, 57, 43, '157-155-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1201, 72, 57, 43, '156-156-1', 156, 'Albanien und Westbalkan/Drin-Flusstal Von 2019 bis 2024 wurde ein Walderhaltungs- und Social-Impact- Projekt in Albanien unter Leitung der österreichischen Entwick- lungsorganisation ICEP umgesetzt, das von der ADA (Austrian De- velopment Agency) und der Lenzing Gruppe finanziert wurde. Das ursprüngliche Ziel war die Entwicklung ländlicher Regionen in Al- banien in der Großregion Shkodёr (Ana e Malit) und Dibёr (Pesh- kopi) durch nachhaltigen Einsatz natürlicher Ressourcen, unter an- derem durch Maßnahmen zum Naturschutz in einem Gebiet von 20 Hektar sowie Schulungen und Social-Impact-Programme.', '2026-02-02 23:07:27'),
(1202, 72, 57, 43, '157-156-2', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1203, 72, 57, 43, '158-156-5', 158, 'Fashion Forest Afforestation Project Lenzing Fiber (Shanghai) Co., Ltd. (LFS) arbeitet zusammen mit dem China National Textile and Apparel Council (CNTAC) und der China Green Carbon Foundation (CGCF) am Fashion Forest – Ecologic Carbon Neutral Forest Projekt im Suochong Village, Sangdui Township im Kreis Daocheng in der Provinz Sichuan. Bei dem Projekt wird die Aufforstung mit heimischen Fichten erforscht, um die Wiederherstellung eines hoch gelegenen Wald-Ökosys- tems zu demonstrieren. Die Aufforstungsarbeiten werden vom Fo- restry and Grassland Bureau des Kreises Daocheng in der Tibeti- schen Autonomen Präfektur Ganzi ausgeführt und Lenzing stellt ei- nen Teil der notwendigen finanziellen Mittel bereit. Das Projekt soll nach dem offiziellen Start 2025 vier Jahre dauern. Im Berichtszeit- raum 2024 fand eine Auftaktveranstaltung statt.', '2026-02-02 23:07:27'),
(1204, 82, 57, 43, '157-157-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1205, 83, 57, 43, '157-158-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:27'),
(1206, 83, 57, 43, '157-158-2', 157, 'Lenzing hat beschlossen, gemeinsam mit ICEP/SAT Sustainable Agriculture Tanzania und Caritas Steiermark/ODAG- Caritas Gitega/Burundi/Universität von Burundi zwei separate Projekte zu finanzieren:', '2026-02-02 23:07:27'),
(1207, 83, 57, 43, '158-158-5', 158, 'Fashion Forest Afforestation Project Lenzing Fiber (Shanghai) Co., Ltd. (LFS) arbeitet zusammen mit dem China National Textile and Apparel Council (CNTAC) und der China Green Carbon Foundation (CGCF) am Fashion Forest – Ecologic Carbon Neutral Forest Projekt im Suochong Village, Sangdui Township im Kreis Daocheng in der Provinz Sichuan. Bei dem Projekt wird die Aufforstung mit heimischen Fichten erforscht, um die Wiederherstellung eines hoch gelegenen Wald-Ökosys- tems zu demonstrieren. Die Aufforstungsarbeiten werden vom Fo- restry and Grassland Bureau des Kreises Daocheng in der Tibeti- schen Autonomen Präfektur Ganzi ausgeführt und Lenzing stellt ei- nen Teil der notwendigen finanziellen Mittel bereit. Das Projekt soll nach dem offiziellen Start 2025 vier Jahre dauern. Im Berichtszeit- raum 2024 fand eine Auftaktveranstaltung statt.', '2026-02-02 23:07:27'),
(1208, 83, 57, 43, '158-158-6', 158, 'Die Umsetzung des Projekts trägt dazu bei, dass die lokalen Öko- systeme und Gemeinschaften sich besser an den Klimawandel an- passen können, indem es die Bevölkerung für Naturschutz sensibi- lisiert und ihnen mehr Beschäftigungsmöglichkeiten in der Forst- wirtschaft und der Walderhaltung bietet, sowie ihre Fähigkeiten in diesen Bereichen stärkt.', '2026-02-02 23:07:27'),
(1209, 88, 57, 43, '156-159-1', 156, '2024 haben sich Lenzing und die ÖBf auf einen Aktionsplan für das Engagement zum Schutz und Erhalt der Torfmoore im Ausseerland in der Steiermark (Österreich) geeinigt. Im Herbst 2024 wurde mit den Maßnahmen begonnen. Feuchtwiesen mit ihrer außerge- wöhnlich hohen biologischen Vielfalt und Amphibienteiche wer- den wiederhergestellt.', '2026-02-02 23:07:28'),
(1210, 88, 57, 43, '156-159-2', 156, 'Albanien und Westbalkan/Drin-Flusstal Von 2019 bis 2024 wurde ein Walderhaltungs- und Social-Impact- Projekt in Albanien unter Leitung der österreichischen Entwick- lungsorganisation ICEP umgesetzt, das von der ADA (Austrian De- velopment Agency) und der Lenzing Gruppe finanziert wurde. Das ursprüngliche Ziel war die Entwicklung ländlicher Regionen in Al- banien in der Großregion Shkodёr (Ana e Malit) und Dibёr (Pesh- kopi) durch nachhaltigen Einsatz natürlicher Ressourcen, unter an- derem durch Maßnahmen zum Naturschutz in einem Gebiet von 20 Hektar sowie Schulungen und Social-Impact-Programme.', '2026-02-02 23:07:28'),
(1211, 88, 57, 43, '157-159-3', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:28'),
(1212, 88, 57, 43, '157-159-4', 157, 'Lenzing hat beschlossen, gemeinsam mit ICEP/SAT Sustainable Agriculture Tanzania und Caritas Steiermark/ODAG- Caritas Gitega/Burundi/Universität von Burundi zwei separate Projekte zu finanzieren:', '2026-02-02 23:07:28'),
(1213, 88, 57, 43, '158-159-6', 158, 'Fashion Forest Afforestation Project Lenzing Fiber (Shanghai) Co., Ltd. (LFS) arbeitet zusammen mit dem China National Textile and Apparel Council (CNTAC) und der China Green Carbon Foundation (CGCF) am Fashion Forest – Ecologic Carbon Neutral Forest Projekt im Suochong Village, Sangdui Township im Kreis Daocheng in der Provinz Sichuan. Bei dem Projekt wird die Aufforstung mit heimischen Fichten erforscht, um die Wiederherstellung eines hoch gelegenen Wald-Ökosys- tems zu demonstrieren. Die Aufforstungsarbeiten werden vom Fo- restry and Grassland Bureau des Kreises Daocheng in der Tibeti- schen Autonomen Präfektur Ganzi ausgeführt und Lenzing stellt ei- nen Teil der notwendigen finanziellen Mittel bereit. Das Projekt soll nach dem offiziellen Start 2025 vier Jahre dauern. Im Berichtszeit- raum 2024 fand eine Auftaktveranstaltung statt.', '2026-02-02 23:07:28');
INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(1214, 88, 57, 43, '158-159-8', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:28'),
(1215, 89, 57, 43, '156-160-1', 156, '2024 haben sich Lenzing und die ÖBf auf einen Aktionsplan für das Engagement zum Schutz und Erhalt der Torfmoore im Ausseerland in der Steiermark (Österreich) geeinigt. Im Herbst 2024 wurde mit den Maßnahmen begonnen. Feuchtwiesen mit ihrer außerge- wöhnlich hohen biologischen Vielfalt und Amphibienteiche wer- den wiederhergestellt.', '2026-02-02 23:07:28'),
(1216, 89, 57, 43, '156-160-2', 156, 'Albanien und Westbalkan/Drin-Flusstal Von 2019 bis 2024 wurde ein Walderhaltungs- und Social-Impact- Projekt in Albanien unter Leitung der österreichischen Entwick- lungsorganisation ICEP umgesetzt, das von der ADA (Austrian De- velopment Agency) und der Lenzing Gruppe finanziert wurde. Das ursprüngliche Ziel war die Entwicklung ländlicher Regionen in Al- banien in der Großregion Shkodёr (Ana e Malit) und Dibёr (Pesh- kopi) durch nachhaltigen Einsatz natürlicher Ressourcen, unter an- derem durch Maßnahmen zum Naturschutz in einem Gebiet von 20 Hektar sowie Schulungen und Social-Impact-Programme.', '2026-02-02 23:07:28'),
(1217, 89, 57, 43, '157-160-3', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:28'),
(1218, 89, 57, 43, '157-160-4', 157, 'Lenzing hat beschlossen, gemeinsam mit ICEP/SAT Sustainable Agriculture Tanzania und Caritas Steiermark/ODAG- Caritas Gitega/Burundi/Universität von Burundi zwei separate Projekte zu finanzieren:', '2026-02-02 23:07:28'),
(1219, 89, 57, 43, '158-160-7', 158, 'Fashion Forest Afforestation Project Lenzing Fiber (Shanghai) Co., Ltd. (LFS) arbeitet zusammen mit dem China National Textile and Apparel Council (CNTAC) und der China Green Carbon Foundation (CGCF) am Fashion Forest – Ecologic Carbon Neutral Forest Projekt im Suochong Village, Sangdui Township im Kreis Daocheng in der Provinz Sichuan. Bei dem Projekt wird die Aufforstung mit heimischen Fichten erforscht, um die Wiederherstellung eines hoch gelegenen Wald-Ökosys- tems zu demonstrieren. Die Aufforstungsarbeiten werden vom Fo- restry and Grassland Bureau des Kreises Daocheng in der Tibeti- schen Autonomen Präfektur Ganzi ausgeführt und Lenzing stellt ei- nen Teil der notwendigen finanziellen Mittel bereit. Das Projekt soll nach dem offiziellen Start 2025 vier Jahre dauern. Im Berichtszeit- raum 2024 fand eine Auftaktveranstaltung statt.', '2026-02-02 23:07:28'),
(1220, 89, 57, 43, '158-160-9', 158, 'Biodiversität und multifunktionale Bewirtschaftung im Wald (BIMUWA) Im Rahmen eines öffentlich geförderten Forschungsprojektes „Bio- diversität im Wald“ (BIMUWA29) wurden unter anderem konkrete Maßnahmen zum Schutz gefährdeter Arten und zur Steigerung der Biodiversität unter lokalen Bedingungen der PEFC-Region 6 (in den österreichi- schen Bundesländern Steiermark und Kärnten) entwickelt, die in die tägliche Waldbewirtschaftung integriert werden. Die ÖBf arbei- ten in Bezug auf dieses Thema auch mit dem Umweltdachverband zusammen. Da die Maßnahmen sehr konkret und dabei relativ leicht umsetzbar sind, sind die positiven Effekte auf große Waldflä- chen skalierbar. Lenzing unterstützte 2023 den Roll-out der Ergeb- nisse für die interessierten privaten Waldbesitzer in der Region. 2024 beteiligte sich Lenzing an der Verbreitung der Ergebnisse und sprach mit Stakeholdern über Optionen für Follow-up-Maßnah- men.', '2026-02-02 23:07:28'),
(1221, 130, 57, 43, '157-161-1', 157, 'Einbeziehung von Stakeholdern bei biologischer Vielfalt und Ökosystemen', '2026-02-02 23:07:28'),
(1340, 18, 61, 46, '150-1-1', 150, 'focus on water and nutrient management on', '2026-02-03 00:39:00'),
(1341, 18, 61, 46, '150-1-2', 150, 'assessment (ESIA) performed in Siilinjärvi to cover', '2026-02-03 00:39:00'),
(1342, 18, 61, 46, '150-1-3', 150, 'The biodiversity impact drivers assessed to be', '2026-02-03 00:39:00'),
(1343, 18, 61, 46, '150-1-4', 150, 'farms. Furthermore, our steering system guides', '2026-02-03 00:39:00'),
(1344, 18, 61, 46, '150-1-5', 150, 'most material to Yara and its value chain are:', '2026-02-03 00:39:00'),
(1345, 18, 61, 46, '150-1-6', 150, 'local operations to cover more specific aspects', '2026-02-03 00:39:00'),
(1346, 52, 61, 46, '150-2-1', 150, 'on local impacts, risk and opportunities. For more', '2026-02-03 00:39:00'),
(1347, 52, 61, 46, '150-2-2', 150, 'information on the HESQ Policy, see page 131.', '2026-02-03 00:39:00'),
(1348, 52, 61, 46, '150-2-3', 150, 'The active mining operation in Siilinjärvi is subject', '2026-02-03 00:39:00'),
(1349, 54, 61, 46, '150-3-1', 150, 'on local impacts, risk and opportunities. For more', '2026-02-03 00:39:00'),
(1350, 54, 61, 46, '150-3-2', 150, 'information on the HESQ Policy, see page 131.', '2026-02-03 00:39:00'),
(1351, 54, 61, 46, '150-3-3', 150, 'The active mining operation in Siilinjärvi is subject', '2026-02-03 00:39:00'),
(1352, 59, 61, 46, '150-4-1', 150, 'and dependencies on nature and biodiversity.', '2026-02-03 00:39:00'),
(1353, 59, 61, 46, '150-4-2', 150, 'It covers pollution, resource use with specific', '2026-02-03 00:39:00'),
(1354, 59, 61, 46, '150-4-3', 150, 'policy to address deforestation. Instead, our policy', '2026-02-03 00:39:00'),
(1355, 59, 61, 46, '150-4-4', 150, 'has a broader approach to reducing harm to the', '2026-02-03 00:39:00'),
(1356, 59, 61, 46, '150-4-5', 150, 'environment, and each site takes actions based', '2026-02-03 00:39:00'),
(1357, 72, 61, 46, '150-5-1', 150, 'and dependencies on nature and biodiversity.', '2026-02-03 00:39:00'),
(1358, 72, 61, 46, '150-5-2', 150, 'It covers pollution, resource use with specific', '2026-02-03 00:39:00'),
(1359, 72, 61, 46, '150-5-3', 150, 'policy to address deforestation. Instead, our policy', '2026-02-03 00:39:00'),
(1360, 72, 61, 46, '150-5-4', 150, 'has a broader approach to reducing harm to the', '2026-02-03 00:39:00'),
(1361, 72, 61, 46, '150-5-5', 150, 'environment, and each site takes actions based', '2026-02-03 00:39:00'),
(1362, 73, 61, 46, '150-6-1', 150, 'and dependencies on nature and biodiversity.', '2026-02-03 00:39:00'),
(1363, 73, 61, 46, '150-6-2', 150, 'It covers pollution, resource use with specific', '2026-02-03 00:39:00'),
(1364, 73, 61, 46, '150-6-3', 150, 'policy to address deforestation. Instead, our policy', '2026-02-03 00:39:00'),
(1365, 73, 61, 46, '150-6-4', 150, 'has a broader approach to reducing harm to the', '2026-02-03 00:39:00'),
(1366, 73, 61, 46, '150-6-5', 150, 'environment, and each site takes actions based', '2026-02-03 00:39:00'),
(1367, 13, 61, 46, '150-7-1', 150, 'active apatite mine in Siilinjärvi, Finland, where', '2026-02-03 00:39:00'),
(1368, 13, 61, 46, '150-7-2', 150, 'forested area is converted to an open-pit mine.', '2026-02-03 00:39:00'),
(1369, 15, 61, 46, '150-8-1', 150, 'forested area is converted to an open-pit mine.', '2026-02-03 00:39:00'),
(1370, 16, 61, 46, '150-9-1', 150, 'forested area is converted to an open-pit mine.', '2026-02-03 00:39:00'),
(1371, 20, 61, 46, '151-10-1', 151, 'risks and opportunities in our strategy and risk', '2026-02-03 00:39:00'),
(1372, 20, 61, 46, '151-10-2', 151, 'processes. The Board of Directors has decided', '2026-02-03 00:39:00'),
(1373, 31, 61, 46, '150-11-1', 150, 'active apatite mine in Siilinjärvi, Finland, where', '2026-02-03 00:39:00'),
(1374, 31, 61, 46, '150-11-2', 150, 'forested area is converted to an open-pit mine.', '2026-02-03 00:39:00'),
(1375, 32, 61, 46, '150-12-1', 150, 'forested area is converted to an open-pit mine.', '2026-02-03 00:39:00'),
(1376, 52, 61, 46, '151-13-1', 151, 'processes. The Board of Directors has decided', '2026-02-03 00:39:00'),
(1377, 52, 61, 46, '151-13-2', 151, 'that the company shall have a low risk appetite on', '2026-02-03 00:39:00'),
(1378, 52, 61, 46, '151-13-3', 151, 'environmental exposure.', '2026-02-03 00:39:00'),
(1379, 54, 61, 46, '151-14-1', 151, 'Our approach to reducing our impacts on', '2026-02-03 00:39:00'),
(1380, 55, 61, 46, '151-15-1', 151, 'processes. The Board of Directors has decided', '2026-02-03 00:39:00'),
(1381, 55, 61, 46, '151-15-2', 151, 'that the company shall have a low risk appetite on', '2026-02-03 00:39:00'),
(1382, 55, 61, 46, '151-15-3', 151, 'environmental exposure.', '2026-02-03 00:39:00'),
(1383, 58, 61, 46, '150-16-1', 150, 'policy does not address social consequences of', '2026-02-03 00:39:00'),
(1384, 73, 61, 46, '151-17-1', 151, 'addressing biodiversity impacts in our supply', '2026-02-03 00:39:00'),
(1385, 73, 61, 46, '151-17-2', 151, 'chain. For information on actions regarding the', '2026-02-03 00:39:00'),
(1386, 101, 61, 46, '150-18-1', 150, 'active apatite mine in Siilinjärvi, Finland, where', '2026-02-03 00:39:00'),
(1387, 101, 61, 46, '150-18-2', 150, 'forested area is converted to an open-pit mine.', '2026-02-03 00:39:00'),
(1388, 102, 61, 46, '151-19-1', 151, 'Siilinjärvi mine is now 2,652 hectares, of which', '2026-02-03 00:39:00'),
(1389, 102, 61, 46, '151-19-2', 151, '201 have been rehabilitated.', '2026-02-03 00:39:00'),
(1390, 104, 61, 46, '151-20-1', 151, 'The only site with material land-use change is', '2026-02-03 00:39:00'),
(1391, 105, 61, 46, '151-21-1', 151, 'Siilinjärvi mine is now 2,652 hectares, of which', '2026-02-03 00:39:00'),
(1392, 105, 61, 46, '151-21-2', 151, '201 have been rehabilitated.', '2026-02-03 00:39:00'),
(1393, 107, 61, 46, '150-22-1', 150, 'forested area is converted to an open-pit mine.', '2026-02-03 00:39:00'),
(1394, 110, 61, 46, '151-23-1', 151, 'Siilinjärvi mine is now 2,652 hectares, of which', '2026-02-03 00:39:00'),
(1395, 124, 61, 46, '151-24-1', 151, 'Siilinjärvi mine is now 2,652 hectares, of which', '2026-02-03 00:39:00'),
(1396, 129, 61, 46, '151-25-1', 151, 'ecosystem impacts, dependencies, risks and', '2026-02-03 00:39:00'),
(1397, 129, 61, 46, '151-25-2', 151, 'implications of biodiversity and ecosystem', '2026-02-03 00:39:00'),
(1398, 129, 61, 46, '151-25-3', 151, 'opportunities originate from our strategy and', '2026-02-03 00:39:00'),
(1399, 130, 61, 46, '151-26-1', 151, 'ecosystem impacts, dependencies, risks and', '2026-02-03 00:39:00'),
(1400, 130, 61, 46, '151-26-2', 151, 'implications of biodiversity and ecosystem', '2026-02-03 00:39:00'),
(1401, 52, 61, 46, '151-27-1', 151, 'on the HESQ management system. Through our', '2026-02-03 00:39:00'),
(1402, 52, 61, 46, '151-27-2', 151, 'HESQ Policy, we have an ambition of zero harm', '2026-02-03 00:39:00'),
(1403, 52, 61, 46, '151-27-3', 151, 'availability, are assessed under climate risks.', '2026-02-03 00:39:00'),
(1404, 52, 61, 46, '151-27-4', 151, 'to the environment. We do not track our progress', '2026-02-03 00:39:00'),
(1405, 52, 61, 46, '151-27-5', 151, 'See page 93 for more information.', '2026-02-03 00:39:00'),
(1406, 52, 61, 46, '151-27-6', 151, 'related to biodiversity and ecosystems, as we are', '2026-02-03 00:39:00'),
(1407, 52, 61, 46, '151-27-7', 151, 'still assessing our baseline. We do, however, track', '2026-02-03 00:39:00'),
(1408, 52, 61, 46, '151-27-8', 151, 'regulations. See page 142 for more', '2026-02-03 00:39:00'),
(1409, 70, 61, 46, '151-28-1', 151, 'Yara has identified Regenerative Agriculture', '2026-02-03 00:39:00'),
(1410, 70, 61, 46, '151-28-2', 151, 'change, this is applicable to our mining activities', '2026-02-03 00:39:00'),
(1411, 70, 61, 46, '151-28-3', 151, 'as a strategic response. See page 16 for more', '2026-02-03 00:39:00'),
(1412, 70, 61, 46, '151-28-4', 151, 'in Siilinjärvi and in 2024 there was no land-use', '2026-02-03 00:39:00'),
(1413, 70, 61, 46, '151-28-5', 151, 'change. Our current priorities focus on our own', '2026-02-03 00:39:00'),
(1414, 70, 61, 46, '151-28-6', 151, 'operations; therefore, we have no material actions', '2026-02-03 00:39:00'),
(1415, 73, 61, 46, '151-29-1', 151, 'Yara has identified Regenerative Agriculture', '2026-02-03 00:39:00'),
(1416, 73, 61, 46, '151-29-2', 151, 'change, this is applicable to our mining activities', '2026-02-03 00:39:00'),
(1417, 73, 61, 46, '151-29-3', 151, 'as a strategic response. See page 16 for more', '2026-02-03 00:39:00'),
(1418, 73, 61, 46, '151-29-4', 151, 'in Siilinjärvi and in 2024 there was no land-use', '2026-02-03 00:39:00'),
(1419, 73, 61, 46, '151-29-5', 151, 'change. Our current priorities focus on our own', '2026-02-03 00:39:00'),
(1420, 73, 61, 46, '151-29-6', 151, 'operations; therefore, we have no material actions', '2026-02-03 00:39:00'),
(1421, 73, 72, 56, '58-1-1', 58, 'change impacts, protect nature and biodiversity, and', '2026-03-01 15:42:52'),
(1422, 73, 72, 56, '58-1-2', 58, 'Selected actions', '2026-03-01 15:42:52'),
(1423, 73, 72, 56, '58-1-3', 58, 'Deliver a net-positive biodiversity impact for projects we commission from 2030 onwards to help protect nature and enable project delivery', '2026-03-01 15:42:52'),
(1424, 90, 72, 56, '58-2-1', 58, 'change impacts, protect nature and biodiversity, and', '2026-03-01 15:42:52'),
(1425, 90, 72, 56, '58-2-2', 58, 'Deliver a net-positive biodiversity impact for projects we commission from 2030 onwards to help protect nature and enable project delivery', '2026-03-01 15:42:52'),
(1426, 12, 72, 56, '85-3-1', 85, 'biodiversity-sensitive areas. These sites are listed in the', '2026-03-01 15:42:52'),
(1427, 13, 72, 56, '85-4-1', 85, 'vessel traffic, which contributes to noise and air pol-', '2026-03-01 15:42:52'),
(1428, 13, 72, 56, '85-4-2', 85, 'lution. At our onshore construction sites, impacts are', '2026-03-01 15:42:52'),
(1429, 13, 72, 56, '85-4-3', 85, 'mainly due to land clearing, cable laying, and machinery', '2026-03-01 15:42:52'),
(1430, 13, 72, 56, '85-4-4', 85, 'operation, causing temporary habitat disruption, species', '2026-03-01 15:42:52'),
(1431, 13, 72, 56, '85-4-5', 85, 'displacement, and noise pollution. All of these impacts', '2026-03-01 15:42:52'),
(1432, 13, 72, 56, '85-4-6', 85, 'cause temporary negative impacts during the con-', '2026-03-01 15:42:52'),
(1433, 13, 72, 56, '85-4-7', 85, 'struction phase, with no material impacts during oper-', '2026-03-01 15:42:52'),
(1434, 13, 72, 56, '85-4-8', 85, 'ations due to the extensive avoidance, reduction, and', '2026-03-01 15:42:52'),
(1435, 13, 72, 56, '85-4-9', 85, 'mitigation measures we build into project design and', '2026-03-01 15:42:52'),
(1436, 15, 72, 56, '85-5-1', 85, 'Some of our sites are located in or near biodiversity-', '2026-03-01 15:42:52'),
(1437, 15, 72, 56, '85-5-2', 85, 'identified as sites with temporary material impacts on', '2026-03-01 15:42:52'),
(1438, 15, 72, 56, '85-5-3', 85, 'sensitive areas. Our activities at these sites generally', '2026-03-01 15:42:52'),
(1439, 15, 72, 56, '85-5-4', 85, 'biodiversity-sensitive areas. These sites are listed in the', '2026-03-01 15:42:52'),
(1440, 16, 72, 56, '85-6-1', 85, 'mainly due to land clearing, cable laying, and machinery', '2026-03-01 15:42:52'),
(1441, 18, 72, 56, '85-7-1', 85, 'ity assessment. In this process, we identify and score', '2026-03-01 15:42:52'),
(1442, 18, 72, 56, '85-7-2', 85, 'impacts, risks, and opportunities (IROs) using knowledge', '2026-03-01 15:42:52'),
(1443, 18, 72, 56, '85-7-3', 85, 'gathered across all offshore and onshore assets, enabling', '2026-03-01 15:42:52'),
(1444, 18, 72, 56, '85-7-4', 85, 'a Group-wide assessment of IROs and dependencies. //', '2026-03-01 15:42:52'),
(1445, 18, 72, 56, '85-7-5', 85, 'conducting environmental impact assessments and risk', '2026-03-01 15:42:52'),
(1446, 18, 72, 56, '85-7-6', 85, 'screenings, we ensure that biodiversity management', '2026-03-01 15:42:52'),
(1447, 18, 72, 56, '85-7-7', 85, 'is integrated into our business and decision- making', '2026-03-01 15:42:52'),
(1448, 19, 72, 56, '85-8-1', 85, 'a Group-wide assessment of IROs and dependencies. //', '2026-03-01 15:42:52'),
(1449, 31, 72, 56, '85-9-1', 85, 'Some of our sites are located in or near biodiversity-', '2026-03-01 15:42:52'),
(1450, 31, 72, 56, '85-9-2', 85, 'sensitive areas. Our activities at these sites generally', '2026-03-01 15:42:52'),
(1451, 32, 72, 56, '85-10-1', 85, 'operation, causing temporary habitat disruption, species', '2026-03-01 15:42:52'),
(1452, 32, 72, 56, '85-10-2', 85, 'displacement, and noise pollution. All of these impacts', '2026-03-01 15:42:52'),
(1453, 32, 72, 56, '85-10-3', 85, 'cause temporary negative impacts during the con-', '2026-03-01 15:42:52'),
(1454, 32, 72, 56, '85-10-4', 85, 'struction phase, with no material impacts during oper-', '2026-03-01 15:42:52'),
(1455, 32, 72, 56, '85-10-5', 85, 'ations due to the extensive avoidance, reduction, and', '2026-03-01 15:42:52'),
(1456, 32, 72, 56, '85-10-6', 85, 'mitigation measures we build into project design and', '2026-03-01 15:42:52'),
(1457, 33, 72, 56, '85-11-1', 85, 'displacement, and noise pollution. All of these impacts', '2026-03-01 15:42:52'),
(1458, 33, 72, 56, '85-11-2', 85, 'are appropriately managed and mitigated through', '2026-03-01 15:42:52'),
(1459, 33, 72, 56, '85-11-3', 85, 'measures defined in the environmental impact assess-', '2026-03-01 15:42:52'),
(1460, 33, 72, 56, '85-11-4', 85, 'conducting environmental impact assessments and risk', '2026-03-01 15:42:52'),
(1461, 33, 72, 56, '85-11-5', 85, 'screenings, we ensure that biodiversity management', '2026-03-01 15:42:52'),
(1462, 33, 72, 56, '85-11-6', 85, 'is integrated into our business and decision- making', '2026-03-01 15:42:52'),
(1463, 33, 72, 56, '85-11-7', 85, 'mitigation measures we build into project design and', '2026-03-01 15:42:52'),
(1464, 52, 72, 56, '85-12-1', 85, 'By following our Biodiversity Policy and the steps laid', '2026-03-01 15:42:52'),
(1465, 69, 72, 56, '85-13-1', 85, 'Some of our sites are located in or near biodiversity-', '2026-03-01 15:42:52'),
(1466, 69, 72, 56, '85-13-2', 85, 'identified as sites with temporary material impacts on', '2026-03-01 15:42:52'),
(1467, 69, 72, 56, '85-13-3', 85, 'By following our Biodiversity Policy and the steps laid', '2026-03-01 15:42:52'),
(1468, 73, 72, 56, '85-14-1', 85, 'and ecosystems. In 2025, we continued taking action', '2026-03-01 15:42:52'),
(1469, 73, 72, 56, '85-14-2', 85, 'to deliver on our ambition of achieving a net-positive', '2026-03-01 15:42:52'),
(1470, 73, 72, 56, '85-14-3', 85, 'mitigation measures we build into project design and', '2026-03-01 15:42:52'),
(1471, 74, 72, 56, '85-15-1', 85, 'ations due to the extensive avoidance, reduction, and', '2026-03-01 15:42:52'),
(1472, 74, 72, 56, '85-15-2', 85, 'mitigation measures we build into project design and', '2026-03-01 15:42:52'),
(1473, 90, 72, 56, '85-16-1', 85, 'to deliver on our ambition of achieving a net-positive', '2026-03-01 15:42:52'),
(1474, 90, 72, 56, '85-16-2', 85, 'biodiversity impact from all new renewable energy', '2026-03-01 15:42:52'),
(1475, 90, 72, 56, '85-16-3', 85, 'projects we commission from 2030 onwards.', '2026-03-01 15:42:52'),
(1476, 96, 72, 56, '85-17-1', 85, 'to deliver on our ambition of achieving a net-positive', '2026-03-01 15:42:52'),
(1477, 96, 72, 56, '85-17-2', 85, 'biodiversity impact from all new renewable energy', '2026-03-01 15:42:52'),
(1478, 96, 72, 56, '85-17-3', 85, 'projects we commission from 2030 onwards.', '2026-03-01 15:42:52'),
(1479, 13, 72, 56, '85-18-1', 85, 'interactions with protected areas for nature conserva-', '2026-03-01 15:42:52'),
(1480, 13, 72, 56, '85-18-2', 85, 'important step towards realising this ambition, we', '2026-03-01 15:42:52'),
(1481, 13, 72, 56, '85-18-3', 85, 'routing and installing cables to either avoid or minimise', '2026-03-01 15:42:52'),
(1482, 13, 72, 56, '85-18-4', 85, 'primarily associated with noise pollution during pile', '2026-03-01 15:42:52'),
(1483, 13, 72, 56, '85-18-5', 85, 'tion or KBAs. Data is recognised from the date of the', '2026-03-01 15:42:52'),
(1484, 15, 72, 56, '85-19-1', 85, 'interactions with protected areas for nature conserva-', '2026-03-01 15:42:52'),
(1485, 15, 72, 56, '85-19-2', 85, 'tion or KBAs. Data is recognised from the date of the', '2026-03-01 15:42:52'),
(1486, 17, 72, 56, '85-20-1', 85, 'operation. Whenever overlaps with threatened species', '2026-03-01 15:42:52'),
(1487, 17, 72, 56, '85-20-2', 85, 'are identified, including those listed by the IUCN Red', '2026-03-01 15:42:52'),
(1488, 17, 72, 56, '85-20-3', 85, 'List, we develop action or mitigation plans to ensure no', '2026-03-01 15:42:52'),
(1489, 18, 72, 56, '85-21-1', 85, 'operation. Whenever overlaps with threatened species', '2026-03-01 15:42:52'),
(1490, 18, 72, 56, '85-21-2', 85, 'are identified, including those listed by the IUCN Red', '2026-03-01 15:42:52'),
(1491, 18, 72, 56, '85-21-3', 85, 'List, we develop action or mitigation plans to ensure no', '2026-03-01 15:42:52'),
(1492, 26, 72, 56, '85-22-1', 85, 'any residual impacts that cannot be fully avoided', '2026-03-01 15:42:52'),
(1493, 26, 72, 56, '85-22-2', 85, 'or mitigated are addressed through species-specific', '2026-03-01 15:42:52'),
(1494, 26, 72, 56, '85-22-3', 85, 'initiatives or habitat restoration, with the aim of', '2026-03-01 15:42:52'),
(1495, 26, 72, 56, '85-22-4', 85, 'restoring biodiversity and ecosystem functioning to at', '2026-03-01 15:42:52'),
(1496, 26, 72, 56, '85-22-5', 85, 'least pre-construction baseline levels. Where residual', '2026-03-01 15:42:52'),
(1497, 31, 72, 56, '85-23-1', 85, 'interactions with protected areas for nature conserva-', '2026-03-01 15:42:52'),
(1498, 31, 72, 56, '85-23-2', 85, 'tion or KBAs. Data is recognised from the date of the', '2026-03-01 15:42:52'),
(1499, 32, 72, 56, '85-24-1', 85, 'interactions with protected areas for nature conserva-', '2026-03-01 15:42:52'),
(1500, 32, 72, 56, '85-24-2', 85, 'primarily associated with noise pollution during pile', '2026-03-01 15:42:52'),
(1501, 32, 72, 56, '85-24-3', 85, 'tion or KBAs. Data is recognised from the date of the', '2026-03-01 15:42:52'),
(1502, 33, 72, 56, '85-25-1', 85, 'We apply the mitigation hierarchy by first seeking to', '2026-03-01 15:42:52'),
(1503, 33, 72, 56, '85-25-2', 85, 'List, we develop action or mitigation plans to ensure no', '2026-03-01 15:42:52'),
(1504, 44, 72, 56, '85-26-1', 85, 'We apply the mitigation hierarchy by first seeking to', '2026-03-01 15:42:52'),
(1505, 44, 72, 56, '85-26-2', 85, 'List, we develop action or mitigation plans to ensure no', '2026-03-01 15:42:52'),
(1506, 44, 72, 56, '85-26-3', 85, 'avoid harmful impacts. In the early stages of project', '2026-03-01 15:42:52'),
(1507, 49, 72, 56, '85-27-1', 85, 'launched our Biodiversity Measurement Framework', '2026-03-01 15:42:52'),
(1508, 73, 72, 56, '85-28-1', 85, 'any residual impacts that cannot be fully avoided', '2026-03-01 15:42:52'),
(1509, 73, 72, 56, '85-28-2', 85, 'or mitigated are addressed through species-specific', '2026-03-01 15:42:52'),
(1510, 73, 72, 56, '85-28-3', 85, 'initiatives or habitat restoration, with the aim of', '2026-03-01 15:42:52'),
(1511, 73, 72, 56, '85-28-4', 85, 'restoring biodiversity and ecosystem functioning to at', '2026-03-01 15:42:52'),
(1512, 73, 72, 56, '85-28-5', 85, 'least pre-construction baseline levels. Where residual', '2026-03-01 15:42:52'),
(1513, 74, 72, 56, '85-29-1', 85, 'We apply the mitigation hierarchy by first seeking to', '2026-03-01 15:42:52'),
(1514, 90, 72, 56, '85-30-1', 85, 'initiatives or habitat restoration, with the aim of', '2026-03-01 15:42:52'),
(1515, 90, 72, 56, '85-30-2', 85, 'restoring biodiversity and ecosystem functioning to at', '2026-03-01 15:42:52'),
(1516, 90, 72, 56, '85-30-3', 85, 'least pre-construction baseline levels. Where residual', '2026-03-01 15:42:52'),
(1517, 96, 72, 56, '85-31-1', 85, 'initiatives or habitat restoration, with the aim of', '2026-03-01 15:42:52'),
(1518, 96, 72, 56, '85-31-2', 85, 'restoring biodiversity and ecosystem functioning to at', '2026-03-01 15:42:52'),
(1519, 96, 72, 56, '85-31-3', 85, 'least pre-construction baseline levels. Where residual', '2026-03-01 15:42:52'),
(1520, 121, 72, 56, '85-32-1', 85, 'are identified, including those listed by the IUCN Red', '2026-03-01 15:42:52'),
(1521, 121, 72, 56, '85-32-2', 85, 'List, we develop action or mitigation plans to ensure no', '2026-03-01 15:42:52'),
(1522, 122, 72, 56, '85-33-1', 85, 'operation. Whenever overlaps with threatened species', '2026-03-01 15:42:52'),
(1523, 122, 72, 56, '85-33-2', 85, 'are identified, including those listed by the IUCN Red', '2026-03-01 15:42:52'),
(1524, 122, 72, 56, '85-33-3', 85, 'List, we develop action or mitigation plans to ensure no', '2026-03-01 15:42:52'),
(1525, 125, 72, 56, '85-34-1', 85, 'restoring biodiversity and ecosystem functioning to at', '2026-03-01 15:42:52'),
(1526, 125, 72, 56, '85-34-2', 85, 'least pre-construction baseline levels. Where residual', '2026-03-01 15:42:52'),
(1527, 15, 72, 56, '86-35-1', 86, 'Across our portfolio, 67 operational sites currently', '2026-03-01 15:42:52'),
(1528, 15, 72, 56, '86-35-2', 86, 'overlap with or are adjacent to protected areas or', '2026-03-01 15:42:52'),
(1529, 15, 72, 56, '86-35-3', 86, 'KBAs, as identified through the IBAT. This is largely due', '2026-03-01 15:42:52'),
(1530, 18, 72, 56, '85-36-1', 85, 'Process for identification and assessment Our ongoing work to identify and mitigate both actual', '2026-03-01 15:42:52'),
(1531, 18, 72, 56, '86-36-2', 86, 'One way we are doing that is by engaging with some', '2026-03-01 15:42:52'),
(1532, 18, 72, 56, '86-36-3', 86, 'of our first-tier suppliers to understand our joint impacts', '2026-03-01 15:42:52'),
(1533, 18, 72, 56, '86-36-4', 86, 'on biodiversity and continue to mitigate these.', '2026-03-01 15:42:52'),
(1534, 19, 72, 56, '86-37-1', 86, 'approach to managing biodiversity impacts and', '2026-03-01 15:42:52'),
(1535, 19, 72, 56, '86-37-2', 86, 'dependencies in our value chain. It also outlines how', '2026-03-01 15:42:52'),
(1536, 26, 72, 56, '85-38-1', 85, 'impacts remain, we implement ecological compen-', '2026-03-01 15:42:52'),
(1537, 26, 72, 56, '85-38-2', 85, 'sation or offsetting measures, while recognising that', '2026-03-01 15:42:52'),
(1538, 26, 72, 56, '85-38-3', 85, 'cannot be offset.', '2026-03-01 15:42:52'),
(1539, 26, 72, 56, '85-38-4', 85, 'Process for identification and assessment Our ongoing work to identify and mitigate both actual', '2026-03-01 15:42:52'),
(1540, 26, 72, 56, '86-38-5', 86, 'on biodiversity and continue to mitigate these.', '2026-03-01 15:42:52'),
(1541, 31, 72, 56, '86-39-1', 86, 'Across our portfolio, 67 operational sites currently', '2026-03-01 15:42:52'),
(1542, 31, 72, 56, '86-39-2', 86, 'overlap with or are adjacent to protected areas or', '2026-03-01 15:42:52'),
(1543, 31, 72, 56, '86-39-3', 86, 'KBAs, as identified through the IBAT. This is largely due', '2026-03-01 15:42:52'),
(1544, 33, 72, 56, '85-40-1', 85, 'impacts remain, we implement ecological compen-', '2026-03-01 15:42:52'),
(1545, 33, 72, 56, '85-40-2', 85, 'sation or offsetting measures, while recognising that', '2026-03-01 15:42:52'),
(1546, 33, 72, 56, '85-40-3', 85, 'Process for identification and assessment Our ongoing work to identify and mitigate both actual', '2026-03-01 15:42:52'),
(1547, 33, 72, 56, '86-40-4', 86, 'on biodiversity and continue to mitigate these.', '2026-03-01 15:42:52'),
(1548, 39, 72, 56, '86-41-1', 86, 'One way we are doing that is by engaging with some', '2026-03-01 15:42:52'),
(1549, 39, 72, 56, '86-41-2', 86, 'of our first-tier suppliers to understand our joint impacts', '2026-03-01 15:42:52'),
(1550, 42, 72, 56, '85-42-1', 85, 'Process for identification and assessment Our ongoing work to identify and mitigate both actual', '2026-03-01 15:42:52'),
(1551, 42, 72, 56, '86-42-2', 86, 'One way we are doing that is by engaging with some', '2026-03-01 15:42:52'),
(1552, 42, 72, 56, '86-42-3', 86, 'of our first-tier suppliers to understand our joint impacts', '2026-03-01 15:42:52'),
(1553, 42, 72, 56, '86-42-4', 86, 'on biodiversity and continue to mitigate these.', '2026-03-01 15:42:52'),
(1554, 44, 72, 56, '85-43-1', 85, 'impacts remain, we implement ecological compen-', '2026-03-01 15:42:52'),
(1555, 44, 72, 56, '85-43-2', 85, 'sation or offsetting measures, while recognising that', '2026-03-01 15:42:52'),
(1556, 44, 72, 56, '85-43-3', 85, 'certain environmental features are irreplaceable and', '2026-03-01 15:42:52'),
(1557, 44, 72, 56, '85-43-4', 85, 'cannot be offset.', '2026-03-01 15:42:52'),
(1558, 44, 72, 56, '85-43-5', 85, 'Process for identification and assessment Our ongoing work to identify and mitigate both actual', '2026-03-01 15:42:53'),
(1559, 44, 72, 56, '86-43-6', 86, 'on biodiversity and continue to mitigate these.', '2026-03-01 15:42:53'),
(1560, 49, 72, 56, '85-44-1', 85, 'In 2025, we further integrated our measurement', '2026-03-01 15:42:53'),
(1561, 49, 72, 56, '85-44-2', 85, 'framework and practices into our project operating', '2026-03-01 15:42:53'),
(1562, 51, 72, 56, '85-45-1', 85, 'certain environmental features are irreplaceable and', '2026-03-01 15:42:53'),
(1563, 51, 72, 56, '85-45-2', 85, 'cannot be offset.', '2026-03-01 15:42:53'),
(1564, 52, 72, 56, '86-46-1', 86, 'The policy addresses direct impacts from our activities', '2026-03-01 15:42:53'),
(1565, 52, 72, 56, '86-46-2', 86, 'able ocean practices. The policy includes our initial', '2026-03-01 15:42:53'),
(1566, 52, 72, 56, '86-46-3', 86, 'approach to managing biodiversity impacts and', '2026-03-01 15:42:53'),
(1567, 52, 72, 56, '86-46-4', 86, 'dependencies in our value chain. It also outlines how', '2026-03-01 15:42:53'),
(1568, 54, 72, 56, '86-47-1', 86, 'The policy addresses direct impacts from our activities', '2026-03-01 15:42:53'),
(1569, 54, 72, 56, '86-47-2', 86, 'able ocean practices. The policy includes our initial', '2026-03-01 15:42:53'),
(1570, 54, 72, 56, '86-47-3', 86, 'approach to managing biodiversity impacts and', '2026-03-01 15:42:53'),
(1571, 69, 72, 56, '86-48-1', 86, 'The policy addresses direct impacts from our activities', '2026-03-01 15:42:53'),
(1572, 69, 72, 56, '86-48-2', 86, 'Across our portfolio, 67 operational sites currently', '2026-03-01 15:42:53'),
(1573, 69, 72, 56, '86-48-3', 86, 'overlap with or are adjacent to protected areas or', '2026-03-01 15:42:53'),
(1574, 69, 72, 56, '86-48-4', 86, 'able ocean practices. The policy includes our initial', '2026-03-01 15:42:53'),
(1575, 69, 72, 56, '86-48-5', 86, 'KBAs, as identified through the IBAT. This is largely due', '2026-03-01 15:42:53'),
(1576, 69, 72, 56, '86-48-6', 86, 'approach to managing biodiversity impacts and', '2026-03-01 15:42:53'),
(1577, 71, 72, 56, '86-49-1', 86, 'able ocean practices. The policy includes our initial', '2026-03-01 15:42:53'),
(1578, 73, 72, 56, '85-50-1', 85, 'biodiversity actions.', '2026-03-01 15:42:53'),
(1579, 73, 72, 56, '86-50-2', 86, 'Key action: Seabird habitat restoration in Taiwan', '2026-03-01 15:42:53'),
(1580, 73, 72, 56, '86-50-3', 86, 'In 2025, we initiated seabird habitat restoration efforts', '2026-03-01 15:42:53'),
(1581, 73, 72, 56, '86-50-4', 86, 'along Taiwan’s western coastline to enhance condi-', '2026-03-01 15:42:53'),
(1582, 74, 72, 56, '85-51-1', 85, 'impacts remain, we implement ecological compen-', '2026-03-01 15:42:53'),
(1583, 74, 72, 56, '85-51-2', 85, 'sation or offsetting measures, while recognising that', '2026-03-01 15:42:53'),
(1584, 74, 72, 56, '85-51-3', 85, 'certain environmental features are irreplaceable and', '2026-03-01 15:42:53'),
(1585, 74, 72, 56, '85-51-4', 85, 'cannot be offset.', '2026-03-01 15:42:53'),
(1586, 75, 72, 56, '85-52-1', 85, 'impacts remain, we implement ecological compen-', '2026-03-01 15:42:53'),
(1587, 75, 72, 56, '85-52-2', 85, 'sation or offsetting measures, while recognising that', '2026-03-01 15:42:53'),
(1588, 81, 72, 56, '85-53-1', 85, 'impacts remain, we implement ecological compen-', '2026-03-01 15:42:53'),
(1589, 81, 72, 56, '85-53-2', 85, 'sation or offsetting measures, while recognising that', '2026-03-01 15:42:53'),
(1590, 86, 72, 56, '85-54-1', 85, 'In 2025, we further integrated our measurement', '2026-03-01 15:42:53'),
(1591, 86, 72, 56, '85-54-2', 85, 'framework and practices into our project operating', '2026-03-01 15:42:53'),
(1592, 86, 72, 56, '85-54-3', 85, 'model for renewable projects, ensuring that we are', '2026-03-01 15:42:53'),
(1593, 86, 72, 56, '85-54-4', 85, 'prepared for projects commissioned from 2030.', '2026-03-01 15:42:53'),
(1594, 87, 72, 56, '86-55-1', 86, 'In 2025, we initiated seabird habitat restoration efforts', '2026-03-01 15:42:53'),
(1595, 90, 72, 56, '85-56-1', 85, 'In 2025, we further integrated our measurement', '2026-03-01 15:42:53'),
(1596, 90, 72, 56, '85-56-2', 85, 'framework and practices into our project operating', '2026-03-01 15:42:53'),
(1597, 90, 72, 56, '86-56-3', 86, 'we will work to deliver on our net-positive biodiversity', '2026-03-01 15:42:53'),
(1598, 130, 72, 56, '85-57-1', 85, 'Process for identification and assessment Our ongoing work to identify and mitigate both actual', '2026-03-01 15:42:53'),
(1599, 130, 72, 56, '86-57-2', 86, 'approach to managing biodiversity impacts and', '2026-03-01 15:42:53'),
(1600, 130, 72, 56, '86-57-3', 86, 'dependencies in our value chain. It also outlines how', '2026-03-01 15:42:53'),
(1601, 33, 72, 56, '86-58-1', 86, 'installation of artificial nesting structures. Baseline', '2026-03-01 15:42:53'),
(1602, 33, 72, 56, '86-58-2', 86, 'managed through environmental impact assessments', '2026-03-01 15:42:53'),
(1603, 33, 72, 56, '86-58-3', 86, 'and permitting processes, with mitigation measures', '2026-03-01 15:42:53'),
(1604, 33, 72, 56, '86-58-4', 86, 'planned as required. An example is the risk of collision', '2026-03-01 15:42:53'),
(1605, 39, 72, 56, '86-59-1', 86, '// E4-3 Actions', '2026-03-01 15:42:53'),
(1606, 39, 72, 56, '86-59-2', 86, 'In 2022, we began a workstream exploring the methods', '2026-03-01 15:42:53'),
(1607, 39, 72, 56, '86-59-3', 86, 'for identifying and monitoring biodiversity growth at', '2026-03-01 15:42:53'),
(1608, 39, 72, 56, '86-59-4', 86, 'campaigns, which are often conducted in collaboration', '2026-03-01 15:42:53'),
(1609, 39, 72, 56, '86-59-5', 86, 'our assets in the UK. In 2025, we expanded the scope', '2026-03-01 15:42:53'),
(1610, 40, 72, 56, '86-60-1', 86, 'Biodiversity Policy', '2026-03-01 15:42:53'),
(1611, 40, 72, 56, '86-60-2', 86, 'Objective: To outline the steps we take to protect bio- diversity across the full life cycle of our assets and thereby how we approach our net-positive biodiversity ambition', '2026-03-01 15:42:53'),
(1612, 49, 72, 56, '86-61-1', 86, 'Availability: Biodiversity Policy', '2026-03-01 15:42:53'),
(1613, 49, 72, 56, '86-61-2', 86, 'habitat data has been collected, and long-term moni-', '2026-03-01 15:42:53'),
(1614, 49, 72, 56, '86-61-3', 86, 'toring will track progress in supporting seabird diversity', '2026-03-01 15:42:53'),
(1615, 52, 72, 56, '86-62-1', 86, 'Biodiversity Policy', '2026-03-01 15:42:53'),
(1616, 52, 72, 56, '86-62-2', 86, 'Objective: To outline the steps we take to protect bio- diversity across the full life cycle of our assets and thereby how we approach our net-positive biodiversity ambition', '2026-03-01 15:42:53'),
(1617, 71, 72, 56, '86-63-1', 86, 'Biodiversity Policy', '2026-03-01 15:42:53'),
(1618, 71, 72, 56, '86-63-2', 86, 'restore wetlands and sandbar areas through targeted', '2026-03-01 15:42:53'),
(1619, 71, 72, 56, '86-63-3', 86, 'Objective: To outline the steps we take to protect bio- diversity across the full life cycle of our assets and thereby how we approach our net-positive biodiversity ambition', '2026-03-01 15:42:53'),
(1620, 73, 72, 56, '86-64-1', 86, '// E4-3 Actions', '2026-03-01 15:42:53'),
(1621, 73, 72, 56, '86-64-2', 86, 'In 2022, we began a workstream exploring the methods', '2026-03-01 15:42:53'),
(1622, 73, 72, 56, '86-64-3', 86, 'for identifying and monitoring biodiversity growth at', '2026-03-01 15:42:53'),
(1623, 73, 72, 56, '86-64-4', 86, 'campaigns, which are often conducted in collaboration', '2026-03-01 15:42:53'),
(1624, 73, 72, 56, '86-64-5', 86, 'our assets in the UK. In 2025, we expanded the scope', '2026-03-01 15:42:53'),
(1625, 74, 72, 56, '86-65-1', 86, 'Key action: Tracking biodiversity growth at our assets', '2026-03-01 15:42:53'),
(1626, 74, 72, 56, '86-65-2', 86, 'Where such impacts cannot be fully mitigated through', '2026-03-01 15:42:53'),
(1627, 74, 72, 56, '86-65-3', 86, 'siting or design changes, operational management', '2026-03-01 15:42:53'),
(1628, 74, 72, 56, '86-65-4', 86, 'plans are implemented, such as enhanced monitoring', '2026-03-01 15:42:53'),
(1629, 86, 72, 56, '86-66-1', 86, 'negative impacts on biodiversity at these sites.', '2026-03-01 15:42:53'),
(1630, 86, 72, 56, '86-66-2', 86, 'During operations, impacts are very limited and are', '2026-03-01 15:42:53'),
(1631, 86, 72, 56, '86-66-3', 86, 'We continuously work on habitat and ecosystem', '2026-03-01 15:42:53'),
(1632, 86, 72, 56, '86-66-4', 86, 'restoration, including the protection and restoration', '2026-03-01 15:42:53'),
(1633, 88, 72, 56, '86-67-1', 86, '// E4-3 Actions', '2026-03-01 15:42:53'),
(1634, 88, 72, 56, '86-67-2', 86, 'In 2022, we began a workstream exploring the methods', '2026-03-01 15:42:53'),
(1635, 88, 72, 56, '86-67-3', 86, 'for identifying and monitoring biodiversity growth at', '2026-03-01 15:42:53'),
(1636, 88, 72, 56, '86-67-4', 86, 'campaigns, which are often conducted in collaboration', '2026-03-01 15:42:53'),
(1637, 88, 72, 56, '86-67-5', 86, 'our assets in the UK. In 2025, we expanded the scope', '2026-03-01 15:42:53'),
(1638, 89, 72, 56, '86-68-1', 86, '// E4-3 Actions', '2026-03-01 15:42:53'),
(1639, 89, 72, 56, '86-68-2', 86, 'In 2022, we began a workstream exploring the methods', '2026-03-01 15:42:53'),
(1640, 89, 72, 56, '86-68-3', 86, 'for identifying and monitoring biodiversity growth at', '2026-03-01 15:42:53'),
(1641, 89, 72, 56, '86-68-4', 86, 'campaigns, which are often conducted in collaboration', '2026-03-01 15:42:53'),
(1642, 89, 72, 56, '86-68-5', 86, 'our assets in the UK. In 2025, we expanded the scope', '2026-03-01 15:42:53'),
(1643, 90, 72, 56, '86-69-1', 86, 'Key action: Tracking biodiversity growth at our assets', '2026-03-01 15:42:53'),
(1644, 90, 72, 56, '86-69-2', 86, 'From 2030, all projects we commission will have a', '2026-03-01 15:42:53'),
(1645, 106, 72, 56, '86-70-1', 86, 'negative impacts on biodiversity at these sites.', '2026-03-01 15:42:53'),
(1646, 106, 72, 56, '86-70-2', 86, 'During operations, impacts are very limited and are', '2026-03-01 15:42:53'),
(1647, 106, 72, 56, '86-70-3', 86, 'We continuously work on habitat and ecosystem', '2026-03-01 15:42:53'),
(1648, 106, 72, 56, '86-70-4', 86, 'restoration, including the protection and restoration', '2026-03-01 15:42:53'),
(1649, 117, 72, 56, '86-71-1', 86, 'Availability: Biodiversity Policy', '2026-03-01 15:42:53'),
(1650, 117, 72, 56, '86-71-2', 86, 'habitat data has been collected, and long-term moni-', '2026-03-01 15:42:53'),
(1651, 117, 72, 56, '86-71-3', 86, 'toring will track progress in supporting seabird diversity', '2026-03-01 15:42:53'),
(1652, 119, 72, 56, '86-72-1', 86, 'and population recovery during the migration seasons.', '2026-03-01 15:42:53'),
(1653, 119, 72, 56, '86-72-2', 86, 'birds), which is appropriately planned for and managed.', '2026-03-01 15:42:53'),
(1654, 120, 72, 56, '86-73-1', 86, 'Availability: Biodiversity Policy', '2026-03-01 15:42:53'),
(1655, 120, 72, 56, '86-73-2', 86, 'habitat data has been collected, and long-term moni-', '2026-03-01 15:42:53'),
(1656, 120, 72, 56, '86-73-3', 86, 'toring will track progress in supporting seabird diversity', '2026-03-01 15:42:53'),
(1657, 126, 72, 56, '86-74-1', 86, 'Availability: Biodiversity Policy', '2026-03-01 15:42:53'),
(1658, 126, 72, 56, '86-74-2', 86, 'habitat data has been collected, and long-term moni-', '2026-03-01 15:42:53'),
(1659, 126, 72, 56, '86-74-3', 86, 'toring will track progress in supporting seabird diversity', '2026-03-01 15:42:53'),
(1660, 16, 72, 56, '86-75-1', 86, 'resource extraction and mining activities. These activities', '2026-03-01 15:42:53'),
(1661, 16, 72, 56, '86-75-2', 86, 'can degrade ecosystems, alter habitats, and reduce', '2026-03-01 15:42:53'),
(1662, 31, 72, 56, '86-76-1', 86, '– at the Greater Changhua 1 Offshore Wind Farm in', '2026-03-01 15:42:53'),
(1663, 31, 72, 56, '86-76-2', 86, 'August 2025. We will now monitor the site to assess', '2026-03-01 15:42:53'),
(1664, 31, 72, 56, '86-76-3', 86, 'coral adaptation and growth, sharing results with', '2026-03-01 15:42:53'),
(1665, 49, 72, 56, '86-77-1', 86, 'workstream remains central to tracking and monitoring', '2026-03-01 15:42:53'),
(1666, 52, 72, 56, '86-78-1', 86, 'Our Biodiversity Policy applies to all locations owned', '2026-03-01 15:42:53'),
(1667, 52, 72, 56, '86-78-2', 86, 'and operated by Ørsted, offshore and onshore,', '2026-03-01 15:42:53'),
(1668, 54, 72, 56, '86-79-1', 86, 'and this mapping informs our approach to addressing', '2026-03-01 15:42:53'),
(1669, 54, 72, 56, '86-79-2', 86, 'Our Biodiversity Policy applies to all locations owned', '2026-03-01 15:42:53'),
(1670, 54, 72, 56, '86-79-3', 86, 'and operated by Ørsted, offshore and onshore,', '2026-03-01 15:42:53'),
(1671, 69, 72, 56, '86-80-1', 86, 'Our Biodiversity Policy applies to all locations owned', '2026-03-01 15:42:53'),
(1672, 69, 72, 56, '86-80-2', 86, 'and operated by Ørsted, offshore and onshore,', '2026-03-01 15:42:53'),
(1673, 71, 72, 56, '86-81-1', 86, 'Our Biodiversity Policy applies to all locations owned', '2026-03-01 15:42:53'),
(1674, 71, 72, 56, '86-81-2', 86, 'and operated by Ørsted, offshore and onshore,', '2026-03-01 15:42:53'),
(1675, 73, 72, 56, '86-82-1', 86, 'Key action: ReCoral by Ørsted™ in Taiwan', '2026-03-01 15:42:53'),
(1676, 86, 72, 56, '86-83-1', 86, 'workstream remains central to tracking and monitoring', '2026-03-01 15:42:53'),
(1677, 89, 72, 56, '86-84-1', 86, '– at the Greater Changhua 1 Offshore Wind Farm in', '2026-03-01 15:42:53'),
(1678, 89, 72, 56, '86-84-2', 86, 'August 2025. We will now monitor the site to assess', '2026-03-01 15:42:53'),
(1679, 89, 72, 56, '86-84-3', 86, 'coral adaptation and growth, sharing results with', '2026-03-01 15:42:53'),
(1680, 104, 72, 56, '86-85-1', 86, 'workstream remains central to tracking and monitoring', '2026-03-01 15:42:53'),
(1681, 117, 72, 56, '86-86-1', 86, 'workstream remains central to tracking and monitoring', '2026-03-01 15:42:53'),
(1682, 126, 72, 56, '86-87-1', 86, '30 metres – comprising multiple species and age groups', '2026-03-01 15:42:53'),
(1683, 18, 72, 56, '87-88-1', 87, 'Key action: Mapping our nature-related risks', '2026-03-01 15:42:53'),
(1684, 18, 72, 56, '87-88-2', 87, 'In 2024, we completed an assessment of nature-', '2026-03-01 15:42:53'),
(1685, 18, 72, 56, '87-88-3', 87, 'related risks, impacts, and dependencies across a sam-', '2026-03-01 15:42:53'),
(1686, 18, 72, 56, '87-88-4', 87, 'ple of our sites, both offshore and onshore. We also', '2026-03-01 15:42:53'),
(1687, 18, 72, 56, '87-88-5', 87, 'began exploring selected material commodities in', '2026-03-01 15:42:53'),
(1688, 18, 72, 56, '87-88-6', 87, 'our upstream supply chain. In 2025, we conducted', '2026-03-01 15:42:53'),
(1689, 19, 72, 56, '87-89-1', 87, 'Key action: Mapping our nature-related risks', '2026-03-01 15:42:53'),
(1690, 19, 72, 56, '87-89-2', 87, 'In 2024, we completed an assessment of nature-', '2026-03-01 15:42:53'),
(1691, 19, 72, 56, '87-89-3', 87, 'related risks, impacts, and dependencies across a sam-', '2026-03-01 15:42:53'),
(1692, 19, 72, 56, '87-89-4', 87, 'ple of our sites, both offshore and onshore. We also', '2026-03-01 15:42:53'),
(1693, 19, 72, 56, '87-89-5', 87, 'began exploring selected material commodities in', '2026-03-01 15:42:53'),
(1694, 19, 72, 56, '87-89-6', 87, 'our upstream supply chain. In 2025, we conducted', '2026-03-01 15:42:53'),
(1695, 31, 72, 56, '87-90-1', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1696, 31, 72, 56, '87-90-2', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1697, 31, 72, 56, '87-90-3', 87, 'the Humber Estuary continues to progress successfully.', '2026-03-01 15:42:53'),
(1698, 31, 72, 56, '87-90-4', 87, 'The aim of the restoration project, Wilder Humber, is', '2026-03-01 15:42:53'),
(1699, 31, 72, 56, '87-90-5', 87, 'to restore the threatened salt marshes and includes', '2026-03-01 15:42:53'),
(1700, 33, 72, 56, '87-91-1', 87, 'Key action: 3D-printed reefs at Anholt Offshore Wind Farm', '2026-03-01 15:42:53'),
(1701, 33, 72, 56, '87-91-2', 87, 'Between 2022 and 2025, we conducted biodiversity', '2026-03-01 15:42:53'),
(1702, 33, 72, 56, '87-91-3', 87, 'Key action: Innovative seagrass planting at the Humber Estuary', '2026-03-01 15:42:53'),
(1703, 33, 72, 56, '87-91-4', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1704, 33, 72, 56, '87-91-5', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1705, 33, 72, 56, '87-91-6', 87, 'the Humber Estuary continues to progress successfully.', '2026-03-01 15:42:53'),
(1706, 33, 72, 56, '87-91-7', 87, 'The aim of the restoration project, Wilder Humber, is', '2026-03-01 15:42:53'),
(1707, 33, 72, 56, '87-91-8', 87, 'to restore the threatened salt marshes and includes', '2026-03-01 15:42:53'),
(1708, 33, 72, 56, '87-91-9', 87, 'seagrass planting, salt marsh restoration, and rebuild-', '2026-03-01 15:42:53'),
(1709, 33, 72, 56, '87-91-10', 87, 'ing native oyster beds. In 2025, we trialled a new', '2026-03-01 15:42:53'),
(1710, 39, 72, 56, '87-92-1', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1711, 39, 72, 56, '87-92-2', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1712, 49, 72, 56, '87-93-1', 87, 'reefs, natural boulder reefs, foundation structures, and', '2026-03-01 15:42:53'),
(1713, 49, 72, 56, '87-93-2', 87, 'biohuts in the Port of Grenaa. We conducted a visual', '2026-03-01 15:42:53'),
(1714, 49, 72, 56, '87-93-3', 87, 'inspection which showed that the 12 3D-printed reefs', '2026-03-01 15:42:53'),
(1715, 49, 72, 56, '87-93-4', 87, 'sea bass, sea squirts, crabs, and starfish were detected', '2026-03-01 15:42:53'),
(1716, 49, 72, 56, '87-93-5', 87, 'some reefs. eDNA results from the wind farm are not', '2026-03-01 15:42:53'),
(1717, 49, 72, 56, '87-93-6', 87, 'yet finalised but are expected to be ready during 2026.', '2026-03-01 15:42:53'),
(1718, 73, 72, 56, '87-94-1', 87, 'Key action: 3D-printed reefs at Anholt Offshore Wind Farm', '2026-03-01 15:42:53'),
(1719, 73, 72, 56, '87-94-2', 87, 'Between 2022 and 2025, we conducted biodiversity', '2026-03-01 15:42:53'),
(1720, 73, 72, 56, '87-94-3', 87, 'Key action: Innovative seagrass planting at the Humber Estuary', '2026-03-01 15:42:53'),
(1721, 73, 72, 56, '87-94-4', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1722, 73, 72, 56, '87-94-5', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1723, 73, 72, 56, '87-94-6', 87, 'the Humber Estuary continues to progress successfully.', '2026-03-01 15:42:53'),
(1724, 73, 72, 56, '87-94-7', 87, 'The aim of the restoration project, Wilder Humber, is', '2026-03-01 15:42:53'),
(1725, 73, 72, 56, '87-94-8', 87, 'to restore the threatened salt marshes and includes', '2026-03-01 15:42:53'),
(1726, 73, 72, 56, '87-94-9', 87, 'seagrass planting, salt marsh restoration, and rebuild-', '2026-03-01 15:42:53'),
(1727, 73, 72, 56, '87-94-10', 87, 'ing native oyster beds. In 2025, we trialled a new', '2026-03-01 15:42:53'),
(1728, 73, 72, 56, '87-94-11', 87, 'innovative seagrass seed planting technique where', '2026-03-01 15:42:53'),
(1729, 73, 72, 56, '87-94-12', 87, 'seagrass ‘plugs’ are transplanted from an area with', '2026-03-01 15:42:53'),
(1730, 73, 72, 56, '87-94-13', 87, 'are set and grown on rock and scallop shells – the first-', '2026-03-01 15:42:53'),
(1731, 73, 72, 56, '87-94-14', 87, 'ever trial using this method in the UK. This combination', '2026-03-01 15:42:53'),
(1732, 73, 72, 56, '87-94-15', 87, 'of novel approaches has already greatly increased the', '2026-03-01 15:42:53'),
(1733, 86, 72, 56, '87-95-1', 87, 'during a trial at our offshore wind farm Gode Wind 3.', '2026-03-01 15:42:53'),
(1734, 86, 72, 56, '87-95-2', 87, 'In 2025, Osonic moved into a commercial phase,', '2026-03-01 15:42:53'),
(1735, 86, 72, 56, '87-95-3', 87, 'with Ørsted offering licencing of the technology and', '2026-03-01 15:42:53'),
(1736, 86, 72, 56, '87-95-4', 87, 'related services to third-party developers for European', '2026-03-01 15:42:53'),
(1737, 86, 72, 56, '87-95-5', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1738, 86, 72, 56, '87-95-6', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1739, 86, 72, 56, '87-95-7', 87, 'the Humber Estuary continues to progress successfully.', '2026-03-01 15:42:53'),
(1740, 88, 72, 56, '87-96-1', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1741, 88, 72, 56, '87-96-2', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1742, 89, 72, 56, '87-97-1', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1743, 89, 72, 56, '87-97-2', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1744, 106, 72, 56, '87-98-1', 87, 'reefs, natural boulder reefs, foundation structures, and', '2026-03-01 15:42:53'),
(1745, 106, 72, 56, '87-98-2', 87, 'biohuts in the Port of Grenaa. We conducted a visual', '2026-03-01 15:42:53');
INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(1746, 106, 72, 56, '87-98-3', 87, 'inspection which showed that the 12 3D-printed reefs', '2026-03-01 15:42:53'),
(1747, 106, 72, 56, '87-98-4', 87, 'we installed in 2022 are now fully covered with algae,', '2026-03-01 15:42:53'),
(1748, 106, 72, 56, '87-98-5', 87, 'providing valuable space, shelter, food, and fruitful', '2026-03-01 15:42:53'),
(1749, 106, 72, 56, '87-98-6', 87, 'ground for further floral overgrowth. Species such as', '2026-03-01 15:42:53'),
(1750, 106, 72, 56, '87-98-7', 87, 'sea bass, sea squirts, crabs, and starfish were detected', '2026-03-01 15:42:53'),
(1751, 106, 72, 56, '87-98-8', 87, 'at the reefs. The reefs’ hard surfaces have been covered', '2026-03-01 15:42:53'),
(1752, 106, 72, 56, '87-98-9', 87, 'with beautiful red algae, with sugar kelp growing on', '2026-03-01 15:42:53'),
(1753, 106, 72, 56, '87-98-10', 87, 'some reefs. eDNA results from the wind farm are not', '2026-03-01 15:42:53'),
(1754, 106, 72, 56, '87-98-11', 87, 'yet finalised but are expected to be ready during 2026.', '2026-03-01 15:42:53'),
(1755, 106, 72, 56, '87-98-12', 87, 'Our work with the Yorkshire Wildlife Trust and', '2026-03-01 15:42:53'),
(1756, 106, 72, 56, '87-98-13', 87, 'Lincolnshire Wildlife Trust, initiated in 2022, to restore', '2026-03-01 15:42:53'),
(1757, 106, 72, 56, '87-98-14', 87, 'the Humber Estuary continues to progress successfully.', '2026-03-01 15:42:53'),
(1758, 106, 72, 56, '87-98-15', 87, 'The aim of the restoration project, Wilder Humber, is', '2026-03-01 15:42:53'),
(1759, 106, 72, 56, '87-98-16', 87, 'to restore the threatened salt marshes and includes', '2026-03-01 15:42:53'),
(1760, 106, 72, 56, '87-98-17', 87, 'seagrass planting, salt marsh restoration, and rebuild-', '2026-03-01 15:42:53'),
(1761, 106, 72, 56, '87-98-18', 87, 'ing native oyster beds. In 2025, we trialled a new', '2026-03-01 15:42:53'),
(1762, 117, 72, 56, '87-99-1', 87, 'reefs, natural boulder reefs, foundation structures, and', '2026-03-01 15:42:53'),
(1763, 117, 72, 56, '87-99-2', 87, 'ground for further floral overgrowth. Species such as', '2026-03-01 15:42:53'),
(1764, 117, 72, 56, '87-99-3', 87, 'sea bass, sea squirts, crabs, and starfish were detected', '2026-03-01 15:42:53'),
(1765, 117, 72, 56, '87-99-4', 87, 'at the reefs. The reefs’ hard surfaces have been covered', '2026-03-01 15:42:53'),
(1766, 126, 72, 56, '87-100-1', 87, 'reefs, natural boulder reefs, foundation structures, and', '2026-03-01 15:42:53'),
(1767, 126, 72, 56, '87-100-2', 87, 'ground for further floral overgrowth. Species such as', '2026-03-01 15:42:53'),
(1768, 126, 72, 56, '87-100-3', 87, 'sea bass, sea squirts, crabs, and starfish were detected', '2026-03-01 15:42:53'),
(1769, 126, 72, 56, '87-100-4', 87, 'at the reefs. The reefs’ hard surfaces have been covered', '2026-03-01 15:42:53'),
(1770, 127, 72, 56, '87-101-1', 87, 'reefs, natural boulder reefs, foundation structures, and', '2026-03-01 15:42:53'),
(1771, 127, 72, 56, '87-101-2', 87, 'biohuts in the Port of Grenaa. We conducted a visual', '2026-03-01 15:42:53'),
(1772, 127, 72, 56, '87-101-3', 87, 'inspection which showed that the 12 3D-printed reefs', '2026-03-01 15:42:53'),
(1773, 127, 72, 56, '87-101-4', 87, 'we installed in 2022 are now fully covered with algae,', '2026-03-01 15:42:53'),
(1774, 127, 72, 56, '87-101-5', 87, 'providing valuable space, shelter, food, and fruitful', '2026-03-01 15:42:53'),
(1775, 127, 72, 56, '87-101-6', 87, 'ground for further floral overgrowth. Species such as', '2026-03-01 15:42:53'),
(1776, 127, 72, 56, '87-101-7', 87, 'sea bass, sea squirts, crabs, and starfish were detected', '2026-03-01 15:42:53'),
(1777, 127, 72, 56, '87-101-8', 87, 'at the reefs. The reefs’ hard surfaces have been covered', '2026-03-01 15:42:53'),
(1778, 127, 72, 56, '87-101-9', 87, 'with beautiful red algae, with sugar kelp growing on', '2026-03-01 15:42:53'),
(1779, 127, 72, 56, '87-101-10', 87, 'some reefs. eDNA results from the wind farm are not', '2026-03-01 15:42:53'),
(1780, 127, 72, 56, '87-101-11', 87, 'yet finalised but are expected to be ready during 2026.', '2026-03-01 15:42:53'),
(1781, 18, 72, 56, '87-102-1', 87, 'Risk and impact management', '2026-03-01 15:42:53'),
(1782, 18, 72, 56, '87-102-2', 87, 'a) i. Processes for identifying, assess- ing, and prioritising nature-related dependencies, impacts, risks, and opportunities in direct operations', '2026-03-01 15:42:53'),
(1783, 18, 72, 56, '87-102-3', 87, 'ii. Processes for identifying, assess- ing, and prioritising nature-related dependencies, impacts, risks, and opportunities in the value chain', '2026-03-01 15:42:53'),
(1784, 19, 72, 56, '87-103-1', 87, 'Risk and impact management', '2026-03-01 15:42:53'),
(1785, 19, 72, 56, '87-103-2', 87, 'a) i. Processes for identifying, assess- ing, and prioritising nature-related dependencies, impacts, risks, and opportunities in direct operations', '2026-03-01 15:42:53'),
(1786, 19, 72, 56, '87-103-3', 87, 'ii. Processes for identifying, assess- ing, and prioritising nature-related dependencies, impacts, risks, and opportunities in the value chain', '2026-03-01 15:42:53'),
(1787, 20, 72, 56, '87-104-1', 87, 'Risk and impact management', '2026-03-01 15:42:53'),
(1788, 20, 72, 56, '87-104-2', 87, 'a) i. Processes for identifying, assess- ing, and prioritising nature-related dependencies, impacts, risks, and opportunities in direct operations', '2026-03-01 15:42:53'),
(1789, 20, 72, 56, '87-104-3', 87, 'ii. Processes for identifying, assess- ing, and prioritising nature-related dependencies, impacts, risks, and opportunities in the value chain', '2026-03-01 15:42:53'),
(1790, 34, 72, 56, '87-105-1', 87, 'c) Resilience of the strategy to nature-related risks and opportunities', '2026-03-01 15:42:53'),
(1791, 34, 72, 56, '87-105-2', 87, 'MR · pages 23-26 SS · pages 85-91', '2026-03-01 15:42:53'),
(1792, 34, 72, 56, '87-105-3', 87, 'MR · page 11 SS · pages 85-91', '2026-03-01 15:42:53'),
(1793, 49, 72, 56, '87-106-1', 87, 'Metrics and targets', '2026-03-01 15:42:53'),
(1794, 49, 72, 56, '87-106-2', 87, 'a) Metrics used to manage ma- terial nature-related risks and opportunities', '2026-03-01 15:42:53'),
(1795, 49, 72, 56, '87-106-3', 87, 'b) Metrics used to assess nature- related dependencies and impacts', '2026-03-01 15:42:53'),
(1796, 16, 73, 57, '108-1-1', 108, '| ESRS E4', '2026-03-10 18:29:33'),
(1797, 16, 73, 57, '108-1-2', 108, 'Natural resources exploitation and land- and freshwater-use change from mining Negative impact', '2026-03-10 18:29:33'),
(1798, 16, 73, 57, '108-1-3', 108, 'Habitat loss from land degradation due to mining Negative impact', '2026-03-10 18:29:33'),
(1799, 130, 73, 57, '108-2-1', 108, '| ESRS E4', '2026-03-10 18:29:33'),
(1800, 130, 73, 57, '108-2-2', 108, 'Natural resources exploitation and land- and freshwater-use change from mining Negative impact', '2026-03-10 18:29:33'),
(1801, 130, 73, 57, '108-2-3', 108, 'Habitat loss from land degradation due to mining Negative impact', '2026-03-10 18:29:33'),
(1802, 130, 73, 57, '108-3-1', 108, 'Temporary disturbances to habitats during construction Negative impact', '2026-03-10 18:29:33'),
(1803, 130, 73, 57, '108-4-1', 108, 'Temporary displacement or loss of species during construction Negative impact', '2026-03-10 18:29:33'),
(1804, 130, 73, 57, '108-4-2', 108, 'Ecotoxicity from mining Negative impact', '2026-03-10 18:29:33'),
(1805, 130, 73, 57, '108-4-3', 108, 'Species population size decrease and extinction risk increase due to mining Negative impact', '2026-03-10 18:29:33'),
(1806, 130, 73, 57, '108-5-1', 108, 'Land- and sea-use change from coal and gas extraction Negative impact', '2026-03-10 18:29:33'),
(1807, 16, 73, 57, '109-6-1', 109, 'Habitat loss from land degradation from mining Negative impact (upstream value chain)', '2026-03-10 18:29:33'),
(1808, 16, 73, 57, '109-6-2', 109, 'Mining of metals and minerals in our supply chain is a direct impact driver of biodiversity loss through land-use and freshwater-use change and ecotoxicity from run-off. It also impacts ecosystems through land degradation.', '2026-03-10 18:29:33'),
(1809, 18, 73, 57, '109-7-1', 109, 'In the tables to the right and on the next page are descriptions of our material IROs related to biodiversity and ecosystems, including how we manage them.', '2026-03-10 18:29:33'),
(1810, 18, 73, 57, '109-7-2', 109, 'The impacts primarily originate from our renewable energy business activities but also partly from our legacy business relating to coal and gas.', '2026-03-10 18:29:33'),
(1811, 18, 73, 57, '109-7-3', 109, 'These impacts occur both through our busi- ness relationships with suppliers and through our own activities of constructing our renew- able assets.', '2026-03-10 18:29:33'),
(1812, 18, 73, 57, '109-7-4', 109, 'We have completed a mapping to help us understand potential negative impacts on biodiversity that we may have in our value chain. We continue to explore ways to identify and miti- gate impacts across our value chain, including our first attempt at mapping impacts from high impact commodi- ties (HICs) in our upstream value chain.', '2026-03-10 18:29:33'),
(1813, 20, 73, 57, '110-8-1', 110, 'impacts and an opportunity in our business, both in', '2026-03-10 18:29:33'),
(1814, 20, 73, 57, '110-8-2', 110, 'and assessing these impacts help us to understand', '2026-03-10 18:29:33'),
(1815, 20, 73, 57, '110-8-3', 110, 'how we can continue to strengthen resilience across', '2026-03-10 18:29:33'),
(1816, 20, 73, 57, '110-8-4', 110, 'our operations, which we also assess using the', '2026-03-10 18:29:33'),
(1817, 20, 73, 57, '110-8-5', 110, 'methodology of the Taskforce on Nature-related', '2026-03-10 18:29:33'),
(1818, 20, 73, 57, '110-8-6', 110, 'Financial Disclosures (TNFD). //', '2026-03-10 18:29:33'),
(1819, 33, 73, 57, '109-9-1', 109, 'At an asset level, we prefer to always have a biodiversity action plan in place, which helps us map out our negative impacts and plan out our mitigating actions accordingly.', '2026-03-10 18:29:33'),
(1820, 34, 73, 57, '110-10-1', 110, 'how we can continue to strengthen resilience across', '2026-03-10 18:29:33'),
(1821, 40, 73, 57, '110-11-1', 110, '// E4-1 Transition plan', '2026-03-10 18:29:33'),
(1822, 42, 73, 57, '109-12-1', 109, 'The impacts primarily originate from our renewable energy business activities but also partly from our legacy business relating to coal and gas.', '2026-03-10 18:29:33'),
(1823, 42, 73, 57, '109-12-2', 109, 'These impacts occur both through our busi- ness relationships with suppliers and through our own activities of constructing our renew- able assets.', '2026-03-10 18:29:33'),
(1824, 42, 73, 57, '109-12-3', 109, 'We have completed a mapping to help us understand potential negative impacts on biodiversity that we may have in our value chain. We continue to explore ways to identify and miti- gate impacts across our value chain, including our first attempt at mapping impacts from high impact commodi- ties (HICs) in our upstream value chain.', '2026-03-10 18:29:33'),
(1825, 42, 73, 57, '109-12-4', 109, 'We are working towards managing our biodiversity-related negative impacts in our value chain.', '2026-03-10 18:29:33'),
(1826, 49, 73, 57, '109-13-1', 109, 'We have implemented several biodiversity pilot projects, monitoring plans, and innovative initiatives to work towards achieving our 2030 net-positive ambition. The most recent one being the launch of our ‘Biodiversity measurement framework’, which will allow us to measure and assess impacts on biodiversity at an asset level, across offshore and onshore operations.', '2026-03-10 18:29:33'),
(1827, 96, 73, 57, '110-14-1', 110, 'Species population size decrease and global extinction risk increase due to mining Negative impact (upstream value chain)', '2026-03-10 18:29:33'),
(1828, 96, 73, 57, '110-14-2', 110, 'This negative impact is linked to natural resources exploitation in our supply chain related to mining and refining processes of metals and minerals.', '2026-03-10 18:29:33'),
(1829, 96, 73, 57, '110-14-3', 110, 'Mining of metals and minerals in our supply chain impacts ecosystems through land degradation, which can lead to habitat loss and impacts species by causing a decrease in species population size and poten- tially extinction.', '2026-03-10 18:29:33'),
(1830, 96, 73, 57, '110-14-4', 110, 'We have completed a mapping to help us understand potential negative impacts to biodiversity that we may have in our value chain. We continue to explore ways to identify and mitigate impacts across our value chain, including our first attempt at mapping impacts from high impact commodities (HICs) in our upstream value chain.', '2026-03-10 18:29:33'),
(1831, 96, 73, 57, '110-14-5', 110, 'to deliver on our ambition to achieve a net-positive', '2026-03-10 18:29:33'),
(1832, 96, 73, 57, '110-14-6', 110, 'biodiversity impact from all new renewable energy', '2026-03-10 18:29:33'),
(1833, 96, 73, 57, '110-14-7', 110, 'projects from 2030.', '2026-03-10 18:29:33'),
(1834, 104, 73, 57, '109-15-1', 109, 'Mining of metals and minerals in our supply chain is a direct impact driver of biodiversity loss through land-use and freshwater-use change and ecotoxicity from run-off. It also impacts ecosystems through land degradation.', '2026-03-10 18:29:33'),
(1835, 104, 73, 57, '109-15-2', 109, 'Our supply chain has adverse impacts on biodiversity through land-use change due to mining and refining processes of coal and through sea-use change from extraction and refining processes of gas that we primarily source from the North Sea.', '2026-03-10 18:29:33'),
(1836, 117, 73, 57, '110-16-1', 110, 'Species population size decrease and global extinction risk increase due to mining Negative impact (upstream value chain)', '2026-03-10 18:29:33'),
(1837, 117, 73, 57, '110-16-2', 110, 'Mining of metals and minerals in our supply chain impacts ecosystems through land degradation, which can lead to habitat loss and impacts species by causing a decrease in species population size and poten- tially extinction.', '2026-03-10 18:29:33'),
(1838, 119, 73, 57, '110-17-1', 110, 'Species population size decrease and global extinction risk increase due to mining Negative impact (upstream value chain)', '2026-03-10 18:29:33'),
(1839, 119, 73, 57, '110-17-2', 110, 'Mining of metals and minerals in our supply chain impacts ecosystems through land degradation, which can lead to habitat loss and impacts species by causing a decrease in species population size and poten- tially extinction.', '2026-03-10 18:29:33'),
(1840, 120, 73, 57, '110-18-1', 110, 'Species population size decrease and global extinction risk increase due to mining Negative impact (upstream value chain)', '2026-03-10 18:29:33'),
(1841, 120, 73, 57, '110-18-2', 110, 'Mining of metals and minerals in our supply chain impacts ecosystems through land degradation, which can lead to habitat loss and impacts species by causing a decrease in species population size and poten- tially extinction.', '2026-03-10 18:29:33'),
(1842, 121, 73, 57, '110-19-1', 110, 'Species population size decrease and global extinction risk increase due to mining Negative impact (upstream value chain)', '2026-03-10 18:29:33'),
(1843, 121, 73, 57, '110-19-2', 110, 'Mining of metals and minerals in our supply chain impacts ecosystems through land degradation, which can lead to habitat loss and impacts species by causing a decrease in species population size and poten- tially extinction.', '2026-03-10 18:29:33'),
(1844, 122, 73, 57, '110-20-1', 110, 'Species population size decrease and global extinction risk increase due to mining Negative impact (upstream value chain)', '2026-03-10 18:29:33'),
(1845, 122, 73, 57, '110-20-2', 110, 'Mining of metals and minerals in our supply chain impacts ecosystems through land degradation, which can lead to habitat loss and impacts species by causing a decrease in species population size and poten- tially extinction.', '2026-03-10 18:29:33'),
(1846, 13, 73, 57, '110-21-1', 110, 'This negative impact concerns the disturbances of species during the construction of our renewable energy assets.', '2026-03-10 18:29:33'),
(1847, 13, 73, 57, '110-21-2', 110, 'Construction of renewable energy projects causes temporary displace- ment of species, or, in some instances, loss of species through adverse impacts on foraging, breeding, and wintering areas.', '2026-03-10 18:29:33'),
(1848, 17, 73, 57, '110-22-1', 110, 'At an asset level, we prefer to always have a biodiversity action plan in place, which helps us map out our negative impacts and plan out our mitigating actions accordingly. When we identify overlaps with e.g. an IUCN Red-listed species, an action plan is developed to ensure that we reduce harm to this species or any threatened species.', '2026-03-10 18:29:33'),
(1849, 31, 73, 57, '110-23-1', 110, 'Construction of renewable energy projects causes temporary displace- ment of species, or, in some instances, loss of species through adverse impacts on foraging, breeding, and wintering areas.', '2026-03-10 18:29:33'),
(1850, 33, 73, 57, '110-24-1', 110, 'At an asset level, we prefer to always have a biodiversity action plan in place, which helps us map out our negative impacts and plan out our mitigating actions accordingly. When we identify overlaps with e.g. an IUCN Red-listed species, an action plan is developed to ensure that we reduce harm to this species or any threatened species.', '2026-03-10 18:29:33'),
(1851, 33, 73, 57, '110-24-2', 110, 'we can develop action plans to mitigate our impacts', '2026-03-10 18:29:33'),
(1852, 39, 73, 57, '110-25-1', 110, 'stakeholders and their interests into consideration.', '2026-03-10 18:29:33'),
(1853, 40, 73, 57, '110-26-1', 110, 'found it. Therefore, our ambition is to take direct', '2026-03-10 18:29:33'),
(1854, 40, 73, 57, '110-26-2', 110, 'offshore and onshore assets where we are responsible', '2026-03-10 18:29:33'),
(1855, 40, 73, 57, '110-26-3', 110, 'for development, we conduct early risk screenings', '2026-03-10 18:29:33'),
(1856, 40, 73, 57, '110-26-4', 110, 'and develop environmental impact assessments (EIAs)', '2026-03-10 18:29:33'),
(1857, 40, 73, 57, '110-26-5', 110, 'or equivalent plans to assess the potential impacts', '2026-03-10 18:29:33'),
(1858, 40, 73, 57, '110-26-6', 110, 'on biodiversity and ecosystems at the locations', '2026-03-10 18:29:33'),
(1859, 40, 73, 57, '110-26-7', 110, 'of potential new assets. This is then followed by', '2026-03-10 18:29:33'),
(1860, 40, 73, 57, '110-26-8', 110, 'action to be able to achieve a net-positive biodiversity', '2026-03-10 18:29:33'),
(1861, 40, 73, 57, '110-26-9', 110, 'the legally required impact assessment processes,', '2026-03-10 18:29:33'),
(1862, 40, 73, 57, '110-26-10', 110, 'impact from projects commissioned from 2030', '2026-03-10 18:29:33'),
(1863, 40, 73, 57, '110-26-11', 110, 'providing data on the biodiversity and ecosystems', '2026-03-10 18:29:33'),
(1864, 40, 73, 57, '110-26-12', 110, 'onwards. In 2024, we took the first steps towards this', '2026-03-10 18:29:33'),
(1865, 40, 73, 57, '110-26-13', 110, 'present at the site location. Based on these findings,', '2026-03-10 18:29:33'),
(1866, 40, 73, 57, '110-26-14', 110, 'by launching our ‘Biodiversity measurement framework’,', '2026-03-10 18:29:33'),
(1867, 49, 73, 57, '110-27-1', 110, 'onwards. In 2024, we took the first steps towards this', '2026-03-10 18:29:33'),
(1868, 49, 73, 57, '110-27-2', 110, 'by launching our ‘Biodiversity measurement framework’,', '2026-03-10 18:29:33'),
(1869, 52, 73, 57, '110-28-1', 110, 'always adhere to local and national regulations', '2026-03-10 18:29:33'),
(1870, 52, 73, 57, '110-28-2', 110, 'and policies, including those related to biodiversity.', '2026-03-10 18:29:33'),
(1871, 54, 73, 57, '110-29-1', 110, 'At an asset level, we prefer to always have a biodiversity action plan in place, which helps us map out our negative impacts and plan out our mitigating actions accordingly. When we identify overlaps with e.g. an IUCN Red-listed species, an action plan is developed to ensure that we reduce harm to this species or any threatened species.', '2026-03-10 18:29:33'),
(1872, 73, 73, 57, '110-30-1', 110, 'At an asset level, we prefer to always have a biodiversity action plan in place, which helps us map out our negative impacts and plan out our mitigating actions accordingly. When we identify overlaps with e.g. an IUCN Red-listed species, an action plan is developed to ensure that we reduce harm to this species or any threatened species.', '2026-03-10 18:29:33'),
(1873, 73, 73, 57, '110-30-2', 110, 'by launching our ‘Biodiversity measurement framework’,', '2026-03-10 18:29:33'),
(1874, 73, 73, 57, '110-30-3', 110, 'we can develop action plans to mitigate our impacts', '2026-03-10 18:29:33'),
(1875, 73, 73, 57, '110-30-4', 110, 'and outline restoration measures. Insights from the early', '2026-03-10 18:29:33'),
(1876, 90, 73, 57, '110-31-1', 110, 'found it. Therefore, our ambition is to take direct', '2026-03-10 18:29:33'),
(1877, 90, 73, 57, '110-31-2', 110, 'offshore and onshore assets where we are responsible', '2026-03-10 18:29:33'),
(1878, 90, 73, 57, '110-31-3', 110, 'for development, we conduct early risk screenings', '2026-03-10 18:29:33'),
(1879, 90, 73, 57, '110-31-4', 110, 'and develop environmental impact assessments (EIAs)', '2026-03-10 18:29:33'),
(1880, 90, 73, 57, '110-31-5', 110, 'or equivalent plans to assess the potential impacts', '2026-03-10 18:29:33'),
(1881, 90, 73, 57, '110-31-6', 110, 'on biodiversity and ecosystems at the locations', '2026-03-10 18:29:33'),
(1882, 90, 73, 57, '110-31-7', 110, 'of potential new assets. This is then followed by', '2026-03-10 18:29:33'),
(1883, 90, 73, 57, '110-31-8', 110, 'action to be able to achieve a net-positive biodiversity', '2026-03-10 18:29:33'),
(1884, 90, 73, 57, '110-31-9', 110, 'the legally required impact assessment processes,', '2026-03-10 18:29:33'),
(1885, 90, 73, 57, '110-31-10', 110, 'impact from projects commissioned from 2030', '2026-03-10 18:29:33'),
(1886, 121, 73, 57, '110-32-1', 110, 'At an asset level, we prefer to always have a biodiversity action plan in place, which helps us map out our negative impacts and plan out our mitigating actions accordingly. When we identify overlaps with e.g. an IUCN Red-listed species, an action plan is developed to ensure that we reduce harm to this species or any threatened species.', '2026-03-10 18:29:33'),
(1887, 122, 73, 57, '110-33-1', 110, 'At an asset level, we prefer to always have a biodiversity action plan in place, which helps us map out our negative impacts and plan out our mitigating actions accordingly. When we identify overlaps with e.g. an IUCN Red-listed species, an action plan is developed to ensure that we reduce harm to this species or any threatened species.', '2026-03-10 18:29:33'),
(1888, 13, 73, 57, '111-34-1', 111, 'potential impacts and risks to biodiversity and eco-', '2026-03-10 18:29:33'),
(1889, 13, 73, 57, '111-34-2', 111, 'Management of impacts in our own operations At Ørsted, we have sites located in or near biodiversity-', '2026-03-10 18:29:33'),
(1890, 13, 73, 57, '111-34-3', 111, 'One example of an impact that we are sometimes', '2026-03-10 18:29:33'),
(1891, 13, 73, 57, '111-34-4', 111, 'unable to mitigate during the operational phase of an', '2026-03-10 18:29:33'),
(1892, 13, 73, 57, '111-34-5', 111, 'designated areas (including protected areas and', '2026-03-10 18:29:33'),
(1893, 13, 73, 57, '111-34-6', 111, 'systems when developing new renewable energy pro-', '2026-03-10 18:29:33'),
(1894, 15, 73, 57, '111-35-1', 111, 'potential impacts and risks to biodiversity and eco-', '2026-03-10 18:29:33'),
(1895, 15, 73, 57, '111-35-2', 111, 'Management of impacts in our own operations At Ørsted, we have sites located in or near biodiversity-', '2026-03-10 18:29:33'),
(1896, 15, 73, 57, '111-35-3', 111, 'One example of an impact that we are sometimes', '2026-03-10 18:29:33'),
(1897, 15, 73, 57, '111-35-4', 111, 'unable to mitigate during the operational phase of an', '2026-03-10 18:29:33'),
(1898, 15, 73, 57, '111-35-5', 111, 'designated areas (including protected areas and', '2026-03-10 18:29:33'),
(1899, 15, 73, 57, '111-35-6', 111, 'systems when developing new renewable energy pro-', '2026-03-10 18:29:33'),
(1900, 21, 73, 57, '111-36-1', 111, 'impacts and risks of our assets to biodiversity and', '2026-03-10 18:29:33'),
(1901, 21, 73, 57, '111-36-2', 111, 'Additionally, we have not identified any systemic risks', '2026-03-10 18:29:33'),
(1902, 21, 73, 57, '111-36-3', 111, 'to our business model that are not addressed through', '2026-03-10 18:29:33'),
(1903, 21, 73, 57, '111-36-4', 111, 'our established practices or the implementation of', '2026-03-10 18:29:33'),
(1904, 21, 73, 57, '111-36-5', 111, 'measures to reach our biodiversity ambition. A key', '2026-03-10 18:29:33'),
(1905, 31, 73, 57, '111-37-1', 111, 'potential impacts and risks to biodiversity and eco-', '2026-03-10 18:29:33'),
(1906, 31, 73, 57, '111-37-2', 111, 'Management of impacts in our own operations At Ørsted, we have sites located in or near biodiversity-', '2026-03-10 18:29:33'),
(1907, 31, 73, 57, '111-37-3', 111, 'designated areas (including protected areas and', '2026-03-10 18:29:33'),
(1908, 33, 73, 57, '111-38-1', 111, 'impacts and risks of our assets to biodiversity and', '2026-03-10 18:29:33'),
(1909, 33, 73, 57, '111-38-2', 111, 'Additionally, we have not identified any systemic risks', '2026-03-10 18:29:33'),
(1910, 33, 73, 57, '111-38-3', 111, 'to our business model that are not addressed through', '2026-03-10 18:29:33'),
(1911, 33, 73, 57, '111-38-4', 111, 'our established practices or the implementation of', '2026-03-10 18:29:33'),
(1912, 33, 73, 57, '111-38-5', 111, 'measures to reach our biodiversity ambition. A key', '2026-03-10 18:29:33'),
(1913, 52, 73, 57, '111-39-1', 111, 'impacts and risks of our assets to biodiversity and', '2026-03-10 18:29:33'),
(1914, 52, 73, 57, '111-39-2', 111, 'ecosystems continues to inform our DMA. In this pro-', '2026-03-10 18:29:33'),
(1915, 52, 73, 57, '111-39-3', 111, 'cess, we base the identification and scoring of IROs on', '2026-03-10 18:29:33'),
(1916, 52, 73, 57, '111-39-4', 111, 'and opportunities at an asset level, helping us to better', '2026-03-10 18:29:33'),
(1917, 52, 73, 57, '111-39-5', 111, 'our established practices or the implementation of', '2026-03-10 18:29:33'),
(1918, 52, 73, 57, '111-39-6', 111, 'the knowledge gathered across all our offshore and', '2026-03-10 18:29:33'),
(1919, 52, 73, 57, '111-39-7', 111, 'understand which sites are material in this respect.', '2026-03-10 18:29:33'),
(1920, 52, 73, 57, '111-39-8', 111, 'measures to reach our biodiversity ambition. A key', '2026-03-10 18:29:33'),
(1921, 52, 73, 57, '111-39-9', 111, 'onshore assets, enabling a cross-business assessment', '2026-03-10 18:29:33'),
(1922, 52, 73, 57, '111-39-10', 111, 'of impacts, risks, dependencies, and opportunities.', '2026-03-10 18:29:33'),
(1923, 73, 73, 57, '111-40-1', 111, 'impacts and risks of our assets to biodiversity and', '2026-03-10 18:29:33'),
(1924, 73, 73, 57, '111-40-2', 111, 'our established practices or the implementation of', '2026-03-10 18:29:33'),
(1925, 73, 73, 57, '111-40-3', 111, 'measures to reach our biodiversity ambition. A key', '2026-03-10 18:29:33'),
(1926, 73, 73, 57, '111-40-4', 111, 'outcome of our biodiversity programme has been', '2026-03-10 18:29:33'),
(1927, 90, 73, 57, '111-41-1', 111, 'work and our progress towards being ready to set', '2026-03-10 18:29:33'),
(1928, 90, 73, 57, '111-41-2', 111, 'science-based targets for nature.', '2026-03-10 18:29:33'),
(1929, 90, 73, 57, '111-41-3', 111, 'the development of our ‘Biodiversity measurement', '2026-03-10 18:29:33'),
(1930, 90, 73, 57, '111-41-4', 111, 'framework’, which will ensure that we can capture all', '2026-03-10 18:29:33'),
(1931, 90, 73, 57, '111-41-5', 111, 'potential impacts and risks to biodiversity and eco-', '2026-03-10 18:29:33'),
(1932, 13, 73, 57, '111-42-1', 111, 'as birds or bats, with wind turbine blades. In cases', '2026-03-10 18:29:33'),
(1933, 13, 73, 57, '111-42-2', 111, 'that there are potential negative impacts on biodiver-', '2026-03-10 18:29:33'),
(1934, 15, 73, 57, '111-43-1', 111, 'tems at all our site locations. When we identify over-', '2026-03-10 18:29:33'),
(1935, 15, 73, 57, '111-43-2', 111, 'laps with e.g. an IUCN Red-listed species, an action', '2026-03-10 18:29:33'),
(1936, 15, 73, 57, '111-43-3', 111, 'plan is developed to ensure that we do no significant', '2026-03-10 18:29:33'),
(1937, 15, 73, 57, '111-43-4', 111, 'harm to this species, nor any threatened species, both', '2026-03-10 18:29:33'),
(1938, 17, 73, 57, '111-44-1', 111, 'laps with e.g. an IUCN Red-listed species, an action', '2026-03-10 18:29:33'),
(1939, 17, 73, 57, '111-44-2', 111, 'plan is developed to ensure that we do no significant', '2026-03-10 18:29:33'),
(1940, 17, 73, 57, '111-44-3', 111, 'harm to this species, nor any threatened species, both', '2026-03-10 18:29:33'),
(1941, 21, 73, 57, '111-45-1', 111, 'We have not completed an assessment of how', '2026-03-10 18:29:33'),
(1942, 21, 73, 57, '111-45-2', 111, 'systemic risks to society have been considered in the', '2026-03-10 18:29:33'),
(1943, 31, 73, 57, '111-46-1', 111, 'tems at all our site locations. When we identify over-', '2026-03-10 18:29:33'),
(1944, 31, 73, 57, '111-46-2', 111, 'laps with e.g. an IUCN Red-listed species, an action', '2026-03-10 18:29:33'),
(1945, 33, 73, 57, '111-47-1', 111, 'We adhere to the mitigation hierarchy in the develop-', '2026-03-10 18:29:33'),
(1946, 33, 73, 57, '111-47-2', 111, 'and ensuring we are undertaking the actions needed', '2026-03-10 18:29:33'),
(1947, 33, 73, 57, '111-47-3', 111, 'plan is developed to ensure that we do no significant', '2026-03-10 18:29:33'),
(1948, 33, 73, 57, '111-47-4', 111, 'vided an overview of impacts based on our most', '2026-03-10 18:29:33'),
(1949, 33, 73, 57, '111-47-5', 111, 'ment of new projects, prioritising to avoid biodiversity', '2026-03-10 18:29:33'),
(1950, 33, 73, 57, '111-47-6', 111, 'to avoid and mitigate impacts on biodiversity. //', '2026-03-10 18:29:33'),
(1951, 39, 73, 57, '111-48-1', 111, 'holder groups.', '2026-03-10 18:29:33'),
(1952, 49, 73, 57, '111-49-1', 111, 'was completed in 2022 using the Global Biodiversity', '2026-03-10 18:29:33'),
(1953, 49, 73, 57, '111-49-2', 111, 'Score tool is still relevant today. The results pro-', '2026-03-10 18:29:33'),
(1954, 51, 73, 57, '111-50-1', 111, 'We have not completed an assessment of how', '2026-03-10 18:29:33'),
(1955, 51, 73, 57, '111-50-2', 111, 'systemic risks to society have been considered in the', '2026-03-10 18:29:33'),
(1956, 52, 73, 57, '111-51-1', 111, 'applying our ‘Biodiversity policy’, we will be able', '2026-03-10 18:29:33'),
(1957, 52, 73, 57, '111-51-2', 111, 'to avoid any impacts related to the deterioration', '2026-03-10 18:29:33'),
(1958, 54, 73, 57, '111-52-1', 111, 'applying our ‘Biodiversity policy’, we will be able', '2026-03-10 18:29:33'),
(1959, 54, 73, 57, '111-52-2', 111, 'to avoid any impacts related to the deterioration', '2026-03-10 18:29:33'),
(1960, 73, 73, 57, '111-53-1', 111, 'We adhere to the mitigation hierarchy in the develop-', '2026-03-10 18:29:33'),
(1961, 73, 73, 57, '111-53-2', 111, 'and ensuring we are undertaking the actions needed', '2026-03-10 18:29:33'),
(1962, 73, 73, 57, '111-53-3', 111, 'plan is developed to ensure that we do no significant', '2026-03-10 18:29:33'),
(1963, 73, 73, 57, '111-53-4', 111, 'vided an overview of impacts based on our most', '2026-03-10 18:29:33'),
(1964, 73, 73, 57, '111-53-5', 111, 'ment of new projects, prioritising to avoid biodiversity', '2026-03-10 18:29:33'),
(1965, 73, 73, 57, '111-53-6', 111, 'to avoid and mitigate impacts on biodiversity. //', '2026-03-10 18:29:33'),
(1966, 74, 73, 57, '111-54-1', 111, 'We adhere to the mitigation hierarchy in the develop-', '2026-03-10 18:29:33'),
(1967, 74, 73, 57, '111-54-2', 111, 'and ensuring we are undertaking the actions needed', '2026-03-10 18:29:33'),
(1968, 74, 73, 57, '111-54-3', 111, 'plan is developed to ensure that we do no significant', '2026-03-10 18:29:33'),
(1969, 74, 73, 57, '111-54-4', 111, 'vided an overview of impacts based on our most', '2026-03-10 18:29:33'),
(1970, 74, 73, 57, '111-54-5', 111, 'ment of new projects, prioritising to avoid biodiversity', '2026-03-10 18:29:33'),
(1971, 74, 73, 57, '111-54-6', 111, 'to avoid and mitigate impacts on biodiversity. //', '2026-03-10 18:29:33'),
(1972, 121, 73, 57, '111-55-1', 111, 'laps with e.g. an IUCN Red-listed species, an action', '2026-03-10 18:29:33'),
(1973, 26, 73, 57, '112-56-1', 112, 'direct impact drivers of biodiversity loss due to extrac-', '2026-03-10 18:29:33'),
(1974, 26, 73, 57, '112-56-2', 112, 'on their progress on working with biodiversity, similar', '2026-03-10 18:29:33'),
(1975, 26, 73, 57, '112-56-3', 112, 'planning and restoration of impacts, we have found', '2026-03-10 18:29:33'),
(1976, 26, 73, 57, '112-56-4', 112, 'that we have no negative impacts on biodiversity and', '2026-03-10 18:29:33'),
(1977, 31, 73, 57, '112-57-1', 112, 'during the construction phase.', '2026-03-10 18:29:33'),
(1978, 31, 73, 57, '112-57-2', 112, 'The scope of the policy covers all of Ørsted’s renewable', '2026-03-10 18:29:33'),
(1979, 31, 73, 57, '112-57-3', 112, 'business, the policy includes an overview of the', '2026-03-10 18:29:33'),
(1980, 31, 73, 57, '112-57-4', 112, 'areas or KBAs. This is the majority of our assets and', '2026-03-10 18:29:33'),
(1981, 31, 73, 57, '112-57-5', 112, 'energy assets, both offshore and onshore, and includes', '2026-03-10 18:29:33'),
(1982, 31, 73, 57, '112-57-6', 112, 'governance structure to support its implementation', '2026-03-10 18:29:33'),
(1983, 31, 73, 57, '112-57-7', 112, 'is connected to the fact that a buffer zone has been', '2026-03-10 18:29:33'),
(1984, 31, 73, 57, '112-57-8', 112, 'applied (25 km for offshore assets, 10 km for onshore', '2026-03-10 18:29:33'),
(1985, 31, 73, 57, '112-57-9', 112, 'Material impacts in our value chain We have identified material negative impacts in our', '2026-03-10 18:29:33'),
(1986, 31, 73, 57, '112-57-10', 112, 'our initial steps towards addressing biodiversity in our', '2026-03-10 18:29:33'),
(1987, 33, 73, 57, '111-58-1', 111, 'during construction and the operational phase.', '2026-03-10 18:29:33'),
(1988, 33, 73, 57, '111-58-2', 111, 'each material impacts the environment, focusing', '2026-03-10 18:29:33'),
(1989, 33, 73, 57, '111-58-3', 111, 'be entirely avoided, we focus on minimising and', '2026-03-10 18:29:33'),
(1990, 33, 73, 57, '111-58-4', 111, 'on biodiversity. The assessment did not include an', '2026-03-10 18:29:33'),
(1991, 33, 73, 57, '111-58-5', 111, 'mitigating them to the extent possible. An example of', '2026-03-10 18:29:33'),
(1992, 39, 73, 57, '112-59-1', 112, 'to our approach with decarbonisation.', '2026-03-10 18:29:33'),
(1993, 39, 73, 57, '112-59-2', 112, 'Interests of key stakeholders Similar to the development of our biodiversity projects', '2026-03-10 18:29:33'),
(1994, 52, 73, 57, '112-60-1', 112, 'operations on biodiversity, ecosystem protection, and', '2026-03-10 18:29:33'),
(1995, 52, 73, 57, '112-60-2', 112, 'Policy governance Accountability of the policy lies with the Chief', '2026-03-10 18:29:33'),
(1996, 54, 73, 57, '112-61-1', 112, 'during the construction phase.', '2026-03-10 18:29:33'),
(1997, 54, 73, 57, '112-61-2', 112, 'The scope of the policy covers all of Ørsted’s renewable', '2026-03-10 18:29:33'),
(1998, 54, 73, 57, '112-61-3', 112, 'business, the policy includes an overview of the', '2026-03-10 18:29:33'),
(1999, 54, 73, 57, '112-61-4', 112, 'areas or KBAs. This is the majority of our assets and', '2026-03-10 18:29:33'),
(2000, 54, 73, 57, '112-61-5', 112, 'energy assets, both offshore and onshore, and includes', '2026-03-10 18:29:33'),
(2001, 54, 73, 57, '112-61-6', 112, 'governance structure to support its implementation', '2026-03-10 18:29:33'),
(2002, 54, 73, 57, '112-61-7', 112, 'is connected to the fact that a buffer zone has been', '2026-03-10 18:29:33'),
(2003, 54, 73, 57, '112-61-8', 112, 'applied (25 km for offshore assets, 10 km for onshore', '2026-03-10 18:29:33'),
(2004, 54, 73, 57, '112-61-9', 112, 'Material impacts in our value chain We have identified material negative impacts in our', '2026-03-10 18:29:33'),
(2005, 54, 73, 57, '112-61-10', 112, 'our initial steps towards addressing biodiversity in our', '2026-03-10 18:29:33'),
(2006, 61, 73, 57, '112-62-1', 112, 'as well as specific third-party standards that support', '2026-03-10 18:29:33'),
(2007, 61, 73, 57, '112-62-2', 112, 'our work, e.g. the EU taxonomy for sustainable', '2026-03-10 18:29:33'),
(2008, 61, 73, 57, '112-62-3', 112, 'assets), increasing the amount of overlaps with both', '2026-03-10 18:29:33'),
(2009, 61, 73, 57, '112-62-4', 112, 'upstream value chain. These impacts are primarily', '2026-03-10 18:29:33'),
(2010, 61, 73, 57, '112-62-5', 112, 'specifically, we engage with some of our tier 1 suppliers', '2026-03-10 18:29:33'),
(2011, 61, 73, 57, '112-62-6', 112, 'economic activities.', '2026-03-10 18:29:33'),
(2012, 69, 73, 57, '112-63-1', 112, 'during the construction phase.', '2026-03-10 18:29:33'),
(2013, 69, 73, 57, '112-63-2', 112, 'The scope of the policy covers all of Ørsted’s renewable', '2026-03-10 18:29:33'),
(2014, 69, 73, 57, '112-63-3', 112, 'business, the policy includes an overview of the', '2026-03-10 18:29:33'),
(2015, 69, 73, 57, '112-63-4', 112, 'areas or KBAs. This is the majority of our assets and', '2026-03-10 18:29:33'),
(2016, 69, 73, 57, '112-63-5', 112, 'energy assets, both offshore and onshore, and includes', '2026-03-10 18:29:33'),
(2017, 69, 73, 57, '112-63-6', 112, 'governance structure to support its implementation', '2026-03-10 18:29:33'),
(2018, 69, 73, 57, '112-63-7', 112, 'is connected to the fact that a buffer zone has been', '2026-03-10 18:29:33'),
(2019, 69, 73, 57, '112-63-8', 112, 'applied (25 km for offshore assets, 10 km for onshore', '2026-03-10 18:29:33'),
(2020, 69, 73, 57, '112-63-9', 112, 'Material impacts in our value chain We have identified material negative impacts in our', '2026-03-10 18:29:33'),
(2021, 69, 73, 57, '112-63-10', 112, 'our initial steps towards addressing biodiversity in our', '2026-03-10 18:29:33'),
(2022, 71, 73, 57, '112-64-1', 112, 'sustainable ocean practices.', '2026-03-10 18:29:33'),
(2023, 71, 73, 57, '112-64-2', 112, 'Commercial Officer (CCO). To ensure that our policy', '2026-03-10 18:29:33'),
(2024, 71, 73, 57, '112-64-3', 112, 'and onshore wind, solar PV, and power stations) that', '2026-03-10 18:29:33'),
(2025, 71, 73, 57, '112-64-4', 112, 'potential impacts on land degradation are mitigated', '2026-03-10 18:29:33'),
(2026, 71, 73, 57, '112-64-5', 112, 'is implemented and taken into account across our', '2026-03-10 18:29:33'),
(2027, 71, 73, 57, '112-64-6', 112, 'currently overlap with or are adjacent to protected', '2026-03-10 18:29:33'),
(2028, 73, 73, 57, '112-65-1', 112, 'direct impact drivers of biodiversity loss due to extrac-', '2026-03-10 18:29:33'),
(2029, 73, 73, 57, '112-65-2', 112, 'on their progress on working with biodiversity, similar', '2026-03-10 18:29:33'),
(2030, 73, 73, 57, '112-65-3', 112, 'planning and restoration of impacts, we have found', '2026-03-10 18:29:33'),
(2031, 73, 73, 57, '112-65-4', 112, 'that we have no negative impacts on biodiversity and', '2026-03-10 18:29:33'),
(2032, 74, 73, 57, '111-66-1', 111, 'during construction and the operational phase.', '2026-03-10 18:29:33'),
(2033, 74, 73, 57, '111-66-2', 111, 'each material impacts the environment, focusing', '2026-03-10 18:29:33'),
(2034, 74, 73, 57, '111-66-3', 111, 'be entirely avoided, we focus on minimising and', '2026-03-10 18:29:33'),
(2035, 74, 73, 57, '111-66-4', 111, 'on biodiversity. The assessment did not include an', '2026-03-10 18:29:33'),
(2036, 74, 73, 57, '111-66-5', 111, 'mitigating them to the extent possible. An example of', '2026-03-10 18:29:33'),
(2037, 54, 73, 57, '112-67-1', 112, 'material extraction in our upstream value chain. How-', '2026-03-10 18:29:33'),
(2038, 54, 73, 57, '112-67-2', 112, 'our biodiversity policy. For example, local communities,', '2026-03-10 18:29:33'),
(2039, 54, 73, 57, '112-67-3', 112, 'In addition to the operational sites, we had 12 assets', '2026-03-10 18:29:33'),
(2040, 39, 73, 57, '112-68-1', 112, 'of biodiversity- and ecosystems-related impacts in our', '2026-03-10 18:29:33'),
(2041, 39, 73, 57, '112-68-2', 112, 'ever, we are committed to working with our suppliers', '2026-03-10 18:29:33'),
(2042, 39, 73, 57, '112-68-3', 112, 'NGOs, and academia are included in the stakeholder', '2026-03-10 18:29:33'),
(2043, 39, 73, 57, '112-68-4', 112, 'under construction in 2024, which were identified as', '2026-03-10 18:29:33'),
(2044, 39, 73, 57, '112-68-5', 112, 'upstream value chain, using global average data for', '2026-03-10 18:29:33'),
(2045, 74, 73, 57, '112-69-1', 112, 'energy assets, just as our peers in the industry. How-', '2026-03-10 18:29:33'),
(2046, 74, 73, 57, '112-69-2', 112, 'ever, we acknowledge the trade-offs of mining in the', '2026-03-10 18:29:33'),
(2047, 74, 73, 57, '112-69-3', 112, 'Further tiers down in the value chain, it becomes', '2026-03-10 18:29:33'),
(2048, 74, 73, 57, '112-69-4', 112, 'Management and mitigation hierarchy Our business model is to develop, construct, operate,', '2026-03-10 18:29:33'),
(2049, 74, 73, 57, '112-69-5', 112, 'construction sites, biodiversity impacts were primarily', '2026-03-10 18:29:33'),
(2050, 74, 73, 57, '112-69-6', 112, 'value chain, which we actively work towards manag-', '2026-03-10 18:29:33'),
(2051, 74, 73, 57, '112-69-7', 112, 'more challenging to mitigate the inherent impacts on', '2026-03-10 18:29:33'),
(2052, 74, 73, 57, '112-69-8', 112, 'and own renewable assets, and we are committed to', '2026-03-10 18:29:33'),
(2053, 74, 73, 57, '112-69-9', 112, 'associated with monopile piling, which generates noise', '2026-03-10 18:29:33'),
(2054, 74, 73, 57, '112-69-10', 112, 'ing. As mentioned before, we are actively engaging', '2026-03-10 18:29:33'),
(2055, 52, 73, 57, '112-70-1', 112, '// E4-2 Policies related to biodiversity and ecosystems', '2026-03-10 18:29:33'),
(2056, 52, 73, 57, '112-70-2', 112, 'of biodiversity to Ørsted and how we believe that bio-', '2026-03-10 18:29:33'),
(2057, 52, 73, 57, '112-70-3', 112, 'diversity is a key part of a sustainable project life cycle.', '2026-03-10 18:29:33'),
(2058, 52, 73, 57, '112-70-4', 112, 'The policy also explains the steps we take to protect', '2026-03-10 18:29:33'),
(2059, 52, 73, 57, '112-70-5', 112, 'biodiversity throughout an asset’s life cycle, aiming to', '2026-03-10 18:29:33'),
(2060, 31, 73, 57, '112-71-1', 112, 'including sites in or near biodiversity-sensitive areas.', '2026-03-10 18:29:33'),
(2061, 33, 73, 57, '113-72-1', 113, 'mise impacts, and take restorative measures where', '2026-03-10 18:29:33'),
(2062, 33, 73, 57, '113-72-2', 113, 'impacts cannot be avoided. We also compensate for', '2026-03-10 18:29:33'),
(2063, 33, 73, 57, '113-72-3', 113, 'any residual adverse impacts that cannot be restored', '2026-03-10 18:29:33'),
(2064, 73, 73, 57, '113-73-1', 113, 'mise impacts, and take restorative measures where', '2026-03-10 18:29:33'),
(2065, 73, 73, 57, '113-73-2', 113, 'impacts cannot be avoided. We also compensate for', '2026-03-10 18:29:33'),
(2066, 73, 73, 57, '113-73-3', 113, 'Key actions Launching our biodiversity measurement framework', '2026-03-10 18:29:33'),
(2067, 73, 73, 57, '113-73-4', 113, 'any residual adverse impacts that cannot be restored', '2026-03-10 18:29:33'),
(2068, 74, 73, 57, '113-74-1', 113, 'mise impacts, and take restorative measures where', '2026-03-10 18:29:33'),
(2069, 74, 73, 57, '113-74-2', 113, 'impacts cannot be avoided. We also compensate for', '2026-03-10 18:29:33'),
(2070, 74, 73, 57, '113-74-3', 113, 'any residual adverse impacts that cannot be restored', '2026-03-10 18:29:33'),
(2071, 75, 73, 57, '113-75-1', 113, 'impacts cannot be avoided. We also compensate for', '2026-03-10 18:29:33'),
(2072, 75, 73, 57, '113-75-2', 113, 'Key actions Launching our biodiversity measurement framework', '2026-03-10 18:29:33'),
(2073, 75, 73, 57, '113-75-3', 113, 'any residual adverse impacts that cannot be restored', '2026-03-10 18:29:33'),
(2074, 90, 73, 57, '113-76-1', 113, 'we should work towards setting science-based targets', '2026-03-10 18:29:33'),
(2075, 90, 73, 57, '113-76-2', 113, 'Key actions Launching our biodiversity measurement framework', '2026-03-10 18:29:33'),
(2076, 90, 73, 57, '113-76-3', 113, 'across impacts, which is then used to set time-bound', '2026-03-10 18:29:33'),
(2077, 90, 73, 57, '113-76-4', 113, 'In 2024, we publicly launched our biodiversity meas-', '2026-03-10 18:29:33'),
(2078, 90, 73, 57, '113-76-5', 113, 'targets. Going forward, we will work towards setting', '2026-03-10 18:29:33'),
(2079, 49, 73, 57, '113-77-1', 113, 'Key actions Launching our biodiversity measurement framework', '2026-03-10 18:29:33'),
(2080, 49, 73, 57, '113-77-2', 113, 'In 2024, we publicly launched our biodiversity meas-', '2026-03-10 18:29:33'),
(2081, 18, 73, 57, '113-78-1', 113, 'can measure, track, and report both the positive and', '2026-03-10 18:29:33'),
(2082, 18, 73, 57, '113-78-2', 113, 'negative impacts on biodiversity. The scope covers', '2026-03-10 18:29:33'),
(2083, 26, 73, 57, '113-79-1', 113, 'Thirdly, we have developed a new method to install', '2026-03-10 18:29:33'),
(2084, 26, 73, 57, '113-79-2', 113, 'offshore wind foundations, reducing noise levels by', '2026-03-10 18:29:33'),
(2085, 26, 73, 57, '113-79-3', 113, 'up to 99 %. It represents one of the greatest advance-', '2026-03-10 18:29:33'),
(2086, 33, 73, 57, '113-80-1', 113, 'Thirdly, we have developed a new method to install', '2026-03-10 18:29:33'),
(2087, 33, 73, 57, '113-80-2', 113, 'offshore wind foundations, reducing noise levels by', '2026-03-10 18:29:33'),
(2088, 33, 73, 57, '113-80-3', 113, 'up to 99 %. It represents one of the greatest advance-', '2026-03-10 18:29:33'),
(2089, 39, 73, 57, '113-81-1', 113, 'engage with local communities in our biodiversity-', '2026-03-10 18:29:33'),
(2090, 44, 73, 57, '113-82-1', 113, 'features are irreplaceable and therefore cannot be', '2026-03-10 18:29:33'),
(2091, 44, 73, 57, '113-82-2', 113, 'Secondly, at our offshore wind site Borssele in the', '2026-03-10 18:29:33'),
(2092, 44, 73, 57, '113-82-3', 113, 'compensated. //', '2026-03-10 18:29:33'),
(2093, 44, 73, 57, '113-82-4', 113, 'Netherlands, we placed cod pipes to simulate reefs', '2026-03-10 18:29:33'),
(2094, 71, 73, 57, '113-83-1', 113, 'Thirdly, we have developed a new method to install', '2026-03-10 18:29:33'),
(2095, 71, 73, 57, '113-83-2', 113, 'offshore wind foundations, reducing noise levels by', '2026-03-10 18:29:33'),
(2096, 71, 73, 57, '113-83-3', 113, 'up to 99 %. It represents one of the greatest advance-', '2026-03-10 18:29:33'),
(2097, 74, 73, 57, '113-84-1', 113, 'features are irreplaceable and therefore cannot be', '2026-03-10 18:29:33'),
(2098, 74, 73, 57, '113-84-2', 113, 'compensated. //', '2026-03-10 18:29:33'),
(2099, 88, 73, 57, '113-85-1', 113, 'Forum (WEF) to launch the Responsible Renewables', '2026-03-10 18:29:33'),
(2100, 88, 73, 57, '113-85-2', 113, 'Infrastructure initiative (RRI). This initiative aims to', '2026-03-10 18:29:33'),
(2101, 88, 73, 57, '113-85-3', 113, 'bring together the renewable energy industry to build', '2026-03-10 18:29:33'),
(2102, 89, 73, 57, '113-86-1', 113, 'Forum (WEF) to launch the Responsible Renewables', '2026-03-10 18:29:33'),
(2103, 89, 73, 57, '113-86-2', 113, 'Infrastructure initiative (RRI). This initiative aims to', '2026-03-10 18:29:33'),
(2104, 89, 73, 57, '113-86-3', 113, 'bring together the renewable energy industry to build', '2026-03-10 18:29:33'),
(2105, 49, 73, 57, '113-87-1', 113, 'building an approach to measure impacts on biodiver-', '2026-03-10 18:29:33'),
(2106, 49, 73, 57, '113-87-2', 113, 'the process of utilising the methodology from SBTN', '2026-03-10 18:29:33'),
(2107, 73, 73, 57, '113-88-1', 113, 'example of coastal ecosystem restoration, a nature-', '2026-03-10 18:29:33'),
(2108, 73, 73, 57, '113-88-2', 113, 'based solution that contributes to the sequestration', '2026-03-10 18:29:33'),
(2109, 73, 73, 57, '113-88-3', 113, 'Piloting net-positive solutions', '2026-03-10 18:29:33'),
(2110, 73, 73, 57, '113-88-4', 113, 'monitoring across our biodiversity pilot projects.', '2026-03-10 18:29:33'),
(2111, 73, 73, 57, '113-88-5', 113, 'Our global portfolio of innovative projects contributes', '2026-03-10 18:29:33'),
(2112, 73, 73, 57, '113-88-6', 113, 'with learnings to enhance nature and thereby to', '2026-03-10 18:29:33'),
(2113, 73, 73, 57, '113-88-7', 113, 'achieve our net-positive ambition. In Taiwan, for', '2026-03-10 18:29:33'),
(2114, 75, 73, 57, '113-89-1', 113, '2024, we have not incorporated biodiversity offsets', '2026-03-10 18:29:33'),
(2115, 90, 73, 57, '113-90-1', 113, 'Currently, we have not adopted any targets for', '2026-03-10 18:29:33'),
(2116, 90, 73, 57, '113-90-2', 113, 'biodiver sity that follows the mandatory minimum', '2026-03-10 18:29:33'),
(2117, 90, 73, 57, '113-90-3', 113, 'work is complete, we will proceed with setting targets', '2026-03-10 18:29:33'),
(2118, 90, 73, 57, '113-90-4', 113, 'for biodiversity. //', '2026-03-10 18:29:33'),
(2119, 12, 73, 57, '114-91-1', 114, 'During our DMA, we concluded that we have material impacts on biodiversity, which happen during the construction phase of our projects. Therefore, the data presented in this table represents material sites with construction activities in 2024 where overlaps are present. The biodiversity data covers offshore and onshore wind farms and solar farms as well as their cable routes within the buffer zones.', '2026-03-10 18:29:33'),
(2120, 13, 73, 57, '114-92-1', 114, 'Piling, cable laying, vessel traffic, noise pollution, sedimentation, temporary displacement of species, and temporary disturbances to habitats.', '2026-03-10 18:29:33');
INSERT INTO `esrs_reportvalue` (`id`, `requirement_id`, `report_id`, `job_id`, `page_id`, `page`, `text`, `timestamp`) VALUES
(2121, 14, 73, 57, '114-93-1', 114, 'During our DMA, we concluded that we have material impacts on biodiversity, which happen during the construction phase of our projects. Therefore, the data presented in this table represents material sites with construction activities in 2024 where overlaps are present. The biodiversity data covers offshore and onshore wind farms and solar farms as well as their cable routes within the buffer zones.', '2026-03-10 18:29:33'),
(2122, 15, 73, 57, '114-94-1', 114, 'During our DMA, we concluded that we have material impacts on biodiversity, which happen during the construction phase of our projects. Therefore, the data presented in this table represents material sites with construction activities in 2024 where overlaps are present. The biodiversity data covers offshore and onshore wind farms and solar farms as well as their cable routes within the buffer zones.', '2026-03-10 18:29:33'),
(2123, 15, 73, 57, '114-94-2', 114, 'For offshore wind farms, a buffer zone of 25 km is applied, whereas the buffer zone is 10 km for onshore wind and solar farms. These buffers have been determined based on best practice rooted in science and to recognise relevant interactions with protected areas for nature conservation or key biodiversity areas.', '2026-03-10 18:29:33'),
(2124, 16, 73, 57, '114-95-1', 114, 'Land clearing, temporary disturbances to habitats, temporary displacement of species, cable laying, operating machinery, and noise pollution.', '2026-03-10 18:29:33'),
(2125, 31, 73, 57, '114-96-1', 114, 'During our DMA, we concluded that we have material impacts on biodiversity, which happen during the construction phase of our projects. Therefore, the data presented in this table represents material sites with construction activities in 2024 where overlaps are present. The biodiversity data covers offshore and onshore wind farms and solar farms as well as their cable routes within the buffer zones.', '2026-03-10 18:29:33'),
(2126, 31, 73, 57, '114-96-2', 114, 'For offshore wind farms, a buffer zone of 25 km is applied, whereas the buffer zone is 10 km for onshore wind and solar farms. These buffers have been determined based on best practice rooted in science and to recognise relevant interactions with protected areas for nature conservation or key biodiversity areas.', '2026-03-10 18:29:33'),
(2127, 32, 73, 57, '114-97-1', 114, 'Piling, cable laying, vessel traffic, noise pollution, sedimentation, temporary displacement of species, and temporary disturbances to habitats.', '2026-03-10 18:29:33'),
(2128, 32, 73, 57, '114-97-2', 114, 'During our DMA, we concluded that we have material impacts on biodiversity, which happen during the construction phase of our projects. Therefore, the data presented in this table represents material sites with construction activities in 2024 where overlaps are present. The biodiversity data covers offshore and onshore wind farms and solar farms as well as their cable routes within the buffer zones.', '2026-03-10 18:29:33'),
(2129, 101, 73, 57, '114-98-1', 114, 'or loss of species. The name of the sites, the size of', '2026-03-10 18:29:33'),
(2130, 101, 73, 57, '114-98-2', 114, 'them, including the buffer zones, and the number of', '2026-03-10 18:29:33'),
(2131, 101, 73, 57, '114-98-3', 114, 'protected areas are listed in the table.', '2026-03-10 18:29:33'),
(2132, 102, 73, 57, '114-99-1', 114, 'Data is recognised from the date of the final investment decision (FID), and the area in hectare is showed for the asset in its entirety.', '2026-03-10 18:29:33'),
(2133, 33, 73, 57, '119-100-1', 119, 'for potential future application at our offshore wind', '2026-03-10 18:29:33'),
(2134, 33, 73, 57, '119-100-2', 119, 'circularity- related supplier requirements in place within', '2026-03-10 18:29:33'),
(2135, 33, 73, 57, '119-100-3', 119, 'farms. The TP cover is temporarily installed to shield', '2026-03-10 18:29:33'),
(2136, 33, 73, 57, '119-100-4', 119, 'the next four to five years. For selected components,', '2026-03-10 18:29:33'),
(2137, 33, 73, 57, '119-100-5', 119, 'Furthermore, to increase the reuse of minor com-', '2026-03-10 18:29:33'),
(2138, 33, 73, 57, '119-100-6', 119, 'against water and to save seabirds from getting', '2026-03-10 18:29:33'),
(2139, 33, 73, 57, '119-100-7', 119, 'recycled materials have already been introduced as', '2026-03-10 18:29:33'),
(2140, 33, 73, 57, '119-100-8', 119, 'ponents and spare parts, we have successfully con-', '2026-03-10 18:29:33'),
(2141, 59, 73, 57, '119-101-1', 119, 'for potential future application at our offshore wind', '2026-03-10 18:29:33'),
(2142, 59, 73, 57, '119-101-2', 119, 'circularity- related supplier requirements in place within', '2026-03-10 18:29:33'),
(2143, 59, 73, 57, '119-101-3', 119, 'farms. The TP cover is temporarily installed to shield', '2026-03-10 18:29:33'),
(2144, 59, 73, 57, '119-101-4', 119, 'the next four to five years. For selected components,', '2026-03-10 18:29:33'),
(2145, 59, 73, 57, '119-101-5', 119, 'Furthermore, to increase the reuse of minor com-', '2026-03-10 18:29:33'),
(2146, 59, 73, 57, '119-101-6', 119, 'against water and to save seabirds from getting', '2026-03-10 18:29:33'),
(2147, 59, 73, 57, '119-101-7', 119, 'recycled materials have already been introduced as', '2026-03-10 18:29:33'),
(2148, 59, 73, 57, '119-101-8', 119, 'ponents and spare parts, we have successfully con-', '2026-03-10 18:29:33'),
(2149, 73, 73, 57, '119-102-1', 119, 'for potential future application at our offshore wind', '2026-03-10 18:29:33'),
(2150, 73, 73, 57, '119-102-2', 119, 'circularity- related supplier requirements in place within', '2026-03-10 18:29:33'),
(2151, 73, 73, 57, '119-102-3', 119, 'farms. The TP cover is temporarily installed to shield', '2026-03-10 18:29:33'),
(2152, 73, 73, 57, '119-102-4', 119, 'the next four to five years. For selected components,', '2026-03-10 18:29:33'),
(2153, 73, 73, 57, '119-102-5', 119, 'Furthermore, to increase the reuse of minor com-', '2026-03-10 18:29:33'),
(2154, 73, 73, 57, '119-102-6', 119, 'against water and to save seabirds from getting', '2026-03-10 18:29:33'),
(2155, 73, 73, 57, '119-102-7', 119, 'recycled materials have already been introduced as', '2026-03-10 18:29:33'),
(2156, 73, 73, 57, '119-102-8', 119, 'ponents and spare parts, we have successfully con-', '2026-03-10 18:29:33'),
(2157, 86, 73, 57, '119-103-1', 119, 'the foundation and the mounting of the wind turbine', '2026-03-10 18:29:33'),
(2158, 86, 73, 57, '119-103-2', 119, 'tower, where the inner parts of the foundation are', '2026-03-10 18:29:33'),
(2159, 86, 73, 57, '119-103-3', 119, 'via our partner Wind Cluster. With this trial, we now', '2026-03-10 18:29:33'),
(2160, 86, 73, 57, '119-103-4', 119, 'exposed to wind and water elements at offshore sites.', '2026-03-10 18:29:33'),
(2161, 86, 73, 57, '119-103-5', 119, 'Repairing and refurbishing spare parts for our wind', '2026-03-10 18:29:33'),
(2162, 86, 73, 57, '119-103-6', 119, 'have a blueprint set-up to scale our efforts to other', '2026-03-10 18:29:33'),
(2163, 88, 73, 57, '119-104-1', 119, 'with wind turbine manufacturer Siemens Gamesa to', '2026-03-10 18:29:33'),
(2164, 88, 73, 57, '119-104-2', 119, 'use recycled glass fibres for certain new wind turbine', '2026-03-10 18:29:33'),
(2165, 88, 73, 57, '119-104-3', 119, 'technically approved refurbishment loops for more', '2026-03-10 18:29:33'),
(2166, 88, 73, 57, '119-104-4', 119, 'than 100 of our key minor components, reducing', '2026-03-10 18:29:33'),
(2167, 88, 73, 57, '119-104-5', 119, 'ration of reuse and recycling markets for our compo-', '2026-03-10 18:29:33'),
(2168, 88, 73, 57, '119-105-1', 119, 'the foundation and the mounting of the wind turbine', '2026-03-10 18:29:33'),
(2169, 88, 73, 57, '119-105-2', 119, 'tower, where the inner parts of the foundation are', '2026-03-10 18:29:33'),
(2170, 88, 73, 57, '119-105-3', 119, 'via our partner Wind Cluster. With this trial, we now', '2026-03-10 18:29:33'),
(2171, 88, 73, 57, '119-105-4', 119, 'exposed to wind and water elements at offshore sites.', '2026-03-10 18:29:33'),
(2172, 88, 73, 57, '119-105-5', 119, 'Repairing and refurbishing spare parts for our wind', '2026-03-10 18:29:33'),
(2173, 88, 73, 57, '119-105-6', 119, 'have a blueprint set-up to scale our efforts to other', '2026-03-10 18:29:33'),
(2174, 89, 73, 57, '119-106-1', 119, 'with wind turbine manufacturer Siemens Gamesa to', '2026-03-10 18:29:33'),
(2175, 89, 73, 57, '119-106-2', 119, 'use recycled glass fibres for certain new wind turbine', '2026-03-10 18:29:33'),
(2176, 89, 73, 57, '119-106-3', 119, 'technically approved refurbishment loops for more', '2026-03-10 18:29:33'),
(2177, 89, 73, 57, '119-106-4', 119, 'than 100 of our key minor components, reducing', '2026-03-10 18:29:33'),
(2178, 89, 73, 57, '119-106-5', 119, 'ration of reuse and recycling markets for our compo-', '2026-03-10 18:29:33'),
(2179, 89, 73, 57, '119-107-1', 119, 'the foundation and the mounting of the wind turbine', '2026-03-10 18:29:33'),
(2180, 89, 73, 57, '119-107-2', 119, 'tower, where the inner parts of the foundation are', '2026-03-10 18:29:33'),
(2181, 89, 73, 57, '119-107-3', 119, 'via our partner Wind Cluster. With this trial, we now', '2026-03-10 18:29:33'),
(2182, 89, 73, 57, '119-107-4', 119, 'exposed to wind and water elements at offshore sites.', '2026-03-10 18:29:33'),
(2183, 89, 73, 57, '119-107-5', 119, 'Repairing and refurbishing spare parts for our wind', '2026-03-10 18:29:33'),
(2184, 89, 73, 57, '119-107-6', 119, 'have a blueprint set-up to scale our efforts to other', '2026-03-10 18:29:33'),
(2185, 90, 73, 57, '119-108-1', 119, 'for potential future application at our offshore wind', '2026-03-10 18:29:33'),
(2186, 90, 73, 57, '119-108-2', 119, 'circularity- related supplier requirements in place within', '2026-03-10 18:29:33'),
(2187, 90, 73, 57, '119-108-3', 119, 'farms. The TP cover is temporarily installed to shield', '2026-03-10 18:29:33'),
(2188, 90, 73, 57, '119-108-4', 119, 'the next four to five years. For selected components,', '2026-03-10 18:29:33'),
(2189, 90, 73, 57, '119-108-5', 119, 'Furthermore, to increase the reuse of minor com-', '2026-03-10 18:29:33'),
(2190, 90, 73, 57, '119-108-6', 119, 'against water and to save seabirds from getting', '2026-03-10 18:29:33'),
(2191, 90, 73, 57, '119-108-7', 119, 'recycled materials have already been introduced as', '2026-03-10 18:29:33'),
(2192, 90, 73, 57, '119-108-8', 119, 'ponents and spare parts, we have successfully con-', '2026-03-10 18:29:33');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `esrs_requirements`
--

CREATE TABLE `esrs_requirements` (
  `id` int NOT NULL,
  `standard_id` int NOT NULL,
  `code` varchar(100) NOT NULL,
  `disclosure_requirement` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `paragraph` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `data_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `conditional_alternative_disclosure_requirement` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `esrs_requirements`
--

INSERT INTO `esrs_requirements` (`id`, `standard_id`, `code`, `disclosure_requirement`, `paragraph`, `title`, `data_type`, `conditional_alternative_disclosure_requirement`, `timestamp`) VALUES
(12, 6, 'E4.SBM-3_01', 'E4.SBM-3', '16 a', 'List of material sites in own operation', 'narrative', '', '2025-12-19 19:01:55'),
(13, 6, 'E4.SBM-3_02', 'E4.SBM-3', '16 a i', 'Disclosure of activities negatively affecting biodiversity sensitive areeas', 'narrative', '', '2025-12-19 19:01:55'),
(14, 6, 'E4.SBM-3_03', 'E4.SBM-3', '16 a ii', 'Disclosure of list of material sites in own operations based on results of identification and assessment of actual and potential impacts on biodiversity and ecosystems', 'narrative', '', '2025-12-19 19:01:55'),
(15, 6, 'E4.SBM-3_04', 'E4.SBM-3', '16 a iii', 'Disclosure of biodiversity-sensitive areas impacted ', 'narrative', '', '2025-12-19 19:01:55'),
(16, 6, 'E4.SBM-3_05', 'E4.SBM-3', '16 b', 'Material negative impacts with regards to land degradation, desertification or soil sealing have been identified', 'semi-narrative', '', '2025-12-19 19:01:55'),
(17, 6, 'E4.SBM-3_06', 'E4.SBM-3', '16 c', 'Own operations affect threatened species', 'semi-narrative', '', '2025-12-19 19:01:55'),
(18, 6, 'E4.IRO-1_01', 'E4.IRO-1', ' 17 a', 'Disclosure of whether and how actual and potential impacts on biodiversity and ecosystems at own site locations and in value chain have been identified and assessed ', 'narrative', '', '2025-12-19 19:01:55'),
(19, 6, 'E4.IRO-1_02', 'E4.IRO-1', ' 17 b', 'Disclosure of whether and how dependencies on biodiversity and ecosystems and their services have been identified and assessed at own site locations and in value chain ', 'narrative', '', '2025-12-19 19:01:55'),
(20, 6, 'E4.IRO-1_03', 'E4.IRO-1', ' 17 c', 'Disclosure of whether and how transition and physical risks and opportunities related to biodiversity and ecosystems have been identified and assessed ', 'narrative', '', '2025-12-19 19:01:55'),
(21, 6, 'E4.IRO-1_04', 'E4.IRO-1', ' 17 d', 'Disclosure of whether and how systemic risks have been considered (biodiversity and ecosystems)', 'narrative', '', '2025-12-19 19:01:55'),
(22, 6, 'E4.IRO-1_05', 'E4.IRO-1', ' 17 e', 'Disclosure of whether and how consultations with affected communities on sustainability assessments of shared biological resources and ecosystems have been conducted ', 'narrative', '', '2025-12-19 19:01:55'),
(23, 6, 'E4.IRO-1_06', 'E4.IRO-1', ' 17 e i', 'Disclosure of whether and how specific sites, raw materials production or sourcing with negative or potential negative impacts on affected communities ', 'narrative', '', '2025-12-19 19:01:55'),
(24, 6, 'E4.IRO-1_07', 'E4.IRO-1', ' 17 e ii', 'Disclosure of whether and how communities were involved in materiality assessment ', 'narrative', '', '2025-12-19 19:01:55'),
(25, 6, 'E4.IRO-1_08', 'E4.IRO-1', ' 17 e iii', 'Disclosure of whether and how negative impacts on priority ecosystem services of relevance to affected communities may be avoided ', 'narrative', '', '2025-12-19 19:01:55'),
(26, 6, 'E4.IRO-1_09', 'E4.IRO-1', ' 17 e iii', 'Disclosure of plans to minimise unavoidable negative impacts and implement mitigation measures that aim to maintain value and functionality of priority services ', 'narrative', '', '2025-12-19 19:01:55'),
(27, 6, 'E4.IRO-1_10', 'E4.IRO-1', '18', 'Disclosure of whether and how tthe business model(s) has been verified using range of biodiversity and ecosystems scenarios, or other scenarios with modelling of biodiversity and ecosystems related consequences, with different possible pathways', 'narrative', '', '2025-12-19 19:01:55'),
(28, 6, 'E4.IRO-1_11', 'E4.IRO-1', ' 18 a', 'Disclosure of why considered scenarios were taken into consideration ', 'narrative', 'Conditional', '2025-12-19 19:01:55'),
(29, 6, 'E4.IRO-1_12', 'E4.IRO-1', ' 18 b', 'Disclosure of how considered scenarios are updated according to evolving conditions and emerging trends ', 'narrative', 'Conditional', '2025-12-19 19:01:55'),
(30, 6, 'E4.IRO-1_13', 'E4.IRO-1', ' 18 c', 'Scenarios are informed by expectations in authoritative intergovernmental instruments and by scientific consensus', 'semi-narrative', 'Conditional', '2025-12-19 19:01:55'),
(31, 6, 'E4.IRO-1_14', 'E4.IRO-1', ' 19a', 'Undertaking has sites located in or near biodiversity-sensitive areas', 'semi-narrative', '', '2025-12-19 19:01:55'),
(32, 6, 'E4.IRO-1_15', 'E4.IRO-1', ' 19a', 'Activities related to sites located in or near biodiversity-sensitive areas negatively affect these areas by leading to deterioration of natural habitats and habitats of species and to disturbance of species for which protected area has been designated', 'semi-narrative', '', '2025-12-19 19:01:55'),
(33, 6, 'E4.IRO-1_16', 'E4.IRO-1', ' 19b', 'It has been concluded that it is necessary to implement biodiversity mitigation measures', 'semi-narrative', '', '2025-12-19 19:01:55'),
(34, 6, 'E4-1_01', 'E4-1', '13 a', 'Disclosure of resilience of current business model(s) and strategy to biodiversity and ecosystems-related physical, transition and systemic risks and opportunities ', 'narrative', '', '2025-12-19 19:01:55'),
(35, 6, 'E4-1_02', 'E4-1', '13 b', 'Disclosure of scope of resilience analysis along own operations and related upstream and downstream value chain ', 'narrative', '', '2025-12-19 19:01:56'),
(36, 6, 'E4-1_03', 'E4-1', '13 c', 'Disclosure of key assumptions made (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(37, 6, 'E4-1_04', 'E4-1', '13 d', 'Disclosure of time horizons used for analysis (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(38, 6, 'E4-1_05', 'E4-1', '13 e', 'Disclosure of results of resilience analysis (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(39, 6, 'E4-1_06', 'E4-1', '13 f', 'Disclosure of involvement of stakeholders (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(40, 6, 'E4-1_07', 'E4-1', '15', 'Disclosure of transition plan to improve and achieve alignment of its business model and strategy', 'narrative', '', '2025-12-19 19:01:56'),
(41, 6, 'E4-1_08', 'E4-1', 'AR 1 a', 'Explanation of how strategy and business model will be adjusted to improve and, ultimately, achieve alignment with relevant local, national and global public policy goals', 'narrative', '', '2025-12-19 19:01:56'),
(42, 6, 'E4-1_09', 'E4-1', 'AR 1 b', 'Include information about  its own operations and  explain how it is responding to material impacts in its related value chain', 'narrative', '', '2025-12-19 19:01:56'),
(43, 6, 'E4-1_10', 'E4-1', 'AR 1 c', 'Explanation of how b strategy interacts with  transition plan ', 'narrative', '', '2025-12-19 19:01:56'),
(44, 6, 'E4-1_11', 'E4-1', 'AR 1 d', 'Disclosure of contribution to impact drivers and possible mitigation actions following mitigation hierarchy and main path-dependencies and locked-in assets and resources that are associated with biodiversity and ecosystems change ', 'narrative', '', '2025-12-19 19:01:56'),
(45, 6, 'E4-1_12', 'E4-1', 'AR 1 e', 'Explanation and quantification of investments and funding supporting the implementation of its transition plan', 'narrative', '', '2025-12-19 19:01:56'),
(46, 6, 'E4-1_13', 'E4-1', 'AR 1  f', 'Disclosure of objectives or plans for aligning economic activities (revenues, CapEx)', 'narrative', '', '2025-12-19 19:01:56'),
(47, 6, 'E4-1_14', 'E4-1', 'AR 1 g', 'Biodiversity offsets are part of transition plan', 'narrative', '', '2025-12-19 19:01:56'),
(48, 6, 'E4-1_15', 'E4-1', 'AR 1  h', 'Information about how process of implementing and updating transition plan is managed ', 'narrative', '', '2025-12-19 19:01:56'),
(49, 6, 'E4-1_16', 'E4-1', 'AR 1  i', 'Indication of metrics and related tools used to measure progress that are integrated in measurement approach (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(50, 6, 'E4-1_17', 'E4-1', 'AR 1  j', 'Administrative, management and supervisory bodies have approved transition plan', 'narrative', '', '2025-12-19 19:01:56'),
(51, 6, 'E4-1_18', 'E4-1', 'AR 1  k', 'Indication of current challenges and limitations to draft plan in relation to areas of significant impact and actions company is taking to address them (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(52, 6, 'E4.MDR-P_01-06', 'E4-2', '22', 'Policies to manage material impacts, risks, dependencies and opportunities related to biodiversity and ecosystems [see ESRS 2 - MDR-P]', 'MDR-P', '', '2025-12-19 19:01:56'),
(53, 6, 'E4-2_01', 'E4-2', '23 a', 'Disclosure on whether and how biodiversity and ecosystems-related policies relate to matters reported in E4 AR4', 'narrative', '', '2025-12-19 19:01:56'),
(54, 6, 'E4-2_02', 'E4-2', '23 b', 'Explanation of whether and  how biodiversity and ecosystems-related policy relates to material biodiversity and ecosystems-related impacts ', 'narrative', '', '2025-12-19 19:01:56'),
(55, 6, 'E4-2_03', 'E4-2', '23 c', 'Explanation of whether and  how biodiversity and ecosystems-related policy relates to material dependencies and material physical and transition risks and opportunities ', 'narrative', '', '2025-12-19 19:01:56'),
(56, 6, 'E4-2_04', 'E4-2', '23 d', 'Explanation of whether and how biodiversity and ecosystems-related policy supports traceability of products, components and raw materials with significant actual or potential impacts on biodiversity and ecosystems along value chain ', 'narrative', '', '2025-12-19 19:01:56'),
(57, 6, 'E4-2_05', 'E4-2', '23 e', 'Explanation of whether and how biodiversity and ecosystems-related policy addresses production, sourcing or consumption from ecosystems that are managed to maintain or enhance conditions for biodiversity ', 'narrative', '', '2025-12-19 19:01:56'),
(58, 6, 'E4-2_06', 'E4-2', '23 f', 'Explanation of whether and how biodiversity and ecosystems-related policy addresses social consequences of biodiversity and ecosystems-related impacts ', 'narrative', '', '2025-12-19 19:01:56'),
(59, 6, 'E4-2_07', 'E4-2', 'AR 12', 'Disclosure of how policy refers to production, sourcing or consumption of raw materials ', 'narrative', '', '2025-12-19 19:01:56'),
(60, 6, 'E4-2_08', 'E4-2', 'AR 12 a', 'Disclosure of how policy refers to policies limiting procurement from suppliers that cannot demonstrate that they are not contributing to significant conversion of protected areas or key biodiversity areas ', 'narrative', '', '2025-12-19 19:01:56'),
(61, 6, 'E4-2_09', 'E4-2', 'AR 12 b', 'Disclosure of how policy refers to recognised standards or third-party certifications overseen by regulators ', 'narrative', '', '2025-12-19 19:01:56'),
(62, 6, 'E4-2_10', 'E4-2', 'AR 12 c', 'Disclosure of how policy addresses raw materials originating from ecosystems that have been managed to maintain or enhance conditions for biodiversity, as demonstrated by regular monitoring and reporting of biodiversity status and gains or losses', 'narrative', '', '2025-12-19 19:01:56'),
(63, 6, 'E4-2_11', 'E4-2', 'AR 16', 'Disclosure of how the policy enables to a), b), c) and d)', 'narrative', '', '2025-12-19 19:01:56'),
(64, 6, 'E4-2_12', 'E4-2', 'AR 17 a', 'Third-party standard of conduct used in policy is objective and achievable based on scientific approach to identifying issues and realistic in assessing how these issues can be addressed under variety of practical circumstances', 'semi-narrative', '', '2025-12-19 19:01:56'),
(65, 6, 'E4-2_13', 'E4-2', 'AR 17 b', 'Third-party standard of conduct used in policy is developed or maintained through process of ongoing consultation with relevant stakeholders with balanced input from all relevant stakeholder groups with no group holding undue authority or veto power over content', 'semi-narrative', '', '2025-12-19 19:01:56'),
(66, 6, 'E4-2_14', 'E4-2', 'AR 17 c', 'Third-party standard of conduct used in policy encourages step-wise approach and continuous improvement in standard and its application of better management practices and requires establishment of meaningful targets and specific milestones to indicate progress against principles and criteria over time', 'semi-narrative', '', '2025-12-19 19:01:56'),
(67, 6, 'E4-2_15', 'E4-2', 'AR 17 d', 'Third-party standard of conduct used in policy is verifiable through independent certifying or verifying bodies, which have defined and rigorous assessment procedures that avoid conflicts of interest and are compliant with ISO guidance on accreditation and verification procedures or Article 5(2) of Regulation (EC) No 765/2008', 'semi-narrative', '', '2025-12-19 19:01:56'),
(68, 6, 'E4-2_16', 'E4-2', 'AR 17 e', 'Third-party standard of conduct used in policy conforms to ISEAL Code of Good Practice', 'semi-narrative', '', '2025-12-19 19:01:56'),
(69, 6, 'E4-2_17', 'E4-2', '24 a', 'Biodiversity and ecosystem protection policy covering operational sites owned, leased, managed in or near protected area or biodiversity-sensitive area outside protected areas has been adopted', 'semi-narrative', '', '2025-12-19 19:01:56'),
(70, 6, 'E4-2_18', 'E4-2', '24 b', 'Sustainable land or agriculture practices or policies have been adopted', 'semi-narrative', '', '2025-12-19 19:01:56'),
(71, 6, 'E4-2_19', 'E4-2', '24 c ', 'Sustainable oceans or seas practices or policies have been adopted', 'semi-narrative', '', '2025-12-19 19:01:56'),
(72, 6, 'E4-2_20', 'E4-2', '24 d', 'Policies to address deforestation have been adopted', 'semi-narrative', '', '2025-12-19 19:01:56'),
(73, 6, 'E4.MDR-A_01-12', 'E4-3', '27', 'Actions and resources in relation to biodiversity and ecosystems [see ESRS 2 - MDR-A]', 'MDR-A', '', '2025-12-19 19:01:56'),
(74, 6, 'E4-3_01', 'E4-3', '28 a', 'Disclosure on how the mitigation hierarchy has been applied with regard to biodiversity and ecosystem actions', 'narrative', '', '2025-12-19 19:01:56'),
(75, 6, 'E4-3_02', 'E4-3', '28 b', 'Biodiversity offsets were used in action plan', 'semi-narrative', '', '2025-12-19 19:01:56'),
(76, 6, 'E4-3_03', 'E4-3', '28 b i', 'Disclosure of aim of biodiversity offset and key performance indicators used ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(77, 6, 'E4-3_04', 'E4-3', '28 b ii', 'Financing effects (direct and indirect costs) of biodiversity offsets', 'Monetary', 'Conditional', '2025-12-19 19:01:56'),
(78, 6, 'E4-3_05', 'E4-3', 'AR 18 a', 'Explanation of rekationship of significant Capex and Opex required to impelement actions taken or planned to relevant line items or notes in the financial statements', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(79, 6, 'E4-3_06', 'E4-3', 'AR 18 b', 'Explanation of rekationship of significant Capex and Opex required to impelement actions taken or planned to key  performance indicators required under Commission Delegated Regulation (EU) 2021/2178', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(80, 6, 'E4-3_07', 'E4-3', 'AR 18 c', 'Explanation of rekationship of significant Capex and Opex required to impelement actions taken or planned to Capex plan required under Commission Delegated Regulation (EU) 2021/2178', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(81, 6, 'E4-3_08', 'E4-3', '28 b iii', 'Description of biodiversity offsets ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(82, 6, 'E4-3_09', 'E4-3', '28 c', 'Description of whether and how local and indigenous knowledge and nature-based solutions have been incorporated into biodiversity and ecosystems-related action ', 'narrative', '', '2025-12-19 19:01:56'),
(83, 6, 'E4-3_10', 'E4-3', 'AR 20 a', 'Disclosure of key stakeholders involved and how they are involved, key stakeholders negatively or positively impacted by action and how they are impacted ', 'narrative', '', '2025-12-19 19:01:56'),
(84, 6, 'E4-3_11', 'E4-3', 'AR 20 b', 'Explanation of need for appropriate consultations and need to respect decisions of affected communities ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(85, 6, 'E4-3_12', 'E4-3', 'AR 20 c', 'Description of whether key action may induce significant negative sustainability impacts (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(86, 6, 'E4-3_13', 'E4-3', 'AR 20 d', 'Explanation of whether the key action is intended to be a one-time initiative or systematic practice', 'narrative', '', '2025-12-19 19:01:56'),
(87, 6, 'E4-3_14', 'E4-3', 'AR 20 e', 'Key action plan is carried out only by undertaking (individual action) using its resources (biodiversity and ecosystems)', 'semi-narrative', '', '2025-12-19 19:01:56'),
(88, 6, 'E4-3_15', 'E4-3', 'AR 20 e', 'Key action plan is part of wider action plan (collective action), of which undertaking is member (biodiversity and ecosystems)', 'semi-narrative', '', '2025-12-19 19:01:56'),
(89, 6, 'E4-3_16', 'E4-3', 'AR 20 f', 'Additional information about project, its sponsors and other participants (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(90, 6, 'E4.MDR-T_01-13', 'E4-4', '31', 'Tracking effectiveness of policies and actions through targets [see ESRS 2 MDR-T ]', 'MDR-T', '', '2025-12-19 19:01:56'),
(91, 6, 'E4-4_01', 'E4-4', '32 a', 'Ecological threshold and allocation of impacts to undertaking were applied when setting target (biodiversity and ecosystems)', 'semi-narrative', '', '2025-12-19 19:01:56'),
(92, 6, 'E4-4_02', 'E4-4', '32 a i', 'Disclosure of ecological threshold identified and methodology used to identify threshold (biodiversity and ecosystems) ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(93, 6, 'E4-4_03', 'E4-4', '32 a ii', 'Disclosure of how entity-specific threshold was determined (biodiversity and ecosystems) ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(94, 6, 'E4-4_04', 'E4-4', '32 a iii', 'Disclosure of how responsibility for respecting identified ecological threshold is allocated (biodiversity and ecosystems) ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(95, 6, 'E4-4_05', 'E4-4', '32 b', 'Target is informed by relevant aspect of EU Biodiversity Strategy for 2030', 'semi-narrative', '', '2025-12-19 19:01:56'),
(96, 6, 'E4-4_06', 'E4-4', '32 c', 'Disclosure of how the targets relate to the biodiversity and ecosystem impacts, dependencies, risks and opportunities identified in relation to own operations and upstream and downstream value chain', 'narrative', '', '2025-12-19 19:01:56'),
(97, 6, 'E4-4_07', 'E4-4', '32 d', 'Disclosure of the geographical scope of the targets', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(98, 6, 'E4-4_08', 'E4-4', '32 e', 'Biodiversity offsets were used in setting target', 'semi-narrative', '', '2025-12-19 19:01:56'),
(99, 6, 'E4-4_09', 'E4-4', '32 f', 'Layer in mitigation hierarchy to which target can be allocated (biodiversity and ecosystems)', 'semi-narrative', '', '2025-12-19 19:01:56'),
(100, 6, 'E4-4_10', 'E4-4', 'AR 22', 'The target addresses shortcomings related to the Substantial Contribution criteria ', 'semi-narrative', '', '2025-12-19 19:01:56'),
(101, 6, 'E4-5_01', 'E4-5', '35', 'Number of sites owned, leased or managed in or near protected areas or key biodiversity areas that undertaking is negatively affecting', 'Integer', 'Conditional', '2025-12-19 19:01:56'),
(102, 6, 'E4-5_02', 'E4-5', '35', 'Area of sites owned, leased or managed in or near protected areas or key biodiversity areas that undertaking is negatively affecting', 'Area', 'Conditional', '2025-12-19 19:01:56'),
(103, 6, 'E4-5_03', 'E4-5', '36', 'Disclosure of land-use based on Life Cycle Assessment ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(104, 6, 'E4-5_04', 'E4-5', '38', 'Disclosure of metrics considered relevant (land-use change, freshwater-use change and (or) sea-use change) ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(105, 6, 'E4-5_05', 'E4-5', '38 a', 'Disclosure of conversion over time of land cover ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(106, 6, 'E4-5_06', 'E4-5', '38 b', 'Disclosure of changes over time in management of ecosystem ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(107, 6, 'E4-5_07', 'E4-5', '38 c', 'Disclosure of changes in spatial configuration of landscape ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(108, 6, 'E4-5_08', 'E4-5', '38 d', 'Disclosure of changes in ecosystem structural connectivity ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(109, 6, 'E4-5_09', 'E4-5', '38 e', 'Disclosure of functional connectivity ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(110, 6, 'E4-5_10', 'E4-5', 'AR 34 a', 'Total use of land area', 'Area', 'Conditional', '2025-12-19 19:01:56'),
(111, 6, 'E4-5_11', 'E4-5', 'AR 34 b', 'Total sealed area', 'Area', 'Conditional', '2025-12-19 19:01:56'),
(112, 6, 'E4-5_12', 'E4-5', 'AR 34 c', 'Nature-oriented area on site', 'Area', 'Conditional', '2025-12-19 19:01:56'),
(113, 6, 'E4-5_13', 'E4-5', 'AR 34 d', 'Nature-oriented area off site', 'Area', 'Conditional', '2025-12-19 19:01:56'),
(114, 6, 'E4-5_14', 'E4-5', '39', 'Disclosure of how pathways of introduction and spread of invasive alien species and risks posed by invasive alien species are managed ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(115, 6, 'E4-5_15', 'E4-5', 'AR 32', 'Number of invasive alien species', 'Integer', 'Conditional', '2025-12-19 19:01:56'),
(116, 6, 'E4-5_16', 'E4-5', 'AR 32', 'Area covered by invasive alien species', 'Area', 'Conditional', '2025-12-19 19:01:56'),
(117, 6, 'E4-5_17', 'E4-5', '40', 'Disclosure of metrics considered relevant (state of species) ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(118, 6, 'E4-5_18', 'E4-5', '40 a', 'Disclosure of paragraph in another environment-related standard in which metric is referred to ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(119, 6, 'E4-5_19', 'E4-5', '40 b', 'Disclosure of population size, range within specific ecosystems and extinction risk ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(120, 6, 'E4-5_20', 'E4-5', '40 c', 'Disclosure of changes in number of individuals of species within specific area ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(121, 6, 'E4-5_21', 'E4-5', '40 d', 'Information about species at global extinction risk ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(122, 6, 'E4-5_22', 'E4-5', '40 d i', 'Disclosure of threat status of species and how activities or pressures may affect threat status ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(123, 6, 'E4-5_23', 'E4-5', '40 d ii', 'Disclosure of change in relevant habitat for threatened species as proxy for impact on local population\'s extinction risk ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(124, 6, 'E4-5_24', 'E4-5', '41 a ', 'Disclosure of ecosystem area coverage ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(125, 6, 'E4-5_25', 'E4-5', '41 b i', 'Disclosure of quality of ecosystems relative to pre-determined reference state ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(126, 6, 'E4-5_26', 'E4-5', '41 b ii', 'Disclosure of multiple species within ecosystem ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(127, 6, 'E4-5_27', 'E4-5', '41 b iii', 'Disclosure of structural components of ecosystem condition ', 'narrative', 'Conditional', '2025-12-19 19:01:56'),
(128, 6, 'E4-6_01', 'E4-6', '45 a', 'Disclosure of quantitative information about anticipated financial effects of material risks and opportunities arising from biodiversity- and ecosystem-related impacts and dependencies ', 'Monetary', '', '2025-12-19 19:01:56'),
(129, 6, 'E4-6_02', 'E4-6', '45 a', 'Disclosure of qualitative information about anticipated financial effects of material risks and opportunities arising from biodiversity- and ecosystem-related impacts and dependencies ', 'narrative', '', '2025-12-19 19:01:56'),
(130, 6, 'E4-6_03', 'E4-6', '45 b', 'Description of effects considered, related impacts and dependencies (biodiversity and ecosystems) ', 'narrative', '', '2025-12-19 19:01:56'),
(131, 6, 'E4-6_04', 'E4-6', '45 c', 'Disclosure of critical assumptions used in estimates of financial effects of material risks and opportunities arising from biodiversity- and ecosystem-related impacts and dependencies ', 'narrative', '', '2025-12-19 19:01:56'),
(132, 6, 'E4-6_05', 'E4-6', 'AR 39', 'Description of related products and services at risk (biodiversity and ecosystems) over the short-, medium- and long-term', 'narrative', '', '2025-12-19 19:01:56'),
(133, 6, 'E4-6_06', 'E4-6', 'AR 39', 'Explanation of how financial amounts are estimated and critical assumptions made (biodiversity and ecosystems) ', 'narrative/monetary', '', '2025-12-19 19:01:56');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `esrs_standards`
--

CREATE TABLE `esrs_standards` (
  `id` int NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `description_eng` varchar(250) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `esrs_standards`
--

INSERT INTO `esrs_standards` (`id`, `code`, `name`, `description`, `description_eng`, `timestamp`) VALUES
(1, 'ESRS 1', 'ESRS 1', 'Allgemeine Anforderungen', '', '2025-12-02 19:54:50'),
(2, 'ESRS 2', 'ESRS 2', 'Allgemeine Angaben ', '', '2025-12-02 19:54:50'),
(3, 'E1', 'ESRS E1', 'Klimawandel', 'Climate Change', '2025-12-02 19:54:50'),
(4, 'E2', 'ESRS E2', 'Umweltverschmutzung', 'Pollution', '2025-12-02 19:54:50'),
(5, 'E3', 'ESRS E3', 'Wasser- und Meeresressourcen', ' Water and Marine Resources', '2025-12-02 19:54:50'),
(6, 'E4', 'ESRS E4', 'Biologische Vielfalt und Ökosysteme', 'Biodiversity and Ecosystems', '2025-12-02 19:54:50'),
(7, 'E5', 'ESRS E5', 'Ressourcennutzung und Kreislaufwirtschaft', 'Resource Use and Circular Economy', '2025-12-02 19:54:50'),
(8, 'S1', 'ESRS S1', 'Eigene Belegschaft', 'Own Workforce', '2025-12-02 19:54:50'),
(9, 'S2', 'ESRS S2', 'Arbeitskräfte in der Wertschöpfungskette', 'Workers in the Value Chain', '2025-12-02 19:54:50'),
(10, 'S3', 'ESRS S3', 'Betroffene Gemeinschaften', 'Affected Communities', '2025-12-02 19:56:36'),
(11, 'S4', 'ESRS S4', 'Verbraucher und Endbenutzer', 'Consumers and End-users', '2025-12-02 19:56:36'),
(12, 'G1', 'ESRS G1', 'Unternehmenspolitik', 'Business Conduct', '2025-12-02 19:56:36');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `industries`
--

CREATE TABLE `industries` (
  `id` int NOT NULL,
  `sector_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `industries`
--

INSERT INTO `industries` (`id`, `sector_id`, `name`, `description`, `timestamp`) VALUES
(1, 1, 'E-Commerce', 'commercial transactions conducted electronically on the internet.', '2025-12-02 18:03:43'),
(2, 1, 'Household & Personal Products', 'Items for cleaning, maintaining, and furnishing a home, often including durable goods and consumables.', '2025-12-08 17:21:58'),
(4, 2, 'Telecommunication Services', 'Dienstleistungen zur Übertragung von Informationen (Sprache, Daten, Video) über Netzwerke wie das Internet, Mobilfunk oder Festnetz.', '2026-01-12 12:52:12'),
(14, 9, 'Chemicals', 'Die chemische Industrie wandelt Rohstoffe wie Erdöl, Erdgas, Mineralien und Wasser durch chemische Verfahren in Zwischen- und Endprodukte um.', '2026-01-29 14:14:37'),
(17, 12, 'Electric Utilities & Power Generators', 'umfasst Unternehmen, die für die Erzeugung, Übertragung, Verteilung und den Verkauf von Elektrizität verantwortlich sind.', '2026-02-25 19:06:02');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `jobs`
--

CREATE TABLE `jobs` (
  `id` int NOT NULL,
  `job_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `report_id` int DEFAULT NULL,
  `standard_id` int NOT NULL,
  `requirements_all` tinyint(1) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `jobs`
--

INSERT INTO `jobs` (`id`, `job_id`, `user_id`, `report_id`, `standard_id`, `requirements_all`, `status`, `created_at`, `updated_at`) VALUES
(29, 'e1f9cc7d-2cf7-4046-ae66-f3e69e46ba1c', 1, 36, 6, 1, 'finished', '2026-01-12 12:57:23', '2026-01-12 13:08:51'),
(40, '49d4891a-5ba3-4cbc-b510-2e112618a687', 1, 54, 6, 1, 'not_compatible', '2026-02-02 19:38:07', '2026-02-02 19:38:07'),
(43, '9b440f1a-8ead-4da2-963d-17a8c4338fd0', 1, 57, 6, 1, 'finished', '2026-02-02 21:41:20', '2026-02-02 22:07:26'),
(46, 'c642eb74-4dbc-48bb-a2d7-4193af20ee10', 1, 61, 6, 1, 'finished', '2026-02-02 23:33:41', '2026-02-02 23:39:00'),
(56, '8d2bfa3d6b9e5e9003124765f63a8cc3', 1, 72, 6, 0, 'finished', '2026-03-01 14:25:08', '2026-03-01 14:42:52'),
(57, '7dc5a8d6-6c74-46e1-b046-4d640844f9a0', 1, 73, 6, 1, 'finished', '2026-03-10 16:48:20', '2026-03-10 17:29:33');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint UNSIGNED NOT NULL,
  `version` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `class` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `namespace` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` int NOT NULL,
  `batch` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2020-12-28-223112', 'CodeIgniter\\Shield\\Database\\Migrations\\CreateAuthTables', 'default', 'CodeIgniter\\Shield', 1768914183, 1),
(2, '2021-07-04-041948', 'CodeIgniter\\Settings\\Database\\Migrations\\CreateSettingsTable', 'default', 'CodeIgniter\\Settings', 1768914183, 1),
(3, '2021-11-14-143905', 'CodeIgniter\\Settings\\Database\\Migrations\\AddContextColumn', 'default', 'CodeIgniter\\Settings', 1768914183, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int UNSIGNED NOT NULL,
  `dbase` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `query` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_length` text COLLATE utf8mb3_bin,
  `col_collation` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `col_default` text COLLATE utf8mb3_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `settings_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8mb3_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `template_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tables` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `page_nr` int UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tables` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `pdf_page_number` int NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `prefs` text COLLATE utf8mb3_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `version` int UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8mb3_bin NOT NULL,
  `schema_sql` text COLLATE utf8mb3_bin,
  `data_sql` longtext COLLATE utf8mb3_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8mb3_bin DEFAULT NULL,
  `tracking_active` int UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Daten für Tabelle `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-12-08 16:19:51', '{\"lang\":\"de\"}');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8mb3_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Users and their assignments to user groups';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reports`
--

CREATE TABLE `reports` (
  `id` int NOT NULL,
  `company_id` int NOT NULL,
  `reporting_year` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `reports`
--

INSERT INTO `reports` (`id`, `company_id`, `reporting_year`, `description`, `status`, `timestamp`) VALUES
(36, 1, '2024', NULL, 'ready', '2026-01-12 13:57:23'),
(54, 31, '2024', NULL, 'not_compatible', '2026-02-02 20:38:07'),
(57, 32, '2024', NULL, 'ready', '2026-02-02 22:41:20'),
(61, 33, '2024', NULL, 'ready', '2026-02-03 00:33:41'),
(72, 34, '2025', NULL, 'ready', '2026-03-01 15:25:08'),
(73, 34, '2024', NULL, 'ready', '2026-03-10 17:48:20');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sectors`
--

CREATE TABLE `sectors` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `sectors`
--

INSERT INTO `sectors` (`id`, `name`, `description`, `timestamp`) VALUES
(1, 'Consumer Goods', 'goods bought and used by consumers, rather than by manufacturers for producing other goods.', '2025-12-02 18:01:39'),
(2, 'Technology & Communications', ' Technologien zur Erfassung, Speicherung, Verarbeitung, Übertragung und zum Austausch digitaler Informationen und Daten, einschließlich Hardware (Smartphones, Computer, Netzwerke), Software, Internet, Telekommunikation und damit verbundener Dienstleistungen, die die Kommunikation und Interaktion in der digitalen Welt ermöglichen.', '2026-01-12 12:50:55'),
(9, 'Resource Transformation', 'Der Ressourcentransformations-Sektor der Industrie bezeichnet die nachhaltige Umgestaltung industrieller Prozesse, bei der Rohstoffe und Energie effizienter genutzt werden. Ziel ist der Übergang von einer linearen Wirtschaft zu einer zirkulären Kreislaufwirtschaft, um Materialien länger zu nutzen, Abfälle zu minimieren und die Klimaneutralität zu fördern.', '2026-01-29 14:14:00'),
(12, 'Infrastruktur', 'notwendiger wirtschaftlicher und organisatorischer Unterbau als Voraussetzung für die Versorgung und die Nutzung eines bestimmten Gebiets, für die gesamte Wirtschaft eines Landes', '2026-02-25 19:05:33');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `settings`
--

CREATE TABLE `settings` (
  `id` int NOT NULL,
  `class` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `value` text COLLATE utf8mb4_general_ci,
  `type` varchar(31) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'string',
  `context` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_message` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `last_active` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`id`, `username`, `status`, `status_message`, `active`, `last_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'MaxMustermann', NULL, NULL, 0, NULL, '2026-01-21 13:49:47', '2026-01-21 13:49:47', NULL),
(5, 'testolino', NULL, NULL, 0, NULL, '2026-01-28 16:42:59', '2026-01-28 19:32:13', '2026-01-28 19:32:13'),
(6, 'test2', NULL, NULL, 0, NULL, '2026-01-28 19:39:57', '2026-01-28 19:39:57', NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `auditors`
--
ALTER TABLE `auditors`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `audit_report`
--
ALTER TABLE `audit_report`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `audit_report_ibfk_1` (`auditor_id`),
  ADD KEY `audit_report_ibfk_2` (`report_id`);

--
-- Indizes für die Tabelle `auth_groups_users`
--
ALTER TABLE `auth_groups_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auth_groups_users_user_id_foreign` (`user_id`);

--
-- Indizes für die Tabelle `auth_identities`
--
ALTER TABLE `auth_identities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type_secret` (`type`,`secret`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `auth_logins`
--
ALTER TABLE `auth_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_identifier` (`id_type`,`identifier`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `auth_permissions_users`
--
ALTER TABLE `auth_permissions_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auth_permissions_users_user_id_foreign` (`user_id`);

--
-- Indizes für die Tabelle `auth_remember_tokens`
--
ALTER TABLE `auth_remember_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `selector` (`selector`),
  ADD KEY `auth_remember_tokens_user_id_foreign` (`user_id`);

--
-- Indizes für die Tabelle `auth_token_logins`
--
ALTER TABLE `auth_token_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_identifier` (`id_type`,`identifier`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `industry_id` (`industry_id`);

--
-- Indizes für die Tabelle `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `esrs_reportvalue`
--
ALTER TABLE `esrs_reportvalue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `esrs_reportvalue_ibfk_1` (`report_id`),
  ADD KEY `requirement_id` (`requirement_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indizes für die Tabelle `esrs_requirements`
--
ALTER TABLE `esrs_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `standard_id` (`standard_id`);

--
-- Indizes für die Tabelle `esrs_standards`
--
ALTER TABLE `esrs_standards`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `industries`
--
ALTER TABLE `industries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sector_id` (`sector_id`);

--
-- Indizes für die Tabelle `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`),
  ADD KEY `standard_id` (`standard_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indizes für die Tabelle `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indizes für die Tabelle `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indizes für die Tabelle `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indizes für die Tabelle `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indizes für die Tabelle `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indizes für die Tabelle `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indizes für die Tabelle `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indizes für die Tabelle `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indizes für die Tabelle `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indizes für die Tabelle `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indizes für die Tabelle `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indizes für die Tabelle `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indizes für die Tabelle `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indizes für die Tabelle `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indizes für die Tabelle `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indizes für die Tabelle `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indizes für die Tabelle `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- Indizes für die Tabelle `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indizes für die Tabelle `sectors`
--
ALTER TABLE `sectors`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `auditors`
--
ALTER TABLE `auditors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `audit_report`
--
ALTER TABLE `audit_report`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `auth_groups_users`
--
ALTER TABLE `auth_groups_users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `auth_identities`
--
ALTER TABLE `auth_identities`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `auth_logins`
--
ALTER TABLE `auth_logins`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT für Tabelle `auth_permissions_users`
--
ALTER TABLE `auth_permissions_users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `auth_remember_tokens`
--
ALTER TABLE `auth_remember_tokens`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `auth_token_logins`
--
ALTER TABLE `auth_token_logins`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT für Tabelle `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT für Tabelle `esrs_reportvalue`
--
ALTER TABLE `esrs_reportvalue`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2193;

--
-- AUTO_INCREMENT für Tabelle `esrs_requirements`
--
ALTER TABLE `esrs_requirements`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT für Tabelle `esrs_standards`
--
ALTER TABLE `esrs_standards`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT für Tabelle `industries`
--
ALTER TABLE `industries`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT für Tabelle `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT für Tabelle `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT für Tabelle `sectors`
--
ALTER TABLE `sectors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT für Tabelle `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `audit_report`
--
ALTER TABLE `audit_report`
  ADD CONSTRAINT `audit_report_ibfk_1` FOREIGN KEY (`auditor_id`) REFERENCES `auditors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `audit_report_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `auth_groups_users`
--
ALTER TABLE `auth_groups_users`
  ADD CONSTRAINT `auth_groups_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `auth_identities`
--
ALTER TABLE `auth_identities`
  ADD CONSTRAINT `auth_identities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `auth_permissions_users`
--
ALTER TABLE `auth_permissions_users`
  ADD CONSTRAINT `auth_permissions_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `auth_remember_tokens`
--
ALTER TABLE `auth_remember_tokens`
  ADD CONSTRAINT `auth_remember_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `companies_ibfk_2` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints der Tabelle `esrs_reportvalue`
--
ALTER TABLE `esrs_reportvalue`
  ADD CONSTRAINT `esrs_reportvalue_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `esrs_reportvalue_ibfk_2` FOREIGN KEY (`requirement_id`) REFERENCES `esrs_requirements` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `esrs_reportvalue_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints der Tabelle `esrs_requirements`
--
ALTER TABLE `esrs_requirements`
  ADD CONSTRAINT `esrs_requirements_ibfk_1` FOREIGN KEY (`standard_id`) REFERENCES `esrs_standards` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints der Tabelle `industries`
--
ALTER TABLE `industries`
  ADD CONSTRAINT `industries_ibfk_1` FOREIGN KEY (`sector_id`) REFERENCES `sectors` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints der Tabelle `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `jobs_ibfk_2` FOREIGN KEY (`standard_id`) REFERENCES `esrs_standards` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `jobs_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints der Tabelle `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
