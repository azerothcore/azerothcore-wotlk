/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Define.h"
#include "EnumFlag.h"

enum UnitBytes1Offsets : uint8
{
    UNIT_BYTES_1_OFFSET_STAND_STATE     = 0,
    UNIT_BYTES_1_OFFSET_PET_TALENTS     = 1,
    UNIT_BYTES_1_OFFSET_VIS_FLAG        = 2,
    UNIT_BYTES_1_OFFSET_ANIM_TIER       = 3
};

// byte value (UNIT_FIELD_BYTES_1, 0)
enum UnitStandStateType
{
    UNIT_STAND_STATE_STAND              = 0,
    UNIT_STAND_STATE_SIT                = 1,
    UNIT_STAND_STATE_SIT_CHAIR          = 2,
    UNIT_STAND_STATE_SLEEP              = 3,
    UNIT_STAND_STATE_SIT_LOW_CHAIR      = 4,
    UNIT_STAND_STATE_SIT_MEDIUM_CHAIR   = 5,
    UNIT_STAND_STATE_SIT_HIGH_CHAIR     = 6,
    UNIT_STAND_STATE_DEAD               = 7,
    UNIT_STAND_STATE_KNEEL              = 8,
    UNIT_STAND_STATE_SUBMERGED          = 9
};

// byte flag value (UNIT_FIELD_BYTES_1, 2)
enum UnitStandFlags
{
    UNIT_STAND_FLAGS_UNK1               = 0x01,
    UNIT_STAND_FLAGS_CREEP              = 0x02,
    UNIT_STAND_FLAGS_UNTRACKABLE        = 0x04,
    UNIT_STAND_FLAGS_UNK4               = 0x08,
    UNIT_STAND_FLAGS_UNK5               = 0x10,
    UNIT_STAND_FLAGS_ALL                = 0xFF
};

// byte flags value (UNIT_FIELD_BYTES_1, 3)
enum UnitBytes1_Flags
{
    UNIT_BYTE1_FLAG_GROUND              = 0x00,
    UNIT_BYTE1_FLAG_ALWAYS_STAND        = 0x01,
    UNIT_BYTE1_FLAG_HOVER               = 0x02,
    UNIT_BYTE1_FLAG_FLY                 = 0x03,
    UNIT_BYTE1_FLAG_SUBMERGED           = 0x04,
    UNIT_BYTE1_FLAG_ALL                 = 0xFF
};

// high byte (3 from 0..3) of UNIT_FIELD_BYTES_2
enum ShapeshiftForm
{
    FORM_NONE                           = 0x00,
    FORM_CAT                            = 0x01,
    FORM_TREE                           = 0x02,
    FORM_TRAVEL                         = 0x03,
    FORM_AQUA                           = 0x04,
    FORM_BEAR                           = 0x05,
    FORM_AMBIENT                        = 0x06,
    FORM_GHOUL                          = 0x07,
    FORM_DIREBEAR                       = 0x08,
    FORM_STEVES_GHOUL                   = 0x09,
    FORM_THARONJA_SKELETON              = 0x0A,
    FORM_TEST_OF_STRENGTH               = 0x0B,
    FORM_BLB_PLAYER                     = 0x0C,
    FORM_SHADOW_DANCE                   = 0x0D,
    FORM_CREATUREBEAR                   = 0x0E,
    FORM_CREATURECAT                    = 0x0F,
    FORM_GHOSTWOLF                      = 0x10,
    FORM_BATTLESTANCE                   = 0x11,
    FORM_DEFENSIVESTANCE                = 0x12,
    FORM_BERSERKERSTANCE                = 0x13,
    FORM_TEST                           = 0x14,
    FORM_ZOMBIE                         = 0x15,
    FORM_METAMORPHOSIS                  = 0x16,
    FORM_UNDEAD                         = 0x19,
    FORM_MASTER_ANGLER                  = 0x1A,
    FORM_FLIGHT_EPIC                    = 0x1B,
    FORM_SHADOW                         = 0x1C,
    FORM_FLIGHT                         = 0x1D,
    FORM_STEALTH                        = 0x1E,
    FORM_MOONKIN                        = 0x1F,
    FORM_SPIRITOFREDEMPTION             = 0x20
};

