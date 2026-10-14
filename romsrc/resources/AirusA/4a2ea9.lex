# 4a2ea9: a ROM lexicon (an Airus AL dictionary): a graph whose nodes each
# stand for a set of characters.  Built by tools/lexicons/newtonlex.py;
# the format is in that file and in tools/lexicons/README.md.
type 0x11

# the character sets, each with the tag the recogniser is told when a
# character of it matched
set s0 "0123456789" "#"
set s1 " " "separ"
set s2 "," "point"
set s3 "-" "minus"
set s4 "#" "numberPre"
set s5 "%$" "suffix_%_$"
set s6 " \x09" "blank"

# the nodes, in the order they lie (the first row is the root's): the
# set, 'word' if a word may end here, 'last' on the last of a row, the
# first child after '->'
node n0 s6 attr=0 -> n0
node n1 s0 word attr=78 -> n8
node n2 s2 attr=0 -> n34
node n3 s3 attr=80 -> n5
node n4 s4 last attr=115 -> n35
node n5 s0 word attr=206 -> n8
node n6 s2 attr=128 -> n34
node n7 s6 last attr=0 -> n5
node n8 s0 word attr=64 -> n12
node n9 s2 word attr=128 -> n31
node n10 s1 attr=0 -> n24
node n11 s5 word last attr=244
node n12 s0 word attr=64 -> n16
node n13 s2 word attr=128 -> n31
node n14 s1 attr=0 -> n24
node n15 s5 word last attr=244
node n16 s0 word attr=64 -> n20
node n17 s2 word attr=128 -> n31
node n18 s1 attr=0 -> n24
node n19 s5 word last attr=244
node n20 s0 word attr=64 -> n20
node n21 s2 word attr=128 -> n31
node n22 s6 attr=128 -> n38
node n23 s5 word last attr=244
node n24 s5 word attr=244
node n25 s0 last attr=64 -> n26
node n26 s0 last attr=64 -> n27
node n27 s0 word last attr=64 -> n28
node n28 s2 word attr=128 -> n31
node n29 s1 attr=0 -> n24
node n30 s5 word last attr=244
node n31 s0 word attr=79 -> n31
node n32 s6 attr=128 -> n38
node n33 s5 word last attr=244
node n34 s0 word last attr=79 -> n31
node n35 s0 word attr=206 -> n37
node n36 s6 last attr=0 -> n35
node n37 s0 word last attr=64 -> n37
node n38 s5 word attr=244
node n39 s6 last attr=0 -> n38
