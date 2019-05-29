#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
        setuid(1001); // uid of webuser
        char start_session[256];
        // argv[1] contains the session ID
        snprintf(start_session, sizeof(start_session), "%s%s", "/bin/bash ./session.sh ", argv[1]);
        system(start_session);

        return 0;
}

