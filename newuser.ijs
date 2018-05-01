coclass 'jnewuser'
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))
wdbuf=: 3 : 'BUF=: BUF,<y'
shownewuser=: 3 : 0
new=. 'NEWUSER=: ',":{.y,0
dat=. cfgopen''
if. 0 = #dat do. return. end.
ndx=. 1 i.~ (<'NEWUSER=') = 8 {.each dat
if. ndx = #dat do. dat=. dat , <'' end.
cfgwrite (<new) ndx } dat
)
0!:0 :: ] <jpath '~config/config.ijs'

deb=: #~ (+. 1: |. (> </\))@(' '&~:)
fexist=: (1:@(1!:4) :: 0:) @ (fboxname &>) @ boxopen
fread=: (1!:1) @ (fboxname &>) @ boxopen :: _1:
fwrite=: ([: , [) (#@[ [ 1!:2) ::(_1:) [: fboxname ]
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))
cfgopen=: 3 : 0
CFG=: jpath '~config/config.ijs'
if. 0 -: fexist <CFG do.
  dat=. fread < jpath '~addons/ide/jnet/config/stdcfg.ijs'
  dat fwrite <CFG
end.
dat=. fread <CFG
if. _1 -: dat do.
  msg=. 'Unable to save configuration file: ',CFG
  wdinfo 'New User';msg
  '' return.
end.
<;._2 (toJ dat), LF
)
cfgwrite=: 3 : 0
dat=. toHOST ; ,&LF each y
dat fwrite <CFG
)
NEWUSERHDR=: topara 0 : 0
If you are new to J, you might start by going through some of the Labs.
Then look at the Primer, which introduces the language and working
environment, and at the various Demos.

The complete J documentation can be accessed through the Help menu.

All users should check out the Release Highlights.

We encourage you to join the J forum, which is the main discussion group
for all topics related to J. For details, see: http://www.jsoftware.com.
)
NEWUSERWD=: 0 : 0
pc6j newuserwd nomax nosize owner;
xywh 8 5 290 15;cc w0 static ss_center;cn "";
xywh 8 20 292 94;cc g0 groupbox;cn "";
xywh 13 26 283 84;cc hdr static;cn "";
xywh 8 120 292 63;cc g1 groupbox;cn "Key Menu Items";
xywh 13 131 86 10;cc s0 static;cn "";
xywh 101 131 192 10;cc n0 static;cn "";
xywh 13 143 86 10;cc s1 static;cn "";
xywh 101 143 192 10;cc n1 static;cn "";
xywh 13 155 86 10;cc s2 static;cn "";
xywh 101 155 192 10;cc n2 static;cn "";
xywh 13 167 86 10;cc s3 static;cn "";
xywh 101 167 192 10;cc n3 static;cn "";
xywh 9 189 157 11;cc show checkbox;cn "";
xywh 225 189 72 12;cc exitj button bs_defpushbutton;cn "E&xit to J Session";
pas 6 6;pcenter;
rem form end;
)
newsetfont=: 3 : 0
nms=. > ;: y
wdbuf ,';setfont ',"1 nms,"1 ' ',FONT
)
newsetfont2=: 3 : 0
wdbuf 'setfont ',y,' ',FONT2
)
newuserwd_run=: 3 : 0
newuserdefs''
BUF=: ''
wdbuf NEWUSERWD

wdbuf 'set hdr "',NEWUSERHDR,'"'
pn=. 'Welcome to ',JVER
wdbuf 'pn "',pn,'"'
wdbuf 'setcaption w0 "',pn,'"'
newsetfont2 'w0'

wdbuf 'setcaption n0 "For new features and recent changes to the system"'
wdbuf 'setcaption s0 "Help|Release Highlights"'
wdbuf 'setcaption n1 "To configure your system, e.g. change the fonts"'
wdbuf 'setcaption s1 "Edit|Configure..."'
wdbuf 'setcaption n2 "To run a Lab"'
wdbuf 'setcaption s2 "Studio|Labs..."'
wdbuf 'setcaption n3 "To run a Demo"'
wdbuf 'setcaption s3 "Studio|Demos..."'

newsetfont 'g0 g1 s0 s1 s2 s3 n0 n1 n2 n3'
newsetfont 'hdr exitj show'
wdbuf 'setcaption show "Do not show this form again"'
wdbuf 'setfocus exitj'

BUF=: ; BUF ,each ';'
wd BUF
wd 'pshow'
)
newuserdefs=: 3 : 0
ver=. (i.&'/' {. ])9!:14''
JVER=: 'J',(({.ver) e. 'jJ') }. ver
if. IFUNIX do.
  FONT=: IFJAVA{::'"DejaVu Serif" 10';'SansSerif 10'
  FONT2=: IFJAVA{::'"DejaVu Serif" 14 bold';'SansSerif 14 bold'
else.
  FONT=: '"MS Sans Serif" 10'
  FONT2=: '"MS Sans Serif" 14 bold'
end.
)
newuserwd_cancel=: 3 : 0
if. -. 2 wdquery JVER;'Do you want to close?' do.
  2!:55''
end.
)
newuser_close=: 3 : 0
if. ". show do. shownewuser 0 end.
wd 'pclose'
coerase <'jnewuser'
)
newuserwd_close=: newuserwd_cancel
newuserwd_enter=: newuserwd_exitj_button=: newuser_close
newuserwd_run''
