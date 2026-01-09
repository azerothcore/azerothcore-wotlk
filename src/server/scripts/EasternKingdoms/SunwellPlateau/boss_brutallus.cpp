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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "MapReference.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldSession.h"
#include "sunwell_plateau.h"

enum Quotes
{
    YELL_INTRO                          = 0,
    YELL_INTRO_BREAK_ICE                = 1,
    YELL_INTRO_CHARGE                   = 2,
    YELL_INTRO_KILL_MADRIGOSA           = 3,
    YELL_INTRO_TAUNT                    = 4,

    YELL_AGGRO                          = 5,
    YELL_KILL                           = 6,
    YELL_LOVE                           = 7,
    YELL_BERSERK                        = 8,
    YELL_DEATH                          = 9,
};

enum Spells
{
    SPELL_METEOR_SLASH                  = 45150,
    SPELL_BURN_DAMAGE                   = 46394,
    SPELL_BURN                          = 45141,
    SPELL_STOMP                         = 45185,
    SPELL_BERSERK                       = 26662,
    SPELL_DUAL_WIELD                    = 42459,
    SPELL_SUMMON_BRUTALLUS_DEATH_CLOUD  = 45884
};

enum Misc
{
    EVENT_SPELL_SLASH                   = 1,
    EVENT_SPELL_STOMP                   = 2,
    EVENT_SPELL_BURN                    = 3,
    EVENT_SPELL_BERSERK                 = 4,

    ACTION_START_EVENT                  = 1,
    ACTION_SPAWN_FELMYST                = 2
};

struct boss_brutallus : public BossAI
{
    boss_brutallus(Creature* creature) : BossAI(creature, DATA_BRUTALLUS)
    {
        me->SetCorpseDelay(360);
    }

    void Reset() override
    {
        BossAI::Reset();
        DoCastSelf(SPELL_DUAL_WIELD, true);
        me->m_Events.KillAllEvents(false);
    }

    void JustEngagedWith(Unit* who) override
    {
        if (who->GetEntry() == NPC_MADRIGOSA)
            return;

        Talk(YELL_AGGRO);
        BossAI::JustEngagedWith(who);

        ScheduleEnrageTimer(SPELL_BERSERK, 6min, YELL_BERSERK);

        ScheduleTimedEvent(11s, [&] {
            DoCastVictim(SPELL_METEOR_SLASH);
        }, 12s);

        ScheduleTimedEvent(30s, [&] {
            DoCastVictim(SPELL_STOMP);
            Talk(YELL_LOVE);
        }, 30s);

        ScheduleTimedEvent(20s, [&] {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, true, -SPELL_BURN_DAMAGE))
                DoCast(target, SPELL_BURN);
        }, 20s);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && roll_chance_i(50))
            Talk(YELL_KILL);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(YELL_DEATH);

        DoCastAOE(SPELL_SUMMON_BRUTALLUS_DEATH_CLOUD, true);
        if (Creature* madrigosa = instance->GetCreature(DATA_MADRIGOSA))
            madrigosa->AI()->DoAction(ACTION_SPAWN_FELMYST);
    }

    void AttackStart(Unit* who) override
    {
        if (who->GetEntry() == NPC_MADRIGOSA)
            return;
        BossAI::AttackStart(who);
    }
};

enum eMadrigosa
{
    EVENT_MAD_1                     = 1,
    EVENT_MAD_2                     = 2,
    EVENT_MAD_2_1                   = 200,
    EVENT_MAD_3                     = 3,
    EVENT_MAD_4                     = 4,
    EVENT_MAD_5                     = 5,
    EVENT_MAD_6                     = 6,
    EVENT_MAD_7                     = 7,
    EVENT_MAD_8                     = 8,
    EVENT_MAD_8_1                   = 800,
    EVENT_MAD_9                     = 9,
    EVENT_MAD_10                    = 10,
    EVENT_MAD_11                    = 11,
    EVENT_MAD_12                    = 12,
    EVENT_MAD_13                    = 13,
    EVENT_MAD_14                    = 14,
    EVENT_MAD_15                    = 15,
    EVENT_MAD_16                    = 16,
    EVENT_MAD_17                    = 17,
    EVENT_MAD_18                    = 18,
    EVENT_MAD_19                    = 19,
    EVENT_MAD_20                    = 20,
    EVENT_MAD_21                    = 21,
    EVENT_SPAWN_FELMYST             = 30,

    SAY_MAD_1                       = 0,
    SAY_MAD_2                       = 1,
    SAY_MAD_3                       = 2,
    SAY_MAD_4                       = 3,
    SAY_MAD_5                       = 4,

    SPELL_MADRIGOSA_FREEZE          = 46609,
    SPELL_MADRIGOSA_FROST_BREATH    = 45065,
    SPELL_MADRIGOSA_FROST_BLAST     = 44872,
    SPELL_MADRIGOSA_FROSTBOLT       = 44843,
    SPELL_MADRIGOSA_ENCAPSULATE     = 44883,

