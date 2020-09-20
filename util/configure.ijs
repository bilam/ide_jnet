require^:(0=4!:0<'IFWIN32') 'jsgrid jzgrid'
require 'jview'
coclass 'jcfg'

glbrush=: 11!:2004
glclear=: 11!:2007
gllines=: 11!:2015
glnodblbuf=: 11!:2070
glpen=: 11!:2022
glrect=: 11!:2031
glrgb=: 11!:2032
glsel=: 11!:2035
glpaint=: 11!:2020
delfret=: }: , {: -. PATHSEP_j_"_
dtb=: #~ +./\.@(' '&~:)
extijs=: , ([: -. '.'"_ e. ]) # '.ijs'"_
expand=: #^:_1

fexist=: (1:@(1!:4) :: 0:) @ (fboxname &>) @ boxopen
index=: #@[ (| - =) i.
info=: wdinfo @ ('Config'&;)
inx1=: #@[ (| - =) i.
isnnint=: ((1: e. 0&>) < (-: <.) *. 1: = #) :: 0:

pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP_j_)#y'
query=: wdquery 'Config'&;

a=. ''''
quote=: (a&,@(,&a))@ (#~ >:@(=&a))

sort=: /:~ :/:
subs=: 2 : 'm I. @(e.&n)@]} ]'
vectoblank=: deb @ (' ' subs LF)

tolist=: }. @ ; @: ((10{a.)&,@,@":each)
todel=: ; @: (DEL&, @ (,&DEL) each)
cutcommas=: 3 : 0
if. #y do.
  a: -.~ deb each <;._1 ',', y
else.
  ''
end.
)
freads=: ''&$: : (4 : 0)
y=. boxopen y
f=. 1!:(1 11 {~ 2=#y)
dat=. f :: _1: y
if. (dat -: _1) +. 0=#dat do. return. end.
dat=. dat,LF -. {:dat=. toJ dat
if. 'b'e.x do. dat=. <;._2 dat
elseif. 'm'e.x do. dat=. ];._2 dat
end.
)
fwrites=: 4 : 0
y=. boxopen y
dat=. ":x
if. -. 0 e. $dat do.
  if. 1>:#$dat do.
    dat=. toHOST dat
    dat=. dat,(LF ~: {:dat)#CRLF
  else. dat=. dat,"1 CRLF
  end.
end.
dat=. ,dat
f=. #@[ [ 1!:2
dat f :: _1: y
)
moveindex=: 4 : 0
'ndx dat'=. y
if. x do.
  nd1=. (<:#dat) <. ndx+1
else.
  nd1=. 0 >. ndx-1
end.
ind=. ndx, nd1
nd1;<(|. ind { dat) ind} dat
)
nubmatrix0=: ([: ~: [: {."1 ]) # ]
textline=: 3 : 0
deb ; (,&' ' ;._2) y
)
towordlist=: 3 : 0
n=. boxxopen y
m=. ' ' e.&> n
p=. m { '';'"'
}. ' ' ,each p ,each n ,each p
)
18!:4 <'jcfg'
BOXES=: ((16+i.11) { a.),'+++++++++|-',:218 194 191 195 197 180 192 193 217 179 196{a.
MAXSMSTYLE=: IFJAVA { 3 2
SMCOLORORG=: ''
0!:0 <jpath '~addons/ide/jnet/config/colordef.ijs'
boxfont=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <;._1 font
)
cutfolders=: 3 : 0
if. 0=#y do. i.0 3 return. end.
if. '''' = {. y do.
  y=. 3{."1 ".;._2 y
  (,each 2 {."1 y) 0 1 }"1 y return.
end.
j=. <;._2 y
if. (_2 {. 0 pick j) e. ' ',.'01' do.
  sub=. <&> 0 ". _2 {.&> j
  j=. _2 }.each j
else.
  sub=. <0
end.
ndx=. j i.&> ' '
nms=. ndx {.each j
pth=. deb each (ndx+1) }.each j
if. 0~:4!:0<'IFWIN32' do.
  sub=. (#nms)#(<0)
end.
nms,.pth,.sub
)
wdc=: 3 : 0
try. wd y
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {. ". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}.y
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  wdinfo 'Window Driver';'wd error ',msg,LF,cmd
end.
)
cfread=: 3 : 0
0!:0 <jpath '~addons/ide/jnet/config/stdcfg.ijs'
0!:0 :: ] <jpath '~config/config.ijs'
ADDNAMES=: ''
0!:0 :: ] <jpath '~addons/config/config.ijs'
if. #ADDNAMES do.
  nms=. <;._1 &> ' ' ,each <;._2 jpathsep ADDNAMES
  nms=. nms ,each "1 '';'~addons',PATHSEP_j_
  Public_j_=: /:~ ~. Public_j_,nms
end.
OUTPUT=: 0, }. OUTPUT
USERFOLDERS=: cutfolders USERFOLDERS
FORMAT=: FORMAT,(#FORMAT) }. 1 0 2 1 0 0
)
configure=: 3 : 0
if. y=0 do.
  cfread''
end.
configrun y
configdel ''
)
configrun=: 3 : 0

9!:3 DISPLAYFORM
9!:7 BOXFORM { BOXES
9!:11 PRINTPREC
9!:17 BOXPOS
9!:21 (2&^ ^: (<&_)) MEMORYLIM
9!:37 OUTPUT
try. 9!:49 XNAMES catch. end.
11!:0 ::0: 'setj mb ', ":OPTMB
11!:0 ::0: 'setj oldisigraph ', ":OPTOLDISIGRAPH
11!:0 ::0: 'setj pc6j ', ":OPTPC6J
11!:0 ::0: 'setj twip ', ":OPTTWIP
if. IFUNIX do.
  FIXFONT_z_=: FIXFONTJ
  PROFONT_z_=: PROFONTJ
else.
  FIXFONT_z_=: FIXFONTW
  PROFONT_z_=: PROFONTW
end.
FIXFONTWH_z_=: (fixfontsize ::])^:(-.IFCONSOLE) 8 16
FIXFONTDEF_jijs_=: FIXFONT_z_
CONFIRMCLOSE_j_=: CONFIRMCLOSE
DIRTREEX_j_=: DIRTREEX
EPSREADER_j_=: EPSREADER
FORMAT_j_=: FORMAT
FORMSIZES_j_=: FORMSIZES
P2UPFONT_j_=: P2UPFONT
PDFREADER_j_=: PDFREADER
PRINTERFONT_j_=: PRINTERFONT
PRINTOPT_j_=: PRINTOPT
READONLY_j_=: READONLY
SHOWSIP_j_=: SHOWSIP
SMPRINT_j_=: SMPRINT
STARTUP_j_=: STARTUP
if. 0~:4!:0<'IFWIN32' do.
else.
  USERFOLDERS_j_=: USERFOLDERS
end.
XDIFF_j_=: XDIFF

if. -.IFCONSOLE do.
  clr=. getcolors SMCOLOR
  if. -. clr -: SMCOLORORG do.
    setcolors clr
  end.
  set_fkeys_jijs_ FKEYS
  set_skeys_jijs_ SKEYS

  SMINIT_jijs_=: SMINIT
  SMSIZE_jijs_=: SMSIZE
  SMSTYLE_jijs_=: MAXSMSTYLE <. SMSTYLE
  if. 0~: 4!:0 <'NEWUSER_jijs_' do. NEWUSER_jijs_=: NEWUSER end.
  wdc 'fontdef ',PROFONT
  if. y do.
    setfontall_jijs_ FIXFONT
    setpnall_jijs_ ''
    wd 'psel ',JCFH
  end.
end.

)
fixfontsize=: 3 : 0
wd 'pc6j abc'
try.
  wd 'xywh 0 0 10 10;cc g isigraph'
  11!:2012 FIXFONT_z_
  res=. 11!:2057 'X'
  wd ::0: 'pclose'
  res
catch.
  wd ::0: 'pclose'
  13!:8[3
end.
)
configdel=: coerase bind (<'jcfg')
config=: 3 : 0
if. wdisparent 'cfmain' do.
  wd 'psel cfmain;pactive' return.
end.
TABNDX=: 0
FKEYNDX=: 0
cfread''
setfields''
COLORDATAORG=: COLORDATA
SMCOLORIDORG=: SMCOLORID
SMCOLORORG=: getcolors SMCOLOR
cfmain_run''
)
cfmain_cancel_button=: 3 : 0
wd 'fontdef ',PROFONT
setcolors COLORDATAORG
setfontall_jijs_ FIXFONT
wd 'psel ',JCFH
wd 'pclose'
configdel ''
smselout_jijs_''
smfocus_jijs_''
)
cfmain_cancel=: cfmain_cancel_button
cfmain_default_button=: 3 : 0
j=. 'This sets the default configuration for all items.',LF,LF
j=. j, 'OK to continue?'
if. 2 query j do. return. end.
0!:0 <jpath '~addons/ide/jnet/config/stdcfg.ijs'
setfields''
info 'Default configuration set'
now=. TABNDX { TABGROUPS
fms=. (LOADED -. now), now
for_f. fms do.
  nam=. > f
  (nam,'_run')~1
  wd 'setshow ',nam,' ', ": f-:now
end.
)
cfmain_ok_button=: 3 : 0
if. #smfont do.
  ('FIXFONT',IFUNIX{'WJ')=: smfont
end.
SMPRINT=: SMPRINT,(0=#SMPRINT)#'print'
PRINTOPT=: }. ; ';' ,each PRINTOPTX
BOXFORM=: '1'={.ascii
DISPLAYFORM=: ('1'=linear,box,tree,parens)#5 2 4 6
NEWUSER=: ". newuser
STATUSBAR=: ". statusbar

(2 }.each ALLTABGROUPS)=. ALLTABGROUPS e. LOADED
if. color do.
  SMCOLOR=: setcolordata COLORDATA
  try.
    smsel_jijs_ SAMPLEFILE
    smsave_jijs_''
    smclose_jijs_''
  catch.
  end.
  smselout_jijs_''
end.
if. forms do.
  if. #fontdef do.
    ('PROFONT',IFUNIX{'WJ')=: fontdef
  end.
  FORMSIZES=: 0 ". &> bwidth;bheight;ewidth;eheight;lheight
end.
if. lint do.
  cflint_read''
  FORMAT=: CFFMT
end.
if. opts do.
  j=. 9!:11 :: _1: [ _1 ". cpp
  if. _1-:j do.
    info 'Invalid setting for print precision'
    return.
  end.
  PRINTPREC=: 9!:10''

  linelen=. _1 ". maxlinelength
  if. -. isnnint linelen do.
    info 'Invalid setting for Max Line Length'
    return.
  end.

  linebef=. _1 ". maxlinesbefore
  if. -. isnnint linebef do.
    info 'Invalid setting for Max Lines Before'
    return.
  end.
  lineaft=. _1 ". maxlinesafter
  if. -. isnnint lineaft do.
    info 'Invalid setting for Max Lines After'
    return.
  end.
  OUTPUT=: 0, linelen, linebef,lineaft

  XNAMES=: 0 ". cbxnames
end.
if. print do.
  P2UPFONT=: p2font,(0=#p2font)#P2UPFONT
  PRINTERFONT=: pfont,(0=#pfont)#PRINTERFONT
end.
if. fkeys do.
  FKEYS_jijs_=: BOXFKEYS
  FKEYS=: unboxfkeys_jijs_ BOXFKEYS
end.
if. sess do.
  cfsess_read''
end.
if. skeys do.
  mn=. MENU -. OLDMENU
  if. 0 = #mn do.
    SKEYS=: ''
  else.
    a=. 0 {"1 mn
    b=. 1 {"1 mn
    SKEYS=: ; a ,each ' ' ,each b ,each LF
  end.
end.
if. start do.
  SMINIT=: 4 {. a , (#a) }. 0 0 700 500 [ a=. 0 ". sminit
  SMSIZE=: 2 {. a , (#a) }. 700 500 [ a=. 0 ". smsize
  STARTUP=: startup
  SMSTYLE=: 0 ". smstyle_select
end.
if. '1'=saveconfig do. configsave'' end.
configure 1

wd 'pclose'
)

cfmain_close=: cfmain_ok_button
mbfont=: 3 : 0
arg=. y
if. #arg do.
  arg=. boxfont arg
  arg=. ({.arg), tolower each }.arg
  arg=. arg -. 'ansi';'oem';'default'
  arg=. }: ; ,&' ' &.> arg
end.
if. IFJNET do.
  res=. wd 'mbfont "Select font" ',arg
else.
  res=. wd 'mbfont ',arg
end.
if. IFJAVA do.
  txt=. ' ',res
  b=. (txt=' ') > ~:/\txt='"'
  txt=. a: -.~ b <;._1 txt
  if. 3 = #txt do.
    num=. _1 ". &> txt
    if. ((1 { num) e. 0 1 2) *. _1 ~: 2 { num do.
      sty=. (1 { num) pick '';'bold';'italic'
      res=. (0 pick txt),' ',(2 pick txt),' ',sty
    end.
  end.
end.
deb res
)
setfields=: 3 : 0
if. IFUNIX do.
  smfont=: FIXFONTJ
  fontdef=: PROFONTJ
else.
  smfont=: FIXFONTW
  fontdef=: PROFONTW
end.
if. 0 = #SMCOLOR -. LF,' ' do. SMCOLOR=: '' end.
COLORDATA=: getcolordata SMCOLOR
newuser=: ":NEWUSER
p2font=: P2UPFONT
pfont=: PRINTERFONT
PRINTOPTX=: ';' cutopen PRINTOPT
'linear box tree parens'=: 1 ": 5 2 4 6 e. DISPLAYFORM
'linedraw ascii'=: 1 ": 0 1=BOXFORM
statusbar=: ":STATUSBAR
'bwidth bheight ewidth eheight lheight'=: ": each FORMSIZES
sminit=: ": SMINIT
smsize=: ": SMSIZE
BOXFKEYS=: boxfkeys_jijs_ FKEYS
)
CFEDSKEY=: 0 : 0
pc6j cfedskey dialog owner;pn "Menu Shortcuts Edit";
xywh 7 9 52 11;cc s0 static;cn "Menu Item:";
xywh 61 9 110 100;cc item combolist ws_vscroll;
xywh 7 28 52 11;cc s1 static;cn "Shortcut Key:";
xywh 61 27 110 100;cc menu combolist ws_vscroll;
xywh 178 9 52 12;cc ok button;cn "OK";
pas 6 6;pcenter;
rem form end;
)
cfedskey_run=: 3 : 0
sk=. '{none}';skeyevents''
wd CFEDSKEY
if. 0 <: SKEYNDX do.
  'fn ck id'=. SKEYNDX { MENU
  wd 'set item *',id
  wd 'setselect item 0'
  wd 'setenable item 0'
  wd 'set menu ',todel sk
  wd 'setselect menu ',": sk i. <ck
else.
  msk=. 0 = # &> 1 {"1 MENU
  if. -. 1 e. msk do.
    info 'All menu items have shortcuts'
    wd 'pclose' return.
  end.
  wd 'set item ',todel msk # 2 {"1 MENU
  wd 'set menu ',todel sk
end.
wd 'pshow'
)
cfedskeyerr=: wdinfo @ ('Menu Shortcuts Edit'&;)
cfedskey_cancel_button=: 3 : 0
wd 'pclose'
)
cfedskey_ok_button=: 3 : 0
cfedskey_setmenu''
wd 'psel cfmain'
cfshowskeyset''
wd 'psel cfedskey;pclose;psel cfmain'
)
cfedskey_setmenu=: 3 : 0
if. 0 > SKEYNDX do.
  if. 0 = #item do. return. end.
  SKEYNDX=: (2 {"1 MENU) i. < item
end.
if. menu -: '{none}' do.
  MENU=: (<<<SKEYNDX) { MENU
  SKEYNDX=: _1
else.
  if. (<menu) e. (<<<SKEYNDX) { 1 {"1 MENU do.
    msg=. 'Shortcut ',menu,' is already in use.'
    msg=. msg,LF,'Add it anyway?'
    if. 2 wdquery 'Menu Shortcuts Edit';msg do. return. end.
  end.
  MENU=: (<menu) (<SKEYNDX;1) } MENU
end.
)
skeyevents=: 3 : 0
f=. 'F' ,each ": each 1 + i.12
r=. f
r=. r, (<'Ctrl+') ,each f
r=. r, (<'Shift+') ,each f
r=. r, (<'Ctrl+Shift+') ,each f
a=. a. {~ ; (a. i. 'A0') + each i. each 26 10
s=. (<'Ctrl+') ,each a
s=. s, (<'Ctrl+Shift+') ,each a
s=. s -. 'Ctrl+C';'Ctrl+V';'Ctrl+X';'Ctrl+Z'
s, r
)
CFEDFKEY=: 0 : 0
pc6j cfedfkey dialog owner;pn "FKeys Edit";
xywh 7 8 61 11;cc sfkey static;cn "Function Key:";
xywh 70 8 60 11;cc keyname static;cn "keyname";
xywh 70 7 121 100;cc key combolist ws_vscroll;
xywh 7 29 74 53;cc g0 groupbox;cn "Output";
xywh 14 40 59 12;cc noisy radiobutton;cn "Noisy";
xywh 14 53 59 12;cc quiet radiobutton group;cn "Quiet";
xywh 14 66 59 12;cc prompt radiobutton group;cn "Prompt";
xywh 7 91 34 11;cc s0 static;cn "Label:";
xywh 42 91 95 12;cc label edit ws_border es_autohscroll;
xywh 7 108 34 11;cc s1 static;cn "Code:";
xywh 42 108 183 12;cc code edit ws_border es_autohscroll;
xywh 208 7 52 12;cc ok button;cn "OK";
xywh 208 23 52 12;cc cancel button;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)
cfedfkey_run=: 3 : 0
wd CFEDFKEY
if. 0 <: FKEYNDX do.
  'key out label code'=. FKEYNDX{BOXFKEYS
  wd 'set keyname ',": fkeycase_jijs_ key
  wd 'set prompt ',":out='0'
  wd 'set quiet ',":out='1'
  wd 'set noisy ',":out='2'
  wd 'set label *',label
  wd 'set code *',code
  wd 'setshow key 0'
else.
  all=. , ('F',each ":each 2 + i.11) ,each"0/ '';'Alt';'Ctrl';'CtrlShift';'Shift'
  usd=. fkeycase_jijs_ each {."1 BOXFKEYS
  dif=. all -. usd
  if. 0 = #dif do.
    info 'All function keys are assigned'
    wd 'pclose' return.
  end.
  wd 'set key ',todel dif
  wd 'setselect key 0'
end.
wd 'pshow'
)
cfedfkeyerr=: wdinfo @ ('Fkeys Edit'&;)
cfedfkey_cancel_button=: 3 : 0
wd 'pclose'
)
cfedfkey_ok_button=: 3 : 0
if. 0 <: FKEYNDX do.
  key=: 0 pick FKEYNDX{BOXFKEYS
else.
  key=: tolower key
end.

out=. ": (prompt,quiet,noisy) i. '1'
if. 0=#label do. cfedfkeyerr 'Enter the Label' return. end.
if. 0=#code do. cfedfkeyerr 'Enter the Code' return. end.
rep=. key;out;label;code
if. 0 <: FKEYNDX do.
  BOXFKEYS=: rep FKEYNDX } BOXFKEYS
else.
  if. #BOXFKEYS do.
    j=. rep,BOXFKEYS
    srt=. 0 ". each (}.each {."1 j) -. each <(>: a.i.'9') }. a.
    BOXFKEYS=: j /: srt ,. j
    FKEYNDX=: ({."1 BOXFKEYS) i. <key
  else.
    BOXFKEYS=: ,:rep
    FKEYNDX=: 0
  end.
end.
wd 'psel cfmain'
cfshowfkeyset''
wd 'psel cfedfkey;pclose;psel cfmain'
)
cfedfkey_cancel=: cfedfkey_cancel_button
cfedfkey_close=: cfedfkey_cancel_button
SAMPLEFILE=: jpath '~addons/ide/jnet/config/colorsmp.ijs'
CFCOLOR=: 0 : 0
pc6j cfcolor;pn "Session Color";
xywh 6 8 288 29;cc g0 groupbox;cn "Scheme";
xywh 11 19 160 120;cc scheme combolist ws_vscroll;
xywh 183 19 52 12;cc saveas button;cn "Save As...";
xywh 236 19 52 12;cc deletescheme button;cn "&Delete...";
xywh 6 44 288 140;cc g1 groupbox;cn "Item";
xywh 11 55 160 127;cc item listbox ws_vscroll;
xywh 183 56 52 12;cc color button;cn "Color...";
xywh 236 56 52 12;cc add button;cn "&Add";
xywh 183 68 52 12;cc edit button;cn "Edit...";
xywh 236 68 52 12;cc delete button;cn "&Delete...";
xywh 184 97 105 14;cc gcolor isigraph;
xywh 184 114 90 11;cc italic checkbox;cn "Italic";
xywh 184 126 90 11;cc underline checkbox;cn "Underline";
xywh 183 150 52 12;cc moveup button;cn "&Move Up";
xywh 236 150 52 12;cc movedn button;cn "&Move Down";
xywh 183 166 105 12;cc sample button;cn "Show Sample";
pas 2 2;pcenter;
rem form end;
)
cfcolor_run=: 3 : 0
if. y=0 do.
  wd CFCOLOR
  if. IFJNET do. glnodblbuf 0 end.
end.
glsel 'gcolor'
COLORDATA=: getcolordata SMCOLOR
COLORMB=: 48$255
ckread''
csread''
css=. {."1 COLORSCHEMES
names=. 4 {"1 COLORDATA
cfcolorsetschemes''
if. SMCOLORID -: 'None' do. cfdisable 1 end.
wd 'set item *',tolist names
cfcoloritem 0
)
cfcolor_act=: 3 : 0
glsel 'gcolor'
)
cfcolor_color_button=: 3 : 0
sel=. 0 ". item_select
ndx=. < sel;1
old=. > ndx { COLORDATA
new=. ,0 ". wd 'mbcolor ',":old,COLORMB
if. #new do.
  if. -. new -: old do.
    COLORDATA=: (<3 {. new) ndx} COLORDATA
    COLORMB=: 3 }. new
    cfcoloranon ''
    cfcolorgraph 3 {. new
    cfcolorapply''
  end.
end.
)
cfcolor_delete_button=: 3 : 0
sel=. 0 ". item_select
'num val j j txt j'=. sel { COLORDATA
if. num e. 0 1 do.
  info 'You cannot delete this color item' return.
end.
if. 0 = 2 query 'OK to delete color item:',LF,LF,txt do.
  cfcoloranon''
  COLORDATA=: (<<<sel) { COLORDATA
  nums=. > {."1 COLORDATA
  nums=. nums - (num e. USRCOLORS) *. nums > num
  COLORDATA=: (<&>nums) ,. }."1 COLORDATA
  sel=. sel <. <: #COLORDATA
  sel cfcolorreset ''
end.
)
cfcolor_deletescheme_button=: 3 : 0
sel=. 0 ". scheme_select
if. (<scheme) e. 'JStandard';'JReverse' do.
  info 'You cannot delete ',scheme return.
end.
if. 0 = 2 query 'OK to delete ',scheme,'?' do.
  COLORSCHEMES=: (<<<sel) { COLORSCHEMES
  cfcolorsetscheme sel <. _2 + #COLORSCHEMES
  cfcolorsetschemes''
  cswrite''
end.
)
cfcolor_italic_button=: 3 : 0
ita=. 0 ". italic
sel=. 0 ". item_select
COLORDATA=: (<ita) (<sel;2)} COLORDATA
cfcoloranon ''
cfcoloritem sel
cfcolorapply''
)
cfcolor_underline_button=: 3 : 0
und=. 0 ". underline
sel=. 0 ". item_select
COLORDATA=: (<und) (<sel;3)} COLORDATA
cfcoloranon ''
cfcoloritem sel
cfcolorapply''
)
cfcolor_item_select=: 3 : 0
cfcoloritem 0 ". item_select
)
cfcolor_sample_button=: 3 : 0
txt=. fread SAMPLEFILE
sel=. '''this is selected text'''
pos=. (1 i.~ sel E. txt) + 0, #sel
open SAMPLEFILE
if. (#txt) > {. pos do.
  smsetselect_jijs_ pos,0
end.
cfcolor_setfocus''
)
cfcolor_setfocus=: 3 : 0
wd 'psel cfmain;pactive;setfocus item'
)
cfcolor_scheme_select=: 3 : 0
cfcolorsetscheme 0 ". scheme_select
)
cfmain_tctrlshift_fkey=: 3 : 0
wdview ": COLORDATA
)
cfcolormove=: 3 : 0
sel=. 0 ". item_select
if. #sel do.
  'ndx new'=. y moveindex sel;<COLORDATA
  if. ndx ~: sel do.
    cfcoloranon''
    ndx cfcolorreset new
  end.
end.
cfcolor_setfocus''
)

