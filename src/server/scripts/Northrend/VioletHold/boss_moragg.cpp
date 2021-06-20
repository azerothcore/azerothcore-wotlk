/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "violet_hold.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"

enum eSpells
{
    SPELL_RAY_OF_SUFFERING_N                = 54442,
    SPELL_RAY_OF_SUFFERING_H                = 59524,
    //SPELL_RAY_OF_SUFFERING_TRIGGERED      = 54417,

    SPELL_RAY_OF_PAIN_N                     = 54438,
    SPELL_RAY_OF_PAIN_H                     = 59523,
    //SPELL_RAY_OF_PAIN_TRIGGERED_N         = 54416,
    //SPELL_RAY_OF_PAIN_TRIGGERED_H         = 59525,

    SPELL_CORROSIVE_SALIVA                  = 54527,
    SPELL_OPTIC_LINK                        = 54396,
};

#define SPELL_RAY_OF_SUFFERING              DUNGEON_MODE(SPELL_RAY_OF_SUFFERING_N, SPELL_RAY_OF_SUFFERING_H)
#define SPELL_RAY_OF_PAIN                   DUNGEON_MODE(SPELL_RAY_OF_PAIN_N, SPELL_RAY_OF_PAIN_H)

enum eEvents
{
    EVENT_SPELL_CORROSIVE_SALIVA = 1,
    EVENT_SPELL_OPTIC_LINK,
};

class boss_moragg : public CreatureScript
{
public:
    boss_moragg() : CreatureScript("boss_moragg") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_moraggAI (pCreature);
    }

    struct boss_moraggAI : public ScriptedAI
    {
        boss_moraggAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoZoneInCombat();
            me->CastSpell(me, SPELL_RAY_OF_SUFFERING, true);
            me->CastSpell(me, SPELL_RAY_OF_PAIN, true);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_CORROSIVE_SALIVA, urand(4000,6000));
            events.RescheduleEvent(EVENT_SPELL_OPTIC_LINK, urand(10000,11000));
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_CORROSIVE_SALIVA:
                    me->CastSpell(me->GetVictim(), SPELL_CORROSIVE_SALIVA, false);
                    events.RepeatEvent(urand(8000,10000));
                    break;
                case EVENT_SPELL_OPTIC_LINK:
                    if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 40.0f, true))
                    {
                        me->CastSpell(target, SPELL_OPTIC_LINK, false);
                        events.RepeatEvent(urand(18000,21000));
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

class spell_optic_link : public SpellScriptLoader
{
public:
    spell_optic_link() : SpellScriptLoader("spell_optic_link") { }

    class spell_optic_linkAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_optic_linkAuraScript)

        void HandleEffectPeriodic(AuraEffect const * aurEff)
        {
            if (Unit* target = GetTarget())
                if (Unit* caster = GetCaster())
                    if (GetAura() && GetAura()->GetEffect(0))
                        GetAura()->GetEffect(0)->SetAmount(aurEff->GetSpellInfo()->Effects[EFFECT_0].BasePoints+(((int32)target->GetExactDist(caster))*25)+(aurEff->GetTickNumber()*100));
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_optic_linkAuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_optic_linkAuraScript();
    }
};

void AddSC_boss_moragg()
{
    new boss_moragg();
    new spell_optic_link();
}
