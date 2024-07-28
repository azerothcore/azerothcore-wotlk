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

#include "the_black_morass.h"
#include "CreatureScript.h"
#include "MoveSplineInit.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum medivhMisc
{
    NPC_SHADOW_COUNCIL_ENFORCER = 17023,
    GO_DARK_PORTAL              = 185103,

    EVENT_CHECK_HEALTH_25       = 1,
    EVENT_CHECK_HEALTH_50       = 2,
    EVENT_CHECK_HEALTH_75       = 3,
    EVENT_SUMMON_CRYSTAL        = 4,
    EVENT_SUMMON_FLYING_CRYSTAL = 5,

    EVENT_OUTRO_1               = 10,
    EVENT_OUTRO_2               = 11,
    EVENT_OUTRO_3               = 12,
    EVENT_OUTRO_4               = 13,
    EVENT_OUTRO_5               = 14,
    EVENT_OUTRO_6               = 15,
    EVENT_OUTRO_7               = 16,
    EVENT_OUTRO_8               = 17
};

static std::vector<uint32> firstWave = { NPC_INFINITE_ASSASSIN, NPC_INFINITE_WHELP, NPC_INFINITE_CHRONOMANCER };
static std::vector<uint32> secondWave = { NPC_INFINITE_EXECUTIONER, NPC_INFINITE_CHRONOMANCER, NPC_INFINITE_WHELP, NPC_INFINITE_ASSASSIN };
static std::vector<uint32> thirdWave = { NPC_INFINITE_EXECUTIONER, NPC_INFINITE_VANQUISHER, NPC_INFINITE_CHRONOMANCER, NPC_INFINITE_ASSASSIN  };

class NpcRunToHome : public BasicEvent
{
public:
    NpcRunToHome(Creature& owner) : _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.GetMotionMaster()->MoveTargetedHome();
        return true;
    }

private:
    Creature& _owner;
};

struct npc_medivh_bm : public ScriptedAI
{
    npc_medivh_bm(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();

        _groundArray.clear();
        _airArray.clear();

        _groundArray.push_back(G3D::Vector3(creature->GetPositionX() + 8.0f, creature->GetPositionY(), creature->GetPositionZ()));
        _airArray.push_back(G3D::Vector3(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ()));

        for (uint8 i = 0; i < 10; ++i)
        {
            _groundArray.push_back(G3D::Vector3(creature->GetPositionX() + 8.0f * cos(2.0f * M_PI * i / 10.0f), creature->GetPositionY() + 8.0f * std::sin(2.0f * M_PI * i / 10.0f), creature->GetPositionZ()));
        }

        for (uint8 i = 0; i < 40; ++i)
        {
            _airArray.push_back(G3D::Vector3(creature->GetPositionX() + i * 0.25f * cos(2.0f * M_PI * i / 10.0f), creature->GetPositionY() + i * 0.25f * std::sin(2.0f * M_PI * i / 10.0f), creature->GetPositionZ() + i / 4.0f));
        }

        for (uint8 i = 40; i < 80; ++i)
        {
            _airArray.push_back(G3D::Vector3(creature->GetPositionX() + 10.0f * cos(2.0f * M_PI * i / 10.0f), creature->GetPositionY() + 10.0f * std::sin(2.0f * M_PI * i / 10.0f), creature->GetPositionZ() + i / 4.0f));
        }
    }

    void Reset() override
    {
        events.Reset();
        me->CastSpell(me, SPELL_MANA_SHIELD, true);

        if (_instance->GetBossState(DATA_AEONUS) != DONE)
        {
            me->CastSpell(me, SPELL_MEDIVH_CHANNEL, false);
        }

        me->SetImmuneToNPC(false);
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() == NPC_DP_CRYSTAL_STALKER)
        {
            summon->DespawnOrUnsummon(25000);
            summon->CastSpell(summon, RAND(SPELL_BANISH_PURPLE, SPELL_BANISH_GREEN), true);
            summon->GetMotionMaster()->MoveSplinePath(&_airArray);
        }
        else if (summon->GetEntry() == NPC_DP_EMITTER_STALKER)
        {
            summon->CastSpell(summon, SPELL_BLACK_CRYSTAL, true);
            Movement::MoveSplineInit init(summon);
            init.MovebyPath(_groundArray);
            init.SetCyclic();
            init.Launch();
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!events.Empty() || _instance->GetBossState(DATA_AEONUS) == DONE)
        {
            return;
        }

