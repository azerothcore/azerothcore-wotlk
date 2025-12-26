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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

enum AssemblySpells
{
    // Any boss
    SPELL_SUPERCHARGE               = 61920,
    SPELL_BERSERK                   = 47008,

    // Steelbreaker
    SPELL_HIGH_VOLTAGE              = 61890,
    SPELL_FUSION_PUNCH              = 61903,
    SPELL_STATIC_DISRUPTION         = 61911,
    SPELL_OVERWHELMING_POWER        = 64637,
    SPELL_ELECTRICAL_CHARGE         = 61902,

    // Runemaster Molgeim
    SPELL_SHIELD_OF_RUNES_BUFF      = 62277,
    SPELL_SHIELD_OF_RUNES           = 62274,
    SPELL_RUNE_OF_POWER             = 61973,
    SPELL_RUNE_OF_DEATH             = 62269,
    SPELL_RUNE_OF_SUMMONING         = 62273,
    SPELL_RUNE_OF_SUMMONING_SUMMON  = 62020,
    SPELL_LIGHTNING_BLAST           = 62054,
    CREATURE_LIGHTNING_ELEMENTAL    = 32958,
    CREATURE_RUNE_OF_SUMMONING      = 33051,
    SPELL_RUNE_OF_POWER_OOC_CHANNEL = 61975,

    // Stormcaller Brundir
    SPELL_CHAIN_LIGHTNING           = 61879,
    SPELL_OVERLOAD                  = 61869,
    SPELL_LIGHTNING_WHIRL           = 61915,
    SPELL_LIGHTNING_WHIRL_TRIGG     = 61916,
    SPELL_LIGHTNING_TENDRILS        = 61887,
    SPELL_LIGHTNING_TENDRILS_2      = 61883,
    SPELL_STORMSHIELD               = 64187,
    SPELL_LIGHTNING_CHANNEL_PRE     = 61942,

};

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
    EVENT_LIGHTNING_FLIGHT      = 27,

    EVENT_ENRAGE                = 30
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
        ObjectGuid guid = pInstance->GetGuidData(DATA_STEELBREAKER + i);
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
        ObjectGuid guid = pInstance->GetGuidData(DATA_STEELBREAKER + i);
        if (!guid)
            return;

        if (Creature* boss = (ObjectAccessor::GetCreature((*me), guid)))
            if (!boss->IsAlive())
                boss->Respawn();
    }
    return;
}

void RestoreAssemblyHealth(ObjectGuid guid1, ObjectGuid guid2, Creature* me)
{
    if (Creature* cr = ObjectAccessor::GetCreature(*me, guid1))
        if (cr->IsAlive())
            cr->SetHealth(cr->GetMaxHealth());

    if (Creature* cr2 = ObjectAccessor::GetCreature(*me, guid2))
        if (cr2->IsAlive())
            cr2->SetHealth(cr2->GetMaxHealth());
}

class boss_steelbreaker : public CreatureScript
{
public:
    boss_steelbreaker() : CreatureScript("boss_steelbreaker") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_steelbreakerAI>(pCreature);
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

