#ifndef _BOTCOMMON_H
#define _BOTCOMMON_H

#include "SharedDefines.h"
#include "SpellAuraDefines.h"

#include <utility>
#include <vector>

/*
NpcBot System by Trickerer (onlysuffering@gmail.com)
Original patch from: LordPsyan https://bitbucket.org/lordpsyan/trinitycore-patches/src/3b8b9072280e/Individual/11185-BOTS-NPCBots.patch
*/

struct Position;

typedef std::vector<std::pair<Position, float> > AoeSpotsVec;
typedef std::vector<Position> AoeSafeSpotsVec;

enum BotCommonValues
{
//MISC
    BOT_GIVER_ENTRY                     = 70000,
    BOT_ENTRY_BEGIN                     = 70001,
    BOT_ENTRY_END                       = 71000,
    BOT_ENTRY_CREATE_BEGIN              = 70800, // 70800 - 71000 reserved for bot creation
    //BOT_PET_ENTRY_BEGIN                 = 70501,
    //BOT_PET_ENTRY_END                   = 70550,
    BOT_ENTRY_MIRROR_IMAGE_BM           = 70552,
    BOT_ENTRY_CONVERSING_WITH_THE_DEPTHS_TRIGGER = 70100,
    BOT_MAX_CHASE_RANGE                 = 120,  //yds
    //BOT_EVADE_TIME                      = 3000, //ms
//COMMON GAMEOBJECTS
    GO_REFRESHMENT_TABLE_1              = 186812,//lvl 65 req70
    GO_REFRESHMENT_TABLE_2              = 193061,//lvl 80 req80
    GO_SOULWELL_1                       = 181621,//lvl 60 req68
    GO_SOULWELL_2                       = 193169,//lvl 69 req80
//COMMON CDs
    POTION_CD                           = 60000,//default 60sec potion cd
    REGEN_CD                            = 1000, //update hp/mana every X milliseconds
//COMMON TIMERS
    ITEM_ENCHANTMENT_EXPIRE_TIMER       = 3600000, //1 Hour
//COMMON GOSSIPS
    GOSSIP_NORMAL_SERVE_MASTER          = 70001,//"I live only to serve the master."
    GOSSIP_GREET_NEED_SMTH              = 70002,//"You need something?"
    GOSSIP_GREET_MURDER                 = 70003,//"Mortals... usually I kill wretches like you at sight"
    GOSSIP_GREET_CUSTOM_SPHYNX          = 70004,
    GOSSIP_NORMAL_CUSTOM_SPHYNX         = 70005,
    GOSSIP_GREET_CUSTOM_DREADLORD       = 70006,
    GOSSIP_NORMAL_CUSTOM_DREADLORD      = 70007,
    GOSSIP_GREET_CUSTOM_DARKRANGER      = 70008,
    GOSSIP_NORMAL_CUSTOM_DARKRANGER     = 70009,
    GOSSIP_GREET_CUSTOM_SEAWITCH        = 70010,
    GOSSIP_NORMAL_CUSTOM_SEAWITCH       = 70011,
    //70012-70100 reserved for bot gossip texts (not selectable)
    GOSSIP_CLASSDESC_BM                 = 70101,
    GOSSIP_CLASSDESC_SPHYNX             = 70102,
    GOSSIP_CLASSDESC_ARCHMAGE           = 70103,
    GOSSIP_CLASSDESC_DREADLORD          = 70104,
    GOSSIP_CLASSDESC_SPELLBREAKER       = 70105,
    GOSSIP_CLASSDESC_DARKRANGER         = 70106,
    GOSSIP_CLASSDESC_NECROMANCER        = 70107,
    GOSSIP_CLASSDESC_SEAWITCH           = 70108,
    //70109-70200 reserved for bot class descriptions gossip texts (not selectable)
    GOSSIP_BOTGIVER_GREET               = 70201,
    GOSSIP_BOTGIVER_HIRE                = 70202,
    GOSSIP_BOTGIVER_HIRE_CLASS          = 70203,
    GOSSIP_BOTGIVER_HIRE_EMPTY          = 70204,
    //70205-70299 reserved for botgiver gossip texts (not selectable)
    GOSSIP_SENDER_BEGIN                 = 6000,
    GOSSIP_SENDER_BOTGIVER_HIRE,
    GOSSIP_SENDER_BOTGIVER_HIRE_CLASS,
    GOSSIP_SENDER_BOTGIVER_HIRE_ENTRY,
    GOSSIP_SENDER_CLASS,
    GOSSIP_SENDER_CLASS_ACTION,
    GOSSIP_SENDER_CLASS_ACTION2,
    GOSSIP_SENDER_CLASS_ACTION3,
    GOSSIP_SENDER_CLASS_ACTION4,
    GOSSIP_SENDER_EQUIPMENT,
    GOSSIP_SENDER_EQUIPMENT_LIST,
    GOSSIP_SENDER_EQUIPMENT_SHOW,
    GOSSIP_SENDER_EQUIPMENT_INFO,
    GOSSIP_SENDER_EQUIP_TRANSMOGS,
    GOSSIP_SENDER_EQUIP_TRANSMOG_INFO,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_BEGIN = GOSSIP_SENDER_EQUIP_TRANSMOGRIFY,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_MHAND = GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_BEGIN,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_OHAND,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_RANGED,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_HEAD,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_SHOULDERS,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_CHEST,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_WAIST,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_LEGS,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_FEET,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_WRIST,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_HANDS,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_BACK,
    GOSSIP_SENDER_EQUIP_TRANSMOGRIFY_BODY,
    GOSSIP_SENDER_UNEQUIP,
    GOSSIP_SENDER_UNEQUIP_ALL,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_EQUIP,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_BEGIN = GOSSIP_SENDER_EQUIP_AUTOEQUIP_EQUIP,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_MHAND = GOSSIP_SENDER_EQUIP_AUTOEQUIP_BEGIN,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_OHAND,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_RANGED,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_HEAD,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_SHOULDERS,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_CHEST,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_WAIST,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_LEGS,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_FEET,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_WRIST,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_HANDS,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_BACK,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_BODY,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_FINGER1,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_FINGER2,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_TRINKET1,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_TRINKET2,
    GOSSIP_SENDER_EQUIP_AUTOEQUIP_NECK,
    GOSSIP_SENDER_EQUIP_RESET,
    GOSSIP_SENDER_EQUIP,
    GOSSIP_SENDER_EQUIP_BEGIN           = GOSSIP_SENDER_EQUIP,
    GOSSIP_SENDER_EQUIP_MHAND           = GOSSIP_SENDER_EQUIP_BEGIN,
    GOSSIP_SENDER_EQUIP_OHAND,
    GOSSIP_SENDER_EQUIP_RANGED,
    GOSSIP_SENDER_EQUIP_HEAD,
    GOSSIP_SENDER_EQUIP_SHOULDERS,
    GOSSIP_SENDER_EQUIP_CHEST,
    GOSSIP_SENDER_EQUIP_WAIST,
    GOSSIP_SENDER_EQUIP_LEGS,
    GOSSIP_SENDER_EQUIP_FEET,
    GOSSIP_SENDER_EQUIP_WRIST,
    GOSSIP_SENDER_EQUIP_HANDS,
    GOSSIP_SENDER_EQUIP_BACK,
    GOSSIP_SENDER_EQUIP_BODY,
    GOSSIP_SENDER_EQUIP_FINGER1,
    GOSSIP_SENDER_EQUIP_FINGER2,
    GOSSIP_SENDER_EQUIP_TRINKET1,
    GOSSIP_SENDER_EQUIP_TRINKET2,
    GOSSIP_SENDER_EQUIP_NECK,
    GOSSIP_SENDER_ROLES_MAIN,
    GOSSIP_SENDER_ROLES_MAIN_TOGGLE,
    GOSSIP_SENDER_ROLES_GATHERING,
    GOSSIP_SENDER_ROLES_GATHERING_TOGGLE,
    GOSSIP_SENDER_ROLES_LOOTING,
    GOSSIP_SENDER_ROLES_LOOTING_TOGGLE,
    GOSSIP_SENDER_ABILITIES,
    GOSSIP_SENDER_ABILITIES_USE,
    GOSSIP_SENDER_ABILITIES_SPECIFICS_LIST,
    GOSSIP_SENDER_ABILITIES_USAGE_LIST,
    GOSSIP_SENDER_ABILITIES_USAGE_LIST_DAMAGE,
    GOSSIP_SENDER_ABILITIES_USAGE_LIST_CC,
    GOSSIP_SENDER_ABILITIES_USAGE_LIST_HEAL,
    GOSSIP_SENDER_ABILITIES_USAGE_LIST_SUPPORT,
    GOSSIP_SENDER_ABILITIES_USAGE_TOGGLE_DAMAGE,
    GOSSIP_SENDER_ABILITIES_USAGE_TOGGLE_CC,
    GOSSIP_SENDER_ABILITIES_USAGE_TOGGLE_HEAL,
    GOSSIP_SENDER_ABILITIES_USAGE_TOGGLE_SUPPORT,
    GOSSIP_SENDER_SPEC,
    GOSSIP_SENDER_SPEC_SET,
    GOSSIP_SENDER_USEITEM,
    GOSSIP_SENDER_USEITEM_USE,
    GOSSIP_SENDER_HIRE,
    GOSSIP_SENDER_DISMISS,
    GOSSIP_SENDER_JOIN_GROUP,
    GOSSIP_SENDER_LEAVE_GROUP,
    GOSSIP_SENDER_FORMATION,
    GOSSIP_SENDER_FORMATION_FOLLOW_DISTANCE_SET,
    GOSSIP_SENDER_FORMATION_ATTACK_DISTANCE,
    GOSSIP_SENDER_FORMATION_ATTACK_DISTANCE_SET,
    GOSSIP_SENDER_FORMATION_ATTACK_ANGLE,
    GOSSIP_SENDER_FORMATION_ATTACK_ANGLE_SET,
    GOSSIP_SENDER_MODEL_UPDATE,
    GOSSIP_SENDER_HOLDPOSITION,
    GOSSIP_SENDER_DONOTHING,
    GOSSIP_SENDER_FOLLOWME,
    GOSSIP_SENDER_ENGAGE_BEHAVIOR,
    GOSSIP_SENDER_ENGAGE_DELAY_SET_ATTACK,
    GOSSIP_SENDER_ENGAGE_DELAY_SET_HEALING,
    GOSSIP_SENDER_TROUBLESHOOTING,
    GOSSIP_SENDER_TROUBLESHOOTING_FIX,
    GOSSIP_SENDER_TROUBLESHOOTING_AURA,
    GOSSIP_SENDER_SCAN,
    GOSSIP_SENDER_DEBUG,
    GOSSIP_SENDER_DEBUG_ACTION,
//GOSSIP CONST
    BOT_GOSSIP_MAX_ITEMS                = 32, // Client limitation 3.3.5 code confirmed
//COMMON NPC TEXTS
    BOT_TEXT_DIE                        = 70300, //"Die!"
    BOT_TEXT_REZZING_YOU                = 70301, //"Rezzing You"
    BOT_TEXT_REZZING_                   = 70302, //"Rezzing "
    BOT_TEXT_YOUR_BOT                   = 70303, //"your bot"
    BOT_TEXT__S_BOT                     = 70304, //"'s bot"
    BOT_TEXT_CANT_CONJURE_WATER_YET     = 70305, //"I can't conjure water yet"
    BOT_TEXT_CANT_CONJURE_FOOD_YET      = 70306, //"I can't conjure food yet"
    BOT_TEXT_CANT_RIGHT_NOW             = 70307, //"I can't do it right now"
    BOT_TEXT_HERE_YOU_GO                = 70308, //"Here you go..."
    BOT_TEXT_DISABLED                   = 70309, //"Disabled"
    BOT_TEXT_NOT_READY_YET              = 70310, //"Not ready yet"
    BOT_TEXT_INVALID_OBJECT_TYPE        = 70311, //"Invalid object type"
    BOT_TEXT_FAILED                     = 70312, //"Failed"
    BOT_TEXT_DONE                       = 70313, //"Done"
    BOT_TEXT_NOT_SHAPESHIFTED           = 70314, //"I am not shapeshifted"
    BOT_TEXT_NO_HEALTHSTONE             = 70315, //"I don't have a healthstone"
    BOT_TEXT_CANT_CREATE_HEALTHSTONE    = 70316, //"I can't create healthstones yet!"
    BOT_TEXT_NO_LOCKPICKING             = 70317, //"WTF I don't have lockpicking!"
    BOT_TEXT_SKILL_LEVEL_TOO_LOW        = 70318, //"My skill level in not high enough"
    BOT_TEXT_CHANGING_MY_SPEC_TO_       = 70319, //"Changing my spec to "
    BOT_TEXT_SPEC_ARMS                  = 70320, //"Arms"
    BOT_TEXT_SPEC_FURY                  = 70321, //"Fury"
    BOT_TEXT_SPEC_PROTECTION            = 70322, //"Protection"
    BOT_TEXT_SPEC_RETRIBUTION           = 70323, //"Retribution"
    BOT_TEXT_SPEC_BEASTMASTERY          = 70324, //"Beast Mastery"
    BOT_TEXT_SPEC_MARKSMANSHIP          = 70325, //"Marksmanship"
    BOT_TEXT_SPEC_SURVIVAL              = 70326, //"Survival"
    BOT_TEXT_SPEC_ASSASINATION          = 70327, //"Assassination"
    BOT_TEXT_SPEC_COMBAT                = 70328, //"Combat"
    BOT_TEXT_SPEC_SUBTLETY              = 70329, //"Subtlety"
    BOT_TEXT_SPEC_DISCIPLINE            = 70330, //"Discipline"
    BOT_TEXT_SPEC_HOLY                  = 70331, //"Holy"
    BOT_TEXT_SPEC_SHADOW                = 70332, //"Shadow"
    BOT_TEXT_SPEC_BLOOD                 = 70333, //"Blood"
    BOT_TEXT_SPEC_FROST                 = 70334, //"Frost"
    BOT_TEXT_SPEC_UNHOLY                = 70335, //"Unholy"
    BOT_TEXT_SPEC_ELEMENTAL             = 70336, //"Elemental"
    BOT_TEXT_SPEC_ENHANCEMENT           = 70337, //"Enhancement"
    BOT_TEXT_SPEC_RESTORATION           = 70338, //"Restoration"
    BOT_TEXT_SPEC_ARCANE                = 70339, //"Arcane"
    BOT_TEXT_SPEC_FIRE                  = 70340, //"Fire"
    BOT_TEXT_SPEC_AFFLICTION            = 70341, //"Affliction"
    BOT_TEXT_SPEC_DEMONOLOGY            = 70342, //"Demonology"
    BOT_TEXT_SPEC_DESTRUCTION           = 70343, //"Destruction"
    BOT_TEXT_SPEC_BALANCE               = 70344, //"Balance"
    BOT_TEXT_SPEC_FERAL                 = 70345, //"Feral Combat"
    BOT_TEXT_SPEC_UNKNOWN               = 70346, //"Unknown"
    BOT_TEXT_HIREDENY_DK                = 70347, //"Go away, weakling"
    BOT_TEXT_HIREDENY_SPHYNX            = 70348, //" is not convinced"
    BOT_TEXT_HIREDENY_ARCHMAGE          = 70349, //"I am not going to waste my time on just anything"
    BOT_TEXT_HIREDENY_DREADLORD         = 70350, //NIY
    BOT_TEXT_HIREDENY_SPELLBREAKER      = 70351, //NIY
    BOT_TEXT_HIREDENY_DARKRANGER        = 70352, //NIY
    BOT_TEXT_HIRE_SUCCESS               = 70353, //"I am ready"
    BOT_TEXT_HIREDENY_MY_MASTER_IS_     = 70354, //"Go away. I serve my master "
    BOT_TEXT_UNKNOWN                    = 70355, //"unknown"
    BOT_TEXT__ON_YOU                    = 70356, //" on You!"
    BOT_TEXT__ON_MYSELF                 = 70357, //" on myself!"
    BOT_TEXT__ON_                       = 70358, //" on "
    BOT_TEXT__USED                      = 70359, //" used!"
    BOT_TEXT_BOT_TANK                   = 70360, //"bot tank"
    BOT_TEXT_CLASS                      = 70361, //"class"
    BOT_TEXT_PLAYER                     = 70362, //"player"
    BOT_TEXT_MASTER                     = 70363, //"master"
    BOT_TEXT_NONE                       = 70364, //"none"
    BOT_TEXT_RANK                       = 70365, //"Rank"
    BOT_TEXT_TALENT                     = 70366, //"talent"
    BOT_TEXT_PASSIVE                    = 70367, //"passive"
    BOT_TEXT_HIDDEN                     = 70368, //"hidden"
    BOT_TEXT_KNOWN                      = 70369, //"known"
    BOT_TEXT_ABILITY                    = 70370, //"ability"
    BOT_TEXT_STAT_STR                   = 70371, //"str"
    BOT_TEXT_STAT_AGI                   = 70372, //"agi"
    BOT_TEXT_STAT_STA                   = 70373, //"sta"
    BOT_TEXT_STAT_INT                   = 70374, //"int"
    BOT_TEXT_STAT_SPI                   = 70375, //"spi"
    BOT_TEXT_STAT_UNK                   = 70376, //"unk stat"
    BOT_TEXT_TOTAL                      = 70377, //"total"
    BOT_TEXT_MELEE_AP                   = 70378, //"Melee AP"
    BOT_TEXT_RANGED_AP                  = 70379, //"Ranged AP"
    BOT_TEXT_ARMOR                      = 70380, //"armor"
    BOT_TEXT_CRIT                       = 70381, //"crit"
    BOT_TEXT_DEFENSE                    = 70382, //"defense"
    BOT_TEXT_MISS                       = 70383, //"miss"
    BOT_TEXT_DODGE                      = 70384, //"dodge"
    BOT_TEXT_PARRY                      = 70385, //"parry"
    BOT_TEXT_BLOCK                      = 70386, //"block"
    BOT_TEXT_BLOCKVALUE                 = 70387, //"block value"
    BOT_TEXT_DMG_TAKEN_MELEE            = 70388, //"Damage taken melee"
    BOT_TEXT_DMG_TAKEN_SPELL            = 70389, //"Damage taken spell"
    BOT_TEXT_DMG_RANGE_MAINHAND         = 70390, //"Damage range mainhand"
    BOT_TEXT_DMG_MULT_MAINHAND          = 70391, //"Damage mult mainhand"
    BOT_TEXT_ATTACK_TIME_MAINHAND       = 70392, //"Attack time mainhand"
    BOT_TEXT_DMG_RANGE_OFFHAND          = 70393, //"Damage range offhand"
    BOT_TEXT_DMG_MULT_OFFHAND           = 70394, //"Damage mult offhand"
    BOT_TEXT_ATTACK_TIME_OFFHAND        = 70395, //"Attack time offhand"
    BOT_TEXT_DMG_RANGE_RANGED           = 70396, //"Damage range ranged"
    BOT_TEXT_DMG_MULT_RANGED            = 70397, //"Damage mult ranged"
    BOT_TEXT_ATTACK_TIME_RANGED         = 70398, //"Attack time ranged"
    BOT_TEXT_MIN                        = 70399, //"min"
    BOT_TEXT_MAX                        = 70400, //"max"
    BOT_TEXT_DPS                        = 70401, //"DPS"
    BOT_TEXT_BASE_HP                    = 70402, //"base hp"
    BOT_TEXT_TOTAL_HP                   = 70403, //"total hp"
    BOT_TEXT_BASE_MP                    = 70404, //"base mana"
    BOT_TEXT_TOTAL_MP                   = 70405, //"total mana"
    BOT_TEXT_CURR_MP                    = 70406, //"current mana"
    BOT_TEXT_SPELLPOWER                 = 70407, //"spell power"
    BOT_TEXT_REGEN_HP                   = 70408, //"health regen_5 bonus"
    BOT_TEXT_REGEN_MP_CAST              = 70409, //"mana regen_5 no cast"
    BOT_TEXT_REGEN_MP_NOCAST            = 70410, //"mana regen_5 casting"
    BOT_TEXT_HASTE                      = 70411, //"haste"
    BOT_TEXT_HIT                        = 70412, //"hit"
    BOT_TEXT_EXPERTISE                  = 70413, //"expertise"
    BOT_TEXT_ARMOR_PEN                  = 70414, //"armor penetration"
    BOT_TEXT_SPELL_PEN                  = 70415, //"spell penetration"
    BOT_TEXT_PCT                        = 70416, //"pct"
    BOT_TEXT_HOLY                       = 70417, //"holy"
    BOT_TEXT_FIRE                       = 70418, //"fire"
    BOT_TEXT_NATURE                     = 70419, //"nature"
    BOT_TEXT_FROST                      = 70420, //"frost"
    BOT_TEXT_SHADOW                     = 70421, //"shadow"
    BOT_TEXT_ARCANE                     = 70422, //"arcane"
    BOT_TEXT_RESISTANCE                 = 70423, //"Resistance"
    BOT_TEXT_COMMAND_STATES             = 70424, //"Command states"
    BOT_TEXT_COMMAND_FOLLOW             = 70425, //"Follow"
    BOT_TEXT_COMMAND_ATTACK             = 70426, //"Attack"
    BOT_TEXT_COMMAND_STAY               = 70427, //"Stay"
    BOT_TEXT_COMMAND_RESET              = 70428, //"Reset"
    BOT_TEXT_COMMAND_FULLSTOP           = 70429, //"FullStop"
    BOT_TEXT_FOLLOW_DISTANCE            = 70430, //"Follow distance"
    BOT_TEXT_SPEC                       = 70431, //"Spec"
    BOT_TEXT_BOT_ROLEMASK_MAIN          = 70432, //"Bot roles mask main"
    BOT_TEXT_BOT_ROLEMASK_GATHERING     = 70433, //"Bot roles mask gathering"
    BOT_TEXT_PVP_KILLS                  = 70434, //"PvP kills"
    BOT_TEXT_PLAYERS                    = 70435, //"players"
    BOT_TEXT_DIED_                      = 70436, //"Died "
    BOT_TEXT__TIMES                     = 70437, //" times"
    BOT_TEXT_BOT_TICKLED                = 70438, //"%s (bot) calms down"
    BOT_TEXT_DEBUG                      = 70439, //"<Debug>"
    BOT_TEXT_HIREWARN_SPHYNX_1          = 70440, //"Are you sure you want to risk drawing "
    BOT_TEXT_HIREWARN_SPHYNX_2          = 70441, //"'s attention?"
    BOT_TEXT_HIREOPTION_SPHYNX          = 70442, //"<Insert Coin>"
    BOT_TEXT_HIREWARN_DREADLORD         = 70443, //"Do you want to entice "
    BOT_TEXT_HIREOPTION_DREADLORD       = 70444, //"<Try to make an offering>"
    BOT_TEXT_HIREWARN_DEFAULT           = 70445, //"Do you wish to hire "
    BOT_TEXT_HIREOPTION_DEFAULT         = 70446, //"<Hire bot>"
    BOT_TEXT_MANAGE_EQUIPMENT           = 70447, //"Manage equipment..."
    BOT_TEXT_MANAGE_ROLES               = 70448, //"Manage roles..."
    BOT_TEXT_MANAGE_FORMATION           = 70449, //"Manage formation..."
    BOT_TEXT_MANAGE_ABILITIES           = 70450, //"Manage abilities..."
    BOT_TEXT_MANAGE_TALENTS             = 70451, //"Manage talents..."
    BOT_TEXT_GIVE_CONSUMABLE            = 70452, //"Give consumable..."
    BOT_TEXT_CREATE_GROUP               = 70453, //"<Create group>"
    BOT_TEXT_CREATE_GROUP_ALL           = 70454, //"<Create group (all bots)>"
    BOT_TEXT_ADD_TO_GROUP               = 70455, //"<Add to group>"
    BOT_TEXT_ADD_TO_GROUP_ALL           = 70456, //"<Add all bots to group>"
    BOT_TEXT_REMOVE_FROM_GROUP          = 70457, //"<Remove from group>"
    BOT_TEXT_FOLLOW_ME                  = 70458, //"Follow me"
    BOT_TEXT_HOLD_POSITION              = 70459, //"Hold your position"
    BOT_TEXT_STAY_HERE                  = 70460, //"Stay here and don't do anything"
    BOT_TEXT_MAGE_FOOD                  = 70461, //"I need food"
    BOT_TEXT_MAGE_DRINK                 = 70462, //"I need water"
    BOT_TEXT_MAGE_TABLE                 = 70463, //"I need a refreshment table"
    BOT_TEXT_ROGUE_PICKLOCK             = 70464, //"Help me pick a lock"
    BOT_TEXT_WARLOCK_HEALTHSTONE        = 70465, //"I need your your healthstone"
    BOT_TEXT_WARLOCK_SOULWELL           = 70466, //"I need a soulwell"
    BOT_TEXT_ROGUE_POISON_REFRESH       = 70467, //"I need you to refresh poisons"
    BOT_TEXT_ROGUE_POISON_MH            = 70468, //"<Choose poison (Main Hand)>"
    BOT_TEXT_ROGUE_POISON_OH            = 70469, //"<Choose poison (Offhand)>"
    BOT_TEXT_SHAMAN_ENCH_REFRESH        = 70470, //"I need you to refresh enchants"
    BOT_TEXT_SHAMAN_ENCH_MH             = 70471, //"<Choose enchant (Main Hand)>"
    BOT_TEXT_SHAMAN_ENCH_OH             = 70472, //"<Choose enchant (Offhand)>"
    BOT_TEXT_REMOVE_SHAPESHIFT          = 70473, //"I need you to remove shapeshift"
    BOT_TEXT_CHOOSE_PET_TYPE            = 70474, //"<Choose pet type>"
    BOT_TEXT_UR_DISMISSED               = 70475, //"You are dismissed"
    BOT_TEXT_ABANDON_WARN_1             = 70476, //"Are you going to abandon "
    BOT_TEXT_ABANDON_WARN_2             = 70477, //"You may regret it..."
    BOT_TEXT_PULL_URSELF                = 70478, //"Pull yourself together, damnit"
    BOT_TEXT_STUDY_CREATURE             = 70479, //"<Study the creature>"
    BOT_TEXT_NEVERMIND                  = 70480, //"Nevermind"
    BOT_TEXT_DISTANCE_SHORT             = 70481, //"dist"
    BOT_TEXT_BACK                       = 70482, //"BACK"
    BOT_TEXT_AUTO                       = 70483, //"<Auto>"
    BOT_TEXT_NONE2                      = 70484, //"<None>"
    BOT_TEXT_RANDOMPET_CUNNING          = 70485, //"Random (Cunning)"
    BOT_TEXT_RANDOMPET_FEROCITY         = 70486, //"Random (Ferocity)"
    BOT_TEXT_RANDOMPET_TENACITY         = 70487, //"Random (Tenacity)"
    BOT_TEXT_SHOW_INVENTORY             = 70488, //"Show me your inventory"
    BOT_TEXT_AUTOEQUIP                  = 70489, //"Auto-equip"
    BOT_TEXT_SLOT_MH                    = 70490, //"Main hand"
    BOT_TEXT_SLOT_OH                    = 70491, //"Off-hand"
    BOT_TEXT_SLOT_RH                    = 70492, //"Ranged"
    BOT_TEXT_SLOT_RELIC                 = 70493, //"Relic"
    BOT_TEXT_SLOT_HEAD                  = 70494, //"Head"
    BOT_TEXT_SLOT_SHOULDERS             = 70495, //"Shoulders"
    BOT_TEXT_SLOT_CHEST                 = 70496, //"Chest"
    BOT_TEXT_SLOT_WAIST                 = 70497, //"Waist"
    BOT_TEXT_SLOT_LEGS                  = 70498, //"Legs"
    BOT_TEXT_SLOT_FEET                  = 70499, //"Feet"
    BOT_TEXT_SLOT_WRIST                 = 70500, //"Wrist"
    BOT_TEXT_SLOT_HANDS                 = 70501, //"Hands"
    BOT_TEXT_SLOT_BACK                  = 70502, //"Back"
    BOT_TEXT_SLOT_SHIRT                 = 70503, //"Shirt"
    BOT_TEXT_SLOT_FINGER1               = 70504, //"Finger1"
    BOT_TEXT_SLOT_FINGER2               = 70505, //"Finger2"
    BOT_TEXT_SLOT_TRINKET1              = 70506, //"Trinket1"
    BOT_TEXT_SLOT_TRINKET2              = 70507, //"Trinket2"
    BOT_TEXT_SLOT_NECK                  = 70508, //"Neck"
    BOT_TEXT_UNEQUIP_ALL                = 70509, //"Unequip all"
    BOT_TEXT_UPDATE_VISUAL              = 70510, //"Update visual"
    BOT_TEXT_VISUALONLY                 = 70511, //"visual only"
    BOT_TEXT_EQUIPPED                   = 70512, //"Equipped"
    BOT_TEXT_NOTHING                    = 70513, //"nothing"
    BOT_TEXT_USE_OLD_EQUIPMENT          = 70514, //"Use your old equipment"
    BOT_TEXT_UNEQUIP                    = 70515, //"Unequip it"
    BOT_TEXT_NOTHING_TO_GIVE            = 70516, //"Hm... I have nothing to give you"
    BOT_TEXT_GATHERING                  = 70517, //"Gathering"
    BOT_TEXT_ABILITIES_STATUS           = 70518, //"Abilities status"
    BOT_TEXT_ALLOWED_ABILITIES          = 70519, //"Manage allowed abilities"
    BOT_TEXT_USE_                       = 70520, //"Use "
    BOT_TEXT_UPDATE                     = 70521, //"Update"
    BOT_TEXT_DAMAGE                     = 70522, //"Damage"
    BOT_TEXT_CONTROL                    = 70523, //"Control"
    BOT_TEXT_HEAL                       = 70524, //"Heal"
    BOT_TEXT_OTHER                      = 70525, //"Other"
    BOT_TEXT_HIRE_EMOTE_SPHYNX          = 70526, //" makes a grinding sound and begins to follow "
    BOT_TEXT_HIREFAIL_OWNED             = 70527, //"%s will not join you until dismissed by the owner"
    BOT_TEXT_HIREFAIL_LVL60             = 70528, //"%s will not join you until you are level 60"
    BOT_TEXT_HIREFAIL_LVL55             = 70529, //"%s will not join you until you are level 55"
    BOT_TEXT_HIREFAIL_LVL40             = 70530, //"%s will not join you until you are level 40"
    BOT_TEXT_HIREFAIL_LVL20             = 70531, //"%s will not join you until you are level 20"
    BOT_TEXT_HIREFAIL_MAXBOTS           = 70532, //"You exceed max npcbots (%u)"
    BOT_TEXT_HIREFAIL_COST              = 70533, //"You don't have enough money"
    BOT_TEXT_HIREFAIL_MAXCLASSBOTS      = 70534, //"You cannot have more bots of that class! %u of %u"
    BOT_TEXT_CANT_DISMISS_EQUIPMENT     = 70535, //"Cannot reset equipment in slot %u (%s)! Cannot dismiss bot!"
    BOT_TEXT_CURRENT                    = 70536, //"current"
    BOT_TEXT_ATTACK_DISTANCE            = 70537, //"Attack distance"
    BOT_TEXT_SHORT_RANGE_ATTACKS        = 70538, //"Short range attacks"
    BOT_TEXT_LONG_RANGE_ATTACKS         = 70539, //"Long range attacks"
    BOT_TEXT_EXACT                      = 70540, //"Exact"
    BOT_TEXT_REMOVE_BUFF                = 70541, //"Remove buff"
    BOT_TEXT_FIX_POWER                  = 70542, //"Fix your power type"
    BOT_TEXT_CANT_UNEQUIP_MAILING       = 70543, //"Cannot unequip %s for some stupid reason! Sending through mail"
    BOT_TEXT_TANK                       = 70544, //"Tank"
    BOT_TEXT_RANGED                     = 70545, //"Ranged"
    BOT_TEXT_MINER                      = 70546, //"Miner"
    BOT_TEXT_HERBALIST                  = 70547, //"Herbalist"
    BOT_TEXT_SKINNER                    = 70548, //"Skinner"
    BOT_TEXT_ENGINEER                   = 70549, //"Engineer"
    BOT_TEXT_OWNERSHIP_EXPIRED          = 70550, //"Bot ownership expired due to inactivity"
    BOT_TEXT_BOTADDFAIL_DISABLED        = 70551, //"NpcBot system is currently disabled. Please contact administration."
    BOT_TEXT_BOTADDFAIL_OWNED           = 70552, //"%s will not join you, already has master: %s"
    BOT_TEXT_BOTADDFAIL_TELEPORTED      = 70553, //"%s cannot join you while about to teleport"
    BOT_TEXT_ASPECT                     = 70554, //"Aspect"
    BOT_TEXT_MONKEY                     = 70555, //"Monkey"
    BOT_TEXT_HAWK                       = 70556, //"Hawk"
    BOT_TEXT_CHEETAH                    = 70557, //"Cheetah"
    BOT_TEXT_VIPER                      = 70558, //"Viper"
    BOT_TEXT_BEAST                      = 70559, //"Beast"
    BOT_TEXT_PACK                       = 70560, //"Pack"
    BOT_TEXT_WILD                       = 70561, //"Wild"
    BOT_TEXT_DRAGONHAWK                 = 70562, //"Dragonhawk"
    BOT_TEXT_NOASPECT                   = 70563, //"No Aspect"
    BOT_TEXT_AURA                       = 70564, //"Aura"
    BOT_TEXT_DEVOTION                   = 70565, //"Devotion"
    BOT_TEXT_CONCENTRATION              = 70566, //"Concentration"
    BOT_TEXT_FIRERESISTANCE             = 70567, //"Fire Resistance"
    BOT_TEXT_FROSTRESISTANCE            = 70568, //"Frost Resistance"
    BOT_TEXT_SHADOWRESISTANCE           = 70569, //"Shadow Resistance"
    BOT_TEXT_RETRIBUTION                = 70570, //"Retribution"
    BOT_TEXT_CRUSADER                   = 70571, //"Crusader"
    BOT_TEXT_NOAURA                     = 70572, //"No Aura"
    BOT_TEXT_CRIPPLING                  = 70573, //"Crippling"
    BOT_TEXT_INSTANT                    = 70574, //"Instant"
    BOT_TEXT_DEADLY                     = 70575, //"Deadly"
    BOT_TEXT_WOUND                      = 70576, //"Wound"
    BOT_TEXT_MINDNUMBING                = 70577, //"Mind-Numbing"
    BOT_TEXT_ANESTHETIC                 = 70578, //"Anesthetic"
    BOT_TEXT_NOTHING_C                  = 70579, //"Nothing"
    BOT_TEXT_FLAMETONGUE                = 70580, //"Flametongue"
    BOT_TEXT_FROSTBRAND                 = 70581, //"Frostbrand"
    BOT_TEXT_WINDFURY                   = 70582, //"Windfury"
    BOT_TEXT_EARTHLIVING                = 70583, //"Earthliving"
    BOT_TEXT_BOTGIVER_SERVICE           = 70584, //"I need your services"
    BOT_TEXT_BOTGIVER_TOO_MANY_BOTS     = 70585, //"You have too many bots"
    BOT_TEXT_BOTGIVER_WISH_TO_HIRE_     = 70586, //"Do you wish to hire "
    BOT_TEXT_BOTGIVER__BOT_BUSY         = 70587, //" is a bit busy at the moment, try again later."
    BOT_TEXT_BOTGIVER_HIRESUCCESS       = 70588, //"Pleasure doing business with you"
    BOT_TEXT_CLASS_WARRIOR_PLU          = 70589, //"Warriors"
    BOT_TEXT_CLASS_PALADIN_PLU          = 70590, //"Paladins"
    BOT_TEXT_CLASS_MAGE_PLU             = 70591, //"Mages"
    BOT_TEXT_CLASS_PRIEST_PLU           = 70592, //"Priests"
    BOT_TEXT_CLASS_WARLOCK_PLU          = 70593, //"Warlocks"
    BOT_TEXT_CLASS_DRUID_PLU            = 70594, //"Druids"
    BOT_TEXT_CLASS_DEATH_KNIGHT_PLU     = 70595, //"Death Knights"
    BOT_TEXT_CLASS_ROGUE_PLU            = 70596, //"Rogues"
    BOT_TEXT_CLASS_SHAMAN_PLU           = 70597, //"Shamans"
    BOT_TEXT_CLASS_HUNTER_PLU           = 70598, //"Hunters"
    BOT_TEXT_CLASS_BM_PLU               = 70599, //"Blademasters"
    BOT_TEXT_CLASS_SPHYNX_PLU           = 70600, //"Destroyers"
    BOT_TEXT_CLASS_ARCHMAGE_PLU         = 70601, //"Archmagi"
    BOT_TEXT_CLASS_DREADLORD_PLU        = 70602, //"Dreadlords"
    BOT_TEXT_CLASS_SPELLBREAKER_PLU     = 70603, //"Spell Breakers"
    BOT_TEXT_CLASS_DARK_RANGER_PLU      = 70604, //"Dark Rangers"
    BOT_TEXT_CLASS_WARRIOR              = 70605, //"Warrior"
    BOT_TEXT_CLASS_PALADIN              = 70606, //"Paladin"
    BOT_TEXT_CLASS_MAGE                 = 70607, //"Mage"
    BOT_TEXT_CLASS_PRIEST               = 70608, //"Priest"
    BOT_TEXT_CLASS_WARLOCK              = 70609, //"Warlock"
    BOT_TEXT_CLASS_DRUID                = 70610, //"Druid"
    BOT_TEXT_CLASS_DEATH_KNIGHT         = 70611, //"Death Knight"
    BOT_TEXT_CLASS_ROGUE                = 70612, //"Rogue"
    BOT_TEXT_CLASS_SHAMAN               = 70613, //"Shaman"
    BOT_TEXT_CLASS_HUNTER               = 70614, //"Hunter"
    BOT_TEXT_CLASS_BM                   = 70615, //"Blademaster"
    BOT_TEXT_CLASS_SPHYNX               = 70616, //"Destroyer"
    BOT_TEXT_CLASS_ARCHMAGE             = 70617, //"Archmage"
    BOT_TEXT_CLASS_DREADLORD            = 70618, //"Dreadlord"
    BOT_TEXT_CLASS_SPELLBREAKER         = 70619, //"Spell Breaker"
    BOT_TEXT_CLASS_DARK_RANGER          = 70620, //"Dark Ranger"
    BOT_TEXT_GENDER_MALE                = 70621, //"Male"
    BOT_TEXT_GENDER_FEMALE              = 70622, //"Female"
    BOT_TEXT_RACE_HUMAN                 = 70623, //"Human"
    BOT_TEXT_RACE_ORC                   = 70624, //"Orc"
    BOT_TEXT_RACE_DWARF                 = 70625, //"Dwarf"
    BOT_TEXT_RACE_NELF                  = 70626, //"Night Elf"
    BOT_TEXT_RACE_UNDEAD                = 70627, //"Undead"
    BOT_TEXT_RACE_TAUREN                = 70628, //"Tauren"
    BOT_TEXT_RACE_GNOME                 = 70629, //"Gnome"
    BOT_TEXT_RACE_TROLL                 = 70630, //"Troll"
    BOT_TEXT_RACE_BELF                  = 70631, //"Blood Elf"
    BOT_TEXT_RACE_DRAENEI               = 70632, //"Draenei"
    BOT_TEXT_RACE_UNKNOWN               = 70633, //"Unknown"
    BOT_TEXT_LOOTING                    = 70634, //"Looting"
    BOT_TEXT_POOR                       = 70635, //"Poor"
    BOT_TEXT_COMMON                     = 70636, //"Common"
    BOT_TEXT_UNCOMMON                   = 70637, //"Uncommon"
    BOT_TEXT_RARE                       = 70638, //"Rare"
    BOT_TEXT_EPIC                       = 70639, //"Epic"
    BOT_TEXT_LEGENDARY                  = 70640, //"Legendary"
    BOT_TEXT_ENGAGE_BEHAVIOR            = 70641, //"Engage behavior"
    BOT_TEXT_DELAY_ATTACK_BY            = 70642, //"Delay attack by"
    BOT_TEXT_DELAY_HEALING_BY           = 70643, //"Delay healing by"
    BOT_TEXT_SECOND_SHORT               = 70644, //"s"
    BOT_TEXT_TANK_OFF                   = 70645, //"Off-Tank"
    BOT_TEXT_CLASS_NECROMANCER_PLU      = 70646, //"Necromancers"
    BOT_TEXT_CLASS_NECROMANCER          = 70647, //"Necromancer"
    BOT_TEXT_ATTACK_ANGLE               = 70648, //"Attack angle"
    BOT_TEXT_NORMAL                     = 70649, //"Normal"
    BOT_TEXT_AVOID_FRONTAL_AOE          = 70650, //"Avoid frontal AOE"
    BOT_TEXT_HIREDENY_SEAWITCH          = 70651, //NIY
    BOT_TEXT_HIREWARN_SEAWITCH          = 70652, //"Are you sure this is gonna work? It's better be the best water in the world..."
    BOT_TEXT_HIREOPTION_SEAWITCH        = 70653, //"Seems like you could really use a drink of fresh water."
    BOT_TEXT_CLASS_SEAWITCH_PLU         = 70654, //"Sea Witches"
    BOT_TEXT_CLASS_SEAWITCH             = 70655, //"Sea Witch"
    BOT_TEXT_MANA_PER_DAMAGE            = 70656, //"Mana per damage"
    BOT_TEXT_DAMAGE_PER_MANA            = 70657, //"Damage per mana"
    BOT_TEXT_TRANSMOGRIFICATION         = 70658, //"Transmogrification..."
    //70659-70799 reserved for custom localization strings
//VEHICLE CREATURES
    CREATURE_NEXUS_SKYTALON_1           = 32535, // [Q] Aces High
    CREATURE_EOE_SKYTALON_N             = 30161, // Eye of Eternity
    CREATURE_EOE_SKYTALON_H             = 31752,
    CREATURE_OCULUS_DRAKE_RUBY          = 27756, // Oculus
    CREATURE_OCULUS_DRAKE_EMERALD       = 27692,
    CREATURE_OCULUS_DRAKE_AMBER         = 27755,
    //CREATURE_TOC_STEED_QUELDOREI        = 33845, // Argent Tournament
    //CREATURE_TOC_NIGHTSABER             = 33319,
    //CREATURE_TOC_STEED_STORMWIND        = 33217,
    //CREATURE_TOC_MECHANOSTRIDER         = 33317,
    //CREATURE_TOC_RAM                    = 33316,
    //CREATURE_TOC_ELEKK                  = 33318,
    //CREATURE_TOC_HAWKSTRIDER_SUNREAVER  = 33844,
    //CREATURE_TOC_RAPTOR                 = 33321,
    //CREATURE_TOC_WARHORSE               = 33324,
    //CREATURE_TOC_WOLF                   = 33320,
    //CREATURE_TOC_HAWKSTRIDER_SILVERMOON = 33323,
    //CREATURE_TOC_KODO                   = 33322,
    CREATURE_TOC5_WARHORSE              = 35644, // Trial of Champion
    CREATURE_TOC5_BATTLEWORG            = 36558,
    CREATURE_ULDUAR_DEMOLISHER          = 33109, // Ulduar
    CREATURE_ULDUAR_SIEGE_ENGINE        = 33060,
    CREATURE_ULDUAR_CHOPPER             = 33062,
    CREATURE_ULDUAR_CHOPPER1            = 34045,
    CREATURE_ICC_BONE_SPIKE1            = 36619, // Icecrown Citadel
    CREATURE_ICC_BONE_SPIKE2            = 38712,
    CREATURE_ICC_BONE_SPIKE3            = 38711,
    CREATURE_ICC_GUNSHIPCANNON_ALLIANCE = 36838,
    CREATURE_ICC_GUNSHIPCANNON_HORDE    = 36839,
    CREATURE_ICC_MUTATED_ABOMINATION1   = 38285,
    CREATURE_ICC_MUTATED_ABOMINATION2   = 38788,
    CREATURE_ICC_MUTATED_ABOMINATION3   = 38789,
    CREATURE_ICC_MUTATED_ABOMINATION4   = 38790,
    CREATURE_ICC_MUTATED_ABOMINATION5   = 37672,
    CREATURE_ICC_MUTATED_ABOMINATION6   = 38605,
    CREATURE_ICC_MUTATED_ABOMINATION7   = 38786,
    CREATURE_ICC_MUTATED_ABOMINATION8   = 38787,
//COMMON AOE TRIGGERS
    CREATURE_ZA_FIRE_BOMB               = 23920,
    CREATURE_EOE_STATIC_FIELD           = 30592,
    CREATURE_ICC_OOZE_PUDDLE            = 37690,
//COMMON ENEMY CREATURES
    CREATURE_BOSS_EREGOS_N              = 27656,
    CREATURE_BOSS_EREGOS_H              = 31561,
    CREATURE_ICC_SINDRAGOSA1            = 36853,
    CREATURE_ICC_SINDRAGOSA2            = 38265,
    CREATURE_ICC_SINDRAGOSA3            = 38266,
    CREATURE_ICC_SINDRAGOSA4            = 38267,
    CREATURE_ICC_ICE_TOMB1              = 36980,
    CREATURE_ICC_ICE_TOMB2              = 38320,
    CREATURE_ICC_ICE_TOMB3              = 38321,
    CREATURE_ICC_ICE_TOMB4              = 38322,
    CREATURE_ICC_VALKYR_LK1             = 36609,
    CREATURE_ICC_VALKYR_LK2             = 39120,
    CREATURE_ICC_VALKYR_LK3             = 39121,
    CREATURE_ICC_VALKYR_LK4             = 39122,
    CREATURE_ICC_ICE_SPHERE1            = 36633,
    CREATURE_ICC_ICE_SPHERE2            = 39305,
    CREATURE_ICC_ICE_SPHERE3            = 39306,
    CREATURE_ICC_ICE_SPHERE4            = 39307,
//COMMON NPCS
    SHAMAN_EARTH_ELEMENTAL              = 15352,
    SHAMAN_FIRE_ELEMENTAL               = 15438,
    //NPC_WORLD_TRIGGER                   = 22515,
//COMMON ITEM DISPLAY IDS
    CHEST_HALISCAN                      = 50566, //Haliscan Jacket
    LEGS_HALISCAN                       = 50567, //Haliscan Pants
//COMMON GAMEEVENTS
    GAME_EVENT_WINTER_VEIL              = 2,
//COMMON FACTIONS
    FACTION_TEMPLATE_HATES_EVERYTHING_1 = 2150, //faction 966 - Monster spar buddy
//COMMON AI MISC VALUES
    BOTAI_MISC_COMBO_POINTS             = 1,
    BOTAI_MISC_DAGGER_MAINHAND,
    BOTAI_MISC_DAGGER_OFFHAND,
    BOTAI_MISC_ENCHANT_IS_AUTO_MH,
    BOTAI_MISC_ENCHANT_IS_AUTO_OH,
    BOTAI_MISC_ENCHANT_CAN_EXPIRE_MH,
    BOTAI_MISC_ENCHANT_CAN_EXPIRE_OH,
    BOTAI_MISC_ENCHANT_CURRENT_MH,
    BOTAI_MISC_ENCHANT_CURRENT_OH,
    BOTAI_MISC_ENCHANT_AVAILABLE_1,
    BOTAI_MISC_ENCHANT_AVAILABLE_2,
    BOTAI_MISC_ENCHANT_AVAILABLE_3,
    BOTAI_MISC_ENCHANT_AVAILABLE_4,
    BOTAI_MISC_ENCHANT_AVAILABLE_5,
    BOTAI_MISC_ENCHANT_AVAILABLE_6,
    BOTAI_MISC_PET_TYPE,
    BOTAI_MISC_PET_AVAILABLE_1,
    BOTAI_MISC_PET_AVAILABLE_2,
    BOTAI_MISC_PET_AVAILABLE_3,
    BOTAI_MISC_PET_AVAILABLE_4,
    BOTAI_MISC_PET_AVAILABLE_5,
    BOTAI_MISC_PET_AVAILABLE_6,
    BOTAI_MISC_PET_AVAILABLE_7,
    BOTAI_MISC_PET_AVAILABLE_8,
    BOTAI_MISC_PET_AVAILABLE_9,
    BOTAI_MISC_PET_AVAILABLE_10,
    BOTAI_MISC_PET_AVAILABLE_11,
    BOTAI_MISC_WEAPON_SPEC,
    BOTPETAI_MISC_DURATION,
    BOTPETAI_MISC_MAXLEVEL,
  //SOUNDS
    SOUND_FREEZE_IMPACT_WINDWALK        = 29,
    SOUND_AXE_2H_IMPACT_FLESH_CRIT      = 158,
    SOUND_ABSORB_GET_HIT                = 3334,
    SOUND_MISS_WHOOSH_2H                = 7081,

//UNUSED
    //SPELL_SUMMON_FELBLAZE_PREVISUAL     = 46350,//green splash impact head/torso

//OTHER
    BASE_MANA_SPHYNX                    = 400 * 5,
    BASE_MANA_SPELLBREAKER              = 250 * 5,
    BASE_MANA_NECROMANCER               = 400 * 5,
    //base mana at 10
    BASE_MANA_10_BM                     = 540 * 5,
    BASE_MANA_10_ARCHMAGE               = 705 * 5,
    BASE_MANA_10_DREADLORD              = 600 * 5,
    BASE_MANA_10_DARK_RANGER            = 570 * 5,
    BASE_MANA_10_SEA_WITCH              = 735 * 5,
    //base mana at 1
    BASE_MANA_1_BM                      = 240 * 5,
    BASE_MANA_1_ARCHMAGE                = 285 * 5,
    BASE_MANA_1_DREADLORD               = 270 * 5,
    BASE_MANA_1_DARK_RANGER             = 225 * 5,
    BASE_MANA_1_SEA_WITCH               = 330 * 5,

