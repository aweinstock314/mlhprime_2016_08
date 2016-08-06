#include <arpa/inet.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>

int main() {
    int counter = 0;
    int fd = socket(AF_INET, SOCK_STREAM, 0), newfd;
    /*struct sockaddr_in {
       .sin_family = AF_INET,
       .sin_port = htons(9001),
       .sin_addr = struct in_addr { .s_addr = 0 }
    } sockaddr;*/
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(9001);
    addr.sin_addr.s_addr = 0;

    bind(fd, (struct sockaddr *)&addr, sizeof(addr));
    listen(fd, 5);

    while((newfd = accept(fd, 0, 0))) {
        dprintf(newfd, "Hello, visitor %d!\n", ++counter);
        close(newfd);
    }

    return 0;
}
