/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Texts
{
    EMOTE_SMOLDERING        = 0,
    EMOTE_IGNITE            = 1,
};

enum Spells
{
    SPELL_SERRATED_BITE     = 19771,
};

enum Events
{
    EVENT_SERRATED_BITE     = 1,
    EVENT_IGNITE,
};

// Serrated Bites timer may be wrong
class npc_mc_core_hound : public CreatureScript
{
public:
    npc_mc_core_hound() : CreatureScript("npc_mc_core_hound")
    {
    }

    struct npc_mc_core_houndAI : public CreatureAI
    {
        npc_mc_core_houndAI(Creature* creature) : CreatureAI(creature),
                                                  killerGUID(),
                                                  smoldering(false)
        {
        }

        void removeFeignDeath()
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
            me->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
            me->RemoveUnitMovementFlag(MOVEMENTFLAG_ROOT);
            me->ClearUnitState(UNIT_STATE_DIED);
            me->ClearUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
            me->DisableRotate(false);

            if (smoldering)
            {
                events.RescheduleEvent(EVENT_SERRATED_BITE, 3000);
            }

            smoldering = false;
            killerGUID.Clear();
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (me->HealthBelowPctDamaged(0, damage))
            {
                if (!smoldering)
                {
                    killerGUID = attacker->GetGUID();
                    events.CancelEvent(EVENT_SERRATED_BITE);
                    events.ScheduleEvent(EVENT_IGNITE, 10000);
                    me->SetHealth(1);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
                    me->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                    me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                    me->AddUnitMovementFlag(MOVEMENTFLAG_ROOT);
                    me->AddUnitState(UNIT_STATE_DIED);
                    me->AddUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
                    me->DisableRotate(true);
                    Talk(EMOTE_SMOLDERING);
                }
                damage = 0;
                smoldering = true;
            }
        }

        void Reset() override
        {
            removeFeignDeath();
        }

        void JustDied(Unit* /*killer*/) override
        {
            removeFeignDeath();
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            events.ScheduleEvent(EVENT_SERRATED_BITE, 3000);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && !smoldering)
            {
                return;
            }

            events.Update(diff);

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SERRATED_BITE:
                    {
                        if (!smoldering)
                        {
                            DoCastVictim(SPELL_SERRATED_BITE);
                        }
                        events.RepeatEvent(urand(5000, 6000));
                        break;
                    }
                    case EVENT_IGNITE:
                    {
                        smoldering = false;
                        std::list<Creature*> hounds;
                        me->GetCreaturesWithEntryInRange(hounds, 80, NPC_CORE_HOUND);
                        hounds.remove_if([](Creature* hound) -> bool
                                         {
                                             return !hound || hound->isDead() || !hound->IsInCombat() || hound->HasUnitState(UNIT_STATE_DIED);
                                         });

                        if (!hounds.empty())
                        {
                            Talk(EMOTE_IGNITE);
                            me->SetFullHealth();
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
                            me->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                            me->RemoveUnitMovementFlag(MOVEMENTFLAG_ROOT);
                            me->ClearUnitState(UNIT_STATE_DIED);
                            me->ClearUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
                            me->DisableRotate(false);
                            if (Unit* victim = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            {
                                AttackStart(victim);
                            }
                        }
                        else if (me->HasUnitState(UNIT_STATE_DIED))
                        {
                            Unit* killer = ObjectAccessor::GetUnit(*me, killerGUID);
                            me->Kill(killer ? killer : me, me);
                            killerGUID.Clear();
                        }
                        break;
                    }
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        ObjectGuid killerGUID;
        bool smoldering;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_mc_core_houndAI>(creature);
    }
};

void AddSC_molten_core()
{
    new npc_mc_core_hound();
}
