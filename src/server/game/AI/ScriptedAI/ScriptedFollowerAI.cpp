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

/* ScriptData
SDName: FollowerAI
SD%Complete: 50
SDComment: This AI is under development
SDCategory: Npc
EndScriptData */

#include "ScriptedFollowerAI.h"
#include "Group.h"
#include "Player.h"
#include "ScriptedCreature.h"

const float MAX_PLAYER_DISTANCE = 100.0f;

enum ePoints
{
    POINT_COMBAT_START  = 0xFFFFFF
};

FollowerAI::FollowerAI(Creature* creature) : ScriptedAI(creature),
    m_uiUpdateFollowTimer(2500),
    m_uiFollowState(STATE_FOLLOW_NONE),
    m_pQuestForFollow(nullptr)
{}

void FollowerAI::AttackStart(Unit* who)
{
    if (!who)
        return;

    if (me->Attack(who, true))
    {
        // This is done in Unit::Attack function which wont bug npcs by not adding threat upon combat start...
        //me->AddThreat(who, 0.0f);
        //me->SetInCombatWith(who);
        //who->SetInCombatWith(me);

        if (me->HasUnitState(UNIT_STATE_FOLLOW))
            me->ClearUnitState(UNIT_STATE_FOLLOW);

        if (me->IsCombatMovementAllowed())
            me->GetMotionMaster()->MoveChase(who);
    }
}

//This part provides assistance to a player that are attacked by who, even if out of normal aggro range
//It will cause me to attack who that are attacking _any_ player (which has been confirmed may happen also on offi)
//The flag (type_flag) is unconfirmed, but used here for further research and is a good candidate.
bool FollowerAI::AssistPlayerInCombatAgainst(Unit* who)
{
    if (!who || !who->GetVictim())
        return false;

    //experimental (unknown) flag not present
    if (!(me->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_CAN_ASSIST))
        return false;

    //not a player
    if (!who->GetVictim()->GetCharmerOrOwnerPlayerOrPlayerItself())
        return false;

    //never attack friendly
    if (me->IsFriendlyTo(who))
        return false;

    //too far away and no free sight?
    if (me->IsWithinDistInMap(who, MAX_PLAYER_DISTANCE) && me->IsWithinLOSInMap(who))
    {
        AttackStart(who);
        return true;
    }

    return false;
}

void FollowerAI::MoveInLineOfSight(Unit* who)
{
    if (me->GetVictim())
        return;

    if (!me->HasUnitState(UNIT_STATE_STUNNED) && who->isTargetableForAttack(true, me) && who->isInAccessiblePlaceFor(me))
        if (HasFollowState(STATE_FOLLOW_INPROGRESS) && AssistPlayerInCombatAgainst(who))
            return;

    if (me->HasReactState(REACT_AGGRESSIVE) && me->CanStartAttack(who))
    {
        if (me->HasUnitState(UNIT_STATE_DISTRACTED))
        {
            me->ClearUnitState(UNIT_STATE_DISTRACTED);
            me->GetMotionMaster()->Clear();
        }
        AttackStart(who);
    }
}

