set term pdf
set terminal pdf size 4in,3.7in
set output 'rak-am.pdf'


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
set y2range [0.7:0.87]
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
plot 'rak-am.csv' \
       using 7:($9 /1000) title '    Static LPA'           linestyle 1 with linespoints, \
    '' using 7:($11/1000) title '    Naive-dyn. LPA'       linestyle 2 with linespoints, \
    '' using 7:($13/1000) title '    Dyn. Δ-screening LPA' linestyle 3 with linespoints, \
    '' using 7:($15/1000) title '    Dyn. Frontier LPA'    linestyle 4 with linespoints, \
    '' using 7:17 title '' linestyle 11 with linespoints axes x1y2, \
    '' using 7:19 title '' linestyle 12 with linespoints axes x1y2, \
    '' using 7:21 title '' linestyle 13 with linespoints axes x1y2, \
    '' using 7:23 title '' linestyle 14 with linespoints axes x1y2, \
    '' using 7:($15/1000):(sprintf("%.2f", $11/$15)) with labels notitle offset character 0,character 1




## Columns in CSV file.
# 01. graph
# 02. order
# 03. size
# 04. batch_deletions_size
# 05. batch_insertions_size
# 06. batch_size
# 07. batch_fraction
# 08. ompsta-t
# 09. ompstas-t
# 10. ompnai-t
# 11. ompnais-t
# 12. ompdel-t
# 13. ompdels-t
# 14. ompfro-t
# 15. ompfros-t
# 16. ompsta-m
# 17. ompstas-m
# 18. ompnai-m
# 19. ompnais-m
# 20. ompdel-m
# 21. ompdels-m
# 22. ompfro-m
# 23. ompfros-m
