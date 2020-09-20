require 'project'

coclass 'jproject'
IgnoreLibs=: <;._1 ' conlib winlib colib compare convert coutil dates dir dll files libpath strings text'

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
STDLIBS=: 'stdlib';'winlib'
STDLIBS=: ~. STDLIBS, <;._1 ' compare convert'

DEFBUILDOPTS=: 0 1 0 0 0 0 0

PJFILES=: ''
PROJECTFILE=: ''
PROJECTPATH=: ''
PLINK=: ''
PLINKLAST=: ''
PROJECTRECENT=: ''
PROJECTLOOKIN=: ''

PID=: ''
PIDPATH=: ''
PIDTREE=: ''
PROJECTCFG=: jpath '~config/projects.ijs'
WINDOWS=: ''
PPSCRIPT=: jpath '~ide/jnet/util/pp.ijs'

XOLD=: ''
XPROJECTRECENT=: PROJECTRECENT
XPROJECTLOOKIN=: PROJECTLOOKIN
XFILES=: ''
XLIBS=: ''

j=. 'PRIMARYFILES PRIMARYLIBS DEVFILES DEVLIBS OTHERFILES'
j=. j,' TARGETFILE TARGETLOCALE TARGETHEADER TARGETEXTRA'
j=. j,' BUILDOPTS PREBUILDFILE POSTBUILDFILE TESTFILE'
PFILENAMES=: ;: j,' NOTES VERSION WINDOWS'
XPFILENAMES=: 'X' ,each PFILENAMES
j=. ;: 'BUILDOPTS NOTES VERSION'
PFILESEPS=: PFILENAMES -. j
projreset=: 3 : 0
noteedit=: ''
(PFILENAMES)=: a:
(XPFILENAMES)=: a:
BUILDOPTS=: XBUILDOPTS=: DEFBUILDOPTS
RLIBS=: _1
RFILES=: ''
)
closeproject=: 3 : 0
projsave 0
try.
  wd 'psel wnote;pclose'
catch. end.
try.
  wd 'psel ',HWNDP
  wpsave 'projectform6'
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
load PROJECTPATH_jproject_,y
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
projectform6_run''
)
opennewproject=: 3 : 0
projsave 0
while. 1 do.
  j=. '"Project Files(*.ijp)|*.ijp" ofn_nochangedir'
  f=. jpathsep mbsave '"New Project File" "',PIDPATH,'" "" ',j
  if. ''-:f do. return. end.
  f=. extijp f
  if. -. '.ijp' -: _4 {.f do.
    info 'Project filename extension should be .ijp'
  elseif. fexist f do.
    if.
      msg=. f,LF,'This file already exists.'
      msg=. msg,LF,LF,'Replace existing file?'
      0=2 1 query msg do. break.
    end.
  elseif. 1 do. break.
  end.
end.

XOLD=: ''
setprojfile f
projreset''
projsave 0
openprojectfile PROJECTFILE
projectform6_show''
projaddrecent''
)
openoldproject=: 3 : 0
projsave 0

while. 1 do.
  j=. '"Project Files(*.ijp)|*.ijp" ofn_filemustexist ofn_nochangedir'
  f=. jpathsep mbopen '"Open Project File" "',PIDPATH,'" "" ',j
  if. ''-:f do. return. end.
  f=. extijp f
  if. '.ijp' -: _4 {.f do. break. end.
  info 'Project filename extension should be .ijp'
end.

openprojectfile f
projectform6_show''
)
openprojectfile=: 3 : 0
file=. fullproject y

if. 0 = '.ijp' -: _4 {. file do.
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
1
)
getselectfiles=: 3 : 0
r=. ''
select. TABNDX
case. 0 do.
  if. #filelist_select do.
    r=. (".filelist_select) { XFILES
  end.
case. 1 do.
  if. #libto_select do.
    r=. getlibfiles (".libto_select) { XLIBS
  else.
    r=. getlibfiles cutopen libfrom
  end.
case. 2 do.
  if. #bpfiles_select do.
    r=. (".bpfiles_select) { BPFILES
  end.
case. 3 do.
  if. #spfiles_select do.
    r=. (".spfiles_select) { XOTHERFILES
  end.
end.
if. 0 = #r do. infonosel'' return. end.
r=. fromfoldername r
if. 0 e. b=. fexist &> r do.
  info 'not found:',LF,LF,tolist (b=0)#r
  '' return.
end.
)
popenfiles=: 3 : 0
if. # f=. getselectfiles '' do.
  open_j_ f
end.
projaddrecent''
)
revfix=: 3 : 0
1 100 1000 #. 3 {. 0 ". ' ' (I. y='.') } y
)
revfmt=: 3 : 0
if. y do.
  ('';'r<.000>3.0';'r<.00>4.0') 8!:2 [0 100 1000 #: y
else.
  ''
end.
)
saveproject=: 3 : 0
openp y
r=. buildproject ''
if. r=0 do.
  wdinfo 'saveproject';'problem with: ',y
else.
  empty''
end.
)
sprintfiles=: 3 : 0
if. # f=. getselectfiles '' do.
  sprintfile each f
end.
projaddrecent''
)
sprintfile=: 3 : 0
if. fexist y do. printfiles y
else. info 'Could not open file: ',y
end.
)
viewfile=: 3 : 0
if. # f=. getselectfiles '' do.
  f=. >{.f
  try.
    f wdview 1!:1 <f
  catch.
  end.
  wd 'psel ',HWNDP,';pactive'
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
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
delstring=: 4 : ';(x E.r) <@((#x)&}.) ;.1 r=. x,y'
do=: ".
drophead=: ] }.~ #@[ * [ -: &: filecase #@[ {. ]
dtb=: #~ [: +./\. ' '&~:
fix=: _1&".
fsep=: '/'&(I.@(=&'\')@]})
hostcmd=: [: 2!:0 '(' , ,&' || true)'
index=: #@[ (| - =) i.
info=: wdinfo @ ('J6 Project Manager'&;)
infonoproj=: info bind 'First select a project file'
infonosel=: info bind 'No file selected'
infonospec=: info bind 'No file specified'
intersect=: e. # [
isempty=: 0: e. $
matchhead=: [ -: &: filecase #@[ {. ]
pkg=: [: (, ,&< ".)&> ;:
query=: wdquery 'J6 Project Manager'&;
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
load PROJECTPATH_jproject_,y
)
loaddscript=: 3 : 0
cocurrent 'base'
loadd PROJECTPATH_jproject_,y
)
loadtryscript=: 3 : 0
try. 0!:0 <y
catch. info 'Unable to load: ',y
end.
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
BFNAMES=: ;: 'XTARGETFILE XPREBUILDFILE XPOSTBUILDFILE XTESTFILE'

BFADD=: 0 : 0
pc6j bfadd owner;pn "Add Project Script";
xywh 6 6 75 65;cc g0 groupbox;cn "Project Script";
xywh 13 18 64 11;cc btarg radiobutton;cn "Target";
xywh 13 31 64 11;cc bpre radiobutton group;cn "Pre-Build";
xywh 13 44 64 11;cc bpost radiobutton group;cn "Post-Build";
xywh 13 57 64 11;cc btest radiobutton group;cn "Test";
xywh 92 9 40 12;cc ok button;cn "OK";
xywh 92 24 40 12;cc cancel button;cn "Close";
pas 4 4;pcenter;
rem form end;
)
bfadd_run=: 3 : 0
wd BFADD
ndx=. 0 i.~ #@". &> BFNAMES
wd 'set btarg 0;set bpre 0;set bpost 0;set btest 0'
if. ndx<4 do.
  wd 'set ',(ndx pick ;: 'btarg bpre bpost btest'),' 1'
end.
wd 'pshow'
)
bfadd_ok_button=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.

ndx=. '1' i.~ btarg,bpre,bpost,btest
if. ndx=4 do.
  info 'No Project Script selected' return.
end.

iftarget=. ndx=0
extok=. (<'.ijs'),iftarget#<'.ijl'

nam=. ndx pick <;._1 ' Target Pre-Build Post-Build Test'
xnm=. ndx pick BFNAMES
xvl=. shortname1 ". xnm

p=. PROJECTPATH

while. 1 do.
  if. iftarget do.
    j=. '"Script Files(*.ijs)|*.ijs|Locked Scripts(*.ijl)|*.ijl"'
  else.
    j=. '"Script Files(*.ijs)|*.ijs"'
  end.
  j=. j,' ofn_nochangedir'
  f=. jpathsep mbsave '"',nam,' File" "',p,'" "',xvl,'" ',j
  if. ''-:f do. return. end.
  f=. extijs f
  if. (<_4 {.f) e. extok do.
    file=. <f
    if. f -: xvl do. return. end.
    if. file jflin XPRIMARYFILES, XDEVFILES do.
      info 'already in project: ',>shortname file break.
    end.

    if. #xvl do.
      if. 0 ~: 2 query 'OK to replace ',nam,' File?' do. continue. end.
    end.
    break. end.

  info 'Script filename extension should be .ijs'
  p=. fpath f
end.
if. 0=fexist file do. '' flwritesnew file end.

f=. tofoldername1 > file

". xnm,'=: f'
XOTHERFILES=: XOTHERFILES jflminus file

projsave 0
bfadd_close''
)
bfadd_close=: 3 : 0
wd 'pclose;psel projectform6;pactive'
bfiles_show''
)

bfadd_cancel_button=: bfadd_cancel=: bfadd_close
bfadd_enter=: bfadd_ok_button
BFILES=: 0 : 0
pc6j bfiles owner;
xywh 3 3 55 11;cc s0 static;cn "Project Files:";
xywh 2 15 148 147;cc bpfiles listbox ws_hscroll ws_vscroll lbs_extendedsel rightmove bottommove;
xywh 154 11 38 12;cc bopen button leftmove rightmove;cn "&Open";
xywh 154 24 38 12;cc bview button leftmove rightmove;cn "&View";
xywh 154 37 38 12;cc bprint button leftmove rightmove;cn "&Print";
xywh 154 50 38 12;cc add button leftmove rightmove;cn "&Add";
xywh 154 63 38 12;cc remove button leftmove rightmove;cn "&Remove";
xywh 154 146 38 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
pas 0 0;
rem form end;
)
bfiles_run=: 3 : 0
wd BFILES
wd 'pshow;'
)
bfiles_cancel_button=: closeproject
bfiles_show=: 3 : 0
j=. buildfiles''
k=. buildfilestag''
b=. 0 < # &> j
BPFILES=: b # j
if. 1 e. b do.
  p=. (shortname b # j) ,each b # k
  wd 'set bpfiles *',tolist p
else.
  wd 'set bpfiles'
end.
)
bfiles_add_button=: bfadd_run
bfiles_remove_button=: 3 : 0

