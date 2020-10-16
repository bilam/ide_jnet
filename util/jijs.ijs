coclass 'jijs'

coinsert 'j'

IFJAVA_z_=: 'jjava'-: (11!:0) :: 0: 'qwd'
IFWINCE_z_=: 7=9!:12''

EMPTY=: i.0 0
SMNAME=: ''
SMHWNDP=: ''
SMTORG=: ''
SMTEXT=: ''
SMPATH=: ''

SMSEL=: ''
SMINIT=: 0 0 700 500
SMSIZE=: 700 500
QFORMX=: SMINIT

FTYPES=: '"Scripts (*.ijs)|*.ijs|Session (*.ijx)|*.ijx|All Files (*.*)|*.*"'
IFMAX=: 0
IFREADONLY=: 0
IFSAVED=: 1
IFSHOW=: 0
IFIOX=: (0: ". wd) :: 0: 'qiox'

PPSCRIPT=: jpath '~system/util/pp.ijs'
sh=: 3 : 0
wd'psel jijs;pshow ',>y{'sw_hide';'sw_shownormal'
)
3 : 0''
if. 0 ~: 4!:0 <'IFJIJX_j_' do. IFJIJX_j_=: 0 end.
)

1!:5 :: ] < jpath '~temp'
3 : 0''
qm=. (0: ". wd) ::(800 600 8 16 1 1 3 3 4 4 19 19 0 0 800 570"_) 'qm'
if. (IFWIN+.IFJNET) > IFJAVA do.
  SMDESK=: 14 15 { qm
  SMBLK=: +/ <: 9 10 { qm
else.
  SMDESK=: (2 {. qm) - 0 33
  SMBLK=: 26
end.
)
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
intn=: i.@>: % ]
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))
pathname=: ({. ; }.)~ (0: i.~ +./\.@(=&PATHSEP_j_))
roundint=: <.@:+&0.5
todelim=: ; @: ((DEL&,) @ (,&DEL) @ , @ ": &.>)
tolist=: }. @ ; @: (LF&, @ , @ ": each)
sysmodifiers=: ''
ucpboxdraw=: 3 : 0
y=. ucp y
a=. ucp '┌┬┐├┼┤└┴┘│─'
b=. (16+i.11) { a.
x=. I. y e. b
(a {~ b i. x { y) x } y
)
checkreadonly=: 3 : 0
if. -. IFREADONLY do. 0 return. end.
msg=. 'The script is read only, so changes cannot be saved.'
msg=. msg,LF,LF,'Do you want to make it writable?'
if. 2 query msg do. 1 return. end.
0 [ setreadonly 0
)
close=: 3 : 0
if. IFIJX do.
  closeijx''
else.
  closeijs''
end.
)
closewindows=: 3 : 0
for_f. qsmallijs_jijs_'' do.
  smsel f
  smsave :: ] ''
  smclose ''
end.
smselact_jijs_ ''
)
closeijx=: 3 : 0
if. CONFIRMCLOSE do.
  if. wdquery 'Jsoftware';'Do you want to exit J?' do. return. end.
end.
fms=. wdforms''
fms=. fms #~ (<'jijs') = 3 {"1 fms
loc=. 2{"1 fms
for_lc. loc do.
  if. 0 = exitijs__lc :: 1: '' do. return. end.
end.
0!:101 :: ] SYS_TERMINATE
2!:55''
)
closeijs=: 3 : 0
if. iftempscript SMNAME do.
  if. 0 = #readid SMHWNDP do.
    1!:55 :: ] <SMNAME
  else.
    save 2
  end.
else.
  if. 2 = save 0 do. 0 return. end.
end.
destroy''
)
exitijs=: 3 : 0
if. iftempscript SMNAME do.
  if. 0 = #readid SMHWNDP do.
    1!:55 :: ] <SMNAME
  else.
    save 2
  end.
else.
  save 1
end.
1
)
clearijx=: 3 : 0
fms=. wdforms''
pid=. >1{ {. fms #~ (<'jijx') = 3 {"1 fms
wd 'psel ',pid, ';set',(IFJNET#'text'),' e'
)
getactsize=: 3 : 0
wd 'psel ',qsmact''
0 ". wd 'qformx'
)
getformx=: 3 : 0
res=. i. 0 4
for_i. y do.
  wd 'psel ',>i
  res=. res, 0 ". wd 'qformx'
end.
)
getsaveas=: 3 : 0

fn=. SMNAME, (0=#SMNAME) # jpath '~temp'

while. 1 do.
  'p f'=. pathname fn

  j=. FTYPES,' ofn_nochangedir'

  fn=. mbsave '"Save As" "',p,'" "',f,'" ',j

  if. 0=#fn do. return. end.
  if. -. '.' e. fn do. fn=. fn,'.ijs' end.
  if. fn -: SMNAME do. return. end.
  if. 0=flexist fn do. return. end.

  j=. fn,LF,'This file already exists.',LF,LF
  msg=. j,'Replace existing file?'

  if. 0=2 query msg do. fn return. end.
end.

)
getscrollpos=: 3 : 0
try.
  0 pick 'user32 SendMessageA i i i i i' (15!:0) y;206;0;0
catch.
  0
end.
)
ifshiftkey=: 3 : 0
'1' e. sysmodifiers
)
iftempscript=: 3 : 0
name=. 1 pick pathname y
_1 ~: _1 ". (name i: '.') {. name
)
info=: 3 : 0
wdinfo 'Jsoftware';y
)
marksavedid=: 3 : 0
wd 'psel ',y
wd 'setmodified e 0'
)
nounrep=: 4 : 0
dat=. y
if. (0=#dat) +. 2=3!:0 dat do.
  if. LF e. dat do.
    dat=. dat, LF -. {:dat
    x,'=: 0 : 0', LF, ; <;.2 dat,')',LF
  else.
    x,'=: ',(quote dat),LF
  end.
else.
  x,'=: ',(":dat),LF
end.
)
parentname=: 3 : 0
sn=. (-.+./\.SMNAME='/') # SMNAME
select. SMSTYLE
case. 0 do.
  n=. sn
case. 1 do.
  n=. SMNAME
case. 2 do.
  n=. sn,' - ',SMNAME
case. 3 do.
  n=. sn,'  []',(-.IFWINCE)#' ',SMNAME
end.
'pn *',n
)
pmovex=: 4 : 0
for_i. x do.
  wd 'psel ', >i
  wd 'pshow sw_shownormal'
  wd 'pmovex ', ": i_index{y
end.
)
query=: 4 : 0
x wdquery 'Jsoftware';y
)
readid=: 3 : 0
wd 'psel ',y
dat=. wd 'qd'
ndx=. ({."1 dat) i. <,'e'
1 pick ndx { dat
)
readid16=: ucp @ readid
readonlydefault=: 3 : 0
if. IFWINCE +. READONLY=2 do. 0 return. end.
if. READONLY=0 do. 1 return. end.
y=. jpathsep@filecase jpathsep y
ins=. filecase jpath '~install/'
if. -. ins -: (#ins) {. y do. 0 return. end.
tmp=. filecase jpath '~temp/'
usr=. filecase jpath '~user/'
(tmp -: (#tmp) {. y) +: usr -: (#usr) {. y
)
saveopenwindows=: 3 : 0
for_f. qsmallijs '' do.
  smsel f
  smsave ''
end.
)
setpnall=: 3 : 0
for_lc. 2 {"1 qsmallforms'' do.
  wd 'psel ',":SMHWNDP__lc
  wd parentname__lc ''
end.
)
setreadonly=: 3 : 0
if. IFWINCE +. IFIJX do. return. end.
b=. ":IFREADONLY=: y
wd 'psel ',":SMHWNDP
wd 'setreadonly e ',b
wd 'set editreadonly ',b
a=. 'minus plus plusline1 plusline2 lower upper'
a=. ;: a,' toggle sort wrap'
a=. ;(<';setenable sel') ,each a ,each <' ',":-.IFREADONLY
wd a
)
togglebox=: 3 : 0
boxdraw -. '+' e. 9!:6''
)
togglereadonly=: 3 : 0
setreadonly -.IFREADONLY
)
togglexs=: 3 : 0
smfocus smsel qsmlastxs ''
)
winmax=: 3 : 0
if. (IFWIN+.IFJNET) > IFJAVA do.
  ids=. qsmall''
  sfx=. IFMAX pick 'maximized';'normal'
  wd ; (<'psel ') ,each ids ,each <(';pshow sw_show',sfx,';')
