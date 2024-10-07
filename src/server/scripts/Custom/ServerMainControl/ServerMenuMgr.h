#ifndef SERVER_MENU_H
#define SERVER_MENU_H

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c
#define site_name "wastorm.eu"
#define UNIX_DAY 86400
#define MIN_VIP_DAY 4
#define VIP_COST_DAY 25
#define CHANGE_FACTION_COST 150000000
#define CHANGE_RACE_COST 75000000
#define CHANGE_NICK_COST 50000000

constexpr static const uint32 BuffList[9] = {
    25898, 48470, 53307, 48074, 48162, 48170, 57623, 43002, 47440
};

enum SERVER_MENU: uint8_t {
    GossipHelloMenu = 1
};

/* #################################### ОСНОВНАЯ СТРУКТУРА ТАБЛИЦ #################################### */

struct TeleportListSTR
{
    uint32 id;            // ид самой телепортации (определяем место телепорта)
    uint8  gossip_menu;   // для определение стандартного пункта (например: 0 это старт меню телепортов, 1 это сталицы)
    uint8  faction;       // определяем фракцию кому доступно (1 альянс 2 орда 3 всем)
    uint32 cost;          // стоимость телепортации
    std::string name_RU;
    std::string name_EN;
    /* координаты для телепорта */
    uint16 map; float position_x; float position_y; float position_z; float orientation;
};

struct Buffs_List
{
    uint32 Entry;
    uint32 Cost;
};

struct Titles_List
{
    uint32 Entry;
    uint32 Cost;
};

typedef std::vector<Buffs_List*> Buffs_Container;
typedef std::vector<Titles_List*> Titles_Container;
typedef std::vector<TeleportListSTR*> TeleportList_Container;


/* #################################### СОЗДАНИЕ ТАБЛИЦ #################################### */

class sServerMenu
{
public:
   static sServerMenu* instance()
   {
       static sServerMenu* instance = new sServerMenu();
       return instance;
   }

   /* проверка на возможность открыть спелл */
   bool CanOpenMenu(Player*);

   /* структуру для сервер меню */
   std::string HeadMenu(Player *player , uint8 MenuId);
   void BodyMenu(Player *player, uint8 MenuId);

   /* расчет голды */
   std::string ConverterMoneyToGold(Player* player, uint32 money);
   std::string ConfirmMoneyTeleport(Player* player, std::string telename);
   uint32 CalculRequiredMoney(Player* player, uint32 money);

   /* список баффов */
   void BuffsListView(Player* /*player*/, uint16 /*page*/);

   /* список званий */
   void TitlesListView(Player* /*player*/, uint16 /*page*/);

   /* главное меню */
   void m_GossipHelloMenu(Player* /*player*/);

   /* телепортация */
   void TeleportListMain(Player* /*player*/);
   void GetTeleportListAfter(Player* /*player*/, uint32 /*action*/, uint8 /*faction*/);
   void TeleportFunction(Player* /*player*/, uint32 /*i*/);

   /* управление персонажа */
   void CharControlMenu(Player* /* player*/);
   void OpenBankSlot(Player* /*player*/);
   void OpenMailSlot(Player* /*player*/);
   std::string ConfirmChangeRFN(Player* /*player*/);
   void ChangeRFN(Player* /*player*/, int /*i*/);

   /* загрузка таблиц */
   void LoadBuffsContainer();
   void LoadTitlesContainer();
   void LoadTeleportListContainer();

   Buffs_Container m_Buffs_Container;
   Titles_Container m_Titles_Container;
   TeleportList_Container m_TeleportList_Container;

   const char* sql_teleportlist = "CREATE TABLE IF NOT EXISTS `server_menu_teleportlist` ("
                                  "    `id` INT(10) UNSIGNED NOT NULL COMMENT 'id',"
                                  "    `gossip_menu` INT(3) UNSIGNED NOT NULL COMMENT 'gossip_menu',"
                                  "    `faction` INT(3) UNSIGNED NOT NULL COMMENT 'faction',"
                                  "    `cost` INT(10) UNSIGNED NOT NULL COMMENT 'cost',"
                                  "    `name_RU` char(100),"
                                  "    `name_EN` char(100),"
                                  "    `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'map',"
                                  "    `position_x` float NOT NULL DEFAULT '0',"
                                  "    `position_y` float NOT NULL DEFAULT '0',"
                                  "    `position_z` float NOT NULL DEFAULT '0',"
                                  "    `orientation` float NOT NULL DEFAULT '0',"
                                  "    PRIMARY KEY (`name_RU`)"
                                  ")"
                                  "COMMENT='server_menu_teleportlist'"
                                  "ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='server_menu_teleportlist';";

   const char* sql_buffs =        "CREATE TABLE IF NOT EXISTS `server_menu_buffs` ("
                                  "    `entry` INT(10) UNSIGNED NOT NULL COMMENT 'entry',"
                                  "    `cost` INT(10) UNSIGNED NOT NULL COMMENT 'cost',"
                                  "    PRIMARY KEY (`entry`)"
                                  ")"
                                  "COMMENT='premium buffs'"
                                  "ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='server_menu_buffs';";

   const char* sql_titles =       "CREATE TABLE IF NOT EXISTS `server_menu_titles` ("
                                  "    `entry` INT(10) UNSIGNED NOT NULL COMMENT 'entry',"
                                  "    `cost` INT(10) UNSIGNED NOT NULL COMMENT 'cost',"
                                  "    PRIMARY KEY (`entry`)"
                                  ")"
                                  "COMMENT='premium titles'"
                                  "ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='server_menu_titles';";
};

#define sServerMenuMgr sServerMenu::instance()
#endif