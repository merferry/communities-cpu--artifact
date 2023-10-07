set term pdf
set terminal pdf size 4in,3in
set output 'hybrid-am.pdf'


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
set y2range [0.67:0.95]
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
       using 4:($7 /1000) title 'P-DF_L'     linestyle 2 with linespoints, \
    '' using 4:($8 /1000) title 'P-DF_{LPA}' linestyle 3 with linespoints, \
    '' using 4:($9 /1000) title 'P-DF_H'     linestyle 4 with linespoints, \
    '' using 4:12 title '' linestyle 12 with linespoints axes x1y2, \
    '' using 4:13 title '' linestyle 13 with linespoints axes x1y2, \
    '' using 4:14 title '' linestyle 14 with linespoints axes x1y2, \
    '' using 4:($7 /1000):($4<=1e-7? sprintf("%.2f", $7 /$9 ) : "") with labels notitle offset character 2.3,character 0.8, \
    '' using 4:($7 /1000):($4> 1e-7 && $4<1e-1? sprintf("%.2f", $7 /$9 ) : "") with labels notitle offset character 0,character 0.8, \
    '' using 4:($7 /1000):($4>=1e-1? sprintf("%.2f", $7 /$9 ) : "") with labels notitle offset character -2,character 1




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
