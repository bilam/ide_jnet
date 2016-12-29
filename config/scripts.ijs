NB. scripts.ijs
NB.
NB. defines noun Public (in j locale)
NB.
NB. file extensions default to .ijs
NB. file names beginning system are saved as ~system.

cocurrent 'j'

NB. =========================================================
NB. Public definitions
NB. form:  shortname longname
buildpublic^:0] 0 : 0
afm          system/classes/plot/afm
bigfiles     system/packages/files/bigfiles
bmp          system/packages/graphics/bmp
break        system/main/break
colib        system/main/colib
color16      system/packages/color/color16
colortab     system/packages/color/colortab
compare      system/main/compare
conlib       system/main/conlib
convert      system/main/convert
coutil       system/main/coutil
csv          system/packages/files/csv
dates        system/main/dates
dd           system/main/dd
debug        system/main/debug
dir          system/main/dir
dirbrowse    system/packages/winapi/dirbrowse
dirmatch     addons/ide/jnet/util/dirmatch
dll          system/main/dll
export       system/packages/export/export
files        system/main/files
font         system/packages/misc/font
format       system/main/format
gl2          system/main/gl2
gl3          system/main/gl3
graph        system/classes/graph/graph
grid         system/classes/grid/grid
guid         system/packages/misc/guid
isigraph     system/packages/graphics/isigraph
jfiles       system/packages/files/jfiles
jmf          system/main/jmf
jp           addons/ide/jnet/util/jp
jpm          addons/ide/jnet/util/jpm
keyfiles     system/packages/files/keyfiles
kfiles       system/packages/files/kfiles
libpath      system/main/libpath
map          system/main/map
menu         system/packages/winapi/menu
misc         system/main/misc
myutil       system/main/myutil
nfiles       system/packages/files/nfiles
numeric      system/main/numeric
odbc         system/packages/odbc/odbc
opengl       system/classes/opengl/opengl
pack         system/main/pack
pacman       addons/ide/jnet/util/pacman
parts        system/main/parts
plot         system/classes/plot/plot
plotdefs     system/classes/plot/plotdefs
primitives   system/packages/misc/primitiv
print        system/packages/print/print
printf       system/main/printf
random       system/packages/stats/random
regex        system/main/regex
registry     system/packages/winapi/registry
rgb          system/packages/color/rgb
scriptdoc    addons/ide/jnet/util/scripdoc
socket       system/main/socket
statdist     system/packages/stats/statdist
statfns      system/packages/stats/statfns
stats        system/packages/stats/stats
stdlib       system/main/stdlib
strings      system/main/strings
sysenv       system/main/sysenv
tar          addons/ide/jnet/util/tar
task         system/packages/misc/task
text         system/main/text
trace        system/packages/misc/trace
trig         system/main/trig
turtle       system/packages/misc/jturtle
unicode      system/main/unicode
validate     system/main/validate
viewmat      system/classes/view/viewmat
winapi       system/packages/winapi/winapi
winlib       system/main/winlib
)

NB. =========================================================
NB. Public classes:
buildpublic^:0] 0 : 0
jbrowse      system/classes/browse/jbrowse
jdgrid       system/classes/grid/jdgrid
jdirs        system/classes/dir/jdirs
jfiletype    system/classes/input/jfiletype
jfreport     system/classes/grid/jfreport
jinput       system/classes/input/jinput
jndict       system/classes/dict/jndict
jpwd         system/classes/input/jpwd
jselect      system/classes/input/jselect
jserver      system/classes/socket/jserver
jsgrid       system/classes/grid/jsgrid
jsplitter    system/classes/splitter/jsplitter
jssc         system/classes/cs/jssc
jsss         system/classes/cs/jsss
jtable       system/classes/grid/jtable
jtelnet      system/classes/socket/jtelnet
jtgrid       system/classes/grid/jtgrid
jtreeview    system/classes/treeview/jtreeview
jvgrid       system/classes/grid/jvgrid
jwdict       system/classes/dict/jwdict
jzdict       system/classes/dict/jzdict
jzgraph      system/classes/graph/jzgraph
jzgrid       system/classes/grid/jzgrid
jzopengl     system/classes/opengl/jzopengl
jzopenglutil system/classes/opengl/jzopenglutil
jzplot       system/classes/plot/jzplot
)
