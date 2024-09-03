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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_crusader.h"

enum JaraxxusTexts
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    EMOTE_LEGION_FLAME      = 2,
    EMOTE_NETHER_PORTAL     = 3,
    SAY_MISTRESS_OF_PAIN    = 4,
    EMOTE_INCINERATE        = 5,
    SAY_INCINERATE          = 6,
    EMOTE_INFERNAL_ERUPTION = 7,
    SAY_INFERNAL_ERUPTION   = 8,
    SAY_KILL_PLAYER         = 9,
    SAY_DEATH               = 10,
    SAY_BERSERK             = 11,
};

enum JaraxxusNPCs
{
    NPC_LEGION_FLAME                    = 34784,
    NPC_INFERNAL_VOLCANO                = 34813,
    NPC_FEL_INFERNAL                    = 34815,
    NPC_NETHER_PORTAL                   = 34825,
    NPC_MISTRESS_OF_PAIN                = 34826,
};

enum JaraxxusSpells
{
    SPELL_NETHER_POWER                  = 66228,
    SPELL_INCINERATE_FLESH              = 66237,
    SPELL_FEL_FIREBALL                  = 66532,
    SPELL_FEL_LIGHTNING                 = 66528,
    SPELL_TOUCH_OF_JARAXXUS             = 66209,
    SPELL_LEGION_FLAME                  = 66197,
    SPELL_LEGION_FLAME_NPC_AURA         = 66201,
    SPELL_SUMMON_VOLCANO                = 66258,
    SPELL_SUMMON_NETHER_PORTAL          = 66269,

    SPELL_FEL_STEAK                     = 66494,
    SPELL_FEL_STEAK_MORPH               = 66493,

    SPELL_SHIVAN_SLASH                  = 66378,
    SPELL_SPINNING_PAIN_SPIKE           = 66283,
    SPELL_MISTRESS_KISS                 = 66336,
    SPELL_MISTRESS_KISS_PERIODIC_DUMMY  = 66334, // also 67905, 67906, 67907
    SPELL_MISTRESS_KISS_INTERRUPT       = 66359,

    SPELL_CHAINS                        = 67924,
    SPELL_BERSERK                       = 64238,
};

enum JaraxxusEvents
{
    EVENT_SPELL_FEL_FIREBALL = 1,
    EVENT_SPELL_FEL_LIGHTNING,
    EVENT_SPELL_INCINERATE_FLESH,
    EVENT_SPELL_NETHER_POWER,
    EVENT_SPELL_LEGION_FLAME,
    EVENT_SPELL_TOUCH_OF_JARAXXUS,
    EVENT_SUMMON_VOLCANO,
    EVENT_SUMMON_NETHER_PORTAL,

    EVENT_SPELL_FEL_STEAK,

    EVENT_SPELL_SHIVAN_SLASH,
    EVENT_SPELL_SPINNING_PAIN_SPIKE,
    EVENT_SPELL_MISTRESS_KISS,
};

