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

#include "Battleground.h"
#include "BattlegroundEY.h"
#include "BattlegroundIC.h"
#include "BattlegroundMgr.h"
#include "BattlegroundSA.h"
#include "BattlegroundWS.h"
#include "CellImpl.h"
#include "Common.h"
#include "Creature.h"
#include "DynamicObject.h"
#include "Formulas.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GossipDef.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Language.h"
#include "Log.h"
#include "MapMgr.h"
#include "MiscPackets.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvPMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "SkillExtraItems.h"
#include "SocialMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "Totem.h"
#include "Transport.h"
#include "Unit.h"
#include "UpdateData.h"
#include "UpdateMask.h"
#include "Util.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldPacket.h"

 /// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

pEffect SpellEffects[TOTAL_SPELL_EFFECTS] =
{
    &Spell::EffectNULL,                                     //  0
    &Spell::EffectInstaKill,                                //  1 SPELL_EFFECT_INSTAKILL
    &Spell::EffectSchoolDMG,                                //  2 SPELL_EFFECT_SCHOOL_DAMAGE
    &Spell::EffectDummy,                                    //  3 SPELL_EFFECT_DUMMY
    &Spell::EffectUnused,                                   //  4 SPELL_EFFECT_PORTAL_TELEPORT          unused
    &Spell::EffectTeleportUnits,                            //  5 SPELL_EFFECT_TELEPORT_UNITS
    &Spell::EffectApplyAura,                                //  6 SPELL_EFFECT_APPLY_AURA
    &Spell::EffectEnvironmentalDMG,                         //  7 SPELL_EFFECT_ENVIRONMENTAL_DAMAGE
    &Spell::EffectPowerDrain,                               //  8 SPELL_EFFECT_POWER_DRAIN
    &Spell::EffectHealthLeech,                              //  9 SPELL_EFFECT_HEALTH_LEECH
    &Spell::EffectHeal,                                     // 10 SPELL_EFFECT_HEAL
    &Spell::EffectBind,                                     // 11 SPELL_EFFECT_BIND
    &Spell::EffectNULL,                                     // 12 SPELL_EFFECT_PORTAL
    &Spell::EffectUnused,                                   // 13 SPELL_EFFECT_RITUAL_BASE              unused
    &Spell::EffectUnused,                                   // 14 SPELL_EFFECT_RITUAL_SPECIALIZE        unused
    &Spell::EffectUnused,                                   // 15 SPELL_EFFECT_RITUAL_ACTIVATE_PORTAL   unused
    &Spell::EffectQuestComplete,                            // 16 SPELL_EFFECT_QUEST_COMPLETE
    &Spell::EffectWeaponDmg,                                // 17 SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL
    &Spell::EffectResurrect,                                // 18 SPELL_EFFECT_RESURRECT
    &Spell::EffectAddExtraAttacks,                          // 19 SPELL_EFFECT_ADD_EXTRA_ATTACKS
    &Spell::EffectUnused,                                   // 20 SPELL_EFFECT_DODGE                    one spell: Dodge
    &Spell::EffectUnused,                                   // 21 SPELL_EFFECT_EVADE                    one spell: Evade (DND)
    &Spell::EffectParry,                                    // 22 SPELL_EFFECT_PARRY
    &Spell::EffectBlock,                                    // 23 SPELL_EFFECT_BLOCK                    one spell: Block
    &Spell::EffectCreateItem,                               // 24 SPELL_EFFECT_CREATE_ITEM
    &Spell::EffectUnused,                                   // 25 SPELL_EFFECT_WEAPON
    &Spell::EffectUnused,                                   // 26 SPELL_EFFECT_DEFENSE                  one spell: Defense
    &Spell::EffectPersistentAA,                             // 27 SPELL_EFFECT_PERSISTENT_AREA_AURA
    &Spell::EffectSummonType,                               // 28 SPELL_EFFECT_SUMMON
    &Spell::EffectLeap,                                     // 29 SPELL_EFFECT_LEAP
    &Spell::EffectEnergize,                                 // 30 SPELL_EFFECT_ENERGIZE
    &Spell::EffectWeaponDmg,                                // 31 SPELL_EFFECT_WEAPON_PERCENT_DAMAGE
    &Spell::EffectTriggerMissileSpell,                      // 32 SPELL_EFFECT_TRIGGER_MISSILE
    &Spell::EffectOpenLock,                                 // 33 SPELL_EFFECT_OPEN_LOCK
    &Spell::EffectSummonChangeItem,                         // 34 SPELL_EFFECT_SUMMON_CHANGE_ITEM
    &Spell::EffectApplyAreaAura,                            // 35 SPELL_EFFECT_APPLY_AREA_AURA_PARTY
    &Spell::EffectLearnSpell,                               // 36 SPELL_EFFECT_LEARN_SPELL
    &Spell::EffectUnused,                                   // 37 SPELL_EFFECT_SPELL_DEFENSE            one spell: SPELLDEFENSE (DND)
    &Spell::EffectDispel,                                   // 38 SPELL_EFFECT_DISPEL
    &Spell::EffectUnused,                                   // 39 SPELL_EFFECT_LANGUAGE
    &Spell::EffectDualWield,                                // 40 SPELL_EFFECT_DUAL_WIELD
    &Spell::EffectJump,                                     // 41 SPELL_EFFECT_JUMP
    &Spell::EffectJumpDest,                                 // 42 SPELL_EFFECT_JUMP_DEST
    &Spell::EffectTeleUnitsFaceCaster,                      // 43 SPELL_EFFECT_TELEPORT_UNITS_FACE_CASTER
    &Spell::EffectLearnSkill,                               // 44 SPELL_EFFECT_SKILL_STEP
    &Spell::EffectAddHonor,                                 // 45 SPELL_EFFECT_ADD_HONOR                honor/pvp related
    &Spell::EffectUnused,                                   // 46 SPELL_EFFECT_SPAWN client-side, unit appears as if it was just spawned
    &Spell::EffectTradeSkill,                               // 47 SPELL_EFFECT_TRADE_SKILL
    &Spell::EffectUnused,                                   // 48 SPELL_EFFECT_STEALTH                  one spell: Base Stealth
    &Spell::EffectUnused,                                   // 49 SPELL_EFFECT_DETECT                   one spell: Detect
    &Spell::EffectTransmitted,                              // 50 SPELL_EFFECT_TRANS_DOOR
    &Spell::EffectUnused,                                   // 51 SPELL_EFFECT_FORCE_CRITICAL_HIT       unused
    &Spell::EffectUnused,                                   // 52 SPELL_EFFECT_GUARANTEE_HIT            one spell: zzOLDCritical Shot
    &Spell::EffectEnchantItemPerm,                          // 53 SPELL_EFFECT_ENCHANT_ITEM
    &Spell::EffectEnchantItemTmp,                           // 54 SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY
    &Spell::EffectTameCreature,                             // 55 SPELL_EFFECT_TAMECREATURE
    &Spell::EffectSummonPet,                                // 56 SPELL_EFFECT_SUMMON_PET
    &Spell::EffectLearnPetSpell,                            // 57 SPELL_EFFECT_LEARN_PET_SPELL
    &Spell::EffectWeaponDmg,                                // 58 SPELL_EFFECT_WEAPON_DAMAGE
    &Spell::EffectCreateRandomItem,                         // 59 SPELL_EFFECT_CREATE_RANDOM_ITEM       create item base at spell specific loot
    &Spell::EffectProficiency,                              // 60 SPELL_EFFECT_PROFICIENCY
    &Spell::EffectSendEvent,                                // 61 SPELL_EFFECT_SEND_EVENT
    &Spell::EffectPowerBurn,                                // 62 SPELL_EFFECT_POWER_BURN
    &Spell::EffectThreat,                                   // 63 SPELL_EFFECT_THREAT
    &Spell::EffectTriggerSpell,                             // 64 SPELL_EFFECT_TRIGGER_SPELL
    &Spell::EffectApplyAreaAura,                            // 65 SPELL_EFFECT_APPLY_AREA_AURA_RAID
    &Spell::EffectRechargeManaGem,                          // 66 SPELL_EFFECT_CREATE_MANA_GEM          (possibly recharge it, misc - is item ID)
    &Spell::EffectHealMaxHealth,                            // 67 SPELL_EFFECT_HEAL_MAX_HEALTH
    &Spell::EffectInterruptCast,                            // 68 SPELL_EFFECT_INTERRUPT_CAST
    &Spell::EffectDistract,                                 // 69 SPELL_EFFECT_DISTRACT
    &Spell::EffectPull,                                     // 70 SPELL_EFFECT_PULL                     one spell: Distract Move
    &Spell::EffectPickPocket,                               // 71 SPELL_EFFECT_PICKPOCKET
    &Spell::EffectAddFarsight,                              // 72 SPELL_EFFECT_ADD_FARSIGHT
    &Spell::EffectUntrainTalents,                           // 73 SPELL_EFFECT_UNTRAIN_TALENTS
    &Spell::EffectApplyGlyph,                               // 74 SPELL_EFFECT_APPLY_GLYPH
    &Spell::EffectHealMechanical,                           // 75 SPELL_EFFECT_HEAL_MECHANICAL          one spell: Mechanical Patch Kit
    &Spell::EffectSummonObjectWild,                         // 76 SPELL_EFFECT_SUMMON_OBJECT_WILD
    &Spell::EffectScriptEffect,                             // 77 SPELL_EFFECT_SCRIPT_EFFECT
    &Spell::EffectUnused,                                   // 78 SPELL_EFFECT_ATTACK
    &Spell::EffectSanctuary,                                // 79 SPELL_EFFECT_SANCTUARY
    &Spell::EffectAddComboPoints,                           // 80 SPELL_EFFECT_ADD_COMBO_POINTS
    &Spell::EffectUnused,                                   // 81 SPELL_EFFECT_CREATE_HOUSE             one spell: Create House (TEST)
    &Spell::EffectNULL,                                     // 82 SPELL_EFFECT_BIND_SIGHT
    &Spell::EffectDuel,                                     // 83 SPELL_EFFECT_DUEL
    &Spell::EffectStuck,                                    // 84 SPELL_EFFECT_STUCK
    &Spell::EffectSummonPlayer,                             // 85 SPELL_EFFECT_SUMMON_PLAYER
    &Spell::EffectActivateObject,                           // 86 SPELL_EFFECT_ACTIVATE_OBJECT
    &Spell::EffectGameObjectDamage,                         // 87 SPELL_EFFECT_GAMEOBJECT_DAMAGE
    &Spell::EffectGameObjectRepair,                         // 88 SPELL_EFFECT_GAMEOBJECT_REPAIR
    &Spell::EffectGameObjectSetDestructionState,            // 89 SPELL_EFFECT_GAMEOBJECT_SET_DESTRUCTION_STATE
    &Spell::EffectKillCreditPersonal,                       // 90 SPELL_EFFECT_KILL_CREDIT              Kill credit but only for single person
    &Spell::EffectUnused,                                   // 91 SPELL_EFFECT_THREAT_ALL               one spell: zzOLDBrainwash
    &Spell::EffectEnchantHeldItem,                          // 92 SPELL_EFFECT_ENCHANT_HELD_ITEM
    &Spell::EffectForceDeselect,                            // 93 SPELL_EFFECT_FORCE_DESELECT
    &Spell::EffectSelfResurrect,                            // 94 SPELL_EFFECT_SELF_RESURRECT
    &Spell::EffectSkinning,                                 // 95 SPELL_EFFECT_SKINNING
    &Spell::EffectCharge,                                   // 96 SPELL_EFFECT_CHARGE
    &Spell::EffectCastButtons,                              // 97 SPELL_EFFECT_CAST_BUTTON (totem bar since 3.2.2a)
    &Spell::EffectKnockBack,                                // 98 SPELL_EFFECT_KNOCK_BACK
    &Spell::EffectDisEnchant,                               // 99 SPELL_EFFECT_DISENCHANT
    &Spell::EffectInebriate,                                //100 SPELL_EFFECT_INEBRIATE
    &Spell::EffectFeedPet,                                  //101 SPELL_EFFECT_FEED_PET
    &Spell::EffectDismissPet,                               //102 SPELL_EFFECT_DISMISS_PET
    &Spell::EffectReputation,                               //103 SPELL_EFFECT_REPUTATION
    &Spell::EffectSummonObject,                             //104 SPELL_EFFECT_SUMMON_OBJECT_SLOT1
    &Spell::EffectSummonObject,                             //105 SPELL_EFFECT_SUMMON_OBJECT_SLOT2
    &Spell::EffectSummonObject,                             //106 SPELL_EFFECT_SUMMON_OBJECT_SLOT3
    &Spell::EffectSummonObject,                             //107 SPELL_EFFECT_SUMMON_OBJECT_SLOT4
    &Spell::EffectDispelMechanic,                           //108 SPELL_EFFECT_DISPEL_MECHANIC
    &Spell::EffectResurrectPet,                             //109 SPELL_EFFECT_RESURRECT_PET
    &Spell::EffectDestroyAllTotems,                         //110 SPELL_EFFECT_DESTROY_ALL_TOTEMS
    &Spell::EffectDurabilityDamage,                         //111 SPELL_EFFECT_DURABILITY_DAMAGE
    &Spell::EffectUnused,                                   //112 SPELL_EFFECT_112
    &Spell::EffectResurrectNew,                             //113 SPELL_EFFECT_RESURRECT_NEW
    &Spell::EffectTaunt,                                    //114 SPELL_EFFECT_ATTACK_ME
    &Spell::EffectDurabilityDamagePCT,                      //115 SPELL_EFFECT_DURABILITY_DAMAGE_PCT
    &Spell::EffectSkinPlayerCorpse,                         //116 SPELL_EFFECT_SKIN_PLAYER_CORPSE       one spell: Remove Insignia, bg usage, required special corpse flags...
    &Spell::EffectSpiritHeal,                               //117 SPELL_EFFECT_SPIRIT_HEAL              one spell: Spirit Heal
    &Spell::EffectSkill,                                    //118 SPELL_EFFECT_SKILL                    professions and more
    &Spell::EffectApplyAreaAura,                            //119 SPELL_EFFECT_APPLY_AREA_AURA_PET
    &Spell::EffectUnused,                                   //120 SPELL_EFFECT_TELEPORT_GRAVEYARD       one spell: Graveyard Teleport Test
    &Spell::EffectWeaponDmg,                                //121 SPELL_EFFECT_NORMALIZED_WEAPON_DMG
    &Spell::EffectUnused,                                   //122 SPELL_EFFECT_122                      unused
    &Spell::EffectSendTaxi,                                 //123 SPELL_EFFECT_SEND_TAXI                taxi/flight related (misc value is taxi path id)
    &Spell::EffectPullTowards,                              //124 SPELL_EFFECT_PULL_TOWARDS
    &Spell::EffectModifyThreatPercent,                      //125 SPELL_EFFECT_MODIFY_THREAT_PERCENT
    &Spell::EffectStealBeneficialBuff,                      //126 SPELL_EFFECT_STEAL_BENEFICIAL_BUFF    spell steal effect?
    &Spell::EffectProspecting,                              //127 SPELL_EFFECT_PROSPECTING              Prospecting spell
    &Spell::EffectApplyAreaAura,                            //128 SPELL_EFFECT_APPLY_AREA_AURA_FRIEND
    &Spell::EffectApplyAreaAura,                            //129 SPELL_EFFECT_APPLY_AREA_AURA_ENEMY
    &Spell::EffectRedirectThreat,                           //130 SPELL_EFFECT_REDIRECT_THREAT
    &Spell::EffectPlaySound,                                //131 SPELL_EFFECT_PLAYER_NOTIFICATION      sound id in misc value (SoundEntries.dbc)
    &Spell::EffectPlayMusic,                                //132 SPELL_EFFECT_PLAY_MUSIC               sound id in misc value (SoundEntries.dbc)
    &Spell::EffectUnlearnSpecialization,                    //133 SPELL_EFFECT_UNLEARN_SPECIALIZATION   unlearn profession specialization
    &Spell::EffectKillCredit,                               //134 SPELL_EFFECT_KILL_CREDIT              misc value is creature entry
    &Spell::EffectNULL,                                     //135 SPELL_EFFECT_CALL_PET
    &Spell::EffectHealPct,                                  //136 SPELL_EFFECT_HEAL_PCT
    &Spell::EffectEnergizePct,                              //137 SPELL_EFFECT_ENERGIZE_PCT
    &Spell::EffectLeapBack,                                 //138 SPELL_EFFECT_LEAP_BACK                Leap back
    &Spell::EffectQuestClear,                               //139 SPELL_EFFECT_CLEAR_QUEST              Reset quest status (miscValue - quest ID)
    &Spell::EffectForceCast,                                //140 SPELL_EFFECT_FORCE_CAST
    &Spell::EffectForceCast,                                //141 SPELL_EFFECT_FORCE_CAST_WITH_VALUE
    &Spell::EffectTriggerSpell,                             //142 SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE
    &Spell::EffectApplyAreaAura,                            //143 SPELL_EFFECT_APPLY_AREA_AURA_OWNER
    &Spell::EffectKnockBack,                                //144 SPELL_EFFECT_KNOCK_BACK_DEST
    &Spell::EffectPullTowards,                              //145 SPELL_EFFECT_PULL_TOWARDS_DEST                      Black Hole Effect
    &Spell::EffectActivateRune,                             //146 SPELL_EFFECT_ACTIVATE_RUNE
    &Spell::EffectQuestFail,                                //147 SPELL_EFFECT_QUEST_FAIL               quest fail
    &Spell::EffectTriggerMissileSpell,                      //148 SPELL_EFFECT_TRIGGER_MISSILE_SPELL_WITH_VALUE
    &Spell::EffectChargeDest,                               //149 SPELL_EFFECT_CHARGE_DEST
    &Spell::EffectQuestStart,                               //150 SPELL_EFFECT_QUEST_START
    &Spell::EffectTriggerRitualOfSummoning,                 //151 SPELL_EFFECT_TRIGGER_SPELL_2
    &Spell::EffectSummonRaFFriend,                          //152 SPELL_EFFECT_SUMMON_RAF_FRIEND        summon Refer-a-Friend
    &Spell::EffectCreateTamedPet,                           //153 SPELL_EFFECT_CREATE_TAMED_PET         misc value is creature entry
    &Spell::EffectDiscoverTaxi,                             //154 SPELL_EFFECT_DISCOVER_TAXI
    &Spell::EffectTitanGrip,                                //155 SPELL_EFFECT_TITAN_GRIP Allows you to equip two-handed axes, maces and swords in one hand, but you attack $49152s1% slower than normal.
    &Spell::EffectEnchantItemPrismatic,                     //156 SPELL_EFFECT_ENCHANT_ITEM_PRISMATIC
    &Spell::EffectCreateItem2,                              //157 SPELL_EFFECT_CREATE_ITEM_2            create item or create item template and replace by some randon spell loot item
    &Spell::EffectMilling,                                  //158 SPELL_EFFECT_MILLING                  milling
    &Spell::EffectRenamePet,                                //159 SPELL_EFFECT_ALLOW_RENAME_PET         allow rename pet once again
    &Spell::EffectForceCast,                                //160 SPELL_EFFECT_FORCE_CAST_2
    &Spell::EffectSpecCount,                                //161 SPELL_EFFECT_TALENT_SPEC_COUNT        second talent spec (learn/revert)
    &Spell::EffectActivateSpec,                             //162 SPELL_EFFECT_TALENT_SPEC_SELECT       activate primary/secondary spec
    &Spell::EffectNULL,                                     //163 unused
    &Spell::EffectRemoveAura,                               //164 SPELL_EFFECT_REMOVE_AURA
};

void Spell::EffectNULL(SpellEffIndex /*effIndex*/)
{
    LOG_DEBUG("spells.aura", "WORLD: Spell Effect DUMMY");
}

void Spell::EffectUnused(SpellEffIndex /*effIndex*/)
{
    // NOT USED BY ANY SPELL OR USELESS OR IMPLEMENTED IN DIFFERENT WAY IN TRINITY
}

void Spell::EffectResurrectNew(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || unitTarget->IsAlive())
        return;

    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    if (!unitTarget->IsInWorld())
        return;

    Player* target = unitTarget->ToPlayer();

    if (target->isResurrectRequested())       // already have one active request
        return;

    uint32 health = damage;
    uint32 mana = m_spellInfo->Effects[effIndex].MiscValue;
    ExecuteLogEffectResurrect(effIndex, target);
    target->setResurrectRequestData(m_caster->GetGUID(), m_caster->GetMapId(), m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), health, mana);
    SendResurrectRequest(target);
}

void Spell::EffectInstaKill(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive() || unitTarget->HasAura(27827)) // Spirit of redemption doesn't make you death, but can cause infinite loops
        return;

    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
        if (unitTarget->ToPlayer()->GetCommandStatus(CHEAT_GOD))
            return;

    if (m_caster == unitTarget)                              // prevent interrupt message
        finish();

    WorldPacket data(SMSG_SPELLINSTAKILLLOG, 8 + 8 + 4);
    data << m_caster->GetGUID();
    data << unitTarget->GetGUID();
    data << uint32(m_spellInfo->Id);
    m_caster->SendMessageToSet(&data, true);

    Unit::DealDamage(m_caster, unitTarget, unitTarget->GetHealth(), nullptr, NODAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);
}

void Spell::EffectEnvironmentalDMG(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive())
        return;

    if (unitTarget->IsPlayer())
        unitTarget->ToPlayer()->EnvironmentalDamage(DAMAGE_FIRE, damage);
    else
    {
        DamageInfo dmgInfo(m_caster, unitTarget, damage, m_spellInfo, m_spellInfo->GetSchoolMask(), SPELL_DIRECT_DAMAGE);

        uint32 absorb = dmgInfo.GetAbsorb();
        uint32 resist = dmgInfo.GetResist();
        uint32 envDamage = dmgInfo.GetDamage();

        Unit::DealDamageMods(unitTarget, envDamage, &absorb);
        damage = envDamage;

        m_caster->SendSpellNonMeleeDamageLog(unitTarget, m_spellInfo, damage, m_spellInfo->GetSchoolMask(), absorb, resist, false, 0);
    }
}

