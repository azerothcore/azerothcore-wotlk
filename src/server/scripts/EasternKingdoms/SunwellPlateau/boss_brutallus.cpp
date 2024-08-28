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

class boss_brutallus : public CreatureScript
{
public:
    boss_brutallus() : CreatureScript("boss_brutallus") { }

    struct boss_brutallusAI : public BossAI
    {
        boss_brutallusAI(Creature* creature) : BossAI(creature, DATA_BRUTALLUS) { }

        void Reset() override
        {
            BossAI::Reset();
            me->CastSpell(me, SPELL_DUAL_WIELD, true);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (me->GetReactState() == REACT_PASSIVE && (!who || who->GetEntry() != NPC_MADRIGOSA))
            {
                if (who)
                    Unit::Kill(me, who);
                damage = 0;
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            if (who->GetEntry() == NPC_MADRIGOSA)
                return;

            Talk(YELL_AGGRO);
            BossAI::JustEngagedWith(who);

            events.ScheduleEvent(EVENT_SPELL_SLASH, 11000);
            events.ScheduleEvent(EVENT_SPELL_STOMP, 30000);
            events.ScheduleEvent(EVENT_SPELL_BURN, 45000);
            events.ScheduleEvent(EVENT_SPELL_BERSERK, 360000);
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

            me->CastSpell(me, SPELL_SUMMON_BRUTALLUS_DEATH_CLOUD, true);
            if (Creature* madrigosa = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_MADRIGOSA)))
                madrigosa->AI()->DoAction(ACTION_SPAWN_FELMYST);
        }

        void AttackStart(Unit* who) override
        {
            if (who->GetEntry() == NPC_MADRIGOSA)
                return;
            BossAI::AttackStart(who);
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
                case EVENT_SPELL_SLASH:
                    me->CastSpell(me->GetVictim(), SPELL_METEOR_SLASH, false);
                    events.ScheduleEvent(EVENT_SPELL_SLASH, 10000);
                    break;
                case EVENT_SPELL_STOMP:
                    me->CastSpell(me->GetVictim(), SPELL_STOMP, false);
                    Talk(YELL_LOVE);
                    events.ScheduleEvent(EVENT_SPELL_STOMP, 30000);
                    break;
                case EVENT_SPELL_BURN:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, true, -SPELL_BURN_DAMAGE))
                        me->CastSpell(target, SPELL_BURN, false);
                    events.ScheduleEvent(EVENT_SPELL_BURN, 60000);
                    break;
                case EVENT_SPELL_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    Talk(YELL_BERSERK);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSunwellPlateauAI<boss_brutallusAI>(creature);
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
    SPELL_BRUTALLUS_FLAME_RING      = 44874,
    SPELL_BRUTALLUS_BREAK_ICE       = 46637,
};

class npc_madrigosa : public CreatureScript
{
public:
    npc_madrigosa() : CreatureScript("npc_madrigosa") { }

    struct npc_madrigosaAI : public NullCreatureAI
    {
        npc_madrigosaAI(Creature* creature) : NullCreatureAI(creature)
        {
            instance = creature->GetInstanceScript();
            bool appear = instance->GetBossState(DATA_BRUTALLUS) != DONE && instance->GetBossState(DATA_MADRIGOSA) == DONE;
            creature->SetVisible(appear);
            creature->SetStandState(UNIT_STAND_STATE_DEAD);
            creature->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
        }

