
write_Zhouetal_tree<-function(bootstraps) {
require("seqinr")
require("ape")
require("ips")
bootstraps->n
alnmnt<-read.alignment("~/Desktop/UG_research_COVID_module/alnmnts/Beta_alpha_coronavirus.aln", format="fasta")
alnmnt<-as.DNAbin(alnmnt)
raxml(alnmnt, m="GTRCAT", N=n, p=5, f="a", x=2, k=FALSE, exec="~/standard-RAxML/raxmlHPC-SSE3", backbone=NULL)

}