void FollowerAI::JustDied(Unit* /*pKiller*/)
{
    if (!HasFollowState(STATE_FOLLOW_INPROGRESS) || !m_uiLeaderGUID || !m_pQuestForFollow)
        return;

    //TODO: need a better check for quests with time limit.
    if (Player* player = GetLeaderForFollower())
    {
        if (Group* group = player->GetGroup())
        {
            for (GroupReference* groupRef = group->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
            {
                if (Player* member = groupRef->GetSource())
                {
                    if (member->IsInMap(player) && member->GetQuestStatus(m_pQuestForFollow->GetQuestId()) == QUEST_STATUS_INCOMPLETE)
                        member->FailQuest(m_pQuestForFollow->GetQuestId());
                }
            }
        }
        else
        {
            if (player->GetQuestStatus(m_pQuestForFollow->GetQuestId()) == QUEST_STATUS_INCOMPLETE)
                player->FailQuest(m_pQuestForFollow->GetQuestId());
        }
    }
}

void FollowerAI::JustRespawned()
{
    m_uiFollowState = STATE_FOLLOW_NONE;

    if (!me->IsCombatMovementAllowed())
        me->SetCombatMovement(true);

    if (me->GetFaction() != me->GetCreatureTemplate()->faction)
        me->SetFaction(me->GetCreatureTemplate()->faction);

    Reset();
}

void FollowerAI::EnterEvadeMode(EvadeReason /*why*/)
{
    me->RemoveAllAuras();
    me->GetThreatMgr().ClearAllThreat();
    me->CombatStop(true);
    me->SetLootRecipient(nullptr);

    if (HasFollowState(STATE_FOLLOW_INPROGRESS))
    {
        LOG_DEBUG("scripts.ai", "FollowerAI left combat, returning to CombatStartPosition.");

        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
        {
            float fPosX, fPosY, fPosZ;
            me->GetPosition(fPosX, fPosY, fPosZ);
            me->GetMotionMaster()->MovePoint(POINT_COMBAT_START, fPosX, fPosY, fPosZ);
        }
    }
    else
    {
        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
            me->GetMotionMaster()->MoveTargetedHome();
    }

    Reset();
}

void FollowerAI::UpdateAI(uint32 uiDiff)
{
    if (HasFollowState(STATE_FOLLOW_INPROGRESS) && !me->GetVictim())
    {
        if (m_uiUpdateFollowTimer <= uiDiff)
        {
            if (HasFollowState(STATE_FOLLOW_COMPLETE) && !HasFollowState(STATE_FOLLOW_POSTEVENT))
            {
                LOG_DEBUG("scripts.ai", "FollowerAI is set completed, despawns.");
                me->DespawnOrUnsummon();
                return;
            }

            bool bIsMaxRangeExceeded = true;

            if (Player* player = GetLeaderForFollower())
            {
                if (HasFollowState(STATE_FOLLOW_RETURNING))
                {
                    LOG_DEBUG("scripts.ai", "FollowerAI is returning to leader.");

                    RemoveFollowState(STATE_FOLLOW_RETURNING);
                    me->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                    return;
                }

                if (Group* group = player->GetGroup())
                {
                    for (GroupReference* groupRef = group->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                    {
                        Player* member = groupRef->GetSource();

                        if (member && me->IsWithinDistInMap(member, MAX_PLAYER_DISTANCE, true, false))
                        {
                            bIsMaxRangeExceeded = false;
                            break;
                        }
                    }
                }
                else
                {
                    if (me->IsWithinDistInMap(player, MAX_PLAYER_DISTANCE, true, false))
                        bIsMaxRangeExceeded = false;
                }
            }

            if (bIsMaxRangeExceeded)
            {
                LOG_DEBUG("scripts.ai", "FollowerAI failed because player/group was to far away or not found");
                me->DespawnOrUnsummon();
                return;
            }

            m_uiUpdateFollowTimer = 1000;
        }
        else
            m_uiUpdateFollowTimer -= uiDiff;
    }

    UpdateFollowerAI(uiDiff);
}

void FollowerAI::UpdateFollowerAI(uint32 /*uiDiff*/)
{
    if (!UpdateVictim())
        return;

    DoMeleeAttackIfReady();
}

void FollowerAI::MovementInform(uint32 motionType, uint32 pointId)
{
    if (motionType != POINT_MOTION_TYPE || !HasFollowState(STATE_FOLLOW_INPROGRESS))
        return;

    if (pointId == POINT_COMBAT_START)
    {
        if (GetLeaderForFollower())
        {
            if (!HasFollowState(STATE_FOLLOW_PAUSED))
                AddFollowState(STATE_FOLLOW_RETURNING);
        }
        else
            me->DespawnOrUnsummon();
    }
}

void FollowerAI::StartFollow(Player* player, uint32 factionForFollower, const Quest* quest)
{
    if (me->GetVictim())
    {
        LOG_DEBUG("scripts.ai", "FollowerAI attempt to StartFollow while in combat.");
        return;
    }

    if (HasFollowState(STATE_FOLLOW_INPROGRESS))
    {
        LOG_ERROR("entities.unit.ai", "FollowerAI attempt to StartFollow while already following.");
        return;
    }

    //set variables
    m_uiLeaderGUID = player->GetGUID();

    if (factionForFollower)
        me->SetFaction(factionForFollower);

    m_pQuestForFollow = quest;

    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == WAYPOINT_MOTION_TYPE)
    {
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MoveIdle();
        LOG_DEBUG("scripts.ai", "FollowerAI start with WAYPOINT_MOTION_TYPE, set to MoveIdle.");
    }

    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);

    AddFollowState(STATE_FOLLOW_INPROGRESS);

    me->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);

    LOG_DEBUG("scripts.ai", "FollowerAI start follow {} ({})", player->GetName(), m_uiLeaderGUID.ToString());
}

Player* FollowerAI::GetLeaderForFollower()
{
    if (Player* player = ObjectAccessor::GetPlayer(*me, m_uiLeaderGUID))
    {
        if (player->IsAlive())
            return player;
        else
        {
            if (Group* group = player->GetGroup())
            {
                for (GroupReference* groupRef = group->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                {
                    Player* member = groupRef->GetSource();

                    if (member && me->IsWithinDistInMap(member, MAX_PLAYER_DISTANCE) && member->IsAlive())
                    {
                        LOG_DEBUG("scripts.ai", "FollowerAI GetLeader changed and returned new leader.");
                        m_uiLeaderGUID = member->GetGUID();
                        return member;
                    }
                }
            }
        }
    }

    LOG_DEBUG("scripts.ai", "FollowerAI GetLeader can not find suitable leader.");
    return nullptr;
}

void FollowerAI::SetFollowComplete(bool bWithEndEvent)
{
    if (me->HasUnitState(UNIT_STATE_FOLLOW))
    {
        me->ClearUnitState(UNIT_STATE_FOLLOW);

        me->StopMoving();
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MoveIdle();
    }

    if (bWithEndEvent)
        AddFollowState(STATE_FOLLOW_POSTEVENT);
    else
    {
        if (HasFollowState(STATE_FOLLOW_POSTEVENT))
            RemoveFollowState(STATE_FOLLOW_POSTEVENT);
    }

    AddFollowState(STATE_FOLLOW_COMPLETE);
}

void FollowerAI::SetFollowPaused(bool paused)
{
    if (!HasFollowState(STATE_FOLLOW_INPROGRESS) || HasFollowState(STATE_FOLLOW_COMPLETE))
        return;

    if (paused)
    {
        AddFollowState(STATE_FOLLOW_PAUSED);

        if (me->HasUnitState(UNIT_STATE_FOLLOW))
        {
            me->ClearUnitState(UNIT_STATE_FOLLOW);

            me->StopMoving();
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
        }
    }
    else
    {
        RemoveFollowState(STATE_FOLLOW_PAUSED);

        if (Player* leader = GetLeaderForFollower())
            me->GetMotionMaster()->MoveFollow(leader, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
    }
}
