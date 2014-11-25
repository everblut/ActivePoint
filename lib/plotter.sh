#!/bin/bash
gnuplot -e "filename='$2'; outputname='$3'" "$1"
rm $2
