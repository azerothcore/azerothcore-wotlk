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
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "TaskScheduler.h"
#include "karazhan.h"

/***********************************/
/*** OPERA WIZARD OF OZ EVENT *****/
/*********************************/
enum Says
{
    SAY_DOROTHEE_DEATH          = 0,
    SAY_DOROTHEE_SUMMON         = 1,
    SAY_DOROTHEE_TITO_DEATH     = 2,
    SAY_DOROTHEE_AGGRO          = 3,

    SAY_ROAR_AGGRO              = 0,
    SAY_ROAR_DEATH              = 1,
    SAY_ROAR_SLAY               = 2,

    SAY_STRAWMAN_AGGRO          = 0,
    SAY_STRAWMAN_DEATH          = 1,
    SAY_STRAWMAN_SLAY           = 2,

    SAY_TINHEAD_AGGRO           = 0,
    SAY_TINHEAD_DEATH           = 1,
    SAY_TINHEAD_SLAY            = 2,
    EMOTE_RUST                  = 3,

    SAY_CRONE_AGGRO             = 0,
    SAY_CRONE_DEATH             = 1,
    SAY_CRONE_SLAY              = 2,
};

enum Spells
{
    // Dorothee
    SPELL_WATERBOLT         = 31012,
    SPELL_SCREAM            = 31013,
    SPELL_SUMMONTITO        = 31014,

    // Tito
    SPELL_YIPPING           = 31015,

    // Strawman
    SPELL_BRAIN_BASH        = 31046,
    SPELL_BRAIN_WIPE        = 31069,
    SPELL_BURNING_STRAW     = 31075,

    // Tinhead
    SPELL_CLEAVE            = 31043,
    SPELL_RUST              = 31086,

    // Roar
    SPELL_MANGLE            = 31041,
    SPELL_SHRED             = 31042,
    SPELL_FRIGHTENED_SCREAM = 31013,

    // Crone
    SPELL_CHAIN_LIGHTNING   = 32337,

    // Cyclone
    SPELL_KNOCKBACK         = 32334,
    SPELL_CYCLONE_VISUAL    = 32332,
};

enum Creatures
{
    CREATURE_TITO           = 17548,
    CREATURE_CYCLONE        = 18412,
    CREATURE_CRONE          = 18168,
};

enum OZActions
{
    ACTION_RELEASE          = 1,
};

void SummonCroneIfReady(InstanceScript* instance, Creature* creature)
{
    instance->SetData(DATA_OPERA_OZ_DEATHCOUNT, SPECIAL);  // Increment DeathCount

    if (instance->GetData(DATA_OPERA_OZ_DEATHCOUNT) == 4)
    {
        if (Creature* pCrone = creature->SummonCreature(CREATURE_CRONE, -10891.96f, -1755.95f, creature->GetPositionZ(), 4.64f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, HOUR * 2 * IN_MILLISECONDS))
        {
            if (creature->GetVictim())
                pCrone->AI()->AttackStart(creature->GetVictim());
            pCrone->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            pCrone->SetImmuneToPC(false);
        }
    }
}

void DespawnAll(InstanceScript* instance)
{
    if (Creature* dorothee = instance->GetCreature(DATA_DOROTHEE))
    {
        dorothee->DespawnOrUnsummon();
    }
    if (Creature* roar = instance->GetCreature(DATA_ROAR))
    {
        roar->DespawnOrUnsummon();
    }
    if (Creature* strawman = instance->GetCreature(DATA_STRAWMAN))
    {
        strawman->DespawnOrUnsummon();
    }
    if (Creature* tinhead = instance->GetCreature(DATA_TINHEAD))
    {
        tinhead->DespawnOrUnsummon();
    }
    if (Creature* tito = instance->GetCreature(DATA_TITO))
    {
        tito->DespawnOrUnsummon();
    }
}

void DoActions(InstanceScript* instance)
{
    uint32 datas[4] = {DATA_DOROTHEE, DATA_ROAR, DATA_STRAWMAN, DATA_TINHEAD};

    for (uint32 data : datas)
    {
        if (Creature* actionCreature = instance->GetCreature(data))
        {
            actionCreature->AI()->DoAction(ACTION_RELEASE);
        }
    }
}

