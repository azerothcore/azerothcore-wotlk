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

#ifndef SCRIPT_OBJECT_UNIT_SCRIPT_H_
#define SCRIPT_OBJECT_UNIT_SCRIPT_H_

#include "ScriptObject.h"
#include "SharedDefines.h"
#include <vector>

enum UnitHook
{
    UNITHOOK_ON_HEAL,
    UNITHOOK_ON_DAMAGE,
    UNITHOOK_MODIFY_PERIODIC_DAMAGE_AURAS_TICK,
    UNITHOOK_MODIFY_MELEE_DAMAGE,
    UNITHOOK_MODIFY_SPELL_DAMAGE_TAKEN,
    UNITHOOK_MODIFY_HEAL_RECEIVED,
    UNITHOOK_ON_BEFORE_ROLL_MELEE_OUTCOME_AGAINST,
    UNITHOOK_ON_AURA_APPLY,
    UNITHOOK_ON_AURA_REMOVE,
    UNITHOOK_IF_NORMAL_REACTION,
    UNITHOOK_CAN_SET_PHASE_MASK,
    UNITHOOK_IS_CUSTOM_BUILD_VALUES_UPDATE,
    UNITHOOK_SHOULD_TRACK_VALUES_UPDATE_POS_BY_INDEX,
    UNITHOOK_ON_PATCH_VALUES_UPDATE,
    UNITHOOK_ON_UNIT_UPDATE,
    UNITHOOK_ON_DISPLAYID_CHANGE,
    UNITHOOK_ON_UNIT_ENTER_EVADE_MODE,
    UNITHOOK_ON_UNIT_ENTER_COMBAT,
    UNITHOOK_ON_UNIT_DEATH,
    UNITHOOK_ON_UNIT_SET_SHAPESHIFT_FORM,
    UNITHOOK_ON_DEAL_DAMAGE_SHIELD_DAMAGE,
    UNITHOOK_ON_SEND_SPELL_NON_MELEE_DAMAGE_LOG,
    UNITHOOK_ON_SEND_ATTACK_STATE_UPDATE,
    UNITHOOK_ON_SEND_SPELL_DAMAGE_IMMUNE,
    UNITHOOK_ON_SEND_SPELL_MISS,
    UNITHOOK_ON_SEND_SPELL_DAMAGE_RESIST,
    UNITHOOK_ON_SEND_SPELL_NON_MELEE_REFLECT_LOG,
    UNITHOOK_ON_SEND_HEAL_SPELL_LOG,
    UNITHOOK_ON_SEND_ENERGIZE_SPELL_LOG,
    UNITHOOK_ON_SEND_PERIODIC_AURA_LOG,
    UNITHOOK_ON_DAMAGE_ABSORBED,
    UNITHOOK_END
};

enum ReputationRank : uint8;
class ByteBuffer;
class HealInfo;
struct BuildValuesCachePosPointers;
struct CalcDamageInfo;
class DamageInfo;
class SpellInfo;
struct SpellNonMeleeDamage;
struct SpellPeriodicAuraLogInfo;

class UnitScript : public ScriptObject
{
protected:
    UnitScript(const char* name, bool addToScripts = true, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // Called when a unit deals healing to another unit
    virtual void OnHeal(Unit* /*healer*/, Unit* /*reciever*/, uint32& /*gain*/) { }

    // Called when a unit deals damage to another unit
    virtual void OnDamage(Unit* /*attacker*/, Unit* /*victim*/, uint32& /*damage*/) { }

    // Called when DoT's Tick Damage is being Dealt
    // Attacker can be nullptr if he is despawned while the aura still exists on target
    virtual void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/, SpellInfo const* /*spellInfo*/) { }

    // Called when Melee Damage is being Dealt
    virtual void ModifyMeleeDamage(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/) { }

    // Called when Spell Damage is being Dealt
    virtual void ModifySpellDamageTaken(Unit* /*target*/, Unit* /*attacker*/, int32& /*damage*/, SpellInfo const* /*spellInfo*/) { }

    // Called when Heal is Recieved
    virtual void ModifyHealReceived(Unit* /*target*/, Unit* /*healer*/, uint32& /*heal*/, SpellInfo const* /*spellInfo*/) { }

