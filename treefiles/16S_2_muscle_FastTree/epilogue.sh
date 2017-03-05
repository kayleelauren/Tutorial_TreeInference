#!/bin/bash
    date +'%s %a %b %e %R:%S %Z %Y' > /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-0237B94ED7E44888AA898E598778AA7D/term.txt
    echo "ExitCode=${10}" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-0237B94ED7E44888AA898E598778AA7D/term.txt
    echo -e "Job Id: $1\nResource List: $6\nResources Used: $7\nQueue Name: $8\n" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-0237B94ED7E44888AA898E598778AA7D/term.txt