class boss_jaraxxus : public CreatureScript
{
public:
    boss_jaraxxus() : CreatureScript("boss_jaraxxus") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_jaraxxusAI>(pCreature);
    }

    struct boss_jaraxxusAI : public ScriptedAI
    {
        boss_jaraxxusAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
            me->SetReactState(REACT_PASSIVE);
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            events.Reset();
            if( pInstance )
                pInstance->SetData(TYPE_JARAXXUS, NOT_STARTED);

            std::list<Creature*> creatures;
            me->GetCreatureListWithEntryInGrid(creatures, NPC_INFERNAL_VOLCANO, 500.f);
            me->GetCreatureListWithEntryInGrid(creatures, NPC_NETHER_PORTAL, 500.f);
            for (Creature* creature : creatures)
                creature->DespawnOrUnsummon();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->setActive(true);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_FEL_FIREBALL, 5s);
            events.RescheduleEvent(EVENT_SPELL_FEL_LIGHTNING, 10s, 15s);
            events.RescheduleEvent(EVENT_SPELL_INCINERATE_FLESH, 24s, 26s);
            events.RescheduleEvent(EVENT_SPELL_NETHER_POWER, 25s, 45s);
            events.RescheduleEvent(EVENT_SPELL_LEGION_FLAME, 30s);
            //if( GetDifficulty() == RAID_DIFFICULTY_25MAN_HEROIC )
            //  events.RescheduleEvent(EVENT_SPELL_TOUCH_OF_JARAXXUS, 10s, 15s);
            events.RescheduleEvent(EVENT_SUMMON_NETHER_PORTAL, 20s); // it schedules EVENT_SUMMON_VOLCANO

            me->RemoveAura(SPELL_CHAINS);
            Talk(SAY_AGGRO);
            DoZoneInCombat();
            if( pInstance )
                pInstance->SetData(TYPE_JARAXXUS, IN_PROGRESS);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            switch( spell->Id )
            {
                case 66228:
                case 67106:
                case 67107:
                case 67108:
                    if( Aura* a = me->GetAura(spell->Id) )
                        a->SetStackAmount(spell->StackAmount);
                    break;
                case 30449:
                    {
                        if( !caster )
                            return;
                        uint32 id = 0;
                        switch( me->GetMap()->GetDifficulty() )
                        {
                            case 0:
                                id = 66228;
                                break;
                            case 1:
                                id = 67106;
                                break;
                            case 2:
                                id = 67107;
                                break;
                            case 3:
                                id = 67108;
                                break;
                        }
                        if( Aura* a = me->GetAura(id) )
                        {
                            if( a->GetStackAmount() > 1 )
                                a->ModStackAmount(-1);
                            else
                                a->Remove();
                            caster->CastSpell(caster, SPELL_NETHER_POWER, true);
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_FEL_FIREBALL:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_FEL_FIREBALL, false);
                    events.Repeat(10s, 15s);
                    break;
                case EVENT_SPELL_FEL_LIGHTNING:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true) )
                        me->CastSpell(target, SPELL_FEL_LIGHTNING, false);
                    events.Repeat(10s, 15s);
                    break;
                case EVENT_SPELL_INCINERATE_FLESH:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true) )
                    {
                        Talk(EMOTE_INCINERATE, target);
                        Talk(SAY_INCINERATE);
                        me->CastSpell(target, SPELL_INCINERATE_FLESH, false);
                    }
                    events.Repeat(20s, 25s);
                    break;
                case EVENT_SPELL_NETHER_POWER:
                    me->CastSpell(me, SPELL_NETHER_POWER, false);
                    events.DelayEvents(5s);
                    events.Repeat(25s, 45s);
                    break;
                case EVENT_SPELL_LEGION_FLAME:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true) )
                    {
                        Talk(EMOTE_LEGION_FLAME, target);
                        me->CastSpell(target, SPELL_LEGION_FLAME, false);
                    }
                    events.Repeat(30s);
                    break;
                case EVENT_SPELL_TOUCH_OF_JARAXXUS:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true) )
                        me->CastSpell(target, SPELL_TOUCH_OF_JARAXXUS, false);
                    events.Repeat(10s, 15s);
                    break;
                case EVENT_SUMMON_NETHER_PORTAL:
                    Talk(EMOTE_NETHER_PORTAL);
                    Talk(SAY_MISTRESS_OF_PAIN);
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_NETHER_PORTAL, false);

                    events.RescheduleEvent(EVENT_SUMMON_VOLCANO, 1min);
                    break;
                case EVENT_SUMMON_VOLCANO:
                    Talk(EMOTE_INFERNAL_ERUPTION);
                    Talk(SAY_INFERNAL_ERUPTION);
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_VOLCANO, false);

                    events.RescheduleEvent(EVENT_SUMMON_NETHER_PORTAL, 1min);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/) override
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);
            if( pInstance )
                pInstance->SetData(TYPE_JARAXXUS, DONE);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            events.Reset();
            summons.DespawnAll();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if( pInstance )
                pInstance->SetData(TYPE_FAILED, 1);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}
    };
};

