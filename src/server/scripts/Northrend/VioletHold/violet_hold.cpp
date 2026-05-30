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

#include "violet_hold.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

/// @todo: Missing Sinclari Trigger announcements (32204) Look at its creature_text for more info.

/***********
** TELEPORTATION PORTAL
***********/

enum PortalEvents
{
    EVENT_SUMMON_KEEPER_OR_GUARDIAN = 1,
    EVENT_SUMMON_KEEPER_TRASH,
    EVENT_SUMMON_ELITES,
    EVENT_SUMMON_SABOTEOUR,
    EVENT_CHECK_DEATHS,
};

struct npc_vh_teleportation_portal : public NullCreatureAI
{
    npc_vh_teleportation_portal(Creature* c) : NullCreatureAI(c), _listOfMobs(me)
    {
        _instance = c->GetInstanceScript();
        _events.Reset();
        _wave = _instance->GetData(DATA_WAVE_COUNT);
        _isKeeperOrGuardian = false;
        _spawned = false;

        if (_wave < 12)
            _addValue = 0;
        else
            _addValue = 1;

        if (_wave % 6 != 0)
            _events.RescheduleEvent(RAND(EVENT_SUMMON_KEEPER_OR_GUARDIAN, EVENT_SUMMON_ELITES), 10s);
        else
            _events.RescheduleEvent(EVENT_SUMMON_SABOTEOUR, 3s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_SUMMON_KEEPER_OR_GUARDIAN:
                _isKeeperOrGuardian = true;
                _spawned = true;
                if (Creature* c = DoSummon(RAND(NPC_PORTAL_GUARDIAN, NPC_PORTAL_KEEPER_1, NPC_PORTAL_KEEPER_2), me, 2.0f, 0, TEMPSUMMON_DEAD_DESPAWN))
                    DoCast(c, SPELL_PORTAL_CHANNEL);
                _events.RescheduleEvent(EVENT_SUMMON_KEEPER_TRASH, 20s);
                break;
            case EVENT_SUMMON_KEEPER_TRASH:
                for (uint8 i = 0; i < 3 + _addValue; ++i)
                {
                    uint32 entry = RAND(NPC_AZURE_INVADER_1, NPC_AZURE_INVADER_2, NPC_AZURE_SPELLBREAKER_1, NPC_AZURE_SPELLBREAKER_2, NPC_AZURE_MAGE_SLAYER_1, NPC_AZURE_MAGE_SLAYER_2, NPC_AZURE_BINDER_1, NPC_AZURE_BINDER_2);
                    DoSummon(entry, me, 2.0f, 20000, TEMPSUMMON_DEAD_DESPAWN);
                }
                _events.Repeat(20s);
                break;
            case EVENT_SUMMON_ELITES:
                _spawned = true;
                for (uint8 i = 0; i < 2 + _addValue; ++i)
                {
                    uint32 entry = RAND(NPC_AZURE_CAPTAIN, NPC_AZURE_RAIDER, NPC_AZURE_STALKER, NPC_AZURE_SORCEROR);
                    DoSummon(entry, me, 2.0f, 20000, TEMPSUMMON_DEAD_DESPAWN);
                }
                me->SetVisible(false);
                break;
            case EVENT_SUMMON_SABOTEOUR:
                DoSummon(NPC_SABOTEOUR, me, 2.0f, 0, TEMPSUMMON_CORPSE_DESPAWN);
                me->DespawnOrUnsummon(3s);
                break;
        }

        if (!_spawned)
            return;

        if (_isKeeperOrGuardian)
        {
            if (!me->IsNonMeleeSpellCast(false))
            {
                for (SummonList::iterator itr = _listOfMobs.begin(); itr != _listOfMobs.end(); ++itr)
                    if (Creature* c = _instance->instance->GetCreature(*itr))
                            if (c->IsAlive() && c->EntryEquals(NPC_PORTAL_GUARDIAN, NPC_PORTAL_KEEPER_1, NPC_PORTAL_KEEPER_2))
                            {
                                DoCast(c, SPELL_PORTAL_CHANNEL);
                                return;
                            }

                Unit::Kill(me, me, false);
            }
        }
        else
        {
            if (_listOfMobs.empty())
                Unit::Kill(me, me, false);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _events.Reset();
        if (_wave % 6 == 0)
            return;
        _instance->DoAction(ACTION_PORTAL_DEFEATED);
    }

    void JustSummoned(Creature* summoned) override
    {
        if (summoned)
        {
            _listOfMobs.Summon(summoned);
            _instance->SetGuidData(DATA_ADD_TRASH_MOB, summoned->GetGUID());
        }
    }

    void SummonedMobDied(Creature* summoned)
    {
        if (summoned)
        {
            _listOfMobs.Despawn(summoned);
            _instance->SetGuidData(DATA_DELETE_TRASH_MOB, summoned->GetGUID());
        }
    }

private:
    InstanceScript* _instance;
    SummonList _listOfMobs;
    EventMap _events;
    uint8 _wave;
    uint8 _addValue;
    bool _isKeeperOrGuardian;
    bool _spawned;
};

/***********
** GENERAL TRASH AI
***********/

struct violet_hold_trashAI : public npc_escortAI
{
    violet_hold_trashAI(Creature* c) : npc_escortAI(c)
    {
        Instance = c->GetInstanceScript();
        PortalLoc = Instance->GetData(DATA_PORTAL_LOCATION);
        AddedWaypoints = false;
        UseAlternate = false;
    }

