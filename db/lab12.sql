-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2022 at 08:30 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lab12`
--

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `status` enum('01','02') NOT NULL DEFAULT '01',
  `pinned` tinyint(1) NOT NULL DEFAULT 0,
  `like` int(11) NOT NULL DEFAULT 0,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `create_by_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `title`, `content`, `status`, `pinned`, `like`, `create_date`, `create_by_id`) VALUES
(1, 'What is Lorem Ipsum?', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '01', 0, 23, '2021-03-08 22:12:58', 1),
(2, 'Why do we use it?', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', '02', 0, 4, '2021-03-08 22:13:38', 2),
(3, 'Where does it come from?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '01', 0, 3, '2021-03-08 22:14:18', 1);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` int(11) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `like` int(11) NOT NULL DEFAULT 0,
  `comment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment_by_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `blog_id`, `comment`, `like`, `comment_date`, `comment_by_id`) VALUES
(1, 1, 'I love your blog!', 0, '2021-03-08 22:14:41', 1),
(2, 1, 'Cool :)', 0, '2021-03-08 22:14:54', 1),
(3, 2, 'new', 1, '2022-04-21 13:21:35', 2),
(5, 2, 'new2', 0, '2022-04-22 01:55:21', 1);

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--

CREATE TABLE `contract` (
  `contract_id` bigint(20) UNSIGNED NOT NULL,
  `tenant_id` int(10) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` char(10) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `room_price` float(8,2) DEFAULT NULL,
  `room_number` char(4) DEFAULT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  `status` enum('rent','move_out') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contract`
--

INSERT INTO `contract` (`contract_id`, `tenant_id`, `first_name`, `last_name`, `address`, `phone`, `start_date`, `end_date`, `room_price`, `room_number`, `room_type`, `status`) VALUES
(1, 1, 'Dormitory', 'Non', 'เลขที่ 2', '191', '2022-04-04', '2023-04-04', 8000.00, 'E201', 'small', NULL),
(2, 2, 'May', 'Na', 'กรุงเทพ', NULL, '2022-05-05', '2023-05-05', 13000.00, 'E205', 'small', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `follow`
--

CREATE TABLE `follow` (
  `user_id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `follow_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image_id` bigint(20) UNSIGNED NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `news_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` int(11) NOT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `file_path` varchar(200) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_by_id` int(11) DEFAULT NULL,
  `main` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `blog_id`, `comment_id`, `file_path`, `upload_date`, `update_by_id`, `main`) VALUES
(1, 1, NULL, '/uploads/cats1.png', '2021-03-16 14:03:36', NULL, 1),
(2, 2, NULL, '/uploads/cats2.jpeg', '2021-03-16 14:04:27', NULL, 1),
(3, 2, NULL, '/uploads/cats3.jpeg', '2021-03-16 14:51:56', NULL, 0),
(4, 3, NULL, '/uploads/cats3.jpeg', '2022-03-27 22:45:23', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `meter`
--

CREATE TABLE `meter` (
  `meter_id` int(10) UNSIGNED NOT NULL,
  `utilities_type` enum('ELECTRICITY_FEE','WATER_FEE') DEFAULT NULL,
  `consumpttion` float(8,2) DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `emp_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `news_id` bigint(20) UNSIGNED NOT NULL,
  `detail_news` text DEFAULT NULL,
  `date_news` date DEFAULT NULL,
  `emp_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `parcel`
--

CREATE TABLE `parcel` (
  `parcel_id` bigint(20) UNSIGNED NOT NULL,
  `p_name` varchar(255) DEFAULT NULL,
  `room_number` char(4) DEFAULT NULL,
  `sent_date` date DEFAULT current_timestamp(),
  `receive_date` date DEFAULT NULL,
  `transport_name` varchar(255) DEFAULT NULL,
  `status` enum('not_received','received') DEFAULT 'not_received',
  `tenant_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `parcel`
--

INSERT INTO `parcel` (`parcel_id`, `p_name`, `room_number`, `sent_date`, `receive_date`, `transport_name`, `status`, `tenant_id`) VALUES
(1, 'May2', 'E205', '2022-03-29', '2022-04-27', 'Shopee', 'received', 1),
(2, 'May', 'E206', '2022-04-02', '0000-00-00', 'Kerry', 'not_received', 2),
(3, 'May', 'E205', '2022-04-15', '2022-04-27', 'Flash', 'received', 1),
(4, 'May', 'E205', '2022-04-15', '2022-04-27', 'Kerry', 'received', 2),
(5, 'May', 'E205', '2022-04-15', '2022-04-27', 'Kerry', 'received', 2),
(6, 'May', 'E205', '2022-04-15', '2022-04-27', 'Flash', 'received', 1),
(7, 'May', 'E205', '2022-04-15', '2022-04-27', 'Flash', 'received', 1),
(8, 'May', 'E205', '2022-04-15', '2022-04-27', 'Flash', 'received', 1),
(9, 'May', 'E205', '2022-04-15', '2022-04-27', 'Flash', 'received', 1),
(10, 'May', 'E205', '2022-04-03', NULL, 'Kerry', 'not_received', 2),
(11, 'May', 'E205', '2022-04-15', '2022-04-27', 'Flash', 'received', 1),
(12, 'May', 'E205', '2022-04-15', '2022-04-27', 'Flash', 'received', 1),
(13, 'Por', 'E201', '2022-04-20', NULL, 'Kerry', 'not_received', 1),
(14, 'Por', 'E201', '2022-04-20', NULL, 'Kerry', 'not_received', 0),
(15, 'Por', 'E201', '2022-04-26', NULL, 'Flash', 'not_received', 0),
(16, 'Por', 'E201', '2022-04-27', NULL, 'Flash', 'not_received', 0),
(17, 'Por', 'E201', '2022-04-27', NULL, 'Flash', 'not_received', 0),
(28, 'Por', 'E201', '2022-04-26', NULL, 'Flash', 'not_received', 0),
(37, 'Por', 'E201', '2022-04-27', NULL, 'Flash', 'not_received', 0),
(38, 'May', 'E205', '2022-04-27', NULL, 'Kerry', 'not_received', 0),
(39, 'May', 'E205', '2022-04-27', NULL, 'Flash', 'not_received', 0),
(40, 'Por', 'E201', '2022-04-27', NULL, 'Kerry', 'not_received', 0),
(44, 'Por', 'E201', '2022-04-14', NULL, 'Kerry', 'not_received', 0),
(45, 'May', 'E205', '2022-04-06', NULL, 'Kerry', 'not_received', 0);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `payment_bank` varchar(255) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_time` time DEFAULT NULL,
  `invoice_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment_image`
--

CREATE TABLE `payment_image` (
  `image_id` bigint(20) UNSIGNED NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `invoice_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `profile_image`
--

CREATE TABLE `profile_image` (
  `img_id` bigint(20) UNSIGNED NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `tenant_id` int(10) NOT NULL,
  `emp_id` int(10) NOT NULL,
  `lossor_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `profile_image`
--

INSERT INTO `profile_image` (`img_id`, `file_path`, `upload_date`, `tenant_id`, `emp_id`, `lossor_id`) VALUES
(1, '/uploads/cats1.png', '2022-04-14 17:44:14', 1, 0, 0),
(2, '/uploads/cats1.png', '2022-04-15 18:18:26', 2, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rent_detail`
--

CREATE TABLE `rent_detail` (
  `room_id` bigint(20) UNSIGNED NOT NULL,
  `room_number` char(4) DEFAULT NULL,
  `room_price` float(8,2) DEFAULT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  `room_status` enum('01','02','03') DEFAULT '01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `reported_information`
--

CREATE TABLE `reported_information` (
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `response` varchar(255) DEFAULT NULL,
  `reported_date` date DEFAULT NULL,
  `reporter_name` varchar(255) DEFAULT NULL,
  `problem_detail` varchar(255) DEFAULT NULL,
  `tenant_id` int(10) NOT NULL,
  `emp_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tenant`
--

CREATE TABLE `tenant` (
  `tenant_id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(255) DEFAULT NULL,
  `l_name` varchar(255) DEFAULT NULL,
  `sex` enum('FEMALE','MALE') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `age` int(10) DEFAULT NULL,
  `phone1` char(10) DEFAULT NULL,
  `phone2` char(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(128) NOT NULL,
  `room_id` int(10) NOT NULL,
  `role` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tenant`
--

INSERT INTO `tenant` (`tenant_id`, `f_name`, `l_name`, `sex`, `birth_date`, `age`, `phone1`, `phone2`, `email`, `username`, `password`, `room_id`, `role`) VALUES
(1, 'Por2', 'Na', 'MALE', '2001-12-12', 20, '191', '212', 'Dormitory2@gmail.com', 'E201', 'po170644', 201, 'EMPLOYEE'),
(2, 'May', 'Ja', 'FEMALE', '2001-12-12', 20, '191', '', 'May@gmail.com', 'E205', 'Po170644', 205, 'TENANT');

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `user_id`, `token`) VALUES
(1, 1, '@HvkYP-wv5Gh6vUnsHlFsDyu0STFB91Sp9TxlxrQG1yyIXPuIs!gdnql^wZBET@H2JnKFHl2K!aog@*CToRt!DF@IXUlpyNNCgz#');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `sex` enum('FEMALE','MALE') DEFAULT NULL,
  `birth_day` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `room_id` char(4) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(10) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `phone2` varchar(45) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(10) NOT NULL DEFAULT 'normal'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `sex`, `birth_day`, `age`, `room_id`, `email`, `mobile`, `picture`, `phone2`, `username`, `password`, `join_date`, `role`) VALUES
(1, 'Admin1', 'Webpro', NULL, NULL, NULL, 'E201', 'admin@webpro.com', '0998887777', NULL, '191', 'admin', '$2b$05$ZuF5bL8EVjt8XgfCnWTsCeWQq0hp.UkjG3t9jf2CXC1u7RTw4zpY2', '2022-04-16 07:31:40', 'tenant'),
(2, 'Author', 'First', NULL, NULL, NULL, NULL, 'author1@webpro.com', NULL, NULL, NULL, 'author1', '$2b$05$ZuF5bL8EVjt8XgfCnWTsCeWQq0hp.UkjG3t9jf2CXC1u7RTw4zpY2', '2022-04-16 07:31:40', 'normal');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` bigint(20) UNSIGNED NOT NULL,
  `license_plate` varchar(7) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `tenant_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`contract_id`);

--
-- Indexes for table `follow`
--
ALTER TABLE `follow`
  ADD PRIMARY KEY (`user_id`,`follower_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `meter`
--
ALTER TABLE `meter`
  ADD PRIMARY KEY (`meter_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`news_id`);

--
-- Indexes for table `parcel`
--
ALTER TABLE `parcel`
  ADD PRIMARY KEY (`parcel_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `payment_image`
--
ALTER TABLE `payment_image`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `profile_image`
--
ALTER TABLE `profile_image`
  ADD PRIMARY KEY (`img_id`);

--
-- Indexes for table `rent_detail`
--
ALTER TABLE `rent_detail`
  ADD PRIMARY KEY (`room_id`);

--
-- Indexes for table `reported_information`
--
ALTER TABLE `reported_information`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `tenant`
--
ALTER TABLE `tenant`
  ADD PRIMARY KEY (`tenant_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_UN` (`token`),
  ADD KEY `token_FK` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `contract`
--
ALTER TABLE `contract`
  MODIFY `contract_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `image_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `meter`
--
ALTER TABLE `meter`
  MODIFY `meter_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `news_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parcel`
--
ALTER TABLE `parcel`
  MODIFY `parcel_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_image`
--
ALTER TABLE `payment_image`
  MODIFY `image_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profile_image`
--
ALTER TABLE `profile_image`
  MODIFY `img_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rent_detail`
--
ALTER TABLE `rent_detail`
  MODIFY `room_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reported_information`
--
ALTER TABLE `reported_information`
  MODIFY `report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tenant`
--
ALTER TABLE `tenant`
  MODIFY `tenant_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `token_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
