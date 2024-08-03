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

#include "SpellAuraEffects.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "CellImpl.h"
#include "Common.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvPMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "Unit.h"
#include "Util.h"
#include "Vehicle.h"
#include "WorldPacket.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

class Aura;
//
// EFFECT HANDLER NOTES
//
// in aura handler there should be check for modes:
// AURA_EFFECT_HANDLE_REAL set
// AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK set
// AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK set - aura is recalculated or is just applied/removed - need to redo all things related to m_amount
// AURA_EFFECT_HANDLE_CHANGE_AMOUNT_SEND_FOR_CLIENT_MASK - logical or of above conditions
// AURA_EFFECT_HANDLE_STAT - set when stats are reapplied
// such checks will Speedup azerothcore change amount/send for client operations
// because for change amount operation packets will not be send
// aura effect handlers shouldn't contain any AuraEffect or Aura object modifications

pAuraEffectHandler AuraEffectHandler[TOTAL_AURAS] =
{
    &AuraEffect::HandleNULL,                                      //  0 SPELL_AURA_NONE
    &AuraEffect::HandleBindSight,                                 //  1 SPELL_AURA_BIND_SIGHT
    &AuraEffect::HandleModPossess,                                //  2 SPELL_AURA_MOD_POSSESS
    &AuraEffect::HandleNoImmediateEffect,                         //  3 SPELL_AURA_PERIODIC_DAMAGE implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleAuraDummy,                                 //  4 SPELL_AURA_DUMMY
    &AuraEffect::HandleModConfuse,                                //  5 SPELL_AURA_MOD_CONFUSE
    &AuraEffect::HandleModCharm,                                  //  6 SPELL_AURA_MOD_CHARM
    &AuraEffect::HandleModFear,                                   //  7 SPELL_AURA_MOD_FEAR
    &AuraEffect::HandleNoImmediateEffect,                         //  8 SPELL_AURA_PERIODIC_HEAL implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleModAttackSpeed,                            //  9 SPELL_AURA_MOD_ATTACKSPEED
    &AuraEffect::HandleModThreat,                                 // 10 SPELL_AURA_MOD_THREAT
    &AuraEffect::HandleModTaunt,                                  // 11 SPELL_AURA_MOD_TAUNT
    &AuraEffect::HandleAuraModStun,                               // 12 SPELL_AURA_MOD_STUN
    &AuraEffect::HandleModDamageDone,                             // 13 SPELL_AURA_MOD_DAMAGE_DONE
    &AuraEffect::HandleNoImmediateEffect,                         // 14 SPELL_AURA_MOD_DAMAGE_TAKEN implemented in Unit::MeleeDamageBonus and Unit::SpellDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         // 15 SPELL_AURA_DAMAGE_SHIELD    implemented in Unit::DoAttackDamage
    &AuraEffect::HandleModStealth,                                // 16 SPELL_AURA_MOD_STEALTH
    &AuraEffect::HandleModStealthDetect,                          // 17 SPELL_AURA_MOD_DETECT
    &AuraEffect::HandleModInvisibility,                           // 18 SPELL_AURA_MOD_INVISIBILITY
    &AuraEffect::HandleModInvisibilityDetect,                     // 19 SPELL_AURA_MOD_INVISIBILITY_DETECTION
    &AuraEffect::HandleNoImmediateEffect,                         // 20 SPELL_AURA_OBS_MOD_HEALTH implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleNoImmediateEffect,                         // 21 SPELL_AURA_OBS_MOD_POWER implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleAuraModResistance,                         // 22 SPELL_AURA_MOD_RESISTANCE
    &AuraEffect::HandleNoImmediateEffect,                         // 23 SPELL_AURA_PERIODIC_TRIGGER_SPELL implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleNoImmediateEffect,                         // 24 SPELL_AURA_PERIODIC_ENERGIZE implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleAuraModPacify,                             // 25 SPELL_AURA_MOD_PACIFY
    &AuraEffect::HandleAuraModRoot,                               // 26 SPELL_AURA_MOD_ROOT
    &AuraEffect::HandleAuraModSilence,                            // 27 SPELL_AURA_MOD_SILENCE
    &AuraEffect::HandleNoImmediateEffect,                         // 28 SPELL_AURA_REFLECT_SPELLS        implement in Unit::SpellHitResult
    &AuraEffect::HandleAuraModStat,                               // 29 SPELL_AURA_MOD_STAT
    &AuraEffect::HandleAuraModSkill,                              // 30 SPELL_AURA_MOD_SKILL
    &AuraEffect::HandleAuraModIncreaseSpeed,                      // 31 SPELL_AURA_MOD_INCREASE_SPEED
    &AuraEffect::HandleAuraModIncreaseMountedSpeed,               // 32 SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED
    &AuraEffect::HandleAuraModDecreaseSpeed,                      // 33 SPELL_AURA_MOD_DECREASE_SPEED
    &AuraEffect::HandleAuraModIncreaseHealth,                     // 34 SPELL_AURA_MOD_INCREASE_HEALTH
    &AuraEffect::HandleAuraModIncreaseEnergy,                     // 35 SPELL_AURA_MOD_INCREASE_ENERGY
    &AuraEffect::HandleAuraModShapeshift,                         // 36 SPELL_AURA_MOD_SHAPESHIFT
    &AuraEffect::HandleAuraModEffectImmunity,                     // 37 SPELL_AURA_EFFECT_IMMUNITY
    &AuraEffect::HandleAuraModStateImmunity,                      // 38 SPELL_AURA_STATE_IMMUNITY
    &AuraEffect::HandleAuraModSchoolImmunity,                     // 39 SPELL_AURA_SCHOOL_IMMUNITY
    &AuraEffect::HandleAuraModDmgImmunity,                        // 40 SPELL_AURA_DAMAGE_IMMUNITY
    &AuraEffect::HandleAuraModDispelImmunity,                     // 41 SPELL_AURA_DISPEL_IMMUNITY
    &AuraEffect::HandleNoImmediateEffect,                         // 42 SPELL_AURA_PROC_TRIGGER_SPELL  implemented in Unit::ProcDamageAndSpellFor and Unit::HandleProcTriggerSpell
    &AuraEffect::HandleNoImmediateEffect,                         // 43 SPELL_AURA_PROC_TRIGGER_DAMAGE implemented in Unit::ProcDamageAndSpellFor
    &AuraEffect::HandleAuraTrackCreatures,                        // 44 SPELL_AURA_TRACK_CREATURES
    &AuraEffect::HandleAuraTrackResources,                        // 45 SPELL_AURA_TRACK_RESOURCES
    &AuraEffect::HandleNULL,                                      // 46 SPELL_AURA_46 (used in test spells 54054 and 54058, and spell 48050) (3.0.8a)
    &AuraEffect::HandleAuraModParryPercent,                       // 47 SPELL_AURA_MOD_PARRY_PERCENT
    &AuraEffect::HandleNoImmediateEffect,                         // 48 SPELL_AURA_PERIODIC_TRIGGER_SPELL_FROM_CLIENT
    &AuraEffect::HandleAuraModDodgePercent,                       // 49 SPELL_AURA_MOD_DODGE_PERCENT
    &AuraEffect::HandleNoImmediateEffect,                         // 50 SPELL_AURA_MOD_CRITICAL_HEALING_AMOUNT implemented in Unit::SpellCriticalHealingBonus
    &AuraEffect::HandleAuraModBlockPercent,                       // 51 SPELL_AURA_MOD_BLOCK_PERCENT
    &AuraEffect::HandleAuraModWeaponCritPercent,                  // 52 SPELL_AURA_MOD_WEAPON_CRIT_PERCENT
    &AuraEffect::HandleNoImmediateEffect,                         // 53 SPELL_AURA_PERIODIC_LEECH implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleModHitChance,                              // 54 SPELL_AURA_MOD_HIT_CHANCE
    &AuraEffect::HandleModSpellHitChance,                         // 55 SPELL_AURA_MOD_SPELL_HIT_CHANCE
    &AuraEffect::HandleAuraTransform,                             // 56 SPELL_AURA_TRANSFORM
    &AuraEffect::HandleModSpellCritChance,                        // 57 SPELL_AURA_MOD_SPELL_CRIT_CHANCE
    &AuraEffect::HandleAuraModIncreaseSwimSpeed,                  // 58 SPELL_AURA_MOD_INCREASE_SWIM_SPEED
    &AuraEffect::HandleNoImmediateEffect,                         // 59 SPELL_AURA_MOD_DAMAGE_DONE_CREATURE implemented in Unit::MeleeDamageBonus and Unit::SpellDamageBonus
    &AuraEffect::HandleAuraModPacifyAndSilence,                   // 60 SPELL_AURA_MOD_PACIFY_SILENCE
    &AuraEffect::HandleAuraModScale,                              // 61 SPELL_AURA_MOD_SCALE
    &AuraEffect::HandleNoImmediateEffect,                         // 62 SPELL_AURA_PERIODIC_HEALTH_FUNNEL implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleNULL,                                      // 63 unused (3.2.0) old SPELL_AURA_PERIODIC_MANA_FUNNEL
    &AuraEffect::HandleNoImmediateEffect,                         // 64 SPELL_AURA_PERIODIC_MANA_LEECH implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleModCastingSpeed,                           // 65 SPELL_AURA_MOD_CASTING_SPEED_NOT_STACK
    &AuraEffect::HandleFeignDeath,                                // 66 SPELL_AURA_FEIGN_DEATH
    &AuraEffect::HandleAuraModDisarm,                             // 67 SPELL_AURA_MOD_DISARM
    &AuraEffect::HandleAuraModStalked,                            // 68 SPELL_AURA_MOD_STALKED
    &AuraEffect::HandleNoImmediateEffect,                         // 69 SPELL_AURA_SCHOOL_ABSORB implemented in Unit::CalcAbsorbResist
    &AuraEffect::HandleUnused,                                    // 70 SPELL_AURA_EXTRA_ATTACKS clientside
    &AuraEffect::HandleModSpellCritChanceShool,                   // 71 SPELL_AURA_MOD_SPELL_CRIT_CHANCE_SCHOOL
    &AuraEffect::HandleModPowerCostPCT,                           // 72 SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT
    &AuraEffect::HandleModPowerCost,                              // 73 SPELL_AURA_MOD_POWER_COST_SCHOOL
    &AuraEffect::HandleNoImmediateEffect,                         // 74 SPELL_AURA_REFLECT_SPELLS_SCHOOL  implemented in Unit::SpellHitResult
    &AuraEffect::HandleNoImmediateEffect,                         // 75 SPELL_AURA_MOD_LANGUAGE
    &AuraEffect::HandleFarSight,                                  // 76 SPELL_AURA_FAR_SIGHT
    &AuraEffect::HandleModMechanicImmunity,                       // 77 SPELL_AURA_MECHANIC_IMMUNITY
    &AuraEffect::HandleAuraMounted,                               // 78 SPELL_AURA_MOUNTED
    &AuraEffect::HandleModDamagePercentDone,                      // 79 SPELL_AURA_MOD_DAMAGE_PERCENT_DONE
    &AuraEffect::HandleModPercentStat,                            // 80 SPELL_AURA_MOD_PERCENT_STAT
    &AuraEffect::HandleNoImmediateEffect,                         // 81 SPELL_AURA_SPLIT_DAMAGE_PCT implemented in Unit::CalcAbsorbResist
    &AuraEffect::HandleWaterBreathing,                            // 82 SPELL_AURA_WATER_BREATHING
    &AuraEffect::HandleModBaseResistance,                         // 83 SPELL_AURA_MOD_BASE_RESISTANCE
    &AuraEffect::HandleNoImmediateEffect,                         // 84 SPELL_AURA_MOD_REGEN implemented in Player::RegenerateHealth
    &AuraEffect::HandleModPowerRegen,                             // 85 SPELL_AURA_MOD_POWER_REGEN implemented in Player::Regenerate
    &AuraEffect::HandleChannelDeathItem,                          // 86 SPELL_AURA_CHANNEL_DEATH_ITEM
    &AuraEffect::HandleNoImmediateEffect,                         // 87 SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN implemented in Unit::MeleeDamageBonus and Unit::SpellDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         // 88 SPELL_AURA_MOD_HEALTH_REGEN_PERCENT implemented in Player::RegenerateHealth
    &AuraEffect::HandleNoImmediateEffect,                         // 89 SPELL_AURA_PERIODIC_DAMAGE_PERCENT
    &AuraEffect::HandleNULL,                                      // 90 unused (3.0.8a) old SPELL_AURA_MOD_RESIST_CHANCE
    &AuraEffect::HandleNoImmediateEffect,                         // 91 SPELL_AURA_MOD_DETECT_RANGE implemented in Creature::GetAggroRange
    &AuraEffect::HandlePreventFleeing,                            // 92 SPELL_AURA_PREVENTS_FLEEING
    &AuraEffect::HandleModUnattackable,                           // 93 SPELL_AURA_MOD_UNATTACKABLE
    &AuraEffect::HandleNoImmediateEffect,                         // 94 SPELL_AURA_INTERRUPT_REGEN implemented in Player::Regenerate
    &AuraEffect::HandleAuraGhost,                                 // 95 SPELL_AURA_GHOST
    &AuraEffect::HandleNoImmediateEffect,                         // 96 SPELL_AURA_SPELL_MAGNET implemented in Unit::SelectMagnetTarget
    &AuraEffect::HandleNoImmediateEffect,                         // 97 SPELL_AURA_MANA_SHIELD implemented in Unit::CalcAbsorbResist
    &AuraEffect::HandleAuraModSkill,                              // 98 SPELL_AURA_MOD_SKILL_TALENT
    &AuraEffect::HandleAuraModAttackPower,                        // 99 SPELL_AURA_MOD_ATTACK_POWER
    &AuraEffect::HandleUnused,                                    //100 SPELL_AURA_AURAS_VISIBLE obsolete? all player can see all auras now, but still have spells including GM-spell
    &AuraEffect::HandleModResistancePercent,                      //101 SPELL_AURA_MOD_RESISTANCE_PCT
    &AuraEffect::HandleNoImmediateEffect,                         //102 SPELL_AURA_MOD_MELEE_ATTACK_POWER_VERSUS implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleAuraModTotalThreat,                        //103 SPELL_AURA_MOD_TOTAL_THREAT
    &AuraEffect::HandleAuraWaterWalk,                             //104 SPELL_AURA_WATER_WALK
    &AuraEffect::HandleAuraFeatherFall,                           //105 SPELL_AURA_FEATHER_FALL
    &AuraEffect::HandleAuraHover,                                 //106 SPELL_AURA_HOVER
    &AuraEffect::HandleNoImmediateEffect,                         //107 SPELL_AURA_ADD_FLAT_MODIFIER implemented in AuraEffect::CalculateSpellMod()
    &AuraEffect::HandleNoImmediateEffect,                         //108 SPELL_AURA_ADD_PCT_MODIFIER implemented in AuraEffect::CalculateSpellMod()
    &AuraEffect::HandleNoImmediateEffect,                         //109 SPELL_AURA_ADD_TARGET_TRIGGER
    &AuraEffect::HandleModPowerRegenPCT,                          //110 SPELL_AURA_MOD_POWER_REGEN_PERCENT implemented in Player::Regenerate, Creature::Regenerate
    &AuraEffect::HandleNoImmediateEffect,                         //111 SPELL_AURA_ADD_CASTER_HIT_TRIGGER implemented in Unit::SelectMagnetTarget
    &AuraEffect::HandleNoImmediateEffect,                         //112 SPELL_AURA_OVERRIDE_CLASS_SCRIPTS
    &AuraEffect::HandleNoImmediateEffect,                         //113 SPELL_AURA_MOD_RANGED_DAMAGE_TAKEN implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         //114 SPELL_AURA_MOD_RANGED_DAMAGE_TAKEN_PCT implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         //115 SPELL_AURA_MOD_HEALING                 implemented in Unit::SpellBaseHealingBonusForVictim
    &AuraEffect::HandleNoImmediateEffect,                         //116 SPELL_AURA_MOD_REGEN_DURING_COMBAT
    &AuraEffect::HandleNoImmediateEffect,                         //117 SPELL_AURA_MOD_MECHANIC_RESISTANCE     implemented in Unit::MagicSpellHitResult
    &AuraEffect::HandleNoImmediateEffect,                         //118 SPELL_AURA_MOD_HEALING_PCT             implemented in Unit::SpellHealingBonus
    &AuraEffect::HandleNULL,                                      //119 unused (3.2.0) old SPELL_AURA_SHARE_PET_TRACKING
    &AuraEffect::HandleAuraUntrackable,                           //120 SPELL_AURA_UNTRACKABLE
    &AuraEffect::HandleAuraEmpathy,                               //121 SPELL_AURA_EMPATHY
    &AuraEffect::HandleModOffhandDamagePercent,                   //122 SPELL_AURA_MOD_OFFHAND_DAMAGE_PCT
    &AuraEffect::HandleModTargetResistance,                       //123 SPELL_AURA_MOD_TARGET_RESISTANCE
    &AuraEffect::HandleAuraModRangedAttackPower,                  //124 SPELL_AURA_MOD_RANGED_ATTACK_POWER
    &AuraEffect::HandleNoImmediateEffect,                         //125 SPELL_AURA_MOD_MELEE_DAMAGE_TAKEN implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         //126 SPELL_AURA_MOD_MELEE_DAMAGE_TAKEN_PCT implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         //127 SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleModPossessPet,                             //128 SPELL_AURA_MOD_POSSESS_PET
    &AuraEffect::HandleAuraModIncreaseSpeed,                      //129 SPELL_AURA_MOD_SPEED_ALWAYS
    &AuraEffect::HandleAuraModIncreaseMountedSpeed,               //130 SPELL_AURA_MOD_MOUNTED_SPEED_ALWAYS
    &AuraEffect::HandleNoImmediateEffect,                         //131 SPELL_AURA_MOD_RANGED_ATTACK_POWER_VERSUS implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleAuraModIncreaseEnergyPercent,              //132 SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT
    &AuraEffect::HandleAuraModIncreaseHealthPercent,              //133 SPELL_AURA_MOD_INCREASE_HEALTH_PERCENT
    &AuraEffect::HandleAuraModRegenInterrupt,                     //134 SPELL_AURA_MOD_MANA_REGEN_INTERRUPT
    &AuraEffect::HandleModHealingDone,                            //135 SPELL_AURA_MOD_HEALING_DONE
    &AuraEffect::HandleNoImmediateEffect,                         //136 SPELL_AURA_MOD_HEALING_DONE_PERCENT   implemented in Unit::SpellHealingBonus
    &AuraEffect::HandleModTotalPercentStat,                       //137 SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE
    &AuraEffect::HandleModMeleeSpeedPct,                          //138 SPELL_AURA_MOD_MELEE_HASTE
    &AuraEffect::HandleForceReaction,                             //139 SPELL_AURA_FORCE_REACTION
    &AuraEffect::HandleAuraModRangedHaste,                        //140 SPELL_AURA_MOD_RANGED_HASTE
    &AuraEffect::HandleRangedAmmoHaste,                           //141 SPELL_AURA_MOD_RANGED_AMMO_HASTE
    &AuraEffect::HandleAuraModBaseResistancePCT,                  //142 SPELL_AURA_MOD_BASE_RESISTANCE_PCT
    &AuraEffect::HandleAuraModResistanceExclusive,                //143 SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE
    &AuraEffect::HandleNoImmediateEffect,                         //144 SPELL_AURA_SAFE_FALL                         implemented in WorldSession::HandleMovementOpcodes
    &AuraEffect::HandleAuraModPetTalentsPoints,                   //145 SPELL_AURA_MOD_PET_TALENT_POINTS
    &AuraEffect::HandleNoImmediateEffect,                         //146 SPELL_AURA_ALLOW_TAME_PET_TYPE
    &AuraEffect::HandleModStateImmunityMask,                      //147 SPELL_AURA_MECHANIC_IMMUNITY_MASK
    &AuraEffect::HandleAuraRetainComboPoints,                     //148 SPELL_AURA_RETAIN_COMBO_POINTS
    &AuraEffect::HandleNoImmediateEffect,                         //149 SPELL_AURA_REDUCE_PUSHBACK
    &AuraEffect::HandleShieldBlockValue,                          //150 SPELL_AURA_MOD_SHIELD_BLOCKVALUE_PCT
    &AuraEffect::HandleAuraTrackStealthed,                        //151 SPELL_AURA_TRACK_STEALTHED
    &AuraEffect::HandleNoImmediateEffect,                         //152 SPELL_AURA_MOD_DETECTED_RANGE implemented in Creature::GetAggroRange
    &AuraEffect::HandleNoImmediateEffect,                         //153 SPELL_AURA_SPLIT_DAMAGE_FLAT
    &AuraEffect::HandleModStealthLevel,                           //154 SPELL_AURA_MOD_STEALTH_LEVEL
    &AuraEffect::HandleNoImmediateEffect,                         //155 SPELL_AURA_MOD_WATER_BREATHING
    &AuraEffect::HandleNoImmediateEffect,                         //156 SPELL_AURA_MOD_REPUTATION_GAIN
    &AuraEffect::HandleNULL,                                      //157 SPELL_AURA_PET_DAMAGE_MULTI
    &AuraEffect::HandleShieldBlockValue,                          //158 SPELL_AURA_MOD_SHIELD_BLOCKVALUE
    &AuraEffect::HandleNoImmediateEffect,                         //159 SPELL_AURA_NO_PVP_CREDIT      only for Honorless Target spell
    &AuraEffect::HandleNoImmediateEffect,                         //160 SPELL_AURA_MOD_AOE_AVOIDANCE                 implemented in Unit::MagicSpellHitResult
    &AuraEffect::HandleNoImmediateEffect,                         //161 SPELL_AURA_MOD_HEALTH_REGEN_IN_COMBAT
    &AuraEffect::HandleNoImmediateEffect,                         //162 SPELL_AURA_POWER_BURN implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleNoImmediateEffect,                         //163 SPELL_AURA_MOD_CRIT_DAMAGE_BONUS
    &AuraEffect::HandleUnused,                                    //164 unused (3.2.0), only one test spell
    &AuraEffect::HandleNoImmediateEffect,                         //165 SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS implemented in Unit::MeleeDamageBonus
    &AuraEffect::HandleAuraModAttackPowerPercent,                 //166 SPELL_AURA_MOD_ATTACK_POWER_PCT
    &AuraEffect::HandleAuraModRangedAttackPowerPercent,           //167 SPELL_AURA_MOD_RANGED_ATTACK_POWER_PCT
    &AuraEffect::HandleNoImmediateEffect,                         //168 SPELL_AURA_MOD_DAMAGE_DONE_VERSUS            implemented in Unit::SpellDamageBonus, Unit::MeleeDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         //169 SPELL_AURA_MOD_CRIT_PERCENT_VERSUS           implemented in Unit::DealDamageBySchool, Unit::DoAttackDamage, Unit::SpellCriticalBonus
    &AuraEffect::HandleDetectAmore,                               //170 SPELL_AURA_DETECT_AMORE       various spells that change visual of units for aura target (clientside?)
    &AuraEffect::HandleAuraModIncreaseSpeed,                      //171 SPELL_AURA_MOD_SPEED_NOT_STACK
    &AuraEffect::HandleAuraModIncreaseMountedSpeed,               //172 SPELL_AURA_MOD_MOUNTED_SPEED_NOT_STACK
    &AuraEffect::HandleNULL,                                      //173 unused (3.2.0) no spells, old SPELL_AURA_ALLOW_CHAMPION_SPELLS  only for Proclaim Champion spell
    &AuraEffect::HandleModSpellDamagePercentFromStat,             //174 SPELL_AURA_MOD_SPELL_DAMAGE_OF_STAT_PERCENT  implemented in Unit::SpellBaseDamageBonus
    &AuraEffect::HandleModSpellHealingPercentFromStat,            //175 SPELL_AURA_MOD_SPELL_HEALING_OF_STAT_PERCENT implemented in Unit::SpellBaseHealingBonus
    &AuraEffect::HandleSpiritOfRedemption,                        //176 SPELL_AURA_SPIRIT_OF_REDEMPTION   only for Spirit of Redemption spell, die at aura end
    &AuraEffect::HandleCharmConvert,                              //177 SPELL_AURA_AOE_CHARM
    &AuraEffect::HandleNoImmediateEffect,                         //178 SPELL_AURA_MOD_DEBUFF_RESISTANCE          implemented in Unit::MagicSpellHitResult
    &AuraEffect::HandleNoImmediateEffect,                         //179 SPELL_AURA_MOD_ATTACKER_SPELL_CRIT_CHANCE implemented in Unit::SpellCriticalBonus
    &AuraEffect::HandleNoImmediateEffect,                         //180 SPELL_AURA_MOD_FLAT_SPELL_DAMAGE_VERSUS   implemented in Unit::SpellDamageBonus
    &AuraEffect::HandleNULL,                                      //181 unused (3.2.0) old SPELL_AURA_MOD_FLAT_SPELL_CRIT_DAMAGE_VERSUS
    &AuraEffect::HandleAuraModResistenceOfStatPercent,            //182 SPELL_AURA_MOD_RESISTANCE_OF_STAT_PERCENT
    &AuraEffect::HandleNULL,                                      //183 SPELL_AURA_MOD_CRITICAL_THREAT only used in 28746 - miscvalue - spell school
    &AuraEffect::HandleNoImmediateEffect,                         //184 SPELL_AURA_MOD_ATTACKER_MELEE_HIT_CHANCE  implemented in Unit::RollMeleeOutcomeAgainst
    &AuraEffect::HandleNoImmediateEffect,                         //185 SPELL_AURA_MOD_ATTACKER_RANGED_HIT_CHANCE implemented in Unit::RollMeleeOutcomeAgainst
    &AuraEffect::HandleNoImmediateEffect,                         //186 SPELL_AURA_MOD_ATTACKER_SPELL_HIT_CHANCE  implemented in Unit::MagicSpellHitResult
    &AuraEffect::HandleNoImmediateEffect,                         //187 SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE  implemented in ObjectAccessor::GetUnitCriticalChance
    &AuraEffect::HandleNoImmediateEffect,                         //188 SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_CHANCE implemented in ObjectAccessor::GetUnitCriticalChance
    &AuraEffect::HandleModRating,                                 //189 SPELL_AURA_MOD_RATING
    &AuraEffect::HandleNoImmediateEffect,                         //190 SPELL_AURA_MOD_FACTION_REPUTATION_GAIN     implemented in Player::CalculateReputationGain
    &AuraEffect::HandleAuraModUseNormalSpeed,                     //191 SPELL_AURA_USE_NORMAL_MOVEMENT_SPEED
    &AuraEffect::HandleModMeleeRangedSpeedPct,                    //192 SPELL_AURA_MOD_MELEE_RANGED_HASTE
    &AuraEffect::HandleModCombatSpeedPct,                         //193 SPELL_AURA_MELEE_SLOW (in fact combat (any type attack) Speed pct)
    &AuraEffect::HandleNoImmediateEffect,                         //194 SPELL_AURA_MOD_TARGET_ABSORB_SCHOOL implemented in Unit::CalcAbsorbResist
    &AuraEffect::HandleNoImmediateEffect,                         //195 SPELL_AURA_MOD_TARGET_ABILITY_ABSORB_SCHOOL implemented in Unit::CalcAbsorbResist
    &AuraEffect::HandleNoImmediateEffect,                         //196 SPELL_AURA_MOD_COOLDOWN - flat mod of spell cooldowns
    &AuraEffect::HandleNoImmediateEffect,                         //197 SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE implemented in Unit::SpellCriticalBonus ObjectAccessor::GetUnitCriticalChance
    &AuraEffect::HandleNULL,                                      //198 unused (3.2.0) old SPELL_AURA_MOD_ALL_WEAPON_SKILLS
    &AuraEffect::HandleNoImmediateEffect,                         //199 SPELL_AURA_MOD_INCREASES_SPELL_PCT_TO_HIT  implemented in Unit::MagicSpellHitResult
    &AuraEffect::HandleNoImmediateEffect,                         //200 SPELL_AURA_MOD_XP_PCT implemented in Player::RewardPlayerAndGroupAtKill
    &AuraEffect::HandleAuraAllowFlight,                           //201 SPELL_AURA_FLY                             this aura enable flight mode...
    &AuraEffect::HandleNoImmediateEffect,                         //202 SPELL_AURA_CANNOT_BE_DODGED                implemented in Unit::RollPhysicalOutcomeAgainst
    &AuraEffect::HandleNoImmediateEffect,                         //203 SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_DAMAGE  implemented in Unit::CalculateMeleeDamage and Unit::CalculateSpellDamage
    &AuraEffect::HandleNoImmediateEffect,                         //204 SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_DAMAGE implemented in Unit::CalculateMeleeDamage and Unit::CalculateSpellDamage
    &AuraEffect::HandleNULL,                                      //205 SPELL_AURA_MOD_SCHOOL_CRIT_DMG_TAKEN
    &AuraEffect::HandleAuraModIncreaseFlightSpeed,                //206 SPELL_AURA_MOD_INCREASE_VEHICLE_FLIGHT_SPEED
    &AuraEffect::HandleAuraModIncreaseFlightSpeed,                //207 SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED
    &AuraEffect::HandleAuraModIncreaseFlightSpeed,                //208 SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED
    &AuraEffect::HandleAuraModIncreaseFlightSpeed,                //209 SPELL_AURA_MOD_MOUNTED_FLIGHT_SPEED_ALWAYS
    &AuraEffect::HandleAuraModIncreaseFlightSpeed,                //210 SPELL_AURA_MOD_VEHICLE_SPEED_ALWAYS
    &AuraEffect::HandleAuraModIncreaseFlightSpeed,                //211 SPELL_AURA_MOD_FLIGHT_SPEED_NOT_STACK
    &AuraEffect::HandleAuraModRangedAttackPowerOfStatPercent,     //212 SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_STAT_PERCENT
    &AuraEffect::HandleNoImmediateEffect,                         //213 SPELL_AURA_MOD_RAGE_FROM_DAMAGE_DEALT implemented in Player::RewardRage
    &AuraEffect::HandleNULL,                                      //214 Tamed Pet Passive
    &AuraEffect::HandleArenaPreparation,                          //215 SPELL_AURA_ARENA_PREPARATION
    &AuraEffect::HandleModCastingSpeed,                           //216 SPELL_AURA_HASTE_SPELLS
    &AuraEffect::HandleNULL,                                      //217 69106 - killing spree helper - unknown use
    &AuraEffect::HandleAuraModRangedHaste,                        //218 SPELL_AURA_HASTE_RANGED
    &AuraEffect::HandleModManaRegen,                              //219 SPELL_AURA_MOD_MANA_REGEN_FROM_STAT
    &AuraEffect::HandleModRatingFromStat,                         //220 SPELL_AURA_MOD_RATING_FROM_STAT
    &AuraEffect::HandleNoImmediateEffect,                         //221 SPELL_AURA_IGNORED
    &AuraEffect::HandleUnused,                                    //222 unused (3.2.0) only for spell 44586 that not used in real spell cast
    &AuraEffect::HandleNoImmediateEffect,                         //223 SPELL_AURA_RAID_PROC_FROM_CHARGE
    &AuraEffect::HandleUnused,                                    //224 unused (3.0.8a)
    &AuraEffect::HandleNoImmediateEffect,                         //225 SPELL_AURA_RAID_PROC_FROM_CHARGE_WITH_VALUE
    &AuraEffect::HandleNoImmediateEffect,                         //226 SPELL_AURA_PERIODIC_DUMMY implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleNoImmediateEffect,                         //227 SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleNoImmediateEffect,                         //228 SPELL_AURA_DETECT_STEALTH stealth detection
    &AuraEffect::HandleNoImmediateEffect,                         //229 SPELL_AURA_MOD_AOE_DAMAGE_AVOIDANCE
    &AuraEffect::HandleAuraModIncreaseMaxHealth,                  //230 SPELL_AURA_MOD_INCREASE_HEALTH_2 only Blood Pact and Commanding Shout
    &AuraEffect::HandleNoImmediateEffect,                         //231 SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE
    &AuraEffect::HandleNoImmediateEffect,                         //232 SPELL_AURA_MECHANIC_DURATION_MOD           implement in Unit::CalculateSpellDuration
    &AuraEffect::HandleUnused,                                    //233 set model id to the one of the creature with id GetMiscValue() - clientside
    &AuraEffect::HandleNoImmediateEffect,                         //234 SPELL_AURA_MECHANIC_DURATION_MOD_NOT_STACK implement in Unit::CalculateSpellDuration
    &AuraEffect::HandleNoImmediateEffect,                         //235 SPELL_AURA_MOD_DISPEL_RESIST               implement in Unit::MagicSpellHitResult
    &AuraEffect::HandleAuraControlVehicle,                        //236 SPELL_AURA_CONTROL_VEHICLE
    &AuraEffect::HandleModSpellDamagePercentFromAttackPower,      //237 SPELL_AURA_MOD_SPELL_DAMAGE_OF_ATTACK_POWER  implemented in Unit::SpellBaseDamageBonus
    &AuraEffect::HandleModSpellHealingPercentFromAttackPower,     //238 SPELL_AURA_MOD_SPELL_HEALING_OF_ATTACK_POWER implemented in Unit::SpellBaseHealingBonus
    &AuraEffect::HandleAuraModScale,                              //239 SPELL_AURA_MOD_SCALE_2 only in Noggenfogger Elixir (16595) before 2.3.0 aura 61
    &AuraEffect::HandleAuraModExpertise,                          //240 SPELL_AURA_MOD_EXPERTISE
    &AuraEffect::HandleForceMoveForward,                          //241 SPELL_AURA_FORCE_MOVE_FORWARD Forces the caster to move forward
    &AuraEffect::HandleNULL,                                      //242 SPELL_AURA_MOD_SPELL_DAMAGE_FROM_HEALING - 2 test spells: 44183 and 44182
    &AuraEffect::HandleAuraModFaction,                            //243 SPELL_AURA_MOD_FACTION
    &AuraEffect::HandleComprehendLanguage,                        //244 SPELL_AURA_COMPREHEND_LANGUAGE
    &AuraEffect::HandleNoImmediateEffect,                         //245 SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL
    &AuraEffect::HandleNoImmediateEffect,                         //246 SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL_NOT_STACK implemented in Spell::EffectApplyAura
    &AuraEffect::HandleAuraCloneCaster,                           //247 SPELL_AURA_CLONE_CASTER
    &AuraEffect::HandleNoImmediateEffect,                         //248 SPELL_AURA_MOD_COMBAT_RESULT_CHANCE         implemented in Unit::RollMeleeOutcomeAgainst
    &AuraEffect::HandleAuraConvertRune,                           //249 SPELL_AURA_CONVERT_RUNE
    &AuraEffect::HandleAuraModIncreaseHealth,                     //250 SPELL_AURA_MOD_INCREASE_HEALTH_2
    &AuraEffect::HandleNoImmediateEffect,                         //251 SPELL_AURA_MOD_ENEMY_DODGE
    &AuraEffect::HandleModCombatSpeedPct,                         //252 SPELL_AURA_252 Is there any difference between this and SPELL_AURA_MELEE_SLOW ? maybe not stacking mod?
    &AuraEffect::HandleNoImmediateEffect,                         //253 SPELL_AURA_MOD_BLOCK_CRIT_CHANCE  implemented in Unit::isBlockCritical
    &AuraEffect::HandleAuraModDisarm,                             //254 SPELL_AURA_MOD_DISARM_OFFHAND
    &AuraEffect::HandleNoImmediateEffect,                         //255 SPELL_AURA_MOD_MECHANIC_DAMAGE_TAKEN_PERCENT    implemented in Unit::SpellDamageBonus
    &AuraEffect::HandleNoReagentUseAura,                          //256 SPELL_AURA_NO_REAGENT_USE Use SpellClassMask for spell select
    &AuraEffect::HandleNULL,                                      //257 SPELL_AURA_MOD_TARGET_RESIST_BY_SPELL_CLASS Use SpellClassMask for spell select
    &AuraEffect::HandleNULL,                                      //258 SPELL_AURA_MOD_SPELL_VISUAL
    &AuraEffect::HandleNoImmediateEffect,                         //259 SPELL_AURA_MOD_HOT_PCT implemented in Unit::SpellHealingBonus
    &AuraEffect::HandleNoImmediateEffect,                         //260 SPELL_AURA_SCREEN_EFFECT (miscvalue = id in ScreenEffect.dbc) not required any code
    &AuraEffect::HandlePhase,                                     //261 SPELL_AURA_PHASE
    &AuraEffect::HandleNoImmediateEffect,                         //262 SPELL_AURA_ABILITY_IGNORE_AURASTATE implemented in spell::cancast
    &AuraEffect::HandleAuraAllowOnlyAbility,                      //263 SPELL_AURA_ALLOW_ONLY_ABILITY player can use only abilities set in SpellClassMask
    &AuraEffect::HandleUnused,                                    //264 unused (3.2.0)
    &AuraEffect::HandleUnused,                                    //265 unused (3.2.0)
    &AuraEffect::HandleUnused,                                    //266 unused (3.2.0)
    &AuraEffect::HandleNoImmediateEffect,                         //267 SPELL_AURA_MOD_IMMUNE_AURA_APPLY_SCHOOL         implemented in Unit::IsImmunedToSpellEffect
    &AuraEffect::HandleAuraModAttackPowerOfStatPercent,           //268 SPELL_AURA_MOD_ATTACK_POWER_OF_STAT_PERCENT
    &AuraEffect::HandleNoImmediateEffect,                         //269 SPELL_AURA_MOD_IGNORE_TARGET_RESIST implemented in Unit::CalcAbsorbResist and CalcArmorReducedDamage
    &AuraEffect::HandleNoImmediateEffect,                         //270 SPELL_AURA_MOD_ABILITY_IGNORE_TARGET_RESIST implemented in Unit::CalcAbsorbResist and CalcArmorReducedDamage
    &AuraEffect::HandleNoImmediateEffect,                         //271 SPELL_AURA_MOD_DAMAGE_FROM_CASTER    implemented in Unit::SpellDamageBonus
    &AuraEffect::HandleNoImmediateEffect,                         //272 SPELL_AURA_IGNORE_MELEE_RESET
    &AuraEffect::HandleUnused,                                    //273 clientside
    &AuraEffect::HandleNoImmediateEffect,                         //274 SPELL_AURA_CONSUME_NO_AMMO implemented in spell::CalculateDamageDoneForAllTargets
    &AuraEffect::HandleNoImmediateEffect,                         //275 SPELL_AURA_MOD_IGNORE_SHAPESHIFT Use SpellClassMask for spell select
    &AuraEffect::HandleNULL,                                      //276 mod damage % mechanic?
    &AuraEffect::HandleNoImmediateEffect,                         //277 SPELL_AURA_MOD_ABILITY_AFFECTED_TARGETS implemented in spell::settargetmap
    &AuraEffect::HandleAuraModDisarm,                             //278 SPELL_AURA_MOD_DISARM_RANGED disarm ranged weapon
    &AuraEffect::HandleNoImmediateEffect,                         //279 SPELL_AURA_INITIALIZE_IMAGES
    &AuraEffect::HandleNoImmediateEffect,                         //280 SPELL_AURA_MOD_TARGET_ARMOR_PCT
    &AuraEffect::HandleNoImmediateEffect,                         //281 SPELL_AURA_MOD_HONOR_GAIN_PCT implemented in Player::RewardHonor
    &AuraEffect::HandleAuraIncreaseBaseHealthPercent,             //282 SPELL_AURA_INCREASE_BASE_HEALTH_PERCENT
    &AuraEffect::HandleNoImmediateEffect,                         //283 SPELL_AURA_MOD_HEALING_RECEIVED       implemented in Unit::SpellHealingBonus
    &AuraEffect::HandleAuraLinked,                                //284 SPELL_AURA_LINKED
    &AuraEffect::HandleAuraModAttackPowerOfArmor,                 //285 SPELL_AURA_MOD_ATTACK_POWER_OF_ARMOR  implemented in Player::UpdateAttackPowerAndDamage
    &AuraEffect::HandleNoImmediateEffect,                         //286 SPELL_AURA_ABILITY_PERIODIC_CRIT implemented in AuraEffect::PeriodicTick
    &AuraEffect::HandleNoImmediateEffect,                         //287 SPELL_AURA_DEFLECT_SPELLS             implemented in Unit::MagicSpellHitResult and Unit::MeleeSpellHitResult
    &AuraEffect::HandleNoImmediateEffect,                         //288 SPELL_AURA_IGNORE_HIT_DIRECTION  implemented in Unit::MagicSpellHitResult and Unit::MeleeSpellHitResult Unit::RollMeleeOutcomeAgainst
    &AuraEffect::HandleNoImmediateEffect,                         //289 SPELL_AURA_PREVENT_DURABILITY_LOSS implemented in Player::DurabilityPointsLoss
    &AuraEffect::HandleAuraModCritPct,                            //290 SPELL_AURA_MOD_CRIT_PCT
    &AuraEffect::HandleNoImmediateEffect,                         //291 SPELL_AURA_MOD_XP_QUEST_PCT  implemented in Player::RewardQuest
    &AuraEffect::HandleAuraOpenStable,                            //292 SPELL_AURA_OPEN_STABLE
    &AuraEffect::HandleAuraOverrideSpells,                        //293 auras which probably add set of abilities to their target based on it's miscvalue
    &AuraEffect::HandleModManaRegen,                              //294 SPELL_AURA_PREVENT_REGENERATE_POWER implemented in Player::Regenerate(Powers power), HandleModManaRegen to refresh regeneration clientside
    &AuraEffect::HandleNULL,                                      //295 0 spells in 3.3.5
    &AuraEffect::HandleAuraSetVehicle,                            //296 SPELL_AURA_SET_VEHICLE_ID sets vehicle on target
    &AuraEffect::HandleNULL,                                      //297 Spirit Burst spells
    &AuraEffect::HandleNULL,                                      //298 70569 - Strangulating, maybe prevents talk or cast
    &AuraEffect::HandleNULL,                                      //299 unused
    &AuraEffect::HandleNoImmediateEffect,                         //300 SPELL_AURA_SHARE_DAMAGE_PCT implemented in Unit::DealDamage
    &AuraEffect::HandleNoImmediateEffect,                         //301 SPELL_AURA_SCHOOL_HEAL_ABSORB implemented in Unit::CalcHealAbsorb
    &AuraEffect::HandleNULL,                                      //302 0 spells in 3.3.5
    &AuraEffect::HandleNoImmediateEffect,                         //303 SPELL_AURA_MOD_DAMAGE_DONE_VERSUS_AURASTATE implemented in Unit::SpellDamageBonus, Unit::MeleeDamageBonus
    &AuraEffect::HandleAuraModFakeInebriation,                    //304 SPELL_AURA_MOD_FAKE_INEBRIATE
    &AuraEffect::HandleAuraModIncreaseSpeed,                      //305 SPELL_AURA_MOD_MINIMUM_SPEED
    &AuraEffect::HandleNULL,                                      //306 0 spells in 3.3.5
    &AuraEffect::HandleNULL,                                      //307 0 spells in 3.3.5
    &AuraEffect::HandleNoImmediateEffect,                         //308 SPELL_AURA_MOD_CRIT_CHANCE_FOR_CASTER implemented in Unit::isSpellCrit, ObjectAccessor::GetUnitCriticalChance
    &AuraEffect::HandleNULL,                                      //309 0 spells in 3.3.5
    &AuraEffect::HandleNoImmediateEffect,                         //310 SPELL_AURA_MOD_CREATURE_AOE_DAMAGE_AVOIDANCE implemented in Spell::CalculateDamageDone
    &AuraEffect::HandleNULL,                                      //311 0 spells in 3.3.5
    &AuraEffect::HandleNULL,                                      //312 0 spells in 3.3.5
    &AuraEffect::HandleNULL,                                      //313 0 spells in 3.3.5
    &AuraEffect::HandlePreventResurrection,                       //314 SPELL_AURA_PREVENT_RESURRECTION todo
    &AuraEffect::HandleNoImmediateEffect,                         //315 SPELL_AURA_UNDERWATER_WALKING todo
    &AuraEffect::HandleNoImmediateEffect,                         //316 SPELL_AURA_PERIODIC_HASTE implemented in AuraEffect::CalculatePeriodic
};

