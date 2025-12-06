/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_UNIT_SCRIPT_H
#define __AB_UNIT_SCRIPT_H

#include "AutoBalance.h"

#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellInfo.h"

class AutoBalance_UnitScript : public UnitScript
{
public:
    AutoBalance_UnitScript()
        : UnitScript("AutoBalance_UnitScript", true, {
            UNITHOOK_MODIFY_PERIODIC_DAMAGE_AURAS_TICK,
            UNITHOOK_MODIFY_SPELL_DAMAGE_TAKEN,
            UNITHOOK_MODIFY_MELEE_DAMAGE,
            UNITHOOK_MODIFY_HEAL_RECEIVED,
            UNITHOOK_ON_AURA_APPLY
        })
    {
    }

    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* source, uint32& amount, SpellInfo const* spellInfo) override;
    void ModifySpellDamageTaken(Unit* target, Unit* source, int32& amount, SpellInfo const* spellInfo) override;
    void ModifyMeleeDamage(Unit* target, Unit* source, uint32& amount) override;
    void ModifyHealReceived(Unit* target, Unit* source, uint32& amount, SpellInfo const* spellInfo) override;
    void OnAuraApply(Unit* unit, Aura* aura) override;

private:
    [[maybe_unused]] bool _debug_damage_and_healing = false; // defaults to false, overwritten in each function

    void   _Debug_Output(std::string function_name, Unit* target, Unit* source, int32 amount, Damage_Healing_Debug_Phase phase, std::string spell_name = "Unknown Spell", uint32 spell_id = 0);
    int32  _Modify_Damage_Healing(Unit* target, Unit* source, int32 amount, SpellInfo const* spellInfo = nullptr);
    uint32 _Modifier_CCDuration(Unit* target, Unit* caster, Aura* aura);
    bool   _isAuraWithEffectType(SpellInfo const* spellInfo, AuraType auraType, bool log = false);
};


#endif /* __AB_UNIT_SCRIPT_H */
