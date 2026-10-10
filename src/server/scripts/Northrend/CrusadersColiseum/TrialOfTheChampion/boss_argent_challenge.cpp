/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_champion.h"

enum EadricSpells
{
    //Eadric
    SPELL_EADRIC_ACHIEVEMENT            = 68197,
    SPELL_EADRIC_CREDIT                 = 68575,

    SPELL_RADIANCE                      = 66935,
    SPELL_VENGEANCE                     = 66865,
    SPELL_HAMMER_JUSTICE                = 66863,
    SPELL_HAMMER_RIGHTEOUS              = 66867,
    SPELL_HAMMER_RIGHTEOUS_THROW_BACK   = 66905,
};

enum PaletressSpells
{
    SPELL_SMITE                         = 66536,
    SPELL_HOLY_FIRE                     = 66538,
    SPELL_RENEW                         = 66537,

    SPELL_HOLY_NOVA                     = 66546,
    SPELL_SHIELD                        = 66515,
    SPELL_CONFESS                       = 66680,
    SPELL_SUMMON_MEMORY                 = 66545,
    SPELL_PALETRESS_CREDIT              = 68574,
    SPELL_PALETRESS_ACHIEVEMENT         = 68206,

    //Memory
    SPELL_OLD_WOUNDS                    = 66620,
    SPELL_SHADOWS_PAST                  = 66619,
    SPELL_WAKING_NIGHTMARE              = 66552,
};

struct boss_eadric : public BossAI
{
    boss_eadric(Creature* creature) : BossAI(creature, BOSS_ARGENT_CHALLENGE)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        me->SetReactState(REACT_PASSIVE);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == 1)
            me->SetFacingTo(3 * M_PI / 2);
    }

    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
            Talk(SAY_EADRIC_KILL_PLAYER);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_EADRIC_AGGRO);
        DoCastSelf(SPELL_VENGEANCE);

        ScheduleTimedEvent(16s, [this]
        {
            DoCastAOE(SPELL_RADIANCE);
            Talk(SAY_EADRIC_EMOTE_RADIANCE);
        }, 16s);

        ScheduleTimedEvent(25s, [this]
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 55.0f, true))
            {
                Talk(SAY_EADRIC_EMOTE_HAMMER_RIGHTEOUS, target);
                Talk(SAY_EADRIC_HAMMER_RIGHTEOUS);
                DoCast(target, SPELL_HAMMER_JUSTICE, true);
                DoCast(target, SPELL_HAMMER_RIGHTEOUS);
            }
        }, 25s);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_HAMMER_RIGHTEOUS_THROW_BACK && me->GetHealth() == 1)
            DoCastSelf(SPELL_EADRIC_ACHIEVEMENT, true);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;
            if (me->GetFaction() != FACTION_FRIENDLY)
            {
                DoCastAOE(SPELL_EADRIC_CREDIT, true);
                me->GetMap()->UpdateEncounterState(ENCOUNTER_CREDIT_CAST_SPELL, SPELL_PALETRESS_CREDIT, me); // paletress' spell credits encounter, but shouldn't credit achievements
                me->SetFaction(FACTION_FRIENDLY);
                scheduler.CancelAll();
                Talk(SAY_EADRIC_DEFEATED);
                me->GetThreatMgr().ClearAllThreat();
                me->SetRegeneratingHealth(false);
                _EnterEvadeMode();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(true);
                instance->SetBossState(BOSS_ARGENT_CHALLENGE, DONE);
            }
        }
    }
};

