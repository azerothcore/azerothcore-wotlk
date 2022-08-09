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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ruins_of_ahnqiraj.h"

enum Spells
{
    SPELL_STINGER_SPRAY  = 25749,
    SPELL_POISON_STINGER = 25748,
    SPELL_PARALYZE       = 25725,
    SPELL_FRENZY         = 8269,
    SPELL_LASH           = 25852,
    SPELL_FEED           = 25721,

    // Server-side spells
    SPELL_SUMMON_LARVA_A = 26538,
    SPELL_SUMMON_LARVA_B = 26539,
    SPELL_LARVA_AGGRO_EFFECT = 25724, // Unknown purpose
    SPELL_LARVA_FEAR_EFFECT  = 25726, // Unknown purpose
};

enum Events
{
    EVENT_STINGER_SPRAY  = 1,
    EVENT_POISON_STINGER = 2,
    EVENT_SUMMON_SWARMER = 3,
    EVENT_SWARMER_ATTACK = 4,
    EVENT_PARALYZE       = 5,
    EVENT_LASH           = 6
};

enum Emotes
{
    EMOTE_FRENZY         =  0
};

enum Phases
{
    PHASE_AIR            = 0,
    PHASE_GROUND         = 1
};

enum Points
{
    POINT_AIR            = 0,
    POINT_GROUND         = 2,
    POINT_PARALYZE       = 2
};

const Position AyamissAirPos =  { -9689.292f, 1547.912f, 48.02729f, 0.0f };
const Position AltarPos =       { -9717.18f, 1517.72f, 27.4677f, 0.0f };
/// @todo These below are probably incorrect, taken from SD2
const Position SwarmerPos =     { -9647.352f, 1578.062f, 55.32f, 0.0f };

struct boss_ayamiss : public BossAI
{
    boss_ayamiss(Creature* creature) : BossAI(creature, DATA_AYAMISS) { homePos = creature->GetHomePosition(); }

    void Reset() override
    {
        BossAI::Reset();
        _phase = PHASE_AIR;
        _enraged = false;
        SetCombatMovement(false);
    }

