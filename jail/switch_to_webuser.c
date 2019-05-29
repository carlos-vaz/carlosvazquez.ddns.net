#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

// Performs downgrading of privilege to user "webuser", and starts a bash session
// argv[1] contains the session ID  
int main(int argc, char *argv[]) {
        setuid(1001); // uid of webuser
        char start_session[256];
        snprintf(start_session, sizeof(start_session), "%s%s", "/bin/bash ./session.sh ", argv[1]);
        
        // Won't return
        system(start_session);

        return 0;
}

