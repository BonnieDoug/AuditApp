-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 15, 2016 at 04:18 PM
-- Server version: 5.1.73
-- PHP Version: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `prod_audit`
--

-- --------------------------------------------------------

--
-- Table structure for table `Answers`
--

CREATE TABLE IF NOT EXISTS `Answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` int(100) NOT NULL,
  `expiry` datetime DEFAULT NULL,
  `evidence` varchar(255) DEFAULT NULL,
  `assignment_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `Questions_id` int(11) NOT NULL,
  `answered_by` int(11) NOT NULL,
  `answered_at` datetime NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `FK_Questions_Answers_ID_0001` (`Questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ApiKeys`
--

CREATE TABLE IF NOT EXISTS `ApiKeys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(6) NOT NULL,
  `private_key` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`private_key`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AssetGroups`
--

CREATE TABLE IF NOT EXISTS `AssetGroups` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `client_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `forename_label` varchar(255) NOT NULL COMMENT 'Forename, Model (Golf)',
  `middlename_label` varchar(255) NOT NULL COMMENT 'Middlenames, Model Variant (GTI)',
  `surname_label` varchar(255) NOT NULL COMMENT 'Surname, Brand (VW)',
  `dob_label` varchar(255) NOT NULL COMMENT 'DOB, Manufacture Date, Build Date',
  `start_label` varchar(255) NOT NULL COMMENT 'Employment start, Product Bought',
  `uniquecode_label` varchar(255) NOT NULL COMMENT 'NI/Serial/Reg Plate',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `AssetGroups`
--

INSERT INTO `AssetGroups` (`id`, `name`, `client_id`, `user_id`, `retired`, `forename_label`, `middlename_label`, `surname_label`, `dob_label`, `start_label`, `uniquecode_label`) VALUES
(1, 'Machinery', 0, 0, 0, 'Model', 'Variant', 'Brand', 'Build Date', 'Purchase Date', 'Serial / Registration'),
(2, 'People', 0, 0, 0, 'Forename', 'Middlenames', 'Surname', 'Date of Birth', 'Employment Started', 'National Insurance'),
(3, 'Location''s', 0, 0, 0, 'Site Name', '', 'Company Name', 'Build Date', 'Purchase Date', 'Company Registration Number');

-- --------------------------------------------------------

--
-- Table structure for table `Assets`
--

