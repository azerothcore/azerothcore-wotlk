#include "bot_ai.h"
#include "botdatamgr.h"
#include "botdump.h"
#include "botgearscore.h"
#include "botlog.h"
#include "botmgr.h"
#include "botwanderful.h"
#include "bot_InstanceEvents.h"
#include "Bag.h"
#include "CellImpl.h"
#include "Chat.h"
#include "CharacterCache.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "Language.h"
//#include "GameClient.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Item.h"
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
#include "Tokenize.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldDatabase.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"

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
    RBAC_PERM_COMMAND_NPCBOT_SPAWNED                         = SEC_GAMEMASTER,
    RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC                    = SEC_PLAYER,
    RBAC_PERM_COMMAND_NPCBOT_CREATENEW                       = SEC_ADMINISTRATOR,
    RBAC_PERM_COMMAND_NPCBOT_SEND                            = SEC_PLAYER
};
//end Acore only
#endif

using namespace Bcore::ChatCommands;

static uint32 last_model_id = 0;

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
            case BOT_CLASS_WARRIOR:     bot_color_str = "ffc79c6e"; bot_class_str = "Warrior";            break;
            case BOT_CLASS_PALADIN:     bot_color_str = "fff58cba"; bot_class_str = "Paladin";            break;
            case BOT_CLASS_HUNTER:      bot_color_str = "ffabd473"; bot_class_str = "Hunter";             break;
            case BOT_CLASS_ROGUE:       bot_color_str = "fffff569"; bot_class_str = "Rogue";              break;
            case BOT_CLASS_PRIEST:      bot_color_str = "ffffffff"; bot_class_str = "Priest";             break;
            case BOT_CLASS_DEATH_KNIGHT:bot_color_str = "ffc41f3b"; bot_class_str = "Death Knight";       break;
            case BOT_CLASS_SHAMAN:      bot_color_str = "ff0070de"; bot_class_str = "Shaman";             break;
            case BOT_CLASS_MAGE:        bot_color_str = "ff69ccf0"; bot_class_str = "Mage";               break;
            case BOT_CLASS_WARLOCK:     bot_color_str = "ff9482c9"; bot_class_str = "Warlock";            break;
            case BOT_CLASS_DRUID:       bot_color_str = "ffff7d0a"; bot_class_str = "Druid";              break;
            case BOT_CLASS_BM:          bot_color_str = "ffa10015"; bot_class_str = "Blademaster";        break;
            case BOT_CLASS_SPHYNX:      bot_color_str = "ff29004a"; bot_class_str = "Obsidian Destroyer"; break;
            case BOT_CLASS_ARCHMAGE:    bot_color_str = "ff028a99"; bot_class_str = "Archmage";           break;
            case BOT_CLASS_DREADLORD:   bot_color_str = "ff534161"; bot_class_str = "Dreadlord";          break;
            case BOT_CLASS_SPELLBREAKER:bot_color_str = "ffcf3c1f"; bot_class_str = "Spellbreaker";       break;
            case BOT_CLASS_DARK_RANGER: bot_color_str = "ff3e255e"; bot_class_str = "Dark Ranger";        break;
            case BOT_CLASS_NECROMANCER: bot_color_str = "ff9900cc"; bot_class_str = "Necromancer";        break;
            case BOT_CLASS_SEA_WITCH:   bot_color_str = "ff40d7a9"; bot_class_str = "Sea Witch";          break;
            case BOT_CLASS_CRYPT_LORD:  bot_color_str = "ff19782b"; bot_class_str = "Crypt Lord";         break;
            default:                    bot_color_str = "ffffffff"; bot_class_str = "Unknown";            break;
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
    << get_race_name(r) << " Male:" \
    << " skin 0-" << uint32(GetMaxVisual<PlayerVisuals::Skins, r, GENDER_MALE>()) \
    << " face 0-" << uint32(GetMaxVisual<PlayerVisuals::Faces, r, GENDER_MALE>()) \
    << " hairstyle 0-" << uint32(GetMaxVisual<PlayerVisuals::HairStyles, r, GENDER_MALE>()) \
    << " haircolor 0-" << uint32(GetMaxVisual<PlayerVisuals::HairColors, r, GENDER_MALE>()) \
    << " features 0-" << uint32(GetMaxVisual<PlayerVisuals::Features, r, GENDER_MALE>()) \
    << "\n" << get_race_name(r) << " Female:" \
    << " skin 0-" << uint32(GetMaxVisual<PlayerVisuals::Skins, r, GENDER_FEMALE>()) \
    << " face 0-" << uint32(GetMaxVisual<PlayerVisuals::Faces, r, GENDER_FEMALE>()) \
    << " hairstyle 0-" << uint32(GetMaxVisual<PlayerVisuals::HairStyles, r, GENDER_FEMALE>()) \
    << " haircolor 0-" << uint32(GetMaxVisual<PlayerVisuals::HairColors, r, GENDER_FEMALE>()) \
    << " features 0-" << uint32(GetMaxVisual<PlayerVisuals::Features, r, GENDER_FEMALE>())

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

            handler->SendSysMessage(stream.str());
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
                BOT_LOG_ERROR("scripts", "GetZoneLevels: no choice for zoneId {}", zoneId);
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
            case RACE_HUMAN:        return "Human";
            case RACE_ORC:          return "Orc";
            case RACE_DWARF:        return "Dwarf";
            case RACE_NIGHTELF:     return "Night Elf";
            case RACE_UNDEAD_PLAYER:return "Undead";
            case RACE_TAUREN:       return "Tauren";
            case RACE_GNOME:        return "Gnome";
            case RACE_TROLL:        return "Troll";
            case RACE_BLOODELF:     return "Blood Elf";
            case RACE_DRAENEI:      return "Draenei";
            default:                return "Non-standard";
        }
    };

    static char const* get_class_name(uint8 class_)
    {
        switch (class_)
        {
            case CLASS_WARRIOR:     return "Warrior";
            case CLASS_PALADIN:     return "Paladin";
            case CLASS_HUNTER:      return "Hunter";
            case CLASS_ROGUE:       return "Rogue";
            case CLASS_PRIEST:      return "Priest";
            case CLASS_DEATH_KNIGHT:return "Death Knight";
            case CLASS_SHAMAN:      return "Shaman";
            case CLASS_MAGE:        return "Mage";
            case CLASS_WARLOCK:     return "Warlock";
            case CLASS_DRUID:       return "Druid";
            default:                return "Non-standard";
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
        //void OnDespawn() override { _wp->SetCreature(nullptr); }

        bool CanAIAttack(Unit const*) const override { return false; }
        void MoveInLineOfSight(Unit*) override {}
        void AttackStart(Unit*) override {}
        void UpdateAI(uint32) override {}

    private:
        WanderNode* const _wp;
    };

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable npcbotLogCommandTable =
        {
            //{ "testwrite",  HandleNpcBotLogTestWriteCommand,        rbac::RBAC_PERM_COMMAND_NPCBOT_DUMP_WRITE,         Console::Yes },
            { "clear",      HandleNpcBotLogClearCommand,            rbac::RBAC_PERM_COMMAND_NPCBOT_DUMP_WRITE,         Console::Yes },
        };

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
            { "setlevels z",HandleNpcBotWPSetLevelsZoneCommand,     rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setflags",   HandleNpcBotWPSetFlagsCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setflags z", HandleNpcBotWPSetFlagsZoneCommand,      rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setname",    HandleNpcBotWPSetNameCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setlinks",   HandleNpcBotWPSetLinksCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "setweights", HandleNpcBotWPSetLinkWeightsCommand,    rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "info",       HandleNpcBotWPInfoCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "links",      HandleNpcBotWPLinksCommand,             rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
        };

        static ChatCommandTable npcbotDebugEventCommandTable =
        {
            { "launch",     HandleNpcBotDebugEventLaunchCommand,    rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::No  },
        };

        static ChatCommandTable npcbotDebugCommandTable =
        {
            { "raid",       HandleNpcBotDebugRaidCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_RAID,         Console::No  },
            { "mount",      HandleNpcBotDebugMountCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_MOUNT,        Console::No  },
            { "model",      HandleNpcBotDebugModelCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_VISUAL,       Console::No  },
            { "spellvisual",HandleNpcBotDebugSpellVisualCommand,    rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_VISUAL,       Console::No  },
            { "states",     HandleNpcBotDebugStatesCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::No  },
            { "spells",     HandleNpcBotDebugSpellsCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::No  },
            { "guids",      HandleNpcBotDebugGuidsCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::No  },
            { "wbequips",   HandleNpcBotDebugWBEquipsCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::Yes },
            { "wpreid",     HandleNpcBotDebugWPReidCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::Yes },
            { "event",      npcbotDebugEventCommandTable                                                                            },
        };

        static ChatCommandTable npcbotSetCommandTable =
        {
            { "faction",    HandleNpcBotSetFactionCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_SET_FACTION,        Console::No  },
            { "owner",      HandleNpcBotSetOwnerCommand,            rbac::RBAC_PERM_COMMAND_NPCBOT_SET_OWNER,          Console::No  },
            { "spec",       HandleNpcBotSetSpecCommand,             rbac::RBAC_PERM_COMMAND_NPCBOT_SET_SPEC,           Console::No  },
        };

        static ChatCommandTable npcbotCommandFollowCommandTable =
        {
            { "",           HandleNpcBotCommandFollowCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_FOLLOW,     Console::No  },
            { "only",       HandleNpcBotCommandFollowOnlyCommand,   rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_FOLLOW,     Console::No  },
        };

        static ChatCommandTable npcbotCommandCommandTable =
        {
            { "standstill", HandleNpcBotCommandStandstillCommand,   rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_STANDSTILL, Console::No  },
            { "stopfully",  HandleNpcBotCommandStopfullyCommand,    rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_STOPFULLY,  Console::No  },
            { "follow",     npcbotCommandFollowCommandTable                                                                         },
            { "walk",       HandleNpcBotCommandWalkCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "nogossip",   HandleNpcBotCommandNoGossipCommand,     rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "unbind",     HandleNpcBotCommandUnBindCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "rebind",     HandleNpcBotCommandReBindCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "nocast",     HandleNpcBotCommandNoCastCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "nolongcast", HandleNpcBotCommandNoLongCastCommand,   rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
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
            { "pull",       HandleNpcBotOrderPullCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_ORDER_CAST,         Console::No  },
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

        static ChatCommandTable npcbotUseOnBotCommandTable =
        {
            { "spell",      HandleNpcBotUseOnBotSpellCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "item",       HandleNpcBotUseOnBotItemCommand,        rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
        };

        static ChatCommandTable npcbotCommandTable =
        {
            //{ "debug",      npcbotDebugCommandTable                                                                                 },
            //{ "toggle",     npcbotToggleCommandTable                                                                                },
            { "set",        npcbotSetCommandTable                                                                                   },
            { "add",        HandleNpcBotAddCommand,                 rbac::RBAC_PERM_COMMAND_NPCBOT_ADD,                Console::No  },
            { "remove",     HandleNpcBotRemoveCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_REMOVE,             Console::No  },
            { "free",       HandleNpcBotFreeCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_REMOVE,             Console::No  },
            { "createnew",  HandleNpcBotCreateNewCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_CREATENEW,          Console::Yes },
            { "spawn",      HandleNpcBotSpawnCommand,               rbac::RBAC_PERM_COMMAND_NPCBOT_SPAWN,              Console::No  },
            { "move",       HandleNpcBotMoveCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_MOVE,               Console::No  },
            { "delete",     npcbotDeleteCommandTable                                                                                },
            { "lookup",     HandleNpcBotLookupCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_LOOKUP,             Console::Yes },
            { "list",       npcbotListCommandTable                                                                                  },
            { "revive",     HandleNpcBotReviveCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_REVIVE,             Console::No  },
            { "reloadconfig",HandleNpcBotReloadConfigCommand,       rbac::RBAC_PERM_COMMAND_NPCBOT_RELOADCONFIG,       Console::Yes },
            { "useonbot",   npcbotUseOnBotCommandTable                                                                              },
            { "command",    npcbotCommandCommandTable                                                                               },
            { "info",       HandleNpcBotInfoCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_INFO,               Console::Yes },
            { "hide",       HandleNpcBotHideCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_HIDE,               Console::No  },
            { "unhide",     HandleNpcBotUnhideCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_UNHIDE,             Console::No  },
            { "show",       HandleNpcBotUnhideCommand,              rbac::RBAC_PERM_COMMAND_NPCBOT_UNHIDE,             Console::No  },
            { "recall",     npcbotRecallCommandTable                                                                                },
            { "kill",       HandleNpcBotKillCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_KILL,               Console::No  },
            { "suicide",    HandleNpcBotKillCommand,                rbac::RBAC_PERM_COMMAND_NPCBOT_KILL,               Console::No  },
            { "fix",        HandleNpcBotFixCommand,                 rbac::RBAC_PERM_COMMAND_NPCBOT_REVIVE,             Console::No  },
            { "go",         HandleNpcBotGoCommand,                  rbac::RBAC_PERM_COMMAND_NPCBOT_MOVE,               Console::No  },
            { "gs",         HandleNpcBotGearScoreCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_COMMAND_MISC,       Console::No  },
            { "sendto",     npcbotSendToCommandTable                                                                                },
            { "distance",   npcbotDistanceCommandTable                                                                              },
            { "order",      npcbotOrderCommandTable                                                                                 },
            { "vehicle",    npcbotVehicleCommandTable                                                                               },
            { "dump",       npcbotDumpCommandTable                                                                                  },
            { "wp",         npcbotWPCommandTable                                                                                    },
            { "log",        npcbotLogCommandTable                                                                                   },
        };

        static ChatCommandTable commandTable =
        {
            { "npcbot",     npcbotCommandTable                                                                                      },
        };
        return commandTable;
    }

    static bool HandleNpcBotLogClearCommand(ChatHandler* handler)
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        trans->Append("TRUNCATE TABLE `characters_npcbot_logs`");
        trans->Append("ALTER TABLE `characters_npcbot_logs` AUTO_INCREMENT = 0");
        CharacterDatabase.CommitTransaction(trans);
        handler->SendSysMessage("Table `characters_npcbot_logs` was cleared and autoincrement was reset");
        return true;
    }

    static bool HandleNpcBotLogTestWriteCommand(ChatHandler* handler, Optional<std::underlying_type_t<BotLogType>> log_type, Optional<uint32> entry, Optional<std::vector<std::string>> extra)
    {
        if (!log_type || !entry)
        {
            handler->PSendSysMessage(".npcbot log testwrite #log_type #entry #[owner] #[mapid] #[inmap] #[inworld] #[params[1-{}]]", MAX_BOT_LOG_PARAMS);
            handler->SendSysMessage("Test `characters_npcbot_logs` table write 2");
            handler->SetSentErrorMessage(true);
            return false;
        }

        decltype(extra)::value_type extras{ extra.value_or(decltype(extra)::value_type{}) };
        extras.resize(MAX_BOT_LOG_PARAMS, "");
        BotLogger::Log(*log_type, *entry, extras[0], extras[1], extras[2], extras[3], extras[4]);
        return true;
    }

    static TempSummon* HandleWPSummon(WanderNode* wp, Map* map)
    {
        CellCoord c = Bcore::ComputeCellCoord(wp->m_positionX, wp->m_positionY);
        GridCoord g = Bcore::ComputeGridCoord(wp->m_positionX, wp->m_positionY);
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
        wpc->SetMaxPower(POWER_MANA, wp->GetFlags());
        wpc->SetPower(POWER_MANA, wp->GetFlags());
        wpc->SetObjectScale(4.0f);
        wp->SetupLinkFromAura();
        wp->SetupLinkToAura();
        wpc->m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GM, wpc->m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GM));
        return wpc;
    }

    static bool HandleNpcBotWPGenerateCommand(ChatHandler* handler, Optional<bool> save)
    {
        using WanderNodeLink = WanderNode::WanderNodeLink;

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
                    wp->Link(WanderNodeLink{ .wp = const_cast<WanderNode*>(mwp), .weight = 0 });
            });

            handler->SendSysMessage(wp->ToString());
        }

        handler->PSendSysMessage("Generating wander nodes completed with {} nodes", uint32(WanderNode::GetAllWPsCount()));

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
                << ',' << wp->GetFlags() << ",'" << wp->GetName() << "','" << wp->FormatLinks() << "'),";
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
                    Unit::Kill(wpc, wpc);
                ASSERT_NOTNULL(HandleWPSummon(const_cast<WanderNode*>(wp), map));
            });
        }

        return true;
    }

    static bool HandleNpcBotWPLinksCommand(ChatHandler* handler)
    {
        using WanderNodeLink = WanderNode::WanderNodeLink;

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
        std::vector<WanderNode const*> to_links;
        WanderNode::DoForAllMapWPs(wp->GetMapId(), [=, &to_links](WanderNode const* mwp) {
            if (mwp != wp && mwp->HasLink(wp))
                to_links.push_back(mwp);
        });
        uint32 counter = 0;
        ss << uint32(to_links.size()) << " WPs have a link to WP " << wp->GetWPId() << ':';
        WanderNode::DoForContainerWPs(to_links, [&ss, &counter, wp = wp](WanderNode const* lwp) {
            ss << "\n" << ++counter << ") <- " << lwp->ToString() << " (dist2d: " << lwp->GetExactDist2d(wp) << ")";
        });
        counter = 0;
        ss << "\nWP " << wp->GetWPId() << " has " << uint32(links.size()) << " links (avg weight " << wp->GetAverageLinkWeight() << "):";
        WanderNode::DoForContainerWPLinks(links, [&ss, &counter, wp = wp](WanderNodeLink const& wlp) {
            ss << "\n" << ++counter << ") -> " << wlp.wp->ToString(static_cast<int32>(wlp.weight)) << " (dist2d: " << wp->GetExactDist2d(wlp.wp) << ")";
        });

        handler->SendSysMessage(ss.str());

        std::array vis_spell_ids = { static_cast<uint32>(2400u), 41637u };
        WanderNode::DoForContainerWPs(to_links, [=](WanderNode const* lwp) {
            if (!lwp->GetCreature())
            {
                handler->PSendSysMessage("Can't visualise link {}-{}, no creature...", lwp->GetWPId(), wp->GetWPId());
                return;
            }
            for (uint32 spell_id : vis_spell_ids)
                lwp->GetCreature()->CastSpell(wpc, spell_id, true);
        });
        WanderNode::DoForContainerWPLinks(links, [=](WanderNodeLink const& wlp) {
            if (!wlp.wp->GetCreature())
            {
                handler->PSendSysMessage("Can't visualise link {}-{}, no creature...", wp->GetWPId(), wlp.wp->GetWPId());
                return;
            }
            for (uint32 spell_id : vis_spell_ids)
                wpc->CastSpell(wlp.wp->GetCreature(), spell_id, true);
        });

        return true;
    }
    static bool HandleExtractWPIdWeightPairs(ChatHandler* handler, std::vector<std::string_view> const& links_strings, std::vector<std::pair<uint32, int32>>& link_pairs)
    {
        bool result = true;
        link_pairs.reserve(links_strings.size());
        for (std::string_view newlink : links_strings)
        {
            std::vector<std::string_view> toks = Bcore::Tokenize(newlink, ':', false);
            Optional<uint32> val1 = toks.size() >= 1 ? Bcore::StringTo<uint32>(toks[0]) : std::nullopt;
            Optional<uint32> val2 = toks.size() >= 2 ? Bcore::StringTo<uint32>(toks[1]) : std::nullopt;
            if (toks.size() > 2 || val1 == std::nullopt || val2 == std::nullopt)
            {
                handler->PSendSysMessage("Invalid link format: {}", newlink);
                result = false;
                continue;
            }
            link_pairs.emplace_back(*val1, val2.value_or(int32(-1)));
        }
        return result;
    }
    static void HandleWPUpdateLinks(ChatHandler* handler, WanderNode* wp, std::vector<std::pair<uint32, int32>> const& newlinks, bool oneway = false, bool on_delete = false)
    {
        using WanderNodeLink = WanderNode::WanderNodeLink;

        if (oneway && on_delete)
        {
            handler->PSendSysMessage("Can't perform one-way delete!");
            return;
        }

        std::remove_cvref_t<decltype(wp->GetLinks())> links = wp->GetLinks(); //copy
        uint32 average_weight = wp->GetAverageLinkWeight();

        std::unordered_set<WanderNode const*> wps_updates;
        std::vector<WanderNodeLink const*> wps_relinks;

        if (on_delete)
        {
            //Find all WPs having a link to us and remove those links
            WanderNode::DoForAllMapWPs(wp->GetMapId(), [=, &links, &wps_updates](WanderNode const* mwp) {
                if (mwp != wp && mwp->HasLink(wp) && std::ranges::none_of(links, [=](WanderNodeLink const& wpl) { return wpl.Id() == mwp->GetWPId(); }))
                {
                    handler->PSendSysMessage("Removing link {}->{}...", mwp->GetWPId(), wp->GetWPId());
                    const_cast<WanderNode*>(mwp)->UnLink(wp);
                    wps_updates.insert(mwp);
                }
            });
        }
        else
        {
            wps_updates.insert(wp);
            //Re-create all links we are not updating in case of only setting one-way links, unless doing a full purge
            if (oneway && !newlinks.empty())
                for (std::remove_cvref_t<decltype(links)>::value_type const& wpl : links)
                    wps_relinks.push_back(&wpl);
        }

        if (links.empty())
            handler->PSendSysMessage("WP {} had no links...", wp->GetWPId());
        else
        {
            while (!wp->GetLinks().empty())
            {
                WanderNode* lwp = wp->GetLinks().front().wp;
                bool removing_reverse_link = (!oneway || std::ranges::any_of(newlinks, [=](auto const& p) { return p.first == lwp->GetWPId(); })) && lwp->HasLink(wp);
                handler->PSendSysMessage("Removing link {}{}{}...", wp->GetWPId(), removing_reverse_link ? "<->" : "->", lwp->GetWPId());
                wp->UnLink(lwp);
                if (removing_reverse_link)
                {
                    lwp->UnLink(wp);
                    wps_updates.insert(lwp);
                }
            }
        }

        for (auto const& p : newlinks)
        {
            uint32 lid = p.first;
            uint32 lweight = p.second >= 0 ? uint32(p.second) : average_weight;

            if (lid == wp->GetWPId())
            {
                handler->PSendSysMessage("Trying to add WP {} to its own links! Are you dumb?", lid);
                continue;
            }

            WanderNode* lwp = WanderNode::FindInMapWPs(wp->GetMapId(), lid);
            if (!lwp)
            {
                handler->PSendSysMessage("WP {} is not found in map {}!", lid, wp->GetMapId());
                continue;
            }

            if (p.second < 0 && lweight)
                handler->PSendSysMessage("Link {}{}{} has no weight assigned, using average ({})!", wp->GetWPId(), oneway ? "->" : "<->", lid, lweight);

            if (!wps_relinks.empty())
            {
                auto wpscit = std::ranges::find_if(wps_relinks, [=](WanderNodeLink const* wlp) { return wlp->Id() == lwp->GetWPId(); });
                if (wpscit != wps_relinks.cend())
                    wps_relinks.erase(wpscit);
            }

            handler->PSendSysMessage("Adding link {}{}{} (w={}, avg was {})...", wp->GetWPId(), oneway ? "->" : "<->", lid, lweight, average_weight);
            if (wp->GetExactDist2d(lwp) > MAX_VISIBILITY_DISTANCE)
                handler->PSendSysMessage("Warning! Link distance is too great ({:.2f})", wp->GetExactDist2d(lwp));

            wp->Link(WanderNodeLink{ .wp = lwp, .weight = lweight });
            if (!oneway)
            {
                lwp->Link(WanderNodeLink{ .wp = wp, .weight = lwp->GetAverageLinkWeight() });
                wps_updates.insert(lwp);
            }
        }

        if (!on_delete)
        {
            if (!wps_relinks.empty())
            {
                std::sort(wps_relinks.begin(), wps_relinks.end(), [](WanderNodeLink const* wlp1, WanderNodeLink const* wlp2) { return wlp1->Id() < wlp2->Id(); });
                for (WanderNodeLink const* wlp : wps_relinks)
                {
                    handler->PSendSysMessage("Adding link {}->{} (w={})...", wp->GetWPId(), wlp->Id(), wlp->weight);
                    if (wp->GetExactDist2d(wlp->wp) > MAX_VISIBILITY_DISTANCE)
                        handler->PSendSysMessage("Warning! Link distance is too great ({})", wp->GetExactDist2d(wlp->wp));
                    wp->Link(WanderNodeLink{ .wp = wlp->wp, .weight = wlp->weight });
                }
            }
            if (!wp->GetLinks().empty() || !links.empty())
            {
                handler->PSendSysMessage("WP {} links {} -> {}, avg link weight {} -> {}...",
                    wp->GetWPId(), uint32(links.size()), uint32(wp->GetLinks().size()), average_weight, wp->GetAverageLinkWeight());
            }
        }

        WorldDatabaseTransaction trans = WorldDatabase.BeginTransaction();
        WanderNode::DoForContainerWPs(wps_updates, [&trans](WanderNode const* uwp) {
            trans->Append("UPDATE creature_template_npcbot_wander_nodes SET links='{}' WHERE id={}", uwp->FormatLinks(), uwp->GetWPId());
        });
        WorldDatabase.DirectCommitTransaction(trans);
    }
    static void HandleWPUpdateLinkWeights(ChatHandler* handler, WanderNode* wp, std::vector<std::pair<uint32, int32>> const& link_weights)
    {
        using WanderNodeLink = WanderNode::WanderNodeLink;

        bool dirty = false;
        auto const& links = wp->GetLinks();
        std::vector<uint32> avg_weight_links;

        for (auto const& p : link_weights)
        {
            uint32 lid = p.first;

            if (!WanderNode::FindInMapWPs(wp->GetMapId(), lid))
            {
                handler->PSendSysMessage("WP {} does not exist!", lid);
                continue;
            }

            if (std::ranges::find_if(links, [=](WanderNodeLink const& wpl) { return wpl.Id() == lid; }) == links.cend())
            {
                handler->PSendSysMessage("WP {} has no link to WP {}!", wp->GetWPId(), lid);
                continue;
            }

            dirty = true;

            if (p.second < 0)
            {
                wp->SetLinkWeight(p.first, 0);
                avg_weight_links.push_back(p.first);
            }
            else
                wp->SetLinkWeight(p.first, static_cast<uint32>(p.second));
        }

        if (!avg_weight_links.empty())
        {
            uint32 average_weight = wp->GetAverageLinkWeight(true);
            for (uint32 awlid : avg_weight_links)
                wp->SetLinkWeight(awlid, average_weight);
        }

        if (dirty)
            WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET links='{}' WHERE id={}", wp->FormatLinks(), wp->GetWPId());
    }
    static bool HandleNpcBotWPSetLinksCommand(ChatHandler* handler, Optional<std::vector<uint32>> links, Optional<bool> oneway)
    {
        if (!links)
        {
            handler->SendSysMessage("Syntax: npcbot wp setlinks #[id[:weight] ...] #[oneway: True/False] #[remove_rev_links: True/False]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetPlayer();
        Unit* wpc = player->GetSelectedUnit();
        WanderNode* wp = wpc ? WanderNode::FindInAllWPs(wpc->ToCreature()) : nullptr;
        if (!wp)
        {
            handler->SendSysMessage("No WP selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::vector<std::pair<uint32, int32>> pairs;
        if (!(links->size() == 1 && links->front() == 0))
            for (uint32 lid : *links)
                pairs.emplace_back(lid, -1);

        HandleWPUpdateLinks(handler, wp, pairs, oneway ? *oneway : false);

        return true;
    }
    static bool HandleNpcBotWPSetLinkWeightsCommand(ChatHandler* handler, Optional<std::vector<std::string_view>> link_weights)
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

        if (!link_weights || link_weights->empty())
        {
            handler->SendSysMessage("Syntax: npcbot wp setweights #[id:weight ...]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::vector<std::pair<uint32, int32>> pairs;
        if (!HandleExtractWPIdWeightPairs(handler, *link_weights, pairs))
        {
            handler->SetSentErrorMessage(true);
            return false;
        }

        HandleWPUpdateLinkWeights(handler, wp, pairs);

        return true;
    }

    static bool HandleNpcBotWPInfoCommand(ChatHandler* handler, Optional<uint32> wpId)
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
            handler->PSendSysMessage("WP levels must be within bounds 1-{}, min <= max", uint32(DEFAULT_MAX_LEVEL));
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 zoneId, areaId;
        player->GetZoneAndAreaId(zoneId, areaId);
        handler->PSendSysMessage("Setting levels min={} max={} for zone {}", uint32(*minlevel), uint32(*maxlevel), zoneId);
        WanderNode::DoForAllZoneWPs(zoneId, [handler = handler, minl = *minlevel, maxl = *maxlevel](WanderNode const* wp) {
            handler->PSendSysMessage("Setting levels min={} max={} for node {} '{}'", uint32(minl), uint32(maxl), wp->GetWPId(), wp->GetName());
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
            handler->PSendSysMessage("WP levels must be within bounds 1-{}, min <= max", uint32(DEFAULT_MAX_LEVEL));
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 wpId = wp->GetWPId();
        auto [minlevel_cur, maxlevel_cur] = wp->GetLevels();

        handler->PSendSysMessage("Changing WP {} '{}' levels from {}-{} to {}-{}", wpId, wp->GetName().c_str(), uint32(minlevel_cur), uint32(maxlevel_cur), uint32(*minlevel), uint32(*maxlevel));
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
                handler->PSendSysMessage("Removing WP {} '{}' flag {}", wpId, wp->GetName(), uint32(-flags));
                const_cast<WanderNode*>(wp)->RemoveFlags(BotWPFlags(-flags));
            }
            else
            {
                handler->PSendSysMessage("Adding WP {} '{}' flag {}", wpId, wp->GetName(), uint32(flags));
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
            handler->PSendSysMessage("Removing WP {} '{}' flag {}", wpId, wp->GetName(), uint32(-*flags));
            wp->RemoveFlags(BotWPFlags(-*flags));
        }
        else
        {
            handler->PSendSysMessage("Adding WP {} '{}' flag {}", wpId, wp->GetName(), uint32(*flags));
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

        handler->PSendSysMessage("Changing WP {} '{}' name to '{}'", wpId, wp->GetName(), *newname);
        wp->SetName(*newname);

        WorldDatabase.Execute("UPDATE creature_template_npcbot_wander_nodes SET name='{}' WHERE id={}", wp->GetName(), wpId);

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

        handler->PSendSysMessage("WP {} '{}' was successfully moved.", wp->GetWPId(), wp->GetName());

        return true;
    }

    static bool HandleNpcBotWPAddCommand(ChatHandler* handler, Optional<uint32> flags, Optional<std::string> name, Optional<uint8> minlevel, Optional<uint8> maxlevel)
    {
        Player* player = handler->GetPlayer();

        if (!flags || !name || (!player->GetMap()->GetEntry()->IsContinent() && !player->GetMap()->GetEntry()->IsBattlegroundOrArena()))
        {
            handler->SendSysMessage("Syntax: npcbot wp add #[flags] #[name] #[minlevel #[maxlevel]]. World maps / BGs only");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (minlevel)
        {
            if (!*minlevel || *minlevel > DEFAULT_MAX_LEVEL)
            {
                handler->PSendSysMessage("Minlevel must be between 1 and {}!", uint32(DEFAULT_MAX_LEVEL));
                handler->SetSentErrorMessage(true);
                return false;
            }
            if (maxlevel)
            {
                if (!*maxlevel || *maxlevel > DEFAULT_MAX_LEVEL)
                {
                    handler->PSendSysMessage("Maxlevel must be between 1 and {}!", uint32(DEFAULT_MAX_LEVEL));
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
            handler->PSendSysMessage("Flags must be below {}!", AsUnderlyingType(BotWPFlags::BOTWP_FLAG_END));
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 zoneId, areaId;
        player->GetZoneAndAreaId(zoneId, areaId);
        WanderNode* wp = new WanderNode(++WanderNode::nextWPId, player->GetMapId(), player->m_positionX, player->m_positionY, player->m_positionZ,
            player->GetOrientation(), zoneId, areaId, *name);

        wp->SetLevels((!minlevel && !maxlevel) ? GetZoneLevels(GetZoneIdOverride(zoneId)) : std::pair{minlevel ? *minlevel : uint8(1), maxlevel ? *maxlevel : uint8(DEFAULT_MAX_LEVEL)});
        wp->SetFlags(BotWPFlags(*flags));

        std::vector<std::pair<uint32, int32>> link_pairs;
        if (Unit* twpc = player->GetSelectedUnit())
            if (WanderNode const* twp = WanderNode::FindInMapWPs(player->GetMapId(), twpc->ToCreature()))
                if (twp->GetWPId() != wp->GetWPId() - 1)
                    link_pairs.emplace_back(twp->GetWPId(), -1);
        if (link_pairs.empty())
        {
            if (WanderNode const* pwp = WanderNode::FindInMapWPs(player->GetMapId(), wp->GetWPId() - 1))
                if (wp->GetExactDist2d(pwp) < MAX_VISIBILITY_DISTANCE)
                    link_pairs.emplace_back(pwp->GetWPId(), -1);
        }
        if (link_pairs.empty())
        {
            WanderNode::DoForAllMapWPs(wp->GetMapId(), [wp = wp, &link_pairs](WanderNode const* mwp) {
                if (wp->GetWPId() != mwp->GetWPId() && wp->GetExactDist2d(mwp) < MAX_VISIBILITY_DISTANCE)
                    link_pairs.emplace_back(mwp->GetWPId(), -1);
            });
        }
        HandleWPUpdateLinks(handler, wp, link_pairs);

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

        handler->PSendSysMessage("Created WP {} '{}' levels {}-{} flags {}", wpId, wpName, uint32(minl), uint32(maxl), wpFlags);

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

        HandleWPUpdateLinks(handler, wp, {}, false, true);
        WanderNode::RemoveWP(wp);

        WorldDatabase.Execute("DELETE FROM creature_template_npcbot_wander_nodes WHERE id={}", wpId);

        handler->PSendSysMessage("WP {} '{}' was successfully deleted.", wpId, wpName);

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

        AreaTableEntry const* zone = sAreaTableStore.LookupEntry(zoneId);
        AreaTableEntry const* area = sAreaTableStore.LookupEntry(areaId);

        std::ostringstream ss;
        ss << "Zone " << zoneId << " (" << std::string(zone ? zone->area_name[0] : "unknown") << ") wps:";
        WanderNode::DoForAllZoneWPs(zoneId, [&ss](WanderNode const* wp) {
            ss << "\n" << wp->ToString();
        });
        ss << "\nArea " << areaId << " (" << std::string(area ? area->area_name[0] : "unknown") << ") wps:";
        WanderNode::DoForAllAreaWPs(areaId, [&ss](WanderNode const* wp) {
            ss << "\n" << wp->ToString();
        });

        handler->SendSysMessage(ss.str());
        return true;
    }
    static bool HandleNpcBotWPListAllCommand(ChatHandler* handler)
    {
        WanderNode::DoForAllWPs([handler = handler](WanderNode* wp) {
            handler->SendSysMessage(wp->ToString());
        });

        return true;
    }

    static bool HandleNpcBotWPGoCommand(ChatHandler* handler, uint32 wpId)
    {
        Player* player = handler->GetPlayer();

        WanderNode const* wp = WanderNode::FindInAllWPs(wpId);
        if (!wp)
        {
            handler->PSendSysMessage("WP {} not found", wpId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        player->TeleportTo(WorldLocation(wp->GetMapId(), *wp), TELE_TO_GM_MODE);

        return true;
    }

    static bool HandleNpcBotDebugEventLaunchCommand(ChatHandler* handler, Optional<uint32> event_num)
    {
        if (!event_num)
        {
            handler->SendSysMessage("Syntax: .npcbot debug event launch #event_num");
            handler->SendSysMessage("Launches event for this instance");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player const* player = handler->GetPlayer();
        if (!player->HaveBot())
        {
            handler->SendSysMessage("You have no bots!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Map* map = player->GetMap();
        if (!map->IsDungeon())
        {
            handler->SendSysMessage("Must be in a dungeon/raid!");
            handler->SetSentErrorMessage(true);
            return false;
        }
        InstanceScript* script = map->ToInstanceMap()->GetInstanceScript();
        if (!script)
        {
            handler->PSendSysMessage("Instance script is not found for map {}!", map->GetId());
            handler->SetSentErrorMessage(true);
            return false;
        }

        switch (*event_num)
        {
            case 1:
                switch (map->GetId())
                {
                    case 631: //Icecrown Citadel
                    {
                        if (player->GetAreaId() != 4859) // "Frozen Throne"
                        {
                            handler->SendSysMessage("Must be in Frozen Throne area!");
                            handler->SetSentErrorMessage(true);
                            return false;
                        }
                        GameObject* platform = nullptr;
                        Bcore::NearestGameObjectEntryInObjectRangeCheck check(*player, 202161, 100.0f);
                        Bcore::GameObjectSearcher<Bcore::NearestGameObjectEntryInObjectRangeCheck> searcher(player, platform, check);
                        Cell::VisitAllObjects(player, searcher, 100.0f);
                        if (!platform)
                        {
                            handler->SendSysMessage("Cannot find platform id 202161!");
                            handler->SetSentErrorMessage(true);
                            return false;
                        }
                        FrozenThronePlatformDestructionEvent(script, platform->GetPosition())();
                        break;
                    }
                    default:
                        handler->PSendSysMessage("Unknown event {} for map {}!", *event_num, map->GetId());
                        handler->SetSentErrorMessage(true);
                        return false;
                }
                break;
            default:
                handler->PSendSysMessage("Unknown event {}!", *event_num);
                handler->SetSentErrorMessage(true);
                return false;
        }

        return true;
    }

    static bool HandleNpcBotDebugWPReidCommand(ChatHandler* handler, Optional<uint32> start_id, Optional<uint32> end_id, Optional<uint32> target_start_id)
    {
        if (!start_id)
        {
            handler->SendSysMessage(".npcbot debug wpreid #start_id [#end_id #target_start_id]");
            handler->SendSysMessage("Compacts WP IDs to elimnate gaps between them, starting with <start_id>");
            handler->SendSysMessage("If #end_id and #target_start_id are provided then instead relocates WPs with IDs <start_id>..<end_id> to <target_start_id>...");
            handler->SendSysMessage("WARNING: THIS IS UNSAFE! Back-up your wander nodes table before proceeding");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!!end_id != !!target_start_id)
        {
            handler->SendSysMessage("Either both #end_id and #target_start_id or none required!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (end_id && *end_id < *start_id)
        {
            handler->SendSysMessage("End id must be equal or greater than start id!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (static bool all_wps_forced = false; !all_wps_forced)
        {
            all_wps_forced = true;
            handler->SendSysMessage("Force loading all wander nodes...");
            BotDataMgr::LoadWanderMap(true, true);
        }

        std::vector<WanderNode*> wander_nodes_copy;
        wander_nodes_copy.reserve(WanderNode::GetAllWPsCount());
        WanderNode::DoForAllWPs([&wander_nodes_copy](WanderNode* wp) { wander_nodes_copy.push_back(wp); });
        std::sort(std::begin(wander_nodes_copy), std::end(wander_nodes_copy), [](WanderNode const* wp1, WanderNode const* wp2) { return wp1->GetWPId() < wp2->GetWPId(); });

        uint32 startid = *start_id;
        uint32 endid = end_id.value_or(wander_nodes_copy.back()->GetWPId());
        const uint32 reid_count = endid - startid + 1;
        uint32 target_startid = target_start_id.value_or(startid);

        if (target_start_id)
        {
            if (std::ranges::any_of(wander_nodes_copy, [st = *target_start_id, en = *target_start_id + reid_count - 1](WanderNode const* wpc) {
                return wpc->GetWPId() >= st && wpc->GetWPId() <= en; }))
            {
                handler->SendSysMessage("Cannot reid onto existing WP ids!");
                handler->SetSentErrorMessage(true);
                return false;
            }

            handler->PSendSysMessage("Running re-id on {}..{} -> {}..{}", startid, endid, target_startid, uint32(target_startid + reid_count - 1));
        }
        else
            handler->PSendSysMessage("Running re-id on {}..{}", startid, endid);

        std::set<uint32> checked_map_ids;
        std::vector<uint32> wander_node_deletes;
        std::vector<WanderNode const*> wander_node_inserts;
        for (WanderNode* wp : wander_nodes_copy)
        {
            if (wp->GetWPId() >= startid && wp->GetWPId() <= endid)
            {
                if (!checked_map_ids.contains(wp->GetMapId()))
                {
                    checked_map_ids.insert(wp->GetMapId());
                    WanderNode::DoForAllMapWPs(wp->GetMapId(), [&wander_node_deletes, &wander_node_inserts](WanderNode const* uwp) {
                        wander_node_deletes.push_back(uwp->GetWPId());
                        wander_node_inserts.push_back(uwp);
                    });
                }
                uint32 prev_id = wp->GetWPId();
                wp->SetId(target_startid++);
                handler->PSendSysMessage("{} => {}", prev_id, wp->GetWPId());
            }
        }

        if (wander_node_deletes.empty() || wander_node_inserts.empty())
        {
            handler->SendSysMessage("No WPs found within given range");
            return false;
        }

        std::sort(std::begin(wander_nodes_copy), std::end(wander_nodes_copy), [](WanderNode const* wp1, WanderNode const* wp2) { return wp1->GetWPId() < wp2->GetWPId(); });
        WanderNode::nextWPId = wander_nodes_copy.back()->GetWPId();

        WorldDatabaseTransaction trans = WorldDatabase.BeginTransaction();
        std::ostringstream ss;
        for (uint32 wpid : wander_node_deletes)
            ss << wpid << ',';
        std::string wp_range_str = ss.str();
        wp_range_str.resize(wp_range_str.size() - 1u);
        trans->Append("DELETE FROM `creature_template_npcbot_wander_nodes` WHERE id IN ({})", wp_range_str);
        ss.str("");
        ss << "INSERT INTO `creature_template_npcbot_wander_nodes` (id,mapid,x,y,z,o,zoneid,areaid,minlevel,maxlevel,flags,name,links) VALUES ";
        WanderNode::DoForContainerWPs(wander_node_inserts, [&ss](WanderNode const* wp) {
            auto [minl, maxl] = wp->GetLevels();
            ss << '(' << wp->GetWPId() << ',' << wp->GetMapId()
                << ',' << wp->GetPositionX() << ',' << wp->GetPositionY() << ',' << wp->GetPositionZ() << ',' << wp->GetOrientation()
                << ',' << wp->GetZoneId() << ',' << wp->GetAreaId() << ',' << uint32(minl) << ',' << uint32(maxl)
                << ',' << wp->GetFlags() << ",'" << wp->GetName() << "','" << wp->FormatLinks() << "'),";
        });
        std::string val_str = ss.str();
        val_str.resize(val_str.size() - 1u);
        trans->Append(val_str.c_str());
        WorldDatabase.CommitTransaction(trans);

        handler->SendSysMessage("Reid complete.");

        return true;
    }

    static bool HandleNpcBotDebugWBEquipsCommand(ChatHandler* handler, Optional<uint32> bc, Optional<uint32> bs, Optional<EXACT_SEQUENCE("ids")> ids)
    {
        const std::array<char const*, BOT_INVENTORY_SIZE> snames {
            "MHAND", "OHAND", "RANGED", "HEAD", "SHOULDERS", "CHEST", "WAIST", "LEGS", "FEET", "WRIST", "HANDS", "BACK", "BODY", "FINGER", "FINGER", "TRINKET", "TRINKET", "NECK"
        };

        if (!bc || !bs || *bc >= BOT_CLASS_END || *bs >= BOT_INVENTORY_SIZE)
        {
            handler->SendSysMessage("Syntax: .npcbot debug wbequips #class #slot #['ids']");
            handler->SendSysMessage("List all generated equip templates (or just ids) for wandering bots of class #botclass");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::ostringstream ss;
        for (uint32 c = BOT_CLASS_WARRIOR; c < BOT_CLASS_END; ++c)
        {
            if (c != *bc)
                continue;
            std::string cname, dummy;
            GetBotClassNameAndColor(c, dummy, cname);
            ItemPerBotClassMap const& bot_gear = BotDataMgr::GetWanderingBotsSortedGearMap();
            ItemPerSlot const& ips_arr = bot_gear.at(c);
            for (uint32 s = BOT_SLOT_MAINHAND; s < BOT_INVENTORY_SIZE; ++s)
            {
                if (s != *bs)
                    continue;
                ItemLeveledArr const& il_arr = ips_arr[s];
                for (uint32 lstep = 0; lstep < LEVEL_STEPS; ++lstep)
                {
                    uint32 minlvl = std::max<uint32>(lstep * ITEM_SORTING_LEVEL_STEP, 1);
                    uint32 maxlvl = (lstep + 1) * ITEM_SORTING_LEVEL_STEP - 1;
                    ItemIdVector const& vec = il_arr[lstep];
                    ss << cname << ' ' << snames[s] << ' ' << minlvl << '-' << maxlvl << " (" << uint32(vec.size()) << "):";
                    for (uint32 itemId : vec)
                    {
                        if (ids != std::nullopt)
                            ss << "\n " << itemId;
                        else
                        {
                            ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
                            if (!proto)
                                ss << "\n [Invalid] " << itemId;
                            else
                            {
                                ss << "\n |c";
                                switch (proto->Quality)
                                {
                                    case ITEM_QUALITY_POOR:     ss << "ff9d9d9d"; break;  //GREY
                                    case ITEM_QUALITY_NORMAL:   ss << "ffffffff"; break;  //WHITE
                                    case ITEM_QUALITY_UNCOMMON: ss << "ff1eff00"; break;  //GREEN
                                    case ITEM_QUALITY_RARE:     ss << "ff0070dd"; break;  //BLUE
                                    case ITEM_QUALITY_EPIC:     ss << "ffa335ee"; break;  //PURPLE
                                    case ITEM_QUALITY_LEGENDARY:ss << "ffff8000"; break;  //ORANGE
                                    case ITEM_QUALITY_ARTIFACT: ss << "ffe6cc80"; break;  //LIGHT YELLOW
                                    case ITEM_QUALITY_HEIRLOOM: ss << "ffe6cc80"; break;  //LIGHT YELLOW
                                    default:                    ss << "ff000000"; break;  //UNK BLACK
                                }
                                ss << "|Hitem:" << uint32(proto->ItemId) << ":0:0:0:0:0:0:0:0:0|h[" << proto->Name1 << "]|h|r";
                            }
                        }
                    }
                    handler->PSendSysMessage("{}", ss.str());
                    ss.str("");
                }
            }
        }

        return true;
    }

    static bool HandleNpcBotDebugGuidsCommand(ChatHandler* handler)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
            target = handler->GetPlayer();

        std::ostringstream gss;
        gss << target->GetName() << "'s guids:"
            << "\n  own guid:\n" << target->GetGUID().ToString()
            << "\n  combo target guid:\n" << target->GetComboTargetGUID().ToString()
            << "\n  pet guid:\n" << target->GetPetGUID().ToString()
            << "\n  minion guid:\n" << target->GetMinionGUID().ToString()
            << "\n  critter guid:\n" << target->GetCritterGUID().ToString()
            << "\n  charmed guid:\n" << target->GetCharmGUID().ToString()
            << "\n  charmer guid:\n" << target->GetCharmerGUID().ToString()
            << "\n  creator guid:\n" << target->GetCreatorGUID().ToString()
            << "\n  creator2 guid:\n" << (target->GetCreator() ? target->GetCreator()->GetGUID().ToString() : std::string{})
            << "\n  owner guid:\n" << target->GetOwnerGUID().ToString();

        handler->SendSysMessage(gss.str());
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

        handler->SendSysMessage(ostr.str());
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

        handler->SendSysMessage(sstr.str());
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

    static bool HandleNpcBotDebugModelCommand(ChatHandler* handler, Optional<uint32> setId)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        Unit* target = owner->GetSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage("No target selected");
            return true;
        }

        if (setId)
            last_model_id = *setId;

        handler->PSendSysMessage("Setting model {}...", last_model_id);
        target->SetDisplayId(last_model_id++);

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
        if (!file_str || (!force_kick && sWorldSessionMgr->GetPlayerCount() > 0))
        {
            handler->SendSysMessage(".npcbot dump load");
            handler->SendSysMessage("Imports NPCBots from a backup SQL file created with '.npcbot dump write' command.");
            handler->SendSysMessage("Syntax: .npcbot dump load #file_name [#force_kick_all]");
            if (!force_kick && sWorldSessionMgr->GetPlayerCount() > 0)
                handler->SendSysMessage("Make sure no players are online before importing.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        sWorldSessionMgr->SetPlayerAmountLimit(0);
        if (force_kick)
            sWorldSessionMgr->KickAll();

        //omit file ext if needed
        if (file_str->find('.') == std::string::npos)
            *file_str += ".sql";

        switch (NPCBotsDump().Load(*file_str))
        {
            case BOT_DUMP_SUCCESS:
                handler->SendSysMessage("Import successful.");
                handler->SendSysMessage("Server will be restarted now to prevent DB corruption.");
                sWorld->ShutdownServ(4, SHUTDOWN_MASK_RESTART, 70);
                break;
            case BOT_DUMP_FAIL_FILE_NOT_EXIST:
                handler->PSendSysMessage("Can't open {} or the file doesn't exist!", *file_str);
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_FILE_CORRUPTED:
                handler->SendSysMessage("File data integrity check failed!");
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_DATA_OCCUPIED:
                handler->PSendSysMessage("Table data contained in {} overlaps with existing table entries!", *file_str);
                handler->SetSentErrorMessage(true);
                return false;
            default:
                handler->SendSysMessage("Error!");
                handler->SetSentErrorMessage(true);
                return false;
        }

        return true;
    }

    static bool HandleNpcBotDumpWriteCommand(ChatHandler* handler, Optional<std::string> file_str)
    {
        if (!file_str)
        {
            handler->SendSysMessage(".npcbot dump write\nExports spawned NPCBots into a SQL file.\nSyntax: .npcbot dump write #file_name");
            handler->SetSentErrorMessage(true);
            return false;
        }

        //omit file ext if needed
        if (file_str->find('.') == std::string::npos)
            *file_str += ".sql";

        switch (NPCBotsDump().Write(*file_str))
        {
            case BOT_DUMP_SUCCESS:
                handler->SendSysMessage("Export successful.");
                break;
            case BOT_DUMP_FAIL_FILE_ALREADY_EXISTS:
                handler->PSendSysMessage("File {} already exists!", *file_str);
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_CANT_WRITE_TO_FILE:
                handler->SendSysMessage("Can't open file for write!");
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_INCOMPLETE:
                handler->SendSysMessage("Export was not completed!");
                handler->SetSentErrorMessage(true);
                return false;
            default:
                handler->SendSysMessage("Error!");
                handler->SetSentErrorMessage(true);
                return false;
        }

        return true;
    }

    static bool HandleNpcBotOrderPullCommand(ChatHandler* handler, Optional<std::string> bot_name, Optional<std::string_view> target_token)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot() || !bot_name)
        {
            handler->SendSysMessage(".npcbot order pull #bot_name #[target_token]");
            handler->SendSysMessage("Orders bot to pull target immediately");
            return true;
        }

        if (owner->GetBotMgr()->IsPartyInCombat(false))
        {
            handler->SendSysMessage("Can't do that while in combat!");
            return true;
        }

        for (std::decay_t<decltype(*bot_name)>::size_type i = 0u; i < bot_name->size(); ++i)
            if ((*bot_name)[i] == '_')
                (*bot_name)[i] = ' ';

        Creature* bot = owner->GetBotMgr()->GetBotByName(*bot_name);
        if (bot)
        {
            if (!bot->IsInWorld())
            {
                handler->PSendSysMessage("Bot {} is not found!", *bot_name);
                return true;
            }
            if (!bot->IsAlive())
            {
                handler->PSendSysMessage("{} is dead!", bot->GetName());
                return true;
            }
            if (!bot->GetBotAI()->HasRole(BOT_ROLE_DPS) || bot->GetVictim() || bot->IsInCombat() || !bot->getAttackers().empty())
            {
                handler->PSendSysMessage("{} cannot pull target! Must be idle and have DPS role", bot->GetName());
                return true;
            }
        }
        else
        {
            auto const& class_name = *bot_name;
            for (auto const c : class_name)
            {
                if (!std::islower(c))
                {
                    handler->SendSysMessage("Bot class name must be in lower case!");
                    return true;
                }
            }

            uint8 bot_class = BotMgr::BotClassByClassName(class_name);
            if (bot_class == BOT_CLASS_NONE)
            {
                handler->PSendSysMessage("Unknown bot name or class {}!", class_name);
                return true;
            }

            std::list<Creature*> cBots = owner->GetBotMgr()->GetAllBotsByClass(bot_class);

            if (cBots.empty())
            {
                handler->PSendSysMessage("No bots of class {} found!", bot_class);
                return true;
            }

            bot = cBots.size() == 1 ? cBots.front() : Bcore::Containers::SelectRandomContainerElement(cBots);

            if (!bot)
            {
                handler->SendSysMessage("None of {} found bots can use pull yet!", cBots.size());
                return true;
            }
        }

        ObjectGuid target_guid = ObjectGuid::Empty;
        bool token_valid = true;
        if (!target_token || target_token == "mytarget")
            target_guid = owner->GetTarget();
        else if (Group const* group = owner->GetGroup())
        {
            if (target_token == "star")
                target_guid = group->GetTargetIcons()[0];
            else if (target_token == "circle")
                target_guid = group->GetTargetIcons()[1];
            else if (target_token == "diamond")
                target_guid = group->GetTargetIcons()[2];
            else if (target_token == "triangle")
                target_guid = group->GetTargetIcons()[3];
            else if (target_token == "moon")
                target_guid = group->GetTargetIcons()[4];
            else if (target_token == "square")
                target_guid = group->GetTargetIcons()[5];
            else if (target_token == "cross")
                target_guid = group->GetTargetIcons()[6];
            else if (target_token == "skull")
                target_guid = group->GetTargetIcons()[7];
            else if (target_token->size() == 1u && std::isdigit(target_token->front()))
            {
                uint8 digit = static_cast<uint8>(std::stoi(std::string(*target_token)));
                switch (digit)
                {
                    case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
                        target_guid = group->GetTargetIcons()[digit - 1];
                        break;
                    default:
                        token_valid = false;
                        break;
                }
            }
            else
                token_valid = false;
        }
        else
            token_valid = false;

        if (!token_valid)
        {
            handler->PSendSysMessage("Invalid target token '{}'!", *target_token);
            handler->SendSysMessage("Valid target tokens:\n    '','mytarget', "
                "'star','1', 'circle','2', 'diamond','3', 'triangle','4', 'moon','5', 'square','6', 'cross','7', 'skull','8'"
                "\nNote that target icons tokens are only available while in group");
            return true;
        }

        Unit* target = target_guid ? ObjectAccessor::GetUnit(*owner, target_guid) : nullptr;
        if (!target || !bot->FindMap() || target->FindMap() != bot->FindMap())
        {
            handler->PSendSysMessage("Invalid target '{}'!", target ? target->GetName().c_str() : "unknown");
            return true;
        }

        bot_ai::BotOrder order(BOT_ORDER_PULL);
        order.params.pullParams.targetGuid = target_guid.GetRawValue();

        if (bot->GetBotAI()->AddOrder(std::move(order)))
        {
            if (DEBUG_BOT_ORDERS)
                handler->PSendSysMessage("Order given: {}: pull {}", bot->GetName(), target ? target->GetName().c_str() : "unknown");
        }
        else
        {
            if (DEBUG_BOT_ORDERS)
                handler->PSendSysMessage("Order failed: {}: pull {}", bot->GetName(), target ? target->GetName().c_str() : "unknown");
        }

        return true;
    }

    static bool HandleNpcBotOrderCastCommand(ChatHandler* handler, Optional<std::string> bot_name, Optional<std::string> spell_name, Optional<std::string_view> target_token)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot() || !bot_name || !spell_name)
        {
            handler->SendSysMessage(".npcbot order cast #bot_name #spell_underscored_name #[target_token]");
            handler->SendSysMessage("Orders bot to cast a spell immediately");
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
                handler->PSendSysMessage("Bot {} is not found!", *bot_name);
                return true;
            }
            if (!bot->IsAlive())
            {
                handler->PSendSysMessage("{} is dead!", bot->GetName());
                return true;
            }

            base_spell = bot->GetBotAI()->GetBaseSpell(*spell_name, handler->GetSessionDbcLocale());
            if (!base_spell)
            {
                handler->PSendSysMessage("{} doesn't have spell named '{}'!", bot->GetName(), *spell_name);
                return true;
            }
            if (!canBotUseSpell(bot, base_spell))
            {
                handler->PSendSysMessage("{}'s {} is not ready yet!", bot->GetName(), sSpellMgr->GetSpellInfo(base_spell)->SpellName[handler->GetSessionDbcLocale()]);
                return true;
            }
        }
        else
        {
            auto const& class_name = *bot_name;
            for (auto const c : class_name)
            {
                if (!std::islower(c))
                {
                    handler->SendSysMessage("Bot class name must be in lower case!");
                    return true;
                }
            }

            uint8 bot_class = BotMgr::BotClassByClassName(class_name);
            if (bot_class == BOT_CLASS_NONE)
            {
                handler->PSendSysMessage("Unknown bot name or class {}!", class_name);
                return true;
            }

            std::list<Creature*> cBots = owner->GetBotMgr()->GetAllBotsByClass(bot_class);

            if (cBots.empty())
            {
                handler->PSendSysMessage("No bots of class {} found!", bot_class);
                return true;
            }

            uint32 found_bots_count = static_cast<uint32>(cBots.size());

            for (Creature const* fbot : cBots)
            {
                base_spell = fbot->GetBotAI()->GetBaseSpell(*spell_name, handler->GetSessionDbcLocale());
                if (base_spell)
                    break;
            }

            if (!base_spell)
            {
                handler->PSendSysMessage("None of {} found bots have spell named '{}'!", found_bots_count, *spell_name);
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

            bot = ccBots.empty() ? nullptr : ccBots.size() == 1 ? ccBots.front() : Bcore::Containers::SelectRandomContainerElement(ccBots);
            if (!bot)
                bot = cBots.empty() ? nullptr : cBots.size() == 1 ? cBots.front() : Bcore::Containers::SelectRandomContainerElement(cBots);

            if (!bot)
            {
                handler->PSendSysMessage("None of {} found bots can use {} yet!", found_bots_count, *spell_name);
                return true;
            }
        }

        ObjectGuid target_guid = ObjectGuid::Empty;
        bool token_valid = true;
        if (!target_token || target_token == "bot" || target_token == "self")
            target_guid = bot->GetGUID();
        else if (target_token == "me" || target_token == "master")
            target_guid = owner->GetGUID();
        else if (target_token == "mypet")
            target_guid = owner->GetPetGUID();
        else if (target_token == "myvehicle")
            target_guid = owner->GetVehicle() ? owner->GetVehicleBase()->GetGUID() : ObjectGuid::Empty;
        else if (target_token == "target")
            target_guid = bot->GetTarget();
        else if (target_token == "mytarget")
            target_guid = owner->GetTarget();
        else if (Group const* group = owner->GetGroup())
        {
            if (target_token == "star")
                target_guid = group->GetTargetIcons()[0];
            else if (target_token == "circle")
                target_guid = group->GetTargetIcons()[1];
            else if (target_token == "diamond")
                target_guid = group->GetTargetIcons()[2];
            else if (target_token == "triangle")
                target_guid = group->GetTargetIcons()[3];
            else if (target_token == "moon")
                target_guid = group->GetTargetIcons()[4];
            else if (target_token == "square")
                target_guid = group->GetTargetIcons()[5];
            else if (target_token == "cross")
                target_guid = group->GetTargetIcons()[6];
            else if (target_token == "skull")
                target_guid = group->GetTargetIcons()[7];
            else if (target_token->size() == 1u && std::isdigit(target_token->front()))
            {
                uint8 digit = static_cast<uint8>(std::stoi(std::string(*target_token)));
                switch (digit)
                {
                    case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
                        target_guid = group->GetTargetIcons()[digit - 1];
                        break;
                    default:
                        token_valid = false;
                        break;
                }
            }
            else
                token_valid = false;
        }
        else
            token_valid = false;

        if (!token_valid)
        {
            handler->PSendSysMessage("Invalid target token '{}'!", *target_token);
            handler->SendSysMessage("Valid target tokens:\n    '','bot','self', 'me','master', 'mypet', 'myvehicle', 'target', 'mytarget', "
                "'star','1', 'circle','2', 'diamond','3', 'triangle','4', 'moon','5', 'square','6', 'cross','7', 'skull','8'"
                "\nNote that target icons tokens are only available while in group");
            return true;
        }

        Unit* target = target_guid ? ObjectAccessor::GetUnit(*owner, target_guid) : nullptr;
        if (!target || !bot->FindMap() || target->FindMap() != bot->FindMap())
        {
            handler->PSendSysMessage("Invalid target '{}'!", target ? target->GetName().c_str() : "unknown");
            return true;
        }

        bot_ai::BotOrder order(BOT_ORDER_SPELLCAST);
        order.params.spellCastParams.baseSpell = base_spell;
        order.params.spellCastParams.targetGuid = target_guid.GetRawValue();

        if (bot->GetBotAI()->AddOrder(std::move(order)))
        {
            if (DEBUG_BOT_ORDERS)
                handler->PSendSysMessage("Order given: {}: {} on {}", bot->GetName(),
                    sSpellMgr->GetSpellInfo(base_spell)->SpellName[handler->GetSessionDbcLocale()], target ? target->GetName().c_str() : "unknown");
        }
        else
        {
            if (DEBUG_BOT_ORDERS)
                handler->PSendSysMessage("Order failed: {}: {} on {}", bot->GetName(),
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
                        //handler->PSendSysMessage("Removing {} from {}", bot->GetName(), bot->GetVehicle()->GetBase()->GetName());
                        bot->ExitVehicle();
                        //bot->BotStopMovement();
                    }
                }
            }
            return true;
        }

        handler->SendSysMessage(".npcbot eject");
        handler->SendSysMessage("Removes your bots from selected vehicle, or, all bots from any vehicles if no vehicle selected");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotFollowDistanceCommand(ChatHandler* handler, Optional<int32> dist)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot() || !dist)
        {
            handler->SendSysMessage(".npcbot distance #[attack] #newdist");
            handler->SendSysMessage("Sets follow / attack distance for bots");
            return true;
        }

        uint8 newdist = uint8(std::min<int32>(std::max<int32>(*dist, 0), 100));
        owner->GetBotMgr()->SetBotFollowDist(newdist);

        handler->PSendSysMessage("Bots' follow distance is set to {}", uint32(newdist));
        return true;
    }

    static bool HandleNpcBotAttackDistanceShortCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot distance attack short");
            handler->SendSysMessage("Sets attack distance for bots");
            return true;
        }

        owner->GetBotMgr()->SetBotAttackRangeMode(BOT_ATTACK_RANGE_SHORT);

        handler->SendSysMessage("Bots' attack distance is set to 'short'");
        return true;
    }

    static bool HandleNpcBotAttackDistanceLongCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot distance attack long");
            handler->SendSysMessage("Sets attack distance for bots");
            return true;
        }

        owner->GetBotMgr()->SetBotAttackRangeMode(BOT_ATTACK_RANGE_LONG);

        handler->SendSysMessage("Bots' attack distance is set to 'long'");
        return true;
    }

    static bool HandleNpcBotAttackDistanceExactCommand(ChatHandler* handler, Optional<int32> dist)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot() || !dist)
        {
            handler->SendSysMessage(".npcbot distance attack #newdist");
            handler->SendSysMessage("Sets attack distance for bots");
            return true;
        }

        uint8 newdist = uint8(std::min<int32>(std::max<int32>(*dist, 0), 50));
        owner->GetBotMgr()->SetBotAttackRangeMode(BOT_ATTACK_RANGE_EXACT, newdist);

        handler->PSendSysMessage("Bots' attack distance is set to {}", uint32(newdist));
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
            handler->SendSysMessage("Removes your owned npcbots from world temporarily");
            //handler->SendSysMessage("You have no bots!");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (!owner->IsAlive())
        {
            handler->SendNotification("You are dead");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat(false))
        {
            handler->SendNotification(LANG_YOU_IN_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!owner->GetBotMgr()->GetBotsHidden())
        {
            owner->GetBotMgr()->SetBotsHidden(true);
            handler->SendSysMessage("Bots hidden");
        }
        return true;
    }

    static bool HandleNpcBotUnhideCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot unhide | show");
            handler->SendSysMessage("Returns your temporarily hidden bots back");
            //handler->SendSysMessage("You have no bots!");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (!owner->IsAlive())
        {
            handler->SendNotification("You are dead");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat(true))
        {
            handler->SendNotification("You can't do that while in PvP combat");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (owner->GetBotMgr()->GetBotsHidden())
        {
            owner->GetBotMgr()->SetBotsHidden(false);
            handler->SendSysMessage("Bots unhidden");
        }
        return true;
    }

    static bool HandleNpcBotFixCommand(ChatHandler* handler, Optional<Variant<std::string_view, uint32>> bot_id_or_name)
    {
        Creature const* target = handler->getSelectedCreature();

        uint32 bot_id;
        if (target && target->IsNPCBot())
            bot_id = target->GetEntry();
        else if (bot_id_or_name)
        {
            if (bot_id_or_name->holds_alternative<uint32>())
                bot_id = bot_id_or_name->get<uint32>();
            else if (Creature const* fbot = BotDataMgr::FindBot(bot_id_or_name->get<std::string_view>(), LocaleConstant(handler->GetSessionDbLocaleIndex())))
            {
                target = fbot;
                bot_id = target->GetEntry();
            }
            else
            {
                char* cre_id = handler->extractKeyFromLink((char*)bot_id_or_name->get<std::string_view>().data(), "Hcreature_entry");
                bot_id = uint32(atoi(cre_id));
            }
        }
        else if (target)
        {
            handler->SendSysMessage("You must select a npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }
        else
        {
            handler->SendSysMessage(".npcbot fix #[id | name | link | <selection>]");
            handler->SendSysMessage("Attempts to fix different bot's unit states and ai mishaps which stall its normal function");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature const* bot = target ? target : BotDataMgr::FindBot(bot_id);
        if (!bot)
        {
            handler->PSendSysMessage("NpcBot {} is not found!", bot_id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        NpcBotData const* bot_data = BotDataMgr::SelectNpcBotData(bot_id);
        Player* owner = !bot->IsFreeBot() ? bot->GetBotOwner() : nullptr;
        Player* tickler = handler->GetPlayer();

        if (!tickler->IsGameMaster())
        {
            handler->SendSysMessage("Must be in GM mode to use this command!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage("Trying to fix bot {} ({}) owned by {} ({})", bot->GetName(), bot_id,
            owner ? owner->GetName().c_str() : "Unknown", owner ? owner->GetGUID().GetCounter() : bot_data->owner);

        bot->GetBotAI()->ReceiveEmote(tickler, TEXT_EMOTE_TICKLE);
        return true;
    }

    static bool HandleNpcBotKillCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        ObjectGuid guid = owner->GetTarget();
        if (!guid || !owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot kill | suicide");
            handler->SendSysMessage("Makes your npcbot just drop dead. If you select yourself ALL your bots will die");
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

        handler->SendSysMessage("You must select one of your bots or yourself");
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
            handler->PSendSysMessage("NpcBot {} is not found!", *creatureId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_APPEARING_AT, bot->GetName());

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
            chandler->SendSysMessage("Makes selected/named bot(s) wait 30 sec for your next DEST spell, assume that position and hold it");
            chandler->SendSysMessage("Max distance is 70 yds");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Your next dest spell will send {} bot(s) to position...", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Your next dest spell will send {} to position...", name_or_count.get<std::string>());
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
            handler->PSendSysMessage("Unable to send any of {} bots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToLastCommand(ChatHandler* handler, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto last #names...");
            chandler->SendSysMessage("Makes selected/named bot(s) assume previous position they were sent from");
            chandler->SendSysMessage("This will cancel current sendto await state");
            chandler->SendSysMessage("Max distance is 70 yds");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Moving {} bot(s) to previous position...", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Moving {} to previous position...", name_or_count.get<std::string>());
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
            handler->PSendSysMessage("Unable to send any of {}u bots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToPointSetCommand(ChatHandler* handler, Optional<uint32> point_id, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto point set #number #names...");
            chandler->SendSysMessage("Marks selected/named bots' current position as send point by #number");
            chandler->PSendSysMessage("Point number must be in range 1 ... {}", uint32(MAX_SEND_POINTS));
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [&](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Marked send point {} for {} bot(s)", *point_id, name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Marked send point {} for {}", *point_id, name_or_count.get<std::string>());
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
            handler->PSendSysMessage("Unable to mark send point for any of {} bots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToPointCommand(ChatHandler* handler, Optional<uint32> point_id, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto point #number #names...");
            chandler->SendSysMessage("Makes selected/named bot(s) assume previously set point by #number");
            chandler->SendSysMessage("This will cancel current sendto await state");
            chandler->SendSysMessage("Max distance is 70 yds");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [&](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Moving {} bot(s) to point {}...", name_or_count.get<uint32>(), *point_id);
            else
                chandler->PSendSysMessage("Moving {} to point {}...", name_or_count.get<std::string>(), *point_id);
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
            handler->PSendSysMessage("Unable to send any of {} bots!", uint32(names->size()));
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
            handler->SendSysMessage("Forces npcbots to move directly on your position. Select a npcbot you want to move or select yourself to move all bots");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat(false))
        {
            handler->SendNotification(LANG_YOU_IN_COMBAT);
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

        handler->SendSysMessage("You must select one of your bots or yourself");
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
            handler->SendSysMessage("Forces all your npcbots to teleport to your position");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (!owner->IsAlive())
        {
            handler->SendNotification("You are dead");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->GetBotsHidden())
        {
            handler->SendNotification("You can't do that while bots are hidden");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat(true))
        {
            handler->SendNotification("You can't do that while in PvP combat");
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
            handler->SendSysMessage("This is a debug command");
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

        handler->PSendSysMessage("Toggling flag {} on {}", setFlags, unit->GetName());
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
            handler->SendSysMessage("Sets faction for selected npcbot (saved in DB)");
            handler->SendSysMessage("Use 'a', 'h', 'm' or 'f' as argument to set faction to alliance, horde, monsters (hostile to all) or friends (friendly to all)");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot() || !bot->IsFreeBot())
        {
            handler->SendSysMessage("You must select uncontrolled npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 factionId = 0;

        if ((*factionStr)[0] == 'a')
            factionId = 1802; //Alliance
        else if ((*factionStr)[0] == 'h')
            factionId = 1801; //Horde
        else if ((*factionStr)[0] == 'm')
            factionId = FACTION_TEMPLATE_NEUTRAL_HOSTILE; //Monsters
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

        handler->PSendSysMessage("{}'s faction set to {}", bot->GetName(), factionId);
        return true;
    }

    static bool HandleNpcBotSetOwnerCommand(ChatHandler* handler, Optional<std::string> charVal)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot || !charVal)
        {
            handler->SendSysMessage(".npcbot set owner #guid | #name");
            handler->SendSysMessage("Binds selected npcbot to new player owner using guid or name and updates owner in DB");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot() || bot->GetBotAI()->IsWanderer())
        {
            handler->SendSysMessage("You must select a non-wandering npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (bot->GetBotAI()->GetBotOwnerGuid())
        {
            handler->SendSysMessage("This npcbot already has owner");
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
            handler->SendSysMessage("Player not found");
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &guidlow);
        bot->GetBotAI()->ReinitOwner();
        //bot->GetBotAI()->Reset();

        handler->PSendSysMessage("{}'s new owner is {} (guidlow: {})", bot->GetName(), characterName, guidlow);
        return true;
    }

    static bool HandleNpcBotSetSpecCommand(ChatHandler* handler, Optional<uint8> spec)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot || !spec)
        {
            handler->SendSysMessage(".npcbot set spec #specnumber");
            handler->SendSysMessage("Changes talent spec for selected npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot())
        {
            handler->SendSysMessage("You must select a npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!bot_ai::IsValidSpecForClass(bot->GetBotClass(), *spec))
        {
            handler->PSendSysMessage("{} is not a valid spec for bot class {}!",
                bot_ai::LocalizedNpcText(chr, bot_ai::TextForSpec(*spec)), uint32(bot->GetBotClass()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        bot->GetBotAI()->SetSpec(*spec);

        handler->PSendSysMessage("{}'s new spec is {}", bot->GetName(), uint32(*spec));
        return true;
    }

    static bool HandleNpcBotLookupCommand(ChatHandler* handler, Optional<uint8> botclass, Optional <bool> unspawned, Optional<uint8> teamid)
    {
        //this is just a modified '.lookup creature' command
        if (!botclass)
        {
            handler->SendSysMessage(".npcbot lookup #class #[not_spawned_only] #[team_id]");
            handler->SendSysMessage("Looks up npcbots by #class, and returns all matches with their creature ID's");
            handler->SendSysMessage("If #not_spawned_only is set to 1 shows only bots which don't exist in world");
            handler->SendSysMessage("If #team_id is provided, will also filter by team: Alliance = 0, Horde = 1, Neutral = 2");
            handler->PSendSysMessage("BOT_CLASS_WARRIOR = {}", uint32(BOT_CLASS_WARRIOR));
            handler->PSendSysMessage("BOT_CLASS_PALADIN = {}", uint32(BOT_CLASS_PALADIN));
            handler->PSendSysMessage("BOT_CLASS_HUNTER = {}", uint32(BOT_CLASS_HUNTER));
            handler->PSendSysMessage("BOT_CLASS_ROGUE = {}", uint32(BOT_CLASS_ROGUE));
            handler->PSendSysMessage("BOT_CLASS_PRIEST = {}", uint32(BOT_CLASS_PRIEST));
            handler->PSendSysMessage("BOT_CLASS_DEATH_KNIGHT = {}", uint32(BOT_CLASS_DEATH_KNIGHT));
            handler->PSendSysMessage("BOT_CLASS_SHAMAN = {}", uint32(BOT_CLASS_SHAMAN));
            handler->PSendSysMessage("BOT_CLASS_MAGE = {}", uint32(BOT_CLASS_MAGE));
            handler->PSendSysMessage("BOT_CLASS_WARLOCK = {}", uint32(BOT_CLASS_WARLOCK));
            handler->PSendSysMessage("BOT_CLASS_DRUID = {}", uint32(BOT_CLASS_DRUID));
            handler->PSendSysMessage("BOT_CLASS_BLADEMASTER = {}", uint32(BOT_CLASS_BM));
            handler->PSendSysMessage("BOT_CLASS_SPHYNX = {}", uint32(BOT_CLASS_SPHYNX));
            handler->PSendSysMessage("BOT_CLASS_ARCHMAGE = {}", uint32(BOT_CLASS_ARCHMAGE));
            handler->PSendSysMessage("BOT_CLASS_DREADLORD = {}", uint32(BOT_CLASS_DREADLORD));
            handler->PSendSysMessage("BOT_CLASS_SPELLBREAKER = {}", uint32(BOT_CLASS_SPELLBREAKER));
            handler->PSendSysMessage("BOT_CLASS_DARK_RANGER = {}", uint32(BOT_CLASS_DARK_RANGER));
            handler->PSendSysMessage("BOT_CLASS_NECROMANCER = {}", uint32(BOT_CLASS_NECROMANCER));
            handler->PSendSysMessage("BOT_CLASS_SEA_WITCH = {}", uint32(BOT_CLASS_SEA_WITCH));
            handler->PSendSysMessage("BOT_CLASS_CRYPT_LORD = {}", uint32(BOT_CLASS_CRYPT_LORD));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (botclass == BOT_CLASS_NONE || botclass >= BOT_CLASS_END)
        {
            handler->PSendSysMessage("Unknown bot class {}", uint32(*botclass));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (teamid && *teamid > uint8(TEAM_NEUTRAL))
        {
            handler->PSendSysMessage("Unknown team {}", uint32(*teamid));
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage("Looking for bots of class {}...", uint32(*botclass));

        uint8 localeIndex = handler->GetSessionDbLocaleIndex();
        CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
        typedef std::vector<BotInfo> BotList;
        BotList botlist;
        for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
        {
            uint32 id = itr->second.Entry;

            if (id == BOT_ENTRY_MIRROR_IMAGE_BM)
                continue;

            NpcBotExtras const* _botExtras = BotDataMgr::SelectNpcBotExtras(id);
            if (!_botExtras || _botExtras->bclass != botclass)
                continue;

            if (unspawned && *unspawned && BotDataMgr::SelectNpcBotData(id))
                continue;

            uint8 race = _botExtras->race;

            if (teamid)
            {
                uint32 faction = BotDataMgr::GetDefaultFactionForBotRaceClass(_botExtras->bclass, race);
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
                case RACE_HUMAN:        raceName = "Human";     break;
                case RACE_ORC:          raceName = "Orc";       break;
                case RACE_DWARF:        raceName = "Dwarf";     break;
                case RACE_NIGHTELF:     raceName = "Night Elf"; break;
                case RACE_UNDEAD_PLAYER:raceName = "Forsaken";  break;
                case RACE_TAUREN:       raceName = "Tauren";    break;
                case RACE_GNOME:        raceName = "Gnome";     break;
                case RACE_TROLL:        raceName = "Troll";     break;
                case RACE_BLOODELF:     raceName = "Blood Elf"; break;
                case RACE_DRAENEI:      raceName = "Draenei";   break;
                case RACE_NONE:         raceName = "No Race";   break;
                default:                raceName = "Unknown";   break;
            }

            handler->PSendSysMessage("{} - |cffffffff|Hcreature_entry:{}|h[{}]|h|r {}", itr->id, itr->id, itr->name, raceName);
        }

        return true;
    }

    static bool HandeNpcBotCleanUpAndRemoval(ChatHandler* handler, Creature* bot, Player const* chr/* = nullptr*/)
    {
        Player const* botowner = bot->GetBotOwner()->ToPlayer();

        if (bot->GetBotAI()->HasRealEquipment())
        {
            ObjectGuid receiver =
                botowner ? botowner->GetGUID() :
                bot->GetBotAI()->GetBotOwnerGuid() != 0 ? ObjectGuid(HighGuid::Player, 0, bot->GetBotAI()->GetBotOwnerGuid()) :
                chr ? chr->GetGUID() : ObjectGuid::Empty;

            if (!botowner && chr && receiver != chr->GetGUID() && !sCharacterCache->HasCharacterCacheEntry(receiver))
                receiver = chr->GetGUID();

            if (receiver == ObjectGuid::Empty)
            {
                handler->PSendSysMessage("Cannot delete bot {} from console: has gear but no player to give it back to! Can only delete this bot in-game.", bot->GetName());
                return false;
            }
            if (bot->GetBotAI()->UnEquipAll(receiver, false) != BotEquipResult::BOT_EQUIP_RESULT_OK)
            {
                handler->PSendSysMessage("{} is unable to unequip some gear. Please remove equips manually first!", bot->GetName());
                return false;
            }
        }

        if (botowner)
            botowner->GetBotMgr()->RemoveBot(bot->GetGUID(), BOT_REMOVE_DISMISS);

        return true;
    }

    static bool HandleNpcBotFreeCommand(ChatHandler* handler)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot)
        {
            handler->SendSysMessage(".npcbot free");
            handler->SendSysMessage("Immediately cancels selected npcbot's ownership");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot() || !bot->GetBotAI()->GetBotOwnerGuid() || bot->IsTempBot())
        {
            handler->SendSysMessage("No owned npcbot selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 owner_guid = bot->GetBotAI()->GetBotOwnerGuid();
        Player const* botowner = bot->GetBotOwner()->ToPlayer();
        if (!HandeNpcBotCleanUpAndRemoval(handler, bot, chr))
        {
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint8 spec = bot_ai::SelectSpecForClass(bot->GetBotClass());
        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_SPEC, &spec);
        uint32 roleMask = bot_ai::DefaultRolesForClass(bot->GetBotClass(), spec);
        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_ROLES, &roleMask);

        if (!botowner)
        {
            uint32 newOwner = 0;
            BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &newOwner);

            if (Group* gr = bot->GetBotGroup())
                gr->RemoveMember(bot->GetGUID());

            bot->GetBotAI()->ResetBotAI(BOTAI_RESET_DISMISS);
        }

        handler->PSendSysMessage("Npcbot {} successfully freed, owner was {}", bot->GetName(), owner_guid);
        return true;
    }

    static bool HandleNpcBotDeleteCommand(ChatHandler* handler)
    {
        Player* chr = handler->GetSession()->GetPlayer();
        Unit* ubot = chr->GetSelectedUnit();
        if (!ubot)
        {
            handler->SendSysMessage(".npcbot delete");
            handler->SendSysMessage("Deletes selected npcbot spawn from world and DB");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = ubot->ToCreature();
        if (!bot || !bot->IsNPCBot())
        {
            handler->SendSysMessage("No npcbot selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (bot->GetBotAI()->IsWanderer())
        {
            BotDataMgr::DespawnWandererBot(bot->GetEntry());
            handler->PSendSysMessage("Wandering bot {} '{}' successfully deleted", bot->GetEntry(), bot->GetName());
            return true;
        }

        if (!HandeNpcBotCleanUpAndRemoval(handler, bot, chr))
        {
            handler->SetSentErrorMessage(true);
            return false;
        }

        bot->CombatStop();
        bot->GetBotAI()->Reset();
        bot->GetBotAI()->canUpdate = false;
        bot->DeleteFromDB();
        bot->AddObjectToRemoveList();

        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_ERASE);

        handler->PSendSysMessage("Npcbot {} successfully deleted", bot->GetName());
        return true;
    }

    static bool HandleNpcBotDeleteByIdCommand(ChatHandler* handler, Optional<uint32> creature_id)
    {
        if (!creature_id)
        {
            handler->SendSysMessage(".npcbot delete id");
            handler->SendSysMessage("Deletes npcbot spawn from world and DB using creature id");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature const* bot = BotDataMgr::FindBot(*creature_id);
        if (!bot)
        {
            handler->PSendSysMessage("npcbot {} not found!", *creature_id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (bot->GetBotAI()->IsWanderer())
        {
            BotDataMgr::DespawnWandererBot(bot->GetEntry());
            handler->PSendSysMessage("Wandering bot {} '{}' successfully deleted", bot->GetEntry(), bot->GetName());
            return true;
        }

        Player* chr = !handler->IsConsole() ? handler->GetSession()->GetPlayer() : nullptr;

        if (!HandeNpcBotCleanUpAndRemoval(handler, const_cast<Creature*>(bot), chr))
        {
            handler->SetSentErrorMessage(true);
            return false;
        }

        const_cast<Creature*>(bot)->CombatStop();
        bot->GetBotAI()->Reset();
        bot->GetBotAI()->canUpdate = false;
        const_cast<Creature*>(bot)->DeleteFromDB();
        const_cast<Creature*>(bot)->AddObjectToRemoveList();

        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_ERASE);

        handler->PSendSysMessage("Npcbot {} successfully deleted", bot->GetName());
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

        handler->PSendSysMessage("{} free npcbots deleted", count);
        return true;
    }

    static bool HandleNpcBotMoveCommand(ChatHandler* handler, Optional<std::string> creVal)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creature = handler->getSelectedCreature();

        if ((!creature && !creVal) || player->GetMap()->Instanceable())
        {
            handler->SendSysMessage(".npcbot move");
            handler->SendSysMessage("Moves npcbot to your location. World maps only");
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
            handler->PSendSysMessage("creature id {} does not exist!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!creInfo->IsNPCBot())
        {
            handler->PSendSysMessage("creature id {} is not a npcbot!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!BotDataMgr::SelectNpcBotData(id))
        {
            handler->PSendSysMessage("NpcBot {} is not spawned!", id);
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

        handler->PSendSysMessage("NpcBot {} (guid {}) was moved", id, lowguid);
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
                handler->SendSysMessage("Creates a new npcbot creature entry");
                handler->SendSysMessage("Syntax: .npcbot createnew #name #class ##race ##gender ##skin ##face ##hairstyle ##haircolor ##features ##[sound_variant = {{1,2,3}}]");
                handler->SendSysMessage("In case of class that cannot change appearance all extra arguments must be omitted");
                handler->SendSysMessage("Use '.npcbot createnew ranges' to print visuals constraints for all races");
            }
            handler->SetSentErrorMessage(true);
            return false;
        };
        static auto const ret_err_invalid_arg = [](ChatHandler* handler, char const* argname, Optional<uint8> argval = {}) {
            handler->PSendSysMessage("Invalid {}{}!", argname, argval ?  (" " + std::to_string(*argval)).c_str() : "");
            handler->SetSentErrorMessage(true);
            return false;
        };
        static auto const ret_err_invalid_args_for = [](ChatHandler* handler, char const* argname1, char const* argname2) {
            handler->PSendSysMessage("Invalid arguments for {} '{}'!", argname1, argname2);
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
            case BOT_CLASS_CRYPT_LORD:
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
        trans->Append("INSERT INTO creature_template SELECT * FROM creature_template_temp_npcbot_create");
        trans->Append("DROP TEMPORARY TABLE creature_template_temp_npcbot_create");
        if (modelId)
        {
            trans->Append("DROP TEMPORARY TABLE IF EXISTS creature_template_model_temp_npcbot_create");
            trans->Append("CREATE TEMPORARY TABLE creature_template_model_temp_npcbot_create ENGINE=MEMORY SELECT * FROM creature_template_model WHERE CreatureID = (SELECT entry FROM creature_template_npcbot_extras WHERE class = {} LIMIT 1)", uint32(*bclass));
            trans->Append("UPDATE creature_template_model_temp_npcbot_create SET CreatureID = {}, CreatureDisplayID = {}", newentry, modelId);
            trans->Append("INSERT INTO creature_template_model SELECT * FROM creature_template_model_temp_npcbot_create");
            trans->Append("DROP TEMPORARY TABLE creature_template_model_temp_npcbot_create");
        }
        trans->Append("REPLACE INTO creature_template_npcbot_extras VALUES ({}, {}, {})", newentry, uint32(*bclass), uint32(*race));
        trans->Append("REPLACE INTO creature_equip_template SELECT {}, 1, ids.itemID1, ids.itemID2, ids.itemID3, -1 FROM (SELECT itemID1, itemID2, itemID3 FROM creature_equip_template WHERE CreatureID = (SELECT entry FROM creature_template_npcbot_extras WHERE class = {} LIMIT 1)) ids", newentry, uint32(*bclass));
        if (can_change_appearance)
            trans->Append("REPLACE INTO creature_template_npcbot_appearance VALUES ({}, \"{}\", {}, {}, {}, {}, {}, {})",
                newentry, namestr, uint32(*gender), uint32(*skin), uint32(*face), uint32(*hairstyle), uint32(*haircolor), uint32(*features));
        WorldDatabase.DirectCommitTransaction(trans);

        handler->PSendSysMessage("New NPCBot {} (class {}) is created with entry {} and will be available for spawning after server restart.", namestr, uint32(*bclass), newentry);
        return true;
    }

    static bool HandleNpcBotSpawnCommand(ChatHandler* handler, Optional<std::string> creVal)
    {
        if (!creVal)
        {
            handler->SendSysMessage(".npcbot spawn");
            handler->SendSysMessage("Adds new npcbot spawn of given entry in world. You can shift-link the npc");
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
            handler->PSendSysMessage("creature {} does not exist!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!creInfo->IsNPCBot())
        {
            handler->PSendSysMessage("creature {} is not a npcbot!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (id == BOT_ENTRY_MIRROR_IMAGE_BM)
        {
            handler->PSendSysMessage("creature {} is a mirror image and cannot be spawned!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (BotDataMgr::SelectNpcBotData(id))
        {
            handler->PSendSysMessage("Npcbot {} already exists in `characters_npcbot` table!", id);
            handler->SendSysMessage("If you want to move this bot to a new location use '.npcbot move' command");
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
            handler->PSendSysMessage("Npcbot {} already exists in `creature` table!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* chr = handler->GetSession()->GetPlayer();

        if (/*Transport* trans = */chr->GetTransport())
        {
            handler->SendSysMessage("Cannot spawn bots on transport!");
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
            handler->SendSysMessage("Cannot spawn bots in instances!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* creature = new Creature();
        if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, chr->GetPhaseMaskForSpawn(), id, 0, chr->GetPositionX(), chr->GetPositionY(), chr->GetPositionZ(), chr->GetOrientation()))
        {
            delete creature;
            handler->SendSysMessage("Creature is not created!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        NpcBotExtras const* _botExtras = BotDataMgr::SelectNpcBotExtras(id);
        if (!_botExtras)
        {
            delete creature;
            handler->PSendSysMessage("No class/race data found for bot {}!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint8 bot_spec = bot_ai::SelectSpecForClass(_botExtras->bclass);
        BotDataMgr::AddNpcBotData(id, bot_ai::DefaultRolesForClass(_botExtras->bclass, bot_spec), bot_spec, creature->GetCreatureTemplate()->faction);

        creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), chr->GetPhaseMaskForSpawn());

        uint32 db_guid = creature->GetSpawnId();
        if (!creature->LoadBotCreatureFromDB(db_guid, map))
        {
            delete creature;
            handler->SendSysMessage("Cannot load npcbot from DB!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));

        handler->SendSysMessage("NpcBot successfully spawned");
        return true;
    }

    static bool HandleNpcBotSpawnedCommand(ChatHandler* handler)
    {
        std::unique_lock<std::shared_mutex> lock(*BotDataMgr::GetLock());
        NpcBotRegistry const& all_bots = BotDataMgr::GetExistingNPCBots();
        std::stringstream ss;
        if (all_bots.empty())
            ss << "No spawned bots found!";
        else
        {
            ss << "Found " << uint32(all_bots.size()) << " bots:";
            uint32 counter = 0;
            for (Creature const* bot : all_bots)
            {
                ++counter;

                std::string bot_color_str;
                std::string bot_class_str;
                GetBotClassNameAndColor(bot->GetBotClass(), bot_color_str, bot_class_str);

                AreaTableEntry const* zone = sAreaTableStore.LookupEntry(bot->GetBotAI()->GetLastZoneId() ? bot->GetBotAI()->GetLastZoneId() : bot->GetZoneId());
                std::string zone_name = zone ? zone->area_name[handler->GetSession() ? handler->GetSessionDbLocaleIndex() : 0] : "Unknown";

                ss << "\n" << counter << ") " << bot->GetEntry() << ": "
                    << bot->GetName() << " - |c" << bot_color_str << bot_class_str << "|r - "
                    << "level " << uint32(bot->GetLevel()) << " - \"" << zone_name << "\" - "
                    << (bot->IsFreeBot() ? bot->GetBotAI()->GetBotOwnerGuid() ? "inactive (owned)" : bot->GetBotAI()->IsWanderer() ? "wandering" : "free" : "active");
            }
        }

        handler->SendSysMessage(ss.str());
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
            ss << "No free bots found!";
        else
        {
            ss << "Found " << uint32(free_bots.size()) << " free bots:";
            uint32 counter = 0;
            for (Creature const* bot : free_bots)
            {
                ++counter;

                std::string bot_color_str;
                std::string bot_class_str;
                GetBotClassNameAndColor(bot->GetBotClass(), bot_color_str, bot_class_str);

                AreaTableEntry const* zone = sAreaTableStore.LookupEntry(bot->GetBotAI()->GetLastZoneId() ? bot->GetBotAI()->GetLastZoneId() : bot->GetZoneId());
                std::string zone_name = zone ? zone->area_name[handler->GetSession() ? handler->GetSessionDbLocaleIndex() : 0] : "Unknown";

                ss << '\n' << counter << ") " << bot->GetEntry() << ": "
                    << bot->GetName() << " - |c" << bot_color_str << bot_class_str << "|r - "
                    << "level " << uint32(bot->GetLevel()) << " - \"" << zone_name << '"'
                    << (bot->GetBotAI()->HasRealEquipment() ? " |cff00ffff(has equipment!)|r" : "");
            }
        }

        handler->SendSysMessage(ss.str());
        return true;
    }

    static bool HandleNpcBotGearScoreCommand(ChatHandler* handler, Optional<std::string_view> class_name)
    {
        Player* owner = handler->GetSession()->GetPlayer();
        Unit* unit = owner->GetSelectedUnit();
        if (!(unit && owner->GetBotMgr()->GetBot(unit->GetGUID())) && !class_name)
        {
            handler->SendSysMessage(".npcbot gs [#class_name]");
            handler->SendSysMessage("Lists GearScore of your selected NPCBot or all bots by #class_name");
            handler->SetSentErrorMessage(true);
            return false;
        }
        std::list<Creature*> bots;
        if (class_name)
        {
            std::string cname(*class_name);
            for (auto const c : cname)
            {
                if (!std::islower(c))
                {
                    handler->SendSysMessage("Bot class name must be in lower case!");
                    return true;
                }
            }

            uint8 bot_class = BotMgr::BotClassByClassName(cname);
            if (bot_class == BOT_CLASS_NONE)
            {
                handler->PSendSysMessage("Unknown bot name or class {}!", cname);
                return true;
            }

            bots = owner->GetBotMgr()->GetAllBotsByClass(bot_class);
            if (bots.empty())
            {
                handler->PSendSysMessage("No bots of class {} found!", uint32(bot_class));
                return true;
            }
        }
        else
            bots.push_back(unit->ToCreature());

        for (Creature const* bot : bots)
        {
            auto scores = bot->GetBotAI()->GetBotGearScores();
            handler->PSendSysMessage("{}'s GearScore total: {}, average: {}", bot->GetName(), uint32(scores.first), uint32(scores.second));
        }

        return true;
    }

    static bool HandleNpcBotUseOnBotSpellCommand(ChatHandler* handler, Optional<Variant<SpellInfo const*, std::vector<std::string>>> spell_name_parts_or_info)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* target = handler->getSelectedCreature();

        if (!spell_name_parts_or_info)
        {
            handler->SendSysMessage(".npcbot useonbot spell [#spell_name]");
            handler->SendSysMessage("Attempts to cast spell by name on selected bot, bypassing client restrictions");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!target || !target->IsNPCBot())
        {
            handler->SendSysMessage("No NPCBot selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 spellId = 0;
        std::string spellname;
        if (spell_name_parts_or_info->holds_alternative<SpellInfo const*>())
            spellId = spell_name_parts_or_info->get<SpellInfo const*>()->Id;
        else
        {
            auto const& vec = spell_name_parts_or_info->get<std::vector<std::string>>();
            spellname = vec[0];
            for (std::size_t i = 1; i < vec.size(); ++i)
                spellname += ' ' + vec[i];

            if (spellname.size() >= 2 && spellname[0] == '[' && spellname[spellname.size() - 1] == ']')
                spellname = spellname.substr(1, spellname.size() - 2);

            LocaleConstant locale = handler->GetSession()->GetSessionDbcLocale();
            for (auto const& kv : player->GetSpellMap())
            {
                if (kv.second->State != PLAYERSPELL_REMOVED && kv.second->Active)
                {
                    SpellInfo const* info = sSpellMgr->GetSpellInfo(kv.first);
                    if (info && info->SpellName[locale] == spellname)
                    {
                        spellId = info->Id;
                        break;
                    }
                }
            }
        }

        SpellInfo const* spellInfo = spellId ? sSpellMgr->AssertSpellInfo(spellId) : nullptr;
        if (!spellInfo)
        {
            handler->PSendSysMessage(LANG_COMMAND_NOSPELLFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // silently cancel
        if (spellInfo->IsPassive() || !spellInfo->IsPositive() || player->isPossessing() || player->IsInFlight())
            return true;

        SpellInfo const* actualSpellInfo = spellInfo->GetAuraRankForLevel(target->GetLevel());
        if (actualSpellInfo)
            spellInfo = actualSpellInfo;

        SpellCastTargets targets;
        targets.SetUnitTarget(target);
        Spell* spell = new Spell(player, spellInfo, TRIGGERED_NONE);
        spell->m_cast_count = 1;
        spell->prepare(&targets);

        return true;
    }

    static bool HandleNpcBotUseOnBotItemCommand(ChatHandler* handler, Optional<Variant<ItemTemplate const*, std::vector<std::string>>> item_name_parts_or_template)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* target = handler->getSelectedCreature();

        if (!item_name_parts_or_template)
        {
            handler->SendSysMessage(".npcbot useonbot item [#item_name]");
            handler->SendSysMessage("Attempts to cast item spell by item name on selected bot, bypassing client restrictions");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!target || !target->IsNPCBot())
        {
            handler->SendSysMessage("No NPCBot selected");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Item* item = nullptr;
        if (item_name_parts_or_template->holds_alternative<ItemTemplate const*>())
            item = player->GetItemByEntry(item_name_parts_or_template->get<ItemTemplate const*>()->ItemId);
        else
        {
            auto const& vec = item_name_parts_or_template->get<std::vector<std::string>>();
            std::string itemname = vec[0];
            for (std::size_t i = 1; i < vec.size(); ++i)
                itemname += ' ' + vec[i];

            if (itemname.size() >= 2 && itemname[0] == '[' && itemname[itemname.size() - 1] == ']')
                itemname = itemname.substr(1, itemname.size() - 2);

            LocaleConstant locale = handler->GetSession()->GetSessionDbcLocale();

            // find the item
            for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END && !item; ++i)
            {
                Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
                if (!pItem || pItem->IsInTrade())
                    continue;

                ItemTemplate const* pItemTemplate = pItem->GetTemplate();
                std::string pItemName = pItemTemplate->Name1;
                if (ItemLocale const* il = sObjectMgr->GetItemLocale(pItemTemplate->ItemId))
                    ObjectMgr::GetLocaleString(il->Name, locale, pItemName);
                if (pItemName == itemname)
                    item = pItem;
            }
            for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END && !item; ++i)
            {
                if (Bag* pBag = player->GetBagByPos(i))
                {
                    for (uint32 j = 0; j < pBag->GetBagSize() && !item; ++j)
                    {
                        Item* pItem = player->GetItemByPos(i, j);
                        if (!pItem || pItem->IsInTrade())
                            continue;

                        ItemTemplate const* pItemTemplate = pItem->GetTemplate();
                        std::string pItemName = pItemTemplate->Name1;
                        if (ItemLocale const* il = sObjectMgr->GetItemLocale(pItemTemplate->ItemId))
                            ObjectMgr::GetLocaleString(il->Name, locale, pItemName);
                        if (pItemName == itemname)
                            item = pItem;
                    }
                }
            }
        }

        if (!item)
        {
            handler->SendSysMessage(LANG_COMMAND_NOITEMFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // find usable spell
        ItemTemplate const* itemtemplate = item->GetTemplate();
        uint32 spellId = 0;
        for (auto const& itemspell : itemtemplate->Spells)
        {
            if (itemspell.SpellId > 0 && itemspell.SpellTrigger == ITEM_SPELLTRIGGER_ON_USE)
            {
                spellId = itemspell.SpellId;
                break;
            }
        }

        SpellInfo const* spellInfo = spellId ? sSpellMgr->GetSpellInfo(spellId) : nullptr;
        if (!spellInfo)
        {
            handler->PSendSysMessage(LANG_COMMAND_NOSPELLFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (itemtemplate->InventoryType != INVTYPE_NON_EQUIP && !item->IsEquipped())
        {
            player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, item, nullptr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        InventoryResult msg = player->CanUseItem(item);
        if (msg != EQUIP_ERR_OK)
        {
            player->SendEquipError(msg, item, nullptr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (itemtemplate->Class == ITEM_CLASS_CONSUMABLE && !(itemtemplate->Flags & ITEM_FLAG_IGNORE_DEFAULT_ARENA_RESTRICTIONS) && player->InArena())
        {
            player->SendEquipError(EQUIP_ERR_NOT_DURING_ARENA_MATCH, item, nullptr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if ((itemtemplate->Flags & ITEM_FLAG_NOT_USEABLE_IN_ARENA) && player->InArena())
        {
            player->SendEquipError(EQUIP_ERR_NOT_DURING_ARENA_MATCH, item, nullptr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (player->IsInCombat() && !spellInfo->CanBeUsedInCombat())
        {
            player->SendEquipError(EQUIP_ERR_NOT_IN_COMBAT, item, nullptr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // silently cancel
        if (spellInfo->IsPassive() || !spellInfo->IsPositive() || player->isPossessing() || player->IsInFlight())
            return true;

        SpellInfo const* actualSpellInfo = spellInfo->GetAuraRankForLevel(target->GetLevel());
        if (actualSpellInfo)
            spellInfo = actualSpellInfo;

        SpellCastTargets targets;
        targets.SetUnitTarget(target);
        Spell* spell = new Spell(player, spellInfo, TRIGGERED_NONE);
        spell->m_CastItem = item;
        spell->m_cast_count = 1;
        spell->m_glyphIndex = 0;
        spell->prepare(&targets);

        return true;
    }

    static bool HandleNpcBotInfoCommand(ChatHandler* handler, Optional<Variant<uint32, std::string>> player_lg_name)
    {
        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        std::string master_name = (player_lg_name && player_lg_name->holds_alternative<std::string>()) ? player_lg_name->get<std::string>() : "";
        if (!master_name.empty())
            normalizePlayerName(master_name);
        ObjectGuid cached_guid = !master_name.empty() ? sCharacterCache->GetCharacterGuidByName(master_name) : ObjectGuid::Empty;
        ObjectGuid master_guid = cached_guid ? cached_guid :
            (player_lg_name && player_lg_name->holds_alternative<uint32>()) ? ObjectGuid::Create<HighGuid::Player>(player_lg_name->get<uint32>()) :
            player && player->GetTarget().IsPlayer() ? player->GetTarget() : ObjectGuid::Empty;

        if (master_guid.IsEmpty())
        {
            if (!master_name.empty())
            {
                handler->PSendSysMessage("Player '{}' is not found!", master_name);
                handler->SetSentErrorMessage(true);
                return false;
            }

            handler->SendSysMessage(".npcbot info");
            handler->SendSysMessage("Lists NpcBots count of each class owned by selected player. You can use this on self and your party members");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (master_name.empty() && !sCharacterCache->GetCharacterNameByGuid(master_guid, master_name))
        {
            handler->PSendSysMessage("Player {} is not found!", master_guid.GetCounter());
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (BotDataMgr::GetOwnedBotsCount(master_guid) == 0)
        {
            handler->PSendSysMessage("{} ({}) has no NpcBots!", master_name, master_guid.GetCounter());
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::vector<ObjectGuid> guidvec;
        BotDataMgr::GetNPCBotGuidsByOwner(guidvec, master_guid);
        Player* master = ObjectAccessor::FindConnectedPlayer(master_guid);
        BotMap const* map = master ? master->GetBotMgr()->GetBotMap() : nullptr;
        uint32 map_size = map ? uint32(map->size()) : 0u;
        if (map)
        {
            guidvec.erase(std::remove_if(std::begin(guidvec), std::end(guidvec),
                [bmap = map](ObjectGuid guid) { return bmap->find(guid) != bmap->end(); }
            ), std::end(guidvec));
        }

        handler->PSendSysMessage("Listing NpcBots for {}, guid {}{}:", master_name, master_guid.GetCounter(), !master ? " (offline)" : "");
        handler->PSendSysMessage("Owned NpcBots: {} (active: {})", uint32(guidvec.size()) + map_size, map_size);
        LocaleConstant loc = LocaleConstant(handler->GetSessionDbLocaleIndex());
        if (map)
        {
            for (uint8 i = BOT_CLASS_WARRIOR; i != BOT_CLASS_END; ++i)
            {
                for (BotMap::const_iterator itr = map->begin(); itr != map->end(); ++itr)
                {
                    if (Creature* cre = itr->second)
                    {
                        if (cre->GetBotClass() == i)
                        {
                            std::string ccolor, cname;
                            GetBotClassNameAndColor(i, ccolor, cname);
                            std::string base_name = cre->GetName();
                            if (CreatureLocale const* creatureLocale = sObjectMgr->GetCreatureLocale(cre->GetEntry()))
                                if (creatureLocale->Name.size() > loc && !creatureLocale->Name[loc].empty())
                                    base_name = creatureLocale->Name[loc];

                            handler->PSendSysMessage("{} ({}): {} (alive: {})", base_name.c_str(), cre->GetEntry(), "|c" + ccolor + cname + "|r", uint32(cre->IsAlive()));
                        }
                    }
                }
            }
        }

        handler->PSendSysMessage("{} inactive bots:", uint32(guidvec.size()));
        for (ObjectGuid guid : guidvec)
        {
            Creature const* bot = BotDataMgr::FindBot(guid.GetEntry());
            std::string ccolor, cname;
            GetBotClassNameAndColor(bot ? bot->GetBotClass() : uint8(BOT_CLASS_NONE), ccolor, cname);
            std::string base_name = bot ? bot->GetName() : "Unknown";
            if (CreatureLocale const* creatureLocale = sObjectMgr->GetCreatureLocale(guid.GetEntry()))
                if (creatureLocale->Name.size() > loc && !creatureLocale->Name[loc].empty())
                    base_name = creatureLocale->Name[loc];
            handler->PSendSysMessage("{} ({}): {} (alive: {})", base_name.c_str(), guid.GetEntry(), "|c" + ccolor + cname + "|r", bot ? uint32(bot->IsAlive()) : uint32(0));
        }

        return true;
    }

    static bool HandleNpcBotCommandStandstillCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command standstill");
            handler->SendSysMessage("Forces your npcbots to stop all movement and remain stationed");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        Unit* target = owner->GetSelectedUnit();
        if (target && owner->GetBotMgr()->GetBot(target->GetGUID()))
        {
            target->ToCreature()->GetBotAI()->SetBotCommandState(BOT_COMMAND_STAY);
            msg = target->GetName() + "'s command state set to 'STAY'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_STAY);
            msg = "Bots' command state set to 'STAY'";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandStopfullyCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command stopfully");
            handler->SendSysMessage("Forces your npcbots to stop all activity");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        Unit* target = owner->GetSelectedUnit();
        if (target && owner->GetBotMgr()->GetBot(target->GetGUID()))
        {
            target->ToCreature()->GetBotAI()->SetBotCommandState(BOT_COMMAND_FULLSTOP);
            msg = target->GetName() + "'s command state set to 'FULLSTOP'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_FULLSTOP);
            msg = "Bots' command state set to 'FULLSTOP'";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandNoLongCastCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command nolongcast");
            handler->SendSysMessage("Makes npcbots unable to cast spells with non-zero cast time");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        if (!owner->GetBotMgr()->GetBotMap()->begin()->second->GetBotAI()->HasBotCommandState(BOT_COMMAND_NO_CAST_LONG))
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_NO_CAST_LONG);
            msg = "Bots' command state set to 'NOLONGCAST'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandStateRemove(BOT_COMMAND_NO_CAST_LONG);
            msg = "Bots' command state 'NOLONGCAST' was removed";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandNoCastCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command nocast");
            handler->SendSysMessage("Makes npcbots unable to cast ANY spells");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        if (!owner->GetBotMgr()->GetBotMap()->begin()->second->GetBotAI()->HasBotCommandState(BOT_COMMAND_NO_CAST))
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_NO_CAST);
            msg = "Bots' command state set to 'NOCAST'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandStateRemove(BOT_COMMAND_NO_CAST);
            msg = "Bots' command state 'NOCAST' was removed";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandFollowOnlyCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command follow only");
            handler->SendSysMessage("Makes npcbots follow you and do nothing else");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        if (!owner->GetBotMgr()->GetBotMap()->begin()->second->GetBotAI()->HasBotCommandState(BOT_COMMAND_INACTION))
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_INACTION);
            msg = "Bots' command state set to 'INACTION'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandStateRemove(BOT_COMMAND_INACTION);
            msg = "Bots' command state 'INACTION' was removed";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandFollowCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command follow");
            handler->SendSysMessage("Allows npcbots to follow you again if stopped");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        Unit* target = owner->GetSelectedUnit();
        if (target && owner->GetBotMgr()->GetBot(target->GetGUID()))
        {
            target->ToCreature()->GetBotAI()->SetBotCommandState(BOT_COMMAND_FOLLOW);
            msg = target->GetName() + "'s command state set to 'FOLLOW'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_FOLLOW);
            msg = "Bots' command state set to 'FOLLOW'";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandWalkCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command walk");
            handler->SendSysMessage("Toggles walk mode for your npcbots");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        bool isWalking = owner->GetBotMgr()->GetBotMap()->begin()->second->GetBotAI()->HasBotCommandState(BOT_COMMAND_WALK);
        if (!isWalking)
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_WALK);
            msg = "Bots' movement mode is set to 'WALK'";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandStateRemove(BOT_COMMAND_WALK);
            msg = "Bots' movement mode is set to 'RUN'";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandNoGossipCommand(ChatHandler* handler)
    {
        Player* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
        {
            handler->SendSysMessage(".npcbot command nogossip");
            handler->SendSysMessage("Toggles gossip availability for your npcbots");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string msg;
        bool isNoGossipEnabled = owner->GetBotMgr()->GetBotMap()->begin()->second->GetBotAI()->HasBotCommandState(BOT_COMMAND_NOGOSSIP);
        if (!isNoGossipEnabled)
        {
            owner->GetBotMgr()->SendBotCommandState(BOT_COMMAND_NOGOSSIP);
            msg = "Bots' gossip is DISABLED";
        }
        else
        {
            owner->GetBotMgr()->SendBotCommandStateRemove(BOT_COMMAND_NOGOSSIP);
            msg = "Bots' gossip is ENABLED";
        }

        handler->SendSysMessage(msg);
        return true;
    }

    static bool HandleNpcBotCommandReBindCommand(ChatHandler* handler, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage(".npcbot command rebind [#names...]");
            chandler->SendSysMessage("Re-binds selected/named unbound npcbot");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Successfully re-bound {} bot(s)", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Successfully re-bound {}", name_or_count.get<std::string>());
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
                    handler->PSendSysMessage("Failed to re-bind {} for some reason!", bot->GetName());
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
                    handler->PSendSysMessage("Failed to re-bind {} for some reason!", name);
                    handler->SetSentErrorMessage(true);
                    continue;
                }
                ++count;
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("Unable to re-bind any of {} bots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotCommandUnBindCommand(ChatHandler* handler, Optional<std::vector<std::string>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage(".npcbot command unbind [#names...]");
            chandler->SendSysMessage("Frees selected/named npcbot(s) temporarily. The bot will return to home location and wait until re-bound");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Successfully unbound {} bot(s)", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Successfully unbound {}", name_or_count.get<std::string>());
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
            handler->PSendSysMessage("Unable to unbind any of {} bots!", uint32(names->size()));
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
            handler->SendSysMessage("Frees selected npcbot from it's owner. Select player to remove all npcbots");
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
                    handler->SendSysMessage("Npcbots were successfully removed");
                    handler->SetSentErrorMessage(true);
                    return true;
                }
                handler->SendSysMessage("Some npcbots were not removed!");
                handler->SetSentErrorMessage(true);
                return false;
            }
            handler->SendSysMessage("Npcbots are not found!");
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
                handler->SendSysMessage("NpcBot successfully removed");
                handler->SetSentErrorMessage(true);
                return true;
            }
            handler->SendSysMessage("NpcBot was NOT removed for some stupid reason!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->SendSysMessage("You must select player or controlled npcbot");
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
            handler->SendSysMessage("Revives selected npcbot. If player is selected, revives all selected player's npcbots");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (Player* master = u->ToPlayer())
        {
            if (!master->HaveBot())
            {
                handler->PSendSysMessage("{} has no npcbots!", master->GetName());
                handler->SetSentErrorMessage(true);
                return false;
            }

            master->GetBotMgr()->ReviveAllBots();
            handler->SendSysMessage("Npcbots revived");
            return true;
        }
        else if (Creature* bot = u->ToCreature())
        {
            if (bot->GetBotAI())
            {
                if (bot->IsAlive())
                {
                    handler->PSendSysMessage("{} is not dead", bot->GetName());
                    handler->SetSentErrorMessage(true);
                    return false;
                }

                BotMgr::ReviveBot(bot, (bot->GetBotOwner() == owner) ? owner->ToUnit() : bot->ToUnit());
                handler->PSendSysMessage("{} revived", bot->GetName());
                return true;
            }
        }

        handler->SendSysMessage("You must select player or npcbot");
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
            handler->SendSysMessage("Allows to hire selected uncontrolled bot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* bot = cre->ToCreature();
        if (!bot || !bot->IsNPCBot() || bot->GetBotAI()->GetBotOwnerGuid() || bot->GetBotAI()->IsWanderer())
        {
            handler->SendSysMessage("You must select uncontrolled non-wandering npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        ObjectGuid::LowType guidlow = owner->GetGUID().GetCounter();
        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &guidlow);
        bot->GetBotAI()->ReinitOwner();

        if (owner->GetBotMgr()->AddBot(bot) == BOT_ADD_SUCCESS)
        {
            handler->PSendSysMessage("{} is now your npcbot", bot->GetName());
            return true;
        }

        handler->SendSysMessage("NpcBot is NOT added for some reason!");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotReloadConfigCommand(ChatHandler* handler)
    {
        BOT_LOG_INFO("misc", "Re-Loading config settings...");
        sWorld->LoadConfigSettings(true);
        sMapMgr->InitializeVisibilityDistanceInfo();
        handler->SendGlobalGMSysMessage("World config settings reloaded.");
        BotMgr::ReloadConfig();
        handler->SendGlobalGMSysMessage("NpcBot config settings reloaded.");
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
