# Phylogenetic analysis of mat-a1 and mat A-1, mat A-2 and mat-A3 genes for Neurospora tetrasperma and heterothallic Neurospora

## Summary
Identified mat-a1 and mat-A genes for N. tetrasperma genomes using blastn, aligned sequences using MUSCLE and performed phylogenetic analysis using RAxML. The details of the steps are given below and are described in further details [here]()

The maximum likelihood best phylogenetic tree for mat-a1 and the tree for the concatenated mat-A1, A2 and A3 are located [here](https://github.com/padraicc/mat_locus_phylogenetics/tree/master/data/raxml_results)

## Programs used

 + blastn from BLAST 2.6.0+  
 + MUSCLE v3.8.31  
 + egglib v3.0.0b13  
 + RAxML v8.2.4  
 + Phyutility v.2.2.6  
 + FigTree v1.4.2

## Blasted the mat a-1 sequence from N. crassa (genbank accession M54787.1) to Ntet 2509 mat a genome 

The mat-a1 gene sequence was downloaded from [NCBI](https://www.ncbi.nlm.nih.gov/nuccore/293953?report=fastadyn094130)

    $ blastn -query data/ncra.mat_a1.fasta  -db ntet_2509/GCA_000213195.1_v1.0_genomic.fna -outfmt 7 -out ntet_2509.blast_mata1_result.txt

## Extracted the best hit region from the NCBI refseq GFF of N. tetrasperma 2509 to see the annotated genes in this region

	$ tabix data/ntet_2509/GCA_000213195.1_v1.0_genomic.gff.gz GL890999.1:7680629-7685846 > genes_overlapping_mata1_blast_result.txt

## Selected the gene gene2113 that encodes a HMG-box domain protein 

	$ samtools faidx data/ntet_2509/GCA_000213195.1_v1.0_genomic.fna GL890999.1:7682534-7683960 > data/2509_mat_a1.fasta
 
## Extracted the matA1,matA2 and matA3 locations for Ncra and Ntet reference genome using the gff files

	$ zgrep "Name=matA" data/ncra_NC12/GCF_000182925.2_NC12_genomic.gff.gz | cut -f1,4-5 > ncra_matA_genes.txt
	$ cat ntet_2508_matA_locus_genes.txt | while read i j k l; do samtools faidx data/ntet_2508/GCF_000213175.1_v2.0_genomic.fna.gz $i:$j-$k > data/2508.$l.fasta ; done

## Extracted the matA-1, matA-2, matA-3 and mat-a1 locations from N. discreta and the N. tetrasperma de Novo genomes using blastn.

Extracted the top hit from the blast hit and extracted the region using samtools faidx
	
	$ bash extract_ndiscreta_mat_genes.sh
	$ bash make_blast_dbs.sh
	$ bash extract_ntet_mat_genes.sh
	
## Creation of multiple alignments
Aligned the gene sequences with MUSCLE and extracted a subset of N. tetrasperma strains, 1 strain per lineage due to the lack
of polymorphism within the mat SR region. The mat-A1, mat-A2 and mat A3 genes were concatenated to form a single matA gene
alignment. The mat gene sequences for the heterothallic species were obtained from the public data available from the 
study of [Strandberg et al. 2010](https://www.ncbi.nlm.nih.gov/pubmed/20601044)

	$ bash make_alignments.sh

## Phylogenetic analysis was carried out using RAxML and 1000 bootstrap replicate searches were performed 
 
	$ qsub raxml_command.sh
	$ bash map_bootstrap.sh
	
Trees were visualised, and sample names modified, using the FigTree tree viewing program. The best trees found by RAxML are located [here](https://github.com/padraicc/mat_locus_phylogenetics/tree/master/data/raxml_results)
	
  
  