class npc_fel_infernal : public CreatureScript
{
public:
    npc_fel_infernal() : CreatureScript("npc_fel_infernal") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_fel_infernalAI>(pCreature);
    }

    struct npc_fel_infernalAI : public ScriptedAI
    {
        npc_fel_infernalAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        EventMap events;

        void Reset() override
        {
            if( Unit* target = me->SelectNearestTarget(200.0f) )
            {
                AttackStart(target);
                DoZoneInCombat();
            }
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_FEL_STEAK, 7s, 20s);
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_FEL_STEAK:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 44.0f, true) )
                    {
                        DoResetThreatList();
                        me->AddThreat(target, 50000.0f);
                        me->CastSpell(target, SPELL_FEL_STEAK_MORPH, true);
                        me->CastSpell(target, SPELL_FEL_STEAK, true);
                        events.Repeat(30s);
                    }
                    else
                        events.Repeat(5s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->DespawnOrUnsummon(10000);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->DespawnOrUnsummon();
        }
    };
};

class npc_mistress_of_pain : public CreatureScript
{
public:
    npc_mistress_of_pain() : CreatureScript("npc_mistress_of_pain") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_mistress_of_painAI>(pCreature);
    }

    struct npc_mistress_of_painAI : public ScriptedAI
    {
        npc_mistress_of_painAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        EventMap events;

        void Reset() override
        {
            if( Unit* target = me->SelectNearestTarget(200.0f) )
            {
                AttackStart(target);
                DoZoneInCombat();
            }
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHIVAN_SLASH, 10s, 20s);
            events.RescheduleEvent(EVENT_SPELL_SPINNING_PAIN_SPIKE, 22s, 30s);
            if( IsHeroic() )
                events.RescheduleEvent(EVENT_SPELL_MISTRESS_KISS, 10s, 15s);
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const*  /*spell*/) override
        {
            //if (caster && spell && spell->Id == 66287 /*control vehicle*/)
            //  caster->ClearUnitState(UNIT_STATE_ONVEHICLE);
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SHIVAN_SLASH:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_SHIVAN_SLASH, false);
                    events.Repeat(15s, 25s);
                    break;
                case EVENT_SPELL_SPINNING_PAIN_SPIKE:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 140.0f, true) )
                        me->CastSpell(target, SPELL_SPINNING_PAIN_SPIKE, false);
                    events.Repeat(25s, 30s);
                    break;
                case EVENT_SPELL_MISTRESS_KISS:
                    me->CastSpell((Unit*)nullptr, SPELL_MISTRESS_KISS, false);
                    events.Repeat(25s, 35s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->DespawnOrUnsummon(10000);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->DespawnOrUnsummon();
        }
    };
};

class spell_toc25_mistress_kiss : public SpellScriptLoader
{
public:
    spell_toc25_mistress_kiss() : SpellScriptLoader("spell_toc25_mistress_kiss") { }

    class spell_toc25_mistress_kiss_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_toc25_mistress_kiss_AuraScript)

        void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
        {
            if (Unit* caster = GetCaster())
                if (Unit* target = GetTarget())
                    if( target->HasUnitState(UNIT_STATE_CASTING) )
                    {
                        caster->CastSpell(target, 66359, true);
                        SetDuration(0);
                    }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_toc25_mistress_kiss_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_toc25_mistress_kiss_AuraScript();
    }
};

class spell_mistress_kiss_area : public SpellScriptLoader
{
public:
    spell_mistress_kiss_area() : SpellScriptLoader("spell_mistress_kiss_area") {}

    class spell_mistress_kiss_area_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mistress_kiss_area_SpellScript)

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            // get a list of players with mana
            targets.remove_if(Acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
            targets.remove_if(Acore::PowerCheck(POWER_MANA, false));
            if (targets.empty())
                return;

            WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
            targets.clear();
            targets.push_back(target);
        }

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            GetCaster()->CastSpell(GetHitUnit(), uint32(GetEffectValue()), true);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mistress_kiss_area_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_mistress_kiss_area_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_mistress_kiss_area_SpellScript();
    }
};

void AddSC_boss_jaraxxus()
{
    new boss_jaraxxus();
    new npc_fel_infernal();
    new npc_mistress_of_pain();
    new spell_toc25_mistress_kiss();
    new spell_mistress_kiss_area();
}
