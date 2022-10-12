NB. ide/jnet manifest

CAPTION=: 'JNET IDE'

DESCRIPTION=: 0 : 0
JNET IDE *not* supported by Jsoftware.

Copy one of the three jnet.exe files to your j bin directory.

Windows:
 install .net framework 4.0 or later
 (already pre-installed on Windows 8 or 10)
 start J by double click jnet.exe
Linux:
 sudo apt-get install mono-complete
 start J by typing mono jnet.exe

Read data/migration.txt for differences with J6 wd commands.
)

VERSION=: '1.0.26'

PLATFORMS=: 'windows linux'

DEPENDS=: 0 : 0
general/misc
graphics/bmp
)

FILES=: 0 : 0
conlib.ijs
gl2.ijs
gl3.ijs
jnet.ijs
newuser.ijs
winlib.ijs
bin/
classes/
config/
data/
demo/
util/
)

RELEASE=: 'j805'

FOLDER=: 'ide/jnet'
