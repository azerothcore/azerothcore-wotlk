#ifndef BOSS_HEIGAN_H_
#define BOSS_HEIGAN_H_

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"



class boss_heigan : public CreatureScript
{
public:
    boss_heigan() : CreatureScript("boss_heigan") { }

    CreatureAI* GetAI(Creature* pCreature) const override;

    struct boss_heiganAI : public BossAI
    {
        explicit boss_heiganAI(Creature* c);

        InstanceScript* pInstance;
        EventMap events;
        uint8 currentPhase{};
        uint8 currentSection{};
        bool moveRight{};

        void Reset() override;

        void KilledUnit(Unit* who) override;

        void JustDied(Unit*  killer) override;

        void JustEngagedWith(Unit* who) override;

        void StartFightPhase(uint8 phase);

        bool IsInRoom(Unit* who);

        void UpdateAI(uint32 diff) override;
    };
};

#endif