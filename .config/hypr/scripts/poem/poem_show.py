"""
诗词显示
2025.1.22 by dralee
"""
from os.path import getatime,exists,expanduser
from os import getcwd
import time
from PIL import Image, ImageDraw, ImageFont
from poem_access import PoemDBAccessor
from model import PoemModel

class PoemShow:
    def __init__(self):
        self.root = '{}/.config/hypr/scripts/poem'.format(expanduser('~'))
        self.db_name ='{}/poem.db'.format(self.root)
        self.db_accessor = PoemDBAccessor(self.db_name)
        self.image_path = '{}/poem.png'.format(self.root)
        self.image_expires_s = 14400 # 4h

    def run(self):
        """随机产生指定分类的诗词，不重复"""
        #print('exists:',exists(self.root))
        #p = self.db_accessor.get_poem(1)
        if exists(self.image_path):
            atime = int(getatime(self.image_path))
            now = int(time.time())
            if now - atime < self.image_expires_s:
                print("resuse the old image")                
                return
        self.db_accessor.reset_poem_record()
        p = self.db_accessor.get_poem_not_show_by_category(11)
        #print(p)
        self.draw(p)

    def draw(self, poem:PoemModel):
        """绘制诗词"""
        # 空白图像
        image = Image.new('RGBA', (500, 500), (255, 0, 0, 0)) # 透明
        #image = Image.new('RGB', (500, 600), (20, 27, 41))
        #image = Image.new('RGB', (500, 400), (255, 27, 41))
        draw = ImageDraw.Draw(image)
        # 画笔
        font_title = ImageFont.truetype('STXINGKA.TTF', 25)
        font = ImageFont.truetype('STXINGKA.TTF', 23)
        font_author = ImageFont.truetype('STXINGKA.TTF', 15)
        
        left = 20
        # 画笔颜色
        draw.text((left+10, 50), poem.title, font=font_title, fill=(252, 195, 7))
        draw.text((left+80, 85), poem.author, font=font_author, fill=(97, 154, 195))
        draw.text((left+100, 105), poem.dynasty, font=font_author, fill=(242, 107, 31))
        top = 130
        for p in poem.paragraphs:
            draw.text((left, top), p.content, font=font, fill=(224, 200, 209))
            top += 28
        

        image.show()
        image.save(self.image_path, 'PNG')

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
