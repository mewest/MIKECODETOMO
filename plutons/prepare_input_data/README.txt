############## PICKS_SET01 ##########################
#      09/27/2012
# This pick set is described in code below. It is based 
# on the total catalog at a time when it contained v4,v5 and slab
#####################################################

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



############## PICKS_SET02 ##########################
#      09/27/2012
#  This is the same as pick_set01 but using the improved 
# (and smaller) v4 catalog. v4 was revised to remove 105 
# events in OCtober 2012
#####################################################

rm -rf picks_set02/*
dbjoin /home/admin/databases/PLUTONS/origin/total/total.origin event |\
   dbsubset - "prefor==orid" |\
   dbsubset - "time>='04/15/2010'" |\
   dbjoin - assoc arrival |\
   dbsubset - "iphase=~/P|S/" |\
   dbjoin - site |\
   dbunjoin -o picks_set02/picks_set02 -
     
db2kml -sbl picks_set02/picks_set02 > picks_set02/picks_set02.kml

# IN MATLAB
     cd picks_set02
     ttimes.do_all('picks_set02')
     addpath('..');
     uturuncu_section('picks_set02')
     cd ..

# SHELL
cat FIG*.ps > picks_set02_FIGS.ps
ps2pdf picks_set02_FIGS.ps
rm -rf picks_set02_FIGS.ps



