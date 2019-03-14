" line numbering
set nu

set cindent
set smartindent
set autoindent

" tabs four spaces
set ts=4
set tabstop=4

set sw=4
set shiftwidth=4

set softtabstop=4

set expandtab
"syntax hilight
syntax on

"auto-indenting
set ai

" no compatible with old vi
set nocompatible

"shot matching brackets
set showmatch

"set binary noeol

"set backspace=indent,eol,startr

let mapleader = ','

set expandtab

" vundle
filetype off " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

Plug 'lukerandall/haskellmode-vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/paredit.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-classpath'
Plug 'guns/vim-clojure-static'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fireplace'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-rails'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mxw/vim-jsx'
Plug 'junegunn/vim-easy-align'
Plug 'mileszs/ack.vim'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

filetype plugin on

" haskell stuff
au BufEnter *.hs compiler ghc
let g:ghc = "/usr/bin/ghc"
let g:haddock_docdir = "/usr/share/doc/ghc/html/" 
" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" set colors when using iTerm2
set t_Co=256
" Solarized stuff
let g:solarized_termtrans = 1
" light in gvimrc
" set background=light
set background=dark
colorscheme solarized

" set Rainbow Parentheses on
let g:rbpt_max = 16
au VimEnter * RainbowParenthesesToggle

" remap split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

function SearchAckWithSelection()
    let sel = s:get_visual_selection()
    execute "Ack '" . sel . "'"
endfunction
function SearchTagsWithSelection()
    let sel = s:get_visual_selection()
    execute "CtrlPTag '" . sel . "'"
endfunction

vnoremap <LEADER>a :<C-U>call SearchAckWithSelection()<CR>
vnoremap <LEADER>. :<C-U>call SearchTagsWithSelection()<CR>

nmap <F7> :NERDTreeToggle<CR>

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlP pwd'
nnoremap <LEADER>. :CtrlPTag<CR>
nnoremap <LEADER>t :CtrlP<CR>

" tern for js
" enable keyboard shortcuts
let g:tern_map_keys=1
"show argument hints
let g:tern_show_argument_hints='on_hold'

nnoremap <C-G> :TernDef<CR>
