#!/usr/bin/env bash

# combine the sequence files into alignments and align with muscle

find data/mat_sequences/*matA_1* data/*matA_1.fasta > matA1_seqs.txt
python seqs_to_align.py --infile matA1_seqs.txt --lineage strain_lineage_map.txt --outfile data/alignments/matA1_unaligned.fasta

find data/mat_sequences/*matA_2* data/*matA_2.fasta > matA2_seqs.txt
python seqs_to_align.py --infile matA2_seqs.txt --lineage strain_lineage_map.txt --outfile data/alignments/matA2_unaligned.fasta

find data/mat_sequences/*matA_3* data/*matA_3.fasta > matA3_seqs.txt
python seqs_to_align.py --infile matA3_seqs.txt --lineage strain_lineage_map.txt --outfile data/alignments/matA3_unaligned.fasta


# create mat A alignments
python extract_align_region.py -infile data/heterothallic_mat_aligns/Neurospora_mat_A123.fas -start 1 -end 995 -out data/alignments/heterothallic_matA_1.fasta
python extract_align_region.py -infile data/heterothallic_mat_aligns/Neurospora_mat_A123.fas -start 996 -end 2388 -out data/alignments/heterothallic_matA_2.fasta
python extract_align_region.py -infile data/heterothallic_mat_aligns/Neurospora_mat_A123.fas -start 2389 -end 3526 --revcomp -out data/alignments/heterothallic_matA_3.fasta

cat data/alignments/heterothallic_matA_1.fasta >> data/alignments/matA1_unaligned.fasta
cat data/alignments/heterothallic_matA_2.fasta >> data/alignments/matA2_unaligned.fasta
cat data/alignments/heterothallic_matA_3.fasta >> data/alignments/matA3_unaligned.fasta

muscle -in data/alignments/matA1_unaligned.fasta -out data/alignments/matA1.temp.fasta
muscle -in data/alignments/matA2_unaligned.fasta -out data/alignments/matA2.fasta
muscle -in data/alignments/matA3_unaligned.fasta -out data/alignments/matA3.temp.fasta

python extract_align_region.py -infile data/alignments/matA1.temp.fasta -start 143 -end 1368 -out data/alignments/matA1.fasta
python extract_align_region.py -infile data/alignments/matA3.temp.fasta -start 1 -end 1138  -out data/alignments/matA3.fasta

rm data/alignments/matA*_unaligned.fasta data/alignments/heterothallic_matA_*.fasta data/alignments/*.temp.fasta

# concatenate the mat-A1, mat-A2 and mat-A3

find data/alignments/matA*.fasta > bigA_aligns.txt
python concat_aligns.py bigA_aligns.txt > data/alignments/matA123.fasta

# extract a subset of N. tetrasperma strains  (1 per lineage) and remove N crass c from mat_A123 alignment as it is missing matA-2
python subset_fasta.py strains_for_phylogentics.txt data/alignments/matA123.fasta > data/alignments/matA123.phylo_set.fasta
python fa2phylip.py -infile data/alignments/matA123.phylo_set.fasta -out data/alignments/matA123.phylo_set.phy

# create mat-a1 alignment
find data/mat_sequences/*mat_a1* data/*mat_a1.fasta > mat_a1_seqs.txt
python seqs_to_align.py --infile mat_a1_seqs.txt --lineage strain_lineage_map.txt --outfile data/alignments/mat_a1_unaligned.fasta

cat data/heterothallic_mat_aligns/Neurospora_mat_a1.fas >> data/alignments/mat_a1_unaligned.fasta

muscle -in data/alignments/mat_a1_unaligned.fasta -out data/alignments/mat_a1.temp.fasta

python extract_align_region.py -infile data/alignments/mat_a1.temp.fasta -start 3227 -end 4653  -out data/alignments/mat_a1.fasta

python subset_fasta.py strains_for_phylogentics.txt data/alignments/mat_a1.fasta > data/alignments/mat_a1.phylo_set.fasta
python fa2phylip.py  -infile data/alignments/mat_a1.phylo_set.fasta  -out data/alignments/mat_a1.phylo_set.phy


rm data/alignments/mat_a1_unaligned.fasta data/alignments/mat_a1.temp.fasta










