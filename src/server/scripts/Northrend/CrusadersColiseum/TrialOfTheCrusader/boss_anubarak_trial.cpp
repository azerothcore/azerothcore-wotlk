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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SharedDefines.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_crusader.h"

enum AnubTexts
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    EMOTE_SUBMERGE          = 2,
    EMOTE_BURROWER          = 3,
    SAY_EMERGE              = 4,
    SAY_LEECHING_SWARM      = 5,
    EMOTE_LEECHING_SWARM    = 6,
    SAY_KILL_PLAYER         = 7,
    SAY_DEATH               = 8,

    EMOTE_SPIKE             = 0,
};

enum AnubNPCs
{
    NPC_FROST_SPHERE                            = 34606,
    NPC_BURROW                                  = 34862,
    NPC_BURROWER                                = 34607,
    NPC_SCARAB                                  = 34605,
    NPC_SPIKE                                   = 34660,
};

enum AnubActions
{
    ACTION_SCARAB_SUBMERGE                      = 1,
    ACTION_SPIKE_FAIL                           = 2,
};

enum AnubModels
{
    MODEL_INVISIBLE_STALKER                     = 11686,
};

Position const AnubLocs[] =
{
    // scarab's beginning pos
    {722.65f, 135.41f, 142.16f, M_PI},

    // churning ground spawns
    {694.886353f, 102.484665f, 142.119614f, 0.0f},
    {731.987244f, 83.3824690f, 142.119614f, 0.0f},
    {694.500671f, 185.363968f, 142.117905f, 0.0f},
    {740.184509f, 193.443390f, 142.117584f, 0.0f},

    // sphere spawns
    { 786.6439f, 108.2498f, 155.6701f, 0.0f },
    { 806.8429f, 150.5902f, 155.6701f, 0.0f },
    { 759.1386f, 163.9654f, 155.6701f, 0.0f },
    { 744.3701f, 119.5211f, 155.6701f, 0.0f },
    { 710.0211f, 120.8152f, 155.6701f, 0.0f },
    { 706.6383f, 161.5266f, 155.6701f, 0.0f },
};

class HideNpcEvent : public BasicEvent
{
public:
    HideNpcEvent(Creature& owner) : _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.SetVisible(false);
        return true;
    }

private:
    Creature& _owner;
};

enum AnubSpells
{
    // Anub'arak
    SPELL_SUBMERGE                              = 65981,
    SPELL_EMERGE                                = 65982,
    SPELL_BERSERK                               = 26662,
    SPELL_CLEAR_ALL_DEBUFFS                     = 34098,

    SPELL_FREEZING_SLASH                        = 66012,
    SPELL_PENETRATING_COLD                      = 66013,
    SPELL_SUMMON_SCARAB                         = 66339,
    SPELL_SUMMON_BURROWER                       = 66332,
    SPELL_LEECHING_SWARM                        = 66118,

    // Anub'arak Pursue
    SPELL_MARK                                  = 67574,
    SPELL_SUMMON_SPIKE                          = 66169,
    SPELL_SPIKE_SPEED1                          = 65920,
    SPELL_SPIKE_TRAIL                           = 65921,
    SPELL_SPIKE_SPEED2                          = 65922,
    SPELL_SPIKE_SPEED3                          = 65923,
    SPELL_SPIKE_FAIL                            = 66181,
    SPELL_SPIKE_TELE                            = 66170,
    SPELL_IMPALE                                = 65919,

    // Scarab
    SPELL_DETERMINATION                         = 66092,
    SPELL_ACID_MANDIBLE                         = 65774,

    // Burrow
    SPELL_CHURNING_GROUND                       = 66969,

    // Frost Sphere
    SPELL_FROST_SPHERE                          = 67539,
    SPELL_PERMAFROST                            = 66193,
    SPELL_PERMAFROST_VISUAL                     = 65882,

    // Burrower
    SPELL_SPIDER_FRENZY                         = 66128,
    SPELL_EXPOSE_WEAKNESS                       = 67720,
    SPELL_SHADOW_STRIKE                         = 66134,
    SPELL_SUBMERGE_EFFECT                       = 53421,
    SPELL_EMERGE_EFFECT                         = 66947,
};