if. 0 e. #bpfiles do. infonosel'' return. end.

files=. (".bpfiles_select) { BPFILES
files=. files -. a:

if. 1 e. files e. <PROJECTFILE
do. info 'You cannot remove the project file' return.
end.

ff=. tolist shortname files
if. 1=2 query 'OK to remove:',LF,LF,ff do. return. end.

XTARGETFILE=: ,> XTARGETFILE jflminus files
XPREBUILDFILE=: ,> XPREBUILDFILE jflminus files
XPOSTBUILDFILE=: ,> XPOSTBUILDFILE jflminus files
XTESTFILE=: ,> XTESTFILE jflminus files

projsave 0
bfiles_show''
)
bfiles_bopen_button=: popenfiles
bfiles_bview_button=: viewfile
bfiles_bprint_button=: sprintfiles
bfiles_bpfiles_button=: popenfiles
buildfiles=: 3 : 0
PROJECTFILE;XTARGETFILE;XPREBUILDFILE;XPOSTBUILDFILE;XTESTFILE
)
buildfilestag=: 3 : 0
' (project)';' (target)';' (prebuild)';' (postbuild)';' (test)'
)
BPNAMES=: 'XBUILDOPTS XTARGETEXTRA XTARGETLOCALE XTARGETHEADER'

WBUILD=: 0 : 0
pc6j wbuild owner;pn "Build Options";
xywh 5 6 166 81;cc g0 groupbox;cn "Include Files";
xywh 88 13 35 11;cc s1 static;cn "Include";
xywh 126 13 33 11;cc s2 static;cn "Require";
xywh 11 22 78 11;cc s3 static;cn "Project source:";
xywh 99 25 9 9;cc incsrc radiobutton;
xywh 135 25 9 10;cc reqsrc radiobutton group;
xywh 11 34 78 11;cc s4 static;cn "Project libraries:";
xywh 99 37 9 9;cc inclib checkbox;
xywh 135 37 9 9;cc reqlib checkbox;
xywh 11 50 84 11;cc s6 static;cn "For standalone files:";
xywh 11 60 78 11;cc s5 static;cn "Standard libraries:";
xywh 94 51 68 1;cc s7 staticbox ss_etchedhorz;
xywh 99 62 9 9;cc incstd checkbox;
xywh 135 62 9 9;cc reqstd checkbox;
xywh 11 74 156 11;cc jdll checkbox;cn "Use libraries for J DLL only";
xywh 5 96 216 120;cc g1 groupbox rightmove bottommove;cn "Build Options";
xywh 11 107 205 10;cc decom checkbox;cn "Delete comments (except header)";
xywh 11 119 205 10;cc noshow checkbox;cn "Do not show J session manager";
xywh 11 129 140 11;cc label static;cn "Header Comments:";
xywh 10 142 205 34;cc theader editm ws_vscroll rightmove bottommove;
xywh 10 184 63 12;cc s8 static topmove bottommove;cn "Load in locale: ";
xywh 75 183 141 13;cc tlocale edit ws_border es_autohscroll topmove rightmove bottommove;
xywh 11 199 63 12;cc label static topmove bottommove;cn "Append to file:";
xywh 75 198 141 13;cc textra edit ws_border es_autohscroll topmove rightmove bottommove;
xywh 178 6 44 12;cc ok button bs_defpushbutton leftmove rightmove;cn "Close";
xywh 178 22 44 12;cc buildapp button leftmove rightmove;cn "&Build Now";
xywh 178 38 44 12;cc help button leftmove rightmove;cn "&Help";
pas 3 2;pcenter;
rem form end;
)
wbuild_run=: 3 : 0
pos=. wd 'qformx'
wd WBUILD
wdcenter pos
wd 'set incsrc ',":-.0{XBUILDOPTS
wd 'set reqsrc ',":0{XBUILDOPTS
wbuildshowlib''
wbuildshowstd''
wd 'set decom ',":3{XBUILDOPTS
wd 'set jdll ',":4{XBUILDOPTS
wd 'set noshow ',":6{XBUILDOPTS
wd 'set theader *',XTARGETHEADER
wd 'set tlocale *',XTARGETLOCALE
wd 'set textra *',XTARGETEXTRA
wd 'pshow;'
)
wbuild_close=: 3 : 0
wbuild_saveok''
wbuildclose''
)
wbuildclose=: 3 : 0
wd 'psel ',HWNDP
wother_show''
wd :: [ 'psel wbuild;pclose'
wd 'psel ',HWNDP,';pactive'
)
wbuild_inclib_button=: 3 : 0
t=. #. (". inclib),". reqlib
t=. t { 2 1 0 0
XBUILDOPTS=: t 1} XBUILDOPTS
wbuildshowlib''
)
wbuild_reqlib_button=: 3 : 0
t=. #. (". inclib),". reqlib
t=. t { 2 1 0 1
XBUILDOPTS=: t 1} XBUILDOPTS
wbuildshowlib''
)
wbuild_incstd_button=: 3 : 0
t=. ". incstd
XBUILDOPTS=: t 2} XBUILDOPTS
wbuildshowstd''
)
wbuild_reqstd_button=: 3 : 0
t=. 2*". reqstd
XBUILDOPTS=: t 2} XBUILDOPTS
wbuildshowstd''
)
wbuildshowlib=: 3 : 0
t=. 1{XBUILDOPTS
wd 'set inclib ',":t=0
wd 'set reqlib ',":t=1
)
wbuildshowstd=: 3 : 0
t=. 2{XBUILDOPTS
wd 'set incstd ',":t=1
wd 'set reqstd ',":t=2
)
wbuild_help_button=: 3 : 0
htmlhelp602 'user/build_apps.htm'
)
wbuild_read=: 3 : 0
c=. (".reqsrc), (1 2{XBUILDOPTS), ". &> decom,jdll,'0',noshow
d=. textra
e=. tlocale
f=. theader
c;d;e;f
)
wbuild_saveok=: 3 : 0
old=. ".each ;: BPNAMES
new=. wbuild_read''
if. old-:new do. return. end.
j=. 'Build options have changed. Save them?'
if. 1=2 query j do. return. end.
wbuild_save''
)
wbuild_save=: 3 : 0
p=. <PROJECTPATH
TARGET_j_=: (p , <tlocale) , (p ~: {."1 TARGET) # TARGET
(BPNAMES)=: wbuild_read''
)
wbuild_cancel=: wbuild_close
wbuild_ok_button=: wbuildclose @ wbuild_save
wbuild_enter=: wbuild_ok_button
wbuild_buildapp_button=: buildapp @ wbuild_save
buildopt=: wbuild_run
buildproject=: 3 : 0
saveopenwindows''
nms=. 'IFREQSRC IFREQLIB STANDALONE IFDELCMT IFDLL j IFNOSHOW'
(nms)=: BUILDOPTS
if. 0=buildprescript'' do. return. end.
buildtarget''
buildpostscript''
)
buildapp=: 3 : 0

