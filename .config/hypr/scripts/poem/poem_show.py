"""
诗词显示
2025.1.22 by dralee
2025.1.23 optimization by dralee
"""
from os.path import getatime,exists,expanduser
import time
from PIL import Image, ImageDraw, ImageFont
from poem_access import PoemDBAccessor
from model import PoemModel

class PoemShow:
    def __init__(self):
        self.font_family_back = 'msyh.ttc' # 备用字体使用微软雅黑
        self.font_family = 'STXINGKA.TTF'  # 主要字体使用华文行楷
        self.root = '{}/.config/hypr/scripts/poem'.format(expanduser('~'))
        self.db_name ='{}/poem.db'.format(self.root)
        self.db_accessor = PoemDBAccessor(self.db_name)
        self.image_path = '{}/poem.png'.format(self.root)
        self.image_expires_s = 14400 # 4h

    def run(self):
        """随机产生指定分类的诗词，不重复"""
        #print('exists:',exists(self.root))
        #p = self.db_accessor.get_poem(11)
        if exists(self.image_path):
            atime = int(getatime(self.image_path))
            now = int(time.time())
            if now - atime < self.image_expires_s:
                print("resuse the old image")
                return
        self.db_accessor.reset_poem_record()
        #p = self.db_accessor.get_poem_not_show_by_category(11)
        p = self.db_accessor.get_poem_not_show_by_rand() # 随机获取
        #print(p)
        self.draw(p)

    def draw(self, poem:PoemModel):
        """绘制诗词"""
        width = 500
        # 空白图像
        image = Image.new('RGBA', (width, 500), (255, 0, 0, 0)) # 透明
        #image = Image.new('RGB', (500, 600), (20, 27, 41))
        #image = Image.new('RGB', (500, 400), (255, 27, 41))
        draw = ImageDraw.Draw(image)
        # 画笔
        font_title = ImageFont.truetype(self.font_family, 25)
        font = ImageFont.truetype(self.font_family, 23)
        font_author = ImageFont.truetype(self.font_family, 15)
        font_title_bak = ImageFont.truetype(self.font_family_back, 21)
        font_bak = ImageFont.truetype(self.font_family_back, 19)
        font_author_bak = ImageFont.truetype(self.font_family_back, 11)

        # 画笔颜色
        titles = []
        l_title = len(poem.title)
        if l_title >= 18:
            p = l_title // 18 + l_title % 18
            if p == 2:
                titles.append(poem.title[0: l_title//2])
                titles.append(poem.title[l_title//2:])
            else:
                for i in range(p):
                    title = poem.title[i*18:(i+1)*18]
                    if title.strip() == '':
                        continue
                    titles.append(title)
        else:
            titles.append(poem.title)

        print(titles)
        top = 50
        for title in titles:
            #draw.text((self.__text_center(title, font_title, width), top), title, font=font_title, fill=(252, 195, 7))
            self.__draw_text_line(draw, title, (self.__text_center(title, font, width)), top, font_title,font_title_bak,(252, 195, 7))
            top+=28
        top+=10
        draw.text((self.__text_center(poem.author, font_author, width), top), poem.author, font=font_author, fill=(97, 154, 195))
        top+=20
        draw.text((self.__text_center(poem.dynasty, font_author, width), top), poem.dynasty, font=font_author, fill=(242, 107, 31))
        #top = 130
        top+=25
        line = ''
        lines = []
        for pg in poem.paragraphs:
            content = pg.content.strip()
            l = len(content)
            if l >= 20:
                p = l // 20 + l % 20
                for i in range(p):
                    content = pg.content[i*20:(i+1)*20].strip()
                    l = len(content)
                    if l == 0:
                        continue
                    if len(line) < l:
                        line = content
                    lines.append(content)
                continue

            l = len(content)
            if len(line) < l:
                line = content
            if content.strip() == '':
                continue
            lines.append(content)
        print("lines:", lines,"==>",line)
        for content in lines:
                #draw.text((self.__text_center(line, font, width), top), content, font=font, fill=(224, 200, 209))
                self.__draw_text_line(draw, content, (self.__text_center(line, font, width)), top, font,font_bak,(224,200,209))
                top += 28

        #image.show()
        image.save(self.image_path, 'PNG')

    def __draw_text_line(self, draw, text, x, y, font:ImageFont,font_bak:ImageFont,fill):
        """自适应字体绘制行"""
        for char in text:
            f = font
            if not f.getmask(char).getbbox():
                f = font_bak
            draw.text((x, y), char, font=f, fill=fill)
            x += self.__font_size(f, char)[0]

    def __font_size(self, font, text):
        """获取字体大小
        返回字体：(w,h)
        """
        l,t,r,b = font.getbbox(text)
        w = r - l
        h = b - t
        return (w,h)

    def __text_center(self, text, font:ImageFont, width):
        l,t,r,b = font.getbbox(text)
        w = r - l
        h = b - t
        #w,h = font.getsize(text)
        left = (width-w)/2
        return left

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
