coclass 'demoexcel'

a_run=: 3 : 0
f=. winpathsep jpath '~temp/excel'
wd 'pc xlauto owner'
try.
  wd 'cc xlApp oleautomation:excel.application'
catch.
  wdinfo 'Excel is not installed'
  return.
end.
wd 'oleget xlApp base workbooks'   NB. extension will be added by excel
wd 'olemethod xlApp temp Add ,'    NB. , = missing value
wd 'oleid xlApp xlWorkBook'
wd 'oleget xlApp xlWorkBook worksheets'
wd 'oleget xlApp temp item 1'
wd 'oleid xlApp xlWorkSheet'
wd 'oleget xlApp xlWorkSheet cells'
wd 'oleid xlApp xlCells'
wd 'oleget xlApp xlCells item 1 1'
wd 'oleset xlApp temp value "ID"'
wd 'oleget xlApp xlCells item 1 2'
wd 'oleset xlApp temp value "Name"'
wd 'oleget xlApp xlCells item 2 1'
wd 'oleset xlApp temp value "1"'
wd 'oleget xlApp xlCells item 2 2'
wd 'oleset xlApp temp value "One"'
wd 'oleget xlApp xlCells item 3 1'
wd 'oleset xlApp temp value "2"'
wd 'oleget xlApp xlCells item 3 2'
wd 'oleset xlApp temp value "Two"'
NB. index property
wd 'oleset xlApp xlWorkSheet cells 4 2 "ID"'
wd 'oleset xlApp xlWorkSheet cells 4 3 "Name"'
wd 'oleset xlApp xlWorkSheet cells 5 2 "1"'
wd 'oleset xlApp xlWorkSheet cells 5 3 "One"'
wd 'oleset xlApp xlWorkSheet cells 6 2 "2"'
wd 'oleset xlApp xlWorkSheet cells 6 3 "Two"'
wd 'oleset xlApp base displayalerts 0'
wd 'olemethod xlApp xlWorkBook saveas "',f,'" 51'   NB. 51 = workbook default
wd 'olemethod xlApp xlWorkBook close 1'
wd 'olemethod xlApp base quit'
wd 'pclose'
wdinfo 'saved to ', f
)

a_run''

