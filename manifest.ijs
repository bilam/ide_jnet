NB. ide/jnet manifest

CAPTION=: 'JNET IDE'

DESCRIPTION=: 0 : 0
JNET IDE *not* supported by Jsoftware.

Copy one of the three jnet.exe files to your j805 bin directory.

Windows:
 install .net framework 4.0 or later
 (already pre-installed on Windows 8 or 10)
 start J by double click jnet.exe
Linux:
 sudo apt-get install mono-complete
 start J by typing mono jnet.exe
)

VERSION=: '1.0.15'

PLATFORMS=: 'windows linux'

DEPENDS=: 0 : 0
general/misc
graphics/bmp
graphics/gl2
graphics/print
)

FILES=: 0 : 0
gl2.ijs
gl3.ijs
jnet.ijs
newuser.ijs
bin/anycpu/jnet.exe
bin/x64/jnet.exe
bin/x86/jnet.exe
classes/
config/
data/
demo/
util/
)

RELEASE=: 'j805 j806 j807'