cfcolor_saveas_button=: cssave_run
cfcolor_add_button=: cfadd_run bind 0
cfcolor_edit_button=: cfedit_run bind 1
cfcolor_moveup_button=: cfcolormove bind 0
cfcolor_movedn_button=: cfcolormove bind 1
getcolordata=: 3 : 0
if. 0 e. $y do. i.0 6 return. end.
dat=. getcolors y
nums=. >{."1 dat
ind=. FIXCOLORS i. nums
b=. ind < #FIXCOLORS
keys=. 4 {"1 dat
keys=. ((b#ind) { FIXCOLORNAMES) (I. b)} keys
keys=. toblank each keys
dat=. keys 4}"0 1 dat
)
getuserkey=: 3 : 0
(({."1 USRKEYS) i. y) { {:"1 USRKEYS
)
setcolordata=: 3 : 0
if. 0 e. #COLORDATA do. '' return. end.
emp=. (#COLORDATA)#a:
num=. ([: ; 4&{.) "1 COLORDATA
msk=. ({."1 num) e. USRCOLORS
mtx=. msk # 4{"1 COLORDATA
txt=. (tounder each mtx) (I. msk)} emp
res=. (<"1 ": num) ,each ' ' ,each txt
if. 0 e. j=. mtx e. KEYCOLORNAMES do.
  usr=. msk expand -. j
  userkeys=. usr # 4{"1 COLORDATA
  uservals=. getuserkey userkeys
  val=. uservals (I. usr)} emp
  res=. res ,each ' ' ,each val
end.

res=. LF ,~ tolist res
)
cfcolorapply=: 3 : 'setcolors COLORDATA'
cfcoloranon=: 3 : 0
if. (<SMCOLORID) e. DEFSCHEMES do.
  SMCOLORID=: ''
  wd 'setselect scheme -1'
end.
)
cfcolorgraph=: 3 : 0
glsel 'gcolor'
glrgb y
glbrush''
glrect 0 0 1000 1000
glpaint ''
)
cfcoloritem=: 3 : 0
if. 0 e. $COLORDATA do. return. end.
nums=. > {."1 COLORDATA
'num clr ita und key j'=. y { COLORDATA
ndx=. I. nums e. USRCOLORS
cfcolorgraph clr
wd 'setenable add ',": 0 e. USRCOLORS e. nums
wd 'setenable delete ',": -. num e. 0 1
wd 'setenable edit ',": (<key) e. USRCOLORNAMES
wd 'setenable italic ',": num > 3
wd 'setenable underline ',": num > 3
wd 'set italic ',": ita
wd 'set underline ',": und
if. #ndx do.
  wd 'setenable moveup ',": y > {.ndx
  wd 'setenable movedn ',": (y >: {.ndx) *. y < {:ndx
else.
  wd 'setenable moveup 0;setenable movedn 0'
end.
wd 'setselect item ',":y
wd 'setshow item 0;setshow item 1'
)
cfcolorreset=: 0&$: : (4 : 0)
if. #y do. COLORDATA=: y end.
cfcolorapply''
names=. 4 {"1 COLORDATA
wd 'set item *',tolist names
cfcoloritem x
)
cfcolorsetscheme=: 3 : 0
y=. {. y,0
ifoldnone=. SMCOLORID -: 'None'
'SMCOLORID SMCOLOR'=: y { COLORSCHEMES
ifnewnone=. SMCOLORID -: 'None'
if. ifnewnone do. SMCOLOR=: '' end.
cfdisable ifnewnone - ifoldnone
SMCOLORIDORG=: SMCOLORID
cfcolorreset COLORDATA=: getcolordata SMCOLOR
ckincx''
cfcolor_setfocus''
)
cfcolorsetschemes=: 3 : 0
css=. {."1 COLORSCHEMES
wd 'set scheme ',toblank todel css
wd 'setselect scheme ',": css inx1 < SMCOLORID
)
cfdisable=: 3 : 0
if. y ~: 0 do.
  j=. 'saveas deletescheme item color add edit delete'
  nms=. > ;: j,' italic underline moveup movedn'
  wd 'setenable ',"1 nms (,"1) 2 ": y<0
end.
)
CFADD=: 0 : 0
pc6j cfadd owner;pn "Add Item";
xywh 6 8 140 107;cc g0 groupbox;cn "Item";
xywh 11 20 125 74;cc itemlist listbox ws_vscroll;
xywh 13 97 52 12;cc new button;cn "New Item";
xywh 59 97 52 12;cc delete button;cn "Delete";
xywh 6 123 205 79;cc g1 groupbox;cn "Definition";
xywh 11 135 90 12;cc itemname edit ws_border es_autohscroll;
xywh 11 152 192 40;cc itemdef editm ws_border es_autovscroll;
xywh 159 135 52 12;cc add button;cn "Accept";
xywh 165 14 52 12;cc ok button bs_defpushbutton;cn "OK";
xywh 165 30 52 12;cc cancel button;cn "Cancel";
pas 4 4;pcenter;
rem form end;
)
cfadd_run=: 3 : 0
nums=. {."1 COLORDATA
FIXUNUSED=: (-. FIXCOLORS e. nums) # FIXCOLORNAMES
wd CFADD
wd 'setfont itemdef ',FIXFONT
cfaddshowkeys''
cfaddshow 0 pick COLADDKEYS,a:
wd 'pshow;'
)
cfadd_ok_button=: 3 : 0
if. #itemlist do.
  wd 'pclose'
  cfaddkey itemlist
else.
  info 'No color item selected'
end.
)
cfadd_add_button=: 3 : 0
name=. deb itemname
def=. vectoblank itemdef

if. 0 e. #name do.
  info 'Item name must be given' return.
end.
if. 0 e. #def do.
  info 'Item definition must be given' return.
end.
if. _2 = 4!:0 <tounder name do.
  j=. 'The item name must be a J name,',LF
  info j,'or list of blank-delimited J names' return.
end.

USRKEYS=: sort nubmatrix0 (name;def), USRKEYS
USRCOLORNAMES=: {."1 USRKEYS
cfaddshowkeys''
cfaddshow name
ckwrite''
)
cfadd_delete_button=: 3 : 0
name=. deb itemname
if. 2 query 'OK to delete: ',LF,LF,name do. return. end.
ndx=. ({."1 USRKEYS) i. <name
ind=. COLADDKEYS i. <name
USRKEYS=: (<<<ndx) { USRKEYS
USRCOLORNAMES=: {."1 USRKEYS
cfaddshowkeys''
if. 0 e. #COLADDKEYS do.
  cfaddshow ''
else.
  cfaddshow (ind <. <: #COLADDKEYS) pick COLADDKEYS
end.
ckwrite''
)
cfadd_itemlist_select=: 3 : 0
cfaddshow itemlist
)
cfadd_new_button=: 3 : 0
wd 'setreadonly itemname 0;setreadonly itemdef 0'
wd 'set itemname;set itemdef'
wd 'setenable add 1'
wd 'setselect itemlist -1'
)
cfadd_enter=: cfadd_ok_button
cfadd_cancel_button=: cfadd_cancel=: cfadd_close=: wd bind 'pclose'
cfadd_itemlist_button=: cfadd_ok_button
cfaddshow=: 3 : 0
wd 'set itemname *',y
if. 0 = #y do.
  wd 'setenable delete 0'
  wd 'setenable new 1;setenable add 1'
  wd 'setreadonly itemname 0;setreadonly itemdef 0'
  wd 'setfocus itemname'
else.
  if. (<y) e. USRCOLORNAMES do.
    wd 'set itemdef *', > getuserkey <y
    wd 'setreadonly itemname 0;setreadonly itemdef 0'
    wd 'setenable add 1;setenable delete 1'
  else.
    if. (<y) e. FIXCOLORNAMES do.
      wd 'set itemdef *{',y,'}'
    else.
      wd 'set itemdef *',". tounder y
    end.
    wd 'setenable add 0;setenable delete 0'
    wd 'setreadonly itemname 1;setreadonly itemdef 1'
  end.
  wd 'setselect itemlist ',":COLADDKEYS i. <y
  wd 'setfocus itemlist'
end.
)
cfaddshowkeys=: 3 : 0
names=. 3 {"1 COLORDATA
COLADDKEYS=: (FIXCOLORNAMES,KEYCOLORNAMES,USRCOLORNAMES) -. names
wd 'set itemlist ', todel COLADDKEYS
)
cfaddkey=: 3 : 0
cfcoloranon''
txt=. deb y
if. (<txt) e. FIXUNUSED do.

  num=. FIXCOLORS {~ FIXCOLORNAMES i. <txt

  nums=. > {."1 COLORDATA
  ndx=. (nums > num) i. 1

  if. num=2 do. clr=. 1 pick (nums i. 1) { COLORDATA
  elseif. num=3 do. clr=. 1 pick (nums i. 0) { COLORDATA
  elseif. 1 do. clr=. 0 0 0
  end.

  new=. num;clr;0;0;txt;''

  COLORDATA=: (ndx {. COLORDATA), new , ndx }. COLORDATA
  ndx cfcolorreset ''
elseif. (<txt) e. KEYCOLORNAMES do.

  val=. ". tounder txt
  num=. {. USRCOLORS -. > {."1 COLORDATA
  COLORDATA=: COLORDATA , num;0 0 0;0;0;txt;val
  (<: #COLORDATA) cfcolorreset ''
elseif. 1 do.

  val=. vectoblank itemdef
  if. 0 e. $val do.
    info 'No keyword definition' return.
  end.
  num=. {. USRCOLORS -. > {."1 COLORDATA
  COLORDATA=: COLORDATA , num;0 0 0;0;0;txt;val
  (<: #COLORDATA) cfcolorreset ''
  USRKEYS=: sort nubmatrix0 (txt;val) , USRKEYS
  ckwrite''

end.
)
toblank=: ' '&(I. @(e.&'_')@]})
tounder=: '_'&(I. @(e.&' ')@]})
getsyskey=: 3 : '". @ tounder each y'
SYSCOLORS=: 0 1 2 3 4 5 6 7 8 9 10
CLSCOLORS=: 20 21 22 23 24 25 26 27 28 29 30 31
USRCOLORS=: 40+i.20

SYSCOLORNAMES=: <;._2 (0 : 0)
background
text
selection background
selection text
margin
mark
lab text background
lab text foreground
readonly background
noun definition
note
)

CLSCOLORNAMES=: <;._2 (0 : 0)
primitive
name
number
string
comment
open quote
unmatched parenthesis
global assignment
local assignment
close definition
malformed
box drawing
)

KEYCOLORNAMES=: <;._2 (0 : 0)
adverbs
arguments
box drawing
conjunctions
control words
nouns
verbs
)

UKEYCOLORNAMES=: tounder each KEYCOLORNAMES

USRCOLORNAMES=: ''

FIXCOLORS=: SYSCOLORS,CLSCOLORS
FIXCOLORNAMES=: SYSCOLORNAMES,CLSCOLORNAMES

JStandard=: 0 : 0
 0 255 255 255 0 0
 1   0   0   0 0 0
 6 228 228 228 0 0
 8 228 228 228 0 0
23   0   0 255 0 0
24   0 128   0 0 0
25 255   0 255 0 0
26 255   0 255 0 0
40 255   0   0 0 0 control_words
)
on=: @:
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
getcolors=: 3 : 0
if. 0 e. $ y do. i.0 6 return. end.
getcolor4 ;._2 y
)
getcolor4=: 3 : 0
dat=. deb y
ndx=. (dat e. '0123456789 ') i. 0
num=. 6 {. ". ndx {. dat
num=. ({.num);(1 2 3{num);(4{num);5{num
dat=. ndx }. dat
ndx=. dat i. ' '
key=. tounder ndx {. dat
if. (<key) e. UKEYCOLORNAMES do.
  val=. ". key
else.
  val=. (ndx+1) }. dat
end.
num,key;val
)
setcolors=: 3 : 0

if. IFJAVA+IFUNIX do. return. end.
wd ,';smkeywords ' ,"1 ": ,. USRCOLORS
wd 'smcolor'
wd^:IFJNET 'smkeywords 0 0'

if. 0 e. $y do. return. end.
wd^:IFJNET 'smkeywords 0 1'

nums=. > 0 {"1 y
vals=. > 1 {"1 y
ital=. > (> 2 {"1 y) { '';' italic '
unds=. > (> 3 {"1 y) { '';' underline '
keys=. 4 {"1 y
sets=. 5 {"1 y
if. 0 e. 2 3 e. nums do.
  ndx=. nums i. 0 1
  nums=. nums, 3 2
  msk=. ~: nums
  nums=. msk # nums
  vals=. msk # vals, ndx{vals
  ital=. msk # ital, ndx{ital
  unds=. msk # unds, ndx{unds
  keys=. msk # keys, ndx{keys
  sets=. msk # sets, ndx{sets
end.

b=. keys e. KEYCOLORNAMES
if. 1 e. b do.
  ndx=. I. b
  keys=. (getsyskey ndx{keys) ndx} keys
end.

b=. nums e. USRCOLORS
if. 1 e. b do.
  j=. <"1 ';smkeywords ' ,"1 (": ,. b#nums) ,"1 ' ',DEL
  wd ; j ,each (b#sets) ,each DEL
end.

wd ,';smcolor ' ,"1 (": nums ,. vals) ,. ital ,. unds

)
CFEDIT=: 0 : 0
pc6j cfedit owner;pn "Edit Item";
xywh 6 8 204 74;cc g1 groupbox;cn "Definition";
xywh 11 20 100 12;cc itemname edit ws_border es_autohscroll;
xywh 11 35 194 40;cc itemdef editm ws_border es_autovscroll;
xywh 118 90 52 12;cc ok button;cn "OK";
xywh 164 90 52 12;cc cancel button;cn "Cancel";
pas 4 4;pcenter;
rem form end;
)
cfedit_run=: 3 : 0
sel=. 0 ". item_select
'name def'=. 4 5 { sel { COLORDATA
wd CFEDIT
wd 'setfont itemdef ',FIXFONT
wd 'set itemname *',name
wd 'set itemdef *', def
wd 'setfocus itemdef'
wd 'pshow'
)
cfedit_ok_button=: 3 : 0
sel=. 0 ". item_select
name=. deb itemname
def=. vectoblank itemdef
if. 0 e. #name do.
  info 'Item name must be given' return.
end.
if. 0 e. #def do.
  info 'Item definition must be given' return.
end.
if. _2 = 4!:0 <tounder name do.
  j=. 'The item name must be a J name,',LF
  info j,'or list of blank-delimited J names' return.
end.
USRKEYS=: sort nubmatrix0 (name;def), USRKEYS
USRCOLORNAMES=: {."1 USRKEYS
COLORDATA=: (name;def) (<sel;4 5)} COLORDATA
wd 'pclose'
sel cfcolorreset ''
)
cfedit_itemname_button=: cfedit_enter=: cfedit_ok_button
cfedit_cancel_button=: cfedit_cancel=: cfedit_close=: wd bind 'pclose'
CSFILE=: jpath '~config/colors.ijs'
CKFILE=: jpath '~config/colorkey.ijs'
DEFSCHEMES=: 'BlueJay';'Desert';'Emacs';'JReverse';'JSamples';'JStandard'
BlueJay=: 0 : 0
 0   0   0 128 0 0
 1 255 255 255 0 0
 6 228 228 228 0 0
 7   0   0 128 0 0
 8  96  96  96 0 0
23 255 255  64 0 0
24   0 255 128 0 0
25 255   0 255 0 0
26 255   0 255 0 0
40 255 192 128 0 0 control_words
)

Desert=: 0 : 0
 0 255 239 213 0 0
 1   0   0 255 0 0
 6 228 228 228 0 0
 8 228 228 228 0 0
23   0  64 128 0 0
24 128  64   0 0 0
25 255   0 255 0 0
26 255   0 255 0 0
31 128  64   0 0 0
40 255   0   0 0 0 control_words
47 128  64   0 0 0 box_drawing
)

Emacs=: 0 : 0
 0  47  79  79 0 0
 1 245 222 179 0 0
 4 224 224 224 0 0
 8  96  96  72 0 0
23 135 206 235 0 0
24 192 192 192 0 0
25 255   0 255 0 0
26 255   0 255 0 0
40 255   0   0 0 0 control_words
)

JReverse=: 0 : 0
 0   0   0   0 0 0
 1 255 255 255 0 0
 2 128 255 255 0 0
 3   0   0   0 0 0
 6 228 228 228 0 0
 7   0   0   0 0 0
 8  96  96  72 0 0
21   0 255 255 0 0
23 255 255  64 0 0
24 192 192 192 0 0
25 255 128 255 0 0
26 255 128 255 0 0
40 255   0   0 0 0 control_words
)

JSamples=: 0 : 0
 0 192 192 192 0 0
 1 255 255 255 0 0
 2 255   0   0 0 0
 3 255 255 255 0 0
 4 128 255 128 0 0
 5   0   0   0 0 0
 6 228 228 228 0 0
 7   0   0   0 0 0
 8  96  96  72 0 0
 9 0   128 128 0 0
10 0   128 128 0 0
20   0   0 255 0 0
21   0   0 255 0 0
22  64   0  64 0 0
23   0 255 255 0 1
24   0 255   0 0 0
25 255   0 255 0 0
26 255   0   0 0 0
27 255 255 128 0 0
28 255 255 128 0 0
29 255   0   0 0 0
30 128   0   0 1 1
31 255 255   0 0 0
40 255   0   0 0 0 control_words
41 128 128 192 0 0 adverbs
42 128 128 192 0 0 arguments
43 128 128 192 0 0 bookmarks
47 255 255   0 0 0 box_drawing
44 128 128 192 0 0 conjunctions
45 128 128 192 0 0 nouns
46 128 128 192 0 0 verbs
)
ckread=: 3 : 0
if. 0=fexist CKFILE do.
  USRKEYS=: i.0 2
else.
  script_jcfg0_ <CKFILE
  p_jcfg0_=: [: (, ,&< ".) &> (4!:1)
  dat=. p_jcfg0_ 0
  dat=. dat #~ (<'y') ~: {."1 dat
  if. 0 e. $dat do.
    USRKEYS=: i.0 2
  else.
    nms=. toblank each {."1 dat
    USRKEYS=: nms ,. {:"1 dat
  end.
  18!:55 <'jcfg0'
end.
ckincx''
)
ckincx=: 3 : 0
msk=. -. (4 {"1 COLORDATA) e. FIXCOLORNAMES,KEYCOLORNAMES
USRKEYS=: (4 5 {"1 msk # COLORDATA), USRKEYS
USRKEYS=: sort nubmatrix0 USRKEYS
USRCOLORNAMES=: {."1 USRKEYS
)
csread=: 3 : 0
if. 0 = fexist CSFILE do.
  dat=. DEFSCHEMES ,. ". each DEFSCHEMES
else.
  script_jcfg0_ <CSFILE
  p_jcfg0_=: [: (, ,&< ".) &> (4!:1)
  dat=. p_jcfg0_ 0
  dat=. dat #~ -. ({."1 dat) e. ;: 'y y.'
  18!:55 <'jcfg0'
  if. 0 e. $dat do.
    dat=. DEFSCHEMES ,. ". each DEFSCHEMES
  end.
end.
dat=. sort dat
dat=. ~. dat, 'None';''
COLORSCHEMES=: dat
)
j=. <;.2 (0 : 0)
colors.ijs

This file contains color schemes for the J session.

The file is updated by Configure, and may also be
changed manually. Each entry must consist of a
definition of a color scheme.
)

CSFILEHEADER=: LF ,~ ; 'NB. '&, each j
j=. <;.2 (0 : 0)
colorkey.ijs

This file contains color keys for the J session.

The file is updated by Configure, and may also be
changed manually. Each entry must consist of a
definition of a color key.

Replace blank in color key names with an underscore.
)

CKFILEHEADER=: LF ,~ ; 'NB. '&, each j
0 : 0

00-19  system colors
20-39  class colors
40-59  keyword colors

 0      bkgnd
 1      text
 2      selbkgnd
 3      seltext
 4      margin
 5      mark (character digits, not bitmaps)
 6      lab text background
 7      lab text foreground
 8      readonly foreground
 9      noun definition
10      note
11-19   reserved
20      primitive
21      name
22      number
23      string
24      comment
25      open quote
26      first unmatched )(
27      name =:
28      name =.
29      naked ) - explicit definition and lab section close
30      malformed
31      box drawing
32-39   reserved
40-59   keywords

)
CSSAVE=: 0 : 0
pc6j cssave owner;pn "Save Scheme";
xywh 166 5 40 12;cc ok button leftmove rightmove;cn "OK";
xywh 166 20 40 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 7 7 150 11;cc label static;cn "Save this color scheme as:";
xywh 6 21 150 12;cc name edit es_autohscroll;
pas 4 4;pcenter;
rem form end;
)
cssave_run=: 3 : 0
wd CSSAVE
wd 'set name *',toblank SMCOLORIDORG
wd 'setfocus name'
wd 'setselect name ',": 0,#SMCOLORIDORG
wd 'pshow;'
)
cssave_cancel_button=: cssave_cancel=: cssave_close=: wd bind 'pclose'
cssave_ok_button=: 3 : 0
if. 0 = #name do.
  info 'First enter a color scheme name' return.
end.
if. name -: 'None' do.
  info 'You may not save color scheme: None' return.
end.
name=. tounder name
if. _2 = 4!:0 <name do.
  j=. 'The color scheme name must be a J name,',LF
  info j,'or list of blank-delimited J names' return.
end.
SMCOLORID=: name
SMCOLOR=: setcolordata COLORDATA
nms=. {."1 COLORSCHEMES
val=. {:"1 COLORSCHEMES
ndx=. nms i. <SMCOLORID
if. ndx = #nms do.
  nms=. nms, <SMCOLORID
  val=. val, <SMCOLOR
  COLORSCHEMES=: sort nms ,. val
else.
  val=. (<SMCOLOR) ndx} val
  COLORSCHEMES=: nms ,. val
end.
cswrite''
wd 'pclose'
SMCOLORIDORG=: SMCOLORID
cfcolorsetschemes''
)

cssave_enter=: cssave_name_button=: cssave_ok_button
ckwrite=: 3 : 0
if. #USRKEYS do.
  nms=. tounder each {."1 USRKEYS
  val=. {:"1 USRKEYS
  j=. nms ,each (<'=: ') ,each quote each val
  j=. j ,each (<LF,LF)
  dat=. _2 }. ; j
else.
  dat=: ''
end.

(CKFILEHEADER, dat) fwrites CKFILE
)
cswrite=: 3 : 0
css=. COLORSCHEMES -. 'None';''
nms=. tounder each {."1 css
val=. {:"1 css
j=. nms ,each (<'=: 0 : 0',LF)
j=. j ,each val ,each (<')',LF,LF)
dat=. _2 }. ; j
(CSFILEHEADER, dat) fwrites CSFILE
)
EXGRIDNAMES=: 'cellalign celldata cellmark colscale gridid gridmargin gridpid hdrcol'
EXNOUNS=: <;._2 (0 : 0)
EPSREADER EPS Reader
XDIFF File Comparison
PDFREADER PDF Reader
BROWSER Web Browser
)
EXDESCS=: <@}:@; ;._1 (,LF);<;.2 (0 : 0)
Read Encapsulated PostScript files.

File Comparison/Merge.

Read Adobe PDF files.

Web Browser, required for online help.
)
CFEXTERN=: 0 : 0
pc6j cfextern;
xywh 6 6 288 160;cc g0 groupbox rightmove bottommove;cn "External Programs";
xywh 12 17 276 144;cc xgrid isigraph rightmove bottommove;
xywh 6 172 288 93;cc g1 groupbox topmove rightmove bottommove;cn "Edit External Program";
xywh 11 184 45 11;cc lab1 static topmove bottommove;cn "Name:";
xywh 59 184 198 12;cc xname static topmove rightmove bottommove;
xywh 11 199 45 11;cc lab2 static topmove bottommove;cn "Command:";
xywh 59 199 229 12;cc xedcmd edit es_autohscroll topmove rightmove bottommove;
xywh 124 248 52 12;cc xselect button leftmove topmove rightmove bottommove;cn "Select...";
xywh 179 248 52 12;cc xbrowse button leftmove topmove rightmove bottommove;cn "Browse...";
xywh 233 248 52 12;cc xreplace button leftmove topmove rightmove bottommove;cn "&Accept";
xywh 12 214 274 30;cc xinfo static topmove rightmove bottommove;cn "xinfo";
pas 2 2;pcenter;
rem form end;
)
cfextern_run=: 3 : 0
if. y=0 do.

  dat=. EPSREADER;XDIFF;PDFREADER;BROWSER
  nouns=. EXNOUNS
  ndx=. nouns i.&> ' '
  EXNAMES=: ndx {.each nouns
  EXIDS=: (ndx+1) }.each nouns
  EXDEFS=: cfexdefs EXNAMES
  EXDEFX=: defremNB EXDEFS
  EXDATA=: EXIDS,.dat
  EXNDX=: 0
  wd CFEXTERN
  if. IFJNET do. glnodblbuf 0 end.
  xgrid=: '' conew 'jsgrid'
end.
cfextern_xgrid_paint''
)

cfextern_act=: ]
cfextern_xbrowse_button=: 3 : 0
f=. cfextern_browsefile 1 pick EXNDX { EXDATA
if. #f do.
  cfextern_xreplace f
end.
)
cfextern_xgrid_paint=: 3 : 0
celldata=. EXDATA
cellalign=. 0
cellmark=. EXNDX,0
colscale=. 1 3
gridid=. 'xgrid'
gridmargin=. 3 2 1 0
gridpid=. 'cfextern'
hdrcol=. 'Name';'Command String'
show__xgrid pack EXGRIDNAMES
cfextern_xgrid_paintdetails''
)
cfextern_xgrid_paintdetails=: 3 : 0
'j s'=. EXNDX { EXDATA
wd 'set xname *',j
wd 'set xedcmd *',s
wd 'set xinfo *',EXNDX pick EXDESCS
wd 'setenable xselect ',":0 < (#EXNDX pick EXDEFX) -. <s
)
cfextern_xreplace_button=: 3 : 0
cfextern_xreplace xedcmd
)
cfextern_xselect_button=: 3 : 0
cmd=. (<xedcmd) -. EXNDX pick EXDEFX
if. #cmd do.
  EXDEFS=: (<cmd,EXNDX pick EXDEFS) EXNDX } EXDEFS
  EXDEFX=: (<cmd,EXNDX pick EXDEFX) EXNDX } EXDEFX
