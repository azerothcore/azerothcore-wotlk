/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"
#include "PassiveAI.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_POISON_CLOUD                      = 28240,
    SPELL_MUTATING_INJECTION                = 28169,
    SPELL_SLIME_SPRAY_10                    = 28157,
    SPELL_SLIME_SPRAY_25                    = 54364,
    SPELL_POISON_CLOUD_DAMAGE_AURA_10       = 28158,
    SPELL_POISON_CLOUD_DAMAGE_AURA_25       = 54362,
    SPELL_BERSERK                           = 26662,

    SPELL_BOMBARD_SLIME                     = 28280, // Spawn slime when hit by slime spray
};

enum Events
{
    EVENT_SPELL_BERSERK                     = 1,
    EVENT_SPELL_POISON_CLOUD                = 2,
    EVENT_SPELL_SLIME_SPRAY                 = 3,
    EVENT_SPELL_MUTATING_INJECTION          = 4,
};

enum Misc
{
    NPC_FALLOUT_SLIME                       = 16290,
    NPC_SEWAGE_SLIME                        = 16375,
};

class boss_grobbulus : public CreatureScript
{
public:
    boss_grobbulus() : CreatureScript("boss_grobbulus") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_grobbulusAI (pCreature);
    }

    struct boss_grobbulusAI : public BossAI
    {
        boss_grobbulusAI(Creature *c) : BossAI(c, BOSS_GROBBULUS), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;
        uint32 dropSludgeTimer;

        void Reset()
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            dropSludgeTimer = 0;
        }

        void EnterCombat(Unit * who)
        {
            BossAI::EnterCombat(who);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_SPELL_POISON_CLOUD, 15000);
            events.ScheduleEvent(EVENT_SPELL_MUTATING_INJECTION, 20000);
            events.ScheduleEvent(EVENT_SPELL_SLIME_SPRAY, 10000);
            events.ScheduleEvent(EVENT_SPELL_BERSERK, RAID_MODE(12*MINUTE*IN_MILLISECONDS, 9*MINUTE*IN_MILLISECONDS));
        }

        void SpellHitTarget(Unit *target, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == RAID_MODE(SPELL_SLIME_SPRAY_10, SPELL_SLIME_SPRAY_25) && target->GetTypeId() == TYPEID_PLAYER)
                me->SummonCreature(NPC_FALLOUT_SLIME, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ());
        }

        void JustSummoned(Creature* cr)
        {
            if (cr->GetEntry() == NPC_FALLOUT_SLIME)
                cr->SetInCombatWithZone();

            summons.Summon(cr);
        }

        void SummonedCreatureDespawn(Creature* summon){ summons.Despawn(summon); }

        void JustDied(Unit*  killer)
        {
            BossAI::JustDied(killer);
            summons.DespawnAll();
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void UpdateAI(uint32 diff)
        {
            // Some nice visuals
            dropSludgeTimer += diff;
            if (!me->IsInCombat() && dropSludgeTimer >= 5000)
            {
                if (me->IsWithinDist3d(3178, -3305, 319, 5.0f) && !summons.HasEntry(NPC_SEWAGE_SLIME))
                    me->CastSpell(3128.96f+irand(-20, 20), -3312.96f+irand(-20, 20), 293.25f, SPELL_BOMBARD_SLIME, false);

                dropSludgeTimer = 0;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_POISON_CLOUD:
                    me->CastSpell(me, SPELL_POISON_CLOUD, true);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SPELL_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_SLIME_SPRAY:
                    me->MonsterTextEmote("Grobbulus sprays slime across the room!", 0, true);
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_SLIME_SPRAY_10, SPELL_SLIME_SPRAY_25), false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_MUTATING_INJECTION:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true, -SPELL_MUTATING_INJECTION))
                        me->CastSpell(target, SPELL_MUTATING_INJECTION, false);

                    events.RepeatEvent(8000 + uint32(120 * me->GetHealthPct()));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_grobbulus_poison_cloud : public CreatureScript
{
public:
    boss_grobbulus_poison_cloud() : CreatureScript("boss_grobbulus_poison_cloud") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_grobbulus_poison_cloudAI(pCreature);
    }

    struct boss_grobbulus_poison_cloudAI : public NullCreatureAI
    {
        boss_grobbulus_poison_cloudAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
        }

        uint32 sizeTimer;
        uint32 auraVisualTimer;

        void Reset()
        {
            sizeTimer = 0;
            auraVisualTimer = 1;
            me->SetFloatValue(UNIT_FIELD_COMBATREACH, 2.0f);
            me->setFaction(21); // Grobbulus one    
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER && me->GetInstanceScript())
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void UpdateAI(uint32 diff)
        {
            // this has to be delayed to be visible :/
            if (auraVisualTimer)
            {
                auraVisualTimer += diff;
                if (auraVisualTimer >= 1000)
                {
                    me->CastSpell(me, (me->GetMap()->Is25ManRaid() ? SPELL_POISON_CLOUD_DAMAGE_AURA_25 : SPELL_POISON_CLOUD_DAMAGE_AURA_10), true);
                    auraVisualTimer = 0;
                }
            }

            sizeTimer += diff;
            // increase size to 15yd in 60 seconds, 0.00025 is the growth of size in 1ms
            me->SetFloatValue(UNIT_FIELD_COMBATREACH, 2.0f+(0.00025f*sizeTimer));
        }
    };

};

class spell_grobbulus_poison : public SpellScriptLoader
{
    public:
        spell_grobbulus_poison() : SpellScriptLoader("spell_grobbulus_poison") { }

        class spell_grobbulus_poison_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_grobbulus_poison_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                std::list<WorldObject*> tmplist;
                for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    if (GetCaster()->IsWithinDist3d((*itr), 0.0f))
                        tmplist.push_back(*itr);

                 targets.clear();
                 for( std::list<WorldObject*>::iterator itr = tmplist.begin(); itr != tmplist.end(); ++itr )
                     targets.push_back(*itr);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_grobbulus_poison_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_grobbulus_poison_SpellScript();
        }
};

void AddSC_boss_grobbulus()
{
    new boss_grobbulus();
    new boss_grobbulus_poison_cloud();
    new spell_grobbulus_poison();
}