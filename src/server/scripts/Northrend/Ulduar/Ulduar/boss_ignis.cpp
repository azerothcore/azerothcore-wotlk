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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameTime.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "ulduar.h"

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

enum Texts
{
    SAY_AGGRO       = 0,
    SAY_SUMMON      = 1,
    SAY_SLAG_POT    = 2,
    SAY_SCORCH      = 3,
    SAY_SLAY        = 4,
    SAY_BERSERK     = 5,
    SAY_DEATH       = 6,
    EMOTE_JETS      = 7,
};

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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_iron_constructAI>(pCreature);
    }

    struct npc_ulduar_iron_constructAI : public ScriptedAI
    {
        npc_ulduar_iron_constructAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->CastSpell(me, 38757, true);
        }

        uint16 timer;

        void Reset() override
        {
            timer = 1000;
            me->SetReactState(REACT_PASSIVE);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        void JustReachedHome() override
        {
            me->CastSpell(me, 38757, true);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_ACTIVATE_CONSTRUCT)
            {
                me->RemoveAura(38757);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                if (InstanceScript* instance = me->GetInstanceScript())
                    if (Creature* ignis = ObjectAccessor::GetCreature(*me, instance->GetGuidData(TYPE_IGNIS)))
                    {
                        ignis->CastSpell(ignis, SPELL_STRENGTH_OF_THE_CREATOR, true);
                        AttackStart(ignis->GetVictim());
                        DoZoneInCombat();
                    }
            }
            else if (spell->Id == SPELL_HEAT_BUFF)
            {
                if (Aura* heat = me->GetAura(SPELL_HEAT_BUFF))
                {
                    if (heat->GetStackAmount() >= 10)
                    {
                        if (heat->GetStackAmount() > 10)
                        {
                            heat->ModStackAmount(-1);
                        }
                        me->CastSpell(me, SPELL_MOLTEN, true);
                        me->GetThreatMgr().ResetAllThreat();
                    }
                }
            }
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= RAID_MODE(3000U, 5000U) && me->GetAura(S_BRITTLE))
            {
                me->CastSpell(me, SPELL_SHATTER, true);
                Unit::Kill(attacker, me);

                if (InstanceScript* instance = me->GetInstanceScript())
                    if (Creature* ignis = ObjectAccessor::GetCreature(*me, instance->GetGuidData(TYPE_IGNIS)))
                        ignis->AI()->SetData(1337, 0);
            }
        }

        void JustDied(Unit*  /*killer*/) override
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* ignis = ObjectAccessor::GetCreature(*me, instance->GetGuidData(TYPE_IGNIS)))
                    ignis->RemoveAuraFromStack(SPELL_STRENGTH_OF_THE_CREATOR);
        }

        void UpdateAI(uint32 diff) override
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

        void MoveInLineOfSight(Unit* /*who*/) override {}
    };
};

