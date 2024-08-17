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

#ifndef __EVENTPROCESSOR_H
#define __EVENTPROCESSOR_H

#include "Define.h"
#include "Duration.h"
#include "Random.h"
#include <map>

class EventProcessor;

// Note. All times are in milliseconds here.
class BasicEvent
{

    friend class EventProcessor;

    enum class AbortState : uint8
    {
        STATE_RUNNING,
        STATE_ABORT_SCHEDULED,
        STATE_ABORTED
        };

    public:
        BasicEvent()
             = default;

        virtual ~BasicEvent() = default; // override destructor to perform some actions on event removal

        // this method executes when the event is triggered
        // return false if event does not want to be deleted
        // e_time is execution time, p_time is update interval
        [[nodiscard]] virtual bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) { return true; }

        [[nodiscard]] virtual bool IsDeletable() const { return true; }   // this event can be safely deleted

        virtual void Abort(uint64 /*e_time*/) { }           // this method executes when the event is aborted

        // Aborts the event at the next update tick
        void ScheduleAbort();
        bool IsActive() const { return m_abortState == AbortState::STATE_RUNNING; }

    private:
        void SetAborted();
        [[nodiscard]] bool IsRunning() const { return (m_abortState == AbortState::STATE_RUNNING); }
        [[nodiscard]] bool IsAbortScheduled() const { return (m_abortState == AbortState::STATE_ABORT_SCHEDULED); }
        [[nodiscard]] bool IsAborted() const { return (m_abortState == AbortState::STATE_ABORTED); }

        AbortState m_abortState{AbortState::STATE_RUNNING};                            // set by externals when the event is aborted, aborted events don't execute

        // these can be used for time offset control
        uint64 m_addTime{0};                                   // time when the event was added to queue, filled by event handler
        uint64 m_execTime{0};                                  // planned time of next execution, filled by event handler
        uint8 m_eventGroup{0};
};

template<typename T>
class LambdaBasicEvent : public BasicEvent
{
    public:
        LambdaBasicEvent(T&& callback) : BasicEvent(), _callback(std::move(callback)) { }

        bool Execute(uint64, uint32) override
        {
            _callback();
            return true;
        }

    private:

        T _callback;
};

template<typename T>
using is_lambda_event = std::enable_if_t<!std::is_base_of_v<BasicEvent, std::remove_pointer_t<std::remove_cvref_t<T>>>>;

typedef std::multimap<uint64, BasicEvent*> EventList;

class EventProcessor
{
    public:
        EventProcessor()  = default;
        ~EventProcessor();

        void Update(uint32 p_time);
        void KillAllEvents(bool force);
        void AddEvent(BasicEvent* Event, uint64 e_time, bool set_addtime = true) { AddEvent(Event, e_time, set_addtime, 0); };
        void AddEvent(BasicEvent* Event, uint64 e_time, bool set_addtime, uint8 eventGroup);
        template<typename T>
        is_lambda_event<T> AddEvent(T&& event, Milliseconds e_time, bool set_addtime = true) { AddEvent(new LambdaBasicEvent<T>(std::move(event)), e_time, set_addtime); }
        void AddEventAtOffset(BasicEvent* event, Milliseconds offset) { AddEvent(event, CalculateTime(offset.count()), true, 0); }
        void AddEventAtOffset(BasicEvent* event, Milliseconds offset, Milliseconds offset2) { AddEvent(event, CalculateTime(randtime(offset, offset2).count()), true, false); }
        template<typename T>
        is_lambda_event<T> AddEventAtOffset(T&& event, Milliseconds offset, uint8 eventGroup) { AddEvent(new LambdaBasicEvent<T>(std::move(event)), CalculateTime(offset.count()), true, eventGroup); };
        template<typename T>
        is_lambda_event<T> AddEventAtOffset(T&& event, Milliseconds offset, Milliseconds offset2, uint8 eventGroup) { AddEvent(new LambdaBasicEvent<T>(std::move(event)), CalculateTime(randtime(offset, offset2).count()), true, eventGroup); };
        template<typename T>
        is_lambda_event<T> AddEventAtOffset(T&& event, Milliseconds offset) { AddEventAtOffset(new LambdaBasicEvent<T>(std::move(event)), offset); }
        template<typename T>
        is_lambda_event<T> AddEventAtOffset(T&& event, Milliseconds offset, Milliseconds offset2) { AddEventAtOffset(new LambdaBasicEvent<T>(std::move(event)), offset, offset2); }
        void ModifyEventTime(BasicEvent* event, Milliseconds newTime);
        [[nodiscard]] uint64 CalculateTime(uint64 t_offset) const;

        //calculates next queue tick time
        [[nodiscard]] uint64 CalculateQueueTime(uint64 delay) const;

        void CancelEventGroup(uint8 group);

    protected:
        uint64 m_time{0};
        EventList m_events;
        bool m_aborting;
};

#endif
