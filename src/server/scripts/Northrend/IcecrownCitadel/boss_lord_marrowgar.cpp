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

#include "CreatureScript.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "icecrown_citadel.h"
#include <random>

enum ScriptTexts
{
    SAY_ENTER_ZONE              = 0,
    SAY_AGGRO                   = 1,
    SAY_BONE_STORM              = 2,
    SAY_BONESPIKE               = 3,
    SAY_KILL                    = 4,
    SAY_DEATH                   = 5,
    SAY_BERSERK                 = 6,
    EMOTE_BONE_STORM            = 7,
};

enum Spells
{
    // Lord Marrowgar
    SPELL_BONE_SLICE            = 69055,
    SPELL_BONE_STORM            = 69076,
    SPELL_BONE_SPIKE_GRAVEYARD  = 69057,
    SPELL_COLDFLAME_NORMAL      = 69140,
    SPELL_COLDFLAME_BONE_STORM  = 72705,

    // Bone Spike
    SPELL_IMPALED               = 69065,
    SPELL_RIDE_VEHICLE          = 46598,

    // Coldflame
    SPELL_COLDFLAME_PASSIVE     = 69145,
    SPELL_COLDFLAME_SUMMON      = 69147,
};

enum Events
{
    EVENT_ENABLE_BONE_SLICE = 1,
    EVENT_SPELL_BONE_SPIKE_GRAVEYARD,
    EVENT_SPELL_COLDFLAME,
    EVENT_SPELL_COLDFLAME_BONE_STORM,
    EVENT_WARN_BONE_STORM,
    EVENT_BEGIN_BONE_STORM,
    EVENT_BONE_STORM_MOVE,
    EVENT_END_BONE_STORM,
    EVENT_ENRAGE,
};

uint32 const boneSpikeSummonId[3] = {69062, 72669, 72670};

struct BoneStormMoveTargetSelector
{
public:
    BoneStormMoveTargetSelector(Creature* source) : _source(source) { }
    bool operator()(Unit const* target) const
    {
        if (!target)
            return false;

        if (target->GetExactDist(_source) > 175.0f)
            return false;

        if (!target->IsPlayer())
            return false;

        if (target->GetPositionX() > -337.0f)
            return false;

        return target != _source->GetVictim();
    }

private:
    Creature const* _source;
};

struct boss_lord_marrowgar : public BossAI
{
public:
    boss_lord_marrowgar(Creature* creature) : BossAI(creature, DATA_LORD_MARROWGAR)
    {
        _introDone = false;
        _boneSlice = false;
    }

    bool _introDone;
    bool _boneSlice;
    ObjectGuid _lastBoneSliceTargets[3];

    void Reset() override
    {
        me->SetReactState(REACT_AGGRESSIVE);
        _Reset();
        events.ScheduleEvent(EVENT_ENABLE_BONE_SLICE, 10s);
        events.ScheduleEvent(EVENT_SPELL_BONE_SPIKE_GRAVEYARD, 10s, 15s);
        events.ScheduleEvent(EVENT_SPELL_COLDFLAME, 5s);
        events.ScheduleEvent(EVENT_WARN_BONE_STORM, 45s, 50s);
        events.ScheduleEvent(EVENT_ENRAGE, 10min);

        _boneSlice = false;

        for (uint8 i = 0; i < 3; ++i)
            _lastBoneSliceTargets[i].Clear();

        instance->SetData(DATA_BONED_ACHIEVEMENT, uint32(true));
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        me->setActive(true);
        DoZoneInCombat();
        instance->SetBossState(DATA_LORD_MARROWGAR, IN_PROGRESS);
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spell) override
    {
        if (target && (spell->Id == 69055 || spell->Id == 70814)) // Bone Slice (Saber Lash)
            for (uint8 i = 0; i < 3; ++i)
                if (!_lastBoneSliceTargets[i])
                {
                    _lastBoneSliceTargets[i] = target->GetGUID();
                    break;
                }
    }