AuraEffect::AuraEffect(Aura* base, uint8 effIndex, int32* baseAmount, Unit* caster):
    m_base(base), m_spellInfo(base->GetSpellInfo()),
    m_baseAmount(baseAmount ? * baseAmount : m_spellInfo->Effects[effIndex].BasePoints), m_dieSides(m_spellInfo->Effects[effIndex].DieSides),
    m_critChance(0), m_oldAmount(0), m_isAuraEnabled(true), m_channelData(nullptr), m_spellmod(nullptr), m_periodicTimer(0), m_tickNumber(0), m_effIndex(effIndex),
    m_canBeRecalculated(true), m_isPeriodic(false)
{
    CalculatePeriodic(caster, true, false);
    CalculatePeriodicData();

    m_amount = CalculateAmount(caster);
    m_casterLevel = caster ? caster->GetLevel() : 0;
    m_applyResilience = caster && caster->CanApplyResilience();
    m_auraGroup = sSpellMgr->GetSpellGroup(GetId());

    CalculateSpellMod();

    // Xinef: channel data structure
    if (caster)
        if (Spell* spell = caster->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            m_channelData = new ChannelTargetData(caster->GetGuidValue(UNIT_FIELD_CHANNEL_OBJECT), spell->m_targets.HasDst() ? spell->m_targets.GetDst() : nullptr);
}

AuraEffect::~AuraEffect()
{
    delete m_spellmod;
    delete m_channelData;
}

void AuraEffect::GetTargetList(std::list<Unit*>& targetList) const
{
    Aura::ApplicationMap const& targetMap = GetBase()->GetApplicationMap();
    // remove all targets which were not added to new list - they no longer deserve area aura
    for (Aura::ApplicationMap::const_iterator appIter = targetMap.begin(); appIter != targetMap.end(); ++appIter)
    {
        if (appIter->second->HasEffect(GetEffIndex()))
            targetList.push_back(appIter->second->GetTarget());
    }
}

void AuraEffect::GetApplicationList(std::list<AuraApplication*>& applicationList) const
{
    Aura::ApplicationMap const& targetMap = GetBase()->GetApplicationMap();
    for (Aura::ApplicationMap::const_iterator appIter = targetMap.begin(); appIter != targetMap.end(); ++appIter)
    {
        if (appIter->second->HasEffect(GetEffIndex()))
            applicationList.push_back(appIter->second);
    }
}

uint32 AuraEffect::GetId() const
{
    return m_spellInfo->Id;
}

int32 AuraEffect::GetMiscValueB() const
{
    return m_spellInfo->Effects[m_effIndex].MiscValueB;
}

int32 AuraEffect::GetMiscValue() const
{
    return m_spellInfo->Effects[m_effIndex].MiscValue;
}

AuraType AuraEffect::GetAuraType() const
{
    return (AuraType)m_spellInfo->Effects[m_effIndex].ApplyAuraName;
}

int32 AuraEffect::CalculateAmount(Unit* caster)
{
    int32 amount;
    // default amount calculation
    amount = m_spellInfo->Effects[m_effIndex].CalcValue(caster, &m_baseAmount, nullptr);

    // check item enchant aura cast
    if (!amount && caster)
        if (ObjectGuid itemGUID = GetBase()->GetCastItemGUID())
            if (Player* playerCaster = caster->ToPlayer())
                if (Item* castItem = playerCaster->GetItemByGuid(itemGUID))
                    if (castItem->GetItemSuffixFactor())
                    {
                        ItemRandomSuffixEntry const* item_rand_suffix = sItemRandomSuffixStore.LookupEntry(std::abs(castItem->GetItemRandomPropertyId()));
                        if (item_rand_suffix)
                        {
                            for (uint8 k = 0; k < MAX_ITEM_ENCHANTMENT_EFFECTS; k++)
                            {
                                SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(item_rand_suffix->Enchantment[k]);
                                if (pEnchant)
                                {
                                    for (uint8 t = 0; t < MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS; t++)
                                        if (pEnchant->spellid[t] == m_spellInfo->Id)
                                        {
                                            amount = uint32((item_rand_suffix->AllocationPct[k] * castItem->GetItemSuffixFactor()) / 10000);
                                            break;
                                        }
                                }

                                if (amount)
                                    break;
                            }
                        }
                    }

    // custom amount calculations go here
    // xinef: normal auras
    switch (GetAuraType())
    {
        // crowd control auras
        case SPELL_AURA_MOD_CONFUSE:
        case SPELL_AURA_MOD_FEAR:
        case SPELL_AURA_MOD_STUN:
        case SPELL_AURA_MOD_ROOT:
        case SPELL_AURA_TRANSFORM:
            m_canBeRecalculated = false;
            if (!m_spellInfo->ProcFlags || m_spellInfo->HasAura(SPELL_AURA_PROC_TRIGGER_SPELL)) // xinef: skip auras with proctriggerspell, they must have procflags...
                break;
            amount = int32(GetBase()->GetUnitOwner()->CountPctFromMaxHealth(10));
            if (caster)
            {
                // Glyphs increasing damage cap
                Unit::AuraEffectList const& overrideClassScripts = caster->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
                for (Unit::AuraEffectList::const_iterator itr = overrideClassScripts.begin(); itr != overrideClassScripts.end(); ++itr)
                {
                    if ((*itr)->IsAffectedOnSpell(m_spellInfo))
                    {
                        // Glyph of Fear, Glyph of Frost nova and similar auras
                        if ((*itr)->GetMiscValue() == 7801)
                        {
                            AddPct(amount, (*itr)->GetAmount());
                            break;
                        }
                    }
                }
            }
            break;
        case SPELL_AURA_SCHOOL_ABSORB:
        case SPELL_AURA_MANA_SHIELD:
            m_canBeRecalculated = false;
            break;
        case SPELL_AURA_MOD_DAMAGE_PERCENT_DONE:
            // Titan's Grip
            if (!caster)
                break;
            if (GetId() == 49152 && caster->ToPlayer())
            {
                Item* item1 = caster->ToPlayer()->GetWeaponForAttack(BASE_ATTACK);
                Item* item2 = caster->ToPlayer()->GetWeaponForAttack(OFF_ATTACK);

                if (!item2)
                    item2 = caster->ToPlayer()->GetShield();

                if (item1 && item2
                    && (item1->GetTemplate()->InventoryType == INVTYPE_2HWEAPON || item2->GetTemplate()->InventoryType == INVTYPE_2HWEAPON))
                {
                    amount = -10;
                }
                else
                    amount = 0;
            }
            break;
        default:
            break;
    }

    // xinef: save base amount, before calculating sp etc. Used for Unit::CastDelayedSpellWithPeriodicAmount
    SetOldAmount(amount * GetBase()->GetStackAmount());
    GetBase()->CallScriptEffectCalcAmountHandlers(this, amount, m_canBeRecalculated);

    // Xinef: Periodic auras
    if (caster)
        switch (GetAuraType())
        {
            case SPELL_AURA_PERIODIC_DAMAGE:
            case SPELL_AURA_PERIODIC_LEECH:
                // xinef: save caster depending auras, always pass 1 as stack amount, effect will be multiplicated at the end of the function by correct value!
                if (GetBase()->GetType() == UNIT_AURA_TYPE)
                    amount = caster->SpellDamageBonusDone(GetBase()->GetUnitOwner(), GetSpellInfo(), amount, DOT, GetEffIndex(), GetPctMods(), 1);
                break;
            case SPELL_AURA_PERIODIC_HEAL:
                if (GetBase()->GetType() == UNIT_AURA_TYPE)
                    amount = caster->SpellHealingBonusDone(GetBase()->GetUnitOwner(), GetSpellInfo(), amount, DOT, GetEffIndex(), GetPctMods(), 1);
                break;
            case SPELL_AURA_DAMAGE_SHIELD:
                if (GetBase()->GetType() == UNIT_AURA_TYPE)
                    amount = caster->SpellDamageBonusDone(GetBase()->GetUnitOwner(), GetSpellInfo(), amount, SPELL_DIRECT_DAMAGE, 0.0f, 1);
                break;
            default:
                break;
        }

    amount *= GetBase()->GetStackAmount();
    return amount;
}

void AuraEffect::CalculatePeriodicData()
{
    // xinef: save caster depending auras with pct mods
    if (GetBase()->GetType() == UNIT_AURA_TYPE && GetCaster())
    {
        if (m_spellInfo->HasAura(SPELL_AURA_PERIODIC_HEAL))
            m_pctMods = GetCaster()->SpellPctHealingModsDone(GetBase()->GetUnitOwner(), GetSpellInfo(), DOT);
        else if (m_spellInfo->HasAura(SPELL_AURA_PERIODIC_DAMAGE) || m_spellInfo->HasAura(SPELL_AURA_PERIODIC_LEECH))
            m_pctMods = GetCaster()->SpellPctDamageModsDone(GetBase()->GetUnitOwner(), GetSpellInfo(), DOT);
    }

    if (GetCaster())
        SetCritChance(CalcPeriodicCritChance(GetCaster(), (GetBase()->GetType() == UNIT_AURA_TYPE ? GetBase()->GetUnitOwner() : nullptr)));
}

void AuraEffect::CalculatePeriodic(Unit* caster, bool create, bool load)
{
    m_amplitude = m_spellInfo->Effects[m_effIndex].Amplitude;

    // prepare periodics
    switch (GetAuraType())
    {
        case SPELL_AURA_OBS_MOD_POWER:
            // 3 spells have no amplitude set
            if (!m_amplitude)
                m_amplitude = 1 * IN_MILLISECONDS;
            [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
        case SPELL_AURA_PERIODIC_DAMAGE:
        case SPELL_AURA_PERIODIC_HEAL:
        case SPELL_AURA_OBS_MOD_HEALTH:
        case SPELL_AURA_PERIODIC_TRIGGER_SPELL:
        case SPELL_AURA_PERIODIC_TRIGGER_SPELL_FROM_CLIENT:
        case SPELL_AURA_PERIODIC_ENERGIZE:
        case SPELL_AURA_PERIODIC_LEECH:
        case SPELL_AURA_PERIODIC_HEALTH_FUNNEL:
        case SPELL_AURA_PERIODIC_MANA_LEECH:
        case SPELL_AURA_PERIODIC_DAMAGE_PERCENT:
        case SPELL_AURA_POWER_BURN:
        case SPELL_AURA_PERIODIC_DUMMY:
        case SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE:
            m_isPeriodic = true;
            break;
        default:
            break;
    }

    GetBase()->CallScriptEffectCalcPeriodicHandlers(this, m_isPeriodic, m_amplitude);

    if (!m_isPeriodic)
        return;

    // Xinef: fix broken data in dbc
    if (m_amplitude <= 0)
        m_amplitude = 1000;

    Player* modOwner = caster ? caster->GetSpellModOwner() : nullptr;

    // Apply casting time mods
    if (m_amplitude)
    {
        // Apply periodic time mod
        if (modOwner)
            modOwner->ApplySpellMod(GetId(), SPELLMOD_ACTIVATION_TIME, m_amplitude);

        if (caster)
        {
            if (caster->HasAuraTypeWithAffectMask(SPELL_AURA_PERIODIC_HASTE, m_spellInfo) || m_spellInfo->HasAttribute(SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC))
                m_amplitude = int32(m_amplitude * caster->GetFloatValue(UNIT_MOD_CAST_SPEED));
        }
    }

    if (load) // aura loaded from db
    {
        m_tickNumber = m_amplitude ? GetBase()->GetDuration() / m_amplitude : 0;
        m_periodicTimer = m_amplitude ? GetBase()->GetDuration() % m_amplitude : 0;
        if (m_spellInfo->HasAttribute(SPELL_ATTR5_EXTRA_INITIAL_PERIOD))
            ++m_tickNumber;
    }
    else // aura just created or reapplied
    {
        m_tickNumber = 0;
        // reset periodic timer on aura create or on reapply when aura isn't dot
        // possibly we should not reset periodic timers only when aura is triggered by proc
        // or maybe there's a spell attribute somewhere
        bool resetPeriodicTimer = create
                                  || ((GetAuraType() != SPELL_AURA_PERIODIC_DAMAGE) && (GetAuraType() != SPELL_AURA_PERIODIC_DAMAGE_PERCENT));

        if (resetPeriodicTimer)
        {
            m_periodicTimer = 0;
            // Start periodic on next tick or at aura apply
            if (m_amplitude)
            {
                if (!GetSpellInfo()->HasAttribute(SPELL_ATTR5_EXTRA_INITIAL_PERIOD))
                    m_periodicTimer += m_amplitude;
                else if (caster && caster->IsTotem()) // for totems only ;d
                {
                    m_periodicTimer = 100; // make it ALMOST instant
                    if (!GetBase()->IsPassive())
                        GetBase()->SetDuration(GetBase()->GetDuration() + 100);
                }
            }
        }
    }
}

void AuraEffect::CalculateSpellMod()
{
    switch (GetAuraType())
    {
        case SPELL_AURA_ADD_FLAT_MODIFIER:
        case SPELL_AURA_ADD_PCT_MODIFIER:
            if (!m_spellmod)
            {
                m_spellmod = new SpellModifier(GetBase());
                m_spellmod->op = SpellModOp(GetMiscValue());

                m_spellmod->type = SpellModType(GetAuraType()); // SpellModType value == spell aura types
                m_spellmod->spellId = GetId();
                m_spellmod->mask = GetSpellInfo()->Effects[GetEffIndex()].SpellClassMask;
                m_spellmod->charges = GetBase()->GetCharges();
            }
            m_spellmod->value = GetAmount();
            break;
        default:
            break;
    }
    GetBase()->CallScriptEffectCalcSpellModHandlers(this, m_spellmod);
}

void AuraEffect::ChangeAmount(int32 newAmount, bool mark, bool onStackOrReapply)
{
    // Reapply if amount change
    uint8 handleMask = 0;
    if (newAmount != GetAmount())
        handleMask |= AURA_EFFECT_HANDLE_CHANGE_AMOUNT;
    if (onStackOrReapply)
        handleMask |= AURA_EFFECT_HANDLE_REAPPLY;

    if (!handleMask)
        return;

    std::list<AuraApplication*> effectApplications;
    GetApplicationList(effectApplications);

    for (std::list<AuraApplication*>::const_iterator apptItr = effectApplications.begin(); apptItr != effectApplications.end(); ++apptItr)
        if ((*apptItr)->HasEffect(GetEffIndex()))
            HandleEffect(*apptItr, handleMask, false);

    if (handleMask & AURA_EFFECT_HANDLE_CHANGE_AMOUNT)
    {
        if (!mark)
            m_amount = newAmount;
        else
            SetAmount(newAmount);
        CalculateSpellMod();
    }

    for (std::list<AuraApplication*>::const_iterator apptItr = effectApplications.begin(); apptItr != effectApplications.end(); ++apptItr)
        if ((*apptItr)->HasEffect(GetEffIndex()))
            HandleEffect(*apptItr, handleMask, true);
}

void AuraEffect::HandleEffect(AuraApplication* aurApp, uint8 mode, bool apply)
{
    // check if call is correct, we really don't want using bitmasks here (with 1 exception)
    ASSERT(mode == AURA_EFFECT_HANDLE_REAL
           || mode == AURA_EFFECT_HANDLE_SEND_FOR_CLIENT
           || mode == AURA_EFFECT_HANDLE_CHANGE_AMOUNT
           || mode == AURA_EFFECT_HANDLE_STAT
           || mode == AURA_EFFECT_HANDLE_SKILL
           || mode == AURA_EFFECT_HANDLE_REAPPLY
           || mode == (AURA_EFFECT_HANDLE_CHANGE_AMOUNT | AURA_EFFECT_HANDLE_REAPPLY));

    // register/unregister effect in lists in case of real AuraEffect apply/remove
    // registration/unregistration is done always before real effect handling (some effect handlers code is depending on this)
    if (mode & AURA_EFFECT_HANDLE_REAL)
        aurApp->GetTarget()->_RegisterAuraEffect(this, apply);

    // xinef: stacking system, force return if effect is disabled, prevents double apply / unapply
    // xinef: placed here so above line can unregister effect from the list
    // xinef: this condition works under assumption that effect handlers performs ALL necessery action with CHANGE_AMOUNT mode
    // xinef: as far as i've checked, all grouped spells meet this condition
    if (!aurApp->IsActive(GetEffIndex()))
        return;

    // real aura apply/remove, handle modifier
    if (mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK)
        ApplySpellMod(aurApp->GetTarget(), apply);

    // call scripts helping/replacing effect handlers
    bool prevented = false;
    if (apply)
        prevented = GetBase()->CallScriptEffectApplyHandlers(this, const_cast<AuraApplication const*>(aurApp), (AuraEffectHandleModes)mode);
    else
        prevented = GetBase()->CallScriptEffectRemoveHandlers(this, const_cast<AuraApplication const*>(aurApp), (AuraEffectHandleModes)mode);

    // check if script events have removed the aura or if default effect prevention was requested
    if ((apply && aurApp->GetRemoveMode()) || prevented)
        return;

    (*this.*AuraEffectHandler [GetAuraType()])(aurApp, mode, apply);

    // check if script events have removed the aura or if default effect prevention was requested
    if (apply && aurApp->GetRemoveMode())
        return;

    // call scripts triggering additional events after apply/remove
    if (apply)
        GetBase()->CallScriptAfterEffectApplyHandlers(this, aurApp, (AuraEffectHandleModes)mode);
    else
        GetBase()->CallScriptAfterEffectRemoveHandlers(this, aurApp, (AuraEffectHandleModes)mode);
}

void AuraEffect::HandleEffect(Unit* target, uint8 mode, bool apply)
{
    AuraApplication* aurApp = GetBase()->GetApplicationOfTarget(target->GetGUID());
    ASSERT(aurApp);
    HandleEffect(aurApp, mode, apply);
}

void AuraEffect::ApplySpellMod(Unit* target, bool apply)
{
    if (!m_spellmod || target->GetTypeId() != TYPEID_PLAYER)
        return;

    target->ToPlayer()->AddSpellMod(m_spellmod, apply);

    // Auras with charges do not mod amount of passive auras
    if (GetBase()->IsUsingCharges())
        return;
    // reapply some passive spells after add/remove related spellmods
    // Warning: it is a dead loop if 2 auras each other amount-shouldn't happen
    switch (GetMiscValue())
    {
        case SPELLMOD_ALL_EFFECTS:
        case SPELLMOD_EFFECT1:
        case SPELLMOD_EFFECT2:
        case SPELLMOD_EFFECT3:
            {
                ObjectGuid guid = target->GetGUID();
                Unit::AuraApplicationMap& auras = target->GetAppliedAuras();
                for (Unit::AuraApplicationMap::iterator iter = auras.begin(); iter != auras.end(); ++iter)
                {
                    Aura* aura = iter->second->GetBase();
                    // only passive and permament auras-active auras should have amount set on spellcast and not be affected
                    // if aura is casted by others, it will not be affected
                    if ((aura->IsPassive() || aura->IsPermanent()) && aura->GetCasterGUID() == guid && aura->GetSpellInfo()->IsAffectedBySpellMod(m_spellmod))
                    {
                        if (GetMiscValue() == SPELLMOD_ALL_EFFECTS)
                        {
                            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                            {
                                if (AuraEffect* aurEff = aura->GetEffect(i))
                                    aurEff->RecalculateAmount();
                            }
                        }
                        else if (GetMiscValue() == SPELLMOD_EFFECT1)
                        {
                            if (AuraEffect* aurEff = aura->GetEffect(0))
                                aurEff->RecalculateAmount();
                        }
                        else if (GetMiscValue() == SPELLMOD_EFFECT2)
                        {
                            if (AuraEffect* aurEff = aura->GetEffect(1))
                                aurEff->RecalculateAmount();
                        }
                        else //if (modOp == SPELLMOD_EFFECT3)
                        {
                            if (AuraEffect* aurEff = aura->GetEffect(2))
                                aurEff->RecalculateAmount();
                        }
                    }
                }

                Pet* pet = target->ToPlayer()->GetPet();
                if (!pet)
                    break;

                ObjectGuid petguid = pet->GetGUID();
                Unit::AuraApplicationMap& petauras = pet->GetAppliedAuras();
                for (Unit::AuraApplicationMap::iterator iter = petauras.begin(); iter != petauras.end(); ++iter)
                {
                    Aura* aura = iter->second->GetBase();
                    // only passive auras-active auras should have amount set on spellcast and not be affected
                    // if aura is casted by others, it will not be affected
                    if ((aura->IsPassive() || aura->IsPermanent()) && aura->GetCasterGUID() == petguid && aura->GetSpellInfo()->IsAffectedBySpellMod(m_spellmod))
                    {
                        if (GetMiscValue() == SPELLMOD_ALL_EFFECTS)
                        {
                            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                            {
                                if (AuraEffect* aurEff = aura->GetEffect(i))
                                    aurEff->RecalculateAmount();
                            }
                        }
                        else if (GetMiscValue() == SPELLMOD_EFFECT1)
                        {
                            if (AuraEffect* aurEff = aura->GetEffect(0))
                                aurEff->RecalculateAmount();
                        }
                        else if (GetMiscValue() == SPELLMOD_EFFECT2)
                        {
                            if (AuraEffect* aurEff = aura->GetEffect(1))
                                aurEff->RecalculateAmount();
                        }
                        else //if (modOp == SPELLMOD_EFFECT3)
                        {
                            if (AuraEffect* aurEff = aura->GetEffect(2))
                                aurEff->RecalculateAmount();
                        }
                    }
                }
            }
        default:
            break;
    }
}

void AuraEffect::Update(uint32 diff, Unit* caster)
{
    if (m_isPeriodic && (GetBase()->GetDuration() >= 0 || GetBase()->IsPassive() || GetBase()->IsPermanent()))
    {
        uint32 totalTicks = GetTotalTicks();

        m_periodicTimer -= int32(diff);
        while (m_periodicTimer <= 0)
        {
            if (!GetBase()->IsPermanent() && (m_tickNumber + 1) > totalTicks)
            {
                break;
            }

            ++m_tickNumber;

            // update before tick (aura can be removed in TriggerSpell or PeriodicTick calls)
            m_periodicTimer += m_amplitude;
            UpdatePeriodic(caster);

            std::list<AuraApplication*> effectApplications;
            GetApplicationList(effectApplications);
            // tick on targets of effects
            for (std::list<AuraApplication*>::const_iterator apptItr = effectApplications.begin(); apptItr != effectApplications.end(); ++apptItr)
                if ((*apptItr)->HasEffect(GetEffIndex()))
                    PeriodicTick(*apptItr, caster);
        }
    }
}

void AuraEffect::UpdatePeriodic(Unit* caster)
{
    switch (GetAuraType())
    {
        case SPELL_AURA_PERIODIC_DUMMY:
            switch (GetSpellInfo()->SpellFamilyName)
            {
                case SPELLFAMILY_GENERIC:
                    switch (GetId())
                    {
                        // Drink
                        case 430:
                        case 431:
                        case 432:
                        case 1133:
                        case 1135:
                        case 1137:
                        case 10250:
                        case 22734:
                        case 27089:
                        case 34291:
                        case 43182:
                        case 43183:
                        case 46755:
                        case 49472: // Drink Coffee
                        case 57073:
                        case 61830:
                            //npcbot
                            if (caster && caster->IsNPCBot())
                            {
                                if (AuraEffect* aurEff = GetBase()->GetEffect(EFFECT_0))
                                {
                                    if (aurEff->GetAuraType() == SPELL_AURA_MOD_POWER_REGEN)
                                    {
                                        aurEff->ChangeAmount(GetAmount());
                                        m_isPeriodic = false;
                                    }
                                }
                                break;
                            }
                            //end npcbot

                            if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
                                return;
                            // Get SPELL_AURA_MOD_POWER_REGEN aura from spell
                            if (AuraEffect* aurEff = GetBase()->GetEffect(0))
                            {
                                if (aurEff->GetAuraType() != SPELL_AURA_MOD_POWER_REGEN)
                                {
                                    m_isPeriodic = false;
                                    LOG_ERROR("spells.aura.effect", "Aura {} structure has been changed - first aura is no longer SPELL_AURA_MOD_POWER_REGEN", GetId());
                                }
                                else
                                {
                                    // default case - not in arena
                                    if (!caster->ToPlayer()->InArena())
                                    {
                                        aurEff->ChangeAmount(GetAmount());
                                        m_isPeriodic = false;
                                    }
                                    else
                                    {
                                        // **********************************************
                                        // This feature uses only in arenas
                                        // **********************************************
                                        // Here need increase mana regen per tick (6 second rule)
                                        // on 0 tick -   0  (handled in 2 second)
                                        // on 1 tick - 166% (handled in 4 second)
                                        // on 2 tick - 133% (handled in 6 second)

                                        // Apply bonus for 1 - 4 tick
                                        switch (m_tickNumber)
                                        {
                                            case 1:   // 0%
                                                aurEff->ChangeAmount(0);
                                                break;
                                            case 2:   // 166%
                                                aurEff->ChangeAmount(GetAmount() * 5 / 3);
                                                break;
                                            case 3:   // 133%
                                                aurEff->ChangeAmount(GetAmount() * 4 / 3);
                                                break;
                                            default:  // 100% - normal regen
                                                aurEff->ChangeAmount(GetAmount());
                                                // No need to update after 4th tick
                                                m_isPeriodic = false;
                                                break;
                                        }
                                    }
                                }
                            }
                            break;
                        case 58549: // Tenacity
                        case 59911: // Tenacity (vehicle)
                            GetBase()->RefreshDuration();
                            break;
                        case 66823:
                        case 67618:
                        case 67619:
                        case 67620: // Paralytic Toxin
                            // Get 0 effect aura
                            if (AuraEffect* slow = GetBase()->GetEffect(0))
                            {
                                int32 newAmount = slow->GetAmount() - 10;
                                if (newAmount < -100)
                                    newAmount = -100;
                                slow->ChangeAmount(newAmount);
                            }
                            break;
                        case 66020:
                            // Get 0 effect aura
                            if (AuraEffect* slow = GetBase()->GetEffect(0))
                            {
                                int32 newAmount = slow->GetAmount() + GetAmount();
                                if (newAmount > 0)
                                    newAmount = 0;
                                slow->ChangeAmount(newAmount);
                            }
                            break;
                        default:
                            break;
                    }
                    break;
                default:
                    break;
            }
        default:
            break;
    }
    GetBase()->CallScriptEffectUpdatePeriodicHandlers(this);
}

float AuraEffect::CalcPeriodicCritChance(Unit const* caster, Unit const* target) const
{
    float critChance = 0.0f;
    if (caster)
    {
        //npcbot
        if (caster->IsNPCBotOrPet())
        {
            Unit::AuraEffectList const& mPeriodicCritAuras = caster->GetAuraEffectsByType(SPELL_AURA_ABILITY_PERIODIC_CRIT);
            for (Unit::AuraEffectList::const_iterator itr = mPeriodicCritAuras.begin(); itr != mPeriodicCritAuras.end(); ++itr)
            {
                if ((*itr)->IsAffectedOnSpell(GetSpellInfo()))
                {
                    critChance = caster->SpellDoneCritChance(nullptr, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), (GetSpellInfo()->DmgClass == SPELL_DAMAGE_CLASS_RANGED ? RANGED_ATTACK : BASE_ATTACK), true);
                    break;
                }
            }

            switch(GetSpellInfo()->SpellFamilyName)
            {
                // Rupture - since 3.3.3 can crit
                case SPELLFAMILY_ROGUE:
                    if (GetSpellInfo()->SpellFamilyFlags[0] & 0x100000)
                        critChance = caster->SpellDoneCritChance(nullptr, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), BASE_ATTACK, true);
                    break;
            }
        }
        //end npcbot
        if (Player* modOwner = caster->GetSpellModOwner())
        {
            Unit::AuraEffectList const& mPeriodicCritAuras = modOwner->GetAuraEffectsByType(SPELL_AURA_ABILITY_PERIODIC_CRIT);
            for (Unit::AuraEffectList::const_iterator itr = mPeriodicCritAuras.begin(); itr != mPeriodicCritAuras.end(); ++itr)
            {
                if ((*itr)->IsAffectedOnSpell(GetSpellInfo()))
                {
                    critChance = modOwner->SpellDoneCritChance(nullptr, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), (GetSpellInfo()->DmgClass == SPELL_DAMAGE_CLASS_RANGED ? RANGED_ATTACK : BASE_ATTACK), true);
                    break;
                }
            }

            switch(GetSpellInfo()->SpellFamilyName)
            {
                // Rupture - since 3.3.3 can crit
                case SPELLFAMILY_ROGUE:
                    if (GetSpellInfo()->SpellFamilyFlags[0] & 0x100000)
                        critChance = modOwner->SpellDoneCritChance(nullptr, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), BASE_ATTACK, true);
                    break;
            }
        }
    }
    if (target && critChance > 0.0f)
        critChance = target->SpellTakenCritChance(caster, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), critChance, BASE_ATTACK, true);

    return std::max(0.0f, critChance);
}

