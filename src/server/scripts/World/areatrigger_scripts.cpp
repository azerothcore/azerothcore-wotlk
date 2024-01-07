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
#include "GameTime.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellMgr.h"
/* ScriptData
SDName: Areatrigger_Scripts
SD%Complete: 100
SDComment: Scripts for areatriggers
SDCategory: Areatrigger
EndScriptData */

/* ContentData
at_coilfang_waterfall           4591
at_legion_teleporter            4560 Teleporter TO Invasion Point: Cataclysm
at_stormwright_shelf            q12741
at_last_rites                   q12019
at_sholazar_waygate             q12548
at_nats_landing                 q11209
at_bring_your_orphan_to         q910 q910 q1800 q1479 q1687 q1558 q10951 q10952
at_brewfest
at_area_52_entrance
EndContentData */

// Ours
class AreaTrigger_at_voltarus_middle : public AreaTriggerScript
{
public:
    AreaTrigger_at_voltarus_middle()
        : AreaTriggerScript("at_voltarus_middle")
    {
    }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (player->IsAlive() && !player->IsInCombat())
            if (player->HasItemCount(39319)) // Scepter of Domination
            {
                player->TeleportTo(571, 6242.67f, -1972.10f, 484.783f, 0.6f);
                return true;
            }

        return false;
    }
};

// Theirs
/*######
## at_coilfang_waterfall
######*/

enum CoilfangGOs
{
    GO_COILFANG_WATERFALL   = 184212
};

class AreaTrigger_at_coilfang_waterfall : public AreaTriggerScript
{
public:
    AreaTrigger_at_coilfang_waterfall()
        : AreaTriggerScript("at_coilfang_waterfall")
    {
    }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (GameObject* go = GetClosestGameObjectWithEntry(player, GO_COILFANG_WATERFALL, 35.0f))
            if (go->getLootState() == GO_READY)
                go->UseDoorOrButton();

        return false;
    }
};

/*#####
## at_legion_teleporter
#####*/

enum LegionTeleporter
{
    SPELL_TELE_A_TO         = 37387,
    QUEST_GAINING_ACCESS_A  = 10589,

    SPELL_TELE_H_TO         = 37389,
    QUEST_GAINING_ACCESS_H  = 10604
};

class AreaTrigger_at_legion_teleporter : public AreaTriggerScript
{
public:
    AreaTrigger_at_legion_teleporter()
        : AreaTriggerScript("at_legion_teleporter")
    {
    }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (player->IsAlive() && !player->IsInCombat())
        {
            if (player->GetTeamId() == TEAM_ALLIANCE && player->GetQuestRewardStatus(QUEST_GAINING_ACCESS_A))
            {
                player->CastSpell(player, SPELL_TELE_A_TO, false);
                return true;
            }

            if (player->GetTeamId() == TEAM_HORDE && player->GetQuestRewardStatus(QUEST_GAINING_ACCESS_H))
            {
                player->CastSpell(player, SPELL_TELE_H_TO, false);
                return true;
            }

            return false;
        }
        return false;
    }
};

/*######
## at_stormwright_shelf
######*/

enum StormwrightShelf
{
    QUEST_STRENGTH_OF_THE_TEMPEST               = 12741,

    SPELL_CREATE_TRUE_POWER_OF_THE_TEMPEST      = 53067
};

class AreaTrigger_at_stormwright_shelf : public AreaTriggerScript
{
public:
    AreaTrigger_at_stormwright_shelf()
        : AreaTriggerScript("at_stormwright_shelf")
    {
    }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (!player->isDead() && player->GetQuestStatus(QUEST_STRENGTH_OF_THE_TEMPEST) == QUEST_STATUS_INCOMPLETE)
            player->CastSpell(player, SPELL_CREATE_TRUE_POWER_OF_THE_TEMPEST, false);

        return true;
    }
};

/*######
## at_scent_larkorwi
######*/

enum ScentLarkorwi
{
    QUEST_SCENT_OF_LARKORWI                     = 4291,
    NPC_LARKORWI_MATE                           = 9683
};

class AreaTrigger_at_scent_larkorwi : public AreaTriggerScript
{
public:
    AreaTrigger_at_scent_larkorwi()
        : AreaTriggerScript("at_scent_larkorwi")
    {
    }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (!player->isDead() && player->GetQuestStatus(QUEST_SCENT_OF_LARKORWI) == QUEST_STATUS_INCOMPLETE)
        {
            if (!player->FindNearestCreature(NPC_LARKORWI_MATE, 15))
                player->SummonCreature(NPC_LARKORWI_MATE, player->GetPositionX() + 5, player->GetPositionY(), player->GetPositionZ(), 3.3f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 100000);
        }