    void ClearDoorSealAura()
    {
        if (Creature* c = Instance->GetCreature(DATA_DOOR_SEAL))
            c->RemoveAura(SPELL_DESTROY_DOOR_SEAL, me->GetGUID());
    }

    void JustEngagedWith(Unit* who) override
    {
        if (!who->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
        {
            me->InterruptNonMeleeSpells(false);
            me->SetImmuneToNPC(false);
        }
    }

    void AttackStart(Unit* who) override
    {
        if (!who->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
            ScriptedAI::AttackStart(who);
    }

    void JustReachedHome() override
    {
        CreatureStartAttackDoor();
    }

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 id) override
    {
        if (PortalLoc < 6)
            if (id == uint16(PLocWPCount[PortalLoc] - 1 - (UseAlternate ? 1 : 0)))
                CreatureStartAttackDoor();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!AddedWaypoints)
        {
            AddedWaypoints = true;
            switch (PortalLoc)
            {
                case 0:
                    for (int i = 0; i < 6; i++)
                        AddWaypoint(i, FirstPortalTrashWPs[i][0] + irand(-1, 1), FirstPortalTrashWPs[i][1] + irand(-1, 1), FirstPortalTrashWPs[i][2] + irand(-1, 1), 0);
                    me->SetHomePosition(FirstPortalTrashWPs[5][0], FirstPortalTrashWPs[5][1], FirstPortalTrashWPs[5][2], 3.149439f);
                    break;
                case 1:
                    UseAlternate = (bool)urand(0, 1);
                    if (!UseAlternate)
                    {
                        for (int i = 0; i < 9; i++)
                            AddWaypoint(i, SecondPortalTrashWPs1[i][0] + irand(-1, 1), SecondPortalTrashWPs1[i][1] + irand(-1, 1), SecondPortalTrashWPs1[i][2], 0);
                        me->SetHomePosition(SecondPortalTrashWPs1[8][0] + irand(-1, 1), SecondPortalTrashWPs1[8][1] + irand(-1, 1), SecondPortalTrashWPs1[8][2] + irand(-1, 1), 3.149439f);
                    }
                    else
                    {
                        for (int i = 0; i < 8; i++)
                            AddWaypoint(i, SecondPortalTrashWPs2[i][0] + irand(-1, 1), SecondPortalTrashWPs2[i][1] + irand(-1, 1), SecondPortalTrashWPs2[i][2], 0);
                        me->SetHomePosition(SecondPortalTrashWPs2[7][0], SecondPortalTrashWPs2[7][1], SecondPortalTrashWPs2[7][2], 3.149439f);
                    }
                    break;
                case 2:
                    for (int i = 0; i < 8; i++)
                        AddWaypoint(i, ThirdPortalTrashWPs[i][0] + irand(-1, 1), ThirdPortalTrashWPs[i][1] + irand(-1, 1), ThirdPortalTrashWPs[i][2], 0);
                    me->SetHomePosition(ThirdPortalTrashWPs[7][0], ThirdPortalTrashWPs[7][1], ThirdPortalTrashWPs[7][2], 3.149439f);
                    break;
                case 3:
                    for (int i = 0; i < 9; i++)
                        AddWaypoint(i, FourthPortalTrashWPs[i][0] + irand(-1, 1), FourthPortalTrashWPs[i][1] + irand(-1, 1), FourthPortalTrashWPs[i][2], 0);
                    me->SetHomePosition(FourthPortalTrashWPs[8][0], FourthPortalTrashWPs[8][1], FourthPortalTrashWPs[8][2], 3.149439f);
                    break;
                case 4:
                    for (int i = 0; i < 6; i++)
                        AddWaypoint(i, FifthPortalTrashWPs[i][0] + irand(-1, 1), FifthPortalTrashWPs[i][1] + irand(-1, 1), FifthPortalTrashWPs[i][2], 0);
                    me->SetHomePosition(FifthPortalTrashWPs[5][0], FifthPortalTrashWPs[5][1], FifthPortalTrashWPs[5][2], 3.149439f);
                    break;
                case 5:
                    for (int i = 0; i < 4; i++)
                        AddWaypoint(i, SixthPoralTrashWPs[i][0] + irand(-1, 1), SixthPoralTrashWPs[i][1] + irand(-1, 1), SixthPoralTrashWPs[i][2], 0);
                    me->SetHomePosition(SixthPoralTrashWPs[3][0], SixthPoralTrashWPs[3][1], SixthPoralTrashWPs[3][2], 3.149439f);
                    break;
            }
            SetDespawnAtEnd(false);
            Start(true);
        }

        npc_escortAI::UpdateAI(diff);
    }

