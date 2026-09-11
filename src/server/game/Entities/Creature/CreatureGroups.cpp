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

#include "CreatureGroups.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "Log.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "QueryResult.h"
#include "Timer.h"
#include "WaypointMgr.h"
#include <algorithm>

FormationMgr::~FormationMgr()
{
}

FormationMgr* FormationMgr::instance()
{
    static FormationMgr instance;
    return &instance;
}

void FormationMgr::AddCreatureToGroup(uint32 groupId, Creature* member)
{
    Map* map = member->FindMap();
    if (!map)
    {
        return;
    }

    CreatureGroupHolderType::iterator itr = map->CreatureGroupHolder.find(groupId);

    //Add member to an existing group
    if (itr != map->CreatureGroupHolder.end())
    {
        LOG_DEBUG("entities.unit", "Group found: {}, inserting creature {}, Group InstanceID {}", groupId, member->GetGUID().ToString(), member->GetInstanceId());
        itr->second->AddMember(member);
    }
    //Create new group
    else
    {
        LOG_DEBUG("entities.unit", "Group not found: {}. Creating new group.", groupId);
        CreatureGroup* group = new CreatureGroup(groupId);
        map->CreatureGroupHolder[groupId] = group;
        group->AddMember(member);
    }
}

void FormationMgr::RemoveCreatureFromGroup(CreatureGroup* group, Creature* member)
{
    LOG_DEBUG("entities.unit", "Deleting member pointer to spawnId: {} from group {}", member->GetSpawnId(), group->GetId());
    group->RemoveMember(member);

    if (group->IsEmpty())
    {
        Map* map = member->FindMap();
        if (!map)
        {
            return;
        }

        LOG_DEBUG("entities.unit", "Deleting group with InstanceID {}", member->GetInstanceId());
        map->CreatureGroupHolder.erase(group->GetId());
        delete group;
    }
}

void FormationMgr::LoadCreatureFormations()
{
    uint32 const oldMSTime = getMSTime();
    CreatureGroupMap.clear();

    //Get group data
    QueryResult result = WorldDatabase.Query("SELECT leaderGUID, memberGUID, dist, angle, groupAI, point_1, point_2 FROM creature_formations ORDER BY leaderGUID");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creatures in formations. DB table `creature_formations` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field const* fields = result->Fetch();

        //Load group member data
        FormationInfo group_member;
        group_member.leaderGUID            = fields[0].Get<uint32>();
        ObjectGuid::LowType const memberGUID = fields[1].Get<uint32>();
        float const follow_dist             = fields[2].Get<float>();
        float const follow_angle            = fields[3].Get<float>() * (static_cast<float>(M_PI) / 180);
        group_member.groupAI               = fields[4].Get<uint16>();
        group_member.point_1               = fields[5].Get<uint16>();
        group_member.point_2               = fields[6].Get<uint16>();

        //If creature is group leader we may skip loading of dist/angle
        if (group_member.leaderGUID != memberGUID)
        {
            if (!group_member.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_SUPPORTED)))
            {
                LOG_ERROR("sql.sql", "creature_formations table leader guid {} and member guid {} has unsupported GroupAI flag value ({}). Skipped", group_member.leaderGUID, memberGUID, group_member.groupAI);
                continue;
            }

            if (!group_member.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER)) && (follow_dist > 0.0f || follow_angle > 0.0f))
            {
                LOG_ERROR("sql.sql", "creature_formations table member guid {} and leader guid {} cannot have follow distance or follow angle because don't have GROUP_AI_FLAG_FOLLOW_LEADER flag. Values are not gonna be used", memberGUID, group_member.leaderGUID);
                group_member.follow_dist       = 0.0f;
                group_member.follow_angle      = 0.0f;
            }
            else
            {
                group_member.follow_dist       = follow_dist;
                group_member.follow_angle      = follow_angle;
            }
        }
        else
        {
            // Leader can have 0 AI flags - its allowed
            if (group_member.groupAI && !group_member.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_SUPPORTED)))
            {
                LOG_ERROR("sql.sql", "creature_formations table leader guid {} and member guid {} has unsupported GroupAI flag value ({}). Skipped", group_member.leaderGUID, memberGUID, group_member.groupAI);
                continue;
            }

            group_member.follow_dist       = 0.0f;
            group_member.follow_angle      = 0.0f;
            if (follow_dist > 0.0f || follow_angle > 0.0f)
            {
                LOG_ERROR("sql.sql", "creature_formations table member guid {} and leader guid {} cannot have follow distance or follow angle. Values are not gonna be used", memberGUID, group_member.leaderGUID);
            }
        }

        if (!sObjectMgr->GetCreatureData(group_member.leaderGUID))
        {
            LOG_ERROR("sql.sql", "creature_formations table leader guid {} incorrect (does not exist). Skipped", group_member.leaderGUID);
            continue;
        }

        if (!sObjectMgr->GetCreatureData(memberGUID))
        {
            LOG_ERROR("sql.sql", "creature_formations table member guid {} incorrect (does not exist). Skipped", memberGUID);
            continue;
        }

        CreatureGroupMap[memberGUID] = group_member;
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creatures In Formations in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void CreatureGroup::AddMember(Creature* member)
{
    LOG_DEBUG("entities.unit", "CreatureGroup::AddMember: Adding unit {}.", member->GetGUID().ToString());

    auto const formationItr = sFormationMgr->CreatureGroupMap.find(member->GetSpawnId());
    ASSERT(formationItr != sFormationMgr->CreatureGroupMap.end());
    m_members[member] = formationItr->second;
    member->SetFormation(this);

    //Check if it is a leader
    if (member->GetSpawnId() == m_groupID)
    {
        LOG_DEBUG("entities.unit", "Unit {} is formation leader. Adding group.", member->GetGUID().ToString());
        bool const isReturningLeader = m_movementLeader != nullptr;
        m_leader = member;
        m_promotePatrolLeader = formationItr->second.HasGroupFlag(
            std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_PROMOTE_PATROL_LEADER));
        m_patrolPathId = member->GetDefaultMovementType() == WAYPOINT_MOTION_TYPE ? member->GetWaypointPath() : 0;

        if (!isReturningLeader || !m_movementLeader->IsAlive() || !IsFormationInCombat())
        {
            m_movementLeader = member;
            m_restoreOriginalLeader = false;
            if (isReturningLeader)
                PrepareFormationMovement();
        }
        else
            m_restoreOriginalLeader = true;
    }
}

