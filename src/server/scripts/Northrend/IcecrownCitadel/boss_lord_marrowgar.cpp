/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "MapManager.h"
#include "icecrown_citadel.h"
#include "PassiveAI.h"
#include "Player.h"
#include "Vehicle.h"
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

struct BoneStormMoveTargetSelector : public acore::unary_function<Unit*, bool>
{
    public:
        BoneStormMoveTargetSelector(Creature* source) : _source(source) { }
        bool operator()(Unit const* target) const
        {
            if (!target)
                return false;

            if (target->GetExactDist(_source) > 175.0f)
                return false;

            if (target->GetTypeId() != TYPEID_PLAYER)
                return false;

            if (target->GetPositionX() > -337.0f)
                return false;

            return target != _source->GetVictim();
        }

    private:
        Creature const* _source;
};

class boss_lord_marrowgar : public CreatureScript
{
    public:
        boss_lord_marrowgar() : CreatureScript("boss_lord_marrowgar") { }

        struct boss_lord_marrowgarAI : public BossAI
        {
            boss_lord_marrowgarAI(Creature* creature) : BossAI(creature, DATA_LORD_MARROWGAR)
            {
                _introDone = false;
                _boneSlice = false;
            }

            bool _introDone;
            bool _boneSlice;
            uint64 _lastBoneSliceTargets[3];

            void Reset()
            {
                me->SetReactState(REACT_AGGRESSIVE);
                _Reset();
                events.ScheduleEvent(EVENT_ENABLE_BONE_SLICE, 10000);
                events.ScheduleEvent(EVENT_SPELL_BONE_SPIKE_GRAVEYARD, urand(10000, 15000));
                events.ScheduleEvent(EVENT_SPELL_COLDFLAME, 5000);
                events.ScheduleEvent(EVENT_WARN_BONE_STORM, urand(45000, 50000));
                events.ScheduleEvent(EVENT_ENRAGE, 600000);

                _boneSlice = false;
                memset(_lastBoneSliceTargets, 0, 3 * sizeof(uint64));

                instance->SetData(DATA_BONED_ACHIEVEMENT, uint32(true));
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(SAY_AGGRO);
                me->setActive(true);
                DoZoneInCombat();
                instance->SetBossState(DATA_LORD_MARROWGAR, IN_PROGRESS);
            }

            void SpellHitTarget(Unit* target, const SpellInfo* spell)
            {
                if (target && (spell->Id == 69055 || spell->Id == 70814)) // Bone Slice (Saber Lash)
                    for (uint8 i=0; i<3; ++i)
                        if (!_lastBoneSliceTargets[i])
                        {
                            _lastBoneSliceTargets[i] = target->GetGUID();
                            break;
                        }
            }

