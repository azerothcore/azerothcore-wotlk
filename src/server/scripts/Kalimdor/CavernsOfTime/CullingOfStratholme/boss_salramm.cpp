/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "culling_of_stratholme.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_SHADOW_BOLT_N                         = 57725,
    SPELL_SHADOW_BOLT_H                         = 58827,
    SPELL_STEAL_FLESH_CHANNEL                   = 52708,
    SPELL_STEAL_FLESH_TARGET                    = 52711,
    SPELL_STEAL_FLESH_CASTER                    = 52712,
    SPELL_SUMMON_GHOULS                         = 52451,
    SPELL_EXPLODE_GHOUL_N                       = 52480,
    SPELL_EXPLODE_GHOUL_H                       = 58825,
    SPELL_CURSE_OF_TWISTED_FAITH                = 58845,
};

enum Events
{
    EVENT_SPELL_SHADOW_BOLT                     = 1,
    EVENT_SPELL_STEAL_FLESH                     = 2,
    EVENT_SPELL_SUMMON_GHOULS                   = 3,
    EVENT_EXPLODE_GHOUL                         = 4,
    EVENT_SPELL_CURSE                           = 5,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SPAWN                                   = 1,
    SAY_SLAY                                    = 2,
    SAY_DEATH                                   = 3,
    SAY_EXPLODE_GHOUL                           = 4,
    SAY_STEAL_FLESH                             = 5,
    SAY_SUMMON_GHOULS                           = 6
};

class boss_salramm : public CreatureScript
{
public:
    boss_salramm() : CreatureScript("boss_salramm") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_salrammAI>(creature);
    }

    struct boss_salrammAI : public npc_escortAI
    {
        boss_salrammAI(Creature* c) : npc_escortAI(c), summons(me)
        {
            Talk(SAY_SPAWN);

            AddWaypoint(1, 2349.07f, 1181.84f, 130.416f, 0);
            AddWaypoint(2, 2240.9f, 1173.33f, 137.171f, 0);
            AddWaypoint(3, 2171.15f, 1251.85f, 135.168f, 0);
            AddWaypoint(4, 2180.95f, 1329.96f, 129.991f, 0);
            AddWaypoint(5, 2219.12f, 1331.17f, 128.11f, 0);
            AddWaypoint(6, 2139.14f, 1351.94f, 132.072f, 0);
            AddWaypoint(7, 2186.49f, 1335.78f, 130.049f, 0);
            AddWaypoint(8, 2170.9f, 1255.13f, 134.816f, 0);
            AddWaypoint(9, 2245.52f, 1169.46f, 137.59f, 0);
            AddWaypoint(10, 2325.94f, 1176.1f, 132.979f, 0);
            AddWaypoint(11, 2351.52f, 1197.95f, 130.444f, 0);

            Start(true, false, 0, NULL, false, true);
        }

        EventMap events;
        SummonList summons;
        void Reset() 
        { 
            events.Reset();
            summons.DespawnAll();
        }

        void WaypointReached() { }

        void JustSummoned(Creature* cr) { summons.Summon(cr); }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 7000);
            events.ScheduleEvent(EVENT_SPELL_STEAL_FLESH, 11000);
            events.ScheduleEvent(EVENT_SPELL_SUMMON_GHOULS, 16000);
            events.ScheduleEvent(EVENT_EXPLODE_GHOUL, 22000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_CURSE, 25000);
        }

        void JustDied(Unit* /*killer*/)
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit*  /*victim*/)
        {
            if (!urand(0,1))
                return;

            Talk(SAY_SLAY);
        }

        void ExplodeGhoul()
        {
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                if (Creature* cr = ObjectAccessor::GetCreature(*me, (*itr)))
                    if (cr->IsAlive())
                    {
                        me->CastSpell(cr, DUNGEON_MODE(SPELL_EXPLODE_GHOUL_N, SPELL_EXPLODE_GHOUL_H), false);
                        return;
                    }
        }

        void UpdateEscortAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_SHADOW_BOLT:
                    me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_SHADOW_BOLT_N, SPELL_SHADOW_BOLT_H), false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_SPELL_STEAL_FLESH:
                    if (!urand(0,2))
                        Talk(SAY_STEAL_FLESH);
                    me->CastSpell(me->GetVictim(), SPELL_STEAL_FLESH_CHANNEL, false);
                    events.RepeatEvent(12000);
                    break;
                case EVENT_SPELL_SUMMON_GHOULS:
                    if (!urand(0,2))
                        Talk(SAY_SUMMON_GHOULS);
                    me->CastSpell(me, SPELL_SUMMON_GHOULS, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_EXPLODE_GHOUL:
                    if (!urand(0,2))
                        Talk(SAY_EXPLODE_GHOUL);
                    ExplodeGhoul();
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SPELL_CURSE:
                    me->CastSpell(me->GetVictim(), SPELL_CURSE_OF_TWISTED_FAITH, false);
                    events.RepeatEvent(30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

};

class spell_boss_salramm_steal_flesh : public SpellScriptLoader
{
    public:
        spell_boss_salramm_steal_flesh() : SpellScriptLoader("spell_boss_salramm_steal_flesh") { }

        class spell_boss_salramm_steal_flesh_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_boss_salramm_steal_flesh_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* caster = GetCaster();
                Unit* target = GetUnitOwner();
                if (caster)
                {
                    caster->CastSpell(caster, SPELL_STEAL_FLESH_CASTER, true);
                    caster->CastSpell(target, SPELL_STEAL_FLESH_TARGET, true);
                }
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_boss_salramm_steal_flesh_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_boss_salramm_steal_flesh_AuraScript();
        }
};

void AddSC_boss_salramm()
{
    new boss_salramm();
    new spell_boss_salramm_steal_flesh();
}
