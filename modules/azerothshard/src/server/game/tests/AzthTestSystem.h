#ifndef AZTHTESTSYSTEM_H
#define	AZTHTESTSYSTEM_H

#ifdef AZTH_WITH_UNIT_TEST
    #include "AzthSystem.h"

    #ifdef AZTH_WITH_PLUGINS
        #include "AzthPlgTests.h"
    #endif

    #ifdef AZTH_WITH_CUSTOM_PLUGINS
        #include "AzthCustomPlgTests.h"
    #endif
#endif

#endif	/* AZTHTESTSYSTEM_H */
