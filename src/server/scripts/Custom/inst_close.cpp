#include "ScriptPCH.h"

class CloseInst : public PlayerScript
{

public:
    CloseInst() : PlayerScript("CloseInst") {}

    /* запрет входа в инсты */
    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea)
    {
        // Проверка в ТМ
        if (player->GetMapId() == 585)
        {
            switch (player->getClass())
            {
            case CLASS_PALADIN:
                if (player->HasItemCount(61387, 1) && player->HasItemCount(61388, 1) && player->HasItemCount(61389, 1) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_WARRIOR:
                if (player->HasItemCount(61382, 1) && player->HasItemCount(61383, 1) && player->HasItemCount(61384, 1) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_HUNTER:
                if (player->HasItemCount(61397, 1) && player->HasItemCount(61398, 1) && player->HasItemCount(61399, 1) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_ROGUE:
                if (player->HasItemCount(61403, 1) && player->HasItemCount(61404, 1) && player->HasItemCount(61405, 1) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_PRIEST:
                if (player->HasItemCount(61423, 1) && player->HasItemCount(61424, 1) && player->HasItemCount(61425, 1) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_DEATH_KNIGHT:
                if (player->HasItemCount(61392, 1) && player->HasItemCount(61393, 1) && player->HasItemCount(61394, 1) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_SHAMAN:
                if ((player->HasItemCount(61408, 1) && player->HasItemCount(61409, 1) && player->HasItemCount(61410, 1)) || (player->HasItemCount(61480, 1) && player->HasItemCount(61481, 1) && player->HasItemCount(61482, 1)) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->GetSession()->GetSecurity())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_MAGE:
                if (player->HasItemCount(61418, 1) && player->HasItemCount(61419, 1) && player->HasItemCount(61420, 1) || player->HasItemCount(100504, 1) && player->GetQuestRewardStatus(20551) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_WARLOCK:
                if (player->HasItemCount(61428, 1) && player->HasItemCount(61429, 1) && player->HasItemCount(61430, 1) || player->HasItemCount(100504, 1) && player->GetQuestRewardStatus(20551) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;
            case CLASS_DRUID:
                if ((player->HasItemCount(61413, 1) && player->HasItemCount(61414, 1) && player->HasItemCount(61415, 1)) || (player->HasItemCount(61602, 1) && player->HasItemCount(61603, 1) && player->HasItemCount(61604, 1)) && player->GetQuestRewardStatus(20551) || player->HasItemCount(100504, 1) || player->GetSession()->GetSecurity())
                {
                    if (!player->HasItemCount(100504, 1))
                    {
                        player->AddItem(100504, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 12887.469727f, -7310.428711f, 66.562340f, 1.596328f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Мрака] подземелья [Азжол-Неруб]\nА так же выполненное задание [Помощь Стратхольму]");
                }
                break;

            default:
                break;
            }
        }

        // проверка в КБ
        if (newZone == 3845)
        {
            switch (player->getClass())
            {
            case CLASS_PALADIN:
                if (player->HasItemCount(70707, 1) && player->HasItemCount(70708, 1) && player->HasItemCount(70709, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_WARRIOR:
                if (player->HasItemCount(70701, 1) && player->HasItemCount(70702, 1) && player->HasItemCount(70703, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_HUNTER:
                if (player->HasItemCount(70722, 1) && player->HasItemCount(70723, 1) && player->HasItemCount(70724, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_ROGUE:
                if (player->HasItemCount(70717, 1) && player->HasItemCount(70718, 1) && player->HasItemCount(70719, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_PRIEST:
                if (player->HasItemCount(70736, 1) && player->HasItemCount(70737, 1) && player->HasItemCount(70738, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_DEATH_KNIGHT:
                if (player->HasItemCount(70712, 1) && player->HasItemCount(70713, 1) && player->HasItemCount(70714, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_SHAMAN:
                if ((player->HasItemCount(70727, 1) && player->HasItemCount(70728, 1) && player->HasItemCount(70754, 1)) || (player->HasItemCount(70758, 1) && player->HasItemCount(70759, 1) && player->HasItemCount(70760, 1)) || player->HasItemCount(100505, 1) || player->GetSession()->GetSecurity())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_MAGE:
                if (player->HasItemCount(70747, 1) && player->HasItemCount(70748, 1) && player->HasItemCount(70749, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_WARLOCK:
                if (player->HasItemCount(70742, 1) && player->HasItemCount(70743, 1) && player->HasItemCount(70744, 1) || player->HasItemCount(100505, 1) || player->IsGameMaster())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;
            case CLASS_DRUID:
                if ((player->HasItemCount(70732, 1) && player->HasItemCount(70733, 1) && player->HasItemCount(70734, 1)) || (player->HasItemCount(70752, 1) && player->HasItemCount(70753, 1) && player->HasItemCount(70755, 1)) || player->HasItemCount(100505, 1) || player->GetSession()->GetSecurity())
                {
                    if (!player->HasItemCount(100505, 1))
                    {
                        player->AddItem(100505, 1);
                    }
                }
                else
                {
                    player->TeleportTo(530, 3089.948975f, 1402.989746f, 189.592224f, 4.598400f);
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо иметь 3 вещи [Грудь, Руки, Ноги] из сета [Повелителя Эльфов] подземелья [Терраса Магистров]\nТакже необходимо завершить задание [Сокровище Магистров] и [Испытание на выносливость]");
                }
                break;

            default:
                break;
            }
        }
        // проверка меха
        if (newZone == 3849)
        {
            if (!player->GetQuestRewardStatus(20210)) {
                player->TeleportTo(530, 2913.550049f, 1605.739990f, 249.011993f, 4.834550f);
                ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо выполнить задание [Плащ Груула]");
            }
        }

        // проверка арка
        if (newZone == 3848)
        {
            if (!player->GetQuestRewardStatus(20211)) {
                player->TeleportTo(530, 3278.582031f, 1416.983398f, 503.112488f, 5.112618f);
                ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо выполнить задание [Захват Механар]");
            }
        }

        // проверка бота
        if (newZone == 3847)
        {
            if (!player->GetQuestRewardStatus(20212)) {
                player->TeleportTo(530, 3335.149658f, 1542.210815f, 180.851791f, 5.635699f);
                ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r\nНеобходимо выполнить задание [Освобождение Аркатрац]");
            }
        }
    }
};

void AddSC_CloseInst()
{
    new CloseInst();
}
