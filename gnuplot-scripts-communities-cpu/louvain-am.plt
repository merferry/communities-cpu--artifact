set term pdf
set terminal pdf size 4in,3.7in
set output 'louvain-am.pdf'


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
set y2range [0.85:0.95]
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
plot 'louvain-am.csv' \
       using 7:($8 /1000)                    title 'Static Louvain'           linestyle 1 with linespoints, \
    '' using 7:($9 /1000)                    title 'Naive-dyn. Louvain'       linestyle 2 with linespoints, \
    '' using 7:((0.001*$8 + 0.999*$10)/1000) title 'Dyn. Δ-screening Louvain' linestyle 3 with linespoints, \
    '' using 7:((0.001*$8 + 0.999*$11)/1000) title 'Dyn. Frontier Louvain'    linestyle 4 with linespoints, \
    '' using 7:12 title '' linestyle 11 with linespoints axes x1y2, \
    '' using 7:13 title '' linestyle 12 with linespoints axes x1y2, \
    '' using 7:14 title '' linestyle 13 with linespoints axes x1y2, \
    '' using 7:15 title '' linestyle 14 with linespoints axes x1y2, \
    '' using 7:((0.001*$8 + 0.999*$11)/1000):(sprintf("%.2f", $9/(0.001*$8 + 0.999*$11))) with labels notitle offset character 0,character -1




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
