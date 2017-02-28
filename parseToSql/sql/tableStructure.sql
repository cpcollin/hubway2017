-- phpMyAdmin SQL Dump
-- version 4.4.15.8
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 27, 2017 at 01:20 PM
-- Server version: 5.7.17
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `hubway`
--

-- --------------------------------------------------------

--
-- Table structure for table `stations`
--

CREATE TABLE IF NOT EXISTS `stations` (
  `station_number` char(6) NOT NULL,
  `station_name` varchar(256) NOT NULL,
  `jurisdiction` varchar(256) NOT NULL,
  `latitude` float(10,6) NOT NULL,
  `longitude` float(10,6) NOT NULL,
  `number_of_docks` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE IF NOT EXISTS `trips` (
  `duration` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `start_station_number` char(6) NOT NULL,
  `start_station_name` varchar(256) NOT NULL,
  `start_station_latitude` decimal(10,8) DEFAULT NULL,
  `start_station_longitude` decimal(11,8) DEFAULT NULL,
  `end_station_number` char(6) DEFAULT NULL,
  `end_station_name` varchar(256) DEFAULT NULL,
  `end_station_latitude` decimal(10,8) DEFAULT NULL,
  `end_station_longitude` decimal(11,8) DEFAULT NULL,
  `bike_id` varchar(256) NOT NULL,
  `member_type` varchar(256) NOT NULL,
  `birth_year` char(4) DEFAULT NULL,
  `zip_code` varchar(128) DEFAULT NULL,
  `gender` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD KEY `start_station_number` (`start_station_number`),
  ADD KEY `end_station_number` (`end_station_number`),
  ADD KEY `duration` (`duration`) USING BTREE,
  ADD KEY `end_date` (`end_date`) USING BTREE,
  ADD KEY `start_date` (`start_date`) USING BTREE;

--
-- Indexes for table `stations`
--
ALTER TABLE `stations`
  ADD UNIQUE KEY `station_number` (`station_number`);

--
--
