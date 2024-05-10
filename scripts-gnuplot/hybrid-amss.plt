set term pdf
set terminal pdf size 4in,3in
set output 'hybrid-amss.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set style fill solid border lt -1
set style textbox opaque noborder
set xrange [1:64]
set xtics 2
set xtics rotate by 45 right
set logscale x 10
set format x "%g"
set grid   y
set key off # above font ",12"
set xlabel  '{/:Bold Threads}'
set ylabel  '{/:Bold Speedup (wrt 1 thread)}'


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
plot 'hybrid-amss.csv' \
       using 2:($10/$5 ) title 'P-DF_L'     linestyle 2 with linespoints, \
    '' using 2:($11/$6 ) title 'P-DF_{LPA}' linestyle 3 with linespoints, \
    '' using 2:($12/$7 ) title 'P-DF_H'     linestyle 4 with linespoints,




## Columns in CSV file.
# 01. graph
# 02. num_threads
# 03. lousta-t
# 04. raksta-t
# 05. loufro-t
# 06. rakfro-t
# 07. hybfro-t
# 08. lousta-t1
# 09. raksta-t1
# 10. loufro-t1
# 11. rakfro-t1
# 12. hybfro-t1
# 13. lousta-m
# 14. raksta-m
# 15. loufro-m
# 16. rakfro-m
# 17. hybfro-m
