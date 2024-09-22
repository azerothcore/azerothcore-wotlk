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
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellInfo.h"
#include "trial_of_the_champion.h"

enum Spells
{
    SPELL_RAISE_DEAD_JAEREN         = 67715,
    SPELL_RAISE_DEAD_ARELAS         = 67705,
    SPELL_BK_FEIGN_DEATH            = 67691,
    SPELL_BLACK_KNIGHT_RES          = 67693,
    SPELL_BK_KILL_CREDIT            = 68663,

    // phase 1
    SPELL_PLAGUE_STRIKE_N           = 67724,
    SPELL_PLAGUE_STRIKE_H           = 67884,
    SPELL_ICY_TOUCH_N               = 67718,
    SPELL_ICY_TOUCH_H               = 67881,
    SPELL_DEATH_RESPITE_N           = 67745,
    SPELL_DEATH_RESPITE_H           = 68306,
    SPELL_DEATH_RESPITE_DUMMY       = 66798,
    SPELL_OBLITERATE_N              = 67725,
    SPELL_OBLITERATE_H              = 67883,

    // phase 2 (+ abilities from phase 1 without death respite)
    SPELL_ARMY_DEAD_N               = 67761,
    SPELL_ARMY_DEAD_H               = 67874,
    SPELL_DESECRATION_N             = 67778,
    SPELL_DESECRATION_H             = 67877,
    SPELL_DESECRATION_SUMMON        = 67779,
    SPELL_BK_GHOUL_EXPLODE          = 67751,

    // phase 3
    SPELL_DEATH_BITE_N              = 67808,
    SPELL_DEATH_BITE_H              = 67875,
    SPELL_MARKED_DEATH_N            = 67823,
    SPELL_MARKED_DEATH_H            = 67882,

    // ghouls
    SPELL_CLAW_N                    = 67774,
    SPELL_CLAW_H                    = 67879,
    SPELL_EXPLODE_N                 = 67729,
    SPELL_EXPLODE_H                 = 67886,
    SPELL_LEAP_N                    = 67749,
    SPELL_LEAP_H                    = 67880,
};
#define SPELL_LEAP                  DUNGEON_MODE(SPELL_LEAP_N, SPELL_LEAP_H)
#define SPELL_EXPLODE               DUNGEON_MODE(SPELL_EXPLODE_N, SPELL_EXPLODE_H)

#define SPELL_PLAGUE_STRIKE         DUNGEON_MODE(SPELL_PLAGUE_STRIKE_N, SPELL_PLAGUE_STRIKE_H)
#define SPELL_ICY_TOUCH             DUNGEON_MODE(SPELL_ICY_TOUCH_N, SPELL_ICY_TOUCH_H)
#define SPELL_DEATH_RESPITE         DUNGEON_MODE(SPELL_DEATH_RESPITE_N, SPELL_DEATH_RESPITE_H)
#define SPELL_OBLITERATE            DUNGEON_MODE(SPELL_OBLITERATE_N, SPELL_OBLITERATE_H)
#define SPELL_ARMY_DEAD             DUNGEON_MODE(SPELL_ARMY_DEAD_N, SPELL_ARMY_DEAD_H)
#define SPELL_DESECRATION           DUNGEON_MODE(SPELL_DESECRATION_N, SPELL_DESECRATION_H)
#define SPELL_DEATH_BITE            DUNGEON_MODE(SPELL_DEATH_BITE_N, SPELL_DEATH_BITE_H)
#define SPELL_MARKED_DEATH          DUNGEON_MODE(SPELL_MARKED_DEATH_N, SPELL_MARKED_DEATH_H)

enum Events
{
    EVENT_ANNOUNCER_SAY_ZOMBIE = 1,
    EVENT_SPELL_PLAGUE_STRIKE,
    EVENT_SPELL_ICY_TOUCH,
    EVENT_SPELL_DEATH_RESPITE,
    EVENT_SPELL_OBLITERATE,
    EVENT_SPELL_DESECRATION,
    EVENT_SPELL_DEATH_BITE,
    EVENT_SPELL_MARKED_DEATH,
};

enum NPCs
{
    NPC_RISEN_CHAMPION              = 35590,
};

enum Models
{
    MODEL_SKELETON                  = 29846,
    MODEL_GHOST                     = 21300
};

class boss_black_knight : public CreatureScript
{
public:
    boss_black_knight() : CreatureScript("boss_black_knight") { }

