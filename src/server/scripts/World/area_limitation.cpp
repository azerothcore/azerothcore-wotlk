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

#include "ScriptMgr.h"
#include "CreatureTextMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"

enum AreaLimitation
{
    SPELL_WARNING_WYRMREST                 = 50065,
    SPELL_WARNING_GRYPHON                  = 48366,
    SPELL_WARNING_FLAMEBRINGER             = 48694,
    SPELL_RIDE_FLAMEBRIGER                 = 48600,
    SPELL_WINTERGARDE_GRYPHON_COMMANDER    = 48365,
    SPELL_BONE_GRYPHON                     = 21745,
    SPELL_ONSLAUGHT_GRYPHON                = 49641,
    SPELL_BOUNDARY_WARNING                 = 51272,
    SPELL_BOUNDARY_WARNING_2               = 51259,
    SPELL_BOUNDARY_WARNING_3               = 56966,
    SPELL_COMMAND_ARGENT_SKYTALON          = 56678,
    SPELL_WYRMREST_DEFENDER_MOUNT          = 49256,

    // Zone/Area
    ICECROWN                               = 210,
    ONSLAUGHT_HARBOR                       = 4417,
    VOLDRUNE                               = 4207,
    WINTERGARDE_KEEP                       = 4177,
    WINTERGARDE_MINE                       = 4178,
    THE_CARRION_FIELDS                     = 4188,
    THE_DRAGON_WASTES                      = 4254,
    PATH_OF_THE_TITANS                     = 4184,
    AZURE_DRAGONSHRINE                     = 4183,
    THE_MIRROR_OF_DAWN                     = 4176,
    WYRMREST_TEMPLE                        = 4161,
    DUN_NIFFELEM                           = 4438,
    VALLEY_OF_ANCIENT_WINTERS              = 4437,
    BRUNNHILDAR_VILLAGE                    = 4422,
    THE_PIT_OF_THE_FANG                    = 4535,
    THE_ARGENT_VANGUARD                    = 4501,
    VALLEY_OF_ECHOES                       = 4504,
    THE_BREACH                             = 4505,
    SCOURGEHOLME                           = 4506,

    // Text
    TEXT_EMOTE                             = 0
};

class spell_wyrmrest_defender_mount : public AuraScript
{
public:
    PrepareAuraScript(spell_wyrmrest_defender_mount);