struct boss_dorothee : public ScriptedAI
{
    boss_dorothee(Creature* creature) : ScriptedAI(creature)
    {
        me->SetCombatMovement(false);
        //this is kinda a big no-no. but it will prevent her from moving to chase targets. she should just cast her spells. in this case, since there is not really something to LOS her with or get out of range this would work. but a more elegant solution would be better

        instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;
    bool titoDied;

    void DoAction(int32 action) override
    {
        if (action == ACTION_RELEASE)
        {
            _scheduler.Schedule(11700ms, [this](TaskContext)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToPC(false);
                me->SetInCombatWithZone();
            });
        }
    }

    void Reset() override
    {
        titoDied = false;
        _startIntro = false;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(1ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_WATERBOLT);
            context.Repeat(1500ms);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SCREAM);
            context.Repeat(30s);
        }).Schedule(41s, [this](TaskContext)
        {
            SummonTito();
        });
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
    }

    void SummonTito()
    {
        if (Creature* pTito = me->SummonCreature(CREATURE_TITO, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
        {
            Talk(SAY_DOROTHEE_SUMMON);
            pTito->AI()->AttackStart(me->GetVictim());
            pTito->SetInCombatWithZone();
            titoDied = false;
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DOROTHEE_DEATH);
        SummonCroneIfReady(instance, me);
        me->DespawnOrUnsummon();
    }

    void SummonedCreatureDies(Creature* creature, Unit* /*killer*/) override
    {
        if (creature->GetEntry() == NPC_TITO)
        {
            Talk(SAY_DOROTHEE_TITO_DEATH);
        }
    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
            DespawnAll(instance);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!_startIntro)
        {
            Talk(SAY_DOROTHEE_AGGRO);
        }

        if (!_startIntro)
        {
            DoActions(instance);
            _startIntro = true;
        }
        DoMeleeAttackIfReady();

        _scheduler.Update(diff);
    }
private:
    TaskScheduler _scheduler;
    bool _startIntro;
};

struct npc_tito : public ScriptedAI
{
    npc_tito(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(10s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_YIPPING);
            context.Repeat(10s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

struct boss_roar : public ScriptedAI
{
    boss_roar(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void DoAction(int32 action) override
    {
        if (action == ACTION_RELEASE)
        {
            _scheduler.Schedule(16670ms, [this](TaskContext)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToPC(false);
                me->SetInCombatWithZone();
            });
        }
    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
            DespawnAll(instance);
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_ROAR_AGGRO);

        _scheduler.Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_MANGLE);
            context.Repeat(5s, 8s);
        }).Schedule(10s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHRED);
            context.Repeat(10s, 15s);
        }).Schedule(15s, [this](TaskContext context)
        {
            //why is this also on roar??? same id
            DoCastSelf(SPELL_FRIGHTENED_SCREAM);
            context.Repeat(20s, 30s);
        });
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_ROAR_DEATH);
        SummonCroneIfReady(instance, me);
        me->DespawnOrUnsummon();
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_ROAR_SLAY);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

struct boss_strawman : public ScriptedAI
{
    boss_strawman(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void DoAction(int32 action) override
    {
        if (action == ACTION_RELEASE)
        {
            _scheduler.Schedule(26300ms, [this](TaskContext)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToPC(false);
                me->SetInCombatWithZone();
            });
        }
    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
            DespawnAll(instance);
        }
    }
    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_STRAWMAN_AGGRO);

        _scheduler.Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_BRAIN_BASH);
            context.Repeat(15s);
        }).Schedule(7s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_BRAIN_WIPE);
            context.Repeat(20s);
        });
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* Spell) override
    {
        if ((Spell->SchoolMask == SPELL_SCHOOL_MASK_FIRE) && roll_chance_i(10))
        {
            /*
                if (not direct damage(aoe, dot))
                    return;
            */

            DoCast(me, SPELL_BURNING_STRAW, true);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_STRAWMAN_DEATH);
        SummonCroneIfReady(instance, me);
        me->DespawnOrUnsummon();
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_STRAWMAN_SLAY);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

struct boss_tinhead : public ScriptedAI
{
    boss_tinhead(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void DoAction(int32 action) override
    {
        if (action == ACTION_RELEASE)
        {
            _scheduler.Schedule(34470ms, [this](TaskContext)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToPC(false);
                me->SetInCombatWithZone();
            });
        }
    }