bool AuraEffect::IsAffectedOnSpell(SpellInfo const* spell) const
{
    if (!spell)
        return false;
    // Check family name
    if (spell->SpellFamilyName != m_spellInfo->SpellFamilyName)
        return false;

    // Check EffectClassMask
    if (m_spellInfo->Effects[m_effIndex].SpellClassMask & spell->SpellFamilyFlags)
        return true;
    return false;
}

bool AuraEffect::HasSpellClassMask() const
{
    return m_spellInfo->Effects[m_effIndex].SpellClassMask;
}

void AuraEffect::SendTickImmune(Unit* target, Unit* caster) const
{
    if (caster)
        caster->SendSpellDamageImmune(target, m_spellInfo->Id);
}

void AuraEffect::PeriodicTick(AuraApplication* aurApp, Unit* caster) const
{
    bool prevented = GetBase()->CallScriptEffectPeriodicHandlers(this, aurApp);
    if (prevented)
        return;

    Unit* target = aurApp->GetTarget();

    // Update serverside orientation of tracking channeled auras on periodic update ticks
    // exclude players because can turn during channeling and shouldn't desync orientation client/server
    if (caster && !caster->IsPlayer() && m_spellInfo->IsChanneled() && m_spellInfo->HasAttribute(SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL))
    {
        ObjectGuid const channelGuid = caster->GetGuidValue(UNIT_FIELD_CHANNEL_OBJECT);
        if (!channelGuid.IsEmpty() && channelGuid != caster->GetGUID())
        {
            if (WorldObject const* objectTarget = ObjectAccessor::GetWorldObject(*caster, channelGuid))
            {
                caster->SetInFront(objectTarget);
            }
        }
    }

    switch (GetAuraType())
    {
        case SPELL_AURA_PERIODIC_DUMMY:
            HandlePeriodicDummyAuraTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_TRIGGER_SPELL:
            HandlePeriodicTriggerSpellAuraTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_TRIGGER_SPELL_FROM_CLIENT:
            // Don't actually do anything - client will trigger casts of these spells by itself
            break;
        case SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE:
            HandlePeriodicTriggerSpellWithValueAuraTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_DAMAGE:
        case SPELL_AURA_PERIODIC_DAMAGE_PERCENT:
            HandlePeriodicDamageAurasTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_LEECH:
            HandlePeriodicHealthLeechAuraTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_HEALTH_FUNNEL:
            HandlePeriodicHealthFunnelAuraTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_HEAL:
        case SPELL_AURA_OBS_MOD_HEALTH:
            HandlePeriodicHealAurasTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_MANA_LEECH:
            HandlePeriodicManaLeechAuraTick(target, caster);
            break;
        case SPELL_AURA_OBS_MOD_POWER:
            HandleObsModPowerAuraTick(target, caster);
            break;
        case SPELL_AURA_PERIODIC_ENERGIZE:
            HandlePeriodicEnergizeAuraTick(target, caster);
            break;
        case SPELL_AURA_POWER_BURN:
            HandlePeriodicPowerBurnAuraTick(target, caster);
            break;
        default:
            break;
    }
}

void AuraEffect::HandleProc(AuraApplication* aurApp, ProcEventInfo& eventInfo)
{
    bool prevented = GetBase()->CallScriptEffectProcHandlers(this, aurApp, eventInfo);
    if (prevented)
        return;

    switch (GetAuraType())
    {
        case SPELL_AURA_PROC_TRIGGER_SPELL:
            HandleProcTriggerSpellAuraProc(aurApp, eventInfo);
            break;
        case SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE:
            HandleProcTriggerSpellWithValueAuraProc(aurApp, eventInfo);
            break;
        case SPELL_AURA_PROC_TRIGGER_DAMAGE:
            HandleProcTriggerDamageAuraProc(aurApp, eventInfo);
            break;
        case SPELL_AURA_RAID_PROC_FROM_CHARGE:
            HandleRaidProcFromChargeAuraProc(aurApp, eventInfo);
            break;
        case SPELL_AURA_RAID_PROC_FROM_CHARGE_WITH_VALUE:
            HandleRaidProcFromChargeWithValueAuraProc(aurApp, eventInfo);
            break;
        default:
            break;
    }

    GetBase()->CallScriptAfterEffectProcHandlers(this, aurApp, eventInfo);
}

void AuraEffect::CleanupTriggeredSpells(Unit* target)
{
    uint32 tSpellId = m_spellInfo->Effects[GetEffIndex()].TriggerSpell;
    if (!tSpellId)
        return;

    SpellInfo const* tProto = sSpellMgr->GetSpellInfo(tSpellId);
    if (!tProto)
        return;

    if (tProto->GetDuration() != -1)
        return;

    // needed for spell 43680, maybe others
    /// @todo: is there a spell flag, which can solve this in a more sophisticated way?
    if (m_spellInfo->Effects[GetEffIndex()].ApplyAuraName == SPELL_AURA_PERIODIC_TRIGGER_SPELL &&
            uint32(m_spellInfo->GetDuration()) == m_spellInfo->Effects[GetEffIndex()].Amplitude)
        return;

    target->RemoveAurasDueToSpell(tSpellId, GetCasterGUID());
}

void AuraEffect::HandleShapeshiftBoosts(Unit* target, bool apply) const
{
    uint32 spellId = 0;
    uint32 spellId2 = 0;
    //uint32 spellId3 = 0;
    uint32 HotWSpellId = 0;

    switch (GetMiscValue())
    {
        case FORM_CAT:
            spellId = 3025;
            HotWSpellId = 24900;
            break;
        case FORM_TREE:
            spellId = 34123;
            break;
        case FORM_TRAVEL:
            spellId = 5419;
            break;
        case FORM_AQUA:
            spellId = 5421;
            break;
        case FORM_BEAR:
            spellId = 1178;
            spellId2 = 21178;
            HotWSpellId = 24899;
            break;
        case FORM_DIREBEAR:
            spellId = 9635;
            spellId2 = 21178;
            HotWSpellId = 24899;
            break;
        case FORM_BATTLESTANCE:
            spellId = 21156;
            break;
        case FORM_DEFENSIVESTANCE:
            spellId = 7376;
            break;
        case FORM_BERSERKERSTANCE:
            spellId = 7381;
            break;
        case FORM_MOONKIN:
            spellId = 24905;
            spellId2 = 69366;
            break;
        case FORM_FLIGHT:
            spellId = 33948;
            spellId2 = 34764;
            break;
        case FORM_FLIGHT_EPIC:
            spellId  = 40122;
            spellId2 = 40121;
            break;
        case FORM_METAMORPHOSIS:
            spellId  = 54817;
            spellId2 = 54879;
            break;
        case FORM_SPIRITOFREDEMPTION:
            spellId  = 27792;
            spellId2 = 27795;                               // must be second, this important at aura remove to prevent to early iterator invalidation.
            break;
        case FORM_SHADOW:
            spellId = 49868;
            spellId2 = 71167;
            break;
        case FORM_GHOSTWOLF:
            spellId = 67116;
            break;
        case FORM_GHOUL:
        case FORM_AMBIENT:
        case FORM_STEALTH:
        case FORM_CREATURECAT:
        case FORM_CREATUREBEAR:
            break;
        default:
            break;
    }

    Player* player = target->ToPlayer();
    if (apply)
    {
        // Remove cooldown of spells triggered on stance change - they may share cooldown with stance spell
        if (spellId)
        {
            if (player)
                player->RemoveSpellCooldown(spellId);
            target->CastSpell(target, spellId, true, nullptr, this, target->GetGUID());
        }

        if (spellId2)
        {
            if (player)
                player->RemoveSpellCooldown(spellId2);
            target->CastSpell(target, spellId2, true, nullptr, this, target->GetGUID());
        }

        if (player)
        {
            const PlayerSpellMap& sp_list = player->GetSpellMap();
            for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
            {
                if (itr->second->State == PLAYERSPELL_REMOVED || !itr->second->IsInSpec(player->GetActiveSpec()))
                    continue;

                if (itr->first == spellId || itr->first == spellId2)
                    continue;

                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
                if (!spellInfo || !spellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_DO_NOT_DISPLAY)))
                    continue;

                if (spellInfo->Stances & (1 << (GetMiscValue() - 1)))
                    target->CastSpell(target, itr->first, true, nullptr, this, target->GetGUID());
            }

            // xinef: talent stance auras are not on m_spells map, so iterate talents
            const PlayerTalentMap& tl_list = player->GetTalentMap();
            for (PlayerTalentMap::const_iterator itr = tl_list.begin(); itr != tl_list.end(); ++itr)
            {
                if (itr->second->State == PLAYERSPELL_REMOVED || !itr->second->IsInSpec(player->GetActiveSpec()))
                    continue;

                if (itr->first == spellId || itr->first == spellId2)
                    continue;

                // Xinef: skip talents with effect learn spell
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
                if (!spellInfo || !spellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_DO_NOT_DISPLAY)) || spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
                    continue;

                if (spellInfo->Stances & (1 << (GetMiscValue() - 1)))
                    target->CastSpell(target, itr->first, true, nullptr, this, target->GetGUID());
            }

            // Also do it for Glyphs
            for (uint32 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
            {
                if (uint32 glyphId = player->GetGlyph(i))
                {
                    if (GlyphPropertiesEntry const* glyph = sGlyphPropertiesStore.LookupEntry(glyphId))
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(glyph->SpellId);
                        if (!spellInfo || !spellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_DO_NOT_DISPLAY)))
                            continue;
                        if (spellInfo->Stances & (1 << (GetMiscValue() - 1)))
                            target->CastSpell(target, glyph->SpellId, TriggerCastFlags(TRIGGERED_FULL_MASK & ~(TRIGGERED_IGNORE_SHAPESHIFT | TRIGGERED_IGNORE_CASTER_AURASTATE)), nullptr, this, target->GetGUID());
                    }
                }
            }

            // Leader of the Pack
            if (player->HasTalent(17007, player->GetActiveSpec()))
            {
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(24932);
                if (spellInfo && spellInfo->Stances & (1 << (GetMiscValue() - 1)))
                    target->CastSpell(target, 24932, true, nullptr, this, target->GetGUID());
            }
            // Improved Barkskin - apply/remove armor bonus due to shapeshift
            if (player->HasTalent(63410, player->GetActiveSpec()) || player->HasTalent(63411, player->GetActiveSpec()))
            {
                target->RemoveAurasDueToSpell(66530);
                if (GetMiscValue() == FORM_TRAVEL || GetMiscValue() == FORM_NONE) // "while in Travel Form or while not shapeshifted"
                    target->CastSpell(target, 66530, true);
            }
            // Heart of the Wild
            if (HotWSpellId)
            {
                // hacky, but the only way as spell family is not SPELLFAMILY_DRUID
                Unit::AuraEffectList const& mModTotalStatPct = target->GetAuraEffectsByType(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE);
                for (Unit::AuraEffectList::const_iterator i = mModTotalStatPct.begin(); i != mModTotalStatPct.end(); ++i)
                {
                    // Heart of the Wild
                    if ((*i)->GetSpellInfo()->SpellIconID == 240 && (*i)->GetMiscValue() == STAT_INTELLECT)
                    {
                        int32 HotWMod = (*i)->GetAmount() / 2; // For each 2% Intelligence, you get 1% stamina and 1% attack power.

                        target->CastCustomSpell(target, HotWSpellId, &HotWMod, nullptr, nullptr, true, nullptr, this, target->GetGUID());
                        break;
                    }
                }
            }
            switch (GetMiscValue())
            {
                case FORM_CAT:
                    // Savage Roar
                    if (target->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_DRUID, 0, 0x10000000, 0))
                        target->CastSpell(target, 62071, true);
                    // Nurturing Instinct
                    if (AuraEffect const* aurEff = target->GetAuraEffect(SPELL_AURA_MOD_SPELL_HEALING_OF_STAT_PERCENT, SPELLFAMILY_DRUID, 2254, 0))
                    {
                        uint32 spellId3 = 0;
                        switch (aurEff->GetId())
                        {
                            case 33872:
                                spellId3 = 47179;
                                break;
                            case 33873:
                                spellId3 = 47180;
                                break;
                        }
                        target->CastSpell(target, spellId3, true, nullptr, this, target->GetGUID());
                    }
                    // Master Shapeshifter - Cat
                    if (AuraEffect const* aurEff = target->GetDummyAuraEffect(SPELLFAMILY_GENERIC, 2851, 0))
                    {
                        int32 bp = aurEff->GetAmount();
                        target->CastCustomSpell(target, 48420, &bp, nullptr, nullptr, true);
                    }
                    break;
                case FORM_DIREBEAR:
                case FORM_BEAR:
                    // Master Shapeshifter - Bear
                    if (AuraEffect const* aurEff = target->GetDummyAuraEffect(SPELLFAMILY_GENERIC, 2851, 0))
                    {
                        int32 bp = aurEff->GetAmount();
                        target->CastCustomSpell(target, 48418, &bp, nullptr, nullptr, true);
                    }
                    // Survival of the Fittest
                    if (AuraEffect const* aurEff = target->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DRUID, 961, 0))
                    {
                        int32 bp = aurEff->GetSpellInfo()->Effects[EFFECT_2].CalcValue();
                        target->CastCustomSpell(target, 62069, &bp, nullptr, nullptr, true, 0, this, target->GetGUID());
                    }
                    break;
                case FORM_MOONKIN:
                    // Master Shapeshifter - Moonkin
                    if (AuraEffect const* aurEff = target->GetDummyAuraEffect(SPELLFAMILY_GENERIC, 2851, 0))
                    {
                        int32 bp = aurEff->GetAmount();
                        target->CastCustomSpell(target, 48421, &bp, nullptr, nullptr, true);
                    }
                    // Always cast Moonkin Aura
                    target->CastSpell(target, 24907, true, nullptr, this, target->GetGUID());
                    break;
                // Master Shapeshifter - Tree of Life
                case FORM_TREE:
                    if (AuraEffect const* aurEff = target->GetDummyAuraEffect(SPELLFAMILY_GENERIC, 2851, 0))
                    {
                        int32 bp = aurEff->GetAmount();
                        target->CastCustomSpell(target, 48422, &bp, nullptr, nullptr, true);
                    }
                    break;
            }
        }
    }
    else
    {
        if (spellId)
            target->RemoveOwnedAura(spellId);
        if (spellId2)
            target->RemoveOwnedAura(spellId2);

        // Improved Barkskin - apply/remove armor bonus due to shapeshift
        if (player)
        {
            if (player->HasTalent(63410, player->GetActiveSpec()) || player->HasTalent(63411, player->GetActiveSpec()))
            {
                target->RemoveAurasDueToSpell(66530);
                target->CastSpell(target, 66530, true);
            }
        }

        const Unit::AuraEffectList& shapeshifts = target->GetAuraEffectsByType(SPELL_AURA_MOD_SHAPESHIFT);
        AuraEffect* newAura = nullptr;
        // Iterate through all the shapeshift auras that the target has, if there is another aura with SPELL_AURA_MOD_SHAPESHIFT, then this aura is being removed due to that one being applied
        for (Unit::AuraEffectList::const_iterator itr = shapeshifts.begin(); itr != shapeshifts.end(); ++itr)
        {
            if ((*itr) != this)
            {
                newAura = *itr;
                break;
            }
        }

        // Use the new aura to see on what stance the target will be
        uint32 newStance = (1 << ((newAura ? newAura->GetMiscValue() : 0) - 1));

        Unit::AuraApplicationMap& tAuras = target->GetAppliedAuras();
        for (Unit::AuraApplicationMap::iterator itr = tAuras.begin(); itr != tAuras.end();)
        {
            // If the stances are not compatible with the spell, remove it
            // Xinef: Remove all passive auras, they will be added if needed
            if (itr->second->GetBase()->IsRemovedOnShapeLost(target) && (!(itr->second->GetBase()->GetSpellInfo()->Stances & newStance) || itr->second->GetBase()->IsPassive()))
                target->RemoveAura(itr);
            else
                ++itr;
        }

        // Xinef: Remove autoattack spells
        if (Spell* spell = target->GetCurrentSpell(CURRENT_MELEE_SPELL))
            if (spell->GetSpellInfo()->CheckShapeshift(newAura ? newAura->GetMiscValue() : 0) != SPELL_CAST_OK)
                spell->cancel(true);
    }
}

/*********************************************************/
/***               AURA EFFECT HANDLERS                ***/
/*********************************************************/

/**************************************/
/***       VISIBILITY & PHASES      ***/
/**************************************/

void AuraEffect::HandleModInvisibilityDetect(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    InvisibilityType type = InvisibilityType(GetMiscValue());

    if (apply)
    {
        target->m_invisibilityDetect.AddFlag(type);
        target->m_invisibilityDetect.AddValue(type, GetAmount());
    }
    else
    {
        if (!target->HasAuraType(SPELL_AURA_MOD_INVISIBILITY_DETECT))
            target->m_invisibilityDetect.DelFlag(type);

        target->m_invisibilityDetect.AddValue(type, -GetAmount());
    }

    // call functions which may have additional effects after chainging state of unit
    target->UpdateObjectVisibility(target->GetTypeId() == TYPEID_PLAYER || target->GetOwnerGUID().IsPlayer());
}

void AuraEffect::HandleModInvisibility(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    InvisibilityType type = InvisibilityType(GetMiscValue());

    if (apply)
    {
        // apply glow vision
        if (target->GetTypeId() == TYPEID_PLAYER && (type == INVISIBILITY_GENERAL || type == INVISIBILITY_UNK10))
            target->SetByteFlag(PLAYER_FIELD_BYTES2, PLAYER_FIELD_BYTES_2_OFFSET_AURA_VISION, PLAYER_FIELD_BYTE2_INVISIBILITY_GLOW);

        target->m_invisibility.AddFlag(type);
        target->m_invisibility.AddValue(type, GetAmount());
    }
    else
    {
        if (!target->HasAuraType(SPELL_AURA_MOD_INVISIBILITY))
        {
            // if not have different invisibility auras.
            // always remove glow vision
            if (target->GetTypeId() == TYPEID_PLAYER)
                target->RemoveByteFlag(PLAYER_FIELD_BYTES2, 3, PLAYER_FIELD_BYTE2_INVISIBILITY_GLOW);

            target->m_invisibility.DelFlag(type);
        }
        else
        {
            bool found = false;
            Unit::AuraEffectList const& invisAuras = target->GetAuraEffectsByType(SPELL_AURA_MOD_INVISIBILITY);
            for (Unit::AuraEffectList::const_iterator i = invisAuras.begin(); i != invisAuras.end(); ++i)
            {
                if (GetMiscValue() == (*i)->GetMiscValue())
                {
                    found = true;
                    break;
                }
            }
            if (!found)
            {
                target->m_invisibility.DelFlag(type);

                // if not have invisibility auras of type INVISIBILITY_GENERAL
                // remove glow vision
                if (target->GetTypeId() == TYPEID_PLAYER && !target->m_invisibility.HasFlag(INVISIBILITY_GENERAL) && !target->m_invisibility.HasFlag(INVISIBILITY_UNK10))
                {
                    target->RemoveByteFlag(PLAYER_FIELD_BYTES2, PLAYER_FIELD_BYTES_2_OFFSET_AURA_VISION, PLAYER_FIELD_BYTE2_INVISIBILITY_GLOW);
                }
            }
        }

        target->m_invisibility.AddValue(type, -GetAmount());
    }

    // call functions which may have additional effects after chainging state of unit
    if (apply && (mode & AURA_EFFECT_HANDLE_REAL))
    {
        // drop flag at invisibiliy in bg
        target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);
    }

    target->UpdateObjectVisibility(target->GetTypeId() == TYPEID_PLAYER || target->GetOwnerGUID().IsPlayer() || target->GetMap()->Instanceable(), true);
    target->bRequestForcedVisibilityUpdate = false;
}

void AuraEffect::HandleModStealthDetect(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    StealthType type = StealthType(GetMiscValue());

    if (apply)
    {
        target->m_stealthDetect.AddFlag(type);
        target->m_stealthDetect.AddValue(type, GetAmount());
    }
    else
    {
        if (!target->HasAuraType(SPELL_AURA_MOD_STEALTH_DETECT))
            target->m_stealthDetect.DelFlag(type);

        target->m_stealthDetect.AddValue(type, -GetAmount());
    }

    // call functions which may have additional effects after chainging state of unit
    target->UpdateObjectVisibility(target->GetTypeId() == TYPEID_PLAYER || target->GetOwnerGUID().IsPlayer());
}

void AuraEffect::HandleModStealth(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    StealthType type = StealthType(GetMiscValue());

    if (apply)
    {
        target->m_stealth.AddFlag(type);
        target->m_stealth.AddValue(type, GetAmount());

        target->SetStandFlags(UNIT_STAND_FLAGS_CREEP);
        if (target->GetTypeId() == TYPEID_PLAYER)
            target->SetByteFlag(PLAYER_FIELD_BYTES2, 3, PLAYER_FIELD_BYTE2_STEALTH);

        // interrupt autoshot
        if (target->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
        {
            target->FinishSpell(CURRENT_AUTOREPEAT_SPELL);
            //npcbot: do not try with npcbot target
            if (target->IsPlayer())
            //end npcbot
            target->ToPlayer()->SendAutoRepeatCancel(target);
        }
    }
    else
    {
        target->m_stealth.AddValue(type, -GetAmount());

        if (!target->HasAuraType(SPELL_AURA_MOD_STEALTH)) // if last SPELL_AURA_MOD_STEALTH
        {
            target->m_stealth.DelFlag(type);

            target->RemoveStandFlags(UNIT_STAND_FLAGS_CREEP);
            if (target->GetTypeId() == TYPEID_PLAYER)
                target->RemoveByteFlag(PLAYER_FIELD_BYTES2, 3, PLAYER_FIELD_BYTE2_STEALTH);
        }
    }

    // call functions which may have additional effects after chainging state of unit
    if (apply && (mode & AURA_EFFECT_HANDLE_REAL))
    {
        // drop flag at stealth in bg
        target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);
    }

    target->UpdateObjectVisibility(target->GetTypeId() == TYPEID_PLAYER || target->GetOwnerGUID().IsPlayer() || target->GetMap()->Instanceable(), true);
    target->bRequestForcedVisibilityUpdate = false;
}

void AuraEffect::HandleModStealthLevel(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    StealthType type = StealthType(GetMiscValue());

    if (apply)
        target->m_stealth.AddValue(type, GetAmount());
    else
        target->m_stealth.AddValue(type, -GetAmount());

    // call functions which may have additional effects after chainging state of unit
    target->UpdateObjectVisibility(target->GetTypeId() == TYPEID_PLAYER || target->GetOwnerGUID().IsPlayer());
}

void AuraEffect::HandleDetectAmore(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
    {
        return;
    }

    Unit* target = aurApp->GetTarget();
    if (target->GetTypeId() != TYPEID_PLAYER)
    {
        return;
    }

    if (apply)
    {
        target->SetByteFlag(PLAYER_FIELD_BYTES2, 3, 1 << (GetMiscValue() - 1));
    }
    else
    {
        if (target->HasAuraType(SPELL_AURA_DETECT_AMORE))
        {
            Unit::AuraEffectList const& amoreAuras = target->GetAuraEffectsByType(SPELL_AURA_DETECT_AMORE);
            for (AuraEffect const* aurEff : amoreAuras)
                if (GetMiscValue() == aurEff->GetMiscValue())
                {
                    return;
                }
        }

        target->RemoveByteFlag(PLAYER_FIELD_BYTES2, 3, 1 << (GetMiscValue() - 1));
    }
}

void AuraEffect::HandleSpiritOfRedemption(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // prepare spirit state
    if (apply)
    {
        // disable breath/etc timers
        target->ToPlayer()->StopMirrorTimers();

        // set stand state (expected in this form)
        if (!target->IsStandState())
            target->SetStandState(UNIT_STAND_STATE_STAND);

        target->SetHealth(1);
    }
    // die at aura end
    else if (target->IsAlive())
        // call functions which may have additional effects after chainging state of unit
        target->setDeathState(DeathState::JustDied);

    // xinef: damage immunity spell, not needed because of 93 aura (adds non_attackable state)
    // xinef: probably blizzard added it just in case in wotlk (id > 46000)
    if (apply)
        target->CastSpell(target, 62371, true);
    else
        target->RemoveAurasDueToSpell(62371);
}

void AuraEffect::HandleAuraGhost(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    if (apply)
    {
        target->ToPlayer()->SetPlayerFlag(PLAYER_FLAGS_GHOST);
        target->m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_GHOST);
        target->m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_GHOST);
    }
    else
    {
        if (target->HasAuraType(SPELL_AURA_GHOST))
            return;

        target->ToPlayer()->RemovePlayerFlag(PLAYER_FLAGS_GHOST);
        target->m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_ALIVE);
        target->m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_ALIVE);
    }
}

void AuraEffect::HandlePhase(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    // no-phase is also phase state so same code for apply and remove
    uint32 newPhase = target->GetPhaseByAuras();

    if (Player* player = target->ToPlayer())
    {
        if (!newPhase)
            newPhase = PHASEMASK_NORMAL;

        // do not change phase to GM with all phases enabled
        if (player->IsGameMaster())
            newPhase = PHASEMASK_ANYWHERE;

        player->SetPhaseMask(newPhase, false);
        player->GetSession()->SendSetPhaseShift(newPhase);
    }
    else
    {
        if (!newPhase)
        {
            newPhase = PHASEMASK_NORMAL;
            if (Creature* creature = target->ToCreature())
                if (CreatureData const* data = sObjectMgr->GetCreatureData(creature->GetSpawnId()))
                    newPhase = data->phaseMask;
        }

        target->SetPhaseMask(newPhase, false);
    }

    // call functions which may have additional effects after chainging state of unit
    // phase auras normally not expected at BG but anyway better check
    if (apply)
    {
        // drop flag at invisibiliy in bg
        target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);
    }

    // need triggering visibility update base at phase update of not GM invisible (other GMs anyway see in any phases)
    if (target->IsVisible())
    {
        if (!target->GetMap()->Instanceable())
        {
            target->UpdateObjectVisibility(false);
            target->m_last_notify_position.Relocate(-5000.0f, -5000.0f, -5000.0f);
        }
        else
            target->UpdateObjectVisibility();
    }
}

/**********************/
/***   UNIT MODEL   ***/
/**********************/

