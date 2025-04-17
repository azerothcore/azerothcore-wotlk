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
#include "scarletmonastery.h"
#include "ScriptedCreature.h"

enum AshbringerEventMisc
{
    NPC_COMMANDER_MOGRAINE         = 3976,
    NPC_INQUISITOR_WHITEMANE       = 3977,
    NPC_SCARLET_SORCERER           = 4294,
    NPC_SCARLET_MYRIDON            = 4295,
    NPC_SCARLET_DEFENDER           = 4298,
    NPC_SCARLET_CHAPLAIN           = 4299,
    NPC_SCARLET_WIZARD             = 4300,
    NPC_SCARLET_CENTURION          = 4301,
    NPC_SCARLET_CHAMPION           = 4302,
    NPC_SCARLET_ABBOT              = 4303,
    NPC_SCARLET_MONK               = 4540,
    NPC_FAIRBANKS                  = 4542,
    NPC_HIGHLORD_MOGRAINE          = 16062,

    GO_CHAPEL_DOOR                 = 104591,
    GO_HIGH_INQUISITOR_DOOR        = 104600
};

enum AshbringerSpell
{
    //Highlord Mograine Spells
    //Needs Fix: Increased the visual effect of spells on hit
    SPELL_FORGIVENESS               = 28697,

    //High Inquisitor Fairbanks
    //Needs Fix: Increased the visual effect of spells on hit
    SPELL_TRANSFORM_GHOST           = 28443
};

enum DataTypes
{
    TYPE_MOGRAINE_AND_WHITE_EVENT = 1,
    TYPE_ASHBRINGER_EVENT         = 2,

    DATA_MOGRAINE                 = 3,
    DATA_WHITEMANE                = 4,
    DATA_DOOR_WHITEMANE           = 5,
    DATA_HORSEMAN_EVENT           = 6,
    DATA_VORREL                   = 7,
    DATA_ARCANIST_DOAN            = 8,
    DATA_DOOR_CHAPEL              = 9,

    GAMEOBJECT_PUMPKIN_SHRINE     = 10
};

float const CATHEDRAL_PULL_RANGE = 80.0f; // Distance from the Cathedral doors to where Mograine is standing

