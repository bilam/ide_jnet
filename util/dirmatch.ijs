require 'jview'
coclass 'jdirmatch'

coinsert 'j'

DMCFGFILE=: jpath '~config/dmconfig.ijs'

DMDIRS=: ''
DMSOURCEFM=: ''
DMSOURCE=: ''
DMTARGET=: ''
DMFAVORITES=: i.0 2

MAXDMDIRS=: 12

DMFOUNDALL=: DMFOUNDCONTENTS=: ''
NOTINSOURCE=: NOTINTARGET=: ''
DIFFTIME=: DIFFCONT=: i.0 6
DIFFTIMEST=: DIFFCONTST=: ''

DMMSK=: ''
DMTREEX=: ''
DMTYPE=: ''
DMTYPES=: 0 2$''
DMMAXSIZE=: 200000
DMTAB=: 'std'
DMCONTENTS=: 0
DMTIMESTAMP=: 0
DMPACK=: ''
DMPACKNAMES=: <;._2 (0 : 0)
DIFFCONT
DIFFCONTST
DIFFTIME
DIFFTIMEST
NOTINSOURCE
)
PJSOURCE=: ''
PJTARGET=: ''

DMSUBDIR=: 1
IGNOREST=: 0
IGNORENS=: 0
IGNORENT=: 0
IGNORESEP=: 1
IGNORELTW=: 0
TEXTBASE=: PATHSEP,'text-base',PATHSEP
termSEP=: , (0: < #) # PATHSEP"_ -. _1&{.
termdelSEP=: }.~ [: - 0: i.~ PATHSEP&= @ |.

HWNDP=: ''
PICON=: ''
contents=: '0'
dmputconfig=: 3 : 0
DMDIRS=: (MAXDMDIRS <. #DMDIRS) {. DMDIRS
DMSNAPS=: (MAXDMDIRS <. #DMSNAPS) {. DMSNAPS
DMSVNS=: (MAXDMDIRS <. #DMSVNS) {. DMSVNS
dat=. 'NB. Directory Match configuration',LF
dat=. dat,LF,'DMDIRS' dmrep tolist DMDIRS
dat=. dat,LF,'DMFAVORITES' dmrep tolist ,DMFAVORITES
dat=. dat,LF,'DMLASTDIRS' dmrep tolist DMLASTDIRS
dat=. dat,LF,'DMSNAPS' dmrep tolist DMSNAPS
dat=. dat,LF,'DMSVNS' dmrep tolist DMSVNS
dat=. dat,LF,'DMTYPE' dmrep DMTYPE
dat=. dat,LF,'DMTYPEXTS' dmjoin DMTYPES,.DMEXTS
dat=. toHOST dat
dat 1!:2 <DMCFGFILE
)
dmgetglobals=: 3 : 0
'DMTYPES DMEXTS'=: dmsplit DMTYPEXTS
DMDIRS=: <;._2 termLF dmlower DMDIRS
DMLASTDIRS=: <;._2 termLF dmlower DMLASTDIRS
if. # DMLASTDIRS do.
  'DMSOURCE DMTARGET'=: 2 {. DMLASTDIRS
else.
  DMSOURCE=: DMTARGET=: ''
end.
DMSOURCEFM=: DMSOURCE
DMSNAPS=: <;._2 termLF dmlower DMSNAPS
DMSVNS=: <;._2 termLF dmlower DMSVNS
DMFAVORITES=: _2 ,\ a: -.~ deb each <;._2 termLF DMFAVORITES
if. 0=nc <'PROJECTFILE_jnproject_' do.
  DMSNAPS=: cleanlist (<PROJECTFILE_jnproject_),DMSNAPS
  DMSVNS=: cleanlist (<delBS PROJECTPATH_jnproject_),DMSVNS
end.
if. 0=nc <'PROJECTFILE_jproject_' do.
  DMSNAPS=: cleanlist (<PROJECTFILE_jproject_),DMSNAPS
  DMSVNS=: cleanlist (<delBS PROJECTPATH_jproject_),DMSVNS
end.
)
EMPTY=: i.0 0
LF2=: LF,LF

deb=: #~ (+. 1: |. (> </\))@(' '&~:)
dlb=: }.~ =&' ' i. 0:

isempty=: 0: e. $
index=: #@[ (| - =) i.
intersect=: e. # [
last=: 1 : 'u " 1'
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP)#y'
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))
subs=. 2 : 'm I. @(e.&n)@]} ]'
toblank=: ' ' subs '_'
tohyphen=: '_' subs ' '

todelim=: ; @: ((DEL&,) @ (,&DEL) @ , @ ": &.>)
tolist=: }.@;@:(LF&,@,@":&.>)

delBS=: }.~ [: - PATHSEP = {:
termBS=: , (0 < #) # PATHSEP -. {:
termLF=: , (0 < #) # LF -. {:

fmtdir=: termBS @ dmlower
addtextbase=: 3 : 0
'nms src'=. y
nms=. pathname &> nms
src=. (<src) ,each ({."1 nms) ,each <'.svn',TEXTBASE
nms=. ({:"1 nms) ,each <'.svn-base'
src ,each nms
)
cleanlist=: 3 : 0
dir=. ~. y -. a:
msk=. (1 e. '.svn'&E.) &> dir
msk=. msk +. (1 e. '.snp'&E.) &> dir
dir #~ -.msk
)
dmfixunix=: 3 : 0
if. -.IFUNIX do. y return. end.
dat=. <;._2 y
rem=. ;:'bvtarget bsource btarget'
msk=. -. +./rem (1 e. E.) &>/ dat
; (msk#dat) ,each LF
)
dmindex=: 4 : 0
if. 0 = #x do. _1 else. x index y end.
)
dminfo=: 3 : 0
jdm_show''
wdinfo 'Directory Match';y
)
dmjoin=: 4 : 0
if. 0 = L. y do.
  dat=. y
else.
  dat=. }. , LF ,. (>tohyphen each {."1 y) ,. ' ',. > {:"1 y
end.
dat=. x,'=: 0 : 0',LF,(termLF dat),')',LF
)
dmquery=: 4 : 0
jdm_show''
x wdquery 'Directory Match';y
)
dmsplit=: 3 : 0
if. 0 < L. y do. y return. end.
dat=. <;._2 y
g=. i.&' '
h=. g (toblank@{. ; deb@}.) ]
res=. h &> dat
({."1 res) ; <{:"1 res
)
dmrep=: 4 : 0
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
expandn=: 4 : 0
y #~ (#y)$>:(-x){.0j1
)
filecopy=: 3 : 0
'source dest'=. y
if. 0 = pathcreate fpath dest do. 0 return.
end.
if. IFWIN do.
  0 pick 'kernel32 CopyFileW i *w *w i' cd (uucp source);(uucp dest);0
else.
  datold=. fread :: 0: dest
  datnew=. fread :: 0: source
  if. -. datold -: datnew do.
    datnew fwrite dest
  end.
end.
1
)
fileread=: 1!:1
filecmp=: 4 : 0
src=. (< @: (1!:1))"0 x
tar=. (< @: (1!:1))"0 y
src = tar
)
fpath=: 3 : 'y#~+./\.y=PATHSEP'
fsetrw=: 3 : 0
if. IFWIN do.
  a=. 1!:6 <y
  if. 0=#a do. return. end.
  ('-' 0 } a) 1!:6 <y
