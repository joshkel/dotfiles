" Pascal / Delphi
if (1==1) "change to "1==0" to use original syntax
  au BufNewFile,BufRead *.pas,*.PAS set ft=delphi
else
  au BufNewFile,BufRead *.pas,*.PAS set ft=pascal
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

au BufNewFile,BufRead *.proto setfiletype proto

au BufNewFile,BufRead *.jspx set filetype=jsp
au BufNewFile,BufRead *.json set filetype=javascript

" Embarcadero RAD Studio projects
au BufNewFile,BufRead *.dproj set filetype=xml
au BufNewFile,BufRead *.cbproj set filetype=xml

" Visual FoxPro programs
au BufNewFile,BufRead *.prg set filetype=foxpro

au BufNewFile,BufRead *.md set filetype=markdown

