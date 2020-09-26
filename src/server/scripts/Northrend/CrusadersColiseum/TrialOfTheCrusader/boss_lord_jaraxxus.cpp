/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "trial_of_the_crusader.h"
#include "SpellScript.h"
#include "SpellAuras.h"

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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_jaraxxusAI(pCreature);
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

        void Reset()
        {
            events.Reset();
            if( pInstance )
                pInstance->SetData(TYPE_JARAXXUS, NOT_STARTED);

            // checked for safety
            while( Creature* c = me->FindNearestCreature(NPC_INFERNAL_VOLCANO, 500.0f, true) )
                c->DespawnOrUnsummon();
            while( Creature* c = me->FindNearestCreature(NPC_NETHER_PORTAL, 500.0f, true) )
                c->DespawnOrUnsummon();
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->setActive(true);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_FEL_FIREBALL, 5000);
            events.RescheduleEvent(EVENT_SPELL_FEL_LIGHTNING, urand(10000,15000));
            events.RescheduleEvent(EVENT_SPELL_INCINERATE_FLESH, urand(24000,26000));
            events.RescheduleEvent(EVENT_SPELL_NETHER_POWER, urand(25000,45000));
            events.RescheduleEvent(EVENT_SPELL_LEGION_FLAME, 30000);
            //if( GetDifficulty() == RAID_DIFFICULTY_25MAN_HEROIC )
            //  events.RescheduleEvent(EVENT_SPELL_TOUCH_OF_JARAXXUS, urand(10000,15000));
            events.RescheduleEvent(EVENT_SUMMON_NETHER_PORTAL, 20000); // it schedules EVENT_SUMMON_VOLCANO

            me->RemoveAura(SPELL_CHAINS);
            Talk(SAY_AGGRO);
            DoZoneInCombat();
            if( pInstance )
                pInstance->SetData(TYPE_JARAXXUS, IN_PROGRESS);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
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
                            case 0: id = 66228; break;
                            case 1: id = 67106; break;
                            case 2: id = 67107; break;
                            case 3: id = 67108; break;
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

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_FEL_FIREBALL:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_FEL_FIREBALL, false);
                    events.RepeatEvent(urand(10000,15000));
                    break;
                case EVENT_SPELL_FEL_LIGHTNING:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true) )
                        me->CastSpell(target, SPELL_FEL_LIGHTNING, false);
                    events.RepeatEvent(urand(10000,15000));
                    break;
                case EVENT_SPELL_INCINERATE_FLESH:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true) )
                    {
                        Talk(EMOTE_INCINERATE, target);
                        Talk(SAY_INCINERATE);
                        me->CastSpell(target, SPELL_INCINERATE_FLESH, false);
                    }
                    events.RepeatEvent(urand(20000,25000));
                    break;
                case EVENT_SPELL_NETHER_POWER:
                    me->CastSpell(me, SPELL_NETHER_POWER, false);
                    events.DelayEvents(5000);
                    events.RepeatEvent(urand(25000,45000));
                    break;
                case EVENT_SPELL_LEGION_FLAME:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true) )
                    {
                        Talk(EMOTE_LEGION_FLAME, target);
                        me->CastSpell(target, SPELL_LEGION_FLAME, false);
                    }
                    events.RepeatEvent(30000);
                    break;
                case EVENT_SPELL_TOUCH_OF_JARAXXUS:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true) )
                        me->CastSpell(target, SPELL_TOUCH_OF_JARAXXUS, false);
                    events.RepeatEvent(urand(10000,15000));
                    break;
                case EVENT_SUMMON_NETHER_PORTAL:
                    Talk(EMOTE_NETHER_PORTAL);
                    Talk(SAY_MISTRESS_OF_PAIN);
                    me->CastSpell((Unit*)NULL, SPELL_SUMMON_NETHER_PORTAL, false);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_SUMMON_VOLCANO, 60000);
                    break;
                case EVENT_SUMMON_VOLCANO:
                    Talk(EMOTE_INFERNAL_ERUPTION);
                    Talk(SAY_INFERNAL_ERUPTION);
                    me->CastSpell((Unit*)NULL, SPELL_SUMMON_VOLCANO, false);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_SUMMON_NETHER_PORTAL, 60000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/)
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);
            if( pInstance )
                pInstance->SetData(TYPE_JARAXXUS, DONE);
        }

        void JustReachedHome()
        {
            me->setActive(false);
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
        }

        void EnterEvadeMode()
        {
            events.Reset();
            summons.DespawnAll();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if( pInstance )
                pInstance->SetData(TYPE_FAILED, 1);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}
    };
};