void CreatureGroup::RemoveMember(Creature* member)
{
    if (m_leader == member)
    {
        m_leader = nullptr;
        if (m_movementLeader == member)
        {
            RemoveFormationMovement();
            m_movementLeader = nullptr;
            m_restoreOriginalLeader = false;
            m_Formed = false;
        }
    }
    else if (m_movementLeader == member)
    {
        RemoveFormationMovement();
        m_movementLeader = nullptr;
        m_Formed = false;
    }

    m_members.erase(member);
    member->SetFormation(nullptr);
}

bool CreatureGroup::IsPatrolLeaderPromotionEnabled() const
{
    return m_promotePatrolLeader;
}

Creature* CreatureGroup::SelectNewMovementLeader(Creature const* excluded) const
{
    Creature* newLeader = nullptr;
    for (auto const& [member, formationInfo] : m_members)
    {
        if (!member || member == excluded || !member->IsAlive() || !member->IsInWorld())
            continue;

        if (!formationInfo.HasGroupFlag(
                std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER)))
            continue;

        if (member->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE) || member->isPossessed() ||
            member->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
            continue;

        if (!newLeader || member->GetSpawnId() < newLeader->GetSpawnId())
            newLeader = member;
    }

    return newLeader;
}

void CreatureGroup::PrepareFormationMovement()
{
    if (!m_movementLeader)
        return;

    for (auto const& [member, formationInfo] : m_members)
    {
        if (!member || member == m_movementLeader || !member->IsAlive())
            continue;

        if (!formationInfo.HasGroupFlag(
                std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER)))
            continue;

        member->GetMotionMaster()->MoveFormation(
            m_movementLeader, formationInfo.follow_dist, formationInfo.follow_angle,
            formationInfo.point_1, formationInfo.point_2);
    }

    m_Formed = true;
}