        if (who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 20.0f))
        {
            Talk(SAY_MEDIVH_ENTER);
            _instance->SetData(DATA_MEDIVH, 1);

            me->CastSpell(me, SPELL_MEDIVH_CHANNEL, false);

            events.ScheduleEvent(EVENT_CHECK_HEALTH_75, 500);
            events.ScheduleEvent(EVENT_CHECK_HEALTH_50, 500);
            events.ScheduleEvent(EVENT_CHECK_HEALTH_25, 500);
            events.ScheduleEvent(EVENT_SUMMON_CRYSTAL, 2000);
            events.ScheduleEvent(EVENT_SUMMON_CRYSTAL, 4000);
            events.ScheduleEvent(EVENT_SUMMON_CRYSTAL, 6000);
            events.ScheduleEvent(EVENT_SUMMON_FLYING_CRYSTAL, 8000);
        }
    }

    void AttackStart(Unit* ) override { }

    void DoAction(int32 param) override
    {
        if (param == ACTION_OUTRO)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_OUTRO_1, 4000);
            me->InterruptNonMeleeSpells(true);

            me->SummonGameObject(GO_DARK_PORTAL, -2086.0f, 7125.6215f, 30.5f, 6.148f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->SetRespawnTime(DAY);
        events.Reset();
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (uint32 eventId = events.ExecuteEvent())
        {
            case EVENT_CHECK_HEALTH_25:
            case EVENT_CHECK_HEALTH_50:
            case EVENT_CHECK_HEALTH_75:
                if (_instance->GetData(DATA_SHIELD_PERCENT) <= eventId * 25)
                {
                    Talk(eventId + 1);
                    break;
                }
                events.ScheduleEvent(eventId, 500);
                break;
            case EVENT_SUMMON_CRYSTAL:
                me->SummonCreature(NPC_DP_EMITTER_STALKER, me->GetPositionX() + 8.0f, me->GetPositionY(), me->GetPositionZ());
                break;
            case EVENT_SUMMON_FLYING_CRYSTAL:
                me->CastSpell(me, SPELL_PORTAL_CRYSTALS, true);
                events.ScheduleEvent(EVENT_SUMMON_FLYING_CRYSTAL, 1000);
                break;
            case EVENT_OUTRO_1:
                me->SetFacingTo(6.21f);
                Talk(SAY_MEDIVH_WIN);
                events.ScheduleEvent(EVENT_OUTRO_2, 17000);
                break;
            case EVENT_OUTRO_2:
                me->SetFacingTo(3.07f);
                events.ScheduleEvent(EVENT_OUTRO_3, 2000);
                break;
            case EVENT_OUTRO_3:
                SummonOrcs(-2046.158f, -3.0f, 37000, 30000, true);
                events.ScheduleEvent(EVENT_OUTRO_4, 2000);
                break;
            case EVENT_OUTRO_4:
                SummonOrcs(-2055.97f, -2.0f, 33000, 28000, false);
                events.ScheduleEvent(EVENT_OUTRO_5, 2000);
                break;
            case EVENT_OUTRO_5:
                SummonOrcs(-2064.0f, -1.5f, 29000, 26000, false);
                events.ScheduleEvent(EVENT_OUTRO_6, 2000);
                break;
            case EVENT_OUTRO_6:
                SummonOrcs(-2074.35f, -0.1f, 26000, 24000, false);
                events.ScheduleEvent(EVENT_OUTRO_7, 7000);
                break;
            case EVENT_OUTRO_7:
                Talk(SAY_MEDIVH_ORCS_ENTER);
                events.ScheduleEvent(EVENT_OUTRO_8, 7000);
                break;
            case EVENT_OUTRO_8:
                if (Creature* cr = me->FindNearestCreature(NPC_SHADOW_COUNCIL_ENFORCER, 20.0f))
                {
                    cr->SetFacingTo(3.07f);
                    cr->AI()->Talk(SAY_MEDIVH_ORCS_ANSWER);
                }
                break;
        }
    }

    void SummonOrcs(float x, float y, uint32 duration, uint32 homeTime, bool first)
    {
        for (uint8 i = 0; i < 6; ++i)
        {
            if (Creature* cr = me->SummonCreature(NPC_SHADOW_COUNCIL_ENFORCER, -2091.731f, 7133.083f - 3.0f * i, 34.589f, 0.0f))
            {
                cr->GetMotionMaster()->MovePoint(0, (first && i == 3) ? x + 2.0f : x, cr->GetPositionY() + y, cr->GetMapHeight(x, cr->GetPositionY() + y, cr->GetPositionZ(), true));
                cr->m_Events.AddEvent(new NpcRunToHome(*cr), cr->m_Events.CalculateTime(homeTime + urand(0, 2000)));
                cr->DespawnOrUnsummon(duration + urand(0, 2000));
            }
        }
    }

