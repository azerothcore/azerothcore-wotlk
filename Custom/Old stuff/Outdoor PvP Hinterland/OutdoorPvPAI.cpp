/*
    ----
    ---- OUTDOOR PVP - AUTOINVITE v1
    
  
*/

#include "OutdoorPvPAI.h"
#include "OutdoorPvPMgr.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "OutdoorPvP.h"
#include "OutdoorPvPMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldPacket.h"

OutdoorPvPAI::OutdoorPvPAI()
{
    m_TypeId = OUTDOOR_PVP_AI;
}

bool OutdoorPvPAI::SetupOutdoorPvP()
{
    for (int i = 0; i < OutdoorPvPHPBuffZonesNum; ++i)
        RegisterZone(OutdoorPvPHPBuffZones[i]);

    return true;
}

Group * OutdoorPvPAI::GetFreeBfRaid(uint32 TeamId)
{
    uint32 itrtemp;
    GuidSet::iterator itr;
    for(itr =m_Groups[TeamId].begin();itr!=m_Groups[TeamId].end();++itr)
    {
        itrtemp = (uint32) itr;
           Group* group = sGroupMgr->GetGroupByGUID(itrtemp);
           if (!group->IsFull())
               return group;
    }
    return NULL;
}

bool OutdoorPvPAI::AddOrSetPlayerToCorrectBfGroup(Player *plr)
{
    if(!plr->IsInWorld())
        return false;

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
        //group->SetBattlegroundOrBattlefieldRaid(group, subgroup);
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

Group* OutdoorPvPAI::GetGroupPlayer(uint32 guid, uint32 TeamId)
{
    int itrtemp;
    GuidSet::iterator itr;
    for(itr=m_Groups[TeamId].begin();itr!=m_Groups[TeamId].end();++itr)
    {
        itrtemp = (int) itr;
        if (Group* group = sGroupMgr->GetGroupByGUID(itrtemp))
            if (group->IsMember(guid))
                return group;
    }
    return NULL;
}

void OutdoorPvPAI::HandlePlayerLeaveZone(Player* plr, uint32 zone)
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