end.
cfselect_run (EXNDX { EXDEFS),0;'cfextern_xselect_do'
)
cfextern_xselect_do=: 3 : 0
if. #y do.
  sel=. deb (1 i.~ 'NB.' E. y) {. y
  if. #sel do.
    cfextern_xreplace sel
  end.
end.
)
cfextern_browsefile=: 3 : 0
if. #y do. 'p f'=. pathname y
else.
  p=. jpath '~home'
  f=. ''
end.
j=. IFWIN#'Applications (*.exe)|*.exe|'
j=. '"',j,'All Files (*.*)|*.*"'
j=. j,' ofn_filemustexist ofn_nochangedir'
if. IFJNET do.
  wd 'mbopen6 "Open File" "',p,'" "',f,'" ',j
else.
  wd 'mbopen "Open File" "',p,'" "',f,'" ',j
end.
)
cfextern_xreplace=: 3 : 0
EXDATA=: (<y) (<EXNDX;1)} EXDATA
cfextern_xgrid_paint''
)
xgrid_gridhandler=: 3 : 0
select. y
case. 'mark' do.
  EXNDX=: {. CELLMARK__xgrid
  cfextern_xgrid_paintdetails''
end.
1
)
cfexdefs=: 3 : 0
r=. ''
for_n. y do.
  r=. r, <boxxopen ('def',tolower >n)~''
