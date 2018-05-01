coclass 'jpacman'
USEGRID=: -.IFJNET
require^:USEGRID 'jzgrid'
coinsert 'jgl2 j'

agrid=: ''
HWNDP=: ''
AHWNDC=: ''
LOGTXT=: ''
ONLINE=: 0
SYSNAME=: 'Package Manager'
WWWREV=: REV=: _1
TIMEOUT=: 60
3 : 0''
if. IFUNIX do.
  if. UNAME-:'Darwin' do.
    HTTPCMD=: 'curl -o %O --stderr %L -f -s -S %U'
  else.
    HTTPCMD=: 'wget -O %O -o %L -t %t %U'
  end.
else.
  if. fexist t=. jpath '~tools/ftp/wget.exe' do.
    HTTPCMD=: '"',t,'" -O %O -o %L -t %t -T %T %U'
  else.
    HTTPCMD=: 'wget.exe -O %O -o %L -t %t -T %T %U'
  end.
  if. fexist t=. jpath '~tools/zip/unzip.exe' do.
    UNZIP=: '"',t,'" -o -C '
  else.
    UNZIP=: 'unzip.exe -o -C '
  end.
end.
)
setfiles=: 3 : 0
ADDCFG=: jpath '~addons/config',PATHSEP
makedir ADDCFG
ADDCFGIJS=: ADDCFG,'config.ijs'
if. 0: ~: 4!:0 @ < 'JLIB' do.
  JRELEASE=: ({.~i.&'/') 9!:14''
else.
  JRELEASE=: 'j','.'-.~({.~i:&'.') JLIB
end.
LIBTREE=: readtree''
WWW=: 'http://www.jsoftware.com/jal/',JRELEASE,'/'
LIBVER=: jpath '~system/config/version.txt'
)
destroy=: 3 : 0
if. #agrid do. destroy__agrid'' end.
if. #HWNDP do.
  try.
    wd 'psel ',HWNDP
    wpsave 'pmview'
    wd 'pclose'
  catch. end.
end.
codestroy''
)
EMPTY=: i. 0 0
LF2=: LF,LF

CFGFILES=: <;._2 (0 : 0)
addons.txt
library.txt
release.txt
revision.txt
zips.txt
)
LIBDESC=: 0 : 0
This is the base library of scripts and labs included in the J system.

Reinstalling or upgrading this library will overwrite files in the system subdirectory. Restart J afterwards.

