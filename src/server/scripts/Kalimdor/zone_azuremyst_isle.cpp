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

#include "Cell.h"
#include "CellImpl.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "GridNotifiers.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "GridNotifiersImpl.h"

/*######
## npc_draenei_survivor
######*/

enum draeneiSurvivor
{
    SAY_HEAL            = 0,
    SAY_HELP            = 1,
    SPELL_IRRIDATION    = 35046,
    SPELL_STUNNED       = 28630
};

class npc_draenei_survivor : public CreatureScript
{
public:
    npc_draenei_survivor() : CreatureScript("npc_draenei_survivor") { }

    struct npc_draenei_survivorAI : public ScriptedAI
    {
        npc_draenei_survivorAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid pCaster;

        uint32 SayThanksTimer;
        uint32 RunAwayTimer;
        uint32 SayHelpTimer;

        bool CanSayHelp;

        void Reset() override
        {
            pCaster.Clear();

            SayThanksTimer = 0;
            RunAwayTimer = 0;
            SayHelpTimer = 10000;

            CanSayHelp = true;

            DoCast(me, SPELL_IRRIDATION, true);

            me->SetPvP(true);
            me->SetUnitFlag(UNIT_FLAG_IN_COMBAT);
            me->SetHealth(me->CountPctFromMaxHealth(10));
            me->SetStandState(UNIT_STAND_STATE_SLEEP);
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void MoveInLineOfSight(Unit* who) override
        {
            if (CanSayHelp && who->IsPlayer() && me->IsFriendlyTo(who) && me->IsWithinDistInMap(who, 25.0f))
            {
                //Random switch between 4 texts
                Talk(SAY_HELP, who);

                SayHelpTimer = 20000;
                CanSayHelp = false;
            }
        }

        void SpellHit(Unit* Caster, SpellInfo const* Spell) override
        {
            if (Spell->SpellFamilyFlags[2] & 0x080000000)
            {
                me->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
                me->SetStandState(UNIT_STAND_STATE_STAND);

                DoCast(me, SPELL_STUNNED, true);

                pCaster = Caster->GetGUID();

                SayThanksTimer = 5000;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (SayThanksTimer)
            {
                if (SayThanksTimer <= diff)
                {
                    me->RemoveAurasDueToSpell(SPELL_IRRIDATION);

                    if (Player* player = ObjectAccessor::GetPlayer(*me, pCaster))
                    {
                        Talk(SAY_HEAL, player);

                        player->TalkedToCreature(me->GetEntry(), me->GetGUID());
                    }

                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MovePoint(0, -4115.053711f, -13754.831055f, 73.508949f);

                    RunAwayTimer = 10000;
                    SayThanksTimer = 0;
                }
                else SayThanksTimer -= diff;

                return;
            }

            if (RunAwayTimer)
            {
                if (RunAwayTimer <= diff)
                    me->DespawnOrUnsummon();
                else
                    RunAwayTimer -= diff;

                return;
            }

            if (SayHelpTimer <= diff)
            {
                CanSayHelp = true;
                SayHelpTimer = 20000;
            }
            else SayHelpTimer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_draenei_survivorAI(creature);
    }
};

/*######
## npc_injured_draenei
######*/

class npc_injured_draenei : public CreatureScript
{
public:
    npc_injured_draenei() : CreatureScript("npc_injured_draenei") { }

    struct npc_injured_draeneiAI : public ScriptedAI
    {
        npc_injured_draeneiAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            me->SetUnitFlag(UNIT_FLAG_IN_COMBAT);
            me->SetHealth(me->CountPctFromMaxHealth(15));
            switch (urand(0, 1))
            {
                case 0:
                    me->SetStandState(UNIT_STAND_STATE_SIT);
                    break;

                case 1:
                    me->SetStandState(UNIT_STAND_STATE_SLEEP);
                    break;
            }
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void MoveInLineOfSight(Unit* /*who*/) override { }

        void UpdateAI(uint32 /*diff*/) override { }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_injured_draeneiAI(creature);
    }
};

/*######
## npc_magwin
######*/

enum Magwin
{
    SAY_START                   = 0,
    SAY_AGGRO                   = 1,
    SAY_PROGRESS                = 2,
    SAY_END1                    = 3,
    SAY_END2                    = 4,
    EMOTE_HUG                   = 5,
    NPC_COWLEN                  = 17311,
    SAY_COWLEN                  = 0,
    EVENT_ACCEPT_QUEST          = 1,
    EVENT_START_ESCORT          = 2,
    EVENT_STAND                 = 3,
    EVENT_TALK_END              = 4,
    EVENT_COWLEN_TALK           = 5,
    QUEST_A_CRY_FOR_HELP        = 9528
};

class npc_magwin : public CreatureScript
{
public:
    npc_magwin() : CreatureScript("npc_magwin") { }

    struct npc_magwinAI : public npc_escortAI
    {
        npc_magwinAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override
        {
            _events.Reset();
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_AGGRO, who);
        }

        void sQuestAccept(Player* player, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_A_CRY_FOR_HELP)
            {
                _player = player->GetGUID();
                _events.ScheduleEvent(EVENT_ACCEPT_QUEST, 2s);
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (Player* player = GetPlayerForEscort())
            {
                switch (waypointId)
                {
                    case 17:
                        Talk(SAY_PROGRESS, player);
                        break;
                    case 28:
                        player->GroupEventHappens(QUEST_A_CRY_FOR_HELP, me);
                        _events.ScheduleEvent(EVENT_TALK_END, 2s);
                        me->SetWalk(false);
                        break;
                    case 29:
                        if (Creature* cowlen = me->FindNearestCreature(NPC_COWLEN, 50.0f, true))
                        {
                            Talk(EMOTE_HUG, cowlen);
                            Talk(SAY_END2, player);
                            break;
                        }
                }
            }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            _events.Update(diff);
            if (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ACCEPT_QUEST:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _player))
                        {
                            Talk(SAY_START, player);
                        }
                        me->SetFaction(FACTION_ESCORTEE_N_NEUTRAL_PASSIVE);
                        _events.ScheduleEvent(EVENT_START_ESCORT, 1s);
                        break;
                    case EVENT_START_ESCORT:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _player))
                        {
                            me->SetWalk(true);
                            Start(true, player->GetGUID());
                        }
                        _events.ScheduleEvent(EVENT_STAND, 2s);
                        break;
                    case EVENT_STAND: // Remove kneel standstate. Using a separate delayed event because it causes unwanted delay before starting waypoint movement.
                        me->SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_STAND_STATE, UNIT_STAND_STATE_STAND);
                        break;
                    case EVENT_TALK_END:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _player))
                        {
                            Talk(SAY_END1, player);
                        }
                        _events.ScheduleEvent(EVENT_COWLEN_TALK, 2s);
                        break;
                    case EVENT_COWLEN_TALK:
                        if (Creature* cowlen = me->FindNearestCreature(NPC_COWLEN, 50.0f, true))
                        {
                            cowlen->AI()->Talk(SAY_COWLEN);
                        }
                        break;
                }
            }
            npc_escortAI::UpdateEscortAI(diff);
        }
    private:
        EventMap _events;
        ObjectGuid _player;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_magwinAI(creature);
    }
};

