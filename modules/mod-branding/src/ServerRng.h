#ifndef MOD_BRANDING_SRC_SERVERRNG_H
#define MOD_BRANDING_SRC_SERVERRNG_H

#include "branding/common/Rng.h"
#include "Random.h"

namespace Branding
{
    // Production IRng: wraps the project's urand helper. Core never touches std::rand / <random>.
    class ServerRng : public IRng
    {
    public:
        uint32_t Next(uint32_t bound) override
        {
            return bound == 0 ? 0 : urand(0, bound - 1);
        }
    };
}

#endif // MOD_BRANDING_SRC_SERVERRNG_H
