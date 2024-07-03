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

#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "SpellScriptLoader.h"
#include "TemporarySummon.h"
#include "zulfarrak.h"

enum Misc
{
    // Paths
    PATH_ADDS           = 81553,

    SAY_BLY_FORWARD     = 2
};

struct PyramidEventData
{
    uint8 waveID = 0;
    uint32 creatureID = 0;
    Position pos;
};

uint32 const pyramidSpawnTotal = 54;

/* list of wave spawns: 0 = wave ID, 1 = creature id, 2 = x, 3 = y
no z coordinat b/c they're all the same */
static PyramidEventData pyramidSpawns[pyramidSpawnTotal] =
{
    { 1, NPC_SANDFURY_CRETIN,   { 1894.64f, 1206.29f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1890.08f, 1218.68f } },
    { 1, NPC_SANDFURY_ACOLYTE,  { 1883.76f, 1222.30f } },
    { 1, NPC_SANDFURY_CRETIN,   { 1874.18f, 1221.24f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1892.28f, 1225.49f } },
    { 1, NPC_SANDFURY_DRUDGE,   { 1889.94f, 1212.21f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1879.02f, 1223.06f } },
    { 1, NPC_SANDFURY_CRETIN,   { 1874.45f, 1204.44f } },
    { 1, NPC_SANDFURY_ACOLYTE,  { 1898.23f, 1217.97f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1882.07f, 1225.70f } },
    { 1, NPC_SANDFURY_ZEALOT,   { 1896.46f, 1205.62f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1886.97f, 1225.86f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1894.72f, 1221.91f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1883.50f, 1218.25f } },
    { 1, NPC_SANDFURY_SLAVE,    { 1886.93f, 1221.40f } },
    { 1, NPC_SANDFURY_ACOLYTE,  { 1889.82f, 1222.51f } },
    { 1, NPC_SANDFURY_DRUDGE,   { 1893.07f, 1215.26f } },
    { 1, NPC_SANDFURY_DRUDGE,   { 1878.57f, 1214.16f } },
    { 1, NPC_SANDFURY_DRUDGE,   { 1883.74f, 1212.35f } },
    { 1, NPC_SANDFURY_ZEALOT,   { 1877.00f, 1207.27f } },
    { 1, NPC_SANDFURY_ZEALOT,   { 1873.63f, 1204.65f } },
    { 1, NPC_SANDFURY_ACOLYTE,  { 1877.40f, 1216.41f } },
    { 1, NPC_SANDFURY_ZEALOT,   { 1899.63f, 1202.52f } },
    { 2, NPC_SANDFURY_CRETIN,   { 1902.83f, 1223.41f } },
    { 2, NPC_SANDFURY_ACOLYTE,  { 1889.82f, 1222.51f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1883.50f, 1218.25f } },
    { 2, NPC_SANDFURY_DRUDGE,   { 1883.74f, 1212.35f } },
    { 2, NPC_SANDFURY_ZEALOT,   { 1877.00f, 1207.27f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1890.08f, 1218.68f } },
    { 2, NPC_SANDFURY_CRETIN,   { 1894.64f, 1206.29f } },
    { 2, NPC_SANDFURY_ACOLYTE,  { 1877.40f, 1216.41f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1892.28f, 1225.49f } },
    { 2, NPC_SANDFURY_DRUDGE,   { 1893.07f, 1215.26f } },
    { 2, NPC_SANDFURY_ZEALOT,   { 1896.46f, 1205.62f } },
    { 2, NPC_SANDFURY_CRETIN,   { 1874.45f, 1204.44f } },
    { 2, NPC_SANDFURY_CRETIN,   { 1874.18f, 1221.24f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1879.02f, 1223.06f } },
    { 2, NPC_SANDFURY_ACOLYTE,  { 1898.23f, 1217.97f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1882.07f, 1225.70f } },
    { 2, NPC_SANDFURY_ZEALOT,   { 1873.63f, 1204.65f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1886.97f, 1225.86f } },
    { 2, NPC_SANDFURY_DRUDGE,   { 1878.57f, 1214.16f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1894.72f, 1221.91f } },
    { 2, NPC_SANDFURY_SLAVE,    { 1886.93f, 1221.40f } },
    { 2, NPC_SANDFURY_ACOLYTE,  { 1883.76f, 1222.30f } },
    { 2, NPC_SANDFURY_DRUDGE,   { 1889.94f, 1212.21f } },
    { 2, NPC_SANDFURY_ZEALOT,   { 1899.63f, 1202.52f } },
    { 3, NPC_SANDFURY_DRUDGE,   { 1878.57f, 1214.16f } },
    { 3, NPC_SANDFURY_SLAVE,    { 1894.72f, 1221.91f } },
    { 3, NPC_SANDFURY_SLAVE,    { 1886.93f, 1221.40f } },
    { 3, NPC_SANDFURY_ACOLYTE,  { 1883.76f, 1222.30f } },
    { 3, NPC_SANDFURY_DRUDGE,   { 1889.94f, 1212.21f } },
    { 3, NPC_SHADOWPRIEST_SEZZZIZ, { 1886.30f, 1199.65f } },
    { 3, NPC_NEKRUM_GUTCHEWER,  { 1881.06f, 1199.70f } }
};

