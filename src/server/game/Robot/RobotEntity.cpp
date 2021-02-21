#include "RobotEntity.h"
#include "RobotManager.h"
#include "RobotConfig.h"
#include "AI_Base.h"
#include "Script_Base.h"
#include "Group.h"

RobotEntity::RobotEntity(uint32 pmRobotID)
{
    robot_id = pmRobotID;
    account_id = 0;
    account_name = "";
    character_id = 0;
    target_level = 0;
    robot_type = 0;
    checkDelay = 5 * TimeConstants::IN_MILLISECONDS;
    entityState = RobotEntityState::RobotEntityState_OffLine;
}

void RobotEntity::Update(uint32 pmDiff)
{
    checkDelay -= pmDiff;
    if (checkDelay < 0)
    {
        checkDelay = 5 * TimeConstants::IN_MILLISECONDS;
        switch (entityState)
        {
        case RobotEntityState::RobotEntityState_None:
        {
            checkDelay = urand(5 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS, 10 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS);
            break;
        }
        case RobotEntityState::RobotEntityState_OffLine:
        {
            checkDelay = urand(5 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS, 10 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS);
            break;
        }
        case RobotEntityState::RobotEntityState_Enter:
        {
            entityState = RobotEntityState::RobotEntityState_CheckAccount;
            sLog->outBasic("Robot %s is ready to go online.", account_name.c_str());
            break;
        }
        case RobotEntityState::RobotEntityState_CheckAccount:
        {
            if (account_name.empty())
            {
                entityState = RobotEntityState::RobotEntityState_None;
            }
            else
            {
                account_id = sRobotManager->CheckRobotAccount(account_name);
                if (account_id > 0)
                {
                    sLog->outBasic("Robot %s is ready.", account_name.c_str());
                    entityState = RobotEntityState::RobotEntityState_CheckCharacter;
                }
                else
                {
                    sLog->outBasic("Robot %s is not ready.", account_name.c_str());
                    entityState = RobotEntityState::RobotEntityState_CreateAccount;
                }
            }
            break;
        }
        case RobotEntityState::RobotEntityState_CreateAccount:
        {
            if (account_name.empty())
            {
                entityState = RobotEntityState::RobotEntityState_None;
            }
            else
            {
                if (!sRobotManager->CreateRobotAccount(account_name))
                {
                    sLog->outBasic("Robot id %d create account failed.", robot_id);
                    entityState = RobotEntityState::RobotEntityState_None;
                }
                else
                {
                    entityState = RobotEntityState::RobotEntityState_CheckAccount;
                }
            }
            break;
        }
        case RobotEntityState::RobotEntityState_CheckCharacter:
        {
            character_id = sRobotManager->CheckAccountCharacter(account_id);
            if (character_id > 0)
            {
                sLog->outBasic("Robot account_id %d character_id %d is ready.", account_id, character_id);
                entityState = RobotEntityState::RobotEntityState_DoLogin;
            }
            else
            {
                sLog->outBasic("Robot account_id %d character_id is not ready.", account_id);
                entityState = RobotEntityState::RobotEntityState_CreateCharacter;
            }
            break;
        }
        case RobotEntityState::RobotEntityState_CreateCharacter:
        {
            if (robot_type == RobotType::RobotType_World)
            {
                character_id = sRobotManager->CreateRobotCharacter(account_id, RobotCampType::RobotCampType_Alliance);
            }
            else if (robot_type == RobotType::RobotType_Raid)
            {
                uint32  targetClass = Classes::CLASS_PALADIN;
                uint32 raceIndex = urand(0, sRobotManager->availableRaces[targetClass].size() - 1);
                uint32 targetRace = sRobotManager->availableRaces[targetClass][raceIndex];
                character_id = sRobotManager->CreateRobotCharacter(account_id, targetClass, targetRace);
            }
            if (character_id > 0)
            {
                std::ostringstream sqlStream;
                sqlStream << "update robot set character_id = " << character_id << " where robot_id = " << robot_id;
                std::string sql = sqlStream.str();
                CharacterDatabase.DirectExecute(sql.c_str());
                entityState = RobotEntityState::RobotEntityState_CheckCharacter;
            }
            else
            {
                entityState = RobotEntityState::RobotEntityState_None;
            }
            break;
        }
        case RobotEntityState::RobotEntityState_DoLogin:
        {
            sRobotManager->LoginRobot(account_id, character_id);
            checkDelay = 10 * TimeConstants::IN_MILLISECONDS;
            entityState = RobotEntityState::RobotEntityState_CheckLogin;
            break;
        }
        case RobotEntityState::RobotEntityState_CheckLogin:
        {
            checkDelay = 5 * TimeConstants::IN_MILLISECONDS;
            Player* me = sRobotManager->CheckLogin(account_id, character_id);
            if (me)
            {
                account_id = account_id;
                character_id = character_id;
                entityState = RobotEntityState::RobotEntityState_Initialize;
            }
            else
            {
                entityState = RobotEntityState::RobotEntityState_None;
            }
            break;
        }
        case RobotEntityState::RobotEntityState_Initialize:
        {
            checkDelay = 5 * TimeConstants::IN_MILLISECONDS;
            uint64 guid = MAKE_NEW_GUID(character_id, 0, HIGHGUID_PLAYER);
            if (Player* me = ObjectAccessor::FindPlayer(guid))
            {
                sRobotManager->InitializeCharacter(me, target_level);
                if (AI_Base* myAI = me->robotAI)
                {
                    myAI->sb->Initialize();
                    myAI->Reset();
                }
                entityState = RobotEntityState::RobotEntityState_Online;
            }
            else
            {
                entityState = RobotEntityState::RobotEntityState_None;
            }
            break;
        }
        case RobotEntityState::RobotEntityState_Online:
        {
            checkDelay = urand(10 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS, 20 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS);
            uint64 guid = MAKE_NEW_GUID(character_id, 0, HIGHGUID_PLAYER);
            if (Player* me = ObjectAccessor::FindPlayer(guid))
            {
                sRobotManager->PrepareRobot(me);
            }
            break;
        }
        case RobotEntityState::RobotEntityState_Exit:
        {
            uint64 guid = MAKE_NEW_GUID(character_id, 0, HIGHGUID_PLAYER);
            if (Player* me = ObjectAccessor::FindPlayer(guid))
            {
                if (me->GetGroup())
                {
                    entityState = RobotEntityState::RobotEntityState_Online;
                    break;
                }
            }
            sLog->outBasic("Robot %d is ready to go offline.", robot_id);
            entityState = RobotEntityState::RobotEntityState_DoLogoff;
            break;
        }
        case RobotEntityState::RobotEntityState_DoLogoff:
        {
            sRobotManager->LogoutRobot(character_id);
            entityState = RobotEntityState::RobotEntityState_CheckLogoff;
            break;
        }
        case RobotEntityState::RobotEntityState_CheckLogoff:
        {
            uint64 guid = MAKE_NEW_GUID(character_id, 0, HIGHGUID_PLAYER);
            if (Player* me = ObjectAccessor::FindPlayer(guid))
            {
                sLog->outError("Log out robot %s failed", me->GetName().c_str());
                entityState = RobotEntityState::RobotEntityState_None;
                break;
            }
            entityState = RobotEntityState::RobotEntityState_OffLine;
            break;
        }
        default:
        {
            checkDelay = urand(5 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS, 10 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS);
            break;
        }
        }
    }
}
