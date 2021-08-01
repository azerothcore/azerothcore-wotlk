/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "the_eye.h"

class instance_the_eye : public InstanceMapScript
{
public:
    instance_the_eye() : InstanceMapScript("instance_the_eye", 550) { }

    struct instance_the_eye_InstanceMapScript : public InstanceScript
    {
        instance_the_eye_InstanceMapScript(Map* map) : InstanceScript(map) {}

        ObjectGuid ThaladredTheDarkenerGUID;
        ObjectGuid LordSanguinarGUID;
        ObjectGuid GrandAstromancerCapernianGUID;
        ObjectGuid MasterEngineerTelonicusGUID;
        ObjectGuid AlarGUID;
        ObjectGuid KaelthasGUID;
        ObjectGuid BridgeWindowGUID;
        ObjectGuid KaelStateRightGUID;
        ObjectGuid KaelStateLeftGUID;

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTER);
        }

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
                case DATA_KAEL_ADVISOR1:
                    return ThaladredTheDarkenerGUID;
                case DATA_KAEL_ADVISOR2:
                    return LordSanguinarGUID;
                case DATA_KAEL_ADVISOR3:
                    return GrandAstromancerCapernianGUID;
                case DATA_KAEL_ADVISOR4:
                    return MasterEngineerTelonicusGUID;
            }

            return ObjectGuid::Empty;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "E Y " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
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

            if (dataHead1 == 'E' && dataHead2 == 'Y')
            {
                for (uint32 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
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
