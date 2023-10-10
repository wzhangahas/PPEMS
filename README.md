# PPEMS
Parsing Prokaryotic and Eukaryotic Microbial Genes Simultaneously from Metagenome by a Novel Analysis Workflow

    The lack of reliable methods for the simultaneous prediction of prokaryotic and eukaryotic microbial genes further
complicates this task. We evaluated gene prediction accuracy for various single organisms using MetaGeneMark and 
MetaEuk pipelines. Building upon these findings, we devised an innovative analysis workflow. Our approach involves 
initially predicting eukaryotic genes using MetaEuk, followed by masking of predicted eukaryotic and partial 
prokaryotic genes via a Perl program. The subsequent prediction of remaining prokaryotic genes is conducted using 
MetaGeneMark or metaProdigal. The new workflow effectively enables the rapid and precise retrieval of coding sequences 
from metagenomes.

Install:

The easiest way to install the following software:

MetaEuk: conda install -c conda-forge -c bioconda metaeuk; conda install -c conda-forge -c bioconda mmseqs2

metaProdigal: conda install -c bioconda prodigal

MetaGeneMark: MetaGeneMark_linux_64.tar.gz and gm_key_64.gz were download from http://topaz.gatech.edu/GeneMark/license_download.cgi. 

gunzip gm_key_64.gz

cp -r  gm_key_64 ~/.gm_key

tar -xzvf MetaGeneMark_linux_64.tar.gz


Run:

Database: https://wwwuser.gwdg.de/~compbiol/metaeuk/

congitgs: wget https://wwwuser.gwdg.de/~compbiol/metaeuk/2019_11/assembled_Tara_5kb_EukRep_contigs.fas.gz

protein database: wget https://wwwuser.gwdg.de/~compbiol/metaeuk/2019_11/MERC_MMETSP_Uniclust50_profiles_for_old_metaeuk.tar.gz

tar -xzvf MERC_MMETSP_Uniclust50_profiles_for_old_metaeuk.tar.gz

mmseqs createdb assembled_Tara_5kb_EukRep_contigs.fas.gz contigsFasta/contigsDB

metaeuk easy-predict contigsFasta/contigsDB MMETSP_uniclust50_MERC predsResults tempFolder

perl mask--CDS-metaeukl.pl assembled_Tara_5kb_EukRep_contigs.fas predsResults.codon.fas metagenome-metaeuk_masked.fa

prodigal -i metagenome-metaeuk_masked.fa -o prodigal.genes -a prodigal.proteins.faa

MetaGeneMark_linux_64/mgm/gmhmmp -a -d -f 3 -m MetaGeneMark_linux_64/mgm/MetaGeneMark_v1.mod metagenome-metaeuk_masked.fa -A MetaGeneMark_mix_protein.fasta -D MetaGeneMark_mix_nucleotide.fasta

eggNOG-mapper was used to annotate the predicted protein.

Citation: 
Parsing Prokaryotic and Eukaryotic Microbial Genes Simultaneously from Metagenome by a Novel Analysis Workflow
