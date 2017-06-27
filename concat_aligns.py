from __future__ import print_function
import sys
import egglib


with open(sys.argv[1]) as fasta_aligns:
    aln_list = [egglib.io.from_fasta(f.rstrip()) for f in fasta_aligns]

padded_align_list = []

for aln in aln_list:
    aln.fix_ends()

concat = egglib.tools.concat(*aln_list)

print(concat.to_fasta())
