# Independent Undergrad Research COVID Module

## Clone this repository before activity 1

Go to your terminal application. Type the following commands.  
`cd` *no matter where you were, this will take you back to your home directory*  
`cd desktop` *we're moving to our desktop, which is where we're going to store all of the data*  
`git clone https://github.com/KatieFish/UG_research_COVID_module` *this is going to clone this repository onto your desktop*  
You should now see a folder called UG_research_COVID_module on your desktop

## Update the repo before activities 2 and 3. 
I'm going to keep adding to the repo here, so you'll need to update your folder with my changes.  
`cd` *no matter where you were, this will take you back to your home directory*  
`cd desktop` *we're moving to our desktop, which is where we're going to store all of the data*  
`git pull` *this command pulls all of the changes I made and updates your version* 

## Download and install software. 
- Download and install RAxML.  
  Go to your terminal and type these commands.  
  `cd` *takes you to your home directory*
  `git clone https://github.com/stamatak/standard-RAxML.git` *clones the RAxML software from it's developers github*
  `cd standared-RAxML` *Navigate into the RAxML directory*
  `make -f Makefile.SSE3.mac` *Compile the RAxML code so that it is executable*


## Instructions for Part 1 - Zhou et al.
You have already read the paper and worked through locating and downloading sequences from the NCBI database.  
You have also use ClustalX to align those sequences.I have the exact same alignment here in this folder.  
You can delete the "SARS_CoV2_seq_comparison" folder if you'd like. We'll work from here from now on.  
We're going to use this alignment to try and re-perform the analyzes in Fig. 1c and 1d.  
As we're doing that, think about what exactly we learn from each of these and why they do not tell us exactly the same thing.  

1. Open Rstudio.  
2. At the console, which is the window with the blue carrot, type:  
`install.packages("seqinr")`  
*We now want to examine average nucleotide identity in segments along the 30kb genome (Fig.1c). The paper doesn't tell
us exactly how this is done or what program to use. I custom wrote a function for this specific analysis that uses a "sliding window"
to look across the alignment and find the average nucleotide identity (ANI) within each "window". In this function you decide the size 
of the window.*  
3. We'll set our working directory, which means the place where we'll pull files from and put them when we create them, to this repo:  
`setwd("~/Desktop/UG_research_COVID_module/")`  
4. Open the function we'll use. Go to the top left of Rstudio and click on the icon that looks like a folder with a green arrow coming out of it. In the UG_research_COVID_module folder there is a folder called scripts and inside that folder is a file called ANI_plot.R. Open that file. 
5. Source the script by clicking on the icon with a blue arrow that says Source. 
6. Call the function in the console:  
`ANI_plot(500)` *first we'll set our sliding window to 500bp*  
7. Give the function a few seconds to run and then go to your UG_research_COVID_module folder. There should now be a new plot in there. Open it up and look at it. Compare it to Zhou et al. Fig. 1c.  
8. Play around with the size of the sliding window. As long as the number is a multiple of 2, it can be used as a sliding window size. What happens at 1000bp? What about 2000bp? When does the graph most closely match Zhou et al.? Did we find anything different?  
9. Let's build a tree like the one seen in Fig. 1 c. I already did the dirty work of downloading and aligning all the sequences. RAxML is the software most researchers use to build phylogenetic trees. We will use R to execute RAxML.  
10. Source the RAxML script I wrote for you:  
`source("~/UG_research_COVID_module/scripts/write_Zhouetal_tree.R")` *Notice how this did the same thing as when we opened and sourced the ANI_plot script we used earlier. Everything you can do by clicking you can do by commands. The GUI is sort of training wheels*  
Go ahead and open the script as well by using the Green arrow icon again so that you can see the commands you're running.  
11. Exectute the function:  
`write_Zhouetal_tree(100)`  
*Note that the bootstraps (the amount of times the data is subsampled to see how well the final tree is supported) are set by you. This is something you can play with to see how it changes how well the ML tree is supported. Start with 100 and finish through step 16 before you begin playing with bootstraps*
There should now be a bunch of files that start with RAxML in your UG_research_COVID_module folder. The maximum liklihood tree is the one we want, and that is in the file `RAxML_bestTree.fromR-date`.  
12. View this file from the command line on Terminal:  
`cd ~/UG_research_COVID_module`  
`less RAxML_bestTree*` *the * works like a wildcard, so there should only be one file named RAxML_bestTree, and this command will view that file*  
13. The information inside looks like gibberish with sequence names and semicolons. This is a format called **newick**.  
14. Go to http://etetoolkit.org/treeview/.  
15. Upload or copy and paste your newick tree data into the appropriate box and click View Tree.  
16. How does our tree compare to Zhou et al. Fig. 1c? 




