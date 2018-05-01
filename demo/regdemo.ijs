NB. regular expression demo

coclass 'regdemo'

HWNDP=: ''

require 'regex'

REGDEMO=: 0 : 0
pc6j regdemo closeok;pn "Regular Expression Pattern Matching";
menupop "&File";
menu std "Sta&ndard demo text" "" "" "";
menu open "&Open..." "" "" "";
menusep ;
menu exit "&Exit" "" "" "";
menupopz;
menupop "&Patterns";
menu p0 "Simple text" "" "" "";
menu p1 "Vowels" "" "" "";
menu p2 "Upper case" "" "" "";
menu p3 "Punctuation" "" "" "";
menu p4 "Alternation" "" "" "";
menu p5 "r + vowels" "" "" "";
menu p6 "Double letters" "" "" "";
menu p7 "J assignment" "" "" "";
menu p8 "Character strings" "" "" "";
menu p9 "J numeric items" "" "" "";
menu p10 "J names" "" "" "";
menupopz;
xywh 182 20 32 11;cc close button leftmove rightmove;cn "Close";
xywh 4 9 21 9;cc label static;cn "Pattern:";
xywh 27 7 150 11;cc pat edit ws_border es_autohscroll rightmove;
xywh 0 34 217 93;cc out richeditm ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly es_sunken rightmove bottommove;
xywh 182 6 32 11;cc match button leftmove rightmove;cn "&Match";
xywh 27 20 150 9;cc msg static rightmove;cn "";
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
STDTEXT=: 0 : 0
Here is some standard text for experimenting with regular
expression pattern matching.

NB. Some sample J code:

foo=: 'can''t' [ y=.>:y  NB. reassign y

test=. <;.1 ' ',array,12#'.'
)

NB. =========================================================
regdemo_run=: 3 : 0
wd REGDEMO
wd 'setfont out ',FIXFONT
HWNDP=: wd 'qhwndp'
newtext STDTEXT
wd 'setfocus pat'
dopattern 5
wd 'pshow;'
)

NB. =========================================================
regdemo_run1=: 3 : 0
xywh=. wd 'psel ',HWNDP,';qformx'
wd REGDEMO
new=. wd 'qhwndp'
wd 'pmovex ',xywh
wd 'setfont out ',FIXFONT
newtext TEXT
wd 'setfocus pat'
dopattern y
wd 'pshow;'
wd 'psel ',HWNDP,';pclose;psel ',new
HWNDP=: new
)

NB. =========================================================
NB. Start/Len From Indices
len=. +/@(*./\)@(= {. + i.@#)
z=. >@{.
i=. >@{:
slfi=: ( (z , ({. , len)@i) ; (len }. ])@i )^:(*@#@i)^:_ &. ((0 2$0)&; :. z) f.

NB. =========================================================
setout=: 4 : 0
s=. (+ +:@i.@#)@:({."1) x
e=. (>:@+ +:@i.@#)@:(+/"1) x
m=. -. (i. (#y)+2*#x) e. s,e

t=. m #^:_1 y
t=. (0{a.) s} t
t=. (1{a.) e} t

t=. t rplc '\';'\\'
t=. t rplc '{';'\{'
t=. t rplc '}';'\}'
t=. t rplc LF;'\par',LF
t=. t rplc (0{a.);'{\ul\cf1 '
t=. t rplc (1{a.);'}'
ctab=. '{\colortbl\red0\green0\blue0;\red255\green0\blue0;}'
t1=. '{\rtf1\ansi\deff0'
t1=. t1, '.'
t1=. t1, '{',ctab,t,'}'
t1=. t1, '}'
wd 'set out *',t1
)

NB. =========================================================
regdemo_close_button=: 3 : 0
wd 'pclose;'
)

NB. =========================================================
regdemo_match_button=: 3 : 0
if. 0=#pat do. return. end.
m=. {."2 pat rxmatches :: 0: TEXT
if. m-:0 do.  NB. error
  (0 2$0) setout TEXT
  if. 'Success'-:t=. rxerror'' do. t=. 'Interrupt' end.
  wd 'set msg *',t=. 'Error: ',t
else.  NB. success
  m setout TEXT
  wd 'set msg *',t=. (":#m),' match',('es'#~1~:#m),'.'
end.
wd 'setfocus pat'
t
)

NB. =========================================================
regdemo_pat_button=: regdemo_match_button

NB. =========================================================
regdemo_std_button=: 3 : 0
newtext STDTEXT
)

NB. =========================================================
newtext=: 3 : 0
(0 2$0) setout TEXT=: y
)

NB. =========================================================
regdemo_open_button=: 3 : 0
f=. mbopen '"Open File" "" "" "Text files|*.txt|Script files|*.ijs|All files|*.*" ofn_filemustexist'
if. *#f do. newtext fread f end.
)

NB. =========================================================
dopattern=: 3 : 0
't p'=. y{Patterns
wd 'set pat *',p
pat=: p
t=. t,': ',regdemo_match_button''
wd 'set msg *',t
)

NB. =========================================================
Patterns=: <;._1;._2 ]0 : 0
`Simple text "regular"`regular
`Vowels`[aeiouAEIOU]
`Upper case letters`[[:upper:]]
`Punctuation`[[:punct:]]
`"standard" or "regular"`standard|regular
`"r" followed by 1 or more vowels`r[aioue]+
`Double letters`([[:alpha:]])\1
`J assignment`([[:alpha:]][[:alnum:]_]*|x\.|y\.|m\.|n\.|u\.|v\.) *=[.:]
`Character strings`'(''|[^'])*'
`J numeric items`[[:digit:]_][[:alnum:]_.]*
`J names`[[:alpha:]][[:alnum:]_]*|x\.|y\.|m\.|n\.|u\.|v\.
)

NB. =========================================================
regdemo_button=: 3 : 0
regdemo_run1 y
)

([:".'regdemo_p'"_,":,'_button=:regdemo_button bind '"_,":)"0 i.#Patterns


NB. =========================================================
regdemo_exit_button=: regdemo_close_button

NB. =========================================================
regdemo_run''
