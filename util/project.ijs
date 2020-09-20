require 'project'

coclass 'jnproject'

3 : 0 ''
if. IFCONSOLE do.
  saveopenwindows=: ]
  coinsert 'j'
else.
  require 'jview'
  coinsert 'j jijs'
end.
)
defaultvalue=: 4 : 'if. _1 = 4!:0 <x do. (x)=: y end.'

MAXRECENT=: 20
'SAVECFG' defaultvalue 1

PJFILES=: ''
PROJECTFILE=: ''
PROJECTPATH=: ''
PROJECTRECENT=: ''
PROJECTLOOKIN=: ''
CURRENTPATH=: ''

PID=: ''
PIDPATH=: ''
PIDTREE=: ''
PROJECTCFG=: jpath '~config/projects.ijs'
WINDOWS=: ''
PPSCRIPT=: jpath '~system/util/pp.ijs'

XPROJECTRECENT=: PROJECTRECENT
XPROJECTLOOKIN=: PROJECTLOOKIN
XFILES=: ''

j=. 'PRIMARYFILES'
PFILENAMES=: ;: j,' WINDOWS'
PFILESEPS=: PFILENAMES
projreset=: 3 : 0
(PFILENAMES)=: a:
)
closeproject=: 3 : 0
projsave 0
projclose_jp_''
try.
  wd 'psel ',HWNDP
  wpsave 'projectform'
  wd 'pclose'
catch. end.
HWNDP=: ''
)
cutcommas=: 3 : 0
if. #y do.
  a: -.~ <;._1 ',', y
else.
  ''
end.
)
getpmfolders=: 3 : 0
a=. jpath '~system/'
b=. {:"1 y
m=. (<a) ~: (#a) {.each b
m=. m *. b ~: <}:a
m # y
)
ifuserfolder=: 3 : 0
(<(y i. PATHSEP) {. y) e. {."1 UserFolders
)
loadlastp=: 3 : 0
if. 0 ~: 4!:0 <'LASTPROJECT_jprojsave_' do. return. end.
'' loadproject LASTPROJECT_jprojsave_
)
loadps=: 3 : 0
cocurrent 'base'
load PROJECTPATH_jnproject_,y
)
openp=: 3 : 0
projreset''
setprojfile y
projread ''
empty''
)
openpr=: 3 : 0
openp y
projaddrecent''
empty''
)
openpp=: 3 : 0
openp y
projectform_run''
)
opennewproject=: 3 : 0
projsave 0
while. 1 do.
  j=. '"Project Files(*.jproj)|*.jproj" ofn_nochangedir'
  f=. jpathsep mbsave '"New Project File" "',PIDPATH,'" "" ',j
  if. ''-:f do. return. end.
  f=. extjproj f
  if. -. '.jproj' -: _6 {.f do.
    info 'Project filename extension should be .jproj'
  elseif. fexist f do.
    if.
      msg=. f,LF,'This file already exists.'
      msg=. msg,LF,LF,'Replace existing file?'
      0=2 1 query msg do. break.
    end.
  elseif. 1 do. break.
  end.
end.

setprojfile f
projreset''
projsave 0
openprojectfile PROJECTFILE
projectform_show''
projaddrecent''
)
openoldproject=: 3 : 0
projsave 0

while. 1 do.
  j=. '"Project Files(*.jproj)|*.jproj" ofn_filemustexist ofn_nochangedir'
  f=. jpathsep mbopen '"Open Project File" "',PIDPATH,'" "" ',j
  if. ''-:f do. return. end.
  f=. extjproj f
  if. '.jproj' -: _6 {.f do. break. end.
  info 'Project filename extension should be .jproj'
end.

openprojectfile f
projectform_show''
)
openprojectfile=: 3 : 0
file=. fullproject y

