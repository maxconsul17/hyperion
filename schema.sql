/*
SQLyog Trial v13.1.9 (64 bit)
MySQL - 10.4.32-MariaDB : Database - hris_v3
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hris_v3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `hris_v3`;

/*Table structure for table `address_information` */

DROP TABLE IF EXISTS `address_information`;

CREATE TABLE `address_information` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `personal_information_id` bigint(20) unsigned NOT NULL,
  `house_no` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `barangay` varchar(255) DEFAULT NULL,
  `city_municipality` varchar(255) NOT NULL,
  `province` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  `address_type` enum('Present','Permanent') NOT NULL DEFAULT 'Present',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address_information_personal_information_id_foreign` (`personal_information_id`),
  CONSTRAINT `address_information_personal_information_id_foreign` FOREIGN KEY (`personal_information_id`) REFERENCES `personal_information` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `announcement_events` */

DROP TABLE IF EXISTS `announcement_events`;

CREATE TABLE `announcement_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `title` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `published_at` date NOT NULL,
  `expires_at` date DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'draft',
  `location` varchar(255) DEFAULT NULL,
  `office` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `approval_sequence_items` */

DROP TABLE IF EXISTS `approval_sequence_items`;

CREATE TABLE `approval_sequence_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `application_type` varchar(255) NOT NULL,
  `application_id` bigint(20) unsigned NOT NULL,
  `employee_id` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `can_approve` tinyint(1) NOT NULL DEFAULT 0,
  `last_approver` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `approval_sequence_items_application_type_application_id_index` (`application_type`,`application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `approval_sequence_setup_items` */

DROP TABLE IF EXISTS `approval_sequence_setup_items`;

CREATE TABLE `approval_sequence_setup_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `approver_id` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sequence` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `attendance_queue` */

DROP TABLE IF EXISTS `attendance_queue`;

CREATE TABLE `attendance_queue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `processed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `attendance_summaries` */

DROP TABLE IF EXISTS `attendance_summaries`;

