syntax on
set t_Co=256
set ts=4 sw=4 softtabstop=4 is autoindent et modeline modelines=2 title
set backspace=indent,eol,start
set enc=utf-8
" Buggy in MacVim
if !has("gui_macvim")
    set cpoptions=$
endif

if !exists("homesick")
    let homesick = $HOME . "/.homesick"
endif

set wildmenu

filetype off
let &runtimepath = &runtimepath . "," . homesick . "/repos/vundle"
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ntpeters/vim-better-whitespace'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-syntastic/syntastic'
Plugin 'editorconfig/editorconfig-vim'

" TODO: Doesn't work in Ubuntu 14.04's tmux 1.8
Plugin 'ConradIrwin/vim-bracketed-paste'

" Better alternative to using .viminfo to remember last line
Plugin 'dietsche/vim-lastplace'

Plugin 'sheerun/vim-polyglot'
" Individual languages, already included in vim-polyglot
" Plugin 'othree/html5.vim'
" Plugin 'pangloss/vim-javascript'
" Plugin 'elzr/vim-json'
" Plugin 'mxw/vim-jsx'
" Plugin 'tpope/vim-liquid'
" Plugin 'mustache/vim-mustache-handlebars'
" Individual languages, tentatively replaced with vim-polyglot
" Plugin 'hail2u/vim-css3-syntax'
" Support for ES2015, among other things
" See https://davidosomething.com/blog/vim-for-javascript/
" Plugin 'othree/yajs'

" Text objects for comments
Plugin 'kana/vim-textobj-user'
Plugin 'glts/vim-textobj-comment'

call vundle#end()

filetype plugin indent on

set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set hidden        " Leave hidden buffers open
set history=100

set spell

set mousemodel=popup_setpos browsedir=buffer
set ttimeoutlen=100        " http://stackoverflow.com/a/2158610/25507

" Join comments and indentation when joining lines.
if v:version >= 704
    set formatoptions+=j
end

if has("win32")
    set gfn=Consolas:h11:cANSI

    " VIM's default:
    " set dir=.,c:\\tmp,c:\\temp
    " My change:  (because Windows 7 rearranges folder windows whenever a .swp
    " is added):
    set dir=c:\\tmp,c:\\temp

    " CTRL-V is Paste
    " (from mswin.vim)
    map <C-V> "+gP
endif

if !has('gui_running')
    " Disable X clipboard to not slow down by trying to connect to an X server.
    set clipboard=exclude:.*
endif

function! ColorColumn(c)
    if v:version >= 703
        let &l:colorcolumn=a:c
    endif
endfunction

" Let % match, e.g., HTML tags
source $VIMRUNTIME/macros/matchit.vim

" Enable spell checking for human-readable documents.
" Disabled for now in favor of blanket statement above.
"au FileType html set spell

autocmd BufEnter *.html :syntax sync fromstart
autocmd BufEnter *.htm :syntax sync fromstart

hi ColorColumn guibg=#eeeeee ctermbg=255

" Default ctermbg=1 red background for unrecognized words is very loud.
" Try something less obtrusive.
hi SpellBad cterm=underline ctermbg=none
hi SpellRare cterm=none ctermbg=none
hi SpellCap cterm=none ctermbg=none

if has('gui_running')
    colorscheme solarized
    set background=light
end

" Map \ro to edit vimrc and \rr to source vimrc
" Hard-code Homeshick's paths so that we work on Windows as well as POSIX
map <leader>ro :e ~/.homesick/repos/dotfiles/home/.vimrc<CR>
map <leader>rr :source ~/.homesick/repos/dotfiles/home/.vimrc<CR>

set incsearch  " search as characters are entered
set hlsearch   " highlight matches

" Map \<space> to turn off highlighting.
nnoremap <leader><space> :nohlsearch<CR>

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

" Customize ntpeters/vim-better-whitespace: don't complain for Valgrind, as
" well as the plugin's default list
let g:better_whitespace_filetypes_blacklist=['valgrind',
            \'diff', 'gitcommit', 'unite', 'qf', 'help']

" Customize elzr/vim-json: don't hide double quotes
"let g:vim_json_syntax_conceal = 0

" Customize mxw/vim-jsx: use JSX even for .js files
let g:jsx_ext_required = 0

" Use F4 to switch between source and header files.
" From http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
" See that file for much more sophisticated versions.
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

if !empty(glob(expand("<sfile>:p:h") . "/.vim/bundle/syntastic"))
    " Recommended Syntastic settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    " C++ checkers are slow and need additional configuration.  Disable for now.
    let g:syntastic_cpp_checkers = []

    let g:syntastic_python_checkers = ['flake8']

    let g:syntastic_sh_shellcheck_args = "-x"

    " Treating .env files as shell scripts results in lots of spurious
    " warnings.  Disable for now.
    let g:syntastic_ignore_files = ['/.env$']
endif

" Other useful resources:
" http://vim.wikia.com/wiki/Example_vimrc
" https://gist.github.com/ben336/4e4bc44d8135cfc43fc3
" http://benmccormick.org/2014/07/14/learning-vim-in-2014-configuring-vim/
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://robots.thoughtbot.com/faster-grepping-in-vim
" http://statico.github.io/vim.html
" http://tuxdiary.com/2015/02/15/yavide/
" http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
" https://github.com/tpope/vim-sensible
" http://vim-bootstrap.com/
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" http://www.liuchengxu.org/posts/use-vim-as-a-python-ide/
" https://hackernoon.com/5-vim-plugins-i-cant-live-without-for-javascript-development-f7e98f98e8d5#.1idq2o5pu
" https://dougblack.io/words/a-good-vimrc.html
" https://leanpub.com/deliberatevim
" https://statico.github.io/vim3.html
" https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html
" https://www.hillelwayne.com/post/intermediate-vim/
"
" For Ctags in particular:
" https://advancedweb.hu/2017/01/10/vim-scala-ag-ctags/

" To share with Windows gVim, create %HOMEPATH%/_vimrc with these contents:
" set runtimepath+=c:/cygwin/home/Josh/.homesick/repos/dotfiles/home/.vim
" source c:/cygwin/home/Josh/.homesick/repos/dotfiles/home/.vimrc

