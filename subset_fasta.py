import sys

keep_list = [] 
for line in open(sys.argv[1], 'r'): # loop through file listing seq ids we want
    keep_list.append(line.rstrip().replace('>', '')) # append them to a list and remove '>'


for line in open(sys.argv[2], 'r'):
    if line.startswith('>'):
        seq_name = line.rstrip().replace('>', '') # remove newline character and remove '>'
        if seq_name in keep_list:
            keep_seq = True
        else:
            keep_seq = False

    if keep_seq == True:
        print line.rstrip()

