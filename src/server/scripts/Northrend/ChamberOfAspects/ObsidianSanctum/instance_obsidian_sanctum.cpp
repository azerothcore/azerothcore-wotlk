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

#include "CreatureAIImpl.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "obsidian_sanctum.h"

ObjectData const creatureData[] =
{
    { NPC_SARTHARION, DATA_SARTHARION },
    { NPC_TENEBRON,   DATA_TENEBRON   },
    { NPC_SHADRON,    DATA_SHADRON    },
    { NPC_VESPERON,   DATA_VESPERON   },
    { 0,              0                }
};

class instance_obsidian_sanctum : public InstanceMapScript
{
public:
    instance_obsidian_sanctum() : InstanceMapScript("instance_obsidian_sanctum", MAP_THE_OBSIDIAN_SANCTUM) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_obsidian_sanctum_InstanceMapScript(pMap);
    }

    struct instance_obsidian_sanctum_InstanceMapScript : public InstanceScript
    {
        explicit instance_obsidian_sanctum_InstanceMapScript(Map* pMap) : InstanceScript(pMap), portalCount(0)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadObjectData(creatureData, nullptr);
        }

        ObjectGuid GetGuidData(uint32 uiData) const override
        {
            return GetObjectGuid(uiData);
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* source, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                // Gonna Go When the Volcano Blows (10 player) (2047)
                case 7326:
                // Gonna Go When the Volcano Blows (25 player) (2048)
                case 7327:
                {
                    Creature const* sartharion = GetCreature(DATA_SARTHARION);
                    return sartharion && !sartharion->AI()->GetData(source->GetGUID().GetCounter());
                }
                // Less Is More (10 player) (624)
                case 7189:
                case 7190:
                case 7191:
                case 522:
                {
                    return instance->GetPlayersCountExceptGMs() < 9;
                }
                // Less Is More (25 player) (1877)
                case 7185:
                case 7186:
                case 7187:
                case 7188:
                {
                    return instance->GetPlayersCountExceptGMs() < 21;
                }
                // Twilight Assist (10 player) (2049)
                case 7328:
                // Twilight Assist (25 player) (2052)
                case 7331:
                {
                    Creature const* sartharion = GetCreature(DATA_SARTHARION);
                    return sartharion && sartharion->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 1;
                }
                // Twilight Duo (10 player) (2050)
                case 7329:
                // Twilight Duo (25 player) (2053)
                case 7332:
                {
                    Creature const* sartharion = GetCreature(DATA_SARTHARION);
                    return sartharion && sartharion->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 2;
                }
                // Twilight Zone (10 player) (2051)
                case 7330:
                // Twilight Zone (25 player) (2054)
                case 7333:
                {
                    Creature const* sartharion = GetCreature(DATA_SARTHARION);
                    return sartharion && sartharion->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 3;
                }
                default:
                    return false;
            }

        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_ADD_PORTAL:
                {
                    if (!m_uiPortalGUID)
                    {
                        if (Creature* sartharion = GetCreature(DATA_SARTHARION))
                        {
                            if (GameObject* portal = sartharion->SummonGameObject(GO_TWILIGHT_PORTAL, 3247.29f, 529.804f, 58.9595f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                            {
                                sartharion->RemoveGameObject(portal, false);
                                m_uiPortalGUID = portal->GetGUID();
                            }
                        }

                        portalCount = 0;
                    }

                    ++portalCount;
                    break;
                }
                case ACTION_CLEAR_PORTAL:
                {
                    --portalCount;
                    if (!portalCount)
                    {
                        if (GameObject* go = instance->GetGameObject(m_uiPortalGUID))
                        {
                            go->Delete();
                        }

                        DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
                        m_uiPortalGUID.Clear();
                    }
                    break;
                }
                case ACTION_START_PATROL:
                {
                    if (Creature* tenebron = GetCreature(DATA_TENEBRON))
                    {
                        if (tenebron->IsAlive() && GetBossState(DATA_TENEBRON) != DONE)
                            tenebron->AI()->DoAction(ACTION_START_PATROL);
                    }

                    if (Creature* shadron = GetCreature(DATA_SHADRON))
                    {
                        if (shadron->IsAlive() && GetBossState(DATA_SHADRON) != DONE)
                            shadron->AI()->DoAction(ACTION_START_PATROL);
                    }

                    if (Creature* vesperon = GetCreature(DATA_VESPERON))
                    {
                        if (vesperon->IsAlive() && GetBossState(DATA_VESPERON) != DONE)
                            vesperon->AI()->DoAction(ACTION_START_PATROL);
                    }
                    break;
                }
                default:
                    break;
            }
        }

    private:
        ObjectGuid m_uiPortalGUID;
        uint8 portalCount;
    };
};

void AddSC_instance_obsidian_sanctum()
{
    new instance_obsidian_sanctum();
}
