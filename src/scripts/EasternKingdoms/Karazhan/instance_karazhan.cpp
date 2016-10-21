/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#include "ScriptMgr.h"
#include "ScriptPCH.h"
#include "InstanceScript.h"
#include "karazhan.h"


class instance_karazhan : public InstanceMapScript
{
    public:
        instance_karazhan() : InstanceMapScript("instance_karazhan", 532) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_karazhan_InstanceMapScript(map);
        }

        struct instance_karazhan_InstanceMapScript : public InstanceScript
        {
            instance_karazhan_InstanceMapScript(Map* map) : InstanceScript(map) { }


            void Initialize()
            {
                SetBossNumber(MAX_ENCOUNTERS);
                _servantQuartersKills = 0;
                _selectedRare = RAND(NPC_HYAKISS_THE_LURKER, NPC_SHADIKITH_THE_GLIDER, NPC_ROKAD_THE_RAVAGER);
            }

            void OnCreatureCreate(Creature* creature)
            {

            }

            void SetData(uint32 type, uint32 uiData)
            {
                switch (type)
                {
                    case DATA_COUNT_SERVANT_QUARTERS_KILLS:
                        if (++_servantQuartersKills > 52) // 56 in total, not all have to be killed, almost all
                        {
                            SetBossState(TYPE_SERVANT_QUARTERS, NOT_STARTED);
                            SetBossState(TYPE_SERVANT_QUARTERS, DONE);
                        }
                        SaveToDB();
                        break;

                    /*
                    case TYPE_ATTUMEN:              m_auiEncounter[0] = uiData; break;
                    case TYPE_MOROES:
                        if (m_auiEncounter[1] == DONE)
                            break;
                        m_auiEncounter[1] = uiData;
                        break;
                    case TYPE_MAIDEN:               m_auiEncounter[2] = uiData; break;
                    case TYPE_OPTIONAL_BOSS:        m_auiEncounter[3] = uiData; break;
                    case TYPE_OPERA:
                        m_auiEncounter[4] = uiData;
                        if (uiData == DONE)
                            instance->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, 16812, NULL);
                        break;
                    case TYPE_CURATOR:              m_auiEncounter[5] = uiData; break;
                    case TYPE_ARAN:                 m_auiEncounter[6] = uiData; break;
                    case TYPE_TERESTIAN:            m_auiEncounter[7] = uiData; break;
                    case TYPE_NETHERSPITE:          m_auiEncounter[8] = uiData; break;
                    case TYPE_CHESS:
                        if (uiData == DONE)
                            DoRespawnGameObject(DustCoveredChest, DAY);
                        m_auiEncounter[9]  = uiData;
                        break;
                    case TYPE_MALCHEZZAR:           m_auiEncounter[10] = uiData; break;
                    case TYPE_NIGHTBANE:
                        if (m_auiEncounter[11] != DONE)
                            m_auiEncounter[11] = uiData;
                        break;
                    case DATA_OPERA_OZ_DEATHCOUNT:
                        if (uiData == SPECIAL)
                            ++m_uiOzDeathCount;
                        else if (uiData == IN_PROGRESS)
                            m_uiOzDeathCount = 0;
                        break;
*/
                }
            }

             void SetData64(uint32 identifier, uint64 data)
             {
                // switch (identifier)
                // {
                 //case DATA_IMAGE_OF_MEDIVH: ImageGUID = data;
                // }
             }

            void OnGameObjectCreate(GameObject* go)
            {
                /*switch (go->GetEntry())
                {
                    case 183932:   m_uiCurtainGUID          = go->GetGUID();         break;
                    case 184278:
                        m_uiStageDoorLeftGUID = go->GetGUID();
                        if (m_auiEncounter[4] == DONE)
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case 184279:
                        m_uiStageDoorRightGUID = go->GetGUID();
                        if (m_auiEncounter[4] == DONE)
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case 184517:   m_uiLibraryDoor          = go->GetGUID();         break;
                    case 185521:   m_uiMassiveDoor          = go->GetGUID();         break;
                    case 184276:   m_uiGamesmansDoor        = go->GetGUID();         break;
                    case 184277:   m_uiGamesmansExitDoor    = go->GetGUID();         break;
                    case 185134:   m_uiNetherspaceDoor      = go->GetGUID();         break;
                    case 184274:    MastersTerraceDoor[0] = go->GetGUID();  break;
                    case 184280:    MastersTerraceDoor[1] = go->GetGUID();  break;
                    case 184275:
                        m_uiSideEntranceDoor = go->GetGUID();
                        if (m_auiEncounter[4] == DONE)
                            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                        else
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                        break;
                    case 185119: DustCoveredChest = go->GetGUID(); break;
                }*/
            }

            uint32 GetData(uint32 data) const
            {
                switch (data)
                {
                    case DATA_SELECTED_RARE:
                        return _selectedRare;
                }

                return 0;
            }

            uint64 GetData64(uint32 data) const
            {
                /*switch (uiData)
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
                    case DATA_NIGHTBANE:                return m_uiNightbaneGUID;
                }
*/
                return 0;
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "K A " << GetBossSaveData() << _servantQuartersKills << ' ' << _selectedRare;
                return saveStream.str();
            }

            void Load(char const* str)
            {
                if (!str)
                    return;

                char dataHead1, dataHead2;

                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'K' && dataHead2 == 'A')
                {
                    for (uint32 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }

                    loadStream >> _servantQuartersKills;
                    loadStream >> _selectedRare;
                }
            }

        private:
            uint32 _servantQuartersKills;
            uint32 _selectedRare;
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

            void Update(AuraEffect const* effect)
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
                GetUnitOwner()->CastCustomSpell(SPELL_OVERLOAD, SPELLVALUE_BASE_POINT0, int32(auraEffect->GetAmount() * (2.0, auraEffect->GetTickNumber())), GetUnitOwner(), true);
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