        return false;
    }
};

/*#####
## at_last_rites
#####*/

enum AtLastRites
{
    QUEST_LAST_RITES                          = 12019,
    QUEST_BREAKING_THROUGH                    = 11898,
};

class AreaTrigger_at_last_rites : public AreaTriggerScript
{
public:
    AreaTrigger_at_last_rites()
        : AreaTriggerScript("at_last_rites")
    {
    }

    bool OnTrigger(Player* player, AreaTrigger const* trigger) override
    {
        QuestStatus QLR = player->GetQuestStatus(QUEST_LAST_RITES);
        QuestStatus QBT = player->GetQuestStatus(QUEST_BREAKING_THROUGH);
        if (!(QLR == QUEST_STATUS_INCOMPLETE || QLR  == QUEST_STATUS_COMPLETE ||
                QBT == QUEST_STATUS_INCOMPLETE || QBT == QUEST_STATUS_COMPLETE))
            return false;

        WorldLocation pPosition;

        switch (trigger->entry)
        {
            case 5332:
            case 5338:
            case 5339:
                pPosition = WorldLocation(571, 3733.68f, 3563.25f, 290.812f, 3.665192f);
                break;
            case 5334:
                pPosition = WorldLocation(571, 3802.38f, 3585.95f, 49.5765f, 0.0f);
                break;
            case 5340:
                if (QBT == QUEST_STATUS_INCOMPLETE)
                    pPosition = WorldLocation(571, 3758, 3562, 345.51f, 0.0f);
                else
                    pPosition = WorldLocation(571, 3687.91f, 3577.28f, 473.342f, 0.0f);
                break;
            default:
                return false;
        }

        player->TeleportTo(pPosition);

        return false;
    }
};

/*######
## at_nats_landing
######*/

enum NatsLanding
{
    QUEST_NATS_BARGAIN = 11209,
    SPELL_FISH_PASTE   = 42644,
    NPC_LURKING_SHARK  = 23928
};

class AreaTrigger_at_nats_landing : public AreaTriggerScript
{
public:
    AreaTrigger_at_nats_landing() : AreaTriggerScript("at_nats_landing") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (!player->IsAlive() || !player->HasAura(SPELL_FISH_PASTE))
            return false;

        if (player->GetQuestStatus(QUEST_NATS_BARGAIN) == QUEST_STATUS_INCOMPLETE)
        {
            if (!player->FindNearestCreature(NPC_LURKING_SHARK, 20.0f))
            {
                if (Creature* shark = player->SummonCreature(NPC_LURKING_SHARK, -4246.243f, -3922.356f, -7.488f, 5.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 100000))
                    shark->AI()->AttackStart(player);

                return false;
            }
        }
        return true;
    }
};

/*######
## at_sentry_point
######*/

enum SentryPoint
{
    SPELL_TELEPORT_VISUAL    = 799,  /// @todo Find the correct spell
    QUEST_MISSING_DIPLO_PT14 = 1265,
    NPC_TERVOSH              = 4967
};

class AreaTrigger_at_sentry_point : public AreaTriggerScript
{
public:
    AreaTrigger_at_sentry_point() : AreaTriggerScript("at_sentry_point") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        auto quest_status = player->GetQuestStatus(QUEST_MISSING_DIPLO_PT14);
        if (!player->IsAlive() || quest_status == QUEST_STATUS_NONE || quest_status == QUEST_STATUS_REWARDED)
            return false;

        if (!player->FindNearestCreature(NPC_TERVOSH, 100.0f))
        {
            if(Creature* tervosh = player->SummonCreature(NPC_TERVOSH, -3476.51f, -4105.94f, 17.1f, 5.3816f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                tervosh->CastSpell(tervosh, SPELL_TELEPORT_VISUAL, true);
        }

        return true;
    }
};

/*######
## at_brewfest
######*/

enum Brewfest
{
    NPC_TAPPER_SWINDLEKEG       = 24711,
    NPC_IPFELKOFER_IRONKEG      = 24710,

    AT_BREWFEST_DUROTAR         = 4829,
    AT_BREWFEST_DUN_MOROGH      = 4820,

