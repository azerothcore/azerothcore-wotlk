/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "Vehicle.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "Player.h"

#define SPELL_FLAME_JETS_10             62680
#define SPELL_FLAME_JETS_25             63472
#define S_FLAME_JETS                    RAID_MODE(SPELL_FLAME_JETS_10, SPELL_FLAME_JETS_25)
#define SPELL_SCORCH_10                 62546
#define SPELL_SCORCH_25                 63474
#define S_SCORCH                        RAID_MODE(SPELL_SCORCH_10, SPELL_SCORCH_25)
#define SPELL_ACTIVATE_CONSTRUCT        62488
#define SPELL_STRENGTH_OF_THE_CREATOR   64473
#define SPELL_SLAG_POT_10               62717
#define SPELL_SLAG_POT_25               63477
#define S_SLAG_POT                      RAID_MODE(SPELL_SLAG_POT_10, SPELL_SLAG_POT_25)
#define SPELL_BERSERK                   64238
#define SPELL_GRAB                      62707
#define SPELL_GRAB_TRIGGERED            62708
#define SPELL_GRAB_CONTROL_2            62711

#define SPELL_SCORCHED_GROUND_10        62548
#define SPELL_SCORCHED_GROUND_25        63476
#define S_SCORCHED_GROUND               RAID_MODE(SPELL_SCORCHED_GROUND_10, SPELL_SCORCHED_GROUND_25)
#define SPELL_HEAT_AREA                 62343
#define SPELL_HEAT_BUFF                 65667
#define SPELL_MOLTEN                    62373
#define SPELL_BRITTLE_10                62382
#define SPELL_BRITTLE_25                67114
#define S_BRITTLE                       RAID_MODE(SPELL_BRITTLE_10, SPELL_BRITTLE_25)
#define SPELL_SHATTER                   62383

#define BOSS_IGNIS                      33118
#define NPC_IRON_CONSTRUCT              33121
#define NPC_SCORCHED_GROUND             33123
#define NPC_WATER_TRIGGER               22515

#define TEXT_AGGRO                      "Insolent whelps! Your blood will temper the weapons used to reclaim this world!"
#define TEXT_ACTIVATE_CONSTRUCT         "Arise, soldiers of the Iron Crucible! The Makers' will be done!"
#define TEXT_SCORCH_1                   "Let the inferno consume you!"
#define TEXT_SCORCH_2                   "BURN! Burn in the makers fire!"
#define TEXT_SLAG_POT                   "I will burn away your impurities!"
#define TEXT_SLAY_1                     "More scraps for the scrapheap!"
#define TEXT_SLAY_2                     "Your bones will serve as kindling!"
#define TEXT_BERSERK                    "Let it be finished!"
#define TEXT_DEATH                      "I. Have. Failed."
#define TEXT_FLAME_JETS                 "Ignis The Furnace Master begins to cast Flame Jets!"

#define SOUND_AGGRO                     15564
#define SOUND_ACTIVATE_CONSTRUCT        15565
#define SOUND_SLAG_POT                  15566
#define SOUND_SCORCH_1                  15567
#define SOUND_SCORCH_2                  15568
#define SOUND_SLAY_1                    15569
#define SOUND_SLAY_2                    15570
#define SOUND_BERSERK                   15571
#define SOUND_DEATH                     15572

#define ACHIEV_STOKIN_THE_FURNACE_EVENT 20951

enum eEvents
{
    EVENT_NONE = 0,
    EVENT_ACTIVATE_CONSTRUCT,
    EVENT_SPELL_SCORCH,
    EVENT_ENABLE_ROTATE,
    EVENT_SPELL_FLAME_JETS,
    EVENT_GRAB,
};