    void JustDied(Unit* /*unit*/) override
    {
        if (Creature* portal = Instance->GetCreature(DATA_TELEPORTATION_PORTAL))
            CAST_AI(npc_vh_teleportation_portal, portal->AI())->SummonedMobDied(me);
    }

    void CreatureStartAttackDoor()
    {
        RemoveEscortState(STATE_ESCORT_ESCORTING | STATE_ESCORT_RETURNING | STATE_ESCORT_PAUSED);
        me->SetImmuneToNPC(true);
        DoCastAOE(SPELL_DESTROY_DOOR_SEAL, true);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        if (!HasEscortState(STATE_ESCORT_ESCORTING))
        {
            me->SetImmuneToNPC(false);
            me->SetHomePosition(1845.577759f + rand_norm() * 5 - 2.5f, 800.681152f + rand_norm() * 5 - 2.5f, 44.104248f, M_PI);
        }

        me->GetThreatMgr().ClearAllThreat();
        me->CombatStop(true);
        if (HasEscortState(STATE_ESCORT_ESCORTING))
        {
            AddEscortState(STATE_ESCORT_RETURNING);
            ReturnToLastPoint();
        }
        else
        {
            me->GetMotionMaster()->MoveTargetedHome();
            Reset();
        }
        me->ClearUnitState(UNIT_STATE_EVADE);
    }

protected:
    InstanceScript* Instance;
    bool AddedWaypoints;
    uint32 PortalLoc;
    bool UseAlternate;
};

/***********
** TRASH SPELLS
***********/

enum AzureInvaderSpells
{
    SPELL_CLEAVE        = 15496,
    SPELL_IMPALE        = 58459,
    SPELL_BRUTAL_STRIKE = 58460,
    SPELL_SUNDER_ARMOR  = 58461,
};

enum AzureSpellbreakerSpells
{
    SPELL_ARCANE_BLAST  = 58462,
    SPELL_SLOW          = 25603,
    SPELL_CHAINS_OF_ICE = 58464,
    SPELL_CONE_OF_COLD  = 58463,
};

enum AzureBinderSpells
{
    SPELL_ARCANE_BARRAGE   = 58456,
    SPELL_ARCANE_EXPLOSION = 58455,
    SPELL_FROST_NOVA       = 58458,
    SPELL_FROSTBOLT        = 58457,
};

enum AzureMageSlayerSpells
{
    SPELL_ARCANE_EMPOWERMENT = 58469,
    SPELL_SPELL_LOCK         = 30849
};

enum AzureCaptainSpells
{
    SPELL_MORTAL_STRIKE      = 32736,
    SPELL_WHIRLWIND_OF_STEEL = 41056
};

enum AzureSorcerorSpells
{
    SPELL_ARCANE_STREAM   = 60181,
    SPELL_MANA_DETONATION = 60182,
};

enum AzureRaiderSpells
{
    SPELL_CONCUSSION_BLOW  = 52719,
    SPELL_MAGIC_REFLECTION = 60158
};

enum AzureStalkerSpells
{
    SPELL_BACKSTAB       = 58471,
    SPELL_TACTICAL_BLINK = 58470
};

/***********
** TRASH — AZURE INVADER
***********/

enum InvaderEvents
{
    EVENT_INVADER_CLEAVE = 1,
    EVENT_INVADER_IMPALE,
    EVENT_INVADER_BRUTAL_STRIKE,
    EVENT_INVADER_SUNDER_ARMOR,
};

struct npc_azure_invader : public violet_hold_trashAI
{
    npc_azure_invader(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_INVADER_CLEAVE, 5s);
        _events.RescheduleEvent(EVENT_INVADER_IMPALE, 4s);
        _events.RescheduleEvent(EVENT_INVADER_BRUTAL_STRIKE, 5s);
        _events.RescheduleEvent(EVENT_INVADER_SUNDER_ARMOR, 4s);
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_INVADER_CLEAVE:
                if (me->GetEntry() == NPC_AZURE_INVADER_1)
                    DoCast(me->GetVictim(), SPELL_CLEAVE);
                _events.Repeat(5s);
                break;
            case EVENT_INVADER_IMPALE:
                if (me->GetEntry() == NPC_AZURE_INVADER_1)
                    DoCastRandomTarget(SPELL_IMPALE, 0, 5.0f);
                _events.Repeat(4s);
                break;
            case EVENT_INVADER_BRUTAL_STRIKE:
                if (me->GetEntry() == NPC_AZURE_INVADER_2)
                    DoCast(me->GetVictim(), SPELL_BRUTAL_STRIKE);
                _events.Repeat(5s);
                break;
            case EVENT_INVADER_SUNDER_ARMOR:
                if (me->GetEntry() == NPC_AZURE_INVADER_2)
                    DoCast(me->GetVictim(), SPELL_SUNDER_ARMOR);
                _events.Repeat(8s, 10s);
                break;
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
};

/***********
** TRASH — AZURE BINDER
***********/

enum BinderEvents
{
    EVENT_BINDER_ARCANE_EXPLOSION = 1,
    EVENT_BINDER_ARCANE_BARRAGE,
    EVENT_BINDER_FROST_NOVA,
    EVENT_BINDER_FROSTBOLT,
};

struct npc_azure_binder : public violet_hold_trashAI
{
    npc_azure_binder(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_BINDER_ARCANE_EXPLOSION, 5s);
        _events.RescheduleEvent(EVENT_BINDER_ARCANE_BARRAGE, 4s);
        _events.RescheduleEvent(EVENT_BINDER_FROST_NOVA, 5s);
        _events.RescheduleEvent(EVENT_BINDER_FROSTBOLT, 4s);
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_BINDER_ARCANE_EXPLOSION:
                if (me->GetEntry() == NPC_AZURE_BINDER_1)
                    DoCast(SPELL_ARCANE_EXPLOSION);
                _events.Repeat(5s);
                break;
            case EVENT_BINDER_ARCANE_BARRAGE:
                if (me->GetEntry() == NPC_AZURE_BINDER_1)
                    DoCastRandomTarget(SPELL_ARCANE_BARRAGE, 0, 30.0f);
                _events.Repeat(6s);
                break;
            case EVENT_BINDER_FROST_NOVA:
                if (me->GetEntry() == NPC_AZURE_BINDER_2)
                    DoCast(SPELL_FROST_NOVA);
                _events.Repeat(5s);
                break;
            case EVENT_BINDER_FROSTBOLT:
                if (me->GetEntry() == NPC_AZURE_BINDER_2)
                    DoCastRandomTarget(SPELL_FROSTBOLT, 0, 40.0f);
                _events.Repeat(6s);
                break;
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
};

/***********
** TRASH — AZURE MAGE SLAYER
***********/

enum MageSlayerEvents
{
    EVENT_MAGE_SLAYER_ARCANE_EMPOWERMENT = 1,
    EVENT_MAGE_SLAYER_SPELL_LOCK,
};

struct npc_azure_mage_slayer : public violet_hold_trashAI
{
    npc_azure_mage_slayer(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_MAGE_SLAYER_ARCANE_EMPOWERMENT, 5s);
        _events.RescheduleEvent(EVENT_MAGE_SLAYER_SPELL_LOCK, 5s);
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_MAGE_SLAYER_ARCANE_EMPOWERMENT:
                if (me->GetEntry() == NPC_AZURE_MAGE_SLAYER_1)
                    DoCastSelf(SPELL_ARCANE_EMPOWERMENT);
                _events.Repeat(14s);
                break;
            case EVENT_MAGE_SLAYER_SPELL_LOCK:
                if (me->GetEntry() == NPC_AZURE_MAGE_SLAYER_2)
                    DoCastRandomTarget(SPELL_SPELL_LOCK, 0, 30.0f);
                _events.Repeat(9s);
                break;
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
};

/***********
** TRASH — AZURE RAIDER
***********/

enum RaiderEvents
{
    EVENT_RAIDER_CONCUSSION_BLOW = 1,
    EVENT_RAIDER_MAGIC_REFLECTION,
};

struct npc_azure_raider : public violet_hold_trashAI
{
    npc_azure_raider(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_RAIDER_CONCUSSION_BLOW, 5s);
        _events.RescheduleEvent(EVENT_RAIDER_MAGIC_REFLECTION, 8s);
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_RAIDER_CONCUSSION_BLOW:
                DoCast(me->GetVictim(), SPELL_CONCUSSION_BLOW);
                _events.Repeat(5s);
                break;
            case EVENT_RAIDER_MAGIC_REFLECTION:
                DoCast(SPELL_MAGIC_REFLECTION);
                _events.Repeat(10s, 15s);
                break;
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
};

/***********
** TRASH — AZURE STALKER
***********/

enum StalkerEvents
{
    EVENT_STALKER_BACKSTAB = 1,
};

struct npc_azure_stalker : public violet_hold_trashAI
{
    npc_azure_stalker(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_STALKER_BACKSTAB, 1300ms);
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        if (_events.ExecuteEvent() == EVENT_STALKER_BACKSTAB)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::MaxDistance, 0, 5.0f, true))
                if (!target->HasInArc(M_PI, me))
                    DoCast(target, SPELL_BACKSTAB);
            _events.Repeat(4s);
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
};

