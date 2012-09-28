#!/bin/sh

# This script will create images of a raw synthetic model.
# It can be used to visualize a synthetic model before running inversions

#export PATH=$PATH:_path_to_your_gmt_



cd ./PROGRAMS/4_CREATE_SYN_DATA/a_set_syn_hor
create.exe
cd ../../..


cd ./PROGRAMS/4_CREATE_SYN_DATA/a_set_syn_ver
create.exe
cd ../../..

