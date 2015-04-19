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
* Dependancies
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

___

#Comparison of RAxML and FastTree

Algorithms

RAxML (Random Axelerated Maximum Likelihood)

Default Algorithm: Rapid Hill Climbing

The RAxML tree search algorithm uses the Lazy Subtree Rearrangement (LSR).

FastTree

___
#Building Phylogenetic Trees
We will be using CIPRES to build trees for the 4 alignments Saeed and Dmitry have created. We will be running this off of your local machine, not Proteus (obviously) so you can clone this repository to your desktop.

CIPRES --> https://www.phylo.org/  
* How to manage data: http://www.phylo.org/tools/flash/cipresportal2_data_management.htm  
* how to run jobs: http://www.phylo.org/tools/flash/cipresportal2_task_management.htm  
* HELP: http://www.phylo.org/index.php/help  

1) Register (you can make use of the system as a guest but it's much easier to handle data with a username).  
* Use your drexel email, they may give you more [CPU time](http://www.phylo.org/index.php/help/cpu_help)  

2) Upload data (alignments are in the [/Tutorial_TreeInference/alignments/](https://github.com/JacobRPrice/Tutorial_TreeInference/tree/master/alignments) directory.  
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

3) Create a Task.   
4) Submit Task.   
5) Grab some coffee. You'll get an email when the run is done.   
6) Profit: Download output files.   

##Building Phylogenetic Trees with FastTree (on CIPRES)  

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

Select “Save” to save the task.   

**To prepare 16s_mafft_FastTree:**  

1) Select “clone” next to 16S_muscle_FastTree.    
2) Change the name to 16S_mafft_FastTree.  
3) Change data to 16S_mafft.  
4) Select “save”.  

**To prepare GlnS_muscle_FastTree:**  

1) Select “clone” next to 16S_muscle_FastTree.   
2) Change the name to GlnS_mafft_FastTree.  
3) Change data to GlnS_muscle.  
4) Update parameters  
* N = 7
* nni = 2log2(N) = 2log2(7) = 6  
* topm = log2(N) = log2(7) ~ 3   

5) Select “save”.  

**To prepare GlnS_mafft_FastTree:**  

1) Select “clone” next to 16S_mafft_FastTree.   
2) Change the name to GnlS_mafft_FastTree.  
3) Change data to GlnS_mafft.  
4) Update parameters  
* N = 7  
* nni = 2log2(N) = 2log2(7) = 6   
* topm = log2(N) = log2(7) ~ 3    

5) Select “save”.  

##Building Phylogenetic Trees with RAxML (on CIPRES)   






___
#Viewing Phylogenetic Trees  

##Seaview  
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

##Interactive Tree of Life  
iTOL Home Page: http://itol.embl.de/  
iTOL Help Pages: http://itol.embl.de/help/help.shtml  
Supported tree formats: 
* Newick  
* Nexus  
* PhyloXML    

![iTOL](http://itol.embl.de/img/head_fra.jpg)

![iTOLexample](http://itol.embl.de/img/itol.jpg)

We will be using iTOL to view our trees. 

1) Register (I know, I know...)  
2) Select the "Trees and Data" tab  
![1](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol1.png)  
3) Create a new workspace  
![2](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol2.png)  
4) Select "upload a new tree to this project"   
![3](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol3.png)  
5) Choose a tree to upload.    
* Name the tree, otherwise it's difficult to distinguish which is which.   
* Adding a description can help with clarity as well.    
![4](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol4.png)  
6) Add any datasets (metadata) you may have for the tree. **Not discussed here.**  
![5](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/itol5.png)  




##Comparing The Phylogenetic Trees



___
