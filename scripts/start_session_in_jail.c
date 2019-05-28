#include <stdlib.h>
#include <unistd.h>

int main() {
	setuid(0); // Not actually needed, since SUID permission bit is set for change_root binary
	system("chroot /var/www/jail /session.sh");

	return 0;
}