saveopenwindows''
getfoldernames''
projsave 0
projaddrecent''

if. 0 = (#XTARGETFILE) + (#XPREBUILDFILE) + #XPOSTBUILDFILE do.
  info 'First set target or build files in the Project tab' return.
end.

xtg=. fromfoldername1 XTARGETFILE

if. #xtg do.
  old=. (fread;fstamp) xtg
else.
  old=. _1
end.

if. 0=buildproject'' do. return. end.

if. y -: 1 do. return. end.

if. #xtg do.
  if. old -: (fread;fstamp) xtg do.
    DB=: old ; <(fread;fstamp) xtg
    info 'No change: ',xtg
  else.
    info 'Saved: ',xtg
  end.
else.
  info 'Project Built'
end.

)
buildjade=: 3 : 0
if. STANDALONE=0 do. '' return. end.
r=. 'NB. standalone defs:',LF
r=. r,'3 : 0 ''''',LF
r=. r,'if. 0 ~: 4!:0 <''PATHSEP_j_'' do.',LF
r=. r,'PATHSEP_j_=: ''/''',LF
r=. r,'jpathsep_z_=: ''/'' & (I. @ (e.&''/\'')@] })',LF
r=. r,'jpath_z_=: jpathsep',LF
r=. r,'end.',LF
r=. r,'load_z_=: require_z_=: script_z_=: ]',LF
r=. r,'IFJAVA_z_=: ''jjava''-: (11!:0) :: 0: ''qwd''',LF
r=. r,'IFJWD_z_=: 0-.@-:(11!:0) :: 0: ''qwd''',LF
r=. r,'IFJNET_z_=: (IFJNET"_)^:(0=4!:0<''IFJNET'') 0',LF
r=. r,'IFCONSOLE_z_=: IFQT < 0-:(11!:0) :: 0: ''qwd''',LF
r=. r,'0',LF,')',LF,LF
)
buildlocale=: 3 : 0
if. #XTARGETLOCALE do.
  setclass XTARGETLOCALE
elseif. (1=STANDALONE) +. (0=IFREQLIB) *. 0<#XPRIMARYLIBS do.
  setclass 'base'
