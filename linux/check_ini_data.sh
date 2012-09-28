# This script checks the validity of the inital data files. If there is 
# an error in the rays.dat or stat_ft.dat file this script will find it. 
# It also outputs diagnostics useful for configuring MAJOR_PARAMS.



cd PROGRAMS/0_START/check_data
./check_data.exe
cd ../../..
