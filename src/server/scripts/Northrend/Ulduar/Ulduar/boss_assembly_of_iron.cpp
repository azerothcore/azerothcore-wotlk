/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "SpellAuraEffects.h"
#include "Player.h"

enum AssemblySpells
{
    // Any boss
    SPELL_SUPERCHARGE               = 61920,
    SPELL_BERSERK                   = 47008,

    // Steelbreaker
    SPELL_HIGH_VOLTAGE_10           = 61890,
    SPELL_HIGH_VOLTAGE_25           = 63498,
    SPELL_FUSION_PUNCH_10           = 61903,
    SPELL_FUSION_PUNCH_25           = 63493,
    SPELL_STATIC_DISRUPTION_10      = 61911,
    SPELL_STATIC_DISRUPTION_25      = 63495,
    SPELL_OVERWHELMING_POWER_10     = 64637,
    SPELL_OVERWHELMING_POWER_25     = 61888,
    SPELL_ELECTRICAL_CHARGE         = 61902,

    // Runemaster Molgeim
    SPELL_SHIELD_OF_RUNES_BUFF      = 62277,
    SPELL_SHIELD_OF_RUNES_10        = 62274,
    SPELL_SHIELD_OF_RUNES_25        = 63489,
    SPELL_RUNE_OF_POWER             = 61973,
    SPELL_RUNE_OF_DEATH_10          = 62269,
    SPELL_RUNE_OF_DEATH_25          = 63490,
    SPELL_RUNE_OF_SUMMONING         = 62273,
    SPELL_RUNE_OF_SUMMONING_SUMMON  = 62020,
    SPELL_LIGHTNING_BLAST_10        = 62054,
    SPELL_LIGHTNING_BLAST_25        = 63491,
    CREATURE_LIGHTNING_ELEMENTAL    = 32958,
    CREATURE_RUNE_OF_SUMMONING      = 33051,
    SPELL_RUNE_OF_POWER_OOC_CHANNEL = 61975,

    // Stormcaller Brundir
    SPELL_CHAIN_LIGHTNING_10        = 61879,
    SPELL_CHAIN_LIGHTNING_25        = 63479,
    SPELL_OVERLOAD_10               = 61869,
    SPELL_OVERLOAD_25               = 63481,
    SPELL_LIGHTNING_WHIRL_10        = 61915,
    SPELL_LIGHTNING_WHIRL_25        = 63483,
    SPELL_LIGHTNING_TENDRILS_10     = 61887,
    SPELL_LIGHTNING_TENDRILS_25     = 63486,
    SPELL_STORMSHIELD               = 64187,
    SPELL_LIGHTNING_CHANNEL_PRE     = 61942,
};

#define SPELL_HIGH_VOLTAGE          RAID_MODE(SPELL_HIGH_VOLTAGE_10, SPELL_HIGH_VOLTAGE_25)
#define SPELL_FUSION_PUNCH          RAID_MODE(SPELL_FUSION_PUNCH_10, SPELL_FUSION_PUNCH_25)
#define SPELL_STATIC_DISRUPTION     RAID_MODE(SPELL_STATIC_DISRUPTION_10, SPELL_STATIC_DISRUPTION_25)
#define SPELL_OVERWHELMING_POWER    RAID_MODE(SPELL_OVERWHELMING_POWER_10, SPELL_OVERWHELMING_POWER_25)
#define SPELL_SHIELD_OF_RUNES       RAID_MODE(SPELL_SHIELD_OF_RUNES_10, SPELL_SHIELD_OF_RUNES_25)
#define SPELL_RUNE_OF_DEATH         RAID_MODE(SPELL_RUNE_OF_DEATH_10, SPELL_RUNE_OF_DEATH_25)
#define SPELL_LIGHTNING_BLAST       RAID_MODE(SPELL_LIGHTNING_BLAST_10, SPELL_LIGHTNING_BLAST_25)
#define SPELL_CHAIN_LIGHTNING       RAID_MODE(SPELL_CHAIN_LIGHTNING_10, SPELL_CHAIN_LIGHTNING_25)
#define SPELL_OVERLOAD              RAID_MODE(SPELL_OVERLOAD_10, SPELL_OVERLOAD_25)
#define SPELL_LIGHTNING_WHIRL       RAID_MODE(SPELL_LIGHTNING_WHIRL_10, SPELL_LIGHTNING_WHIRL_25)
#define SPELL_LIGHTNING_TENDRILS    RAID_MODE(SPELL_LIGHTNING_TENDRILS_10, SPELL_LIGHTNING_TENDRILS_25)


