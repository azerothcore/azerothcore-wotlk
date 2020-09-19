/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "magisters_terrace.h"
#include "WorldPacket.h"
#include "Opcodes.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_PHOENIX                 = 1,
    SAY_FLAMESTRIKE             = 2,
    SAY_GRAVITY_LAPSE           = 3,
    SAY_TIRED                   = 4,
    SAY_RECAST_GRAVITY          = 5,
    SAY_DEATH                   = 6
};

enum Spells
{
    // Phase 1
    SPELL_FIREBALL_N                = 44189,
    SPELL_FIREBALL_H                = 46164,
    SPELL_FLAMESTRIKE_SUMMON        = 44192,
    SPELL_PHOENIX                   = 44194,
    SPELL_SHOCK_BARRIER             = 46165,
    SPELL_PYROBLAST                 = 36819,

    // Phase 2
    SPELL_SUMMON_ARCANE_SPHERE      = 44265,
    SPELL_TELEPORT_CENTER           = 44218,
    SPELL_GRAVITY_LAPSE_INITIAL     = 44224,
    SPELL_GRAVITY_LAPSE_PLAYER      = 44219, // Till 44223, 5 players
    SPELL_GRAVITY_LAPSE_FLY         = 44227,
    SPELL_GRAVITY_LAPSE_DOT         = 44226,
    SPELL_GRAVITY_LAPSE_CHANNEL     = 44251,
    SPELL_POWER_FEEDBACK            = 44233
};

enum Misc
{
    EVENT_INIT_COMBAT           = 1,
    EVENT_SPELL_FIREBALL        = 2,
    EVENT_SPELL_PHOENIX         = 3,
    EVENT_SPELL_FLAMESTRIKE     = 4,
    EVENT_SPELL_SHOCK_BARRIER   = 5,
    EVENT_CHECK_HEALTH          = 6,
    EVENT_GRAVITY_LAPSE_1_1     = 7,
    EVENT_GRAVITY_LAPSE_1_2     = 8,
    EVENT_GRAVITY_LAPSE_2       = 9,
    EVENT_GRAVITY_LAPSE_3       = 10,
    EVENT_GRAVITY_LAPSE_4       = 11,
    EVENT_GRAVITY_LAPSE_5       = 12,
    EVENT_FINISH_TALK           = 13,

    ACTION_TELEPORT_PLAYERS     = 1,
    ACTION_KNOCKUP              = 2,
    ACTION_ALLOW_FLY            = 3,
    ACTION_REMOVE_FLY           = 4,

    CREATURE_ARCANE_SPHERE      = 24708
};

