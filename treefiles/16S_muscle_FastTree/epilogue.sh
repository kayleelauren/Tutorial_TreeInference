#!/bin/bash
    date +'%s %a %b %e %R:%S %Z %Y' > /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-5FD87969F0B24E30AAE7F533D5B410AD/term.txt
    echo "ExitCode=${10}" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-5FD87969F0B24E30AAE7F533D5B410AD/term.txt
    echo -e "Job Id: $1\nResource List: $6\nResources Used: $7\nQueue Name: $8\n" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-5FD87969F0B24E30AAE7F533D5B410AD/term.txt