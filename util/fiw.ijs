require 'regex'
coclass 'jfiw'
coinsert 'j';'jijs'

FIWCASE=: 1
FIWCONNDX=: 0
FIWDOWN=: 1
FIWDEFAULT=: 1
FIWH=: ''
FIWINC=: 0
FIWMSK=: ''
FIWWHAT=: ''
FIWMAX=: 20
FIWTITLE=: 'Find'
FIWRTITLE=: 'Find & Replace'

FIWCONTEXT=: 0 : 0
any
name only
assigned
assigned globally
assigned locally
in comment text
)
3 : 0''
if. _1=4!:0 <'FIWFIND' do.
  FIWFIND_j_=: i.0 3
  FIWREPLACE_j_=: ''
end.
)


deb=: #~ (+. 1: |. (> </\))@(' '&~:)
find=: #@[ (| - =) i.
bcfind=: find &: (tolower each)
finfo=: 3 : 'wdinfo FIWTITLE;y'
frinfo=: 3 : 'wdinfo FIWRTITLE;y'
fquery=: 4 : 'x wdquery FIWTITLE;y'
groupndx=: [: <: I. + e.~
subs=. 2 : 'm I. @(e.&n)@]} ]'
toblank=: ' ' subs '_'
tohyphen=: '_' subs ' '
subtcc=: ' '&(I.@(e.&(TAB,CRLF))@]})
termLF=: , (0: < #) # LF"_ -. _1&{.
termdelLF=: }.~ [: - 0: i.~ LF&= @ |.
tolist=: }. @ ; @: (LF&, each)
toLF=: (10{a.)&(I. @(e.&(13{a.))@]})