class boss_felblood_kaelthas : public CreatureScript
{
public:
    boss_felblood_kaelthas() : CreatureScript("boss_felblood_kaelthas") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_felblood_kaelthasAI(creature);
    }

    struct boss_felblood_kaelthasAI : public ScriptedAI
    {
        boss_felblood_kaelthasAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
            introSpeak = false;
        }

        InstanceScript* instance;
        EventMap events;
        EventMap events2;
        SummonList summons;
        bool introSpeak;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
            instance->SetData(DATA_KAELTHAS_EVENT, NOT_STARTED);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
        }

        void JustSummoned(Creature* summon)
        {
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                if (*itr == summon->GetGUID())
                    return;
            summons.Summon(summon);
        }

        void InitializeAI()
        {
            ScriptedAI::InitializeAI();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
        }

        void JustDied(Unit*)
        {
            instance->SetData(DATA_KAELTHAS_EVENT, DONE);
        }

        void EnterCombat(Unit* /*who*/)
        {
            instance->SetData(DATA_KAELTHAS_EVENT, IN_PROGRESS);
            me->SetInCombatWithZone();

            events.ScheduleEvent(EVENT_SPELL_FIREBALL, 0);
            events.ScheduleEvent(EVENT_SPELL_PHOENIX, 15000);
            events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 22000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);

            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_SHOCK_BARRIER, 50000);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!introSpeak && me->IsWithinDistInMap(who, 40.0f) && who->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_AGGRO);
                introSpeak = true;
                events2.ScheduleEvent(EVENT_INIT_COMBAT, 35000);
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth())
            {
                damage = me->GetHealth()-1;
                if (me->isRegeneratingHealth())
                {
                    me->SetRegeneratingHealth(false);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE|UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    me->CombatStop();
                    me->SetReactState(REACT_PASSIVE);
                    LapseAction(ACTION_REMOVE_FLY);
                    events.Reset();
                    events2.ScheduleEvent(EVENT_FINISH_TALK, 6000);
                    Talk(SAY_DEATH);
                }
            }
        }
        
        void LapseAction(uint8 action)
        {
            uint8 counter = 0;
            Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr, ++counter)
                if (Player* player = itr->GetSource())
                {
                    if (action == ACTION_TELEPORT_PLAYERS)
                        me->CastSpell(player, SPELL_GRAVITY_LAPSE_PLAYER+counter, true);
                    else if (action == ACTION_KNOCKUP)
                        player->CastSpell(player, SPELL_GRAVITY_LAPSE_DOT, true, nullptr, nullptr, me->GetGUID());
                    else if (action == ACTION_ALLOW_FLY)
                        player->CastSpell(player, SPELL_GRAVITY_LAPSE_FLY, true, nullptr, nullptr, me->GetGUID());
                    else if (action == ACTION_REMOVE_FLY)
                    {
                        player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_FLY);
                        player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_DOT);
                    }
                }
        }

        void UpdateAI(uint32 diff)
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_INIT_COMBAT:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    if (Unit* target = SelectTargetFromPlayerList(50.0f))
                        AttackStart(target);
                    return;
                case EVENT_FINISH_TALK:
                    Unit::Kill(me, me);
                    return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (uint32 eventId = events.ExecuteEvent())
            {
                case EVENT_SPELL_FIREBALL:
                    me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_FIREBALL_N, SPELL_FIREBALL_H), false);
                    events.ScheduleEvent(EVENT_SPELL_FIREBALL, urand(3000, 4500));
                    break;
                case EVENT_SPELL_FLAMESTRIKE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    {
                        me->CastSpell(target, SPELL_FLAMESTRIKE_SUMMON, true);
                        Talk(SAY_FLAMESTRIKE);
                    }
                    events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 25000);
                    break;
                case EVENT_SPELL_SHOCK_BARRIER:
                    me->CastSpell(me, SPELL_SHOCK_BARRIER, true);
                    me->CastCustomSpell(SPELL_PYROBLAST, SPELLVALUE_MAX_TARGETS, 1, (Unit*)NULL, false);
                    events.ScheduleEvent(EVENT_SPELL_SHOCK_BARRIER, 50000);
                    break;
                case EVENT_SPELL_PHOENIX:
                    Talk(SAY_PHOENIX);
                    me->CastSpell(me, SPELL_PHOENIX, false);
                    events.ScheduleEvent(EVENT_SPELL_PHOENIX, 60000);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(50))
                    {
                        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                        me->CastSpell(me, SPELL_TELEPORT_CENTER, true);
                        events.Reset();

                        me->StopMoving();
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MoveIdle();

                        events.SetPhase(1);
                        events.ScheduleEvent(EVENT_GRAVITY_LAPSE_1_1, 0);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
                    break;
                case EVENT_GRAVITY_LAPSE_1_1:
                case EVENT_GRAVITY_LAPSE_1_2:
                    Talk(eventId == EVENT_GRAVITY_LAPSE_1_1 ? SAY_GRAVITY_LAPSE : SAY_RECAST_GRAVITY);
                    me->CastSpell(me, SPELL_GRAVITY_LAPSE_INITIAL, false);
                    events.ScheduleEvent(EVENT_GRAVITY_LAPSE_2, 2000);
                    break;
                case EVENT_GRAVITY_LAPSE_2:
                    LapseAction(ACTION_TELEPORT_PLAYERS);
                    events.ScheduleEvent(EVENT_GRAVITY_LAPSE_3, 1000);
                    break;
                case EVENT_GRAVITY_LAPSE_3:
                    LapseAction(ACTION_KNOCKUP);
                    events.ScheduleEvent(EVENT_GRAVITY_LAPSE_4, 1000);
                    break;
                case EVENT_GRAVITY_LAPSE_4:
                    LapseAction(ACTION_ALLOW_FLY);
                    for (uint8 i = 0; i < 3; ++i)
                        me->CastSpell(me, SPELL_SUMMON_ARCANE_SPHERE, true);

                    me->CastSpell(me, SPELL_GRAVITY_LAPSE_CHANNEL, false);
                    events.ScheduleEvent(EVENT_GRAVITY_LAPSE_5, 30000);
                    break;
                case EVENT_GRAVITY_LAPSE_5:
                    LapseAction(ACTION_REMOVE_FLY);
                    me->InterruptNonMeleeSpells(false);
                    Talk(SAY_TIRED);
                    me->CastSpell(me, SPELL_POWER_FEEDBACK, false);
                    events.ScheduleEvent(EVENT_GRAVITY_LAPSE_1_2, 10000);
                    break;
            }


            if (events.GetPhaseMask() == 0)
                DoMeleeAttackIfReady();
        }
    };
};

class spell_mt_phoenix_burn : public SpellScriptLoader
{
    public:
        spell_mt_phoenix_burn() : SpellScriptLoader("spell_mt_phoenix_burn") { }

        class spell_mt_phoenix_burn_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mt_phoenix_burn_SpellScript);

            void HandleAfterCast()
            {
                uint32 damage = CalculatePct(GetCaster()->GetMaxHealth(), 5);
                Unit::DealDamage(GetCaster(), GetCaster(), damage);
            }

            void Register()
            {
                AfterCast += SpellCastFn(spell_mt_phoenix_burn_SpellScript::HandleAfterCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mt_phoenix_burn_SpellScript();
        }
};

void AddSC_boss_felblood_kaelthas()
{
    new boss_felblood_kaelthas();
    new spell_mt_phoenix_burn();
}
