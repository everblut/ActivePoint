set view map
set dgrid3d
set term png
set output outputname
set xtics border in scale 0,0 nomirror rotate by 45  offset character 0, 0, 0 autojustify
set xtics  norangelimit font ",8"
set ytics  norangelimit font ",8"
set xtics   ()
set samples 101, 101
set isosamples 100, 100
set cbtics 10 norangelimit
set cbrange [100:0]
set grid xtics ytics lw 1 lt 0 lc rgb 'black'
set title "Mapa de similitud"
splot filename u 1:2:3:xtic(4):ytic(5) w pm3d