    ObjectGuid GetGUID(int32 id) const override
    {
        if (id >= 0 && id <= 2)
            return _lastBoneSliceTargets[id];

        return ObjectGuid::Empty;
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
            case 0:
                break;
            case EVENT_ENABLE_BONE_SLICE:
                _boneSlice = true;
                break;
            case EVENT_SPELL_BONE_SPIKE_GRAVEYARD:
                {
                    bool a = me->HasAura(SPELL_BONE_STORM);
                    if (IsHeroic() || !a)
                        me->CastSpell(me, SPELL_BONE_SPIKE_GRAVEYARD, a);
                    events.Repeat(15s, 20s);
                }
                break;
            case EVENT_SPELL_COLDFLAME:
                if (!me->HasAura(SPELL_BONE_STORM))
                    me->CastSpell((Unit*)nullptr, SPELL_COLDFLAME_NORMAL, false);
                events.Repeat(5s);
                break;
            case EVENT_SPELL_COLDFLAME_BONE_STORM:
                me->CastSpell(me, SPELL_COLDFLAME_BONE_STORM, false);
                break;
            case EVENT_WARN_BONE_STORM:
                _boneSlice = false;
                Talk(EMOTE_BONE_STORM);
                Talk(SAY_BONE_STORM);
                me->FinishSpell(CURRENT_MELEE_SPELL, false);
                me->CastSpell(me, SPELL_BONE_STORM, false);
                me->SetReactState(REACT_PASSIVE); // to prevent chasing another target on UpdateVictim()
                me->GetMotionMaster()->MoveIdle();
                me->GetMotionMaster()->MovementExpired();
                events.Repeat(90s, 95s);
                events.ScheduleEvent(EVENT_BEGIN_BONE_STORM, 3050ms);
                break;
            case EVENT_BEGIN_BONE_STORM:
                {
                    uint32 _boneStormDuration = RAID_MODE<uint32>(20000, 30000, 20000, 30000);
                    if (Aura* pStorm = me->GetAura(SPELL_BONE_STORM))
                        pStorm->SetDuration(int32(_boneStormDuration));
                    events.ScheduleEvent(EVENT_BONE_STORM_MOVE, 0ms);
                    events.ScheduleEvent(EVENT_END_BONE_STORM, _boneStormDuration + 1);
                }
                break;
            case EVENT_BONE_STORM_MOVE:
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == POINT_MOTION_TYPE)
                    {
                        events.Repeat(1ms);
                        break;
                    }
                    events.Repeat(5s);
                    Unit* unit = SelectTarget(SelectTargetMethod::Random, 0, BoneStormMoveTargetSelector(me));
                    if (!unit)
                    {
                        if ((unit = SelectTarget(SelectTargetMethod::MaxThreat, 0, 175.0f, true)))
                            if (unit->GetPositionX() > -337.0f)
                            {
                                EnterEvadeMode();
                                return;
                            }
                    }
                    if (unit)
                        me->GetMotionMaster()->MoveCharge(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), 25.0f, 1337);
                    break;
                }
                break;
            case EVENT_END_BONE_STORM:
                me->StopMoving();
                me->GetMotionMaster()->MovementExpired();
                me->SetReactState(REACT_AGGRESSIVE);
                DoStartMovement(me->GetVictim());
                events.CancelEvent(EVENT_BONE_STORM_MOVE);
                events.ScheduleEvent(EVENT_ENABLE_BONE_SLICE, 10s);
                if (!IsHeroic())
                    events.RescheduleEvent(EVENT_SPELL_BONE_SPIKE_GRAVEYARD, 15s, 20s);
                break;
            case EVENT_ENRAGE:
                me->CastSpell(me, SPELL_BERSERK, true);
                Talk(SAY_BERSERK);
                break;
        }

        if (me->HasAura(SPELL_BONE_STORM))
            return;

        if (_boneSlice && !me->GetCurrentSpell(CURRENT_MELEE_SPELL))
            DoCastVictim(SPELL_BONE_SLICE);

        if (_boneSlice && me->isAttackReady() && me->GetVictim() && !me->HasUnitState(UNIT_STATE_CASTING) && me->IsWithinMeleeRange(me->GetVictim()))
        {
            for (uint8 i = 0; i < 3; ++i)
                _lastBoneSliceTargets[i].Clear();
        }

        DoMeleeAttackIfReady();
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE || id != 1337)
            return;

        events.ScheduleEvent(EVENT_SPELL_COLDFLAME_BONE_STORM, 0ms);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
    }

    void JustReachedHome() override
    {
        _JustReachedHome();
        instance->SetBossState(DATA_LORD_MARROWGAR, FAIL);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_introDone && me->IsAlive() && who->IsPlayer() && me->GetExactDist2dSq(who) <= 10000.0f) // 100*100, moveinlineofsight limited to 60yd anyway
        {
            Talk(SAY_ENTER_ZONE);
            _introDone = true;
        }

        BossAI::MoveInLineOfSight(who);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetPositionX() < -337.0f; // main gate
    }
};