void Spell::EffectSchoolDMG(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (unitTarget && unitTarget->IsAlive())
    {
        bool apply_direct_bonus = true;
        switch (m_spellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_GENERIC:
                {
                    // Meteor like spells (divided damage to targets)
                    if (m_spellInfo->HasAttribute(SPELL_ATTR0_CU_SHARE_DAMAGE))
                    {
                        uint32 count = 0;
                        for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
                            if (ihit->effectMask & (1 << effIndex))
                                ++count;

                        damage /= count;                    // divide to all targets
                    }
                    break;
                }
            case SPELLFAMILY_WARRIOR:
                {
                    // Shield Slam
                    if (m_spellInfo->SpellFamilyFlags[1] & 0x200 && m_spellInfo->GetCategory() == 1209)
                    {
                        uint8 level = m_caster->GetLevel();
                        // xinef: shield block should increase the limit
                        float limit = m_caster->HasAura(2565) ? 2.0f : 1.0f;
                        uint32 block_value = m_caster->GetShieldBlockValue(uint32(float(level) * 24.5f * limit), uint32(float(level) * 34.5f * limit));

                        damage += int32(m_caster->ApplyEffectModifiers(m_spellInfo, effIndex, float(block_value)));
                    }
                    // Victory Rush
                    else if (m_spellInfo->SpellFamilyFlags[1] & 0x100)
                        ApplyPct(damage, m_caster->GetTotalAttackPowerValue(BASE_ATTACK));
                    // Shockwave
                    else if (m_spellInfo->Id == 46968)
                    {
                        int32 pct = m_caster->CalculateSpellDamage(unitTarget, m_spellInfo, 2);
                        if (pct > 0)
                            damage += int32(CalculatePct(m_caster->GetTotalAttackPowerValue(BASE_ATTACK), pct));
                        break;
                    }
                    break;
                }
            case SPELLFAMILY_WARLOCK:
                {
                    // Incinerate Rank 1 & 2
                    if ((m_spellInfo->SpellFamilyFlags[1] & 0x000040) && m_spellInfo->SpellIconID == 2128)
                    {
                        // Incinerate does more dmg (dmg*0.25) if the target have Immolate debuff.
                        // Check aura state for speed but aura state set not only for Immolate spell
                        if (unitTarget->HasAuraState(AURA_STATE_CONFLAGRATE))
                        {
                            if (unitTarget->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_WARLOCK, 0x4, 0, 0))
                                damage += damage / 4;
                        }
                    }
                    // Conflagrate - consumes Immolate or Shadowflame
                    else if (m_spellInfo->TargetAuraState == AURA_STATE_CONFLAGRATE)
                    {
                        AuraEffect const* aura = nullptr;                // found req. aura for damage calculation

                        Unit::AuraEffectList const& mPeriodic = unitTarget->GetAuraEffectsByType(SPELL_AURA_PERIODIC_DAMAGE);
                        for (Unit::AuraEffectList::const_iterator i = mPeriodic.begin(); i != mPeriodic.end(); ++i)
                        {
                            // for caster applied auras only
                            if ((*i)->GetSpellInfo()->SpellFamilyName != SPELLFAMILY_WARLOCK ||
                                    (*i)->GetCasterGUID() != m_caster->GetGUID())
                                continue;

                            // Immolate
                            if ((*i)->GetSpellInfo()->SpellFamilyFlags[0] & 0x4)
                            {
                                aura = *i;                      // it selected always if exist
                                break;
                            }

                            // Shadowflame
                            if ((*i)->GetSpellInfo()->SpellFamilyFlags[2] & 0x00000002)
                                aura = *i;                      // remember but wait possible Immolate as primary priority
                        }

                        // found Immolate or Shadowflame
                        if (aura)
                        {
                            uint32 pdamage = uint32(std::max(aura->GetAmount(), 0));
                            pdamage = unitTarget->SpellDamageBonusTaken(m_caster, aura->GetSpellInfo(), pdamage, DOT, aura->GetBase()->GetStackAmount());
                            uint32 pct_dir = m_caster->CalculateSpellDamage(unitTarget, m_spellInfo, (effIndex + 1));
                            uint8 baseTotalTicks = uint8(m_caster->CalcSpellDuration(aura->GetSpellInfo()) / aura->GetSpellInfo()->Effects[EFFECT_0].Amplitude);

                            damage += int32(CalculatePct(pdamage * baseTotalTicks, pct_dir));

                            uint32 pct_dot = m_caster->CalculateSpellDamage(unitTarget, m_spellInfo, (effIndex + 2)) / 3;
                            m_spellValue->EffectBasePoints[1] = m_spellInfo->Effects[EFFECT_1].CalcBaseValue(int32(CalculatePct(pdamage * baseTotalTicks, pct_dot)));

                            apply_direct_bonus = false;
                            // Glyph of Conflagrate
                            if (!m_caster->HasAura(56235))
                                unitTarget->RemoveAurasDueToSpell(aura->GetId(), m_caster->GetGUID());

                            break;
                        }
                    }
                    // Shadow Bite
                    else if (m_spellInfo->SpellFamilyFlags[1] & 0x400000)
                    {
                        if (m_caster->GetTypeId() == TYPEID_UNIT && m_caster->IsPet())
                        {
                            if (Player* owner = m_caster->GetOwner()->ToPlayer())
                            {
                                if (AuraEffect* aurEff = owner->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_WARLOCK, 214, 0))
                                {
                                    int32 bp0 = aurEff->GetId() == 54037 ? 4 : 8;
                                    m_caster->CastCustomSpell(m_caster, 54425, &bp0, nullptr, nullptr, true);
                                }
                            }
                        }
                    }
                    break;
                }
            case SPELLFAMILY_PRIEST:
                {
                    // Improved Mind Blast (Mind Blast in shadow form bonus)
                    if (m_caster->GetShapeshiftForm() == FORM_SHADOW && (m_spellInfo->SpellFamilyFlags[0] & 0x00002000))
                    {
                        Unit::AuraEffectList const& ImprMindBlast = m_caster->GetAuraEffectsByType(SPELL_AURA_ADD_FLAT_MODIFIER);
                        for (Unit::AuraEffectList::const_iterator i = ImprMindBlast.begin(); i != ImprMindBlast.end(); ++i)
                        {
                            if ((*i)->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_PRIEST &&
                                    ((*i)->GetSpellInfo()->SpellIconID == 95))
                            {
                                int chance = (*i)->GetSpellInfo()->Effects[EFFECT_1].CalcValue(m_caster);
                                if (roll_chance_i(chance))
                                    // Mind Trauma
                                    m_caster->CastSpell(unitTarget, 48301, true, 0);
                                break;
                            }
                        }
                    }
                    break;
                }
            case SPELLFAMILY_DRUID:
                {
                    // Ferocious Bite
                    if (m_caster->GetTypeId() == TYPEID_PLAYER && (m_spellInfo->SpellFamilyFlags[0] & 0x000800000) && m_spellInfo->SpellVisual[0] == 6587)
                    {
                        // converts each extra point of energy into ($f1+$AP/410) additional damage
                        float ap = m_caster->GetTotalAttackPowerValue(BASE_ATTACK);
                        float multiple = ap / 410 + m_spellInfo->Effects[effIndex].DamageMultiplier;
                        int32 energy = -(m_caster->ModifyPower(POWER_ENERGY, -30));
                        damage += int32(energy * multiple);
                        damage += int32(CalculatePct(m_caster->GetComboPoints() * ap, 7));
                    }
                    //npcbot: Ferocious Bite support
                    else if (m_caster->IsNPCBot() && (m_spellInfo->SpellFamilyFlags[0] & 0x800000) && m_spellInfo->SpellVisual[0] == 6587)
                    {
                        // converts each extra point of energy into ($f1+$AP/410) additional damage
                        float ap = m_caster->GetTotalAttackPowerValue(BASE_ATTACK);
                        float multiple = ap / 410 + m_spellInfo->Effects[effIndex].DamageMultiplier;
                        int32 energy = -(m_caster->ModifyPower(POWER_ENERGY, -30));
                        damage += int32(energy * multiple);
                        damage += int32(CalculatePct(m_caster->ToCreature()->GetCreatureComboPoints() * ap, 7));
                    }
                    //end npcbot
                    // Wrath
                    else if (m_spellInfo->SpellFamilyFlags[0] & 0x00000001)
                    {
                        // Improved Insect Swarm
                        if (AuraEffect const* aurEff = m_caster->GetDummyAuraEffect(SPELLFAMILY_DRUID, 1771, 0))
                            if (unitTarget->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_DRUID, 0x00200000, 0, 0))
                                AddPct(damage, aurEff->GetAmount());
                    }
                    break;
                }
            case SPELLFAMILY_ROGUE:
                {
                    // Envenom
                    if (m_spellInfo->SpellFamilyFlags[1] & 0x00000008)
                    {
                        if (Player* player = m_caster->ToPlayer())
                        {
                            // consume from stack dozes not more that have combo-points
                            if (uint32 combo = player->GetComboPoints())
                            {
                                // Lookup for Deadly poison (only attacker applied)
                                if (AuraEffect const* aurEff = unitTarget->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_ROGUE, 0x00010000, 0, 0, m_caster->GetGUID()))
                                {
                                    // count consumed deadly poison doses at target
                                    bool needConsume = true;
                                    uint32 spellId = aurEff->GetId();

                                    uint32 doses = aurEff->GetBase()->GetStackAmount();
                                    if (doses > combo)
                                        doses = combo;

                                    // Master Poisoner
                                    Unit::AuraEffectList const& auraList = player->GetAuraEffectsByType(SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL_NOT_STACK);
                                    for (Unit::AuraEffectList::const_iterator iter = auraList.begin(); iter != auraList.end(); ++iter)
                                    {
                                        if ((*iter)->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_ROGUE && (*iter)->GetSpellInfo()->SpellIconID == 1960)
                                        {
                                            uint32 chance = (*iter)->GetSpellInfo()->Effects[EFFECT_2].CalcValue(m_caster);

                                            if (chance && roll_chance_i(chance))
                                                needConsume = false;

                                            break;
                                        }
                                    }

                                    if (needConsume)
                                        for (uint32 i = 0; i < doses; ++i)
                                            unitTarget->RemoveAuraFromStack(spellId, m_caster->GetGUID());

                                    damage *= doses;
                                    damage += int32(player->GetTotalAttackPowerValue(BASE_ATTACK) * 0.09f * combo);
                                }

                                // Eviscerate and Envenom Bonus Damage (item set effect)
                                if (m_caster->HasAura(37169))
                                    damage += combo * 40;
                            }
                        }
                        //npcbot: Envenom support
                        else if (m_caster->IsNPCBot())
                        {
                            // consume from stack dozes not more that have combo-points
                            if (uint8 combo = m_caster->ToCreature()->GetCreatureComboPoints())
                            {
                                // Lookup for Deadly poison (only attacker applied)
                                if (AuraEffect const* aurEff = unitTarget->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_ROGUE, 0x00010000, 0, 0, m_caster->GetGUID()))
                                {
                                    // count consumed deadly poison doses at target
                                    bool needConsume = true;
                                    uint32 spellId = aurEff->GetId();

                                    uint32 doses = aurEff->GetBase()->GetStackAmount();
                                    if (doses > combo)
                                        doses = combo;

                                    // Master Poisoner
                                    Unit::AuraEffectList const& auraList = m_caster->GetAuraEffectsByType(SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL_NOT_STACK);
                                    for (Unit::AuraEffectList::const_iterator iter = auraList.begin(); iter != auraList.end(); ++iter)
                                    {
                                        if ((*iter)->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_ROGUE && (*iter)->GetSpellInfo()->SpellIconID == 1960)
                                        {
                                            uint32 chance = (*iter)->GetSpellInfo()->GetEffect(EFFECT_2).CalcValue(m_caster);

                                            if (chance && roll_chance_i(chance))
                                                needConsume = false;

                                            break;
                                        }
                                    }

                                    if (needConsume)
                                        for (uint32 i = 0; i < doses; ++i)
                                            unitTarget->RemoveAuraFromStack(spellId, m_caster->GetGUID());

                                    damage *= doses;
                                    damage += int32(m_caster->GetTotalAttackPowerValue(BASE_ATTACK) * 0.09f * combo);
                                }

                                // Eviscerate and Envenom Bonus Damage (item set effect)
                                if (m_caster->HasAura(37169))
                                    damage += combo * 40;
                            }
                        }
                        //end npcbot
                    }
                    // Eviscerate
                    else if (m_spellInfo->SpellFamilyFlags[0] & 0x00020000)
                    {
                        if (m_caster->GetTypeId() == TYPEID_PLAYER)
                        {
                            if (uint32 combo = m_caster->ToPlayer()->GetComboPoints())
                            {
                                float ap = m_caster->GetTotalAttackPowerValue(BASE_ATTACK);
                                damage += int32(ap * combo * 0.07f);

                                // Eviscerate and Envenom Bonus Damage (item set effect)
                                if (m_caster->HasAura(37169))
                                    damage += combo * 40;
                            }
                        }
                        //npcbot: Eviscerate support
                        else if (m_caster->IsNPCBot())
                        {
                            if (uint32 combo = m_caster->ToCreature()->GetCreatureComboPoints())
                            {
                                float ap = m_caster->GetTotalAttackPowerValue(BASE_ATTACK);
                                damage += std::lroundf(ap * combo * 0.07f);

                                // Eviscerate and Envenom Bonus Damage (item set effect)
                                if (m_caster->HasAura(37169))
                                    damage += combo*40;
                            }
                        }
                        //end npcbot
                    }
                    break;
                }
            case SPELLFAMILY_HUNTER:
                {
                    //Gore
                    if (m_spellInfo->SpellIconID == 1578)
                    {
                        if (m_caster->HasAura(57627))           // Charge 6 sec post-affect
                            damage *= 2;
                    }
                    // Steady Shot
                    else if (m_spellInfo->SpellFamilyFlags[1] & 0x1)
                    {
                        bool found = false;
                        // check dazed affect
                        Unit::AuraEffectList const& decSpeedList = unitTarget->GetAuraEffectsByType(SPELL_AURA_MOD_DECREASE_SPEED);
                        for (Unit::AuraEffectList::const_iterator iter = decSpeedList.begin(); iter != decSpeedList.end(); ++iter)
                        {
                            if ((*iter)->GetSpellInfo()->SpellIconID == 15 && (*iter)->GetSpellInfo()->Dispel == 0)
                            {
                                found = true;
                                break;
                            }
                        }

                        /// @todo: should this be put on taken but not done?
                        if (found)
                            damage += m_spellInfo->Effects[EFFECT_1].CalcValue();

                        if (Player* caster = m_caster->ToPlayer())
                        {
                            // Add Ammo and Weapon damage plus RAP * 0.1
                            float dmg_min = 0.f;
                            float dmg_max = 0.f;
                            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
                            {
                                dmg_min += caster->GetWeaponDamageRange(RANGED_ATTACK, MINDAMAGE, i);
                                dmg_max += caster->GetWeaponDamageRange(RANGED_ATTACK, MAXDAMAGE, i);
                            }

                            if (dmg_max == 0.0f && dmg_min > dmg_max)
                            {
                                damage += int32(dmg_min);
                            }
                            else
                            {
                                damage += irand(int32(dmg_min), int32(dmg_max));
                            }
                            damage += int32(caster->GetAmmoDPS() * caster->GetAttackTime(RANGED_ATTACK) * 0.001f);
                        }
                        //npcbot: calculate bot weapon damage
                        if (m_caster->IsNPCBot())
                        {
                            if (Item* item = m_caster->ToCreature()->GetBotEquips(2/*BOT_SLOT_RANGED*/))
                            {
                                ItemTemplate const* weaponTemplate = item->GetTemplate();
                                float dmg_min = 0.f;
                                float dmg_max = 0.f;
                                for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
                                {
                                    dmg_min += weaponTemplate->Damage[i].DamageMin;
                                    dmg_max += weaponTemplate->Damage[i].DamageMax;
                                }
                                if (dmg_max == 0.0f && dmg_min > dmg_max)
                                    damage += int32(dmg_min);
                                else
                                    damage += irand(int32(dmg_min), int32(dmg_max));
                                damage += int32(m_caster->ToCreature()->GetCreatureAmmoDPS() * weaponTemplate->Delay * 0.001f);
                            }
                        }
                        //end npcbot
                    }
                    break;
                }
            case SPELLFAMILY_PALADIN:
                {
                    // Hammer of the Righteous
                    if (m_spellInfo->SpellFamilyFlags[1] & 0x00040000)
                    {
                        // Add main hand dps * effect[2] amount
                        if (Player* player = m_caster->ToPlayer())
                        {
                            float minTotal = 0.f;
                            float maxTotal = 0.f;
                            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
                            {
                                float tmpMin, tmpMax;
                                player->CalculateMinMaxDamage(BASE_ATTACK, false, false, tmpMin, tmpMax, i);
                                minTotal += tmpMin;
                                maxTotal += tmpMax;
                            }

                            float average = (minTotal + maxTotal) / 2;
                            int32 count = m_caster->CalculateSpellDamage(unitTarget, m_spellInfo, EFFECT_2);
                            damage += count * int32(average * IN_MILLISECONDS) / m_caster->GetAttackTime(BASE_ATTACK);
                        }
                        //npcbot: creature weaoin damage
                        else if (m_caster->IsNPCBot())
                        {
                            float minTotal = 0.f;
                            float maxTotal = 0.f;

                            float tmpMin, tmpMax;
                            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
                            {
                                m_caster->ToCreature()->CalculateMinMaxDamage(BASE_ATTACK, false, false, tmpMin, tmpMax, i);
                                minTotal += tmpMin;
                                maxTotal += tmpMax;
                            }

                            float average = (minTotal + maxTotal) / 2;
                            // Add main hand dps * effect[2] amount
                            int32 count = m_caster->CalculateSpellDamage(unitTarget, m_spellInfo, EFFECT_2);
                            damage += count * int32(average * IN_MILLISECONDS) / m_caster->GetAttackTime(BASE_ATTACK);
                        }
                        //end npcbot
                        break;
                    }
                    // Shield of Righteousness
                    if (m_spellInfo->SpellFamilyFlags[EFFECT_1] & 0x100000)
                    {
                        uint8 level = m_caster->GetLevel();
                        uint32 block_value = m_caster->GetShieldBlockValue(uint32(float(level) * 29.5f), uint32(float(level) * 34.5f));
                        if (m_caster->GetAuraEffect(64882, EFFECT_0))
                            block_value += 225;
                        damage += CalculatePct(block_value, m_spellInfo->Effects[EFFECT_1].CalcValue());
                        break;
                    }
                    break;
                }
        }

        if (m_originalCaster /*&& damage > 0 Xinef: this can be increased from 0*/ && apply_direct_bonus)
        {
            // Xinef: protection
            if (damage < 0)
                damage = 0;

            damage = m_originalCaster->SpellDamageBonusDone(unitTarget, m_spellInfo, (uint32)damage, SPELL_DIRECT_DAMAGE, effIndex);
            damage = unitTarget->SpellDamageBonusTaken(m_originalCaster, m_spellInfo, (uint32)damage, SPELL_DIRECT_DAMAGE);
        }

        m_damage += damage;
    }
}

void Spell::EffectDummy(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget && !gameObjTarget && !itemTarget)
        return;

    // selection by spell family
    switch (m_spellInfo->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            {
                switch (m_spellInfo->Id)
                {
                    // Trial of the Champion, Trample
                    case 67866:
                        {
                            if( unitTarget && !unitTarget->IsVehicle() && !unitTarget->GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID) )
                                unitTarget->CastSpell(unitTarget, 67867, false);
                            return;
                        }
                    // Trial of the Champion, Hammer of the Righteous
                    case 66867:
                        {
                            if( !unitTarget )
                                return;
                            if( unitTarget->HasAura(66940) )
                                m_caster->CastSpell(unitTarget, 66903, true);
                            else
                                m_caster->CastSpell(unitTarget, 66904, true);
                            return;
                        }
                    case 17731:
                    case 69294:
                        {
                            if( !gameObjTarget || gameObjTarget->GetRespawnTime() > GameTime::GetGameTime().count() )
                                return;

                            gameObjTarget->SetRespawnTime(10);
                            gameObjTarget->SendCustomAnim(gameObjTarget->GetGoAnimProgress());
                            if( Creature* trigger = gameObjTarget->SummonCreature(12758, *gameObjTarget, TEMPSUMMON_TIMED_DESPAWN, 1000) )
                                trigger->CastSpell(trigger, 17731, false);

                            return;
                        }
                    // HoL, Arc Weld
                    case 59086:
                        {
                            if( m_caster && m_caster->GetTypeId() == TYPEID_PLAYER && m_caster->ToPlayer()->isMoving() )
                                m_caster->CastSpell(m_caster, 59097, true);

                            return;
                        }
                }
                break;
            }
        case SPELLFAMILY_PALADIN:
            switch (m_spellInfo->Id)
            {
                case 31789:                                 // Righteous Defense (step 1)
                    {
                        if (!unitTarget)
                            return;
                        // not empty (checked), copy
                        Unit::AttackerSet attackers = unitTarget->getAttackers();

                        // remove invalid attackers
                        for (Unit::AttackerSet::iterator aItr = attackers.begin(); aItr != attackers.end();)
                            if (!(*aItr)->IsValidAttackTarget(m_caster))
                                aItr = attackers.erase(aItr);
                            else
                                ++aItr;

                        // selected from list 3
                        uint32 maxTargets = std::min<uint32>(3, attackers.size());
                        for (uint32 i = 0; i < maxTargets; ++i)
                        {
                            Unit::AttackerSet::iterator aItr = attackers.begin();
                            std::advance(aItr, urand(0, attackers.size() - 1));
                            m_caster->CastSpell((*aItr), 31790, true);
                            attackers.erase(aItr);
                        }

                        return;
                    }
            }
            break;
        case SPELLFAMILY_ROGUE:
            // Hunger for Blood
            if( m_spellInfo->Id == 51662 )
            {
                m_caster->CastSpell(m_caster, 63848, true);
                return;
            }
            break;
    }

    // pet auras
    if (PetAura const* petSpell = sSpellMgr->GetPetAura(m_spellInfo->Id, effIndex))
    {
        m_caster->AddPetAura(petSpell);
        return;
    }

    // normal DB scripted effect
    LOG_DEBUG("spells.aura", "Spell ScriptStart spellid {} in EffectDummy({})", m_spellInfo->Id, effIndex);
    m_caster->GetMap()->ScriptsStart(sSpellScripts, uint32(m_spellInfo->Id | (effIndex << 24)), m_caster, unitTarget);

    if (gameObjTarget)
    {
        sScriptMgr->OnDummyEffect(m_caster, m_spellInfo->Id, effIndex, gameObjTarget);
    }
    else if (unitTarget && unitTarget->GetTypeId() == TYPEID_UNIT)
    {
        sScriptMgr->OnDummyEffect(m_caster, m_spellInfo->Id, effIndex, unitTarget->ToCreature());
    }
    else if (itemTarget)
    {
        sScriptMgr->OnDummyEffect(m_caster, m_spellInfo->Id, effIndex, itemTarget);
    }
}

void Spell::EffectTriggerSpell(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET
            && effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH)
        return;

    uint32 triggered_spell_id = m_spellInfo->Effects[effIndex].TriggerSpell;

    /// @todo: move those to spell scripts
    if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_TRIGGER_SPELL
            && effectHandleMode == SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
    {
        // special cases
        switch (triggered_spell_id)
        {
            //npcbot: triggered heal/energize calculation (effect)
            // Quest - Self Healing from resurrect (invisible in log)
            case 25155:
            {
                switch (m_spellInfo->Id)
                {
                    //Replenish Life (Regenerating Aura)
                    case 34756:
                    {
                        //cannot target self
                        if (m_caster == unitTarget)
                            return;

                        // % of max health
                        int32 basepoints0 = 0.01f * unitTarget->GetMaxHealth() * m_spellInfo->Effects[effIndex].BasePoints;
                        //TC_LOG_ERROR("entities.unit", "TriggerSpell(%u from %u): %s on %s base val %i,",
                        //    triggered_spell_id, m_spellInfo->Id, m_caster->GetName().c_str(), unitTarget->GetName().c_str(), int32(basepoints0));
                        //CastSpellExtraArgs args(true);
                        //args.AddSpellBP0(basepoints0);
                        //unitTarget->CastSpell(unitTarget, triggered_spell_id, args);
                        unitTarget->CastCustomSpell(unitTarget, triggered_spell_id, &basepoints0, nullptr, nullptr, true);
                        return;
                    }
                    default:
                        break;
                }
                break;
            }
            // Energize (invisible in log)
            case 60628:
            {
                switch (m_spellInfo->Id)
                {
                    //Replenish Mana
                    case 33394:
                    {
                        //cannot target self
                        if (m_caster == unitTarget)
                            return;

                        // % of max mana
                        int32 basepoints0 = m_spellInfo->Effects[effIndex].BasePoints;
                        //TC_LOG_ERROR("entities.unit", "TriggerSpell(%u from %u): %s on %s base val %i,",
                        //    triggered_spell_id, m_spellInfo->Id, m_caster->GetName().c_str(), unitTarget->GetName().c_str(), int32(basepoints0));
                        //CastSpellExtraArgs args(true);
                        //args.AddSpellBP0(basepoints0);
                        //unitTarget->CastSpell(unitTarget, triggered_spell_id, args);
                        unitTarget->CastCustomSpell(unitTarget, triggered_spell_id, &basepoints0, nullptr, nullptr, true, nullptr, nullptr, m_caster->GetGUID());
                        return;
                    }
                    default:
                        break;
                }
                break;
            }
            //end npcbot
            // Mirror Image
            case 58832:
                {
                    // Glyph of Mirror Image
                    if (m_caster->HasAura(63093))
                        m_caster->CastSpell(m_caster, 65047, true); // Mirror Image

                    break;
                }
            // Demonic Empowerment -- succubus
            case 54437:
                {
                    unitTarget->RemoveMovementImpairingAuras(true);
                    unitTarget->RemoveAurasByType(SPELL_AURA_MOD_STALKED);
                    unitTarget->RemoveAurasByType(SPELL_AURA_MOD_STUN);

                    // Cast Lesser Invisibility
                    unitTarget->CastSpell(unitTarget, 7870, true);
                    return;
                }
            // just skip
            case 23770:                                         // Sayge's Dark Fortune of *
                // not exist, common cooldown can be implemented in scripts if need.
                return;
            // Brittle Armor - (need add max stack of 24575 Brittle Armor)
            case 29284:
                {
                    // Brittle Armor
                    SpellInfo const* spell = sSpellMgr->GetSpellInfo(24575);
                    if (!spell)
                        return;

                    for (uint32 j = 0; j < spell->StackAmount; ++j)
                        m_caster->CastSpell(unitTarget, spell->Id, true);
                    return;
                }
            // Mercurial Shield - (need add max stack of 26464 Mercurial Shield)
            case 29286:
                {
                    // Mercurial Shield
                    SpellInfo const* spell = sSpellMgr->GetSpellInfo(26464);
                    if (!spell)
                        return;

                    for (uint32 j = 0; j < spell->StackAmount; ++j)
                        m_caster->CastSpell(unitTarget, spell->Id, true);
                    return;
                }
            // Cloak of Shadows
            case 35729:
                {
                    uint32 dispelMask = SpellInfo::GetDispelMask(DISPEL_ALL);
                    Unit::AuraApplicationMap& Auras = unitTarget->GetAppliedAuras();
                    for (Unit::AuraApplicationMap::iterator iter = Auras.begin(); iter != Auras.end();)
                    {
                        // remove all harmful spells on you...
                        SpellInfo const* spell = iter->second->GetBase()->GetSpellInfo();

                        // Pounce Bleed shouldn't be removed by Cloak of Shadows.
                        if (spell->GetAllEffectsMechanicMask() & 1 << MECHANIC_BLEED)
                            return;

                        bool dmgClassNone = false;
                        if (spell->DmgClass == SPELL_DAMAGE_CLASS_NONE && spell->SpellFamilyName == SPELLFAMILY_GENERIC)
                            for (uint8 i = EFFECT_0; i < MAX_SPELL_EFFECTS; ++i)
                            {
                                if ((iter->second->GetEffectMask() & (1 << i)) &&
                                        spell->Effects[i].ApplyAuraName != SPELL_AURA_PERIODIC_DAMAGE &&
                                        spell->Effects[i].ApplyAuraName != SPELL_AURA_PERIODIC_TRIGGER_SPELL &&
                                        spell->Effects[i].ApplyAuraName != SPELL_AURA_DUMMY)
                                {
                                    dmgClassNone = false;
                                    break;
                                }
                                dmgClassNone = true;
                            }

                        if ((spell->DmgClass == SPELL_DAMAGE_CLASS_MAGIC || (spell->GetDispelMask() & dispelMask) || dmgClassNone) &&
                                // ignore positive and passive auras
                                !iter->second->IsPositive() && !iter->second->GetBase()->IsPassive() &&
                                // Xinef: Ignore NPC spells having INVULNERABILITY attribute
                                (!spell->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) || spell->SpellFamilyName != SPELLFAMILY_GENERIC))
                        {
                            m_caster->RemoveAura(iter);
                        }
                        else
                            ++iter;
                    }
                    return;
                }
        }
    }

    // normal case
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(triggered_spell_id);
    if (!spellInfo)
    {
        LOG_DEBUG("spells.aura", "Spell::EffectTriggerSpell spell {} tried to trigger unknown spell {}", m_spellInfo->Id, triggered_spell_id);
        return;
    }

    //npcbot: override spellInfo
    spellInfo = spellInfo->TryGetSpellInfoOverride(GetCaster());
    //end npcbot

    SpellCastTargets targets;
    if (effectHandleMode == SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
    {
        if (!spellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, effIndex))
            return;
        targets.SetUnitTarget(unitTarget);
    }
    else //if (effectHandleMode == SPELL_EFFECT_HANDLE_LAUNCH)
    {
        if (spellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, effIndex) && (m_spellInfo->Effects[effIndex].GetProvidedTargetMask() & TARGET_FLAG_UNIT_MASK))
            return;

        if (spellInfo->GetExplicitTargetMask() & TARGET_FLAG_DEST_LOCATION)
            targets.SetDst(m_targets);

        if (Unit* target = m_targets.GetUnitTarget())
            targets.SetUnitTarget(target);
        else
            targets.SetUnitTarget(m_caster);
    }

    CustomSpellValues values;
    // set basepoints for trigger with value effect
    if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE)
    {
        // maybe need to set value only when basepoints == 0?
        values.AddSpellMod(SPELLVALUE_BASE_POINT0, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT1, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT2, damage);
    }

    // Remove spell cooldown (not category) if spell triggering spell with cooldown and same category
    if (m_caster->GetTypeId() == TYPEID_PLAYER && spellInfo->CategoryRecoveryTime && m_spellInfo->GetCategory() == spellInfo->GetCategory())
    {
        m_caster->ToPlayer()->RemoveSpellCooldown(spellInfo->Id);
    }

    // original caster guid only for GO cast
    m_caster->CastSpell(targets, spellInfo, &values, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_NO_PERIODIC_RESET), nullptr, nullptr, m_originalCasterGUID);
}

void Spell::EffectTriggerMissileSpell(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET
            && effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    uint32 triggered_spell_id = m_spellInfo->Effects[effIndex].TriggerSpell;

    // normal case
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(triggered_spell_id);
    if (!spellInfo)
    {
        LOG_DEBUG("spells.aura", "Spell::EffectTriggerMissileSpell spell {} tried to trigger unknown spell {}", m_spellInfo->Id, triggered_spell_id);
        return;
    }

    //npcbot: override spellInfo
    spellInfo = spellInfo->TryGetSpellInfoOverride(GetCaster());
    //end npcbot

    SpellCastTargets targets;
    if (effectHandleMode == SPELL_EFFECT_HANDLE_HIT_TARGET)
    {
        if (!spellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, effIndex))
            return;
        targets.SetUnitTarget(unitTarget);
    }
    else //if (effectHandleMode == SPELL_EFFECT_HANDLE_HIT)
    {
        if (spellInfo->NeedsToBeTriggeredByCaster(m_spellInfo, effIndex) && (m_spellInfo->Effects[effIndex].GetProvidedTargetMask() & TARGET_FLAG_UNIT_MASK))
            return;

        if (spellInfo->GetExplicitTargetMask() & TARGET_FLAG_DEST_LOCATION)
            targets.SetDst(m_targets);

        targets.SetUnitTarget(m_caster);
    }

    CustomSpellValues values;
    // set basepoints for trigger with value effect
    if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_TRIGGER_MISSILE_SPELL_WITH_VALUE)
    {
        // maybe need to set value only when basepoints == 0?
        values.AddSpellMod(SPELLVALUE_BASE_POINT0, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT1, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT2, damage);
    }

    // Remove spell cooldown (not category) if spell triggering spell with cooldown and same category
    if (m_caster->GetTypeId() == TYPEID_PLAYER && spellInfo->CategoryRecoveryTime && m_spellInfo->GetCategory() == spellInfo->GetCategory())
    {
        m_caster->ToPlayer()->RemoveSpellCooldown(spellInfo->Id);
    }

    // original caster guid only for GO cast
    m_caster->CastSpell(targets, spellInfo, &values, TRIGGERED_FULL_MASK, nullptr, nullptr, m_originalCasterGUID);
}

void Spell::EffectForceCast(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    uint32 triggered_spell_id = m_spellInfo->Effects[effIndex].TriggerSpell;

    // normal case
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(triggered_spell_id);

    if (!spellInfo)
    {
        LOG_ERROR("spells.effect", "Spell::EffectForceCast of spell {}: triggering unknown spell id {}", m_spellInfo->Id, triggered_spell_id);
        return;
    }

    if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_FORCE_CAST && damage)
    {
        switch (m_spellInfo->Id)
        {
            case 52588: // Skeletal Gryphon Escape
            case 48598: // Ride Flamebringer Cue
                unitTarget->RemoveAura(damage);
                break;
            case 52463: // Hide In Mine Car
            case 52349: // Overtake
                unitTarget->CastCustomSpell(unitTarget, spellInfo->Id, &damage, nullptr, nullptr, true, nullptr, nullptr, m_originalCasterGUID);
                return;
            case 72378: // Blood Nova
            case 73058: // Blood Nova
                m_caster->CastSpell(unitTarget, damage, true);   // additional spell cast
                break;
        }
    }

    CustomSpellValues values;
    // set basepoints for trigger with value effect
    if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_FORCE_CAST_WITH_VALUE)
    {
        // maybe need to set value only when basepoints == 0?
        values.AddSpellMod(SPELLVALUE_BASE_POINT0, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT1, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT2, damage);
    }

    SpellCastTargets targets;
    targets.SetUnitTarget(m_caster);

    unitTarget->CastSpell(targets, spellInfo, &values, TRIGGERED_FULL_MASK);
}

void Spell::EffectTriggerRitualOfSummoning(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    uint32 triggered_spell_id = m_spellInfo->Effects[effIndex].TriggerSpell;
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(triggered_spell_id);

    if (!spellInfo)
    {
        LOG_ERROR("spells.effect", "EffectTriggerRitualOfSummoning of spell {}: triggering unknown spell id {}", m_spellInfo->Id, triggered_spell_id);
        return;
    }

    finish();

    m_caster->CastSpell((Unit*)nullptr, spellInfo, false);
}

