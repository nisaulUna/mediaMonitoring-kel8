-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 09 Mar 2025 pada 14.15
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `media_monitoring`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `keywords`
--

CREATE TABLE `keywords` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `keyword` varchar(100) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_activities`
--

CREATE TABLE `log_activities` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `action_details` text NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `media_mentions`
--

CREATE TABLE `media_mentions` (
  `id` int(11) NOT NULL,
  `keyword_id` int(11) NOT NULL,
  `mediaSource_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `url` varchar(500) NOT NULL,
  `published_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `media_sources`
--

CREATE TABLE `media_sources` (
  `id` int(11) NOT NULL,
  `source_name` varchar(100) NOT NULL,
  `source_type` enum('news','social','blog','forum') NOT NULL,
  `source_url` varchar(500) NOT NULL,
  `country` varchar(30) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `project`
--

CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `project`
--

INSERT INTO `project` (`id`, `id_user`, `project_name`, `description`, `is_active`, `createdAt`, `updatedAt`) VALUES
(2, 2, 'Website E-Commerce', 'ytyg', 1, '2025-03-08 16:12:58', '2025-03-08 16:15:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `report_type` enum('weekly','daily','monthly') NOT NULL,
  `report_parameters` varchar(50) DEFAULT NULL,
  `report_data` text DEFAULT NULL,
  `generatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiresAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reports`
--

INSERT INTO `reports` (`id`, `project_id`, `created_by`, `report_type`, `report_parameters`, `report_data`, `generatedAt`, `expiresAt`) VALUES
(4, 2, 'sias', '', 'param1', 'Test report data', '2025-03-08 17:18:08', '2025-03-14 20:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sentiment_analysis`
--

CREATE TABLE `sentiment_analysis` (
  `id` int(11) NOT NULL,
  `mentions_id` int(11) NOT NULL,
  `sentiment_score` decimal(5,2) DEFAULT NULL,
  `sentiment_category` enum('positive','negative','neutral') NOT NULL,
  `sentiment_details` text DEFAULT NULL,
  `analyzedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indeks untuk tabel `log_activities`
--
ALTER TABLE `log_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_user` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
