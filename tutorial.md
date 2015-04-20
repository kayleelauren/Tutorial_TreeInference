#Tree Inference - RAxML and FastTree
___

NOTE: Background and supporting literature available in [LitReview](https://github.com/JacobRPrice/Tutorial_TreeInference/tree/master/LitReview) directory.

**Cloning this directory:**

    git clone https://github.com/JacobRPrice/Tutorial_TreeInference.git
___

#Building Phylogenies

**Phylogenetic Inference**  
> In considering the Origin of Species, it is quite conceivable that a naturalist, reflecting on the mutual affinities of organic beings, on their embryological relations, their geographical distribution, geological succession, and other such facts, might come to the conclusion that species had not been independently created, but had descended, like varieties, from other species.  - **Charles Darwin, 1959, The Origin of Species**  

**”I think..."**  
![darwintree](http://static.guim.co.uk/sys-images/Guardian/Pix/pictures/2008/04/17/DarwinSketch.article.jpg)  


**We’ve come a long way.**
![dinophylogeny](https://leilabattison.files.wordpress.com/2012/02/dn14392-1_1891.jpg)   

A **phylogeny**, or evolutionary tree, represents the evolutionary relationships among a set of organisms or groups of organisms, called taxa (singular: taxon). The tips of the tree represent groups of descendent taxa (often species) and the nodes on the tree represent the common ancestors of those descendants. Two descendents that split from the same node are called sister groups. In the tree below, species A & B are sister groups — they are each other's closest relatives.  [[source](http://evolution.berkeley.edu/evolibrary/article/phylogenetics_02)]  
![phy](http://evolution.berkeley.edu/evolibrary/images/phylogenetics/clade.gif)  

####Constructing Phylogenetic Trees [General Concepts]  

#####1) Select taxa/organisms of interest. 
#####2) Determine characteristics/traits/loci as basis for phylogeny. 
 Early phylogenies were based on morphology. Now they are based on genetic/molecular data at one or more locus.  
#####3) Align sequences
#####4) Create Phylogeny  

######4a) Distance-Matrix Methods  
Attempts to quantify the “distance” or “difference” between two sequences, two paired/joined sequences and a third un-joined sequence, or two pairs/joins of sequences. Attempts to arrange pairing/joining to minimize differences.  

* Neighbor-joining  
* Fitch-Margoliash  
* Including outgroups —> serves as control

######4b) Maximum Parsimony  
Constructs phylogenetic tree that contains the smallest number of evolutionary events (mutations, etc).  
**Major Con:** Not statistically consistent. —> [Long Branch Attraction](http://en.wikipedia.org/wiki/Long_branch_attraction) (e.g. as a result of convergent evolution)

######4c) Maximum Likelihood  
Uses an explicit model of character evolution to determine a given trees likelihood. Algorithm cycles until it’s reached a maximum/convergent value, providing the best tree. 


######4d) Bayesian Inference
Seeks to maximize the posterior probability of the tree being generated using both previous trees and explicit evolution model.

___
#Tree Inference Packages
There are at least [392](http://evolution.genetics.washington.edu/phylip/software.html) tree building packages available to researchers. Two commonly utilized packages are RAxML and FastTree. 

####RAxML: Randomized Axelerated Maximum Likelyhood

RAxML Homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html  
RAxML GitHub: https://github.com/stamatak/standard-RAxML  
RAxML Install following directions on GitHub or the homepage. 

####FastTree

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

####QIIME  
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

####CIPRES
CIPRES is another option. It offers a [web-based interface](https://www.phylo.org/) that allows users to avoid command line/terminal prompts.  Like QIIME, users are able to carry out tree building using [RAxML or FastTree](https://www.phylo.org/portal2/tools.action), amongst other methods. 

___
# Tree Inference Algorithms

##RAxML Algorithm
By default, the current version of RAxML uses the Rapid Hill Climbing with Lazy Subtree Rearrangement approach to tree inference. 
This is not the original "full search" algorithm used by the program, but it outputs trees that are virtually as good as the ones
produces by the full search. It is substantially faster than the full search algorithm.

###Rapid Hill Climbing with Lazy Subtree Rearrangement

####LSR
* The fundamental mechanism that is used to search the tree space with RAxML is called Lazy Subtree Rearrangement (LSR)
* An LSR consists of pruning/removing a subtree from the current best tree "t" and then reinserting it into all neighboring   branches up to a certain distance/radius (rearrangement distance) of n nodes from the pruning point
* For each possible subtree insertion within the rearrangement distance, RAxML evaluates the log likelihood score of the   alternative topology
* The reason it is called "Lazy" Subtree Rearrangement is because this is done in a lazy way, since only the length of the   three branches adjacent to the insertion point/node will be optimized
* Thus, an LSR only yields an approximate log likelihood "all(t')" score for each alternative topology t' constructed by an  LSR from t
* However, this all(t') score can be used to sort the alternative topologies

####What Next?
* After this fast pre-scoring of a large number of alternative topologies, only a very small fraction of the best-scoring  topologies needs to be optimized more exhaustively to improve the overall tree score
* One iteration of the RAxML hill-climbing algorithm consists of performing LSR's on all subtrees of a given topology "t"  for a fixed rearrangement distance "n"
* Thereafter, the branches of the 20 best-scoring trees are thoroughly optimized
* This procedure of conducting LSR's on all subtrees and then optimizing the 20 best-scoring trees is performed until no  improved tree is encountered

####Main Idea
* The main idea of the new heuristics is to reduce the number of LSR's performed, which is done by using an empirical
cutoff-rule that stops the recursive descent of an LSR into deeper branches at a higher rearrangement distance from
the pruning position if they do not appear to be promising
* Thus, if the approximate log likelihood all(t') for the current rearrange tree t' is worse than the log likelihood  
ll(t) of the currently best tree t and if the difference &#948;(all(t')),ll(t)) is larger than a certain threshold  
lh<sub>cutoff</sub> the remaining LSR's below that node are omitted
* The threshold lh<sub>cutoff</sub> = &#8734; which means that no cutoffs are made alternative tree topologies t<sub>i</sub>   where all(t<sub>i</sub>) &#8804; ll(t) are stored.
* The threshold lh<sub>cutoff</sub> for the next iteration is set to the average of #948;. If the search computes an LSR for   which all(t') &#8804; ll(t) and &#948;(all(t'),ll(t)) &#8805; lh<sub>cutoff</sub> it will simply skip the remaining LSRs below  the current node. 
* Thus, each iteration k of the search algorithm uses a threshold value lh<sub>cutoff</sub> that has been obtained during the  previous iteration k - 1. 
* This allows to dynamically adapt lh<sub>cutoff</sub> to the specific dataset and to the progress of the search. 
* The omission of a large amount of unnecessary LSRs that have a high probability not to improve the tree yields substantial   run time improvements and returns equally good trees at the same time (see Table below).

![LSR Outline](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/LSROutline.png)

![!LSR Table](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/LSRTable.png)

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
* Profile distance is identical to the average distance if the distances are not corrected for multiple substitutions  
and if the sequences do not contain gaps
* For example, if we join two sequences A and B together, then the profile distance
&#916;(AB,C) = (d<sub>u</sub>(A,C)+d<sub>u</sub>(B,C))/2  
* But, we do want to correct for multiple substitutions (especially for large sequences which almost certainly contain gaps)
* FastTree uses the logarithm of averages between the profiles to make this correction	

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
* Neighbor-Joining selects the join that minimizes the criterion d<sub>u</sub>(i,j) - r(i) - (r,j), where i,j, and k  
are indices of active nodes that have not been joined, d<sub>u</sub>(i,j) is the distance between nodes i and j, n  
is the number of active nodes and  
r(i) = &#931; d<sub>u</sub>(i,k)/(n-2) (where k does not equal i)  
where r(i) can be thought of as the average "out-distance" of i to other active nodes  
* Traditional Neighbor-Joining computes all N out-distances before doing any joins, and updates each out-distance  after each join
* To reduce time complexity, FastTree avoids this work by computing each out-distance as needed by using  
a "total profile" T which is the average of all active nodes' profiles, as implied by  
&#931; &#916;(i,k) = n * &#916;(i,T) - &#916;(i,i)
(&#916;(i,i) is the average distance between children of i, including self-comparisons)
* FastTree computes the total profile at the beginning of Neighbor-Joining, updates it incrementally, and recomputes  
it every 200 joins to avoid roundoff error
* FastTree does not log the correct distances during Neighbor-Joining because this would reduce FastTree's accuracy

####Selecting the Best Join
* FastTree uses heuristics to reduce the number of joins considered at each step
* FastTree uses the "top-hits" heuristic where it records a top-hits list: the nodes that are the closest m neighbors  
of that node, according to the Neighbor-Joining criterion
* FastTree estimates these lists for all sequences before doing any joins
* FasTree restricts the top-hits heuristic to ensure that a sequence's top hits are only inferred from the top hits of  
a "close enough" neighbor
* Fast tree maintains these top-hits lists during Neighbor-Joining, and as the algorithm progresses, the top-hits  
list becomes gradually shorter as joined (inactive) nodes become absent
* FastTree also remembers the best-known join for each node, and updates the best join whenever it considers a join  that involves that node
* Based on the best joins and top-hits lists, FastTree can quickly select a join

####Nearest Neighbor Interchanges
* After FastTree constructs an initial tree with Neighbor-Joining, it uses NNI's to improve the tree topology
* During each round, FastTree tests and possibly rearranges each split in the tree, and it recomputes the profile of each   internal node
* FastTree has a fixed number of rounds of NNI's instead of using iteration to ensure fast completion
* FastTree also visits nodes in postorder to ensure efficiency

####Local Bootstrap
* To estimate the support for each split, FastTree resamples the alignment's columns with Knuth's 2002  
random number generator
* FastTree counts the fraction of resamples that support a split over the two potential NNI's around that node
* If a resample's minimum evolution criterion gives a tie, then that resample is counted as not supporting the split
 
####Branch Lengths
Finally, once the topology is complete, FastTree computes branch lengths, with  
d(AB,CD) = (d(A,C)+(d(A,D)+d(B,C)+d(B,C))/4 - (d(A,B)+d(C,D))/2  
for internal branches and  
d(A,BC) = (d(A,B)+d(A,C)-d(B,C))/2  
for the branch leading to leaf A, where d are log-corrected profile distances

####A Rough Overview of Fast Tree
![Fast Tree Overview](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/FastTreeOverview.38%20PM.png)

___

#Comparison of RAxML and FastTree
###RAxML

####Pros
Produces the best Maximum Likelihood scores in comparison to other popular ML methods
Computes ML scores faster than other ML methods that have comparable accuracy
Produces more accurate trees than FastTree for highly accurate alignments (e.g. MAFFT alignments)

####Cons
Computational requirements can be prohibitive for alignments with more than a few thousand sequences and sites

###FastTree
####Pros
Faster than most tree inference methods (including RAxML)
Produces relatively accurate trees quickly
Performs better (than RAxML) on less accurate alignments

####Cons
Less accurate with highly accurate alignments

###Evidence
In a study performed by the Department of Computer Science and Section of Integrative Biology at the University of Texas at Austin, RAxML, RAxML-Limited (time-constrained), and FastTree were compared on 1800 1000-taxon alignments. For each dataset, six alignments were produced: the true alignment, and using MAFFT, SATé, ClustalW, QuickTree, and PartTree, each in their default settings, to estimate alignments. For each of the 1800 resulting alignments, RAxML, FastTree, and RAxML-Limited were used to estimated ML trees. Each estimated tree was compared to the true tree, with zero-event edges contracted (potentially inferable model trees). Topological accuracy was measured using the missing branch rate, which is the proportion of branches present in the PIMT but missing in the estimated tree.

Liu et al (2011)  

In this study, we explore the performance with respect to ML score, running time, and topological accuracy, of FastTree and RAxML on thousands of alignments (based on both simulated and biological nucleotide datasets) with up to 27,634 sequences. 


*  We find that when RAxML and FastTree are constrained to the same running time, FastTree produces topologically much more accurate trees in almost all cases.  
* We also find that when RAxML is allowed to run to completion, it provides an advantage over FastTree in terms of the ML score, but does not produce substantially more accurate tree topologies. 
*  Interestingly, the relative accuracy of trees computed using FastTree and RAxML depends in part on the accuracy of the sequence alignment and dataset size, so that FastTree can be more accurate than RAxML on large datasets with relatively inaccurate alignments.  
* Finally, the running times of RAxML and FastTree are dramatically different, so that when run to completion, RAxML can take several orders of magnitude longer than FastTree to complete.  
*  Thus, our study shows that very large phylogenies can be estimated very quickly using FastTree, with little (and in some cases no) degradation in tree accuracy, as compared to RAxML.

![missingbranchrate](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/missingbranchrate.png)  

![runtimes](https://raw.githubusercontent.com/JacobRPrice/Tutorial_TreeInference/master/images/runtimes.png)  

###Take-Aways
* The relative accuracy of RAxML and FastTree depends on the accuracy of the alignment, with RAxML performing better on
more accurate alignments and FastTree giving better results on less accurate alignments. 
* The time complexity and computational requirements of RAxML make it extremely prohibitive.
* FastTree can produce relatively accurate results quickly, with less prohibitive computational requirements.



___
#Building Phylogenetic Trees
We will be using CIPRES to build trees for the 4 alignments Saeed and Dmitry have created. We will be running this off of your local machine, not Proteus (obviously) so you can [clone](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/tutorial.md#tree-inference---raxml-and-fasttree) this repository to your desktop.

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

####16s  

**16S_mafft_FastTree**
![16S_mafft_FastTree](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/16S_mafft_FastTree.png)  

**16S_muscle_FastTree**  
![16S_muscle_FastTree](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/16S_muscle_FastTree.png)  

**16S_mafft_raxml**  
![16S_mafft_raxml](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/16S_mafft_raxml.png)  

**16S_muscle_raxml**  
![16S_muscle_raxml](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/16S_muscle_raxml.png)  

**16S_mafft_raxml_wCAT**  
![16S_mafft_raxml_wCAT](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/16S_mafft_raxml_wCAT.png)  

**16S_muscle_raxml_wCAT**  
![16S_muscle_raxml_wCAT](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/16S_muscle_raxml_wCAT.png)  


####GlnS  

**GlnS_mafft_FastTree**  
![GlnS_mafft_FastTree](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/GlnS_mafft_FastTree.png)  

**GlnS_muscle_FastTree**  
![GlnS_muscle_FastTree](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/GlnS_muscle_FastTree.png)  

**GlnS_mafft_raxml**  
![GlnS_mafft_raxml](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/GlnS_mafft_raxml.png)  

**GnlS_muscle_raxml**  
![GnlS_muscle_raxml](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/GnlS_muscle_raxml.png)  

**GlnS_mafft_raxml_wCAT**  
![GlnS_mafft_raxml_wCAT](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/GlnS_mafft_raxml_wCAT.png)  

**GlnS_muscle_raxml_wCAT**  
![GlnS_muscle_raxml_wCAT](https://github.com/JacobRPrice/Tutorial_TreeInference/blob/master/treeimages/GlnS_muscle_raxml_wCAT.png)  

___
