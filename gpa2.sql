-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2022 at 06:09 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

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

-- --------------------------------------------------------

--
-- Table structure for table `accounts_logininfo`
--

CREATE TABLE `accounts_logininfo` (
  `id` bigint(20) NOT NULL,
  `image_name` varchar(200) NOT NULL,
  `fails` smallint(5) UNSIGNED NOT NULL CHECK (`fails` >= 0),
  `login_link` varchar(225) DEFAULT NULL,
  `reset_link` varchar(225) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts_logininfo`
--

INSERT INTO `accounts_logininfo` (`id`, `image_name`, `fails`, `login_link`, `reset_link`, `user_id`) VALUES
(6, 'lioness', 0, NULL, '487c8fca-41af-47ba-9f76-5e094c0efb0b', 7),
(7, 'donald', 0, NULL, 'fbd3c49d-98f4-41a9-ada6-12d67019e335', 8),
(8, 'humming', 0, NULL, NULL, 9);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add user_accounts', 7, 'add_user_accounts'),
(26, 'Can change user_accounts', 7, 'change_user_accounts'),
(27, 'Can delete user_accounts', 7, 'delete_user_accounts'),
(28, 'Can view user_accounts', 7, 'view_user_accounts'),
(29, 'Can add login info', 8, 'add_logininfo'),
(30, 'Can change login info', 8, 'change_logininfo'),
(31, 'Can delete login info', 8, 'delete_logininfo'),
(32, 'Can view login info', 8, 'view_logininfo'),
(33, 'Can add contact', 9, 'add_contact'),
(34, 'Can change contact', 9, 'change_contact'),
(35, 'Can delete contact', 9, 'delete_contact'),
(36, 'Can view contact', 9, 'view_contact');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$260000$oGrUegE8s9SS1ji7lwFphB$plBw1cScnLdpC5w0Uy4QmZ7AnWbE02SWhML5NmLY9HQ=', '2022-07-04 13:33:38.789625', 1, 'admin', '', '', '', 1, 1, '2022-05-25 16:47:36.944617'),
(7, 'pbkdf2_sha256$260000$YC1FenwaSXwwWBEirY5MST$fAc/rpDKZdPsaiP/hXChEa4eWT4o+VSE+18rmNWq7ko=', '2022-07-14 03:50:04.909695', 0, 'priyanshuarora02@gmail.com', '', '', 'priyanshuarora02@gmail.com', 0, 1, '2022-06-27 09:32:18.277669'),
(8, 'pbkdf2_sha256$260000$G9czDnz5iGuFIl5tZmwl99$GQSjVAlASiBD2NFLp3VNULZ9ns5BHavv5CoPPrp0Z9o=', '2022-06-27 14:04:21.587502', 0, 'priyanshuarora595@gmail.com', '', '', 'priyanshuarora595@gmail.com', 0, 1, '2022-06-27 14:04:21.484685'),
(9, 'pbkdf2_sha256$260000$4ymYbQi8FxOOaxqXuKBUYK$q7V+UIIkisf5QqIchYkavqUuvhL48GLA99fNjKWKXZI=', '2022-06-28 10:50:38.315114', 0, 'asimali@gmail.com', '', '', 'asimali@gmail.com', 0, 1, '2022-06-28 10:50:37.161768');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(9, 'accounts', 'contact'),
(8, 'accounts', 'logininfo'),
(7, 'accounts', 'user_accounts'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-05-25 16:45:58.184941'),
(2, 'auth', '0001_initial', '2022-05-25 16:45:58.536240'),
(3, 'accounts', '0001_initial', '2022-05-25 16:45:58.614027'),
(4, 'admin', '0001_initial', '2022-05-25 16:45:58.703587'),
(5, 'admin', '0002_logentry_remove_auto_add', '2022-05-25 16:45:58.711143'),
(6, 'admin', '0003_logentry_add_action_flag_choices', '2022-05-25 16:45:58.717541'),
(7, 'contenttypes', '0002_remove_content_type_name', '2022-05-25 16:45:58.807330'),
(8, 'auth', '0002_alter_permission_name_max_length', '2022-05-25 16:45:58.850436'),
(9, 'auth', '0003_alter_user_email_max_length', '2022-05-25 16:45:58.864219'),
(10, 'auth', '0004_alter_user_username_opts', '2022-05-25 16:45:58.871246'),
(11, 'auth', '0005_alter_user_last_login_null', '2022-05-25 16:45:58.904827'),
(12, 'auth', '0006_require_contenttypes_0002', '2022-05-25 16:45:58.907362'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2022-05-25 16:45:58.914466'),
(14, 'auth', '0008_alter_user_username_max_length', '2022-05-25 16:45:58.929623'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2022-05-25 16:45:58.966551'),
(16, 'auth', '0010_alter_group_name_max_length', '2022-05-25 16:45:58.980880'),
(17, 'auth', '0011_update_proxy_permissions', '2022-05-25 16:45:58.987858'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2022-05-25 16:45:59.001096'),
(19, 'sessions', '0001_initial', '2022-05-25 16:45:59.028635'),
(20, 'accounts', '0002_delete_user_accounts', '2022-05-25 17:37:19.675182'),
(21, 'accounts', '0003_contact', '2022-06-23 06:29:36.523975');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('48uk7p1qivpm6o16pn1x0f536puh89hq', 'eyJpbWdfbmFtZSI6ImtpbmdmaXNoZXIifQ:1o5pAZ:W994QCEBtN9Z9fe5Nw_PdoXFDKnQjKlMy6NvujTKieg', '2022-07-11 13:52:51.909056'),
('58h9nmommx10rgepfn51lhgz6k0hb0g9', '.eJxVjMsOwiAQRf-FtSG8KS7d-w1kYAapGkhKuzL-uzbpQrf3nHNfLMK21rgNWuKM7MwcO_1uCfKD2g7wDu3Wee5tXebEd4UfdPBrR3peDvfvoMKo39rkJFARhKCBrHAOPU1aZa-ElcYXmwwBCYdSF0peoQRbfNYQNPlJaPb-AO2GN_8:1nw4IO:oUojfp-hgTwALlj0tnpm9ynfDzRp36x4qk5jKvSggiQ', '2022-06-14 16:00:36.097072'),
('61mjsjaj9hjrjt45lopyuvbvd0arc6ek', 'eyJpbWdfbmFtZSI6ImFkdmV0aW1lIn0:1o5pDr:eRluK9T41QYQftkMepE8x7xOXn4mbgwOVjdFdadbE9Y', '2022-07-11 13:56:15.994478'),
('jzbg79ddqofz19vzr84gajlswbjnxr16', '.eJxVjMsOgjAQRf-la9MMfTDg0r3fQIbOjKCmTSisjP-uJCx0e88592UG2tZp2Kosw8zmbII5_W4jpYfkHfCd8q3YVPK6zKPdFXvQaq-F5Xk53L-Dier0rZ2PjDF1AQF78j4Q9oyjOICWWCGpKKiE2AVpAbVpmdA7Im1iYHXm_QHY0DgD:1nvyR4:ZeKpNpy7-d1_x3U_D8wMZENkVUVV2I0pA0nFE0brNWU', '2022-06-14 09:45:10.289193'),
('pd6u29popz05f64df4qusdqstlk34i8c', '.eJxVjDsOwjAQBe_iGlnrJP5R0nMGa9f24gCypTipEHeHSCmgfTPzXiLgtpaw9byEOYmzsOL0uxHGR647SHestyZjq-syk9wVedAury3l5-Vw_w4K9vKtxwR6mIiN1mrK3nCKDISeka1BReCYWaEfPGnrCEE57cbIDsioMYJ4fwD5ATg1:1oBprY:agF1pMw3Vc8xJSF8zH2Xdp0RlSGSvUK-cnczHRGYx50', '2022-07-28 03:50:04.917763'),
('pw1t3ptibf6yuwl1wp6zeeoke2etzl00', 'eyJpbWdfbmFtZSI6ImxvbmRvbiJ9:1o5lRi:jZBhFgwZGoIo6lDaDRK-H0n9wJk6x9JQNWbO2GzxhHs', '2022-07-11 09:54:18.895222'),
('vxl3c8tlrm1nfxtj5550rhc4pd3h0cbo', 'eyJpbWdfbmFtZSI6ImNyYW5lIn0:1o5lWi:TBTDad6uYmyfNiKzBMg-Vawhc-hxfi9ri6BjHEA0UIQ', '2022-07-11 09:59:28.695168');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_contact`
--
ALTER TABLE `accounts_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `accounts_logininfo`
--
ALTER TABLE `accounts_logininfo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `login_link` (`login_link`),
  ADD UNIQUE KEY `reset_link` (`reset_link`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_contact`
--
ALTER TABLE `accounts_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `accounts_logininfo`
--
ALTER TABLE `accounts_logininfo`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts_logininfo`
--
ALTER TABLE `accounts_logininfo`
  ADD CONSTRAINT `accounts_logininfo_user_id_2a0cfaf2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
