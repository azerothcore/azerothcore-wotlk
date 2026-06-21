#include "Containment.h"

namespace Branding
{
    double Containment(uint64_t contributed, uint64_t goal)
    {
        if (goal == 0 || contributed >= goal)
            return 1.0;

        return static_cast<double>(contributed) / static_cast<double>(goal);
    }
}
