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

/* ScriptData
SDName: Instance_ZulGurub
SD%Complete: 80
SDComment: Missing reset function after killing a boss for Ohgan, Thekal.
SDCategory: Zul'Gurub
EndScriptData */

#include "GameEventMgr.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "zulgurub.h"

DoorData const doorData[] =
{
    { GO_FORCEFIELD, DATA_ARLOKK, DOOR_TYPE_ROOM },
    { 0,             0,           DOOR_TYPE_ROOM }
};

ObjectData const creatureData[] =
{
    { NPC_HIGH_PRIEST_THEKAL, DATA_THEKAL  },
    { NPC_ZEALOT_LORKHAN,     DATA_LORKHAN },
    { NPC_ZEALOT_ZATH,        DATA_ZATH    },
    { NPC_PRIESTESS_MARLI,    DATA_MARLI   },
    { 0,                      0            }
};

class instance_zulgurub : public InstanceMapScript
{
public:
    instance_zulgurub(): InstanceMapScript(ZGScriptName, 309) { }

    struct instance_zulgurub_InstanceMapScript : public InstanceScript
    {
        instance_zulgurub_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, nullptr);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_JINDO_THE_HEXXER:
                    _jindoTheHexxerGUID = creature->GetGUID();
                    break;
                case NPC_VILEBRANCH_SPEAKER:
                    _vilebranchSpeakerGUID = creature->GetGUID();
                    break;
                case NPC_ARLOKK:
                    _arlokkGUID = creature->GetGUID();
                    break;
                case NPC_HAKKAR:
                    _hakkarGUID = creature->GetGUID();
                    break;
                case NPC_SPAWN_OF_MARLI:
                    if (Creature* marli = GetCreature(DATA_MARLI))
                    {
                        marli->AI()->JustSummoned(creature);
                    }
                    break;
                case NPC_GAHZRANKA:
                    _gahzrankaGUID = creature->GetGUID();
                    break;
                case NPC_GRILEK:
                case NPC_HAZZARAH:
                case NPC_RENATAKI:
                case NPC_WUSHOOLAY:
                    _edgeOfMadnessGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            switch (go->GetEntry())
            {
                case GO_GONG_OF_BETHEKK:
                    _goGongOfBethekkGUID = go->GetGUID();
                    if (GetBossState(DATA_ARLOKK) == DONE)
                        go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    else
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                default:
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 uiData) const override
        {
            switch (uiData)
            {
                case DATA_JINDO:
                    return _jindoTheHexxerGUID;
                case NPC_ARLOKK:
                    return _arlokkGUID;
                case GO_GONG_OF_BETHEKK:
                    return _goGongOfBethekkGUID;
                case DATA_HAKKAR:
                    return _hakkarGUID;
                case DATA_EDGE_OF_MADNESS:
                    return _edgeOfMadnessGUID;
            }

            return ObjectGuid::Empty;
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_GAHZRANKA)
            {
                return _gahzrankaGUID || GetBossState(DATA_GAHZRANKA) == DONE;
            }

            return 0;
        }

        void RemoveHakkarPowerStack()
        {
            if (Creature* hakkar = instance->GetCreature(_hakkarGUID))
            {
                hakkar->CastSpell(hakkar, SPELL_HAKKAR_POWER_DOWN, true);
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_JEKLIK:
                case DATA_VENOXIS:
                case DATA_MARLI:
                case DATA_ARLOKK:
                case DATA_THEKAL:
                    if (state == DONE)
                        RemoveHakkarPowerStack();
                    break;
                default:
                    break;
            }

            return true;
        }

    private:
        // If all High Priest bosses were killed. Ohgan is added too.
        // Jindo is needed for healfunction.

        ObjectGuid _jindoTheHexxerGUID;
        ObjectGuid _vilebranchSpeakerGUID;
        ObjectGuid _arlokkGUID;
        ObjectGuid _goGongOfBethekkGUID;
        ObjectGuid _hakkarGUID;
        ObjectGuid _gahzrankaGUID;
        ObjectGuid _edgeOfMadnessGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_zulgurub_InstanceMapScript(map);
    }
};

enum EdgeOfMadnessEnum
{
    EVENT_EDGE_OF_MADNESS_GRILEK    = 27,
    EVENT_EDGE_OF_MADNESS_HAZZARAH  = 28,
    EVENT_EDGE_OF_MADNESS_RENATAKI  = 29,
    EVENT_EDGE_OF_MADNESS_WUSHOOLAY = 30
};

std::vector<std::pair<uint32, uint32>> BrazierOfMadnessContainer =
{
    { EVENT_EDGE_OF_MADNESS_GRILEK,     NPC_GRILEK      },
    { EVENT_EDGE_OF_MADNESS_HAZZARAH,   NPC_HAZZARAH    },
    { EVENT_EDGE_OF_MADNESS_RENATAKI,   NPC_RENATAKI    },
    { EVENT_EDGE_OF_MADNESS_WUSHOOLAY,  NPC_WUSHOOLAY   }
};

Position const edgeOfMagnessSummonPos = { -11901.229f, -1906.366f, 65.358f, 0.942f };

struct go_brazier_of_madness : public GameObjectAI
{
    go_brazier_of_madness(GameObject* go) : GameObjectAI(go) { }

    bool GossipHello(Player* /*player*/, bool reportUse) override
    {
        if (reportUse)
        {
            return true;
        }

        if (InstanceScript* instanceScript = me->GetInstanceScript())
        {
            if (instanceScript->GetGuidData(DATA_EDGE_OF_MADNESS))
            {
                return false;
            }
        }

        uint32 bossEntry = 0;
        for (uint8 i = 0; i < 4; ++i)
        {
            if (sGameEventMgr->IsActiveEvent(BrazierOfMadnessContainer[i].first))
            {
                bossEntry = BrazierOfMadnessContainer[i].second;
                break;
            }
        }

        if (bossEntry)
        {
            me->SummonCreature(bossEntry, edgeOfMagnessSummonPos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2 * HOUR * IN_MILLISECONDS);
        }

        return false;
    }
};

void AddSC_instance_zulgurub()
{
    new instance_zulgurub();
    RegisterGameObjectAI(go_brazier_of_madness);
}