    SAY_WELCOME                 = 4,

    AREATRIGGER_TALK_COOLDOWN   = 5, // in seconds
};

class AreaTrigger_at_brewfest : public AreaTriggerScript
{
public:
    AreaTrigger_at_brewfest() : AreaTriggerScript("at_brewfest")
    {
        // Initialize for cooldown
        _triggerTimes[AT_BREWFEST_DUROTAR] = _triggerTimes[AT_BREWFEST_DUN_MOROGH] = 0;
    }

    bool OnTrigger(Player* player, AreaTrigger const* trigger) override
    {
        uint32 triggerId = trigger->entry;
        // Second trigger happened too early after first, skip for now
        if (GameTime::GetGameTime().count() - _triggerTimes[triggerId] < AREATRIGGER_TALK_COOLDOWN)
            return false;

        switch (triggerId)
        {
            case AT_BREWFEST_DUROTAR:
                if (Creature* tapper = player->FindNearestCreature(NPC_TAPPER_SWINDLEKEG, 20.0f))
                    tapper->AI()->Talk(SAY_WELCOME, player);
                break;
            case AT_BREWFEST_DUN_MOROGH:
                if (Creature* ipfelkofer = player->FindNearestCreature(NPC_IPFELKOFER_IRONKEG, 20.0f))
                    ipfelkofer->AI()->Talk(SAY_WELCOME, player);
                break;
            default:
                break;
        }

        _triggerTimes[triggerId] = GameTime::GetGameTime().count();
        return false;
    }

private:
    std::map<uint32, time_t> _triggerTimes;
};

/*######
## at_area_52_entrance
######*/

enum Area52Entrance
{
    SPELL_A52_NEURALYZER  = 34400,
    NPC_SPOTLIGHT         = 19913,
    SUMMON_COOLDOWN       = 5,

    AT_AREA_52_SOUTH      = 4472,
    AT_AREA_52_NORTH      = 4466,
    AT_AREA_52_WEST       = 4471,
    AT_AREA_52_EAST       = 4422,
};

class AreaTrigger_at_area_52_entrance : public AreaTriggerScript
{
public:
    AreaTrigger_at_area_52_entrance() : AreaTriggerScript("at_area_52_entrance")
    {
        _triggerTimes[AT_AREA_52_SOUTH] = _triggerTimes[AT_AREA_52_NORTH] = _triggerTimes[AT_AREA_52_WEST] = _triggerTimes[AT_AREA_52_EAST] = 0;
    }

    bool OnTrigger(Player* player, AreaTrigger const* trigger) override
    {
        float x = 0.0f, y = 0.0f, z = 0.0f;

        if (!player->IsAlive())
            return false;

        uint32 triggerId = trigger->entry;
        if (GameTime::GetGameTime().count() - _triggerTimes[trigger->entry] < SUMMON_COOLDOWN)
            return false;

        switch (triggerId)
        {
            case AT_AREA_52_EAST:
                x = 3044.176f;
                y = 3610.692f;
                z = 143.61f;
                break;
            case AT_AREA_52_NORTH:
                x = 3114.87f;
                y = 3687.619f;
                z = 143.62f;
                break;
            case AT_AREA_52_WEST:
                x = 3017.79f;
                y = 3746.806f;
                z = 144.27f;
                break;
            case AT_AREA_52_SOUTH:
                x = 2950.63f;
                y = 3719.905f;
                z = 143.33f;
                break;
        }

        player->SummonCreature(NPC_SPOTLIGHT, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 5000);
        player->AddAura(SPELL_A52_NEURALYZER, player);
        _triggerTimes[trigger->entry] = GameTime::GetGameTime().count();
        return false;
    }

private:
    std::map<uint32, time_t> _triggerTimes;
};

void AddSC_areatrigger_scripts()
{
    // Ours
    new AreaTrigger_at_voltarus_middle();

    // Theirs
    new AreaTrigger_at_coilfang_waterfall();
    new AreaTrigger_at_legion_teleporter();
    new AreaTrigger_at_stormwright_shelf();
    new AreaTrigger_at_scent_larkorwi();
    new AreaTrigger_at_last_rites();
    new AreaTrigger_at_nats_landing();
    new AreaTrigger_at_sentry_point();
    new AreaTrigger_at_brewfest();
    new AreaTrigger_at_area_52_entrance();
}

