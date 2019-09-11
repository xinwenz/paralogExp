#!/bin/bash
#$ -t 2-483
#$ -q abio,bio,pub8i,pub64,epyc,free128,free64,free48,free88i,free72i,free56i,free48i,free40i,free32i,free24i,free16i
#$ -ckpt blcr

export PATH="/data/users/xinwenz/software/kent:/data/users/xinwenz/software/kent/blat:$PATH"
export wd=`pwd`
csh -f `head -n $SGE_TASK_ID jobList | tail -n 1`
