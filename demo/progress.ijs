NB. progressbar demo
NB.
NB. cc prog progressbar [v] [min] [max] [value];
NB.
NB. min,max,value should be integers

coclass 'jndemo'

NB. =========================================================
PBdemo=: 0 : 0
pc pbdemo closeok escclose;
minwh 400 200;cc prog progressbar 0 20 7;
)

NB. =========================================================
pbdemo_run=: 3 : 0
wd PBdemo
wd 'pshow'
)

NB. =========================================================
pbdemo_run''
smoutput 0 : 0
Try:
  wd 'set prog pos 11'
  wd 'set prog max 30'
)
