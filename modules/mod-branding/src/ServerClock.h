#ifndef MOD_BRANDING_SRC_SERVERCLOCK_H
#define MOD_BRANDING_SRC_SERVERCLOCK_H

#include "branding/common/Clock.h"
#include "GameTime.h"

namespace Branding
{
    // Production IClock: wraps the server's game time. The pure core never reads time directly.
    class ServerClock : public IClock
    {
    public:
        uint64_t NowUnix() const override
        {
            return static_cast<uint64_t>(GameTime::GetGameTime().count());
        }
    };
}

#endif // MOD_BRANDING_SRC_SERVERCLOCK_H
