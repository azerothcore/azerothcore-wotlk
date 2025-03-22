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

#include "OutdoorPvPSI.h"
#include "CreatureScript.h"
#include "GameObject.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "OutdoorPvPScript.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "Transport.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSessionMgr.h"
#include "WorldStatePackets.h"

OutdoorPvPSI::OutdoorPvPSI()
{
    _typeId = OUTDOOR_PVP_SI;
    m_Gathered_A = 0;
    m_Gathered_H = 0;
    m_LastController = TEAM_NEUTRAL;
}

void OutdoorPvPSI::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    packet.Worldstates.reserve(3);
    packet.Worldstates.emplace_back(SI_GATHERED_A, m_Gathered_A);
    packet.Worldstates.emplace_back(SI_GATHERED_H, m_Gathered_H);
    packet.Worldstates.emplace_back(SI_SILITHYST_MAX, SI_MAX_RESOURCES);
}

void OutdoorPvPSI::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(SI_GATHERED_A, 0);
    player->SendUpdateWorldState(SI_GATHERED_H, 0);
    player->SendUpdateWorldState(SI_SILITHYST_MAX, 0);
}

void OutdoorPvPSI::UpdateWorldState()
{
    SendUpdateWorldState(SI_GATHERED_A, m_Gathered_A);
    SendUpdateWorldState(SI_GATHERED_H, m_Gathered_H);
    SendUpdateWorldState(SI_SILITHYST_MAX, SI_MAX_RESOURCES);
}

bool OutdoorPvPSI::SetupOutdoorPvP()
{
    for (uint8 i = 0; i < OutdoorPvPSIBuffZonesNum; ++i)
        RegisterZone(OutdoorPvPSIBuffZones[i]);

    SetMapFromZone(OutdoorPvPSIBuffZones[0]);

    return true;
}

bool OutdoorPvPSI::Update(uint32 /*diff*/)
{
    return false;
}

void OutdoorPvPSI::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    if (player->GetTeamId() == m_LastController)
        player->CastSpell(player, SI_CENARION_FAVOR, true);
    OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

void OutdoorPvPSI::HandlePlayerLeaveZone(Player* player, uint32 zone)
{
    // remove buffs
    player->RemoveAurasDueToSpell(SI_CENARION_FAVOR);
    OutdoorPvP::HandlePlayerLeaveZone(player, zone);
}

bool OutdoorPvPSI::HandleAreaTrigger(Player* player, uint32 trigger)
{
    std::lock_guard<std::mutex> guard(sOutdoorPvPMgr->_lock);

    switch (trigger)
    {
        case SI_AREATRIGGER_A:
            if (player->GetTeamId() == TEAM_ALLIANCE && player->HasAura(SI_SILITHYST_FLAG))
            {
                // remove aura
                player->RemoveAurasDueToSpell(SI_SILITHYST_FLAG);
                ++ m_Gathered_A;
                if (m_Gathered_A >= SI_MAX_RESOURCES)
                {
                    TeamApplyBuff(TEAM_ALLIANCE, SI_CENARION_FAVOR, 0, player);
                    sWorldSessionMgr->SendZoneText(OutdoorPvPSIBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_SI_CAPTURE_A));
                    m_LastController = TEAM_ALLIANCE;
                    m_Gathered_A = 0;
                    m_Gathered_H = 0;
                }
                UpdateWorldState();
                // reward player, xinef: has no effect on characters above level 70
                if (player->GetLevel() < 70)
                    player->CastSpell(player, SI_TRACES_OF_SILITHYST, true);
                // add 19 honor
                player->RewardHonor(nullptr, 1, 19);
                // add 20 cenarion circle repu
                player->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(609), 20.f);
                // complete quest
                player->KilledMonsterCredit(SI_TURNIN_QUEST_CM_A);
            }
            return true;
        case SI_AREATRIGGER_H:
            if (player->GetTeamId() == TEAM_HORDE && player->HasAura(SI_SILITHYST_FLAG))
            {
                // remove aura
                player->RemoveAurasDueToSpell(SI_SILITHYST_FLAG);
                ++ m_Gathered_H;
                if (m_Gathered_H >= SI_MAX_RESOURCES)
                {
                    TeamApplyBuff(TEAM_HORDE, SI_CENARION_FAVOR, 0, player);
                    sWorldSessionMgr->SendZoneText(OutdoorPvPSIBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_SI_CAPTURE_H));
                    m_LastController = TEAM_HORDE;
                    m_Gathered_A = 0;
                    m_Gathered_H = 0;
                }
                UpdateWorldState();
                // reward player, xinef: has no effect on characters above level 70
                if (player->GetLevel() < 70)
                    player->CastSpell(player, SI_TRACES_OF_SILITHYST, true);
                // add 19 honor
                player->RewardHonor(nullptr, 1, 19);
                // add 20 cenarion circle repu
                player->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(609), 20.f);
                // complete quest
                player->KilledMonsterCredit(SI_TURNIN_QUEST_CM_H);
            }
            return true;
    }
    return false;
}

