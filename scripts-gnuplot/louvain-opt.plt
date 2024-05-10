set term pdf
set terminal pdf size 10in,2.0in
set output 'louvain-opt.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set style fill solid border lt -1
set style textbox opaque noborder
set xtics rotate by 45 right
set grid   y
set key above font ",12"
set yrange  [0.0:1]
set y2range [0.9:1]
set ylabel  '{/:Bold Relative runtime}'
set y2label '{/:Bold Realtive modularity}'
set y2tics  0.02
set xtics rotate by 45 right
set tmargin 2
set bmargin 3.5
set boxwidth 5 relative


## Define colors
array T[9] = [ \
  0x6000A0, \
  0x006030, \
  0x2080C0, \
  0xB07000, \
  0xA09010, \
  0x004080, \
  0xB00000, \
  0x1090A0, \
  0x304060 \
]
array B[9] = [ \
  0x9100D0, \
  0x009E73, \
  0x56B4E9, \
  0xE69F00, \
  0xF0E442, \
  0x0072B2, \
  0xE51E10, \
  0x42E4F0, \
  0x73839E, \
]


## Draw labels
set label "{/:Bold OpenMP}\n{/:Bold schedule}"       at screen 0.10,0.97 center font "Tahoma,11" textcolor rgb T[1]
set label "{/:Bold Max.}\n{/:Bold iterations}"       at screen 0.22,0.97 center font "Tahoma,11" textcolor rgb T[2]
set label "{/:Bold Tolerance}\n{/:Bold drop}"        at screen 0.34,0.97 center font "Tahoma,11" textcolor rgb T[3]
set label "{/:Bold Tolerance}\n{/:Bold (initial)}"   at screen 0.44,0.97 center font "Tahoma,11" textcolor rgb T[4]
set label "{/:Bold Aggregation}\n{/:Bold tolerance}" at screen 0.56,0.97 center font "Tahoma,11" textcolor rgb T[5]
set label "{/:Bold Pruning}"                         at screen 0.66,0.97 center font "Tahoma,11" textcolor rgb T[6]
set label "{/:Bold Community}\n{/:Bold vertices}"    at screen 0.73,0.97 center font "Tahoma,11" textcolor rgb T[7]
set label "{/:Bold Aggregate}"                       at screen 0.80,0.97 center font "Tahoma,11" textcolor rgb T[8]
set label "{/:Bold Hashtable}"                       at screen 0.88,0.97 center font "Tahoma,11" textcolor rgb T[9]


## Draw plot
plot "louvain-opt.csv" \
     using 0:6:(1):(B[$1]):xtic(3) title '' with boxes lc rgb var, \
  '' using 0:7 title '' with lines linestyle 5 lw 3 lc rgb "#0000FF" axes x1y2




## Columns in CSV file.
# 01. technique
# 02. time
# 03. modularity
