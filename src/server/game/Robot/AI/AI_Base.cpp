#include "AI_Base.h"
#include "Script_Warrior.h"
#include "Script_Hunter.h"
#include "Script_Shaman.h"
#include "Script_Paladin.h"
#include "Script_Warlock.h"
#include "Script_Priest.h"
#include "Script_Rogue.h"
#include "Script_Mage.h"
#include "Script_Druid.h"
#include "RobotConfig.h"
#include "RobotManager.h"
#include "Group.h"
#include "MotionMaster.h"
#include "GridNotifiers.h"
#include "Map.h"
#include "Pet.h"
#include "MapManager.h"

AI_Base::AI_Base(Player* pmMe)
{
    me = pmMe;
    groupRole = GroupRole::GroupRole_DPS;
    engageTarget = NULL;
    eatDelay = 0;
    drinkDelay = 0;
    engageDelay = 0;

    switch (me->getClass())
    {
    case Classes::CLASS_WARRIOR:
    {
        sb = new Script_Warrior(me);
        break;
    }
    case Classes::CLASS_HUNTER:
    {
        sb = new Script_Hunter(me);
        break;
    }
    case Classes::CLASS_SHAMAN:
    {
        sb = new Script_Shaman(me);
        break;
    }
    case Classes::CLASS_PALADIN:
    {
        sb = new Script_Paladin(me);
        break;
    }
    case Classes::CLASS_WARLOCK:
    {
        sb = new Script_Warlock(me);
        break;
    }
    case Classes::CLASS_PRIEST:
    {
        sb = new Script_Priest(me);
        break;
    }
    case Classes::CLASS_ROGUE:
    {
        sb = new Script_Rogue(me);
        break;
    }
    case Classes::CLASS_MAGE:
    {
        sb = new Script_Mage(me);
        break;
    }
    case Classes::CLASS_DRUID:
    {
        sb = new Script_Druid(me);
        break;
    }
    default:
    {
        sb = new Script_Base(me);
        break;
    }
    }
}

void AI_Base::Reset()
{
    engageDelay = 0;
    combatTime = 0;
    teleportAssembleDelay = 0;
    eatDelay = 0;
    drinkDelay = 0;
    readyCheckDelay = 0;
    staying = false;
    holding = false;
    following = true;
    cure = true;
    aoe = true;
    moveDelay = 0;
    actionType = 0;
    actionDelay = 0;
    dpsDelay = sRobotConfig->DPSDelay;
    followDistance = FOLLOW_NORMAL_DISTANCE;
    uint32 maxTalentCountTab = me->GetMaxTalentCountTab();
    switch (me->getClass())
    {
    case Classes::CLASS_WARRIOR:
    {
        followDistance = MELEE_MIN_DISTANCE;
        break;
    }
    case Classes::CLASS_HUNTER:
    {
        break;
    }
    case Classes::CLASS_SHAMAN:
    {
        if (maxTalentCountTab == 0 || maxTalentCountTab == 1)
        {
            followDistance = MELEE_MIN_DISTANCE;
        }
        break;
    }
    case Classes::CLASS_PALADIN:
    {
        if (groupRole != GroupRole::GroupRole_Healer)
        {
            followDistance = MELEE_MIN_DISTANCE;
        }
        break;
    }
    case Classes::CLASS_WARLOCK:
    {
        break;
    }
    case Classes::CLASS_PRIEST:
    {
        break;
    }
    case Classes::CLASS_ROGUE:
    {
        followDistance = MELEE_MIN_DISTANCE;
        break;
    }
    case Classes::CLASS_MAGE:
    {
        break;
    }
    case Classes::CLASS_DRUID:
    {
        followDistance = MELEE_MIN_DISTANCE;
        break;
    }
    default:
    {
        break;
    }
    }
    sb->Reset();
}

bool AI_Base::Chasing()
{
    if (holding)
    {
        return false;
    }
    return true;
}

