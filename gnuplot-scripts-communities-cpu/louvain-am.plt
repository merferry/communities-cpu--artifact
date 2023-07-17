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
set format x "10^{%L}"
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
       using 4:($5 /1000)                    title 'Static Louvain'              linestyle 1 with linespoints, \
    '' using 4:($6 /1000)                    title 'Naive-dynamic Louvain'       linestyle 2 with linespoints, \
    '' using 4:((0.001*$5 + 0.999*$7 )/1000) title 'Dynamic Δ-screening Louvain' linestyle 3 with linespoints, \
    '' using 4:((0.001*$5 + 0.999*$8 )/1000) title 'Dynamic Frontier Louvain'    linestyle 4 with linespoints, \
    '' using 4:9  title '' linestyle 11 with linespoints axes x1y2, \
    '' using 4:10 title '' linestyle 12 with linespoints axes x1y2, \
    '' using 4:11 title '' linestyle 13 with linespoints axes x1y2, \
    '' using 4:12 title '' linestyle 14 with linespoints axes x1y2, \
    '' using 4:((0.001*$5 + 0.999*$8 )/1000):(sprintf("%.2f", $6/(0.001*$5 + 0.999*$8 ))) with labels notitle offset character 0,character -1




## Columns in CSV file.
# 01. graph
# 02. batch_deletions_fraction
# 03. batch_insertions_fraction
# 04. batch_fraction
# 05. lousta-t
# 06. lounai-t
# 07. loudel-t
# 08. loufro-t
# 09. lousta-m
# 10. lounai-m
# 11. loudel-m
# 12. loufro-m
