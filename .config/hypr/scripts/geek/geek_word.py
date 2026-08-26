"""
每日一话
2025.7.4 by dralee
2026.8.25 by dralee fix sync
"""
from os.path import getatime,exists,expanduser
import time

class GeekWord:
    def __init__(self):
        self.root = '{}/.config/hypr/scripts/geek'.format(expanduser('~'))
        self.source = "geek_quotes_10000.txt"
        self.text_file = "word"
        self.sync = ".sync"
        self.cache_time = 3600 # 1h
 
    def __read_file(self, file_name):
        file_name = "{}/{}".format(self.root, file_name)
        if not exists(file_name):
            return
        with open(file_name, "r", encoding='utf8') as f:
            return f.read().strip()

    def __exists(self, file_name):
        file_name = "{}/{}".format(self.root, file_name)
        return exists(file_name)
    
    def __save_file(self, file_name, content):
        file_name = "{}/{}".format(self.root, file_name)
        with open(file_name, "w", encoding='utf8') as f:
            f.write(content)

    def get_word(self):
        """获取每日一话
        每句索引以 1 开始
        """
        word = None
        tstr = self.__read_file(self.sync)
        lasttime = int('0' if tstr is None or tstr == '' else tstr)
        now = int(time.time())
        if self.__exists(self.text_file):
            #atime = int(getatime(self.text_file))            
            if now - lasttime < self.cache_time:
                #print("resuse the old word")
                return
            word = self.__read_file(self.text_file)
        
        index = 0
        if word is not None:
            index = int(word.split('#')[1])
            #print("word index: ", index)
        words = self.__read_file(self.source).split('\n')
        max_index = int(words[-1].split('#')[1])
        index = 0 if index == max_index else index
        word = words[index]
        #print("max index:", max_index, "index:", index, "word:", word)
        self.__save_file(self.text_file, word)
        self.__save_file(self.sync, str(now))
    
    def read(self):
        """获取每日一话"""
        self.get_word()
        text = self.__read_file(self.text_file)
        raw = text.split('#')[0]
        #print("the text is:", text)
        print(raw)
        return text

def main():
    gw = GeekWord()
    gw.read()

if __name__ == "__main__":
    main()
