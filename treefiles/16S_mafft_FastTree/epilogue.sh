#!/bin/bash
    date +'%s %a %b %e %R:%S %Z %Y' > /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-ACF3FD1BEBE2451BBA41E8A89B20D402/term.txt
    echo "ExitCode=${10}" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-ACF3FD1BEBE2451BBA41E8A89B20D402/term.txt
    echo -e "Job Id: $1\nResource List: $6\nResources Used: $7\nQueue Name: $8\n" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-FASTTREE_XSEDE-ACF3FD1BEBE2451BBA41E8A89B20D402/term.txt