bool OutdoorPvPSI::HandleDropFlag(Player* player, uint32 spellId)
{
    if (spellId == SI_SILITHYST_FLAG)
    {
        // if it was dropped away from the player's turn-in point, then create a silithyst mound, if it was dropped near the areatrigger, then it was dispelled by the outdoorpvp, so do nothing
        switch (player->GetTeamId())
        {
            case TEAM_ALLIANCE:
                {
                    AreaTrigger const* atEntry = sObjectMgr->GetAreaTrigger(SI_AREATRIGGER_A);
                    if (atEntry)
                    {
                        // 5.0f is safe-distance
                        if (player->GetDistance(atEntry->x, atEntry->y, atEntry->z) > 5.0f + atEntry->radius)
                        {
                            // he dropped it further, summon mound
                            GameObject* go = sObjectMgr->IsGameObjectStaticTransport(SI_SILITHYST_MOUND) ? new StaticTransport() : new GameObject();
                            Map* map = player->GetMap();
                            if (!map)
                            {
                                delete go;
                                return true;
                            }

                            if (!go->Create(map->GenerateLowGuid<HighGuid::GameObject>(), SI_SILITHYST_MOUND, map, player->GetPhaseMask(), player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation(), G3D::Quat(), 100, GO_STATE_READY))
                            {
                                delete go;
                                return true;
                            }

                            go->SetRespawnTime(0);

                            if (!map->AddToMap(go))
                            {
                                delete go;
                                return true;
                            }
                        }
                    }
                }
                break;
            case TEAM_HORDE:
                {
                    AreaTrigger const* atEntry = sObjectMgr->GetAreaTrigger(SI_AREATRIGGER_H);
                    if (atEntry)
                    {
                        // 5.0f is safe-distance
                        if (player->GetDistance(atEntry->x, atEntry->y, atEntry->z) > 5.0f + atEntry->radius)
                        {
                            // he dropped it further, summon mound
                            GameObject* go = sObjectMgr->IsGameObjectStaticTransport(SI_SILITHYST_MOUND) ? new StaticTransport() : new GameObject();
                            Map* map = player->GetMap();
                            if (!map)
                            {
                                delete go;
                                return true;
                            }

                            if (!go->Create(map->GenerateLowGuid<HighGuid::GameObject>(), SI_SILITHYST_MOUND, map, player->GetPhaseMask(), player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation(), G3D::Quat(), 100, GO_STATE_READY))
                            {
                                delete go;
                                return true;
                            }

                            go->SetRespawnTime(0);

                            if (!map->AddToMap(go))
                            {
                                delete go;
                                return true;
                            }
                        }
                    }
                }
                break;
            default:
                break;
        }
        return true;
    }
    return false;
}

bool OutdoorPvPSI::HandleCustomSpell(Player* player, uint32 spellId, GameObject* go)
{
    if (!go || spellId != SI_SILITHYST_FLAG_GO_SPELL)
        return false;
    player->CastSpell(player, SI_SILITHYST_FLAG, true);
    if (go->GetGOInfo()->entry == SI_SILITHYST_MOUND)
    {
        // despawn go
        go->SetRespawnTime(0);
        go->Delete();
    }
    return true;
}

class OutdoorPvP_silithus : public OutdoorPvPScript
{
public:
    OutdoorPvP_silithus()
        : OutdoorPvPScript("outdoorpvp_si")
    {
    }

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPSI();
    }
};

void AddSC_outdoorpvp_si()
{
    new OutdoorPvP_silithus();
}
