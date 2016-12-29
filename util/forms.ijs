coclass 'jforms'

FPN=: 'Forms Manager'

resetforms=: 3 : 0
FNMS=: ''
FIDS=: ''
FSEL=: ''
FTYP=: ''
)

resetforms''
info=: wdinfo @ (FPN&;)
query=: wdquery FPN&;
getforms=: 3 : 0
'FIDS FTYP FNMS'=: readforms''
FSEL=: FSEL #~ FSEL e. FIDS
)
getfilename=: #~ [: *./\. ~:&PATHSEP_j_
readforms=: 3 : 0
fm=. wdforms''
msk=. -. ('jforms';FPN) -:"1 [ 0 5 {"1 fm
fm=. msk # fm
if. #fm do.
  id=. 1 {"1 fm
  ty=. 3 {"1 fm
  nm=. jpathsep &.> 5 {"1 fm
  ndx=. I. 0 < # &> 3 {"1 fm
  nm=. (getfilename each ndx { nm) ndx } nm
  res=. id ; ty ; <nm
  ind=. /: (3 {"1 fm),.nm
  ind&{ each res
else.
  '';''
end.
)
readformids=: 3 : 0
1 {"1 wdforms''
)
getselids=: 3 : 0
FSEL=: FIDS {~ 0 ". fms_select
)
pset=: 3 : 0
getselids''
psetcmd y
showforms''
)
psetcmd=: 3 : 0
'id ty nm'=. readforms''
fms=. FSEL #~ FSEL e. id
if. 0 = #fms do. return. end.
if. y -: 'pclose' do.
  msk=. -. id e. fms
  if. -. (<'jijx') e. msk # ty do.
    if. 1 = #fms do.
      info 'Cannot close the J session' return.
    else.

      info 'Closing all but the J session'
      ndx=. (<'jijx') i.~ (id i. fms) { ty
      fms=. fms -. ndx { id
    end.

  end.
end.
if. 0 = #fms do. return. end.
wd }. ; ';psel '&, each ,&(';',y) each fms
)
setselect=: 3 : 0
wd 'setselect fms -1'
if. #y do.
  wd }. ; ';setselect fms '&, @ ": each y
end.
)
showforms=: 3 : 0
getforms''
wd 'psel ',HWNDP
if. #FNMS do.
  fms=. DEL ,each FNMS ,each DEL
  wd 'set fms ', ;fms
  if. #FSEL do.
    setselect FIDS i. FSEL
  else.
    setselect 0
  end.
else.
  wd 'set fms'
end.
)
JFORMS=: 0 : 0
pc6j jforms closeok;
xywh 5 5 110 105;cc fms listbox lbs_extendedsel lbs_multiplesel rightmove bottommove;
xywh 121 4 58 12;cc act button bs_defpushbutton leftmove rightmove;cn "&Activate";
xywh 121 17 58 12;cc res button leftmove rightmove;cn "&Restore";
xywh 121 30 58 12;cc min button leftmove rightmove;cn "Mi&nimize";
xywh 121 43 58 12;cc cls button leftmove rightmove;cn "&Close";
xywh 121 60 58 12;cc invert button leftmove topmove rightmove bottommove;cn "&Invert Select";
xywh 121 77 58 12;cc ref button leftmove topmove rightmove bottommove;cn "Re&fresh";
xywh 121 94 58 12;cc cancel button leftmove topmove rightmove bottommove;cn "Cancel";
pas 4 0;pcenter;
rem form end;
)
jforms_run=: 3 : 0
if. 0 = # readforms'' do.
  wdinfo FPN;'No forms' return.
end.
resetforms''
wd JFORMS
wd 'pn *',FPN
HWNDP=: wd 'qhwndp'
showforms''
wd 'pshow;'
)
jforms_invert_button=: 3 : 0
setselect (i.#FNMS) -. 0 ". fms_select
)
jforms_act_button=: pset bind 'pactive'
jforms_cls_button=: pset bind 'pclose'
jforms_ref_button=: showforms
jforms_min_button=: pset bind 'pshow sw_minimize'
jforms_res_button=: pset bind 'pshow sw_restore'
jforms_close=: jforms_cancel_button=: wd bind 'pclose'
jforms_fms_button=: jforms_act_button
jforms_fms_select=: ]
forms=: jforms_run