        void JustEngagedWith(Unit* who) override
        {
            if (pInstance)
                pInstance->SetData(TYPE_ASSEMBLY, IN_PROGRESS);

            me->setActive(true);
            me->SetInCombatWithZone();
            me->CastSpell(me, SPELL_HIGH_VOLTAGE, true);
            events.ScheduleEvent(EVENT_ENRAGE, 15min);
            UpdatePhase();

            if (!pInstance)
                return;

            if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_STEELBREAKER + urand(0, 2))))
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
                if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_STEELBREAKER + i)))
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
                    events.RescheduleEvent(EVENT_FUSION_PUNCH, 15s);
                    break;
                case 2:
                    events.RescheduleEvent(EVENT_STATIC_DISRUPTION, 20s);
                    break;
                case 3:
                    me->ResetLootMode();
                    events.RescheduleEvent(EVENT_OVERWHELMING_POWER, 8s);
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
                RestoreAssemblyHealth(pInstance->GetGuidData(DATA_BRUNDIR), pInstance->GetGuidData(DATA_MOLGEIM), me);
                me->CastSpell(me, SPELL_SUPERCHARGE, true);
                Talk(SAY_STEELBREAKER_DEATH);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (!who->IsPlayer())
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

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
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

            switch (events.ExecuteEvent())
            {
                case EVENT_FUSION_PUNCH:
                    me->CastSpell(me->GetVictim(), SPELL_FUSION_PUNCH, false);
                    events.Repeat(15s, 20s);
                    break;
                case EVENT_STATIC_DISRUPTION:
                    if (Unit* pTarget = SelectTarget(SelectTargetMethod::MinDistance, 0, 0, true))
                        me->CastSpell(pTarget, SPELL_STATIC_DISRUPTION, false);

                    events.Repeat(20s, 40s);
                    break;
                case EVENT_OVERWHELMING_POWER:
                    Talk(SAY_STEELBREAKER_POWER);
                    me->CastSpell(me->GetVictim(), SPELL_OVERWHELMING_POWER, true);
                    events.Repeat(RAID_MODE(61s, 36s));
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
        return GetUlduarAI<boss_runemaster_molgeimAI>(pCreature);
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

            me->m_Events.AddEventAtOffset(new CastRunesEvent(*me), 8s);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
            me->RemoveAllAuras();
        }

        void JustEngagedWith(Unit* who) override
        {
            me->InterruptNonMeleeSpells(false);
            me->setActive(true);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_ENRAGE, 15min);
            UpdatePhase();

            if (!pInstance)
                return;

            for (uint8 i = 0; i < 3; ++i)
                if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_STEELBREAKER + i)))
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
                    events.RescheduleEvent(EVENT_SHIELD_OF_RUNES, 20s);
                    events.RescheduleEvent(EVENT_RUNE_OF_POWER, 30s);
                    break;
                case 2:
                    events.RescheduleEvent(EVENT_RUNE_OF_DEATH, 35s);
                    break;
                case 3:
                    me->ResetLootMode();
                    events.RescheduleEvent(EVENT_RUNE_OF_SUMMONING, 20s, 30s);
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
                RestoreAssemblyHealth(pInstance->GetGuidData(DATA_STEELBREAKER), pInstance->GetGuidData(DATA_BRUNDIR), me);
                me->CastSpell(me, SPELL_SUPERCHARGE, true);
                Talk(SAY_MOLGEIM_DEATH);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (!who->IsPlayer())
                return;

            Talk(SAY_MOLGEIM_SLAY);
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
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

            switch (events.ExecuteEvent())
            {
                case EVENT_RUNE_OF_POWER:
                    {
                        Unit* target = DoSelectLowestHpFriendly(60);
                        if (!target || !target->IsAlive())
                            target = me;

                        me->CastSpell(target, SPELL_RUNE_OF_POWER, true);
                        events.Repeat(1min);
                        break;
                    }
                case EVENT_SHIELD_OF_RUNES:
                    me->CastSpell(me, SPELL_SHIELD_OF_RUNES, false);
                    events.RescheduleEvent(EVENT_SHIELD_OF_RUNES, 27s, 34s);
                    break;
                case EVENT_RUNE_OF_DEATH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                        me->CastSpell(target, SPELL_RUNE_OF_DEATH, true);

                    Talk(SAY_MOLGEIM_RUNE_DEATH);
                    events.Repeat(30s, 40s);
                    break;
                case EVENT_RUNE_OF_SUMMONING:
                    Talk(SAY_MOLGEIM_SUMMON);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_RUNE_OF_SUMMONING);
                    events.Repeat(30s, 45s);
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
        return GetUlduarAI<npc_assembly_lightningAI>(pCreature);
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
        void EnterEvadeMode(EvadeReason /* why */) override {}
        void OnCharmed(bool /*apply*/) override {}

        bool _boomed;

        void Reset() override
        {
            if (Player* target = SelectTargetFromPlayerList(150))
                me->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f);
            else
                me->DespawnOrUnsummon(1ms);
        }

        void MovementInform(uint32 type, uint32  /*id*/) override
        {
            if (type == FOLLOW_MOTION_TYPE && !_boomed)
            {
                _boomed = true;
                me->CastSpell(me, SPELL_LIGHTNING_BLAST, true);
                me->DespawnOrUnsummon(1s);
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
        return GetUlduarAI<boss_stormcaller_brundirAI>(pCreature);
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
        ObjectGuid _flyTargetGUID;
        uint32 _channelTimer;

        bool _stunnedAchievement;

        void Reset() override
        {
            me->SetLootMode(0);
            RespawnAssemblyOfIron(pInstance, me);

            _channelTimer = 0;
            _phase = 0;
            _flyTargetGUID.Clear();
            _stunnedAchievement = true;

            events.Reset();

            me->SetDisableGravity(false);
            me->SetRegeneratingHealth(true);
            me->SetReactState(REACT_AGGRESSIVE);
            if (pInstance)
                pInstance->SetData(TYPE_ASSEMBLY, NOT_STARTED);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
            me->RemoveAllAuras();
        }

        void JustEngagedWith(Unit* who) override
        {
            me->InterruptNonMeleeSpells(false);
            me->setActive(true);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_ENRAGE, 15min);
            UpdatePhase();

            if (!pInstance)
                return;

            for (uint8 i = 0; i < 3; ++i)
                if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_STEELBREAKER + i)))
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
                    events.RescheduleEvent(EVENT_CHAIN_LIGHTNING, 9s, 17s);
                    events.RescheduleEvent(EVENT_OVERLOAD, 25s, 40s);
                    break;
                case 2:
                    events.RescheduleEvent(EVENT_LIGHTNING_WHIRL, 20s, 40s);
                    break;
                case 3:
                    me->ResetLootMode();
                    me->CastSpell(me, SPELL_STORMSHIELD, true);
                    events.RescheduleEvent(EVENT_LIGHTNING_TENDRILS, 15s, 16s);
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
                RestoreAssemblyHealth(pInstance->GetGuidData(DATA_STEELBREAKER), pInstance->GetGuidData(DATA_MOLGEIM), me);
                me->CastSpell(me, SPELL_SUPERCHARGE, true);
                Talk(SAY_BRUNDIR_DEATH);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (!who->IsPlayer() || urand(0, 2))
                return;

            Talk(SAY_BRUNDIR_SLAY);
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SUPERCHARGE)
                UpdatePhase();
        }

        void SpellHitTarget(Unit*  /*target*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == sSpellMgr->GetSpellIdForDifficulty(SPELL_CHAIN_LIGHTNING, me)  || spellInfo->Id == sSpellMgr->GetSpellIdForDifficulty(SPELL_LIGHTNING_WHIRL_TRIGG, me))
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
                    me->GetMotionMaster()->MovePoint(POINT_CHANNEL_STEELBREAKER, 1587.18f + 10.0f * cos(o), 121.02f + 10.0f * std::sin(o), 427.3f);
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_CHAIN_LIGHTNING:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);

                    events.Repeat(9s, 17s);
                    break;
                case EVENT_OVERLOAD:
                    Talk(EMOTE_BRUNDIR_OVERLOAD);
                    me->CastSpell(me, SPELL_OVERLOAD, true);
                    events.RescheduleEvent(EVENT_OVERLOAD, 25s, 40s);
                    break;
                case EVENT_LIGHTNING_WHIRL:
                    Talk(SAY_BRUNDIR_SPECIAL);
                    me->CastSpell(me, SPELL_LIGHTNING_WHIRL, true);
                    events.Repeat(10s, 25s);
                    break;
                case EVENT_LIGHTNING_TENDRILS:
                    {
                        // Reschedule old
                        events.Repeat(35s);
                        events.DelayEvents(18s);
                        Talk(SAY_BRUNDIR_FLIGHT);

                        Unit* oldVictim = me->GetVictim();
                        _flyTargetGUID = oldVictim->GetGUID();
                        me->SetRegeneratingHealth(false);
                        me->SetDisableGravity(true);
                        me->SetHover(true);

                        me->CombatStop();
                        me->StopMoving();
                        me->SetReactState(REACT_PASSIVE);
                        me->SetGuidValue(UNIT_FIELD_TARGET, ObjectGuid::Empty);
                        me->SetUnitFlag(UNIT_FLAG_STUNNED);

                        me->CastSpell(me, SPELL_LIGHTNING_TENDRILS, true);
                        me->CastSpell(me, SPELL_LIGHTNING_TENDRILS_2, true);
                        events.ScheduleEvent(EVENT_LIGHTNING_LAND, 16s);
                        events.ScheduleEvent(EVENT_LIGHTNING_FLIGHT, 1s);
                        break;
                    }
                case EVENT_LIGHTNING_LAND:
                    {
                        float speed = me->GetDistance(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()) / (1000.0f * 0.001f);
                        me->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, speed);
                        events.ScheduleEvent(EVENT_LAND_LAND, 1s);
                        break;
                    }
                case EVENT_LAND_LAND:
                    me->SetCanFly(false);
                    me->SetHover(false);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetDisableGravity(false);
                    if (Unit* flyTarget = ObjectAccessor::GetUnit(*me, _flyTargetGUID))
                    {
                        me->Attack(flyTarget, false);
                    }

                    me->SetRegeneratingHealth(true);
                    _flyTargetGUID.Clear();
                    me->RemoveAura(sSpellMgr->GetSpellIdForDifficulty(SPELL_LIGHTNING_TENDRILS, me));
                    me->RemoveAura(SPELL_LIGHTNING_TENDRILS_2);
                    DoResetThreatList();
                    events.CancelEvent(EVENT_LIGHTNING_FLIGHT);
                    break;
                case EVENT_ENRAGE:
                    Talk(SAY_BRUNDIR_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_LIGHTNING_FLIGHT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        me->GetMotionMaster()->MovePoint(0, *target);
                    }
                    events.ScheduleEvent(EVENT_LIGHTNING_FLIGHT, 6s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_shield_of_runes_aura : public AuraScript
{
    PrepareAuraScript(spell_shield_of_runes_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHIELD_OF_RUNES_BUFF });
    }

    void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* owner = GetUnitOwner())
            if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_ENEMY_SPELL && aurEff->GetAmount() <= 0)
                owner->CastSpell(owner, SPELL_SHIELD_OF_RUNES_BUFF, false);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_shield_of_runes_aura::OnRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_assembly_meltdown : public SpellScript
{
    PrepareSpellScript(spell_assembly_meltdown);

    void HandleInstaKill(SpellEffIndex /*effIndex*/)
    {
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
            if (Creature* Steelbreaker = ObjectAccessor::GetCreature(*GetCaster(), instance->GetGuidData(DATA_STEELBREAKER)))
                Steelbreaker->AI()->DoAction(ACTION_ADD_CHARGE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_assembly_meltdown::HandleInstaKill, EFFECT_1, SPELL_EFFECT_INSTAKILL);
    }
};