end.
)
cfwhich=: 3 : 0
r=. ''
for_d. y do.
  r=. r,<LF -.~ 2!:0 ::(''"_)'which ',(>d),' 2>/dev/null'
end.
~. r-.a:
)
defbrowser=: 3 : 0
if. UNAME -: 'Darwin' do. 'open' return. end.
if. IFWIN do. dlft_shellopen '.htm' return. end.
cfwhich ;: 'firefox mozilla netscape konqueror'
)
defepsreader=: 3 : 0
if. IFWIN do.
  dlft_shellopen '.eps'
else.
  cfwhich ;: 'acroread evince xgdvi'
end.
)
defpdfreader=: 3 : 0
if. IFWIN do.
  dlft_shellopen '.pdf'
else.
  cfwhich ;: 'acroread evince'
end.
)
defxdiff=: 3 : 0
''
)
defremNB=: 3 : 0
deb @ ({.~ 1 i.~ 'NB. ' E. ]) L: 0 y
)
CFGRIDNAMES=: 'cellalign celldata cellmark colscale gridmargin gridpid hdrcol'

CFFOLDER=: 0 : 0
pc6j cffolder closeok owner;pn "User Folders";
xywh 3 6 288 196;cc Folders groupbox rightmove bottommove;
xywh 9 17 276 164;cc grid isigraph rightmove bottommove;
xywh 9 185 60 12;cc up button topmove bottommove;cn "Move &Up";
xywh 71 185 60 12;cc down button topmove bottommove;cn "Move Do&wn";
xywh 222 185 60 12;cc delete button leftmove topmove rightmove bottommove;cn "&Delete";
xywh 3 206 288 59;cc g0 groupbox topmove rightmove bottommove;cn "Edit Folder";
xywh 8 218 33 11;cc label static topmove bottommove;cn "Name:";
xywh 42 218 168 12;cc desc edit ws_border es_autohscroll topmove rightscale bottommove;
xywh 8 234 33 11;cc label static topmove bottommove;cn "Folder:";
xywh 42 234 241 12;cc efolder edit ws_border es_autohscroll topmove rightmove bottommove;
xywh 215 218 66 11;cc ifsub checkbox leftmove topmove rightmove bottommove;cn "Subfolder";
xywh 8 250 60 12;cc addtop button topmove bottommove;cn "Add at &top";
xywh 70 250 60 12;cc addend button topmove bottommove;cn "Add at &end";
xywh 222 250 60 12;cc replace button leftmove topmove rightmove bottommove;cn "&Replace";
pas 2 2;pcenter;
rem form end;
)
cffolder_run=: 3 : 0
if. y=0 do.
  wd CFFOLDER
  if. IFJNET do. glnodblbuf 0 end.
  if. 0~:4!:0<'IFWIN32' do.
    wd 'setenable ifsub 0'
  end.
  grid=: '' conew 'jsgrid'
  FNDX=: 0