enum AnubEvents
{
    EVENT_RESPAWN_SPHERE = 1,
    EVENT_ENRAGE,
    EVENT_SPELL_FREEZING_SLASH,
    EVENT_SPELL_PENETRATING_COLD,
    EVENT_SUMMON_NERUBIAN,
    EVENT_SUBMERGE,
    EVENT_EMERGE,
    EVENT_EMERGE_2,
    EVENT_SPELL_SUMMON_SPIKE,
    EVENT_SPELL_SHADOW_STRIKE,
    EVENT_SUMMON_SCARAB,
    EVENT_SPELL_DETERMINATION,
};

struct boss_anubarak_trial : public BossAI
{
    boss_anubarak_trial(Creature* creature) : BossAI(creature, BOSS_ANUBARAK)
    {
        _intro = false;
        _phase3 = false;
        me->ApplySpellImmune(0, IMMUNITY_ID, sSpellMgr->GetSpellIdForDifficulty(SPELL_PERMAFROST, me), true);
        me->m_SightDistance = 90.0f; // for MoveInLineOfSight distance
    }

    void Reset() override
    {
        _Reset();
        me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        for (uint8 i = 0; i < 10; ++i)
        {
            float angle = rand_norm() * 2 * M_PI;
            float dist = rand_norm() * 40.0f;
            if (Creature* scarab = me->SummonCreature(NPC_SCARAB, AnubLocs[0].GetPositionX() + cos(angle) * dist, AnubLocs[0].GetPositionY() + std::sin(angle) * dist, AnubLocs[0].GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
            {
                scarab->SetFaction(FACTION_PREY);
                scarab->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                scarab->GetMotionMaster()->MoveRandom(15.0f);
            }
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_ANUBARAK_DESPAWN_SUMMONS)
            summons.DespawnAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        events.Reset();
        events.RescheduleEvent(EVENT_ENRAGE, 10min);
        events.RescheduleEvent(EVENT_SPELL_FREEZING_SLASH, 7s, 15s);
        events.RescheduleEvent(EVENT_SPELL_PENETRATING_COLD, 15s, 20s);
        events.RescheduleEvent(EVENT_SUMMON_NERUBIAN, 5s, 8s);
        events.RescheduleEvent(EVENT_SUBMERGE, 80s);
        if (!IsHeroic())
            events.RescheduleEvent(EVENT_RESPAWN_SPHERE, 4s);

        for (ObjectGuid const& guid : summons)
        {
            if (Creature* scarab = instance->instance->GetCreature(guid))
            {
                scarab->GetMotionMaster()->MoveIdle();
                scarab->StopMoving();
                scarab->CastSpell(scarab, SPELL_SUBMERGE, false);
                scarab->AI()->DoAction(ACTION_SCARAB_SUBMERGE);
            }
        }
        summons.clear();
        for (uint8 i = 0; i < 4; ++i)
        {
            if (Creature* burrow = me->SummonCreature(NPC_BURROW, AnubLocs[i + 1]))
                _burrowGUIDs[i] = burrow->GetGUID();
        }
        for (uint8 i = 0; i < 6; ++i)
        {
            if (Creature* sphere = me->SummonCreature(NPC_FROST_SPHERE, AnubLocs[i + 5]))
                _sphereGUIDs[i] = sphere->GetGUID();
        }

        Talk(SAY_AGGRO);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (!_phase3 && HealthBelowPct(30) && !me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) && !me->HasAura(SPELL_SUBMERGE) && !me->HasAura(SPELL_EMERGE))
        {
            _phase3 = true;
            events.CancelEvent(EVENT_SUBMERGE);
            events.CancelEvent(EVENT_EMERGE);
            events.CancelEvent(EVENT_EMERGE_2);
            if (!IsHeroic())
                events.CancelEvent(EVENT_SUMMON_NERUBIAN);
            DoCastAOE(SPELL_LEECHING_SWARM);
            Talk(EMOTE_LEECHING_SWARM);
            Talk(SAY_LEECHING_SWARM);
            return;
        }

        switch (events.ExecuteEvent())
        {
            case EVENT_ENRAGE:
                DoCastSelf(SPELL_BERSERK, true);
                break;
            case EVENT_RESPAWN_SPHERE:
                {
                    uint8 startAt = urand(0, 5);
                    uint8 i = startAt;
                    do
                    {
                        if (Creature* sphere = ObjectAccessor::GetCreature(*me, _sphereGUIDs[i]))
                            if (!sphere->HasAura(SPELL_FROST_SPHERE))
                            {
                                if (Creature* newSphere = me->SummonCreature(NPC_FROST_SPHERE, AnubLocs[i + 5]))
                                    _sphereGUIDs[i] = newSphere->GetGUID();
                                break;
                            }
                        i = (i + 1) % 6;
                    } while (i != startAt);
                    events.Repeat(4s);
                }
                break;
            case EVENT_SPELL_FREEZING_SLASH:
                {
                    DoCastVictim(SPELL_FREEZING_SLASH);
                    events.Repeat(15s, 20s);
                }
                break;
            case EVENT_SPELL_PENETRATING_COLD:
                {
                    me->CastCustomSpell(SPELL_PENETRATING_COLD, SPELLVALUE_MAX_TARGETS, RAID_MODE(2, 5, 2, 5));
                    events.Repeat(18s);
                }
                break;
            case EVENT_SUMMON_NERUBIAN:
                {
                    me->CastCustomSpell(SPELL_SUMMON_BURROWER, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 2, 2, 4));
                    events.Repeat(45s);
                }
                break;
            case EVENT_SUBMERGE:
                {
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    bool berserk = me->HasAura(SPELL_BERSERK);
                    DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                    if (berserk)
                        DoCastSelf(SPELL_BERSERK, true);
                    Talk(EMOTE_SUBMERGE);
                    Talk(EMOTE_BURROWER);
                    DoCastSelf(SPELL_SUBMERGE);
                    events.CancelEvent(EVENT_SUMMON_NERUBIAN);
                    events.CancelEvent(EVENT_SPELL_FREEZING_SLASH);
                    events.CancelEvent(EVENT_SPELL_PENETRATING_COLD);
                    events.RescheduleEvent(EVENT_EMERGE, 1min);
                    events.RescheduleEvent(EVENT_SPELL_SUMMON_SPIKE, 2500ms);
                    events.RescheduleEvent(EVENT_SUMMON_SCARAB, 3s);
                }
                break;
            case EVENT_SUMMON_SCARAB:
                {
                    uint8 i = urand(0, 3);
                    if (Creature* burrow = ObjectAccessor::GetCreature(*me, _burrowGUIDs[i]))
                        DoCast(burrow, SPELL_SUMMON_SCARAB, true);
                    events.Repeat(4s);
                }
                break;
            case EVENT_EMERGE:
                {
                    DoCastSelf(SPELL_SPIKE_TELE, true);
                    summons.DespawnEntry(NPC_SPIKE);
                    events.CancelEvent(EVENT_SUMMON_SCARAB);
                    events.RescheduleEvent(EVENT_EMERGE_2, 2s);
                }
                break;
            case EVENT_EMERGE_2:
                {
                    Talk(SAY_EMERGE);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->setAttackTimer(BASE_ATTACK, 3000);
                    me->RemoveAura(SPELL_SUBMERGE);
                    DoCastSelf(SPELL_EMERGE);
                    events.RescheduleEvent(EVENT_SUMMON_NERUBIAN, 5s, 8s);
                    events.RescheduleEvent(EVENT_SPELL_FREEZING_SLASH, 7s, 15s);
                    events.RescheduleEvent(EVENT_SPELL_PENETRATING_COLD, 15s, 20s);
                    events.RescheduleEvent(EVENT_SUBMERGE, 80s);
                }
                break;
            case EVENT_SPELL_SUMMON_SPIKE:
                DoCastSelf(SPELL_SUMMON_SPIKE, true);
                break;
            default:
                break;
        }

        DoMeleeAttackIfReady();
    }

