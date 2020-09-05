/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "Player.h"
#include <array>
#include "ahnkahet.h"

class instance_ahnkahet : public InstanceMapScript
{
public:
    instance_ahnkahet() : InstanceMapScript("instance_ahnkahet", 619) { }

    struct instance_ahnkahet_InstanceScript : public InstanceScript
    {
        instance_ahnkahet_InstanceScript(Map* pMap) : InstanceScript(pMap) {Initialize();};

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTER);

            elderNadox_GUID = 0;
            princeTaldaram_GUID = 0;
            jedogaShadowseeker_GUID = 0;
            heraldVolazj_GUID = 0;
            amanitar_GUID = 0;

            Prince_TaldaramPlatform = 0;
            Prince_TaldaramGate = 0;
            spheres[0] = spheres[1] = NOT_STARTED;

            nadoxAchievement = false;
            jedogaAchievement = false;
        }

        void OnCreatureCreate(Creature* pCreature) override
        {
            switch(pCreature->GetEntry())
            {
                case NPC_ELDER_NADOX:
                    elderNadox_GUID = pCreature->GetGUID();
                    break;
                case NPC_PRINCE_TALDARAM:
                    princeTaldaram_GUID = pCreature->GetGUID();
                    break;
                case NPC_JEDOGA_SHADOWSEEKER:
                    jedogaShadowseeker_GUID = pCreature->GetGUID();
                    break;
                case NPC_HERALD_JOLAZJ:
                    heraldVolazj_GUID = pCreature->GetGUID();
                    break;
                case NPC_AMANITAR:
                    amanitar_GUID = pCreature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* pGo) override
        {
            switch(pGo->GetEntry())
            {
                case GO_TELDARAM_PLATFORM:
                {
                    Prince_TaldaramPlatform = pGo->GetGUID();
                    if (GetBossState(DATA_PRINCE_TALDARAM) == DONE)
                    {
                        HandleGameObject(0, true, pGo);
                    }

                    break;
                }
                case GO_TELDARAM_SPHERE1:
                case GO_TELDARAM_SPHERE2:
                {
                    if (spheres[pGo->GetEntry() == GO_TELDARAM_SPHERE1 ? 0 : 1] == DONE)
                    {
                        pGo->SetGoState(GO_STATE_ACTIVE);
                        pGo->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    }
                    else
                    {
                        pGo->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    }

                    break;
                }
                case GO_TELDARAM_DOOR:
                {
                    Prince_TaldaramGate = pGo->GetGUID(); // Web gate past Prince Taldaram
                    if (GetBossState(DATA_PRINCE_TALDARAM) == DONE)
                    {
                        HandleGameObject(0, true, pGo);
                    }

                    break;
                }
            }
        }

        uint64 GetData64(uint32 identifier) const override
        {
            switch(identifier)
            {
                case DATA_ELDER_NADOX:                return elderNadox_GUID;
                case DATA_PRINCE_TALDARAM:            return princeTaldaram_GUID;
                case DATA_JEDOGA_SHADOWSEEKER:        return jedogaShadowseeker_GUID;
                case DATA_HERALD_VOLAZJ:              return heraldVolazj_GUID;
                case DATA_AMANITAR:                   return amanitar_GUID;
                case DATA_PRINCE_TALDARAM_PLATFORM:   return Prince_TaldaramPlatform;
            }

            return 0;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                case 7317: // Respect Your Elders (2038)
                    return nadoxAchievement;
                case 7359: // Volunteer Work (2056)
                    return jedogaAchievement;
            }
            return false;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
            case DATA_PRINCE_TALDARAM_EVENT:
            {
                if (state == DONE)
                {
                    HandleGameObject(Prince_TaldaramGate, true);
                }
                break;
            }
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch(type)
            {
                case DATA_TELDRAM_SPHERE1:
                    spheres[0] = data;
                    break;
                case DATA_TELDRAM_SPHERE2:
                    spheres[1] = data;
                    break;
                case DATA_NADOX_ACHIEVEMENT:
                    nadoxAchievement = (bool)data;
                    return;
                case DATA_JEDOGA_ACHIEVEMENT:
                    jedogaAchievement = (bool)data;
                    return;
            }

            if (data == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch(type)
            {
                case DATA_TELDRAM_SPHERE1:
                    return spheres[0];
                case DATA_TELDRAM_SPHERE2:
                    return spheres[1];
            }

            return 0;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "A K " << GetBossSaveData() << spheres[0] << ' ' << spheres[1];

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'A' && dataHead2 == 'K')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;

                    SetBossState(i, EncounterState(tmpState));
                }

                loadStream >> spheres[0] >> spheres[1];
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        uint64 elderNadox_GUID;
        uint64 princeTaldaram_GUID;
        uint64 jedogaShadowseeker_GUID;
        uint64 heraldVolazj_GUID;
        uint64 amanitar_GUID;

        uint64 Prince_TaldaramPlatform;
        uint64 Prince_TaldaramGate;

        std::array<uint32, 2> spheres;

        bool nadoxAchievement;
        bool jedogaAchievement;
    };

    InstanceScript* GetInstanceScript(InstanceMap *map) const
    {
       return new instance_ahnkahet_InstanceScript(map);
    }
};

class spell_shadow_sickle_periodic_damage : public SpellScriptLoader
{
    public:
        spell_shadow_sickle_periodic_damage() : SpellScriptLoader("spell_shadow_sickle_periodic_damage") { }

        class spell_shadow_sickle_periodic_damage_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_shadow_sickle_periodic_damage_AuraScript);

            void HandlePeriodic(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();

                if (Unit* caster = GetCaster())
                {
                    std::list<Player*> PlayerList;
                    PlayerList.clear();

                    Map::PlayerList const &players = caster->GetMap()->GetPlayers();
                    for (auto const& itr : players)
                    {
                        Player* player = itr.GetSource();
                        if (player && player->IsWithinDist(caster, 40.0f) && player->IsAlive()) // SPELL_SHADOW_SICKLE_H & SPELL_SHADOW_SICKLE range is 40 yards
                            PlayerList.push_back(player);
                    }

                    if (PlayerList.empty())
                        return;

                    if (Player* target = acore::Containers::SelectRandomContainerElement(PlayerList))
                        caster->CastSpell(target, caster->GetMap()->IsHeroic() ? SPELL_SHADOW_SICKLE_H : SPELL_SHADOW_SICKLE, true);
                }
            }

            void Register() override
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadow_sickle_periodic_damage_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_shadow_sickle_periodic_damage_AuraScript();
        }
};

void AddSC_instance_ahnkahet()
{
   new instance_ahnkahet;
   new spell_shadow_sickle_periodic_damage();
}