void AuraEffect::HandleAuraModShapeshift(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    uint32 modelid = 0;
    Powers PowerType = POWER_MANA;
    ShapeshiftForm form = ShapeshiftForm(GetMiscValue());

    switch (form)
    {
        case FORM_CAT:                                      // 0x01
        case FORM_GHOUL:                                    // 0x07
            PowerType = POWER_ENERGY;
            break;

        case FORM_BEAR:                                     // 0x05
        case FORM_DIREBEAR:                                 // 0x08

        case FORM_BATTLESTANCE:                             // 0x11
        case FORM_DEFENSIVESTANCE:                          // 0x12
        case FORM_BERSERKERSTANCE:                          // 0x13
            PowerType = POWER_RAGE;
            break;

        case FORM_TREE:                                     // 0x02
        case FORM_TRAVEL:                                   // 0x03
        case FORM_AQUA:                                     // 0x04
        case FORM_AMBIENT:                                  // 0x06

        case FORM_STEVES_GHOUL:                             // 0x09
        case FORM_THARONJA_SKELETON:                        // 0x0A
        case FORM_TEST_OF_STRENGTH:                         // 0x0B
        case FORM_BLB_PLAYER:                               // 0x0C
        case FORM_SHADOW_DANCE:                             // 0x0D
        case FORM_CREATUREBEAR:                             // 0x0E
        case FORM_CREATURECAT:                              // 0x0F
        case FORM_GHOSTWOLF:                                // 0x10

        case FORM_TEST:                                     // 0x14
        case FORM_ZOMBIE:                                   // 0x15
        case FORM_METAMORPHOSIS:                            // 0x16
        case FORM_UNDEAD:                                   // 0x19
        case FORM_MASTER_ANGLER:                            // 0x1A
        case FORM_FLIGHT_EPIC:                              // 0x1B
        case FORM_SHADOW:                                   // 0x1C
        case FORM_FLIGHT:                                   // 0x1D
        case FORM_STEALTH:                                  // 0x1E
        case FORM_MOONKIN:                                  // 0x1F
        case FORM_SPIRITOFREDEMPTION:                       // 0x20
            break;
        default:
            LOG_ERROR("spells.aura.effect", "Auras: Unknown Shapeshift Type: {}", GetMiscValue());
    }

    modelid = target->GetModelForForm(form, GetId());

    if (apply)
    {
        // remove polymorph before changing display id to keep new display id
        switch (form)
        {
            case FORM_CAT:
            case FORM_TREE:
            case FORM_TRAVEL:
            case FORM_AQUA:
            case FORM_BEAR:
            case FORM_DIREBEAR:
            case FORM_FLIGHT_EPIC:
            case FORM_FLIGHT:
            case FORM_MOONKIN:
                {
                    if (Player* player = target->ToPlayer())
                    {
                        player->SetCanTeleport(true);
                    }
                    // remove movement affects
                    target->RemoveAurasByShapeShift();

                    // and polymorphic affects
                    if (target->IsPolymorphed())
                        target->RemoveAurasDueToSpell(target->getTransForm());
                    break;
                }
            default:
                break;
        }

        // remove other shapeshift before applying a new one
        // xinef: rogue shouldnt be wrapped by this check (shadow dance vs stealth)
        if (GetSpellInfo()->SpellFamilyName != SPELLFAMILY_ROGUE)
            target->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT, ObjectGuid::Empty, GetBase());

        // stop handling the effect if it was removed by linked event
        if (aurApp->GetRemoveMode())
            return;

        if (PowerType != POWER_MANA)
        {
            uint32 oldPower = target->GetPower(PowerType);
            // reset power to default values only at power change
            if (target->getPowerType() != PowerType)
                target->setPowerType(PowerType);

            switch (form)
            {
                case FORM_CAT:
                case FORM_BEAR:
                case FORM_DIREBEAR:
                    {
                        // get furor proc chance
                        uint32 FurorChance = 0;
                        if (AuraEffect const* dummy = target->GetDummyAuraEffect(SPELLFAMILY_DRUID, 238, 0))
                            FurorChance = std::max(dummy->GetAmount(), 0);

                        switch (GetMiscValue())
                        {
                            case FORM_CAT:
                                {
                                    int32 basePoints = int32(std::min(oldPower, FurorChance));
                                    target->SetPower(POWER_ENERGY, 0);
                                    target->CastCustomSpell(target, 17099, &basePoints, nullptr, nullptr, true, nullptr, this);
                                    break;
                                }
                            case FORM_BEAR:
                            case FORM_DIREBEAR:
                                if (urand(0, 99) < FurorChance)
                                    target->CastSpell(target, 17057, true);
                                break;
                            default:
                                {
                                    uint32 newEnergy = std::min(target->GetPower(POWER_ENERGY), FurorChance);
                                    target->SetPower(POWER_ENERGY, newEnergy);
                                    break;
                                }
                        }
                        break;
                    }
                default:
                    break;
            }
        }
        // stop handling the effect if it was removed by linked event
        if (aurApp->GetRemoveMode())
            return;

        target->SetShapeshiftForm(form);
        // xinef: allow shapeshift to override model id if forced transform aura is not present!
        if (modelid > 0)
        {
            bool allow = true;
            if (target->getTransForm() && !(target->GetMapId() == 560 /*The Escape From Durnholde*/))
                if (SpellInfo const* transformSpellInfo = sSpellMgr->GetSpellInfo(target->getTransForm()))
                    if (transformSpellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) || !transformSpellInfo->IsPositive())
                        allow = false;

            if (allow)
                target->SetDisplayId(modelid);
        }
    }
    else
    {
        // reset model id if no other auras present
        // may happen when aura is applied on linked event on aura removal
        if (!target->HasAuraType(SPELL_AURA_MOD_SHAPESHIFT))
        {
            target->SetShapeshiftForm(FORM_NONE);
            if (target->IsClass(CLASS_DRUID, CLASS_CONTEXT_ABILITY))
            {
                target->setPowerType(POWER_MANA);
                // Remove movement impairing effects also when shifting out
                target->RemoveAurasByShapeShift();
            }
        }

        if (modelid > 0)
            target->RestoreDisplayId();

        switch (form)
        {
            // Nordrassil Harness - bonus
            case FORM_BEAR:
            case FORM_DIREBEAR:
            case FORM_CAT:
                if (AuraEffect* dummy = target->GetAuraEffect(37315, 0))
                    target->CastSpell(target, 37316, true, nullptr, dummy);
                break;
            // Nordrassil Regalia - bonus
            case FORM_MOONKIN:
                if (AuraEffect* dummy = target->GetAuraEffect(37324, 0))
                    target->CastSpell(target, 37325, true, nullptr, dummy);
                break;
            case FORM_BATTLESTANCE:
            case FORM_DEFENSIVESTANCE:
            case FORM_BERSERKERSTANCE:
                {
                    //npcbot: skip this, handled inside class ai
                    if (target->IsNPCBot())
                        break;
                    //end npcbot
                    uint32 Rage_val = 0;
                    // Defensive Tactics
                    if (form == FORM_DEFENSIVESTANCE)
                    {
                        if (AuraEffect const* aurEff = target->IsScriptOverriden(m_spellInfo, 831))
                            Rage_val += aurEff->GetAmount() * 10;
                    }
                    // Stance mastery + Tactical mastery (both passive, and last have aura only in defense stance, but need apply at any stance switch)
                    if (target->GetTypeId() == TYPEID_PLAYER)
                    {
                        // Stance mastery - trainer spell
                        PlayerSpellMap const& sp_list = target->ToPlayer()->GetSpellMap();
                        for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
                        {
                            if (itr->second->State == PLAYERSPELL_REMOVED || !itr->second->IsInSpec(target->ToPlayer()->GetActiveSpec()))
                                continue;

                            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
                            if (spellInfo && spellInfo->SpellFamilyName == SPELLFAMILY_WARRIOR && spellInfo->SpellIconID == 139)
                                Rage_val += target->CalculateSpellDamage(target, spellInfo, 0) * 10;
                        }

                        // Tactical Mastery - talent
                        PlayerTalentMap const& tp_list = target->ToPlayer()->GetTalentMap();
                        for (PlayerTalentMap::const_iterator itr = tp_list.begin(); itr != tp_list.end(); ++itr)
                        {
                            if (itr->second->State == PLAYERSPELL_REMOVED || !itr->second->IsInSpec(target->ToPlayer()->GetActiveSpec()))
                                continue;

                            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
                            if (spellInfo && spellInfo->SpellFamilyName == SPELLFAMILY_WARRIOR && spellInfo->SpellIconID == 139)
                                Rage_val += target->CalculateSpellDamage(target, spellInfo, 0) * 10;
                        }
                    }
                    if (target->GetPower(POWER_RAGE) > Rage_val)
                        target->SetPower(POWER_RAGE, Rage_val);
                    break;
                }
            default:
                break;
        }
    }

    // adding/removing linked auras
    // add/remove the shapeshift aura's boosts
    HandleShapeshiftBoosts(target, apply);

    if (target->GetTypeId() == TYPEID_PLAYER)
        target->ToPlayer()->InitDataForForm();

    if (target->IsClass(CLASS_DRUID, CLASS_CONTEXT_ABILITY))
    {
        // Dash
        if (AuraEffect* aurEff = target->GetAuraEffect(SPELL_AURA_MOD_INCREASE_SPEED, SPELLFAMILY_DRUID, 0, 0, 0x8))
            aurEff->RecalculateAmount();

        // Disarm handling
        // If druid shifts while being disarmed we need to deal with that since forms aren't affected by disarm
        // and also HandleAuraModDisarm is not triggered
        if (!target->CanUseAttackType(BASE_ATTACK))
        {
            //npcbot: skip bots (handled inside AI)
            if (target->IsNPCBotOrPet())
            {}
            else
            //end npcbot
            if (Item* pItem = target->ToPlayer()->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
            {
                target->ToPlayer()->_ApplyWeaponDamage(EQUIPMENT_SLOT_MAINHAND, pItem->GetTemplate(), nullptr, apply);
            }
        }

        // Update crit chance for feral forms
        //npcbot: skip bots (handled inside AI)
        if (target->IsNPCBotOrPet())
        {}
        else
        //end npcbot
        switch (form)
        {
            case FORM_CAT:
            case FORM_BEAR:
            case FORM_DIREBEAR:
            case FORM_GHOSTWOLF:
                target->ToPlayer()->UpdateAllCritPercentages();
                break;
            default:
                break;
        }
    }

    // stop handling the effect if it was removed by linked event
    if (apply && aurApp->GetRemoveMode())
        return;

    if (target->GetTypeId() == TYPEID_PLAYER)
    {
        SpellShapeshiftFormEntry const* shapeInfo = sSpellShapeshiftFormStore.LookupEntry(form);
        // Learn spells for shapeshift form - no need to send action bars or add spells to spellbook
        for (uint8 i = 0; i < MAX_SHAPESHIFT_SPELLS; ++i)
        {
            if (!shapeInfo->stanceSpell[i])
                continue;
            if (apply)
                target->ToPlayer()->_addSpell(shapeInfo->stanceSpell[i], SPEC_MASK_ALL, true);
            else
                target->ToPlayer()->removeSpell(shapeInfo->stanceSpell[i], SPEC_MASK_ALL, true);
        }
    }
}

void AuraEffect::HandleAuraTransform(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
    {
        // update active transform spell only when transform or shapeshift not set or not overwriting negative by positive case
        if (GetSpellInfo()->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) || !target->GetModelForForm(target->GetShapeshiftForm(), GetId()) || !GetSpellInfo()->IsPositive())
        {
            // special case (spell specific functionality)
            if (GetMiscValue() == 0)
            {
                switch (GetId())
                {
                    // Orb of Deception
                    case 16739:
                        {
                            if (target->GetTypeId() != TYPEID_PLAYER)
                                return;

                            switch (target->getRace())
                            {
                                // Blood Elf
                                case RACE_BLOODELF:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 17829 : 17830);
                                    break;
                                // Orc
                                case RACE_ORC:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10139 : 10140);
                                    break;
                                // Troll
                                case RACE_TROLL:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10135 : 10134);
                                    break;
                                // Tauren
                                case RACE_TAUREN:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10136 : 10147);
                                    break;
                                // Undead
                                case RACE_UNDEAD_PLAYER:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10146 : 10145);
                                    break;
                                // Draenei
                                case RACE_DRAENEI:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 17827 : 17828);
                                    break;
                                // Dwarf
                                case RACE_DWARF:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10141 : 10142);
                                    break;
                                // Gnome
                                case RACE_GNOME:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10148 : 10149);
                                    break;
                                // Human
                                case RACE_HUMAN:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10137 : 10138);
                                    break;
                                // Night Elf
                                case RACE_NIGHTELF:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 10143 : 10144);
                                    break;
                                default:
                                    break;
                            }
                            break;
                        }
                    // Murloc costume
                    case 42365:
                        target->SetDisplayId(21723);
                        break;
                    // Dread Corsair
                    case 50517:
                    // Corsair Costume
                    case 51926:
                        {
                            if (target->GetTypeId() != TYPEID_PLAYER)
                                return;

                            switch (target->getRace())
                            {
                                // Blood Elf
                                case RACE_BLOODELF:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25032 : 25043);
                                    break;
                                // Orc
                                case RACE_ORC:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25039 : 25050);
                                    break;
                                // Troll
                                case RACE_TROLL:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25041 : 25052);
                                    break;
                                // Tauren
                                case RACE_TAUREN:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25040 : 25051);
                                    break;
                                // Undead
                                case RACE_UNDEAD_PLAYER:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25042 : 25053);
                                    break;
                                // Draenei
                                case RACE_DRAENEI:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25033 : 25044);
                                    break;
                                // Dwarf
                                case RACE_DWARF:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25034 : 25045);
                                    break;
                                // Gnome
                                case RACE_GNOME:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25035 : 25046);
                                    break;
                                // Human
                                case RACE_HUMAN:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25037 : 25048);
                                    break;
                                // Night Elf
                                case RACE_NIGHTELF:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25038 : 25049);
                                    break;
                                default:
                                    break;
                            }
                            break;
                        }
                    // Pygmy Oil
                    case 53806:
                        target->SetDisplayId(22512);
                        break;
                    // Honor the Dead
                    case 65386:
                    case 65495:
                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 29203 : 29204);
                        break;
                    // Gossip NPC Appearance - Brewfest
                    case 65511:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21839 : 21838);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21841 : 21840);
                                    break;
                                case DisplayRace::Orc:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21867 : 21866);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21869 : 21868);
                                    break;
                                case DisplayRace::Troll:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21875 : 21874);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21877 : 21876);
                                    break;
                                case DisplayRace::Tauren:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21869 : 21871);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21872 : 21873);
                                    break;
                                case DisplayRace::Undead:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21879 : 21878);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21881 : 21880);
                                    break;
                                case DisplayRace::Draenei:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21844 : 21842);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21845 : 21843);
                                    break;
                                case DisplayRace::Dwarf:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21846 : 21848);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21847 : 21849);
                                    break;
                                case DisplayRace::Gnome:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21851 : 21850);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21853 : 21852);
                                    break;
                                case DisplayRace::Human:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21859 : 21858);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21861 : 21860);
                                    break;
                                case DisplayRace::NightElf:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21863 : 21862);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21865 : 21864);
                                    break;
                                case DisplayRace::Goblin:
                                    if (urand(0, 1))
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21854 : 21856);
                                    else
                                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 21855 : 21857);
                                    break;
                                default:
                                    break;
                            }

                            // equip random brewfest mug
                            uint32 itemIds[5] = {
                                2703,  // Monster - Item, Tankard Wooden
                                2704,  // Monster - Item, Tankard Dirty
                                2705,  // Monster - Item, Tankard Metal
                                13861, // Monster - Item, Tankard Gold
                                33963  // NPC Equip 33963
                            };
                            if (target->ToCreature())
                                target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, itemIds[urand(0, 4)]);

                            break;
                        }
                    // Gossip NPC Appearance - Winter Veil
                    case 65522:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18793 : 18785);
                                    break;
                                case DisplayRace::Orc:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18805 : 18804);
                                    break;
                                case DisplayRace::Troll:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18809 : 18808);
                                    break;
                                case DisplayRace::Tauren:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18807 : 18806);
                                    break;
                                case DisplayRace::Undead:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18811 : 18810);
                                    break;
                                case DisplayRace::Draenei:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18795 : 18794);
                                    break;
                                case DisplayRace::Dwarf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18797 : 18796);
                                    break;
                                case DisplayRace::Gnome:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18799 : 18798);
                                    break;
                                case DisplayRace::Human:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18801 : 18800);
                                    break;
                                case DisplayRace::NightElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18803 : 18802);
                                    break;
                                case DisplayRace::Goblin:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19342 : 19339);
                                default:
                                    break;
                            }
                            break;
                        }
                    // Gossip NPC Appearance - Default
                    case 65523:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19170 : 19169);
                                    break;
                                case DisplayRace::Orc:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19182 : 19181);
                                    break;
                                case DisplayRace::Troll:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19186 : 19185);
                                    break;
                                case DisplayRace::Tauren:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19184 : 19183);
                                    break;
                                case DisplayRace::Undead:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19188 : 19187);
                                    break;
                                case DisplayRace::Draenei:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19172 : 19171);
                                    break;
                                case DisplayRace::Dwarf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19174 : 19173);
                                    break;
                                case DisplayRace::Gnome:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19176 : 19175);
                                    break;
                                case DisplayRace::Human:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19178 : 19177);
                                    break;
                                case DisplayRace::NightElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19180 : 19179);
                                    break;
                                case DisplayRace::Goblin:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 19343 : 19340);
                                default:
                                    break;
                            }
                            break;
                        }
                    // Gossip NPC Appearance - Lunar Festival
                    case 65524:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18841 : 18840);
                                    break;
                                case DisplayRace::Orc:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18870 : 18869);
                                    break;
                                case DisplayRace::Troll:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18874 : 18873);
                                    break;
                                case DisplayRace::Tauren:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18872 : 18871);
                                    break;
                                case DisplayRace::Undead:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18876 : 18875);
                                    break;
                                case DisplayRace::Draenei:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18843 : 18842);
                                    break;
                                case DisplayRace::Dwarf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18845 : 18844);
                                    break;
                                case DisplayRace::Gnome:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18847 : 18846);
                                    break;
                                case DisplayRace::Human:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18860 : 18858);
                                    break;
                                case DisplayRace::NightElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 18868 : 18867);
                                    break;
                                case DisplayRace::Goblin:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 21067 : 19341);
                                default:
                                    break;
                            }
                            break;
                        }
                    // Gossip NPC Appearance - Hallow's End
                    case 65525:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22361 : 22360);
                                    break;
                                case DisplayRace::Orc:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22375 : 22374);
                                    break;
                                case DisplayRace::Troll:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22379 : 22378);
                                    break;
                                case DisplayRace::Tauren:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22377 : 22376);
                                    break;
                                case DisplayRace::Undead:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22381 : 22380);
                                    break;
                                case DisplayRace::Draenei:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22363 : 22362);
                                    break;
                                case DisplayRace::Dwarf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22365 : 22364);
                                    break;
                                case DisplayRace::Gnome:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22367 : 22366);
                                    break;
                                case DisplayRace::Human:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22371 : 22370);
                                    break;
                                case DisplayRace::NightElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22373 : 22372);
                                    break;
                                case DisplayRace::Goblin:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 22369 : 22368);
                                default:
                                    break;
                            }
                            break;
                        }
                    // Gossip NPC Appearance - Midsummer
                    case 65526:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 21086 : 21085);
                                    break;
                                case DisplayRace::Orc:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16438 : 16436);
                                    break;
                                case DisplayRace::Troll:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16446 : 16445);
                                    break;
                                case DisplayRace::Tauren:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16432 : 16442);
                                    break;
                                case DisplayRace::Undead:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16444 : 16443);
                                    break;
                                case DisplayRace::Draenei:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 21083 : 21084);
                                    break;
                                case DisplayRace::Dwarf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16413 : 16434);
                                    break;
                                case DisplayRace::Gnome:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16448 : 16447);
                                    break;
                                case DisplayRace::Human:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16433 : 16412);
                                    break;
                                case DisplayRace::NightElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 16435 : 16414);
                                    break;
                                case DisplayRace::Goblin:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 29243 : 16431);
                                default:
                                    break;
                            }
                            break;
                        }
                    // Gossip NPC Appearance - Spirit of Competition
                    case 65527:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24508 : 24519);
                                    break;
                                case DisplayRace::Orc:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24515 : 24526);
                                    break;
                                case DisplayRace::Troll:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24517 : 24528);
                                    break;
                                case DisplayRace::Tauren:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24516 : 24527);
                                    break;
                                case DisplayRace::Undead:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24518 : 24529);
                                    break;
                                case DisplayRace::Draenei:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24509 : 24520);
                                    break;
                                case DisplayRace::Dwarf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24510 : 24521);
                                    break;
                                case DisplayRace::Gnome:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24511 : 24522);
                                    break;
                                case DisplayRace::Human:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24513 : 24524);
                                    break;
                                case DisplayRace::NightElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24514 : 24525);
                                    break;
                                case DisplayRace::Goblin:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 24512 : 24523);
                                default:
                                    break;
                            }
                            break;
                        }
                    // Gossip NPC Appearance - Pirates' Day
                    case 65528:
                        {
                            switch (target->GetDisplayRace())
                            {
                                case DisplayRace::BloodElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25032 : 25043);
                                    break;
                                case DisplayRace::Orc:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25039 : 25050);
                                    break;
                                case DisplayRace::Troll:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25041 : 25052);
                                    break;
                                case DisplayRace::Tauren:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25040 : 25051);
                                    break;
                                case DisplayRace::Undead:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25042 : 25053);
                                    break;
                                case DisplayRace::Draenei:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25033 : 25044);
                                    break;
                                case DisplayRace::Dwarf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25034 : 25045);
                                    break;
                                case DisplayRace::Gnome:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25035 : 25046);
                                    break;
                                case DisplayRace::Human:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25037 : 25048);
                                    break;
                                case DisplayRace::NightElf:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25038 : 25049);
                                    break;
                                case DisplayRace::Goblin:
                                    target->SetDisplayId(target->getGender() == GENDER_MALE ? 25036 : 25047);
                                default:
                                    break;
                            }
                            break;
                        }
                    // Gossip NPC Appearance - Day of the Dead(DotD)
                    case 65529:
                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 29203 : 29204);
                        break;
                    // Darkspear Pride
                    case 75532:
                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 31737 : 31738);
                        break;
                    // Gnomeregan Pride
                    case 75531:
                        target->SetDisplayId(target->getGender() == GENDER_MALE ? 31654 : 31655);
                        break;
                    default:
                        break;
                }
            }
            else
            {
                CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(GetMiscValue());
                if (!ci)
                {
                    target->SetDisplayId(16358);              // pig pink ^_^
                    LOG_ERROR("spells.aura.effect", "Auras: unknown creature id = {} (only need its modelid) From Spell Aura Transform in Spell ID = {}", GetMiscValue(), GetId());
                }
                else
                {
                    uint32 model_id = 0;

                    if (uint32 modelid = ObjectMgr::ChooseDisplayId(ci)->CreatureDisplayID)
                        model_id = modelid;                     // Will use the default model here

                    // Polymorph (sheep)
                    if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_MAGE && GetSpellInfo()->SpellIconID == 82 && GetSpellInfo()->SpellVisual[0] == 12978)
                        if (Unit* caster = GetCaster())
                            if (caster->HasAura(52648))         // Glyph of the Penguin
                                model_id = 26452;

                    target->SetDisplayId(model_id);

                    // Dragonmaw Illusion (set mount model also)
                    if (GetId() == 42016 && target->GetMountID() && !target->GetAuraEffectsByType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED).empty())
                        target->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 16314);
                }
            }
        }

        // update active transform spell only when transform or shapeshift not set or not overwriting negative by positive case
        SpellInfo const* transformSpellInfo = sSpellMgr->GetSpellInfo(target->getTransForm());
        if (!transformSpellInfo || GetSpellInfo()->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) || !GetSpellInfo()->IsPositive() || transformSpellInfo->IsPositive())
            target->setTransForm(GetId());

        // polymorph case
        if ((mode & AURA_EFFECT_HANDLE_REAL) && target->GetTypeId() == TYPEID_PLAYER && target->IsPolymorphed())
        {
            // for players, start regeneration after 1s (in polymorph fast regeneration case)
            // only if caster is Player (after patch 2.4.2)
            if (GetCasterGUID().IsPlayer())
                target->ToPlayer()->setRegenTimerCount(1 * IN_MILLISECONDS);

            //dismount polymorphed target (after patch 2.4.2)
            if (target->IsMounted())
                target->RemoveAurasByType(SPELL_AURA_MOUNTED);
        }
    }
    else
    {
        // HandleEffect(this, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT, true) will reapply it if need
        if (target->getTransForm() == GetId())
            target->setTransForm(0);

        target->RestoreDisplayId();

        // Dragonmaw Illusion (restore mount model)
        if (GetId() == 42016 && target->GetMountID() == 16314)
        {
            if (!target->GetAuraEffectsByType(SPELL_AURA_MOUNTED).empty())
            {
                uint32 cr_id = target->GetAuraEffectsByType(SPELL_AURA_MOUNTED).front()->GetMiscValue();
                if (CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(cr_id))
                {
                    CreatureModel model = *ObjectMgr::ChooseDisplayId(ci);
                    sObjectMgr->GetCreatureModelRandomGender(&model, ci);

                    target->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, model.CreatureDisplayID);
                }
            }
        }
    }
}

void AuraEffect::HandleAuraModScale(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_SEND_FOR_CLIENT_MASK))
        return;

    aurApp->GetTarget()->RecalculateObjectScale();
}

void AuraEffect::HandleAuraCloneCaster(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
    {
        Unit* caster = GetCaster();
        if (!caster || caster == target)
            return;

        // What must be cloned? at least display and scale
        target->SetDisplayId(caster->GetDisplayId());
        target->SetUnitFlag2(UNIT_FLAG2_MIRROR_IMAGE);
    }
    else
    {
        target->SetDisplayId(target->GetNativeDisplayId());
        target->RemoveUnitFlag2(UNIT_FLAG2_MIRROR_IMAGE);
    }
}

/************************/
/***      FIGHT       ***/
/************************/

void AuraEffect::HandleFeignDeath(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }

    if (apply)
    {
        /*
        WorldPacket data(SMSG_FEIGN_DEATH_RESISTED, 9);
        data<<target->GetGUID();
        data<<uint8(0);
        target->SendMessageToSet(&data, true);
        */

        UnitList targets;
        Acore::AnyUnfriendlyUnitInObjectRangeCheck u_check(target, target, target->GetVisibilityRange()); // no VISIBILITY_COMPENSATION, distance is enough
        Acore::UnitListSearcher<Acore::AnyUnfriendlyUnitInObjectRangeCheck> searcher(target, targets, u_check);
        Cell::VisitAllObjects(target, searcher, target->GetMap()->GetVisibilityRange());
        for (UnitList::iterator iter = targets.begin(); iter != targets.end(); ++iter)
        {
            if (!(*iter)->HasUnitState(UNIT_STATE_CASTING))
                continue;

            for (uint32 i = CURRENT_FIRST_NON_MELEE_SPELL; i < CURRENT_MAX_SPELL; i++)
            {
                if ((*iter)->GetCurrentSpell(i) && (*iter)->GetCurrentSpell(i)->m_targets.GetUnitTargetGUID() == target->GetGUID())
                {
                    SpellInfo const* si = (*iter)->GetCurrentSpell(i)->GetSpellInfo();
                    if (si->HasAttribute(SPELL_ATTR6_IGNORE_PHASE_SHIFT) && (*iter)->GetTypeId() == TYPEID_UNIT)
                    {
                        Creature* c = (*iter)->ToCreature();
                        if ((!c->IsPet() && c->GetCreatureTemplate()->rank == CREATURE_ELITE_WORLDBOSS) || c->isWorldBoss() || c->IsDungeonBoss())
                            continue;
                    }
                    bool interrupt = false; // pussywizard: skip spells that don't target units, but casted on unit (eg. TARGET_DEST_TARGET_ENEMY)
                    for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
                        if (si->Effects[j].Effect && (si->Effects[j].GetUsedTargetObjectType() == TARGET_OBJECT_TYPE_UNIT || si->Effects[j].GetUsedTargetObjectType() == TARGET_OBJECT_TYPE_UNIT_AND_DEST))
                        {
                            // at least one effect truly targets an unit, interrupt the spell
                            interrupt = true;
                            break;
                        }
                    if (interrupt)
                        (*iter)->InterruptSpell(CurrentSpellTypes(i), false);
                }
            }
        }

        if (target->GetInstanceScript() && target->GetInstanceScript()->IsEncounterInProgress())
        {
            // Xinef: replaced with CombatStop(false)
            target->AttackStop();
            target->RemoveAllAttackers();
            target->getHostileRefMgr().addThreatPercent(-100);
            target->ToPlayer()->SendAttackSwingCancelAttack();     // melee and ranged forced attack cancel
        }
        else
        {
            target->CombatStop();
            target->getHostileRefMgr().deleteReferences();
        }

        target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);

        // prevent interrupt message
        if (GetCasterGUID() == target->GetGUID())
        {
            if (target->GetCurrentSpell(CURRENT_GENERIC_SPELL))
                target->FinishSpell(CURRENT_GENERIC_SPELL, true);

            // interrupt autoshot
            if (target->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
            {
                target->FinishSpell(CURRENT_AUTOREPEAT_SPELL);
                target->ToPlayer()->SendAutoRepeatCancel(target);
            }
        }

        target->InterruptNonMeleeSpells(true);

        // stop handling the effect if it was removed by linked event
        if (aurApp->GetRemoveMode())
            return;
        // blizz like 2.0.x
        target->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
        // blizz like 2.0.x
        target->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        // blizz like 2.0.x
        target->SetDynamicFlag(UNIT_DYNFLAG_DEAD);

        target->AddUnitState(UNIT_STATE_DIED);
    }
    else
    {
        /*
        WorldPacket data(SMSG_FEIGN_DEATH_RESISTED, 9);
        data<<target->GetGUID();
        data<<uint8(1);
        target->SendMessageToSet(&data, true);
        */
        // blizz like 2.0.x
        target->RemoveUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
        // blizz like 2.0.x
        target->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        // blizz like 2.0.x
        target->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);

        target->ClearUnitState(UNIT_STATE_DIED);
    }
}

void AuraEffect::HandleModUnattackable(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
    if (!apply && target->HasAuraType(SPELL_AURA_MOD_UNATTACKABLE))
        return;

    target->ApplyModFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE, apply);

    // call functions which may have additional effects after chainging state of unit
    if (apply && (mode & AURA_EFFECT_HANDLE_REAL))
    {
        // xinef: this aura should not stop combat (movie with sindragosa proves that)
        //target->CombatStop();
        target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);
    }
}

void AuraEffect::HandleAuraModDisarm(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    AuraType type = GetAuraType();

    //Prevent handling aura twice
    if ((apply) ? target->GetAuraEffectsByType(type).size() > 1 : target->HasAuraType(type))
        return;

    uint32 field, flag, slot;
    WeaponAttackType attType;
    switch (type)
    {
        case SPELL_AURA_MOD_DISARM:
            field = UNIT_FIELD_FLAGS;
            flag = UNIT_FLAG_DISARMED;
            slot = EQUIPMENT_SLOT_MAINHAND;
            attType = BASE_ATTACK;
            break;
        case SPELL_AURA_MOD_DISARM_OFFHAND:
            field = UNIT_FIELD_FLAGS_2;
            flag = UNIT_FLAG2_DISARM_OFFHAND;
            slot = EQUIPMENT_SLOT_OFFHAND;
            attType = OFF_ATTACK;
            break;
        case SPELL_AURA_MOD_DISARM_RANGED:
            field = UNIT_FIELD_FLAGS_2;
            flag = UNIT_FLAG2_DISARM_RANGED;
            slot = EQUIPMENT_SLOT_RANGED;
            attType = RANGED_ATTACK;
            break;
        default:
            return;
    }

    // if disarm aura is to be removed, remove the flag first to reapply damage/aura mods
    if (!apply)
        target->RemoveFlag(field, flag);

    // Handle damage modification, shapeshifted druids are not affected
    if (target->GetTypeId() == TYPEID_PLAYER && (!target->IsInFeralForm() || target->GetShapeshiftForm() == FORM_GHOSTWOLF))
    {
        if (Item* pItem = target->ToPlayer()->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
        {
            uint8 attacktype = Player::GetAttackBySlot(slot);

            if (attacktype < MAX_ATTACK)
            {
                target->ToPlayer()->_ApplyWeaponDamage(slot, pItem->GetTemplate(), nullptr, !apply);
                target->ToPlayer()->_ApplyWeaponDependentAuraMods(pItem, WeaponAttackType(attacktype), !apply);
            }
        }
    }

    // if disarm effects should be applied, wait to set flag until damage mods are unapplied
    if (apply)
        target->SetFlag(field, flag);

    if (target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->GetCurrentEquipmentId())
        target->UpdateDamagePhysical(attType);
}

void AuraEffect::HandleAuraModSilence(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
    {
        target->SetUnitFlag(UNIT_FLAG_SILENCED);

        // call functions which may have additional effects after chainging state of unit
        // Stop cast only spells vs PreventionType == SPELL_PREVENTION_TYPE_SILENCE
        for (uint32 i = CURRENT_MELEE_SPELL; i < CURRENT_MAX_SPELL; ++i)
            if (Spell* spell = target->GetCurrentSpell(CurrentSpellTypes(i)))
                if (spell->m_spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE)
                    // Stop spells on prepare or casting state
                    target->InterruptSpell(CurrentSpellTypes(i), false);
    }
    else
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(SPELL_AURA_MOD_SILENCE) || target->HasAuraType(SPELL_AURA_MOD_PACIFY_SILENCE))
            return;

        target->RemoveUnitFlag(UNIT_FLAG_SILENCED);
    }
}

