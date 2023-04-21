set term pdf
set terminal pdf size 10in,6in font ",20"
set output 'hybrid-allss.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set title noenhanced
set style fill solid border lt -1
set style textbox opaque noborder
set lmargin 4.5
set tmargin 1
set xtics 2
unset xtics
set logscale x 10
set format x "%g"
set grid   y
set key off
set multiplot layout 3,4 margins 0.07,0.98,0.05,0.95 spacing 0.06,0.07
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
set label "Speedup" at screen 0.01,0.5 center rotate font "Tahoma,18"
set label "Threads" at screen 0.5,0.02 center font "Tahoma,18"
files='indochina-2004 arabic-2005 uk-2005 webbase-2001 it-2004 sk-2005 com-LiveJournal com-Orkut asia_osm europe_osm kmer_A2a kmer_V1r'
do for [i=1:words(files)] {
set title word(files, i) offset 0,-0.8
plot 'hybrid-allss/'.word(files, i).'.csv' \
       using 8:((0.001*$25 + 0.999*$28)/(0.001*$9  + 0.999*$12)) title 'Dyn. Frontier Louvain'     linestyle 2 with linespoints, \
    '' using 8:($30/$14)                                         title 'Dyn. Frontier RAK'         linestyle 3 with linespoints, \
    '' using 8:((0.002*$25 + 0.998*$32)/(0.002*$9  + 0.998*$16)) title 'Dyn. Frontier Louvain-RAK' linestyle 4 with linespoints,
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
# 08. num_threads
# 09. ompstal-t
# 10. ompstar-t
# 11. ompstars-t
# 12. ompfrol-t
# 13. ompfror-t
# 14. ompfrors-t
# 15. ompfrolr-t
# 16. ompfrolrs-t
# 17. ompstal-m
# 18. ompstar-m
# 19. ompstars-m
# 20. ompfrol-m
# 21. ompfror-m
# 22. ompfrors-m
# 23. ompfrolr-m
# 24. ompfrolrs-m
# 25. ompstal-t1
# 26. ompstar-t1
# 27. ompstars-t1
# 28. ompfrol-t1
# 29. ompfror-t1
# 30. ompfrors-t1
# 31. ompfrolr-t1
# 32. ompfrolrs-t1
