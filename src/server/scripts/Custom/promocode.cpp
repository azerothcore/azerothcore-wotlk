#include "ScriptPCH.h"
#include "Config.h"

#define SQL_CODE "SELECT `CodeId`, `MailMoney`, `MaxCountForCharacter`, `MaxCountForAccount`, `MaxCountTotal`, `MailSubject`, `MailText` FROM `world_coded` WHERE `CodeStart` <= CURRENT_TIMESTAMP AND `CodeEnd` >= CURRENT_TIMESTAMP AND `CodeData` = {} LIMIT 1"
#define SQL_CODE_COUNT "SELECT COUNT(*) FROM `world_coded_history` WHERE `CodeId` = {}"
#define SQL_CODE_COUNT_ACCOUNT "SELECT COUNT(*) FROM `world_coded_history` WHERE `CodeId` = {} AND `AccountId` = {}"
#define SQL_CODE_COUNT_CHARACTER "SELECT COUNT(*) FROM `world_coded_history` WHERE `CodeId` = {} AND `CharacterGuid` = {}"
#define SQL_CODE_HISTORY "INSERT INTO `world_coded_history` (`CodeId`, `CharacterGuid`, `AccountId`, `SessionIp`) VALUES ({}, {}, {}, '%s')"
#define SQL_CODE_ITEMS "SELECT `ItemId`, `ItemCount` FROM `world_coded_items` WHERE `CodeId` = {} AND (`ItemClassMask` & %u OR `ItemClassMask` = 0) AND (`ItemRaceMask` & {} OR `ItemRaceMask` = 0)"

bool SCEnable = false;

class Mod_SpecialCode_WorldScript : public WorldScript
{
    public:
        Mod_SpecialCode_WorldScript() : WorldScript("Mod_SpecialCode_WorldScript") { }

    void OnConfigLoad(bool /*reload*/)
    {
        SCEnable = sConfigMgr->GetBoolDefault("SpecialCode.Enable", false);
    }
};

class Mod_SpecialCode_AllCreatureScript : public AllCreatureScript
{
    public:
        Mod_SpecialCode_AllCreatureScript() : AllCreatureScript("Mod_SpecialCode_AllCreatureScript") { }

    void AllCreatureCode(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/, const char* code)
    {
        if (!SCEnable || !player || !*code)
            return;

        std::string std_code(code);
        CharacterDatabase.EscapeString(std_code);
        QueryResult result = CharacterDatabase.Query(SQL_CODE, std_code.c_str());
        if (!result)
        {
            CloseGossipMenuFor(player);
            return;
        }

        uint32 codeId = (*result)[0].Get<uint32>();
        std::string subject = (*result)[5].Get<std::string>();
        std::string text = (*result)[6].Get<std::string>();
        int32 mailMoney = (*result)[1].Get<uint32>();
        uint8 maxCharacters = (*result)[2].Get<uint8>();
        uint8 maxAccount = (*result)[3].Get<uint8>();
        uint8 maxTotal = (*result)[4].Get<uint8>();
        uint16 currentTotal = 0;
        uint16 currentAccount = 0;
        uint16 currentCharacter = 0;

        if (maxTotal > 0)
        {
            result = CharacterDatabase.Query(SQL_CODE_COUNT, codeId);
            if (result)
                currentTotal = (*result)[0].Get<uint16>();

            if (currentTotal >= maxTotal)
            {
                CloseGossipMenuFor(player);
                return;
            }
        }

        uint32 accountId = player->GetSession()->GetAccountId();

        if (maxAccount > 0)
        {
            result = CharacterDatabase.Query(SQL_CODE_COUNT_ACCOUNT, codeId, accountId);
            if (result)
                currentAccount = (*result)[0].Get<uint16>();

            if (currentAccount >= maxAccount)
            {
                CloseGossipMenuFor(player);
                return;
            }
        }

        bool guid = player->GetGUID();

        if (maxCharacters > 0)
        {
            result = CharacterDatabase.Query(SQL_CODE_COUNT_CHARACTER, codeId, guid);
            if (result)
                currentCharacter = (*result)[0].Get<uint16>();

            if (currentCharacter >= maxCharacters)
            {
                CloseGossipMenuFor(player);
                return;
            }
        }

        CharacterDatabase.Execute(SQL_CODE_HISTORY, codeId, guid, accountId, player->GetSession()->GetRemoteAddress().c_str());

        MailDraft draft(subject, text);
      //  SQLTransaction trans = SQLTransaction<CharacterDatabaseConnection>;

        result = CharacterDatabase.Query(SQL_CODE_ITEMS, codeId, player->getClassMask(), player->getRaceMask());

        if (result)
        {
            typedef std::pair<uint32, uint32> ItemPair;
            typedef std::list< ItemPair > ItemPairs;
            ItemPairs items;

            do
            {
                Field* fields = result->Fetch();

                uint32 itemId = fields[0].Get<uint32>();
                uint16 itemCount = fields[1].Get<uint16>();

                ItemTemplate const* itemProto = sObjectMgr->GetItemTemplate(itemId);
                if (!itemProto)
                    continue;

                if (itemCount < 1 || (itemProto->MaxCount > 0 && itemCount > uint32(itemProto->MaxCount)))
                    continue;

                while (itemCount > itemProto->GetMaxStackSize())
                {
                    items.push_back(ItemPair(itemId, itemProto->GetMaxStackSize()));
                    itemCount -= itemProto->GetMaxStackSize();
                }

                items.push_back(ItemPair(itemId, itemCount));

                if (items.size() > MAX_MAIL_ITEMS)
                {
                    CloseGossipMenuFor(player);
                    return;
                }
            }
            while (result->NextRow());

            for (ItemPairs::const_iterator itr = items.begin(); itr != items.end(); ++itr)
            {
                if (Item* item = Item::CreateItem(itr->first, itr->second, 0))
                {
             //       item->SaveToDB(trans);
                    draft.AddItem(item);
                }
            }
        }

        if (mailMoney > 0)
            draft.AddMoney(mailMoney);
        else
            draft.AddCOD(mailMoney*-1);

     //   draft.SendMailTo(trans, MailReceiver(player, GUID_LOPART(guid)), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM));
    //    CharacterDatabase.CommitTransaction(trans);
        CloseGossipMenuFor(player);
    }

};

void AddSC_SpecialCode()
{
    new Mod_SpecialCode_WorldScript();
    new Mod_SpecialCode_AllCreatureScript();
}