CREATE TABLE `attendance_summaries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(150) NOT NULL,
  `cutoff_id` bigint(20) unsigned NOT NULL,
  `worked` decimal(12,2) DEFAULT NULL,
  `late` decimal(12,2) DEFAULT NULL,
  `undertime` decimal(12,2) DEFAULT NULL,
  `absent` decimal(12,2) DEFAULT NULL,
  `overtime` blob DEFAULT NULL,
  `leave` decimal(12,2) DEFAULT NULL,
  `ob` decimal(12,2) DEFAULT NULL,
  `holiday` decimal(12,2) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'summarize',
  `is_hold` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_summaries_employee_id_index` (`employee_id`),
  KEY `attendance_summaries_cutoff_id_index` (`cutoff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `blood_types` */

DROP TABLE IF EXISTS `blood_types`;

CREATE TABLE `blood_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blood_types_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `change_schedule_application_items` */

DROP TABLE IF EXISTS `change_schedule_application_items`;

CREATE TABLE `change_schedule_application_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `change_schedule_application_id` bigint(20) unsigned NOT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `day` varchar(255) DEFAULT NULL,
  `tardy_start` time DEFAULT NULL,
  `absent_start` time DEFAULT NULL,
  `early_dismiss` time DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `date_effective` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `change_schedule_applications` */

DROP TABLE IF EXISTS `change_schedule_applications`;

CREATE TABLE `change_schedule_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `change_schedule_type` varchar(255) NOT NULL DEFAULT 'permanent',
  `reason` text DEFAULT NULL,
  `allow_approver` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `bypass_by` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `civil_statuses` */

DROP TABLE IF EXISTS `civil_statuses`;

CREATE TABLE `civil_statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `clearance_requests` */

DROP TABLE IF EXISTS `clearance_requests`;

CREATE TABLE `clearance_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `clearance_id` bigint(20) unsigned NOT NULL,
  `request_date` datetime NOT NULL DEFAULT current_timestamp(),
  `last_working_day` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `initiated_by` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `clearances` */

DROP TABLE IF EXISTS `clearances`;

CREATE TABLE `clearances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clearances_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `contact_information` */

DROP TABLE IF EXISTS `contact_information`;

CREATE TABLE `contact_information` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `personal_information_id` bigint(20) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `emergency_contact_name` varchar(255) DEFAULT NULL,
  `emergency_contact_number` varchar(255) DEFAULT NULL,
  `emergency_relationship` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_information_personal_information_id_foreign` (`personal_information_id`),
  CONSTRAINT `contact_information_personal_information_id_foreign` FOREIGN KEY (`personal_information_id`) REFERENCES `personal_information` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `correction_application_items` */

DROP TABLE IF EXISTS `correction_application_items`;

CREATE TABLE `correction_application_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `correction_application_id` bigint(20) unsigned NOT NULL,
  `request_time_in` time DEFAULT NULL,
  `request_time_out` time DEFAULT NULL,
  `correction_details` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `correction_applications` */

DROP TABLE IF EXISTS `correction_applications`;

CREATE TABLE `correction_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `reason` text DEFAULT NULL,
  `allow_approver` tinyint(1) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `bypass_by` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `correction_reasons` */

DROP TABLE IF EXISTS `correction_reasons`;

CREATE TABLE `correction_reasons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correction_reasons_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `countries` */

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `coverage_types` */

DROP TABLE IF EXISTS `coverage_types`;

CREATE TABLE `coverage_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `data_request_approvals` */

DROP TABLE IF EXISTS `data_request_approvals`;

CREATE TABLE `data_request_approvals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `requested_by` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `reviewed_by` varchar(255) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_request_approvals_employee_id_status_index` (`employee_id`,`status`),
  KEY `data_request_approvals_requested_by_status_index` (`requested_by`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `deduction_histories` */

DROP TABLE IF EXISTS `deduction_histories`;

CREATE TABLE `deduction_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `deduction_id` bigint(20) unsigned DEFAULT NULL,
  `deduction_type_id` bigint(20) unsigned NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs to apply deduction',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'updated',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deduction_histories_deduction_type_id_foreign` (`deduction_type_id`),
  CONSTRAINT `deduction_histories_deduction_type_id_foreign` FOREIGN KEY (`deduction_type_id`) REFERENCES `deduction_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `deduction_types` */

DROP TABLE IF EXISTS `deduction_types`;

CREATE TABLE `deduction_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deduction_types_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `deductions` */

DROP TABLE IF EXISTS `deductions`;

CREATE TABLE `deductions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `deduction_type_id` bigint(20) unsigned NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs to apply deduction',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deductions_deduction_type_id_foreign` (`deduction_type_id`),
  CONSTRAINT `deductions_deduction_type_id_foreign` FOREIGN KEY (`deduction_type_id`) REFERENCES `deduction_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `department_holiday` */

DROP TABLE IF EXISTS `department_holiday`;

CREATE TABLE `department_holiday` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `holiday_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `departments` */

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `designations` */

DROP TABLE IF EXISTS `designations`;

CREATE TABLE `designations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `dtr_cutoffs` */

DROP TABLE IF EXISTS `dtr_cutoffs`;

CREATE TABLE `dtr_cutoffs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_start` date NOT NULL COMMENT 'Start date of DTR cutoff',
  `date_end` date NOT NULL COMMENT 'End date of DTR cutoff',
  `confirmation_date` datetime DEFAULT NULL COMMENT 'When attendance was confirmed',
  `confirmation_time_from` time DEFAULT NULL,
  `confirmation_time_to` time DEFAULT NULL,
  `confirmation_date_to` datetime DEFAULT NULL COMMENT 'When attendance was confirmed',
  `confirmed_by` bigint(20) unsigned DEFAULT NULL COMMENT 'User ID who confirmed DTR cutoff',
  `is_locked` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Whether DTR is finalized for payroll',
  `locked_at` timestamp NULL DEFAULT NULL COMMENT 'Date when DTR cutoff was locked',
  `status` enum('open','confirmed','locked','closed') NOT NULL DEFAULT 'open' COMMENT 'Current status of DTR cutoff',
  `remarks` text DEFAULT NULL COMMENT 'Notes or confirmation remarks',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dtr_cutoffs_confirmed_by_foreign` (`confirmed_by`),
  CONSTRAINT `dtr_cutoffs_confirmed_by_foreign` FOREIGN KEY (`confirmed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `employee_attendances` */

DROP TABLE IF EXISTS `employee_attendances`;

CREATE TABLE `employee_attendances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(765) NOT NULL,
  `date` date NOT NULL,
  `sched_start` varchar(765) NOT NULL,
  `sched_end` varchar(765) NOT NULL,
  `time_in` varchar(765) DEFAULT NULL,
  `time_out` varchar(765) DEFAULT NULL,
  `tardy` tinyint(1) NOT NULL,
  `tardy_seconds` bigint(20) DEFAULT NULL,
  `undertime` tinyint(1) NOT NULL,
  `undertime_seconds` bigint(20) DEFAULT NULL,
  `worked_days` bigint(20) DEFAULT NULL,
  `absent` tinyint(1) NOT NULL,
  `absent_seconds` bigint(20) DEFAULT NULL,
  `remarks` varchar(765) DEFAULT NULL,
  `details` blob NOT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `dtr_cutoff_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Linked dtr cutoff ID, if applicable',
  `leave_application_id` bigint(20) unsigned DEFAULT NULL,
  `ob_application_id` bigint(20) unsigned DEFAULT NULL,
  `overtime_application_id` bigint(20) unsigned DEFAULT NULL,
  `change_schedule_application_id` bigint(20) unsigned DEFAULT NULL,
  `holiday_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `employee_positions` */

DROP TABLE IF EXISTS `employee_positions`;

CREATE TABLE `employee_positions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `employee_schedules` */

DROP TABLE IF EXISTS `employee_schedules`;

CREATE TABLE `employee_schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `day` varchar(255) DEFAULT NULL,
  `day_index` int(11) DEFAULT NULL,
  `tardy_start` time DEFAULT NULL,
  `absent_start` time DEFAULT NULL,
  `early_dismiss` time DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `date_effective` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `employee_statuses` */

DROP TABLE IF EXISTS `employee_statuses`;

CREATE TABLE `employee_statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `facial_logs` */

DROP TABLE IF EXISTS `facial_logs`;

CREATE TABLE `facial_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `site` varchar(255) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `processed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facial_logs_employee_id_index` (`employee_id`),
  KEY `facial_logs_time_index` (`time`),
  KEY `facial_logs_site_index` (`site`),
  KEY `facial_logs_device_id_index` (`device_id`),
  KEY `facial_logs_processed_index` (`processed`),
  KEY `facial_logs_employee_id_time_index` (`employee_id`,`time`),
  KEY `facial_logs_processed_time_index` (`processed`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `holiday_catalogs` */

DROP TABLE IF EXISTS `holiday_catalogs`;

CREATE TABLE `holiday_catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `holiday_name` varchar(765) NOT NULL,
  `type` varchar(765) DEFAULT NULL,
  `with_pay` varchar(9) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `holidays` */

DROP TABLE IF EXISTS `holidays`;

CREATE TABLE `holidays` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `holiday_catalog_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `updated_at` varchar(60) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `income_histories` */

DROP TABLE IF EXISTS `income_histories`;

CREATE TABLE `income_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `income_id` bigint(20) unsigned DEFAULT NULL,
  `income_type_id` bigint(20) unsigned NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `remaining_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs to apply deduction',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'updated',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `income_histories_income_type_id_foreign` (`income_type_id`),
  CONSTRAINT `income_histories_income_type_id_foreign` FOREIGN KEY (`income_type_id`) REFERENCES `income_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `income_types` */

DROP TABLE IF EXISTS `income_types`;

CREATE TABLE `income_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `income_types_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `incomes` */

DROP TABLE IF EXISTS `incomes`;

CREATE TABLE `incomes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `income_type_id` bigint(20) unsigned NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `remaining_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs to apply deduction',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incomes_income_type_id_foreign` (`income_type_id`),
  CONSTRAINT `incomes_income_type_id_foreign` FOREIGN KEY (`income_type_id`) REFERENCES `income_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `job_applications` */

DROP TABLE IF EXISTS `job_applications`;

CREATE TABLE `job_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_listing_id` bigint(20) unsigned NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `cover_letter` text DEFAULT NULL,
  `resume_path` varchar(255) DEFAULT NULL,
  `status` enum('pending','shortlisted','reviewed','accepted','rejected') NOT NULL DEFAULT 'pending',
  `applied_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `job_applications_job_listing_id_foreign` (`job_listing_id`),
  CONSTRAINT `job_applications_job_listing_id_foreign` FOREIGN KEY (`job_listing_id`) REFERENCES `job_listings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `job_batches` */

DROP TABLE IF EXISTS `job_batches`;

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `job_listings` */

DROP TABLE IF EXISTS `job_listings`;

CREATE TABLE `job_listings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `employment_type` varchar(255) NOT NULL,
  `salary_from` decimal(12,2) DEFAULT NULL,
  `salary_to` decimal(12,2) DEFAULT NULL,
  `description` text NOT NULL,
  `requirements` text DEFAULT NULL,
  `benefits` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `leave_applications` */

DROP TABLE IF EXISTS `leave_applications`;

CREATE TABLE `leave_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `number_of_days` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `reason` text DEFAULT NULL,
  `allow_approver` tinyint(1) NOT NULL,
  `with_pay` tinyint(1) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `bypass_by` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `leave_credits` */

DROP TABLE IF EXISTS `leave_credits`;

CREATE TABLE `leave_credits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `credit` decimal(5,2) NOT NULL,
  `avail` decimal(5,2) NOT NULL,
  `balance` decimal(5,2) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `leave_type_rules` */

DROP TABLE IF EXISTS `leave_type_rules`;

CREATE TABLE `leave_type_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `leave_type_id` bigint(20) unsigned NOT NULL,
  `year_from` int(11) NOT NULL,
  `year_to` int(11) NOT NULL,
  `credits` decimal(10,2) NOT NULL,
  `employee_status_id` bigint(20) unsigned NOT NULL,
  `position_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `leave_types` */

DROP TABLE IF EXISTS `leave_types`;

CREATE TABLE `leave_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `gender` varchar(255) NOT NULL,
  `approver_count` int(11) NOT NULL,
  `additional_columns` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`additional_columns`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `leave_types_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `loan_histories` */

DROP TABLE IF EXISTS `loan_histories`;

CREATE TABLE `loan_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `loan_id` bigint(20) unsigned DEFAULT NULL,
  `loan_type_id` bigint(20) unsigned NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs to apply deduction',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'updated',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_histories_loan_type_id_foreign` (`loan_type_id`),
  CONSTRAINT `loan_histories_loan_type_id_foreign` FOREIGN KEY (`loan_type_id`) REFERENCES `loan_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `loan_types` */

DROP TABLE IF EXISTS `loan_types`;

CREATE TABLE `loan_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loan_types_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `loans` */

DROP TABLE IF EXISTS `loans`;

CREATE TABLE `loans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `loan_type_id` bigint(20) unsigned NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs to apply deduction',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loans_loan_type_id_foreign` (`loan_type_id`),
  CONSTRAINT `loans_loan_type_id_foreign` FOREIGN KEY (`loan_type_id`) REFERENCES `loan_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `menu_access_controls` */

DROP TABLE IF EXISTS `menu_access_controls`;

CREATE TABLE `menu_access_controls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `menu_id` bigint(20) unsigned NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `write` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_access_controls_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_access_controls_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `menus` */

DROP TABLE IF EXISTS `menus`;

CREATE TABLE `menus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `title` varchar(191) NOT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `order_no` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(255) DEFAULT NULL,
  `parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`parameters`)),
  `writable` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`writable`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_parent_id_index` (`parent_id`),
  CONSTRAINT `menus_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `nationalities` */

DROP TABLE IF EXISTS `nationalities`;

CREATE TABLE `nationalities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `ob_applications` */

DROP TABLE IF EXISTS `ob_applications`;

CREATE TABLE `ob_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `is_halfday` tinyint(1) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `allow_approver` tinyint(1) NOT NULL,
  `number_of_days` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `bypass_by` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `offices` */

DROP TABLE IF EXISTS `offices`;

CREATE TABLE `offices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` bigint(20) unsigned NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `offices_department_id_foreign` (`department_id`),
  CONSTRAINT `offices_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `organizations` */

DROP TABLE IF EXISTS `organizations`;

CREATE TABLE `organizations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `position_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `office_id` bigint(20) unsigned NOT NULL,
  `designation_id` bigint(20) unsigned NOT NULL,
  `employee_status_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organizations_position_id_foreign` (`position_id`),
  KEY `organizations_department_id_foreign` (`department_id`),
  KEY `organizations_office_id_foreign` (`office_id`),
  KEY `organizations_designation_id_foreign` (`designation_id`),
  KEY `organizations_employee_status_id_foreign` (`employee_status_id`),
  CONSTRAINT `organizations_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `organizations_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `designations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `organizations_employee_status_id_foreign` FOREIGN KEY (`employee_status_id`) REFERENCES `employee_statuses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `organizations_office_id_foreign` FOREIGN KEY (`office_id`) REFERENCES `offices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `organizations_position_id_foreign` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `overtime_applications` */

DROP TABLE IF EXISTS `overtime_applications`;

CREATE TABLE `overtime_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `office_hours` varchar(255) DEFAULT NULL,
  `duration` time NOT NULL,
  `breaktime` time NOT NULL,
  `reason` text DEFAULT NULL,
  `allow_approver` tinyint(1) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `bypass_by` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `overtime_items` */

DROP TABLE IF EXISTS `overtime_items`;

CREATE TABLE `overtime_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `overtime_application_id` bigint(20) unsigned NOT NULL,
  `overtime_start` time NOT NULL,
  `overtime_end` time NOT NULL,
  `break` time NOT NULL,
  `total_hours` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pagibig_contributions` */

DROP TABLE IF EXISTS `pagibig_contributions`;

CREATE TABLE `pagibig_contributions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `salary_from` decimal(12,2) NOT NULL,
  `salary_to` decimal(12,2) DEFAULT NULL,
  `fixed_er` decimal(12,2) DEFAULT NULL,
  `fixed_ee` decimal(12,2) DEFAULT NULL,
  `percentage_er` decimal(5,2) DEFAULT NULL,
  `percentage_ee` decimal(5,2) DEFAULT NULL,
  `year` varchar(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `payroll_computed_table` */

DROP TABLE IF EXISTS `payroll_computed_table`;

CREATE TABLE `payroll_computed_table` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payroll_cutoff_id` bigint(20) unsigned NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `employee_account_number` varchar(80) DEFAULT NULL,
  `quarter` tinyint(3) unsigned DEFAULT NULL,
  `basic_salary` double(15,2) NOT NULL DEFAULT 0.00,
  `gross_pay` double(15,2) NOT NULL DEFAULT 0.00,
  `net_pay` double(15,2) NOT NULL DEFAULT 0.00,
  `overtime_pay` double(15,2) NOT NULL DEFAULT 0.00,
  `tardy_amount` double(15,2) NOT NULL DEFAULT 0.00,
  `absent_amount` double(15,2) NOT NULL DEFAULT 0.00,
  `incomes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`incomes`)),
  `loans` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`loans`)),
  `deductions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`deductions`)),
  `fix_deductions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`fix_deductions`)),
  `withholding_tax` double(15,2) NOT NULL DEFAULT 0.00,
  `total_deductions` double(15,2) NOT NULL DEFAULT 0.00,
  `monthly_rate` decimal(10,5) DEFAULT NULL,
  `daily_rate` decimal(10,5) DEFAULT NULL,
  `workdays` decimal(10,5) DEFAULT NULL,
  `status` enum('PENDING','SAVED','PROCESSED') NOT NULL DEFAULT 'PENDING',
  `is_hold` tinyint(1) NOT NULL DEFAULT 0,
  `saved_by` varchar(25) DEFAULT NULL,
  `saved_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `payroll_cutoffs` */

DROP TABLE IF EXISTS `payroll_cutoffs`;

CREATE TABLE `payroll_cutoffs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dtr_cutoff_id` bigint(20) unsigned DEFAULT NULL,
  `schedule` varchar(255) NOT NULL,
  `cutoff_name` varchar(255) DEFAULT NULL COMMENT 'Label for payroll cutoff, e.g., October 1–15, 2025',
  `period_start` date NOT NULL COMMENT 'Start date of payroll period',
  `period_end` date NOT NULL COMMENT 'End date of payroll period',
  `pay_date` date DEFAULT NULL COMMENT 'Date when payroll will be released',
  `quarter` varchar(255) NOT NULL,
  `status` enum('open','processing','finalized','closed') NOT NULL DEFAULT 'open' COMMENT 'Current status of payroll cutoff',
  `is_locked` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Locked for payroll adjustments',
  `locked_at` timestamp NULL DEFAULT NULL COMMENT 'Date when payroll cutoff was locked',
  `remarks` text DEFAULT NULL COMMENT 'Optional notes from HR or payroll',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payroll_cutoffs_dtr_cutoff_id_foreign` (`dtr_cutoff_id`),
  CONSTRAINT `payroll_cutoffs_dtr_cutoff_id_foreign` FOREIGN KEY (`dtr_cutoff_id`) REFERENCES `dtr_cutoffs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `payroll_processed_deductions` */

DROP TABLE IF EXISTS `payroll_processed_deductions`;

CREATE TABLE `payroll_processed_deductions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payroll_id` bigint(20) unsigned NOT NULL,
  `deduction_id` bigint(20) unsigned NOT NULL,
  `deduction_type_id` bigint(20) unsigned NOT NULL,
  `employee_id` varchar(255) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs applied',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payroll_processed_deductions_payroll_id_foreign` (`payroll_id`),
  KEY `payroll_processed_deductions_deduction_id_foreign` (`deduction_id`),
  KEY `payroll_processed_deductions_deduction_type_id_foreign` (`deduction_type_id`),
  CONSTRAINT `payroll_processed_deductions_deduction_id_foreign` FOREIGN KEY (`deduction_id`) REFERENCES `deductions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payroll_processed_deductions_deduction_type_id_foreign` FOREIGN KEY (`deduction_type_id`) REFERENCES `deduction_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payroll_processed_deductions_payroll_id_foreign` FOREIGN KEY (`payroll_id`) REFERENCES `payroll_computed_table` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `payroll_processed_incomes` */