else.
  a=. 1!:7 <y
  if. 0=#a do. return. end.
  ('rw' 0 1 } a) 1!:7 <y
end.
)
makecompare=: 3 : 0
select. IGNORESEP + 2 * IGNORELTW
case. 0 do.
  compare=: compare_jcompare_
  fcompare=: ('';0) & fcomp_jcompare_
case. 1 do.
  compare=: compare_jcompare_ & toJ
  fcompare=: ('';1) & fcomp_jcompare_
case. 2 do.
  compare=: compare_jcompare_ & remltws
  fcompare=: ('';2) & fcomp_jcompare_
case. 3 do.
  compare=: compare_jcompare_ & remltws & toJ
  fcompare=: ('';3) & fcomp_jcompare_
end.
i.0 0
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
remltws=: 3 : 0
y=. (toJ y), LF
fn=. #~ ([: (+./\ *. +./\.) -.@(e.&(' ',TAB)))
dat=. fn each <;._2 y
}: ; dat ,each LF
)
requireproject=: 3 : 0
require 'ide/jnet/util/project'
)
tolist3=: 3 : 0
}. , LF ,. listfmt y
)
tolist6=: 3 : 0
dat=. ((2 * #y),3) $ ,y
}: tolist 2 expandn <"1 listfmt dat
)
listfmt=: 3 : 0
nm=. > 0 {"1 y
ts=. tsfmt > 1 {"1 y
ts=. ' ' ,. ts ,. ' '
sz=. ": ,. > 2 {"1 y
nm ,. ts ,. sz
)
tsfmt=: 3 : 0
r=. }: $ y
t=. 2 1 0 3 4 5 {"1 [ _6 [\ , 6 {."1 <. y
d=. '--#::' 2 6 11 14 17 }"1 [ 2 4 5 3 3 3 ": t
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
d=. ,((1 {"1 t) { mth) 3 4 5 }"1 d
d=. '0' (I. d=' ') } d
d=. ' ' (I. d='#') } d
(r,20) $ d
)
wdshiver=: 3 : 0
a=. wd 'qformx'
wd 'pmovex ', ": 0 0 1 0 + 0 ". a
wd 'pmovex ', a
)
getdir=: 3 : 0

