#include <stdio.h>
#include <string.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include "utils.h"

int main(int argc, char *argv[]) {
    if(argc < 3) {
        perror("Missing parameters: ./writer foo bar\n");
        return 1;
    }

    int shmid = 0;
    char* s_key = argv[1];
    key_t key = fkey(s_key);
    char* value;
    char *shared_data;

    /*  create the segment: */
    if ((shmid = shmget(key, SHM_SIZE, 0644 | IPC_CREAT)) == -1) {
        perror("Error with shmget\n");
        return 1;
    }

    /* attach to the segment to get a pointer to it: */
    if ((shared_data = shmat(shmid, NULL, 0)) == (char *)-1) {
        perror("Error with shmat\n");
        return 1;
    }

    value = argv[2];
    strncpy(shared_data, value, SHM_SIZE);

    /* detach from shared memory */
    shmdt(shared_data);

    return 0;
}
