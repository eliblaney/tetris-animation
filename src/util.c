#include <stdlib.h>
#include <unistd.h>

/*
 * ARM assembly is really bad at some OS-dependent
 * functions like clearing the terminal screen and
 * sleeping for a certain amount of time. So, this file
 * exists for those things that would be utter pain to
 * recreate in assembly.
 *
 */

/* Clears the screen with the handy-dandy POSIX clear command */
int clear(void) {
    system("clear");
    return 0;
}

/* Sleeps for 500 milliseconds with the handy-dandy sleep function */
int sleep_tick() {
    sleep(0.8);
    return 0;
}
