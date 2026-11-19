// companion.c - Mach-O dyld constructor companion
#include <stdio.h>

extern int horizon_mod_init(void);

__attribute__((constructor))
static void horizon_mod_entry_constructor(void) {
    printf("[HorizonDylib] Injected into Horizon Rust via dyld constructor\n");
    horizon_mod_init();
}
