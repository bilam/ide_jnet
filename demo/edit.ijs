NB. alignment, password, readonly
NB.

coclass 'jndemo'

NB. =========================================================
edit=: 3 : 0
wd 'fontdef Monospaced 12'
wd 'pc8j edit'
wd 'xywh 10 10 200 21;cc e0 edit'
wd 'xywh 220 10 200 21;cc e4 edit password'
wd 'xywh 440 10 200 21;cc e5 edit readonly'
wd 'xywh 10 40 200 21;cc l1 static left'
wd 'xywh 220 40 200 21;cc l2 static center'
wd 'xywh 440 40 200 21;cc l3 static right'
wd 'xywh 10 70 200 21;cc e1 edit left'
wd 'xywh 220 70 200 21;cc e2 edit center'
wd 'xywh 440 70 200 21;cc e3 edit right'
wd 'xywh 10 100 200 21;cc l4 static;cn "integer"'
wd 'xywh 220 100 200 21;cc v1 editint'
wd 'xywh 10 130 200 21;cc l5 static;cn "float"'
wd 'xywh 220 130 200 21;cc v2 editnum'
wd 'xywh 10 160 200 21;cc l6 static;cn "date in dd/mm/yyyy"'
wd 'xywh 220 160 200 21;cc v3 edit'
wd 'xywh 10 190 200 21;cc l7 static;cn "input mask phone number"'
wd 'xywh 220 190 200 21;cc v4 editmask;set _ mask "(999)-000-0000"'
wd 'pshow'
wd 'fontdef'
wd 'set e0 limit 10'
wd 'set e0 text limit=10'
wd 'set e1 text left'
wd 'set e2 text center'
wd 'set e3 text right'
wd 'set e4 text password'
wd 'set e5 text readonly'
wd 'set l1 text left'
wd 'set l2 text center'
wd 'set l3 text right'
)

NB. =========================================================
edit_e0_button=: 3 : 0
smoutput 'e0 button event'
)

NB. =========================================================
edit_e0_char=: 3 : 0
if. 16bf800 <: 3 u: ucp sysdata do.
  smoutput 'e0 char event keycode: ', ": 3 u: ucp sysdata
else.
  smoutput 'e0 char event key: ', sysdata
end.
)

NB. =========================================================
edit_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
edit''