enum ShapeshiftFlags
{
    SHAPESHIFT_FLAG_STANCE                          = 0x00000001,   // Form allows various player activities, which normally cause "You can't X while shapeshifted." errors (npc/go interaction, item use, etc)
    SHAPESHIFT_FLAG_NOT_TOGGLEABLE                  = 0x00000002,   // NYI
    SHAPESHIFT_FLAG_PERSIST_ON_DEATH                = 0x00000004,   // NYI
    SHAPESHIFT_FLAG_CAN_NPC_INTERACT                = 0x00000008,   // Form unconditionally allows talking to NPCs while shapeshifted (even if other activities are disabled)
    SHAPESHIFT_FLAG_DONT_USE_WEAPON                 = 0x00000010,   // NYI
    SHAPESHIFT_FLAG_AGILITY_ATTACK_BONUS            = 0x00000020,   // Druid Cat form
    SHAPESHIFT_FLAG_CAN_USE_EQUIPPED_ITEMS          = 0x00000040,   // NYI
    SHAPESHIFT_FLAG_CAN_USE_ITEMS                   = 0x00000080,   // NYI
    SHAPESHIFT_FLAG_DONT_AUTO_UNSHIFT               = 0x00000100,   // Handled at client side
    SHAPESHIFT_FLAG_CONSIDERED_DEAD                 = 0x00000200,   // NYI
    SHAPESHIFT_FLAG_CAN_ONLY_CAST_SHAPESHIFT_SPELLS = 0x00000400,   // NYI
    SHAPESHIFT_FLAG_STANCE_CANCEL_AT_FLIGHTMASTER   = 0x00000800,   // NYI
    SHAPESHIFT_FLAG_NO_EMOTE_SOUNDS                 = 0x00001000,   // NYI
    SHAPESHIFT_FLAG_NO_TRIGGER_TELEPORT             = 0x00002000,   // NYI
    SHAPESHIFT_FLAG_CANNOT_CHANGE_EQUIPPED_ITEMS    = 0x00004000,   // NYI
    SHAPESHIFT_FLAG_RESUMMON_PETS_ON_UNSHIFT        = 0x00008000,   // NYI
    SHAPESHIFT_FLAG_CANNOT_USE_GAME_OBJECTS         = 0x00010000,   // NYI
};

// low byte (0 from 0..3) of UNIT_FIELD_BYTES_2
enum SheathState
{
    SHEATH_STATE_UNARMED                = 0,        // non prepared weapon
    SHEATH_STATE_MELEE                  = 1,        // prepared melee weapon
    SHEATH_STATE_RANGED                 = 2         // prepared ranged weapon
};

#define MAX_SHEATH_STATE    3

// byte (1 from 0..3) of UNIT_FIELD_BYTES_2
enum UnitPVPStateFlags
{
    UNIT_BYTE2_FLAG_PVP                 = 0x01,
    UNIT_BYTE2_FLAG_UNK1                = 0x02,
    UNIT_BYTE2_FLAG_FFA_PVP             = 0x04,
    UNIT_BYTE2_FLAG_SANCTUARY           = 0x08,
    UNIT_BYTE2_FLAG_UNK4                = 0x10,
    UNIT_BYTE2_FLAG_UNK5                = 0x20,
    UNIT_BYTE2_FLAG_UNK6                = 0x40,
    UNIT_BYTE2_FLAG_UNK7                = 0x80
};

// byte (2 from 0..3) of UNIT_FIELD_BYTES_2
enum UnitRename
{
    UNIT_CAN_BE_RENAMED                 = 0x01,
    UNIT_CAN_BE_ABANDONED               = 0x02
};

enum UnitTypeMask
{
    UNIT_MASK_NONE                      = 0x00000000,
    UNIT_MASK_SUMMON                    = 0x00000001,
    UNIT_MASK_MINION                    = 0x00000002,
    UNIT_MASK_GUARDIAN                  = 0x00000004,
    UNIT_MASK_TOTEM                     = 0x00000008,
    UNIT_MASK_PET                       = 0x00000010,
    UNIT_MASK_VEHICLE                   = 0x00000020,
    UNIT_MASK_PUPPET                    = 0x00000040,
    UNIT_MASK_HUNTER_PET                = 0x00000080,
    UNIT_MASK_CONTROLLABLE_GUARDIAN     = 0x00000100,
    UNIT_MASK_ACCESSORY                 = 0x00000200
};

