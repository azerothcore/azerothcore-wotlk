
#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "karazhan.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Map.h"
#include "Player.h"

const Position OptionalSpawn[] =
{
    { -10960.981445f, -1940.138428f, 46.178097f, 4.12f }, // Hyakiss the Lurker
    { -10945.769531f, -2040.153320f, 49.474438f, 0.077f }, // Shadikith the Glider
    { -10899.903320f, -2085.573730f, 49.474449f, 1.38f }  // Rokad the Ravager
};

class instance_karazhan : public InstanceMapScript
{
public:
    instance_karazhan() : InstanceMapScript("instance_karazhan", 532) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_karazhan_InstanceMapScript(map);
    }

    struct instance_karazhan_InstanceMapScript : public InstanceScript
    {
        instance_karazhan_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(EncounterCount);

            // 1 - OZ, 2 - HOOD, 3 - RAJ, this never gets altered.
            OperaEvent = urand(EVENT_OZ, EVENT_RAJ);
            OzDeathCount = 0;
            OptionalBossCount = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
            case NPC_KILREK:
                m_uiKilrekGUID = creature->GetGUID();
                break;
            case NPC_TERESTIAN_ILLHOOF:
                m_uiTerestianGUID = creature->GetGUID();
                break;
            case NPC_MOROES:
                m_uiMoroesGUID = creature->GetGUID();
                break;
            case NPC_NIGHTBANE:
                m_uiNightBaneGUID = creature->GetGUID();
            case NPC_RELAY:
                m_uiRelayGUID = creature->GetGUID();
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            Creature* creature = unit->ToCreature();
            if (!creature)
                return;

            switch (creature->GetEntry())
            {
            case NPC_COLDMIST_WIDOW:
            case NPC_COLDMIST_STALKER:
            case NPC_SHADOWBAT:
            case NPC_VAMPIRIC_SHADOWBAT:
            case NPC_GREATER_SHADOWBAT:
            case NPC_PHASE_HOUND:
            case NPC_DREADBEAST:
            case NPC_SHADOWBEAST:
                if (GetBossState(DATA_OPTIONAL_BOSS) == TO_BE_DECIDED)
                {
                    ++OptionalBossCount;
                    if (OptionalBossCount == OPTIONAL_BOSS_REQUIRED_DEATH_COUNT)
                    {
                        switch (urand(NPC_HYAKISS_THE_LURKER, NPC_ROKAD_THE_RAVAGER))
                        {
                        case NPC_HYAKISS_THE_LURKER:
                            instance->SummonCreature(NPC_HYAKISS_THE_LURKER, OptionalSpawn[0]);
                            break;
                        case NPC_SHADIKITH_THE_GLIDER:
                            instance->SummonCreature(NPC_SHADIKITH_THE_GLIDER, OptionalSpawn[1]);
                            break;
                        case NPC_ROKAD_THE_RAVAGER:
                            instance->SummonCreature(NPC_ROKAD_THE_RAVAGER, OptionalSpawn[2]);
                            break;
                        }
                    }
                }
                break;
            default:
                break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
            case DATA_OPERA_OZ_DEATHCOUNT:
                if (data == SPECIAL)
                    ++OzDeathCount;
                else if (data == IN_PROGRESS)
                    OzDeathCount = 0;
                break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
            case DATA_OPERA_PERFORMANCE:
                if (state == DONE)
                {
                    HandleGameObject(m_uiStageDoorLeftGUID, true);
                    HandleGameObject(m_uiStageDoorRightGUID, true);
                    if (GameObject* sideEntrance = instance->GetGameObject(m_uiSideEntranceDoor))
                        sideEntrance->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                    instance->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, 16812, nullptr);
                }
                break;
            case DATA_CHESS:
                if (state == DONE)
                    DoRespawnGameObject(DustCoveredChest, DAY);
                break;
            default:
                break;
            }

            return true;
        }

        void SetData64(uint32 type, uint64 data) override
        {
            if (type == DATA_IMAGE_OF_MEDIVH)
                ImageGUID = data;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
            case GO_STAGE_CURTAIN:
                m_uiCurtainGUID = go->GetGUID();
                break;
            case GO_STAGE_DOOR_LEFT:
                m_uiStageDoorLeftGUID = go->GetGUID();
                if (GetBossState(DATA_OPERA_PERFORMANCE) == DONE)
                    go->SetGoState(GO_STATE_ACTIVE);
                break;
            case GO_STAGE_DOOR_RIGHT:
                m_uiStageDoorRightGUID = go->GetGUID();
                if (GetBossState(DATA_OPERA_PERFORMANCE) == DONE)
                    go->SetGoState(GO_STATE_ACTIVE);
                break;
            case GO_PRIVATE_LIBRARY_DOOR:
                m_uiLibraryDoor = go->GetGUID();
                break;
            case GO_MASSIVE_DOOR:
                m_uiMassiveDoor = go->GetGUID();
                if (GetBossState(DATA_ARAN) != IN_PROGRESS)
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                else
                    go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                break;
            case GO_GAMESMAN_HALL_DOOR:
                m_uiGamesmansDoor = go->GetGUID();
                break;
            case GO_GAMESMAN_HALL_EXIT_DOOR:
                m_uiGamesmansExitDoor = go->GetGUID();
                break;
            case GO_NETHERSPACE_DOOR:
                m_uiNetherspaceDoor = go->GetGUID();
                if (GetBossState(DATA_PRINCE) != IN_PROGRESS)
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                else
                    go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                break;
            case GO_MASTERS_TERRACE_DOOR:
                MastersTerraceDoor[0] = go->GetGUID();
                break;
            case GO_MASTERS_TERRACE_DOOR2:
                MastersTerraceDoor[1] = go->GetGUID();
                break;
            case GO_SIDE_ENTRANCE_DOOR:
                m_uiSideEntranceDoor = go->GetGUID();
                if (GetBossState(DATA_OPERA_PERFORMANCE) == DONE)
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                else
                    go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                break;
            case GO_DUST_COVERED_CHEST:
                DustCoveredChest = go->GetGUID();
                break;
            }

            switch (OperaEvent)
            {
                /// @todo Set Object visibilities for Opera based on performance
            case EVENT_OZ:
                break;

            case EVENT_HOOD:
                break;

            case EVENT_RAJ:
                break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
            case DATA_OPERA_PERFORMANCE:
                return OperaEvent;
            case DATA_OPERA_OZ_DEATHCOUNT:
                return OzDeathCount;

            case DATA_KILREK:
                return m_uiKilrekGUID;
            case DATA_TERESTIAN:
                return m_uiTerestianGUID;
            case DATA_MOROES:
                return m_uiMoroesGUID;
            case DATA_GO_STAGEDOORLEFT:
                return m_uiStageDoorLeftGUID;
            case DATA_GO_STAGEDOORRIGHT:
                return m_uiStageDoorRightGUID;
            case DATA_GO_CURTAINS:
                return m_uiCurtainGUID;
            case DATA_GO_LIBRARY_DOOR:
                return m_uiLibraryDoor;
            case DATA_GO_MASSIVE_DOOR:
                return m_uiMassiveDoor;
            case DATA_GO_SIDE_ENTRANCE_DOOR:
                return m_uiSideEntranceDoor;
            case DATA_GO_GAME_DOOR:
                return m_uiGamesmansDoor;
            case DATA_GO_GAME_EXIT_DOOR:
                return m_uiGamesmansExitDoor;
            case DATA_GO_NETHER_DOOR:
                return m_uiNetherspaceDoor;
            case DATA_MASTERS_TERRACE_DOOR_1:
                return MastersTerraceDoor[0];
            case DATA_MASTERS_TERRACE_DOOR_2:
                return MastersTerraceDoor[1];
            case DATA_IMAGE_OF_MEDIVH:
                return ImageGUID;
            }

            return 0;
        }

        uint64 GetData64(uint32 data) const override
        {
            switch (data)
            {
            case DATA_KILREK:                   return m_uiKilrekGUID;
            case DATA_TERESTIAN:                return m_uiTerestianGUID;
            case DATA_MOROES:                   return m_uiMoroesGUID;
            case DATA_GO_STAGEDOORLEFT:         return m_uiStageDoorLeftGUID;
            case DATA_GO_STAGEDOORRIGHT:        return m_uiStageDoorRightGUID;
            case DATA_GO_CURTAINS:              return m_uiCurtainGUID;
            case DATA_GO_LIBRARY_DOOR:          return m_uiLibraryDoor;
            case DATA_GO_MASSIVE_DOOR:          return m_uiMassiveDoor;
            case DATA_GO_SIDE_ENTRANCE_DOOR:    return m_uiSideEntranceDoor;
            case DATA_GO_GAME_DOOR:             return m_uiGamesmansDoor;
            case DATA_GO_GAME_EXIT_DOOR:        return m_uiGamesmansExitDoor;
            case DATA_GO_NETHER_DOOR:           return m_uiNetherspaceDoor;
            case DATA_MASTERS_TERRACE_DOOR_1:   return MastersTerraceDoor[0];
            case DATA_MASTERS_TERRACE_DOOR_2:   return MastersTerraceDoor[1];
            case DATA_IMAGE_OF_MEDIVH:          return ImageGUID;
            case DATA_NIGHTBANE:                return m_uiNightBaneGUID;
            }

            return 0;
        }

    private:
        uint32 OperaEvent;
        uint32 OzDeathCount;
        uint32 OptionalBossCount;
        //uint32 m_auiEncounter[MAX_ENCOUNTERS];
        //uint32 m_uiTeam;
        uint64 m_uiCurtainGUID;
        uint64 m_uiStageDoorLeftGUID;
        uint64 m_uiStageDoorRightGUID;
        uint64 m_uiKilrekGUID;
        uint64 m_uiTerestianGUID;
        uint64 m_uiMoroesGUID;
        uint64 m_uiNightBaneGUID;
        //uint64 EchoOfMedivhGUID;
        uint64 m_uiLibraryDoor;                                     // Door at Shade of Aran
        uint64 m_uiMassiveDoor;                                     // Door at Netherspite
        uint64 m_uiSideEntranceDoor;                                // Side Entrance
        uint64 m_uiGamesmansDoor;                                   // Door before Chess
        uint64 m_uiGamesmansExitDoor;                               // Door after Chess
        uint64 m_uiNetherspaceDoor;                                // Door at Malchezaar
        //uint64 m_uiServantsAccessDoor;                              // Door to Brocken Stair
        uint64 MastersTerraceDoor[2];
        uint64 ImageGUID;
        uint64 DustCoveredChest;
        uint64 m_uiRelayGUID;
    };
};

