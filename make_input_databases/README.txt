# This pick set contains 




rm -rf picks_set01/*
dbjoin /home/admin/databases/PLUTONS/origin/total/total.origin event |\
   dbsubset - "prefor==orid" |\
   dbsubset - "time>='04/15/2010'" |\
   dbjoin - assoc arrival |\
   dbsubset - "iphase=~/P|S/" |\
   dbjoin - site |\
   dbunjoin -o picks_set01/picks_set01 -
     
db2kml -sbl picks_set01/picks_set01 > picks_set01/picks_set01.kml


# IN MATLAB
     cd picks_set01
     ttimes.do_all('picks_set01')
     addpath('..');
     uturuncu_section('picks_set01')
     cd ..


# SHELL
cat FIG*.ps > picks_set01_FIGS.ps
ps2pdf picks_set01_FIGS.ps
rm -rf picks_set01_FIGS.ps