if. 0 = '.jproj' -: _6 {. file do.
  info 'Not a project file: ',file
  0 return.
end.

if. 0=fexist file do.
  info 'not found: ',file
  XPROJECTRECENT=: XPROJECTRECENT -. <file
  0 return.
end.

setprojfile file
p=. fullname@addfret each 1 {"1 UserFolders
if. -. XPROJECTLOOKIN -: (#XPROJECTLOOKIN) {. file do.
  XPROJECTLOOKIN=: PROJECTLOOKIN=: ''
end.
b=. p = <XPROJECTLOOKIN

if. 1 e. b do.
  x=. i. # p
else.
  x=. \: # &> p
  p=. x { p
  m=. [ -: #@[ {. ]
  b=. p m &> <file
end.

if. 1 e. b do.
  ndx=. b i. 1
  pn=. 0 pick ndx { x { UserFolders
  if. PID -: pn do.
    PJFILES=: sort ~. PJFILES, <file
  else.
    setprojpath pn, _1 |. (getpidpath pn) drophead XPROJECTLOOKIN
  end.
else.
  pn=. delfret fpath file
  setprojpath pn
end.

setpidtree''
projread''
snapshot''
projopen_jp_ file
1
)
getselectfiles=: 3 : 0
r=. ''
select. TABNDX
case. 0 do.
  if. #bpfiles_select do.
    r=. (".bpfiles_select) { BPFILES
    r=. CURRENTPATH&,&.> r
  end.
case. 1 do.
  if. #filelist_select do.
    r=. (".filelist_select) { XFILES
    r=. PROJECTPATH&,&.> r
  end.
end.
if. 0 = #r do. infonosel'' return. end.
if. 0 e. b=. (0~:ftype) &> r do.
  info 'not found:',LF,LF,tolist (b=0)#r
  '' return.
end.
r
)
popenfiles=: 3 : 0
if. # f=. getselectfiles '' do.
  for_f1. f do.
    if. '..'-:_2{.f2=. >f1 do.
      if. 2=ftype f2=. ({.~ i:&'/') f2=. _3}.f2 do.
        CURRENTPATH=: f2,'/'
        bfiles_show''
      end.
    elseif. '/'={:f2 do.
      if. 2=ftype }:f2 do.
        CURRENTPATH=: f2
        bfiles_show''
      end.
    elseif. do.
      ext=. < tolower@(}.~ i:&'.') f2
      if. ext e. <;._1 ' .bmp .gif .ico .jpeg .jpg .png' do.
        viewimage_j_ f2
      elseif. ext e. <;._1 ' .pdf' do.
        viewpdf_j_ f2
      elseif. do.
        open_j_ f2
      end.
    end.
  end.
end.
projaddrecent''
)
3 : 0''
if. IFUNIX do.
  filecase=: [
else.
  filecase=: tolower
end.
0
)
EMPTY=: i. 0 0

bcfind=: #@[ (| - =) i. &: (filecase each)
bcfind0=: {."1 @ [ bcfind ]
find=: #@[ (| - =) i.
find0=: {."1 @ [ bcfind ]

boxlist=: (<;._2) -. a:"_
delstring=: 4 : ';(x E.r) <@((#x)&}.) ;.1 r=. x,y'
do=: ".
drophead=: ] }.~ #@[ * [ -: &: filecase #@[ {. ]
fix=: _1&".
fsep=: '/'&(I.@(=&'\')@]})
hostcmd=: [: 2!:0 '(' , ,&' || true)'
index=: #@[ (| - =) i.
info=: wdinfo @ ('Project Manager'&;)
infonoproj=: info bind 'First select a project file'
infonosel=: info bind 'No file selected'
infonospec=: info bind 'No file specified'
intersect=: e. # [
isempty=: 0: e. $
matchhead=: [ -: &: filecase #@[ {. ]
pkg=: [: (, ,&< ".)&> ;:
query=: wdquery 'Project Manager'&;
sort=: /:~ : /:
subs=. 2 : 'm I. @(e.&n)@]} ]'
addfret=: , PATHSEP -. [: {: PATHSEP , ]
delfret=: }: , {: -. PATHSEP"_
termLF=: , (0: < #) # LF"_ -. _1&{.
termdelLF=: {.~ 1: i.~ [: *./\. =&LF
toblank=: ' ' subs '_'
tounderscore=: '_' subs ' '
tolist=: }. @ ; @: (LF&, each)
tolist2=: (2&}.) @ ; @: ((LF,LF)&, each)
xin=: [ -. -.
a=. ''''
quote=: (a&,@(,&a))@ (#~ >:@(=&a))
imxq=: 9!:26
imxs=: 9!:27
imxsq=: 9!:28
imxss=: 9!:29
dquote=: '"'&, @ (,&'"')
addNB=: 3 : 0
if. 0=#y do. '' return. end.
y=. <;._2 termLF y
b=. 0='NB.'&-: @ (3&{.) &> y
add=. b #each <'NB. '
tolist add ,each y
)
batchcmd=: 3 : 0
'dir cmd'=. y
if. IFUNIX do.
  unixshellx 'cd ',(dquote dir),LF,cmd
else.
  t=. jpath '~temp/unzip.bat'
  r=. 2 {. dir
  r=. r,LF,'cd ',dquote 2 }. dir
  r=. r,LF,cmd
  r fwrites t
  shell t
  ferase t
end.
)
copynew=: 4 : 0
y=. boxopen y
dat=. fread each y
if. 1 e. b=. dat = <_1 do.
  info 'file not found:',,' ',.>b#y
  return.
end.
x copyto ; dat
)
copyto=: 4 : 0
datold=. fread x
datnew=. y
if. datold -: datnew do.
  'no change, size: ',":#datnew
else.
  res=. datnew fwrite x
  if. res -: _1 do.
    if. 0 = pathcreate fpath x do.
      info 'Cannot create path: ',fpath x return.
    end.
  end.
  res=. datnew fwrite x
  if. res -: _1 do.
    info 'Could not write to: ',x return.
  end.
  'copied, size: ',":#datnew
end.
)
dcopynew=: 4 : 0
fm=. addfret y
to=. addfret x
nms=. 1 dir fm
for_n. nms do.
  id=. 1 pick pathname >n
  (to,id) copynew >n
end.
)
decomment=: 3 : 0
dat=. <;._2 termLF toJ y
if. 2 > #dat do. y return. end.

com=. ('NB.'&-:)@(3&{.)&> dat
ncm=. com < (1|.0,}.com) +. (0,}._1|.com)
msk=. com +: ncm *. dat=a:

dat=. msk # dat

f=. 'NB.'&E. <: ~:/\@(e.&'''')
g=. #~ *./\@f
LF,~ tolist g each dat
)
flwritesnew=: 4 : 0
dat=. x
if. -. 0 e. $dat do.
  if. 1>:#$dat do.
    dat=. toHOST dat
    dat=. dat,(LF ~: {:dat)#CRLF
  else. dat=. dat,"1 CRLF
  end.
end.
dat flwritenew y
)
flwritenew=: 4 : 0
dat=. ,x
new=. -. dat -: fread y
if. new do. dat fwrite y end.
new
)
loadscript=: 3 : 0
cocurrent 'base'
load PROJECTPATH_jnproject_,y
)
loaddscript=: 3 : 0
cocurrent 'base'
loadd PROJECTPATH_jnproject_,y
)
nounrep=: 3 : 0
LF ,~ y,'=: ',nounrep1 ". y
)
nounrep1=: 3 : 0
dat=. y
if. #dat do.
  select. 3!:0 dat
  case. 2 do.
    if. LF e. dat do.
      dat=. dat, LF -. {:dat
      '0 : 0', LF, ; <;.2 dat,')'
    else.
      quote dat
    end.
  case. 32 do.
    5!:5 <'dat'
  case. do.
    ": dat
  end.
else.
  ''''''
end.
)
openterminal=: 3 : 0
2!:1 'gnome-terminal --working-directory=', (dquote PROJECTPATH),' &'
)
pathcreate=: 3 : 0
p=. jpathsep y
p=. p, PATHSEP_j_ -. {: p
if. # 1!:0 }: p do. 1 return. end.
p=. (p e. '/\') <;.2 p
t=. ''
f=. 1!:5 :: 0:
while. #p do.
  t=. (_1 { p), t
  p=. }: p
  if. # 1!:0 }: ; p do.
    p=. ; p
    while. #t do.
      p=. p, > 0 { t
      t=. }. t
      if. 0 = f < p do. 0 return. end.
    end.
    1 return.
  end.
end.
0
)
shellcmd=: 3 : 0
if. IFUNIX do.
  'res err'=. unixshell y
  if. #err do.
    res=. res,((0<#res)#LF,LF),err
  end.
  res
else.
  spawn_jtask_ y
end.
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
  info 'Shell command error: ',LF,LF,err
end.
res
)
snapfilecopy=: 3 : 0
'source dest'=. y
if. IFWIN do.
  0 pick 'kernel32 CopyFileW i *w *w i' cd (uucp source);(uucp dest);0
else.
  if. 0 = pathcreate fpath dest do. 0 return. end.
  if. _1 -: dat=. fread source do. 0 return. end.
  -. _1 -: dat fwrite dest
end.
)
BFILES=: 0 : 0
pc6j bfiles owner;
xywh 3 3 55 11;cc s0 static;cn "Directory:";
xywh 3 14 188 11;cc currentpath static rightmove;cn "";
xywh 2 26 148 147;cc bpfiles listbox ws_hscroll ws_vscroll lbs_extendedsel rightmove bottommove;
xywh 154 26 38 12;cc bopen button leftmove rightmove;cn "&Open";
xywh 154 157 38 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
pas 0 0;
rem form end;
)
bfiles_run=: 3 : 0
wd BFILES
wd 'pshow;'
)
bfiles_cancel_button=: closeproject
bfiles_show=: 3 : 0
BPFILES=: buildfiles''
wd 'setcaption currentpath *', CURRENTPATH
if. #BPFILES do.
  wd 'set bpfiles *',tolist BPFILES
else.
  wd 'set bpfiles'
end.
)

bfiles_bopen_button=: popenfiles
bfiles_bpfiles_button=: popenfiles
buildfiles=: 3 : 0
if. 0=#PROJECTFILE do. '' return. end.
if. #a=. 1!:0 < CURRENTPATH,'*' do.
  a=. (#~ ('.'~:{.)&>) {."1 a
  f=. (#~ (1=ftype@(CURRENTPATH&,))&>) a
  d=. ,&'/'&.> (#~ (2=ftype@(CURRENTPATH&,))&>) a
  (<'..'),(/:~d),/:~f
else.
  ,<'..'
end.
)
buildproject=: 3 : 0
saveopenwindows''
buildtarget''
)
buildapp=: 3 : 0

saveopenwindows''
getfoldernames''
projsave 0
projaddrecent''
buildproject''
)
buildtarget=: 3 : 0
)
CFG=: 0 : 0
pc6j cfg owner;pn "Configuration";
xywh 6 8 248 74;cc v1 groupbox rightmove;cn "Snapshots";
xywh 11 20 86 11;cc busesnaps checkbox;cn "Use Snapshots";
xywh 11 34 59 11;cc s3 static;cn "Max Snapshots:";
xywh 72 33 20 12;cc snaps edit ws_border es_autohscroll;
xywh 11 49 238 11;cc s4 static;cn "Exclusion List (comma separated):";
xywh 11 63 239 12;cc snapx edit ws_border es_autohscroll rightmove;
xywh 275 12 44 12;cc ok button leftmove rightmove;cn "OK";
xywh 275 26 44 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)
cfg_run=: 3 : 0
if. y=0 do.
  wd CFG
end.
USESNAPS=: 0 < PMSNAPS
MAXSNAPS=: PMSNAPS + 5 * PMSNAPS=0
CFSNAPX=: PMSNAPX
cfg_show''
wd 'setfocus ok'
wd 'pshow'
)
cfg_refresh=: 3 : 0
cfg_read''
cfg_show''
)
cfg_busesnaps_button=: cfg_refresh
cfg_ok_button=: 3 : 0
cfg_read''
PMSNAPS=: USESNAPS * MAXSNAPS
PMSNAPX=: CFSNAPX
projcfgsave''
wd 'pclose'
wd 'psel ',HWNDP
wd 'setenable snapmake ',": 0 < PMSNAPS
wd 'setenable snapview ',": 0 < PMSNAPS
)
cfg_read=: 3 : 0
USESNAPS=: 0 ". busesnaps
MAXSNAPS=: 0 ". snaps
CFSNAPX=: deb each cutcommas snapx
)
cfg_show=: 3 : 0
b=. ": USESNAPS
wd 'set busesnaps ',b
wd 'setenable snaps ',b
wd 'setenable snapx ',b
wd 'set snaps ',": MAXSNAPS
wd 'set snapx *', 2 }. ; (<', ') ,each CFSNAPX
)
cfg_cancel_button=: wd bind 'pclose'
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP)#y'
fpath=: 3 : 'y#~+./\.y=PATHSEP'
fexist=: (1:@(1!:4) :: 0:) @ (fboxname &>) @ boxopen
fexists=: #~ fexist&>
jpathsep=: '/' & (I.@(=&'\')@]})
extjproj=: 3 : 0
y, (('.ijp' -: _4 {. y) < ((0 < #y) > '.jproj' -: _6 {. y)) # '.jproj'
)
extijs=: ]
extnone=: ]
fullname=: 3 : 0
if. 0 = # y do. '' return. end.
p=. '/'
d=. fromfoldername1 y
d1=. jpathsep d
b=. (</ d1 i. ':',p) +. ('~' = {. d1) +. (2{.d1) -: 2#p
if. b do.
elseif. p ~: 1{.d1 do.
  d=. jcwdpath d
elseif. IFWIN do.
  d=. (2{.jcwdpath''),d
end.

filecase d
)
fullproject=: fullname @ extjproj
fullscript=: (0: < #) # fullname @ extijs
pidname=: 3 : 0
y=. PIDPATH drophead ({.~ i:&'/') y
x=. <;.1 PATHSEP,y
if. =/ _2 {. x do. }. ; }: x else. y end.
)
cutdeb=: [: -.&a: <@deb;._2@termLF

pr1=: cutdeb
pr2=: cutdeb
pr3=: cutopen @ termLF

tr1=: tolist @: (extnone each)
tr2=: tolist
changedepth=: 3 : 0
if. 0 = #PROJECTFILE do. return. end.
if. y=1 do.
  a=. PIDPATH&drophead each PJFILES
  PIDTREE=: (PID,PATHSEP) &, each ~.(a i.&> PATHSEP) {. each a
  path=. getpidpath PID
  rest=. path drophead PROJECTFILE
  ndx=. rest i. PATHSEP
  dir=. ndx {. rest
  PID=: PID, PATHSEP, dir
  PIDPATH=: PIDPATH, dir, PATHSEP
  msk=. (<PIDPATH) = (#PIDPATH) {.each PJFILES
  PJFILES=: msk # PJFILES
else.
  ndx=. PID i: PATHSEP
  PID=: ndx {. PID
  ndx=. 1 + (}:PIDPATH) i: PATHSEP
  PIDPATH=: ndx {. PIDPATH
  PJFILES=: fullproject each projgetfiles PIDPATH
  setpidtree''
end.
projsetlookin''
)
deletefile=: 3 : 0

p=. PROJECTPATH
j=. '"Script Files (*.ijs)|*.ijs|Text Files (*.txt)|*.txt|'
j=. j,'All Files (*.*)|*.*" ofn_nochangedir'
f=. mbopen '"Delete File" "',p,'" "" ',j

if. ''-:f do. return. end.
if. 0=fexist f do. return. end.
if. 1=2 query 'OK to delete: ',f,'?' do. return. end.

file=. <f
1!:55 file
XPRIMARYFILES=: XPRIMARYFILES jflminus file
showfiles''
)
fixfret=: 4 : 0
fls=. {."1 dirtree y
res=. ''
if. x -: CRLF do.
  tofret=. toCRLF
else.
  tofret=. toJ
end.
for_f. fls do.
  dat=. 1!:1 f
  if. 2 = 3!:0 dat do.
    fix=. tofret dat
    if. -. fix -: dat do.
      fix 1!:2 f
      res=. res,f
    end.
  end.
end.
if. #res do.
  }. ; LF ,each (#y) }. each res
else.
  empty''
end.
)

fixfretCRLF=: CRLF & fixfret
fixfretLF=: LF & fixfret
getdepth=: 3 : 0
+/ PID = PATHSEP
)
getmaxdepth=: 3 : 0
if. 0 = #PROJECTFILE do. 0 return. end.
path=. getpidpath (PID i. PATHSEP) {. PID
0 >. <: +/ PATHSEP = path drophead PROJECTFILE
)
getpidpath=: 3 : 0
pid=. y
ind=. pid i. PATHSEP
ndx=. ({."1 UserFolders) bcfind <ind {. pid
if. ndx ~: _1 do.
  t=. (> 1 { ndx{UserFolders),ind }. pid
else.
  t=. pid
end.
fullname addfret t
)
projgetfiles=: 3 : 0
p=. addfret y
files=. projtree p
sort filecase each files
)
projinit=: 3 : 0
projcfgread''
PID=: ''
if. #PROJECTFILE do.
  openprojectfile PROJECTFILE
elseif. #selproj1 XPROJECTRECENT do.
  openprojectfile 0 pick selproj1 XPROJECTRECENT
elseif. 1 do.
  setprojpathfile 0 pick {.UserFolders,a:
end.
1
)
projread=: 3 : 0
projreset''
projread1''
)
projread1=: 3 : 0
getfoldernames''
PRIMARYFILES=: loadtry PROJECTFILE
XPRIMARYFILES=: pr1 PRIMARYFILES
XWINDOWS=: pr3 WINDOWS
)

loadtry=: 3 : 0
a=. <;.2 jpathsep toJ 1!:1 ::(''"_) <y
msk=. ('NB.'-:(3&{.)@dlb)&> a
; a:-.~(-.msk)#a
)
projcopyback=: 3 : 0
getfoldernames''

PRIMARYFILES=: tr1 XPRIMARYFILES

WINDOWS=: tolist XWINDOWS

empty''
)
projsave=: 3 : 0
projcopyback''
EMPTY
)
selproj1=: (#~ ([:(<'.jproj')&=_6&{.&.>))
selproj=: (#~ ([:(<'.jproj')&=_6&{.&.>)) @: ({."1)
seldir=: #~ '-d'&-:"1 @ (1 4&{"1) @ > @ (4&{"1)
projtree=: 3 : 0
r=. ''
t=. y
ps=. PATHSEP_j_
if. #t do. t=. t, ps -. {:t end.
p=. fullname@addfret each 1 {"1 UserFolders
if. -. 1 e. p e. (# &> p) {.each <y do.
  ,<PROJECTFILE return.
end.
dirs=. <t
while. #dirs do.
  fpath=. (>{.dirs) &,
  dirs=. }. dirs
  dat=. 1!:0 fpath '*'
  if. #dat do.
    drs=. seldir dat
    if. #drs do.
      dirs=. (fpath @ (,&ps) each {."1 drs),dirs
    end.
    r=. r, fpath each selproj dat
  end.
end.
sort filecase each r
)
setpidtree=: 3 : 0
if. (-. PATHSEP e. PID) +. 2 >: +/ PATHSEP=getpidpath PID do.
  res=. {."1 getpmfolders UserFolders
else.
  pid=. (PID i: PATHSEP) {. PID
  path=. (1 + (}:PIDPATH) i: PATHSEP) {. PIDPATH
  a=. (#path) }. each projgetfiles path
  res=. (pid,PATHSEP)&, each ~. (a i.&> PATHSEP) {. each a
end.
if. -. ifuserfolder PID do.
  res=. (<PIDPATH),res
end.

PIDTREE=: res
)
setprojfile=: 3 : 0
if. #y do.
  p=. y
else.
  p=. 0 pick PJFILES,a:
end.
PROJECTFILE=: fullname p
PROJECTPATH=: 0 pick pathname PROJECTFILE
CURRENTPATH=: PROJECTPATH
)
setprojpath=: 3 : 0
projreset''
PID=: y
PIDPATH=: getpidpath PID
setpidtree''
PJFILES=: fullproject each projgetfiles PIDPATH
projsetlookin''
)
setprojpathfile=: 3 : 0
setprojpath y
if. -. (<PROJECTFILE) e. PJFILES do.
  PROJECTFILE=: fromfoldername1 0 pick PJFILES,a:
  PROJECTPATH=: 0 pick pathname PROJECTFILE
  if. #PROJECTFILE do.
    openprojectfile PROJECTFILE
  end.
end.
)
fromfoldername=: 3 : 0
nms=. boxxopen y
ind=. I. '~' = ({. @ (,&' ')) &> nms
new=. }. each ind { nms
ndx=. <./ @ (i.&'/\') &> new
tag=. ndx {. each new
par=. '.' = {. &> tag
len=. ('.'&= i. 0:) &> tag
tag=. len }. each tag
inx=. PPIDS i. tag
msk=. inx < # PPIDS
hdr=. (msk # inx) { PPATHS
if. 1 e. msk # par do.
  sel=. I. msk # par
  shd=. sel { hdr
  f=. #@] | ([: +/\. ] e. '/\'"_) i: [
  top=. (sel { len) f each shd
  shd=. top {. each shd
  hdr=. shd sel } hdr
end.
new=. hdr ,each msk # ndx }. each new
nms=. new (msk # ind) } nms
jpathsep each nms
)
fromfoldername1=: 3 : 0
nam=. , > y
if. '~' = {. nam do.
  ind=. <./ nam i. '/\'
  tag=. }. ind {. nam
  par=. '.' = {. tag
  if. par do.
    len=. ('.' = tag) i. 0
    tag=. len }. tag
  end.
  ndx=. PPIDS i. <tag
  if. ndx < # PPIDS do.
    bal=. ind }. nam
    pfx=. ndx pick PPATHS
    if. par do.
      pfx=. ((#pfx) | (+/\. pfx e. '/\') i: len) {. pfx
    end.
    nam=. pfx,bal
  end.
end.
jpathsep nam
)
getfoldernames=: 3 : 0
folders=. SystemFolders,UserFolders
PPIDS=: {."1 folders
PPATHS=: jpath@filecase each 1 {"1 folders
)
tofoldername1=: 3 : 0
nam=. y
if. '~' = {. nam,'~' do. return. end.

nam=. filecase nam

msk=. 1
pps=. msk # PPATHS ,each PATHSEP
pds=. msk # PPIDS
len=. # &> pps
msk=. pps = len {. each <nam
if. 1 e. msk do.
  ndx=. ((i. >./) msk # len) { I. msk
  '~', (> ndx { pds),(<: ndx { len) }. nam return.
end.

if. -. ifuserfolder PID do. nam return. end.
pid=. PIDPATH
msk=. pid = (#pid) {. nam
ndx=. msk i. 0
if. ndx <: 1 do. nam return. end.
if. 1 >: +/ PATHSEP = ndx {. pid do. nam return. end.

cnt=. (+/ PATHSEP = ndx }. pid) - getdepth''
if. cnt < 1 do. nam return. end.

'~', (cnt # '.'), PID, (<:ndx) }. nam
)
jflin=: 4 : 0
x=. boxxopen x
y=. a: -.~ boxxopen y
(fromfoldername x) e. fromfoldername y
)
jflminus=: 4 : 0
x=. boxxopen x
y=. a: -.~ boxxopen y
(-. (fromfoldername x) e. fromfoldername y) # x
)
gitcheck=: 3 : 0
0 < # 0 pick gitreadstatus''
)
gitgui=: 3 : 0
if. 0 = #PROJECTPATH do. 0 return. end.
0 0$gitshell 'git gui &'
)
gitreadstatus=: 3 : 0
if. IFUNIX *: 0 < #PROJECTPATH do. '';'' return. end.
gitshell 'git status'
)
gitshell=: 3 : 0
unixshell 'cd "',(dquote jpath delfret PROJECTPATH),'"',LF,y
)
gitstatus=: 3 : 0
'Git Status' wdview 0 pick gitreadstatus ''
)
CFGHDR=: ; < @ ('NB. '&,) ;.2 (0 : 0)
Projects configuration

defines:
PMSNAPS           snapshots
PMSNAPX           snapshot exclusion list
PROJECTLOOKIN     last project "look in"
PROJECTRECENT     recent project loads
)
projsplit=: 3 : 0
if. 0 < L. y do. y return. end.
if. 0=#y do. '';'' return. end.
dat=. <;._2 y
g=. i.&' '
h=. g (toblank@{. ; deb@}.) ]
h &> dat
)
projcfgread=: 3 : 0
PMSNAPS=: 0
PMSNAPX=: ''
PROJECTLOOKIN=: ''
PROJECTRECENT=: ''
try. 0!:0 <PROJECTCFG catch. end.
XPROJECTRECENT=: fexists fullproject each cutopen PROJECTRECENT
XPROJECTLOOKIN=: fullname PROJECTLOOKIN
)
projcfgsave=: 3 : 0
if. -. SAVECFG do. 0 return. end.
PROJECTRECENT=: tolist extnone each XPROJECTRECENT
PROJECTLOOKIN=: extnone XPROJECTLOOKIN
dat=. CFGHDR
dat=. dat,LF,nounrep 'PMSNAPS'
dat=. dat,LF,nounrep 'PMSNAPX'
dat=. dat,LF,nounrep 'PROJECTLOOKIN'
dat=. dat,LF,nounrep 'PROJECTRECENT'
dat flwritesnew PROJECTCFG
)
projaddrecent=: 3 : 0
if. -. (<PROJECTFILE) -: {.1{.XPROJECTRECENT do.
  XPROJECTRECENT=: ({.~ MAXRECENT"_ <. #) ~. (<PROJECTFILE),XPROJECTRECENT
  projcfgsave''
end.
)
projsetlookin=: 3 : 0
if. -. PIDPATH -: XPROJECTLOOKIN do.
  XPROJECTLOOKIN=: PIDPATH
  projcfgsave''
end.
)
RECENT=: 0 : 0
pc6j precent nomin owner;pn "Recent Projects";
xywh 4 8 51 10;cc s0 static;cn "Project Files:";
xywh 3 18 174 123;cc l0 listbox ws_vscroll rightmove bottommove;
xywh 95 5 40 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 136 5 40 12;cc ok button bs_defpushbutton leftmove rightmove;cn "OK";
pas 2 2;pcenter;
rem form end;
)
precent_run=: 3 : 0

if. 0 e. #XPROJECTRECENT do.
  info 'No recent project files' return.
end.

projsave 0

rp=. tofoldername extnone each XPROJECTRECENT

pos=. wd 'qformx'
wd RECENT
wdcenter pos

wd 'set l0 *', tolist rp
wd 'setselect l0 0'
wd 'setfocus l0'
wd 'pshow'
)
precent_close=: 3 : 0
wd 'pclose'
wd 'psel ',HWNDP,';pactive'
)
precent_doit=: 3 : 0
wd 'pclose'
if. #l0 do.
  wd 'psel ',HWNDP
  openprojectfile fullproject l0
  projaddrecent''
  projectform_show''
end.
wd 'psel ',HWNDP,';pactive'
)
precent_enter=: precent_ok_button=: precent_l0_button=: precent_doit
precent_cancel=: precent_cancel_button=: precent_close
plast_run=: 3 : 0
j=. selproj1 XPROJECTRECENT -. < PROJECTFILE
if. 0 e. #j do.
  info 'No recent project files' return.
end.
projsave 0
openprojectfile >{.j
projaddrecent''
projectform_show''
)
loadproject=: 4 : 0
f=. jpath extjproj y
if. 0=fexist f do.
  info 'not found: ',f return.
end.
setprojfile fullname f
)
runproject=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
runproject1 0
)
runproject1=: 3 : 0
projaddrecent''
saveopenwindows''
projsave 0
f=. PROJECTPATH,'build.ijs'
if. fexist f do.
  load f
end.
f=. PROJECTPATH,'run.ijs'
if. 0=fexist f do.
  info 'not found: ',f return.
else.
  runimmx0 '0!:0 <''',f,''''
end.
)
buildproject=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
saveopenwindows''
projsave 0
f=. PROJECTPATH,'build.ijs'
if. 0=fexist f do.
  info 'not found: ',f return.
else.
  load f
end.
)
runtest=: 3 : 0
f=. PROJECTPATH,'build.ijs'
if. fexist f do.
  load f
end.
stk=. 13!:13''
if. # stk do.
  nms=. ;: 'runtest projectform_runtest_button wdhandler_jnproject_'
  if. -. nms -: {."1 stk do.
    smoutput 'Stack cleared - run Test again'
    jdb_close_jdebug_ :: ] ''
    return.
  end.
end.
13!:0 [ 13!:17 ''
f=. PROJECTPATH, 'test.ijs'
if. 0=fexist f do. info 'Not found: ',LF,LF,f return. end.
saveopenwindows''
runimmx0 '0!:0 <''',f,''''
)
SFILES=: 0 : 0
pc6j sfiles;
xywh 3 3 55 11;cc s0 static;cn "Source:";
xywh 2 15 148 147;cc filelist listbox ws_vscroll lbs_extendedsel rightmove bottommove;
xywh 154 11 38 12;cc open button leftmove rightmove;cn "&Open";
xywh 154 146 38 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
pas 0 0;
rem form end;
)
sfiles_run=: 3 : 0
wd SFILES
wd 'pshow;'
)
sfiles_cancel_button=: closeproject
sfiles_show=: 3 : 0
wd 'psel ',HWNDP
if. 0=#PROJECTFILE do.
  wd 'set filelist *' return.
else.
  PRIMARYFILES=: loadtry PROJECTFILE
  XPRIMARYFILES=: pr1 PRIMARYFILES
  wd 'set filelist *', jpathsep getfilelist''
  wd 'setshow filelist 0;setshow filelist 1'
end.
)


sfiles_filelist_button=: popenfiles
sfiles_open_button=: popenfiles
getfilelist=: 3 : 0

if. 0 = (#XPRIMARYFILES) do.
  XFILES=: ''
  return.
end.

XFILES=: XPRIMARYFILES
tolist XPRIMARYFILES
)
snapshot=: 3 : 0
if. PMSNAPS=0 do. return. end.

today=. 's', 2 }. ": <. 100 #. 3 {.6!:0''
p=. PROJECTPATH,'.snp'
if. 0 = #1!:0 p do.
  if. -. ss_makedir p do. return. end.
end.
p=. p,PATHSEP
d=. 1!:0 p,'*'
pfx=. p,today
if. 0=#d do. ss_make pfx,'001' return. end.
d=. \:~ {."1 d #~ 'd' = 4{"1 > 4{"1 d
last=. 0 pick d
iftoday=. today -: 7 {. last
if. y -: 1 do.
  if. (p,last) ss_match PROJECTPATH do.
    ss_info 'Last snapshot matches current project.' return.
  end.
  if. iftoday do.
    f=. pfx,_3 {. '00',": 1 + 0 ". _3 {. last
  else.
    f=. pfx,'001'
  end.
  ss_make f
  ss_info 'New snapshot: ',1 pick pathname f
else.
  if. iftoday do. return. end.
  if. (p,last) ss_match PROJECTPATH do. return. end.
  ss_make pfx,'001'
end.
d=. (PMSNAPS-1) }. d
for_s. d do.
  f=. p,(>s),PATHSEP
  1!:55 f&, each {."1 [ 1!:0 f,'*'
  1!:55 <f
end.
)
snapview=: 3 : 0
require 'ide/jnet/util/dirmatch'
PJPROJ_jdirmatch_=: ''
dmrun_jdirmatch_ 1 1
)
ss_files=: 3 : 0
t=. 1!:0 y,'*'
if. 0=#t do. return. end.
att=. > 4{"1 t
msk=. ('h' = 1{"1 att) +: 'd' = 4{"1 att
t=. /:~ msk # t
if. #PMSNAPX do.
  t #~ -. +./ PMSNAPX (1: e. E.) &>/ {."1 t
end.
)
ss_info=: wdinfo @ ('Snapshot'&;)
ss_make=: 3 : 0
fm=. PROJECTPATH
to=. y,PATHSEP
if. 0 -: 1!:5 :: 0: <to do.
  ss_info 'Unable to create snapshot directory.'
  0 return.
end.
f=. {."1 ss_files fm
fm=. (<fm) ,each f
to=. (<to) ,each f
res=. snapfilecopy"1 fm ,. to
if. 0 e. res do.
  txt=. 'Unable to copy:',LF,LF,tolist (res=0)#fm
  ss_info txt
end.
)
ss_makedir=: 3 : 0
if. 0 -: 1!:5 :: 0: <y do.
  ss_info 'Unable to create snapshot directory.'
  0 return.
end.
arw=. 'rw' 0 1 } 1!:7 <y
if. 0 -: arw 1!:7 :: 0: <y do.
  ss_info 'Unable to set read/write attributes for snapshot directory.'
  0 return.
end.
if. -.IFUNIX do.
  ph=. 'h' 1 } 1!:6 <y
  if. 0 -: ph 1!:6 :: 0: <y do.
    ss_info 'Unable to set hidden attribute for snapshot directory.'
  end.
end.
1
)
ss_match=: 4 : 0
x=. addfret x
y=. addfret y
a=. ss_files x
b=. ss_files y
ra=. #a
rb=. #b
if. 0 e. ra,rb do.
  ra = rb return.
end.
fa=. {."1 a
fb=. {."1 b
if. -. fa -: fb do. 0 return. end.
if. -. (2 {"1 a) -: (2 {"1 b) do. 0 return. end.
fx=. x&, each fa
fy=. y&, each fa
(<@(1!:1) fy) -: <@(1!:1) fx
)
ss_list=: 3 : 0
if. isempty y do.
  p=. PROJECTPATH
else.
  p=. 0 pick pathname y
end.
d=. 1!:0 p,'.snp',PATHSEP_j_,'*'
if. #d do.
  d=. d #~ 'd' = 4 {"1 > 4 {"1 d
  \:~ {."1 d
else.
  ''
end.
)
SVNHWNDP=: ''
SVNPATH=: ''
SVNPATHX=: ''
SVNS0=: <;._2 (0 : 0)
add file to SVN
delete
do nothing
)
SVNS1=: <;._2 (0 : 0)
remove from SVN
revert to SVN
do nothing
)
SVNS2=: <;._2 (0 : 0)
do nothing
revert to SVN
)

SVNS=: SVNS0;SVNS1;<SVNS2
PSVN=: 0 : 0
pc6j psvn;pn "Subversion Status";
menupop "&File";
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Tools";
menu bviewinfo "&SVN info" "" "" "";
menusep;
menu brefresh "&Refresh Display" "" "" "";
menupopz;
xywh 6 5 355 41;cc g0 groupbox rightmove;cn "Path";
xywh 13 16 136 11;cc s0 static;cn "Path to files shown:";
xywh 12 29 265 100;cc cpath combodrop rightmove;
xywh 289 15 60 12;cc bproject button leftmove rightmove;cn "Project";
xywh 289 29 60 12;cc broot button leftmove rightmove;cn "Root";
xywh 6 52 355 119;cc g1 groupbox rightmove bottommove;cn "Status/Action";
xywh 12 64 265 100;cc sgrid isigraph rightmove bottommove;
xywh 284 60 71 45;cc g2 groupbox leftmove rightmove;cn "Set Actions";
xywh 289 73 60 12;cc bsetdef button leftmove rightmove;cn "Defaults";
xywh 289 87 60 12;cc bsetdon button leftmove rightmove;cn "Do Nothing";
xywh 289 109 60 12;cc bapply button leftmove rightmove;cn "Apply";
xywh 289 123 60 12;cc bview button leftmove rightmove;cn "View";
xywh 289 136 60 12;cc bdiff button leftmove rightmove;cn "Compare";
xywh 289 150 60 12;cc bdiffall button leftmove rightmove;cn "Compare All";
xywh 6 177 355 41;cc g3 groupbox topmove rightmove bottommove;cn "SVN Commit";
xywh 13 188 136 11;cc s1 static topmove rightmove bottommove;cn "Commit Message:";
xywh 12 200 265 12;cc ecommit edit topmove rightmove bottommove;
xywh 289 200 60 12;cc bcommit button leftmove topmove rightmove bottommove;cn "Commit";
pas 6 4;pcenter;
rem form end;
)
psvn_run=: 3 : 0
wd PSVN
SVNHWNDP=: wd 'qhwndp'
wd 'set ecommit commit'
sgrid=: '' conew 'jzgrid'
cellcolors=. CELLCOLORS__sgrid
cellcolors=. 248 (<0;3 4 5) } cellcolors
cellalign=. 0
celledit=. 0
cellitems=. SVNS
colminwidth=. 50 200 100
colscale=. 1 4 1
gridid=. 'sgrid'
gridmargin=. 4 4 1 0
gridrowmode=: 1
hdrcol=. 'Status';'File';'Action'
hdrcolalign=. 0
j=. 'cellalign cellcolors celledit cellitems colminwidth colscale'
unpack__sgrid pkg j,' gridid gridmargin gridrowmode hdrcol hdrcolalign'
psvn_show y
wd 'pshow'
)
psvn_apply1=: 3 : 0
'st fl act'=. y
select. act
case. 'add file to SVN' do.
  'svn add ',dquote fl
case. 'delete' do.
  (IFUNIX pick 'del ';'rm '),dquote fl
case. 'remove from SVN' do.
  'svn rm ',dquote fl
case. 'revert to SVN' do.
  'svn revert ',dquote fl
case. do.
  ''
end.
)
psvn_bapply_button=: 3 : 0
dat=. CELLDATA__sgrid
p=. jpath delfret SVNPATH
cmd=. ''
for_d. dat do.
  cmd=. cmd, <psvn_apply1 d
end.
cmd=. cmd -. a:
cmd=. ; cmd ,each LF
batchcmd p;cmd
psvn_refresh ''
)
psvn_bcommit_button=: svncommit
psvn_bdiff_button=: 3 : 0
sel=. psvn_getselect''
if. 0 = #sel do. return. end.
'st fl'=. sel
if. 'M' ~: {.st do.
  info 'Compare should be done on modified files.' return.
end.
wdview psvn_diff1 fl
)
psvn_bdiffall_button=: 3 : 0
dat=. CELLDATA__sgrid
msk=. 'M' = {.&> {."1 dat
if. -. 1 e. msk do.
  info 'No modified files to compare.' return.
end.
fls=. SVNPATH&, each msk # 1 {"1 dat
res=. psvn_diff1 each fls
wdview _2 }. ; res ,each <LF,LF
)
psvn_bproject_button=: 3 : 0
psvn_refresh SVNPATH=: > {. SVNPATHX
)
psvn_broot_button=: 3 : 0
psvn_refresh SVNPATH=: > {: SVNPATHX
)
psvn_bsetdef_button=: 3 : 0
dat=. CELLDATA__sgrid
ind=. '?!' i. {. &> {."1 dat
dat=. (}:"1 dat),.ind { {. &> SVNS
show__sgrid ,:'celldata';<dat
)
psvn_bsetdon_button=: 3 : 0
dat=. CELLDATA__sgrid
dat=. (}:"1 dat),.<'do nothing'
show__sgrid ,:'celldata';<dat
)
psvn_bview_button=: 3 : 0
sel=. psvn_getselect''
if. 0 = #sel do. return. end.
'st fl'=. sel
if. '!' = {.st do.
  (fl,' - from svn') wdview freads psvn_svnfile fl
else.
  fl wdview freads jpath fl
end.
)
psvn_bviewinfo_button=: 3 : 0
wdview shellcmd 'svn info ',dquote jpath delfret SVNPATH
)
psvn_close=: 3 : 0
if. #sgrid do.
  destroy__sgrid''
end.
wd 'psel ',SVNHWNDP
wd 'pclose'
SVNHWNDP=: sgrid=: ''
)
psvn_cpath_button=: 3 : 0
psvn_refresh SVNPATH=: addfret cpath
)
psvn_diff1=: 3 : 0
fl=. y
sf=. psvn_svnfile fl
new=. freads jpath fl
old=. freads sf
'compare svn:',LF,fl,LF,old compare new
)
psvn_getselect=: 3 : 0
mark=. CELLMARK__sgrid
if. 0 = #mark do.
  info 'First select a file.'
  '' return.
end.
'st fl j'=. ({.mark) { CELLDATA__sgrid
st;SVNPATH,fl
)
psvn_refresh=: 3 : 0
psvn_show svnreadstatus SVNPATH
)
psvn_show=: 3 : 0
if. #y do.
  SVNNDX=: '?!' i. {.&> {."1 y
  celltype=. 0 0 ,"1 0 [ 200 + SVNNDX
  celldata=. y ,. SVNNDX { {.&> SVNS
else.
  SVNNDX=: i.0
  celltype=. 0 0 0
  celldata=. 0 3$<''
end.
show__sgrid pkg 'celldata celltype'
wd 'set cpath *',tolist SVNPATHX
wd 'setselect cpath ',":SVNPATHX i. <SVNPATH
wd 'setenable bproject ',": -. SVNPATH -: > {.SVNPATHX
wd 'setenable broot ',": -. SVNPATH -: > {: SVNPATHX
)
psvn_svnfile=: 3 : 0
'p f'=. pathname jpath y
p=. p,'.svn/text-base/'
f=. f,'.svn-base'
jpathsep p,f
)
psvn_cancel=: psvn_cancel_button=: psvn_close
psvn_exit_button=: psvn_close
psvn_ecommit_button=: psvn_bcommit_button
psvn_brefresh_button=: psvn_refresh
svncheck=: 3 : 0
if. 0 = #PROJECTPATH do. 0 return. end.
d=. 1!:0 PROJECTPATH,'.svn'
if. 0 = #d do. 0 return. end.
'd'=4{>(<0;4){d
)
svncheckmsg=: 3 : 0
if. svncheck'' do. 1 return. end.
info 'This project is not stored in Subversion'
0
)
svncommit=: 3 : 0
if. 0=#ecommit do.
  info 'First enter a commit message.' return.
end.
msg=. (1 + ecommit='"') # ecommit
smoutput shellcmd 'svn commit -m "',msg,'" ',dquote jpath delfret SVNPATH
psvn_refresh ''
)
svnreadpaths=: 3 : 0
r=. ''
p=. jpath delfret y
f=. shellcmd :: 0:
while.
  a=. f 'svn info ',dquote p
  1 < +/a = LF do.
  r=. r,<p,PATHSEP
  if. -. PATHSEP e. p do. break. end.
  p=. (p i: PATHSEP) {. p
end.
if. 0 = #r do.
  msg=. 'There is no result from svn info.',LF,LF
  info msg,'Please ensure that svn is installed and on the path.'
  ''
else.
  tofoldername1 each r
end.
)
svnreadstatus=: 3 : 0
p=. dquote jpath delfret y
a=. shellcmd 'svn status ',p
if. 0 = #a do. return. end.
a=. <;._2 toJ a
s=. 6 {.each a
f=. (6+#p) }.each a
msk=. (_5 {.!.PATHSEP each f) ~: <PATHSEP,'.snp'
msk=. msk *. 0 < # &> f
s=. msk#s
f=. msk#f
(s,.f) /: f
)
svnstatus=: 3 : 0
if. -. svncheckmsg'' do. return. end.
SVNPATH=: tofoldername1 PROJECTPATH
SVNPATHX=: svnreadpaths SVNPATH
if. 0 = #SVNPATHX do. return. end.
psvn_run svnreadstatus SVNPATH
)
svnview=: 3 : 0
if. -. svncheckmsg'' do. return. end.
require 'ide/jnet/util/dirmatch'
PJPROJ_jdirmatch_=: ''
dmrun_jdirmatch_ 2 1
)
psvn_cpath_select=: psvn_cpath_button
TEMPLATETEST=: 0 : 0
buildproject_jnproject_ ''
loadtarget_jnproject_ ''
loadscript_jnproject_ 'test0.ijs'
)
templateijs=: 4 : 0
('NB. ',x,LF) fwrites y,x,'.ijs'
)
template1=: 3 : 0
p=. jpath y
y=. tofoldername1 y
f=. ;: 'build init main run test test0'
f templateijs each <p
(LF,TEMPLATETEST) fappends p,'test.ijs'
(LF,'smoutput ''test0'',LF') fappends p,'test0.ijs'
projsave 0
showfiles''
)
tagparen=: ' ('&, @ (,&')') @ ":
getprojdirfiles=: 3 : 0
p=. PROJECTPATH
t=. 1!:0 p,'*'
t=. t #~ 'd'~: 4{ &> 4{"1 t
p&, each {."1 t
)
globalassigns=: 3 : 0
rx=. '([[:alpha:]][[:alnum:]_]*|x\.|y\.|m\.|n\.|u\.|v\.) *=:'
/:~ (-.&' ') @ (_2&}.) each rx rxall y
)
prettyprint=: 3 : 0
if. 0=#f=. getselectfiles'' do. return. end.
saveopenwindows''
load PPSCRIPT
r=. pp_jpp_ f
if. r -: _1 do. return. end.
b=. r > 0
if. 1 e. b do.
  txt=. 'Changed:',LF,tolist b#f
else.
  txt=. 'No change'
end.
info txt
)
showassignments=: 3 : 0
if. 0=#f=. getselectfiles'' do. return. end.
saveopenwindows''
showassignments1 f
)
showassignments1=: 3 : 0
f=. y
none=. <,<'{none}'
fls=. 'In file: '&, each f
nms=. globalassigns @ fread each f
if. 1 < #f do.
  all=. sort ; ~. each nms
  nub=. ~. all
  cnt=. #/.~ all
  if. 2 < #f do.
    fls=. fls,~<'In more than one file:'
    nms=. nms ,~ <((cnt<#f) *. cnt>1)#nub
  end.
  fls=. fls,~<'In every file:'
  nms=. nms ,~ <(cnt=#f)#nub
end.
fls=. (, @ (,.&LF) @ (,:&'-')) each fls
nms=. tagcount each nms
nms=. none (I. 0=# &> nms)} nms
nms=. , @ (,.&LF) @: > each nms
'Global Assignments' wdview tolist fls ,each nms
)
tagcount=: 3 : 0
cnt=. #/.~ y
nms=. ~. y
if. 1 e. b=. cnt > 1 do.
  tag=. tagparen each b#cnt
  tag=. (b#nms) ,each tag
  tag (I. b)} nms
end.
)
allwindows=: 3 : 0
<;._2 qsmallijs''
)
openwindow=: 3 : 0
'name pos'=. ';' cutopen y
open name
smmove pos
)
windows_close=: 3 : 0
for_f. qsmallijs'' do.
  smsel f
  smsave ''
  smclose ''
end.
wd 'psel ',HWNDP,';pactive'
)
windows_open=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
if. 0=#XWINDOWS do.
  info 'no windows to open' return.
end.
openwindow each XWINDOWS
wd 'psel ',HWNDP,';pactive'
)
windows_save=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
f=. qsmallijs''
if. 0=#f do.
  WINDOWS=: XWINDOWS=: ''
else.
  qsize=. ';'&, @ ": @ qsmsize @ smsel
  XWINDOWS=: (id2names f) ,each qsize each f
  WINDOWS=: tolist XWINDOWS
end.
projsave 0
if. (<PROJECTFILE) e. allwindows'' do.
  smsel PROJECTFILE
  smwrite freads PROJECTFILE
end.
)
TABGROUPS=: ;: 'bfiles sfiles'
PTOP=: 0
PROJECTFORM=: 0 : 0
pc6j projectform;pn "Project Manager";
menupop "&File";
menu pnew "&New..." "" "" "";
menu popen "&Open..." "" "" "";
menusep;
menu plast "&Last" "Ctrl+L" "" "";
menu precent "&Recent..." "" "" "";
menusep;
menu refresh "Re&fresh Tabs" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Options";
menu ptop "Topmost window" "Ctrl+T" "" "";
menusep;
menu configure "Confi&gure..." "" "" "";
menupopz;
menupop "&Tools";
menu ass "&Global Assignments in File" "" "" "";
menusep;
menu pp "&Format Script" "" "" "";
menusep;
menu snapview "&Compare Snapshots..." "" "" "";
menu snapmake "&Make Snapshot" "" "" "";
menusep;
menu gitgui "&Git Gui" "" "" "";
menu gitstatus "&Git Status" "" "" "";
menu svnview "&Compare SVN..." "" "" "";
menu svnstatus "&Status SVN..." "" "" "";
menupopz;
menupop "&Windows";
menu closewin "&Close Windows" "" "" "";
menusep;
menu openwin "&Open Windows" "" "" "";
menusep;
menu savewin "&Save Windows" "" "" "";
menupopz;
menupop "&Help";
menu helpover "&Overview" "" "" "";
menupopz;
xywh 2 5 30 11;cc s0 static;cn "Pro&ject:";
xywh 33 4 104 260;cc projectfile combodrop ws_vscroll rightmove;
xywh 2 20 30 11;cc s1 static;cn "Look &In:";
xywh 33 19 104 260;cc projectpath combodrop ws_vscroll rightmove;
xywh 140 21 7 10;cc selectpathup button leftmove rightmove;cn "<";
xywh 147 21 7 10;cc selectpathdown button leftmove rightmove;cn ">";
xywh 0 35 198 1;cc s2 staticbox ss_etchedhorz rightmove;
xywh 2 44 198 184;cc tabs tab rightmove bottommove;
xywh 158 4 38 12;cc load button leftmove rightmove;cn "&Run";
xywh 158 18 38 12;cc build button leftmove rightmove;cn "&Build";
xywh 158 32 38 12;cc runtest button leftmove rightmove;cn "&Test";
pas 0 2;pcenter;
rem form end;
)
projectform_run=: 3 : 0
getfoldernames''
if. wdisparent 'projectform' do.
  wd 'psel projectform;pshow;pactive' return.
end.
TABNDX=: 0
TXFILES=: i.0 2
wd PROJECTFORM
HWNDP=: wd 'qhwndp'
wd 'set tabs "Files" "Source"'
wd 'creategroup tabs'
bfiles_run''
sfiles_run''
wd 'creategroup'
projinit''
projectform_show''
wd 'setenable snapmake ',": 0 < PMSNAPS
wd 'setenable snapview ',": 0 < PMSNAPS
wd 'setshow bfiles 1'
wd 'setfocus load'
wd 'set ptop ',":PTOP
wpset 'projectform'
wd 'pshow;'
)
projectform_helpover_button=: 3 : 0
htmlhelp602 'user/projects.htm'
)
projectform_projectfile_select=: 3 : 0
if. #projectfile_select do.
  j=. (".projectfile_select) pick PJFNDX { PJFILES
  if. j -: PROJECTFILE do. return. end.
  projsave 0
  projectform_load j
  projaddrecent''
end.
)
projectform_projectpath_select=: 3 : 0
if. projectpath -: PID do. return. end.
projsave 0
setprojpathfile projectpath
projectform_load PROJECTFILE
)
projectform_selectpath=: 3 : 0
dep=. getdepth''
if. y = 1 do.
  max=. getmaxdepth''
  if. dep = max do. return. end.
  changedepth 1
else.
  if. dep = 0 do. return. end.
  changedepth _1
end.
showproject''
)

projectform_selectpathdown_button=: projectform_selectpath bind 1
projectform_selectpathup_button=: projectform_selectpath bind 0
projectform_tabs_button=: 3 : 0
new=. ".tabs_select
wd 'setshow ',(>TABNDX{TABGROUPS),' 0'
TABNDX=: new
wd 'setshow ',(>TABNDX{TABGROUPS),' 1'
)
projectform_ptop_button=: 3 : 0
PTOP=: -. PTOP
wd 'set ptop ',":PTOP
wd 'ptop ',":PTOP
)
projectform_enter=: ]
projectform_cancel=: projectform_close=: closeproject
projectform_ass_button=: showassignments
projectform_closewin_button=: windows_close
projectform_configure_button=: cfg_run
projectform_exit_button=: projectform_close
projectform_gitgui_button=: gitgui
projectform_gitstatus_button=: gitstatus
projectform_load_button=: runproject
projectform_build_button=: buildapp
projectform_openwin_button=: windows_open
projectform_plast_button=: plast_run
projectform_pnew_button=: opennewproject
projectform_popen_button=: openoldproject
projectform_pp_button=: prettyprint
projectform_precent_button=: precent_run
projectform_projectfile_button=: projectform_projectfile_select
projectform_projectpath_button=: projectform_projectpath_select
projectform_refresh_button=: showfiles
projectform_runtest_button=: runtest
projectform_savewin_button=: windows_save
projectform_snapmake_button=: snapshot bind 1
projectform_snapview_button=: snapview
projectform_svnstatus_button=: svnstatus
projectform_svnview_button=: svnview

projectform_dctrl_fkey=: editinputlog
projectform_fctrl_fkey=: editfind
projectform_fctrlshift_fkey=: fif
projectform_lctrl_fkey=: projectform_plast_button
projectform_load=: 3 : 0
projreset''
if. #y do.
  setprojfile y
else.
  setprojfile 0 pick PJFILES,a:
end.
if. #PROJECTFILE do.
  projread ''
  snapshot''
end.
projectform_show''
)
projectform_show=: 3 : 0
wd 'psel ',HWNDP
showproject''
showfiles''
wd 'setshow ',(0 pick TABGROUPS),' ',":0=TABNDX
wd 'setshow ',(1 pick TABGROUPS),' ',":1=TABNDX
wd 'setselect tabs ',":TABNDX
snap=. ": 0 < PMSNAPS
git=. ": gitcheck''
svn=. ": svncheck''
wd 'setenable snapview ',snap
wd 'setenable snapmake ',snap
wd 'setenable gitgui ',git
wd 'setenable gitstatus ',git
wd 'setenable svnview ',svn
wd 'setenable svnstatus ',svn
wd 'setshow gitgui ',git
wd 'setshow gitstatus ',git
wd 'setshow svnview ',svn
wd 'setshow svnstatus ',svn
wd :: [ 'psel projpath;pclose'
wd 'psel ',HWNDP,';pactive'
wd 'setfocus load'
)
showfiles=: 3 : 0
CURRENTPATH=: PROJECTPATH
sfiles_show @ bfiles_show ''
wd 'setshow ',(0 pick TABGROUPS),' ',":0=TABNDX
wd 'setshow ',(1 pick TABGROUPS),' ',":1=TABNDX
wd 'setselect tabs ',":TABNDX
)

projectmanager=: projectform_run
showproject=: 3 : 0
if. #PJFILES do.
  nms=. pidname each PJFILES
  PJFNDX=: /: nms
  wd 'set projectfile *', tolist PJFNDX { nms
  wd 'setselect projectfile ',": (PJFNDX { PJFILES) bcfind <PROJECTFILE
  wd 'setenable projectfile 1'
else.
  PJFNDX=: ''
  wd 'set projectfile *'
  wd 'setenable projectfile 0'
end.
if. #PIDTREE do.
  wd 'set projectpath *', tolist PIDTREE
  wd 'setselect projectpath ',": 0 >. PIDTREE bcfind <PID
else.
  wd 'set projectpath *'
end.
)
