#ifndef MOD_BRANDING_CORE_COMMON_RNG_H
#define MOD_BRANDING_CORE_COMMON_RNG_H

#include <cstdint>

namespace Branding
{
    // Injected randomness. Core never touches std::rand / <random> directly (determinism, §8).
    // Production wraps the project Random helpers; tests inject a seeded FakeRng.
    class IRng
    {
    public:
        virtual ~IRng() = default;

        // Uniform value in [0, bound). Returns 0 when bound == 0.
        virtual uint32_t Next(uint32_t bound) = 0;
    };
}

#endif // MOD_BRANDING_CORE_COMMON_RNG_H
