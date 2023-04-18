#include "bot_ai.h"
#include "botdump.h"
#include "botmgr.h"
#include "botdatamgr.h"
#include "botwanderful.h"
#include "Chat.h"
#include "CharacterCache.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "Language.h"
#include "Group.h"
#include "Log.h"
#include "Map.h"
#include "MapMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
//#include "RBAC.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Spell.h"
#include "TemporarySummon.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldDatabase.h"
#include "WorldSession.h"

/*
Name: script_bot_commands
%Complete: ???
Comment: Npc Bot related commands by Trickerer (onlysuffering@gmail.com)
Category: commandscripts/custom/
*/

#ifdef _MSC_VER
# pragma warning(push, 4)
#endif

static bool isWPSpawnWarningGiven = false;

#ifdef AC_COMPILER
//Acore only
enum rbac
{
    RBAC_PERM_COMMAND_NPCBOT                                 = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_ADD                             = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_REMOVE                          = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_SPAWN                           = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_MOVE                            = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_DELETE                          = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_LOOKUP                          = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_REVIVE                          = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_RELOADCONFIG                    = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_INFO                            = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_HIDE                            = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_UNHIDE                          = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_RECALL                          = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_KILL                            = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_DEBUG_RAID                      = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_DEBUG_MOUNT                     = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_DEBUG_VISUAL                    = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES                    = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_TOGGLE_FLAGS                    = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_SET_FACTION                     = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_SET_OWNER                       = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_SET_SPEC                        = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_COMMAND_STANDSTILL              = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_COMMAND_STOPFULLY               = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_COMMAND_FOLLOW                  = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_ATTDISTANCE_SHORT               = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_ATTDISTANCE_LONG                = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_ATTDISTANCE_EXACT               = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_FOLDISTANCE_EXACT               = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_ORDER_CAST                      = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_VEHICLE_EJECT                   = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_DUMP_LOAD                       = SEC_ADMINISTRATOR,
    RBAC_PERM_COMMAND_NPCBOT_DUMP_WRITE                      = SEC_ADMINISTRATOR,
    RBAC_PERM_COMMAND_NPCBOT_SPAWNED                         = SEC_ADMINISTRATOR,
    RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC                    = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_CREATENEW                       = SEC_ADMINISTRATOR,
    RBAC_PERM_COMMAND_NPCBOT_SEND                            = SEC_PLAYER
};
//end Acore only
#endif

using namespace Acore::ChatCommands;

class script_bot_commands : public CommandScript
{
private:
    static constexpr size_t SOUND_SETS_COUNT = 3;
    static constexpr size_t GENDERS_COUNT = 2;
    static constexpr size_t RACES_COUNT = 10;

    // model ids with different sound sets tied to them
    enum SoundSetModels : uint32
    {
        SOUNDSETMODEL_HUMAN_MALE_1          = 1492,
        SOUNDSETMODEL_HUMAN_MALE_2          = 1290,
        SOUNDSETMODEL_HUMAN_MALE_3          = 1699,
        SOUNDSETMODEL_HUMAN_FEMALE_1        = 1295,
        SOUNDSETMODEL_HUMAN_FEMALE_2        = 1296,
        SOUNDSETMODEL_HUMAN_FEMALE_3        = 1297,
        SOUNDSETMODEL_DWARF_MALE_1          = 1280,
        SOUNDSETMODEL_DWARF_MALE_2          = 1354,
        SOUNDSETMODEL_DWARF_MALE_3          = 1362,
        SOUNDSETMODEL_DWARF_FEMALE_1        = 1286,
        SOUNDSETMODEL_DWARF_FEMALE_2        = 1407,
        SOUNDSETMODEL_DWARF_FEMALE_3        = 2585,
        SOUNDSETMODEL_NIGHTELF_MALE_1       = 1285,
        SOUNDSETMODEL_NIGHTELF_MALE_2       = 1704,
        SOUNDSETMODEL_NIGHTELF_MALE_3       = 1706,
        SOUNDSETMODEL_NIGHTELF_FEMALE_1     = 1681,
        SOUNDSETMODEL_NIGHTELF_FEMALE_2     = 1682,
        SOUNDSETMODEL_NIGHTELF_FEMALE_3     = 1719,
        SOUNDSETMODEL_GNOME_MALE_1          = 1832,
        SOUNDSETMODEL_GNOME_MALE_2          = 4287,
        SOUNDSETMODEL_GNOME_MALE_3          = 4717,
        SOUNDSETMODEL_GNOME_FEMALE_1        = 3124,
        SOUNDSETMODEL_GNOME_FEMALE_2        = 5378,
        SOUNDSETMODEL_GNOME_FEMALE_3        = 3108,
        SOUNDSETMODEL_DRAENEI_MALE_1        = 16226,
        SOUNDSETMODEL_DRAENEI_MALE_2        = 16589,
        SOUNDSETMODEL_DRAENEI_MALE_3        = 16224,
        SOUNDSETMODEL_DRAENEI_FEMALE_1      = 16222,
        SOUNDSETMODEL_DRAENEI_FEMALE_2      = 16202,
        SOUNDSETMODEL_DRAENEI_FEMALE_3      = 16636,
        SOUNDSETMODEL_ORC_MALE_1            = 1275,
        SOUNDSETMODEL_ORC_MALE_2            = 1326,
        SOUNDSETMODEL_ORC_MALE_3            = 1368,
        SOUNDSETMODEL_ORC_FEMALE_1          = 1325,
        SOUNDSETMODEL_ORC_FEMALE_2          = 1868,
        SOUNDSETMODEL_ORC_FEMALE_3          = 1874,
        SOUNDSETMODEL_UNDEAD_MALE_1         = 1278,
        SOUNDSETMODEL_UNDEAD_MALE_2         = 1562,
        SOUNDSETMODEL_UNDEAD_MALE_3         = 1578,
        SOUNDSETMODEL_UNDEAD_FEMALE_1       = 1592,
        SOUNDSETMODEL_UNDEAD_FEMALE_2       = 1593,
        SOUNDSETMODEL_UNDEAD_FEMALE_3       = 1603,
        SOUNDSETMODEL_TAUREN_MALE_1         = 2083,
        SOUNDSETMODEL_TAUREN_MALE_2         = 2087,
        SOUNDSETMODEL_TAUREN_MALE_3         = 2096,
        SOUNDSETMODEL_TAUREN_FEMALE_1       = 2113,
        SOUNDSETMODEL_TAUREN_FEMALE_2       = 2112,
        SOUNDSETMODEL_TAUREN_FEMALE_3       = 2127,
        SOUNDSETMODEL_TROLL_MALE_1          = 3608,
        SOUNDSETMODEL_TROLL_MALE_2          = 4047,
        SOUNDSETMODEL_TROLL_MALE_3          = 4068,
        SOUNDSETMODEL_TROLL_FEMALE_1        = 4085,
        SOUNDSETMODEL_TROLL_FEMALE_2        = 4231,
        SOUNDSETMODEL_TROLL_FEMALE_3        = 4524,
        SOUNDSETMODEL_BLOODELF_MALE_1       = 15532,
        SOUNDSETMODEL_BLOODELF_MALE_2       = 16700,
        SOUNDSETMODEL_BLOODELF_MALE_3       = 16699,
        SOUNDSETMODEL_BLOODELF_FEMALE_1     = 15514,
        SOUNDSETMODEL_BLOODELF_FEMALE_2     = 15518,
        SOUNDSETMODEL_BLOODELF_FEMALE_3     = 15520,
    };

    static constexpr size_t RaceToRaceOffset[MAX_RACES] = {
        RACE_NONE,
        0, //RACE_HUMAN
        5, //RACE_ORC
        1, //RACE_DWARF
        2, //RACE_RACE_NIGHTELF
        6, //RACE_RACE_UNDEAD_PLAYER
        7, //RACE_TAUREN
        3, //RACE_GNOME
        8, //RACE_TROLL
        RACE_NONE,
        9, //RACE_BLOODELF
        4, //RACE_DRAENEI
    };

    static constexpr uint32 SoundSetModelsArray[RACES_COUNT][GENDERS_COUNT][SOUND_SETS_COUNT] = {
        {{SOUNDSETMODEL_HUMAN_MALE_1, SOUNDSETMODEL_HUMAN_MALE_2, SOUNDSETMODEL_HUMAN_MALE_3}, {SOUNDSETMODEL_HUMAN_FEMALE_1, SOUNDSETMODEL_HUMAN_FEMALE_2, SOUNDSETMODEL_HUMAN_FEMALE_3}},
        {{SOUNDSETMODEL_DWARF_MALE_1, SOUNDSETMODEL_DWARF_MALE_2, SOUNDSETMODEL_DWARF_MALE_3}, {SOUNDSETMODEL_DWARF_FEMALE_1, SOUNDSETMODEL_DWARF_FEMALE_2, SOUNDSETMODEL_DWARF_FEMALE_3}},
        {{SOUNDSETMODEL_NIGHTELF_MALE_1, SOUNDSETMODEL_NIGHTELF_MALE_2, SOUNDSETMODEL_NIGHTELF_MALE_3}, {SOUNDSETMODEL_NIGHTELF_FEMALE_1, SOUNDSETMODEL_NIGHTELF_FEMALE_2, SOUNDSETMODEL_NIGHTELF_FEMALE_3}},
        {{SOUNDSETMODEL_GNOME_MALE_1, SOUNDSETMODEL_GNOME_MALE_2, SOUNDSETMODEL_GNOME_MALE_3}, {SOUNDSETMODEL_GNOME_FEMALE_1, SOUNDSETMODEL_GNOME_FEMALE_2, SOUNDSETMODEL_GNOME_FEMALE_3}},
        {{SOUNDSETMODEL_DRAENEI_MALE_1, SOUNDSETMODEL_DRAENEI_MALE_2, SOUNDSETMODEL_DRAENEI_MALE_3}, {SOUNDSETMODEL_DRAENEI_FEMALE_1, SOUNDSETMODEL_DRAENEI_FEMALE_2, SOUNDSETMODEL_DRAENEI_FEMALE_3}},
        {{SOUNDSETMODEL_ORC_MALE_1, SOUNDSETMODEL_ORC_MALE_2, SOUNDSETMODEL_ORC_MALE_3}, {SOUNDSETMODEL_ORC_FEMALE_1, SOUNDSETMODEL_ORC_FEMALE_2, SOUNDSETMODEL_ORC_FEMALE_3}},
        {{SOUNDSETMODEL_UNDEAD_MALE_1, SOUNDSETMODEL_UNDEAD_MALE_2, SOUNDSETMODEL_UNDEAD_MALE_3}, {SOUNDSETMODEL_UNDEAD_FEMALE_1, SOUNDSETMODEL_UNDEAD_FEMALE_2, SOUNDSETMODEL_UNDEAD_FEMALE_3}},
        {{SOUNDSETMODEL_TAUREN_MALE_1, SOUNDSETMODEL_TAUREN_MALE_2, SOUNDSETMODEL_TAUREN_MALE_3}, {SOUNDSETMODEL_TAUREN_FEMALE_1, SOUNDSETMODEL_TAUREN_FEMALE_2, SOUNDSETMODEL_TAUREN_FEMALE_3}},
        {{SOUNDSETMODEL_TROLL_MALE_1, SOUNDSETMODEL_TROLL_MALE_2, SOUNDSETMODEL_TROLL_MALE_3}, {SOUNDSETMODEL_TROLL_FEMALE_1, SOUNDSETMODEL_TROLL_FEMALE_2, SOUNDSETMODEL_TROLL_FEMALE_3}},
        {{SOUNDSETMODEL_BLOODELF_MALE_1, SOUNDSETMODEL_BLOODELF_MALE_2, SOUNDSETMODEL_BLOODELF_MALE_3}, {SOUNDSETMODEL_BLOODELF_FEMALE_1, SOUNDSETMODEL_BLOODELF_FEMALE_2, SOUNDSETMODEL_BLOODELF_FEMALE_3}}
    };

    static void GetBotClassNameAndColor(uint8 botclass, std::string& bot_color_str, std::string& bot_class_str)
    {
        switch (botclass)
        {
            case BOT_CLASS_WARRIOR:     bot_color_str = "ffc79c6e"; bot_class_str = "战士";                break;
            case BOT_CLASS_PALADIN:     bot_color_str = "fff58cba"; bot_class_str = "圣骑士";              break;
            case BOT_CLASS_HUNTER:      bot_color_str = "ffabd473"; bot_class_str = "猎人";                break;
            case BOT_CLASS_ROGUE:       bot_color_str = "fffff569"; bot_class_str = "潜行者";              break;
            case BOT_CLASS_PRIEST:      bot_color_str = "ffffffff"; bot_class_str = "牧师";                break;
            case BOT_CLASS_DEATH_KNIGHT:bot_color_str = "ffc41f3b"; bot_class_str = "死亡骑士";            break;
            case BOT_CLASS_SHAMAN:      bot_color_str = "ff0070de"; bot_class_str = "萨满祭司";            break;
            case BOT_CLASS_MAGE:        bot_color_str = "ff69ccf0"; bot_class_str = "法师";                break;
            case BOT_CLASS_WARLOCK:     bot_color_str = "ff9482c9"; bot_class_str = "术士";                break;
            case BOT_CLASS_DRUID:       bot_color_str = "ffff7d0a"; bot_class_str = "德鲁伊";              break;
            case BOT_CLASS_BM:          bot_color_str = "ffa10015"; bot_class_str = "剑圣";                break;
            case BOT_CLASS_SPHYNX:      bot_color_str = "ff29004a"; bot_class_str = "黑曜石毁灭者";        break;
            case BOT_CLASS_ARCHMAGE:    bot_color_str = "ff028a99"; bot_class_str = "大法师";              break;
            case BOT_CLASS_DREADLORD:   bot_color_str = "ff534161"; bot_class_str = "恐惧魔王";            break;
            case BOT_CLASS_SPELLBREAKER:bot_color_str = "ffcf3c1f"; bot_class_str = "破法者";              break;
            case BOT_CLASS_DARK_RANGER: bot_color_str = "ff3e255e"; bot_class_str = "黑暗游侠";            break;
            case BOT_CLASS_NECROMANCER: bot_color_str = "ff9900cc"; bot_class_str = "死灵法师";            break;
            case BOT_CLASS_SEA_WITCH:   bot_color_str = "ff40d7a9"; bot_class_str = "海妖";                break;
            default:                    bot_color_str = "ffffffff"; bot_class_str = "未知职业";            break;
        }
    }

    struct PlayerVisuals
    {
        struct PlayerVisualsBase{};
        struct Skins:PlayerVisualsBase{};
        struct Faces:PlayerVisualsBase{};
        struct HairStyles:PlayerVisualsBase{};
        struct HairColors:PlayerVisualsBase{};
        struct Features:PlayerVisualsBase{};
    };

    template<typename E, Races R, Gender G>
    static constexpr uint8 GetMaxVisual()
    {
        static_assert(std::is_base_of_v<PlayerVisuals::PlayerVisualsBase, E>, "GetMaxVisual() must check PlayerVisuals enums");

#define MV_PRED9(skinm,skinf,facem,facef,hairm,hairf,hairc,featm,featf) \
    if      constexpr (std::is_same_v<E, PlayerVisuals::Skins>)      return !F ? skinm : skinf; \
    else if constexpr (std::is_same_v<E, PlayerVisuals::Faces>)      return !F ? facem : facef; \
    else if constexpr (std::is_same_v<E, PlayerVisuals::HairStyles>) return !F ? hairm : hairf; \
    else if constexpr (std::is_same_v<E, PlayerVisuals::HairColors>) return !F ? hairc : hairc; \
    else if constexpr (std::is_same_v<E, PlayerVisuals::Features>)   return !F ? featm : featf

        constexpr bool F = G == GENDER_FEMALE;
        if constexpr (R == RACE_HUMAN)         { MV_PRED9(9,9, 11,14, 16,23, 9,  8,6); }
        if constexpr (R == RACE_DWARF)         { MV_PRED9(8,8,   9,9, 15,18, 9, 10,5); }
        if constexpr (R == RACE_NIGHTELF)      { MV_PRED9(8,8,   8,8, 11,11, 7,  5,9); }
        if constexpr (R == RACE_GNOME)         { MV_PRED9(4,4,   6,6, 11,11, 8,  7,6); }
        if constexpr (R == RACE_DRAENEI)       { MV_PRED9(13,13, 9,9, 13,15, 6,  7,6); }
        if constexpr (R == RACE_ORC)           { MV_PRED9(8,8,   8,8, 11,12, 7, 10,6); }
        if constexpr (R == RACE_UNDEAD_PLAYER) { MV_PRED9(5,5,   9,9, 14,14, 9, 16,7); }
        if constexpr (R == RACE_TAUREN)        { MV_PRED9(18,10, 4,3, 12,11, 2,  6,4); }
        if constexpr (R == RACE_TROLL)         { MV_PRED9(5,5,   4,5,   9,9, 9, 10,5); }
        if constexpr (R == RACE_BLOODELF)      { MV_PRED9(9,9,   9,9, 15,18, 9, 9,10); }

#undef MV_PRED9
        return 0;
    }