    //MAX_LOOT_ITEMS                      = 18 // Client limitation 3.3.5 code confirmed
};

enum BotClasses : uint8
{
    BOT_CLASS_NONE                      = CLASS_NONE,
    BOT_CLASS_WARRIOR                   = CLASS_WARRIOR,
    BOT_CLASS_PALADIN                   = CLASS_PALADIN,
    BOT_CLASS_HUNTER                    = CLASS_HUNTER,
    BOT_CLASS_ROGUE                     = CLASS_ROGUE,
    BOT_CLASS_PRIEST                    = CLASS_PRIEST,
    BOT_CLASS_DEATH_KNIGHT              = CLASS_DEATH_KNIGHT,
    BOT_CLASS_SHAMAN                    = CLASS_SHAMAN,
    BOT_CLASS_MAGE                      = CLASS_MAGE,
    BOT_CLASS_WARLOCK                   = CLASS_WARLOCK,
    BOT_CLASS_DRUID                     = CLASS_DRUID,

    BOT_CLASS_BM,
    BOT_CLASS_SPHYNX,
    BOT_CLASS_ARCHMAGE,
    BOT_CLASS_DREADLORD,
    BOT_CLASS_SPELLBREAKER,
    BOT_CLASS_DARK_RANGER,
    BOT_CLASS_NECROMANCER,
    BOT_CLASS_SEA_WITCH,