void Spell::EffectJump(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (m_caster->IsInFlight())
        return;

    if (!unitTarget)
        return;

    float speedXY, speedZ;
    CalculateJumpSpeeds(effIndex, m_caster->GetExactDist2d(unitTarget), speedXY, speedZ);
    m_caster->GetMotionMaster()->MoveJump(*unitTarget, speedXY, speedZ);

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        sScriptMgr->AnticheatSetUnderACKmount(m_caster->ToPlayer());
    }
}

void Spell::EffectJumpDest(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH)
        return;

    if (m_caster->IsInFlight())
        return;

    if (!m_targets.HasDst() || m_caster->GetVehicle())
        return;

    // Init dest coordinates
    float x, y, z;
    destTarget->GetPosition(x, y, z);
    // xinef: this can happen if MovePositionToFirstCollision detects that X, Y cords are invalid and returns prematurely
    if (!Acore::IsValidMapCoord(x, y, z) || z <= INVALID_HEIGHT)
        return;

    float speedXY, speedZ;
    float dist = m_caster->GetExactDist2d(x, y);
    CalculateJumpSpeeds(effIndex, dist, speedXY, speedZ);

    // Override, calculations are incorrect
    if (m_spellInfo->Id == 49376) // feral charge
    {
        speedXY = pow(speedZ * 10, 8);
        m_caster->GetMotionMaster()->MoveJump(x, y, z, speedXY, speedZ, 0, ObjectAccessor::GetUnit(*m_caster, m_caster->GetGuidValue(UNIT_FIELD_TARGET)));

        if (Player* player = m_caster->ToPlayer())
        {
            player->SetCanTeleport(true);
        }

        if (m_caster->GetTypeId() == TYPEID_PLAYER)
        {
            sScriptMgr->AnticheatSetUnderACKmount(m_caster->ToPlayer());
        }

        return;
    }

    if (m_spellInfo->Id == 57604) // death grip
    {
        speedZ = 3.0f;
        speedXY = 50.0f;
    }

    // crash fix?
    if (speedXY < 1.0f)
        speedXY = 1.0f;

    if (Player* player = m_caster->ToPlayer())
    {
        player->SetCanTeleport(true);
    }
    m_caster->GetMotionMaster()->MoveJump(x, y, z, speedXY, speedZ);

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        sScriptMgr->AnticheatSetUnderACKmount(m_caster->ToPlayer());
    }
}

void Spell::CalculateJumpSpeeds(uint8 i, float dist, float& speedXY, float& speedZ)
{
    if (m_spellInfo->Effects[i].MiscValue)
        speedZ = float(m_spellInfo->Effects[i].MiscValue) / 10;
    else if (m_spellInfo->Effects[i].MiscValueB)
        speedZ = float(m_spellInfo->Effects[i].MiscValueB) / 10;
    else
        speedZ = 10.0f;
    speedXY = dist * 10.0f / speedZ;
}

void Spell::EffectTeleportUnits(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || unitTarget->IsInFlight())
        return;

    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
    {
        sScriptMgr->AnticheatSetUnderACKmount(unitTarget->ToPlayer());
    }

    // Pre effects
    switch (m_spellInfo->Id)
    {
        case 70746: // Teleport Into Sunwell (for Battered Hilt)
            if (Player* target = unitTarget->ToPlayer())
            {
                uint32 mapid = destTarget->GetMapId();
                float x, y, z, orientation;
                destTarget->GetPosition(x, y, z, orientation);
                target->TeleportTo(mapid, x, y, z, orientation, TELE_TO_GM_MODE); // skip PlayerCannotEnter check
            }
            return;
    }

    // If not exist data for dest location - return
    if (!m_targets.HasDst())
    {
        LOG_ERROR("spells.effect", "Spell::EffectTeleportUnits - does not have destination for spell ID {}\n", m_spellInfo->Id);
        return;
    }

    // Init dest coordinates
    uint32 mapid = destTarget->GetMapId();
    if (mapid == MAPID_INVALID)
        mapid = unitTarget->GetMapId();
    float x, y, z, orientation;
    destTarget->GetPosition(x, y, z, orientation);
    if (!orientation && m_targets.GetUnitTarget())
        orientation = m_targets.GetUnitTarget()->GetOrientation();
    LOG_DEBUG("spells.aura", "Spell::EffectTeleportUnits - teleport unit to {} {} {} {} {}\n", mapid, x, y, z, orientation);

    if (mapid == unitTarget->GetMapId())
    {
        if (unitTarget->GetVehicleKit()) // we are vehicle!
            unitTarget->GetVehicleKit()->TeleportVehicle(x, y, z, orientation);
        else
        {
            bool withPet = unitTarget->GetTypeId() == TYPEID_PLAYER && m_spellInfo->SpellFamilyName == SPELLFAMILY_GENERIC && unitTarget->GetMap()->IsDungeon() && unitTarget->GetExactDist(x, y, z) > 50.0f;
            unitTarget->NearTeleportTo(x, y, z, orientation, unitTarget == m_caster, false, withPet, true);
            if (unitTarget->GetTypeId() == TYPEID_PLAYER) // pussywizard: for units it's done inside NearTeleportTo
                unitTarget->UpdateObjectVisibility(true);
        }
    }
    else if (unitTarget->GetTypeId() == TYPEID_PLAYER)
        unitTarget->ToPlayer()->TeleportTo(mapid, x, y, z, orientation, unitTarget == m_caster ? TELE_TO_SPELL : 0);
    else
    {
        LOG_ERROR("spells.effect", "Spell::EffectTeleportUnits - spellId {} attempted to teleport creature to a different map.", m_spellInfo->Id);
        return;
    }

    // post effects for TARGET_DEST_DB
    switch (m_spellInfo->Id)
    {
        // Dimensional Ripper - Everlook
        case 23442:
            {
                int32 r = irand(0, 119);
                if (r >= 70)                                  // 7/12 success
                {
                    if (r < 100)                              // 4/12 evil twin
                        m_caster->CastSpell(m_caster, 23445, true);
                    else                                        // 1/12 fire
                        m_caster->CastSpell(m_caster, 23449, true);
                }
                return;
            }
        // Ultrasafe Transporter: Toshley's Station
        case 36941:
            {
                if (roll_chance_i(50))                        // 50% success
                {
                    int32 rand_eff = urand(1, 7);
                    switch (rand_eff)
                    {
                        case 1:
                            // soul split - evil
                            m_caster->CastSpell(m_caster, 36900, true);
                            break;
                        case 2:
                            // soul split - good
                            m_caster->CastSpell(m_caster, 36901, true);
                            break;
                        case 3:
                            // Increase the size
                            m_caster->CastSpell(m_caster, 36895, true);
                            break;
                        case 4:
                            // Decrease the size
                            m_caster->CastSpell(m_caster, 36893, true);
                            break;
                        case 5:
                            // Transform
                            {
                                if (m_caster->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                                    m_caster->CastSpell(m_caster, 36897, true);
                                else
                                    m_caster->CastSpell(m_caster, 36899, true);
                                break;
                            }
                        case 6:
                            // chicken
                            m_caster->CastSpell(m_caster, 36940, true);
                            break;
                        case 7:
                            // evil twin
                            m_caster->CastSpell(m_caster, 23445, true);
                            break;
                    }
                }
                return;
            }
    }
}

void Spell::EffectApplyAura(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!m_spellAura || !unitTarget)
        return;
    ASSERT(unitTarget == m_spellAura->GetOwner());
    m_spellAura->_ApplyEffectForTargets(effIndex);
}

void Spell::EffectApplyAreaAura(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!m_spellAura || !unitTarget)
        return;
    ASSERT (unitTarget == m_spellAura->GetOwner());
    m_spellAura->_ApplyEffectForTargets(effIndex);
}

void Spell::EffectUnlearnSpecialization(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint32 spellToUnlearn = m_spellInfo->Effects[effIndex].TriggerSpell;

    player->removeSpell(spellToUnlearn, SPEC_MASK_ALL, false);
    LOG_DEBUG("spells.aura", "Spell: Player {} has unlearned spell {} from Npc: {}",
        player->GetGUID().ToString(), spellToUnlearn, m_caster->GetGUID().ToString());
}

void Spell::EffectPowerDrain(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_spellInfo->Effects[effIndex].MiscValue < 0 || m_spellInfo->Effects[effIndex].MiscValue >= int8(MAX_POWERS))
        return;

    Powers PowerType = Powers(m_spellInfo->Effects[effIndex].MiscValue);

    if (!unitTarget || !unitTarget->IsAlive() || !unitTarget->HasActivePowerType(PowerType) || damage < 0)
        return;

    // add spell damage bonus
    damage = m_caster->SpellDamageBonusDone(unitTarget, m_spellInfo, uint32(damage), SPELL_DIRECT_DAMAGE, effIndex);
    damage = unitTarget->SpellDamageBonusTaken(m_caster, m_spellInfo, uint32(damage), SPELL_DIRECT_DAMAGE);

    // resilience reduce mana draining effect at spell crit damage reduction (added in 2.4)
    int32 power = damage;
    if (PowerType == POWER_MANA)
        power -= unitTarget->GetSpellCritDamageReduction(power);

    //npcbot: handle Obsidian Destroyer's Drain Mana (target is friendly, amount is only limited by caster's max mana)
    if (m_caster->GetTypeId() == TYPEID_UNIT && m_caster->ToCreature()->GetBotClass() == 13 && PowerType == POWER_MANA)
        power = m_caster->GetMaxPower(PowerType);
    //end npcbot

    int32 newDamage = -(unitTarget->ModifyPower(PowerType, -int32(power)));

    float gainMultiplier = 0.0f;

    // Don`t restore from self drain
    if (m_caster != unitTarget)
    {
        gainMultiplier = m_spellInfo->Effects[effIndex].CalcValueMultiplier(m_originalCaster, this);

        int32 gain = int32(newDamage * gainMultiplier);

        m_caster->EnergizeBySpell(m_caster, m_spellInfo->Id, gain, PowerType);
    }
    ExecuteLogEffectTakeTargetPower(effIndex, unitTarget, PowerType, newDamage, gainMultiplier);
}

void Spell::EffectSendEvent(SpellEffIndex effIndex)
{
    // we do not handle a flag dropping or clicking on flag in battleground by sendevent system
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET
            && effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    WorldObject* target = nullptr;

    // call events for object target if present
    if (effectHandleMode == SPELL_EFFECT_HANDLE_HIT_TARGET)
    {
        if (unitTarget)
            target = unitTarget;
        else if (gameObjTarget)
            target = gameObjTarget;
    }
    else // if (effectHandleMode == SPELL_EFFECT_HANDLE_HIT)
    {
        // let's prevent executing effect handler twice in case when spell effect is capable of targeting an object
        // this check was requested by scripters, but it has some downsides:
        // now it's impossible to script (using sEventScripts) a cast which misses all targets
        // or to have an ability to script the moment spell hits dest (in a case when there are object targets present)
        if (m_spellInfo->Effects[effIndex].GetProvidedTargetMask() & (TARGET_FLAG_UNIT_MASK | TARGET_FLAG_GAMEOBJECT_MASK))
            return;
        // some spells have no target entries in dbc and they use focus target
        if (focusObject)
            target = focusObject;
        /// @todo: there should be a possibility to pass dest target to event script
    }

    LOG_DEBUG("spells.aura", "Spell ScriptStart {} for spellid {} in EffectSendEvent ", m_spellInfo->Effects[effIndex].MiscValue, m_spellInfo->Id);

    if (ZoneScript* zoneScript = m_caster->GetZoneScript())
        zoneScript->ProcessEvent(target, m_spellInfo->Effects[effIndex].MiscValue);
    else if (InstanceScript* instanceScript = m_caster->GetInstanceScript())    // needed in case Player is the caster
        instanceScript->ProcessEvent(target, m_spellInfo->Effects[effIndex].MiscValue);

    m_caster->GetMap()->ScriptsStart(sEventScripts, m_spellInfo->Effects[effIndex].MiscValue, m_caster, target);
}

void Spell::EffectPowerBurn(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_spellInfo->Effects[effIndex].MiscValue < 0 || m_spellInfo->Effects[effIndex].MiscValue >= int8(MAX_POWERS))
        return;

    Powers PowerType = Powers(m_spellInfo->Effects[effIndex].MiscValue);

    if (!unitTarget || !unitTarget->IsAlive() || !unitTarget->HasActivePowerType(PowerType) || damage < 0)
        return;

    // burn x% of target's mana, up to maximum of 2x% of caster's mana (Mana Burn)
    if (m_spellInfo->Id == 8129)
    {
        int32 maxDamage = int32(CalculatePct(m_caster->GetMaxPower(PowerType), damage * 2));
        damage = int32(CalculatePct(unitTarget->GetMaxPower(PowerType), damage));
        damage = std::min(damage, maxDamage);

        // Remove fear
        unitTarget->RemoveAurasByType(SPELL_AURA_MOD_FEAR);
    }

    int32 power = damage;
    // resilience reduce mana draining effect at spell crit damage reduction (added in 2.4)
    if (PowerType == POWER_MANA)
        power -= unitTarget->GetSpellCritDamageReduction(power);

    int32 newDamage = -(unitTarget->ModifyPower(PowerType, -power));

    // NO - Not a typo - EffectPowerBurn uses effect value multiplier - not effect damage multiplier
    float dmgMultiplier = m_spellInfo->Effects[effIndex].CalcValueMultiplier(m_originalCaster, this);

    // add log data before multiplication (need power amount, not damage)
    ExecuteLogEffectTakeTargetPower(effIndex, unitTarget, PowerType, newDamage, 0.0f);

    newDamage = int32(newDamage * dmgMultiplier);

    m_damage += newDamage;
}

void Spell::EffectHeal(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (unitTarget && unitTarget->IsAlive() && damage >= 0)
    {
        // Try to get original caster
        Unit* caster = m_originalCasterGUID ? m_originalCaster : m_caster;

        // Skip if m_originalCaster not available
        if (!caster)
            return;

        int32 addhealth = damage;

        // Vessel of the Naaru (Vial of the Sunwell trinket)
        if (m_spellInfo->Id == 45064)
        {
            // Amount of heal - depends from stacked Holy Energy
            int damageAmount = 0;
            if (AuraEffect const* aurEff = m_caster->GetAuraEffect(45062, 0))
            {
                damageAmount += aurEff->GetAmount();
                m_caster->RemoveAurasDueToSpell(45062);
            }

            addhealth += damageAmount;
        }
        // Swiftmend - consumes Regrowth or Rejuvenation
        else if (m_spellInfo->TargetAuraState == AURA_STATE_SWIFTMEND && unitTarget->HasAuraState(AURA_STATE_SWIFTMEND, m_spellInfo, m_caster))
        {
            Unit::AuraEffectList const& RejorRegr = unitTarget->GetAuraEffectsByType(SPELL_AURA_PERIODIC_HEAL);
            // find most short by duration
            AuraEffect* forcedTargetAura = nullptr;
            AuraEffect* targetAura = nullptr;
            for (Unit::AuraEffectList::const_iterator i = RejorRegr.begin(); i != RejorRegr.end(); ++i)
            {
                if ((*i)->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_DRUID
                        && (*i)->GetSpellInfo()->SpellFamilyFlags[0] & 0x50)
                {
                    if (m_caster->GetGUID() == (*i)->GetCasterGUID())
                    {
                        if (!forcedTargetAura || (*i)->GetBase()->GetDuration() < forcedTargetAura->GetBase()->GetDuration())
                            forcedTargetAura = *i;
                    }
                    else if (!targetAura || (*i)->GetBase()->GetDuration() < targetAura->GetBase()->GetDuration())
                        targetAura = *i;
                }
            }

            if (forcedTargetAura)
                targetAura = forcedTargetAura;

            if (!targetAura)
            {
                LOG_ERROR("spells.effect", "Target({}) has aurastate AURA_STATE_SWIFTMEND but no matching aura.", unitTarget->GetGUID().ToString());
                return;
            }

            int32 tickheal = targetAura->GetAmount();
            if (Unit* auraCaster = targetAura->GetCaster())
                tickheal = unitTarget->SpellHealingBonusTaken(auraCaster, targetAura->GetSpellInfo(), tickheal, DOT);

            //int32 tickheal = targetAura->GetSpellInfo()->EffectBasePoints[idx] + 1;
            //It is said that talent bonus should not be included

            int32 tickcount = 0;
            // Rejuvenation
            if (targetAura->GetSpellInfo()->SpellFamilyFlags[0] & 0x10)
                tickcount = 4;
            // Regrowth
            else // if (targetAura->GetSpellInfo()->SpellFamilyFlags[0] & 0x40)
                tickcount = 6;

            addhealth += tickheal * tickcount;

            // Glyph of Swiftmend
            if (!caster->HasAura(54824))
                unitTarget->RemoveAura(targetAura->GetId(), targetAura->GetCasterGUID());

            //addhealth += tickheal * tickcount;
            //addhealth = caster->SpellHealingBonus(m_spellInfo, addhealth, HEAL, unitTarget);
        }
        // Death Pact - return pct of max health to caster
        else if (m_spellInfo->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT && m_spellInfo->SpellFamilyFlags[0] & 0x00080000)
        {
            addhealth = caster->SpellHealingBonusDone(unitTarget, m_spellInfo, int32(caster->CountPctFromMaxHealth(damage)), HEAL, effIndex);
            addhealth = unitTarget->SpellHealingBonusTaken(caster, m_spellInfo, addhealth, HEAL);
        }
        else if (m_spellInfo->Id != 33778) // not lifebloom
        {
            addhealth = caster->SpellHealingBonusDone(unitTarget, m_spellInfo, addhealth, HEAL, effIndex);
            addhealth = unitTarget->SpellHealingBonusTaken(caster, m_spellInfo, addhealth, HEAL);
        }

        // Implemented this way as there is no other way to do it currently (that I know :P)...
        if (caster->ToPlayer() && caster->HasAura(23401)) // Nefarian Corrupted Healing (priest)
        {
            if (!m_spellInfo->HasAura(SPELL_AURA_PERIODIC_HEAL) && (m_spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_HOLY))
            {
                m_damage = 0;
                caster->CastSpell(unitTarget, 23402, false); // Nefarian Corrupted Healing Periodic Damage effect.
                return;
            }
        }

        m_damage -= addhealth;
    }
}

void Spell::EffectHealPct(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive() || damage < 0)
        return;

    // Skip if m_originalCaster not available
    if (!m_originalCaster)
        return;

    uint32 heal = m_originalCaster->SpellHealingBonusDone(unitTarget, m_spellInfo, unitTarget->CountPctFromMaxHealth(damage), HEAL, effIndex);
    heal = unitTarget->SpellHealingBonusTaken(m_originalCaster, m_spellInfo, heal, HEAL);

    m_damage -= heal;
}

void Spell::EffectHealMechanical(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive() || damage < 0)
        return;

    // Skip if m_originalCaster not available
    if (!m_originalCaster)
        return;

    uint32 heal = m_originalCaster->SpellHealingBonusDone(unitTarget, m_spellInfo, uint32(damage), HEAL, effIndex);

    m_damage -= unitTarget->SpellHealingBonusTaken(m_originalCaster, m_spellInfo, heal, HEAL);
}

void Spell::EffectHealthLeech(SpellEffIndex  effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive() || damage < 0)
        return;

    damage = m_caster->SpellDamageBonusDone(unitTarget, m_spellInfo, uint32(damage), SPELL_DIRECT_DAMAGE, effIndex);
    damage = unitTarget->SpellDamageBonusTaken(m_caster, m_spellInfo, uint32(damage), SPELL_DIRECT_DAMAGE);

    LOG_DEBUG("spells.aura", "HealthLeech :{}", damage);

    // xinef: handled in spell.cpp
    //float healMultiplier = m_spellInfo->Effects[effIndex].CalcValueMultiplier(m_originalCaster, this);

    m_damage += damage;
    // get max possible damage, don't count overkill for heal
    //uint32 healthGain = uint32(-unitTarget->GetHealthGain(-damage) * healMultiplier);

    //if (m_caster->IsAlive())
    //{
    //    healthGain = m_caster->SpellHealingBonusDone(m_caster, m_spellInfo, healthGain, HEAL);
    //    healthGain = m_caster->SpellHealingBonusTaken(m_caster, m_spellInfo, healthGain, HEAL);

    //    m_caster->HealBySpell(m_caster, m_spellInfo, uint32(healthGain));
    //}
}

void Spell::DoCreateItem(uint8 /*effIndex*/, uint32 itemId)
{
    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint32 newitemid = itemId;

    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(newitemid);
    if (!pProto)
    {
        player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, nullptr, nullptr);
        return;
    }

    uint32 addNumber = damage;

    // bg reward have some special in code work
    bool SelfCast = true;
    switch (m_spellInfo->Id)
    {
        case SPELL_AV_MARK_WINNER:
        case SPELL_AV_MARK_LOSER:
        case SPELL_WS_MARK_WINNER:
        case SPELL_WS_MARK_LOSER:
        case SPELL_WS_MARK_TIE:
        case SPELL_AB_MARK_WINNER:
        case SPELL_AB_MARK_LOSER:
            SelfCast = true;
            break;
        case SPELL_WG_MARK_WINNER:
            if (player->HasAura(55629 /*SPELL_LIEUTENANT*/))
                addNumber = 3;
            else if (player->HasAura(33280 /*SPELL_CORPORAL*/))
                addNumber = 2;
            else
                addNumber = 1;
            SelfCast = true;
            break;
    }

    if (addNumber < 1)
        addNumber = 1;
    if (addNumber > pProto->GetMaxStackSize())
        addNumber = pProto->GetMaxStackSize();

    /* == gem perfection handling == */

    // the chance of getting a perfect result
    float perfectCreateChance = 0.0f;

    // the resulting perfect item if successful
    uint32 perfectItemType = itemId;

    // get perfection capability and chance
    if (CanCreatePerfectItem(player, m_spellInfo->Id, perfectCreateChance, perfectItemType))
        if (roll_chance_f(perfectCreateChance)) // if the roll succeeds...
            newitemid = perfectItemType;        // the perfect item replaces the regular one

    /* == gem perfection handling over == */

    /* == profession specialization handling == */

    // init items_count to 1, since 1 item will be created regardless of specialization
    int32 itemsCount = 1;
    float additionalCreateChance = 0.0f;
    int32 additionalMaxNum = 0;
    // get the chance and maximum number for creating extra items
    if (canCreateExtraItems(player, m_spellInfo->Id, additionalCreateChance, additionalMaxNum))
    {
        // roll with this chance till we roll not to create or we create the max num
        while (roll_chance_f(additionalCreateChance) && itemsCount <= additionalMaxNum)
            ++itemsCount;
    }

    // really will be created more items
    addNumber *= itemsCount;

    /* == profession specialization handling over == */

    // can the player store the new item?
    ItemPosCountVec dest;
    uint32 no_space = 0;
    InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, newitemid, addNumber, &no_space);
    if (msg != EQUIP_ERR_OK)
    {
        // convert to possible store amount
        if (msg == EQUIP_ERR_INVENTORY_FULL || msg == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
            addNumber -= no_space;
        else
        {
            // if not created by another reason from full inventory or unique items amount limitation
            player->SendEquipError(msg, nullptr, nullptr, newitemid);
            return;
        }
    }

    if (addNumber)
    {
        // create the new item and store it
        Item* pItem = player->StoreNewItem(dest, newitemid, true);

        // was it successful? return error if not
        if (!pItem)
        {
            player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, nullptr, nullptr);
            return;
        }

        // set the "Crafted by ..." property of the item
        if (pItem->GetTemplate()->HasSignature())
            pItem->SetGuidValue(ITEM_FIELD_CREATOR, player->GetGUID());

        // send info to the client
        player->SendNewItem(pItem, addNumber, true, SelfCast);

        sScriptMgr->OnCreateItem(player, pItem, addNumber);

        // we succeeded in creating at least one item, so a levelup is possible
        if (SelfCast)
            player->UpdateCraftSkill(m_spellInfo->Id);
    }
}

void Spell::EffectCreateItem(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    DoCreateItem(effIndex, m_spellInfo->Effects[effIndex].ItemType);
    ExecuteLogEffectCreateItem(effIndex, m_spellInfo->Effects[effIndex].ItemType);
}

void Spell::EffectCreateItem2(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint32 itemId = m_spellInfo->Effects[effIndex].ItemType;

    if (itemId)
        DoCreateItem(effIndex, itemId);

    // special case: fake item replaced by generate using spell_loot_template
    if (m_spellInfo->IsLootCrafting())
    {
        if (itemId)
        {
            if (!player->HasItemCount(itemId))
                return;

            // remove reagent
            uint32 count = 1;
            player->DestroyItemCount(itemId, count, true);

            // create some random items
            player->AutoStoreLoot(m_spellInfo->Id, LootTemplates_Spell);
        }
        else
            player->AutoStoreLoot(m_spellInfo->Id, LootTemplates_Spell);    // create some random items
    }
    /// @todo: ExecuteLogEffectCreateItem(i, m_spellInfo->Effects[i].ItemType);
}

void Spell::EffectCreateRandomItem(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    // create some random items
    player->AutoStoreLoot(m_spellInfo->Id, LootTemplates_Spell);
    /// @todo: ExecuteLogEffectCreateItem(i, m_spellInfo->Effects[i].ItemType);
}

void Spell::EffectPersistentAA(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (!m_spellAura)
    {
        Unit* caster = m_caster->GetEntry() == WORLD_TRIGGER ? m_originalCaster : m_caster;
        float radius = m_spellInfo->Effects[effIndex].CalcRadius(caster);

        // Caster not in world, might be spell triggered from aura removal
        if (!caster->IsInWorld() || !caster->FindMap() || !ObjectAccessor::GetUnit(*caster, caster->GetGUID())) // pussywizard: temporary crash fix (FindMap and GetUnit are mine)
            return;
        DynamicObject* dynObj = new DynamicObject(false);
        if (!dynObj->CreateDynamicObject(caster->GetMap()->GenerateLowGuid<HighGuid::DynamicObject>(), caster, m_spellInfo->Id, *destTarget, radius, DYNAMIC_OBJECT_AREA_SPELL))
        {
            delete dynObj;
            return;
        }

        if (Aura* aura = Aura::TryCreate(m_spellInfo, MAX_EFFECT_MASK, dynObj, caster, &m_spellValue->EffectBasePoints[0]))
        {
            m_spellAura = aura;
            m_spellAura->SetTriggeredByAuraSpellInfo(m_triggeredByAuraSpell.spellInfo);
            m_spellAura->_RegisterForTargets();
        }
        else
            return;
    }

    ASSERT(m_spellAura->GetDynobjOwner());
    m_spellAura->_ApplyEffectForTargets(effIndex);
}

