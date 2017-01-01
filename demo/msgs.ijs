NB. msgs
NB.

coclass 'jndemo'

NB. =========================================================
msgs=: 3 : 0
wd 'pc6j msgs'
wd 'xywh 10 10 120 20;cc ms checkbox;cn "smoutput immediately";'
wd 'xywh 10 50 60 20;cc bu button;cn start;'
wd 'xywh 10 90 200 20;cc prog progress'
wd 'pshow'
)

NB. =========================================================
msgs_bu_button=: 3 : 0
closef=: 0
usemsgs=. 0 ". ms
for_i. i.11 do.
  if. closef do. break. end.
  wd 'set prog ', ":10*10-i
  smoutput 10-i
  wd^:usemsgs 'msgs'
  6!:3[1
end.
)

NB. =========================================================
msgs_close=: 3 : 0
closef=: 1
wd 'pclose'
)

NB. =========================================================
msgs''
