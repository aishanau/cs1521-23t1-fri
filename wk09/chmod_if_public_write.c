
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

void chmod_if_need(char *pathname) {
    // check if we need to change the perms 

    struct stat info;
    if (stat(pathname, &info) == -1) {
        perror(pathname);
        exit(1);
    }

    mode_t permissions = info.st_mode;
    
    if ((permissions & S_IWOTH) != 0) {
        // publically writable perm set
        // we want to turn it off 
        mode_t new_perm = permissions & ~S_IWOTH;
        if (chmod(pathname, new_perm) == -1) {
            perror(pathname);
            exit(1);
        }
        printf("removing public write from %s\n", pathname);

    } else {
        // file is already not pub writable 
        printf("%s is not publically writable\n", pathname);
    }
}

int main(int argc, char *argv[]) {
    // loop through all command line arguments 
    // take away public writable perms 
    for (int i = 1; i < argc; i++) {
        chmod_if_need(argv[i]);
    }
    return 0;
}