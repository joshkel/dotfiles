syntax on
set ts=4 sw=4 is autoindent et modeline
set backspace=indent,eol,start
set enc=utf-8
set cpoptions=$

if !exists("homesick")
    let homesick = $HOME . "/.homesick"
endif

filetype off
let &runtimepath = &runtimepath . "," . homesick . "/repos/vundle"
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'mustache/vim-mustache-handlebars'
Bundle 'ntpeters/vim-better-whitespace'

call vundle#end()

filetype plugin indent on

set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set hidden        " Leave hidden buffers open
set history=100

set spell

set mousemodel=popup_setpos browsedir=buffer
set ttimeoutlen=100        " http://stackoverflow.com/a/2158610/25507

if has("win32")
    set gfn=Consolas:h11:cANSI

    " VIM's default:
    " set dir=.,c:\\tmp,c:\\temp
    " My change:  (because Windows 7 rearranges folder windows whenever a .swp
    " is added):
    set dir=c:\\tmp,c:\\temp
endif

if !has('gui_running')
    " Disable X clipboard to not slow down by trying to connect to an X server.
    set clipboard=exclude:.*
endif

function ColorColumn()
    if v:version >= 703 && has('gui_running')
        setlocal colorcolumn=80
    endif
endfunction

" Let % match, e.g., HTML tags
source $VIMRUNTIME/macros/matchit.vim

" Enable spell checking for human-readable documents.
" Disabled for now in favor of blanket statement above.
"au FileType html set spell

au FileType python set et | exec ColorColumn()

autocmd BufEnter *.html :syntax sync fromstart
autocmd BufEnter *.htm :syntax sync fromstart

" Enable viminfo to remember certain things when we exit.
set viminfo='10,\"100,:20,%,n~/.viminfo
" Use viminfo to restore last line when reopening a file
" vim.wikia.com has a fancier, longer version.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

hi ColorColumn guibg=#eeeeee

" Default ctermbg=1 red background for unrecognized words is very loud.
" Try something less obtrusive.
hi SpellBad cterm=underline ctermbg=none
hi SpellRare cterm=none ctermbg=none
hi SpellCap cterm=none ctermbg=none

map <leader>rr :source ~/.vimrc<CR>

" Map Ctrl-Left and Ctrl-Right to :prev (previous file) and :next (next file),
" respectively 
map  <Esc>[D <Esc>:prev<CR>
map  <Esc>[C <Esc>:next<CR>
map! <Esc>[D <Esc>:prev<CR>
map! <Esc>[C <Esc>:next<CR>
nmap <Esc>[D :prev<CR>
nmap <Esc>[C :next<CR>

" Toggles "paste mode' (no autoindent)
" http://nvie.com/posts/how-i-boosted-my-vim/
set pastetoggle=<F2>

" Other useful resources:
" http://vim.wikia.com/wiki/Example_vimrc
" https://gist.github.com/ben336/4e4bc44d8135cfc43fc3
" http://benmccormick.org/2014/07/14/learning-vim-in-2014-configuring-vim/
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://robots.thoughtbot.com/faster-grepping-in-vim
" http://statico.github.io/vim.html

" To share with Windows gVim, create %HOMEPATH%/_vimrc with these contents:
" set runtimepath+=c:/cygwin/home/Josh/.homesick/repos/dotfiles/home/.vim
" source c:/cygwin/home/Josh/.homesick/repos/dotfiles/home/.vimrc