end.
cffolder_grid_paint''
)

cffolder_act=: ]
cffolder_grid_paint=: 3 : 0
if. #USERFOLDERS do.
  FNDX=: FNDX <. <:#USERFOLDERS
  a=. 0 {"1 USERFOLDERS
  b=. 1 {"1 USERFOLDERS
  if. 0~:4!:0<'IFWIN32' do.
    c=. 0#~ #a
  else.
    c=. ; 2 {"1 USERFOLDERS
  end.
  c=. <"0 c { ' s'
  celldata=. a,.c,.b
  cellalign=. 0 1 0
  cellmark=. FNDX,0
  colscale=. 1 0 3
  gridmargin=. 3 2 1 0
  gridpid=. 'cffolder'
  hdrcol=. 'Name';'Sub';'Folder Path'
  show__grid pack CFGRIDNAMES
  cffolder_grid_paintdetails''
end.
)
cffolder_grid_paintdetails=: 3 : 0
if. 0 <: FNDX do.
  'j k s'=. 3{. FNDX { USERFOLDERS
  wd 'set desc *',j
  wd 'set efolder *',delfret k
  if. 0~:4!:0<'IFWIN32' do.
    wd 'set ifsub 0'
  else.
    wd 'set ifsub ',": s
  end.
end.
)
cffolder_up_button=: 3 : 0
ndx=. {. CELLMARK__grid
ind=. ndx, ndx1=. 0 >. ndx-1
USERFOLDERS=: (|.ind{USERFOLDERS) ind} USERFOLDERS
FNDX=: ndx1
cffolder_grid_paint''
)
cffolder_down_button=: 3 : 0
ndx=. {. CELLMARK__grid
ind=. ndx, ndx1=. (<:#USERFOLDERS) <. ndx+1
USERFOLDERS=: (|.ind{USERFOLDERS) ind} USERFOLDERS
FNDX=: ndx1
cffolder_grid_paint''
)
cffolder_delete_button=: 3 : 0
ndx=. {. CELLMARK__grid
if. 1=#USERFOLDERS do.
  info 'You cannot delete the only folder' return.
end.
msg=. 'OK to delete: ',>{.ndx{USERFOLDERS
if. 0=2 query msg do.
  USERFOLDERS=: USERFOLDERS #~ -. (i.#USERFOLDERS) e. ndx
  FNDX=: (<:#USERFOLDERS) <. ndx
  cffolder_grid_paint''
end.
)
cffolder_addtop_button=: 3 : 0
if. cffolder_addcheck 0 do.
  USERFOLDERS=: ~. (desc;efolder;0".ifsub),USERFOLDERS
  FNDX=: 0
  cffolder_grid_paint''
end.
)
cffolder_addend_button=: 3 : 0
if. cffolder_addcheck 0 do.
  USERFOLDERS=: ~. USERFOLDERS, desc;efolder;0".ifsub
  FNDX=: ({."1 USERFOLDERS) i. <desc
  cffolder_grid_paint''
end.
)
cffolder_ifsub_button=: 3 : 0
if. '0'=ifsub do. return. end.
cffolder_readadd''
if. -. issubfolder efolder do.
  info 'No parent folder for this subfolder'
  wd 'set ifsub 0'
end.
)
cffolder_replace_button=: 3 : 0
if. cffolder_addcheck 1 do.
  ndx=. {. CELLMARK__grid
  USERFOLDERS=: (desc;efolder;0".ifsub) ndx} USERFOLDERS
  FNDX=: ndx
  cffolder_grid_paint''
end.
)
cffolder_readadd=: 3 : 0
desc=: deb desc
efolder=: jpathsep deb efolder
efolder=: (-PATHSEP_j_={:efolder)}.efolder
)
cffolder_addcheck=: 3 : 0

cffolder_readadd''
sub=. 0".ifsub

if. (desc;efolder;sub) e. USERFOLDERS do. 0 return. end.
r=. 0
if. sub do.
  if. -. issubfolder efolder do.
    info 'Cannot make this a subfolder, as there is no parent folder.'
    0 return.
  end.
end.
if. 0=#desc do.
  info 'Enter the name'
elseif. 20<#desc do.
  info 'Name may not exceed 20 characters'
elseif. 0=#efolder do.
  info 'Enter the folder paths'
elseif. y < (<desc) e. {."1 USERFOLDERS do.
  info 'Name already in use'
elseif. y < (<efolder) e. {:"1 USERFOLDERS do.
  info 'Folder already in use'
elseif. 1 do.
  r=. 1
end.

r
)
grid_gridhandler=: 3 : 0
select. y
case. 'mark' do.
  FNDX=: {. CELLMARK__grid
  cffolder_grid_paintdetails''
end.
1
)
FORMNOTES=: textline 0 : 0
Control sizes are derived from these values.
Label height is normally less than edit height
and they are centered horizontally.
)
CFFORMS=: 0 : 0
pc6j cfforms;pn "Configure Forms";
xywh 7 10 28 11;cc sffont static;cn "Font:";
xywh 37 9 160 12;cc fontdef edit ws_border es_autohscroll;
xywh 218 10 52 12;cc fbrowse button;cn "&Select...";
xywh 7 42 60 11;cc f0 static;cn "Button width:";
xywh 72 41 22 12;cc bwidth edit ws_border es_autohscroll;
xywh 7 57 60 11;cc f1 static;cn "Button height:";
xywh 72 56 22 12;cc bheight edit ws_border es_autohscroll;
xywh 7 72 60 11;cc f2 static;cn "Edit width:";
xywh 72 71 22 12;cc ewidth edit ws_border es_autohscroll;
xywh 7 87 60 11;cc f3 static;cn "Edit height:";
xywh 72 86 22 12;cc eheight edit ws_border es_autohscroll;
xywh 7 102 60 11;cc f4 static;cn "Label height:";
xywh 72 101 22 12;cc lheight edit ws_border es_autohscroll;
xywh 7 118 52 10;cc f5 static;cn "Notes:";
xywh 12 129 281 36;cc f6 static;
pas 4 2;pcenter;
rem form end;
)
cfforms_run=: 3 : 0
if. y=0 do.
  wd CFFORMS
  f=. ". @ wd :: _1:
  if. _1 ~: j=. f 'qformsize' do.
    FORMSIZES=: j
  end.
end.
if. IFUNIX do.
  font=. PROFONTJ
else.
  font=. PROFONTW
end.
wd 'set fontdef *',font
wd 'set f6 *',FORMNOTES
wd 'set bwidth ',":0{FORMSIZES
wd 'set bheight ',":1{FORMSIZES
wd 'set ewidth ',":2{FORMSIZES
wd 'set eheight ',":3{FORMSIZES
wd 'set lheight ',":4{FORMSIZES
)
cfforms_act=: ]
cfforms_cancel_button=: 3 : 0
wd 'pclose;'
)
cfforms_fbrowse_button=: 3 : 0
if. #j=. mbfont fontdef do.
  wd 'set fontdef *',fontdef=: j
end.
)
CFLINT=: 0 : 0
pc6j cflint;
xywh 8 8 286 31;cc sf static rightmove;
xywh 6 47 288 41;cc g0 groupbox rightmove;cn "Syntax Validation and Formatting";
xywh 12 60 276 11;cc rbcheckonly radiobutton;cn "Validate only";
xywh 12 72 276 11;cc rbpplint radiobutton group;cn "Validate and format";
xywh 6 95 288 57;cc g0 groupbox rightmove;cn "Indenting";
xywh 12 109 276 11;cc btab radiobutton;cn "Use tabs (Hard tabs)";
xywh 12 121 276 11;cc bspc radiobutton group;cn "Use spaces (Soft tabs)";
xywh 19 134 58 11;cc s0 static;cn "Soft tab width:";
xywh 79 134 20 12;cc espc edit ws_border es_autohscroll;
xywh 6 160 288 56;cc g2 groupbox rightmove;cn "Format Options";
xywh 12 174 276 11;cc lcb0 checkbox;cn "Replace multiple spaces with one";
xywh 12 186 276 11;cc lcb1 checkbox;cn "Indent explicit definitions";
xywh 12 198 276 11;cc lcb2 checkbox;cn "Indent select. block";
pas 6 6;pcenter;
rem form end;
)
cflint_run=: 3 : 0
if. y=0 do.
  wd CFLINT
  CFFMT=: FORMAT
end.
msg=. 'Settings for Format Script menu item in the session and Project Manager, '
msg=. msg,'which validates and optionally formats a script.'
wd 'set sf *',msg
cflint_show''
)
cflint_show=: 3 : 0
wd 'set rbpplint ',":0 { CFFMT
wd 'set rbcheckonly ',": -. 0 { CFFMT
wd 'set btab ',":1 { CFFMT
wd 'set bspc ',": -. 1 { CFFMT
wd 'set sf *',msg
wd 'set espc ',":2 { CFFMT
wd 'set lcb0 ',":3 { CFFMT
wd 'set lcb1 ',":4 { CFFMT
wd 'set lcb2 ',":5 { CFFMT
)
cflint_bpplint_button=: cflint_reads
cflint_bcheckonly_button=: cflint_reads
cflint_btab_button=: cflint_reads
cflint_bspc_button=: cflint_reads
cflint_reads=: 3 : 0
cflint_read''
cflint_show''
)
cflint_read=: 3 : 0
j=. (0 ". lcb0),(0 ". lcb1),0 ". lcb2
CFFMT=: (0 ". rbpplint),(0 ". btab),(0 ". espc),j
)
cflint_act=: ]
CFOPTS=: 0 : 0
pc6j cfopts;
xywh 6 8 288 69;cc v0 groupbox;cn "Global Parameters";
xywh 12 24 77 11;cc l2 static;cn "Memory Limit:";
xywh 90 23 115 100;cc cml combolist ws_vscroll cbs_autohscroll;
xywh 212 23 52 12;cc defml button;cn "Default";
xywh 12 41 77 11;cc l0 static;cn "Print Precision:";
xywh 90 40 30 12;cc cpp edit ws_border es_autohscroll;
xywh 212 40 52 12;cc defpp button;cn "Default";
xywh 13 61 200 12;cc cbxnames checkbox;cn "Permit x. y. names in explicit definitions";
xywh 6 84 288 54;cc v1 groupbox;cn "Session Manager";
xywh 12 98 77 11;cc s2 static;cn "Max Line Length:";
xywh 90 96 30 12;cc maxlinelength edit ws_border es_autohscroll;
xywh 12 110 77 11;cc s3 static;cn "Max Lines Before:";
xywh 90 109 30 12;cc maxlinesbefore edit ws_border es_autohscroll;
xywh 12 122 77 11;cc s4 static;cn "Max Lines After:";
xywh 90 121 30 12;cc maxlinesafter edit ws_border es_autohscroll;
xywh 212 95 52 12;cc defll button;cn "Defaults";
pas 6 6;pcenter;
rem form end;
)
cfopts_run=: 3 : 0
if. y=0 do.
  wd CFOPTS