enum eEnums
{
    // Steelbreaker
    EVENT_FUSION_PUNCH          = 1,
    EVENT_STATIC_DISRUPTION     = 2,
    EVENT_OVERWHELMING_POWER    = 3,
    //EVENT_CHECK_MAIN_TANK     = 4,

    // Molgeim
    EVENT_RUNE_OF_POWER         = 11,
    EVENT_SHIELD_OF_RUNES       = 12,
    EVENT_RUNE_OF_DEATH         = 13,
    EVENT_RUNE_OF_SUMMONING     = 14,
    EVENT_LIGHTNING_BLAST       = 15,

    // Brundir
    EVENT_CHAIN_LIGHTNING       = 21,
    EVENT_OVERLOAD              = 22,
    EVENT_LIGHTNING_WHIRL       = 23,
    EVENT_LIGHTNING_TENDRILS    = 24,
    EVENT_LIGHTNING_LAND        = 25,
    EVENT_LAND_LAND             = 26,
    EVENT_IMMUNE                = 27,

    EVENT_ENRAGE                = 30,
};

enum AssemblyYells
{
    SAY_STEELBREAKER_AGGRO                      = 0,
    SAY_STEELBREAKER_SLAY                       = 1,
    SAY_STEELBREAKER_POWER                      = 2,
    SAY_STEELBREAKER_DEATH                      = 3,
    SAY_STEELBREAKER_ENCOUNTER_DEFEATED         = 4,
    SAY_STEELBREAKER_BERSERK                    = 5,

    SAY_MOLGEIM_AGGRO                           = 0,
    SAY_MOLGEIM_SLAY                            = 1,
    SAY_MOLGEIM_RUNE_DEATH                      = 2,
    SAY_MOLGEIM_SUMMON                          = 3,
    SAY_MOLGEIM_DEATH                           = 4,
    SAY_MOLGEIM_ENCOUNTER_DEFEATED              = 5,
    SAY_MOLGEIM_BERSERK                         = 6,

    SAY_BRUNDIR_AGGRO                           = 0,
    SAY_BRUNDIR_SLAY                            = 1,
    SAY_BRUNDIR_SPECIAL                         = 2,
    SAY_BRUNDIR_FLIGHT                          = 3,
    SAY_BRUNDIR_DEATH                           = 4,
    SAY_BRUNDIR_ENCOUNTER_DEFEATED              = 5,
    SAY_BRUNDIR_BERSERK                         = 6,
    EMOTE_BRUNDIR_OVERLOAD                      = 7
};

enum Misc
{
    ACTION_ADD_CHARGE           = 1,
    POINT_CHANNEL_STEELBREAKER  = 1
};

bool IsEncounterComplete(InstanceScript* pInstance, Creature* me)
{
    if (!pInstance || !me)
        return false;

    for (uint8 i = 0; i < 3; ++i)
    {
        uint64 guid = pInstance->GetData64(DATA_STEELBREAKER + i);
        if (!guid)
            return false;

        if (Creature* boss = (ObjectAccessor::GetCreature(*me, guid)))
        {
            if (boss->IsAlive())
                return false;
            continue;
        }
        else
            return false;
    }
    return true;
}

void RespawnAssemblyOfIron(InstanceScript* pInstance, Creature* me)
{
    if (!pInstance || !me)
        return;

    for (uint8 i = 0; i < 3; ++i)
    {
        uint64 guid = pInstance->GetData64(DATA_STEELBREAKER + i);
        if (!guid)
            return;

        if (Creature* boss = (ObjectAccessor::GetCreature((*me), guid)))
            if (!boss->IsAlive())
                boss->Respawn();
    }
    return;
}

void RestoreAssemblyHealth(uint64 guid1, uint64 guid2, Creature* me)
{
    if(Creature* cr = ObjectAccessor::GetCreature(*me, guid1))
        if(cr->IsAlive())
            cr->SetHealth(cr->GetMaxHealth());

    if(Creature* cr2 = ObjectAccessor::GetCreature(*me, guid2))
        if(cr2->IsAlive())
            cr2->SetHealth(cr2->GetMaxHealth());

}