    BOT_CLASS_END,

    BOT_CLASS_EX_START                  = BOT_CLASS_BM
};

enum BotStances
{
    BOT_STANCE_NONE                     = 0,
    WARRIOR_BATTLE_STANCE               = BOT_CLASS_END,
    WARRIOR_DEFENSIVE_STANCE,
    WARRIOR_BERSERKER_STANCE,
    DEATH_KNIGHT_BLOOD_PRESENCE,
    DEATH_KNIGHT_FROST_PRESENCE,
    DEATH_KNIGHT_UNHOLY_PRESENCE,
    DRUID_BEAR_FORM,
    DRUID_CAT_FORM,
    DRUID_MOONKIN_FORM,
    DRUID_TREE_FORM,
    DRUID_TRAVEL_FORM,
    DRUID_AQUATIC_FORM,
    //DRUID_FLIGHT_FORM //NYI
};

enum BotRoles : uint32
{
    BOT_ROLE_NONE                       = 0x00000,
    BOT_ROLE_TANK                       = 0x00001,
    BOT_ROLE_TANK_OFF                   = 0x00002,
    BOT_ROLE_DPS                        = 0x00004,
    BOT_ROLE_HEAL                       = 0x00008,
    BOT_ROLE_RANGED                     = 0x00010,

    BOT_ROLE_PARTY                      = 0x00020, //hidden

