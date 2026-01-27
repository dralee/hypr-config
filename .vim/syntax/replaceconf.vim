" 语法文件：~/.vim/syntax/replaceconf.vim
" # 为备注
" 替换值配置语法，以==>指定替换的值，前为源值，后为替换的值
" 如：dev==>fat
" 2026.1.27 by dralee
" 清除已有的语法定义
if exists("b:current_syntax")
  finish
endif

syntax match spliter '==>'

" 定义key-value对：xxx==> 开头的行
syntax match configKey /^.*\ze==>/ nextgroup=configValue
syntax match configValue /==>\s*\zs.*$/ contained


" 定义多行数据：不是key:value格式且不是block-name的行
" 这些行既不包含冒号在开头，也不是config-xxx格式
syntax match configMultiline /^[^a-zA-Z0-9_-].*$\|^[a-zA-Z0-9_-]\+\s\+[^:].*$|^[^\s*$]/

" 也匹配那些看起来像config-xxx但前后没有空行的内容（作为多行数据）
syntax match configMultilineConfig /^config-[a-zA-Z0-9_-]\+$/ contains=NONE

" 多行字符串
syntax region doubleQuoteString start='"' end='"'
syntax region doubleQuoteString start="'" end="'"
syntax region quoteString1 start='{' end='}'
syntax region quoteString2 start="\[" end="\]"

" 备注
syntax match commentString /\s*#.*$/

"syntax cluster StringContains add=configParam
"syntax cluster CommentContains add=configParam

" 设置颜色
highlight link spliter Keyword
highlight link configKey Identifier
highlight link configValue String
highlight link configMultiline String 
highlight link configMultilineConfig String
highlight link doubleQuoteString String
highlight link quoteString1 String
highlight link quoteString2 String
highlight link configParam Keyword
highlight link commentString Comment

" 特殊高亮：让block-name更突出
highlight configBlockName guifg=#00FF00 ctermfg=green gui=bold cterm=bold

let b:current_syntax = "replaceconf"

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
