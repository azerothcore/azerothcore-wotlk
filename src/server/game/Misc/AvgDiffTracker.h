/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
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
