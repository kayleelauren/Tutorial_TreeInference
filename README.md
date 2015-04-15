#ECES690 Tutorial 2: Tree Inference - RAxML and FastTree
___

NOTE: Background and supporting literature available in [LitReview](https://github.com/JacobRPrice/Tutorial_TreeInference/tree/master/LitReview) directory.

**Cloning this directory:**

    git clone https://github.com/JacobRPrice/Tutorial_TreeInference.git
___


___
##RAxML: Randomized Axelerated Maximum Likelyhood

RAxML Homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html
RAxML Install: **Already done on Proteus** 
RAxML GitHub: https://github.com/stamatak/standard-RAxML

###RAxML Algorithm

###Building Phylogenetic Trees with RAxML

___
##FastTree

FastTree Homepage: http://www.microbesonline.org/fasttree/
FastTree Install: http://www.microbesonline.org/fasttree/#Install

###FastTree Algorithm


###Building Phylogenetic Trees with FastTree
**Install on Proteus**
    # Navigate inside the cloned repo
    cd <path>/Tutorial_TreeInference/
    # Should see the install file (FastTree.c)
    ls -lap
    # install single-thread version of FastTree by running the following
    gcc -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm
    # if using a Mac and you have problems use the following command instead (remove #)
    #gcc -DNO_SSE -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm
    # install multi-thread version to use multiple cores
    gcc -DOPENMP -fopenmp -O3 -finline-functions -funroll-loops -Wall -o FastTreeMP FastTree.c -lm







___
##Viewing Phylogenetic Trees

**Seaview** (http://doua.prabi.fr/software/seaview)

![SeaView](http://doua.prabi.fr/binaries/seaview-tree)

**Interactive Tree of Life** (http://itol.embl.de/)

![iTOL](http://itol.embl.de/img/head_fra.jpg)

![iTOLexample](http://itol.embl.de/img/itol.jpg)


iTOL Help Pages: http://itol.embl.de/help/help.shtml

Supported tree formats: 
* Newick 
* Nexus 
* PhyloXML




___
##Comparison of RAxML and FastTree

