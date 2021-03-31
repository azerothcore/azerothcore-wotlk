/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ahnkahet.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"

enum Spells
{
    // BASIC FIGHT
    SPELL_MIND_FLAY                         = 57941,
    SPELL_MIND_FLAY_H                       = 59974,
    SPELL_SHADOW_BOLT_VOLLEY                = 57942,
    SPELL_SHADOW_BOLT_VOLLEY_H              = 59975,
    SPELL_SHIVER                            = 57949,
    SPELL_SHIVER_H                          = 59978,

    // INSANITY
    SPELL_INSANITY                          = 57496, //Dummy
    INSANITY_VISUAL                         = 57561,
    SPELL_INSANITY_TARGET                   = 57508,
    SPELL_CLONE_PLAYER                      = 57507, //casted on player during insanity
    SPELL_INSANITY_PHASING_1                = 57508,
    SPELL_INSANITY_PHASING_2                = 57509,
    SPELL_INSANITY_PHASING_3                = 57510,
    SPELL_INSANITY_PHASING_4                = 57511,
    SPELL_INSANITY_PHASING_5                = 57512
};

enum Yells
{
    SAY_AGGRO   = 0,
    SAY_SLAY    = 1,
    SAY_DEATH   = 2,
    SAY_PHASE   = 3
};

enum Misc
{
    NPC_TWISTED_VISAGE                      = 30625,
    ACHIEV_QUICK_DEMISE_START_EVENT         = 20382,
};

enum Events
{
    EVENT_HERALD_MIND_FLAY                  = 1,
    EVENT_HERALD_SHADOW,
    EVENT_HERALD_SHIVER,
};

class boss_volazj : public CreatureScript
{
public:
    boss_volazj() : CreatureScript("boss_volazj") { }

    struct boss_volazjAI : public BossAI
    {
        boss_volazjAI(Creature* pCreature) : BossAI(pCreature, DATA_HERALD_VOLAZJ),
            insanityTimes(0),
            insanityHandled(0)
        {
        }

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            // Visible for all players in insanity
            me->SetPhaseMask((1 | 16 | 32 | 64 | 128 | 256), true);
        }