r=. i.0 3
path=. y
ifsvn=. '.svn' -: _4 {. path
if. ifsvn do.
  fl=. 1!:0 path,TEXTBASE,'*'
  fl=. fl #~ (<'.svn-base') = _9 {. each {."1 fl
  path=. _4 }. path
  r=. r, (path&, each _9 }. each {."1 fl),.1 2{"1 fl
else.
  fl=. 1!:0 path,'*'
  if. #fl do.
    att=. > 4{"1 fl
    fl=. fl #~ ('h' ~: 1{"1 att) *. 'd' ~: 4{"1 att
  end.
  r=. r, (path&, each {."1 fl),.1 2{"1 fl
end.
if. DMSUBDIR do.
  dl=. 1!:0 path,'*'
  if. #dl do.
    att=. > 4{"1 dl
    dl=. dl #~ ('h' ~: 1{"1 att) *. 'd' = 4{"1 att
    dr=. {."1 dl
    dr=. dr -. DMTREEX
    if. #dr do.
      dr=. (path&, @ ,&(PATHSEP,ifsvn#'.svn')) each dr
      r=. r, ; getdir each dr
    end.
  end.
end.
if. #r do.
  r=. (dmlower L:0 {."1 r) 0 }"0 1 r
end.
if. -. (<,'*') e. DMX do.
  fls=. {."1 r
  ndx=. 1 + fls i: &> '.'
  msk=. (ndx }.each fls) e. DMX
  r=. msk # r
end.

sort r
)
DMDIRS=: 0 : 0
)

DMFAVORITES=: 0 : 0
)

DMLASTDIRS=: 0 : 0
)

DMSNAPS=: 0 : 0
)

DMSVNS=: 0 : 0
)

DMTYPE=: 'SourceText'

DMTYPEXTS=: 0 : 0
Scripts    ijs
Labs       ijt
Text       txt
SourceText ijs, ijt, txt
HTML       htm, html
Plaintext  htm, html, ijs, ijt, txt
All        *
)
FED=: 0 : 0
pc6j fed owner;
xywh 2 3 150 11;cc z0 static;cn "Directory Pairs:";
xywh 0 16 250 200;cc favedit editm ws_vscroll es_autohscroll rightmove bottommove;
xywh 202 2 44 12;cc cancel button leftmove rightmove;cn "Close";
pas 0 0;
rem form end;
)
fed_run=: 3 : 0
pos=. wd 'qformx'
wd FED
wd 'set favedit *',tolist }: , DMFAVORITES ,. a:
wd 'setfocus favedit'
wdcenter pos
wd 'pshow'
)
fedclose=: 3 : 0
dat=. a: -.~ <;._2 favedit, LF
if. 1 = 2 | #dat do.
  dminfo 'Favorites not in pairs. There are ',(":#dat),' directories'
  return.
end.
DMFAVORITES=: _2 ,\ dat
wd 'pclose;psel ',HWNDP
wd 'pactive'
)
fed_cancel_button=: fed_cancel=: fed_close=: fedclose
CELLALIGN=: 0
HDRCOL=: 'Source';'Target'
GRIDSORT=: 0
GRIDOPTS=: 'CELLDATA CELLALIGN GRIDSORT HDRCOL'
FAV=: 0 : 0
pc6j fav closeok owner;pn "dirs";
xywh 2 3 150 11;cc s0 static;cn "Directories:";
xywh 0 16 300 200;cc grid isigraph ws_border rightmove bottommove;
xywh 204 2 44 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 252 2 44 12;cc ok button bs_defpushbutton leftmove rightmove;cn "&OK";
pas 0 0;pcenter;
rem form end;
)
fav_run=: 3 : 0
CELLDATA=: DMFAVORITES
pos=. wd 'qformx'
wd FAV
wdfit ''
wdcenter pos
grid=: '' conew 'jsgrid'
show__grid GRIDOPTS
wd 'setfocus grid'
wd 'pshow;'
)
fav_gethilite=: 3 : 0
0 pick ({.CELLMARK__grid) { CELLDATA
)
favclose=: 3 : 0
destroy__grid''
wd 'psel fav;pclose'
)
fav_cancel_button=: fav_cancel=: fav_close=: favclose
formselect=: 3 : 'wd''psel '',formhwnd'
favorites=: 3 : 0
if. #DMFAVORITES do. fav_run'' end.
)
fav_do=: 3 : 0
row=. {. CELLMARK__grid
'src tar'=. deb each row { CELLDATA
if. -. (src;tar) -: source,target do.
  DMSOURCEFM=: src
  DMTARGET=: tar
  DMDIRS=: ~. dmlower each (src;tar), DMDIRS
  wd 'psel ',HWNDP
  dmshow''
end.
favclose''
)
fav_ok_button=: fav_enter=: fav_do
select_result=: fav_do
getfoundname1=: 3 : 0
if. isempty dat=. getnames '' do. '' return. end.
'prev name next'=. dat
if. isempty name do. '' return. end.
if. prev -: name do.
  DMTARGET joindirname name
elseif. name -: next do.
  getsourcename1 name
elseif. (<name) e. {."1 NOTINSOURCE do.
  DMTARGET joindirname name
elseif. (<name) e. {."1 NOTINTARGET do.
  getsourcename1 name
elseif. do.
  ''
end.
)
getfoundname2=: 3 : 0
if. isempty dat=. getnames '' do. '' return. end.
'prev name next'=. dat
if. prev -: name do.
  'first second'=. prev;name
elseif. name -: next do.
  'first second'=. name;next
elseif. do.
  '' return.
end.
(getsourcename1 first) ; DMTARGET joindirname second
)
getignorenames=: 3 : 0
dat=. getnames ''
if. isempty 1 pick dat do. '' return. end.
dat -. a:
)
getnames=: 3 : 0
if. 0=#found do. '' return. end.
pos=. {.".found_select
ind=. 0, I. found=LF
ndx=. (ind >: pos) i: 0
ndx=. ndx + 0 1 2
dat=. <;._2 found,LF
dat=. a: , dat , a:
if. 0 e. ndx e. i. # dat do. '' return. end.
res=. getname1 each ndx { dat
if. 0=#;res do. '' end.
)
joindirname=: 4 : 0
(fmtdir x), y
)
getname1=: 3 : 0
dat=. deb |. y
ndx=. I. dat = ' '
if. 2 < # ndx do.
  |. (1 + 2 { ndx) }. dat
else.
  ''
end.
)
remfound=: 3 : 0
fm=. <y
dms=. jpathsep DMSOURCE, PATHSEP

msk=. fm ~: dms&, each {."1 DIFFCONT
if. 0 e. msk do.
  DIFFCONT=: msk # DIFFCONT
  DIFFCONTST=: msk # DIFFCONTST
end.

msk=. fm ~: dms&, each {."1 DIFFTIME
if. 0 e. msk do.
  DIFFTIME=: msk # DIFFTIME
  DIFFTIMEST=: msk # DIFFTIMEST
end.

msk=. fm ~: dms&, each {."1 NOTINTARGET
if. 0 e. msk do.
  NOTINTARGET=: msk # NOTINTARGET
end.

match_fmt''
dmshowfind {: 0 ". found_scroll
)
match=: 3 : 0
dmread''
if. isempty DMSOURCE do.
  dminfo 'Enter the source directory' return.
end.
if. isempty DMTARGET do.
  dminfo 'Enter the target directory' return.
end.
DMDIRS=. ~. dmlower each (DMSOURCE;DMTARGET), DMDIRS
matches 0
DMMAXMSG=: 0
dmshowfind''
)
matches=: 3 : 0
DMFOUNDCONTENTS=: DMFOUNDALL=: ''
match_do ''
DMPACK=: pack DMPACKNAMES
match_fmt y
)
matchclear=: 3 : 0
DMFOUNDCONTENTS=: DMFOUNDALL=: ''
DMMAXMSG=: 0
dmshowfind''
)
match_do=: 3 : 0

NOTINSOURCE=: NOTINTARGET=: ''
DIFFTIME=: DIFFCONT=: i.0 6
DIFFTIMEST=: DIFFCONTST=: ''
DMX=: ' ,' cutopen (DMTYPES i. boxxopen DMTYPE) pick DMEXTS

src=. fmtdir DMSOURCE
tar=. fmtdir DMTARGET

dx=. getdir src, (DMTAB-:'svn') # '.svn'
dy=. getdir tar

