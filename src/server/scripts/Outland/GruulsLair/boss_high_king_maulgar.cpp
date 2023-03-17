/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "gruuls_lair.h"

enum HighKingMaulgar
{
    SAY_AGGRO                   = 0,
    SAY_ENRAGE                  = 1,
    SAY_OGRE_DEATH              = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    // High King Maulgar
    SPELL_ARCING_SMASH          = 39144,
    SPELL_MIGHTY_BLOW           = 33230,
    SPELL_WHIRLWIND             = 33238,
    SPELL_BERSERKER_C           = 26561,
    SPELL_ROAR                  = 16508,
    SPELL_FLURRY                = 33232,

    // Olm the Summoner
    SPELL_DARK_DECAY            = 33129,
    SPELL_DEATH_COIL            = 33130,
    SPELL_SUMMON_WFH            = 33131,

    // Kiggler the Craed
    SPELL_GREATER_POLYMORPH     = 33173,
    SPELL_LIGHTNING_BOLT        = 36152,
    SPELL_ARCANE_SHOCK          = 33175,
    SPELL_ARCANE_EXPLOSION      = 33237,

    // Blindeye the Seer
    SPELL_GREATER_PW_SHIELD     = 33147,
    SPELL_HEAL                  = 33144,
    SPELL_PRAYER_OH             = 33152,

    // Krosh Firehand
    SPELL_GREATER_FIREBALL      = 33051,
    SPELL_SPELLSHIELD           = 33054,
    SPELL_BLAST_WAVE            = 33061,

    ACTION_ADD_DEATH            = 1
};

enum HKMEvents
{
    EVENT_RECENTLY_SPOKEN       = 1,
    EVENT_ARCING_SMASH          = 2,
    EVENT_MIGHTY_BLOW           = 3,
    EVENT_WHIRLWIND             = 4,
    EVENT_CHARGING              = 5,
    EVENT_ROAR                  = 6,
    EVENT_CHECK_HEALTH          = 7,

    EVENT_ADD_ABILITY1          = 10,
    EVENT_ADD_ABILITY2          = 11,
    EVENT_ADD_ABILITY3          = 12,
    EVENT_ADD_ABILITY4          = 13
};

struct boss_high_king_maulgar : public BossAI
{
    boss_high_king_maulgar(Creature* creature) : BossAI(creature, DATA_MAULGAR) { }

    void Reset() override
    {
        _Reset();
        me->SetLootMode(0);
    }

