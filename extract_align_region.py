import argparse
import egglib
import sys


def complement(seq_str):

    comp_dict = {'A': 'T', 'G': 'C', 'T': 'A', 'C': 'G', 'N': 'N', '?': '?', '-':'-'}

    complement_seq = ''
    for base in seq_str:
        complement_seq += comp_dict[base]

    return complement_seq

parser = argparse.ArgumentParser(description="Extract region from a fasta alignment file")
parser.add_argument('-infile', required=True, help="input fasta file")
parser.add_argument('-start', required=True, type=int)
parser.add_argument('-end', required=True, type=int)
parser.add_argument('-out', required=True, help="Outfile")

parser.add_argument('--complement', required=False, action='store_true', help="complement sequences")
parser.add_argument('--reverse', required=False, action='store_true', help="reverse sequences")
parser.add_argument('--revcomp', required=False, action='store_true', help="reverse complement sequences")
args = parser.parse_args()

aln = egglib.io.from_fasta(args.infile)
start = args.start - 1  # convert 1-based to zero-based
end = args.end

if args.complement and args.reverse:
    sys.exit("Choose --reverse or complement and not both")

if args.complement and args.revcomp:
    sys.exit("Choose --complement or --revcomp and not both")

if args.reverse and args.revcomp:
    sys.exit("Choose --reverse or --revcomp and not both")

if args.reverse and args.revcomp and args.complement:
    sys.exit("Choose one of --reverse, --complement or --revcomp")

sub_align = aln.extract(start, end)

if args.complement:
    for i in range(aln.ns):
        seq = sub_align.get_sequence(i).string()
        comp_seq = complement(seq)
        sub_align.set_sequence(i, comp_seq)


elif args.revcomp:
    for i in range(aln.ns):
        rc_seq = egglib.tools.rc((sub_align.get_sequence(i).string()))
        sub_align.set_sequence(i, rc_seq)

elif args.reverse:
    for i in range(aln.ns):
        seq = sub_align.get_sequence(i).string()
        rev_seq = sub_align.get_sequence(i).string()[::-1]
        sub_align.set_sequence(i, rev_seq)

sub_align.fix_ends()
sub_align.to_fasta(args.out)