    //Called when Damage is Dealt
    virtual uint32 DealDamage(Unit* /*AttackerUnit*/, Unit* /*pVictim*/, uint32 damage, DamageEffectType /*damagetype*/) { return damage; }

    virtual void OnBeforeRollMeleeOutcomeAgainst(Unit const* /*attacker*/, Unit const* /*victim*/, WeaponAttackType /*attType*/, int32& /*attackerMaxSkillValueForLevel*/, int32& /*victimMaxSkillValueForLevel*/, int32& /*attackerWeaponSkill*/, int32& /*victimDefenseSkill*/, int32& /*crit_chance*/, int32& /*miss_chance*/, int32& /*dodge_chance*/, int32& /*parry_chance*/, int32& /*block_chance*/ ) {   };

    virtual void OnAuraApply(Unit* /*unit*/, Aura* /*aura*/) { }

    virtual void OnAuraRemove(Unit* /*unit*/, AuraApplication* /*aurApp*/, AuraRemoveMode /*mode*/) { }

    [[nodiscard]] virtual bool IfNormalReaction(Unit const* /*unit*/, Unit const* /*target*/, ReputationRank& /*repRank*/) { return true; }

    [[nodiscard]] virtual bool CanSetPhaseMask(Unit const* /*unit*/, uint32 /*newPhaseMask*/, bool /*update*/) { return true; }

    [[nodiscard]] virtual bool IsCustomBuildValuesUpdate(Unit const* /*unit*/, uint8 /*updateType*/, ByteBuffer& /*fieldBuffer*/, Player const* /*target*/, uint16 /*index*/) { return false; }

    [[nodiscard]] virtual bool ShouldTrackValuesUpdatePosByIndex(Unit const* /*unit*/, uint8 /*updateType*/, uint16 /*index*/) { return false; }

    virtual void OnPatchValuesUpdate(Unit const* /*unit*/, ByteBuffer& /*valuesUpdateBuf*/, BuildValuesCachePosPointers& /*posPointers*/, Player* /*target*/) { }

    /**
     * @brief This hook runs in Unit::Update
     *
     * @param unit Contains information about the Unit
     * @param diff Contains information about the diff time
     */
    virtual void OnUnitUpdate(Unit* /*unit*/, uint32 /*diff*/) { }

    virtual void OnDisplayIdChange(Unit* /*unit*/, uint32 /*displayId*/) { }

    virtual void OnUnitEnterEvadeMode(Unit* /*unit*/, uint8 /*evadeReason*/) { }
    virtual void OnUnitEnterCombat(Unit* /*unit*/, Unit* /*victim*/) { }
    virtual void OnUnitDeath(Unit* /*unit*/, Unit* /*killer*/) { }
    virtual void OnUnitSetShapeshiftForm(Unit* /*unit*/, uint8 /*form*/) { }

    /**
     * @brief Called when damage shield (e.g. Thorns) damage
     *        is dealt inside DealDamageShieldDamage.
     *
     * @param damageInfo Damage details (attacker, victim, amount,
     *                   absorb, resist, school)
     * @param overkill   Damage exceeding the target's remaining
     *                   health (0 if target survives)
     */
    virtual void OnDealDamageShieldDamage(DamageInfo* /*damageInfo*/,
        uint32 /*overkill*/) { }

    /**
     * @brief Called when a spell non-melee damage log is sent
     *        to the client (SMSG_SPELLNONMELEEDAMAGELOG).
     *
      * @param log      Spell damage details including damage, absorb,
      *                 resist, blocked, school, and hit-info flags
      * @param overkill Damage exceeding the target's remaining
      *                 health (0 if target survives)
     */
    virtual void OnSendSpellNonMeleeDamageLog(
          SpellNonMeleeDamage* /*log*/, int32 /*overkill*/) { }

    /**
     * @brief Called when a melee attack state update is sent
     *        to the client (SMSG_ATTACKERSTATEUPDATE).
     *
     * @param damageInfo Full melee damage calculation result
     * @param overkill   Damage exceeding the target's remaining
     *                   health (0 if target survives)
     */
    virtual void OnSendAttackStateUpdate(
        CalcDamageInfo* /*damageInfo*/, int32 /*overkill*/) { }

