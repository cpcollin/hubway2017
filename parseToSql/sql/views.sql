-- phpMyAdmin SQL Dump
-- version 4.4.15.8
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 27, 2017 at 03:46 PM
-- Server version: 5.7.17
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `hubway`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `riders_per_day`
--
CREATE TABLE IF NOT EXISTS `riders_per_day` (
`year` int(4)
,`month` int(2)
,`day` int(2)
,`total` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `riders_per_hour`
--
CREATE TABLE IF NOT EXISTS `riders_per_hour` (
`year` int(4)
,`month` int(2)
,`day` int(2)
,`hour` int(2)
,`total` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `riders_per_month`
--
CREATE TABLE IF NOT EXISTS `riders_per_month` (
`year` int(4)
,`month` int(2)
,`total` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `riders_per_day`
--
DROP TABLE IF EXISTS `riders_per_day`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `riders_per_day` AS select year(`trips`.`start_date`) AS `year`,month(`trips`.`start_date`) AS `month`,dayofmonth(`trips`.`start_date`) AS `day`,count(0) AS `total` from `trips` group by year(`trips`.`start_date`),month(`trips`.`start_date`),dayofmonth(`trips`.`start_date`) order by year(`trips`.`start_date`),month(`trips`.`start_date`),dayofmonth(`trips`.`start_date`);

-- --------------------------------------------------------

--
-- Structure for view `riders_per_hour`
--
DROP TABLE IF EXISTS `riders_per_hour`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `riders_per_hour` AS select year(`trips`.`start_date`) AS `year`,month(`trips`.`start_date`) AS `month`,dayofmonth(`trips`.`start_date`) AS `day`,hour(`trips`.`start_date`) AS `hour`,count(0) AS `total` from `trips` group by year(`trips`.`start_date`),month(`trips`.`start_date`),dayofmonth(`trips`.`start_date`),hour(`trips`.`start_date`) order by year(`trips`.`start_date`),month(`trips`.`start_date`),dayofmonth(`trips`.`start_date`),hour(`trips`.`start_date`);

-- --------------------------------------------------------

--
-- Structure for view `riders_per_month`
--
DROP TABLE IF EXISTS `riders_per_month`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `riders_per_month` AS select year(`trips`.`start_date`) AS `year`,month(`trips`.`start_date`) AS `month`,count(0) AS `total` from `trips` group by year(`trips`.`start_date`),month(`trips`.`start_date`) order by year(`trips`.`start_date`),month(`trips`.`start_date`);

