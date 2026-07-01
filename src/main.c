#include <stdio.h>
#include "../include/config.h"
#include "../include/ispis.h"

extern int broj;

// sk-90ff18ee21104a19b370ff6516d4de9e

int main(){

    #ifdef SRPSKI
    printf("Zdravo svete!\n");
    #endif

    #ifdef ENGLESKI
    printf("Hello world!\n");
    #endif

    ispisi();
    printf("velicina bafera: %d\n",BUFF_SIZE);
    return 0;
}
