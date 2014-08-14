syntax on
set ts=4 sw=4 is si et modeline
set backspace=indent,eol,start
set enc=utf-8
set cpoptions=$
filetype plugin on

set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

if has("win32")
    set gfn=Consolas:h11:cANSI

    " VIM's default:
    " set dir=.,c:\\tmp,c:\\temp
    " My change:  (because Windows 7 rearranges folder windows whenever a .swp
    " is added):
    set dir=c:\\tmp,c:\\temp
endif

if has('gui_running')
    " Inline spell-checking in text mode is too noisy (no nice subtle graphics).
    set spell
else
    " Disable X clipboard to not slow down by trying to connect to an X server.
    set clipboard=exclude:.*
endif

function ColorColumn()
    if v:version >= 703 && has('gui_running')
        set colorcolumn=80
    endif
endfunction

" Let % match, e.g., HTML tags
source $VIMRUNTIME/macros/matchit.vim

au BufRead *.jspx set filetype=jsp
au BufRead *.json set filetype=javascript

" Make syntax highlighting work for RAD Studio projects.
au BufRead *.cbproj set filetype=xml

" Make syntax highlighting work for Visual FoxPro programs.
au BufRead *.prg set filetype=foxpro

au BufRead *.md set filetype=markdown

" Enable spell checking for human-readable documents.
" Disabled for now in favor of blanket statement above.
"au FileType html set spell

au FileType python set et | exec ColorColumn()

au FileType cpp set ts=2 sw=2 | exec ColorColumn()

autocmd BufEnter *.html :syntax sync fromstart
autocmd BufEnter *.htm :syntax sync fromstart

" Enable viminfo to remember certain things when we exit.
set viminfo='10,\"100,:20,%,n~/.viminfo
" Use viminfo to restore last line when reopening a file
" vim.wikia.com has a fancier, longer version.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

hi ColorColumn guibg=#eeeeee

" Map Ctrl-Left and Ctrl-Right to :prev (previous file) and :next (next file),
" respectively 
map  ^[[D <Esc>:prev<CR>
map  ^[[C <Esc>:next<CR>
map! ^[[D <Esc>:prev<CR>
map! ^[[C <Esc>:next<CR>
nmap ^[[D :prev<CR>
nmap ^[[C :next<CR>

" TODO: See https://gist.github.com/ben336/4e4bc44d8135cfc43fc3
" TODO: See http://benmccormick.org/2014/07/14/learning-vim-in-2014-configuring-vim/

