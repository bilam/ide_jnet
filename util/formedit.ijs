require 'general/misc/font graphics/bmp'
coclass 'jformedit'

coinsert 'jgl2 jijs'
coinsert 'jgl2'
create=: 3 : 0

copybuffer=: ''
if. mGSCALE=0 do.
  wd 'pc6j gscale;xywh 0 0 200 200;cc g isigraph'
  s=. 2 { 0 ". wd 'qchildxywh g'
  x=. 2 { 0 ". wd 'qchildxywhx g'
  wd 'pclose'
  mGSCALE_jformedit_=: x % s
  topixels_jformedit_=: roundint @ (] * GSCALE)
  tounits_jformedit_=: roundint @ (] % GSCALE)
  GWH_jformedit_=: 2 {. 0 ". wd 'qm'
  XYWH_jformedit_=: '0 0 ',": <.GWH % GSCALE''
end.

if. isempty y do.
  id=. qsmact ''
  FNAME=: id2name id
  if. '.ijx' -: _4 {. FNAME do.
    info 'Open a script window before running Form Edit'
    destroy''
    return.
  end.
  smsel id
  smsave ''
else.
  FNAME=: y
  smopen FNAME
end.
if. 0 = file_init'' do. destroy'' end.
)
create_show=: 3 : 0

wd DESIGN
wd 'pn "Design - ',PID,'"'
wdfit''
nd=. 'undo redo center minus plus size space touch'
wd 3 |. ; ' 0;setenable '&, each ;: nd
selectdesign=: wd bind ('psel ',wd 'qhwndp')

drawform''
selectdesign''
wd 'ptop'
wd 'pshow'

getformsizes''
geteditheight''
bufsnap ''
)
destroy=: 3 : 0
try.
  selectform''
  wd 'pclose'
catch. end.
try.
  selectdesign''
  wd 'pclose'
