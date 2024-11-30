call plug#begin()

" List your plugins here
"Plug 'tpope/vim-sensible'

" vim startify
Plug 'mhinz/vim-startify'

" c# intellisense and more for C#
Plug 'omnisharp/omnisharp-vim'

" nerdtree
Plug 'preservim/nerdtree'

" batch search replace
Plug 'brooth/far.vim'

" python mode for intellisense
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" coc intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" neoformat auto format the code
Plug 'sbdchd/neoformat'

" translate
Plug 'voldikss/vim-translator'

" nerdcommenter for code
Plug 'preservim/nerdcommenter'

" tabular for markdown
Plug 'preservim/vim-markdown'

" markdown
Plug 'preservim/vim-markdown'


call plug#end()

" pathogen plugin
execute pathogen#infect()


" shotkey for nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" coc
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" colc Use <Ctrl-F> to format documents with prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
noremap <C-F> :Prettier<CR>

" coc highlight
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc pop color
highlight CocFloating ctermfg=LightBlue ctermbg=DarkGrey "gui=#11f0c3
"highlight CocErrorFloat ctermfg={fg color} ctermbg={bg color} gui={gui color}
"highlight CocMenueSel ctermfg=Red ctermbg=Blue "gui={gui color}


" nerdcommenter toggle monitor
nnoremap <silent> <leader>c} V}:call nerdcommenter#Comment('x', 'toggle')<CR>
nnoremap <silent> <leader>c{ V{:call nerdcommenter#Comment('x', 'toggle')<CR>

" tagbar,by pathogen use the tagbar where is in the ~/.vim/bundle
execute pathogen#infect('tagbar/{}')
nmap <F8> :TagbarToggle<CR>

" vim-auto-save,by pathogen use the auto-save where is in the ~/.vim/bundle
execute pathogen#infect('vim-auto-save/{}')
let g:auto_save = 1  " enable AutoSave on Vim startup

" neoformat
let g:neoformat_try_formatprg = 1
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
" Ctrl+F format the file
noremap <C-F> :Neoformat<CR>

" set the default vi config
set shiftwidth=4 smarttab
set tabstop=4
set nu