class npc_coldflame : public CreatureScript
{
public:
    npc_coldflame() : CreatureScript("npc_coldflame") { }

    struct npc_coldflameAI : public NullCreatureAI
    {
        npc_coldflameAI(Creature* creature) : NullCreatureAI(creature)
        {
        }

        EventMap events;

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            events.ScheduleEvent(1, 450ms);
            events.ScheduleEvent(2, 12s);
            me->m_positionZ = 42.5f;
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case 1:
                    {
                        me->m_positionZ = 42.5f;
                        me->DisableSpline();
                        me->CastSpell(me, SPELL_COLDFLAME_SUMMON, true);
                        float nx = me->GetPositionX() + 5.0f * cos(me->GetOrientation());
                        float ny = me->GetPositionY() + 5.0f * std::sin(me->GetOrientation());
                        if (!me->IsWithinLOS(nx, ny, 42.5f))
                        {
                            break;
                        }
                        me->NearTeleportTo(nx, ny, 42.5f, me->GetOrientation());
                        events.Repeat(450ms);
                    }
                    break;
                case 2:
                    events.Reset();
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_coldflameAI>(creature);
    }
};

class npc_bone_spike : public CreatureScript
{
public:
    npc_bone_spike() : CreatureScript("npc_bone_spike") { }

    struct npc_bone_spikeAI : public NullCreatureAI
    {
        npc_bone_spikeAI(Creature* creature) : NullCreatureAI(creature), hasTrappedUnit(false)
        {
        }

        EventMap events;
        bool hasTrappedUnit;

        void DoAction(int32 action) override
        {
            if (action != -1337)
                return;

            if (TempSummon* summ = me->ToTempSummon())
                if (Unit* trapped = summ->GetSummonerUnit())
                {
                    Position exitPos = {me->GetPositionX(), me->GetPositionY(), 60.0f, me->GetOrientation()};
                    trapped->UpdateAllowedPositionZ(exitPos.GetPositionX(), exitPos.GetPositionY(), exitPos.m_positionZ);
                    exitPos.m_positionZ += 1.0f;
                    if (Unit* vehBase = trapped->GetVehicleBase())
                        vehBase->RemoveAurasByType(SPELL_AURA_CONTROL_VEHICLE, trapped->GetGUID());
                    trapped->_ExitVehicle(&exitPos);
                    trapped->RemoveAurasDueToSpell(SPELL_IMPALED);
                    trapped->GetMotionMaster()->Clear();
                    trapped->UpdatePosition(exitPos, true);
                    trapped->StopMovingOnCurrentPos();
                    trapped->NearTeleportTo(exitPos.GetPositionX(), exitPos.GetPositionY(), exitPos.GetPositionZ(), exitPos.GetOrientation(), false);
                }

            me->DespawnOrUnsummon(1);
        }

