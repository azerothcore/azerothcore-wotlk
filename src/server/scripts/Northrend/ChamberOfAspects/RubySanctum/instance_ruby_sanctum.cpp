/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "InstanceScript.h"
#include "Player.h"
#include "ruby_sanctum.h"
#include "ScriptMgr.h"
#include "TemporarySummon.h"
#include "WorldPacket.h"

DoorData const doorData[] =
{
    {GO_FIRE_FIELD,     DATA_BALTHARUS_THE_WARBORN, DOOR_TYPE_PASSAGE,  BOUNDARY_E   },
    {GO_FLAME_WALLS,    DATA_SAVIANA_RAGEFIRE,      DOOR_TYPE_PASSAGE,  BOUNDARY_NONE},
    {GO_FLAME_WALLS,    DATA_BALTHARUS_THE_WARBORN, DOOR_TYPE_PASSAGE,  BOUNDARY_NONE},
    {GO_FLAME_WALLS,    DATA_GENERAL_ZARITHRIAN,    DOOR_TYPE_ROOM,     BOUNDARY_NONE},
    {GO_BURNING_TREE_4, DATA_HALION_INTRO1,         DOOR_TYPE_PASSAGE,  BOUNDARY_NONE},
    {GO_BURNING_TREE_3, DATA_HALION_INTRO1,         DOOR_TYPE_PASSAGE,  BOUNDARY_NONE},
    {GO_BURNING_TREE_2, DATA_HALION_INTRO2,         DOOR_TYPE_PASSAGE,  BOUNDARY_NONE},
    {GO_BURNING_TREE_1, DATA_HALION_INTRO2,         DOOR_TYPE_PASSAGE,  BOUNDARY_NONE},
    {GO_TWILIGHT_FLAME_RING, DATA_HALION,           DOOR_TYPE_ROOM,     BOUNDARY_NONE},
    {0,                 0,                          DOOR_TYPE_ROOM,     BOUNDARY_NONE},
};

class instance_ruby_sanctum : public InstanceMapScript
{
public:
    instance_ruby_sanctum() : InstanceMapScript("instance_ruby_sanctum", 724) { }

    struct instance_ruby_sanctum_InstanceMapScript : public InstanceScript
    {
        instance_ruby_sanctum_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
        }

