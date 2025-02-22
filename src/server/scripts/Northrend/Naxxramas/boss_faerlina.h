#ifndef BOSS_FAERLINA_H_
#define BOSS_FAERLINA_H_

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "naxxramas.h"

namespace Faerlina {

enum Yells
{
    SAY_GREET                           = 0,
    SAY_AGGRO                           = 1,
    SAY_SLAY                            = 2,
    SAY_DEATH                           = 3,
    EMOTE_WIDOWS_EMBRACE                = 4,
    EMOTE_FRENZY                        = 5,
    SAY_FRENZY                          = 6
};

enum Spells
{
    SPELL_POISON_BOLT_VOLLEY            = 28796,
    SPELL_RAIN_OF_FIRE                  = 28794,
    SPELL_FRENZY                        = 28798,
    SPELL_WIDOWS_EMBRACE                = 28732,
    SPELL_MINION_WIDOWS_EMBRACE         = 54097
};

enum Groups
{
    GROUP_FRENZY                        = 1
};

enum Misc
{
    NPC_NAXXRAMAS_WORSHIPPER            = 16506,
    NPC_NAXXRAMAS_FOLLOWER              = 16505
};

class boss_faerlina : public CreatureScript
{
public:
    boss_faerlina() : CreatureScript("boss_faerlina") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_faerlinaAI>(pCreature);
    }

    struct boss_faerlinaAI : public BossAI
    {
        boss_faerlinaAI(Creature* c) : BossAI(c, BOSS_FAERLINA), _introDone(false) { }

        void SummonHelpers()
        {
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3362.66f, -3620.97f, 261.08f, 4.57276f);
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3344.3f, -3618.31f, 261.08f, 4.69494f);
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3356.71f, -3620.05f, 261.08f, 4.57276f);
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3350.26f, -3619.11f, 261.08f, 4.67748f);
            if (Is25ManRaid())
            {
                me->SummonCreature(NPC_NAXXRAMAS_FOLLOWER, 3347.49f, -3617.59f, 261.0f, 4.49f);
                me->SummonCreature(NPC_NAXXRAMAS_FOLLOWER, 3359.64f, -3619.16f, 261.0f, 4.56f);
            }
        }

        void Reset() override
        {
            BossAI::Reset();
            summons.DespawnAll();
            SummonHelpers();
            if (GameObject* go = me->GetMap()->GetGameObject(instance->GetGuidData(DATA_FAERLINA_WEB)))
                go->SetGoState(GO_STATE_ACTIVE);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->CallForHelp(VISIBLE_RANGE);
            summons.DoZoneInCombat();
            Talk(SAY_AGGRO);

            ScheduleTimedEvent(7s, 15s, [&]{
                if (!me->HasAura(SPELL_WIDOWS_EMBRACE))
                    DoCastVictim(SPELL_POISON_BOLT_VOLLEY);
            }, 7s, 15s);

            ScheduleTimedEvent(8s, 18s, [&] {
                DoCastRandomTarget(SPELL_RAIN_OF_FIRE);
            }, 8s, 18s);

            scheduler.Schedule(60s, 80s, GROUP_FRENZY, [this](TaskContext context) {
                if (!me->HasAura(SPELL_WIDOWS_EMBRACE))
                {
                    Talk(SAY_FRENZY);
                    Talk(EMOTE_FRENZY);
                    DoCastSelf(SPELL_FRENZY, true);
                    context.Repeat(1min);
                }
                else
                    context.Repeat(30s);
            });

            if (GameObject* go = me->GetMap()->GetGameObject(instance->GetGuidData(DATA_FAERLINA_WEB)))
                go->SetGoState(GO_STATE_READY);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!_introDone && who->IsPlayer())
            {
                Talk(SAY_GREET);
                _introDone = true;
            }
            ScriptedAI::MoveInLineOfSight(who);
        }

        void KilledUnit(Unit* who) override
        {
            if (!who->IsPlayer())
                return;

            if (!urand(0, 3))
                Talk(SAY_SLAY);

            instance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
            if (GameObject* go = me->GetMap()->GetGameObject(instance->GetGuidData(DATA_FAERLINA_WEB)))
                go->SetGoState(GO_STATE_ACTIVE);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == RAID_MODE(SPELL_WIDOWS_EMBRACE, SPELL_MINION_WIDOWS_EMBRACE))
            {
                Talk(EMOTE_WIDOWS_EMBRACE);
                scheduler.RescheduleGroup(GROUP_FRENZY, 1min);
                me->RemoveAurasDueToSpell(SPELL_FRENZY);
                instance->SetData(DATA_FRENZY_REMOVED, 0);
                if (Is25ManRaid())
                    caster->KillSelf();
            }
        }

        private:
            bool _introDone;
    };
};

}

#endif