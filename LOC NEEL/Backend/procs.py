import connect_mysql

def check_credentials(un,pw):

    o = connect_mysql.getDBCursor("credential_check",(un,pw))
    print(o)
    d={}
    d["userID"] = un

    if (o[0][0] == 'false'):
        d["type"] = ''
        d["status"] = False
    else:
        d["type"] = o[0][1]
        d["status"] = True

    return d

def register_student(data):
    data.pop('gender')

    tup = (data['un'],data['pw'],data['email'],data['phone'],data['name'],data['typeName'],)

    o = connect_mysql.getDBCursor("register_user",tup)
    print(o)

    dbRequest = {}
    dbRequest["status"] = True
    dbRequest["uid"] = data["un"]
    dbRequest["name"] = data["name"]
    dbRequest["typeName"] = data["typeName"]
    dbRequest["email"] = data["email"]
    dbRequest["phone"] = data["phone"]
    dbRequest["pw"] = data["pw"]
    
    return dbRequest

def get_eligible_scholarships(uid):
    print("Calling Get Scholarship Procedure")
    o = connect_mysql.getDBCursor("get_eligible_scholarships",(uid,))

    # d = {}
	# master_scholarship.scholarship_id,
    # 	organization_profile.name,
    #     master_sc_category.categories,
    #     master_scholarship.scholarships,
    #     scholarship_table.url_site,
    #     scholarship_table.last_date_to_apply

    l = []
    for i in o:
        d = {}
        d['ID'] = i[0]
        d['Organization'] = i[1]
        d['Scholarship Category'] = i[2]
        d['Scholarship'] = i[3]
        d['URL'] = i[4]
        d['Last Date to Apply'] = str(i[5])
        l.append(d)

    print(l)
    return l

def createUpdateStudentProfile(data):
    l = []
    for i in data:
        l.append(data[i])
    
    print("Create update student profile")
    print(l)

    o = connect_mysql.getDBCursor("update_student",(l))
    return [{'Response':True}]

def inspect_scholership(id,status):

    o = connect_mysql.getDBCursor("inspect_scholarship",(id,status))
    print(o)
    
    dbResponse = {}
    dbResponse["sid"] = id
    dbResponse["v_status"] = status
    return dbResponse

def inspect_students(id,status):

    o = connect_mysql.getDBCursor("inspect_student",(id,status))
    print(o)
    
    dbResponse = {}
    dbResponse["sid"] = id
    dbResponse["v_status"] = status
    return dbResponse

def get_scholarship_category():
    l = []
    o = connect_mysql.getDBCursor("get_scholarship_category")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['Scholarship Category'] = i[1]
        l.append(d)
    
    return l

def get_qualification():
    l = []
    o = connect_mysql.getDBCursor("get_qualification")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['Qualification'] = i[1]
        l.append(d)
    
    return l

def get_hobby():
    l = []
    o = connect_mysql.getDBCursor("get_hobby")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['Hobby'] = i[1]
        l.append(d)
    
    return l

def get_skills():
    l = []
    o = connect_mysql.getDBCursor("get_skills")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['Skills'] = i[1]
        l.append(d)
    
    return l

def get_event():
    l = []
    o = connect_mysql.getDBCursor("get_event")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['Event'] = i[1]
        l.append(d)
    
    return l

def get_course():
    l = []
    o = connect_mysql.getDBCursor("get_course")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['Course'] = i[1]
        l.append(d)
    
    return l

def get_city():
    l = []
    o = connect_mysql.getDBCursor("get_city")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['City'] = i[1]
        l.append(d)
    
    return l

def get_caste():
    l = []
    o = connect_mysql.getDBCursor("get_caste")
    #print(o)
    for i in o:
        d = {}
        d['id'] = i[0]
        d['Caste'] = i[1]
        l.append(d)
    
    return l