void Spell::EffectEnergize(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;
    if (!unitTarget->IsAlive())
        return;

    if (m_spellInfo->Effects[effIndex].MiscValue < 0 || m_spellInfo->Effects[effIndex].MiscValue >= int8(MAX_POWERS))
        return;

    Powers power = Powers(m_spellInfo->Effects[effIndex].MiscValue);

    if (unitTarget->GetTypeId() == TYPEID_PLAYER && !unitTarget->HasActivePowerType(power) && m_spellInfo->SpellFamilyName != SPELLFAMILY_POTION
            && !m_spellInfo->HasAttribute(SPELL_ATTR7_ONLY_IN_SPELLBOOK_UNTIL_LEARNED))
        return;

    if (unitTarget->GetMaxPower(power) == 0)
        return;

    // Some level depends spells
    int level_multiplier = 0;
    int level_diff = 0;
    switch (m_spellInfo->Id)
    {
        case 9512:                                          // Restore Energy
            level_diff = m_caster->GetLevel() - 40;
            level_multiplier = 2;
            break;
        case 24571:                                         // Blood Fury
            level_diff = m_caster->GetLevel() - 60;
            level_multiplier = 10;
            break;
        case 24532:                                         // Burst of Energy
            level_diff = m_caster->GetLevel() - 60;
            level_multiplier = 4;
            break;
        case 31930:                                         // Judgements of the Wise
        case 63375:                                         // Improved Stormstrike
        case 68082:                                         // Glyph of Seal of Command
            damage = int32(CalculatePct(unitTarget->GetCreateMana(), damage));
            break;
        case 48542:                                         // Revitalize
            damage = int32(CalculatePct(unitTarget->GetMaxPower(power), damage));
            break;
        case 71132:                                         // Glyph of Shadow Word: Pain
            damage = int32(CalculatePct(unitTarget->GetCreateMana(), 1));  // set 1 as value, missing in dbc
            break;
        default:
            break;
    }

    if (level_diff > 0)
        damage -= level_multiplier * level_diff;

    if (damage < 0)
        return;

    m_caster->EnergizeBySpell(unitTarget, m_spellInfo->Id, damage, power);

    // Mad Alchemist's Potion
    if (m_spellInfo->Id == 45051)
    {
        // find elixirs on target
        bool guardianFound = false;
        bool battleFound = false;
        Unit::AuraApplicationMap& Auras = unitTarget->GetAppliedAuras();
        for (Unit::AuraApplicationMap::iterator itr = Auras.begin(); itr != Auras.end(); ++itr)
        {
            SpellGroupSpecialFlags sFlag = sSpellMgr->GetSpellGroupSpecialFlags(itr->second->GetBase()->GetId());
            if (!guardianFound)
                if (sFlag & SPELL_GROUP_SPECIAL_FLAG_ELIXIR_GUARDIAN)
                    guardianFound = true;
            if (!battleFound)
                if (sFlag & SPELL_GROUP_SPECIAL_FLAG_ELIXIR_BATTLE)
                    battleFound = true;
            if (battleFound && guardianFound)
                break;
        }

        // get all available elixirs by mask and spell level
        std::set<uint32> availableElixirs;
        if (!guardianFound)
            sSpellMgr->GetSetOfSpellsInSpellGroupWithFlag(1, SPELL_GROUP_SPECIAL_FLAG_ELIXIR_GUARDIAN, availableElixirs);
        if (!battleFound)
            sSpellMgr->GetSetOfSpellsInSpellGroupWithFlag(1, SPELL_GROUP_SPECIAL_FLAG_ELIXIR_BATTLE, availableElixirs);
        for (std::set<uint32>::iterator itr = availableElixirs.begin(); itr != availableElixirs.end();)
        {
            SpellInfo const* spellInfo = sSpellMgr->AssertSpellInfo(*itr);
            if (spellInfo->SpellLevel < m_spellInfo->SpellLevel || spellInfo->SpellLevel > unitTarget->GetLevel())
                availableElixirs.erase(itr++);
            else
                ++itr;
        }

        if (!availableElixirs.empty())
        {
            // cast random elixir on target
            m_caster->CastSpell(unitTarget, Acore::Containers::SelectRandomContainerElement(availableElixirs), true, m_CastItem);
        }
    }
}

void Spell::EffectEnergizePct(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;
    if (!unitTarget->IsAlive())
        return;

    if (m_spellInfo->Effects[effIndex].MiscValue < 0 || m_spellInfo->Effects[effIndex].MiscValue >= int8(MAX_POWERS))
        return;

    Powers power = Powers(m_spellInfo->Effects[effIndex].MiscValue);

    if (unitTarget->GetTypeId() == TYPEID_PLAYER && !unitTarget->HasActivePowerType(power) && !m_spellInfo->HasAttribute(SPELL_ATTR7_ONLY_IN_SPELLBOOK_UNTIL_LEARNED))
        return;

    uint32 maxPower = unitTarget->GetMaxPower(power);
    if (maxPower == 0)
        return;

    uint32 gain = CalculatePct(maxPower, damage);
    m_caster->EnergizeBySpell(unitTarget, m_spellInfo->Id, gain, power);
}

void Spell::SendLoot(ObjectGuid guid, LootType loottype)
{
    Player* player = m_caster->ToPlayer();
    if (!player)
        return;

    if (gameObjTarget)
    {
        // Players shouldn't be able to loot gameobjects that are currently despawned
        if (!gameObjTarget->isSpawned() && !player->IsGameMaster())
        {
            LOG_ERROR("spells.effect", "Possible hacking attempt: Player {} [{}] tried to loot a gameobject [{}] which is on respawn time without being in GM mode!",
                player->GetName(), player->GetGUID().ToString(), gameObjTarget->GetGUID().ToString());
            return;
        }
        // special case, already has GossipHello inside so return and avoid calling twice
        if (gameObjTarget->GetGoType() == GAMEOBJECT_TYPE_GOOBER)
        {
            gameObjTarget->Use(m_caster);
            return;
        }

        if (sScriptMgr->OnGossipHello(player, gameObjTarget))
            return;

        if (gameObjTarget->AI()->GossipHello(player, false))
            return;

        switch (gameObjTarget->GetGoType())
        {
            case GAMEOBJECT_TYPE_DOOR:
                gameObjTarget->UseDoorOrButton(0, false, player);
                return;
            case GAMEOBJECT_TYPE_BUTTON:
                gameObjTarget->UseDoorOrButton(0, false, player);

                // Xinef: properly link possible traps
                if (uint32 trapEntry = gameObjTarget->GetGOInfo()->button.linkedTrap)
                    gameObjTarget->TriggeringLinkedGameObject(trapEntry, player);
                return;
            case GAMEOBJECT_TYPE_QUESTGIVER:
                player->PrepareGossipMenu(gameObjTarget, gameObjTarget->GetGOInfo()->questgiver.gossipID, true);
                player->SendPreparedGossip(gameObjTarget);
                return;

            case GAMEOBJECT_TYPE_SPELL_FOCUS:
                // triggering linked GO
                if (uint32 trapEntry = gameObjTarget->GetGOInfo()->spellFocus.linkedTrapId)
                    gameObjTarget->TriggeringLinkedGameObject(trapEntry, m_caster);
                return;

            case GAMEOBJECT_TYPE_CHEST:
                // triggering linked GO
                if (uint32 trapEntry = gameObjTarget->GetGOInfo()->chest.linkedTrapId)
                    gameObjTarget->TriggeringLinkedGameObject(trapEntry, m_caster);

            // Don't return, let loots been taken
            default:
                break;
        }
    }

    // Send loot
    player->SendLoot(guid, loottype);
}

void Spell::EffectOpenLock(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    //npcbot
    if (m_caster->IsNPCBot() && gameObjTarget)
    {
        GameObjectTemplate const* botGoInfo = gameObjTarget->GetGOInfo();
        Creature* bot = m_caster->ToCreature();

        // Arathi Basin banner opening. /// @todo Verify correctness of this check
        if ((botGoInfo->type == GAMEOBJECT_TYPE_BUTTON && botGoInfo->button.noDamageImmune) ||
            (botGoInfo->type == GAMEOBJECT_TYPE_GOOBER && botGoInfo->goober.losOK))
        {
            //CanUseBattlegroundObject() already called in CheckCast()
            // in battleground check
            if (Battleground* bg = bot->GetBotBG())
            {
                bg->EventBotClickedOnFlag(bot, gameObjTarget);
                return;
            }
        }
        else if (botGoInfo->type == GAMEOBJECT_TYPE_FLAGSTAND)
        {
            //CanUseBattlegroundObject() already called in CheckCast()
            // in battleground check
            if (Battleground* bg = bot->GetBotBG())
            {
                if (bg->GetBgTypeID(true) == BATTLEGROUND_EY)
                    bg->EventBotClickedOnFlag(bot, gameObjTarget);
                return;
            }
        }
        else if (botGoInfo->type == GAMEOBJECT_TYPE_TRAP)
        {
            gameObjTarget->SetLootState(GO_ACTIVATED);
            return;
        }

        return;
    }
    //end npcbot

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
    {
        LOG_DEBUG("spells.aura", "WORLD: Open Lock - No Player Caster!");
        return;
    }

    Player* player = m_caster->ToPlayer();

    uint32 lockId = 0;
    ObjectGuid guid;

    // Get lockId
    if (gameObjTarget)
    {
        GameObjectTemplate const* goInfo = gameObjTarget->GetGOInfo();
        // Arathi Basin banner opening. /// @todo: Verify correctness of this check
        if ((goInfo->type == GAMEOBJECT_TYPE_BUTTON && goInfo->button.noDamageImmune) ||
                (goInfo->type == GAMEOBJECT_TYPE_GOOBER && goInfo->goober.losOK))
        {
            //CanUseBattlegroundObject() already called in CheckCast()
            // in battleground check
            if (Battleground* bg = player->GetBattleground())
            {
                bg->EventPlayerClickedOnFlag(player, gameObjTarget);
                return;
            }
        }
        else if (goInfo->type == GAMEOBJECT_TYPE_FLAGSTAND)
        {
            //CanUseBattlegroundObject() already called in CheckCast()
            // in battleground check
            if (Battleground* bg = player->GetBattleground())
            {
                if (bg->GetBgTypeID(true) == BATTLEGROUND_EY)
                    bg->EventPlayerClickedOnFlag(player, gameObjTarget);
                return;
            }
        }
        else if (m_spellInfo->Id == 1842 && gameObjTarget->GetGOInfo()->type == GAMEOBJECT_TYPE_TRAP)
        {
            gameObjTarget->SetLootState(GO_JUST_DEACTIVATED);
            if (gameObjTarget->getLootState() == GO_JUST_DEACTIVATED && !gameObjTarget->GetOwner()) // pussywizard
            {
                gameObjTarget->SetRespawnTime(gameObjTarget->GetGOInfo()->GetAutoCloseTime() / IN_MILLISECONDS/*xinef*/);
            }
            return;
        }
        /// @todo: Add script for spell 41920 - Filling, becouse server it freze when use this spell
        // handle outdoor pvp object opening, return true if go was registered for handling
        // these objects must have been spawned by outdoorpvp!
        else if (gameObjTarget->GetGOInfo()->type == GAMEOBJECT_TYPE_GOOBER && sOutdoorPvPMgr->HandleOpenGo(player, gameObjTarget))
            return;
        lockId = goInfo->GetLockId();
        guid = gameObjTarget->GetGUID();
    }
    else if (itemTarget)
    {
        lockId = itemTarget->GetTemplate()->LockID;
        guid = itemTarget->GetGUID();
    }
    else
    {
        LOG_DEBUG("spells.aura", "WORLD: Open Lock - No GameObject/Item Target!");
        return;
    }

    SkillType skillId = SKILL_NONE;
    int32 reqSkillValue = 0;
    int32 skillValue;

    SpellCastResult res = CanOpenLock(effIndex, lockId, skillId, reqSkillValue, skillValue);
    if (res != SPELL_CAST_OK)
    {
        SendCastResult(res);
        return;
    }

    if (gameObjTarget)
        SendLoot(guid, LOOT_SKINNING);
    else if (itemTarget)
    {
        itemTarget->SetFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_UNLOCKED);
        if (Player* itemOwner = itemTarget->GetOwner())
            itemTarget->SetState(ITEM_CHANGED, itemOwner);
    }

    // not allow use skill grow at item base open
    if (!m_CastItem && skillId != SKILL_NONE)
    {
        // update skill if really known
        if (uint32 pureSkillValue = player->GetPureSkillValue(skillId))
        {
            if (gameObjTarget)
            {
                // Allow one skill-up until respawned
                if (!gameObjTarget->IsInSkillupList(player->GetGUID()))
                {
                    gameObjTarget->AddToSkillupList(player->GetGUID());
                    player->UpdateGatherSkill(skillId, pureSkillValue, reqSkillValue);
                }

            }
            else if (itemTarget)
            {
                // Do one skill-up
                player->UpdateGatherSkill(skillId, pureSkillValue, reqSkillValue);
            }
        }
    }
    ExecuteLogEffectOpenLock(effIndex, gameObjTarget ? (Object*)gameObjTarget : (Object*)itemTarget);
}

void Spell::EffectSummonChangeItem(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* player = m_caster->ToPlayer();

    // applied only to using item
    if (!m_CastItem)
        return;

    // ... only to item in own inventory/bank/equip_slot
    if (m_CastItem->GetOwnerGUID() != player->GetGUID())
        return;

    uint32 newitemid = m_spellInfo->Effects[effIndex].ItemType;
    if (!newitemid)
        return;

    uint16 pos = m_CastItem->GetPos();

    Item* pNewItem = Item::CreateItem(newitemid, 1, player);
    if (!pNewItem)
        return;

    // Client-side enchantment durations update
    player->UpdateEnchantmentDurations();

    for (uint8 j = PERM_ENCHANTMENT_SLOT; j <= TEMP_ENCHANTMENT_SLOT; ++j)
        if (m_CastItem->GetEnchantmentId(EnchantmentSlot(j)))
            pNewItem->SetEnchantment(EnchantmentSlot(j), m_CastItem->GetEnchantmentId(EnchantmentSlot(j)), m_CastItem->GetEnchantmentDuration(EnchantmentSlot(j)), m_CastItem->GetEnchantmentCharges(EnchantmentSlot(j)));

    if (m_CastItem->GetUInt32Value(ITEM_FIELD_DURABILITY) < m_CastItem->GetUInt32Value(ITEM_FIELD_MAXDURABILITY))
    {
        double lossPercent = 1 - m_CastItem->GetUInt32Value(ITEM_FIELD_DURABILITY) / double(m_CastItem->GetUInt32Value(ITEM_FIELD_MAXDURABILITY));
        player->DurabilityLoss(pNewItem, lossPercent);
    }

    if (player->IsInventoryPos(pos))
    {
        ItemPosCountVec dest;
        InventoryResult msg = player->CanStoreItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(), dest, pNewItem, true);
        if (msg == EQUIP_ERR_OK)
        {
            player->DestroyItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(), true);

            // prevent crash at access and unexpected charges counting with item update queue corrupt
            if (m_CastItem == m_targets.GetItemTarget())
                m_targets.SetItemTarget(nullptr);

            m_CastItem = nullptr;
            m_castItemGUID.Clear();

            player->StoreItem(dest, pNewItem, true);
            player->ItemAddedQuestCheck(pNewItem->GetEntry(), 1);
            return;
        }
    }
    else if (player->IsBankPos(pos))
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanBankItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(), dest, pNewItem, true);
        if (msg == EQUIP_ERR_OK)
        {
            player->DestroyItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(), true);

            // prevent crash at access and unexpected charges counting with item update queue corrupt
            if (m_CastItem == m_targets.GetItemTarget())
                m_targets.SetItemTarget(nullptr);

            m_CastItem = nullptr;
            m_castItemGUID.Clear();

            player->BankItem(dest, pNewItem, true);
            return;
        }
    }
    else if (player->IsEquipmentPos(pos))
    {
        uint16 dest;

        player->DestroyItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(), true);

        uint8 msg = player->CanEquipItem(m_CastItem->GetSlot(), dest, pNewItem, true);

        if (msg == EQUIP_ERR_OK || msg == EQUIP_ERR_CANT_DO_RIGHT_NOW)
        {
            if (msg == EQUIP_ERR_CANT_DO_RIGHT_NOW) dest = EQUIPMENT_SLOT_MAINHAND;

            // prevent crash at access and unexpected charges counting with item update queue corrupt
            if (m_CastItem == m_targets.GetItemTarget())
                m_targets.SetItemTarget(nullptr);

            m_CastItem = nullptr;
            m_castItemGUID.Clear();

            player->EquipItem(dest, pNewItem, true);
            player->AutoUnequipOffhandIfNeed();
            return;
        }
    }

    // fail
    delete pNewItem;
}

void Spell::EffectProficiency(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;
    Player* p_target = m_caster->ToPlayer();

    uint32 subClassMask = m_spellInfo->EquippedItemSubClassMask;
    if (m_spellInfo->EquippedItemClass == ITEM_CLASS_WEAPON && !(p_target->GetWeaponProficiency() & subClassMask))
    {
        p_target->AddWeaponProficiency(subClassMask);
        p_target->SendProficiency(ITEM_CLASS_WEAPON, p_target->GetWeaponProficiency());
    }
    if (m_spellInfo->EquippedItemClass == ITEM_CLASS_ARMOR && !(p_target->GetArmorProficiency() & subClassMask))
    {
        p_target->AddArmorProficiency(subClassMask);
        p_target->SendProficiency(ITEM_CLASS_ARMOR, p_target->GetArmorProficiency());
    }
}

void Spell::EffectSummonType(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    uint32 entry = m_spellInfo->Effects[effIndex].MiscValue;
    if (!entry)
        return;

    SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(m_spellInfo->Effects[effIndex].MiscValueB);
    if (!properties)
    {
        LOG_ERROR("spells.effect", "EffectSummonType: Unhandled summon type {}", m_spellInfo->Effects[effIndex].MiscValueB);
        return;
    }

    if (!m_originalCaster)
        return;

    bool personalSpawn = (properties->Flags & SUMMON_PROP_FLAG_ONLY_VISIBLE_TO_SUMMONER) != 0;
    int32 duration = m_spellInfo->GetDuration();
    if (Player* modOwner = m_originalCaster->GetSpellModOwner())
        modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_DURATION, duration);

    TempSummon* summon = nullptr;

    // determine how many units should be summoned
    uint32 numSummons;

    // some spells need to summon many units, for those spells number of summons is stored in effect value
    // however so far noone found a generic check to find all of those (there's no related data in summonproperties.dbc
    // and in spell attributes, possibly we need to add a table for those)
    // so here's a list of MiscValueB values, which is currently most generic check
    switch (properties->Id)
    {
        case 64:
        case 61:
        case 1101:
        case 66:
        case 648:
        case 2301:
        case 1061:
        case 1261:
        case 629:
        case 181:
        case 715:
        case 1562:
        case 833:
        case 1161:
        case 713: // xinef, bloodworms
            numSummons = (damage > 0) ? damage : 1;
            break;
        default:
            numSummons = 1;
            break;
    }

    switch (properties->Category)
    {
        case SUMMON_CATEGORY_WILD:
        case SUMMON_CATEGORY_ALLY:
        case SUMMON_CATEGORY_UNK:
            if (properties->Flags & 512)
            {
                SummonGuardian(effIndex, entry, properties, numSummons, personalSpawn);
                break;
            }
            switch (properties->Type)
            {
                case SUMMON_TYPE_PET:
                case SUMMON_TYPE_GUARDIAN:
                case SUMMON_TYPE_GUARDIAN2:
                case SUMMON_TYPE_MINION:
                    SummonGuardian(effIndex, entry, properties, numSummons, personalSpawn);
                    break;
                // Summons a vehicle, but doesn't force anyone to enter it (see SUMMON_CATEGORY_VEHICLE)
                case SUMMON_TYPE_VEHICLE:
                case SUMMON_TYPE_VEHICLE2:
                    summon = m_caster->GetMap()->SummonCreature(entry, *destTarget, properties, duration, m_originalCaster, m_spellInfo->Id, 0, personalSpawn);
                    break;
                case SUMMON_TYPE_LIGHTWELL:
                case SUMMON_TYPE_TOTEM:
                    {
                        // protection code
                        summon = m_caster->GetMap()->SummonCreature(entry, *destTarget, properties, duration, m_originalCaster, m_spellInfo->Id, 0, personalSpawn);
                        if (!summon || !summon->IsTotem())
                            return;

                        // Mana Tide Totem
                        if (m_spellInfo->Id == 16190)
                            damage = m_caster->CountPctFromMaxHealth(10);

                        if (damage && properties->Type != SUMMON_TYPE_LIGHTWELL) // Health set in script for lightwell
                        {
                            summon->SetMaxHealth(damage);
                            summon->SetHealth(damage);
                        }
                        break;
                    }
                case SUMMON_TYPE_JEEVES:
                case SUMMON_TYPE_MINIPET:
                    {
                        summon = m_caster->GetMap()->SummonCreature(entry, *destTarget, properties, duration, m_originalCaster, m_spellInfo->Id, 0, personalSpawn);
                        if (!summon || !summon->HasUnitTypeMask(UNIT_MASK_MINION))
                            return;

                        summon->SelectLevel();       // some summoned creaters have different from 1 DB data for level/hp
                        summon->ReplaceAllNpcFlags(NPCFlags(summon->GetCreatureTemplate()->npcflag));

                        summon->SetImmuneToAll(true);
                        summon->SetReactState(REACT_PASSIVE);

                        // Xinef: Pet can have some auras in creature_addon or in scripts, do not remove them instantly
                        //summon->AI()->EnterEvadeMode();
                        if (properties->Type != SUMMON_TYPE_JEEVES)
                        {
                            summon->GetMotionMaster()->Clear(false);
                            summon->GetMotionMaster()->MoveFollow(m_originalCaster, PET_FOLLOW_DIST, summon->GetFollowAngle(), MOTION_SLOT_ACTIVE);
                        }
                        break;
                    }
                default:
                    {
                        float radius = m_spellInfo->Effects[effIndex].CalcRadius();

                        TempSummonType summonType = (duration <= 0) ? TEMPSUMMON_DEAD_DESPAWN : TEMPSUMMON_TIMED_DESPAWN;

                        for (uint32 count = 0; count < numSummons; ++count)
                        {
                            Position pos;
                            if (count == 0)
                                pos = *destTarget;
                            else
                                // randomize position for multiple summons
                                pos = m_caster->GetRandomPoint(*destTarget, radius);

                            summon = m_originalCaster->SummonCreature(entry, pos, summonType, duration, 0, nullptr, personalSpawn);
                            if (!summon)
                                continue;

                            summon->SetTempSummonType(summonType);

                            if (properties->Category == SUMMON_CATEGORY_ALLY)
                            {
                                summon->SetOwnerGUID(m_originalCaster->GetGUID());
                                summon->SetFaction(m_originalCaster->GetFaction());
                            }

                            ExecuteLogEffectSummonObject(effIndex, summon);
                        }
                        return;
                    }
            }//switch
            break;
        case SUMMON_CATEGORY_PET:
            // Xinef: SummonGuardian function can summon a few npcs of same type, remove old summons with same entry here
            if (m_originalCaster)
                m_originalCaster->RemoveAllMinionsByEntry(entry);
            SummonGuardian(effIndex, entry, properties, numSummons, personalSpawn);
            break;
        case SUMMON_CATEGORY_PUPPET:
            summon = m_caster->GetMap()->SummonCreature(entry, *destTarget, properties, duration, m_originalCaster, m_spellInfo->Id, 0, personalSpawn);
            break;
        case SUMMON_CATEGORY_VEHICLE:
            // Summoning spells (usually triggered by npc_spellclick) that spawn a vehicle and that cause the clicker
            // to cast a ride vehicle spell on the summoned unit.
            //float x, y, z;
            //m_caster->GetClosePoint(x, y, z, DEFAULT_WORLD_OBJECT_SIZE);
            // xinef: vehicles summoned in air, eg. Cold Hearted quest
            if (std::fabs(m_caster->GetPositionZ() - destTarget->GetPositionZ()) > 6.0f)
                destTarget->m_positionZ = m_caster->GetPositionZ();

            summon = m_originalCaster->GetMap()->SummonCreature(entry, *destTarget, properties, duration, m_caster, m_spellInfo->Id, 0, personalSpawn);
            if (!summon || !summon->IsVehicle())
                return;

            // The spell that this effect will trigger. It has SPELL_AURA_CONTROL_VEHICLE
            uint32 spellId = VEHICLE_SPELL_RIDE_HARDCODED;
            int32 basePoints = m_spellInfo->Effects[effIndex].CalcValue();
            if (basePoints > 1) // xinef: some summoning spells have value 1 - indicates vehicle seat
            {
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(basePoints);
                if (spellInfo && spellInfo->HasAura(SPELL_AURA_CONTROL_VEHICLE))
                    spellId = spellInfo->Id;
            }

            // xinef: if we have small value, it indicates seat position
            if (basePoints > 0 && basePoints < MAX_VEHICLE_SEATS)
                m_originalCaster->CastCustomSpell(spellId, SPELLVALUE_BASE_POINT0, basePoints, summon, true);
            else
                m_originalCaster->CastSpell(summon, spellId, true);

            // xinef: i think this is wrong, found only 2 vehicles with faction override and one of them should inherit caster faction...
            //uint32 faction = properties->Faction;
            //if (!faction)
            uint32 faction = m_originalCaster->GetFaction();

            summon->SetFaction(faction);
            break;
    }

    if (summon)
    {
        summon->SetCreatorGUID(m_originalCaster->GetGUID());
        ExecuteLogEffectSummonObject(effIndex, summon);
    }
}

void Spell::EffectLearnSpell(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
    {
        if (unitTarget->ToPet())
            EffectLearnPetSpell(effIndex);
        return;
    }

    Player* player = unitTarget->ToPlayer();

    uint32 spellToLearn = (m_spellInfo->Id == 483 || m_spellInfo->Id == 55884) ? damage : m_spellInfo->Effects[effIndex].TriggerSpell;
    player->learnSpell(spellToLearn);

    LOG_DEBUG("spells.aura", "Spell: Player {} has learned spell {} from Npc {}",
        player->GetGUID().ToString(), spellToLearn, m_caster->GetGUID().ToString());
}

typedef std::list<std::pair<uint32, ObjectGuid>> DispelList;
void Spell::EffectDispel(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    // Create dispel mask by dispel type
    uint32 dispel_type = m_spellInfo->Effects[effIndex].MiscValue;
    uint32 dispelMask  = SpellInfo::GetDispelMask(DispelType(dispel_type));

    DispelChargesList dispel_list;
    unitTarget->GetDispellableAuraList(m_caster, dispelMask, dispel_list, m_spellInfo);
    if (dispel_list.empty())
        return;

    // Ok if exist some buffs for dispel try dispel it
    uint32 failCount = 0;
    DispelChargesList success_list;
    WorldPacket dataFail(SMSG_DISPEL_FAILED, 8 + 8 + 4 + 4 + damage * 4);
    // dispel N = damage buffs (or while exist buffs for dispel)
    for (int32 count = 0; count < damage && !dispel_list.empty();)
    {
        // Random select buff for dispel
        DispelChargesList::iterator itr = dispel_list.begin();
        std::advance(itr, urand(0, dispel_list.size() - 1));

        int32 chance = itr->first->CalcDispelChance(unitTarget, !unitTarget->IsFriendlyTo(m_caster));
        // 2.4.3 Patch Notes: "Dispel effects will no longer attempt to remove effects that have 100% dispel resistance."
        if (!chance)
        {
            dispel_list.erase(itr);
            continue;
        }
        else
        {
            if (roll_chance_i(chance))
            {
                bool alreadyListed = false;
                for (DispelChargesList::iterator successItr = success_list.begin(); successItr != success_list.end(); ++successItr)
                {
                    if (successItr->first->GetId() == itr->first->GetId())
                    {
                        ++successItr->second;
                        alreadyListed = true;
                    }
                }
                if (!alreadyListed)
                    success_list.push_back(std::make_pair(itr->first, 1));
                --itr->second;
                if (itr->second <= 0)
                    dispel_list.erase(itr);
            }
            else
            {
                if (!failCount)
                {
                    // Failed to dispell
                    dataFail << m_caster->GetGUID();                    // Caster GUID
                    dataFail << unitTarget->GetGUID();                  // Victim GUID
                    dataFail << uint32(m_spellInfo->Id);                // dispel spell id
                }
                ++failCount;
                dataFail << uint32(itr->first->GetId());                // Spell Id
            }
            ++count;
        }
    }

    if (failCount)
        m_caster->SendMessageToSet(&dataFail, true);

    // put in combat
    if (unitTarget->IsFriendlyTo(m_caster))
        unitTarget->getHostileRefMgr().threatAssist(m_caster, 0.0f, m_spellInfo);

    if (success_list.empty())
        return;

    WorldPacket dataSuccess(SMSG_SPELLDISPELLOG, 8 + 8 + 4 + 1 + 4 + success_list.size() * 5);
    // Send packet header
    dataSuccess << unitTarget->GetPackGUID();               // Victim GUID
    dataSuccess << m_caster->GetPackGUID();                 // Caster GUID
    dataSuccess << uint32(m_spellInfo->Id);                // dispel spell id
    dataSuccess << uint8(0);                               // not used
    dataSuccess << uint32(success_list.size());            // count
    for (DispelChargesList::iterator itr = success_list.begin(); itr != success_list.end(); ++itr)
    {
        // Send dispelled spell info
        dataSuccess << uint32(itr->first->GetId());              // Spell Id
        dataSuccess << uint8(0);                        // 0 - dispelled !=0 cleansed
        unitTarget->RemoveAurasDueToSpellByDispel(itr->first->GetId(), m_spellInfo->Id, itr->first->GetCasterGUID(), m_caster, itr->second);
    }
    m_caster->SendMessageToSet(&dataSuccess, true);

    // On success dispel
    // Devour Magic
    if (m_spellInfo->SpellFamilyName == SPELLFAMILY_WARLOCK && m_spellInfo->GetCategory() == SPELLCATEGORY_DEVOUR_MAGIC)
    {
        int32 heal_amount = m_spellInfo->Effects[EFFECT_1].CalcValue();
        m_caster->CastCustomSpell(m_caster, 19658, &heal_amount, nullptr, nullptr, true);
        // Glyph of Felhunter
        if (Unit* owner = m_caster->GetOwner())
            if (owner->GetAura(56249))
                owner->CastCustomSpell(owner, 19658, &heal_amount, nullptr, nullptr, true);
    }
}