    BOT_ROLE_GATHERING_MINING           = 0x00040,
    BOT_ROLE_GATHERING_HERBALISM        = 0x00080,
    BOT_ROLE_GATHERING_SKINNING         = 0x00100,
    BOT_ROLE_GATHERING_ENGINEERING      = 0x00200,

    BOT_ROLE_AUTOLOOT                   = 0x00400, //not in mask
    BOT_ROLE_AUTOLOOT_POOR              = 0x00800,
    BOT_ROLE_AUTOLOOT_COMMON            = 0x01000,
    BOT_ROLE_AUTOLOOT_UNCOMMON          = 0x02000,
    BOT_ROLE_AUTOLOOT_RARE              = 0x04000,
    BOT_ROLE_AUTOLOOT_EPIC              = 0x08000,
    BOT_ROLE_AUTOLOOT_LEGENDARY         = 0x10000,

    BOT_MAX_ROLE                        = 0x20000,

    BOT_ROLE_MASK_MAIN                  = (BOT_ROLE_TANK | BOT_ROLE_TANK_OFF | BOT_ROLE_DPS | BOT_ROLE_HEAL | BOT_ROLE_RANGED),
    //BOT_ROLE_MASK_MAIN_EX               = (BOT_ROLE_TANK | BOT_ROLE_DPS | BOT_ROLE_HEAL | BOT_ROLE_RANGED | BOT_ROLE_PARTY),
    BOT_ROLE_MASK_GATHERING             = (BOT_ROLE_GATHERING_MINING | BOT_ROLE_GATHERING_HERBALISM | BOT_ROLE_GATHERING_SKINNING | BOT_ROLE_GATHERING_ENGINEERING),
    BOT_ROLE_MASK_LOOTING               = (BOT_ROLE_AUTOLOOT_POOR | BOT_ROLE_AUTOLOOT_COMMON | BOT_ROLE_AUTOLOOT_UNCOMMON | BOT_ROLE_AUTOLOOT_RARE | BOT_ROLE_AUTOLOOT_EPIC | BOT_ROLE_AUTOLOOT_LEGENDARY),