DROP TABLE IF EXISTS `payroll_processed_incomes`;

CREATE TABLE `payroll_processed_incomes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payroll_id` bigint(20) unsigned NOT NULL,
  `income_id` bigint(20) unsigned NOT NULL,
  `income_type_id` bigint(20) unsigned NOT NULL,
  `employee_id` varchar(255) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `remaining_amount` decimal(12,2) NOT NULL,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs applied',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payroll_processed_incomes_payroll_id_foreign` (`payroll_id`),
  KEY `payroll_processed_incomes_income_id_foreign` (`income_id`),
  KEY `payroll_processed_incomes_income_type_id_foreign` (`income_type_id`),
  CONSTRAINT `payroll_processed_incomes_income_id_foreign` FOREIGN KEY (`income_id`) REFERENCES `incomes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payroll_processed_incomes_income_type_id_foreign` FOREIGN KEY (`income_type_id`) REFERENCES `income_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payroll_processed_incomes_payroll_id_foreign` FOREIGN KEY (`payroll_id`) REFERENCES `payroll_computed_table` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `payroll_processed_loans` */

DROP TABLE IF EXISTS `payroll_processed_loans`;

CREATE TABLE `payroll_processed_loans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payroll_id` bigint(20) unsigned NOT NULL,
  `loan_id` bigint(20) unsigned NOT NULL,
  `loan_type_id` bigint(20) unsigned NOT NULL,
  `employee_id` varchar(255) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `cutoff_count` int(10) unsigned NOT NULL COMMENT 'Number of cutoffs applied',
  `schedule` varchar(255) NOT NULL COMMENT 'e.g., monthly, semimonthly',
  `quarter` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payroll_processed_loans_payroll_id_foreign` (`payroll_id`),
  KEY `payroll_processed_loans_loan_id_foreign` (`loan_id`),
  KEY `payroll_processed_loans_loan_type_id_foreign` (`loan_type_id`),
  CONSTRAINT `payroll_processed_loans_loan_id_foreign` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payroll_processed_loans_loan_type_id_foreign` FOREIGN KEY (`loan_type_id`) REFERENCES `loan_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payroll_processed_loans_payroll_id_foreign` FOREIGN KEY (`payroll_id`) REFERENCES `payroll_computed_table` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `payroll_setups` */

