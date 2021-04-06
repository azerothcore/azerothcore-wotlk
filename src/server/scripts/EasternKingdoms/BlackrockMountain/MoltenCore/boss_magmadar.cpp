/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Magmadar
SD%Complete: 75
SDComment: Conflag on ground nyi
SDCategory: Molten Core
EndScriptData */

#include "molten_core.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Texts
{
    EMOTE_FRENZY        = 0,
    EMOTE_SMOLDERING    = 0,
    EMOTE_IGNITE        = 1,
};

enum Spells
{
    SPELL_FRENZY        = 19451,
    SPELL_MAGMA_SPIT    = 19449,
    SPELL_PANIC         = 19408,
    SPELL_LAVA_BOMB     = 19428,
    SPELL_SERRATED_BITE = 19771,
};

enum Events
{
    EVENT_FRENZY        = 1,
    EVENT_PANIC,
    EVENT_LAVA_BOMB,
    EVENT_SERRATED_BITE,
    EVENT_IGNITE,
};

class boss_magmadar : public CreatureScript
{
public:
    boss_magmadar() : CreatureScript("boss_magmadar") { }

    struct boss_magmadarAI : public BossAI
    {
        boss_magmadarAI(Creature* creature) : BossAI(creature, BOSS_MAGMADAR)
        {
        }

        void Reset() override
        {
            _Reset();
            DoCastSelf(SPELL_MAGMA_SPIT, true);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FRENZY, 30000);
            events.ScheduleEvent(EVENT_PANIC, 20000);
            events.ScheduleEvent(EVENT_LAVA_BOMB, 12000);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
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
                    case EVENT_FRENZY:
                    {
                        Talk(EMOTE_FRENZY);
                        DoCastSelf(SPELL_FRENZY);
                        events.RepeatEvent(15000);
                        break;
                    }
                    case EVENT_PANIC:
                    {
                        DoCastVictim(SPELL_PANIC);
                        events.RepeatEvent(35000);
                        break;
                    }
                    case EVENT_LAVA_BOMB:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true, -SPELL_LAVA_BOMB))
                        {
                            DoCast(target, SPELL_LAVA_BOMB);
                        }

                        events.RepeatEvent(12000);
                        break;
                    }
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_magmadarAI>(creature);
    }
};

// Serrated Bites timer may be wrong
class npc_magmadar_core_hound : public CreatureScript
{
public:
    npc_magmadar_core_hound() : CreatureScript("npc_magmadar_core_hound")
    {
    }

    struct npc_magmadar_core_houndAI : public CreatureAI
    {
        npc_magmadar_core_houndAI(Creature* creature) : CreatureAI(creature)
        {
        }

        void removeFeignDeath()
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29);
            me->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->RemoveUnitMovementFlag(MOVEMENTFLAG_ROOT);
            me->ClearUnitState(UNIT_STATE_DIED);
            me->ClearUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
            me->DisableRotate(false);

            if (smoldering)
            {
                events.RescheduleEvent(EVENT_SERRATED_BITE, 10000); // timer may be wrong
            }

            smoldering = false;
            killerGUID = 0;
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
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29);
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
            events.ScheduleEvent(EVENT_SERRATED_BITE, 10000); // timer may be wrong
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
                        events.ScheduleEvent(EVENT_SERRATED_BITE, 10000); // again, timer may be wrong
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
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29);
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
                            killerGUID = 0;
                        }
                        break;
                    }
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        uint64 killerGUID;
        bool smoldering;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_magmadar_core_houndAI>(creature);
    }
};

void AddSC_boss_magmadar()
{
    new boss_magmadar();
    new npc_magmadar_core_hound();
}
