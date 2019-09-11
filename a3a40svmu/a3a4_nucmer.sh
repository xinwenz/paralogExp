#!/bin/bash

module load MUMmer

nucmer --maxmatch -p a3_a4 a3.fasta a4.fasta