DROP TABLE IF EXISTS `payroll_setups`;

CREATE TABLE `payroll_setups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `monthly` decimal(12,2) NOT NULL DEFAULT 0.00,
  `semimonthly` decimal(12,2) NOT NULL DEFAULT 0.00,
  `daily` decimal(12,2) NOT NULL DEFAULT 0.00,
  `hourly` decimal(12,2) NOT NULL DEFAULT 0.00,
  `minutely` decimal(12,2) NOT NULL DEFAULT 0.00,
  `schedule` enum('semimonthly','monthly') NOT NULL,
  `quarter` varchar(255) NOT NULL,
  `effective_date` date NOT NULL,
  `sss_employer` varchar(255) DEFAULT NULL,
  `sss_employee` varchar(255) DEFAULT NULL,
  `sss_quarter` varchar(255) DEFAULT NULL,
  `philhealth_employer` varchar(255) DEFAULT NULL,
  `philhealth_employee` varchar(255) DEFAULT NULL,
  `philhealth_quarter` varchar(255) DEFAULT NULL,
  `pagibig_employer` varchar(255) DEFAULT NULL,
  `pagibig_employee` varchar(255) DEFAULT NULL,
  `pagibig_quarter` varchar(255) DEFAULT NULL,
  `withholding_tax` decimal(12,2) DEFAULT NULL,
  `auto_calculate` tinyint(1) NOT NULL DEFAULT 0,
  `tax_status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `personal_information` */

