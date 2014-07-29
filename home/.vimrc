syntax on
set ts=4 sw=4 is ai et
set backspace=indent,eol,start
set enc=utf-8
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

au BufRead *.jspx set filetype=jsp
au BufRead *.json set filetype=javascript

" Make syntax highlighting work for RAD Studio projects.
au BufRead *.cbproj set filetype=xml

" Make syntax highlighting work for Visual FoxPro programs.
au BufRead *.prg set filetype=foxpro

au BufRead *.md set filetype=markdown

" Enable spell checking for human-readable documents.
au FileType html set spell

au FileType python set et colorcolumn=80

au FileType cpp set ts=2 sw=2 colorcolumn=80

" Useful settings for Java web development.  No longer needed.
"au FileType html set noet
"au FileType css set noet
"au FileType jsp set noet
"au FileType xhtml set noet

augroup filetype
    au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" Use viminfo to restore last line when reopening a file
" vim.wikia.com has a fancier, longer version.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

hi ColorColumn guibg=#eeeeee

