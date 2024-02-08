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
#include "InstanceScript.h"
#include "SpellScriptLoader.h"
#include "the_eye.h"

ObjectData const creatureData[] =
{
    { NPC_KAELTHAS,         DATA_KAELTHAS       },
    { NPC_THALADRED,        DATA_THALADRED      },
    { NPC_LORD_SANGUINAR,   DATA_LORD_SANGUINAR },
    { NPC_CAPERNIAN,        DATA_CAPERNIAN      },
    { NPC_TELONICUS,        DATA_TELONICUS      },
    { 0,                    0                   }
};

ObjectData const gameObjectData[] =
{
    { 0,               0                 }
};

class instance_the_eye : public InstanceMapScript
{
public:
    instance_the_eye() : InstanceMapScript("instance_the_eye", 550) { }

    struct instance_the_eye_InstanceMapScript : public InstanceScript
    {
        instance_the_eye_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            LoadObjectData(creatureData, gameObjectData);
            SetBossNumber(MAX_ENCOUNTER);
        }

        ObjectGuid ThaladredTheDarkenerGUID;
        ObjectGuid LordSanguinarGUID;
        ObjectGuid GrandAstromancerCapernianGUID;
        ObjectGuid MasterEngineerTelonicusGUID;
        ObjectGuid AlarGUID;
        ObjectGuid KaelthasGUID;
        ObjectGuid BridgeWindowGUID;
        ObjectGuid KaelStateRightGUID;
        ObjectGuid KaelStateLeftGUID;

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_ALAR:
                    AlarGUID = creature->GetGUID();
                    break;
                case NPC_KAELTHAS:
                    KaelthasGUID = creature->GetGUID();
                    break;
                case NPC_THALADRED:
                    ThaladredTheDarkenerGUID = creature->GetGUID();
                    break;
                case NPC_TELONICUS:
                    MasterEngineerTelonicusGUID = creature->GetGUID();
                    break;
                case NPC_CAPERNIAN:
                    GrandAstromancerCapernianGUID = creature->GetGUID();
                    break;
                case NPC_LORD_SANGUINAR:
                    LordSanguinarGUID = creature->GetGUID();
                    break;
            }
            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* gobject) override
        {
            switch (gobject->GetEntry())
            {
                case GO_BRIDGE_WINDOW:
                    BridgeWindowGUID = gobject->GetGUID();
                    break;
                case GO_KAEL_STATUE_RIGHT:
                    KaelStateRightGUID = gobject->GetGUID();
                    break;
                case GO_KAEL_STATUE_LEFT:
                    KaelStateLeftGUID = gobject->GetGUID();
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case GO_BRIDGE_WINDOW:
                    return BridgeWindowGUID;
                case GO_KAEL_STATUE_RIGHT:
                    return KaelStateRightGUID;
                case GO_KAEL_STATUE_LEFT:
                    return KaelStateLeftGUID;
                case NPC_ALAR:
                    return AlarGUID;
                case NPC_KAELTHAS:
                    return KaelthasGUID;
            }

            return ObjectGuid::Empty;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_the_eye_InstanceMapScript(map);
    }
};

class spell_the_eye_countercharge : public SpellScriptLoader
{
public:
    spell_the_eye_countercharge() : SpellScriptLoader("spell_the_eye_countercharge") { }

    class spell_the_eye_counterchargeScript : public AuraScript
    {
        PrepareAuraScript(spell_the_eye_counterchargeScript);

        bool PrepareProc(ProcEventInfo&  /*eventInfo*/)
        {
            // xinef: prevent charge drop
            PreventDefaultAction();
            return true;
        }

        void Register() override
        {
            DoCheckProc += AuraCheckProcFn(spell_the_eye_counterchargeScript::PrepareProc);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_the_eye_counterchargeScript();
    }
};

void AddSC_instance_the_eye()
{
    new instance_the_eye();
    new spell_the_eye_countercharge();
}