        EventMap events;
        InstanceScript* instance;

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_EVENT)
            {
                me->SetDisableGravity(true);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
                me->NearTeleportTo(1570.97f, 725.51f, 79.77f, 3.82f);
                events.ScheduleEvent(EVENT_MAD_1, 2000);
            }
            else if (param == ACTION_SPAWN_FELMYST)
                events.ScheduleEvent(EVENT_SPAWN_FELMYST, 60000);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_MAD_1:
                    me->SetVisible(true);
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        me->SetTarget(brutallus->GetGUID());
                        brutallus->SetReactState(REACT_PASSIVE);
                        brutallus->setActive(true);
                    }
                    me->GetMotionMaster()->MovePoint(1, 1477.94f, 643.22f, 21.21f);
                    me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                    events.ScheduleEvent(EVENT_MAD_2, 6000);
                    break;
                case EVENT_MAD_2:
                    Talk(SAY_MAD_1);
                    me->CastSpell(me, SPELL_MADRIGOSA_FREEZE, false);
                    events.ScheduleEvent(EVENT_MAD_2_1, 1000);
                    break;
                case EVENT_MAD_2_1:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    me->SetDisableGravity(false);
                    me->CastSpell(me, SPELL_MADRIGOSA_FROST_BREATH, false);
                    events.ScheduleEvent(EVENT_MAD_3, 7000);
                    break;
                case EVENT_MAD_3:
                    Talk(SAY_MAD_2);
                    events.ScheduleEvent(EVENT_MAD_4, 7000);
                    break;
                case EVENT_MAD_4:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                        brutallus->AI()->Talk(YELL_INTRO);
                    events.ScheduleEvent(EVENT_MAD_5, 5000);
                    break;
                case EVENT_MAD_5:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        brutallus->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACK1H);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACK1H);
                    }
                    events.ScheduleEvent(EVENT_MAD_6, 10000);
                    break;
                case EVENT_MAD_6:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        brutallus->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                    }
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    me->SetDisableGravity(true);
                    events.ScheduleEvent(EVENT_MAD_7, 4000);
                    break;
                case EVENT_MAD_7:
                    Talk(SAY_MAD_3);
                    me->CastSpell(me, SPELL_MADRIGOSA_FROST_BLAST, false);
                    events.ScheduleEvent(EVENT_MAD_8, 3000);
                    events.ScheduleEvent(EVENT_MAD_8, 5000);
                    events.ScheduleEvent(EVENT_MAD_8, 6500);
                    events.ScheduleEvent(EVENT_MAD_8, 7500);
                    events.ScheduleEvent(EVENT_MAD_8, 8500);
                    events.ScheduleEvent(EVENT_MAD_8, 9500);
                    events.ScheduleEvent(EVENT_MAD_9, 11000);
                    events.ScheduleEvent(EVENT_MAD_8, 12000);
                    events.ScheduleEvent(EVENT_MAD_8, 14000);
                    break;
                case EVENT_MAD_8:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                        me->CastSpell(brutallus, SPELL_MADRIGOSA_FROSTBOLT, false);
                    break;
                case EVENT_MAD_9:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        brutallus->CastSpell(brutallus, SPELL_BRUTALLUS_FLAME_RING, true);
                        brutallus->RemoveAllAuras();
                        brutallus->CastSpell(brutallus, SPELL_BRUTALLUS_FEL_FIREBALL, false);
                        brutallus->AI()->Talk(YELL_INTRO_BREAK_ICE);
                    }
                    events.ScheduleEvent(EVENT_MAD_11, 6000);
                    break;
                //case EVENT_MAD_10:
                case EVENT_MAD_11:
                    me->SetDisableGravity(false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    events.ScheduleEvent(EVENT_MAD_13, 2500);
                    break;
                case EVENT_MAD_13:
                    Talk(SAY_MAD_4);
                    me->RemoveAllAuras();
                    me->CastSpell(me, SPELL_MADRIGOSA_ENCAPSULATE, false);
                    events.ScheduleEvent(EVENT_MAD_14, 2000);
                    break;
                case EVENT_MAD_14:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        brutallus->SetDisableGravity(true);
                        brutallus->GetMotionMaster()->MovePoint(0, brutallus->GetPositionX(), brutallus->GetPositionY() - 30.0f, brutallus->GetPositionZ() + 15.0f, false, true);
                    }
                    events.ScheduleEvent(EVENT_MAD_15, 10000);
                    break;
                case EVENT_MAD_15:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        brutallus->RemoveAllAuras();
                        brutallus->SetDisableGravity(false);
                        brutallus->GetMotionMaster()->MoveFall();
                        brutallus->AI()->Talk(YELL_INTRO_CHARGE);
                    }
                    events.ScheduleEvent(EVENT_MAD_16, 1400);
                    break;
                case EVENT_MAD_16:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                        brutallus->CastSpell(me, SPELL_BRUTALLUS_CHARGE, true);
                    events.ScheduleEvent(EVENT_MAD_17, 1200);
                    break;
                case EVENT_MAD_17:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                        brutallus->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
                    events.ScheduleEvent(EVENT_MAD_18, 500);
                    break;
                case EVENT_MAD_18:
                    Talk(SAY_MAD_5);
                    me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    events.ScheduleEvent(EVENT_MAD_19, 6000);
                    break;
                case EVENT_MAD_19:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                        brutallus->AI()->Talk(YELL_INTRO_KILL_MADRIGOSA);
                    events.ScheduleEvent(EVENT_MAD_20, 7000);
                    break;
                case EVENT_MAD_20:
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetFaction(FACTION_FRIENDLY);
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        brutallus->AI()->Talk(YELL_INTRO_TAUNT);
                        brutallus->CastSpell(brutallus, SPELL_BRUTALLUS_BREAK_ICE, false);
                    }
                    events.ScheduleEvent(EVENT_MAD_21, 4000);
                    break;
                case EVENT_MAD_21:
                    if (Creature* brutallus = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRUTALLUS)))
                    {
                        brutallus->SetReactState(REACT_AGGRESSIVE);
                        brutallus->SetHealth(brutallus->GetMaxHealth());
                        brutallus->AI()->EnterEvadeMode();
                        brutallus->setActive(false);
                    }
                    break;
                case EVENT_SPAWN_FELMYST:
                    me->DespawnOrUnsummon(1);
                    if (Creature* felmyst = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_FELMYST)))
                        felmyst->AI()->DoAction(ACTION_START_EVENT);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSunwellPlateauAI<npc_madrigosaAI>(creature);
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
            {
                Map::PlayerList const& PlayerList = map->GetPlayers();
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    if (i->GetSource())
                    {
                        UpdateData data;
                        WorldPacket pkt;
                        go->BuildValuesUpdateBlockForPlayer(&data, i->GetSource());
                        data.BuildPacket(pkt);
                        i->GetSource()->GetSession()->SendPacket(&pkt);
                    }
            }
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
            {
                Map::PlayerList const& PlayerList = map->GetPlayers();
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    if (i->GetSource())
                    {
                        UpdateData data;
                        WorldPacket pkt;
                        go->BuildValuesUpdateBlockForPlayer(&data, i->GetSource());
                        data.BuildPacket(pkt);
                        i->GetSource()->GetSession()->SendPacket(&pkt);
                    }
            }
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

class AreaTrigger_at_sunwell_madrigosa : public AreaTriggerScript
{
public:
    AreaTrigger_at_sunwell_madrigosa() : AreaTriggerScript("at_sunwell_madrigosa") {}

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (instance->GetBossState(DATA_MADRIGOSA) != DONE)
            {
                instance->SetBossState(DATA_MADRIGOSA, NOT_STARTED);
                instance->SetBossState(DATA_MADRIGOSA, DONE);
                if (Creature* creature = ObjectAccessor::GetCreature(*player, instance->GetGuidData(NPC_MADRIGOSA)))
                    creature->AI()->DoAction(ACTION_START_EVENT);
            }

        return true;
    }
};

void AddSC_boss_brutallus()
{
    new boss_brutallus();
    new npc_madrigosa();
    RegisterSpellScript(spell_madrigosa_activate_barrier);
    RegisterSpellScript(spell_madrigosa_deactivate_barrier);
    RegisterSpellScript(spell_brutallus_burn);
    new AreaTrigger_at_sunwell_madrigosa();
}
