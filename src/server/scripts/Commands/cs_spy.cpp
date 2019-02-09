#include "ScriptPCH.h"
#include "Channel.h"
#include "Language.h"
#include "Group.h"

// Maps to store followed players
std::map<uint32,uint32> gmListening;
std::map<uint32,uint32> gmListeningGroup;

class chat_spy_playerscript : public PlayerScript
{
public:
    chat_spy_playerscript() : PlayerScript("chat_spy_playerscript") { }

    void OnChat(Player *sender, uint32 /*type*/, uint32 lang, std::string& msg, Player *receiver)
    {
        if (gmListening.size() > 0 && lang != LANG_ADDON)
        {
            // if the sender or the receiver is being followed
            Player* gm = GetGmFromList(sender);
            if (!gm)
                gm = GetGmFromList(receiver);

            if (gm)
            {
                ChatHandler(gm->GetSession()).PSendSysMessage(LANG_COMMAND_SPY_WHISPERS_PLAYER,
                    sender->GetName().c_str(), receiver ? receiver->GetName().c_str() : "<unknown>", msg.c_str());
            }
        }
    }

    void OnChat(Player* sender, uint32 /*type*/, uint32 lang, std::string& msg, Group* group)
    {
        if(gmListeningGroup.size() > 0 && lang != LANG_ADDON)
            if(Player* gm = GetGmFromGroupList(group))
                ChatHandler(gm->GetSession()).PSendSysMessage(LANG_COMMAND_SPY_TELLS_GROUP,
                    sender->GetName().c_str(), msg.c_str());
    }

    Player* GetGmFromList(Player* from)
    {
        std::map<uint32,uint32>::const_iterator itr = gmListening.find(from->GetGUIDLow());
        return itr != gmListening.end() ? sObjectMgr->GetPlayerByLowGUID(itr->second) : NULL;
    }

    Player* GetGmFromGroupList(Group* group)
    {
        std::map<uint32,uint32>::const_iterator itr = gmListeningGroup.find(group->GetLowGUID());
        return itr != gmListeningGroup.end() ? sObjectMgr->GetPlayerByLowGUID(itr->second) : NULL;
    }
};

class chat_spy_commandscript : public CommandScript
{
public:
    chat_spy_commandscript() : CommandScript("chat_spy_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> spyCommandTable =
        {
            { "follow",         SEC_GAMEMASTER,     false,  &HandleSpyFollowCommand,        ""},
            { "groupfollow",    SEC_ADMINISTRATOR,  false,  &HandleSpyFollowGroupCommand,   ""},
            { "unfollow",       SEC_GAMEMASTER,     false,  &HandleSpyUnFollowCommand,      ""},
            { "groupunfollow",  SEC_ADMINISTRATOR,  false,  &HandleSpyUnFollowGroupCommand, ""},
            { "clear",          SEC_GAMEMASTER,     false,  &HandleSpyClearCommand,         ""},
            { "status",         SEC_GAMEMASTER,     false,  &HandleSpyStatusCommand,        ""}
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "spy",            SEC_GAMEMASTER,     false,  NULL, "", spyCommandTable}
        };

