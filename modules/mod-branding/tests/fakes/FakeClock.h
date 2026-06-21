#ifndef MOD_BRANDING_TESTS_FAKES_FAKECLOCK_H
#define MOD_BRANDING_TESTS_FAKES_FAKECLOCK_H

#include "branding/common/Clock.h"

namespace Branding::Test
{
    // Deterministic clock the test advances by hand.
    class FakeClock : public IClock
    {
    public:
        explicit FakeClock(uint64_t now = 1000) : _now(now) { }
        uint64_t NowUnix() const override { return _now; }
        void SetNow(uint64_t now) { _now = now; }
        void Advance(uint64_t seconds) { _now += seconds; }

    private:
        uint64_t _now;
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKECLOCK_H
