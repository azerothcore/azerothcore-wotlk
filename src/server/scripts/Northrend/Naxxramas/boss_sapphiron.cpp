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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "naxxramas.h"

enum Yells
{
    EMOTE_AIR_PHASE         = 0,
    EMOTE_GROUND_PHASE      = 1,
    EMOTE_BREATH            = 2,
    EMOTE_ENRAGE            = 3
};

enum Spells
{
    // Fight
    SPELL_FROST_AURA                = 28531,
    SPELL_CLEAVE                    = 19983,
    SPELL_TAIL_SWEEP                = 55697,
    SPELL_SUMMON_BLIZZARD           = 28560,
    SPELL_LIFE_DRAIN                = 28542,
    SPELL_BERSERK                   = 26662,

    // Ice block
    SPELL_ICEBOLT_CAST              = 28526,
    SPELL_ICEBOLT_TRIGGER           = 28522,
    SPELL_FROST_MISSILE             = 30101,
    SPELL_FROST_EXPLOSION           = 28524,

    // Visuals
    SPELL_SAPPHIRON_DIES            = 29357
};

enum Misc
{
    GO_ICE_BLOCK                    = 181247,
    NPC_BLIZZARD                    = 16474,

    POINT_CENTER                    = 1
};

enum Events
{
    EVENT_BERSERK                   = 1,
    EVENT_CLEAVE                    = 2,
    EVENT_TAIL_SWEEP                = 3,
    EVENT_LIFE_DRAIN                = 4,
    EVENT_BLIZZARD                  = 5,
    EVENT_FLIGHT_START              = 6,
    EVENT_FLIGHT_LIFTOFF            = 7,
    EVENT_FLIGHT_ICEBOLT            = 8,
    EVENT_FLIGHT_BREATH             = 9,
    EVENT_FLIGHT_SPELL_EXPLOSION    = 10,
    EVENT_FLIGHT_START_LAND         = 11,
    EVENT_LAND                      = 12,
    EVENT_GROUND                    = 13,
    EVENT_HUNDRED_CLUB              = 14
};

class boss_sapphiron : public CreatureScript
{
public:
    boss_sapphiron() : CreatureScript("boss_sapphiron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_sapphironAI>(pCreature);
    }

    struct boss_sapphironAI : public BossAI
    {
        explicit boss_sapphironAI(Creature* c) : BossAI(c, BOSS_SAPPHIRON)
        {}

        EventMap events;
        uint8 iceboltCount{};
        uint32 spawnTimer{};
        GuidList blockList;
        ObjectGuid currentTarget;

        void InitializeAI() override
        {
            me->SummonGameObject(GO_SAPPHIRON_BIRTH, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, 0, 0, 0, 0, 0);
            me->SetVisible(false);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
            ScriptedAI::InitializeAI();
        }

        bool IsInRoom()
        {
            if (me->GetExactDist(3523.5f, -5235.3f, 137.6f) > 100.0f)
            {
                EnterEvadeMode();
                return false;
            }
            return true;
        }

        void Reset() override
        {
            BossAI::Reset();
            if (me->IsVisible())
            {
                me->SetReactState(REACT_AGGRESSIVE);
            }
            events.Reset();
            iceboltCount = 0;
            spawnTimer = 0;
            currentTarget.Clear();
            blockList.clear();
            me->SetAnimTier(AnimTier::Fly);
        }