class boss_ignis : public CreatureScript
{
public:
    boss_ignis() : CreatureScript("boss_ignis") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_ignisAI>(pCreature);
    }

    struct boss_ignisAI : public ScriptedAI
    {
        boss_ignisAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        EventMap events;
        uint8 counter;
        bool bShattered;
        uint32 lastShatterMSTime;

        void Reset() override
        {
            events.Reset();
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            counter = 0;
            bShattered = false;
            lastShatterMSTime = 0;

            if (InstanceScript* m_pInstance = me->GetInstanceScript())
            {
                m_pInstance->SetData(TYPE_IGNIS, NOT_STARTED);
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_STOKIN_THE_FURNACE_EVENT);
            }
        }

        void JustEngagedWith(Unit*  /*who*/) override
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
            events.ScheduleEvent(EVENT_ACTIVATE_CONSTRUCT, RAID_MODE(40000, 30000));
            events.ScheduleEvent(EVENT_SPELL_SCORCH, 10s);
            events.ScheduleEvent(EVENT_SPELL_FLAME_JETS, 32s);
            events.ScheduleEvent(EVENT_GRAB, 25s);

            Talk(SAY_AGGRO);
            DoZoneInCombat();

            if (InstanceScript* m_pInstance = me->GetInstanceScript())
            {
                m_pInstance->SetData(TYPE_IGNIS, IN_PROGRESS);
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_STOKIN_THE_FURNACE_EVENT);
                m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_STOKIN_THE_FURNACE_EVENT);
            }
        }

        void SetData(uint32 id, uint32  /*value*/) override
        {
            if (id == 1337)
            {
                if (lastShatterMSTime)
                    if (getMSTimeDiff(lastShatterMSTime, GameTime::GetGameTimeMS().count()) <= 5000)
                        bShattered = true;

                lastShatterMSTime = GameTime::GetGameTimeMS().count();
            }
        }

        uint32 GetData(uint32 id) const override
        {
            if (id == 1337)
                return (bShattered ? 1 : 0);
            return 0;
        }

        void JustReachedHome() override
        {
            me->setActive(false);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);

            if (me->GetInstanceScript())
                me->GetInstanceScript()->SetData(TYPE_IGNIS, DONE);

            std::list<Creature*> icl;
            me->GetCreaturesWithEntryInRange(icl, 300.0f, NPC_IRON_CONSTRUCT);
            for( std::list<Creature*>::iterator itr = icl.begin(); itr != icl.end(); ++itr )
                if ((*itr)->IsAlive() && (*itr)->IsInCombat())
                    Unit::Kill(*itr, *itr);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (caster && spell->Id == SPELL_GRAB_CONTROL_2)
            {
                //caster->ClearUnitState(UNIT_STATE_ONVEHICLE);
                me->CastSpell(caster, S_SLAG_POT, true);
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (me->GetPositionX() < 490.0f || me->GetPositionX() > 690.0f || me->GetPositionY() < 130.0f || me->GetPositionY() > 410.0f )
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_ACTIVATE_CONSTRUCT:
                    Talk(SAY_SUMMON);
                    me->CastCustomSpell(SPELL_ACTIVATE_CONSTRUCT, SPELLVALUE_MAX_TARGETS, 1, (Unit*)nullptr, false);
                    if (++counter >= 20)
                    {
                        Talk(SAY_BERSERK);
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                    }
                    events.RepeatEvent(RAID_MODE(40000, 30000));
                    break;
                case EVENT_SPELL_SCORCH:
                    Talk(SAY_SCORCH);
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->DisableRotate(true);
                    me->SendMovementFlagUpdate();
                    me->CastSpell(me->GetVictim(), S_SCORCH, false);
                    events.Repeat(20s);
                    events.RescheduleEvent(EVENT_ENABLE_ROTATE, 3s);
                    break;
                case EVENT_ENABLE_ROTATE:
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->DisableRotate(false);
                    break;
                case EVENT_SPELL_FLAME_JETS:
                    Talk(EMOTE_JETS);
                    me->CastSpell(me->GetVictim(), S_FLAME_JETS, false);
                    events.Repeat(25s);
                    break;
                case EVENT_GRAB:
                    {
                        std::list<Creature*> icl;
                        me->GetCreaturesWithEntryInRange(icl, 300.0f, NPC_IRON_CONSTRUCT);

                        GuidVector playerGUIDs;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        Player* temp = nullptr;

                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                        {
                            temp = itr->GetSource();
                            if (!temp->IsAlive() || temp->GetExactDist2d(me) > 90.0f )
                                continue;
                            if (me->GetVictim() && temp->GetGUID() == me->GetVictim()->GetGUID())
                                continue;
                            bool found = false;
                            for (std::list<Creature*>::iterator iterator = icl.begin(); iterator != icl.end(); ++iterator)
                            {
                                if ((*iterator)->GetVictim() && (*iterator)->GetVictim()->GetGUID() == temp->GetGUID())
                                {
                                    found = true;
                                    break;
                                }
                            }

                            if (!found)
                                playerGUIDs.push_back(temp->GetGUID());
                        }

                        if (!playerGUIDs.empty())
                        {
                            int8 pos = urand(0, playerGUIDs.size() - 1);
                            if (Player* pTarget = ObjectAccessor::GetPlayer(*me, playerGUIDs.at(pos)))
                            {
                                Talk(SAY_SLAG_POT);
                                me->CastSpell(pTarget, SPELL_GRAB, false);
                            }
                        }

                        events.Repeat(24s);
                        events.DelayEvents(6s);
                    }
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode(why);
        }
    };
};