            uint64 GetGUID(int32 id) const
            {
                if (id >= 0 && id <= 2)
                    return _lastBoneSliceTargets[id];

                return (uint64)0;
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || !CheckInRoom())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case 0:
                        break;
                    case EVENT_ENABLE_BONE_SLICE:
                        _boneSlice = true;
                        events.PopEvent();
                        break;
                    case EVENT_SPELL_BONE_SPIKE_GRAVEYARD:
                        {
                            bool a = me->HasAura(SPELL_BONE_STORM);
                            if (IsHeroic() || !a)
                                me->CastSpell(me, SPELL_BONE_SPIKE_GRAVEYARD, a);
                            events.RepeatEvent(urand(15000, 20000));
                        }
                        break;
                    case EVENT_SPELL_COLDFLAME:
                        if (!me->HasAura(SPELL_BONE_STORM))
                            me->CastSpell((Unit*)NULL, SPELL_COLDFLAME_NORMAL, false);
                        events.RepeatEvent(5000);
                        break;
                    case EVENT_SPELL_COLDFLAME_BONE_STORM:
                        me->CastSpell(me, SPELL_COLDFLAME_BONE_STORM, false);
                        events.PopEvent();
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
                        events.RepeatEvent(urand(90000, 95000));
                        events.ScheduleEvent(EVENT_BEGIN_BONE_STORM, 3050);
                        break;
                    case EVENT_BEGIN_BONE_STORM:
                        {
                            uint32 _boneStormDuration = RAID_MODE<uint32>(20000, 30000, 20000, 30000);
                            if (Aura* pStorm = me->GetAura(SPELL_BONE_STORM))
                                pStorm->SetDuration(int32(_boneStormDuration));
                            events.PopEvent();
                            events.ScheduleEvent(EVENT_BONE_STORM_MOVE, 0);
                            events.ScheduleEvent(EVENT_END_BONE_STORM, _boneStormDuration+1);
                        }
                        break;
                    case EVENT_BONE_STORM_MOVE:
                        {
                            if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == POINT_MOTION_TYPE)
                            {
                                events.RepeatEvent(1);
                                break;
                            }
                            events.RepeatEvent(5000);
                            Unit* unit = SelectTarget(SELECT_TARGET_RANDOM, 0, BoneStormMoveTargetSelector(me));
                            if (!unit)
                            {
                                if ((unit = SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 175.0f, true)))
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
                        events.PopEvent();
                        events.CancelEvent(EVENT_BONE_STORM_MOVE);
                        events.ScheduleEvent(EVENT_ENABLE_BONE_SLICE, 10000);
                        if (!IsHeroic())
                            events.RescheduleEvent(EVENT_SPELL_BONE_SPIKE_GRAVEYARD, urand(15000, 20000));
                        break;
                    case EVENT_ENRAGE:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(SAY_BERSERK);
                        events.PopEvent();
                        break;
                }

                if (me->HasAura(SPELL_BONE_STORM))
                    return;

                if (_boneSlice && !me->GetCurrentSpell(CURRENT_MELEE_SPELL))
                    DoCastVictim(SPELL_BONE_SLICE);

                if (_boneSlice && me->isAttackReady() && me->GetVictim() && !me->HasUnitState(UNIT_STATE_CASTING) && me->IsWithinMeleeRange(me->GetVictim()))
                    memset(_lastBoneSliceTargets, 0, 3 * sizeof(uint64));

