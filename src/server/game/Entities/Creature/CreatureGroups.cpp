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

#include "CreatureGroups.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "Log.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "WaypointMgr.h"

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

    //Check if it is a leader
    if (member->GetSpawnId() == m_groupID)
    {
        LOG_DEBUG("entities.unit", "Unit {} is formation leader. Adding group.", member->GetGUID().ToString());
        m_leader = member;
    }

    m_members[member] = sFormationMgr->CreatureGroupMap.find(member->GetSpawnId())->second;
    member->SetFormation(this);
}

void CreatureGroup::RemoveMember(Creature* member)
{
    if (m_leader == member)
    {
        m_leader = nullptr;
    }

    m_members.erase(member);
    member->SetFormation(nullptr);
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

        if (pMember->IsValidAttackTarget(target) && pMember->AI())
        {
            pMember->AI()->AttackStart(target);
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
    if (m_members.size() && !(m_members.begin()->second.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER))))
        return;

    for (auto const& itr : m_members)
    {
        Creature* member = itr.first;
        if (member && member != m_leader && member->IsAlive())
        {
            if (initMotionMaster)
            {
                if (dismiss)
                    member->GetMotionMaster()->Initialize();
                else
                    member->GetMotionMaster()->MoveIdle();

                LOG_DEBUG("entities.unit", "Set {} movement for member {}", dismiss ? "default" : "idle", member->GetGUID().ToString());
            }
        }
    }
    m_Formed = !dismiss;
}

void CreatureGroup::LeaderMoveTo(float x, float y, float z, uint32 move_type)
{
    //! To do: This should probably get its own movement generator or use WaypointMovementGenerator.
    //! If the leader's path is known, member's path can be plotted as well using formation offsets.
    if (!m_leader)
        return;

    float pathDist = m_leader->GetExactDist(x, y, z);
    float pathAngle = std::atan2(m_leader->GetPositionY() - y, m_leader->GetPositionX() - x);

    for (auto const& itr : m_members)
    {
        Creature* member = itr.first;
        FormationInfo const& pFormationInfo = itr.second;
        if (member == m_leader || !member->IsAlive() || member->GetVictim() || !pFormationInfo.HasGroupFlag(std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER)))
            continue;

        // Xinef: If member is stunned / rooted etc don't allow to move him
        if (member->HasUnitState(UNIT_STATE_NOT_MOVE))
            continue;

        // Xinef: this should be automatized, if turn angle is greater than PI/2 (90�) we should swap formation angle
        float followAngle = pFormationInfo.follow_angle;
        if (static_cast<float>(M_PI) - std::fabs(std::fabs(m_leader->GetOrientation() - pathAngle) - static_cast<float>(M_PI)) > static_cast<float>(M_PI)* 0.5f)
        {
            // pussywizard: in both cases should be 2*M_PI - follow_angle
            // pussywizard: also, GetCurrentWaypointID() returns 0..n-1, while point_1 must be > 0, so +1
            // pussywizard: db table waypoint_data shouldn't have point id 0 and shouldn't have any gaps for this to work!
            // if (m_leader->GetCurrentWaypointID()+1 == pFormationInfo->point_1 || m_leader->GetCurrentWaypointID()+1 == itr->second->point_2)
            followAngle = Position::NormalizeOrientation(pFormationInfo.follow_angle + static_cast<float>(M_PI)); //(2 * M_PI) - itr->second->follow_angle;
        }

        float const followDist = pFormationInfo.follow_dist;

        float dx = x + std::cos(followAngle + pathAngle) * followDist;
        float dy = y + std::sin(followAngle + pathAngle) * followDist;
        float dz = z;

        Acore::NormalizeMapCoord(dx);
        Acore::NormalizeMapCoord(dy);
        if (move_type < 2)
            member->UpdateGroundPositionZ(dx, dy, dz);

        // pussywizard: setting the same movementflags is not enough, spline decides whether leader walks/runs, so spline param is now passed as "run" parameter to this function
        member->SetUnitMovementFlags(m_leader->GetUnitMovementFlags());
        switch (move_type)
        {
        case WAYPOINT_MOVE_TYPE_WALK:
            member->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
            break;
        case WAYPOINT_MOVE_TYPE_RUN:
            member->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            break;
        case WAYPOINT_MOVE_TYPE_LAND:
            member->AddUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY);
            break;
        }

        // xinef: if we move members to position without taking care of sizes, we should compare distance without sizes
        // xinef: change members speed basing on distance - if too far speed up, if too close slow down
        UnitMoveType const mtype = Movement::SelectSpeedType(member->GetUnitMovementFlags());
        float const speedRate = m_leader->GetSpeedRate(mtype) * member->GetExactDist(dx, dy, dz) / pathDist;

        if (speedRate > 0.01f) // don't move if speed rate is too low
        {
            member->SetSpeedRate(mtype, speedRate);
            member->GetMotionMaster()->MovePoint(0, dx, dy, dz);
            member->SetHomePosition(dx, dy, dz, pathAngle);
        }
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