class instance_zulfarrak : public InstanceMapScript
{
public:
    instance_zulfarrak() : InstanceMapScript(ZFScriptName, 209) {}

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_zulfarrak_InstanceMapScript(map);
    }

    struct instance_zulfarrak_InstanceMapScript : public InstanceScript
    {
        instance_zulfarrak_InstanceMapScript(Map* map) : InstanceScript(map) { }

        ObjectGuid EndDoorGUID;
        ObjectGuid BlyGUID;
        ObjectGuid WeegliGUID;
        ObjectGuid OroGUID;
        ObjectGuid RavenGUID;
        ObjectGuid MurtaGUID;
        ObjectGuid ShadowpriestGUID;

        GuidList addsAtBase;
        GuidList movedadds;

        uint32 GahzrillaSummoned;
        uint32 PyramidPhase;
        uint32 major_wave_Timer;
        uint32 minor_wave_Timer;
        uint32 addGroupSize;
        uint32 waypoint;

        void Initialize() override
        {
            SetHeaders(DataHeader);
            GahzrillaSummoned = NOT_STARTED;

            PyramidPhase = 0;
            major_wave_Timer = 0;
            minor_wave_Timer = 0;
            addGroupSize = 0;
            waypoint = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_BLY:
                    BlyGUID = creature->GetGUID();
                    creature->SetReactState(REACT_PASSIVE); // starts out passive (in a cage)
                    break;
                case NPC_RAVEN:
                    RavenGUID = creature->GetGUID();
                    creature->SetReactState(REACT_PASSIVE);// starts out passive (in a cage)
                    break;
                case NPC_ORO:
                    OroGUID = creature->GetGUID();
                    creature->SetReactState(REACT_PASSIVE);// starts out passive (in a cage)
                    break;
                case NPC_WEEGLI:
                    WeegliGUID = creature->GetGUID();
                    creature->SetReactState(REACT_PASSIVE);// starts out passive (in a cage)
                    break;
                case NPC_MURTA:
                    MurtaGUID = creature->GetGUID();
                    creature->SetReactState(REACT_PASSIVE);// starts out passive (in a cage)
                    break;
                case NPC_SHADOWPRIEST_SEZZZIZ:
                    ShadowpriestGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_END_DOOR:
                    EndDoorGUID = gameobject->GetGUID();
                    if (PyramidPhase == PYRAMID_DONE)
                    {
                        HandleGameObject(gameobject->GetGUID(), true, gameobject);
                    }
                    break;
                default:
                    break;
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (unit->GetEntry() == NPC_BLY)
            {
                PyramidPhase = PYRAMID_DONE;
                SaveToDB();
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_PYRAMID:
                    PyramidPhase = data;
                    break;
                case DATA_GAHZRILLA:
                    GahzrillaSummoned = data;
                    break;
                default:
                    break;
            }

            SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_PYRAMID:
                    return PyramidPhase;
                case DATA_GAHZRILLA:
                    return GahzrillaSummoned;
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                case NPC_BLY:
                    return BlyGUID;
                case NPC_RAVEN:
                    return RavenGUID;
                case NPC_ORO:
                    return OroGUID;
                case NPC_WEEGLI:
                    return WeegliGUID;
                case NPC_MURTA:
                    return MurtaGUID;
                case NPC_SHADOWPRIEST_SEZZZIZ:
                    return ShadowpriestGUID;
                case GO_END_DOOR:
                    return EndDoorGUID;
            }

            return ObjectGuid::Empty;
        }

        void Update(uint32 diff) override
        {
            switch (PyramidPhase)
            {
                case PYRAMID_NOT_STARTED:
                case PYRAMID_KILLED_ALL_TROLLS:
                case PYRAMID_MOVED_DOWNSTAIRS:
                case PYRAMID_DESTROY_GATES:
                case PYRAMID_GATES_DESTROYED:
                case PYRAMID_DONE:
                    break;
                case PYRAMID_ARRIVED_AT_STAIR:
                    SpawnPyramidWave(1);
                    SetData(DATA_PYRAMID, PYRAMID_WAVE_1);
                    major_wave_Timer = 2 * MINUTE * IN_MILLISECONDS;
                    minor_wave_Timer = 0;
                    addGroupSize = 2;
                    break;
                case PYRAMID_WAVE_1:
                    if (IsWaveAllDead())
                    {
                        SetData(DATA_PYRAMID, PYRAMID_PRE_WAVE_2);
                        major_wave_Timer = 10 * IN_MILLISECONDS; //give players a few seconds before wave 2 starts to rebuff
                    }
                    else
                    {
                        if (minor_wave_Timer <= diff)
                        {
                            SendAddsUpStairs(addGroupSize++);
                            minor_wave_Timer = 10 * IN_MILLISECONDS;
                        }
                        else
                        {
                            minor_wave_Timer -= diff;
                        }
                    }
                    break;
                case PYRAMID_PRE_WAVE_2:
                    if (major_wave_Timer <= diff)
                    {
                        // beginning 2nd wave!
                        SpawnPyramidWave(2);
                        SetData(DATA_PYRAMID, PYRAMID_WAVE_2);
                        minor_wave_Timer = 0;
                        addGroupSize = 2;
                    }
                    else
                    {
                        major_wave_Timer -= diff;
                    }
                    break;
                case PYRAMID_WAVE_2:
                    if (IsWaveAllDead())
                    {
                        SpawnPyramidWave(3);
                        SetData(DATA_PYRAMID, PYRAMID_PRE_WAVE_3);
                        major_wave_Timer = 5 * IN_MILLISECONDS; //give NPCs time to return to their home spots
                    }
                    else
                    {
                        if (minor_wave_Timer <= diff)
                        {
                            SendAddsUpStairs(addGroupSize++);
                            minor_wave_Timer = 10 * IN_MILLISECONDS;
                        }
                        else
                        {
                            minor_wave_Timer -= diff;
                        }
                    }
                    break;
                case PYRAMID_PRE_WAVE_3:
                    if (major_wave_Timer <= diff)
                    {
                        // move NPCs to bottom of stair
                        MoveNPCIfAlive(NPC_BLY, 1887.92f, 1228.179f, 9.98f, 4.78f);
                        MoveNPCIfAlive(NPC_MURTA, 1891.57f, 1228.68f, 9.69f, 4.78f);
                        MoveNPCIfAlive(NPC_ORO, 1897.23f, 1228.34f, 9.43f, 4.78f);
                        MoveNPCIfAlive(NPC_RAVEN, 1883.68f, 1227.95f, 9.543f, 4.78f);
                        MoveNPCIfAlive(NPC_WEEGLI, 1878.02f, 1227.65f, 9.485f, 4.78f);
                        SetData(DATA_PYRAMID, PYRAMID_WAVE_3);
                        if (Creature* sergeantBlye = instance->GetCreature(BlyGUID))
                        {
                            sergeantBlye->AI()->Talk(SAY_BLY_FORWARD);
                        }
                    }
                    else
                    {
                        major_wave_Timer -= diff;
                    }
                    break;
                case PYRAMID_WAVE_3:
                    if (IsWaveAllDead()) // move NPCS to their final positions
                    {
                        SetData(DATA_PYRAMID, PYRAMID_KILLED_ALL_TROLLS);
                        MoveNPCIfAlive(NPC_BLY, 1883.82f, 1200.83f, 8.87f, 1.32f);
                        MoveNPCIfAlive(NPC_MURTA, 1891.83f, 1201.45f, 8.87f, 1.32f);
                        MoveNPCIfAlive(NPC_ORO, 1894.50f, 1204.40f, 8.87f, 1.32f);
                        MoveNPCIfAlive(NPC_RAVEN, 1874.11f, 1206.17f, 8.87f, 1.32f);
                        MoveNPCIfAlive(NPC_WEEGLI, 1877.52f, 1199.63f, 8.87f, 1.32f);
                    }
                    break;
                default:
                    break;
            };
        }

        void MoveNPCIfAlive(uint32 entry, float x, float y, float z, float o)
        {
           if (Creature* npc = instance->GetCreature(GetGuidData(entry)))
           {
               if (npc->IsAlive())
               {
                    npc->SetWalk(true);
                    npc->GetMotionMaster()->MovePoint(1, { x, y, z, o } );
                    npc->SetHomePosition(x, y, z, o);
               }
            }
        }

        void SpawnPyramidWave(uint32 wave)
        {
            for (uint32 i = 0; i < pyramidSpawnTotal; i++)
            {
                if (pyramidSpawns[i].waveID == wave)
                {
                    float orientation = 4.78f;
                    if (pyramidSpawns[i].creatureID == NPC_SHADOWPRIEST_SEZZZIZ || pyramidSpawns[i].creatureID == NPC_NEKRUM_GUTCHEWER)
                    {
                        orientation = 1.32f;
                    }

                    Position pos = { pyramidSpawns[i].pos.GetPositionX(), pyramidSpawns[i].pos.GetPositionY(), 8.87f, orientation };
                    if (TempSummon* ts = instance->SummonCreature(pyramidSpawns[i].creatureID, pos))
                    {
                        addsAtBase.push_back(ts->GetGUID());

                        if (pyramidSpawns[i].creatureID != NPC_SHADOWPRIEST_SEZZZIZ && pyramidSpawns[i].creatureID != NPC_NEKRUM_GUTCHEWER)
                        {
                            ts->GetMotionMaster()->MoveRandom(10);
                        }
                    }
                }
            }
        }

        bool IsWaveAllDead()
        {
            for (GuidList::iterator itr = addsAtBase.begin(); itr != addsAtBase.end(); ++itr)
            {
                if (Creature* add = instance->GetCreature((*itr)))
                {
                    if (add->IsAlive())
                    {
                        return false;
                    }
                }
            }

            for (GuidList::iterator itr = movedadds.begin(); itr != movedadds.end(); ++itr)
            {
                if (Creature* add = instance->GetCreature(((*itr))))
                {
                    if (add->IsAlive())
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        void SendAddsUpStairs(uint32 count)
        {
            //pop a add from list, send him up the stairs...
            for (uint32 addCount = 0; addCount < count && !addsAtBase.empty(); addCount++)
            {
                if (Creature* add = instance->GetCreature(*addsAtBase.begin()))
                {
                    add->GetMotionMaster()->MovePath(PATH_ADDS, false);
                    movedadds.push_back(add->GetGUID());
                }

                addsAtBase.erase(addsAtBase.begin());
            }
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> PyramidPhase;
            data >> GahzrillaSummoned;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << PyramidPhase << ' ' << GahzrillaSummoned;
        }
    };
};

// 10247 - Summon Zul'Farrak Zombies
class spell_zulfarrak_summon_zulfarrak_zombies : public SpellScript
{
    PrepareSpellScript(spell_zulfarrak_summon_zulfarrak_zombies);

    void HandleSummon(SpellEffIndex effIndex)
    {
        if (effIndex == EFFECT_0)
        {
            if (roll_chance_i(30))
            {
                PreventHitDefaultEffect(effIndex);
                return;
            }
        }
        else if (roll_chance_i(40))
        {
            PreventHitDefaultEffect(effIndex);
            return;
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_zulfarrak_summon_zulfarrak_zombies::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
        OnEffectHit += SpellEffectFn(spell_zulfarrak_summon_zulfarrak_zombies::HandleSummon, EFFECT_1, SPELL_EFFECT_SUMMON);
    }
};

// 10738 - Unlocking
class spell_zulfarrak_unlocking : public SpellScript
{
    PrepareSpellScript(spell_zulfarrak_unlocking);

    void HandleOpenLock(SpellEffIndex  /*effIndex*/)
    {
        GameObject* cage = GetHitGObj();
        std::list<WorldObject*> cagesList;
        Acore::AllWorldObjectsInRange objects(GetCaster(), 15.0f);
        Acore::WorldObjectListSearcher<Acore::AllWorldObjectsInRange> searcher(GetCaster(), cagesList, objects);
        Cell::VisitAllObjects(GetCaster(), searcher, 15.0f);
        for (std::list<WorldObject*>::const_iterator itr = cagesList.begin(); itr != cagesList.end(); ++itr)
        {
            if (GameObject* go = (*itr)->ToGameObject())
                if (go->GetDisplayId() == cage->GetDisplayId())
                    go->UseDoorOrButton(0, false, GetCaster());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_zulfarrak_unlocking::HandleOpenLock, EFFECT_0, SPELL_EFFECT_OPEN_LOCK);
    }
};

void AddSC_instance_zulfarrak()
{
    new instance_zulfarrak();
    RegisterSpellScript(spell_zulfarrak_summon_zulfarrak_zombies);
    RegisterSpellScript(spell_zulfarrak_unlocking);
}

