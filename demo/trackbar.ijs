NB. trackbar demo
NB.
NB. cc track trackbar [v] [numeric options]
NB.
NB. numeric options are:
NB. minimum
NB. maximum
NB. position

NB.
NB. min,max,value should be integers

coclass 'jndemo'

NB. =========================================================
SLdemo=: 0 : 0
pc8j trackbardemo;
minwh 200 40;cc track trackbar 0 20 8;
)

NB. =========================================================
trackbardemo_close=: 3 : 0
wd 'pclose'
showevents_jnet_ 0
)

NB. =========================================================
trackbardemo_run=: 3 : 0
wd SLdemo
wd 'pshow'
)

NB. =========================================================
showevents_jnet_ 2
trackbardemo_run''
smoutput 0 : 0
Try:
  wd 'set track pos 11'
  wd 'set track max 30'
)