        void Reset() override
        {
            _Reset();
            events.ScheduleEvent(EVENT_HERALD_MIND_FLAY, 8000);
            events.ScheduleEvent(EVENT_HERALD_SHADOW, 5000);
            events.ScheduleEvent(EVENT_HERALD_SHIVER, 15000);

            insanityTimes = 0;
            insanityHandled = 0;

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_STUNNED);
            ResetPlayersPhaseMask();
            instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_QUICK_DEMISE_START_EVENT);
        }

        void SpellHitTarget(Unit* pTarget, const SpellInfo *spell) override
        {
            if (spell->Id == SPELL_INSANITY)
            {
                // Not good target or too many players
                if (pTarget->GetTypeId() != TYPEID_PLAYER || insanityHandled > 4)
                {
                    return;
                }

                // First target - start channel visual and set self as unnattackable
                if (!insanityHandled)
                {
                    me->RemoveAllAuras();
                    DoCastSelf(INSANITY_VISUAL, true);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->SetControlled(true, UNIT_STATE_STUNNED);
                }

                // phase mask
                pTarget->CastSpell(pTarget, SPELL_INSANITY_TARGET + insanityHandled, true);
                
                // summon twisted party members for this target
                Map::PlayerList const &players = me->GetMap()->GetPlayers();
                for (auto const& i : players)
                {
                    Player *plr = i.GetSource();
                    if (!plr || !plr->IsAlive() || plr->IsGameMaster() || pTarget->GetGUID() == plr->GetGUID())
                    {
                        continue;
                    }

                    // Summon clone
                    if (Unit* summon = me->SummonCreature(NPC_TWISTED_VISAGE, *plr, TEMPSUMMON_CORPSE_DESPAWN, 0))
                    {
                        summon->AddThreat(pTarget, 0.0f);
                        summon->SetInCombatWith(pTarget);
                        pTarget->SetInCombatWith(summon);

                        plr->CastSpell(summon, SPELL_CLONE_PLAYER, true);
                        summon->SetPhaseMask(1 | (1 << (4 + insanityHandled)), true);
                        summon->SetUInt32Value(UNIT_FIELD_MINDAMAGE, plr->GetUInt32Value(UNIT_FIELD_MINDAMAGE));
                        summon->SetUInt32Value(UNIT_FIELD_MAXDAMAGE, plr->GetUInt32Value(UNIT_FIELD_MAXDAMAGE));
                    }
                }

                ++insanityHandled;
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_AGGRO);
            instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_QUICK_DEMISE_START_EVENT);
            me->SetInCombatWithZone();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_STUNNED);
            ResetPlayersPhaseMask();
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_SLAY);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            // Do not perform insanity recast if boss is casting insanity
            if (me->FindCurrentSpellBySpellId(SPELL_INSANITY))
                return;

            // First insanity
            if (insanityTimes == 0 && me->HealthBelowPctDamaged(66, damage))
            {
                DoCastSelf(SPELL_INSANITY, false);
                ++insanityTimes;
            }
            // Second insanity
            else if (insanityTimes == 1 && me->HealthBelowPctDamaged(33, damage))
            {
                me->InterruptNonMeleeSpells(false);
                DoCastSelf(SPELL_INSANITY, false);
                ++insanityTimes;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
            {
                return;
            }

            if (insanityHandled)
            {
                if (!CheckPhaseMinions())
                {
                    return;
                }

                insanityHandled = 0;
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetControlled(false, UNIT_STATE_STUNNED);
                me->RemoveAurasDueToSpell(INSANITY_VISUAL);
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_HERALD_MIND_FLAY:
                    {
                        DoCastVictim(DUNGEON_MODE(SPELL_MIND_FLAY, SPELL_MIND_FLAY_H), false);
                        events.RepeatEvent(20000);
                    }break;
                    case EVENT_HERALD_SHADOW:
                    {
                        DoCastVictim(DUNGEON_MODE(SPELL_SHADOW_BOLT_VOLLEY, SPELL_SHADOW_BOLT_VOLLEY_H), false);
                        events.RepeatEvent(5000);
                    }break;
                    case EVENT_HERALD_SHIVER:
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            DoCast(pTarget, DUNGEON_MODE(SPELL_SHIVER, SPELL_SHIVER_H), false);

                        events.RepeatEvent(15000);
                    }break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint8 insanityTimes;
        uint8 insanityHandled;

        void ResetPlayersPhaseMask()
        {
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& i : players)
            {
                if (Player* pPlayer = i.GetSource())
                {
                    uint32 phaseAuraToRemove = 0;
                    switch (pPlayer->GetPhaseMask())
                    {
                        case 16:
                        {
                            phaseAuraToRemove = SPELL_INSANITY_PHASING_1;
                            break;
                        }
                        case 32:
                        {
                            phaseAuraToRemove = SPELL_INSANITY_PHASING_2;
                            break;
                        }
                        case 64:
                        {
                            phaseAuraToRemove = SPELL_INSANITY_PHASING_3;
                            break;
                        }
                        case 128:
                        {
                            phaseAuraToRemove = SPELL_INSANITY_PHASING_4;
                            break;
                        }
                        case 256:
                        {
                            phaseAuraToRemove = SPELL_INSANITY_PHASING_5;
                            break;
                        }
                    }

                    if (phaseAuraToRemove)
                    {
                        pPlayer->RemoveAurasDueToSpell(phaseAuraToRemove);
                    }
                }
            }
        }

        bool CheckPhaseMinions()
        {
            summons.RemoveNotExisting();
            if (summons.empty())
            {
                ResetPlayersPhaseMask();
                return true;
            }

            uint16 phase = 1;
            for (uint64 const summonGUID : summons)
            {
                if (Creature* summon = ObjectAccessor::GetCreature(*me, summonGUID))
                {
                    phase |= summon->GetPhaseMask();
                }
            }

            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& i : players)
            {
                Player* pPlayer = i.GetSource();
                if (pPlayer && !(pPlayer->GetPhaseMask() & phase))
                {
                    pPlayer->RemoveAurasDueToSpell(GetSpellForPhaseMask(pPlayer->GetPhaseMask()));
                }
            }

            return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_volazjAI(creature);
    }
};

void AddSC_boss_volazj()
{
    new boss_volazj();
}