    // BossAI's default would also zone-pull the burrows and frost spheres into combat.
    void JustSummoned(Creature* summon) override
    {
        if (!summon)
            return;

        summons.Summon(summon);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
            Talk(SAY_KILL_PLAYER);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        events.Reset();
        summons.DespawnAll();
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        instance->SetData(TYPE_FAILED, 1);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!who->IsPlayer() || me->GetExactDistSq(who) > 6400.0f) // 80yd*80yd
            return;

        if (me->getStandState() != UNIT_STAND_STATE_STAND)
            me->SetStandState(UNIT_STAND_STATE_STAND);

        if (!_intro)
        {
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if (!me->IsInCombat())
                Talk(SAY_INTRO);
            _intro = true;
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetEntry() != NPC_FROST_SPHERE;
    }

private:
    bool _intro;
    bool _phase3;
    ObjectGuid _sphereGUIDs[6];
    ObjectGuid _burrowGUIDs[4];
};

struct npc_swarm_scarab : public ScriptedAI
{
    npc_swarm_scarab(Creature* creature) : ScriptedAI(creature), _submerged(false) {}

    void DoAction(int32 param) override
    {
        if (param == ACTION_SCARAB_SUBMERGE)
        {
            _submerged = true;
            scheduler.Schedule(2s, [this](TaskContext /*context*/)
            {
                me->DisappearAndDie();
            });
        }
    }