fx=. {."1 dx
fy=. {."1 dy

fx=. (#src) }. each fx
fy=. (#tar) }. each fy
dx=. fx ,. }."1 dx
dy=. fy ,. }."1 dy
NOTINTARGET=: (-. fx e. fy) # dx
NOTINSOURCE=: (-. fy e. fx) # dy

dx=. (fx e. fy) # dx
dy=. (fy e. fx) # dy
dxy=. dx ,. dy

if. 0 e. #dx do. return. end.
msk=. (2 {"1 dx) ~: 2 {"1 dy
if. 1 e. msk do.
  DIFFCONT=: msk # dxy
  msk=. -. msk
  dx=. msk # dx
  dy=. msk # dy
  dxy=. msk # dxy
end.
nms=. {."1 dx

if. DMTAB-:'svn' do.
  snm=. addtextbase nms;src
else.
  snm=. src&, each nms
end.

cmp=. snm filecmp tar&, each nms
DIFFCONT=: sort DIFFCONT, (cmp = 0) # dxy
DIFFCONTST=: (1 {"1 DIFFCONT) earlier 4 {"1 DIFFCONT
if. DMTIMESTAMP do.
  dx=. cmp # dx
  dy=. cmp # dy
  dxy=. cmp # dxy
  msk=. -. dx e. dy
  if. 1 e. msk do.
    DIFFTIME=: msk # dxy
    DIFFTIMEST=: (1 {"1 DIFFTIME) earlier 4 {"1 DIFFTIME
  end.
end.
)
earlier=: 4 : 0
_2 </ \ /: /: , x ,. y
)
match_fmt=: 3 : 0

ignorens_do''
ignorent_do''
ignorest_do''

count=. {. y,1
DMFOUNDCONTENTS=: DMFOUNDALL=: ''

hit=. +/ (#DIFFCONT),(#DIFFTIME),(#NOTINSOURCE),#NOTINTARGET

if. 0 = hit do.
  dminfo count pick 'Contents match';'Contents now match'
  return.
end.

if. #DIFFCONT do.
  DMFOUNDCONTENTS=: 'different contents - source,target: ',LF,(tolist6 DIFFCONT),LF2
end.

txt=. ''
if. #NOTINSOURCE do.
  txt=. txt, 'not in source: ',LF,(tolist3 NOTINSOURCE),LF2
end.

if. #NOTINTARGET do.
  txt=. txt, 'not in target: ',LF,(tolist3 NOTINTARGET),LF2
end.

if. #DIFFTIME do.
  txt=. txt, 'different timestamp - source,target: ',LF,(tolist6 DIFFTIME),LF2
end.

DMFOUNDALL=: txt, DMFOUNDCONTENTS
)
match_reshow=: 3 : 0
if. 0=#DMPACK do. return. end.
DMMAXMSG=: 0
pdef DMPACK
match_fmt 0
dmshowfind''
)
getsourcename=: 3 : 0
if. (DMTAB-:'svn') do.
  y=. pathname &> y
  px=. < '.svn',TEXTBASE
  sx=. <'.svn-base'
  y=. ({."1 y) ,each px ,each ({:"1 y) ,each sx
end.
(<fmtdir DMSOURCE) ,each y
)
getsourcename1=: getsourcename&.<
PTOP=: 0
PSHOW=: 0
JDM=: 0 : 0
pc6j jdm;pn "Directory Match";
menupop "&File";
menu std "Source from Directory" "" "" "";
menu snp "Source from Snapshot" "" "" "";
menu svn "Source from Subversion" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Favorites";
menu select "&Select from favorites..." "" "" "";
menusep;
menu edit "&Edit favorites..." "" "" "";
menusep;
menu save "S&ave current files as favorites" "" "" "";
menupopz;
menupop "&View";
menu contents "&Contents only" "" "" "";
menusep;
menu mignorent "Ignore target files not in source" "" "" "";
menu mignorens "Ignore source files not in target" "" "" "";
menu mignorest "Ignore source files earlier than target" "" "" "";
menupopz;
menupop "&Compare";
menu mignoresep "&Detail compare ignores line separators" "" "" "";
menu mignoreltw "&Detail compare ignores leading and trailing whitespace" "" "" "";
menupopz;
menupop "&Tools";
menu swap "&Swap source and target directories" "" "" "";
menusep;
menu copyst "&Copy source files not in target" "" "" "";
menusep;
menu copylt "Copy source files &later than target" "" "" "";
menusep;
menu copyat "Copy &all source files" "" "" "";
menusep;
menu delts "&Delete target files not in source" "" "" "";
menusep;
menu print "&Print" "" "" "";
menupopz;
menupop "&Help";
menu help "&Help" "" "" "";
menupopz;
xywh 0 0 392 52;cc tabs static rightmove;
xywh 0 58 392 1;cc s1 staticbox ss_etchedhorz rightmove;
xywh 0 61 325 150;cc found editm ws_hscroll ws_vscroll rightmove bottommove;
xywh 330 61 60 12;cc compare button leftmove rightmove;cn "Co&mpare";
xywh 330 74 60 12;cc compareall button leftmove rightmove;cn "Compare &All";
xywh 330 87 60 12;cc xdiff button leftmove rightmove;cn "E&xternal Diff";
xywh 330 100 60 12;cc open button leftmove rightmove;cn "&Open";
xywh 330 113 60 12;cc view button leftmove rightmove;cn "&View";
xywh 330 126 60 12;cc copy button leftmove rightmove;cn "&Copy";
xywh 330 139 60 12;cc ignore button leftmove rightmove;cn "&Ignore";
xywh 330 195 60 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
xywh 352 199 40 12;cc hideme button leftmove topmove rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
dmrun=: 3 : 0
jdm_init''
if. wdishandle HWNDP do.
  wd 'psel ',HWNDP
  jdm_show''
  return.
end.

makecompare''
PSHOW=: 0
0!:0 :: ] <DMCFGFILE
dmgetglobals''
wd JDM
HWNDP=: wd 'qhwndp'
if. L. y do.
  'src tar'=. ": each 2 $ y
  DMSOURCEFM=: src
  DMTARGET=: tar
  DMDIRS=: ~. dmlower each (src;tar), DMDIRS
  index=. match=. 0
else.
  'index match'=. 2 {. y,0
end.
DMTABGROUPS=: ;: 'std snp svn'
DMTAB=: index pick DMTABGROUPS
DMTABID=: 'jdm', DMTAB
DMLOADED=: <DMTABID

wd 'setshow tabs 0'
wd 'creategroup tabs'
(DMTABID,'_run')~match
wd 'creategroup'
wd 'setshow ',DMTABID,' 1'
wd 'set mignoresep ',":IGNORESEP
wd 'set mignoreltw ',":IGNORELTW
wd 'set mignorent ',":IGNORENT
wd 'set mignorens ',":IGNORENS
wd 'set mignorest ',":IGNOREST
wd 'setshow hideme 0'
wd 'setfont found ',FIXFONT
wd :: ] 'picon ',PICON
dmshow''
enablefound 0
wpset 'jdm'
if. match -: 1 do.
  (DMTABID,'_match')~''
end.
jdm_show''
EMPTY
)
jdm_init=: 3 : 0
if. IFWIN do.
  dmlower=: tolower
else.
  dmlower=: ]
end.
if. 0=4!:0 <'DIRTREEX' do.
  DMTREEX=: boxxopen DIRTREEX
end.
EMPTY
)
jdm_show=: 3 : 0
if. -. PSHOW do.
  wd 'pshow;pactive;ptop ',":PTOP
  PSHOW=: 1
end.
)
jdm_btypes_button=: 3 : 0
(type;<DMTYPES,.DMEXTS) conew 'jfiletype'
)
jdm_contents_button=: 3 : 0
DMCONTENTS=: ". contents
dmshowfind''
)
jdm_close=: 3 : 0
dmread''
dmputconfig''
DMPACK=: ''
wpsave 'jdm'
wd 'psel ',HWNDP
wd 'pclose'
)
jdm_cancel=: jdm_cancel_button=: jdm_close
jdm_exit_button=: jdm_close
jdm_enter=: jdm_edir_button=: jdm_etype_button=: jdm_find_button
jdm_help_button=: 3 : 0
htmlhelp602 'user/directory_match.htm'
)
jdm_print_button=: 3 : 0
if. 0=#found do. dminfo 'Nothing to print'
else. prints found end.
)
dmread=: 3 : 0
DMCONTENTS=: 0 ". contents
)
jdm_swap=: 3 : 0
if. y -: DMTAB do. return. end.
dmlast=. DMTABID
DMTABID=: 'jdm', DMTAB=: y
if. -. DMTABID e. DMLOADED do.
  wd 'creategroup tabs'
  (DMTABID,'_run')~''
  wd 'creategroup'