class boss_steelbreaker : public CreatureScript
{
public:
    boss_steelbreaker() : CreatureScript("boss_steelbreaker") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_steelbreakerAI (pCreature);
    }

    struct boss_steelbreakerAI : public ScriptedAI
    {
        boss_steelbreakerAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* pInstance;
        uint8 _phase;

        void Reset() override
        {
            me->SetLootMode(0);
            RespawnAssemblyOfIron(pInstance, me);

            _phase = 0;
            events.Reset();
            if (pInstance)
                pInstance->SetData(TYPE_ASSEMBLY, NOT_STARTED);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
            me->RemoveAllAuras();
        }

        void EnterCombat(Unit* who) override
        {
            if (pInstance)
                pInstance->SetData(TYPE_ASSEMBLY, IN_PROGRESS);

            me->setActive(true);
            me->SetInCombatWithZone();
            me->CastSpell(me, SPELL_HIGH_VOLTAGE, true);
            events.ScheduleEvent(EVENT_ENRAGE, 900000);
            UpdatePhase();

            if (!pInstance)
                return;

            if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_STEELBREAKER + urand(0, 2))))
            {
                switch (boss->GetEntry())
                {
                    case NPC_STEELBREAKER:
                        boss->AI()->Talk(SAY_STEELBREAKER_AGGRO);
                        break;
                    case NPC_MOLGEIM:
                        boss->AI()->Talk(SAY_MOLGEIM_AGGRO);
                        break;
                    case NPC_BRUNDIR:
                        boss->AI()->Talk(SAY_BRUNDIR_AGGRO);
                        break;
                }
            }

            for (uint8 i = 0; i < 3; ++i)
                if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_STEELBREAKER + i)))
                    if (!boss->IsInCombat())
                        boss->AI()->AttackStart(who);
        }

        void UpdatePhase()
        {
            if (_phase >= 3)
                return;

            ++_phase;

            switch (_phase)
            {
                case 1:
                    events.RescheduleEvent(EVENT_FUSION_PUNCH, 15000);
                    break;
                case 2:
                    events.RescheduleEvent(EVENT_STATIC_DISRUPTION, 20000);
                    break;
                case 3:
                    me->ResetLootMode();
                    events.RescheduleEvent(EVENT_OVERWHELMING_POWER, 8000);
                    break;
            }
        }

        void JustDied(Unit*  /*Killer*/) override
        {
            if (!pInstance)
                return;

            if (IsEncounterComplete(pInstance, me))
            {
                pInstance->SetData(TYPE_ASSEMBLY, DONE);
                me->CastSpell(me, 65195, true); // credit
                Talk(SAY_STEELBREAKER_ENCOUNTER_DEFEATED);
            }
            else
            {
                RestoreAssemblyHealth(pInstance->GetData64(DATA_BRUNDIR), pInstance->GetData64(DATA_MOLGEIM), me);
                me->CastSpell(me, SPELL_SUPERCHARGE, true);
                Talk(SAY_STEELBREAKER_DEATH);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (_phase == 3)
                me->CastSpell(me, SPELL_ELECTRICAL_CHARGE, true);

            Talk(SAY_STEELBREAKER_SLAY);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_ADD_CHARGE)
                me->CastSpell(me, SPELL_ELECTRICAL_CHARGE, true);
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SUPERCHARGE)
                UpdatePhase();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.ExecuteEvent())
            {
                case EVENT_FUSION_PUNCH:
                    me->CastSpell(me->GetVictim(), SPELL_FUSION_PUNCH, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                case EVENT_STATIC_DISRUPTION:
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_FARTHEST, 0, 0, true))
                        me->CastSpell(pTarget, SPELL_STATIC_DISRUPTION, false);

                    events.RepeatEvent(urand(20000, 40000));
                    break;
                case EVENT_OVERWHELMING_POWER:
                    Talk(SAY_STEELBREAKER_POWER);
                    me->CastSpell(me->GetVictim(), SPELL_OVERWHELMING_POWER, true);
                    events.RepeatEvent(RAID_MODE(61000, 36000));
                    break;
                case EVENT_ENRAGE:
                    Talk(SAY_STEELBREAKER_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class CastRunesEvent : public BasicEvent
{
public:
    CastRunesEvent(Creature& owner) : BasicEvent(), _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*diff*/) override
    {
        if (!_owner.IsInCombat())
            _owner.CastSpell(&_owner, SPELL_RUNE_OF_POWER_OOC_CHANNEL, true);
        return true;
    }

private:
    Creature& _owner;
};

