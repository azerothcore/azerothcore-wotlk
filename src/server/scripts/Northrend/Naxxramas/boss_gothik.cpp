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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "naxxramas.h"

enum Yells
{
    SAY_INTRO_1                     = 0,
    SAY_INTRO_2                     = 1,
    SAY_INTRO_3                     = 2,
    SAY_INTRO_4                     = 3,
    SAY_PHASE_TWO                   = 4,
    SAY_DEATH                       = 5,
    SAY_KILL                        = 6,

    EMOTE_PHASE_TWO                 = 7,
    EMOTE_GATE_OPENED               = 8
};

enum Spells
{
    // Gothik
    SPELL_HARVEST_SOUL              = 28679,
    SPELL_SHADOW_BOLT_10            = 29317,
    SPELL_SHADOW_BOLT_25            = 56405,
    // Teleport spells
    SPELL_TELEPORT_DEAD             = 28025,
    SPELL_TELEPORT_LIVE             = 28026,
    //  Visual spells
    SPELL_INFORM_LIVING_TRAINEE     = 27892,
    SPELL_INFORM_LIVING_KNIGHT      = 27928,
    SPELL_INFORM_LIVING_RIDER       = 27935,
    SPELL_INFORM_DEAD_TRAINEE       = 27915,
    SPELL_INFORM_DEAD_KNIGHT        = 27931,
    SPELL_INFORM_DEAD_RIDER         = 27937,
    /*SPELL_ANCHOR_2_TRAINEE          = 27893,
    SPELL_ANCHOR_2_DK               = 27929,
    SPELL_ANCHOR_2_RIDER            = 27936, fix me */
    // Living trainee
    SPELL_DEATH_PLAGUE              = 55604,
    // Dead trainee
    SPELL_ARCANE_EXPLOSION          = 27989,
    // Living knight
    SPELL_SHADOW_MARK               = 27825,
    // Dead knight
    SPELL_WHIRLWIND                 = 56408,
    // Living rider
    SPELL_SHADOW_BOLT_VOLLEY        = 27831,
    // Dead rider
    SPELL_DRAIN_LIFE                = 27994,
    SPELL_UNHOLY_FRENZY             = 55648,
    // Horse
    SPELL_STOMP                     = 27993
};

enum Misc
{
    NPC_LIVING_TRAINEE              = 16124,
    NPC_LIVING_KNIGHT               = 16125,
    NPC_LIVING_RIDER                = 16126,
    NPC_DEAD_TRAINEE                = 16127,
    NPC_DEAD_KNIGHT                 = 16148,
    NPC_DEAD_HORSE                  = 16149,
    NPC_DEAD_RIDER                  = 16150,
    //NPC_TRIGGER                     = 16137, fix me
};

enum Events
{
    // Gothik
    EVENT_SUMMON_ADDS               = 1,
    EVENT_HARVEST_SOUL              = 2,
    EVENT_SHADOW_BOLT               = 3,
    EVENT_TELEPORT                  = 4,
    EVENT_CHECK_HEALTH              = 5,
    EVENT_CHECK_PLAYERS             = 6,
    // Living trainee
    EVENT_DEATH_PLAGUE              = 7,
    // Dead trainee
    EVENT_ARCANE_EXPLOSION          = 8,
    // Living knight
    EVENT_SHADOW_MARK               = 9,
    // Dead knight
    EVENT_WHIRLWIND                 = 10,
    // Living rider
    EVENT_SHADOW_BOLT_VOLLEY        = 11,
    // Dead rider
    EVENT_DRAIN_LIFE                = 12,
    EVENT_UNHOLY_FRENZY             = 13,
    // HORSE
    EVENT_STOMP                     = 14,
    // Intro
    EVENT_INTRO_2                   = 15,
    EVENT_INTRO_3                   = 16,
    EVENT_INTRO_4                   = 17
};

