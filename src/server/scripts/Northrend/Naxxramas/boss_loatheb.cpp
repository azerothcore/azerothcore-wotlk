/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Spells
{
    SPELL_NECROTIC_AURA                         = 55593,
    SPELL_SUMMON_SPORE                          = 29234,
    SPELL_DEATHBLOOM_10                         = 29865,
    SPELL_DEATHBLOOM_25                         = 55053,
    SPELL_INEVITABLE_DOOM_10                    = 29204,
    SPELL_INEVITABLE_DOOM_25                    = 55052,
    SPELL_BERSERK                               = 26662,
};

enum Events
{
    EVENT_SPELL_NECROTIC_AURA                   = 1,
    EVENT_SPELL_DEATHBLOOM                      = 2,
    EVENT_SPELL_INEVITABLE_DOOM                 = 3,
    EVENT_SPELL_BERSERK                         = 4,
};

enum Texts
{
    SAY_NECROTIC_AURA_APPLIED       = 0,
    SAY_NECROTIC_AURA_REMOVED       = 1,
    SAY_NECROTIC_AURA_FADING        = 2,
};

class boss_loatheb : public CreatureScript
{
public:
    boss_loatheb() : CreatureScript("boss_loatheb") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_loathebAI (pCreature);
    }

    struct boss_loathebAI : public BossAI
    {
        boss_loathebAI(Creature *c) : BossAI(c, BOSS_LOATHEB)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            BossAI::Reset();
            events.Reset();
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_LOATHEB_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void JustSummoned(Creature* cr) { cr->SetInCombatWithZone(); }

        void SummonedCreatureDies(Creature*  /*cr*/, Unit*)
        {
            if (pInstance)
                pInstance->SetData(DATA_SPORE_KILLED, 0);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void EnterCombat(Unit * who)
        {
            BossAI::EnterCombat(who);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_LOATHEB_GATE)))
                    go->SetGoState(GO_STATE_READY);
            }

            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_SPELL_NECROTIC_AURA, 0);
            events.ScheduleEvent(EVENT_SPELL_DEATHBLOOM, 25000);
            events.ScheduleEvent(EVENT_SPELL_INEVITABLE_DOOM, 120000);
            events.ScheduleEvent(EVENT_SPELL_BERSERK, 720000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_NECROTIC_AURA:
                    me->CastSpell(me, SPELL_NECROTIC_AURA, true);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_DEATHBLOOM:
                    me->CastSpell(me, SPELL_SUMMON_SPORE, true);
                    me->CastSpell(me, RAID_MODE(SPELL_DEATHBLOOM_10, SPELL_DEATHBLOOM_25), false);
                    events.RepeatEvent(30000);
                    break;
                case EVENT_SPELL_INEVITABLE_DOOM:
                    me->CastSpell(me, RAID_MODE(SPELL_INEVITABLE_DOOM_10, SPELL_INEVITABLE_DOOM_25), false);
                    events.RepeatEvent(events.GetTimer() < 5*MINUTE*IN_MILLISECONDS ? 30000 : 15000);
                    break;
                case EVENT_SPELL_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_loatheb_necrotic_aura_warning : public SpellScriptLoader
{
    public:
        spell_loatheb_necrotic_aura_warning() : SpellScriptLoader("spell_loatheb_necrotic_aura_warning") { }

        class spell_loatheb_necrotic_aura_warning_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_loatheb_necrotic_aura_warning_AuraScript);

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Creature* target = GetTarget()->ToCreature();
                if (target->IsAIEnabled)
                    target->AI()->Talk(SAY_NECROTIC_AURA_APPLIED);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Creature* target = GetTarget()->ToCreature();
                if (target->IsAIEnabled)
                    target->AI()->Talk(SAY_NECROTIC_AURA_REMOVED);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_loatheb_necrotic_aura_warning_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_loatheb_necrotic_aura_warning_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_loatheb_necrotic_aura_warning_AuraScript();
        }
};

void AddSC_boss_loatheb()
{
    new boss_loatheb();
    new spell_loatheb_necrotic_aura_warning();
}
