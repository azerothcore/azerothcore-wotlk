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
    //SPELL_SUMMON_SWARMERS         = 56119, //2x 30178  -- 2x every 10secs, spell works fine but i need specific coords
    //SPELL_SUMMON_SWARM_GUARD      = 56120, //1x 30176  -- at 50%hp, spell works fine but i need specific coords

    // ADDS
    SPELL_SPRINT                    = 56354,
    SPELL_GUARDIAN_AURA             = 56151,
    SPELL_SWARMER_AURA              = 56158,
};

enum Creatures
{
    NPC_AHNKAHAR_SWARMER            = 30178,
    NPC_AHNKAHAR_GUARDIAN_ENTRY     = 30176,
};

enum Events
{
    EVENT_CHECK_HEALTH              = 1,
    EVENT_CHECK_HOME                = 2,
    EVENT_PLAGUE                    = 3,
    EVENT_BROOD_RAGE                = 4,
    EVENT_SWARMER                   = 5,
    EVENT_SUMMON_GUARD              = 6,
};

enum Yells
{
    SAY_AGGRO       = 0,
    SAY_SLAY        = 1,
    SAY_DEATH       = 2,
    SAY_EGG_SAC     = 3,
    EMOTE_HATCHES   = 4
};

class boss_elder_nadox : public CreatureScript
{
public:
    boss_elder_nadox() : CreatureScript("boss_elder_nadox") { }

    struct boss_elder_nadoxAI : public ScriptedAI
    {
        boss_elder_nadoxAI(Creature *c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        EventMap events;
        InstanceScript *pInstance;
        SummonList summons;

        void SummonHelpers(bool swarm)
        {
            Creature *cr;
            if (swarm)
            {
                if ((cr = me->SummonCreature(NPC_AHNKAHAR_SWARMER, 640.425f, -919.544f, 25.8701f, 2.56563f)))
                    summons.Summon(cr);
                if ((cr = me->SummonCreature(NPC_AHNKAHAR_SWARMER, 655.891f, -930.445f, 25.6978f, 3.64774f)))
                    summons.Summon(cr);
            }
            else
            {
                if ((cr = me->SummonCreature(NPC_AHNKAHAR_GUARDIAN_ENTRY, 658.677f, -934.332f, 25.6978f, 3.03687f)))
                    summons.Summon(cr);
            }
        }

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();

            if (pInstance)
            {
                pInstance->SetData(DATA_ELDER_NADOX_EVENT, NOT_STARTED);
                pInstance->SetData(DATA_NADOX_ACHIEVEMENT, true);
            }
        }

        void EnterCombat(Unit * /*who*/)
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            events.ScheduleEvent(EVENT_SWARMER, 10000);
            events.ScheduleEvent(EVENT_CHECK_HOME, 2000);
            events.ScheduleEvent(EVENT_PLAGUE, 5000+rand()%3000);
            events.ScheduleEvent(EVENT_BROOD_RAGE, 5000);

            if (pInstance)
                pInstance->SetData(DATA_ELDER_NADOX_EVENT, IN_PROGRESS);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_GUARDIAN_DIED)
            {
                if (pInstance)
                    pInstance->SetData(DATA_NADOX_ACHIEVEMENT, false);
            }
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/)
        {
            events.Reset();
            summons.DespawnAll();
            
            Talk(SAY_DEATH);

            if (pInstance)
                pInstance->SetData(DATA_ELDER_NADOX_EVENT, DONE);
        }

        void JustSummoned(Creature* cr)
        {
            if (cr)
            {
                if (cr->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY )
                    Talk(SAY_EGG_SAC);
                
                summons.Summon(cr);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch ( events.GetEvent() )
            {
                case EVENT_CHECK_HEALTH:
                {
                    events.RepeatEvent(1000);
                    if (HealthBelowPct(50))
                    {
                        events.CancelEvent(EVENT_CHECK_HEALTH);
                        events.ScheduleEvent(EVENT_SUMMON_GUARD, 100);
                    }
                    break;
                }
                case EVENT_SUMMON_GUARD:
                {
                    Talk(EMOTE_HATCHES, me);
                    SummonHelpers(false);
                    events.PopEvent();
                    break;
                }
                case EVENT_BROOD_RAGE:
                {
                    if (Creature *pSwarmer = me->FindNearestCreature(NPC_AHNKAHAR_SWARMER, 40, true))
                        me->CastSpell(pSwarmer, SPELL_BROOD_RAGE_H, true);
                    
                    events.RepeatEvent(10000);
                    break;
                }
                case EVENT_PLAGUE:
                {
                    me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_BROOD_PLAGUE, SPELL_BROOD_PLAGUE_H), false);
                    events.RepeatEvent(12000+rand()%5000);
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
                    if (me->HasAura(SPELL_ENRAGE))
                        break;

                    if (me->GetPositionZ() < 24)
                    {
                        me->CastSpell(me, SPELL_ENRAGE, true);
                        events.PopEvent();
                        break;
                    }

                    events.RepeatEvent(2000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
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

        
        uint32 uiSprintTimer;
        void Reset()
        {
            if (me->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY)
                me->CastSpell(me, SPELL_GUARDIAN_AURA, true);
            else // Swarmers
                me->CastSpell(me, SPELL_SWARMER_AURA, true);
            
            if (me->GetEntry() == NPC_AHNKAHAR_SWARMER || me->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY)
                me->SetInCombatWithZone();

            uiSprintTimer = 10000;
        }

        void JustDied(Unit * /*killer*/)
        {
            if (me->GetEntry() == NPC_AHNKAHAR_GUARDIAN_ENTRY)
            {
                if (InstanceScript *pInstance = me->GetInstanceScript()) 
                    if (Creature *nadox = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_ELDER_NADOX)))
                        nadox->AI()->DoAction(ACTION_GUARDIAN_DIED);

                me->RemoveAllAuras();
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (uiSprintTimer <= diff)
            {
                me->CastSpell(me, SPELL_SPRINT, false);
                uiSprintTimer = 15000;
            }
            else 
                uiSprintTimer -= diff;

            DoMeleeAttackIfReady();
        }
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
                    if ((*itr)->IsAlive())
                        aliveCount++;
                for (itr = swarm2.begin(); itr != swarm2.end(); ++itr)
                    if ((*itr)->IsAlive())
                        aliveCount++;

                if (Aura *aur = caster->GetAura(56281))
                {
                    if (aliveCount > 0)
                        aur->SetStackAmount(aliveCount);
                    else
                        aur->Remove();
                }
                else if (aliveCount > 0)
                {
                    caster->CastCustomSpell(caster, 56281, &aliveCount, &aliveCount, &aliveCount, true);
                    if (Aura *aur = caster->GetAura(56281))
                        aur->SetStackAmount(aliveCount);
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
    new spell_ahn_kahet_swarmer_aura();
}
