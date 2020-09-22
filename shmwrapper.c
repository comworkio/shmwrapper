#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utils.h"

int main(int argc, char *argv[]) {
    check_arguments (argc, 2);

    char* s_opt = argv[1];

    if (strcmp (s_opt, "-h") == 0) {
        display_help ();
        return 0;
    }

    check_arguments(argc, 3);
    char* s_key = argv[2];

    if (strcmp (s_opt, "-r") == 0) {
        shm_read (s_key);
    } else if (strcmp (s_opt, "-c") == 0) {
        shm_clear (s_key);
    } else if (strcmp (s_opt, "-w") == 0) {
        check_arguments(argc, 4);
        char* s_value = argv[3];
        shm_write (s_key, s_value);
    } else {
        f_display_help (stderr);
        return 1;
    }

    return 0;
}