const uint32 gothikWaves[24][2] =
{
    {NPC_LIVING_TRAINEE,    20000},
    {NPC_LIVING_TRAINEE,    20000},
    {NPC_LIVING_TRAINEE,    10000},
    {NPC_LIVING_KNIGHT,     10000},
    {NPC_LIVING_TRAINEE,    15000},
    {NPC_LIVING_KNIGHT,     10000},
    {NPC_LIVING_TRAINEE,    15000},
    {NPC_LIVING_TRAINEE,    0},
    {NPC_LIVING_KNIGHT,     10000},
    {NPC_LIVING_RIDER,      10000},
    {NPC_LIVING_TRAINEE,    5000},
    {NPC_LIVING_KNIGHT,     15000},
    {NPC_LIVING_RIDER,      0},
    {NPC_LIVING_TRAINEE,    10000},
    {NPC_LIVING_KNIGHT,     10000},
    {NPC_LIVING_TRAINEE,    10000},
    {NPC_LIVING_RIDER,      5000},
    {NPC_LIVING_KNIGHT,     5000},
    {NPC_LIVING_TRAINEE,    20000},
    {NPC_LIVING_RIDER,      0},
    {NPC_LIVING_KNIGHT,     0},
    {NPC_LIVING_TRAINEE,    15000},
    {NPC_LIVING_TRAINEE,    29000},
    {0, 0}
};

const Position PosSummonLiving[6] =
{
    {2669.7f, -3428.76f, 268.56f, 1.6f},
    {2692.1f, -3428.76f, 268.56f, 1.6f},
    {2714.4f, -3428.76f, 268.56f, 1.6f},
    {2669.7f, -3431.67f, 268.56f, 1.6f},
    {2692.1f, -3431.67f, 268.56f, 1.6f},
    {2714.4f, -3431.67f, 268.56f, 1.6f}
};

const Position PosSummonDead[5] =
{
    {2725.1f, -3310.0f, 268.85f, 3.4f},
    {2699.3f, -3322.8f, 268.60f, 3.3f},
    {2733.1f, -3348.5f, 268.84f, 3.1f},
    {2682.8f, -3304.2f, 268.85f, 3.9f},
    {2664.8f, -3340.7f, 268.23f, 3.7f}
};

//const Position PosGroundLivingSide = {2691.2f, -3387.0f, 267.68f, 1.52f};
//const Position PosGroundDeadSide   = {2693.5f, -3334.6f, 267.68f, 4.67f};
//const Position PosPlatform         = {2640.5f, -3360.6f, 285.26f, 0.0f};

#define POS_Y_GATE  -3360.78f
#define POS_Y_WEST  -3285.0f
#define POS_Y_EAST  -3434.0f
#define POS_X_NORTH  2750.49f
#define POS_X_SOUTH  2633.84f
#define IN_LIVE_SIDE(who) (who->GetPositionY() < POS_Y_GATE)

// Predicate function to check that the r   efzr unit is NOT on the same side as the source.
struct NotOnSameSide
{
public:
    explicit NotOnSameSide(Unit* pSource) : m_inLiveSide(IN_LIVE_SIDE(pSource)) { }

    bool operator() (Unit const* pTarget)
    {
        return (m_inLiveSide != IN_LIVE_SIDE(pTarget));
    }

private:
    bool m_inLiveSide;
};