class npc_ulduar_iron_construct : public CreatureScript
{
public:
    npc_ulduar_iron_construct() : CreatureScript("npc_ulduar_iron_construct") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_iron_constructAI (pCreature);
    }

    struct npc_ulduar_iron_constructAI : public ScriptedAI
    {
        npc_ulduar_iron_constructAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            me->CastSpell(me, 38757, true);
        }

        uint16 timer;

        void Reset()
        {
            timer = 1000;
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }

        void JustReachedHome()
        {
            me->CastSpell(me, 38757, true);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_ACTIVATE_CONSTRUCT)
            {
                me->RemoveAura(38757);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                if (InstanceScript* instance = me->GetInstanceScript())
                    if (Creature* ignis = ObjectAccessor::GetCreature(*me, instance->GetData64(TYPE_IGNIS)))
                    {
                        ignis->CastSpell(ignis, SPELL_STRENGTH_OF_THE_CREATOR, true);
                        AttackStart(ignis->GetVictim());
                        DoZoneInCombat();
                    }
            }
            else if (spell->Id == SPELL_HEAT_BUFF)
            {
                if (Aura* a = me->GetAura(SPELL_HEAT_BUFF))
                    if( a->GetStackAmount() >= RAID_MODE(10,20) )
                        {
                            if (RAID_MODE(1,0) && a->GetStackAmount() > 10) // prevent going over 10 on 10man version
                                a->ModStackAmount(-1);

                            me->CastSpell(me, SPELL_MOLTEN, true);
                            me->getThreatManager().resetAllAggro();
                        }
            }
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if( damage >= RAID_MODE(3000U, 5000U) && me->GetAura(S_BRITTLE) )
            {
                me->CastSpell(me, SPELL_SHATTER, true);
                Unit::Kill(attacker, me);

                if (InstanceScript* instance = me->GetInstanceScript())
                    if (Creature* ignis = ObjectAccessor::GetCreature(*me, instance->GetData64(TYPE_IGNIS)))
                        ignis->AI()->SetData(1337, 0);
            }
        }

        void JustDied(Unit*  /*killer*/)
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* ignis = ObjectAccessor::GetCreature(*me, instance->GetData64(TYPE_IGNIS)))
                    ignis->RemoveAuraFromStack(SPELL_STRENGTH_OF_THE_CREATOR);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (timer <= diff)
            {
                timer = 1000;
                if (Aura* a = me->GetAura(SPELL_MOLTEN))
                    if (me->FindNearestCreature(NPC_WATER_TRIGGER, 18.0f, true))
                    {
                        me->RemoveAura(a);
                        me->CastSpell(me, S_BRITTLE, true);
                    }
            }
            else
                timer -= diff;

            DoMeleeAttackIfReady();
        }

        void MoveInLineOfSight(Unit* /*who*/) {}
    };
};

