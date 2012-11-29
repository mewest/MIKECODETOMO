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
rm -rf *.ps



############## PICKS_SET02 ##########################
#      09/27/2012
#  This is the same as pick_set01 but using the improved 
# (and smaller) v4 catalog. v4 was revised to remove 105 
# events in October 2012
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
rm -rf *.ps



############## PICKS_SET03 ##########################
#      11/27/2012
# This is the same as pick_set02 but using the additional slab 
# events derived from the chile catalog as well as the slab catalog.
#####################################################

rm -rf picks_set03/*
dbjoin /home/admin/databases/PLUTONS/origin/total/total.origin event |\
   dbsubset - "prefor==orid" |\
   dbsubset - "time>='04/15/2010'" |\
   dbsubset - "deg2km(distance(origin.lat,origin.lon,-22.26,-67.18))<200" |\
   dbjoin - assoc arrival |\
   dbsubset - "iphase=~/P|S/" |\
   dbjoin - site |\
   dbsubset - "deg2km(distance(site.lat,site.lon,-22.26,-67.18))<100" |\
   dbunjoin -o picks_set03/picks_set03 -
     
db2kml -sbl picks_set03/picks_set03 > picks_set03/picks_set03.kml

# IN MATLAB
     cd picks_set03
     ttimes.do_all('picks_set03')
     addpath('..');
     uturuncu_section('picks_set03')
     cd ..

# SHELL
cat picks_set03/FIG*.ps > picks_set03/picks_set03_FIGS.ps
pstopdf picks_set03/picks_set03_FIGS.ps
# rm -rf picks_set03/*.ps
# copy to working dir ...


############## PICKS_SET04 ##########################
#      11/27/2012
# This is a subset of the picks_set03 that excludes the so-called slab catalog events 
#####################################################

rm -rf picks_set04/*
dbjoin /home/admin/databases/PLUTONS/origin/total/total.origin event |\
   dbsubset - "prefor==orid" |\
   dbsubset - "time>='04/15/2010'" |\
   dbsubset - "deg2km(distance(origin.lat,origin.lon,-22.26,-67.18))<200" |\
   dbsubset - 'depth<50' |\
   dbsubset - 'auth!="OSC" && auth!="UdC"' |\
   dbjoin - assoc arrival |\
   dbsubset - "iphase=~/P|S/" |\
   dbjoin - site |\
   dbsubset - "deg2km(distance(site.lat,site.lon,-22.26,-67.18))<100" |\
   dbunjoin -o picks_set04/picks_set04 -
     
db2kml -sbl picks_set04/picks_set04 > picks_set04/picks_set04.kml

# IN MATLAB
     cd picks_set04
     ttimes.do_all('picks_set04')
     addpath('..');
     uturuncu_section('picks_set04')
     cd ..

# SHELL
cat picks_set04/FIG*.ps > picks_set04/picks_set04_FIGS.ps
pstopdf picks_set04/picks_set04_FIGS.ps
# rm -rf picks_set04/*.ps
# copy to working dir ...



############## PICKS_SET05 ##########################
#      11/27/2012
# This is a subset of the picks_set03 that includes ONLY the slab catalog events 
#####################################################

rm -rf picks_set05/*
dbjoin /home/admin/databases/PLUTONS/origin/total/total.origin event |\
   dbsubset - "prefor==orid" |\
   dbsubset - "time>='04/15/2010'" |\
   dbsubset - "deg2km(distance(origin.lat,origin.lon,-22.26,-67.18))<200" |\
   dbsubset - 'depth>50' |\
   dbsubset - 'auth=="OSC" || auth=="UdC"' |\
   dbjoin - assoc arrival |\
   dbsubset - "iphase=~/P|S/" |\
   dbjoin - site |\
   dbsubset - "deg2km(distance(site.lat,site.lon,-22.26,-67.18))<100" |\
   dbunjoin -o picks_set05/picks_set05 -
     
db2kml -sbl picks_set05/picks_set05 > picks_set05/picks_set05.kml

# IN MATLAB
     cd picks_set05
     ttimes.do_all('picks_set05')
     addpath('..');
     uturuncu_section('picks_set05')
     cd ..

# SHELL
cat picks_set05/FIG*.ps > picks_set05/picks_set05_FIGS.ps
pstopdf picks_set05/picks_set05_FIGS.ps
# rm -rf picks_set05/*.ps
# copy to working dir ...