void AuraEffect::HandleAuraModPacify(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
    {
        target->SetUnitFlag(UNIT_FLAG_PACIFIED);
        //target->AttackStop(); // pussywizard: why having this flag prevents from being in combat? it should just prevent melee attack
    }
    else
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(SPELL_AURA_MOD_PACIFY) || target->HasAuraType(SPELL_AURA_MOD_PACIFY_SILENCE))
            return;
        target->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
    }
}

void AuraEffect::HandleAuraModPacifyAndSilence(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (!(apply))
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(SPELL_AURA_MOD_PACIFY_SILENCE))
            return;
    }
    HandleAuraModPacify(aurApp, mode, apply);
    HandleAuraModSilence(aurApp, mode, apply);
}

void AuraEffect::HandleAuraAllowOnlyAbility(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() == TYPEID_PLAYER)
    {
        if (apply)
            target->ToPlayer()->SetPlayerFlag(PLAYER_ALLOW_ONLY_ABILITY);
        else
        {
            // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
            if (target->HasAuraType(SPELL_AURA_ALLOW_ONLY_ABILITY))
                return;
            target->ToPlayer()->RemovePlayerFlag(PLAYER_ALLOW_ONLY_ABILITY);
        }
    }
}

/****************************/
/***      TRACKING        ***/
/****************************/

void AuraEffect::HandleAuraTrackCreatures(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    if (apply)
        target->SetFlag(PLAYER_TRACK_CREATURES, uint32(1) << (GetMiscValue() - 1));
    else
        target->RemoveFlag(PLAYER_TRACK_CREATURES, uint32(1) << (GetMiscValue() - 1));
}

void AuraEffect::HandleAuraTrackResources(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    if (apply)
        target->SetFlag(PLAYER_TRACK_RESOURCES, uint32(1) << (GetMiscValue() - 1));
    else
        target->RemoveFlag(PLAYER_TRACK_RESOURCES, uint32(1) << (GetMiscValue() - 1));
}

void AuraEffect::HandleAuraTrackStealthed(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    if (!(apply))
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
    }
    target->ApplyModFlag(PLAYER_FIELD_BYTES, PLAYER_FIELD_BYTE_TRACK_STEALTHED, apply);
}

void AuraEffect::HandleAuraModStalked(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    // used by spells: Hunter's Mark, Mind Vision, Syndicate Tracker (MURP) DND
    if (apply)
        target->SetDynamicFlag(UNIT_DYNFLAG_TRACK_UNIT);
    else
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (!target->HasAuraType(GetAuraType()))
            target->RemoveDynamicFlag(UNIT_DYNFLAG_TRACK_UNIT);
    }

    // call functions which may have additional effects after chainging state of unit
    target->UpdateObjectVisibility(target->GetTypeId() == TYPEID_PLAYER);
}

void AuraEffect::HandleAuraUntrackable(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
        target->SetByteFlag(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_VIS_FLAG, UNIT_STAND_FLAGS_UNTRACKABLE);
    else
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
        target->RemoveByteFlag(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_VIS_FLAG, UNIT_STAND_FLAGS_UNTRACKABLE);
    }
}

/****************************/
/***  SKILLS & TALENTS    ***/
/****************************/

void AuraEffect::HandleAuraModPetTalentsPoints(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // Recalculate pet talent points
    if (Pet* pet = target->ToPlayer()->GetPet())
        pet->InitTalentForLevel();
}

void AuraEffect::HandleAuraModSkill(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_SKILL)))
        return;
    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    uint32 prot = GetMiscValue();
    int32 points = GetAmount();

    target->ToPlayer()->ModifySkillBonus(prot, ((apply) ? points : -points), GetAuraType() == SPELL_AURA_MOD_SKILL_TALENT);
    if (prot == SKILL_DEFENSE)
        target->ToPlayer()->UpdateDefenseBonusesMod();
}

/****************************/
/***       MOVEMENT       ***/
/****************************/

void AuraEffect::HandleAuraMounted(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    Unit* caster = GetCaster();

    if (apply)
    {
        uint32 creatureEntry = GetMiscValue();
        uint32 displayId = 0;
        uint32 vehicleId = 0;

        // Festive Holiday Mount
        if (target->HasAura(62061))
        {
            if (GetBase()->HasEffectType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                creatureEntry = 24906;
            else
                creatureEntry = 15665;
        }

        // Festive Brewfest Mount
        if (!GetBase()->HasEffectType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) && target->HasAura(FRESH_BREWFEST_HOPS))
        {
            if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
            {
                creatureEntry = GREAT_BREWFEST_KODO;
            }
            else
            {
                creatureEntry = BREWFEST_KODO;
            }
        }

        if (CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creatureEntry))
        {
            CreatureModel model = *ObjectMgr::ChooseDisplayId(creatureInfo);
            sObjectMgr->GetCreatureModelRandomGender(&model, creatureInfo);
            displayId = model.CreatureDisplayID;

            vehicleId = creatureInfo->VehicleId;

            //some spell has one aura of mount and one of vehicle
            for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            {
                if (GetSpellInfo()->Effects[i].Effect == SPELL_EFFECT_SUMMON && GetSpellInfo()->Effects[i].MiscValue == GetMiscValue())
                {
                    displayId = 0;
                }
            }

        }
        target->Mount(displayId, vehicleId, GetMiscValue());
    }
    else
    {
        target->Dismount();
        //some mounts like Headless Horseman's Mount or broom stick are skill based spell
        // need to remove ALL arura related to mounts, this will stop client crash with broom stick
        // and never endless flying after using Headless Horseman's Mount
        if (mode & AURA_EFFECT_HANDLE_REAL)
            target->RemoveAurasByType(SPELL_AURA_MOUNTED);
    }
}

void AuraEffect::HandleAuraAllowFlight(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (!apply)
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()) || target->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
            return;
    }

    target->SetCanFly(apply);

    if (!apply && target->GetTypeId() == TYPEID_UNIT && !target->IsLevitating())
        target->GetMotionMaster()->MoveFall();
}

void AuraEffect::HandleAuraWaterWalk(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }

    if (!apply)
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
    }

    target->SetWaterWalking(apply);
}

void AuraEffect::HandleAuraFeatherFall(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }

    if (!apply)
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
    }

    target->SetFeatherFall(apply);

    // start fall from current height
    if (!apply && target->GetTypeId() == TYPEID_PLAYER)
        target->ToPlayer()->SetFallInformation(GameTime::GetGameTime().count(), target->GetPositionZ());
}

void AuraEffect::HandleAuraHover(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }

    if (!apply)
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
    }

    target->SetHover(apply);    //! Sets movementflags
}

void AuraEffect::HandleWaterBreathing(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    // update timers in client
    if (target->GetTypeId() == TYPEID_PLAYER)
        target->ToPlayer()->UpdateMirrorTimers();
}

void AuraEffect::HandleForceMoveForward(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
        target->SetUnitFlag2(UNIT_FLAG2_FORCE_MOVEMENT);
    else
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
        target->RemoveUnitFlag2(UNIT_FLAG2_FORCE_MOVEMENT);
    }
}

/****************************/
/***        THREAT        ***/
/****************************/

void AuraEffect::HandleModThreat(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    for (int8 i = 0; i < MAX_SPELL_SCHOOL; ++i)
        if (GetMiscValue() & (1 << i))
            ApplyPercentModFloatVar(target->m_threatModifier[i], float(GetAmount()), apply);
}

void AuraEffect::HandleAuraModTotalThreat(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    //npcbot: handle for bots
    if (target->IsAlive() && target->IsNPCBotOrPet())
    {
        Unit* caster = GetCaster();
        if (caster && caster->IsAlive())
            target->getHostileRefMgr().addTempThreat((float)GetAmount(), apply);
        return;
    }
    //end npcbot

    if (!target->IsAlive() || target->GetTypeId() != TYPEID_PLAYER)
        return;

    Unit* caster = GetCaster();
    if (caster && caster->IsAlive())
        target->getHostileRefMgr().addTempThreat((float)GetAmount(), apply);
}

void AuraEffect::HandleModTaunt(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (!target->IsAlive() || !target->CanHaveThreatList())
        return;

    Unit* caster = GetCaster();
    if (!caster || !caster->IsAlive())
        return;

    if (apply)
        target->TauntApply(caster);
    else
    {
        // When taunt aura fades out, mob will switch to previous target if current has less than 1.1 * secondthreat
        target->TauntFadeOut(caster);
    }
}

/*****************************/
/***        CONTROL        ***/
/*****************************/

void AuraEffect::HandleModConfuse(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->SetControlled(apply, UNIT_STATE_CONFUSED);
}

void AuraEffect::HandleModFear(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->SetControlled(apply, UNIT_STATE_FLEEING, GetCaster(), true);
}

void AuraEffect::HandleAuraModStun(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->SetControlled(apply, UNIT_STATE_STUNNED);
}

void AuraEffect::HandleAuraModRoot(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->SetControlled(apply, UNIT_STATE_ROOT);
}

void AuraEffect::HandlePreventFleeing(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();
    // Since patch 3.0.2 this mechanic no longer affects fear effects. It will ONLY prevent humanoids from fleeing due to low health.
    if (target->GetTypeId() == TYPEID_PLAYER || !apply || target->HasAuraType(SPELL_AURA_MOD_FEAR))
        return;
    /// @todo: find a way to cancel fleeing for assistance.
    /// Currently this will only stop creatures fleeing due to low health that could not find nearby allies to flee towards.
    target->SetControlled(false, UNIT_STATE_FLEEING);
}

/***************************/
/***        CHARM        ***/
/***************************/

void AuraEffect::HandleModPossess(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    Unit* caster = GetCaster();

    // no support for posession AI yet
    if (caster && caster->GetTypeId() == TYPEID_UNIT)
    {
        HandleModCharm(aurApp, mode, apply);
        return;
    }

    if (apply)
        target->SetCharmedBy(caster, CHARM_TYPE_POSSESS, aurApp);
    else
        target->RemoveCharmedBy(caster);
}

void AuraEffect::HandleModPossessPet(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    // Used by spell "Eyes of the Beast"

    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* caster = GetCaster();
    if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
        return;

    //seems it may happen that when removing it is no longer owner's pet
    //if (caster->ToPlayer()->GetPet() != target)
    //    return;

    Unit* target = aurApp->GetTarget();
    if (target->GetTypeId() != TYPEID_UNIT || !target->IsPet())
        return;

    Pet* pet = target->ToPet();

    if (apply)
    {
        if (caster->ToPlayer()->GetPet() != pet)
            return;

        // Must clear current motion or pet leashes back to owner after a few yards
        //  when under spell 'Eyes of the Beast'
        pet->GetMotionMaster()->Clear();
        pet->SetCharmedBy(caster, CHARM_TYPE_POSSESS, aurApp);
    }
    else
    {
        pet->RemoveCharmedBy(caster);

        if (!pet->IsWithinDistInMap(caster, pet->GetMap()->GetVisibilityRange()))
            pet->Remove(PET_SAVE_NOT_IN_SLOT, true);
        else
        {
            // Reinitialize the pet bar or it will appear greyed out
            caster->ToPlayer()->PetSpellInitialize();

            // Follow owner only if not fighting or owner didn't click "stay" at new location
            // This may be confusing because pet bar shows "stay" when under the spell but it retains
            //  the "follow" flag. Player MUST click "stay" while under the spell.
            if (!pet->GetVictim() && !pet->GetCharmInfo()->HasCommandState(COMMAND_STAY))
            {
                pet->GetMotionMaster()->MoveFollow(caster, PET_FOLLOW_DIST, pet->GetFollowAngle());
            }
        }
    }
}

void AuraEffect::HandleModCharm(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    Unit* caster = GetCaster();

    if (apply)
        target->SetCharmedBy(caster, CHARM_TYPE_CHARM, aurApp);
    else
        target->RemoveCharmedBy(caster);
}

void AuraEffect::HandleCharmConvert(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    Unit* caster = GetCaster();

    if (apply)
        target->SetCharmedBy(caster, CHARM_TYPE_CONVERT, aurApp);
    else
        target->RemoveCharmedBy(caster);
}

/**
 * Such auras are applied from a caster(=player) to a vehicle.
 * This has been verified using spell #49256
 */
void AuraEffect::HandleAuraControlVehicle(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (!target->IsVehicle())
        return;

    Unit* caster = GetCaster();

    if (!caster || caster == target)
        return;

    if (apply)
    {
        // Currently spells that have base points  0 and DieSides 0 = "0/0" exception are pushed to -1,
        // however the idea of 0/0 is to ingore flag VEHICLE_SEAT_FLAG_CAN_ENTER_OR_EXIT and -1 checks for it,
        // so this break such spells or most of them.
        // Current formula about m_amount: effect base points + dieside - 1
        // TO DO: Reasearch more about 0/0 and fix it.
        caster->_EnterVehicle(target->GetVehicleKit(), m_amount - 1, aurApp);
    }
    else
    {
        if (GetId() == 53111) // Devour Humanoid
        {
            Unit::Kill(target, caster);
            if (caster->GetTypeId() == TYPEID_UNIT)
                caster->ToCreature()->RemoveCorpse();
        }

        caster->_ExitVehicle();
        // some SPELL_AURA_CONTROL_VEHICLE auras have a dummy effect on the player - remove them
        caster->RemoveAurasDueToSpell(GetId());
    }
}

/*********************************************************/
/***                  MODIFY SPEED                     ***/
/*********************************************************/
void AuraEffect::HandleAuraModIncreaseSpeed(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    target->UpdateSpeed(MOVE_RUN, true);

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }
}

void AuraEffect::HandleAuraModIncreaseMountedSpeed(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    HandleAuraModIncreaseSpeed(aurApp, mode, apply);
}

void AuraEffect::HandleAuraModIncreaseFlightSpeed(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();
    if (mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK)
        target->UpdateSpeed(MOVE_FLIGHT, true);

    //! Update ability to fly
    if (GetAuraType() == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED)
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK && (apply || (!target->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) && !target->HasAuraType(SPELL_AURA_FLY))))
        {
            target->SetCanFly(apply);

            if (!apply && target->GetTypeId() == TYPEID_UNIT && !target->IsLevitating())
                target->GetMotionMaster()->MoveFall();
        }

        //! Someone should clean up these hacks and remove it from this function. It doesn't even belong here.
        if (mode & AURA_EFFECT_HANDLE_REAL)
        {
            //Players on flying mounts must be immune to polymorph
            if (target->GetTypeId() == TYPEID_PLAYER)
                target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);

            // Dragonmaw Illusion (overwrite mount model, mounted aura already applied)
            if (apply && target->HasAuraEffect(42016, 0) && target->GetMountID())
                target->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 16314);
        }
    }

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }
}

void AuraEffect::HandleAuraModIncreaseSwimSpeed(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    target->UpdateSpeed(MOVE_SWIM, true);

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }
}

void AuraEffect::HandleAuraModDecreaseSpeed(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    target->UpdateSpeed(MOVE_WALK, true);
    target->UpdateSpeed(MOVE_RUN, true);
    target->UpdateSpeed(MOVE_SWIM, true);
    target->UpdateSpeed(MOVE_FLIGHT, true);
    target->UpdateSpeed(MOVE_RUN_BACK, true);
    target->UpdateSpeed(MOVE_SWIM_BACK, true);
    target->UpdateSpeed(MOVE_FLIGHT_BACK, true);

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }
}

void AuraEffect::HandleAuraModUseNormalSpeed(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->UpdateSpeed(MOVE_RUN,  true);
    target->UpdateSpeed(MOVE_SWIM, true);
    target->UpdateSpeed(MOVE_FLIGHT,  true);

    if (Player* targetPlayer = target->ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(targetPlayer);
    }
}

/*********************************************************/
/***                     IMMUNITY                      ***/
/*********************************************************/

void AuraEffect::HandleModStateImmunityMask(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();
    std::list <AuraType> aura_immunity_list;
    uint32 mechanic_immunity_list = 0;
    int32 miscVal = GetMiscValue();

    switch (miscVal)
    {
        case 96:
        case 1615:
            {
                if (!GetAmount())
                {
                    mechanic_immunity_list = (1 << MECHANIC_SNARE) | (1 << MECHANIC_ROOT)
                                             | (1 << MECHANIC_FEAR) | (1 << MECHANIC_STUN)
                                             | (1 << MECHANIC_SLEEP) | (1 << MECHANIC_CHARM)
                                             | (1 << MECHANIC_SAPPED) | (1 << MECHANIC_HORROR)
                                             | (1 << MECHANIC_POLYMORPH) | (1 << MECHANIC_DISORIENTED)
                                             | (1 << MECHANIC_FREEZE) | (1 << MECHANIC_TURN);

                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_CHARM);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_DECREASE_SPEED);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_ROOT);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_CONFUSE);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_FEAR);
                }
                break;
            }
        case 679:
            {
                if (GetId() == 57742)
                {
                    mechanic_immunity_list = (1 << MECHANIC_SNARE) | (1 << MECHANIC_ROOT)
                                             | (1 << MECHANIC_FEAR) | (1 << MECHANIC_STUN)
                                             | (1 << MECHANIC_SLEEP) | (1 << MECHANIC_CHARM)
                                             | (1 << MECHANIC_SAPPED) | (1 << MECHANIC_HORROR)
                                             | (1 << MECHANIC_POLYMORPH) | (1 << MECHANIC_DISORIENTED)
                                             | (1 << MECHANIC_FREEZE) | (1 << MECHANIC_TURN);

                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_DECREASE_SPEED);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_ROOT);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_CONFUSE);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_FEAR);
                }
                break;
            }
        case 1557:
            {
                if (GetId() == 64187)
                {
                    mechanic_immunity_list = (1 << MECHANIC_STUN);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);
                }
                else
                {
                    mechanic_immunity_list = (1 << MECHANIC_SNARE) | (1 << MECHANIC_ROOT)
                                             | (1 << MECHANIC_FEAR) | (1 << MECHANIC_STUN)
                                             | (1 << MECHANIC_SLEEP) | (1 << MECHANIC_CHARM)
                                             | (1 << MECHANIC_SAPPED) | (1 << MECHANIC_HORROR)
                                             | (1 << MECHANIC_POLYMORPH) | (1 << MECHANIC_DISORIENTED)
                                             | (1 << MECHANIC_FREEZE) | (1 << MECHANIC_TURN);

                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_DECREASE_SPEED);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_ROOT);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_CONFUSE);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_FEAR);
                }
                break;
            }
        case 1614:
        case 1694:
            {
                target->ApplySpellImmune(GetId(), IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, apply);
                aura_immunity_list.push_back(SPELL_AURA_MOD_TAUNT);
                break;
            }
        case 1630:
            {
                if (!GetAmount())
                {
                    target->ApplySpellImmune(GetId(), IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_TAUNT);
                }
                else
                {
                    mechanic_immunity_list = (1 << MECHANIC_SNARE) | (1 << MECHANIC_ROOT)
                                             | (1 << MECHANIC_FEAR) | (1 << MECHANIC_STUN)
                                             | (1 << MECHANIC_SLEEP) | (1 << MECHANIC_CHARM)
                                             | (1 << MECHANIC_SAPPED) | (1 << MECHANIC_HORROR)
                                             | (1 << MECHANIC_POLYMORPH) | (1 << MECHANIC_DISORIENTED)
                                             | (1 << MECHANIC_FREEZE) | (1 << MECHANIC_TURN);

                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_DECREASE_SPEED);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_ROOT);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_CONFUSE);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_FEAR);
                }
                break;
            }
        case 477:
        case 1733:
        case 1632:
            {
                if (!GetAmount())
                {
                    mechanic_immunity_list = (1 << MECHANIC_SNARE) | (1 << MECHANIC_ROOT)
                                             | (1 << MECHANIC_FEAR) | (1 << MECHANIC_STUN)
                                             | (1 << MECHANIC_SLEEP) | (1 << MECHANIC_CHARM)
                                             | (1 << MECHANIC_SAPPED) | (1 << MECHANIC_HORROR)
                                             | (1 << MECHANIC_POLYMORPH) | (1 << MECHANIC_DISORIENTED)
                                             | (1 << MECHANIC_FREEZE) | (1 << MECHANIC_TURN) | (1 << MECHANIC_BANISH);

                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_BANISH, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);

                    aura_immunity_list.push_back(SPELL_AURA_MOD_DECREASE_SPEED);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_ROOT);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_CONFUSE);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_FEAR);
                }
                break;
            }
        case 878:
            {
                if (GetAmount() == 1)
                {
                    mechanic_immunity_list = (1 << MECHANIC_SNARE) | (1 << MECHANIC_STUN)
                                             | (1 << MECHANIC_DISORIENTED) | (1 << MECHANIC_FREEZE);

                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
                    target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);
                    aura_immunity_list.push_back(SPELL_AURA_MOD_DECREASE_SPEED);
                }
                break;
            }
        default:
            break;
    }

    if (aura_immunity_list.empty())
    {
        // Roots, OK
        if (GetMiscValue() & (1 << 0))
        {
            mechanic_immunity_list = (1 << MECHANIC_SNARE);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
            aura_immunity_list.push_back(SPELL_AURA_MOD_ROOT);
        }
        // Taunt, OK
        if (GetMiscValue() & (1 << 1))
        {
            aura_immunity_list.push_back(SPELL_AURA_MOD_TAUNT);
        }
        // Crowd-Control auras?
        if (GetMiscValue() & (1 << 2))
        {
            mechanic_immunity_list = (1 << MECHANIC_POLYMORPH) | (1 << MECHANIC_DISORIENTED);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
            aura_immunity_list.push_back(SPELL_AURA_MOD_CONFUSE);
        }
        // Interrupt, OK
        if (GetMiscValue() & (1 << 3))
        {
            mechanic_immunity_list = (1 << MECHANIC_INTERRUPT);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_INTERRUPT, apply);
        }
        // Transform?
        if (GetMiscValue() & (1 << 4))
        {
            aura_immunity_list.push_back(SPELL_AURA_TRANSFORM);
        }
        // Stun auras breakable by damage (Incapacitate effects), OK
        if (GetMiscValue() & (1 << 5))
        {
            mechanic_immunity_list = (1 << MECHANIC_KNOCKOUT);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_KNOCKOUT, apply);
        }
        // // Slowing effects
        if (GetMiscValue() & (1 << 6))
        {
            mechanic_immunity_list = (1 << MECHANIC_SNARE);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
            aura_immunity_list.push_back(SPELL_AURA_MOD_DECREASE_SPEED);
        }
        // Charm auras?, 90%
        if ((GetMiscValue() & (1 << 7)))
        {
            mechanic_immunity_list = (1 << MECHANIC_CHARM);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
            aura_immunity_list.push_back(SPELL_AURA_MOD_CHARM);
            aura_immunity_list.push_back(SPELL_AURA_MOD_POSSESS);
        }
        // UNK
        // if ((GetMiscValue() & (1 << 8)))
        // {
        // }
        // Fear, OK
        if (GetMiscValue() & (1 << 9))
        {
            mechanic_immunity_list = (1 << MECHANIC_FEAR);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
            aura_immunity_list.push_back(SPELL_AURA_MOD_FEAR);
        }
        // Stuns, OK
        if (GetMiscValue() & (1 << 10))
        {
            mechanic_immunity_list = (1 << MECHANIC_STUN);

            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
            aura_immunity_list.push_back(SPELL_AURA_MOD_STUN);
        }
    }

    // apply immunities
    for (std::list <AuraType>::iterator iter = aura_immunity_list.begin(); iter != aura_immunity_list.end(); ++iter)
        target->ApplySpellImmune(GetId(), IMMUNITY_STATE, *iter, apply);

    // Patch 3.0.3 Bladestorm now breaks all snares and roots on the warrior when activated.
    if (GetId() == 46924)
    {
        // Knockback and hex
        target->ApplySpellImmune(GetId(), IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, apply);
    }

    if (apply && GetSpellInfo()->HasAttribute(SPELL_ATTR1_IMMUNITY_PURGES_EFFECT))
    {
        target->RemoveAurasWithMechanic(mechanic_immunity_list, AURA_REMOVE_BY_DEFAULT, GetId());
        for (std::list <AuraType>::iterator iter = aura_immunity_list.begin(); iter != aura_immunity_list.end(); ++iter)
            target->RemoveAurasByType(*iter);
    }
}

void AuraEffect::HandleModMechanicImmunity(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();
    uint32 mechanic = 0;

    switch (GetId())
    {
        case 46924: // BladeStorm
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
            break;
        case 34471: // The Beast Within
        case 19574: // Bestial Wrath
        case 38484: // Bestial Wrath
        case 40081: // Free friend (Black Temple)
            mechanic = IMMUNE_TO_MOVEMENT_IMPAIRMENT_AND_LOSS_CONTROL_MASK;
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_KNOCKOUT, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_BANISH, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SHACKLE, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_DAZE, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
            break;
        case 42292: // PvP trinket
        case 59752: // Every Man for Himself
        case 65547: // PvP trinket for Faction Champions (ToC 25)
        case 53490: // Bullheaded
        case 46227: // Medalion of Immunity
            mechanic = IMMUNE_TO_MOVEMENT_IMPAIRMENT_AND_LOSS_CONTROL_MASK;
            target->RemoveAurasByType(SPELL_AURA_PREVENTS_FLEEING); // xinef: Patch 2.3.0 PvP Trinkets: Insignia of the Alliance, Insignia of the Horde, Medallion of the Alliance, and Medallion of the Horde now clear the debuff from Judgement of Justice.
            // Actually we should apply immunities here, too, but the aura has only 100 ms duration, so there is practically no point
            break;
        case 54508: // Demonic Empowerment
            mechanic = (1 << MECHANIC_SNARE) | (1 << MECHANIC_ROOT);
            target->RemoveAurasByType(SPELL_AURA_MOD_STUN);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
            break;
        default:
            if (GetMiscValue() < 1)
                return;
            mechanic = 1 << GetMiscValue();
            target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, GetMiscValue(), apply);
            break;
    }

    if (apply && GetSpellInfo()->HasAttribute(SPELL_ATTR1_IMMUNITY_PURGES_EFFECT))
    {
        // Xinef: exception for purely snare mechanic (eg. hands of freedom)!
        if (mechanic == (1 << MECHANIC_SNARE))
            target->RemoveMovementImpairingAuras(false);
        else
            target->RemoveAurasWithMechanic(mechanic, AURA_REMOVE_BY_DEFAULT, GetId());
    }
}

void AuraEffect::HandleAuraModEffectImmunity(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplySpellImmune(GetId(), IMMUNITY_EFFECT, GetMiscValue(), apply);

    // when removing flag aura, handle flag drop
    Player* player = target->ToPlayer();
    if (!apply && player && (GetSpellInfo()->AuraInterruptFlags & AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION))
    {
        if (player->InBattleground())
        {
            if (Battleground* bg = player->GetBattleground())
                bg->EventPlayerDroppedFlag(player);
        }
        else
            sOutdoorPvPMgr->HandleDropFlag(player, GetSpellInfo()->Id);
    }

    //npcbot
    if (Creature* bot = target->ToCreature())
    {
        if (!apply && bot->IsNPCBot() && (GetSpellInfo()->AuraInterruptFlags & AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION))
        {
            if (Battleground* botbg = bot->GetBotBG())
                botbg->EventBotDroppedFlag(bot);
        }
    }
    //end npcbot
}

void AuraEffect::HandleAuraModStateImmunity(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplySpellImmune(GetId(), IMMUNITY_STATE, GetMiscValue(), apply);

    if (apply && GetSpellInfo()->HasAttribute(SPELL_ATTR1_IMMUNITY_PURGES_EFFECT))
        target->RemoveAurasByType(AuraType(GetMiscValue()), ObjectGuid::Empty, GetBase());
}

void AuraEffect::HandleAuraModSchoolImmunity(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplySpellImmune(GetId(), IMMUNITY_SCHOOL, GetMiscValue(), (apply));

    if (GetSpellInfo()->Mechanic == MECHANIC_BANISH)
    {
        if (apply)
            target->AddUnitState(UNIT_STATE_ISOLATED);
        else
        {
            bool banishFound = false;
            Unit::AuraEffectList const& banishAuras = target->GetAuraEffectsByType(GetAuraType());
            for (Unit::AuraEffectList::const_iterator i = banishAuras.begin(); i != banishAuras.end(); ++i)
                if ((*i)->GetSpellInfo()->Mechanic == MECHANIC_BANISH)
                {
                    banishFound = true;
                    break;
                }
            if (!banishFound)
                target->ClearUnitState(UNIT_STATE_ISOLATED);
        }
    }

    if (apply && GetMiscValue() == SPELL_SCHOOL_MASK_NORMAL)
        target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);

    // remove all flag auras (they are positive, but they must be removed when you are immune)
    if (GetSpellInfo()->HasAttribute(SPELL_ATTR1_IMMUNITY_PURGES_EFFECT)
            && GetSpellInfo()->HasAttribute(SPELL_ATTR2_FAIL_ON_ALL_TARGETS_IMMUNE))
        target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);

    /// @todo: optimalize this cycle - use RemoveAurasWithInterruptFlags call or something else
    if ((apply)
            && GetSpellInfo()->HasAttribute(SPELL_ATTR1_IMMUNITY_PURGES_EFFECT)
            && GetSpellInfo()->IsPositive())                       //Only positive immunity removes auras
    {
        uint32 school_mask = GetMiscValue();
        Unit::AuraApplicationMap& Auras = target->GetAppliedAuras();
        for (Unit::AuraApplicationMap::iterator iter = Auras.begin(); iter != Auras.end();)
        {
            SpellInfo const* spell = iter->second->GetBase()->GetSpellInfo();
            if ((spell->GetSchoolMask() & school_mask)//Check for school mask
                    && GetSpellInfo()->CanDispelAura(spell)
                    && !iter->second->IsPositive()          //Don't remove positive spells
                    && spell->Id != GetId())               //Don't remove self
            {
                target->RemoveAura(iter);
            }
            else
                ++iter;
        }
    }
}

void AuraEffect::HandleAuraModDmgImmunity(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplySpellImmune(GetId(), IMMUNITY_DAMAGE, GetMiscValue(), apply);
}

void AuraEffect::HandleAuraModDispelImmunity(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplySpellDispelImmunity(m_spellInfo, DispelType(GetMiscValue()), (apply));
}

/*********************************************************/
/***                  MODIFY STATS                     ***/
/*********************************************************/

/********************************/
/***        RESISTANCE        ***/
/********************************/

void AuraEffect::HandleAuraModResistanceExclusive(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    for (int8 x = SPELL_SCHOOL_NORMAL; x < MAX_SPELL_SCHOOL; x++)
    {
        if (GetMiscValue() & int32(1 << x))
        {
            int32 amount = target->GetMaxPositiveAuraModifierByMiscMask(SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE, 1 << x, this);
            if (amount < GetAmount())
            {
                float value = float(GetAmount() - amount);
                target->HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + x), BASE_VALUE, value, apply);
                if (target->GetTypeId() == TYPEID_PLAYER)
                    target->ApplyResistanceBuffModsMod(SpellSchools(x), aurApp->IsPositive(), value, apply);
            }
        }
    }
}

void AuraEffect::HandleAuraModResistance(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    for (int8 x = SPELL_SCHOOL_NORMAL; x < MAX_SPELL_SCHOOL; x++)
    {
        if (GetMiscValue() & int32(1 << x))
        {
            target->HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + x), TOTAL_VALUE, float(GetAmount()), apply);
            if (target->GetTypeId() == TYPEID_PLAYER || target->IsPet())
                target->ApplyResistanceBuffModsMod(SpellSchools(x), GetAmount() > 0, (float)GetAmount(), apply);
        }
    }
}

void AuraEffect::HandleAuraModBaseResistancePCT(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();
    for (int8 x = SPELL_SCHOOL_NORMAL; x < MAX_SPELL_SCHOOL; x++)
    {
        if (GetMiscValue() & int32(1 << x))
        {
            target->HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + x), BASE_PCT, float(GetAmount()), apply);
        }
    }
}

void AuraEffect::HandleModResistancePercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    for (int8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; i++)
    {
        if (GetMiscValue() & int32(1 << i))
        {
            target->HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + i), TOTAL_PCT, float(GetAmount()), apply);
            if (target->GetTypeId() == TYPEID_PLAYER || target->IsPet())
            {
                target->ApplyResistanceBuffModsPercentMod(SpellSchools(i), true, (float)GetAmount(), apply);
                target->ApplyResistanceBuffModsPercentMod(SpellSchools(i), false, (float)GetAmount(), apply);
            }
        }
    }
}

void AuraEffect::HandleModBaseResistance(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();
    for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; i++)
    {
        if (GetMiscValue() & (1 << i))
        {
            target->HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + i), TOTAL_VALUE, float(GetAmount()), apply);
        }
    }
}

void AuraEffect::HandleModTargetResistance(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    // applied to damage as HandleNoImmediateEffect in Unit::CalcAbsorbResist and Unit::CalcArmorReducedDamage

    // show armor penetration
    if (target->GetTypeId() == TYPEID_PLAYER && (GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL))
        target->ApplyModInt32Value(PLAYER_FIELD_MOD_TARGET_PHYSICAL_RESISTANCE, GetAmount(), apply);

    // show as spell penetration only full spell penetration bonuses (all resistances except armor and holy
    if (target->GetTypeId() == TYPEID_PLAYER && (GetMiscValue() & SPELL_SCHOOL_MASK_SPELL) == SPELL_SCHOOL_MASK_SPELL)
        target->ApplyModInt32Value(PLAYER_FIELD_MOD_TARGET_RESISTANCE, GetAmount(), apply);
}