    //BOT_ROLE_TANK_MELEE                 = (BOT_ROLE_TANK | BOT_ROLE_DPS),
    //BOT_ROLE_TANK_RANGED                = (BOT_ROLE_TANK | BOT_ROLE_DPS | BOT_ROLE_RANGED),
    //BOT_ROLE_TANK_RANGED_NODPS          = (BOT_ROLE_TANK | BOT_ROLE_RANGED),
};

enum BotTalentSpecs
{
    BOT_SPEC_WARRIOR_ARMS               = 1,
    BOT_SPEC_WARRIOR_FURY               = 2,
    BOT_SPEC_WARRIOR_PROTECTION         = 3,
    BOT_SPEC_PALADIN_HOLY               = 4,
    BOT_SPEC_PALADIN_PROTECTION         = 5,
    BOT_SPEC_PALADIN_RETRIBUTION        = 6,
    BOT_SPEC_HUNTER_BEASTMASTERY        = 7,
    BOT_SPEC_HUNTER_MARKSMANSHIP        = 8,
    BOT_SPEC_HUNTER_SURVIVAL            = 9,
    BOT_SPEC_ROGUE_ASSASINATION         = 10,
    BOT_SPEC_ROGUE_COMBAT               = 11,
    BOT_SPEC_ROGUE_SUBTLETY             = 12,
    BOT_SPEC_PRIEST_DISCIPLINE          = 13,
    BOT_SPEC_PRIEST_HOLY                = 14,
    BOT_SPEC_PRIEST_SHADOW              = 15,
    BOT_SPEC_DK_BLOOD                   = 16,
    BOT_SPEC_DK_FROST                   = 17,
    BOT_SPEC_DK_UNHOLY                  = 18,
    BOT_SPEC_SHAMAN_ELEMENTAL           = 19,
    BOT_SPEC_SHAMAN_ENHANCEMENT         = 20,
    BOT_SPEC_SHAMAN_RESTORATION         = 21,
    BOT_SPEC_MAGE_ARCANE                = 22,
    BOT_SPEC_MAGE_FIRE                  = 23,
    BOT_SPEC_MAGE_FROST                 = 24,
    BOT_SPEC_WARLOCK_AFFLICTION         = 25,
    BOT_SPEC_WARLOCK_DEMONOLOGY         = 26,
    BOT_SPEC_WARLOCK_DESTRUCTION        = 27,
    BOT_SPEC_DRUID_BALANCE              = 28,
    BOT_SPEC_DRUID_FERAL                = 29,
    BOT_SPEC_DRUID_RESTORATION          = 30,
    BOT_SPEC_DEFAULT                    = 31,

