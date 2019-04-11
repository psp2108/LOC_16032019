#call register_user("premb","1234","prembhajaj@gmail.com","8104461845", "Prem Bhajaj","2");
import random

q = 'call register_user("{}","{}","{}","{}", "{}","{}");'
up = 'call update_student("{}","{}","{}","{}",{},{},"{}",{},{},"{}","{}","{}",{},"{}-{}-{}");'
qual= 'call add_qualification("{}","{}","{}","{}","{}","{}");'
uo = 'call update_organizer("{}","{}",{});'
hob = 'call add_hobby("{}",{});'
ski = 'call add_skills("{}",{});'
scho = 'call update_scholarship_details("{}",{},"{}","{}","https://www.{}.com/",{},{},{},{},{},{});'
name1 = ['','Allison','Arthur','Ana','Alex','Arlene']
name2 = ['','Barry','Bertha','Bill','Bonnie','Bret']
org1 = ['','Values in India (PAIRVI)','Oxfam India','Indian National Trade Union Congress','Youth for Unity','Wada Na Todo Abhiyan (WNTA)']
inst = ["St. Xavier's College of Education, Hindupur","St. John's High School, Amalapuram","Kendriya Vidyalaya, Khanapara","Don Bosco High School, Guwahati","Holy Child School Guwahati","Government Secondary School, Rani","Vijnana Vihara School, Nutakki","Banaras Hindu University","Career Point University","Dravidian University","IIHMR University","Integral University","Jawaharlal Nehru Technological University, Anantapur","Sri Guru Granth Sahib World University"]
g = True
###############################################################################################
a = 1000
b = q.format('o_' + str(a) ,a,'pratik.sp.1112@gmail.com','8879799396', 'Pratik Panchal',2)
print(b)
#print('#----')
###############################################################################################
#print('#====================')
###############################################################################################
# IN _uid varchar(12),
# IN _name varchar(400),
# IN _age int,
# IN _gender varchar(10),
# IN _physical_disability varchar(1000),
# IN _course int,
# IN _adhar_card varchar(12),
# IN _city int,
# IN _caste int,
# IN _caste_certificate varchar(1000),
# IN _resume_path varchar(1000),
# IN _income_certificate varchar(1000),
# IN _annual_income double,
# IN _dob datetime
# a += 1
# b = q.format('stud_' + str(a) ,a,'pk.panchal.526@gmail.com','7021513100', 'Prem Bhajaj',1)
# print(b)   

# b = up.format('stud_' + str(a),'Prem Bhajaj',20, 'Male', 'NULL', 2,random.randint(400000000000, 999999999999),1,3,'c:/caste'+str(a),'c:/resume'+str(a),'c:/income'+str(a),500000,1998,12,4)
# print(b)
#print('#----')
for k in name1:
    i = k
    a += 1
    if i == '':
        i = 'Prem Bhajaj'
        b = q.format('stud_' + str(a) ,a,'pk.panchal.526@gmail.com','7021513100', 'Prem Bhajaj',0)
    else:
        b = q.format('stud_' + str(a),a,i + "@email.com",random.randint(6000000000, 9999999999),i,0)
    print(b)

    if g:
        gender = 'Female'
    else:
        gender = 'Male'
    g = not g

    course = random.randint(1, 9)

    if i == '':
        b = up.format('stud_' + str(a),'Prem Bhajaj',20, 'Male', 'NULL', 2,random.randint(400000000000, 999999999999),1,3,'c:/caste'+str(a),'c:/resume'+str(a),'c:/income'+str(a),500000,1998,12,4)
    else:
        b = up.format('stud_' + str(a),i,random.randint(15, 30), gender, 'NULL', course,random.randint(400000000000, 999999999999),random.randint(1, 25),random.randint(1, 6),'c:/caste'+str(a),'c:/resume'+str(a),'c:/income'+str(a),random.randint(200000, 1000000),random.randint(1990, 2004),random.randint(1, 12),random.randint(1, 28))

    # b = up.format('stud_' + str(a),i,random.randint(15, 30), gender, 'NULL', 1,random.randint(400000000000, 999999999999),4,3,'c:/caste','c:/resume','c:/income',500000,random.randint(1980, 2004),random.randint(1, 12),random.randint(1, 28))
    print(b)

    counter = 0
    # call add_qualification(_uid,_qualification,institute,other_achievement,score,_certificate)
    b = qual.format('stud_' + str(a),1,inst[random.randint(0,len(inst)-1)],'NULL',random.randint(60,99),'c:/certificate'+str(a)+str(counter))
    counter += 1
    print(b)

    if course < 9:
        if course >= 5 and course <= 8:
            z = inst[random.randint(0,len(inst)-1)]
            qq = 6
            for x in range(5,course):
                b = qual.format('stud_' + str(a),qq,z,'NULL',random.randint(60,99),'c:/certificate'+str(a)+str(counter))
                counter += 1
                qq += 1
                print(b)
                b = qual.format('stud_' + str(a),qq,z,'NULL',random.randint(60,99),'c:/certificate'+str(a)+str(counter))
                counter += 1
                qq += 1
                print(b)

        if course >= 1 and course <= 4:
            z = inst[random.randint(0,len(inst)-1)]
            qq = 14
            for x in range(1,course):
                b = qual.format('stud_' + str(a),qq,z,'NULL',random.randint(60,99),'c:/certificate'+str(a)+str(counter))
                counter += 1
                qq += 1
                print(b)
                b = qual.format('stud_' + str(a),qq,z,'NULL',random.randint(60,99),'c:/certificate'+str(a)+str(counter))
                counter += 1
                qq += 1
                print(b)

        if course == 4:
            if (True if random.randint(0,0) == 1 else False):
                if (True if random.randint(0,0) == 1 else False):
                    b = qual.format('stud_' + str(a),4,z,'NULL',random.randint(60,100),'c:/certificate'+str(a)+str(counter))
                    counter += 1
                    print(b)
                else:
                    b = qual.format('stud_' + str(a),5,z,'NULL',random.randint(60,100),'c:/certificate'+str(a)+str(counter))
                    counter += 1
                    print(b)

    hobbies = random.randint(0,5)
    hh = []
    for zz in range(0, hobbies):
        h = random.randint(1,9)
        while h in hh:
            h = random.randint(1,9)
        hh.append(h)
        b = hob.format('stud_' + str(a), h)
        print(b)

    skills = random.randint(0,11)
    ss = []
    for zz in range(0, skills):
        s = random.randint(1,11)
        while s in ss:
            s = random.randint(1,11)
        ss.append(s)
        b = ski.format('stud_' + str(a), s)
        print(b)

    #print('#----')