enum UnitState
{
    UNIT_STATE_DIED                     = 0x00000001,       // player has fake death aura
    UNIT_STATE_MELEE_ATTACKING          = 0x00000002,       // player is melee attacking someone
    UNIT_STATE_CHARMED                  = 0x00000004,       // having any kind of charm aura on self
    UNIT_STATE_STUNNED                  = 0x00000008,
    UNIT_STATE_ROAMING                  = 0x00000010,
    UNIT_STATE_CHASE                    = 0x00000020,
    //UNIT_STATE_SEARCHING              = 0x00000040,
    UNIT_STATE_FLEEING                  = 0x00000080,
    UNIT_STATE_IN_FLIGHT                = 0x00000100,       // player is in flight mode
    UNIT_STATE_FOLLOW                   = 0x00000200,
    UNIT_STATE_ROOT                     = 0x00000400,
    UNIT_STATE_CONFUSED                 = 0x00000800,
    UNIT_STATE_DISTRACTED               = 0x00001000,
    UNIT_STATE_ISOLATED                 = 0x00002000,       // area auras do not affect other players
    UNIT_STATE_ATTACK_PLAYER            = 0x00004000,
    UNIT_STATE_CASTING                  = 0x00008000,
    UNIT_STATE_POSSESSED                = 0x00010000,
    UNIT_STATE_CHARGING                 = 0x00020000,
    UNIT_STATE_JUMPING                  = 0x00040000,
    UNIT_STATE_MOVE                     = 0x00100000,
    UNIT_STATE_ROTATING                 = 0x00200000,
    UNIT_STATE_EVADE                    = 0x00400000,
    UNIT_STATE_ROAMING_MOVE             = 0x00800000,
    UNIT_STATE_CONFUSED_MOVE            = 0x01000000,
    UNIT_STATE_FLEEING_MOVE             = 0x02000000,
    UNIT_STATE_CHASE_MOVE               = 0x04000000,
    UNIT_STATE_FOLLOW_MOVE              = 0x08000000,
    UNIT_STATE_IGNORE_PATHFINDING       = 0x10000000,       // do not use pathfinding in any MovementGenerator
    UNIT_STATE_NO_ENVIRONMENT_UPD       = 0x20000000,

    // serverside region
    UNIT_STATE_NO_COMBAT_MOVEMENT       = 0x40000000,       // should not be changed outside the core and should be placed at the end
    UNIT_STATE_LOGOUT_TIMER             = 0x80000000,       // Unit is logging out

    UNIT_STATE_ALL_STATE_SUPPORTED = UNIT_STATE_DIED | UNIT_STATE_MELEE_ATTACKING | UNIT_STATE_CHARMED | UNIT_STATE_STUNNED | UNIT_STATE_ROAMING | UNIT_STATE_CHASE
    | UNIT_STATE_FLEEING | UNIT_STATE_IN_FLIGHT | UNIT_STATE_FOLLOW | UNIT_STATE_ROOT | UNIT_STATE_CONFUSED
    | UNIT_STATE_DISTRACTED | UNIT_STATE_ISOLATED | UNIT_STATE_ATTACK_PLAYER | UNIT_STATE_CASTING
    | UNIT_STATE_POSSESSED | UNIT_STATE_CHARGING | UNIT_STATE_JUMPING | UNIT_STATE_MOVE | UNIT_STATE_ROTATING
    | UNIT_STATE_EVADE | UNIT_STATE_ROAMING_MOVE | UNIT_STATE_CONFUSED_MOVE | UNIT_STATE_FLEEING_MOVE
    | UNIT_STATE_CHASE_MOVE | UNIT_STATE_FOLLOW_MOVE | UNIT_STATE_IGNORE_PATHFINDING | UNIT_STATE_NO_ENVIRONMENT_UPD,

    UNIT_STATE_UNATTACKABLE             = UNIT_STATE_IN_FLIGHT,

    // for real move using movegen check and stop (except unstoppable flight)
    UNIT_STATE_MOVING                   = UNIT_STATE_ROAMING_MOVE | UNIT_STATE_CONFUSED_MOVE | UNIT_STATE_FLEEING_MOVE | UNIT_STATE_CHASE_MOVE | UNIT_STATE_FOLLOW_MOVE,
    UNIT_STATE_CONTROLLED               = (UNIT_STATE_CONFUSED | UNIT_STATE_STUNNED | UNIT_STATE_FLEEING),
    UNIT_STATE_LOST_CONTROL             = (UNIT_STATE_CONTROLLED | UNIT_STATE_JUMPING | UNIT_STATE_CHARGING),
    UNIT_STATE_SIGHTLESS                = (UNIT_STATE_LOST_CONTROL | UNIT_STATE_EVADE),
    UNIT_STATE_CANNOT_AUTOATTACK        = (UNIT_STATE_LOST_CONTROL | UNIT_STATE_CASTING),
    UNIT_STATE_CANNOT_TURN              = (UNIT_STATE_LOST_CONTROL | UNIT_STATE_ROTATING | UNIT_STATE_ROOT),

