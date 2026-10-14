# 4a0a81: a ROM lexicon (an Airus AL dictionary): a graph whose nodes each
# stand for a set of characters.  Built by tools/lexicons/newtonlex.py;
# the format is in that file and in tools/lexicons/README.md.
type 0x11

# the character sets, each with the tag the recogniser is told when a
# character of it matched
set s0 "0" "zero"
set s1 "1" "one"
set s2 "2" "two"
set s3 "3" "three"
set s4 "4" "four"
set s5 "5" "five"
set s6 "6" "six"
set s7 "7" "seven"
set s8 "8" "eight"
set s9 "9" "nine"
set s10 ":" ":"
set s11 "." "point"
set s12 "aA" "meridianA"
set s13 "pP" "meridianP"
set s14 "mM" "meridianM"
set s15 " \x09" "blank"

# the nodes, in the order they lie (the first row is the root's): the
# set, 'word' if a word may end here, 'last' on the last of a row, the
# first child after '->'
node n0 s15 attr=0 -> n0
node n1 s0 word attr=73 -> n21
node n2 s1 word attr=73 -> n32
node n3 s2 word attr=73 -> n13
node n4 s3 word attr=73 -> n51
node n5 s4 word attr=73 -> n51
node n6 s5 word attr=73 -> n51
node n7 s6 word attr=73 -> n51
node n8 s7 word attr=73 -> n51
node n9 s8 word attr=73 -> n51
node n10 s9 word attr=73 -> n51
node n11 s12 attr=76 -> n103
node n12 s13 last attr=77 -> n105
node n13 s0 word attr=64 -> n46
node n14 s1 word attr=64 -> n46
node n15 s2 word attr=64 -> n46
node n16 s3 word attr=64 -> n46
node n17 s10 attr=128 -> n75
node n18 s12 attr=204 -> n103
node n19 s13 attr=205 -> n105
node n20 s15 last attr=128 -> n101
node n21 s0 word attr=64 -> n46
node n22 s1 word attr=64 -> n47
node n23 s2 word attr=64 -> n47
node n24 s3 word attr=64 -> n47
node n25 s4 word attr=64 -> n47
node n26 s5 word attr=64 -> n47
node n27 s6 word attr=64 -> n47
node n28 s7 word attr=64 -> n47
node n29 s8 word attr=64 -> n47
node n30 s9 word attr=64 -> n47
node n31 s10 last attr=128 -> n55
node n32 s0 word attr=64 -> n51
node n33 s1 word attr=64 -> n51
node n34 s2 word attr=64 -> n51
node n35 s3 word attr=64 -> n46
node n36 s4 word attr=64 -> n46
node n37 s5 word attr=64 -> n46
node n38 s6 word attr=64 -> n46
node n39 s7 word attr=64 -> n46
node n40 s8 word attr=64 -> n46
node n41 s9 word attr=64 -> n46
node n42 s12 attr=204 -> n103
node n43 s13 attr=205 -> n105
node n44 s15 attr=128 -> n101
node n45 s10 last attr=128 -> n75
node n46 s10 last attr=128 -> n55
node n47 s10 attr=128 -> n75
node n48 s12 attr=204 -> n103
node n49 s13 attr=205 -> n105
node n50 s15 last attr=128 -> n101
node n51 s10 attr=128 -> n75
node n52 s12 attr=204 -> n103
node n53 s13 attr=205 -> n105
node n54 s15 last attr=128 -> n101
node n55 s0 word attr=74 -> n65
node n56 s1 word attr=74 -> n65
node n57 s2 word attr=74 -> n65
node n58 s3 word attr=74 -> n65
node n59 s4 word attr=74 -> n65
node n60 s5 word attr=74 -> n65
node n61 s6 word attr=74
node n62 s7 word attr=74
node n63 s8 word attr=74
node n64 s9 word last attr=74
node n65 s0 word attr=64
node n66 s1 word attr=64
node n67 s2 word attr=64
node n68 s3 word attr=64
node n69 s4 word attr=64
node n70 s5 word attr=64
node n71 s6 word attr=64
node n72 s7 word attr=64
node n73 s8 word attr=64
node n74 s9 word last attr=64
node n75 s0 word attr=74 -> n85
node n76 s1 word attr=74 -> n85
node n77 s2 word attr=74 -> n85
node n78 s3 word attr=74 -> n85
node n79 s4 word attr=74 -> n85
node n80 s5 word attr=74 -> n85
node n81 s6 word attr=74 -> n98
node n82 s7 word attr=74 -> n98
node n83 s8 word attr=74 -> n98
node n84 s9 word last attr=74 -> n98
node n85 s0 word attr=64 -> n98
node n86 s1 word attr=64 -> n98
node n87 s2 word attr=64 -> n98
node n88 s3 word attr=64 -> n98
node n89 s4 word attr=64 -> n98
node n90 s5 word attr=64 -> n98
node n91 s6 word attr=64 -> n98
node n92 s7 word attr=64 -> n98
node n93 s8 word attr=64 -> n98
node n94 s9 word attr=64 -> n98
node n95 s12 attr=204 -> n103
node n96 s13 attr=205 -> n105
node n97 s15 last attr=128 -> n101
node n98 s12 attr=204 -> n103
node n99 s13 attr=205 -> n105
node n100 s15 last attr=128 -> n101
node n101 s12 attr=76 -> n103
node n102 s13 last attr=77 -> n105
node n103 s11 attr=0 -> n107
node n104 s14 word last attr=128 -> n108
node n105 s11 attr=0 -> n107
node n106 s14 word last attr=128 -> n108
node n107 s14 word last attr=128 -> n108
node n108 s11 word last attr=0
