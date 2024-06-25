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
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "violet_hold.h"

/// @todo: Missing Sinclari Trigger announcements (32204) Look at its creature_text for more info.
/// @todo: Activation Crystals (go_vh_activation_crystal) (193611) are spammable, should be a 1 time use per crystal.

enum Texts
{
    GOSSIP_MENU_START_EVENT     = 9998,
    GOSSIP_MENU_ITEM            = 9997,
    GOSSIP_MENU_LATE_JOIN       = 10275,

    NPC_TEXT_SINCLARI_IN        = 13853,
    NPC_TEXT_SINCLARI_ITEM      = 13854,
    NPC_TEXT_SINCLARI_DONE      = 13910,
    NPC_TEXT_SINCLARI_LATE_JOIN = 14271,
};

/***********
** DEFENSE SYSTEM CRYSTAL
***********/

class go_vh_activation_crystal : public GameObjectScript
{
public:
    go_vh_activation_crystal() : GameObjectScript("go_vh_activation_crystal") { }

    bool OnGossipHello(Player*  /*player*/, GameObject* go) override
    {
        if (InstanceScript* pInstance = go->GetInstanceScript())
            pInstance->SetData(DATA_ACTIVATE_DEFENSE_SYSTEM, 1);
        return true;
    }
};

/***********
** SINCLARI
***********/

class npc_vh_sinclari : public CreatureScript
{
public:
    npc_vh_sinclari() : CreatureScript("npc_vh_sinclari") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (InstanceScript* pInstance = creature->GetInstanceScript())
            switch (pInstance->GetData(DATA_ENCOUNTER_STATUS))
            {
                case NOT_STARTED:
                    AddGossipItemFor(player, GOSSIP_MENU_ITEM, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                    AddGossipItemFor(player, GOSSIP_MENU_START_EVENT, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    SendGossipMenuFor(player, NPC_TEXT_SINCLARI_IN, creature->GetGUID());
                    break;
                case IN_PROGRESS:
                    AddGossipItemFor(player, GOSSIP_MENU_LATE_JOIN, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    SendGossipMenuFor(player, NPC_TEXT_SINCLARI_LATE_JOIN, creature->GetGUID());
                    break;
                default: // DONE or invalid
                    SendGossipMenuFor(player, NPC_TEXT_SINCLARI_DONE, creature->GetGUID());
            }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);

        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                CloseGossipMenuFor(player);
                if (InstanceScript* pInstance = creature->GetInstanceScript())
                    pInstance->SetData(DATA_START_INSTANCE, 1);
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                SendGossipMenuFor(player, NPC_TEXT_SINCLARI_ITEM, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->NearTeleportTo(playerTeleportPosition.GetPositionX(), playerTeleportPosition.GetPositionY(), playerTeleportPosition.GetPositionZ(), playerTeleportPosition.GetOrientation(), true);
                CloseGossipMenuFor(player);
                break;
        }
        return true;
    }
};

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

class npc_vh_teleportation_portal : public CreatureScript
{
public:
    npc_vh_teleportation_portal() : CreatureScript("npc_vh_teleportation_portal") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_vh_teleportation_portalAI>(creature);
    }

    struct npc_vh_teleportation_portalAI : public NullCreatureAI
    {
        npc_vh_teleportation_portalAI(Creature* c) : NullCreatureAI(c), listOfMobs(me)
        {
            pInstance = c->GetInstanceScript();
            events.Reset();
            if (pInstance)
            {
                wave = pInstance->GetData(DATA_WAVE_COUNT);
                bKorG = false;
                spawned = false;

                if (wave < 12)
                    addValue = 0;
                else
                    addValue = 1;

                if (wave % 6 != 0)
                    events.RescheduleEvent(RAND(EVENT_SUMMON_KEEPER_OR_GUARDIAN, EVENT_SUMMON_ELITES), 10s);
                else
                    events.RescheduleEvent(EVENT_SUMMON_SABOTEOUR, 3s);
            }
        }

        InstanceScript* pInstance;
        SummonList listOfMobs;
        EventMap events;
        uint8 wave;
        uint8 addValue;
        bool bKorG;
        bool spawned;

