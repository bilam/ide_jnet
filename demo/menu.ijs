NB. menu demo

coclass 'jndemo'

test=: 3 : 0
wd 'pc6j test'
wd 'menupop "&File"'
wd 'menu new "&New File"'
wd 'menu open "&Open File"'
wd 'menusep'
wd 'menu quit "Quit" "Ctrl+Q"'
wd 'menupopz'
wd 'menupop "&Edit"'
wd 'menu inputlog "Input &Log"'
wd 'menusep'
wd 'menupop "&Configure"'
wd 'menu base "&Base"'
wd 'menu launchpad "Launch &Pad"'
wd 'menupopz'
wd 'menusep'
wd 'menu sidebar "&Sidebar" "Ctrl+B"'
wd 'menu font "Session &Font"'
wd 'menupopz'
wd 'menupop "&Help"'
wd 'menu about "&About"'
wd 'menupopz'
wd 'set sidebar 1'
wd 'setenable font 0'
wd 'xywh 0 0 300 200'
wd 'cc list listbox'
wd 'set list one two three'
wd 'pshow'
)

NB. =========================================================
test_close=: 3 : 0
wd 'pclose'
showevents_jnet_ 0
)

showevents_jnet_ 2
test''
