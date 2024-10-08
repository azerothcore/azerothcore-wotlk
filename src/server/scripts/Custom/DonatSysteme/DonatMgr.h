#ifndef DONAT_SYSTEME_H
#define DONAT_SYSTEME_H

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

/* #################################### СОЗДАНИЕ ТАБЛИЦ #################################### */

class DonationSysteme
{
public:
   static DonationSysteme* instance()
   {
       static DonationSysteme* instance = new DonationSysteme();
       return instance;
   }

   /* #################################### ОСНОВНАЯ СТРУКТУРА ТАБЛИЦ #################################### */

    struct DonationSystemeList
    {
        uint32 id;            // ид 
        uint8  gossip_menu;   // для определение стандартного пункта
        uint32  classID;      // определяем класса кому доступно
        std::string name_RU;
        std::string name_EN;
        uint32 itemID;        // ид предмета
        uint32 count;         // кол. предмета
        uint32 cost;          // стоймость
        uint32 discount;      // скидки в % (0 - 100)
    };

    typedef std::vector<DonationSystemeList*> DonationSysteme_Container;

    /* загрузка таблиц */
    void LoadDonationSystemeListContainer();
    void DonationSystemeListMain(Player* player);
    void GetDonationSystemeAfter(Player* player, uint32 action, uint32 /*classid*/);
    std::string ReturnFullName(Player* player, uint32 entry, uint32 cost, uint32 count, uint32 discount);
    uint32 returnCost(uint32 cost, uint32 discount);
    void DonationFunction(Player* player, uint32 i);
    std::string HeadMenu(Player* player);
    void LookingItem(Player* player, uint32 entry);
    void DonatPayementFuction(Player* player, uint32 i);

    DonationSysteme_Container m_DonationSysteme_Container;

    const char* sql_donation_systeme = "CREATE TABLE IF NOT EXISTS `server_donat_menu` ("
                                       " `id` int unsigned NOT NULL AUTO_INCREMENT,"
                                        "`gossip_menu` int unsigned DEFAULT '0',"
                                        "`classID` int unsigned DEFAULT '0',"
                                        "`name_RU` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,"
                                        "`name_EN` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,"
                                       " `itemID` int DEFAULT '0',"
                                        "`count` int unsigned NOT NULL DEFAULT '1',"
                                      "  `cost` int DEFAULT '0',"
                                       " `discount` int DEFAULT '0',"
                                        "PRIMARY KEY (`id`)"
                                    ") ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;";
};

#define DonationSystemeMgr DonationSysteme::instance()
#endif