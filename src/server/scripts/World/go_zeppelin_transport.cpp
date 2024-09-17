#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "zeppelin.h"

// 175080 The Iron Eagle (ORG - STV)
struct go_zeppelin_transport : GameObjectAI
{
    go_zeppelin_transport(GameObject *object) : GameObjectAI(object) { };

    void OnStateChanged(uint32 state, Unit* /*unit*/) override
    {
        // no hook exists for stopping, event for arriving in org is early
        // EventInform arrival is early for org, DBC hack required or hook
        if (state == GO_STATE_READY) // stop frame
            me->PlayRadiusSound(SOUND_ZEPPELIN_HORN, 45.0f);
    }

    void EventInform(uint32 eventId) override
    {
        ZeppelinEvent event = static_cast<ZeppelinEvent>(eventId);
        ZeppelinEntry zeppelinEntry = static_cast<ZeppelinEntry>(me->GetEntry());
        if (event && zeppelinEntry)
            sWorld->setWorldState(zeppelinEntry, event); // smartAI missing ACTION ?
        // Arrival
        {
            auto itr = EVENT_TO_MASTER_MAP.find(event);
            if (itr != EVENT_TO_MASTER_MAP.end())
            {
                ZeppelinMaster entry = itr->second;
                if (Creature* creature = me->FindNearestCreature(entry, 100.0f)) // range TC
                {
                    creature->AI()->Talk(0);
                }
            }
        }
        // Deperature
    }

// void UpdateAI(uint32 const diff) override
// {
//     _scheduler.Update(diff);
// }
// protected:
// TaskScheduler _scheduler;
};

void AddSC_zeppelin_scripts()
{
    RegisterGameObjectAI(go_zeppelin_transport);
}