private:
    InstanceScript* _instance;
    EventMap _events;
    Movement::PointsArray _groundArray;
    Movement::PointsArray _airArray;
};

enum timeRift
{
    EVENT_SUMMON_AT_RIFT        = 1,
    EVENT_CHECK_DEATH           = 2,
    EVENT_SUMMON_BOSS           = 3,

    SAY_RIFT_MOB_SUMMONED       = 0
};

struct npc_time_rift : public NullCreatureAI
{
    npc_time_rift(Creature* creature) : NullCreatureAI(creature)
    {
        _instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        uint32 riftNumer = _instance->GetData(DATA_RIFT_NUMBER);

        if (riftNumer < 6)
        {
            waveMobs = firstWave;
        }
        else if (riftNumer < 12)
        {
            waveMobs = secondWave;
        }
        else
        {
            waveMobs = thirdWave;
        }

        waveMobIndex = 0;
        events.ScheduleEvent(EVENT_SUMMON_AT_RIFT, 16s);
        events.ScheduleEvent(EVENT_SUMMON_BOSS, 6s);
    }

    void JustSummoned(Creature* creature) override
    {
        if (creature->GetEntry() != NPC_AEONUS && _riftKeeperGUID.IsEmpty())
        {
            _riftKeeperGUID = creature->GetGUID();
        }
    }

    void DoSummonAtRift(uint32 entry)
    {
        Position pos = me->GetNearPosition(10.0f, 2 * M_PI * rand_norm());

        if (Creature* summon = me->SummonCreature(entry, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 150000))
        {
            if (Creature* medivh = _instance->GetCreature(DATA_MEDIVH))
            {
                float o = medivh->GetAngle(summon) + frand(-1.0f, 1.0f);
                summon->SetHomePosition(medivh->GetPositionX() + 14.0f * cos(o), medivh->GetPositionY() + 14.0f * std::sin(o), medivh->GetPositionZ(), summon->GetAngle(medivh));
                summon->GetMotionMaster()->MoveTargetedHome(true);
                summon->SetReactState(REACT_DEFENSIVE);
            }
        }
    }

    void DoSelectSummon()
    {
        uint32 entry = waveMobs[waveMobIndex];
        if (entry == NPC_INFINITE_WHELP)
        {
            DoSummonAtRift(entry);
            DoSummonAtRift(entry);
            DoSummonAtRift(entry);
        }
        else
        {
            if (urand(0, 1))
            {
                switch (entry)
                {
                    case NPC_INFINITE_ASSASSIN:
                        entry = NPC_INFINITE_ASSASSIN_2;
                        break;
                    case NPC_INFINITE_CHRONOMANCER:
                        entry = NPC_INFINITE_CHRONOMANCER_2;
                        break;
                    case NPC_INFINITE_EXECUTIONER:
                        entry = NPC_INFINITE_EXECUTIONER_2;
                        break;
                    case NPC_INFINITE_VANQUISHER:
                        entry = NPC_INFINITE_VANQUISHER_2;
                        break;
                    default:
                        break;
                }
            }

            DoSummonAtRift(entry);
        }

        if (++waveMobIndex >= waveMobs.size())
        {
            waveMobIndex = 0;
        }
    }

