/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "GridNotifiers.h"
#include "CombatAI.h"
#include "naxxramas.h"

enum Yells
{
    SAY_INTRO_1                 = 0,
    SAY_INTRO_2                 = 1,
    SAY_INTRO_3                 = 2,
    SAY_INTRO_4                 = 3,
    SAY_PHASE_TWO               = 4,
    SAY_DEATH                   = 5,
    SAY_KILL                    = 6,

    EMOTE_PHASE_TWO             = 7,
    EMOTE_GATE_OPENED           = 8
};

enum Spells
{
    SPELL_HARVEST_SOUL              = 28679,
    SPELL_SHADOW_BOLT_10            = 29317,
    SPELL_SHADOW_BOLT_25            = 56405,
    SPELL_INFORM_LIVING_TRAINEE     = 27892,
    SPELL_INFORM_LIVING_KNIGHT      = 27928,
    SPELL_INFORM_LIVING_RIDER       = 27935,
    SPELL_INFORM_DEAD_TRAINEE       = 27915,
    SPELL_INFORM_DEAD_KNIGHT        = 27931,
    SPELL_INFORM_DEAD_RIDER         = 27937,

    // TRAINEES
    SPELL_DEATH_PLAGUE              = 55604,    // LIVING TRAINEE
    SPELL_ARCANE_EXPLOSION          = 27989,    // DEAD TRAINEE (20y)

    // KNIGHT
    SPELL_SHADOW_MARK               = 27825,    // LIVING KNIGHT
    SPELL_WHIRLWIND                 = 56408,    // DEAD KNIGHT

    // RIDER
    SPELL_BLOOD_PRESENCE            = 55212,    // LIVING RIDER
    SPELL_DEATH_COIL                = 55209,    // LIVING RIDER
    SPELL_HASTE_AURA                = 13589,    // LIVING RIDER
    SPELL_HYSTERIA                  = 55213,    // LIVING RIDER
    SPELL_INTIMIDATING_SHOUT        = 5246,     // LIVING RIDER
    SPELL_VEIL_OF_DARKNESS          = 28350,    // LIVING RIDER
    SPELL_DRAIN_LIFE                = 27994,    // DEAD RIDER
    SPELL_UNHOLY_AURA               = 55606,    // DEAD RIDER
    SPELL_UNHOLY_FRENZY             = 55648,    // DEAD RIDER

    // HORSE
    SPELL_STOMP                     = 27993     // DEAD HORSE
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

    ACTION_GATE_OPEN                = 1,
};

enum Events
{
    EVENT_SUMMON_ADDS               = 1,
    EVENT_SPELL_HARVEST_SOUL        = 2,
    EVENT_SPELL_SHADOW_BOLT         = 3,
    EVENT_TELEPORT                  = 4,
    EVENT_CHECK_HEALTH              = 5,
    EVENT_CHECK_PLAYERS             = 6,

    // TRAINEES
    EVENT_SPELL_DEATH_PLAGUE        = 7,
    EVENT_SPELL_ARCANE_EXPLOSION    = 8,

    // KNIGHT
    EVENT_SPELL_SHADOW_MARK         = 9,
    EVENT_SPELL_WHIRLWIND           = 10,

    // RIDER
    EVENT_SPELL_BLOOD_PRESENCE      = 11,
    EVENT_SPELL_DEATH_COIL          = 12,
    EVENT_SPELL_HASTE_AURA          = 13,
    EVENT_SPELL_HYSTERIA            = 14,
    EVENT_SPELL_INTIMIDATING_SHOUT  = 15,
    EVENT_SPELL_VEIL_OF_DARKNESS    = 16,
    EVENT_SPELL_DRAIN_LIFE          = 17,
    EVENT_SPELL_UNHOLY_AURA         = 18,
    EVENT_SPELL_UNHOLY_FRENZY       = 19,

    // HORSE
    EVENT_SPELL_STOMP               = 20,

