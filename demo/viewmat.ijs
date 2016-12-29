
coclass 'jndemo'

NB. =========================================================
test1=: 3 : 0
if. -. checkrequire_jndemo_ 'viewmat';'graphics/viewmat' do. return. end.
require 'viewmat'
viewmat i.5 5
wd 'pmove ', ":(n=. ?100 100), _1 _1
viewmat (] +./ .*. |:) 3&#. inverse i.243
wd 'pmove ', ":(50+n), _1 _1
)

NB. =========================================================
test1''
