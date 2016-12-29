coclass 'jhelp'
coinsert 'jijs';'j'

0!:0 <jpath '~addons/ide/jnet/util/helpndx.ijs'

j=. ((i.&' ')({.;}.-.' '"_)]);._2 DICTNDX
DICT=: {."1 j
DICTX=: {:"1 j
help=: 3 : 0
if. 0=#y do.

  smselact''
  txt=. smread''
  if. =/r=. smgetsel'' do.
    pos=. {.r
    ndx=. pos + (pos }. txt) i. LF
    txt=. ndx {. txt
    ndx=. - (|. txt) i. LF
    pos=. pos - ndx + #txt
    txt=. ndx {. txt
    if. '[-' -: }. 3 {. txt do.
      if. helperror txt do. return. end.
    end.
    at=. pos{txt,LF
    as=. pos{LF,txt
    if. *./ (at,as) e. ' ',CRLF do.
      helpword txt return.
    end.
    sep=. {.~ <./ @ (i.&('() ''',{.a.))
    beg=. sep&.|. pos{.txt
    bit=. beg,sep pos}.txt

    if. 0=#bit-.' ' do.
      y=. ''
    else.
      wds=. ;:bit
      len=. #&>}:wds
      y=. > wds {~ 0 i.~ (#beg)>:+/\len
    end.
  else.
    y=. txt {~ ({.r) + i. --/r
  end.

end.
if. 0 = #y do. return. end.
if. #ndx=. helpndx y do.
  htmlhelp 'dictionary/',ndx
elseif. _1 < ndx=. 4!:4 :: _1: boxopen y do.
  scriptdoc ndx { 4!:3 ''
elseif. do.
  wdinfo 'Help';'Help topic not found: ',":y
end.
)
helpndx=: 3 : 0
y=. ,y
if. 2 = 3!:0 y do.
  if. 'goto_' -: 5{.y do. y=. 'goto_?'
  elseif. 'for_' -: 4{.y do. y=. 'for_?'
  elseif. 'label_' -: 6{.y do. y=. 'label_?'
  end.
  top=. <y
  if. top e. DICT do.
    (>DICTX {~ DICT i.top),'.htm'
  else. ''
  end.
end.
)
helpword=: 3 : 0
smselout ''
txt=. smread ''
txt=. txt {.~ 1 + 0 i:~ txt=' '
txt=. txt,LF -. {:txt
txt=. txt,ucpboxdraw,(": ;: y),.LF
smselout''
smwrite txt
smprompt '   '
)
helperror=: 3 : 0
txt=. 3 }. y
ndx=. txt i. ']'
if. ndx = #txt do. 0 return. end.
pos=. _1 ". ndx {. txt
if. 1 ~: #pos do. 0 return. end.
if. _1 = pos do. 0 return. end.
smopen CR -.~ deb (ndx+1) }. txt
txt=. smread ''
lns=. 0, >: I. LF = txt, LF
smscroll 0 >. pos - 7
if. pos < <: # lns do.
  smsetselect (0 _1 + (pos + 0 1) { lns), 0
end.
smfocus''
1
)