class spell_ignis_scorch_aura : public AuraScript
{
    PrepareAuraScript(spell_ignis_scorch_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SCORCHED_GROUND_10, SPELL_SCORCHED_GROUND_25 });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (aurEff->GetTotalTicks() >= 0 && aurEff->GetTickNumber() == uint32(aurEff->GetTotalTicks()))
            if (Unit* caster = GetCaster())
                if (Creature* summon = caster->SummonCreature(NPC_SCORCHED_GROUND, caster->GetPositionX() + 20.0f * cos(caster->GetOrientation()), caster->GetPositionY() + 20.0f * std::sin(caster->GetOrientation()), 361.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 30000))
                {
                    if (!summon->FindNearestCreature(NPC_WATER_TRIGGER, 25.0f, true)) // must be away from the water
                        summon->CastSpell(summon, (aurEff->GetId() == SPELL_SCORCH_10 ? SPELL_SCORCHED_GROUND_10 : SPELL_SCORCHED_GROUND_25), true);
                }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_ignis_scorch_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_ignis_grab_initial : public SpellScript
{
    PrepareSpellScript(spell_ignis_grab_initial);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GRAB_TRIGGERED });
    }

    void HandleScript(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_GRAB_TRIGGERED, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ignis_grab_initial::HandleScript, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum SlagPot
{
    SPELL_SLAG_POT_DAMAGE_1 = 65722,
    SPELL_SLAG_POT_DAMAGE_2 = 65723,
    SPELL_SCORCH_DAMAGE_1   = 62549,
    SPELL_SCORCH_DAMAGE_2   = 63475,
    SPELL_SLAG_IMBUED_1     = 62836,
    SPELL_SLAG_IMBUED_2     = 63536
};

class spell_ignis_slag_pot_aura : public AuraScript
{
    PrepareAuraScript(spell_ignis_slag_pot_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_SLAG_POT_DAMAGE_1,
                SPELL_SLAG_POT_DAMAGE_2,
                SPELL_SCORCH_DAMAGE_1,
                SPELL_SCORCH_DAMAGE_2,
                SPELL_SLAG_IMBUED_1,
                SPELL_SLAG_IMBUED_2
            });
    }

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
            if (Unit* target = GetTarget())
                caster->CastSpell(target, (GetId() == SPELL_SLAG_POT_10 ? SPELL_SLAG_POT_DAMAGE_1 : SPELL_SLAG_POT_DAMAGE_2), true);
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            target->ApplySpellImmune(GetId(), IMMUNITY_ID, SPELL_SCORCH_DAMAGE_1, true);
            target->ApplySpellImmune(GetId(), IMMUNITY_ID, SPELL_SCORCH_DAMAGE_2, true);
        }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            target->ApplySpellImmune(GetId(), IMMUNITY_ID, SPELL_SCORCH_DAMAGE_1, false);
            target->ApplySpellImmune(GetId(), IMMUNITY_ID, SPELL_SCORCH_DAMAGE_2, false);
            if (target->IsAlive())
                target->CastSpell(target, (GetId() == SPELL_SLAG_POT_10 ? SPELL_SLAG_IMBUED_1 : SPELL_SLAG_IMBUED_2), true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_ignis_slag_pot_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectApply += AuraEffectApplyFn(spell_ignis_slag_pot_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_ignis_slag_pot_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class achievement_ignis_shattered : public AchievementCriteriaScript
{
public:
    achievement_ignis_shattered() : AchievementCriteriaScript("achievement_ignis_shattered") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target || !target->IsCreature())
            return false;
        return !!target->ToCreature()->AI()->GetData(1337);
    }
};

void AddSC_boss_ignis()
{
    new boss_ignis();
    new npc_ulduar_iron_construct();
    RegisterSpellScript(spell_ignis_scorch_aura);
    RegisterSpellScript(spell_ignis_grab_initial);
    RegisterSpellScript(spell_ignis_slag_pot_aura);
    new achievement_ignis_shattered();
}
