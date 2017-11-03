#include "../pchdef.h"
#include "playerbot.h"
#include "PlayerbotAIConfig.h"
#include "PlayerbotFactory.h"
#include "PlayerbotDbStore.h"
#include <cstdlib>
#include <iostream>

#include "LootObjectStack.h"
#include "strategy/values/Formations.h"

using namespace std;
using namespace BotAI;

void PlayerbotDbStore::Load(PlayerbotAI *ai)
{
    uint64 guid = ai->GetBot()->GetGUID();
    uint32 account = sObjectMgr->GetPlayerAccountIdByGUID(guid);
    if (sPlayerbotAIConfig.IsInRandomAccountList(account))
        return;

    QueryResult results = CharacterDatabase.PQuery("SELECT `key`,`value` FROM `ai_playerbot_db_store` WHERE `guid` = '%u'", guid);
    if (results)
    {
        ai->ClearStrategies(BOT_STATE_COMBAT);
        ai->ClearStrategies(BOT_STATE_NON_COMBAT);
        ai->ChangeStrategy("+chat", BOT_STATE_COMBAT);
        ai->ChangeStrategy("+chat", BOT_STATE_NON_COMBAT);

        do
        {
            Field* fields = results->Fetch();
            string key = fields[0].GetString();
            string value = fields[1].GetString();
            ExternalEventHelper helper(ai->GetAiObjectContext());
            helper.ParseChatCommand(value, ai->GetMaster());
            ai->DoNextAction();
        } while (results->NextRow());

    }
}

void PlayerbotDbStore::Save(PlayerbotAI *ai)
{
    uint64 guid = ai->GetBot()->GetGUID();
    uint32 account = sObjectMgr->GetPlayerAccountIdByGUID(guid);
    if (sPlayerbotAIConfig.IsInRandomAccountList(account))
        return;

    Reset(ai);

    SaveValue(guid, "co", FormatStrategies("co", ai->GetStrategies(BOT_STATE_COMBAT)));
    SaveValue(guid, "nc", FormatStrategies("nc", ai->GetStrategies(BOT_STATE_NON_COMBAT)));
    SaveValue(guid, "dead", FormatStrategies("dead", ai->GetStrategies(BOT_STATE_DEAD)));

    Value<Formation*>* formation = ai->GetAiObjectContext()->GetValue<Formation*>("formation");
    ostringstream outFormation; outFormation << "formation " << formation->Get()->getName();
    SaveValue(guid, "formation", outFormation.str());

	//SPP need fix lootStrategy
	/*Value<LootStrategy*>* lootStrategy = ai->GetAiObjectContext()->GetValue<LootStrategy*>("loot strategy");
	ostringstream outLoot; outLoot << "ll " << lootStrategy->Get()->GetName();
	SaveValue(guid, "ll", outLoot.str());*/
}

string PlayerbotDbStore::FormatStrategies(string type, list<string> strategies)
{
    ostringstream out;
    out << type << " ";
    for(list<string>::iterator i = strategies.begin(); i != strategies.end(); ++i)
        out << "+" << (*i).c_str() << ",";

	string res = out.str();
    return res.substr(0, res.size() - 1);
}

void PlayerbotDbStore::Reset(PlayerbotAI *ai)
{
    uint64 guid = ai->GetBot()->GetGUID();
    uint32 account = sObjectMgr->GetPlayerAccountIdByGUID(guid);
    if (sPlayerbotAIConfig.IsInRandomAccountList(account))
        return;

    CharacterDatabase.PExecute("DELETE FROM `ai_playerbot_db_store` WHERE `guid` = '%u'", guid);
}

void PlayerbotDbStore::SaveValue(uint64 guid, string key, string value)
{
    CharacterDatabase.PExecute("INSERT INTO `ai_playerbot_db_store` (`guid`, `key`, `value`) VALUES ('%u', '%s', '%s')", guid, key.c_str(), value.c_str());
}
