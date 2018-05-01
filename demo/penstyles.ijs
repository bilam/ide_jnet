NB. pen styles demo

coclass 'jndemo'
coinsert 'jgl2'

NB. =========================================================
PenStyles=: cutopen 0 : 0
Solid Line
Dash Line
Dot Line
Dash Dot Line
Dash Dot Dot Line
No Pen
)

NB. =========================================================
penstyle_run=: 3 : 0
if. -. checkrequire 'gl2';'graphics/gl2' do. return. end.
require 'gl2'
coinsert 'jgl2'
wd 'pc6j penstyle closeok'
wd 'pn "Pen Styles"'
wd 'xywh 0 0 400 270'
wd 'cc g isigraph'
wd 'pshow'
)

penstyle_g_paint=: 3 : 0
off=. 30
glfill^:IFJNET 255 255 255 255
glrgb 0 0 255
for_i. i.#PenStyles do.
  y=. 30+40*i
  glpen (IFJNET{1,3),i   NB. J602 all solid if width > 1
  gllines 25,y,200,y
  gltextxy 230,y-off
  gltext (":i),' ',i pick PenStyles
end.
)

penstyle_run''
