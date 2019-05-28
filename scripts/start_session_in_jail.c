#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
        // Not actually needed, since SUID permission bit is set for start_session_in_jail binary
        setuid(0);
        char chroot_command[256];
        // argv[1] contains the session ID
        snprintf(chroot_command, sizeof(chroot_command), "%s%s", "chroot /var/www/jail /session.sh ", argv[1]);
        system(chroot_command);

        return 0;
}