    BOT_SPEC_BEGIN                      = BOT_SPEC_WARRIOR_ARMS,
    BOT_SPEC_END                        = BOT_SPEC_DEFAULT

};

enum BotPetTypes
{
    //Warlock
    BOT_PET_IMP                         = 70501,
    BOT_PET_VOIDWALKER                  = 70502,
    BOT_PET_SUCCUBUS                    = 70503,
    BOT_PET_FELHUNTER                   = 70504,
    BOT_PET_FELGUARD                    = 70505,

    BOT_PET_WARLOCK_START               = BOT_PET_IMP,
    BOT_PET_WARLOCK_END                 = BOT_PET_FELGUARD,

    //Hunter
    //cunning
    BOT_PET_SPIDER                      = 70506,
    BOT_PET_SERPENT                     = 70507,
    BOT_PET_BIRDOFPREY                  = 70508,
    BOT_PET_BAT                         = 70509,
    BOT_PET_WINDSERPENT                 = 70510,
    BOT_PET_RAVAGER                     = 70511,
    BOT_PET_DRAGONHAWK                  = 70512,
    BOT_PET_NETHERRAY                   = 70513,
    BOT_PET_SPOREBAT                    = 70514,
    //ferocity
    BOT_PET_CARRIONBIRD                 = 70515,
    BOT_PET_RAPTOR                      = 70516,
    BOT_PET_WOLF                        = 70517,
    BOT_PET_TALLSTRIDER                 = 70518,
    BOT_PET_CAT                         = 70519,
    BOT_PET_HYENA                       = 70520,
    BOT_PET_WASP                        = 70521,
    BOT_PET_TEROMOTH                    = 70522,
    //tenacity
    BOT_PET_SCORPID                     = 70523,
    BOT_PET_TURTLE                      = 70524,
    BOT_PET_GORILLA                     = 70525,
    BOT_PET_BEAR                        = 70526,
    BOT_PET_BOAR                        = 70527,
    BOT_PET_CRAB                        = 70528,
    BOT_PET_CROCOLISK                   = 70529,
    BOT_PET_WARPSTALKER                 = 70530,
    //cunning (exotic)
    BOT_PET_SILITHID                    = 70531,
    BOT_PET_CHIMAERA                    = 70532,
    //ferocity (exotic)
    BOT_PET_SPIRITBEAST                 = 70533,
    BOT_PET_COREHOUND                   = 70534,
    BOT_PET_DEVILSAUR                   = 70535,
    //tenacity (exotic)
    BOT_PET_RHINO                       = 70536,
    BOT_PET_WORM                        = 70537,

