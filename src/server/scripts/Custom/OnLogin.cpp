#include "ScriptMgr.h"
#include "DatabaseEnv.h"
#include "SpellInfo.h"
#include "ObjectMgr.h"
#include "Item.h"
#include "Pet.h"
#include "ReputationMgr.h"
#include "Translate.h"
#include "ServerMenu/ServerMenuMgr.h"

const uint32 SPELL_DEMENTIA = 40874;

struct Event
{
        uint8 Events;
};

enum Enums
{
        FIRST_DELAY    = 5000,
        SECOND_DELAY   = 10000,
        THIRD_DELAY    = 15000,
        FOURTH_DELAY   = 20000
};

static std::map<ObjectGuid, Event> _events;

class Information_Server : public BasicEvent
{
public:
        Information_Server(Player* player) : _Plr(player) {}

        virtual bool Execute(uint64 /*time*/, uint32 /*diff*/) override
        {
            ObjectGuid pEvent;
            pEvent = _Plr->GetGUID();
            char const* icon_color;
            icon_color = "|TInterface\\GossipFrame\\Availablequesticon:15:15:|t|cffff9933 ";

            switch(_events[pEvent].Events)
            {
                case 0:
                    ChatHandler(_Plr->GetSession()).PSendSysMessage("%sДобро пожаловать на проект |cffffff4dWoW-IDK.RU|r", icon_color);
                    _events[pEvent].Events = 1;
                    break;

                case 1:
                    ChatHandler(_Plr->GetSession()).PSendSysMessage("%sПеред вами стоит моб быстрого старта 'Mr.Gladiator' в котором сможете выбрать ваш спек, он всё сделает за вас.", icon_color);
                    _events[pEvent].Events = 2;
                    break;

                case 2:
                    ChatHandler(_Plr->GetSession()).PSendSysMessage("%sРядом с ним находится продавцы экипиров, если вы хотите сами одеть вашего персонажа.", icon_color);
                    _events[pEvent].Events = 3;
                    break;

                case 3:
                    ChatHandler(_Plr->GetSession()).PSendSysMessage("%sМы желаем вам приятной игры на нашем проекте <3", icon_color);
                    _events[pEvent].Events = 5;
                    break;
            }
            return true;
        }
        Player* _Plr;
};

class Login_script : public PlayerScript
{
public:
    Login_script() : PlayerScript("Login_script") {}

    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea) override
    {
        if (!player || !newZone || !newArea)
            return;

        // Remove Dementia on updating zone for player
        if (player->HasAura(SPELL_DEMENTIA))
            player->RemoveAura(SPELL_DEMENTIA);
    }

    void OnMapChanged(Player *player) override
    {
        if (!player)
            return;

        Map *map = player->GetMap();
        if (!map)
            return;

        player->VerifiedRankBuff(map);
    }

    void RemoveDementia(Player* player) 
    {
        if (!player)
            return;

        // Remove Dementia on player login
        if (player->HasAura(SPELL_DEMENTIA))
            player->RemoveAura(SPELL_DEMENTIA);
    }


    void DeleteItem_OnLogin(Player* player)
    {
        /* Удаление шмоток при старте */
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
            if (Item* haveItemEquipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                if (haveItemEquipped)
                {
                    player->DestroyItemCount(haveItemEquipped->GetEntry(), 1, true, true);

                    if (haveItemEquipped->IsInWorld())
                    {
                        haveItemEquipped->RemoveFromWorld();
                        haveItemEquipped->DestroyForPlayer(player);
                    }

                    haveItemEquipped->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
                    haveItemEquipped->SetSlot(NULL_SLOT);
                    haveItemEquipped->SetState(ITEM_REMOVED, player);
                }
            }
        }

        switch (player->getClass())
        {
            case CLASS_DEATH_KNIGHT:
            {
                player->DestroyItemCount(38145, 4, true); // сумки
                player->DestroyItemCount(41751, 10, true); // черный гриб
                player->AddItem(6948, 1); // камень возврашения
                player->removeSpell(3273, SPEC_MASK_ALL, false); // первая помощь
            }
            break;

            case CLASS_HUNTER:
            {
                player->DestroyItemCount(2512, 200, true); // стреллы
                player->DestroyItemCount(2516, 200, true); // стреллы номер 2
                player->DestroyItemCount(2101, 4, true); // сумка для стрел
                player->DestroyItemCount(2102, 1, true); // сумка для стрел номер 2
                player->AddItem(52021, 100000); // пули
            }
            break;
        }
    }

    void OnFirstLogin(Player* player) override
    {
        player->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(1156), 42999);
        DeleteItem_OnLogin(player);
        if (!player->HasSpell(33388))
            player->learnSpell(33388);
        if (!player->HasSpell(33391))
            player->learnSpell(33391);
        if (!player->HasSpell(34090))
            player->learnSpell(34090);
        if (!player->HasSpell(34091))
            player->learnSpell(34091);
        if (!player->HasSpell(54197))
            player->learnSpell(54197);

        player->m_Events.AddEvent(new Information_Server(player), player->m_Events.CalculateTime(FIRST_DELAY));
        player->m_Events.AddEvent(new Information_Server(player), player->m_Events.CalculateTime(SECOND_DELAY));
        player->m_Events.AddEvent(new Information_Server(player), player->m_Events.CalculateTime(THIRD_DELAY));
        player->m_Events.AddEvent(new Information_Server(player), player->m_Events.CalculateTime(FOURTH_DELAY));
    }

    void OnLogin(Player* player) override
    {
        if (!player)
            return;

        player->RankControlOnLogin();
        player->LoadPvPRank();

        RemoveDementia(player);
        sServerMenuMgr->VipMountLearn(player);

        Map *map = player->GetMap();
        if (!map)
            return;
        player->VerifiedRankBuff(map);

        // выходные бонусы
        if (sServerMenuMgr->isDoubleDays()) {
            ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_HOLIDAY_ONLOGIN, EN_HOLIDAY_ONLOGIN));
        }
    }
};

void AddSC_Login_script()
{
    new Login_script();
}