end.
wd 'set cml *',tolist getml''
wd 'setselect cml ',":MEMLIM i. <. 2 ^. 9!:20''
wd 'set cpp ',":PRINTPREC
wd 'set maxlinelength ',": 1 { OUTPUT
wd 'set maxlinesbefore ',": 2 { OUTPUT
wd 'set maxlinesafter ',": 3 { OUTPUT
wd 'set cbxnames ',":XNAMES
)
cfopts_act=: ]
cfopts_cancel_button=: wd bind 'pclose'
cfmt=: 3 : 0
dat=. ":x:<.y
len=. #dat
msk=. (-len) {. (|. len $ 1j1 1 1),3$1
msk # !.',' dat
)
getml=: 3 : 0
min=. 17
max=. getmaxml''
MEMLIM=: min + i. 1 + max - min
mlfmt each MEMLIM
)
getmaxml=: 3 : 0
old=. 9!:20''
9!:21 [ _
max=. 9!:20''
9!:21 old
<. 2 ^. max
)
mlfmt=: 3 : 0
'2^',(":y),' = ',cfmt 2^y
)
cfopts_cml_button=: 3 : 0
MEMORYLIM=: MEMLIM {~ ". cml_select
if. MEMORYLIM = {:MEMLIM do.
  MEMORYLIM=: _
end.
)

cfopts_cml_select=: cfopts_cml_button
cfopts_defml_button=: 3 : 0
MEMORYLIM=: _
wd 'setselect cml ',": <: #MEMLIM
)
cfopts_defpp_button=: 3 : 0
wd 'set cpp 6'
)
cfopts_maxlinelength_button=: 3 : 0
if. -. isnnint _1 ". maxlinelength do.
  info 'Invalid setting for Max Line Length'
end.
)
cfopts_maxlinesbefore_button=: 3 : 0
if. -. isnnint _1 ". maxlinesbefore do.
  info 'Invalid setting for Max Lines Before'
end.
)
cfopts_maxlinesafter_button=: 3 : 0
if. -. isnnint _1 ". maxlinesafter do.
  info 'Invalid setting for Max Lines After'
end.
)
cfopts_defll_button=: 3 : 0
wd 'set maxlinelength 256'
wd 'set maxlinesbefore 0'
wd 'set maxlinesafter 222'
)
PRINTNOTES=: 'A 7-7.5 point fixed-pitch font is recommended.'

CFPRINT=: 0 : 0
pc6j cfprint;pn "Configure Print";
xywh 6 8 288 32;cc g0 groupbox;cn "Print Font";
xywh 12 20 183 12;cc pfont edit ws_border es_autohscroll;
xywh 202 20 52 12;cc pbrowse button;cn "&Browse...";
xywh 6 50 288 43;cc g1 groupbox;cn "Print 2-Up Font";
xywh 12 74 183 12;cc p2font edit ws_border es_autohscroll;
xywh 202 74 52 12;cc p2browse button;cn "&Browse...";
xywh 10 61 231 11;cc p2 static;
xywh 6 107 288 40;cc g2 groupbox;cn "Default Print Type";
xywh 12 119 54 11;cc bprint radiobutton;cn "print";
xywh 12 131 68 11;cc bprint2 radiobutton group;cn "print 2-up";
xywh 72 119 173 11;cc bascii checkbox;cn "Ascii box-drawing characters";
pas 2 2;pcenter;
rem form end;
)
cfprint_run=: 3 : 0
if. y=0 do.
  wd CFPRINT
end.
wd 'set p2 *',PRINTNOTES
wd 'set pfont *',PRINTERFONT
wd 'set p2font *',P2UPFONT
wd 'set bprint ',":SMPRINT-:'print'
wd 'set bprint2 ',":SMPRINT-:'print2'
wd 'set bascii ',": (<'ascii') e. PRINTOPTX
)

cfprint_act=: ]
cfprint_cancel_button=: 3 : 0
wd 'pclose;'
)
cfprint_pbrowse_button=: 3 : 0
if. #j=. mbfont pfont do.
  pfont=: j
  wd 'set pfont *',pfont
end.
)
cfprint_p2browse_button=: 3 : 0
if. #j=. mbfont p2font do.
  p2font=: j
  wd 'set p2font *',p2font