    struct boss_black_knightAI : public ScriptedAI
    {
        boss_black_knightAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint8 Phase;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            Phase = 1;
            me->SetDisplayId(me->GetNativeDisplayId());
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToAll(true);
            me->SetReactState(REACT_PASSIVE);
            if (pInstance)
                pInstance->SetData(BOSS_BLACK_KNIGHT, NOT_STARTED);

            //me->SetLootMode(0); // [LOOT]
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->DespawnOrUnsummon(1);
            ScriptedAI::EnterEvadeMode(why);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
            {
                damage = 0;
                return;
            }

            if (Phase < 3 && damage >= me->GetHealth())
            {
                damage = 0;
                me->SetHealth(me->GetMaxHealth());
                events.Reset();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveAllAuras();
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->CastSpell(me, SPELL_BK_GHOUL_EXPLODE, true);
                summons.clear();

                me->CastSpell(me, SPELL_BK_FEIGN_DEATH, true);
                me->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
                me->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
                me->AddUnitState(UNIT_STATE_DIED);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == -1)
            {
                summons.DespawnAll();
            }
            else if (param == 1)
            {
                if (!pInstance)
                    return;

                pInstance->SetData(BOSS_BLACK_KNIGHT, IN_PROGRESS);
                Talk(SAY_BK_AGGRO);
                me->CastSpell((Unit*)nullptr, (pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SPELL_RAISE_DEAD_JAEREN : SPELL_RAISE_DEAD_ARELAS), false);
                if (Creature* announcer = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_ANNOUNCER)))
                    announcer->DespawnOrUnsummon();

