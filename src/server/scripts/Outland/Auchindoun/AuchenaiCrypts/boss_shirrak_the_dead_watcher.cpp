/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"
#include "SpellScript.h"
#include "SpellAuras.h"

enum eShirrak
{

    SPELL_INHIBIT_MAGIC                 = 32264,
    SPELL_ATTRACT_MAGIC                 = 32265,
    SPELL_CARNIVOROUS_BITE_N            = 36383,
    SPELL_CARNIVOROUS_BITE_H            = 39382,

    SPELL_FIERY_BLAST_N                 = 32302,
    SPELL_FIERY_BLAST_H                 = 38382,
    SPELL_FOCUS_FIRE_VISUAL             = 32286,
    SPELL_FOCUS_CAST                    = 32300,

    EVENT_SPELL_INHIBIT_MAGIC           = 1,
    EVENT_SPELL_ATTRACT_MAGIC           = 2,
    EVENT_SPELL_CARNIVOROUS             = 3,
    EVENT_SPELL_FOCUS_FIRE              = 4,
    EVENT_SPELL_FOCUS_FIRE_2            = 5,
    EVENT_SPELL_FOCUS_FIRE_3            = 6,

    ENTRY_FOCUS_FIRE                    = 18374,

    EMOTE_FOCUSED                       = 0
};

class boss_shirrak_the_dead_watcher : public CreatureScript
{
public:
    boss_shirrak_the_dead_watcher() : CreatureScript("boss_shirrak_the_dead_watcher") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_shirrak_the_dead_watcherAI (creature);
    }

    struct boss_shirrak_the_dead_watcherAI : public ScriptedAI
    {
        boss_shirrak_the_dead_watcherAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        EventMap events;
        uint64 focusGUID;

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode();
        }

        void Reset()
        {
            events.Reset();
            focusGUID = 0;
            me->SetControlled(false, UNIT_STATE_ROOT);
        }

        void EnterCombat(Unit*)
        {
            events.ScheduleEvent(EVENT_SPELL_INHIBIT_MAGIC, 0);
            events.ScheduleEvent(EVENT_SPELL_ATTRACT_MAGIC, 28000);
            events.ScheduleEvent(EVENT_SPELL_CARNIVOROUS, 10000);
            events.ScheduleEvent(EVENT_SPELL_FOCUS_FIRE, 17000);
        }

        void JustSummoned(Creature* summon)
        {
            summon->CastSpell(summon, SPELL_FOCUS_FIRE_VISUAL, true);
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_FOCUS_CAST)
                target->CastSpell(target, DUNGEON_MODE(SPELL_FIERY_BLAST_N, SPELL_FIERY_BLAST_H), false);
        }

        uint8 getStackCount(float dist)
        {
            if (dist < 15)
                return 4;
            if (dist < 25)
                return 3;
            if (dist < 35)
                return 2;
            return 1;
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            uint32 eventId = events.GetEvent();

            if (eventId == EVENT_SPELL_INHIBIT_MAGIC)
            {
                Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    if (Player* player = i->GetSource())
                    {
                        float dist = me->GetDistance(player);
                        if (player->IsAlive() && dist < 45.0f)
                        {
                            Aura* aura = player->GetAura(SPELL_INHIBIT_MAGIC);
                            if (!aura)
                                aura = me->AddAura(SPELL_INHIBIT_MAGIC, player);
                            else
                                aura->RefreshDuration();

                            if (aura)
                                aura->SetStackAmount(getStackCount(dist));
                        }
                        else
                            player->RemoveAurasDueToSpell(SPELL_INHIBIT_MAGIC);
                    }
                events.RepeatEvent(3000);
                return;
            }

            if (!UpdateVictim())
                return;


            switch (eventId)
            {
                case EVENT_SPELL_ATTRACT_MAGIC:
                    me->CastSpell(me, SPELL_ATTRACT_MAGIC, false);
                    events.RepeatEvent(30000);
                    events.RescheduleEvent(EVENT_SPELL_CARNIVOROUS, 1500);
                    break;
                case EVENT_SPELL_CARNIVOROUS:
                    me->CastSpell(me, DUNGEON_MODE(SPELL_CARNIVOROUS_BITE_N, SPELL_CARNIVOROUS_BITE_H), false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_SPELL_FOCUS_FIRE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                    {
                        if (Creature* cr = me->SummonCreature(ENTRY_FOCUS_FIRE, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 7000))
                            focusGUID = cr->GetGUID();
                        Talk(EMOTE_FOCUSED, target);
                    }
                    events.RepeatEvent(urand(15000, 20000));
                    events.ScheduleEvent(EVENT_SPELL_FOCUS_FIRE_2, 3000);
                    events.ScheduleEvent(EVENT_SPELL_FOCUS_FIRE_2, 3500);
                    events.ScheduleEvent(EVENT_SPELL_FOCUS_FIRE_2, 4000);
                    events.ScheduleEvent(EVENT_SPELL_FOCUS_FIRE_3, 5000);
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    break;
                case EVENT_SPELL_FOCUS_FIRE_2:
                    if (Unit* flare = ObjectAccessor::GetCreature(*me, focusGUID))
                        me->CastSpell(flare, SPELL_FOCUS_CAST, true);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_FOCUS_FIRE_3:
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_auchenai_possess : public SpellScriptLoader
{
    public:
        spell_auchenai_possess() : SpellScriptLoader("spell_auchenai_possess") { }

        class spell_auchenai_possess_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_auchenai_possess_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                    if (Unit* target = GetTarget())
                        caster->CastSpell(target, 32830 /*POSSESS*/, true);
            }

            void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
            {
                isPeriodic = true;
                amplitude = 2000;
            }

            void Update(AuraEffect*  /*effect*/)
            {
                // Xinef: Charm is removed when target is at or below 50%hp
                if (Unit* owner = GetUnitOwner())
                    if (owner->GetHealthPct() <= 50)
                        SetDuration(0);
            }

            void Register()
            {
                // Base channel
                if (m_scriptSpellId == 33401)
                    OnEffectRemove += AuraEffectRemoveFn(spell_auchenai_possess_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
                else
                {
                    DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_auchenai_possess_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_MOD_CHARM);
                    OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_auchenai_possess_AuraScript::Update, EFFECT_0, SPELL_AURA_MOD_CHARM);
                }
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_auchenai_possess_AuraScript();
        }
};

void AddSC_boss_shirrak_the_dead_watcher()
{
    new boss_shirrak_the_dead_watcher();
    new spell_auchenai_possess();
}
