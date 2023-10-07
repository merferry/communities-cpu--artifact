set term pdf
set terminal pdf size 10in,4.8in font ",20"
set output 'hybrid-all.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set title noenhanced
set style fill solid border lt -1
set style textbox opaque noborder
set lmargin 4.5
set tmargin 1
unset xtics
set logscale x 10
set logscale y 10
set format x "10^{%L}"
set grid   y
set key off
set multiplot layout 2,4 margins 0.07,0.98,0.12,0.95 spacing 0.06,0.14
# set xlabel  'Batch fraction'
# set ylabel  'Runtime (s)'


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
set label "Runtime (s)" at screen 0.01,0.5 center rotate font ",20"
set label "Batch fraction" at screen 0.5,0.02 center font ",20"
files='it-2004 sk-2005 com-LiveJournal com-Orkut asia_osm europe_osm kmer_A2a kmer_V1r'
do for [i=1:words(files)] {
if (i>=1) { set xtics rotate by 45 right }
set title word(files, i) offset 0,-0.8
plot 'hybrid-all/'.word(files, i).'.csv' \
       using 4:($7 /1000) title 'Dynamic Frontier Louvain'     linestyle 2 with linespoints, \
    '' using 4:($8 /1000) title 'Dynamic Frontier RAK'         linestyle 3 with linespoints, \
    '' using 4:($9 /1000) title 'Dynamic Frontier Louvain-RAK' linestyle 4 with linespoints,
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
# 02. batch_deletions_fraction
# 03. batch_insertions_fraction
# 04. batch_fraction
# 05. lousta-t
# 06. raksta-t
# 07. loufro-t
# 08. rakfro-t
# 09. hybfro-t
# 10. lousta-m
# 11. raksta-m
# 12. loufro-m
# 13. rakfro-m
# 14. hybfro-m
