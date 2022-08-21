/*
    ----
    ---- OUTDOOR PVP - AUTOINVITE v1
    
  
*/

#include "OutdoorPvPAI.h"
#include "OutdoorPvPMgr.h"
#include "Group.h"
#include "GroupMgr.h"

OutdoorPvPAI::OutdoorPvPAI()
{
    m_TypeId = OUTDOOR_PVP_AI; // also defined in OutdoorPvP.h
}

bool OutdoorPvPAI::SetupOutdoorPvP()
{
    for (int i = 0; i < OutdoorPvPHPBuffZonesNum; ++i)
        RegisterZone(OutdoorPvPHPBuffZones[i]);
    LOG_INFO("misc", "Autoinvite works!");
    return true;
}

Group* OutdoorPvPAI::GetFreeBfRaid(TeamId TeamId)
{
    for (GuidSet::const_iterator itr = m_Groups[TeamId].begin(); itr != m_Groups[TeamId].end(); ++itr)
        if (Group* group = sGroupMgr->GetGroupByGUID(itr->GetCounter()))
            if (!group->IsFull())
                return group;

    return nullptr;
}

bool OutdoorPvPAI::AddOrSetPlayerToCorrectBfGroup(Player* plr)
{
    if (!plr->IsInWorld())
        return false;

    if (plr->GetGroup() && (plr->GetGroup()->isBGGroup() || plr->GetGroup()->isBFGroup()))
    {
        //LOG_INFO("misc", "Battlefield::AddOrSetPlayerToCorrectBfGroup - player is already in {} group!", (player->GetGroup()->isBGGroup() ? "BG" : "BF"));
        LOG_INFO("misc", "Battlefield::AddOrSetPlayerToCorrectBfGroup - player is already in {} group! AutoGroup HL");
        return false;
    }

    Group* group = GetFreeBfRaid(plr->GetTeamId());
    if (!group)
    {
        group = new Group;
        Battleground *bg = (Battleground*)sOutdoorPvPMgr->GetOutdoorPvPToZoneId(47);
        group->SetBattlegroundGroup(bg);
        group->Create(plr);
        sGroupMgr->AddGroup(group);
        m_Groups[plr->GetTeamId()].insert(group->GetGUID());
    }
    else if (group->IsMember(plr->GetGUID()))
    {
        uint8 subgroup = group->GetMemberGroup(plr->GetGUID());
        plr->SetBattlegroundOrBattlefieldRaid(group, subgroup);
    }
    else
    {
        group->AddMember(plr);
        if (Group* originalGroup = plr->GetOriginalGroup())
            if (originalGroup->IsLeader(plr->GetGUID()))
                group->ChangeLeader(plr->GetGUID());
    }
    return true;
}

void OutdoorPvPAI::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    if(AddOrSetPlayerToCorrectBfGroup(player))
    {

    }
	OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

Group* OutdoorPvPAI::GetGroupPlayer(ObjectGuid guid, TeamId TeamId)
{
    for (GuidSet::const_iterator itr = m_Groups[TeamId].begin(); itr != m_Groups[TeamId].end(); ++itr)
        if (Group* group = sGroupMgr->GetGroupByGUID(itr->GetCounter()))
            if (group->IsMember(guid))
                return group;

    return nullptr;
}

void OutdoorPvPAI::HandlePlayerLeaveZone(Player *plr, uint32 zone)
{
    if(Group* group = GetGroupPlayer(plr->GetGUID(), plr->GetTeamId()))
    {
        if (!group->RemoveMember(plr->GetGUID()))       
        {
            m_Groups[plr->GetTeamId()].erase(group->GetGUID());
            group->SetBattlegroundGroup(NULL);
        }
    }

    OutdoorPvP::HandlePlayerLeaveZone(plr, zone);
}

class OutdoorPvP_autogroup : public OutdoorPvPScript
{
    public:

        OutdoorPvP_autogroup()
            : OutdoorPvPScript("outdoorpvp_ai")
        {
        }

        OutdoorPvP* GetOutdoorPvP() const
        {
            return new OutdoorPvPAI();
        }
};

void AddSC_outdoorpvp_autogroup()
{
    new OutdoorPvP_autogroup();
}