    void KilledUnit(Unit*  /*victim*/) override
    {
        if (events.GetNextEventTime(EVENT_RECENTLY_SPOKEN) == 0)
        {
            events.ScheduleEvent(EVENT_RECENTLY_SPOKEN, 5s);
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        if (instance->GetData(DATA_ADDS_KILLED) == MAX_ADD_NUMBER)
            _JustDied();
    }

    void DoAction(int32 actionId) override
    {
        if (me->IsAlive())
        {
            Talk(SAY_OGRE_DEATH);
            if (actionId == MAX_ADD_NUMBER)
            {
                me->AddLootMode(1);
            }
        }
        else if (actionId == MAX_ADD_NUMBER)
        {
            me->AddLootMode(1);
            me->loot.clear();
            me->loot.FillLoot(me->GetCreatureTemplate()->lootid, LootTemplates_Creature, me->GetLootRecipient(), false, false, me->GetLootMode(), me);
            me->SetDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
            _JustDied();
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        events.ScheduleEvent(EVENT_ARCING_SMASH, 6s);
        events.ScheduleEvent(EVENT_MIGHTY_BLOW, 20s);
        events.ScheduleEvent(EVENT_WHIRLWIND, 30s);
        events.ScheduleEvent(EVENT_CHECK_HEALTH, 500ms);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_ARCING_SMASH:
                me->CastSpell(me->GetVictim(), SPELL_ARCING_SMASH, false);
                events.ScheduleEvent(EVENT_ARCING_SMASH, 10s);
                break;
            case EVENT_MIGHTY_BLOW:
                me->CastSpell(me->GetVictim(), SPELL_MIGHTY_BLOW, false);
                events.ScheduleEvent(EVENT_MIGHTY_BLOW, 16s);
                break;
            case EVENT_WHIRLWIND:
                events.DelayEvents(15s);
                me->CastSpell(me, SPELL_WHIRLWIND, false);
                events.ScheduleEvent(EVENT_WHIRLWIND, 54s);
                break;
            case EVENT_CHECK_HEALTH:
                if (me->HealthBelowPct(50))
                {
                    Talk(SAY_ENRAGE);
                    me->CastSpell(me, SPELL_FLURRY, true);
                    events.ScheduleEvent(EVENT_CHARGING, 0s);
                    events.ScheduleEvent(EVENT_ROAR, 30s);
                    break;
                }
                events.ScheduleEvent(EVENT_CHECK_HEALTH, 500ms);
                break;
            case EVENT_ROAR:
                me->CastSpell(me, SPELL_ROAR, false);
                events.ScheduleEvent(EVENT_ROAR, 40s);
                break;
            case EVENT_CHARGING:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                    me->CastSpell(target, SPELL_BERSERKER_C, false);
                events.ScheduleEvent(EVENT_CHARGING, 35s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

struct boss_olm_the_summoner : public ScriptedAI
{
    boss_olm_the_summoner(Creature* creature) : ScriptedAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
    }

    EventMap events;
    SummonList summons;
    InstanceScript* instance;

    void Reset() override
    {
        events.Reset();
        summons.DespawnAll();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 25.0f);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        events.ScheduleEvent(EVENT_ADD_ABILITY1, 10s);
        events.ScheduleEvent(EVENT_ADD_ABILITY2, 15s);
        events.ScheduleEvent(EVENT_ADD_ABILITY3, 20s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_ADD_ABILITY1:
                DoCastVictim(SPELL_DARK_DECAY);
                events.ScheduleEvent(EVENT_ADD_ABILITY1, 7s);
                break;
            case EVENT_ADD_ABILITY2:
                me->CastSpell(me, SPELL_SUMMON_WFH, false);
                events.ScheduleEvent(EVENT_ADD_ABILITY2, 30s);
                break;
            case EVENT_ADD_ABILITY3:
                DoCastRandomTarget(SPELL_DEATH_COIL);
                events.ScheduleEvent(EVENT_ADD_ABILITY3, 20s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

struct boss_kiggler_the_crazed : public ScriptedAI
{
    boss_kiggler_the_crazed(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    EventMap events;
    InstanceScript* instance;

    void Reset() override
    {
        events.Reset();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        events.ScheduleEvent(EVENT_ADD_ABILITY1, 5s);
        events.ScheduleEvent(EVENT_ADD_ABILITY2, 10s);
        events.ScheduleEvent(EVENT_ADD_ABILITY3, 20s);
        events.ScheduleEvent(EVENT_ADD_ABILITY4, 30s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_ADD_ABILITY1:
                if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1))
                    me->CastSpell(target, SPELL_GREATER_POLYMORPH, false);
                events.ScheduleEvent(EVENT_ADD_ABILITY1, 20s);
                break;
            case EVENT_ADD_ABILITY2:
                DoCastVictim(SPELL_LIGHTNING_BOLT);
                events.ScheduleEvent(EVENT_ADD_ABILITY2, 1500ms);
                break;
            case EVENT_ADD_ABILITY3:
                DoCastVictim(SPELL_ARCANE_SHOCK);
                events.ScheduleEvent(EVENT_ADD_ABILITY3, 20s);
                break;
            case EVENT_ADD_ABILITY4:
                DoCastAOE(SPELL_ARCANE_EXPLOSION);
                events.ScheduleEvent(EVENT_ADD_ABILITY4, 30s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

struct boss_blindeye_the_seer : public ScriptedAI
{
    boss_blindeye_the_seer(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    EventMap events;
    InstanceScript* instance;

    void Reset() override
    {
        events.Reset();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        events.ScheduleEvent(EVENT_ADD_ABILITY1, 1700ms);
        events.ScheduleEvent(EVENT_ADD_ABILITY2, 10s);
        events.ScheduleEvent(EVENT_ADD_ABILITY3, 20s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_ADD_ABILITY1:
                DoCastSelf(SPELL_GREATER_PW_SHIELD);
                events.ScheduleEvent(EVENT_ADD_ABILITY1, 30s);
                break;
            case EVENT_ADD_ABILITY2:
                if (Unit* target = DoSelectLowestHpFriendly(60.0f, 50000))
                {
                    DoCast(target, SPELL_HEAL);
                }
                events.ScheduleEvent(EVENT_ADD_ABILITY2, 25s);
                break;
            case EVENT_ADD_ABILITY3:
                me->CastSpell(me, SPELL_PRAYER_OH, false);
                events.ScheduleEvent(EVENT_ADD_ABILITY3, 30s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

struct boss_krosh_firehand : public ScriptedAI
{
    boss_krosh_firehand(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    EventMap events;
    InstanceScript* instance;

    void Reset() override
    {
        events.Reset();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 25.0f);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        events.ScheduleEvent(EVENT_ADD_ABILITY1, 1s);
        events.ScheduleEvent(EVENT_ADD_ABILITY2, 5s);
        events.ScheduleEvent(EVENT_ADD_ABILITY3, 20s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_ADD_ABILITY1:
                DoCastVictim(SPELL_GREATER_FIREBALL);
                events.ScheduleEvent(EVENT_ADD_ABILITY1, 3500ms);
                break;
            case EVENT_ADD_ABILITY2:
                DoCastSelf(SPELL_SPELLSHIELD);
                events.ScheduleEvent(EVENT_ADD_ABILITY2, 40s);
                break;
            case EVENT_ADD_ABILITY3:
                DoCastAOE(SPELL_BLAST_WAVE);
                events.ScheduleEvent(EVENT_ADD_ABILITY3, 20s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_high_king_maulgar()
{
    RegisterGruulsLairAI(boss_high_king_maulgar);
    RegisterGruulsLairAI(boss_kiggler_the_crazed);
    RegisterGruulsLairAI(boss_blindeye_the_seer);
    RegisterGruulsLairAI(boss_olm_the_summoner);
    RegisterGruulsLairAI(boss_krosh_firehand);
}
