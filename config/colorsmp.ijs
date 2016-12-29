NB. Color Samples script
NB. Color Scheme <JSamples> has entries
NB. for each system color setting.

NB.*abc v example verb
NB. this has format examples
def=: 3 : 0
'this is a text string'
'this is an open quote
'this is selected text'
abc=. 1 2.3 4j5       NB. numbers
mno=. + * ^ %         NB. verbs
rst=: ~ /. \          NB. adverbs
xyz=: " @. ^:         NB. conjunctions
a + ((mno - rst) % b  NB. unmatched paren
'沒有問題','Frábært veður í dag'
if. test do. +/ @: *: i. 10
else. <\ abc
end.
for_j. i do.
  try. %j catch. 'fail' end.
end.
)

NB.*controlwords v verb with all control words
NB. this lists all control words possible in an
NB. explicit definition.
controlwords=. 3 : 0
assert. break. case. catch. catchd. catcht.
continue. do. else. elseif. end. fcase. for.
goto. if. label. return. select. throw. trap.
try. while. whilst.
)

NB. =========================================================
NB. following is a noun definition used as comments
Note 0
assert. break. case. catch. catchd. catcht.
abc=. 1 2.3 4j5, + * ^ %,  ~ /. \
)

NB.* boxed n example noun
NB. this noun has box drawing characters
boxed=: noun define
Normal string here...
┌─┬───────────┬──────────┐
│0│255 255 255│background│
└─┴───────────┴──────────┘
)

┌─┬───────────┬──────────┐
│0│255 255 255│background│
├─┼───────────┼──────────┤
│1│0 0 0      │text      │
└─┴───────────┴──────────┘

-- (3 of 35) Lab Text (ctd) ------------------------------
The standard mathematical functions are + - * % ^ ^., i.e.
plus, minus, times, divide, power and log:
)
   5 + 10 20 30
15 25 35
