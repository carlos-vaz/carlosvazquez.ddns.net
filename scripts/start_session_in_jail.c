#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
	setuid(0); // Not actually needed, since SUID permission bit is set for change_root binary
	char chroot_command[256];
	snprintf(chroot_command, sizeof(chroot_command), "%s%s", "chroot /var/www/jail /session.sh ", argv[1]);
	system(chroot_command);

	return 0;
}