end.
)
printstyle=: 3 : 0
wd 'set pfont *',pfont
)
cfprint_bprint_button=: 3 : 'SMPRINT=: ''print'''
cfprint_bprint2_button=: 3 : 'SMPRINT=: ''print2'''
cfprint_bascii_button=: 3 : 0
if. '1'=bascii do.
  PRINTOPTX=: PRINTOPTX, <'ascii'
else.
  PRINTOPTX=: PRINTOPTX -. <'ascii'
end.
)
CFGITEMS=: <;._2 (0 : 0)
FIXFONTJ
PROFONTJ
FIXFONTW
PROFONTW
PRINTERFONT
P2UPFONT
SMPRINT
PRINTOPT
SMINIT
SMSIZE
SMSTYLE
BOXFORM
BOXPOS
BROWSER
CONFIRMCLOSE
DIRTREEX
DISPLAYFORM
EPSREADER
FORMAT
FORMSIZES
MEMORYLIM
NEWUSER
OPTMB
OPTOLDISIGRAPH
OPTPC6J
OPTTWIP
OUTPUT
PDFREADER
PRINTPREC
READONLY
SHOWSIP
SMCOLORID
STARTUP
STATUSBAR
XDIFF
XNAMES
)
CFGLISTS=: <;._2 (0 : 0)
SMCOLOR
FKEYS
SKEYS
)
configclean=: 3 : 0
txt=. y, LF
txt=. txt #~ -. (LF,LF) E. txt
(LF = {. txt) }. txt
)
a=. ''''
quote=: (a&,@(,&a))@ (#~ >:@(=&a))
cfgitem=: 3 : 0
val=. y~
if. #val do.
  select. 3!:0 val
  case. 2 do.
    val=. quote val
  case. 32 do.
    val=. 5!:5 <'val'
  case. do.
    val=. ": val
  end.
else.
  val=. ''''''
end.
y,'=: ',val
)
cfglist=: 3 : 0
val=. y~
if. # val do.
  y,'=: 0 : 0',LF,val,')'
else.
  y,'=: '''''
end.
)
cfguserfolders=: 3 : 0
if. 0~:4!:0<'IFWIN32' do.
  cf=. UserFolders_j_
else.
  cf=. USERFOLDERS_j_
