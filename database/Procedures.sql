##Login Table

####### CHECK CREDENTIALS #########
DELIMITER //
CREATE OR REPLACE PROCEDURE credential_check(
IN _uid varchar(12),
IN _pwd varchar(50)
)

BEGIN
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

END //

#call credential_check("pratiksp","12345")

#########################################

####### REGISTER USER #########

DELIMITER //
CREATE OR REPLACE PROCEDURE register_user(
IN _uid varchar(12),
IN _pwd varchar(50),
IN email varchar(500),
IN phone varchar(10),
IN _name varchar(400),
IN type int
)

BEGIN

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

END //


#call register_user("premb","1234","prembhajaj@gmail.com","8104461845", "Prem Bhajaj","2");

#########################################

####### UPDATE LOGIN DETAILS #########
DELIMITER //
CREATE OR REPLACE PROCEDURE change_login_detail(
IN _uid varchar(12),
IN old_pwd varchar(50),
IN _pwd varchar(50),
IN _email varchar(500),
IN _phone varchar(10)
)

BEGIN
    DECLARE PWD varchar(50);

    set PWD = (select password from login_table where user_id = _uid);

    if (PWD = old_pwd) THEN
        update login_table set 
        password = _pwd,
        email = email,
        phone_no = _phone
        where user_id = _uid;

        select "User Updated";
    ELSE
        select "Password Mismatched";
    end if;

END //

#call change_login_detail("pratiksp","1234","12345","prembhajaj@gmail.com","8104461845");

#########################################

####### GET USER SENSETIVE DATA #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_sensetive_data(
IN _uid varchar(12)
)

BEGIN
    select user_id, email, phone_no from login_table where user_id = _uid;
END //

#call get_sensetive_data("pratiksp");

############################################################################################################
## Student

####### UPDATE STUDENT PROFILE #########

DELIMITER //
CREATE OR REPLACE PROCEDURE update_student(
IN _uid varchar(12),
IN _name varchar(400),
IN _age int,
IN _gender varchar(10),
IN _physical_disability varchar(1000),
IN _course int,
IN _adhar_card varchar(12),
IN _city int,
IN _caste int,
IN _caste_certificate varchar(1000),
IN _resume_path varchar(1000),
IN _income_certificate varchar(1000),
IN _annual_income double,
IN _dob datetime
)

BEGIN

	DECLARE student_id int;
    
    set student_id = (select student_user from login_table where user_id = _uid);
    
    if (student_id is not NULL) and (student_id > 0) then
    	
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
     ELSE
     	select "False";
     end if;

END //

#call update_student("pratiksp","Pratik Panchal","10","Male",NULL,4,"998877665544",2,2,"C:/Caste Certificate","C/Resume","C:/Income Certificate",500000,"1998-08-21");

####### ADD QUALIFICATION ###########
DELIMITER //
CREATE OR REPLACE PROCEDURE add_qualification(
    IN _uid varchar(12),
    IN _qualification int,
    IN institute varchar(1000),
    IN other_achievement varchar(1000),
    IN score int,
    IN certificate varchar(1000)
)

BEGIN

	DECLARE student_id int;
    
    set student_id = (select student_user from login_table where user_id = _uid);

	INSERT INTO map_qualifications (qualification_id, institute_or_name, other_achievement, student_id, total_score, certificate_path) VALUES (_qualification,institute,other_achievement,student_id,score,certificate);
    
    
END //
#call add_qualification(_uid,_qualification,institute,other_achievement,score,_certificate)

####### ADD STUDENT HOBBIES #########

DELIMITER //
CREATE OR REPLACE PROCEDURE add_hobby(
IN _uid varchar(12),
IN hobbyID int
)

BEGIN

	DECLARE student_id int;
    DECLARE count int;

    set student_id = (select student_user from login_table where user_id = _uid);
    set count = (select count(*) from map_hobby where map_hobby.student_id = student_id and map_hobby.hobby_id = hobbyID);

    if count = 0 THEN
        insert into map_hobby (map_hobby.student_id, map_hobby.hobby_id) values (student_id, hobbyID);
    end if;


END //

#call add_hobby("pratiksp",1);

####### ADD STUDENT SKILLS #########

DELIMITER //
CREATE OR REPLACE PROCEDURE add_skills(
IN _uid varchar(12),
IN SkillID int
)

BEGIN

	DECLARE student_id int;
    DECLARE count int;

    set student_id = (select student_user from login_table where user_id = _uid);
    set count = (select count(*) from map_skills where map_skills.student_id = student_id and map_skills.skill_id = SkillID);

    if count = 0 THEN
        insert into map_skills (map_skills.student_id, map_skills.skill_id) values (student_id, SkillID);
    end if;


END //

#call add_skills("pratiksp",1);

####### GET ELIGIBLE SCHOLARSHIPS #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_eligible_scholarships(
IN _uid varchar(12)
)