    static bool IsValidVisual(uint8 race, uint8 gender, uint8 skin, uint8 face, uint8 hairs, uint8 hairc, uint8 features)
    {
#define VISUALS_PRED1(r) (gender == GENDER_FEMALE) ? ( \
    skin <= GetMaxVisual<PlayerVisuals::Skins, r, GENDER_FEMALE>() && \
    face <= GetMaxVisual<PlayerVisuals::Faces, r, GENDER_FEMALE>() && \
    hairs <= GetMaxVisual<PlayerVisuals::HairStyles, r, GENDER_FEMALE>() && \
    hairc <= GetMaxVisual<PlayerVisuals::HairColors, r, GENDER_FEMALE>() && \
    features <= GetMaxVisual<PlayerVisuals::Features, r, GENDER_FEMALE>()) : ( \
    skin <= GetMaxVisual<PlayerVisuals::Skins, r, GENDER_MALE>() && \
    face <= GetMaxVisual<PlayerVisuals::Faces, r, GENDER_MALE>() && \
    hairs <= GetMaxVisual<PlayerVisuals::HairStyles, r, GENDER_MALE>() && \
    hairc <= GetMaxVisual<PlayerVisuals::HairColors, r, GENDER_MALE>() && \
    features <= GetMaxVisual<PlayerVisuals::Features, r, GENDER_MALE>())

        switch (race)
        {
            case RACE_HUMAN:         return VISUALS_PRED1(RACE_HUMAN);
            case RACE_DWARF:         return VISUALS_PRED1(RACE_DWARF);
            case RACE_NIGHTELF:      return VISUALS_PRED1(RACE_NIGHTELF);
            case RACE_GNOME:         return VISUALS_PRED1(RACE_GNOME);
            case RACE_DRAENEI:       return VISUALS_PRED1(RACE_DRAENEI);
            case RACE_ORC:           return VISUALS_PRED1(RACE_ORC);
            case RACE_UNDEAD_PLAYER: return VISUALS_PRED1(RACE_UNDEAD_PLAYER);
            case RACE_TAUREN:        return VISUALS_PRED1(RACE_TAUREN);
            case RACE_TROLL:         return VISUALS_PRED1(RACE_TROLL);
            case RACE_BLOODELF:      return VISUALS_PRED1(RACE_BLOODELF);
            default: return false;
        }
#undef VISUALS_PRED1
    }

    static void ReportVisualRanges(ChatHandler* handler)
    {
#define FILL_VISUALS_REPORT2(s,r) s \
    << get_race_name(r) << " 男:" \
    << " 皮肤 0-" << uint32(GetMaxVisual<PlayerVisuals::Skins, r, GENDER_MALE>()) \
    << " 脸型 0-" << uint32(GetMaxVisual<PlayerVisuals::Faces, r, GENDER_MALE>()) \
    << " 发型 0-" << uint32(GetMaxVisual<PlayerVisuals::HairStyles, r, GENDER_MALE>()) \
    << " 发色 0-" << uint32(GetMaxVisual<PlayerVisuals::HairColors, r, GENDER_MALE>()) \
    << " 特征 0-" << uint32(GetMaxVisual<PlayerVisuals::Features, r, GENDER_MALE>()) \
    << "\n" << get_race_name(r) << " 女:" \
    << " 皮肤 0-" << uint32(GetMaxVisual<PlayerVisuals::Skins, r, GENDER_FEMALE>()) \
    << " 脸型 0-" << uint32(GetMaxVisual<PlayerVisuals::Faces, r, GENDER_FEMALE>()) \
    << " 发型 0-" << uint32(GetMaxVisual<PlayerVisuals::HairStyles, r, GENDER_FEMALE>()) \
    << " 发色 0-" << uint32(GetMaxVisual<PlayerVisuals::HairColors, r, GENDER_FEMALE>()) \
    << " 特征 0-" << uint32(GetMaxVisual<PlayerVisuals::Features, r, GENDER_FEMALE>())

        handler->SendSysMessage("Ranges:");
        for (uint8 race : { RACE_HUMAN, RACE_DWARF, RACE_NIGHTELF, RACE_GNOME, RACE_DRAENEI, RACE_ORC, RACE_UNDEAD_PLAYER, RACE_TAUREN, RACE_TROLL, RACE_BLOODELF })
        {
            std::ostringstream stream;
            switch (race)
            {
                case RACE_HUMAN:         FILL_VISUALS_REPORT2(stream, RACE_HUMAN);         break;
                case RACE_DWARF:         FILL_VISUALS_REPORT2(stream, RACE_DWARF);         break;
                case RACE_NIGHTELF:      FILL_VISUALS_REPORT2(stream, RACE_NIGHTELF);      break;
                case RACE_GNOME:         FILL_VISUALS_REPORT2(stream, RACE_GNOME);         break;
                case RACE_DRAENEI:       FILL_VISUALS_REPORT2(stream, RACE_DRAENEI);       break;
                case RACE_ORC:           FILL_VISUALS_REPORT2(stream, RACE_ORC);           break;
                case RACE_UNDEAD_PLAYER: FILL_VISUALS_REPORT2(stream, RACE_UNDEAD_PLAYER); break;
                case RACE_TAUREN:        FILL_VISUALS_REPORT2(stream, RACE_TAUREN);        break;
                case RACE_TROLL:         FILL_VISUALS_REPORT2(stream, RACE_TROLL);         break;
                case RACE_BLOODELF:      FILL_VISUALS_REPORT2(stream, RACE_BLOODELF);      break;
                default:                                                                   break;
            }

            handler->PSendSysMessage(stream.str().c_str());
        }
#undef FILL_VISUALS_REPORT2
    }

    static std::pair<uint8, uint8> GetZoneLevels(uint32 zoneId)
    {
        //Only maps 0 and 1 are covered
        switch (zoneId)
        {
            case 1: // Dun Morogh
            case 12: // Elwynn Forest
            case 14: // Durotar
            case 85: // Tirisfal Glades
            case 141: // Teldrassil
            case 215: // Mulgore
            case 3430: // Eversong Woods
            case 3524: // Azuremyst Isle
                return { 1, 10 };
            case 38: // Loch Modan
            case 40: // Westfall
            case 130: // Silverpine Woods
            case 148: // Darkshore
            case 3433: // Ghostlands
            case 3525: // Bloodmyst Isle
            case 721: // Gnomeregan
                return { 8, 20 };
            case 17: // Barrens
                return { 8, 25 };
            case 44: // Redridge Mountains
            case 406: // Stonetalon Mountains
                return { 13, 25 };
            case 10: // Duskwood
            case 11: // Wetlands
            case 267: // Hillsbrad Foothills
            case 331: // Ashenvale
                return { 18, 30 };
            case 400: // Thousand Needles
                return { 23, 35 };
            case 36: // Alterac Mountains
            case 45: // Arathi Highlands
            case 405: // Desolace
                return { 28, 40 };
            case 33: // Stranglethorn Valley
            case 3: // Badlands
            case 8: // Swamp of Sorrows
            case 15: // Dustwallow Marsh
                return { 33, 45 };
            case 47: // Hinterlands
            case 357: // Feralas
            case 440: // Tanaris
                return { 38, 50 };
            case 4: // Blasted Lands
            case 16: // Azshara
            case 51: // Searing Gorge
                return { 43, 54 };
            case 490: // Un'Goro Crater
            case 361: // Felwood
                return { 46, 56 };
            case 28: // Western Plaguelands
            case 46: // Burning Steppes
                return { 48, 56 };
            case 41: // Deadwind Pass
                return { 50, 60 };
            case 1377: // Silithus
            case 2017: // Stratholme
            case 139: // Eastern Plaguelands
            case 618: // Winterspring
                return { 53, 60 };
            case 25: // BlackrockMountain
            case 493: // Moonglade
                return { 46, 60 };
            default:
                LOG_ERROR("scripts", "GetZoneLevels: no choice for zoneId {}", zoneId);
                return { 1, 60 };
        }
    }

    static bool IsNoWPZone(uint32 zoneId)
    {
        //Only maps 0 and 1 are covered
        switch (zoneId)
        {
            case 1477: // Moonglade
            case 1519: // Stormwind
            case 1537: // Ironforge
            case 1637: // Orgrimmar
            case 1638: // Thunder Bluff
            case 1657: // Darnassus
            case 3487: // Silvermoon
            case 3557: // Exodar
            case 493: // Moonglade
                return true;
            default:
                return false;
        }
    }

    static uint32 GetZoneIdOverride(uint32 zoneId)
    {
        switch (zoneId)
        {
            case 718: // Wailing Caverns
                return 17; // Barrens
            case 1337: // Uldaman
                return 3; // Badlands
            case 2057: // Scholomance
                return 139; // EPL
            case 2100: // Maraudon
                return 405; // Desolace
            case 1581: // Deadmines
                return 40; // Westfall
            default:
                return zoneId;
        }
    }

    struct BotInfo
    {
        explicit BotInfo(uint32 Id, std::string&& Name, uint8 Race) : id(Id), name(std::move(Name)), race(Race) {}
        uint32 id;
        std::string name;
        uint8 race;
    };

    static char const* get_race_name(uint8 race)
    {
        switch (race)
        {
            case RACE_HUMAN:        return "人类";
            case RACE_ORC:          return "兽人";
            case RACE_DWARF:        return "矮人";
            case RACE_NIGHTELF:     return "暗夜精灵";
            case RACE_UNDEAD_PLAYER:return "被遗忘者";
            case RACE_TAUREN:       return "牛头人";
            case RACE_GNOME:        return "侏儒";
            case RACE_TROLL:        return "巨魔";
            case RACE_BLOODELF:     return "血精灵";
            case RACE_DRAENEI:      return "德莱尼";
            default:                return "未知种族";
        }
    };

    static char const* get_class_name(uint8 class_)
    {
        switch (class_)
        {
            case CLASS_WARRIOR:     return "战士";
            case CLASS_PALADIN:     return "圣骑士";
            case CLASS_HUNTER:      return "猎人";
            case CLASS_ROGUE:       return "潜行者";
            case CLASS_PRIEST:      return "牧师";
            case CLASS_DEATH_KNIGHT:return "死亡骑士";
            case CLASS_SHAMAN:      return "萨满祭司";
            case CLASS_MAGE:        return "法师";
            case CLASS_WARLOCK:     return "术士";
            case CLASS_DRUID:       return "德鲁伊";
            default:                return "未知职业";
        }
    };

