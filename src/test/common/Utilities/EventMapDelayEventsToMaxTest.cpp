/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "EventMap.h"
#include "gtest/gtest.h"

// DelayEventsToMax() pushes events whose time falls inside the given window out to that
// window's end. It must move them, not re-create them: a re-created event loses the
// group and phase it was scheduled with.

TEST(EventMapDelayEventsToMaxTest, KeepsEventGroup)
{
    EventMap events;
    events.ScheduleEvent(1, Milliseconds(400), 1);   // inside the window
    events.ScheduleEvent(2, Milliseconds(12000), 1); // outside the window

    events.DelayEventsToMax(Milliseconds(1001), 0);

    ASSERT_EQ(events.GetTimeUntilEvent(1), Milliseconds(1001));

    // Cancelling the group must still cancel the delayed event.
    events.CancelEventGroup(1);

    EXPECT_FALSE(events.HasTimeUntilEvent(1));
    EXPECT_FALSE(events.HasTimeUntilEvent(2));
}

TEST(EventMapDelayEventsToMaxTest, KeepsEventPhase)
{
    EventMap events;
    events.SetPhase(1);
    events.ScheduleEvent(7, Milliseconds(400), 0, 2); // belongs to phase 2

    events.DelayEventsToMax(Milliseconds(1001), 0);
    events.Update(Milliseconds(2000));

    // The map is in phase 1, so a phase 2 event must not run.
    EXPECT_EQ(events.ExecuteEvent(), 0);
}

TEST(EventMapDelayEventsToMaxTest, LeavesEventsOutsideWindowAlone)
{
    EventMap events;
    events.ScheduleEvent(3, Milliseconds(5000), 1);

    events.DelayEventsToMax(Milliseconds(1001), 0);

    EXPECT_EQ(events.GetTimeUntilEvent(3), Milliseconds(5000));
}