        void EnterCombatSelfFunction()
        {
            Map::PlayerList const& PlList = me->GetMap()->GetPlayers();
            if (PlList.IsEmpty())
                return;

            for (auto const& i : PlList)
            {
                if (Player* player = i.GetSource())
                {
                    if (player->IsGameMaster())
                        continue;

                    if (player->IsAlive() && me->GetDistance(player) < 80.0f)
                    {
                        me->SetInCombatWith(player);
                        player->SetInCombatWith(me);
                        me->AddThreat(player, 0.0f);
                    }
                }
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            EnterCombatSelfFunction();
            me->CastSpell(me, SPELL_FROST_AURA, true);
            events.ScheduleEvent(EVENT_BERSERK, 15min);
            events.ScheduleEvent(EVENT_CLEAVE, 5s);
            events.ScheduleEvent(EVENT_TAIL_SWEEP, 10s);
            events.ScheduleEvent(EVENT_LIFE_DRAIN, 17s);
            events.ScheduleEvent(EVENT_BLIZZARD, 17s);
            events.ScheduleEvent(EVENT_FLIGHT_START, 45s);
            events.ScheduleEvent(EVENT_HUNDRED_CLUB, 5s);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            me->CastSpell(me, SPELL_SAPPHIRON_DIES, true);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_SAPPHIRON_BIRTH)
            {
                spawnTimer = 1;
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_CENTER)
            {
                events.ScheduleEvent(EVENT_FLIGHT_LIFTOFF, 500ms);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_ICEBOLT_CAST)
            {
                me->CastSpell(target, SPELL_ICEBOLT_TRIGGER, true);
            }
        }

