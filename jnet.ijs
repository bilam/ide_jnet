NB. JNet

18!:4 <'z'

PATHSEP_j_=: '/'

IFJAVA=: 'jjava'-: (11!:0) :: 0: 'qwd'
IFJWD=: 0-.@-:(11!:0) :: 0: 'qwd'
IFJNET=: (IFJNET"_)^:(0=4!:0<'IFJNET') 0
IFWINCE=: 7=9!:12''
IFCONSOLE=: IFQT < 0-:(11!:0) :: 0: 'qwd'
IFTILEWM=: (IFTILEWM"_)^:(0=4!:0<'IFTILEWM') 0
USEQTJPEG=: 0
USEQTPNG=: 0

3 : 0''
if.IFJWD>IFJA do.
  finalize_jgl2_=: load bind 'ide/jnet/gl2'
end.
if. IFJA +. -.IFJWD do.
  IFJIJX_j_=: 1
end.
if. IFUNIX do.
  if. 0~:nc <'FIXFONT' do. FIXFONT=: IFJAVA{::'"DejaVu Sans Mono" 12';'Monospaced 12' end.
  if. 0~:nc <'PROFONT' do. PROFONT=: IFJAVA{::'"DejaVu Serif" 10';'SansSerif 10' end.
else.
  if. 0~:nc <'FIXFONT' do. FIXFONT=: '"Courier New" 12' end.
  if. 0~:nc <'PROFONT' do. PROFONT=: '"MS Sans Serif" 8' end.
end.
EMPTY
)

buildpublic_j_ 0 : 0
conlib       ~addons/ide/jnet/conlib
gl3          ~addons/ide/jnet/gl3
jnet         ~addons/ide/jnet/jnet
jview        ~addons/ide/jnet/util/jview
print        ~addons/ide/jnet/print/print
stdlib       ~system/main/stdlib
winlib       ~addons/ide/jnet/winlib
grid         ~addons/ide/jnet/classes/graphics/grid/grid
jdgrid       ~addons/ide/jnet/classes/graphics/grid/jdgrid
jsgrid       ~addons/ide/jnet/classes/graphics/grid/jsgrid
jtable       ~addons/ide/jnet/classes/graphics/grid/jtable
jtgrid       ~addons/ide/jnet/classes/graphics/grid/jtgrid
jvgrid       ~addons/ide/jnet/classes/graphics/grid/jvgrid
jzgrid       ~addons/ide/jnet/classes/graphics/grid/jzgrid
)
18!:4 <'jnet'
addons_msg=: 0 : 0
The XX are not yet installed.

To install, select menu Tools|Package Manager and install package YY.
)
addons_missing=: 3 : 0
'name addon script'=. y
if. fexist script do. 0 return. end.
sminfo name;addons_msg rplc 'XX';name;'YY';addon
1
)
demojn=: 3 : 0
p=. jpath '~addons/ide/jnet/demo/jndemo.ijs'
if. addons_missing 'jnet demos';'ide/jnet';p do. return. end.
load p
)
demowd=: 3 : 0
p=. jpath '~addons/demos/wd/demos.ijs'
if. addons_missing 'Showcase demos';'demos/wd';p do. return. end.
load p
)
lab=: 3 : 0
p=. jpath '~addons/labs/labs/lab.ijs'
if. addons_missing 'labs';'labs/labs';p do. return. end.
require p
lab_jlab_ y
)
coclass 'jpick'


RETURN=: ''

todelim=: ; @: ((DEL&,) @ (,&DEL) @ , @ ": &.>)
create=: jpick_run
destroy=: 3 : 0
wd 'pclose'
codestroy''
)
JPICK=: 0 : 0
pc6j jpick nomin owner;
xywh 0 0 200 175;cc lb listbox ws_vscroll rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
jpick_run=: 3 : 0
'sel init title return opts'=. 5 {. y
'font tab'=. 2 {. opts, 0
RETURN=: (return -.' '),'__COCREATOR'
wd JPICK
wd 'pn *',title
wd 'setfont lb ',font pick FIXFONT;PROFONT
if. tab do.
  wd 'settabstops lb ',": tab
end.
wd 'set lb ',todelim sel
if. #init do.
  wd 'setselect lb ',":init
end.
wd 'pshow'
)
jpick_enter=: jpick_lb_button=: jpickdo bind 1
jpick_cancel=: jpick_close=: jpickdo bind 0
jpickdo=: 3 : 0
res=. ''
if. y do.
  sel=. lb_select
  if. #sel do.
    res=. {. 0 ". sel
  end.
end.
destroy''
try. RETURN~ res catch. end.
)
coclass 'jnet'
JNETREQ=: '1.0.1.0'
checkjnetversion=: 3 : 0
f=. 1000 #. 3 {. 0 ". ' ' I.@('.'=])} ]
ver=. wd 'version'
act=. f (<./ ver i.'/s') {. ver
req=. f JNETREQ
if. req <: act do. return. end.
msg=. 'The JNet application needs updating.',LF2
msg=. msg,'Please download and install the latest jnet addon.'
sminfo 'JNet';msg
)
showevents=: 3 : 0
select. {. y,1
case. 0 do.
  4!:55 <'wdhandler_debug_z_'
case. 1 do.
  wdhandler_debug_z_=: 3 : 'smoutput sysevent,''_'',(>coname''''),''_'''
case. 2 do.
  wdhandler_debug_z_=: 3 : 'smoutput wdq'
case. 3 do.
  wdhandler_debug_z_=: 3 : 'if. -. ''_mmove''-:_6{.sysevent do. smoutput sysevent end.'
case. 4 do.
  wdhandler_debug_z_=: 3 : 'if. -. ''_mmove''-:_6{.sysevent do. smoutput wdq end.'
end.
EMPTY
)
18!:4 <'base'

3 : 0''
if. 0=4!:0<'DISPLAYLOAD_j_' do.
  DISPLAYLOAD_j_=: 1
  IFJIJX_j_=: 1
else.
  DISPLAYLOAD_j_=: 0
end.

load '~addons/ide/jnet/gl2.ijs'
load '~addons/ide/jnet/winlib.ijs'
load '~addons/ide/jnet/util/jijs.ijs'
load '~addons/ide/jnet/util/cfgread.ijs'
configure_jcfg_ 0
if. -. IFJIJX_j_ do. newijx_jijs_ 0 end.
checkjnetversion_jnet_^:IFJNET''
EMPTY
)
