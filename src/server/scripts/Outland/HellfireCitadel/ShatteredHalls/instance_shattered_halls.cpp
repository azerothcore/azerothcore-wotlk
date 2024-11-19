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
#include "CreatureTextMgr.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "shattered_halls.h"

ObjectData const creatureData[] =
{
    { NPC_GRAND_WARLOCK_NETHEKURSE  , DATA_NETHEKURSE     },
    { NPC_WARCHIEF_KARGATH          , DATA_KARGATH        },
    { NPC_OMROGG_LEFT_HEAD          , DATA_OMROGG_LEFT_HEAD },
    { NPC_OMROGG_RIGHT_HEAD         , DATA_OMROGG_RIGHT_HEAD },
    { NPC_WARCHIEF_PORTAL           , DATA_WARCHIEF_PORTAL },
    { 0                             , 0                   }
};

DoorData const doorData[] =
{
    { GO_GRAND_WARLOCK_CHAMBER_DOOR_1, DATA_NETHEKURSE, DOOR_TYPE_PASSAGE },
    { GO_GRAND_WARLOCK_CHAMBER_DOOR_2, DATA_NETHEKURSE, DOOR_TYPE_PASSAGE },
    { 0,                                             0, DOOR_TYPE_ROOM    } // END
};

class instance_shattered_halls : public InstanceMapScript
{
public:
    instance_shattered_halls() : InstanceMapScript("instance_shattered_halls", 540) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_shattered_halls_InstanceMapScript(map);
    }

    struct instance_shattered_halls_InstanceMapScript : public InstanceScript
    {
        instance_shattered_halls_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetBossNumber(ENCOUNTER_COUNT);
            LoadObjectData(creatureData, nullptr);
            LoadDoorData(doorData);

            TeamIdInInstance = TEAM_NEUTRAL;
            RescueTimer = 100 * MINUTE * IN_MILLISECONDS;
        }

        void OnPlayerEnter(Player* player) override
        {
            if (TeamIdInInstance == TEAM_NEUTRAL)
                TeamIdInInstance = player->GetTeamId();
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (TeamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const& players = instance->GetPlayers();
                if (!players.IsEmpty())
                    if (Player* player = players.begin()->GetSource())
                        TeamIdInInstance = player->GetTeamId();
            }

            switch (creature->GetEntry())
            {
                case NPC_SHATTERED_EXECUTIONER:
                    if (RescueTimer > 25 * MINUTE * IN_MILLISECONDS)
                        creature->AddLootMode(2);
                    executionerGUID = creature->GetGUID();
                    break;
                case NPC_RIFLEMAN_BROWNBEARD:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_KORAG_PROUDMANE);
                    prisonerGUID[0] = creature->GetGUID();
                    break;
                case NPC_CAPTAIN_ALINA:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_CAPTAIN_BONESHATTER);
                    prisonerGUID[1] = creature->GetGUID();
                    break;
                case NPC_PRIVATE_JACINT:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_SCOUT_ORGARR);
                    prisonerGUID[2] = creature->GetGUID();
                    break;
            }
            InstanceScript::OnCreatureCreate(creature);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_ENTERED_ROOM && data == DATA_ENTERED_ROOM && RescueTimer == 100 * MINUTE * IN_MILLISECONDS)
            {
                DoCastSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_1);
                instance->LoadGrid(230, -80);

                if (Creature* kargath = GetCreature(DATA_KARGATH))
                    sCreatureTextMgr->SendChat(kargath, TeamIdInInstance == TEAM_ALLIANCE ? 3 : 4, nullptr, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_MAP);

                RescueTimer = 80 * MINUTE * IN_MILLISECONDS;
            }
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                case DATA_PRISONER_1:
                case DATA_PRISONER_2:
                case DATA_PRISONER_3:
                    return prisonerGUID[data - DATA_PRISONER_1];
                case DATA_EXECUTIONER:
                    return executionerGUID;
            }

            return ObjectGuid::Empty;
        }

        void Update(uint32 diff) override
        {
            if (RescueTimer && RescueTimer < 100 * MINUTE * IN_MILLISECONDS)
            {
                RescueTimer -= std::min(RescueTimer, diff);

                if ((RescueTimer / IN_MILLISECONDS) == 25 * MINUTE)
                {
                    DoRemoveAurasDueToSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_1);
                    DoCastSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_2);
                    if (Creature* prisoner = instance->GetCreature(prisonerGUID[0]))
                        Unit::Kill(prisoner, prisoner);
                    if (Creature* executioner = instance->GetCreature(executionerGUID))
                        executioner->RemoveLootMode(2);
                }
                else if ((RescueTimer / IN_MILLISECONDS) == 15 * MINUTE)
                {
                    DoRemoveAurasDueToSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_2);
                    DoCastSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_3);
                    if (Creature* prisoner = instance->GetCreature(prisonerGUID[1]))
                        Unit::Kill(prisoner, prisoner);
                }
                else if ((RescueTimer / IN_MILLISECONDS) == 0)
                {
                    DoRemoveAurasDueToSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_3);
                    if (Creature* prisoner = instance->GetCreature(prisonerGUID[2]))
                        Unit::Kill(prisoner, prisoner);
                }
            }
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> RescueTimer;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << RescueTimer;
        }

    protected:
        ObjectGuid executionerGUID;
        ObjectGuid prisonerGUID[3];
        uint32 RescueTimer;
        TeamId TeamIdInInstance;
    };
};

class at_shattered_halls_execution : public AreaTriggerScript
{
public:
    at_shattered_halls_execution() : AreaTriggerScript("at_shattered_halls_execution") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        if (InstanceScript* instanceScript = player->GetInstanceScript())
        {
            if (player->GetMap()->IsHeroic())
            {
                instanceScript->SetData(DATA_ENTERED_ROOM, DATA_ENTERED_ROOM);
            }
        }

        return true;
    }
};

void AddSC_instance_shattered_halls()
{
    new instance_shattered_halls();
    new at_shattered_halls_execution();
}
