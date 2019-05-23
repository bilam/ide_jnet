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