else.
  fms=. qsmallforms''
  ids=. 1 {"1 fms
  loc=. 2 {"1 fms
  if. IFMAX do.
    qf=. i. 0 4
    for_lc. loc do.
      qf=. qf, QFORMX__lc
    end.
    wd ; (<';psel ') ,each ids ,each <"1 ';pmovex ',"1 ": qf
  else.
    for_lc. loc do.
      QFORMX__lc=: 0 ". wd 'psel ',(lc_index pick ids),';qformx'
    end.
    wd ; (<';psel ') ,each ids ,each (<';pmovex ',": 0 0,SMDESK)
  end.
end.
IFMAX_jijs_=: -.IFMAX
SMSEL_jijs_=: _1 pick ids
smfocus_jijs_''
)
ide_maximize=: 3 : 0
wd ; ('psel '&,@(,&';pshow sw_showmaximized;')) each qsmall''
)
ide_minimize=: 3 : 0
wd ; ('psel '&,@(,&';pshow sw_showminimized;')) each qsmall''
)
ide_restore=: 3 : 0
wd ; ('psel '&,@(,&';pshow sw_restore;')) each qsmall''
)
SCMP=: 0 : 0
pc6j scmp owner;
xywh 4 2 50 12;cc original radiobutton;cn "Original";
xywh 54 2 50 12;cc current radiobutton group;cn "Current";
xywh 199 1 50 12;cc revert button leftmove rightmove;cn "Revert";
xywh 249 1 50 12;cc close button leftmove rightmove;cn "Close";
xywh 0 14 300 225;cc etext editm ws_border ws_vscroll es_readonly rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
scmp_run=: 3 : 0
locSM=: y
smsel SMNAME
SMTNOW=: smread''
SMTRVT=: 0
wd SCMP
HWNDP=: wd 'qhwndp'
wd 'setfont etext ',FIXFONT_j_
if. SMTORG -: SMTEXT do.
  wd 'set original 1;set current 0;setenable current 0'
else.
  wd 'set original 0;set current 1;'
end.
scmp_show 1
wdfit''
wd 'pshow'
)
scmp_close=: 3 : 0
wd 'pclose'
codestroy''
)
scmp_revert_button=: 3 : 0
sel=. 0 ". current
if. SMTRVT -: 0 do.
  SMTRVT=: SMTNOW
  SMTNOW=: sel pick SMTORG;SMTEXT
else.
  SMTNOW=: SMTRVT
  SMTRVT=: 0
end.
smsel SMNAME
smwrite SMTNOW
wd 'psel ',HWNDP
scmp_show sel
)
scmp_show=: 3 : 0
r=. 'comparing: ',LF,SMNAME,LF
r=. r, (y pick SMTORG;SMTEXT) compare SMTNOW
wd 'set etext *',r
)
scmp_close_button=: scmp_cancel=: scmp_close
scmp_original_button=: scmp_show bind 0
scmp_current_button=: scmp_show bind 1
runcompare=: 3 : 0
loc=. coname''
a=. cocreate''
coinsert__a loc
scmp_run__a loc
)
create=: 3 : 0

SMNAME=: jpathsep y
IFIJX=: '.ijx' -: _4 {. SMNAME

if. IFIJX do.
  ndx=. 6 + ('editijs' E. JIJS) i.1
  bf=. 'x' ndx } JIJS
  nolint=. 1
else.
  nolint=. 3 ~: 4!:0 <'lint_lint_'
  bf=. JIJS
end.

if. -. IFWINCE do.
  if. # wd 'qpx' do.
    topleft=. getcascade''
    bf=. bf,'pmovex ',": topleft, SMSIZE
  else.
    bf=. bf,'pmovex ',": SMINIT
  end.
end.

if. nolint do.
  bf=. ('menu runlint' i.&1@:E. bf) ({. , (}.~ LF&(i.&1@:E.))@}.) bf
end.

if. IFIJX do.
  txt=. ''
  if. -. IFWINCE do.
    bf=. bf, ';setenable editlint 0;setenable editformedit 0'
    bf=. bf, ';setenable runwindow 0;setenable runwindowd 0'
  end.
  bf=. bf, ';pgroup jijx'
