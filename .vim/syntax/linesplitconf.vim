" 语法文件：~/.vim/syntax/linesplitconf.vim
" # 为备注
" 分隔行语法，以空行为分隔，首行为配置名称，其后为配置项
" 每个配置项以":"分隔，支持参数引用global块的定义参数，通过${name}形式引用
" 2026.1.27 by dralee
" 清除已有的语法定义
if exists("b:current_syntax")
  finish
endif

" 包含其它文件的语法,各关键字用空格分隔，不支持特殊字符，如@include无法识别成功
"syntax keyword keywordInclude include if else and

" 定义block-name：前后都有空行的config-xxx格式
" 使用\n\zs和\ze来精确匹配
syntax match configBlockName /^[a-zA-Z_][a-zA-Z0-9_-]*$/

" 定义key-value对：xxx: 开头的行
syntax match configKey /^[a-zA-Z0-9_-]\+\ze:/ nextgroup=configValue
syntax match configValue /:\s*\zs.*$/ contained

" 定义参数
syntax match configParam '\${[a-zA-Z_][a-zA-Z0-9_-]*}' containedin=String,quoteString1,quoteString2

" 定义多行数据：不是key:value格式且不是block-name的行
" 这些行既不包含冒号在开头，也不是config-xxx格式
syntax match configMultiline /^[^a-zA-Z0-9_-].*$\|^[a-zA-Z0-9_-]\+\s\+[^:].*$|^[^\s*$]/

" 也匹配那些看起来像config-xxx但前后没有空行的内容（作为多行数据）
syntax match configMultilineConfig /^config-[a-zA-Z0-9_-]\+$/ contains=NONE

" 通过match将@include定义为一个关键字
syntax match includeKey /@include\>/ 
syntax match includeValue /@include\s*\zs.*$/ 

" 多行字符串
syntax region doubleQuoteString start='"' end='"' skip='\\'
syntax region doubleQuoteString start="'" end="'" skip='\\'
syntax region quoteString1 start='{' end='}'
syntax region quoteString2 start="\[" end="\]"

" 备注
syntax match commentString /\s*#.*$/

"syntax cluster StringContains add=configParam
"syntax cluster CommentContains add=configParam

" 设置颜色
highlight link configBlockName Title
highlight link configKey Identifier
highlight link configValue String
highlight link configMultiline String 
highlight link configMultilineConfig String
highlight link doubleQuoteString String
highlight link quoteString1 String
highlight link quoteString2 String
highlight link configParam Keyword
highlight link commentString Comment
highlight link includeKey Keyword 
highlight link includeValue Identifier

" 特殊高亮：让block-name更突出
highlight configBlockName guifg=#00FF00 ctermfg=green gui=bold cterm=bold

let b:current_syntax = "linesplitconf"

" ============================================
" 文件类型检测：~/.vim/ftdetect/customconfig.vim
" ============================================
" autocmd BufRead,BufNewFile *.conf set filetype=customconfig
" autocmd BufRead,BufNewFile *.cfg set filetype=customconfig

" ============================================
" 或者在 ~/.vimrc 中直接使用：
" ============================================
" augroup CustomConfig
"   autocmd!
"   autocmd BufRead,BufNewFile *.conf set filetype=customconfig
"   " 或者对当前buffer手动设置
"   " :set filetype=customconfig
" augroup END
