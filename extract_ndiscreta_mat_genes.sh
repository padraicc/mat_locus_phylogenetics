#!/usr/bin/env bash


makeblastdb -in data/ndis_8579/Neurospora_discreta.AssemblyScaffolds.fasta -dbtype nucl -out data/ndis_8579/Neurospora_discreta.AssemblyScaffolds.fasta


ls data/ncra.matA*.fasta | while read i; 
do 

    fasta_id="$(basename $i .fasta)"
    
    blastn -query $i -db data/ndis_8579/Neurospora_discreta.AssemblyScaffolds.fasta -outfmt 7 -out data/ndis.${fasta_id}.txt

done

grep -v ^# data/ndis.ncra.matA_1.txt | head -n1 | cut -f2,9-10 | while read i j k ; do samtools faidx data/ndis_8579/Neurospora_discreta.AssemblyScaffolds.fasta $i:$j-$k > data/ndis.matA_1.fasta; done

grep -v ^# data/ndis.ncra.matA_2.txt | head -n1 | cut -f2,9-10 | while read i j k ; do samtools faidx data/ndis_8579/Neurospora_discreta.AssemblyScaffolds.fasta $i:$j-$k > data/ndis.matA_2.fasta; done

grep -v ^# data/ndis.ncra.matA_3.txt | head -n1 | cut -f2,9-10 | while read i j k ; do samtools faidx data/ndis_8579/Neurospora_discreta.AssemblyScaffolds.fasta $i:$j-$k > data/ndis.matA_3ls .fasta; done