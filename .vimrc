syntax on " 语法高亮
" syntax enable
" set background=light
" colorscheme solarized " solarized 配色主题方案

" colorscheme darkblue " vim 自带主题方案



set nocompatible " 去除vi一致性
set nu " 显示行号
set tabstop=4 " 设置tab的缩进值
set hlsearch
set autoindent
" 设置默认进行大小写不敏感查找
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase

filetype on
" filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugins')
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'                " file/directory treee
Plugin 'scrooloose/nerdcommenter'           " code commenter
Plugin 'kien/ctrlp.vim'                     " Fuzzy file, buffer, mru, tag, etc finder
" Plugin 'Valloric/YouCompleteMe'           " C-family, C#, Go, JavaScript, Python,
call vundle#end()
filetype plugin indent on

hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff

" call plug#begin('~/.vim/plugged')
" Plug 'itchyny/lightline.vim'
" call plug#end()

" NERDTree plugin
map <F2> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