    void Reset() override
    {
        _rustCount = 0;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_TINHEAD_AGGRO);

        _scheduler.Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(5s);
        }).Schedule(15s, [this](TaskContext context)
        {
            if (_rustCount < 8)
            {
                ++_rustCount;
                Talk(EMOTE_RUST);
                DoCastSelf(SPELL_RUST);
                context.Repeat(6s);
            }
        });
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
            DespawnAll(instance);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_TINHEAD_DEATH);
        SummonCroneIfReady(instance, me);
        me->DespawnOrUnsummon();
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_TINHEAD_SLAY);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
    uint8 _rustCount;
};

struct boss_crone : public ScriptedAI
{
    boss_crone(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;

    void Reset() override
    {
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_CRONE_SLAY);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_CRONE_AGGRO);
        DoZoneInCombat();

        _scheduler.Schedule(22s, [this](TaskContext context)
        {
            if (Creature* Cyclone = DoSpawnCreature(CREATURE_CYCLONE, float(urand(0, 9)), float(urand(0, 9)), 0, 0, TEMPSUMMON_TIMED_DESPAWN, 15000))
            Cyclone->CastSpell(Cyclone, SPELL_CYCLONE_VISUAL, true);
            context.Repeat(22s);
        }).Schedule(8s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CHAIN_LIGHTNING);
            context.Repeat(8s);
        });

    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_CRONE_DEATH);

        instance->SetBossState(DATA_OPERA_PERFORMANCE, DONE);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

struct npc_cyclone : public ScriptedAI
{
    npc_cyclone(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(1s, [this](TaskContext context)
        {
            Position pos = me->GetRandomNearPosition(10);
            me->GetMotionMaster()->MovePoint(0, pos);
            context.Repeat(3s, 5s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!me->HasAura(SPELL_KNOCKBACK))
            DoCast(me, SPELL_KNOCKBACK, true);

        _scheduler.Update(diff);
    }
private:
    TaskScheduler _scheduler;
};

/**************************************/
/**** Opera Red Riding Hood Event* ***/
/************************************/
enum RedRidingHood
{
    SAY_WOLF_AGGRO                  = 0,
    SAY_WOLF_SLAY                   = 1,
    SAY_WOLF_HOOD                   = 2,
    SOUND_WOLF_DEATH                = 9275,

    SPELL_LITTLE_RED_RIDING_HOOD    = 30768,
    SPELL_TERRIFYING_HOWL           = 30752,
    SPELL_WIDE_SWIPE                = 30761,
    SPELL_PICNIC_BASKET_SMELL       = 30755,

    CREATURE_BIG_BAD_WOLF           = 17521,

    GRANDMOTHER_GOSSIP_MENU1        = 7441,
    GRANDMOTHER_GOSSIP_MENU2        = 7442,
    GRANDMOTHER_GOSSIP_MENU3        = 7443,

    GRANDMOTHER_TEXT1               = 9009,
    GRANDMOTHER_TEXT2               = 9010,
    GRANDMOTHER_TEXT3               = 9011
};

struct npc_grandmother : public CreatureScript
{
    npc_grandmother() : CreatureScript("npc_grandmother") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                AddGossipItemFor(player, GRANDMOTHER_GOSSIP_MENU2, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, GRANDMOTHER_TEXT2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                AddGossipItemFor(player, GRANDMOTHER_GOSSIP_MENU3, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GRANDMOTHER_TEXT3, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                if (Creature* pBigBadWolf = creature->SummonCreature(CREATURE_BIG_BAD_WOLF, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, HOUR * 2 * IN_MILLISECONDS))
                {
                    pBigBadWolf->AI()->AttackStart(player);
                }
                creature->DespawnOrUnsummon();
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, GRANDMOTHER_GOSSIP_MENU1, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        SendGossipMenuFor(player, GRANDMOTHER_TEXT1, creature->GetGUID());

        return true;
    }
};

struct boss_bigbadwolf : public ScriptedAI
{
    boss_bigbadwolf(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void JustEngagedWith(Unit* /*who*/) override
    {
        instance->DoUseDoorOrButton(instance->GetGuidData(DATA_GO_STAGEDOORLEFT));
        Talk(SAY_WOLF_AGGRO);
        DoZoneInCombat();

        _scheduler.Schedule(30s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
            {
                Talk(SAY_WOLF_HOOD);
                DoCast(target, SPELL_LITTLE_RED_RIDING_HOOD, true);
                target->CastSpell(me, SPELL_PICNIC_BASKET_SMELL, true);
            }

            context.Repeat(40s);
        }).Schedule(25s, 35s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_TERRIFYING_HOWL);
            context.Repeat(25s, 35s);
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_WIDE_SWIPE);
            context.Repeat(25s, 30s);
        });
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_WOLF_SLAY);
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoPlaySoundToSet(me, SOUND_WOLF_DEATH);

