/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Golemagg
SD%Complete: 90
SDComment: Timers need to be confirmed, Golemagg's Trust need to be checked
SDCategory: Molten Core
EndScriptData */

#include "molten_core.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "ObjectAccessor.h"

enum Texts
{
    EMOTE_LOWHP                 = 0,
};

enum Spells
{
    // Golemagg
    SPELL_PYROBLAST             = 20228,
    SPELL_EARTHQUAKE            = 19798,
    SPELL_ENRAGE                = 19953,
    SPELL_GOLEMAGG_TRUST        = 20553,

    // Core Rager
    SPELL_QUIET_SUICIDE         = 3617,     // Server side
    SPELL_MANGLE                = 19820,
    SPELL_FULL_HEAL             = 17683,
};

enum Misc
{
    DATA_GOLEMAGG_CORE_HOUND    = 1
};

class boss_golemagg : public CreatureScript
{
public:
    boss_golemagg() : CreatureScript("boss_golemagg") { }

    struct boss_golemaggAI : public BossAI
    {
        boss_golemaggAI(Creature* creature) : BossAI(creature, DATA_GOLEMAGG),
            earthquakeTimer(0),
            pyroblastTimer(7000),
            enraged(false)
        {}

        void Reset() override
        {
            earthquakeTimer = 0;
            pyroblastTimer = 7000;
            enraged = false;

            _Reset();
            for (ObjectGuid const& minionGuid : coreHoundsGuids)
            {
                Creature* minion = ObjectAccessor::GetCreature(*me, minionGuid);
                if (minion && minion->isDead())
                {
                    minion->Respawn();
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            for (ObjectGuid const& minionGuid : coreHoundsGuids)
            {
                Creature* minion = ObjectAccessor::GetCreature(*me, minionGuid);
                if (minion && minion->IsAlive())
                {
                    minion->CastSpell(minion, SPELL_QUIET_SUICIDE, true);
                }
            }

            coreHoundsGuids.clear();
        }

        void EnterCombat(Unit* victim) override
        {
            _EnterCombat();
            for (ObjectGuid const& minionGuid : coreHoundsGuids)
            {
                Creature* minion = ObjectAccessor::GetCreature(*me, minionGuid);
                if (minion && minion->IsAlive())
                {
                    minion->AI()->DoZoneInCombat();
                    minion->AI()->AttackStart(victim);
                }
            }

            pyroblastTimer = 7000;
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!enraged && me->HealthBelowPctDamaged(10, damage))
            {
                DoCastSelf(SPELL_ENRAGE, true);
                earthquakeTimer = 3000;
                enraged = true;
            }
        }

        void SetGUID(ObjectGuid guid, int32 id) override
        {
            if (id == DATA_GOLEMAGG_CORE_HOUND)
            {
                coreHoundsGuids.insert(guid);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            // Should not get impact by cast state
            if (earthquakeTimer)
            {
                if (earthquakeTimer <= diff)
                {
                    DoCastAOE(SPELL_EARTHQUAKE);
                    earthquakeTimer = 3000;
                }
                else
                {
                    earthquakeTimer -= diff;
                }
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            if (pyroblastTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                {
                    DoCast(target, SPELL_PYROBLAST);
                }

                pyroblastTimer = 7000;
            }
            else
            {
                pyroblastTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }

    private:
        GuidSet coreHoundsGuids;
        uint32 earthquakeTimer;
        uint32 pyroblastTimer;
        bool enraged;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_golemaggAI>(creature);
    }
};

class npc_core_rager : public CreatureScript
{
public:
    npc_core_rager() : CreatureScript("npc_core_rager") { }

    struct npc_core_ragerAI : public ScriptedAI
    {
        npc_core_ragerAI(Creature* creature) : ScriptedAI(creature),
            instance(creature->GetInstanceScript())
        {
        }

        void Reset() override
        {
            mangleTimer = 7000;               // These times are probably wrong

            if (instance->GetBossState(DATA_GOLEMAGG) != DONE)
            {
                if (Creature* golemagg = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_GOLEMAGG)))
                {
                    golemagg->AI()->SetGUID(me->GetGUID(), DATA_GOLEMAGG_CORE_HOUND);
                }
            }
            else
            {
                DoCastSelf(SPELL_QUIET_SUICIDE);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            // Just in case if something will go bad, let players to kill this creature
            if (instance->GetBossState(DATA_GOLEMAGG) == DONE)
            {
                return;
            }

            if (me->HealthBelowPctDamaged(50, damage))
            {
                damage = 0;
                DoCastSelf(SPELL_GOLEMAGG_TRUST, true);
                DoCastSelf(SPELL_FULL_HEAL, true);
                Talk(EMOTE_LOWHP);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            // Mangle
            if (mangleTimer <= diff)
            {
                DoCastVictim(SPELL_MANGLE);
                mangleTimer = 10000;
            }
            else
            {
                mangleTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* instance;
        uint32 mangleTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_core_ragerAI>(creature);
    }
};

void AddSC_boss_golemagg()
{
    new boss_golemagg();
    new npc_core_rager();
}
