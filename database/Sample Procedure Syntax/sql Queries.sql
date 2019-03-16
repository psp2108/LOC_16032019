#-------------------------------------------
#DATABASE :: railwayconcession 
#--------------------------------------------

#    CREATION OF STUDENT PROFILE TABLE
	
create table Student_Profile(
sap_id varchar(12) NOT NULL,
student_name varchar(255) NOT NULL,
student_password varchar(255) NOT NULL,
email varchar(255) NOT NULL,
hometown varchar(255) NOT NULL,
department varchar(255) NOT NULL,
PRIMARY KEY(sap_id)
);

#-----------------------------------------------
#	CREATION OF railwayconcession table

create table rail_concess(
sap_id varchar(12) NOT NULL,
rc_id int NOT NULL AUTO_INCREMENT,
request_date date,
class_type int,
approved_from date,
approved_till date,
application_status int DEFAULT 0,
PRIMARY KEY(rc_id),
FOREIGN KEY (sap_id) REFERENCES student_profile(sap_id)
);


#---------------
# Procedures

######################################

DELIMITER //
CREATE OR REPLACE PROCEDURE `credential_check`(
IN sap_id_ip varchar(12),
IN student_password_ip varchar(255)
)

BEGIN

    IF(select * from student_profile where 
       sap_id=sap_id_ip AND student_password=student_password_ip) THEN 
    
    	SELECT "true";
    ELSE
    	SELECT "false";
    END IF;

END //

########################

DELIMITER //
CREATE OR REPLACE PROCEDURE `status_change`(
IN rc_id_ip int,
IN status_ip int    
)

BEGIN

	IF(status_ip = -1) THEN
		UPDATE rail_concess 
        SET 
        application_status = -1,
        approved_from = now(),
        approved_till = DATE_ADD(now(), INTERVAL 3 MONTH)
        
        WHERE rc_id = rc_id_ip;
    ELSE
		UPDATE rail_concess
        SET 
        application_status = status_ip,
        approved_from = now(),
        approved_till = DATE_ADD(now(), INTERVAL 3 MONTH)
        WHERE rc_id = rc_id_ip;
    END IF; 
    

	select "true";

END //

##################################

DELIMITER //
CREATE OR REPLACE PROCEDURE `show_app_status`(
IN sap_id_ip varchar(12)
)

BEGIN
	
    DECLARE ROW_COUNT INT;
	
    SET ROW_COUNT = (
        SELECT COUNT(*) from rail_concess, student_profile
    	WHERE
    	Student_Profile.sap_id = rail_concess.sap_id AND
    	rail_concess.sap_id = sap_id_ip
    	order by rc_id DESC
    	limit 1
    );
	
    IF (ROW_COUNT <> 0) THEN
    	select 
        student_name, rail_concess.sap_id, "Ville Parle", hometown, 
        email, department, class_type, application_status
        from rail_concess, student_profile
        WHERE
        Student_Profile.sap_id = rail_concess.sap_id AND
        rail_concess.sap_id = sap_id_ip
        order by rc_id DESC
        limit 1;
    ELSE
    	SELECT "false";
    END IF;

END //


############################################

DELIMITER //
CREATE OR REPLACE PROCEDURE `request_application`(
IN sap_id_ip varchar(12),
IN class_type_ip int
)

BEGIN

DECLARE is_pending int;
DECLARE is_accepted int;
DECLARE is_rejected int;
DECLARE curr_date date;
DECLARE last_date date;
DECLARE number_of_days int;




SET is_pending = (SELECT COUNT(*) from rail_concess where sap_id = sap_id_ip and application_status = 0);

SET is_accepted = (SELECT COUNT(*) from rail_concess where sap_id = sap_id_ip and application_status = 1);

SET is_rejected = (SELECT COUNT(*) from rail_concess where sap_id = sap_id_ip and application_status = -1);

set curr_date = (select now());

	if(is_accepted > 0 OR is_rejected > 0) THEN
		set last_date = (select approved_till from rail_concess where sap_id = sap_id_ip 
                         and application_status = 1
                         order by approved_till desc
                         limit 1);
                         
        set number_of_days = (select datediff(last_date, curr_date));
	else 
    	set number_of_days = (0);
    end if;
     
     
if(is_pending > 0) THEN
	select "Your request is already waiting for approval!";
else
	if(number_of_days <= 15) THEN
    	
        INSERT INTO rail_concess 
        (sap_id,request_date,class_type) VALUES
        (sap_id_ip,now(),class_type_ip);
        
    	select "Request accepted and waiting for approval";
    ELSE
    	select "Request accepted only 15 days prior to last date";
    end if;
end if;
END //