#ifndef MOD_BRANDING_CORE_COMMON_CLOCK_H
#define MOD_BRANDING_CORE_COMMON_CLOCK_H

#include <cstdint>

namespace Branding
{
    // Injected time source. Core never reads the wall clock directly (determinism, §8).
    // Production wraps server time; tests inject a FakeClock they advance by hand.
    class IClock
    {
    public:
        virtual ~IClock() = default;
        virtual uint64_t NowUnix() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_COMMON_CLOCK_H