        bool IsValidExplosionTarget(WorldObject* target)
        {
            for (ObjectGuid const& guid : blockList)
            {
                if (target->GetGUID() == guid)
                    return false;

                if (Unit* block = ObjectAccessor::GetUnit(*me, guid))
                {
                    if (block->IsInBetween(me, target, 2.0f) && block->IsWithinDist(target, 10.0f))
                        return false;
                }
            }
            return true;
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void UpdateAI(uint32 diff) override
        {
            if (spawnTimer)
            {
                spawnTimer += diff;
                if (spawnTimer >= 21500)
                {
                    me->SetVisible(true);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    spawnTimer = 0;
                }
                return;
            }

            if (!IsInRoom())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BERSERK:
                    Talk(EMOTE_ENRAGE);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    return;
                case EVENT_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.Repeat(10s);
                    return;
                case EVENT_TAIL_SWEEP:
                    me->CastSpell(me, SPELL_TAIL_SWEEP, false);
                    events.Repeat(10s);
                    return;
                case EVENT_LIFE_DRAIN:
                    me->CastCustomSpell(SPELL_LIFE_DRAIN, SPELLVALUE_MAX_TARGETS, RAID_MODE(2, 5), me, false);
                    events.Repeat(24s);
                    return;
                case EVENT_BLIZZARD:
                    {
                        Creature* cr;
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        {
                            cr = me->SummonCreature(NPC_BLIZZARD, *target, TEMPSUMMON_TIMED_DESPAWN, 16000);
                        }
                        else
                        {
                            cr = me->SummonCreature(NPC_BLIZZARD, *me, TEMPSUMMON_TIMED_DESPAWN, 16000);
                        }
                        if (cr)
                        {
                            cr->GetMotionMaster()->MoveRandom(40);
                        }
                        events.Repeat(RAID_MODE(8000ms, 6500ms));
                        return;
                    }
                case EVENT_FLIGHT_START:
                    if (me->HealthBelowPct(11))
                    {
                        return;
                    }
                    events.Repeat(45s);
                    events.DelayEvents(35s);
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    me->GetMotionMaster()->MovePoint(POINT_CENTER, x, y, z, FORCED_MOVEMENT_NONE, 0.f, o);
                    return;
                case EVENT_FLIGHT_LIFTOFF:
                    Talk(EMOTE_AIR_PHASE);
                    me->GetMotionMaster()->MoveIdle();
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    me->SetDisableGravity(true);
                    currentTarget.Clear();
                    events.ScheduleEvent(EVENT_FLIGHT_ICEBOLT, 3s);
                    iceboltCount = RAID_MODE(2, 3);
                    return;
                case EVENT_FLIGHT_ICEBOLT:
                    {
                        if (currentTarget)
                        {
                            if (Unit* target = ObjectAccessor::GetUnit(*me, currentTarget))
                            {
                                me->SummonGameObject(GO_ICE_BLOCK, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 0);
                            }
                        }

                        std::vector<Unit*> targets;
                        auto i = me->GetThreatMgr().GetThreatList().begin();
                        for (; i != me->GetThreatMgr().GetThreatList().end(); ++i)
                        {
                            if ((*i)->getTarget()->IsPlayer())
                            {
                                bool inList = false;
                                if (!blockList.empty())
                                {
                                    for (GuidList::const_iterator itr = blockList.begin(); itr != blockList.end(); ++itr)
                                    {
                                        if ((*i)->getTarget()->GetGUID() == *itr)
                                        {
                                            inList = true;
                                            break;
                                        }
                                    }
                                }
                                if (!inList)
                                {
                                    targets.push_back((*i)->getTarget());
                                }
                            }
                        }

                        if (!targets.empty() && iceboltCount)
                        {
                            auto itr = targets.begin();
                            advance(itr, urand(0, targets.size() - 1));
                            me->CastSpell(*itr, SPELL_ICEBOLT_CAST, false);
                            blockList.push_back((*itr)->GetGUID());
                            currentTarget = (*itr)->GetGUID();
                            --iceboltCount;
                            events.ScheduleEvent(EVENT_FLIGHT_ICEBOLT, Seconds(uint32(me->GetExactDist(*itr) / 13.0f)));
                        }
                        else
                        {
                            events.ScheduleEvent(EVENT_FLIGHT_BREATH, 1s);
                        }
                        return;
                    }
                case EVENT_FLIGHT_BREATH:
                    currentTarget.Clear();
                    Talk(EMOTE_BREATH);
                    me->CastSpell(me, SPELL_FROST_MISSILE, false);
                    events.ScheduleEvent(EVENT_FLIGHT_SPELL_EXPLOSION, 8500ms);
                    return;
                case EVENT_FLIGHT_SPELL_EXPLOSION:
                    me->CastSpell(me, SPELL_FROST_EXPLOSION, true);
                    events.ScheduleEvent(EVENT_FLIGHT_START_LAND, 3s);
                    return;
                case EVENT_FLIGHT_START_LAND:
                    if (!blockList.empty())
                    {
                        for (GuidList::const_iterator itr = blockList.begin(); itr != blockList.end(); ++itr)
                        {
                            if (Unit* block = ObjectAccessor::GetUnit(*me, *itr))
                            {
                                block->RemoveAurasDueToSpell(SPELL_ICEBOLT_TRIGGER);
                            }
                        }
                    }
                    blockList.clear();
                    me->RemoveAllGameObjects();
                    events.ScheduleEvent(EVENT_LAND, 1s);
                    return;
                case EVENT_LAND:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    me->SetDisableGravity(false);
                    events.ScheduleEvent(EVENT_GROUND, 1500ms);
                    return;
                case EVENT_GROUND:
                    Talk(EMOTE_GROUND_PHASE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetInCombatWithZone();
                    return;
                case EVENT_HUNDRED_CLUB:
                    {
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for (auto const& itr : pList)
                        {
                            if (itr.GetSource()->GetResistance(SPELL_SCHOOL_FROST) > 100)
                            {
                                instance->SetData(DATA_HUNDRED_CLUB, 0);
                                return;
                            }
                        }
                        events.Repeat(5s);
                        return;
                    }
            }
            DoMeleeAttackIfReady();
        }
    };
};

class spell_sapphiron_frost_explosion : public SpellScript
{
    PrepareSpellScript(spell_sapphiron_frost_explosion);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->ToCreature())
            return;

        std::list<WorldObject*> tmplist;
        for (auto& target : targets)
        {
            if (CAST_AI(boss_sapphiron::boss_sapphironAI, caster->ToCreature()->AI())->IsValidExplosionTarget(target))
            {
                tmplist.push_back(target);
            }
        }
        targets.clear();
        for (auto& itr : tmplist)
        {
            targets.push_back(itr);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sapphiron_frost_explosion::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

void AddSC_boss_sapphiron()
{
    new boss_sapphiron();
    RegisterSpellScript(spell_sapphiron_frost_explosion);
}