class npc_fel_infernal : public CreatureScript
{
public:
    npc_fel_infernal() : CreatureScript("npc_fel_infernal") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_fel_infernalAI(pCreature);
    }

    struct npc_fel_infernalAI : public ScriptedAI
    {
        npc_fel_infernalAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        EventMap events;

        void Reset()
        {
            if( Unit* target = me->SelectNearestTarget(200.0f) )
            {
                AttackStart(target);
                DoZoneInCombat();
            }
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_FEL_STEAK, urand(7000,20000));
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_FEL_STEAK:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 44.0f, true) )
                    {
                        DoResetThreat();
                        me->AddThreat(target, 50000.0f);
                        me->CastSpell(target, SPELL_FEL_STEAK_MORPH, true);
                        me->CastSpell(target, SPELL_FEL_STEAK, true);
                        events.RepeatEvent(30000);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            me->DespawnOrUnsummon(10000);
        }

        void EnterEvadeMode()
        {
            me->DespawnOrUnsummon();
        }
    };

};

class npc_mistress_of_pain : public CreatureScript
{
public:
    npc_mistress_of_pain() : CreatureScript("npc_mistress_of_pain") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_mistress_of_painAI(pCreature);
    }

    struct npc_mistress_of_painAI : public ScriptedAI
    {
        npc_mistress_of_painAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        EventMap events;

        void Reset()
        {
            if( Unit* target = me->SelectNearestTarget(200.0f) )
            {
                AttackStart(target);
                DoZoneInCombat();
            }
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHIVAN_SLASH, urand(10000,20000));
            events.RescheduleEvent(EVENT_SPELL_SPINNING_PAIN_SPIKE, urand(22000,30000));
            if( IsHeroic() )
                events.RescheduleEvent(EVENT_SPELL_MISTRESS_KISS, urand(10000,15000));
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo*  /*spell*/)
        {
            //if (caster && spell && spell->Id == 66287 /*control vehicle*/)
            //  caster->ClearUnitState(UNIT_STATE_ONVEHICLE);
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SHIVAN_SLASH:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_SHIVAN_SLASH, false);
                    events.RepeatEvent(urand(15000,25000));
                    break;
                case EVENT_SPELL_SPINNING_PAIN_SPIKE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 140.0f, true) )
                        me->CastSpell(target, SPELL_SPINNING_PAIN_SPIKE, false);
                    events.RepeatEvent(urand(25000,30000));
                    break;
                case EVENT_SPELL_MISTRESS_KISS:
                    me->CastSpell((Unit*)NULL, SPELL_MISTRESS_KISS, false);
                    events.RepeatEvent(urand(25000,35000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            me->DespawnOrUnsummon(10000);
        }

        void EnterEvadeMode()
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

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            if (Unit* caster = GetCaster())
                if (Unit* target = GetTarget())
                    if( target->HasUnitState(UNIT_STATE_CASTING) )
                    {
                        caster->CastSpell(target, 66359, true);
                        SetDuration(0);
                    }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_toc25_mistress_kiss_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript *GetAuraScript() const
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
                targets.remove_if(acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
                targets.remove_if(acore::PowerCheck(POWER_MANA, false));
                if (targets.empty())
                    return;

                WorldObject* target = acore::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->CastSpell(GetHitUnit(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mistress_kiss_area_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_mistress_kiss_area_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
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
