#!/bin/bash
    date +'%s %a %b %e %R:%S %Z %Y' > /projects/ps-ngbt/backend/gordon_workspace/NGBW-JOB-MAFFT_TG-2EB7FCC9B38D45C984D5B7E3B42AE379/term.txt
    echo "ExitCode=${10}" >> /projects/ps-ngbt/backend/gordon_workspace/NGBW-JOB-MAFFT_TG-2EB7FCC9B38D45C984D5B7E3B42AE379/term.txt
    echo -e "Job Id: $1\nResource List: $6\nResources Used: $7\nQueue Name: $8\n" >> /projects/ps-ngbt/backend/gordon_workspace/NGBW-JOB-MAFFT_TG-2EB7FCC9B38D45C984D5B7E3B42AE379/term.txt