elseif. 1 do. ''
end.
)
buildprescript=: 3 : 0
if. 0=#XPREBUILDFILE do. 1 return. end.
fl=. fromfoldername1 XPREBUILDFILE
try. 1 [ load__ <fl
catch. 0 [ info 'Error loading: ',,":fl
end.
)
buildpostscript=: 3 : 0
if. 0=#XPOSTBUILDFILE do. 1 return. end.
fl=. fromfoldername1 XPOSTBUILDFILE
try. 1 [ load__ <fl
catch. 0 [ info 'Error loading: ',,":fl
end.
)
buildstdlibs=: 3 : 0
select. STANDALONE
case. 0 do. ''
case. 1 do.
  libs=. getstdlibs''
  if. #msk=. I. -. fexist&> fromfoldername getlibfiles libs do.
    echo >msk{libs
  end.
  j=. <@(1!:1) fromfoldername getlibfiles libs
  if. IFDLL do.
    j=. j, <@(1!:1) <jpath '~addons/ide/jnet/conlib.ijs'
  else.
    j=. j, <@(1!:1) <jpath '~addons/ide/jnet/winlib.ijs'
  end.
  txt=. tolist j
case. 2 do.
  libs=. getstdlibs''
  f=. ' ''system/main/'&, @ (,&'.ijs''')
  j=. <'boot_z_=: 3 : ''0!:0 <jpathsep y'''
  j=. j, 'boot_z_'&, each f each libs
  if. IFDLL do.
    j=. j, <'0!:0 <jpathsep ''addons/ide/jnet/conlib.ijs'''
  else.
    j=. j, <'0!:0 <jpathsep ''addons/ide/jnet/winlib.ijs'''
  end.
  tolist j
end.
)
buildsystemdefs=: 3 : 0
dat=. y
res=. ''
if. STANDALONE = 0 do. return. end.
c=. 'jsystemdefs *''hostdefs''' rxmatches dat
if. #c do.
  res=. (getsystemdefs 'hostdefs'),LF
end.
c=. 'jsystemdefs *''netdefs''' rxmatches dat
if. #c do.
  res=. res, (getsystemdefs 'netdefs'),LF
end.
if. #res do.
  'jsystemdefs_z_=: 3 : ''0!:100 toHOST (y,''''_'''',tolower UNAME,(IF64#''''_64''''),''''_j_'''')~''',LF,res
else.
  ''
end.
)
buildtarget=: 3 : 0
if. 0=#XTARGETFILE do. return. end.

j=. addNB XTARGETHEADER
j=. j, (0<#j)#LF
pjf=. fsep tofoldername1 extnone PROJECTFILE
tag=. j,'NB. built from project: ',pjf,LF

'cmt tgt'=. buildtargetfiles''
tag=. tag, cmt

def=. buildjade''
std=. buildstdlibs''
trg=. buildtargetlibs''
sys=. buildsystemdefs trg
dat=. def;std;sys;trg;def
dat=. dat,<buildlocale''
dat=. dat,<tgt
dat=. dat,<XTARGETEXTRA
dat=. dtb each dat -. a:
dat=. ; dat ,each LF

if. IFDELCMT do. dat=. decomment dat end.
if. IFNOSHOW do. dat=. 'IFJIJX_j_=: 1',LF,dat end.

dat=. toHOST tag, LF, dat

xtg=. fromfoldername1 XTARGETFILE
if. 0 = pathcreate fpath xtg do.
  info 'Could not create path: ',fpath xtg return.
end.
if. '.ijl' -: _4 {. xtg do.
  dat=. 3!:6 dat
end.

if. dat flwritenew xtg do.
  Loaded_j_=: Loaded -. xtg
end.
)
buildtargetfiles=: 3 : 0
if. 0=#XPRIMARYFILES do. '';'' return. end.
xpf=. XPRIMARYFILES
if. 0=IFREQSRC do.
  xpf=. fromfoldername xpf
  top=. <;._2 LF ,~ 1!:1 {. xpf
  msk=. *./\ ('NB.'"_ -: 3: {. ]) &> top
  if. {. msk do.
    cmt=. (tolist msk # top), LF
    top=. (-.msk) # top
  else.
    cmt=. ''
  end.
  top=. termdelLF tolist top
  cmt ; tolist2 top ; <@(1!:1) }.xpf
else.
  f=. 'script_z_ '''&, @ (,&'''')
  '' ; LF ,~ fsep tolist f each xpf
end.
)
buildtargetlibs=: 3 : 0
if. 0=#XPRIMARYLIBS do. '' return. end.
select. IFREQLIB
case. 0 do.
  libs=. reqlibs1 XPRIMARYLIBS
  fls=. fromfoldername getscripts_j_ libs
  if. #msk=. I. -. fexist&> fls do.
    echo >msk{fls
  end.
  nodepends tolist <@(1!:1) fls
case. 1 do.
  libs=. getlibfiles XPRIMARYLIBS
  fsep ;'script_z_ '''&, each libs ,each <('''',LF)
case. do. ''
end.
)
getstdlibs=: 3 : 0
<'stdlib'
)
getsystemdefs=: 3 : 0
def=. _4&}.&.> {.("1) 1!:0 <jpath '~system/defs/',y,'*.ijs'
(def)=. <@(1!:1)"0 jpath@('~system/defs/'&,)@(,&'.ijs')&.> def
a=. ''
for_idef. def do.
  a=. a, (>idef),'_j_=: 0 :0',LF,((>idef)~),LF,')',LF
end.
)
setclass=: 3 : 0
y=. ,> y
if. 0 = #y do. '' return. end.
f=. '''',y,''''
(((<y) e. ;: 'base z') pick 'coclass ';'cocurrent '),f,LF
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
extijp=: 3 : 0
y, (('.jproj' -: _6 {. y) < ((0 < #y) > '.ijp' -: _4 {. y)) # '.ijp'
)
extijs=: 3 : 0
y, ((0 < #y) > ('.ijl';'.ijs') e.~ < _4 {. y) # '.ijs'
)
extnone=: 3 : 0
(- 4 * (<_4 {. y) e. <'.ijs') }. y
)
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
fullproject=: fullname @ extijp
fullscript=: (0: < #) # fullname @ extijs
pidname=: 3 : 0
y=. PIDPATH drophead extnone y
x=. <;.1 PATHSEP,y
if. =/ _2 {. x do. }. ; }: x else. y end.
)
plinkpath=: 3 : '0 pick pathname jpath PLINK'
shortname=: 3 : 0
if. 0 e. # y do. '' return. end.
files=. y
full=. fromfoldername y
path=. PROJECTPATH
len=. #path
ndx=. I. (<path) = len {. each full
(len }. each ndx { full) ndx } files
)
shortname1=: 3 : '> shortname <y'
fixrelative1=: 3 : 0
fn=. y
if. 0 = #fn do. return. end.
if. '~' = {. fn do. return. end.
if. PATHSEP = {. fn do. return. end.
if. IFWIN *. ':' = 1 { fn,':' do. return. end.
tofoldername1 fullname fn
)
cutdeb=: [: -.&a: <@deb;._2@termLF

pr1=: (fixrelative1 @ extijs each) @: cutdeb
pr2=: cutdeb
pr3=: cutopen @ termLF
pr4=: fixrelative1 @ extijs
pr5=: (fixrelative1 each) @: cutdeb

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
f=. jpathsep mbopen '"Delete File" "',p,'" "" ',j

if. ''-:f do. return. end.
if. 0=fexist f do. return. end.
if. 1=2 query 'OK to delete: ',f,'?' do. return. end.

file=. <f
1!:55 file
XPRIMARYFILES=: XPRIMARYFILES jflminus file
XDEVFILES=: XDEVFILES jflminus file
XOTHERFILES=: XOTHERFILES jflminus file
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
loadtryscript PROJECTFILE

BUILDOPTS=: (#DEFBUILDOPTS) {. BUILDOPTS,(#BUILDOPTS)}.DEFBUILDOPTS

if. '<' = {. PRIMARYFILES do.
  PLINKLAST=: PLINK=: }. PRIMARYFILES
  PRIMARYFILES=: 'PRIMARYFILES' readlink1 PLINK
  PLINKOLD=: PRIMARYFILES
else.
  PLINK=: ''
end.

OTHERFILES=: jpathsep OTHERFILES
PRIMARYFILES=: jpathsep PRIMARYFILES
DEVFILES=: jpathsep DEVFILES
TARGETFILE=: jpathsep TARGETFILE
PREBUILDFILE=: jpathsep PREBUILDFILE
POSTBUILDFILE=: jpathsep POSTBUILDFILE
TESTFILE=: jpathsep TESTFILE

XPRIMARYFILES=: pr1 PRIMARYFILES
XDEVFILES=: pr1 DEVFILES
XPRIMARYLIBS=: pr2 PRIMARYLIBS
XDEVLIBS=: pr2 DEVLIBS
XOTHERFILES=: pr5 OTHERFILES
XTARGETLOCALE=: TARGETLOCALE
XTARGETHEADER=: TARGETHEADER
XTARGETEXTRA=: TARGETEXTRA

XTARGETFILE=: pr4 TARGETFILE
XPREBUILDFILE=: pr4 PREBUILDFILE
XPOSTBUILDFILE=: pr4 POSTBUILDFILE
XTESTFILE=: pr4 TESTFILE

XBUILDOPTS=: BUILDOPTS
XNOTES=: NOTES
XVERSION=: VERSION
XWINDOWS=: pr3 WINDOWS
XOLD=: ".each XPFILENAMES
)
projcopyback=: 3 : 0
getfoldernames''

PRIMARYFILES=: tr1 XPRIMARYFILES

DEVFILES=: tr1 XDEVFILES
PRIMARYLIBS=: tr2 XPRIMARYLIBS
DEVLIBS=: tr2 XDEVLIBS
OTHERFILES=: tr2 XOTHERFILES

TARGETLOCALE=: XTARGETLOCALE
TARGETHEADER=: XTARGETHEADER
TARGETEXTRA=: XTARGETEXTRA

TARGETFILE=: XTARGETFILE
PREBUILDFILE=: XPREBUILDFILE
POSTBUILDFILE=: XPOSTBUILDFILE
TESTFILE=: XTESTFILE

BUILDOPTS=: XBUILDOPTS
NOTES=: XNOTES
VERSION=: XVERSION
WINDOWS=: tolist XWINDOWS
if. #PLINK do.
  if. -. PLINKOLD -: PRIMARYFILES do.
    (nounrep 'PRIMARYFILES') writelink1 PLINK
  end.
  PRIMARYFILES=: '<',PLINK
end.

empty''
)
projsave=: 3 : 0
if. (y=0) *. XOLD -: ".each XPFILENAMES do. return. end.
projcopyback''
pn=. jpathsep extnone PROJECTFILE
hdr=. 'NB. project file: ',pn,LF,LF
hdr=. hdr,'coclass ''jproject''',LF
ndx=. I. PFILENAMES e. PFILESEPS
nms=. nounrep each PFILENAMES
nms=. (jpathsep each ndx { nms) ndx } nms
dat=. hdr, ; LF&, each nms
dat flwritesnew PROJECTFILE
XOLD=: ".each XPFILENAMES
EMPTY
)
selproj1=: (#~ ([:(<'.ijp')&=_4&{.&.>))
selproj=: (#~ ([:(<'.ijp')&=_4&{.&.>)) @: ({."1)
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
folders=. (SystemFolders),2{."1 UserFolders
folders=. folders \: # &> {:"1 folders
PPIDS=: {."1 folders
PPATHS=: jpath@filecase each 1 {"1 folders
PSUBS=: 0#~#folders
)
tofoldername1=: 3 : 0
nam=. y
if. '~' = {. nam,'~' do. return. end.

nam=. filecase nam

msk=. -. PSUBS
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
LFILES=: 0 : 0
pc6j lfiles;
xywh 3 3 55 11;cc z0 static;cn "Select From:";
xywh 2 15 72 147;cc libfrom listbox ws_vscroll rightscale bottommove;
xywh 79 3 55 11;cc z1 static leftscale rightscale;cn "Selected:";
xywh 78 15 72 147;cc libto listbox ws_vscroll leftscale rightmove bottommove;
xywh 154 11 38 12;cc open button leftmove rightmove;cn "&Open";
xywh 154 24 38 12;cc view button leftmove rightmove;cn "&View";
xywh 154 37 38 12;cc print button leftmove rightmove;cn "&Print";
xywh 154 50 19 11;cc lmove button leftmove rightmove;cn "<<";
xywh 173 50 19 11;cc rmove button leftmove rightmove;cn ">>";
xywh 154 146 38 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
pas 2 2;
rem form end;
)
lfiles_run=: 3 : 0
wd LFILES
wd 'pshow;'
)
lfiles_cancel_button=: closeproject
lfiles_rlibs=: 3 : 0
r=. ~. (req -. ]) getlibfiles XPRIMARYLIBS,XDEVLIBS
r=. r intersect 1 {"1 Public
)
lfiles_show=: 3 : 0
pub=. {."1 Public

d1=. req x1=. getlibfiles XPRIMARYLIBS
f=. XPRIMARYLIBS

d2=. req x2=. getlibfiles XDEVLIBS
d1=. d1 -. x1,x2
d2=. d2 -. d1,x1,x2
d1=. pub intersect getlibids d1
d2=. pub intersect getlibids d2
RLIBS=: d1,d2
XLIBS=: XPRIMARYLIBS,d1,XDEVLIBS,d2
f=. f, (,&' (r)') each d1
f=. f, (,&' (d)') each XDEVLIBS
f=. f, (,&' (dr)') each d2

j=. (getliball'') -. XPRIMARYLIBS,XDEVLIBS
wd 'set libfrom *', tolist j
wd 'set libto *', tolist f
)
lfiles_rmove_button=: 3 : 0
if. -. 0 e. #libfrom do.
  XPRIMARYLIBS=: sort XPRIMARYLIBS,<libfrom
  lfiles_show''
end.
)
lfiles_lmove_button=: 3 : 0
if. -. 0 e. #libto do.
  file=. (".libto_select) { XLIBS
  if. file e. RLIBS do.
    info 'Cannot deselect required files' return.
  end.
  XPRIMARYLIBS=: XPRIMARYLIBS -. file
  XDEVLIBS=: XDEVLIBS -. file
  lfiles_show''
end.
)
lfiles_libfrom_button=: lfiles_rmove_button
lfiles_libto_button=: lfiles_lmove_button
lfiles_open_button=: popenfiles
lfiles_view_button=: viewfile
lfiles_print_button=: sprintfiles
lfiles_dev=: 3 : 0
if. 0 e. #libto_select do.
  if. #libfrom_select do.
    info 'Dev File applies only to files in the Selected list' return.
  else.
    infonosel'' return.
  end.
end.
file=. (".libto_select) { XLIBS
if. file e. RLIBS do.
  info 'Dev File does not apply to required files' return.
end.
p=. file -. XPRIMARYLIBS
q=. file -. XDEVLIBS
XPRIMARYLIBS=: sort p , XPRIMARYLIBS -. q
XDEVLIBS=: sort q, XDEVLIBS -. p
lfiles_show''
)
LINK=: 0 : 0
pc6j link owner;pn "Project Link";
xywh 216 7 45 12;cc ok button leftmove rightmove;cn "OK";
xywh 216 22 45 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 9 8 198 45;cc g0 groupbox rightmove;cn "Link Project";
xywh 15 20 133 11;cc enablelink checkbox;cn "Enable Link";
xywh 14 34 190 12;cc projlink edit ws_border es_autohscroll rightmove;
xywh 156 19 45 12;cc bprojlink button leftmove rightmove;cn "Browse...";
pas 3 4;pcenter;
rem form end;
)
link_run=: 3 : 0
wd LINK
link_show 0 < #PLINK
wd 'set projlink *',PLINK
wd 'setfocus ok'
wd 'pshow;'
)
link_bprojlink_button=: 3 : 0
'p f'=. pathname (0<#projlink) pick PLINKLAST;projlink
j=. '"Project Files (*.ijp)|*.ijp" ofn_filemustexist ofn_nochangedir'
r=. jpathsep mbopen '"Select File" "',p,'" "',f,'" ',j
if. #r do.
  wd 'set projlink *',r
end.
)
link_enablelink_button=: 3 : 0
on=. '1' = enablelink
if. -. on do.
  if. #projlink do.
    if. 2 query 'Confirm remove project link?' do. return. end.
  end.
end.
link_show on
)
link_show=: 3 : 0
if. y do.
  wd 'set enablelink 1'
  wd 'setenable projlink 1'
else.
  wd 'set enablelink 0'
  wd 'setenable projlink 0'
  wd 'set projlink'
end.
)
link_ok_button=: 3 : 0
on=. '1' = enablelink
if. on do.
  if. 0 = #projlink do.
    info 'First set project link' return.
  end.
  if. PROJECTFILE -: jpath projlink do.
    msg=. 'The linked project is the same as the current project file.'
    msg=. msg,LF,LF,'Select another project or remove the link.'
    info msg return.
  end.
  projlink=. tofoldername1 projlink
  if. -. (fromfoldername1 projlink) -: fromfoldername1 PLINK do.
    PLINKLAST=: PLINK=: projlink
    if. 0 -: pfs=. 'PRIMARYFILES' readlink1 PLINK do. return. end.
    PRIMARYFILES=: pfs
    XPRIMARYFILES=: pr1 PRIMARYFILES
    PLINKOLD=: PRIMARYFILES
  end.
else.
  if. #PLINK do.
    PLINKOLD=: XPRIMARYFILES=: PRIMARYFILES=: PLINK=: ''
  end.
end.
wd 'pclose'
showfiles''
)
link_close=: link_ok_button
ink_cancel=: link_cancel_button=: wd bind 'pclose'
readlink1=: 4 : 0
nam=. > x
a=. freads jpath y
if. a -: _1 do.
  info 'Unable to read link project: ',y
  0 return.
end.
x=. 1 i.~ (nam,'=: ') E. a
a=. (x + 3 + #nam) }. a
if. '0' = {.a do.
  a=. (1 + a i. LF) }. a
  (1 i.~ (LF,')') E. a) {. a
else.
  a=. }. a
  (a i. '''') {. a
end.
)
writelink1=: 4 : 0
f=. jpath y
a=. 'b' freads f
a=. a ,each LF
b=. (1: e. '=: '&E.) &> a
b=. 1 (0) } b
a=. b <@; ;.1 a
h=. (1 + x i. ' ') {. x
ndx=. 1 i. ~ (<h) = (#h) {.each a
if. ndx < # a do.
  a=. (<x,LF) ndx } a
else.
  a=. a , <x,LF
end.
a=. ; a
a fwrites f
)
readlinkedproject=: 4 : 0
cocurrent x
coclass=: ]
0!:0 <y
)
WNOTE=: 0 : 0
pc6j wnote owner;
xywh 2 3 55 11;cc z0 static;cn "Notes:";
xywh 0 16 250 200;cc noteedit editm ws_border ws_hscroll ws_vscroll rightmove bottommove;
xywh 207 2 38 12;cc cancel button leftmove rightmove;cn "Close";
pas 0 0;
rem form end;
)
wnote_run=: 3 : 0
if. wdisparent 'wnote' do.
  wd 'psel wnote;pactive' return.
end.
pos=. wd 'qformx'
wd WNOTE
wd 'set noteedit *',XNOTES
wd 'setfocus noteedit'
wdcenter pos
wd 'pshow'
)
wnoteclose=: 3 : 0
XNOTES=: termLF (#~ +./\.@(~:&LF)) noteedit
wd 'pclose'
wd 'psel ',HWNDP,';pactive'
)

wnote_cancel_button=: wnote_cancel=: wnote_close=: wnoteclose
j=. 'cellalign celldata cellitems celltype colminwidth'
ORPHANGRIDNAMES=: j,' colscale gridid gridmargin hdrcol hdrcolalign'
ORPHANHWNDP=: ''
ORPHANS0=: <;._2 (0 : 0)
add to Source
add to Other
add as Target
add as Pre-Build
add as Post-Build
add as Test
delete
do nothing
)
ORPHANS1=: <;._2 (0 : 0)
remove from project
do nothing
)
PORPHANS=: 0 : 0
pc6j porphans owner;pn "Orphan Files";
xywh 8 8 229 12;cc s0 static rightmove;
xywh 6 20 231 105;cc pgrid0 isigraph rightmove bottomscale;
xywh 8 132 229 12;cc s1 static topscale bottomscale rightmove;
xywh 6 154 231 105;cc pgrid1 isigraph topscale rightmove bottommove;
xywh 254 14 52 12;cc ok button leftmove rightmove;cn "OK";
xywh 254 29 52 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 254 43 52 12;cc apply button leftmove rightmove;cn "Apply";
xywh 248 72 64 61;cc g0 groupbox leftmove rightmove;cn "Set Actions";
xywh 254 86 52 12;cc psetdef button leftmove rightmove;cn "Defaults";
xywh 254 101 52 12;cc psetdon button leftmove rightmove;cn "Do Nothing";
xywh 254 116 52 12;cc psetfirst button leftmove rightmove;cn "Copy First";
pas 6 4;pcenter;
rem form end;
)
porphans_run=: 3 : 0
'orphans widows'=. y

wd 'pc6j porphans owner;pn "Orphan Files";'
ORPHANHWNDP=: wd 'qhwndp'
if. #orphans do.
  wd 'xywh 8 8 229 12;cc s0 static rightmove;'
  wd 'xywh 6 20 231 105;cc pgrid0 isigraph rightmove bottomscale;'
  wd 'setcaption s0 *Files not referenced in project:'
end.
if. #widows do.
  off=. 124 * 0 < #orphans
  wd 'xywh 8 ',(":8+off),' 229 12;cc s1 static topscale bottomscale rightmove;'
  wd 'xywh 6 ',(":20+off),' 231 105;cc pgrid1 isigraph topscale rightmove bottommove;'
  wd 'setcaption s1 *Files that are referenced but do not exist:'
end.
wd (1 i.~ 'xywh 2' E. PORPHANS) }. PORPHANS
cellalign=. 0
celltype=. 0 200
colscale=. 4 1
colminwidth=. 200 100
gridmargin=. 3 2 1 0
hdrcol=. 'File';'Action'
hdrcolalign=. 0

pgrid0=: pgrid1=: ''
if. #orphans do.
  ext=. _4 {. each orphans
  ors=. _1 ^ -. ext e. '.ijs';'.ijt';'.txt'
  ors=. ors * ext ~: <'.ijs'
  celldata=. orphans,.ors{ORPHANS0
  cellitems=. ,<ORPHANS0
  gridid=. 'pgrid0'
  pgrid0=: '' conew 'jzgrid'
  show__pgrid0 pkg ORPHANGRIDNAMES
end.
if. #widows do.
  celldata=. widows,.(#widows) # {.ORPHANS1
  cellitems=. ,<ORPHANS1
  gridid=. 'pgrid1'
  pgrid1=: '' conew 'jzgrid'
  show__pgrid1 pkg ORPHANGRIDNAMES
end.
wd 'pshow'
)
porphans_apply=: 3 : 0
p=. 0 pick pathname tofoldername1 PROJECTFILE
if. #pgrid0 do.
  dat=. CELLDATA__pgrid0
  for_d. dat do.
    'f act'=. d
    pf=. p,f
    select. ORPHANS0 i. <act
    case. 0 do.
      XPRIMARYFILES=: XPRIMARYFILES, <pf
    case. 1 do.
      XOTHERFILES=: sort XOTHERFILES, <pf
    case. 2 do.
      XTARGETFILE=: pf
    case. 3 do.
      XPREBUILDFILE=: pf
    case. 4 do.
      XPOSTBUILDFILE=: pf
    case. 5 do.
      XTESTFILE=: pf
    case. 6 do.
      ferase jpath pf
    end.
  end.
end.
if. #pgrid1 do.
  dat=. CELLDATA__pgrid1
  for_d. dat do.
    'f act'=. d
    select. ORPHANS1 i. <act
    case. 0 do.
      pf=. p prepath f
      XPRIMARYFILES=: XPRIMARYFILES jflminus pf
      XOTHERFILES=: XOTHERFILES jflminus pf
      XDEVFILES=: XDEVFILES jflminus pf
      XTARGETFILE=: ;XTARGETFILE jflminus pf
      XPREBUILDFILE=: ;XPREBUILDFILE jflminus pf
      XPOSTBUILDFILE=: ;XPOSTBUILDFILE jflminus pf
      XTESTFILE=: ;XTESTFILE jflminus pf
    end.
  end.
end.
XDEVFILES=: XDEVFILES jflminus XPRIMARYFILES
projsave 0
wd 'psel ',HWNDP
showfiles''
projaddrecent''
wd 'psel ',ORPHANHWNDP
)
porphans_apply_button=: 3 : 0
porphans_apply''
ow=. getorphans''
if. 0 = #;ow do.
  wdinfo 'Orphan Files';'No more orphan files'
  porphans_close'' return.
end.
ow=. sort each shortname each ow
porphans_update ow
)
porphans_close=: 3 : 0
if. #pgrid0 do.
  destroy__pgrid0''
end.
if. #pgrid1 do.
  destroy__pgrid1''
end.
wd 'psel ',ORPHANHWNDP
wd 'pclose'
ORPHANHWNDP=: pgrid0=: pgrid1=: ''
)
porphans_ok_button=: 3 : 0
porphans_apply''
porphans_close''
)
porphans_cancel_button=: porphans_close
porphans_update=: 3 : 0
'orphans widows'=. y

if. #pgrid0 do.
  dat=. CELLDATA__pgrid0
  msk=. ({."1 dat) e. orphans
  dat=. msk # dat
  show__pgrid0 ,:'celldata';<dat
end.
if. #pgrid1 do.
  dat=. CELLDATA__pgrid1
  msk=. ({."1 dat) e. widows
  dat=. msk # dat
  show__pgrid1 ,:'celldata';<dat
end.

)
getorphans=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
saveopenwindows''
f=. getprojdirfiles''
j=. PROJECTFILE;XTARGETFILE;XPREBUILDFILE;XPOSTBUILDFILE;XTESTFILE
j=. j,XPRIMARYFILES,XDEVFILES,XOTHERFILES
f=. fullname each f
j=. fullname each j -. a:
f=. filecase each f
j=. filecase each j
orphan=. f -. j
widow=. (-.@fexist &> # ]) j
orphan;<widow
)
showorphans=: 3 : 0
ow=. getorphans''
if. 0 = #;ow do.
  info 'No orphan files' return.
end.
porphans_run sort each shortname each ow
)
porphans_psetdef_button=: 3 : 0
if. #pgrid0 do.
  dat=. {."1 CELLDATA__pgrid0
  ors=. -. (<'.ijs') ([ -: _4 {.]) &> dat
  dat=. dat,.ors{ORPHANS0
  show__pgrid0 ,:'celldata';<dat
end.
if. #pgrid1 do.
  dat=. ({."1 CELLDATA__pgrid1),.{.ORPHANS1
  show__pgrid1 ,:'celldata';<dat
end.
)
porphans_psetdon_button=: 3 : 0
if. #pgrid0 do.
  dat=. ({."1 CELLDATA__pgrid0),.{:ORPHANS0
  show__pgrid0 ,:'celldata';<dat
end.
if. #pgrid1 do.
  dat=. ({."1 CELLDATA__pgrid1),.{:ORPHANS1
  show__pgrid1 ,:'celldata';<dat
end.
)
porphans_psetfirst_button=: 3 : 0
if. #pgrid0 do.
  dat=. ({."1 CELLDATA__pgrid0),.(<0;1){CELLDATA__pgrid0
  show__pgrid0 ,:'celldata';<dat
end.
if. #pgrid1 do.
  dat=. ({."1 CELLDATA__pgrid1),.(<0;1){CELLDATA__pgrid1
  show__pgrid1 ,:'celldata';<dat
end.
)
prepath=: 4 : 0
if. IFUNIX do.
  m=. '/' ~: {.y
else.
  m=. ':' ~: {:2{.y
end.
(m#x),y
)
WOTHER=: 0 : 0
pc6j wother owner;
xywh 3 3 55 11;cc s0 static;cn "Other Files:";
xywh 2 15 148 147;cc spfiles listbox ws_hscroll ws_vscroll lbs_extendedsel rightmove bottommove;
xywh 154 11 38 12;cc bopen button leftmove rightmove;cn "&Open";
xywh 154 24 38 12;cc bview button leftmove rightmove;cn "&View";
xywh 154 37 38 12;cc bprint button leftmove rightmove;cn "&Print";
xywh 154 50 38 12;cc add button leftmove rightmove;cn "&Add";
xywh 154 63 38 12;cc remove button leftmove rightmove;cn "&Remove";
xywh 154 146 38 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
pas 0 0;
rem form end;
)
wother_run=: 3 : 0
wd WOTHER
wd 'pshow;'
)
wother_cancel_button=: closeproject
wother_show=: 3 : 0
XOTHERFILES=: XOTHERFILES jflminus XPRIMARYFILES,XDEVFILES,buildfiles''
wd 'set spfiles *',tolist shortname XOTHERFILES
)
wother_add_button=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
p=. PROJECTPATH

j=. '"Script Files (*.ijs)|*.ijs|Project Files (*.ijp)|*.ijp|'
j=. j,'Lab Files (*.ijt)|*.ijt|Text Files (*.txt)|*.txt|'
j=. j,'All Files (*.*)|*.*"'
j=. j,' ofn_nochangedir'
f=. jpathsep mbsave '"Other File" "',p,'" "" ',j
if. '' -: f do. return. end.

f=. f, (-. '.' e. f) # '.ijs'

if. f jflin XPRIMARYFILES, XDEVFILES, XOTHERFILES, buildfiles'' do.
  info 'already in project: ',shortname1 f return.
end.
if. 0=fexist f do. '' flwritesnew f end.

XOTHERFILES=: sort XOTHERFILES, < tofoldername1 f
projsave 0
wother_show''
)
wother_remove_button=: 3 : 0
if. 0 e. #spfiles do. infonosel'' return. end.

files=. (".spfiles_select) { XOTHERFILES
ff=. tolist shortname files
if. 1=2 query 'OK to remove:',LF,LF,ff do. return. end.

XOTHERFILES=: XOTHERFILES jflminus files
projsave 0
wother_show''
)
wother_bopen_button=: popenfiles
wother_bview_button=: viewfile
wother_bprint_button=: sprintfiles
wother_spfiles_button=: popenfiles
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
  projectform6_show''
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
projectform6_show''
)
RX=: '^\s*(load|require|script<|script_z_<|script <|script_z_) *(''(''''|[^''])*'')'

reqread=: 1!:1 :: (''"_)
reqscripts=: fromfoldername @ getlibfiles @ ; @: (cutopen@".&.>)
reqlibs=: getlibids @: req @: getlibfiles
reqlibs1=: 3 : 0
a=. y
b=. ''
while. -. '' -: r=. reqlibs a do.
  a=. r [ b=. r,b
end.
~.b,y
)
getliball=: 3 : 0
sort STDLIBS -.~ ~. {."1 Public
)
getlibfiles=: 3 : 0
y=. y-.IgnoreLibs
f=. (0{"1 Public),y
t=. (1{"1 Public),y
t {~ f i. y
)
getlibids=: 3 : 0
s=. jpathsep each y
f=. (1{"1 Public),y
t=. (0{"1 Public),s
t {~ f i. y
)
nodepends=: 3 : 0
if. 0=#y do. '' return. end.
dat=. (LF,LF),y
hit=. RX rxmatches_jregex_ dat
if. 0=#hit do. y return. end.
ndx=. 0, {.@(1&{)"2 hit
dat=. ((i.#dat) e. ndx) <;.1 dat
dat=. 6 }. ; 'NB. '&, each dat
)
req=: 3 : 0
RXH=: rxcomp_jregex_ RX
files=. fromfoldername boxxopen y
done=. ''
found=. i.0 2
while. #files do.
  done=. done,f=. {.files
  r=. req1 f
  found=. found, r ,. f
  files=. ~. (}.files), r -. done
end.
rxfree_jregex_ RXH
reqsort found
)
req1=: 3 : 0
dat=. reqread < jpath > y
if. 0=#dat do. '' return. end.
hit=. RXH rxmatches_jregex_ LF,dat
if. 0=#hit do. '' return. end.
reqscripts (2{"2 hit) rxfrom_jregex_ LF,dat
)
reqsort=: 3 : 0
b=. {."1 y
e=. {:"1 y
r=. ''
while. #b do.
  n=. b -. e
  if. 0=#n do. n=. {.b end.
  r=. r,n
  msk=. -. b e. n
  e=. msk#e
  b=. msk#b
end.
r=. ~. r
s=. 1{"1 Public
t=. fromfoldername s
(s,r) {~ (t,r) i. r
)
loadproject=: 4 : 0
f=. jpath extijp y
if. 0=fexist f do.
  info 'not found: ',f return.
end.
setprojfile fullname f
projcfgread''
projread''
runprojectfiles 'p' e. x
)
loadtarget=: 3 : 0
cocurrent 'base'
load XTARGETFILE_jproject_
)
loaddtarget=: 3 : 0
cocurrent 'base'
loadd XTARGETFILE_jproject_
)
runproject=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
runproject1 0
)
runproject1=: 3 : 0
saveopenwindows''
projsave 0
j=. y pick 'loadp ';'''c'' loadp ';'''cp'' loadp '
('   ',j,'''',PROJECTFILE,'''') 1!:2 [ 2
runprojectfiles y=2
)
runprojectfiles=: 3 : 0
projaddrecent''
if. y=1 do.
  l=. PRIMARYLIBS
  f=. XPRIMARYFILES
else.
  l=. PRIMARYLIBS,LF,DEVLIBS
  f=. XPRIMARYFILES,XDEVFILES
end.
load l
if. #f do.
  f=. extijs each f
  if. #XTARGETLOCALE do.
    cocurrent XTARGETLOCALE
  else.
    cocurrent 'base'
  end.
  load f
end.
)
runtest=: 3 : 0
stk=. 13!:13''
if. # stk do.
  nms=. ;: 'runtest projectform6_runtest_button wdhandler_jproject_'
  if. -. nms -: {."1 stk do.
    smoutput 'Stack cleared - run Test again'
    jdb_close_jdebug_ :: ] ''
    return.
  end.
end.
13!:0 [ 13!:17 ''
f=. fromfoldername1 XTESTFILE
if. 0=#f do. info 'No test file defined' return. end.
if. 0=fexist f do. info 'Not found: ',LF,LF,f return. end.
saveopenwindows''
runimmx0 '0!:0 <''',f,''''
)
SFILES=: 0 : 0
pc6j sfiles;
xywh 3 3 55 11;cc s0 static;cn "Files:";
xywh 2 15 148 147;cc filelist listbox ws_vscroll lbs_extendedsel rightmove bottommove;
xywh 154 11 38 12;cc open button leftmove rightmove;cn "&Open";
xywh 154 24 38 12;cc view button leftmove rightmove;cn "&View";
xywh 154 37 38 12;cc print button leftmove rightmove;cn "&Print";
xywh 154 50 38 12;cc add button leftmove rightmove;cn "&Add";
xywh 154 63 38 12;cc remove button leftmove rightmove;cn "&Remove";
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
  wd 'set filelist *', jpathsep getfilelist''
  if. #y do.
    ndx=. XFILES i. y
    ndx=. ndx #~ ndx = ({.ndx)+i.#ndx
    wd@('setselect filelist '&,@":) &> ndx
  end.
  wd 'setshow filelist 0;setshow filelist 1'
end.
)
sfiles_add_button=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
if. #PLINK do.
  p=. plinkpath''
else.
  p=. PROJECTPATH
end.
while. 1 do.
  j=. '"Script Files(*.ijs)|*.ijs"'
  j=. j,' ofn_nochangedir'
  f=. jpathsep mbsave '"New Source File" "',p,'" "" ',j
  if. ''-:f do. return. end.
  f=. extijs f
  if. '.ijs' -: _4 {.f do. break. end.
  info 'Script filename extension should be .ijs'
end.
f=. filecase f

if. f jflin XPRIMARYFILES, XDEVFILES do.
  info 'already in project: ',shortname1 extnone f return.
end.

if. #PLINK do.
  if. -. p -: (#p) {. f do.
    info 'New linked script must be in link directory.' return.
  end.
end.
if. 0=fexist f do. '' flwritesnew f end.

XPRIMARYFILES=: XPRIMARYFILES, < tofoldername1 f
XDEVFILES=: XDEVFILES jflminus f
sfiles_show''
projaddrecent''
)
sfiles_remove_button=: 3 : 0
if. 0 e. #filelist do. infonosel'' return. end.

files=. (".filelist_select) { XFILES

if. 1 e. files e. RFILES do.
  info 'You cannot remove required files' return.
end.

ff=. tolist shortname extnone each files

if. 1=2 query 'OK to remove:',LF,LF,ff do. return. end.

XFILES=: XFILES jflminus files
XPRIMARYFILES=: XPRIMARYFILES jflminus files
XDEVFILES=: XDEVFILES jflminus files
sfiles_show''
projaddrecent''
)

sfiles_filelist_button=: popenfiles
sfiles_open_button=: popenfiles
sfiles_view_button=: viewfile
sfiles_print_button=: sprintfiles
sfiles_dev=: 3 : 0
if. 0 e. #filelist do. infonosel'' return. end.
files=. (".filelist_select) { XFILES
if. 1 e. files e. RFILES do.
  info 'You cannot make a required file into a dev file' return.
end.
p=. files jflminus XPRIMARYFILES
q=. files jflminus XDEVFILES
XPRIMARYFILES=: (XPRIMARYFILES jflminus q),p
XDEVFILES=: (XDEVFILES jflminus p),q
sfiles_show''
)
sfiles_move=: 3 : 0
if. TABNDX ~: 0 do.
  info 'Source Move applies only in the Source Tab' return.
end.
if. 0 e. #filelist do. infonosel'' return. end.
files=. (".filelist_select) { XFILES
if. 1 e. files e. RFILES do.
  info 'Cannot move required files' return.
end.
if. #fp=. files jflminus XDEVFILES do.
  ndx=. XPRIMARYFILES i. fp
  j=. y,(#XPRIMARYFILES),({.ndx),{:ndx
  XPRIMARYFILES=: XPRIMARYFILES {~ ssort j
end.
if. #fd=. files jflminus XPRIMARYFILES do.
  ndx=. XDEVFILES i. fd
  j=. y,(#XDEVFILES),({.ndx),{:ndx
  XDEVFILES=: XDEVFILES {~ ssort j
end.
sfiles_show files
)
sourcesort=: 3 : 0
msg=. 'OK to sort source files in alpha order?'
if. 0 = 2 query msg do.
  XPRIMARYFILES=: sort XPRIMARYFILES
  sfiles_show ''
end.
)
ssort=: 3 : 0
'd l b e'=. y
x=. i.l
if. (y=0) *. b>0 do.
  b=. b-1 [ e=. e+1
  (b{.x),(1|.b}.e{.x),e}.x
elseif. (y=1) *. e<l-1 do.
  e=. e+2
  (b{.x),(_1|.b}.e{.x),e}.x
end.
)
getfilelist=: 3 : 0
if. #PLINK do.
  XFILES=: XPRIMARYFILES
  p=. plinkpath''
  f=. fromfoldername XPRIMARYFILES
  f=. extnone each p & drophead each f
  tolist f ,each <' (l)' return.
end.
if. 0 = (#XPRIMARYFILES) + #XDEVFILES do.
  RFILES=: ''
  XFILES=: ''
  return.
end.

if. _1 -: RLIBS do. RLIBS=: lfiles_rlibs'' end.

inlibs=. getlibfiles XPRIMARYLIBS,RLIBS
d1=. (req XPRIMARYFILES) jflminus inlibs

inlibs=. inlibs,getlibfiles XDEVLIBS
d2=. (req XDEVFILES) jflminus inlibs
d1=. d1 jflminus XPRIMARYFILES,XDEVFILES
d2=. d2 jflminus d1,XPRIMARYFILES,XDEVFILES
d1=. d1 #~ flexist &> jpath each d1
d2=. d2 #~ flexist &> jpath each d2
RFILES=: d1,d2
XFILES=: XPRIMARYFILES,d1,XDEVFILES,d2

f=. extnone each XPRIMARYFILES
f=. f, (,&' (r)') each extnone each d1
f=. f, (,&' (d)') each extnone each XDEVFILES
f=. f, (,&' (dr)') each extnone each d2

f=. shortname f

tolist f
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
require '~ide/jnet/util/dirmatch.ijs'
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
require '~ide/jnet/util/dirmatch.ijs'
PJPROJ_jdirmatch_=: ''
dmrun_jdirmatch_ 2 1
)
psvn_cpath_select=: psvn_cpath_button
TEMPLATETEST=: 0 : 0
buildproject_jproject_ ''
loadtarget_jproject_ ''
loadscript_jproject_ 'test0.ijs'
)
templateijs=: 4 : 0
('NB. ',x,LF) fwrites y,x,'.ijs'
)
template1=: 3 : 0
p=. jpath y
y=. tofoldername1 y
f=. ;: 'init main run test test0'
f templateijs each <p
(LF,TEMPLATETEST) fappends p,'test.ijs'
(LF,'smoutput ''test0'',LF') fappends p,'test0.ijs'
XPRIMARYFILES=: (<y) ,each (3 {.f) ,each <'.ijs'
XOTHERFILES=: ,<y,'test0.ijs'
XTESTFILE=: y,'test.ijs'
projsave 0
showfiles''
)
tagparen=: ' ('&, @ (,&')') @ ":
exportdoc=: 3 : 0
require '~ide/jnet/packages/export/export.ijs'
f=. >{.getselectfiles''
exportmenu_jexport_ f;sysmodifiers
)
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
fls=. 'In file: '&, each shortname f
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
showprojdir=: 3 : 0
dirs PROJECTPATH
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
TABGROUPS=: ;: 'sfiles lfiles bfiles wother'
PTOP=: 0
PROJECTFORM=: 0 : 0
pc6j projectform6;pn "J6 Project Manager";
menupop "&File";
menu pnew "&New..." "" "" "";
menu popen "&Open..." "" "" "";
menusep;
menu plast "&Last" "Ctrl+L" "" "";
menu precent "&Recent..." "" "" "";
menusep;
menu save "&Save" "Ctrl+S" "" "";
menusep;
menu notes "No&tes..." "" "" "";
menusep;
menu refresh "Re&fresh Tabs" "" "" "";
menusep;
menu delete "&Delete File..." "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Options";
menu dev "Mark as Dev Only" "" "" "";
menusep;
menu up "Source Move Up" "Ctrl+U" "" "";
menu down "Source Move Down" "Ctrl+N" "" "";
menusep;
menu ptop "Topmost window" "Ctrl+T" "" "";
menusep;
menu configure "Confi&gure..." "" "" "";
menupopz;
menupop "&Tools";
menu runfile "&Run File" "Ctrl+W" "" "";
menusep;
menu ass "&Global Assignments in File" "" "" "";
menusep;
menu pub "&Export Script" "" "" "";
menu pp "&Format Script" "" "" "";
menusep;
menu orphan "Project &Orphan Files" "" "" "";
menu projdir "Project &Directory" "" "" "";
menusep;
menu sourcesort "&Sort Source Files" "" "" "";
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
menupop "&Project";
menu buildopt "Build &Options..." "" "" "";
menusep;
menu linkproject "&Link Project..." "" "" "";
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
xywh 2 44 198 176;cc tabs tab rightmove bottommove;
xywh 158 4 38 12;cc load button leftmove rightmove;cn "&Load";
xywh 158 18 38 12;cc buildapp button leftmove rightmove;cn "&Build";
xywh 158 32 38 12;cc runtest button leftmove rightmove;cn "&Test";
pas 0 2;pcenter;
rem form end;
)
projectform6_run=: 3 : 0
getfoldernames''
if. wdisparent 'projectform6' do.
  wd 'psel projectform6;pshow;pactive' return.
end.
TABNDX=: 0
TXFILES=: i.0 2
wd PROJECTFORM
HWNDP=: wd 'qhwndp'
wd 'set tabs "Source" "Library" "Project" "Other"'
wd 'creategroup tabs'
sfiles_run''
lfiles_run''
bfiles_run''
wother_run''
wd 'creategroup'
projinit''
projectform6_show''
wd 'setenable snapmake ',": 0 < PMSNAPS
wd 'setenable snapview ',": 0 < PMSNAPS
wd 'setshow sfiles 1'
wd 'setfocus load'
wd 'set ptop ',":PTOP
wpset 'projectform6'
wd 'pshow;'
)
projectform6_buildapp_button=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
buildapp''
)
projectform6_buildopt_button=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
buildopt''
)
projectform6_dev_button=: 3 : 0
if. TABNDX=0 do. sfiles_dev'' else. lfiles_dev'' end.
)
projectform6_helpover_button=: 3 : 0
htmlhelp602 'user/projects.htm'
)
projectform6_projectfile_select=: 3 : 0
if. #projectfile_select do.
  j=. (".projectfile_select) pick PJFNDX { PJFILES
  if. j -: PROJECTFILE do. return. end.
  projsave 0
  projectform6_load j
  projaddrecent''
end.
)
projectform6_projectpath_select=: 3 : 0
if. projectpath -: PID do. return. end.
projsave 0
setprojpathfile projectpath
projectform6_load PROJECTFILE
)
projectform6_save_button=: 3 : 0
if. 0=#PROJECTFILE do. infonoproj'' return. end.
projsave 0
info 'Saved: ',PROJECTFILE
)
projectform6_selectpath=: 3 : 0
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

projectform6_selectpathdown_button=: projectform6_selectpath bind 1
projectform6_selectpathup_button=: projectform6_selectpath bind 0
projectform6_tabs_button=: 3 : 0
new=. ".tabs_select
if. new=3 do. wother_show'' end.
wd 'setshow ',(>TABNDX{TABGROUPS),' 0'
TABNDX=: new
wd 'setshow ',(>TABNDX{TABGROUPS),' 1'
)
projectform6_ptop_button=: 3 : 0
PTOP=: ".ptop
wd 'ptop ',ptop
)
projectform6_enter=: ]
projectform6_cancel=: projectform6_close=: closeproject
projectform6_ass_button=: showassignments
projectform6_closewin_button=: windows_close
projectform6_configure_button=: cfg_run
projectform6_linkproject_button=: link_run
projectform6_delete_button=: deletefile
projectform6_down_button=: sfiles_move bind 1
projectform6_exit_button=: projectform6_close
projectform6_gitgui_button=: gitgui
projectform6_gitstatus_button=: gitstatus
projectform6_load_button=: runproject
projectform6_notes_button=: wnote_run
projectform6_openwin_button=: windows_open
projectform6_orphan_button=: showorphans
projectform6_plast_button=: plast_run
projectform6_pnew_button=: opennewproject
projectform6_popen_button=: openoldproject
projectform6_pp_button=: prettyprint
projectform6_precent_button=: precent_run
projectform6_projdir_button=: showprojdir
projectform6_projectfile_button=: projectform6_projectfile_select
projectform6_projectpath_button=: projectform6_projectpath_select
projectform6_pub_button=: exportdoc
projectform6_refresh_button=: showfiles
projectform6_runfile_button=: load @: getselectfiles
projectform6_runtest_button=: runtest
projectform6_savewin_button=: windows_save
projectform6_snapmake_button=: snapshot bind 1
projectform6_snapview_button=: snapview
projectform6_svnstatus_button=: svnstatus
projectform6_svnview_button=: svnview
projectform6_sourcesort_button=: sourcesort
projectform6_up_button=: sfiles_move bind 0

projectform6_bctrl_fkey=: projectform6_buildapp_button
projectform6_dctrl_fkey=: editinputlog
projectform6_fctrl_fkey=: editfind
projectform6_fctrlshift_fkey=: fif
projectform6_lctrl_fkey=: projectform6_plast_button
projectform6_nctrl_fkey=: projectform6_down_button
projectform6_sctrl_fkey=: projectform6_save_button
projectform6_uctrl_fkey=: projectform6_up_button
projectform6_wctrl_fkey=: projectform6_runfile_button
projectform6_load=: 3 : 0
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
projectform6_show''
)
projectform6_show=: 3 : 0
wd 'psel ',HWNDP
showproject''
showfiles''
wd 'setshow ',(0 pick TABGROUPS),' ',":0=TABNDX
wd 'setshow ',(1 pick TABGROUPS),' ',":1=TABNDX
wd 'setshow ',(2 pick TABGROUPS),' ',":2=TABNDX
wd 'setshow ',(3 pick TABGROUPS),' ',":3=TABNDX
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
showfiles=: lfiles_show @ sfiles_show @ bfiles_show @ wother_show
projectmanager=: projectform6_run
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
