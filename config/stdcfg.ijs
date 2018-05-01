NB. standard configuration

FIXFONTW=: '"Courier New" 12'
PROFONTW=: '"MS Sans Serif" 10'

3 : 0''
if. IFUNIX do.
  FIXFONTJ=: IFJAVA{::'"DejaVu Sans Mono" 12';'Monospaced 12'
  PROFONTJ=: IFJAVA{::'"DejaVu Serif" 10';'SansSerif 10'
else.
  FIXFONTJ=: FIXFONTW
  PROFONTJ=: PROFONTW
end.
)

PRINTERFONT=: FIXFONTJ
P2UPFONT=: IFUNIX{::'"Courier New" 7.5 bold';'"DejaVu Serif" 7.5 bold'
SMPRINT=: 'print'
PRINTOPT=: ''
SMINIT=: 0 0 700 500
SMSIZE=: 700 500
SMSTYLE=: 3
BOXFORM=: UNAME -: 'Darwin'
BOXPOS=: 0 0
BROWSER=: ''
CONFIRMCLOSE=: 1
DIRTREEX=: ''
DISPLAYFORM=: 2
EPSREADER=: ''
FORMAT=: 1 0 2 1 0 0
FORMSIZES=: 48 12 60 12 11
MEMORYLIM=: _
NEWUSER=: 1
OPTOLDISIGRAPH=: 0
OPTMB=: 0
OPTPC6J=: 0
OPTTWIP=: 0
OUTPUT=: 0 256 0 222
PDFREADER=: ''
PRINTPREC=: 6
READONLY=: 0
SHOWSIP=: 1
STARTUP=: '~config/startup.ijs'
STATUSBAR=: 1
SMCOLORID=: 'JStandard'
XDIFF=: ''
XNAMES=: 0

FKEYS=: 0 : 0
'f3';'1';'Find Next';'editfind_j_ 1'
'f3ctrl';'1';'Find Top';'editfind_j_ 0'
'f3shift';'1';'Find Back';'editfind_j_ _1'
'f12';'1';'Toggle IJX|Last IJS';'togglexs_jijs_'''''
)

SMCOLOR=: JStandard

SKEYS=: 0 : 0
)

USERFOLDERS=: 0 : 0
'Projects';'~user/projects';0
'User';'~user';0
'System';'~system';0
'Addons';'~addons';0
)

