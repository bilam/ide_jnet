NB. debug definitions and utilities

cocurrent 'z'

NB. =========================================================
NB.*dbgjn v turn debugging window on/off
dbgjn=: 3 : 0
if. y do.
  if. _1 = 4!:0 <'jdb_open_jdebug_' do.
    0!:0 <jpath '~addons/ide/jnet/util/debugs.ijs'
  end.
  jdb_open_jdebug_''
  smfocusact_jijs_''
  13!:0 [ 1
else.
  jdb_close_jdebug_ :: ] ''
  13!:15 ''
  13!:0 [ 0
end.
)

NB. =========================================================
NB.*dbview v view stack
dbview=: 3 : 0
if. _1 = 4!:0 <'jdbview_jdbview_' do.
  require 'ide/jnet/util/dbview'
end.
jdbview_jdbview_ }. 13!:13''
)
