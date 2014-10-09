setlocal ts=2 sw=2

exec ColorColumn()

" See http://stackoverflow.com/q/22649637/25507
let b:browsefilter = "C++ Source Files (*.cpp, *.cc, *.h, *.hpp)\t*.cpp;*.cc;*.h;*.hpp\n" .
 \ "C Source Files (*.c, *.h)\t*.c;*.h\n" .
 \ "C/C++ Header Files (*.h, *.hpp)\t*.h;*.hpp\n" .
 \ "All Files (*.*)\t*.*\n"