/***********
** TRASH — AZURE SPELLBREAKER
***********/

enum SpellbreakerEvents
{
    EVENT_SPELLBREAKER_ARCANE_BLAST = 1,
    EVENT_SPELLBREAKER_SLOW,
    EVENT_SPELLBREAKER_CHAINS_OF_ICE,
    EVENT_SPELLBREAKER_CONE_OF_COLD,
};

struct npc_azure_spellbreaker : public violet_hold_trashAI
{
    npc_azure_spellbreaker(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_SPELLBREAKER_ARCANE_BLAST, 5s);
        _events.RescheduleEvent(EVENT_SPELLBREAKER_SLOW, 4s);
        _events.RescheduleEvent(EVENT_SPELLBREAKER_CHAINS_OF_ICE, 5s);
        _events.RescheduleEvent(EVENT_SPELLBREAKER_CONE_OF_COLD, 4s);
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_SPELLBREAKER_ARCANE_BLAST:
                if (me->GetEntry() == NPC_AZURE_SPELLBREAKER_1)
                    DoCastRandomTarget(SPELL_ARCANE_BLAST, 0, 30.0f);
                _events.Repeat(6s);
                break;
            case EVENT_SPELLBREAKER_SLOW:
                if (me->GetEntry() == NPC_AZURE_SPELLBREAKER_1)
                    DoCastRandomTarget(SPELL_SLOW, 0, 30.0f);
                _events.Repeat(5s);
                break;
            case EVENT_SPELLBREAKER_CHAINS_OF_ICE:
                if (me->GetEntry() == NPC_AZURE_SPELLBREAKER_2)
                    DoCastRandomTarget(SPELL_CHAINS_OF_ICE, 0, 30.0f);
                _events.Repeat(7s);
                break;
            case EVENT_SPELLBREAKER_CONE_OF_COLD:
                if (me->GetEntry() == NPC_AZURE_SPELLBREAKER_2)
                    DoCast(SPELL_CONE_OF_COLD);
                _events.Repeat(5s);
                break;
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
};