/********************************/
/***           STAT           ***/
/********************************/

void AuraEffect::HandleAuraModStat(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (GetMiscValue() < -2 || GetMiscValue() > 4)
    {
        LOG_ERROR("spells.aura.effect", "WARNING: Spell {} effect {} has an unsupported misc value ({}) for SPELL_AURA_MOD_STAT ", GetId(), GetEffIndex(), GetMiscValue());
        return;
    }

    for (int32 i = STAT_STRENGTH; i < MAX_STATS; i++)
    {
        // -1 or -2 is all stats (misc < -2 checked in function beginning)
        if (GetMiscValue() < 0 || GetMiscValue() == i)
        {
            //target->ApplyStatMod(Stats(i), m_amount, apply);
            target->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_VALUE, float(GetAmount()), apply);
            if (target->GetTypeId() == TYPEID_PLAYER || target->IsPet())
                target->ApplyStatBuffMod(Stats(i), (float)GetAmount(), apply);
        }
    }
}

void AuraEffect::HandleModPercentStat(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (GetMiscValue() < -1 || GetMiscValue() > 4)
    {
        LOG_ERROR("spells.aura.effect", "WARNING: Misc Value for SPELL_AURA_MOD_PERCENT_STAT not valid");
        return;
    }

    // only players have base stats
    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
    {
        if (GetMiscValue() == i || GetMiscValue() == -1)
            target->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), BASE_PCT, float(m_amount), apply);
    }
}

void AuraEffect::HandleModSpellDamagePercentFromStat(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // Magic damage modifiers implemented in Unit::SpellDamageBonus
    // This information for client side use only
    // Recalculate bonus
    target->ToPlayer()->UpdateSpellDamageAndHealingBonus();
}

void AuraEffect::HandleModSpellHealingPercentFromStat(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // Recalculate bonus
    target->ToPlayer()->UpdateSpellDamageAndHealingBonus();
}

void AuraEffect::HandleModSpellDamagePercentFromAttackPower(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // Magic damage modifiers implemented in Unit::SpellDamageBonus
    // This information for client side use only
    // Recalculate bonus
    target->ToPlayer()->UpdateSpellDamageAndHealingBonus();
}

void AuraEffect::HandleModSpellHealingPercentFromAttackPower(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // Recalculate bonus
    target->ToPlayer()->UpdateSpellDamageAndHealingBonus();
}

void AuraEffect::HandleModHealingDone(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;
    // implemented in Unit::SpellHealingBonus
    // this information is for client side only
    target->ToPlayer()->UpdateSpellDamageAndHealingBonus();
}

void AuraEffect::HandleModTotalPercentStat(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (GetMiscValue() < -1 || GetMiscValue() > 4)
    {
        LOG_ERROR("spells.aura.effect", "WARNING: Misc Value for SPELL_AURA_MOD_PERCENT_STAT not valid");
        return;
    }

    // save current health state
    float healthPct = target->GetHealthPct();
    bool alive = target->IsAlive();
    float value = GetAmount();

    if (GetId() == 67480) // xinef: hack fix for blessing of sanctuary stats stack with blessing of kings...
    {
        if (value) // not turned off
            value = 10.0f;
        for (int32 i = STAT_STRENGTH; i < MAX_STATS; i++)
        {
            if (i == STAT_STRENGTH || i == STAT_STAMINA)
            {
                if (apply && (target->GetTypeId() == TYPEID_PLAYER || target->IsPet()))
                    target->ApplyStatPercentBuffMod(Stats(i), value, apply);

                target->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, value, apply);

                if (!apply && (target->GetTypeId() == TYPEID_PLAYER || target->IsPet()))
                    target->ApplyStatPercentBuffMod(Stats(i), value, apply);
            }
        }
        return;
    }

    for (int32 i = STAT_STRENGTH; i < MAX_STATS; i++)
    {
        if (GetMiscValue() == i || GetMiscValue() == -1)
        {
            if (apply && (target->GetTypeId() == TYPEID_PLAYER || target->IsPet()))
                target->ApplyStatPercentBuffMod(Stats(i), value, apply);

            target->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, value, apply);

            if (!apply && (target->GetTypeId() == TYPEID_PLAYER || target->IsPet()))
                target->ApplyStatPercentBuffMod(Stats(i), value, apply);
        }
    }

    // recalculate current HP/MP after applying aura modifications (only for spells with SPELL_ATTR0_UNK4 0x00000010 flag)
    if (GetMiscValue() == STAT_STAMINA && m_spellInfo->HasAttribute(SPELL_ATTR0_IS_ABILITY))
        target->SetHealth(std::max<uint32>(uint32(healthPct * target->GetMaxHealth() * 0.01f), (alive ? 1 : 0)));
}

void AuraEffect::HandleAuraModResistenceOfStatPercent(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    if (GetMiscValue() != SPELL_SCHOOL_MASK_NORMAL)
    {
        // support required adding replace UpdateArmor by loop by UpdateResistence at intellect update
        // and include in UpdateResistence same code as in UpdateArmor for aura mod apply.
        LOG_ERROR("spells.aura.effect", "Aura SPELL_AURA_MOD_RESISTANCE_OF_STAT_PERCENT(182) does not work for non-armor type resistances!");
        return;
    }

    // Recalculate Armor
    target->UpdateArmor();
}

void AuraEffect::HandleAuraModExpertise(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    target->ToPlayer()->UpdateExpertise(BASE_ATTACK);
    target->ToPlayer()->UpdateExpertise(OFF_ATTACK);
}

/********************************/
/***      HEAL & ENERGIZE     ***/
/********************************/
void AuraEffect::HandleModPowerRegen(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // Update manaregen value
    if (GetMiscValue() == POWER_MANA)
        target->ToPlayer()->UpdateManaRegen();
    else if (GetMiscValue() == POWER_RUNE)
        target->ToPlayer()->UpdateRuneRegen(RuneType(GetMiscValueB()));
    // other powers are not immediate effects - implemented in Player::Regenerate, Creature::Regenerate
}

void AuraEffect::HandleModPowerRegenPCT(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    HandleModPowerRegen(aurApp, mode, apply);
}

void AuraEffect::HandleModManaRegen(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    //Note: an increase in regen does NOT cause threat.
    target->ToPlayer()->UpdateManaRegen();
}

void AuraEffect::HandleAuraModIncreaseHealth(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
    {
        target->HandleStatModifier(UNIT_MOD_HEALTH, TOTAL_VALUE, float(GetAmount()), apply);
        target->ModifyHealth(GetAmount());
    }
    else
    {
        if (int32(target->GetHealth()) > GetAmount())
            target->ModifyHealth(-GetAmount());
        else
            target->SetHealth(1);
        target->HandleStatModifier(UNIT_MOD_HEALTH, TOTAL_VALUE, float(GetAmount()), apply);
    }
}

void AuraEffect::HandleAuraModIncreaseMaxHealth(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    uint32 oldhealth = target->GetHealth();
    double healthPercentage = (double)oldhealth / (double)target->GetMaxHealth();

    target->HandleStatModifier(UNIT_MOD_HEALTH, TOTAL_VALUE, float(GetAmount()), apply);

    // refresh percentage
    if (oldhealth > 0)
    {
        uint32 newhealth = uint32(std::ceil((double)target->GetMaxHealth() * healthPercentage));
        if (newhealth == 0)
            newhealth = 1;

        target->SetHealth(newhealth);
    }
}

void AuraEffect::HandleAuraModIncreaseEnergy(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    Powers PowerType = Powers(GetMiscValue());
    // do not check power type, we can always modify the maximum
    // as the client will not see any difference
    // also, placing conditions that may change during the aura duration
    // inside effect handlers is not a good idea
    //if (int32(PowerType) != GetMiscValue())
    //    return;

    UnitMods unitMod = UnitMods(static_cast<uint16>(UNIT_MOD_POWER_START) + PowerType);

    target->HandleStatModifier(unitMod, TOTAL_VALUE, float(GetAmount()), apply);
}

void AuraEffect::HandleAuraModIncreaseEnergyPercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    Powers PowerType = Powers(GetMiscValue());
    // do not check power type, we can always modify the maximum
    // as the client will not see any difference
    // also, placing conditions that may change during the aura duration
    // inside effect handlers is not a good idea
    //if (int32(PowerType) != GetMiscValue())
    //    return;

    UnitMods unitMod = UnitMods(static_cast<uint16>(UNIT_MOD_POWER_START) + PowerType);
    float amount = float(GetAmount());

    if (apply)
    {
        target->HandleStatModifier(unitMod, TOTAL_PCT, amount, apply);
        target->ModifyPowerPct(PowerType, amount, apply);
    }
    else
    {
        target->ModifyPowerPct(PowerType, amount, apply);
        target->HandleStatModifier(unitMod, TOTAL_PCT, amount, apply);
    }
}

void AuraEffect::HandleAuraModIncreaseHealthPercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    // Unit will keep hp% after MaxHealth being modified if unit is alive.
    float percent = target->GetHealthPct();
    target->HandleStatModifier(UNIT_MOD_HEALTH, TOTAL_PCT, float(GetAmount()), apply);

    // Xinef: pct was rounded down and could "kill" creature by setting its health to 0 making npc zombie
    if (target->IsAlive())
        if (uint32 healthAmount = CalculatePct(target->GetMaxHealth(), percent))
            target->SetHealth(healthAmount);
}

void AuraEffect::HandleAuraIncreaseBaseHealthPercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->HandleStatModifier(UNIT_MOD_HEALTH, BASE_PCT, float(GetAmount()), apply);
}

/********************************/
/***          FIGHT           ***/
/********************************/

void AuraEffect::HandleAuraModParryPercent(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    if (!target->ToPlayer()->CanParry())
        target->ToPlayer()->SetCanParry(true);
    else
        target->ToPlayer()->UpdateParryPercentage();
}

void AuraEffect::HandleAuraModDodgePercent(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    target->ToPlayer()->UpdateDodgePercentage();
}

void AuraEffect::HandleAuraModBlockPercent(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    target->ToPlayer()->UpdateBlockPercentage();
}

void AuraEffect::HandleAuraModRegenInterrupt(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    HandleModManaRegen(aurApp, mode, apply);
}

void AuraEffect::HandleAuraModWeaponCritPercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    for (int i = 0; i < MAX_ATTACK; ++i)
        if (Item* pItem = target->ToPlayer()->GetWeaponForAttack(WeaponAttackType(i), true))
            target->ToPlayer()->_ApplyWeaponDependentAuraCritMod(pItem, WeaponAttackType(i), this, apply);

    // mods must be applied base at equipped weapon class and subclass comparison
    // with spell->EquippedItemClass and  EquippedItemSubClassMask and EquippedItemInventoryTypeMask
    // GetMiscValue() comparison with item generated damage types

    if (GetSpellInfo()->EquippedItemClass == -1)
    {
        target->ToPlayer()->HandleBaseModValue(CRIT_PERCENTAGE,         FLAT_MOD, float (GetAmount()), apply);
        target->ToPlayer()->HandleBaseModValue(OFFHAND_CRIT_PERCENTAGE, FLAT_MOD, float (GetAmount()), apply);
        target->ToPlayer()->HandleBaseModValue(RANGED_CRIT_PERCENTAGE,  FLAT_MOD, float (GetAmount()), apply);
    }
    else
    {
        // done in Player::_ApplyWeaponDependentAuraMods
    }
}

void AuraEffect::HandleModHitChance(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() == TYPEID_PLAYER)
    {
        target->ToPlayer()->UpdateMeleeHitChances();
        target->ToPlayer()->UpdateRangedHitChances();
    }
    else
    {
        target->m_modMeleeHitChance += (apply) ? GetAmount() : (-GetAmount());
        target->m_modRangedHitChance += (apply) ? GetAmount() : (-GetAmount());
    }
}

void AuraEffect::HandleModSpellHitChance(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() == TYPEID_PLAYER)
        target->ToPlayer()->UpdateSpellHitChances();
    else
        target->m_modSpellHitChance += (apply) ? GetAmount() : (-GetAmount());
}

void AuraEffect::HandleModSpellCritChance(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() == TYPEID_PLAYER)
        target->ToPlayer()->UpdateAllSpellCritChances();
    else
        target->m_baseSpellCritChance += (apply) ? GetAmount() : -GetAmount();
}

void AuraEffect::HandleModSpellCritChanceShool(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    for (int school = SPELL_SCHOOL_NORMAL; school < MAX_SPELL_SCHOOL; ++school)
        if (GetMiscValue() & (1 << school))
            target->ToPlayer()->UpdateSpellCritChance(school);
}

void AuraEffect::HandleAuraModCritPct(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
    {
        target->m_baseSpellCritChance += (apply) ? GetAmount() : -GetAmount();
        return;
    }

    target->ToPlayer()->HandleBaseModValue(CRIT_PERCENTAGE,         FLAT_MOD, float (GetAmount()), apply);
    target->ToPlayer()->HandleBaseModValue(OFFHAND_CRIT_PERCENTAGE, FLAT_MOD, float (GetAmount()), apply);
    target->ToPlayer()->HandleBaseModValue(RANGED_CRIT_PERCENTAGE,  FLAT_MOD, float (GetAmount()), apply);

    // included in Player::UpdateSpellCritChance calculation
    target->ToPlayer()->UpdateAllSpellCritChances();
}

/********************************/
/***         ATTACK SPEED     ***/
/********************************/

void AuraEffect::HandleModCastingSpeed(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    // Xinef: Do not apply such auras in normal way
    if (GetAmount() >= 1000)
    {
        target->SetInstantCast(apply);
        return;
    }

    target->ApplyCastTimePercentMod((float)GetAmount(), apply);
}

void AuraEffect::HandleModMeleeRangedSpeedPct(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplyAttackTimePercentMod(BASE_ATTACK, (float)GetAmount(), apply);
    target->ApplyAttackTimePercentMod(OFF_ATTACK, (float)GetAmount(), apply);
    target->ApplyAttackTimePercentMod(RANGED_ATTACK, (float)GetAmount(), apply);
}

void AuraEffect::HandleModCombatSpeedPct(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplyCastTimePercentMod(float(GetAmount()), apply);
    target->ApplyAttackTimePercentMod(BASE_ATTACK, float(GetAmount()), apply);
    target->ApplyAttackTimePercentMod(OFF_ATTACK, float(GetAmount()), apply);
    target->ApplyAttackTimePercentMod(RANGED_ATTACK, float(GetAmount()), apply);
}

void AuraEffect::HandleModAttackSpeed(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplyAttackTimePercentMod(BASE_ATTACK, float(GetAmount()), apply);
    target->UpdateDamagePhysical(BASE_ATTACK);
}

void AuraEffect::HandleModMeleeSpeedPct(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplyAttackTimePercentMod(BASE_ATTACK, float(GetAmount()), apply);
    target->ApplyAttackTimePercentMod(OFF_ATTACK,  float(GetAmount()), apply);
}

void AuraEffect::HandleAuraModRangedHaste(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->ApplyAttackTimePercentMod(RANGED_ATTACK, (float)GetAmount(), apply);
}

void AuraEffect::HandleRangedAmmoHaste(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    target->ApplyAttackTimePercentMod(RANGED_ATTACK, (float)GetAmount(), apply);
}

/********************************/
/***       COMBAT RATING      ***/
/********************************/

void AuraEffect::HandleModRating(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    for (uint32 rating = 0; rating < MAX_COMBAT_RATING; ++rating)
        if (GetMiscValue() & (1 << rating))
            target->ToPlayer()->ApplyRatingMod(CombatRating(rating), GetAmount(), apply);
}

void AuraEffect::HandleModRatingFromStat(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // Just recalculate ratings
    for (uint32 rating = 0; rating < MAX_COMBAT_RATING; ++rating)
        if (GetMiscValue() & (1 << rating))
            target->ToPlayer()->ApplyRatingMod(CombatRating(rating), 0, apply);
}

/********************************/
/***        ATTACK POWER      ***/
/********************************/

void AuraEffect::HandleAuraModAttackPower(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->HandleStatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, float(GetAmount()), apply);
}

void AuraEffect::HandleAuraModRangedAttackPower(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if ((target->getClassMask() & CLASSMASK_WAND_USERS) != 0)
        return;

    target->HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(GetAmount()), apply);
}

void AuraEffect::HandleAuraModAttackPowerPercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    //UNIT_FIELD_ATTACK_POWER_MULTIPLIER = multiplier - 1
    target->HandleStatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_PCT, float(GetAmount()), apply);
}

void AuraEffect::HandleAuraModRangedAttackPowerPercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    if ((target->getClassMask() & CLASSMASK_WAND_USERS) != 0)
        return;

    //UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER = multiplier - 1
    target->HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_PCT, float(GetAmount()), apply);
}

void AuraEffect::HandleAuraModRangedAttackPowerOfStatPercent(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    // Recalculate bonus
    if (target->GetTypeId() == TYPEID_PLAYER && !(target->getClassMask() & CLASSMASK_WAND_USERS))
        target->ToPlayer()->UpdateAttackPowerAndDamage(true);
}

void AuraEffect::HandleAuraModAttackPowerOfStatPercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    HandleAuraModAttackPowerOfArmor(aurApp, mode, apply);
}

void AuraEffect::HandleAuraModAttackPowerOfArmor(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    // Recalculate bonus
    if (target->GetTypeId() == TYPEID_PLAYER)
        target->ToPlayer()->UpdateAttackPowerAndDamage(false);
}
/********************************/
/***        DAMAGE BONUS      ***/
/********************************/
void AuraEffect::HandleModDamageDone(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    // apply item specific bonuses for already equipped weapon
    if (target->GetTypeId() == TYPEID_PLAYER)
    {
        for (int i = 0; i < MAX_ATTACK; ++i)
            if (Item* pItem = target->ToPlayer()->GetWeaponForAttack(WeaponAttackType(i), true))
                target->ToPlayer()->_ApplyWeaponDependentAuraDamageMod(pItem, WeaponAttackType(i), this, apply);
    }

    // GetMiscValue() is bitmask of spell schools
    // 1 (0-bit) - normal school damage (SPELL_SCHOOL_MASK_NORMAL)
    // 126 - full bitmask all magic damages (SPELL_SCHOOL_MASK_MAGIC) including wands
    // 127 - full bitmask any damages
    //
    // mods must be applied base at equipped weapon class and subclass comparison
    // with spell->EquippedItemClass and  EquippedItemSubClassMask and EquippedItemInventoryTypeMask
    // GetMiscValue() comparison with item generated damage types

    if ((GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL) != 0 && sScriptMgr->CanModAuraEffectDamageDone(this, target, aurApp, mode, apply))
    {
        // apply generic physical damage bonuses including wand case
        if (GetSpellInfo()->EquippedItemClass == -1 || target->GetTypeId() != TYPEID_PLAYER)
        {
            target->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_VALUE, float(GetAmount()), apply);
            target->HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_VALUE, float(GetAmount()), apply);
            target->HandleStatModifier(UNIT_MOD_DAMAGE_RANGED, TOTAL_VALUE, float(GetAmount()), apply);

            if (target->GetTypeId() == TYPEID_PLAYER)
            {
                if (GetAmount() > 0)
                    target->ApplyModInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS, GetAmount(), apply);
                else
                    target->ApplyModInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG, GetAmount(), apply);
            }
        }
        else
        {
            // done in Player::_ApplyWeaponDependentAuraMods
        }
    }

    // Skip non magic case for Speedup
    if ((GetMiscValue() & SPELL_SCHOOL_MASK_MAGIC) == 0)
        return;

    if (GetSpellInfo()->EquippedItemClass != -1 || GetSpellInfo()->EquippedItemInventoryTypeMask != 0)
    {
        // wand magic case (skip generic to all item spell bonuses)
        // done in Player::_ApplyWeaponDependentAuraMods

        // Skip item specific requirements for not wand magic damage
        return;
    }

    // Magic damage modifiers implemented in Unit::SpellDamageBonus
    // This information for client side use only
    if (target->GetTypeId() == TYPEID_PLAYER)
    {
        if (GetAmount() > 0)
        {
            for (uint32 i = SPELL_SCHOOL_HOLY; i < MAX_SPELL_SCHOOL; i++)
            {
                if ((GetMiscValue() & (1 << i)) != 0)
                    target->ApplyModInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + i, GetAmount(), apply);
            }
        }
        else
        {
            for (uint32 i = SPELL_SCHOOL_HOLY; i < MAX_SPELL_SCHOOL; i++)
            {
                if ((GetMiscValue() & (1 << i)) != 0)
                    target->ApplyModInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + i, GetAmount(), apply);
            }
        }
        if (Guardian* pet = target->ToPlayer()->GetGuardianPet())
            pet->UpdateAttackPowerAndDamage();
    }
}

void AuraEffect::HandleModDamagePercentDone(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();
    if (!target)
        return;

    if (!sScriptMgr->CanModAuraEffectModDamagePercentDone(this, target, aurApp, mode, apply))
        return;

    if (target->GetTypeId() == TYPEID_PLAYER)
    {
        for (int i = 0; i < MAX_ATTACK; ++i)
            if (Item* item = target->ToPlayer()->GetWeaponForAttack(WeaponAttackType(i), false))
                target->ToPlayer()->_ApplyWeaponDependentAuraDamageMod(item, WeaponAttackType(i), this, apply);
    }

    if ((GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL) && (GetSpellInfo()->EquippedItemClass == -1 || target->GetTypeId() != TYPEID_PLAYER))
    {
        target->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, float(GetAmount()), apply);
        target->HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND,  TOTAL_PCT, float(GetAmount()), apply);
        target->HandleStatModifier(UNIT_MOD_DAMAGE_RANGED,   TOTAL_PCT, float(GetAmount()), apply);

        if (target->GetTypeId() == TYPEID_PLAYER)
            target->ToPlayer()->ApplyPercentModFloatValue(PLAYER_FIELD_MOD_DAMAGE_DONE_PCT, float (GetAmount()), apply);
    }
    else
    {
        // done in Player::_ApplyWeaponDependentAuraMods for SPELL_SCHOOL_MASK_NORMAL && EquippedItemClass != -1 and also for wand case
    }
}

void AuraEffect::HandleModOffhandDamagePercent(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    target->HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_PCT, float(GetAmount()), apply);
}

void AuraEffect::HandleShieldBlockValue(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_STAT)))
        return;

    Unit* target = aurApp->GetTarget();

    BaseModType modType = FLAT_MOD;
    if (GetAuraType() == SPELL_AURA_MOD_SHIELD_BLOCKVALUE_PCT)
        modType = PCT_MOD;

    if (target->GetTypeId() == TYPEID_PLAYER)
        target->ToPlayer()->HandleBaseModValue(SHIELD_BLOCK_VALUE, modType, float(GetAmount()), apply);
}

/********************************/
/***        POWER COST        ***/
/********************************/

void AuraEffect::HandleModPowerCostPCT(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    float amount = CalculatePct(1.0f, GetAmount());
    for (int i = 0; i < MAX_SPELL_SCHOOL; ++i)
        if (GetMiscValue() & (1 << i))
            target->ApplyModSignedFloatValue(UNIT_FIELD_POWER_COST_MULTIPLIER + i, amount, apply);
}

void AuraEffect::HandleModPowerCost(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    for (int i = 0; i < MAX_SPELL_SCHOOL; ++i)
        if (GetMiscValue() & (1 << i))
            target->ApplyModInt32Value(UNIT_FIELD_POWER_COST_MODIFIER + i, GetAmount(), apply);
}

void AuraEffect::HandleArenaPreparation(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
        target->SetUnitFlag(UNIT_FLAG_PREPARATION);
    else
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
        target->RemoveUnitFlag(UNIT_FLAG_PREPARATION);
    }
}

void AuraEffect::HandleNoReagentUseAura(AuraApplication const* aurApp, uint8 mode, bool /*apply*/) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    flag96 mask;
    Unit::AuraEffectList const& noReagent = target->GetAuraEffectsByType(SPELL_AURA_NO_REAGENT_USE);
    for (Unit::AuraEffectList::const_iterator i = noReagent.begin(); i != noReagent.end(); ++i)
        mask |= (*i)->m_spellInfo->Effects[(*i)->m_effIndex].SpellClassMask;

    target->SetUInt32Value(PLAYER_NO_REAGENT_COST_1, mask[0]);
    target->SetUInt32Value(PLAYER_NO_REAGENT_COST_1 + 1, mask[1]);
    target->SetUInt32Value(PLAYER_NO_REAGENT_COST_1 + 2, mask[2]);
}

void AuraEffect::HandleAuraRetainComboPoints(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    // combo points was added in SPELL_EFFECT_ADD_COMBO_POINTS handler
    // remove only if aura expire by time (in case combo points amount change aura removed without combo points lost)
    if (!(apply) && GetBase()->GetDuration() == 0)
        target->AddComboPoints(-GetAmount());
}

/*********************************************************/
/***                    OTHERS                         ***/
/*********************************************************/

void AuraEffect::HandleAuraDummy(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & (AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK | AURA_EFFECT_HANDLE_REAPPLY)))
        return;

    Unit* target = aurApp->GetTarget();

    Unit* caster = GetCaster();

    if (mode & AURA_EFFECT_HANDLE_REAL)
    {
        // pet auras
        if (PetAura const* petSpell = sSpellMgr->GetPetAura(GetId(), m_effIndex))
        {
            if (apply)
                target->AddPetAura(petSpell);
            else
                target->RemovePetAura(petSpell);
        }
    }

    if (mode & (AURA_EFFECT_HANDLE_REAL | AURA_EFFECT_HANDLE_REAPPLY))
    {
        // AT APPLY
        if (apply)
        {
            switch (GetId())
            {
                case 1515:                                      // Tame beast
                    // FIX_ME: this is 2.0.12 threat effect replaced in 2.1.x by dummy aura, must be checked for correctness
                    if (caster && target->CanHaveThreatList())
                        target->AddThreat(caster, 10.0f);
                    break;
                case 34026:   // kill command
                    {
                        Unit* pet = target->GetGuardianPet();
                        if (!pet)
                            break;

                        target->CastSpell(target, 34027, true, nullptr, this);

                        // set 3 stacks and 3 charges (to make all auras not disappear at once)
                        Aura* owner_aura = target->GetAura(34027, GetCasterGUID());
                        Aura* pet_aura  = pet->GetAura(58914, GetCasterGUID());
                        if (owner_aura)
                        {
                            owner_aura->SetCharges(0);
                            owner_aura->SetStackAmount(owner_aura->GetSpellInfo()->StackAmount);
                            if (pet_aura)
                            {
                                pet_aura->SetCharges(0);
                                pet_aura->SetStackAmount(owner_aura->GetSpellInfo()->StackAmount);
                            }
                        }
                        break;
                    }
                case 37096:                                     // Blood Elf Illusion
                    {
                        if (caster)
                        {
                            switch (caster->getGender())
                            {
                                case GENDER_FEMALE:
                                    caster->CastSpell(target, 37095, true, nullptr, this); // Blood Elf Disguise
                                    break;
                                case GENDER_MALE:
                                    caster->CastSpell(target, 37093, true, nullptr, this);
                                    break;
                                default:
                                    break;
                            }
                        }
                        break;
                    }
                case 55198:   // Tidal Force
                    {
                        target->CastSpell(target, 55166, true);
                        if (Aura* owner_aura = target->GetAura(55166))
                            owner_aura->SetStackAmount(owner_aura->GetSpellInfo()->StackAmount);
                        return;
                    }
                case 39850:                                     // Rocket Blast
                    if (roll_chance_i(20))                       // backfire stun
                        target->CastSpell(target, 51581, true, nullptr, this);
                    break;
                case 43873:                                     // Headless Horseman Laugh
                    target->PlayDistanceSound(11965);
                    break;
                case 46354:                                     // Blood Elf Illusion
                    if (caster)
                    {
                        switch (caster->getGender())
                        {
                            case GENDER_FEMALE:
                                caster->CastSpell(target, 46356, true, nullptr, this);
                                break;
                            case GENDER_MALE:
                                caster->CastSpell(target, 46355, true, nullptr, this);
                                break;
                        }
                    }
                    break;
                case 46361:                                     // Reinforced Net
                    if (caster)
                        target->GetMotionMaster()->MoveFall();
                    break;
                case 46699:                                     // Requires No Ammo
                    if (target->GetTypeId() == TYPEID_PLAYER)
                        target->ToPlayer()->RemoveAmmo();      // not use ammo and not allow use
                    break;
                case 71563:
                    {
                        if (Aura* newAura = target->AddAura(71564, target))
                            newAura->SetStackAmount(newAura->GetSpellInfo()->StackAmount);
                        return;
                    }
            }
        }
        // AT REMOVE
        else
        {
            if ((GetSpellInfo()->IsQuestTame()) && caster && caster->IsAlive() && target->IsAlive() && aurApp->GetRemoveMode() != AURA_REMOVE_BY_CANCEL)
            {
                uint32 finalSpelId = 0;
                switch (GetId())
                {
                    case 19548:
                        finalSpelId = 19597;
                        break;
                    case 19674:
                        finalSpelId = 19677;
                        break;
                    case 19687:
                        finalSpelId = 19676;
                        break;
                    case 19688:
                        finalSpelId = 19678;
                        break;
                    case 19689:
                        finalSpelId = 19679;
                        break;
                    case 19692:
                        finalSpelId = 19680;
                        break;
                    case 19693:
                        finalSpelId = 19684;
                        break;
                    case 19694:
                        finalSpelId = 19681;
                        break;
                    case 19696:
                        finalSpelId = 19682;
                        break;
                    case 19697:
                        finalSpelId = 19683;
                        break;
                    case 19699:
                        finalSpelId = 19685;
                        break;
                    case 19700:
                        finalSpelId = 19686;
                        break;
                    case 30646:
                        finalSpelId = 30647;
                        break;
                    case 30653:
                        finalSpelId = 30648;
                        break;
                    case 30654:
                        finalSpelId = 30652;
                        break;
                    case 30099:
                        finalSpelId = 30100;
                        break;
                    case 30102:
                        finalSpelId = 30103;
                        break;
                    case 30105:
                        finalSpelId = 30104;
                        break;
                }

                if (finalSpelId)
                    caster->CastSpell(target, finalSpelId, true, nullptr, this);
            }

            switch (m_spellInfo->SpellFamilyName)
            {
                case SPELLFAMILY_GENERIC:
                    switch (GetId())
                    {
                        case 2584: // Waiting to Resurrect
                            // Waiting to resurrect spell cancel, we must remove player from resurrect queue
                            if (target->GetTypeId() == TYPEID_PLAYER)
                            {
                                if (Battleground* bg = target->ToPlayer()->GetBattleground())
                                    bg->RemovePlayerFromResurrectQueue(target->ToPlayer());
                                if(Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(target->GetZoneId()))
                                    bf->RemovePlayerFromResurrectQueue(target->GetGUID());
                            }
                            break;
                        case 43681: // Inactive
                            {
                                if (target->GetTypeId() != TYPEID_PLAYER || aurApp->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
                                    return;

                                if (target->GetMap()->IsBattleground())
                                    target->ToPlayer()->LeaveBattleground();
                                break;
                            }
                        case 52172:  // Coyote Spirit Despawn Aura
                        case 60244:  // Blood Parrot Despawn Aura
                            target->CastSpell((Unit*)nullptr, GetAmount(), true, nullptr, this);
                            break;
                        // Halls of Lightning, Arc Lightning
                        case 52921:
                            {
                                if( aurApp->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE )
                                    return;

                                Player* player = nullptr;
                                Acore::AnyPlayerInObjectRangeCheck checker(target, 10.0f);
                                Acore::PlayerSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(target, player, checker);
                                Cell::VisitWorldObjects(target, searcher, 10.0f);

                                if( player && player->GetGUID() != target->GetGUID() )
                                    target->CastSpell(player, 52921, true);

                                return;
                            }
                        case 58600: // Restricted Flight Area
                        case 58730: // Restricted Flight Area
                            if (aurApp->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
                                target->CastSpell(target, 58601, true);
                            break;
                        case 46374: // quest The Power of the Elements (11893)
                            {
                                if (target->isDead() && GetBase() && target->GetTypeId() == TYPEID_UNIT && target->GetEntry() == 24601)
                                {
                                    auto caster2 = GetBase()->GetCaster();
                                    if (caster2 && caster2->GetTypeId() == TYPEID_PLAYER)
                                    {
                                        caster2->ToPlayer()->KilledMonsterCredit(25987);
                                    }
                                }
                                return;
                            }
                    }
                    break;
                default:
                    break;
            }
        }
    }

    // AT APPLY & REMOVE

    switch (m_spellInfo->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            {
                if (!(mode & AURA_EFFECT_HANDLE_REAL))
                    break;
                switch (GetId())
                {
                    // Recently Bandaged
                    case 11196:
                        target->ApplySpellImmune(GetId(), IMMUNITY_MECHANIC, GetMiscValue(), apply);
                        break;
                    // Unstable Power
                    case 24658:
                        {
                            uint32 spellId = 24659;
                            if (apply && caster)
                            {
                                SpellInfo const* spell = sSpellMgr->AssertSpellInfo(spellId);

                                for (uint32 i = 0; i < spell->StackAmount; ++i)
                                    caster->CastSpell(target, spell->Id, true, nullptr, nullptr, GetCasterGUID());
                                break;
                            }
                            target->RemoveAurasDueToSpell(spellId);
                            break;
                        }
                    // Restless Strength
                    case 24661:
                        {
                            uint32 spellId = 24662;
                            if (apply && caster)
                            {
                                SpellInfo const* spell = sSpellMgr->AssertSpellInfo(spellId);
                                for (uint32 i = 0; i < spell->StackAmount; ++i)
                                    caster->CastSpell(target, spell->Id, true, nullptr, nullptr, GetCasterGUID());
                                break;
                            }
                            target->RemoveAurasDueToSpell(spellId);
                            break;
                        }
                    // Tag Murloc
                    case 30877:
                        {
                            // Tag/untag Blacksilt Scout
                            target->SetEntry(apply ? 17654 : 17326);
                            break;
                        }
                    case 57819: // Argent Champion
                    case 57820: // Ebon Champion
                    case 57821: // Champion of the Kirin Tor
                    case 57822: // Wyrmrest Champion
                        {
                            if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
                                break;

                            uint32 FactionID = 0;

                            if (apply)
                            {
                                switch (m_spellInfo->Id)
                                {
                                    case 57819:
                                        FactionID = 1106;
                                        break; // Argent Crusade
                                    case 57820:
                                        FactionID = 1098;
                                        break; // Knights of the Ebon Blade
                                    case 57821:
                                        FactionID = 1090;
                                        break; // Kirin Tor
                                    case 57822:
                                        FactionID = 1091;
                                        break; // The Wyrmrest Accord
                                }
                            }
                            caster->ToPlayer()->SetChampioningFaction(FactionID);
                            break;
                        }
                    // LK Intro VO (1)
                    case 58204:
                        if (target->GetTypeId() == TYPEID_PLAYER)
                        {
                            // Play part 1
                            if (apply)
                                target->PlayDirectSound(14970, target->ToPlayer());
                            // continue in 58205
                            else
                                target->CastSpell(target, 58205, true);
                        }
                        break;
                    // LK Intro VO (2)
                    case 58205:
                        if (target->GetTypeId() == TYPEID_PLAYER)
                        {
                            // Play part 2
                            if (apply)
                                target->PlayDirectSound(14971, target->ToPlayer());
                            // Play part 3
                            else
                                target->PlayDirectSound(14972, target->ToPlayer());
                        }
                        break;
                    case 62061: // Festive Holiday Mount
                        if (target->HasAuraType(SPELL_AURA_MOUNTED))
                        {
                            uint32 creatureEntry = 0;
                            if (apply)
                            {
                                if (target->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                                    creatureEntry = 24906;
                                else
                                    creatureEntry = 15665;
                            }
                            else
                                creatureEntry = target->GetAuraEffectsByType(SPELL_AURA_MOUNTED).front()->GetMiscValue();

                            if (CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creatureEntry))
                            {
                                CreatureModel model = *ObjectMgr::ChooseDisplayId(creatureInfo);
                                sObjectMgr->GetCreatureModelRandomGender(&model, creatureInfo);

                                target->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, model.CreatureDisplayID);
                            }
                        }
                        break;
                    case FRESH_BREWFEST_HOPS: // Festive Brewfest Mount
                        if (target->HasAuraType(SPELL_AURA_MOUNTED) && !target->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                        {
                            uint32 creatureEntry = 0;

                            if (apply)
                            {
                                if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
                                {
                                    creatureEntry = GREAT_BREWFEST_KODO;
                                }
                                else
                                {
                                    creatureEntry = BREWFEST_KODO;
                                }
                            }
                            else
                            {
                                creatureEntry = target->GetAuraEffectsByType(SPELL_AURA_MOUNTED).front()->GetMiscValue();
                            }

                            if (CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creatureEntry))
                            {
                                CreatureModel model = *ObjectMgr::ChooseDisplayId(creatureInfo);
                                sObjectMgr->GetCreatureModelRandomGender(&model, creatureInfo);

                                target->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, model.CreatureDisplayID);
                            }
                        }
                        break;
                }

                break;
            }
        case SPELLFAMILY_MAGE:
            {
                //if (!(mode & AURA_EFFECT_HANDLE_REAL))
                //break;
                break;
            }
        case SPELLFAMILY_PRIEST:
            {
                //if (!(mode & AURA_EFFECT_HANDLE_REAL))
                //break;
                break;
            }
        case SPELLFAMILY_DRUID:
            {
                //if (!(mode & AURA_EFFECT_HANDLE_REAL))
                //    break;
                break;
            }
        case SPELLFAMILY_SHAMAN:
            {
                //if (!(mode & AURA_EFFECT_HANDLE_REAL))
                //    break;
                break;
            }
    }
}

