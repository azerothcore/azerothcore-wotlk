#ifndef ARENA_ONE_VS_ONE_H
#define ARENA_ONE_VS_ONE_H

constexpr BattlegroundQueueTypeId bgQueueTypeId = (BattlegroundQueueTypeId)((int)BATTLEGROUND_QUEUE_5v5);
#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

class ArenaOne
{
public:
    static ArenaOne* instance()
    {
        static ArenaOne* instance = new ArenaOne();
        return instance;
    }

    // выход из очереди
    void LeaveQueue(Player* /*player*/);
    // вход в очередь
    bool JoinQueueArena(Player* /*player*/, bool isRated = true);
    // создать тиму
    bool CreateArenateam(Player* /*player*/);
    // проверка на вход в очередь
    void JoinQueue(Player* /*player*/);
    // проверка на одежду
    bool ArenaCheckFullEquipAndTalents(Player* /*player*/);
    // проверка на таланты
    bool Arena1v1CheckTalents(Player* /*player*/);
    // главное меню
    void ArenaMainMenu(Player* /*player*/);

};

#define ArenaOneMgr ArenaOne::instance()
#endif