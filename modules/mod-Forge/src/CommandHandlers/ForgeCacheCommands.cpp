#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>
//#include <ShopCache.cpp>
//#include "Transmogrification.h"

class ForgeCacheCommands : public CommandScript
{
public:
    ForgeCacheCommands() : CommandScript("ForgeCacheCommands")
    {
       
    }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> exampleCommandTable1 =
        {
            // This command does something
            { "forge",      SEC_ADMINISTRATOR,     true,  &ForgePoints,      "" },
            { "talent",      SEC_ADMINISTRATOR,     true, &TalentPoints,      "" },
            { "prestige",      SEC_ADMINISTRATOR,     true, &PrestigePoints,      "" },
            { "racial",      SEC_ADMINISTRATOR,     true, &RacialPoints,      "" }
        };

        // Level 1 sub command
        static std::vector<ChatCommand> exampleCommandTable =
        {
            { "reloadCache",      SEC_ADMINISTRATOR,     true,  &ReloadCache,      ""},
            { "addpoints",      SEC_ADMINISTRATOR,     true, nullptr,      "", exampleCommandTable1}
        };

        // Root command
        static std::vector<ChatCommand> commandTable =
        {
            //  name       permission   allow console?   handler method      help      child commands table 
            { "forge",   SEC_ADMINISTRATOR,      true,           nullptr,         "", exampleCommandTable}
        };

        return commandTable; // Return the root command table
    }

    //          Handle + "Something" + Command
    static bool ReloadCache(ChatHandler* handler, char const* args)
    {
        ForgeCache::get_instance()->ReloadDB();
        //ShopCache::get_instance()->LoadCache();
        //sTransmogrification->Load();

        // hater: load scaling spell info
        LOG_INFO("server.loading", "Loading SpellScaling...");
        sObjectMgr->LoadSpellScalingData();
        sObjectMgr->LoadSpellScalingSpellMap();
        sObjectMgr->LoadSpellScalingValue();
        sObjectMgr->LoadSpellDurationData();

        // ChatHandler could be Console or Player session
        handler->PSendSysMessage("Cache Reloaded");
        return true;
    }

    static bool ForgePoints(ChatHandler* handler, char const* args)
    {
        uint32 amount = static_cast<uint32>(std::stoul(args));
        ForgeCache::get_instance()->AddCharacterPointsToAllSpecs(handler->getSelectedPlayerOrSelf(), CharacterPointType::FORGE_SKILL_TREE, amount);
        ForgeCommonMessage::get_instance()->SendActiveSpecInfo(handler->getSelectedPlayerOrSelf());
        return true;
    }

    static bool TalentPoints(ChatHandler* handler, char const* args)
    {
        uint32 amount = static_cast<uint32>(std::stoul(args));
        ForgeCache::get_instance()->AddCharacterPointsToAllSpecs(handler->getSelectedPlayerOrSelf(), CharacterPointType::TALENT_TREE, amount);
        ForgeCommonMessage::get_instance()->SendActiveSpecInfo(handler->getSelectedPlayerOrSelf());
        return true;
    }

    static bool PrestigePoints(ChatHandler* handler, char const* args)
    {
        uint32 amount = static_cast<uint32>(std::stoul(args));
        ForgeCache::get_instance()->AddCharacterPointsToAllSpecs(handler->getSelectedPlayerOrSelf(), CharacterPointType::PRESTIGE_TREE, amount);
        ForgeCommonMessage::get_instance()->SendActiveSpecInfo(handler->getSelectedPlayerOrSelf());
        return true;
    }

    static bool RacialPoints(ChatHandler* handler, char const* args)
    {
        uint32 amount = static_cast<uint32>(std::stoul(args));
        ForgeCache::get_instance()->AddCharacterPointsToAllSpecs(handler->getSelectedPlayerOrSelf(), CharacterPointType::RACIAL_TREE, amount);
        ForgeCommonMessage::get_instance()->SendActiveSpecInfo(handler->getSelectedPlayerOrSelf());
        return true;
    }

private:

};
