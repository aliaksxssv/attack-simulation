#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// This function will execute when the shared library is loaded
__attribute__((constructor))
void run_on_load() {
    printf("\n�~_~T� You are hacked! �~_~T�\n");
}