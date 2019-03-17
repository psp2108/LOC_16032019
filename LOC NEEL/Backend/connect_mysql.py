import config_file
import mysql.connector

def getDBCursor(proc, param_tup=None):
    db = mysql.connector.connect(host=config_file.hostname, 
        user=config_file.username, 
        password=config_file.pwd, 
        database=config_file.database)

    cursor = db.cursor()
    
    if param_tup != None:
        args = cursor.callproc(proc,param_tup)
    else:
        args = cursor.callproc(proc)

    db.commit()

    z = []

    for result in cursor.stored_results():
        result = result.fetchall()
        z.append(result)

    return z[0]