# 4a1d1d: a ROM lexicon (an Airus AL dictionary): a graph whose nodes each
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
set s23 "." "period"
set s24 "," "comma"
set s25 " \x09" "blank"
set s26 "/-" "shortDateSep"
set s27 "/" "slashSep"
set s28 "-" "dashSep"

# the nodes, in the order they lie (the first row is the root's): the
# set, 'word' if a word may end here, 'last' on the last of a row, the
# first child after '->'
node n0 s25 attr=0 -> n0
node n1 s0 attr=71 -> n12
node n2 s12 attr=0 -> n52
node n3 s18 attr=0 -> n64
node n4 s21 attr=107 -> n81
node n5 s6 attr=0 -> n113
node n6 s17 attr=0 -> n125
node n7 s10 attr=0 -> n164
node n8 s1 attr=0 -> n203
node n9 s14 attr=94 -> n253
node n10 s13 attr=95 -> n264
node n11 s4 last attr=96 -> n277
node n12 s0 word attr=64 -> n24
node n13 s25 attr=128 -> n156
node n14 s27 attr=128 -> n35
node n15 s28 attr=128 -> n36
node n16 s10 attr=128 -> n164
node n17 s6 attr=214 -> n176
node n18 s12 attr=128 -> n193
node n19 s1 attr=128 -> n203
node n20 s17 attr=221 -> n236
node n21 s14 attr=222 -> n253
node n22 s13 attr=223 -> n264
node n23 s4 last attr=224 -> n277
node n24 s25 attr=128 -> n156
node n25 s27 attr=128 -> n35
node n26 s28 attr=128 -> n36
node n27 s10 attr=128 -> n164
node n28 s6 attr=214 -> n176
node n29 s12 attr=128 -> n193
node n30 s1 attr=128 -> n203
node n31 s17 attr=221 -> n236
node n32 s14 attr=222 -> n253
node n33 s13 attr=223 -> n264
node n34 s4 last attr=224 -> n277
node n35 s0 word last attr=70 -> n45
node n36 s0 word attr=70 -> n45
node n37 s10 attr=0 -> n164
node n38 s6 attr=86 -> n176
node n39 s12 attr=0 -> n193
node n40 s1 attr=0 -> n203
node n41 s17 attr=93 -> n236
node n42 s14 attr=94 -> n253
node n43 s13 attr=95 -> n264
node n44 s4 last attr=96 -> n277
node n45 s0 word attr=64 -> n47
node n46 s26 last attr=128 -> n48
node n47 s26 last attr=128 -> n48
node n48 s0 last attr=69 -> n49
node n49 s0 word last attr=64 -> n50
node n50 s0 last attr=64 -> n51
node n51 s0 word last attr=64
node n52 s14 word attr=105 -> n54
node n53 s1 last attr=0 -> n194
node n54 s13 word attr=0 -> n58
node n55 s23 word attr=128 -> n150
node n56 s24 attr=28 -> n153
node n57 s25 last attr=128 -> n155
node n58 s4 attr=0 -> n62
node n59 s23 word attr=128 -> n150
node n60 s24 attr=128 -> n153
node n61 s25 last attr=128 -> n155
node n62 s1 last attr=0 -> n63
node n63 s22 word last attr=128 -> n150
node n64 s19 word attr=106 -> n67
node n65 s8 word attr=108 -> n95
node n66 s14 last attr=0 -> n298
node n67 s5 word attr=0 -> n71
node n68 s23 word attr=128 -> n150
node n69 s24 attr=128 -> n153
node n70 s25 last attr=128 -> n155
node n71 s17 word attr=0 -> n75
node n72 s23 word attr=128 -> n150
node n73 s24 attr=128 -> n153
node n74 s25 last attr=128 -> n155
node n75 s4 attr=0 -> n79
node n76 s23 word attr=128 -> n150
node n77 s24 attr=128 -> n153
node n78 s25 last attr=128 -> n155
node n79 s1 last attr=0 -> n80
node n80 s22 word last attr=128 -> n150
node n81 s5 word last attr=0 -> n82
node n82 s4 word attr=0 -> n86
node n83 s23 word attr=128 -> n150
node n84 s24 attr=128 -> n153
node n85 s25 last attr=128 -> n155
node n86 s13 attr=0 -> n90
node n87 s23 word attr=128 -> n150
node n88 s24 attr=128 -> n153
node n89 s25 last attr=128 -> n155
node n90 s5 last attr=0 -> n91
node n91 s17 last attr=0 -> n92
node n92 s4 last attr=0 -> n93
node n93 s1 last attr=0 -> n94
node n94 s22 word last attr=128 -> n150
node n95 s19 word attr=0 -> n99
node n96 s23 word attr=128 -> n150
node n97 s24 attr=128 -> n153
node n98 s25 last attr=128 -> n155
node n99 s16 word attr=0 -> n103
node n100 s23 word attr=128 -> n150
node n101 s24 attr=128 -> n153
node n102 s25 last attr=128 -> n155
node n103 s17 word attr=0 -> n107
node n104 s23 word attr=128 -> n150
node n105 s24 attr=128 -> n153
node n106 s25 last attr=128 -> n155
node n107 s4 attr=0 -> n111
node n108 s23 word attr=128 -> n150
node n109 s24 attr=128 -> n153
node n110 s25 last attr=128 -> n155
node n111 s1 last attr=0 -> n112
node n112 s22 word last attr=128 -> n150
node n113 s16 word attr=109 -> n115
node n114 s5 last attr=86 -> n177
node n115 s9 word attr=0 -> n119
node n116 s23 word attr=128 -> n150
node n117 s24 attr=128 -> n153
node n118 s25 last attr=128 -> n155
node n119 s4 attr=0 -> n123
node n120 s23 word attr=128 -> n150
node n121 s24 attr=128 -> n153
node n122 s25 last attr=128 -> n155
node n123 s1 last attr=0 -> n124
node n124 s22 word last attr=128 -> n150
node n125 s1 word attr=110 -> n128
node n126 s19 word attr=104 -> n140
node n127 s5 last attr=93 -> n237
node n128 s18 word attr=0 -> n132
node n129 s23 word attr=128 -> n150
node n130 s24 attr=128 -> n153
node n131 s25 last attr=128 -> n155
node n132 s19 attr=0 -> n136
node n133 s23 word attr=128 -> n150
node n134 s24 attr=128 -> n153
node n135 s25 last attr=128 -> n155
node n136 s16 last attr=0 -> n137
node n137 s4 last attr=0 -> n138
node n138 s1 last attr=0 -> n139
node n139 s22 word last attr=128 -> n150
node n140 s13 word attr=0 -> n144
node n141 s23 word attr=128 -> n150
node n142 s24 attr=128 -> n153
node n143 s25 last attr=128 -> n155
node n144 s4 attr=0 -> n148
node n145 s23 word attr=128 -> n150
node n146 s24 attr=128 -> n153
node n147 s25 last attr=128 -> n155
node n148 s1 last attr=0 -> n149
node n149 s22 word last attr=128 -> n150
node n150 s0 word attr=71 -> n12
node n151 s24 attr=0 -> n153
node n152 s25 last attr=0 -> n155
node n153 s0 word attr=71 -> n12
node n154 s25 last attr=0 -> n155
node n155 s0 word last attr=71 -> n12
node n156 s10 attr=0 -> n164
node n157 s6 attr=86 -> n176
node n158 s12 attr=0 -> n193
node n159 s1 attr=0 -> n203
node n160 s17 attr=93 -> n236
node n161 s14 attr=94 -> n253
node n162 s13 attr=95 -> n264
node n163 s4 last attr=96 -> n277
node n164 s1 attr=85 -> n166
node n165 s19 last attr=0 -> n213
node n166 s13 word last attr=0 -> n167
node n167 s19 attr=0 -> n173
node n168 s23 word attr=128 -> n290
node n169 s24 attr=128 -> n294
node n170 s25 attr=128 -> n296
node n171 s28 attr=128 -> n296
node n172 s0 last attr=197 -> n49
node n173 s1 last attr=0 -> n174
node n174 s16 last attr=0 -> n175
node n175 s22 word last attr=128 -> n290
node n176 s5 last attr=0 -> n177
node n177 s2 word last attr=0 -> n178
node n178 s16 word attr=0 -> n184
node n179 s23 word attr=128 -> n290
node n180 s24 attr=128 -> n294
node n181 s25 attr=128 -> n296
node n182 s28 attr=128 -> n296
node n183 s0 last attr=197 -> n49
node n184 s19 attr=0 -> n190
node n185 s23 word attr=128 -> n290
node n186 s24 attr=128 -> n294
node n187 s25 attr=128 -> n296
node n188 s28 attr=128 -> n296
node n189 s0 last attr=197 -> n49
node n190 s1 last attr=0 -> n191
node n191 s16 last attr=0 -> n192
node n192 s22 word last attr=128 -> n290
node n193 s1 last attr=0 -> n194
node n194 s16 word attr=87 -> n196
node n195 s22 word last attr=153 -> n290
node n196 s3 attr=0 -> n202
node n197 s23 word attr=128 -> n290
node n198 s24 attr=128 -> n294
node n199 s25 attr=128 -> n296
node n200 s28 attr=128 -> n296
node n201 s0 last attr=197 -> n49
node n202 s8 word last attr=128 -> n290
node n203 s15 attr=88 -> n205
node n204 s19 last attr=92 -> n227
node n205 s16 word last attr=0 -> n206
node n206 s9 attr=0 -> n212
node n207 s23 word attr=128 -> n290
node n208 s24 attr=128 -> n294
node n209 s25 attr=128 -> n296
node n210 s28 attr=128 -> n296
node n211 s0 last attr=197 -> n49
node n212 s11 word last attr=128 -> n290
node n213 s13 word attr=90 -> n215
node n214 s11 word last attr=91 -> n221
node n215 s5 word attr=128 -> n290
node n216 s23 word attr=128 -> n290
node n217 s24 attr=128 -> n294
node n218 s25 attr=128 -> n296
node n219 s28 attr=128 -> n296
node n220 s0 last attr=197 -> n49
node n221 s22 word attr=128 -> n290
node n222 s23 word attr=128 -> n290
node n223 s24 attr=128 -> n294
node n224 s25 attr=128 -> n296
node n225 s28 attr=128 -> n296
node n226 s0 last attr=197 -> n49
node n227 s7 word last attr=0 -> n228
node n228 s19 attr=0 -> n234
node n229 s23 word attr=128 -> n290
node n230 s24 attr=128 -> n294
node n231 s25 attr=128 -> n296
node n232 s28 attr=128 -> n296
node n233 s0 last attr=197 -> n49
node n234 s17 last attr=0 -> n235
node n235 s18 word last attr=128 -> n290
node n236 s5 last attr=0 -> n237
node n237 s15 word last attr=0 -> n238
node n238 s18 word attr=0 -> n244
node n239 s23 word attr=128 -> n290
node n240 s24 attr=128 -> n294
node n241 s25 attr=128 -> n296
node n242 s28 attr=128 -> n296
node n243 s0 last attr=197 -> n49
node n244 s5 attr=0 -> n249
node n245 s23 word attr=128 -> n290
node n246 s24 attr=128 -> n294
node n247 s25 attr=128 -> n296
node n248 s0 last attr=197 -> n49
node n249 s12 last attr=0 -> n250
node n250 s2 last attr=0 -> n251
node n251 s5 last attr=0 -> n252
node n252 s16 word last attr=128 -> n290
node n253 s3 last attr=0 -> n254
node n254 s18 word last attr=0 -> n255
node n255 s14 attr=0 -> n261
node n256 s23 word attr=128 -> n290
node n257 s24 attr=128 -> n294
node n258 s25 attr=128 -> n296
node n259 s28 attr=128 -> n296
node n260 s0 last attr=197 -> n49
node n261 s2 last attr=0 -> n262
node n262 s5 last attr=0 -> n263
node n263 s16 word last attr=128 -> n290
node n264 s14 last attr=0 -> n265
node n265 s20 word last attr=0 -> n266
node n266 s5 attr=0 -> n272
node n267 s23 word attr=128 -> n290
node n268 s24 attr=128 -> n294
node n269 s25 attr=128 -> n296
node n270 s28 attr=128 -> n296
node n271 s0 last attr=197 -> n49
node n272 s12 word last attr=0 -> n273
node n273 s2 attr=0 -> n275
node n274 s0 last attr=197 -> n49
node n275 s5 last attr=0 -> n276
node n276 s16 word last attr=128 -> n290
node n277 s5 last attr=0 -> n278
node n278 s3 word last attr=0 -> n279
node n279 s5 attr=0 -> n285
node n280 s23 word attr=128 -> n290
node n281 s24 attr=128 -> n294
node n282 s25 attr=128 -> n296
node n283 s28 attr=128 -> n296
node n284 s0 last attr=197 -> n49
node n285 s12 word last attr=0 -> n286
node n286 s2 attr=0 -> n288
node n287 s0 last attr=197 -> n49
node n288 s5 last attr=0 -> n289
node n289 s16 word last attr=128 -> n290
node n290 s24 attr=0 -> n294
node n291 s25 attr=0 -> n296
node n292 s28 attr=0 -> n296
node n293 s0 last attr=69 -> n49
node n294 s25 attr=0 -> n296
node n295 s0 last attr=69 -> n49
node n296 s0 last attr=69 -> n49
node n297 s14 last attr=0 -> n298
node n298 s12 last attr=0 -> n299
node n299 s14 last attr=0 -> n300
node n300 s16 last attr=0 -> n301
node n301 s16 last attr=0 -> n302
node n302 s14 last attr=0 -> n303
node n303 s21 word last attr=167
