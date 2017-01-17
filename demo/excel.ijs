coclass 'demoexcel'

a_run=: 3 : 0
if. -. checkrequire_jndemo_ 'tara';'tables/tara' do. return. end.
wd 'pc xlauto owner'
try.
  wd 'cc xl oleautomation:excel.application'
catch.
  wdinfo 'No Excel Application'
  wd 'pclose'
  0 return.
end.
try.
  wd 'oleget xl base workbooks'
  wd 'oleid xl wbs'
  wd 'olemethod xl wbs open "',(jpath '~addons/tables/tara/test/test.xls'),'"'
  wd 'oleid xl wb'
NB.   wd 'oleset xl wb saved 1'
  wd 'oleget xl base worksheets'
  wd 'oleid xl wss'
  echo count=. wd 'oleget xl wss count'
catch.
  echo wd'qer'
  wd 'olemethod xl base quit'
end.
wd 'pclose'
)

a_run''
