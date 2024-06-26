set term pdf
set terminal pdf size 10in,4.8in font ",20"
set output 'hybrid-allss.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set title noenhanced
set style fill solid border lt -1
set style textbox opaque noborder
set lmargin 4.5
set tmargin 1
set xrange [1:64]
set xtics 2
unset xtics
set logscale x 10
set format x "%g"
set grid   y
set key off
set multiplot layout 2,4 margins 0.07,0.98,0.12,0.95 spacing 0.06,0.14
# set xlabel  'Threads'
# set ylabel  'Speedup'


## Set line styles
set style line  1 linewidth 2 linetype 8 pointtype 5
set style line  2 linewidth 2 linetype 7 pointtype 7
set style line  3 linewidth 2 linetype 6 pointtype 9
set style line  4 linewidth 2 linetype 1 pointtype 2
set style line 11 linewidth 2 linetype 8 pointtype 5 dashtype 2
set style line 12 linewidth 2 linetype 7 pointtype 7 dashtype 2
set style line 13 linewidth 2 linetype 6 pointtype 9 dashtype 2
set style line 14 linewidth 2 linetype 1 pointtype 2 dashtype 2


## Draw plot
set label "Speedup (wrt 1 thread)" at screen 0.01,0.5 center rotate font "Tahoma,18"
set label "Threads" at screen 0.5,0.02 center font "Tahoma,18"
files='it-2004 sk-2005 com-LiveJournal com-Orkut asia_osm europe_osm kmer_A2a kmer_V1r'
do for [i=1:words(files)] {
set ytics auto
if (i==4) { set ytics 2 }
if (i==5) { set ytics 2 }
if (i==8) { set ytics 1 }
if (i>=9) { set ytics 1 }
if (i>=1) { set xtics 2 rotate by 45 right }
set title word(files, i) offset 0,-0.8
plot 'hybrid-allss/'.word(files, i).'.csv' \
       using 2:($10/$5 ) title 'Dynamic Frontier Louvain'     linestyle 2 with linespoints, \
    '' using 2:($11/$6 ) title 'Dynamic Frontier RAK'         linestyle 3 with linespoints, \
    '' using 2:($12/$7 ) title 'Dynamic Frontier Louvain-RAK' linestyle 4 with linespoints,
}
unset multiplot




## Names of CSV files.
# 01. indochina-2004
# 02. uk-2002
# 03. arabic-2005
# 04. uk-2005
# 05. webbase-2001
# 06. it-2004
# 07. sk-2005
# 08. com-LiveJournal
# 09. com-Orkut
# 10. asia_osm
# 11. europe_osm
# 12. kmer_A2a
# 13. kmer_V1r


## Columns in CSV file.
# 01. graph
# 02. num_threads
# 03. lousta-t
# 04. raksta-t
# 05. loufro-t
# 06. rakfro-t
# 07. hybfro-t
# 08. lousta-t1
# 09. raksta-t1
# 10. loufro-t1
# 11. rakfro-t1
# 12. hybfro-t1
# 13. lousta-m
# 14. raksta-m
# 15. loufro-m
# 16. rakfro-m
# 17. hybfro-m
