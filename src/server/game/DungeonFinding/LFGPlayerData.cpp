/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "LFGPlayerData.h"
#include "LFGMgr.h"

namespace lfg
{

LfgPlayerData::LfgPlayerData(): m_State(LFG_STATE_NONE), m_OldState(LFG_STATE_NONE), m_canOverrideRBState(false),
    m_TeamId(TEAM_ALLIANCE), m_Group(0), m_Roles(0), m_Comment("")
{}

LfgPlayerData::~LfgPlayerData()
{
}

void LfgPlayerData::SetState(LfgState state)
{
    if (m_State == LFG_STATE_RAIDBROWSER && state != LFG_STATE_RAIDBROWSER && !CanOverrideRBState())
        return;

    switch (state)
    {
        case LFG_STATE_NONE:
        case LFG_STATE_FINISHED_DUNGEON:
            m_Roles = 0;
            m_SelectedDungeons.clear();
            m_Comment = "";
            // No break on purpose
        case LFG_STATE_DUNGEON:
            m_OldState = state;
            // No break on purpose
        default:
            m_State = state;
    }
}

void LfgPlayerData::RestoreState()
{
    if (m_State == LFG_STATE_RAIDBROWSER && m_OldState != LFG_STATE_RAIDBROWSER && !CanOverrideRBState())
        return;

    if (m_OldState == LFG_STATE_NONE)
    {
        m_SelectedDungeons.clear();
        m_Roles = 0;
    }
    m_State = m_OldState;
}

void LfgPlayerData::SetLockedDungeons(LfgLockMap const& lockStatus)
{
    m_LockedDungeons = lockStatus;
}

void LfgPlayerData::SetTeam(TeamId teamId)
{
    m_TeamId = teamId;
}

void LfgPlayerData::SetGroup(uint64 group)
{
    m_Group = group;
}

void LfgPlayerData::SetRoles(uint8 roles)
{
    m_Roles = roles;
}

void LfgPlayerData::SetComment(std::string const& comment)
{
    m_Comment = comment;
}

void LfgPlayerData::SetSelectedDungeons(LfgDungeonSet const& dungeons)
{
    m_SelectedDungeons = dungeons;
}

void LfgPlayerData::SetRandomPlayersCount(uint8 count)
{
    m_randomPlayers = count;
}

uint8 LfgPlayerData::GetRandomPlayersCount() const
{
    return m_randomPlayers;
}

LfgState LfgPlayerData::GetState() const
{
    return m_State;
}

LfgState LfgPlayerData::GetOldState() const
{
    return m_OldState;
}

const LfgLockMap& LfgPlayerData::GetLockedDungeons() const
{
    return m_LockedDungeons;
}

TeamId LfgPlayerData::GetTeam() const
{
    return m_TeamId;
}

uint64 LfgPlayerData::GetGroup() const
{
    return m_Group;
}

uint8 LfgPlayerData::GetRoles() const
{
    return m_Roles;
}

std::string const& LfgPlayerData::GetComment() const
{
    return m_Comment;
}

LfgDungeonSet const& LfgPlayerData::GetSelectedDungeons() const
{
    return m_SelectedDungeons;
}

} // namespace lfg