class boss_ignis : public CreatureScript
{
public:
    boss_ignis() : CreatureScript("boss_ignis") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_ignisAI (pCreature);
    }

    struct boss_ignisAI : public ScriptedAI
    {
        boss_ignisAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        EventMap events;
        uint8 counter;
        bool bShattered;
        uint32 lastShatterMSTime;

        void Reset()
        {
            events.Reset();
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            counter = 0;
            bShattered = false;
            lastShatterMSTime = 0;
            
            if( InstanceScript* m_pInstance = me->GetInstanceScript() )
            {
                m_pInstance->SetData(TYPE_IGNIS, NOT_STARTED);
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_STOKIN_THE_FURNACE_EVENT);
            }
        }

        void EnterCombat(Unit*  /*who*/)
        {
            me->setActive(true);

            std::list<Creature*> icl;
            me->GetCreaturesWithEntryInRange(icl, 300.0f, NPC_IRON_CONSTRUCT);
            for( std::list<Creature*>::iterator itr = icl.begin(); itr != icl.end(); ++itr )
            {
                if (!(*itr)->IsAlive())
                {
                    (*itr)->Respawn();
                    (*itr)->UpdatePosition((*itr)->GetHomePosition(), true);
                    (*itr)->StopMovingOnCurrentPos();
                }
                (*itr)->AI()->Reset();
                if (!(*itr)->HasAura(38757))
                    (*itr)->CastSpell((*itr), 38757, true);
            }

            bShattered = false;
            lastShatterMSTime = 0;
            events.Reset();
            events.ScheduleEvent(EVENT_ACTIVATE_CONSTRUCT, RAID_MODE(40000,30000));
            events.ScheduleEvent(EVENT_SPELL_SCORCH, 10000);
            events.ScheduleEvent(EVENT_SPELL_FLAME_JETS, 32000);
            events.ScheduleEvent(EVENT_GRAB, 25000);

            me->MonsterYell(TEXT_AGGRO, LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_AGGRO);
            DoZoneInCombat();

            if( InstanceScript* m_pInstance = me->GetInstanceScript() )
            {
                m_pInstance->SetData(TYPE_IGNIS, IN_PROGRESS);
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_STOKIN_THE_FURNACE_EVENT);
                m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_STOKIN_THE_FURNACE_EVENT);
            }
        }

        void SetData(uint32 id, uint32  /*value*/)
        {
            if (id == 1337)
            {
                if (lastShatterMSTime)
                    if (getMSTimeDiff(lastShatterMSTime, World::GetGameTimeMS()) <= 5000)
                        bShattered = true;

                lastShatterMSTime = World::GetGameTimeMS();
            }
        }

        uint32 GetData(uint32 id) const
        {
            if (id == 1337)
                return (bShattered ? 1 : 0);
            return 0;
        }

        void JustReachedHome()
        {
            me->setActive(false);
        }

        void KilledUnit(Unit*  /*victim*/)
        {
            if( rand()%2 )
            {
                me->MonsterYell(TEXT_SLAY_1, LANG_UNIVERSAL, 0);
                me->PlayDirectSound(SOUND_SLAY_1);
            }
            else
            {
                me->MonsterYell(TEXT_SLAY_2, LANG_UNIVERSAL, 0);
                me->PlayDirectSound(SOUND_SLAY_2);
            }
        }

        void JustDied(Unit * /*victim*/)
        {
            me->MonsterYell(TEXT_DEATH, LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_DEATH);

            if( me->GetInstanceScript() )
                me->GetInstanceScript()->SetData(TYPE_IGNIS, DONE);

            std::list<Creature*> icl;
            me->GetCreaturesWithEntryInRange(icl, 300.0f, NPC_IRON_CONSTRUCT);
            for( std::list<Creature*>::iterator itr = icl.begin(); itr != icl.end(); ++itr )
                if ((*itr)->IsAlive() && (*itr)->IsInCombat())
                    Unit::Kill(*itr, *itr);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (caster && spell->Id == SPELL_GRAB_CONTROL_2)
            {
                //caster->ClearUnitState(UNIT_STATE_ONVEHICLE);
                me->CastSpell(caster, S_SLAG_POT, true);
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if( me->GetPositionX() < 490.0f || me->GetPositionX() > 690.0f || me->GetPositionY() < 130.0f || me->GetPositionY() > 410.0f )
            {
                EnterEvadeMode();
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_ACTIVATE_CONSTRUCT:
                    me->CastCustomSpell(SPELL_ACTIVATE_CONSTRUCT, SPELLVALUE_MAX_TARGETS, 1, (Unit*)NULL, false);
                    if (++counter >= 20)
                    {
                        me->MonsterYell(TEXT_BERSERK, LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_BERSERK);
                        me->CastSpell(me, SPELL_BERSERK, true);
                        events.PopEvent();
                        break;
                    }
                    events.RepeatEvent(RAID_MODE(40000,30000));
                    break;
                case EVENT_SPELL_SCORCH:
                    if( rand()%2 )
                    {
                        me->MonsterYell(TEXT_SCORCH_1, LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_SCORCH_1);
                    }
                    else
                    {
                        me->MonsterYell(TEXT_SCORCH_2, LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_SCORCH_2);
                    }
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->DisableRotate(true);
                    me->SendMovementFlagUpdate();
                    me->CastSpell(me->GetVictim(), S_SCORCH, false);
                    events.RepeatEvent(20000);
                    events.RescheduleEvent(EVENT_ENABLE_ROTATE, 3001);
                    break;
                case EVENT_ENABLE_ROTATE:
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->DisableRotate(false);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_FLAME_JETS:
                    me->MonsterTextEmote(TEXT_FLAME_JETS, 0, true);
                    me->CastSpell(me->GetVictim(), S_FLAME_JETS, false);
                    events.RepeatEvent(25000);
                    break;
                case EVENT_GRAB:
                    {
                        std::list<Creature*> icl;
                        me->GetCreaturesWithEntryInRange(icl, 300.0f, NPC_IRON_CONSTRUCT);

                        std::vector<uint64> playerGUIDs;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        Player* temp = NULL;

                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                        {
                            temp = itr->GetSource();
                            if( !temp->IsAlive() || temp->GetExactDist2d(me) > 90.0f )
                                continue;
                            if( me->GetVictim() && temp->GetGUID() == me->GetVictim()->GetGUID() )
                                continue;
                            bool found = false;
                            for( std::list<Creature*>::iterator itr = icl.begin(); itr != icl.end(); ++itr )
                                if( (*itr)->GetVictim() && (*itr)->GetVictim()->GetGUID() == temp->GetGUID() )
                                {
                                    found = true;
                                    break;
                                }

                            if( !found )
                                playerGUIDs.push_back(temp->GetGUID());
                        }

                        if( !playerGUIDs.empty() )
                        {
                            int8 pos = urand(0, playerGUIDs.size()-1);
                            if( Player* pTarget = ObjectAccessor::GetPlayer(*me,playerGUIDs.at(pos)) )
                            {
                                me->MonsterYell(TEXT_SLAG_POT, LANG_UNIVERSAL, 0);
                                me->PlayDirectSound(SOUND_SLAG_POT);
                                me->CastSpell(pTarget, SPELL_GRAB, false);
                            }
                        }

                        events.RepeatEvent(24000); // +6000 below
                        events.DelayEvents(6000);
                    }
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode();
        }
    };
};

