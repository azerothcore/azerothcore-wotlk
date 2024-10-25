#ifndef BOT_EVENTS_H_
#define BOT_EVENTS_H_

#include "EventProcessor.h"

/*
Name: bot_Events
%Complete: ???
Comment: Custom event types for NPCBot system by Trickerer (onlysuffering@gmail.com)
Category: creature_cripts/custom/bots/events

Notes:
All events must be executed through botAI
*/

//Teleport home: near or far, only used for free bots
class TeleportHomeEvent : public BasicEvent
{
    friend class bot_ai;
protected:
    TeleportHomeEvent(bot_ai* ai, bool reset) : _ai(ai), _reset(reset) {}
    ~TeleportHomeEvent() {}

    TeleportHomeEvent(TeleportHomeEvent const&) = delete;

    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override
    {
        _ai->TeleportHome(_reset);
        return true;
    }

private:
    bot_ai* _ai;
    bool _reset;
};
//Delayed teleport finish: adds bot back to world on new location
class TeleportFinishEvent : public BasicEvent
{
    friend class bot_ai;
    friend class BotMgr;
protected:
    TeleportFinishEvent(bot_ai* ai, bool reset) : _ai(ai), _reset(reset) {}
    ~TeleportFinishEvent() {}

    TeleportFinishEvent(TeleportFinishEvent const&) = delete;

    //Execute is always called while creature is out of world so ai is never deleted
    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override
    {
        _ai->FinishTeleport(_reset);
        return true;
    }

private:
    bot_ai* _ai;
    bool _reset;
};
//Await state removal
class AwaitStateRemovalEvent : public BasicEvent
{
    friend class bot_ai;
protected:
    AwaitStateRemovalEvent(bot_ai* ai, uint8 state) : _ai(ai), _state(state) {}
    ~AwaitStateRemovalEvent() = default;

    AwaitStateRemovalEvent(AwaitStateRemovalEvent const&) = delete;

    //Execute is always called while creature is out of world so ai is never deleted
    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override
    {
        _ai->EventRemoveBotAwaitState(_state);
        return true;
    }

private:
    bot_ai* _ai;
    const uint8 _state;
};

#endif
