## Independent Undergrad Research COVID Module

# Clone this repository before activity 1

Go to your terminal application. Type the following commands.  
`cd` *no matter where you were, this will take you back to your home directory*  
`cd desktop` *we're moving to our desktop, which is where we're going to store all of the data*
`git clone https://github.com/KatieFish/UG_research_COVID_module` *this is going to clone this repository onto your desktop*
You should now see a folder called UG_research_COVID_module on your desktop

#Update the repo before activities 2 and 3. 
I'm going to keep adding to the repo here, so you'll need to update your folder with my changes. 
`cd` *no matter where you were, this will take you back to your home directory*
`cd desktop` *we're moving to our desktop, which is where we're going to store all of the data*
`git pull` *this command pulls all of the changes I made and updates your version*


##Instructions for Part 1 - Zhou et al.
You have already read the paper and worked through locating and downloading sequences from the NCBI database. 
You have also use ClustalX to align those sequences.I have the exact same alignment here in this folder. 
You can delete the "SARS_CoV2_seq_comparison" folder if you'd like. We'll work from here from now on. 
We're going to use this alignment to try and re-perform the analyzes in Fig. 1c and 1d.
As we're doing that, think about what exactly we learn from each of these and why they do not tell us exactly the same thing.

1) Open Rstudio. 
2) At the console, which is the window with the blue carrot, type: 
`install.packages("seqinr")`
*We now want to examine average nucleotide identity in segments along the 30kb genome (Fig.1c). The paper doesn't tell
us exactly how this is done or what program to use. I custom wrote a function for this specific analysis that uses a "sliding window"
to look across the alignment and find the average nucleotide identity (ANI) within each "window". In this function you decide the size 
of the window. 



