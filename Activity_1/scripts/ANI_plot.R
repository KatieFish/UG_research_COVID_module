

#for recreation of Zhou et al. fig 1c 
#KJF least modified 03-24-20
#window size must be divisible by 2!!!
ANI_plot<-function(window_size){

z<-window_size/2
require("seqinr")
alnmnt<-read.alignment("~/Desktop/UG_research_COVID_module/alnmnts/nt_identity_seq.aln", format="clustal")

##conversion of alnmnt into matrix
alnmnt_matrix<-matrix(nrow=length(alnmnt[[2]]), ncol=30489)
row.names(alnmnt_matrix)<-unlist(alnmnt[[2]])
for (i in 1:length(alnmnt[[2]])){
alnmnt_matrix[i,]<-unlist(strsplit(alnmnt$seq[[i]], split=""))
}
row.names(alnmnt_matrix)[which(row.names(alnmnt_matrix)=="MN996528.1")]<-"WIV04"
row.names(alnmnt_matrix)[which(row.names(alnmnt_matrix)=="MN996532.1")]<-"Bat_CoV_RaTG13"
row.names(alnmnt_matrix)[which(row.names(alnmnt_matrix)=="MG772933.1")]<-"Bat_CoV_ZC45"
row.names(alnmnt_matrix)[which(row.names(alnmnt_matrix)=="KF367457.1")]<-"Bat_SARS-CoV_WIV1"
row.names(alnmnt_matrix)[which(row.names(alnmnt_matrix)=="AY278488.2")]<-"SARS_BJ01"

####create ANI matrix to plot
ANI_matrix<-alnmnt_matrix
ANI_matrix[, 1:ncol(ANI_matrix)]<-NA
reference<-as.vector(alnmnt_matrix[which(row.names(alnmnt_matrix)=="WIV04"), ])
for (i in 1:nrow(alnmnt_matrix)){
  comparison<-as.vector(alnmnt_matrix[i,])
  #sliding bp window provided by user input
  for (j in z:(length(comparison)-z)){
    matches<- length(which(reference[(j-z):(j+z)] == comparison[(j-z):(j+z)]))
   ANI_matrix[i,j]<-matches/window_size
  }
}
ANI_matrix[,1:z]<-ANI_matrix[,z]
ANI_matrix[, (ncol(ANI_matrix)-z):ncol(ANI_matrix)]<-ANI_matrix[, (ncol(ANI_matrix)-z)]
x<-c(1:ncol(ANI_matrix))

pdf(file=sprintf("~/Desktop/UG_research_COVID_module/nt_identity_plot_%d.pdf", window_size), height=6, width = 6)
plot(x, ANI_matrix[2, ], main=sprintf("recreation of Zhou et al. 2020 fig. 1c\n %d kb sliding window", window_size), ylab="% nucleotide identity", xlab="position", type="l", ylim=c(.3, 1), lty=3)
par(new=T)
plot(x, ANI_matrix[1, ], ylab=NA, xlab=NA, type="l", col="red", xaxt='n', yaxt='n', ylim=c(.3, 1))
par(new=T)
plot(x, ANI_matrix[3, ], ylab=NA, xlab=NA, type="l", col="blue", xaxt='n', yaxt='n', ylim=c(.3, 1))
par(new=T)
plot(x, ANI_matrix[4, ], ylab=NA, xlab=NA, type="l", col="green", xaxt='n', yaxt='n', ylim=c(.3, 1))
par(new=T)
plot(x, ANI_matrix[5, ], ylab=NA, xlab=NA, type="l", col="orange", xaxt='n', yaxt='n', ylim=c(.3, 1))
legend("bottomleft", legend=row.names(ANI_matrix), col=c("black", "red", "blue", "green", "orange"),lty=1)
dev.off()

}