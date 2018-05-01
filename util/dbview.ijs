require 'grid'

coclass 'jdbview'

coinsert 'jdebug'

EMPTY=: i.0 0
CEMPTY=: 0 0 $' '

CMASK=: 1 1 1 1 1 0 1 1 0
CMASK=: 1 0 0 0 1 0 1 1 0
CALIGN=: 0 1 1 1 0 0 0 0 1
CHDRCOL=: <;._1 ' name/msg msg ln nc def script args locals susp'

CELLALIGNV=: 0
CELLFONT=: 1
CELLEDIT=: 0

DBVIEWDAT=: ''
DOTNAMES=: ;: 'm. n. u. v. x. y.'
GRIDNAMES=: 0 : 0
CELLALIGN
CELLALIGNV
CELLDATA
CELLEDIT
CELLFONT
HDRCOL
)
MAXRWS=: 10
MAXRWS2=: <. -: <: MAXRWS
MAXCLS=: 50
MINVIEW=: 120 0
VHWNDP=: ''
jdb_ischar=: 3!:0 e. 2 131072 262144"_
a=. 16 + i. 11
b=. 9 1 1 # 43 124 45
jdb_boxascii=: a.&i. { ((b { a.) a } a.)"_
jdb_addptr=: 4 : 0
len=. #y
end=. len <. x + MAXRWS2
y=. end {. y
bgn=. 0 >. end - MAXRWS
y=. bgn }. y
s=. x - bgn
ptr=. '>' s } (#y) $ ' '
ndx=. ('[' , ": , '] '"_) &.> bgn + i.#y
(ptr ,&.> ndx) ,&.> y
)
jdb_flat=: 3 : 0
(MAXRWS,MAXCLS) jdb_flat1 y
)
jdb_flat1=: 4 : 0
if. 0 e. $y do. CEMPTY return. end.
if. 0 < L. y do.
  x jdb_flatb y
elseif. jdb_ischar y do.
  x jdb_flatc y
elseif. do.
  x jdb_flatn y