    void JustSummoned(Creature* who) override
    {
        switch (who->GetEntry())
        {
            case NPC_SWARMER:
                _swarmers.push_back(who->GetGUID());
                break;
            case NPC_LARVA:
                who->GetMotionMaster()->MovePoint(POINT_PARALYZE, AltarPos);
                break;
            case NPC_HORNET:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                {
                    who->AI()->AttackStart(target);
                }
                break;
        }

        summons.Summon(who);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_AIR)
        {
            me->AddUnitState(UNIT_STATE_ROOT);
        }
        else if (type == WAYPOINT_MOTION_TYPE && id == POINT_GROUND)
        {
            SetCombatMovement(true);
            me->m_Events.AddEventAtOffset([this]()
            {
                if (me->GetVictim())
                {
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                }

            }, 1s);
        }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->ClearUnitState(UNIT_STATE_ROOT);
        me->SetHomePosition(homePos);
        BossAI::EnterEvadeMode(why);
    }

    void EnterCombat(Unit* attacker) override
    {
        BossAI::EnterCombat(attacker);
        events.ScheduleEvent(EVENT_STINGER_SPRAY, 20s, 30s);
        events.ScheduleEvent(EVENT_POISON_STINGER, 5s);
        events.ScheduleEvent(EVENT_SUMMON_SWARMER, 5s);
        events.ScheduleEvent(EVENT_SWARMER_ATTACK, 60s);
        events.ScheduleEvent(EVENT_PARALYZE, 15s);
        me->SetCanFly(true);
        me->SetDisableGravity(true);
        me->GetMotionMaster()->MovePoint(POINT_AIR, AyamissAirPos);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (_phase == PHASE_AIR && me->HealthBelowPctDamaged(70, damage))
        {
            _phase = PHASE_GROUND;
            me->ClearUnitState(UNIT_STATE_ROOT);
            me->SetCanFly(false);
            me->SetDisableGravity(false);
            me->GetMotionMaster()->MovePath(me->GetEntry() * 10, false);
            events.ScheduleEvent(EVENT_LASH, 5s, 8s);
            events.CancelEvent(EVENT_POISON_STINGER);
            DoResetThreat();
        }

        if (!_enraged && me->HealthBelowPctDamaged(20, damage))
        {
            DoCastSelf(SPELL_FRENZY);
            Talk(EMOTE_FRENZY);
            _enraged = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_STINGER_SPRAY:
                DoCastSelf(SPELL_STINGER_SPRAY);
                events.ScheduleEvent(EVENT_STINGER_SPRAY, 15s, 20s);
                break;
            case EVENT_POISON_STINGER:
                DoCastVictim(SPELL_POISON_STINGER);
                events.ScheduleEvent(EVENT_POISON_STINGER, 2s, 3s);
                break;
            case EVENT_PARALYZE:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0, true))
                {
                    DoCast(target, SPELL_PARALYZE, true);
                    instance->SetGuidData(DATA_PARALYZED, target->GetGUID());
                    DoCastAOE(RAND(SPELL_SUMMON_LARVA_A, SPELL_SUMMON_LARVA_B), true);
                }
                events.ScheduleEvent(EVENT_PARALYZE, 15s);
                break;
            case EVENT_SWARMER_ATTACK:
                for (ObjectGuid const& guid : _swarmers)
                {
                    if (Creature* swarmer = me->GetMap()->GetCreature(guid))
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                        {
                            swarmer->AI()->AttackStart(target);
                        }
                    }
                }
                _swarmers.clear();
                events.ScheduleEvent(EVENT_SWARMER_ATTACK, 60s);
                break;
            case EVENT_SUMMON_SWARMER:
            {
                Position const offset = { 0.0f, 0.0f, 20.0f, 0.0f };
                Position spawnpos = me->GetRandomPoint(SwarmerPos, 80.0f);
                spawnpos.RelocateOffset(offset);
                if (Creature* wasp = me->SummonCreature(NPC_SWARMER, spawnpos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    wasp->GetMotionMaster()->MoveRandom(10.0f);
                }
                events.ScheduleEvent(EVENT_SUMMON_SWARMER, 5s);
                break;
            }
            case EVENT_LASH:
                DoCastVictim(SPELL_LASH);
                events.ScheduleEvent(EVENT_LASH, 8s, 15s);
                break;
            }
        }
        DoMeleeAttackIfReady();
    }
private:
    GuidList _swarmers;
    uint8 _phase;
    bool _enraged;
    Position homePos;
};

struct npc_hive_zara_larva : public ScriptedAI
{
    npc_hive_zara_larva(Creature* creature) : ScriptedAI(creature)
    {
        _instance = me->GetInstanceScript();
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE)
        {
            if (id == POINT_PARALYZE)
            {
                if (Player* target = ObjectAccessor::GetPlayer(*me, _instance->GetGuidData(DATA_PARALYZED)))
                {
                    DoCast(target, SPELL_FEED);
                }
            }
        }
    }

    void JustSummoned(Creature* summon) override
    {
        if (Creature* ayamiss = _instance->GetCreature(DATA_AYAMISS))
        {
            ayamiss->AI()->JustSummoned(summon);
        }
    }

    void MoveInLineOfSight(Unit* who) override

    {
        if (_instance->GetBossState(DATA_AYAMISS) == IN_PROGRESS)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void AttackStart(Unit* victim) override
    {
        if (_instance->GetBossState(DATA_AYAMISS) == IN_PROGRESS)
            return;

        ScriptedAI::AttackStart(victim);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_instance->GetBossState(DATA_AYAMISS) == IN_PROGRESS)
            return;

        ScriptedAI::UpdateAI(diff);
    }
private:
    InstanceScript* _instance;
};

void AddSC_boss_ayamiss()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_ayamiss);
    RegisterRuinsOfAhnQirajCreatureAI(npc_hive_zara_larva);
}
