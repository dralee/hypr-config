"""
诗词显示
2025.1.22 by dralee
2025.7.7 by dralee monitors sync for show same poem
"""
import json
from os.path import getatime,exists,expanduser
import time
from .poem_access import PoemDBAccessor
from .model import PoemModel

class PoemShow:
    def __init__(self):
        self.root = '{}/.config/waybar/scripts/poem'.format(expanduser('~'))
        self.db_name ='{}/poem.db'.format(self.root)
        self.db_accessor = PoemDBAccessor(self.db_name)
        self.image_path = '{}/poem.tk'.format(self.root)
        self.sync = '{}/.sync'.format(self.root)
        self.image_expires_s = 3600 # 1h

    def run(self, change_immediately=False):
        """随机产生指定分类的诗词，不重复
        change_immediately: 是否立即刷新
        """
        #print('change_immediately:',change_immediately)
        #print('exists:',exists(self.root))
        #p = self.db_accessor.get_poem(1)
        now = int(time.time())
        if not change_immediately and exists(self.image_path):
            atime = self.__last_sync() # int(getatime(self.image_path))
            if now - atime < self.image_expires_s:                
                p = self.__from_cache()
                #print('from cache', p)
                return self.to_waybar_tooltip(p)
        self.db_accessor.reset_poem_record()
        p = self.db_accessor.get_poem_not_show_by_category(11)
        self.__save(self.sync, str(now))
        self.__cache(p)        
        #print('cache it.')
        #print(p)
        return self.to_waybar_tooltip(p)
    
    def __last_sync(self):
        """上次同步时间"""
        v = self.__read(self.sync)
        if v is None:
            return 0
        return int(v)


    def __save(self, filename, content):
        """保存"""
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(content)

    def __read(self, filename):
        """读取"""
        if not exists(filename):
            return None
        with open(filename, 'r', encoding='utf-8') as f:
            return f.read()

    def __cache(self, p):
        """缓存"""
        content = json.dumps(p.to_dict(), ensure_ascii=False)
        self.__save(self.image_path, content)

    def __from_cache(self):
        """加载"""
        content = self.__read(self.image_path)
        if content is None:
            return None
        pstr = json.loads(content)
        return PoemModel.from_dict(pstr)        

    def to_waybar_tooltip(self, p:PoemModel):
        """转换为waybar的tooltip格式"""
        if p is None:
            return ""
        res = "<span>\n"
        res += '<span font_weight="bold" color="#FCC307" font_size="13pt">    {}</span>\n'.format(p.title)
        res += '<span color="#619AC3" font_size="8pt">         {}</span> (<span color="#ED5126" font_size="9pt">{}</span>)\n'.format(p.author, p.dynasty)
        for g in p.paragraphs:
            res += '<span color="#E0C8D1" font_size="12pt">{}</span>\n'.format(g.content)
        if p.notes is not None and len(p.notes) > 0:
            res += "\n"
            for n in p.notes:
                res += '<span color="#E0C8D1" font_size="10pt">{}</span>\n'.format(n.content)
        res += "</span>"
        #print('======>',res)
        return res

def main():
    ps = PoemShow()
    ps.run()

def test():
    sql = 'INSERT INTO poem_record(poem_id,category_id,author_id) VALUES'
    for i in range(250):
        sql += '({},11,1),'.format(i+1)
    sql = sql[:-1]
    print(sql)

def test1():
    a = getatime('poem.png')
    print(a)

if __name__ == '__main__':
    main()
    #test()
    #test1()
