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

#ifndef SCRIPT_OBJECT_UNIT_SCRIPT_H_
#define SCRIPT_OBJECT_UNIT_SCRIPT_H_

#include "ScriptObject.h"

enum ReputationRank : uint8;
class ByteBuffer;
struct BuildValuesCachePosPointers;

class UnitScript : public ScriptObject
{
protected:
    UnitScript(const char* name, bool addToScripts = true);

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

    [[nodiscard]] virtual bool IsNeedModSpellDamagePercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) { return true; }

    [[nodiscard]] virtual bool IsNeedModMeleeDamagePercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) { return true; }

    [[nodiscard]] virtual bool IsNeedModHealPercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) { return true; }

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
};

#endif