struct boss_paletress : public BossAI
{
    boss_paletress(Creature* creature) : BossAI(creature, BOSS_ARGENT_CHALLENGE)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        if (_memoryGUID)
        {
            if (Creature* memory = ObjectAccessor::GetCreature(*me, _memoryGUID))
                memory->DespawnOrUnsummon();
            _memoryGUID.Clear();
        }
        me->SetReactState(REACT_PASSIVE);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == 1)
            me->SetFacingTo(3 * M_PI / 2);
    }

    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
            Talk(SAY_PALETRESS_KILL_PLAYER);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
        Talk(SAY_PALETRESS_AGGRO);

        ScheduleTimedEvent(9s, 12s, [this] { DoCastRandomTarget(SPELL_HOLY_FIRE, 0, 30.0f, true); }, 9s, 12s);
        ScheduleTimedEvent(2s, 3s, [this] { DoCastRandomTarget(SPELL_SMITE, 0, 50.0f, true); }, 3s, 4s);

        ScheduleHealthCheckEvent(25, [this]
        {
            me->InterruptNonMeleeSpells(true);
            Talk(SAY_PALETRESS_MEMORY_SUMMON);
            DoCastAOE(SPELL_HOLY_NOVA);
            DoCastSelf(SPELL_SHIELD);
            DoCastAOE(SPELL_SUMMON_MEMORY);
            SummonMemory();
            DoCastAOE(SPELL_CONFESS);
            scheduler.Schedule(6s, 8s, [this](TaskContext context)
            {
                if (!_memoryGUID)
                    return;
                if (urand(0, 1))
                    DoCastSelf(SPELL_RENEW);
                else if (Creature* memory = ObjectAccessor::GetCreature(*me, _memoryGUID))
                    if (memory->IsAlive())
                        DoCast(memory, SPELL_RENEW);
                context.Repeat(15s, 17s);
            });
        });
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_MEMORY_DIED)
        {
            _memoryGUID.Clear();
            me->RemoveAura(SPELL_SHIELD);
            Talk(SAY_PALETRESS_MEMORY_DEATH);
        }
        else if (action == ACTION_DESPAWN_MEMORY)
        {
            if (_memoryGUID)
                if (Creature* memory = ObjectAccessor::GetCreature(*me, _memoryGUID))
                {
                    memory->DespawnOrUnsummon();
                    _memoryGUID.Clear();
                }
        }
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override
    {
        BossAI::DamageTaken(attacker, damage, damagetype, damageSchoolMask);

        if (damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;

            if (me->GetFaction() != FACTION_FRIENDLY)
            {
                DoCastAOE(SPELL_PALETRESS_CREDIT, true);
                me->SetFaction(FACTION_FRIENDLY);
                scheduler.CancelAll();
                Talk(SAY_PALETRESS_DEFEATED);
                me->GetThreatMgr().ClearAllThreat();
                me->SetRegeneratingHealth(false);
                _EnterEvadeMode();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(true);
                instance->SetBossState(BOSS_ARGENT_CHALLENGE, DONE);
                instance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_PALETRESS_ACHIEVEMENT);
            }
        }
    }

    void JustSummoned(Creature* summon) override
    {
        BossAI::JustSummoned(summon);
        instance->SetData(DATA_MEMORY_ENTRY, summon->GetEntry());
        _memoryGUID = summon->GetGUID();
    }

    void SummonMemory()
    {
        static uint32 const MemorySummonSpells[] =
        {
            66704, 66705, 66706, 66707, 66709, 66710, 66711, 66712, 66713, 66714, 66715, 66708, 66708,
            66691, 66692, 66694, 66695, 66696, 66697, 66698, 66699, 66700, 66701, 66702, 66703, 66543
        };

        DoCastSelf(MemorySummonSpells[urand(0, uint32(std::size(MemorySummonSpells)) - 1)], true);
    }

private:
    ObjectGuid _memoryGUID;
};

struct npc_memory : public CreatureAI
{
    npc_memory(Creature* creature) : CreatureAI(creature), _instance(creature->GetInstanceScript())
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetObjectScale(0.01f);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToAll(true);

        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        scheduler.Schedule(500ms, [this](TaskContext context)
        {
            me->SetObjectScale(1.0f);

            context.Schedule(5s, [this](TaskContext context)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(false);
                if (Unit* target = me->SelectNearestTarget(200.0f))
                {
                    AttackStart(target);
                    DoZoneInCombat();
                }
                me->SetReactState(REACT_AGGRESSIVE);

                context.Schedule(8s, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_OLD_WOUNDS, 0, 10.0f, true, true);
                    context.Repeat(12s);
                });
                context.Schedule(4s, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_SHADOWS_PAST, 0, 40.0f, true);
                    context.Repeat(15s, 20s);
                });
                context.Schedule(20s, 30s, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_WAKING_NIGHTMARE);
                    context.Repeat(35s);
                });
            });
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->DespawnOrUnsummon(20s);
        if (_instance)
            if (Creature* paletress = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_PALETRESS)))
                paletress->AI()->DoAction(ACTION_MEMORY_DIED);
    }

    void UpdateAI(uint32 diff) override
    {
        UpdateVictim();

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

private:
    InstanceScript* _instance;
};