Files outside the system subdirectory, such as profile.ijs, are not changed.
)
cutjal=: ([: (* 4 > +/\) ' ' = ]) <;._1 ]
cutjsp=: ([: (* 5 > +/\) ' ' = ]) <;._1 ]
dquote=: '"'&, @ (,&'"')
dtb=: #~ ([: +./\. ' '&~:)
fname=: #~ ([: *./\. ~:&'/')
hostcmd=: [: 2!:0 '(' , ] , ' || true)'"_
ischar=: 2 = 3!:0
rnd=: [ * [: <. 0.5 + %~
sep2under=: '/' & (I.@('_' = ])})
termLF=: , (0 < #) # LF -. {:
todel=: ; @: (DEL&, @ (,&DEL) each)
tolist=: }. @ ; @: (LF&,@,@":each)
isjpkgout=: ((4 = {:) *. 2 = #)@$ *. 1 = L.
getintro=: ('...' ,~ -&3@[ {. ])^:(<#)

isgui=: 3 : '0 < # HWNDP'
info=: smoutput`(wdinfo@(SYSNAME&;))@.isgui
query=: wdquery SYSNAME&;
getnames=: 3 : 0
y=. ,y
if. 0=L.y do.
  if. +/ BASELIB E. y do.
    y=. (<BASELIB), cutnames y rplc BASELIB;''
  else.
    y=. cutnames y
  end.
end.
y
)
curtailcaption=: 3 : 0
idx=. <_1;~I. 45<#&>{:"1 y
y=. (45&getintro &.> idx{y) idx}y
)
deltree=: 3 : 0
try.
  res=. 0< ferase {."1 dirtree y
  *./ res,0<ferase |.dirpath y
catch. 0 end.
)
fixjal=: 3 : 0
if. 2 > #y do. i.0 5 return. end.
m=. _2 |. (LF,')',LF) E. y
r=. _2 }. each m <;._2 y
x=. r i.&> LF
d=. (x+1) }.each r
r=. x {.each r
r=. 3 {."1 cutjal &> ' ' ,each r
x=. d i.&> LF
c=. x {.each d
d=. (x+1) }.each d
r,.c,.d
)
fixjal2=: 3 : 0
if. 2 > #y do. i.0 2 return. end.
cutjal &> ' ' ,each <;._2 y
)
fixjsp=: 3 : 0
if. 2 > #y do. i.0 5 return. end.
m=. _2 |. (LF,')',LF) E. y
r=. _2 }. each m <;._2 y
x=. r i.&> LF
d=. (x+1) }.each r
r=. x {.each r
r=. ' ' ,each r
(cutjsp &> r),.d
)
fixlib=: 3 : 0
msk=. (<LIBTREE) = 1 {"1 y
if. -. 1 e. msk do. ($0);'';0 return. end.
'ver fln siz'=. 2 4 5 { (msk i.1) { y
ver=. fixver ver
ver;fln;siz
)
fixlibs=: 3 : 0
if. 2 > #y do.
  i.0 6 return.
end.
fls=. <;._2 y
ndx=. fls i.&> ' '
siz=. <&> 0 ". (ndx+1) }.&> fls
fls=. ndx {.each fls
zps=. <;._2 &> fls ,each '_'
pfm=. 3 {"1 zps
msk=. IFUNIX ~: (1 e. 'win'&E.) &> pfm
msk # zps,.fls,.siz
)
fixrev=: 3 : 0
{. _1 ". :: _1: y -. CRLF
)
fixupd=: 3 : 0
_1 ". :: _1: y -. CRLF
)
fixver=: 3 : 0
if. ischar y do.
  y=. y -. CRLF
  y=. 0 ". ' ' (I. y='.') } y
end.
3 {. y
)
fixvers=: 3 : 0
s=. $y
y=. ,y
3 {."1 [ 0 ". s $ ' ' (I. y e. './') } y
)
fmtjal=: 3 : 0
if. 0 = #y do. '' return. end.
r=. (4 {."1 y) ,each "1 '  ',LF2
r=. <@; "1 r
; r ,each ({:"1 y) ,each <')',LF
)
fmtjal2=: 3 : 0
if. 0 = #y do. '' return. end.
; (2 {."1 y) ,each "1 ' ',LF
)
fmtdep=: 3 : 0
}. ; ',' ,each a: -.~ <;._2 y
)
fmtjsp=: 3 : 0
if. 0 = #y do. '' return. end.
r=. (4 {."1 y) ,each "1 '   ',LF
r=. <@; "1 r
; r ,each ({:"1 y) ,each <')',LF
)
fmtlib=: 3 : 0
, 'q<.>,q<.>r<0>3.0,r<0>3.0' 8!:2 y
)
fmtver=: 3 : 0
if. 0=#y do. '' return. end.
if. ischar y do. y return. end.
}. ; '.' ,each ": each y
)
fmtverlib=: 3 : 0
fmtver y
)
fixzips=: 3 : 0
if. 2 > #y do. i.0 5 return. end.
fls=. <;._2 y
ndx=. fls i.&> ' '
siz=. 0 ". (ndx+1) }.&> fls
fls=. ndx {.each fls
zps=. <;._2 &> fls ,each '_'
zps=. zps,.fls,.<&>siz
pfm=. 3 {"1 zps
lnx=. (1 e. 'linux'&E.) &> pfm
mac=. (1 e. 'darwin'&E.) &> pfm
win=. mac < (1 e. 'win'&E.) &> pfm

select. UNAME
case. 'Win' do.
  zps=. win # zps
case. 'Linux' do.
  zps=. lnx # zps
case. 'Darwin' do.
  zps=. (lnx +. mac) # zps
  zps=. zps /: 3 {"1 zps
  zps=. (~: 3 {."1 zps) # zps
end.

bit=. IF64 pick '64';'32'
pfm=. 3 {"1 zps
exc=. (1 e. bit&E.) &> pfm
zps=. zps \: exc
zps=. (~: 3 {."1 zps) # zps
fnm=. 0 {"1 zps
lnm=. 1 {"1 zps
ver=. 2 {"1 zps
pfm=. 3 {"1 zps
fls=. 4 {"1 zps
siz=. 5 {"1 zps
nms=. fnm ,each '/' ,each lnm
pfm=. (pfm i.&> '.') {.each pfm
ndx=. \: # &> pfm
sort ndx { nms,.pfm,.ver,.fls,.siz
)
fwritenew=: 4 : 0
if. x -: fread y do.
  0
else.
  x fwrite y
end.
)
platformparent=: 3 : 0
((< _2 {. y) e. '32';'64') # _2 }. y
)
makedir=: 1!:5 :: 0: @ <
plural=: 4 : 0
y,(1=x)#'s'
)
sizefmt=: 3 : 0
select. +/ y >: 1e3 1e4 1e6 1e7 1e9
case. 0 do.
  (": y), ' byte',(y~:1)#'s'
case. 1 do.
  (": 0.1 rnd y%1e3),' KB'
case. 2 do.
  (": 1 rnd y%1e3),' KB'
case. 3 do.
  (": 0.1 rnd y%1e6),' MB'
case. 4 do.
  (": 1 rnd y%1e6),' MB'
case. do.
  (": 0.1 rnd y%1e9),' GB'
end.
)
shellcmd=: 3 : 0
if. IFUNIX do.
  hostcmd y
else.
  spawn_jtask_ y
end.
)
subdir=: 3 : 0
if. 0=#y do. '' return. end.
a=. 1!:0 y,'*'
if. 0=#a do. '' return. end.
a=. a #~ '-d' -:"1 [ 1 4 {"1 > 4 {"1 a
(<y) ,each ({."1 a) ,each '/'
)
testaccess=: 3 : 0
f=. <jpath'~install/testaccess.txt'
try.
  '' 1!:2 f
  1!:55 f
  1
catch.
  0
end.
)
toupper1=: 3 : 0
if. 0=#y do. '' return. end.
(toupper {. y),tolower }. y
)
unzip=: 3 : 0
'file dir'=. dquote each y
e=. 'Unexpected unzip error'
if. IFUNIX do.
  notarcmd=. IFIOS
  if. UNAME-:'Android' do.
    notarcmd=. _1-: 2!:0 ::_1: 'which tar 2>/dev/null'
    if. (UNAME-:'Android') > '/mnt/sdcard'-:2!:5'EXTERNAL_STORAGE' do. notarcmd=. 1 end.
  end.
  if. notarcmd do.
    require 'tar'
    'file dir'=. y
    if. (i.0 0) -: tar 'x';file;dir do. e=. '' end.
  else.
    e=. shellcmd 'tar ',((IFIOS+:UNAME-:'Android')#(('Darwin'-:UNAME){::'--no-same-owner --no-same-permissions';'-o -p')),' -xzf ',file,' -C ',dir
  end.
  if. ('/usr/'-:5{.dir) *. ('root'-:2!:5'USER') +. (<2!:5'HOME') e. 0;'/var/root';'/root';'';,'/' do.
    shellcmd ::0: 'find ',dir,' -type d -exec chmod a+rx {} \+'
    shellcmd ::0: 'find ',dir,' -type f -exec chmod a+r {} \+'
  end.
else.
  dir=. (_2&}. , '/' -.~ _2&{.) dir
  e=. shellcmd UNZIP,' ',file,' -d ',dir
end.
e
)
zipext=: 3 : 0
y, IFUNIX pick '.zip';'.tar.gz'
)
toDEL=: [: ; (DEL&, @ (,&DEL)) each
CHECKADDONSDIR=: 0 : 0
The addons directory does not exist and cannot be created.

It is set to: XX.

You can either create the directory manually, or set a new addons directory in your profile script.
)
CHECKASK=: 0 : 0
Read catalog from the server using Internet connection now?

Otherwise the local catalog is used offline.
)
CHECKONLINE=: 0 : 0
An active Internet connection is needed to install packages.

Continue only if you have an active Internet connection.

OK to continue?
)
CHECKREADSVR=: 0 : 0
An active Internet connection is needed to read the server repository catalog.

Continue only if you have an active Internet connection.

OK to continue?
)
CHECKSTARTUP=: 0 : 0
Setup repository using Internet connection now?

Select No if not connected, to complete setup later. After Setup is done, repository can be used offline with more options in Tools menu and Preferences dialog.
)
checkaccess=: 3 : 0
if. testaccess'' do. 1 return. end.
msg=. 'Unable to run Package Manager, as you do not have access to the installation folder.'
if. IFWIN do.
  msg=. msg,LF,LF,'To run as Administrator, right-click the J icon, select Run as... and '
  msg=. msg,'then select Adminstrator.'
end.
info msg
0
)
checkaddonsdir=: 3 : 0
d=. jpath '~addons'
if. # 1!:0 d do. 1 return. end.
if. 1!:5 :: 0: <d do.
  log 'Created addons directory: ',d
  1 return.
end.
info CHECKADDONSDIR rplc 'XX';d
0
)
getonline=: 3 : 0
ONLINE=: 0 = 2 wdquery y
)
getserver=: 3 : 0
'rc p'=. httpgetr (WWW,'revision.txt');2
if. rc do. 0 return. end.
write_lastupdate''
WWWREV=: fixrev p
if. WWWREV = REV do. 1 return. end.
refreshweb''
)
checkonline=: 3 : 0
select. READCATALOG
case. 0 do.
  if. REV >: 0 do.
    ONLINE=: 0
    log 'Using local copy of catalog. See Preferences to change the setting.'
    1 return.
  end.
  if. 0 = getonline 'Read Catalog from Server';CHECKREADSVR do. 0 return. end.
case. 1 do.
  ONLINE=: 1
case. 2 do.
  if. REV >: 0 do.
    if. 0 = getonline 'Read Catalog from Server';CHECKASK do.
      log 'Using local copy of catalog. See Preferences to change the setting.'
      1 return.
    end.
  else.
    if. 0 = getonline 'Setup Repository';CHECKSTARTUP do. 0 return. end.
  end.
end.
log 'Updating server catalog...'
if. 0 = getserver'' do.
  ONLINE=: 0
  log 'Working offline using local copy of catalog.'
else.
  log 'Done.'
end.
1
)
checkstatus=: 3 : 0
if. 0 e. #LIBS do. '' return. end.
msk=. masklib PKGDATA
ups=. pkgups''
libupm=. 1 e. msk *. ups
msk=. -. msk
addnim=. +/msk *. pkgnew''
addupm=. +/msk *. pkgups''
tot=. +/addnim,addupm,libupm
if. 0 = tot do.
  'All available packages are installed and up to date.' return.
end.
select. 0 < addnim,addupm
case. 0 0 do.
  msg=. 'Addons are up to date.'
case. 0 1 do.
  msg=. 'All addons are installed, ',(":addupm), ' can be upgraded.'
case. 1 0 do.
  if. addnim = <:#PKGDATA do.
    msg=. 'No addons are installed.'
  else.
    j=. ' addon',('s'#~1<addnim),' are not yet installed.'
    msg=. 'Installed addons are up to date, ',(":addnim),j
  end.
case. 1 1 do.
  j=. (":addupm),' addon',('s'#~1<addupm),' can be upgraded, '
  msg=. j,(":addnim), ' addon',('s'#~1<addnim),' are not yet installed.'
end.
if. 0 = libupm do.
  msg,LF,'The base library is up to date.'
else.
  msg,LF,'There is a newer version of the base library.'
end.
)

write_lastupdate=: 3 : 0
txt=. ": 6!:0 ''
txt fwrites ADDCFG,'lastupdate.txt'
)
checklastupdate=: 3 : 0
if. _1 -: LASTUPD do.
  res=. 'has never been updated.'
else.
  res=. 'was last updated: ',timestamp LASTUPD
end.
'Local JAL information ',res
)
PACMANCFG=: jpath '~config/pacmancfg.ijs'

PACMANCFGHDR=: 0 : 0
)
readconfig=: 3 : 0
READCATALOG=: 2
TEXTFONT=: FIXFONT_z_
0!:0 :: ] <PACMANCFG
)
writeconfig=: 3 : 0
r=. PACMANCFGHDR
r=. r,'TEXTFONT=: ''',TEXTFONT,'''',LF
r=. r,'READCATALOG=: ',(":READCATALOG),LF
r 1!:2 :: ] <PACMANCFG
)
httpget=: 3 : 0
'f t'=. 2 {. (boxxopen y),a:
n=. f #~ -. +./\. f e. '=/'
p=. jpath '~temp/',n
q=. jpath '~temp/httpget.log'
t=. ":{.t,3
ferase p;q
fail=. 0
cmd=. HTTPCMD rplc '%O';(dquote p);'%L';(dquote q);'%t';t;'%T';(":TIMEOUT);'%U';f
try.
  fail=. _1-: e=. shellcmd cmd
catch. fail=. 1 end.
if. fail +. 0 >: fsize p do.
  if. _1-:msg=. freads q do.
    if. (_1-:msg) +. 0=#msg=. e do. msg=. 'Unexpected error' end. end.
  log 'Connection failed: ',msg
  info 'Connection failed:',LF2,msg
  r=. 1;msg
  ferase p;q
else.
  r=. 0;p
  ferase q
end.
r
)
httpgetr=: 3 : 0
res=. httpget y
if. 0 = 0 pick res do.
  f=. 1 pick res
  txt=. freads f
  ferase f
  0;txt
end.
)
install=: 3 : 0
dat=. y
'num siz'=. pmview_applycounts dat
many=. 1 < num
msg=. 'Installing ',(":num),' package',many#'s'
msg=. msg,' of ',(many#'total '),'size ',sizefmt siz
log msg
installdo 1 {"1 dat
log 'Done.'
readlocal''
pacman_init 0
)
install_console=: 3 : 0
if. -. init_console 'server' do. '' return. end.
pkgs=. getnames y
pkgs=. pkgs (e. # [) 1{"1 PKGDATA
if. 0 = num=. #pkgs do. '' return. end.
many=. 1 < num
msg=. 'Installing ',(":num),' package',many#'s'
log msg
installdo pkgs
log 'Done.'
readlocal''
pacman_init ''
checkstatus''
)
upgrade_console=: 3 : 0
if. -. init_console 'read' do. '' return. end.
if. 0=#pkgs=. getnames y do. pkgs=. 1{"1 PKGDATA end.
pkgs=. pkgs (e. # [) (pkgups # 1&{"1@])PKGDATA
install_console pkgs
)
installdo=: 3 : 0
msk=. -. y e. <BASELIB
if. 0 e. msk do.
  install_library''
end.
install_addon each msk # y
)
install_addon=: 3 : 0
ndx=. ({."1 ZIPS) i. <y
if. ndx = #ZIPS do. EMPTY return. end.
log 'Downloading ',y,'...'
f=. 3 pick ndx { ZIPS
'rc p'=. httpget WWW,'addons/',f
if. rc do. return. end.
log 'Installing ',y,'...'
msg=. unzip p;jpath'~addons'
ferase p
if. 0>:fsize jpath'~addons/',y,'/manifest.ijs' do.
  log 'Extraction failed: ',msg
  info 'Extraction failed:',LF2,msg
  return.
end.
install_addins y
install_config y
)
install_addins=: 3 :0
fl=. ADDCFG,'addins.txt'
ins=. fixjal2 freads fl
ins=. ins #~ (<y) ~: {."1 ins
ndx=. ({."1 ADDONS) i. <y
ins=. sort ins, 2 {. ndx { ADDONS
(fmtjal2 ins) fwrites fl
)
install_config=: 3 : 0
ADDLABS=: ''
0!:0 :: ] < ADDCFGIJS
install_labs y
write_config''
)
install_labs=: 3 : 0
labs=. dirtree jpath '~addons/',y,'/*.ijt'
if. 0=#labs do. return. end.
pfx=. jpath '~addons/'
labs=. (#pfx) }.each {."1 labs
LABCATEGORY=: ''
0!:0 ::] <jpath '~addons/',y,'/manifest.ijs'
cat=. LABCATEGORY
if. 0 = #cat do.
  cat=. toupper1 (y i. '/') {. y
end.
new=. labs ,each <' ',cat
txt=. sort ~. new,<;._2 ADDLABS
ndx=. 4 + (1 i.~ '.ijt'&E.) &> txt
msk=. fexist &> (<pfx) ,each ndx {.each txt
txt=. msk # txt
ADDLABS=: ; txt ,each LF
)
install_library=: 3 : 0
log 'Downloading base library...'
f=. 1 pick LIB
'rc p'=. httpget WWW,'library/',f
if. rc do. return. end.
log 'Installing base library...'
unzip p;jpath'~system'
ferase p
readlin''
)
write_config=: 3 : 0
txt=. 'NB. Addon configuration',LF2
txt=. txt,'ADDLABS=: 0 : 0',LF,ADDLABS,')',LF
txt fwrites ADDCFGIJS
)
show_console=: 4 : 0
if. -. init_console 'read' do. '' return. end.
select. x
case. 'search' do.
  pkgs=. getnames y
  res=. (pkgsearch pkgs) # 1 2 3 4 {"1 PKGDATA
  res=. curtailcaption res
case. 'show' do.
  pkgs=. getnames y
  res=. (msk=. pkgshow pkgs) # 5 {"1 PKGDATA
  if. #res do.
    res=. ,((<'== '), &.> msk # 1 {"1 PKGDATA) ,. res
    res=. (2#LF) joinstring (70&foldtext)&.> res
  end.
case. 'showinstalled' do.
  dat=. (isjpkgout y) {:: (1 2 3 4 {"1 PKGDATA);<y
  res=. (-.@pkgnew # ])dat
  res=. curtailcaption res
case. 'shownotinstalled' do.
  dat=. (isjpkgout y) {:: (1 2 3 4 {"1 PKGDATA);<y
  res=. (pkgnew # 0 2 3&{"1@])dat
  res=. curtailcaption res
case. 'showupgrade' do.
  dat=. (isjpkgout y) {:: (1 2 3 4 {"1 PKGDATA);<y
  res=. (pkgups # ])dat
  res=. curtailcaption res
case. 'status' do.
  res=. checklastupdate''
  res=. res,LF,checkstatus''
end.
res
)

showfiles_console=: 4 : 0
if. -. init_console 'read' do. '' return. end.
pkgs=. getnames y
pkgs=. pkgs (e. # [) (-.@pkgnew # 1&{"1@]) PKGDATA
pkgs=. pkgs -. <BASELIB
if. 0=#pkgs do. '' return. end.
fn=. (<'~addons/') ,&.> (pkgs) ,&.> <'/',x,(x-:'history'){::'.ijs';'.txt'
res=. res #~ msk=. (<_1) ~: res=. fread@jpath &.> fn
if. #res do.
  res=. ,((<'== '), &.> msk#pkgs) ,. res
  res=. (2#LF) joinstring res
end.
)
remove_console=: 3 : 0
if. -. init_console 'edit' do. '' return. end.
pkgs=. getnames y
pkgs=. pkgs (e. # [) (-.@pkgnew # 1&{"1@]) PKGDATA
pkgs=. pkgs -. <BASELIB
if. 0 = num=. #pkgs do. '' return. end.
many=. 1 < num
msg=. 'Removing ',(":num),' package',many#'s'
log msg
remove_addon each pkgs
log 'Done.'
readlocal''
pacman_init ''
checkstatus''
)

remove_addon=: 3 : 0
log 'Removing ',y,'...'
treepath=. jpath '~addons/',y
if. -.deltree treepath do.
  nf=. #dirtree treepath
  nd=. <: # dirpath treepath
  nd=. nd + (tolower treepath) e. dirpath jpath '~addons/', '/' taketo y
  msg=. (":nd),' directories and ',(":nf),' files not removed.'
  log 'Remove failed: ',msg
  info 'Remove failed:',LF2,msg
  return.
end.
remove_addins y
remove_config y
)
remove_addins=: 3 :0
fl=. ADDCFG,'addins.txt'
ins=. fixjal2 freads fl
ins=. ins #~ (<y) ~: {."1 ins
(fmtjal2 ins) fwrites fl
)
remove_config=: 3 : 0
ADDLABS=: ''
0!:0 :: ] < ADDCFGIJS
remove_labs y
write_config''
)
remove_labs=: 3 : 0
txt=. <;._2 ADDLABS
txt=. txt #~ (<jpathsep y) ~: (#y)&{. each txt
ADDLABS=: ; txt ,each LF
)
LOG=: 1
LOGMAX=: 100
log=: 3 : 0
if. 0=LOG do. return. end.
if. -.isgui'' do.
  smoutput y
else.
  LOGTXT=: LOGTXT,<;.2 y,LF -. {: y
  del=. (#LOGTXT) - LOGMAX
  if. del > 0 do.
    LOGTXT=: del }. LOGTXT
  end.
  txt=. }:;LOGTXT
  if. -.0".blog do. sel_view 3 end.
  wd 'set edlog *',txt
  wd 'setselect edlog ',":(0 0+#txt),0
  wd 'msgs'
end.
)
logstatus=: 3 : 0
if. ONLINE do.
  log checkstatus''
end.
)
PREFSMSG=: 0 : 0
Read catalog from server is best if you are always
connected to the Internet.
Otherwise, select from the other options.
)

PMPREFS=: 0 : 0
pc6j pmprefs owner;pn "Package Manager Preferences";
xywh 210 118 44 12;cc pfixbrowse button leftmove rightmove;cn "&Browse...";
xywh 6 12 255 79;cc g1 groupbox rightmove;cn "Catalog at Startup";
xywh 12 24 243 24;cc catmsg static rightmove;
xywh 12 49 234 12;cc bsrv radiobutton rightmove;cn "Read catalog from server";
xywh 12 62 234 12;cc bloc radiobutton rightmove group;cn "Use local copy of catalog";
xywh 12 75 234 12;cc bask radiobutton rightmove group;cn "Always ask";
xywh 6 106 255 32;cc g0 groupbox rightmove;cn "Font";
xywh 12 118 47 10;cc s0 static;cn "Text font:";
xywh 62 118 140 12;cc pfixfont edit ws_border es_autohscroll rightmove;
xywh 274 13 44 12;cc ok button leftmove rightmove;cn "OK";
xywh 274 29 44 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 6 4;pcenter;
rem form end;
)
pmprefs_run=: 3 : 0
wd PMPREFS
wd 'set catmsg *',' ' (I.PREFSMSG=LF) } PREFSMSG
wd 'set bloc ',":READCATALOG=0
wd 'set bsrv ',":READCATALOG=1
wd 'set bask ',":READCATALOG=2
wd 'set pfixfont *',TEXTFONT
wd 'pshow'
)
pmprefs_close=: 3 : 0
wd 'pclose'
)
pmprefs_ok_button=: 3 : 0
TEXTFONT=: pfixfont
READCATALOG=: 3 | (bloc,bsrv,bask) i. '1'
writeconfig''
pmprefs_close''
wd 'psel ',HWNDP
wd 'setfont adesc ',TEXTFONT
)
pmprefs_pfixbrowse_button=: 3 : 0
if. #j=. wd 'mbfont ',pfixfont do.
  wd 'set pfixfont *',pfixfont=: j
end.
)
pmprefs_cancel_button=: pmprefs_close
readlin=: 3 : 0
if. 0: ~: 4!:0 @ < 'JLIB' do.
  LIN=: 6 1 1 >. fixver freads LIBVER
else.
  LIN=: 6 1 1 >. fixver JLIB
end.
)
readlocal=: 3 : 0
readlin''
ADDONS=: fixjal freads ADDCFG,'addons.txt'
ADDINS=: fixjal2 freads ADDCFG,'addins.txt'
REV=: fixrev freads ADDCFG,'revision.txt'
LASTUPD=: fixupd freads ADDCFG,'lastupdate.txt'
LIBS=: fixlibs freads ADDCFG,'library.txt'
LIB=: fixlib LIBS
ZIPS=: fixzips freads ADDCFG,'zips.txt'
)
readtree=: 3 : 0
f=. ADDCFG,'tree.txt'
tree=. LF -.~ freads f
if. -. (<tree) e. 'current';'stable' do.
  tree=. 'current'
  writetree tree
end.
tree
)
writetree=: 3 : 0
y fwritenew ADDCFG,'tree.txt'
)
refreshweb=: 3 : 0
if. 0 = refreshjal'' do. 0 return. end.
readlocal''
1
)
refreshaddins=: 3 : 0
ADDLABS=: ''
f=. ADDCFG,'addins.txt'
p=. jpath '~addons/'
sd=. ;subdir each subdir p
if. 0=#sd do.
  '' fwrite f
  write_config'' return.
end.
r=. s=. ''
for_d. sd do.
  mft=. freads (>d),'manifest.ijs'
  if. mft -: _1 do. continue. end.
  VERSION=: ''
  0!:100 mft
  ver=. fmtver fixver VERSION
  n=. }: (#p) }. >d
  n=. '/' (I.n='\') } n
  r=. r,n,' ',ver,LF
  s=. s,d
end.
r fwritenew f
s=. (#p) }.each }: each s
install_labs each s
write_config''
)
refreshjal=: 3 : 0
'rc p'=. httpget WWW,zipext 'jal'
if. rc do. 0 return. end.
unzip p;ADDCFG
ferase p
if. *./ CFGFILES e. {."1 [ 1!:0 ADDCFG,'*' do. 1 return. end.
msg=. 'Could not install the local repository catalog.'
log msg
info msg
0
)
updatejal=: 3 : 0
log 'Updating server catalog...'
if. -. init_console 'server' do. '' return. end.
refreshaddins''
readlocal''
pacman_init''
res=. checklastupdate''
res,LF,checkstatus''
)
RELIBMSG=: 0 : 0
You are now using the XX base library, and can switch to the YY base library.

This will download the YY version of the base library and overwrite existing files. Addons are not affected.

OK to switch to the YY library?
)
prelib=: 3 : 0
old=. LIBTREE
new=. (('stable';'current') i. <old) pick 'current';'beta'
msg=. RELIBMSG rplc ('XX';'YY'),.old;new
if. 2 1 query SYSNAME;msg do.
  info 'Not done.' return.
end.
switchlibrary 1 pick new
)
switchlibrary=: 3 : 0
ferase LIBVER
writetree LIBTREE=: y
refreshjal''
readlocal''
pmview_setpn''
)
masklib=: 3 : 0
(1 {"1 y) = <BASELIB
)
pkglater=: 3 : 0
dat=. (s=. isjpkgout y){:: PKGDATA;<y
if. 0=#dat do. $0 return. end.
loc=. fixvers > (2-s) {"1 dat
srv=. fixvers > (3-s) {"1 dat
{."1 /:"2 srv ,:"1 loc
)
pkgnew=: 3 : 0
dat=. (s=. isjpkgout y){:: PKGDATA;<y
if. 0=#dat do. $0 return. end.
0 = # &> (2-s) {"1 dat
)
pkgups=: pkgnew < pkglater

pkgsearch=: 3 : 0
+./"1 +./ y E."1&>"(0 _) 1{"1 PKGDATA
)
pkgshow=: 3 : 0
y e.~ 1{"1 PKGDATA
)
setshowall=: 3 : 0
PKGDATA=: (<y) (<(I.DATAMASK);0) } PKGDATA
)
setshownew=: 3 : 0
ndx=. I. DATAMASK *. pkgnew''
PKGDATA=: (<y) (<ndx;0) } PKGDATA
)
setshowups=: 3 : 0
ndx=. I. DATAMASK *. pkgups''
PKGDATA=: (<y) (<ndx;0) } PKGDATA
)
splitlib=: 3 : 0
if. 0=#y do.
  2 $ <y return.
end.
msk=. masklib y
(msk#y) ; <(-.msk)#y
)
BASELIB=: 'base library'
DATAMASK=: 0
PKGDATA=: 0 7$a:
IFSECTION=: 0
SECTION=: ,<'All'
SELNDX=: 0 0
STATUS=: cutopen 0 : 0
All
Not installed
Installed, updateable
All installed
)

j=. 'cellalign cellcolors celledit cellmark celltype colminwidth colscale'
j=. j,' gridborder gridid gridmargin gridpid gridrowmode'
GRIDNAMES=: j,' hdrcol hdrcolalign'
PMVIEW=: 0 : 0
pc6j pmview;
menupop "&File";
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Tools";
menu pupcat "&Update Catalog from Server" "" "" "";
menusep;
menu prebuild "&Rebuild all Repository Catalogs" "" "" "";
menusep;
menu pprefs "&Preferences..." "" "" "";
menupopz;
xywh 4 4 75 149;cc sel listbox ws_vscroll bottommove;
xywh 6 156 33 11;cc bstatus radiobutton topmove bottommove;cn "Status";
xywh 40 156 42 11;cc bsection radiobutton topmove bottommove group;cn "Category";
xywh 4 174 75 73;cc g0 groupbox topmove bottommove;cn "Selections";
xywh 16 186 52 12;cc bclear button topmove bottommove;cn "Clear All";
xywh 16 200 52 12;cc bupdate button topmove bottommove;cn "Updates";
xywh 16 214 52 12;cc bnotins button topmove bottommove;cn "Not Installed";
xywh 16 228 52 12;cc bselall button topmove bottommove;cn "Select All";
xywh 16 249 52 12;cc apply button topmove bottommove;cn "Do Install...";
xywh 83 156 295 91;cc edlog editm ws_vscroll es_readonly topmove rightmove bottommove;
xywh 83 156 295 91;cc edhis editm ws_vscroll topmove rightmove bottommove;
xywh 83 156 295 91;cc edman editm ws_vscroll topmove rightmove bottommove;
xywh 83 156 295 91;cc adesc editm ws_vscroll topmove rightmove bottommove;
xywh 88 251 44 10;cc bsummary radiobutton topmove bottommove;cn "Summary";
xywh 136 251 37 10;cc bhistory radiobutton topmove bottommove group;cn "History";
xywh 177 251 43 10;cc bmanifest radiobutton topmove bottommove group;cn "Manifest";
xywh 350 251 29 10;cc blog radiobutton leftmove topmove rightmove bottommove group;cn "Log";
xywh 83 4 296 147;cc agrid isigraph rightmove bottommove;
xywh 221 250 34 12;cc binfo button topmove bottommove;cn "Info";
pas 3 4;pcenter;
rem form end;
)
pmview_run=: 3 : 0
wd ('agrid isigraph';'agrid checkedlistbox')&stringreplace^:(-.USEGRID) PMVIEW
wd 'pn *',SYSNAME
wd 'setfont adesc ',TEXTFONT
HWNDP=: wd 'qhwndp'
AHWNDC=: wd 'qhwndc agrid'
wpset 'pmview'
sel_view 0
pmview_gridinit''
pmview_show''
wd 'pshow'
)
agrid_gridhandler=: 3 : 0
select. y
case. 'mark' do.
  row=. {.CELLMARK__agrid
  wd 'set adesc *',(<row;5) pick VIEWDATA
  a=. '~addons/',(<row;1){:: VIEWDATA
  wd 'set edhis *',}.^:(_1&-:) fread jpath a,'/history.txt'
  wd 'set edman *',}.^:(_1&-:) fread jpath a,'/manifest.ijs'
  if. 0".blog do. sel_view 0 end.
end.
1
)
sel_view=: 3 : 0
if. #y do.
  'bsummary bhistory bmanifest blog'=: <;._1 ' ',":|._4{.#:2^y
  wd 'set bsummary ',bsummary
  wd 'set bhistory ',bhistory
  wd 'set bmanifest ',bmanifest
  wd 'set blog ',blog
end.
wd 'setshow adesc ',bsummary
wd 'setshow edhis ',bhistory
wd 'setshow edman ',bmanifest
wd 'setshow edlog ',blog
)
addon_info=: 3 : 0
if. 0=#VIEWDATA do. return.end.
if. USEGRID do.
  row=. {.CELLMARK__agrid
else.
  row=. {. ". wd 'get agrid select'
  if. row=_1 do. return. end.
end.
a=. (<row;1){:: VIEWDATA
if. 'base library'-:a do. a=. 'JAL' else. a=. 'Addons/',a end.
a=. 'http://code.jsoftware.com/wiki/',a
browser_view a
)
browser_view=: 3 : 0
browse_j_ y
)
pmview_apply_button=: 3 : 0
dat=. pmview_selected''
if. 0 = #dat do.
  info 'No packages selected for installation.' return.
end.
if. -. ONLINE do.
  if. -. getonline 'Install Packages';CHECKONLINE do. return. end.
end.
install dat
)
pmview_bclear_button=: 3 : 0
pmview_read''
setshowall 0
pmview_show''
)
pmview_bnotins_button=: 3 : 0
pmview_read''
setshownew 1
pmview_show''
)
pmview_bselall_button=: 3 : 0
pmview_read''
setshowall 1
pmview_show''
)
pmview_bupdate_button=: 3 : 0
pmview_read''
setshowups 1
pmview_show''
)
pmview_prebuild_button=: 3 : 0
if. -. ONLINE do.
  getonline 'Read Catalog from Server';CHECKASK
end.
if. ONLINE do.
  log 'Updating server catalog...'
  refreshjal''
end.
log 'Rebuilding local file list...'
refreshaddins''
readlocal''
log 'Done.'
pacman_init''
)
pmview_pupcat_button=: 3 : 0
if. -. ONLINE do.
  if. 0 = getonline 'Read Catalog from Server';CHECKASK do. return. end.
end.
log 'Updating server catalog...'
if. refreshweb'' do.
  log 'Done.'
end.
pacman_init''
)
pmview_sel_select=: 3 : 0
pmview_read ''
pmview_show''
)
pmview_applycounts=: 3 : 0
dat=. y
if. 0=#dat do. 0 0 return. end.
'lib dat'=. splitlib dat
cnt=. 0 < #lib
siz=. cnt * 2 pick LIB
ind=. ({."1 ZIPS) i. 1 {"1 dat
(cnt + #ind),siz + +/>(<ind;4){ZIPS
)
pmview_getmask=: 3 : 0
ndx=. IFSECTION { SELNDX
if. IFSECTION do.
  sel=. ndx pick SECTION
  select. sel
  case. 'All' do.
    DATAMASK=: (#PKGDATA) $ 1
  case. BASELIB do.
    DATAMASK=: (1 {"1 PKGDATA) = <BASELIB
  case. do.
    DATAMASK=: (<sel,'/') = (1+#sel) {.each 1 {"1 PKGDATA
  end.
else.
  select. ndx pick STATUS
  case. 'All' do.
    DATAMASK=: (#PKGDATA) $ 1
  case. 'Not installed' do.
    DATAMASK=: pkgnew''
  case. 'Installed, updateable' do.
    DATAMASK=: pkgups''
  case. 'All installed' do.
    DATAMASK=: -. pkgnew''
  end.
end.
)
pmview_gridinit=: 3 : 0
if. USEGRID do.
  agrid=: '' conew 'jzgrid'
  cellcolors=. CELLCOLORS__agrid
  cellcolors=. 248 (<0;3 4 5) } cellcolors
  cellalign=. 0
  celledit=. 1 0 0 0 0
  cellmark=. 0 0
  celltype=. 100 0 0 0 0
  colminwidth=. 10 20 20 20 20
  colscale=. 0 0 0 0 1
  gridborder=. 1
  gridmargin=. 3 6 1 0
  gridrowmode=: 1
  gridid=. 'agrid'
  gridpid=. 'pmview'
  hdrcol=. '';'Package';'Installed';'Latest';'Caption'
  hdrcolalign=: 1 0 0 0 0
  setnames__agrid pack GRIDNAMES
else.
  wd'setc agrid tabstops 100 40 40'
end.
)
pmview_postinit=: 3 : 0
pmview_setmenu''
pmview_show''
logstatus''
)
pmview_read=: 3 : 0
SELNDX=: (0 ". sel_select) IFSECTION } SELNDX
IFSECTION=: 0 ". bsection
if. USEGRID do.
  new=. CELLDATA__agrid,._2 {."1 VIEWDATA
else.
  CELLDATA=: (<("0) 1 (". wd 'get agrid checkedindex')} 0#~#CELLDATA),.}."1 CELLDATA
  new=. CELLDATA,._2 {."1 VIEWDATA
end.
PKGDATA=: new (I.DATAMASK) } PKGDATA
)
pmview_refresh=: 3 : 0
pmview_read''
pmview_show''
)
pmview_selected=: 3 : 0
pmview_read''
PKGDATA #~ > {."1 PKGDATA
)
pmview_setmenu=: 3 : 0
glsel^:USEGRID AHWNDC
nms=. ;: 'stable current beta'
msk=. nms e. 1 {"1 LIBS
sel=. 1 e. (}.msk,0) *. nms = <LIBTREE
)
pmview_show=: 3 : 0
wd 'psel pmview'
pmview_getmask ''
glsel^:USEGRID AHWNDC
wd 'set bstatus ',":-. IFSECTION
wd 'set bsection ',":IFSECTION
sel=. IFSECTION pick STATUS;<SECTION
wd 'set sel ',todel sel
wd 'setselect sel ',":IFSECTION { SELNDX
wd 'setenable apply ',":ONLINE
sel_view''
pmview_showdata DATAMASK # PKGDATA
)
pmview_showdata=: 3 : 0
VIEWDATA=: y
if. USEGRID do.
  CELLDATA__agrid=: _2 }."1 VIEWDATA
  show__agrid ''
  if. #y do.
    row=. {.CELLMARK__agrid
    wd 'set adesc *',(<row;5) pick VIEWDATA
  end.
else.
  CELLDATA=: _2 }."1 VIEWDATA
  n=. 20&{.&.> 1{"1 VIEWDATA
  mark=. ; 0{"1 VIEWDATA
  v1=. 2{"1 VIEWDATA
  v2=. 3{"1 VIEWDATA
  v3=. 4{"1 VIEWDATA
  wd 'setc agrid items *',toDEL n ,&.> (<TAB) ,&.> v1 ,&.> (<TAB) ,&.> v2 ,&.> (<TAB) ,&.> v3
  for_m. I.mark do.
    wd 'setc agrid checked ', ":m
  end.
  if. #y do.
    row=. {. ". wd 'get agrid checkedindex'
    if. row~:_1 do.
      wd 'set adesc *',(<row;5) pick VIEWDATA
    end.
  end.
end.
)
pmview_agrid_select=: 3 : 0
if. _1 ~: row=. {. ". agrid_select do.
  wd 'set adesc *',(<row;5) pick VIEWDATA
  a=. '~addons/',(<row;1){:: VIEWDATA
  wd 'set edhis *',}.^:(_1&-:) fread jpath a,'/history.txt'
  wd 'set edman *',}.^:(_1&-:) fread jpath a,'/manifest.ijs'
  if. 0".blog do. sel_view 0 end.
end.
)
info_view=: 3 : 0
wd 'set bsummary ',bsummary
wd 'set bhistory ',bhistory
wd 'set bmanifest ',bmanifest
wd 'set blog ',blog
wd 'setshow adesc ',bsummary
wd 'setshow edhis ',bhistory
wd 'setshow edman ',bmanifest
wd 'setshow edlog ',blog
)
pmview_cancel=: pmview_close=: destroy
pmview_bsection_button=: pmview_refresh
pmview_bstatus_button=: pmview_refresh
pmview_pprefs_button=: pmprefs_run
pmview_exit_button=: pmview_close
pmview_prelib_button=: prelib

pmview_bsummary_button=: info_view`pmview_refresh@.USEGRID
pmview_bhistory_button=: info_view`pmview_refresh@.USEGRID
pmview_bmanifest_button=: info_view`pmview_refresh@.USEGRID
pmview_blog_button=: info_view`pmview_refresh@.USEGRID
pmview_binfo_button=: addon_info
runpacman=: 3 : 0
a=. conew 'jpacman'
runpacman1__a''
)
runpacman1=: 3 : 0
if. -. runpacman2'' do.
  destroy''
end.
)
runpacman2=: 3 : 0
if. -. checkaccess'' do. 0 return. end.
readconfig''
pmview_run''
if. -. checkaddonsdir'' do. 0 return. end.
setfiles ''
readlocal''
if. -. checkonline'' do. 0 return. end.
pacman_init 1
1
)
pacman_init=: 3 : 0
dat=. ADDONS #~ ({."1 ADDONS) e. {."1 ZIPS
if. 0=#dat do.
  dat=. i.0 6
else.
  ndx=. ({."1 ADDINS) i. {."1 dat
  ins=. ndx { (1 {"1 ADDINS),<''
  dat=. dat,.<''
  dat=. 0 5 1 3 4 2 {"1 dat
  dat=. ins 1 }"0 1 dat
end.
lib=. 'base library';(fmtver LIN);(fmtver 0 pick LIB);'base library scripts and labs';LIBDESC;''
dat=. dat,lib
dat=. (<0),.dat
PKGDATA=: sort dat
nms=. 1 {"1 PKGDATA
nms=. ~. (nms i.&> '/') {.each nms
SECTION=: 'All';nms
DATAMASK=: (#PKGDATA) $ 1
if. isgui'' do. pmview_postinit'' end.
EMPTY
)
init_console=: 3 : 0
if. 0=#y do. y=. 'read' end.
select. y
fcase. 'edit';'server' do.
  if. -. checkaccess'' do. 0 return. end.
case. 'read' do.
  readconfig''
  if. -. checkaddonsdir'' do. 0 return. end.
  setfiles''
  readlocal''
  pacman_init ''
  res=. 1
case. do. res=. 0
end.
if. y -: 'server' do. res=. getserver'' end.
res
)

jpkg=: 4 : 0
select. x
case. 'history';'manifest' do.
  x showfiles_console y
case. 'install' do.
  install_console y
case. 'remove' do.
  remove_console y
case. ;:'show search showinstalled shownotinstalled showupgrade status' do.
  x show_console y
case. 'update' do.
  updatejal ''
case. 'upgrade' do.
  upgrade_console y
case. do.
  msg=. 'Valid options are:',LF
  msg=. msg,'  history, install, manifest, remove, show, search,',LF
  msg=. msg,'  showinstalled, shownotinstalled, showupgrade, status,',LF
  msg,'  update, upgrade'
end.
)
jpkg_z_=: 3 : 0
'help' jpkg y
:
a=. conew 'jpacman'
res=. x jpkg__a y
destroy__a''
res
)
jpkgv_z_=: (<@:>"1@|:^:(0 ~: #))@jpkg
