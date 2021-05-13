-- This script creates the db objects upon startup

CREATE DATABASE  IF NOT EXISTS `aa_audit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aa_audit`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: aa_audit
-- --------------------------------------ç----------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditors`
--

DROP TABLE IF EXISTS `auditors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditors` (
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `employee_id` varchar(45) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits` (
  `audit_id` int NOT NULL,
  `audit_date` date DEFAULT NULL,
  `revision_num` int NOT NULL,
  `facilities_facility_id` int NOT NULL,
  `versions_version` int NOT NULL,
  PRIMARY KEY (`audit_id`,`revision_num`,`facilities_facility_id`),
  KEY `fk_audits_facilities1_idx` (`facilities_facility_id`),
  KEY `fk_audits_versions1_idx` (`versions_version`),
  CONSTRAINT `fk_audits_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`),
  CONSTRAINT `fk_audits_versions1` FOREIGN KEY (`versions_version`) REFERENCES `versions` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audits_has_auditors`
--

DROP TABLE IF EXISTS `audits_has_auditors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits_has_auditors` (
  `audits_audit_id` int NOT NULL,
  `audits_revision_num` int NOT NULL,
  `auditors_employee_id` varchar(45) NOT NULL,
  PRIMARY KEY (`audits_audit_id`,`audits_revision_num`,`auditors_employee_id`),
  KEY `fk_audits_has_auditors_auditors1_idx` (`auditors_employee_id`),
  KEY `fk_audits_has_auditors_audits1_idx` (`audits_audit_id`,`audits_revision_num`),
  CONSTRAINT `fk_audits_has_auditors_auditors1` FOREIGN KEY (`auditors_employee_id`) REFERENCES `auditors` (`employee_id`),
  CONSTRAINT `fk_audits_has_auditors_audits1` FOREIGN KEY (`audits_audit_id`, `audits_revision_num`) REFERENCES `audits` (`audit_id`, `revision_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audits_has_reports`
--

DROP TABLE IF EXISTS `audits_has_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits_has_reports` (
  `audits_audit_id` int NOT NULL,
  `reports_report_id` int NOT NULL,
  PRIMARY KEY (`audits_audit_id`,`reports_report_id`),
  KEY `fk_audits_has_reports_reports1_idx` (`reports_report_id`),
  KEY `fk_audits_has_reports_audits1_idx` (`audits_audit_id`),
  CONSTRAINT `fk_audits_has_reports_audits1` FOREIGN KEY (`audits_audit_id`) REFERENCES `audits` (`audit_id`),
  CONSTRAINT `fk_audits_has_reports_reports1` FOREIGN KEY (`reports_report_id`) REFERENCES `reports` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `audits_v`
--

DROP TABLE IF EXISTS `audits_v`;
/*!50001 DROP VIEW IF EXISTS `audits_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `audits_v` AS SELECT 
 1 AS `audit_id`,
 1 AS `revision_num`,
 1 AS `versions_version`,
 1 AS `audit_date`,
 1 AS `facilities_facility_id`,
 1 AS `facility_name`,
 1 AS `facility_operator_name`,
 1 AS `operator_id`,
 1 AS `report_id`,
 1 AS `reporting_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `beams`
--

DROP TABLE IF EXISTS `beams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beams` (
  `beam_id` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `direction` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`beam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cases`
--

DROP TABLE IF EXISTS `cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases` (
  `case_id` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `constant_values`
--

DROP TABLE IF EXISTS `constant_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `constant_values` (
  `constant_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `value` json DEFAULT NULL,
  `date_inserted` date DEFAULT NULL,
  `versions_version` int NOT NULL,
  PRIMARY KEY (`constant_id`,`versions_version`),
  KEY `fk_constant_values_versions1_idx` (`versions_version`),
  CONSTRAINT `fk_constant_values_versions1` FOREIGN KEY (`versions_version`) REFERENCES `versions` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ct_models`
--

DROP TABLE IF EXISTS `ct_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ct_models` (
  `ct_model_id` int NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ct_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `energy_level`
--

DROP TABLE IF EXISTS `energy_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `energy_level` (
  `energy_level` varchar(45) NOT NULL,
  PRIMARY KEY (`energy_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities` (
  `facility_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `facility_operator_operator_id` int NOT NULL,
  PRIMARY KEY (`facility_id`,`facility_operator_operator_id`),
  KEY `fk_facilities_facility_operator1_idx` (`facility_operator_operator_id`),
  CONSTRAINT `fk_facilities_facility_operator1` FOREIGN KEY (`facility_operator_operator_id`) REFERENCES `facility_operator` (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities_has_cts`
--

DROP TABLE IF EXISTS `facilities_has_cts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities_has_cts` (
  `ct_id` varchar(45) NOT NULL,
  `ct_models_ct_model_id` int NOT NULL,
  `facilities_facility_id` int NOT NULL,
  PRIMARY KEY (`ct_id`,`ct_models_ct_model_id`,`facilities_facility_id`),
  KEY `fk_facilities_has_cts_ct_models1_idx` (`ct_models_ct_model_id`),
  KEY `fk_facilities_has_cts_facilities1_idx` (`facilities_facility_id`),
  CONSTRAINT `fk_facilities_has_cts_ct_models1` FOREIGN KEY (`ct_models_ct_model_id`) REFERENCES `ct_models` (`ct_model_id`),
  CONSTRAINT `fk_facilities_has_cts_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities_has_linacs`
--

DROP TABLE IF EXISTS `facilities_has_linacs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities_has_linacs` (
  `facilities_facility_id` int NOT NULL,
  `linacs_linac_model_id` int NOT NULL,
  `linac_serial_number` varchar(45) DEFAULT NULL,
  `linac_id` varchar(45) NOT NULL,
  PRIMARY KEY (`linac_id`,`linacs_linac_model_id`,`facilities_facility_id`),
  KEY `fk_facilities_has_linacs_linacs1_idx` (`linacs_linac_model_id`),
  KEY `fk_facilities_has_linacs_facilities1_idx` (`facilities_facility_id`),
  CONSTRAINT `fk_facilities_has_linacs_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`),
  CONSTRAINT `fk_facilities_has_linacs_linacs1` FOREIGN KEY (`linacs_linac_model_id`) REFERENCES `linac_models` (`linac_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities_has_planning_systems`
--

DROP TABLE IF EXISTS `facilities_has_planning_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities_has_planning_systems` (
  `facilities_facility_id` int NOT NULL,
  `planning_systems_ps_id` int NOT NULL,
  PRIMARY KEY (`facilities_facility_id`,`planning_systems_ps_id`),
  KEY `fk_facilities_has_planning_systems_planning_systems1_idx` (`planning_systems_ps_id`),
  KEY `fk_facilities_has_planning_systems_facilities1_idx` (`facilities_facility_id`),
  CONSTRAINT `fk_facilities_has_planning_systems_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`),
  CONSTRAINT `fk_facilities_has_planning_systems_planning_systems1` FOREIGN KEY (`planning_systems_ps_id`) REFERENCES `planning_systems` (`ps_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_operator`
--

DROP TABLE IF EXISTS `facility_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility_operator` (
  `operator_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `registration_number` varchar(45) DEFAULT NULL,
  `public_private` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`operator_id`),
  UNIQUE KEY `registration_number_UNIQUE` (`registration_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_stated`
--

DROP TABLE IF EXISTS `facility_stated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility_stated` (
  `facilities_has_linacs_linac_id` varchar(45) NOT NULL,
  `trs_398_method_method_id` int NOT NULL,
  `amount` decimal(65,30) DEFAULT NULL,
  `facilities_has_cts_ct_id` varchar(45) NOT NULL,
  `energy_level_energy_level` varchar(45) NOT NULL,
  `planning_system_algorithm_algorithm_id` int NOT NULL,
  `phantoms_phantom_id` int NOT NULL,
  `facilities_has_planning_systems_planning_systems_ps_id` int NOT NULL,
  `audits_audit_id` int NOT NULL,
  `audits_revision_num` int NOT NULL,
  PRIMARY KEY (`facilities_has_linacs_linac_id`,`trs_398_method_method_id`,`facilities_has_cts_ct_id`,`energy_level_energy_level`,`planning_system_algorithm_algorithm_id`,`phantoms_phantom_id`,`facilities_has_planning_systems_planning_systems_ps_id`,`audits_audit_id`,`audits_revision_num`),
  KEY `fk_facility_stated_rename_facilities_has_linacs1_idx` (`facilities_has_linacs_linac_id`),
  KEY `fk_facility_stated_rename_trs_398_method1_idx` (`trs_398_method_method_id`),
  KEY `fk_facility_stated_facilities_has_cts1_idx` (`facilities_has_cts_ct_id`),
  KEY `fk_facility_stated_energy_level1_idx` (`energy_level_energy_level`),
  KEY `fk_facility_stated_planning_system_algorithm1_idx` (`planning_system_algorithm_algorithm_id`),
  KEY `fk_facility_stated_phantoms1_idx` (`phantoms_phantom_id`),
  KEY `fk_facility_stated_facilities_has_planning_systems1_idx` (`facilities_has_planning_systems_planning_systems_ps_id`),
  KEY `fk_facility_stated_audits1_idx` (`audits_audit_id`,`audits_revision_num`),
  CONSTRAINT `fk_facility_stated_audits1` FOREIGN KEY (`audits_audit_id`, `audits_revision_num`) REFERENCES `audits` (`audit_id`, `revision_num`),
  CONSTRAINT `fk_facility_stated_energy_level1` FOREIGN KEY (`energy_level_energy_level`) REFERENCES `energy_level` (`energy_level`),
  CONSTRAINT `fk_facility_stated_facilities_has_cts1` FOREIGN KEY (`facilities_has_cts_ct_id`) REFERENCES `facilities_has_cts` (`ct_id`),
  CONSTRAINT `fk_facility_stated_facilities_has_planning_systems1` FOREIGN KEY (`facilities_has_planning_systems_planning_systems_ps_id`) REFERENCES `facilities_has_planning_systems` (`planning_systems_ps_id`),
  CONSTRAINT `fk_facility_stated_phantoms1` FOREIGN KEY (`phantoms_phantom_id`) REFERENCES `phantoms` (`phantom_id`),
  CONSTRAINT `fk_facility_stated_planning_system_algorithm1` FOREIGN KEY (`planning_system_algorithm_algorithm_id`) REFERENCES `planning_system_algorithm` (`algorithm_id`),
  CONSTRAINT `fk_facility_stated_rename_facilities_has_linacs1` FOREIGN KEY (`facilities_has_linacs_linac_id`) REFERENCES `facilities_has_linacs` (`linac_id`),
  CONSTRAINT `fk_facility_stated_rename_trs_398_method1` FOREIGN KEY (`trs_398_method_method_id`) REFERENCES `trs_398_method` (`method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `facility_stated_v`
--

DROP TABLE IF EXISTS `facility_stated_v`;
/*!50001 DROP VIEW IF EXISTS `facility_stated_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `facility_stated_v` AS SELECT 
 1 AS `audit_id`,
 1 AS `revision_num`,
 1 AS `audit_date`,
 1 AS `facility_id`,
 1 AS `facility_name`,
 1 AS `linac_id`,
 1 AS `linac_serial_number`,
 1 AS `linac_model`,
 1 AS `linac_manufacturer`,
 1 AS `trs_398_id`,
 1 AS `trs_398_description`,
 1 AS `planning_system_id`,
 1 AS `planning_system_name`,
 1 AS `planning_system_version`,
 1 AS `planning_system_manufacturer`,
 1 AS `ps_algorithm_id`,
 1 AS `ps_algorithm_name`,
 1 AS `ct_id`,
 1 AS `ct_model`,
 1 AS `ct_manufacturer`,
 1 AS `phantom_id`,
 1 AS `phantom_name`,
 1 AS `energy_level_energy_level`,
 1 AS `amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `linac_models`
--

DROP TABLE IF EXISTS `linac_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linac_models` (
  `linac_model_id` int NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`linac_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phantoms`
--

DROP TABLE IF EXISTS `phantoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phantoms` (
  `phantom_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`phantom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `planning_system_algorithm`
--

DROP TABLE IF EXISTS `planning_system_algorithm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planning_system_algorithm` (
  `algorithm_id` int NOT NULL,
  `algorithm_name` varchar(45) NOT NULL,
  PRIMARY KEY (`algorithm_id`),
  UNIQUE KEY `algorithm_name_UNIQUE` (`algorithm_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `planning_systems`
--

DROP TABLE IF EXISTS `planning_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planning_systems` (
  `ps_id` int NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ps_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `points`
--

DROP TABLE IF EXISTS `points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `points` (
  `point` int NOT NULL,
  `position` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `report_id` int NOT NULL,
  `reporting_date` date DEFAULT NULL,
  `report_document` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `result_id` int NOT NULL,
  `points_point` int NOT NULL,
  `beams_beam_id` int NOT NULL,
  `cases_case_id` int NOT NULL,
  `audits_audit_id` int NOT NULL,
  `audits_revision_num` int NOT NULL,
  `energy_level` varchar(45) NOT NULL,
  `measured_current` decimal(65,30) DEFAULT NULL,
  `predicted_current` decimal(65,30) DEFAULT NULL,
  `variation_pc` decimal(65,3) DEFAULT NULL,
  `planning_system_algorithm_algorithm_id` int NOT NULL,
  PRIMARY KEY (`result_id`,`points_point`,`beams_beam_id`,`cases_case_id`,`audits_audit_id`,`audits_revision_num`,`energy_level`,`planning_system_algorithm_algorithm_id`),
  KEY `fk_results_points1_idx` (`points_point`),
  KEY `fk_results_beams1_idx` (`beams_beam_id`),
  KEY `fk_results_cases1_idx` (`cases_case_id`),
  KEY `fk_results_audits1_idx` (`audits_audit_id`,`audits_revision_num`),
  KEY `fk_results_energy_level1_idx` (`energy_level`),
  KEY `fk_results_planning_system_algorithm1_idx` (`planning_system_algorithm_algorithm_id`),
  CONSTRAINT `fk_results_audits1` FOREIGN KEY (`audits_audit_id`, `audits_revision_num`) REFERENCES `audits` (`audit_id`, `revision_num`),
  CONSTRAINT `fk_results_beams1` FOREIGN KEY (`beams_beam_id`) REFERENCES `beams` (`beam_id`),
  CONSTRAINT `fk_results_cases1` FOREIGN KEY (`cases_case_id`) REFERENCES `cases` (`case_id`),
  CONSTRAINT `fk_results_energy_level1` FOREIGN KEY (`energy_level`) REFERENCES `energy_level` (`energy_level`),
  CONSTRAINT `fk_results_planning_system_algorithm1` FOREIGN KEY (`planning_system_algorithm_algorithm_id`) REFERENCES `planning_system_algorithm` (`algorithm_id`),
  CONSTRAINT `fk_results_points1` FOREIGN KEY (`points_point`) REFERENCES `points` (`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `results_v`
--

DROP TABLE IF EXISTS `results_v`;
/*!50001 DROP VIEW IF EXISTS `results_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `results_v` AS SELECT 
 1 AS `result_id`,
 1 AS `audit_id`,
 1 AS `revision_num`,
 1 AS `version`,
 1 AS `audit_date`,
 1 AS `facility_id`,
 1 AS `facility`,
 1 AS `point`,
 1 AS `point_position`,
 1 AS `beam`,
 1 AS `beam_description`,
 1 AS `beam_direction`,
 1 AS `case_id`,
 1 AS `case_description`,
 1 AS `energy_level`,
 1 AS `measured_current`,
 1 AS `predicted_current`,
 1 AS `variation_pc`,
 1 AS `algorithm_id`,
 1 AS `algorithm_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `trs_398_method`
--

DROP TABLE IF EXISTS `trs_398_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trs_398_method` (
  `method_id` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `versions` (
  `version` int NOT NULL,
  `date_created` date DEFAULT NULL,
  `comments` blob,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `audits_v`
--

/*!50001 DROP VIEW IF EXISTS `audits_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `audits_v` AS select `audits`.`audit_id` AS `audit_id`,`audits`.`revision_num` AS `revision_num`,`audits`.`versions_version` AS `versions_version`,`audits`.`audit_date` AS `audit_date`,`audits`.`facilities_facility_id` AS `facilities_facility_id`,`facilities`.`name` AS `facility_name`,`facility_operator`.`name` AS `facility_operator_name`,`facility_operator`.`operator_id` AS `operator_id`,`reports`.`report_id` AS `report_id`,`reports`.`reporting_date` AS `reporting_date` from ((((`audits` join `facilities` on((`audits`.`facilities_facility_id` = `facilities`.`facility_id`))) join `facility_operator` on((`facilities`.`facility_operator_operator_id` = `facility_operator`.`operator_id`))) join `audits_has_reports` on((`audits`.`audit_id` = `audits_has_reports`.`audits_audit_id`))) join `reports` on((`audits`.`audit_id` = `audits_has_reports`.`audits_audit_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `facility_stated_v`
--

/*!50001 DROP VIEW IF EXISTS `facility_stated_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `facility_stated_v` AS select `facility_stated`.`audits_audit_id` AS `audit_id`,`facility_stated`.`audits_revision_num` AS `revision_num`,`audits`.`audit_date` AS `audit_date`,`facilities`.`facility_id` AS `facility_id`,`facilities`.`name` AS `facility_name`,`facility_stated`.`facilities_has_linacs_linac_id` AS `linac_id`,`facilities_has_linacs`.`linac_serial_number` AS `linac_serial_number`,`linac_models`.`model` AS `linac_model`,`linac_models`.`manufacturer` AS `linac_manufacturer`,`facility_stated`.`trs_398_method_method_id` AS `trs_398_id`,`trs_398_method`.`description` AS `trs_398_description`,`facility_stated`.`facilities_has_planning_systems_planning_systems_ps_id` AS `planning_system_id`,`planning_systems`.`name` AS `planning_system_name`,`planning_systems`.`version` AS `planning_system_version`,`planning_systems`.`manufacturer` AS `planning_system_manufacturer`,`facility_stated`.`planning_system_algorithm_algorithm_id` AS `ps_algorithm_id`,`planning_system_algorithm`.`algorithm_name` AS `ps_algorithm_name`,`facility_stated`.`facilities_has_cts_ct_id` AS `ct_id`,`ct_models`.`model` AS `ct_model`,`ct_models`.`manufacturer` AS `ct_manufacturer`,`facility_stated`.`phantoms_phantom_id` AS `phantom_id`,`phantoms`.`name` AS `phantom_name`,`facility_stated`.`energy_level_energy_level` AS `energy_level_energy_level`,`facility_stated`.`amount` AS `amount` from (((((((((`facility_stated` join `audits` on(((`facility_stated`.`audits_audit_id` = `audits`.`audit_id`) and (`facility_stated`.`audits_revision_num` = `audits`.`revision_num`)))) join `facilities` on((`audits`.`facilities_facility_id` = `facilities`.`facility_id`))) join `facilities_has_linacs` on((`facility_stated`.`facilities_has_linacs_linac_id` = `facilities_has_linacs`.`linac_id`))) join `linac_models` on((`facilities_has_linacs`.`linacs_linac_model_id` = `linac_models`.`linac_model_id`))) join `trs_398_method` on((`facility_stated`.`trs_398_method_method_id` = `trs_398_method`.`method_id`))) join `planning_systems` on((`facility_stated`.`facilities_has_planning_systems_planning_systems_ps_id` = `planning_systems`.`ps_id`))) join `planning_system_algorithm` on((`facility_stated`.`planning_system_algorithm_algorithm_id` = `planning_system_algorithm`.`algorithm_id`))) join `ct_models` on((`facility_stated`.`facilities_has_cts_ct_id` = `ct_models`.`ct_model_id`))) join `phantoms` on((`facility_stated`.`phantoms_phantom_id` = `phantoms`.`phantom_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `results_v`
--

/*!50001 DROP VIEW IF EXISTS `results_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `results_v` AS select `results`.`result_id` AS `result_id`,`results`.`audits_audit_id` AS `audit_id`,`audits`.`revision_num` AS `revision_num`,`audits`.`versions_version` AS `version`,`audits`.`audit_date` AS `audit_date`,`audits`.`facilities_facility_id` AS `facility_id`,`facilities`.`name` AS `facility`,`results`.`points_point` AS `point`,`points`.`position` AS `point_position`,`results`.`beams_beam_id` AS `beam`,`beams`.`description` AS `beam_description`,`beams`.`direction` AS `beam_direction`,`results`.`cases_case_id` AS `case_id`,`cases`.`description` AS `case_description`,`results`.`energy_level` AS `energy_level`,`results`.`measured_current` AS `measured_current`,`results`.`predicted_current` AS `predicted_current`,`results`.`variation_pc` AS `variation_pc`,`results`.`planning_system_algorithm_algorithm_id` AS `algorithm_id`,`planning_system_algorithm`.`algorithm_name` AS `algorithm_name` from ((((((`results` join `points` on((`results`.`points_point` = `points`.`point`))) join `beams` on((`results`.`beams_beam_id` = `beams`.`beam_id`))) join `cases` on((`results`.`cases_case_id` = `cases`.`case_id`))) join `audits` on(((`results`.`audits_audit_id` = `audits`.`audit_id`) and (`results`.`audits_revision_num` = `audits`.`revision_num`)))) join `facilities` on((`audits`.`facilities_facility_id` = `facilities`.`facility_id`))) join `planning_system_algorithm` on((`results`.`planning_system_algorithm_algorithm_id` = `planning_system_algorithm`.`algorithm_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-19 13:25:03