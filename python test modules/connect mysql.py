import mysql.connector

mydb = mysql.connector.connect(host="localhost", user="root", password="", database="railwayconcession")

mycursor = mydb.cursor()

mycursor.execute("SELECT * FROM student_profile")

for i in mycursor:
    print(i)