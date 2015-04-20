#!/bin/bash
    date +'%s %a %b %e %R:%S %Z %Y' > /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-9C38250A099F4F478C2C8E2549ED37B1/term.txt
    echo "ExitCode=${10}" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-9C38250A099F4F478C2C8E2549ED37B1/term.txt
    echo -e "Job Id: $1\nResource List: $6\nResources Used: $7\nQueue Name: $8\n" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-9C38250A099F4F478C2C8E2549ED37B1/term.txt