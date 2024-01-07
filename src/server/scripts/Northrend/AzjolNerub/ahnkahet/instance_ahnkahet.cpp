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

#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ahnkahet.h"

ObjectData const creatureData[] =
{
    { NPC_PRINCE_TALDARAM, DATA_PRINCE_TALDARAM },
    { 0,                   0                    }
};

DoorData const doorData[] =
{
    { GO_TELDARAM_DOOR, DATA_PRINCE_TALDARAM, DOOR_TYPE_PASSAGE },
    { 0,                0,                    DOOR_TYPE_ROOM    }
};

class instance_ahnkahet : public InstanceMapScript
{
public:
    instance_ahnkahet() : InstanceMapScript(AhnKahetScriptName, 619) { }

    struct instance_ahnkahet_InstanceScript : public InstanceScript
    {
        instance_ahnkahet_InstanceScript(Map* pMap) : InstanceScript(pMap)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            SetPersistentDataCount(MAX_PERSISTENT_DATA);
            LoadObjectData(creatureData, nullptr);
            LoadDoorData(doorData);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_TELDARAM_PLATFORM:
                {
                    taldaramPlatform_GUID = go->GetGUID();
                    HandleGameObject(ObjectGuid::Empty, IsAllSpheresActivated(), go);
                    break;
                }
                case GO_TELDARAM_SPHERE1:
                case GO_TELDARAM_SPHERE2:
                {
                    if (GetPersistentData(go->GetEntry() == GO_TELDARAM_SPHERE1 ? 0 : 1) == DONE || GetBossState(DATA_PRINCE_TALDARAM) == DONE)
                    {
                        go->SetGoState(GO_STATE_ACTIVE);
                        go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    }
                    else
                    {
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    }

                    break;
                }
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            uint8 index = type == DATA_TELDRAM_SPHERE1 ? 0 : 1;

            if ((type == DATA_TELDRAM_SPHERE1 || type == DATA_TELDRAM_SPHERE2) && GetPersistentData(index) != DONE)
            {
                StorePersistentData(index, DONE);
                SaveToDB();

                if (Creature* taldaram = GetCreature(DATA_PRINCE_TALDARAM))
                {
                    if (taldaram->IsAlive())
                    {
                        taldaram->AI()->Talk(SAY_SPHERE_ACTIVATED);

                        if (IsAllSpheresActivated())
                        {
                            HandleGameObject(taldaramPlatform_GUID, true, nullptr);
                            taldaram->AI()->DoAction(ACTION_REMOVE_PRISON);
                        }
                    }
                }
            }
        }

    private:
        // Teldaram related
        ObjectGuid taldaramPlatform_GUID;

        bool IsAllSpheresActivated() const
        {
            return GetBossState(DATA_PRINCE_TALDARAM) == DONE ||
                (GetPersistentData(DATA_TELDRAM_SPHERE1) == DONE && GetPersistentData(DATA_TELDRAM_SPHERE2) == DONE);
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_ahnkahet_InstanceScript(map);
    }
};

// 56702 Shadow Sickle
// 59103 Shadow Sickle
class spell_shadow_sickle_periodic_damage : public AuraScript
{
    PrepareAuraScript(spell_shadow_sickle_periodic_damage);

    void HandlePeriodic(AuraEffect const*  /*aurEff*/)
    {
        GetCaster()->CastSpell(nullptr, SPELL_SHADOW_SICKLE);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadow_sickle_periodic_damage::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_instance_ahnkahet()
{
    new instance_ahnkahet;
    RegisterSpellScript(spell_shadow_sickle_periodic_damage);
}