    void Reset() override
    {
        me->SetCorpseDelay(10 * 60);
        DoCastSelf(SPELL_ACID_MANDIBLE, true);
        events.Reset();
        events.ScheduleEvent(EVENT_SPELL_DETERMINATION, 10s, 50s);
        _submerged = false;
        scheduler.CancelAll();
        if (me->GetFaction() == FACTION_MONSTER_2) // hostile - it's phase 2
            if (Unit* target = me->SelectNearestTarget(250.0f))
            {
                AttackStart(target);
                DoZoneInCombat();
                if (Unit* randomTarget = SelectTarget(SelectTargetMethod::Random, 0, 250.0f, true))
                {
                    me->AddThreat(randomTarget, 20000.0f);
                    AttackStart(randomTarget);
                }
            }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoZoneInCombat();
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        // Submerged scarabs only wait for their despawn.
        if (_submerged)
            return;

        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (events.ExecuteEvent() == EVENT_SPELL_DETERMINATION)
        {
            DoCastSelf(SPELL_DETERMINATION);
            events.Repeat(20s, 60s);
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_TRAITOR_KING, true);
        me->m_Events.AddEventAtOffset(new HideNpcEvent(*me), 5s);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetEntry() != NPC_FROST_SPHERE && !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
    }

private:
    bool _submerged;
};

struct npc_frost_sphere : public NullCreatureAI
{
    npc_frost_sphere(Creature* creature) : NullCreatureAI(creature)
    {
        me->ApplySpellImmune(0, IMMUNITY_ID, sSpellMgr->GetSpellIdForDifficulty(SPELL_LEECHING_SWARM, me), true);

        DoCastSelf(SPELL_FROST_SPHERE, true);
        me->GetMotionMaster()->MoveRandom(20.0f);
        me->SetCorpseDelay(15 * 60 * 1000);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->GetHealth() <= damage)
        {
            damage = 0;
            if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
            {
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->GetMotionMaster()->MoveIdle();
                me->GetMotionMaster()->MoveCharge(me->GetPositionX(), me->GetPositionY(), 143.0f, 20.0f);
                scheduler.Schedule(1500ms, [this](TaskContext /*context*/)
                {
                    me->RemoveAurasDueToSpell(SPELL_FROST_SPHERE);
                    me->SetDisplayId(MODEL_INVISIBLE_STALKER);
                    me->SetObjectScale(2.0f);
                    me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), 142.7f, me->GetOrientation(), false);
                    me->SetFacingTo(me->GetOrientation());
                    DoCastSelf(SPELL_PERMAFROST_VISUAL, true);
                    DoCastSelf(SPELL_PERMAFROST, true);
                    me->SetCanFly(false);
                });
            }
        }
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_SPIKE_FAIL)
        {
            me->RemoveAllAuras();
            me->DespawnOrUnsummon(1500ms);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

struct npc_nerubian_burrower : public ScriptedAI
{
    npc_nerubian_burrower(Creature* creature) : ScriptedAI(creature)
    {
        // I am summoned by another npc (SPELL_EFFECT_FORCE_CAST), inform Anub'arak
        if (InstanceScript* instance = me->GetInstanceScript())
            if (ObjectGuid guid = instance->GetGuidData(TYPE_ANUBARAK))
                if (Creature* anub = instance->instance->GetCreature(guid))
                    anub->AI()->JustSummoned(me);
    }

    void Reset() override
    {
        me->SetCorpseDelay(10 * 60);
        DoCastSelf(SPELL_EXPOSE_WEAKNESS, true);
        DoCastSelf(SPELL_SPIDER_FRENZY, true);
        events.Reset();
        events.RescheduleEvent(EVENT_SUBMERGE, 30s);
        if (IsHeroic())
            events.RescheduleEvent(EVENT_SPELL_SHADOW_STRIKE, 30s, 45s);
        if (Unit* target = me->SelectNearestTarget(250.0f))
        {
            AttackStart(target);
            DoZoneInCombat();
        }
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spell) override
    {
        if (!target || !spell)
            return;

        if (spell->Id == SPELL_SHADOW_STRIKE)
        {
            float o = target->GetOrientation();
            if (o >= M_PI)
                o -= M_PI;
            else
                o += M_PI;
            me->NearTeleportTo(target->GetPositionX() + cos(o) * 5.0f, target->GetPositionY() + std::sin(o) * 5.0f, target->GetPositionZ() + 0.6f, target->GetOrientation());
            AttackStart(target);
            me->GetMotionMaster()->MoveChase(target);
            events.DelayEvents(3s);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_SPELL_SHADOW_STRIKE:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 250.0f, true))
                    DoCast(target, SPELL_SHADOW_STRIKE);
                events.Repeat(30s, 45s);
                break;
            case EVENT_SUBMERGE:
                if (HealthBelowPct(80) && !me->HasAura(sSpellMgr->GetSpellIdForDifficulty(SPELL_PERMAFROST, me))) // not having permafrost - allow submerge
                {
                    me->GetMotionMaster()->MoveIdle();
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                    DoCastSelf(SPELL_EXPOSE_WEAKNESS, true);
                    DoCastSelf(SPELL_SPIDER_FRENZY, true);
                    DoCastSelf(SPELL_SUBMERGE);

                    events.DelayEvents(15s);
                    events.RescheduleEvent(EVENT_EMERGE, 10s);
                }
                else
                    events.Repeat(3s);
                break;
            case EVENT_EMERGE:
                me->SetHealth(me->GetMaxHealth());
                me->GetMotionMaster()->MoveChase(me->GetVictim());
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                DoCastSelf(SPELL_EMERGE);
                me->RemoveAura(SPELL_SUBMERGE);

                events.RescheduleEvent(EVENT_SUBMERGE, 30s);
                break;
            default:
                break;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->m_Events.AddEventAtOffset(new HideNpcEvent(*me), 5s);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetEntry() != NPC_FROST_SPHERE;
    }
};

