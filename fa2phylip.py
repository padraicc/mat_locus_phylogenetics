from __future__ import print_function
import argparse
import egglib

parser = argparse.ArgumentParser(description="Extract region from a fasta alignment file")
parser.add_argument('-infile', required=True, help="input fasta file")
parser.add_argument('-out', required=True, help="Outfile")

args = parser.parse_args()
aln = egglib.io.from_fasta(args.infile)
phylip_string = aln.phyml()
with open(args.out, 'w') as outfile:
    print(phylip_string, file=outfile)
