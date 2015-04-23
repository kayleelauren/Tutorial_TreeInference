#!/bin/bash
    date +'%s %a %b %e %R:%S %Z %Y' > /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-560BD7DD83E64005A22D9744BF9A32BC/term.txt
    echo "ExitCode=${10}" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-560BD7DD83E64005A22D9744BF9A32BC/term.txt
    echo -e "Job Id: $1\nResource List: $6\nResources Used: $7\nQueue Name: $8\n" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-560BD7DD83E64005A22D9744BF9A32BC/term.txt