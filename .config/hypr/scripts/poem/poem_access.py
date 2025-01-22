"""
诗词访问
2025.1.22 by dralee
"""
from sqlite3_db import SqliteAccessor
from model import AuthorModel,PoemModel,ParagraphModel,NoteModel,PoemRecordModel

class PoemDBAccessor(SqliteAccessor):
    """诗歌数据库访问"""
    def __init__(self, db_path):
        super().__init__(db_path)

    def create_poem_record(self, record:PoemRecordModel):
        """创建诗词显示记录, id for success """
        sql = "INSERT INTO poem_record (poem_id,category_id,author_id) VALUES ({},{},{})"\
            .format(record.poem_id, record.category_id, record.author_id)        
        #print(sql)
        _,id = self.execute(sql)
        return id
    
    def exist_author(self, name, dynasty):
        """判断作者是否存在"""
        items = self.query("SELECT id FROM author WHERE name='{}' AND dynasty='{}' LIMIT 1".format(name, dynasty))
        return items is not None and len(items) > 0
    
    def get_poem_not_show_by_category(self, category_id):
        """查询未显示的诗词根据分类查询"""
        sql = "SELECT poem_id FROM poem_record"
        ids = self.query(sql)
        ids_exists = []
        if ids is not None and len(ids) > 0:
            ids_exists = [str(id[0]) for id in ids]
        sql = "SELECT id FROM poem WHERE category_id={} AND id NOT IN\
             ({}) ORDER BY RANDOM() LIMIT 1".format(category_id,','.join(ids_exists))
        #print(sql, ids_exists, ids)
        item = self.query_one(sql)
        if item is None:
            return None
        p = self.get_poem(item[0])
        if p is None:
            return None
        self.create_poem_record(PoemRecordModel(p.id,category_id,p.author_id))
        return p
    
    def reset_poem_record(self):
        """重置诗词显示记录"""
        sql = "SELECT COUNT(1) FROM poem p WHERE NOT EXISTS(SELECT poem_id FROM poem_record WHERE poem_id=p.id)"
        count = self.query_one(sql)
        if count is None:            
            return
        if count[0] > 0:
            #print("存在未显示的诗词记录")
            return
        #print("可显示诗词已为空,重置诗词显示记录")
        sql = "DELETE FROM poem_record"
        self.execute(sql)
    
    def get_poem(self, poem_id):
        """查询诗词"""
        sql = """SELECT p.id,p.title,p.author_id, a.name author,p.rhythmic,p.category_id,
          c.name category,p.content_type,a.dynasty
FROM author a INNER JOIN poem p ON a.id=p.author_id
INNER JOIN poem_category c ON c.id=p.category_id WHERE p.id={}""".format(poem_id)
        #print(sql)
        item = self.query_one(sql)
        if item is None:
            return None
        ps = self.get_pragraphs(poem_id)
        ns = self.get_nodes(poem_id)
        poem = PoemModel(int(item[0]),item[1],int(item[2]),item[3],item[4],int(item[5]),item[6],int(item[7]),item[8],ps,ns)
        return poem
        
    def get_author(self, name, dynasty):
        """查询作者"""
        sql = "SELECT * FROM author WHERE name='{}' AND dynasty='{}'".format(name, dynasty)
        #print(sql)
        items = self.query(sql)
        print('items:',items)
        if items is None or len(items) == 0:
            return None
        item = items[0]
        return AuthorModel(int(item[0]),item[1],item[2],item[3],item[4])
    
    def get_pragraphs(self, poem_id):
        """查询段落"""
        items = self.query("SELECT id,content,sort FROM poem_paragraph WHERE poem_id='{}' ORDER BY sort".format(poem_id))
        if items is None or len(items) == 0:
            return None
        result = []
        for item in items:        
            result.append(ParagraphModel(item[0],item[1],item[2]))
        return result
    
    def get_nodes(self, poem_id):
        """查询注释"""
        items = self.query("SELECT id,content,sort FROM poem_note WHERE poem_id='{}' ORDER BY sort".format(poem_id))
        if items is None or len(items) == 0:
            return None
        result = []
        for item in items:        
            result.append(NoteModel(item[0],item[1],item[2]))
        return result
