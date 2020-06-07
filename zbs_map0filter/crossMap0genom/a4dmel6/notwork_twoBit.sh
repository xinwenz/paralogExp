# load module by adding kent into path 

target="scer_num"
export PATH="/data/users/xinwenz/software/kent:$PATH"
faToTwoBit ${target}.fasta ${target}.2bit
twoBitInfo ${target}.2bit stdout | sort -k2,2nr > ${target}.chrom.sizes 

#faToTwoBit dmel6.fa dmel6.2bit
#twoBitInfo dmel6.2bit stdout | sort -k2,2nr > dmel6.chrom.sizes 

#faSize dmel6.fa
#real 142573024

#calc \( 142573024 / 2861349177 \) \* 1024 
#51.02 : round down to the nearset 50? that is 50

# creat ooc file with -repMatch=50
#blat dmel6.2bit /dev/null /dev/null -tileSize=11 -mak#eOoc=dmel6.ooc -repMatch=50

target="dmel6"
query="a3"

time (/data/apps/user_contributed_software/ytao7/kentUtils/src/hg/utils/automation/doSameSpeciesLiftOver.pl -verbose=2 -buildDir=`pwd`\
-ooc=`pwd`/${target}.ooc -fileServer=localhost -localTmp="/dev/shm" \
-bigClusterHub=localhost -dbHost=localhost -workhorse=localhost \
-target2Bit=`pwd`/${target}.2bit -targetSizes=`pwd`/${target}.chrom.sizes \ 
-query2Bit=`pwd`/${query}.2bit -querySizes=`pwd`/${query}.chrom.sizes ${target} ${query}) > do.log 2>&1
 

 