        void UpdateAI(uint32 diff) override
        {
            if (!pInstance)
                return;

            events.Update(diff);

            switch(events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SUMMON_KEEPER_OR_GUARDIAN:
                    bKorG = true;
                    spawned = true;
                    if (Creature* c = DoSummon(RAND(NPC_PORTAL_GUARDIAN, NPC_PORTAL_KEEPER), me, 2.0f, 0, TEMPSUMMON_DEAD_DESPAWN))
                        me->CastSpell(c, SPELL_PORTAL_CHANNEL, false);
                    events.RescheduleEvent(EVENT_SUMMON_KEEPER_TRASH, 20s);
                    break;
                case EVENT_SUMMON_KEEPER_TRASH:
                    for (uint8 i = 0; i < 3 + addValue; ++i)
                    {
                        uint32 entry = RAND(NPC_AZURE_INVADER_1, NPC_AZURE_INVADER_2, NPC_AZURE_SPELLBREAKER_1, NPC_AZURE_SPELLBREAKER_2, NPC_AZURE_MAGE_SLAYER_1, NPC_AZURE_MAGE_SLAYER_2, NPC_AZURE_BINDER_1, NPC_AZURE_BINDER_2);
                        DoSummon(entry, me, 2.0f, 20000, TEMPSUMMON_DEAD_DESPAWN);
                    }
                    events.Repeat(20s);
                    break;
                case EVENT_SUMMON_ELITES:
                    spawned = true;
                    for (uint8 i = 0; i < 2 + addValue; ++i)
                    {
                        uint32 entry = RAND(NPC_AZURE_CAPTAIN, NPC_AZURE_RAIDER, NPC_AZURE_STALKER, NPC_AZURE_SORCEROR);
                        DoSummon(entry, me, 2.0f, 20000, TEMPSUMMON_DEAD_DESPAWN);
                    }
                    me->SetVisible(false);
                    break;
                case EVENT_SUMMON_SABOTEOUR:
                    DoSummon(NPC_SABOTEOUR, me, 2.0f, 0, TEMPSUMMON_CORPSE_DESPAWN);
                    me->DespawnOrUnsummon(3000);
                    break;
            }

            if (!spawned)
                return;

            if (bKorG)
            {
                if (!me->IsNonMeleeSpellCast(false)) // keeper/guardian died => channeled spell interrupted
                {
                    // if keeper/guard lost all victims, in enterevademode linking aura is removed, restore it:
                    if (pInstance)
                        for (SummonList::iterator itr = listOfMobs.begin(); itr != listOfMobs.end(); ++itr)
                            if (Creature* c = pInstance->instance->GetCreature(*itr))
                                if (c->IsAlive() && (c->GetEntry() == NPC_PORTAL_GUARDIAN || c->GetEntry() == NPC_PORTAL_KEEPER))
                                {
                                    me->CastSpell(c, SPELL_PORTAL_CHANNEL, false);
                                    return;
                                }
                    Unit::Kill(me, me, false);
                }
            }
            else
            {
                if (listOfMobs.empty())
                    Unit::Kill(me, me, false);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            events.Reset();
            if (wave % 6 == 0) // just to be sure, shouln't occur
                return;
            if (pInstance)
                pInstance->SetData(DATA_PORTAL_DEFEATED, 0);
        }

        void JustSummoned(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                listOfMobs.Summon(pSummoned);
                pInstance->SetGuidData(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void SummonedMobDied(Creature* pSummoned)
        {
            if (pSummoned)
            {
                listOfMobs.Despawn(pSummoned);
                pInstance->SetGuidData(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
            }
        }
    };
};

/***********
** GENERAL TRASH AI
***********/

struct violet_hold_trashAI : public npc_escortAI
{
    violet_hold_trashAI(Creature* c) : npc_escortAI(c)
    {
        pInstance = c->GetInstanceScript();
        if (pInstance)
            PLoc = pInstance->GetData(DATA_PORTAL_LOCATION);
        bAddedWP = false;
        bAlt = false;
    }

    InstanceScript* pInstance;
    bool bAddedWP;
    uint32 PLoc;
    bool bAlt;

    void ClearDoorSealAura()
    {
        if (pInstance)
            if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_DOOR_SEAL_GUID)))
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

    void WaypointReached(uint32 id) override
    {
        if (PLoc < 6)
            if (id == uint16(PLocWPCount[PLoc] - 1 - (bAlt ? 1 : 0)))
                CreatureStartAttackDoor();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!bAddedWP)
        {
            bAddedWP = true;
            switch(PLoc)
            {
                case 0:
                    for(int i = 0; i < 6; i++)
                        AddWaypoint(i, FirstPortalTrashWPs[i][0] + irand(-1, 1), FirstPortalTrashWPs[i][1] + irand(-1, 1), FirstPortalTrashWPs[i][2] + irand(-1, 1), 0);
                    me->SetHomePosition(FirstPortalTrashWPs[5][0], FirstPortalTrashWPs[5][1], FirstPortalTrashWPs[5][2], 3.149439f);
                    break;
                case 1:
                    bAlt = (bool)urand(0, 1);
                    if (!bAlt)
                    {
                        for(int i = 0; i < 9; i++)
                            AddWaypoint(i, SecondPortalTrashWPs1[i][0] + irand(-1, 1), SecondPortalTrashWPs1[i][1] + irand(-1, 1), SecondPortalTrashWPs1[i][2], 0);
                        me->SetHomePosition(SecondPortalTrashWPs1[8][0] + irand(-1, 1), SecondPortalTrashWPs1[8][1] + irand(-1, 1), SecondPortalTrashWPs1[8][2] + irand(-1, 1), 3.149439f);
                    }
                    else
                    {
                        for(int i = 0; i < 8; i++)
                            AddWaypoint(i, SecondPortalTrashWPs2[i][0] + irand(-1, 1), SecondPortalTrashWPs2[i][1] + irand(-1, 1), SecondPortalTrashWPs2[i][2], 0);
                        me->SetHomePosition(SecondPortalTrashWPs2[7][0], SecondPortalTrashWPs2[7][1], SecondPortalTrashWPs2[7][2], 3.149439f);
                    }
                    break;
                case 2:
                    for(int i = 0; i < 8; i++)
                        AddWaypoint(i, ThirdPortalTrashWPs[i][0] + irand(-1, 1), ThirdPortalTrashWPs[i][1] + irand(-1, 1), ThirdPortalTrashWPs[i][2], 0);
                    me->SetHomePosition(ThirdPortalTrashWPs[7][0], ThirdPortalTrashWPs[7][1], ThirdPortalTrashWPs[7][2], 3.149439f);
                    break;
                case 3:
                    for(int i = 0; i < 9; i++)
                        AddWaypoint(i, FourthPortalTrashWPs[i][0] + irand(-1, 1), FourthPortalTrashWPs[i][1] + irand(-1, 1), FourthPortalTrashWPs[i][2], 0);
                    me->SetHomePosition(FourthPortalTrashWPs[8][0], FourthPortalTrashWPs[8][1], FourthPortalTrashWPs[8][2], 3.149439f);
                    break;
                case 4:
                    for(int i = 0; i < 6; i++)
                        AddWaypoint(i, FifthPortalTrashWPs[i][0] + irand(-1, 1), FifthPortalTrashWPs[i][1] + irand(-1, 1), FifthPortalTrashWPs[i][2], 0);
                    me->SetHomePosition(FifthPortalTrashWPs[5][0], FifthPortalTrashWPs[5][1], FifthPortalTrashWPs[5][2], 3.149439f);
                    break;
                case 5:
                    for(int i = 0; i < 4; i++)
                        AddWaypoint(i, SixthPoralTrashWPs[i][0] + irand(-1, 1), SixthPoralTrashWPs[i][1] + irand(-1, 1), SixthPoralTrashWPs[i][2], 0);
                    me->SetHomePosition(SixthPoralTrashWPs[3][0], SixthPoralTrashWPs[3][1], SixthPoralTrashWPs[3][2], 3.149439f);
                    break;
            }
            SetDespawnAtEnd(false);
            Start(true, true);
        }

        npc_escortAI::UpdateAI(diff);
    }

