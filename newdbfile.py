import sqlite3
import time
import psutil

#ram = psutil.virtual_memory()
#disk = psutil.disk_usage('/')

conn=sqlite3.connect('new1.db')
c=conn.cursor()

def create_table():
    c.execute("CREATE TABLE IF NOT EXISTS sysdetails(datetime TEXT, rampercent REAL, cpu1percent REAL)")


def data_entry():
    c.execute("INSERT INTO sysdetails VALUES('0',0,0)")
    conn.commit()

def dynamic_data_entry():
    datetime=str(time.ctime())

    ram1 = psutil.virtual_memory()
    rampercent=ram1.percent

    cpupercent=psutil.cpu_percent()
    #print(cpupercent)

    c.execute("INSERT INTO sysdetails(datetime,rampercent,cpu1percent) VALUES(?,?,?)",(datetime,rampercent,cpupercent))
    conn.commit()
    return rampercent, cpupercent
starttime=time.time()
create_table()
#data_entry()
while True:
  ram = psutil.virtual_memory()
  ram,cpu= dynamic_data_entry()
  print (time.ctime(), ram,cpu )

  #time.sleep(5.0 - ((time.time() - starttime) % 5.0))
  time.sleep(5.0)




c.close()
conn.close()