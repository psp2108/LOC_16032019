-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 16, 2019 at 04:57 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_hobby` (IN `_uid` VARCHAR(12), IN `hobbyID` INT)  BEGIN

	DECLARE student_id int;
    DECLARE count int;

    set student_id = (select student_user from login_table where user_id = _uid);
    set count = (select count(*) from map_hobby where map_hobby.student_id = student_id and map_hobby.hobby_id = hobbyID);

    if count = 0 THEN
        insert into map_hobby (map_hobby.student_id, map_hobby.hobby_id) values (student_id, hobbyID);
    end if;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_skills` (IN `_uid` VARCHAR(12), IN `SkillID` INT)  BEGIN

	DECLARE student_id int;
    DECLARE count int;

    set student_id = (select student_user from login_table where user_id = _uid);
    set count = (select count(*) from map_skills where map_skills.student_id = student_id and map_skills.skill_id = SkillID);

    if count = 0 THEN
        insert into map_skills (map_skills.student_id, map_skills.skill_id) values (student_id, SkillID);
    end if;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `change_login_detail` (IN `_uid` VARCHAR(12), IN `old_pwd` VARCHAR(50), IN `_pwd` VARCHAR(50), IN `_email` VARCHAR(500), IN `_phone` VARCHAR(10))  BEGIN
    DECLARE PWD varchar(50);

    set PWD = (select password from login_table where user_id = _uid);

    if (PWD = old_pwd) THEN
        update login_table set password = _pwd,
        email = email,
        phone_no = _phone
        where user_id = _uid;

        select "User Updated";
    ELSE
        select "Password Mismatched";
    end if;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `credential_check` (IN `_uid` VARCHAR(12), IN `_pwd` VARCHAR(50))  BEGIN

    IF(select count(*) from login_table where 
       user_id=_uid AND password=_pwd) > 0 THEN 
    
    	SELECT "true";
    ELSE
    	SELECT "false";
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_caste` ()  BEGIN

	select * from master_caste;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_city` ()  BEGIN

	select * from master_city;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_course` ()  BEGIN

	select course_id, CONCAT(main_course, " - ", sub_course, " (year ", course_year, ")") from master_course;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_event` ()  BEGIN

	select * from master_event;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_hobby` ()  BEGIN

	select * from master_hobby;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_qualification` ()  BEGIN

	SELECT * FROM master_qualification;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_scholarship_category` ()  BEGIN

	SELECT * FROM master_sc_category;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sensetive_data` (IN `_uid` VARCHAR(12))  BEGIN
    select user_id, email, phone_no from login_table where user_id = _uid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_skills` ()  BEGIN

	SELECT * FROM master_skill;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user` (IN `_uid` VARCHAR(12), IN `_pwd` VARCHAR(50), IN `email` VARCHAR(500), IN `phone` VARCHAR(10), IN `_name` VARCHAR(400), IN `type` INT)  BEGIN

	DECLARE TYPE_ID INT;
    
    IF (type = 0) THEN 
    	insert into student_profile (student_profile.name) value (_name);
        
        set TYPE_ID = (select student_id from student_profile order by student_id desc limit 1);
        
        update login_table set student_user = TYPE_ID;
    	SELECT "Student";
    ELSE 
        IF (type = 1) THEN
            insert into organization_profile (name) values (_name);

            set TYPE_ID = (select organization_id from organization_profile order by organization_id desc limit 1);

            
            SELECT "ORGANIZER";
        ELSE 
            IF (type = 2) THEN
                insert into operator_profile (name) values (_name);

                set TYPE_ID = (select operator_id from operator_profile order by operator_id desc limit 1);

                update login_table set operator_user = TYPE_ID;

                SELECT "OPERATOR";
            END IF;
        END IF;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_operator` (IN `_uid` VARCHAR(12), IN `_name` VARCHAR(1000), IN `_city` INT)  BEGIN

	DECLARE operator_id int;
    
    set operator_id = (select operator_user from login_table where user_id = _uid);
    
    update operator_profile set
    name = _name,
    city = _city
    where operator_profile.operator_id = operator_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_organizer` (IN `_uid` VARCHAR(12), IN `_name` VARCHAR(1000), IN `_city` INT)  BEGIN

	DECLARE organization_id int;
    
    set organization_id = (select organizer_user from login_table where user_id = _uid);
    
    update organization_profile set
    name = _name,
    city = _city
    where organization_profile.organization_id = organization_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_scholarship_details` (IN `_uid` VARCHAR(12), IN `categoryID` INT, IN `scholarship_name` VARCHAR(1000), IN `last_date` DATETIME, IN `_url` VARCHAR(1000), IN `_annual_income` DOUBLE, IN `casteID` INT, IN `eventID` INT, IN `qualificationID` INT, IN `_qualification_score` INT, IN `courseID` INT)  BEGIN

    DECLARE _scholarship_id int;
    DECLARE _eligibility_id int;
	DECLARE organization_id int;
    
    set organization_id = (select organizer_user from login_table where user_id = _uid);
    
    insert into master_scholarship (scholarships, category) values (scholarship_name,categoryID);
    set _scholarship_id = (select scholarship_id from master_scholarship order by scholarship_id desc limit 1);
	
    if categoryID=1 THEN 
    	insert into eligibility_criteria (annual_income,organization,scholarship) values 
        (_annual_income, organization_id, _scholarship_id);
            end if;
    if categoryID=2 THEN 
    	insert into eligibility_criteria (caste,organization,scholarship) values 
        (casteID, organization_id, _scholarship_id);
            end if;
    if categoryID=3 THEN 
    	insert into eligibility_criteria (events,organization,scholarship) values 
        (eventID, organization_id, _scholarship_id);
            end if;
    if categoryID=4 THEN 
    	if qualificationID != -1 and courseId != -1 THEN
    		insert into eligibility_criteria (qualification,qualification_score,upcomming_course,organization,scholarship) 
            values (qualificationID,_qualification_score,courseID,organization_id,_scholarship_id);
        end if;
    	if courseId != -1 THEN
    		insert into eligibility_criteria (upcomming_course,organization,scholarship) values (courseID, organization_id, _scholarship_id);
        end if;
    	if qualificationID != -1 THEN
    		insert into eligibility_criteria (qualification,qualification_score,organization,scholarship) 
            values (qualificationID,_qualification_score, organization_id, _scholarship_id);
        end if;
        
            end if;
	
    set _eligibility_id = (select criteria_id from eligibility_criteria order by criteria_id desc limit 1);
    
    insert into scholarship_table (name,organization,last_date_to_apply,url_site,scholarship,eligibility) 
    values (scholarship_name,organization_id,last_date,_url,_scholarship_id,_eligibility_id);
    

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_student` (IN `_uid` VARCHAR(12), IN `_name` VARCHAR(400), IN `_age` INT, IN `_gender` VARCHAR(10), IN `_physical_disability` VARCHAR(1000), IN `_course` INT, IN `_adhar_card` VARCHAR(12), IN `_city` INT, IN `_caste` INT, IN `_caste_certificate` VARCHAR(1000), IN `_resume_path` VARCHAR(1000), IN `_income_certificate` VARCHAR(1000), IN `_annual_income` DOUBLE, IN `_dob` DATETIME)  BEGIN

	DECLARE student_id int;
    
    set student_id = (select student_user from login_table where user_id = _uid);
    
    update student_profile set
    name = _name,
    age = _age,
    gender = _gender,
    physical_disability = _physical_disability,
    course = _course,
    adhar_number = _adhar_card,
    city = _city,
    caste = _caste,
    caste_certificate = caste_certificate,
    resume_path = _resume_path,
    annual_income = _annual_income,
    student_profile.income_certificte_path = _income_certificate,
    dob = _dob
    where student_profile.student_id = student_id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `eligibility_criteria`