end.
(DMTABID,'_show')~''
wdshiver''
wd 'setshow ',dmlast,' 0'
wd 'setshow ',DMTABID,' 1'
)

jdm_std_button=: jdm_swap bind 'std'
jdm_snp_button=: jdm_swap bind 'snp'
jdm_svn_button=: jdm_swap bind 'svn'
jdm_tctrl_fkey=: 3 : 0
PTOP=: ".ptop
wd 'ptop ',ptop
)
jdm_save_button=: 3 : 0
DMFAVORITES=: ~. DMFAVORITES, source ; target
dminfo 'Done.'
)
dmshow=: 3 : 0
DMALL=: cleanlist DMSOURCEFM;DMTARGET;DMDIRS
dup=. DMSOURCEFM -: DMTARGET
wd 'setenable swap ',": DMTAB -: 'std'
wd 'set contents ', ":DMCONTENTS
(DMTABID,'_show')~''
qd=. wd 'qd'
({."1 qd)=: {:"1 qd
)
dmshowfind=: 3 : 0
if. 0=#DMFOUNDALL do.
  wd 'set found'
  enablefound 0
  return.
end.
txt=. DMCONTENTS pick DMFOUNDALL;DMFOUNDCONTENTS
if. DMMAXMSG < DMMAXSIZE < #txt do.
  msg=. 'Found text is too large to display in full.'
  msg=. msg,LF,LF,'Save full text to file temp',PATHSEP,'dm.txt?'
  if. 0=2 dmquery msg do.
    txt 1!:2 <jpath '~temp/dm.txt'
  end.
  txt=. (DMMAXSIZE {. txt),'...'
end.
DMMAXMSG=: 1
enablefound 1
wd 'set found *',txt
if. #y do.
  y=. ": y <. 0 >. <: +/txt=LF
  wd 'setscroll found ',y
end.
)
jdm_compare_button=: comparefiles
jdm_compareall_button=: compareallfiles
jdm_edit_button=: fed_run
jdm_match_button=: match
jdm_open_button=: openfile
jdm_swap_button=: swapdirs
jdm_view_button=: viewfile
jdm_select_button=: favorites
jdm_copy_button=: copy1
jdm_copyat_button=: copyall
jdm_copylt_button=: copylater
jdm_copyst_button=: copysource
jdm_delts_button=: deletetarget
jdm_ignore_button=: ignore
jdm_mignoresep_button=: ignoresep
jdm_mignoreltw_button=: ignoreltw
jdm_mignorent_button=: ignorent
jdm_mignorens_button=: ignorens
jdm_mignorest_button=: ignorest
jdm_xdiff_button=: xdiff

jdm_source_button=: jdm_target_button=: jdm_type_button=: match
filetype_result=: 3 : 0
'type filters'=. y
DMTYPES=: {."1 filters
DMEXTS=: {:"1 filters
wd 'psel ',HWNDP
wd 'set type ',todelim DMTYPES
wd 'setselect type ',": DMTYPES i. <type
)
comparefiles=: 3 : 0
if. 0=#name=. getfoundname2'' do.
  dminfo 'Nothing to compare'
else.
  wdview fcompare name
end.
)
compareallfiles=: 3 : 0
nms=. {."1 DIFFCONT
res=. ''
for_n. nms do.
  src=. getsourcename1 > n
  tar=. (fmtdir DMTARGET), > n
  res=. res, fcompare src;tar
  res=. res, LF, LF
end.
res=. _2 }. res
if. 0=#res do.
  dminfo 'Nothing to compare'
else.
  wdview res
end.
)
xdiff=: 3 : 0
if. 0=#name=. getfoundname2'' do.
  dminfo 'Nothing to compare'