struct npc_anubarak_spike : public ScriptedAI
{
    npc_anubarak_spike(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetCorpseDelay(0);
    }

    enum SpikeEvents
    {
        EVENT_SPIKE_SPEED_2 = 1,
        EVENT_SPIKE_SPEED_3,
        EVENT_SPIKE_RESUME,
        EVENT_SPIKE_REACQUIRE,
    };

    void DoAction(int32 param) override
    {
        if (param == ACTION_SPIKE_FAIL)
        {
            if (Unit* target = ObjectAccessor::GetPlayer(*me, _targetGUID))
                target->RemoveAura(SPELL_MARK);
            _targetGUID.Clear();
            me->RemoveAllAuras();
            me->GetMotionMaster()->MoveIdle();
            events.Reset();
            events.RescheduleEvent(EVENT_SPIKE_RESUME, 4s);
        }
    }

    bool CanPursue(Unit* target) const
    {
        // Physical immunity (Hand of Protection) does not break pursuit, but full immunity does.
        return target && me->IsValidAttackTarget(target) && !target->HasAuraType(SPELL_AURA_FEIGN_DEATH)
            && !target->HasStealthAura()
            && !target->HasSchoolImmunityForMask(SPELL_SCHOOL_MASK_ALL, me, nullptr);
    }

