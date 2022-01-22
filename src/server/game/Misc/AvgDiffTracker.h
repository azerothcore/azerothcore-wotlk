/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __AVGDIFFTRACKER_H
#define __AVGDIFFTRACKER_H

#include "Common.h"
#include <cstring>

#define AVG_DIFF_COUNT 500

class AvgDiffTracker
{
public:
    AvgDiffTracker() : total(0), index(0), average(0) { memset(&tab, 0, sizeof(tab)); max[0] = 0; max[1] = 0; }

    uint32 getAverage()
    {
        return average;
    }

    uint32 getTimeWeightedAverage()
    {
        if (tab[AVG_DIFF_COUNT - 1] == 0)
            return 0;

        uint32 sum = 0, weightsum = 0;
        for (uint32 i = 0; i < AVG_DIFF_COUNT; ++i)
        {
            sum += tab[i] * tab[i];
            weightsum += tab[i];
        }
        return sum / weightsum;
    }

    uint32 getMax()
    {
        return max[0] > max[1] ? max[0] : max[1];
    }

    void Update(uint32 diff)
    {
        if (diff < 1)
            diff = 1;
        total -= tab[index];
        total += diff;
        tab[index] = diff;
        if (diff > max[0])
            max[0] = diff;
        if (++index >= AVG_DIFF_COUNT)
        {
            index = 0;
            max[1] = max[0];
            max[0] = 0;
        }

        if (tab[AVG_DIFF_COUNT - 1])
            average = total / AVG_DIFF_COUNT;
        else if (index)
            average = total / index;
        else
            average = 0;
    }

private:
    uint32 tab[AVG_DIFF_COUNT];
    uint32 total;
    uint32 index;
    uint32 max[2];
    uint32 average;
};

extern AvgDiffTracker avgDiffTracker;
extern AvgDiffTracker lfgDiffTracker;
extern AvgDiffTracker devDiffTracker;

#endif
