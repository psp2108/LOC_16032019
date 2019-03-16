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

#########################################
