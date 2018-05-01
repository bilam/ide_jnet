NB. webgl

coclass 'jndemo'

J3DI=: file2url jpath '~addons/ide/jnet/js/J3DI.js'
J3DIMath=: file2url jpath '~addons/ide/jnet/js/J3DIMath.js'
PICTURE=: file2url jpath '~addons/graphics/bmp/toucan.bmp'

NB. =========================================================
run_webgl=: 3 : 0
wd 'pc8j webgl;xywh 0 0 300 300;cc w webview'
h=. fread jpath '~addons/ide/jnet/demo/webgl.html'
m=. ('J3DI_js';J3DI;'J3DIMath_js';J3DIMath;'PICTURE';PICTURE) stringreplace h
wd 'pshow'
wd 'set w baseurl *', file2url jpath '~Addons'
wd 'set w html *',m
)

NB. =========================================================
webgl_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
run_webgl''