    void SelectNewTarget(bool next)
    {
        events.CancelEvent(EVENT_SPIKE_REACQUIRE);
        if (_targetGUID)
            if (Unit* target = ObjectAccessor::GetPlayer(*me, _targetGUID))
                target->RemoveAura(SPELL_MARK);
        _targetGUID.Clear();
        me->AttackStop();
        me->GetMotionMaster()->MoveIdle();
        if (!next)
        {
            events.Reset();
            me->RemoveAllAuras();
            // Start the pursuit even if everyone is currently immune, so acquisition can retry.
            DoCastSelf(SPELL_SPIKE_SPEED1, true);
            DoCastSelf(SPELL_SPIKE_TRAIL, true);
            events.RescheduleEvent(EVENT_SPIKE_SPEED_2, 7s);
        }
        DoZoneInCombat();
        DoResetThreatList();
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [this](Unit* candidate)
        {
            return DefaultTargetSelector(me, 250.0f, true, true, 0)(candidate) && CanPursue(candidate);
        }))
        {
            _targetGUID = target->GetGUID();
            DoCast(target, SPELL_MARK, true);
            Talk(EMOTE_SPIKE, target);
            AttackStart(target);
            me->GetMotionMaster()->MoveChase(target);
        }
        else
            events.RescheduleEvent(EVENT_SPIKE_REACQUIRE, 300ms);
    }

    void Reset() override
    {
        SelectNewTarget(false);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_targetGUID)
        {
            Unit* target = ObjectAccessor::GetPlayer(*me, _targetGUID);
            // Reaching the marked player clears CHASE_MOVE; that is not a reason to abandon pursuit.
            if (!CanPursue(target) || !target->HasAura(SPELL_MARK) || me->GetVictim() != target
                || me->GetMotionMaster()->GetCurrentMovementGeneratorType() != CHASE_MOTION_TYPE)
                SelectNewTarget(true);
        }

        events.Update(diff);

        switch (events.ExecuteEvent())
        {
            case EVENT_SPIKE_SPEED_2:
                DoCastSelf(SPELL_SPIKE_SPEED2, true);

                events.RescheduleEvent(EVENT_SPIKE_SPEED_3, 7s);
                break;
            case EVENT_SPIKE_SPEED_3:
                DoCastSelf(SPELL_SPIKE_SPEED3, true);

                break;
            case EVENT_SPIKE_RESUME:
                Reset();
                break;
            case EVENT_SPIKE_REACQUIRE:
                SelectNewTarget(true);
                break;
            default:
                break;
        }
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }

private:
    ObjectGuid _targetGUID;
};

class spell_pursuing_spikes_aura : public AuraScript
{
    PrepareAuraScript(spell_pursuing_spikes_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPIKE_FAIL, SPELL_IMPALE });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Unit* target = GetTarget())
        {
            if (Creature* sphere = target->FindNearestCreature(NPC_FROST_SPHERE, 8.0f, true))
            {
                target->UpdatePosition(*sphere, false);
                target->CastCustomSpell(SPELL_SPIKE_FAIL, SPELLVALUE_MAX_TARGETS, 1);
                if (target->IsCreature())
                    target->ToCreature()->AI()->DoAction(ACTION_SPIKE_FAIL);
                Remove();
                return;
            }
            target->CastSpell((Unit*)nullptr, SPELL_IMPALE, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_pursuing_spikes_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 66118 Leeching Swarm
enum LeechingSwarmSpells
{
    SPELL_LEECHING_SWARM_DMG    = 66240,
    SPELL_LEECHING_SWARM_HEAL   = 66125,
};

class spell_gen_leeching_swarm_aura : public AuraScript
{
    PrepareAuraScript(spell_gen_leeching_swarm_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LEECHING_SWARM_DMG, SPELL_LEECHING_SWARM_HEAL });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (Unit* caster = GetCaster())
        {
            int32 lifeLeeched = GetTarget()->CountPctFromCurHealth(aurEff->GetAmount());
            if (lifeLeeched < 250)
                lifeLeeched = 250;
            // Damage
            caster->CastCustomSpell(GetTarget(), SPELL_LEECHING_SWARM_DMG, &lifeLeeched, 0, 0, true);
            // Heal is handled in damage spell. It has to heal the same amount, but some of the dmg can be resisted.
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_leeching_swarm_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_gen_leeching_swarm_dmg : public SpellScript
{
    PrepareSpellScript(spell_gen_leeching_swarm_dmg);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LEECHING_SWARM_HEAL });
    }

    void HandleAfterHit()
    {
        if (Unit* caster = GetCaster())
            if (GetHitDamage() > 0)
            {
                int32 damage = GetHitDamage();
                caster->CastCustomSpell(caster, SPELL_LEECHING_SWARM_HEAL, &damage, 0, 0, true);
            }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_gen_leeching_swarm_dmg::HandleAfterHit);
    }
};

void AddSC_boss_anubarak_trial()
{
    RegisterTrialOfTheCrusaderCreatureAI(boss_anubarak_trial);
    RegisterTrialOfTheCrusaderCreatureAI(npc_swarm_scarab);
    RegisterTrialOfTheCrusaderCreatureAI(npc_frost_sphere);
    RegisterTrialOfTheCrusaderCreatureAI(npc_nerubian_burrower);
    RegisterTrialOfTheCrusaderCreatureAI(npc_anubarak_spike);
    RegisterSpellScript(spell_pursuing_spikes_aura);
    RegisterSpellScript(spell_gen_leeching_swarm_aura);
    RegisterSpellScript(spell_gen_leeching_swarm_dmg);
}