    // stay by different reasons
    UNIT_STATE_NOT_MOVE                 = UNIT_STATE_ROOT | UNIT_STATE_STUNNED | UNIT_STATE_DIED | UNIT_STATE_DISTRACTED,
    UNIT_STATE_IGNORE_ANTISPEEDHACK     = UNIT_STATE_FLEEING | UNIT_STATE_CONFUSED | UNIT_STATE_CHARGING | UNIT_STATE_DISTRACTED | UNIT_STATE_POSSESSED,
    UNIT_STATE_ALL_STATE                = 0xffffffff        //(UNIT_STATE_STOPPED | UNIT_STATE_MOVING | UNIT_STATE_IN_COMBAT | UNIT_STATE_IN_FLIGHT)
};

// Used for IsClass hook
enum ClassContext : uint8
{
    CLASS_CONTEXT_NONE                  = 0,    // Default
    CLASS_CONTEXT_INIT                  = 1,
    CLASS_CONTEXT_TELEPORT              = 2,
    CLASS_CONTEXT_QUEST                 = 3,
    CLASS_CONTEXT_STATS                 = 4,
    CLASS_CONTEXT_TAXI                  = 5,
    CLASS_CONTEXT_SKILL                 = 6,
    CLASS_CONTEXT_TALENT_POINT_CALC     = 7,
    CLASS_CONTEXT_ABILITY               = 8,
    CLASS_CONTEXT_ABILITY_REACTIVE      = 9,
    CLASS_CONTEXT_PET                   = 10,
    CLASS_CONTEXT_PET_CHARM             = 11,
    CLASS_CONTEXT_EQUIP_RELIC           = 12,
    CLASS_CONTEXT_EQUIP_SHIELDS         = 13,
    CLASS_CONTEXT_EQUIP_ARMOR_CLASS     = 14,
    CLASS_CONTEXT_WEAPON_SWAP           = 15,
    CLASS_CONTEXT_GRAVEYARD             = 16,
    CLASS_CONTEXT_CLASS_TRAINER         = 17
};

// Value masks for UNIT_FIELD_FLAGS
enum UnitFlags : uint32
{
    UNIT_FLAG_NONE                          = 0x00000000,
    UNIT_FLAG_SERVER_CONTROLLED             = 0x00000001,       // set only when unit movement is controlled by server - by SPLINE/MONSTER_MOVE packets, together with UNIT_FLAG_STUNNED; only set to units controlled by client; client function CGUnit_C::IsClientControlled returns false when set for owner
    UNIT_FLAG_NON_ATTACKABLE                = 0x00000002,       // not attackable
    UNIT_FLAG_DISABLE_MOVE                  = 0x00000004,
    UNIT_FLAG_PLAYER_CONTROLLED             = 0x00000008,       // controlled by player, use _IMMUNE_TO_PC instead of _IMMUNE_TO_NPC
    UNIT_FLAG_RENAME                        = 0x00000010,
    UNIT_FLAG_PREPARATION                   = 0x00000020,       // don't take reagents for spells with SPELL_ATTR5_NO_REAGENT_COST_WITH_AURA
    UNIT_FLAG_UNK_6                         = 0x00000040,
    UNIT_FLAG_NOT_ATTACKABLE_1              = 0x00000080,       // ?? (UNIT_FLAG_PLAYER_CONTROLLED | UNIT_FLAG_NOT_ATTACKABLE_1) is NON_PVP_ATTACKABLE
    UNIT_FLAG_IMMUNE_TO_PC                  = 0x00000100,       // disables combat/assistance with PlayerCharacters (PC) - see Unit::_IsValidAttackTarget, Unit::_IsValidAssistTarget
    UNIT_FLAG_IMMUNE_TO_NPC                 = 0x00000200,       // disables combat/assistance with NonPlayerCharacters (NPC) - see Unit::_IsValidAttackTarget, Unit::_IsValidAssistTarget
    UNIT_FLAG_LOOTING                       = 0x00000400,       // loot animation
    UNIT_FLAG_PET_IN_COMBAT                 = 0x00000800,       // in combat?, 2.0.8
    UNIT_FLAG_PVP                           = 0x00001000,       // changed in 3.0.3
    UNIT_FLAG_SILENCED                      = 0x00002000,       // silenced, 2.1.1
    UNIT_FLAG_CANNOT_SWIM                   = 0x00004000,       // 2.0.8
    UNIT_FLAG_SWIMMING                      = 0x00008000,       // shows swim animation in water
    UNIT_FLAG_NON_ATTACKABLE_2              = 0x00010000,       // removes attackable icon, if on yourself, cannot assist self but can cast TARGET_SELF spells - added by SPELL_AURA_MOD_UNATTACKABLE
    UNIT_FLAG_PACIFIED                      = 0x00020000,       // 3.0.3 ok
    UNIT_FLAG_STUNNED                       = 0x00040000,       // 3.0.3 ok
    UNIT_FLAG_IN_COMBAT                     = 0x00080000,
    UNIT_FLAG_TAXI_FLIGHT                   = 0x00100000,       // disable casting at client side spell not allowed by taxi flight (mounted?), probably used with 0x4 flag
    UNIT_FLAG_DISARMED                      = 0x00200000,       // 3.0.3, disable melee spells casting..., "Required melee weapon" added to melee spells tooltip.
    UNIT_FLAG_CONFUSED                      = 0x00400000,
    UNIT_FLAG_FLEEING                       = 0x00800000,
    UNIT_FLAG_POSSESSED                     = 0x01000000,       // under direct client control by a player (possess or vehicle)
    UNIT_FLAG_NOT_SELECTABLE                = 0x02000000,
    UNIT_FLAG_SKINNABLE                     = 0x04000000,
    UNIT_FLAG_MOUNT                         = 0x08000000,
    UNIT_FLAG_UNK_28                        = 0x10000000,
    UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT = 0x20000000,       // Prevent automatically playing emotes from parsing chat text, for example "lol" in /say, ending message with ? or !, or using /yell
    UNIT_FLAG_SHEATHE                       = 0x40000000,
    UNIT_FLAG_IMMUNE                        = 0x80000000        // Immune to damage
};
DEFINE_ENUM_FLAG(UnitFlags);