        instance->SetBossState(DATA_OPERA_PERFORMANCE, DONE);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();

        _scheduler.Update(diff);
    }
private:
    TaskScheduler _scheduler;
};

/**********************************************/
/******** Opera Romeo and Juliet Event* ******/
/********************************************/

enum JulianneRomulo
{
    /**** Speech *****/
    SAY_JULIANNE_AGGRO              = 0,
    SAY_JULIANNE_ENTER              = 1,
    SAY_JULIANNE_DEATH01            = 2,
    SAY_JULIANNE_DEATH02            = 3,
    SAY_JULIANNE_RESURRECT          = 4,
    SAY_JULIANNE_SLAY               = 5,

    SAY_ROMULO_AGGRO                = 0,
    SAY_ROMULO_DEATH                = 1,
    SAY_ROMULO_DEATH2               = 2,
    SAY_ROMULO_RESURRECT            = 3,
    SAY_ROMULO_SLAY                 = 4,

    SPELL_BLINDING_PASSION          = 30890,
    SPELL_DEVOTION                  = 30887,
    SPELL_ETERNAL_AFFECTION         = 30878,
    SPELL_POWERFUL_ATTRACTION       = 30889,
    SPELL_DRINK_POISON              = 30907,

    SPELL_BACKWARD_LUNGE            = 30815,
    SPELL_DARING                    = 30841,
    SPELL_DEADLY_SWATHE             = 30817,
    SPELL_POISON_THRUST             = 30822,

    SPELL_UNDYING_LOVE              = 30951,
    SPELL_RES_VISUAL                = 24171,

    CREATURE_ROMULO                 = 17533,
    ROMULO_X                        = -10900,
    ROMULO_Y                        = -1758,
};

enum RAJPhase
{
    PHASE_JULIANNE      = 0,
    PHASE_ROMULO        = 1,
    PHASE_BOTH          = 2,
};

enum RAJGroups
{
    GROUP_COMBAT        = 0,
    GROUP_RP            = 1
};

enum RAJActions
{
    ACTION_FAKING_DEATH     = 2,
    ACTION_COMBAT_SCHEDULE  = 3,
    //ACTION_DO_RESURRECT     = 4,
    //ACTION_RESS_ROMULO      = 5,
    ACTION_CANCEL_COMBAT    = 6
};

void PretendToDie(Creature* creature)
{
    creature->AI()->DoAction(ACTION_CANCEL_COMBAT);
    creature->InterruptNonMeleeSpells(true);
    creature->RemoveAllAuras();
    creature->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
    creature->SetReactState(REACT_PASSIVE);
    creature->GetMotionMaster()->MovementExpired(false);
    creature->GetMotionMaster()->MoveIdle();
    creature->SetStandState(UNIT_STAND_STATE_DEAD);
}

void Resurrect(Creature* target)
{
    target->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
    target->SetReactState(REACT_AGGRESSIVE);
    target->SetFullHealth();
    target->SetStandState(UNIT_STAND_STATE_STAND);
    target->CastSpell(target, SPELL_RES_VISUAL, true);
    target->AI()->DoAction(ACTION_COMBAT_SCHEDULE);
    if (target->GetVictim())
    {
        target->GetMotionMaster()->MoveChase(target->GetVictim());
        target->AI()->AttackStart(target->GetVictim());
    }
    else
        target->GetMotionMaster()->Initialize();
}

struct boss_julianne : public ScriptedAI
{
    boss_julianne(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
        isFakingDeath = false;
    }

