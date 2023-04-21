set term pdf
set terminal pdf size 10in,6in font ",20"
set output 'louvain-all.pdf'


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
set format x "%g"
set grid   y
set key off
set multiplot layout 3,4 margins 0.06,0.98,0.05,0.95 spacing 0.06,0.07
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
set label "Runtime (s)" at screen 0.01,0.5 center rotate font "Tahoma,18"
set label "Batch fraction" at screen 0.5,0.02 center font "Tahoma,18"
files='indochina-2004 arabic-2005 uk-2005 webbase-2001 it-2004 sk-2005 com-LiveJournal com-Orkut asia_osm europe_osm kmer_A2a kmer_V1r'
do for [i=1:words(files)] {
set title word(files, i) offset 0,-0.8
plot 'louvain-all/'.word(files, i).'.csv' \
       using 7:($8 /1000)                    title 'Static'           linestyle 1 with linespoints, \
    '' using 7:($9 /1000)                    title 'Naive-dyn.'       linestyle 2 with linespoints, \
    '' using 7:((0.001*$8 + 0.999*$10)/1000) title 'Dyn. Δ-screening' linestyle 3 with linespoints, \
    '' using 7:((0.001*$8 + 0.999*$11)/1000) title 'Dyn. Frontier'    linestyle 4 with linespoints,
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
# 02. order
# 03. size
# 04. batch_deletions_size
# 05. batch_insertions_size
# 06. batch_size
# 07. batch_fraction
# 08. ompsta-t
# 09. ompnai-t
# 10. ompdel-t
# 11. ompfro-t
# 12. ompsta-m
# 13. ompnai-m
# 14. ompdel-m
# 15. ompfro-m