void Spell::EffectDualWield(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    unitTarget->SetCanDualWield(true);
}

void Spell::EffectPull(SpellEffIndex effIndex)
{
    /// @todo: create a proper pull towards distract spell center for distract
    EffectNULL(effIndex);
}

void Spell::EffectDistract(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    // Check for possible target
    if (!unitTarget || unitTarget->IsEngaged())
        return;

    // target must be OK to do this
    if (unitTarget->HasUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_STUNNED | UNIT_STATE_FLEEING))
        return;

    unitTarget->SetFacingTo(unitTarget->GetAngle(destTarget)); /// @BUG Causes the player to stop moving + interrupts spellcast.
    unitTarget->GetMotionMaster()->MoveDistract(damage * IN_MILLISECONDS);
}

void Spell::EffectPickPocket(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    m_caster->ToPlayer()->SendLoot(unitTarget->GetGUID(), LOOT_PICKPOCKETING);
}

void Spell::EffectAddFarsight(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    float radius = m_spellInfo->Effects[effIndex].CalcRadius();
    int32 duration = m_spellInfo->GetDuration();
    // Caster not in world, might be spell triggered from aura removal
    if (!m_caster->IsInWorld())
        return;

    // Remove old farsight if exist
    bool updateViewerVisibility = m_caster->RemoveDynObject(m_spellInfo->Id);

    DynamicObject* dynObj = new DynamicObject(true);
    if (!dynObj->CreateDynamicObject(m_caster->GetMap()->GenerateLowGuid<HighGuid::DynamicObject>(), m_caster, m_spellInfo->Id, *destTarget, radius, DYNAMIC_OBJECT_FARSIGHT_FOCUS))
    {
        delete dynObj;
        return;
    }

    dynObj->SetDuration(duration);
    dynObj->SetCasterViewpoint(updateViewerVisibility);
}

void Spell::EffectUntrainTalents(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || m_caster->GetTypeId() == TYPEID_PLAYER)
        return;

    if (ObjectGuid guid = m_caster->GetGUID()) // the trainer is the caster
        unitTarget->ToPlayer()->SendTalentWipeConfirm(guid);
}

void Spell::EffectTeleUnitsFaceCaster(SpellEffIndex  /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || unitTarget->IsInFlight())
        return;

    if (m_targets.HasDst())
    {
        unitTarget->NearTeleportTo(destTarget->GetPositionX(), destTarget->GetPositionY(), destTarget->GetPositionZ(), destTarget->GetAbsoluteAngle(m_caster), unitTarget == m_caster);
    }
}

void Spell::EffectLearnSkill(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    if (damage < 0)
        return;

    uint32 skillid = m_spellInfo->Effects[effIndex].MiscValue;
    uint16 skillval = unitTarget->ToPlayer()->GetPureSkillValue(skillid);
    unitTarget->ToPlayer()->SetSkill(skillid, m_spellInfo->Effects[effIndex].CalcValue(), skillval ? skillval : 1, damage * 75);
}

void Spell::EffectAddHonor(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    // not scale value for item based reward (/10 value expected)
    if (m_CastItem)
    {
        unitTarget->ToPlayer()->RewardHonor(nullptr, 1, damage / 10, false);
        LOG_DEBUG("spells.aura", "SpellEffect::AddHonor (spell_id {}) rewards {} honor points (item {}) for player: {}",
            m_spellInfo->Id, damage / 10, m_CastItem->GetEntry(), unitTarget->ToPlayer()->GetGUID().ToString());
        return;
    }

    // do not allow to add too many honor for player (50 * 21) = 1040 at level 70, or (50 * 31) = 1550 at level 80
    if (damage <= 50)
    {
        uint32 honor_reward = Acore::Honor::hk_honor_at_level(unitTarget->GetLevel(), float(damage));
        unitTarget->ToPlayer()->RewardHonor(nullptr, 1, honor_reward, false);
        LOG_DEBUG("spells.aura", "SpellEffect::AddHonor (spell_id {}) rewards {} honor points (scale) to player: {}",
            m_spellInfo->Id, honor_reward, unitTarget->ToPlayer()->GetGUID().ToString());
    }
    else
    {
        //maybe we have correct honor_gain in damage already
        unitTarget->ToPlayer()->RewardHonor(nullptr, 1, damage, false);
        LOG_DEBUG("spells.aura", "SpellEffect::AddHonor (spell_id {}) rewards {} honor points (non scale) for player: {}",
            m_spellInfo->Id, damage, unitTarget->ToPlayer()->GetGUID().ToString());
    }
}

void Spell::EffectTradeSkill(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;
    // uint32 skillid =  m_spellInfo->Effects[i].MiscValue;
    // uint16 skillmax = unitTarget->ToPlayer()->(skillid);
    // m_caster->ToPlayer()->SetSkill(skillid, skillval?skillval:1, skillmax+75);
}

void Spell::EffectEnchantItemPerm(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;
    if (!itemTarget)
        return;

    Player* p_caster = m_caster->ToPlayer();

    // Handle vellums
    if (itemTarget->IsWeaponVellum() || itemTarget->IsArmorVellum())
    {
        // destroy one vellum from stack
        uint32 count = 1;
        p_caster->DestroyItemCount(itemTarget, count, true);
        unitTarget = p_caster;
        // and add a scroll
        DoCreateItem(effIndex, m_spellInfo->Effects[effIndex].ItemType);
        itemTarget = nullptr;
        m_targets.SetItemTarget(nullptr);
    }
    else
    {
        // do not increase skill if vellum used
        if (!(m_CastItem && m_CastItem->GetTemplate()->Flags & ITEM_FLAG_NO_REAGENT_COST))
            p_caster->UpdateCraftSkill(m_spellInfo->Id);

        uint32 enchant_id = m_spellInfo->Effects[effIndex].MiscValue;
        if (!enchant_id)
            return;

        SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!pEnchant)
            return;

        // item can be in trade slot and have owner diff. from caster
        Player* item_owner = itemTarget->GetOwner();
        if (!item_owner)
            return;

        // remove old enchanting before applying new if equipped
        item_owner->ApplyEnchantment(itemTarget, PERM_ENCHANTMENT_SLOT, false);

        itemTarget->SetEnchantment(PERM_ENCHANTMENT_SLOT, enchant_id, 0, 0, m_caster->GetGUID());

        // add new enchanting if equipped
        item_owner->ApplyEnchantment(itemTarget, PERM_ENCHANTMENT_SLOT, true);

        item_owner->RemoveTradeableItem(itemTarget);
        itemTarget->ClearSoulboundTradeable(item_owner);
    }
}

void Spell::EffectEnchantItemPrismatic(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;
    if (!itemTarget)
        return;

    uint32 enchant_id = m_spellInfo->Effects[effIndex].MiscValue;
    if (!enchant_id)
        return;

    SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
    if (!pEnchant)
        return;

    // support only enchantings with add socket in this slot
    {
        bool add_socket = false;
        for (uint8 i = 0; i < MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS; ++i)
        {
            if (pEnchant->type[i] == ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET)
            {
                add_socket = true;
                break;
            }
        }
        if (!add_socket)
        {
            LOG_ERROR("spells.effect", "Spell::EffectEnchantItemPrismatic: attempt apply enchant spell {} with SPELL_EFFECT_ENCHANT_ITEM_PRISMATIC ({}) but without ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET ({}), not suppoted yet.",
                           m_spellInfo->Id, SPELL_EFFECT_ENCHANT_ITEM_PRISMATIC, ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET);
            return;
        }
    }

    // item can be in trade slot and have owner diff. from caster
    Player* item_owner = itemTarget->GetOwner();
    if (!item_owner)
        return;

    // remove old enchanting before applying new if equipped
    item_owner->ApplyEnchantment(itemTarget, PRISMATIC_ENCHANTMENT_SLOT, false);

    itemTarget->SetEnchantment(PRISMATIC_ENCHANTMENT_SLOT, enchant_id, 0, 0, m_caster->GetGUID());

    // add new enchanting if equipped
    item_owner->ApplyEnchantment(itemTarget, PRISMATIC_ENCHANTMENT_SLOT, true);

    item_owner->RemoveTradeableItem(itemTarget);
    itemTarget->ClearSoulboundTradeable(item_owner);
}

void Spell::EffectEnchantItemTmp(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* p_caster = m_caster->ToPlayer();

    // Rockbiter Weapon apply to both weapon
    if (!itemTarget)
        return;
    if (m_spellInfo->SpellFamilyName == SPELLFAMILY_SHAMAN && m_spellInfo->SpellFamilyFlags[0] & 0x400000)
    {
        uint32 spell_id = 0;

        // enchanting spell selected by calculated damage-per-sec stored in Effect[1] base value
        // Note: damage calculated (correctly) with rounding int32(float(v)) but
        // RW enchantments applied damage int32(float(v)+0.5), this create  0..1 difference sometime
        switch (damage)
        {
            // Rank 1
            case  2:
                spell_id = 36744;
                break;               //  0% [ 7% == 2, 14% == 2, 20% == 2]
            // Rank 2
            case  4:
                spell_id = 36753;
                break;               //  0% [ 7% == 4, 14% == 4]
            case  5:
                spell_id = 36751;
                break;               // 20%
            // Rank 3
            case  6:
                spell_id = 36754;
                break;               //  0% [ 7% == 6, 14% == 6]
            case  7:
                spell_id = 36755;
                break;               // 20%
            // Rank 4
            case  9:
                spell_id = 36761;
                break;               //  0% [ 7% == 6]
            case 10:
                spell_id = 36758;
                break;               // 14%
            case 11:
                spell_id = 36760;
                break;               // 20%
            default:
                LOG_ERROR("spells.effect", "Spell::EffectEnchantItemTmp: Damage {} not handled in S'RW", damage);
                return;
        }

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id);
        if (!spellInfo)
        {
            LOG_ERROR("spells.effect", "Spell::EffectEnchantItemTmp: unknown spell id {}", spell_id);
            return;
        }

        for (int j = BASE_ATTACK; j <= OFF_ATTACK; ++j)
        {
            if (Item* item = p_caster->GetWeaponForAttack(WeaponAttackType(j)))
            {
                if (item->IsFitToSpellRequirements(m_spellInfo))
                {
                    Spell* spell = new Spell(m_caster, spellInfo, TRIGGERED_FULL_MASK);
                    SpellCastTargets targets;
                    targets.SetItemTarget(item);
                    spell->prepare(&targets);
                }
            }
        }
        return;
    }
    if (!itemTarget)
        return;

    uint32 enchant_id = m_spellInfo->Effects[effIndex].MiscValue;

    if (!enchant_id)
    {
        LOG_ERROR("spells.effect", "Spell {} Effect {} (SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY) have 0 as enchanting id", m_spellInfo->Id, effIndex);
        return;
    }

    SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
    if (!pEnchant)
    {
        LOG_ERROR("spells.effect", "Spell {} Effect {} (SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY) have not existed enchanting id {} ", m_spellInfo->Id, effIndex, enchant_id);
        return;
    }

    // select enchantment duration
    uint32 duration;

    // rogue family enchantments exception by duration
    if (m_spellInfo->Id == 38615)
        duration = 1800;                                    // 30 mins
    // other rogue family enchantments always 1 hour (some have spell damage=0, but some have wrong data in EffBasePoints)
    else if (m_spellInfo->SpellFamilyName == SPELLFAMILY_ROGUE)
        duration = 3600;                                    // 1 hour
    // shaman family enchantments
    else if (m_spellInfo->SpellFamilyName == SPELLFAMILY_SHAMAN)
        duration = 1800;                                    // 30 mins
    // other cases with this SpellVisual already selected
    else if (m_spellInfo->SpellVisual[0] == 215)
        duration = 1800;                                    // 30 mins
    // some fishing pole bonuses except Glow Worm which lasts full hour
    else if (m_spellInfo->SpellVisual[0] == 563 && m_spellInfo->Id != 64401)
        duration = 600;                                     // 10 mins
    // shaman rockbiter enchantments
    else if (m_spellInfo->SpellVisual[0] == 0)
        duration = 1800;                                    // 30 mins
    else if (m_spellInfo->Id == 29702)
        duration = 300;                                     // 5 mins
    else if (m_spellInfo->Id == 37360)
        duration = 300;                                     // 5 mins
    // default case
    else
        duration = 3600;                                    // 1 hour

    // item can be in trade slot and have owner diff. from caster
    Player* item_owner = itemTarget->GetOwner();
    if (!item_owner)
        return;

    // remove old enchanting before applying new if equipped
    item_owner->ApplyEnchantment(itemTarget, TEMP_ENCHANTMENT_SLOT, false);

    itemTarget->SetEnchantment(TEMP_ENCHANTMENT_SLOT, enchant_id, duration * 1000, pEnchant->charges, m_caster->GetGUID());

    // add new enchanting if equipped
    item_owner->ApplyEnchantment(itemTarget, TEMP_ENCHANTMENT_SLOT, true);

    item_owner->RemoveTradeableItem(itemTarget);
    itemTarget->ClearSoulboundTradeable(item_owner);
}

void Spell::EffectTameCreature(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetPetGUID())
        return;

    if (!unitTarget)
        return;

    if (unitTarget->GetTypeId() != TYPEID_UNIT)
        return;

    Creature* creatureTarget = unitTarget->ToCreature();

    if (creatureTarget->IsPet())
        return;

    if (!m_caster->IsClass(CLASS_HUNTER, CLASS_CONTEXT_PET))
        return;

    // cast finish successfully
    //SendChannelUpdate(0);
    finish();

    Pet* pet = m_caster->CreateTamedPetFrom(creatureTarget, m_spellInfo->Id);
    if (!pet)                                               // in very specific state like near world end/etc.
        return;

    // "kill" original creature
    creatureTarget->DespawnOrUnsummon();

    uint8 level = (creatureTarget->GetLevel() < (m_caster->GetLevel() - 5)) ? (m_caster->GetLevel() - 5) : creatureTarget->GetLevel();

    // prepare visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, level - 1);

    // add to world
    pet->GetMap()->AddToMap(pet->ToCreature(), true);

    // visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, level);

    // caster have pet now
    m_caster->SetMinion(pet, true);

    pet->InitTalentForLevel();

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
        m_caster->ToPlayer()->PetSpellInitialize();
    }
}

void Spell::EffectSummonPet(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (!m_originalCaster)
        return;

    uint32 petentry = m_spellInfo->Effects[effIndex].MiscValue;
    int32 duration = m_spellInfo->GetDuration();

    if(Player* modOwner = m_originalCaster->GetSpellModOwner())
        modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_DURATION, duration);

    Player* owner = m_originalCaster->ToPlayer();
    if (!owner && m_originalCaster->ToCreature()->IsTotem())
        owner = m_originalCaster->GetCharmerOrOwnerPlayerOrPlayerItself();

    if (!owner)
    {
        SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(67);
        if (properties)
        {
            // Xinef: unsummon old guardian
            if (Guardian* oldPet = m_originalCaster->GetGuardianPet())
                oldPet->UnSummon();
            SummonGuardian(effIndex, petentry, properties, 1, false);
        }
        return;
    }

    Pet* OldSummon = owner->GetPet();

    // if pet requested type already exist
    if (OldSummon)
    {
        if (petentry == 0 || OldSummon->GetEntry() == petentry)
        {
            // pet in corpse state can't be summoned
            if (OldSummon->isDead())
                return;

            ASSERT(OldSummon->GetMap() == owner->GetMap());

            //OldSummon->GetMap()->Remove(OldSummon->ToCreature(), false);

            float px, py, pz;
            owner->GetClosePoint(px, py, pz, OldSummon->GetObjectSize());

            OldSummon->NearTeleportTo(px, py, pz, OldSummon->GetOrientation());
            OldSummon->UpdateObjectVisibility();

            OldSummon->SetHealth(OldSummon->GetMaxHealth());
            OldSummon->SetPower(OldSummon->getPowerType(), OldSummon->GetMaxPower(OldSummon->getPowerType()));
            // notify player
            for (CreatureSpellCooldowns::const_iterator itr = OldSummon->m_CreatureSpellCooldowns.begin(); itr != OldSummon->m_CreatureSpellCooldowns.end(); ++itr)
                owner->SendClearCooldown(itr->first, OldSummon);

            // actually clear cooldowns
            OldSummon->m_CreatureSpellCooldowns.clear();
            Unit::AuraApplicationMap& myAuras = OldSummon->GetAppliedAuras();
            for (Unit::AuraApplicationMap::iterator i = myAuras.begin(); i != myAuras.end();)
            {
                Aura const* aura = i->second->GetBase();
                if (!aura->IsPassive() && !OldSummon->IsPetAura(aura) && aura->CanBeSentToClient())
                    OldSummon->RemoveAura(i);
                else
                    ++i;
            }
            return;
        }

        if (owner->GetTypeId() == TYPEID_PLAYER)
            owner->ToPlayer()->RemovePet(OldSummon, PET_SAVE_NOT_IN_SLOT, false);
        else
            return;
    }

    float x, y, z;
    owner->GetClosePoint(x, y, z, owner->GetObjectSize());
    Pet* pet = owner->SummonPet(petentry, x, y, z, owner->GetOrientation(), SUMMON_PET);
    if (!pet)
        return;

    if (m_caster->GetTypeId() == TYPEID_UNIT)
    {
        if (m_caster->ToCreature()->IsTotem())
            pet->SetReactState(REACT_AGGRESSIVE);
        else
            pet->SetReactState(REACT_DEFENSIVE);
    }

    pet->SetUInt32Value(UNIT_CREATED_BY_SPELL, m_spellInfo->Id);

    // Reset cooldowns
    if (!owner->IsClass(CLASS_HUNTER, CLASS_CONTEXT_PET))
    {
        pet->m_CreatureSpellCooldowns.clear();
        owner->PetSpellInitialize();
    }

    // Set health to max if new pet is summoned
    // in this function old pet is saved with current health eg. 20% and new one is loaded from db with same amount
    // pet should have full health
    pet->SetHealth(pet->GetMaxHealth());

    // generate new name for summon pet
    std::string new_name = sObjectMgr->GeneratePetName(petentry);
    if (!new_name.empty())
        pet->SetName(new_name);

    // ExecuteLogEffectSummonObject(effectInfo->EffectIndex, pet);
}

void Spell::EffectLearnPetSpell(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (unitTarget->ToPlayer())
    {
        EffectLearnSpell(effIndex);
        return;
    }
    Pet* pet = unitTarget->ToPet();
    if (!pet)
        return;

    SpellInfo const* learn_spellproto = sSpellMgr->GetSpellInfo(m_spellInfo->Effects[effIndex].TriggerSpell);
    if (!learn_spellproto)
        return;

    pet->learnSpell(learn_spellproto->Id);
    pet->SavePetToDB(PET_SAVE_AS_CURRENT);
    pet->GetOwner()->PetSpellInitialize();
}

void Spell::EffectTaunt(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    // xinef: Hand of Reckoning, cast before checing canhavethreatlist. fixes damage against pets
    if (m_spellInfo->Id == 62124 && unitTarget->GetVictim() != m_caster)
    {
        m_caster->CastSpell(unitTarget, 67485, true);
        unitTarget->CombatStart(m_caster);
    }

    // this effect use before aura Taunt apply for prevent taunt already attacking target
    // for spell as marked "non effective at already attacking target"
    if (!unitTarget->CanHaveThreatList() || (unitTarget->GetVictim() == m_caster && !m_spellInfo->HasAura(SPELL_AURA_MOD_TAUNT)))
    {
        SendCastResult(SPELL_FAILED_DONT_REPORT);
        return;
    }

    if (!unitTarget->GetThreatMgr().GetOnlineContainer().empty())
    {
        // Also use this effect to set the taunter's threat to the taunted creature's highest value
        float myThreat = unitTarget->GetThreatMgr().GetThreat(m_caster);
        float topThreat = unitTarget->GetThreatMgr().GetOnlineContainer().getMostHated()->GetThreat();
        if (topThreat > myThreat)
            unitTarget->GetThreatMgr().DoAddThreat(m_caster, topThreat - myThreat);

        //Set aggro victim to caster
        if (HostileReference* forcedVictim = unitTarget->GetThreatMgr().GetOnlineContainer().getReferenceByTarget(m_caster))
            unitTarget->GetThreatMgr().setCurrentVictim(forcedVictim);
    }
}

void Spell::EffectWeaponDmg(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive())
        return;

    // multiple weapon dmg effect workaround
    // execute only the last weapon damage
    // and handle all effects at once
    for (uint32 j = effIndex + 1; j < MAX_SPELL_EFFECTS; ++j)
    {
        switch (m_spellInfo->Effects[j].Effect)
        {
            case SPELL_EFFECT_WEAPON_DAMAGE:
            case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
            case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
            case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                return;     // we must calculate only at last weapon effect
                break;
        }
    }

    // some spell specific modifiers
    float totalDamagePercentMod  = 100.0f;                  // applied to final bonus+weapon damage
    int32 spell_bonus = 0;                                  // bonus specific for spell
    bool normalized = false;

    switch (m_spellInfo->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            {
                switch (m_spellInfo->Id)
                {
                    // Trial of the Champion, Black Knight, Obliterate
                    case 67725:
                    case 67883:
                        {
                            AddPct(totalDamagePercentMod, unitTarget->GetDiseasesByCaster(m_caster->GetGUID(), 1) * 30.0f);
                            break;
                        }
                }
                break;
            }
        case SPELLFAMILY_WARRIOR:
            {
                // Devastate (player ones)
                if (m_spellInfo->SpellFamilyFlags[1] & 0x40)
                {
                    m_caster->CastSpell(unitTarget, 58567, true);

                    if (Aura* aur = unitTarget->GetAura(58567))
                    {
                        // 58388 - Glyph of Devastate dummy aura.
                        if (m_caster->HasAura(58388))
                            aur->ModStackAmount(1);

                        spell_bonus += (aur->GetStackAmount() - 1) * CalculateSpellDamage(2, unitTarget);
                    }
                }
                break;
            }
        case SPELLFAMILY_ROGUE:
            {
                // Fan of Knives, Hemorrhage, Ghostly Strike
                if ((m_spellInfo->SpellFamilyFlags[1] & 0x40000)
                        || (m_spellInfo->SpellFamilyFlags[0] & 0x6000000))
                {
                    // Hemorrhage
                    if (m_spellInfo->SpellFamilyFlags[0] & 0x2000000)
                    {
                        AddComboPointGain(unitTarget, 1);
                    }
                    // 50% more damage with daggers
                    if (m_caster->GetTypeId() == TYPEID_PLAYER)
                        if (Item* item = m_caster->ToPlayer()->GetWeaponForAttack(m_attackType, true))
                            if (item->GetTemplate()->SubClass == ITEM_SUBCLASS_WEAPON_DAGGER)
                                AddPct(totalDamagePercentMod, 50.0f);

                    //npcbot: handle bot weapons
                    // 50% more damage with daggers
                    if (m_caster->IsNPCBot())
                        if (Item const* weapon = m_caster->ToCreature()->GetBotEquips(m_attackType))
                            if (weapon->GetTemplate()->SubClass == ITEM_SUBCLASS_WEAPON_DAGGER)
                                totalDamagePercentMod *= 1.5f;
                    //end npcbot
                }
                // Mutilate (for each hand)
                else if (m_spellInfo->SpellFamilyFlags[1] & 0x6)
                {
                    bool found = false;
                    // fast check
                    if (unitTarget->HasAuraState(AURA_STATE_DEADLY_POISON, m_spellInfo, m_caster))
                        found = true;
                    // full aura scan
                    else
                    {
                        Unit::AuraApplicationMap const& auras = unitTarget->GetAppliedAuras();
                        for (Unit::AuraApplicationMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                        {
                            if (itr->second->GetBase()->GetSpellInfo()->Dispel == DISPEL_POISON)
                            {
                                found = true;
                                break;
                            }
                        }
                    }

                    if (found)
                        AddPct(totalDamagePercentMod, 20.0f);          // 120% if poisoned
                }
                break;
            }
        case SPELLFAMILY_PALADIN:
            {
                switch (m_spellInfo->Id)
                {
                    case 20467: // Seal of Command Unleashed
                        spell_bonus += int32(0.08f * m_caster->GetTotalAttackPowerValue(BASE_ATTACK));
                        spell_bonus += int32(0.13f * m_caster->SpellBaseDamageBonusDone(m_spellInfo->GetSchoolMask()));
                        break;
                    case 42463: // Seals of the Pure for Seal of Vengeance/Corruption
                    case 53739:
                        if (AuraEffect const* sealsOfPure = m_caster->GetAuraEffect(SPELL_AURA_ADD_PCT_MODIFIER, SPELLFAMILY_PALADIN, 25, 0))
                            AddPct(totalDamagePercentMod, sealsOfPure->GetAmount());
                        break;
                    case 53385:  // Divine Storm deals normalized damage
                        normalized = true;
                        break;
                    default:
                        break;
                }
                break;
            }
        case SPELLFAMILY_SHAMAN:
            {
                // Skyshatter Harness item set bonus
                // Stormstrike
                if (AuraEffect* aurEff = m_caster->IsScriptOverriden(m_spellInfo, 5634))
                    m_caster->CastSpell(m_caster, 38430, true, nullptr, aurEff);
                // Lava lash damage increased by Flametongue weapon
                if (m_caster->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_SHAMAN, 688, EFFECT_0))
                    AddPct(totalDamagePercentMod, 25.0f);
                break;
            }
        case SPELLFAMILY_DRUID:
            {
                // Mangle (Cat): CP
                if (m_spellInfo->SpellFamilyFlags[1] & 0x400)
                {
                    AddComboPointGain(unitTarget, 1);
                }
                // Shred, Maul - Rend and Tear
                else if (m_spellInfo->SpellFamilyFlags[0] & 0x00008800 && unitTarget->HasAuraState(AURA_STATE_BLEEDING))
                {
                    if (AuraEffect const* rendAndTear = m_caster->GetDummyAuraEffect(SPELLFAMILY_DRUID, 2859, 0))
                        AddPct(totalDamagePercentMod, rendAndTear->GetAmount());
                }
                break;
            }
        case SPELLFAMILY_HUNTER:
            {
                // Kill Shot
                if( m_spellInfo->SpellFamilyFlags[1] & 0x800000 )
                {
                    spell_bonus += int32(m_caster->GetTotalAttackPowerValue(RANGED_ATTACK) * 0.4f);
                }
                break;
            }
        case SPELLFAMILY_DEATHKNIGHT:
            {
                // Plague Strike
                if (m_spellInfo->SpellFamilyFlags[0] & 0x1)
                {
                    // Glyph of Plague Strike
                    if (AuraEffect const* aurEff = m_caster->GetAuraEffect(58657, EFFECT_0))
                        AddPct(totalDamagePercentMod, aurEff->GetAmount());
                    break;
                }
                // Blood Strike
                if (m_spellInfo->SpellFamilyFlags[0] & 0x400000)
                {
                    float disease_amt = m_spellInfo->Effects[EFFECT_2].CalcValue();
                    //Death Knight T8 Melee 4P Bonus
                    if (AuraEffect* aurEff = m_caster->GetAuraEffectDummy(64736) )
                        AddPct(disease_amt, aurEff->GetAmount());

                    AddPct(totalDamagePercentMod, disease_amt * unitTarget->GetDiseasesByCaster(m_caster->GetGUID()) / 2.0f);

                    // Glyph of Blood Strike
                    if (m_caster->GetAuraEffect(59332, EFFECT_0))
                        if (unitTarget->HasAuraType(SPELL_AURA_MOD_DECREASE_SPEED))
                            AddPct(totalDamagePercentMod, 20.0f);
                    break;
                }
                // Death Strike
                if (m_spellInfo->SpellFamilyFlags[0] & 0x10)
                {
                    // Glyph of Death Strike
                    if (AuraEffect const* aurEff = m_caster->GetAuraEffect(59336, EFFECT_0))
                        if (uint32 runic = std::min<uint32>(m_caster->GetPower(POWER_RUNIC_POWER), aurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue()))
                            AddPct(totalDamagePercentMod, runic);
                    break;
                }
                // Obliterate (12.5% more damage per disease)
                if (m_spellInfo->SpellFamilyFlags[1] & 0x20000)
                {
                    bool consumeDiseases = true;
                    // Annihilation
                    if (AuraEffect const* aurEff = m_caster->GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 2710, EFFECT_0))
                        // Do not consume diseases if roll sucesses
                        if (roll_chance_i(aurEff->GetAmount()))
                            consumeDiseases = false;

                    float disease_amt = m_spellInfo->Effects[EFFECT_2].CalcValue();
                    //Death Knight T8 Melee 4P Bonus
                    if (AuraEffect* aurEff = m_caster->GetAuraEffectDummy(64736) )
                        AddPct(disease_amt, aurEff->GetAmount());

                    AddPct(totalDamagePercentMod, disease_amt * unitTarget->GetDiseasesByCaster(m_caster->GetGUID(), consumeDiseases) / 2.0f);
                    break;
                }
                // Blood-Caked Strike - Blood-Caked Blade
                if (m_spellInfo->SpellIconID == 1736)
                {
                    int32 weaponDamage = m_caster->CalculateDamage(m_attackType, false, true);
                    ApplyPct(weaponDamage, std::min(uint32(3), unitTarget->GetDiseasesByCaster(m_caster->GetGUID())) * 12.5f);
                    spell_bonus = weaponDamage;
                    break;
                }
                // Heart Strike
                if (m_spellInfo->SpellFamilyFlags[0] & 0x1000000)
                {
                    float disease_amt = m_spellInfo->Effects[EFFECT_2].CalcValue();
                    //Death Knight T8 Melee 4P Bonus
                    if (AuraEffect* aurEff = m_caster->GetAuraEffectDummy(64736) )
                        AddPct(disease_amt, aurEff->GetAmount());

                    AddPct(totalDamagePercentMod, disease_amt * unitTarget->GetDiseasesByCaster(m_caster->GetGUID()));
                    break;
                }
                // Rune Strike
                if (m_spellInfo->SpellFamilyFlags[1] & 0x20000000)
                {
                    spell_bonus += int32(0.15f * m_caster->GetTotalAttackPowerValue(BASE_ATTACK));
                }

                break;
            }
    }

    float weaponDamagePercentMod = 100.0f;
    int32 fixed_bonus = 0;

    for (int j = 0; j < MAX_SPELL_EFFECTS; ++j)
    {
        switch (m_spellInfo->Effects[j].Effect)
        {
            case SPELL_EFFECT_WEAPON_DAMAGE:
            case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
                fixed_bonus += CalculateSpellDamage(j, unitTarget);
                break;
            case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
                fixed_bonus += CalculateSpellDamage(j, unitTarget);
                normalized = true;
                break;
            case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                ApplyPct(weaponDamagePercentMod, CalculateSpellDamage(j, unitTarget));
                break;
            default:
                break;                                      // not weapon damage effect, just skip
        }
    }

    // apply to non-weapon bonus weapon total pct effect, weapon total flat effect included in weapon damage
    if (fixed_bonus || spell_bonus)
    {
        UnitMods unitMod;
        switch (m_attackType)
        {
            default:
            case BASE_ATTACK:
                unitMod = UNIT_MOD_DAMAGE_MAINHAND;
                break;
            case OFF_ATTACK:
                unitMod = UNIT_MOD_DAMAGE_OFFHAND;
                break;
            case RANGED_ATTACK:
                unitMod = UNIT_MOD_DAMAGE_RANGED;
                break;
        }

        if (m_spellSchoolMask & SPELL_SCHOOL_MASK_NORMAL)
        {
            float weapon_total_pct = m_caster->GetModifierValue(unitMod, TOTAL_PCT);
            fixed_bonus = int32(fixed_bonus * weapon_total_pct);
            spell_bonus = int32(spell_bonus * weapon_total_pct);
        }
    }

    int32 weaponDamage = 0;
    // Dancing Rune Weapon
    if (m_caster->GetEntry() == 27893)
    {
        if (Unit* owner = m_caster->GetOwner())
            weaponDamage = owner->CalculateDamage(m_attackType, normalized, true);
    }
    else if (m_spellInfo->Id == 5019) // Wands
    {
        weaponDamage = m_caster->CalculateDamage(m_attackType, true, false);
    }
    else
    {
        weaponDamage = m_caster->CalculateDamage(m_attackType, normalized, true);
    }

    // Sequence is important
    for (int j = 0; j < MAX_SPELL_EFFECTS; ++j)
    {
        // We assume that a spell have at most one fixed_bonus
        // and at most one weaponDamagePercentMod
        switch (m_spellInfo->Effects[j].Effect)
        {
            case SPELL_EFFECT_WEAPON_DAMAGE:
            case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
            case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
                weaponDamage += fixed_bonus;
                break;
            case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                ApplyPct(weaponDamage, weaponDamagePercentMod);
            default:
                break;                                      // not weapon damage effect, just skip
        }
    }

    weaponDamage += spell_bonus;
    ApplyPct(weaponDamage, totalDamagePercentMod);

    // prevent negative damage
    uint32 eff_damage(std::max(weaponDamage, 0));

    // Add melee damage bonuses (also check for negative)
    eff_damage = m_caster->MeleeDamageBonusDone(unitTarget, eff_damage, m_attackType, m_spellInfo, m_spellSchoolMask);
    eff_damage = unitTarget->MeleeDamageBonusTaken(m_caster, eff_damage, m_attackType, m_spellInfo, m_spellSchoolMask);

    // Meteor like spells (divided damage to targets)
    if (m_spellInfo->HasAttribute(SPELL_ATTR0_CU_SHARE_DAMAGE))
    {
        uint32 count = 0;
        for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
            if (ihit->effectMask & (1 << effIndex))
                ++count;

        eff_damage /= count;                    // divide to all targets
    }

    m_damage += eff_damage;
}

