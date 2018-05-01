NB. init for pousse

require 'jview'
require 'gl2'

coclass 'pousse'

coinsert 'jgl2'

IFTEST=: 0

WHITE=: 255 255 255
BLACK=: 0 0 0
RED=: 224 0 0
GREEN=: 0 192 0

COLORS=: WHITE, BLACK, GREEN ,: RED
NB.       empty   grid   0      X

3 : 0 ''
if. IFTEST do.
  DEFSIZE=: 3
  IFAUTO=: 0
  IFTWO=: 1
else.
  DEFSIZE=: 4
  IFAUTO=: 1
  IFTWO=: 0
end.
)

IFGREENMOVE=: 0

PRED=: 'X'
PGREEN=: 'O'

INSTRUCTIONS=: 0 : 0
Pousse is a 2 person game, played on an N by N board. Initially the board is empty, and the
players take turns inserting one marker of their color (RED or GREEN) on the
board. The color RED always goes first. The computer plays GREEN.

A marker can only be inserted on the board by sliding it onto a
particular row from the left or from the right, or onto a particular
column from the top or from the bottom. So there are 4*N possible
"moves" (ways to insert a marker).

When a marker is inserted, there may be a marker on the square where
the insertion takes place. In this case, all markers on the insertion
row or column from the insertion square up to the first empty square
are moved one square further to make room for the inserted marker.
Note that the last marker of the row or column will be pushed off the
board (and must be removed from play) if there are no empty squares on
the insertion row or column.

A row or a column is a "straight" of a given color, if it contains
N markers of the given color.

The game ends either when an insertion:

1) repeats a previous configuration of the board; in this case
   the player who inserted the marker LOSES

2) creates a configuration with more straights of one color than
   straights of the other color; the player whose color is dominant
   (in number of straights) WINS

A game always leads to a win by one of the two players. Draws are
impossible.

Click the buttons to insert a marker. A button is disabled when it
would repeat a previous cofiguration of the board.

If the computer is on autoplay,
it will then play its move automatically, otherwise click any button
or click the playing area for the computer's move.
)

j=. 0 : 0
Pousse was the subject of the 1998 ICFP Functional Programming contest sponsored by MIT.

The program used here is the entry submitted by Iverson Software.

The program logic is as follows:

)

k=. 0 : 0
9!:1 >.*:+/6!:0 ''                NB. set random seed

free=: ' '                        NB. free square ' ' or '.'

run=: 3 : 0
q=. a:-.~<;._2 y,' '
n=. ".>{.q
q=. }.q
n runc q
!

