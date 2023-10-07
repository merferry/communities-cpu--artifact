set term pdf
set terminal pdf size 4in,2.7in
set output 'louvain-aff.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set style fill solid border lt -1
set style textbox opaque noborder
set xtics rotate by 45 right
set logscale x 10
set logscale y 10
set format x "10^{%L}"
set format y "10^{%L}"
set grid   y
set key above font ",12"
set xlabel  '{/:Bold Batch fraction}'
set ylabel  '{/:Bold Fraction of Affected vertices}'


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
plot 'louvain-aff.csv' \
       using 6:9  title 'P-DS_L'   linestyle 3 with linespoints, \
    '' using 6:10 title 'P-DF_L'   linestyle 4 with linespoints, \
    '' using 6:9:($6< 1e-6? sprintf("%.1f", $9 /$10) : "") with labels notitle offset character 3.7,character -0.8, \
    '' using 6:9:($6>=1e-6 && $6<1e-4? sprintf("%.1f", $9 /$10) : "") with labels notitle offset character 0,character -0.8, \
    '' using 6:9:($6>=1e-4 && $6<0.1 ? sprintf("%.1f", $9 /$10) : "") with labels notitle offset character 0,character -0.8, \
    '' using 6:9:($6>=0.1 ? sprintf("%.1f", $9 /$10) : "") with labels notitle offset character -3,character -0.8




## Columns in CSV file.
# 01. graph
# 02. order
# 03. size
# 04. batch_deletions_fraction
# 05. batch_insertions_fraction
# 06. batch_fraction
# 07. lousta-aff
# 08. lounai-aff
# 09. loudel-aff
# 10. loufro-aff
