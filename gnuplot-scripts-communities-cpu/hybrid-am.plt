set term pdf
set terminal pdf size 4in,3.7in
set output 'hybrid-am.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set style fill solid border lt -1
set style textbox opaque noborder
set xtics rotate by 45 right
set logscale x 10
set logscale y 10
set format x "%g"
set grid   y
set key above font ",12"
set xlabel  '{/:Bold Batch fraction}'
set ylabel  '{/:Bold Runtime (s)}'
set y2label '{/:Bold Modularity}'
set y2range [0.75:1.00]
set y2tics  0.05


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
plot 'hybrid-am.csv' \
       using 7:((0.001*$8  + 0.999*$11)/1000) title 'Dyn. Frontier Louvain'     linestyle 2 with linespoints, \
    '' using 7:($13/1000)                     title 'Dyn. Frontier LPA'         linestyle 3 with linespoints, \
    '' using 7:((0.002*$8  + 0.998*$15)/1000) title 'Dyn. Frontier Louvain-LPA' linestyle 4 with linespoints, \
    '' using 7:19 title '' linestyle 12 with linespoints axes x1y2, \
    '' using 7:21 title '' linestyle 13 with linespoints axes x1y2, \
    '' using 7:23 title '' linestyle 14 with linespoints axes x1y2, \
    '' using 7:((0.002*$8  + 0.998*$15)/1000):(sprintf("%.2f", (0.001*$8  + 0.999*$11)/(0.002*$8  + 0.998*$15))) with labels notitle offset character 0,character -1




## Columns in CSV file.
# 01. graph
# 02. order
# 03. size
# 04. batch_deletions_size
# 05. batch_insertions_size
# 06. batch_size
# 07. batch_fraction
# 08. ompstal-t
# 09. ompstar-t
# 10. ompstars-t
# 11. ompfrol-t
# 12. ompfror-t
# 13. ompfrors-t
# 14. ompfrolr-t
# 15. ompfrolrs-t
# 16. ompstal-m
# 17. ompstar-m
# 18. ompstars-m
# 19. ompfrol-m
# 20. ompfror-m
# 21. ompfrors-m
# 22. ompfrolr-m
# 23. ompfrolrs-m
