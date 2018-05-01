NB. console library
NB.
NB. this script is loaded when J is run from the console,
NB. in addition to sysenv, stdlib, colib and break

18!:4 <'z'

getenv=: 2!:5
echo=: 0 0&$ @ (1!:2&2)
stdout=: 1!:2&4
stderr=: 1!:2&5
stdin=: 1!:1@3: :. stdout

NB. *getargs v was written by Joey K Tuttle
getargs=: 3 : 0
ARGV getargs y
:
argb=. (]`(([: < 1: {. }.) , [: < 2: }. ])@.('-'"_ = {.))&.> x
NB. The above boxes parms (elements starting with "-" returning name;value
parm=. 32 = ;(3!:0)&.> argb
((-. parm)#argb);(>parm#argb);(". (0 = isatty 0)#'stdin ''''')
)

NB. =========================================================
NB. jhelp
NB. for example, jhelp 'netscape'
jhelp=: 3 : 0
if. ''-:y do. 'for example, jhelp ''netscape''' return. end.
2!:1 y,' ',jpath '~help/index.htm &'
)

NB. =========================================================
NB. wd substitutes (only if console)
3 : 0''
if. 0 -: (11!:0) :: 0: '' do.
  wd=: ''"1 _ _
  wdinfo=: (i.0 0)"_
  wdclippaste=: (''"_)
  wdqchildxywh=: (0 0 0 0"_)
  wdqchildxywhx=: (0 0 0 0"_)
  wdqcolor=: ( 0 0 0"_)
  wdqd=: (''"_)
  wdqer=: (''"_)
  wdqformx=: (0 0 800 600"_)
  wdqhinst=: 0:
  wdqhwndc=: 0:
  wdqhwndp=: 0:
  wdqhwndx=: 0:
  wdqm=: (800 600 8 16 1 1 3 3 4 4 19 19 0 0 800 570"_)
  wdqp=: (''"_)
  wdqprinters=: (''"_)
  wdqpx=: (''"_)
  wdqq=: (''"_)
  wdqscreen=: (264 211 800 600 96 96 32 1 _1 36 36 51"_)
  wdqwd=: (''"_)
end.
i.0 0
)

NB. *fliprgb v flip between argb and abgr byte order
fliprgb=: 3 : 0
s=. $y
d=. ((#y),4)$2 (3!:4) y=. <.,y
d=. 2 1 0 3{"1 d
s$_2(3!:4),d
)