class boss_gothik : public CreatureScript
{
public:
    boss_gothik() : CreatureScript("boss_gothik") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_gothikAI>(pCreature);
    }

    struct boss_gothikAI : public BossAI
    {
        explicit boss_gothikAI(Creature* c) : BossAI(c, BOSS_GOTHIK), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }
        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;
        bool secondPhase{};
        bool gateOpened{};
        uint8 waveCount{};

        bool IsInRoom()
        {
            if (me->GetPositionX() > 2767 || me->GetPositionX() < 2618 || me->GetPositionY() > -3285 || me->GetPositionY() < -3435)
            {
                EnterEvadeMode();
                return false;
            }
            return true;
        }

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            me->SetImmuneToPC(false);
            me->SetReactState(REACT_PASSIVE);
            secondPhase = false;
            gateOpened = false;
            waveCount = 0;
            me->NearTeleportTo(2642.139f, -3386.959f, 285.492f, 6.265f);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_ENTER_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_INNER_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_EXIT_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->SetInCombatWithZone();
            Talk(SAY_INTRO_1);
            events.ScheduleEvent(EVENT_INTRO_2, 4s);
            events.ScheduleEvent(EVENT_INTRO_3, 9s);
            events.ScheduleEvent(EVENT_INTRO_4, 14s);
            me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            events.ScheduleEvent(EVENT_SUMMON_ADDS, 30s);
            events.ScheduleEvent(EVENT_CHECK_PLAYERS, 2min);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_ENTER_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_INNER_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, 200.0f))
            {
                if (gateOpened)
                {
                    summon->AI()->AttackStart(target);
                    summon->CallForHelp(40.0f);
                }
                else
                {
                    if (summon->GetEntry() == NPC_LIVING_TRAINEE ||
                        summon->GetEntry() == NPC_LIVING_KNIGHT  ||
                        summon->GetEntry() == NPC_LIVING_RIDER   )
                    {
                        if (IN_LIVE_SIDE(target))
                        {
                            summon->AI()->AttackStart(target);
                        }
                    }
                    else
                    {
                        if (!IN_LIVE_SIDE(target))
                        {
                            summon->AI()->AttackStart(target);
                        }
                    }
                }
            }
        }

        void SummonedCreatureDespawn(Creature* cr) override
        {
            summons.Despawn(cr);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_KILL);
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
            summons.DespawnAll();
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_ENTER_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_INNER_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_EXIT_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void SummonHelpers(uint32 entry)
        {
            switch(entry)
            {
                case NPC_LIVING_TRAINEE:
                    me->SummonCreature(NPC_LIVING_TRAINEE, PosSummonLiving[0].GetPositionX(), PosSummonLiving[0].GetPositionY(), PosSummonLiving[0].GetPositionZ(), PosSummonLiving[0].GetOrientation());
                    me->SummonCreature(NPC_LIVING_TRAINEE, PosSummonLiving[1].GetPositionX(), PosSummonLiving[1].GetPositionY(), PosSummonLiving[1].GetPositionZ(), PosSummonLiving[1].GetOrientation());
                    if (Is25ManRaid())
                    {
                        me->SummonCreature(NPC_LIVING_TRAINEE, PosSummonLiving[2].GetPositionX(), PosSummonLiving[2].GetPositionY(), PosSummonLiving[2].GetPositionZ(), PosSummonLiving[2].GetOrientation());
                    }
                    break;
                case NPC_LIVING_KNIGHT:
                    me->SummonCreature(NPC_LIVING_KNIGHT, PosSummonLiving[3].GetPositionX(), PosSummonLiving[3].GetPositionY(), PosSummonLiving[3].GetPositionZ(), PosSummonLiving[3].GetOrientation());
                    if (Is25ManRaid())
                    {
                        me->SummonCreature(NPC_LIVING_KNIGHT, PosSummonLiving[5].GetPositionX(), PosSummonLiving[5].GetPositionY(), PosSummonLiving[5].GetPositionZ(), PosSummonLiving[5].GetOrientation());
                    }
                    break;
                case NPC_LIVING_RIDER:
                    me->SummonCreature(NPC_LIVING_RIDER, PosSummonLiving[4].GetPositionX(), PosSummonLiving[4].GetPositionY(), PosSummonLiving[4].GetPositionZ(), PosSummonLiving[4].GetOrientation());
                    break;
            }
        }

        bool CheckGroupSplitted()
        {
            Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
            if (!PlayerList.IsEmpty())
            {
                bool checklife = false;
                bool checkdead = false;
                for (const auto& i : PlayerList)
                {
                    Player* player = i.GetSource();
                    if (player->IsAlive() &&
                        player->GetPositionX() <= POS_X_NORTH &&
                        player->GetPositionX() >= POS_X_SOUTH &&
                        player->GetPositionY() <= POS_Y_GATE &&
                        player->GetPositionY() >= POS_Y_EAST)
                        {
                            checklife = true;
                        }
                    else if (player->IsAlive() &&
                             player->GetPositionX() <= POS_X_NORTH &&
                             player->GetPositionX() >= POS_X_SOUTH &&
                             player->GetPositionY() >= POS_Y_GATE &&
                             player->GetPositionY() <= POS_Y_WEST)
                             {
                                 checkdead = true;
                             }

                    if (checklife && checkdead)
                        return true;
                }
            }
            return false;
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            uint8 pos = urand(0, 4);
            switch (spellInfo->Id)
            {
                case SPELL_INFORM_LIVING_TRAINEE:
                    me->SummonCreature(NPC_DEAD_TRAINEE, PosSummonDead[pos].GetPositionX(), PosSummonDead[pos].GetPositionY(), PosSummonDead[pos].GetPositionZ(), PosSummonDead[pos].GetOrientation());
                    break;
                case SPELL_INFORM_LIVING_KNIGHT:
                    me->SummonCreature(NPC_DEAD_KNIGHT, PosSummonDead[pos].GetPositionX(), PosSummonDead[pos].GetPositionY(), PosSummonDead[pos].GetPositionZ(), PosSummonDead[pos].GetOrientation());
                    break;
                case SPELL_INFORM_LIVING_RIDER:
                    me->SummonCreature(NPC_DEAD_RIDER, PosSummonDead[pos].GetPositionX(), PosSummonDead[pos].GetPositionY(), PosSummonDead[pos].GetPositionZ(), PosSummonDead[pos].GetOrientation());
                    me->SummonCreature(NPC_DEAD_HORSE, PosSummonDead[pos].GetPositionX(), PosSummonDead[pos].GetPositionY(), PosSummonDead[pos].GetPositionZ(), PosSummonDead[pos].GetOrientation());
                    break;
            }
            me->HandleEmoteCommand(EMOTE_ONESHOT_SPELL_CAST);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!secondPhase)
            {
                damage = 0;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!IsInRoom())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_INTRO_2:
                    Talk(SAY_INTRO_2);
                    break;
                case EVENT_INTRO_3:
                    Talk(SAY_INTRO_3);
                    break;
                case EVENT_INTRO_4:
                    Talk(SAY_INTRO_4);
                    break;
                case EVENT_SHADOW_BOLT:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_SHADOW_BOLT_10, SPELL_SHADOW_BOLT_25), false);
                    events.Repeat(1s);
                    break;
                case EVENT_HARVEST_SOUL:
                    me->CastSpell(me, SPELL_HARVEST_SOUL, false);
                    events.Repeat(15s);
                    break;
                case EVENT_TELEPORT:
                    me->AttackStop();
                    if (IN_LIVE_SIDE(me))
                    {
                        me->CastSpell(me, SPELL_TELEPORT_DEAD, false);
                    }
                    else
                    {
                        me->CastSpell(me, SPELL_TELEPORT_LIVE, false);
                    }
                    me->GetThreatMgr().resetAggro(NotOnSameSide(me));
                    if (Unit* pTarget = SelectTarget(SelectTargetMethod::MaxDistance, 0))
                    {
                        me->GetThreatMgr().AddThreat(pTarget, 100.0f);
                        AttackStart(pTarget);
                    }
                    events.Repeat(20s);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(30) && pInstance)
                    {
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_INNER_GATE)))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                        }
                        events.CancelEvent(EVENT_TELEPORT);
                        break;
                    }
                    events.Repeat(1s);
                    break;
                case EVENT_SUMMON_ADDS:
                    if (gothikWaves[waveCount][0])
                    {
                        SummonHelpers(gothikWaves[waveCount][0]);
                        events.RepeatEvent(gothikWaves[waveCount][1]);
                    }
                    else
                    {
                        secondPhase = true;
                        Talk(SAY_PHASE_TWO);
                        Talk(EMOTE_PHASE_TWO);
                        me->CastSpell(me, SPELL_TELEPORT_LIVE, false);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                        me->SetImmuneToPC(false);
                        me->RemoveAllAuras();
                        events.ScheduleEvent(EVENT_SHADOW_BOLT, 1s);
                        events.ScheduleEvent(EVENT_HARVEST_SOUL, 5s, 15s);
                        events.ScheduleEvent(EVENT_TELEPORT, 20s);
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1s);
                    }
                    waveCount++;
                    break;
                case EVENT_CHECK_PLAYERS:
                    if (!CheckGroupSplitted())
                    {
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_GOTHIK_INNER_GATE)))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                        }
                        gateOpened = true;
                        Talk(EMOTE_GATE_OPENED);
                    }
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class npc_boss_gothik_minion : public CreatureScript
{
public:
    npc_boss_gothik_minion() : CreatureScript("npc_boss_gothik_minion") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<npc_boss_gothik_minionAI>(pCreature);
    }

    struct npc_boss_gothik_minionAI : public CombatAI
    {
        explicit npc_boss_gothik_minionAI(Creature* c) : CombatAI(c)
        {
            livingSide = IN_LIVE_SIDE(me);
        }
        EventMap events;
        bool livingSide;
        bool IsOnSameSide(Unit const* who) const { return livingSide == IN_LIVE_SIDE(who); }

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetNoCallAssistance(false);
            events.Reset();
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            switch (me->GetEntry())
            {
                case NPC_LIVING_TRAINEE:
                    events.ScheduleEvent(EVENT_DEATH_PLAGUE, 3s);
                    break;
                case NPC_DEAD_TRAINEE:
                    events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, 2500ms);
                    break;
                case NPC_LIVING_KNIGHT:
                    events.ScheduleEvent(EVENT_SHADOW_MARK, 3s);
                    break;
                case NPC_DEAD_KNIGHT:
                    events.ScheduleEvent(EVENT_WHIRLWIND, 2s);
                    break;
                case NPC_LIVING_RIDER:
                    events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 3s);
                    break;
                case NPC_DEAD_RIDER:
                    events.ScheduleEvent(EVENT_DRAIN_LIFE, 2000ms, 3500ms);
                    events.ScheduleEvent(EVENT_UNHOLY_FRENZY, 5s, 9s);
                    break;
                case NPC_DEAD_HORSE:
                    events.ScheduleEvent(EVENT_STOMP, 2s, 5s);
                    break;
            }
        }

        void JustDied(Unit*) override
        {
            switch (me->GetEntry())
            {
                case NPC_LIVING_TRAINEE:
                    me->CastSpell(me, SPELL_INFORM_LIVING_TRAINEE, true);
                    break;
                case NPC_LIVING_KNIGHT:
                    me->CastSpell(me, SPELL_INFORM_LIVING_KNIGHT, true);
                    break;
                case NPC_LIVING_RIDER:
                    me->CastSpell(me, SPELL_INFORM_LIVING_RIDER, true);
                    break;
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && me->GetInstanceScript())
            {
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            if (me->GetUnitState() == UNIT_STATE_CASTING)
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_DEATH_PLAGUE:
                    me->CastSpell(me->GetVictim(), SPELL_DEATH_PLAGUE, false);
                    events.Repeat(4s, 7s);
                    break;
                case EVENT_ARCANE_EXPLOSION:
                    if (Unit* victim = me->GetVictim())
                    {
                        if (victim->IsWithinDist(me, 20))
                        {
                            me->CastSpell(victim, SPELL_ARCANE_EXPLOSION, false);
                        }
                    }
                    events.Repeat(2500ms);
                    break;
                case EVENT_SHADOW_MARK:
                    if (Unit* victim = me->GetVictim())
                    {
                        if (victim->IsWithinDist(me, 10))
                        {
                            me->CastSpell(victim, SPELL_SHADOW_MARK, false);
                        }
                    }
                    events.Repeat(5s, 7s);
                    break;
                case EVENT_WHIRLWIND:
                    if (Unit* victim = me->GetVictim())
                    {
                        if (victim->IsWithinDist(me, 10))
                        {
                            me->CastSpell(victim, SPELL_WHIRLWIND, false);
                        }
                    }
                    events.Repeat(4s, 6s);
                    break;
                case EVENT_SHADOW_BOLT_VOLLEY:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT_VOLLEY, false);
                    events.Repeat(5s);
                    break;
                case EVENT_DRAIN_LIFE:
                    if (Unit* victim = me->GetVictim())
                    {
                        if (victim->IsWithinDist(me, 20))
                        {
                            me->CastSpell(victim, SPELL_DRAIN_LIFE, false);
                        }
                    }
                    events.Repeat(8s, 12s);
                    break;
                case EVENT_UNHOLY_FRENZY:
                    me->AddAura(SPELL_UNHOLY_FRENZY, me);
                    events.Repeat(15s, 17s);
                    break;
                case EVENT_STOMP:
                    if (Unit* victim = me->GetVictim())
                    {
                        if (victim->IsWithinDist(me, 10))
                        {
                            me->CastSpell(victim, SPELL_STOMP, false);
                        }
                    }
                    events.Repeat(4s, 9s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class spell_gothik_shadow_bolt_volley : public SpellScript
{
    PrepareSpellScript(spell_gothik_shadow_bolt_volley);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOW_MARK });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(false, SPELL_SHADOW_MARK));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gothik_shadow_bolt_volley::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_gothik()
{
    new boss_gothik();
    new npc_boss_gothik_minion();
    RegisterSpellScript(spell_gothik_shadow_bolt_volley);
}

