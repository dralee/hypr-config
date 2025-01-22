"""
保存模型
2025.1.20 by dralee
"""
from enum import Enum

class EnvType(Enum):
    """环境类型"""
    home=1
    work=2

class ContentType(Enum):
    """内容类型 0:整诗 1:摘句"""
    full = 0 # 整诗
    part = 1 # 摘句

class AuthorModel:
    """作者"""
    def __init__(self, id, name, dynasty, description, creation_time=None):
        self.id = id
        self.name = name
        self.dynasty = dynasty
        self.description = description
        self.creation_time = creation_time
    def __str__(self):
        return "id:{}, name:{}, dynasty:{}".format(self.id, self.name, self.dynasty)

class ParagraphModel:
    """段落"""
    def __init__(self, id, content, sort):
        self.id = id
        self.content = content
        self.sort = sort

    def __str__(self):
        return "<id:{}, content:{}, sort:{}>".format(self.id, self.content, self.sort)

class NoteModel:
    """注释"""
    def __init__(self, id, content, sort):
        self.id = id
        self.content = content
        self.sort = sort
    
    def __str__(self):
        return "<id:{}, content:{}, sort:{}>".format(self.id, self.content, self.sort)

class PoemModel:
    """诗体结构，查询体"""
    def __init__(self, id, title,author_id, author, rhythmic,category_id,\
                  category,content_type, dynasty, paragraphs, notes):
        """
        paragraphs:段落列表 ParagraphModel[]
        notes:注释列表 NoteModel[]
        """
        self.id = id
        self.title = title
        self.author_id = author_id
        self.author = author
        self.rhythmic = rhythmic
        self.paragraphs = paragraphs
        self.notes = notes
        self.dynasty = dynasty
        self.category_id = category_id
        self.category = category
        self.content_type = content_type

    def __str__(self):
        return 'id:{},title:{},author_id:{}, author:{}, rhythmic:{}, paragraphs:{}, notes:{}, \
            dynasty:{},category_id:{}, category:{},content_type:{}'.format(self.id, self.title,\
            self.author_id, self.author, self.rhythmic, self.__str(self.paragraphs), \
            self.__str(self.notes), self.dynasty, self.category_id, self.category, self.content_type)

    def __str(self,list):
        """list转为字符串"""
        if list is None:
            return '[]?'
        return '[{}]'.format(','.join([str(item) for item in list]))

class PoemRecordModel:
    """诗词作品显示记录"""
    def __init__(self, poem_id, category_id, author_id, creation_time=None,id=0):
        self.id = id
        self.poem_id = poem_id #诗词id
        self.category_id = category_id #诗词分类id
        self.author_id = author_id #诗词作者id
        self.creation_time = creation_time
    def __str__(self):
        return "<id:{}, poem_id:{}, category_id:{}, author_id:{}, creation_time:{}>"\
            .format(self.id, self.poem_id, self.category_id, self.author_id, self.creation_time)