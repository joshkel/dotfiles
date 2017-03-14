" Pascal / Delphi
" I like the original syntax better.
if (1==0) "change to "1==0" to use original syntax
  au BufNewFile,BufRead *.pas,*.PAS,*.inc set ft=delphi
else
  au BufNewFile,BufRead *.pas,*.PAS,*.inc set ft=pascal
endif
" Delphi project file
au BufNewFile,BufRead *.dpr,*.DPR set ft=delphi
" Delphi form file
au BufNewFile,BufRead *.dfm,*.DFM set ft=delphi
au BufNewFile,BufRead *.xfm,*.XFM set ft=delphi
" Delphi package file
au BufNewFile,BufRead *.dpk,*.DPK set ft=delphi
" Delphi .DOF file = INI file for MSDOS
au BufNewFile,BufRead *.dof,*.DOF set ft=dosini
au BufNewFile,BufRead *.kof,*.KOF set ft=dosini
au BufNewFile,BufRead *.dsk,*.DSK set ft=dosini
au BufNewFile,BufRead *.desk,*.DESK set ft=dosini
au BufNewFile,BufRead *.dti,*.DTI set ft=dosini
" Delphi .BPG = Makefile
au BufNewFile,BufRead *.bpg,*.BPG set ft=make|setlocal makeprg=make\ -f\ % 

au BufNewFile,BufRead *.i set filetype=swig
au BufNewFile,BufRead *.swg set filetype=swig

au BufNewFile,BufRead *.proto set filetype=proto spellcapcheck=

au BufNewFile,BufRead *.jspx set filetype=jsp
au BufNewFile,BufRead *.json set filetype=javascript

" Embarcadero RAD Studio projects
au BufNewFile,BufRead *.dproj set filetype=xml
au BufNewFile,BufRead *.cbproj set filetype=xml
au BufNewFile,BufRead *.groupproj set filetype=xml

" Visual FoxPro programs
au BufNewFile,BufRead *.prg set filetype=foxpro

" C++ standard headers - no suffix
au BufNewFile,BufRead */dinkumware/* set filetype=cpp
au BufNewFile,BufRead */dinkumware64/* set filetype=cpp
au BufNewFile,BufRead /usr/include/c++/* set filetype=cpp

" Web development-related config files
au BufNewFile,BufRead .babelrc set filetype=json
au BufNewFile,BufRead .eslintrc set filetype=json
au BufNewFile,BufRead .jscsrc set filetype=json

" More web development
au BufNewFile,BufRead .node_repl_history set filetype=javascript

" Valgrind filenames that I like to use
au BufRead valgrind.out set filetype=valgrind
au BufRead helgrind.out set filetype=valgrind
au BufRead *.supp set filetype=supp

" Other
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead upstart set filetype=upstart
au BufNewFile,BufRead *.ll set filetype=llvm
au BufNewFile,BufRead *.rockspec set filetype=lua