    bool AreaCheck(Unit* target)
    {
        if (target->GetAreaId() != THE_DRAGON_WASTES && target->GetAreaId() != PATH_OF_THE_TITANS && target->GetAreaId() != AZURE_DRAGONSHRINE &&
            target->GetAreaId() != THE_MIRROR_OF_DAWN && target->GetAreaId() != WYRMREST_TEMPLE)
            return true;
        return false;
    }

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_WARNING_WYRMREST,
                SPELL_WYRMREST_DEFENDER_MOUNT
            });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        Unit* caster = GetCaster();

        if (Creature* wyrmrest = target->GetVehicleCreatureBase())
        {
            sCreatureTextMgr->SendChat(wyrmrest, TEXT_EMOTE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            target->CastSpell(target, SPELL_WARNING_WYRMREST, true);
        }

        // any way out of the game using mount will be removed
        if (!caster || caster->GetVehicleCreatureBase())
            return;

        caster->RemoveAurasDueToSpell(SPELL_WYRMREST_DEFENDER_MOUNT);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetUnitOwner()->ToPlayer();
        switch (target->GetAreaId())
        {
            case THE_DRAGON_WASTES:
            case PATH_OF_THE_TITANS:
            case AZURE_DRAGONSHRINE:
            case THE_MIRROR_OF_DAWN:
            case WYRMREST_TEMPLE:
                target->RemoveAura(SPELL_WARNING_WYRMREST);
                break;
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_wyrmrest_defender_mount::AreaCheck);
        OnEffectApply += AuraEffectApplyFn(spell_wyrmrest_defender_mount::HandleApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_wyrmrest_defender_mount::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_wintergarde_gryphon_commander : public AuraScript
{
public:
    PrepareAuraScript(spell_wintergarde_gryphon_commander);

    bool CheckArea(Unit* target)
    {
        if (target->GetAreaId() != WINTERGARDE_KEEP && target->GetAreaId() != WINTERGARDE_MINE && target->GetAreaId() != THE_CARRION_FIELDS)
            return true;
        return false;
    }
        
    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
    }
        
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_WARNING_GRYPHON,
                SPELL_WINTERGARDE_GRYPHON_COMMANDER
            });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        Unit* caster = GetCaster();
        if (Creature* gryphon = target->GetVehicleCreatureBase())
        {
            sCreatureTextMgr->SendChat(gryphon, TEXT_EMOTE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            target->CastSpell(target, SPELL_WARNING_GRYPHON, true);
        }
        
	    // any way out of the game using mount will be removed
        if (!caster || caster->GetVehicleCreatureBase())
            return;

        caster->RemoveAurasDueToSpell(SPELL_WINTERGARDE_GRYPHON_COMMANDER);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        switch (target->GetAreaId())
        {
            case WINTERGARDE_KEEP:
            case WINTERGARDE_MINE:
            case THE_CARRION_FIELDS:
                target->RemoveAura(SPELL_WARNING_GRYPHON);
                break;
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_wintergarde_gryphon_commander::CheckArea);
        OnEffectApply += AuraEffectApplyFn(spell_wintergarde_gryphon_commander::HandleApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_wintergarde_gryphon_commander::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_ride_flamebringer : public AuraScript
{
public:
    PrepareAuraScript(spell_ride_flamebringer);

    bool CheckArea(Unit* target)
    {
        if (target->GetAreaId() != VOLDRUNE)
            return true;
        return false;
    }

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARNING_FLAMEBRINGER });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        if (Creature* flamebringer = target->GetVehicleCreatureBase())
        {
            sCreatureTextMgr->SendChat(flamebringer, TEXT_EMOTE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            target->CastSpell(target, SPELL_WARNING_FLAMEBRINGER, true);
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetUnitOwner()->ToPlayer())
        {
            if (target->GetAreaId() == VOLDRUNE)
                target->RemoveAura(SPELL_WARNING_FLAMEBRINGER);
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_ride_flamebringer::CheckArea);
        OnEffectApply += AuraEffectApplyFn(spell_ride_flamebringer::HandleApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_ride_flamebringer::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_bone_gryphon : public AuraScript
{
public:
    PrepareAuraScript(spell_bone_gryphon);

    bool CheckArea(Unit* target)
    {
        if (target->GetAreaId() != ONSLAUGHT_HARBOR)
            return true;
        return false;
    }

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_BOUNDARY_WARNING,
                SPELL_BONE_GRYPHON
            });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        Unit* caster = GetCaster();

        if (Creature* gryphon = target->GetVehicleCreatureBase())
        {
            sCreatureTextMgr->SendChat(gryphon, TEXT_EMOTE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            target->CastSpell(target, SPELL_BOUNDARY_WARNING, true);
        }
		
        // any way out of the game using mount will be removed
        if (!caster || caster->GetVehicleCreatureBase())
            return;

        caster->RemoveAurasDueToSpell(SPELL_BONE_GRYPHON);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetUnitOwner()->ToPlayer())
        {
            if (target->GetAreaId() == ONSLAUGHT_HARBOR)
                target->RemoveAura(SPELL_BOUNDARY_WARNING);
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_bone_gryphon::CheckArea);
        OnEffectApply += AuraEffectApplyFn(spell_bone_gryphon::HandleApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_bone_gryphon::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_onslaught_gryphon : public AuraScript
{
public:
    PrepareAuraScript(spell_onslaught_gryphon);

    bool CheckArea(Unit* target)
    {
        if (target->GetZoneId() != ICECROWN)
            return true;
        return false;
    }

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BOUNDARY_WARNING });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        Unit* caster = GetCaster();

        if (Creature* gryphon = target->GetVehicleCreatureBase())
        {
            sCreatureTextMgr->SendChat(gryphon, TEXT_EMOTE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            target->CastSpell(target, SPELL_BOUNDARY_WARNING, true);
        }

        // any way out of the game using mount will be removed
        if (!caster || caster->GetVehicleCreatureBase())
            return;

        caster->RemoveAurasDueToSpell(SPELL_ONSLAUGHT_GRYPHON);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetUnitOwner())
        {
            if (target->GetZoneId() == ICECROWN)
                target->RemoveAura(SPELL_BOUNDARY_WARNING);
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_onslaught_gryphon::CheckArea);
        OnEffectApply += AuraEffectApplyFn(spell_onslaught_gryphon::HandleApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_onslaught_gryphon::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_ride_freed_proto_drake : public AuraScript
{
public:
    PrepareAuraScript(spell_ride_freed_proto_drake);

    bool AreaCheck(Unit* target)
    {
        if (target->GetAreaId() != DUN_NIFFELEM && target->GetAreaId() != VALLEY_OF_ANCIENT_WINTERS && target->GetAreaId() != BRUNNHILDAR_VILLAGE &&
            target->GetAreaId() != THE_PIT_OF_THE_FANG)
            return true;
        return false;
    }

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BOUNDARY_WARNING_2 });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        if (Creature* drake = target->GetVehicleCreatureBase())
        {
            sCreatureTextMgr->SendChat(drake, TEXT_EMOTE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            target->CastSpell(target, SPELL_BOUNDARY_WARNING_2, true);
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetUnitOwner()->ToPlayer();
        switch (target->GetAreaId())
        {
            case DUN_NIFFELEM:
            case VALLEY_OF_ANCIENT_WINTERS:
            case BRUNNHILDAR_VILLAGE:
            case THE_PIT_OF_THE_FANG:
                target->RemoveAura(SPELL_BOUNDARY_WARNING_2);
                break;
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_ride_freed_proto_drake::AreaCheck);
        OnEffectApply += AuraEffectApplyFn(spell_ride_freed_proto_drake::HandleApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_ride_freed_proto_drake::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_command_argent_skytalon : public AuraScript
{
public:
    PrepareAuraScript(spell_command_argent_skytalon);

    bool AreaCheck(Unit* target)
    {
        if (target->GetAreaId() != THE_ARGENT_VANGUARD && target->GetAreaId() != VALLEY_OF_ECHOES && target->GetAreaId() != THE_BREACH &&
            target->GetAreaId() != SCOURGEHOLME)
            return true;
        return false;
    }

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_BOUNDARY_WARNING,
                SPELL_COMMAND_ARGENT_SKYTALON
            });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* target = GetUnitOwner()->ToPlayer();
        Unit* caster = GetCaster();

        if (Creature* sytalon = target->GetVehicleCreatureBase())
        {
            sCreatureTextMgr->SendChat(sytalon, TEXT_EMOTE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            target->CastSpell(target, SPELL_BOUNDARY_WARNING, true);
        }

        // any way out of the game using mount will be removed
        if (!caster || caster->GetVehicleCreatureBase())
            return;

        caster->RemoveAurasDueToSpell(SPELL_COMMAND_ARGENT_SKYTALON);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetUnitOwner()->ToPlayer();
        switch (target->GetAreaId())
        {
            case THE_ARGENT_VANGUARD:
            case VALLEY_OF_ECHOES:
            case THE_BREACH:
            case SCOURGEHOLME:
                target->RemoveAura(SPELL_BOUNDARY_WARNING);
                break;
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_command_argent_skytalon::AreaCheck);
        OnEffectApply += AuraEffectApplyFn(spell_command_argent_skytalon::HandleApply, EFFECT_1, SPELL_AURA_PHASE, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_command_argent_skytalon::HandleRemove, EFFECT_1, SPELL_AURA_PHASE, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_area_limitation()
{
    RegisterSpellScript(spell_wyrmrest_defender_mount);
    RegisterSpellScript(spell_wintergarde_gryphon_commander);
    RegisterSpellScript(spell_ride_flamebringer);
    RegisterSpellScript(spell_bone_gryphon);
    RegisterSpellScript(spell_onslaught_gryphon);
    RegisterSpellScript(spell_ride_freed_proto_drake);
    RegisterSpellScript(spell_command_argent_skytalon);
}