    void SummonedCreatureDies(Creature* creature, Unit* /*killer*/) override
    {
        if (creature->GetGUID() == _riftKeeperGUID)
        {
            me->DespawnOrUnsummon(0);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (events.ExecuteEvent())
        {
            case EVENT_SUMMON_AT_RIFT:
                if (!_instance->GetCreature(DATA_AEONUS))
                {
                    DoSelectSummon();
                    events.ScheduleEvent(EVENT_SUMMON_AT_RIFT, 15000);
                }
                break;
            case EVENT_SUMMON_BOSS:
            {
                int32 entry = 0;
                switch (_instance->GetData(DATA_RIFT_NUMBER))
                {
                    case 6:
                        entry = _instance->GetBossState(DATA_CHRONO_LORD_DEJA) == DONE ? (me->GetMap()->IsHeroic() ? NPC_INFINITE_CHRONO_LORD : -NPC_CHRONO_LORD_DEJA) : NPC_CHRONO_LORD_DEJA;
                        break;
                    case 12:
                        entry = _instance->GetBossState(DATA_TEMPORUS) == DONE ? (me->GetMap()->IsHeroic() ? NPC_INFINITE_TIMEREAVER : -NPC_TEMPORUS) : NPC_TEMPORUS;
                        break;
                    case 18:
                        entry = NPC_AEONUS;
                        break;
                    default:
                        entry = RAND(NPC_RIFT_KEEPER_WARLOCK, NPC_RIFT_KEEPER_MAGE, NPC_RIFT_LORD, NPC_RIFT_LORD_2);
                        break;
                }

                Position pos = me->GetNearPosition(10.0f, 2 * M_PI * rand_norm());

                if (Creature* summon = me->SummonCreature(std::abs(entry), pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3 * MINUTE * IN_MILLISECONDS))
                {
                    if (entry < 0)
                    {
                        summon->SetLootMode(0);
                    }

                    if (summon->GetEntry() != NPC_AEONUS)
                    {
                        me->CastSpell(summon, SPELL_RIFT_CHANNEL, false);
                    }

                    if (summon->IsAIEnabled)
                    {
                        summon->AI()->Talk(SAY_RIFT_MOB_SUMMONED);
                    }
                }
            }
        }
    }

private:
    EventMap _events;
    InstanceScript* _instance;
    ObjectGuid _riftKeeperGUID;
    std::vector<uint32> waveMobs;
    uint8 waveMobIndex;
};

struct npc_black_morass_summoned_add : public SmartAI
{
    npc_black_morass_summoned_add(Creature* creature) : SmartAI(creature)
    {
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        SmartAI::EnterEvadeMode(why);

        me->GetMotionMaster()->MoveTargetedHome(true);
    }
};

class spell_black_morass_corrupt_medivh : public AuraScript
{
    PrepareAuraScript(spell_black_morass_corrupt_medivh);

    bool Load() override
    {
        _ticks = 0;
        return true;
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        if (++_ticks >= 3)
        {
            _ticks = 0;

            if (InstanceScript* instance = GetUnitOwner()->GetInstanceScript())
            {
                instance->SetData(DATA_DAMAGE_SHIELD, m_scriptSpellId == SPELL_CORRUPT_AEONUS ? 2 : 1);
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_morass_corrupt_medivh::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    uint8 _ticks = 0;
};

void AddSC_the_black_morass()
{
    RegisterTheBlackMorassCreatureAI(npc_medivh_bm);
    RegisterTheBlackMorassCreatureAI(npc_time_rift);
    RegisterTheBlackMorassCreatureAI(npc_black_morass_summoned_add);

    RegisterSpellScript(spell_black_morass_corrupt_medivh);
}