// Value masks for UNIT_FIELD_FLAGS_2
enum UnitFlags2 : uint32
{
    UNIT_FLAG2_NONE                         = 0x00000000,
    UNIT_FLAG2_FEIGN_DEATH                  = 0x00000001,
    UNIT_FLAG2_HIDE_BODY                    = 0x00000002,       // Hide unit model (show only player equip)
    UNIT_FLAG2_IGNORE_REPUTATION            = 0x00000004,
    UNIT_FLAG2_COMPREHEND_LANG              = 0x00000008,
    UNIT_FLAG2_MIRROR_IMAGE                 = 0x00000010,
    UNIT_FLAG2_DO_NOT_FADE_IN               = 0x00000020,       // Unit model instantly appears when summoned (does not fade in)
    UNIT_FLAG2_FORCE_MOVEMENT               = 0x00000040,
    UNIT_FLAG2_DISARM_OFFHAND               = 0x00000080,
    UNIT_FLAG2_DISABLE_PRED_STATS           = 0x00000100,       // Player has disabled predicted stats (Used by raid frames)
    UNIT_FLAG2_DISARM_RANGED                = 0x00000400,       // this does not disable ranged weapon display (maybe additional flag needed?)
    UNIT_FLAG2_REGENERATE_POWER             = 0x00000800,
    UNIT_FLAG2_RESTRICT_PARTY_INTERACTION   = 0x00001000,       // Restrict interaction to party or raid
    UNIT_FLAG2_PREVENT_SPELL_CLICK          = 0x00002000,       // Prevent spellclick
    UNIT_FLAG2_ALLOW_ENEMY_INTERACT         = 0x00004000,
    UNIT_FLAG2_CANNOT_TURN                  = 0x00008000,
    UNIT_FLAG2_UNK2                         = 0x00010000,
    UNIT_FLAG2_PLAY_DEATH_ANIM              = 0x00020000,       // Plays special death animation upon death
    UNIT_FLAG2_ALLOW_CHEAT_SPELLS           = 0x00040000,       // Allows casting spells with AttributesEx7 & SPELL_ATTR7_DEBUG_SPELL
    UNIT_FLAG2_UNUSED_6                     = 0x01000000
};
DEFINE_ENUM_FLAG(UnitFlags2);

