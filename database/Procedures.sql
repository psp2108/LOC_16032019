##Login Table

####### CHECK CREDENTIALS #########
DELIMITER //
CREATE OR REPLACE PROCEDURE credential_check(
IN _uid varchar(12),
IN _pwd varchar(50)
)

BEGIN

    IF(select count(*) from login_table where 
       user_id=_uid AND password=_pwd) > 0 THEN 
    
    	SELECT "true";
    ELSE
    	SELECT "false";
    END IF;

END //

#call credential_check("pratiksp","1234")

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
        
        update login_table set student_user = TYPE_ID;
    	SELECT "Student";
    ELSE 
        IF (type = 1) THEN
            insert into organization_profile (name) values (_name);

            set TYPE_ID = (select organization_id from organization_profile order by organization_id desc limit 1);

            #pdate login_table set organizer_user = TYPE_ID;

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

END //

#call update_student("pratiksp","Pratik Panchal","10","Male",NULL,4,"998877665544",2,2,"C:/Caste Certificate","C/Resume","C:/Income Certificate",500000,"1998-08-21");

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