/***********
** TRASH — AZURE CAPTAIN
***********/

enum CaptainEvents
{
    EVENT_CAPTAIN_MORTAL_STRIKE = 1,
    EVENT_CAPTAIN_WHIRLWIND,
};

struct npc_azure_captain : public violet_hold_trashAI
{
    npc_azure_captain(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_CAPTAIN_MORTAL_STRIKE, 5s);
        _events.RescheduleEvent(EVENT_CAPTAIN_WHIRLWIND, 8s);
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_CAPTAIN_MORTAL_STRIKE:
                DoCast(me->GetVictim(), SPELL_MORTAL_STRIKE);
                _events.Repeat(5s);
                break;
            case EVENT_CAPTAIN_WHIRLWIND:
                DoCastAOE(SPELL_WHIRLWIND_OF_STEEL);
                _events.Repeat(8s);
                break;
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
};

/***********
** TRASH — AZURE SORCEROR
***********/

enum SorcerorEvents
{
    EVENT_SORCEROR_ARCANE_STREAM = 1,
    EVENT_SORCEROR_MANA_DETONATION,
};

struct npc_azure_sorceror : public violet_hold_trashAI
{
    npc_azure_sorceror(Creature* c) : violet_hold_trashAI(c) {}

    void Reset() override
    {
        _events.Reset();
        _events.RescheduleEvent(EVENT_SORCEROR_ARCANE_STREAM, 4s);
        _events.RescheduleEvent(EVENT_SORCEROR_MANA_DETONATION, 5s);
        _arcaneStreamOnCooldown = false;
    }