void Spell::EffectThreat(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive() || !m_caster->IsAlive())
        return;

    // xinef: skip if target cannot have threat list or caster is friendly (ghoul leap)
    if (!unitTarget->CanHaveThreatList() || m_caster->IsFriendlyTo(unitTarget))
        return;

    unitTarget->AddThreat(m_caster, float(damage));
}

void Spell::EffectHealMaxHealth(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive())
        return;

    int32 addhealth = 0;

    // damage == 0 - heal for caster max health
    if (damage == 0)
        addhealth = m_caster->GetMaxHealth();
    else
        addhealth = unitTarget->GetMaxHealth() - unitTarget->GetHealth();

    m_healing += addhealth;
}

void Spell::EffectInterruptCast(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsAlive())
        return;

    /// @todo: not all spells that used this effect apply cooldown at school spells
    // also exist case: apply cooldown to interrupted cast only and to all spells
    // there is no CURRENT_AUTOREPEAT_SPELL spells that can be interrupted
    for (uint32 i = CURRENT_FIRST_NON_MELEE_SPELL; i < CURRENT_AUTOREPEAT_SPELL; ++i)
    {
        if (Spell* spell = unitTarget->GetCurrentSpell(CurrentSpellTypes(i)))
        {
            SpellInfo const* curSpellInfo = spell->m_spellInfo;
            // check if we can interrupt spell
            if ((spell->getState() == SPELL_STATE_CASTING
                    || (spell->getState() == SPELL_STATE_PREPARING && spell->GetCastTime() > 0.0f))
                    && curSpellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE
                    && ((i == CURRENT_GENERIC_SPELL && curSpellInfo->InterruptFlags & SPELL_INTERRUPT_FLAG_INTERRUPT)
                        || (i == CURRENT_CHANNELED_SPELL && curSpellInfo->ChannelInterruptFlags & CHANNEL_INTERRUPT_FLAG_INTERRUPT)))
            {
                if (m_originalCaster)
                {
                    int32 duration = m_originalCaster->ModSpellDuration(m_spellInfo, unitTarget, m_originalCaster->CalcSpellDuration(m_spellInfo), false, 1 << effIndex);
                    unitTarget->ProhibitSpellSchool(curSpellInfo->GetSchoolMask(), duration/*spellInfo->GetDuration()*/);
                }
                ExecuteLogEffectInterruptCast(effIndex, unitTarget, curSpellInfo->Id);
                unitTarget->InterruptSpell(CurrentSpellTypes(i), false);
            }
        }
    }
}

void Spell::EffectSummonObjectWild(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    uint32 gameobject_id = m_spellInfo->Effects[effIndex].MiscValue;

    GameObject* pGameObj = sObjectMgr->IsGameObjectStaticTransport(gameobject_id) ? new StaticTransport() : new GameObject();

    WorldObject* target = focusObject;
    if (!target)
        target = m_caster;

    float x, y, z;
    if (m_targets.HasDst())
        destTarget->GetPosition(x, y, z);
    else
        m_caster->GetClosePoint(x, y, z, DEFAULT_WORLD_OBJECT_SIZE);

    Map* map = target->GetMap();

    if (!pGameObj->Create(map->GenerateLowGuid<HighGuid::GameObject>(), gameobject_id, map, m_caster->GetPhaseMask(), x, y, z, target->GetOrientation(), G3D::Quat(), 100, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    int32 duration = m_spellInfo->GetDuration();

    pGameObj->SetRespawnTime(duration > 0 ? duration / IN_MILLISECONDS : 0);
    pGameObj->SetSpellId(m_spellInfo->Id);

    ExecuteLogEffectSummonObject(effIndex, pGameObj);

    // Wild object not have owner and check clickable by players
    map->AddToMap(pGameObj, true);

    if (pGameObj->GetGoType() == GAMEOBJECT_TYPE_FLAGDROP)
        if (Player* player = m_caster->ToPlayer())
            if (Battleground* bg = player->GetBattleground())
                bg->SetDroppedFlagGUID(pGameObj->GetGUID(), player->GetTeamId() == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE);

    //npcbot
    if (m_caster->IsNPCBot() && pGameObj->GetGoType() == GAMEOBJECT_TYPE_FLAGDROP)
    {
        if (Battleground* bg = m_caster->ToCreature()->GetBotBG())
            bg->SetDroppedFlagGUID(pGameObj->GetGUID(), bg->GetOtherTeamId(bg->GetBotTeamId(m_caster->GetGUID())));
    }
    //end npcbot

    if (GameObject* linkedTrap = pGameObj->GetLinkedTrap())
    {
        linkedTrap->SetRespawnTime(duration > 0 ? duration/IN_MILLISECONDS :0);
        linkedTrap->SetSpellId(m_spellInfo->Id);
        ExecuteLogEffectSummonObject(effIndex, linkedTrap);
    }
}

void Spell::EffectScriptEffect(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    /// @todo: we must implement hunter pet summon at login there (spell 6962)

    switch (m_spellInfo->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            {
                switch (m_spellInfo->Id)
                {
                    // Shadow Flame (All script effects, not just end ones to prevent player from dodging the last triggered spell)
                    case 22539:
                    case 22972:
                    case 22975:
                    case 22976:
                    case 22977:
                    case 22978:
                    case 22979:
                    case 22980:
                    case 22981:
                    case 22982:
                    case 22983:
                    case 22984:
                    case 22985:
                        {
                            if (!unitTarget || !unitTarget->IsAlive())
                                return;

                            // Onyxia Scale Cloak
                            if (unitTarget->HasAura(22683))
                                return;

                            // Shadow Flame
                            m_caster->CastSpell(unitTarget, 22682, true);
                            return;
                        }
                    // Plant Warmaul Ogre Banner
                    case 32307:
                        if (Player* caster = m_caster->ToPlayer())
                        {
                            caster->RewardPlayerAndGroupAtEvent(18388, unitTarget);
                            if (Creature* target = unitTarget->ToCreature())
                            {
                                target->setDeathState(DeathState::Corpse);
                                target->RemoveCorpse();
                            }
                        }
                        break;
                    // SOTA defender teleport
                    case 54640:
                        {
                            if (Player* player = unitTarget->ToPlayer())
                                if (player->GetBattleground() && player->GetBattleground()->GetBgTypeID(true) == BATTLEGROUND_SA)
                                {
                                    if (GameObject* dportal = player->FindNearestGameObject(192819, 10.0f))
                                    {
                                        BattlegroundSA* bg = ((BattlegroundSA*)player->GetBattleground());
                                        bg->DefendersPortalTeleport(dportal, player);
                                    }
                                }
                            return;
                        }
                    /*// Mug Transformation
                    case 41931:
                    {
                        if (m_caster->GetTypeId() != TYPEID_PLAYER)
                            return;

                        uint8 bag = 19;
                        uint8 slot = 0;
                        Item* item = nullptr;

                        while (bag) // 256 = 0 due to var type
                        {
                            item = m_caster->ToPlayer()->GetItemByPos(bag, slot);
                            if (item && item->GetEntry() == 38587)
                                break;

                            ++slot;
                            if (slot == 39)
                            {
                                slot = 0;
                                ++bag;
                            }
                        }
                        if (bag)
                        {
                            if (m_caster->ToPlayer()->GetItemByPos(bag, slot)->GetCount() == 1) m_caster->ToPlayer()->RemoveItem(bag, slot, true);
                            else m_caster->ToPlayer()->GetItemByPos(bag, slot)->SetCount(m_caster->ToPlayer()->GetItemByPos(bag, slot)->GetCount()-1);
                            // Spell 42518 (Braufest - Gratisprobe des Braufest herstellen)
                            m_caster->CastSpell(m_caster, 42518, true);
                            return;
                        }
                        break;
                    }*/
                    // Roll Dice - Decahedral Dwarven Dice
                    case 47770:
                        {
                            char buf[128];
                            const char* gender = "his";
                            if (m_caster->getGender() > 0)
                                gender = "her";
                            snprintf(buf, sizeof(buf), "%s rubs %s [Decahedral Dwarven Dice] between %s hands and rolls. One %u and one %u.", m_caster->GetName().c_str(), gender, gender, urand(1, 10), urand(1, 10));
                            m_caster->TextEmote(buf);
                            break;
                        }
                    case 52173: // Coyote Spirit Despawn
                    case 60243: // Blood Parrot Despawn
                        if (unitTarget->GetTypeId() == TYPEID_UNIT && unitTarget->ToCreature()->IsSummon())
                            unitTarget->ToTempSummon()->UnSummon();
                        return;
                    case 57347: // Retrieving (Wintergrasp RP-GG pickup spell)
                        {
                            if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT || m_caster->GetTypeId() != TYPEID_PLAYER)
                                return;

                            unitTarget->ToCreature()->DespawnOrUnsummon();

                            return;
                        }
                    case 57349: // Drop RP-GG (Wintergrasp RP-GG at death drop spell)
                        {
                            if (m_caster->GetTypeId() != TYPEID_PLAYER)
                                return;

                            // Delete item from inventory at death
                            m_caster->ToPlayer()->DestroyItemCount(damage, 5, true);

                            return;
                        }
                    case 58418:                                 // Portal to Orgrimmar
                    case 58420:                                 // Portal to Stormwind
                        {
                            if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER || effIndex != 0)
                                return;

                            uint32 spellID = m_spellInfo->Effects[EFFECT_0].CalcValue();
                            uint32 questID = m_spellInfo->Effects[EFFECT_1].CalcValue();

                            if (unitTarget->ToPlayer()->GetQuestStatus(questID) == QUEST_STATUS_COMPLETE)
                                unitTarget->CastSpell(unitTarget, spellID, true);

                            return;
                        }
                    // Stoneclaw Totem
                    case 55328: // Rank 1
                    case 55329: // Rank 2
                    case 55330: // Rank 3
                    case 55332: // Rank 4
                    case 55333: // Rank 5
                    case 55335: // Rank 6
                    case 55278: // Rank 7
                    case 58589: // Rank 8
                    case 58590: // Rank 9
                    case 58591: // Rank 10
                        {
                            int32 basepoints0 = damage;
                            // Cast Absorb on totems
                            for (uint8 slot = SUMMON_SLOT_TOTEM; slot < MAX_TOTEM_SLOT; ++slot)
                            {
                                if (!unitTarget->m_SummonSlot[slot])
                                    continue;

                                Creature* totem = unitTarget->GetMap()->GetCreature(unitTarget->m_SummonSlot[slot]);
                                if (totem && totem->IsTotem())
                                {
                                    m_caster->CastCustomSpell(totem, 55277, &basepoints0, nullptr, nullptr, true);
                                }
                            }
                            // Glyph of Stoneclaw Totem
                            if (AuraEffect* aur = unitTarget->GetAuraEffect(63298, 0))
                            {
                                basepoints0 *= aur->GetAmount();
                                m_caster->CastCustomSpell(unitTarget, 55277, &basepoints0, nullptr, nullptr, true);
                            }
                            break;
                        }
                    case 61263: // for item Intravenous Healing Potion (44698)
                        {
                            if( !m_caster || !unitTarget )
                                return;

                            m_caster->CastSpell(m_caster, 61267, true);
                            m_caster->CastSpell(m_caster, 61268, true);
                            return;
                        }
                }
                break;
            }
        case SPELLFAMILY_ROGUE:
            {
                switch( m_spellInfo->Id )
                {
                    // Master of Subtlety
                    case 31666:
                        {
                            if( !unitTarget )
                                return;

                            Aura* mos = unitTarget->GetAura(31665);
                            if( mos )
                            {
                                mos->SetMaxDuration(6000);
                                mos->SetDuration(6000, true);
                            }

                            break;
                        }
                    // Overkill
                    case 58428:
                        {
                            if( !unitTarget )
                                return;

                            Aura* overkill = unitTarget->GetAura(58427);
                            if( overkill )
                            {
                                overkill->SetMaxDuration(20000);
                                overkill->SetDuration(20000, true);
                            }

                            break;
                        }
                }
                break;
            }
    }

    // normal DB scripted effect
    LOG_DEBUG("spells.aura", "Spell ScriptStart spellid {} in EffectScriptEffect({})", m_spellInfo->Id, effIndex);
    m_caster->GetMap()->ScriptsStart(sSpellScripts, uint32(m_spellInfo->Id | (effIndex << 24)), m_caster, unitTarget);
}

void Spell::EffectSanctuary(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (unitTarget->GetInstanceScript() && unitTarget->GetInstanceScript()->IsEncounterInProgress())
    {
        unitTarget->getHostileRefMgr().UpdateVisibility(true);
        // Xinef: replaced with CombatStop(false)
        unitTarget->AttackStop();
        unitTarget->RemoveAllAttackers();

        // Night Elf: Shadowmeld only resets threat temporarily
        if (m_spellInfo->Id != 59646)
            unitTarget->getHostileRefMgr().addThreatPercent(-100);

        if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            unitTarget->ToPlayer()->SendAttackSwingCancelAttack();     // melee and ranged forced attack cancel
    }
    else
    {
        unitTarget->getHostileRefMgr().UpdateVisibility(m_spellInfo->Id == 59646); // Night Elf: Shadowmeld
        unitTarget->CombatStop(true);
    }

    UnitList targets;
    Acore::AnyUnfriendlyUnitInObjectRangeCheck u_check(unitTarget, unitTarget, unitTarget->GetVisibilityRange()); // no VISIBILITY_COMPENSATION, distance is enough
    Acore::UnitListSearcher<Acore::AnyUnfriendlyUnitInObjectRangeCheck> searcher(unitTarget, targets, u_check);
    Cell::VisitAllObjects(unitTarget, searcher, unitTarget->GetVisibilityRange());
    for (UnitList::iterator iter = targets.begin(); iter != targets.end(); ++iter)
    {
        if (!(*iter)->HasUnitState(UNIT_STATE_CASTING))
            continue;

        for (uint32 i = CURRENT_FIRST_NON_MELEE_SPELL; i < CURRENT_MAX_SPELL; i++)
        {
            if ((*iter)->GetCurrentSpell(i) && (*iter)->GetCurrentSpell(i)->m_targets.GetUnitTargetGUID() == unitTarget->GetGUID())
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

    // Xinef: Set last sanctuary time
    unitTarget->m_lastSanctuaryTime = GameTime::GetGameTimeMS().count();
}

void Spell::EffectAddComboPoints(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
    {
        return;
    }

    if (!unitTarget || damage <= 0)
    {
        return;
    }

    AddComboPointGain(unitTarget, damage);
}

void Spell::EffectDuel(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || m_caster->GetTypeId() != TYPEID_PLAYER || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* caster = m_caster->ToPlayer();
    Player* target = unitTarget->ToPlayer();

    // caster or target already have requested duel
    if (caster->duel || target->duel || !target->GetSocial() || target->GetSocial()->HasIgnore(caster->GetGUID()))
        return;

    // Players can only fight a duel in zones with this flag
    AreaTableEntry const* casterAreaEntry = sAreaTableStore.LookupEntry(caster->GetAreaId());
    if (casterAreaEntry && !(casterAreaEntry->flags & AREA_FLAG_ALLOW_DUELS))
    {
        SendCastResult(SPELL_FAILED_NO_DUELING);            // Dueling isn't allowed here
        return;
    }

    AreaTableEntry const* targetAreaEntry = sAreaTableStore.LookupEntry(target->GetAreaId());
    if (targetAreaEntry && !(targetAreaEntry->flags & AREA_FLAG_ALLOW_DUELS))
    {
        SendCastResult(SPELL_FAILED_NO_DUELING);            // Dueling isn't allowed here
        return;
    }

    //CREATE DUEL FLAG OBJECT
    uint32 gameobject_id = m_spellInfo->Effects[effIndex].MiscValue;
    GameObject* pGameObj = sObjectMgr->IsGameObjectStaticTransport(gameobject_id) ? new StaticTransport() : new GameObject();

    Map* map = m_caster->GetMap();
    if (!pGameObj->Create(map->GenerateLowGuid<HighGuid::GameObject>(), gameobject_id,
                          map, m_caster->GetPhaseMask(),
                          m_caster->GetPositionX() + (unitTarget->GetPositionX() - m_caster->GetPositionX()) / 2,
                          m_caster->GetPositionY() + (unitTarget->GetPositionY() - m_caster->GetPositionY()) / 2,
                          m_caster->GetPositionZ(),
                          m_caster->GetOrientation(), G3D::Quat(), 0, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    pGameObj->SetUInt32Value(GAMEOBJECT_FACTION, m_caster->GetFaction());
    pGameObj->SetUInt32Value(GAMEOBJECT_LEVEL, m_caster->GetLevel() + 1);
    int32 duration = m_spellInfo->GetDuration();
    pGameObj->SetRespawnTime(duration > 0 ? duration / IN_MILLISECONDS : 0);
    pGameObj->SetSpellId(m_spellInfo->Id);

    ExecuteLogEffectSummonObject(effIndex, pGameObj);

    m_caster->AddGameObject(pGameObj);
    map->AddToMap(pGameObj, true);
    //END

    // Send request
    WorldPacket data(SMSG_DUEL_REQUESTED, 8 + 8);
    data << pGameObj->GetGUID();
    data << caster->GetGUID();
    caster->GetSession()->SendPacket(&data);
    target->GetSession()->SendPacket(&data);

    // create duel-info
    bool isMounted = (GetSpellInfo()->Id == 62875);
    caster->duel = std::make_unique<DuelInfo>(target, caster, isMounted);
    target->duel = std::make_unique<DuelInfo>(caster, caster, isMounted);

    caster->SetGuidValue(PLAYER_DUEL_ARBITER, pGameObj->GetGUID());
    target->SetGuidValue(PLAYER_DUEL_ARBITER, pGameObj->GetGUID());

    sScriptMgr->OnPlayerDuelRequest(target, caster);
}

void Spell::EffectStuck(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* target = m_caster->ToPlayer();
    if (target->IsInFlight())
        return;

    // xinef: if player is dead - teleport to graveyard
    if (!target->IsAlive())
    {
        if (target->HasAuraType(SPELL_AURA_PREVENT_RESURRECTION))
            return;

        // xinef: player is in corpse
        if (!target->HasPlayerFlag(PLAYER_FLAGS_GHOST))
            target->BuildPlayerRepop();
        target->RepopAtGraveyard();
        return;
    }

    // xinef: no hearthstone in bag or on cooldown
    Item* hearthStone = target->GetItemByEntry(6948);
    if (!hearthStone || target->HasSpellCooldown(8690))
    {
        float o = rand_norm() * 2 * M_PI;
        Position pos = *target;
        target->MovePositionToFirstCollision(pos, 5.0f, o);
        target->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), target->GetOrientation());
        return;
    }

    // xinef: we have hearthstone not on cooldown, just use it
    target->CastSpell(target, 8690, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD));
}

void Spell::EffectSummonPlayer(SpellEffIndex /*effIndex*/)
{
    // workaround - this effect should not use target map
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    // Evil Twin (ignore player summon, but hide this for summoner)
    // Xinef: Unit Target may be on other map!!!, Need workaround
    if (unitTarget->HasAura(23445))
        return;

    float x, y, z;
    m_caster->GetPosition(x, y, z);

    player->SetSummonPoint(m_caster->GetMapId(), x, y, z);

    WorldPacket data(SMSG_SUMMON_REQUEST, 8 + 4 + 4);
    data << m_caster->GetGUID();                                // summoner guid
    data << uint32(m_caster->GetZoneId());                      // summoner zone
    data << uint32(MAX_PLAYER_SUMMON_DELAY * IN_MILLISECONDS);  // auto decline after msecs
    player->GetSession()->SendPacket(&data);
}

void Spell::EffectActivateObject(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!gameObjTarget)
        return;

    GameObjectActions action = GameObjectActions(m_spellInfo->Effects[effIndex].MiscValue);
    switch (action)
    {
        case GameObjectActions::AnimateCustom0:
        case GameObjectActions::AnimateCustom1:
        case GameObjectActions::AnimateCustom2:
        case GameObjectActions::AnimateCustom3:
            gameObjTarget->SendCustomAnim(uint32(action) - uint32(GameObjectActions::AnimateCustom0));
            break;
        case GameObjectActions::Disturb: // What's the difference with Open?
        case GameObjectActions::Open:
            if (Unit* unitCaster = m_caster->ToUnit())
                gameObjTarget->Use(unitCaster);
            break;
        case GameObjectActions::OpenAndUnlock:
            if (Unit* unitCaster = m_caster->ToUnit())
                gameObjTarget->UseDoorOrButton(0, false, unitCaster);
            [[fallthrough]];
        case GameObjectActions::Unlock:
        case GameObjectActions::Lock:
            gameObjTarget->ApplyModFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED, action == GameObjectActions::Lock);
            break;
        case GameObjectActions::Close:
        case GameObjectActions::Rebuild:
            gameObjTarget->ResetDoorOrButton();
            break;
        case GameObjectActions::Despawn:
            gameObjTarget->DespawnOrUnsummon();
            break;
        case GameObjectActions::MakeInert:
        case GameObjectActions::MakeActive:
            gameObjTarget->ApplyModFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE, action == GameObjectActions::MakeInert);
            break;
        case GameObjectActions::CloseAndLock:
            gameObjTarget->ResetDoorOrButton();
            gameObjTarget->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
            break;
        case GameObjectActions::Destroy:
            if (Unit* unitCaster = m_caster->ToUnit())
                gameObjTarget->UseDoorOrButton(0, true, unitCaster);
            break;
        case GameObjectActions::UseArtKit0:
        case GameObjectActions::UseArtKit1:
        case GameObjectActions::UseArtKit2:
        case GameObjectActions::UseArtKit3:
        {
            GameObjectTemplateAddon const* templateAddon = gameObjTarget->GetTemplateAddon();

            uint32 artKitIndex = uint32(action) - uint32(GameObjectActions::UseArtKit0);

            uint32 artKitValue = 0;
            if (templateAddon)
                artKitValue = templateAddon->artKits[artKitIndex];

            if (artKitValue == 0)
                LOG_ERROR("sql.sql", "GameObject {} hit by spell {} needs `artkit{}` in `gameobject_template_addon`", gameObjTarget->GetEntry(), m_spellInfo->Id, artKitIndex);
            else
                gameObjTarget->SetGoArtKit(artKitValue);

            break;
        }
        case GameObjectActions::None:
            LOG_FATAL("spell", "Spell {} has action type NONE in effect {}", m_spellInfo->Id, int32(effIndex));
            break;
        default:
            LOG_ERROR("spell", "Spell {} has unhandled action {} in effect {}", m_spellInfo->Id, int32(action), int32(effIndex));
            break;
    }
}