class boss_runemaster_molgeim : public CreatureScript
{
public:
    boss_runemaster_molgeim() : CreatureScript("boss_runemaster_molgeim") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_runemaster_molgeimAI (pCreature);
    }

    struct boss_runemaster_molgeimAI : public ScriptedAI
    {
        boss_runemaster_molgeimAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList summons;
        EventMap events;
        uint8 _phase;

        void Reset() override
        {
            me->SetLootMode(0);
            RespawnAssemblyOfIron(pInstance, me);

            _phase = 0;
            events.Reset();
            summons.DespawnAll();

            if (pInstance)
                pInstance->SetData(TYPE_ASSEMBLY, NOT_STARTED);

            me->m_Events.AddEvent(new CastRunesEvent(*me), me->m_Events.CalculateTime(8000));
        }

        void JustReachedHome() override
        {
            me->setActive(false);
            me->RemoveAllAuras();
        }

        void EnterCombat(Unit* who) override
        {
            me->InterruptNonMeleeSpells(false);
            me->setActive(true);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_ENRAGE, 900000);
            UpdatePhase();

            if (!pInstance)
                return;

            for (uint8 i = 0; i < 3; ++i)
                if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_STEELBREAKER + i)))
                    if (!boss->IsInCombat())
                        boss->AI()->AttackStart(who);
        }

        void UpdatePhase()
        {
            if (_phase >= 3)
                return;

            ++_phase;

            switch (_phase)
            {
                case 1:
                    events.RescheduleEvent(EVENT_SHIELD_OF_RUNES, 20000);
                    events.RescheduleEvent(EVENT_RUNE_OF_POWER, 30000);
                    break;
                case 2:
                    events.RescheduleEvent(EVENT_RUNE_OF_DEATH, 35000);
                    break;
                case 3:
                    me->ResetLootMode();
                    events.RescheduleEvent(EVENT_RUNE_OF_SUMMONING, urand(20000, 30000));
                    break;
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (!pInstance)
                return;

            if (IsEncounterComplete(pInstance, me))
            {
                pInstance->SetData(TYPE_ASSEMBLY, DONE);
                me->CastSpell(me, 65195, true); // credit
                Talk(SAY_MOLGEIM_ENCOUNTER_DEFEATED);
            }
            else
            {
                RestoreAssemblyHealth(pInstance->GetData64(DATA_STEELBREAKER), pInstance->GetData64(DATA_BRUNDIR), me);
                me->CastSpell(me, SPELL_SUPERCHARGE, true);
                Talk(SAY_MOLGEIM_DEATH);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_MOLGEIM_SLAY);
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SUPERCHARGE)
                UpdatePhase();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.ExecuteEvent())
            {
                case EVENT_RUNE_OF_POWER:
                    {
                        Unit* target = DoSelectLowestHpFriendly(60);
                        if (!target || !target->IsAlive())
                            target = me;

                        me->CastSpell(target, SPELL_RUNE_OF_POWER, true);
                        events.RepeatEvent(60000);
                        break;
                    }
                case EVENT_SHIELD_OF_RUNES:
                    me->CastSpell(me, SPELL_SHIELD_OF_RUNES, false);
                    events.RescheduleEvent(EVENT_SHIELD_OF_RUNES, urand(27000, 34000));
                    break;
                case EVENT_RUNE_OF_DEATH:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        me->CastSpell(target, SPELL_RUNE_OF_DEATH, true);

                    Talk(SAY_MOLGEIM_RUNE_DEATH);
                    events.RepeatEvent(urand(30000, 40000));
                    break;
                case EVENT_RUNE_OF_SUMMONING:
                    Talk(SAY_MOLGEIM_SUMMON);
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, SPELL_RUNE_OF_SUMMONING);
                    events.RepeatEvent(urand(30000, 45000));
                    break;
                case EVENT_ENRAGE:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    Talk(SAY_MOLGEIM_BERSERK);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_assembly_lightning : public CreatureScript
{
public:
    npc_assembly_lightning() : CreatureScript("npc_assembly_lightning") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_assembly_lightningAI (pCreature);
    }

    struct npc_assembly_lightningAI : public ScriptedAI
    {
        npc_assembly_lightningAI(Creature* c) : ScriptedAI(c)
        {
            _boomed = false;
        }

        void MoveInLineOfSight(Unit*) override {}
        void AttackStart(Unit*) override {}
        void UpdateAI(uint32) override {}
        void EnterEvadeMode() override {}
        void OnCharmed(bool /*apply*/) override {}

        bool _boomed;

        void Reset() override
        {
            if (Player* target = SelectTargetFromPlayerList(150))
                me->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f);
            else
                me->DespawnOrUnsummon(1);
        }

        void MovementInform(uint32 type, uint32  /*id*/) override
        {
            if (type == FOLLOW_MOTION_TYPE && !_boomed)
            {
                _boomed = true;
                me->CastSpell(me, SPELL_LIGHTNING_BLAST, true);
                me->DespawnOrUnsummon(1000);
            }
        }
    };
};