else.
  if. IFSAVED=: -. flexist SMNAME do.
    '' flwrite SMNAME
  end.
  SMTEXT=: SMTORG=: utf8 flread SMNAME
  txt=. SMTEXT
  IFREADONLY=: (0<#txt) *. readonlydefault SMNAME
  bf=. bf, ';pgroup jijs'
  recent_put SMNAME
end.

bf=. bf, ';setfont e ',FIXFONT
bf=. bf, ';setfocus e;qhwndp'
SMHWNDP=: wd bf
smsel SMHWNDP

wd parentname''

if. #txt do.
  wd 'set e *', txt
  wd 'setmodified e 0'
end.

setreadonly IFREADONLY

if. IFIJX do.
  wd 'setenable close 0'
else.
  wd 'setenable fileexit 0'
end.
if. IFSHOW = 0 do.
  IFSHOW_jijs_=: 1
  if. ARGV -: ,<'undefined' do. return. end.
end.

if. -.IFJNET do.
  wd 'setenable labs 0'
  wd 'setenable labadvance 0'
  wd 'setenable labchapters 0'
end.

if. -.IFIOX do.
  wd 'pshow'
  if. IFWINCE do.
    wd 'setsip ',":SHOWSIP
  end.
end.

)
destroy=: 3 : 0
wd :: ] 'psel ',SMHWNDP,';pclose'
codestroy''
)
aboutj=: 3 : 0
r=. 'J',}.(i.&'/'{.])9!:14''
r=. r,' - Copyright 1994-2016 Jsoftware Inc., www.jsoftware.com.'
r=. r,LF,LF,JVERSION
r=. r,LF,LF,'This computer program is protected by copyright law and international treaties.'
)
getcascade=: 3 : 0
getcascade1 (1 {"1 wdforms'');SMSIZE
)
getcascade1=: 3 : 0
'fms size'=. y
if. 0 = #fms do. 0 0 return. end.
len=. 1 + 0 >. <. <./ (SMDESK - size) % SMBLK
bgn=. (SMBLK * i.len) - -: SMBLK
end=. bgn + SMBLK
res=. 2 {."1 getformx fms
res=. res #~ *./"1 res < {: end
x=. {."1 res
y=. {:"1 res
x=. (i.<./) +/ (x >/ bgn) *. x </ end
y=. (i.<./) +/ (y >/ bgn) *. y </ end
SMBLK * x,y
)
getcascades=: 3 : 0
len=. 1 + 0 >. <. <./ (SMDESK - SMSIZE) % SMBLK
SMBLK * len | i. y
)
3 : 0''
if. IFUNIX do.
  filecase=: [
else.
  filecase=: tolower
end.
0
)
flerase=: [: 1!:55 ::] <
flexist=: 1:@(1!:4)@< :: 0:
flread=: 3 : 'toJ 1!:1 <y'
flwrite=: 4 : '(toHOST x) 1!:2 <y'
flopen=: 3 : 0
0 flopen y
:
if. 1e8< sz=. 1!:4 boxopen y do. wdinfo 'file size too large' return. end.
if. +./(1!:11 (>y);0,1e5<.sz) e.~ (32{.a.)-.TAB,LF,CR,FF do. wdinfo 'binary file' return. end.
smopen > y
smscroll x
smfocus ''
)
openijs=: 3 : 0
ifnew=. 0

if. y -: 'temp' do.
  if. 'ijx' -: _3 {. SMNAME do.
    p=. SMPATH
  else.
    p=. 0 pick pathname SMNAME
  end.
else.
  p=. ''
end.

if. 0 = #p do. p=. jpath '~',y end.

j=. FTYPES,' ofn_nochangedir'
while. 1 do.
  f=. mbopen '"Open File" "',p,'" "" ',j
  if. 0 = #f do. '' return. end.
  p=. 0 pick pathname f
  if. -. flexist f do.
    f=. extijs f
    if. -. flexist f do.
      try.
        '' flwrite f
        ifnew=. 1
      catch.
        info 'Cannot create file: ',f continue.
      end.
    end.
  end.
  break.
end.
SMPATH=: 0 pick pathname f
flopen f
if. -. ifnew do. return. end.
loc=. id2loc name2id f
setreadonly__loc 0
)
save=: 3 : 0
sel=. {. y , 1
new=. readid SMHWNDP
if. SMTEXT -: new do. 1 return. end.
if. checkreadonly'' do. return. end.
if. (sel=0) +. (sel=1) *. IFSAVED=0 do.
  q=. 3 query 'Save changes to ',SMNAME,'?'
  if. q do.
    (1 2 i. q) { 0 2 return.
  end.
end.
new flwrite SMNAME
recent_put SMNAME
marksavedid SMHWNDP
SMTEXT=: new
IFSAVED=: 1
)
saveas=: 3 : 0
fn=. getsaveas''
if. #fn do.
  SMNAME=: jpathsep fn
  new=. readid SMHWNDP
  new flwrite SMNAME
  recent_put SMNAME
  SMTEXT=: new
  IFSAVED=: 1
  wd parentname ''
end.
)
a=. '0123456789acfhilrstAFCS'
fkeycase=: 'F'"_ , (('acs',a)"_ i. }.) { ('ACS',a)"_
set_fkeys=: 3 : 0
FKEYS=: boxfkeys y
)
boxfkeys=: 3 : 0
if. 0 = #y do. i.0 4 return. end.
dat=. y, LF -. {:y
ndx=. a. i. dat
if. 1 e. 126 < ndx do.
  if. 1 e. 126 < ndx -. 197 do.
    ,:'f12';'1';'Toggle IJX|Last IJS';'togglexs_jijs_'''''
  else.
    <;._1 &> (197{a.) ,each <;._2 dat
  end.
else.
  ". &> <;._2 dat
end.
)
unboxfkeys=: 3 : 0
if. 0 = #y do.
  ''
else.
  sep=. LF,~(<:{:$y)#';'
  tolist <@;"1 (quote each y) ,each"1 sep
end.
)
fkeyrun=: 3 : 0
ndx=. ({."1 FKEYS) i. <y
if. ndx = # FKEYS do. empty '' return. end.
'sty cmd'=. 1 3 { ndx { FKEYS
select. {. sty
case. '0' do.
  smprompt cmd
case. '1' do.
  runimmx0 cmd
case. '2' do.
  runimmx1 cmd
end.
)
fkeyselect=: 3 : 0
if. 0 e. #FKEYS do.
  info 'No fkeys are defined. See menu Edit|Configure|FKeys' return.
end.
pik=. fkeylist FKEYS
sel=. pik;'';'FKeys';'fkeyselect1';1 45
sel conew 'jpick'
)
fkeylist=: 3 : 0
nos=. fkeycase each 0 {"1 y
sep=. TAB
nos ,each sep ,each 2 {"1 y
)
fkeyselect1=: 3 : 0
if. #y do.
  fkeys (<y;0) pick FKEYS
end.
)
tofoldername=: 3 : 0
if. 0=#y do. '' return. end.
folders=. SystemFolders,UserFolders
pds=. {."1 folders
pps=. {:"1 folders
pps=. filecase each jpath each pps ,each PATHSEP
ndx=. \: # &> pps
pds=. ndx{pds
pps=. ndx{pps
res=. jpathsep@filecase each boxxopen y
len=. # &> pps
for_i. i.#res do.
  nam=. i pick res
  if. '~' = {. nam,'~' do. continue. end.
  msk=. pps = len {. each <nam
  if. 1 e. msk do.
    ndx=. ((i. >./) msk # len) { I. msk
    nam=. ('~', > ndx { pds),(<: ndx { len) }. nam
    res=. (<nam) i } res
  end.
end.
pps=. }: each pps
ndx=. 1 + pps i: &> PATHSEP
msk=. ndx < len
pps=. msk # ndx {.each pps
pds=. msk # pds
len=. # &> pps
for_i. i.#res do.
  nam=. i pick res
  if. '~' = {. nam,'~' do. continue. end.
  if. PATHSEP = {. nam do. continue. end.
  msk=. pps = len {. each <nam
  if. 1 e. msk do.
    ndx=. ((i. >./) msk # len) { I. msk
    nam=. ('~.', > ndx { pds),(<: ndx { len) }. nam
    res=. (<nam) i } res
  end.
end.
res
)
resizefont=: 3 : 0
if. y = 0 do. return. end.
require 'font'
siz=. getfontsize FIXFONT
if. y < 0 do.
  siz=. (siz - 1) <. <. 0.5 + siz % 1 - 0.1 * y
else.
  siz=. (siz + 1) >. <. 0.5 + siz * 1 + 0.1 * y
end.
setfontall FIXFONT_z_=: siz setfontsize FIXFONT
)
restorefont=: 3 : 0
setfontall FIXFONT_z_=: FIXFONTDEF
)
setfontall=: 3 : 0
for_id. qsmall''do.
  wd 'psel ',> id
  wd 'setfont e ',y
end.
)
getfile=: 3 : 0
path=. jpath '~home'
t=. '"Select File" "',path,'" "" '
t=. t,'"Scripts (*.ijs)|*.ijs|All Files (*.*)|*.*"'
t=. t,' ofn_filemustexist ofn_pathmustexist;'
mbopen t
)
getline=: 3 : 0
smselact''
txt=. smread''
pos=. {. smgetsel''
ndx=. pos + <./ (pos }. txt) i. CRLF
txt=. ndx {. txt
ndx=. - <./ (|. txt) i. CRLF
ndx {. txt
)
getselection=: 3 : 0
smselact''
txt=. smread''
'b e'=. 2 $ smgetsel''
b }. e {. txt
)
lint=: 3 : 0
if. IFIJX do. return. end.
require PPSCRIPT
old=. e
sel=. {. 0 ". e_select
crs=. +/ LF = sel {. old
new=. pplint_jpp_ old
if. 0 = #new do. return. end.
if. L. new do.
  'lin msg'=. new
  wd 'setscroll e ',":0 >. lin - 10
  pos=. 1 0 + (+/\LF = old) i. lin + 0 1
  wd 'setselect e ',":pos,1
  wdinfo 'Format Script';msg
  return.
end.
if. -. new -: old do.
  old=. sel {. old
  chr=. +/ -. (TAB,' ') e.~ (1 + old i: LF) }. old
  spc=. (*chr) *. ' ' = {: old
  ndx=. crs { 0, 1 + I. LF = new
  sel=. ndx + chr i.~ 0, +/\ -. (TAB,' ') e.~ ndx }. new
  sel=. sel + spc * LF ~: {. sel }. new
  sel=. sel <. <:#new
  wd 'set e *',new
  wd 'setscroll e ',": {: 0 ". e_scroll
  wd 'setselect e ',":sel,sel,0
end.
)
new=: 3 : 0
n=. conew 'jijs'
d=. 1!:0 jpath '~temp/*.',y
a=. 0, {.@:(0&".)@> _4 }. each {."1 d
a=. ": {. (i. >: #a) -. a
create__n jpath '~temp/',a,'.',y
setreadonly__n 0
)
newijs=: 3 : 0
new 'ijs'
)
newijx=: 3 : 0
new 'ijx'
if. IFWINCE < y -: 0 do.
  if. (NEWUSER = 1) *. 1 = #ARGV do.
    load '~addons/ide/jnet/newuser.ijs'
  end.
end.
)
comparesvn=: 3 : 0
smselact''
smsave''
nam=. id2name SMSEL
msk=. +./\. nam=PATHSEP
pth=. msk # nam
bal=. (-.msk) # nam
svn=. pth,'.svn/text-base/',bal,'.svn-base'
txt=. 1!:1 :: 0: <svn
if. txt -: 0 do.
  wdinfo 'Unable to read: ',svn
else.
  require 'jview'
  wdview fcompare svn;nam
end.
)
RECENTFILE=: jpath '~config/recent.ijs'
RECENTMAX=: 20
RECENTLOC=: <''
JRECENT=: 0 : 0
pc6j jrecent;pn "Recent Scripts";
xywh 3 3 175 130;cc lb listbox ws_vscroll rightmove bottommove;
xywh 182 4 52 11;cc open button bs_defpushbutton leftmove rightmove;cn "&Open";
xywh 182 17 52 11;cc view button leftmove rightmove;cn "&View";
xywh 182 30 52 11;cc run button leftmove rightmove;cn "&Run";
xywh 182 43 52 11;cc rund button leftmove rightmove;cn "Run &Display";
pas 3 3;pcenter;
rem form end;
)
jrecent_run=: 3 : 0
wd JRECENT
HWNDP=: wd 'qhwndp'
wpset 'jrecent'
wd 'set lb ',todelim tofoldername y
wd 'setselect lb 0'
wd 'setfocus lb'
wd 'pshow'
)
jrecent_close=: 3 : 0
try.
  wd 'psel ',HWNDP
  wpsave 'jrecent'
  wd 'pclose'
catch. end.
RECENTLOC_jijs_=: <''
codestroy ''
)
jrecent_open_button=: 3 : 0
if. #lb do.
  lb=. jpath lb
  if. 0 = ifshiftkey'' do. jrecent_close'' end.
  runimmx0_jijs_ 'smopen_jijs_ ' , quote lb
end.
)
jrecent_view_button=: 3 : 0
require 'jview'
if. #lb do.
  lb=. jpath lb
  if. 0 = ifshiftkey'' do. jrecent_close'' end.
  runimmx0 'wdview 1!:1 < ' , quote lb
end.
)
jrecent_run_button=: 3 : 0
if. #lb do.
  lb=. jpath lb
  if. 0 = ifshiftkey'' do. jrecent_close'' end.
  runimmx1 'load ' , quote lb
end.
)
jrecent_rund_button=: 3 : 0
if. #lb do.
  lb=. jpath lb
  if. 0 = ifshiftkey'' do. jrecent_close'' end.
  runimmx1 'loadd ' , quote lb

end.
)
jrecent_enter=: jrecent_lb_button=: jrecent_open_button
jrecent_cancel=: jrecent_close
recent_run=: 3 : 0
if. 0 e. #RECENT do.
  info 'No recent files'
elseif. RECENTLOC e. conl 1 do.
  wd 'psel ',HWNDP__RECENTLOC
  wd 'pshow'
elseif. do.
  a=. conew 'jijs'
  RECENTLOC_jijs_=: a
  jrecent_run__RECENTLOC RECENT
end.
)
recent_open=: 3 : 0
if. #y do.
  smopen y pick RECENT
end.
)
recent_put=: 3 : 0
if. iftempscript y do. return. end.
y=. boxxopen y
if. -. IFUNIX do.
  y=. tolower each y
end.
new=. ~. y, RECENT
new=. (RECENTMAX <. #new) {. new
if. new -: RECENT do. return. end.
recent_save RECENT_jijs_=: new
)
recent_read=: 3 : 0
try.
  0!:100 (1!:1) <RECENTFILE
  RECENT=: LF cutopen RECENT
catch.
  RECENT=: ''
end.
)
recent_save=: 3 : 0
dat=. 'NB. Recent Scripts',LF
dat=. dat,LF,'RECENT' nounrep tolist RECENT
dat=. toHOST dat
dat 1!:2 <RECENTFILE
)
runimmx0=: 3 : 0
IMMX_jijs_=: utf8 y
9!:27 '0!:100 IMMX_jijs_'
9!:29 [ 1
)
runimmx1=: 3 : 0
IMMX_jijs_=: utf8 y
9!:27 '0!:101 IMMX_jijs_'
9!:29 [ 1
)
runfile=: 3 : 0
f=. getfile $0
if. #f do.
  fn=. 'load',(1 = 1 {. y)#'d'
  runimmx1 fn, ' ' , quote f
end.
)
runline=: 3 : 0
runimmx1 getline''
)
runselection=: 3 : 0
runimmx1 getselection''
)
runwindow=: 3 : 0
if. IFIJX do. return. end.
save 1
fn=. 'load',(1 = 1 {. y)#'d'
runimmx1 fn, ' ' , quote SMNAME
)
runlint=: 3 : 0
if. IFIJX do. return. end.
save 1
runimmx1 'lint ' , quote SMNAME
)
set_skeys=: 3 : 0
if. 0 = #y do. return. end.
dat=. <;._2 y
ndx=. dat i. &> ' '
nam=. ndx {.each dat
key=. (ndx+1) }.each dat
frm=. <;._2 JIJS
ndx=. 5 + (5 }.each frm) i. &> ' '
sel=. ndx {. each frm
ind=. sel i. (<'menu ') ,each nam
msk=. ind < #frm
if. 0 e. msk do.
  ind=. msk # ind
  key=. msk # key
end.
new=. key set_skey1 each ind { frm
frm=. new ind } frm
JIJS=: ; frm ,each LF
)
set_skey1=: 4 : 0
txt=. 4 }. y
sep=. (txt = ' ') > ~:/\ txt = '"'
'id cp sc tt sh'=. 5 {. sep <;.1 txt
sc=. ' "',x,'"'
key=. getskey x
('jijs_',key,'_fkey')=: ('jijs_',(id-.' '),'_button')~
'menu', ;id;cp;sc;tt;sh
)
getskey=: 3 : 0
ndx=. y i: '+'
tolower '+ ' -.~ (ndx }. y), ndx {. y
)
boxskeys=: 3 : 0
if. 0 = #y do.
  i.0 2
else.
  dat=. <;._2 y
  ndx=. dat i. &> ' '
  (ndx {.each dat) ,. (ndx+1) }.each dat
end.
)
unboxskeys=: 3 : 0
if. 0 = #y do.
  ''
else.
  nam=. {."1 y
  key=. {:"1 y
  tolist nam ,each ' ' ,each key
end.
)
getSMSEL=: 3 : 0
if. -. (<SMSEL) e. 1 {"1 wdforms'' do.
  smsel ''
end.
SMSEL
)
id2loc=: 3 : 0
fms=. wdforms''
ndx=. (1 {"1 fms) i. boxopen y
if. ndx < #fms do.
  (<ndx;2) { fms
else.
  ''
end.
)
id2names=: 3 : 0
fms=. wdforms''
ndx=. ,(1 {"1 fms) i. boxxopen y
ind=. I. ndx < #fms
nms=. (#ndx) # <''
for_i. ind do.
  loc=. 2 { (i{ndx) { fms
  nms=. (<SMNAME__loc) i } nms
end.
)
id2name=: > @ {. @ id2names
id2type=: 3 : 0
fms=. wdforms''
ndx=. (1 {"1 fms) i. boxopen y
if. ndx < #fms do.
  > (<ndx;3) { fms
else.
  ''
end.
)
name2id=: 3 : 0
fms=. wdforms''
fms=. fms #~ (3 {"1 fms) e. 'jijs';'jijx'
fid=. tolower > y
if. 0 = #fid do. return. end.
if. (<fid) e. 1 {"1 fms do. return. end.
for_loc. 2 {"1 fms do.
  if. fid -: tolower SMNAME__loc do.
    1 pick loc_index { fms return.
  end.
end.
''
)
qsmact=: 3 : 0
fms=. wdforms''
b=. (3 {"1 fms) e. 'jijs';'jijx'
fms=. b # fms
last=. 0 ". > 4{"1 fms
ndx=. last i. >./last
(<ndx;1) pick fms
)
qsmall=: 3 : 0
fms=. wdforms''
msk=. ('jijs';'jijx') e.~ 3 {"1 fms
fms=. msk # fms
(1 {"1 fms) /: 0 ". > 4{"1 fms
)
qsmallforms=: 3 : 0
fms=. wdforms''
msk=. ('jijs';'jijx') e.~ 3 {"1 fms
fms=. msk # fms
fms /: 0 ". > 4{"1 fms
)
qsmallijs=: 3 : 0
fms=. wdforms''
msk=. (<'jijs') = 3 {"1 fms
msk # 1 {"1 fms
)
qsmsize=: 3 : 0
wd 'psel ',SMSEL
0 ". wd 'qformx'
)
qsmlastijs=: 3 : 0
fms=. wdforms''
b=. (3 {"1 fms) e. <'jijs'
if. 0 = +/b do. '' return. end.
fms=. b # fms
last=. 0 ". > 4 {"1 fms
1 pick {. fms \: last
)
qsmlastxs=: 3 : 0
fms=. wdforms''
b=. (3 {"1 fms) e. 'jijs';'jijx'
fms=. b # fms
last=. 0 ". > 4 {"1 fms
fms=. fms \: last
if. (<'jijs') = 3 { {. fms do.
  ndx=. (3 {"1 fms) i. <'jijx'
else.
  ndx=. 1
end.
ndx=. ndx <. <: #fms
(<ndx;1) pick fms
)
qsmout=: 3 : 0
fms=. wdforms''
ind=. (3 {"1 fms) i. <'jijx'
(<ind;1) pick fms
)
smappend=: 3 : 0
txt=. smread ''
smwrite txt,y
)
smclose=: 3 : 0
getSMSEL''
if. #SMSEL do.
  loc=. id2loc SMSEL
  destroy__loc ''
  smsel ''
end.
)
smfocus=: 3 : 0
wd 'psel ',SMSEL
wd 'pactive'
wd 'setfocus e'
)
smfocusact=: smfocus @ smselact
smfocusout=: smfocus @ smselout
smgetsel=: 3 : 0
wd 'psel ',SMSEL
dat=. wd 'qd'
ndx=. ({."1 dat) i. <'e_select'
0 ". 1 pick ndx { dat
)
smopen=: 3 : 0
id=. name2id y
if. 0 = #id do.
  a=. conew 'jijs'
  create__a y
else.
  smsel id
  wd 'psel ',SMSEL
end.
wd 'setfocus e'
empty''
)
smmove=: 3 : 0
wd 'psel ',SMSEL
wd 'pmovex ',": y
)
smprompt=: 3 : 0
'txt def'=. 2 {. boxxopen y
smsel qsmout''
wd 'psel ',SMSEL
dat=. wd 'qd'
ndx=. ({."1 dat) i. <,'e'
ses=. 1 pick ndx { dat
ses=. ses, (LF ~: _1 {. ses) # LF
ses=. ses,utf8 txt
wd 'set e *',ses,def
wd 'setselect e ',": ((#ses)+0,#def), 1
)
smread=: 3 : 0
readid16 SMSEL
)
smreplace=: 3 : 0
wd 'psel ',SMSEL
wd 'setreplace e *',utf8 y
)
smsave=: 3 : 0
getSMSEL''
if. #SMSEL do.
  loc=. id2loc SMSEL
  save__loc 2
end.
)
smscroll=: 3 : 0
wd 'psel ',SMSEL
loc=. id2loc SMSEL
txt=. SMTEXT__loc
if. (y=0) +. 0=#txt do.
  wd 'setselect e 0 0 0' return.
end.
len=. #;.2 ucp txt,LF
pos=. +/ (y <. #len) {. len
wd 'setselect e ',": pos,pos,0
)
smsel=: 3 : 0
empty SMSEL_jijs_=: name2id , > y
)
smselact=: smsel @ qsmact
smselout=: smsel @ qsmout
smsetcmd=: 3 : 0
cmd=. 4 {. y
def=. cmd , FKEYS
FKEYS=: sort (~: {."1 def) # def
)
smsetselect=: 3 : 0
wd 'psel ',SMSEL
wd 'setselect e ',": y
)
smsetsaved=: 3 : 0
loc=. id2loc SMSEL
IFSAVED__loc=: 1
)
smwrite=: 3 : 0
wd 'psel ',SMSEL
wd 'set e *',utf8 y
)
select_line=: 3 : 0

if. IFREADONLY do. return. end.

smselact''
txt=. smread ''
'bgn end'=. oldsel=. smgetsel ''

if. 0 = #txt do.
  wdinfo 'Selection';'No text selected' return.
end.

sel=. bgn }. end {. txt
ndx=. LF i.~ |. bgn {. txt
bgn=. bgn - ndx
if. LF ~: {: sel do.
  txt=. txt, LF
  ndx=. 1 + LF i.~ end }. txt
  end=. end + ndx
end.

sel=. bgn }. end {. txt

csl=. <;.2 sel

select. y
case. 'minus' do.
  msk=. -. (8 {. each csl) e. 'NB. ----';'NB. ===='
  csl=. msk # csl
  msk4=. (<'NB. ') = 4 {. each csl
  msk3=. msk4 < (<'NB.') = 3 {. each csl
  new=. ; ((msk4 * 4) + msk3 * 3) }. each csl
  set=. bgn + 0, <: #new
case. 'plus' do.
  msk=. 1 < # &> csl
  hdr=. (3 + msk) {. each <'NB.'
  new=. ; hdr ,each csl
  set=. bgn + 0, <: #new
case. 'plusline1' do.
  cmt=. 'NB. ',(57#'-'),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'plusline2' do.
  cmt=. 'NB. ',(57#'='),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'sort' do.
  new=. ; /:~ csl
  set=. bgn + 0, <: #new
end.

if. -. new -: sel do.
  smsetselect bgn, end
  smreplace new
  smsetselect set <. <: #smread''
end.

)
select_text=: 3 : 0

if. IFREADONLY do. return. end.

smselact''
txt=. smread ''
'bgn end'=. smgetsel ''

if. bgn = end do.
  wdinfo 'Selection';'No text selected' return.
end.

sel=. bgn }. end {. txt
select. y
case. 'lower' do.
  new=. tolower sel
case. 'toggle' do.
  lwr=. a. {~ (i.26) + a. i. 'a'
  upr=. a. {~ (i.26) + a. i. 'A'
  ndx=. (lwr,upr,a.) i. sel
  new=. ndx { upr,lwr,a.
case. 'upper' do.
  new=. toupper sel
case. 'wrap' do.
  new=. 61 foldtext sel
end.

if. -. new -: sel do.
  smreplace new
  smsetselect bgn + 0,#new
end.

)
cleartemp=: 3 : 0
par=. 'Delete Temporary Files'
msg=. 'This deletes everything under ~temp, except files'
msg=. msg,' that are currently in use.'
msg=. msg,LF,LF,'OK to continue?'
if. 0 wdquery par;msg do.
  wdinfo par;'Not done.' return.
end.
require 'dir'
p=. filecase jpath '~temp/'
f=. (1:@(1!:55) :: 0:)"0
a=. jpathsep@filecase each {."1 dirtree p
a=. a -. jpathsep@filecase each id2name each qsmall ''
a=. a -. < jpathsep@filecase 9!:46''
m=. f a
a=. (#p) }. each (m=0) # a
a=. a #~ (<'jbreak/') ~: 7 {. each a
b=. jpathsep@filecase each dirpath p
b=. b -. (}:p);p,'jbreak'
m=. f b
b=. (#p) }. each (m=0) # b
c=. a,b
if. #c do.
  c=. ; LF ,each c
  wdinfo par;'Could not delete: ',LF,c
end.
EMPTY
)
cutpara=: 3 : 0
txt=. topara y
txt=. txt,LF -. {:txt
b=. (}.b,0) < b=. txt=LF
b <;._2 txt
)
foldtext=: 4 : 0
if. 0 e. $y do. '' return. end.
txt=. toJ y
len=. 1 + (txt ~: LF ) i: 1
lfs=. len }. txt
txt=. ; x foldpara each cutpara len {. txt
(}:txt), lfs
)
foldpara=: 4 : 0
if. 0=#y do. LF return. end.
r=. ''
x1=. >: x
txt=. y
while.
  ind=. ' ' i.~ |. x1{.txt
  s=. txt {.~ ndx=. x1 - >: x1 | ind
  s=. (+./\.s ~: ' ') # s
  r=. r, s, LF
  #txt=. (ndx + ind<x1) }. txt
do. end.
r
)
topara=: 3 : 0
txt=. toJ y
b=. txt=LF
c=. b +. txt=' '
b=. b > (1,}:b) +. }.c,0
txt=. ' ' (b#i.#b) } txt
)
tilecascade=: 3 : 0
ids=. qsmall''
pos=. getcascades_jijs_ #ids
ids pmovex (pos,.pos) ,"1 SMSIZE
)
tileacross=: 3 : 0
'ids x y w h'=. tileget''
len=. # ids
if. len = 0 do. return. end.
if. 4 > len do.
  xs=. x + roundint w * intn len
  xp=. }: xs
  wp=. (}. xs) - xp
  pos=. xp,.y,.wp,.h
else.
  pos=. ids tile2fit x,y,w,h
end.
ids pmovex pos
)
tile=: 3 : 0
'ids x y w h'=. tileget''
len=. # ids
if. len = 0 do. return. end.
if. 4 > len do.
  ys=. y + roundint h * intn len
  yp=. }: ys
  hp=. (}. ys) - yp
  pos=. x,.yp,.w,.hp
else.
  pos=. ids tile2fit x,y,w,h
end.
ids pmovex pos
)
tileget=: 3 : 0
ids=. |. qsmall''
len=. # ids
fmx=. getformx ids
xy=. 2 {."1 fmx
msk=. xy +./ . >: _10000
if. 0 e. msk do.
  ids=. msk # ids
  fmx=. msk # fmx
  xy=. msk # xy
end.
wh=. 2 }."1 fmx
'x y'=. <./ xy
'w h'=. (>./ xy + wh) - x,y
ids;x;y;w;h
)
rdist=: 3 : 0
r=. <.y
r + ((+/r) + \:/: 1|y) < <.0.5++/y
)
tile2fit=: 4 : 0
ids=. x
'x y w h'=. y
len=. #x
cls=. <. %: len
rws=. rdist cls # len % cls

nub=. ~. rws
wid=. rdist cls # w % cls
blk=. {.nub
cnt=. +/ rws = blk
col=. cnt {. wid

pos=. tile2fit1 x;y;w;h;blk;col

if. cnt < #rws do.
  x=. x + +/ col
  w=. w - +/ col
  col=. cnt }. wid
  blk=. {: nub
  pos=. pos, tile2fit1 x;y;w;h;blk;col
end.

)
tile2fit1=: 3 : 0
'x y w h rws wid'=. y
cls=. #wid
ys=. y + roundint h * intn rws
xp=. rws # x + 0, +/\ }: wid
yp=. (rws*cls) $ }: ys
wp=. rws # wid
hp=. (rws*cls) $ (}.-}:) ys
xp,.yp,.wp,.hp
)
JIJS=: 0 : 0
pc6j jijs;
menupop "&File";
menu filenewijs "&New ijs" "Ctrl+N" "" "";
menusep ;
menu fileopen "&Open..." "Ctrl+O" "" "";
menu fileopenuser "&Open User..." "Ctrl+H" "" "";
menu fileopensystem "&Open System..." "Ctrl+I" "" "";
menu filerecent "&Recent..." "Ctrl+G" "" "";
menusep ;
menu save "Save" "Ctrl+S" "" "";
menu saveas "Save &As..." "" "" "";
menu close "Close" "" "" "";
menusep ;
menu fileprint "&Print" "Ctrl+P" "" "";
menu fileprintsetup "Print Setup..." "" "" "";
menusep ;
menu fileexit "E&xit" "" "" "";
menupopz;
menupop "&Edit";
menu editundo "&Undo" "Ctrl+Z" "" "";
menu editredo "&Redo" "Ctrl+Y" "" "";
menusep ;
menu editcut "Cu&t" "Ctrl+X" "" "";
menu editcopy "&Copy" "Ctrl+C" "" "";
menu editpaste "&Paste" "Ctrl+V" "" "";
menusep ;
menu editselectall "Select &All" "Ctrl+A" "" "";
menusep ;
menu editreadonly "&Read Only" "Ctrl+T" "" "";
menusep ;
menu editfind "&Find..." "Ctrl+F" "" "";
menu editfif "Find &in Files..." "Ctrl+Shift+F" "" "";
menusep ;
menu editdirmatch "Directory &Match..." "" "" "";
menusep ;
menu editclearterm "Clear Terminal" "Ctrl+Shift+T" "" "";
menusep ;
menu editinputlog "Input &Log..." "Ctrl+D" "" "";
menusep ;
menu editlint "Format Script" "Ctrl+L" "" "";
menusep ;
menu editformedit "Form &Editor..." "" "" "";
menusep ;
menu editconfigure "Confi&gure..." "" "" "";
menu editbasecfg "base.cfg" "" "" "";
menu editfolderscfg "folders.cfg" "" "" "";
menupopz;
menupop "&Run";
menu runline "&Line" "Ctrl+R" "" "";
menu runselection "&Selection" "Ctrl+E" "" "";
menu runwindow "&Window" "Ctrl+W" "" "";
menu runwindowd "Window &Display" "Ctrl+Shift+W" "" "";
menu runlint "Window and Syntax &Check" "Ctrl+1" "" "";
menusep ;
menu runfile "&File" "" "" "";
menu runfiled "File Di&splay" "" "" "";
menusep ;
menu runprojman "&Project Manager..." "Ctrl+B" "" "";
menusep ;
menu runprojman6 "J6 Project Manager..." "" "" "";
menusep ;
menu runpacman "&Package Manager..." "" "" "";
menusep ;
menu rundebug "&Debug..." "Ctrl+K" "" "";
menupopz;
menupop "&Tools";
menupop "Selection";
menu selminus "&Remove ZZ." "Ctrl+Shift+B" "" "";
menu selplus "&Add ZZ." "Ctrl+Shift+N" "" "";
menu selplusline1 "&Add ZZ. --" "Ctrl+Shift+K" "" "";
menu selplusline2 "&Add ZZ. ==" "Ctrl+Shift+L" "" "";
menusep ;
menu sellower "&Lower Case" "" "" "";
menu selupper "&Upper Case" "" "" "";
menu seltoggle "&Toggle Case" "" "" "";
menusep ;
menu selsort "&Sort" "" "" "";
menusep ;
menu selwrap "&Wrap" "" "" "";
menupopz;
menusep ;
menu fkeys "&FKeys..." "" "" "";
menusep ;
menu togglebox "&Toggle Ascii Box Drawing" "" "" "";
menupopz;
menupop "&Window";
menu tilecascade "&Cascade" "" "" "";
menu tile "&Tile" "" "" "";
menu tileacross "Tile Acros&s" "" "" "";
menusep ;
menu max "&Maximize On/Off" "Ctrl+M" "" "";
menusep ;
menu forms "&Forms..." "Ctrl+Q" "" "";
menupopz;
menupop "&Help";
menu helphelp "&Help" "" "" "";
menusep ;
menu helpgeneral "&General Info" "" "" "";
menu helprelease "&Release Highlights" "" "" "";
menusep ;
menu helpvocab "&Vocabulary" "F1" "" "";
menu helpconstants "&Constants" "" "" "";
menu helpcontrols "Control &Structures" "" "" "";
menu helpforeigns "&Foreign Conjunction" "" "" "";
menusep ;
menu helpwdover "&wd Overview" "Shift+F1" "" "";
menu helpwdcmd "&wd Commands" "" "" "";
menu helpgl2cmd "&gl2 Commands" "" "" "";
menu helpuser602 "J602 User Manual" "" "" "";
menu helpmigration "Migration Notes" "" "" "";
menusep ;
menu helpcontext "&Context Sensitive" "Ctrl+F1" "" "";
menusep ;
menu helpuser "&User Manual" "" "" "";
menu helpprimer "&Primer" "" "" "";
menu helpphrases "&Phrases" "" "" "";
menu helpdictionary "&Dictionary" "" "" "";
menu helprelnotes "Release &Notes" "" "" "";
menusep ;
menupop "&Studio";
menu labs "&Labs..." "" "" "";
menu labadvance "Advance" "Ctrl+J" "" "";
menu labchapters "Chapters..." "" "" "";
menusep ;
menu demos "Demos..." "" "" "";
menupopz;
menusep ;
menu aboutj "&About J..." "" "" "";
menupopz;
xywh 0 0 250 150;cc e editijs ws_hscroll ws_vscroll es_nohidesel rightmove bottommove;
pas 0 0;
rem form end;
)
JIJSMAC=: 0 : 0
pc6j jijs;
menupop "&File";
menu filenewijs "&New ijs" "Ctrl+N" "" "";
menusep ;
menu fileopen "&Open..." "Ctrl+O" "" "";
menu fileopenuser "&Open User..." "Ctrl+H" "" "";
menu fileopensystem "&Open System..." "Ctrl+I" "" "";
menu filerecent "&Recent..." "Ctrl+G" "" "";
menusep ;
menu save "Save" "Ctrl+S" "" "";
menu saveas "Save &As..." "" "" "";
menu close "Close" "Ctrl+W" "" "";
menusep ;
menu fileprint "&Print" "Ctrl+P" "" "";
menusep ;
menu fileexit "E&xit" "Ctrl+Q" "" "";
menupopz;
menupop "&Edit";
menu editundo "&Undo" "Ctrl+Z" "" "";
menu editredo "&Redo" "Ctrl+Y" "" "";
menusep ;
menu editcut "Cu&t" "Ctrl+X" "" "";
menu editcopy "&Copy" "Ctrl+C" "" "";
menu editpaste "&Paste" "Ctrl+V" "" "";
menusep ;
menu editselectall "Select &All" "Ctrl+A" "" "";
menusep ;
menu editreadonly "&Read Only" "Ctrl+T" "" "";
menusep ;
menu editfind "&Find..." "Ctrl+F" "" "";
menu editfif "Find &in Files..." "Ctrl+Shift+F" "" "";
menusep ;
menu editdirmatch "Directory &Match..." "" "" "";
menusep ;
menu editclearterm "Clear Terminal" "Ctrl+Shift+T" "" "";
menusep ;
menu editinputlog "Input &Log..." "Ctrl+D" "" "";
menusep ;
menu editlint "Format Script" "Ctrl+L" "" "";
menusep ;
menu editformedit "Form &Editor..." "" "" "";
menusep ;
menu editconfigure "Confi&gure..." "" "" "";
menu editbasecfg "base.cfg" "" "" "";
menu editfolderscfg "folders.cfg" "" "" "";
menupopz;
menupop "&Run";
menu runline "&Line" "Ctrl+R" "" "";
menu runselection "&Selection" "Ctrl+E" "" "";
menu runwindow "&Window (Ctrl+W)" "" "" "";
menu runwindowd "Window &Display (Ctrl+Shift+W)" "" "" "";
menu runlint "Window and Syntax &Check" "Ctrl+1" "" "";
menusep ;
menu runfile "&File" "" "" "";
menu runfiled "File Di&splay" "" "" "";
menusep ;
menu runprojman "&Project Manager..." "Ctrl+B" "" "";
menusep ;
menu runprojman6 "J6 Project Manager..." "" "" "";
menusep ;
menu runpacman "&Package Manager..." "" "" "";
menusep ;
menu rundebug "&Debug..." "Ctrl+K" "" "";
menupopz;
menupop "&Tools";
menupop "Selection";
menu selminus "&Remove ZZ." "Ctrl+Shift+B" "" "";
menu selplus "&Add ZZ." "Ctrl+Shift+N" "" "";
menu selplusline1 "&Add ZZ. --" "Ctrl+Shift+K" "" "";
menu selplusline2 "&Add ZZ. ==" "Ctrl+Shift+L" "" "";
menusep ;
menu sellower "&Lower Case" "" "" "";
menu selupper "&Upper Case" "" "" "";
menu seltoggle "&Toggle Case" "" "" "";
menusep ;
menu selsort "&Sort" "" "" "";
menusep ;
menu selwrap "&Wrap" "" "" "";
menupopz;
menusep ;
menu fkeys "&FKeys..." "" "" "";
menusep ;
menu togglebox "&Toggle Ascii Box Drawing" "" "" "";
menupopz;
menupop "&Window";
menu tilecascade "&Cascade" "" "" "";
menu tile "&Tile" "" "" "";
menu tileacross "Tile Acros&s" "" "" "";
menusep ;
menu max "&Maximize On/Off" "Ctrl+M" "" "";
menusep ;
menu forms "&Forms (Ctrl+Q)..." "" "" "";
menupopz;
menupop "&Help";
menu helphelp "&Help" "" "" "";
menusep ;
menu helpgeneral "&General Info" "" "" "";
menu helprelease "&Release Highlights" "" "" "";
menusep ;
menu helpvocab "&Vocabulary" "F1" "" "";
menu helpconstants "&Constants" "" "" "";
menu helpcontrols "Control &Structures" "" "" "";
menu helpforeigns "&Foreign Conjunction" "" "" "";
menusep ;
menu helpcontext "&Context Sensitive" "Ctrl+F1" "" "";
menusep ;
menu helpuser "&User Manual" "" "" "";
menu helpprimer "&Primer" "" "" "";
menu helpphrases "&Phrases" "" "" "";
menu helpdictionary "&Dictionary" "" "" "";
menu helprelnotes "Release &Notes" "" "" "";
menusep ;
menupop "&Studio";
menu labs "&Labs..." "" "" "";
menu labadvance "Advance" "Ctrl+J" "" "";
menu labchapters "Chapters..." "" "" "";
menusep ;
menu demos "Demos..." "" "" "";
menupopz;
menusep ;
menu aboutj "&About J..." "" "" "";
menupopz;
xywh 0 0 250 150;cc e editijs ws_hscroll ws_vscroll es_nohidesel rightmove bottommove;
pas 0 0;
rem form end;
)
jijs_aboutj_button=: 3 : 0
wdinfo 'About J';aboutj''
)
jijs_default=: 3 : 0
if. systype -: 'fkey' do. fkeyrun syschild end.
)
jijs_close=: jijs_cancel=: jijs_close_button=: close
jijs_demos_button=: demos
jijs_editconfigure_button=: config
jijs_editcopy_button=: 3 : 'wd ''setedit e c'''
jijs_editcut_button=: 3 : 'wd ''setedit e x'''
jijs_editdirmatch_button=: dirmatch
jijs_editfif_button=: fif
jijs_editfind_button=: editfind
jijs_editformedit_button=: formedit
jijs_editclearterm_button=: clearijx
jijs_editinputlog_button=: editinputlog
jijs_editlint_button=: lint
jijs_editpaste_button=: 3 : 'wd ''setedit e v'''
jijs_editreadonly_button=: togglereadonly
jijs_editredo_button=: 3 : 'wd ''setedit e y'''
jijs_editselectall_button=: 3 : 'wd ''setselect e'''
jijs_editundo_button=: 3 : 'wd ''setedit e z'''
jijs_editbasecfg_button=: open_j_@jpath bind '~config/base.cfg'
jijs_editfolderscfg_button=: open_j_@jpath bind '~config/folders.cfg'
jijs_filecleartemp_button=: cleartemp
jijs_fileexit_button=: closeijx
jijs_filenewijs_button=: newijs
jijs_fileopen_button=: openijs bind 'temp'
jijs_fileopensystem_button=: openijs bind 'system'
jijs_fileopenuser_button=: openijs bind 'user'
jijs_fileprint_button=: fileprint_j_
jijs_fileprintsetup_button=: fileprintsetup_j_
jijs_filerecent_button=: recent_run
jijs_fkeys_button=: fkeyselect
jijs_forms_button=: forms
jijs_helpconstants_button=: 3 : 'htmlhelp ''dictionary/dcons.htm'''
jijs_helpcontext_button=: 3 : 'help y'
jijs_helpcontrols_button=: 3 : 'htmlhelp ''dictionary/ctrl.htm'''
jijs_helpdictionary_button=: 3 : 'htmlhelp ''dictionary/contents.htm'''
jijs_helpforeigns_button=: 3 : 'htmlhelp ''dictionary/xmain.htm'''
jijs_helpgeneral_button=: 3 : 'htmlhelp ''user/product.htm'''
jijs_helpgl2cmd_button=: 3 : 'htmlhelp602 ''user/gl2_commands.htm'''
jijs_helphelp_button=: 3 : 'htmlhelp ''index.htm'''
jijs_helpphrases_button=: 3 : 'htmlhelp ''phrases/contents.htm'''
jijs_helpprimer_button=: 3 : 'htmlhelp ''primer/contents.htm'''
jijs_helprelease_button=: 3 : 'htmlhelp ''user/relhigh.htm'''
jijs_helprelnotes_button=: 3 : 'htmlhelp ''release/contents.htm'''
jijs_helpuser602_button=: 3 : 'htmlhelp602 ''user/contents.htm'''
jijs_helpuser_button=: 3 : 'htmlhelp ''user/contents.htm'''
jijs_helpvocab_button=: 3 : 'htmlhelp ''dictionary/vocabul.htm'''
jijs_helpwdcmd_button=: 3 : 'htmlhelp602 ''user/wd_commands.htm'''
jijs_helpwdover_button=: 3 : 'htmlhelp602 ''user/win_driver_cmd_ref_overview.htm'''
jijs_labadvance_button=: 3 : 'lab_jnet_ 0'
jijs_labchapters_button=: 3 : 'lab_jnet_ 1'
jijs_labs_button=: 3 : 'lab_jnet_'''''
jijs_max_button=: winmax
jijs_rundebug_button=: debug
jijs_runfile_button=: runfile bind 0
jijs_runfiled_button=: runfile bind 1
jijs_runline_button=: runline
jijs_runpacman_button=: pacman
jijs_runprojman_button=: projectmanager
jijs_runprojman6_button=: projectmanager6
jijs_runselection_button=: runselection
jijs_runwindow_button=: runwindow bind 0
jijs_runwindowd_button=: runwindow bind 1
jijs_runlint_button=: runlint
jijs_save_button=: save bind 2
jijs_saveas_button=: saveas
jijs_sellower_button=: select_text bind 'lower'
jijs_selminus_button=: select_line bind 'minus'
jijs_selplus_button=: select_line bind 'plus'
jijs_selplusline1_button=: select_line bind 'plusline1'
jijs_selplusline2_button=: select_line bind 'plusline2'
jijs_selsort_button=: select_line bind 'sort'
jijs_seltoggle_button=: select_text bind 'toggle'
jijs_selupper_button=: select_text bind 'upper'
jijs_selwrap_button=: select_text bind 'wrap'
jijs_tile_button=: tile
jijs_tileacross_button=: tileacross
jijs_tilecascade_button=: tilecascade
jijs_togglebox_button=: togglebox
jijs_helpmigration_button=: 3 : 0
require 'jview'
'Migration Note' wdview fread '~addons/ide/jnet/data/migration.txt'
)
jijs_f1_fkey=: jijs_helpvocab_button
jijs_f1ctrl_fkey=: jijs_helpcontext_button
jijs_f1shift_fkey=: jijs_helpwdover_button
jijs_actrl_fkey=: jijs_editselectall_button
jijs_bctrl_fkey=: jijs_runprojman_button
jijs_dctrl_fkey=: jijs_editinputlog_button
jijs_ectrl_fkey=: jijs_runselection_button
jijs_fctrl_fkey=: jijs_editfind_button
jijs_gctrl_fkey=: jijs_filerecent_button
jijs_hctrl_fkey=: jijs_fileopenuser_button
jijs_ictrl_fkey=: jijs_fileopensystem_button
jijs_jctrl_fkey=: jijs_labadvance_button
jijs_kctrl_fkey=: jijs_rundebug_button
jijs_lctrl_fkey=: jijs_editlint_button
jijs_mctrl_fkey=: jijs_max_button
jijs_nctrl_fkey=: jijs_filenewijs_button
jijs_octrl_fkey=: jijs_fileopen_button
jijs_pctrl_fkey=: jijs_fileprint_button
jijs_qctrl_fkey=: jijs_forms_button
jijs_rctrl_fkey=: jijs_runline_button
jijs_sctrl_fkey=: jijs_save_button
jijs_tctrl_fkey=: jijs_editreadonly_button
jijs_wctrl_fkey=: jijs_runwindow_button
jijs_1ctrl_fkey=: jijs_runlint_button

jijs_bctrlshift_fkey=: jijs_selminus_button
jijs_ectrlshift_fkey=: jijs_runselection_button
jijs_fctrlshift_fkey=: jijs_editfif_button
jijs_kctrlshift_fkey=: jijs_selplusline1_button
jijs_lctrlshift_fkey=: jijs_selplusline2_button
jijs_nctrlshift_fkey=: jijs_selplus_button
jijs_rctrlshift_fkey=: jijs_runline_button
jijs_wctrlshift_fkey=: jijs_runwindowd_button
3 : 0 ''

if. UNAME-:'Darwin' do.
  JIJS=: JIJSMAC
  sys_macabout_z_=: jijs_aboutj_button_jijs_
  sys_macpreferences_z_=: config_jijs_
  sys_macquit_z_=: closeijx_jijs_
elseif. IFJAVA do.
  t=. <;.2 JIJS,LF
  m=. (1: e. 'fileprintsetup'&E.) &> t
  JIJS=: }: ; (-.m) # t
end.
ndx=. I. 'ZZ' E. JIJS
JIJS=: 'NB' (<"0 ndx +/ 0 1) } JIJS
)

recent_read''