    void UpdateAI(uint32 diff) override
    {
        violet_hold_trashAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case EVENT_SORCEROR_ARCANE_STREAM:
                DoCastRandomTarget(SPELL_ARCANE_STREAM, 0, 35.0f);
                _arcaneStreamOnCooldown = true;
                _events.Repeat(5s, 10s);
                break;
            case EVENT_SORCEROR_MANA_DETONATION:
                if (_arcaneStreamOnCooldown)
                {
                    DoCastAOE(SPELL_MANA_DETONATION);
                    _arcaneStreamOnCooldown = false;
                }
                _events.Repeat(2s, 6s);
                break;
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    bool _arcaneStreamOnCooldown;
};

/***********
** SABOTEUR
***********/

enum AzureSaboteurSpells
{
    SABOTEUR_SHIELD_DISRUPTION = 58291,
    SABOTEUR_SHIELD_EFFECT = 45775,
    SPELL_TELEPORT_VISUAL = 52096,
};

enum SaboteurEvents
{
    EVENT_SABOTEUR_SHIELD_DISRUPTION = 1,
    EVENT_SABOTEUR_RELEASE_BOSS,
    EVENT_SABOTEUR_DISAPPEAR,
};

struct npc_azure_saboteur : public npc_escortAI
{
    npc_azure_saboteur(Creature* c) : npc_escortAI(c)
    {
        _instance = c->GetInstanceScript();
        _boss = _instance->GetData(DATA_WAVE_COUNT) == 6
            ? _instance->GetPersistentData(PERSISTENT_DATA_FIRST_BOSS)
            : _instance->GetPersistentData(PERSISTENT_DATA_SECOND_BOSS);
        _addedWaypoints = false;
        _isOpening = false;
    }

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 waypointId) override
    {
        switch (_boss)
        {
            case BOSS_MORAGG:
                if (waypointId == 2)
                    FinishPointReached();
                break;
            case BOSS_EREKEM:
                if (waypointId == 2)
                    FinishPointReached();
                break;
            case BOSS_ICHORON:
                if (waypointId == 1)
                    FinishPointReached();
                break;
            case BOSS_LAVANTHOR:
                if (waypointId == 0)
                    FinishPointReached();
                break;
            case BOSS_XEVOZZ:
                if (waypointId == 0)
                    FinishPointReached();
                break;
            case BOSS_ZURAMAT:
                if (waypointId == 4)
                    FinishPointReached();
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        npc_escortAI::UpdateAI(diff);

        if (!_addedWaypoints)
        {
            _addedWaypoints = true;
            switch (_boss)
            {
                case BOSS_MORAGG:
                    for (int i = 0; i < 3; i++)
                        AddWaypoint(i, SaboteurFinalPos1[i][0], SaboteurFinalPos1[i][1], SaboteurFinalPos1[i][2], 0);
                    me->SetHomePosition(SaboteurFinalPos1[2][0], SaboteurFinalPos1[2][1], SaboteurFinalPos1[2][2], 4.762346f);
                    break;
                case BOSS_EREKEM:
                    for (int i = 0; i < 3; i++)
                        AddWaypoint(i, SaboteurFinalPos2[i][0], SaboteurFinalPos2[i][1], SaboteurFinalPos2[i][2], 0);
                    me->SetHomePosition(SaboteurFinalPos2[2][0], SaboteurFinalPos2[2][1], SaboteurFinalPos2[2][2], 1.862674f);
                    break;
                case BOSS_ICHORON:
                    for (int i = 0; i < 2; i++)
                        AddWaypoint(i, SaboteurFinalPos3[i][0], SaboteurFinalPos3[i][1], SaboteurFinalPos3[i][2], 0);
                    me->SetHomePosition(SaboteurFinalPos3[1][0], SaboteurFinalPos3[1][1], SaboteurFinalPos3[1][2], 5.500638f);
                    break;
                case BOSS_LAVANTHOR:
                    AddWaypoint(0, SaboteurFinalPos4[0], SaboteurFinalPos4[1], SaboteurFinalPos4[2], 0);
                    me->SetHomePosition(SaboteurFinalPos4[0], SaboteurFinalPos4[1], SaboteurFinalPos4[2], 3.991108f);
                    break;
                case BOSS_XEVOZZ:
                    AddWaypoint(0, SaboteurFinalPos5[0], SaboteurFinalPos5[1], SaboteurFinalPos5[2], 0);
                    me->SetHomePosition(SaboteurFinalPos5[0], SaboteurFinalPos5[1], SaboteurFinalPos5[2], 1.100841f);
                    break;
                case BOSS_ZURAMAT:
                    for (int i = 0; i < 5; i++)
                        AddWaypoint(i, SaboteurFinalPos6[i][0], SaboteurFinalPos6[i][1], SaboteurFinalPos6[i][2], 0);
                    me->SetHomePosition(SaboteurFinalPos6[4][0], SaboteurFinalPos6[4][1], SaboteurFinalPos6[4][2], 0.983031f);
                    break;
            }
            SetDespawnAtEnd(false);
            Start(true);
        }

        if (_isOpening)
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case EVENT_SABOTEUR_SHIELD_DISRUPTION:
                    DoCastSelf(SABOTEUR_SHIELD_DISRUPTION);
                    ++_count;
                    if (_count < 3)
                        _events.RescheduleEvent(EVENT_SABOTEUR_SHIELD_DISRUPTION, 1s);
                    else
                    {
                        _instance->DoAction(ACTION_RELEASE_BOSS);
                        _events.RescheduleEvent(EVENT_SABOTEUR_DISAPPEAR, 500ms);
                    }
                    break;
                case EVENT_SABOTEUR_DISAPPEAR:
                    _isOpening = false;
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->SetDisplayId(11686);
                    DoCastSelf(SPELL_TELEPORT_VISUAL, true);
                    me->DespawnOrUnsummon(1s);
                    break;
            }
        }
    }

    void FinishPointReached()
    {
        _isOpening = true;
        _count = 1;
        DoCastSelf(SABOTEUR_SHIELD_DISRUPTION);
        _events.RescheduleEvent(EVENT_SABOTEUR_SHIELD_DISRUPTION, 1s);
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

private:
    InstanceScript* _instance;
    bool _addedWaypoints;
    uint8 _boss;
    bool _isOpening;
    EventMap _events;
    uint8 _count;
};

