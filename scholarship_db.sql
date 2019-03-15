-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2019 at 08:52 PM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scholarship_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `login_table`
--

CREATE TABLE `login_table` (
  `user_id` varchar(12) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(500) NOT NULL,
  `phone_no` varchar(10) NOT NULL,
  `token` varchar(64) DEFAULT NULL,
  `student_user` int(11) DEFAULT NULL,
  `organizer_user` int(11) DEFAULT NULL,
  `operator_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `map_hobby`
--

CREATE TABLE `map_hobby` (
  `self_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `hobby_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `map_qualifications`
--

CREATE TABLE `map_qualifications` (
  `self_id` int(11) NOT NULL,
  `qualification_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `total_score` int(11) NOT NULL,
  `certificate_path` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `map_scholarships`
--

CREATE TABLE `map_scholarships` (
  `self_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `scholarship_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `map_skills`
--

CREATE TABLE `map_skills` (
  `self_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_caste`
--

CREATE TABLE `master_caste` (
  `caste_id` int(11) NOT NULL,
  `Caste` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_city`
--

CREATE TABLE `master_city` (
  `city_id` int(11) NOT NULL,
  `Cities` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_event`
--

CREATE TABLE `master_event` (
  `event_id` int(11) NOT NULL,
  `events` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_hobby`
--

CREATE TABLE `master_hobby` (
  `hobby_id` int(11) NOT NULL,
  `hobbies` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_qualification`
--

CREATE TABLE `master_qualification` (
  `qualification_id` int(11) NOT NULL,
  `qualifications` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_scholarship`
--

CREATE TABLE `master_scholarship` (
  `scholarship_id` int(11) NOT NULL,
  `scholarships` varchar(500) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_sc_category`
--

CREATE TABLE `master_sc_category` (
  `category_id` int(11) NOT NULL,
  `categories` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_skill`
--

CREATE TABLE `master_skill` (
  `skill_id` int(11) NOT NULL,
  `skills` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_status`
--

CREATE TABLE `master_status` (
  `status_id` int(11) NOT NULL,
  `status` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `operator_profile`
--

CREATE TABLE `operator_profile` (
  `operator_id` int(11) NOT NULL,
  `name` varchar(500) NOT NULL,
  `city` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `organization_profile`
--

CREATE TABLE `organization_profile` (
  `organization_id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `total_scholarships` int(11) NOT NULL,
  `total_events` int(11) NOT NULL,
  `city` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `scholarship_table`
--

CREATE TABLE `scholarship_table` (
  `scholarship_id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `organization` int(11) NOT NULL,
  `last_date_to_apply` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `url_site` varchar(1000) NOT NULL,
  `scholarship` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `checked_by` int(11) NOT NULL,
  `eligibility` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `student_profile`
--

CREATE TABLE `student_profile` (
  `student_id` int(11) NOT NULL,
  `name` varchar(400) NOT NULL,
  `age` int(11) NOT NULL,
  `course` int(11) NOT NULL,
  `total_hobbies` int(11) NOT NULL,
  `total_skills` int(11) NOT NULL,
  `adhar_number` varchar(12) NOT NULL,
  `city` int(11) NOT NULL,
  `caste` int(11) NOT NULL,
  `resume_path` varchar(1000) NOT NULL,
  `annual_income` double NOT NULL,
  `income_certificte_path` varchar(1000) NOT NULL,
  `dob` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login_table`
--
ALTER TABLE `login_table`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_no` (`phone_no`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `operator_user` (`operator_user`),
  ADD KEY `organizer_user` (`organizer_user`),
  ADD KEY `student_user` (`student_user`);

--
-- Indexes for table `map_hobby`
--
ALTER TABLE `map_hobby`
  ADD PRIMARY KEY (`self_id`),
  ADD KEY `hobby_id` (`hobby_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `map_qualifications`
--
ALTER TABLE `map_qualifications`
  ADD PRIMARY KEY (`self_id`),
  ADD KEY `qualification_id` (`qualification_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `map_scholarships`
--
ALTER TABLE `map_scholarships`
  ADD PRIMARY KEY (`self_id`),
  ADD KEY `scholarship_id` (`scholarship_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `map_skills`
--
ALTER TABLE `map_skills`
  ADD PRIMARY KEY (`self_id`),
  ADD KEY `skill_id` (`skill_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `master_caste`
--
ALTER TABLE `master_caste`
  ADD PRIMARY KEY (`caste_id`);

--
-- Indexes for table `master_city`
--
ALTER TABLE `master_city`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `master_event`
--
ALTER TABLE `master_event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `master_hobby`
--
ALTER TABLE `master_hobby`
  ADD PRIMARY KEY (`hobby_id`);

--
-- Indexes for table `master_qualification`
--
ALTER TABLE `master_qualification`
  ADD PRIMARY KEY (`qualification_id`);

--
-- Indexes for table `master_scholarship`
--
ALTER TABLE `master_scholarship`
  ADD PRIMARY KEY (`scholarship_id`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `master_sc_category`
--
ALTER TABLE `master_sc_category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `master_skill`
--
ALTER TABLE `master_skill`
  ADD PRIMARY KEY (`skill_id`);

--
-- Indexes for table `master_status`
--
ALTER TABLE `master_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `operator_profile`
--
ALTER TABLE `operator_profile`
  ADD PRIMARY KEY (`operator_id`),
  ADD KEY `city` (`city`);

--
-- Indexes for table `organization_profile`
--
ALTER TABLE `organization_profile`
  ADD PRIMARY KEY (`organization_id`),
  ADD KEY `city` (`city`);

--
-- Indexes for table `scholarship_table`
--
ALTER TABLE `scholarship_table`
  ADD PRIMARY KEY (`scholarship_id`),
  ADD KEY `checked_by` (`checked_by`),
  ADD KEY `organization` (`organization`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `student_profile`
--
ALTER TABLE `student_profile`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `city` (`city`),
  ADD KEY `caste` (`caste`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `map_hobby`
--
ALTER TABLE `map_hobby`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `map_qualifications`
--
ALTER TABLE `map_qualifications`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `map_scholarships`
--
ALTER TABLE `map_scholarships`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `map_skills`
--
ALTER TABLE `map_skills`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_caste`
--
ALTER TABLE `master_caste`
  MODIFY `caste_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_city`
--
ALTER TABLE `master_city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_event`
--
ALTER TABLE `master_event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_hobby`
--
ALTER TABLE `master_hobby`
  MODIFY `hobby_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_qualification`
--
ALTER TABLE `master_qualification`
  MODIFY `qualification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_scholarship`
--
ALTER TABLE `master_scholarship`
  MODIFY `scholarship_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_sc_category`
--
ALTER TABLE `master_sc_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_skill`
--
ALTER TABLE `master_skill`
  MODIFY `skill_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_status`
--
ALTER TABLE `master_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `operator_profile`
--
ALTER TABLE `operator_profile`
  MODIFY `operator_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `organization_profile`
--
ALTER TABLE `organization_profile`
  MODIFY `organization_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scholarship_table`
--
ALTER TABLE `scholarship_table`
  MODIFY `scholarship_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_profile`
--
ALTER TABLE `student_profile`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `login_table`
--
ALTER TABLE `login_table`
  ADD CONSTRAINT `login_table_ibfk_1` FOREIGN KEY (`operator_user`) REFERENCES `operator_profile` (`operator_id`),
  ADD CONSTRAINT `login_table_ibfk_2` FOREIGN KEY (`organizer_user`) REFERENCES `organization_profile` (`organization_id`),
  ADD CONSTRAINT `login_table_ibfk_3` FOREIGN KEY (`student_user`) REFERENCES `student_profile` (`student_id`);

--
-- Constraints for table `map_hobby`
--
ALTER TABLE `map_hobby`
  ADD CONSTRAINT `map_hobby_ibfk_1` FOREIGN KEY (`hobby_id`) REFERENCES `master_hobby` (`hobby_id`),
  ADD CONSTRAINT `map_hobby_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_profile` (`student_id`);

--
-- Constraints for table `map_qualifications`
--
ALTER TABLE `map_qualifications`
  ADD CONSTRAINT `map_qualifications_ibfk_1` FOREIGN KEY (`qualification_id`) REFERENCES `master_qualification` (`qualification_id`),
  ADD CONSTRAINT `map_qualifications_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_profile` (`student_id`);

--
-- Constraints for table `map_scholarships`
--
ALTER TABLE `map_scholarships`
  ADD CONSTRAINT `map_scholarships_ibfk_1` FOREIGN KEY (`scholarship_id`) REFERENCES `scholarship_table` (`scholarship_id`),
  ADD CONSTRAINT `map_scholarships_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_profile` (`student_id`);

--
-- Constraints for table `map_skills`
--
ALTER TABLE `map_skills`
  ADD CONSTRAINT `map_skills_ibfk_1` FOREIGN KEY (`skill_id`) REFERENCES `master_skill` (`skill_id`),
  ADD CONSTRAINT `map_skills_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_profile` (`student_id`);

--
-- Constraints for table `master_scholarship`
--
ALTER TABLE `master_scholarship`
  ADD CONSTRAINT `master_scholarship_ibfk_1` FOREIGN KEY (`category`) REFERENCES `master_sc_category` (`category_id`);

--
-- Constraints for table `operator_profile`
--
ALTER TABLE `operator_profile`
  ADD CONSTRAINT `operator_profile_ibfk_1` FOREIGN KEY (`city`) REFERENCES `master_city` (`city_id`);

--
-- Constraints for table `organization_profile`
--
ALTER TABLE `organization_profile`
  ADD CONSTRAINT `organization_profile_ibfk_1` FOREIGN KEY (`city`) REFERENCES `master_city` (`city_id`);

--
-- Constraints for table `scholarship_table`
--
ALTER TABLE `scholarship_table`
  ADD CONSTRAINT `scholarship_table_ibfk_1` FOREIGN KEY (`checked_by`) REFERENCES `operator_profile` (`operator_id`),
  ADD CONSTRAINT `scholarship_table_ibfk_2` FOREIGN KEY (`organization`) REFERENCES `organization_profile` (`organization_id`),
  ADD CONSTRAINT `scholarship_table_ibfk_3` FOREIGN KEY (`status`) REFERENCES `master_status` (`status_id`);

--
-- Constraints for table `student_profile`
--
ALTER TABLE `student_profile`
  ADD CONSTRAINT `student_profile_ibfk_1` FOREIGN KEY (`city`) REFERENCES `master_city` (`city_id`),
  ADD CONSTRAINT `student_profile_ibfk_2` FOREIGN KEY (`caste`) REFERENCES `master_caste` (`caste_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