enum RavegerCage
{
    NPC_DEATH_RAVAGER       = 17556,

    SPELL_REND              = 13443,
    SPELL_ENRAGING_BITE     = 30736,

    QUEST_STRENGTH_ONE      = 9582
};

class go_ravager_cage : public GameObjectScript
{
public:
    go_ravager_cage() : GameObjectScript("go_ravager_cage") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->UseDoorOrButton();
        if (player->GetQuestStatus(QUEST_STRENGTH_ONE) == QUEST_STATUS_INCOMPLETE)
        {
            if (Creature* ravager = go->FindNearestCreature(NPC_DEATH_RAVAGER, 5.0f, true))
            {
                ravager->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                ravager->SetReactState(REACT_AGGRESSIVE);
                ravager->AI()->AttackStart(player);
            }
        }
        return true;
    }
};

class npc_death_ravager : public CreatureScript
{
public:
    npc_death_ravager() : CreatureScript("npc_death_ravager") { }

    struct npc_death_ravagerAI : public ScriptedAI
    {
        npc_death_ravagerAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 RendTimer;
        uint32 EnragingBiteTimer;

        void Reset() override
        {
            RendTimer = 30000;
            EnragingBiteTimer = 20000;

            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (RendTimer <= diff)
            {
                DoCastVictim(SPELL_REND);
                RendTimer = 30000;
            }
            else RendTimer -= diff;

            if (EnragingBiteTimer <= diff)
            {
                DoCastVictim(SPELL_ENRAGING_BITE);
                EnragingBiteTimer = 15000;
            }
            else EnragingBiteTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_death_ravagerAI(creature);
    }
};

/*########
## Quest: The Prophecy of Akida
########*/

enum BristlelimbCage
{
    QUEST_THE_PROPHECY_OF_AKIDA         = 9544,
    NPC_STILLPINE_CAPITIVE              = 17375,
    GO_BRISTELIMB_CAGE                  = 181714,