ffmatch=: ({.@{.+{:@(1&{)) @ rxmatch_jregex_
ffmatches=: ({.@{.+{:@(1&{))"2 @ rxmatches_jregex_

fiwsbs=: #~ -.@('\\'&E.)
fiwplain=: ;@(,~&.> e.&'[](){}$^.*+?|\' #&.> (<PATHSEP_j_)"_)
a=. ,&';'
b=. e.&', ;' > [: ~:/\ e.&'"'
c=. b (< @ (-.&'"')) ;._2 ]
d=. -.&a:
fcut=: d@c@a f.
comments=: 3 : 0
txt=. <;._2 y,LF
f=. 'NB.'&E. <: ~:/\@(''''&=)
g=. i.&0 + 3: * 0&e.
h=. g@f ($&' '@[ , }.) ]
txt=. h each txt
}: ;txt ,each LF
)
fiwmax=: 3 : 0
dat=. y #~ ~: {."1 ,. y
(FIWMAX <. #dat) {. dat
)
JFIR=: 0 : 0
pc6j jfir closeok;pn "Find and Replace";
xywh 2 8 40 11;cc s0 static ss_right;cn "Find what:";
xywh 45 7 122 70;cc what combodrop ws_border cbs_autohscroll rightmove;
xywh 2 26 40 11;cc s1 static ss_right;cn "In context:";
xywh 45 25 70 100;cc context combolist rightmove;
xywh 2 49 40 11;cc s2 static ss_right;cn "Replace:";
xywh 45 48 122 70;cc repwhat combodrop ws_border cbs_autohscroll rightmove;
xywh 119 26 53 12;cc case checkbox leftmove rightmove;cn "Match case";
xywh 91 64 80 12;cc undo button leftmove rightmove;cn "Undo Last";
xywh 176 4 80 12;cc findtop button bs_defpushbutton leftmove rightmove;cn "Find Top (Ctrl+F3)";
xywh 176 19 80 12;cc find button leftmove rightmove;cn "Find Next (F3)";
xywh 176 34 80 12;cc findback button bs_defpushbutton leftmove rightmove;cn "Find Back (Shift+F3)";
xywh 176 49 80 12;cc replace button leftmove rightmove;cn "Replace";
xywh 176 64 80 12;cc replaceall button leftmove rightmove;cn "Replace Forward";
pas 8 2;pcenter;ptop;
rem form end;
)
jfir_run=: 3 : 0
FIWINC=: 0
FIWHOLD=: FIWH
oldformx=. 0 ".wd'qformx'
wd JFIR
FIWH=: wd 'qhwndp'
wd 'setfocus what'
wd 'set context *',FIWCONTEXT
if. #FIWFIND do.
  txt=. {."1 FIWFIND
  wd 'set what *',utf8 tolist txt
  if. #FIWWHAT do.
    wd 'setselect what ',":ndx=. txt i. <FIWWHAT
    FIWCASE=: 2 pick ndx{FIWFIND
    FIWCONNDX=: 1 pick ndx{FIWFIND
    wd 'setfocus repwhat'
  end.
end.
if. #FIWREPLACE do.
  wd 'set repwhat *',utf8 tolist FIWREPLACE
end.
wd 'setselect context ',":{:0,FIWCONNDX
wd 'set case ',":FIWCASE
wd 'setenable undo 0'
wd 'pmovex ',":(3 {. oldformx),{: 0 ". wd'qformx'
wd 'pshow'
wd 'psel ',FIWHOLD
wd 'pclose;psel ',FIWH
wd 'pactive'
)
jfir_read=: 3 : 0
FIWINC=: 0
jfir_readrest''
)
jfir_readrest=: 3 : 0
jfiw_readrest''
FIWREPWHAT=: ucp repwhat
jfirsetfind''
)
jfir_readundo=: 3 : 0
FIWTEXTOLD=: FIWTEXT
FIWPOSOLD=: FIWPOS
FIWINCOLD=: FIWINC
)
jfirsetfind=: 3 : 0
if. #FIWREPWHAT do.
  FIWREPLACE_j_=: fiwmax (<FIWREPWHAT),FIWREPLACE
  wd 'set repwhat *',utf8 tolist FIWREPLACE
  wd 'setselect repwhat 0'
end.
)
jfir_close=: 3 : 0
if. #FIWH do.
  wd 'psel ',FIWH
  wd 'pclose'
  FIWH=: ''
end.
)
jfirok=: 3 : 0
if. 0=#FIWWHAT do. 0 [ frinfo 'Nothing to replace' return. end.
if. FIWREPWHAT-:FIWWHAT do.
  0 [ frinfo 'Find and Replace texts are the same' return.
end.
1
)
jfir_replace_button=: 3 : 0
jfir_readrest''
if. 0=jfirok'' do. FIWINC=0 return. end.
if. FIWINC=0 do.
  old=. FIWPOS
  dat=. fwss''
  if. dat=_1 do. return. end.
  if. dat=_2 do. frinfo 'No match found' return. end.
  FIWPOS=: dat
  FIWINC=: 1
  if. old~:FIWPOS do. jfir_show'' return. end.
end.
jfir_readundo''
dat=. fwrs''
smwrite FIWTEXT
wd 'psel ',FIWH
wd 'setenable undo 1'
if. dat=_3 do.
  jfir_show 1
  FIWINC=: 0
else.
  FIWINC=: 1
  FIWPOS=: dat
  jfir_show''
end.
)
jfir_replaceall_button=: 3 : 0
jfir_read''
if. 0=jfirok'' do. return. end.
count=. 0
old=. FIWPOS
dat=. fwss''
if. dat=_1 do. return. end.
if. dat=_2 do. frinfo 'No matches found' return. end.
FIWPOS=: dat
FIWINC=: 1
jfir_readundo''
whilst. 0 <: dat do.
  count=. count + 1
  dat=. fwrs''
end.
wd 'psel ',FIWH
wd 'setenable undo 1'
smwrite FIWTEXT
wd 'psel ',FIWH
frinfo (":count),' replacement',((1<count)#'s'),' made'
FIWINC=: 0
)
jfir_repwhat_select=: 3 : 0
FIWINC=: 0
FIWREPWHAT=: repwhat
jfirsetfind''
)
jfir_undo_button=: 3 : 0
FIWTEXT=: FIWTEXTOLD
FIWPOS=: FIWPOSOLD
FIWINC=: FIWINCOLD
wd 'psel ',FIWH
wd 'setenable undo 0'
smwrite FIWTEXT
jfir_show''
)
jfir_show=: 3 : 0
if. y-:1 do. len=. 0 else. len=. #FIWWHAT end.
smscroll 0 >. _7 + +/ LF = FIWPOS {. FIWTEXT
smsetselect (FIWPOS+0,len),1
smfocus''
)
jfir_case_button=: jfiw_case_button
jfir_find_button=: jfiw_find_button
jfir_findback_button=: jfiw_findback_button
jfir_findtop_button=: jfiw_findtop_button
jfir_context_button=: jfiw_find_button
jfir_what_button=: jfiw_what_button
jfir_enter=: jfir_context_button=: jfir_repwhat_button=: jfiw_find_button
jfir_what_select=: jfiw_what_select
jfir_context_select=: jfiw_context_select
jfir_fctrl_fkey=: jfiw_find_button

jfir_fctrl_fkey=: jfiw_find_button bind 1
jfir_f3_fkey=: jfiw_find_button bind 1
jfir_f3ctrl_fkey=: jfiw_find_button bind 0
jfir_f3shift_fkey=: jfiw_find_button bind _1

jfir_cancel_button=: jfir_cancel=: jfir_close
fwssinit=: 3 : 0

p=. y
nna=. '(^|[^[:alnum:]_])'
nnz=. '($|[^[:alnum:]_])'

select. FIWCONNDX
case. 1 do. p=. nna,p,nnz
case. 2 do. p=. nna,p,'[[:space:]]*=[.:]'
case. 3 do. p=. nna,p,'[[:space:]]*=:'
case. 4 do. p=. nna,p,'[[:space:]]*=\.'
end.

FIWCOMP=: rxcomp_jregex_ :: _1: p

if. FIWCOMP -: _1 do.
  finfo 'Unable to compile regular expression'
  0
else.
  1
end.
)
fwss=: 3 : 0

if. FIWCASE=0 do.
  txt=. tolower FIWTEXT
  what=. tolower FIWWHAT
else.
  txt=. FIWTEXT
  what=. FIWWHAT
end.

regex=. FIWCONNDX e. 1 2 3 4

if. regex do.
  if. 0=fwssinit what do. _1 return. end.
end.

if. FIWCONNDX=5 do.
  txt=. comments txt
end.

if. FIWDOWN=0 do.
  blk=. FIWPOS{.txt
  if. regex do.
    ndx=. FIWCOMP ffmatches blk
    rxfree_jregex_ FIWCOMP
  else.
    ndx=. I. what E. blk
  end.
  if. 0 e. $ndx do. _2 else. {:ndx end.
else.
  blk=. (FIWPOS+FIWINC)}.txt
  if. regex do.
    ndx=. _1 -.~ FIWCOMP ffmatch blk
    rxfree_jregex_ FIWCOMP
  else.
    ndx=. I. what E. blk
  end.
  if. 0 e. $ndx do. _2 else. FIWPOS+FIWINC+{.ndx end.
end.
)
fwrs=: 3 : 0
FIWTEXT=: (FIWPOS{.FIWTEXT),FIWREPWHAT,(FIWPOS+#FIWWHAT)}.FIWTEXT
old=. FIWPOS
FIWPOS=: FIWPOS+FIWDOWN * 0 >. <:#FIWREPWHAT
hit=. fwss''
if. hit<0 do.
  FIWPOS=: old
  _3
else.
  FIWPOS=: hit
end.
)
JFIW=: 0 : 0
pc6j jfiw;pn "Find";
xywh 2 8 40 11;cc s0 static ss_right;cn "Find what:";
xywh 45 7 122 70;cc what combodrop ws_border cbs_autohscroll rightmove;
xywh 2 26 40 11;cc s1 static ss_right;cn "In context:";
xywh 45 25 70 100;cc context combolist rightmove;
xywh 119 26 53 12;cc case checkbox leftmove rightmove;cn "Match case";
xywh 176 4 80 12;cc findtop button bs_defpushbutton leftmove rightmove;cn "Find Top (Ctrl+F3)";
xywh 176 19 80 12;cc find button leftmove rightmove;cn "Find Next (F3)";
xywh 176 34 80 12;cc findback button leftmove rightmove;cn "Find Back (Shift+F3)";
xywh 176 49 80 12;cc replace button leftmove rightmove;cn "Replace...";
pas 8 2;pcenter;ptop;
rem form end;
)
jfiw_run=: 3 : 0
if. wdishandle FIWH do.
  wd 'psel ',FIWH
  jfiw_find_button y
  return.
end.
FIWINC=: 0
FIWDOWN=: 1
FIWDEFAULT=: 1
wd JFIW
FIWH=: wd 'qhwndp'
wpset 'jfiw'
wd 'set context *',FIWCONTEXT
if. #FIWFIND do. jfiwsetfind 0 end.
wd 'setselect context ',":FIWCONNDX
wd 'set case ',":FIWCASE
wd 'setfocus what'
wd 'pshow'
)
jfiw_close=: 3 : 0
if. #FIWH do.
  wd 'psel ',FIWH
  wpsave 'jfiw'
  wd 'psel ',FIWH
end.
wd 'pclose'
FIWH=: ''
)
jfiw_read=: 3 : 0
FIWINC=: 0
jfiw_readrest''
)
jfiw_readrest=: 3 : 0
FIWWHAT=: ucp what
FIWCONNDX=: {: 0,". context_select
FIWCASE=: ". case
if. #FIWWHAT do.
  FIWFIND_j_=: fiwmax (FIWWHAT;FIWCONNDX;FIWCASE),FIWFIND
  wd 'set what *',utf8 tolist {."1 FIWFIND
  wd 'setselect what 0'
end.
smselact''
FIWTEXT=: smread ''
FIWPOS=: {. smgetsel ''
wd 'psel ',FIWH
)
jfiw_find_button=: 3 : 0
if. 0=#FIWH do. return. end.
jfiw_readrest''
y=. {. y,1
select. y
case. _1 do.
  FIWDOWN=: 0
case. 0 do.
  FIWPOS=: 0
  FIWINC=: 0
  FIWDOWN=: 1
  FIWDEFAULT=: 1
case. do.
  FIWDOWN=: 1
  FIWDEFAULT=: 0
end.
dat=. fwss''
if. _1-:dat do. return. end.
if. _2-:dat do. finfo 'No match found' return. end.
FIWPOS=: dat
jfiw_show''
FIWINC=: 1
)
jfiw_findback_button=: jfiw_find_button bind _1
jfiw_findtop_button=: jfiw_find_button bind 0
jfiw_finddefault=: 3 : 0
jfiw_find_button FIWDEFAULT
)
jfiw_show=: 3 : 0
if. y-:1 do. len=. 0 else. len=. #FIWWHAT end.
smsetselect (FIWPOS+0,len),0
smfocus''
)
jfiw_what_select=: 3 : 0
FIWINC=: 0
if. #what_select do.
  jfiwsetfind ".what_select
end.
)
jfiwsetfind=: 3 : 0
FIWFIND_j_=: FIWFIND /: y ~: i.#FIWFIND
'FIWWHAT FIWCONNDX FIWCASE'=: 0{FIWFIND
wd 'set what *',utf8 tolist {."1 FIWFIND
wd 'setselect what 0'
wd 'set case ',":FIWCASE
wd 'setselect context ',":FIWCONNDX
)
jfiw_enter=: jfiw_what_button=: jfiw_context_button=: jfiw_finddefault
jfiw_cancel_button=: jfiw_cancel=: jfiw_close
jfiw_replace_button=: jfir_run @ jfiw_read
jfiw_rctrl_fkey=: jfiw_replace_button
jfiw_context_select=: jfiw_read
jfiw_case_button=: jfiw_read

jfiw_fctrl_fkey=: jfiw_find_button bind 1
jfiw_f3_fkey=: jfiw_find_button bind 1
jfiw_f3ctrl_fkey=: jfiw_find_button bind 0
jfiw_f3shift_fkey=: jfiw_find_button bind _1

fiw=: jfiw_run
