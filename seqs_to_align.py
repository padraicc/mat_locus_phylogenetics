from __future__ import print_function
import time
import argparse
import subprocess
import os

parser = argparse.ArgumentParser("python seqs_to_align.py --infile seqs.txt > seqs_aligned.fasta")
# parser.print_usage("python seqs_to_align --infile seqs.txt > seqs_aligned.fasta")
parser.add_argument('--infile', required=True, help="Infile list fasta sequence files to combine")
parser.add_argument('--lineage', required=False, help="File mapping the strains to lineage or species")
parser.add_argument('--outfile', required=True, help="File mapping the strains to lineage or species")

args = parser.parse_args()

if args.lineage:
    lineage_map = {line.rstrip().split()[0]: line.rstrip().split()[1] for line in open(args.lineage)}
    # print(lineage_map)


with open(args.infile) as seq_file:
    seq_list = [_.rstrip() for _ in seq_file]
    outfile = args.outfile

    with open(outfile, 'w') as out:
        for seq in seq_list:
            strain_id = os.path.basename(seq).split('.')[0]
            if args.lineage:
                if lineage_map[strain_id].startswith('L'):
                    print('>N_tetrasperma_{}_{}'.format(strain_id, lineage_map[strain_id]), file=out)
                else:
                     print('>{}_{}'.format(lineage_map[strain_id], strain_id), file=out)
            else:
                print('>N_tetrasperma_{}'.format(strain_id), file=out)

            with open(seq) as fasta_file:
                for line in fasta_file:
                    if line.startswith('>'):
                        continue
                    else:
                        print(line.rstrip(), file=out)