catch. end.
codestroy''
)
addLF=: , & LF
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
dquote=: '"'&, @ (,&'"')
index=: #@[ (| - =) i.
isempty=: 0: e. $
rounddown=: [ * [: <. %~
roundint=: <. @ +&0.5
roundup=: [ * [: >. %~
sessiontime=: 6!:1
tolist=: }. @ ; @: (LF&, @ , @ ": each)
towords=: ;: ^: _1
capture=: 3 : 0
CAPTURE=: {. y
glcapture y
)
cursor=: 3 : 0
glcursor CURSOR=: y
)
debs=: 3 : 0
msk=. (y ~: ' ') +. ~: /\ y = '"'
y #~ msk +. 1 |. msk > </\ msk
)
deletecc=: 3 : 0
if. #SELECT do.
  ndx=. <<<SELECT
  CCS=: ndx { CCS
  CLS=: ndx { CLS
  CPS=: ndx { CPS
  IDS=: ndx { IDS
  STY=: ndx { STY
  SELECT=: $0
  drawpaint ''
  bufsnap''
end.
)
deldblquote=: 3 : 0
nd0=. 1 + y index '"'
nd1=. y i: '"'
nd0 }. nd1 {. y
)
dblquote=: '"'&, @ (,&'"')
delprefix=: 3 : 0
ndx=. 1 + y i. &> '_'
towords ndx }. each y
)
flipypos=: 3 : 0
ry=. $y
(ry $ 0, GHX) + y * ry $ 1 _1
)
flipypos1=: 3 : 0
({. y), GHX - {:y
)
flipyrect=: 3 : 0
c=. GHX - +/"1 [ 1 3{"1 y
($y) $ ,c 1}"0 1 y
)
ferase=: (1!:55&< :: _1: ) &>
fread=: (1!:1 :: _1:) @ boxopen
fstamp=: (1: >@{ ,@(1!:0)) ::(_1:)
fwrite=: (1!:2 :: _1:) boxopen
freads=: 3 : 0
dat=. (1!:1) :: _1: boxopen y
if. (dat -: _1) +. 0=#dat do. return. end.
dat,LF -. {:dat=. toJ dat
)
flwrites=: 4 : 0
dat=. x
if. -. 0 e. $dat do.
  if. 1 >: #$dat do.
    dat=. dat,(LF ~: {:dat)#LF
  else.
    dat=. ,dat,"1 LF
  end.
end.
(toHOST dat) flwritenew y
)
flwritenew=: 4 : 0
dat=. ,x
new=. -. dat -: fread y
if. new do. dat fwrite y end.
new
)
getformsizes=: 3 : 0
FORMSIZES=: FORMSIZES_j_
)
geteditheight=: 3 : 0
EDITHEIGHT=: FORMSIZES {~ {: 4 pick (({."1 CONTROLS) i. <'edit') { CONTROLS
)
getoleocx=: 3 : 0
if. y do.
  if. 0 = # OLEOCX do.
    j=. _2 [\ <;._2 wd 'oleocx ',IFJNET#":y
    OLEOCX=: j /: tolower each {."1 j
  end.
else.
  if. -.IFJNET do. return. end.
  if. 0 = # OLEAUT do.
    j=. _2 [\ <;._2 wd 'oleocx ',":y
    OLEAUT=: j /: tolower each {."1 j
  end.
end.
)
getwhx=: 3 : 0
selectform''
2 3 { 0 ". wd 'qchildxywhx g'
)
globals=: 3 : 0
rx=. rxcomp '([[:alpha:]][[:alnum:]_]*|x\.|y\.|m\.|n\.|u\.|v\.) *=:'
nms=. rx rxall y
rxfree rx
nms=. _2 }. each ~. nms
hdr=. PID, '_'
len=. # hdr
len }. each ((<hdr) = len {. each nms) # nms
)
ifshiftkey=: 3 : '''1'' e. sysmodifiers'
ifctrlkey=: 3 : '''2'' e. sysmodifiers'
ifctrlshiftkey=: 3 : '''3'' e. sysmodifiers'
info=: 3 : 0
wdinfo 'Form Edit';y
)
makeccx=: 3 : 0
CCX=: topixelsxywh viewccs''
)
makedots=: 3 : 0
'w h'=. 0 >. y
x=. h # i.w
y=. (w*h) $ i.h
m=. 2 | x + y
(m#x),.m#y
)
minform=: 3 : 0
if. IFUNIX do. return. end.
smsel_jijs_ FNAME
wd 'psel ',SMSEL_jijs_
wd 'pshow sw_showminimized'
)
mousepos=: 3 : 0
2 {. 0 ". sysdata
)
mouseposu=: 3 : 0
roundint (mousepos'') % GSCALE''
)
query=: 4 : 0
x wdquery 'Form Edit';y
)
selectcode=: 3 : 0
smopen FNAME
dat=. smread ''
sel=. {. SELECT
id=. sel pick IDS
ndx=. ({."1 CONTROLS) i. sel { CLS
evt=. > {. 6 pick ndx { CONTROLS
if. 0 = #evt do. return. end.
fn=. PID,'_',id,'_',evt
ndx=. 1 i.~ ((fn,'=:') E. dat) +. (fn,' =:') E. dat
if. ndx = #dat do.
  new=. LF,fn,'=: 3 : 0',LF
  dat=. dat,new,')',LF
  smwrite dat
  ndx=. ndx + #new
else.
  ndx=. ndx + 1 + (ndx }. dat) i. LF
end.
smsetselect ndx,ndx,0
smfocus''
)
state=: 3 : 0
nms=. 'cc';'caption';'id';'class';'style'
dat=. > each CCS ; CPS ; IDS ; CLS ; <STY
nms ,: dat
)
tocoordsxywh1=: 3 : 0
'x y w h'=. y
s=. roundint (x + w) % GSCALE''
t=. roundint (y + h) % GSCALE''
x=. roundint x % GSCALE''
y=. roundint y % GSCALE''
x,y,(s-x),t-y
)
topixelsxywh=: 3 : 0
'x y w h'=. |: y
s=. roundint (GSCALE'') * x + w
t=. roundint (GSCALE'') * y + h
x=. roundint x * GSCALE''
y=. roundint y * GSCALE''
x,.y,.(s-x),.t-y
)
validatecc=: 3 : 0
if. '_' e. y do.
  info 'An id cannot contain an underscore: ',y
  0 return.
end.
if. (<y) e. WDNAMES do.
  msg=. 'The id "',y,'" is reserved.',LF,LF
  info msg,'It is best to avoid ids beginning "wd".'
  0 return.
end.
if. _2 = 4!:0 <y do.
  info 'Invalid control id: ',y
  0 return.
end.
1
)
viewccs=: 3 : 0
ndx=. I. CLS e. 'combodrop';'combolist'
CBSIZE (<ndx;3) } CCS
)
ws_add=: 3 : 0
dat=. <;._1@:(' ' , deb) ^: (L.=0:) y
dat=. (<'ws_group') (I. dat = <'group') } dat
dat=. (<'gs_opengl') (I. dat = <'opengl') } dat
towords dat
)
ws_del=: 3 : 0
dat=. <;._1@:(' ' , deb) ^: (L.=0:) y
dat=. (<'group') (I. dat = <'ws_group') } dat
dat=. (<'opengl') (I. dat = <'gs_opengl') } dat
dat=. }.^:('_'={.) each dat
)
BLACK=: 0 0 0
RED=: 255 0 0
BLUE=: 0 0 255
3 : 0 ''
if. IFJAVA do.
  TEXT=: 0 0 0
  FACE=: 236 233 216
  SHADOW=: 172 168 153
  HIGH=: 255 255 255
  DKSHADOW=: 113 111 100
  LIGHT=: 241 239 226
else.
  nms=. 'FACE SHADOW TEXT HIGH DKSHADOW LIGHT'
  (nms)=: 0 ". wd 'qcolor ',"1 ": ,.15 16 18 20 21 22
end.
)
PID=: ''
PST=: ''
PCN=: ''
PAS=: 6 6
POP=: ''
PMV=: ''
PFE=: ''
CCS=: 0 4$0
CCX=: 0 4$0
CLS=: ''
CPS=: ''
IDS=: ''
STY=: ''
BUF=: ''
MNU=: ''
RFE=: 'rem form end;'
SBR=: ''
TBR=: ''
TBFN=: jpath '~addons/ide/jnet/data/isitbar8.bmp'
PC6J=: 0
PC8J=: 0
MOUSEIGNORE=: 0
MOUSETIME=: sessiontime''

GWH=: 0 0
XYWH=: ''
MINWH=: 160 20
HWNDP=: ''
LOCK=: 0
BOX=: ''
CURSOR=: 0
DOWN=: ''
UP=: ''
ORDER=: 0
PDF=: ''
SELECT=: $0
STEP=: 1
TESTLOC=: ''
TESTHWNDP=: ''
WINDIR=: 0
GFONT=: PROFONT
OLEOCX=: ''
OLEAUT=: ''
sysevent=: ''
sysmodifiers=: ,'0'
CAPNONE=: 0
CAPMOVE=: 7
CAPSIZE=: 8
CAPSELECT=: 3
CAPTURE=: CAPNONE
FWH=: _1
mGSCALE=: 0
GSCALE=: 3 : '((-.PC8J*.IFJNET){0,(((,''1'')-:11!:0 ::0:''getj pc6j'')+.PC6J+.-.IFJNET)){1,mGSCALE'
GRID=: 16
FNAME=: ''
PID=: ''
WDNAMES=: <;._2 (0 : 0)
wd
wdhandler
wdinfo
wdq
)
j=. 0 : 0
button
bs
group
defpushbutton ownerdraw

0 1
1
button
checkbox
bs
group
lefttext
left
2 4
1
button
combobox
cbs
group vscroll
autohscroll sort

2 2
0
button select
combodrop
cbs
group vscroll
autohscroll sort

2 2
0
button select
combolist
cbs
group vscroll
sort

2 2
0
button select
edit
es
group thickframe
autohscroll lowercase nohidesel password readonly right uppercase
center left
2 3
0
button
editm
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
center left
2 2
0

groupbox
-
group
-

2 2
1

isigraph
gs
-
opengl

2 2
0
char copy cut focus focuslost mbldbl mbldown mblup mblmdown mblmdbl mblmup mbrdbl mbrdown mbrup mmove mwheel paint paste undo
listbox
lbs
group hscroll vscroll
extendedsel multicolumn multiplesel ownerdrawfixed sort

2 2
0
button select
progress
-
group

-
2 3
0
button
radiobutton
bs
-
lefttext
left
2 4
1
button
richedit
es
group thickframe
autohscroll nohidesel readonly sunken
center left
2 3
0
button
richeditm
es
group hscroll thickframe vscroll
autohscroll autovscroll center nohidesel readonly right sunken
center left
2 2
0

scrollbar
sbs
group
-

2 3
0
button
scrollbarv
sbs
group
-

3 2
0
button
spin

group
-

1 1
0
button
spinv

group
-

1 1
0
button
static
ss
group
center leftnowordwrap noprefix right simple

2 4
1

staticbox
ss
group
blackframe blackrect etchedframe etchedhorz etchedvert grayframe grayrect sunken whiteframe whiterect

2 2
0

tab
tcs
group
buttons multiline
noheader
2 2
0
button
trackbar
tbs
group
autoticks both enableselrange nothumb noticks top

2 3
0
button
trackbarv
tbs
group
autoticks both enableselrange left nothumb noticks

3 2
0
button
ocx
ocx
group
-

2 2
0
button
oleautomation
-
-
-

2 2
0
-
checkedlistbox
lbs
group hscroll vscroll
extendedsel multicolumn multiplesel ownerdrawfixed sort
checkonclick multiple multiextended mutisimple
2 2
0
button select
datagrid
-
group
-

2 2
0
button select
datepicker
-
group

cal
2 3
0
changed
dspinbox

group
-

2 3
0
changed
editmask
es
group
autohscroll lowercase nohidesel password readonly right uppercase
center left
2 3
0
button char
editint
es
group
autohscroll nohidesel password readonly right
center left
2 3
0
button char
editnum
es
group
autohscroll nohidesel password readonly right
center left
2 3
0
button char
image
-
group

autosize center normal stretch zoom
2 2
0

isidraw
-
-
-

2 2
0
char copy cut focus focuslost mbldbl mbldown mblup mblmdown mblmdbl mblmup mbrdbl mbrdown mbrup mmove mwheel paint paste undo
isiprint
-
-

j6 j8
2 2
0
print
opengl
-
-

es version
2 2
0
char copy cut focus focuslost mbldbl mbldown mblup mblmdown mblmdbl mblmup mbrdbl mbrdown mbrup mmove mwheel paint paste undo
progressbar
-
group
-

2 3
0
-
spinbox

group
-

2 3
0
changed
timepicker
-
group
-

2 3
0
changed
webview
-
group
-

2 2
0
-
)
j=. _8 [\ <;._2 j -. '-'
s=. 'border disabled '
std=. ([: 'ws_'&, each [: ;: s&,) each 2 {"1 j
sty=. (1 {"1 j) ,each '_'
cls=. (< each sty) ,each each ;: each 3 {"1 j
cls=. /:~@:~. each cls ,&.> IFJNET {:: a: ,&< (< each sty) ,each each ;: each 4 {"1 j
siz=. 0 ". each 5 {"1 j
cap=. 0 ". each 6 {"1 j
evt=. ;: each 7 {"1 j
CONTROLS=: (2 {."1 j) ,. std ,. cls ,. siz ,. cap ,. evt
JAVASTYLES=: cutopen 0 : 0
bs_defpushbutton
bs_lefttext
bs_ownerdraw
cbs_autohscroll
cbs_sort
es_autohscroll
es_autovscroll
es_center
es_lowercase
es_nohidesel
es_password
es_readonly
es_right
es_sunken
es_uppercase
gs_opengl
lbs_extendedsel
lbs_multicolumn
lbs_multiplesel
lbs_ownerdrawfixed
lbs_sort
sbs_vert
ss_blackframe
ss_blackrect
ss_center
ss_etchedframe
ss_etchedhorz
ss_etchedvert
ss_grayframe
ss_grayrect
ss_leftnowordwrap
ss_noprefix
ss_right
ss_simple
ss_sunken
ss_whiteframe
ss_whiterect
tbs_autoticks
tbs_both
tbs_enableselrange
tbs_left
tbs_nothumb
tbs_noticks
tbs_top
tcs_buttons
tcs_multiline
ws_border
ws_disabled
ws_group
ws_hscroll
ws_thickframe
ws_vscroll
)
3 : 0''
if. -.IFJNET do.
  CONTROLS=: CONTROLS {.~ >: (<'oleautomation') i.~ {."1 CONTROLS
end.
std=. 2 {"1 CONTROLS
cls=. 3 {"1 CONTROLS
if. IFJAVA do.
  std=. std (e. # [) each <JAVASTYLES
  cls=. cls (e. # [) each <JAVASTYLES
end.
CONTROLS=: (std ,. cls) 2 3 }"1 CONTROLS
STDCONTROLS=: CONTROLS #~ ('ocx';'oleautomation') (-.@e.)~ {."1 CONTROLS
)
bufsnap=: 3 : 0
if. #BUF do.
  BUF=: (1 + POS) {. BUF
end.
BUF=: BUF, (<CCS;CLS;CPS;IDS;STY;SELECT) -. _1 {. BUF
POS=: <: # BUF
selectdesign''
wd 'setenable undo ',": * POS
wd 'setenable redo 0'
)
bufredo=: 3 : 0
if. POS < <: # BUF do.
  old=. IDS
  POS=: POS + 1
  'CCS CLS CPS IDS STY SELECT'=: POS pick BUF
  drawpaint ''
  design_enable''
  selectdesign''
  wd 'setenable undo 1'
  wd 'setenable redo ', ": POS < <: # BUF
end.
)
bufundo=: 3 : 0
if. POS > 0 do.
  old=. IDS
  POS=: POS - 1
  'CCS CLS CPS IDS STY SELECT'=: POS pick BUF
  drawpaint ''
  design_enable''
  selectdesign''
  wd 'setenable redo 1'
  wd 'setenable undo ', ": POS > 0
end.
)
FORMEVENTS=: <;._2 (0 : 0)
cancel
close
default
enter
handler
run
)
WCODE=: 0 : 0
pc6j wcode owner;
xywh 4 7 45 64;cc g0 groupbox;cn "Event type";
xywh 9 18 38 9;cc wccontrol radiobutton;cn "control";
xywh 9 30 38 9;cc wcfkey radiobutton group;cn "fkey";
xywh 9 42 38 9;cc wcform radiobutton group;cn "form";
xywh 9 54 38 9;cc wcorphan radiobutton group;cn "orphan";
xywh 56 7 90 66;cc wclist listbox ws_vscroll;
xywh 151 9 36 12;cc wcclose button;cn "Close";
xywh 151 24 36 12;cc wccode button;cn "Code...";
xywh 151 39 36 12;cc wchelp button;cn "Help";
pas 3 4;pcenter;
rem form end;
)
wcode_run=: 3 : 0
wd WCODE
HCODE=: wd 'qhwndp'
wd 'set wccontrol 1'
'wccontrol wcfkey wcform wcorphan'=: ": each 1 0 0 0
wclist=: ''
wcode_show 0
wd 'pn "Code - ',PID,'"'
wd 'pshow;'
)
wcode_wccode_button=: 3 : 0
smopen FNAME
dat=. smread''
if. '1' e. wccontrol,wcfkey,wcform do.
  dat=. dat, LF, PID,'_',(wclist -. ' '),'=: 3 : 0',LF,')',LF
  smwrite dat
  wcode_show''
  smfocus''
elseif. # j=. wclist -. ' ' do.
  ndx=. 1 i.~ (PID,'_', j) E. dat
  smsetselect ndx,ndx,0
  smfocus
end.
)
wcode_close=: 3 : 0
wd 'pclose'
)
wcode_show=: 3 : 0
smopen FNAME
GLOBALS=: globals smread ''
wd 'psel ',HCODE
select. (wccontrol,wcfkey,wcform,wcorphan) i. '1'
case. 0 do.
  wcodelist controlevents''
case. 1 do.
  wcodelist fkeyevents''
case. 2 do.
  wcodelist FORMEVENTS
case. 3 do.
  inc=. FORMEVENTS,(controlevents''),fkeyevents''
  nms=. /:~ GLOBALS -. inc -. each ' '
  wd 'set wclist ',towords dblquote each nms
end.
)
wcode_wchelp_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
wcodelist=: 3 : 0
nms=. y -. each ' '
ndx=. nms index <wclist -. ' '
msk=. nms e. GLOBALS
nms=. msk /:~ (msk { '  ';'') ,each y
wd 'set wclist ',towords dblquote each nms
wd 'setselect wclist ',":ndx
)
wcode_wccontrol_button=: wcode_show
wcode_wcfkey_button=: wcode_show
wcode_wcform_button=: wcode_show
wcode_wcorphan_button=: wcode_show
wcode_wcclose_button=: wcode_cancel=: wcode_close
wcode_wclist_button=: wcode_enter=: wcode_wccode_button
controlevents=: 3 : 0
evt=. (({."1 CONTROLS) i. CLS) { 6{"1 CONTROLS
ctl=. ; (IDS ,each '_') (<@[ ,each ]) each evt
mnu=. <;._2 MNU
msk=. (<'menu ') = 5 {. each mnu
mnu=. 5 }. each msk # mnu
mnu=. (mnu i. &> ' ') {. each mnu
mnu=. mnu ,each <'_button'
~. ctl, mnu
)
fkeyevents=: 3 : 0
f=. 'f' ,each ": each 1 + i.12
r=. f
r=. r, f ,each <' ctrl'
r=. r, f ,each <' shift'
r=. r, f ,each <' ctrlshift'
a=. a. {~ ; (a. i. 'a0') + each i. each 26 10
r=. r, a ,each <' ctrl'
r=. r, a ,each <' ctrlshift'
r=. r -. 'c ctrl';'v ctrl';'x ctrl';'z ctrl'
r ,each <'_fkey'
)
FMSTYLE=: , ; each { (;<;:'left top right bottom') ; <;:'move scale'
WCONTROL=: 0 : 0
pc6j wcontrol nomax nomin nosize owner;pn "Control";
xywh 4 7 21 9;cc s0 static;cn "Class:";
xywh 28 7 55 9;cc sclass static;
xywh 4 19 34 10;cc s1 static;cn "Id:";
xywh 39 18 90 11;cc id edit ws_border es_autohscroll;
xywh 4 31 34 10;cc scaption static;cn "Caption:";
xywh 39 30 90 11;cc caption edit ws_border es_autohscroll;
xywh 4 46 125 39;cc g0 groupbox;cn "Size rules";
xywh 13 63 33 11;cc wz button;cn "Fix";
xywh 48 56 33 11;cc nz button;cn "Fix";
xywh 83 63 33 11;cc ez button;cn "Fix";
xywh 48 69 33 11;cc sz button;cn "Fix";
xywh 4 93 34 10;cc sposition static;cn "Position:";
xywh 39 92 90 11;cc position edit ws_border es_autohscroll;
xywh 136 7 40 10;cc s3 static;cn "Styles:";
xywh 136 17 54 90;cc style listbox lbs_multiplesel lbs_sort;
xywh 195 7 40 10;cc s4 static;cn "Class Styles:";
xywh 195 17 54 90;cc class listbox lbs_multiplesel lbs_sort;
xywh 257 7 38 12;cc ok button;cn "OK";
xywh 257 20 38 12;cc cancel button;cn "Cancel";
xywh 257 36 38 12;cc apply button;cn "&Apply";
xywh 257 51 38 12;cc code button;cn "&Code...";
xywh 257 66 38 12;cc help button;cn "&Help";
pas 3 3;pcenter;
rem form end;
)
wcontrol_run=: 3 : 0
if. 0 = #SELECT do.
  info 'First select a control' return.
end.
if. 1 < #SELECT do.
  info 'Select a single control' return.
end.

sel=. {. SELECT
class=. sel pick CLS
pos=. sel { CCS
styles=. ;: sel pick STY
ndx=. ({."1 CONTROLS) i. < class
'sty cst cap evt'=. 2 3 5 6 { ndx { CONTROLS
evt=. > {. evt
ocx=. class-:'ocx'
oleautomation=. class-:'oleautomation'
cap=. cap +. ocx +. oleautomation

design_enable ''
wd WCONTROL
wd 'pn "Control - ',PID,'"'
wd 'setcaption sclass ',class
wd 'set id *',sel pick IDS
wd 'set position *',": pos
wd 'set caption *',sel pick CPS
wd 'setshow scaption ',":cap
wd 'setshow caption ',":cap
wd 'setenable code ',":0 < #evt
wd 'setcaption scaption ',(ocx+.oleautomation) pick 'Caption:';oleautomation pick 'ocx:';'oleautomation:'
FMS=: (_2 [\ FMSTYLE e. styles) i."1 [ 1
wcontrol_setmoves''

wd 'set style ',delprefix sty
for_n. I. sty e. styles do.
  wd 'setselect style ',":n
end.
wd 'set class ',delprefix cst
for_n. I. cst e. styles do.
  wd 'setselect class ',":n
end.

wd 'pshow;'
MOUSEIGNORE=: 1
)
wcontrol_close=: 3 : 0
if. 0 = wcontrol_read'' do. return. end.
wcontrol_cancel''
drawpaint''
)
wcontrol_cancel=: 3 : 0
MOUSEIGNORE=: 0
wd'pclose'
)
wcontrol_read=: 3 : 0
if. 0 = validatecc id do. 0 return. end.
sel=. {. SELECT
if. (<id) e. (<<<sel) { IDS do.
  msg=. 'The id "',id,'" is used for another control in this form'
  info msg
  0 return.
end.
cls=. sel pick CLS
ndx=. ({."1 CONTROLS) i. <cls
pos=. 0 ". position
if. 4 ~: #pos do.
  info 'Position should be 4 numbers: x y w h'
else.
  CCS=: pos sel } CCS
end.
pfx=. 1 pick ndx { CONTROLS
fms=. FMSTYLE {~ (FMS < 2) # FMS + 0 2 4 6
s=. 'ws_'&, each cutopen style
s=. s, (pfx,'_')&, each cutopen class
s=. towords s,fms
STY=: (<s) sel } STY
IDS=: (<id) sel } IDS
CPS=: (<caption) sel } CPS
1
)
wcontrol_setmoves=: 3 : 0
if. #y do.
  FMS=: 3 | FMS + y = i. 4
end.
dat=. FMS { ;: 'Move Scale Fix'
wd 'setcaption wz ', 0 pick dat
wd 'setcaption nz ', 1 pick dat
wd 'setcaption ez ', 2 pick dat
wd 'setcaption sz ', 3 pick dat
)

wcontrol_wz_button=: wcontrol_setmoves bind 0
wcontrol_nz_button=: wcontrol_setmoves bind 1
wcontrol_ez_button=: wcontrol_setmoves bind 2
wcontrol_sz_button=: wcontrol_setmoves bind 3

wcontrol_ok_button=: wcontrol_close
wcontrol_cancel_button=: wcontrol_cancel
wcontrol_apply_button=: 3 : 0
if. 0=wcontrol_read'' do. 0 return. end.
drawpaint''
1
)
wcontrol_code_button=: 3 : 0
if. 0 = wcontrol_apply_button'' do. 0 return. end.
selectcode ''
1
)
wcontrol_help_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
DESIGN_NOTMAC=: 0 : 0
pc6j design nomax nomin nosize;
menupop "File";
menu save "Save" "" "" "";
menusep ;
menu exit "Exit" "" "" "";
menupopz;
menupop "Window";
menu winnew "New  Control" "" "" "";
menu wincontrol "Control" "" "" "";
menu winparent "Parent" "" "" "";
menusep ;
menu windel "Delete Control" "" "" "";
menusep ;
menu winmenu "Menu" "" "" "";
menu wintoolbar "Toolbar" "" "" "";
menu winstatus "Statusbar" "" "" "";
menusep ;
menu wincode "Code" "" "" "";
menu winscript "Script" "" "" "";
menupopz;
menupop "Help";
menu helpformedit "Form Edit" "" "" "";
menupopz;
xywh 14 4 11 11;cc n button;cn "";
xywh 3 15 11 11;cc w button;cn "";
xywh 14 15 11 11;cc c button;cn "1";
xywh 25 15 11 11;cc e button;cn "";
xywh 14 26 11 11;cc s button;cn "";
xywh 39 4 28 11;cc new button;cn "New...";
xywh 39 15 28 11;cc view button;cn "View";
xywh 39 26 28 11;cc script button;cn "Script";
xywh 70 4 28 11;cc undo button;cn "Undo";
xywh 70 15 28 11;cc redo button;cn "Redo";
xywh 70 26 28 11;cc lock button;cn "Lock";
xywh 98 4 28 11;cc center button;cn "Center";
xywh 98 15 28 11;cc size button;cn "Size";
xywh 126 4 28 11;cc space button;cn "Space";
xywh 126 15 28 11;cc touch button;cn "Touch";
xywh 154 4 28 11;cc minus button;cn "Minus";
xywh 154 15 28 11;cc plus button;cn "Plus";
xywh 185 4 36 11;cc ok button;cn "OK";
xywh 185 15 36 11;cc cancel button;cn "Cancel";
xywh 102 28 50 11;cc id static;cn "";
xywh 152 28 56 11;cc pos static ss_center;cn "";
pas 3 1;pcenter;
rem form end;
)

DESIGN_MAC=: 0 : 0
pc6j design nomax nomin nosize;
menupop "File";
menu save "Save" "" "" "";
menusep ;
menu exit "Exit" "" "" "";
menupopz;
menupop "Window";
menu winnew "New  Control" "" "" "";
menu wincontrol "Control" "" "" "";
menu winparent "Parent" "" "" "";
menusep ;
menu windel "Delete Control" "" "" "";
menusep ;
menu winmenu "Menu" "" "" "";
menu wintoolbar "Toolbar" "" "" "";
menu winstatus "Statusbar" "" "" "";
menusep ;
menu wincode "Code" "" "" "";
menu winscript "Script" "" "" "";
menupopz;
menupop "Help";
menu helpformedit "Form Edit" "" "" "";
menupopz;
xywh 21 4 18 13;cc n button;cn "";
xywh 3 17 18 13;cc w button;cn "";
xywh 21 17 18 13;cc c button;cn "1";
xywh 39 17 18 13;cc e button;cn "";
xywh 21 30 18 13;cc s button;cn "";
xywh 60 4 34 13;cc new button;cn "New...";
xywh 60 17 34 13;cc view button;cn "View";
xywh 60 30 34 13;cc script button;cn "Script";
xywh 97 4 34 13;cc undo button;cn "Undo";
xywh 97 17 34 13;cc redo button;cn "Redo";
xywh 97 30 34 13;cc lock button;cn "Lock";
xywh 131 4 34 13;cc center button;cn "Center";
xywh 131 17 34 13;cc size button;cn "Size";
xywh 165 4 34 13;cc space button;cn "Space";
xywh 165 17 34 13;cc touch button;cn "Touch";
xywh 199 4 34 13;cc minus button;cn "Minus";
xywh 199 17 34 13;cc plus button;cn "Plus";
xywh 236 4 36 13;cc ok button;cn "OK";
xywh 236 17 36 13;cc cancel button;cn "Cancel";
xywh 134 34 50 13;cc id static;cn "";
xywh 185 34 56 13;cc pos static ss_center;cn "";
pas 3 1;pcenter;
rem form end;
)

DESIGN=: >(UNAME-:'Darwin'){DESIGN_NOTMAC;DESIGN_MAC
design_align=: 3 : 0
if. 2 > #SELECT do. return. end.
anc=. {. SELECT
bal=. }. SELECT
select. y
case. 'w' do.
  CCS=: ((<anc;0) { CCS) (<bal;0) } CCS
case. 'n' do.
  CCS=: ((<anc;1) { CCS) (<bal;1) } CCS
case. 'e' do.
  lef=. 0 >. (+/ (<anc;0 2) { CCS) - (<bal;2) { CCS
  CCS=: lef (<bal;0) } CCS
case. 's' do.
  top=. 0 >. (+/ (<anc;1 3) { CCS) - (<bal;3) { CCS
  CCS=: top (<bal;1) } CCS
end.
drawpaint ''
bufsnap''
)
design_close=: 3 : 0
try.
  saveform''
  smfocus''
catch. end.
destroy''
)
design_c_button=: 3 : 0
STEP=: (STEP = 1) { 1 4
wd 'setcaption c ',": STEP
)
design_cancel_button=: 3 : 0
smfocus''
destroy''
)
design_center_button=: 3 : 0
if. isempty SELECT do. return. end.
if. 0 = # (i.#CCS) -. SELECT do. return. end.
if. ifshiftkey '' do.
  hit=. (1 { PAS) + >./ +/"1 (<(<SELECT);1 3) { CCS
  top=. roundint -: hit - (<SELECT;3) { CCS
  CCS=: top (<SELECT;1) } CCS
else.
  wid=. (0 { PAS) + >./ +/"1 (<(<SELECT);0 2) { CCS
  lef=. roundint -: wid - (<SELECT;2) { CCS
  CCS=: lef (<SELECT;0) } CCS
end.
drawpaint ''
bufsnap''
)
design_enable=: 3 : 0
selectdesign''
select. # SELECT
case. 0 do.
  cmd=. '/minus 0/plus 0/size 0/space 0/touch 0'
case. 1 do.
  cmd=. '/minus 0/plus 0/size 0/space 0/touch 0'
case. 2 do.
  cmd=. '/minus 1/plus 1/size 1/space 0/touch 1'
case. do.
  cmd=. '/minus 1/plus 1/size 1/space 1/touch 1'
end.
wd ;'setenable '&, each (<;._1 cmd) ,each ';'
wd 'setenable center ',":(#SELECT) e. }. i.#CCS
)
design_helpformedit_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
design_lock_button=: 3 : 0
LOCK=: -.LOCK
wd 'setcaption lock ',LOCK pick 'Lock';'Unlock'
if. LOCK do.
  if. #SELECT do.
    SELECT=: ,{. SELECT
  end.
  CURSOR=: IDC_ARROW
  CAPTURE=: CAPNONE
  drawpaint''
  design_enable''
end.
)
design_move=: 3 : 0
if. ifshiftkey'' do.
  design_align y
else.
  design_move1 y
end.
)
design_move1=: 3 : 0
if. # SELECT do.
  m=. (y = 'es') - y = 'wn'
  c=. SELECT { CCS
  c=. c +"1 m, 0 0
  if. STEP > 1 do.
    ndx=. y e. 'sn'
    if. y e. 'es' do.
      c=. (STEP roundup ndx {"1 c) ndx }"0 1 c
    else.
      c=. (STEP rounddown ndx {"1 c) ndx }"0 1 c
    end.
  end.
  c=. 0 >. c
  CCS=: c SELECT } CCS
  drawpaint ''
  bufsnap''
end.
)
design_save_button=: 3 : 0
saveform''
)
design_script_button=: 3 : 0
smopen FNAME
smfocus''
)
design_size_button=: 3 : 0
if. 2 > #SELECT do. return. end.
anc=. {. SELECT
bal=. }. SELECT
if. ifshiftkey '' do.
  h=. (<anc;3) { CCS
  CCS=: h (<bal;3) } CCS
else.
  w=. (<anc;2) { CCS
  CCS=: w (<bal;2) } CCS
end.
drawpaint ''
bufsnap''
)
design_space_button=: 3 : 0
if. 3 > len=. #SELECT do. return. end.
if. ifshiftkey '' do.
  ccs=. viewccs''
  ndx=. SELECT /: (<SELECT;1) { ccs
  top=. (<ndx;1) { ccs
  hit=. (<ndx;3) { ccs
  spc=. ({:top) - ({.top) + +/ }: hit
  dif=. 0 >. roundint spc % <: len
  new=. ({.top) + }: +/\ hit + dif
  CCS=: new (<(}.ndx);1) } CCS
else.
  ndx=. SELECT /: (<SELECT;0) { CCS
  lef=. (<ndx;0) { CCS
  wid=. (<ndx;2) { CCS
  spc=. ({:lef) - ({.lef) + +/ }: wid
  dif=. 0 >. roundint spc % <: len
  new=. ({.lef) + }: +/\ wid + dif
  CCS=: new (<(}.ndx);0) } CCS
end.
drawpaint ''
bufsnap''
)
design_spread=: 3 : 0
if. 2 > #SELECT do. return. end.
bal=. }. SELECT
if. ifshiftkey '' do.
  bal=. bal /: (<bal;1) { CCS
  y=. (y * 1 + i.#bal) + (<bal;1) { CCS
  CCS=: y (<bal;1) } CCS
else.
  bal=. bal /: (<bal;0) { CCS
  x=. (y * 1 + i.#bal) + (<bal;0) { CCS
  CCS=: x (<bal;0) } CCS
end.
drawpaint ''
bufsnap''
)
design_touch_button=: 3 : 0
if. 2 > #SELECT do. return. end.
anc=. {. SELECT
bal=. }. SELECT
if. ifshiftkey '' do.
  ccs=. viewccs''
  top=. (<anc;1) { ccs
  bal=. bal /: (<bal;1) { ccs
  hit=. (<(anc,}:bal);3) { ccs
  y=. top + 0, +/\ >:hit
  CCS=: y (<(anc,bal);1) } CCS
else.
  lef=. (<anc;0) { CCS
  bal=. bal /: (<bal;0) { CCS
  x=. lef + 0, +/\ >:(<(anc,}:bal);2) { CCS
  CCS=: x (<(anc,bal);0) } CCS
end.
drawpaint ''
bufsnap''
)
design_view_button=: 3 : 0
if. #TESTLOC do.
  open=. wd :: 0: 'psel ',TESTHWNDP,';pclose'
  coerase :: ] TESTLOC
  TESTLOC=: TESTHWNP=: ''
  if. open do. return. end.
end.
TESTLOC=: cocreate ''
a=. form_create 1
try. wd__TESTLOC a
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {.". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}. a
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  info 'wd error ',msg,LF,cmd
  coerase :: ] TESTLOC
  TESTLOC=: ''
  return.
end.
wd 'pshow'
TESTHWNDP=: wd 'qhwndp'
selectdesign''
)
design_ok_button=: design_close

design_e_button=: design_move bind 'e'
design_n_button=: design_move bind 'n'
design_s_button=: design_move bind 's'
design_w_button=: design_move bind 'w'

design_minus_button=: design_spread bind _1
design_plus_button=: design_spread bind 1

design_new_button=: newcc_run
design_exit_button=: design_close
design_redo_button=: bufredo
design_undo_button=: bufundo
design_wincode_button=: wcode_run
design_wincontrol_button=: wcontrol_run
design_windel_button=: deletecc
design_winmenu_button=: wmenu_run
design_winnew_button=: newcc_run
design_winparent_button=: wparent_run
design_winscript_button=: design_script_button
design_winstatus_button=: wstatus_run
design_wintoolbar_button=: wtbar_run
drawback=: 3 : 0
glbrush glrgb FACE
glrect 0 0,GWH
glpen 1 0 [ glrgb 0 0 0
glpixel GRID * > ,{ i. each >. GWH % GRID
)
drawcontrols=: 3 : 0
CCX=: makeccx''
cns=. CPS
cap=. (({."1 CONTROLS) i. CLS) { (5 {"1 CONTROLS),<0
ids=. IDS
ndx=. /: (i.#CCX) e. SELECT
fns=. 'draw'&, each ndx { CLS
dat=. ndx { ids,.STY,.cns,.cap,.<"1 CCX
r=. ''
for_d. dat do.
  (>d_index{fns)~d
end.
)
drawforeground=: 3 : 0
colors=. RED,:BLUE
if. #SELECT do.
  ccs=. SELECT { CCX
  for_i. SELECT do.
    clr=. i ~: {. SELECT
    glrgb clr { colors
    glpen 3 0
    glbrushnull''
    glrect i_index { ccs
  end.
end.
if. #BOX do.
  glrgb {. colors
  glpen 2 0
  glbrushnull''
  glrect BOX
end.
if. ORDER do.
  glpen 1 0 [ glbrush glrgb FACE
  glrgb 0 0 0
  glfont 'bold' changefont GFONT
  for_i. CCX do.
    xy=. _4 + 2 {. i
    tx=. ": i_index
    glrect xy,0 1+glqextent tx
    gltextxy xy
    gltext tx
  end.
end.
)
drawform=: 3 : 0
drawinit''
drawsize 0
wd 'pshow'
)
drawinit=: 3 : 0
wd 'pc6j form'
wd 'xywh 0 0 100 100;cc s static;setshow s 0'
wd 'cc g isigraph nopas;'
HWNDP=: wd 'qhwndp'
HWNDG=: wd 'qhwndc g'
if. IFJNET do. glnodblbuf_jgl2_ 0 end.
wd 'pn "',((*#PCN) pick PID;PCN),'"'
wd MNU
wd SBR
wd TBR
wd 'setxywhx g 0 0 ',":GWH
wd 'pas 0 0'
)
drawpaint=: 3 : 0
form_g_paint''
glpaint''
if. # SELECT do.
  selectdesign''
  wd 'set id *', ({.SELECT) pick IDS
  wd 'set pos *',": ({.SELECT) { CCS
  wd 'psel ',HWNDP
end.
)
drawsize=: 3 : 0
makeccx''
wd 'psel ',HWNDP
fwh=. MINWH >. PAS + >./ +/"2 [ _2 [\"1 CCX
if. y *. fwh -: FWH do. return. end.
FWH=: fwh
wh=. _2 {. 0 ". wd 'qchildxywhx s'
fx=. 0 ". wd 'qformx'
wd 'setxywhx s 0 0 ',":FWH
wd 'pmovex ',":fx + 0 0,FWH - wh
)
form_g_paint=: 3 : 0
glsel HWNDG
glclear''
glfont GFONT
glcursor IDC_ARROW
drawsize 1
drawback''
drawcontrols''
drawforeground''
glcursor CURSOR
)
RCSIZE=: 12
CBSIZE=: 13
RBHIGH=: ". ;._2 (0 : 0)
4 11
5 11
6 11
7 11
10 2
10 3
11 4
11 5
11 6
11 7
10 8
10 9
)
RBLIGHT=: ". ;._2 (0 : 0)
9 3
10 4
10 5
10 6
10 7
9 8
2 9
3 9
8 9
9 9
4 10
5 10
6 10
7 10
)
RBSHADOW=: ". ;._2 (0 : 0)
4 0
5 0
6 0
7 0
2 1
3 1
8 1
9 1
1 2
2 2
1 3
0 4
0 5
0 6
0 7
1 8
1 9
)
RBDKSHADOW=: ". ;._2 (0 : 0)
4 1
5 1
6 1
7 1
2 2
3 2
8 2
9 2
2 3
1 4
1 5
1 6
1 7
2 8
)
drawbox=: 4 : 0
glpen 1 0 [ glrgb x
glbrushnull''
glrect y
)
drawbutton=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
r=. x + w
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
glpen 1 0 [ glrgb HIGH
glbrush glrgb FACE
glrect x,y,w,h
glpen 1 0 [ glrgb LIGHT
gllines x1,y1,r,y1
gllines x1,y1,x1,s
glpen 1 0 [ glrgb SHADOW
gllines r1,y1,r1,s1
gllines x1,s1,r,s1
glpen 1 0 [ glrgb DKSHADOW
gllines x,s,r,s
gllines r,y,r,s+1
n=. n, (0=#n) # d
'nx ny'=. glqextent n
tx=. x + -: w - nx
ty=. (y + 2) >. y + -: h - ny
glclip 2 2 _3 _3 + x,y,w,h
gltextxy tx,ty
gltext n
glclipreset''
)
drawcheckbox=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
glbrush glrgb FACE
if. 1 e. 'ws_border' E. s do.
  glpen 1 0 [ glrgb TEXT
  glrect x,y,w,h
  'x y w h'=. 1 1 _2 _2 + p
else.
  glpen 0 0 [ glrgb FACE
  glrect x,y,w,h
end.
y=. y + <. -: 0 >. h - RCSIZE
h=. RCSIZE
lt=. 1 e. 'bs_lefttext' E. s
x=. x + lt * w - h + 1
r=. x + h
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
glpen 1 0 [ glrgb SHADOW
glbrush glrgb HIGH
glrect x,y,h,h
glpen 1 0 [ glrgb DKSHADOW
gllines x1,y1,r,y1
gllines x1,y1,x1,s
glpen 1 0 [ glrgb LIGHT
gllines r1,y1,r1,s1
gllines x1,s1,r,s1
glpen 1 0 [ glrgb HIGH
gllines x,s,r,s
gllines r,y,r,s+1
'x y w h'=. p
n=. n, (0=#n) # d
'nx ny'=. glqextent n
x=. x + 3 + RCSIZE * lt=0
w=. w - 3 + RCSIZE
tx=. x + 2
ty=. <: y + <. -: h - ny
glclip x,y,w,h
gltextxy tx,ty
gltext n
glclipreset''
)
drawcombobox=: 3 : 0
'' drawinput y
'd s n c p'=. y
'x y w h'=. p
y=. y + CBSIZE*GSCALE''
r=. x + w
x1=. x + 1
r1=. r - 1
glpen 1 0 [ glrgb LIGHT
gllines x1,y,r1,y
glpen 1 0 [ glrgb HIGH
gllines x,(y+1),r,y+1
glpen 1 0 [ glrgb SHADOW
gllines x,(y+2),r,y+2
glpen 1 0 [ glrgb DKSHADOW
gllines x1,(y+3),r1,y+3
)
drawcombodrop=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
'' drawinput d;s;n;c;x,y,w,h

h=. h - 4
y=. y + 2
r=. x + w - 1
s=. y + h
x=. r - h + 1
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,h,h

glpen 1 0 [ glrgb HIGH
gllines 1 + x,y,(r-1),y
gllines 1 + x,y,x,s-1

glpen 1 0 [ glrgb SHADOW
gllines (x+1),(s-1),(r-2),s-1
gllines (r-2),(y+1),(r-2),s

glpen 1 0 [ glrgb DKSHADOW
gllines x,s,r,s
gllines (r-1),y,(r-1),s

w=. <. 0.25 * _2 + {. h
xy=. (x + >.-: h - +:w),y + <. -: h - w
glbrush glrgb TEXT
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
)
drawgroupbox=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
y=. y + 5
h=. h - 5
HIGH drawbox (1+x,y),w,h
glpixel (x,y+h),:(x+w),y
SHADOW drawbox x,y,w,h
n=. n, (0=#n) # d
'w h'=. 4 0 + glqextent n
x=. x + 6
y=. y + 5 - -: h
glpen 0 0 [ glbrush glrgb FACE
glrect x,y,w,h
gltextxy (x+2),y
gltext n
)
drawinput=: 4 : 0
'd s n c p'=. y
n=. (0 < #x) # d,' ',x
'x y w h'=. p
r=. x + w
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
glpen 1 0 [ glrgb SHADOW
glbrush glrgb HIGH
glrect x,y,w,h
glpen 1 0 [ glrgb DKSHADOW
gllines x1,y1,r,y1
gllines x1,y1,x1,s
glpen 1 0 [ glrgb LIGHT
gllines r1,y1,r1,s1
gllines x1,s1,r,s1
glpen 1 0 [ glrgb HIGH
gllines x,s,r,s
gllines r,y,r,s+1
glclip 2 2 _3 _3 + x,y,w,h
gltextxy (2*IFJAVA) + 3 2 + x,y
gltext n
glclipreset''
)
drawocx=: 3 : 0
'ocx' drawinput y
)
drawprogress=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
SHADOW drawbox p
DKSHADOW drawbox p + 1 1 _2 _2
glpen 1 0 [ glrgb HIGH
gllines (x+w-1),y,(x+w-1),y+h
gllines x,(y+h-1),(x+w),y+h-1
)
drawradiobutton=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
glbrush glrgb FACE
if. 1 e. 'ws_border' E. s do.
  glpen 1 0 [ glrgb TEXT
  glrect x,y,w,h
  'x y w h'=. 1 1 _2 _2 + p
else.
  glpen 1 0 [ glrgb FACE
  glrect x,y,w,h
end.
y=. y + <. -: 0 >. h - RCSIZE
h=. RCSIZE
lt=. 1 e. 'bs_lefttext' E. s
x=. x + lt * w - h
r=. x + h
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
xy=. x,y
glbrush glrgb HIGH
glpen 1 0 [ glrgb FACE
glrect 1 1 _2 _1 + x,y,h,h
glpen 1 0 [ glrgb SHADOW
glpixel xy +"1 RBSHADOW
glpen 1 0 [ glrgb DKSHADOW
glpixel xy +"1 RBDKSHADOW
glpen 1 0 [ glrgb LIGHT
glpixel xy +"1 RBLIGHT
glpen 1 0 [ glrgb HIGH
glpixel xy +"1 RBHIGH
'x y w h'=. p
n=. n, (0=#n) # d
'nx ny'=. glqextent n
x=. x + 3 + RCSIZE*lt=0
w=. w - 3 + RCSIZE
tx=. x + 2
ty=. <: y + <. -: h - ny
glclip x,y,w,h
gltextxy tx,ty
gltext n
glclipreset''
)
drawscrollbar=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
t=. h
s=. y + t - 1
x1=. x + 1
y1=. y + 1
xm=. x+t
xw=. x+w-t
xmt=. xm+t
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,w,t
glpen 1 0 [ glrgb HIGH
gllines x1,y1,(xm-1),y1
gllines x1,y1,x1,s
gllines (x1+t),y1,(xmt-1),y1
gllines (x1+t),y1,(x1+t),s
gllines (xw+1),y1,(x+w-1),y1
gllines (xw+1),y1,(xw+1),s
glpen 1 0 [ glrgb SHADOW
gllines (xm-1),y1,(xm-1),s
gllines x1,(s-1),xm,s-1
gllines (xmt-1),y1,(xmt-1),s
gllines (x1+t+1),(s-1),(xmt),s-1
gllines (x+w-2),y1,(x+w-2),s
gllines (xw+1),(s-1),(x+w-2),s-1
glpen 1 0 [ glrgb DKSHADOW
gllines xm,y,xm,s+1
gllines x,s,xm,s
gllines xmt,y,xmt,s+1
gllines (x+t),s,xmt,s
gllines (x+w-1),y,(x+w-1),s
gllines xw,s,(x+w),s

glbrush glrgb HIGH
glpen 1 0
glrect (xmt+1),y,(w-1+3*t),t
glbrush glrgb HIGH
glpen 1 0 [ glrgb FACE
glpixel ((xmt+1),y) +"1 makedots (w-1+3*t),t
h=. <. 0.25 * _2 + t
x=. x + <. -: t - h
y=. y + >.-: t - +:h
glbrush glrgb TEXT
glpen 1 0
glpolygon (x+h),y,x,(y+h),(x+h),y++:h
x=. x + w - t
glpolygon x,y,(x+h),(y+h),x,y++:h
)
drawscrollbarv=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
t=. w
r=. x + t - 1
x1=. x + 1
y1=. y + 1
ym=. y + t
yh=. y + h - t
ymt=. ym + t
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,t,h
glpen 1 0 [ glrgb HIGH
gllines x1,y1,x1,ym-1
gllines x1,y1,r,y1
gllines x1,(y1+t),x1,ym+t-1
gllines x1,(y1+t),r,y1+t
gllines x1,(yh+1),x1,y+h-1
gllines x1,(yh+1),r,(yh+1)
glpen 1 0 [ glrgb SHADOW
gllines x1,(ym-1),r,(ym-1)
gllines (r-1),y1,(r-1),ym
gllines x1,(ymt-1),r,(ymt-1)
gllines (r-1),(y1+t+1),(r-1),ymt
gllines x1,(y+h-2),r,(y+h-2)
gllines (r-1),(yh+1),(r-1),(y+h-2)
glpen 1 0 [ glrgb DKSHADOW
gllines x,ym,(r+1),ym
gllines r,y,r,ym
gllines x,ymt,(r+1),ymt
gllines r,(y+t),r,ymt
gllines x,(y+h-1),r,y+h-1
gllines r,yh,r,y+h
glbrush glrgb HIGH
glpen 1 0
glrect x,(ymt+1),t,h-1+3*t
glpen 1 0 [ glrgb FACE
glpixel (x,ymt+1) +"1 makedots t,h-1+3*t
w=. <. 0.25 * _2 + t
x=. x + >.-: t - +:w
y=. y + 1 + <. -: t - w
glbrush glrgb TEXT
glpen 1 0
glpolygon x,(y+w),(x+w),y,(x++:w),y+w
y=. y + h - t + 1
glpolygon x,y,(x+w),(y+w),(x++:w),y
)
drawspin=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
x1=. x + 1
y1=. y + 1
w2=. >. -: w
w=. +: w2
r=. x+w
s=. y+h
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,w,h
glpen 1 0 [ glrgb HIGH
glbrushnull''
glrect p + 1 1 _1 _1
gllines (x+w2+2),y1,(x+w2+2),s
glpen 1 0 [ glrgb SHADOW
gllines (r-1),y1,(r-1),s
gllines x1,(s-1),r,s-1
gllines (x+w2-1),y1,(x+w2-1),s
glpen 1 0 [ glrgb LIGHT
gllines (x+w2+1),y1,(x+w2+1),s
glpen 1 0 [ glrgb DKSHADOW
gllines r,y,r,s+1
gllines x,s,r,s
gllines (x+w2),y,(x+w2),s
d=. <. 0.25 * _2 + w2 <. h
x=. x + <. -: w2 - d
y=. y + >.-: h - +:d
glbrush glrgb TEXT
glpen 1 0
glpolygon (x+d),y,x,(y+d),(x+d),y++:d
x=. x + w2
glpolygon x,y,(x+d),(y+d),x,y++:d
)
drawspinv=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
x1=. x + 1
y1=. y + 1
h2=. >. -: h
h=. +: h2
r=. x+w
s=. y+h
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,w,h
glpen 1 0 [ glrgb HIGH
glbrushnull''
glrect p + 1 1 _1 _1
gllines x1,(y+h2+2),r,y+h2+2
glpen 1 0 [ glrgb SHADOW
gllines (r-1),y1,(r-1),s
gllines x1,(s-1),r,s-1
gllines x1,(y+h2-1),r,y+h2-1
glpen 1 0 [ glrgb LIGHT
gllines x1,(y+h2+1),r,y+h2+1
glpen 1 0 [ glrgb DKSHADOW
gllines r,y,r,s+1
gllines x,s,r,s
gllines x,(y+h2),r,y+h2
d=. <. 0.25 * _2 + h2 <. w
x=. x + >. -: w - +:d
y=. y + <. -: h2 - d
glbrush glrgb TEXT
glpen 1 0
glpolygon x,(y+d),(x+d),y,(x++:d),y+d
y=. y + h2
glpolygon x,y,(x+d),(y+d),(x++:d),y
)
drawstatic=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
glpen 0 0 [ glbrush glrgb FACE
glrect x,y,w,h
glclip 2 2 _3 _3 + x,y,w,h
gltextxy (2*IFJAVA) + 3 2 + x,y
n=. n, (0=#n) # d
gltext n
glclipreset''
)
drawstaticbox=: 3 : 0
'd s n c p'=. y
DKSHADOW drawbox p
)
drawtab=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
HIGH drawbox (1+x,y),w,h
glpixel (x,y+h),:(x+w),y
SHADOW drawbox x,y,w,h
)
drawtrackbar=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
wb=. 11
w=. w >. wb
hb=. 8 >. 22 <. h
h2=. <. -: hb-6
glbrush glrgb FACE
glpen 1 0
glrect p
glbrush glrgb LIGHT
glpen 1 0 [ glrgb HIGH
glrect (x+wb),(y+h2-2),(w-wb),4
gllines x,y,(x+wb+1),y
gllines x,y,x,y+hb-6
xy=. (x+1+i.6),.(y+hb-6)+i.6
glpixel xy
glpen 1 0 [ glrgb LIGHT
gllines (x+1),(y+1),(x+1),y+hb-6
gllines (x+1),(y+1),(x+wb-1),y+1
glpixel 1 0 +"1 xy
glpen 1 0 [ glrgb SHADOW
xy=. (x+wb-i.6),.(y+hb-7)+i.6
gllines (x+wb),(y+1),(x+wb),y+hb-6
gllines (x+wb+1),(y+h2-1),(x+w-2),y+h2-1
glpixel xy
glpen 1 0 [ glrgb DKSHADOW
glpixel 0 1 +"1 xy
gllines (x+wb+1),y,(x+wb+1),y+hb-6
gllines (x+wb+1),(y+h2-2),(x+w-1),y+h2-2
glpen 1 0 [ glrgb TEXT
gllines (x+6),(y+hb+1),(x+6),y+hb+5
gllines (x+w-6),(y+hb+1),(x+w-6),y+hb+5
)
drawtrackbarv=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
hb=. 11
h=. h >. hb
wb=. 8 >. 22 <. w
w2=. <. -: wb-6
glbrush glrgb FACE
glpen 1 0
glrect p
glbrush glrgb LIGHT
glpen 1 0 [ glrgb HIGH
glrect (x+w2-2),(y+hb),4,h-hb
gllines x,y,x,y+hb+1
gllines x,y,(x+wb-6),y
xy=. (x+1+i.6),.(y+hb-6)+i.6
xy=. (x+wb-6-i.6),.y+1+i.6
glpixel xy
glpen 1 0 [ glrgb LIGHT
gllines (x+1),(y+1),(x+wb-6),y+1
gllines (x+1),(y+1),(x+1),y+hb-1
glpixel 0 _1 +"1 xy
glpen 1 0 [ glrgb SHADOW
xy=. (x+wb-i.6),.(y+hb-7)+i.6
xy=. (x+wb-7-i.6),.y+hb-i.6
gllines (x+1),(y+hb),(x+wb-6),y+hb
gllines (x+w2-2),(y+hb+1),(x+w2-2),y+h-1
glpixel xy
glpen 1 0 [ glrgb DKSHADOW
glpixel 1 0 +"1 xy
gllines (x+w2-1),(y+hb+1),(x+w2-1),y+h-2
gllines x,(y+hb+1),(x+wb-6),y+hb+1
glpen 1 0 [ glrgb TEXT
gllines (x+wb+1),(y+6),(x+wb+5),y+6
gllines (x+wb+1),(y+h-6),(x+wb+5),y+h-6
)
drawcombolist=: drawcombodrop
drawedit=: 'edit' & drawinput
draweditm=: 'editm' & drawinput
drawisigraph=: 'isigraph' & drawinput
drawlistbox=: drawcombobox
drawrichedit=: 'richedit' & drawinput
drawricheditm=: 'richeditm' & drawinput
drawcheckedlistbox=: drawcombobox
drawdatagrid=: 'datagrid' & drawinput
drawdatepicker=: 'datepicker' & drawinput
drawdspinbox=: drawspin
draweditint=: 'editint' & drawinput
draweditmask=: 'editmask' & drawinput
draweditnum=: 'editnum' & drawinput
drawimage=: 'image' & drawinput
drawisidraw=: 'isidraw' & drawinput
drawisiprint=: 'isiprint' & drawinput
drawoleautomation=: 'oleautomation' & drawinput
drawopengl=: 'opengl' & drawinput
drawprogressbar=: drawprogress
drawspinbox=: drawspin
drawtimepicker=: 'datepicker' & drawinput
drawwebview=: 'webview' & drawinput
file_init=: 3 : 0
dat=. file_read FNAME
if. dat -: _1 do.
  info 'Unable to read: ',>FNAME
  0 return.
end.
nms=. a: -.~ {."1 dat
select. #nms
case. 0 do. newform ''
case. 1 do. openform 0 pick nms
case. do. pickform nms
end.
1
)
file_read=: 3 : 0
smsel y
smsave ''
dat=. freads y
if. dat -: _1 do. return. end.
file_read1 dat
)
file_read1=: 3 : 0
dat=. y
if. 0 = # dat do. i.0 2 return. end.
msk=. (LF,RFE,LF) E. dat
if. 0 = +/ msk do. ,: '';<dat return. end.
hdr=. msk i. 1
f=. [: </\ (LF,')',LF)&E.
msk=. f each msk <;.1 dat
msk=. _2 |. (hdr#0),;msk
ndx=. 1 + msk i: 1
ftr=. ndx }. dat
dax=. msk <;.2 dat
(; pairform each dax), '';ftr
)
openform=: 3 : 0
PID=: y
fdata=. file_read FNAME
if. fdata -: _1 do.
  info 'Unable to read: ',>FNAME
  0 return.
end.
ndx=. ({."1 fdata) i. <PID
dat=. (<ndx;1) pick fdata
txt=. {:"1 fdata
dat=. a: -.~ <;._2 dat
ndx=. 1 i.~ (deb each dat) = <RFE
PFE=: tolist ndx }. dat
dat=. dlb each ndx {. dat
dat=. dat -. a:
PDF=: deb (i.&'=' {. ]) 0 pick dat
dat=. }. dat
dat=. (, ';'"_ -. {:) each dat

msk=. (<'menu') = 4 {. each dat
MNU=: readmenudef getmenudef ; (msk # dat) ,each LF
dat=. (-. msk) # dat

msk=. (<'sbar') = 4 {. each dat
SBR=: readstatusdef getstatusdef ; (msk # dat) ,each LF
dat=. (-. msk) # dat

msk=. (<'tbar') = 4 {. each dat
TBR=: readtoolbardef gettoolbardef ; (msk # dat) ,each LF
dat=. (-. msk) # dat

msk=. (<'xywh') = 4 {. each dat
dat=. <;._2 each dat
child=. msk # dat
parent=. (-. msk) # dat
pdf=. 0 pick parent
PC6J=: 'pc6j '-:5{.>0 pick pdf
PC8J=: 'pc8j '-:5{.>0 pick pdf
PST=: (1 + # (((PC6J,PC8J) i. 1){::'pc6j ';'pc8j ';'pc '),PID) }. 0 pick pdf
PCN=: deldblquote ((PC6J+.PC8J){3 5) }. 1 pick pdf, a:
pop=. ';' cutopen 1 pick parent, a:
ndx=. I. (<'pas ') = 4 {. each pop
if. #ndx do.
  PAS=: 2 {. 0 ". 4 }. ({.ndx) pick pop
  pop=. (<<<ndx) { pop
else.
  PAS=: 6 6
end.
ndx=. I. (<'pmove ') = 6 {. each pop
if. #ndx do.
  PMV=: 4 {. 0 ". 6 }. ({.ndx) pick pop
  pop=. (<<<ndx) { pop
else.
  PMV=: $0
end.
POP=: pop
cx=. deb each 0 pick each child
cc=. deb each 1 pick each child
cn=. debs each 2 pick each child ,each <<''

msk=. (3 {. each cc) e. <'cc '
msk=. msk *. (3 {. each cn) e. 'cn ';'   '

if. 0 e. msk do.
  msg=. tolist ([: ; ,&';' each) each msk # child
  info 'Ignoring invalid child definition: ', msg
  cc=. msk # cc
  cn=. msk # cn
  cx=. msk # cx
end.

if. #cc do.
  CCS=: 0 ". &> 5 }. each cx
  cc=. 3 }. each cc
  ndx=. cc i. &> ' '
  IDS=: ndx {. each cc
  cc=. (ndx + 1) }.each cc
  ndx=. cc i. &> ' '
  CLS=: ndx {. each cc
  STY=: ws_add each (ndx + 1) }.each cc
  CPS=: deldblquote each 3 }. each cn
  ndx=. I. 'ocx:'&-: &> 4 {.each CLS
  if. #ndx do.
    txt=. 4 }.each ndx { CLS
    CPS=: txt ndx } CPS
    CLS=: (<'ocx') ndx } CLS
  end.
  ndx=. I. 'oleautomation:'&-: &> 14 {.each CLS
  if. #ndx do.
    txt=. 14 }.each ndx { CLS
    CPS=: txt ndx } CPS
    CLS=: (<'oleautomation') ndx } CLS
  end.
end.
create_show ''
)
pairform=: 3 : 0
dat=. <;.2 y
msk1=. (<'pc ') = 3 {.each dat
msk2=. ('pc6j ';'pc8j ') e.~ 5 {.each dat
msk=. 1 |. msk1+.msk2
msk=. msk *. (1: e. '0 : 0'&E.) &> dat
if. 0 = +/msk do.
  (<''),.y;''
else.
  ndx=. msk i: 1
  hdr=. ndx {. dat
  ftr=. ndx }. dat
  nam=. 1 pick ;: 1 pick ftr
  ('';;hdr) ,: nam;;ftr
end.
)
saveform=: 3 : 0
frm=. form_read''
fdata=. file_read FNAME
if. fdata -: _1 do.
  frm fwrite jpath '~temp/formedit.ijs'
  msg=. 'Unable to access file ',>FNAME
  msg=. msg,LF,LF,'Form written to file: ',jpath '~temp/formedit.ijs'
  info msg
  destroy'' return.
end.
ndx=. ({."1 fdata) i. <PID
if. ndx = #fdata do.
  fdata=. fdata, PID;frm
else.
  fdata=. (<frm) (<ndx;1) } fdata
end.
dat=. ; {:"1 fdata
smopen FNAME
old=. smread''
if. -. old -: dat do.
  loc=. id2loc name2id FNAME
  if. checkreadonly__loc'' do. return. end.
  smwrite dat
  smsave ''
end.
)
DELKEY=: 29
form_cancel=: 3 : 0
destroy''
)
form_close=: 3 : 0
saveform''
smfocus''
destroy''
)
form_g_char=: 3 : 0
if. DELKEY = a.i.{.sysdata do.
  deletecc''
end.
)
form_newcc_button=: newcc_run
form_parent_button=: 3 : 0
wd 'mbmsg parent *set parent styles etc'
)
form_read=: 3 : 0
r=. PDF,'=: 0 : 0',LF
r=. r, form_create 0
r,LF,PFE,LF
)
form_create=: 3 : 0
view=. {. y, 0
pst=. PST , view # ' closeok'
r=. deb (((PC6J,PC8J) i. 1){::'pc6j ';'pc8j ';'pc '),PID,' ',pst
r=. r,';',(*#PCN) # 'pn "',PCN,'";'
r=. r,LF
r=. r,MNU
r=. r,SBR
r=. r,TBR
r=. r, formcc_create 1
r=. r,'pas ',(":PAS),';'
r=. r, ; ,&';' each ~. POP, view # <'ptop'
r=. r,(*#PMV) # 'pmove ',(":PMV),';'
)
formcc_create=: 3 : 0
final=. y
cns=. CPS
cap=. (({."1 CONTROLS) i. CLS) { (5 {"1 CONTROLS),<0
ids=. IDS
if. -. final do.
  if. #ndx=. I. ids e. FORMISIGRAPHS do.
    new=. ndx { ids
    whilst. 1 e. new e. ids do.
      new=. new ,each '0'
    end.
    ids=. new ndx } ids
  end.
end.
dat=. ids,.CLS,.STY,.cns,.cap
ccs=. CCS
grp=. 0
r=. ''
for_i. i.#ids do.
  'd c s n p'=. i { dat
  s=. ws_del s
  select. c
  case. 'button' do.
    s=. s -. (-.final) # <'bs_ownerdraw'
  case. 'radiobutton' do.
    if. grp do.
      s=. s, (<'group') -. s
    else.
      s=. s -. <'group'
    end.
  case. 'isigraph' do.
    c=. final pick 'editm';'isigraph'
  case. 'isidraw' do.
    c=. final pick 'editm';'isidraw'
  case. 'isiprint' do.
    c=. final pick 'editm';'isiprint'
  case. 'tab' do.
    c=. final pick 'groupbox';'tab'
  case. 'ocx' do.
    c=. final pick 'editm';'ocx:',n
    n=. ''
  case. 'oleautomation' do.
    c=. final pick 'editm';'oleautomation:',n
    n=. ''
  end.
  grp=. c -: 'radiobutton'
  s=. towords s
  s=. (* # s) # ' ',s
  if. p *. #n do.
    n=. 'cn "',n,'";'
  else.
    n=. ''
  end.
  r=. r,'xywh ',": i { ccs
  r=. r,';cc ',d,' ',c,s,';',n,LF
end.
)
form_g_copy=: copyselect
form_g_paste=: pasteselect

form_nctrl_fkey=: form_newcc_button
form_pctrl_fkey=: form_parent_button
form_sctrl_fkey=: saveform
form_tctrl_fkey=: order
selectform=: 3 : 0
wd 'psel ',HWNDP
)
copyselect=: 3 : 0
copybuffer=: SELECT
)
pasteselect=: 3 : 0
if. 0=#copybuffer do. return. end.
for_cp. copybuffer do.
  pastecontrol (cp{CLS),(cp{IDS),(cp{CPS),(<cp{CCS),(cp{STY)
end.
SELECT=: copybuffer=: (-#copybuffer){.i.#IDS
drawpaint''
bufsnap''
1
)
pastecontrol=: 3 : 0
'class id caption ccs sty'=. y
if. 0 = #class do.
  info 'First select a class'
  0 return.
end.
if. 0 = #id do.
  id=. 'cc', class
end.
CCS=: CCS, 6 6 0 0 + ccs
IDS=: IDS, <id
CPS=: CPS, <caption
CLS=: CLS, <class
STY=: STY, <sty
drawpaint''
bufsnap''
1
)
boxtest=: 3 : 0
if. isempty CCX do. '' return. end.
bb=. 2 {. y
be=. bb + 1 + 2 }. y
bc=. 2 {."1 CCX
ec=. bc + 2 }."1 CCX
ndx=. I. *./"1 (bb <: "1 bc) ,. be >: "1 ec
ndx /: (ndx { CLS) = <'groupbox'
)
hittest=: 3 : 0
best=. ''
for_i. i.#CCX do.
  if. y rtest i{CCX do.
    if. #best do.
      old=. 2{.best{CCX
      new=. 2{.i{CCX
      old=. +/y-old
      new=. +/y-new
      if. new<old do. best=. i end.
    else.
      best=. i
    end.
  end.
end.
, best
)
rtest=: 4 : 0
xy=. 2{.y
wh=. xy+2}.y
*./(x>:xy),x<:wh
)
WMENU=: 0 : 0
pc6j wmenu owner;
xywh 1 20 158 11;cc s0 static rightmove;cn "Definition: id caption _  shortcut _ statushelp _ tooltip";
xywh 0 33 253 150;cc menudef editm ws_vscroll rightmove bottommove;
xywh 170 3 40 12;cc apply button leftmove rightmove;cn "&Apply";
xywh 170 17 40 12;cc help button leftmove rightmove;cn "&Help";
xywh 211 3 40 12;cc ok button leftmove rightmove;cn "OK";
xywh 211 17 40 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 0 0;pcenter;
rem form end;
)
wmenu_run=: 3 : 0
wd WMENU
wd 'pn "Menu - ',PID,'"'
selectmenu=: wd bind ('psel ',wd 'qhwndp')
wd 'set menudef *',getmenudef MNU
wd 'pshow;'
)
wmenu_apply_button=: 3 : 0
applymenudef ''
wd 'set menudef *',getmenudef MNU
wd 'setfocus menudef'
)
wmenu_help_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
wmenu_close=: 3 : 0
applymenudef ''
wd 'pclose'
)
wmenu_cancel_button=: 3 : 0
wd'pclose'
)
wmenu_ok_button=: wmenu_close
wmenu_cancel=: wmenu_cancel_button
applymenudef=: 3 : 0
new=. readmenudef menudef
if. MNU -: new do. return. end.
MNU=: new
drawpaint''
selectmenu ''
)
getmenudef=: 3 : 0
if. 0 = # y do. '' return. end.
ind=. ''
r=. ''
mnu=. cutopen y
mnu=. (mnu i.&> ';') {. each mnu
for_m. mnu do.
  m=. > m
  x=. m i. ' '
  select. x {. m
  case. 'menu' do.
    txt=. ' ', deb x }. m
    sep=. (txt = ' ') > ~:/\ txt = '"'
    'id cp sc tt sh'=. 5 {. (sep <;._1 txt) -. each '"'
    sel=. id,' ',cp,' _ ',sc,' _ ',tt,' _ ',sh
    sel=. (-. *./\. sel e. ' _') # sel
    r=. r, addLF ind, sel
  case. 'menupop' do.
    r=. r, addLF ind , (x }. m) -. ' "'
    ind=. ind, '  '
  case. 'menupopz' do.
    r=. r, addLF ind, '+'
    ind=. 2 }. ind
  case. 'menusep' do.
    r=. r, addLF ind, '-'
  case. do.
    info 'Unrecognized menu command: ',m
  end.
end.
r
)
readmenudef=: 3 : 0
def=. y
if. 0 = # def do. '' return. end.
ind=. ''
r=. ''
mnu=. a: -.~ deb each cutopen def
for_m. mnu do.
  m=. > m
  if. '+' = {. m do.
    r=. r, <'menupopz'
  elseif. '-' = {. m do.
    r=. r, <'menusep'
  elseif. do.
    x=. m i. ' '
    id=. x {. m
    bal=. deb x }. m
    if. #bal do.
      bal=. 4 {. <;._1 '_', bal
      bal=. dblquote each deb each bal
      r=. r, <'menu ',id,' ',towords bal
    else.
      r=. r,<'menupop ',dblquote id
    end.
  end.
end.
; r ,each (<';',LF)
)
WAITM=: 0.15
WAITD=: 0.5
j=. IDC_SIZENWSE,IDC_SIZENS,IDC_SIZENESW,IDC_SIZEWE
IDCSET=: j,IDC_SIZENWSE,IDC_SIZENS,IDC_SIZENESW,IDC_SIZEWE
gfocus=: 3 : 0
wd 'setfocus g'
)
form_g_mbldbl=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. return. end.
capture CAPNONE
DOWN=: ''
SELECT=: hittest mousepos''
if. #SELECT do.
  SELECT=: , {. SELECT
  drawpaint''
  if. ifctrlkey'' do.
    selectcode''
  else.
    wcontrol_run''
  end.
else.
  wparent_run''
end.
design_enable ''
)
form_g_mbldown=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. order_select'' return. end.
pos=. mousepos''
time=. sessiontime''
if. (DOWN -: pos) *. WAITD > time - MOUSETIME do.
  return.
end.
MOUSETIME=: time
DOWN=: pos
sel=. hittest DOWN
if. (#sel) *. ifctrlkey'' do.
  SELECT=: sel
  selectcode'' return.
end.
if. CURSOR e. IDCSET do.
  capture CAPSIZE,,topixels SELECT { CCS
else.
  dombldown sel
end.
gfocus''
drawpaint''
design_enable ''
)
dombldown=: 3 : 0
sel=. y
if. isempty sel do.
  SELECT=: $0
  capture CAPSELECT return.
end.
if. LOCK do.
  SELECT=: sel return.
end.
if. isempty SELECT do.
  SELECT=: sel
  mbsetcursor'' return.
end.
if. sel e. SELECT do.
  if. ifshiftkey'' do.
    SELECT=: SELECT -. sel
  else.
    SELECT=: SELECT /: SELECT ~: {. sel
    CURSOR=: IDC_CROSS
  end.
  return.
end.
if. ifshiftkey'' do.
  SELECT=: SELECT, sel
else.
  SELECT=: sel
  mbsetcursor''
end.
)
mbsetcursor=: 3 : 0
if. (-.LOCK) *. #SELECT do.
  if. CURSOR e. IDCSET do.
    capture CAPSIZE,,SELECT { CCS
  else.
    CURSOR=: IDC_CROSS
  end.
end.
)
form_g_mblup=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. return. end.
if. ''-:DOWN do. return. end.
UP=: mousepos''
dif=. UP - DOWN
oldcap=. CAPTURE
capture CAPNONE
cursor IDC_ARROW
select. oldcap
case. CAPSELECT do.
  box=. (UP <. DOWN), | dif
  SELECT=: boxtest box
case. CAPMOVE do.
  if. WAITM < (sessiontime'') - MOUSETIME do.
    c=. SELECT { CCS
    c=. 0 >. c +"1 [ (tounits dif), 0 0
    CCS=: c SELECT } CCS
  end.
case. CAPSIZE do.
  c=. SELECT { CCS
  d=. sizediff tounits dif
  c=. 0 >. c +"1 d
  CCS=: c SELECT } CCS
end.
drawpaint''
design_enable ''
bufsnap''
)
form_g_mmove=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. return. end.
if. 0=#SELECT do. return. end.
time=. sessiontime''
if. CAPTURE do.
  pos=. mousepos''
  ccs=. topixels ({.SELECT) { CCS
  select. CAPTURE
  case. CAPMOVE do.
    c=. ccs + (pos-DOWN), 0 0
  case. CAPSIZE do.
    c=. ccs + 0 0, pos-DOWN
  end.
  selectdesign''
  wd 'set pos *',": tocoordsxywh1 c
  wd 'setupdate pos'
  glsel HWNDG
elseif. #SELECT do.
  if. CURSOR = IDC_CROSS do.
    capture CAPMOVE,,SELECT { CCX
  else.
    p=. (mousepos '') sizetest ({.SELECT) { CCX
    if. p e. 3 4 5 do.
      cursor p { IDCSET
      IDCDIR=: p
    else.
      cursor IDC_ARROW
    end.
  end.
  glpaint^:(-.IFJNET) ''
end.
)
sizediff=: 3 : 0
'x y'=. y
select. IDCDIR
case. 0 do. x,y,-x,y
case. 1 do. 0,y,0,-y
case. 2 do. 0,y,x,-y
case. 3 do. 0 0,x,0
case. 4 do. 0 0,x,y
case. 5 do. 0 0 0,y
case. 6 do. x,0,(-x),y
case. 7 do. x,0,(-x),0
end.
)
sizetest=: 4 : 0
'mx my'=. x
'px py pw ph'=. y
ty=. (my > py-6) *. (my < py+6)
by=. (my > ph+py-6) *. (my < ph+py+6)
nx=. (ty,by) i. 1
if. (mx > px-6) *. (mx < px+6) do.
  nx { 0 6 7
elseif. (mx > pw+px-6) *. (mx < pw+px+6) do.
  nx { 2 4 3
elseif. do.
  nx { 1 5 _1
end.
)
NEWCC=: 0 : 0
pc6j newcc nomax nomin nosize owner;pn "New Control";
xywh 4 6 171 143;cc g0 groupbox;cn "Class";
xywh 12 17 47 11;cc standard radiobutton;cn "Standard";
xywh 60 17 33 11;cc ocx radiobutton group;cn "OCX";
xywh 100 17 42 11;cc oleautomation radiobutton group;cn "OleAuto";
xywh 9 30 160 112;cc class listbox ws_vscroll;
xywh 180 13 31 11;cc s0 static;cn "Id:";
xywh 212 12 56 12;cc id edit;
xywh 180 26 31 11;cc scaption static;cn "Caption:";
xywh 212 25 56 12;cc caption edit es_autohscroll;
xywh 274 7 42 12;cc ok button;cn "OK";
xywh 274 20 42 12;cc cancel button;cn "Cancel";
xywh 274 36 42 12;cc apply button;cn "Apply";
xywh 274 50 42 12;cc help button;cn "Help";
pas 5 5;pcenter;
rem form end;
)
newcc_run=: 3 : 0
wd NEWCC
if. IFJAVA+.-.IFWIN do.
  wd 'setenable ocx 0'
  wd 'setenable oleautomation 0'
end.
selectnewcc=: wd bind ('psel ',wd 'qhwndp')
newcc_standard_button ''
wd 'setfocus class'
wd 'pshow'
MOUSEIGNORE=: 1
)

toDEL=: [: ; (DEL&, @ (,&DEL)) each
newcc_standard_button=: 3 : 0
OCX=: 0
OLEAUTO=: 0
wd 'set standard 1'
wd 'set ocx 0'
wd 'set oleautomation 0'
wd 'set class ', toDEL {."1 STDCONTROLS
wd 'setselect class 0'
newcc_enable 0
)
newcc_enable=: 3 : 0
if. -.OCX+.OLEAUTO do.
  if. (<y;5) pick STDCONTROLS do.
    wd 'setshow scaption 1;setshow caption 1' return.
  end.
end.
wd 'set caption'
wd 'setshow scaption 0;setshow caption 0'
)
newcc_class_select=: 3 : 0
newcc_enable 0 ". class_select
)
newcc_ocx_button=: 3 : 0
OCX=: 1
OLEAUTO=: 0
getoleocx 1
wd 'set standard 0'
wd 'set ocx 1'
wd 'set oleautomation 0'
wd 'set caption'
wd 'setshow scaption 0;setshow caption 0'
wd 'set class ', toDEL {."1 OLEOCX
)
newcc_oleautomation_button=: 3 : 0
OCX=: 0
OLEAUTO=: 1
getoleocx 0
wd 'set standard 0'
wd 'set ocx 0'
wd 'set oleautomation 1'
wd 'set caption'
wd 'setshow scaption 0;setshow caption 0'
wd 'set class ', toDEL {."1 OLEAUT
)
newcc_apply_button=: 3 : 0
if. 0 = #class do.
  info 'First select a class'
  0 return.
end.

if. 0 = #id do.
  id=. 'cc', class
end.

if. 0 = validatecc id do. 0 return. end.

if. (<id) e. IDS do.
  msg=. 'The id "',id,'" is already used in this form'
  info msg
  0 return.
end.

if. 0 = #caption do.
  caption=. id
end.

if. OCX do.
  caption=. (({."1 OLEOCX) i. <class) pick {:"1 OLEOCX
  class=. 'ocx'
elseif. OLEAUTO do.
  caption=. (({."1 OLEAUT) i. <class) pick {:"1 OLEAUT
  class=. 'oleautomation'
end.

ndx=. ({."1 CONTROLS) i. <class
siz=. ((<ndx;4) pick CONTROLS) { FORMSIZES
CCS=: CCS, 0 0,siz
IDS=: IDS, <id
CPS=: CPS, <caption
CLS=: CLS, <class
STY=: STY, <''
drawpaint ''
bufsnap''
1
)
newcc_cancel=: 3 : 0
MOUSEIGNORE=: 0
wd 'pclose'
)
newcc_close=: 3 : 0
if. newcc_apply_button'' do.
  selectnewcc''
  newcc_cancel''
end.
)
newcc_help_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
newcc_ok_button=: newcc_close
newcc_cancel_button=: newcc_cancel
NEWFORM=: 0 : 0
pc6j newform nomax nomin nosize owner;pn "Form Edit - Id";
xywh 120 7 40 12;cc ok button;cn "OK";
xywh 120 21 40 12;cc cancel button;cn "Cancel";
xywh 8 10 38 10;cc label static;cn "Form Id:";
xywh 52 10 60 12;cc formid edit ws_border es_autohscroll;
xywh 8 25 38 10;cc label static;cn "Form Type:";
xywh 52 25 60 42;cc formtype listbox ws_vscroll;
pas 4 2;pcenter;
rem form end;
)
newform_run=: 3 : 0
frm=. {."1 [ 1!:0 jpath '~addons/ide/jnet/data/forms/*.ijs'
wd NEWFORM
NEWFORMHWNDP=: wd 'qhwndp'
wd 'set formtype ', ; frm ,each LF
wd 'setselect formtype 0'
wd 'setfocus formid'
wd 'pshow;'
)
newform_ok_button=: 3 : 0
if. 0 = #formid do.
  info 'First enter the Form Id'
  wd 'setfocus formid'
  return.
end.
if. 0 = #formtype do.
  info 'First select the Form Type'
  wd 'setfocus formtype'
  return.
end.
dat=. freads jpath '~addons/ide/jnet/data/forms/',formtype
PC6J=. 1 e. (LF,'pc6j ') E. dat
PC8J=. 1 e. (LF,'pc6j ') E. dat
if. PC6J do.
  ndx=. 1 i.~ (LF,'pc6j ') E. dat
  j=. (ndx + 6) }. dat
elseif. PC8J do.
  ndx=. 1 i.~ (LF,'pc8j ') E. dat
  j=. (ndx + 6) }. dat
elseif. do.
  ndx=. 1 i.~ (LF,'pc ') E. dat
  j=. (ndx + 4) }. dat
end.
formname=. deb (j i. ';') {. j
if. formid -: toupper formid do.
  formid=. tolower formid
end.
dat=. dat rplc ((((PC6J,PC8J) i. 1){::'pc6j ';'pc8j ';'pc '),formname) ; (((PC6J,PC8J) i. 1){::'pc6j ';'pc8j ';'pc '),formid
dat=. dat rplc (toupper formname) ; toupper formid
dat=. dat rplc (formname,'_') ; formid,'_'
txt=. freads FNAME
if. #txt do.
  dat=. txt, LF, dat
end.
fdata=. file_read1 dat
nms=. a: -.~ {."1 fdata
newform_close ''
smopen FNAME
smwrite dat
openform _1 pick nms
)
newform_close=: 3 : 0
wd 'psel ',NEWFORMHWNDP
wd 'pclose'
)
newform_cancel=: newform_cancel_button=: newform_close
newform=: newform_run
newform_enter=: newform_ok_button
order=: 3 : 0
if. 0 = #CCS do.
  ORDER=: 0
else.
  ORDER=: -. ORDER
end.
SELECT=: $0
drawpaint ''
)
order_select=: 3 : 0
sel=. hittest mousepos ''
if. isempty sel do. return. end.
msk=. (i.#CCS) ~: {. sel
if. ifctrlkey'' do.
  sortccs /: msk
  SELECT=: ,0
elseif. (#SELECT) *. ifshiftkey'' do.
  if. sel -: SELECT do. return. end.
  if. SELECT = <: #CCS do. return. end.
  new=. {. SELECT + 1
  sortccs /: (i.new), new + new }. msk
  SELECT=: , new
elseif. 1 do. return.
end.
drawpaint ''
)
sortccs=: 3 : 0
ndx=. y
CCS=: ndx { CCS
CLS=: ndx { CLS
CPS=: ndx { CPS
IDS=: ndx { IDS
STY=: ndx { STY
SELECT=: ndx i. SELECT
)
WPARENT=: 0 : 0
pc6j wparent owner;pn "Parent";
xywh 5 10 31 12;cc label static;cn "Id:";
xywh 38 10 69 11;cc id static rightmove;
xywh 5 25 31 12;cc label static;cn "Caption:";
xywh 38 24 69 12;cc caption edit ws_border es_autohscroll;
xywh 5 43 40 11;cc label static;cn "Styles:";
xywh 4 54 60 89;cc styles listbox lbs_multiplesel rightscale;
xywh 68 43 40 11;cc label static leftmove rightmove;cn "Options:";
xywh 67 54 60 89;cc options listbox lbs_multiplesel leftscale rightscale;
xywh 125 10 56 11;cc label1 static;cn "Right margin:";
xywh 125 25 56 11;cc label static;cn "Bottom margin:";
xywh 182 10 25 80;cc rmargin combodrop ws_vscroll;
xywh 182 24 25 80;cc bmargin combodrop ws_vscroll;
xywh 143 50 36 12;cc bpmove button leftmove rightmove;cn "pmove";
xywh 142 63 65 13;cc pmove static leftmove rightmove;
xywh 216 10 36 12;cc ok button leftmove rightmove;cn "OK";
xywh 216 26 36 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 216 50 36 12;cc apply button leftmove rightmove;cn "&Apply";
xywh 216 65 36 12;cc help button leftmove rightmove;cn "&Help";
pas 3 3;pcenter;
rem form end;
)
wparent_run=: 3 : 0
sty=. IFJNET{::'closeok dialog nomax nomenu nomin nosize owner';'closeok dialog escclose nomax nomenu nomin nosize owner'
opt=. 'pcenter ptop'
Wpmv=: PMV
wd WPARENT
selectparent=: wd bind ('psel ',wd 'qhwndp')
wd 'set styles ',sty
for_n. I. (;:sty) e. ;: PST do.
  wd 'setselect styles ',":n
end.
wd 'set options ',opt
for_n. I. (;:opt) e. POP do.
  wd 'setselect options ',":n
end.
wd 'setcaption id *',PID
wd 'set caption *',PCN
wd 'set rmargin ',": i.21
wd 'setselect rmargin ',": 0 { PAS
wd 'set bmargin ',": i.21
wd 'setselect bmargin ',": 1 { PAS
wd 'setcaption pmove *',":Wpmv
wd 'pshow;'
MOUSEIGNORE=: 1
)
wparent_apply_button=: 3 : 0
wparent_read''
drawpaint ''
)
wparent_bpmove_button=: 3 : 0
if. #Wpmv do.
  Wpmv=: ''
else.
  selectform''
  Wpmv=: roundint (0 ". wd 'qformx') % GSCALE''
end.
selectparent''
wd 'setcaption pmove *',": Wpmv
)
wparent_close=: 3 : 0
wparent_read ''
wparent_cancel ''
selectform''
cap=. (*#PCN) pick PID;PCN
wd 'pn "',cap,'"'
)
wparent_cancel=: 3 : 0
MOUSEIGNORE=: 0
wd 'pclose'
)
wparent_help_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
wparent_cancel_button=: wparent_cancel
wparent_ok_button=: wparent_close
wparent_read=: 3 : 0
PAS=: (0 ". rmargin), 0 ". bmargin
PCN=: caption
PMV=: Wpmv
POP=: cutopen options
PST=: towords cutopen styles
)
WSELECT=: 0 : 0
pc6j wselect nomax nomenu nosize owner;
xywh 4 5 72 58;cc slist listbox ws_vscroll;
xywh 84 6 36 12;cc ok button bs_defpushbutton;cn "OK";
xywh 84 20 36 12;cc cancel button;cn "Cancel";
xywh 84 36 36 12;cc new button;cn "New...";
pas 4 4;pcenter;
rem form end;
)
wselect_run=: 3 : 0
wd WSELECT
wd 'set slist ', ; y ,each LF
wd 'setselect slist 0'
wd 'pshow'
)
wselect_new_button=: 3 : 0
wd 'pclose'
newform''
)
wselect_ok_button=: 3 : 0
wd 'pclose'
openform slist
)
wselect_cancel=: 3 : 0
wd 'pclose'
destroy''
)
wselect_cancel_button=: wselect_close=: wselect_cancel
wselect_slist_button=: wselect_enter=: wselect_ok_button
pickform=: wselect_run
WSTATUS=: 0 : 0
pc6j wstatus nosize owner;
xywh 1 20 128 9;cc s0 static;cn "Definition: id width text";
xywh 0 31 200 100;cc statusdef editm ws_vscroll;
xywh 132 3 36 12;cc apply button;cn "&Apply";
xywh 132 17 36 12;cc help button;cn "&Help";
xywh 171 3 36 12;cc ok button;cn "OK";
xywh 171 17 36 12;cc cancel button;cn "Cancel";
pas 0 0;pcenter;
rem form end;
)
wstatus_run=: 3 : 0
wd WSTATUS
wd 'pn "Status - ',PID,'"'
selectstatus=: wd bind ('psel ',wd 'qhwndp')
wd 'set statusdef *',getstatusdef SBR
wd 'pshow;'
)
wstatus_apply_button=: 3 : 0
applystatusdef ''
wd 'set statusdef *',getstatusdef SBR
wd 'setfocus statusdef'
)
wstatus_help_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
wstatus_close=: 3 : 0
applystatusdef ''
wd 'pclose'
)
wstatus_cancel_button=: 3 : 0
wd 'pclose'
)
wstatus_ok_button=: wstatus_close
wstatus_cancel=: wstatus_cancel_button
applystatusdef=: 3 : 0
new=. readstatusdef statusdef
if. SBR -: new do. return. end.
SBR=: new
drawpaint''
selectstatus ''
)
getstatusdef=: 3 : 0
r=. ''
if. 0 = # y do. return. end.
sbr=. cutopen y
sbr=. deb each (sbr i.&> ';') {. each sbr
msk=. (<'sbarset') = 7 {. each sbr
sbr=. 7 }. each msk # sbr
for_s. sbr do.
  txt=. > s
  sep=. (txt = ' ') > ~:/\ txt = '"'
  'id wd tx'=. 3 {. (sep <;._1 txt) -. each '"'
  wd=. ": {. 0 ". wd
  r=. r, addLF id,' ',wd,' ',tx
end.
r
)
readstatusdef=: 3 : 0
sbr=. a: -.~ deb each LF cutopen y
r=. ''
if. 0 = # sbr do. return. end.
r=. <'sbar ',": # sbr
for_s. sbr do.
  txt=. > s
  x=. txt i. ' '
  id=. x {. txt
  txt=. (x + 1) }. txt
  x=. txt i. ' '
  wd=. ": {. 0 ". x {. txt
  txt=. (x + 1) }. txt
  r=. r , <'sbarset ',id,' ',wd,' "',txt,'"'
end.
r=. r, <'sbarshow'
; r ,each (<';',LF)
)
WTBAR=: 0 : 0
pc6j wtbar owner;
xywh 0 0 270 15;cc tbbmp isigraph rightmove;
xywh 0 16 270 12;cc tbids isigraph rightmove;
xywh 4 31 36 12;cc tbfile button;cn "File...";
xywh 42 32 218 11;cc tbname static;cn "";
xywh 4 46 89 11;cc tbflat checkbox;cn "Flat Toolbar (Jwdw)";
xywh 4 66 175 11;cc sdef static;cn "";
xywh 0 79 270 150;cc toolbardef editm es_autovscroll rightmove bottommove;
xywh 192 50 36 12;cc apply button leftmove rightmove;cn "&Apply";
xywh 192 64 36 12;cc help button leftmove rightmove;cn "&Help";
xywh 230 50 36 12;cc ok button leftmove rightmove;cn "OK";
xywh 230 64 36 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 0 0;pcenter;
rem form end;
)
wtbar_run=: 3 : 0
rerun=. 1 = {. y
if. rerun do.
  xywh=. wd 'qformx'
  wd 'psel wtbar;pclose'
end.
wd WTBAR
wd 'pn "Toolbar - ',PID,'"'
if. IFJNET do.
  glsel_jgl2_ 'tbbmp'
  glnodblbuf_jgl2_ 0
  glsel_jgl2_ 'tbids'
  glnodblbuf_jgl2_ 0
end.
selecttoolbar=: wd bind ('psel ',wd 'qhwndp')
wd 'setcaption sdef *Definition: id  index  tooltip  _  statushelp'
wtbar_showdef''
if. rerun do.
  wd 'pmovex ',xywh
end.
wd 'pshow;'
)
wtbar_showdef=: 3 : 0
'f s d'=. gettoolbardef TBR
if. # f do.
  TBFN=: f
end.
TBDS=: s
TBDF=: d
wtbar_showtoolbar''
)
wtbar_showtoolbar=: 3 : 0
try.
  dat=. 1!:1 < TBFN
catch.
  wdinfo 'Toolbar';'file read error: ',":>TBFN return.
end.
if. -. '.bmp' -: tolower _4 {. TBFN do.
  msg=. 'The Form Editor only supports bitmap toolbar files with extension .bmp.'
  wdinfo 'Toolbar';msg return.
end.

bits=. 0 pick getbmphdr dat
if. -. bits e. 4 8 24 do.
  wdinfo 'Toolbar';'Only 4, 8 or 24 bit bitmaps supported by Toolbar' return.
end.
BMP=: readbmp TBFN
'rws cls'=. $ BMP
cnt=. cls % 16
if. cnt ~: <.cnt do.
  wdinfo 'Toolbar';'Bitmaps should have a width of 16 pixels' return.
end.

wtbar_showbar''
wd 'set tbflat ',":1 e. 'tbstyle_flat' E. TBDS
wd 'setcaption tbname *',TBFN
wd 'set toolbardef *',TBDF
wd 'pas 0 0'
)
wtbar_showbar=: 3 : 0

'rws cls'=. $ BMP
cnt=. cls % 16
wh=. _2 {. 0 ". wd 'qchildxywhx tbbmp'
scl=. <./ wh % cls,rws
'w h'=. <. scl * cls,rws
exp=. (- 0: , }:) <. 0.5 + +/\ rws $ h % rws
bmp=. exp # BMP
exp=. (- 0: , }:) <. 0.5 + +/\ cls $ w % cls
bmp=. exp #"1 bmp

glsel 'tbbmp'
glclear''
glrgb 0 ". wd 'qcolor 15'
glpen 0 0
glbrush''
glrect 0 0,wh
glpixels (0 0, |.$bmp), ,bmp
wh=. _2 {. 0 ". wd 'qchildxywhx tbids'
glsel 'tbids'
glclear''
glrgb 0 ". wd 'qcolor 15'
glpen 0 0
glbrush''
glrect 0 0,wh
glrgb 0 0 0
glfont GFONT
pos=. <. (({.scl) * 8 + 16 * i. cnt) ,. 2
for_i. i. cnt do.
  gltextxy i { pos
  gltext ": i
end.
)
getbmphdr=: 3 : 0
toi=. 256&#.@(a.&i.)@(|."1)
dat=. y
bits=. toi 28 29 {dat
if. toi 30 31 32 33{dat do.
  wdinfo 'Toolbar';'Compressed format not supported'
  0 return.
end.
'off shdr cls rws'=. toi (10+i.4 4){dat
bits,rws,cls
)
wtbar_apply_button=: 3 : 0
applytoolbardef ''
wtbar_showdef''
wd 'setfocus toolbardef'
)
wtbar_help_button=: 3 : 0
htmlhelp602_j_ 'user/form_editor_overview.htm'
)
wtbar_close=: 3 : 0
applytoolbardef ''
wd 'pclose'
)
wtbar_cancel_button=: 3 : 0
wd'pclose'
)
wtbar_tbfile_button=: 3 : 0
while. 1 do.
  j=. '"Bitmap Files(*.bmp)|*.bmp" ofn_filemustexist ofn_nochangedir'
  d=. jpath '~system'
  f=. mbopen '"Select Bitmap File" "',d,'" "" ',j
  break.
end.
if. isempty f do. return. end.
if. TBFN -: f do. return. end.
TBFN=: f
TBR=: readtoolbardef TBFN;TBDS;toolbardef
wtbar_run 1
)
wtbar_tbflat_button=: 3 : 0
TBDS=: ('1'={. tbflat) # 'tbstyle_flat'
)
wtbar_ok_button=: wtbar_close
wtbar_cancel=: wtbar_cancel_button
wtbar_tbbmp_paint=: wtbar_showbar
applytoolbardef=: 3 : 0
TBR=: readtoolbardef TBFN;TBDS;toolbardef
drawpaint''
selecttoolbar ''
)
gettoolbardef=: 3 : 0
if. 0 = # y do. 3 $ <'' return. end.
ind=. ''
txt=. ''
tbr=. cutopen y
tbr=. (tbr i.&> ';') {. each tbr
tbr=. deb each tbr
tbr=. (0 < # &> tbr) # tbr
sty=. ''
for_m. tbr do.
  m=. > m
  x=. m i. ' '
  select. x {. m
  case. 'tbar' do.
    val=. deb 5 }. m
    if. '"' = {.val do.
      val=. }. val
      ndx=. val i. '"'
    else.
      ndx=. val i. ' '
    end.
    file=. ndx {. val
    val=. deb (ndx + 1) }. val
    sty=. deb (val i. ' ') }. val
  case. 'tbarset' do.
    sel=. ' ', deb x }. m
    sep=. (sel = ' ') > ~:/\ sel = '"'
    'id cp sc tt sh'=. 5 {. (sep <;._1 sel) -. each '"'
    if. #id do.
      txt=. txt, addLF id,'  ',sc,'  ',tt,'  _  ',sh
    else.
      txt=. txt, addLF sc
    end.
  case. 'tbarshow' do.
  case. do.
    info 'Unrecognized toolbar command: ',m
  end.
end.
file;sty;txt
)
readtoolbardef=: 3 : 0
'file sty txt'=. y
if. 0 = # txt do. '' return. end.
tbr=. a: -.~ deb each <;._2 txt,LF
if. #sty do.
  sty=. ' ',(":#tbr),' ',sty
end.
r=. <'tbar ',(dquote deb file),sty
for_m. tbr do.
  ind=. ": m_index
  m=. > m
  x=. m i. ' '
  id=. x {. m
  if. _1 ~: _1 ". id do.
    r=. r, <'tbarset "" ',ind, ' ',id
  else.
    m=. deb x }. m
    x=. m i. ' '
    cp=. x {. m
    m=. deb x }. m
    x=. m i. '_'
    tt=. dquote deb x {. m
    sh=. dquote deb (1 + x) }. m
    r=. r, < 'tbarset', ; ' ',each id;ind;cp;tt;sh
  end.
end.
r=. r , <'tbarshow'
; r ,each (<';',LF)
)