    void JustDied(Unit* /*unit*/) override
    {
        if (pInstance)
            if (Creature* portal = ObjectAccessor::GetCreature((*me), pInstance->GetGuidData(DATA_TELEPORTATION_PORTAL_GUID)))
                CAST_AI(npc_vh_teleportation_portal::npc_vh_teleportation_portalAI, portal->AI())->SummonedMobDied(me);
    }

    void CreatureStartAttackDoor()
    {
        RemoveEscortState(STATE_ESCORT_ESCORTING | STATE_ESCORT_RETURNING | STATE_ESCORT_PAUSED);
        me->SetImmuneToNPC(true);
        me->CastSpell((Unit*)nullptr, SPELL_DESTROY_DOOR_SEAL, true);
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
};

/***********
** TRASH SPELLS
***********/

enum AzureInvaderSpells
{
    SPELL_CLEAVE = 15496,
    SPELL_IMPALE_N = 58459,
    SPELL_IMPALE_H = 59256,
    SPELL_BRUTAL_STRIKE = 58460,
    SPELL_SUNDER_ARMOR = 58461,
};
#define SPELL_IMPALE                DUNGEON_MODE(SPELL_IMPALE_N, SPELL_IMPALE_H)

enum AzureSpellbreakerSpells
{
    SPELL_ARCANE_BLAST_N = 58462,
    SPELL_ARCANE_BLAST_H = 59257,
    SPELL_SLOW = 25603,
    SPELL_CHAINS_OF_ICE = 58464,
    SPELL_CONE_OF_COLD_N = 58463,
    SPELL_CONE_OF_COLD_H = 59258
};
#define SPELL_ARCANE_BLAST          DUNGEON_MODE(SPELL_ARCANE_BLAST_N, SPELL_ARCANE_BLAST_H)
#define SPELL_CONE_OF_COLD          DUNGEON_MODE(SPELL_CONE_OF_COLD_N, SPELL_CONE_OF_COLD_H)

enum AzureBinderSpells
{
    SPELL_ARCANE_BARRAGE_N = 58456,
    SPELL_ARCANE_BARRAGE_H = 59248,
    SPELL_ARCANE_EXPLOSION_N = 58455,
    SPELL_ARCANE_EXPLOSION_H = 59245,
    SPELL_FROST_NOVA_N = 58458,
    SPELL_FROST_NOVA_H = 59253,
    SPELL_FROSTBOLT_N = 58457,
    SPELL_FROSTBOLT_H = 59251,
};
#define SPELL_ARCANE_BARRAGE        DUNGEON_MODE(SPELL_ARCANE_BARRAGE_N, SPELL_ARCANE_BARRAGE_H)
#define SPELL_ARCANE_EXPLOSION      DUNGEON_MODE(SPELL_ARCANE_EXPLOSION_N, SPELL_ARCANE_EXPLOSION_H)
#define SPELL_FROST_NOVA            DUNGEON_MODE(SPELL_FROST_NOVA_N, SPELL_FROST_NOVA_H)
#define SPELL_FROSTBOLT             DUNGEON_MODE(SPELL_FROSTBOLT_N, SPELL_FROSTBOLT_H)

enum AzureMageSlayerSpells
{
    SPELL_ARCANE_EMPOWERMENT = 58469,
    SPELL_SPELL_LOCK = 30849
};

enum AzureCaptainSpells
{
    SPELL_MORTAL_STRIKE = 32736,
    SPELL_WHIRLWIND_OF_STEEL = 41056
};

enum AzureSorcerorSpells
{
    SPELL_ARCANE_STREAM_N = 60181,
    SPELL_ARCANE_STREAM_H = 60204,
    SPELL_MANA_DETONATION_N = 60182,
    SPELL_MANA_DETONATION_H = 60205
};
#define SPELL_ARCANE_STREAM         DUNGEON_MODE(SPELL_ARCANE_STREAM_N, SPELL_ARCANE_STREAM_H)
#define SPELL_MANA_DETONATION       DUNGEON_MODE(SPELL_MANA_DETONATION_N, SPELL_MANA_DETONATION_H)

enum AzureRaiderSpells
{
    SPELL_CONCUSSION_BLOW = 52719,
    SPELL_MAGIC_REFLECTION = 60158
};

enum AzureStalkerSpells
{
    SPELL_BACKSTAB = 58471,
    SPELL_TACTICAL_BLINK = 58470
};

/***********
** TRASH
***********/

class npc_azure_invader : public CreatureScript
{
public:
    npc_azure_invader() : CreatureScript("npc_azure_invader") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_invaderAI>(creature);
    }