bool CreatureGroup::TryPromotePatrolLeader(Creature* deadLeader)
{
    if (!deadLeader || deadLeader != m_movementLeader || !IsPatrolLeaderPromotionEnabled())
        return false;

    uint32 const pathId = m_patrolPathId;
    if (!pathId)
        return false;

    Creature* newLeader = SelectNewMovementLeader(deadLeader);
    if (!newLeader)
        return false;

    auto const [lastWaypointId, currentPathId] = deadLeader->GetCurrentWaypointInfo();
    uint32 const resumeAfterWaypointId = currentPathId == pathId ? lastWaypointId : deadLeader->GetCurrentWaypointID();

    m_movementLeader = newLeader;
    m_restoreOriginalLeader = true;
    newLeader->UpdateWaypointID(resumeAfterWaypointId);
    newLeader->UpdateCurrentWaypointInfo(resumeAfterWaypointId, pathId);
    newLeader->GetMotionMaster()->MoveWaypoint(pathId, true, PathSource::WAYPOINT_MGR, resumeAfterWaypointId);
    PrepareFormationMovement();

    LOG_DEBUG("entities.unit", "Promoted {} to movement leader of formation {} after {} died.",
        newLeader->GetGUID().ToString(), m_groupID, deadLeader->GetGUID().ToString());
    return true;
}

void CreatureGroup::MemberRespawned(Creature* member)
{
    if (member != m_leader || m_movementLeader == m_leader)
        return;

    if (IsFormationInCombat())
    {
        m_restoreOriginalLeader = true;
        return;
    }

    m_movementLeader = m_leader;
    m_restoreOriginalLeader = false;
    m_Formed = true;
}

void CreatureGroup::TryRestoreOriginalLeader()
{
    if (!m_restoreOriginalLeader || !m_leader || !m_leader->IsAlive() || IsFormationInCombat())
        return;

    m_movementLeader = m_leader;
    m_restoreOriginalLeader = false;
    m_Formed = true;
    m_leader->Motion_Initialize();
}

void CreatureGroup::InitializeMovementLeader(Creature* member)
{
    if (!member || member != m_movementLeader)
        return;

    FormationReset(false, true);
    if (member == m_leader)
    {
        member->GetMotionMaster()->Initialize();
        return;
    }

    uint32 const pathId = m_patrolPathId;
    if (!pathId)
    {
        FormationReset(true, false);
        member->GetMotionMaster()->Initialize();
        return;
    }

    auto const [lastWaypointId, currentPathId] = member->GetCurrentWaypointInfo();
    member->GetMotionMaster()->MoveWaypoint(pathId, true, PathSource::WAYPOINT_MGR,
        currentPathId == pathId ? lastWaypointId : member->GetCurrentWaypointID());
}

void CreatureGroup::MemberEngagingTarget(Creature* member, Unit* target)
{
    uint8 const groupAI = sFormationMgr->CreatureGroupMap[member->GetSpawnId()].groupAI;
    if (member == m_leader)
    {
        if (!(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_MEMBER_ASSIST_LEADER)))
        {
            return;
        }
    }
    else if (!(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_LEADER_ASSIST_MEMBER)))
    {
        return;
    }

    for (auto const& itr : m_members)
    {
        Creature* pMember = itr.first;
        if (!pMember)
        {
            continue;
        }

        if (pMember == member || !pMember->IsAlive() || pMember->GetVictim())
        {
            continue;
        }

        if (pMember == m_leader && !(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_LEADER_ASSIST_MEMBER)))
        {
            continue;
        }

        if (pMember->IsValidAttackTarget(target))
        {
            pMember->EngageWithTarget(target);
        }
    }
}

Unit* CreatureGroup::GetNewTargetForMember(Creature* member)
{
    uint8 const groupAI = sFormationMgr->CreatureGroupMap[member->GetSpawnId()].groupAI;
    if (!(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_ACQUIRE_NEW_TARGET_ON_EVADE)))
    {
        return nullptr;
    }

    if (member == m_leader)
    {
        if (!(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_MEMBER_ASSIST_LEADER)))
        {
            return nullptr;
        }
    }
    else if (!(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_LEADER_ASSIST_MEMBER)))
    {
        return nullptr;
    }

    for (auto const& itr : m_members)
    {
        Creature* pMember = itr.first;
        if (!pMember)
        {
            continue;
        }

        if (pMember == member || !pMember->IsAlive() || !pMember->GetVictim())
        {
            continue;
        }

        if (pMember == m_leader && !(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_MEMBER_ASSIST_LEADER)))
        {
            continue;
        }

        if (member->IsValidAttackTarget(pMember->GetVictim()))
        {
            return pMember->GetVictim();
        }
    }

    return nullptr;
}

