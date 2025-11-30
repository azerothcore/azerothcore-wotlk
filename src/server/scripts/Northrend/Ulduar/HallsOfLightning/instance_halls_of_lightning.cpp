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
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "halls_of_lightning.h"

DoorData const doorData[] =
{
    { GO_VOLKHAN_DOOR,   DATA_VOLKHAN,   DOOR_TYPE_PASSAGE },
    { GO_IONAR_DOOR,     DATA_IONAR,     DOOR_TYPE_PASSAGE },
    { 0,                        0,       DOOR_TYPE_ROOM    }
};

ObjectData const gameObjectData[] =
{
    { GO_LOKEN_THRONE, DATA_LOKEN_THRONE },
    { 0,               0                 }
};

class instance_halls_of_lightning : public InstanceMapScript
{
public:
    instance_halls_of_lightning() : InstanceMapScript("instance_halls_of_lightning", MAP_HALLS_OF_LIGHTNING) { }

    struct instance_halls_of_lightning_InstanceMapScript : public InstanceScript
    {
        instance_halls_of_lightning_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
            LoadObjectData(nullptr, gameObjectData);
            _volkhanAchievement = false;
            _bjarngrimAchievement = false;
        };

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 7321: //Shatter Resistant (2042)
                    return _volkhanAchievement;
                case 6835: // Lightning Struck (1834)
                    return _bjarngrimAchievement;
            }
            return false;
        }

        void SetData(uint32 uiType, uint32 uiData) override
        {
            // Achievements
            if (uiType == DATA_BJARNGRIM_ACHIEVEMENT)
                _bjarngrimAchievement = (bool)uiData;
            else if (uiType == DATA_VOLKHAN_ACHIEVEMENT)
                _volkhanAchievement = (bool)uiData;
        }

    private:
        bool _volkhanAchievement;
        bool _bjarngrimAchievement;
    };

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_halls_of_lightning_InstanceMapScript(pMap);
    }
};

enum TitaniumHallwaySpells
{
    SPELL_FREEZE_ANIM = 16245,
    SPELL_AWAKEN      = 52875,
};

class at_hol_hall_of_watchers : public OnlyOnceAreaTriggerScript
{
public:
    at_hol_hall_of_watchers() : OnlyOnceAreaTriggerScript("at_hol_hall_of_watchers") {}

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        std::list<Creature*> creatures;
        player->GetCreatureListWithEntryInGrid(creatures, { NPC_TITANIUM_SIEGEBREAKER, NPC_TITANIUM_THUNDERER }, 50.0f);
        creatures.remove_if([&](Creature const* creature) -> bool
        {
            return !player->IsWithinLOSInMap(creature) || !creature->HasAura(SPELL_FREEZE_ANIM);
        });

        if (creatures.empty())
            return false;

        Acore::Containers::RandomResize(creatures, urand(2, 4));

        ObjectGuid target = player->GetGUID();

        for (Creature* creature : creatures)
        {
            creature->SetHomePosition(player->GetPosition());
            creature->AI()->DoCastSelf(SPELL_AWAKEN);
            creature->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            creature->m_Events.AddEventAtOffset([creature, target] {
                creature->AI()->DoAction(ACTION_ACTIVATE_TITANIUM_VRYKUL);
                if (Player* targetPlayer = ObjectAccessor::GetPlayer(*creature, target))
                    creature->AI()->AttackStart(targetPlayer);
            }, 5s);
        }

        return false;
    }
};

void AddSC_instance_halls_of_lightning()
{
    new instance_halls_of_lightning();
    new at_hol_hall_of_watchers();
}
