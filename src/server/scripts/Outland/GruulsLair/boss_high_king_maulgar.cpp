/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
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

class boss_high_king_maulgar : public CreatureScript
{
public:
    boss_high_king_maulgar() : CreatureScript("boss_high_king_maulgar") { }

    struct boss_high_king_maulgarAI : public BossAI
    {
        boss_high_king_maulgarAI(Creature* creature) : BossAI(creature, DATA_MAULGAR) { }

        void Reset()
        {
            _Reset();
            me->SetLootMode(0);
        }

        void KilledUnit(Unit*  /*victim*/)
        {
            if (events.GetNextEventTime(EVENT_RECENTLY_SPOKEN) == 0)
            {
                events.ScheduleEvent(EVENT_RECENTLY_SPOKEN, 5000);
                Talk(SAY_SLAY);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (instance->GetData(DATA_ADDS_KILLED) == MAX_ADD_NUMBER)
                _JustDied();
        }

        void DoAction(int32 actionId)
        {
            if (me->IsAlive())
            {
                Talk(SAY_OGRE_DEATH);
                if (actionId == MAX_ADD_NUMBER)
                    me->SetLootMode(1);
            }
            else if (actionId == MAX_ADD_NUMBER)
            {
                me->loot.clear();
                me->loot.FillLoot(me->GetCreatureTemplate()->lootid, LootTemplates_Creature, me->GetLootRecipient(), false, false, 1);
                me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                _JustDied();
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_ARCING_SMASH, 6000);
            events.ScheduleEvent(EVENT_MIGHTY_BLOW, 20000);
            events.ScheduleEvent(EVENT_WHIRLWIND, 30000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
        }

        void UpdateAI(uint32 diff)
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
                    events.ScheduleEvent(EVENT_ARCING_SMASH, 10000);
                    break;
                case EVENT_MIGHTY_BLOW:
                    me->CastSpell(me->GetVictim(), SPELL_MIGHTY_BLOW, false);
                    events.ScheduleEvent(EVENT_MIGHTY_BLOW, 16000);
                    break;
                case EVENT_WHIRLWIND:
                    events.DelayEvents(15000);
                    me->CastSpell(me, SPELL_WHIRLWIND, false);
                    events.ScheduleEvent(EVENT_WHIRLWIND, 54000);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(50))
                    {
                        Talk(SAY_ENRAGE);
                        me->CastSpell(me, SPELL_FLURRY, true);
                        events.ScheduleEvent(EVENT_CHARGING, 0);
                        events.ScheduleEvent(EVENT_ROAR, 3000);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
                    break;
                case EVENT_ROAR:
                    me->CastSpell(me, SPELL_ROAR, false);
                    events.ScheduleEvent(EVENT_ROAR, 40000);
                    break;
                case EVENT_CHARGING:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                        me->CastSpell(target, SPELL_BERSERKER_C, false);
                    events.ScheduleEvent(EVENT_CHARGING, 35000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_high_king_maulgarAI>(creature);
    }
};

class boss_olm_the_summoner : public CreatureScript
{
public:
    boss_olm_the_summoner() : CreatureScript("boss_olm_the_summoner") { }

    struct boss_olm_the_summonerAI : public ScriptedAI
    {
        boss_olm_the_summonerAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* instance;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
        }

        void AttackStart(Unit* who)
        {
            if (!who)
                return;

            if (me->Attack(who, true))
                me->GetMotionMaster()->MoveChase(who, 25.0f);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->SetInCombatWithZone();
            instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

            events.ScheduleEvent(EVENT_ADD_ABILITY1, 10000);
            events.ScheduleEvent(EVENT_ADD_ABILITY2, 15000);
            events.ScheduleEvent(EVENT_ADD_ABILITY3, 20000);
        }

        void JustDied(Unit* /*killer*/)
        {
            instance->SetData(DATA_ADDS_KILLED, 1);
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ADD_ABILITY1:
                    me->CastSpell(me->GetVictim(), SPELL_DARK_DECAY, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY1, 20000);
                    break;
                case EVENT_ADD_ABILITY2:
                    me->CastSpell(me, SPELL_SUMMON_WFH, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY2, 30000);
                    break;
                case EVENT_ADD_ABILITY3:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, SPELL_DEATH_COIL, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY3, 20000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_olm_the_summonerAI>(creature);
    }
};

class boss_kiggler_the_crazed : public CreatureScript
{
public:
    boss_kiggler_the_crazed() : CreatureScript("boss_kiggler_the_crazed") { }

    struct boss_kiggler_the_crazedAI : public ScriptedAI
    {
        boss_kiggler_the_crazedAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* instance;

        void Reset()
        {
            events.Reset();
            instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->SetInCombatWithZone();
            instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

            events.ScheduleEvent(EVENT_ADD_ABILITY1, 5000);
            events.ScheduleEvent(EVENT_ADD_ABILITY2, 10000);
            events.ScheduleEvent(EVENT_ADD_ABILITY3, 20000);
            events.ScheduleEvent(EVENT_ADD_ABILITY4, 30000);
        }

        void JustDied(Unit* /*killer*/)
        {
            instance->SetData(DATA_ADDS_KILLED, 1);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ADD_ABILITY1:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                        me->CastSpell(target, SPELL_GREATER_POLYMORPH, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY1, 20000);
                    break;
                case EVENT_ADD_ABILITY2:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                        me->CastSpell(target, SPELL_LIGHTNING_BOLT, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY2, 15000);
                    break;
                case EVENT_ADD_ABILITY3:
                    me->CastSpell(me->GetVictim(), SPELL_ARCANE_SHOCK, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY3, 20000);
                    break;
                case EVENT_ADD_ABILITY4:
                    me->CastSpell(me, SPELL_ARCANE_EXPLOSION, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY4, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_kiggler_the_crazedAI>(creature);
    }
};

class boss_blindeye_the_seer : public CreatureScript
{
public:
    boss_blindeye_the_seer() : CreatureScript("boss_blindeye_the_seer") { }

    struct boss_blindeye_the_seerAI : public ScriptedAI
    {
        boss_blindeye_the_seerAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* instance;

        void Reset()
        {
            events.Reset();
            instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->SetInCombatWithZone();
            instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

            events.ScheduleEvent(EVENT_ADD_ABILITY1, 5000);
            events.ScheduleEvent(EVENT_ADD_ABILITY2, 10000);
            events.ScheduleEvent(EVENT_ADD_ABILITY3, 20000);
        }

        void JustDied(Unit* /*killer*/)
        {
            instance->SetData(DATA_ADDS_KILLED, 1);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ADD_ABILITY1:
                    me->CastSpell(me, SPELL_GREATER_PW_SHIELD, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY1, 30000);
                    break;
                case EVENT_ADD_ABILITY2:
                    if (Unit* target = DoSelectLowestHpFriendly(60.0f, 50000))
                        me->CastSpell(target, SPELL_HEAL, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY2, 25000);
                    break;
                case EVENT_ADD_ABILITY3:
                    me->CastSpell(me, SPELL_PRAYER_OH, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY3, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_blindeye_the_seerAI>(creature);
    }
};

class boss_krosh_firehand : public CreatureScript
{
public:
    boss_krosh_firehand() : CreatureScript("boss_krosh_firehand") { }

    struct boss_krosh_firehandAI : public ScriptedAI
    {
        boss_krosh_firehandAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* instance;

        void Reset()
        {
            events.Reset();
            instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
        }

        void AttackStart(Unit* who)
        {
            if (!who)
                return;

            if (me->Attack(who, true))
                me->GetMotionMaster()->MoveChase(who, 25.0f);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->SetInCombatWithZone();
            instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

            events.ScheduleEvent(EVENT_ADD_ABILITY1, 1000);
            events.ScheduleEvent(EVENT_ADD_ABILITY2, 5000);
            events.ScheduleEvent(EVENT_ADD_ABILITY3, 20000);
        }

        void JustDied(Unit* /*killer*/)
        {
            instance->SetData(DATA_ADDS_KILLED, 1);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ADD_ABILITY1:
                    me->CastSpell(me->GetVictim(), SPELL_GREATER_FIREBALL, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY1, 3500);
                    break;
                case EVENT_ADD_ABILITY2:
                    me->CastSpell(me, SPELL_SPELLSHIELD, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY2, 40000);
                    break;
                case EVENT_ADD_ABILITY3:
                    me->CastSpell(me, SPELL_BLAST_WAVE, false);
                    events.ScheduleEvent(EVENT_ADD_ABILITY3, 20000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_krosh_firehandAI>(creature);
    }
};

void AddSC_boss_high_king_maulgar()
{
    new boss_high_king_maulgar();
    new boss_kiggler_the_crazed();
    new boss_blindeye_the_seer();
    new boss_olm_the_summoner();
    new boss_krosh_firehand();
}