public:
    script_bot_commands() : CommandScript("script_bot_commands") { }

    class WanderNode_AI : public CreatureAI
    {
    public:
        WanderNode_AI(Creature* creature, WanderNode* wp) : CreatureAI(creature), _wp(wp)
        { _wp->SetCreature(me); }

        void JustDied(Unit*) override { _wp->SetCreature(nullptr); }

        bool CanAIAttack(Unit const*) const override { return false; }
        void MoveInLineOfSight(Unit*) override {}
        void AttackStart(Unit*) override {}
        void UpdateAI(uint32) override {}

    private:
        WanderNode* const _wp;
    };

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable npcbotToggleCommandTable =
        {
            { "flags",      HandleNpcBotToggleFlagsCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_TOGGLE_FLAGS,       Console::No  },
        };

        static ChatCommandTable npcbotWPCommandTable =
        {
            //{ "generate",   HandleNpcBotWPGenerateCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::Yes },
            { "spawnall",   HandleNpcBotWPSpawnAllCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "move",       HandleNpcBotWPMoveCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "add",        HandleNpcBotWPAddCommand,               rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "del",        HandleNpcBotWPDeleteCommand,            rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "list",       HandleNpcBotWPListCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "list all",   HandleNpcBotWPListAllCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::Yes },
            { "go",         HandleNpcBotWPGoCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setlevels",  HandleNpcBotWPSetLevelsCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setlevels z",HandleNpcBotWPSetLevelsZoneCommand,     rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::Yes },
            { "setflags",   HandleNpcBotWPSetFlagsCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setflags z", HandleNpcBotWPSetFlagsZoneCommand,      rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setname",    HandleNpcBotWPSetNameCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setlinks",   HandleNpcBotWPLinksSetCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "info",       HandleNpcBotWPCommand,                  rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "links",      HandleNpcBotWPLinksCommand,             rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
        };

        static ChatCommandTable npcbotDebugCommandTable =
        {
            { "raid",       HandleNpcBotDebugRaidCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_RAID,         Console::No  },
            { "mount",      HandleNpcBotDebugMountCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_MOUNT,        Console::No  },
            { "spellvisual",HandleNpcBotDebugSpellVisualCommand,    rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_VISUAL,       Console::No  },
            { "states",     HandleNpcBotDebugStatesCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::No  },
            { "spells",     HandleNpcBotDebugSpellsCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::No  },
        };

        static ChatCommandTable npcbotSetCommandTable =
        {
            { "faction",    HandleNpcBotSetFactionCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SET_FACTION,        Console::No  },
            { "owner",      HandleNpcBotSetOwnerCommand,            rbac::RBAC_PERM_COMMAND_NPCBOT_SET_OWNER,          Console::No  },
            { "spec",       HandleNpcBotSetSpecCommand,             rbac::RBAC_PERM_COMMAND_NPCBOT_SET_SPEC,           Console::No  },
        };

        static ChatCommandTable npcbotCommandCommandTable =
        {
            { "standstill", HandleNpcBotCommandStandstillCommand,   rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_STANDSTILL, Console::No  },
            { "stopfully",  HandleNpcBotCommandStopfullyCommand,    rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_STOPFULLY,  Console::No  },
            { "follow",     HandleNpcBotCommandFollowCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_FOLLOW,     Console::No  },
            { "walk",       HandleNpcBotCommandWalkCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "nogossip",   HandleNpcBotCommandNoGossipCommand,     rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "unbind",     HandleNpcBotCommandUnBindCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "rebind",     HandleNpcBotCommandReBindCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
        };

        static ChatCommandTable npcbotAttackDistanceCommandTable =
        {
            { "short",      HandleNpcBotAttackDistanceShortCommand, rbac::RBAC_PERM_COMMAND_NPCBOT_ATTDISTANCE_SHORT,  Console::No  },
            { "long",       HandleNpcBotAttackDistanceLongCommand,  rbac::RBAC_PERM_COMMAND_NPCBOT_ATTDISTANCE_LONG,   Console::No  },
            { "",           HandleNpcBotAttackDistanceExactCommand, rbac::RBAC_PERM_COMMAND_NPCBOT_ATTDISTANCE_EXACT,  Console::No  },
        };

        static ChatCommandTable npcbotDistanceCommandTable =
        {
            { "attack",     npcbotAttackDistanceCommandTable                                                                        },
            { "",           HandleNpcBotFollowDistanceCommand,      rbac::RBAC_PERM_COMMAND_NPCBOT_FOLDISTANCE_EXACT,  Console::No  },
        };

        static ChatCommandTable npcbotOrderCommandTable =
        {
            { "cast",       HandleNpcBotOrderCastCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_ORDER_CAST,         Console::No  },
        };

        static ChatCommandTable npcbotVehicleCommandTable =
        {
            { "eject",      HandleNpcBotVehicleEjectCommand,        rbac::RBAC_PERM_COMMAND_NPCBOT_VEHICLE_EJECT,      Console::No  },
        };

        static ChatCommandTable npcbotDumpCommandTable =
        {
            { "load",       HandleNpcBotDumpLoadCommand,            rbac::RBAC_PERM_COMMAND_NPCBOT_DUMP_LOAD,          Console::Yes },
            { "write",      HandleNpcBotDumpWriteCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_DUMP_WRITE,         Console::Yes },
        };

        static ChatCommandTable npcbotRecallCommandTable =
        {
            { "",           HandleNpcBotRecallCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_RECALL,             Console::No  },
            { "spawns",     HandleNpcBotRecallSpawnsCommand,        rbac::RBAC_PERM_COMMAND_NPCBOT_RECALL,             Console::No  },
            { "teleport",   HandleNpcBotRecallTeleportCommand,      rbac::RBAC_PERM_COMMAND_NPCBOT_RECALL,             Console::No  },
        };

        static ChatCommandTable npcbotListSpawnedCommandTable =
        {
            { "",           HandleNpcBotSpawnedCommand,             rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWNED,            Console::Yes },
            { "free",       HandleNpcBotSpawnedFreeCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWNED,            Console::Yes },
        };

        static ChatCommandTable npcbotListCommandTable =
        {
            { "spawned",    npcbotListSpawnedCommandTable                                                                           },
        };

        static ChatCommandTable npcbotDeleteCommandTable =
        {
            { "",           HandleNpcBotDeleteCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_DELETE,             Console::No  },
            { "id",         HandleNpcBotDeleteByIdCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_DELETE,             Console::Yes },
            { "free",       HandleNpcBotDeleteFreeCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_DELETE,             Console::Yes },
        };

        static ChatCommandTable npcbotSendToPointCommandTable =
        {
            { "",           HandleNpcBotSendToPointCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_SEND,               Console::No  },
            { "set",        HandleNpcBotSendToPointSetCommand,      rbac::RBAC_PERM_COMMAND_NPCBOT_SEND,               Console::No  },
        };

        static ChatCommandTable npcbotSendToCommandTable =
        {
            { "",           HandleNpcBotSendToCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_SEND,               Console::No  },
            { "last",       HandleNpcBotSendToLastCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SEND,               Console::No  },
            { "point",      npcbotSendToPointCommandTable                                                                           },
        };

        static ChatCommandTable npcbotCommandTable =
        {
            //{ "debug",      npcbotDebugCommandTable                                                                                 },
            //{ "toggle",     npcbotToggleCommandTable                                                                                },
            { "set",        npcbotSetCommandTable                                                                                   },
            { "add",        HandleNpcBotAddCommand,                 rbac::RBAC_PERM_COMMAND_NPCBOT_ADD,                Console::No  },
            { "remove",     HandleNpcBotRemoveCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_REMOVE,             Console::No  },
            { "createnew",  HandleNpcBotCreateNewCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_CREATENEW,          Console::Yes },
            { "spawn",      HandleNpcBotSpawnCommand,               rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "move",       HandleNpcBotMoveCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_MOVE,               Console::No  },
            { "delete",     npcbotDeleteCommandTable                                                                                },
            { "lookup",     HandleNpcBotLookupCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_LOOKUP,             Console::Yes },
            { "list",       npcbotListCommandTable                                                                                  },
            { "revive",     HandleNpcBotReviveCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_REVIVE,             Console::No  },
            { "reloadconfig",HandleNpcBotReloadConfigCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_RELOADCONFIG,       Console::Yes },
            { "command",    npcbotCommandCommandTable                                                                               },
            { "info",       HandleNpcBotInfoCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_INFO,               Console::No  },
            { "hide",       HandleNpcBotHideCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_HIDE,               Console::No  },
            { "unhide",     HandleNpcBotUnhideCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_UNHIDE,             Console::No  },
            { "show",       HandleNpcBotUnhideCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_UNHIDE,             Console::No  },
            { "recall",     npcbotRecallCommandTable                                                                                },
            { "kill",       HandleNpcBotKillCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_KILL,               Console::No  },
            { "suicide",    HandleNpcBotKillCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_KILL,               Console::No  },
            { "go",         HandleNpcBotGoCommand,                  rbac::RBAC_PERM_COMMAND_NPCBOT_MOVE,               Console::No  },
            { "sendto",     npcbotSendToCommandTable                                                                                },
            { "distance",   npcbotDistanceCommandTable                                                                              },
            { "order",      npcbotOrderCommandTable                                                                                 },
            { "vehicle",    npcbotVehicleCommandTable                                                                               },
            { "dump",       npcbotDumpCommandTable                                                                                  },
            { "wp",         npcbotWPCommandTable                                                                                    },
        };

        static ChatCommandTable commandTable =
        {
            { "npcbot",     npcbotCommandTable                                                                                      },
        };
        return commandTable;
    }

    static TempSummon* HandleWPSummon(WanderNode* wp, Map* map)
    {
        CellCoord c = Acore::ComputeCellCoord(wp->m_positionX, wp->m_positionY);
        GridCoord g = Acore::ComputeGridCoord(wp->m_positionX, wp->m_positionY);
        ASSERT(c.IsCoordValid(), "Invalid Cell coord!");
        ASSERT(g.IsCoordValid(), "Invalid Grid coord!");
        map->LoadGrid(wp->m_positionX, wp->m_positionY);
        ASSERT(map->GetEntry()->IsContinent() || map->GetEntry()->IsBattlegroundOrArena(), map->GetDebugInfo().c_str());

        TempSummon* wpc = map->SummonCreature(VISUAL_WAYPOINT, *wp);
        wpc->SetTempSummonType(TEMPSUMMON_CORPSE_DESPAWN);
        wpc->AIM_Initialize(new WanderNode_AI(wpc, wp));
        wpc->setActive(true);
        wpc->SetVisibilityDistanceOverride(VisibilityDistanceType::Infinite);
        wpc->SetLevel(wp->GetLevels().first);
        wpc->AddUnitState(UNIT_STATE_EVADE);
        wpc->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
        wpc->SetMaxHealth(wp->GetWPId());
        wpc->SetFullHealth();
        wpc->SetPowerType(POWER_MANA);
        wpc->SetMaxPower(POWER_MANA, uint32(wp->GetLinks().size()));
        wpc->SetPower(POWER_MANA, wpc->GetMaxPower(POWER_MANA));
        wpc->SetObjectScale(10.0f);
        return wpc;
    }

    static bool HandleNpcBotWPGenerateCommand(ChatHandler* handler, Optional<bool> save)
    {
        WanderNode::RemoveAllWPs();

        handler->SendSysMessage("Generating wander nodes from POIs. No levels or flags will be set");

        uint32 poiId_start = 0;
        for (AreaPOIEntry const* aProto : sAreaPOIStore)
        {
            if (aProto->mapId != 0 && aProto->mapId != 1/* && aProto->ContinentID != 530 && aProto->ContinentID != 571*/)
                continue;

            uint32 poiId = ++poiId_start;
            std::string poiName = aProto->name;
            if (strlen(aProto->name2) > 0)
            {
                poiName += " - ";
                poiName += aProto->name2;
            }
            poiName.erase(std::remove_if(std::begin(poiName), std::end(poiName), [](char c) { return c == '\''; }), poiName.end());
            uint32 poiMapId = aProto->mapId;
            float x = aProto->x;
            float y = aProto->y;
            float z = aProto->z;
            float o = frand(0.001f, float(M_PI + M_PI) - 0.001f);
            float ground_z = sMapMgr->CreateBaseMap(poiMapId)->GetHeight(PHASEMASK_NORMAL, x, y, z);
            if (ground_z > INVALID_HEIGHT)
                z = ground_z;
            uint32 poiZoneId, poiAreaId;
            sMapMgr->GetZoneAndAreaId(PHASEMASK_NORMAL, poiZoneId, poiAreaId, poiMapId, x, y, z);

            poiZoneId = GetZoneIdOverride(poiZoneId);
            if (IsNoWPZone(poiZoneId))
            {
                --poiId_start;
                continue;
            }

            WanderNode* wp = new WanderNode(poiId, poiMapId, x, y, z, o, poiZoneId, poiAreaId, poiName);
            auto [minl, maxl] = GetZoneLevels(poiZoneId);
            wp->SetLevels(minl, maxl);
            BotWPFlags flags = BotWPFlags::BOTWP_FLAG_NONE;
            wp->SetFlags(flags);
            WanderNode::DoForAllMapWPs(poiMapId, [wp = wp](WanderNode const* mwp) {
                if (mwp->GetWPId() != wp->GetWPId() && mwp->GetExactDist2d(wp) < MAX_VISIBILITY_DISTANCE)
                    wp->Link(const_cast<WanderNode*>(mwp));
            });

            handler->SendSysMessage(wp->ToString().c_str());
        }

        handler->PSendSysMessage("Generating wander nodes completed with %u nodes", uint32(WanderNode::GetAllWPsCount()));

        if (!(save && *save))
            return true;

        WorldDatabaseTransaction trans = WorldDatabase.BeginTransaction();
        trans->Append("DROP TABLE IF EXISTS creature_wander_nodes_");
        trans->Append(
            "CREATE TABLE creature_wander_nodes_ ("
            "  `id` int(10) unsigned NOT NULL,"
            "  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RENAME_ME',"
            "  `mapid` smallint(5) unsigned NOT NULL DEFAULT '0',"
            "  `zoneid` int(10) unsigned NOT NULL DEFAULT '0',"
            "  `areaid` int(10) unsigned NOT NULL DEFAULT '0',"
            "  `minlevel` tinyint(3) unsigned NOT NULL DEFAULT '0',"
            "  `maxlevel` tinyint(3) unsigned NOT NULL DEFAULT '0',"
            "  `flags` int(10) unsigned NOT NULL DEFAULT '0',"
            "  `x` float NOT NULL DEFAULT '0',"
            "  `y` float NOT NULL DEFAULT '0',"
            "  `z` float NOT NULL DEFAULT '0',"
            "  `o` float NOT NULL DEFAULT '0',"
            "  `links` mediumtext COLLATE utf8mb4_unicode_ci,"
            "  PRIMARY KEY (`id`)"
            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bot Wander Map'"
        );
        std::ostringstream ss;
        ss << "INSERT INTO creature_wander_nodes_ (id,mapid,x,y,z,o,zoneId,areaId,minlevel,maxlevel,flags,name,links) VALUES ";
        WanderNode::DoForAllWPs([&ss](WanderNode const* wp) {
            auto [minl, maxl] = wp->GetLevels();
            ss << '(' << wp->GetWPId() << ',' << wp->GetMapId()
                << ',' << wp->GetPositionX() << ',' << wp->GetPositionY() << ',' << wp->GetPositionZ() << ',' << wp->GetOrientation()
                << ',' << wp->GetZoneId() << ',' << wp->GetAreaId() << ',' << uint32(minl) << ',' << uint32(maxl)
                << ',' << wp->GetFlags() << ",'" << wp->GetName().c_str() << "','" << wp->FormatLinks() << "'),";
        });
        std::string val_str = ss.str();
        val_str.resize(val_str.size() - 1u);
        trans->Append(val_str);
        WorldDatabase.CommitTransaction(trans);

        handler->SendSysMessage("Saved.");

        return true;
    }

    static bool HandleNpcBotWPSpawnAllCommand(ChatHandler* handler)
    {
        if (!isWPSpawnWarningGiven)
        {
            isWPSpawnWarningGiven = true;
            handler->SendSysMessage("Warning! Spawning all wander points in map will load ALL required grids. Repeat to confirm.");
            handler->SetSentErrorMessage(true);
            return false;
        }
        else
        {
            if (WanderNode::GetAllWPsCount() == 0u)
                BotDataMgr::LoadWanderMap();

            Player* player = handler->GetPlayer();
            WanderNode::DoForAllMapWPs(player->GetMapId(), [map = player->GetMap()](WanderNode const* wp) {
                if (Creature* wpc = wp->GetCreature())
                    wpc->ToTempSummon()->DespawnOrUnsummon();
                ASSERT_NOTNULL(HandleWPSummon(const_cast<WanderNode*>(wp), map));
            });
        }

        return true;
    }

    static bool HandleNpcBotWPLinksCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        auto const& links = wp->GetLinks();

        std::ostringstream ss;
        ss.setf(std::ios_base::fixed);
        ss.precision(2);
        uint32 counter = 0;
        ss << "WP " << wp->GetWPId() << " has " << uint32(links.size()) << " links:";
        WanderNode::DoForContainerWPs(links, [&ss, &counter, wp = wp](WanderNode const* lwp) {
            ss << "\n" << ++counter << ") " << lwp->ToString() << " (dist2d: " << wp->GetExactDist2d(lwp) << ")";
        });

        handler->SendSysMessage(ss.str().c_str());

        WanderNode::DoForContainerWPs(links, [wp = wp, wpc = wpc, handler = handler](WanderNode const* lwp) {
            if (!lwp->GetCreature())
            {
                handler->PSendSysMessage("Can't visualise link %u-%u, no creature...", wp->GetWPId(), lwp->GetWPId());
                return;
            }
            wpc->CastSpell(lwp->GetCreature(), 2400, true);
            wpc->CastSpell(lwp->GetCreature(), 41637, true);
        });

        return true;
    }
    static void HandleWPUpdateLinks(ChatHandler* handler, WanderNode* wp, std::vector<uint32> linkIds, bool oneway = false)
    {
        auto const linksCopy = wp->GetLinks();

        std::set<decltype(linksCopy)::value_type> wps_updates;
        std::copy(std::cbegin(linksCopy), std::cend(linksCopy), std::inserter(wps_updates, wps_updates.begin()));

        std::set<decltype(linksCopy)::value_type> wps_relinks = wps_updates;

        wps_updates.insert(wp);

        if (linksCopy.empty())
            handler->PSendSysMessage("WP %u had no links...", wp->GetWPId());
        else
        {
            WanderNode::DoForContainerWPs(linksCopy, [wp = wp, handler = handler](WanderNode* lwp) {
                handler->PSendSysMessage("Removing link %u<->%u...", wp->GetWPId(), lwp->GetWPId());
                wp->UnLink(lwp);
            });
        }

        for (uint32 lid : linkIds)
        {
            if (lid == wp->GetWPId())
            {
                handler->PSendSysMessage("Trying to add WP %u to its own links! Are you dumb?", lid);
                continue;
            }

            WanderNode* lwp = WanderNode::FindInMapWPs(lid, wp->GetMapId());
            if (!lwp)
            {
                handler->PSendSysMessage("WP %u is not found in map %u!", lid, wp->GetMapId());
                continue;
            }

            if (wps_relinks.count(lwp) != 0)
                wps_relinks.erase(lwp);

            handler->PSendSysMessage("Adding link %u%s%u...", wp->GetWPId(), oneway ? "->" : "<->", lid);
            if (wp->GetExactDist2d(lwp) > MAX_VISIBILITY_DISTANCE)
                handler->PSendSysMessage("Warning! Link distance is too great (%.2f)", wp->GetExactDist2d(lwp));

            wp->Link(lwp, oneway);
            wps_updates.insert(lwp);
        }

        if (oneway)
        {
            std::vector<decltype(linksCopy)::value_type> wps_relinks_vec;
            wps_relinks_vec.reserve(wps_relinks.size());
            for (WanderNode* rlwp : wps_relinks)
                wps_relinks_vec.push_back(rlwp);
            std::sort(wps_relinks_vec.begin(), wps_relinks_vec.end());
            for (WanderNode* rlwp : wps_relinks_vec)
            {
                handler->PSendSysMessage("Adding link %u<->%u...", wp->GetWPId(), rlwp->GetWPId());
                if (wp->GetExactDist2d(rlwp) > MAX_VISIBILITY_DISTANCE)
                    handler->PSendSysMessage("Warning! Link distance is too great (%.2f)", wp->GetExactDist2d(rlwp));
                wp->Link(rlwp);
            }
        }

        WorldDatabaseTransaction trans = WorldDatabase.BeginTransaction();
        WanderNode::DoForContainerWPs(wps_updates, [&trans](WanderNode const* uwp) {
            if (Creature* wpc = uwp->GetCreature())
            {
                wpc->SetMaxPower(POWER_MANA, uint32(uwp->GetLinks().size()));
                wpc->SetPower(POWER_MANA, wpc->GetMaxPower(POWER_MANA));
            }
            trans->Append("UPDATE creature_template_npcbot_wander_nodes SET links='{}' WHERE id={}", uwp->FormatLinks().c_str(), uwp->GetWPId());
        });
        WorldDatabase.DirectCommitTransaction(trans);
    }
    static bool HandleNpcBotWPLinksSetCommand(ChatHandler* handler, Optional<std::vector<uint32>> linkIds, Optional<bool> oneway)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!linkIds)
        {
            handler->SendSysMessage("Syntax: npcbot wp links set #[ids...]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        HandleWPUpdateLinks(handler, wp, *linkIds, oneway ? *oneway : false);

        return true;
    }

    static bool HandleNpcBotWPCommand(ChatHandler* handler, Optional<uint32> wpId)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;

        if (!wp && wpId)
            wp = WanderNode::FindInAllWPs(*wpId);

        if (!wp)
        {
            handler->SendSysMessage("Syntax: npcbot wp info #[id_or_selection]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->SendSysMessage(wp->ToString());

        return true;
    }
    static bool HandleNpcBotWPSetLevelsZoneCommand(ChatHandler* handler, Optional<uint8> minlevel, Optional<uint8> maxlevel)
    {
        Player* player = handler->GetPlayer();

        if (!minlevel || !maxlevel)
        {
            handler->SendSysMessage("Syntax: npcbot wp info setlevels z #[minlevel] #[maxlevel]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!*minlevel || !*maxlevel || *minlevel > DEFAULT_MAX_LEVEL || *maxlevel > DEFAULT_MAX_LEVEL || *minlevel > *maxlevel)
        {
            handler->PSendSysMessage("WP levels must be within bounds 1-%u, min <= max", uint32(DEFAULT_MAX_LEVEL));
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 zoneId, areaId;
        player->GetZoneAndAreaId(zoneId, areaId);
        handler->PSendSysMessage("Setting levels min=%u max=%u for zone %u", uint32(*minlevel), uint32(*maxlevel), zoneId);
        WanderNode::DoForAllZoneWPs(zoneId, [handler = handler, minl = *minlevel, maxl = *maxlevel](WanderNode const* wp) {
            handler->PSendSysMessage("Setting levels min=%u max=%u for node %u '%s'",
                uint32(minl), uint32(maxl), wp->GetWPId(), wp->GetName().c_str());
            const_cast<WanderNode*>(wp)->SetLevels(minl, maxl);
            if (Creature* creature = wp->GetCreature())
                if (creature->GetLevel() != minl)
                    creature->SetLevel(minl);
            WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET minlevel={}, maxlevel={} WHERE id={}",
                uint32(minl), uint32(maxl), wp->GetWPId());
        });

        return true;
    }
    static bool HandleNpcBotWPSetLevelsCommand(ChatHandler* handler, Optional<uint8> minlevel, Optional<uint8> maxlevel)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!minlevel || !maxlevel)
        {
            handler->SendSysMessage("Syntax: npcbot wp info setlevels #[minlevel] #[maxlevel]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!*minlevel || !*maxlevel || *minlevel > DEFAULT_MAX_LEVEL || *maxlevel > DEFAULT_MAX_LEVEL || *minlevel > *maxlevel)
        {
            handler->PSendSysMessage("WP levels must be within bounds 1-%u, min <= max", uint32(DEFAULT_MAX_LEVEL));
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 wpId = wp->GetWPId();
        auto [minlevel_cur, maxlevel_cur] = wp->GetLevels();

        handler->PSendSysMessage("Changing WP %u '%s' levels from %u-%u to %u-%u",
            wpId, wp->GetName().c_str(), uint32(minlevel_cur), uint32(maxlevel_cur), uint32(*minlevel), uint32(*maxlevel));
        wp->SetLevels(*minlevel, *maxlevel);
        if (Creature* creature = wp->GetCreature())
            if (creature->GetLevel() != *minlevel)
                creature->SetLevel(*minlevel);

        WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET minlevel={}, maxlevel={} WHERE id={}",
            uint32(*minlevel), uint32(*maxlevel), wpId);

        return true;
    }

    static bool HandleNpcBotWPSetFlagsZoneCommand(ChatHandler* handler, Optional<int32> flags)
    {
        Player* player = handler->GetPlayer();

        if (!flags)
        {
            handler->SendSysMessage("Syntax: npcbot wp info setflags z #[flags]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 zoneId, areaId;
        player->GetZoneAndAreaId(zoneId, areaId);
        WanderNode::DoForAllZoneWPs(zoneId, [handler = handler, flags = *flags](WanderNode const* wp) {
            uint32 wpId = wp->GetWPId();
            if (flags < 0)
            {
                handler->PSendSysMessage("Removing WP %u '%s' flag %u", wpId, wp->GetName().c_str(), uint32(-flags));
                const_cast<WanderNode*>(wp)->RemoveFlags(BotWPFlags(-flags));
            }
            else
            {
                handler->PSendSysMessage("Adding WP %u '%s' flag %u", wpId, wp->GetName().c_str(), uint32(flags));
                const_cast<WanderNode*>(wp)->SetFlags(BotWPFlags(flags));
            }
            WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET flags={} WHERE id={}", wp->GetFlags(), wpId);
        });

        return true;
    }
    static bool HandleNpcBotWPSetFlagsCommand(ChatHandler* handler, Optional<int32> flags)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!flags)
        {
            handler->SendSysMessage("Syntax: npcbot wp info setflags #[flag]. Use negative value to remove");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 wpId = wp->GetWPId();

        if (*flags < 0)
        {
            handler->PSendSysMessage("Removing WP %u '%s' flag %u", wpId, wp->GetName().c_str(), uint32(-*flags));
            wp->RemoveFlags(BotWPFlags(-*flags));
        }
        else
        {
            handler->PSendSysMessage("Adding WP %u '%s' flag %u", wpId, wp->GetName().c_str(), uint32(*flags));
            wp->SetFlags(BotWPFlags(*flags));
        }

        WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET flags={} WHERE id={}", wp->GetFlags(), wpId);

        return true;
    }
    static bool HandleNpcBotWPSetNameCommand(ChatHandler* handler, Optional<std::string> newname)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!newname)
        {
            handler->SendSysMessage("Syntax: npcbot wp info setname #[name]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 wpId = wp->GetWPId();

        handler->PSendSysMessage("Changing WP %u '%s' name to '%s'", wpId, wp->GetName().c_str(), newname->c_str());
        wp->SetName(*newname);

        WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET name='{}' WHERE id={}", wp->GetName().c_str(), wpId);

        return true;
    }

    static bool HandleNpcBotWPMoveCommand(ChatHandler* handler, Optional<uint32> wpId)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = (wpc && wpc->GetTypeId() == TYPEID_UNIT) ? WanderNode::FindInAllWPs(wpc->ToCreature()) :
            wpId ? WanderNode::FindInAllWPs(*wpId) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected or id provided");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (wp->GetMapId() != player->GetMapId())
        {
            handler->SendSysMessage("Can't move WP to a different map!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        wp->Relocate(player);
        if (Creature* creature = wp->GetCreature())
            creature->NearTeleportTo(*player);

        WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET x={},y={},z={},o={} WHERE id={}",
            wp->m_positionX, wp->m_positionY, wp->m_positionZ, wp->GetOrientation(), wp->GetWPId());

        handler->PSendSysMessage("WP %u '%s' was successfully moved.", wp->GetWPId(), wp->GetName().c_str());

        return true;
    }

    static bool HandleNpcBotWPAddCommand(ChatHandler* handler, Optional<uint32> flags, Optional<std::string> name,
        Optional<uint8> minlevel, Optional<uint8> maxlevel)
    {
        Player* player = handler->GetPlayer();

        if (!flags || !name || (!player->GetMap()->GetEntry()->IsContinent() && !player->GetMap()->GetEntry()->IsBattlegroundOrArena()))
        {
            handler->SendSysMessage("Syntax: npcbot wp add #[flags] #[name] #[minlevel #[maxlevel]]. World maps only");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (minlevel)
        {
            if (!*minlevel || *minlevel > DEFAULT_MAX_LEVEL)
            {
                handler->PSendSysMessage("Minlevel must be between 1 and %u!", uint32(DEFAULT_MAX_LEVEL));
                handler->SetSentErrorMessage(true);
                return false;
            }
            if (maxlevel)
            {
                if (!*maxlevel || *maxlevel > DEFAULT_MAX_LEVEL)
                {
                    handler->PSendSysMessage("Maxlevel must be between 1 and %u!", uint32(DEFAULT_MAX_LEVEL));
                    handler->SetSentErrorMessage(true);
                    return false;
                }
                if (*minlevel > *maxlevel)
                {
                    handler->SendSysMessage("Minlevel can't be greater than maxlevel");
                    handler->SetSentErrorMessage(true);
                    return false;
                }
            }
        }

        if (*flags >= AsUnderlyingType(BotWPFlags::BOTWP_FLAG_END))
        {
            handler->PSendSysMessage("Flags must below %u!", AsUnderlyingType(BotWPFlags::BOTWP_FLAG_END));
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 zoneId, areaId;
        player->GetZoneAndAreaId(zoneId, areaId);
        WanderNode* wp = new WanderNode(++WanderNode::nextWPId, player->GetMapId(), player->m_positionX, player->m_positionY, player->m_positionZ,
            player->GetOrientation(), zoneId, areaId, *name);

        wp->SetLevels((!minlevel && !maxlevel) ? GetZoneLevels(GetZoneIdOverride(zoneId)) : std::pair{minlevel ? *minlevel : uint8(1), maxlevel ? *maxlevel : uint8(DEFAULT_MAX_LEVEL)});
        wp->SetFlags(BotWPFlags(*flags));

        std::vector<uint32> linkIds;
        if (Unit* twpc = player->GetSelectedUnit())
            if (WanderNode const* twp = WanderNode::FindInMapWPs(twpc->ToCreature(), player->GetMapId()))
                if (twp->GetWPId() != wp->GetWPId() - 1)
                    linkIds.push_back(twp->GetWPId());
        if (linkIds.empty())
        {
            if (WanderNode const* pwp = WanderNode::FindInMapWPs(wp->GetWPId() - 1, player->GetMapId()))
                if (wp->GetExactDist2d(pwp) < MAX_VISIBILITY_DISTANCE)
                    linkIds.push_back(pwp->GetWPId());
        }
        if (linkIds.empty())
        {
            WanderNode::DoForAllMapWPs(wp->GetMapId(), [wp = wp, &linkIds](WanderNode const* mwp) {
                if (wp->GetWPId() != mwp->GetWPId() && wp->GetExactDist2d(mwp) < MAX_VISIBILITY_DISTANCE)
                    linkIds.push_back(mwp->GetWPId());
            });
        }
        HandleWPUpdateLinks(handler, wp, linkIds);

        ASSERT_NOTNULL(HandleWPSummon(wp, player->GetMap()));

        uint32 wpId = wp->GetWPId();
        std::string wpName = wp->GetName();
        auto [minl, maxl] = wp->GetLevels();
        uint32 wpFlags = wp->GetFlags();

        std::ostringstream ss;
        ss << "INSERT INTO creature_template_npcbot_wander_nodes (id,mapid,x,y,z,o,zoneId,areaId,minlevel,maxlevel,flags,name,links)"
            << " VALUES "
            << '(' << wpId << ',' << wp->GetMapId()
            << ',' << wp->GetPositionX() << ',' << wp->GetPositionY() << ',' << wp->GetPositionZ() << ',' << wp->GetOrientation()
            << ',' << wp->GetZoneId() << ',' << wp->GetAreaId() << ',' << uint32(minl) << ',' << uint32(maxl)
            << ',' << wpFlags << ",'" << wpName << "','" << wp->FormatLinks() << "')";

        WorldDatabase.Execute(ss.str().c_str());

        handler->PSendSysMessage("Created WP %u '%s' levels %u-%u flags %u", wpId, wpName.c_str(), uint32(minl), uint32(maxl), wpFlags);

        return true;
    }
    static bool HandleNpcBotWPDeleteCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();

        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 wpId = wp->GetWPId();
        std::string wpName = wp->GetName();

        HandleWPUpdateLinks(handler, wp, {});
        wpc->ToCreature()->AIM_Initialize();
        if (wpc->IsInWorld())
            wpc->ToTempSummon()->DespawnOrUnsummon();
        WanderNode::RemoveWP(wp);

        WorldDatabase.Execute("DELETE FROM creature_template_npcbot_wander_nodes WHERE id={}", wpId);

        handler->PSendSysMessage("WP %u '%s' was successfully deleted.", wpId, wpName.c_str());

        return true;
    }

    static bool HandleNpcBotWPListCommand(ChatHandler* handler, Optional<uint32> ozoneId, Optional<uint32> oareaId)
    {
        Player* player = handler->GetPlayer();

        uint32 zoneId = 0, areaId = 0;
        if (!ozoneId && !oareaId)
            player->GetZoneAndAreaId(zoneId, areaId);
        else
        {
            if (ozoneId)
                zoneId = *ozoneId;
            if (oareaId)
                areaId = *oareaId;
        }

        std::ostringstream ss;
        ss << "Zone " << zoneId << " (" << std::string(sAreaTableStore.LookupEntry(zoneId)->area_name[0]) << ") wps:";
        WanderNode::DoForAllZoneWPs(zoneId, [&ss](WanderNode const* wp) {
            ss << "\n" << wp->ToString();
        });
        ss << "\nArea " << areaId << " (" << std::string(sAreaTableStore.LookupEntry(areaId)->area_name[0]) << ") wps:";
        WanderNode::DoForAllAreaWPs(areaId, [&ss](WanderNode const* wp) {
            ss << "\n" << wp->ToString();
        });

        handler->SendSysMessage(ss.str().c_str());
        return true;
    }
    static bool HandleNpcBotWPListAllCommand(ChatHandler* handler)
    {
        WanderNode::DoForAllWPs([handler = handler](WanderNode* wp) {
            handler->SendSysMessage(wp->ToString().c_str());
        });

        return true;
    }

    static bool HandleNpcBotWPGoCommand(ChatHandler* handler, uint32 wpId)
    {
        Player* player = handler->GetPlayer();

        WanderNode const* wp = WanderNode::FindInAllWPs(wpId);
        if (!wp)
        {
            handler->PSendSysMessage("WP %u not found", wpId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        player->TeleportTo(WorldLocation(wp->GetMapId(), *wp), TELE_TO_GM_MODE);

        return true;
    }

    static bool HandleNpcBotDebugSpellsCommand(ChatHandler* /*handler*/)
    {
        //Unit* target = handler->getSelectedUnit();
        //if (!target)
        //{
        //    handler->SendSysMessage("No target selected");
        //    return true;
        //}

        //std::ostringstream ostr;
        //ostr << "Listing spells for " << target->GetName() << ':';
        //for (uint8 i = 0; i < CURRENT_MAX_SPELL; ++i)
        //{
        //    if (Spell const* curSpell = target->GetCurrentSpell(CurrentSpellTypes(i)))
        //        ostr << "\nSpell type " << uint32(i) << ":\n" << curSpell->GetDebugInfo();
        //}

        //handler->SendSysMessage(ostr.str().c_str());
        return true;
    }

    static bool HandleNpcBotDebugStatesCommand(ChatHandler* handler)
    {
        Unit const* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage("No target selected");
            return true;
        }

        std::ostringstream ostr;
        ostr << "Listing states for " << target->GetName() << ":";
        for (uint32 state = 1u; state != 1u << 31; state <<= 1)
        {
            if (target->HasUnitState(state))
                ostr << "\n    0x" << std::hex << (state);
        }

        handler->SendSysMessage(ostr.str().c_str());
        return true;
    }

    static bool HandleNpcBotDebugRaidCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        Group const* gr = owner->GetGroup();
        if (!owner->HaveBot() || !gr)
        {
            handler->SendSysMessage(".npcbot debug raid");
            handler->SendSysMessage("prints your raid bots info");
            return true;
        }
        if (!gr->isRaidGroup())
        {
            handler->SendSysMessage("only usable in raid");
            return true;
        }

        uint8 counter = 0;
        uint8* subBots = new uint8[MAX_RAID_SUBGROUPS];
        memset((void*)subBots, 0, (MAX_RAID_SUBGROUPS)*sizeof(uint8));
        std::ostringstream sstr;
        BotMap const* map = owner->GetBotMgr()->GetBotMap();
        for (BotMap::const_iterator itr = map->begin(); itr != map->end(); ++itr)
        {
            Creature* bot = itr->second;
            if (!bot || !gr->IsMember(itr->second->GetGUID()))
                continue;

            uint8 subGroup = gr->GetMemberGroup(itr->second->GetGUID());
            ++subBots[subGroup];
            sstr << uint32(++counter) << ": " << bot->GetGUID().GetCounter() << " " << bot->GetName()
                << " subgr: " << uint32(subGroup + 1) << "\n";
        }

        for (uint8 i = 0; i != MAX_RAID_SUBGROUPS; ++i)
            if (subBots[i] > 0)
                sstr << uint32(subBots[i]) << " bots in subgroup " << uint32(i + 1) << "\n";

        handler->SendSysMessage(sstr.str().c_str());
        delete[] subBots;
        return true;
    }

    static bool HandleNpcBotDebugMountCommand(ChatHandler* handler, Optional<uint32> mountId)
    {
        if (!mountId)
            return false;

        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage("No target selected");
            return true;
        }

        target->Mount(*mountId);
        return true;
    }

    static bool HandleNpcBotDebugSpellVisualCommand(ChatHandler* handler, Optional<uint32> kit)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        Unit* target = owner->GetSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage("No target selected");
            return true;
        }

        target->SendPlaySpellVisual(kit.value_or(0));
        return true;
    }

    static bool HandleNpcBotDumpLoadCommand(ChatHandler* handler, Optional<std::string> file_str, Optional<bool> forceKick)
    {
        bool force_kick = forceKick.value_or(false);
        if (!file_str || (!force_kick && sWorld->GetPlayerCount() > 0))
        {
            handler->SendSysMessage(".npcbot dump load");
            handler->SendSysMessage("从用'.npcbot dump write'命令创建的备份SQL文件导入NPCBots。");
            handler->SendSysMessage("Syntax: .npcbot dump load #file_name [#force_kick_all]");
            if (!force_kick && sWorld->GetPlayerCount() > 0)
                handler->SendSysMessage("确保导入前没有玩家在线。");
            handler->SetSentErrorMessage(true);
            return false;
        }

        sWorld->SetPlayerAmountLimit(0);
        if (force_kick)
            sWorld->KickAll();

        //omit file ext if needed
        if (file_str->find('.') == std::string::npos)
            *file_str += ".sql";

        switch (NPCBotsDump().Load(*file_str))
        {
            case BOT_DUMP_SUCCESS:
                handler->SendSysMessage("导入成功。");
                handler->SendSysMessage("现在服务器将被重新启动，以防止数据库损坏。");
                sWorld->ShutdownServ(4, SHUTDOWN_MASK_RESTART, 70);
                break;
            case BOT_DUMP_FAIL_FILE_NOT_EXIST:
                handler->PSendSysMessage("无法打开%s或文件不存在!", file_str->c_str());
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_FILE_CORRUPTED:
                handler->SendSysMessage("文件数据完整性检查失败!");
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_DATA_OCCUPIED:
                handler->PSendSysMessage("包含在%s中的表数据与现有的表项冲突!", file_str->c_str());
                handler->SetSentErrorMessage(true);
                return false;
            default:
                handler->SendSysMessage("错误!");
                handler->SetSentErrorMessage(true);
                return false;
        }

        return true;
    }

    static bool HandleNpcBotDumpWriteCommand(ChatHandler* handler, Optional<std::string> file_str)
    {
        if (!file_str)
        {
            handler->SendSysMessage(".npcbot dump write\n将已生成的NPCBots导出到一个SQL文件中\nSyntax: .npcbot dump write #file_name");
            handler->SetSentErrorMessage(true);
            return false;
        }

        //omit file ext if needed
        if (file_str->find('.') == std::string::npos)
            *file_str += ".sql";

        switch (NPCBotsDump().Write(*file_str))
        {
            case BOT_DUMP_SUCCESS:
                handler->SendSysMessage("导出成功");
                break;
            case BOT_DUMP_FAIL_FILE_ALREADY_EXISTS:
                handler->PSendSysMessage("文件 %s 已存在!", file_str->c_str());
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_CANT_WRITE_TO_FILE:
                handler->SendSysMessage("无法写入文件!");
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_INCOMPLETE:
                handler->SendSysMessage("导出未完成!");
                handler->SetSentErrorMessage(true);
                return false;
            default:
                handler->SendSysMessage("错误!");
                handler->SetSentErrorMessage(true);
                return false;
        }

        return true;
    }

    static bool HandleNpcBotOrderCastCommand(ChatHandler* handler, Optional<std::string> bot_name, Optional<std::string> spell_name, Optional<std::string_view> target_token)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot() || !bot_name || !spell_name)
        {
            handler->SendSysMessage(".npcbot order cast #bot_name #spell_underscored_name #[target_token]");
            handler->SendSysMessage("命令NPCBot立即施展一个法术");
            return true;
        }

        for (std::decay_t<decltype(*spell_name)>::size_type i = 0u; i < spell_name->size(); ++i)
            if ((*spell_name)[i] == '_')
                (*spell_name)[i] = ' ';

        for (std::decay_t<decltype(*bot_name)>::size_type i = 0u; i < bot_name->size(); ++i)
            if ((*bot_name)[i] == '_')
                (*bot_name)[i] = ' ';

        auto canBotUseSpell = [=](Creature const* tbot, uint32 bspell) {
            //we ignore GCD for now
            return bspell && (tbot->GetBotAI()->GetSpellCooldown(bspell) <= tbot->GetBotAI()->GetLastDiff());
        };

        uint32 base_spell = 0;
        Creature* bot = owner->GetBotMgr()->GetBotByName(*bot_name);
        if (bot)
        {
            if (!bot->IsInWorld())
            {
                handler->PSendSysMessage("NPCBot %s 不存在!", bot_name->c_str());
                return true;
            }
            if (!bot->IsAlive())
            {
                handler->PSendSysMessage("%s 已死亡!", bot->GetName().c_str());
                return true;
            }

            base_spell = bot->GetBotAI()->GetBaseSpell(*spell_name, handler->GetSessionDbcLocale());
            if (!base_spell)
            {
                handler->PSendSysMessage("%s没有名为'%s'的法术!", bot->GetName().c_str(), spell_name->c_str());
                return true;
            }
            if (!canBotUseSpell(bot, base_spell))
            {
                handler->PSendSysMessage("%s's %s 还未就绪!", bot->GetName().c_str(), sSpellMgr->GetSpellInfo(base_spell)->SpellName[handler->GetSessionDbcLocale()]);
                return true;
            }
        }
        else
        {
            auto class_name = *bot_name;
            //for (auto const c : class_name)
            //{
            //    if (!std::islower(c))
            //    {
            //        handler->SendSysMessage("Bot class name must be in lower case!");
            //        return true;
            //    }
            //}

            uint8 bot_class = BotMgr::BotClassByClassName(class_name);
            if (bot_class == BOT_CLASS_NONE)
            {
                handler->PSendSysMessage("未知NPCBot名字或职业 %s!", class_name.c_str());
                return true;
            }

            std::list<Creature*> cBots = owner->GetBotMgr()->GetAllBotsByClass(bot_class);

            if (cBots.empty())
            {
                handler->PSendSysMessage("没有找到职业为 %u 的NPCBot!", bot_class);
                return true;
            }

            for (Creature const* fbot : cBots)
            {
                base_spell = fbot->GetBotAI()->GetBaseSpell(*spell_name, handler->GetSessionDbcLocale());
                if (base_spell)
                    break;
            }

            if (!base_spell)
            {
                handler->PSendSysMessage("这%u个NPCBot都没有技能'%s'!", cBots.size(), spell_name->c_str());
                return true;
            }

            cBots.erase(std::remove_if(cBots.begin(), cBots.end(),
                [=](Creature const* tbot) {
                    if (tbot->GetBotAI()->GetOrdersCount() >= MAX_BOT_ORDERS_QUEUE_SIZE)
                        return true;
                    return !canBotUseSpell(tbot, base_spell);
                }),
                cBots.end());

            decltype(cBots) ccBots;
            for (decltype(cBots)::const_iterator it = cBots.begin(); it != cBots.end();)
            {
                if (!(*it)->GetCurrentSpell(CURRENT_CHANNELED_SPELL) && !(*it)->IsNonMeleeSpellCast(false, false, true, false, false))
                {
                    ccBots.push_back(*it);
                    it = cBots.erase(it);
                }
                else
                    ++it;
            }

            bot = ccBots.empty() ? nullptr : ccBots.size() == 1 ? ccBots.front() : Acore::Containers::SelectRandomContainerElement(ccBots);
            if (!bot)
                bot = cBots.empty() ? nullptr : cBots.size() == 1 ? cBots.front() : Acore::Containers::SelectRandomContainerElement(cBots);

            if (!bot)
            {
                handler->PSendSysMessage("这%u个NPCBot都还不能使用技能%s!", cBots.size(), spell_name->c_str());
                return true;
            }
        }

        ObjectGuid target_guid;
        if (!target_token || target_token == "bot" || target_token == "self" || target_token == "机器人" || target_token == "自己")
            target_guid = bot->GetGUID();
        else if (target_token == "me" || target_token == "master" || target_token == "我" || target_token == "主人")
            target_guid = owner->GetGUID();
        else if (target_token == "mypet" || target_token == "我的宠物")
            target_guid = owner->GetPetGUID();
        else if (target_token == "myvehicle" || target_token == "我的载具")
            target_guid = owner->GetVehicle() ? owner->GetVehicleBase()->GetGUID() : ObjectGuid::Empty;
        else if (target_token == "target" || target_token == "目标")
            target_guid = bot->GetTarget();
        else if (target_token == "mytarget" || target_token == "我的目标")
            target_guid = owner->GetTarget();
        else
        {
            handler->PSendSysMessage("无效的target_token '%s'!", *target_token);
            handler->SendSysMessage("可用的target_token:\n    '','bot','self', 'me','master', 'mypet', 'myvehicle', 'target', 'mytarget', '机器人', '自己', '我', '主人', '我的宠物', '我的载具', '目标', '我的目标'");
            return true;
        }

        Unit* target = target_guid ? ObjectAccessor::GetUnit(*owner, target_guid) : nullptr;
        if (!target || !bot->FindMap() || target->FindMap() != bot->FindMap())
        {
            handler->PSendSysMessage("无效的目标 '%s'!", target ? target->GetName().c_str() : "未知名字");
            return true;
        }

        bot_ai::BotOrder order(BOT_ORDER_SPELLCAST);
        order.params.spellCastParams.baseSpell = base_spell;
        order.params.spellCastParams.targetGuid = target_guid.GetRawValue();

        if (bot->GetBotAI()->AddOrder(std::move(order)))
        {
            if (DEBUG_BOT_ORDERS)
                handler->PSendSysMessage("Order given: %s: %s on %s", bot->GetName().c_str(),
                    sSpellMgr->GetSpellInfo(base_spell)->SpellName[handler->GetSessionDbcLocale()], target ? target->GetName().c_str() : "unknown");
        }
        else
        {
            if (DEBUG_BOT_ORDERS)
                handler->PSendSysMessage("Order failed: %s: %s on %s", bot->GetName().c_str(),
                    sSpellMgr->GetSpellInfo(base_spell)->SpellName[handler->GetSessionDbcLocale()], target ? target->GetName().c_str() : "unknown");
        }

        return true;
    }

    static bool HandleNpcBotVehicleEjectCommand(ChatHandler* handler)
    {
        Player const* owner = handler->GetSession()->GetPlayer();
        Unit const* target = handler->getSelectedUnit();

        bool hasBotsInVehicles = false;
        bool botsInSelVehicle = 0;
        BotMap const* bmap = nullptr;
        if (owner->HaveBot())
        {
            bmap = owner->GetBotMgr()->GetBotMap();
            for (BotMap::const_iterator ci = bmap->begin(); ci != bmap->end(); ++ci)
            {
                if (ci->second && ci->second->GetVehicle())
                {
                    if (!hasBotsInVehicles)
                        hasBotsInVehicles = true;
                    if (!botsInSelVehicle && target && target->IsVehicle() && target->GetVehicleKit()->GetSeatForPassenger(ci->second))
                        botsInSelVehicle = true;
                }
                if (hasBotsInVehicles && botsInSelVehicle)
                    break;
            }
        }

        if (bmap && hasBotsInVehicles)
        {
            for (BotMap::const_iterator ci = bmap->begin(); ci != bmap->end(); ++ci)
            {
                Creature* bot = ci->second;
                if (bot && bot->GetVehicle())
                {
                    bool doeject = false;
                    if (!botsInSelVehicle)
                        doeject = true;
                    else if (target)
                        if (/*VehicleSeatEntry const* seat = */target->GetVehicleKit()->GetSeatForPassenger(bot))
                            //if (seat->CanEnterOrExit())
                                doeject = true;

                    if (doeject)
                    {
                        bot->GetVehicle()->GetBase()->StopMoving();
                        //handler->PSendSysMessage("Removing %s from %s", bot->GetName().c_str(), bot->GetVehicle()->GetBase()->GetName().c_str());
                        bot->ExitVehicle();
                        //bot->BotStopMovement();
                    }
                }
            }
            return true;
        }

        handler->SendSysMessage(".npcbot eject");
        handler->SendSysMessage("移除所选载具上的NPCBot，如果没有选择载具，则移除任何载具上的所有NPCBot。");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotFollowDistanceCommand(ChatHandler* handler, Optional<int32> dist)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot() || !dist)
        {
            handler->SendSysMessage(".npcbot distance #[attack] #newdist");
            handler->SendSysMessage("设置NPCBot的跟随/攻击距离");
            return true;
        }

        uint8 newdist = uint8(std::min<int32>(std::max<int32>(*dist, 0), 100));
        owner->GetBotMgr()->SetBotFollowDist(newdist);

        handler->PSendSysMessage("NPCBot的跟随距离已设置为 %u", uint32(newdist));
        return true;
    }

    static bool HandleNpcBotAttackDistanceShortCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot distance attack short");
            handler->SendSysMessage("设置NPCBot的攻击距离");
            return true;
        }

        owner->GetBotMgr()->SetBotAttackRangeMode(BOT_ATTACK_RANGE_SHORT);

        handler->SendSysMessage("NPCBot的攻击距离已设置为 'short'");
        return true;
    }

    static bool HandleNpcBotAttackDistanceLongCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot distance attack long");
            handler->SendSysMessage("设置NPCBot的攻击距离");
            return true;
        }

        owner->GetBotMgr()->SetBotAttackRangeMode(BOT_ATTACK_RANGE_LONG);

        handler->SendSysMessage("NPCBot的攻击距离已设置为 'long'");
        return true;
    }

    static bool HandleNpcBotAttackDistanceExactCommand(ChatHandler* handler, Optional<int32> dist)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot() || !dist)
        {
            handler->SendSysMessage(".npcbot distance attack #newdist");
            handler->SendSysMessage("设置NPCBot的攻击距离");
            return true;
        }

        uint8 newdist = uint8(std::min<int32>(std::max<int32>(*dist, 0), 50));
        owner->GetBotMgr()->SetBotAttackRangeMode(BOT_ATTACK_RANGE_EXACT, newdist);

        handler->PSendSysMessage("NPCBot的攻击距离已设置为 %u", uint32(newdist));
        return true;
    }

    static bool HandleNpcBotHideCommand(ChatHandler* handler)
    {
        // Hiding/unhiding bots should be allowed only out of combat
        // Currenly bots can teleport to master in combat
        // This creates potential for some serious trolls
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot hide");
            handler->SendSysMessage("暂时隐藏你拥有的NPCBots");
            //handler->SendSysMessage("You have no bots!");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (!owner->IsAlive())
        {
            handler->GetSession()->SendNotification("你已死亡");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat())
        {
            handler->GetSession()->SendNotification(LANG_YOU_IN_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        owner->GetBotMgr()->SetBotsHidden(true);
        handler->SendSysMessage("NPCBots已隐藏");
        return true;
    }

    static bool HandleNpcBotUnhideCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot unhide | show");
            handler->SendSysMessage("取消隐藏你拥有的NPCBots");
            //handler->SendSysMessage("You have no bots!");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (!owner->IsAlive())
        {
            handler->GetSession()->SendNotification("你已死亡");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat() && (owner->IsPvP() || owner->IsFFAPvP()))
        {
            handler->GetSession()->SendNotification("在PvP战斗中你不能这样做");
            handler->SetSentErrorMessage(true);
            return false;
        }

        owner->GetBotMgr()->SetBotsHidden(false);
        handler->SendSysMessage("NPCBots已取消隐藏");
        return true;
    }

    static bool HandleNpcBotKillCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        ObjectGuid guid = owner->GetTarget();
        if (!guid || !owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot kill | suicide");
            handler->SendSysMessage("让你的NPCBots直接死亡。如果你选择自己，你的所有NPCBots都会死亡。");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (guid == owner->GetGUID())
        {
            owner->GetBotMgr()->KillAllBots();
            return true;
        }
        if (Creature* bot = owner->GetBotMgr()->GetBot(guid))
        {
            owner->GetBotMgr()->KillBot(bot);
            return true;
        }

        handler->SendSysMessage("你必须选择你的一个NPCBot或你自己");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotGoCommand(ChatHandler* handler, Optional<uint32> creatureId)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (!creatureId)
        {
            handler->SendSysMessage(".npcbot go #[ID]");
            handler->SendSysMessage("Teleports to npcbot's current location");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature const* bot = BotDataMgr::FindBot(*creatureId);
        if (!bot)
        {
            handler->PSendSysMessage("NpcBot %u is not found!", *creatureId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_APPEARING_AT, bot->GetName().c_str());

        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        else
            player->SaveRecallPosition(); // save only in non-flight case

        WorldLocation wloc = *bot;
        wloc.m_positionZ += 1.5f;

        player->TeleportTo(wloc, TELE_TO_GM_MODE);
        return true;
    }

    static bool HandleNpcBotSendToCommand(ChatHandler* handler, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto #names...");
            chandler->SendSysMessage("让被选中的NPCBots等待30秒，等待你的下一个目标法术，以指定传送位置。");
            chandler->SendSysMessage("最大距离为70码");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("你的下一个目标法术将把%u个NPCBots传送到位置...", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("你的下一个目标法术将把%s传送到位置...", name_or_count.get<std::string>().c_str());
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
            return return_syntax(handler);

        if (!names || names->empty())
        {
            Unit const* target = handler->getSelectedCreature();
            Creature const* bot = target ? owner->GetBotMgr()->GetBot(target->GetGUID()) : nullptr;
            if (bot && bot->IsAlive() && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_FULLSTOP))
            {
                bot->GetBotAI()->SetBotAwaitState(BOT_AWAIT_SEND);
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            for (decltype(name)::size_type i = 0u; i < name.size(); ++i)
                if (name[i] == '_')
                    name[i] = ' ';

            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive() && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_FULLSTOP))
            {
                ++count;
                bot->GetBotAI()->SetBotAwaitState(BOT_AWAIT_SEND);
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("无法传送%u个NPCBots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToLastCommand(ChatHandler* handler, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto last #names...");
            chandler->SendSysMessage("使被选中的/指定名字的NPCBots回到他们被发送的前一个位置。");
            chandler->SendSysMessage("这将取消当前的传送等待状态");
            chandler->SendSysMessage("最大距离为70码");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("传送%u 个NPCBots到前一个位置...", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("传送 %s 到前一个位置...", name_or_count.get<std::string>().c_str());
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
            return return_syntax(handler);

        if (!names || names->empty())
        {
            Unit const* target = handler->getSelectedCreature();
            Creature const* bot = target ? owner->GetBotMgr()->GetBot(target->GetGUID()) : nullptr;
            if (bot && bot->IsAlive() && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_FULLSTOP))
            {
                bot->GetBotAI()->MoveToLastSendPosition();
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            for (decltype(name)::size_type i = 0u; i < name.size(); ++i)
                if (name[i] == '_')
                    name[i] = ' ';

            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive() && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_FULLSTOP))
            {
                ++count;
                bot->GetBotAI()->MoveToLastSendPosition();
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("无法传送%u个NPCBots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToPointSetCommand(ChatHandler* handler, Optional<uint32> point_id, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto point set #number #names...");
            chandler->SendSysMessage("通过编号#number 将选定/给定名字的NPCBots的当前位置标记为传送点");
            chandler->PSendSysMessage("传送点编号必须在 1 ... %u 范围内", uint32(MAX_SEND_POINTS));
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [&](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("标记传送点 %u 给 %u 个NPCBots", *point_id, name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("标记传送点 %u 给 %s", *point_id, name_or_count.get<std::string>().c_str());
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!point_id || !*point_id || *point_id > MAX_SEND_POINTS || !owner->HaveBot())
            return return_syntax(handler);

        if (!names || names->empty())
        {
            Unit const* target = handler->getSelectedCreature();
            Creature const* bot = target ? owner->GetBotMgr()->GetBot(target->GetGUID()) : nullptr;
            if (bot && bot->IsAlive())
            {
                bot->GetBotAI()->MarkSendPosition(*point_id - 1);
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            for (decltype(name)::size_type i = 0u; i < name.size(); ++i)
                if (name[i] == '_')
                    name[i] = ' ';

            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive())
            {
                ++count;
                bot->GetBotAI()->MarkSendPosition(*point_id - 1);
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("无法为任何 %u 个NPCBots标记传送点！", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToPointCommand(ChatHandler* handler, Optional<uint32> point_id, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto point #number #names...");
            chandler->SendSysMessage("使选定/给定名字的NPCBots移动到先前由#number 设置的点");
            chandler->SendSysMessage("这将取消当前传送等待状态");
            chandler->SendSysMessage("最大距离为 70 码");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [&](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("移动 %u 个NPCBots到传送点 %u...", name_or_count.get<uint32>(), *point_id);
            else
                chandler->PSendSysMessage("移动 %s 到传送点 %u...", name_or_count.get<std::string>().c_str(), *point_id);
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!point_id || !*point_id || *point_id > MAX_SEND_POINTS || !owner->HaveBot())
            return return_syntax(handler);

        if (!names || names->empty())
        {
            Unit const* target = handler->getSelectedCreature();
            Creature const* bot = target ? owner->GetBotMgr()->GetBot(target->GetGUID()) : nullptr;
            if (bot && bot->IsAlive() && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_FULLSTOP))
            {
                bot->GetBotAI()->MoveToSendPosition(*point_id - 1);
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            for (decltype(name)::size_type i = 0u; i < name.size(); ++i)
                if (name[i] == '_')
                    name[i] = ' ';

            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive() && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_FULLSTOP))
            {
                ++count;
                bot->GetBotAI()->MoveToSendPosition(*point_id - 1);
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("无法移动 %u 个NPCBots", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotRecallCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        ObjectGuid guid = owner->GetTarget();
        if (!guid || !owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot recall");
            handler->SendSysMessage("强制NPCBots直接移动到你身边。选择一个你想移动的NPCBot或者选择你自己来移动所有NPCBots");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat())
        {
            handler->GetSession()->SendNotification(LANG_YOU_IN_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (guid == owner->GetGUID())
        {
            owner->GetBotMgr()->RecallAllBots();
            return true;
        }
        if (Creature* bot = owner->GetBotMgr()->GetBot(guid))
        {
            owner->GetBotMgr()->RecallBot(bot);
            return true;
        }

        handler->SendSysMessage("你必须选择你的一个NPCBot或你自己");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotRecallSpawnsCommand(ChatHandler* handler)
    {
        Player const* owner = handler->GetSession()->GetPlayer();

        std::vector<ObjectGuid> botvec;
        BotDataMgr::GetNPCBotGuidsByOwner(botvec, owner->GetGUID());
        if (owner->HaveBot())
            botvec.erase(std::remove_if(botvec.begin(), botvec.end(), [=](ObjectGuid botguid) { return owner->GetBotMgr()->GetBot(botguid); }), botvec.end());

        uint32 recalled_count = 0;
        for (ObjectGuid botguid : botvec)
        {
            if (Creature const* bot = BotDataMgr::FindBot(botguid.GetEntry()))
            {
                bot->GetBotAI()->ResetBotAI(BOTAI_RESET_FORCERECALL);
                ++recalled_count;
            }
        }

        if (recalled_count == 0)
        {
            handler->SendSysMessage(".npcbot recall spawns");
            handler->SendSysMessage("Forces all your owned inactive npcbots to teleport to their spawn locations immediatelly");
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandleNpcBotRecallTeleportCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot recall teleport");
            handler->SendSysMessage("强制NPCBots传送到你身边。");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (!owner->IsAlive())
        {
            handler->GetSession()->SendNotification("你已死亡");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat() && (owner->IsPvP() || owner->IsFFAPvP()))
        {
            handler->GetSession()->SendNotification("在PvP战斗中你不能这样做");
            handler->SetSentErrorMessage(true);
            return false;
        }

        owner->GetBotMgr()->RecallAllBots(true);
        return true;
    }

    static bool HandleNpcBotToggleFlagsCommand(ChatHandler* handler, Optional<uint32> flag)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* unit = chr->GetSelectedUnit();
        if (!unit || unit->GetTypeId() != TYPEID_UNIT || !flag)
        {
            handler->SendSysMessage(".npcbot toggle flags #flag");
            handler->SendSysMessage("这是一个调试命令");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 setFlags = 0;
        switch (*flag)
        {
            case 6:
                setFlags = UNIT_FLAG_UNK_6;
                break;
            case 14:
                setFlags = UNIT_FLAG_CANNOT_SWIM;
                break;
            case 15:
                setFlags = UNIT_FLAG_SWIMMING;
                break;
            case 16:
                setFlags = UNIT_FLAG_NON_ATTACKABLE_2;
                break;
            default:
                break;
        }

        if (!setFlags)
            return false;

        handler->PSendSysMessage("Toggling flag %u on %s", setFlags, unit->GetName().c_str());
        unit->ToggleFlag(UNIT_FIELD_FLAGS, setFlags);
        return true;
    }

    static bool HandleNpcBotSetFactionCommand(ChatHandler* handler, Optional<std::string> factionStr)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot || !factionStr)
        {
            handler->SendSysMessage(".npcbot set faction #faction");
            handler->SendSysMessage("为选定的NPCBot设置阵营（保存在数据库中）");
            handler->SendSysMessage("使用'a'、'h'、'm'或'f'作为参数，将阵营设置为联盟、部落、怪物（对所有人都有敌意）或朋友（对所有人都友好）。");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot() || !bot->IsFreeBot())
        {
            handler->SendSysMessage("你必须选择没有被雇佣的NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 factionId = 0;

        if ((*factionStr)[0] == 'a')
            factionId = 1802; //Alliance
        else if ((*factionStr)[0] == 'h')
            factionId = 1801; //Horde
        else if ((*factionStr)[0] == 'm')
            factionId = 14; //Monsters
        else if ((*factionStr)[0] == 'f')
            factionId = 35; //Friendly to all

        if (!factionId)
        {
            char* pfactionid = handler->extractKeyFromLink((char*)factionStr->c_str(), "Hfaction");
            factionId = atoi(pfactionid);
        }

        if (!sFactionTemplateStore.LookupEntry(factionId))
        {
            handler->PSendSysMessage(LANG_WRONG_FACTION, factionId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_FACTION, &factionId);
        bot->GetBotAI()->ReInitFaction();

        handler->PSendSysMessage("%s的阵营设置为%u", bot->GetName().c_str(), factionId);
        return true;
    }

    static bool HandleNpcBotSetOwnerCommand(ChatHandler* handler, Optional<std::string> charVal)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot || !charVal)
        {
            handler->SendSysMessage(".npcbot set owner #guid | #name");
            handler->SendSysMessage("使用GUID或名字将选定的NPCBot与新的玩家所有者绑定，并更新数据库中的所有者。");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot() || bot->GetBotAI()->IsWanderer())
        {
            handler->SendSysMessage("你必须选择一个空闲的NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (bot->GetBotAI()->GetBotOwnerGuid())
        {
            handler->SendSysMessage("这个NPCBot已经由主人了");
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* characterName_str = strtok((char*)charVal->c_str(), " ");
        if (!characterName_str)
            return false;

        std::string characterName = characterName_str;
        uint32 guidlow = (uint32)atoi(characterName_str);

        bool found = true;
        if (guidlow)
            found = sCharacterCache->GetCharacterNameByGuid(ObjectGuid(HighGuid::Player, 0, guidlow), characterName);
        else
            guidlow = sCharacterCache->GetCharacterGuidByName(characterName).GetCounter();

        if (!guidlow || !found)
        {
            handler->SendSysMessage("未找到玩家");
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &guidlow);
        bot->GetBotAI()->ReinitOwner();
        //bot->GetBotAI()->Reset();

        handler->PSendSysMessage("%s的新主人是%s (guidlow: %u)", bot->GetName().c_str(), characterName.c_str(), guidlow);
        return true;
    }

    static bool HandleNpcBotSetSpecCommand(ChatHandler* handler, Optional<uint8> spec)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot || !spec)
        {
            handler->SendSysMessage(".npcbot set spec #specnumber");
            handler->SendSysMessage("改变所选NPCBot的天赋参数");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot())
        {
            handler->SendSysMessage("你必须选择一个NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!bot_ai::IsValidSpecForClass(bot->GetBotClass(), *spec))
        {
            handler->PSendSysMessage("%s 对于职业 %u 是无效的!",
                bot_ai::LocalizedNpcText(chr, bot_ai::TextForSpec(*spec)), uint32(bot->GetBotClass()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        bot->GetBotAI()->SetSpec(*spec);

        handler->PSendSysMessage("%s的新天赋参数是%u", bot->GetName().c_str(), uint32(*spec));
        return true;
    }

    static bool HandleNpcBotLookupCommand(ChatHandler* handler, Optional<uint8> botclass, Optional <bool> unspawned, Optional<uint8> teamid)
    {
        //this is just a modified '.lookup creature' command
        if (!botclass)
        {
            handler->SendSysMessage(".npcbot lookup #class #[not_spawned_only]");
            handler->SendSysMessage("按#class（职业ID）查找NpcBots，并返回所有匹配的生物ID。");
            handler->SendSysMessage("如果#not_spawned_only（仅未生成）设置为1，则只显示世界上不存在的NpcBots。");
            handler->SendSysMessage("如果提供#team_id, 则会按阵营筛选: 联盟 = 0, 部落 = 1, 中立 = 2");
            handler->PSendSysMessage("战士 = %u", uint32(BOT_CLASS_WARRIOR));
            handler->PSendSysMessage("圣骑士 = %u", uint32(BOT_CLASS_PALADIN));
            handler->PSendSysMessage("猎人 = %u", uint32(BOT_CLASS_HUNTER));
            handler->PSendSysMessage("潜行者 = %u", uint32(BOT_CLASS_ROGUE));
            handler->PSendSysMessage("牧师 = %u", uint32(BOT_CLASS_PRIEST));
            handler->PSendSysMessage("死亡骑士 = %u", uint32(BOT_CLASS_DEATH_KNIGHT));
            handler->PSendSysMessage("萨满祭司 = %u", uint32(BOT_CLASS_SHAMAN));
            handler->PSendSysMessage("法师 = %u", uint32(BOT_CLASS_MAGE));
            handler->PSendSysMessage("术士 = %u", uint32(BOT_CLASS_WARLOCK));
            handler->PSendSysMessage("德鲁伊 = %u", uint32(BOT_CLASS_DRUID));
            handler->PSendSysMessage("剑圣 = %u", uint32(BOT_CLASS_BM));
            handler->PSendSysMessage("毁灭者 = %u", uint32(BOT_CLASS_SPHYNX));
            handler->PSendSysMessage("大法师 = %u", uint32(BOT_CLASS_ARCHMAGE));
            handler->PSendSysMessage("恐惧魔王 = %u", uint32(BOT_CLASS_DREADLORD));
            handler->PSendSysMessage("破法者 = %u", uint32(BOT_CLASS_SPELLBREAKER));
            handler->PSendSysMessage("黑暗游侠 = %u", uint32(BOT_CLASS_DARK_RANGER));
            handler->PSendSysMessage("死灵法师 = %u", uint32(BOT_CLASS_NECROMANCER));
            handler->PSendSysMessage("海妖 = %u", uint32(BOT_CLASS_SEA_WITCH));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (botclass == BOT_CLASS_NONE || botclass >= BOT_CLASS_END)
        {
            handler->PSendSysMessage("未知职业ID %u", uint32(*botclass));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (teamid && *teamid > uint8(TEAM_NEUTRAL))
        {
            handler->PSendSysMessage("未知阵营 %u", uint32(*teamid));
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage("按职业ID %u 查找NPCBots...", uint32(*botclass));

        uint8 localeIndex = handler->GetSessionDbLocaleIndex();
        CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
        typedef std::vector<BotInfo> BotList;
        BotList botlist;
        for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
        {
            uint32 id = itr->second.Entry;

            if (id == BOT_ENTRY_MIRROR_IMAGE_BM)
                continue;
            //Blademaster disabled
            if (botclass == BOT_CLASS_BM)
                continue;

            NpcBotExtras const* _botExtras = BotDataMgr::SelectNpcBotExtras(id);
            if (!_botExtras || _botExtras->bclass != botclass)
                continue;

            if (unspawned && *unspawned && BotDataMgr::SelectNpcBotData(id))
                continue;

            uint8 race = _botExtras->race;

            if (teamid)
            {
                ChrRacesEntry const* rentry = sChrRacesStore.LookupEntry(race);
                uint32 faction = rentry ? rentry->FactionID : 14;
                TeamId team = BotDataMgr::GetTeamIdForFaction(faction);

                if (*teamid != uint8(team))
                    continue;
            }

            if (CreatureLocale const* creatureLocale = sObjectMgr->GetCreatureLocale(id))
            {
                if (creatureLocale->Name.size() > localeIndex && !creatureLocale->Name[localeIndex].empty())
                {
                    botlist.emplace_back(id, std::string(creatureLocale->Name[localeIndex]), race);
                    continue;
                }
            }

            std::string name = itr->second.Name;
            if (name.empty())
                continue;

            botlist.emplace_back(id, std::move(name), race);
        }

        if (botlist.empty())
        {
            handler->SendSysMessage(LANG_COMMAND_NOCREATUREFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::sort(botlist.begin(), botlist.end(), [](BotInfo const& bi1, BotInfo const& bi2) { return bi1.id < bi2.id; });

        for (BotList::const_iterator itr = botlist.begin(); itr != botlist.end(); ++itr)
        {
            uint8 race = itr->race;
            if (race >= MAX_RACES)
                race = RACE_NONE;

            std::string_view raceName;
            switch (race)
            {
                case RACE_HUMAN:        raceName = "人类";       break;
                case RACE_ORC:          raceName = "兽人";       break;
                case RACE_DWARF:        raceName = "矮人";       break;
                case RACE_NIGHTELF:     raceName = "暗夜精灵";   break;
                case RACE_UNDEAD_PLAYER:raceName = "被遗忘者";   break;
                case RACE_TAUREN:       raceName = "牛头人";     break;
                case RACE_GNOME:        raceName = "侏儒";       break;
                case RACE_TROLL:        raceName = "巨魔";       break;
                case RACE_BLOODELF:     raceName = "血精灵";     break;
                case RACE_DRAENEI:      raceName = "德莱尼";     break;
                case RACE_NONE:         raceName = "没有种族";   break;
                default:                raceName = "未知种族";   break;
            }

            handler->PSendSysMessage("%d - |cffffffff|Hcreature_entry:%d|h[%s]|h|r %s", itr->id, itr->id, itr->name.c_str(), raceName);
        }

        return true;
    }

    static bool HandleNpcBotDeleteCommand(ChatHandler* handler)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot)
        {
            handler->SendSysMessage(".npcbot delete");
            handler->SendSysMessage("从世界和数据库中删除选定的NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot())
        {
            handler->SendSysMessage("没有选定的NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (bot->GetBotAI()->IsWanderer())
        {
            BotDataMgr::DespawnWandererBot(bot->GetEntry());
            handler->PSendSysMessage("Wandering bot %u '%s' successfully deleted", bot->GetEntry(), bot->GetName().c_str());
            return true;
        }

        Player const* botowner = bot->GetBotOwner()->ToPlayer();

        ObjectGuid receiver =
            botowner ? botowner->GetGUID() :
            bot->GetBotAI()->GetBotOwnerGuid() != 0 ? ObjectGuid(HighGuid::Player, 0, bot->GetBotAI()->GetBotOwnerGuid()) :
            chr->GetGUID();
        if (!bot->GetBotAI()->UnEquipAll(receiver))
        {
            handler->PSendSysMessage("%s无法解除某些装备。请在删除NPCBot之前删除装备!", bot->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (botowner)
            botowner->GetBotMgr()->RemoveBot(bot->GetGUID(), BOT_REMOVE_DISMISS);

        bot->CombatStop();
        bot->GetBotAI()->Reset();
        bot->GetBotAI()->canUpdate = false;
        bot->DeleteFromDB();
        bot->AddObjectToRemoveList();

        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_ERASE);

        handler->PSendSysMessage("NPCBot %s 删除成功", bot->GetName().c_str());
        return true;
    }

    static bool HandleNpcBotDeleteByIdCommand(ChatHandler* handler, Optional<uint32> creature_id)
    {
        if (!creature_id)
        {
            handler->SendSysMessage(".npcbot delete id");
            handler->SendSysMessage("使用生物ID从世界和DB中删除NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature const* bot = BotDataMgr::FindBot(*creature_id);
        if (!bot)
        {
            handler->PSendSysMessage("NPCBot %u 不存在!", *creature_id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (bot->GetBotAI()->IsWanderer())
        {
            handler->SendSysMessage("Cannot delete wanderer npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* chr = !handler->IsConsole() ? handler->GetSession()->GetPlayer() : nullptr;
        Player const* botowner = bot->GetBotOwner()->ToPlayer();

        if (bot->GetBotAI()->HasRealEquipment())
        {
            ObjectGuid receiver =
                botowner ? botowner->GetGUID() :
                bot->GetBotAI()->GetBotOwnerGuid() != 0 ? ObjectGuid(HighGuid::Player, 0, bot->GetBotAI()->GetBotOwnerGuid()) :
                chr ? chr->GetGUID() : ObjectGuid::Empty;
            if (receiver == ObjectGuid::Empty)
            {
                handler->PSendSysMessage("无法从控制台删除NPCBot %s：有装备，但没有玩家可以归还! 只能在游戏中删除这个NPCBot。", bot->GetName().c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
            if (!bot->GetBotAI()->UnEquipAll(receiver))
            {
                handler->PSendSysMessage("%s无法解除某些装备。请在删除NPCBot之前删除装备!", bot->GetName().c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        if (botowner)
            botowner->GetBotMgr()->RemoveBot(bot->GetGUID(), BOT_REMOVE_DISMISS);

        const_cast<Creature*>(bot)->CombatStop();
        bot->GetBotAI()->Reset();
        bot->GetBotAI()->canUpdate = false;
        const_cast<Creature*>(bot)->DeleteFromDB();
        const_cast<Creature*>(bot)->AddObjectToRemoveList();

        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_ERASE);

        handler->PSendSysMessage("NPCBot %s 删除成功", bot->GetName().c_str());
        return true;
    }

    static bool HandleNpcBotDeleteFreeCommand(ChatHandler* handler)
    {
        uint32 count = 0;
        for (uint32 creature_id : BotDataMgr::GetExistingNPCBotIds())
            if (NpcBotData const* botData = BotDataMgr::SelectNpcBotData(creature_id))
                if (botData->owner == 0)
                    if (HandleNpcBotDeleteByIdCommand(handler, creature_id))
                        ++count;

        handler->PSendSysMessage("%u 个自由NPCBots已删除", count);
        return true;
    }

    static bool HandleNpcBotMoveCommand(ChatHandler* handler, Optional<std::string> creVal)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creature = handler->getSelectedCreature();

        if ((!creature && !creVal) || player->GetMap()->Instanceable())
        {
            handler->SendSysMessage(".npcbot move");
            handler->SendSysMessage("将NPCBot移动到你的位置。仅限世界地图");
            handler->SendSysMessage("Syntax: .npcbot move [#ID]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* charID = creVal ? handler->extractKeyFromLink((char*)creVal->c_str(), "Hcreature_entry") : nullptr;
        if (!charID && !creature)
            return false;

        uint32 id = charID ? atoi(charID) : creature->GetEntry();

        CreatureTemplate const* creInfo = sObjectMgr->GetCreatureTemplate(id);
        if (!creInfo)
        {
            handler->PSendSysMessage("生物ID %u 不存在!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!(creInfo->flags_extra & CREATURE_FLAG_EXTRA_NPCBOT))
        {
            handler->PSendSysMessage("生物ID %u 不是NPCBot!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!BotDataMgr::SelectNpcBotData(id))
        {
            handler->PSendSysMessage("NPCBot %u 没有被生成!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature const* bot = BotDataMgr::FindBot(id);
        ASSERT(bot);

        uint32 lowguid = bot->GetSpawnId();

        CreatureData const* data = sObjectMgr->GetCreatureData(lowguid);
        if (!data)
        {
            handler->PSendSysMessage(LANG_COMMAND_CREATGUIDNOTFOUND, lowguid);
            handler->SetSentErrorMessage(true);
            return false;
        }

        CreatureData* cdata = const_cast<CreatureData*>(data);
        cdata->posX = player->GetPositionX();
        cdata->posY = player->GetPositionY();
        cdata->posZ = player->GetPositionZ();
        cdata->orientation = player->GetOrientation();
        cdata->mapid = player->GetMapId();

        WorldDatabase.Execute(
            "UPDATE creature SET position_x = {}, position_y = {}, position_z = {}, orientation = {}, map = {} WHERE guid = {}",
            cdata->posX, cdata->posY, cdata->posZ, cdata->orientation, uint32(cdata->mapid), lowguid);

        if (bot->GetBotAI()->IAmFree() && bot->IsInWorld() && !bot->IsInCombat() && bot->IsAlive())
            BotMgr::TeleportBot(const_cast<Creature*>(bot), player->GetMap(), player);

        handler->PSendSysMessage("NPCBot %u (guid %u) 已移动", id, lowguid);
        return true;
    }

    static bool HandleNpcBotCreateNewCommand(ChatHandler* handler, Optional<std::string> name, Optional<uint8> bclass, Optional<uint8> race, Optional<uint8> gender, Optional<uint8> skin, Optional<uint8> face, Optional<uint8> hairstyle, Optional<uint8> haircolor, Optional<uint8> features, Optional<uint8> soundset)
    {
        static auto const ret_err = [](ChatHandler* handler, bool report_ranges = false) {
            if (report_ranges)
                ReportVisualRanges(handler);
            else
            {
                handler->SendSysMessage(".npcbot createnew");
                handler->SendSysMessage("创建一个新的NPCBot生物条目");
                handler->SendSysMessage("Syntax: .npcbot createnew #name #class ##race ##gender ##skin ##face ##hairstyle ##haircolor ##features ##[sound_variant = {{1,2,3}}]");
                handler->SendSysMessage("如果是不能改变外观的职业，所有的额外参数必须省略。");
                handler->SendSysMessage("使用'.npcbot createnew ranges'来显示所有种族的视觉约束。");
            }
            handler->SetSentErrorMessage(true);
            return false;
        };
        static auto const ret_err_invalid_arg = [](ChatHandler* handler, char const* argname, Optional<uint8> argval = {}) {
            handler->PSendSysMessage("无效的 %s%s!", argname, argval ?  (" " + std::to_string(*argval)).c_str() : "");
            handler->SetSentErrorMessage(true);
            return false;
        };
        static auto const ret_err_invalid_args_for = [](ChatHandler* handler, char const* argname1, char const* argname2) {
            handler->PSendSysMessage("无效的参数对于 %s '%s'!", argname1, argname2);
            handler->SetSentErrorMessage(true);
            return false;
        };

        if (!bclass || !name)
            return ret_err(handler, name && *name == "ranges");

        for (std::decay_t<decltype(*name)>::size_type i = 0u; i < name->size(); ++i)
            if ((*name)[i] == '_')
                (*name)[i] = ' ';

        bool const can_change_appearance = (*bclass < BOT_CLASS_EX_START || *bclass == BOT_CLASS_ARCHMAGE);

        if (can_change_appearance && (!race || !gender || !skin || !face || !hairstyle || !haircolor || !features))
            return ret_err(handler);
        if (!can_change_appearance && (race || gender || skin || face || hairstyle || haircolor || features))
            return ret_err(handler);
        if (soundset && (*soundset < 1 || *soundset > SOUND_SETS_COUNT))
            return ret_err(handler);

        if (*bclass >= BOT_CLASS_END || (*bclass < BOT_CLASS_EX_START && !((1u << (*bclass - 1)) & CLASSMASK_ALL_PLAYABLE)))
            return ret_err_invalid_arg(handler, "class", bclass);

        std::string namestr;
        normalizePlayerName(namestr);
        if (!consoleToUtf8(*name, namestr))
            return ret_err_invalid_arg(handler, "name");
        namestr[0] = std::toupper(namestr[0]);

        if (race && !((1u << (*race - 1)) & RACEMASK_ALL_PLAYABLE))
            return ret_err_invalid_arg(handler, "race", race);

        if (can_change_appearance && *gender != GENDER_MALE && *gender != GENDER_FEMALE)
            return ret_err_invalid_arg(handler, "gender", gender);

        // class / race combination check
        if ((*bclass < BOT_CLASS_EX_START && !sObjectMgr->GetPlayerInfo(*race, *bclass)) ||
            (*bclass == BOT_CLASS_ARCHMAGE && *race != RACE_HUMAN))
            return ret_err_invalid_args_for(handler, "class", get_class_name(*bclass));

        if (can_change_appearance && !IsValidVisual(*race, *gender, *skin, *face, *hairstyle, *haircolor, *features))
            return ret_err_invalid_args_for(handler, "race", get_race_name(*race));

        //here we force races for custom classes
        switch (*bclass)
        {
            case BOT_CLASS_BM:
            case BOT_CLASS_SPHYNX:
            case BOT_CLASS_DREADLORD:
            case BOT_CLASS_SPELLBREAKER:
                race = 15; //RACE_SKELETON
                break;
            case BOT_CLASS_NECROMANCER:
                race = RACE_HUMAN;
                break;
            case BOT_CLASS_DARK_RANGER:
                race = RACE_BLOODELF;
                break;
            case BOT_CLASS_SEA_WITCH:
                race = 13; //RACE_NAGA
                break;
        }

        //get normalized modelID
        uint32 modelId = can_change_appearance ? SoundSetModelsArray[RaceToRaceOffset[*race]][*gender][soundset ? *soundset - 1 : urand(0u, 2u)] : 0;

        uint32 newentry = 0;
        QueryResult creres = WorldDatabase.Query("SELECT entry FROM creature_template WHERE entry = {}", BOT_ENTRY_CREATE_BEGIN);
        if (!creres)
            newentry = BOT_ENTRY_CREATE_BEGIN;
        else
        {
            creres = WorldDatabase.Query("SELECT MIN(entry) FROM creature_template WHERE entry >= {} AND entry IN (SELECT entry FROM creature_template) AND entry+1 NOT IN (SELECT entry FROM creature_template)", BOT_ENTRY_CREATE_BEGIN);
            ASSERT(creres);
            Field* field = creres->Fetch();
            newentry = field[0].Get<uint32>() + 1;
        }

        WorldDatabaseTransaction trans = WorldDatabase.BeginTransaction();
        trans->Append("DROP TEMPORARY TABLE IF EXISTS creature_template_temp_npcbot_create");
        trans->Append("CREATE TEMPORARY TABLE creature_template_temp_npcbot_create ENGINE=MEMORY SELECT * FROM creature_template WHERE entry = (SELECT entry FROM creature_template_npcbot_extras WHERE class = {} LIMIT 1)", uint32(*bclass));
        trans->Append("UPDATE creature_template_temp_npcbot_create SET entry = {}, name = \"{}\"", newentry, namestr.c_str());
        if (modelId)
            trans->Append("UPDATE creature_template_temp_npcbot_create SET modelid1 = {}", modelId);
        trans->Append("INSERT INTO creature_template SELECT * FROM creature_template_temp_npcbot_create");
        trans->Append("DROP TEMPORARY TABLE creature_template_temp_npcbot_create");
        trans->Append("REPLACE INTO creature_template_npcbot_extras VALUES ({}, {}, {})", newentry, uint32(*bclass), uint32(*race));
        trans->Append("REPLACE INTO creature_equip_template SELECT {}, 1, ids.itemID1, ids.itemID2, ids.itemID3, -1 FROM (SELECT itemID1, itemID2, itemID3 FROM creature_equip_template WHERE CreatureID = (SELECT entry FROM creature_template_npcbot_extras WHERE class = {} LIMIT 1)) ids", newentry, uint32(*bclass));
        if (can_change_appearance)
            trans->Append("REPLACE INTO creature_template_npcbot_appearance VALUES ({}, \"{}\", {}, {}, {}, {}, {}, {})",
                newentry, namestr.c_str(), uint32(*gender), uint32(*skin), uint32(*face), uint32(*hairstyle), uint32(*haircolor), uint32(*features));
        WorldDatabase.DirectCommitTransaction(trans);

        handler->PSendSysMessage("New NPCBot %s (class %u) is created with entry %u and will be available for spawning after server restart.", namestr.c_str(), uint32(*bclass), newentry);
        return true;
    }

    static bool HandleNpcBotSpawnCommand(ChatHandler* handler, Optional<std::string> creVal)
    {
        if (!creVal)
        {
            handler->SendSysMessage(".npcbot spawn");
            handler->SendSysMessage("在世界中生成新的NPCBot. 你可以使用生物ID或者shift单击生物链接。");
            handler->SendSysMessage("Syntax: .npcbot spawn #entry");
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* charID = handler->extractKeyFromLink((char*)creVal->c_str(), "Hcreature_entry");
        if (!charID)
            return false;

        uint32 id = uint32(atoi(charID));

        CreatureTemplate const* creInfo = sObjectMgr->GetCreatureTemplate(id);

        if (!creInfo)
        {
            handler->PSendSysMessage("生物 %u 不存在!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!(creInfo->flags_extra & CREATURE_FLAG_EXTRA_NPCBOT))
        {
            handler->PSendSysMessage("生物 %u 不是NPCBot!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (BotDataMgr::SelectNpcBotData(id))
        {
            handler->PSendSysMessage("NPCBot %u 已存在于 `characters_npcbot` 表中!", id);
            handler->SendSysMessage("如果你想把这个NPCBot移动到一个新的位置，使用'.npcbot move'命令");
            handler->SetSentErrorMessage(true);
            return false;
        }

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_CREATURE_BY_ID);
        //"SELECT guid FROM creature WHERE id1 = ? OR id2 = ? OR id3 = ?", CONNECTION_SYNCH
        //stmt->setUInt32(0, id);
        stmt->SetArguments(id, id, id);
        PreparedQueryResult res2 = WorldDatabase.Query(stmt);
        if (res2)
        {
            handler->PSendSysMessage("NPCBot %u 已存在于 `creature` 表中!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* chr = handler->GetSession()->GetPlayer();

        if (/*Transport* trans = */chr->GetTransport())
        {
            handler->SendSysMessage("无法在载具上生成NPCBots!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        //float x = chr->GetPositionX();
        //float y = chr->GetPositionY();
        //float z = chr->GetPositionZ();
        //float o = chr->GetOrientation();
        Map* map = chr->GetMap();

        if (map->Instanceable())
        {
            handler->SendSysMessage("无法在副本上生成NPCBots!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* creature = new Creature();
        if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, chr->GetPhaseMaskForSpawn(), id, 0, chr->GetPositionX(), chr->GetPositionY(), chr->GetPositionZ(), chr->GetOrientation()))
        {
            delete creature;
            handler->SendSysMessage("生物没有被创造!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        NpcBotExtras const* _botExtras = BotDataMgr::SelectNpcBotExtras(id);
        if (!_botExtras)
        {
            delete creature;
            handler->PSendSysMessage("没有找到NPCBot %u的职业/种族数据!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotDataMgr::AddNpcBotData(id, bot_ai::DefaultRolesForClass(_botExtras->bclass), bot_ai::DefaultSpecForClass(_botExtras->bclass), creature->GetCreatureTemplate()->faction);

        creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), chr->GetPhaseMaskForSpawn());

        uint32 db_guid = creature->GetSpawnId();
        if (!creature->LoadBotCreatureFromDB(db_guid, map))
        {
            delete creature;
            handler->SendSysMessage("无法从数据库加载NPCBot!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));

        handler->SendSysMessage("NPCBot生成成功");
        return true;
    }

    static bool HandleNpcBotSpawnedCommand(ChatHandler* handler)
    {
        std::unique_lock<std::shared_mutex> lock(*BotDataMgr::GetLock());
        NpcBotRegistry const& all_bots = BotDataMgr::GetExistingNPCBots();
        std::stringstream ss;
        if (all_bots.empty())
            ss << "没找到已生成的NPCBots!";
        else
        {
            ss << "发现 " << uint32(all_bots.size()) << " 个NPCBots:";
            uint32 counter = 0;
            for (Creature const* bot : all_bots)
            {
                ++counter;

                std::string bot_color_str;
                std::string bot_class_str;
                GetBotClassNameAndColor(bot->GetBotClass(), bot_color_str, bot_class_str);

                AreaTableEntry const* zone = sAreaTableStore.LookupEntry(bot->GetBotAI()->GetLastZoneId() ? bot->GetBotAI()->GetLastZoneId() : bot->GetZoneId());
                std::string zone_name = zone ? zone->area_name[handler->GetSession() ? handler->GetSessionDbLocaleIndex() : 0] : "未知区域";

                ss << "\n" << counter << ") " << bot->GetEntry() << ": "
                    << bot->GetName() << " - |c" << bot_color_str << bot_class_str << "|r - "
                    << "等级 " << uint32(bot->GetLevel()) << " - \"" << zone_name << "\" - "
                    << (bot->IsFreeBot() ? (bot->GetBotAI()->GetBotOwnerGuid() ? "未激活 (已雇佣)" : "自由") : "已激活");
            }
        }

        handler->SendSysMessage(ss.str().c_str());
        return true;
    }

    static bool HandleNpcBotSpawnedFreeCommand(ChatHandler* handler)
    {
        std::unique_lock<std::shared_mutex> lock(*BotDataMgr::GetLock());
        NpcBotRegistry const& all_bots = BotDataMgr::GetExistingNPCBots();
        //using std::remove_if with sets requires c++20
        std::vector<NpcBotRegistry::value_type> free_bots;
        free_bots.reserve(all_bots.size());
        for (Creature const* bot : all_bots)
            if (BotDataMgr::SelectNpcBotData(bot->GetEntry())->owner == 0)
                free_bots.push_back(bot);
        std::stringstream ss;
        if (free_bots.empty())
            ss << "没找到自由的NPCBots!";
        else
        {
            ss << "发现 " << uint32(free_bots.size()) << " 个自由的NPCBots:";
            uint32 counter = 0;
            for (Creature const* bot : free_bots)
            {
                ++counter;

                std::string bot_color_str;
                std::string bot_class_str;
                GetBotClassNameAndColor(bot->GetBotClass(), bot_color_str, bot_class_str);

                AreaTableEntry const* zone = sAreaTableStore.LookupEntry(bot->GetBotAI()->GetLastZoneId() ? bot->GetBotAI()->GetLastZoneId() : bot->GetZoneId());
                std::string zone_name = zone ? zone->area_name[handler->GetSession() ? handler->GetSessionDbLocaleIndex() : 0] : "未知区域";

                ss << '\n' << counter << ") " << bot->GetEntry() << ": "
                    << bot->GetName() << " - |c" << bot_color_str << bot_class_str << "|r - "
                    << "等级 " << uint32(bot->GetLevel()) << " - \"" << zone_name << '"'
                    << (bot->GetBotAI()->HasRealEquipment() ? " |cff00ffff(有装备!)|r" : "");
            }
        }

        handler->SendSysMessage(ss.str().c_str());
        return true;
    }

    static bool HandleNpcBotInfoCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player->GetTarget())
        {
            handler->SendSysMessage(".npcbot info");
            handler->SendSysMessage("列出所选玩家拥有的每个等级的NPCBot的数量。你可以对自己和你的好友使用这个功能。");
            handler->SetSentErrorMessage(true);
            return false;
        }
        Player* master = player->GetSelectedPlayer();
        if (!master)
        {
            handler->SendSysMessage("未选择玩家");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (BotDataMgr::GetOwnedBotsCount(master->GetGUID()) == 0)
        {
            handler->PSendSysMessage("%s 没有NPCBots!", master->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::vector<ObjectGuid> guidvec;
        BotDataMgr::GetNPCBotGuidsByOwner(guidvec, master->GetGUID());
        BotMap const* map = master->GetBotMgr()->GetBotMap();
        guidvec.erase(std::remove_if(std::begin(guidvec), std::end(guidvec),
            [bmap = map](ObjectGuid guid) { return bmap->find(guid) != bmap->end(); }
        ), std::end(guidvec));

        handler->PSendSysMessage("列出 %s 的 NpcBots", master->GetName().c_str());
        handler->PSendSysMessage("拥有 NPCBots: %u(已激活: %u)", uint32(guidvec.size() + map->size()), uint32(map->size()));

        for (uint8 i = BOT_CLASS_WARRIOR; i != BOT_CLASS_END; ++i)
        {
            uint8 count = 0;
            uint8 alivecount = 0;
            for (BotMap::const_iterator itr = map->begin(); itr != map->end(); ++itr)
            {
                if (Creature* cre = itr->second)
                {
                    if (cre->GetBotClass() == i)
                    {
                        ++count;
                        if (cre->IsAlive())
                            ++alivecount;
                    }
                }
            }
            if (count == 0)
                continue;

            char const* bclass;
            switch (i)
            {
                case BOT_CLASS_WARRIOR:         bclass = "战士";             break;
                case BOT_CLASS_PALADIN:         bclass = "圣骑士";           break;
                case BOT_CLASS_MAGE:            bclass = "法师";             break;
                case BOT_CLASS_PRIEST:          bclass = "牧师";             break;
                case BOT_CLASS_WARLOCK:         bclass = "术士";             break;
                case BOT_CLASS_DRUID:           bclass = "德鲁伊";           break;
                case BOT_CLASS_DEATH_KNIGHT:    bclass = "死亡骑士";         break;
                case BOT_CLASS_ROGUE:           bclass = "潜行者";           break;
                case BOT_CLASS_SHAMAN:          bclass = "萨满祭司";         break;
                case BOT_CLASS_HUNTER:          bclass = "猎人";             break;
                case BOT_CLASS_BM:              bclass = "剑圣";             break;
                case BOT_CLASS_SPHYNX:          bclass = "毁灭者";           break;
                case BOT_CLASS_ARCHMAGE:        bclass = "大法师";           break;
                case BOT_CLASS_DREADLORD:       bclass = "恐惧魔王";         break;
                case BOT_CLASS_SPELLBREAKER:    bclass = "破法者";           break;
                case BOT_CLASS_DARK_RANGER:     bclass = "黑暗游侠";         break;
                case BOT_CLASS_NECROMANCER:     bclass = "死灵法师";         break;
                case BOT_CLASS_SEA_WITCH:       bclass = "海妖";             break;
                default:                        bclass = "未知职业";         break;
            }
            handler->PSendSysMessage("%s: %u (存活: %u)", bclass, count, alivecount);
        }

        if (guidvec.empty())
            return true;

        handler->PSendSysMessage("%u未绑定的NPCBots:", uint32(guidvec.size()));
        for (ObjectGuid guid : guidvec)
        {
            Creature const* bot = BotDataMgr::FindBot(guid.GetEntry());
            std::string ccolor, cname;
            GetBotClassNameAndColor(bot ? bot->GetBotClass() : uint8(BOT_CLASS_NONE), ccolor, cname);
            handler->PSendSysMessage("%s (%s)", bot ? bot->GetName().c_str() : "未知", "|c" + ccolor + cname + "|r");
        }

        return true;
    }

    static bool HandleNpcBotCommandStandstillCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command standstill");
            handler->SendSysMessage("迫使你的NPCBots停止所有行动，并保持静止状态");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        Unit* target = owner->GetSelectedUnit();
        if (target && owner->GetBotMgr()->GetBot(target->GetGUID()))
        {
            target->ToCreature()->GetBotAI()->SetBotCommandState(BOT_COMMAND_STAY);
            msg = target->GetName() + "的命令状态设置为'STAY'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_STAY);
            msg = "NPCBots的命令状态设置为'STAY'";
        }

        handler->SendSysMessage(msg.c_str());
        return true;
    }

    static bool HandleNpcBotCommandStopfullyCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command stopfully");
            handler->SendSysMessage("迫使你的NPCBots停止所有行动");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        Unit* target = owner->GetSelectedUnit();
        if (target && owner->GetBotMgr()->GetBot(target->GetGUID()))
        {
            target->ToCreature()->GetBotAI()->SetBotCommandState(BOT_COMMAND_FULLSTOP);
            msg = target->GetName() + "的命令状态设置为'FULLSTOP'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_FULLSTOP);
            msg = "NPCBots的命令状态设置为'FULLSTOP'";
        }

        handler->SendSysMessage(msg.c_str());
        return true;
    }

    static bool HandleNpcBotCommandFollowCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command follow");
            handler->SendSysMessage("如果停止，允许NPCBots再次跟随你");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        Unit* target = owner->GetSelectedUnit();
        if (target && owner->GetBotMgr()->GetBot(target->GetGUID()))
        {
            target->ToCreature()->GetBotAI()->SetBotCommandState(BOT_COMMAND_FOLLOW);
            msg = target->GetName() + "的命令状态设置为'FOLLOW'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_FOLLOW);
            msg = "NPCBots的命令状态设置为'FOLLOW'";
        }

        handler->SendSysMessage(msg.c_str());
        return true;
    }

    static bool HandleNpcBotCommandWalkCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command walk");
            handler->SendSysMessage("为你的NPCBots切换行走模式");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        bool isWalking = owner->GetBotMgr()->GetBotMap()->begin()->second->GetBotAI()->HasBotCommandState(BOT_COMMAND_WALK);
        if (!isWalking)
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_WALK);
            msg = "NPCBots的行走模式切换为'WALK'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandStateRemove(BOT_COMMAND_WALK);
            msg = "NPCBots的行走模式切换为'RUN'";
        }

        handler->SendSysMessage(msg.c_str());
        return true;
    }

    static bool HandleNpcBotCommandNoGossipCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command nogossip");
            handler->SendSysMessage("开关NPCBots的闲聊功能");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        bool isNoGossipEnabled = owner->GetBotMgr()->GetBotMap()->begin()->second->GetBotAI()->HasBotCommandState(BOT_COMMAND_NOGOSSIP);
        if (!isNoGossipEnabled)
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_NOGOSSIP);
            msg = "NPCBots的闲聊功能已关闭";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandStateRemove(BOT_COMMAND_NOGOSSIP);
            msg = "NPCBots的闲聊功能已打开";
        }

        handler->SendSysMessage(msg.c_str());
        return true;
    }

    static bool HandleNpcBotCommandReBindCommand(ChatHandler* handler, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage(".npcbot command rebind [#names...]");
            chandler->SendSysMessage("重新绑定选定的/指定名字的未绑定的NPCBot");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("成功重新绑定 %u 个NPCBots", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("成功重新绑定 %s", name_or_count.get<std::string>().c_str());
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot() && BotDataMgr::GetOwnedBotsCount(owner->GetGUID()) == 0)
            return return_syntax(handler);

        BotMgr* mgr = owner->GetBotMgr();

        if (!names || names->empty())
        {
            Creature const* bot = handler->getSelectedCreature();
            if (bot && bot->IsNPCBot() && !bot->IsTempBot() && !mgr->GetBot(bot->GetGUID()) && bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_UNBIND) &&
                BotDataMgr::SelectNpcBotData(bot->GetEntry())->owner == owner->GetGUID().GetCounter())
            {
                if (mgr->RebindBot(const_cast<Creature*>(bot)) != BOT_ADD_SUCCESS)
                {
                    handler->PSendSysMessage("由于某种原因，重新绑定 %s 失败了!", bot->GetName().c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            for (decltype(name)::size_type i = 0u; i < name.size(); ++i)
                if (name[i] == '_')
                    name[i] = ' ';

            std::vector<uint32> bot_ids;
            bot_ids.reserve(owner->GetBotMgr()->GetNpcBotsCount());
            for (auto const& kv : *owner->GetBotMgr()->GetBotMap())
                bot_ids.push_back(kv.first.GetEntry());

            Creature const* bot = BotDataMgr::FindBot(name, owner->GetSession()->GetSessionDbLocaleIndex(), &bot_ids);
            if (bot && bot->IsNPCBot() && !bot->IsTempBot() && !mgr->GetBot(bot->GetGUID()) && bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_UNBIND) &&
                BotDataMgr::SelectNpcBotData(bot->GetEntry())->owner == owner->GetGUID().GetCounter())
            {
                if (mgr->RebindBot(const_cast<Creature*>(bot)) != BOT_ADD_SUCCESS)
                {
                    handler->PSendSysMessage("由于某种原因，重新绑定 %s 失败了!", name.c_str());
                    handler->SetSentErrorMessage(true);
                    continue;
                }
                ++count;
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("无法重新绑定 %u 个NPCBots中的任何一个!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotCommandUnBindCommand(ChatHandler* handler, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage(".npcbot command unbind [#names...]");
            chandler->SendSysMessage("暂时释放选定/给定名字的NPCBots。机器人将返回原位并等待重新绑定");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("成功解绑 %u 个NPCBots", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("成功解绑 %s", name_or_count.get<std::string>().c_str());
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
            return return_syntax(handler);

        if (!names || names->empty())
        {
            Unit const* target = handler->getSelectedCreature();
            Creature const* bot = target ? owner->GetBotMgr()->GetBot(target->GetGUID()) : nullptr;
            if (bot && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_UNBIND))
            {
                owner->GetBotMgr()->UnbindBot(bot->GetGUID());
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            for (decltype(name)::size_type i = 0u; i < name.size(); ++i)
                if (name[i] == '_')
                    name[i] = ' ';

            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_UNBIND))
            {
                ++count;
                owner->GetBotMgr()->UnbindBot(bot->GetGUID());
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("无法解除绑定 %u 个NPCBots中的任何一个!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotRemoveCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        Unit* u = owner->GetSelectedUnit();
        if (!u)
        {
            handler->SendSysMessage(".npcbot remove");
            handler->SendSysMessage("将选定的NPCBot从它的主人那里解雇。选择玩家来解雇所有Npcbots");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* master = u->ToPlayer();
        if (master)
        {
            if (master->HaveBot())
            {
                master->RemoveAllBots(BOT_REMOVE_DISMISS);

                if (!master->HaveBot())
                {
                    handler->SendSysMessage("NPCBots解雇成功");
                    handler->SetSentErrorMessage(true);
                    return true;
                }
                handler->SendSysMessage("一部分NPCBots没有被解雇!");
                handler->SetSentErrorMessage(true);
                return false;
            }
            handler->SendSysMessage("没有找到NPCBots!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* cre = u->ToCreature();
        if (cre && cre->IsNPCBot() && !cre->IsFreeBot())
        {
            master = cre->GetBotOwner();
            master->GetBotMgr()->RemoveBot(cre->GetGUID(), BOT_REMOVE_DISMISS);
            if (master->GetBotMgr()->GetBot(cre->GetGUID()) == nullptr)
            {
                handler->SendSysMessage("NPCBot解雇成功");
                handler->SetSentErrorMessage(true);
                return true;
            }
            handler->SendSysMessage("NPCBot没有被解雇，原因未知!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->SendSysMessage("你必须选择玩家或已被雇佣的NPCBot");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotReviveCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        Unit* u = owner->GetSelectedUnit();
        if (!u)
        {
            handler->SendSysMessage(".npcbot revive");
            handler->SendSysMessage("使选定的NPCBot复活。如果玩家被选中，则使被选中的玩家的所有NPCBot复活。");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (Player* master = u->ToPlayer())
        {
            if (!master->HaveBot())
            {
                handler->PSendSysMessage("%s没有NPCBots!", master->GetName().c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }

            master->GetBotMgr()->ReviveAllBots();
            handler->SendSysMessage("NPCBots已复活");
            return true;
        }
        else if (Creature* bot = u->ToCreature())
        {
            if (bot->GetBotAI())
            {
                if (bot->IsAlive())
                {
                    handler->PSendSysMessage("%s还没死", bot->GetName().c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }

                BotMgr::ReviveBot(bot, (bot->GetBotOwner() == owner) ? owner->ToUnit() : bot->ToUnit());
                handler->PSendSysMessage("%s 已复活", bot->GetName().c_str());
                return true;
            }
        }

        handler->SendSysMessage("你必须选择玩家或NPCBot");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotAddCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        Unit* cre = owner->GetSelectedUnit();

        if (!cre || cre->GetTypeId() != TYPEID_UNIT)
        {
            handler->SendSysMessage(".npcbot add");
            handler->SendSysMessage("雇佣选中的自由NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = cre->ToCreature();
        if (!bot || !bot->IsNPCBot() || bot->GetBotAI()->GetBotOwnerGuid() || bot->GetBotAI()->IsWanderer())
        {
            handler->SendSysMessage("你必须选择自由NPCBot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        ObjectGuid::LowType guidlow = owner->GetGUID().GetCounter();
        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &guidlow);
        bot->GetBotAI()->ReinitOwner();

        if (owner->GetBotMgr()->AddBot(bot) == BOT_ADD_SUCCESS)
        {
            handler->PSendSysMessage("%s 现在是你的NPCBot了", bot->GetName().c_str());
            return true;
        }

        handler->SendSysMessage("雇佣NPCBot失败，原因未知!");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotReloadConfigCommand(ChatHandler* handler)
    {
        LOG_INFO("misc", "Re-Loading config settings...");
        sWorld->LoadConfigSettings(true);
        sMapMgr->InitializeVisibilityDistanceInfo();
        handler->SendGlobalGMSysMessage("World配置已重新加载。");
        BotMgr::ReloadConfig();
        handler->SendGlobalGMSysMessage("NPCBot配置已重新加载。");
        return true;
    }
};

void AddSC_script_bot_commands()
{
    new script_bot_commands();
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