/// Non Player Character flags
enum NPCFlags : uint32
{
    UNIT_NPC_FLAG_NONE                      = 0x00000000,       // SKIP
    UNIT_NPC_FLAG_GOSSIP                    = 0x00000001,       // TITLE has gossip menu DESCRIPTION 100%
    UNIT_NPC_FLAG_QUESTGIVER                = 0x00000002,       // TITLE is quest giver DESCRIPTION guessed, probably ok
    UNIT_NPC_FLAG_UNK1                      = 0x00000004,
    UNIT_NPC_FLAG_UNK2                      = 0x00000008,
    UNIT_NPC_FLAG_TRAINER                   = 0x00000010,       // TITLE is trainer DESCRIPTION 100%
    UNIT_NPC_FLAG_TRAINER_CLASS             = 0x00000020,       // TITLE is class trainer DESCRIPTION 100%
    UNIT_NPC_FLAG_TRAINER_PROFESSION        = 0x00000040,       // TITLE is profession trainer DESCRIPTION 100%
    UNIT_NPC_FLAG_VENDOR                    = 0x00000080,       // TITLE is vendor (generic) DESCRIPTION 100%
    UNIT_NPC_FLAG_VENDOR_AMMO               = 0x00000100,       // TITLE is vendor (ammo) DESCRIPTION 100%, general goods vendor
    UNIT_NPC_FLAG_VENDOR_FOOD               = 0x00000200,       // TITLE is vendor (food) DESCRIPTION 100%
    UNIT_NPC_FLAG_VENDOR_POISON             = 0x00000400,       // TITLE is vendor (poison) DESCRIPTION guessed
    UNIT_NPC_FLAG_VENDOR_REAGENT            = 0x00000800,       // TITLE is vendor (reagents) DESCRIPTION 100%
    UNIT_NPC_FLAG_REPAIR                    = 0x00001000,       // TITLE can repair DESCRIPTION 100%
    UNIT_NPC_FLAG_FLIGHTMASTER              = 0x00002000,       // TITLE is flight master DESCRIPTION 100%
    UNIT_NPC_FLAG_SPIRITHEALER              = 0x00004000,       // TITLE is spirit healer DESCRIPTION guessed
    UNIT_NPC_FLAG_SPIRITGUIDE               = 0x00008000,       // TITLE is spirit guide DESCRIPTION guessed
    UNIT_NPC_FLAG_INNKEEPER                 = 0x00010000,       // TITLE is innkeeper
    UNIT_NPC_FLAG_BANKER                    = 0x00020000,       // TITLE is banker DESCRIPTION 100%
    UNIT_NPC_FLAG_PETITIONER                = 0x00040000,       // TITLE handles guild/arena petitions DESCRIPTION 100% 0xC0000 = guild petitions, 0x40000 = arena team petitions
    UNIT_NPC_FLAG_TABARDDESIGNER            = 0x00080000,       // TITLE is guild tabard designer DESCRIPTION 100%
    UNIT_NPC_FLAG_BATTLEMASTER              = 0x00100000,       // TITLE is battlemaster DESCRIPTION 100%
    UNIT_NPC_FLAG_AUCTIONEER                = 0x00200000,       // TITLE is auctioneer DESCRIPTION 100%
    UNIT_NPC_FLAG_STABLEMASTER              = 0x00400000,       // TITLE is stable master DESCRIPTION 100%
    UNIT_NPC_FLAG_GUILD_BANKER              = 0x00800000,       // TITLE is guild banker DESCRIPTION cause client to send 997 opcode
    UNIT_NPC_FLAG_SPELLCLICK                = 0x01000000,       // TITLE has spell click enabled DESCRIPTION cause client to send 1015 opcode (spell click)
    UNIT_NPC_FLAG_PLAYER_VEHICLE            = 0x02000000,       // TITLE is player vehicle DESCRIPTION players with mounts that have vehicle data should have it set
    UNIT_NPC_FLAG_MAILBOX                   = 0x04000000,       // TITLE is mailbox

    UNIT_NPC_FLAG_VENDOR_MASK = UNIT_NPC_FLAG_VENDOR | UNIT_NPC_FLAG_VENDOR_AMMO | UNIT_NPC_FLAG_VENDOR_POISON | UNIT_NPC_FLAG_VENDOR_REAGENT
};
DEFINE_ENUM_FLAG(NPCFlags);

enum UnitMoveType
{
    MOVE_WALK           = 0,
    MOVE_RUN            = 1,
    MOVE_RUN_BACK       = 2,
    MOVE_SWIM           = 3,
    MOVE_SWIM_BACK      = 4,
    MOVE_TURN_RATE      = 5,
    MOVE_FLIGHT         = 6,
    MOVE_FLIGHT_BACK    = 7,
    MOVE_PITCH_RATE     = 8
};

#define MAX_MOVE_TYPE     9

