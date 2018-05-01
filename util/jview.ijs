coclass 'jview'
MAXSIZE=: 400000

ischar=: 2 = 3!:0
getfontsz=: 13 : '{.1{._1 -.~ _1 ". y'
3 : 0''
if. 0 ~: 4!:0 <'VIEWFONT' do.
  VIEWFONT=: FIXFONT
end.
if. 0 ~: 4!:0 <'SMPRINT_j_' do.
  VIEWPRINT=: ''
else.
  VIEWPRINT=: SMPRINT_j_
end.
0
)

VIEWFONTSIZE=: getfontsz VIEWFONT
VIEWFONTSCALE=: 1
cifmt1=: 3 : 0
neg=. 0 > y
dat=. 0 ": | y
len=. #dat
msk=. (-len) {. (|. len$1j1 1 1) , 3$1
dat=. msk # !. ',' dat
(neg # '-'), dat
)
flat=: 3 : 0
dat=. ": y
dat=. 1 1}. _1 _1}. ": <dat
}: (,|."1 [ 1,.-. *./\"1 |."1 dat=' ')#,dat,.LF
)
setfontsz=: 4 : 0
b=. ~: /\ y='"'
nam=. b#y
txt=. ;:(-.b)#y
ndx=. 1 i.~ ([: *./ e.&'0123456789.') &> txt
nam, }: ; ,&' ' &.> (<": x) ndx } txt
)
unibox=: 3 : 0
fm=. (16+i.11) { a.
msk=. y e. fm
if. -. 1 e. msk do. y return. end.
to=. 4 u: 9484 9516 9488 9500 9532 9508 9492 9524 9496 9474 9472
y=. ucp y
msk=. y e. fm
un=. to {~ fm i. msk#y
utf8 un (I.msk) } y
)
create=: jview_run
destroy=: codestroy
JVIEW=: 0 : 0
pc6j jview;
xywh 2 2 132 10;cc h0 static;
xywh 0 13 350 250;cc e0 editm ws_border ws_vscroll es_readonly rightmove bottommove;
xywh 140 2 24 10;cc Top checkbox leftmove rightmove;
xywh 166 2 29 10;cc Wrap checkbox leftmove rightmove;
xywh 196 1 38 12;cc Print button leftmove rightmove;
pas 0 0;pcenter;
rem form end;
)
jview_form=: 3 : 0
'print edit'=. 2 {. y
VIEWMAX=: 0
ed=. ' ws_border ws_vscroll rightmove bottommove'
ed=. ed, (edit=0)# '  es_readonly'
wd 'pc6j jview'
wd 'xywh 2 2 132 10;cc h0 static;'
wd 'xywh 0 13 350 250;cc e0 editm',ed,' ws_hscroll'
wd 'xywh 0 13 350 250;cc e1 editm',ed
p=. 269 - 48 * print + edit
wd 'xywh ',(":p),' 2 34 10;cc Top checkbox leftmove rightmove;'
p=. p + 37
wd 'xywh ',(":p),' 2 39 10;cc Wrap checkbox leftmove rightmove;'
p=. p + 43
if. print do.
  wd 'xywh ',(":p),' 1 48 12;cc Print button leftmove rightmove;'
  p=. p + 48
end.
if. edit do.
  wd 'xywh ',(":p),' 1 48 12;cc OK button leftmove rightmove;'
end.
wd 'setfont e0 ',VIEWFONT
wd 'setfont e1 ',VIEWFONT
wd 'pas 0 0;pcenter;'
formhwnd=: wd 'qhwndp'
)
jview_getargs=: 3 : 0
defprint=. (0<#VIEWPRINT) *. 0=IFWINCE
y=. boxopen y
'name hdr txt'=. 3 {. y,'';''
wrap=. ptop=. edit=. noprint=. 0
print=. 1
y=. 3 }. y
if. #y do.
  if. (1=#y) *. ischar >{.y do.
    y=. ' ',>{.y
    y=. (y e. ', ') <;._1 y
    y=. y #~ y e. ;:'wrap ptop edit noprint'
    if. #y do.
      (y)=. 1
    end.
    print=. -. noprint
  else.
    y=. ; y
    'wrap print ptop edit'=. 4 {. y, (#y) }. 0 1 0 0
  end.
end.
print=. print *. defprint
if. edit do.
  edit=. 3 = 4!:0 <'view_result__COCREATOR'
end.
name;hdr;txt;wrap;print;ptop;edit
)
jview_gettext=: 3 : 0
('1'={.Wrap) pick e0;e1
)
jview_run=: 3 : 0

'name hdr txt wrap print ptop edit'=. jview_getargs y

if. 2 <: #$txt do. txt=. flat txt end.
txt=. unibox txt
txt=. (1{a.) (I. DEL=txt) }txt
if. MAXSIZE <: #txt do.
  msg=. 'Text size of ',(cifmt1 #txt),' characters is too large to view.'
  msg=. msg,LF,LF,'Truncated to ',(cifmt1 MAXSIZE),' characters.'
  txt=. (MAXSIZE {. txt),LF,'...'
  wdinfo name;msg
end.
TEXT=: txt

jview_form print,edit
wd 'pn *',name
wd 'set h0 *',hdr
wd 'set Wrap ',": wrap
wd 'set Top ',": ptop
wd 'ptop ',": ptop

try.
  if. wrap=0 do.
    wd 'set e0 *',txt
    wd 'setselect e0 0 0'
    wd 'setshow e1 0;setshow e0 1'
  else.
    wd 'set e1 *',txt
    wd 'setselect e1 0 0'
    wd 'setshow e1 1;setshow e0 0'
  end.
catch.
  msg=. LF,LF,({.~ i.&':') wd 'qer'
  wdinfo 'jview';'Unable to view text',msg
  wd 'psel jview;pclose'
  destroy''
  return.
end.

wdfit''
wd 'pshow'
)
jview_OK_button=: 3 : 0
TEXT=: jview_gettext''
jview_close 1
)
jview_Print_button=: 3 : 0
require 'print'
txt=. jview_gettext''
try. '' VIEWPRINT~ txt
catch. wdinfo 'Print';'Print failed.',LF,LF,'Check the printer is installed'
end.
)
jview_Top_button=: 3 : 0
wd 'ptop ',Top
)
jview_Wrap_button=: 3 : 0
if. Wrap='1' do.
  wd 'set e1 *',e0
  wd 'setselect e1 ',e0_select
  wd 'setshow e1 1;setshow e0 0'
else.
  wd 'set e0 *',e1
  wd 'setselect e0 ',e1_select
  wd 'setshow e0 1;setshow e1 0'
end.
)
jview_close=: 3 : 0
wd 'pclose'
f=. 'view_result__COCREATOR'
if. 3 = 4!:0 :: _1: < f do.
  if. y -: 1 do.
    res=. 0;TEXT
  else.
    res=. 1;TEXT
  end.
  try. f~res catch. end.
end.
destroy''
)
jview_cancel=: jview_close
jview_mctrl_fkey=: 3 : 0
VIEWMAX=: -. VIEWMAX
if. VIEWMAX do.
  wd 'pshow sw_showmaximized'
else.
  wd 'pshow sw_shownormal'
end.
)
jview_maximize=: 3 : 0
VIEWMAX=: 0
jview_mctrl_fkey''
)
jview_scale=: 3 : 0
VIEWFONTSCALE=: VIEWFONTSCALE * 1.2 ^ y
font=. (<. 0.5 + VIEWFONTSIZE * VIEWFONTSCALE) setfontsz VIEWFONT
wd 'setfont e0 ',font
wd 'setfont e1 ',font
)
jview_bctrl_fkey=: jview_scale bind 1
jview_bctrlshift_fkey=: jview_scale bind _1
cocurrent 'z'
fview=: 3 : 0
y=. boxopen y
f=. 1!:(1 11 {~ 2=#y)
dat=. f :: _1: y
if. dat -: _1 do. return. end.
empty (>{.y) wdview dat
)
wdview=: 3 : 0
'View' wdview y
:
txt=. y
if. 0=L.txt do. txt=. '';txt end.
empty (x;txt) conew 'jview'
)
