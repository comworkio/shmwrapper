#include <stdio.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <string.h>
#include "utils.h"

int main(int argc, char *argv[]) {
    if(argc < 1) {
        perror("Missing parameters: ./clear foo\n");
        return 1;
    }

    int shmid = 0;
    char* s_key = argv[1];
    key_t key = fkey(s_key);
    char *shared_data;

    /*  create the segment */
    if ((shmid = shmget(key, SHM_SIZE, 0644 | IPC_CREAT)) == -1) {
        perror("Error with shmget\n");
        return 1;
    }

    /* destroy the shared memory */
    shmctl(shmid, IPC_RMID, NULL);

    return 0;
}
