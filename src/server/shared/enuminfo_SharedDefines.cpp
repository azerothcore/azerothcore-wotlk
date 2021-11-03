/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "SharedDefines.h"
#include "Define.h"
#include "SmartEnum.h"
#include <stdexcept>

namespace Acore::Impl::EnumUtilsImpl
{

/*************************************************************\
|* data for enum 'Races' in 'SharedDefines.h' auto-generated *|
\*************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<Races>::ToString(Races value)
{
    switch (value)
    {
        case RACE_HUMAN: return { "RACE_HUMAN", "Human", "" };
        case RACE_ORC: return { "RACE_ORC", "Orc", "" };
        case RACE_DWARF: return { "RACE_DWARF", "Dwarf", "" };
        case RACE_NIGHTELF: return { "RACE_NIGHTELF", "Night Elf", "" };
        case RACE_UNDEAD_PLAYER: return { "RACE_UNDEAD_PLAYER", "Undead", "" };
        case RACE_TAUREN: return { "RACE_TAUREN", "Tauren", "" };
        case RACE_GNOME: return { "RACE_GNOME", "Gnome", "" };
        case RACE_TROLL: return { "RACE_TROLL", "Troll", "" };
        case RACE_BLOODELF: return { "RACE_BLOODELF", "Blood Elf", "" };
        case RACE_DRAENEI: return { "RACE_DRAENEI", "Draenei", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Races>::Count() { return 10; }

template <>
AC_API_EXPORT Races EnumUtils<Races>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return RACE_HUMAN;
        case 1: return RACE_ORC;
        case 2: return RACE_DWARF;
        case 3: return RACE_NIGHTELF;
        case 4: return RACE_UNDEAD_PLAYER;
        case 5: return RACE_TAUREN;
        case 6: return RACE_GNOME;
        case 7: return RACE_TROLL;
        case 8: return RACE_BLOODELF;
        case 9: return RACE_DRAENEI;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Races>::ToIndex(Races value)
{
    switch (value)
    {
        case RACE_HUMAN: return 0;
        case RACE_ORC: return 1;
        case RACE_DWARF: return 2;
        case RACE_NIGHTELF: return 3;
        case RACE_UNDEAD_PLAYER: return 4;
        case RACE_TAUREN: return 5;
        case RACE_GNOME: return 6;
        case RACE_TROLL: return 7;
        case RACE_BLOODELF: return 8;
        case RACE_DRAENEI: return 9;
        default: throw std::out_of_range("value");
    }
}

/***************************************************************\
|* data for enum 'Classes' in 'SharedDefines.h' auto-generated *|
\***************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<Classes>::ToString(Classes value)
{
    switch (value)
    {
        case CLASS_WARRIOR: return { "CLASS_WARRIOR", "Warrior", "" };
        case CLASS_PALADIN: return { "CLASS_PALADIN", "Paladin", "" };
        case CLASS_HUNTER: return { "CLASS_HUNTER", "Hunter", "" };
        case CLASS_ROGUE: return { "CLASS_ROGUE", "Rogue", "" };
        case CLASS_PRIEST: return { "CLASS_PRIEST", "Priest", "" };
        case CLASS_DEATH_KNIGHT: return { "CLASS_DEATH_KNIGHT", "Death Knight", "" };
        case CLASS_SHAMAN: return { "CLASS_SHAMAN", "Shaman", "" };
        case CLASS_MAGE: return { "CLASS_MAGE", "Mage", "" };
        case CLASS_WARLOCK: return { "CLASS_WARLOCK", "Warlock", "" };
        case CLASS_DRUID: return { "CLASS_DRUID", "Druid", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Classes>::Count() { return 10; }

template <>
AC_API_EXPORT Classes EnumUtils<Classes>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return CLASS_WARRIOR;
        case 1: return CLASS_PALADIN;
        case 2: return CLASS_HUNTER;
        case 3: return CLASS_ROGUE;
        case 4: return CLASS_PRIEST;
        case 5: return CLASS_DEATH_KNIGHT;
        case 6: return CLASS_SHAMAN;
        case 7: return CLASS_MAGE;
        case 8: return CLASS_WARLOCK;
        case 9: return CLASS_DRUID;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Classes>::ToIndex(Classes value)
{
    switch (value)
    {
        case CLASS_WARRIOR: return 0;
        case CLASS_PALADIN: return 1;
        case CLASS_HUNTER: return 2;
        case CLASS_ROGUE: return 3;
        case CLASS_PRIEST: return 4;
        case CLASS_DEATH_KNIGHT: return 5;
        case CLASS_SHAMAN: return 6;
        case CLASS_MAGE: return 7;
        case CLASS_WARLOCK: return 8;
        case CLASS_DRUID: return 9;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr0' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr0>::ToString(SpellAttr0 value)
{
    switch (value)
    {
        case SPELL_ATTR0_PROC_FAILURE_BURNS_CHARGE: return { "SPELL_ATTR0_PROC_FAILURE_BURNS_CHARGE", "Unknown attribute 0@Attr0", "" };
        case SPELL_ATTR0_USES_RANGED_SLOT: return { "SPELL_ATTR0_USES_RANGED_SLOT", "Treat as ranged attack", "Use ammo, ranged attack range modifiers, ranged haste, etc." };
        case SPELL_ATTR0_ON_NEXT_SWING_NO_DAMAGE: return { "SPELL_ATTR0_ON_NEXT_SWING_NO_DAMAGE", "On next melee (type 1)", "Both \042on next swing\042 attributes have identical handling in server & client" };
        case SPELL_ATTR0_DO_NOT_LOG_IMMUNE_MISSES: return { "SPELL_ATTR0_DO_NOT_LOG_IMMUNE_MISSES", "Replenishment (client only)", "" };
        case SPELL_ATTR0_IS_ABILITY: return { "SPELL_ATTR0_IS_ABILITY", "Treat as ability", "Cannot be reflected, not affected by cast speed modifiers, etc." };
        case SPELL_ATTR0_IS_TRADESKILL: return { "SPELL_ATTR0_IS_TRADESKILL", "Trade skill recipe", "Displayed in recipe list, not affected by cast speed modifiers" };
        case SPELL_ATTR0_PASSIVE: return { "SPELL_ATTR0_PASSIVE", "Passive spell", "Spell is automatically cast on self by core" };
        case SPELL_ATTR0_DO_NOT_DISPLAY: return { "SPELL_ATTR0_DO_NOT_DISPLAY", "Hidden in UI (client only)", "Not visible in spellbook or aura bar (Spellbook, Aura Icon, Combat Log)" };
        case SPELL_ATTR0_DO_NOT_LOG: return { "SPELL_ATTR0_DO_NOT_LOG", "Hidden in combat log (client only)", "Spell will not appear in combat logs" };
        case SPELL_ATTR0_HELD_ITEM_ONLY: return { "SPELL_ATTR0_HELD_ITEM_ONLY", "Auto-target mainhand item (client only)", "Client will automatically select main-hand item as cast target" };
        case SPELL_ATTR0_ON_NEXT_SWING: return { "SPELL_ATTR0_ON_NEXT_SWING", "On next melee (type 2)", "Both \042on next swing\042 attributes have identical handling in server & client" };
        case SPELL_ATTR0_WEARER_CASTS_PROC_TRIGGER: return { "SPELL_ATTR0_WEARER_CASTS_PROC_TRIGGER", "Unknown attribute 11@Attr0", "" };
        case SPELL_ATTR0_SERVER_ONLY: return { "SPELL_ATTR0_SERVER_ONLY", "Only usable during daytime (unused)", "" };
        case SPELL_ATTR0_ALLOW_ITEM_SPELL_IN_PVP: return { "SPELL_ATTR0_ALLOW_ITEM_SPELL_IN_PVP", "Only usable during nighttime (unused)", "" };
        case SPELL_ATTR0_ONLY_INDOORS: return { "SPELL_ATTR0_ONLY_INDOORS", "Only usable indoors", "" };
        case SPELL_ATTR0_ONLY_OUTDOORS: return { "SPELL_ATTR0_ONLY_OUTDOORS", "Only usable outdoors", "" };
        case SPELL_ATTR0_NOT_SHAPESHIFTED: return { "SPELL_ATTR0_NOT_SHAPESHIFTED", "Not usable while shapeshifted", "" };
        case SPELL_ATTR0_ONLY_STEALTHED: return { "SPELL_ATTR0_ONLY_STEALTHED", "Only usable in stealth", "" };
        case SPELL_ATTR0_DO_NOT_SHEATH: return { "SPELL_ATTR0_DO_NOT_SHEATH", "Don't shealthe weapons (client only)", "" };
        case SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL: return { "SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL", "Scale with caster level", "For non-player casts, scale impact and power cost with caster's level" };
        case SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT: return { "SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT", "Stop attacking after cast", "After casting this, the current auto-attack will be interrupted" };
        case SPELL_ATTR0_NO_ACTIVE_DEFENSE: return { "SPELL_ATTR0_NO_ACTIVE_DEFENSE", "Prevent physical avoidance", "Spell cannot be dodged, parried or blocked" };
        case SPELL_ATTR0_TRACK_TARGET_IN_CAST_PLAYER_ONLY: return { "SPELL_ATTR0_TRACK_TARGET_IN_CAST_PLAYER_ONLY", "Automatically face target during cast (client only)", "" };
        case SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD: return { "SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD", "Can be cast while dead", "Spells without this flag cannot be cast by dead units in non-triggered contexts" };
        case SPELL_ATTR0_ALLOW_WHILE_MOUNTED: return { "SPELL_ATTR0_ALLOW_WHILE_MOUNTED", "Can be cast while mounted", "" };
        case SPELL_ATTR0_COOLDOWN_ON_EVENT: return { "SPELL_ATTR0_COOLDOWN_ON_EVENT", "Cooldown starts on expiry", "Spell is unusable while already active, and cooldown does not begin until the effects have worn off" };
        case SPELL_ATTR0_AURA_IS_DEBUFF: return { "SPELL_ATTR0_AURA_IS_DEBUFF", "Is negative spell", "Forces the spell to be treated as a negative spell" };
        case SPELL_ATTR0_ALLOW_WHILE_SITTING: return { "SPELL_ATTR0_ALLOW_WHILE_SITTING", "Can be cast while sitting", "" };
        case SPELL_ATTR0_NOT_IN_COMBAT_ONLY_PEACEFUL: return { "SPELL_ATTR0_NOT_IN_COMBAT_ONLY_PEACEFUL", "Cannot be used in combat", "" };
        case SPELL_ATTR0_NO_IMMUNITIES: return { "SPELL_ATTR0_NO_IMMUNITIES", "Pierce invulnerability", "Allows spell to pierce invulnerability, unless the invulnerability spell also has this attribute" };
        case SPELL_ATTR0_HEARTBEAT_RESIST: return { "SPELL_ATTR0_HEARTBEAT_RESIST", "Periodic resistance checks", "Periodically re-rolls against resistance to potentially expire aura early" };
        case SPELL_ATTR0_NO_AURA_CANCEL: return { "SPELL_ATTR0_NO_AURA_CANCEL", "Aura cannot be cancelled", "Prevents the player from voluntarily canceling a positive aura" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr0>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr0 EnumUtils<SpellAttr0>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR0_PROC_FAILURE_BURNS_CHARGE;
        case 1: return SPELL_ATTR0_USES_RANGED_SLOT;
        case 2: return SPELL_ATTR0_ON_NEXT_SWING_NO_DAMAGE;
        case 3: return SPELL_ATTR0_DO_NOT_LOG_IMMUNE_MISSES;
        case 4: return SPELL_ATTR0_IS_ABILITY;
        case 5: return SPELL_ATTR0_IS_TRADESKILL;
        case 6: return SPELL_ATTR0_PASSIVE;
        case 7: return SPELL_ATTR0_DO_NOT_DISPLAY;
        case 8: return SPELL_ATTR0_DO_NOT_LOG;
        case 9: return SPELL_ATTR0_HELD_ITEM_ONLY;
        case 10: return SPELL_ATTR0_ON_NEXT_SWING;
        case 11: return SPELL_ATTR0_WEARER_CASTS_PROC_TRIGGER;
        case 12: return SPELL_ATTR0_SERVER_ONLY;
        case 13: return SPELL_ATTR0_ALLOW_ITEM_SPELL_IN_PVP;
        case 14: return SPELL_ATTR0_ONLY_INDOORS;
        case 15: return SPELL_ATTR0_ONLY_OUTDOORS;
        case 16: return SPELL_ATTR0_NOT_SHAPESHIFTED;
        case 17: return SPELL_ATTR0_ONLY_STEALTHED;
        case 18: return SPELL_ATTR0_DO_NOT_SHEATH;
        case 19: return SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL;
        case 20: return SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        case 21: return SPELL_ATTR0_NO_ACTIVE_DEFENSE;
        case 22: return SPELL_ATTR0_TRACK_TARGET_IN_CAST_PLAYER_ONLY;
        case 23: return SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD;
        case 24: return SPELL_ATTR0_ALLOW_WHILE_MOUNTED;
        case 25: return SPELL_ATTR0_COOLDOWN_ON_EVENT;
        case 26: return SPELL_ATTR0_AURA_IS_DEBUFF;
        case 27: return SPELL_ATTR0_ALLOW_WHILE_SITTING;
        case 28: return SPELL_ATTR0_NOT_IN_COMBAT_ONLY_PEACEFUL;
        case 29: return SPELL_ATTR0_NO_IMMUNITIES;
        case 30: return SPELL_ATTR0_HEARTBEAT_RESIST;
        case 31: return SPELL_ATTR0_NO_AURA_CANCEL;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr0>::ToIndex(SpellAttr0 value)
{
    switch (value)
    {
        case SPELL_ATTR0_PROC_FAILURE_BURNS_CHARGE: return 0;
        case SPELL_ATTR0_USES_RANGED_SLOT: return 1;
        case SPELL_ATTR0_ON_NEXT_SWING_NO_DAMAGE: return 2;
        case SPELL_ATTR0_DO_NOT_LOG_IMMUNE_MISSES: return 3;
        case SPELL_ATTR0_IS_ABILITY: return 4;
        case SPELL_ATTR0_IS_TRADESKILL: return 5;
        case SPELL_ATTR0_PASSIVE: return 6;
        case SPELL_ATTR0_DO_NOT_DISPLAY: return 7;
        case SPELL_ATTR0_DO_NOT_LOG: return 8;
        case SPELL_ATTR0_HELD_ITEM_ONLY: return 9;
        case SPELL_ATTR0_ON_NEXT_SWING: return 10;
        case SPELL_ATTR0_WEARER_CASTS_PROC_TRIGGER: return 11;
        case SPELL_ATTR0_SERVER_ONLY: return 12;
        case SPELL_ATTR0_ALLOW_ITEM_SPELL_IN_PVP: return 13;
        case SPELL_ATTR0_ONLY_INDOORS: return 14;
        case SPELL_ATTR0_ONLY_OUTDOORS: return 15;
        case SPELL_ATTR0_NOT_SHAPESHIFTED: return 16;
        case SPELL_ATTR0_ONLY_STEALTHED: return 17;
        case SPELL_ATTR0_DO_NOT_SHEATH: return 18;
        case SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL: return 19;
        case SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT: return 20;
        case SPELL_ATTR0_NO_ACTIVE_DEFENSE: return 21;
        case SPELL_ATTR0_TRACK_TARGET_IN_CAST_PLAYER_ONLY: return 22;
        case SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD: return 23;
        case SPELL_ATTR0_ALLOW_WHILE_MOUNTED: return 24;
        case SPELL_ATTR0_COOLDOWN_ON_EVENT: return 25;
        case SPELL_ATTR0_AURA_IS_DEBUFF: return 26;
        case SPELL_ATTR0_ALLOW_WHILE_SITTING: return 27;
        case SPELL_ATTR0_NOT_IN_COMBAT_ONLY_PEACEFUL: return 28;
        case SPELL_ATTR0_NO_IMMUNITIES: return 29;
        case SPELL_ATTR0_HEARTBEAT_RESIST: return 30;
        case SPELL_ATTR0_NO_AURA_CANCEL: return 31;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr1' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr1>::ToString(SpellAttr1 value)
{
    switch (value)
    {
        case SPELL_ATTR1_DISMISS_PET_FIRST: return { "SPELL_ATTR1_DISMISS_PET_FIRST", "Dismiss Pet on cast", "Without this attribute, summoning spells will fail if caster already has a pet" };
        case SPELL_ATTR1_USE_ALL_MANA: return { "SPELL_ATTR1_USE_ALL_MANA", "Drain all power", "Ignores listed power cost and drains entire pool instead" };
        case SPELL_ATTR1_IS_CHANNELED: return { "SPELL_ATTR1_IS_CHANNELED", "Channeled (type 1)", "Both \042channeled\042 attributes have identical handling in server & client" };
        case SPELL_ATTR1_NO_REDIRECTION: return { "SPELL_ATTR1_NO_REDIRECTION", "Ignore redirection effects", "Spell will not be attracted by SPELL_MAGNET auras (Grounding Totem)" };
        case SPELL_ATTR1_NO_SKILL_INCREASE: return { "SPELL_ATTR1_NO_SKILL_INCREASE", "Unknown attribute 4@Attr1", "stealth and whirlwind" };
        case SPELL_ATTR1_ALLOW_WHILE_STEALTHED: return { "SPELL_ATTR1_ALLOW_WHILE_STEALTHED", "Does not break stealth", "" };
        case SPELL_ATTR1_IS_SELF_CHANNELED: return { "SPELL_ATTR1_IS_SELF_CHANNELED", "Channeled (type 2)", "Both \042channeled\042 attributes have identical handling in server & client" };
        case SPELL_ATTR1_NO_REFLECTION: return { "SPELL_ATTR1_NO_REFLECTION", "Ignore reflection effects", "Spell will pierce through Spell Reflection and similar" };
        case SPELL_ATTR1_ONLY_PEACEFUL_TARGETS: return { "SPELL_ATTR1_ONLY_PEACEFUL_TARGETS", "Target cannot be in combat", "" };
        case SPELL_ATTR1_INITIATE_COMBAT: return { "SPELL_ATTR1_INITIATE_COMBAT", "Enables Auto-Attack (client only)", "Caster will begin auto-attacking the target on cast" };
        case SPELL_ATTR1_NO_THREAT: return { "SPELL_ATTR1_NO_THREAT", "Does not generate threat", "Also does not cause target to engage" };
        case SPELL_ATTR1_AURA_UNIQUE: return { "SPELL_ATTR1_AURA_UNIQUE", "Aura will not refresh its duration when recast", "" };
        case SPELL_ATTR1_FAILURE_BREAKS_STEALTH: return { "SPELL_ATTR1_FAILURE_BREAKS_STEALTH", "Pickpocket (client only)", "" };
        case SPELL_ATTR1_TOGGLE_FAR_SIGHT: return { "SPELL_ATTR1_TOGGLE_FAR_SIGHT", "Farsight aura (client only)", "" };
        case SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL: return { "SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL", "Track target while channeling", "While channeling, adjust facing to face target" };
        case SPELL_ATTR1_IMMUNITY_PURGES_EFFECT: return { "SPELL_ATTR1_IMMUNITY_PURGES_EFFECT", "Immunity cancels preapplied auras", "For immunity spells, cancel all auras that this spell would make you immune to when the spell is applied" };
        case SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS: return { "SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS", "Unaffected by school immunities", "Will not pierce Divine Shield, Ice Block and other full invulnerabilities" };
        case SPELL_ATTR1_NO_AUTOCAST_AI: return { "SPELL_ATTR1_NO_AUTOCAST_AI", "Cannot be autocast by pet", "(AI)" };
        case SPELL_ATTR1_PREVENTS_ANIM: return { "SPELL_ATTR1_PREVENTS_ANIM", "NYI, auras apply UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT", "" };
        case SPELL_ATTR1_EXCLUDE_CASTER: return { "SPELL_ATTR1_EXCLUDE_CASTER", "Cannot be self-cast", "" };
        case SPELL_ATTR1_FINISHING_MOVE_DAMAGE: return { "SPELL_ATTR1_FINISHING_MOVE_DAMAGE", "Requires combo points (type 1)", "" };
        case SPELL_ATTR1_THREAT_ONLY_ON_MISS: return { "SPELL_ATTR1_THREAT_ONLY_ON_MISS", "Unknown attribute 21@Attr1", "" };
        case SPELL_ATTR1_FINISHING_MOVE_DURATION: return { "SPELL_ATTR1_FINISHING_MOVE_DURATION", "Requires combo points (type 2)", "" };
        case SPELL_ATTR1_IGNORE_OWNERS_DEATH: return { "SPELL_ATTR1_IGNORE_OWNERS_DEATH", "Unknwon attribute 23@Attr1", "" };
        case SPELL_ATTR1_SPECIAL_SKILLUP: return { "SPELL_ATTR1_SPECIAL_SKILLUP", "Fishing (client only)", "" };
        case SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT: return { "SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT", "Unknown attribute 25@Attr1", "" };
        case SPELL_ATTR1_REQUIRE_ALL_TARGETS: return { "SPELL_ATTR1_REQUIRE_ALL_TARGETS", "Unknown attribute 26@Attr1", "Related to [target=focus] and [target=mouseover] macros?" };
        case SPELL_ATTR1_DISCOUNT_POWER_ON_MISS: return { "SPELL_ATTR1_DISCOUNT_POWER_ON_MISS", "Unknown attribute 27@Attr1", "Melee spell?" };
        case SPELL_ATTR1_NO_AURA_ICON: return { "SPELL_ATTR1_NO_AURA_ICON", "Hide in aura bar (client only)", "" };
        case SPELL_ATTR1_NAME_IN_CHANNEL_BAR: return { "SPELL_ATTR1_NAME_IN_CHANNEL_BAR", "Show spell name during channel (client only)", "" };
        case SPELL_ATTR1_COMBO_ON_BLOCK: return { "SPELL_ATTR1_COMBO_ON_BLOCK", "Enable at dodge", "(Mainline: Dispel All Stacks)" };
        case SPELL_ATTR1_CAST_WHEN_LEARNED: return { "SPELL_ATTR1_CAST_WHEN_LEARNED", "Unknown attribute 31@Attr1", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr1>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr1 EnumUtils<SpellAttr1>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR1_DISMISS_PET_FIRST;
        case 1: return SPELL_ATTR1_USE_ALL_MANA;
        case 2: return SPELL_ATTR1_IS_CHANNELED;
        case 3: return SPELL_ATTR1_NO_REDIRECTION;
        case 4: return SPELL_ATTR1_NO_SKILL_INCREASE;
        case 5: return SPELL_ATTR1_ALLOW_WHILE_STEALTHED;
        case 6: return SPELL_ATTR1_IS_SELF_CHANNELED;
        case 7: return SPELL_ATTR1_NO_REFLECTION;
        case 8: return SPELL_ATTR1_ONLY_PEACEFUL_TARGETS;
        case 9: return SPELL_ATTR1_INITIATE_COMBAT;
        case 10: return SPELL_ATTR1_NO_THREAT;
        case 11: return SPELL_ATTR1_AURA_UNIQUE;
        case 12: return SPELL_ATTR1_FAILURE_BREAKS_STEALTH;
        case 13: return SPELL_ATTR1_TOGGLE_FAR_SIGHT;
        case 14: return SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL;
        case 15: return SPELL_ATTR1_IMMUNITY_PURGES_EFFECT;
        case 16: return SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS;
        case 17: return SPELL_ATTR1_NO_AUTOCAST_AI;
        case 18: return SPELL_ATTR1_PREVENTS_ANIM;
        case 19: return SPELL_ATTR1_EXCLUDE_CASTER;
        case 20: return SPELL_ATTR1_FINISHING_MOVE_DAMAGE;
        case 21: return SPELL_ATTR1_THREAT_ONLY_ON_MISS;
        case 22: return SPELL_ATTR1_FINISHING_MOVE_DURATION;
        case 23: return SPELL_ATTR1_IGNORE_OWNERS_DEATH;
        case 24: return SPELL_ATTR1_SPECIAL_SKILLUP;
        case 25: return SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT;
        case 26: return SPELL_ATTR1_REQUIRE_ALL_TARGETS;
        case 27: return SPELL_ATTR1_DISCOUNT_POWER_ON_MISS;
        case 28: return SPELL_ATTR1_NO_AURA_ICON;
        case 29: return SPELL_ATTR1_NAME_IN_CHANNEL_BAR;
        case 30: return SPELL_ATTR1_COMBO_ON_BLOCK;
        case 31: return SPELL_ATTR1_CAST_WHEN_LEARNED;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr1>::ToIndex(SpellAttr1 value)
{
    switch (value)
    {
        case SPELL_ATTR1_DISMISS_PET_FIRST: return 0;
        case SPELL_ATTR1_USE_ALL_MANA: return 1;
        case SPELL_ATTR1_IS_CHANNELED: return 2;
        case SPELL_ATTR1_NO_REDIRECTION: return 3;
        case SPELL_ATTR1_NO_SKILL_INCREASE: return 4;
        case SPELL_ATTR1_ALLOW_WHILE_STEALTHED: return 5;
        case SPELL_ATTR1_IS_SELF_CHANNELED: return 6;
        case SPELL_ATTR1_NO_REFLECTION: return 7;
        case SPELL_ATTR1_ONLY_PEACEFUL_TARGETS: return 8;
        case SPELL_ATTR1_INITIATE_COMBAT: return 9;
        case SPELL_ATTR1_NO_THREAT: return 10;
        case SPELL_ATTR1_AURA_UNIQUE: return 11;
        case SPELL_ATTR1_FAILURE_BREAKS_STEALTH: return 12;
        case SPELL_ATTR1_TOGGLE_FAR_SIGHT: return 13;
        case SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL: return 14;
        case SPELL_ATTR1_IMMUNITY_PURGES_EFFECT: return 15;
        case SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS: return 16;
        case SPELL_ATTR1_NO_AUTOCAST_AI: return 17;
        case SPELL_ATTR1_PREVENTS_ANIM: return 18;
        case SPELL_ATTR1_EXCLUDE_CASTER: return 19;
        case SPELL_ATTR1_FINISHING_MOVE_DAMAGE: return 20;
        case SPELL_ATTR1_THREAT_ONLY_ON_MISS: return 21;
        case SPELL_ATTR1_FINISHING_MOVE_DURATION: return 22;
        case SPELL_ATTR1_IGNORE_OWNERS_DEATH: return 23;
        case SPELL_ATTR1_SPECIAL_SKILLUP: return 24;
        case SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT: return 25;
        case SPELL_ATTR1_REQUIRE_ALL_TARGETS: return 26;
        case SPELL_ATTR1_DISCOUNT_POWER_ON_MISS: return 27;
        case SPELL_ATTR1_NO_AURA_ICON: return 28;
        case SPELL_ATTR1_NAME_IN_CHANNEL_BAR: return 29;
        case SPELL_ATTR1_COMBO_ON_BLOCK: return 30;
        case SPELL_ATTR1_CAST_WHEN_LEARNED: return 31;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr2' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr2>::ToString(SpellAttr2 value)
{
    switch (value)
    {
        case SPELL_ATTR2_ALLOW_DEAD_TARGET: return { "SPELL_ATTR2_ALLOW_DEAD_TARGET", "Can target dead players or corpses", "" };
        case SPELL_ATTR2_NO_SHAPESHIFT_UI: return { "SPELL_ATTR2_NO_SHAPESHIFT_UI", "Unknown attribute 1@Attr2", "vanish, shadowform, Ghost Wolf and other" };
        case SPELL_ATTR2_IGNORE_LINE_OF_SIGHT: return { "SPELL_ATTR2_IGNORE_LINE_OF_SIGHT", "Ignore Line of Sight", "" };
        case SPELL_ATTR2_ALLOW_LOW_LEVEL_BUFF: return { "SPELL_ATTR2_ALLOW_LOW_LEVEL_BUFF", "Ignore aura scaling", "" };
        case SPELL_ATTR2_USE_SHAPESHIFT_BAR: return { "SPELL_ATTR2_USE_SHAPESHIFT_BAR", "Show in stance bar (client only)", "" };
        case SPELL_ATTR2_AUTO_REPEAT: return { "SPELL_ATTR2_AUTO_REPEAT", "Ranged auto-attack spell", "" };
        case SPELL_ATTR2_CANNOT_CAST_ON_TAPPED: return { "SPELL_ATTR2_CANNOT_CAST_ON_TAPPED", "Cannot target others' tapped units", "Can only target untapped units, or those tapped by caster" };
        case SPELL_ATTR2_DO_NOT_REPORT_SPELL_FAILURE: return { "SPELL_ATTR2_DO_NOT_REPORT_SPELL_FAILURE", "Unknown attribute 7@Attr2", "" };
        case SPELL_ATTR2_INCLUDE_IN_ADVANCED_COMBAT_LOG: return { "SPELL_ATTR2_INCLUDE_IN_ADVANCED_COMBAT_LOG", "Unknown attribute 8@Attr2", "not set in 3.0.3" };
        case SPELL_ATTR2_ALWAYS_CAST_AS_UNIT: return { "SPELL_ATTR2_ALWAYS_CAST_AS_UNIT", "Unknown attribute 9@Attr2", "" };
        case SPELL_ATTR2_SPECIAL_TAMING_FLAG: return { "SPELL_ATTR2_SPECIAL_TAMING_FLAG", "Unknown attribute 10@Attr2", "Related to taming?" };
        case SPELL_ATTR2_NO_TARGET_PER_SECOND_COST: return { "SPELL_ATTR2_NO_TARGET_PER_SECOND_COST", "Health Funnel", "" };
        case SPELL_ATTR2_CHAIN_FROM_CASTER: return { "SPELL_ATTR2_CHAIN_FROM_CASTER", "Unknown attribute 12@Attr2", "Cleave, Heart Strike, Maul, Sunder Armor, Swipe" };
        case SPELL_ATTR2_ENCHANT_OWN_ITEM_ONLY: return { "SPELL_ATTR2_ENCHANT_OWN_ITEM_ONLY", "Enchant persists when entering arena", "" };
        case SPELL_ATTR2_ALLOW_WHILE_INVISIBLE: return { "SPELL_ATTR2_ALLOW_WHILE_INVISIBLE", "Unknown attribute 14@Attr2", "" };
        case SPELL_ATTR2_DO_NOT_CONSUME_IF_GAINED_DURING_CAST: return { "SPELL_ATTR2_DO_NOT_CONSUME_IF_GAINED_DURING_CAST", "Unknown attribute 15@Attr2", "not set in 3.0.3" };
        case SPELL_ATTR2_NO_ACTIVE_PETS: return { "SPELL_ATTR2_NO_ACTIVE_PETS", "Tame Beast", "" };
        case SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS: return { "SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS", "Don't reset swing timer", "Does not reset melee/ranged autoattack timer on cast" };
        case SPELL_ATTR2_NO_JUMP_WHILE_CAST_PENDING: return { "SPELL_ATTR2_NO_JUMP_WHILE_CAST_PENDING", "Requires dead pet", "" };
        case SPELL_ATTR2_ALLOW_WHILE_NOT_SHAPESHIFTED: return { "SPELL_ATTR2_ALLOW_WHILE_NOT_SHAPESHIFTED", "Also allow outside shapeshift (caster form)", "Even if Stances are nonzero, allow spell to be cast outside of shapeshift (though not in a different shapeshift)" };
        case SPELL_ATTR2_INITIATE_COMBAT_POST_CAST: return { "SPELL_ATTR2_INITIATE_COMBAT_POST_CAST", "(Enables Auto-Attack)", "" };
        case SPELL_ATTR2_FAIL_ON_ALL_TARGETS_IMMUNE: return { "SPELL_ATTR2_FAIL_ON_ALL_TARGETS_IMMUNE", "Damage reduction ability", "Causes BG flags to be dropped if combined with ATTR1_DISPEL_AURAS_ON_IMMUNITY" };
        case SPELL_ATTR2_NO_INITIAL_THREAD: return { "SPELL_ATTR2_NO_INITIAL_THREAD", "Unknown attribute 22@Attr2", "Ambush, Backstab, Cheap Shot, Death Grip, Garrote, Judgements, Mutilate, Pounce, Ravage, Shiv, Shred" };
        case SPELL_ATTR2_PROC_COOLDOWN_ON_FAILURE: return { "SPELL_ATTR2_PROC_COOLDOWN_ON_FAILURE", "Arcane Concentration", "" };
        case SPELL_ATTR2_ITEM_CAST_WITH_OWNER_SKILL: return { "SPELL_ATTR2_ITEM_CAST_WITH_OWNER_SKILL", "Unknown attribute 24@Attr2", "" };
        case SPELL_ATTR2_DONT_BLOCK_MANA_REGEN: return { "SPELL_ATTR2_DONT_BLOCK_MANA_REGEN", "Unknown attribute 25@Attr2", "" };
        case SPELL_ATTR2_NO_SCHOOL_IMMUNITIES: return { "SPELL_ATTR2_NO_SCHOOL_IMMUNITIES", "Pierce aura application immunities", "Allow aura to be applied despite target being immune to new aura applications" };
        case SPELL_ATTR2_IGNORE_WEAPONSKILL: return { "SPELL_ATTR2_IGNORE_WEAPONSKILL", "Unknown attribute 27@Attr2", "" };
        case SPELL_ATTR2_NOT_AN_ACTION: return { "SPELL_ATTR2_NOT_AN_ACTION", "Unknown attribute 28@Attr2", "" };
        case SPELL_ATTR2_CANT_CRIT: return { "SPELL_ATTR2_CANT_CRIT", "Cannot critically strike", "" };
        case SPELL_ATTR2_ACTIVE_THREAT: return { "SPELL_ATTR2_ACTIVE_THREAT", "Allow triggered spell to trigger (type 1)", "Without this attribute, any triggered spell will be unable to trigger other auras' procs" };
        case SPELL_ATTR2_RETAIN_ITEM_CAST: return { "SPELL_ATTR2_RETAIN_ITEM_CAST", "Food buff (client only)", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr2>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr2 EnumUtils<SpellAttr2>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR2_ALLOW_DEAD_TARGET;
        case 1: return SPELL_ATTR2_NO_SHAPESHIFT_UI;
        case 2: return SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        case 3: return SPELL_ATTR2_ALLOW_LOW_LEVEL_BUFF;
        case 4: return SPELL_ATTR2_USE_SHAPESHIFT_BAR;
        case 5: return SPELL_ATTR2_AUTO_REPEAT;
        case 6: return SPELL_ATTR2_CANNOT_CAST_ON_TAPPED;
        case 7: return SPELL_ATTR2_DO_NOT_REPORT_SPELL_FAILURE;
        case 8: return SPELL_ATTR2_INCLUDE_IN_ADVANCED_COMBAT_LOG;
        case 9: return SPELL_ATTR2_ALWAYS_CAST_AS_UNIT;
        case 10: return SPELL_ATTR2_SPECIAL_TAMING_FLAG;
        case 11: return SPELL_ATTR2_NO_TARGET_PER_SECOND_COST;
        case 12: return SPELL_ATTR2_CHAIN_FROM_CASTER;
        case 13: return SPELL_ATTR2_ENCHANT_OWN_ITEM_ONLY;
        case 14: return SPELL_ATTR2_ALLOW_WHILE_INVISIBLE;
        case 15: return SPELL_ATTR2_DO_NOT_CONSUME_IF_GAINED_DURING_CAST;
        case 16: return SPELL_ATTR2_NO_ACTIVE_PETS;
        case 17: return SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS;
        case 18: return SPELL_ATTR2_NO_JUMP_WHILE_CAST_PENDING;
        case 19: return SPELL_ATTR2_ALLOW_WHILE_NOT_SHAPESHIFTED;
        case 20: return SPELL_ATTR2_INITIATE_COMBAT_POST_CAST;
        case 21: return SPELL_ATTR2_FAIL_ON_ALL_TARGETS_IMMUNE;
        case 22: return SPELL_ATTR2_NO_INITIAL_THREAD;
        case 23: return SPELL_ATTR2_PROC_COOLDOWN_ON_FAILURE;
        case 24: return SPELL_ATTR2_ITEM_CAST_WITH_OWNER_SKILL;
        case 25: return SPELL_ATTR2_DONT_BLOCK_MANA_REGEN;
        case 26: return SPELL_ATTR2_NO_SCHOOL_IMMUNITIES;
        case 27: return SPELL_ATTR2_IGNORE_WEAPONSKILL;
        case 28: return SPELL_ATTR2_NOT_AN_ACTION;
        case 29: return SPELL_ATTR2_CANT_CRIT;
        case 30: return SPELL_ATTR2_ACTIVE_THREAT;
        case 31: return SPELL_ATTR2_RETAIN_ITEM_CAST;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr2>::ToIndex(SpellAttr2 value)
{
    switch (value)
    {
        case SPELL_ATTR2_ALLOW_DEAD_TARGET: return 0;
        case SPELL_ATTR2_NO_SHAPESHIFT_UI: return 1;
        case SPELL_ATTR2_IGNORE_LINE_OF_SIGHT: return 2;
        case SPELL_ATTR2_ALLOW_LOW_LEVEL_BUFF: return 3;
        case SPELL_ATTR2_USE_SHAPESHIFT_BAR: return 4;
        case SPELL_ATTR2_AUTO_REPEAT: return 5;
        case SPELL_ATTR2_CANNOT_CAST_ON_TAPPED: return 6;
        case SPELL_ATTR2_DO_NOT_REPORT_SPELL_FAILURE: return 7;
        case SPELL_ATTR2_INCLUDE_IN_ADVANCED_COMBAT_LOG: return 8;
        case SPELL_ATTR2_ALWAYS_CAST_AS_UNIT: return 9;
        case SPELL_ATTR2_SPECIAL_TAMING_FLAG: return 10;
        case SPELL_ATTR2_NO_TARGET_PER_SECOND_COST: return 11;
        case SPELL_ATTR2_CHAIN_FROM_CASTER: return 12;
        case SPELL_ATTR2_ENCHANT_OWN_ITEM_ONLY: return 13;
        case SPELL_ATTR2_ALLOW_WHILE_INVISIBLE: return 14;
        case SPELL_ATTR2_DO_NOT_CONSUME_IF_GAINED_DURING_CAST: return 15;
        case SPELL_ATTR2_NO_ACTIVE_PETS: return 16;
        case SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS: return 17;
        case SPELL_ATTR2_NO_JUMP_WHILE_CAST_PENDING: return 18;
        case SPELL_ATTR2_ALLOW_WHILE_NOT_SHAPESHIFTED: return 19;
        case SPELL_ATTR2_INITIATE_COMBAT_POST_CAST: return 20;
        case SPELL_ATTR2_FAIL_ON_ALL_TARGETS_IMMUNE: return 21;
        case SPELL_ATTR2_NO_INITIAL_THREAD: return 22;
        case SPELL_ATTR2_PROC_COOLDOWN_ON_FAILURE: return 23;
        case SPELL_ATTR2_ITEM_CAST_WITH_OWNER_SKILL: return 24;
        case SPELL_ATTR2_DONT_BLOCK_MANA_REGEN: return 25;
        case SPELL_ATTR2_NO_SCHOOL_IMMUNITIES: return 26;
        case SPELL_ATTR2_IGNORE_WEAPONSKILL: return 27;
        case SPELL_ATTR2_NOT_AN_ACTION: return 28;
        case SPELL_ATTR2_CANT_CRIT: return 29;
        case SPELL_ATTR2_ACTIVE_THREAT: return 30;
        case SPELL_ATTR2_RETAIN_ITEM_CAST: return 31;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr3' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr3>::ToString(SpellAttr3 value)
{
    switch (value)
    {
        case SPELL_ATTR3_PVP_ENABLING: return { "SPELL_ATTR3_PVP_ENABLING", "Unknown attribute 0@Attr3", "" };
        case SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT: return { "SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT", "1 Ignores subclass mask check when checking proc", "" };
        case SPELL_ATTR3_NO_CASTING_BAR_TEXT: return { "SPELL_ATTR3_NO_CASTING_BAR_TEXT", "Unknown attribute 2@Attr3", "" };
        case SPELL_ATTR3_COMPLETELY_BLOCKED: return { "SPELL_ATTR3_COMPLETELY_BLOCKED", "Blockable spell", "" };
        case SPELL_ATTR3_NO_RES_TIMER: return { "SPELL_ATTR3_NO_RES_TIMER", "Ignore resurrection timer", "" };
        case SPELL_ATTR3_NO_DURABILITY_LOSS: return { "SPELL_ATTR3_NO_DURABILITY_LOSS", "Unknown attribute 5@Attr3", "" };
        case SPELL_ATTR3_NO_AVOIDANCE: return { "SPELL_ATTR3_NO_AVOIDANCE", "Unknown attribute 6@Attr3", "" };
        case SPELL_ATTR3_DOT_STACKING_RULE: return { "SPELL_ATTR3_DOT_STACKING_RULE", "Stack separately for each caster", "" };
        case SPELL_ATTR3_ONLY_ON_PLAYER: return { "SPELL_ATTR3_ONLY_ON_PLAYER", "Can only target players", "" };
        case SPELL_ATTR3_NOT_A_PROC: return { "SPELL_ATTR3_NOT_A_PROC", "Allow triggered spell to trigger (type 2)", "Without this attribute, any triggered spell will be unable to trigger other auras' procs" };
        case SPELL_ATTR3_REQUIRES_MAIN_HAND_WEAPON: return { "SPELL_ATTR3_REQUIRES_MAIN_HAND_WEAPON", "Require main hand weapon", "" };
        case SPELL_ATTR3_ONLY_BATTLEGROUNDS: return { "SPELL_ATTR3_ONLY_BATTLEGROUNDS", "Can only be cast in battleground", "" };
        case SPELL_ATTR3_ONLY_ON_GHOSTS: return { "SPELL_ATTR3_ONLY_ON_GHOSTS", "Can only target ghost players", "" };
        case SPELL_ATTR3_HIDE_CHANNEL_BAR: return { "SPELL_ATTR3_HIDE_CHANNEL_BAR", "Do not display channel bar (client only)", "" };
        case SPELL_ATTR3_HIDE_IN_RAID_FILTER: return { "SPELL_ATTR3_HIDE_IN_RAID_FILTER", "Honorless Target", "" };
        case SPELL_ATTR3_NORMAL_RANGED_ATTACK: return { "SPELL_ATTR3_NORMAL_RANGED_ATTACK", "Unknown attribute 15@Attr3", "Auto Shoot, Shoot, Throw - ranged normal attack attribute?" };
        case SPELL_ATTR3_SUPRESS_CASTER_PROCS: return { "SPELL_ATTR3_SUPRESS_CASTER_PROCS", "Cannot trigger procs", "" };
        case SPELL_ATTR3_SUPRESS_TARGET_PROCS: return { "SPELL_ATTR3_SUPRESS_TARGET_PROCS", "No initial aggro", "" };
        case SPELL_ATTR3_ALWAYS_HIT: return { "SPELL_ATTR3_ALWAYS_HIT", "Ignore hit result", "Spell cannot miss, or be dodged/parried/blocked" };
        case SPELL_ATTR3_INSTANT_TARGET_PROCS: return { "SPELL_ATTR3_INSTANT_TARGET_PROCS", "Cannot trigger spells during aura proc", "" };
        case SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD: return { "SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD", "Persists through death", "" };
        case SPELL_ATTR3_ONLY_PROC_OUTDOORS: return { "SPELL_ATTR3_ONLY_PROC_OUTDOORS", "Unknown attribute 21@Attr3", "" };
        case SPELL_ATTR3_CASTING_CANCELS_AUTOREPEAT: return { "SPELL_ATTR3_CASTING_CANCELS_AUTOREPEAT", "Requires equipped Wand (Mainline: Do Not Trigger Target Stand)", "" };
        case SPELL_ATTR3_NO_DAMAGE_HISTORY: return { "SPELL_ATTR3_NO_DAMAGE_HISTORY", "Unknown attribute 23@Attr3", "" };
        case SPELL_ATTR3_REQUIRES_OFF_HAND_WEAPON: return { "SPELL_ATTR3_REQUIRES_OFF_HAND_WEAPON", "Requires offhand weapon", "" };
        case SPELL_ATTR3_TREAT_AS_PERIODIC: return { "SPELL_ATTR3_TREAT_AS_PERIODIC", "Treat as periodic effect", "" };
        case SPELL_ATTR3_CAN_PROC_FROM_PROCS: return { "SPELL_ATTR3_CAN_PROC_FROM_PROCS", "Can trigger from triggered spells", "" };
        case SPELL_ATTR3_ONLY_PROC_ON_CASTER: return { "SPELL_ATTR3_ONLY_PROC_ON_CASTER", "Drain Soul", "" };
        case SPELL_ATTR3_IGNORE_CASTER_AND_TARGET_RESTRICTIONS: return { "SPELL_ATTR3_IGNORE_CASTER_AND_TARGET_RESTRICTIONS", "Unknown attribute 28@Attr3", "" };
        case SPELL_ATTR3_IGNORE_CASTER_MODIFIERS: return { "SPELL_ATTR3_IGNORE_CASTER_MODIFIERS", "Damage dealt is unaffected by modifiers", "" };
        case SPELL_ATTR3_DO_NOT_DISPLAY_RANGE: return { "SPELL_ATTR3_DO_NOT_DISPLAY_RANGE", "Do not show range in tooltip (client only)", "" };
        case SPELL_ATTR3_NOT_ON_AOE_IMMUNE: return { "SPELL_ATTR3_NOT_ON_AOE_IMMUNE", "Unknown attribute 31@Attr3", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr3>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr3 EnumUtils<SpellAttr3>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR3_PVP_ENABLING;
        case 1: return SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT;
        case 2: return SPELL_ATTR3_NO_CASTING_BAR_TEXT;
        case 3: return SPELL_ATTR3_COMPLETELY_BLOCKED;
        case 4: return SPELL_ATTR3_NO_RES_TIMER;
        case 5: return SPELL_ATTR3_NO_DURABILITY_LOSS;
        case 6: return SPELL_ATTR3_NO_AVOIDANCE;
        case 7: return SPELL_ATTR3_DOT_STACKING_RULE;
        case 8: return SPELL_ATTR3_ONLY_ON_PLAYER;
        case 9: return SPELL_ATTR3_NOT_A_PROC;
        case 10: return SPELL_ATTR3_REQUIRES_MAIN_HAND_WEAPON;
        case 11: return SPELL_ATTR3_ONLY_BATTLEGROUNDS;
        case 12: return SPELL_ATTR3_ONLY_ON_GHOSTS;
        case 13: return SPELL_ATTR3_HIDE_CHANNEL_BAR;
        case 14: return SPELL_ATTR3_HIDE_IN_RAID_FILTER;
        case 15: return SPELL_ATTR3_NORMAL_RANGED_ATTACK;
        case 16: return SPELL_ATTR3_SUPRESS_CASTER_PROCS;
        case 17: return SPELL_ATTR3_SUPRESS_TARGET_PROCS;
        case 18: return SPELL_ATTR3_ALWAYS_HIT;
        case 19: return SPELL_ATTR3_INSTANT_TARGET_PROCS;
        case 20: return SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
        case 21: return SPELL_ATTR3_ONLY_PROC_OUTDOORS;
        case 22: return SPELL_ATTR3_CASTING_CANCELS_AUTOREPEAT;
        case 23: return SPELL_ATTR3_NO_DAMAGE_HISTORY;
        case 24: return SPELL_ATTR3_REQUIRES_OFF_HAND_WEAPON;
        case 25: return SPELL_ATTR3_TREAT_AS_PERIODIC;
        case 26: return SPELL_ATTR3_CAN_PROC_FROM_PROCS;
        case 27: return SPELL_ATTR3_ONLY_PROC_ON_CASTER;
        case 28: return SPELL_ATTR3_IGNORE_CASTER_AND_TARGET_RESTRICTIONS;
        case 29: return SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
        case 30: return SPELL_ATTR3_DO_NOT_DISPLAY_RANGE;
        case 31: return SPELL_ATTR3_NOT_ON_AOE_IMMUNE;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr3>::ToIndex(SpellAttr3 value)
{
    switch (value)
    {
        case SPELL_ATTR3_PVP_ENABLING: return 0;
        case SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT: return 1;
        case SPELL_ATTR3_NO_CASTING_BAR_TEXT: return 2;
        case SPELL_ATTR3_COMPLETELY_BLOCKED: return 3;
        case SPELL_ATTR3_NO_RES_TIMER: return 4;
        case SPELL_ATTR3_NO_DURABILITY_LOSS: return 5;
        case SPELL_ATTR3_NO_AVOIDANCE: return 6;
        case SPELL_ATTR3_DOT_STACKING_RULE: return 7;
        case SPELL_ATTR3_ONLY_ON_PLAYER: return 8;
        case SPELL_ATTR3_NOT_A_PROC: return 9;
        case SPELL_ATTR3_REQUIRES_MAIN_HAND_WEAPON: return 10;
        case SPELL_ATTR3_ONLY_BATTLEGROUNDS: return 11;
        case SPELL_ATTR3_ONLY_ON_GHOSTS: return 12;
        case SPELL_ATTR3_HIDE_CHANNEL_BAR: return 13;
        case SPELL_ATTR3_HIDE_IN_RAID_FILTER: return 14;
        case SPELL_ATTR3_NORMAL_RANGED_ATTACK: return 15;
        case SPELL_ATTR3_SUPRESS_CASTER_PROCS: return 16;
        case SPELL_ATTR3_SUPRESS_TARGET_PROCS: return 17;
        case SPELL_ATTR3_ALWAYS_HIT: return 18;
        case SPELL_ATTR3_INSTANT_TARGET_PROCS: return 19;
        case SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD: return 20;
        case SPELL_ATTR3_ONLY_PROC_OUTDOORS: return 21;
        case SPELL_ATTR3_CASTING_CANCELS_AUTOREPEAT: return 22;
        case SPELL_ATTR3_NO_DAMAGE_HISTORY: return 23;
        case SPELL_ATTR3_REQUIRES_OFF_HAND_WEAPON: return 24;
        case SPELL_ATTR3_TREAT_AS_PERIODIC: return 25;
        case SPELL_ATTR3_CAN_PROC_FROM_PROCS: return 26;
        case SPELL_ATTR3_ONLY_PROC_ON_CASTER: return 27;
        case SPELL_ATTR3_IGNORE_CASTER_AND_TARGET_RESTRICTIONS: return 28;
        case SPELL_ATTR3_IGNORE_CASTER_MODIFIERS: return 29;
        case SPELL_ATTR3_DO_NOT_DISPLAY_RANGE: return 30;
        case SPELL_ATTR3_NOT_ON_AOE_IMMUNE: return 31;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr4' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr4>::ToString(SpellAttr4 value)
{
    switch (value)
    {
        case SPELL_ATTR4_NO_CAST_LOG: return { "SPELL_ATTR4_NO_CAST_LOG", "Cannot be resisted", "" };
        case SPELL_ATTR4_CLASS_TRIGGER_ONLY_ON_TARGET: return { "SPELL_ATTR4_CLASS_TRIGGER_ONLY_ON_TARGET", "Only proc on self-cast", "" };
        case SPELL_ATTR4_AURA_EXPIRES_OFFLINE: return { "SPELL_ATTR4_AURA_EXPIRES_OFFLINE", "Buff expires while offline", "Debuffs (except Resurrection Sickness) will automatically do this" };
        case SPELL_ATTR4_NO_HELPFUL_THREAT: return { "SPELL_ATTR4_NO_HELPFUL_THREAT", "Unknown attribute 3@Attr4", "" };
        case SPELL_ATTR4_NO_HARMFUL_THREAT: return { "SPELL_ATTR4_NO_HARMFUL_THREAT", "Treat as delayed spell", "This will no longer cause guards to attack on use??" };
        case SPELL_ATTR4_ALLOW_CLIENT_TARGETING: return { "SPELL_ATTR4_ALLOW_CLIENT_TARGETING", "Unknown attribute 5@Attr4", "" };
        case SPELL_ATTR4_CANNOT_BE_STOLEN: return { "SPELL_ATTR4_CANNOT_BE_STOLEN", "Aura cannot be stolen", "" };
        case SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING: return { "SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING", "Can be cast while casting", "Ignores already in-progress cast and still casts" };
        case SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS: return { "SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS", "Deals fixed damage", "" };
        case SPELL_ATTR4_COMBAT_FEEDBACK_WHEN_USABLE: return { "SPELL_ATTR4_COMBAT_FEEDBACK_WHEN_USABLE", "Spell is initially disabled (client only)", "" };
        case SPELL_ATTR4_WEAPON_SPEED_COST_SCALING: return { "SPELL_ATTR4_WEAPON_SPEED_COST_SCALING", "Attack speed modifies cost", "Adds 10 to power cost for each 1s of weapon speed" };
        case SPELL_ATTR4_NO_PARTIAL_IMMUNITY: return { "SPELL_ATTR4_NO_PARTIAL_IMMUNITY", "Unknown attribute 11@Attr4", "" };
        case SPELL_ATTR4_AURA_IS_BUFF: return { "SPELL_ATTR4_AURA_IS_BUFF", "Unknown attribute 12@Attr4", "" };
        case SPELL_ATTR4_DO_NOT_LOG_CASTER: return { "SPELL_ATTR4_DO_NOT_LOG_CASTER", "Unknown attribute 13@Attr4", "" };
        case SPELL_ATTR4_REACTIVE_DAMAGE_PROC: return { "SPELL_ATTR4_REACTIVE_DAMAGE_PROC", "Damage does not break auras", "" };
        case SPELL_ATTR4_NOT_IN_SPELLBOOK: return { "SPELL_ATTR4_NOT_IN_SPELLBOOK", "Unknown attribute 15@Attr4", "" };
        case SPELL_ATTR4_NOT_IN_ARENA_OR_RATED_BATTLEGROUND: return { "SPELL_ATTR4_NOT_IN_ARENA_OR_RATED_BATTLEGROUND", "Not usable in arena", "Makes spell unusable despite CD <= 10min" };
        case SPELL_ATTR4_IGNORE_DEFAULT_ARENA_RESTRICTIONS: return { "SPELL_ATTR4_IGNORE_DEFAULT_ARENA_RESTRICTIONS", "Usable in arena", "Makes spell usable despite CD > 10min" };
        case SPELL_ATTR4_BOUNCY_CHAIN_MISSILES: return { "SPELL_ATTR4_BOUNCY_CHAIN_MISSILES", "Chain area targets", "[NYI] Hits area targets over time instead of all at once" };
        case SPELL_ATTR4_ALLOW_PROC_WHILE_SITTING: return { "SPELL_ATTR4_ALLOW_PROC_WHILE_SITTING", "Unknown attribute 19@Attr4", "proc dalayed, after damage or don't proc on absorb?" };
        case SPELL_ATTR4_AURA_NEVER_BOUNCES: return { "SPELL_ATTR4_AURA_NEVER_BOUNCES", "Allow self-cast to override stronger aura (client only)", "" };
        case SPELL_ATTR4_ALLOW_ENETRING_ARENA: return { "SPELL_ATTR4_ALLOW_ENETRING_ARENA", "Keep when entering arena", "" };
        case SPELL_ATTR4_PROC_SUPPRESS_SWING_ANIM: return { "SPELL_ATTR4_PROC_SUPPRESS_SWING_ANIM", "Unknown attribute 22@Attr4", "Seal of Command (42058,57770) and Gymer's Smash 55426" };
        case SPELL_ATTR4_SUPRESS_WEAPON_PROCS: return { "SPELL_ATTR4_SUPRESS_WEAPON_PROCS", "Cannot trigger item spells", "" };
        case SPELL_ATTR4_AUTO_RANGED_COMBAT: return { "SPELL_ATTR4_AUTO_RANGED_COMBAT", "Unknown attribute 24@Attr4", "Shoot-type spell?" };
        case SPELL_ATTR4_OWNER_POWER_SCALING: return { "SPELL_ATTR4_OWNER_POWER_SCALING", "Pet Scaling aura", "" };
        case SPELL_ATTR4_ONLY_FLYING_AREAS: return { "SPELL_ATTR4_ONLY_FLYING_AREAS", "Only in Outland/Northrend", "" };
        case SPELL_ATTR4_FORCE_DISPLAY_CASTBAR: return { "SPELL_ATTR4_FORCE_DISPLAY_CASTBAR", "Inherit critical chance from triggering aura", "" };
        case SPELL_ATTR4_IGNORE_COMBAT_TIMERS: return { "SPELL_ATTR4_IGNORE_COMBAT_TIMERS", "Unknown attribute 28@Attr4", "Aimed Shot" };
        case SPELL_ATTR4_AURA_BOUNCE_FAILS_SPELL: return { "SPELL_ATTR4_AURA_BOUNCE_FAILS_SPELL", "Unknown attribute 29@Attr4", "" };
        case SPELL_ATTR4_OBSOLETE: return { "SPELL_ATTR4_OBSOLETE", "Unknown attribute 30@Attr4", "" };
        case SPELL_ATTR4_USE_FACING_FROM_SPELL: return { "SPELL_ATTR4_USE_FACING_FROM_SPELL", "Unknown attribute 31@Attr4", "Polymorph (chicken) 228 and Sonic Boom (38052,38488)" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr4>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr4 EnumUtils<SpellAttr4>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR4_NO_CAST_LOG;
        case 1: return SPELL_ATTR4_CLASS_TRIGGER_ONLY_ON_TARGET;
        case 2: return SPELL_ATTR4_AURA_EXPIRES_OFFLINE;
        case 3: return SPELL_ATTR4_NO_HELPFUL_THREAT;
        case 4: return SPELL_ATTR4_NO_HARMFUL_THREAT;
        case 5: return SPELL_ATTR4_ALLOW_CLIENT_TARGETING;
        case 6: return SPELL_ATTR4_CANNOT_BE_STOLEN;
        case 7: return SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING;
        case 8: return SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS;
        case 9: return SPELL_ATTR4_COMBAT_FEEDBACK_WHEN_USABLE;
        case 10: return SPELL_ATTR4_WEAPON_SPEED_COST_SCALING;
        case 11: return SPELL_ATTR4_NO_PARTIAL_IMMUNITY;
        case 12: return SPELL_ATTR4_AURA_IS_BUFF;
        case 13: return SPELL_ATTR4_DO_NOT_LOG_CASTER;
        case 14: return SPELL_ATTR4_REACTIVE_DAMAGE_PROC;
        case 15: return SPELL_ATTR4_NOT_IN_SPELLBOOK;
        case 16: return SPELL_ATTR4_NOT_IN_ARENA_OR_RATED_BATTLEGROUND;
        case 17: return SPELL_ATTR4_IGNORE_DEFAULT_ARENA_RESTRICTIONS;
        case 18: return SPELL_ATTR4_BOUNCY_CHAIN_MISSILES;
        case 19: return SPELL_ATTR4_ALLOW_PROC_WHILE_SITTING;
        case 20: return SPELL_ATTR4_AURA_NEVER_BOUNCES;
        case 21: return SPELL_ATTR4_ALLOW_ENETRING_ARENA;
        case 22: return SPELL_ATTR4_PROC_SUPPRESS_SWING_ANIM;
        case 23: return SPELL_ATTR4_SUPRESS_WEAPON_PROCS;
        case 24: return SPELL_ATTR4_AUTO_RANGED_COMBAT;
        case 25: return SPELL_ATTR4_OWNER_POWER_SCALING;
        case 26: return SPELL_ATTR4_ONLY_FLYING_AREAS;
        case 27: return SPELL_ATTR4_FORCE_DISPLAY_CASTBAR;
        case 28: return SPELL_ATTR4_IGNORE_COMBAT_TIMERS;
        case 29: return SPELL_ATTR4_AURA_BOUNCE_FAILS_SPELL;
        case 30: return SPELL_ATTR4_OBSOLETE;
        case 31: return SPELL_ATTR4_USE_FACING_FROM_SPELL;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr4>::ToIndex(SpellAttr4 value)
{
    switch (value)
    {
        case SPELL_ATTR4_NO_CAST_LOG: return 0;
        case SPELL_ATTR4_CLASS_TRIGGER_ONLY_ON_TARGET: return 1;
        case SPELL_ATTR4_AURA_EXPIRES_OFFLINE: return 2;
        case SPELL_ATTR4_NO_HELPFUL_THREAT: return 3;
        case SPELL_ATTR4_NO_HARMFUL_THREAT: return 4;
        case SPELL_ATTR4_ALLOW_CLIENT_TARGETING: return 5;
        case SPELL_ATTR4_CANNOT_BE_STOLEN: return 6;
        case SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING: return 7;
        case SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS: return 8;
        case SPELL_ATTR4_COMBAT_FEEDBACK_WHEN_USABLE: return 9;
        case SPELL_ATTR4_WEAPON_SPEED_COST_SCALING: return 10;
        case SPELL_ATTR4_NO_PARTIAL_IMMUNITY: return 11;
        case SPELL_ATTR4_AURA_IS_BUFF: return 12;
        case SPELL_ATTR4_DO_NOT_LOG_CASTER: return 13;
        case SPELL_ATTR4_REACTIVE_DAMAGE_PROC: return 14;
        case SPELL_ATTR4_NOT_IN_SPELLBOOK: return 15;
        case SPELL_ATTR4_NOT_IN_ARENA_OR_RATED_BATTLEGROUND: return 16;
        case SPELL_ATTR4_IGNORE_DEFAULT_ARENA_RESTRICTIONS: return 17;
        case SPELL_ATTR4_BOUNCY_CHAIN_MISSILES: return 18;
        case SPELL_ATTR4_ALLOW_PROC_WHILE_SITTING: return 19;
        case SPELL_ATTR4_AURA_NEVER_BOUNCES: return 20;
        case SPELL_ATTR4_ALLOW_ENETRING_ARENA: return 21;
        case SPELL_ATTR4_PROC_SUPPRESS_SWING_ANIM: return 22;
        case SPELL_ATTR4_SUPRESS_WEAPON_PROCS: return 23;
        case SPELL_ATTR4_AUTO_RANGED_COMBAT: return 24;
        case SPELL_ATTR4_OWNER_POWER_SCALING: return 25;
        case SPELL_ATTR4_ONLY_FLYING_AREAS: return 26;
        case SPELL_ATTR4_FORCE_DISPLAY_CASTBAR: return 27;
        case SPELL_ATTR4_IGNORE_COMBAT_TIMERS: return 28;
        case SPELL_ATTR4_AURA_BOUNCE_FAILS_SPELL: return 29;
        case SPELL_ATTR4_OBSOLETE: return 30;
        case SPELL_ATTR4_USE_FACING_FROM_SPELL: return 31;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr5' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr5>::ToString(SpellAttr5 value)
{
    switch (value)
    {
        case SPELL_ATTR5_ALLOW_ACTION_DURING_CHANNEL: return { "SPELL_ATTR5_ALLOW_ACTION_DURING_CHANNEL", "Can be channeled while moving", "" };
        case SPELL_ATTR5_NO_REAGENT_COST_WITH_AURA: return { "SPELL_ATTR5_NO_REAGENT_COST_WITH_AURA", "No reagents during arena preparation", "" };
        case SPELL_ATTR5_REMOVE_ENTERING_ARENA: return { "SPELL_ATTR5_REMOVE_ENTERING_ARENA", "Remove when entering arena", "Force this aura to be removed on entering arena, regardless of other properties" };
        case SPELL_ATTR5_ALLOW_WHILE_STUNNED: return { "SPELL_ATTR5_ALLOW_WHILE_STUNNED", "Usable while stunned", "" };
        case SPELL_ATTR5_TRIGGERS_CHANNELING: return { "SPELL_ATTR5_TRIGGERS_CHANNELING", "Unknown attribute 4@Attr5", "" };
        case SPELL_ATTR5_LIMIT_N: return { "SPELL_ATTR5_LIMIT_N", "Single-target aura", "Remove previous application to another unit if applied" };
        case SPELL_ATTR5_IGNORE_AREA_EFFECT_PVP_CHECK: return { "SPELL_ATTR5_IGNORE_AREA_EFFECT_PVP_CHECK", "Unknown attribute 6@Attr5", "" };
        case SPELL_ATTR5_NOT_ON_PLAYER: return { "SPELL_ATTR5_NOT_ON_PLAYER", "Unknown attribute 7@Attr5", "" };
        case SPELL_ATTR5_NOT_ON_PLAYER_CONTROLLED_NPC: return { "SPELL_ATTR5_NOT_ON_PLAYER_CONTROLLED_NPC", "Cannot target player controlled units but can target players", "" };
        case SPELL_ATTR5_EXTRA_INITIAL_PERIOD: return { "SPELL_ATTR5_EXTRA_INITIAL_PERIOD", "Immediately do periodic tick on apply", "" };
        case SPELL_ATTR5_DO_NOT_DISPLAY_DURATION: return { "SPELL_ATTR5_DO_NOT_DISPLAY_DURATION", "Do not send aura duration to client", "" };
        case SPELL_ATTR5_IMPLIED_TARGETING: return { "SPELL_ATTR5_IMPLIED_TARGETING", "Auto-target target of target (client only)", "" };
        case SPELL_ATTR5_MELEE_CHAIN_TARGETING: return { "SPELL_ATTR5_MELEE_CHAIN_TARGETING", "Unknown attribute 12@Attr5", "Cleave related?" };
        case SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC: return { "SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC", "Duration scales with Haste Rating", "" };
        case SPELL_ATTR5_NOT_AVALIABLE_WHILE_CHARMED: return { "SPELL_ATTR5_NOT_AVALIABLE_WHILE_CHARMED", "Charmed units cannot cast this spell", "" };
        case SPELL_ATTR5_TREAT_AS_AREA_EFFECT: return { "SPELL_ATTR5_TREAT_AS_AREA_EFFECT", "Unknown attribute 15@Attr5", "Related to multi-target spells?" };
        case SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPED_ITEM: return { "SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPED_ITEM", "DESCRIPTION this allows spells with EquippedItemClass to affect spells from other items if the required item is equipped", "" };
        case SPELL_ATTR5_ALLOW_WHILE_FLEEING: return { "SPELL_ATTR5_ALLOW_WHILE_FLEEING", "Usable while feared", "" };
        case SPELL_ATTR5_ALLOW_WHILE_CONFUSED: return { "SPELL_ATTR5_ALLOW_WHILE_CONFUSED", "Usable while confused", "" };
        case SPELL_ATTR5_AI_DOESNT_FACE_TARGET: return { "SPELL_ATTR5_AI_DOESNT_FACE_TARGET", "Do not auto-turn while casting", "" };
        case SPELL_ATTR5_DO_NOT_ATTEMPT_A_PET_RESUMMON_WHEN_DISMOUNTING: return { "SPELL_ATTR5_DO_NOT_ATTEMPT_A_PET_RESUMMON_WHEN_DISMOUNTING", "Unknown attribute 20@Attr5", "" };
        case SPELL_ATTR5_IGNORE_TARGET_REQUIREMENTS: return { "SPELL_ATTR5_IGNORE_TARGET_REQUIREMENTS", "Unknown attribute 21@Attr5", "" };
        case SPELL_ATTR5_NOT_ON_TRIVIAL: return { "SPELL_ATTR5_NOT_ON_TRIVIAL", "Unknown attribute 22@Attr5", "" };
        case SPELL_ATTR5_NO_PARTIAL_RESISTS: return { "SPELL_ATTR5_NO_PARTIAL_RESISTS", "Unknown attribute 23@Attr5", "" };
        case SPELL_ATTR5_IGNORE_CASTER_REQUIREMENETS: return { "SPELL_ATTR5_IGNORE_CASTER_REQUIREMENETS", "Unknown attribute 24@Attr5", "" };
        case SPELL_ATTR5_ALWAYS_LINE_OF_SIGHT: return { "SPELL_ATTR5_ALWAYS_LINE_OF_SIGHT", "Unknown attribute 25@Attr5", "" };
        case SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT: return { "SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT", "Ignore line of sight checks", "" };
        case SPELL_ATTR5_NO_CASTER_AURA_ICON: return { "SPELL_ATTR5_NO_CASTER_AURA_ICON", "Don't show aura if self-cast (client only)", "" };
        case SPELL_ATTR5_NO_TARGET_AURA_ICON: return { "SPELL_ATTR5_NO_TARGET_AURA_ICON", "Don't show aura unless self-cast (client only)", "" };
        case SPELL_ATTR5_AURA_UNIQUE_PER_CASTER: return { "SPELL_ATTR5_AURA_UNIQUE_PER_CASTER", "Unknown attribute 29@Attr5", "" };
        case SPELL_ATTR5_ALWAYS_SHOW_GROUND_TEXTURE: return { "SPELL_ATTR5_ALWAYS_SHOW_GROUND_TEXTURE", "Unknown attribute 30@Attr5", "" };
        case SPELL_ATTR5_ADD_MELEE_HIT_RATING: return { "SPELL_ATTR5_ADD_MELEE_HIT_RATING", "Unknown attribute 31@Attr5", "Forces nearby enemies to attack caster?" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr5>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr5 EnumUtils<SpellAttr5>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR5_ALLOW_ACTION_DURING_CHANNEL;
        case 1: return SPELL_ATTR5_NO_REAGENT_COST_WITH_AURA;
        case 2: return SPELL_ATTR5_REMOVE_ENTERING_ARENA;
        case 3: return SPELL_ATTR5_ALLOW_WHILE_STUNNED;
        case 4: return SPELL_ATTR5_TRIGGERS_CHANNELING;
        case 5: return SPELL_ATTR5_LIMIT_N;
        case 6: return SPELL_ATTR5_IGNORE_AREA_EFFECT_PVP_CHECK;
        case 7: return SPELL_ATTR5_NOT_ON_PLAYER;
        case 8: return SPELL_ATTR5_NOT_ON_PLAYER_CONTROLLED_NPC;
        case 9: return SPELL_ATTR5_EXTRA_INITIAL_PERIOD;
        case 10: return SPELL_ATTR5_DO_NOT_DISPLAY_DURATION;
        case 11: return SPELL_ATTR5_IMPLIED_TARGETING;
        case 12: return SPELL_ATTR5_MELEE_CHAIN_TARGETING;
        case 13: return SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC;
        case 14: return SPELL_ATTR5_NOT_AVALIABLE_WHILE_CHARMED;
        case 15: return SPELL_ATTR5_TREAT_AS_AREA_EFFECT;
        case 16: return SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPED_ITEM;
        case 17: return SPELL_ATTR5_ALLOW_WHILE_FLEEING;
        case 18: return SPELL_ATTR5_ALLOW_WHILE_CONFUSED;
        case 19: return SPELL_ATTR5_AI_DOESNT_FACE_TARGET;
        case 20: return SPELL_ATTR5_DO_NOT_ATTEMPT_A_PET_RESUMMON_WHEN_DISMOUNTING;
        case 21: return SPELL_ATTR5_IGNORE_TARGET_REQUIREMENTS;
        case 22: return SPELL_ATTR5_NOT_ON_TRIVIAL;
        case 23: return SPELL_ATTR5_NO_PARTIAL_RESISTS;
        case 24: return SPELL_ATTR5_IGNORE_CASTER_REQUIREMENETS;
        case 25: return SPELL_ATTR5_ALWAYS_LINE_OF_SIGHT;
        case 26: return SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT;
        case 27: return SPELL_ATTR5_NO_CASTER_AURA_ICON;
        case 28: return SPELL_ATTR5_NO_TARGET_AURA_ICON;
        case 29: return SPELL_ATTR5_AURA_UNIQUE_PER_CASTER;
        case 30: return SPELL_ATTR5_ALWAYS_SHOW_GROUND_TEXTURE;
        case 31: return SPELL_ATTR5_ADD_MELEE_HIT_RATING;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr5>::ToIndex(SpellAttr5 value)
{
    switch (value)
    {
        case SPELL_ATTR5_ALLOW_ACTION_DURING_CHANNEL: return 0;
        case SPELL_ATTR5_NO_REAGENT_COST_WITH_AURA: return 1;
        case SPELL_ATTR5_REMOVE_ENTERING_ARENA: return 2;
        case SPELL_ATTR5_ALLOW_WHILE_STUNNED: return 3;
        case SPELL_ATTR5_TRIGGERS_CHANNELING: return 4;
        case SPELL_ATTR5_LIMIT_N: return 5;
        case SPELL_ATTR5_IGNORE_AREA_EFFECT_PVP_CHECK: return 6;
        case SPELL_ATTR5_NOT_ON_PLAYER: return 7;
        case SPELL_ATTR5_NOT_ON_PLAYER_CONTROLLED_NPC: return 8;
        case SPELL_ATTR5_EXTRA_INITIAL_PERIOD: return 9;
        case SPELL_ATTR5_DO_NOT_DISPLAY_DURATION: return 10;
        case SPELL_ATTR5_IMPLIED_TARGETING: return 11;
        case SPELL_ATTR5_MELEE_CHAIN_TARGETING: return 12;
        case SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC: return 13;
        case SPELL_ATTR5_NOT_AVALIABLE_WHILE_CHARMED: return 14;
        case SPELL_ATTR5_TREAT_AS_AREA_EFFECT: return 15;
        case SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPED_ITEM: return 16;
        case SPELL_ATTR5_ALLOW_WHILE_FLEEING: return 17;
        case SPELL_ATTR5_ALLOW_WHILE_CONFUSED: return 18;
        case SPELL_ATTR5_AI_DOESNT_FACE_TARGET: return 19;
        case SPELL_ATTR5_DO_NOT_ATTEMPT_A_PET_RESUMMON_WHEN_DISMOUNTING: return 20;
        case SPELL_ATTR5_IGNORE_TARGET_REQUIREMENTS: return 21;
        case SPELL_ATTR5_NOT_ON_TRIVIAL: return 22;
        case SPELL_ATTR5_NO_PARTIAL_RESISTS: return 23;
        case SPELL_ATTR5_IGNORE_CASTER_REQUIREMENETS: return 24;
        case SPELL_ATTR5_ALWAYS_LINE_OF_SIGHT: return 25;
        case SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT: return 26;
        case SPELL_ATTR5_NO_CASTER_AURA_ICON: return 27;
        case SPELL_ATTR5_NO_TARGET_AURA_ICON: return 28;
        case SPELL_ATTR5_AURA_UNIQUE_PER_CASTER: return 29;
        case SPELL_ATTR5_ALWAYS_SHOW_GROUND_TEXTURE: return 30;
        case SPELL_ATTR5_ADD_MELEE_HIT_RATING: return 31;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr6' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr6>::ToString(SpellAttr6 value)
{
    switch (value)
    {
        case SPELL_ATTR6_NO_COOLDOWN_ON_TOOLTIP: return { "SPELL_ATTR6_NO_COOLDOWN_ON_TOOLTIP", "Don't display cooldown (client only)", "" };
        case SPELL_ATTR6_DO_NOT_RESET_COOLDOWN_IN_ARENA: return { "SPELL_ATTR6_DO_NOT_RESET_COOLDOWN_IN_ARENA", "Only usable in arena", "" };
        case SPELL_ATTR6_NOT_AN_ATTACK: return { "SPELL_ATTR6_NOT_AN_ATTACK", "Ignore all preventing caster auras", "" };
        case SPELL_ATTR6_CAN_ASSIST_IMMUNE_PC: return { "SPELL_ATTR6_CAN_ASSIST_IMMUNE_PC", "Ignore immunity flags when assisting", "" };
        case SPELL_ATTR6_IGNORE_FOR_MOD_TIME_RATE: return { "SPELL_ATTR6_IGNORE_FOR_MOD_TIME_RATE", "Unknown attribute 4@Attr6", "" };
        case SPELL_ATTR6_DO_NOT_CONSUME_RESOURCES: return { "SPELL_ATTR6_DO_NOT_CONSUME_RESOURCES", "Don't consume proc charges", "" };
        case SPELL_ATTR6_FLOATING_COMBAT_TEXT_ON_CAST: return { "SPELL_ATTR6_FLOATING_COMBAT_TEXT_ON_CAST", "Generate spell_cast event instead of aura_start (client only)", "" };
        case SPELL_ATTR6_AURA_IS_WEAPON_PROC: return { "SPELL_ATTR6_AURA_IS_WEAPON_PROC", "Unknown attribute 7@Attr6", "" };
        case SPELL_ATTR6_DO_NOT_CHAIN_TO_CROWD_CONTROLLED_TARGETS: return { "SPELL_ATTR6_DO_NOT_CHAIN_TO_CROWD_CONTROLLED_TARGETS", "Do not implicitly target in CC", "Implicit targeting (chaining and area targeting) will not impact crowd controlled targets" };
        case SPELL_ATTR6_ALLOW_ON_CHARMED_TARGETS: return { "SPELL_ATTR6_ALLOW_ON_CHARMED_TARGETS", "Unknown attribute 9@Attr6", "" };
        case SPELL_ATTR6_NO_AURA_LOG: return { "SPELL_ATTR6_NO_AURA_LOG", "Can target possessed friends", "[NYI]" };
        case SPELL_ATTR6_NOT_IN_RAID_INSTANCES: return { "SPELL_ATTR6_NOT_IN_RAID_INSTANCES", "Unusable in raid instances", "" };
        case SPELL_ATTR6_ALLOW_WHILE_RIDING_VEHICLE: return { "SPELL_ATTR6_ALLOW_WHILE_RIDING_VEHICLE", "Castable while caster is on vehicle", "" };
        case SPELL_ATTR6_IGNORE_PHASE_SHIFT: return { "SPELL_ATTR6_IGNORE_PHASE_SHIFT", "Can target invisible units", "" };
        case SPELL_ATTR6_AI_PRIMARY_RANGED_ATTACK: return { "SPELL_ATTR6_AI_PRIMARY_RANGED_ATTACK", "Unknown attribute 14@Attr6", "" };
        case SPELL_ATTR6_NO_PUSHBACK: return { "SPELL_ATTR6_NO_PUSHBACK", "Unknown attribute 15@Attr6", "only 54368, 67892" };
        case SPELL_ATTR6_NO_JUMP_PATHING: return { "SPELL_ATTR6_NO_JUMP_PATHING", "Unknown attribute 16@Attr6", "" };
        case SPELL_ATTR6_ALLOW_EQUIP_WHILE_CASTING: return { "SPELL_ATTR6_ALLOW_EQUIP_WHILE_CASTING", "Unknown attribute 17@Attr6", "Mount related?" };
        case SPELL_ATTR6_ORIGINATE_FROM_CONTROLLER: return { "SPELL_ATTR6_ORIGINATE_FROM_CONTROLLER", "Spell is cast by charmer", "Client will prevent casting if not possessed, charmer will be caster for all intents and purposes" };
        case SPELL_ATTR6_DELAY_COMBAT_TIMER_DURING_CAST: return { "SPELL_ATTR6_DELAY_COMBAT_TIMER_DURING_CAST", "Unknown attribute 19@Attr6", "only 47488, 50782" };
        case SPELL_ATTR6_AURA_ICON_ONLY_FOR_CASTER: return { "SPELL_ATTR6_AURA_ICON_ONLY_FOR_CASTER", "Only visible to caster (client only) (LIMIT 10)", "" };
        case SPELL_ATTR6_SHOW_MECHANIC_AS_COMBAT_TEXT: return { "SPELL_ATTR6_SHOW_MECHANIC_AS_COMBAT_TEXT", "Client UI target effects (client only)", "" };
        case SPELL_ATTR6_ABSORB_CANNOT_BE_IGNORED: return { "SPELL_ATTR6_ABSORB_CANNOT_BE_IGNORED", "Unknown attribute 22@Attr6", "only 72054" };
        case SPELL_ATTR6_TAPS_IMMEDIATELY: return { "SPELL_ATTR6_TAPS_IMMEDIATELY", "Unknown attribute 23@Attr6", "" };
        case SPELL_ATTR6_CAN_TARGET_UNTARGETABLE: return { "SPELL_ATTR6_CAN_TARGET_UNTARGETABLE", "Can target untargetable units", "" };
        case SPELL_ATTR6_DOESNT_RESET_SWING_TIMER_IF_INSTANT: return { "SPELL_ATTR6_DOESNT_RESET_SWING_TIMER_IF_INSTANT", "Do not reset swing timer if cast time is instant", "" };
        case SPELL_ATTR6_VEHICLE_IMMUNITY_CATEGORY: return { "SPELL_ATTR6_VEHICLE_IMMUNITY_CATEGORY", "Unknown attribute 26@Attr6", "Player castable buff?" };
        case SPELL_ATTR6_IGNORE_HEALTH_MODIFIERS: return { "SPELL_ATTR6_IGNORE_HEALTH_MODIFIERS", "Limit applicable %healing modifiers", "This prevents certain healing modifiers from applying - see implementation if you really care about details" };
        case SPELL_ATTR6_DO_NOT_SELECT_TARGET_WITH_INITIATES_COMBAT: return { "SPELL_ATTR6_DO_NOT_SELECT_TARGET_WITH_INITIATES_COMBAT", "Unknown attribute 28@Attr6", "Death grip?" };
        case SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS: return { "SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS", "Limit applicable %damage modifiers", "This prevents certain damage modifiers from applying - see implementation if you really care about details" };
        case SPELL_ATTR6_DISABLE_TIED_EFFECT_POINTS: return { "SPELL_ATTR6_DISABLE_TIED_EFFECT_POINTS", "Unknown attribute 30@Attr6", "" };
        case SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS: return { "SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS", "Ignore cooldown modifiers for category cooldown", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr6>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr6 EnumUtils<SpellAttr6>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR6_NO_COOLDOWN_ON_TOOLTIP;
        case 1: return SPELL_ATTR6_DO_NOT_RESET_COOLDOWN_IN_ARENA;
        case 2: return SPELL_ATTR6_NOT_AN_ATTACK;
        case 3: return SPELL_ATTR6_CAN_ASSIST_IMMUNE_PC;
        case 4: return SPELL_ATTR6_IGNORE_FOR_MOD_TIME_RATE;
        case 5: return SPELL_ATTR6_DO_NOT_CONSUME_RESOURCES;
        case 6: return SPELL_ATTR6_FLOATING_COMBAT_TEXT_ON_CAST;
        case 7: return SPELL_ATTR6_AURA_IS_WEAPON_PROC;
        case 8: return SPELL_ATTR6_DO_NOT_CHAIN_TO_CROWD_CONTROLLED_TARGETS;
        case 9: return SPELL_ATTR6_ALLOW_ON_CHARMED_TARGETS;
        case 10: return SPELL_ATTR6_NO_AURA_LOG;
        case 11: return SPELL_ATTR6_NOT_IN_RAID_INSTANCES;
        case 12: return SPELL_ATTR6_ALLOW_WHILE_RIDING_VEHICLE;
        case 13: return SPELL_ATTR6_IGNORE_PHASE_SHIFT;
        case 14: return SPELL_ATTR6_AI_PRIMARY_RANGED_ATTACK;
        case 15: return SPELL_ATTR6_NO_PUSHBACK;
        case 16: return SPELL_ATTR6_NO_JUMP_PATHING;
        case 17: return SPELL_ATTR6_ALLOW_EQUIP_WHILE_CASTING;
        case 18: return SPELL_ATTR6_ORIGINATE_FROM_CONTROLLER;
        case 19: return SPELL_ATTR6_DELAY_COMBAT_TIMER_DURING_CAST;
        case 20: return SPELL_ATTR6_AURA_ICON_ONLY_FOR_CASTER;
        case 21: return SPELL_ATTR6_SHOW_MECHANIC_AS_COMBAT_TEXT;
        case 22: return SPELL_ATTR6_ABSORB_CANNOT_BE_IGNORED;
        case 23: return SPELL_ATTR6_TAPS_IMMEDIATELY;
        case 24: return SPELL_ATTR6_CAN_TARGET_UNTARGETABLE;
        case 25: return SPELL_ATTR6_DOESNT_RESET_SWING_TIMER_IF_INSTANT;
        case 26: return SPELL_ATTR6_VEHICLE_IMMUNITY_CATEGORY;
        case 27: return SPELL_ATTR6_IGNORE_HEALTH_MODIFIERS;
        case 28: return SPELL_ATTR6_DO_NOT_SELECT_TARGET_WITH_INITIATES_COMBAT;
        case 29: return SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS;
        case 30: return SPELL_ATTR6_DISABLE_TIED_EFFECT_POINTS;
        case 31: return SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr6>::ToIndex(SpellAttr6 value)
{
    switch (value)
    {
        case SPELL_ATTR6_NO_COOLDOWN_ON_TOOLTIP: return 0;
        case SPELL_ATTR6_DO_NOT_RESET_COOLDOWN_IN_ARENA: return 1;
        case SPELL_ATTR6_NOT_AN_ATTACK: return 2;
        case SPELL_ATTR6_CAN_ASSIST_IMMUNE_PC: return 3;
        case SPELL_ATTR6_IGNORE_FOR_MOD_TIME_RATE: return 4;
        case SPELL_ATTR6_DO_NOT_CONSUME_RESOURCES: return 5;
        case SPELL_ATTR6_FLOATING_COMBAT_TEXT_ON_CAST: return 6;
        case SPELL_ATTR6_AURA_IS_WEAPON_PROC: return 7;
        case SPELL_ATTR6_DO_NOT_CHAIN_TO_CROWD_CONTROLLED_TARGETS: return 8;
        case SPELL_ATTR6_ALLOW_ON_CHARMED_TARGETS: return 9;
        case SPELL_ATTR6_NO_AURA_LOG: return 10;
        case SPELL_ATTR6_NOT_IN_RAID_INSTANCES: return 11;
        case SPELL_ATTR6_ALLOW_WHILE_RIDING_VEHICLE: return 12;
        case SPELL_ATTR6_IGNORE_PHASE_SHIFT: return 13;
        case SPELL_ATTR6_AI_PRIMARY_RANGED_ATTACK: return 14;
        case SPELL_ATTR6_NO_PUSHBACK: return 15;
        case SPELL_ATTR6_NO_JUMP_PATHING: return 16;
        case SPELL_ATTR6_ALLOW_EQUIP_WHILE_CASTING: return 17;
        case SPELL_ATTR6_ORIGINATE_FROM_CONTROLLER: return 18;
        case SPELL_ATTR6_DELAY_COMBAT_TIMER_DURING_CAST: return 19;
        case SPELL_ATTR6_AURA_ICON_ONLY_FOR_CASTER: return 20;
        case SPELL_ATTR6_SHOW_MECHANIC_AS_COMBAT_TEXT: return 21;
        case SPELL_ATTR6_ABSORB_CANNOT_BE_IGNORED: return 22;
        case SPELL_ATTR6_TAPS_IMMEDIATELY: return 23;
        case SPELL_ATTR6_CAN_TARGET_UNTARGETABLE: return 24;
        case SPELL_ATTR6_DOESNT_RESET_SWING_TIMER_IF_INSTANT: return 25;
        case SPELL_ATTR6_VEHICLE_IMMUNITY_CATEGORY: return 26;
        case SPELL_ATTR6_IGNORE_HEALTH_MODIFIERS: return 27;
        case SPELL_ATTR6_DO_NOT_SELECT_TARGET_WITH_INITIATES_COMBAT: return 28;
        case SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS: return 29;
        case SPELL_ATTR6_DISABLE_TIED_EFFECT_POINTS: return 30;
        case SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS: return 31;
        default: throw std::out_of_range("value");
    }
}

/******************************************************************\
|* data for enum 'SpellAttr7' in 'SharedDefines.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<SpellAttr7>::ToString(SpellAttr7 value)
{
    switch (value)
    {
        case SPELL_ATTR7_ALLOW_SPELL_REFLECTION: return { "SPELL_ATTR7_ALLOW_SPELL_REFLECTION", "Unknown attribute 0@Attr7", "Shaman's new spells (Call of the ...), Feign Death." };
        case SPELL_ATTR7_NO_TARGET_DURATION_MOD: return { "SPELL_ATTR7_NO_TARGET_DURATION_MOD", "Ignore duration modifiers", "" };
        case SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD: return { "SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD", "Reactivate at resurrect (client only)", "" };
        case SPELL_ATTR7_DEBUG_SPELL: return { "SPELL_ATTR7_DEBUG_SPELL", "Is cheat spell", "Cannot cast if caster doesn't have UnitFlag2 & UNIT_FLAG2_ALLOW_CHEAT_SPELLS" };
        case SPELL_ATTR7_TREAT_AS_RAID_BUFF: return { "SPELL_ATTR7_TREAT_AS_RAID_BUFF", "Unknown attribute 4@Attr7", "Soulstone related?" };
        case SPELL_ATTR7_CAN_BE_MULTI_CAST: return { "SPELL_ATTR7_CAN_BE_MULTI_CAST", "Summons player-owned totem", "" };
        case SPELL_ATTR7_DONT_CAUSE_SPELL_PUSHBACK: return { "SPELL_ATTR7_DONT_CAUSE_SPELL_PUSHBACK", "Damage dealt by this does not cause spell pushback", "" };
        case SPELL_ATTR7_PREPARE_FOR_VEHICLE_CONTROL_END: return { "SPELL_ATTR7_PREPARE_FOR_VEHICLE_CONTROL_END", "Unknown attribute 7@Attr7", "66218 (Launch) spell." };
        case SPELL_ATTR7_HORDE_SPECIFIC_SPELL: return { "SPELL_ATTR7_HORDE_SPECIFIC_SPELL", "Horde only", "" };
        case SPELL_ATTR7_ALLIANCE_SPECIFIC_SPELL: return { "SPELL_ATTR7_ALLIANCE_SPECIFIC_SPELL", "Alliance only", "" };
        case SPELL_ATTR7_DISPEL_REMOVES_CHARGES: return { "SPELL_ATTR7_DISPEL_REMOVES_CHARGES", "Dispel/Spellsteal remove individual charges", "" };
        case SPELL_ATTR7_CAN_CAUSE_INTERRUPT: return { "SPELL_ATTR7_CAN_CAUSE_INTERRUPT", "Only interrupt non-player casting", "" };
        case SPELL_ATTR7_CAN_CAUSE_SILENCE: return { "SPELL_ATTR7_CAN_CAUSE_SILENCE", "Unknown attribute 12@Attr7", "Not set in 3.2.2a." };
        case SPELL_ATTR7_NO_UI_NOT_INTERRUPTIBLE: return { "SPELL_ATTR7_NO_UI_NOT_INTERRUPTIBLE", "Unknown attribute 13@Attr7", "Not set in 3.2.2a." };
        case SPELL_ATTR7_RECAST_ON_RESUMMON: return { "SPELL_ATTR7_RECAST_ON_RESUMMON", "Unknown attribute 14@Attr7", "Only 52150 (Raise Dead - Pet) spell." };
        case SPELL_ATTR7_RESET_SWING_TIMER_AT_SPELL_START: return { "SPELL_ATTR7_RESET_SWING_TIMER_AT_SPELL_START", "Unknown attribute 15@Attr7", "Exorcism - guaranteed crit vs families?" };
        case SPELL_ATTR7_ONLY_IN_SPELLBOOK_UNTIL_LEARNED: return { "SPELL_ATTR7_ONLY_IN_SPELLBOOK_UNTIL_LEARNED", "Can restore secondary power", "Only spells with this attribute can replenish a non-active power type" };
        case SPELL_ATTR7_DO_NOT_LOG_PVP_KILL: return { "SPELL_ATTR7_DO_NOT_LOG_PVP_KILL", "Unknown attribute 17@Attr7", "Only 27965 (Suicide) spell." };
        case SPELL_ATTR7_ATTACK_ON_CHARGE_TO_UNIT: return { "SPELL_ATTR7_ATTACK_ON_CHARGE_TO_UNIT", "Has charge effect", "" };
        case SPELL_ATTR7_REPORT_SPELL_FAILURE_TO_UNIT_TARGET: return { "SPELL_ATTR7_REPORT_SPELL_FAILURE_TO_UNIT_TARGET", "Is zone teleport", "" };
        case SPELL_ATTR7_NO_CLIENT_FAIL_WHILE_STUNNED_FLEEING_CONFUSED: return { "SPELL_ATTR7_NO_CLIENT_FAIL_WHILE_STUNNED_FLEEING_CONFUSED", "Unknown attribute 20@Attr7", "Invulnerability related?" };
        case SPELL_ATTR7_RETAIN_COOLDOWN_THROUGH_LOAD: return { "SPELL_ATTR7_RETAIN_COOLDOWN_THROUGH_LOAD", "Unknown attribute 21@Attr7", "" };
        case SPELL_ATTR7_IGNORES_COLD_WEATHER_FLYING_REQUIREMENT: return { "SPELL_ATTR7_IGNORES_COLD_WEATHER_FLYING_REQUIREMENT", "Ignore cold weather flying restriction", "Set for loaner mounts, allows them to be used despite lacking required flight skill" };
        case SPELL_ATTR7_NO_ATTACK_DODGE: return { "SPELL_ATTR7_NO_ATTACK_DODGE", "Spell cannot be dodged 23@Attr7", "Motivate, Mutilate, Shattering Throw" };
        case SPELL_ATTR7_NO_ATTACK_PARRY: return { "SPELL_ATTR7_NO_ATTACK_PARRY", "Spell cannot be parried 24@Attr7", "Motivate, Mutilate, Perform Speech, Shattering Throw" };
        case SPELL_ATTR7_NO_ATTACK_MISS: return { "SPELL_ATTR7_NO_ATTACK_MISS", "Spell cannot be missed 25@Attr7", "" };
        case SPELL_ATTR7_TREAT_AS_NPC_AOE: return { "SPELL_ATTR7_TREAT_AS_NPC_AOE", "Unknown attribute 26@Attr7", "" };
        case SPELL_ATTR7_BYPASS_NO_RESURRECTION_AURA: return { "SPELL_ATTR7_BYPASS_NO_RESURRECTION_AURA", "Bypasses the prevent resurrection aura", "" };
        case SPELL_ATTR7_DO_NOT_COUNT_FOR_PVP_SCOREBOARD: return { "SPELL_ATTR7_DO_NOT_COUNT_FOR_PVP_SCOREBOARD", "Consolidate in raid buff frame (client only)", "" };
        case SPELL_ATTR7_REFLECTION_ONLY_DEFENDS: return { "SPELL_ATTR7_REFLECTION_ONLY_DEFENDS", "Unknown attribute 29@Attr7", "only 69028, 71237" };
        case SPELL_ATTR7_CAN_PROC_FROM_SUPPRESSED_TARGET_PROCS: return { "SPELL_ATTR7_CAN_PROC_FROM_SUPPRESSED_TARGET_PROCS", "Unknown attribute 30@Attr7", "Burning Determination, Divine Sacrifice, Earth Shield, Prayer of Mending" };
        case SPELL_ATTR7_ALWAYS_CAST_LOG: return { "SPELL_ATTR7_ALWAYS_CAST_LOG", "Client indicator (client only)", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr7>::Count() { return 32; }

template <>
AC_API_EXPORT SpellAttr7 EnumUtils<SpellAttr7>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return SPELL_ATTR7_ALLOW_SPELL_REFLECTION;
        case 1: return SPELL_ATTR7_NO_TARGET_DURATION_MOD;
        case 2: return SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD;
        case 3: return SPELL_ATTR7_DEBUG_SPELL;
        case 4: return SPELL_ATTR7_TREAT_AS_RAID_BUFF;
        case 5: return SPELL_ATTR7_CAN_BE_MULTI_CAST;
        case 6: return SPELL_ATTR7_DONT_CAUSE_SPELL_PUSHBACK;
        case 7: return SPELL_ATTR7_PREPARE_FOR_VEHICLE_CONTROL_END;
        case 8: return SPELL_ATTR7_HORDE_SPECIFIC_SPELL;
        case 9: return SPELL_ATTR7_ALLIANCE_SPECIFIC_SPELL;
        case 10: return SPELL_ATTR7_DISPEL_REMOVES_CHARGES;
        case 11: return SPELL_ATTR7_CAN_CAUSE_INTERRUPT;
        case 12: return SPELL_ATTR7_CAN_CAUSE_SILENCE;
        case 13: return SPELL_ATTR7_NO_UI_NOT_INTERRUPTIBLE;
        case 14: return SPELL_ATTR7_RECAST_ON_RESUMMON;
        case 15: return SPELL_ATTR7_RESET_SWING_TIMER_AT_SPELL_START;
        case 16: return SPELL_ATTR7_ONLY_IN_SPELLBOOK_UNTIL_LEARNED;
        case 17: return SPELL_ATTR7_DO_NOT_LOG_PVP_KILL;
        case 18: return SPELL_ATTR7_ATTACK_ON_CHARGE_TO_UNIT;
        case 19: return SPELL_ATTR7_REPORT_SPELL_FAILURE_TO_UNIT_TARGET;
        case 20: return SPELL_ATTR7_NO_CLIENT_FAIL_WHILE_STUNNED_FLEEING_CONFUSED;
        case 21: return SPELL_ATTR7_RETAIN_COOLDOWN_THROUGH_LOAD;
        case 22: return SPELL_ATTR7_IGNORES_COLD_WEATHER_FLYING_REQUIREMENT;
        case 23: return SPELL_ATTR7_NO_ATTACK_DODGE;
        case 24: return SPELL_ATTR7_NO_ATTACK_PARRY;
        case 25: return SPELL_ATTR7_NO_ATTACK_MISS;
        case 26: return SPELL_ATTR7_TREAT_AS_NPC_AOE;
        case 27: return SPELL_ATTR7_BYPASS_NO_RESURRECTION_AURA;
        case 28: return SPELL_ATTR7_DO_NOT_COUNT_FOR_PVP_SCOREBOARD;
        case 29: return SPELL_ATTR7_REFLECTION_ONLY_DEFENDS;
        case 30: return SPELL_ATTR7_CAN_PROC_FROM_SUPPRESSED_TARGET_PROCS;
        case 31: return SPELL_ATTR7_ALWAYS_CAST_LOG;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<SpellAttr7>::ToIndex(SpellAttr7 value)
{
    switch (value)
    {
        case SPELL_ATTR7_ALLOW_SPELL_REFLECTION: return 0;
        case SPELL_ATTR7_NO_TARGET_DURATION_MOD: return 1;
        case SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD: return 2;
        case SPELL_ATTR7_DEBUG_SPELL: return 3;
        case SPELL_ATTR7_TREAT_AS_RAID_BUFF: return 4;
        case SPELL_ATTR7_CAN_BE_MULTI_CAST: return 5;
        case SPELL_ATTR7_DONT_CAUSE_SPELL_PUSHBACK: return 6;
        case SPELL_ATTR7_PREPARE_FOR_VEHICLE_CONTROL_END: return 7;
        case SPELL_ATTR7_HORDE_SPECIFIC_SPELL: return 8;
        case SPELL_ATTR7_ALLIANCE_SPECIFIC_SPELL: return 9;
        case SPELL_ATTR7_DISPEL_REMOVES_CHARGES: return 10;
        case SPELL_ATTR7_CAN_CAUSE_INTERRUPT: return 11;
        case SPELL_ATTR7_CAN_CAUSE_SILENCE: return 12;
        case SPELL_ATTR7_NO_UI_NOT_INTERRUPTIBLE: return 13;
        case SPELL_ATTR7_RECAST_ON_RESUMMON: return 14;
        case SPELL_ATTR7_RESET_SWING_TIMER_AT_SPELL_START: return 15;
        case SPELL_ATTR7_ONLY_IN_SPELLBOOK_UNTIL_LEARNED: return 16;
        case SPELL_ATTR7_DO_NOT_LOG_PVP_KILL: return 17;
        case SPELL_ATTR7_ATTACK_ON_CHARGE_TO_UNIT: return 18;
        case SPELL_ATTR7_REPORT_SPELL_FAILURE_TO_UNIT_TARGET: return 19;
        case SPELL_ATTR7_NO_CLIENT_FAIL_WHILE_STUNNED_FLEEING_CONFUSED: return 20;
        case SPELL_ATTR7_RETAIN_COOLDOWN_THROUGH_LOAD: return 21;
        case SPELL_ATTR7_IGNORES_COLD_WEATHER_FLYING_REQUIREMENT: return 22;
        case SPELL_ATTR7_NO_ATTACK_DODGE: return 23;
        case SPELL_ATTR7_NO_ATTACK_PARRY: return 24;
        case SPELL_ATTR7_NO_ATTACK_MISS: return 25;
        case SPELL_ATTR7_TREAT_AS_NPC_AOE: return 26;
        case SPELL_ATTR7_BYPASS_NO_RESURRECTION_AURA: return 27;
        case SPELL_ATTR7_DO_NOT_COUNT_FOR_PVP_SCOREBOARD: return 28;
        case SPELL_ATTR7_REFLECTION_ONLY_DEFENDS: return 29;
        case SPELL_ATTR7_CAN_PROC_FROM_SUPPRESSED_TARGET_PROCS: return 30;
        case SPELL_ATTR7_ALWAYS_CAST_LOG: return 31;
        default: throw std::out_of_range("value");
    }
}

/*****************************************************************\
|* data for enum 'Mechanics' in 'SharedDefines.h' auto-generated *|
\*****************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<Mechanics>::ToString(Mechanics value)
{
    switch (value)
    {
        case MECHANIC_NONE: return { "MECHANIC_NONE", "MECHANIC_NONE", "" };
        case MECHANIC_CHARM: return { "MECHANIC_CHARM", "MECHANIC_CHARM", "" };
        case MECHANIC_DISORIENTED: return { "MECHANIC_DISORIENTED", "MECHANIC_DISORIENTED", "" };
        case MECHANIC_DISARM: return { "MECHANIC_DISARM", "MECHANIC_DISARM", "" };
        case MECHANIC_DISTRACT: return { "MECHANIC_DISTRACT", "MECHANIC_DISTRACT", "" };
        case MECHANIC_FEAR: return { "MECHANIC_FEAR", "MECHANIC_FEAR", "" };
        case MECHANIC_GRIP: return { "MECHANIC_GRIP", "MECHANIC_GRIP", "" };
        case MECHANIC_ROOT: return { "MECHANIC_ROOT", "MECHANIC_ROOT", "" };
        case MECHANIC_SLOW_ATTACK: return { "MECHANIC_SLOW_ATTACK", "MECHANIC_SLOW_ATTACK", "" };
        case MECHANIC_SILENCE: return { "MECHANIC_SILENCE", "MECHANIC_SILENCE", "" };
        case MECHANIC_SLEEP: return { "MECHANIC_SLEEP", "MECHANIC_SLEEP", "" };
        case MECHANIC_SNARE: return { "MECHANIC_SNARE", "MECHANIC_SNARE", "" };
        case MECHANIC_STUN: return { "MECHANIC_STUN", "MECHANIC_STUN", "" };
        case MECHANIC_FREEZE: return { "MECHANIC_FREEZE", "MECHANIC_FREEZE", "" };
        case MECHANIC_KNOCKOUT: return { "MECHANIC_KNOCKOUT", "MECHANIC_KNOCKOUT", "" };
        case MECHANIC_BLEED: return { "MECHANIC_BLEED", "MECHANIC_BLEED", "" };
        case MECHANIC_BANDAGE: return { "MECHANIC_BANDAGE", "MECHANIC_BANDAGE", "" };
        case MECHANIC_POLYMORPH: return { "MECHANIC_POLYMORPH", "MECHANIC_POLYMORPH", "" };
        case MECHANIC_BANISH: return { "MECHANIC_BANISH", "MECHANIC_BANISH", "" };
        case MECHANIC_SHIELD: return { "MECHANIC_SHIELD", "MECHANIC_SHIELD", "" };
        case MECHANIC_SHACKLE: return { "MECHANIC_SHACKLE", "MECHANIC_SHACKLE", "" };
        case MECHANIC_MOUNT: return { "MECHANIC_MOUNT", "MECHANIC_MOUNT", "" };
        case MECHANIC_INFECTED: return { "MECHANIC_INFECTED", "MECHANIC_INFECTED", "" };
        case MECHANIC_TURN: return { "MECHANIC_TURN", "MECHANIC_TURN", "" };
        case MECHANIC_HORROR: return { "MECHANIC_HORROR", "MECHANIC_HORROR", "" };
        case MECHANIC_INVULNERABILITY: return { "MECHANIC_INVULNERABILITY", "MECHANIC_INVULNERABILITY", "" };
        case MECHANIC_INTERRUPT: return { "MECHANIC_INTERRUPT", "MECHANIC_INTERRUPT", "" };
        case MECHANIC_DAZE: return { "MECHANIC_DAZE", "MECHANIC_DAZE", "" };
        case MECHANIC_DISCOVERY: return { "MECHANIC_DISCOVERY", "MECHANIC_DISCOVERY", "" };
        case MECHANIC_IMMUNE_SHIELD: return { "MECHANIC_IMMUNE_SHIELD", "MECHANIC_IMMUNE_SHIELD", "Divine (Blessing) Shield/Protection and Ice Block" };
        case MECHANIC_SAPPED: return { "MECHANIC_SAPPED", "MECHANIC_SAPPED", "" };
        case MECHANIC_ENRAGED: return { "MECHANIC_ENRAGED", "MECHANIC_ENRAGED", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Mechanics>::Count() { return 32; }

template <>
AC_API_EXPORT Mechanics EnumUtils<Mechanics>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return MECHANIC_NONE;
        case 1: return MECHANIC_CHARM;
        case 2: return MECHANIC_DISORIENTED;
        case 3: return MECHANIC_DISARM;
        case 4: return MECHANIC_DISTRACT;
        case 5: return MECHANIC_FEAR;
        case 6: return MECHANIC_GRIP;
        case 7: return MECHANIC_ROOT;
        case 8: return MECHANIC_SLOW_ATTACK;
        case 9: return MECHANIC_SILENCE;
        case 10: return MECHANIC_SLEEP;
        case 11: return MECHANIC_SNARE;
        case 12: return MECHANIC_STUN;
        case 13: return MECHANIC_FREEZE;
        case 14: return MECHANIC_KNOCKOUT;
        case 15: return MECHANIC_BLEED;
        case 16: return MECHANIC_BANDAGE;
        case 17: return MECHANIC_POLYMORPH;
        case 18: return MECHANIC_BANISH;
        case 19: return MECHANIC_SHIELD;
        case 20: return MECHANIC_SHACKLE;
        case 21: return MECHANIC_MOUNT;
        case 22: return MECHANIC_INFECTED;
        case 23: return MECHANIC_TURN;
        case 24: return MECHANIC_HORROR;
        case 25: return MECHANIC_INVULNERABILITY;
        case 26: return MECHANIC_INTERRUPT;
        case 27: return MECHANIC_DAZE;
        case 28: return MECHANIC_DISCOVERY;
        case 29: return MECHANIC_IMMUNE_SHIELD;
        case 30: return MECHANIC_SAPPED;
        case 31: return MECHANIC_ENRAGED;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Mechanics>::ToIndex(Mechanics value)
{
    switch (value)
    {
        case MECHANIC_NONE: return 0;
        case MECHANIC_CHARM: return 1;
        case MECHANIC_DISORIENTED: return 2;
        case MECHANIC_DISARM: return 3;
        case MECHANIC_DISTRACT: return 4;
        case MECHANIC_FEAR: return 5;
        case MECHANIC_GRIP: return 6;
        case MECHANIC_ROOT: return 7;
        case MECHANIC_SLOW_ATTACK: return 8;
        case MECHANIC_SILENCE: return 9;
        case MECHANIC_SLEEP: return 10;
        case MECHANIC_SNARE: return 11;
        case MECHANIC_STUN: return 12;
        case MECHANIC_FREEZE: return 13;
        case MECHANIC_KNOCKOUT: return 14;
        case MECHANIC_BLEED: return 15;
        case MECHANIC_BANDAGE: return 16;
        case MECHANIC_POLYMORPH: return 17;
        case MECHANIC_BANISH: return 18;
        case MECHANIC_SHIELD: return 19;
        case MECHANIC_SHACKLE: return 20;
        case MECHANIC_MOUNT: return 21;
        case MECHANIC_INFECTED: return 22;
        case MECHANIC_TURN: return 23;
        case MECHANIC_HORROR: return 24;
        case MECHANIC_INVULNERABILITY: return 25;
        case MECHANIC_INTERRUPT: return 26;
        case MECHANIC_DAZE: return 27;
        case MECHANIC_DISCOVERY: return 28;
        case MECHANIC_IMMUNE_SHIELD: return 29;
        case MECHANIC_SAPPED: return 30;
        case MECHANIC_ENRAGED: return 31;
        default: throw std::out_of_range("value");
    }
}

/*************************************************************\
|* data for enum 'Emote' in 'SharedDefines.h' auto-generated *|
\*************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<Emote>::ToString(Emote value)
{
    switch (value)
    {
        case EMOTE_ONESHOT_TALK: return { "EMOTE_ONESHOT_TALK", "EMOTE_ONESHOT_TALK", "" };
        case EMOTE_ONESHOT_BOW: return { "EMOTE_ONESHOT_BOW", "EMOTE_ONESHOT_BOW", "" };
        case EMOTE_ONESHOT_WAVE: return { "EMOTE_ONESHOT_WAVE", "EMOTE_ONESHOT_WAVE", "" };
        case EMOTE_ONESHOT_CHEER: return { "EMOTE_ONESHOT_CHEER", "EMOTE_ONESHOT_CHEER", "" };
        case EMOTE_ONESHOT_EXCLAMATION: return { "EMOTE_ONESHOT_EXCLAMATION", "EMOTE_ONESHOT_EXCLAMATION", "" };
        case EMOTE_ONESHOT_QUESTION: return { "EMOTE_ONESHOT_QUESTION", "EMOTE_ONESHOT_QUESTION", "" };
        case EMOTE_ONESHOT_EAT: return { "EMOTE_ONESHOT_EAT", "EMOTE_ONESHOT_EAT", "" };
        case EMOTE_STATE_DANCE: return { "EMOTE_STATE_DANCE", "EMOTE_STATE_DANCE", "" };
        case EMOTE_ONESHOT_LAUGH: return { "EMOTE_ONESHOT_LAUGH", "EMOTE_ONESHOT_LAUGH", "" };
        case EMOTE_STATE_SLEEP: return { "EMOTE_STATE_SLEEP", "EMOTE_STATE_SLEEP", "" };
        case EMOTE_STATE_SIT: return { "EMOTE_STATE_SIT", "EMOTE_STATE_SIT", "" };
        case EMOTE_ONESHOT_RUDE: return { "EMOTE_ONESHOT_RUDE", "EMOTE_ONESHOT_RUDE", "" };
        case EMOTE_ONESHOT_ROAR: return { "EMOTE_ONESHOT_ROAR", "EMOTE_ONESHOT_ROAR", "" };
        case EMOTE_ONESHOT_KNEEL: return { "EMOTE_ONESHOT_KNEEL", "EMOTE_ONESHOT_KNEEL", "" };
        case EMOTE_ONESHOT_KISS: return { "EMOTE_ONESHOT_KISS", "EMOTE_ONESHOT_KISS", "" };
        case EMOTE_ONESHOT_CRY: return { "EMOTE_ONESHOT_CRY", "EMOTE_ONESHOT_CRY", "" };
        case EMOTE_ONESHOT_CHICKEN: return { "EMOTE_ONESHOT_CHICKEN", "EMOTE_ONESHOT_CHICKEN", "" };
        case EMOTE_ONESHOT_BEG: return { "EMOTE_ONESHOT_BEG", "EMOTE_ONESHOT_BEG", "" };
        case EMOTE_ONESHOT_APPLAUD: return { "EMOTE_ONESHOT_APPLAUD", "EMOTE_ONESHOT_APPLAUD", "" };
        case EMOTE_ONESHOT_SHOUT: return { "EMOTE_ONESHOT_SHOUT", "EMOTE_ONESHOT_SHOUT", "" };
        case EMOTE_ONESHOT_FLEX: return { "EMOTE_ONESHOT_FLEX", "EMOTE_ONESHOT_FLEX", "" };
        case EMOTE_ONESHOT_SHY: return { "EMOTE_ONESHOT_SHY", "EMOTE_ONESHOT_SHY", "" };
        case EMOTE_ONESHOT_POINT: return { "EMOTE_ONESHOT_POINT", "EMOTE_ONESHOT_POINT", "" };
        case EMOTE_STATE_STAND: return { "EMOTE_STATE_STAND", "EMOTE_STATE_STAND", "" };
        case EMOTE_STATE_READY_UNARMED: return { "EMOTE_STATE_READY_UNARMED", "EMOTE_STATE_READY_UNARMED", "" };
        case EMOTE_STATE_WORK_SHEATHED: return { "EMOTE_STATE_WORK_SHEATHED", "EMOTE_STATE_WORK_SHEATHED", "" };
        case EMOTE_STATE_POINT: return { "EMOTE_STATE_POINT", "EMOTE_STATE_POINT", "" };
        case EMOTE_STATE_NONE: return { "EMOTE_STATE_NONE", "EMOTE_STATE_NONE", "" };
        case EMOTE_ONESHOT_WOUND: return { "EMOTE_ONESHOT_WOUND", "EMOTE_ONESHOT_WOUND", "" };
        case EMOTE_ONESHOT_WOUND_CRITICAL: return { "EMOTE_ONESHOT_WOUND_CRITICAL", "EMOTE_ONESHOT_WOUND_CRITICAL", "" };
        case EMOTE_ONESHOT_ATTACK_UNARMED: return { "EMOTE_ONESHOT_ATTACK_UNARMED", "EMOTE_ONESHOT_ATTACK_UNARMED", "" };
        case EMOTE_ONESHOT_ATTACK1H: return { "EMOTE_ONESHOT_ATTACK1H", "EMOTE_ONESHOT_ATTACK1H", "" };
        case EMOTE_ONESHOT_ATTACK2HTIGHT: return { "EMOTE_ONESHOT_ATTACK2HTIGHT", "EMOTE_ONESHOT_ATTACK2HTIGHT", "" };
        case EMOTE_ONESHOT_ATTACK2H_LOOSE: return { "EMOTE_ONESHOT_ATTACK2H_LOOSE", "EMOTE_ONESHOT_ATTACK2H_LOOSE", "" };
        case EMOTE_ONESHOT_PARRY_UNARMED: return { "EMOTE_ONESHOT_PARRY_UNARMED", "EMOTE_ONESHOT_PARRY_UNARMED", "" };
        case EMOTE_ONESHOT_PARRY_SHIELD: return { "EMOTE_ONESHOT_PARRY_SHIELD", "EMOTE_ONESHOT_PARRY_SHIELD", "" };
        case EMOTE_ONESHOT_READY_UNARMED: return { "EMOTE_ONESHOT_READY_UNARMED", "EMOTE_ONESHOT_READY_UNARMED", "" };
        case EMOTE_ONESHOT_READY1H: return { "EMOTE_ONESHOT_READY1H", "EMOTE_ONESHOT_READY1H", "" };
        case EMOTE_ONESHOT_READY_BOW: return { "EMOTE_ONESHOT_READY_BOW", "EMOTE_ONESHOT_READY_BOW", "" };
        case EMOTE_ONESHOT_SPELL_PRECAST: return { "EMOTE_ONESHOT_SPELL_PRECAST", "EMOTE_ONESHOT_SPELL_PRECAST", "" };
        case EMOTE_ONESHOT_SPELL_CAST: return { "EMOTE_ONESHOT_SPELL_CAST", "EMOTE_ONESHOT_SPELL_CAST", "" };
        case EMOTE_ONESHOT_BATTLE_ROAR: return { "EMOTE_ONESHOT_BATTLE_ROAR", "EMOTE_ONESHOT_BATTLE_ROAR", "" };
        case EMOTE_ONESHOT_SPECIALATTACK1H: return { "EMOTE_ONESHOT_SPECIALATTACK1H", "EMOTE_ONESHOT_SPECIALATTACK1H", "" };
        case EMOTE_ONESHOT_KICK: return { "EMOTE_ONESHOT_KICK", "EMOTE_ONESHOT_KICK", "" };
        case EMOTE_ONESHOT_ATTACK_THROWN: return { "EMOTE_ONESHOT_ATTACK_THROWN", "EMOTE_ONESHOT_ATTACK_THROWN", "" };
        case EMOTE_STATE_STUN: return { "EMOTE_STATE_STUN", "EMOTE_STATE_STUN", "" };
        case EMOTE_STATE_DEAD: return { "EMOTE_STATE_DEAD", "EMOTE_STATE_DEAD", "" };
        case EMOTE_ONESHOT_SALUTE: return { "EMOTE_ONESHOT_SALUTE", "EMOTE_ONESHOT_SALUTE", "" };
        case EMOTE_STATE_KNEEL: return { "EMOTE_STATE_KNEEL", "EMOTE_STATE_KNEEL", "" };
        case EMOTE_STATE_USE_STANDING: return { "EMOTE_STATE_USE_STANDING", "EMOTE_STATE_USE_STANDING", "" };
        case EMOTE_ONESHOT_WAVE_NO_SHEATHE: return { "EMOTE_ONESHOT_WAVE_NO_SHEATHE", "EMOTE_ONESHOT_WAVE_NO_SHEATHE", "" };
        case EMOTE_ONESHOT_CHEER_NO_SHEATHE: return { "EMOTE_ONESHOT_CHEER_NO_SHEATHE", "EMOTE_ONESHOT_CHEER_NO_SHEATHE", "" };
        case EMOTE_ONESHOT_EAT_NO_SHEATHE: return { "EMOTE_ONESHOT_EAT_NO_SHEATHE", "EMOTE_ONESHOT_EAT_NO_SHEATHE", "" };
        case EMOTE_STATE_STUN_NO_SHEATHE: return { "EMOTE_STATE_STUN_NO_SHEATHE", "EMOTE_STATE_STUN_NO_SHEATHE", "" };
        case EMOTE_ONESHOT_DANCE: return { "EMOTE_ONESHOT_DANCE", "EMOTE_ONESHOT_DANCE", "" };
        case EMOTE_ONESHOT_SALUTE_NO_SHEATH: return { "EMOTE_ONESHOT_SALUTE_NO_SHEATH", "EMOTE_ONESHOT_SALUTE_NO_SHEATH", "" };
        case EMOTE_STATE_USE_STANDING_NO_SHEATHE: return { "EMOTE_STATE_USE_STANDING_NO_SHEATHE", "EMOTE_STATE_USE_STANDING_NO_SHEATHE", "" };
        case EMOTE_ONESHOT_LAUGH_NO_SHEATHE: return { "EMOTE_ONESHOT_LAUGH_NO_SHEATHE", "EMOTE_ONESHOT_LAUGH_NO_SHEATHE", "" };
        case EMOTE_STATE_WORK: return { "EMOTE_STATE_WORK", "EMOTE_STATE_WORK", "" };
        case EMOTE_STATE_SPELL_PRECAST: return { "EMOTE_STATE_SPELL_PRECAST", "EMOTE_STATE_SPELL_PRECAST", "" };
        case EMOTE_ONESHOT_READY_RIFLE: return { "EMOTE_ONESHOT_READY_RIFLE", "EMOTE_ONESHOT_READY_RIFLE", "" };
        case EMOTE_STATE_READY_RIFLE: return { "EMOTE_STATE_READY_RIFLE", "EMOTE_STATE_READY_RIFLE", "" };
        case EMOTE_STATE_WORK_MINING: return { "EMOTE_STATE_WORK_MINING", "EMOTE_STATE_WORK_MINING", "" };
        case EMOTE_STATE_WORK_CHOPWOOD: return { "EMOTE_STATE_WORK_CHOPWOOD", "EMOTE_STATE_WORK_CHOPWOOD", "" };
        case EMOTE_STATE_APPLAUD: return { "EMOTE_STATE_APPLAUD", "EMOTE_STATE_APPLAUD", "" };
        case EMOTE_ONESHOT_LIFTOFF: return { "EMOTE_ONESHOT_LIFTOFF", "EMOTE_ONESHOT_LIFTOFF", "" };
        case EMOTE_ONESHOT_YES: return { "EMOTE_ONESHOT_YES", "EMOTE_ONESHOT_YES", "" };
        case EMOTE_ONESHOT_NO: return { "EMOTE_ONESHOT_NO", "EMOTE_ONESHOT_NO", "" };
        case EMOTE_ONESHOT_TRAIN: return { "EMOTE_ONESHOT_TRAIN", "EMOTE_ONESHOT_TRAIN", "" };
        case EMOTE_ONESHOT_LAND: return { "EMOTE_ONESHOT_LAND", "EMOTE_ONESHOT_LAND", "" };
        case EMOTE_STATE_AT_EASE: return { "EMOTE_STATE_AT_EASE", "EMOTE_STATE_AT_EASE", "" };
        case EMOTE_STATE_READY1H: return { "EMOTE_STATE_READY1H", "EMOTE_STATE_READY1H", "" };
        case EMOTE_STATE_SPELL_KNEEL_START: return { "EMOTE_STATE_SPELL_KNEEL_START", "EMOTE_STATE_SPELL_KNEEL_START", "" };
        case EMOTE_STATE_SUBMERGED: return { "EMOTE_STATE_SUBMERGED", "EMOTE_STATE_SUBMERGED", "" };
        case EMOTE_ONESHOT_SUBMERGE: return { "EMOTE_ONESHOT_SUBMERGE", "EMOTE_ONESHOT_SUBMERGE", "" };
        case EMOTE_STATE_READY2H: return { "EMOTE_STATE_READY2H", "EMOTE_STATE_READY2H", "" };
        case EMOTE_STATE_READY_BOW: return { "EMOTE_STATE_READY_BOW", "EMOTE_STATE_READY_BOW", "" };
        case EMOTE_ONESHOT_MOUNT_SPECIAL: return { "EMOTE_ONESHOT_MOUNT_SPECIAL", "EMOTE_ONESHOT_MOUNT_SPECIAL", "" };
        case EMOTE_STATE_TALK: return { "EMOTE_STATE_TALK", "EMOTE_STATE_TALK", "" };
        case EMOTE_STATE_FISHING: return { "EMOTE_STATE_FISHING", "EMOTE_STATE_FISHING", "" };
        case EMOTE_ONESHOT_FISHING: return { "EMOTE_ONESHOT_FISHING", "EMOTE_ONESHOT_FISHING", "" };
        case EMOTE_ONESHOT_LOOT: return { "EMOTE_ONESHOT_LOOT", "EMOTE_ONESHOT_LOOT", "" };
        case EMOTE_STATE_WHIRLWIND: return { "EMOTE_STATE_WHIRLWIND", "EMOTE_STATE_WHIRLWIND", "" };
        case EMOTE_STATE_DROWNED: return { "EMOTE_STATE_DROWNED", "EMOTE_STATE_DROWNED", "" };
        case EMOTE_STATE_HOLD_BOW: return { "EMOTE_STATE_HOLD_BOW", "EMOTE_STATE_HOLD_BOW", "" };
        case EMOTE_STATE_HOLD_RIFLE: return { "EMOTE_STATE_HOLD_RIFLE", "EMOTE_STATE_HOLD_RIFLE", "" };
        case EMOTE_STATE_HOLD_THROWN: return { "EMOTE_STATE_HOLD_THROWN", "EMOTE_STATE_HOLD_THROWN", "" };
        case EMOTE_ONESHOT_DROWN: return { "EMOTE_ONESHOT_DROWN", "EMOTE_ONESHOT_DROWN", "" };
        case EMOTE_ONESHOT_STOMP: return { "EMOTE_ONESHOT_STOMP", "EMOTE_ONESHOT_STOMP", "" };
        case EMOTE_ONESHOT_ATTACK_OFF: return { "EMOTE_ONESHOT_ATTACK_OFF", "EMOTE_ONESHOT_ATTACK_OFF", "" };
        case EMOTE_ONESHOT_ATTACK_OFF_PIERCE: return { "EMOTE_ONESHOT_ATTACK_OFF_PIERCE", "EMOTE_ONESHOT_ATTACK_OFF_PIERCE", "" };
        case EMOTE_STATE_ROAR: return { "EMOTE_STATE_ROAR", "EMOTE_STATE_ROAR", "" };
        case EMOTE_STATE_LAUGH: return { "EMOTE_STATE_LAUGH", "EMOTE_STATE_LAUGH", "" };
        case EMOTE_ONESHOT_CREATURE_SPECIAL: return { "EMOTE_ONESHOT_CREATURE_SPECIAL", "EMOTE_ONESHOT_CREATURE_SPECIAL", "" };
        case EMOTE_ONESHOT_JUMPLANDRUN: return { "EMOTE_ONESHOT_JUMPLANDRUN", "EMOTE_ONESHOT_JUMPLANDRUN", "" };
        case EMOTE_ONESHOT_JUMPEND: return { "EMOTE_ONESHOT_JUMPEND", "EMOTE_ONESHOT_JUMPEND", "" };
        case EMOTE_ONESHOT_TALK_NO_SHEATHE: return { "EMOTE_ONESHOT_TALK_NO_SHEATHE", "EMOTE_ONESHOT_TALK_NO_SHEATHE", "" };
        case EMOTE_ONESHOT_POINT_NO_SHEATHE: return { "EMOTE_ONESHOT_POINT_NO_SHEATHE", "EMOTE_ONESHOT_POINT_NO_SHEATHE", "" };
        case EMOTE_STATE_CANNIBALIZE: return { "EMOTE_STATE_CANNIBALIZE", "EMOTE_STATE_CANNIBALIZE", "" };
        case EMOTE_ONESHOT_JUMPSTART: return { "EMOTE_ONESHOT_JUMPSTART", "EMOTE_ONESHOT_JUMPSTART", "" };
        case EMOTE_STATE_DANCESPECIAL: return { "EMOTE_STATE_DANCESPECIAL", "EMOTE_STATE_DANCESPECIAL", "" };
        case EMOTE_ONESHOT_DANCESPECIAL: return { "EMOTE_ONESHOT_DANCESPECIAL", "EMOTE_ONESHOT_DANCESPECIAL", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_01: return { "EMOTE_ONESHOT_CUSTOM_SPELL_01", "EMOTE_ONESHOT_CUSTOM_SPELL_01", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_02: return { "EMOTE_ONESHOT_CUSTOM_SPELL_02", "EMOTE_ONESHOT_CUSTOM_SPELL_02", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_03: return { "EMOTE_ONESHOT_CUSTOM_SPELL_03", "EMOTE_ONESHOT_CUSTOM_SPELL_03", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_04: return { "EMOTE_ONESHOT_CUSTOM_SPELL_04", "EMOTE_ONESHOT_CUSTOM_SPELL_04", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_05: return { "EMOTE_ONESHOT_CUSTOM_SPELL_05", "EMOTE_ONESHOT_CUSTOM_SPELL_05", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_06: return { "EMOTE_ONESHOT_CUSTOM_SPELL_06", "EMOTE_ONESHOT_CUSTOM_SPELL_06", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_07: return { "EMOTE_ONESHOT_CUSTOM_SPELL_07", "EMOTE_ONESHOT_CUSTOM_SPELL_07", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_08: return { "EMOTE_ONESHOT_CUSTOM_SPELL_08", "EMOTE_ONESHOT_CUSTOM_SPELL_08", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_09: return { "EMOTE_ONESHOT_CUSTOM_SPELL_09", "EMOTE_ONESHOT_CUSTOM_SPELL_09", "" };
        case EMOTE_ONESHOT_CUSTOM_SPELL_10: return { "EMOTE_ONESHOT_CUSTOM_SPELL_10", "EMOTE_ONESHOT_CUSTOM_SPELL_10", "" };
        case EMOTE_STATE_EXCLAIM: return { "EMOTE_STATE_EXCLAIM", "EMOTE_STATE_EXCLAIM", "" };
        case EMOTE_STATE_DANCE_CUSTOM: return { "EMOTE_STATE_DANCE_CUSTOM", "EMOTE_STATE_DANCE_CUSTOM", "" };
        case EMOTE_STATE_SIT_CHAIR_MED: return { "EMOTE_STATE_SIT_CHAIR_MED", "EMOTE_STATE_SIT_CHAIR_MED", "" };
        case EMOTE_STATE_CUSTOM_SPELL_01: return { "EMOTE_STATE_CUSTOM_SPELL_01", "EMOTE_STATE_CUSTOM_SPELL_01", "" };
        case EMOTE_STATE_CUSTOM_SPELL_02: return { "EMOTE_STATE_CUSTOM_SPELL_02", "EMOTE_STATE_CUSTOM_SPELL_02", "" };
        case EMOTE_STATE_EAT: return { "EMOTE_STATE_EAT", "EMOTE_STATE_EAT", "" };
        case EMOTE_STATE_CUSTOM_SPELL_04: return { "EMOTE_STATE_CUSTOM_SPELL_04", "EMOTE_STATE_CUSTOM_SPELL_04", "" };
        case EMOTE_STATE_CUSTOM_SPELL_03: return { "EMOTE_STATE_CUSTOM_SPELL_03", "EMOTE_STATE_CUSTOM_SPELL_03", "" };
        case EMOTE_STATE_CUSTOM_SPELL_05: return { "EMOTE_STATE_CUSTOM_SPELL_05", "EMOTE_STATE_CUSTOM_SPELL_05", "" };
        case EMOTE_STATE_SPELLEFFECT_HOLD: return { "EMOTE_STATE_SPELLEFFECT_HOLD", "EMOTE_STATE_SPELLEFFECT_HOLD", "" };
        case EMOTE_STATE_EAT_NO_SHEATHE: return { "EMOTE_STATE_EAT_NO_SHEATHE", "EMOTE_STATE_EAT_NO_SHEATHE", "" };
        case EMOTE_STATE_MOUNT: return { "EMOTE_STATE_MOUNT", "EMOTE_STATE_MOUNT", "" };
        case EMOTE_STATE_READY2HL: return { "EMOTE_STATE_READY2HL", "EMOTE_STATE_READY2HL", "" };
        case EMOTE_STATE_SIT_CHAIR_HIGH: return { "EMOTE_STATE_SIT_CHAIR_HIGH", "EMOTE_STATE_SIT_CHAIR_HIGH", "" };
        case EMOTE_STATE_FALL: return { "EMOTE_STATE_FALL", "EMOTE_STATE_FALL", "" };
        case EMOTE_STATE_LOOT: return { "EMOTE_STATE_LOOT", "EMOTE_STATE_LOOT", "" };
        case EMOTE_STATE_SUBMERGED_NEW: return { "EMOTE_STATE_SUBMERGED_NEW", "EMOTE_STATE_SUBMERGED_NEW", "" };
        case EMOTE_ONESHOT_COWER: return { "EMOTE_ONESHOT_COWER", "EMOTE_ONESHOT_COWER", "" };
        case EMOTE_STATE_COWER: return { "EMOTE_STATE_COWER", "EMOTE_STATE_COWER", "" };
        case EMOTE_ONESHOT_USE_STANDING: return { "EMOTE_ONESHOT_USE_STANDING", "EMOTE_ONESHOT_USE_STANDING", "" };
        case EMOTE_STATE_STEALTH_STAND: return { "EMOTE_STATE_STEALTH_STAND", "EMOTE_STATE_STEALTH_STAND", "" };
        case EMOTE_ONESHOT_OMNICAST_GHOUL: return { "EMOTE_ONESHOT_OMNICAST_GHOUL", "EMOTE_ONESHOT_OMNICAST_GHOUL", "" };
        case EMOTE_ONESHOT_ATTACK_BOW: return { "EMOTE_ONESHOT_ATTACK_BOW", "EMOTE_ONESHOT_ATTACK_BOW", "" };
        case EMOTE_ONESHOT_ATTACK_RIFLE: return { "EMOTE_ONESHOT_ATTACK_RIFLE", "EMOTE_ONESHOT_ATTACK_RIFLE", "" };
        case EMOTE_STATE_SWIM_IDLE: return { "EMOTE_STATE_SWIM_IDLE", "EMOTE_STATE_SWIM_IDLE", "" };
        case EMOTE_STATE_ATTACK_UNARMED: return { "EMOTE_STATE_ATTACK_UNARMED", "EMOTE_STATE_ATTACK_UNARMED", "" };
        case EMOTE_ONESHOT_SPELL_CAST_W_SOUND: return { "EMOTE_ONESHOT_SPELL_CAST_W_SOUND", "EMOTE_ONESHOT_SPELL_CAST_W_SOUND", "" };
        case EMOTE_ONESHOT_DODGE: return { "EMOTE_ONESHOT_DODGE", "EMOTE_ONESHOT_DODGE", "" };
        case EMOTE_ONESHOT_PARRY1H: return { "EMOTE_ONESHOT_PARRY1H", "EMOTE_ONESHOT_PARRY1H", "" };
        case EMOTE_ONESHOT_PARRY2H: return { "EMOTE_ONESHOT_PARRY2H", "EMOTE_ONESHOT_PARRY2H", "" };
        case EMOTE_ONESHOT_PARRY2HL: return { "EMOTE_ONESHOT_PARRY2HL", "EMOTE_ONESHOT_PARRY2HL", "" };
        case EMOTE_STATE_FLYFALL: return { "EMOTE_STATE_FLYFALL", "EMOTE_STATE_FLYFALL", "" };
        case EMOTE_ONESHOT_FLYDEATH: return { "EMOTE_ONESHOT_FLYDEATH", "EMOTE_ONESHOT_FLYDEATH", "" };
        case EMOTE_STATE_FLY_FALL: return { "EMOTE_STATE_FLY_FALL", "EMOTE_STATE_FLY_FALL", "" };
        case EMOTE_ONESHOT_FLY_SIT_GROUND_DOWN: return { "EMOTE_ONESHOT_FLY_SIT_GROUND_DOWN", "EMOTE_ONESHOT_FLY_SIT_GROUND_DOWN", "" };
        case EMOTE_ONESHOT_FLY_SIT_GROUND_UP: return { "EMOTE_ONESHOT_FLY_SIT_GROUND_UP", "EMOTE_ONESHOT_FLY_SIT_GROUND_UP", "" };
        case EMOTE_ONESHOT_EMERGE: return { "EMOTE_ONESHOT_EMERGE", "EMOTE_ONESHOT_EMERGE", "" };
        case EMOTE_ONESHOT_DRAGON_SPIT: return { "EMOTE_ONESHOT_DRAGON_SPIT", "EMOTE_ONESHOT_DRAGON_SPIT", "" };
        case EMOTE_STATE_SPECIAL_UNARMED: return { "EMOTE_STATE_SPECIAL_UNARMED", "EMOTE_STATE_SPECIAL_UNARMED", "" };
        case EMOTE_ONESHOT_FLYGRAB: return { "EMOTE_ONESHOT_FLYGRAB", "EMOTE_ONESHOT_FLYGRAB", "" };
        case EMOTE_STATE_FLYGRABCLOSED: return { "EMOTE_STATE_FLYGRABCLOSED", "EMOTE_STATE_FLYGRABCLOSED", "" };
        case EMOTE_ONESHOT_FLYGRABTHROWN: return { "EMOTE_ONESHOT_FLYGRABTHROWN", "EMOTE_ONESHOT_FLYGRABTHROWN", "" };
        case EMOTE_STATE_FLY_SIT_GROUND: return { "EMOTE_STATE_FLY_SIT_GROUND", "EMOTE_STATE_FLY_SIT_GROUND", "" };
        case EMOTE_STATE_WALK_BACKWARDS: return { "EMOTE_STATE_WALK_BACKWARDS", "EMOTE_STATE_WALK_BACKWARDS", "" };
        case EMOTE_ONESHOT_FLYTALK: return { "EMOTE_ONESHOT_FLYTALK", "EMOTE_ONESHOT_FLYTALK", "" };
        case EMOTE_ONESHOT_FLYATTACK1H: return { "EMOTE_ONESHOT_FLYATTACK1H", "EMOTE_ONESHOT_FLYATTACK1H", "" };
        case EMOTE_STATE_CUSTOM_SPELL_08: return { "EMOTE_STATE_CUSTOM_SPELL_08", "EMOTE_STATE_CUSTOM_SPELL_08", "" };
        case EMOTE_ONESHOT_FLY_DRAGON_SPIT: return { "EMOTE_ONESHOT_FLY_DRAGON_SPIT", "EMOTE_ONESHOT_FLY_DRAGON_SPIT", "" };
        case EMOTE_STATE_SIT_CHAIR_LOW: return { "EMOTE_STATE_SIT_CHAIR_LOW", "EMOTE_STATE_SIT_CHAIR_LOW", "" };
        case EMOTE_ONESHOT_STUN: return { "EMOTE_ONESHOT_STUN", "EMOTE_ONESHOT_STUN", "" };
        case EMOTE_ONESHOT_SPELL_CAST_OMNI: return { "EMOTE_ONESHOT_SPELL_CAST_OMNI", "EMOTE_ONESHOT_SPELL_CAST_OMNI", "" };
        case EMOTE_STATE_READY_THROWN: return { "EMOTE_STATE_READY_THROWN", "EMOTE_STATE_READY_THROWN", "" };
        case EMOTE_ONESHOT_WORK_CHOPWOOD: return { "EMOTE_ONESHOT_WORK_CHOPWOOD", "EMOTE_ONESHOT_WORK_CHOPWOOD", "" };
        case EMOTE_ONESHOT_WORK_MINING: return { "EMOTE_ONESHOT_WORK_MINING", "EMOTE_ONESHOT_WORK_MINING", "" };
        case EMOTE_STATE_SPELL_CHANNEL_OMNI: return { "EMOTE_STATE_SPELL_CHANNEL_OMNI", "EMOTE_STATE_SPELL_CHANNEL_OMNI", "" };
        case EMOTE_STATE_SPELL_CHANNEL_DIRECTED: return { "EMOTE_STATE_SPELL_CHANNEL_DIRECTED", "EMOTE_STATE_SPELL_CHANNEL_DIRECTED", "" };
        case EMOTE_STAND_STATE_NONE: return { "EMOTE_STAND_STATE_NONE", "EMOTE_STAND_STATE_NONE", "" };
        case EMOTE_STATE_READYJOUST: return { "EMOTE_STATE_READYJOUST", "EMOTE_STATE_READYJOUST", "" };
        case EMOTE_STATE_STRANGULATE: return { "EMOTE_STATE_STRANGULATE", "EMOTE_STATE_STRANGULATE", "" };
        case EMOTE_STATE_READY_SPELL_OMNI: return { "EMOTE_STATE_READY_SPELL_OMNI", "EMOTE_STATE_READY_SPELL_OMNI", "" };
        case EMOTE_STATE_HOLD_JOUST: return { "EMOTE_STATE_HOLD_JOUST", "EMOTE_STATE_HOLD_JOUST", "" };
        case EMOTE_ONESHOT_CRY_JAINA: return { "EMOTE_ONESHOT_CRY_JAINA", "EMOTE_ONESHOT_CRY_JAINA", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Emote>::Count() { return 174; }

template <>
AC_API_EXPORT Emote EnumUtils<Emote>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return EMOTE_ONESHOT_TALK;
        case 1: return EMOTE_ONESHOT_BOW;
        case 2: return EMOTE_ONESHOT_WAVE;
        case 3: return EMOTE_ONESHOT_CHEER;
        case 4: return EMOTE_ONESHOT_EXCLAMATION;
        case 5: return EMOTE_ONESHOT_QUESTION;
        case 6: return EMOTE_ONESHOT_EAT;
        case 7: return EMOTE_STATE_DANCE;
        case 8: return EMOTE_ONESHOT_LAUGH;
        case 9: return EMOTE_STATE_SLEEP;
        case 10: return EMOTE_STATE_SIT;
        case 11: return EMOTE_ONESHOT_RUDE;
        case 12: return EMOTE_ONESHOT_ROAR;
        case 13: return EMOTE_ONESHOT_KNEEL;
        case 14: return EMOTE_ONESHOT_KISS;
        case 15: return EMOTE_ONESHOT_CRY;
        case 16: return EMOTE_ONESHOT_CHICKEN;
        case 17: return EMOTE_ONESHOT_BEG;
        case 18: return EMOTE_ONESHOT_APPLAUD;
        case 19: return EMOTE_ONESHOT_SHOUT;
        case 20: return EMOTE_ONESHOT_FLEX;
        case 21: return EMOTE_ONESHOT_SHY;
        case 22: return EMOTE_ONESHOT_POINT;
        case 23: return EMOTE_STATE_STAND;
        case 24: return EMOTE_STATE_READY_UNARMED;
        case 25: return EMOTE_STATE_WORK_SHEATHED;
        case 26: return EMOTE_STATE_POINT;
        case 27: return EMOTE_STATE_NONE;
        case 28: return EMOTE_ONESHOT_WOUND;
        case 29: return EMOTE_ONESHOT_WOUND_CRITICAL;
        case 30: return EMOTE_ONESHOT_ATTACK_UNARMED;
        case 31: return EMOTE_ONESHOT_ATTACK1H;
        case 32: return EMOTE_ONESHOT_ATTACK2HTIGHT;
        case 33: return EMOTE_ONESHOT_ATTACK2H_LOOSE;
        case 34: return EMOTE_ONESHOT_PARRY_UNARMED;
        case 35: return EMOTE_ONESHOT_PARRY_SHIELD;
        case 36: return EMOTE_ONESHOT_READY_UNARMED;
        case 37: return EMOTE_ONESHOT_READY1H;
        case 38: return EMOTE_ONESHOT_READY_BOW;
        case 39: return EMOTE_ONESHOT_SPELL_PRECAST;
        case 40: return EMOTE_ONESHOT_SPELL_CAST;
        case 41: return EMOTE_ONESHOT_BATTLE_ROAR;
        case 42: return EMOTE_ONESHOT_SPECIALATTACK1H;
        case 43: return EMOTE_ONESHOT_KICK;
        case 44: return EMOTE_ONESHOT_ATTACK_THROWN;
        case 45: return EMOTE_STATE_STUN;
        case 46: return EMOTE_STATE_DEAD;
        case 47: return EMOTE_ONESHOT_SALUTE;
        case 48: return EMOTE_STATE_KNEEL;
        case 49: return EMOTE_STATE_USE_STANDING;
        case 50: return EMOTE_ONESHOT_WAVE_NO_SHEATHE;
        case 51: return EMOTE_ONESHOT_CHEER_NO_SHEATHE;
        case 52: return EMOTE_ONESHOT_EAT_NO_SHEATHE;
        case 53: return EMOTE_STATE_STUN_NO_SHEATHE;
        case 54: return EMOTE_ONESHOT_DANCE;
        case 55: return EMOTE_ONESHOT_SALUTE_NO_SHEATH;
        case 56: return EMOTE_STATE_USE_STANDING_NO_SHEATHE;
        case 57: return EMOTE_ONESHOT_LAUGH_NO_SHEATHE;
        case 58: return EMOTE_STATE_WORK;
        case 59: return EMOTE_STATE_SPELL_PRECAST;
        case 60: return EMOTE_ONESHOT_READY_RIFLE;
        case 61: return EMOTE_STATE_READY_RIFLE;
        case 62: return EMOTE_STATE_WORK_MINING;
        case 63: return EMOTE_STATE_WORK_CHOPWOOD;
        case 64: return EMOTE_STATE_APPLAUD;
        case 65: return EMOTE_ONESHOT_LIFTOFF;
        case 66: return EMOTE_ONESHOT_YES;
        case 67: return EMOTE_ONESHOT_NO;
        case 68: return EMOTE_ONESHOT_TRAIN;
        case 69: return EMOTE_ONESHOT_LAND;
        case 70: return EMOTE_STATE_AT_EASE;
        case 71: return EMOTE_STATE_READY1H;
        case 72: return EMOTE_STATE_SPELL_KNEEL_START;
        case 73: return EMOTE_STATE_SUBMERGED;
        case 74: return EMOTE_ONESHOT_SUBMERGE;
        case 75: return EMOTE_STATE_READY2H;
        case 76: return EMOTE_STATE_READY_BOW;
        case 77: return EMOTE_ONESHOT_MOUNT_SPECIAL;
        case 78: return EMOTE_STATE_TALK;
        case 79: return EMOTE_STATE_FISHING;
        case 80: return EMOTE_ONESHOT_FISHING;
        case 81: return EMOTE_ONESHOT_LOOT;
        case 82: return EMOTE_STATE_WHIRLWIND;
        case 83: return EMOTE_STATE_DROWNED;
        case 84: return EMOTE_STATE_HOLD_BOW;
        case 85: return EMOTE_STATE_HOLD_RIFLE;
        case 86: return EMOTE_STATE_HOLD_THROWN;
        case 87: return EMOTE_ONESHOT_DROWN;
        case 88: return EMOTE_ONESHOT_STOMP;
        case 89: return EMOTE_ONESHOT_ATTACK_OFF;
        case 90: return EMOTE_ONESHOT_ATTACK_OFF_PIERCE;
        case 91: return EMOTE_STATE_ROAR;
        case 92: return EMOTE_STATE_LAUGH;
        case 93: return EMOTE_ONESHOT_CREATURE_SPECIAL;
        case 94: return EMOTE_ONESHOT_JUMPLANDRUN;
        case 95: return EMOTE_ONESHOT_JUMPEND;
        case 96: return EMOTE_ONESHOT_TALK_NO_SHEATHE;
        case 97: return EMOTE_ONESHOT_POINT_NO_SHEATHE;
        case 98: return EMOTE_STATE_CANNIBALIZE;
        case 99: return EMOTE_ONESHOT_JUMPSTART;
        case 100: return EMOTE_STATE_DANCESPECIAL;
        case 101: return EMOTE_ONESHOT_DANCESPECIAL;
        case 102: return EMOTE_ONESHOT_CUSTOM_SPELL_01;
        case 103: return EMOTE_ONESHOT_CUSTOM_SPELL_02;
        case 104: return EMOTE_ONESHOT_CUSTOM_SPELL_03;
        case 105: return EMOTE_ONESHOT_CUSTOM_SPELL_04;
        case 106: return EMOTE_ONESHOT_CUSTOM_SPELL_05;
        case 107: return EMOTE_ONESHOT_CUSTOM_SPELL_06;
        case 108: return EMOTE_ONESHOT_CUSTOM_SPELL_07;
        case 109: return EMOTE_ONESHOT_CUSTOM_SPELL_08;
        case 110: return EMOTE_ONESHOT_CUSTOM_SPELL_09;
        case 111: return EMOTE_ONESHOT_CUSTOM_SPELL_10;
        case 112: return EMOTE_STATE_EXCLAIM;
        case 113: return EMOTE_STATE_DANCE_CUSTOM;
        case 114: return EMOTE_STATE_SIT_CHAIR_MED;
        case 115: return EMOTE_STATE_CUSTOM_SPELL_01;
        case 116: return EMOTE_STATE_CUSTOM_SPELL_02;
        case 117: return EMOTE_STATE_EAT;
        case 118: return EMOTE_STATE_CUSTOM_SPELL_04;
        case 119: return EMOTE_STATE_CUSTOM_SPELL_03;
        case 120: return EMOTE_STATE_CUSTOM_SPELL_05;
        case 121: return EMOTE_STATE_SPELLEFFECT_HOLD;
        case 122: return EMOTE_STATE_EAT_NO_SHEATHE;
        case 123: return EMOTE_STATE_MOUNT;
        case 124: return EMOTE_STATE_READY2HL;
        case 125: return EMOTE_STATE_SIT_CHAIR_HIGH;
        case 126: return EMOTE_STATE_FALL;
        case 127: return EMOTE_STATE_LOOT;
        case 128: return EMOTE_STATE_SUBMERGED_NEW;
        case 129: return EMOTE_ONESHOT_COWER;
        case 130: return EMOTE_STATE_COWER;
        case 131: return EMOTE_ONESHOT_USE_STANDING;
        case 132: return EMOTE_STATE_STEALTH_STAND;
        case 133: return EMOTE_ONESHOT_OMNICAST_GHOUL;
        case 134: return EMOTE_ONESHOT_ATTACK_BOW;
        case 135: return EMOTE_ONESHOT_ATTACK_RIFLE;
        case 136: return EMOTE_STATE_SWIM_IDLE;
        case 137: return EMOTE_STATE_ATTACK_UNARMED;
        case 138: return EMOTE_ONESHOT_SPELL_CAST_W_SOUND;
        case 139: return EMOTE_ONESHOT_DODGE;
        case 140: return EMOTE_ONESHOT_PARRY1H;
        case 141: return EMOTE_ONESHOT_PARRY2H;
        case 142: return EMOTE_ONESHOT_PARRY2HL;
        case 143: return EMOTE_STATE_FLYFALL;
        case 144: return EMOTE_ONESHOT_FLYDEATH;
        case 145: return EMOTE_STATE_FLY_FALL;
        case 146: return EMOTE_ONESHOT_FLY_SIT_GROUND_DOWN;
        case 147: return EMOTE_ONESHOT_FLY_SIT_GROUND_UP;
        case 148: return EMOTE_ONESHOT_EMERGE;
        case 149: return EMOTE_ONESHOT_DRAGON_SPIT;
        case 150: return EMOTE_STATE_SPECIAL_UNARMED;
        case 151: return EMOTE_ONESHOT_FLYGRAB;
        case 152: return EMOTE_STATE_FLYGRABCLOSED;
        case 153: return EMOTE_ONESHOT_FLYGRABTHROWN;
        case 154: return EMOTE_STATE_FLY_SIT_GROUND;
        case 155: return EMOTE_STATE_WALK_BACKWARDS;
        case 156: return EMOTE_ONESHOT_FLYTALK;
        case 157: return EMOTE_ONESHOT_FLYATTACK1H;
        case 158: return EMOTE_STATE_CUSTOM_SPELL_08;
        case 159: return EMOTE_ONESHOT_FLY_DRAGON_SPIT;
        case 160: return EMOTE_STATE_SIT_CHAIR_LOW;
        case 161: return EMOTE_ONESHOT_STUN;
        case 162: return EMOTE_ONESHOT_SPELL_CAST_OMNI;
        case 163: return EMOTE_STATE_READY_THROWN;
        case 164: return EMOTE_ONESHOT_WORK_CHOPWOOD;
        case 165: return EMOTE_ONESHOT_WORK_MINING;
        case 166: return EMOTE_STATE_SPELL_CHANNEL_OMNI;
        case 167: return EMOTE_STATE_SPELL_CHANNEL_DIRECTED;
        case 168: return EMOTE_STAND_STATE_NONE;
        case 169: return EMOTE_STATE_READYJOUST;
        case 170: return EMOTE_STATE_STRANGULATE;
        case 171: return EMOTE_STATE_READY_SPELL_OMNI;
        case 172: return EMOTE_STATE_HOLD_JOUST;
        case 173: return EMOTE_ONESHOT_CRY_JAINA;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<Emote>::ToIndex(Emote value)
{
    switch (value)
    {
        case EMOTE_ONESHOT_TALK: return 0;
        case EMOTE_ONESHOT_BOW: return 1;
        case EMOTE_ONESHOT_WAVE: return 2;
        case EMOTE_ONESHOT_CHEER: return 3;
        case EMOTE_ONESHOT_EXCLAMATION: return 4;
        case EMOTE_ONESHOT_QUESTION: return 5;
        case EMOTE_ONESHOT_EAT: return 6;
        case EMOTE_STATE_DANCE: return 7;
        case EMOTE_ONESHOT_LAUGH: return 8;
        case EMOTE_STATE_SLEEP: return 9;
        case EMOTE_STATE_SIT: return 10;
        case EMOTE_ONESHOT_RUDE: return 11;
        case EMOTE_ONESHOT_ROAR: return 12;
        case EMOTE_ONESHOT_KNEEL: return 13;
        case EMOTE_ONESHOT_KISS: return 14;
        case EMOTE_ONESHOT_CRY: return 15;
        case EMOTE_ONESHOT_CHICKEN: return 16;
        case EMOTE_ONESHOT_BEG: return 17;
        case EMOTE_ONESHOT_APPLAUD: return 18;
        case EMOTE_ONESHOT_SHOUT: return 19;
        case EMOTE_ONESHOT_FLEX: return 20;
        case EMOTE_ONESHOT_SHY: return 21;
        case EMOTE_ONESHOT_POINT: return 22;
        case EMOTE_STATE_STAND: return 23;
        case EMOTE_STATE_READY_UNARMED: return 24;
        case EMOTE_STATE_WORK_SHEATHED: return 25;
        case EMOTE_STATE_POINT: return 26;
        case EMOTE_STATE_NONE: return 27;
        case EMOTE_ONESHOT_WOUND: return 28;
        case EMOTE_ONESHOT_WOUND_CRITICAL: return 29;
        case EMOTE_ONESHOT_ATTACK_UNARMED: return 30;
        case EMOTE_ONESHOT_ATTACK1H: return 31;
        case EMOTE_ONESHOT_ATTACK2HTIGHT: return 32;
        case EMOTE_ONESHOT_ATTACK2H_LOOSE: return 33;
        case EMOTE_ONESHOT_PARRY_UNARMED: return 34;
        case EMOTE_ONESHOT_PARRY_SHIELD: return 35;
        case EMOTE_ONESHOT_READY_UNARMED: return 36;
        case EMOTE_ONESHOT_READY1H: return 37;
        case EMOTE_ONESHOT_READY_BOW: return 38;
        case EMOTE_ONESHOT_SPELL_PRECAST: return 39;
        case EMOTE_ONESHOT_SPELL_CAST: return 40;
        case EMOTE_ONESHOT_BATTLE_ROAR: return 41;
        case EMOTE_ONESHOT_SPECIALATTACK1H: return 42;
        case EMOTE_ONESHOT_KICK: return 43;
        case EMOTE_ONESHOT_ATTACK_THROWN: return 44;
        case EMOTE_STATE_STUN: return 45;
        case EMOTE_STATE_DEAD: return 46;
        case EMOTE_ONESHOT_SALUTE: return 47;
        case EMOTE_STATE_KNEEL: return 48;
        case EMOTE_STATE_USE_STANDING: return 49;
        case EMOTE_ONESHOT_WAVE_NO_SHEATHE: return 50;
        case EMOTE_ONESHOT_CHEER_NO_SHEATHE: return 51;
        case EMOTE_ONESHOT_EAT_NO_SHEATHE: return 52;
        case EMOTE_STATE_STUN_NO_SHEATHE: return 53;
        case EMOTE_ONESHOT_DANCE: return 54;
        case EMOTE_ONESHOT_SALUTE_NO_SHEATH: return 55;
        case EMOTE_STATE_USE_STANDING_NO_SHEATHE: return 56;
        case EMOTE_ONESHOT_LAUGH_NO_SHEATHE: return 57;
        case EMOTE_STATE_WORK: return 58;
        case EMOTE_STATE_SPELL_PRECAST: return 59;
        case EMOTE_ONESHOT_READY_RIFLE: return 60;
        case EMOTE_STATE_READY_RIFLE: return 61;
        case EMOTE_STATE_WORK_MINING: return 62;
        case EMOTE_STATE_WORK_CHOPWOOD: return 63;
        case EMOTE_STATE_APPLAUD: return 64;
        case EMOTE_ONESHOT_LIFTOFF: return 65;
        case EMOTE_ONESHOT_YES: return 66;
        case EMOTE_ONESHOT_NO: return 67;
        case EMOTE_ONESHOT_TRAIN: return 68;
        case EMOTE_ONESHOT_LAND: return 69;
        case EMOTE_STATE_AT_EASE: return 70;
        case EMOTE_STATE_READY1H: return 71;
        case EMOTE_STATE_SPELL_KNEEL_START: return 72;
        case EMOTE_STATE_SUBMERGED: return 73;
        case EMOTE_ONESHOT_SUBMERGE: return 74;
        case EMOTE_STATE_READY2H: return 75;
        case EMOTE_STATE_READY_BOW: return 76;
        case EMOTE_ONESHOT_MOUNT_SPECIAL: return 77;
        case EMOTE_STATE_TALK: return 78;
        case EMOTE_STATE_FISHING: return 79;
        case EMOTE_ONESHOT_FISHING: return 80;
        case EMOTE_ONESHOT_LOOT: return 81;
        case EMOTE_STATE_WHIRLWIND: return 82;
        case EMOTE_STATE_DROWNED: return 83;
        case EMOTE_STATE_HOLD_BOW: return 84;
        case EMOTE_STATE_HOLD_RIFLE: return 85;
        case EMOTE_STATE_HOLD_THROWN: return 86;
        case EMOTE_ONESHOT_DROWN: return 87;
        case EMOTE_ONESHOT_STOMP: return 88;
        case EMOTE_ONESHOT_ATTACK_OFF: return 89;
        case EMOTE_ONESHOT_ATTACK_OFF_PIERCE: return 90;
        case EMOTE_STATE_ROAR: return 91;
        case EMOTE_STATE_LAUGH: return 92;
        case EMOTE_ONESHOT_CREATURE_SPECIAL: return 93;
        case EMOTE_ONESHOT_JUMPLANDRUN: return 94;
        case EMOTE_ONESHOT_JUMPEND: return 95;
        case EMOTE_ONESHOT_TALK_NO_SHEATHE: return 96;
        case EMOTE_ONESHOT_POINT_NO_SHEATHE: return 97;
        case EMOTE_STATE_CANNIBALIZE: return 98;
        case EMOTE_ONESHOT_JUMPSTART: return 99;
        case EMOTE_STATE_DANCESPECIAL: return 100;
        case EMOTE_ONESHOT_DANCESPECIAL: return 101;
        case EMOTE_ONESHOT_CUSTOM_SPELL_01: return 102;
        case EMOTE_ONESHOT_CUSTOM_SPELL_02: return 103;
        case EMOTE_ONESHOT_CUSTOM_SPELL_03: return 104;
        case EMOTE_ONESHOT_CUSTOM_SPELL_04: return 105;
        case EMOTE_ONESHOT_CUSTOM_SPELL_05: return 106;
        case EMOTE_ONESHOT_CUSTOM_SPELL_06: return 107;
        case EMOTE_ONESHOT_CUSTOM_SPELL_07: return 108;
        case EMOTE_ONESHOT_CUSTOM_SPELL_08: return 109;
        case EMOTE_ONESHOT_CUSTOM_SPELL_09: return 110;
        case EMOTE_ONESHOT_CUSTOM_SPELL_10: return 111;
        case EMOTE_STATE_EXCLAIM: return 112;
        case EMOTE_STATE_DANCE_CUSTOM: return 113;
        case EMOTE_STATE_SIT_CHAIR_MED: return 114;
        case EMOTE_STATE_CUSTOM_SPELL_01: return 115;
        case EMOTE_STATE_CUSTOM_SPELL_02: return 116;
        case EMOTE_STATE_EAT: return 117;
        case EMOTE_STATE_CUSTOM_SPELL_04: return 118;
        case EMOTE_STATE_CUSTOM_SPELL_03: return 119;
        case EMOTE_STATE_CUSTOM_SPELL_05: return 120;
        case EMOTE_STATE_SPELLEFFECT_HOLD: return 121;
        case EMOTE_STATE_EAT_NO_SHEATHE: return 122;
        case EMOTE_STATE_MOUNT: return 123;
        case EMOTE_STATE_READY2HL: return 124;
        case EMOTE_STATE_SIT_CHAIR_HIGH: return 125;
        case EMOTE_STATE_FALL: return 126;
        case EMOTE_STATE_LOOT: return 127;
        case EMOTE_STATE_SUBMERGED_NEW: return 128;
        case EMOTE_ONESHOT_COWER: return 129;
        case EMOTE_STATE_COWER: return 130;
        case EMOTE_ONESHOT_USE_STANDING: return 131;
        case EMOTE_STATE_STEALTH_STAND: return 132;
        case EMOTE_ONESHOT_OMNICAST_GHOUL: return 133;
        case EMOTE_ONESHOT_ATTACK_BOW: return 134;
        case EMOTE_ONESHOT_ATTACK_RIFLE: return 135;
        case EMOTE_STATE_SWIM_IDLE: return 136;
        case EMOTE_STATE_ATTACK_UNARMED: return 137;
        case EMOTE_ONESHOT_SPELL_CAST_W_SOUND: return 138;
        case EMOTE_ONESHOT_DODGE: return 139;
        case EMOTE_ONESHOT_PARRY1H: return 140;
        case EMOTE_ONESHOT_PARRY2H: return 141;
        case EMOTE_ONESHOT_PARRY2HL: return 142;
        case EMOTE_STATE_FLYFALL: return 143;
        case EMOTE_ONESHOT_FLYDEATH: return 144;
        case EMOTE_STATE_FLY_FALL: return 145;
        case EMOTE_ONESHOT_FLY_SIT_GROUND_DOWN: return 146;
        case EMOTE_ONESHOT_FLY_SIT_GROUND_UP: return 147;
        case EMOTE_ONESHOT_EMERGE: return 148;
        case EMOTE_ONESHOT_DRAGON_SPIT: return 149;
        case EMOTE_STATE_SPECIAL_UNARMED: return 150;
        case EMOTE_ONESHOT_FLYGRAB: return 151;
        case EMOTE_STATE_FLYGRABCLOSED: return 152;
        case EMOTE_ONESHOT_FLYGRABTHROWN: return 153;
        case EMOTE_STATE_FLY_SIT_GROUND: return 154;
        case EMOTE_STATE_WALK_BACKWARDS: return 155;
        case EMOTE_ONESHOT_FLYTALK: return 156;
        case EMOTE_ONESHOT_FLYATTACK1H: return 157;
        case EMOTE_STATE_CUSTOM_SPELL_08: return 158;
        case EMOTE_ONESHOT_FLY_DRAGON_SPIT: return 159;
        case EMOTE_STATE_SIT_CHAIR_LOW: return 160;
        case EMOTE_ONESHOT_STUN: return 161;
        case EMOTE_ONESHOT_SPELL_CAST_OMNI: return 162;
        case EMOTE_STATE_READY_THROWN: return 163;
        case EMOTE_ONESHOT_WORK_CHOPWOOD: return 164;
        case EMOTE_ONESHOT_WORK_MINING: return 165;
        case EMOTE_STATE_SPELL_CHANNEL_OMNI: return 166;
        case EMOTE_STATE_SPELL_CHANNEL_DIRECTED: return 167;
        case EMOTE_STAND_STATE_NONE: return 168;
        case EMOTE_STATE_READYJOUST: return 169;
        case EMOTE_STATE_STRANGULATE: return 170;
        case EMOTE_STATE_READY_SPELL_OMNI: return 171;
        case EMOTE_STATE_HOLD_JOUST: return 172;
        case EMOTE_ONESHOT_CRY_JAINA: return 173;
        default: throw std::out_of_range("value");
    }
}

/***************************************************************\
|* data for enum 'ChatMsg' in 'SharedDefines.h' auto-generated *|
\***************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<ChatMsg>::ToString(ChatMsg value)
{
    switch (value)
    {
        case CHAT_MSG_ADDON: return { "CHAT_MSG_ADDON", "CHAT_MSG_ADDON", "" };
        case CHAT_MSG_SYSTEM: return { "CHAT_MSG_SYSTEM", "CHAT_MSG_SYSTEM", "" };
        case CHAT_MSG_SAY: return { "CHAT_MSG_SAY", "CHAT_MSG_SAY", "" };
        case CHAT_MSG_PARTY: return { "CHAT_MSG_PARTY", "CHAT_MSG_PARTY", "" };
        case CHAT_MSG_RAID: return { "CHAT_MSG_RAID", "CHAT_MSG_RAID", "" };
        case CHAT_MSG_GUILD: return { "CHAT_MSG_GUILD", "CHAT_MSG_GUILD", "" };
        case CHAT_MSG_OFFICER: return { "CHAT_MSG_OFFICER", "CHAT_MSG_OFFICER", "" };
        case CHAT_MSG_YELL: return { "CHAT_MSG_YELL", "CHAT_MSG_YELL", "" };
        case CHAT_MSG_WHISPER: return { "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER", "" };
        case CHAT_MSG_WHISPER_FOREIGN: return { "CHAT_MSG_WHISPER_FOREIGN", "CHAT_MSG_WHISPER_FOREIGN", "" };
        case CHAT_MSG_WHISPER_INFORM: return { "CHAT_MSG_WHISPER_INFORM", "CHAT_MSG_WHISPER_INFORM", "" };
        case CHAT_MSG_EMOTE: return { "CHAT_MSG_EMOTE", "CHAT_MSG_EMOTE", "" };
        case CHAT_MSG_TEXT_EMOTE: return { "CHAT_MSG_TEXT_EMOTE", "CHAT_MSG_TEXT_EMOTE", "" };
        case CHAT_MSG_MONSTER_SAY: return { "CHAT_MSG_MONSTER_SAY", "CHAT_MSG_MONSTER_SAY", "" };
        case CHAT_MSG_MONSTER_PARTY: return { "CHAT_MSG_MONSTER_PARTY", "CHAT_MSG_MONSTER_PARTY", "" };
        case CHAT_MSG_MONSTER_YELL: return { "CHAT_MSG_MONSTER_YELL", "CHAT_MSG_MONSTER_YELL", "" };
        case CHAT_MSG_MONSTER_WHISPER: return { "CHAT_MSG_MONSTER_WHISPER", "CHAT_MSG_MONSTER_WHISPER", "" };
        case CHAT_MSG_MONSTER_EMOTE: return { "CHAT_MSG_MONSTER_EMOTE", "CHAT_MSG_MONSTER_EMOTE", "" };
        case CHAT_MSG_CHANNEL: return { "CHAT_MSG_CHANNEL", "CHAT_MSG_CHANNEL", "" };
        case CHAT_MSG_CHANNEL_JOIN: return { "CHAT_MSG_CHANNEL_JOIN", "CHAT_MSG_CHANNEL_JOIN", "" };
        case CHAT_MSG_CHANNEL_LEAVE: return { "CHAT_MSG_CHANNEL_LEAVE", "CHAT_MSG_CHANNEL_LEAVE", "" };
        case CHAT_MSG_CHANNEL_LIST: return { "CHAT_MSG_CHANNEL_LIST", "CHAT_MSG_CHANNEL_LIST", "" };
        case CHAT_MSG_CHANNEL_NOTICE: return { "CHAT_MSG_CHANNEL_NOTICE", "CHAT_MSG_CHANNEL_NOTICE", "" };
        case CHAT_MSG_CHANNEL_NOTICE_USER: return { "CHAT_MSG_CHANNEL_NOTICE_USER", "CHAT_MSG_CHANNEL_NOTICE_USER", "" };
        case CHAT_MSG_AFK: return { "CHAT_MSG_AFK", "CHAT_MSG_AFK", "" };
        case CHAT_MSG_DND: return { "CHAT_MSG_DND", "CHAT_MSG_DND", "" };
        case CHAT_MSG_IGNORED: return { "CHAT_MSG_IGNORED", "CHAT_MSG_IGNORED", "" };
        case CHAT_MSG_SKILL: return { "CHAT_MSG_SKILL", "CHAT_MSG_SKILL", "" };
        case CHAT_MSG_LOOT: return { "CHAT_MSG_LOOT", "CHAT_MSG_LOOT", "" };
        case CHAT_MSG_MONEY: return { "CHAT_MSG_MONEY", "CHAT_MSG_MONEY", "" };
        case CHAT_MSG_OPENING: return { "CHAT_MSG_OPENING", "CHAT_MSG_OPENING", "" };
        case CHAT_MSG_TRADESKILLS: return { "CHAT_MSG_TRADESKILLS", "CHAT_MSG_TRADESKILLS", "" };
        case CHAT_MSG_PET_INFO: return { "CHAT_MSG_PET_INFO", "CHAT_MSG_PET_INFO", "" };
        case CHAT_MSG_COMBAT_MISC_INFO: return { "CHAT_MSG_COMBAT_MISC_INFO", "CHAT_MSG_COMBAT_MISC_INFO", "" };
        case CHAT_MSG_COMBAT_XP_GAIN: return { "CHAT_MSG_COMBAT_XP_GAIN", "CHAT_MSG_COMBAT_XP_GAIN", "" };
        case CHAT_MSG_COMBAT_HONOR_GAIN: return { "CHAT_MSG_COMBAT_HONOR_GAIN", "CHAT_MSG_COMBAT_HONOR_GAIN", "" };
        case CHAT_MSG_COMBAT_FACTION_CHANGE: return { "CHAT_MSG_COMBAT_FACTION_CHANGE", "CHAT_MSG_COMBAT_FACTION_CHANGE", "" };
        case CHAT_MSG_BG_SYSTEM_NEUTRAL: return { "CHAT_MSG_BG_SYSTEM_NEUTRAL", "CHAT_MSG_BG_SYSTEM_NEUTRAL", "" };
        case CHAT_MSG_BG_SYSTEM_ALLIANCE: return { "CHAT_MSG_BG_SYSTEM_ALLIANCE", "CHAT_MSG_BG_SYSTEM_ALLIANCE", "" };
        case CHAT_MSG_BG_SYSTEM_HORDE: return { "CHAT_MSG_BG_SYSTEM_HORDE", "CHAT_MSG_BG_SYSTEM_HORDE", "" };
        case CHAT_MSG_RAID_LEADER: return { "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_LEADER", "" };
        case CHAT_MSG_RAID_WARNING: return { "CHAT_MSG_RAID_WARNING", "CHAT_MSG_RAID_WARNING", "" };
        case CHAT_MSG_RAID_BOSS_EMOTE: return { "CHAT_MSG_RAID_BOSS_EMOTE", "CHAT_MSG_RAID_BOSS_EMOTE", "" };
        case CHAT_MSG_RAID_BOSS_WHISPER: return { "CHAT_MSG_RAID_BOSS_WHISPER", "CHAT_MSG_RAID_BOSS_WHISPER", "" };
        case CHAT_MSG_FILTERED: return { "CHAT_MSG_FILTERED", "CHAT_MSG_FILTERED", "" };
        case CHAT_MSG_BATTLEGROUND: return { "CHAT_MSG_BATTLEGROUND", "CHAT_MSG_BATTLEGROUND", "" };
        case CHAT_MSG_BATTLEGROUND_LEADER: return { "CHAT_MSG_BATTLEGROUND_LEADER", "CHAT_MSG_BATTLEGROUND_LEADER", "" };
        case CHAT_MSG_RESTRICTED: return { "CHAT_MSG_RESTRICTED", "CHAT_MSG_RESTRICTED", "" };
        case CHAT_MSG_BATTLENET: return { "CHAT_MSG_BATTLENET", "CHAT_MSG_BATTLENET", "" };
        case CHAT_MSG_ACHIEVEMENT: return { "CHAT_MSG_ACHIEVEMENT", "CHAT_MSG_ACHIEVEMENT", "" };
        case CHAT_MSG_GUILD_ACHIEVEMENT: return { "CHAT_MSG_GUILD_ACHIEVEMENT", "CHAT_MSG_GUILD_ACHIEVEMENT", "" };
        case CHAT_MSG_ARENA_POINTS: return { "CHAT_MSG_ARENA_POINTS", "CHAT_MSG_ARENA_POINTS", "" };
        case CHAT_MSG_PARTY_LEADER: return { "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_PARTY_LEADER", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<ChatMsg>::Count() { return 53; }

template <>
AC_API_EXPORT ChatMsg EnumUtils<ChatMsg>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return CHAT_MSG_ADDON;
        case 1: return CHAT_MSG_SYSTEM;
        case 2: return CHAT_MSG_SAY;
        case 3: return CHAT_MSG_PARTY;
        case 4: return CHAT_MSG_RAID;
        case 5: return CHAT_MSG_GUILD;
        case 6: return CHAT_MSG_OFFICER;
        case 7: return CHAT_MSG_YELL;
        case 8: return CHAT_MSG_WHISPER;
        case 9: return CHAT_MSG_WHISPER_FOREIGN;
        case 10: return CHAT_MSG_WHISPER_INFORM;
        case 11: return CHAT_MSG_EMOTE;
        case 12: return CHAT_MSG_TEXT_EMOTE;
        case 13: return CHAT_MSG_MONSTER_SAY;
        case 14: return CHAT_MSG_MONSTER_PARTY;
        case 15: return CHAT_MSG_MONSTER_YELL;
        case 16: return CHAT_MSG_MONSTER_WHISPER;
        case 17: return CHAT_MSG_MONSTER_EMOTE;
        case 18: return CHAT_MSG_CHANNEL;
        case 19: return CHAT_MSG_CHANNEL_JOIN;
        case 20: return CHAT_MSG_CHANNEL_LEAVE;
        case 21: return CHAT_MSG_CHANNEL_LIST;
        case 22: return CHAT_MSG_CHANNEL_NOTICE;
        case 23: return CHAT_MSG_CHANNEL_NOTICE_USER;
        case 24: return CHAT_MSG_AFK;
        case 25: return CHAT_MSG_DND;
        case 26: return CHAT_MSG_IGNORED;
        case 27: return CHAT_MSG_SKILL;
        case 28: return CHAT_MSG_LOOT;
        case 29: return CHAT_MSG_MONEY;
        case 30: return CHAT_MSG_OPENING;
        case 31: return CHAT_MSG_TRADESKILLS;
        case 32: return CHAT_MSG_PET_INFO;
        case 33: return CHAT_MSG_COMBAT_MISC_INFO;
        case 34: return CHAT_MSG_COMBAT_XP_GAIN;
        case 35: return CHAT_MSG_COMBAT_HONOR_GAIN;
        case 36: return CHAT_MSG_COMBAT_FACTION_CHANGE;
        case 37: return CHAT_MSG_BG_SYSTEM_NEUTRAL;
        case 38: return CHAT_MSG_BG_SYSTEM_ALLIANCE;
        case 39: return CHAT_MSG_BG_SYSTEM_HORDE;
        case 40: return CHAT_MSG_RAID_LEADER;
        case 41: return CHAT_MSG_RAID_WARNING;
        case 42: return CHAT_MSG_RAID_BOSS_EMOTE;
        case 43: return CHAT_MSG_RAID_BOSS_WHISPER;
        case 44: return CHAT_MSG_FILTERED;
        case 45: return CHAT_MSG_BATTLEGROUND;
        case 46: return CHAT_MSG_BATTLEGROUND_LEADER;
        case 47: return CHAT_MSG_RESTRICTED;
        case 48: return CHAT_MSG_BATTLENET;
        case 49: return CHAT_MSG_ACHIEVEMENT;
        case 50: return CHAT_MSG_GUILD_ACHIEVEMENT;
        case 51: return CHAT_MSG_ARENA_POINTS;
        case 52: return CHAT_MSG_PARTY_LEADER;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<ChatMsg>::ToIndex(ChatMsg value)
{
    switch (value)
    {
        case CHAT_MSG_ADDON: return 0;
        case CHAT_MSG_SYSTEM: return 1;
        case CHAT_MSG_SAY: return 2;
        case CHAT_MSG_PARTY: return 3;
        case CHAT_MSG_RAID: return 4;
        case CHAT_MSG_GUILD: return 5;
        case CHAT_MSG_OFFICER: return 6;
        case CHAT_MSG_YELL: return 7;
        case CHAT_MSG_WHISPER: return 8;
        case CHAT_MSG_WHISPER_FOREIGN: return 9;
        case CHAT_MSG_WHISPER_INFORM: return 10;
        case CHAT_MSG_EMOTE: return 11;
        case CHAT_MSG_TEXT_EMOTE: return 12;
        case CHAT_MSG_MONSTER_SAY: return 13;
        case CHAT_MSG_MONSTER_PARTY: return 14;
        case CHAT_MSG_MONSTER_YELL: return 15;
        case CHAT_MSG_MONSTER_WHISPER: return 16;
        case CHAT_MSG_MONSTER_EMOTE: return 17;
        case CHAT_MSG_CHANNEL: return 18;
        case CHAT_MSG_CHANNEL_JOIN: return 19;
        case CHAT_MSG_CHANNEL_LEAVE: return 20;
        case CHAT_MSG_CHANNEL_LIST: return 21;
        case CHAT_MSG_CHANNEL_NOTICE: return 22;
        case CHAT_MSG_CHANNEL_NOTICE_USER: return 23;
        case CHAT_MSG_AFK: return 24;
        case CHAT_MSG_DND: return 25;
        case CHAT_MSG_IGNORED: return 26;
        case CHAT_MSG_SKILL: return 27;
        case CHAT_MSG_LOOT: return 28;
        case CHAT_MSG_MONEY: return 29;
        case CHAT_MSG_OPENING: return 30;
        case CHAT_MSG_TRADESKILLS: return 31;
        case CHAT_MSG_PET_INFO: return 32;
        case CHAT_MSG_COMBAT_MISC_INFO: return 33;
        case CHAT_MSG_COMBAT_XP_GAIN: return 34;
        case CHAT_MSG_COMBAT_HONOR_GAIN: return 35;
        case CHAT_MSG_COMBAT_FACTION_CHANGE: return 36;
        case CHAT_MSG_BG_SYSTEM_NEUTRAL: return 37;
        case CHAT_MSG_BG_SYSTEM_ALLIANCE: return 38;
        case CHAT_MSG_BG_SYSTEM_HORDE: return 39;
        case CHAT_MSG_RAID_LEADER: return 40;
        case CHAT_MSG_RAID_WARNING: return 41;
        case CHAT_MSG_RAID_BOSS_EMOTE: return 42;
        case CHAT_MSG_RAID_BOSS_WHISPER: return 43;
        case CHAT_MSG_FILTERED: return 44;
        case CHAT_MSG_BATTLEGROUND: return 45;
        case CHAT_MSG_BATTLEGROUND_LEADER: return 46;
        case CHAT_MSG_RESTRICTED: return 47;
        case CHAT_MSG_BATTLENET: return 48;
        case CHAT_MSG_ACHIEVEMENT: return 49;
        case CHAT_MSG_GUILD_ACHIEVEMENT: return 50;
        case CHAT_MSG_ARENA_POINTS: return 51;
        case CHAT_MSG_PARTY_LEADER: return 52;
        default: throw std::out_of_range("value");
    }
}
}