    EVENT_INTRO_2                   = 21,
    EVENT_INTRO_3                   = 22,
    EVENT_INTRO_4                   = 23,
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
    {2714.4f, -3431.67f, 268.56f, 1.6f},
};

const Position PosSummonDead[5] =
{
    {2725.1f, -3310.0f, 268.85f, 3.4f},
    {2699.3f, -3322.8f, 268.60f, 3.3f},
    {2733.1f, -3348.5f, 268.84f, 3.1f},
    {2682.8f, -3304.2f, 268.85f, 3.9f},
    {2664.8f, -3340.7f, 268.23f, 3.7f},
};

const Position PosGroundLivingSide = {2691.2f, -3387.0f, 267.68f, 1.52f};
const Position PosGroundDeadSide   = {2693.5f, -3334.6f, 267.68f, 4.67f};
const Position PosPlatform         = {2640.5f, -3360.6f, 285.26f, 0.0f};

#define POS_Y_GATE  -3360.78f
#define POS_Y_WEST  -3285.0f
#define POS_Y_EAST  -3434.0f
#define POS_X_NORTH  2750.49f
#define POS_X_SOUTH  2633.84f
#define IN_LIVE_SIDE(who) (who->GetPositionY() < POS_Y_GATE)

// Predicate function to check that the r   efzr unit is NOT on the same side as the source.
struct NotOnSameSide : public acore::unary_function<Unit *, bool>
{
    bool m_inLiveSide;
    explicit NotOnSameSide(Unit *pSource) : m_inLiveSide(IN_LIVE_SIDE(pSource)) {}
    
    bool operator() (const Unit *pTarget)
    {
        return (m_inLiveSide != IN_LIVE_SIDE(pTarget));
    }
};