DROP TABLE IF EXISTS `personal_information`;

CREATE TABLE `personal_information` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `suffix` varchar(255) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_place` varchar(255) DEFAULT NULL,
  `civil_status` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `philhealth_contributions` */

DROP TABLE IF EXISTS `philhealth_contributions`;

CREATE TABLE `philhealth_contributions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `salary_min` decimal(12,2) NOT NULL,
  `salary_max` decimal(12,2) DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `default_amount` decimal(12,2) DEFAULT NULL,
  `year` varchar(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `positions` */

DROP TABLE IF EXISTS `positions`;

CREATE TABLE `positions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pulse_aggregates` */

DROP TABLE IF EXISTS `pulse_aggregates`;

CREATE TABLE `pulse_aggregates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bucket` int(10) unsigned NOT NULL,
  `period` mediumint(8) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `key` mediumtext NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `aggregate` varchar(255) NOT NULL,
  `value` decimal(20,2) NOT NULL,
  `count` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pulse_aggregates_bucket_period_type_aggregate_key_hash_unique` (`bucket`,`period`,`type`,`aggregate`,`key_hash`),
  KEY `pulse_aggregates_period_bucket_index` (`period`,`bucket`),
  KEY `pulse_aggregates_type_index` (`type`),
  KEY `pulse_aggregates_period_type_aggregate_bucket_index` (`period`,`type`,`aggregate`,`bucket`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pulse_entries` */

DROP TABLE IF EXISTS `pulse_entries`;

CREATE TABLE `pulse_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `key` mediumtext NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `value` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pulse_entries_timestamp_index` (`timestamp`),
  KEY `pulse_entries_type_index` (`type`),
  KEY `pulse_entries_key_hash_index` (`key_hash`),
  KEY `pulse_entries_timestamp_type_key_hash_value_index` (`timestamp`,`type`,`key_hash`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pulse_values` */

DROP TABLE IF EXISTS `pulse_values`;

CREATE TABLE `pulse_values` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `key` mediumtext NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `value` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pulse_values_type_key_hash_unique` (`type`,`key_hash`),
  KEY `pulse_values_timestamp_index` (`timestamp`),
  KEY `pulse_values_type_index` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `relationships` */

DROP TABLE IF EXISTS `relationships`;

CREATE TABLE `relationships` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `religions` */

DROP TABLE IF EXISTS `religions`;

CREATE TABLE `religions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `schedule_shift_details` */

DROP TABLE IF EXISTS `schedule_shift_details`;

CREATE TABLE `schedule_shift_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_shift_id` bigint(20) unsigned NOT NULL,
  `day` varchar(255) DEFAULT NULL,
  `day_index` int(11) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `tardy_start` time DEFAULT NULL,
  `absent_start` time DEFAULT NULL,
  `early_dismiss` time DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schedule_shift_details_schedule_shift_id_foreign` (`schedule_shift_id`),
  CONSTRAINT `schedule_shift_details_schedule_shift_id_foreign` FOREIGN KEY (`schedule_shift_id`) REFERENCES `schedule_shifts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `schedule_shifts` */

DROP TABLE IF EXISTS `schedule_shifts`;

CREATE TABLE `schedule_shifts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_name` varchar(255) NOT NULL,
  `validation` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `service_records` */

DROP TABLE IF EXISTS `service_records`;

CREATE TABLE `service_records` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(765) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `present` tinyint(1) NOT NULL DEFAULT 0,
  `position_title` varchar(255) DEFAULT NULL,
  `office_name` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_records_employee_id_index` (`employee_id`),
  KEY `service_records_employee_id_start_date_index` (`employee_id`,`start_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `shift_assignments` */

DROP TABLE IF EXISTS `shift_assignments`;

CREATE TABLE `shift_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_shift_id` bigint(20) unsigned NOT NULL,
  `employee_id` varchar(255) NOT NULL,
  `date_effective` date NOT NULL,
  `processed` tinyint(1) NOT NULL DEFAULT 0,
  `updated_by` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shift_assignments_employee_id_date_effective_index` (`employee_id`,`date_effective`),
  KEY `shift_assignments_schedule_shift_id_foreign` (`schedule_shift_id`),
  CONSTRAINT `shift_assignments_schedule_shift_id_foreign` FOREIGN KEY (`schedule_shift_id`) REFERENCES `schedule_shifts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `sss_contributions` */

DROP TABLE IF EXISTS `sss_contributions`;

CREATE TABLE `sss_contributions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `salary_from` decimal(12,2) NOT NULL,
  `salary_to` decimal(12,2) DEFAULT NULL,
  `salary_bracket` decimal(12,2) NOT NULL,
  `er` decimal(12,2) NOT NULL,
  `ee` decimal(12,2) NOT NULL,
  `ec` decimal(12,2) NOT NULL,
  `provident_er` decimal(12,2) NOT NULL DEFAULT 0.00,
  `provident_ee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_er_with_provident` decimal(12,2) NOT NULL,
  `total_ee_with_provident` decimal(12,2) NOT NULL,
  `total_contribution` decimal(12,2) NOT NULL,
  `year` varchar(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tax_statuses` */

DROP TABLE IF EXISTS `tax_statuses`;

CREATE TABLE `tax_statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tax_tables` */

DROP TABLE IF EXISTS `tax_tables`;

CREATE TABLE `tax_tables` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `income_from` decimal(12,2) NOT NULL,
  `income_to` decimal(12,2) DEFAULT NULL,
  `base_tax` decimal(12,2) NOT NULL,
  `tax_rate` decimal(5,2) NOT NULL,
  `excess_over` decimal(12,2) NOT NULL,
  `employment_status` varchar(255) NOT NULL,
  `tax_status` varchar(255) NOT NULL,
  `year` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `timesheets` */

DROP TABLE IF EXISTS `timesheets`;

CREATE TABLE `timesheets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `work_date` date NOT NULL,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `titles` */

DROP TABLE IF EXISTS `titles`;

CREATE TABLE `titles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(765) DEFAULT NULL,
  `name` varchar(765) DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `email` varchar(765) DEFAULT NULL,
  `user_type` varchar(765) NOT NULL DEFAULT 'employee',
  `acting_as` varchar(765) NOT NULL DEFAULT 'employee',
  `avatar_url` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(765) DEFAULT NULL,
  `payslip_password` varchar(765) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `last_active_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(300) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `web_check_in_details` */

DROP TABLE IF EXISTS `web_check_in_details`;

CREATE TABLE `web_check_in_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `facial_log_id` bigint(20) unsigned NOT NULL,
  `captured_image` blob NOT NULL,
  `location` varchar(255) NOT NULL,
  `source` blob NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `web_check_in_details_facial_log_id_foreign` (`facial_log_id`),
  CONSTRAINT `web_check_in_details_facial_log_id_foreign` FOREIGN KEY (`facial_log_id`) REFERENCES `facial_logs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `work_experiences` */

DROP TABLE IF EXISTS `work_experiences`;

CREATE TABLE `work_experiences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `personal_information_id` bigint(20) unsigned NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `position_title` varchar(255) NOT NULL,
  `employment_status` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `responsibilities` text DEFAULT NULL,
  `monthly_salary` decimal(10,2) DEFAULT NULL,
  `supervisor_name` varchar(255) DEFAULT NULL,
  `supervisor_contact` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `work_experiences_personal_information_id_foreign` (`personal_information_id`),
  CONSTRAINT `work_experiences_personal_information_id_foreign` FOREIGN KEY (`personal_information_id`) REFERENCES `personal_information` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
