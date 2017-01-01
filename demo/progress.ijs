NB. progressbar demo
NB.
NB. cc prog progressbar [v] [min] [max] [value];
NB.
NB. min,max,value should be integers

coclass 'jndemo'

NB. =========================================================
PBdemo=: 0 : 0
pc6j pbdemo closeok;
xywh 0 0 200 100;cc prog progress;
)

NB. =========================================================
pbdemo_run=: 3 : 0
wd PBdemo
wd 'pshow'
wd 'set prog 20'
)

NB. =========================================================
pbdemo_run''
smoutput 0 : 0
Try:
  wd 'set prog pos 11'
  wd 'set prog max 30'
)