enum MovementFlags
{
    MOVEMENTFLAG_NONE                       = 0x00000000,
    MOVEMENTFLAG_FORWARD                    = 0x00000001,
    MOVEMENTFLAG_BACKWARD                   = 0x00000002,
    MOVEMENTFLAG_STRAFE_LEFT                = 0x00000004,
    MOVEMENTFLAG_STRAFE_RIGHT               = 0x00000008,
    MOVEMENTFLAG_LEFT                       = 0x00000010,
    MOVEMENTFLAG_RIGHT                      = 0x00000020,
    MOVEMENTFLAG_PITCH_UP                   = 0x00000040,
    MOVEMENTFLAG_PITCH_DOWN                 = 0x00000080,
    MOVEMENTFLAG_WALKING                    = 0x00000100,       // Walking
    MOVEMENTFLAG_ONTRANSPORT                = 0x00000200,       // Used for flying on some creatures
    MOVEMENTFLAG_DISABLE_GRAVITY            = 0x00000400,       // Former MOVEMENTFLAG_LEVITATING. This is used when walking is not possible.
    MOVEMENTFLAG_ROOT                       = 0x00000800,       // Must not be set along with MOVEMENTFLAG_MASK_MOVING
    MOVEMENTFLAG_FALLING                    = 0x00001000,       // damage dealt on that type of falling
    MOVEMENTFLAG_FALLING_FAR                = 0x00002000,
    MOVEMENTFLAG_PENDING_STOP               = 0x00004000,
    MOVEMENTFLAG_PENDING_STRAFE_STOP        = 0x00008000,
    MOVEMENTFLAG_PENDING_FORWARD            = 0x00010000,
    MOVEMENTFLAG_PENDING_BACKWARD           = 0x00020000,
    MOVEMENTFLAG_PENDING_STRAFE_LEFT        = 0x00040000,
    MOVEMENTFLAG_PENDING_STRAFE_RIGHT       = 0x00080000,
    MOVEMENTFLAG_PENDING_ROOT               = 0x00100000,
    MOVEMENTFLAG_SWIMMING                   = 0x00200000,       // appears with fly flag also
    MOVEMENTFLAG_ASCENDING                  = 0x00400000,       // press "space" when flying
    MOVEMENTFLAG_DESCENDING                 = 0x00800000,
    MOVEMENTFLAG_CAN_FLY                    = 0x01000000,       // Appears when unit can fly AND also walk
    MOVEMENTFLAG_FLYING                     = 0x02000000,       // unit is actually flying. pretty sure this is only used for players. creatures use disable_gravity
    MOVEMENTFLAG_SPLINE_ELEVATION           = 0x04000000,       // used for flight paths
    MOVEMENTFLAG_SPLINE_ENABLED             = 0x08000000,       // used for flight paths
    MOVEMENTFLAG_WATERWALKING               = 0x10000000,       // prevent unit from falling through water
    MOVEMENTFLAG_FALLING_SLOW               = 0x20000000,       // active rogue safe fall spell (passive)
    MOVEMENTFLAG_HOVER                      = 0x40000000,       // hover, cannot jump

    /// @todo: Check if PITCH_UP and PITCH_DOWN really belong here..
    MOVEMENTFLAG_MASK_MOVING =
    MOVEMENTFLAG_FORWARD | MOVEMENTFLAG_BACKWARD | MOVEMENTFLAG_STRAFE_LEFT | MOVEMENTFLAG_STRAFE_RIGHT |
    MOVEMENTFLAG_PITCH_UP | MOVEMENTFLAG_PITCH_DOWN | MOVEMENTFLAG_FALLING | MOVEMENTFLAG_FALLING_FAR | MOVEMENTFLAG_ASCENDING | MOVEMENTFLAG_DESCENDING |
    MOVEMENTFLAG_SPLINE_ELEVATION,

    MOVEMENTFLAG_MASK_TURNING =
    MOVEMENTFLAG_LEFT | MOVEMENTFLAG_RIGHT,

    MOVEMENTFLAG_MASK_MOVING_FLY =
    MOVEMENTFLAG_FLYING | MOVEMENTFLAG_ASCENDING | MOVEMENTFLAG_DESCENDING,

    /// @todo if needed: add more flags to this masks that are exclusive to players
    MOVEMENTFLAG_MASK_PLAYER_ONLY =
    MOVEMENTFLAG_FLYING,

    MOVEMENTFLAG_MASK_MOVING_OR_TURN = MOVEMENTFLAG_MASK_MOVING | MOVEMENTFLAG_MASK_TURNING,

