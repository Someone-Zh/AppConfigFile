" syntax on " 语法高亮
" syntax enable
" set background=light
" colorscheme solarized " solarized 配色主题方案

" colorscheme darkblue " vim 自带主题方案

let mapleader=";"  " 更换leader键
set nocompatible " 去除vi一致性
set nu " 显示行号
set tabstop=4 " 设置tab的缩进值
set hlsearch " 高亮搜寻
set autoindent " 自动缩进
set ignorecase " 设置默认进行大小写不敏感查找
set smartcase " 如果有一个大写字母，则切换到大小写敏感查找
" 状态栏配置
set statusline=%#file_path#\%<%.50F\             "显示文件名和文件路径 (%<应该可以去掉)
set statusline+=%=%#file_info#\%y%m%r%h%w\ %*        "显示文件类型及文件状态
set statusline+=%#file_code#\%{&ff}\[%{&fenc}]\ %*   "显示文件编码类型
set statusline+=%#file_row#\ \[row:%l/%L]\ %*   "显示光标所在行和列
set statusline+=%#file_col#\ \[col:%c]\ %*   "显示光标所在行和列
set statusline+=%#file_ratio#\%3p%%\%*            "显示光标前文本所占总文本的比例
hi file_path cterm=none ctermfg=25 ctermbg=0
hi file_info cterm=none ctermfg=208 ctermbg=0
hi file_code cterm=none ctermfg=169 ctermbg=0
hi file_row cterm=none ctermfg=100 ctermbg=0
hi file_col cterm=none ctermfg=125 ctermbg=0
hi file_ratio cterm=none ctermfg=green ctermbg=0
hi statusline ctermfg=0 " 设置状态栏前景色为透明
set laststatus=2

filetype on
hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
" Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree',{ 'on': 'NERDTreeToggle'}                " file/directory treee
Plug 'scrooloose/nerdcommenter'           " code commenter
call plug#end()

filetype plugin indent on
" 映射配置
map <F3> :NERDTreeToggle<CR>
map <C-S-n> ;ci
map <C-S-a> ;cA
" 插件配置
let g:NERDSpaceDelims = 1  " 注释加一个空格
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '\.git' , '\.idea']

let g:NERDTreeWinSize = 35

autocmd vimenter * NERDTreeToggle " 自动打开文件树
autocmd VimEnter * wincmd p   " 打开时聚焦文本
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " 仅剩下nerdTree时 自动关闭
" autocmd TabEnter * NERDTreeMirror
