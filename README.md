# Independent Undergrad Research COVID Module

## Update the Repository before Activity 2


## Update the repo before activities 2 and 3. 
I'm going to keep adding to the repo here, so you'll need to update your folder with my changes.  
`cd` *no matter where you were, this will take you back to your home directory*  
`cd Desktop/UG_research_COVID_module` *we're moving to our desktop, which is where we're going to store all of the data*  
`git pull` *this command pulls all of the changes I made and updates your version* 


## Installation of software for Activity 2  

### Blast + command line tools  
- Go to ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/  
- Click on the top release (2.10.0)  
- Click on ncbi-blast-2.10.0+.dmg (2nd link from the bottom)  
- Double click on the downloaded .dmg file  
- Double click on the .pkg file in the window that pops up.  
- If you get this message "“ncbi-blast-2.10.0+.pkg” can’t be opened because it is from an unidentified developer."  
		- Click OK.  
		- Go to System Preferences -> Security & Privacy -> Near the bottom right click Open Anyway  
- Follow the instructions to finish installing.  
- To check to make sure it installed, go to your Terminal.  
`cd /usr/local`  
`ls` *There should be a directory in there called ncbi. Success!*  

## Instructions for part 2 - Zhang et al.  
*A note - this paper reports a draft genome for pangolin coronavirus. The paper does NOT deposit this genome in NCBI or any other location. In order to perform these analyses, I had to dig up a partial Pangolin_Cov genome from a different, earlier pre-print paper that does not appear to have been published yet. All other sequences used here are the identical sequences used by these authors.*

1. For background, watch this lecture put together by Dr. Britt Glaunsinger, an HHMI Investigator at UC Berkeley:  
https://www.youtube.com/watch?v=8_bOhZd6ieM  
2. Read Zhang et al. 2020 (in the pubs folder)
3. Start by generating an ANI plot, just like you did for Zhu et al. Open Rstudio, and load the script found in UG_research_COVID_module/Activity_2/scripts/ANI_plot_2. Call the function  
`>ANI_plot_2(1000)`  
*What does the 1000 mean? Does this look like figure 1b in Zhang et al.?*  
4. For hints at why we don't reproduce the exact figure in the paper, lets take a look at the actual sequence. On your terminal:  
`cd ~/Desktop/UG_research_COVID_module/Activity_2/fasta_files/`  
How many sequences are in this file? We know that each unique sequence in a fasta file starts with a ">". Let's use a pattern matching tool called "grep" to find out how many there are.  
`grep ">" model_Beta_coronavirus.fasta` *How many sequences are present?*  
Let's find out how many lines are in this file.  
`wc -l model_Beta_coronavirus.fasta` *wc stands for word count and the -l flag tells the computer to count the lines*  
*let's find out which on which line of this file the pangolin sequence starts, so we don't have to look through the whole huge file by eye*  
`grep -n "Pangolin_CoV" model_Beta_coronavirus.fasta` *the "-n" flag tells the computer to spit out the line number of the match.*  
Subtract the line that the Pangolin sequence begins at from the total lines. Use that number below.  
`tail -n #YOUCALCULATED model_Beta_coronavirus.fasta` *this should spit out just the Pangolin sequence. What do you notice when scrolling through this sequence?*  
5. Build a phylogenetic tree from full genome sequences.  
	- Go to https://raxml-ng.vital-it.ch/
	- Click on choose file for sequence alignment and upload the /UG_research_COVID_module/Activity_2/Beta_alpha_coronavirus_alnmnt.fasta file.  
	- Leave constraint tree blank.  
	- Leave the presets as they are. (Unpartitioned model, DNA, GTR, ML estimate, GAMMA, 4, mean, None etc)  
	- Enter your email at the bottom and hit submit.  
	- You should get an email when your tree is finished. Do the relationships in the tree corroborate the paper? Do we also find Pangolin_CoV to be in a clade with RAT13 and SARS-CoV2?  
	
6. Download the protein-coding sequence for the spike protein of SARS-CoV2.  
	- use your ncbi skills from last activity to find the entry for accession number MN908947  
	- scroll through the page for this entry. Notice where says "Features" on the left hand side.  
	- Features like genes and regulatory regions can be annotated here. Find the Spike protein gene annotated as gene "S".  
	- Click on CDS. This will highlight a bunch of sequence in brown. On the bottom right hand of your screen will be a link to Display: FASTA. Click FASTA.  
	- A new page will open with the FASTA sequence for just the S protein. Click on Send to: Complete Record, File, click Create File.  
	- Find the .fasta file from where it downloaded, rename it as SARS_CoV2_S.fasta and move it to Desktop/UG_research_Covid_module/Activity_2/fasta_files. 
7. Use BLAST command line tools to build a blast database from our model_Beta_coronavirus.fasta file  
	`cd ~/Desktop/UG_research_COVID_module/Activity_2/fasta_files/`  

	`/usr/local/ncbi/blast/bin/makeblastdb -in model_Beta_coronavirus.fasta -dbtype nucl -parse_seqids -out modelBetaCovdb.fn ` *We 	just made our sequences into a database that we'll BLAST against - it's just like running BLAST on the web-version, but we're 		customizing the sequences we're searching here*  

	`/usr/local/ncbi/blast/bin/blastn -query SARS_CoV2.fasta -db ./modelBetaCovdb.fn -out CoV_S_protein_blast_results.txt -max_hsps 1` 		*We blasted the S gene sequence we downloaded against the database we created*  

	`open CoV_S_protein_blast_results.txt` *look at the results. Did we pull out sequence for each virus? Now we'll run it 			again to clean it up so we can align the sequences*  

	`/usr/local/ncbi/blast/bin/blastn -query SARS_CoV2.fasta -db ./modelBetaCovdb.fn -outfmt '6 sseqid sseq' -out CoV_S_genes.txt -max_hsps 1 `  
	Run these few lines of code to clean our result up.  
	`tr "\t" "\n" < CoV_S_genes.txt > COV_S.fsa`  

	`sed -i '' 's/-//g' COV_S.fasta`  

	One quick manual pain in the butt - open the file and put a ">" carrot in front of each sequence name to make it fasta format.
	`open COV_S.fasta`  
	
8. Open MEGA. Use what we learned last semester to load the COV_S.fasta file (File -> Edit/build alignment -> Retrieve sequences from file)  
9. In MEGA, align the sequences with MUSCLE - align DNA, not codons.  
10. Trim the alignment by selecting and deleting the beginning and end sequence that does not contain a base for all sequences.  
11. Again, using what we learned last semester, produce a ML tree using a General Time Reversible model with a GAMMA distribution.  
12. Does the tree you produce look like the one in Fig. 3? Why or why not? What's the difference between the sequence data they show and ours?  
13. Our BLAST result returned only portions of some of the S proteins. I manually curated the full-length S protein coding sequences for each of these viruses. Load this file into MEGA (Activity_2/fasta_files/SARS_CoV2_S_protein_full_length_cds.fasta).  
14. Now, in the alignment window, click the Translated Protein Sequence tab.  
15. Align the protein sequences with MUSLCE.  
16. Find the 5 "key" residues in ACE2 binding. You can search for positions in the bottom left corner by entering the position number. *Note - in our alignment they correspond to 455, 486, 493, 501, and 505 w/out gaps!!*  
17. Do we observe the same substitutions they report?  
18. Find the S1/S2 cleavage site reported in figure 4. Do we see the same insertion in SARS-CoV2 that they do?  
19. How many analyses in this study were we able to reproduce and confirm? Which were we not able to? 









