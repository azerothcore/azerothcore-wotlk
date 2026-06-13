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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "drak_tharon_keep.h"
#include "SpellScript.h"

DoorData const doorData[] =
{
    { GO_NOVOS_CRYSTAL_1,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { GO_NOVOS_CRYSTAL_2,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { GO_NOVOS_CRYSTAL_3,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { GO_NOVOS_CRYSTAL_4,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { 0,                    0,                      DOOR_TYPE_ROOM }
};

struct instance_drak_tharon_keep : public InstanceScript
{
    instance_drak_tharon_keep(Map* map) : InstanceScript(map)
    {
        SetHeaders(DataHeader);
        SetBossNumber(MAX_ENCOUNTERS);
        LoadDoorData(doorData);
    }

    void OnGameObjectCreate(GameObject* go) override
    {
        switch (go->GetEntry())
        {
            case GO_NOVOS_CRYSTAL_1:
            case GO_NOVOS_CRYSTAL_2:
            case GO_NOVOS_CRYSTAL_3:
            case GO_NOVOS_CRYSTAL_4:
                AddDoor(go);
                break;
        }
    }

    void OnGameObjectRemove(GameObject* go) override
    {
        switch (go->GetEntry())
        {
            case GO_NOVOS_CRYSTAL_1:
            case GO_NOVOS_CRYSTAL_2:
            case GO_NOVOS_CRYSTAL_3:
            case GO_NOVOS_CRYSTAL_4:
                RemoveDoor(go);
                break;
        }
    }
};

class spell_dtk_raise_dead_aura : public AuraScript
{
    PrepareAuraScript(spell_dtk_raise_dead_aura);

    bool Load() override
    {
        return GetUnitOwner()->IsCreature();
    }

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ToCreature()->DespawnOrUnsummon(1ms);
        GetUnitOwner()->SummonCreature(NPC_RISEN_DRAKKARI_WARRIOR, *GetUnitOwner());
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_dtk_raise_dead_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_dtk_summon_random_drakkari : public SpellScript
{
    PrepareSpellScript(spell_dtk_summon_random_drakkari);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_DRAKKARI_SHAMAN, SPELL_SUMMON_DRAKKARI_GUARDIAN });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), RAND(SPELL_SUMMON_DRAKKARI_SHAMAN, SPELL_SUMMON_DRAKKARI_GUARDIAN), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dtk_summon_random_drakkari::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_instance_drak_tharon_keep()
{
    RegisterInstanceScript(instance_drak_tharon_keep, MAP_DRAK_THARON_KEEP);
    RegisterSpellScript(spell_dtk_raise_dead_aura);
    RegisterSpellScript(spell_dtk_summon_random_drakkari);
}