class boss_stormcaller_brundir : public CreatureScript
{
public:
    boss_stormcaller_brundir() : CreatureScript("boss_stormcaller_brundir") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_stormcaller_brundirAI (pCreature);
    }

    struct boss_stormcaller_brundirAI : public ScriptedAI
    {
        boss_stormcaller_brundirAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* pInstance;
        uint32 _phase;
        bool _flyPhase;
        Unit* _flyTarget;
        uint32 _channelTimer;

        bool _stunnedAchievement;

        void Reset() override
        {
            me->SetLootMode(0);
            RespawnAssemblyOfIron(pInstance, me);

            _channelTimer = 0;
            _phase = 0;
            _flyPhase = false;
            _flyTarget = nullptr;
            _stunnedAchievement = true;

            events.Reset();

            me->SetDisableGravity(false);
            me->SetRegeneratingHealth(true);
            me->SetReactState(REACT_AGGRESSIVE);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);

            if (pInstance)
                pInstance->SetData(TYPE_ASSEMBLY, NOT_STARTED);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
            me->RemoveAllAuras();
        }

        void EnterCombat(Unit* who) override
        {
            me->InterruptNonMeleeSpells(false);
            me->setActive(true);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_ENRAGE, 900000);
            UpdatePhase();

            if (!pInstance)
                return;

            for (uint8 i = 0; i < 3; ++i)
                if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_STEELBREAKER + i)))
                    if (!boss->IsInCombat())
                        boss->AI()->AttackStart(who);
        }

        void UpdatePhase()
        {
            if (_phase >= 3)
                return;

            ++_phase;

            switch (_phase)
            {
                case 1:
                    events.RescheduleEvent(EVENT_CHAIN_LIGHTNING, urand(9000, 17000));
                    events.RescheduleEvent(EVENT_OVERLOAD, urand(25000, 40000));
                    break;
                case 2:
                    events.RescheduleEvent(EVENT_LIGHTNING_WHIRL, urand(20000, 40000));
                    break;
                case 3:
                    me->ResetLootMode();
                    me->CastSpell(me, SPELL_STORMSHIELD, true);
                    events.RescheduleEvent(EVENT_LIGHTNING_TENDRILS, urand(15000, 16000));
                    break;
            }
        }

        void JustDied(Unit*  /*Killer*/) override
        {
            if (!pInstance)
                return;
            me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), 427.5, me->GetOrientation());
            if (IsEncounterComplete(pInstance, me))
            {
                pInstance->SetData(TYPE_ASSEMBLY, DONE);
                me->CastSpell(me, 65195, true); // credit
                Talk(SAY_BRUNDIR_ENCOUNTER_DEFEATED);
            }
            else
            {
                RestoreAssemblyHealth(pInstance->GetData64(DATA_STEELBREAKER), pInstance->GetData64(DATA_MOLGEIM), me);
                me->CastSpell(me, SPELL_SUPERCHARGE, true);
                Talk(SAY_BRUNDIR_DEATH);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER || urand(0, 2))
                return;

            Talk(SAY_BRUNDIR_SLAY);
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SUPERCHARGE)
                UpdatePhase();
        }

        void SpellHitTarget(Unit*  /*target*/, const SpellInfo* spellInfo) override
        {
            if (spellInfo->Id == SPELL_CHAIN_LIGHTNING || spellInfo->Id == uint32(RAID_MODE(61916, 63482))) // Lightning Whirl triggered
                _stunnedAchievement = false;
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_BRUNDIR)
                return _stunnedAchievement;

            return 0;
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type == POINT_MOTION_TYPE && point == POINT_CHANNEL_STEELBREAKER)
                me->CastSpell(me, SPELL_LIGHTNING_CHANNEL_PRE, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat() && me->GetReactState() == REACT_AGGRESSIVE)
            {
                _channelTimer += diff;
                if (_channelTimer >= 10000)
                {
                    _channelTimer = 0;
                    float o = urand(0, 5) * M_PI / 3.0f;
                    me->InterruptNonMeleeSpells(false);
                    me->GetMotionMaster()->MovePoint(POINT_CHANNEL_STEELBREAKER, 1587.18f + 10.0f * cos(o), 121.02f + 10.0f * sin(o), 427.3f);
                }
            }

            if (!UpdateVictim())
                return;

            if (_flyPhase)
            {
                if (_flyTarget && me->GetDistance2d(_flyTarget) >= 6 )
                {
                    //float speed = me->GetDistance(_flyTarget->GetPositionX(), _flyTarget->GetPositionY(), _flyTarget->GetPositionZ()+15) / (1500.0f * 0.001f);
                    me->SendMonsterMove(_flyTarget->GetPositionX(), _flyTarget->GetPositionY(), _flyTarget->GetPositionZ() + 15, 1500, SPLINEFLAG_FLYING);
                    me->SetPosition(_flyTarget->GetPositionX(), _flyTarget->GetPositionY(), _flyTarget->GetPositionZ(), _flyTarget->GetOrientation());
                }
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_CHAIN_LIGHTNING:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);

                    events.RepeatEvent(urand(9000, 17000));
                    break;
                case EVENT_IMMUNE:
                    me->ApplySpellImmune(1, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
                    break;
                case EVENT_OVERLOAD:
                    me->ApplySpellImmune(1, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                    Talk(EMOTE_BRUNDIR_OVERLOAD);
                    me->CastSpell(me, SPELL_OVERLOAD, true);
                    events.RescheduleEvent(EVENT_OVERLOAD, urand(25000, 40000));
                    events.RescheduleEvent(EVENT_IMMUNE, 5999);
                    break;
                case EVENT_LIGHTNING_WHIRL:
                    Talk(SAY_BRUNDIR_SPECIAL);
                    me->CastSpell(me, SPELL_LIGHTNING_WHIRL, true);
                    events.RepeatEvent(urand(10000, 25000));
                    break;
                case EVENT_LIGHTNING_TENDRILS:
                    {
                        // Reschedule old
                        events.RepeatEvent(35000);
                        events.DelayEvents(18000);
                        Talk(SAY_BRUNDIR_FLIGHT);

                        _flyPhase = true;
                        _flyTarget = me->GetVictim();
                        me->SetRegeneratingHealth(false);
                        me->SetDisableGravity(true);

                        me->CombatStop();
                        me->StopMoving();
                        me->SetReactState(REACT_PASSIVE);
                        me->SetUInt64Value(UNIT_FIELD_TARGET, 0);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
                        me->SendMonsterMove(_flyTarget->GetPositionX(), _flyTarget->GetPositionY(), _flyTarget->GetPositionZ() + 15, 1500, SPLINEFLAG_FLYING);

                        me->CastSpell(me, SPELL_LIGHTNING_TENDRILS, true);
                        me->CastSpell(me, 61883, true);
                        events.ScheduleEvent(EVENT_LIGHTNING_LAND, 16000);

                        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                        break;
                    }
                case EVENT_LIGHTNING_LAND:
                    {
                        float speed = me->GetDistance(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()) / (1000.0f * 0.001f);
                        me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), speed);
                        _flyPhase = false;
                        events.ScheduleEvent(EVENT_LAND_LAND, 1000);
                        break;
                    }
                case EVENT_LAND_LAND:
                    me->SetCanFly(false);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetDisableGravity(false);
                    if (_flyTarget)
                        me->Attack(_flyTarget, false);

                    me->SetRegeneratingHealth(true);
                    _flyTarget = nullptr;
                    me->RemoveAura(SPELL_LIGHTNING_TENDRILS);
                    me->RemoveAura(61883);
                    DoResetThreat();
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
                    break;
                case EVENT_ENRAGE:
                    Talk(SAY_BRUNDIR_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};


