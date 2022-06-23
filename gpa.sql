-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2022 at 07:35 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gpa`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts_contact`
--

CREATE TABLE `accounts_contact` (
  `id` bigint(20) NOT NULL,
  `firstname` varchar(122) NOT NULL,
  `lastname` varchar(122) NOT NULL,
  `contactemail` varchar(122) NOT NULL,
  `comment` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts_contact`
--

INSERT INTO `accounts_contact` (`id`, `firstname`, `lastname`, `contactemail`, `comment`) VALUES
(1, 'Naman', 'Sharma', 'naman.sharma00100@gmail.com', 'trvdjyjdyt'),
(2, 'Naman', 'Sharma', 'naman.sharma00100@gmail.com', 'mv rvuibnveud'),
(3, 'Naman', 'Sharma', 'naman.sharma00100@gmail.com', 'mv rvuibnveud'),
(4, 'Naman', 'Sharma', 'naman.sharma00100@gmail.com', 'vdfbdbdbfd'),
(5, 'Naman', 'Sharma', 'naman.sharma00100@gmail.com', 'vdfbdbdbfd'),
(6, 'Naman', 'Sharma', 'naman.sharma00100@gmail.com', 'vdfbdbdbfd'),
(7, 'priyanshu', 'arora', 'naman.sharma00100@gmail.com', 'ekwlnvoeuvnouenvou4nvounonon'),
(8, 'priyanshu', 'arora', 'naman.sharma00100@gmail.com', 'ekwlnvoeuvnouenvou4nvounonon'),
(9, 'Naman', 'Sharma', '123@gmail.com', 'dsjcb ojfevbojebfovjbefojvbojfvbojbv'),
(10, 'Naman', 'Sharma', '123@gmail.com', 'dsjcb ojfevbojebfovjbefojvbojfvbojbv'),
(11, 'Naman', 'Sharma', 'absd@gmail.com', 'dojnqc oencoebnojvojfvjovbfv'),
(12, 'Testing-1', 'tester', 'tester@tester.com', 'hey there, its final testing 101.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_contact`
--
ALTER TABLE `accounts_contact`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_contact`
--
ALTER TABLE `accounts_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