class spell_karazhan_brittle_bones : public SpellScriptLoader
{
public:
    spell_karazhan_brittle_bones() : SpellScriptLoader("spell_karazhan_brittle_bones") { }

    class spell_karazhan_brittle_bones_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_karazhan_brittle_bones_AuraScript);

        void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
        {
            isPeriodic = true;
            amplitude = 5000;
        }

        void Update(AuraEffect const*  /*effect*/)
        {
            PreventDefaultAction();
            if (roll_chance_i(35))
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_RATTLED, true);
        }

        void Register()
        {
            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_karazhan_brittle_bones_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_karazhan_brittle_bones_AuraScript::Update, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_karazhan_brittle_bones_AuraScript();
    }
};

class spell_karazhan_overload : public SpellScriptLoader
{
public:
    spell_karazhan_overload() : SpellScriptLoader("spell_karazhan_overload") { }

    class spell_karazhan_overload_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_karazhan_overload_AuraScript);

        void PeriodicTick(AuraEffect const* auraEffect)
        {
            PreventDefaultAction();
            //Should stop at 3200 damage, maybe check needed(?)
            GetUnitOwner()->CastCustomSpell(SPELL_OVERLOAD, SPELLVALUE_BASE_POINT0, int32(auraEffect->GetAmount() * pow(2.0, auraEffect->GetTickNumber())), GetUnitOwner(), true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_karazhan_overload_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_karazhan_overload_AuraScript();
    }
};

class spell_karazhan_blink : public SpellScriptLoader
{
public:
    spell_karazhan_blink() : SpellScriptLoader("spell_karazhan_blink") { }

    class spell_karazhan_blink_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_karazhan_blink_SpellScript);

        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->getThreatManager().resetAllAggro();
            if (Unit* target = GetHitUnit())
                GetCaster()->CastSpell(target, SPELL_BLINK, true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_karazhan_blink_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_karazhan_blink_SpellScript();
    }
};


void AddSC_instance_karazhan()
{
    new instance_karazhan();
    new spell_karazhan_brittle_bones();
    new spell_karazhan_overload();
    new spell_karazhan_blink();
}