--

CREATE TABLE `eligibility_criteria` (
  `criteria_id` int(11) NOT NULL,
  `caste` int(11) DEFAULT NULL,
  `qualification` int(11) DEFAULT NULL,
  `qualification_score` int(11) DEFAULT NULL,
  `annual_income` double DEFAULT NULL,
  `events` int(11) DEFAULT NULL,
  `organization` int(11) NOT NULL,
  `scholarship` int(11) NOT NULL,
  `upcomming_course` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `eligibility_criteria`
--

INSERT INTO `eligibility_criteria` (`criteria_id`, `caste`, `qualification`, `qualification_score`, `annual_income`, `events`, `organization`, `scholarship`, `upcomming_course`) VALUES
(11, 1, NULL, NULL, NULL, NULL, 4, 3, NULL),
(12, NULL, NULL, NULL, 500000, NULL, 4, 2, NULL),
(13, NULL, NULL, NULL, 0, 1, 5, 7, NULL),
(14, NULL, 1, 85, 0, NULL, 6, 5, NULL),
(15, NULL, NULL, NULL, 0, NULL, 6, 6, 1),
(16, NULL, 11, 90, 0, NULL, 6, 9, 1),
(36, NULL, NULL, NULL, NULL, NULL, 4, 25, 4);

-- --------------------------------------------------------

--
-- Table structure for table `login_table`
--

CREATE TABLE `login_table` (
  `user_id` varchar(12) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(500) NOT NULL,
  `phone_no` varchar(10) NOT NULL,
  `token` varchar(64) DEFAULT NULL,
  `student_user` int(11) DEFAULT NULL,
  `organizer_user` int(11) DEFAULT NULL,
  `operator_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login_table`
--

INSERT INTO `login_table` (`user_id`, `password`, `email`, `phone_no`, `token`, `student_user`, `organizer_user`, `operator_user`) VALUES
('org1', '123', 'org@gmail.com', '8879799396', NULL, NULL, 4, NULL),
('pratiksp', '12345', 'pratik.sp.1112@gmail.com', '8104461845', NULL, 3, NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `map_hobby`
--

CREATE TABLE `map_hobby` (
  `self_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `hobby_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `map_hobby`
--

INSERT INTO `map_hobby` (`self_id`, `student_id`, `hobby_id`) VALUES
(3, 3, 1),
(4, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `map_qualifications`
--

CREATE TABLE `map_qualifications` (
  `self_id` int(11) NOT NULL,
  `qualification_id` int(11) NOT NULL,
  `institute_or_name` varchar(1000) NOT NULL,
  `other_achievement` varchar(1000) NOT NULL,
  `student_id` int(11) NOT NULL,
  `total_score` int(11) NOT NULL,
  `certificate_path` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `map_qualifications`
--

INSERT INTO `map_qualifications` (`self_id`, `qualification_id`, `institute_or_name`, `other_achievement`, `student_id`, `total_score`, `certificate_path`) VALUES
(1, 1, 'St. John Bosco High School', '', 3, 86, '');

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

--
-- Dumping data for table `map_skills`
--

INSERT INTO `map_skills` (`self_id`, `student_id`, `skill_id`) VALUES
(1, 3, 1),
(2, 3, 3),
(3, 3, 2),
(4, 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `master_caste`
--

CREATE TABLE `master_caste` (
  `caste_id` int(11) NOT NULL,
  `Caste` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_caste`
--

INSERT INTO `master_caste` (`caste_id`, `Caste`) VALUES
(1, 'SC'),
(2, 'ST'),
(3, 'OBC'),
(4, 'SBC'),
(5, 'VJNT'),
(6, 'Buddism');

-- --------------------------------------------------------

--
-- Table structure for table `master_city`
--

CREATE TABLE `master_city` (
  `city_id` int(11) NOT NULL,
  `Cities` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_city`
--

INSERT INTO `master_city` (`city_id`, `Cities`) VALUES
(1, 'Mumbai'),
(2, 'Pune'),
(3, 'Nagpur'),
(4, 'Nashik'),
(5, 'Palghar'),
(6, 'Aurangabad'),
(7, 'Solapur'),
(8, 'Dhule'),
(9, 'Amravati'),
(10, 'Nashik'),
(11, 'Kolhapur'),
(12, 'Nanded'),
(13, 'Sangli'),
(14, 'Thane'),
(15, 'Akola'),
(16, 'Latur'),
(17, 'Ahmednagar'),
(18, 'Jalgaon'),
(19, 'Kolhapur'),
(20, 'Chandrapur'),
(21, 'Parbhani'),
(22, 'Jalna'),
(23, 'Jalgaon'),
(24, 'Panvel'),
(25, 'Panvel'),
(26, 'Satara'),
(27, 'Beed'),
(28, 'Yavatmal'),
(29, 'Nagpur'),
(30, 'Gondia'),
(31, 'Solapur'),
(32, 'Amravati'),
(33, 'Osmanabad'),
(34, 'Nandurbar'),
(35, 'Wardha'),
(36, 'Latur'),
(37, 'Wardha');

-- --------------------------------------------------------

--
-- Table structure for table `master_course`
--

CREATE TABLE `master_course` (
  `course_id` int(11) NOT NULL,
  `main_course` varchar(1000) NOT NULL,
  `sub_course` varchar(1000) NOT NULL,
  `course_year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_course`
--

INSERT INTO `master_course` (`course_id`, `main_course`, `sub_course`, `course_year`) VALUES
(1, 'Degree', 'Computer Engineering', 1),
(2, 'Degree', 'Computer Engineering', 2),
(3, 'Degree', 'Computer Engineering', 3),
(4, 'Degree', 'Computer Engineering', 4),
(5, 'Diploma', 'Computer Engineering', 1),
(6, 'Diploma', 'Computer Engineering', 2),
(7, 'Diploma', 'Computer Engineering', 3),
(8, 'Diploma', 'Computer Engineering', 4),
(9, 'SSC', 'Maharashtra State Board', 10);

-- --------------------------------------------------------

--
-- Table structure for table `master_event`
--

CREATE TABLE `master_event` (
  `event_id` int(11) NOT NULL,
  `events` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_event`
--

INSERT INTO `master_event` (`event_id`, `events`) VALUES
(1, 'Chess Compedition'),
(2, 'Carrom Compedition'),
(3, 'Cubing Compedition'),
(4, 'Cricket Match'),
(5, 'Paper Presentation'),
(6, 'Dance Compedition'),
(7, 'Singing Compedition'),
(8, 'Quiz Round on Bollywood');

-- --------------------------------------------------------

--
-- Table structure for table `master_hobby`
--

CREATE TABLE `master_hobby` (
  `hobby_id` int(11) NOT NULL,
  `hobbies` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_hobby`
--

INSERT INTO `master_hobby` (`hobby_id`, `hobbies`) VALUES
(1, 'Chess'),
(2, 'Cubing'),
(3, 'Carrom'),
(4, 'Reading'),
(5, 'Writing'),
(6, 'Dancing'),
(7, 'Singing'),
(8, 'Listening to Musics'),
(9, 'Watching Movies');

-- --------------------------------------------------------

--
-- Table structure for table `master_qualification`
--

CREATE TABLE `master_qualification` (
  `qualification_id` int(11) NOT NULL,
  `qualifications` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_qualification`
--

INSERT INTO `master_qualification` (`qualification_id`, `qualifications`) VALUES
(1, 'SSC'),
(2, 'JEE'),
(3, 'CET'),
(4, 'GATE'),
(5, 'GRE'),
(6, 'Diploma Sem 1'),
(7, 'Diploma Sem 2'),
(8, 'Diploma Sem 3'),
(9, 'Diploma Sem 4'),
(10, 'Diploma Sem 5'),
(11, 'Diploma Sem 6'),
(12, 'Diploma Sem 7'),
(13, 'Diploma Sem 8'),
(14, 'Degree sem 1'),
(15, 'Degree sem 2'),
(16, 'Degree sem 3'),
(17, 'Degree sem 4'),
(18, 'Degree sem 5'),
(19, 'Degree sem 6'),
(20, 'Degree sem 7'),
(21, 'Degree sem 8');

-- --------------------------------------------------------

--
-- Table structure for table `master_scholarship`
--

CREATE TABLE `master_scholarship` (
  `scholarship_id` int(11) NOT NULL,
  `scholarships` varchar(500) NOT NULL,
  `amount` double NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_scholarship`
--

INSERT INTO `master_scholarship` (`scholarship_id`, `scholarships`, `amount`, `category`) VALUES
(1, 'Government of India Post-Matric Scholarship', 0, 1),
(2, 'Post-Matric Tuition Fee and Examination Fee (Freeship)', 0, 1),
(3, 'Maintenance Allowance for student Studying in professional courses', 0, 2),
(4, 'Rajarshri Chhatrapati Shahu Maharaj Merit Scholarship', 0, 2),
(5, 'Post-Matric Scholarship for persons with disability', 0, 3),
(6, 'Post Matric Scholarship Scheme (Government Of India)', 0, 3),
(7, 'Tuition Fee &  Exam Fee for Tribal Students (Freeship)', 0, 4),
(8, 'Vocational Education Fee Reimbursement', 0, 4),
(9, 'Vocational Education Maintenance Allowance', 0, 3),
(25, 'Scholarship name', 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `master_sc_category`
--

CREATE TABLE `master_sc_category` (
  `category_id` int(11) NOT NULL,
  `categories` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_sc_category`
--

INSERT INTO `master_sc_category` (`category_id`, `categories`) VALUES
(1, 'Financial'),
(2, 'Backword'),
(3, 'Academics'),
(4, 'Other Activities');

-- --------------------------------------------------------

--
-- Table structure for table `master_skill`
--

CREATE TABLE `master_skill` (
  `skill_id` int(11) NOT NULL,
  `skills` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_skill`
--

INSERT INTO `master_skill` (`skill_id`, `skills`) VALUES
(1, 'Java'),
(2, 'Advance Java'),
(3, 'Python'),
(4, 'Advance Python'),
(5, 'MySql'),
(6, 'MongoDB'),
(7, 'Machine LEarning'),
(8, 'Photoshop'),
(9, 'Video Editing'),
(10, 'Graphics Designing'),
(11, 'Animation');

-- --------------------------------------------------------

--
-- Table structure for table `master_status`
--

CREATE TABLE `master_status` (
  `status_id` int(11) NOT NULL,
  `status` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_status`
--

INSERT INTO `master_status` (`status_id`, `status`) VALUES
(1, 'Pending'),
(2, 'Approved'),
(3, 'Rejected');

-- --------------------------------------------------------

--
-- Table structure for table `operator_profile`
--

CREATE TABLE `operator_profile` (
  `operator_id` int(11) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `city` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `operator_profile`
--

INSERT INTO `operator_profile` (`operator_id`, `name`, `city`) VALUES
(1, 'Neel Patel', 1),
(2, 'Operator Name', 4);

-- --------------------------------------------------------

--
-- Table structure for table `organization_profile`
--

CREATE TABLE `organization_profile` (
  `organization_id` int(11) NOT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `total_scholarships` int(11) DEFAULT NULL,
  `total_events` int(11) DEFAULT NULL,
  `city` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization_profile`
--

INSERT INTO `organization_profile` (`organization_id`, `name`, `total_scholarships`, `total_events`, `city`) VALUES
(4, 'L & T Build India Scholarship', 0, 0, 1),
(5, 'NDDC Scholarships', 0, 0, 2),
(6, 'SGPC Cambridge Scholarship', 0, 0, 6);

-- --------------------------------------------------------

--
-- Table structure for table `scholarship_table`
--

CREATE TABLE `scholarship_table` (
  `scholarship_id` int(11) NOT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `organization` int(11) NOT NULL,
  `last_date_to_apply` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `url_site` varchar(1000) NOT NULL,
  `scholarship` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `checked_by` int(11) DEFAULT NULL,
  `eligibility` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scholarship_table`
--

INSERT INTO `scholarship_table` (`scholarship_id`, `name`, `organization`, `last_date_to_apply`, `url_site`, `scholarship`, `status`, `checked_by`, `eligibility`) VALUES
(12, 'Scholarship name', 4, '2020-01-01 00:00:00', 'https://www.url.com/', 25, 1, NULL, 36);

-- --------------------------------------------------------

--
-- Table structure for table `student_profile`
--

CREATE TABLE `student_profile` (
  `student_id` int(11) NOT NULL,
  `name` varchar(400) DEFAULT NULL,
  `gender` varchar(10) NOT NULL DEFAULT 'Male',
  `age` int(11) DEFAULT NULL,
  `physical_disability` varchar(1000) DEFAULT NULL,
  `course` int(11) DEFAULT NULL,
  `total_hobbies` int(11) DEFAULT NULL,
  `total_skills` int(11) DEFAULT NULL,
  `adhar_number` varchar(12) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `caste` int(11) DEFAULT NULL,
  `caste_certificate` varchar(1000) DEFAULT NULL,
  `resume_path` varchar(1000) DEFAULT NULL,
  `annual_income` double DEFAULT NULL,
  `income_certificte_path` varchar(1000) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_profile`
--

INSERT INTO `student_profile` (`student_id`, `name`, `gender`, `age`, `physical_disability`, `course`, `total_hobbies`, `total_skills`, `adhar_number`, `city`, `caste`, `caste_certificate`, `resume_path`, `annual_income`, `income_certificte_path`, `dob`, `status`) VALUES
(3, 'Pratik Panchal', 'Male', 10, NULL, 4, NULL, NULL, '998877665544', 2, 2, NULL, 'C/Resume', 500000, 'C:/Income Certificate', '1998-08-21', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eligibility_criteria`
--
ALTER TABLE `eligibility_criteria`
  ADD PRIMARY KEY (`criteria_id`),
  ADD KEY `caste` (`caste`),
  ADD KEY `qualification` (`qualification`),
  ADD KEY `events` (`events`),
  ADD KEY `scholarship` (`scholarship`),
  ADD KEY `organization` (`organization`),
  ADD KEY `upcomming_course` (`upcomming_course`);

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
-- Indexes for table `master_course`
--
ALTER TABLE `master_course`
  ADD PRIMARY KEY (`course_id`);

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
  ADD KEY `status` (`status`),
  ADD KEY `scholarship` (`scholarship`);

--
-- Indexes for table `student_profile`
--
ALTER TABLE `student_profile`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `city` (`city`),
  ADD KEY `caste` (`caste`),
  ADD KEY `course` (`course`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `eligibility_criteria`
--
ALTER TABLE `eligibility_criteria`
  MODIFY `criteria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `map_hobby`
--
ALTER TABLE `map_hobby`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `map_qualifications`
--
ALTER TABLE `map_qualifications`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `map_scholarships`
--
ALTER TABLE `map_scholarships`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `map_skills`
--
ALTER TABLE `map_skills`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `master_caste`
--
ALTER TABLE `master_caste`
  MODIFY `caste_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `master_city`
--
ALTER TABLE `master_city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `master_course`
--
ALTER TABLE `master_course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `master_event`
--
ALTER TABLE `master_event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `master_hobby`
--
ALTER TABLE `master_hobby`
  MODIFY `hobby_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `master_qualification`
--
ALTER TABLE `master_qualification`
  MODIFY `qualification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `master_scholarship`
--
ALTER TABLE `master_scholarship`
  MODIFY `scholarship_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `master_sc_category`
--
ALTER TABLE `master_sc_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `master_skill`
--
ALTER TABLE `master_skill`
  MODIFY `skill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `master_status`
--
ALTER TABLE `master_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `operator_profile`
--
ALTER TABLE `operator_profile`
  MODIFY `operator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `organization_profile`
--
ALTER TABLE `organization_profile`
  MODIFY `organization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `scholarship_table`
--
ALTER TABLE `scholarship_table`
  MODIFY `scholarship_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `student_profile`
--
ALTER TABLE `student_profile`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `eligibility_criteria`
--
ALTER TABLE `eligibility_criteria`
  ADD CONSTRAINT `eligibility_criteria_ibfk_1` FOREIGN KEY (`caste`) REFERENCES `master_caste` (`caste_id`),
  ADD CONSTRAINT `eligibility_criteria_ibfk_2` FOREIGN KEY (`qualification`) REFERENCES `master_qualification` (`qualification_id`),
  ADD CONSTRAINT `eligibility_criteria_ibfk_3` FOREIGN KEY (`events`) REFERENCES `master_event` (`event_id`),
  ADD CONSTRAINT `eligibility_criteria_ibfk_4` FOREIGN KEY (`scholarship`) REFERENCES `master_scholarship` (`scholarship_id`),
  ADD CONSTRAINT `eligibility_criteria_ibfk_5` FOREIGN KEY (`organization`) REFERENCES `organization_profile` (`organization_id`),
  ADD CONSTRAINT `eligibility_criteria_ibfk_6` FOREIGN KEY (`upcomming_course`) REFERENCES `master_course` (`course_id`);

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
  ADD CONSTRAINT `scholarship_table_ibfk_4` FOREIGN KEY (`scholarship`) REFERENCES `master_scholarship` (`scholarship_id`),
  ADD CONSTRAINT `scholarship_table_ibfk_5` FOREIGN KEY (`status`) REFERENCES `master_status` (`status_id`);

--
-- Constraints for table `student_profile`
--
ALTER TABLE `student_profile`
  ADD CONSTRAINT `student_profile_ibfk_1` FOREIGN KEY (`city`) REFERENCES `master_city` (`city_id`),
  ADD CONSTRAINT `student_profile_ibfk_2` FOREIGN KEY (`caste`) REFERENCES `master_caste` (`caste_id`),
  ADD CONSTRAINT `student_profile_ibfk_3` FOREIGN KEY (`course`) REFERENCES `master_course` (`course_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
