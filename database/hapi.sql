-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2023 at 03:24 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hapi`
--

-- --------------------------------------------------------

--
-- Table structure for table `daily_user_moods`
--

CREATE TABLE `daily_user_moods` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code` varchar(15) NOT NULL,
  `date` date NOT NULL,
  `mood_count` int(11) NOT NULL,
  `total_score` int(11) NOT NULL,
  `avg_score` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_user_moods`
--

INSERT INTO `daily_user_moods` (`id`, `user_id`, `code`, `date`, `mood_count`, `total_score`, `avg_score`, `created_at`, `updated_at`) VALUES
(1, 1, '1_20230303', '2023-03-03', 6, 21, 3.5, '2023-03-03 07:13:55', '2023-03-03 13:25:29');

-- --------------------------------------------------------

--
-- Table structure for table `moods`
--

CREATE TABLE `moods` (
  `id` int(11) NOT NULL,
  `mood` varchar(30) NOT NULL,
  `score` int(5) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moods`
--

INSERT INTO `moods` (`id`, `mood`, `score`, `created_at`, `updated_at`) VALUES
(1, 'great', 5, '2023-03-02 13:47:24', NULL),
(2, 'good', 4, '2023-03-02 13:47:25', NULL),
(3, 'neutral', 3, '2023-03-02 13:47:40', NULL),
(4, 'bad', 2, '2023-03-02 13:47:41', NULL),
(5, 'awful', 1, '2023-03-02 13:47:45', NULL),
(6, 'anxious', 0, '2023-03-03 03:56:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`, `created_at`, `updated_at`) VALUES
(1, 'johndoe@gmail.com', 'password', 'John Doe', '2023-03-02 13:20:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_moods`
--

CREATE TABLE `user_moods` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mood_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_moods`
--

INSERT INTO `user_moods` (`id`, `user_id`, `mood_id`, `title`, `description`, `time`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 'Broke up', 'Today he broke me up, he\'ll regret it', '2023-03-03 07:13:55', '2023-03-03 07:13:55', NULL),
(2, 1, 3, 'Got C on math', 'You know, at least i tried my best', '2023-03-03 07:14:55', '2023-03-03 07:14:55', NULL),
(3, 1, 1, 'Bonus on paycheck', 'Finally get it, feel so good', '2023-03-03 07:16:13', '2023-03-03 07:16:13', NULL),
(4, 1, 1, 'Cuddling w mom', 'Been a long time we did this, feel so loved. I just know that she actually care for me so much, out of my expectation', '2023-03-03 07:17:34', '2023-03-03 07:17:34', NULL),
(5, 1, 2, 'Bought favorite ice cream', 'Make me feel so much sober', '2023-03-03 07:18:30', '2023-03-03 07:18:30', NULL),
(6, 1, 3, 'Having an evening jogging', 'So so, make my endorphine better', '2023-03-03 13:25:29', '2023-03-03 13:25:29', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daily_user_moods`
--
ALTER TABLE `daily_user_moods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `moods`
--
ALTER TABLE `moods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_moods`
--
ALTER TABLE `user_moods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mood_id` (`mood_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `daily_user_moods`
--
ALTER TABLE `daily_user_moods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `moods`
--
ALTER TABLE `moods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_moods`
--
ALTER TABLE `user_moods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_moods`
--
ALTER TABLE `user_moods`
  ADD CONSTRAINT `user_moods_ibfk_1` FOREIGN KEY (`mood_id`) REFERENCES `moods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
