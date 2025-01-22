"""
sqlite3 数据库访问
2025.1.22 by dralee
"""
import sqlite3

class SqliteAccessor:
    """数据库访问"""
    def __init__(self, db_path):
        self.db_path = db_path
        self.now = "datetime('now','localtime')"

    def connect(self):
        """连接数据库"""
        #print("db is :", self.db_path)
        return sqlite3.connect(self.db_path)
    
    def execute(self, sql):
        """执行sql单语句
        返回:(rowcount, lastrowid)
        """
        conn = self.connect()
        c = conn.execute(sql)
        conn.commit()
        r = c.rowcount
        lastrowid = c.lastrowid
        conn.close()
        return (r, lastrowid)
    
    def execute_script(self, sql):
        """执行sql多条语句
        无返回
        """
        conn = self.connect()
        c = conn.executescript(sql)
        conn.commit()
        conn.close()

    def query(self, sql):
        """查询"""
        conn = self.connect()
        cursor = conn.cursor()
        cursor.execute(sql)
        result = cursor.fetchall()
        conn.close()
        return result

    def query_one(self, sql):
        """查询单行"""
        conn = self.connect()
        cursor = conn.cursor()
        cursor.execute(sql)
        result = cursor.fetchone()
        conn.close()
        return result

    def query_scripts(self, sql_scripts, sql_query):
        """查询
        sql_scripts: 多条sql语句
        sql_query: 查询作为结果返回的语句
        """
        conn = self.connect()
        cursor = conn.cursor()
        #print('sql script:', sql_scripts)
        cursor.executescript(sql_scripts)
        #print('sql query:', sql_query)
        c = cursor.execute(sql_query)
        result = c.fetchall()
        print('cursor:', c.rowcount)
        conn.close()
        return result
    