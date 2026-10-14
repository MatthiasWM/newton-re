# 4a2c55: a ROM lexicon (an Airus AL dictionary): a graph whose nodes each
# stand for a set of characters.  Built by tools/lexicons/newtonlex.py;
# the format is in that file and in tools/lexicons/README.md.
type 0x11

# the character sets, each with the tag the recogniser is told when a
# character of it matched
set s0 "0123456789" "#"
set s1 "," "comma"
set s2 "." "point"
set s3 "(" "openparen"
set s4 ")" "closeparen"
set s5 "-" "minus"
set s6 "$£" "currencyPre"
set s7 "#" "numberPre"
set s8 "%" "percentSuf"
set s9 " \x09" "blank"

# the nodes, in the order they lie (the first row is the root's): the
# set, 'word' if a word may end here, 'last' on the last of a row, the
# first child after '->'
node n0 s9 attr=0 -> n0
node n1 s0 word attr=78 -> n10
node n2 s2 attr=0 -> n39
node n3 s5 attr=80 -> n7
node n4 s3 attr=80 -> n42
node n5 s7 attr=115 -> n77
node n6 s6 last attr=115 -> n80
node n7 s0 word attr=206 -> n10
node n8 s2 attr=128 -> n39
node n9 s9 last attr=0 -> n7
node n10 s0 word attr=64 -> n15
node n11 s2 word attr=128 -> n36
node n12 s1 attr=0 -> n29
node n13 s8 word attr=244
node n14 s9 last attr=0 -> n40
node n15 s0 word attr=64 -> n20
node n16 s2 word attr=128 -> n36
node n17 s1 attr=0 -> n29
node n18 s8 word attr=244
node n19 s9 last attr=0 -> n40
node n20 s0 word attr=64 -> n25
node n21 s2 word attr=128 -> n36
node n22 s1 attr=0 -> n29
node n23 s8 word attr=244
node n24 s9 last attr=0 -> n40
node n25 s0 word attr=64 -> n25
node n26 s2 word attr=128 -> n36
node n27 s8 word attr=244
node n28 s9 last attr=0 -> n40
node n29 s0 last attr=64 -> n30
node n30 s0 last attr=64 -> n31
node n31 s0 word last attr=64 -> n32
node n32 s2 word attr=128 -> n36
node n33 s1 attr=0 -> n29
node n34 s8 word attr=244
node n35 s9 last attr=0 -> n40
node n36 s0 word attr=79 -> n36
node n37 s8 word attr=244
node n38 s9 last attr=0 -> n40
node n39 s0 word last attr=79 -> n36
node n40 s8 word attr=244
node n41 s9 last attr=0 -> n40
node n42 s0 attr=206 -> n45
node n43 s2 attr=128 -> n71
node n44 s9 last attr=0 -> n42
node n45 s4 word attr=128
node n46 s2 attr=128 -> n72
node n47 s1 attr=0 -> n64
node n48 s0 attr=64 -> n50
node n49 s9 last attr=0 -> n75
node n50 s4 word attr=128
node n51 s2 attr=128 -> n72
node n52 s1 attr=0 -> n64
node n53 s0 attr=64 -> n55
node n54 s9 last attr=0 -> n75
node n55 s4 word attr=128
node n56 s2 attr=128 -> n72
node n57 s1 attr=0 -> n64
node n58 s0 attr=64 -> n60
node n59 s9 last attr=0 -> n75
node n60 s4 word attr=128
node n61 s2 attr=128 -> n72
node n62 s0 attr=64 -> n60
node n63 s9 last attr=0 -> n75
node n64 s0 last attr=64 -> n65
node n65 s0 last attr=64 -> n66
node n66 s0 last attr=64 -> n67
node n67 s4 word attr=128
node n68 s2 attr=128 -> n72
node n69 s1 attr=0 -> n64
node n70 s9 last attr=0 -> n75
node n71 s0 last attr=79 -> n72
node n72 s4 word attr=128
node n73 s0 attr=79 -> n72
node n74 s9 last attr=0 -> n75
node n75 s4 word attr=128
node n76 s9 last attr=0 -> n75
node n77 s0 word attr=206 -> n79
node n78 s9 last attr=0 -> n77
node n79 s0 word last attr=64 -> n79
node n80 s0 word attr=206 -> n10
node n81 s5 attr=208 -> n7
node n82 s9 last attr=0 -> n80
