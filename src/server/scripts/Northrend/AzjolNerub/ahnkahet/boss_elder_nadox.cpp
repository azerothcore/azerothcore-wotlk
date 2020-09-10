/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"
#include "SpellAuras.h"
#include "SpellScript.h"

enum Misc
{
    // ACTIONS
    ACTION_GUARDIAN_DIED            = 1,
};

enum Spells
{
    // NADOX
    SPELL_BROOD_PLAGUE              = 56130,
    SPELL_BROOD_PLAGUE_H            = 59467,
    SPELL_BROOD_RAGE_H              = 59465,
    SPELL_ENRAGE                    = 26662, // Enraged if too far away from home
    SPELL_SUMMON_SWARMERS           = 56119, //2x NPC_AHNKAHAR_SWARMER
    SPELL_SUMMON_SWARM_GUARD        = 56120, //1x NPC_AHNKAHAR_GUARDIAN_ENTRY  -- at 50%hp

    // ADDS
    SPELL_SPRINT                    = 56354,
    SPELL_GUARDIAN_AURA             = 56151,
    SPELL_SWARMER_AURA              = 56158,
};

enum Creatures
{
    NPC_AHNKAHAR_SWARMER            = 30178,
    NPC_AHNKAHAR_GUARDIAN_ENTRY     = 30176,
    NPC_AHNKAHAR_SWARM_EGG          = 30172,
    NPC_AHNKAHAR_GUARDIAN_EGG       = 30173,
};

enum Events
{
    EVENT_CHECK_HOME                = 1,
    EVENT_PLAGUE                    = 2,
    EVENT_BROOD_RAGE                = 3,
    EVENT_SWARMER                   = 4,
};

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_DEATH                       = 2,
    SAY_EGG_SAC                     = 3,
    EMOTE_HATCHES                   = 4
};

class boss_elder_nadox : public CreatureScript
{
public:
    boss_elder_nadox() : CreatureScript("boss_elder_nadox") { }

    struct boss_elder_nadoxAI : public BossAI
    {
        boss_elder_nadoxAI(Creature* creature) : BossAI(creature, DATA_PRINCE_TALDARAM),
            previousSwarmEgg_GUID(0),
            guardianSummoned(false)
        {      
        }

        void Reset() override
        {
            guardianSummoned = false;
            _Reset();
            events.ScheduleEvent(EVENT_SWARMER, 10000);
            events.ScheduleEvent(EVENT_CHECK_HOME, 2000);
            events.ScheduleEvent(EVENT_PLAGUE, urand(5000, 8000));
            events.ScheduleEvent(EVENT_BROOD_RAGE, 5000);

            // Clear eggs data
            swarmEggs.clear();
            guardianEggs.clear();
            previousSwarmEgg_GUID = 0;
        }

        void EnterCombat(Unit * /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_AGGRO);

            // Cache eggs
            std::list<Creature*> eggs;
            // Swarm eggs
            me->GetCreatureListWithEntryInGrid(eggs, NPC_AHNKAHAR_SWARM_EGG, 250.0f);
            if (!eggs.empty())
            {
                for (Creature* const egg : eggs)
                {
                    if (egg)
                    {
                        swarmEggs.push_back(egg->GetGUID());
                    }
                }
            }

            eggs.clear();

             // Guardian eggs
            me->GetCreatureListWithEntryInGrid(eggs, NPC_AHNKAHAR_GUARDIAN_EGG, 250.0f);
            if (!eggs.empty())
            {
                for (Creature* const egg : eggs)
                {
                    if (egg)
                    {
                        guardianEggs.push_back(egg->GetGUID());
                    }
                }
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_SLAY);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY)
            {
                Talk(SAY_EGG_SAC);
            }
                
