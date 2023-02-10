# Z-A
Data and scripts for calculating pi and Ne on autosomes and Z chromosome in manakin populations

Basic workflow:
- Start with raw reads (format: two .fastq files per sequencing lane, one for forward reads, one for reverse reads)
- Demultiplex and trim adapter sequences using Stacks process_radtags (result: a .fastq file for each individual)
- Align to a reference (we need to decide vitellinus vs. candei) using bwa mem (result: a bam file for each individual)
- Call SNPs using Stacks gstacks
- Create an unfiltered VCF file containing all sites, variant and invariant using Stacks populations (result: one VCF file per population)
- (NOTE ON THE ABOVE: WE MAY NOT BE ABLE TO USE STACKS FOR THIS. I'M LOOKING INTO IT)
- Filter the VCF file for quality and missingness using VCFtools (result: one VCF file per population)
- Calculate pi using pixy (result: pixy output file)
- TBD: how to translate the pixy results into final numbers per population and per chromosome
