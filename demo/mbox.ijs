NB. mb (message box) demo
NB.
NB. the message box syntax is:
NB.   wd 'mb type buttons title message'
NB.
NB. type specifies the icon and default behaviour:
NB.  info      (default OK button)
NB.  warn      (default OK button)
NB.  critical  (default OK button)
NB.  query     (requires two or three buttons)
NB.
NB. if one button, there is no result,
NB. otherwise the result is the button name (ok, cancel, ...)
NB.
NB. buttons are from the set, defbutton {} is the default:
NB.  mb_abortretryignore The message box contains Abort, Retry, and Ignore buttons.
NB.  mb_ok               The message box contains an OK button.
NB.  mb_okcancel         The message box contains OK and Cancel buttons.
NB.  mb_retrycancel      The message box contains Retry and Cancel buttons.
NB.  mb_yesno            The message box contains Yes and No buttons.
NB.  mb_yesnocancel      The message box contains Yes, No, and Cancel buttons.
NB.
NB. defbutton if present is either
NB.  mb_defbutton1,  mb_defbutton2,  mb_defbutton3

coclass 'jndemo'

demo1=: 3 : 0
wd 'mb info *Job finished.',LF,LF,'Goodbye.'
)

demo2=: 3 : 0
wd 'mb warn "Model Run" "Job finished early."'
)

demo3=: 3 : 0
wd 'mb critical "Model Run" "Job failed."'
)

demo4=: 3 : 0
wd 'mb query mb_okcancel "Model Run" "OK to save?"'
)

demo5=: 3 : 0
wd 'mb query mb_defbutton2 mb_yesnocancel "Model Run" "OK to continue?"'
)

demo1''
demo2''
demo3''
smoutput demo4''
smoutput demo5''