void AI_Base::Update(uint32 pmDiff)
{
    if (!me)
    {
        return;
    }
    if (WorldSession* mySesson = me->GetSession())
    {
        if (mySesson->isRobotSession)
        {
            sb->Update(pmDiff);
            if (Group* myGroup = me->GetGroup())
            {
                if (readyCheckDelay > 0)
                {
                    readyCheckDelay -= pmDiff;
                    if (readyCheckDelay <= 0)
                    {
                        if (Group* myGroup = me->GetGroup())
                        {
                            if (Player* leaderPlayer = ObjectAccessor::FindPlayer(myGroup->GetLeaderGUID()))
                            {
                                if (WorldSession* leaderWS = leaderPlayer->GetSession())
                                {
                                    if (!leaderWS->isRobotSession)
                                    {
                                        uint8 readyCheckValue = 0;
                                        if (!me->IsAlive())
                                        {
                                            readyCheckValue = 0;
                                        }
                                        else if (me->GetDistance(leaderPlayer) > DEFAULT_VISIBILITY_DISTANCE)
                                        {
                                            readyCheckValue = 0;
                                        }
                                        else
                                        {
                                            readyCheckValue = 1;
                                        }
                                        WorldPacket data(MSG_RAID_READY_CHECK, 8);
                                        data << readyCheckValue;
                                        if (WorldSession* myWS = me->GetSession())
                                        {
                                            myWS->HandleRaidReadyCheckOpcode(data);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                if (moveDelay > 0)
                {
                    moveDelay -= pmDiff;
                    return;
                }
                if (teleportAssembleDelay > 0)
                {
                    teleportAssembleDelay -= pmDiff;
                    if (teleportAssembleDelay <= 0)
                    {
                        Player* leaderPlayer = nullptr;
                        bool canTeleport = true;
                        for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                        {
                            if (Player* member = groupRef->GetSource())
                            {
                                if (member->GetGUID() == myGroup->GetLeaderGUID())
                                {
                                    leaderPlayer = member;
                                }
                                if (member->IsBeingTeleported())
                                {
                                    sRobotManager->WhisperTo(leaderPlayer, "Some one is teleporting. I will wait.", Language::LANG_UNIVERSAL, me);
                                    teleportAssembleDelay = 2000;
                                    canTeleport = false;
                                    break;
                                }
                            }
                        }
                        if (canTeleport)
                        {
                            if (leaderPlayer)
                            {
                                if (leaderPlayer->IsInWorld())
                                {
                                    if (!me->IsAlive())
                                    {
                                        me->ResurrectPlayer(0.2f);
                                        me->SpawnCorpseBones();
                                    }
                                    me->getThreatManager().clearReferences();
                                    me->ClearInCombat();
                                    sb->ClearTarget();
                                    if (me->TeleportTo(leaderPlayer->GetMapId(), leaderPlayer->GetPositionX(), leaderPlayer->GetPositionY(), leaderPlayer->GetPositionZ(), leaderPlayer->GetOrientation()))
                                    {
                                        sRobotManager->WhisperTo(leaderPlayer, "I have come", Language::LANG_UNIVERSAL, me);
                                        return;
                                    }
                                    else
                                    {
                                        sRobotManager->WhisperTo(leaderPlayer, "I can not come to you", Language::LANG_UNIVERSAL, me);
                                    }
                                }
                                else
                                {
                                    sRobotManager->WhisperTo(leaderPlayer, "Leader is not in world", Language::LANG_UNIVERSAL, me);
                                }
                            }
                            else
                            {
                                sRobotManager->WhisperTo(leaderPlayer, "Can not find leader", Language::LANG_UNIVERSAL, me);
                            }
                        }
                    }
                }
                if (staying)
                {
                    return;
                }

                bool groupInCombat = GroupInCombat();
                if (groupInCombat)
                {
                    eatDelay = 0;
                    drinkDelay = 0;
                    combatTime += pmDiff;
                }
                else
                {
                    combatTime = 0;
                }
                if (engageDelay > 0)
                {
                    engageDelay -= pmDiff;
                    if (engageDelay <= 0)
                    {
                        sb->rm->ResetMovement();
                        sb->ClearTarget();
                        return;
                    }
                    if (me->IsAlive())
                    {
                        switch (groupRole)
                        {
                        case GroupRole::GroupRole_DPS:
                        {
                            if (sb->DPS(engageTarget, Chasing(), aoe))
                            {
                                return;
                            }
                            else
                            {
                                engageTarget = NULL;
                                engageDelay = 0;
                            }
                            break;
                        }
                        case GroupRole::GroupRole_Healer:
                        {
                            if (Heal())
                            {
                                return;
                            }
                            break;
                        }
                        case GroupRole::GroupRole_Tank:
                        {
                            if (sb->Tank(engageTarget, Chasing(), aoe))
                            {
                                return;
                            }
                            else
                            {
                                engageTarget = NULL;
                                engageDelay = 0;
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                        }
                    }
                    return;
                }
                if (assistDelay > 0)
                {
                    assistDelay -= pmDiff;
                    if (sb->Assist())
                    {
                        return;
                    }
                    else
                    {
                        assistDelay = 0;
                    }
                }
                if (groupInCombat)
                {
                    if (sb->Assist())
                    {
                        return;
                    }
                    switch (groupRole)
                    {
                    case GroupRole::GroupRole_DPS:
                    {
                        if (DPS())
                        {
                            return;
                        }
                        break;
                    }
                    case GroupRole::GroupRole_Healer:
                    {
                        if (Heal())
                        {
                            return;
                        }
                        break;
                    }
                    case GroupRole::GroupRole_Tank:
                    {
                        if (Tank())
                        {
                            return;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                    }
                }
                else
                {
                    if (eatDelay > 0)
                    {
                        eatDelay -= pmDiff;
                        if (drinkDelay > 0)
                        {
                            drinkDelay -= pmDiff;
                            if (drinkDelay <= 0)
                            {
                                sb->Drink();
                            }
                        }
                        return;
                    }
                    switch (groupRole)
                    {
                    case GroupRole::GroupRole_DPS:
                    {
                        if (Rest())
                        {
                            return;
                        }
                        if (Buff())
                        {
                            return;
                        }
                        break;
                    }
                    case GroupRole::GroupRole_Healer:
                    {
                        if (Rest())
                        {
                            return;
                        }
                        if (Heal())
                        {
                            return;
                        }
                        if (Buff())
                        {
                            return;
                        }
                        break;
                    }
                    case GroupRole::GroupRole_Tank:
                    {
                        if (Rest())
                        {
                            return;
                        }
                        if (Buff())
                        {
                            return;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                    }
                }
                Follow();
            }
        }
    }
}

bool AI_Base::GroupInCombat()
{
    if (!me)
    {
        return false;
    }
    if (Group* myGroup = me->GetGroup())
    {
        for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
        {
            if (Player* member = groupRef->GetSource())
            {
                if (member->IsInCombat())
                {
                    if (me->GetDistance(member) < ATTACK_RANGE_LIMIT)
                    {
                        return true;
                    }
                }
                else if (Pet* memberPet = member->GetPet())
                {
                    if (memberPet->IsAlive())
                    {
                        if (memberPet->IsInCombat())
                        {
                            if (me->GetDistance(memberPet) < ATTACK_RANGE_LIMIT)
                            {
                                return true;
                            }
                        }
                    }
                }
            }
        }
    }

    return false;
}

bool AI_Base::Engage(Unit* pmTarget)
{
    if (!me)
    {
        return false;
    }
    switch (groupRole)
    {
    case GroupRole::GroupRole_Tank:
    {
        return sb->Tank(pmTarget, Chasing(), aoe);
    }
    case GroupRole::GroupRole_DPS:
    {
        return sb->DPS(pmTarget, Chasing(), aoe);
    }
    case GroupRole::GroupRole_Healer:
    {
        return Heal();
    }
    default:
    {
        break;
    }
    }

    return false;
}

bool AI_Base::DPS()
{
    if (combatTime > dpsDelay)
    {
        if (!me)
        {
            return false;
        }
        if (!me->IsAlive())
        {
            return false;
        }
        if (Group* myGroup = me->GetGroup())
        {
            // icon only 
            if (Unit* target = ObjectAccessor::GetUnit(*me, myGroup->GetOGByTargetIcon(7)))
            {
                if (sb->DPS(target, Chasing(), aoe))
                {
                    return true;
                }
            }
        }
    }

    return false;
}

bool AI_Base::Tank()
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (Group* myGroup = me->GetGroup())
    {
        // icon ot 
        if (Unit* target = ObjectAccessor::GetUnit(*me, myGroup->GetOGByTargetIcon(7)))
        {
            if (target->GetTarget())
            {
                if (target->GetTarget() != me->GetGUID())
                {
                    for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                    {
                        if (Player* member = groupRef->GetSource())
                        {
                            if (target->GetTarget() == member->GetGUID())
                            {
                                if (sb->Tank(target, Chasing(), aoe))
                                {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
        }
        // ot 
        Unit* nearestAttacker = nullptr;
        float nearestDistance = ATTACK_RANGE_LIMIT;
        for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
        {
            if (Player* member = groupRef->GetSource())
            {
                if (member->IsAlive())
                {
                    for (Unit::AttackerSet::const_iterator ait = member->getAttackers().begin(); ait != member->getAttackers().end(); ++ait)
                    {
                        if (Unit* eachAttacker = *ait)
                        {
                            if (eachAttacker->IsAlive())
                            {
                                if (me->IsValidAttackTarget(eachAttacker))
                                {
                                    if (eachAttacker->GetTarget())
                                    {
                                        if (eachAttacker->GetTarget() != me->GetGUID())
                                        {
                                            float eachDistance = me->GetDistance(eachAttacker);
                                            if (eachDistance < nearestDistance)
                                            {
                                                if (myGroup->GetTargetIconByOG(eachAttacker->GetGUID()) == -1)
                                                {
                                                    nearestDistance = eachDistance;
                                                    nearestAttacker = eachAttacker;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (nearestAttacker)
        {
            if (sb->Tank(nearestAttacker, Chasing(), aoe))
            {
                myGroup->SetTargetIcon(7, me->GetGUID(), nearestAttacker->GetGUID());
                return true;
            }
        }
        // icon 
        if (Unit* target = ObjectAccessor::GetUnit(*me, myGroup->GetOGByTargetIcon(7)))
        {
            if (sb->Tank(target, Chasing(), aoe))
            {
                return true;
            }
        }
    }

    return false;
}

bool AI_Base::Tank(Unit* pmTarget)
{
    if (!me)
    {
        return false;
    }
    switch (groupRole)
    {
    case GroupRole::GroupRole_Tank:
    {
        return sb->Tank(pmTarget, Chasing(), aoe);
    }
    default:
    {
        break;
    }
    }

    return false;
}

bool AI_Base::Rest()
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    bool canTry = false;
    if (me->GetHealthPct() < 40.0f)
    {
        canTry = true;
    }
    if (me->getPowerType() == Powers::POWER_MANA)
    {
        if (me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA) < 40.0f)
        {
            canTry = true;
        }
    }
    if (canTry)
    {
        if (sb->Eat())
        {
            eatDelay = DEFAULT_REST_DELAY;
            drinkDelay = 1000;
            return true;
        }
    }

    return false;
}

bool AI_Base::Heal()
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (Group* myGroup = me->GetGroup())
    {
        std::unordered_map<uint32, Player*> lowMemberMap;
        for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
        {
            if (Player* member = groupRef->GetSource())
            {
                if (me->GetDistance(member) < HEAL_MAX_DISTANCE)
                {
                    if (cure)
                    {
                        if (sb->Cure(member))
                        {
                            return true;
                        }
                    }
                    if (member->robotAI->groupRole == GroupRole::GroupRole_Tank)
                    {
                        if (sb->Heal(member))
                        {
                            return true;
                        }
                    }
                    if (member->IsAlive())
                    {
                        if (member->GetHealthPct() < 50.0f)
                        {
                            lowMemberMap[lowMemberMap.size()] = member;
                        }
                    }
                }
            }
        }
        if (lowMemberMap.size() > 2)
        {
            if (sb->GroupHeal())
            {
                return true;
            }
        }
        else if (lowMemberMap.size() > 0)
        {
            if (sb->Heal(lowMemberMap[0]))
            {
                return true;
            }
        }
    }

    return false;
}

bool AI_Base::Buff()
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (Group* myGroup = me->GetGroup())
    {
        for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
        {
            if (Player* member = groupRef->GetSource())
            {
                if (sb->Buff(member, cure))
                {
                    return true;
                }
            }
        }
    }

    return false;
}

bool AI_Base::Follow()
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (holding)
    {
        return false;
    }
    if (!following)
    {
        return false;
    }
    if (Group* myGroup = me->GetGroup())
    {
        if (Player* leader = ObjectAccessor::GetPlayer(*me, myGroup->GetLeaderGUID()))
        {
            if (sb->Follow(leader, followDistance))
            {
                return true;
            }
        }
    }

    return false;
}

bool AI_Base::Stay(std::string pmTargetGroupRole)
{
    if (!me)
    {
        return false;
    }
    bool todo = true;
    if (pmTargetGroupRole == "dps")
    {
        if (groupRole != GroupRole::GroupRole_DPS)
        {
            todo = false;
        }
    }
    else if (pmTargetGroupRole == "healer")
    {
        if (groupRole != GroupRole::GroupRole_Healer)
        {
            todo = false;
        }
    }
    else if (pmTargetGroupRole == "tank")
    {
        if (groupRole != GroupRole::GroupRole_Tank)
        {
            todo = false;
        }
    }

    if (todo)
    {
        me->StopMoving();
        me->GetMotionMaster()->Clear();
        me->AttackStop();
        me->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
        sb->PetStop();
        sb->rm->ResetMovement();
        staying = true;
        return true;
    }

    return false;
}

bool AI_Base::Hold(std::string pmTargetGroupRole)
{
    if (!me)
    {
        return false;
    }
    bool todo = true;
    if (pmTargetGroupRole == "dps")
    {
        if (groupRole != GroupRole::GroupRole_DPS)
        {
            todo = false;
        }
    }
    else if (pmTargetGroupRole == "healer")
    {
        if (groupRole != GroupRole::GroupRole_Healer)
        {
            todo = false;
        }
    }
    else if (pmTargetGroupRole == "tank")
    {
        if (groupRole != GroupRole::GroupRole_Tank)
        {
            todo = false;
        }
    }

    if (todo)
    {
        holding = true;
        staying = false;
        return true;
    }

    return false;
}

std::string AI_Base::GetGroupRoleName()
{
    if (!me)
    {
        return "";
    }
    switch (groupRole)
    {
    case GroupRole::GroupRole_DPS:
    {
        return "dps";
    }
    case GroupRole::GroupRole_Tank:
    {
        return "tank";
    }
    case GroupRole::GroupRole_Healer:
    {
        return "healer";
    }
    default:
    {
        break;
    }
    }
    return "dps";
}

void AI_Base::SetGroupRole(std::string pmRoleName)
{
    if (!me)
    {
        return;
    }
    if (pmRoleName == "dps")
    {
        groupRole = GroupRole::GroupRole_DPS;
    }
    else if (pmRoleName == "tank")
    {
        groupRole = GroupRole::GroupRole_Tank;
    }
    else if (pmRoleName == "healer")
    {
        groupRole = GroupRole::GroupRole_Healer;
    }
}