        return commandTable;
    }

    static bool HandleSpyFollowCommand(ChatHandler* handler, const char* args)
    {
        if(!*args)
            return false;

        char *cName = strtok ((char*)args, " ");
        if(!cName)
            return false;

        std::string pTarget = args;
        if(!normalizePlayerName(pTarget))
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            return true;
        }

        if(Player* target = ObjectAccessor::FindPlayer(sObjectMgr->GetPlayerGUIDByName(pTarget.c_str())))
        {
            std::map<uint32,uint32>::const_iterator itr = gmListening.find(target->GetGUIDLow());
            if(itr != gmListening.end())
            {
                if(Player* gm = sObjectMgr->GetPlayerByLowGUID(itr->second))
                {
                    handler->PSendSysMessage(LANG_COMMAND_SPY_ALREADY_FOLLOWED_BY, target->GetName().c_str(), gm->GetName().c_str());
                    return true;
                }

                gmListening[target->GetGUIDLow()] = handler->GetSession()->GetPlayer()->GetGUIDLow();
                handler->PSendSysMessage(LANG_COMMAND_SPY_FOLLOWING, target->GetName().c_str());
            }
        }
        else
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);

        return true;
    }

    static bool HandleSpyFollowGroupCommand(ChatHandler* handler, const char* args)
    {
        if(!*args)
            return false;

        char *cName = strtok ((char*)args," ");
        if(!cName)
            return false;

        std::string pTarget = args;
        if(!normalizePlayerName(pTarget))
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            return true;
        }

        if(Player* target = ObjectAccessor::FindPlayer(sObjectMgr->GetPlayerGUIDByName(pTarget.c_str())))
        {
            if(Group* group = target->GetGroup())
            {
                std::map<uint32,uint32>::const_iterator itr = gmListeningGroup.find(group->GetLowGUID());
                if(itr != gmListeningGroup.end())
                {
                    if(Player* gm = sObjectMgr->GetPlayerByLowGUID(itr->second))
                    {
                        handler->PSendSysMessage(LANG_COMMAND_SPY_ALREADY_FOLLOWED_BY, target->GetName().c_str(), gm->GetName().c_str());
                        return true;
                    }

                    gmListeningGroup[group->GetLowGUID()] = handler->GetSession()->GetPlayer()->GetGUIDLow();
                    handler->PSendSysMessage(LANG_COMMAND_SPY_FOLLOWING_GROUP, target->GetName().c_str());
                }
            }
            else
                handler->PSendSysMessage(LANG_NOT_IN_GROUP, target->GetName().c_str());
        }
        else
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);

        return true;
    }

    static bool HandleSpyUnFollowCommand(ChatHandler* handler, const char* args)
    {
        if(!*args)
            return false;

        char *cName = strtok ((char*)args," ");
        if(!cName)
            return false;

        std::string pTarget = args;
        if(!normalizePlayerName(pTarget))
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            return true;
        }

        if(Player* target = ObjectAccessor::FindPlayer(sObjectMgr->GetPlayerGUIDByName(pTarget.c_str())))
        {
            handler->PSendSysMessage(LANG_COMMAND_SPY_UNFOLLOW, cName);
            if(gmListening.find(target->GetGUIDLow()) != gmListening.end())
                gmListening.erase(target->GetGUIDLow());
        }
        else
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
        return true;
    }

    static bool HandleSpyUnFollowGroupCommand(ChatHandler* handler, const char* args)
    {
        if(!*args)
            return false;

        char *cName = strtok ((char*)args," ");
        if(!cName)
            return false;

        std::string pTarget = args;
        if(!normalizePlayerName(pTarget))
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            return true;
        }

        if(Player* target = ObjectAccessor::FindPlayer(sObjectMgr->GetPlayerGUIDByName(pTarget.c_str())))
        {
            if(Group* group = target->GetGroup())
            {
                if(gmListeningGroup.find(group->GetLowGUID()) != gmListening.end())
                {
                    gmListeningGroup.erase(group->GetLowGUID());
                    handler->PSendSysMessage(LANG_COMMAND_SPY_UNFOLLOW_GROUP, cName);
                }
                else
                    handler->PSendSysMessage(LANG_COMMAND_SPY_NOT_FOLLOWING_GROUP, cName);
            }
            else
                handler->PSendSysMessage(LANG_NOT_IN_GROUP, target->GetName().c_str());
        }
        else
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
        return true;
    }

    static bool HandleSpyClearCommand(ChatHandler* handler, const char* /*args*/)
    {
        gmListening.clear();
        handler->SendSysMessage(LANG_COMMAND_SPY_CLEARED);
        return true;
    }

    static bool HandleSpyStatusCommand(ChatHandler* handler, const char* /*args*/)
    {
        uint32 guidlow = handler->GetSession()->GetPlayer()->GetGUIDLow();
        std::map<uint32,uint32>::iterator next;
        handler->SendSysMessage(LANG_COMMAND_SPY_LIST);

        for(std::map<uint32,uint32>::iterator itr = gmListening.begin(); itr != gmListening.end(); itr = next)
        {
            // There's the possibility that itr is erased, so we save it
            next = itr;
            ++next;
            if(itr->second == guidlow)
            {
                if(Player* target = ObjectAccessor::FindPlayer(itr->first))
                    handler->PSendSysMessage("%s", target->GetName().c_str());
                else // clear offline players
                    gmListening.erase(itr);
            }
        }

        return true;
    }

};

class chat_spy_logout_cleaner : public PlayerScript
{
public:
    chat_spy_logout_cleaner() : PlayerScript("chat_spy_logout_cleaner") { }

    void OnLogout(Player* player)
    {
        if(player && player->IsGameMaster())
        {
            uint32 guidlow = player->GetGUIDLow();
            std::map<uint32,uint32>::iterator next;
            for(std::map<uint32,uint32>::iterator itr = gmListening.begin(); itr != gmListening.end(); itr = next)
            {
                next = itr; // Save a reference to the next one
                ++next;
                if(itr->second == guidlow)
                    gmListening.erase(itr);
            }
        }
    }
};

void AddSC_spy_commandscript()
{
    new chat_spy_playerscript();
    new chat_spy_commandscript();
    new chat_spy_logout_cleaner();
}