enum CreatureIds
{
    NPC_FOUNTAIN_OF_LIGHT               = 35311,
};

enum ArgentSoldierSpells
{
    // monk
    SPELL_FLURRY_OF_BLOWS               = 67233,
    SPELL_PUMMEL                        = 67235,
    SPELL_DIVINE_SHIELD                 = 67251,
    SPELL_FINAL_MEDITATION              = 67255,

    // priestess
    SPELL_HOLY_SMITE                    = 36176,
    SPELL_FOUNTAIN_OF_LIGHT             = 67194,
    SPELL_SHADOW_WORD_PAIN              = 34941,
    SPELL_MIND_CONTROL                  = 67229,

    // lightwielder
    SPELL_BLAZING_LIGHT                 = 67247,
    SPELL_CLEAVE                        = 15284,
    SPELL_UNBALANCING_STRIKE            = 67237,
};

struct npc_argent_soldier : public npc_escortAI
{
    npc_argent_soldier(Creature* creature) : npc_escortAI(creature), _instance(creature->GetInstanceScript())
    {
        me->SetReactState(REACT_PASSIVE);
        SetDespawnAtEnd(false);
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
        _finalMeditation = false;
    }

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 point) override
    {
        if (point == 1)
        {
            switch (_waypoint)
            {
                case 0:
                    me->SetFacingTo(5.4f);
                    break;
                case 1:
                    me->SetFacingTo(4.6f);
                    break;
                case 2:
                    me->SetFacingTo(4.0f);
                    break;
            }
        }
    }

    void SetData(uint32 waypoint, uint32 /*data*/) override
    {
        AddWaypoint(0, me->GetPositionX(), 660.0f, 411.80f);
        switch (me->GetEntry())
        {
            case NPC_ARGENT_LIGHTWIELDER:
                switch (waypoint)
                {
                    case 0:
                        AddWaypoint(1, 716.321f, 647.047f, 411.93f);
                        break;
                    case 1:
                        AddWaypoint(1, 742.44f, 650.29f, 411.79f);
                        break;
                    case 2:
                        AddWaypoint(1, 772.6314f, 651.7f, 411.93f);
                        break;
                }
                break;
            case NPC_ARGENT_MONK:
                switch (waypoint)
                {
                    case 0:
                        AddWaypoint(1, 717.86f, 649.0f, 411.923f);
                        break;
                    case 1:
                        AddWaypoint(1, 746.73f, 650.24f, 411.56f);
                        break;
                    case 2:
                        AddWaypoint(1, 775.567f, 648.26f, 411.93f);
                        break;
                }
                break;
            case NPC_PRIESTESS:
                switch (waypoint)
                {
                    case 0:
                        AddWaypoint(1, 719.872f, 650.94f, 411.93f);
                        break;
                    case 1:
                        AddWaypoint(1, 750.72f, 650.20f, 411.77f);
                        break;
                    case 2:
                        AddWaypoint(1, 777.78f, 645.70f, 411.93f);
                        break;
                }
                break;
        }

        me->SetWalk(false);
        Start(false);
        _waypoint = waypoint;
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (_finalMeditation && damage >= me->GetHealth())
        {
            _finalMeditation = false;
            damage = me->GetHealth() - 1;
            scheduler.DelayAll(10s);
            DoCastSelf(SPELL_DIVINE_SHIELD, true);
            DoCastAOE(SPELL_FINAL_MEDITATION, true);
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        switch (me->GetEntry())
        {
            case NPC_ARGENT_MONK:
                ScheduleTimedEvent(5s, [this] { DoCastSelf(SPELL_FLURRY_OF_BLOWS); }, 12s, 18s);
                ScheduleTimedEvent(7s, [this] { DoCastVictim(SPELL_PUMMEL); }, 8s, 11s);
                if (IsHeroic())
                    _finalMeditation = true;
                break;
            case NPC_PRIESTESS:
                ScheduleTimedEvent(5s, 8s, [this] { DoCastVictim(SPELL_HOLY_SMITE); }, 6s, 8s);
                ScheduleTimedEvent(3s, 6s, [this] { DoCastVictim(SPELL_SHADOW_WORD_PAIN); }, 12s, 15s);
                ScheduleTimedEvent(8s, 15s, [this] { DoCastAOE(SPELL_FOUNTAIN_OF_LIGHT); }, 35s, 45s);
                if (IsHeroic())
                    ScheduleTimedEvent(12s, [this] { DoCastRandomTarget(SPELL_MIND_CONTROL, 0, 30.0f, true); }, 22s, 30s);
                break;
            case NPC_ARGENT_LIGHTWIELDER:
                ScheduleTimedEvent(12s, 15s, [this]
                {
                    Unit* target = DoSelectLowestHpFriendly(40.0f);
                    if (!target)
                        target = me;
                    DoCast(target, SPELL_BLAZING_LIGHT);
                }, 8s, 12s);
                ScheduleTimedEvent(3s, 5s, [this] { DoCastVictim(SPELL_CLEAVE); }, 6s, 8s);
                if (IsHeroic())
                    ScheduleTimedEvent(8s, 12s, [this] { DoCastVictim(SPELL_UNBALANCING_STRIKE); }, 12s, 15s);
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        npc_escortAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->DespawnOrUnsummon(10s);
        if (_instance)
            _instance->SetData(DATA_ARGENT_SOLDIER_DEFEATED, 0);
    }

private:
    InstanceScript* _instance;
    uint8 _waypoint = 0;
    bool _finalMeditation = false;
};

class spell_eadric_radiance : public SpellScript
{
    PrepareSpellScript(spell_eadric_radiance);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        std::list<WorldObject*> tmplist;
        for( std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if ((*itr)->ToUnit()->HasInArc(M_PI, GetCaster()))
                tmplist.push_back(*itr);

        targets.clear();
        for( std::list<WorldObject*>::iterator itr = tmplist.begin(); itr != tmplist.end(); ++itr )
            targets.push_back(*itr);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_eadric_radiance::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_eadric_radiance::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_toc5_light_rain : public SpellScript
{
    PrepareSpellScript(spell_toc5_light_rain);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        for( std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); )
        {
            if ((*itr)->IsCreature())
                if ((*itr)->ToCreature()->GetEntry() == NPC_FOUNTAIN_OF_LIGHT)
                {
                    targets.erase(itr);
                    itr = targets.begin();
                    continue;
                }
            ++itr;
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_toc5_light_rain::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

enum ReflectiveShield
{
    SPELL_REFLECTIVE_SHIELD_DAMAGE = 33619
};

class spell_reflective_shield_aura : public AuraScript
{
    PrepareAuraScript(spell_reflective_shield_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_REFLECTIVE_SHIELD_DAMAGE });
    }

    void HandleAfterEffectAbsorb(AuraEffect*   /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        if (Unit* attacker = dmgInfo.GetAttacker())
            if (GetOwner() && attacker->GetGUID() != GetOwner()->GetGUID())
            {
                int32 damage = (int32)(absorbAmount * 0.25f);
                GetOwner()->ToUnit()->CastCustomSpell(attacker, SPELL_REFLECTIVE_SHIELD_DAMAGE, &damage, nullptr, nullptr, true);
            }
    }

    void Register() override
    {
        AfterEffectAbsorb += AuraEffectAbsorbFn(spell_reflective_shield_aura::HandleAfterEffectAbsorb, EFFECT_0);
    }
};

void AddSC_boss_argent_challenge()
{
    RegisterTrialOfTheChampionCreatureAI(boss_eadric);
    RegisterTrialOfTheChampionCreatureAI(boss_paletress);
    RegisterTrialOfTheChampionCreatureAI(npc_memory);
    RegisterTrialOfTheChampionCreatureAI(npc_argent_soldier);
    RegisterSpellScript(spell_eadric_radiance);
    RegisterSpellScript(spell_toc5_light_rain);
    RegisterSpellScript(spell_reflective_shield_aura);
}
