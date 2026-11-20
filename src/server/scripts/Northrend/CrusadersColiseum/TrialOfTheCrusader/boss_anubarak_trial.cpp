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
    NPC_SPIKE                                   = 34660,
    NPC_SKITTERING_SCARAB                       = 35763,
};

enum AnubActions
{
    ACTION_SCARAB_SUBMERGE                      = 1, // read by the Skittering Scarab SmartAI (ACTION_DONE)
    ACTION_SPIKE_FAIL                           = 2,
    ACTION_INTRO_EMERGE                         = 3, // sent by the SmartAI of areatrigger 5475 (his chamber)
};

Position const AnubLocs[] =
{
    // churning ground spawns
    {694.886353f, 102.484665f, 142.119614f, 0.0f},
    {731.987244f, 83.3824690f, 142.119614f, 0.0f},
    {694.500671f, 185.363968f, 142.117905f, 0.0f},
    {740.184509f, 193.443390f, 142.117584f, 0.0f},

    // sphere spawns
    { 779.8038f, 150.6580f, 158.1426f, 0.0f },
    { 736.0243f, 113.4201f, 158.0226f, 0.0f },
    { 712.5712f, 160.9948f, 158.4368f, 0.0f },
    { 701.4271f, 126.4740f, 158.0205f, 0.0f },
    { 747.9202f, 155.0920f, 158.0613f, 0.0f },
    { 769.6285f, 121.1024f, 158.0504f, 0.0f },
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
    SPELL_DAZE_IMMUNITY                         = 53757,
    SPELL_DAZE_IMMUNITY_CANCEL                  = 59556,
    SPELL_RESET_CLEANUP                         = 66508,

    SPELL_FREEZING_SLASH                        = 66012,
    SPELL_PENETRATING_COLD                      = 66013,
    SPELL_SUMMON_SCARAB                         = 66339,
    SPELL_SUMMON_BURROWER                       = 66332,
    SPELL_LEECHING_SWARM                        = 66118,
    SPELL_FORCE_SHADOW_STRIKE                   = 66379,

    // Anub'arak Pursue
    SPELL_MARK                                  = 67574,
    SPELL_SUMMON_SPIKE                          = 66169,
    SPELL_SPIKE_SPEED1                          = 65920,
    SPELL_SPIKE_TRAIL                           = 65921,
    SPELL_SPIKE_SPEED2                          = 65922,
    SPELL_SPIKE_SPEED3                          = 65923,
    SPELL_SPIKE_FAIL                            = 66181,
    SPELL_SPIKE_TELE                            = 66170,
    SPELL_SPIKE_TARGET_SEARCH                   = 67470,
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
    SPELL_PERMAFROST_MODEL                      = 66185,

    // Burrower
    SPELL_SPIDER_FRENZY                         = 66128,
    SPELL_EXPOSE_WEAKNESS                       = 67720,
    SPELL_SHADOW_STRIKE                         = 66134,
    SPELL_RECENTLY_AWAKENED                     = 66311,
    SPELL_BURROWER_SUBMERGE                     = 67322,
    SPELL_SUBMERGE_BURROWER                     = 68394,
    SPELL_PERSISTENT_DIRT                       = 68048,
    SPELL_FULL_HEAL                             = 43978,
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
    EVENT_SUBMERGED,
    EVENT_SPELL_SHADOW_STRIKE,
    EVENT_SPELL_DETERMINATION,
};

struct boss_anubarak_trial : public BossAI
{
    boss_anubarak_trial(Creature* creature) : BossAI(creature, BOSS_ANUBARAK)
    {
        me->ApplySpellImmune(0, IMMUNITY_ID, sSpellMgr->GetSpellIdForDifficulty(SPELL_PERMAFROST, me), true);
    }

    void Reset() override
    {
        _Reset();
        _introPending = false;
        _phase3 = false;
    }