end.
if. 0 = #cf do.
  'USERFOLDERS=: ''''',LF return.
end.
cf=. cf,. (<0)#~#cf
txt=. quote each 2 {."1 cf
if. 0~:4!:0<'IFWIN32' do.
  flg=. (#cf)#<'0'
else.
  flg=. ": each 2 }."1 cf
end.
usr=. ; (txt,.flg) ,each "1 ';;',LF
'USERFOLDERS=: 0 : 0',LF,usr,')',LF
)
configsave=: 3 : 0
FKEYS=: configclean FKEYS
j=. 'NB. configuration';''
j=. j, cfgitem each CFGITEMS
j=. j, cfglist each CFGLISTS
j=. ; j ,each LF
j=. j, cfguserfolders ''
j=. toHOST j
j 1!:2 :: ] <jpath '~config/config.ijs'
)
CFSESS=: 0 : 0
pc6j cfsess;
xywh 6 4 288 66;cc g0 groupbox;cn "Directory Exclusion";
xywh 11 16 276 36;cc sn static;cn "ln";
xywh 11 53 276 12;cc dirtreex edit ws_border es_autohscroll;
xywh 6 72 288 80;cc g1 groupbox;cn "Open Script Read Only State";
xywh 11 88 276 22;cc rostate static;cn "ln";
xywh 11 112 240 10;cc rb0 radiobutton;cn "All scripts";
xywh 11 124 240 10;cc rb1 radiobutton group;cn "Scripts under ~install except those under ~temp or ~user";
xywh 11 140 240 10;cc rb2 radiobutton group;cn "None - all scripts are opened editable";
xywh 6 156 288 29;cc g2 groupbox;cn "Session Close";
xywh 12 168 276 12;cc confirmclose checkbox;cn "confirmclose";
xywh 6 190 288 61;cc legacyoption groupbox;cn "Legacy Option";
xywh 12 202 276 11;cc optpc6j checkbox;cn "Create form using J6 dialog unit";
xywh 12 214 276 11;cc optmb checkbox;cn "J6 mb command syntax";
xywh 12 226 276 11;cc opttwip checkbox;cn "printer using twip measurement unit";
xywh 12 238 276 11;cc optoldisigraph checkbox;cn "old isigraph";
pas 6 6;
rem form end;
)
cfsess_act=: ]
cfsess_run=: 3 : 0
if. y=0 do.
  wd CFSESS
end.
msg=. 'Directory exclusion list for dirtree,'
msg=. msg,' also used by dirfind, dirss and dirssrplc.'
msg=. msg,' Commas separate entries. Hidden directories'
msg=. msg,' are automatically excluded.'
wd 'set sn *',msg
msg=. 'Set readonly state when a script is opened. Ctrl+T toggles the state.'
msg=. msg, ' New temporary scripts are always opened editable.'
wd 'set rostate *',msg
msg=. 'Give confirmation prompt when the J session is closed.'
wd 'setcaption confirmclose *',msg
cfsess_set''
)
cfsess_read=: 3 : 0
CONFIRMCLOSE=: 0 ". confirmclose
DIRTREEX=: cutcommas dirtreex
READONLY=: (rb0,rb1,rb2) i. '1'
OPTMB=: 0 ". optmb
OPTOLDISIGRAPH=: 0 ". optoldisigraph
OPTPC6J=: 0 ". optpc6j
OPTTWIP=: 0 ". opttwip
)
cfsess_set=: 3 : 0
wd 'set confirmclose ',":CONFIRMCLOSE
wd 'set dirtreex *', }. ; ',' ,each DIRTREEX
wd 'set rb0 ',":READONLY=0
wd 'set rb1 ',":READONLY=1
wd 'set rb2 ',":READONLY=2
wd 'set optmb ',":OPTMB
wd 'set optoldisigraph ',":OPTOLDISIGRAPH
wd 'set optpc6j ',":OPTPC6J
wd 'set opttwip ',":OPTTWIP
)
SKEYNOTES=: textline 0 : 0
Definitions take effect when you next load J.
Ctrl CVXZ may not be modified.
)

CFSKEYS=: 0 : 0
pc6j cfskeys;pn "Menu Shortcuts";
xywh 8 8 259 20;cc s0 static rightmove;
xywh 6 32 175 12;cc t0 static;cn "Menu Shortcut Definitions:";
xywh 6 45 186 180;cc skeyset listbox ws_border ws_vscroll;
xywh 200 45 70 12;cc add button;cn "&Add";
xywh 200 59 70 12;cc modify button;cn "&Modify";
xywh 200 76 70 12;cc original button;cn "Restore Original";
pas 6 6;pcenter;
rem form end;
)
cfskeys_run=: 3 : 0
if. y=0 do.
  MENU=: readmenu JIJS_jijs_
  wd CFSKEYS
  wd 'setcaption s0 *',SKEYNOTES
  wd 'settabstops skeyset 50'
end.
cfshowskeyset''
OLDMENU=: readmenu getjijs''
)
cfskeys_act=: ]
cfskeys_add_button=: 3 : 0
cfedskey_run SKEYNDX=: _1
)
cfskeys_cancel_button=: 3 : 0
wd 'pclose;'
)
cfskeys_modify_button=: 3 : 0
ndx=. cfskeys_index''
if. -. (1{ndx{MENU) e. skeyevents'' do.
  info 'Shortcut may not be changed: ',>1{ndx{MENU return.
end.
SKEYNDX=: ndx
cfedskey_run ''
)
cfskeys_original_button=: 3 : 0
MENU=: OLDMENU
SKEYNDX=: _1
cfshowskeyset''
)
getjijs=: 3 : 0
cocurrent 'jtemp'
0!:0 <jpath '~addons/ide/jnet/util/jijs.ijs'
res=. JIJS
cocurrent 'jcfg'
coerase <'jtemp'
res
)
cfskeys_index=: 3 : 0
if. 0 = #skeyset do. _1 return. end.
(1 {"1 MENU) i. < (<./ skeyset i. TAB,' ') {. skeyset
)
cfskeys_skeyset_button=: cfskeys_modify_button
cfshowskeyset=: 3 : 0
if. #MENU do.
  msk=. 0 < # &> 1 {"1 MENU
  key=. msk # 1 {"1 MENU
  cap=. msk # 2 {"1 MENU
  txt=. todel key ,each TAB ,each cap
  wd 'set skeyset ',txt
else.
  wd 'set skeyset'
end.
)
readmenu=: 3 : 0
mnu=. <;._2 y
mnu=. mnu #~ (<'menu') = 4 {.each mnu
mnu=. (mnu i.&> ';') {. each mnu
r=. i. 0 3
n=. p=. ''
for_m. mnu do.
  m=. > m
  x=. m i. ' '
  select. x {. m
  case. 'menu' do.
    txt=. ' ', deb x }. m
    sep=. (txt = ' ') > ~:/\ txt = '"'
    'id cp sc tt sh'=. 5 {. (sep <;._1 txt) -. each <'&"'
    r=. r, id;sc;n,cp
  case. 'menupop' do.
    p=. p, < (x }. m) -. ' &"'
    n=. ; p ,each '|'
  case. 'menupopz' do.
    p=. }: p
    n=. ; p ,each '|'
  case. 'menusep' do.
  case. do.
    info 'Unrecognized menu command: ',m
  end.
end.
r
)
SELNOTES=: textline 0 : 0
Startup selections take effect when you
next load J.
)
SMSTYLES=: todel cutopen 0 : 0
board.ijs
d:/jxs/board.ijs
board.ijs - d:/jxs/board.ijs
board.ijs* [20 3] d:/jxs/board.ijs
)
CFSTART=: 0 : 0
pc6j cfstart;pn "Configure View";
xywh 8 8 286 20;cc s0 static;
xywh 6 34 288 29;cc v1 groupbox;cn "Startup Script";
xywh 12 46 175 12;cc startup edit ws_border es_autohscroll;
xywh 195 46 70 12;cc startupopen button;cn "&Open";
xywh 6 70 288 64;cc v0 groupbox;cn "Windows";
xywh 11 85 93 12;cc a0 static;cn "Initial Session Position:";
xywh 11 100 93 12;cc a1 static;cn "New Window Size:";
xywh 11 116 93 12;cc a2 static;cn "Window Title Style:";
xywh 107 84 80 12;cc sminit edit ws_border es_autohscroll;
xywh 107 99 80 12;cc smsize edit ws_border es_autohscroll;
xywh 106 115 150 90;cc smstyle combolist;
xywh 195 83 70 12;cc currentpos button;cn "&Current Position";
xywh 195 98 70 12;cc currentsiz button;cn "Current &Size";
xywh 6 143 288 28;cc v2 groupbox;cn "Welcome to J";
xywh 11 154 276 11;cc newuser checkbox;cn "&Show Welcome to J form";
pas 2 2;pcenter;
rem form end;
)
cfstart_run=: 3 : 0
if. y=0 do.
  wd CFSTART
end.
CFSTARTH=: wd 'qhwndp'
wd 'setcaption s0 *',SELNOTES
wd 'set sminit *',sminit
wd 'set smsize *',smsize
wd 'set startup *',STARTUP
wd 'set smstyle ',SMSTYLES
wd 'setselect smstyle ',":SMSTYLE
cfstart_act''
)
cfstart_act=: 3 : 0
wd 'set newuser ',":NEWUSER
wd 'setenable newuser 1'
)
cfstart_currentpos_button=: 3 : 0
p=. ": getactsize_jijs_''
wd 'psel ',CFSTARTH
wd 'set sminit *',p
)
cfstart_currentsiz_button=: 3 : 0
p=. ": _2 {. getactsize_jijs_''
wd 'psel ',CFSTARTH
wd 'set smsize *',p
)
cfstart_startupopen_button=: 3 : 0
if. 0 = fexist jpath startup do.
  if. 2 query 'Startup file does not exist. Create it?' do.
    return. end.
  '' fwrite jpath startup
end.
open_j_ jpath startup
)
CFFKEYS=: 0 : 0
pc6j cffkeys;pn "Configure Fkeys";
xywh 6 8 150 11;cc t0 static;cn "Function Key Definitions:";
xywh 6 21 230 220;cc fkeyset listbox ws_border ws_vscroll;
xywh 240 21 52 12;cc add button;cn "&Add";
xywh 240 35 52 12;cc modify button;cn "&Modify";
xywh 240 54 52 12;cc delete button;cn "&Delete";
pas 6 6;pcenter;
rem form end;
)
cffkeys_run=: 3 : 0
if. y=0 do.
  wd CFFKEYS
  wd :: ] 'settabstops fkeyset 60'
end.
cfshowfkeyset''
)
cffkeys_act=: ]
cffkeys_add_button=: 3 : 0
cfedfkey_run FKEYNDX=: _1
)
cffkeys_cancel_button=: 3 : 0
wd 'pclose;'
)
cffkeys_modify_button=: 3 : 0
FKEYNDX=: {.(".fkeyset_select),_1
cfedfkey_run ''
)
cffkeys_fkeyset_button=: cffkeys_modify_button
cfshowfkeyset=: 3 : 0
if. #BOXFKEYS do.
  txt=. todel fkeylist_jijs_ BOXFKEYS
  wd 'set fkeyset ',txt
  wd 'setselect fkeyset ',": FKEYNDX=: 0 >. FKEYNDX
else.
  wd 'set fkeyset'
end.
)
cffkeys_delete_button=: 3 : 0
FKEYNDX=: {.(".fkeyset_select),_1
if. 0 > FKEYNDX do. return. end.
key=. fkeycase_jijs_ 0 pick FKEYNDX{BOXFKEYS
key=. (key i. TAB) {. key
msg=. 'Delete ',key,'?'
if. 0=0 wdquery 'Tools'; msg do.
  BOXFKEYS=: (FKEYNDX ~: i.#BOXFKEYS) # BOXFKEYS
  FKEYNDX=: FKEYNDX <. <:#BOXFKEYS
  cfshowfkeyset''
end.
)
FONTHELP=: textline 0 : 0
Use any fixed pitch font.
)
CFVIEW=: 0 : 0
pc6j cfview;pn "Configure View";
xywh 6 6 288 42;cc v2 groupbox;cn "Display Font";
xywh 12 31 160 12;cc smfont edit ws_border es_autohscroll;
xywh 180 30 52 12;cc browse button;cn "&Browse...";
xywh 12 17 235 12;cc fonthelp static;
xywh 6 58 288 58;cc v1 groupbox;cn "Display Form";
xywh 12 70 54 9;cc linear checkbox;cn "&Linear";
xywh 12 81 54 9;cc box checkbox group;cn "Bo&x";
xywh 12 92 54 9;cc tree checkbox group;cn "&Tree";
xywh 12 103 54 9;cc parens checkbox group;cn "&Parens";
xywh 81 70 161 11;cc multi checkbox;cn "Allow &Multiple Selections";
xywh 6 127 110 51;cc v3 groupbox;cn "Box Chars and Positioning";
xywh 14 143 50 9;cc ascii radiobutton;cn "&Ascii";
xywh 14 155 50 9;cc linedraw radiobutton group;cn "Li&nedraw";
xywh 73 140 32 32;cc gpos isigraph;
pas 6 6;pcenter;
rem form end;
)
cfview_run=: 3 : 0
if. y=0 do.
  wd CFVIEW
  if. IFJNET do. glnodblbuf 0 end.
  DISPLAYFORM=: 9!:2''
end.
GPOSORG=: 0 ". wd 'qchildxywhx gpos'
MULTI=: 1<#DISPLAYFORM
if. IFUNIX do.
  font=. FIXFONTJ
else.
  font=. FIXFONTW
end.
wd 'set smfont *',font
wd 'set fonthelp *',FONTHELP
wd 'set multi ',":MULTI
wd 'set linedraw ',":linedraw
wd 'set ascii ',":ascii
cfviewdisp''
cfview_gpos_paint''
)
cfview_gpos_paint=: 3 : 0
wd 'psel cfmain'
a=. 0 ". wd 'qchildxywhx gpos'
GPOSWH=: 3 * >. 3 %~ <./ (2 {. a % GPOSORG) * _2 {. GPOSORG
wd 'setxywhx gpos ',": (2 {. a), 1+ 2 # GPOSWH
cfps BOXPOS
)
cfview_act=: 3 : 0
glsel 'gpos'
)
cfviewdisp=: 3 : 0
wd 'set linear ',":5 e. DISPLAYFORM
wd 'set box ',":2 e. DISPLAYFORM
wd 'set tree ',":4 e. DISPLAYFORM
wd 'set parens ',":6 e. DISPLAYFORM
)
cfview_linear_button=: cfdisplay bind 5
cfview_box_button=: cfdisplay bind 2
cfview_tree_button=: cfdisplay bind 4
cfview_parens_button=: cfdisplay bind 6
cfview_cancel_button=: 3 : 0
wd 'pclose;'
)
cfview_browse_button=: 3 : 0
smfont=: mbfont smfont
wd 'set smfont *',smfont
)
cfview_gpos_mbldown=: 3 : 0
if. 0 ~: 4!:0 <'sysdata' do. empty'' return. end.
'x y w h'=. 4 {. 0 ". sysdata
px=. <. 2.99 * y % h
py=. <. 2.99 * x % w
cfps BOXPOS=: px,py
glpaint''
)
cfview_multi_button=: 3 : 0
if. MULTI do.
  MULTI=: 0
  DISPLAYFORM=: (1<.#DISPLAYFORM)$DISPLAYFORM
  cfviewdisp''
else.
  MULTI=: 1
end.
)
cfdisplay=: 3 : 0
DISPLAYFORM=: y cftoggle DISPLAYFORM
cfviewdisp''
)
cfps=: 3 : 0
'x y'=. y
xy=. >,{;~0 1 2
scale=. GPOSWH % 3
off=. IFWINCE * 16b40000000
f=. 0 ". wd @ ('qcolor '&,) @ ": @ (off&+)
glclear''
glpen 1 0 [ glrgb 0 0 0
glbrush glrgb IFJAVA pick (f 15);238 238 238
glrect 0 0, ,~ scale*3
glbrush glrgb f IFJAVA { 16 10
p=. 0 1 2 3
gllines scale * 0 ,. p ,. 3 ,. p
gllines scale * p ,. 0 ,. p ,. 3
glrect (0 0,2 > y,x) + scale * (y, x) , 1 1
)
cftoggle=: 4 : 0
if. x e. y do.
  y -. x
else.
  x , MULTI#y
end.
)
j=. <;._2 (0 : 0)
cfview Display
cfcolor Color
cffkeys Fkeys
cffolder Folders
cflint Format Script
cfforms Forms
cfopts Parameters
cfprint Print
cfsess Session
cfskeys Shortcuts
cfstart Startup
cfextern External Programs
)

ndx=. j i.&> ' '
TABGROUPS=: ((i.12)-.(0~:4!:0<'IFWIN32')#3 11){ ndx {.each j
TABNAMES=: ((i.12)-.(0~:4!:0<'IFWIN32')#3 11){ (ndx+1) }.each j
ALLTABGROUPS=: TABGROUPS
CFMAIN=: 0 : 0
pc6j cfmain;pn "Configure";
xywh 3 4 86 192;cc t0 groupbox;cn "Category";
xywh 6 16 80 178;cc category listbox ws_vscroll;
xywh 94 0 300 265;cc tabs groupbox;
xywh 12 206 69 10;cc saveconfig checkbox;cn "Save Config";
xywh 15 219 60 12;cc default button;cn "Set Defaults";
xywh 15 233 60 12;cc cancel button;cn "Cancel";
xywh 15 247 60 12;cc ok button;cn "OK";
xywh 3 196 86 69;cc g1 groupbox;cn "";
pas 3 6;pcenter;
rem form end;
)
cfmain_run=: 3 : 0

if. IFJAVA do.
  exclude=. <'cfcolor'
else.
  exclude=. ''
end.

msk=. -. TABGROUPS e. exclude
TABGROUPS=: msk # TABGROUPS
TABNAMES=: msk # TABNAMES

TABNDX=: 0
LOADED=: TABNDX { TABGROUPS

wd CFMAIN
JCFH=: wd 'qhwndp'
wd 'setshow tabs 0'
wd 'set category ',todel TABNAMES
wd 'setselect category 0'
wd 'creategroup tabs'
cfview_run''
wd 'creategroup'
wd 'setshow cfview 1'
wd 'set saveconfig 1'
wd 'pshow'
)
cfmain_category_select=: 3 : 0
swap 0 ". category_select
)
regclean=: 3 : 0
r=. tolower deb y -. {. a.
res=. r {.~ 1 i.~ (r=' ') > ~:/\r='"'
if. ('"' = {.res) *. '"' = {:res do. }. }: res end.
)

dlft_shellopen=: 3 : 0
'' if. 1~:>{.r=. querykeyvalue HKEY_CLASSES_ROOT;y;'' do.
  return. end.
if. 1~:>{.r=. querykeyvalue HKEY_CLASSES_ROOT;((}:>{:r),'/shell/open/command');'' do.
  return. end.
regclean >{:r
)
RegOpenKeyExA=: 'advapi32 RegOpenKeyExA i i *c i i *i'&cd
RegQueryValueExA=: 'advapi32 RegQueryValueExA i i *c i *i *c *i'&cd
RegCloseKey=: 'advapi32 RegCloseKey i i'&cd
HKEY_CLASSES_ROOT=: _2147483648
fullaccess=: 983103
querykeyvalue=: 3 : 0
2000 querykeyvalue y
:
'hkey subkey value'=. y
'rc handle'=. regopen hkey;subkey
if. rc~:0 do. (-rc);'' return. end.
'rc x x x type data len'=. RegQueryValueExA handle;value;0;(,0);(x${.a.);,x
'unable to close' assertrc regclose handle
if. rc~:0 do. (-rc);'' return. end.
({.type);({.len){.data
)
regopen=: 3 : 0
'hkey subkey'=. y
'rc x x x x handle'=. RegOpenKeyExA hkey;subkey;0;fullaccess;,0
rc;{.handle
)
regclose=: 3 : 0
>{.RegCloseKey ,<y
)
assertrc=: ([ , ' ('"_ , ":@] , ')'"_) assert ]=0:
CFSELECT=: 0 : 0
pc6j cfselect nomin owner;pn "Select";
xywh 0 0 250 175;cc lbselect listbox ws_vscroll rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
cfselect_run=: 3 : 0
'sel init return'=. 3 {. y
CFRETURN=: return
wd CFSELECT
wd 'set lbselect ',todel sel
if. #init do.
  wd 'setselect lbselect ',":init
end.
wd 'pshow'
)
cfselect_enter=: cfselect_lbselect_button=: cfselectdo bind 1
cfselect_cancel=: cfselect_close=: cfselectdo bind 0
cfselectdo=: 3 : 0
res=. y # lbselect
wd 'pclose'
CFRETURN~res
)
swap=: 3 : 0
ndx=. (#TABGROUPS) | y
new=. ndx pick TABGROUPS
if. -. (<new) e. LOADED do.
  wd 'creategroup tabs'
  (new,'_run')~0
  wd 'creategroup'
  LOADED=: LOADED,<new
else.
  (new,'_act')~0
end.
wd 'setshow ',(TABNDX pick TABGROUPS),' 0'
TABNDX=: ndx
wd 'setshow ',new,' 1'
select. new
case. 'cfextern' do.
  if. IFUNIX do.
    wd 'setshow bdef 0'
    wd 'setshow bepsdef 0'
    wd 'setshow bpdfdef 0'
  end.
end.
)
config 0
