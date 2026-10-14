# 4a2501: a ROM lexicon (an Airus AL dictionary): a graph whose nodes each
# stand for a set of characters.  Built by tools/lexicons/newtonlex.py;
# the format is in that file and in tools/lexicons/README.md.
type 0x11

# the character sets, each with the tag the recogniser is told when a
# character of it matched
set s0 "0123456789" "#"
set s1 "Aa" "A"
set s2 "Bb" "B"
set s3 "Cc" "C"
set s4 "Dd" "D"
set s5 "Ee" "E"
set s6 "Ff" "F"
set s7 "Gg" "G"
set s8 "Hh" "H"
set s9 "Ii" "I"
set s10 "Jj" "J"
set s11 "Ll" "L"
set s12 "Mm" "M"
set s13 "Nn" "N"
set s14 "Oo" "O"
set s15 "Pp" "P"
set s16 "Rr" "R"
set s17 "Ss" "S"
set s18 "Tt" "T"
set s19 "Uu" "U"
set s20 "Vv" "V"
set s21 "Ww" "W"
set s22 "Yy" "Y"
set s23 "/-" "dateSep"
set s24 "." "period"
set s25 "," "comma"
set s26 " \x09" "blank"

# the nodes, in the order they lie (the first row is the root's): the
# set, 'word' if a word may end here, 'last' on the last of a row, the
# first child after '->'
node n0 s26 attr=0 -> n0
node n1 s0 attr=71 -> n16
node n2 s12 attr=0 -> n23
node n3 s18 attr=0 -> n35
node n4 s21 attr=107 -> n52
node n5 s6 attr=0 -> n84
node n6 s17 attr=0 -> n96
node n7 s10 attr=0 -> n135
node n8 s1 attr=0 -> n162
node n9 s14 attr=94 -> n195
node n10 s13 attr=95 -> n203
node n11 s4 last attr=96 -> n212
node n12 s0 word attr=64 -> n14
node n13 s23 last attr=128 -> n19
node n14 s23 last attr=128 -> n19
node n15 s0 word last attr=70 -> n12
node n16 s0 word attr=64 -> n18
node n17 s23 last attr=128 -> n15
node n18 s23 last attr=128 -> n15
node n19 s0 last attr=69 -> n20
node n20 s0 word last attr=64 -> n21
node n21 s0 last attr=64 -> n22
node n22 s0 word last attr=64
node n23 s14 word attr=105 -> n25
node n24 s1 last attr=0 -> n156
node n25 s13 word attr=0 -> n29
node n26 s24 word attr=128 -> n121
node n27 s25 attr=128 -> n124
node n28 s26 last attr=128 -> n126
node n29 s4 attr=0 -> n33
node n30 s24 word attr=128 -> n121
node n31 s25 attr=128 -> n124
node n32 s26 last attr=128 -> n126
node n33 s1 last attr=0 -> n34
node n34 s22 word last attr=128 -> n121
node n35 s19 word attr=106 -> n38
node n36 s8 word attr=108 -> n66
node n37 s14 last attr=0 -> n232
node n38 s5 word attr=0 -> n42
node n39 s24 word attr=128 -> n121
node n40 s25 attr=128 -> n124
node n41 s26 last attr=128 -> n126
node n42 s17 word attr=0 -> n46
node n43 s24 word attr=128 -> n121
node n44 s25 attr=128 -> n124
node n45 s26 last attr=128 -> n126
node n46 s4 attr=0 -> n50
node n47 s24 word attr=128 -> n121
node n48 s25 attr=128 -> n124
node n49 s26 last attr=128 -> n126
node n50 s1 last attr=0 -> n51
node n51 s22 word last attr=128 -> n121
node n52 s5 word last attr=0 -> n53
node n53 s4 word attr=0 -> n57
node n54 s24 word attr=128 -> n121
node n55 s25 attr=128 -> n124
node n56 s26 last attr=128 -> n126
node n57 s13 attr=0 -> n61
node n58 s24 word attr=128 -> n121
node n59 s25 attr=128 -> n124
node n60 s26 last attr=128 -> n126
node n61 s5 last attr=0 -> n62
node n62 s17 last attr=0 -> n63
node n63 s4 last attr=0 -> n64
node n64 s1 last attr=0 -> n65
node n65 s22 word last attr=128 -> n121
node n66 s19 word attr=0 -> n70
node n67 s24 word attr=128 -> n121
node n68 s25 attr=128 -> n124
node n69 s26 last attr=128 -> n126
node n70 s16 word attr=0 -> n74
node n71 s24 word attr=128 -> n121
node n72 s25 attr=128 -> n124
node n73 s26 last attr=128 -> n126
node n74 s17 word attr=0 -> n78
node n75 s24 word attr=128 -> n121
node n76 s25 attr=128 -> n124
node n77 s26 last attr=128 -> n126
node n78 s4 attr=0 -> n82
node n79 s24 word attr=128 -> n121
node n80 s25 attr=128 -> n124
node n81 s26 last attr=128 -> n126
node n82 s1 last attr=0 -> n83
node n83 s22 word last attr=128 -> n121
node n84 s16 word attr=109 -> n86
node n85 s5 last attr=86 -> n145
node n86 s9 word attr=0 -> n90
node n87 s24 word attr=128 -> n121
node n88 s25 attr=128 -> n124
node n89 s26 last attr=128 -> n126
node n90 s4 attr=0 -> n94
node n91 s24 word attr=128 -> n121
node n92 s25 attr=128 -> n124
node n93 s26 last attr=128 -> n126
node n94 s1 last attr=0 -> n95
node n95 s22 word last attr=128 -> n121
node n96 s1 word attr=110 -> n99
node n97 s19 word attr=104 -> n111
node n98 s5 last attr=93 -> n184
node n99 s18 word attr=0 -> n103
node n100 s24 word attr=128 -> n121
node n101 s25 attr=128 -> n124
node n102 s26 last attr=128 -> n126
node n103 s19 attr=0 -> n107
node n104 s24 word attr=128 -> n121
node n105 s25 attr=128 -> n124
node n106 s26 last attr=128 -> n126
node n107 s16 last attr=0 -> n108
node n108 s4 last attr=0 -> n109
node n109 s1 last attr=0 -> n110
node n110 s22 word last attr=128 -> n121
node n111 s13 word attr=0 -> n115
node n112 s24 word attr=128 -> n121
node n113 s25 attr=128 -> n124
node n114 s26 last attr=128 -> n126
node n115 s4 attr=0 -> n119
node n116 s24 word attr=128 -> n121
node n117 s25 attr=128 -> n124
node n118 s26 last attr=128 -> n126
node n119 s1 last attr=0 -> n120
node n120 s22 word last attr=128 -> n121
node n121 s0 attr=71 -> n16
node n122 s25 attr=0 -> n124
node n123 s26 last attr=0 -> n126
node n124 s0 attr=71 -> n16
node n125 s26 last attr=0 -> n126
node n126 s10 attr=0 -> n135
node n127 s6 attr=86 -> n144
node n128 s12 attr=0 -> n155
node n129 s1 attr=0 -> n162
node n130 s17 attr=93 -> n183
node n131 s14 attr=94 -> n195
node n132 s13 attr=95 -> n203
node n133 s4 attr=96 -> n212
node n134 s0 last attr=71 -> n16
node n135 s1 attr=85 -> n137
node n136 s19 last attr=0 -> n169
node n137 s13 word last attr=0 -> n138
node n138 s19 attr=0 -> n141
node n139 s26 attr=128 -> n222
node n140 s24 word last attr=128 -> n221
node n141 s1 last attr=0 -> n142
node n142 s16 last attr=0 -> n143
node n143 s22 word last attr=128 -> n221
node n144 s5 last attr=0 -> n145
node n145 s2 word last attr=0 -> n146
node n146 s16 word attr=0 -> n149
node n147 s26 attr=128 -> n222
node n148 s24 word last attr=128 -> n221
node n149 s19 attr=0 -> n152
node n150 s26 attr=128 -> n222
node n151 s24 word last attr=128 -> n221
node n152 s1 last attr=0 -> n153
node n153 s16 last attr=0 -> n154
node n154 s22 word last attr=128 -> n221
node n155 s1 last attr=0 -> n156
node n156 s16 word attr=87 -> n158
node n157 s22 word last attr=153 -> n221
node n158 s3 attr=0 -> n161
node n159 s26 attr=128 -> n222
node n160 s24 word last attr=128 -> n221
node n161 s8 word last attr=128 -> n221
node n162 s15 attr=88 -> n164
node n163 s19 last attr=92 -> n177
node n164 s16 word last attr=0 -> n165
node n165 s9 attr=0 -> n168
node n166 s26 attr=128 -> n222
node n167 s24 word last attr=128 -> n221
node n168 s11 word last attr=128 -> n221
node n169 s13 word attr=90 -> n171
node n170 s11 word last attr=91 -> n174
node n171 s5 word attr=128 -> n221
node n172 s26 attr=128 -> n222
node n173 s24 word last attr=128 -> n221
node n174 s22 word attr=128 -> n221
node n175 s26 attr=128 -> n222
node n176 s24 word last attr=128 -> n221
node n177 s7 word last attr=0 -> n178
node n178 s19 attr=0 -> n181
node n179 s26 attr=128 -> n222
node n180 s24 word last attr=128 -> n221
node n181 s17 last attr=0 -> n182
node n182 s18 word last attr=128 -> n221
node n183 s5 last attr=0 -> n184
node n184 s15 word last attr=0 -> n185
node n185 s18 word attr=0 -> n188
node n186 s26 attr=128 -> n222
node n187 s24 word last attr=128 -> n221
node n188 s5 attr=0 -> n191
node n189 s26 attr=128 -> n222
node n190 s24 word last attr=128 -> n221
node n191 s12 last attr=0 -> n192
node n192 s2 last attr=0 -> n193
node n193 s5 last attr=0 -> n194
node n194 s16 word last attr=128 -> n221
node n195 s3 last attr=0 -> n196
node n196 s18 word last attr=0 -> n197
node n197 s14 attr=0 -> n200
node n198 s26 attr=128 -> n222
node n199 s24 word last attr=128 -> n221
node n200 s2 last attr=0 -> n201
node n201 s5 last attr=0 -> n202
node n202 s16 word last attr=128 -> n221
node n203 s14 last attr=0 -> n204
node n204 s20 word last attr=0 -> n205
node n205 s5 attr=0 -> n208
node n206 s26 attr=128 -> n222
node n207 s24 word last attr=128 -> n221
node n208 s12 word last attr=0 -> n209
node n209 s2 last attr=0 -> n210
node n210 s5 last attr=0 -> n211
node n211 s16 word last attr=128 -> n221
node n212 s5 last attr=0 -> n213
node n213 s3 word last attr=0 -> n214
node n214 s5 attr=0 -> n217
node n215 s26 attr=128 -> n222
node n216 s24 word last attr=128 -> n221
node n217 s12 word last attr=0 -> n218
node n218 s2 last attr=0 -> n219
node n219 s5 last attr=0 -> n220
node n220 s16 word last attr=128 -> n221
node n221 s26 last attr=0 -> n222
node n222 s0 word last attr=71 -> n223
node n223 s0 word attr=64 -> n226
node n224 s26 attr=128 -> n230
node n225 s25 last attr=128 -> n229
node n226 s26 attr=128 -> n230
node n227 s25 attr=128 -> n229
node n228 s0 last attr=69 -> n22
node n229 s26 last attr=0 -> n230
node n230 s0 last attr=69 -> n20
node n231 s14 last attr=0 -> n232
node n232 s12 last attr=0 -> n233
node n233 s14 last attr=0 -> n234
node n234 s16 last attr=0 -> n235
node n235 s16 last attr=0 -> n236
node n236 s14 last attr=0 -> n237
node n237 s21 word last attr=167
