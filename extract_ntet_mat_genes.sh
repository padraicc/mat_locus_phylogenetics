#!/usr/bin/env bash


seq_files=data/mat_sequences
blast_results=data/blast_results

if [ ! -d "$seq_files" ]; then
	mkdir -p ${seq_files}
fi

if [ ! -d "$blast_results" ]; then
	mkdir -p ${blast_results}
fi


# Use blastn to find mat A loci and using samtools to extract the top hit
declare -a matA_array=('matA_1' 'matA_2' 'matA_3')

for i in ${matA_array[@]}
do

	query_fasta_file=data/2508.${i}.fasta

	cat bigA_strains.txt | while read j # loop through list of bigA strains and the pacbio sequenced strains
	do
		strain_id=${j}
		subject_db=data/denovo_files/${j}.fas

		blastn -query ${query_fasta_file} -db ${subject_db} -outfmt "6 sseqid sstart send sstrand" -out ${blast_results}/${strain_id}.${i}.txt
		cut -f1,2,3,4 ${blast_results}/${strain_id}.${i}.txt |
		while read scaffold start end strand ;
		do
			if [ ${start} -lt ${end} ]; then
				samtools faidx ${subject_db} ${scaffold}:${start}-${end} > ${seq_files}/${strain_id}.${i}.fasta
			else

				if [ ${strand} == 'minus' ]; then
					samtools faidx ${subject_db} ${scaffold}:${end}-${start} | seqtk seq -r -l 60 > ${seq_files}/${strain_id}.${i}.fasta
				fi

			fi

		done

	done

done


# blast the mat-a1 sequence against the small a strains

cat smalla_strains.txt | while read j # loop through list of small_a strains and the pacbio sequenced strains
do
	strain_id=${j}
	subject_db=data/denovo_files/${j}.fas

	blastn -query data/2509.mat_a1.fasta -db ${subject_db} -outfmt "6 sseqid sstart send sstrand" -out ${blast_results}/${strain_id}.mat_a1.txt
	cut -f1,2,3,4 ${blast_results}/${strain_id}.mat_a1.txt |
	while read scaffold start end strand ;
	do
		if [ ${start} -lt ${end} ]; then
			samtools faidx ${subject_db} ${scaffold}:${start}-${end} > ${seq_files}/${strain_id}.mat_a1.fasta
		else

			if [ ${strand} == 'minus' ]; then
				samtools faidx ${subject_db} ${scaffold}:${end}-${start} | seqtk seq -r -l 60 > ${seq_files}/${strain_id}.mat_a1.fasta
			fi

		fi

	done

done


