#include <string.h>
#include <sys/types.h>

key_t fkey(char* original) {
    int i = 0, d = 1, total = 0;
    for (i = 0 ; i < strlen(original) ; i++) {
        total += d+((int) original[i]);
        d*=10;
    }

    return total;
}