        void JustDied(Unit* /*killer*/) override
        {
            DoAction(-1337);
        }

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
                return;
            if (Unit* summonerUnit = summoner->ToUnit())
            {
                if (Vehicle* v = summonerUnit->GetVehicle())
                {
                    if (Unit* u = v->GetBase())
                    {
                        if (u->GetEntry() == NPC_BONE_SPIKE && u->IsCreature())
                        {
                            u->ToCreature()->AI()->DoAction(-1337);
                        }
                    }
                }
                ObjectGuid petGUID = summonerUnit->GetPetGUID();
                summonerUnit->SetPetGUID(ObjectGuid::Empty);
                me->CastSpell(summonerUnit, SPELL_IMPALED, true);
                summonerUnit->CastSpell(me, SPELL_RIDE_VEHICLE, true);
                //summoner->ClearUnitState(UNIT_STATE_ONVEHICLE);
                summonerUnit->SetPetGUID(petGUID);
                summonerUnit->GetMotionMaster()->Clear();
                summonerUnit->StopMoving();
                events.ScheduleEvent(1, 8000);
                hasTrappedUnit = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!hasTrappedUnit || !me->IsAlive())
                return;

            if (TempSummon* summ = me->ToTempSummon())
            {
                if (Unit* trapped = summ->GetSummonerUnit())
                {
                    if (!trapped->IsOnVehicle(me) || !trapped->IsAlive() || !me->GetInstanceScript() || me->GetInstanceScript()->GetBossState(DATA_LORD_MARROWGAR) != IN_PROGRESS || trapped->HasSpiritOfRedemptionAura())
                    {
                        DoAction(-1337);
                        return;
                    }
                }
                else
                {
                    me->DespawnOrUnsummon(1);
                    return;
                }
            }
            else
            {
                me->DespawnOrUnsummon(1);
                return;
            }

            events.Update(diff);

            if (events.ExecuteEvent() == 1)
                if (InstanceScript* instance = me->GetInstanceScript())
                    instance->SetData(DATA_BONED_ACHIEVEMENT, uint32(false));
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_bone_spikeAI>(creature);
    }
};