else.
  'a b'=. name
  wd 'winexec ',DEL,XDIFF,' "',a,'" "',b,'"',DEL
end.
)
copy1=: 3 : 0
if. isempty name=. getfoundname2'' do.
  name=. getfoundname1''
end.
if. isempty name do.
  txt=. 'No file selected'
  dminfo txt return.
end.

name=. boxopen name
if. 2 = #name do.
  'fm to'=. name
else.
  fm=. 0 pick name
  to=. (fmtdir DMTARGET), (#fmtdir DMSOURCE) }. fm
end.

fm=. jpathsep fm
to=. jpathsep to

svn=. (DMTAB-:'svn') # ' Subversion'
txt=. 'OK to copy from',svn,' source to target: ',LF,LF,fm

if. 0 = 0 dmquery txt do.
  res=. filecopy fm;to
  if. res = 0 do.
    txt=. 'Unable to copy file'
    dminfo txt
  else.
    if. DMTAB-:'svn' do.
      fsetrw to
    end.
    remfound fm
  end.
else.
  dminfo 'Not done'
end.
)
copyall=: 3 : 0
not=. {."1 NOTINTARGET
dif=. ({."1 DIFFCONT), {."1 DIFFTIME
fls=. not, dif
if. 0 = # fls do.
  dminfo 'No source files to copy' return.
end.
fm=. getsourcename fls
to=. (fmtdir DMTARGET)&, each fls
to docopy fm
)
copylater=: 3 : 0
dif=. DIFFCONT,DIFFTIME
msk=. (4 {"1 dif) earlier 1 {"1 dif
fls=. msk # {."1 dif
if. 0 = # fls do.
  dminfo 'No source files to copy' return.
end.
fm=. getsourcename fls
to=. (fmtdir DMTARGET)&, each fls
to docopy fm
)
copysource=: 3 : 0
if. 0 = # NOTINTARGET do.
  dminfo 'No source files to copy' return.
end.
fm=. getsourcename {."1 NOTINTARGET
to=. (fmtdir DMTARGET)&, each {."1 NOTINTARGET
to docopy fm
)
deletetarget=: 3 : 0
if. 0 = # NOTINSOURCE do.
  dminfo 'No target files to delete' return.
end.
nms=. (fmtdir DMTARGET)&, each {."1 NOTINSOURCE
if. 0 = 0 dmquery 'OK to delete:',LF,LF,tolist nms do.
  ferase nms
  match''
end.
)
docopy=: 4 : 0
to=. x
fm=. y
if. 0 = 0 dmquery 'OK to copy:',LF,LF,tolist fm do.
  res=. filecopy"1 fm ,. to
  if. 0 e. res do.
    txt=. 'Unable to copy:',LF,LF,tolist (res=0)#fm
    dminfo txt
  end.
  if. 1 e. res do.
    match''
  end.
else.
  dminfo 'Not done'
end.
)
enablefound=: 3 : 0
f=. <' ',": y
hit=. (#DIFFCONT),(#DIFFTIME),(#NOTINSOURCE),#NOTINTARGET
nms=. 'copy ignore found open view print xdiff'
if. y = 0 do.
  nms=. ;: nms , ' compare compareall contents copyat copylt copyst delts'
  cmd=. nms ,each f
else.
  cmd=. (;: nms) ,each f
  dd=. (#DIFFCONT) + #DIFFTIME
  cmd=. cmd, <'compare ',": 0 < dd
  cmd=. cmd, <'compareall ',": 0 < dd
  cmd=. cmd, <'contents ',": (0 < 0 { hit) *. 0 < +/ }. hit
  cmd=. cmd, <'copyat ',": 0 < (#NOTINTARGET) + dd
  cmd=. cmd, <'copylt ',": 0 < (#NOTINTARGET) + 0 e. DIFFTIMEST, DIFFCONTST
  cmd=. cmd, <'copyst ',": 0 < #NOTINTARGET
  cmd=. cmd, <'delts ',": 0 < #NOTINSOURCE
  cmd=. cmd, <'xdiff ',": (*#XDIFF) *. 0 < dd
end.
wd }. ; ';setenable '&, each cmd
)
ignore=: 3 : 0
nms=. getignorenames''
if. isempty nms do.
  dminfo 'No file selected' return.
end.

msk=. -. ({."1 DIFFCONT) e. nms
DIFFCONT=: msk # DIFFCONT
DIFFCONTST=: msk # DIFFCONTST

msk=. -. ({."1 DIFFTIME) e. nms
DIFFTIME=: msk # DIFFTIME
DIFFTIMEST=: msk # DIFFTIMEST

NOTINSOURCE=: nms ignore1 NOTINSOURCE
NOTINTARGET=: nms ignore1 NOTINTARGET
match_fmt''
dmshowfind''
)
ignore1=: 4 : 0
y #~ -. ({."1 y) e. x
)
ignoreltw=: 3 : 0
IGNORELTW=: -. IGNORELTW
wd 'set mignoreltw ',":IGNORELTW
makecompare''
i.0 0
)
ignorens=: 3 : 0
IGNORENS=: -. IGNORENS
match_reshow''
)
ignorens_do=: 3 : 0
if. IGNORENS do.
  NOTINTARGET=: 0 # NOTINTARGET
end.
)
ignorent=: 3 : 0
IGNORENT=: -. IGNORENT
match_reshow''
)
ignorent_do=: 3 : 0
if. IGNORENT do.
  NOTINSOURCE=: 0 # NOTINSOURCE
end.
)
ignoresep=: 3 : 0
IGNORESEP=: -. IGNORESEP
wd 'set mignoresep ',":IGNORESEP
makecompare''
i.0 0
)
ignorest=: 3 : 0
IGNOREST=: -. IGNOREST
match_reshow''
)
ignorest_do=: 3 : 0
if. -. IGNOREST do. return. end.
if. -. 1 e. DIFFCONTST, DIFFTIMEST do. return. end.
if. #DIFFCONT do.
  DIFFCONT=: (-. DIFFCONTST) # DIFFCONT
  DIFFCONTST=: (#DIFFCONT) $ 0
end.
if. #DIFFTIME do.
  DIFFTIME=: (-. DIFFTIMEST) # DIFFTIME
  DIFFTIMEST=: (#DIFFTIME) $ 0
end.
)
openfile=: 3 : 0
if. 0=#name=. getfoundname1'' do.
  dminfo 'No file selected'
else.
  try.
    smopen_jijs_ name
    smfocus_jijs_ ''

  catch. dminfo 'Unable to open: ',name
  end.
end.
)
swapdirs=: 3 : 0
dmread''
'DMSOURCEFM DMTARGET'=: DMTARGET ; DMSOURCEFM
if. #DMFOUNDALL do.
  'NOTINSOURCE NOTINTARGET'=: NOTINTARGET ;< NOTINSOURCE
  DIFFCONT=: 3 4 5 0 1 2 {"1 DIFFCONT
  DIFFTIME=: 3 4 5 0 1 2 {"1 DIFFTIME
  match_fmt''
end.
dmshow''
dmshowfind''
)
viewfile=: 3 : 0
if. 0=#name=. getfoundname1'' do.
  dminfo 'No file selected'
else.
  dat=. 1!:1 :: _1: < name
  if. dat -: _1 do.
    dminfo 'Unable to view: ',name
  else.
    name wdview dat
  end.
end.
)
view_result=: 3 : 0
wd 'psel ',HWNDP
wd 'setfocus found'
)
JDMSNP=: 0 : 0
pc6j jdmsnp;
xywh 4 6 30 11;cc s21 static;cn "Project:";
xywh 35 5 167 150;cc pproject combodrop ws_vscroll cbs_autohscroll rightmove;
xywh 206 7 10 9;cc bpproject button leftmove rightmove;cn ">>";
xywh 4 21 30 11;cc s22 static;cn "Source:";
xywh 35 20 167 150;cc psource combolist ws_vscroll cbs_autohscroll rightmove;
xywh 4 36 30 11;cc s23 static;cn "Target:";
xywh 35 35 167 150;cc ptarget combolist ws_vscroll rightmove;
xywh 223 6 102 10;cc ptimestamp checkbox leftmove rightmove;cn "Compare timestamps";
xywh 223 17 102 10;cc psubdir checkbox leftmove rightmove;cn "Include subdirectories";
xywh 328 4 60 12;cc pmatch button leftmove rightmove;cn "Match";
pas 0 0;pcenter;
rem form end;
)
jdmsnp_run=: 3 : 0
wd JDMSNP
)
jdmsnp_bpproject_button=: 3 : 0
dir=. 0 pick DMSNAPS,<jpath '~home'
j=. '"Project Files (*.jproj *.ijp)|*.jproj;*.ijp"'
f=. mbopen '"Select Project" "',dir,'" "" ',j
if. 0 = #f do. return. end.
if. 0 = fexist f do. return. end.
DMSNAPS=: cleanlist (<f),DMSNAPS
dmshow''
matchclear''
)
jdmsnp_pproject_select=: 3 : 0
DMSNAPS=: cleanlist (<pproject), DMSNAPS
jdmsnp_show''
)
jdmsnp_match=: 3 : 0
jdmsnp_read''
match''
)

