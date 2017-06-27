#!/bin/bash

#$ -l h_rt=12:00:00
#$ -l mem=4G
#$ -l rmem=4G
#$ -l arch=intel*
#$ -e raxml_log.e
#$ -o raxml_log.o
#$ -N phy 
#$ -q evolgen.q -P evolgen
#$ -pe openmp 20


cd data/alignments

raxmlHPC-PTHREADS-SSE3 -T 10 -s matA123.phylo_set.phy -n matA123.best.tre -p 12345 -m GTRGAMMA -f d -N 30 &

raxmlHPC-PTHREADS-SSE3 -T 10 -s matA123.phylo_set.phy -n matA123.boot.tre -p 12345 -x 12345 -m GTRGAMMA -N 1000 &

wait

raxmlHPC-PTHREADS-SSE3 -T 10 -s mat_a1.phylo_set.phy -n mat_a1.best.tre -p 12345 -m GTRGAMMA -f d -N 30 &

raxmlHPC-PTHREADS-SSE3 -T 10 -s mat_a1.phylo_set.phy -n mat_a1.boot.tre -p 12345 -x 12345 -m GTRGAMMA -N 1000 &

wait

mv *.tre ../raxml_results


