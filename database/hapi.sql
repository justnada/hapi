-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 29, 2023 at 02:09 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

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
-- Table structure for table `moods`
--

CREATE TABLE `moods` (
  `id` int(11) NOT NULL,
  `mood` varchar(30) NOT NULL,
  `score` int(5) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
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
(6, 'anxious', 0, '2023-03-03 03:56:47', NULL),
(13, 'angry', 18, '2023-03-26 15:56:32', '2023-03-26 15:57:17');

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
  `date` date NOT NULL,
  `score_total` int(11) NOT NULL,
  `score_avg` float NOT NULL,
  `mood_total` int(11) NOT NULL,
  `mood_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_moods`
--

INSERT INTO `user_moods` (`id`, `user_id`, `date`, `score_total`, `score_avg`, `mood_total`, `mood_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-03-27', 9, 4.5, 2, 1, '2023-03-27 00:13:27', '2023-03-27 00:14:08');

-- --------------------------------------------------------

--
-- Table structure for table `user_mood_details`
--

CREATE TABLE `user_mood_details` (
  `id` int(11) NOT NULL,
  `user_mood_id` int(11) NOT NULL,
  `mood_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_mood_details`
--

INSERT INTO `user_mood_details` (`id`, `user_mood_id`, `mood_id`, `title`, `description`, `timestamp`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Buy New House', 'Finally able to buy my own house, thank god', '2023-03-27 00:13:27', '2023-03-27 00:13:27', NULL),
(2, 1, 2, 'Got A On Dismath', 'I got A on discrete math', '2023-03-27 00:14:08', '2023-03-27 00:14:08', NULL);

--
-- Indexes for dumped tables
--

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_mood_details`
--
ALTER TABLE `user_mood_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `moods`
--
ALTER TABLE `moods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_moods`
--
ALTER TABLE `user_moods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_mood_details`
--
ALTER TABLE `user_mood_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
