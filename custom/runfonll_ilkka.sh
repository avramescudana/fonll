#!/bin/bash
#!runfonll.sh

executable="/home/ilmahele/workspace/fonll/FONLL-1.3.3/Linux/fonlllha"
run="dsdpT_test"
runtype=1
e=3500
beam1="1"
beam2="1"
#pdf1="0 0 260000"
#pdf2="0 0 260000"
pdf1="0 0 10550"
pdf2="0 0 10550"
#hvqm=4.75
hvqm=1.5
y=0.0

## Remove previous run
rm $run.dat > /dev/null

#pt=(10)
#pt=(0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5 13.5 14.5 15.5 16.5 17.5 18.5 19.5 20.5)
#pt=(0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20 20.5 21 21.5 22 22.5 23 23.5 24 24.5 25 25.5 26 26.5 27 27.5 28 28.5 29 29.5 30 30.5 31 31.5 32 32.5 33 33.5 34 34.5 35 35.5 36 36.5 37 37.5 38 38.5 39 39.5 40)
pt=(1 2 3 4 5 6 7 8 9 10)


for i in "${pt[@]}"
do

echo "Calculating point (pT,y) = ($i,${y})"

## 1 for FONLL, 2 for Fixed Order, 3 for resummed in the massless limit
runname=$run$i
filename=$runname".out"
pT=$i

#$executable <<EOF
$executable > /dev/null <<EOF
 $runname
 $beam1 $e $pdf1 
 $beam2 $e $pdf2
 $hvqm
 -1
 1 1
 $pT $y
 $runtype
EOF

result=$(head -n 1 $filename)
rm $run*".tmp" > /dev/null
rm $run*".out" > /dev/null
rm $run*"log" > /dev/null
echo $result | awk '{printf "%4.2f\t%5.3e\n", $1, $3*2*$pT}' >> $run.dat

done