runc=: 4 : 0                      NB. runs complete history
N=: x
seq=: q=. y
NNN=: N,NN=: N,N
IN4=: i.N4=: N*4
IN=: i.N
IX=: <"1(N,2)$2#IN                NB. indexes for all new rows for a side
BS=: NN$free
ps=: (0,NN)$,BS
sign=: 1
while. #q do.
  sign=: -.sign
  ps=: ps,BS=: ((sign{'XO'),>{.q) Play BS
  q=. }.q
end.
piece=: (-.sign){'XO'
allm=: piece moves BS             NB. calculate all possible moves
alln=: mnames N                   NB. move names corresp. to allm
i.0 0
!

pickrandom=: ?@# { ]
pickmax=: (= >./) # i.@#
pickmove=: 1 : '(pickrandom pickmax y u allm){alln'

Play=: 4 : 0      NB. mv Play board  makes one move. e.g. 'XT1' Play 5 5$' '
'm d'=. 2{.x
i=. <:".2}.x
select. d
case. 'L' do. y i}~m LT i{y
case. 'R' do. y i}~m LT&.|. i{y
case. 'T' do. y j}~m LT j{y [ j=. <a:;i
case. 'B' do. y j}~m LT&.|. j{y [ j=. <a:;i
end.
!

LT=: #@] {. [ , (i.@#@] ~: ] i. free"_) # ]

chrows=: 4 : 0   NB. new row for each left side move
q=. x,. (IN{"0 2 y),. free
i=. q i."1 free
N{."1 (i~:/i.N+2) #"1 q
!

side=: # # ,:                                 NB. make n copies of a board
lmoves=: 4 : '(x chrows q) IX} q=.side y'   NB. left moves
rmoves=: lmoves&.(|."1"_)                     NB. right
tmoves=: lmoves&.(|:"2"_)                     NB. top
bmoves=: rmoves&.(|:"2"_)                     NB. bottom
moves=: lmoves, rmoves, tmoves, bmoves
mnames=: ,/ @: ('LRTB'"_ ,."0 2 ]) @: (":"0) @: >: @: i.

flip=: 'X'&=@[ { 'XO'"_

straight=: +/"1 @: ({:@$ = +/"1 ,"1 +/"2) @: =
evstraight=: straight - flip@[ straight ]

evline=: +/"1 @: (* * 2&^@:|) @: (+/"1 ,"1 +/"2) @: (= - flip@[ = ])

evrepeat=: 4 : '- y e. ((#ps)$''XO''=x)#ps'

dedge=: >: @: (+/~) @: (i. <. i.@-)
count=: +/"1 @: (,"2) @: (dedge@{:@$ *"2 ]) @: =
evcount=: count - flip@[ count ]

ev=: evline + evcount + 1e8"_ * evrepeat + evstraight

ev2a=: flip@[ ([ -@:(>./"1)@:ev moves)"2 ]

ev2=: 4 : 0                    NB. 2-ply search using ev on each ply
p=. x ev y
i=. I.  (_1e6<p)*.p<1e6   NB. look on only if non winner & non loser
q=. (x ev2a i{y) i}p
(*./_1e6>q){q,:p               NB. if q is all bleak, just use p
!
)

k=. k rplc ('!',LF);')',LF
k=. k rplc LF;LF,' '
ABOUT=: j,' ',k
9!:1 >.*:+/6!:0 ''                NB. set random seed

free=: ' '                        NB. free square ' ' or '.'

run=: 3 : 0
q=. a:-.~<;._2 y,' '
n=. ".>{.q
q=. }.q
n runc q
)

runc=: 4 : 0                      NB. runs complete history
N=: x
seq=: q=. y
NNN=: N,NN=: N,N
IN4=: i.N4=: N*4
IN=: i.N
IX=: <"1(N,2)$2#IN                NB. indexes for all new rows for a side
BS=: NN$free
ps=: (0,NN)$,BS
sign=: 1
while. #q do.
  sign=: -.sign
  ps=: ps,BS=: ((sign{'XO'),>{.q) Play BS
  q=. }.q
end.
piece=: (-.sign){'XO'
allm=: piece moves BS             NB. calculate all possible moves
alln=: mnames N                   NB. move names corresp. to allm
i.0 0
)

pickrandom=: ?@# { ]
pickmax=: (= >./) # i.@#
pickmove=: 1 : '(pickrandom pickmax y u allm){alln'

Play=: 4 : 0      NB. mv Play board  makes one move. e.g. 'XT1' Play 5 5$' '
'm d'=. 2{.x
i=. <:".2}.x
select. d
case. 'L' do. y i}~m LT i{y
case. 'R' do. y i}~m LT&.|. i{y
case. 'T' do. y j}~m LT j{y [ j=. <a:;i
case. 'B' do. y j}~m LT&.|. j{y [ j=. <a:;i
end.
)

LT=: #@] {. [ , (i.@#@] ~: ] i. free"_) # ]

chrows=: 4 : 0   NB. new row for each left side move
q=. x,. (IN{"0 2 y),. free
i=. q i."1 free
N{."1 (i~:/i.N+2) #"1 q
)

side=: # # ,:                                 NB. make n copies of a board
lmoves=: 4 : '(x chrows q) IX} q=.side y'   NB. left moves
rmoves=: lmoves&.(|."1"_)                     NB. right
tmoves=: lmoves&.(|:"2"_)                     NB. top
bmoves=: rmoves&.(|:"2"_)                     NB. bottom
moves=: lmoves, rmoves, tmoves, bmoves
mnames=: ,/ @: ('LRTB'"_ ,."0 2 ]) @: (":"0) @: >: @: i.

flip=: 'X'&=@[ { 'XO'"_

straight=: +/"1 @: ({:@$ = +/"1 ,"1 +/"2) @: =
evstraight=: straight - flip@[ straight ]

evline=: +/"1 @: (* * 2&^@:|) @: (+/"1 ,"1 +/"2) @: (= - flip@[ = ])

evrepeat=: 4 : '- y e. ((#ps)$''XO''=x)#ps'

dedge=: >: @: (+/~) @: (i. <. i.@-)
count=: +/"1 @: (,"2) @: (dedge@{:@$ *"2 ]) @: =
evcount=: count - flip@[ count ]

ev=: evline + evcount + 1e8"_ * evrepeat + evstraight

ev2a=: flip@[ ([ -@:(>./"1)@:ev moves)"2 ]

ev2=: 4 : 0                    NB. 2-ply search using ev on each ply
p=. x ev y
i=. I. (_1e6<p)*.p<1e6   NB. look on only if non winner & non loser
q=. (x ev2a i{y) i}p
(*./_1e6>q){q,:p               NB. if q is all bleak, just use p
)

info=: wdinfo @ ('Pousse'&;)
unwords=: ;: inverse
NB. win

OFFX=: 70
OFFY=: 0

NB. =========================================================
PS=: 0 : 0
pc6j ps closeok nomax nosize;pn "Pousse";
menupop "Options";
menu new "&New Game" "Ctrl+N" "" "";
menupop "New_Game_Size";
menu sz3 "&3" "" "" "";
menu sz4 "&4" "" "" "";
menu sz5 "&5" "" "" "";
menu sz6 "&6" "" "" "";
menu sz7 "&7" "" "" "";
menu sz8 "&8" "" "" "";
menupopz;
menusep ;
menu undo "&Undo" "Ctrl+U" "" "";
menusep ;
menu auto "&Auto Green Move" "" "" "";
menusep ;
menu two "&Two Player" "" "" "";
menusep ;
menu exit "E&xit" "" "" "";
menupopz;
menupop "Help";
menu instructions "&Instructions" "" "" "";
menusep ;
menu about "&About" "" "" "";
menupopz;
xywh 5 5 23 9;cc s1 static;cn "Red";
xywh 29 5 31 9;cc s2 static;cn "Green";
xywh 4 14 51 60;cc log editm ws_vscroll es_readonly bottomscale;
pas 0 0;
rem form end;
)

NB. =========================================================
ps_run=: ''&$: : (4 : 0)
ps=. PS rplc 'New_Game_Size';'New Game Size'
wd ps
wd 'setfont log ',FIXFONT
defbuttons''
defgrid''
writemenu''
wd 'pas 0 0'
if. #x do. wdcenter x
else. wd 'pcenter' end.
ps_new_button''
wd 'pshow;'
)

NB. =========================================================
ps_about_button=: 3 : 0
'About' wdview '';(topara ABOUT);1
)

NB. =========================================================
ps_auto_button=: 3 : 0
IFAUTO=: -. IFAUTO
writemenu''
if. IFGREENMOVE do. rungreen'' end.
)

NB. =========================================================
ps_close=: 3 : 0
wd'pclose'
)

NB. =========================================================
ps_exit_button=: ps_cancel=: ps_close

NB. =========================================================
ps_instructions_button=: 3 : 0
'Instructions' wdview '';(topara INSTRUCTIONS);1
)

NB. =========================================================
ps_board_mbldown=: 3 : 0
if. IFGREENMOVE > IFTWO do. rungreen'' end.
)

NB. =========================================================
ps_new_button=: 3 : 0
button_enable (4*SIZE)#1
IFGREENMOVE=: 0
SEQ=: ''
run ":SIZE
psshow''
)

NB. =========================================================
ps_nctrl_fkey=: ps_new_button

NB. =========================================================
ps_two_button=: 3 : 0
IFTWO=: -. IFTWO
writemenu''
if. IFGREENMOVE *. IFAUTO do. rungreen'' end.
)

NB. =========================================================
ps_undo_button=: 3 : 0
if. IFTWO do.
  SEQ=: _3 }. SEQ
  IFGREENMOVE=: -. IFGREENMOVE
elseif. IFGREENMOVE do.
  SEQ=: _3 }. SEQ
  IFGREENMOVE=: 0
elseif. 1 do.
  SEQ=: _6 }. SEQ
end.
run (":SIZE),' ',SEQ
psshow''
)

NB. =========================================================
ps_uctrl_fkey=: ps_undo_button

NB. =========================================================
ps_boardsize=: 3 : 0
if. y=SIZE do.
  ps_new_button''
else.
  pos=. wd 'qformx'
  wd 'pclose'
  pos pousse y
end.
)

NB. =========================================================
ps_sz3_button=: ps_boardsize bind 3
ps_sz4_button=: ps_boardsize bind 4
ps_sz5_button=: ps_boardsize bind 5
ps_sz6_button=: ps_boardsize bind 6
ps_sz7_button=: ps_boardsize bind 7
ps_sz8_button=: ps_boardsize bind 8

NB. =========================================================
psshow=: 3 : 0
writelog SEQ
writeboard BS
writeenable''
writemenu''
wd 'setfocus board'
)

NB. =========================================================
button_enable=: 3 : 0
1 button_enable I. y
0 button_enable I. -.y
:
if. #y do.
  bn=. y{,BUTTONS
  if. IFJAVA=0 do.
    wd 'setenable '&, @ (,&(' ',(":x),' ')) &> bn
  end.
end.
)

NB. =========================================================
defbuttons=: 3 : 0
BUTTONS=: 'LRTB' ,each "0/ ":&.> >:i.SIZE
x=. ": OFFX + ,. SIZE#0,WID+CELL*SIZE
y=. ": OFFY + ,. HITE+CELL*(,~)i.SIZE
j=. (';cc '&,@ (,&' button')) &> ,2 {.BUTTONS
wd 'xywh ',"1 x,"1 ' ',"1 y,"1 (' ',":WID,CELL),"1 j
x=. ": OFFX + ,. (,~) WID+CELL*i.SIZE
y=. ": OFFY + ,. SIZE#0,HITE+CELL*SIZE
j=. (';cc '&,@ (,&' button')) &> ,2 }. BUTTONS
wd 'xywh ',"1 x,"1 ' ',"1 y,"1 (' ',":CELL,HITE),"1 j
)

NB. =========================================================
defgrid=: 3 : 0
j=. ';cc board isigraph'
wd 'xywh ',(":(OFFX+WID),(OFFY+HITE),2#CELL*SIZE),j
NB. resize grid for even sized buttons:
'x y w h'=. 0 ". wd 'qchildxywhx board'
CELL=: <. SIZE %~ w <. h
wd 'setxywhx board ',":x,y,2#CELL*SIZE
where=: (4,~*:SIZE)$, ,&(2#CELL)"1 CELL*>{2#<i.SIZE
)

NB. =========================================================
writeboard=: 3 : 0
y=. |:y
glrgb 1{COLORS
glpen 0 0
(0{COLORS) writecell where#~' '=,y
((2+PRED='X'){COLORS) writecell where#~'X'=,y
((2+PRED='O'){COLORS) writecell where#~'O'=,y
glpaint ''
)

NB. =========================================================
writecell=: 4 : 0 "1
glrgb x
glbrush ''
glrect y NB. ,2#<.CELL%4
)

NB. =========================================================
writemenu=: 3 : 0
wd 'set auto ',":IFAUTO
wd 'set two ',":IFTWO
wd 'setenable auto ',":IFTWO=0
)

NB. =========================================================
writelog=: 3 : 0
if. 0 e. #y do.
  wd 'set log'
else.
  seq=. ;: y
  rws=. >. -: #seq
  seq=. _2 [\ (rws*2) {. seq
  txt=. LF ,. (>{."1 seq) ,. '  ' ,"1 >{:"1 seq
  wd 'set log *', log=: }. ,txt
  wd 'setscroll log ',":rws
end.
)
NB. run

NB. =========================================================
done=: 3 : 0
cred=. PRED straight BS
cgreen=. PGREEN straight BS
res=. cred ~: cgreen
if. res do.
  button_enable (4*SIZE)#0
  name=. (cgreen>cred) pick 'Red';'Green'
  txt=. log ,LF, name,' wins'
  wd 'set log *', txt
  wd 'setscroll log ',": 1++/txt=LF
end.
res
)

NB. =========================================================
pousse=: ''&$: : (4 : 0)
SIZE=: {.y,DEFSIZE
if. IFWINCE do.
  WID=: 12
  HITE=: 12
  CELL=: 16
else.
  WID=: 13
  HITE=: 13
  CELL=: 20
end.
SEQ=: ''
BS=: (2#SIZE)$' '
PRED=: 'X'
run ":SIZE
x ps_run''
)

NB. =========================================================
ps_default=: 3 : 0
if. -. systype-:'button' do. '' return. end.
if. -. (<syschild) e. ,BUTTONS do. '' return. end.
if. IFGREENMOVE > IFTWO do. rungreen'' return. end.
run (":SIZE),' ',SEQ=: SEQ,' ',syschild
IFGREENMOVE=: -. IFGREENMOVE
psshow''
if. done '' do. return. end.
if. IFAUTO > IFTWO do. rungreen'' end.
)

NB. =========================================================
NB. auto run green
rungreen=: 3 : 0
if. IFTWO do. return. end.
run (":SIZE),' ',SEQ=: SEQ,' ',ev2 pickmove piece
IFGREENMOVE=: 0
psshow''
if. done '' do. return. end.
)

NB. =========================================================
writeenable=: 3 : 0
button_enable -.| (IFGREENMOVE{PRED,PGREEN) evrepeat allm
)

NB. =========================================================
wd :: ] 'psel ps;pclose'
pousse''