void AuraEffect::HandleChannelDeathItem(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    if (apply || aurApp->GetRemoveMode() != AURA_REMOVE_BY_DEATH)
        return;

    Unit* caster = GetCaster();

    if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* plCaster = caster->ToPlayer();

    // Item amount
    if (GetAmount() <= 0)
        return;

    if (GetSpellInfo()->Effects[m_effIndex].ItemType == 0)
        return;

    //Adding items
    uint32 noSpaceForCount = 0;
    uint32 count = m_amount;

    ItemPosCountVec dest;
    InventoryResult msg = plCaster->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, GetSpellInfo()->Effects[m_effIndex].ItemType, count, &noSpaceForCount);
    if (msg != EQUIP_ERR_OK)
    {
        count -= noSpaceForCount;
        plCaster->SendEquipError(msg, nullptr, nullptr, GetSpellInfo()->Effects[m_effIndex].ItemType);
        if (count == 0)
            return;
    }

    Item* newitem = plCaster->StoreNewItem(dest, GetSpellInfo()->Effects[m_effIndex].ItemType, true);
    if (!newitem)
    {
        plCaster->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, nullptr, nullptr);
        return;
    }
    plCaster->SendNewItem(newitem, count, true, true);
}

void AuraEffect::HandleBindSight(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    Unit* caster = GetCaster();

    if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
        return;

    caster->ToPlayer()->SetViewpoint(target, apply);
}

void AuraEffect::HandleFarSight(AuraApplication const* /*aurApp*/, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
    {
        return;
    }

    Unit* caster = GetCaster();
    if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
    {
        return;
    }

    Player* player = caster->ToPlayer();
    if (apply)
    {
        player->SetFarSightDistance(m_spellInfo->GetMaxRange());
    }
    else
    {
        player->ResetFarSightDistance();
    }

    caster->UpdateObjectVisibility(!apply);
}

void AuraEffect::HandleForceReaction(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* player = target->ToPlayer();

    uint32 faction_id = GetMiscValue();
    ReputationRank faction_rank = ReputationRank(m_amount);

    player->GetReputationMgr().ApplyForceReaction(faction_id, faction_rank, apply);
    player->GetReputationMgr().SendForceReactions();

    // stop fighting if at apply forced rank friendly or at remove real rank friendly
    if ((apply && faction_rank >= REP_FRIENDLY) || (!apply && player->GetReputationRank(faction_id) >= REP_FRIENDLY))
        player->StopAttackFaction(faction_id);
}

void AuraEffect::HandleAuraEmpathy(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (!apply)
    {
        // do not remove unit flag if there are more than this auraEffect of that kind on unit on unit
        if (target->HasAuraType(GetAuraType()))
            return;
    }

    if (target->GetCreatureType() == CREATURE_TYPE_BEAST)
        target->ApplyModUInt32Value(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_SPECIALINFO, apply);
}

void AuraEffect::HandleAuraModFaction(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
    {
        target->SetFaction(GetMiscValue());
        if (target->GetTypeId() == TYPEID_PLAYER)
            target->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    }
    else
    {
        target->RestoreFaction();
        if (target->GetTypeId() == TYPEID_PLAYER)
            target->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    }
}

void AuraEffect::HandleComprehendLanguage(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK))
        return;

    Unit* target = aurApp->GetTarget();

    if (apply)
        target->SetUnitFlag2(UNIT_FLAG2_COMPREHEND_LANG);
    else
    {
        if (target->HasAuraType(GetAuraType()))
            return;

        target->RemoveUnitFlag2(UNIT_FLAG2_COMPREHEND_LANG);
    }
}

void AuraEffect::HandleAuraConvertRune(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* player = target->ToPlayer();

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        return;

    uint32 runes = m_amount;
    // convert number of runes specified in aura amount of rune type in miscvalue to runetype in miscvalueb
    if (apply)
    {
        for (uint32 i = 0; i < MAX_RUNES && runes; ++i)
        {
            if (GetMiscValue() != player->GetCurrentRune(i))
                continue;
            if (!player->GetRuneCooldown(i))
            {
                player->AddRuneByAuraEffect(i, RuneType(GetMiscValueB()), this);
                --runes;
            }
        }
    }
    else
        player->RemoveRunesByAuraEffect(this);
}

void AuraEffect::HandleAuraLinked(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    Unit* target = aurApp->GetTarget();

    uint32 triggeredSpellId = sSpellMgr->GetSpellIdForDifficulty(m_spellInfo->Effects[m_effIndex].TriggerSpell, target);
    SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(triggeredSpellId);
    if (!triggeredSpellInfo)
        return;

    if (mode & AURA_EFFECT_HANDLE_REAL)
    {
        if (apply)
        {
            Unit* caster = triggeredSpellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, GetEffIndex()) ? GetCaster() : target;

            if (!caster)
                return;
            // If amount avalible cast with basepoints (Crypt Fever for example)
            if (GetAmount())
                caster->CastCustomSpell(target, triggeredSpellId, &m_amount, nullptr, nullptr, true, nullptr, this);
            else
                caster->CastSpell(target, triggeredSpellId, true, nullptr, this);
        }
        else
        {
            ObjectGuid casterGUID = triggeredSpellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, GetEffIndex()) ? GetCasterGUID() : target->GetGUID();
            target->RemoveAura(triggeredSpellId, casterGUID, 0, aurApp->GetRemoveMode());
        }
    }
    else if (mode & AURA_EFFECT_HANDLE_REAPPLY && apply)
    {
        ObjectGuid casterGUID = triggeredSpellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, GetEffIndex()) ? GetCasterGUID() : target->GetGUID();
        // change the stack amount to be equal to stack amount of our aura
        if (Aura* triggeredAura = target->GetAura(triggeredSpellId, casterGUID))
            triggeredAura->ModStackAmount(GetBase()->GetStackAmount() - triggeredAura->GetStackAmount());
    }
}

void AuraEffect::HandleAuraOpenStable(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER || !target->IsInWorld())
        return;

    if (apply)
        target->ToPlayer()->GetSession()->SendStablePet(target->GetGUID());

    // client auto close stable dialog at !apply aura
}

void AuraEffect::HandleAuraModFakeInebriation(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK))
        return;

    Player* target = aurApp->GetTarget()->ToPlayer();
    if (!target)
        return;

    target->ApplyModInt32Value(PLAYER_FAKE_INEBRIATION, GetAmount(), apply);
    target->UpdateInvisibilityDrunkDetect();
}

void AuraEffect::HandleAuraOverrideSpells(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Player* target = aurApp->GetTarget()->ToPlayer();

    if (!target || !target->IsInWorld())
        return;

    uint32 overrideId = uint32(GetMiscValue());

    if (apply)
    {
        target->SetUInt16Value(PLAYER_FIELD_BYTES2, PLAYER_BYTES_2_OVERRIDE_SPELLS_UINT16_OFFSET, overrideId);
        if (OverrideSpellDataEntry const* overrideSpells = sOverrideSpellDataStore.LookupEntry(overrideId))
            for (uint8 i = 0; i < MAX_OVERRIDE_SPELL; ++i)
                if (uint32 spellId = overrideSpells->spellId[i])
                    target->_addSpell(spellId, SPEC_MASK_ALL, true);
    }
    else
    {
        target->SetUInt16Value(PLAYER_FIELD_BYTES2, PLAYER_BYTES_2_OVERRIDE_SPELLS_UINT16_OFFSET, 0);
        if (OverrideSpellDataEntry const* overrideSpells = sOverrideSpellDataStore.LookupEntry(overrideId))
            for (uint8 i = 0; i < MAX_OVERRIDE_SPELL; ++i)
                if (uint32 spellId = overrideSpells->spellId[i])
                    target->removeSpell(spellId, SPEC_MASK_ALL, true);
    }
}

void AuraEffect::HandleAuraSetVehicle(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    Unit* target = aurApp->GetTarget();

    if (target->GetTypeId() != TYPEID_PLAYER || !target->IsInWorld())
        return;

    uint32 vehicleId = GetMiscValue();

    if (apply)
    {
        if (!target->CreateVehicleKit(vehicleId, 0))
            return;
    }
    else if (target->GetVehicleKit())
        target->RemoveVehicleKit();

    WorldPacket data(SMSG_PLAYER_VEHICLE_DATA, target->GetPackGUID().size() + 4);
    data << target->GetPackGUID();
    data << uint32(apply ? vehicleId : 0);
    target->SendMessageToSet(&data, true);

    if (apply)
    {
        data.Initialize(SMSG_ON_CANCEL_EXPECTED_RIDE_VEHICLE_AURA, 0);
        target->ToPlayer()->GetSession()->SendPacket(&data);
    }
}

void AuraEffect::HandlePreventResurrection(AuraApplication const* aurApp, uint8 mode, bool apply) const
{
    if (!(mode & AURA_EFFECT_HANDLE_REAL))
        return;

    if (aurApp->GetTarget()->GetTypeId() != TYPEID_PLAYER)
        return;

    if (apply)
        aurApp->GetTarget()->RemoveByteFlag(PLAYER_FIELD_BYTES, 0, PLAYER_FIELD_BYTE_RELEASE_TIMER);
    else if (!aurApp->GetTarget()->GetMap()->Instanceable())
        aurApp->GetTarget()->SetByteFlag(PLAYER_FIELD_BYTES, 0, PLAYER_FIELD_BYTE_RELEASE_TIMER);
}

void AuraEffect::HandlePeriodicDummyAuraTick(Unit* target, Unit* caster) const
{
    switch (GetSpellInfo()->SpellFamilyName)
    {
        case SPELLFAMILY_DRUID:
            {
                switch (GetSpellInfo()->Id)
                {
                    // Frenzied Regeneration
                    case 22842:
                        {
                            // Converts up to 10 rage per second into health for $d.  Each point of rage is converted into ${$m2/10}.1% of max health.
                            // Should be manauser
                            if (!target->HasActivePowerType(POWER_RAGE))
                                break;
                            uint32 rage = target->GetPower(POWER_RAGE);
                            // Nothing todo
                            if (rage == 0)
                                break;
                            int32 mod = (rage < 100) ? rage : 100;
                            int32 points = target->CalculateSpellDamage(target, GetSpellInfo(), 1);
                            int32 regen = target->GetMaxHealth() * (mod * points / 10) / 1000;
                            target->CastCustomSpell(target, 22845, &regen, 0, 0, true, 0, this);
                            target->SetPower(POWER_RAGE, rage - mod);
                            break;
                        }
                }
                break;
            }
        case SPELLFAMILY_HUNTER:
            {
                // Explosive Shot
                if (GetSpellInfo()->SpellFamilyFlags[1] & 0x80000000)
                {
                    if (caster)
                        caster->CastCustomSpell(53352, SPELLVALUE_BASE_POINT0, m_amount, target, true, nullptr, this);
                    break;
                }
                switch (GetSpellInfo()->Id)
                {
                    // Feeding Frenzy Rank 1
                    case 53511:
                        if (target->GetVictim() && target->GetVictim()->HealthBelowPct(35))
                            target->CastSpell(target, 60096, true, 0, this);
                        return;
                    // Feeding Frenzy Rank 2
                    case 53512:
                        if (target->GetVictim() && target->GetVictim()->HealthBelowPct(35))
                            target->CastSpell(target, 60097, true, 0, this);
                        return;
                    default:
                        break;
                }
                break;
            }
        case SPELLFAMILY_SHAMAN:
            if (GetId() == 52179) // Astral Shift
            {
                // Periodic need for remove visual on stun/fear/silence lost
                if (!(target->GetUnitFlags() & (UNIT_FLAG_STUNNED | UNIT_FLAG_FLEEING | UNIT_FLAG_SILENCED)))
                    target->RemoveAurasDueToSpell(52179);
                break;
            }
            break;
        case SPELLFAMILY_DEATHKNIGHT:
            switch (GetId())
            {
                case 49016: // Hysteria
                    uint32 damage = uint32(target->CountPctFromMaxHealth(1));
                    Unit::DealDamage(target, target, damage, nullptr, NODAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);
                    break;
            }
            // Blood of the North
            // Reaping
            // Death Rune Mastery
            if (GetSpellInfo()->SpellIconID == 3041 || GetSpellInfo()->SpellIconID == 22 || GetSpellInfo()->SpellIconID == 2622)
            {
                if (target->GetTypeId() != TYPEID_PLAYER)
                    return;
                if (!target->ToPlayer()->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
                    return;

                // timer expired - remove death runes
                target->ToPlayer()->RemoveRunesByAuraEffect(this);
            }
            break;
        default:
            break;
    }
}

void AuraEffect::HandlePeriodicTriggerSpellAuraTick(Unit* target, Unit* caster) const
{
    // generic casting code with custom spells and target/caster customs
    uint32 triggerSpellId = GetSpellInfo()->Effects[GetEffIndex()].TriggerSpell;

    SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(triggerSpellId);
    SpellInfo const* auraSpellInfo = GetSpellInfo();
    uint32 auraId = auraSpellInfo->Id;

    // specific code for cases with no trigger spell provided in field
    if (!triggeredSpellInfo)
    {
        switch (auraSpellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_GENERIC:
                {
                    switch (auraId)
                    {
                        // Thaumaturgy Channel
                        case 9712:
                            triggerSpellId = 21029;
                            if (caster)
                                caster->CastSpell(caster, triggerSpellId, true);
                            return;
                        // Brood Affliction: Bronze
                        case 23170:
                            // Only 10% chance of triggering spell
                            if (roll_chance_f(10.f))
                            {
                                triggerSpellId = 23171;
                            }
                            break;
                        // Restoration
                        case 24379:
                        case 23493:
                            {
                                if (caster)
                                {
                                    int32 heal = caster->CountPctFromMaxHealth(10);
                                    HealInfo healInfo(caster, target, heal, auraSpellInfo, auraSpellInfo->GetSchoolMask());
                                    caster->HealBySpell(healInfo);

                                    if (int32 mana = caster->GetMaxPower(POWER_MANA))
                                    {
                                        mana /= 10;
                                        caster->EnergizeBySpell(caster, 23493, mana, POWER_MANA);
                                    }
                                }
                                return;
                            }
                        // Nitrous Boost
                        case 27746:
                            if (caster && target->GetPower(POWER_MANA) >= 10)
                            {
                                target->ModifyPower(POWER_MANA, -10);
                                target->SendEnergizeSpellLog(caster, 27746, 10, POWER_MANA);
                            }
                            else
                                target->RemoveAurasDueToSpell(27746);
                            return;
                        // Frost Blast
                        case 27808:
                            if (caster)
                            {
                                caster->CastCustomSpell(29879, SPELLVALUE_BASE_POINT0, int32(target->CountPctFromMaxHealth(21)), target, true, nullptr, this);
                                if (GetTickNumber() == 1)
                                    caster->CastSpell(target, 27808, true);
                            }
                            return;
                        // Inoculate Nestlewood Owlkin
                        case 29528:
                            if (target->GetTypeId() != TYPEID_UNIT) // prevent error reports in case ignored player target
                                return;
                            break;
                        // Feed Captured Animal
                        case 29917:
                            triggerSpellId = 29916;
                            break;
                        // Extract Gas
                        case 30427:
                            {
                                // move loot to player inventory and despawn target
                                if (caster && caster->GetTypeId() == TYPEID_PLAYER &&
                                        target->GetTypeId() == TYPEID_UNIT &&
                                        target->ToCreature()->GetCreatureTemplate()->type == CREATURE_TYPE_GAS_CLOUD)
                                {
                                    Player* player = caster->ToPlayer();
                                    Creature* creature = target->ToCreature();
                                    // missing lootid has been reported on startup - just return
                                    if (!creature->GetCreatureTemplate()->SkinLootId)
                                        return;

                                    player->AutoStoreLoot(creature->GetCreatureTemplate()->SkinLootId, LootTemplates_Skinning, true);

                                    creature->DespawnOrUnsummon();
                                }
                                return;
                            }
                        // Quake
                        case 30576:
                            triggerSpellId = 30571;
                            break;
                        // Doom
                        /// @todo: effect trigger spell may be independant on spell targets, and executed in spell finish phase
                        // so instakill will be naturally done before trigger spell
                        case 31347:
                            {
                                target->CastSpell(target, 31350, true, nullptr, this);
                                Unit::Kill(target, target);
                                return;
                            }
                        // Tear of Azzinoth Summon Channel - it's not really supposed to do anything, and this only prevents the console spam
                        case 39857:
                            triggerSpellId = 39856;
                            break;
                        // Personalized Weather
                        case 46736:
                            triggerSpellId = 46737;
                            break;
                        // Shield Level 1
                        case 63130:
                        // Shield Level 2
                        case 63131:
                        // Shield Level 3
                        case 63132:
                        // Ball of Flames Visual
                        case 71706:
                            return;
                        // Oculus, Mage-Lord Urom, Time Bomb
                        case 51121:
                        case 59376:
                            {
                                const int32 dmg = target->GetMaxHealth() - target->GetHealth();
                                target->CastCustomSpell(target, 51132, &dmg, 0, 0, true);
                                return;
                            }
                    }
                    break;
                }
            case SPELLFAMILY_SHAMAN:
                {
                    switch (auraId)
                    {
                        // Lightning Shield (The Earthshatterer set trigger after cast Lighting Shield)
                        case 28820:
                            {
                                // Need remove self if Lightning Shield not active
                                if (!target->GetAuraEffect(SPELL_AURA_PROC_TRIGGER_SPELL, SPELLFAMILY_SHAMAN, 0x400, 0, 0))
                                    target->RemoveAurasDueToSpell(28820);
                                return;
                            }
                    }
                    break;
                }
            default:
                break;
        }
    }
    else
    {
        // Spell exist but require custom code
        switch (auraId)
        {
            // Mana Tide
            case 16191:
                target->CastCustomSpell(target, triggerSpellId, &m_amount, nullptr, nullptr, true, nullptr, this);
                return;
            // Poison (Grobbulus)
            case 28158:
            case 54362:
            // Slime Pool (Dreadscale & Acidmaw)
            case 66882:
                target->CastCustomSpell(triggerSpellId, SPELLVALUE_RADIUS_MOD, (int32)((((float)m_tickNumber / 60) * 0.9f + 0.1f) * 10000 * 2 / 3), nullptr, true, nullptr, this);
                return;
            // Eye of Eternity, Malygos, Arcane Overload
            case 56432:
                if (triggerSpellId == 56438)
                {
                    target->CastCustomSpell(triggerSpellId, SPELLVALUE_RADIUS_MOD, (int32)(10000 * (1.0f - 0.02f * (m_tickNumber + 1))), nullptr, true, nullptr, this);
                    return;
                }
                break;
            // Beacon of Light
            case 53563:
                {
                    // area aura owner casts the spell
                    GetBase()->GetUnitOwner()->CastSpell(target, triggeredSpellInfo, true, 0, this, GetBase()->GetUnitOwner()->GetGUID());
                    return;
                }
            // Trial of the Crusader, Jaraxxus, Spinning Pain Spike
            case 66283:
                {
                    const int32 dmg = target->GetMaxHealth() / 2;
                    target->CastCustomSpell(target, 66316, &dmg, nullptr, nullptr, true);
                    return;
                }
            // Violet Hold, Moragg, Ray of Suffering, Ray of Pain
            case 54442:
            case 59524:
            case 54438:
            case 59523:
                {
                    if (caster)
                        if (Unit* victim = caster->GetVictim())
                            if(victim->GetDistance(caster) < 45.0f)
                            {
                                target = victim;
                                break;
                            }
                    return;
                }
            case 24745: // Summon Templar, Trigger
            case 24747: // Summon Templar Fire, Trigger
            case 24757: // Summon Templar Air, Trigger
            case 24759: // Summon Templar Earth, Trigger
            case 24761: // Summon Templar Water, Trigger
            case 24762: // Summon Duke, Trigger
            case 24766: // Summon Duke Fire, Trigger
            case 24769: // Summon Duke Air, Trigger
            case 24771: // Summon Duke Earth, Trigger
            case 24773: // Summon Duke Water, Trigger
            case 24785: // Summon Royal, Trigger
            case 24787: // Summon Royal Fire, Trigger
            case 24791: // Summon Royal Air, Trigger
            case 24792: // Summon Royal Earth, Trigger
            case 24793: // Summon Royal Water, Trigger
                {
                    // All this spells trigger a spell that requires reagents; if the
                    // triggered spell is cast as "triggered", reagents are not consumed
                    if (caster)
                        caster->CastSpell(target, triggerSpellId, false);
                    return;
                }
            // Hunter - Rapid Recuperation
            case 56654:
            case 58882:
                int32 amount = int32(target->GetMaxPower(POWER_MANA) * GetAmount() / 100.0f);
                target->CastCustomSpell(target, triggerSpellId, &amount, nullptr, nullptr, true, nullptr, this);
                return;
        }
    }

    // Reget trigger spell proto
    triggeredSpellInfo = sSpellMgr->GetSpellInfo(triggerSpellId);

    if (triggeredSpellInfo)
    {
        //npcbot: override spellInfo
        triggeredSpellInfo = triggeredSpellInfo->TryGetSpellInfoOverride(caster);
        //end npcbot

        if (Unit* triggerCaster = triggeredSpellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, GetEffIndex()) ? caster : target)
        {
            SpellCastTargets targets;
            targets.SetUnitTarget(target);
            if (triggeredSpellInfo->IsChannelCategorySpell() && m_channelData)
            {
                targets.SetDstChannel(m_channelData->spellDst);
                targets.SetObjectTargetChannel(m_channelData->channelGUID);
            }

            // Xinef: do not skip reagent cost for entry casts
            TriggerCastFlags triggerFlags = TRIGGERED_FULL_MASK;
            if (GetSpellInfo()->Effects[GetEffIndex()].TargetA.GetCheckType() == TARGET_CHECK_ENTRY || GetSpellInfo()->Effects[GetEffIndex()].TargetB.GetCheckType() == TARGET_CHECK_ENTRY)
                triggerFlags = TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_POWER_AND_REAGENT_COST);

            triggerCaster->CastSpell(targets, triggeredSpellInfo, nullptr, triggerFlags, nullptr, this);
            LOG_DEBUG("spells.aura", "AuraEffect::HandlePeriodicTriggerSpellAuraTick: Spell {} Trigger {}", GetId(), triggeredSpellInfo->Id);
        }
    }
}

void AuraEffect::HandlePeriodicTriggerSpellWithValueAuraTick(Unit* target, Unit* caster) const
{
    uint32 triggerSpellId = GetSpellInfo()->Effects[m_effIndex].TriggerSpell;
    if (SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(triggerSpellId))
    {
        //npcbot: override spellInfo
        triggeredSpellInfo = triggeredSpellInfo->TryGetSpellInfoOverride(caster);
        //end npcbot

        if (Unit* triggerCaster = triggeredSpellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, GetEffIndex()) ? caster : target)
        {
            SpellCastTargets targets;
            targets.SetUnitTarget(target);
            if (triggeredSpellInfo->IsChannelCategorySpell() && m_channelData)
            {
                targets.SetDstChannel(m_channelData->spellDst);
                targets.SetObjectTargetChannel(m_channelData->channelGUID);
            }

            CustomSpellValues values;
            values.AddSpellMod(SPELLVALUE_BASE_POINT0, GetAmount());

            triggerCaster->CastSpell(targets, triggeredSpellInfo, &values, TRIGGERED_FULL_MASK, nullptr, this);
            LOG_DEBUG("spells.aura", "AuraEffect::HandlePeriodicTriggerSpellWithValueAuraTick: Spell {} Trigger {}", GetId(), triggeredSpellInfo->Id);
        }
    }
    else
    {
        Creature* c = target->ToCreature();
        if (c && caster)
        {
            sScriptMgr->OnDummyEffect(caster, GetId(), SpellEffIndex(GetEffIndex()), target->ToCreature());
        }

        LOG_DEBUG("spells.aura", "AuraEffect::HandlePeriodicTriggerSpellWithValueAuraTick: Spell {} has non-existent spell {} in EffectTriggered[{}] and is therefor not triggered.", GetId(), triggerSpellId, GetEffIndex());
    }
}

void AuraEffect::HandlePeriodicDamageAurasTick(Unit* target, Unit* caster) const
{
    if (!target->IsAlive())
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED) || target->IsImmunedToDamageOrSchool(GetSpellInfo()) || target->IsTotem())
    {
        SendTickImmune(target, caster);
        return;
    }

    // Consecrate ticks can miss and will not show up in the combat log
    if (caster && GetSpellInfo()->Effects[GetEffIndex()].Effect == SPELL_EFFECT_PERSISTENT_AREA_AURA &&
            caster->SpellHitResult(target, GetSpellInfo(), false) != SPELL_MISS_NONE)
        return;

    // some auras remove at specific health level or more
    if (GetAuraType() == SPELL_AURA_PERIODIC_DAMAGE)
    {
        switch (GetSpellInfo()->Id)
        {
            case 43093:
            case 31956:
            case 38801:  // Grievous Wound
            case 35321:
            case 38363:
            case 39215:  // Gushing Wound
                if (target->IsFullHealth())
                {
                    target->RemoveAurasDueToSpell(GetSpellInfo()->Id);
                    return;
                }
                break;
            case 38772: // Grievous Wound
                {
                    uint32 percent = GetSpellInfo()->Effects[EFFECT_1].CalcValue(caster);
                    if (!target->HealthBelowPct(percent))
                    {
                        target->RemoveAurasDueToSpell(GetSpellInfo()->Id);
                        return;
                    }
                    break;
                }
        }
    }

    CleanDamage cleanDamage = CleanDamage(0, 0, BASE_ATTACK, MELEE_HIT_NORMAL);

    // ignore non positive values (can be result apply spellmods to aura damage
    uint32 damage = std::max(GetAmount(), 0);

    // If the damage is percent-max-health based, calculate damage before the Modify hook
    if (GetAuraType() == SPELL_AURA_PERIODIC_DAMAGE_PERCENT)
    {
        // xinef: ceil obtained value, it may happen that 10 ticks for 10% damage may not kill owner
        damage = uint32(std::ceil(CalculatePct<float, float>(target->GetMaxHealth(), damage)));
    }

    // Script Hook For HandlePeriodicDamageAurasTick -- Allow scripts to change the Damage pre class mitigation calculations
    sScriptMgr->ModifyPeriodicDamageAurasTick(target, caster, damage, GetSpellInfo());

    if (target->GetAI())
    {
        target->GetAI()->OnCalculatePeriodicTickReceived(damage, caster);
    }

    if (GetAuraType() == SPELL_AURA_PERIODIC_DAMAGE)
    {
        //npcbot: Black Arrow damage on targets below 20%
        if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_WARLOCK && (GetSpellInfo()->SpellFamilyFlags[1] & 0x4) &&
            target->HasAuraState(AURA_STATE_HEALTHLESS_20_PERCENT))
        {
            damage *= 5;
        }
        //end npcbot

        // xinef: leave only target depending bonuses, rest is handled in calculate amount
        if (GetBase()->GetType() == DYNOBJ_AURA_TYPE && caster)
            damage = caster->SpellDamageBonusDone(target, GetSpellInfo(), damage, DOT, GetEffIndex(), 0.0f, GetBase()->GetStackAmount());
        damage = target->SpellDamageBonusTaken(caster, GetSpellInfo(), damage, DOT, GetBase()->GetStackAmount());

        // Calculate armor mitigation
        if (Unit::IsDamageReducedByArmor(GetSpellInfo()->GetSchoolMask(), GetSpellInfo(), GetEffIndex()))
        {
            uint32 damageReductedArmor = Unit::CalcArmorReducedDamage(caster, target, damage, GetSpellInfo(), GetCasterLevel());
            cleanDamage.mitigated_damage += damage - damageReductedArmor;
            damage = damageReductedArmor;
        }

        // Curse of Agony damage-per-tick calculation
        if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_WARLOCK && (GetSpellInfo()->SpellFamilyFlags[0] & 0x400) && GetSpellInfo()->SpellIconID == 544)
        {
            uint32 totalTick = GetTotalTicks();
            // 1..4 ticks, 1/2 from normal tick damage
            if (m_tickNumber <= totalTick / 3)
                damage = damage / 2;
            // 9..12 ticks, 3/2 from normal tick damage
            else if (m_tickNumber > totalTick * 2 / 3)
                damage += (damage + 1) / 2;       // +1 prevent 0.5 damage possible lost at 1..4 ticks
            // 5..8 ticks have normal tick damage
        }
    }

    // calculate crit chance
    bool crit = false;
    if ((crit = roll_chance_f(GetCritChance())))
        damage = Unit::SpellCriticalDamageBonus(caster, m_spellInfo, damage, target);

    // Auras reducing damage from AOE spells
    if (GetSpellInfo()->Effects[GetEffIndex()].IsAreaAuraEffect() || GetSpellInfo()->Effects[GetEffIndex()].IsTargetingArea() || GetSpellInfo()->Effects[GetEffIndex()].Effect == SPELL_EFFECT_PERSISTENT_AREA_AURA) // some persistent area auras have targets like A=53 B=28
    {
        damage = target->CalculateAOEDamageReduction(damage, GetSpellInfo()->SchoolMask, caster);
    }

    int32 dmg = damage;
    int32 mitigatedDamage = cleanDamage.mitigated_damage;
    if (CanApplyResilience())
    {
        int32 resilienceReduction = dmg;
        Unit::ApplyResilience(target, nullptr, &resilienceReduction, crit, CR_CRIT_TAKEN_SPELL);

        resilienceReduction = dmg - resilienceReduction;
        dmg -= resilienceReduction;
        mitigatedDamage += resilienceReduction;
    }

    damage = std::max(0, dmg);
    cleanDamage.mitigated_damage = std::max(0, mitigatedDamage);

    DamageInfo dmgInfo(caster, target, damage, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), DOT, cleanDamage.mitigated_damage);
    Unit::CalcAbsorbResist(dmgInfo);

    uint32 absorb = dmgInfo.GetAbsorb();
    uint32 resist = dmgInfo.GetResist();
    damage = dmgInfo.GetDamage();

    LOG_DEBUG("spells.aura.effect", "PeriodicTick: {} attacked {} for {} dmg inflicted by {} abs is {}",
                    GetCasterGUID().ToString(), target->GetGUID().ToString(), damage, GetId(), absorb);
    Unit::DealDamageMods(target, damage, &absorb);

    // Set trigger flag
    uint32 procAttacker = PROC_FLAG_DONE_PERIODIC;
    uint32 procVictim   = PROC_FLAG_TAKEN_PERIODIC;
    uint32 procEx = (crit ? PROC_EX_CRITICAL_HIT : PROC_EX_NORMAL_HIT) | PROC_EX_INTERNAL_DOT;
    if (absorb > 0)
        procEx |= PROC_EX_ABSORB;

    if (damage)
        procVictim |= PROC_FLAG_TAKEN_DAMAGE;

    int32 overkill = damage - target->GetHealth();
    if (overkill < 0)
        overkill = 0;

    SpellPeriodicAuraLogInfo pInfo(this, damage, overkill, absorb, resist, 0.0f, crit);
    target->SendPeriodicAuraLog(&pInfo);

    Unit::DealDamage(caster, target, damage, &cleanDamage, DOT, GetSpellInfo()->GetSchoolMask(), GetSpellInfo(), true);

    Unit::ProcDamageAndSpell(caster, target, caster ? procAttacker : 0, procVictim, procEx, damage, BASE_ATTACK, GetSpellInfo(), nullptr, GetEffIndex(), nullptr, &dmgInfo);
}

