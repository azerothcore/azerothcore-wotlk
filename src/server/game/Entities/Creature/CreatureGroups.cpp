/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Creature.h"
#include "CreatureGroups.h"
#include "ObjectMgr.h"

#include "CreatureAI.h"
#include "MoveSplineInit.h"

FormationMgr::~FormationMgr()
{
    for (CreatureGroupInfoType::iterator itr = CreatureGroupMap.begin(); itr != CreatureGroupMap.end(); ++itr)
        delete itr->second;
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
        return;

    CreatureGroupHolderType::iterator itr = map->CreatureGroupHolder.find(groupId);

    //Add member to an existing group
    if (itr != map->CreatureGroupHolder.end())
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Group found: %u, inserting creature GUID: %u, Group InstanceID %u", groupId, member->GetGUIDLow(), member->GetInstanceId());
#endif
        itr->second->AddMember(member);
    }
    //Create new group
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Group not found: %u. Creating new group.", groupId);
#endif
        CreatureGroup* group = new CreatureGroup(groupId);
        map->CreatureGroupHolder[groupId] = group;
        group->AddMember(member);
    }
}

void FormationMgr::RemoveCreatureFromGroup(CreatureGroup* group, Creature* member)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_UNITS, "Deleting member pointer to GUID: %u from group %u", group->GetId(), member->GetDBTableGUIDLow());
#endif
    group->RemoveMember(member);

    if (group->isEmpty())
    {
        Map* map = member->FindMap();
        if (!map)
            return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Deleting group with InstanceID %u", member->GetInstanceId());
#endif
        map->CreatureGroupHolder.erase(group->GetId());
        delete group;
    }
}

void FormationMgr::LoadCreatureFormations()
{
    uint32 oldMSTime = getMSTime();

    for (CreatureGroupInfoType::iterator itr = CreatureGroupMap.begin(); itr != CreatureGroupMap.end(); ++itr) // for reload case
        delete itr->second;
    CreatureGroupMap.clear();

    //Get group data
    QueryResult result = WorldDatabase.Query("SELECT leaderGUID, memberGUID, dist, angle, groupAI, point_1, point_2 FROM creature_formations ORDER BY leaderGUID");

    if (!result)
    {
        sLog->outErrorDb(">>  Loaded 0 creatures in formations. DB table `creature_formations` is empty!");
        sLog->outString();
        return;
    }

    uint32 count = 0;
    Field* fields;
    FormationInfo* group_member;

    do
    {
        fields = result->Fetch();

        //Load group member data
        group_member                        = new FormationInfo();
        group_member->leaderGUID            = fields[0].GetUInt32();
        uint32 memberGUID                   = fields[1].GetUInt32();
        group_member->groupAI               = fields[4].GetUInt32();
        group_member->point_1               = fields[5].GetUInt16();
        group_member->point_2               = fields[6].GetUInt16();
        //If creature is group leader we may skip loading of dist/angle
        if (group_member->leaderGUID != memberGUID)
        {
            group_member->follow_dist       = fields[2].GetFloat();
            group_member->follow_angle      = fields[3].GetFloat() * M_PI / 180;
        }
        else
        {
            group_member->follow_dist       = 0;
            group_member->follow_angle      = 0;
        }

        // check data correctness
        {
            if (!sObjectMgr->GetCreatureData(group_member->leaderGUID))
            {
                sLog->outErrorDb("creature_formations table leader guid %u incorrect (not exist)", group_member->leaderGUID);
                delete group_member;
                continue;
            }

            if (!sObjectMgr->GetCreatureData(memberGUID))
            {
                sLog->outErrorDb("creature_formations table member guid %u incorrect (not exist)", memberGUID);
                delete group_member;
                continue;
            }
        }

        CreatureGroupMap[memberGUID] = group_member;
        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u creatures in formations in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void CreatureGroup::AddMember(Creature* member)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_UNITS, "CreatureGroup::AddMember: Adding unit GUID: %u.", member->GetGUIDLow());
#endif

    //Check if it is a leader
    if (member->GetDBTableGUIDLow() == m_groupID)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Unit GUID: %u is formation leader. Adding group.", member->GetGUIDLow());
#endif
        m_leader = member;
    }

    m_members[member] = sFormationMgr->CreatureGroupMap.find(member->GetDBTableGUIDLow())->second;
    member->SetFormation(this);
}

void CreatureGroup::RemoveMember(Creature* member)
{
    if (m_leader == member)
        m_leader = nullptr;

    m_members.erase(member);
    member->SetFormation(nullptr);
}

