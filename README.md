# Z-A
Data and scripts for calculating pi and Ne on autosomes and Z chromosome in manakin populations

Basic workflow:
- Start with raw reads (format: two .fastq files per sequencing lane, one for forward reads, one for reverse reads)
- Demultiplex and trim adapter sequences using Stacks process_radtags (result: a .fastq file for each individual)
- Align to a reference (we need to decide vitellinus vs. candei) using bwa mem (result: a bam file for each individual)
- Call SNPs and generate an all-sites VCF using bcftools (result: one VCF file per population)
- Filter the VCF file for quality and missingness using vcftools (result: one VCF file per population)
- Calculate pi using pixy (result: pixy output file)
- Calculate per-population pi in R