void AuraEffect::HandlePeriodicHealthLeechAuraTick(Unit* target, Unit* caster) const
{
    if (!target->IsAlive())
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED) || target->IsImmunedToDamageOrSchool(GetSpellInfo()))
    {
        SendTickImmune(target, caster);
        return;
    }

    if (caster && GetSpellInfo()->Effects[GetEffIndex()].Effect == SPELL_EFFECT_PERSISTENT_AREA_AURA &&
            caster->SpellHitResult(target, GetSpellInfo(), false) != SPELL_MISS_NONE)
        return;

    CleanDamage cleanDamage = CleanDamage(0, 0, BASE_ATTACK, MELEE_HIT_NORMAL);

    uint32 damage = std::max(GetAmount(), 0);

    // Script Hook For HandlePeriodicHealthLeechAurasTick -- Allow scripts to change the Damage pre class mitigation calculations
    sScriptMgr->ModifyPeriodicDamageAurasTick(target, caster, damage, GetSpellInfo());

    if (target->GetAI())
    {
        target->GetAI()->OnCalculatePeriodicTickReceived(damage, caster);
    }

    if (GetBase()->GetType() == DYNOBJ_AURA_TYPE)
        damage = caster->SpellDamageBonusDone(target, GetSpellInfo(), damage, DOT, GetEffIndex(), 0.0f, GetBase()->GetStackAmount());
    damage = target->SpellDamageBonusTaken(caster, GetSpellInfo(), damage, DOT, GetBase()->GetStackAmount());

    bool crit = false;
    if ((crit = roll_chance_f(GetCritChance())))
        damage = Unit::SpellCriticalDamageBonus(caster, m_spellInfo, damage, target);

    // Calculate armor mitigation
    if (Unit::IsDamageReducedByArmor(GetSpellInfo()->GetSchoolMask(), GetSpellInfo(), m_effIndex))
    {
        uint32 damageReductedArmor = Unit::CalcArmorReducedDamage(caster, target, damage, GetSpellInfo(), GetCasterLevel());
        cleanDamage.mitigated_damage += damage - damageReductedArmor;
        damage = damageReductedArmor;
    }

    int32 dmg = damage;
    int32 cleanDamageAmount = cleanDamage.mitigated_damage;
    if (CanApplyResilience())
    {
        int32 resilienceReduction = dmg;
        Unit::ApplyResilience(target, nullptr, &resilienceReduction, crit, CR_CRIT_TAKEN_SPELL);

        resilienceReduction = dmg - resilienceReduction;
        dmg -= resilienceReduction;
        cleanDamageAmount += resilienceReduction;
    }

    damage = std::max(0, dmg);
    cleanDamage.mitigated_damage = std::max(0, cleanDamageAmount);

    DamageInfo dmgInfo(caster, target, damage, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), DOT, cleanDamage.mitigated_damage);
    Unit::CalcAbsorbResist(dmgInfo);

    uint32 absorb = dmgInfo.GetAbsorb();
    uint32 resist = dmgInfo.GetResist();
    damage = dmgInfo.GetDamage();

    // Set trigger flag
    uint32 procAttacker = PROC_FLAG_DONE_PERIODIC;
    uint32 procVictim   = PROC_FLAG_TAKEN_PERIODIC;
    uint32 procEx = (crit ? PROC_EX_CRITICAL_HIT : PROC_EX_NORMAL_HIT) | PROC_EX_INTERNAL_DOT;
    if (absorb > 0)
        procEx |= PROC_EX_ABSORB;

    if (dmgInfo.GetDamage())
        procVictim |= PROC_FLAG_TAKEN_DAMAGE;

    if (target->GetHealth() < dmgInfo.GetDamage())
    {
        dmgInfo.ModifyDamage(dmgInfo.GetDamage() - target->GetHealth());
    }

    damage = dmgInfo.GetDamage();

    LOG_DEBUG("spells.aura.effect", "PeriodicTick: {} health leech of {} for {} dmg inflicted by {} abs is {}",
                    GetCasterGUID().ToString(), target->GetGUID().ToString(), damage, GetId(), absorb);
    if (caster)
        caster->SendSpellNonMeleeDamageLog(target, GetSpellInfo(), damage, GetSpellInfo()->GetSchoolMask(), absorb, resist, false, 0, crit);

    int32 new_damage;

    new_damage = Unit::DealDamage(caster, target, damage, &cleanDamage, DOT, GetSpellInfo()->GetSchoolMask(), GetSpellInfo(), false);

    Unit::ProcDamageAndSpell(caster, target, caster ? procAttacker : 0, procVictim, procEx, damage, BASE_ATTACK, GetSpellInfo(), nullptr, GetEffIndex(), nullptr, &dmgInfo);

    if (!caster || !caster->IsAlive())
        return;

    float gainMultiplier = GetSpellInfo()->Effects[GetEffIndex()].CalcValueMultiplier(caster);

    uint32 heal = uint32(caster->SpellHealingBonusDone(caster, GetSpellInfo(), uint32(new_damage * gainMultiplier), DOT, GetEffIndex(), 0.0f, GetBase()->GetStackAmount()));
    heal = uint32(caster->SpellHealingBonusTaken(caster, GetSpellInfo(), heal, DOT, GetBase()->GetStackAmount()));

    HealInfo healInfo(caster, caster, heal, GetSpellInfo(), GetSpellInfo()->GetSchoolMask());
    int32 gain = caster->HealBySpell(healInfo);
    caster->getHostileRefMgr().threatAssist(caster, gain * 0.5f, GetSpellInfo());
}

void AuraEffect::HandlePeriodicHealthFunnelAuraTick(Unit* target, Unit* caster) const
{
    if (!caster || !caster->IsAlive() || !target->IsAlive())
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED))
    {
        SendTickImmune(target, caster);
        return;
    }

    uint32 damage = std::max(GetAmount(), 0);
    // do not kill health donator
    if (caster->GetHealth() < damage)
        damage = caster->GetHealth() - 1;
    if (!damage)
        return;

    caster->ModifyHealth(-(int32)damage);
    LOG_DEBUG("spells.aura", "PeriodicTick: donator {} target {} damage {}.", caster->GetEntry(), target->GetEntry(), damage);

    float gainMultiplier = GetSpellInfo()->Effects[GetEffIndex()].CalcValueMultiplier(caster);

    damage = int32(damage * gainMultiplier);

    HealInfo healInfo(caster, target, damage, GetSpellInfo(), GetSpellInfo()->GetSchoolMask());
    caster->HealBySpell(healInfo);
}

void AuraEffect::HandlePeriodicHealAurasTick(Unit* target, Unit* caster) const
{
    if (!target->IsAlive())
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED))
    {
        SendTickImmune(target, caster);
        return;
    }

    // heal for caster damage (must be alive)
    if (target != caster && GetSpellInfo()->HasAttribute(SPELL_ATTR2_NO_TARGET_PER_SECOND_COST) && (!caster || !caster->IsAlive()))
        return;

    // don't regen when permanent aura target has full power
    if (GetBase()->IsPermanent() && target->IsFullHealth())
        return;

    // ignore negative values (can be result apply spellmods to aura damage
    int32 damage = std::max(m_amount, 0);

    if (GetAuraType() == SPELL_AURA_OBS_MOD_HEALTH)
    {
        // Taken mods
        float TakenTotalMod = 1.0f;

        // Tenacity increase healing % taken
        if (AuraEffect const* Tenacity = target->GetAuraEffect(58549, 0))
            AddPct(TakenTotalMod, Tenacity->GetAmount());

        // Healing taken percent
        float minval = (float)target->GetMaxNegativeAuraModifier(SPELL_AURA_MOD_HEALING_PCT);
        if (minval)
            AddPct(TakenTotalMod, minval);

        float maxval = (float)target->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HEALING_PCT);
        if (maxval)
            AddPct(TakenTotalMod, maxval);

        // Healing over time taken percent
        float minval_hot = (float)target->GetMaxNegativeAuraModifier(SPELL_AURA_MOD_HOT_PCT);
        if (minval_hot)
            AddPct(TakenTotalMod, minval_hot);

        float maxval_hot = (float)target->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HOT_PCT);
        if (maxval_hot)
            AddPct(TakenTotalMod, maxval_hot);

        // Arena / BG Dampening
        float minval_pct = (float)target->GetMaxNegativeAuraModifier(SPELL_AURA_MOD_HEALING_DONE_PERCENT);
        if (minval_pct)
            AddPct(TakenTotalMod, minval_pct);

        TakenTotalMod = std::max(TakenTotalMod, 0.0f);

        // the most ugly hack i made :P the other option is to change all spellvalues to float...
        // demonic aegis
        if (caster && GetSpellInfo()->SpellFamilyName == SPELLFAMILY_WARLOCK && (GetSpellInfo()->SpellFamilyFlags[1] & 0x20000000))
            if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_AURA_ADD_PCT_MODIFIER, SPELLFAMILY_WARLOCK, 89, 0))
                AddPct(TakenTotalMod, aurEff->GetAmount());

        damage = uint32(target->CountPctFromMaxHealth(damage));
        damage = uint32(damage * TakenTotalMod);
    }
    else
    {
        // Wild Growth = amount + (6 - 2*doneTicks) * ticks* amount / 100
        if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_DRUID && GetSpellInfo()->SpellIconID == 2864)
        {
            uint32 tickNumber = GetTickNumber() - 1;
            int32 tempAmount = m_spellInfo->Effects[m_effIndex].CalcValue(caster, &m_baseAmount, nullptr);

            float drop = 2.0f;

            // Item - Druid T10 Restoration 2P Bonus
            if (caster)
                if (AuraEffect* aurEff = caster->GetAuraEffect(70658, 0))
                    AddPct(drop, -aurEff->GetAmount());

            damage += GetTotalTicks() * tempAmount * (6 - (drop * tickNumber)) * 0.01f;
        }

        if (GetBase()->GetType() == DYNOBJ_AURA_TYPE)
            damage = caster->SpellHealingBonusDone(target, GetSpellInfo(), damage, DOT, GetEffIndex(), 0.0f, GetBase()->GetStackAmount());
        damage = target->SpellHealingBonusTaken(caster, GetSpellInfo(), damage, DOT, GetBase()->GetStackAmount());
    }

    bool crit = false;
    if ((crit = roll_chance_f(GetCritChance())))
        damage = Unit::SpellCriticalHealingBonus(caster, GetSpellInfo(), damage, target);

    LOG_DEBUG("spells.aura.effect", "PeriodicTick: {} heal of {} for {} health inflicted by {}",
                    GetCasterGUID().ToString(), target->GetGUID().ToString(), damage, GetId());

    uint32 heal = uint32(damage);

    // Script Hook For HandlePeriodicDamageAurasTick -- Allow scripts to change the Damage pre class mitigation calculations
    sScriptMgr->ModifyPeriodicDamageAurasTick(target, caster, heal, GetSpellInfo());
    sScriptMgr->ModifyHealReceived(target, caster, heal, GetSpellInfo());

    if (target->GetAI())
    {
        target->GetAI()->OnCalculatePeriodicTickReceived(heal, caster);
    }

    HealInfo healInfo(caster, target, heal, GetSpellInfo(), GetSpellInfo()->GetSchoolMask());
    Unit::CalcHealAbsorb(healInfo);
    int32 gain = Unit::DealHeal(caster, target, healInfo.GetHeal());
    healInfo.SetEffectiveHeal(gain);

    SpellPeriodicAuraLogInfo pInfo(this, healInfo.GetHeal(), healInfo.GetHeal() - healInfo.GetEffectiveHeal(), healInfo.GetAbsorb(), 0, 0.0f, crit);
    target->SendPeriodicAuraLog(&pInfo);

    if (caster)
        target->getHostileRefMgr().threatAssist(caster, float(gain) * 0.5f, GetSpellInfo());

    bool haveCastItem = GetBase()->GetCastItemGUID();

    // Health Funnel
    // damage caster for heal amount
    // xinef: caster is available, checked earlier
    if (target != caster && GetSpellInfo()->HasAttribute(SPELL_ATTR2_NO_TARGET_PER_SECOND_COST))
    {
        uint32 manaPerSecond = GetSpellInfo()->ManaPerSecond;
        if ((int32)manaPerSecond > gain && gain > 0)
        {
            manaPerSecond = gain;
        }

        uint32 absorb2 = 0;
        Unit::DealDamageMods(caster, manaPerSecond, &absorb2);

        CleanDamage cleanDamage = CleanDamage(0, 0, BASE_ATTACK, MELEE_HIT_NORMAL);
        Unit::DealDamage(caster, caster, manaPerSecond, &cleanDamage, SELF_DAMAGE, GetSpellInfo()->GetSchoolMask(), GetSpellInfo(), true);
    }

    uint32 procAttacker = PROC_FLAG_DONE_PERIODIC;
    uint32 procVictim   = PROC_FLAG_TAKEN_PERIODIC;
    uint32 procEx = (crit ? PROC_EX_CRITICAL_HIT : PROC_EX_NORMAL_HIT) | PROC_EX_INTERNAL_HOT;
    if (healInfo.GetAbsorb() > 0)
        procEx |= PROC_EX_ABSORB;

    // ignore item heals
    if (!haveCastItem && GetAuraType() != SPELL_AURA_OBS_MOD_HEALTH) // xinef: dont allow obs_mod_health to proc spells, this is passive regeneration and not hot
        Unit::ProcDamageAndSpell(caster, target, caster ? procAttacker : 0, procVictim, procEx, heal, BASE_ATTACK, GetSpellInfo(), nullptr, GetEffIndex(), nullptr, nullptr, &healInfo);
}

void AuraEffect::HandlePeriodicManaLeechAuraTick(Unit* target, Unit* caster) const
{
    Powers PowerType = Powers(GetMiscValue());

    if (!caster || !caster->IsAlive() || !target->IsAlive() || !target->HasActivePowerType(PowerType))
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED) || target->IsImmunedToDamageOrSchool(GetSpellInfo()))
    {
        SendTickImmune(target, caster);
        return;
    }

    if (GetSpellInfo()->Effects[GetEffIndex()].Effect == SPELL_EFFECT_PERSISTENT_AREA_AURA &&
            caster->SpellHitResult(target, GetSpellInfo(), false) != SPELL_MISS_NONE)
        return;

    // ignore negative values (can be result apply spellmods to aura damage
    int32 drainAmount = std::max(m_amount, 0);

    // Special case: draining x% of mana (up to a maximum of 2*x% of the caster's maximum mana)
    // It's mana percent cost spells, m_amount is percent drain from target
    if (m_spellInfo->ManaCostPercentage)
    {
        // max value
        int32 maxmana = CalculatePct(caster->GetMaxPower(PowerType), drainAmount * 2.0f);
        ApplyPct(drainAmount, target->GetMaxPower(PowerType));
        if (drainAmount > maxmana)
            drainAmount = maxmana;
    }

    LOG_DEBUG("spells.aura.effect", "PeriodicTick: {} power leech of {} for {} dmg inflicted by {}",
                    GetCasterGUID().ToString(), target->GetGUID().ToString(), drainAmount, GetId());
    // resilience reduce mana draining effect at spell crit damage reduction (added in 2.4)
    if (PowerType == POWER_MANA)
        drainAmount -= target->GetSpellCritDamageReduction(drainAmount);

    int32 drainedAmount = -target->ModifyPower(PowerType, -drainAmount);

    float gainMultiplier = GetSpellInfo()->Effects[GetEffIndex()].CalcValueMultiplier(caster);

    SpellPeriodicAuraLogInfo pInfo(this, drainedAmount, 0, 0, 0, gainMultiplier, false);
    target->SendPeriodicAuraLog(&pInfo);

    int32 gainAmount = int32(drainedAmount * gainMultiplier);
    int32 gainedAmount = 0;
    if (gainAmount)
    {
        gainedAmount = caster->ModifyPower(PowerType, gainAmount);
        target->AddThreat(caster, float(gainedAmount) * 0.5f, GetSpellInfo()->GetSchoolMask(), GetSpellInfo());
    }

    target->AddThreat(caster, float(gainedAmount) * 0.5f, GetSpellInfo()->GetSchoolMask(), GetSpellInfo());

    // remove CC auras
    target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TAKE_DAMAGE);

    // Drain Mana
    if (m_spellInfo->SpellFamilyName == SPELLFAMILY_WARLOCK
            && m_spellInfo->SpellFamilyFlags[0] & 0x00000010)
    {
        int32 manaFeedVal = 0;
        if (AuraEffect const* aurEff = GetBase()->GetEffect(1))
            manaFeedVal = aurEff->GetAmount();
        // Mana Feed - Drain Mana
        if (manaFeedVal > 0)
        {
            int32 feedAmount = CalculatePct(gainedAmount, manaFeedVal);
            caster->CastCustomSpell(caster, 32554, &feedAmount, nullptr, nullptr, true, nullptr, this);
        }
    }
}

void AuraEffect::HandleObsModPowerAuraTick(Unit* target, Unit* caster) const
{
    Powers PowerType;
    if (GetMiscValue() == POWER_ALL)
        PowerType = target->getPowerType();
    else
        PowerType = Powers(GetMiscValue());

    if (!target->IsAlive() || !target->GetMaxPower(PowerType))
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED))
    {
        SendTickImmune(target, caster);
        return;
    }

    // don't regen when permanent aura target has full power
    if (GetBase()->IsPermanent() && target->GetPower(PowerType) == target->GetMaxPower(PowerType))
        return;

    // ignore negative values (can be result apply spellmods to aura damage
    uint32 amount = std::max(m_amount, 0) * target->GetMaxPower(PowerType) / 100;
    LOG_DEBUG("spells.aura.effect", "PeriodicTick: {} energize {} for {} dmg inflicted by {}",
                    GetCasterGUID().ToString(), target->GetGUID().ToString(), amount, GetId());
    SpellPeriodicAuraLogInfo pInfo(this, amount, 0, 0, 0, 0.0f, false);
    target->SendPeriodicAuraLog(&pInfo);

    int32 gain = target->ModifyPower(PowerType, amount);

    if (caster)
        target->getHostileRefMgr().threatAssist(caster, float(gain) * 0.5f, GetSpellInfo());
}

void AuraEffect::HandlePeriodicEnergizeAuraTick(Unit* target, Unit* caster) const
{
    Powers PowerType = Powers(GetMiscValue());

    if (target->GetTypeId() == TYPEID_PLAYER && !target->HasActivePowerType(PowerType) && !m_spellInfo->HasAttribute(SPELL_ATTR7_ONLY_IN_SPELLBOOK_UNTIL_LEARNED))
        return;

    if (!target->IsAlive() || !target->GetMaxPower(PowerType))
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED))
    {
        SendTickImmune(target, caster);
        return;
    }

    // don't regen when permanent aura target has full power
    if (GetBase()->IsPermanent() && target->GetPower(PowerType) == target->GetMaxPower(PowerType))
        return;

    // ignore negative values (can be result apply spellmods to aura damage
    int32 amount = std::max(m_amount, 0);

    SpellPeriodicAuraLogInfo pInfo(this, amount, 0, 0, 0, 0.0f, false);
    target->SendPeriodicAuraLog(&pInfo);

    LOG_DEBUG("spells.aura.effect", "PeriodicTick: {} energize {} for {} dmg inflicted by {}",
                    GetCasterGUID().ToString(), target->GetGUID().ToString(), amount, GetId());
    int32 gain = target->ModifyPower(PowerType, amount);

    if (caster)
        target->getHostileRefMgr().threatAssist(caster, float(gain) * 0.5f, GetSpellInfo());
}

void AuraEffect::HandlePeriodicPowerBurnAuraTick(Unit* target, Unit* caster) const
{
    Powers PowerType = Powers(GetMiscValue());

    if (!caster || !target->IsAlive() || !target->HasActivePowerType(PowerType))
        return;

    if (target->HasUnitState(UNIT_STATE_ISOLATED) || target->IsImmunedToDamageOrSchool(GetSpellInfo()))
    {
        SendTickImmune(target, caster);
        return;
    }

    // ignore negative values (can be result apply spellmods to aura damage
    int32 damage = std::max(m_amount, 0);

    // resilience reduce mana draining effect at spell crit damage reduction (added in 2.4)
    if (PowerType == POWER_MANA)
        damage -= target->GetSpellCritDamageReduction(damage);

    uint32 gain = uint32(-target->ModifyPower(PowerType, -damage));

    float dmgMultiplier = GetSpellInfo()->Effects[GetEffIndex()].CalcValueMultiplier(caster);

    SpellInfo const* spellProto = GetSpellInfo();
    // maybe has to be sent different to client, but not by SMSG_PERIODICAURALOG
    SpellNonMeleeDamage damageInfo(caster, target, spellProto, spellProto->SchoolMask);
    // no SpellDamageBonus for burn mana
    caster->CalculateSpellDamageTaken(&damageInfo, int32(gain * dmgMultiplier), spellProto);

    Unit::DealDamageMods(damageInfo.target, damageInfo.damage, &damageInfo.absorb);

    caster->SendSpellNonMeleeDamageLog(&damageInfo);

    // Set trigger flag
    uint32 procAttacker = PROC_FLAG_DONE_PERIODIC;
    uint32 procVictim   = PROC_FLAG_TAKEN_PERIODIC;
    uint32 procEx       = createProcExtendMask(&damageInfo, SPELL_MISS_NONE) | PROC_EX_INTERNAL_DOT;
    if (damageInfo.damage)
        procVictim |= PROC_FLAG_TAKEN_DAMAGE;

    caster->DealSpellDamage(&damageInfo, true);

    DamageInfo dmgInfo(damageInfo, DOT);
    Unit::ProcDamageAndSpell(caster, damageInfo.target, procAttacker, procVictim, procEx, damageInfo.damage, BASE_ATTACK, spellProto, nullptr, GetEffIndex(), nullptr, &dmgInfo);
}

void AuraEffect::HandleProcTriggerSpellAuraProc(AuraApplication* aurApp, ProcEventInfo& eventInfo)
{
    Unit* triggerCaster = aurApp->GetTarget();
    Unit* triggerTarget = eventInfo.GetProcTarget();

    uint32 triggerSpellId = GetSpellInfo()->Effects[GetEffIndex()].TriggerSpell;
    if (SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(triggerSpellId))
    {
        LOG_DEBUG("spells.aura", "AuraEffect::HandleProcTriggerSpellAuraProc: Triggering spell {} from aura {} proc", triggeredSpellInfo->Id, GetId());

        //npcbot: override spellInfo
        triggeredSpellInfo = triggeredSpellInfo->TryGetSpellInfoOverride(aurApp->GetBase()->GetCaster());
        //end npcbot

        //npcbot
        Aura const* triggeredByAura = aurApp->GetBase();
        int32 basepoints0 = 0;
        switch (triggerSpellId)
        {
            // Quest - Self Healing from resurrect (invisible in log)
            case 25155:
            {
                switch (GetId())
                {
                    //Vampiric Aura
                    case 20810:
                    {
                        DamageInfo const* dinfo = eventInfo.GetDamageInfo();
                        uint32 damage = dinfo->GetDamage();
                        if (!damage)
                            return;

                        // 100% / 25%
                        if (triggerTarget->GetGUID() == triggeredByAura->GetCasterGUID())
                            basepoints0 = int32(damage);
                        else
                            basepoints0 = int32(damage / 4);

                        triggerCaster->CastCustomSpell(triggerTarget, triggerSpellId, &basepoints0, nullptr, nullptr, true, nullptr);
                        return;
                    }
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
        //end npcbot

        triggerCaster->CastSpell(triggerTarget, triggeredSpellInfo, true, nullptr, this);
    }
    else
    {
        LOG_DEBUG("spells.aura", "AuraEffect::HandleProcTriggerSpellAuraProc: Could not trigger spell {} from aura {} proc, because the spell does not have an entry in Spell.dbc.", triggerSpellId, GetId());
    }
}

void AuraEffect::HandleProcTriggerSpellWithValueAuraProc(AuraApplication* aurApp, ProcEventInfo& eventInfo)
{
    Unit* triggerCaster = aurApp->GetTarget();
    Unit* triggerTarget = eventInfo.GetProcTarget();

    uint32 triggerSpellId = GetSpellInfo()->Effects[m_effIndex].TriggerSpell;
    if (SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(triggerSpellId))
    {
        // used only with EXTRA_LOGS
        (void)triggeredSpellInfo;

        //npcbot: override spellInfo
        triggeredSpellInfo = triggeredSpellInfo->TryGetSpellInfoOverride(aurApp->GetBase()->GetCaster());
        //end npcbot

        int32 basepoints0 = GetAmount();
        LOG_DEBUG("spells.aura", "AuraEffect::HandleProcTriggerSpellWithValueAuraProc: Triggering spell {} with value {} from aura {} proc", triggeredSpellInfo->Id, basepoints0, GetId());
        triggerCaster->CastCustomSpell(triggerTarget, triggerSpellId, &basepoints0, nullptr, nullptr, true, nullptr, this);
    }
    else
    {
        LOG_DEBUG("spells.aura", "AuraEffect::HandleProcTriggerSpellWithValueAuraProc: Could not trigger spell {} from aura {} proc, because the spell does not have an entry in Spell.dbc.", triggerSpellId, GetId());
    }
}

void AuraEffect::HandleProcTriggerDamageAuraProc(AuraApplication* aurApp, ProcEventInfo& eventInfo)
{
    Unit* target = aurApp->GetTarget();
    Unit* triggerTarget = eventInfo.GetProcTarget();
    if (triggerTarget->HasUnitState(UNIT_STATE_ISOLATED) || triggerTarget->IsImmunedToDamageOrSchool(GetSpellInfo()))
    {
        SendTickImmune(triggerTarget, target);
        return;
    }

    SpellNonMeleeDamage damageInfo(target, triggerTarget, GetSpellInfo(), GetSpellInfo()->SchoolMask);
    uint32 damage = target->SpellDamageBonusDone(triggerTarget, GetSpellInfo(), GetAmount(), SPELL_DIRECT_DAMAGE, GetEffIndex());
    damage = triggerTarget->SpellDamageBonusTaken(target, GetSpellInfo(), damage, SPELL_DIRECT_DAMAGE);
    target->CalculateSpellDamageTaken(&damageInfo, damage, GetSpellInfo());
    Unit::DealDamageMods(damageInfo.target, damageInfo.damage, &damageInfo.absorb);
    target->SendSpellNonMeleeDamageLog(&damageInfo);
    LOG_DEBUG("spells.aura", "AuraEffect::HandleProcTriggerDamageAuraProc: Triggering {} spell damage from aura {} proc", damage, GetId());
    target->DealSpellDamage(&damageInfo, true);
}

void AuraEffect::HandleRaidProcFromChargeAuraProc(AuraApplication* aurApp, ProcEventInfo& /*eventInfo*/)
{
    Unit* target = aurApp->GetTarget();

    uint32 triggerSpellId;
    switch (GetId())
    {
        case 57949:            // Shiver
            triggerSpellId = 57952;
            //animationSpellId = 57951; dummy effects for jump spell have unknown use (see also 41637)
            break;
        case 59978:            // Shiver
            triggerSpellId = 59979;
            break;
        case 43593:            // Cold Stare
            triggerSpellId = 43594;
            break;
        default:
            LOG_DEBUG("spells.aura", "AuraEffect::HandleRaidProcFromChargeAuraProc: received not handled spell: {}", GetId());
            return;
    }

    int32 jumps = GetBase()->GetCharges();

    // current aura expire on proc finish
    GetBase()->SetCharges(0);
    GetBase()->SetUsingCharges(true);

    // next target selection
    if (jumps > 0)
    {
        if (Unit* caster = GetCaster())
        {
            float radius = GetSpellInfo()->Effects[GetEffIndex()].CalcRadius(caster);

            if (Unit* triggerTarget = target->GetNextRandomRaidMemberOrPet(radius))
            {
                target->CastSpell(triggerTarget, GetSpellInfo(), true, nullptr, this, GetCasterGUID());
                if (Aura* aura = triggerTarget->GetAura(GetId(), GetCasterGUID()))
                    aura->SetCharges(jumps);
            }
        }
    }

    LOG_DEBUG("spells.aura", "AuraEffect::HandleRaidProcFromChargeAuraProc: Triggering spell {} from aura {} proc", triggerSpellId, GetId());
    target->CastSpell(target, triggerSpellId, true, nullptr, this, GetCasterGUID());
}

void AuraEffect::HandleRaidProcFromChargeWithValueAuraProc(AuraApplication* aurApp, ProcEventInfo& /*eventInfo*/)
{
    Unit* target = aurApp->GetTarget();

    // Currently only Prayer of Mending
    if (!(GetSpellInfo()->SpellFamilyName == SPELLFAMILY_PRIEST && GetSpellInfo()->SpellFamilyFlags[1] & 0x20))
    {
        LOG_DEBUG("spells.aura", "AuraEffect::HandleRaidProcFromChargeWithValueAuraProc: received not handled spell: {}", GetId());
        return;
    }
    uint32 triggerSpellId = 33110;

    int32 value = GetAmount();

    int32 jumps = GetBase()->GetCharges();

    // current aura expire on proc finish
    GetBase()->SetCharges(0);
    GetBase()->SetUsingCharges(true);

    // next target selection
    if (jumps > 0)
    {
        if (Unit* caster = GetCaster())
        {
            float radius = GetSpellInfo()->Effects[GetEffIndex()].CalcRadius(caster);

            Unit*                                                         triggerTarget = nullptr;
            Acore::MostHPMissingGroupInRange                              u_check(target, radius, 0);
            Acore::UnitLastSearcher<Acore::MostHPMissingGroupInRange>     searcher(target, triggerTarget, u_check);
            Cell::VisitAllObjects(target, searcher, radius);

            if (triggerTarget)
            {
                target->CastCustomSpell(triggerTarget, GetId(), &value, nullptr, nullptr, true, nullptr, this, GetCasterGUID());
                if (Aura* aura = triggerTarget->GetAura(GetId(), GetCasterGUID()))
                    aura->SetCharges(jumps);
            }
        }
    }

    LOG_DEBUG("spells.aura", "AuraEffect::HandleRaidProcFromChargeWithValueAuraProc: Triggering spell {} from aura {} proc", triggerSpellId, GetId());
    target->CastCustomSpell(target, triggerSpellId, &value, nullptr, nullptr, true, nullptr, this, GetCasterGUID());
}

int32 AuraEffect::GetTotalTicks() const
{
    uint32 totalTicks = 1;
    if (m_amplitude)
    {
        totalTicks = GetBase()->GetMaxDuration() / m_amplitude;

        if (m_spellInfo->HasAttribute(SPELL_ATTR5_EXTRA_INITIAL_PERIOD))
        {
            ++totalTicks;
        }
    }

    return totalTicks;
}
