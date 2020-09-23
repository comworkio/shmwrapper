#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include "utils.h"

key_t token_key (char* original) {
    int i = 0, d = 1, total = 0;
    for (i = 0 ; i < strlen (original) ; i++) {
        total += d * ((int) original[i]);
        d*=10;
    }

    return total;
}

void check_arguments (int argc, int min_expected) {
    if (argc < min_expected) {
        f_display_help (stderr);
        exit (1);
    }
}

void display_help () {
    f_display_help (stdout);
}

void f_display_help (FILE* std) {
    fprintf (std, std == stderr ? COLOR_BOLD_RED : COLOR_BOLD_GREEN);
    fprintf (std, "Usage: shmwrapper <option> [value]\n\n");
    fprintf (std, COLOR_BLUE);
    fprintf (std, "* -h : display help[value]\n");
    fprintf (std, "* -w <key> <value> : store <value> associated with <key> in the shared memory\n");
    fprintf (std, "* -r <key> : get the value associated with <key> in the shared memory\n");
    fprintf (std, "* -c <key> : remove the value associated with <key> in the shared memory\n");
    fprintf (std, COLOR_GREEN);
    fprintf (std, "\nExamples:\n");
    fprintf (std, "shmwrapper -w foo bar\n");
    fprintf (std, "shmwrapper -r foo\n");
    fprintf (std, "shmwrapper -c foo\n");
    fprintf (std, COLOR_RESET);
}

int create_segment (key_t key) {
    int shmid = 0;

    if ((shmid = shmget(key, SHM_SIZE, 0644 | IPC_CREAT)) == -1) {
        perror (COLOR_BOLD_RED);
        perror ("[create_segment] Error with shmget\n");
        perror (COLOR_RESET);
        exit (1);
    }

    return shmid;
}

char* attach_segment_to_pointer (int shmid) {
    char *shared_data;

    if ((shared_data = shmat(shmid, NULL, 0)) == (char *)-1) {
        perror (COLOR_BOLD_RED);
        perror ("[attach_segment_to_pointer] Error with shmat\n");
        perror (COLOR_RESET);
        exit(1);
    }

    return shared_data;
}

void clear_entry (int shmid) {
    shmctl (shmid, IPC_RMID, NULL);
}

void detach_shm (char* shared_data) {
    shmdt (shared_data);
}

void shm_read (char* s_key) {
    char* shared_data = attach_segment_to_pointer (create_segment (token_key (s_key)));
    printf ("%s\n", shared_data);
    detach_shm (shared_data);
}

void shm_clear (char* s_key) {
    clear_entry (create_segment (token_key (s_key)));
}

void shm_write (char* s_key, char* s_value) {
    char* shared_data = attach_segment_to_pointer (create_segment (token_key (s_key)));
    strncpy (shared_data, s_value, SHM_SIZE);
    detach_shm (shared_data);
}