jdmsnp_pmatch_button=: jdmsnp_match
jdmsnp_pproject_button=: jdmsnp_match
jdmsnp_psource_button=: jdmsnp_match
jdmsnp_read=: 3 : 0
DMSNAPS=: cleanlist (<pproject),DMSNAPS
path=. 0 pick pathname pproject
DMSOURCEFM=: path,'.snp',PATHSEP,psource
if. ptarget -: 'Current' do.
  DMTARGET=: path
else.
  DMTARGET=: path,'.snp',PATHSEP,ptarget
end.
DMSOURCE=: DMSOURCEFM
DMTIMESTAMP=: 0 ". ptimestamp
DMTYPE=: 'All'
DMSUBDIR=: 0
)
jdmsnp_show=: 3 : 0
requireproject''
jdmsnp_getfiles''
wd 'set std 0;set snp 1;set svn 0'
wd 'set pproject ',todelim DMSNAPS
wd 'setselect pproject ',": (0<#DMSNAPS){_1 0
wd 'set psource ',todelim PJSOURCES
wd 'setselect psource ',":PJSOURCES dmindex <PJSOURCE
wd 'set ptarget ',todelim PJTARGETS
wd 'setselect ptarget ',":PJTARGETS dmindex <PJTARGET
wd 'set ptimestamp ',":DMTIMESTAMP
wd 'set psubdir 0;setenable psubdir 0'
wd 'setfocus pmatch'
)
jdmsnp_getfiles=: 3 : 0
if. isempty DMSNAPS do.
  PJSOURCES=: PJTARGETS=: PJSOURCE=: PJTARGET=: '' return.
