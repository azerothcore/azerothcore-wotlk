#ifndef BOT_INSTANCE_EVENTS_H_
#define BOT_INSTANCE_EVENTS_H_

#include "EventProcessor.h"
#include "Position.h"

/*
Name: bot_InstanceEvents
%Complete: ???
Comment: Custom event types for NPCBot system by Trickerer (onlysuffering@gmail.com)
Category: creature_cripts/custom/bots/events

Notes:
All events must be executed through botAI
*/
class InstanceScript;

//Base for instance event -based events
class NpcBotInstanceEventBase : public BasicEvent
{
public:
    InstanceScript* GetScript() const { return _instance; }
    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override { return true; }
    bool operator()() { return Execute(0, 0); }

protected:
    NpcBotInstanceEventBase(InstanceScript* instance) : _instance(instance) {}
    ~NpcBotInstanceEventBase() = default;
    NpcBotInstanceEventBase(NpcBotInstanceEventBase const&) = delete;

private:
    InstanceScript* _instance;
};
class FrozenThronePlatformDestructionEvent : public NpcBotInstanceEventBase
{
    friend class bot_ai;
    friend class instance_icecrown_citadel;
    friend class script_bot_commands;

public:
    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override;

protected:
    FrozenThronePlatformDestructionEvent(InstanceScript* instance, Position&& platformPos) : NpcBotInstanceEventBase(instance), _platform_pos(std::move(platformPos)) {}
    ~FrozenThronePlatformDestructionEvent() = default;
    FrozenThronePlatformDestructionEvent(FrozenThronePlatformDestructionEvent const&) = delete;

private:
    Position _platform_pos;
};

#endif
