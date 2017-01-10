NB. JNet

18!:4 <'z'

buildpublic_j_ 0 : 0
grid         ~addons/graphics/grid/grid
jdgrid       ~addons/graphics/grid/jdgrid
jsgrid       ~addons/graphics/grid/jsgrid
jttable      ~addons/graphics/grid/jtable
jtgrid       ~addons/graphics/grid/jtgrid
jvgrid       ~addons/graphics/grid/jvgrid
jzgrid       ~addons/graphics/grid/jzgrid
)

PATHSEP_j_=: '/'

IFJAVA=: 'jjava'-: (11!:0) :: 0: 'qwd'
IFJNET=: (IFJNET"_)^:(0=4!:0<'IFJNET') 0
IFIOS=: 0
IFQT=: 0
IFWINCE=: 7=9!:12''
IFCONSOLE=: 0
IFTILEWM=: (IFTILEWM"_)^:(0=4!:0<'IFTILEWM') 0
USEQTJPEG=: 0
USEQTPNG=: 0

finalize_jgl2_=: 3 : 0
load 'ide/jnet/gl2'
)

3 : 0''
if. IFUNIX do.
  if. 0~:nc <'FIXFONT' do. FIXFONT=: IFJAVA{::'"DejaVu Sans Mono" 12';'Monospaced 12' end.
  if. 0~:nc <'PROFONT' do. PROFONT=: IFJAVA{::'"DejaVu Serif" 10';'SansSerif 10' end.
else.
  if. 0~:nc <'FIXFONT' do. FIXFONT=: '"Courier New" 12' end.
  if. 0~:nc <'PROFONT' do. PROFONT=: '"MS Sans Serif" 8' end.
end.
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
18!:4 <'z'
wd6=: 3 : 0"1
if. 'pc6j '-:5{.y do. y=. 'pc ',5}.y end.
y=. (';pc6j';';pc ') stringreplace y
y=. ((LF,'pc6j ');(LF,'pc ')) stringreplace y
11!:0 y
)
wd=: wd6`(11!:0)@.IFJNET f.
wdreset=: wd bind 'reset'
wdclipread=: toJ @ wd bind 'clippaste'
wdbox=: 3 : 0
whs=. 8 9 10 13 32{a.
del=. 127{a.
dat=. ' ',y
msk=. ~:/\ dat e. del
mqt=. 2: +./\ 0: , 2: | +/\ @ (=&'"')
mquote=. -. mqt dat
msk=. mquote *. msk
ndx=. 1 i.~ msk < dat='*'
end=. < }. ndx }. dat
dat=. ndx{.dat
msk=. mquote *.(ndx {. msk) < dat e. whs
dat=. (msk <;._1 dat) , end
a: -.~ dat -. each <del
)
wdcenter=: 3 : 0
'fx fy fw fh'=. 0&". :: ] y
'sx sy'=. sxy=. 2 {. 0 ". wd 'qm'
'w h'=. sxy <. _2 {. 0 ". wd 'qformx'
x=. 0 >. (sx-w) <. fx + <. -: fw-w
y=. 0 >. (sy-h) <. fy + <. -: fh-h
wd 'pmovex ',": x,y,w,h
)
wdclipwrite=: 3 : 0
txt=. y
if. L. txt do.
  txt=. }. ; (LF&, @ , @ ": each) txt
else.
  txt=. ": txt
  if. 1 < #$txt do. txt=. }. , LF,"1 txt end.
end.
wd 'clipcopy *',toHOST txt
#txt
)
wde=: 3 : 0
try. res=. wd y
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {.". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}.y
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  wdinfo 'Window Driver';'wd error ',msg,LF,cmd
  wderr=. 13!:8@1:
  wderr ''
end.
)
wdfit=: 3 : 0

if. IFJAVA do. return. end.

'mx my'=. 2{.y,(#y)}.1 1
'x y w h'=. 0 ". wd 'qformx'
'fx fy zx zy yc ym sx sy sw sh'=. 6 }. 0 ". wd 'qm'

select. mx
case. 0 do.
  w=. w - 0 <. sx - x
  x=. x >. sx
  w=. 0 >. w <. sx + sw - x
case. 1 do.
  x=. sx >. x <. (sx+sw) - w
  w=. 0 >. w <. sx + sw - x
case. 2 do.
  x=. sx
  w=. sw
case. 3 do.
  x=. - fx
  w=. sw + 2 * fx
end.

select. my
case. 0 do.
  h=. h - 0 <. sy - y
  y=. y >. sy
  h=. 0 >. h <. sy + sh - y
case. 1 do.
  y=. sy >. y <. (sy+sh) - h
  h=. 0 >. h <. sy + sh - y
case. 2 do.
  y=. sy
  h=. sh
case. 3 do.
  y=. - yc + fy
  h=. sh + yc + 2 * fy
end.

wd 'pmovex ',":x,y,w,h
)
wdforms=: <;._2;._2 @ wd bind 'qpx'
wdget=: 4 : 0
nms=. {."1 y
vls=. {:"1 y
if. L. x do. vls {~ nms i. ,&.>x
else. > vls {~ nms i. <,x
end.
)

SYSPPC=: (<'syschild'),.'ppcnext';'ppcprevious'
wdhandler=: 3 : 0
wdq=: wd 'q'
wd_val=. {:"1 wdq
({."1 wdq)=: wd_val
if. 3=4!:0<'wdhandler_debug' do.
  try. wdhandler_debug'' catch. end.
end.
if. IFWINCE do.
  if. 1 e. SYSPPC e. wdq do.
    (syschild,'_jijs_')~'' return.
  end.
end.
wd_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. wd_val
if. 3 > wd_ndx do.
  wd_fn=. > wd_ndx { wd_val
  if. 13!:17'' do.
    wd_fn~''
  else.
    try. wd_fn~''
    catch.
      wd_err=. 13!:12''
      if. 0=4!:0 <'ERM_j_' do.
        wd_erm=. ERM_j_
        ERM_j_=: ''
        if. wd_erm -: wd_err do. i.0 0 return. end.
      end.
      wd_err=. LF,,LF,.(}.^:('|'e.~{.));._2 ,&LF^:(LF~:{:) wd_err
      wdinfo 'wdhandler';'error in: ',wd_fn,wd_err
    end.
  end.
end.
i.0 0
)
wdinfo=: 3 : 0
'a b'=. _2{. boxopen y
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
if. IFJNET do.
  empty wd 'mb info ',(f a),' ',(f b)
else.
  empty wd 'mb ',(f a),' ',(f b),' mb_iconinformation'
end.
)
wdisparent=: boxopen e. <;._2 @ wd bind 'qp'
wdishandle=: boxopen e. 1: {"1 wdforms
wdmove=: 3 : 0
'' wdmove y
:
if. IFJAVA do. return. end.
'px py'=. y
'sx sy sw sh'=. 12 13 14 15 { 0 ". wd 'qm'
if. #x do. wd 'psel ',x end.
'x y w h'=. 0 ". wd 'qformx'
if. px < 0 do. px=. sw - w - 1 + px end.
if. py < 0 do. py=. sh - h - 1 + py end.
wd 'pmovex ',": (px+sx),(py+sy),w,h
)
wdpclose=: [: wd :: empty 'psel ' , ';pclose' ,~ ":
wdqshow=: 3 : 0
txt=. (>{."1 wdq),.TAB,.>{:"1 wdq
wdinfo 'wdq';(60 <. {:$txt) {."1 txt
)
wdquery=: 3 : 0
0 wdquery y
:
if. IFJNET do.
  msg=. ;:'okcancel retrycancel yesno yesnocancel abortretryignore'
  res=. ;:'OK CANCEL RETRY YES NO ABORT IGNORE'
  ndx=. 0 1;2 1;3 4;3 4 1;5 2 6
  't d'=. 2{.x [ 'a b'=. _2{. boxopen y
  if. 2=#$b=. ":b do. b=. }.,LF,.b end.
  f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
  if. d e. 1 2 do.
    m=. 'mb query ', ('mb_defbutton',":>:d), ' mb_', (>t{msg), ' ',(f a),' ',(f b)
  else.
    m=. 'mb query mb_', (>t{msg), ' ',(f a),' ',(f b)
  end.
  (res {~ >t{ndx) i. <wd m
else.
  msg=. ;:'okcancel retrycancel yesno yesnocancel abortretryignore'
  res=. ;:'OK CANCEL RETRY YES NO ABORT IGNORE'
  ndx=. 0 1;2 1;3 4;3 4 1;5 2 6
  't d'=. 2{.x [ 'a b'=. _2{. boxopen y
  if. 2=#$b=. ":b do. b=. }.,LF,.b end.
  f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
  m=. 'mb ',(f a),' ',(f b),' mb_iconquestion mb_',>t{msg
  if. d e. 1 2 do. m=. m,' mb_defbutton',":>:d end.
  (res {~ >t{ndx) i. <wd m
end.
)
wdselect=: 3 : 0
0 wdselect y
:
if. 0=#y do.
  empty wd 'psel wdselect;pclose' return.
end.

'n s e'=. 3{.x

if. 2=L.y do. 'hdr sel'=. y
else. hdr=. '' [ sel=. y
end.

'r c'=. $,.>sel
sel=. ;sel ,each LF

'c r'=. (12,5*6>r) + >. 4 8 * >. c,r
c=. 205 <. 80 >. (4*#hdr) >. c
r=. 128 <. r

if. (<'wdselect') e. <;._2 wd 'qp' do.
  wd 'psel wdselect;pn '",hdr,'";'
else.
  wd 'pc6j wdselect;pn *',hdr
  wd 'xywh 4 4 ',":c,r
  wd 'cc l0 listbox ws_vscroll rightmove bottommove',s#' lbs_multiplesel'
  wd 'setfont l0 ',PROFONT
  wd 'cc e0 editm; setshow e0 0'
  wd 'xywh ',(":14+c),' 6 36 12;cc ok button leftmove rightmove bottommove;cn "OK";'
  wd 'xywh ',(":14+c),' 21 36 12;cc cancel button leftmove rightmove bottommove;cn "Cancel";'
  wd 'pas 4 2;pcenter;'
end.

wd 'set e0 *',sel
wd 'set l0 *',sel
wd (_1 ~: n) # 'setselect l0 ',":n
wd 'setfocus l0'
wd 'pshow'

while. 1 do.
  wdq=. wd 'wait;q'
  ({."1 wdq)=. {:"1 wdq
  done=. (<'cancel') e. systype;syschild
  button=. systype -: 'button'
  ok=. button *. (<syschild) e. ;:'l0 ok enter'
  if. ok +. done do.
    wd (ok *: e)#'pclose'
    ok;".l0_select
    break.
  end.
end.
)
wdstatus=: 3 : 0
'' wdstatus y
:
if. 0 e. $y do.
  empty wd :: [ 'psel status;pclose'
  return.
end.

msg=. y
if. 2=#$msg=. ":msg do. msg=. }.,LF,.msg
else. msg=. toJ (-LF={:msg)}.msg
end.

pn=. (*#x)#'pn ',DEL,x,DEL,';'

if. (<'status') e. <;._2 wd 'qp;' do.
  wd 'psel status;',pn
else.
  size=. |. 0 100 >. 8 4*$];._2 msg,LF
  wd 'pc6j status closeok;',pn
  wd 'xywh 10 10 ',(":size),';'
  wd 'cc s0 static;'
  wd 'pas 10 10;pcenter;'
end.

wd 'set s0 *',msg
wd 'pshow;'
)
mbopen=: 3 : 0
if. IFJNET do.
  jpathsep wd 8 u: 'mb open6 ',y
else.
  jpathsep wd 8 u: 'mbopen ',y
end.
)
mbsave=: 3 : 0
if. IFJNET do.
  jpathsep wd 8 u: 'mb save6 ',y
else.
  jpathsep wd 8 u: 'mbsave ',y
end.
)
wdclippaste=: (wd bind 'clippaste') :: (''"_)
wdqchildxywh=: (0 ". [: wd 'qchildxywh ' , ]) :: (0 0 0 0"_)
wdqchildxywhx=: (0 ". [: wd 'qchildxywhx ' , ] ) :: (0 0 0 0"_)
wdqcolor=: (0 ". [: wd 'qcolor ' , ":) :: ( 0 0 0"_)
wdqd=: (wd bind 'qd') :: (''"_)
wdqer=: (wd bind 'qer') :: (''"_)
wdqformx=: (0 ". wd bind 'qformx') :: (0 0 800 600"_)
wdqform=: (0 ". wd bind 'qformx') :: (0 0 800 600"_)
wdqhinst=: (0 ". wd bind 'qhinst') :: (0"_)
wdqhwndc=: (0 ". [: wd 'qhwndc ' , ]) :: (0"_)
wdqhwndp=: (0 ". wd bind 'qhwndp') :: (0"_)
wdqhwndx=: (0 ". wd bind 'qhwndx') :: (0"_)
wdqm=: (0 ". wd bind 'qm') :: (800 600 8 16 1 1 3 3 4 4 19 19 0 0 800 570"_)
wdqp=: (wd bind 'qp') :: (''"_)
wdqprinters=: (wd bind 'qprinters') :: (''"_)
wdqpx=: (wd bind 'qpx') :: (''"_)
wdqq=: (wd bind 'q') :: (''"_)
wdqscreen=: (0 ". wd bind 'qscreen') :: (264 211 800 600 96 96 32 1 _1 36 36 51"_)
wdqwd=: (wd bind 'qwd')
readimg_jnet_=: 11!:3000
getimg_jnet_=: 11!:3001
writeimg_jnet_=: 11!:3002
putimg_jnet_=: 11!:3003
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

18!:4 <'base'

3 : 0''
if. 0=4!:0<'DISPLAYLOAD_j_' do.
  DISPLAYLOAD_j_=: 1
  IFJIJX_j_=: 1
else.
  DISPLAYLOAD_j_=: 0
end.

load '~addons/ide/jnet/gl2.ijs'
load '~addons/ide/jnet/util/jijs.ijs'
load '~addons/ide/jnet/util/cfgread.ijs'
configure_jcfg_ 0
if. -. IFJIJX_j_ do. newijx_jijs_ 0 end.
EMPTY
)