end.
path=. 0 pick pathname 0 pick DMSNAPS
PJSOURCES=: ss_list_jnproject_ termBS path
PJSOURCES=: PJSOURCES, ss_list_jproject_ termBS path
PJTARGETS=: (<'Current'),PJSOURCES
PJSOURCE=: >{. (PJSOURCES intersect <PJSOURCE), PJSOURCES
PJTARGET=: >{. (PJTARGETS intersect <PJTARGET), PJTARGETS
)
JDMSTD=: 0 : 0
pc6j jdmstd;
xywh 4 6 30 11;cc s0 static;cn "Source:";
xywh 35 5 167 150;cc source combodrop ws_vscroll cbs_autohscroll rightmove;
xywh 4 21 30 11;cc s1 static;cn "Target";
xywh 35 20 167 150;cc target combodrop ws_vscroll cbs_autohscroll rightmove;
xywh 4 36 30 11;cc s2 static;cn "Type:";
xywh 35 35 147 150;cc type combolist ws_vscroll cbs_autohscroll rightmove;
xywh 206 7 10 9;cc bsource button leftmove rightmove;cn ">>";
xywh 206 21 10 9;cc btarget button leftmove rightmove;cn ">>";
xywh 185 37 10 9;cc btypes button leftmove rightmove;cn ">>";
xywh 223 6 102 10;cc timestamp checkbox leftmove rightmove;cn "Compare timestamps";
xywh 223 17 102 10;cc subdir checkbox leftmove rightmove;cn "Include subdirectories";
xywh 328 4 60 12;cc match button leftmove rightmove;cn "Match";
pas 0 0;pcenter;
rem form end;
)
jdmstd_run=: 3 : 0
wd dmfixunix JDMSTD
)
jdmstd_btypes_button=: 3 : 0
(type;<DMTYPES,.DMEXTS) conew 'jfiletype'
)
jdmstd_bsource_button=: 3 : 0
dir=. DMSOURCE,(0=#DMSOURCE)#jpath '~home'
txt=. dmlower mbdir 'Select Folder';dir;0
if. (#txt) > txt -: dmlower source do.
  DMSOURCE=: txt
  DMDIRS=: ~. (<txt), DMDIRS
  dmshow''
  matchclear''
end.
)
jdmstd_btarget_button=: 3 : 0
dir=. DMTARGET,(0=#DMTARGET)#jpath '~home'
txt=. dmlower mbdir 'Select Folder';dir;0
if. (#txt) > txt -: dmlower target do.
  DMTARGET=: txt
  DMDIRS=: ~. (<txt), DMDIRS
  dmshow''
  matchclear''
end.
)
jdmstd_match=: 3 : 0
jdmstd_read''
match''
)

jdmstd_match_button=: jdmstd_match
jdmstd_source_button=: jdmstd_match
jdmstd_target_button=: jdmstd_match
jdmstd_read=: 3 : 0
DMSOURCEFM=: (0 < #source) # fullname source
DMTARGET=: (0 < #target) # fullname target
DMLASTDIRS=: DMSOURCEFM;DMTARGET
DMSOURCE=: (DMTAB-:'svn') pick DMSOURCEFM;DMTARGET
DMTIMESTAMP=: 0 ". timestamp
DMTYPE=: type
DMSUBDIR=: 0 ". subdir
)
jdmstd_show=: 3 : 0
txt=. todelim DMALL
wd 'set std 1;set snp 0;set svn 0'
wd 'set source ',txt
wd 'set target ',txt
if. 0 < # DMALL do.
  wd 'setselect source 0'
end.
if. 1 < # DMALL do.
  wd 'setselect target 1'
end.
wd 'set type ',todelim DMTYPES
wd 'setselect type ',": (#DMTYPES) | DMTYPES i. <DMTYPE
wd 'set timestamp ',":DMTIMESTAMP
wd 'set subdir ', ":DMSUBDIR
wd 'setfocus match'
)
JDMSVN=: 0 : 0
pc6j jdmsvn;
xywh 4 6 171 11;cc s10 static;cn "Source from Subversion";
xywh 4 21 30 11;cc s11 static;cn "Target";
xywh 35 20 167 150;cc vtarget combodrop ws_vscroll cbs_autohscroll rightmove;
xywh 4 36 30 11;cc s12 static;cn "Type:";
xywh 35 35 147 150;cc vtype combolist ws_vscroll cbs_autohscroll rightmove;
xywh 206 21 10 9;cc bvtarget button leftmove rightmove;cn ">>";
xywh 185 37 10 9;cc bvtypes button leftmove rightmove;cn ">>";
xywh 223 6 102 10;cc vtimestamp checkbox leftmove rightmove;cn "Compare timestamps";
xywh 223 17 102 10;cc vsubdir checkbox leftmove rightmove;cn "Include subdirectories";
xywh 328 4 60 12;cc vmatch button leftmove rightmove;cn "Match";
pas 0 0;pcenter;
rem form end;
)
jdmsvn_run=: 3 : 0
wd dmfixunix JDMSVN
)
jdmsvn_bvtypes_button=: 3 : 0
(type;<DMTYPES,.DMEXTS) conew 'jfiletype'
)
jdmsvn_bvtarget_button=: 3 : 0
dir=. 0 pick DMSVNS,<jpath '~home'
txt=. dmlower mbdir 'Select Folder';dir;0
if. (#txt) > txt -: dmlower vtarget do.
  DMSVNS=: cleanlist (<txt), DMSVNS
  dmshow''
  matchclear''
end.
)
jdmsvn_match=: 3 : 0
jdmsvn_read''
match''
)

jdmsvn_vmatch_button=: jdmsvn_match
jdmsvn_vtarget_button=: jdmsvn_match
jdmsvn_vtype_button=: jdmsvn_match
jdmsvn_read=: 3 : 0
DMTARGET=: (0 < #vtarget) # fullname vtarget
DMSOURCE=: DMTARGET
DMSVNS=: cleanlist (<DMTARGET),DMSVNS
DMTIMESTAMP=: 0 ". vtimestamp
DMTYPE=: vtype
DMSUBDIR=: 0 ". vsubdir
)
jdmsvn_show=: 3 : 0
wd 'set std 0;set snp 0;set svn 1'
wd 'set vtarget ',todelim DMSVNS
if. # DMSVNS do.
  wd 'setselect vtarget 0'
end.
wd 'set vtype ',todelim DMTYPES
wd 'setselect vtype ',": (#DMTYPES) | DMTYPES i. <DMTYPE
wd 'set vtimestamp ',":DMTIMESTAMP
wd 'set vsubdir ', ":DMSUBDIR
wd 'setfocus vmatch'
)
dirmatch_z_=: dmrun_jdirmatch_
