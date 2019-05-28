#include <stdlib.h>
#include <unistd.h>

int main() {
	setuid(0);
	system("chroot /var/www/jail /bin/bash");

	return 0;
}