    SPELL_BRUTALLUS_CHARGE          = 44884,
    SPELL_BRUTALLUS_FEL_FIREBALL    = 44844,
    SPELL_BRUTALLUS_FLAME_RING      = 44873,
    SPELL_BRUTALLUS_BREAK_ICE       = 46637,
};

struct npc_madrigosa : public NullCreatureAI
{
    npc_madrigosa(Creature* creature) : NullCreatureAI(creature)
    {
        instance = creature->GetInstanceScript();
        creature->SetStandState(UNIT_STAND_STATE_DEAD);
        creature->SetDynamicFlag(UNIT_DYNFLAG_DEAD);

        if (instance->IsBossDone(DATA_BRUTALLUS))
            creature->SetVisible(false);
    }

    EventMap events;
    InstanceScript* instance;

    void DoAction(int32 param) override
    {
        if (param == ACTION_START_EVENT)
        {
            me->NearTeleportTo(1570.97f, 725.51f, 79.77f, 3.82f);
            me->SetDisableGravity(true);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
            me->SendMovementFlagUpdate();

            events.ScheduleEvent(EVENT_MAD_1, 2s);
        }
        else if (param == ACTION_SPAWN_FELMYST)
            events.ScheduleEvent(EVENT_SPAWN_FELMYST, 60s);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (events.ExecuteEvent())
        {
        case EVENT_MAD_1:
            me->SetVisible(true);
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                me->SetTarget(brutallus->GetGUID());
                brutallus->SetReactState(REACT_PASSIVE);
                brutallus->setActive(true);
            }
            me->GetMotionMaster()->MoveTakeoff(1, 1477.94f, 643.22f, 21.21f);
            me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
            events.ScheduleEvent(EVENT_MAD_2, 4s);
            break;
        case EVENT_MAD_2:
            Talk(SAY_MAD_1);
            me->CastSpell(me, SPELL_MADRIGOSA_FREEZE, false);
            events.ScheduleEvent(EVENT_MAD_2_1, 1s);
            break;
        case EVENT_MAD_2_1:
            me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
            me->SetDisableGravity(false);
            me->CastSpell(me, SPELL_MADRIGOSA_FROST_BREATH, false);
            events.ScheduleEvent(EVENT_MAD_3, 7s);
            break;
        case EVENT_MAD_3:
            Talk(SAY_MAD_2);
            events.ScheduleEvent(EVENT_MAD_4, 7s);
            break;
        case EVENT_MAD_4:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
                brutallus->AI()->Talk(YELL_INTRO);
            events.ScheduleEvent(EVENT_MAD_5, 5s);
            break;
        case EVENT_MAD_5:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                brutallus->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACK1H);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACK1H);
            }
            events.ScheduleEvent(EVENT_MAD_6, 10s);
            break;
        case EVENT_MAD_6:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                brutallus->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            }
            me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            me->SetDisableGravity(true);
            events.ScheduleEvent(EVENT_MAD_7, 4s);
            break;
        case EVENT_MAD_7:
            Talk(SAY_MAD_3);
            me->CastSpell(me, SPELL_MADRIGOSA_FROST_BLAST, false);
            events.ScheduleEvent(EVENT_MAD_8, 3s);
            events.ScheduleEvent(EVENT_MAD_8, 5s);
            events.ScheduleEvent(EVENT_MAD_8_1, 6s);
            events.ScheduleEvent(EVENT_MAD_8, 6500ms);
            events.ScheduleEvent(EVENT_MAD_8, 7500ms);
            events.ScheduleEvent(EVENT_MAD_8, 8500ms);
            events.ScheduleEvent(EVENT_MAD_8, 9500ms);
            events.ScheduleEvent(EVENT_MAD_9, 11s);
            events.ScheduleEvent(EVENT_MAD_8, 12s);
            events.ScheduleEvent(EVENT_MAD_8, 14s);
            break;
        case EVENT_MAD_8:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
                me->CastSpell(brutallus, SPELL_MADRIGOSA_FROSTBOLT, false);
            break;
        case EVENT_MAD_8_1:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
                brutallus->CastSpell(brutallus, SPELL_BRUTALLUS_FLAME_RING, false);
            break;
        case EVENT_MAD_9:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                brutallus->RemoveAllAuras();
                brutallus->CastSpell(brutallus, SPELL_BRUTALLUS_FEL_FIREBALL, false);
                brutallus->AI()->Talk(YELL_INTRO_BREAK_ICE);
            }
            events.ScheduleEvent(EVENT_MAD_11, 6s);
            break;
            //case EVENT_MAD_10:
        case EVENT_MAD_11:
            me->SetDisableGravity(false);
            me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
            events.ScheduleEvent(EVENT_MAD_13, 2500ms);
            break;
        case EVENT_MAD_13:
            Talk(SAY_MAD_4);
            me->RemoveAllAuras();
            me->CastSpell(me, SPELL_MADRIGOSA_ENCAPSULATE, false);
            events.ScheduleEvent(EVENT_MAD_14, 2s);
            break;
        case EVENT_MAD_14:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                brutallus->SetDisableGravity(true);
                brutallus->GetMotionMaster()->MovePoint(0, brutallus->GetPositionX(), brutallus->GetPositionY() - 30.0f, brutallus->GetPositionZ() + 15.0f, FORCED_MOVEMENT_NONE, 0.f, 0.f, false, true);
            }
            events.ScheduleEvent(EVENT_MAD_15, 10s);
            break;
        case EVENT_MAD_15:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                brutallus->RemoveAllAuras();
                brutallus->SetDisableGravity(false);
                brutallus->GetMotionMaster()->MoveFall();
                brutallus->AI()->Talk(YELL_INTRO_CHARGE);
            }
            events.ScheduleEvent(EVENT_MAD_16, 1400ms);
            break;
        case EVENT_MAD_16:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
                brutallus->CastSpell(me, SPELL_BRUTALLUS_CHARGE, true);
            events.ScheduleEvent(EVENT_MAD_17, 1200ms);
            break;
        case EVENT_MAD_17:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
                brutallus->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
            events.ScheduleEvent(EVENT_MAD_18, 500ms);
            break;
        case EVENT_MAD_18:
            Talk(SAY_MAD_5);
            me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
            me->SetStandState(UNIT_STAND_STATE_DEAD);
            events.ScheduleEvent(EVENT_MAD_19, 6s);
            break;
        case EVENT_MAD_19:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
                brutallus->AI()->Talk(YELL_INTRO_KILL_MADRIGOSA);
            events.ScheduleEvent(EVENT_MAD_20, 7s);
            break;
        case EVENT_MAD_20:
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetFaction(FACTION_FRIENDLY);
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                brutallus->AI()->Talk(YELL_INTRO_TAUNT);
                brutallus->CastSpell(brutallus, SPELL_BRUTALLUS_BREAK_ICE, false);
            }
            events.ScheduleEvent(EVENT_MAD_21, 4s);
            break;
        case EVENT_MAD_21:
            if (Creature* brutallus = instance->GetCreature(DATA_BRUTALLUS))
            {
                brutallus->SetReactState(REACT_AGGRESSIVE);
                brutallus->SetHealth(brutallus->GetMaxHealth());
                brutallus->AI()->EnterEvadeMode();
                brutallus->setActive(false);
            }
            break;
        case EVENT_SPAWN_FELMYST:
            DoCastAOE(SPELL_SUMMON_FELBLAZE, true);
            me->DespawnOrUnsummon(1ms);
            break;
        }
    }
};

