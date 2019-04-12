#pragma once
#include "../Value.h"

namespace BotAI
{
    class LastSpellCast 
    {
    public:
        LastSpellCast() : id(0),time(0) {}

    public:
        void Set(uint32 id, uint64 target, time_t time)
        {
            this->id = id;
            this->target = target;
            this->time = time;
        }
        
        void Reset()
        {
            id = 0;			
            target = 0;
            time = 0;
        }
    public:
        uint32 id;
        uint64 target;
        time_t time;
    };
   
    class LastSpellCastValue : public ManualSetValue<LastSpellCast&>
	{
	public:
        LastSpellCastValue(PlayerbotAI* ai) : ManualSetValue<LastSpellCast&>(ai, data) {}

    private:
        LastSpellCast data;
    };
}