void CreatureGroup::MemberEvaded(Creature* member)
{
    uint8 const groupAI = sFormationMgr->CreatureGroupMap[member->GetSpawnId()].groupAI;
    if (!(groupAI & std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_EVADE_MASK)))
    {
        return;
    }

    for (auto const& itr : m_members)
    {
        Creature* pMember = itr.first;
        // This should never happen
        if (!pMember)
            continue;

        if (pMember == member || pMember->IsInEvadeMode() || !itr.second.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_EVADE_MASK)))
            continue;

        if (itr.second.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_EVADE_TOGETHER)))
        {
            if (!pMember->IsAlive() || !pMember->IsInCombat())
                continue;

            if (pMember->IsAIEnabled)
                if (CreatureAI* pMemberAI = pMember->AI())
                    pMemberAI->EnterEvadeMode();
        }
        else
        {
            if (pMember->IsAlive())
                continue;

            if (itr.second.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_DONT_RESPAWN_LEADER_ON_EVADE)) && pMember == m_leader)
                continue;

            pMember->Respawn();
        }
    }
}

void CreatureGroup::FormationReset(bool dismiss, bool initMotionMaster)
{
    bool const hasFormationMovement = std::ranges::any_of(m_members, [](auto const& member)
    {
        return member.second.HasGroupFlag(
            std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER));
    });
    if (!hasFormationMovement)
        return;

    for (auto const& itr : m_members)
    {
        Creature* member = itr.first;
        if (member && member != m_movementLeader && member->IsAlive())
        {
            if (initMotionMaster)
            {
                if (dismiss)
                    member->GetMotionMaster()->MovementExpiredOnSlot(MOTION_SLOT_IDLE, false);
                else
                    member->GetMotionMaster()->MoveIdle();

                LOG_DEBUG("entities.unit", "Set {} movement for member {}",
                    dismiss ? "default" : "idle", member->GetGUID().ToString());
            }
        }
    }
    m_Formed = !dismiss;
}

void CreatureGroup::LeaderStartedMoving()
{
    if (!m_movementLeader)
        return;

    for (auto const& itr : m_members)
    {
        Creature* member = itr.first;
        FormationInfo const& pFormationInfo = itr.second;
        if (member == m_movementLeader || !member->IsAlive() || member->GetVictim() ||
            !pFormationInfo.HasGroupFlag(
                std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER)))
            continue;

        if (member->HasUnitState(UNIT_STATE_NOT_MOVE) || member->isPossessed() ||
            member->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
            continue;

        float const followAngle = pFormationInfo.follow_angle;
        float const followDist = pFormationInfo.follow_dist;

        if (!member->HasUnitState(UNIT_STATE_FOLLOW_MOVE))
            member->GetMotionMaster()->MoveFormation(
                m_movementLeader, followDist, followAngle, pFormationInfo.point_1, pFormationInfo.point_2);
    }
}

bool CreatureGroup::CanLeaderStartMoving() const
{
    for (auto const& itr : m_members)
    {
        if (itr.first && itr.first != m_movementLeader && itr.first->IsAlive())
            if (itr.first->IsEngaged() || itr.first->IsInEvadeMode())
                return false;
    }

    return true;
}

void CreatureGroup::RemoveFormationMovement()
{
    for (auto const& itr : m_members)
    {
        Creature* member = itr.first;
        if (!member || member == m_movementLeader)
            continue;

        if (member->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_IDLE) == FORMATION_MOTION_TYPE)
            member->GetMotionMaster()->MovementExpiredOnSlot(MOTION_SLOT_IDLE, false);
    }
}

void CreatureGroup::DespawnFormation(Milliseconds timeToDespawn /*=0ms*/, Seconds forcedRespawnTimer /*=0s*/)
{
    for (auto const& itr : m_members)
    {
        if (itr.first)
            itr.first->DespawnOrUnsummon(timeToDespawn, forcedRespawnTimer);
    }
}

void CreatureGroup::RespawnFormation(bool force)
{
    for (auto const& itr : m_members)
    {
        if (itr.first && !itr.first->IsAlive())
        {
            itr.first->Respawn(force);
        }
    }
}

bool CreatureGroup::IsFormationInCombat()
{
    for (auto const& itr : m_members)
    {
        if (itr.first && itr.first->IsInCombat())
        {
            return true;
        }
    }

    return false;
}

bool CreatureGroup::IsAnyMemberAlive(bool ignoreLeader /*= false*/)
{
    for (auto const& itr : m_members)
    {
        if (itr.first && itr.first->IsAlive())
        {
            if (!ignoreLeader || itr.first != m_leader)
            {
                return true;
            }
        }
    }

    return false;
}