    struct npc_azure_invaderAI : public violet_hold_trashAI
    {
        npc_azure_invaderAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiCleaveTimer;
        uint32 uiImpaleTimer;
        uint32 uiBrutalStrikeTimer;
        uint32 uiSunderArmorTimer;

        void Reset() override
        {
            uiCleaveTimer = 5000;
            uiImpaleTimer = 4000;
            uiBrutalStrikeTimer = 5000;
            uiSunderArmorTimer = 4000;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (me->GetEntry() == NPC_AZURE_INVADER_1)
            {
                if (uiCleaveTimer <= diff)
                {
                    DoCast(me->GetVictim(), SPELL_CLEAVE);
                    uiCleaveTimer = 5000;
                }
                else uiCleaveTimer -= diff;

                if (uiImpaleTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 5.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_IMPALE);
                    uiImpaleTimer = 4000;
                }
                else uiImpaleTimer -= diff;
            }

            if (me->GetEntry() == NPC_AZURE_INVADER_2)
            {
                if (uiBrutalStrikeTimer <= diff)
                {
                    DoCast(me->GetVictim(), SPELL_BRUTAL_STRIKE);
                    uiBrutalStrikeTimer = 5000;
                }
                else uiBrutalStrikeTimer -= diff;

                if (uiSunderArmorTimer <= diff)
                {
                    DoCast(me->GetVictim(), SPELL_SUNDER_ARMOR);
                    uiSunderArmorTimer = urand(8000, 10000);
                }
                else uiSunderArmorTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_azure_binder : public CreatureScript
{
public:
    npc_azure_binder() : CreatureScript("npc_azure_binder") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_binderAI>(creature);
    }

    struct npc_azure_binderAI : public violet_hold_trashAI
    {
        npc_azure_binderAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiArcaneExplosionTimer;
        uint32 uiArcainBarrageTimer;
        uint32 uiFrostNovaTimer;
        uint32 uiFrostboltTimer;

        void Reset() override
        {
            uiArcaneExplosionTimer = 5000;
            uiArcainBarrageTimer = 4000;
            uiFrostNovaTimer = 5000;
            uiFrostboltTimer = 4000;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (me->GetEntry() == NPC_AZURE_BINDER_1)
            {
                if (uiArcaneExplosionTimer <= diff)
                {
                    DoCast(SPELL_ARCANE_EXPLOSION);
                    uiArcaneExplosionTimer = 5000;
                }
                else uiArcaneExplosionTimer -= diff;

                if (uiArcainBarrageTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_ARCANE_BARRAGE);
                    uiArcainBarrageTimer = 6000;
                }
                else uiArcainBarrageTimer -= diff;
            }

            if (me->GetEntry() == NPC_AZURE_BINDER_2)
            {
                if (uiFrostNovaTimer <= diff)
                {
                    DoCast(SPELL_FROST_NOVA);
                    uiFrostNovaTimer = 5000;
                }
                else uiFrostNovaTimer -= diff;

                if (uiFrostboltTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_FROSTBOLT);
                    uiFrostboltTimer = 6000;
                }
                else uiFrostboltTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_azure_mage_slayer : public CreatureScript
{
public:
    npc_azure_mage_slayer() : CreatureScript("npc_azure_mage_slayer") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_mage_slayerAI>(creature);
    }

    struct npc_azure_mage_slayerAI : public violet_hold_trashAI
    {
        npc_azure_mage_slayerAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiArcaneEmpowermentTimer;
        uint32 uiSpellLockTimer;

        void Reset() override
        {
            uiArcaneEmpowermentTimer = 5000;
            uiSpellLockTimer = 5000;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (me->GetEntry() == NPC_AZURE_MAGE_SLAYER_1)
            {
                if (uiArcaneEmpowermentTimer <= diff)
                {
                    DoCast(me, SPELL_ARCANE_EMPOWERMENT);
                    uiArcaneEmpowermentTimer = 14000;
                }
                else uiArcaneEmpowermentTimer -= diff;
            }

            if (me->GetEntry() == NPC_AZURE_MAGE_SLAYER_2)
            {
                if (uiSpellLockTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_SPELL_LOCK);
                    uiSpellLockTimer = 9000;
                }
                else uiSpellLockTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_azure_raider : public CreatureScript
{
public:
    npc_azure_raider() : CreatureScript("npc_azure_raider") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_raiderAI> (creature);
    }

    struct npc_azure_raiderAI : public violet_hold_trashAI
    {
        npc_azure_raiderAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiConcussionBlowTimer;
        uint32 uiMagicReflectionTimer;

        void Reset() override
        {
            uiConcussionBlowTimer = 5000;
            uiMagicReflectionTimer = 8000;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (uiConcussionBlowTimer <= diff)
            {
                DoCast(me->GetVictim(), SPELL_CONCUSSION_BLOW);
                uiConcussionBlowTimer = 5000;
            }
            else uiConcussionBlowTimer -= diff;

            if (uiMagicReflectionTimer <= diff)
            {
                DoCast(SPELL_MAGIC_REFLECTION);
                uiMagicReflectionTimer = urand(10000, 15000);
            }
            else uiMagicReflectionTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class npc_azure_stalker : public CreatureScript
{
public:
    npc_azure_stalker() : CreatureScript("npc_azure_stalker") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_stalkerAI>(creature);
    }

    struct npc_azure_stalkerAI : public violet_hold_trashAI
    {
        npc_azure_stalkerAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiBackstabTimer;
        uint32 uiTacticalBlinkTimer;
        bool TacticalBlinkCasted;

        void Reset() override
        {
            uiBackstabTimer = 1300;
            uiTacticalBlinkTimer = 8000;
            TacticalBlinkCasted = false;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            /*if (!TacticalBlinkCasted)
            {
                if (uiTacticalBlinkTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_TACTICAL_BLINK);
                    uiTacticalBlinkTimer = 10000;
                    TacticalBlinkCasted = true;
                } else uiTacticalBlinkTimer -= diff;
            }

            else*/
            {
                if (uiBackstabTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::MaxDistance, 0, 5.0f, true);
                    if (pTarget && !pTarget->HasInArc(M_PI, me))
                        DoCast(pTarget, SPELL_BACKSTAB);
                    TacticalBlinkCasted = false;
                    uiBackstabTimer = 4000;
                }
                else uiBackstabTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_azure_spellbreaker : public CreatureScript
{
public:
    npc_azure_spellbreaker() : CreatureScript("npc_azure_spellbreaker") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_spellbreakerAI>(creature);
    }

    struct npc_azure_spellbreakerAI : public violet_hold_trashAI
    {
        npc_azure_spellbreakerAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiArcaneBlastTimer;
        uint32 uiSlowTimer;
        uint32 uiChainsOfIceTimer;
        uint32 uiConeOfColdTimer;

        void Reset() override
        {
            uiArcaneBlastTimer = 5000;
            uiSlowTimer = 4000;
            uiChainsOfIceTimer = 5000;
            uiConeOfColdTimer = 4000;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (me->GetEntry() == NPC_AZURE_SPELLBREAKER_1)
            {
                if (uiArcaneBlastTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_ARCANE_BLAST);
                    uiArcaneBlastTimer = 6000;
                }
                else uiArcaneBlastTimer -= diff;

                if (uiSlowTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_SLOW);
                    uiSlowTimer = 5000;
                }
                else uiSlowTimer -= diff;
            }

            if (me->GetEntry() == NPC_AZURE_SPELLBREAKER_2)
            {
                if (uiChainsOfIceTimer <= diff)
                {
                    Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true);
                    if (pTarget)
                        DoCast(pTarget, SPELL_CHAINS_OF_ICE);
                    uiChainsOfIceTimer = 7000;
                }
                else uiChainsOfIceTimer -= diff;

                if (uiConeOfColdTimer <= diff)
                {
                    DoCast(SPELL_CONE_OF_COLD);
                    uiConeOfColdTimer = 5000;
                }
                else uiConeOfColdTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_azure_captain : public CreatureScript
{
public:
    npc_azure_captain() : CreatureScript("npc_azure_captain") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_captainAI>(creature);
    }

    struct  npc_azure_captainAI : public violet_hold_trashAI
    {
        npc_azure_captainAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiMortalStrikeTimer;
        uint32 uiWhirlwindTimer;

        void Reset() override
        {
            uiMortalStrikeTimer = 5000;
            uiWhirlwindTimer = 8000;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (uiMortalStrikeTimer <= diff)
            {
                DoCast(me->GetVictim(), SPELL_MORTAL_STRIKE);
                uiMortalStrikeTimer = 5000;
            }
            else uiMortalStrikeTimer -= diff;

            if (uiWhirlwindTimer <= diff)
            {
                DoCastAOE(SPELL_WHIRLWIND_OF_STEEL);
                uiWhirlwindTimer = 8000;
            }
            else uiWhirlwindTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class npc_azure_sorceror : public CreatureScript
{
public:
    npc_azure_sorceror() : CreatureScript("npc_azure_sorceror") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_sorcerorAI>(creature);
    }

    struct  npc_azure_sorcerorAI : public violet_hold_trashAI
    {
        npc_azure_sorcerorAI(Creature* c) : violet_hold_trashAI(c) {}

        uint32 uiArcaneStreamTimer;
        uint32 uiArcaneStreamTimerStartingValueHolder;
        uint32 uiManaDetonationTimer;

        void Reset() override
        {
            uiArcaneStreamTimer = 4000;
            uiArcaneStreamTimerStartingValueHolder = uiArcaneStreamTimer;
            uiManaDetonationTimer = 5000;
        }

        void UpdateAI(uint32 diff) override
        {
            violet_hold_trashAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (uiArcaneStreamTimer <= diff)
            {
                Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 35.0f, true);
                if (pTarget)
                    DoCast(pTarget, SPELL_ARCANE_STREAM);
                uiArcaneStreamTimer = urand(0, 5000) + 5000;
                uiArcaneStreamTimerStartingValueHolder = uiArcaneStreamTimer;
            }
            else uiArcaneStreamTimer -= diff;

            if (uiManaDetonationTimer <= diff && uiArcaneStreamTimer >= 1500 && uiArcaneStreamTimer <= uiArcaneStreamTimerStartingValueHolder / 2)
            {
                DoCastAOE(SPELL_MANA_DETONATION);
                uiManaDetonationTimer = urand(2000, 6000);
            }
            else uiManaDetonationTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
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

class npc_azure_saboteur : public CreatureScript
{
public:
    npc_azure_saboteur() : CreatureScript("npc_azure_saboteur") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVioletHoldAI<npc_azure_saboteurAI>(creature);
    }

    struct npc_azure_saboteurAI : public npc_escortAI
    {
        npc_azure_saboteurAI(Creature* c) : npc_escortAI(c)
        {
            pInstance = c->GetInstanceScript();
            uiBoss = 0;
            if (pInstance)
                uiBoss = pInstance->GetData(DATA_WAVE_COUNT) == 6 ? pInstance->GetData(DATA_FIRST_BOSS_NUMBER) : pInstance->GetData(DATA_SECOND_BOSS_NUMBER);
            bAddedWPs = false;
            bOpening = false;
        }

        InstanceScript* pInstance;
        bool bAddedWPs;
        uint8 uiBoss;
        bool bOpening;
        uint32 timer;
        uint8 count;

        void WaypointReached(uint32 uiWPointId) override
        {
            if (!pInstance)
                return;

            switch(uiBoss)
            {
                case 1:
                    if(uiWPointId == 2)
                        FinishPointReached();
                    break;
                case 2:
                    if(uiWPointId == 2)
                        FinishPointReached();
                    break;
                case 3:
                    if(uiWPointId == 1)
                        FinishPointReached();
                    break;
                case 4:
                    if(uiWPointId == 0)
                        FinishPointReached();
                    break;
                case 5:
                    if(uiWPointId == 0)
                        FinishPointReached();
                    break;
                case 6:
                    if(uiWPointId == 4)
                        FinishPointReached();
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if(!bAddedWPs)
            {
                bAddedWPs = true;
                switch(uiBoss)
                {
                    case 1:
                        for(int i = 0; i < 3; i++)
                            AddWaypoint(i, SaboteurFinalPos1[i][0], SaboteurFinalPos1[i][1], SaboteurFinalPos1[i][2], 0);
                        me->SetHomePosition(SaboteurFinalPos1[2][0], SaboteurFinalPos1[2][1], SaboteurFinalPos1[2][2], 4.762346f);
                        break;
                    case 2:
                        for(int i = 0; i < 3; i++)
                            AddWaypoint(i, SaboteurFinalPos2[i][0], SaboteurFinalPos2[i][1], SaboteurFinalPos2[i][2], 0);
                        me->SetHomePosition(SaboteurFinalPos2[2][0], SaboteurFinalPos2[2][1], SaboteurFinalPos2[2][2], 1.862674f);
                        break;
                    case 3:
                        for(int i = 0; i < 2; i++)
                            AddWaypoint(i, SaboteurFinalPos3[i][0], SaboteurFinalPos3[i][1], SaboteurFinalPos3[i][2], 0);
                        me->SetHomePosition(SaboteurFinalPos3[1][0], SaboteurFinalPos3[1][1], SaboteurFinalPos3[1][2], 5.500638f);
                        break;
                    case 4:
                        AddWaypoint(0, SaboteurFinalPos4[0], SaboteurFinalPos4[1], SaboteurFinalPos4[2], 0);
                        me->SetHomePosition(SaboteurFinalPos4[0], SaboteurFinalPos4[1], SaboteurFinalPos4[2], 3.991108f);
                        break;
                    case 5:
                        AddWaypoint(0, SaboteurFinalPos5[0], SaboteurFinalPos5[1], SaboteurFinalPos5[2], 0);
                        me->SetHomePosition(SaboteurFinalPos5[0], SaboteurFinalPos5[1], SaboteurFinalPos5[2], 1.100841f);
                        break;
                    case 6:
                        for(int i = 0; i < 5; i++)
                            AddWaypoint(i, SaboteurFinalPos6[i][0], SaboteurFinalPos6[i][1], SaboteurFinalPos6[i][2], 0);
                        me->SetHomePosition(SaboteurFinalPos6[4][0], SaboteurFinalPos6[4][1], SaboteurFinalPos6[4][2], 0.983031f);
                        break;
                }
                SetDespawnAtEnd(false);
                Start(true, true);
            }

            if (bOpening)
            {
                if (timer <= diff)
                {
                    if (count < 2)
                    {
                        me->CastSpell(me, SABOTEUR_SHIELD_DISRUPTION, false);
                        timer = 1000;
                    }
                    else if (count == 2)
                    {
                        me->CastSpell(me, SABOTEUR_SHIELD_DISRUPTION, false);
                        if (pInstance)
                            pInstance->SetData(DATA_RELEASE_BOSS, 0);
                        timer = 500;
                    }
                    else
                    {
                        bOpening = false;
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->SetDisplayId(11686);
                        me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                        me->DespawnOrUnsummon(1000);
                    }
                    ++count;
                }
                else timer -= diff;
            }
        }

        void FinishPointReached()
        {
            bOpening = true;
            timer = 1000;
            count = 0;
            me->CastSpell(me, SABOTEUR_SHIELD_DISRUPTION, false);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}
    };
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
            if (InstanceScript* pInstance = target->GetInstanceScript())
                pInstance->SetData(DATA_DECRASE_DOOR_HEALTH, 0);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_destroy_door_seal_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

struct npc_violet_hold_defense_system : public ScriptedAI
{
    npc_violet_hold_defense_system(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        DoCast(RAND(SPELL_DEFENSE_SYSTEM_SPAWN_EFFECT, SPELL_DEFENSE_SYSTEM_VISUAL));
        events.ScheduleEvent(EVENT_ARCANE_LIGHTNING, 4s);
        events.ScheduleEvent(EVENT_ARCANE_LIGHTNING_INSTAKILL, 4s);
        me->DespawnOrUnsummon(7s, 0s);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        switch (events.ExecuteEvent())
        {
            case EVENT_ARCANE_LIGHTNING:
                DoCastAOE(RAND(SPELL_ARCANE_LIGHTNING, SPELL_ARCANE_LIGHTNING_VISUAL));
                events.RepeatEvent(2000);
                break;
            case EVENT_ARCANE_LIGHTNING_INSTAKILL:
                DoCastAOE(SPELL_ARCANE_LIGHTNING_INSTAKILL);
                events.RepeatEvent(1000);
                break;
        }
    }
};

void AddSC_violet_hold()
{
    new go_vh_activation_crystal();
    new npc_vh_sinclari();
    new npc_vh_teleportation_portal();
    new npc_azure_saboteur();

    new npc_azure_invader();
    new npc_azure_spellbreaker();
    new npc_azure_binder();
    new npc_azure_mage_slayer();
    new npc_azure_captain();
    new npc_azure_sorceror();
    new npc_azure_raider();
    new npc_azure_stalker();

    RegisterSpellScript(spell_destroy_door_seal_aura);
    RegisterCreatureAI(npc_violet_hold_defense_system);
}
