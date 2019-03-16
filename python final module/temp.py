import connect_mysql

# o = getDBCursor("get_skills")
o = connect_mysql.getDBCursor("get_eligible_scholarships",("pratiksp",))
# o = connect_mysql.getDBCursor("credential_check",("pratiksp","12345",))

print(o)