        void OnPlayerEnter(Player* /*player*/) override
        {
            if (GetBossState(DATA_HALION_INTRO_DONE) != DONE && GetBossState(DATA_GENERAL_ZARITHRIAN) == DONE)
            {
                instance->LoadGrid(3156.0f, 537.0f);
                if (Creature* halionController = instance->GetCreature(HalionControllerGUID))
                    halionController->AI()->DoAction(ACTION_INTRO_HALION);
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_BALTHARUS_THE_WARBORN:
                    BaltharusTheWarbornGUID = creature->GetGUID();
                    break;
                case NPC_XERESTRASZA:
                    XerestraszaGUID = creature->GetGUID();
                    break;
                case NPC_GENERAL_ZARITHRIAN:
                    GeneralZarithrianGUID = creature->GetGUID();
                    break;
                case NPC_ZARITHRIAN_SPAWN_STALKER:
                    if (!ZarithrianSpawnStalkerGUID[0])
                        ZarithrianSpawnStalkerGUID[0] = creature->GetGUID();
                    else
                        ZarithrianSpawnStalkerGUID[1] = creature->GetGUID();
                    break;
                case NPC_HALION:
                    HalionGUID = creature->GetGUID();
                    break;
                case NPC_TWILIGHT_HALION:
                    TwilightHalionGUID = creature->GetGUID();
                    break;
                case NPC_HALION_CONTROLLER:
                    HalionControllerGUID = creature->GetGUID();
                    break;
                case NPC_ORB_CARRIER:
                    OrbCarrierGUID = creature->GetGUID();
                    break;

                case NPC_LIVING_INFERNO:
                case NPC_LIVING_EMBER:
                case NPC_METEOR_STRIKE_NORTH:
                case NPC_METEOR_STRIKE_SOUTH:
                case NPC_METEOR_STRIKE_EAST:
                case NPC_METEOR_STRIKE_WEST:
                case NPC_METEOR_STRIKE_FLAME:
                case NPC_COMBUSTION:
                case NPC_CONSUMPTION:
                    if (Creature* halion = instance->GetCreature(HalionGUID))
                        halion->AI()->JustSummoned(creature);
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FIRE_FIELD:
                case GO_FLAME_WALLS:
                case GO_BURNING_TREE_1:
                case GO_BURNING_TREE_2:
                case GO_BURNING_TREE_3:
                case GO_BURNING_TREE_4:
                case GO_TWILIGHT_FLAME_RING:
                    AddDoor(go, true);
                    break;
                case GO_FLAME_RING:
                    FlameRingGUID = go->GetGUID();
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FIRE_FIELD:
                case GO_FLAME_WALLS:
                case GO_BURNING_TREE_1:
                case GO_BURNING_TREE_2:
                case GO_BURNING_TREE_3:
                case GO_BURNING_TREE_4:
                    AddDoor(go, false);
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case NPC_BALTHARUS_THE_WARBORN:
                    return BaltharusTheWarbornGUID;
                case NPC_XERESTRASZA:
                    return XerestraszaGUID;
                case NPC_GENERAL_ZARITHRIAN:
                    return GeneralZarithrianGUID;
                case DATA_ZARITHRIAN_SPAWN_STALKER_1:
                case DATA_ZARITHRIAN_SPAWN_STALKER_2:
                    return ZarithrianSpawnStalkerGUID[type - DATA_ZARITHRIAN_SPAWN_STALKER_1];
                case NPC_HALION_CONTROLLER:
                    return HalionControllerGUID;
                case NPC_HALION:
                    return HalionGUID;
                case NPC_TWILIGHT_HALION:
                    return TwilightHalionGUID;
                case NPC_ORB_CARRIER:
                    return OrbCarrierGUID;

                case GO_FLAME_RING:
                    return FlameRingGUID;
            }

            return ObjectGuid::Empty;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_SAVIANA_RAGEFIRE:
                case DATA_BALTHARUS_THE_WARBORN:
                    if (GetBossState(DATA_BALTHARUS_THE_WARBORN) == DONE && GetBossState(DATA_SAVIANA_RAGEFIRE) == DONE)
                        if (Creature* zarithrian = instance->GetCreature(GeneralZarithrianGUID))
                            zarithrian->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                    break;
                case DATA_GENERAL_ZARITHRIAN:
                    if (state == DONE)
                        if (Creature* halionController = instance->GetCreature(HalionControllerGUID))
                            halionController->AI()->DoAction(ACTION_INTRO_HALION);
                    break;
                case DATA_HALION:
                    DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TOGGLE, 0);
                    DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TWILIGHT, 0);
                    DoUpdateWorldState(WORLDSTATE_CORPOREALITY_MATERIAL, 0);
                    HandleGameObject(FlameRingGUID, true);
                    break;
            }

            return true;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "R S " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void FillInitialWorldStates(WorldPacket& data) override
        {
            data << uint32(WORLDSTATE_CORPOREALITY_MATERIAL) << uint32(50);
            data << uint32(WORLDSTATE_CORPOREALITY_TWILIGHT) << uint32(50);
            data << uint32(WORLDSTATE_CORPOREALITY_TOGGLE) << uint32(0);
        }

        void Load(char const* str) override
        {
            if (!str)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(str);

            char dataHead1, dataHead2;

            std::istringstream loadStream(str);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'R' && dataHead2 == 'S')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;

                    SetBossState(i, EncounterState(tmpState));
                }

                // Xinef: additional check
                if (GetBossState(DATA_HALION_INTRO_DONE) != DONE)
                {
                    SetBossState(DATA_HALION_INTRO1, NOT_STARTED);
                    SetBossState(DATA_HALION_INTRO2, NOT_STARTED);
                }
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    protected:
        ObjectGuid BaltharusTheWarbornGUID;
        ObjectGuid XerestraszaGUID;
        ObjectGuid GeneralZarithrianGUID;
        ObjectGuid ZarithrianSpawnStalkerGUID[2];

        ObjectGuid HalionGUID;
        ObjectGuid TwilightHalionGUID;
        ObjectGuid HalionControllerGUID;
        ObjectGuid OrbCarrierGUID;
        ObjectGuid FlameRingGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_ruby_sanctum_InstanceMapScript(map);
    }
};

class spell_ruby_sanctum_rallying_shout : public SpellScriptLoader
{
public:
    spell_ruby_sanctum_rallying_shout() : SpellScriptLoader("spell_ruby_sanctum_rallying_shout") { }

    class spell_ruby_sanctum_rallying_shout_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_ruby_sanctum_rallying_shout_SpellScript);

        void CountAllies()
        {
            uint32 count = GetSpell()->GetUniqueTargetInfo()->size();
            if (count == GetCaster()->GetAuraCount(SPELL_RALLY))
                return;

            GetCaster()->RemoveAurasDueToSpell(SPELL_RALLY);
            if (count > 0)
                GetCaster()->CastCustomSpell(SPELL_RALLY, SPELLVALUE_AURA_STACK, count, GetCaster(), true);
        }

        void Register() override
        {
            AfterHit += SpellHitFn(spell_ruby_sanctum_rallying_shout_SpellScript::CountAllies);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_ruby_sanctum_rallying_shout_SpellScript();
    }
};

void AddSC_instance_ruby_sanctum()
{
    new instance_ruby_sanctum();
    new spell_ruby_sanctum_rallying_shout();
}
