#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

extern char **environ;


// function which spawns a process and waits for it to finish
int spawn_and_wait(char *argv[]) {
    // spawn process

    // error checking 

    // waitpid

    return 0;
}


int main(int argc, char* argv[]) {

    char *args[] = { };
    spawn_and_wait(args);
    return 0;
}