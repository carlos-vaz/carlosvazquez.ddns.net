#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

// The point of this program is to upgrade the user to root (temporarily) as only root can change
// the root directory of a shell session. One way to upgrade is to use the SUID (set user ID on execution)
// permission bit, but for some reason this only works on execution of binaries (not bash scripts), hence
// this binary. See https://www.hackingarticles.in/linux-privilege-escalation-using-suid-binaries/ for more
// details. 
// argv[1] contains the session ID
int main(int argc, char *argv[]) {
        // Not actually needed, since SUID permission bit is set for start_session_in_jail binary
        setuid(0);
        char chroot_command[256];
        snprintf(chroot_command, sizeof(chroot_command), "%s%s", "chroot /var/www/jail /launch_session.sh ", argv[1]);
        
        // After this call is executed (won't return), the new root directory will be /var/www/jail/ and launch_session.sh
        // will be running 
        system(chroot_command);

        return 0;
}

