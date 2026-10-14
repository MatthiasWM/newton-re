# 4a2b41: a ROM lexicon (an Airus AL dictionary): a graph whose nodes each
# stand for a set of characters.  Built by tools/lexicons/newtonlex.py;
# the format is in that file and in tools/lexicons/README.md.
type 0x19

# the character sets, each with the tag the recogniser is told when a
# character of it matched
set s0 "0123456789" "n"
set s1 "xX" "ex"
set s2 "-" "dash"
set s3 " " "blank"
set s4 "()" "paren"

# the nodes, in the order they lie (the first row is the root's): the
# set, 'word' if a word may end here, 'last' on the last of a row, the
# first child after '->'
node n0 s0 word attr=81 -> n4
node n1 s1 attr=81 -> n3
node n2 s4 last attr=81 -> n29
node n3 s0 last attr=2 -> n4
node n4 s0 word attr=3 -> n8
node n5 s2 attr=3 -> n16
node n6 s3 attr=3 -> n16
node n7 s4 last attr=3 -> n29
node n8 s0 word attr=4 -> n11
node n9 s2 attr=4 -> n16
node n10 s3 last attr=4 -> n16
node n11 s0 word attr=5 -> n14
node n12 s2 attr=5 -> n16
node n13 s3 last attr=5 -> n16
node n14 s0 word last attr=6 -> n15
node n15 s0 word last attr=7 -> n20
node n16 s0 attr=8 -> n18
node n17 s4 last attr=8 -> n29
node n18 s0 last attr=9 -> n19
node n19 s0 last attr=10 -> n20
node n20 s0 word attr=11 -> n24
node n21 s3 attr=11 -> n23
node n22 s2 last attr=11 -> n23
node n23 s0 word last attr=12 -> n24
node n24 s0 last attr=13 -> n25
node n25 s0 last attr=14 -> n26
node n26 s0 word attr=15 -> n24
node n27 s2 attr=15 -> n20
node n28 s3 last attr=15 -> n20
node n29 s0 last attr=16 -> n30
node n30 s0 last attr=17 -> n31
node n31 s0 last attr=18 -> n32
node n32 s4 last attr=19 -> n33
node n33 s0 attr=20 -> n4
node n34 s3 last attr=20 -> n35
node n35 s0 last attr=21 -> n4