class spell_shield_of_runes : public SpellScriptLoader
{
public:
    spell_shield_of_runes() : SpellScriptLoader("spell_shield_of_runes") { }

    class spell_shield_of_runes_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_shield_of_runes_AuraScript);

        void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* owner = GetUnitOwner())
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_ENEMY_SPELL && aurEff->GetAmount() <= 0)
                    owner->CastSpell(owner, SPELL_SHIELD_OF_RUNES_BUFF, false);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_shield_of_runes_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_shield_of_runes_AuraScript();
    }
};

class spell_assembly_meltdown : public SpellScriptLoader
{
public:
    spell_assembly_meltdown() : SpellScriptLoader("spell_assembly_meltdown") { }

    class spell_assembly_meltdown_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_assembly_meltdown_SpellScript);

        void HandleInstaKill(SpellEffIndex /*effIndex*/)
        {
            if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                if (Creature* Steelbreaker = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(DATA_STEELBREAKER)))
                    Steelbreaker->AI()->DoAction(ACTION_ADD_CHARGE);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_assembly_meltdown_SpellScript::HandleInstaKill, EFFECT_1, SPELL_EFFECT_INSTAKILL);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_assembly_meltdown_SpellScript();
    }
};

class spell_assembly_rune_of_summoning : public SpellScriptLoader
{
public:
    spell_assembly_rune_of_summoning() : SpellScriptLoader("spell_assembly_rune_of_summoning") { }

