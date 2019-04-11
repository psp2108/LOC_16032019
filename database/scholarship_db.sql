-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2019 at 02:01 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_qualification` (IN `_uid` VARCHAR(12), IN `_qualification` INT, IN `institute` VARCHAR(1000), IN `other_achievement` VARCHAR(1000), IN `score` INT, IN `certificate` VARCHAR(1000))  BEGIN

	DECLARE student_id int;
    
    set student_id = (select student_user from login_table where user_id = _uid);

	INSERT INTO map_qualifications (qualification_id, institute_or_name, other_achievement, student_id, total_score, certificate_path) VALUES (_qualification,institute,other_achievement,student_id,score,certificate);
    
    
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
    DECLARE student int;
    DECLARE operator int;
    DECLARE organizer int;

    IF(select count(*) from login_table where 
       user_id=_uid AND password=_pwd) > 0 THEN 

        set student = (select student_user from login_table where user_id = _uid);
        set operator = (select operator_user from login_table where user_id = _uid);
        set organizer = (select organizer_user from login_table where user_id = _uid);

        if student is not null then 
            select "True","0";
        end if;
        if operator is not null then 
            select "True","2";
        end if;
        if organizer is not null then 
            select "True","1";
        end if;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_eligible_scholarships` (IN `_uid` VARCHAR(12))  BEGIN
	DECLARE student_id int;
	DECLARE income double;
    
    
    set student_id = (select student_user from login_table where user_id = _uid);

                    
    select 
    	master_scholarship.scholarship_id,
    	organization_profile.name,
        master_sc_category.categories,
        master_scholarship.scholarships,
        scholarship_table.url_site,
        scholarship_table.last_date_to_apply
            from 
    eligibility_criteria,master_scholarship,organization_profile,student_profile,
    master_qualification,map_qualifications, master_sc_category, scholarship_table
    WHERE
    
    ((eligibility_criteria.annual_income >= student_profile.annual_income AND
    eligibility_criteria.annual_income is not NULL and
    eligibility_criteria.annual_income != 0) or
     
    (eligibility_criteria.caste = student_profile.caste) or
     
    (eligibility_criteria.upcomming_course = student_profile.course) or 
     
    (eligibility_criteria.qualification = master_qualification.qualification_id AND
    map_qualifications.qualification_id = master_qualification.qualification_id AND
    map_qualifications.student_id = student_profile.student_id AND
    eligibility_criteria.qualification_score is not NULL and
    eligibility_criteria.qualification_score != 0 and
    eligibility_criteria.qualification_score <= map_qualifications.total_score)) and
    
    student_profile.student_id = student_id and
    eligibility_criteria.scholarship = master_scholarship.scholarship_id AND
    eligibility_criteria.organization = organization_profile.organization_id AND
    master_scholarship.category = master_sc_category.category_id 
       
    group by eligibility_criteria.criteria_id;
	
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_scholarship` (IN `sch_id` INT)  BEGIN


	DECLARE _cat int;
    set _cat = (select master_sc_category.category_id from master_sc_category, master_scholarship, scholarship_table where scholarship_table.scholarship = master_scholarship.scholarship_id and master_scholarship.category = master_sc_category.category_id limit 1);

    
    if _cat = 1 THEN
    
        select master_sc_category.categories,
        master_scholarship.scholarships,
        scholarship_table.url_site,
        scholarship_table.last_date_to_apply,
        CONCAT("Income < ",eligibility_criteria.annual_income)

        from 
        master_sc_category,master_scholarship,
        scholarship_table,eligibility_criteria

        where
        master_sc_category.category_id = master_scholarship.category AND
        master_scholarship.scholarship_id = scholarship_table.scholarship AND
        eligibility_criteria.annual_income != 0 AND
        eligibility_criteria.annual_income is not NULL and
        scholarship_table.scholarship_id = sch_id;
    end if;
   
    if _cat = 2 THEN
        select 
        master_sc_category.categories,
        master_scholarship.scholarships,
        scholarship_table.url_site,
        scholarship_table.last_date_to_apply,
        master_caste.Caste

        from 
        master_sc_category,master_scholarship,
        scholarship_table,eligibility_criteria,
        master_caste

        where
        master_sc_category.category_id = master_scholarship.category AND
        master_scholarship.scholarship_id = scholarship_table.scholarship AND
                eligibility_criteria.caste = master_caste.caste_id AND
        eligibility_criteria.caste != 0 AND
        eligibility_criteria.caste is not NULL and
        scholarship_table.scholarship_id = sch_id;
    
    end if;
    
   if _cat = 3 THEN
   		select 
        master_sc_category.categories,
        master_scholarship.scholarships,
        scholarship_table.url_site,
        scholarship_table.last_date_to_apply,
        master_course.sub_course,
        master_qualification.qualifications

        from 
        master_sc_category,master_scholarship,
        scholarship_table,eligibility_criteria,
        master_course, master_qualification

        where
        master_sc_category.category_id = master_scholarship.category AND
        master_scholarship.scholarship_id = scholarship_table.scholarship AND
        eligibility_criteria.upcomming_course = master_course.course_id AND
        eligibility_criteria.upcomming_course != 0 AND
        eligibility_criteria.upcomming_course is not NULL and
        eligibility_criteria.qualification = master_qualification.qualification_id and
        eligibility_criteria.qualification != 0 AND
        eligibility_criteria.qualification is not NULL and
        scholarship_table.scholarship_id = sch_id;
   end if;
  
  if _cat = 4 then 
   		
        select 
        master_sc_category.categories,
        master_scholarship.scholarships,
        scholarship_table.url_site,
        scholarship_table.last_date_to_apply,
        master_event.events

        from 
        master_sc_category,master_scholarship,
        scholarship_table,eligibility_criteria,
        master_event

        where
        master_sc_category.category_id = master_scholarship.category AND
        master_scholarship.scholarship_id = scholarship_table.scholarship AND
                eligibility_criteria.events = master_event.event_id AND
        eligibility_criteria.events != 0 AND
        eligibility_criteria.events is not NULL and
        scholarship_table.scholarship_id = sch_id;
  
  end if;

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `inspect_scholarship` (IN `id` INT, IN `_status` INT)  BEGIN

	update scholarship_table set status = _status where scholarship_id = id;
    select "True";

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inspect_student` (IN `id` INT, IN `_status` INT)  BEGIN

	update student_profile set status = _status where student_id = id;
    select "True";

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user` (IN `_uid` VARCHAR(12), IN `_pwd` VARCHAR(50), IN `email` VARCHAR(500), IN `phone` VARCHAR(10), IN `_name` VARCHAR(400), IN `type` INT)  BEGIN

	DECLARE TYPE_ID INT;
    
    IF (type = 0) THEN 
    	insert into student_profile (student_profile.name) value (_name);
        
        set TYPE_ID = (select student_id from student_profile order by student_id desc limit 1);
        
        insert into login_table (user_id,password,email,phone_no,student_user) values (_uid, _pwd, email, phone, TYPE_ID);
        update login_table set student_user = TYPE_ID where user_id = _uid;
    	SELECT "STUDENT",user_id from login_table where user_id = _uid;
    ELSE 
        IF (type = 1) THEN
            insert into organization_profile (name) values (_name);

            set TYPE_ID = (select organization_id from organization_profile order by organization_id desc limit 1);

            insert into login_table (user_id,password,email,phone_no,organizer_user) values (_uid, _pwd, email, phone, TYPE_ID);

            SELECT "ORGANIZER",user_id from login_table where user_id = _uid;
        ELSE 
            IF (type = 2) THEN
                insert into operator_profile (name) values (_name);

                set TYPE_ID = (select operator_id from operator_profile order by operator_id desc limit 1);

                insert into login_table (user_id,password,email,phone_no,operator_user) values (_uid, _pwd, email, phone, TYPE_ID);

                SELECT 'OPERATOR',user_id from login_table where user_id = _uid;
            ELSE
                Select 'False';
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

    select "True";

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_scholarships` (IN `org_id` INT)  BEGIN
	
    if (select count(*) from scholarship_table where scholarship_table.organization = org_id) > 0 then
        select scholarship_table.name, scholarship_table.url_site from 
        organization_profile, scholarship_table where 
        scholarship_table.organization = organization_profile.organization_id AND
        organization_profile.organization_id = org_id;
    ELSE
    	select "";
    end if;