class boss_gothik : public CreatureScript
{
public:
    boss_gothik() : CreatureScript("boss_gothik") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_gothikAI (pCreature);
    }

    struct boss_gothikAI : public BossAI
    {
        explicit boss_gothikAI(Creature *c) : BossAI(c, BOSS_GOTHIK), summons(me)
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
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_PASSIVE);
            secondPhase = false;
            gateOpened = false;
            waveCount = 0;

            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_ENTER_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_INNER_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_EXIT_GATE)))
                    go->SetGoState(GO_STATE_READY);
            }
        }

        void EnterCombat(Unit * who) override
        {
            BossAI::EnterCombat(who);
            me->SetInCombatWithZone();
            Talk(SAY_INTRO_1);
            events.ScheduleEvent(EVENT_INTRO_2, 4000);
            events.ScheduleEvent(EVENT_INTRO_3, 9000);
            events.ScheduleEvent(EVENT_INTRO_4, 14000);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_DISABLE_MOVE);
            me->NearTeleportTo(PosPlatform.GetPositionX(), PosPlatform.GetPositionY(), PosPlatform.GetPositionZ(), PosPlatform.GetOrientation());
            
            events.ScheduleEvent(EVENT_SUMMON_ADDS, 30000);
            events.ScheduleEvent(EVENT_CHECK_PLAYERS, 120000);
            
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_ENTER_GATE)))
                    go->SetGoState(GO_STATE_READY);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_INNER_GATE)))
                    go->SetGoState(GO_STATE_READY);
            }
        }

        void JustSummoned(Creature *summon) override
        {
            if (gateOpened)
                summon->AI()->DoAction(ACTION_GATE_OPEN);
                
            summons.Summon(summon);
            summon->SetInCombatWithZone();
        }

        void SummonedCreatureDespawn(Creature* cr) override { summons.Despawn(cr); }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_KILL);

            if (pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
            summons.DespawnAll();

            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_ENTER_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_INNER_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_EXIT_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
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
                        me->SummonCreature(NPC_LIVING_TRAINEE, PosSummonLiving[2].GetPositionX(), PosSummonLiving[2].GetPositionY(), PosSummonLiving[2].GetPositionZ(), PosSummonLiving[2].GetOrientation());
                    break;
                case NPC_LIVING_KNIGHT:
                    me->SummonCreature(NPC_LIVING_KNIGHT, PosSummonLiving[3].GetPositionX(), PosSummonLiving[3].GetPositionY(), PosSummonLiving[3].GetPositionZ(), PosSummonLiving[3].GetOrientation());
                    if (Is25ManRaid())
                        me->SummonCreature(NPC_LIVING_KNIGHT, PosSummonLiving[5].GetPositionX(), PosSummonLiving[5].GetPositionY(), PosSummonLiving[5].GetPositionZ(), PosSummonLiving[5].GetOrientation());
                    break;
                case NPC_LIVING_RIDER:
                    me->SummonCreature(NPC_LIVING_RIDER, PosSummonLiving[4].GetPositionX(), PosSummonLiving[4].GetPositionY(), PosSummonLiving[4].GetPositionZ(), PosSummonLiving[4].GetOrientation());
                    break;
            }
        }

        bool CheckGroupSplitted()
        {
            Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
            if (!PlayerList.isEmpty())
            {
                bool checklife = false;
                bool checkdead = false;
                for (const auto & i : PlayerList)
                {
                    Player* player = i.GetSource();
                    if (player->IsAlive() &&
                        player->GetPositionX() <= POS_X_NORTH &&
                        player->GetPositionX() >= POS_X_SOUTH &&
                        player->GetPositionY() <= POS_Y_GATE &&
                        player->GetPositionY() >= POS_Y_EAST)
                        checklife = true;
                    else if (player->IsAlive() &&
                        player->GetPositionX() <= POS_X_NORTH &&
                        player->GetPositionX() >= POS_X_SOUTH &&
                        player->GetPositionY() >= POS_Y_GATE &&
                        player->GetPositionY() <= POS_Y_WEST)
                        checkdead = true;

                    if (checklife && checkdead)
                        return true;
                }
            }
            return false;
        }

        void SpellHit(Unit * /*caster*/, const SpellInfo* spellInfo) override
        {
            uint8 pos = urand(0,4);
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

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!secondPhase)
                damage = 0;
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

            switch (events.GetEvent())
            {
                case EVENT_INTRO_2:
                    Talk(SAY_INTRO_2);
                    events.PopEvent();
                    break;
                case EVENT_INTRO_3:
                    Talk(SAY_INTRO_3);
                    events.PopEvent();
                    break;
                case EVENT_INTRO_4:
                    Talk(SAY_INTRO_4);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_SHADOW_BOLT_10, SPELL_SHADOW_BOLT_25), false);
                    events.RepeatEvent(2000);
                    break;
                case EVENT_SPELL_HARVEST_SOUL:
                    me->CastSpell(me, SPELL_HARVEST_SOUL, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_TELEPORT:
                    me->AttackStop();
                    if (IN_LIVE_SIDE(me))
                        me->NearTeleportTo(PosGroundDeadSide.GetPositionX(), PosGroundDeadSide.GetPositionY(), PosGroundDeadSide.GetPositionZ(), PosGroundDeadSide.GetOrientation());
                    else
                        me->NearTeleportTo(PosGroundLivingSide.GetPositionX(), PosGroundLivingSide.GetPositionY(), PosGroundLivingSide.GetPositionZ(), PosGroundLivingSide.GetOrientation());

                    me->getThreatManager().resetAggro(NotOnSameSide(me));
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_NEAREST, 0))
                    {
                        me->getThreatManager().addThreat(pTarget, 100.0f);
                        AttackStart(pTarget);
                    }
                    events.RepeatEvent(20000);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(30) && pInstance)
                    {
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_INNER_GATE)))
                            go->SetGoState(GO_STATE_ACTIVE);

                        events.CancelEvent(EVENT_TELEPORT);
                        events.PopEvent();
                        break;
                    }
                    events.RepeatEvent(1000);
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
                        me->NearTeleportTo(PosGroundLivingSide.GetPositionX(), PosGroundLivingSide.GetPositionY(), PosGroundLivingSide.GetPositionZ(), PosGroundLivingSide.GetOrientation());
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_DISABLE_MOVE);
                        
                        summons.DoAction(ACTION_GATE_OPEN);
                        summons.DoZoneInCombat();
                        events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 1000);
                        events.ScheduleEvent(EVENT_SPELL_HARVEST_SOUL, urand(5000,15000));
                        events.ScheduleEvent(EVENT_TELEPORT, 20000);
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        events.PopEvent();
                    }

                    waveCount++;
                    break;
                case EVENT_CHECK_PLAYERS:
                    if (!CheckGroupSplitted())
                    {
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GOTHIK_INNER_GATE)))
                            go->SetGoState(GO_STATE_ACTIVE);

                        summons.DoAction(ACTION_GATE_OPEN);
                        summons.DoZoneInCombat();
                        gateOpened = true;
                        Talk(EMOTE_GATE_OPENED);
                    }
                    events.PopEvent();
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
        return new npc_boss_gothik_minionAI (pCreature);
    }

    struct npc_boss_gothik_minionAI : public CombatAI
    {
        explicit npc_boss_gothik_minionAI(Creature *c) : CombatAI(c)
        {
            livingSide = IN_LIVE_SIDE(me);
            gateOpened = false;
        }

        EventMap events;
        bool livingSide;
        bool gateOpened;

        bool IsOnSameSide(Unit const* who) const { return livingSide == IN_LIVE_SIDE(who); }
        bool CanAIAttack(Unit const* target) const override { return gateOpened || IsOnSameSide(target); }

        void Reset() override { events.Reset(); }
        void EnterCombat(Unit*  /*who*/) override
        {
            me->SetInCombatWithZone();

            switch (me->GetEntry())
            {
                case NPC_LIVING_TRAINEE:
                    events.ScheduleEvent(EVENT_SPELL_DEATH_PLAGUE, 2000);
                    break;
                case NPC_DEAD_TRAINEE:
                    events.ScheduleEvent(EVENT_SPELL_ARCANE_EXPLOSION, 2000);
                    break;
                case NPC_LIVING_KNIGHT:
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_MARK, 2000);
                    break;
                case NPC_DEAD_KNIGHT:
                    events.ScheduleEvent(EVENT_SPELL_WHIRLWIND, 2000);
                    break;
                case NPC_LIVING_RIDER:
                    events.ScheduleEvent(EVENT_SPELL_BLOOD_PRESENCE, 1);
                    events.ScheduleEvent(EVENT_SPELL_DEATH_COIL, 3000);
                    events.ScheduleEvent(EVENT_SPELL_HYSTERIA, 10000);
                    events.ScheduleEvent(EVENT_SPELL_HASTE_AURA, 1000);
                    events.ScheduleEvent(EVENT_SPELL_INTIMIDATING_SHOUT, urand(4000, 9000));
                    events.ScheduleEvent(EVENT_SPELL_VEIL_OF_DARKNESS, urand(5000,7000));
                    break;
                case NPC_DEAD_RIDER:
                    events.ScheduleEvent(EVENT_SPELL_DRAIN_LIFE, urand(2000, 3500));
                    events.ScheduleEvent(EVENT_SPELL_UNHOLY_AURA, 1);
                    events.ScheduleEvent(EVENT_SPELL_UNHOLY_FRENZY, urand(5000, 9000));
                    break;
                case NPC_DEAD_HORSE:
                    events.ScheduleEvent(EVENT_SPELL_STOMP, urand(2000, 5000));
                    break;
            }
        }
        void DamageTaken(Unit* attacker, uint32 &damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!attacker || (!gateOpened && !IsOnSameSide(attacker)))
                damage = 0;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_GATE_OPEN)
                gateOpened = true;
        }

        void JustDied(Unit *) override
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
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (me->GetUnitState() == UNIT_STATE_CASTING)
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_DEATH_PLAGUE:
                    me->CastSpell(me->GetVictim(), SPELL_DEATH_PLAGUE, false);
                    events.RepeatEvent(urand(15000,20000));
                    break;
                case EVENT_SPELL_ARCANE_EXPLOSION:
                    if (Unit* victim = me->GetVictim())
                        if (victim->IsWithinDist(me, 20))
                            me->CastSpell(victim, SPELL_ARCANE_EXPLOSION, false);
                    events.RepeatEvent(urand(5000, 10000));
                    break;
                case EVENT_SPELL_SHADOW_MARK:
                    if (Unit* victim = me->GetVictim())
                        if (!victim->HasAura(SPELL_SHADOW_MARK))
                            me->CastSpell(me->GetVictim(), SPELL_SHADOW_MARK, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                case EVENT_SPELL_WHIRLWIND:
                    if (Unit* victim = me->GetVictim())
                        if (victim->IsWithinDist(me, 10))
                            me->CastSpell(victim, SPELL_WHIRLWIND, false);
                    events.RepeatEvent(urand(5000, 8000));
                    break;
                case EVENT_SPELL_BLOOD_PRESENCE:
                    if (!me->HasAura(SPELL_BLOOD_PRESENCE))
                        me->CastSpell(me, SPELL_BLOOD_PRESENCE, false);
                    break;
                case EVENT_SPELL_HASTE_AURA:
                    if (!me->HasAura(SPELL_HASTE_AURA))
                        me->CastSpell(me, SPELL_HASTE_AURA, false);
                    break;
                case EVENT_SPELL_DEATH_COIL:
                    me->CastSpell(me->GetVictim(), SPELL_DEATH_COIL, false);
                    events.RepeatEvent(urand(5000, 9000));
                    break;
                case EVENT_SPELL_HYSTERIA:
                    if (!me->HasAura(SPELL_HYSTERIA))
                        me->CastSpell(me, SPELL_HYSTERIA, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                case EVENT_SPELL_INTIMIDATING_SHOUT:
                    if (Unit* victim = me->GetVictim())
                        if (victim->IsWithinDist(me, 10))
                            me->CastSpell(victim, SPELL_INTIMIDATING_SHOUT, false);
                    events.RepeatEvent(urand(14000, 22000));
                    break;
                case EVENT_SPELL_VEIL_OF_DARKNESS:
                    me->CastSpell(me->GetVictim(), SPELL_VEIL_OF_DARKNESS, false);
                    events.RepeatEvent(urand(13000, 19000));
                    break;
                case EVENT_SPELL_DRAIN_LIFE:
                    me->CastSpell(me->GetVictim(), SPELL_DRAIN_LIFE, false);
                    events.RepeatEvent(urand(6000, 15000));
                    break;
                case EVENT_SPELL_UNHOLY_AURA:
                    if (!me->HasAura(SPELL_UNHOLY_AURA))
                        me->CastSpell(me, SPELL_UNHOLY_AURA, false);
                    events.RepeatEvent(urand(2000, 5000));
                    break;
                case EVENT_SPELL_UNHOLY_FRENZY:
                    if (!me->HasAura(SPELL_UNHOLY_FRENZY))
                        me->CastSpell(me, SPELL_UNHOLY_FRENZY, false);
                    events.RepeatEvent(urand(2000, 5000));
                    break;
                case NPC_DEAD_HORSE:
                    me->CastSpell(me->GetVictim(), SPELL_STOMP, false);
                    events.RepeatEvent(urand(4000, 9000));
                    break;
                default:
                    break;
            }

			DoMeleeAttackIfReady();
        }
    };

};

class spell_gothik_shadow_bolt_volley : public SpellScriptLoader
{
    public:
        spell_gothik_shadow_bolt_volley() : SpellScriptLoader("spell_gothik_shadow_bolt_volley") { }

        class spell_gothik_shadow_bolt_volley_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_gothik_shadow_bolt_volley_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::UnitAuraCheck(false, SPELL_SHADOW_MARK));
            }

            void Register() override
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gothik_shadow_bolt_volley_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_gothik_shadow_bolt_volley_SpellScript();
        }
};

void AddSC_boss_gothik()
{
    new boss_gothik();
    new npc_boss_gothik_minion();
    new spell_gothik_shadow_bolt_volley();
}
