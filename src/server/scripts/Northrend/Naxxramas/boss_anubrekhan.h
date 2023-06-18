#ifndef BOSS_ANUBREKHAN_H_
#define BOSS_ANUBREKHAN_H_

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

class boss_anubrekhan : public CreatureScript
{
public:
    boss_anubrekhan() : CreatureScript("boss_anubrekhan") { }

    CreatureAI* GetAI(Creature* pCreature) const override;

    struct boss_anubrekhanAI : public BossAI
    {
        explicit boss_anubrekhanAI(Creature* c);

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        bool sayGreet;

        void SummonCryptGuards();

        void Reset() override;

        void JustSummoned(Creature* cr) override;

        void SummonedCreatureDies(Creature* cr, Unit*) override;

        void SummonedCreatureDespawn(Creature* cr) override;

        void JustDied(Unit*  killer) override;

        void KilledUnit(Unit* victim) override;

        void JustEngagedWith(Unit* who) override;

        void MoveInLineOfSight(Unit* who) override;

        void UpdateAI(uint32 diff) override;
    };
};

#endif