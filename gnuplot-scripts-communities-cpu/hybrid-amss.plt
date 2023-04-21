set term pdf
set terminal pdf size 4in,3.7in
set output 'hybrid-amss.pdf'


## Set global styles
set termoption dashed
set datafile separator ','
set style fill solid border lt -1
set style textbox opaque noborder
set xtics 2
set xtics rotate by 45 right
set logscale x 10
set format x "%g"
set grid   y
set key above font ",12"
set xlabel  '{/:Bold Threads}'
set ylabel  '{/:Bold Speedup}'


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
       using 8:((0.001*$25 + 0.999*$28)/(0.001*$9  + 0.999*$12)) title 'Dyn. Frontier Louvain'     linestyle 2 with linespoints, \
    '' using 8:($30/$14)                                         title 'Dyn. Frontier LPA'         linestyle 3 with linespoints, \
    '' using 8:((0.002*$25 + 0.998*$32)/(0.002*$9  + 0.998*$16)) title 'Dyn. Frontier Louvain-LPA' linestyle 4 with linespoints,




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