    void DoAction(int32 param) override
    {
        switch (param)
        {
            case ACTION_DESPAWN_SUMMONS:
                summons.DespawnAll();
                break;
            case ACTION_ANUBARAK_INTRO_SUBMERGE:
                _introPending = true;
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetImmuneToAll(true);
                DoCastSelf(SPELL_SUBMERGE);
                break;
            case ACTION_INTRO_EMERGE:
                if (!_introPending)
                    break;
                _introPending = false;
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAura(SPELL_SUBMERGE);
                DoCastSelf(SPELL_EMERGE);
                Talk(SAY_INTRO);
                me->m_Events.AddEventAtOffset([this]()
                {
                    me->SetImmuneToAll(false);
                }, 7s);
                break;
            default:
                break;
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        DoCastAOE(SPELL_DAZE_IMMUNITY, true);
        events.Reset();
        events.RescheduleEvent(EVENT_ENRAGE, 10min);
        events.RescheduleEvent(EVENT_SPELL_FREEZING_SLASH, 21s, 28s);
        events.RescheduleEvent(EVENT_SPELL_PENETRATING_COLD, 17s, 30s);
        events.RescheduleEvent(EVENT_SUMMON_NERUBIAN, 11s);
        events.RescheduleEvent(EVENT_SUBMERGE, 80s);
        if (IsHeroic())
            events.RescheduleEvent(EVENT_SPELL_SHADOW_STRIKE, 30s);
        else
            events.RescheduleEvent(EVENT_RESPAWN_SPHERE, 4s);

        // The scarabs submerge and despawn for their week-long respawn time, so they stay gone through wipes.
        std::list<Creature*> scarabs;
        me->GetCreatureListWithEntryInGrid(scarabs, NPC_SKITTERING_SCARAB, 150.0f);
        for (Creature* scarab : scarabs)
            scarab->AI()->DoAction(ACTION_SCARAB_SUBMERGE);

        for (uint8 i = 0; i < 4; ++i)
            me->SummonCreature(NPC_BURROW, AnubLocs[i]);
        for (uint8 i = 0; i < 6; ++i)
        {
            if (Creature* sphere = me->SummonCreature(NPC_FROST_SPHERE, AnubLocs[i + 4]))
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
                                if (Creature* newSphere = me->SummonCreature(NPC_FROST_SPHERE, AnubLocs[i + 4]))
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
                    events.Repeat(21s, 28s);
                }
                break;
            case EVENT_SPELL_PENETRATING_COLD:
                {
                    // Keeps going while submerged. Sniffed intervals are 18-21s there and spread wider on the surface.
                    me->CastCustomSpell(SPELL_PENETRATING_COLD, SPELLVALUE_MAX_TARGETS, RAID_MODE(2, 5, 2, 5));
                    if (me->HasAura(SPELL_SUBMERGE))
                        events.Repeat(18s, 21s);
                    else
                        events.Repeat(18s, 26s);
                }
                break;
            case EVENT_SUMMON_NERUBIAN:
                {
                    me->CastCustomSpell(SPELL_SUMMON_BURROWER, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 2, 2, 4));
                    events.Repeat(45s);
                }
                break;
            case EVENT_SPELL_SHADOW_STRIKE:
                DoCastAOE(SPELL_FORCE_SHADOW_STRIKE, true);
                events.Repeat(30500ms);
                break;
            case EVENT_SUBMERGE:
                {
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    Talk(EMOTE_SUBMERGE);
                    Talk(EMOTE_BURROWER);
                    DoCastSelf(SPELL_SUBMERGE);
                    events.CancelEvent(EVENT_SUMMON_NERUBIAN);
                    events.CancelEvent(EVENT_SPELL_FREEZING_SLASH);
                    events.CancelEvent(EVENT_SPELL_SHADOW_STRIKE);
                    events.RescheduleEvent(EVENT_EMERGE, 64700ms);
                    events.RescheduleEvent(EVENT_SUBMERGED, 3200ms);
                }
                break;
            case EVENT_SUBMERGED:
                DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                // Berserk lasts 5 minutes; refreshing it on each submerge keeps the 10-minute enrage up.
                if (me->HasAura(SPELL_BERSERK))
                    DoCastSelf(SPELL_BERSERK, true);
                DoCastSelf(SPELL_SUMMON_SPIKE, true);
                DoCastAOE(SPELL_SUMMON_SCARAB, true);
                break;
            case EVENT_EMERGE:
                {
                    DoCastSelf(SPELL_SPIKE_TELE, true);
                    summons.DespawnEntry(NPC_SPIKE);
                    events.RescheduleEvent(EVENT_EMERGE_2, 1600ms);
                }
                break;
            case EVENT_EMERGE_2:
                {
                    Talk(SAY_EMERGE);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->setAttackTimer(BASE_ATTACK, 3000);
                    me->RemoveAura(SPELL_SUBMERGE);
                    DoCastSelf(SPELL_EMERGE);
                    events.RescheduleEvent(EVENT_SUMMON_NERUBIAN, 5s);
                    events.RescheduleEvent(EVENT_SPELL_FREEZING_SLASH, 6s, 18s);
                    events.RescheduleEvent(EVENT_SUBMERGE, 74500ms);
                    if (IsHeroic())
                        events.RescheduleEvent(EVENT_SPELL_SHADOW_STRIKE, 35s);
                }
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
        DoResetCleanup();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
            Talk(SAY_KILL_PLAYER);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        DoResetCleanup();
        events.Reset();
        summons.DespawnAll();
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        instance->SetData(TYPE_FAILED, 1);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetEntry() != NPC_FROST_SPHERE;
    }

private:
    void DoResetCleanup()
    {
        DoCastAOE(SPELL_DAZE_IMMUNITY_CANCEL, true);
        DoCastAOE(SPELL_RESET_CLEANUP, true);
    }

