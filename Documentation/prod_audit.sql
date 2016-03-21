-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 21, 2016 at 04:51 PM
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
  `question_id` int(11) NOT NULL,
  `answered_by` int(11) NOT NULL,
  `answered_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`)
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
-- Table structure for table `Assignments`
--

CREATE TABLE IF NOT EXISTS `Assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audit_id` int(11) NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `assigned_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Audits`
--

CREATE TABLE IF NOT EXISTS `Audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `AuditType_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `AuditType_id` (`AuditType_id`),
  KEY `client_id` (`client_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Questions`
--

CREATE TABLE IF NOT EXISTS `Questions` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer_required` tinyint(1) NOT NULL DEFAULT '0',
  `add_evidence` tinyint(1) NOT NULL DEFAULT '0',
  `evidence_required` tinyint(1) NOT NULL DEFAULT '0',
  `add_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `expiry_required` tinyint(1) NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `client_id` (`client_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `QuestionTypeOptions`
--

INSERT INTO `QuestionTypeOptions` (`id`, `name`, `value`, `type_id`, `client_id`) VALUES
(1, 'No', 0, 1, 0),
(2, 'Yes', 100, 1, 0),
(3, 'Yes', 100, 2, 0),
(4, 'No', 0, 2, 0),
(5, 'NA', 100, 2, 0),
(6, 'Bad', 0, 3, 0),
(7, 'Ok', 33, 3, 0),
(8, 'Good', 66, 3, 0),
(9, 'Great', 100, 3, 0);

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
  ADD CONSTRAINT `Answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `Questions` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
