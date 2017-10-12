/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Magmadar
SD%Complete: 75
SDComment: Conflag on ground nyi
SDCategory: Molten Core
EndScriptData */

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Texts
{
    EMOTE_FRENZY        = 0,
    EMOTE_SMOLDERING    = 0,
    EMOTE_IGNITE        = 1,
};

enum Spells
{
    SPELL_FRENZY            = 19451,
    SPELL_MAGMA_SPIT        = 19449,
    SPELL_PANIC             = 19408,
    SPELL_LAVA_BOMB         = 19428,
    SPELL_SERRATED_BITE     = 19771,
};

enum Events
{
    EVENT_FRENZY        = 1,
    EVENT_PANIC         = 2,
    EVENT_LAVA_BOMB     = 3,
    EVENT_SERRATED_BITE = 1,
    EVENT_IGNITE        = 2,
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

            void Reset()
            {
                BossAI::Reset();
                DoCast(me, SPELL_MAGMA_SPIT, true);
            }

            void EnterCombat(Unit* victim)
            {
                BossAI::EnterCombat(victim);
                events.ScheduleEvent(EVENT_FRENZY, 30000);
                events.ScheduleEvent(EVENT_PANIC, 20000);
                events.ScheduleEvent(EVENT_LAVA_BOMB, 12000);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_FRENZY:
                            Talk(EMOTE_FRENZY);
                            DoCast(me, SPELL_FRENZY);
                            events.ScheduleEvent(EVENT_FRENZY, 15000);
                            break;
                        case EVENT_PANIC:
                            DoCastVictim(SPELL_PANIC);
                            events.ScheduleEvent(EVENT_PANIC, 35000);
                            break;
                        case EVENT_LAVA_BOMB:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true, -SPELL_LAVA_BOMB))
                                DoCast(target, SPELL_LAVA_BOMB);
                            events.ScheduleEvent(EVENT_LAVA_BOMB, 12000);
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_magmadarAI(creature);
        }
};

// Smoldering animation is an hack, Serrated Bites timer may be wrong
// The original smoldering aura should increase crit chance to 100% and play dead animation
class npc_magmadar_core_hound : public CreatureScript
{
public:
    npc_magmadar_core_hound() : CreatureScript("npc_magmadar_core_hound") { }

    struct npc_magmadar_core_houndAI : public CreatureAI
    {
        npc_magmadar_core_houndAI(Creature* creature) : CreatureAI(creature)
        {
        }

        EventMap events;
        bool smoldering;
        std::list<Creature *> hounds;

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) 
        {
            if (me->HealthBelowPctDamaged(0, damage))
            {
                if (!smoldering)
                {
                    events.ScheduleEvent(EVENT_IGNITE, 10000);
                    me->SetHealth(1);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED|UNIT_FLAG_PACIFIED);
                    me->AddAura(57626, me); // feign death animation, this is an hack even if the result is good
                    Talk(EMOTE_SMOLDERING);
                }
                damage = 0;
                smoldering = true;
            }
        }

        void Reset()
        {

        }

        void EnterCombat(Unit* /*victim*/)
        {
            events.ScheduleEvent(EVENT_SERRATED_BITE, 10000); // timer may be wrong
            smoldering = false;
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_SERRATED_BITE:
                    if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED))
                        DoCast(me->GetVictim(), SPELL_SERRATED_BITE);
                    events.ScheduleEvent(EVENT_SERRATED_BITE, 10000); // again, timer may be wrong
                    break;
                case EVENT_IGNITE:
                    me->GetCreaturesWithEntryInRange(hounds, 100, NPC_CORE_HOUND);
                    for (Creature * i : hounds)
                    {
                        if (i && i->IsAlive() && i->IsInCombat() && !i->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED))
                        {
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED|UNIT_FLAG_PACIFIED);
                            me->RemoveAura(me->GetAura(57626), AURA_REMOVE_BY_DEFAULT);
                            me->SetFullHealth();
                            smoldering = false;
                            Talk(EMOTE_IGNITE);
                            return;
                        }
                    }
                    Unit::Kill(me, me);
                    break;
                default:
                    break;
                }
            }

            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED))
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_magmadar_core_houndAI(creature);
    }
};

void AddSC_boss_magmadar()
{
    new boss_magmadar();
    new npc_magmadar_core_hound();
}