    BOT_PET_HUNTER_START                = BOT_PET_SPIDER,
    BOT_PET_HUNTER_END_GENERAL          = BOT_PET_WARPSTALKER,
    BOT_PET_HUNTER_END_EXOTIC           = BOT_PET_WORM,

    BOT_PET_CUNNING_START               = BOT_PET_SPIDER,
    BOT_PET_CUNNING_END                 = BOT_PET_SPOREBAT,
    BOT_PET_FEROCITY_START              = BOT_PET_CARRIONBIRD,
    BOT_PET_FEROCITY_END                = BOT_PET_TEROMOTH,
    BOT_PET_TENACITY_START              = BOT_PET_SCORPID,
    BOT_PET_TENACITY_END                = BOT_PET_WARPSTALKER,

    BOT_PET_EXOTIC_START                = BOT_PET_SILITHID,
    BOT_PET_EXOTIC_END                  = BOT_PET_WORM,

    //DK
    BOT_PET_GHOUL                       = 70538,
    BOT_PET_GARGOYLE                    = 70539,//NYI
    BOT_PET_DANCING_RUNE_WEAPON         = 70540,//NYI
    BOT_PET_AOD_GHOUL                   = 70541,//NYI

    //Priest
    BOT_PET_SHADOWFIEND                 = 70542,

    //Shaman
    BOT_PET_SPIRIT_WOLF                 = 70543,

    //Mage
    BOT_PET_WATER_ELEMENTAL             = 70544,

    //Druid
    BOT_PET_FORCE_OF_NATURE             = 70545,

    //Archmage
    BOT_PET_AWATER_ELEMENTAL            = 70556,

    //Dreadlord
    BOT_PET_INFERNAL                    = 70562,

    //Dark Ranger
    BOT_PET_DARK_MINION                 = 70573,
    BOT_PET_DARK_MINION_ELITE           = 70574,