    class spell_assembly_rune_of_summoning_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_assembly_rune_of_summoning_AuraScript);

        void OnPeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            if (aurEff->GetTickNumber() % 2 == 0)
                GetTarget()->CastSpell(GetTarget(), SPELL_RUNE_OF_SUMMONING_SUMMON, true, nullptr, aurEff, GetTarget()->IsSummon() ? GetTarget()->ToTempSummon()->GetSummonerGUID() : 0);
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (TempSummon* summ = GetTarget()->ToTempSummon())
                summ->DespawnOrUnsummon(1);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_assembly_rune_of_summoning_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            OnEffectRemove += AuraEffectRemoveFn(spell_assembly_rune_of_summoning_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_assembly_rune_of_summoning_AuraScript();
    }
};

class achievement_assembly_of_iron : public AchievementCriteriaScript
{
public:
    achievement_assembly_of_iron(char const* name, uint32 entry) : AchievementCriteriaScript(name),
        _targetEntry(entry)
    {
    }

    bool OnCheck(Player*  /*player*/, Unit* target) override
    {
        return target && target->GetAuraCount(SPELL_SUPERCHARGE) >= 2 && (!_targetEntry || target->GetEntry() == _targetEntry);
    }

private:
    uint32 const _targetEntry;
};

class achievement_cant_do_that_while_stunned : public AchievementCriteriaScript
{
public:
    achievement_cant_do_that_while_stunned() : AchievementCriteriaScript("achievement_cant_do_that_while_stunned") {}

    bool OnCheck(Player*  /*player*/, Unit* target) override
    {
        bool allow = target && target->GetAuraCount(SPELL_SUPERCHARGE) >= 2;
        if (!allow)
            return false;

        if (InstanceScript* instance = target->GetInstanceScript())
            if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(DATA_BRUNDIR)))
                return cr->AI()->GetData(DATA_BRUNDIR);

        return false;
    }
};

void AddSC_boss_assembly_of_iron()
{
    new boss_steelbreaker();
    new boss_runemaster_molgeim();
    new boss_stormcaller_brundir();
    new npc_assembly_lightning();

    new spell_shield_of_runes();
    new spell_assembly_meltdown();
    new spell_assembly_rune_of_summoning();

    new achievement_assembly_of_iron("achievement_but_im_on_your_side", 0);
    new achievement_assembly_of_iron("achievement_assembly_steelbreaker", NPC_STEELBREAKER);
    new achievement_assembly_of_iron("achievement_assembly_runemaster", NPC_MOLGEIM);
    new achievement_assembly_of_iron("achievement_assembly_stormcaller", NPC_BRUNDIR);
    new achievement_cant_do_that_while_stunned();
}