/***********
** DESTROY DOOR SEAL SPELL SCRIPT
***********/

class spell_destroy_door_seal_aura : public AuraScript
{
    PrepareAuraScript(spell_destroy_door_seal_aura);

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* target = GetTarget())
            if (InstanceScript* Instance = target->GetInstanceScript())
                Instance->DoAction(ACTION_DECREASE_DOOR_HEALTH);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_destroy_door_seal_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

struct npc_violet_hold_defense_system : public ScriptedAI
{
    npc_violet_hold_defense_system(Creature* creature) : ScriptedAI(creature)
    {
        _tickCount = 0;
    }

    void Reset() override
    {
        _tickCount = 0;
        DoCast(RAND(SPELL_DEFENSE_SYSTEM_SPAWN_EFFECT, SPELL_DEFENSE_SYSTEM_VISUAL));
        events.ScheduleEvent(EVENT_ARCANE_LIGHTNING, 4s);
        me->DespawnOrUnsummon(7s, 0s);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (events.ExecuteEvent() == EVENT_ARCANE_LIGHTNING)
        {
            DoCastAOE(SPELL_ARCANE_LIGHTNING);
            DoCastAOE(SPELL_ARCANE_LIGHTNING_VISUAL);

            if (++_tickCount >= 3)
                DoCastAOE(SPELL_ARCANE_LIGHTNING_INSTAKILL);
            else
                events.Repeat(1s);
        }
    }

private:
    uint8 _tickCount;
};

void AddSC_violet_hold()
{
    RegisterVioletHoldCreatureAI(npc_vh_teleportation_portal);
    RegisterVioletHoldCreatureAI(npc_azure_saboteur);

    RegisterVioletHoldCreatureAI(npc_azure_invader);
    RegisterVioletHoldCreatureAI(npc_azure_spellbreaker);
    RegisterVioletHoldCreatureAI(npc_azure_binder);
    RegisterVioletHoldCreatureAI(npc_azure_mage_slayer);
    RegisterVioletHoldCreatureAI(npc_azure_captain);
    RegisterVioletHoldCreatureAI(npc_azure_sorceror);
    RegisterVioletHoldCreatureAI(npc_azure_raider);
    RegisterVioletHoldCreatureAI(npc_azure_stalker);

    RegisterSpellScript(spell_destroy_door_seal_aura);
    RegisterCreatureAI(npc_violet_hold_defense_system);
}
