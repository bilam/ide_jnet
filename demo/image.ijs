NB. image demo

coclass 'jndemo'

NB. =========================================================
imdemo_run=: 3 : 0
if. -. checkrequire 'bmp';'graphics/bmp' do. return. end.
wd 'pc8j imdemo closeok'
wd 'xywh 0 0 150 150;cc pic image'
wd 'xywh 150 0 150 150;cc jpg image stretch'
wd 'xywh 0 150 150 150;cc png image zoom'
wd 'xywh 150 150 150 150;cc bmp image center'
wd 'set pic image *',jpath '~addons/graphics/bmp/toucan.bmp'
NB. convert to jpg
d=. readimg_jnet_ jpath '~addons/graphics/bmp/toucan.bmp'
writeimg_jnet_ d; jpath '~temp/toucan.jpg'
wd 'set jpg image *',jpath '~temp/toucan.jpg'
NB. flip and save as png
d1=. |."1 d
writeimg_jnet_ d1; jpath '~temp/toucan.png'
wd 'set png image *',jpath '~temp/toucan.png'
NB. pure blue
d2=. setalpha 20 200$255
writeimg_jnet_ d2; jpath '~temp/blue.bmp'
wd 'set bmp image *',jpath '~temp/blue.bmp'
wd 'pshow'
)

imdemo_run''