class spell_marrowgar_coldflame : public SpellScript
{
    PrepareSpellScript(spell_marrowgar_coldflame);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.clear();
        Unit* target = GetCaster()->GetAI()->SelectTarget(SelectTargetMethod::Random, 1, -1.0f, true,true,  -SPELL_IMPALED); // -1.0f as it takes into account object size
        if (!target)
            target = GetCaster()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true); // if only tank or noone outside of boss' model
        if (!target)
            return;

        targets.push_back(target);
    }

    void HandleScriptEffect(SpellEffIndex  /*effIndex*/)
    {
        Unit* caster = GetCaster();
        float angle = caster->GetAngle(GetHitUnit());
        float dist = caster->GetObjectSize() / 2.0f;
        float z = caster->GetPositionZ() + 2.5f;
        float nx = caster->GetPositionX() + dist * cos(angle);
        float ny = caster->GetPositionY() + dist * std::sin(angle);

        if (!caster->IsWithinLOS(nx, ny, z))
        {
            nx = caster->GetPositionX() + 0.5f * cos(angle);
            ny = caster->GetPositionY() + 0.5f * std::sin(angle);
        }

        if (caster->IsWithinLOS(nx, ny, z))
        {
            caster->SetOrientation(angle);
            caster->CastSpell(nx, ny, z, uint32(GetEffectValue()), true);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_marrowgar_coldflame::SelectTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_marrowgar_coldflame::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_marrowgar_bone_spike_graveyard : public SpellScript
{
    PrepareSpellScript(spell_marrowgar_bone_spike_graveyard);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_IMPALED });
    }

    void HandleSpikes(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Creature* marrowgar = GetCaster()->ToCreature())
        {
            bool didHit = false;
            CreatureAI* marrowgarAI = marrowgar->AI();
            uint8 boneSpikeCount = uint8(GetCaster()->GetMap()->GetSpawnMode() & 1 ? 3 : 1);

            std::vector<Player*> validPlayers;
            Map::PlayerList const& pList = marrowgar->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                if (Player* plr = itr->GetSource())
                    if (plr->IsAlive() && !plr->IsGameMaster() && plr->GetExactDist2dSq(marrowgar) < (150.0f * 150.0f) && !plr->HasAura(SPELL_IMPALED))
                        if (!marrowgar->GetVictim() || marrowgar->GetVictim()->GetGUID() != plr->GetGUID())
                            if (plr->GetGUID() != marrowgarAI->GetGUID(0) && plr->GetGUID() != marrowgarAI->GetGUID(1) && plr->GetGUID() != marrowgarAI->GetGUID(2)) // not a bone slice target
                                validPlayers.push_back(plr);

            std::vector<Player*>::iterator begin = validPlayers.begin(), end = validPlayers.end();

            std::random_device rd;
            std::shuffle(begin, end, std::default_random_engine{rd()});

            for (uint8 i = 0; i < boneSpikeCount && i < validPlayers.size(); ++i)
            {
                Unit* target = validPlayers[i];
                didHit = true;
                //target->CastCustomSpell(boneSpikeSummonId[i], SPELLVALUE_BASE_POINT0, 0, target, true);
                target->CastSpell(target, boneSpikeSummonId[i], true);
            }

            if (didHit)
                marrowgarAI->Talk(SAY_BONESPIKE);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_marrowgar_bone_spike_graveyard::HandleSpikes, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_marrowgar_coldflame_bonestorm : public SpellScript
{
    PrepareSpellScript(spell_marrowgar_coldflame_bonestorm);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* caster = GetCaster();
        float x = caster->GetPositionX();
        float y = caster->GetPositionY();
        float z = caster->GetPositionZ() + 2.5f;
        for (uint8 i = 0; i < 4; ++i)
        {
            float nx = x + 2.5f * cos((M_PI / 4) + (i * (M_PI / 2)));
            float ny = y + 2.5f * std::sin((M_PI / 4) + (i * (M_PI / 2)));
            if (caster->IsWithinLOS(nx, ny, z))
            {
                caster->SetOrientation((M_PI / 4) + (i * (M_PI / 2)));
                caster->CastSpell(nx, ny, z, uint32(GetEffectValue() + i), true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_marrowgar_coldflame_bonestorm::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_marrowgar_bone_storm : public SpellScript
{
    PrepareSpellScript(spell_marrowgar_bone_storm);

    void RecalculateDamage()
    {
        float dist = GetHitUnit()->GetExactDist2d(GetCaster());
        if (dist >= 9.0f) dist -= 9.0f;
        else dist = 0.0f;
        SetHitDamage(int32(GetHitDamage() / std::max(sqrtf(dist), 1.0f)));
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_marrowgar_bone_storm::RecalculateDamage);
    }
};

class spell_marrowgar_bone_slice : public SpellScript
{
    PrepareSpellScript(spell_marrowgar_bone_slice);

    bool Load() override
    {
        _targetCount = 0;
        return true;
    }

    void CountTargets(std::list<WorldObject*>& targets)
    {
        _targetCount = std::min<uint32>(targets.size(), GetSpellInfo()->MaxAffectedTargets);
    }

    void SplitDamage()
    {
        if (!_targetCount)
            return; // This spell can miss all targets

        SetHitDamage(GetHitDamage() / _targetCount);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_marrowgar_bone_slice::CountTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        OnHit += SpellHitFn(spell_marrowgar_bone_slice::SplitDamage);
    }

private:
    uint32 _targetCount;
};

void AddSC_boss_lord_marrowgar()
{
    RegisterIcecrownCitadelCreatureAI(boss_lord_marrowgar);
    new npc_coldflame();
    new npc_bone_spike();
    RegisterSpellScript(spell_marrowgar_coldflame);
    RegisterSpellScript(spell_marrowgar_coldflame_bonestorm);
    RegisterSpellScript(spell_marrowgar_bone_spike_graveyard);
    RegisterSpellScript(spell_marrowgar_bone_storm);
    RegisterSpellScript(spell_marrowgar_bone_slice);
}
