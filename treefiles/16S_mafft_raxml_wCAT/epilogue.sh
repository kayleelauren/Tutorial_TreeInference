#!/bin/bash
    date +'%s %a %b %e %R:%S %Z %Y' > /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-DE44E54AC67142E58DC4886D71194657/term.txt
    echo "ExitCode=${10}" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-DE44E54AC67142E58DC4886D71194657/term.txt
    echo -e "Job Id: $1\nResource List: $6\nResources Used: $7\nQueue Name: $8\n" >> /projects/ps-ngbt/backend/trestles_workspace/NGBW-JOB-RAXMLHPC8_XSEDE-DE44E54AC67142E58DC4886D71194657/term.txt