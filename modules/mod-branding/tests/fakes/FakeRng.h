#ifndef MOD_BRANDING_TESTS_FAKES_FAKERNG_H
#define MOD_BRANDING_TESTS_FAKES_FAKERNG_H

#include "branding/common/Rng.h"

namespace Branding::Test
{
    // Deterministic LCG so tests are reproducible for a given seed.
    class FakeRng : public IRng
    {
    public:
        explicit FakeRng(uint32_t seed = 12345) : _state(seed) { }

        uint32_t Next(uint32_t bound) override
        {
            _state = _state * 1664525u + 1013904223u;
            return bound == 0 ? 0 : _state % bound;
        }

    private:
        uint32_t _state;
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKERNG_H
