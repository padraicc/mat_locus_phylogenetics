#!/usr/bin/env bash


find data/denovo_files/*.fas data/pacbio_assemblies/*.fas | while read i

do

	makeblastdb -in ${i} -dbtype nucl -out ${i}

	samtools faidx ${i}

done