void Spell::EffectApplyGlyph(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER || m_glyphIndex >= MAX_GLYPH_SLOT_INDEX)
        return;

    Player* player = m_caster->ToPlayer();

    // glyph sockets level requirement
    uint8 minLevel = 0;
    switch (m_glyphIndex)
    {
        case 0:
        case 1:
            minLevel = 15;
            break;
        case 2:
            minLevel = 50;
            break;
        case 3:
            minLevel = 30;
            break;
        case 4:
            minLevel = 70;
            break;
        case 5:
            minLevel = 80;
            break;
    }
    if (minLevel && m_caster->GetLevel() < minLevel)
    {
        SendCastResult(SPELL_FAILED_GLYPH_SOCKET_LOCKED);
        return;
    }

    // apply new one
    if (uint32 glyph = m_spellInfo->Effects[effIndex].MiscValue)
    {
        if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyph))
        {
            if (GlyphSlotEntry const* glyphSlotEntry = sGlyphSlotStore.LookupEntry(player->GetGlyphSlot(m_glyphIndex)))
            {
                if (glyphEntry->TypeFlags != glyphSlotEntry->TypeFlags)
                {
                    SendCastResult(SPELL_FAILED_INVALID_GLYPH);
                    return;                                 // glyph slot mismatch
                }
            }

            // remove old glyph aura
            if (uint32 oldGlyph = player->GetGlyph(m_glyphIndex))
                if (GlyphPropertiesEntry const* oldGlyphEntry = sGlyphPropertiesStore.LookupEntry(oldGlyph))
                {
                    player->RemoveAurasDueToSpell(oldGlyphEntry->SpellId);

                    // Removed any triggered auras
                    Unit::AuraMap& ownedAuras = player->GetOwnedAuras();
                    for (Unit::AuraMap::iterator iter = ownedAuras.begin(); iter != ownedAuras.end();)
                    {
                        Aura* aura = iter->second;
                        if (SpellInfo const* triggeredByAuraSpellInfo = aura->GetTriggeredByAuraSpellInfo())
                        {
                            if (triggeredByAuraSpellInfo->Id == oldGlyphEntry->SpellId)
                            {
                                player->RemoveOwnedAura(iter);
                                continue;
                            }
                        }
                        ++iter;
                    }

                    player->SendLearnPacket(oldGlyphEntry->SpellId, false); // Send packet to properly handle client-side spell tooltips
                }

            player->SendLearnPacket(glyphEntry->SpellId, true); // Send packet to properly handle client-side spell tooltips
            player->CastSpell(m_caster, glyphEntry->SpellId, TriggerCastFlags(TRIGGERED_FULL_MASK & ~(TRIGGERED_IGNORE_SHAPESHIFT | TRIGGERED_IGNORE_CASTER_AURASTATE)));
            player->SetGlyph(m_glyphIndex, glyph, !player->GetSession()->PlayerLoading());
            player->SendTalentsInfoData(false);
        }
    }
}

void Spell::EffectEnchantHeldItem(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    // this is only item spell effect applied to main-hand weapon of target player (players in area)
    if (!unitTarget)
        return;

    Player* item_owner = unitTarget->ToPlayer();
    if (!item_owner)
    {
        return;
    }

    Item* item = item_owner->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
    if (!item)
        return;

    // must be equipped
    if (!item->IsEquipped())
        return;

    if (m_spellInfo->Effects[effIndex].MiscValue)
    {
        uint32 enchant_id = m_spellInfo->Effects[effIndex].MiscValue;
        int32 duration = m_spellInfo->GetDuration();          //Try duration index first ..
        if (!duration)
            duration = damage * IN_MILLISECONDS; //+1;            //Base points after ..
        if (!duration)
            duration = 10 * IN_MILLISECONDS;                   //10 seconds for enchants which don't have listed duration

        // Xinef: Venomhide poison, no other spell uses this effect...
        if (m_spellInfo->Id == 14792)
            duration = 5 * MINUTE * IN_MILLISECONDS;

        SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!pEnchant)
            return;

        // Always go to temp enchantment slot
        EnchantmentSlot slot = TEMP_ENCHANTMENT_SLOT;

        // Enchantment will not be applied if a different one already exists
        if (item->GetEnchantmentId(slot) && item->GetEnchantmentId(slot) != enchant_id)
            return;

        // Apply the temporary enchantment
        item->SetEnchantment(slot, enchant_id, duration, pEnchant->charges, m_caster->GetGUID());
        item_owner->ApplyEnchantment(item, slot, true);
    }
}

void Spell::EffectDisEnchant(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!itemTarget || !itemTarget->GetTemplate()->DisenchantID)
        return;

    if (Player* caster = m_caster->ToPlayer())
    {
        caster->UpdateCraftSkill(m_spellInfo->Id);
        caster->SendLoot(itemTarget->GetGUID(), LOOT_DISENCHANTING);
    }

    // item will be removed at disenchanting end
}

void Spell::EffectInebriate(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint8 currentDrunk = player->GetDrunkValue();
    int32 drunkMod = damage;

    if (drunkMod == 0)
        return;

    // drunkMod may contain values ​​that are guaranteed to cause uint8 overflow/underflow (examples: 29690, 46874)
    // In addition, we would not want currentDrunk to become more than 100.
    // So before adding the values, let's check that everything is fine.
    if (drunkMod > 0 && drunkMod > static_cast<int32>(100 - currentDrunk))
        currentDrunk = 100;
    else if (drunkMod < 0 && drunkMod < static_cast<int32>(0 - currentDrunk))
        currentDrunk = 0;
    else
        currentDrunk += drunkMod; // Due to previous checks we can be sure that currentDrunk will not go beyond [0-100] range.

    player->SetDrunkValue(currentDrunk, m_CastItem ? m_CastItem->GetEntry() : 0);

    if (currentDrunk == 100 && roll_chance_i(25))
        player->CastSpell(player, 67468, false);    // Drunken Vomit
}

void Spell::EffectFeedPet(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    Player* player = m_caster->ToPlayer();
    if (!player)
        return;

    Item* foodItem = itemTarget;
    if (!foodItem)
        return;

    Pet* pet = player->GetPet();
    if (!pet)
        return;

    if (!pet->IsAlive())
        return;

    int32 benefit = pet->GetCurrentFoodBenefitLevel(foodItem->GetTemplate()->ItemLevel);
    if (benefit <= 0)
        return;

    ExecuteLogEffectDestroyItem(effIndex, foodItem->GetEntry());

    uint32 count = 1;
    player->DestroyItemCount(foodItem, count, true);
    /// @todo: fix crash when a spell has two effects, both pointed at the same item target

    m_caster->CastCustomSpell(pet, m_spellInfo->Effects[effIndex].TriggerSpell, &benefit, nullptr, nullptr, true);
}

void Spell::EffectDismissPet(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || !unitTarget->IsPet())
        return;

    Pet* pet = unitTarget->ToPet();

    ExecuteLogEffectUnsummonObject(effIndex, pet);
    pet->Remove(PET_SAVE_NOT_IN_SLOT);
}

void Spell::EffectSummonObject(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    uint32 gameobjectId = m_spellInfo->Effects[effIndex].MiscValue;

    uint8 slot = 0;
    switch (m_spellInfo->Effects[effIndex].Effect)
    {
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT1:
            slot = 0;
            break;
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT2:
            slot = 1;
            break;
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT3:
            slot = 2;
            break;
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT4:
            slot = 3;
            break;
        default:
            return;
    }

    if (m_caster)
    {
        ObjectGuid guid = m_caster->m_ObjectSlot[slot];
        if (guid)
        {
            if (GameObject* gameObject = m_caster->GetMap()->GetGameObject(guid))
            {
                // Recast case - null spell id to make auras not be removed on object remove from world
                if (m_spellInfo->Id == gameObject->GetSpellId())
                    gameObject->SetSpellId(0);
                m_caster->RemoveGameObject(gameObject, true);
            }
            m_caster->m_ObjectSlot[slot].Clear();
        }
    }

    GameObject* pGameObj = sObjectMgr->IsGameObjectStaticTransport(gameobjectId) ? new StaticTransport() : new GameObject();

    float x, y, z;
    // If dest location if present
    if (m_targets.HasDst())
        destTarget->GetPosition(x, y, z);
    // Summon in random point all other units if location present
    else
        m_caster->GetClosePoint(x, y, z, DEFAULT_WORLD_OBJECT_SIZE);

    Map* map = m_caster->GetMap();
    if (!pGameObj->Create(map->GenerateLowGuid<HighGuid::GameObject>(), gameobjectId, map, m_caster->GetPhaseMask(), x, y, z, m_caster->GetOrientation(), G3D::Quat(), 0, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    //pGameObj->SetUInt32Value(GAMEOBJECT_LEVEL, m_caster->GetLevel());
    int32 duration = m_spellInfo->GetDuration();
    pGameObj->SetRespawnTime(duration > 0 ? duration / IN_MILLISECONDS : 0);
    pGameObj->SetSpellId(m_spellInfo->Id);
    m_caster->AddGameObject(pGameObj);

    ExecuteLogEffectSummonObject(effIndex, pGameObj);

    map->AddToMap(pGameObj, true);

    m_caster->m_ObjectSlot[slot] = pGameObj->GetGUID();
}

void Spell::EffectResurrect(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (!unitTarget)
        return;

    Player* target = unitTarget->ToPlayer();
    if (!target)
    {
        return;
    }

    if (unitTarget->IsAlive() || !unitTarget->IsInWorld())
        return;

    if (target->isResurrectRequested())       // already have one active request
        return;

    uint32 health = target->CountPctFromMaxHealth(damage);
    uint32 mana   = CalculatePct(target->GetMaxPower(POWER_MANA), damage);

    ExecuteLogEffectResurrect(effIndex, target);

    target->setResurrectRequestData(m_caster->GetGUID(), m_caster->GetMapId(), m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), health, mana);
    SendResurrectRequest(target);
}

void Spell::EffectAddExtraAttacks(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
    {
        return;
    }

    if (!unitTarget || !unitTarget->IsAlive())
    {
        return;
    }

    unitTarget->AddExtraAttacks(damage);

    ExecuteLogEffectExtraAttacks(effIndex, unitTarget, damage);
}

void Spell::EffectParry(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
        m_caster->ToPlayer()->SetCanParry(true);
}

void Spell::EffectBlock(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
        m_caster->ToPlayer()->SetCanBlock(true);
}

void Spell::EffectLeap(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || unitTarget->IsInFlight())
        return;

    if (!m_targets.HasDst())
        return;

    Position dstpos = destTarget->GetPosition();
    unitTarget->NearTeleportTo(dstpos.GetPositionX(), dstpos.GetPositionY(), dstpos.GetPositionZ(), dstpos.GetOrientation(), unitTarget == m_caster);
}

void Spell::EffectReputation(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    float repChange = static_cast<float>(damage);

    uint32 factionId = m_spellInfo->Effects[effIndex].MiscValue;

    FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionId);
    if (!factionEntry)
        return;

    repChange = player->CalculateReputationGain(REPUTATION_SOURCE_SPELL, 0, repChange, factionId);
    player->GetReputationMgr().ModifyReputation(factionEntry, repChange);
}

void Spell::EffectQuestComplete(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint32 questId = m_spellInfo->Effects[effIndex].MiscValue;
    if (questId)
    {
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            return;

        uint16 logSlot = player->FindQuestSlot(questId);
        if (logSlot < MAX_QUEST_LOG_SIZE)
            player->AreaExploredOrEventHappens(questId);
        else if (player->CanTakeQuest(quest, false))    // never rewarded before
            player->CompleteQuest(questId);             // quest not in log - for internal use
    }
}

void Spell::EffectForceDeselect(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    // xinef: clear focus
    m_caster->SendClearTarget();

    WorldPacket data(SMSG_CLEAR_TARGET, 8);
    data << m_caster->GetGUID();

    float dist = m_caster->GetVisibilityRange() + VISIBILITY_COMPENSATION;
    Acore::MessageDistDelivererToHostile notifier(m_caster, &data, dist);
    Cell::VisitWorldObjects(m_caster, notifier, dist);

    // xinef: we should also force pets to remove us from current target
    Unit::AttackerSet attackerSet;
    for (Unit::AttackerSet::const_iterator itr = m_caster->getAttackers().begin(); itr != m_caster->getAttackers().end(); ++itr)
        if ((*itr)->GetTypeId() == TYPEID_UNIT && !(*itr)->CanHaveThreatList())
            attackerSet.insert(*itr);

    for (Unit::AttackerSet::const_iterator itr = attackerSet.begin(); itr != attackerSet.end(); ++itr)
        (*itr)->AttackStop();

    // Xinef: Mirror images code Initialize Images
    if (m_spellInfo->Id == 58836)
    {
        std::vector<Unit*> images;
        for (Unit::ControlSet::const_iterator itr = m_caster->m_Controlled.begin(); itr != m_caster->m_Controlled.end(); ++itr)
            if ((*itr)->GetEntry() == 31216 /*NPC_MIRROR_IMAGE*/)
                images.push_back(*itr);

        if (images.empty())
            return;

        UnitList targets;
        Acore::AnyUnfriendlyUnitInObjectRangeCheck u_check(m_caster, m_caster, m_caster->GetVisibilityRange()); // no VISIBILITY_COMPENSATION, distance is enough
        Acore::UnitListSearcher<Acore::AnyUnfriendlyUnitInObjectRangeCheck> searcher(m_caster, targets, u_check);
        Cell::VisitAllObjects(m_caster, searcher, m_caster->GetVisibilityRange());
        for (UnitList::iterator iter = targets.begin(); iter != targets.end(); ++iter)
        {
            if (!(*iter)->HasUnitState(UNIT_STATE_CASTING))
                continue;

            if (Spell* spell = (*iter)->GetCurrentSpell(CURRENT_GENERIC_SPELL))
            {
                if (spell->m_targets.GetUnitTargetGUID() == m_caster->GetGUID())
                {
                    SpellInfo const* si = spell->GetSpellInfo();
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
                        spell->m_targets.SetUnitTarget(images.at(urand(0, images.size() - 1)));
                }
            }
        }
    }
}

void Spell::EffectSelfResurrect(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (!m_caster || m_caster->IsAlive())
        return;
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;
    if (!m_caster->IsInWorld())
        return;

    uint32 health = 0;
    uint32 mana = 0;

    // flat case
    if (damage < 0)
    {
        health = uint32(-damage);
        mana = m_spellInfo->Effects[effIndex].MiscValue;
    }
    // percent case
    else
    {
        health = m_caster->CountPctFromMaxHealth(damage);
        if (m_caster->GetMaxPower(POWER_MANA) > 0)
            mana = CalculatePct(m_caster->GetMaxPower(POWER_MANA), damage);
    }

    Player* player = m_caster->ToPlayer();
    player->ResurrectPlayer(0.0f);

    player->SetHealth(health);
    player->SetPower(POWER_MANA, mana);
    player->SetPower(POWER_RAGE, 0);
    player->SetPower(POWER_ENERGY, player->GetMaxPower(POWER_ENERGY));

    player->SpawnCorpseBones();
}

void Spell::EffectSkinning(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (unitTarget->GetTypeId() != TYPEID_UNIT)
        return;
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Creature* creature = unitTarget->ToCreature();
    int32 targetLevel = creature->GetLevel();

    uint32 skill = creature->GetCreatureTemplate()->GetRequiredLootSkill();

    creature->RemoveUnitFlag(UNIT_FLAG_SKINNABLE);
    creature->SetDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
    m_caster->ToPlayer()->SendLoot(creature->GetGUID(), LOOT_SKINNING);

    int32 reqValue = targetLevel < 10 ? 0 : targetLevel < 20 ? (targetLevel - 10) * 10 : targetLevel * 5;

    int32 skillValue = m_caster->ToPlayer()->GetPureSkillValue(skill);

    // Double chances for elites
    m_caster->ToPlayer()->UpdateGatherSkill(skill, skillValue, reqValue, creature->isElite() ? 2 : 1);
}

void Spell::EffectCharge(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode == SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
    {
        if (!unitTarget)
            return;

        ObjectGuid targetGUID = ObjectGuid::Empty;
        Player* player = m_caster->ToPlayer();
        if (player)
        {
            // charge changes fall time
            player->SetFallInformation(GameTime::GetGameTime().count(), m_caster->GetPositionZ());

            if (!m_spellInfo->HasAttribute(SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT) && !m_spellInfo->IsPositive() && m_caster->GetTarget() == unitTarget->GetGUID())
            {
                targetGUID = unitTarget->GetGUID();
            }
        }

        float speed = G3D::fuzzyGt(m_spellInfo->Speed, 0.0f) ? m_spellInfo->Speed : SPEED_CHARGE;
        // Spell is not using explicit target - no generated path
        if (!m_preGeneratedPath)
        {
            Position pos = unitTarget->GetFirstCollisionPosition(unitTarget->GetCombatReach(), unitTarget->GetRelativeAngle(m_caster));
            m_caster->GetMotionMaster()->MoveCharge(pos.m_positionX, pos.m_positionY, pos.m_positionZ, speed, EVENT_CHARGE, nullptr, false, 0.0f, targetGUID);
        }
        else
        {
            m_caster->GetMotionMaster()->MoveCharge(*m_preGeneratedPath, speed, targetGUID);
        }

        if (player)
        {
            sScriptMgr->AnticheatSetUnderACKmount(player);
        }
    }
}

void Spell::EffectChargeDest(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH)
        return;

    if (m_targets.HasDst())
    {
        Position pos = destTarget->GetPosition();

        if (!m_caster->IsWithinLOS(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()))
        {
            float angle = m_caster->GetRelativeAngle(pos.GetPositionX(), pos.GetPositionY());
            float dist = m_caster->GetDistance(pos);
            pos = m_caster->GetFirstCollisionPosition(dist, angle);
        }

        m_caster->GetMotionMaster()->MoveCharge(pos.m_positionX, pos.m_positionY, pos.m_positionZ);

        if (m_caster->GetTypeId() == TYPEID_PLAYER)
        {
            sScriptMgr->AnticheatSetUnderACKmount(m_caster->ToPlayer());
        }
    }
}

void Spell::EffectKnockBack(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    // Xinef: allow entry specific spells to skip those checks
    if (m_spellInfo->Effects[effIndex].TargetA.GetCheckType() != TARGET_CHECK_ENTRY && m_spellInfo->Effects[effIndex].TargetB.GetCheckType() != TARGET_CHECK_ENTRY)
    {
        if (unitTarget->IsVehicle() && unitTarget->GetCreatureType() != CREATURE_TYPE_BEAST)
            return;

        if (unitTarget->GetVehicle())
            return;

        if (Creature* creatureTarget = unitTarget->ToCreature())
            if (creatureTarget->isWorldBoss() || creatureTarget->IsDungeonBoss() || creatureTarget->IsImmuneToKnockback() || unitTarget->ToCreature()->GetCreatureType() == CREATURE_TYPE_GIANT)
                return;
    }

    // Spells with SPELL_EFFECT_KNOCK_BACK(like Thunderstorm) can't knoback target if target has ROOT
    if (unitTarget->HasUnitState(UNIT_STATE_ROOT))
        return;

    // Instantly interrupt non melee spells being casted
    if (unitTarget->IsNonMeleeSpellCast(true))
        unitTarget->InterruptNonMeleeSpells(true);

    float ratio = 0.1f;
    float speedxy = float(m_spellInfo->Effects[effIndex].MiscValue) * ratio;
    float speedz = float(damage) * ratio;
    if (speedxy <= 0.1f && speedz <= 0.1f)
        return;

    float x, y;
    if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_KNOCK_BACK_DEST)
    {
        if (m_targets.HasDst())
            destTarget->GetPosition(x, y);
        else
            return;
    }
    else //if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_KNOCK_BACK)
    {
        m_caster->GetPosition(x, y);
    }

    unitTarget->KnockbackFrom(x, y, speedxy, speedz);

    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
    {
        sScriptMgr->AnticheatSetUnderACKmount(unitTarget->ToPlayer());
    }
}

void Spell::EffectLeapBack(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH_TARGET)
        return;

    if (!unitTarget)
        return;

    float speedxy = m_spellInfo->Effects[effIndex].MiscValue / 10.0f;
    float speedz = damage / 10.0f;
    //1891: Disengage
    m_caster->JumpTo(speedxy, speedz, m_spellInfo->SpellFamilyName != SPELLFAMILY_HUNTER);

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        sScriptMgr->AnticheatSetUnderACKmount(m_caster->ToPlayer());
    }

    // xinef: changes fall time
    if (m_caster->GetTypeId() == TYPEID_PLAYER)
        m_caster->ToPlayer()->SetFallInformation(GameTime::GetGameTime().count(), m_caster->GetPositionZ());
}

void Spell::EffectQuestClear(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint32 quest_id = m_spellInfo->Effects[effIndex].MiscValue;

    Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);

    if (!quest)
        return;

    // Player has never done this quest
    if (player->GetQuestStatus(quest_id) == QUEST_STATUS_NONE)
        return;

    // remove all quest entries for 'entry' from quest log
    for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
    {
        uint32 logQuest = player->GetQuestSlotQuestId(slot);
        if (logQuest == quest_id)
        {
            player->SetQuestSlot(slot, 0);

            // we ignore unequippable quest items in this case, it's still be equipped
            player->TakeQuestSourceItem(logQuest, false);

            if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
            {
                player->pvpInfo.IsHostile = player->pvpInfo.IsInHostileArea || player->HasPvPForcingQuest();
                player->UpdatePvPState();
            }
        }
    }

    player->RemoveRewardedQuest(quest_id);
    player->RemoveActiveQuest(quest_id, false);
}

void Spell::EffectSendTaxi(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (Player* player = unitTarget->ToPlayer())
    {
        player->ActivateTaxiPathTo(m_spellInfo->Effects[effIndex].MiscValue, m_spellInfo->Id);
    }
}

void Spell::EffectPullTowards(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Position pos;
    if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_PULL_TOWARDS_DEST)
    {
        if (m_targets.HasDst())
            pos.Relocate(*destTarget);
        else
            return;
    }
    else //if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_PULL_TOWARDS)
    {
        // Xinef: Increase Z position a little bit, should protect from falling through textures
        pos.Relocate(m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ() + 1.0f, m_caster->GetOrientation());
    }

    float speedXY = float(m_spellInfo->Effects[effIndex].MiscValue) ? float(m_spellInfo->Effects[effIndex].MiscValue) * 0.1f : 30.f;
    float speedZ = unitTarget->GetDistance(pos) / speedXY * 0.5f * Movement::gravity;

    unitTarget->GetMotionMaster()->MoveJump(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), speedXY, speedZ);

    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
    {
        sScriptMgr->AnticheatSetUnderACKmount(unitTarget->ToPlayer());
    }
}

void Spell::EffectDispelMechanic(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    uint32 mechanic = m_spellInfo->Effects[effIndex].MiscValue;

    std::queue<std::pair<uint32, ObjectGuid>> dispel_list;

    Unit::AuraMap const& auras = unitTarget->GetOwnedAuras();
    for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
    {
        Aura* aura = itr->second;
        if (!aura->GetApplicationOfTarget(unitTarget->GetGUID()))
            continue;
        if (roll_chance_i(aura->CalcDispelChance(unitTarget, !unitTarget->IsFriendlyTo(m_caster))))
        {
            if ((aura->GetSpellInfo()->GetAllEffectsMechanicMask() & (1 << mechanic)))
            {
                dispel_list.push(std::make_pair(aura->GetId(), aura->GetCasterGUID()));

                // spell only removes 1 bleed effect do not continue
                if (m_spellInfo->Effects[effIndex].BasePoints == 1)
                {
                    break;
                }
            }
        }
    }

    for (; dispel_list.size(); dispel_list.pop())
    {
        unitTarget->RemoveAura(dispel_list.front().first, dispel_list.front().second, 0, AURA_REMOVE_BY_ENEMY_SPELL);
    }

    // put in combat
    if (unitTarget->IsFriendlyTo(m_caster))
        unitTarget->getHostileRefMgr().threatAssist(m_caster, 0.0f, m_spellInfo);
}

void Spell::EffectResurrectPet(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (damage < 0)
        return;

    Player* player = m_caster->ToPlayer();
    if (!player)
    {
        return;
    }

    Pet* pet = player->GetPet();
    if (!pet)
    {
        // Position passed to SummonPet is irrelevant with current implementation,
        // pet will be relocated without using these coords in Pet::LoadPetFromDB
        player->SummonPet(0, 0.0f, 0.0f, 0.0f, 0.0f, SUMMON_PET, 0s, damage);
        return;
    }

    /// @todo: Better to fail Hunter's "Revive Pet" at cast instead of here when casting ends
    if (pet->IsAlive())
    {
        return;
    }

    // Reposition the pet's corpse before reviving so as not to grab aggro
    // We can use a different, more accurate version of GetClosePoint() since we have a pet
    float x, y, z; // Will be used later to reposition the pet if we have one
    player->GetClosePoint(x, y, z, pet->GetCombatReach(), PET_FOLLOW_DIST, pet->GetFollowAngle());
    pet->NearTeleportTo(x, y, z, player->GetOrientation());
    pet->Relocate(x, y, z, player->GetOrientation()); // This is needed so SaveStayPosition() will get the proper coords.
    pet->ReplaceAllDynamicFlags(UNIT_DYNFLAG_NONE);
    pet->RemoveUnitFlag(UNIT_FLAG_SKINNABLE);
    pet->setDeathState(DeathState::Alive);
    pet->ClearUnitState(uint32(UNIT_STATE_ALL_STATE & ~(UNIT_STATE_POSSESSED))); // xinef: just in case
    pet->SetHealth(pet->CountPctFromMaxHealth(damage));
    pet->SetDisplayId(pet->GetNativeDisplayId());

    // xinef: restore movement
    if (auto ci = pet->GetCharmInfo())
    {
        ci->SetIsAtStay(false);
        ci->SetIsFollowing(false);
    }

    pet->SavePetToDB(PET_SAVE_AS_CURRENT);
}

void Spell::EffectDestroyAllTotems(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    int32 mana = 0;
    for (uint8 slot = SUMMON_SLOT_TOTEM; slot < MAX_TOTEM_SLOT; ++slot)
    {
        if (!m_caster->m_SummonSlot[slot])
            continue;

        Creature* totem = m_caster->GetMap()->GetCreature(m_caster->m_SummonSlot[slot]);
        if (totem && totem->IsTotem())
        {
            uint32 spell_id = totem->GetUInt32Value(UNIT_CREATED_BY_SPELL);
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id);
            if (spellInfo)
            {
                mana += spellInfo->ManaCost;
                mana += int32(CalculatePct(m_caster->GetCreateMana(), spellInfo->ManaCostPercentage));
            }
            totem->ToTotem()->UnSummon();
        }
    }
    ApplyPct(mana, damage);
    if (mana)
        m_caster->CastCustomSpell(m_caster, 39104, &mana, nullptr, nullptr, true);
}

void Spell::EffectDurabilityDamage(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    int32 slot = m_spellInfo->Effects[effIndex].MiscValue;

    // -1 means all player equipped items and -2 all items
    if (slot < 0)
    {
        player->DurabilityPointsLossAll(damage, (slot < -1));
        ExecuteLogEffectDurabilityDamage(effIndex, unitTarget, -1, -1);
        return;
    }

    // invalid slot value
    if (slot >= INVENTORY_SLOT_BAG_END)
        return;

    if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
    {
        player->DurabilityPointsLoss(item, damage);
        ExecuteLogEffectDurabilityDamage(effIndex, unitTarget, item->GetEntry(), slot);
    }
}

void Spell::EffectDurabilityDamagePCT(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    int32 slot = m_spellInfo->Effects[effIndex].MiscValue;

    // FIXME: some spells effects have value -1/-2
    // Possibly its mean -1 all player equipped items and -2 all items
    if (slot < 0)
    {
        player->DurabilityLossAll(float(damage) / 100.0f, (slot < -1));
        return;
    }

    // invalid slot value
    if (slot >= INVENTORY_SLOT_BAG_END)
        return;

    if (damage <= 0)
        return;

    if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
        player->DurabilityLoss(item, float(damage) / 100.0f);
}

void Spell::EffectModifyThreatPercent(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    unitTarget->GetThreatMgr().ModifyThreatByPercent(m_caster, damage);
}

