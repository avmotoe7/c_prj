#include <stdio.h>
#include "../lib/include/zbir.h"

extern int broj;

int ispisi(){
    printf("Zbir :%d\n",zbir(1,2));
    printf("Broj :%d\n",broj);
    return 0;
}