    /// Movement flags that have change status opcodes associated for players
    MOVEMENTFLAG_MASK_HAS_PLAYER_STATUS_OPCODE = MOVEMENTFLAG_DISABLE_GRAVITY | MOVEMENTFLAG_ROOT |
    MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_WATERWALKING | MOVEMENTFLAG_FALLING_SLOW | MOVEMENTFLAG_HOVER
};

enum MovementFlags2
{
    MOVEMENTFLAG2_NONE                      = 0x00000000,
    MOVEMENTFLAG2_NO_STRAFE                 = 0x00000001,
    MOVEMENTFLAG2_NO_JUMPING                = 0x00000002,
    MOVEMENTFLAG2_UNK3                      = 0x00000004,        // Overrides various clientside checks
    MOVEMENTFLAG2_FULL_SPEED_TURNING        = 0x00000008,
    MOVEMENTFLAG2_FULL_SPEED_PITCHING       = 0x00000010,
    MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING     = 0x00000020,
    MOVEMENTFLAG2_UNK7                      = 0x00000040,
    MOVEMENTFLAG2_UNK8                      = 0x00000080,
    MOVEMENTFLAG2_UNK9                      = 0x00000100,
    MOVEMENTFLAG2_UNK10                     = 0x00000200,
    MOVEMENTFLAG2_INTERPOLATED_MOVEMENT     = 0x00000400,
    MOVEMENTFLAG2_INTERPOLATED_TURNING      = 0x00000800,
    MOVEMENTFLAG2_INTERPOLATED_PITCHING     = 0x00001000,
    MOVEMENTFLAG2_UNK14                     = 0x00002000,
    MOVEMENTFLAG2_UNK15                     = 0x00004000,
    MOVEMENTFLAG2_UNK16                     = 0x00008000
};

enum SplineFlags
{
    SPLINEFLAG_NONE                         = 0x00000000,
    SPLINEFLAG_FORWARD                      = 0x00000001,
    SPLINEFLAG_BACKWARD                     = 0x00000002,
    SPLINEFLAG_STRAFE_LEFT                  = 0x00000004,
    SPLINEFLAG_STRAFE_RIGHT                 = 0x00000008,
    SPLINEFLAG_TURN_LEFT                    = 0x00000010,
    SPLINEFLAG_TURN_RIGHT                   = 0x00000020,
    SPLINEFLAG_PITCH_UP                     = 0x00000040,
    SPLINEFLAG_PITCH_DOWN                   = 0x00000080,
    SPLINEFLAG_DONE                         = 0x00000100,
    SPLINEFLAG_FALLING                      = 0x00000200,
    SPLINEFLAG_NO_SPLINE                    = 0x00000400,
    SPLINEFLAG_TRAJECTORY                   = 0x00000800,
    SPLINEFLAG_WALK_MODE                    = 0x00001000,
    SPLINEFLAG_FLYING                       = 0x00002000,
    SPLINEFLAG_KNOCKBACK                    = 0x00004000,
    SPLINEFLAG_FINAL_POINT                  = 0x00008000,
    SPLINEFLAG_FINAL_TARGET                 = 0x00010000,
    SPLINEFLAG_FINAL_FACING                 = 0x00020000,
    SPLINEFLAG_CATMULL_ROM                  = 0x00040000,
    SPLINEFLAG_CYCLIC                       = 0x00080000,
    SPLINEFLAG_ENTER_CYCLE                  = 0x00100000,
    SPLINEFLAG_ANIMATION_TIER               = 0x00200000,
    SPLINEFLAG_FROZEN                       = 0x00400000,
    SPLINEFLAG_TRANSPORT                    = 0x00800000,
    SPLINEFLAG_TRANSPORT_EXIT               = 0x01000000,
    SPLINEFLAG_UNKNOWN7                     = 0x02000000,
    SPLINEFLAG_UNKNOWN8                     = 0x04000000,
    SPLINEFLAG_ORIENTATION_INVERTED         = 0x08000000,
    SPLINEFLAG_USE_PATH_SMOOTHING           = 0x10000000,
    SPLINEFLAG_ANIMATION                    = 0x20000000,
    SPLINEFLAG_UNCOMPRESSED_PATH            = 0x40000000,
    SPLINEFLAG_UNKNOWN10                    = 0x80000000
};

enum SplineType
{
    SPLINETYPE_NORMAL           = 0,
    SPLINETYPE_STOP             = 1,
    SPLINETYPE_FACING_SPOT      = 2,
    SPLINETYPE_FACING_TARGET    = 3,
    SPLINETYPE_FACING_ANGLE     = 4
};
