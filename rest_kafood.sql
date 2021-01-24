-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 25 Jan 2021 pada 00.35
-- Versi Server: 10.1.32-MariaDB
-- PHP Version: 7.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rest_kafood`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_order`
--

CREATE TABLE `tbl_order` (
  `id_order` varchar(15) NOT NULL,
  `id_produk` varchar(15) NOT NULL,
  `id_user` varchar(15) NOT NULL,
  `id_warung` varchar(15) NOT NULL,
  `jumlah` int(3) NOT NULL,
  `total` int(11) NOT NULL,
  `is_proses` tinyint(1) NOT NULL DEFAULT '0',
  `is_delivery` tinyint(1) NOT NULL DEFAULT '0',
  `is_done` tinyint(1) NOT NULL DEFAULT '0',
  `date_created` int(11) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_produk`
--

CREATE TABLE `tbl_produk` (
  `id_produk` varchar(15) NOT NULL,
  `id_user` varchar(15) NOT NULL,
  `nama_produk` text NOT NULL,
  `kategori` enum('Makanan','Minuman','Kue') NOT NULL,
  `harga` int(11) NOT NULL,
  `gambar` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_produk`
--

INSERT INTO `tbl_produk` (`id_produk`, `id_user`, `nama_produk`, `kategori`, `harga`, `gambar`, `date_created`, `date_updated`) VALUES
('28823', '11', 'Nasi Goreng Jakarta', 'Makanan', 270000, '', '2021-01-20 12:47:16', '2021-01-20 12:57:20'),
('288d23', '11', 'Jus Alpukat Merah', 'Minuman', 27000, './assets/uploads/images/WIN_20200707_01_23_37_Pro.jpg', '2021-01-20 12:47:16', '2021-01-20 15:08:01'),
('NtAWQxIl', '11', 'Jus Alpukat Merah', 'Minuman', 27000, './assets/uploads/images/IMG_8445.jpg', '2021-01-20 15:05:25', '2021-01-20 15:05:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_user` varchar(15) NOT NULL,
  `username` varchar(128) NOT NULL,
  `namalengkap` varchar(200) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `gambar` text,
  `password` varchar(256) NOT NULL,
  `role` enum('admin','user','warung') NOT NULL,
  `alamat` text,
  `no_hp` varchar(15) DEFAULT '',
  `latitude` float DEFAULT '0',
  `longitude` float DEFAULT '0',
  `is_active` int(1) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user`
--

INSERT INTO `tbl_user` (`id_user`, `username`, `namalengkap`, `email`, `gambar`, `password`, `role`, `alamat`, `no_hp`, `latitude`, `longitude`, `is_active`, `date_created`, `date_updated`) VALUES
('1', 'aswarkasim', '', 'aswarkasim@gmail.com', 'default.jpg', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', '', '', 0, 0, 1, '0000-00-00 00:00:00', '2021-01-21 13:09:37'),
('10', 'assa', '', 'assa@gmail.com', '', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'warung', '', '', 0, 0, 1, '0000-00-00 00:00:00', '2021-01-20 12:49:15'),
('11', 'Accung', '', 'accung@gmail.com', '', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'warung', '', '', 0, 0, 1, '0000-00-00 00:00:00', '2021-01-20 12:57:15'),
('13', 'hisyam', 'Muhammad Hisyam', 'hash@gmail.com', './assets/uploads/images/WIN_20200707_01_23_37_Pro3.jpg', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', 'Jl. Anoa', '0852355151', 321434, -424355, 1, '2021-01-21 13:09:11', '2021-01-21 13:09:11'),
('14', 'hisyam', 'Muhammad Hisyam', 'hash@gmail.com', '', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', 'Jl. Anoa', '0852355151', 321434, -424355, 1, '2021-01-21 13:10:22', '2021-01-21 13:10:22'),
('3QUu1xFD', 'hisyam', 'Muhammad Hisyam', 'hash@gmail.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', 'Jl. Anoa', '0852355151', 321434, -424355, 1, '2021-01-21 13:32:27', '2021-01-21 13:32:27'),
('9', 'Admin', '', 'admin@gmail.com', '', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'admin', '', '', 0, 0, 0, '0000-00-00 00:00:00', '2021-01-20 12:49:15'),
('iUW8MTlO', 'indah', 'Muhammad Hisyam', 'hash@gmail.com', './assets/uploads/images/IMG_84456.jpg', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', 'Jl. Anoa', '0852355151', 321434, -424355, 1, '2021-01-21 13:51:27', '2021-01-21 14:14:11'),
('Ks9AxuX7', 'indah', NULL, NULL, NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', NULL, '', 0, 0, 0, '2021-01-21 14:00:56', '2021-01-21 14:00:56'),
('RzYMu9rE', 'indah', NULL, NULL, NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', NULL, '', 0, 0, 0, '2021-01-21 14:00:45', '2021-01-21 14:00:45'),
('VYtPkXCH', 'hisyam', 'Muhammad Hisyam', 'hash@gmail.com', './assets/uploads/images/WIN_20200707_01_24_21_Pro.jpg', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', 'Jl. Anoa', '0852355151', 321434, -424355, 1, '2021-01-21 13:13:56', '2021-01-21 13:38:42'),
('yVaDRPbi', 'indah', NULL, NULL, NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'user', NULL, '', 0, 0, 0, '2021-01-21 14:01:13', '2021-01-21 14:01:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`id_order`);

--
-- Indexes for table `tbl_produk`
--
ALTER TABLE `tbl_produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_user`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