class instance_scarlet_monastery : public InstanceMapScript
{
public:
    instance_scarlet_monastery() : InstanceMapScript("instance_scarlet_monastery", 189) {}

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_scarlet_monastery_InstanceMapScript(map);
    }

    struct instance_scarlet_monastery_InstanceMapScript : public InstanceScript
    {
        instance_scarlet_monastery_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                // case ENTRY_PUMPKIN_SHRINE: PumpkinShrineGUID = go->GetGUID(); break;
                case GO_HIGH_INQUISITOR_DOOR:
                    _doorHighInquisitorGUID = go->GetGUID();
                    break;
                case GO_CHAPEL_DOOR:
                    _doorChapelGUID = go->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SCARLET_MYRIDON:
                case NPC_SCARLET_DEFENDER:
                case NPC_SCARLET_CENTURION:
                case NPC_SCARLET_SORCERER:
                case NPC_SCARLET_WIZARD:
                case NPC_SCARLET_ABBOT:
                case NPC_SCARLET_MONK:
                case NPC_SCARLET_CHAMPION:
                case NPC_SCARLET_CHAPLAIN:
                case NPC_FAIRBANKS:
                    _ashbringerNpcGUID.emplace(creature->GetGUID());
                    break;
                case NPC_COMMANDER_MOGRAINE:
                    _mograineGUID = creature->GetGUID();
                    _ashbringerNpcGUID.emplace(creature->GetGUID());
                    break;
                case NPC_INQUISITOR_WHITEMANE:
                   _whitemaneGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_MOGRAINE_AND_WHITE_EVENT:
                    if (data == IN_PROGRESS)
                    {
                        if (Creature* mograine = instance->GetCreature(_mograineGUID))
                        {
                            std::list<Creature*> creatureList;
                            GetCreatureListWithEntryInGrid(creatureList, mograine, NPC_SCARLET_MONK, CATHEDRAL_PULL_RANGE);
                            GetCreatureListWithEntryInGrid(creatureList, mograine, NPC_SCARLET_ABBOT, CATHEDRAL_PULL_RANGE);
                            GetCreatureListWithEntryInGrid(creatureList, mograine, NPC_SCARLET_CHAMPION, CATHEDRAL_PULL_RANGE);
                            GetCreatureListWithEntryInGrid(creatureList, mograine, NPC_SCARLET_CENTURION, CATHEDRAL_PULL_RANGE);
                            GetCreatureListWithEntryInGrid(creatureList, mograine, NPC_SCARLET_WIZARD, CATHEDRAL_PULL_RANGE);
                            GetCreatureListWithEntryInGrid(creatureList, mograine, NPC_SCARLET_CHAPLAIN, CATHEDRAL_PULL_RANGE);
                            for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
                            {
                                if (Creature* creature = *itr)
                                    creature->AI()->AttackStart(mograine->GetVictim());
                            }
                        }
                        _encounter = IN_PROGRESS;
                    }
                    if (data == FAIL)
                    {
                        Creature* whitemane = instance->GetCreature(_whitemaneGUID);
                        if (!whitemane)
                            return;

                        Creature* mograine = instance->GetCreature(_mograineGUID);
                        if (!mograine)
                            return;

                        if (whitemane->IsAlive() && mograine->IsAlive())
                        {
                            // When Whitemane emerges from the main gate, Whitemane will stand next to Mograine's corpse and will not reset Whitemane
                            if (whitemane->IsEngaged()||whitemane->IsInEvadeMode())
                                whitemane->DespawnOnEvade(20s);

                            mograine->DespawnOnEvade(20s);
                            _encounter = NOT_STARTED;
                            return;
                        }

                        // Whitemane will not be able to fight Mograine again when he dies
                        if (!whitemane->IsAlive())
                        {
                            mograine->DespawnOrUnsummon();
                            _encounter = data;
                            return;
                        }

                        if (whitemane->IsAlive() && !mograine->IsAlive())
                        {
                            whitemane->DespawnOnEvade(20s);
                            _encounter = data;
                            return;
                        }

                        _encounter = data;
                    }
                    if (data == DONE)
                        _encounter = DONE;
                    break;
                case TYPE_ASHBRINGER_EVENT:
                    if (data == IN_PROGRESS)
                    {
                        // the ashbringer incident did not sniff out any data from whitemane
                        if (Creature* whitemane = instance->GetCreature(_whitemaneGUID))
                            if (whitemane->IsAlive() && !whitemane->IsEngaged())
                                whitemane->DespawnOrUnsummon();

                        if (GameObject* go = instance->GetGameObject(_doorChapelGUID))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                            go->SetLootState(GO_ACTIVATED);
                            go->SetGameObjectFlag(GO_FLAG_IN_USE);
                        }

                        for (auto const& scarletCathedralNpcGuid : _ashbringerNpcGUID)
                            if (Creature* scarletNpc = instance->GetCreature(scarletCathedralNpcGuid))
                                if (scarletNpc->IsAlive() && !scarletNpc->IsEngaged())
                                    scarletNpc->SetFaction(FACTION_FRIENDLY);
                    }
                    _ashencounter = data;
                    break;
                case DATA_HORSEMAN_EVENT:
                    _encounter = data;
                    break;
                default:
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_MOGRAINE:
                    return _mograineGUID;
                case DATA_WHITEMANE:
                    return _whitemaneGUID;
                case DATA_DOOR_WHITEMANE:
                    return _doorHighInquisitorGUID;
                case DATA_DOOR_CHAPEL:
                    return _doorChapelGUID;
                default:
                    return ObjectGuid::Empty;
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case TYPE_MOGRAINE_AND_WHITE_EVENT:
                    return _encounter;
                    break;
                case DATA_HORSEMAN_EVENT:
                    return _encounter;
                    break;
                case TYPE_ASHBRINGER_EVENT:
                    return _ashencounter;
                    break;
                default:
                    return 0;
                    break;
            }
        }
    private:
        ObjectGuid _doorHighInquisitorGUID;
        ObjectGuid _doorChapelGUID;
        ObjectGuid _mograineGUID;
        ObjectGuid _whitemaneGUID;
        uint32 _encounter{};
        uint32 _ashencounter{};
        GuidSet _ashbringerNpcGUID;
    };
};

void AddSC_instance_scarlet_monastery()
{
    new instance_scarlet_monastery();
}