    void Reset() override
    {
        phase = PHASE_JULIANNE;

        if (isFakingDeath)
        {
            Resurrect(me);
            isFakingDeath = false;
        }

        summonedRomulo = false;
        me->SetImmuneToPC(true);

        _scheduler.Schedule(1s, [this](TaskContext)
        {
            Talk(SAY_JULIANNE_ENTER);
        }).Schedule(10s, [this](TaskContext)
        {
            Talk(SAY_JULIANNE_AGGRO);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToPC(false);
            me->SetInCombatWithZone();
        });
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
            case ACTION_FAKING_DEATH:
                isFakingDeath = false;
                break;
            case ACTION_COMBAT_SCHEDULE:
                ScheduleCombat();
                break;
            case ACTION_RESS_ROMULO:
                me->m_Events.AddEventAtOffset([this]
                {
                    if (Creature* romulo = instance->GetCreature(DATA_ROMULO))
                    {
                        Talk(SAY_JULIANNE_RESURRECT);
                        Resurrect(romulo);
                        romulo->AI()->DoAction(ACTION_FAKING_DEATH);
                        romulo->AI()->Talk(SAY_ROMULO_RESURRECT);
                    }
                }, 1s);
                break;
            case ACTION_DO_RESURRECT:
                phase = PHASE_BOTH;
                isFakingDeath = false;
                Resurrect(me);
                me->ResumeChasingVictim();
                break;
            case ACTION_CANCEL_COMBAT:
                _scheduler.CancelGroup(GROUP_COMBAT);
                break;
        }
    }

    void ScheduleCombat()
    {
        _scheduler.Schedule(30s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_BLINDING_PASSION);
            context.Repeat(30s, 45s);
        }).Schedule(15s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastSelf(SPELL_DEVOTION);
            context.Repeat(15s, 45s);
        }).Schedule(5s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_POWERFUL_ATTRACTION);
            context.Repeat(5s, 30s);
        }).Schedule(25s, GROUP_COMBAT, [this](TaskContext context)
        {
            if (urand(0, 1) && summonedRomulo)
            {
                if (Creature* romulo = instance->GetCreature(DATA_ROMULO))
                {
                    if (!romulo->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                    {
                        DoCast(romulo, SPELL_ETERNAL_AFFECTION);
                    }
                }
            }
            else
            {
                DoCast(me, SPELL_ETERNAL_AFFECTION);
            }
            context.Repeat(45s, 60s);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        ScheduleCombat();
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* Spell) override
    {
        if (Spell->Id == SPELL_DRINK_POISON)
        {
            Talk(SAY_JULIANNE_DEATH01);
            _scheduler.CancelGroup(GROUP_COMBAT);
            _scheduler.Schedule(2500ms, GROUP_RP, [this](TaskContext)
            {
                //will do this 2secs after spell hit. this is time to display visual as expected
                PretendToDie(me);
                phase = PHASE_ROMULO;
                _scheduler.Schedule(10s, GROUP_RP, [this](TaskContext)
                {
                    if (Creature* romulo = me->SummonCreature(CREATURE_ROMULO, ROMULO_X, ROMULO_Y, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, HOUR * 2 * IN_MILLISECONDS))
                    {
                        romulo->SetInCombatWithZone();
                    }
                    summonedRomulo = true;
                });
            });
        }
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage < me->GetHealth())
        {
            return;
        }

        damage = me->GetHealth() - 1;

        if (phase == PHASE_JULIANNE)
        {
            me->ClearTarget();

            if (isFakingDeath)
            {
                return;
            }

            me->InterruptNonMeleeSpells(true);
            DoCast(me, SPELL_DRINK_POISON);

            me->GetMotionMaster()->Clear();

            isFakingDeath = true;
            return;
        }

        if (phase == PHASE_BOTH && !isFakingDeath)
        {
            PretendToDie(me);
            isFakingDeath = true;
            instance->DoAction(ACTION_SCHEDULE_RAJ_CHECK);
        }
    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            me->DespawnOrUnsummon();
            instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
        }
    }

    void JustDied(Unit*) override
    {
        Talk(SAY_JULIANNE_DEATH02);

        instance->SetBossState(DATA_OPERA_PERFORMANCE, DONE);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim != me)
        {
            Talk(SAY_JULIANNE_SLAY);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (!UpdateVictim())
        {
            return;
        }

        if (!isFakingDeath)
        {
            DoMeleeAttackIfReady();
        }
    }