                DoMeleeAttackIfReady();
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE || id != 1337)
                    return;

                events.ScheduleEvent(EVENT_SPELL_COLDFLAME_BONE_STORM, 0);
            }

            void JustDied(Unit* /*killer*/)
            {
                Talk(SAY_DEATH);
                _JustDied();
            }

            void JustReachedHome()
            {
                _JustReachedHome();
                instance->SetBossState(DATA_LORD_MARROWGAR, FAIL);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (!_introDone && me->IsAlive() && who->GetTypeId() == TYPEID_PLAYER && me->GetExactDist2dSq(who) <= 10000.0f) // 100*100, moveinlineofsight limited to 60yd anyway
                {
                    Talk(SAY_ENTER_ZONE);
                    _introDone = true;
                }

                BossAI::MoveInLineOfSight(who);
            }

            bool CanAIAttack(Unit const* target) const
            {
                return target->GetPositionX() < -337.0f; // main gate
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_lord_marrowgarAI>(creature);
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

        void IsSummonedBy(Unit* /*summoner*/)
        {
            events.ScheduleEvent(1, 450);
            events.ScheduleEvent(2, 12000);
            me->m_positionZ = 42.5f;
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    {
                    me->m_positionZ = 42.5f;
                    me->DisableSpline();
                    me->CastSpell(me, SPELL_COLDFLAME_SUMMON, true);
                    float nx = me->GetPositionX()+5.0f*cos(me->GetOrientation());
                    float ny = me->GetPositionY()+5.0f*sin(me->GetOrientation());
                    if (!me->IsWithinLOS(nx, ny, 42.5f))
                    {
                        events.PopEvent();
                        break;
                    }
                    me->NearTeleportTo(nx, ny, 42.5f, me->GetOrientation());
                    events.RepeatEvent(450);
                    }
                    break;
                case 2:
                    events.Reset();
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
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

        void DoAction(int32 action)
        {
            if (action != -1337)
                return;

            if (TempSummon* summ = me->ToTempSummon())
                if (Unit* trapped = summ->GetSummoner())
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

        void JustDied(Unit* /*killer*/)
        {
            DoAction(-1337);
        }

        void IsSummonedBy(Unit* summoner)
        {
            if (!summoner)
                return;

            if (Vehicle* v = summoner->GetVehicle())
                if (Unit* u = v->GetBase())
                    if (u->GetEntry() == NPC_BONE_SPIKE && u->GetTypeId() == TYPEID_UNIT)
                        u->ToCreature()->AI()->DoAction(-1337);

            uint64 petGUID = summoner->GetPetGUID();
            summoner->SetPetGUID(0);
            me->CastSpell(summoner, SPELL_IMPALED, true);
            summoner->CastSpell(me, SPELL_RIDE_VEHICLE, true);
            //summoner->ClearUnitState(UNIT_STATE_ONVEHICLE);
            summoner->SetPetGUID(petGUID);
            summoner->GetMotionMaster()->Clear();
            summoner->StopMoving();
            events.ScheduleEvent(1, 8000);
            hasTrappedUnit = true;
        }

        void UpdateAI(uint32 diff)
        {
            if (!hasTrappedUnit || !me->IsAlive())
                return;

            if (TempSummon* summ = me->ToTempSummon())
            {
                if (Unit* trapped = summ->GetSummoner())
                {
                    if (!trapped->IsOnVehicle(me) || !trapped->IsAlive() || !me->GetInstanceScript() || me->GetInstanceScript()->GetBossState(DATA_LORD_MARROWGAR) != IN_PROGRESS || trapped->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
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

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetIcecrownCitadelAI<npc_bone_spikeAI>(creature);
    }
};

class spell_marrowgar_coldflame : public SpellScriptLoader
{
public:
    spell_marrowgar_coldflame() : SpellScriptLoader("spell_marrowgar_coldflame") { }

    class spell_marrowgar_coldflame_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_marrowgar_coldflame_SpellScript);

        void SelectTarget(std::list<WorldObject*>& targets)
        {
            targets.clear();
            Unit* target = GetCaster()->GetAI()->SelectTarget(SELECT_TARGET_RANDOM, 1, -1.0f, true, -SPELL_IMPALED); // -1.0f as it takes into account object size
            if (!target)
                target = GetCaster()->GetAI()->SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true); // if only tank or noone outside of boss' model
            if (!target)
                return;

            targets.push_back(target);
        }

        void HandleScriptEffect(SpellEffIndex  /*effIndex*/)
        {
            Unit* caster = GetCaster();
            float angle = caster->GetAngle(GetHitUnit());
            float dist = caster->GetObjectSize()/2.0f;
            float z = caster->GetPositionZ()+2.5f;
            float nx = caster->GetPositionX()+dist*cos(angle);
            float ny = caster->GetPositionY()+dist*sin(angle);

            if (!caster->IsWithinLOS(nx, ny, z))
            {
                nx = caster->GetPositionX()+0.5f*cos(angle);
                ny = caster->GetPositionY()+0.5f*sin(angle);
            }

            if (caster->IsWithinLOS(nx, ny, z))
            {
                caster->m_orientation = angle;
                caster->CastSpell(nx, ny, z, uint32(GetEffectValue()), true);
            }
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_marrowgar_coldflame_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_marrowgar_coldflame_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_marrowgar_coldflame_SpellScript();
    }
};

class spell_marrowgar_bone_spike_graveyard : public SpellScriptLoader
{
public:
    spell_marrowgar_bone_spike_graveyard() : SpellScriptLoader("spell_marrowgar_bone_spike_graveyard") { }

    class spell_marrowgar_bone_spike_graveyard_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_marrowgar_bone_spike_graveyard_SpellScript);

        void HandleSpikes(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Creature* marrowgar = GetCaster()->ToCreature())
            {
                bool didHit = false;
                CreatureAI* marrowgarAI = marrowgar->AI();
                uint8 boneSpikeCount = uint8(GetCaster()->GetMap()->GetSpawnMode() & 1 ? 3 : 1);

                std::vector<Player*> validPlayers;
                Map::PlayerList const &pList = marrowgar->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                    if (Player* plr = itr->GetSource())
                        if (plr->IsAlive() && !plr->IsGameMaster() && plr->GetExactDist2dSq(marrowgar) < (150.0f * 150.0f) && !plr->HasAura(SPELL_IMPALED))
                            if (!marrowgar->GetVictim() || marrowgar->GetVictim()->GetGUID() != plr->GetGUID())
                                if (plr->GetGUID() != marrowgarAI->GetGUID(0) && plr->GetGUID() != marrowgarAI->GetGUID(1) && plr->GetGUID() != marrowgarAI->GetGUID(2)) // not a bone slice target
                                    validPlayers.push_back(plr);

                std::vector<Player*>::iterator begin=validPlayers.begin(), end=validPlayers.end();

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

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_marrowgar_bone_spike_graveyard_SpellScript::HandleSpikes, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_marrowgar_bone_spike_graveyard_SpellScript();
    }
};

class spell_marrowgar_coldflame_bonestorm : public SpellScriptLoader
{
    public:
        spell_marrowgar_coldflame_bonestorm() : SpellScriptLoader("spell_marrowgar_coldflame_bonestorm") { }

        class spell_marrowgar_coldflame_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_marrowgar_coldflame_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Unit* caster = GetCaster();
                float x = caster->GetPositionX();
                float y = caster->GetPositionY();
                float z = caster->GetPositionZ()+2.5f;
                for (uint8 i = 0; i < 4; ++i)
                {
                    float nx = x+2.5f*cos((M_PI/4)+(i*(M_PI/2)));
                    float ny = y+2.5f*sin((M_PI/4)+(i*(M_PI/2)));
                    if (caster->IsWithinLOS(nx, ny, z))
                    {
                        caster->m_orientation = (M_PI/4)+(i*(M_PI/2));
                        caster->CastSpell(nx, ny, z, uint32(GetEffectValue() + i), true);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_marrowgar_coldflame_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_marrowgar_coldflame_SpellScript();
        }
};

class spell_marrowgar_bone_storm : public SpellScriptLoader
{
    public:
        spell_marrowgar_bone_storm() : SpellScriptLoader("spell_marrowgar_bone_storm") { }

        class spell_marrowgar_bone_storm_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_marrowgar_bone_storm_SpellScript);

            void RecalculateDamage()
            {
                float dist = GetHitUnit()->GetExactDist2d(GetCaster());
                if (dist >= 9.0f) dist -= 9.0f;
                else dist = 0.0f;
                SetHitDamage(int32(GetHitDamage() / std::max(sqrtf(dist), 1.0f)));
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_marrowgar_bone_storm_SpellScript::RecalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_marrowgar_bone_storm_SpellScript();
        }
};

class spell_marrowgar_bone_slice : public SpellScriptLoader
{
    public:
        spell_marrowgar_bone_slice() : SpellScriptLoader("spell_marrowgar_bone_slice") { }

        class spell_marrowgar_bone_slice_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_marrowgar_bone_slice_SpellScript);

            bool Load()
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

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_marrowgar_bone_slice_SpellScript::CountTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
                OnHit += SpellHitFn(spell_marrowgar_bone_slice_SpellScript::SplitDamage);
            }

            uint32 _targetCount;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_marrowgar_bone_slice_SpellScript();
        }
};

void AddSC_boss_lord_marrowgar()
{
    new boss_lord_marrowgar();
    new npc_coldflame();
    new npc_bone_spike();
    new spell_marrowgar_coldflame();
    new spell_marrowgar_coldflame_bonestorm();
    new spell_marrowgar_bone_spike_graveyard();
    new spell_marrowgar_bone_storm();
    new spell_marrowgar_bone_slice();
}