            BossAI::JustSummoned(summon);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*school*/) override
        {
            if (!guardianSummoned && me->HealthBelowPctDamaged(55, damage))
            {
                Talk(EMOTE_HATCHES, me);
                SummonHelpers(false);

                guardianSummoned = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.GetEvent())
            {
                switch (eventId)
                {
                case EVENT_BROOD_RAGE:
                {
                    if (Creature* pSwarmer = me->FindNearestCreature(NPC_AHNKAHAR_SWARMER, 40, true))
                        DoCast(pSwarmer, SPELL_BROOD_RAGE_H, true);

                    events.RepeatEvent(10000);
                    break;
                }
                case EVENT_PLAGUE:
                {
                    DoCastVictim(DUNGEON_MODE(SPELL_BROOD_PLAGUE, SPELL_BROOD_PLAGUE_H), false);
                    events.RepeatEvent(12000 + rand() % 5000);
                    break;
                }
                case EVENT_SWARMER:
                {
                    SummonHelpers(true);
                    events.RepeatEvent(10000);
                    break;
                }
                case EVENT_CHECK_HOME:
                {
                    if (!me->HasAura(SPELL_ENRAGE) && me->GetPositionZ() < 24)
                    {
                        DoCastSelf(SPELL_ENRAGE, true);
                        events.PopEvent();
                        break;
                    }

                    events.RepeatEvent(2000);
                }break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        
        std::list<uint64> swarmEggs;
        std::list<uint64> guardianEggs;
        uint64 previousSwarmEgg_GUID;   // This will prevent casting summoning spells on same egg twice
        bool guardianSummoned;

        void SummonHelpers(bool swarm)
        {
            if (swarm)
            {
                if (swarmEggs.empty())
                {
                    return;
                }

                // Make a copy of guid list
                std::list<uint64> swarmEggs2(warmEggs);

                // Remove previous egg
                if (previousSwarmEgg_GUID)
                {
                    std::list<uint64>::iterator itr = std::find(swarmEggs2.begin(), swarmEggs2.end(), previousSwarmEgg_GUID);
                    if (itr != swarmEggs2.end())
                    {
                        swarmEggs2.erase(itr);
                    }
                }

                if (swarmEggs2.empty())
                {
                    return;
                }

                previousSwarmEgg_GUID = acore::Containers::SelectRandomContainerElement(swarmEggs2);

                if (Creature* egg = ObjectAccessor::GetCreature(*me, previousSwarmEgg_GUID))
                {
                    egg->CastSpell(egg, SPELL_SUMMON_SWARMERS, true, nullptr, nullptr, me->GetGUID());
                }
            }
            else
            {
                if (guardianEggs.empty())
                {
                    return;
                }

                uint64 const guardianEggGUID = acore::Containers::SelectRandomContainerElement(guardianEggs);
                if (Creature* egg = ObjectAccessor::GetCreature(*me, guardianEggGUID))
                {
                    egg->CastSpell(egg, SPELL_SUMMON_SWARM_GUARD, true, nullptr, nullptr, me->GetGUID());
                }
            }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_elder_nadoxAI(creature);
    }
};

class npc_ahnkahar_nerubian : public CreatureScript
{
public:
    npc_ahnkahar_nerubian() : CreatureScript("npc_ahnkahar_nerubian") { }

    struct npc_ahnkahar_nerubianAI : public ScriptedAI
    {
        npc_ahnkahar_nerubianAI(Creature *c) : ScriptedAI(c) { }

        void Reset()
        {
            if (me->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY)
            {
                DoCastSelf(SPELL_GUARDIAN_AURA, true);
            }
            else // Swarmers
            {
                DoCastSelf(SPELL_SWARMER_AURA, true);
            }
            
            if (me->GetEntry() == NPC_AHNKAHAR_SWARMER || me->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY)
            {
                me->SetInCombatWithZone();
            }

            uiSprintTimer = 10000;
        }

        void JustDied(Unit * /*killer*/)
        {
            if (me->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY)
            {
                if (InstanceScript *pInstance = me->GetInstanceScript()) 
                {
                    if (Creature *nadox = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_ELDER_NADOX)))
                        nadox->AI()->DoAction(ACTION_GUARDIAN_DIED);
                }

                me->RemoveAllAuras();
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (uiSprintTimer <= diff)
            {
                DoCastSelf(SPELL_SPRINT, false);
                uiSprintTimer = 15000;
            }
            else 
                uiSprintTimer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 uiSprintTimer;
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_ahnkahar_nerubianAI(creature);
    }
};

class spell_ahn_kahet_swarmer_aura : public SpellScriptLoader
{
    public:
        spell_ahn_kahet_swarmer_aura() : SpellScriptLoader("spell_ahn_kahet_swarmer_aura") { }

        class spell_ahn_kahet_swarmer_aura_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ahn_kahet_swarmer_aura_SpellScript)

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                std::list<Creature*> swarm, swarm2;
                caster->GetCreaturesWithEntryInRange(swarm, 40.0f, 30338);
                caster->GetCreaturesWithEntryInRange(swarm2, 40.0f, 30178);
                int32 aliveCount = -1; // minus self

                std::list<Creature*>::const_iterator itr;
                for (itr = swarm.begin(); itr != swarm.end(); ++itr)
                {
                    if ((*itr)->IsAlive())
                    {
                        ++aliveCount;
                    }
                }
                for (itr = swarm2.begin(); itr != swarm2.end(); ++itr)
                {
                    if ((*itr)->IsAlive())
                    {
                        ++aliveCount;
                    }
                }

                if (Aura *aur = caster->GetAura(56281))
                {
                    if (aliveCount > 0)
                    {
                        aur->SetStackAmount(aliveCount);
                    }
                    else
                    {
                        aur->Remove();
                    }
                }
                else if (aliveCount > 0)
                {
                    // TODO: move spell id to enum
                    caster->CastCustomSpell(caster, 56281, &aliveCount, &aliveCount, &aliveCount, true);
                    if (Aura *aur = caster->GetAura(56281))
                    {
                        aur->SetStackAmount(aliveCount);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_ahn_kahet_swarmer_aura_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ahn_kahet_swarmer_aura_SpellScript();
        }
};

void AddSC_boss_elder_nadox()
{
    new boss_elder_nadox();
    new npc_ahnkahar_nerubian();

    // Spells
    new spell_ahn_kahet_swarmer_aura();
}
