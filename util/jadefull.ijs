coclass 'j'
Snapshots=: 0
FolderTree=: FolderIds=: 0
RecentMax=: 5
Folder=: RecentDirmatch=: RecentFif=: RecentFiles=: RecentProjects=: ''
Alpha=: a. {~ , (a.i.'Aa') +/ i.26
Num=: a. {~ (a.i.'0') + i.10
AlphaNum=: Alpha,Num
Boxes=: ((16+i.11) { a.),:'+++++++++|-'
ScriptExt=: '.ijs'
ProjExt=: '.jproj'

extnone=: {.~ i:&'.'
extproj=: , (ProjExt #~ '.'&e. < 0 < #)
extsrc=: , ('.ijs' #~ '.'&e. < 0 < #)

addfname=: , (e.&'/\' i: 1:) }. ]
boxdraw=: 3 : '9!:7 y { Boxes'
hostcmd=: [: 2!:0 '(' , ,&' || true)'
fpath=: [: }: +./\.@:=&'/' # ]
maxrecent=: 3 : '(RecentMax <. #r) {. r=. ~.y'
pack=: [: (,. ".&.>) ;: ::]
pdef=: 3 : '0 0$({."1 y)=: {:"1 y'
seldir=: #~ '-d'&-:"1 @ (1 4&{"1) @ > @ (4&{"1)
spath=: #~ [: *./\. '/'&~:
termLF=: , (0 < #) # LF -. {:
termsep=: , (0 < #) # '/' -. {:
tolist=: }.@;@:(LF&,each)
remsep=: }.~ [: - '/' = {:

path2proj=: ,'/',ProjExt ,~ spath
3 : 0''
if. IFUNIX do.
  filecase=: ]
  isroot=: '/' = {.
else.
  filecase=: tolower
  isroot=: ':' = {.@}.
end.
0
)
dirtreex=: 3 : 0
'' dirtreex y
:
y=. jpath y
p=. (+./\. y = '/') # y
d=. 1!:0 y,('/' = {:y) # '*'
if. 0 = #d do. '' return. end.
a=. > 4 {"1 d
m=. 'd' = 4 {"1 a
f=. (<p) ,each {."1 d
if. 1 e. m do.
  f=. f, ; dirtreex each (m#f) ,each <'/','*'
end.
if. #x do.
  f #~ (1 e. x E. ])&> f
end.
)
getfolderdefs=: 3 : 0
p=. (, '/' , ProjExt ,~ spath) each subdirtree y
t=. p #~ #@(1!:0)&> p
t;<fpath each (1+#y) }. each (-#ProjExt) }. each t
)
isconfigfile=: 3 : 0
'p f'=. fpathname y
x=. f i: '.'
(p -: jpath '~config/') *. '.cfg'-:x}.f
)
isdir=: 3 : 0
d=. 1!:0 y
if. 1 ~: #d do. 0 return. end.
'd' = 4 { 4 pick ,d
)
istempname=: 3 : 0
x=. y i: '.'
*./ ('.ijs'-:x}.y),(x{.y) e. Num
)
istempscript=: 3 : 0
'p f'=. fpathname y
(p -: jpath '~temp/') *. istempname f
)
jshowconsole=: 3 : 0
if. -.IFWIN do. 'only supported in windows' return. end.
t=. {.>'kernel32.dll GetConsoleWindow x'cd''
'user32.dll ShowWindow n x i'cd t;(0-:y){5 0
i.0 0
)
mkdir=: 3 : 0
a=. termsep y
if. #1!:0 }:a do. 1 return. end.
for_n. I. a='/' do.
  1!:5 :: 0: < n{.a
end.
)
newtempscript=: 3 : 0
x=. ScriptExt
p=. jpath '~temp/'
d=. 1!:0 p,'*',x
a=. (-#x) }. each {."1 d
a=. a #~ (*./ .e.&'0123456789') &> a
a=. 0, {.@:(0&".) &> a
p, x ,~ ": {. (i. >: #a) -. a
)
nounrep=: 2 }. [: ; [: nounrep1 each ;:
nounrep1=: LF2 , ] , '=: ' , [: nounrep2 ".
nounrep2=: 3 : 0
if. 0 = #y do. '''''' return. end.
select. 3!:0 y
fcase. 32 do.
  y=. ; y ,each LF
case. 2 do.
  if. LF e. y do.
    y=. y, LF -. {:y
    '0 : 0', LF, ; <;.2 y,')'
  else.
    quote y
  end.
case. do.
  ": y
end.
)
octal=: 3 : 0
t=. ,y
x=. a. i. t
n=. x e. 9 10 13
m=. n < 32 > x
if. (isutf8 t) > 1 e. m do. t return. end.
r=. t ,"0 1 [ 3 # EAV
if. #m=. I. m +. x>126 do.
  s=. '\',.}.1 ": 8 (#.^:_1) 255,m{x
  r=. s m} r
end.
EAV -.~ ,r
)
rmdir=: 3 : 0
r=. 1;'not a directory: ',":y
if. 0=#y do. r return. end.
d=. 1!:0 y
if. 1 ~: #d do. r return. end.
if. 'd' ~: 4 { 4 pick {. d do. r return. end.
if. IFWIN do.
  shell_jtask_ 'rmdir ',y,' /S /Q'
else.
  hostcmd_j_ 'rm -rf --preserve-root ',y
end.
(#1!:0 y);''
)
fpathname=: +./\.@:(=&'/')@:('/'&(I.@(e.&'/\')@]})) (# ; -.@[ # ]) ]
setfolder=: 3 : 0
if. 0=#y do.
  Folder=: FolderTree=: FolderIds=: '' return.
end.
assert. (<y) e. {."1 UserFolders
Folder=: y
'FolderTree FolderIds'=: getfolderdefs jpath '~',y
if. 3=nc <'snapshot_tree_jp_' do.
  snapshot_tree_jp_ FolderTree
end.
EMPTY
)
subdirtree=: 3 : 0
if. 0=#1!:0 y do. '' return. end.
r=. ''
dir=. <y,'/'
while. #dir do.
  fpath=. (>{.dir) &,
  dir=. }.dir
  dat=. seldir 1!:0 fpath '*'
  if. #dat do.
    dat=. fpath each {."1 dat
    r=. r,dat
    dir=. (dat ,each '/'),dir
  end.
end.
sort filecase each r
)
unixshell=: 3 : 0
f=. jpath '~temp/shell.sh'
t=. jpath '~temp/shell.txt'
e=. jpath '~temp/shell.err'
('#!/bin/sh',LF,y,LF) fwrite f
'rwx------' 1!:7 <f
hostcmd '"',f,'" > "',t,'" 2> "',e,'"'
r=. (fread t);fread e
ferase f;t;e
r
)
unixshellx=: 3 : 0
'res err'=. unixshell y
if. #err do.
  smoutput 'Shell command error: ',LF,LF,err
end.
res
)
htmlhelp=: 3 : 0
f=. jpath '~addons/docs/help/',y
if. fexist ({.~ i:&'#') f do.
  browse 'file://',f
else.
  f=. 'http://www.jsoftware.com/docs/help',}.(i.&'/'{.]) 9!:14''
  browse f,'/',y
end.
)
htmlhelp602=: 3 : 0
f=. jpath '~addons/docs/help/',y
if. ('user/contents.htm'-.@-:y) *. fexist ({.~ i:&'#') f do.
  browse 'file://',f
else.
  f=. 'http://www.jsoftware.com/docs/help','602'
  browse f,'/',y
end.
)
browseref=: 3 : 0
htmlhelp 'dictionary/',y
)
recentmax=: 3 : '({.~ RecentMax <. #) ~.y'
recentfiles_add_j_=: 3 : 0
RecentFiles_j_=: recentmax (<jpath y),RecentFiles_j_
recentsave''
)
recentproj_add=: 3 : 0
RecentProjects_j_=: recentmax (<jpath y),RecentProjects_j_
recentsave''
)
recentsave=: 3 : 0
n=. 'Folder RecentDirmatch RecentFif RecentFiles RecentProjects'
r=. 'NB. gtkide recent',LF2,nounrep n
r fwritenew_jp_ jpath '~config/recent.dat'
)
BOXES=: ((16+i.11) { a.),'+++++++++|-',:218 194 191 195 197 180 192 193 217 179 196{a.
boxdraw=: 3 : '9!:7 y { BOXES'
config=: 3 : 0
load 'ide/jnet/util/configure'
)
debug=: 3 : 0
require 'ide/jnet/util/debug'
dbgjn 1
)
demos=: 3 : 0
load 'ide/jnet/demo/jndemo'
)
dirmatch=: 3 : 0
require 'ide/jnet/util/dirmatch'
dmrun_jdirmatch_ y
)
editfind=: 3 : 0
require 'ide/jnet/util/fiw'
fiw_jfiw_ y
)
fif=: 3 : 0
require 'ide/jnet/util/fif'
fif_jfif_ y
)
filenewform=: 3 : 0
require 'ide/jnet/util/wizard'
classwizard_jwizard_''
)
fileprint_j_=: 3 : 0
smselact_jijs_''
dat=. smread_jijs_''
if. ~:/ r=. smgetsel_jijs_'' do.
  prints (--/r) {. ({.r) }. dat
else.
  prints dat
end.
)
fileprintsetup=: empty @ wd bind (IFJNET{::'mbprinter pd_printsetup';'mbprinter')
formedit=: 3 : 0
require 'ide/jnet/util/formedit'
y conew 'jformedit'
)
forms=: 3 : 0
require 'ide/jnet/util/forms'
forms_jforms_''
)
gridwizard=: 3 : 0
require 'ide/jnet/util/autocode'
autocode_jautocode_ y
)
help=: 3 : 0
require 'ide/jnet/util/help'
require 'ide/jnet/util/scripdoc'
help_jhelp_ y
)
lab=: 3 : 0
require 'ide/jnet/util/lab'
lab_jlab_ y
)
prints=: 3 : 0
'' prints y
:
require 'print'
f=. SMPRINT_j_
try.
  x f~ y
catch.
  wdinfo 'Print';'Print failed.',LF,LF,'Check the printer is installed'
end.
)
printfiles=: 3 : 0
'' printfiles y
:
require 'print'
f=. SMPRINT_j_
f=. (5{.f),'file',5}.f
try.
  x f~ y
catch.
  wdinfo 'Print';'Print failed.',LF,LF,'Check the printer is installed'
end.
)
pacman=: 3 : 0
require 'ide/jnet/util/pacman'
runpacman_jpacman_ y
)
projectmanager=: 3 : 0
require 'ide/jnet/util/project'
projectmanager_jnproject_ y
)
projectmanager6=: 3 : 0
require 'ide/jnet/util/project6'
projectmanager_jproject_ y
)
INPUTLOGFILE=: jpath '~config/input.log'
getinputlog=: 3 : 0
log=. wd 'sminputlog'
log=. < @ dltb ;._2 log
log=. log #~ (1: e. e.&(33}.127{.a.)) &> log
|. ~. |. log
)
editinputlog=: 3 : 0