BEGIN
	DECLARE student_id int;
	DECLARE income double;
    
    
    set student_id = (select student_user from login_table where user_id = _uid);

    #1 Financial (get from stud table)
    #2 Backward (get from stud table)
    #3 Academics (get from stud table and map_qualification with qualifications)
    #4 Others (map_events)
    
    select 
    	master_scholarship.scholarship_id,
    	organization_profile.name,
        master_sc_category.categories,
        master_scholarship.scholarships,
        scholarship_table.url_site,
        scholarship_table.last_date_to_apply
        -- scho
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
   # master_scholarship.scholarship_id = scholarship_table.scholarship
    
    group by eligibility_criteria.criteria_id;
	
END //

#call get_eligible_scholarships("pratiksp");


############################################################################################################
## Organization

####### UPDATE Organization PROFILE #########

DELIMITER //
CREATE OR REPLACE PROCEDURE update_organizer(
IN _uid varchar(12),
IN _name varchar(1000),
IN _city int
)

BEGIN

	DECLARE organization_id int;
    
    set organization_id = (select organizer_user from login_table where user_id = _uid);
    
    update organization_profile set
    name = _name,
    city = _city
    where organization_profile.organization_id = organization_id;

END //

#call update_organizer("pratiksp","Organization Name",4);

############################################################################################################
## Operator

####### UPDATE Operator PROFILE #########

DELIMITER //
CREATE OR REPLACE PROCEDURE update_operator(
IN _uid varchar(12),
IN _name varchar(1000),
IN _city int
)

BEGIN

	DECLARE operator_id int;
    
    set operator_id = (select operator_user from login_table where user_id = _uid);
    
    update operator_profile set
    name = _name,
    city = _city
    where operator_profile.operator_id = operator_id;

END //

#call update_operator("pratiksp","Operator Name",4);
## Operator

####### UPDATE SCHOLARSHIP DETAILS #########

DELIMITER //
CREATE OR REPLACE PROCEDURE update_scholarship_details(
    IN _uid varchar(12),
    IN categoryID int,
    IN scholarship_name varchar(1000),
    IN last_date datetime,
    IN _url varchar(1000),
    IN _annual_income double,
    IN casteID int,
    IN eventID int,
    IN qualificationID int,
    IN _qualification_score int,
    IN courseID int
)

BEGIN

    DECLARE _scholarship_id int;
    DECLARE _eligibility_id int;
	DECLARE organization_id int;
    
    set organization_id = (select organizer_user from login_table where user_id = _uid);
    
    insert into master_scholarship (scholarships, category) values (scholarship_name,categoryID);
    set _scholarship_id = (select scholarship_id from master_scholarship order by scholarship_id desc limit 1);

    if categoryID=1 THEN 
    	insert into eligibility_criteria (annual_income,organization,scholarship) values 
        (_annual_income, organization_id, _scholarship_id);
        #select "1";
    end if;
    if categoryID=2 THEN 
    	insert into eligibility_criteria (caste,organization,scholarship) values 
        (casteID, organization_id, _scholarship_id);
        #select "2";
    end if;
    if categoryID=3 THEN 
    	insert into eligibility_criteria (events,organization,scholarship) values 
        (eventID, organization_id, _scholarship_id);
        #select "3";
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
        
        #select "4";
    end if;
	
    set _eligibility_id = (select criteria_id from eligibility_criteria order by criteria_id desc limit 1);
    
    insert into scholarship_table (name,organization,last_date_to_apply,url_site,scholarship,eligibility) 
    values (scholarship_name,organization_id,last_date,_url,_scholarship_id,_eligibility_id);
    

END //

#call update_scholarship_details("org1",4,"Scholarship name","2020-01-01","https://www.url.com/",500000,3,2,-1,90,4);

############################################################################################################
## Masters

####### GET CASTE #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_caste()

BEGIN

	select * from master_caste;

END //

#call get_caste()

####### GET CITIES #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_city()

BEGIN

	select * from master_city;

END //

#call get_city()

####### GET COURSE #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_course()

BEGIN

	select course_id, CONCAT(main_course, " - ", sub_course, " (year ", course_year, ")") from master_course;

END //

#call get_course()

####### GET EVENT #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_event()

BEGIN

	select * from master_event;

END //

#call get_event()

####### GET HOBBY #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_hobby()

BEGIN

	select * from master_hobby;

END //

#call get_hobby()

####### GET QUALIFICATION #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_qualification()

BEGIN

	SELECT * FROM master_qualification;

END //

#call get_qualification()

####### GET SCHOLARSHIP CATEGORY #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_scholarship_category()

BEGIN

	SELECT * FROM master_sc_category;

END //

#call get_scholarship_category()

####### GET SKILLS #########

DELIMITER //
CREATE OR REPLACE PROCEDURE get_skills()

BEGIN

	SELECT * FROM master_skill;

END //

#call get_skills()