end.
)
jdb_flatb=: 4 : 0
if. 0 e. $y do. CEMPTY return. end.
if. 0 e. 2 < x do. CEMPTY return. end.
shape=. $y
'rws cls'=. x
if. (-:cls) < {:$y do.
  y=. (>.-:cls) {."1 y
end.
select. #shape
case. 0 do.
  x jdb_flatc ": < (x-2) jdb_flat1 > y return.
case. 1 do.
  x jdb_flatc ": (<x-2) jdb_flat1 &.> y return.
case. 2 do.
  if. (-:rws) < {. shape do.
    y=. (>.-:rws) {. y
  end.
  hit=. 0
  r=. ''
  for_t. y do.
    if. hit >: rws do. break. end.
    txt=. (<x-2) jdb_flat1 &.> t
    shp=. $ S:0 txt
    hit=. hit + 1 + >./ {."1 shp
    len=. +/\ 1 + {:"1 shp
    if. cls < {:len do.
      ndx=. (cls < len) i. 1
      y=. ndx {."1 y
      txt=. ndx {. txt
    end.
    r=. r, <txt
  end.
  x jdb_flatc ": ({:$y) {.&> r
case. do.
  blk=. _2 }. shape
  rln=. rws <. _2 { shape
  blk=. 1 >. <. rws % rln
  y=. (blk,rln) {. y
  hit=. 0
  r=. i.0 0
  for_t. y do.
    if. hit >: rws do. break. end.
    txt=. (x-1) jdb_flatb t
    hit=. hit + 1 + #txt
    r=. r, ' ',txt
  end.
  x jdb_flatc }. r
end.
)
jdb_flatc=: 4 : 0
if. 0 e. $y do. CEMPTY return. end.
if. 0 e. 0 < x do. CEMPTY return. end.
shape=. $y
'rws cls'=. x
select. #shape
case. 0 do.
  1 1 $ y
case. 1 do.
  if. LF e. y do.
    y=. <;._2 y,LF
    if. rws < # y do.
      y=. ((rws-1) {. y) , <'...'
    end.
    ndx=. I. cls < # &> y
    if. #ndx do.
      new=. ,&'...' &.> (cls-3) {. &.> ndx { y
      y=. new ndx } y
    end.
    >y
  elseif. cls < shape do.
    ,:((cls-3){.y),'...'
  elseif. do.
    ,:y
  end.
case. 2 do.
  'r c'=. shape
  if. r=1 do.
    x jdb_flatc ,y
  else.
    select. x < shape
    case. 0 0 do.
      y
    case. 0 1 do.
      ((r,cls-3){.y) ,"1 '...'
    case. 1 0 do.
      ((rws-1){.y), '...'
    case. 1 1 do.
      ((((rws-1),cls-3){.y),"1 '...'),'...'
    end.
  end.
case. do.
  blk=. }: shape
  if. 1 = */ blk do.
    x jdb_flatc ,y
  else.
    blk= <. */\. ^:_1 (rws+1) <. */\. blk
    if. cls < {:shape do.
      y=. ((blk,cls-3) {. y) ,"1 '...'
    else.
      y=. blk {. y
    end.
    x jdb_flatc 1 1}. _1 _1}. ": <y
  end.
end.
)
jdb_flatn=: 4 : 0
if. 0 e. $y do. CEMPTY return. end.
if. 0 e. 0 < x do. CEMPTY return. end.
shape=. $y
'rws cls'=. x
if. cls < {:$y do.
  y=. cls {."1 y
end.
select. #shape
case. 0 do.
case. 1 do.
case. 2 do.
  'r c'=. $y
  if. r = 1 do.
    y=. ,y
  else.
    if. rws < {. shape do.
      y=. (rws+1) {. y
    end.
  end.
case. do.
  blk=. }: shape
  if. 1 = */ blk do.
    y=. ,y
  else.
    blk= <. */\. ^:_1 (rws+1) <. */\. blk
    y=. blk {. y
  end.
end.
x jdb_flatc ": y
)
jdb_fixreps=: 3 : 0

name=. > (<0 0) { STACK
if. 0 e. #name do. STACK return. end.
lns=. ; 2 {"1 STACK
nmc=. ; 3{"1 STACK
rps=. 4{"1 STACK
arglen=. # &> 6{"1 STACK
val=. (#nmc) # _1
if. 1 e. b=. nmc=3 do.
  val=. (<: b # arglen) (I. b)} val
end.
if. 1 e. b=. (nmc~:3) *. (1: e. MNUV&e.) &> STACKLOCS do.
  sel=. (<'x')&e. &> b # STACKLOCS
  val=. sel (I. b)} val
end.
nmc=. nmc + (nmc=3) *. val=1
tac=. 0 = # &> STACKLOCS
brp=. (>: 0 >. val) >@{ &.> (<"1 tac,.nmc) jdb_boxrep &.> rps
bln=. # &> brp

if. 0=#brp do.
  jdb_info 'Unable to display Debug stack'
  '' return.
end.

if. 0={.bln do.
  jdb_info 'Unable to display top of stack'
  '' return.
end.

if. 0 e. bln do.
  brp=. (<'display not available') (I. bln)} brp
end.
brp=. lns jdb_addptr &.> brp
jdb_tolist &.> brp
)
jdb_fixstack=: 3 : 0
dat=. y
en=. (; 1 {"1 dat) { '';9!:8''
nam=. (0 {"1 dat) ,&.> LF ,&.> en
dat=. nam 0 }"0 1 dat
arg=. 6 {"1 dat
ndx=. 2 = # &> arg
add=. ndx { (,<,'y');<(,'x');,'y'
arg=. add ,.&.> arg
dat=. arg 6 }"0 1 dat
loc=. 7 {"1 dat
STACKLOCS=: {."1 &.> loc
msk=. -. &.> STACKLOCS e.&.> <DOTNAMES
loc=. msk #&.> loc
loc=. loc -. &.> arg
STACK=: loc 7 }"0 1 dat
reps=. jdb_fixreps''
CSTACK=: reps 4 }"0 1 STACK
''
)
JDBVIEW=: 0 : 0
pc6j jdbview;pn "Stack";
xywh 0 0 400 300;cc grid isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
jdbview_run=: 3 : 0
wd JDBVIEW
VHWNDP=: wd 'qhwndp'
if. IFJNET do. glnodblbuf 0 end.
destroy=: jdbviewdestroy
formx=. 0 ". wd 'qformx'
wh=. _2 {. 0 ". wd 'qchildxywhx grid'
grid=: '' conew 'jzgrid'
show__grid GRIDNAMES
twh=. MINVIEW >. readsize__grid wh
del=. 0 <. twh - wh
if. -. IFJAVA do.
  wd 'setxywhx grid 0 0 ',":wh + del
end.
wd 'pmovex ',":formx + 0 0,0 <. del+1+5*IFJAVA
wd 'pshow;'
)
jdbviewdestroy=: 3 : 0
wd :: ] 'psel ',VHWNDP,';pclose'
destroy__grid''
codestroy''
)
jdbview_close=: jdbview_cancel=: jdbviewdestroy
jdbview=: 3 : 0
a=. conew 'jdbview'
jdbviewp__a y
)
jdbviewp=: 3 : 0
if. 0 e. $y do.
  y=. DBVIEWDAT
end.
if. 0 e. $y do. return. end.
jdb_fixstack y
CSTACK=: CMASK #"1 CSTACK
CELLALIGN=: CMASK # CALIGN
CELLDATA=: jdb_flat &.> CSTACK
CELLDATA=: jdb_boxascii &.> CELLDATA
HDRCOL=: CMASK # CHDRCOL
jdbview_run''
)