    bool _introPending;
    bool _phase3;
    ObjectGuid _sphereGUIDs[6];
};

struct npc_swarm_scarab : public ScriptedAI
{
    npc_swarm_scarab(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        me->SetCorpseDelay(10 * 60);
        DoCastSelf(SPELL_ACID_MANDIBLE, true);
        events.Reset();
        // Sniffed scarabs cast it at most once, and only about a quarter of them ever do.
        if (roll_chance_i(25))
            events.ScheduleEvent(EVENT_SPELL_DETERMINATION, 1s, 50s);
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
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (events.ExecuteEvent() == EVENT_SPELL_DETERMINATION)
            DoCastSelf(SPELL_DETERMINATION);

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_TRAITOR_KING, true);
        me->m_Events.AddEventAtOffset(new HideNpcEvent(*me), 5s);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetEntry() != NPC_FROST_SPHERE;
    }
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
                    DoCastSelf(SPELL_PERMAFROST_MODEL, true);
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
            // Keep the Permafrost model until the despawn instead of flashing back to a sphere.
            me->RemoveAllAurasExceptType(SPELL_AURA_TRANSFORM);
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
    npc_nerubian_burrower(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        me->SetCorpseDelay(10 * 60);
        DoCastSelf(SPELL_EXPOSE_WEAKNESS, true);
        DoCastSelf(SPELL_SPIDER_FRENZY, true);
        DoCastSelf(SPELL_RECENTLY_AWAKENED, true);
        events.Reset();
        events.RescheduleEvent(EVENT_SUBMERGE, 1600ms);
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

    void OnSpellCast(SpellInfo const* spell) override
    {
        switch (spell->Id)
        {
            case SPELL_BURROWER_SUBMERGE:
                me->GetMotionMaster()->MoveIdle();
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                DoCastSelf(SPELL_SUBMERGE_BURROWER);
                break;
            case SPELL_SUBMERGE_BURROWER:
                DoCastSelf(SPELL_PERSISTENT_DIRT, true);
                DoCastSelf(SPELL_FULL_HEAL, true);
                events.CancelEvent(EVENT_SUBMERGE);
                events.DelayEvents(31s);
                events.RescheduleEvent(EVENT_EMERGE, 31s);
                break;
            default:
                break;
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
            case EVENT_SUBMERGE:
                if (HealthBelowPct(80) && !me->HasAura(sSpellMgr->GetSpellIdForDifficulty(SPELL_PERMAFROST, me))
                    && DoCastSelf(SPELL_BURROWER_SUBMERGE) == SPELL_CAST_OK)
                    events.Repeat(16s);
                else
                    events.Repeat(1600ms);
                break;
            case EVENT_EMERGE:
                me->GetMotionMaster()->MoveChase(me->GetVictim());
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAura(SPELL_SUBMERGE_BURROWER);
                DoCastSelf(SPELL_EMERGE);
                DoCastSelf(SPELL_SPIDER_FRENZY, true);

                events.RescheduleEvent(EVENT_SUBMERGE, 1600ms);
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
        EVENT_SPIKE_MARK,
    };

    void DoAction(int32 param) override
    {
        if (param == ACTION_SPIKE_FAIL)
        {
            if (Unit* target = ObjectAccessor::GetPlayer(*me, _targetGUID))
                target->RemoveAura(SPELL_MARK);
            _targetGUID.Clear();
            RemoveSpeedAuras();
            me->GetMotionMaster()->MoveIdle();
            events.Reset();
            events.RescheduleEvent(EVENT_SPIKE_RESUME, 4s);
        }
    }

    // The trail stays up for the spike's whole life; only the speed stages restart.
    void RemoveSpeedAuras()
    {
        me->RemoveAurasDueToSpell(SPELL_SPIKE_SPEED1);
        me->RemoveAurasDueToSpell(SPELL_SPIKE_SPEED2);
        me->RemoveAurasDueToSpell(SPELL_SPIKE_SPEED3);
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
        DoZoneInCombat();
        if (!next)
        {
            events.Reset();
            RemoveSpeedAuras();
            // Start the pursuit even if everyone is currently immune, so acquisition can retry.
            DoCastSelf(SPELL_SPIKE_SPEED1, true);
            if (!me->HasAura(SPELL_SPIKE_TRAIL))
                DoCastSelf(SPELL_SPIKE_TRAIL, true);
            // Not triggered: the core sends no SPELL_GO for a triggered spell without a visual.
            DoCastAOE(SPELL_SPIKE_TARGET_SEARCH);
            events.RescheduleEvent(EVENT_SPIKE_SPEED_2, 7s);
            // The spike holds still until the mark lands; losing the target mid-pursuit re-marks at once.
            events.RescheduleEvent(EVENT_SPIKE_MARK, 1600ms);
            return;
        }
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
        events.Reset();
        events.RescheduleEvent(EVENT_SPIKE_RESUME, 1600ms);
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
                SelectNewTarget(false);
                break;
            case EVENT_SPIKE_MARK:
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

// 66339 - Summon Scarab
class spell_anubarak_summon_scarab_aura : public AuraScript
{
    PrepareAuraScript(spell_anubarak_summon_scarab_aura);

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        // Sniffed burrows summon on roughly a quarter of their ticks; nothing in the DBC rolls this.
        if (!roll_chance_i(24))
            PreventDefaultAction();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_anubarak_summon_scarab_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 66135 - Shadow Strike
class spell_anubarak_shadow_strike : public SpellScript
{
    PrepareSpellScript(spell_anubarak_shadow_strike);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOW_STRIKE });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Acore::Containers::RandomResize(targets, 1);
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        // A creature cast replaces the one in progress, so striking now would cancel a Submerge
        // halfway and leave the burrower unselectable above ground.
        if (caster->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) || caster->HasUnitState(UNIT_STATE_CASTING))
            return;

        caster->CastSpell(GetHitUnit(), SPELL_SHADOW_STRIKE);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_anubarak_shadow_strike::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_anubarak_shadow_strike::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 66508 - Reset Cleanup
class spell_anubarak_reset_cleanup : public SpellScript
{
    PrepareSpellScript(spell_anubarak_reset_cleanup);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ uint32(spellInfo->Effects[EFFECT_1].CalcValue()) });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        // The basepoints hold the 10-man normal Acid-Drenched Mandibles; the scarabs apply the difficulty variant
        GetHitUnit()->RemoveAurasDueToSpell(sSpellMgr->GetSpellIdForDifficulty(uint32(GetEffectValue()), GetCaster()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_anubarak_reset_cleanup::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
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
    RegisterSpellScript(spell_anubarak_summon_scarab_aura);
    RegisterSpellScript(spell_anubarak_shadow_strike);
    RegisterSpellScript(spell_anubarak_reset_cleanup);
    RegisterSpellScript(spell_gen_leeching_swarm_aura);
    RegisterSpellScript(spell_gen_leeching_swarm_dmg);
}