##############################################################################

###  INSPECT STUDENTS #####

DELIMITER //
CREATE OR REPLACE PROCEDURE inspect_student(
IN id int,
IN _status int
)

BEGIN

	update student_profile set status = _status where student_id = id;
    select "True";

END //

#call inspect_student(3,2);


###  INSPECT SCHOLARSHIPS #####

DELIMITER //
CREATE OR REPLACE PROCEDURE inspect_scholarship(
IN id int,
IN _status int
)

BEGIN

	update scholarship_table set status = _status where scholarship_id = id;
    select "True";

END //

#call inspect_scholarship(12,3)

####################################################

##### VIEW SCHOLARSHIP

DELIMITER //
CREATE OR REPLACE PROCEDURE view_scholarships(
IN org_id int
)

BEGIN
	
    if (select count(*) from scholarship_table where scholarship_table.organization = org_id) > 0 then
        select scholarship_table.name, scholarship_table.url_site from 
        organization_profile, scholarship_table where 
        scholarship_table.organization = organization_profile.organization_id AND
        organization_profile.organization_id = org_id;
    ELSE
    	select "";
    end if;

END //

#call view_scholarships(5)

##### GET SCHOLARSHIP

DELIMITER //
CREATE OR REPLACE PROCEDURE get_scholarship(
IN sch_id int
)

BEGIN


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
        #eligibility_criteria.scholarship = scholarship_table.scholarship_id AND
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
        #eligibility_criteria.scholarship = scholarship_table.scholarship_id AND
        eligibility_criteria.events = master_event.event_id AND
        eligibility_criteria.events != 0 AND
        eligibility_criteria.events is not NULL and
        scholarship_table.scholarship_id = sch_id;
  
  end if;

END //

#call get_scholarship(14);


####################################################

##### GET ELIGIBLE STUDENTS

DELIMITER //
CREATE OR REPLACE PROCEDURE get_eligible(
IN sch_id int
)

BEGIN

END //

#call get_eligible(14);




###################################################################################################################################
################# GET ELIGIBLE STUDENTS ###################### 

DELIMITER //
CREATE OR REPLACE PROCEDURE get_eligible_students(
IN _oid varchar(12)
)

BEGIN
	DECLARE organizer_id int;
	# DECLARE income double;
    
    
    set organizer_id = (select organizer_user from login_table where user_id = _oid);

    #1 Financial (get from stud table)
    #2 Backward (get from stud table)
    #3 Academics (get from stud table and map_qualification with qualifications)
    #4 Others (map_events)
    
    select 
    /*
    	master_scholarship.scholarship_id,
    	organization_profile.name,
        master_sc_category.categories,
        master_scholarship.scholarships,
        scholarship_table.url_site,
        scholarship_table.last_date_to_apply
    */
        student_profile.student_id,
        student_profile.name,
        student_profile.status,
        login_table.user_id

    from 
    eligibility_criteria,master_scholarship,organization_profile,student_profile,
    master_qualification,map_qualifications, master_sc_category, scholarship_table, login_table
    WHERE
        -- organization_profile.organization_id = organizer_id and

        -- scholarship_table.organization = organization_profile.organizer_id and
        -- scholarship_table.eligibility = eligibility_criteria.criteria_id and

        -- (
        --     (
        --         student_profile.caste = eligibility_criteria.caste and 
        --         eligibility_criteria.caste is not NULL and 
        --         eligibility_criteria.caste != 0 
        --     ) or
        --     (
        --         student_profile.annual_income <= eligibility_criteria.annual_income and 
        --         eligibility_criteria.annual_income is not NULL and
        --         eligibility_criteria.annual_income != 0
        --     ) or
        --     (
        --         eligibility_criteria.upcomming_course = student_profile.course and 
        --         eligibility_criteria.upcomming_course is not NULL and 
        --         eligibility_criteria.upcomming_course != 0 
        --     ) or
        --     (
        --         student_profile.student_id = map_qualifications.student_id and
        --         eligibility_criteria.qualification = map_qualifications.qualification_id and
        --         eligibility_criteria.qualification is not NULL and 
        --         eligibility_criteria.qualification != 0 and

        --         eligibility_criteria.qualification_score <= map_qualifications.total_score and
        --         eligibility_criteria.qualification_score is not NULL and 
        --         eligibility_criteria.qualification_score != 0 
        --     )
        -- )



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
    
   # student_profile.student_id = student_id and
    organization_profile.organization_id = organizer_id and
    eligibility_criteria.scholarship = master_scholarship.scholarship_id AND
    eligibility_criteria.organization = organization_profile.organization_id AND
    master_scholarship.category = master_sc_category.category_id and
    login_table.student_user = student_profile.student_id
   # master_scholarship.scholarship_id = scholarship_table.scholarship
    
    group by eligibility_criteria.criteria_id;
	
END //

#call get_eligible_students("org_1012");