    /**
     * @brief Called when a spell damage immunity message is
     *        sent (SMSG_SPELLORDAMAGE_IMMUNE).
     *
     * @param attacker The unit whose spell was resisted
     * @param victim   The immune unit
     * @param spellId  The resisted spell
     */
    virtual void OnSendSpellDamageImmune(Unit* /*attacker*/,
        Unit* /*victim*/, uint32 /*spellId*/) { }

    /**
     * @brief Called when a spell miss log is sent to the
     *        client (SMSG_SPELLLOGMISS).
     *
     * @param attacker The casting unit
     * @param victim   The target unit
     * @param spellID  The missed spell
     * @param missInfo The type of miss (resist, dodge, etc.)
     */
    virtual void OnSendSpellMiss(Unit* /*attacker*/,
        Unit* /*victim*/, uint32 /*spellID*/,
        SpellMissInfo /*missInfo*/) { }

    /**
     * @brief Called when a full spell resist message is sent
     *        (SMSG_PROCRESIST).
     *
     * @param attacker The casting unit
     * @param victim   The resisting unit
     * @param spellId  The resisted spell
     */
    virtual void OnSendSpellDamageResist(Unit* /*attacker*/,
        Unit* /*victim*/, uint32 /*spellId*/) { }

    /**
     * @brief Called when a spell reflect damage log is sent.
     *        Fires before the player-only filter in
     *        SendSpellNonMeleeReflectLog, so modules see
     *        all reflects regardless of unit type.
     *
     * @param log      Reflected spell damage details
     * @param attacker The original caster whose spell was
     *                 reflected
     */
    virtual void OnSendSpellNonMeleeReflectLog(
        SpellNonMeleeDamage* /*log*/, Unit* /*attacker*/) { }

    /**
     * @brief Called when a heal spell log is sent to the
     *        client (SMSG_SPELLHEALLOG).
     *
     * @param healInfo Heal details (healer, target, amount,
     *                 overheal, absorb, spell)
     * @param critical Whether the heal was a critical strike
     */
    virtual void OnSendHealSpellLog(HealInfo const& /*healInfo*/,
        bool /*critical*/) { }

    /**
     * @brief Called when a power energize log is sent to the
     *        client (SMSG_SPELLENERGIZELOG).
     *
     * @param attacker  The energizing unit (caster)
     * @param victim    The unit receiving power
     * @param spellID   The energize spell
     * @param amount    Amount of power restored
     * @param powerType The power type (mana, rage, energy)
     */
    virtual void OnSendEnergizeSpellLog(Unit* /*attacker*/,
        Unit* /*victim*/, uint32 /*spellID*/,
        uint32 /*amount*/, Powers /*powerType*/) { }

    /**
     * @brief Called when a periodic aura log is sent to the
     *        client (SMSG_PERIODICAURALOG). Covers periodic
     *        damage, healing, and energize ticks.
     *
     * @param victim The unit affected by the periodic aura
     * @param pInfo  Periodic aura tick details (aura effect,
     *               damage/heal amount, absorb, resist, etc.)
     */
    virtual void OnSendPeriodicAuraLog(Unit* /*victim*/,
        SpellPeriodicAuraLogInfo* /*pInfo*/) { }

    /**
     * @brief Called after an absorb aura absorbs part or all of
     *        incoming damage.
     *
     * Fires once per absorb aura per damage event inside
     * CalcAbsorbResist. Covers both school absorbs and mana shields.
     *
     * @param dmgInfo         Incoming damage context
     * @param absorbSpellInfo The absorb aura's spell
     * @param absorbCaster    Unit that applied the absorb aura
     * @param absorbAmount    Amount absorbed by this specific aura
     */
    virtual void OnDamageAbsorbed(DamageInfo& /*dmgInfo*/,
        SpellInfo const* /*absorbSpellInfo*/, Unit* /*absorbCaster*/,
        uint32 /*absorbAmount*/) { }
};

#endif