    //Necromancer
    BOT_PET_NECROSKELETON               = 70580,

    BOT_PET_TORNADO                     = 70586,

    BOT_PET_INVALID                     = 99999
};

enum BotPetOriginalEntries
{
    ORIGINAL_ENTRY_IMP                  = 416,
    ORIGINAL_ENTRY_VOIDWALKER           = 1860,
    ORIGINAL_ENTRY_SUCCUBUS             = 1863,
    ORIGINAL_ENTRY_FELHUNTER            = 417,
    ORIGINAL_ENTRY_FELGUARD             = 17252,
    //ORIGINAL_ENTRY_GHOUL                = 26125,
    //ORIGINAL_ENTRY_SHADOWFIEND          = 19668,
    //ORIGINAL_ENTRY_SPIRIT_WOLF          = 29264,
    ORIGINAL_ENTRY_WATER_ELEMENTAL      = 510,
    //ORIGINAL_ENTRY_FORCE_OF_NATURE      = 1964,
    ORIGINAL_ENTRY_HUNTER_PET           = 1 // from Pet.cpp InitStatsForLevel()
};

enum BotEquipSlot
{
    BOT_SLOT_MAINHAND           = 0,
    BOT_SLOT_OFFHAND            = 1,
    BOT_SLOT_RANGED             = 2,
    BOT_SLOT_HEAD               = 3,
    BOT_SLOT_SHOULDERS          = 4,
    BOT_SLOT_CHEST              = 5,
    BOT_SLOT_WAIST              = 6,
    BOT_SLOT_LEGS               = 7,
    BOT_SLOT_FEET               = 8,
    BOT_SLOT_WRIST              = 9,
    BOT_SLOT_HANDS              = 10,
    BOT_SLOT_BACK               = 11,
    BOT_SLOT_BODY               = 12,
    BOT_SLOT_FINGER1            = 13,
    BOT_SLOT_FINGER2            = 14,
    BOT_SLOT_TRINKET1           = 15,
    BOT_SLOT_TRINKET2           = 16,
    BOT_SLOT_NECK               = 17,
    BOT_INVENTORY_SIZE
};

constexpr uint8 BOT_TRANSMOG_INVENTORY_SIZE = 13; // BOT_SLOT_BODY + 1

enum BotStatMods
{
    //ItemProtoType.h
    BOT_STAT_MOD_MANA                       = 0,
    BOT_STAT_MOD_HEALTH                     = 1,
    BOT_STAT_MOD_AGILITY                    = 3,
    BOT_STAT_MOD_STRENGTH                   = 4,
    BOT_STAT_MOD_INTELLECT                  = 5,
    BOT_STAT_MOD_SPIRIT                     = 6,
    BOT_STAT_MOD_STAMINA                    = 7,
    BOT_STAT_MOD_DEFENSE_SKILL_RATING       = 12,
    BOT_STAT_MOD_DODGE_RATING               = 13,
    BOT_STAT_MOD_PARRY_RATING               = 14,
    BOT_STAT_MOD_BLOCK_RATING               = 15,
    BOT_STAT_MOD_HIT_MELEE_RATING           = 16,
    BOT_STAT_MOD_HIT_RANGED_RATING          = 17,
    BOT_STAT_MOD_HIT_SPELL_RATING           = 18,
    BOT_STAT_MOD_CRIT_MELEE_RATING          = 19,
    BOT_STAT_MOD_CRIT_RANGED_RATING         = 20,
    BOT_STAT_MOD_CRIT_SPELL_RATING          = 21,
    BOT_STAT_MOD_HIT_TAKEN_MELEE_RATING     = 22,
    BOT_STAT_MOD_HIT_TAKEN_RANGED_RATING    = 23,
    BOT_STAT_MOD_HIT_TAKEN_SPELL_RATING     = 24,
    BOT_STAT_MOD_CRIT_TAKEN_MELEE_RATING    = 25,
    BOT_STAT_MOD_CRIT_TAKEN_RANGED_RATING   = 26,
    BOT_STAT_MOD_CRIT_TAKEN_SPELL_RATING    = 27,
    BOT_STAT_MOD_HASTE_MELEE_RATING         = 28,
    BOT_STAT_MOD_HASTE_RANGED_RATING        = 29,
    BOT_STAT_MOD_HASTE_SPELL_RATING         = 30,
    BOT_STAT_MOD_HIT_RATING                 = 31,
    BOT_STAT_MOD_CRIT_RATING                = 32,
    BOT_STAT_MOD_HIT_TAKEN_RATING           = 33,
    BOT_STAT_MOD_CRIT_TAKEN_RATING          = 34,
    BOT_STAT_MOD_RESILIENCE_RATING          = 35,
    BOT_STAT_MOD_HASTE_RATING               = 36,
    BOT_STAT_MOD_EXPERTISE_RATING           = 37,
    BOT_STAT_MOD_ATTACK_POWER               = 38,
    BOT_STAT_MOD_RANGED_ATTACK_POWER        = 39,
    BOT_STAT_MOD_FERAL_ATTACK_POWER         = 40,
    BOT_STAT_MOD_SPELL_HEALING_DONE         = 41,                 // deprecated
    BOT_STAT_MOD_SPELL_DAMAGE_DONE          = 42,                 // deprecated
    BOT_STAT_MOD_MANA_REGENERATION          = 43,
    BOT_STAT_MOD_ARMOR_PENETRATION_RATING   = 44,
    BOT_STAT_MOD_SPELL_POWER                = 45,
    BOT_STAT_MOD_HEALTH_REGEN               = 46,
    BOT_STAT_MOD_SPELL_PENETRATION          = 47,
    BOT_STAT_MOD_BLOCK_VALUE                = 48,
    //END ItemProtoType.h

    BOT_STAT_MOD_DAMAGE_MIN                 = BOT_STAT_MOD_BLOCK_VALUE + 1,
    BOT_STAT_MOD_DAMAGE_MAX,
    BOT_STAT_MOD_ARMOR,
    BOT_STAT_MOD_RESIST_HOLY,
    BOT_STAT_MOD_RESIST_FIRE,
    BOT_STAT_MOD_RESIST_NATURE,
    BOT_STAT_MOD_RESIST_FROST,
    BOT_STAT_MOD_RESIST_SHADOW,
    BOT_STAT_MOD_RESIST_ARCANE,
    BOT_STAT_MOD_EX,
    MAX_BOT_ITEM_MOD,

    BOT_STAT_MOD_RESISTANCE_START           = BOT_STAT_MOD_ARMOR
};

enum BotAIResetType
{
    BOTAI_RESET_INIT                    = 0x01,
    BOTAI_RESET_DISMISS                 = 0x02,
    BOTAI_RESET_LOST                    = 0x04,
    BOTAI_RESET_LOGOUT                  = 0x08,

    BOTAI_RESET_MASK_ABANDON_MASTER     = (BOTAI_RESET_INIT | BOTAI_RESET_DISMISS)
};

enum BotMovementType
{
    BOT_MOVE_POINT                      = 1,
    //BOT_MOVE_FOLLOW
    BOT_MOVE_CHASE
};

enum BotCommandStates
{
    BOT_COMMAND_STAY                    = 0x01,
    BOT_COMMAND_FOLLOW                  = 0x02,
    BOT_COMMAND_ATTACK                  = 0x04,
    BOT_COMMAND_COMBATRESET             = 0x08,
    BOT_COMMAND_FULLSTOP                = 0x10,
    BOT_COMMAND_ISSUED_ORDER            = 0x20,
    BOT_COMMAND_WALK                    = 0x40,

    BOT_COMMAND_MASK_UNCHASE            = BOT_COMMAND_STAY | BOT_COMMAND_FOLLOW | BOT_COMMAND_FULLSTOP,
    BOT_COMMAND_MASK_UNMOVING           = BOT_COMMAND_STAY | BOT_COMMAND_FULLSTOP | BOT_COMMAND_ISSUED_ORDER
};

#define FROM_ARRAY(arr) arr, arr + sizeof(arr) / sizeof(arr[0])

//Only non-persistent types are allowed
enum BotOrderTypes
{
    BOT_ORDER_NONE          = 0,
    BOT_ORDER_SPELLCAST     = 1
};
#define DEBUG_BOT_ORDERS 0
#define MAX_BOT_ORDERS_QUEUE_SIZE 3

enum BotVehicleStrats
{
    BOT_VEH_STRAT_NONE,
    BOT_VEH_STRAT_WYRMREST_SKYTALON,
    BOT_VEH_STRAT_RUBY_DRAKE,
    BOT_VEH_STRAT_EMERALD_DRAKE,
    BOT_VEH_STRAT_AMBER_DRAKE,
    BOT_VEH_STRAT_TOC5_MOUNT,
    BOT_VEH_STRAT_ULDUAR_DEMOLISHER,
    BOT_VEH_STRAT_ULDUAR_SIEGEENGINE,
    BOT_VEH_STRAT_ULDUAR_CHOPPER,

    BOT_VEH_STRAT_GENERIC
};

#endif
