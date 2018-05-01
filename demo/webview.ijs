NB. webview
NB.
NB. !!! this is experimental and *will* change...
NB.
NB. cover for the QWebView
NB. cmd so far:
NB.  set c url url
NB.  set c baseurl url
NB.  set c html text

coclass 'jndemo'

NB. =========================================================
webview=: 3 : 0
wd 'pc8j webview'
wd 'xywh 0 0 400 20'
wd 'cc e edit'
wd 'xywh 0 20 400 400'
wd 'cc w1 webview'
wd 'xywh 400 20 400 400'
wd 'cc w2 webview'
wd 'set e text *http://news.yahoo.com'
wd 'set w1 url *http://news.yahoo.com'
wd 'set w2 baseurl *http://www.jsoftware.com'
wd 'set w2 html *<html><body><img src=''http://www.jsoftware.com/zippy.gif'' /></body></html>'
wd 'pshow'
)

NB. =========================================================
webview_e_button=: 3 : 0
smoutput e
wd 'set w1 url *',e
)

NB. =========================================================
webview_w1_curl=: 3 : 0
wd 'set e text *',w1_curl
)

NB. =========================================================
webview_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
webview''