void Spell::EffectTransmitted(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    uint32 name_id = m_spellInfo->Effects[effIndex].MiscValue;

    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(name_id);

    if (!goinfo)
    {
        LOG_ERROR("sql.sql", "Gameobject (Entry: {}) not exist and not created at spell (ID: {}) cast", name_id, m_spellInfo->Id);
        return;
    }

    float fx, fy, fz;

    if (m_targets.HasDst())
        destTarget->GetPosition(fx, fy, fz);
    //FIXME: this can be better check for most objects but still hack
    else if (m_spellInfo->Effects[effIndex].HasRadius() && m_spellInfo->Speed == 0)
    {
        float dis = m_spellInfo->Effects[effIndex].CalcRadius(m_originalCaster);
        m_caster->GetClosePoint(fx, fy, fz, DEFAULT_WORLD_OBJECT_SIZE, dis);
    }
    else
    {
        //GO is always friendly to it's creator, get range for friends
        float min_dis = m_spellInfo->GetMinRange(true);
        float max_dis = m_spellInfo->GetMaxRange(true);
        float dis = (float)rand_norm() * (max_dis - min_dis) + min_dis;

        m_caster->GetClosePoint(fx, fy, fz, DEFAULT_WORLD_OBJECT_SIZE, dis);
    }

    // Seaforium charge
    if (m_spellInfo->Id == 52410 || m_spellInfo->Id == 66268 || m_spellInfo->Id == 66674) // SotA / IoC / IoC Huge
    {
        fx = m_caster->GetPositionX();
        fy = m_caster->GetPositionY();
        fz = m_caster->GetPositionZ();
    }

    Map* cMap = m_caster->GetMap();
    // if gameobject is summoning object, it should be spawned right on caster's position
    if (goinfo->type == GAMEOBJECT_TYPE_SUMMONING_RITUAL)
        m_caster->GetPosition(fx, fy, fz);

    GameObject* pGameObj = sObjectMgr->IsGameObjectStaticTransport(name_id) ? new StaticTransport() : new GameObject();

    if (!pGameObj->Create(cMap->GenerateLowGuid<HighGuid::GameObject>(), name_id, cMap, m_caster->GetPhaseMask(), fx, fy, fz, m_caster->GetOrientation(), G3D::Quat(), 100, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    int32 duration = m_spellInfo->GetDuration();

    switch (goinfo->type)
    {
        case GAMEOBJECT_TYPE_FISHINGNODE:
            {
                m_caster->SetGuidValue(UNIT_FIELD_CHANNEL_OBJECT, pGameObj->GetGUID());
                m_caster->AddGameObject(pGameObj);              // will removed at spell cancel

                // end time of range when possible catch fish (FISHING_BOBBER_READY_TIME..GetDuration(m_spellInfo))
                // start time == fish-FISHING_BOBBER_READY_TIME (0..GetDuration(m_spellInfo)-FISHING_BOBBER_READY_TIME)
                int32 lastSec = 0;
                switch (urand(0, 2))
                {
                    case 0:
                        lastSec =  3;
                        break;
                    case 1:
                        lastSec =  7;
                        break;
                    case 2:
                        lastSec = 13;
                        break;
                }

                // Duration of the fishing bobber can't be higher than the Fishing channeling duration
                duration = std::min(duration, duration - lastSec*IN_MILLISECONDS + FISHING_BOBBER_READY_TIME*IN_MILLISECONDS);

                break;
            }
        case GAMEOBJECT_TYPE_SUMMONING_RITUAL:
            {
                if (m_caster->GetTypeId() == TYPEID_PLAYER)
                {
                    pGameObj->AddUniqueUse(m_caster->ToPlayer());
                    m_caster->AddGameObject(pGameObj);      // will be removed at spell cancel
                }
                break;
            }
        case GAMEOBJECT_TYPE_DUEL_ARBITER: // 52991
            m_caster->AddGameObject(pGameObj);
            break;
        case GAMEOBJECT_TYPE_FISHINGHOLE:
        case GAMEOBJECT_TYPE_CHEST:
        default:
            break;
    }

    pGameObj->SetRespawnTime(duration > 0 ? duration / IN_MILLISECONDS : 0);

    pGameObj->SetOwnerGUID(m_caster->GetGUID());

    //pGameObj->SetUInt32Value(GAMEOBJECT_LEVEL, m_caster->GetLevel());
    pGameObj->SetSpellId(m_spellInfo->Id);

    ExecuteLogEffectSummonObject(effIndex, pGameObj);

    LOG_DEBUG("spells.effect", "AddObject at SpellEfects.cpp EffectTransmitted");
    //m_caster->AddGameObject(pGameObj);
    //m_ObjToDel.push_back(pGameObj);

    cMap->AddToMap(pGameObj, true);

    if (GameObject* linkedTrap = pGameObj->GetLinkedTrap())
    {
        linkedTrap->SetRespawnTime(duration > 0 ? duration / IN_MILLISECONDS : 0);
        linkedTrap->SetSpellId(m_spellInfo->Id);
        linkedTrap->SetOwnerGUID(m_caster->GetGUID());

        ExecuteLogEffectSummonObject(effIndex, linkedTrap);
    }

    if (Player* player = m_caster->ToPlayer())
    {
        player->SetCanTeleport(true);
    }
}

void Spell::EffectProspecting(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* p_caster = m_caster->ToPlayer();
    if (!itemTarget || !(itemTarget->GetTemplate()->Flags & ITEM_FLAG_IS_PROSPECTABLE))
        return;

    if (itemTarget->GetCount() < 5)
        return;

    if (sWorld->getBoolConfig(CONFIG_SKILL_PROSPECTING))
    {
        uint32 SkillValue = p_caster->GetPureSkillValue(SKILL_JEWELCRAFTING);
        uint32 reqSkillValue = itemTarget->GetTemplate()->RequiredSkillRank;
        p_caster->UpdateGatherSkill(SKILL_JEWELCRAFTING, SkillValue, reqSkillValue);
    }

    m_caster->ToPlayer()->SendLoot(itemTarget->GetGUID(), LOOT_PROSPECTING);
}

void Spell::EffectMilling(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* p_caster = m_caster->ToPlayer();
    if (!itemTarget || !(itemTarget->GetTemplate()->Flags & ITEM_FLAG_IS_MILLABLE))
        return;

    if (itemTarget->GetCount() < 5)
        return;

    if (sWorld->getBoolConfig(CONFIG_SKILL_MILLING))
    {
        uint32 SkillValue = p_caster->GetPureSkillValue(SKILL_INSCRIPTION);
        uint32 reqSkillValue = itemTarget->GetTemplate()->RequiredSkillRank;
        p_caster->UpdateGatherSkill(SKILL_INSCRIPTION, SkillValue, reqSkillValue);
    }

    m_caster->ToPlayer()->SendLoot(itemTarget->GetGUID(), LOOT_MILLING);
}

void Spell::EffectSkill(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    LOG_DEBUG("spells.aura", "WORLD: SkillEFFECT");
}

/* There is currently no need for this effect. We handle it in Battleground.cpp
   If we would handle the resurrection here, the spiritguide would instantly disappear as the
   player revives, and so we wouldn't see the spirit heal visual effect on the npc.
   This is why we use a half sec delay between the visual effect and the resurrection itself */
void Spell::EffectSpiritHeal(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    /*
    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;
    if (!unitTarget->IsInWorld())
        return;

    //m_spellInfo->Effects[i].BasePoints; == 99 (percent?)
    //unitTarget->ToPlayer()->setResurrect(m_caster->GetGUID(), unitTarget->GetPositionX(), unitTarget->GetPositionY(), unitTarget->GetPositionZ(), unitTarget->GetMaxHealth(), unitTarget->GetMaxPower(POWER_MANA));
    unitTarget->ToPlayer()->ResurrectPlayer(1.0f);
    unitTarget->ToPlayer()->SpawnCorpseBones();
    */
}

// remove insignia spell effect
void Spell::EffectSkinPlayerCorpse(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    LOG_DEBUG("spells.aura", "Effect: SkinPlayerCorpse");
    if ((m_caster->GetTypeId() != TYPEID_PLAYER) || (unitTarget->GetTypeId() != TYPEID_PLAYER) || (unitTarget->IsAlive()))
        return;

    unitTarget->ToPlayer()->RemovedInsignia(m_caster->ToPlayer());
}

void Spell::EffectStealBeneficialBuff(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    LOG_DEBUG("spells.aura", "Effect: StealBeneficialBuff");

    if (!unitTarget || unitTarget == m_caster)                 // can't steal from self
        return;

    DispelChargesList steal_list;

    // Create dispel mask by dispel type
    uint32 dispelMask  = SpellInfo::GetDispelMask(DispelType(m_spellInfo->Effects[effIndex].MiscValue));
    Unit::AuraMap const& auras = unitTarget->GetOwnedAuras();
    for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
    {
        Aura* aura = itr->second;
        AuraApplication* aurApp = aura->GetApplicationOfTarget(unitTarget->GetGUID());
        if (!aurApp)
            continue;

        if ((aura->GetSpellInfo()->GetDispelMask()) & dispelMask)
        {
            // Need check for passive? this
            if (!aurApp->IsPositive() || aura->IsPassive() || aura->GetSpellInfo()->HasAttribute(SPELL_ATTR4_CANNOT_BE_STOLEN))
                continue;

            // The charges / stack amounts don't count towards the total number of auras that can be dispelled.
            // Ie: A dispel on a target with 5 stacks of Winters Chill and a Polymorph has 1 / (1 + 1) -> 50% chance to dispell
            // Polymorph instead of 1 / (5 + 1) -> 16%.
            bool dispel_charges = aura->GetSpellInfo()->HasAttribute(SPELL_ATTR7_DISPEL_REMOVES_CHARGES);
            uint8 charges = dispel_charges ? aura->GetCharges() : aura->GetStackAmount();
            if (charges > 0)
                steal_list.push_back(std::make_pair(aura, charges));
        }
    }

    if (steal_list.empty())
        return;

    // Ok if exist some buffs for dispel try dispel it
    uint32 failCount = 0;
    DispelList success_list;
    WorldPacket dataFail(SMSG_DISPEL_FAILED, 8 + 8 + 4 + 4 + damage * 4);
    // dispel N = damage buffs (or while exist buffs for dispel)
    for (int32 count = 0; count < damage && !steal_list.empty();)
    {
        // Random select buff for dispel
        DispelChargesList::iterator itr = steal_list.begin();
        std::advance(itr, urand(0, steal_list.size() - 1));

        int32 chance = itr->first->CalcDispelChance(unitTarget, !unitTarget->IsFriendlyTo(m_caster));
        // 2.4.3 Patch Notes: "Dispel effects will no longer attempt to remove effects that have 100% dispel resistance."
        if (!chance)
        {
            steal_list.erase(itr);
            continue;
        }
        else
        {
            if (roll_chance_i(chance))
            {
                success_list.push_back(std::make_pair(itr->first->GetId(), itr->first->GetCasterGUID()));
                --itr->second;
                if (itr->second <= 0)
                    steal_list.erase(itr);
            }
            else
            {
                if (!failCount)
                {
                    // Failed to dispell
                    dataFail << m_caster->GetGUID();                    // Caster GUID
                    dataFail << unitTarget->GetGUID();                  // Victim GUID
                    dataFail << uint32(m_spellInfo->Id);                // dispel spell id
                }
                ++failCount;
                dataFail << uint32(itr->first->GetId());                // Spell Id
            }
            ++count;
        }
    }

    if (failCount)
        m_caster->SendMessageToSet(&dataFail, true);

    if (success_list.empty())
        return;

    WorldPacket dataSuccess(SMSG_SPELLSTEALLOG, 8 + 8 + 4 + 1 + 4 + damage * 5);
    dataSuccess << unitTarget->GetPackGUID();       // Victim GUID
    dataSuccess << m_caster->GetPackGUID();         // Caster GUID
    dataSuccess << uint32(m_spellInfo->Id);         // dispel spell id
    dataSuccess << uint8(0);                        // not used
    dataSuccess << uint32(success_list.size());     // count
    for (DispelList::iterator itr = success_list.begin(); itr != success_list.end(); ++itr)
    {
        dataSuccess << uint32(itr->first);          // Spell Id
        dataSuccess << uint8(0);                    // 0 - steals !=0 transfers
        unitTarget->RemoveAurasDueToSpellBySteal(itr->first, itr->second, m_caster);
    }
    m_caster->SendMessageToSet(&dataSuccess, true);
}

void Spell::EffectKillCreditPersonal(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (Player* player = unitTarget->GetCharmerOrOwnerPlayerOrPlayerItself())
    {
        player->KilledMonsterCredit(m_spellInfo->Effects[effIndex].MiscValue);
    }
}

void Spell::EffectKillCredit(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (!player)
    {
        return;
    }

    int32 creatureEntry = m_spellInfo->Effects[effIndex].MiscValue;
    if (!creatureEntry)
    {
        if (m_spellInfo->Id == 42793) // Burn Body
            creatureEntry = 24008; // Fallen Combatant
    }

    if (creatureEntry)
        player->RewardPlayerAndGroupAtEvent(creatureEntry, unitTarget);
}

void Spell::EffectQuestFail(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (Player* player = unitTarget->ToPlayer())
    {
        player->FailQuest(m_spellInfo->Effects[effIndex].MiscValue);
    }
}

void Spell::EffectQuestStart(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(m_spellInfo->Effects[effIndex].MiscValue))
    {
        if (!player->CanTakeQuest(quest, false))
            return;

        if (quest->IsAutoAccept() && player->CanAddQuest(quest, false))
            player->AddQuestAndCheckCompletion(quest, player);

        player->PlayerTalkClass->SendQuestGiverQuestDetails(quest, player->GetGUID(), true);
    }
}

void Spell::EffectActivateRune(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_LAUNCH)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* player = m_caster->ToPlayer();

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        return;

    // needed later
    m_runesState = m_caster->ToPlayer()->GetRunesState();

    uint32 count = damage;
    if (count == 0) count = 1;
    for (uint32 j = 0; j < MAX_RUNES && count > 0; ++j)
    {
        if (player->GetRuneCooldown(j) && player->GetCurrentRune(j) == RuneType(m_spellInfo->Effects[effIndex].MiscValue))
        {
            if (m_spellInfo->Id == 45529)
                if (player->GetBaseRune(j) != RuneType(m_spellInfo->Effects[effIndex].MiscValueB))
                    continue;
            player->SetRuneCooldown(j, 0);
            player->SetGracePeriod(j, player->IsInCombat()); // xinef: reset grace period
            --count;
        }
    }

    // Blood Tap
    if (m_spellInfo->Id == 45529 && count > 0)
    {
        for (uint32 l = 0; l < MAX_RUNES && count > 0; ++l)
        {
            // Check if both runes are on cd as that is the only time when this needs to come into effect
            if ((player->GetRuneCooldown(l) && player->GetCurrentRune(l) == RuneType(m_spellInfo->Effects[effIndex].MiscValueB)) && (player->GetRuneCooldown(l + 1) && player->GetCurrentRune(l + 1) == RuneType(m_spellInfo->Effects[effIndex].MiscValueB)))
            {
                // Should always update the rune with the lowest cd
                if (player->GetRuneCooldown(l) >= player->GetRuneCooldown(l + 1))
                    l++;
                player->SetRuneCooldown(l, 0);
                player->SetGracePeriod(l, player->IsInCombat()); // xinef: reset grace period
                --count;
            }
            else
                break;
        }
    }

    // Empower rune weapon
    if (m_spellInfo->Id == 47568)
    {
        // Need to do this just once
        if (effIndex != 0)
            return;

        for (uint32 i = 0; i < MAX_RUNES; ++i)
        {
            if (player->GetRuneCooldown(i) && (player->GetCurrentRune(i) == RUNE_FROST ||  player->GetCurrentRune(i) == RUNE_DEATH))
            {
                player->SetRuneCooldown(i, 0);
                player->SetGracePeriod(i, player->IsInCombat()); // xinef: reset grace period
            }
        }
    }

    // is needed to push through to the client that the rune is active
    //player->ResyncRunes(MAX_RUNES);
    m_caster->CastSpell(m_caster, 47804, true);
}

void Spell::EffectCreateTamedPet(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER || unitTarget->GetPetGUID() || !unitTarget->IsClass(CLASS_HUNTER, CLASS_CONTEXT_PET))
        return;

    uint32 creatureEntry = m_spellInfo->Effects[effIndex].MiscValue;
    Pet* pet = unitTarget->CreateTamedPetFrom(creatureEntry, m_spellInfo->Id);
    if (!pet)
        return;

    // add to world
    pet->GetMap()->AddToMap(pet->ToCreature(), true);

    // unitTarget has pet now
    unitTarget->SetMinion(pet, true);

    pet->InitTalentForLevel();

    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
    {
        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
        unitTarget->ToPlayer()->PetSpellInitialize();
    }
}

void Spell::EffectDiscoverTaxi(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint32 nodeid = m_spellInfo->Effects[effIndex].MiscValue;
    if (sTaxiNodesStore.LookupEntry(nodeid))
        player->GetSession()->SendDiscoverNewTaxiNode(nodeid);
}

void Spell::EffectTitanGrip(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        if (Aura* aur = m_caster->GetAura(49152))
            aur->RecalculateAmountOfEffects();
        else
            m_caster->CastSpell(unitTarget, 49152, true); // damage reduction

        m_caster->ToPlayer()->SetCanTitanGrip(true);
    }
}

void Spell::EffectRedirectThreat(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (unitTarget)
        m_caster->SetRedirectThreat(unitTarget->GetGUID(), uint32(damage));
}

void Spell::EffectGameObjectDamage(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!gameObjTarget)
        return;

    Unit* caster = m_originalCaster;
    if (!caster)
        return;

    FactionTemplateEntry const* casterFaction = caster->GetFactionTemplateEntry();
    FactionTemplateEntry const* targetFaction = sFactionTemplateStore.LookupEntry(gameObjTarget->GetUInt32Value(GAMEOBJECT_FACTION));
    // Do not allow to damage GO's of friendly factions (ie: Wintergrasp Walls/Ulduar Storm Beacons)
    if ((casterFaction && targetFaction && !casterFaction->IsFriendlyTo(*targetFaction)) || !targetFaction)
        gameObjTarget->ModifyHealth(-damage, caster, GetSpellInfo()->Id);
}

void Spell::EffectGameObjectRepair(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!gameObjTarget)
        return;

    gameObjTarget->ModifyHealth(damage, m_caster);
}

void Spell::EffectGameObjectSetDestructionState(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!gameObjTarget || !m_originalCaster)
        return;

    Player* player = m_originalCaster->GetCharmerOrOwnerPlayerOrPlayerItself();
    gameObjTarget->SetDestructibleState(GameObjectDestructibleState(m_spellInfo->Effects[effIndex].MiscValue), player, true);
}

void Spell::SummonGuardian(uint32 i, uint32 entry, SummonPropertiesEntry const* properties, uint32 numGuardians, bool personalSpawn)
{
    Unit* caster = m_originalCaster;
    if (!caster)
        return;

    if (caster->IsTotem())
        caster = caster->ToTotem()->GetOwner();

    // in another case summon new
    uint8 summonLevel = caster->GetLevel();

    // level of pet summoned using engineering item based at engineering skill level
    if (m_CastItem && caster->GetTypeId() == TYPEID_PLAYER)
        if (ItemTemplate const* proto = m_CastItem->GetTemplate())
        {
            // xinef: few special cases
            if (proto->RequiredSkill == SKILL_ENGINEERING)
            {
                if (uint16 skill202 = caster->ToPlayer()->GetSkillValue(SKILL_ENGINEERING))
                    summonLevel = skill202 / 5;
            }

            switch (m_spellInfo->Id)
            {
                // Dragon's Call
                case 13049:
                    summonLevel = 55;
                    break;

                // Cleansed Timberling Heart: Summon Timberling
                case 5666:
                    summonLevel = 7;
                    break;

                // Glowing Cat Figurine: Summon Ghost Saber
                case 6084:
                    // minLevel 19, maxLevel 20
                    summonLevel = 20;
                    break;

                // Spiked Collar: Summon Felhunter
                case 8176:
                    summonLevel = 30;
                    break;

                // Dog Whistle: Summon Tracking Hound
                case 9515:
                    summonLevel = 30;
                    break;

                // Barov Peasant Caller: Death by Peasant
                case 18307:
                case 18308:
                    summonLevel = 60;
                    break;

                // Thornling Seed: Plant Thornling
                case 22792:
                    summonLevel = 60;
                    break;

                // Cannonball Runner: Summon Crimson Cannon
                case 6251:
                    summonLevel = 61;
                    break;
            }
        }

    summonLevel = std::min<uint8>(sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL) + sWorld->getIntConfig(CONFIG_WORLD_BOSS_LEVEL_DIFF), std::max<uint8>(1U, summonLevel));

    float radius = 5.0f;
    int32 duration = m_spellInfo->GetDuration();

    if (Player* modOwner = m_originalCaster->GetSpellModOwner())
        modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_DURATION, duration);

    //TempSummonType summonType = (duration == 0) ? TEMPSUMMON_DEAD_DESPAWN : TEMPSUMMON_TIMED_DESPAWN;
    Map* map = caster->GetMap();
    TempSummon* summon = nullptr;

    uint32 currMinionsCount = m_caster->m_Controlled.size();
    uint32 totalNumGuardians = numGuardians + currMinionsCount;

    for (uint32 count = 0; count < numGuardians; ++count)
    {
        Position pos;

        // xinef: do not use precalculated position for effect summon pet in this function
        // it means it was cast by NPC and should have its position overridden unless the
        // target position is specified in the DB AND the effect has no or zero radius
        if ((totalNumGuardians == 1 && GetSpellInfo()->Effects[i].Effect != SPELL_EFFECT_SUMMON_PET) ||
            (GetSpellInfo()->Effects[i].TargetA.GetTarget() == TARGET_DEST_DB &&
            (!GetSpellInfo()->Effects[i].HasRadius() || GetSpellInfo()->Effects[i].RadiusEntry->RadiusMax == 0)))
        {
            pos = *destTarget;
        }
        else
        {
            // randomize position
            pos = m_caster->GetRandomPoint(*destTarget, radius);
        }

        summon = map->SummonCreature(entry, pos, properties, duration, caster, m_spellInfo->Id, 0, personalSpawn);
        if (!summon)
            return;

        // xinef: set calculated level
        summon->SetLevel(summonLevel);

        // if summonLevel changed, set stats for calculated level
        if (summonLevel != caster->GetLevel())
        {
            ((Guardian*)summon)->InitStatsForLevel(summonLevel);
        }

        // xinef: if we have more than one guardian, change follow angle
        if (summon->HasUnitTypeMask(UNIT_MASK_MINION) && totalNumGuardians > 1)
            ((Minion*)summon)->SetFollowAngle(m_caster->GetAbsoluteAngle(pos.GetPositionX(), pos.GetPositionY()));
        //else if (summon->HasUnitTypeMask(UNIT_MASK_MINION) && m_targets.HasDst())
        //    ((Minion*)summon)->SetFollowAngle(m_caster->GetAngle(summon));

        // xinef: move this here, some auras are added in initstatsforlevel!
        if (!summon->IsInCombat() && !summon->IsTrigger())
        {
            //  summon->AI()->EnterEvadeMode();
            summon->GetMotionMaster()->Clear(false);
            summon->GetMotionMaster()->MoveFollow(caster, PET_FOLLOW_DIST, summon->GetFollowAngle(), MOTION_SLOT_ACTIVE);
        }

        if (properties && properties->Category == SUMMON_CATEGORY_ALLY)
            summon->SetFaction(caster->GetFaction());

        ExecuteLogEffectSummonObject(i, summon);
    }

    // Summon infernal, cast enslave demon
    // xinef: have to do it here because in Pet init stats infernal is not in world, imo this should be changed...
    if (summon)
    {
        switch (m_spellInfo->Id)
        {
            // Inferno, Warlock summon spell
            case 1122:
                caster->AddAura(61191, summon);
                break;
            // Ritual of Doom, Warlock summon spell
            case 60478:
                caster->AddAura(SPELL_RITUAL_ENSLAVEMENT, summon);
                break;
        }
    }
}

void Spell::EffectRenamePet(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT ||
            !unitTarget->IsPet() || unitTarget->ToPet()->getPetType() != HUNTER_PET)
        return;

    unitTarget->SetByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED);
}

void Spell::EffectPlayMusic(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    uint32 soundid = m_spellInfo->Effects[effIndex].MiscValue;

    if (!sSoundEntriesStore.LookupEntry(soundid))
    {
        LOG_ERROR("spells.effect", "EffectPlayMusic: Sound (Id: {}) not exist in spell {}.", soundid, m_spellInfo->Id);
        return;
    }

    unitTarget->ToPlayer()->SendDirectMessage(WorldPackets::Misc::PlayMusic(soundid).Write());
}

void Spell::EffectSpecCount(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (Player* player = unitTarget->ToPlayer())
    {
        player->UpdateSpecCount(damage);
    }
}

void Spell::EffectActivateSpec(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    if (Player* player = unitTarget->ToPlayer())
    {
        player->ActivateSpec(damage - 1); // damage is 1 or 2, spec is 0 or 1
    }
}

void Spell::EffectPlaySound(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    switch (m_spellInfo->Id)
    {
        case 58730: // Restricted Flight Area
        case 58600: // Restricted Flight Area
            player->GetSession()->SendNotification(LANG_ZONE_NOFLYZONE);
            break;
        default:
            break;
    }

    uint32 soundId = m_spellInfo->Effects[effIndex].MiscValue;

    if (!sSoundEntriesStore.LookupEntry(soundId))
    {
        LOG_ERROR("spells.effect", "EffectPlayerSound: Sound (Id: {}) not exist in spell {}.", soundId, m_spellInfo->Id);
        return;
    }

    player->PlayDirectSound(soundId, player);
}

void Spell::EffectRemoveAura(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;
    // there may be need of specifying casterguid of removed auras
    unitTarget->RemoveAurasDueToSpell(m_spellInfo->Effects[effIndex].TriggerSpell);
}

void Spell::EffectCastButtons(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* p_caster = m_caster->ToPlayer();
    uint32 button_id = m_spellInfo->Effects[effIndex].MiscValue + 132;
    uint32 n_buttons = m_spellInfo->Effects[effIndex].MiscValueB;

    for (; n_buttons; --n_buttons, ++button_id)
    {
        ActionButton const* ab = p_caster->GetActionButton(button_id);
        if (!ab || ab->GetType() != ACTION_BUTTON_SPELL)
            continue;

        //! Action button data is unverified when it's set so it can be "hacked"
        //! to contain invalid spells, so filter here.
        uint32 spell_id = ab->GetAction();
        if (!spell_id)
            continue;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id);
        if (!spellInfo)
            continue;

        if (!p_caster->HasSpell(spell_id) || p_caster->HasSpellCooldown(spell_id))
            continue;

        if (!spellInfo->HasAttribute(SPELL_ATTR7_CAN_BE_MULTI_CAST))
            continue;

        uint32 cost = spellInfo->CalcPowerCost(m_caster, spellInfo->GetSchoolMask(), this);
        if (m_caster->GetPower(POWER_MANA) < cost)
            continue;

        TriggerCastFlags triggerFlags = TriggerCastFlags(TRIGGERED_IGNORE_GCD | TRIGGERED_IGNORE_CAST_IN_PROGRESS | TRIGGERED_CAST_DIRECTLY);
        m_caster->CastSpell(m_caster, spell_id, triggerFlags);
    }
}

void Spell::EffectRechargeManaGem(SpellEffIndex /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* player = m_caster->ToPlayer();

    if (!player)
        return;

    uint32 item_id = m_spellInfo->Effects[EFFECT_0].ItemType;

    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item_id);
    if (!pProto)
    {
        player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, nullptr, nullptr);
        return;
    }

    if (Item* pItem = player->GetItemByEntry(item_id))
    {
        for (int x = 0; x < MAX_ITEM_PROTO_SPELLS; ++x)
            pItem->SetSpellCharges(x, pProto->Spells[x].SpellCharges);
        pItem->SetState(ITEM_CHANGED, player);
    }
}

void Spell::EffectBind(SpellEffIndex effIndex)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    WorldLocation homeLoc;
    uint32 areaId = player->GetAreaId();

    if (m_spellInfo->Effects[effIndex].MiscValue)
        areaId = m_spellInfo->Effects[effIndex].MiscValue;

    if (m_targets.HasDst())
        homeLoc.WorldRelocate(*destTarget);
    else
    {
        homeLoc = player->GetWorldLocation();
    }

    player->SetHomebind(homeLoc, areaId);

    // binding
    WorldPacket data(SMSG_BINDPOINTUPDATE, 4 + 4 + 4 + 4 + 4);
    data << float(homeLoc.GetPositionX());
    data << float(homeLoc.GetPositionY());
    data << float(homeLoc.GetPositionZ());
    data << uint32(homeLoc.GetMapId());
    data << uint32(areaId);
    player->SendDirectMessage(&data);

    LOG_DEBUG("spells.aura", "EffectBind: New homebind X: {}, Y: {}, Z: {}, MapId: {}, AreaId: {}",
                   homeLoc.GetPositionX(), homeLoc.GetPositionY(), homeLoc.GetPositionZ(), homeLoc.GetMapId(), areaId);
    // zone update
    data.Initialize(SMSG_PLAYERBOUND, 8 + 4);
    data << m_caster->GetGUID();
    data << uint32(areaId);
    player->SendDirectMessage(&data);
}

void Spell::EffectSummonRaFFriend(SpellEffIndex  /*effIndex*/)
{
    if (effectHandleMode != SPELL_EFFECT_HANDLE_HIT_TARGET)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    if (!unitTarget)
        return;

    Player* player = unitTarget->ToPlayer();
    if (!player)
    {
        return;
    }

    float x, y, z;
    m_caster->GetPosition(x, y, z);
    unitTarget->ToPlayer()->SetSummonPoint(m_caster->GetMapId(), x, y, z);
    WorldPacket data(SMSG_SUMMON_REQUEST, 8 + 4 + 4);
    data << m_caster->GetGUID();
    data << uint32(m_caster->GetZoneId());
    data << uint32(MAX_PLAYER_SUMMON_DELAY * IN_MILLISECONDS); // auto decline after msecs
    player->GetSession()->SendPacket(&data);
}