class spell_ignis_scorch : public SpellScriptLoader
{
public:
    spell_ignis_scorch() : SpellScriptLoader("spell_ignis_scorch") { }

    class spell_ignis_scorch_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ignis_scorch_AuraScript)

        void HandleEffectPeriodic(AuraEffect const * aurEff)
        {
            if (aurEff->GetTotalTicks() >= 0 && aurEff->GetTickNumber() == uint32(aurEff->GetTotalTicks()))
                if (Unit* c = GetCaster())
                    if (Creature* s = c->SummonCreature(NPC_SCORCHED_GROUND, c->GetPositionX()+20.0f*cos(c->GetOrientation()), c->GetPositionY()+20.0f*sin(c->GetOrientation()), 361.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 30000))
                    {
                        if (!s->FindNearestCreature(NPC_WATER_TRIGGER, 25.0f,true)) // must be away from the water
                            s->CastSpell(s, (aurEff->GetId() == 62546 ? SPELL_SCORCHED_GROUND_10 : SPELL_SCORCHED_GROUND_25), true);
                    }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_ignis_scorch_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_ignis_scorch_AuraScript();
    }
};

class spell_ignis_grab_initial : public SpellScriptLoader
{
public:
    spell_ignis_grab_initial() : SpellScriptLoader("spell_ignis_grab_initial") { }

    class spell_ignis_grab_initial_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_ignis_grab_initial_SpellScript);

        void HandleScript(SpellEffIndex  /*effIndex*/)
        {
            if (Unit* t = GetHitUnit())
                t->CastSpell(t, SPELL_GRAB_TRIGGERED, true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_ignis_grab_initial_SpellScript::HandleScript, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_ignis_grab_initial_SpellScript();
    }
};

class spell_ignis_slag_pot : public SpellScriptLoader
{
public:
    spell_ignis_slag_pot() : SpellScriptLoader("spell_ignis_slag_pot") { }

    class spell_ignis_slag_pot_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ignis_slag_pot_AuraScript)

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            if (Unit* c = GetCaster())
                if (Unit* t = GetTarget())
                    c->CastSpell(t, (GetId() == 62717 ? 65722 : 65723), true);
        }

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* t = GetTarget())
            {
                t->ApplySpellImmune(GetId(), IMMUNITY_ID, 62549, true);
                t->ApplySpellImmune(GetId(), IMMUNITY_ID, 63475, true);
            }
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* t = GetTarget())
            {
                t->ApplySpellImmune(GetId(), IMMUNITY_ID, 62549, false);
                t->ApplySpellImmune(GetId(), IMMUNITY_ID, 63475, false);
                if (t->IsAlive())
                    t->CastSpell(t, (GetId() == 62717 ? 62836 : 63536), true);
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_ignis_slag_pot_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            OnEffectApply += AuraEffectApplyFn(spell_ignis_slag_pot_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_ignis_slag_pot_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_ignis_slag_pot_AuraScript();
    }
};

class achievement_ignis_shattered : public AchievementCriteriaScript
{
    public:
        achievement_ignis_shattered() : AchievementCriteriaScript("achievement_ignis_shattered") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (!target || target->GetTypeId() != TYPEID_UNIT)
                return false;
            return (target->ToCreature()->AI()->GetData(1337) ? true : false);
        }
};

void AddSC_boss_ignis()
{
    new boss_ignis();
    new npc_ulduar_iron_construct();
    new spell_ignis_scorch();
    new spell_ignis_grab_initial();
    new spell_ignis_slag_pot();
    new achievement_ignis_shattered();
}