                events.Reset();
                events.ScheduleEvent(EVENT_ANNOUNCER_SAY_ZOMBIE, 2500ms);
                events.ScheduleEvent(EVENT_SPELL_PLAGUE_STRIKE, 7s, 9s);
                events.ScheduleEvent(EVENT_SPELL_ICY_TOUCH, 3500ms, 7000ms);
                events.ScheduleEvent(EVENT_SPELL_DEATH_RESPITE, 13s, 15s);
                events.ScheduleEvent(EVENT_SPELL_OBLITERATE, 11s, 19s);
            }
        }

        void SpellHitTarget(Unit*  /*target*/, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_BLACK_KNIGHT_RES:
                    me->SetHealth(me->GetMaxHealth());
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetImmuneToAll(false);
                    me->SetControlled(false, UNIT_STATE_STUNNED);

                    me->RemoveUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
                    me->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
                    me->ClearUnitState(UNIT_STATE_DIED);

                    ++Phase;

                    switch (Phase)
                    {
                        case 2:
                            me->SetDisplayId(MODEL_SKELETON);
                            Talk(SAY_BK_PHASE_2);
                            me->CastSpell(me, SPELL_ARMY_DEAD, false);

                            events.Reset();
                            events.ScheduleEvent(EVENT_SPELL_PLAGUE_STRIKE, 7s, 9s);
                            events.ScheduleEvent(EVENT_SPELL_ICY_TOUCH, 3500ms, 7000ms);
                            events.ScheduleEvent(EVENT_SPELL_OBLITERATE, 11s, 19s);
                            events.ScheduleEvent(EVENT_SPELL_DESECRATION, 2s, 3s);
                            break;
                        case 3:
                            me->SetDisplayId(MODEL_GHOST);
                            Talk(SAY_BK_PHASE_3);

                            events.Reset();
                            events.ScheduleEvent(EVENT_SPELL_DEATH_BITE, 2s);
                            events.ScheduleEvent(EVENT_SPELL_MARKED_DEATH, 1s);
                            break;
                        default:
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            break;
                    }
                    break;
            }
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
                case EVENT_ANNOUNCER_SAY_ZOMBIE:
                    if (pInstance && !summons.empty())
                        if (Creature* ghoul = pInstance->instance->GetCreature(*summons.begin()))
                            if (urand(0, 1))
                                ghoul->Yell("[Zombie] .... . Brains ....", LANG_UNIVERSAL); /// @todo: Multiple variations + not always happening, from video sources, needs sniff to transition from DB.
                    break;
                case EVENT_SPELL_PLAGUE_STRIKE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_PLAGUE_STRIKE, false);
                    events.Repeat(10s, 12s);
                    break;
                case EVENT_SPELL_ICY_TOUCH:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_ICY_TOUCH, false);
                    events.Repeat(5s, 6s);
                    break;
                case EVENT_SPELL_DEATH_RESPITE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_DEATH_RESPITE, false);
                    events.Repeat(13s, 15s);
                    break;
                case EVENT_SPELL_OBLITERATE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_OBLITERATE, false);
                    events.Repeat(15s, 17s);
                    break;
                case EVENT_SPELL_DESECRATION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_DESECRATION, false);
                    events.Repeat(14s, 17s);
                    break;
                case EVENT_SPELL_DEATH_BITE:
                    me->CastSpell((Unit*)nullptr, SPELL_DEATH_BITE, false);
                    events.Repeat(2s, 4s);
                    break;
                case EVENT_SPELL_MARKED_DEATH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.000000f, true))
                        me->CastSpell(target, SPELL_MARKED_DEATH, false);
                    events.Repeat(9s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (Unit* target = summon->SelectNearestTarget(200.0f))
            {
                summon->AI()->AttackStart(target);
                DoZoneInCombat(summon);
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
            {
                Talk(SAY_BK_KILL_PLAYER);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->CastSpell((Unit*)nullptr, SPELL_BK_KILL_CREDIT, true);
            Talk(SAY_BK_DEATH);
            if (pInstance)
                pInstance->SetData(BOSS_BLACK_KNIGHT, DONE);
            if (me->ToTempSummon())
                me->ToTempSummon()->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheChampionAI<boss_black_knightAI>(pCreature);
    }
};

class npc_black_knight_skeletal_gryphon : public CreatureScript
{
public:
    npc_black_knight_skeletal_gryphon() : CreatureScript("npc_black_knight_skeletal_gryphon") {}

    struct npc_black_knight_skeletal_gryphonAI : public npc_escortAI
    {
        npc_black_knight_skeletal_gryphonAI(Creature* pCreature) : npc_escortAI(pCreature) {}

        void Reset() override
        {
            Start(false, true, ObjectGuid::Empty, nullptr);
            SetDespawnAtEnd(true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToAll(true);
        }

        void DoAction(int32 param) override
        {
            if (param == 1)
            {
                me->SetControlled(false, UNIT_STATE_ROOT);
                me->DisableRotate(false);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                SetEscortPaused(false);
            }
        }

        void WaypointReached(uint32 i) override
        {
            if (i == 12)
            {
                SetEscortPaused(true);
                me->SetOrientation(3.62f);
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->DisableRotate(true);
                me->SetFacingTo(3.62f);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_MOUNT_SPECIAL);
                if (InstanceScript* pInstance = me->GetInstanceScript())
                    pInstance->SetData(DATA_SKELETAL_GRYPHON_LANDED, 0);
            }
        }

        void UpdateAI(uint32 uiDiff) override
        {
            npc_escortAI::UpdateAI(uiDiff);
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheChampionAI<npc_black_knight_skeletal_gryphonAI>(pCreature);
    }
};

class npc_black_knight_ghoul : public CreatureScript
{
public:
    npc_black_knight_ghoul() : CreatureScript("npc_black_knight_ghoul") { }

    struct npc_black_knight_ghoulAI : public ScriptedAI
    {
        npc_black_knight_ghoulAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            events.Reset();
            if (me->GetEntry() == NPC_RISEN_JAEREN || me->GetEntry() == NPC_RISEN_ARELAS)
                events.RescheduleEvent(1, 1s); // leap
            events.RescheduleEvent(2, 3s, 4s); // claw
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_BK_GHOUL_EXPLODE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_STUNNED);
                me->CastSpell(me, SPELL_EXPLODE, false);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_CLAW_N:
                case SPELL_CLAW_H:
                    DoResetThreatList();
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
                    {
                        me->AddThreat(target, 100.0f);
                        AttackStart(target);
                    }
                    break;
                case SPELL_EXPLODE_H:
                    if (target && target->IsPlayer())
                        if (pInstance)
                            pInstance->SetData(DATA_ACHIEV_IVE_HAD_WORSE, 0);
                    break;
            }
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
                case 1: // leap
                    if (Unit* target = me->GetVictim())
                        if (me->GetDistance(target) > 5.0f && me->GetDistance(target) < 30.0f)
                        {
                            me->CastSpell(target, SPELL_LEAP, false);

                            break;
                        }
                    events.Repeat(1s);
                    break;
                case 2: // claw
                    if (Unit* target = me->GetVictim())
                        me->CastSpell(target, SPELL_CLAW_N, false);
                    events.Repeat(6s, 8s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheChampionAI<npc_black_knight_ghoulAI>(pCreature);
    }
};

void AddSC_boss_black_knight()
{
    new boss_black_knight();
    new npc_black_knight_skeletal_gryphon();
    new npc_black_knight_ghoul();
}