private:
    InstanceScript* instance;
    uint32 phase;
    bool isFakingDeath;
    bool summonedRomulo;
    TaskScheduler _scheduler;
};

struct boss_romulo : public ScriptedAI
{
    boss_romulo(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        phase = PHASE_ROMULO;
        isFakingDeath = false;
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
            case ACTION_FAKING_DEATH:
                isFakingDeath = false;
                break;
            case ACTION_COMBAT_SCHEDULE:
                ScheduleCombat();
                break;
            case ACTION_CANCEL_COMBAT:
                _scheduler.CancelGroup(GROUP_COMBAT);
                break;
        }
    }

    void JustReachedHome() override
    {
        me->DespawnOrUnsummon();
        if (Creature* julianne = instance->GetCreature(DATA_JULIANNE))
        {
            julianne->DespawnOrUnsummon();
        }
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage < me->GetHealth())
        {
            return;
        }

        damage = me->GetHealth() - 1;

        if (phase == PHASE_ROMULO)
        {
            Talk(SAY_ROMULO_DEATH);
            PretendToDie(me);
            isFakingDeath = true;
            phase = PHASE_BOTH;

            me->m_Events.AddEventAtOffset([this]
            {
                Resurrect(me);
                isFakingDeath = false;
                if (Creature* julliane = instance->GetCreature(DATA_JULIANNE))
                {
                    julliane->AI()->DoAction(ACTION_DO_RESURRECT);
                }
            }, 3s);
        }

        if (phase == PHASE_BOTH && !isFakingDeath)
        {
            Talk(SAY_ROMULO_DEATH2);
            PretendToDie(me);
            instance->DoAction(ACTION_SCHEDULE_RAJ_CHECK);
            isFakingDeath = true;
        }
    }

    void ScheduleCombat()
    {
        if (Creature* Julianne = instance->GetCreature(DATA_JULIANNE))
        {
            if (Julianne->GetVictim())
            {
                me->AddThreat(Julianne->GetVictim(), 1.0f);
                AttackStart(Julianne->GetVictim());
            }
        }

        _scheduler.Schedule(15s, GROUP_COMBAT, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true, false))
            {
                if (target && !me->HasInArc(M_PI, target))
                {
                    DoCast(target, SPELL_BACKWARD_LUNGE);
                    context.Repeat(15s, 30s);
                }
            }
        }).Schedule(20s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastSelf(SPELL_DARING);
            context.Repeat(20s, 40s);
        }).Schedule(25s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_DEADLY_SWATHE);
            context.Repeat(15s, 25s);
        }).Schedule(10s, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastVictim(SPELL_POISON_THRUST);
            context.Repeat(10s, 20s);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_ROMULO_AGGRO);

        ScheduleCombat();
    }

    void EnterEvadeMode(EvadeReason reason) override
    {
        ScriptedAI::EnterEvadeMode(reason);

        instance->SetBossState(DATA_OPERA_PERFORMANCE, FAIL);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_ROMULO_DEATH);

        instance->SetBossState(DATA_OPERA_PERFORMANCE, DONE);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim != me)
        {
            Talk(SAY_ROMULO_SLAY);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (!UpdateVictim())
        {
            return;
        }

        if (!isFakingDeath)
        {
            DoMeleeAttackIfReady();
        }
    }
private:
    InstanceScript* instance;
    uint32 phase;
    bool isFakingDeath;
    TaskScheduler _scheduler;
};

void AddSC_bosses_opera()
{
    RegisterKarazhanCreatureAI(boss_dorothee);
    RegisterKarazhanCreatureAI(boss_strawman);
    RegisterKarazhanCreatureAI(boss_tinhead);
    RegisterKarazhanCreatureAI(boss_roar);
    RegisterKarazhanCreatureAI(boss_crone);
    RegisterKarazhanCreatureAI(npc_tito);
    RegisterKarazhanCreatureAI(npc_cyclone);
    new npc_grandmother();
    RegisterKarazhanCreatureAI(boss_bigbadwolf);
    RegisterKarazhanCreatureAI(boss_julianne);
    RegisterKarazhanCreatureAI(boss_romulo);
}