END$$

DELIMITER ;

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
('org_1007', '1007', 'neelpatel3039@gmail.com', '8879366022', NULL, NULL, 22, NULL),
('org_1008', '1008', 'Barry@email.com', '7171358594', NULL, NULL, 23, NULL),
('org_1009', '1009', 'Bertha@email.com', '9167464457', NULL, NULL, 24, NULL),
('org_1010', '1010', 'Bill@email.com', '7659748572', NULL, NULL, 25, NULL),
('org_1011', '1011', 'Bonnie@email.com', '6134598425', NULL, NULL, 26, NULL),
('org_1012', '1012', 'Bret@email.com', '7773997290', NULL, NULL, 27, NULL),
('o_1000', '1000', 'pratik.sp.1112@gmail.com', '8879799396', NULL, NULL, NULL, 18),
('stud_1001', '1001', 'pk.panchal.526@gmail.com', '7021513100', NULL, 23, NULL, NULL),
('stud_1002', '1002', 'Allison@email.com', '8768091327', NULL, 24, NULL, NULL),
('stud_1003', '1003', 'Arthur@email.com', '7417668468', NULL, 25, NULL, NULL),
('stud_1004', '1004', 'Ana@email.com', '7002333834', NULL, 26, NULL, NULL),
('stud_1005', '1005', 'Alex@email.com', '7099225010', NULL, 27, NULL, NULL),
('stud_1006', '1006', 'Arlene@email.com', '9814847105', NULL, 28, NULL, NULL);

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
(11, 24, 8),
(12, 24, 2),
(13, 26, 9),
(14, 26, 1),
(15, 26, 2),
(16, 26, 5),
(17, 26, 3),
(18, 27, 3),
(19, 27, 9),
(20, 27, 2),
(21, 27, 8),
(22, 27, 5),
(23, 28, 6),
(24, 28, 1),
(25, 28, 3),
(26, 28, 8),
(27, 28, 5);

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
(6, 1, 'Government Secondary School, Rani', 'NULL', 23, 69, 'c:/certificate10010'),
(7, 6, 'Don Bosco High School, Guwahati', 'NULL', 23, 77, 'c:/certificate10011'),
(8, 7, 'Don Bosco High School, Guwahati', 'NULL', 23, 70, 'c:/certificate10012'),
(9, 8, 'Don Bosco High School, Guwahati', 'NULL', 23, 73, 'c:/certificate10013'),
(10, 9, 'Don Bosco High School, Guwahati', 'NULL', 23, 65, 'c:/certificate10014'),
(11, 10, 'Don Bosco High School, Guwahati', 'NULL', 23, 70, 'c:/certificate10015'),
(12, 11, 'Don Bosco High School, Guwahati', 'NULL', 23, 93, 'c:/certificate10016'),
(13, 1, 'Career Point University', 'NULL', 24, 64, 'c:/certificate10020'),
(14, 1, 'Banaras Hindu University', 'NULL', 25, 99, 'c:/certificate10030'),
(15, 14, 'IIHMR University', 'NULL', 25, 97, 'c:/certificate10031'),
(16, 15, 'IIHMR University', 'NULL', 25, 64, 'c:/certificate10032'),
(17, 1, 'St. Xavier\'s College of Education, Hindupur', 'NULL', 26, 60, 'c:/certificate10040'),
(18, 6, 'Integral University', 'NULL', 26, 68, 'c:/certificate10041'),
(19, 7, 'Integral University', 'NULL', 26, 99, 'c:/certificate10042'),
(20, 8, 'Integral University', 'NULL', 26, 85, 'c:/certificate10043'),
(21, 9, 'Integral University', 'NULL', 26, 71, 'c:/certificate10044'),
(22, 10, 'Integral University', 'NULL', 26, 98, 'c:/certificate10045'),
(23, 11, 'Integral University', 'NULL', 26, 98, 'c:/certificate10046'),
(24, 1, 'Career Point University', 'NULL', 27, 99, 'c:/certificate10050'),
(25, 1, 'Holy Child School Guwahati', 'NULL', 28, 86, 'c:/certificate10060');

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
(27, 23, 10),
(28, 23, 9),
(29, 23, 1),
(30, 24, 11),
(31, 24, 2),
(32, 24, 6),
(33, 24, 9),
(34, 24, 5),
(35, 24, 7),
(36, 24, 4),
(37, 24, 1),
(38, 24, 8),
(39, 25, 11),
(40, 25, 6),
(41, 25, 3),
(42, 25, 4),
(43, 25, 5),
(44, 25, 2),
(45, 25, 9),
(46, 25, 1),
(47, 25, 8),
(48, 26, 7),
(49, 26, 9),
(50, 26, 11),
(51, 26, 6),
(52, 26, 5),
(53, 26, 10),
(54, 26, 2),
(55, 26, 8),
(56, 26, 4),
(57, 26, 3),
(58, 26, 1),
(59, 27, 11),
(60, 27, 4),
(61, 27, 1),
(62, 27, 9),
(63, 27, 6),
(64, 28, 8),
(65, 28, 5);

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
(6, 'Buddism'),
(7, 'Open');

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
(25, 'Scholarship name', 0, 4),
(26, 'Scholarship name 2', 0, 2),
(27, 'Scholarship name3', 0, 1),
(28, 'Scholarship name', 0, 3),
(29, 'Neel Patel @0', 0, 2),
(30, 'Neel Patel @1', 0, 3),
(31, 'Barry @0', 0, 2),
(32, 'Barry @1', 0, 1),
(33, 'Barry @2', 0, 3),
(34, 'Barry @3', 0, 4),
(35, 'Barry @4', 0, 4),
(36, 'Barry @5', 0, 4),
(37, 'Barry @6', 0, 4),
(38, 'Barry @7', 0, 4),
(39, 'Barry @8', 0, 4),
(40, 'Bertha @0', 0, 1),
(41, 'Bertha @1', 0, 4),
(42, 'Bertha @2', 0, 3),
(43, 'Bill @0', 0, 2),
(44, 'Bill @1', 0, 1),
(45, 'Bill @2', 0, 4),
(46, 'Bill @3', 0, 4),
(47, 'Bill @4', 0, 3),
(48, 'Bonnie @0', 0, 2),
(49, 'Bonnie @1', 0, 4),
(50, 'Bonnie @2', 0, 4),
(51, 'Bonnie @3', 0, 3),
(52, 'Bret @0', 0, 4),
(53, 'Bret @1', 0, 2),
(54, 'Bret @2', 0, 3),
(55, 'Bret @3', 0, 1);

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
(18, 'Pratik Panchal', NULL);

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
(22, '', NULL, NULL, 15),
(23, 'Values in India (PAIRVI)', NULL, NULL, 3),
(24, 'Oxfam India', NULL, NULL, 19),
(25, 'Indian National Trade Union Congress', NULL, NULL, 12),
(26, 'Youth for Unity', NULL, NULL, 23),
(27, 'Wada Na Todo Abhiyan (WNTA)', NULL, NULL, 7);

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
(16, 'Neel Patel @0', 22, '2020-01-01 00:00:00', 'https://www.neelpatel0.com/', 29, 1, NULL, 40),
(17, 'Neel Patel @1', 22, '2020-01-01 00:00:00', 'https://www.neelpatel1.com/', 30, 1, NULL, 41),
(18, 'Barry @0', 23, '2020-01-01 00:00:00', 'https://www.barry0.com/', 31, 1, NULL, 42),
(19, 'Barry @1', 23, '2020-01-01 00:00:00', 'https://www.barry1.com/', 32, 1, NULL, 43),
(20, 'Barry @2', 23, '2020-01-01 00:00:00', 'https://www.barry2.com/', 33, 1, NULL, 44),
(21, 'Barry @3', 23, '2020-01-01 00:00:00', 'https://www.barry3.com/', 34, 1, NULL, 45),
(22, 'Barry @4', 23, '2020-01-01 00:00:00', 'https://www.barry4.com/', 35, 1, NULL, 46),
(23, 'Barry @5', 23, '2020-01-01 00:00:00', 'https://www.barry5.com/', 36, 1, NULL, 47),
(24, 'Barry @6', 23, '2020-01-01 00:00:00', 'https://www.barry6.com/', 37, 1, NULL, 48),
(25, 'Barry @7', 23, '2020-01-01 00:00:00', 'https://www.barry7.com/', 38, 1, NULL, 49),
(26, 'Barry @8', 23, '2020-01-01 00:00:00', 'https://www.barry8.com/', 39, 1, NULL, 50),
(27, 'Bertha @0', 24, '2020-01-01 00:00:00', 'https://www.bertha0.com/', 40, 1, NULL, 51),
(28, 'Bertha @1', 24, '2020-01-01 00:00:00', 'https://www.bertha1.com/', 41, 1, NULL, 52),
(29, 'Bertha @2', 24, '2020-01-01 00:00:00', 'https://www.bertha2.com/', 42, 1, NULL, 53),
(30, 'Bill @0', 25, '2020-01-01 00:00:00', 'https://www.bill0.com/', 43, 1, NULL, 54),
(31, 'Bill @1', 25, '2020-01-01 00:00:00', 'https://www.bill1.com/', 44, 1, NULL, 55),
(32, 'Bill @2', 25, '2020-01-01 00:00:00', 'https://www.bill2.com/', 45, 1, NULL, 56),
(33, 'Bill @3', 25, '2020-01-01 00:00:00', 'https://www.bill3.com/', 46, 1, NULL, 57),
(34, 'Bill @4', 25, '2020-01-01 00:00:00', 'https://www.bill4.com/', 47, 1, NULL, 58),
(35, 'Bonnie @0', 26, '2020-01-01 00:00:00', 'https://www.bonnie0.com/', 48, 1, NULL, 59),
(36, 'Bonnie @1', 26, '2020-01-01 00:00:00', 'https://www.bonnie1.com/', 49, 1, NULL, 60),
(37, 'Bonnie @2', 26, '2020-01-01 00:00:00', 'https://www.bonnie2.com/', 50, 1, NULL, 61),
(38, 'Bonnie @3', 26, '2020-01-01 00:00:00', 'https://www.bonnie3.com/', 51, 1, NULL, 62),
(39, 'Bret @0', 27, '2020-01-01 00:00:00', 'https://www.bret0.com/', 52, 1, NULL, 63),
(40, 'Bret @1', 27, '2020-01-01 00:00:00', 'https://www.bret1.com/', 53, 1, NULL, 64),
(41, 'Bret @2', 27, '2020-01-01 00:00:00', 'https://www.bret2.com/', 54, 1, NULL, 65),
(42, 'Bret @3', 27, '2020-01-01 00:00:00', 'https://www.bret3.com/', 55, 1, NULL, 66);

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
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_profile`
--

INSERT INTO `student_profile` (`student_id`, `name`, `gender`, `age`, `physical_disability`, `course`, `total_hobbies`, `total_skills`, `adhar_number`, `city`, `caste`, `caste_certificate`, `resume_path`, `annual_income`, `income_certificte_path`, `dob`, `status`) VALUES
(23, 'Prem Bhajaj', 'Female', 15, NULL, 8, NULL, NULL, '909930022832', 20, 4, NULL, 'c:/resume1001', 854049, 'c:/income1001', '1994-08-28', 1),
(24, 'Allison', 'Male', 28, NULL, 9, NULL, NULL, '925917147404', 23, 2, NULL, 'c:/resume1002', 650736, 'c:/income1002', '2001-03-27', 1),
(25, 'Arthur', 'Female', 22, NULL, 2, NULL, NULL, '734726144245', 18, 5, NULL, 'c:/resume1003', 400420, 'c:/income1003', '2001-08-09', 1),
(26, 'Ana', 'Male', 24, NULL, 8, NULL, NULL, '965864334272', 18, 1, NULL, 'c:/resume1004', 920129, 'c:/income1004', '2001-01-28', 1),
(27, 'Alex', 'Female', 16, NULL, 5, NULL, NULL, '754828832282', 24, 4, NULL, 'c:/resume1005', 323977, 'c:/income1005', '1995-07-13', 1),
(28, 'Arlene', 'Male', 20, NULL, 9, NULL, NULL, '436067890220', 20, 5, NULL, 'c:/resume1006', 497210, 'c:/income1006', '1999-10-15', 1);

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
-- AUTO_INCREMENT for table `map_hobby`
--
ALTER TABLE `map_hobby`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `map_qualifications`
--
ALTER TABLE `map_qualifications`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `map_scholarships`
--
ALTER TABLE `map_scholarships`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `map_skills`
--
ALTER TABLE `map_skills`
  MODIFY `self_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `master_caste`
--
ALTER TABLE `master_caste`
  MODIFY `caste_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `master_city`
--
ALTER TABLE `master_city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
  MODIFY `scholarship_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

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
  MODIFY `operator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `organization_profile`
--
ALTER TABLE `organization_profile`
  MODIFY `organization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `scholarship_table`
--
ALTER TABLE `scholarship_table`
  MODIFY `scholarship_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `student_profile`
--
ALTER TABLE `student_profile`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

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
