set term pdf
set terminal pdf size 4in,3in
set output 'rak-am.pdf'


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
set y2range [0.6:0.85]
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
       using 4:($5 /1000) title 'Static LPA' linestyle 1 with linespoints, \
    '' using 4:($7 /1000) title 'P-DS_{LPA}' linestyle 3 with linespoints, \
    '' using 4:($8 /1000) title 'P-DF_{LPA}' linestyle 4 with linespoints, \
    '' using 4:9  title '' linestyle 11 with linespoints axes x1y2, \
    '' using 4:11 title '' linestyle 13 with linespoints axes x1y2, \
    '' using 4:12 title '' linestyle 14 with linespoints axes x1y2, \
    '' using 4:($5 /1000):($4<=1e-7? sprintf("%.2f", $5 /$8 ) : "") with labels notitle offset character 2.3,character -0.7, \
    '' using 4:($5 /1000):($4> 1e-7 && $4< 1e-1? sprintf("%.2f", $5 /$8 ) : "") with labels notitle offset character 0.5,character -0.8, \
    '' using 4:($5 /1000):($4>=1e-1? sprintf("%.2f", $5 /$8 ) : "") with labels notitle offset character -3.5,character -1, \
    '' using 4:($7 /1000):($4<=1e-7? sprintf("%.2f", $7 /$8 ) : "") with labels notitle offset character 2.3,character 0.7, \
    '' using 4:($7 /1000):($4> 1e-7 && $4< 1e-2? sprintf("%.2f", $7 /$8 ) : "") with labels notitle offset character 0.5,character -0.8, \
    '' using 4:($7 /1000):($4>=1e-2 && $4< 1e-1? sprintf("%.2f", $7 /$8 ) : "") with labels notitle offset character 2.7,character 0, \
    '' using 4:($7 /1000):($4>=1e-1? sprintf("%.2f", $7 /$8 ) : "") with labels notitle offset character -2.5,character -2




## Columns in CSV file.
# 01. graph
# 02. batch_deletions_size
# 03. batch_insertions_size
# 04. batch_fraction
# 05. raksta-t
# 06. raknai-t
# 07. rakdel-t
# 08. rakfro-t
# 09. raksta-m
# 10. raknai-m
# 11. rakdel-m
# 12. rakfro-m