log=. getinputlog''

if. 0=#log do.
  wdinfo 'Input Log';'Nothing in the input log' return.
end.

'old sel'=. INPUTLOG
if. log -: old do.
  x=. sel
else.
  x=. <:#log
end.

INPUTLOG_j_=: log;x

sel=. INPUTLOG,'Input Log';'editinputprompt'
sel conew 'jpick'
)
editinputprompt=: 3 : 0
if. # y do.
  log=. 0 pick INPUTLOG
  INPUTLOG_j_=: log ; y
  smprompt_jijs_ '   ',y pick log
end.
)
INPUTLOG=: '';0
WINPOS=: i.0 2
filex=: ] , ([: -. '.'"_ e. ]) # [

TARGET=: i.0 2
edit=: 3 : 0
'n s'=. y
file=. {.,getscripts_j_ s
dat=. 1!:1 :: _1: file
if. dat -: _1 do.
  'file read error: ',,>file return.
end.
dat=. toJ dat
dat=. < @ (;: :: <) ;._2 dat,LF
ndx=. I. (1: e. (n;'=:')&E.) &> dat
if. 0 = #ndx do.
  m=. }:(2<:+/\.n='_')#n
  ndx=. I. (1: e. (m;'=:')&E.) &> dat
end.
if. 0 = #ndx do.
  wdinfo 'not found: ',":n return.
end.
if. IFWINCE do.
  open file
else.
  ({.ndx) flopen_jijs_ file
end.
)

formeditrun=: 3 : 0
'form file'=. y
load file
if. +./'coclass' E. 1!:1<file do.
  t1=. 'object=:''''conew''',form,''''
  t2=. 'object_base_ =:''''conew_base_''',form,''''
else.
  t1=. form,'_run'''''
  t2=. form,'_run_base_'''''
end.
smoutput '   ',t1
".t2
empty''
)
loadp=: ''&$: : (4 : 0)
require 'ide/jnet/util/project6'
x loadproject_jproject_ y
)
open=: 3 : 0
f=. ,getscripts y
b=. exist"0 f
if. 0 e. b do.
  j=. (b=0)#f
  if. 1=#j do. j=. ,>j
  else. j=. LF,; LF&, each j
  end.
  wdinfo 'Open';'not found: ',j
end.
if. #f=. b#f do. openfiles f end.
)
openfiles=: 3 : 0
try.
  flopen_jijs_ each y
catch. end.
empty''
)
save=: 4 : 0
fl=. boxopen x
lc=. y
'' 1!:2 fl
if. 0=#lc do. lc=. 4!:1[6 end.
lc=. , each cutopen lc
lc=. (lc e.4!:1[6)#lc
if. 0=#lc do. empty'' return. end.
nms=. 3 : '(<''y'')-.~(''namelist_'',(y),''_'')~0 1 2 3' each lc
nms=. ;nms (,each <) each '_'&,@(,&'_') each lc
res=. nms ,each <'=:'
res=. res ,each <@(5!:5) nms
res=. ; res ,each LF
(toHOST res) 1!:3 fl
empty ''
)
saveuserfolders=: 3 : 0
0!:0 <jpath '~addons/ide/jnet/util/cfguser.ijs'
)
scriptmake=: 4 : 0
y=. getscripts y
txt=. ''
while. #y do.
  f=. {.{.y
  dat=. 1!:1 :: _1: f
  if. dat -: _1 do.
    'file read error: ',>f return.
  end.
  txt=. txt,LF,dat
  y=. }.y
end.
txt=. toJ txt,LF
txt=. <;._2 txt
f=. #~ -.@(('NB.'&-:)@(3&{.)&>)
txt=. f txt
f=. 'NB.'&E. <: ~:/\@(''''&=)
g=. (,&CRLF)@(#~ *./\@f)
txt=. ;g each txt
txt 1!:2 boxopen x
#txt
)
scripts=: 3 : 0
if. 0=#y do.
  list 0{"1 PUBLIC
elseif. 'reset'-:y do.
  0!:0 <SCRIPTS
elseif. 'v'e.y do.
  dir=. PUBLIC
  a=. >0{"1 dir
  b=. >1{"1 dir
  a /:~ a,.' ',.b
elseif. 'e' e.y do.
  open SCRIPTS
elseif. 1 do.
  'invalid argument to scripts: ',,":y
end.
)
lastactive_j_=: 3 : 0
d=. wdforms''
b=. (3 {"1 d) e. 'jijs';'jijx'
d=. b#d
last=. ".>4{"1 d
b=. last=>./last
>1{,b#d
)
cleantable=: [: sort ([: ~: {."1) # ]
globaldefs=: 3 : 0
dat=. <;._2 y,LF
f=. [: (#~ (<'=:')&-:@{:) [: 2&{. ;:
def=. f &.> dat
b=. *#&>def
nms=. {.&>b#def
ndx=. b#i.#b
ind=. /:>nms
(ind{nms);<ind{ndx
)
origin=: 3 : 0
((<''),4!:3 '') {~ >: 4!:4 cutopen y
)
0!:0 :: ] <jpath '~config/winpos.ijs'


3 : 0 ''
if. IFUNIX do. return. end.
GetSystemMetrics=: >@{.@('User32 GetSystemMetrics i i' & (15!:0))
SM_CMONITORS=: 80
SM_XVIRTUALSCREEN=: 76
SM_YVIRTUALSCREEN=: 77
SM_CXVIRTUALSCREEN=: 78
SM_CYVIRTUALSCREEN=: 79
)

fixWINPOS=: 3 : 0
if. IFUNIX do. return. end.
sm=. GetSystemMetrics"0 SM_XVIRTUALSCREEN,SM_YVIRTUALSCREEN
q=. 0 1{"1 >1{"1 WINPOS_j_
f=. q<"1 sm
rp=. (f*"1 sm)+q*"1 -.f
qq=. (<"1 rp) (0 1)}&.> ]1{"1 WINPOS_j_
WINPOS_j_=: qq 1}"0 1 WINPOS_j_
)
wpsave=: 3 : 0
'' wpsave y
:
if. #y do.
  if. #x do.
    pos=. x
  else.
    if. # wd :: 0: 'psel ',y do. return. end.
    pos=. 0 ". wd 'qformx'
  end.
  siz=. _2 {. pos

  if. IFJAVA do.
    max=. 2 {. 0 ". wd 'qm'
  else.
    max=. 14 15 { 0 ". wd 'qm'
  end.

  min=. 100 40
  if. 1 e. (min > siz) +. max < siz do. return. end.
  ndx=. ({."1 WINPOS_j_) i. <y
  if. ndx = #WINPOS_j_ do.
    WINPOS_j_=: WINPOS_j_,y;pos-1
  end.
  if. pos -: >{:ndx{WINPOS_j_ do. return. end.
  WINPOS_j_=: (y;pos) ndx}WINPOS_j_
end.
dat=. 'WINPOS=:',5!:5 <'WINPOS_j_'
dat 1!:2 <jpath '~config/winpos.ijs'
)
wpset=: 3 : 0
ndx=. ({."1 WINPOS_j_) i. <y
if. r=. ndx < #WINPOS_j_ do.
  fixWINPOS''
  'x y w h'=. >{:ndx{WINPOS_j_
  'sx sy'=. 2 {. 0 ". wd 'qm'
  x=. x <. sx - w=. w <. sx
  y=. y <. sy - h=. h <. sy
  wd 'pmovex ',":x,y,w,h
end.
r
)
wpreset=: 3 : 0
if. #y=. a: -.~ boxopen y do.
  b=. -. ({."1 WINPOS_j_) e. y
else. b=. 0 end.
WINPOS_j_=: b#WINPOS_j_
wpsave''
)
xedit=: 0&$: : (4 : 0)
'file row'=. 2{.(boxopen y),<0
file=. ,file
if. IFJHS do.
  xmr ::0: file
  EMPTY return.
end.
editor=. (Editor_j_;Editor_nox_j_){::~ nox=. (UNAME-:'Linux') *. (0;'') e.~ <2!:5 'DISPLAY'
if. 0=#editor do. EMPTY return. end.
if. 1 e. '%f' E. editor do.
  cmd=. editor stringreplace~ '%f';(dquote >@fboxname file);'%l';(":>:row)
else.
  cmd=. editor, ' ', (dquote >@fboxname file)
end.
try.
  if. IFUNIX do.
    if. x do.
      2!:1 cmd
    else.
      2!:1 cmd, (0=nox+.(1 -.@e. 'term' E. editor)*.(1 e. '/vi' E. editor)+.'vi'-:2{.editor)#' &'
    end.
  else.
    (x{0 _1) fork_jtask_ cmd
  end.
catch.
  msg=. '|Could not run the editor:',cmd,LF
  msg=. msg,'|You can change the Editor definition in Edit|Configure|Base'
  smoutput msg
end.
EMPTY
)
cocurrent 'z'
loadp=: loadp_j_
open=: open_j_
scripts=: scripts_j_
edit=: 3 : 0
y=. cutopen y
if. 0=#y do. empty'' return. end.
if. 1=#y do.
  if. _1 = s=. 4!:4 y do.
    open y return. end.
  y=. y,<s{4!:3 ''
end.
edit_j_ y
)
