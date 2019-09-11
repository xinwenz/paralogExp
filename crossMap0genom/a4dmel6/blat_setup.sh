#### all you need is two genome fasta files #######
#### fasta to 2bit #####
### 11.ooc ########
##### run.blat/psl/... #######
##### generate job list ########
####### cp blatJob.csh and for blat_joblist.sh for HPC into run.blat/ 


export PATH="/data/users/xinwenz/software/kent/:/data/users/xinwenz/software/kent/blat/:$PATH"

workDirectory="/dfs1/bio/xinwenz/paralogExp/crossMap0genom/a4dmel6"
mkdir -p ${workDirectory}/run.blat ${workDirectory}/run.chain

# the resulting liftOver chain file will end up in ${workDirectory}/

# location where your two .2bit files are located:
export twoBitDirectory=${workDirectory}

#######################################################################
# targetDb is the sequence you have good coordinates you want to convert
export targetDb="dmel6"
# typical chunk size for a target sequence is 10,000,000 bases
export targetChunkSize="32100000"
# no need to overlap chunks, either target or query:
export chunkOverlapSize="0"
# allow only a single sequence to exist in a single chunk group
export chunkCountLimit="1"

# queryDb is the sequence you want to convert coordinates from the target
#    to the query
export queryDb="a4_7"
# typical chunk size for a query sequence is also 10,000,000 bases
export queryChunkSize="32100000"

faToTwoBit ${targetDb}.fasta ${targetDb}.2bit
faToTwoBit ${queryDb}.fasta ${queryDb}.2bit 
#######################################################################
# Compute partitions (coordinate ranges) for cluster jobs.
# working in the run.blat directory

cd ${workDirectory}/run.blat

# directory tParts will be created, make sure it is clean
rm -fr tParts
twoBitInfo ${twoBitDirectory}/${targetDb}.2bit stdout | sort -k2nr > ${targetDb}.chrom.sizes
# check the usage message for this command in the kent source tree
#   to see what all the arguments mean:
$HOME/software/kent/scripts/partitionSequence.pl ${targetChunkSize} \
   ${chunkOverlapSize} ${twoBitDirectory}/${targetDb}.2bit ${targetDb}.chrom.sizes \
   ${chunkCountLimit} \
   -lstDir=tParts > t_tmp.lst
# output t.lst is the listing of the target chunks to work with

# same procedure for the query bits:
rm -fr qParts
twoBitInfo ${twoBitDirectory}/${queryDb}.2bit stdout | sort -k2nr > ${queryDb}.chrom.sizes
# check the usage message for this command in the kent source tree
#   to see what all the arguments mean:
$HOME/software/kent/scripts/partitionSequence.pl ${queryChunkSize} \
   ${chunkOverlapSize} ${twoBitDirectory}/${queryDb}.2bit ${queryDb}.chrom.sizes \
   ${chunkCountLimit} \
   -lstDir=qParts > q_tmp.lst
# output q.lst is the listing of the query chunks to work with

#######################################################################
# Construct the 11.ooc file for the target sequence, assuming

cd ${workDirectory}/run.blat

#  the printout of the faSize is a line something like:
# 23332831 bases (10 N's 23332821 real 18400480 upper 4932341 lower) in 16 sequences in 1 files
# use the fifth field there, the 23332821 "real" number of bases:
export realSize=`twoBitToFa ${twoBitDirectory}/${targetDb}.2bit stdout | faSize stdin | grep real | awk '{print $5}'`
# calculate repMatch based on a proportion of the hg19 genoe size
export repMatch=`calc \( ${realSize} / 2897316137 \) \* 1024`
# That gives a really small number for small genomes, ignore that result
# and simply use a repMatch of 100:
blat ${twoBitDirectory}/${targetDb}.2bit /dev/null \
        /dev/null -tileSize=11 -makeOoc=11.ooc -repMatch=100

#######################################################################
# Construct the result output PSL directories

cd ${workDirectory}/run.blat
mkdir ${workDirectory}/run.blat/psl
for F in `cat t_tmp.lst`
do
  B=`basename ${F}`
  mkdir ${workDirectory}/run.blat/psl/${B}
done


# construct gensub2 template file
#  ( allow only ${workDirectory} to shell expand here, the other $ variables
#	are for gensub2 use, hence \$ to keep them literal )
# the "blatJob.csh" script can be found at:

cat << EOF > template
#LOOP
./blatJob.csh \$(path1) \$(path2) ${workDirectory}/run.blat/psl/\$(file1)/\$(file2).psl
#ENDLOOP
EOF

## construct jobList for each query chunk blat to each target chunk:i
## with absolute path
awk -v pwd="$PWD" '{ if ($1 ~ /.*dfs1.*/) print $1; else print pwd"/"$1 }' t_tmp.lst > t.lst
awk -v pwd="$PWD" '{ if ($1 ~ /.*dfs1.*/) print $1; else print pwd"/"$1 }' q_tmp.lst > q.lst

rm t_tmp.lst
rm q_tmp.lst

gensub2 t.lst q.lst template jobList

# the resulting jobList is a listing of commands to be run which will perform
# the blat on each specified target/query chunk pair of sequences
# With the blatJob.csh in place in this run.blat directory, you can simply
# run each job in the jobList:
#    chmod +x ./jobList
#    ./jobList > jobs.log 2>&1i

cd ${workDirectory}
cp *.csh ${workDirectory}/run.blat/
cp blat_joblist.sh ${workDirectory}/run.blat/
