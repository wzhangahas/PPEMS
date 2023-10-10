use strict;

#Uasge:perl mask--CDS-metaeukl.pl metagenome.fa metaeuk.genes.codon.fas metagenome-metaeuk_masked.fa
my $metagenome="$ARGV[0]";
my $metaeuk_gene="$ARGV[1]";
my $masked_genome="$ARGV[2]";

my %hash;
$/=">";
open FASTA, "$ARGV[0]" or die;
 <FASTA>;
while(<FASTA>)
{
chomp;
my ($id,$seq)=(split /\n/,$_,2)[0,1];
my $new_id=(split /\s+/,$id)[0];
$seq=~s/\n//g;
$hash{$new_id}=$seq;

}
close FASTA;

$/="\n";
open IN, "$ARGV[1]" or die;
open OUT, ">$ARGV[2]" or die;
while(<IN>)
{
chomp;	
	if(/^>/)
	{
	
	my ($chr_id,$flag,$start,$end)=(split /\|/,$_)[1,2,6,7];
	$end=$end+1;	
	my $length=$end-$start;	
	my $NNN="N" x $length;
	my $tmp_seq=substr($hash{$chr_id},$start,$length);	
	$hash{$chr_id}=~s/$tmp_seq/$NNN/;	
	}
}


foreach my $key(keys %hash)
{
	$hash{$key}=~s/(\w{60})/$1\n/g;    #捕获60个字母，然后加回车换行符
	
	print OUT ">$key\n$hash{$key}\n";
}
close IN;
close OUT;


