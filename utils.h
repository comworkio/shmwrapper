#define SHM_SIZE 1024

#define COLOR_RESET "\033[0m"
#define COLOR_BOLD_RED "\033[1;31m"
#define COLOR_BOLD_GREEN "\033[1;32m"
#define COLOR_GREEN "\033[0;32m"
#define COLOR_BLUE "\033[0;34m"

void display_help ();

void f_display_help (FILE*);

void clear_entry (int);

void shm_read (char*);

void shm_clear (char*);

void shm_write (char*, char*);

void check_arguments(int, int);
