-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 29, 2023 at 05:54 AM
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
-- Table structure for table `psychiatrists`
--

CREATE TABLE `psychiatrists` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` varchar(128) NOT NULL,
  `grade` varchar(128) NOT NULL,
  `experience` varchar(128) NOT NULL,
  `rating` float NOT NULL,
  `patient` int(11) NOT NULL,
  `image` varchar(128) NOT NULL,
  `banner` varchar(128) NOT NULL,
  `address` text NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longtitude` decimal(9,6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `psychiatrists`
--

INSERT INTO `psychiatrists` (`id`, `name`, `status`, `grade`, `experience`, `rating`, `patient`, `image`, `banner`, `address`, `latitude`, `longtitude`, `created_at`, `updated_at`) VALUES
(1, 'Dr. Bambang Pamungkas', 'Spesialis Insomnia dan Depresi', 'Dokter Profesional', '> 5 tahun', 4.5, 200, 'risa-olive', 'user-banner', 'Jl. Graha Raya Bintaro No.50, Pd. Kacang Bar., Kec. Pd. Aren, Kota Tangerang Selatan, Banten 15226', '-6.239365', '106.689280', '2023-03-29 03:23:37', '2023-03-29 03:28:50'),
(4, 'Dr. Cemi Lanmais', 'Psikolog', 'Dokter Profesional', '> 3 tahun', 4.4, 35, 'risa-olive', 'user-banner', 'Jl. H. Rasam No.96, Parigi Baru, Kec. Pd. Aren, Kota Tangerang Selatan, Banten 15228', '-6.267815', '106.687155', '2023-03-29 03:31:33', NULL),
(5, 'Dr. Wendy Pambudi', 'Psikiater', 'Dokter Rumah Sakit', '> 4 tahun', 4.5, 46, 'risa-olive', 'user-banner', 'Jl. Garut Barat, Parigi Baru, Kec. Pd. Aren, Kota Tangerang Selatan, Banten 15228', '-6.261399', '106.685506', '2023-03-29 03:33:10', '2023-03-29 03:51:01');

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
(1, 1, '2023-03-27', 9, 4.5, 2, 1, '2023-03-27 00:13:27', '2023-03-27 00:14:08'),
(2, 1, '2023-03-01', 2, 5, 1, 1, '2023-03-29 01:55:23', NULL);

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
-- Indexes for table `psychiatrists`
--
ALTER TABLE `psychiatrists`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `psychiatrists`
--
ALTER TABLE `psychiatrists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_moods`
--
ALTER TABLE `user_moods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_mood_details`
--
ALTER TABLE `user_mood_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
