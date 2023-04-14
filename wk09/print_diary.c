// print $HOME/.diary to stdout

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {

    char *home_path = getenv("HOME");
    char *diary_filename = ".diary";

    int diary_path_length = strlen(home_path) + strlen(diary_filename) + 1 + 1;

    char *diary_path = malloc(sizeof(char) * diary_path_length);

    // pointer to the string
    // number of character in string 
    // normal printf format
    snprintf(diary_path, diary_path_length, "%s/%s", home_path, diary_filename);

    printf("The diary pathname is %s\n", diary_path);

    FILE *diary_stream = fopen(diary_path, "r");

    // print out contents
    int c;
    while ((c = fgetc(diary_stream)) != EOF) {
        fputc(c, stdout);
    }

    fclose(diary_stream);
    free(diary_path);
    return 0;
}