class spell_assembly_rune_of_summoning_aura : public AuraScript
{
    PrepareAuraScript(spell_assembly_rune_of_summoning_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RUNE_OF_SUMMONING_SUMMON });
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (aurEff->GetTickNumber() % 2 == 0)
            GetTarget()->CastSpell(GetTarget(), SPELL_RUNE_OF_SUMMONING_SUMMON, true, nullptr, aurEff, GetTarget()->IsSummon() ? GetTarget()->ToTempSummon()->GetSummonerGUID() : ObjectGuid::Empty);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (TempSummon* summ = GetTarget()->ToTempSummon())
            summ->DespawnOrUnsummon(1ms);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_assembly_rune_of_summoning_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectRemove += AuraEffectRemoveFn(spell_assembly_rune_of_summoning_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class achievement_assembly_of_iron : public AchievementCriteriaScript
{
public:
    achievement_assembly_of_iron(char const* name, uint32 entry) : AchievementCriteriaScript(name),
        _targetEntry(entry)
    {
    }

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
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

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        bool allow = target && target->GetAuraCount(SPELL_SUPERCHARGE) >= 2;
        if (!allow)
            return false;

        if (InstanceScript* instance = target->GetInstanceScript())
            if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetGuidData(DATA_BRUNDIR)))
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

    RegisterSpellScript(spell_shield_of_runes_aura);
    RegisterSpellScript(spell_assembly_meltdown);
    RegisterSpellScript(spell_assembly_rune_of_summoning_aura);

    new achievement_assembly_of_iron("achievement_but_im_on_your_side", 0);
    new achievement_assembly_of_iron("achievement_assembly_steelbreaker", NPC_STEELBREAKER);
    new achievement_assembly_of_iron("achievement_assembly_runemaster", NPC_MOLGEIM);
    new achievement_assembly_of_iron("achievement_assembly_stormcaller", NPC_BRUNDIR);
    new achievement_cant_do_that_while_stunned();
}