    CAPITIVE_SAY                        = 0,

    POINT_INIT                          = 1,
    EVENT_DESPAWN                       = 1,
};

class npc_stillpine_capitive : public CreatureScript
{
public:
    npc_stillpine_capitive() : CreatureScript("npc_stillpine_capitive") { }

    struct npc_stillpine_capitiveAI : public ScriptedAI
    {
        npc_stillpine_capitiveAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            if (GameObject* cage = me->FindNearestGameObject(GO_BRISTELIMB_CAGE, 5.0f))
            {
                cage->SetLootState(GO_JUST_DEACTIVATED);
                cage->SetGoState(GO_STATE_READY);
            }
            _events.Reset();
            _playerGUID.Clear();
            _movementComplete = false;
        }

        void StartMoving(Player* owner)
        {
            if (owner)
            {
                Talk(CAPITIVE_SAY, owner);
                _playerGUID = owner->GetGUID();
            }
            Position pos = me->GetNearPosition(3.0f, 0.0f);
            me->GetMotionMaster()->MovePoint(POINT_INIT, pos);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_INIT)
                return;

            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                player->RewardPlayerAndGroupAtEvent(me->GetEntry(), player);

            _movementComplete = true;
            _events.ScheduleEvent(EVENT_DESPAWN, 3500ms);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!_movementComplete)
                return;

            _events.Update(diff);

            if (_events.ExecuteEvent() == EVENT_DESPAWN)
                me->DespawnOrUnsummon();
        }

    private:
        ObjectGuid _playerGUID;
        EventMap _events;
        bool _movementComplete;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_stillpine_capitiveAI(creature);
    }
};

class go_bristlelimb_cage : public GameObjectScript
{
public:
    go_bristlelimb_cage() : GameObjectScript("go_bristlelimb_cage") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->SetGoState(GO_STATE_READY);
        if (player->GetQuestStatus(QUEST_THE_PROPHECY_OF_AKIDA) == QUEST_STATUS_INCOMPLETE)
        {
            if (Creature* capitive = go->FindNearestCreature(NPC_STILLPINE_CAPITIVE, 5.0f, true))
            {
                go->ResetDoorOrButton();
                CAST_AI(npc_stillpine_capitive::npc_stillpine_capitiveAI, capitive->AI())->StartMoving(player);
                return false;
            }
        }
        return true;
    }
};

enum NestlewoodOwlkin
{
    NPC_NESTLEWOOD_OWLKIN_ENTRY   = 16518,
    NPC_INOCULATED_OWLKIN_ENTRY   = 16534,

    TALK_OWLKIN                   = 0
};

class spell_inoculate_nestlewood_owlkin : public AuraScript
{
public:
    PrepareAuraScript(spell_inoculate_nestlewood_owlkin)

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* owlkin = GetTarget()->ToCreature())
            if (owlkin->GetEntry() == NPC_NESTLEWOOD_OWLKIN_ENTRY)
                owlkin->SetFacingToObject(GetCaster());
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        if (Creature* owlkin = GetTarget()->ToCreature())
        {
            if (owlkin->GetEntry() == NPC_NESTLEWOOD_OWLKIN_ENTRY)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (owlkin->UpdateEntry(NPC_INOCULATED_OWLKIN_ENTRY))
                {
                    owlkin->AI()->Talk(TALK_OWLKIN);
                    owlkin->GetMotionMaster()->MoveRandom(15.0f);
                    owlkin->SetUnitFlag(UnitFlags(UNIT_FLAG_IMMUNE_TO_PC));
                    owlkin->DespawnOrUnsummon(15s, 0s);
                    caster->RewardPlayerAndGroupAtEvent(NPC_INOCULATED_OWLKIN_ENTRY, caster);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_inoculate_nestlewood_owlkin::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_inoculate_nestlewood_owlkin::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_azuremyst_isle()
{
    new npc_draenei_survivor();
    new npc_injured_draenei();
    new npc_magwin();
    new npc_death_ravager();
    new go_ravager_cage();
    new npc_stillpine_capitive();
    new go_bristlelimb_cage();
    RegisterSpellScript(spell_inoculate_nestlewood_owlkin);
}
