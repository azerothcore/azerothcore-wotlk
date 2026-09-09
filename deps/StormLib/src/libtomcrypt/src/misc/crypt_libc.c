/*****************************************************************************/
/* crypt_libc.c                           Copyright (c) Ladislav Zezula 2010 */
/*---------------------------------------------------------------------------*/
/* Description:                                                              */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 05.05.10  1.00  Lad  The first version of crypt_libc.c                    */
/*****************************************************************************/

// LibTomCrypt header
#include <stdlib.h>
#include "../headers/tomcrypt.h"

LTC_EXPORT void * LTC_CALL LibTomMalloc(size_t n)
{
    return malloc(n);
}

LTC_EXPORT void * LTC_CALL LibTomCalloc(size_t n, size_t s)
{
    return calloc(n, s);
}

LTC_EXPORT void * LTC_CALL LibTomRealloc(void *p, size_t n)
{
    return realloc(p, n);
}

LTC_EXPORT void LTC_CALL LibTomFree(void * p)
{
    free(p);
}

LTC_EXPORT clock_t LTC_CALL LibTomClock(void)
{
    return clock();
}

LTC_EXPORT void LTC_CALL LibTomQsort(void *base, size_t nmemb, size_t size, int(LTC_CALL * compar)(const void *, const void *))
{
    qsort(base, nmemb, size, compar);
}
