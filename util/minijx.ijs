NB. minijx
NB.
NB. minimal ijx window - useful for testing jexe server
NB. or standalone applications.
NB.
NB. this is the window that is created when J is loaded
NB. with parameter -jprofile and no script file.

NB. =========================================================
11!:0 'pc ijx closeok;xywh 0 0 300 200'
11!:0 'cc e editijx ws_hscroll ws_vscroll es_nohidesel rightmove bottommove'
11!:0 'setfont e ',>(5=9!:12'') { '"Courier New" 12';'"DejaVu Sans Mono" 12'
11!:0 'pas 0 0;pgroup jijx;pshow'