CREATE TABLE IF NOT EXISTS `Assets` (
  `id` int(200) NOT NULL AUTO_INCREMENT,
  `forename` varchar(255) NOT NULL COMMENT 'Forename, Model etc Doug, A200, Aspire',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlenames/Model Variant',
  `surname` varchar(255) DEFAULT NULL COMMENT 'Forename, Brand etc i.e Hayward, Mercedes, Acer',
  `unique_ref_code` varchar(255) DEFAULT NULL COMMENT 'National Insurance, Serial Number etc',
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `Counties_id` int(10) DEFAULT NULL COMMENT 'FK to county table',
  `Countries_id` int(10) DEFAULT NULL COMMENT 'FK to country table',
  `postcode` varchar(10) DEFAULT NULL,
  `dob` datetime DEFAULT NULL COMMENT 'Date of birth / Production date',
  `start_date` datetime DEFAULT NULL COMMENT 'First employed / Bought',
  `created_date` datetime NOT NULL COMMENT 'When asset was created',
  `updated_date` datetime DEFAULT NULL COMMENT 'Last updated if ever',
  `client_id` int(10) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 Not-Retired / 1 Retired',
  `AssetGroups_id` int(10) NOT NULL,
  `AssetTypes_id` int(10) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `AssetGroups_id` (`AssetGroups_id`),
  KEY `AssetTypes_id` (`AssetTypes_id`),
  KEY `Counties_id` (`Counties_id`),
  KEY `Countries_id` (`Countries_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=45 ;

--
-- Dumping data for table `Assets`
--

INSERT INTO `Assets` (`id`, `forename`, `middlename`, `surname`, `unique_ref_code`, `address1`, `address2`, `Counties_id`, `Countries_id`, `postcode`, `dob`, `start_date`, `created_date`, `updated_date`, `client_id`, `retired`, `AssetGroups_id`, `AssetTypes_id`, `image`) VALUES
(1, 'Doug', NULL, NULL, 'JN 89 49 35 D', '18 Kent Street', 'Hasland', 8, 229, 'S410PL', '1989-03-10 00:00:00', '2015-05-14 00:00:00', '2016-04-05 00:00:00', NULL, 5350, 0, 2, 16, '2d4d5468003b47883fe08a806c5a0c94.jpeg'),
(2, 'John', NULL, 'Smith', 'AB 12 34 56 B', '1 Someplace Street', 'Somewhere', 5, 220, 'A12 3BC', '1988-11-23 00:00:00', '2015-04-15 00:00:00', '2016-04-06 00:00:00', NULL, 0, 1, 2, 15, '2d4d5468003b47883fe08a806c5a0c94.jpeg'),
(3, 'MODEL NAME HERE', 'VARIANT HERE', 'BRAND HERE', 'REGISTRATION HERE', 'ADDDRESSS LINE ONE', 'ADDDRESSS LINE TWO', 50, 229, 'POSTCODE H', '2016-04-13 23:00:00', '2016-04-13 23:00:00', '2016-04-08 09:38:08', NULL, 0, 1, 1, 2, '2d4d5468003b47883fe08a806c5a0c94.jpeg'),
(4, 'A Name', 'A Middle Name', 'A Surname', 'SomeUniqueCode', 'Line one address', 'Line 2', 74, 229, 'postcode', '1989-10-02 23:00:00', '2016-04-12 23:00:00', '2016-04-08 13:49:02', NULL, 0, 1, 2, 15, '2d4d5468003b47883fe08a806c5a0c94.jpeg'),
(22, '09808', '', '', '', '', '', 74, 229, '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2016-04-08 16:57:02', NULL, 0, 1, 1, 2, '6dd572122222967a8c9d545dbe3adb11.png'),
(23, 'A New Asset', 'With a middle name', 'Surname', 'NI Number', 'Here', 'There', 8, 229, 'Everywhere', '1989-10-02 23:00:00', '2016-04-12 23:00:00', '2016-04-11 08:49:44', NULL, 0, 1, 2, 16, '6dd572122222967a8c9d545dbe3adb11.png'),
(24, 'ijoi', 'ijoij', 'oijoijioj', 'oijoijoij', '897987', '987987', 74, 229, '987987', '2016-04-11 23:00:00', '2016-04-12 23:00:00', '2016-04-11 08:55:30', NULL, 0, 1, 1, 2, '6dd572122222967a8c9d545dbe3adb11.png'),
(25, 'ijoi', 'ijoij', 'oijoijioj', 'oijoijoij', '897987', '987987', 74, 229, '987987', '2016-04-11 23:00:00', '2016-04-12 23:00:00', '2016-04-11 09:01:03', NULL, 0, 1, 1, 2, '6dd572122222967a8c9d545dbe3adb11.png'),
(26, '1', '2', '3', '4', '1', '2', 74, 229, '3', '2016-04-10 23:00:00', '2016-04-11 23:00:00', '2016-04-11 09:12:41', NULL, 0, 1, 2, 16, 'f6cbfb6d4190e52a3fdb50db73ddf8bf.png'),
(27, '876', '876876', '876876786', '876876876', '77', '777', 74, 229, '77', '2016-04-03 23:00:00', '2016-04-07 23:00:00', '2016-04-11 09:52:59', NULL, 0, 1, 1, 3, 'b8e47789e747e1165e38dc4cd5823522.png'),
(28, '876', '876876', '876876786', '876876876', '77', '777', 74, 229, '77', '2016-04-03 23:00:00', '2016-04-07 23:00:00', '2016-04-11 09:53:12', NULL, 0, 1, 1, 3, 'b8e47789e747e1165e38dc4cd5823522.png'),
(29, '876', '876876', '876876786', '876876876', '77', '777', 74, 229, '77', '2016-04-03 23:00:00', '2016-04-07 23:00:00', '2016-04-11 09:53:12', NULL, 0, 1, 1, 3, 'b8e47789e747e1165e38dc4cd5823522.png'),
(30, '876', '876876', '876876786', '876876876', '77', '777', 74, 229, '77', '2016-04-03 23:00:00', '2016-04-07 23:00:00', '2016-04-11 09:53:12', NULL, 0, 1, 1, 3, 'b8e47789e747e1165e38dc4cd5823522.png'),
(31, '876', '876876', '876876786', '876876876', '77', '777', 74, 229, '77', '2016-04-03 23:00:00', '2016-04-07 23:00:00', '2016-04-11 09:53:13', NULL, 0, 1, 1, 3, 'b8e47789e747e1165e38dc4cd5823522.png'),
(32, '876', '876876', '876876786', '876876876', '77', '777', 74, 229, '77', '2016-04-03 23:00:00', '2016-04-07 23:00:00', '2016-04-11 09:53:13', NULL, 0, 1, 1, 3, 'b8e47789e747e1165e38dc4cd5823522.png'),
(33, '876', '876876', '876876786', '876876876', '77', '777', 74, 229, '77', '2016-04-03 23:00:00', '2016-04-07 23:00:00', '2016-04-11 09:53:13', NULL, 0, 0, 1, 3, 'b8e47789e747e1165e38dc4cd5823522.png'),
(34, '56', '', '55', '55', '777', '777', 74, 229, '777', '2016-04-12 23:00:00', '2016-04-12 23:00:00', '2016-04-11 09:54:33', NULL, 0, 0, 3, 8, 'cd29f2620f12c6bfc5995fa5880d9a6e.png'),
(35, '56', '', '55', '55', '777', '777', 74, 229, '777', '2016-04-12 23:00:00', '2016-04-12 23:00:00', '2016-04-11 09:55:33', NULL, 0, 0, 3, 8, 'cd29f2620f12c6bfc5995fa5880d9a6e.png'),
(36, '56', '', '55', '55', '777', '777', 74, 229, '777', '2016-04-12 23:00:00', '2016-04-12 23:00:00', '2016-04-11 09:55:48', NULL, 0, 0, 3, 8, 'cd29f2620f12c6bfc5995fa5880d9a6e.png'),
(37, '786', '876', '876', '876', '098', '098', 74, 229, '08', '2016-04-19 23:00:00', '2016-04-17 23:00:00', '2016-04-11 09:56:59', NULL, 0, 1, 2, 15, 'ccdb2f9257311675aedd29cac4dab013.png'),
(38, 'Some model', 'of some variant', 'of some brand', 'ipjpoj', 'opipoi', 'poipoi', 50, 229, 'poi', '2016-04-13 23:00:00', '2016-04-21 23:00:00', '2016-04-13 13:04:57', NULL, 0, 0, 1, 2, '66b32588f3fe73f0fad92ca977a38e62.jpg'),
(39, 'Some model', 'Variant', 'and Brand', '098098', '-9-09', '908098', 80, 229, '098098', '2016-04-20 23:00:00', '2016-04-22 23:00:00', '2016-04-13 13:07:00', NULL, 5350, 0, 1, 2, '84d25b2f3d61ff9853e1568d7692ac8c.jpg'),
(40, 'P1', '3.8L twin-turbo M838TQ V8', 'Mclaren', 'mcl4r3n', '1 House', 'Nowhere near mine', 29, 229, 'a12 0bc', '2016-03-17 00:00:00', '2016-04-13 23:00:00', '2016-04-13 15:52:38', NULL, 5350, 0, 1, 1, 'f8119f844774c9a79e2725b78ec7d189.jpg'),
(41, 'Its Big', 'Its Blue', 'And a Lorry', '123 ABC', 'Somewhere', 'Someplace', 44, 229, '123123', '1999-09-30 23:00:00', '2015-07-21 23:00:00', '2016-04-13 16:45:12', NULL, 5350, 0, 1, 3, '1e75c75baed7fc44aaa14249bf974c45.jpg'),
(43, 'Stealth Jet', 'Black', 'Big Ass', '928739173987', 'Some Govermeant place', 'Spying on people', 50, 83, '', '2015-09-02 23:00:00', '2016-09-25 23:00:00', '2016-04-13 16:46:57', NULL, 5350, 0, 1, 4, '4f823553421f228ae502835c7737060e.jpg'),
(44, 'Tank', 'Killing Machine', 'British', 'B1g A55 T4NK', 'Here', 'There', 10, 229, 'Everywhere', '1914-03-01 00:00:00', '2016-04-19 23:00:00', '2016-04-13 16:48:33', NULL, 5350, 0, 1, 5, '09c98f60f39e5475232ca4bb07f31e3a.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `AssetTypes`
--

CREATE TABLE IF NOT EXISTS `AssetTypes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `client_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `AssetGroups_id` int(10) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `AssetGroups_id` (`AssetGroups_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `AssetTypes`
--

INSERT INTO `AssetTypes` (`id`, `name`, `client_id`, `user_id`, `AssetGroups_id`, `retired`) VALUES
(1, 'Car', 0, 0, 1, 0),
(2, 'Bike', 0, 0, 1, 0),
(3, 'Lorry', 0, 0, 1, 0),
(4, 'Airplane', 0, 0, 1, 0),
(5, 'Tank', 0, 0, 1, 0),
(6, 'Ship', 0, 0, 1, 0),
(7, 'Digger', 0, 0, 1, 0),
(8, 'Factory', 0, 0, 3, 0),
(9, 'Building Site', 0, 0, 3, 0),
(10, 'Home', 0, 0, 3, 0),
(11, 'Office', 0, 0, 3, 0),
(12, 'Holiday Home', 0, 0, 3, 0),
(13, 'Farm', 0, 0, 3, 0),
(14, 'Zoo', 0, 0, 3, 0),
(15, 'Employer', 0, 0, 2, 0),
(16, 'Employee', 0, 0, 2, 0),
(17, 'Contractor', 0, 0, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Assignments`
--

CREATE TABLE IF NOT EXISTS `Assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Audits_id` int(11) NOT NULL,
  `Assets_id` int(11) NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `assigned_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Audits_id` (`Audits_id`),
  KEY `Assets_id` (`Assets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AuditDatas`
--

CREATE TABLE IF NOT EXISTS `AuditDatas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `AuditTypes_id` int(11) NOT NULL,
  `retired` int(1) NOT NULL DEFAULT '0',
  `Audits_id` int(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `client_id` (`client_id`),
  KEY `created_by` (`user_id`),
  KEY `AuditTypes_Audits_ID_FK1` (`AuditTypes_id`),
  KEY `Audits_id` (`Audits_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `AuditDatas`
--

INSERT INTO `AuditDatas` (`id`, `name`, `description`, `created_at`, `client_id`, `user_id`, `AuditTypes_id`, `retired`, `Audits_id`, `updated_at`) VALUES
(1, 'Audit 1', 'With a description', '2016-04-15 09:44:20', 5350, 13508, 5, 1, 1, '2016-04-15 09:54:02'),
(3, 'Audit 1 - Updated', 'With a description - Updated', '2016-04-15 09:54:02', 5350, 13508, 5, 0, 1, NULL),
(4, 'Audit 2', 'Audit2', '2016-04-15 11:00:42', 5350, 13508, 4, 0, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Audits`
--

CREATE TABLE IF NOT EXISTS `Audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `retired` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `client_id` (`client_id`),
  KEY `created_by` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `Audits`
--

INSERT INTO `Audits` (`id`, `client_id`, `user_id`, `retired`) VALUES
(1, 5350, 13508, 0),
(2, 5350, 13508, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Audits_BK`
--

CREATE TABLE IF NOT EXISTS `Audits_BK` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `AuditTypes_id` int(11) NOT NULL,
  `retired` int(1) NOT NULL DEFAULT '0',
  `parent` int(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `client_id` (`client_id`),
  KEY `created_by` (`created_by`),
  KEY `AuditTypes_Audits_ID_FK1` (`AuditTypes_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `Audits_BK`
--

INSERT INTO `Audits_BK` (`id`, `name`, `description`, `created_at`, `client_id`, `created_by`, `AuditTypes_id`, `retired`, `parent`, `updated_at`) VALUES
(1, 'Audit 1', 'This is Audit 1', '2016-04-04 16:12:57', 5350, 123, 3, 0, 0, '2016-04-04 16:13:18'),
(2, 'Audit 1 - Updated', 'This is Audit 1', '2016-04-04 16:13:15', 0, 123, 3, 1, 1, NULL),
(3, 'Audit 1 - Updated', 'This is Audit 1', '2016-04-04 16:13:19', 0, 123, 3, 1, 1, '2016-04-04 16:14:27'),
(4, 'Audit 1 - Updated again', 'This is Audit 1', '2016-04-04 16:14:27', 0, 123, 3, 1, 3, '2016-04-11 08:47:09'),
(5, 'Audit 2', 'Audit 2', '2016-04-05 08:58:01', 0, 123, 4, 1, 0, NULL),
(6, 'Audit 3', 'Audit 3 description of.', '2016-04-05 08:59:29', 0, 123, 2, 1, 0, '2016-04-11 08:38:19'),
(7, 'Audit 4', 'Yet another audit', '2016-04-05 09:00:06', 0, 123, 10, 1, 0, '2016-04-05 09:00:50'),
(8, 'Audit 4', 'Yet another audit', '2016-04-05 09:00:09', 0, 123, 10, 1, 0, '2016-04-05 09:00:36'),
(9, 'Audit 4', 'Yet another audit', '2016-04-05 09:00:13', 0, 123, 10, 1, 0, NULL),
(10, 'Audit 5', 'Yet another audit', '2016-04-05 09:00:36', 0, 123, 10, 1, 8, NULL),
(11, 'Audit 7', 'Yet another audit', '2016-04-05 09:00:50', 0, 123, 10, 1, 7, NULL),
(16, 'Audit 1 - Updated again AND AGAIN', 'This is Audit 1', '2016-04-11 08:47:09', 0, 123, 4, 1, 4, '2016-04-11 08:47:50'),
(17, 'Audit 1 - Updated again AND ONCE AGAIN', 'This should have legionella type', '2016-04-11 08:47:50', 0, 123, 5, 1, 16, NULL),
(20, '1', '2', '2016-04-11 09:23:53', 0, 123, 4, 1, 0, NULL),
(21, 'Test', '5350', '2016-04-13 10:27:46', 5350, 13508, 3, 1, 0, NULL),
(22, 'Test Audit by 5350', 'with 4 questions 2 groups and audit type legionella', '2016-04-13 10:51:07', 5350, 13508, 5, 1, 0, NULL),
(23, 'Test Audit by 5350', 'with 4 questions 2 groups and audit type legionella', '2016-04-13 10:51:31', 5350, 13508, 5, 1, 0, NULL),
(24, 'Test Audit by 5350', 'with 4 questions 2 groups and audit type legionella', '2016-04-13 10:51:44', 5350, 13508, 5, 1, 0, NULL),
(25, 'Shouldnt 404', '1', '2016-04-13 11:07:53', 5350, 13508, 2, 1, 0, NULL),
(26, 'Shouldnt 404', 'Has been updated', '2016-04-13 11:47:52', 5350, 13508, 2, 1, 0, '2016-04-13 11:53:26'),
(27, 'Shouldnt 404 - Retired one', 'Has been updated', '2016-04-13 11:51:33', 5350, 13508, 2, 1, 0, NULL),
(28, 'Shouldnt 404 - Retired one', 'Has been updated', '2016-04-13 11:53:26', 5350, 13508, 2, 1, 26, '2016-04-13 11:55:54'),
(29, 'Shouldnt 404 - Retired two', 'Has been updated', '2016-04-13 11:55:54', 5350, 13508, 2, 1, 28, '2016-04-13 11:56:16'),
(30, 'Shouldnt 404 - Retired three', 'Has been updated', '2016-04-13 11:56:16', 5350, 13508, 2, 0, 29, NULL),
(31, 'SOmething else', '123', '2016-04-13 12:20:15', 5350, 13508, 5, 1, 0, '2016-04-13 12:20:30'),
(32, 'SOmething else - Updated', '123', '2016-04-13 12:20:30', 5350, 13508, 5, 0, 31, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `AuditTypes`
--

CREATE TABLE IF NOT EXISTS `AuditTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `AuditTypes`
--

INSERT INTO `AuditTypes` (`id`, `name`, `client_id`) VALUES
(1, 'Vehicle Service', 0),
(2, 'MOT', 0),
(3, 'Site Audit', 0),
(4, 'Gap Analysis', 0),
(5, 'Legionella', 0),
(6, 'Employee Appraisal', 0),
(7, 'Interview', 0),
(8, 'KPI', 0),
(9, 'Home Inspection', 0),
(10, 'Fire Check', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Counties`
--

CREATE TABLE IF NOT EXISTS `Counties` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=89 ;

--
-- Dumping data for table `Counties`
--

INSERT INTO `Counties` (`id`, `name`) VALUES
(73, 'Aberdeenshire'),
(50, 'Anglesey'),
(74, 'Angus'),
(75, 'Argyll'),
(76, 'Ayrshire'),
(77, 'Banffshire'),
(2, 'Bedfordshire'),
(78, 'Berwickshire'),
(51, 'Breconshire'),
(3, 'Buckinghamshire'),
(79, 'Bute'),
(52, 'Caernarvonshire'),
(80, 'Caithness'),
(4, 'Cambridgeshire'),
(53, 'Cardiganshire'),
(54, 'Carmarthenshire'),
(5, 'Cheshire'),
(81, 'Clackmannanshire'),
(6, 'Cornwall and Isles of Scilly'),
(7, 'Cumbria'),
(55, 'Denbighshire'),
(8, 'Derbyshire'),
(9, 'Devon'),
(10, 'Dorset'),
(83, 'Dumbartonshire'),
(82, 'Dumfriesshire'),
(11, 'Durham'),
(84, 'East Lothian'),
(12, 'East Sussex'),
(13, 'Essex'),
(85, 'Fife'),
(43, 'Flintshire'),
(44, 'Glamorgan'),
(14, 'Gloucestershire'),
(15, 'Greater London'),
(16, 'Greater Manchester'),
(17, 'Hampshire'),
(18, 'Hertfordshire'),
(86, 'Inverness'),
(19, 'Kent'),
(87, 'Kincardineshire'),
(88, 'Kinross-shire'),
(56, 'Kirkcudbrightshire'),
(57, 'Lanarkshire'),
(20, 'Lancashire'),
(21, 'Leicestershire'),
(22, 'Lincolnshire'),
(1, 'London'),
(45, 'Merionethshire'),
(23, 'Merseyside'),
(58, 'Midlothian'),
(46, 'Monmouthshire'),
(47, 'Montgomeryshire'),
(59, 'Moray'),
(60, 'Nairnshire'),
(24, 'Norfolk'),
(25, 'North Yorkshire'),
(26, 'Northamptonshire'),
(27, 'Northumberland'),
(28, 'Nottinghamshire'),
(61, 'Orkney'),
(29, 'Oxfordshire'),
(62, 'Peebleshire'),
(48, 'Pembrokeshire'),
(63, 'Perthshire'),
(49, 'Radnorshire'),
(64, 'Renfrewshire'),
(65, 'Ross & Cromarty'),
(66, 'Roxburghshire'),
(67, 'Selkirkshire'),
(68, 'Shetland'),
(30, 'Shropshire'),
(31, 'Somerset'),
(32, 'South Yorkshire'),
(33, 'Staffordshire'),
(69, 'Stirlingshire'),
(34, 'Suffolk'),
(35, 'Surrey'),
(70, 'Sutherland'),
(36, 'Tyne and Wear'),
(37, 'Warwickshire'),
(71, 'West Lothian'),
(38, 'West Midlands'),
(39, 'West Sussex'),
(40, 'West Yorkshire'),
(72, 'Wigtownshire'),
(41, 'Wiltshire'),
(42, 'Worcestershire');

-- --------------------------------------------------------

--
-- Table structure for table `Countries`
--

CREATE TABLE IF NOT EXISTS `Countries` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(3) NOT NULL,
  `name` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `country_code` (`country_code`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=247 ;

--
-- Dumping data for table `Countries`
--

INSERT INTO `Countries` (`id`, `country_code`, `name`, `enabled`) VALUES
(1, 'AF', 'Afghanistan', 1),
(2, 'AL', 'Albania', 1),
(3, 'DZ', 'Algeria', 1),
(4, 'DS', 'American Samoa', 1),
(5, 'AD', 'Andorra', 1),
(6, 'AO', 'Angola', 1),
(7, 'AI', 'Anguilla', 1),
(8, 'AQ', 'Antarctica', 1),
(9, 'AG', 'Antigua and Barbuda', 1),
(10, 'AR', 'Argentina', 1),
(11, 'AM', 'Armenia', 1),
(12, 'AW', 'Aruba', 1),
(13, 'AU', 'Australia', 1),
(14, 'AT', 'Austria', 1),
(15, 'AZ', 'Azerbaijan', 1),
(16, 'BS', 'Bahamas', 1),
(17, 'BH', 'Bahrain', 1),
(18, 'BD', 'Bangladesh', 1),
(19, 'BB', 'Barbados', 1),
(20, 'BY', 'Belarus', 1),
(21, 'BE', 'Belgium', 1),
(22, 'BZ', 'Belize', 1),
(23, 'BJ', 'Benin', 1),
(24, 'BM', 'Bermuda', 1),
(25, 'BT', 'Bhutan', 1),
(26, 'BO', 'Bolivia', 1),
(27, 'BA', 'Bosnia and Herzegovina', 1),
(28, 'BW', 'Botswana', 1),
(29, 'BV', 'Bouvet Island', 1),
(30, 'BR', 'Brazil', 1),
(31, 'IO', 'British Indian Ocean Territory', 1),
(32, 'BN', 'Brunei Darussalam', 1),
(33, 'BG', 'Bulgaria', 1),
(34, 'BF', 'Burkina Faso', 1),
(35, 'BI', 'Burundi', 1),
(36, 'KH', 'Cambodia', 1),
(37, 'CM', 'Cameroon', 1),
(38, 'CA', 'Canada', 1),
(39, 'CV', 'Cape Verde', 1),
(40, 'KY', 'Cayman Islands', 1),
(41, 'CF', 'Central African Republic', 1),
(42, 'TD', 'Chad', 1),
(43, 'CL', 'Chile', 1),
(44, 'CN', 'China', 1),
(45, 'CX', 'Christmas Island', 1),
(46, 'CC', 'Cocos (Keeling) Islands', 1),
(47, 'CO', 'Colombia', 1),
(48, 'KM', 'Comoros', 1),
(49, 'CG', 'Congo', 1),
(50, 'CK', 'Cook Islands', 1),
(51, 'CR', 'Costa Rica', 1),
(52, 'HR', 'Croatia (Hrvatska)', 1),
(53, 'CU', 'Cuba', 1),
(54, 'CY', 'Cyprus', 1),
(55, 'CZ', 'Czech Republic', 1),
(56, 'DK', 'Denmark', 1),
(57, 'DJ', 'Djibouti', 1),
(58, 'DM', 'Dominica', 1),
(59, 'DO', 'Dominican Republic', 1),
(60, 'TP', 'East Timor', 1),
(61, 'EC', 'Ecuador', 1),
(62, 'EG', 'Egypt', 1),
(63, 'SV', 'El Salvador', 1),
(64, 'GQ', 'Equatorial Guinea', 1),
(65, 'ER', 'Eritrea', 1),
(66, 'EE', 'Estonia', 1),
(67, 'ET', 'Ethiopia', 1),
(68, 'FK', 'Falkland Islands (Malvinas)', 1),
(69, 'FO', 'Faroe Islands', 1),
(70, 'FJ', 'Fiji', 1),
(71, 'FI', 'Finland', 1),
(72, 'FR', 'France', 1),
(73, 'FX', 'France, Metropolitan', 1),
(74, 'GF', 'French Guiana', 1),
(75, 'PF', 'French Polynesia', 1),
(76, 'TF', 'French Southern Territories', 1),
(77, 'GA', 'Gabon', 1),
(78, 'GM', 'Gambia', 1),
(79, 'GE', 'Georgia', 1),
(80, 'DE', 'Germany', 1),
(81, 'GH', 'Ghana', 1),
(82, 'GI', 'Gibraltar', 1),
(83, 'GK', 'Guernsey', 1),
(84, 'GR', 'Greece', 1),
(85, 'GL', 'Greenland', 1),
(86, 'GD', 'Grenada', 1),
(87, 'GP', 'Guadeloupe', 1),
(88, 'GU', 'Guam', 1),
(89, 'GT', 'Guatemala', 1),
(90, 'GN', 'Guinea', 1),
(91, 'GW', 'Guinea-Bissau', 1),
(92, 'GY', 'Guyana', 1),
(93, 'HT', 'Haiti', 1),
(94, 'HM', 'Heard and Mc Donald Islands', 1),
(95, 'HN', 'Honduras', 1),
(96, 'HK', 'Hong Kong', 1),
(97, 'HU', 'Hungary', 1),
(98, 'IS', 'Iceland', 1),
(99, 'IN', 'India', 1),
(100, 'IM', 'Isle of Man', 1),
(101, 'ID', 'Indonesia', 1),
(102, 'IR', 'Iran (Islamic Republic of)', 1),
(103, 'IQ', 'Iraq', 1),
(104, 'IE', 'Ireland', 1),
(105, 'IL', 'Israel', 1),
(106, 'IT', 'Italy', 1),
(107, 'CI', 'Ivory Coast', 1),
(108, 'JE', 'Jersey', 1),
(109, 'JM', 'Jamaica', 1),
(110, 'JP', 'Japan', 1),
(111, 'JO', 'Jordan', 1),
(112, 'KZ', 'Kazakhstan', 1),
(113, 'KE', 'Kenya', 1),
(114, 'KI', 'Kiribati', 1),
(115, 'KP', 'Korea, People''s Republic', 1),
(116, 'KR', 'Korea, Republic of', 1),
(117, 'XK', 'Kosovo', 1),
(118, 'KW', 'Kuwait', 1),
(119, 'KG', 'Kyrgyzstan', 1),
(120, 'LA', 'Lao Democratic Republic', 1),
(121, 'LV', 'Latvia', 1),
(122, 'LB', 'Lebanon', 1),
(123, 'LS', 'Lesotho', 1),
(124, 'LR', 'Liberia', 1),
(125, 'LY', 'Libyan Arab Jamahiriya', 1),
(126, 'LI', 'Liechtenstein', 1),
(127, 'LT', 'Lithuania', 1),
(128, 'LU', 'Luxembourg', 1),
(129, 'MO', 'Macau', 1),
(130, 'MK', 'Macedonia', 1),
(131, 'MG', 'Madagascar', 1),
(132, 'MW', 'Malawi', 1),
(133, 'MY', 'Malaysia', 1),
(134, 'MV', 'Maldives', 1),
(135, 'ML', 'Mali', 1),
(136, 'MT', 'Malta', 1),
(137, 'MH', 'Marshall Islands', 1),
(138, 'MQ', 'Martinique', 1),
(139, 'MR', 'Mauritania', 1),
(140, 'MU', 'Mauritius', 1),
(141, 'TY', 'Mayotte', 1),
(142, 'MX', 'Mexico', 1),
(143, 'FM', 'Micronesia', 1),
(144, 'MD', 'Moldova, Republic of', 1),
(145, 'MC', 'Monaco', 1),
(146, 'MN', 'Mongolia', 1),
(147, 'ME', 'Montenegro', 1),
(148, 'MS', 'Montserrat', 1),
(149, 'MA', 'Morocco', 1),
(150, 'MZ', 'Mozambique', 1),
(151, 'MM', 'Myanmar', 1),
(152, 'NA', 'Namibia', 1),
(153, 'NR', 'Nauru', 1),
(154, 'NP', 'Nepal', 1),
(155, 'NL', 'Netherlands', 1),
(156, 'AN', 'Netherlands Antilles', 1),
(157, 'NC', 'New Caledonia', 1),
(158, 'NZ', 'New Zealand', 1),
(159, 'NI', 'Nicaragua', 1),
(160, 'NE', 'Niger', 1),
(161, 'NG', 'Nigeria', 1),
(162, 'NU', 'Niue', 1),
(163, 'NF', 'Norfolk Island', 1),
(164, 'MP', 'Northern Mariana Islands', 1),
(165, 'NO', 'Norway', 1),
(166, 'OM', 'Oman', 1),
(167, 'PK', 'Pakistan', 1),
(168, 'PW', 'Palau', 1),
(169, 'PS', 'Palestine', 1),
(170, 'PA', 'Panama', 1),
(171, 'PG', 'Papua New Guinea', 1),
(172, 'PY', 'Paraguay', 1),
(173, 'PE', 'Peru', 1),
(174, 'PH', 'Philippines', 1),
(175, 'PN', 'Pitcairn', 1),
(176, 'PL', 'Poland', 1),
(177, 'PT', 'Portugal', 1),
(178, 'PR', 'Puerto Rico', 1),
(179, 'QA', 'Qatar', 1),
(180, 'RE', 'Reunion', 1),
(181, 'RO', 'Romania', 1),
(182, 'RU', 'Russian Federation', 1),
(183, 'RW', 'Rwanda', 1),
(184, 'KN', 'Saint Kitts and Nevis', 1),
(185, 'LC', 'Saint Lucia', 1),
(186, 'VC', 'Saint Vincent and the Grenadines', 1),
(187, 'WS', 'Samoa', 1),
(188, 'SM', 'San Marino', 1),
(189, 'ST', 'Sao Tome and Principe', 1),
(190, 'SA', 'Saudi Arabia', 1),
(191, 'SN', 'Senegal', 1),
(192, 'RS', 'Serbia', 1),
(193, 'SC', 'Seychelles', 1),
(194, 'SL', 'Sierra Leone', 1),
(195, 'SG', 'Singapore', 1),
(196, 'SK', 'Slovakia', 1),
(197, 'SI', 'Slovenia', 1),
(198, 'SB', 'Solomon Islands', 1),
(199, 'SO', 'Somalia', 1),
(200, 'ZA', 'South Africa', 1),
(201, 'GS', 'South Georgia South Sandwich Islands', 1),
(202, 'ES', 'Spain', 1),
(203, 'LK', 'Sri Lanka', 1),
(204, 'SH', 'St. Helena', 1),
(205, 'PM', 'St. Pierre and Miquelon', 1),
(206, 'SD', 'Sudan', 1),
(207, 'SR', 'Suriname', 1),
(208, 'SJ', 'Svalbard and Jan Mayen Islands', 1),
(209, 'SZ', 'Swaziland', 1),
(210, 'SE', 'Sweden', 1),
(211, 'CH', 'Switzerland', 1),
(212, 'SY', 'Syrian Arab Republic', 1),
(213, 'TW', 'Taiwan', 1),
(214, 'TJ', 'Tajikistan', 1),
(215, 'TZ', 'Tanzania, United Republic of', 1),
(216, 'TH', 'Thailand', 1),
(217, 'TG', 'Togo', 1),
(218, 'TK', 'Tokelau', 1),
(219, 'TO', 'Tonga', 1),
(220, 'TT', 'Trinidad and Tobago', 1),
(221, 'TN', 'Tunisia', 1),
(222, 'TR', 'Turkey', 1),
(223, 'TM', 'Turkmenistan', 1),
(224, 'TC', 'Turks and Caicos Islands', 1),
(225, 'TV', 'Tuvalu', 1),
(226, 'UG', 'Uganda', 1),
(227, 'UA', 'Ukraine', 1),
(228, 'AE', 'United Arab Emirates', 1),
(229, 'GB', 'United Kingdom', 1),
(230, 'US', 'United States', 1),
(231, 'UM', 'United States minor outlying islands', 1),
(232, 'UY', 'Uruguay', 1),
(233, 'UZ', 'Uzbekistan', 1),
(234, 'VU', 'Vanuatu', 1),
(235, 'VA', 'Vatican City State', 1),
(236, 'VE', 'Venezuela', 1),
(237, 'VN', 'Vietnam', 1),
(238, 'VG', 'Virgin Islands (British)', 1),
(239, 'VI', 'Virgin Islands (U.S.)', 1),
(240, 'WF', 'Wallis and Futuna Islands', 1),
(241, 'EH', 'Western Sahara', 1),
(242, 'YE', 'Yemen', 1),
(243, 'YU', 'Yugoslavia', 1),
(244, 'ZR', 'Zaire', 1),
(245, 'ZM', 'Zambia', 1),
(246, 'ZW', 'Zimbabwe', 1);

-- --------------------------------------------------------

--
-- Table structure for table `QuestionGroups`
--

CREATE TABLE IF NOT EXISTS `QuestionGroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `audit_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_id` (`audit_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `QuestionGroups`
--

INSERT INTO `QuestionGroups` (`id`, `name`, `audit_id`, `client_id`) VALUES
(1, 'Group 1', 1, 5350),
(2, 'Group 2', 1, 5350),
(3, 'Group 1 - Updated', 3, 5350),
(4, 'Group 2 - Updated', 3, 5350),
(5, 'Audit 2 Group 1', 4, 5350);

-- --------------------------------------------------------

--
-- Table structure for table `Questions`
--

CREATE TABLE IF NOT EXISTS `Questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer_required` tinyint(1) NOT NULL DEFAULT '0',
  `add_evidence` tinyint(1) NOT NULL DEFAULT '0',
  `evidence_required` tinyint(1) NOT NULL DEFAULT '0',
  `add_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `expiry_required` tinyint(1) NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `audit_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `client_id` (`client_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `Questions`
--

INSERT INTO `Questions` (`id`, `question`, `answer_required`, `add_evidence`, `evidence_required`, `add_expiry`, `expiry_required`, `type_id`, `group_id`, `client_id`, `audit_id`) VALUES
(1, 'Question 1', 1, 1, 0, 1, 0, 2, 1, 5350, 1),
(2, 'Question 2', 1, 1, 1, 1, 1, 4, 1, 5350, 1),
(3, 'Question 3', 1, 0, 0, 1, 1, 3, 2, 5350, 1),
(4, 'Question 4', 1, 1, 1, 0, 0, 1, 2, 5350, 1),
(5, 'Question 1 - Updated', 1, 1, 0, 1, 0, 2, 3, 5350, 3),
(6, 'Question 2 - Updated', 1, 1, 1, 1, 1, 4, 3, 5350, 3),
(7, 'Question 3 - Updated', 1, 0, 0, 1, 1, 3, 4, 5350, 3),
(8, 'Question 4 - Updated', 1, 1, 1, 0, 0, 1, 4, 5350, 3),
(9, 'Audit 2 Group 1 Question 1', 1, 1, 0, 0, 0, 3, 5, 5350, 4);

-- --------------------------------------------------------

--
-- Table structure for table `QuestionTypeOptions`
--

CREATE TABLE IF NOT EXISTS `QuestionTypeOptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` int(10) NOT NULL,
  `type_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `QuestionTypeOptions`
--

INSERT INTO `QuestionTypeOptions` (`id`, `name`, `value`, `type_id`, `client_id`) VALUES
(1, 'No', 0, 1, 0),
(2, 'Yes', 100, 1, 0),
(3, 'Yes', 100, 2, 0),
(4, 'No', 0, 2, 0),
(5, 'NA', 50, 2, 0),
(6, 'Bad', 0, 3, 0),
(7, 'Ok', 33, 3, 0),
(8, 'Good', 66, 3, 0),
(9, 'Great', 100, 3, 0),
(10, 'Point Range', 100, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `QuestionTypes`
--

CREATE TABLE IF NOT EXISTS `QuestionTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `QuestionTypes`
--

INSERT INTO `QuestionTypes` (`id`, `name`, `client_id`) VALUES
(1, 'Yes/No', 0),
(2, 'Yes/No/Na', 0),
(3, 'Bad/Ok/Good/Great', 0),
(4, 'Points', 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Answers`
--
ALTER TABLE `Answers`
  ADD CONSTRAINT `FK_Questions_Answers_ID_0001` FOREIGN KEY (`Questions_id`) REFERENCES `Questions` (`id`);

--
-- Constraints for table `Assets`
--
ALTER TABLE `Assets`
  ADD CONSTRAINT `Assets_ibfk_3` FOREIGN KEY (`AssetGroups_id`) REFERENCES `AssetGroups` (`id`),
  ADD CONSTRAINT `Assets_ibfk_4` FOREIGN KEY (`AssetTypes_id`) REFERENCES `AssetTypes` (`id`),
  ADD CONSTRAINT `Assets_ibfk_5` FOREIGN KEY (`Counties_id`) REFERENCES `Counties` (`id`),
  ADD CONSTRAINT `Assets_ibfk_6` FOREIGN KEY (`Countries_id`) REFERENCES `Countries` (`id`);

--
-- Constraints for table `AssetTypes`
--
ALTER TABLE `AssetTypes`
  ADD CONSTRAINT `AssetTypes_ibfk_1` FOREIGN KEY (`AssetGroups_id`) REFERENCES `AssetGroups` (`id`);

--
-- Constraints for table `Assignments`
--
ALTER TABLE `Assignments`
  ADD CONSTRAINT `Assignments_ibfk_3` FOREIGN KEY (`Assets_id`) REFERENCES `Assets` (`id`),
  ADD CONSTRAINT `Assignments_ibfk_1` FOREIGN KEY (`Audits_id`) REFERENCES `Audits` (`id`),
  ADD CONSTRAINT `Assignments_ibfk_2` FOREIGN KEY (`Audits_id`) REFERENCES `Audits` (`id`);

--
-- Constraints for table `AuditDatas`
--
ALTER TABLE `AuditDatas`
  ADD CONSTRAINT `AuditDatas_ibfk_1` FOREIGN KEY (`AuditTypes_id`) REFERENCES `AuditTypes` (`id`),
  ADD CONSTRAINT `AuditDatas_ibfk_2` FOREIGN KEY (`Audits_id`) REFERENCES `Audits` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
