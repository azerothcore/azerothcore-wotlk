#include "AzthPlgLoader.h"

/*
    this file is used for "mod" scripts
 */

#ifndef AZTH_PLG_LOADER
#define AZTH_PLG_LOADER

/* This is where mods' loading functions should be declared. */

void AzthAddPlg() {
    /* This is where mods should be added. */

    AddAzthScripts();

#ifdef AZTH_WITH_UNIT_TEST
    AddTestSystemScripts();
#endif
}

#endif


