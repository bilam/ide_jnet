NB. timer
NB.
NB. argument is milliseconds

coclass 'jndemo'

timer=: 3 : 0
if. y do.
  sys_timer_z_=: 3 : 'smoutput ''systimer: '',":6!:0$0'
  wd 'timer ',":y
else.
  wd 'timer 0'
  sys_timer_z_=: ]
end.
EMPTY
)

NB. =========================================================
jndemo_timer=: 3 : 0
smoutput 'jndemo form timer: ',":6!:0$0
)

NB. =========================================================
smoutput 0 : 0
There are 2 timers - the system timer, and the form timer.

There is only one system timer, while any number of form may have timers.

Examples:

1. system timer, calls sys_timer_z_

start, e.g. every two seconds:
   timer_jndemo_ 2000

stop:
   timer_jndemo_ 0

2. jndemo form timer, calls jndemo_timer
(jndemo form should be active)

start, e.g. every 2 1/2 seconds:
   wd 'ptimer 2500'

stop:
   wd 'ptimer 0'
)