void CreatureGroup::MemberAttackStart(Creature* member, Unit* target)
{
    uint8 groupAI = sFormationMgr->CreatureGroupMap[member->GetDBTableGUIDLow()]->groupAI;
    if (!groupAI)
        return;

    if (groupAI == 1 && member != m_leader)
        return;

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        if (m_leader) // avoid crash if leader was killed and reset.
            sLog->outDebug(LOG_FILTER_UNITS, "GROUP ATTACK: group instance id %u calls member instid %u", m_leader->GetInstanceId(), member->GetInstanceId());
#endif

        //Skip one check
        if (itr->first == member)
            continue;

        if (!itr->first->IsAlive())
            continue;

        if (itr->first->GetVictim())
            continue;

        if (itr->first->IsValidAttackTarget(target) && itr->first->AI())
            itr->first->AI()->AttackStart(target);
    }
}

void CreatureGroup::FormationReset(bool dismiss)
{
    if (m_members.size() && m_members.begin()->second->groupAI == 5)
        return;

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        if (itr->first != m_leader && itr->first->IsAlive())
        {
            if (dismiss)
                itr->first->GetMotionMaster()->Initialize();
            else
                itr->first->GetMotionMaster()->MoveIdle();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_UNITS, "Set %s movement for member GUID: %u", dismiss ? "default" : "idle", itr->first->GetGUIDLow());
#endif
        }
    }
    m_Formed = !dismiss;
}

void CreatureGroup::LeaderMoveTo(float x, float y, float z, bool run)
{
    //! To do: This should probably get its own movement generator or use WaypointMovementGenerator.
    //! If the leader's path is known, member's path can be plotted as well using formation offsets.
    if (!m_leader)
        return;

    uint8 groupAI = sFormationMgr->CreatureGroupMap[m_leader->GetDBTableGUIDLow()]->groupAI;
    if (groupAI == 5)
        return;

    float pathDist = m_leader->GetExactDist(x, y, z);
    float pathAngle = m_leader->GetAngle(x, y);

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        Creature* member = itr->first;
        if (member == m_leader || !member->IsAlive() || member->GetVictim())
            continue;

        // Xinef: If member is stunned / rooted etc don't allow to move him
        if (member->HasUnitState(UNIT_STATE_NOT_MOVE))
            continue;

        // Xinef: this should be automatized, if turn angle is greater than PI/2 (90�) we should swap formation angle
        if (M_PI - fabs(fabs(m_leader->GetOrientation() - pathAngle) - M_PI) > M_PI*0.50f)
        {
            // pussywizard: in both cases should be 2*M_PI - follow_angle
            // pussywizard: also, GetCurrentWaypointID() returns 0..n-1, while point_1 must be > 0, so +1
            // pussywizard: db table waypoint_data shouldn't have point id 0 and shouldn't have any gaps for this to work!
            // if (m_leader->GetCurrentWaypointID()+1 == itr->second->point_1 || m_leader->GetCurrentWaypointID()+1 == itr->second->point_2)
            itr->second->follow_angle = Position::NormalizeOrientation(itr->second->follow_angle + M_PI); //(2 * M_PI) - itr->second->follow_angle;
        }

        float followAngle = itr->second->follow_angle;
        float followDist = itr->second->follow_dist;

        float dx = x + cos(followAngle + pathAngle) * followDist;
        float dy = y + sin(followAngle + pathAngle) * followDist;
        float dz = z;

        acore::NormalizeMapCoord(dx);
        acore::NormalizeMapCoord(dy);

        member->UpdateGroundPositionZ(dx, dy, dz);

        member->SetUnitMovementFlags(m_leader->GetUnitMovementFlags());
        // pussywizard: setting the same movementflags is not enough, spline decides whether leader walks/runs, so spline param is now passed as "run" parameter to this function
        if (run && member->IsWalking())
            member->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
        else if (!run && !member->IsWalking())
            member->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);

        // xinef: if we move members to position without taking care of sizes, we should compare distance without sizes
        // xinef: change members speed basing on distance - if too far speed up, if too close slow down
        UnitMoveType mtype = Movement::SelectSpeedType(member->GetUnitMovementFlags());
        float speedRate = m_leader->GetSpeedRate(mtype) * member->GetExactDist(dx, dy, dz) / pathDist;

        if (speedRate > 0.01f) // don't move if speed rate is too low
        {
            member->SetSpeedRate(mtype, speedRate);
            member->GetMotionMaster()->MovePoint(0, dx, dy, dz);
            member->SetHomePosition(dx, dy, dz, pathAngle);
        }
    }
}
