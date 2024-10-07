#ifndef NPC_PROFESSION_H
#define NPC_PROFESSION_H

#include "SharedDefines.h"

enum SERVER_MENU: uint8_t {
    GossipHelloMenu = 1
};

class sProfession
{
public:
    static sProfession* instance()
    {
        static sProfession* instance = new sProfession();
        return instance;
    }

    /* все професии */
    static constexpr std::array<uint32, 14> _PROF = { SKILL_ALCHEMY, SKILL_BLACKSMITHING, SKILL_LEATHERWORKING, SKILL_TAILORING, SKILL_ENGINEERING,
        SKILL_ENCHANTING, SKILL_JEWELCRAFTING, SKILL_INSCRIPTION, SKILL_HERBALISM, SKILL_SKINNING, SKILL_MINING, SKILL_FIRST_AID, SKILL_FISHING, SKILL_COOKING };

    /* скиллы профессий */
    static constexpr std::array<uint32, 1> _SKILL_COOKING        = { 51296 };
    static constexpr std::array<uint32, 1> _SKILL_FIRST_AID      = { 45542 };
    static constexpr std::array<uint32, 1> _SKILL_FISHING        = { 65293 };
    static constexpr std::array<uint32, 6> _SKILL_ALCHEMY        = { 2259, 3101, 3464, 11611, 28596, 51304 };
    static constexpr std::array<uint32, 6> _SKILL_BLACKSMITHING  = { 2018, 3100, 3538, 9785, 29844, 51300 };
    static constexpr std::array<uint32, 6> _SKILL_ENCHANTING     = { 7411, 7412, 7413, 13920, 28029, 51313 };
    static constexpr std::array<uint32, 6> _SKILL_ENGINEERING    = { 4036, 4037, 4038, 12656, 30350, 51306 };
    static constexpr std::array<uint32, 6> _SKILL_INSCRIPTION    = { 45357, 45358, 45359, 45360, 45361, 45363 };
    static constexpr std::array<uint32, 6> _SKILL_JEWELCRAFTING  = { 25229, 25230, 28894, 28895, 28897, 51311 };
    static constexpr std::array<uint32, 6> _SKILL_LEATHERWORKING = { 2108, 3104, 3811, 10662, 32549, 51302 };
    static constexpr std::array<uint32, 6> _SKILL_TAILORING      = { 3908, 3909, 3910, 12180, 26790, 51309 };
    static constexpr std::array<uint32, 6> _SKILL_MINING         = { 2575, 2576, 3564, 10248, 29354, 50310 };
    static constexpr std::array<uint32, 6> _SKILL_SKINNING       = { 8613, 8617, 8618, 10768, 32678, 50305 };
    static constexpr std::array<uint32, 11> _SKILL_HERBALISM     = { 2366, 2368, 3570, 11993, 28695, 50300, 55428, 55480, 55500, 55501, 55502 };

    /* количество профессий в завимости от ранга */
    uint8 CountPlayerCanLearn();
    /* если у игрока уже есть максимально кол профессий */
    bool PlayerAlreadyHasMaxProfessions(const Player* /* player */);
    /* выучаем всю профессию */
    bool LearnAllRecipesInProfession(Player* /* player */, uint32 /* skill */);
    /* рыбалка / кулинария / первая помощь */
    bool IsSecondarySkill(uint32 skill) const;
    /* функция выучение профессий */
    void CompleteLearnProfession(Player* /* player */, uint32 /* skill */);
    /* защита задания */
    void CompleteQuest(Player* /* player */);
    /* главное меню профессий */
    void MainMenu(Player* /* player */, Creature* /* creature */);
    /* меню primary */
    void PrimaryMenu(Player* /* player */, Creature* /* creature */);
    /* меню second */
    void SecondMenu(Player* /* player */, Creature* /* creature */);
    /* меню реагентов */
    void ReagentsMenu(Player* /* player */, Creature* /* creature */);
    /* заголовка в госипке */
    std::string HeadMenu(Player* /* player */);
    /* заголовка в разделе реагентов */
    std::string HeadMenuNPC(Player* /* player */);
};

#define sProfessionMgr sProfession::instance()
#endif