#!/bin/bash
#$ -ckpt restart

blastfl=self_dmel6gen.blast

allines=`cat ../0dmel6ref//Dmel6_gene_list`
for line in $allines
do
	mylist=$(grep $line $blastfl | cut -d"," -f 12 | tr "\n" ',')
 	num=$(echo $mylist | grep ',' -o | wc -l)
	res1=$(echo $mylist | cut -d"," -f 1) 
	res2=$(echo $mylist | cut -d"," -f 2)
	res3=$(echo $mylist | cut -d"," -f 3)
	res4=$(echo $mylist | cut -d"," -f 4)
	res5=$(echo $mylist | cut -d"," -f 5) 
	echo -e $line $num $res1 $res2 $res3 $res4 $res5
done

