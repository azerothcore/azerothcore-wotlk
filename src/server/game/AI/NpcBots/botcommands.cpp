#include "bot_ai.h"
#include "botdump.h"
#include "botmgr.h"
#include "botdatamgr.h"
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

        LocaleConstant loc = handler->GetSessionDbcLocale();
        handler->SendSysMessage("Ranges:");
        for (uint8 race : { RACE_HUMAN, RACE_DWARF, RACE_NIGHTELF, RACE_GNOME, RACE_DRAENEI, RACE_ORC, RACE_UNDEAD_PLAYER, RACE_TAUREN, RACE_BLOODELF })
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

    struct BotInfo
    {
            explicit BotInfo(uint32 Id, std::string&& Name, uint8 Race) : id(Id), name(std::move(Name)), race(Race) {}
            uint32 id;
            std::string name;
            uint8 race;

            BotInfo (BotInfo&&) noexcept = default;
            BotInfo& operator=(BotInfo&&) noexcept = default;

            BotInfo() = delete;
            BotInfo(BotInfo const&) = delete;
            BotInfo& operator=(BotInfo const&) = delete;
    };
    static bool sortbots(BotInfo const& p1, BotInfo const& p2)
    {
        return p1.id < p2.id;
    }


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

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable npcbotToggleCommandTable =
        {
            { "flags",      HandleNpcBotToggleFlagsCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_TOGGLE_FLAGS,       Console::No  },
        };

        static ChatCommandTable npcbotDebugCommandTable =
        {
            { "raid",       HandleNpcBotDebugRaidCommand,           rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_RAID,         Console::No  },
            { "mount",      HandleNpcBotDebugMountCommand,          rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_MOUNT,        Console::No  },
            { "spellvisual",HandleNpcBotDebugSpellVisualCommand,    rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_VISUAL,       Console::No  },
            { "states",     HandleNpcBotDebugStatesCommand,         rbac::RBAC_PERM_COMMAND_NPCBOT_DEBUG_STATES,       Console::No  },
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
            { "sendto",     npcbotSendToCommandTable                                                                                },
            { "distance",   npcbotDistanceCommandTable                                                                              },
            { "order",      npcbotOrderCommandTable                                                                                 },
            { "vehicle",    npcbotVehicleCommandTable                                                                               },
            { "dump",       npcbotDumpCommandTable                                                                                  },
        };

        static ChatCommandTable commandTable =
        {
            { "npcbot",     npcbotCommandTable                                                                                      },
        };
        return commandTable;
    }

    static bool HandleNpcBotDebugStatesCommand(ChatHandler* handler)
    {
        Unit* target = handler->getSelectedUnit();
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
            handler->SendSysMessage("Imports NPCBots from a backup SQL file created with '.npcbot dump write' command.");
            handler->SendSysMessage("Syntax: .npcbot dump load #file_name [#force_kick_all]");
            if (!force_kick && sWorld->GetPlayerCount() > 0)
                handler->SendSysMessage("Make sure no players are online before importing.");
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
                handler->SendSysMessage("Import successful.");
                handler->SendSysMessage("Server will be restarted now to prevent DB corruption.");
                sWorld->ShutdownServ(4, SHUTDOWN_MASK_RESTART, 70);
                break;
            case BOT_DUMP_FAIL_FILE_NOT_EXIST:
                handler->PSendSysMessage("Can't open %s or the file doesn't exist!", file_str->c_str());
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_FILE_CORRUPTED:
                handler->SendSysMessage("File data integrity check failed!");
                handler->SetSentErrorMessage(true);
                return false;
            case BOT_DUMP_FAIL_DATA_OCCUPIED:
                handler->PSendSysMessage("Table data contained in %s overlaps with existing table entries!", file_str->c_str());
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
                handler->PSendSysMessage("File %s already exists!", file_str->c_str());
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

    static bool HandleNpcBotOrderCastCommand(ChatHandler* handler, Optional<std::string_view> bot_name, Optional<std::string> spell_name, Optional<std::string_view> target_token)
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
                handler->PSendSysMessage("Bot %s is not found!", *bot_name);
                return true;
            }
            if (!bot->IsAlive())
            {
                handler->PSendSysMessage("%s is dead!", bot->GetName().c_str());
                return true;
            }

            base_spell = bot->GetBotAI()->GetBaseSpell(*spell_name, handler->GetSessionDbcLocale());
            if (!base_spell)
            {
                handler->PSendSysMessage("%s doesn't have spell named '%s'!", bot->GetName().c_str(), spell_name->c_str());
                return true;
            }
            if (!canBotUseSpell(bot, base_spell))
            {
                handler->PSendSysMessage("%s's %s is not ready yet!", bot->GetName().c_str(), sSpellMgr->GetSpellInfo(base_spell)->SpellName[handler->GetSessionDbcLocale()]);
                return true;
            }
        }
        else
        {
            auto class_name = *bot_name;
            for (auto const c : class_name)
            {
                if (!std::islower(c))
                {
                    handler->SendSysMessage("Bot class name must be in lower case!");
                    return true;
                }
            }

            uint8 bot_class = BotMgr::BotClassByClassName(std::string(class_name));
            if (bot_class == BOT_CLASS_NONE)
            {
                handler->PSendSysMessage("Unknown bot name or class %s!", std::string(class_name).c_str());
                return true;
            }

            std::list<Creature*> cBots = owner->GetBotMgr()->GetAllBotsByClass(bot_class);

            if (cBots.empty())
            {
                handler->PSendSysMessage("No bots of class %u found!", bot_class);
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
                handler->PSendSysMessage("None of %u found bots have spell named '%s'!", cBots.size(), spell_name->c_str());
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
                handler->PSendSysMessage("None of %u found bots can use %s yet!", cBots.size(), spell_name->c_str());
                return true;
            }
        }

        ObjectGuid target_guid;
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
        else
        {
            handler->PSendSysMessage("Invalid target token '%s'!", *target_token);
            handler->SendSysMessage("Valid target tokens:\n    '','bot','self', 'me','master', 'mypet', 'myvehicle', 'target', 'mytarget'");
            return true;
        }

        Unit* target = target_guid ? ObjectAccessor::GetUnit(*owner, target_guid) : nullptr;
        if (!target || !bot->FindMap() || target->FindMap() != bot->FindMap())
        {
            handler->PSendSysMessage("Invalid target '%s'!", target ? target->GetName().c_str() : "unknown");
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

        handler->PSendSysMessage("Bots' follow distance is set to %u", uint32(newdist));
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

        handler->PSendSysMessage("Bots' attack distance is set to %u", uint32(newdist));
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
            handler->GetSession()->SendNotification("You are dead");
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
        handler->SendSysMessage("Bots hidden");
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
            handler->GetSession()->SendNotification("You are dead");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat() && (owner->IsPvP() || owner->IsFFAPvP()))
        {
            handler->GetSession()->SendNotification("You can't do that while in PvP combat");
            handler->SetSentErrorMessage(true);
            return false;
        }

        owner->GetBotMgr()->SetBotsHidden(false);
        handler->SendSysMessage("Bots unhidden");
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

    static bool HandleNpcBotSendToCommand(ChatHandler* handler, Optional<std::vector<std::string_view>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto #names...");
            chandler->SendSysMessage("Makes selected/named bot(s) wait 30 sec for your next DEST spell, assume that position and hold it");
            chandler->SendSysMessage("Max distance is 70 yds");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string_view, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Your next dest spell will send %u bot(s) to position...", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Your next dest spell will send %s to position...", name_or_count.get<std::string_view>().data());
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
            return return_syntax(handler);

        if (!names || names->empty())
        {
            Unit const* target = handler->getSelectedCreature();
            Creature const* bot = target ? owner->GetBotMgr()->GetBot(target->GetGUID()) : nullptr;
            if (bot && bot->IsAlive())
            {
                bot->GetBotAI()->SetBotAwaitState(BOT_AWAIT_SEND);
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive())
            {
                ++count;
                bot->GetBotAI()->SetBotAwaitState(BOT_AWAIT_SEND);
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("Unable to send any of %u bots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToLastCommand(ChatHandler* handler, Optional<std::vector<std::string_view>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto last #names...");
            chandler->SendSysMessage("Makes selected/named bot(s) assume previous position they were sent from");
            chandler->SendSysMessage("This will cancel current sendto await state");
            chandler->SendSysMessage("Max distance is 70 yds");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [](ChatHandler* chandler, Variant<std::string_view, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Moving %u bot(s) to previous position...", name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Moving %s to previous position...", name_or_count.get<std::string_view>().data());
            return true;
        };

        Player const* owner = handler->GetSession()->GetPlayer();

        if (!owner->HaveBot())
            return return_syntax(handler);

        if (!names || names->empty())
        {
            Unit const* target = handler->getSelectedCreature();
            Creature const* bot = target ? owner->GetBotMgr()->GetBot(target->GetGUID()) : nullptr;
            if (bot && bot->IsAlive())
            {
                bot->GetBotAI()->MoveToLastSendPosition();
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive())
            {
                ++count;
                bot->GetBotAI()->MoveToLastSendPosition();
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("Unable to send any of %u bots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToPointSetCommand(ChatHandler* handler, Optional<uint32> point_id, Optional<std::vector<std::string_view>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto point set #number #names...");
            chandler->SendSysMessage("Marks selected/named bots' current position as send point by #number");
            chandler->PSendSysMessage("Point number must be in range 1 ... %u", uint32(MAX_SEND_POINTS));
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [&](ChatHandler* chandler, Variant<std::string_view, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Marked send point %u for %u bot(s)", *point_id, name_or_count.get<uint32>());
            else
                chandler->PSendSysMessage("Marked send point %u for %s", *point_id, name_or_count.get<std::string_view>().data());
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
            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive())
            {
                ++count;
                bot->GetBotAI()->MarkSendPosition(*point_id - 1);
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("Unable to mark send point for any of %u bots!", uint32(names->size()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        return return_success(handler, { count });
    }

    static bool HandleNpcBotSendToPointCommand(ChatHandler* handler, Optional<uint32> point_id, Optional<std::vector<std::string_view>> names)
    {
        static auto return_syntax = [](ChatHandler* chandler) -> bool {
            chandler->SendSysMessage("Syntax: .npcbot sendto point #number #names...");
            chandler->SendSysMessage("Makes selected/named bot(s) assume previously set point by #number");
            chandler->SendSysMessage("This will cancel current sendto await state");
            chandler->SendSysMessage("Max distance is 70 yds");
            chandler->SetSentErrorMessage(true);
            return false;
        };

        static auto return_success = [&](ChatHandler* chandler, Variant<std::string_view, uint32> name_or_count) -> bool {
            if (name_or_count.holds_alternative<uint32>())
                chandler->PSendSysMessage("Moving %u bot(s) to point %u...", name_or_count.get<uint32>(), *point_id);
            else
                chandler->PSendSysMessage("Moving %s to point %u...", name_or_count.get<std::string_view>().data(), *point_id);
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
                bot->GetBotAI()->MoveToSendPosition(*point_id - 1);
                return return_success(handler, { bot->GetName() });
            }
            return return_syntax(handler);
        }

        uint32 count = 0;
        for (decltype(names)::value_type::value_type name : *names)
        {
            Creature const* bot = owner->GetBotMgr()->GetBotByName(name);
            if (bot && bot->IsAlive())
            {
                ++count;
                bot->GetBotAI()->MoveToSendPosition(*point_id - 1);
            }
        }

        if (count == 0)
        {
            handler->PSendSysMessage("Unable to send any of %u bots!", uint32(names->size()));
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

        handler->SendSysMessage("You must select one of your bots or yourself");
        handler->SetSentErrorMessage(true);
        return false;
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
            handler->GetSession()->SendNotification("You are dead");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (owner->GetBotMgr()->IsPartyInCombat() && (owner->IsPvP() || owner->IsFFAPvP()))
        {
            handler->GetSession()->SendNotification("You can't do that while in PvP combat");
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

        handler->PSendSysMessage("%s's faction set to %u", bot->GetName().c_str(), factionId);
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
        if (!bot || !bot->IsNPCBot())
        {
            handler->SendSysMessage("You must select a npcbot");
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

        handler->PSendSysMessage("%s's new owner is %s (guidlow: %u)", bot->GetName().c_str(), characterName.c_str(), guidlow);
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
            handler->PSendSysMessage("%s is not a valid spec for bot class %u!",
                bot_ai::LocalizedNpcText(chr, bot_ai::TextForSpec(*spec)), uint32(bot->GetBotClass()));
            handler->SetSentErrorMessage(true);
            return false;
        }

        bot->GetBotAI()->SetSpec(*spec);

        handler->PSendSysMessage("%s's new spec is %u", bot->GetName().c_str(), uint32(*spec));
        return true;
    }

    static bool HandleNpcBotLookupCommand(ChatHandler* handler, Optional<uint8> botclass, Optional <bool> unspawned)
    {
        //this is just a modified '.lookup creature' command
        if (!botclass)
        {
            handler->SendSysMessage(".npcbot lookup #class #[not_spawned_only]");
            handler->SendSysMessage("Looks up npcbots by #class, and returns all matches with their creature ID's");
            handler->SendSysMessage("If #not_spawned_only is set to 1 shows only bots which don't exist in world");
            handler->PSendSysMessage("BOT_CLASS_WARRIOR = %u", uint32(BOT_CLASS_WARRIOR));
            handler->PSendSysMessage("BOT_CLASS_PALADIN = %u", uint32(BOT_CLASS_PALADIN));
            handler->PSendSysMessage("BOT_CLASS_HUNTER = %u", uint32(BOT_CLASS_HUNTER));
            handler->PSendSysMessage("BOT_CLASS_ROGUE = %u", uint32(BOT_CLASS_ROGUE));
            handler->PSendSysMessage("BOT_CLASS_PRIEST = %u", uint32(BOT_CLASS_PRIEST));
            handler->PSendSysMessage("BOT_CLASS_DEATH_KNIGHT = %u", uint32(BOT_CLASS_DEATH_KNIGHT));
            handler->PSendSysMessage("BOT_CLASS_SHAMAN = %u", uint32(BOT_CLASS_SHAMAN));
            handler->PSendSysMessage("BOT_CLASS_MAGE = %u", uint32(BOT_CLASS_MAGE));
            handler->PSendSysMessage("BOT_CLASS_WARLOCK = %u", uint32(BOT_CLASS_WARLOCK));
            handler->PSendSysMessage("BOT_CLASS_DRUID = %u", uint32(BOT_CLASS_DRUID));
            handler->PSendSysMessage("BOT_CLASS_BLADEMASTER = %u", uint32(BOT_CLASS_BM));
            handler->PSendSysMessage("BOT_CLASS_SPHYNX = %u", uint32(BOT_CLASS_SPHYNX));
            handler->PSendSysMessage("BOT_CLASS_ARCHMAGE = %u", uint32(BOT_CLASS_ARCHMAGE));
            handler->PSendSysMessage("BOT_CLASS_DREADLORD = %u", uint32(BOT_CLASS_DREADLORD));
            handler->PSendSysMessage("BOT_CLASS_SPELLBREAKER = %u", uint32(BOT_CLASS_SPELLBREAKER));
            handler->PSendSysMessage("BOT_CLASS_DARK_RANGER = %u", uint32(BOT_CLASS_DARK_RANGER));
            handler->PSendSysMessage("BOT_CLASS_NECROMANCER = %u", uint32(BOT_CLASS_NECROMANCER));
            handler->PSendSysMessage("BOT_CLASS_SEA_WITCH = %u", uint32(BOT_CLASS_SEA_WITCH));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (botclass == BOT_CLASS_NONE || botclass >= BOT_CLASS_END)
        {
            handler->PSendSysMessage("Unknown bot class %u", uint32(*botclass));
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage("Looking for bots of class %u...", uint32(*botclass));

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

        std::sort(botlist.begin(), botlist.end(), script_bot_commands::sortbots);

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

        Player const* botowner = bot->GetBotOwner()->ToPlayer();

        ObjectGuid receiver =
            botowner ? botowner->GetGUID() :
            bot->GetBotAI()->GetBotOwnerGuid() != 0 ? ObjectGuid(HighGuid::Player, 0, bot->GetBotAI()->GetBotOwnerGuid()) :
            chr->GetGUID();
        if (!bot->GetBotAI()->UnEquipAll(receiver))
        {
            handler->PSendSysMessage("%s is unable to unequip some gear. Please remove equips before deleting bot!", bot->GetName().c_str());
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

        handler->PSendSysMessage("Npcbot %s successfully deleted", bot->GetName().c_str());
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
            handler->PSendSysMessage("npcbot %u not found!", *creature_id);
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
                handler->PSendSysMessage("Cannot delete bot %s from console: has gear but no player to give it back to! Can only delete this bot in-game.", bot->GetName().c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
            if (!bot->GetBotAI()->UnEquipAll(receiver))
            {
                handler->PSendSysMessage("%s is unable to unequip some gear. Please remove equips before deleting bot!", bot->GetName().c_str());
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

        handler->PSendSysMessage("Npcbot %s successfully deleted", bot->GetName().c_str());
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

        handler->PSendSysMessage("%u free npcbots deleted", count);
        return true;
    }

    static bool HandleNpcBotMoveCommand(ChatHandler* handler, Optional<std::string> creVal)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creature = handler->getSelectedCreature();

        if (!creature && !creVal)
        {
            handler->SendSysMessage(".npcbot move");
            handler->SendSysMessage("Moves npcbot to your location");
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
            handler->PSendSysMessage("creature id %u does not exist!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!(creInfo->flags_extra & CREATURE_FLAG_EXTRA_NPCBOT))
        {
            handler->PSendSysMessage("creature id %u is not a npcbot!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!BotDataMgr::SelectNpcBotData(id))
        {
            handler->PSendSysMessage("NpcBot %u is not spawned!", id);
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

        handler->PSendSysMessage("NpcBot %u (guid %u) was moved", id, lowguid);
        return true;
    }

    static bool HandleNpcBotCreateNewCommand(ChatHandler* handler, Optional<std::string_view> name, Optional<uint8> bclass, Optional<uint8> race, Optional<uint8> gender, Optional<uint8> skin, Optional<uint8> face, Optional<uint8> hairstyle, Optional<uint8> haircolor, Optional<uint8> features, Optional<uint8> soundset)
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
            handler->PSendSysMessage("Invalid %s%s!", argname, argval ?  (" " + std::to_string(*argval)).c_str() : "");
            handler->SetSentErrorMessage(true);
            return false;
        };
        static auto const ret_err_invalid_args_for = [](ChatHandler* handler, char const* argname1, char const* argname2) {
            handler->PSendSysMessage("Invalid arguments for %s '%s'!", argname1, argname2);
            handler->SetSentErrorMessage(true);
            return false;
        };

        if (!bclass || !name)
            return ret_err(handler, name && *name == "ranges");

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
            handler->PSendSysMessage("creature %u does not exist!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!(creInfo->flags_extra & CREATURE_FLAG_EXTRA_NPCBOT))
        {
            handler->PSendSysMessage("creature %u is not a npcbot!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (BotDataMgr::SelectNpcBotData(id))
        {
            handler->PSendSysMessage("Npcbot %u already exists in `characters_npcbot` table!", id);
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
            handler->PSendSysMessage("Npcbot %u already exists in `creature` table!", id);
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
            handler->PSendSysMessage("No class/race data found for bot %u!", id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotDataMgr::AddNpcBotData(id, bot_ai::DefaultRolesForClass(_botExtras->bclass), bot_ai::DefaultSpecForClass(_botExtras->bclass), creature->GetCreatureTemplate()->faction);

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
                    << (bot->IsFreeBot() ? (bot->GetBotAI()->GetBotOwnerGuid() ? "inactive (owned)" : "free") : "active");
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

        handler->SendSysMessage(ss.str().c_str());
        return true;
    }

    static bool HandleNpcBotInfoCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player->GetTarget())
        {
            handler->SendSysMessage(".npcbot info");
            handler->SendSysMessage("Lists NpcBots count of each class owned by selected player. You can use this on self and your party members");
            handler->SetSentErrorMessage(true);
            return false;
        }
        Player* master = player->GetSelectedPlayer();
        if (!master)
        {
            handler->SendSysMessage("No player selected");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (BotDataMgr::GetOwnedBotsCount(master->GetGUID()) == 0)
        {
            handler->PSendSysMessage("%s has no NpcBots!", master->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotMgr* mgr = master->GetBotMgr();
        if (!mgr)
            mgr = new BotMgr(master);

        std::vector<ObjectGuid> guidvec;
        BotDataMgr::GetNPCBotGuidsByOwner(guidvec, master->GetGUID());
        BotMap const* map = mgr->GetBotMap();
        guidvec.erase(std::remove_if(std::begin(guidvec), std::end(guidvec),
            [bmap = map](ObjectGuid guid) { return bmap->find(guid) != bmap->end(); }
        ), std::end(guidvec));

        handler->PSendSysMessage("Listing NpcBots for %s", master->GetName().c_str());
        handler->PSendSysMessage("Owned NpcBots: %u (active: %u)", uint32(guidvec.size() + map->size()), uint32(map->size()));
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
                case BOT_CLASS_WARRIOR:         bclass = "Warriors";        break;
                case BOT_CLASS_PALADIN:         bclass = "Paladins";        break;
                case BOT_CLASS_MAGE:            bclass = "Mages";           break;
                case BOT_CLASS_PRIEST:          bclass = "Priests";         break;
                case BOT_CLASS_WARLOCK:         bclass = "Warlocks";        break;
                case BOT_CLASS_DRUID:           bclass = "Druids";          break;
                case BOT_CLASS_DEATH_KNIGHT:    bclass = "Death Knights";   break;
                case BOT_CLASS_ROGUE:           bclass = "Rogues";          break;
                case BOT_CLASS_SHAMAN:          bclass = "Shamans";         break;
                case BOT_CLASS_HUNTER:          bclass = "Hunters";         break;
                case BOT_CLASS_BM:              bclass = "Blademasters";    break;
                case BOT_CLASS_SPHYNX:          bclass = "Destroyers";      break;
                case BOT_CLASS_ARCHMAGE:        bclass = "Archmagi";        break;
                case BOT_CLASS_DREADLORD:       bclass = "Dreadlords";      break;
                case BOT_CLASS_SPELLBREAKER:    bclass = "Spell Breakers";  break;
                case BOT_CLASS_DARK_RANGER:     bclass = "Dark Rangers";    break;
                case BOT_CLASS_NECROMANCER:     bclass = "Necromancers";    break;
                case BOT_CLASS_SEA_WITCH:       bclass = "Sea Witches";     break;
                default:                        bclass = "Unknown Class";   break;
            }
            handler->PSendSysMessage("%s: %u (alive: %u)", bclass, count, alivecount);
        }

        if (guidvec.empty())
            return true;

        handler->PSendSysMessage("%u inactive bots:", uint32(guidvec.size()));
        for (ObjectGuid guid : guidvec)
        {
            Creature const* bot = BotDataMgr::FindBot(guid.GetEntry());
            std::string ccolor, cname;
            GetBotClassNameAndColor(bot ? bot->GetBotClass() : uint8(BOT_CLASS_NONE), ccolor, cname);
            handler->PSendSysMessage("%s (%s)", bot ? bot->GetName().c_str() : "Unknown", "|c" + ccolor + cname + "|r");
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

        handler->SendSysMessage(msg.c_str());
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

        handler->SendSysMessage(msg.c_str());
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

        handler->SendSysMessage(msg.c_str());
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

        handler->SendSysMessage(msg.c_str());
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

        handler->SendSysMessage(msg.c_str());
        return true;
    }

    static bool HandleNpcBotCommandReBindCommand(ChatHandler* handler, Optional<std::string_view> botname)
    {
        Player const* owner = handler->GetSession()->GetPlayer();
        Unit const* u = owner->GetSelectedUnit();
        if ((!u && !botname) || BotDataMgr::GetOwnedBotsCount(owner->GetGUID()) == 0)
        {
            handler->SendSysMessage(".npcbot command rebind [#name]");
            handler->SendSysMessage("Re-binds selected/named unbound npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotMgr* mgr = owner->GetBotMgr();
        if (!mgr)
            mgr = new BotMgr(const_cast<Player*>(owner));

        Creature const* cre = (u && u->GetTypeId() == TYPEID_UNIT) ? u->ToCreature() : BotDataMgr::FindBot(*botname, owner->GetSession()->GetSessionDbLocaleIndex());
        if (!cre || !cre->IsNPCBot() || mgr->GetBot(cre->GetGUID()) ||
            !cre->GetBotAI()->HasBotCommandState(BOT_COMMAND_UNBIND) ||
            BotDataMgr::SelectNpcBotData(cre->GetEntry())->owner != owner->GetGUID().GetCounter())
        {
            handler->SendSysMessage("Must target your unbound npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (mgr->RebindBot(const_cast<Creature*>(cre)) != BOT_ADD_SUCCESS)
        {
            handler->SendSysMessage("Failed to re-bind bot for some reason!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage("%s successfully re-bound", cre->GetName().c_str());
        return true;
    }

    static bool HandleNpcBotCommandUnBindCommand(ChatHandler* handler, Optional<std::string_view> botname)
    {
        Player const* owner = handler->GetSession()->GetPlayer();
        Unit const* u = owner->GetSelectedUnit();
        if (!owner->HaveBot() || (!u && !botname))
        {
            handler->SendSysMessage(".npcbot command unbind [#name]");
            handler->SendSysMessage("Frees selected/named npcbot temporarily. The bot will return to home location and wait until re-bound");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature const* cre = (u && u->GetTypeId() == TYPEID_UNIT) ? u->ToCreature() : owner->GetBotMgr()->GetBotByName(*botname);
        if (!cre || !cre->IsNPCBot() || !owner->GetBotMgr()->GetBot(cre->GetGUID()) ||
            cre->GetBotAI()->HasBotCommandState(BOT_COMMAND_UNBIND))
        {
            handler->SendSysMessage("Must target your active npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        owner->GetBotMgr()->UnbindBot(cre->GetGUID());
        handler->PSendSysMessage("%s successfully unbound", cre->GetName().c_str());
        return true;
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
                handler->PSendSysMessage("%s has no npcbots!", master->GetName().c_str());
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
                    handler->PSendSysMessage("%s is not dead", bot->GetName().c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }

                BotMgr::ReviveBot(bot, (bot->GetBotOwner() == owner) ? owner->ToUnit() : bot->ToUnit());
                handler->PSendSysMessage("%s revived", bot->GetName().c_str());
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
        if (!bot || !bot->IsNPCBot() || bot->GetBotAI()->GetBotOwnerGuid())
        {
            handler->SendSysMessage("You must select uncontrolled npcbot");
            handler->SetSentErrorMessage(true);
            return false;
        }

        BotMgr* mgr = owner->GetBotMgr();
        if (!mgr)
            mgr = new BotMgr(owner);

        ObjectGuid::LowType guidlow = owner->GetGUID().GetCounter();
        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &guidlow);
        bot->GetBotAI()->ReinitOwner();

        if (mgr->AddBot(bot) == BOT_ADD_SUCCESS)
        {
            handler->PSendSysMessage("%s is now your npcbot", bot->GetName().c_str());
            return true;
        }

        handler->SendSysMessage("NpcBot is NOT added for some reason!");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleNpcBotReloadConfigCommand(ChatHandler* handler)
    {
        LOG_INFO("misc", "Re-Loading config settings...");
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
