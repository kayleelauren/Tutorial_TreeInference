#Tree Inference - RAxML and FastTree
___

NOTE: Background and supporting literature available in [LitReview](https://github.com/JacobRPrice/Tutorial_TreeInference/tree/master/LitReview) directory.

**Cloning this directory:**

    git clone https://github.com/JacobRPrice/Tutorial_TreeInference.git
___

#Building Phylogenetic Trees

WHY?

HOW IS IT DONE? 

___
#Tree Inference Packages
There are at least [392](http://evolution.genetics.washington.edu/phylip/software.html) tree building packages available to researchers. Two commonly utilized packages are RAxML and FastTree. 

##RAxML: Randomized Axelerated Maximum Likelyhood

RAxML Homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html  
RAxML GitHub: https://github.com/stamatak/standard-RAxML  
RAxML Install following directions on GitHub or the homepage. 

##FastTree

FastTree Homepage: http://www.microbesonline.org/fasttree/  
FastTree Install: http://www.microbesonline.org/fasttree/#Install

Navigate inside the cloned repo  

    cd <path>/Tutorial_TreeInference/  
    
Should see the install file (FastTree.c)  

    ls -lap  
    
install single-thread version of FastTree by running the following  

    gcc -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm  
    
if using a Mac and you have problems use the following command instead (remove #)  

    #gcc -DNO_SSE -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm  
    
install multi-thread version to use multiple cores  

    gcc -DOPENMP -fopenmp -O3 -finline-functions -funroll-loops -Wall -o FastTreeMP FastTree.c -lm   

**Unfortunately, installing and running these packages can be tricky, particularly on a cluster.**  
* Dependencies
* Adding executable locations to PATH  
* Capabilities in handing different input and output files
* etc...

![Good news everyone!](http://magellanverse.com/images/goodnewseveryone.png)

##QIIME  
QIIME has a [function](http://qiime.org/1.3.0/scripts/make_phylogeny.html) that makes it easy to streamline the tree building process.  It has options for both RAxML and FastTree methods.  

    make_phylogeny.py [options]  
    [REQUIRED]  
    -i, --input_fp  
    Path to read input fasta alignment, only first word in defline will be considered  
    [OPTIONAL]  
    -t, --tree_method  
    Method for tree building. Valid choices are: clearcut, clustalw, raxml, fasttree_v1, fasttree, muscle [default: fasttree]
    -o, --result_fp  
    Path to store result file [default: <input_sequences_filename>.tre]  
    -l, --log_fp  
    Path to store log file [default: No log file created.]  
    -r, --root_method  
    Method for choosing root of phylo tree Valid choices are: midpoint, tree_method_default [default: tree_method_default]  

##CIPRES
CIPRES is another option. It offers a [web-based interface](https://www.phylo.org/) that allows users to avoid command line/terminal prompts.  Like QIIME, users are able to carry out tree building using [RAxML or FastTree](https://www.phylo.org/portal2/tools.action), amongst other methods. 

___
# Tree Inference Algorithms

##RAxML Algorithm


##FastTree Algorithm

###Neighbor Joining with Profiles

Fast Tree uses the Neighbor-Joining with Profiles approach to tree inference. It implements this
Neighbor-Joining by storing "profiles" for the internal nodes of the tree rather than
storing a distance matrix.

####How Fast Tree Computes Distances Between Profiles

####Distances between Sequences
* Uses both corrected and uncorrected distances
* Corrects the distances for multiple substitutions during Nearest Neighbor Interchanges (NNI's), computing final branch lengths and local bootstrap, but not during Neighbor-Joining  
**Nucleotide Sequences**
* Uncorrected Distance d<sub>u</sub> = fraction of positions that differ
* Corrected Distance Jukes-Cantor distance: d = -3/4log(1-4/3d<sub>u</sub>)  
**Protein Sequences**
* Estimates by using BLOSUM45 amino acid similarity matrix
* Uncorrected distance d<sub>u</sub> = average dissimilarity among nongap positions
* Corrected distance d = -1.3 x log(1-d<sub>u</sub>)  
**Both Nucleotide and Protein Sequences**
* Truncates the corrected distances to a max of 3.0 substitutions per site, and for sequences that do not overlap because of gaps, Fast Tree uses this max distance
	
####Distances between Profiles
* Uses profiles to estimate the average distance between the children of two nodes
* Profile distance at each position is the average dissimilarity of the characters
	
####Distances between Internal Nodes
* Neighbor-Joining operates on distances between internal nodes rather
than on average distances between the members of subtrees
* For example, after joining nodes A and B, Neighbor-Joining sets  
  d<sub>u</sub>(AB,C) = d<sub>u</sub>(A,C) + d<sub>u</sub>(B,C) - d<sub>u</sub>(A,B)/2
* Fast Tree instead sets the profile of AB to P(AB) = (P(A) + P(B))/2  (where P is a vector)
and computes the distance between nodes with
  d<sub>u</sub>(i,j) = &#916;(i,j) - u(i) - u(j), where &#916; is the profile distance and u(i) is the "up distance" (average distance of the node from its children)
* This profile-based computation gives the exact same value of same value of d<sub>u</sub>(i,j) as long as distances are not  
corrected for multiple substitutions and the sequences contain no gaps  

####Calculating the Neighbor-Joining Criterion

####Selecting the Best Join

####A Rough Overview of Fast Tree
![Fast Tree Overview](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/FastTreeOverview.38%20PM.png)

___

#Comparison of RAxML and FastTree



___
#Building Phylogenetic Trees
We will be using CIPRES to build trees for the 4 alignments Saeed and Dmitry have created. We will be running this off of your local machine, not Proteus (obviously) so you can clone this repository to your desktop.

CIPRES --> https://www.phylo.org/  
* How to manage data: http://www.phylo.org/tools/flash/cipresportal2_data_management.htm  
* how to run jobs: http://www.phylo.org/tools/flash/cipresportal2_task_management.htm  
* HELP: http://www.phylo.org/index.php/help  

###1) Register  
(you can make use of the system as a guest but it's much easier to handle data with a username)  
* Use your drexel email, they may give you more [CPU time](http://www.phylo.org/index.php/help/cpu_help)  

###2) Upload your data  
(alignments are in the [/Tutorial_TreeInference/alignments/](https://github.com/JacobRPrice/Tutorial_TreeInference/tree/master/alignments) directory.  
* select "create new folder" in home screen.  
![1](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/cipres1.png)  
* name the folder and give it a description. 
![2](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/images/cipres2.png)  
* select "save" --> new folder will show up in left panel
* select "data" subdirectory. 
![3](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/cipres3.png)  
* select "upload data"  
![4](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/cipres4.png)  
* "choose files" navigate to and select your file to upload  -> upload all 4 alignments
![5](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/cipres5.png)  

###3) Create a Task.  
* Inside "Task" directory, select create new task.  
![createnewtask](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/createnewtask.png)  
* Give your task a description, select your input files, and select your tools. Then modify your task's parameters.  
![descriptionetc](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/descriptionetc2.png)  

####Building Phylogenetic Trees with RAxML (on CIPRES)   

**To prepare 16S_muscle_RAxML:**   
**Description:** 16S_muscle_raxml    
**Input:** 16S_muscle.fasta     
**Tool:** RAxML-HPC2 v.8 on XSEDE   
**Input Parameters:**   
For now, keep all of the defaults, with one exception...

>Warning: It is not a good idea to use the CAT approximation of rate heterogeneity on datasets
with less than 50 taxa. [From the manual]  

Click "Advanced Parameters" to reveal more options. Scroll to "Nucleic Acid Options" and select GTRGAMMA (generalized time-reversable+ optimization of substitution rates+ GAMMA model of rate heterogeneity). 

* Select "Save" to save the task to your task list.  

        If you're doing multiple runs of a similar type you can use the "Clone" button to clone a task and then modify it  
        
####Building Phylogenetic Trees with FastTree (on CIPRES)  

**To prepare 16s_muscle_FastTree:**  
**Description:** 16S_muscle_FastTree  
**Input:** 16S_muscle.fasta   
**Tool:** FastTreeMP on XSEDE  
**Input Parameters:**  

Data Type:  
> Nucleotide

-nni  
nearest-neighbor interchanges  
> (((A,B),C),D) => (((A,C),B),D)  
FastTree1  
log2(N)+1 = log2(20) = 6  
FastTree2  
2log2(N) = 2log2(20) = 10  

-spr  
subtree-pruning-regrafting  
> a subtree is removed from the tree and inserted elsewhere.   

-boot  
number of bootstraps for Shimodaira-Hasegawa test  
> set to default = 1000  

-topm   
Top-Hit list.   
> 20 sequences in alignment   
N=20  
m = log2(N) = Log2(20) = 5  

-close  
> set to default = 0.75  

-refresh  
> set to default = 0.8  

* Select “Save” to save the task.   

###4) Submit your tasks from your task screen.  
###5) Grab some coffee. You'll get an email when the run is done (or you can refresh the page).  
![downloadfiles](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/rundone.png)  
###6) Download output files.   
![downloadfiles](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/downloadfiles.png)  

___
#Viewing Phylogenetic Trees  

###Seaview  
Seaview Homepage: http://doua.prabi.fr/software/seaview  
Seaview Help Page: http://doua.prabi.fr/software/seaview_data/seaview  
Supported tree formats:  
* Newick  
* Nexus  
* Phylip  
* others?  
Pros:  
* Easy to use  
* Manual manipulation of alignments is simple  
Cons:  
* "Outdated" GUI might turn some off
* Trees are NOT "pretty"
* Limited alignment and tree building methods without using/installing packages from other sources

![seaviewprotein](https://modernmodelorganism.files.wordpress.com/2011/02/nogaps.png)
![SeaView](http://doua.prabi.fr/binaries/seaview-tree)

###Interactive Tree of Life  
iTOL Home Page: http://itol.embl.de/  
iTOL Help Pages: http://itol.embl.de/help/help.shtml  
Supported tree formats: 
* Newick  
* Nexus  
* PhyloXML    

![iTOL](http://itol.embl.de/img/head_fra.jpg)

![iTOLexample](http://itol.embl.de/img/itol.jpg)

We will be using iTOL to view our trees. 

####1) Register (I know, I know...)  
####2) Select the "Trees and Data" tab  
![1](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol1.png)  
####3) Create a new workspace  
![2](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol2.png)  
####4) Select "upload a new tree to this project"   
![3](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol3.png)  
####5) Choose a tree to upload.    
* Name the tree, otherwise it's difficult to distinguish which is which.   
* Adding a description can help with clarity as well.    
![4](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol4.png)  
####6) Add any datasets (metadata) you may have for the tree. **Not discussed here.**  
![5](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol5.png)  
####7) Manipulate tree in the viewer.   
####8) Export tree for use (.eps is default).   



###Comparing The Phylogenetic Trees

16
![s](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/16S_mafft_FastTree.eps)

___