###############################################################################################
#print('#====================')
###############################################################################################
# CREATE OR REPLACE PROCEDURE update_scholarship_details(
#     IN _uid varchar(12),
#     IN categoryID int,
#     IN scholarship_name varchar(1000),
#     IN last_date datetime,
#     IN _url varchar(1000),

#     IN _annual_income double,

#     IN casteID int,

#     IN eventID int,

#     IN qualificationID int,
#     IN _qualification_score int,
#################################
#     IN courseID int

    

# a += 1
# b = q.format('org_' + str(a) ,a,'neelpatel3039@gmail.com','8879366022', 'Neel Patel',0)
# print(b)
# b = uo.format('org_' + str(a),'NPs Organization',1)
# print(b)
#print('#----')
for k in range(len(name2)):
    i = name2[k]
    j = org1[k]
    a += 1
    if i == '':
        i = 'Neel Patel'
        b = q.format('org_' + str(a) ,a,'neelpatel3039@gmail.com','8879366022', 'Neel Patel',1)
    else:
        b = q.format('org_' + str(a),a,i + "@email.com",random.randint(6000000000, 9999999999),i,1)
    print(b)
    # call update_organizer("pratiksp","Organization Name",4);
    if i == '':
        b = uo.format('org_' + str(a),'NPs Organization',1)
    else:
        b = uo.format('org_' + str(a),j,random.randint(1, 25))
    print(b)

    category_list = []
    qualification_list = []

    scholarships = random.randint(0,10)
    for scholarship in range(scholarships):
        url = i.lower() + str(scholarship)
        url = url.replace(" ", "")
        url = url.replace("'", "")
        url = url.replace("(", "")
        url = url.replace(")", "")
        category = random.randint(1,4)
        if category != 4:
            while category in category_list:
                category = random.randint(1,4)
            if category != 4:
                category_list.append(category)

        if category == 1:
            b = scho.format('org_' + str(a),category,i+' @'+str(scholarship),'2020-01-01',url,random.randint(4,6) * 100000,-1,-1,-1,-1,-1)

        if category == 2:
            b = scho.format('org_' + str(a),category,i+' @'+str(scholarship),'2020-01-01',url,-1,random.randint(1,6),-1,-1,-1,-1)

        if category == 3:
            b = scho.format('org_' + str(a),category,i+' @'+str(scholarship),'2020-01-01',url,-1,-1,random.randint(1,8),-1,-1,-1)

        if category == 4:
            zz = random.randint(1,21)
            while zz in qualification_list:
                zz = random.randint(1,21)
            qualification_list.append(zz)
            b = scho.format('org_' + str(a),category,i+' @'+str(scholarship),'2020-01-01',url,-1,-1,-1,zz,random.randint(50,100),-1)

        print(b)

    #print('#----')
###############################################################################################