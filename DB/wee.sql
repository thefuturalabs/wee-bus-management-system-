-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2023 at 10:49 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wee`
--

-- --------------------------------------------------------

--
-- Table structure for table `bus`
--

CREATE TABLE `bus` (
  `bus_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `number` varchar(40) NOT NULL,
  `district` varchar(40) NOT NULL,
  `from` varchar(40) NOT NULL,
  `to` varchar(40) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bus`
--

INSERT INTO `bus` (`bus_id`, `driver_id`, `name`, `number`, `district`, `from`, `to`, `status`) VALUES
(1, 3, 'chakkara', '8855669933', 'kannur', '11.2587531,75.78041', '11.8744775,75.37036619999999', 0),
(2, 3, 'abc', '3625147896', 'kozhikode ', '11.2587531,75.78041', '11.6853575,76.1319953', 0);

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `driver_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `mobile` varchar(30) NOT NULL,
  `district` varchar(30) NOT NULL,
  `licence` varchar(200) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`driver_id`, `login_id`, `name`, `mobile`, `district`, `licence`, `status`) VALUES
(1, 3, 'shanu', '9988776655', 'wayanad ', '499517522.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fecility`
--

CREATE TABLE `fecility` (
  `fecility_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `location` varchar(200) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `image` varchar(40) NOT NULL,
  `type` varchar(30) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fecility`
--

INSERT INTO `fecility` (`fecility_id`, `login_id`, `name`, `email`, `location`, `mobile`, `image`, `type`, `status`) VALUES
(1, 5, 'tea time', 'tea@gmail.com', '11.2857357,11.2857357', '0987654321', '61859201.jpg', 'restaurent', 1);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `feedback` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `issue`
--

CREATE TABLE `issue` (
  `issue_id` int(11) NOT NULL,
  `driver_id` varchar(30) NOT NULL,
  `bus_id` varchar(30) NOT NULL,
  `issue` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `location` varchar(200) NOT NULL,
  `status` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `bus_id`, `driver_id`, `location`, `status`) VALUES
(1, 1, 3, '11.2857486,75.7933868', 1),
(2, 1, 3, '11.2857486,75.7933868', 0),
(3, 1, 3, '11.2857461,75.7934513', 0),
(4, 1, 3, '11.2857289,75.7934615', 0),
(5, 1, 3, '11.2856903,75.7935299', 0),
(6, 1, 3, '11.2856603,75.7937272', 0),
(7, 1, 3, '11.2857198,75.7934343', 0),
(8, 1, 3, '11.2857186,75.7933867', 0),
(9, 1, 3, '11.2857454,75.7934107', 0),
(10, 1, 3, '11.285762,75.7934409', 0),
(11, 1, 3, '11.2857472,75.7934073', 0),
(12, 1, 3, '11.2857497,75.7934051', 0),
(13, 1, 3, '11.2857609,75.7934212', 0),
(14, 1, 3, '11.2857663,75.7934253', 0),
(15, 1, 3, '11.2857661,75.7934159', 0),
(16, 1, 3, '11.2857564,75.7934001', 0),
(17, 1, 3, '11.2857591,75.7934121', 0),
(18, 1, 3, '11.2857813,75.7934715', 0),
(19, 1, 3, '11.285767,75.7934345', 0),
(20, 1, 3, '11.2857564,75.793406', 0),
(21, 1, 3, '11.2857601,75.7934084', 0),
(22, 1, 3, '11.2857629,75.7934079', 0),
(23, 1, 3, '11.2857572,75.7934049', 0),
(24, 1, 3, '11.2857495,75.7933989', 0),
(25, 1, 3, '11.2857532,75.7934044', 0),
(26, 1, 3, '11.285779,75.7934515', 0),
(27, 1, 3, '11.2857617,75.7934075', 0),
(28, 1, 3, '11.2857556,75.7933929', 0),
(29, 1, 3, '11.2857471,75.7934016', 0),
(30, 1, 3, '11.2857571,75.7933984', 0),
(31, 1, 3, '11.2857589,75.7933974', 0),
(32, 2, 3, '11.2857561,75.7934015', 1),
(33, 1, 3, '11.2857561,75.7934015', 0),
(34, 2, 3, '11.2857561,75.7934015', 0),
(35, 2, 3, '11.2857566,75.7934046', 0),
(36, 1, 3, '11.2857566,75.7934046', 0),
(37, 1, 3, '11.285771,75.7934346', 0),
(38, 2, 3, '11.285771,75.7934346', 0),
(39, 1, 3, '11.2857486,75.7934002', 0),
(40, 2, 3, '11.2857486,75.7934002', 0),
(41, 1, 3, '11.2857499,75.7933925', 0),
(42, 2, 3, '11.2857499,75.7933925', 0),
(43, 2, 3, '11.2857517,75.7933999', 0),
(44, 1, 3, '11.2857517,75.7933999', 0),
(45, 2, 3, '11.2857519,75.7934013', 0),
(46, 1, 3, '11.2857519,75.7934013', 0),
(47, 2, 3, '11.2857515,75.7934064', 0),
(48, 1, 3, '11.2857515,75.7934064', 0),
(49, 1, 3, '11.2857501,75.7934015', 0),
(50, 2, 3, '11.2857501,75.7934015', 0),
(51, 1, 3, '11.2857547,75.7934385', 0),
(52, 2, 3, '11.2857547,75.7934385', 0),
(53, 1, 3, '11.2857487,75.7934384', 0),
(54, 2, 3, '11.2857487,75.7934384', 0),
(55, 2, 3, '11.2857418,75.7934456', 0),
(56, 1, 3, '11.2857418,75.7934456', 0),
(57, 1, 3, '11.285741,75.7934465', 0),
(58, 2, 3, '11.285741,75.7934465', 0),
(59, 2, 3, '11.2857408,75.793444', 0),
(60, 1, 3, '11.2857408,75.793444', 0),
(61, 2, 3, '11.2857408,75.7934438', 0),
(62, 1, 3, '11.2857408,75.7934438', 0),
(63, 1, 3, '11.2857415,75.793442', 0),
(64, 2, 3, '11.2857415,75.793442', 0),
(65, 2, 3, '11.2857415,75.7934421', 0),
(66, 1, 3, '11.2857415,75.7934421', 0),
(67, 2, 3, '11.2857407,75.7934377', 0),
(68, 1, 3, '11.2857407,75.7934377', 0),
(69, 1, 3, '11.2857405,75.7934368', 0),
(70, 2, 3, '11.2857405,75.7934368', 0),
(71, 1, 3, '11.2857408,75.7934357', 0),
(72, 2, 3, '11.2857408,75.7934357', 0),
(73, 1, 3, '11.2857408,75.7934356', 0),
(74, 2, 3, '11.2857408,75.7934356', 0),
(75, 2, 3, '11.2857409,75.7934341', 0),
(76, 1, 3, '11.2857409,75.7934341', 0),
(77, 2, 3, '11.2857409,75.7934339', 0),
(78, 1, 3, '11.2857409,75.7934339', 0),
(79, 2, 3, '11.285741,75.7934325', 0),
(80, 1, 3, '11.285741,75.7934325', 0),
(81, 1, 3, '11.285741,75.7934324', 0),
(82, 2, 3, '11.285741,75.7934324', 0),
(83, 2, 3, '11.2857411,75.7934309', 0),
(84, 1, 3, '11.2857411,75.7934309', 0),
(85, 2, 3, '11.2857531,75.79344', 0),
(86, 1, 3, '11.2857531,75.79344', 0),
(87, 2, 3, '11.2857539,75.7934406', 0),
(88, 1, 3, '11.2857539,75.7934406', 0),
(89, 1, 3, '11.2857378,75.7934309', 0),
(90, 2, 3, '11.2857378,75.7934309', 0),
(91, 2, 3, '11.2857361,75.7934299', 0),
(92, 1, 3, '11.2857361,75.7934299', 0),
(93, 2, 3, '11.2857359,75.7934237', 0),
(94, 1, 3, '11.2857359,75.7934237', 0),
(95, 1, 3, '11.2857352,75.7934038', 0),
(96, 2, 3, '11.2857352,75.7934038', 0),
(97, 1, 3, '11.2857351,75.7934005', 0),
(98, 2, 3, '11.2857351,75.7934005', 0),
(99, 2, 3, '11.285734,75.7934069', 0),
(100, 1, 3, '11.285734,75.7934069', 0),
(101, 2, 3, '11.2857338,75.7934079', 0),
(102, 1, 3, '11.2857338,75.7934079', 0),
(103, 1, 3, '11.2857312,75.7934097', 0),
(104, 2, 3, '11.2857312,75.7934097', 0),
(105, 2, 3, '11.2857309,75.7934098', 0),
(106, 1, 3, '11.2857309,75.7934098', 0),
(107, 1, 3, '11.2857311,75.7934079', 0),
(108, 2, 3, '11.2857311,75.7934079', 0),
(109, 2, 3, '11.2857311,75.7934077', 0),
(110, 1, 3, '11.2857311,75.7934077', 0),
(111, 1, 3, '11.285731,75.7934077', 0),
(112, 2, 3, '11.285731,75.7934077', 0),
(113, 1, 3, '11.285731,75.7934041', 0),
(114, 2, 3, '11.285731,75.7934041', 0),
(115, 1, 3, '11.285731,75.7934037', 0),
(116, 2, 3, '11.285731,75.7934037', 0),
(117, 2, 3, '11.2857312,75.7934037', 0),
(118, 1, 3, '11.2857312,75.7934037', 0),
(119, 2, 3, '11.2857312,75.7934037', 0),
(120, 1, 3, '11.2857312,75.7934037', 0),
(121, 2, 3, '11.285734,75.7934064', 0),
(122, 1, 3, '11.285734,75.7934064', 0),
(123, 1, 3, '11.2857342,75.7934066', 0),
(124, 2, 3, '11.2857342,75.7934066', 0),
(125, 2, 3, '11.2857347,75.7934056', 0),
(126, 1, 3, '11.2857347,75.7934056', 0),
(127, 1, 3, '11.2857348,75.7934054', 0),
(128, 2, 3, '11.2857348,75.7934054', 0),
(129, 2, 3, '11.2857356,75.7934053', 0),
(130, 1, 3, '11.2857356,75.7934053', 0),
(131, 1, 3, '11.2857356,75.7934054', 0),
(132, 2, 3, '11.2857356,75.7934054', 0),
(133, 1, 3, '11.2857356,75.7934054', 0),
(134, 2, 3, '11.2857356,75.7934054', 0),
(135, 2, 3, '11.2857357,75.7934037', 0),
(136, 1, 3, '11.2857357,75.7934037', 0),
(137, 1, 3, '11.2857357,75.7934035', 0),
(138, 2, 3, '11.2857357,75.7934035', 0),
(139, 1, 3, '11.2857348,75.7934023', 0),
(140, 2, 3, '11.2857348,75.7934023', 0),
(141, 2, 3, '11.2857347,75.7934022', 0),
(142, 1, 3, '11.2857347,75.7934022', 0),
(143, 1, 3, '11.2857308,75.793407', 0),
(144, 2, 3, '11.2857308,75.793407', 0),
(145, 2, 3, '11.2857303,75.7934076', 0),
(146, 1, 3, '11.2857303,75.7934076', 0),
(147, 1, 3, '11.2857281,75.7934086', 0),
(148, 2, 3, '11.2857281,75.7934086', 0),
(149, 2, 3, '11.2857281,75.7934086', 0),
(150, 1, 3, '11.2857281,75.7934086', 0),
(151, 1, 3, '11.285725,75.7934134', 0),
(152, 2, 3, '11.285725,75.7934134', 0),
(153, 2, 3, '11.2857232,75.793415', 0),
(154, 1, 3, '11.2857232,75.793415', 0),
(155, 1, 3, '11.2857231,75.7934151', 0),
(156, 2, 3, '11.2857231,75.7934151', 0),
(157, 1, 3, '11.2857261,75.7934155', 0),
(158, 2, 3, '11.2857261,75.7934155', 0),
(159, 1, 3, '11.2857262,75.7934157', 0),
(160, 2, 3, '11.2857262,75.7934157', 0),
(161, 2, 3, '11.2857273,75.7934141', 0),
(162, 1, 3, '11.2857273,75.7934141', 0),
(163, 2, 3, '11.2857297,75.7934143', 0),
(164, 1, 3, '11.2857297,75.7934143', 0),
(165, 2, 3, '11.2857307,75.7934139', 0),
(166, 1, 3, '11.2857307,75.7934139', 0),
(167, 2, 3, '11.2857326,75.7934149', 0),
(168, 1, 3, '11.2857326,75.7934149', 0),
(169, 2, 3, '11.2857341,75.7934168', 0),
(170, 1, 3, '11.2857341,75.7934168', 0),
(171, 1, 3, '11.2857348,75.7934167', 0),
(172, 2, 3, '11.2857348,75.7934167', 0),
(173, 1, 3, '11.2857584,75.7934189', 0),
(174, 2, 3, '11.2857584,75.7934189', 0),
(175, 1, 3, '11.2857767,75.7934171', 0),
(176, 2, 3, '11.2857767,75.7934171', 0),
(177, 1, 3, '11.2857743,75.7934218', 0),
(178, 2, 3, '11.2857743,75.7934218', 0),
(179, 2, 3, '11.2857621,75.7934154', 0),
(180, 1, 3, '11.2857621,75.7934154', 0),
(181, 2, 3, '11.285762,75.7934067', 0),
(182, 1, 3, '11.285762,75.7934067', 0),
(183, 1, 3, '11.2857621,75.7934065', 0),
(184, 2, 3, '11.2857621,75.7934065', 0),
(185, 2, 3, '11.2857547,75.7934132', 0),
(186, 1, 3, '11.2857547,75.7934132', 0),
(187, 2, 3, '11.2857537,75.7934115', 0),
(188, 1, 3, '11.2857537,75.7934115', 0),
(189, 2, 3, '11.2857525,75.79341', 0),
(190, 1, 3, '11.2857525,75.79341', 0),
(191, 1, 3, '11.2857519,75.7934083', 0),
(192, 2, 3, '11.2857519,75.7934083', 0),
(193, 1, 3, '11.2857515,75.7934065', 0),
(194, 2, 3, '11.2857515,75.7934065', 0),
(195, 2, 3, '11.285751,75.7934055', 0),
(196, 1, 3, '11.285751,75.7934055', 0),
(197, 1, 3, '11.2857509,75.7934048', 0),
(198, 2, 3, '11.2857509,75.7934048', 0),
(199, 1, 3, '11.2857509,75.7934048', 0),
(200, 2, 3, '11.2857509,75.7934048', 0),
(201, 2, 3, '11.2857498,75.7934069', 0),
(202, 1, 3, '11.2857498,75.7934069', 0),
(203, 1, 3, '11.2857501,75.793407', 0),
(204, 2, 3, '11.2857501,75.793407', 0),
(205, 1, 3, '11.2857504,75.7934072', 0),
(206, 2, 3, '11.2857504,75.7934072', 0),
(207, 1, 3, '11.2857502,75.7934057', 0),
(208, 2, 3, '11.2857502,75.7934057', 0),
(209, 2, 3, '11.2857503,75.7934052', 0),
(210, 1, 3, '11.2857503,75.7934052', 0),
(211, 1, 3, '11.2857501,75.7934042', 0),
(212, 2, 3, '11.2857501,75.7934042', 0),
(213, 1, 3, '11.2857502,75.793404', 0),
(214, 2, 3, '11.2857502,75.793404', 0),
(215, 2, 3, '11.2857506,75.7934035', 0),
(216, 1, 3, '11.2857506,75.7934035', 0),
(217, 1, 3, '11.2857506,75.7934034', 0),
(218, 2, 3, '11.2857506,75.7934034', 0),
(219, 1, 3, '11.2857504,75.7934025', 0),
(220, 2, 3, '11.2857504,75.7934025', 0);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `type` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`login_id`, `username`, `password`, `type`) VALUES
(1, 'admin', 'admin', 'admin'),
(2, 'rto', 'rto123', 'rto'),
(3, 'shanu', 'shanu123', 'driver'),
(4, 'abcd', 'abcd123', 'user'),
(5, 'tea', 'tea123', 'fecility');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`notification_id`, `title`, `content`) VALUES
(2, 'notification1', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

-- --------------------------------------------------------

--
-- Table structure for table `rto`
--

CREATE TABLE `rto` (
  `rto_id` int(11) NOT NULL,
  `login_id` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(30) NOT NULL,
  `mobile` varchar(30) NOT NULL,
  `district` varchar(40) NOT NULL,
  `proof` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rto`
--

INSERT INTO `rto` (`rto_id`, `login_id`, `name`, `email`, `mobile`, `district`, `proof`, `status`) VALUES
(1, '2', 'rto1', 'rto@gmail.com', '4455667788', 'kozhikode ', '214150635.jpg', '1');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `mobile` varchar(40) NOT NULL,
  `place` varchar(40) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `login_id`, `name`, `email`, `mobile`, `place`, `status`) VALUES
(1, 4, 'abcd', 'abcd@gmail.com', '0099887766', 'kozhikode ', '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`bus_id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`driver_id`);

--
-- Indexes for table `fecility`
--
ALTER TABLE `fecility`
  ADD PRIMARY KEY (`fecility_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `issue`
--
ALTER TABLE `issue`
  ADD PRIMARY KEY (`issue_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `rto`
--
ALTER TABLE `rto`
  ADD PRIMARY KEY (`rto_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bus`
--
ALTER TABLE `bus`
  MODIFY `bus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `driver_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `fecility`
--
ALTER TABLE `fecility`
  MODIFY `fecility_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `issue`
--
ALTER TABLE `issue`
  MODIFY `issue_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rto`
--
ALTER TABLE `rto`
  MODIFY `rto_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