class spell_madrigosa_activate_barrier : public SpellScript
{
    PrepareSpellScript(spell_madrigosa_activate_barrier);

    void HandleActivateObject(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GameObject* go = GetHitGObj())
        {
            go->SetGoState(GO_STATE_READY);
            if (Map* map = go->GetMap())
                map->DoForAllPlayers([&](Player* player) {
                    UpdateData data;
                    WorldPacket pkt;
                    go->BuildValuesUpdateBlockForPlayer(&data, player);
                    data.BuildPacket(pkt);
                    player->SendDirectMessage(&pkt);
                });
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_madrigosa_activate_barrier::HandleActivateObject, EFFECT_0, SPELL_EFFECT_ACTIVATE_OBJECT);
    }
};

class spell_madrigosa_deactivate_barrier : public SpellScript
{
    PrepareSpellScript(spell_madrigosa_deactivate_barrier);

    void HandleActivateObject(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GameObject* go = GetHitGObj())
        {
            go->SetGoState(GO_STATE_ACTIVE);
            if (Map* map = go->GetMap())
                map->DoForAllPlayers([&](Player* player) {
                    UpdateData data;
                    WorldPacket pkt;
                    go->BuildValuesUpdateBlockForPlayer(&data, player);
                    data.BuildPacket(pkt);
                    player->SendDirectMessage(&pkt);
                });
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_madrigosa_deactivate_barrier::HandleActivateObject, EFFECT_0, SPELL_EFFECT_ACTIVATE_OBJECT);
    }
};

class spell_brutallus_burn : public SpellScript
{
    PrepareSpellScript(spell_brutallus_burn);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BURN_DAMAGE });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            if (!target->HasAura(SPELL_BURN_DAMAGE))
                target->CastSpell(target, SPELL_BURN_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_brutallus_burn::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class at_sunwell_madrigosa : public OnlyOnceAreaTriggerScript
{
public:
    at_sunwell_madrigosa() : OnlyOnceAreaTriggerScript("at_sunwell_madrigosa") {}

    bool _OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (!instance->IsBossDone(DATA_BRUTALLUS))
                if (Creature* creature = instance->GetCreature(DATA_MADRIGOSA))
                    creature->AI()->DoAction(ACTION_START_EVENT);

        return true;
    }
};

void AddSC_boss_brutallus()
{
    RegisterSunwellPlateauCreatureAI(boss_brutallus);
    RegisterSunwellPlateauCreatureAI(npc_madrigosa);
    RegisterSpellScript(spell_madrigosa_activate_barrier);
    RegisterSpellScript(spell_madrigosa_deactivate_barrier);
    RegisterSpellScript(spell_brutallus_burn);
    new at_sunwell_madrigosa();
}
