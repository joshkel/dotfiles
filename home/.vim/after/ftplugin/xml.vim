if expand('%:e') == 'xaml'
    let b:browsefilter = "XAML files (*.xaml, *.xaml.cs)\t*.xaml;*.xaml.cs\n" .
     \ "All Files (*.*)\t*.*\n"
endif
