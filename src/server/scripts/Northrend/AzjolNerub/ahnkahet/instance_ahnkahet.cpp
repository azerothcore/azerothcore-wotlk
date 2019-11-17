/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "Player.h"
#include "ahnkahet.h"

class instance_ahnkahet : public InstanceMapScript
{
public:
    instance_ahnkahet() : InstanceMapScript("instance_ahnkahet", 619) { }

    struct instance_ahnkahet_InstanceScript : public InstanceScript
    {
        instance_ahnkahet_InstanceScript(Map* pMap) : InstanceScript(pMap) {Initialize();};

        uint64 Elder_Nadox;
        uint64 Prince_Taldaram;
        uint64 Jedoga_Shadowseeker;
        uint64 Herald_Volazj;
        uint64 Amanitar;

        uint64 Prince_TaldaramPlatform;
        uint64 Prince_TaldaramGate;

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        uint32 spheres;

        bool nadoxAchievement;
        bool jedogaAchievement;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            Elder_Nadox = 0;
            Prince_Taldaram = 0;
            Jedoga_Shadowseeker = 0;
            Herald_Volazj = 0;
            Amanitar = 0;

            Prince_TaldaramPlatform = 0;
            Prince_TaldaramGate = 0;
            spheres = NOT_STARTED;

            nadoxAchievement = false;
            jedogaAchievement = false;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnCreatureCreate(Creature* pCreature)
        {
            switch(pCreature->GetEntry())
            {
                case NPC_ELDER_NADOX:
                    Elder_Nadox = pCreature->GetGUID();
                    break;
                case NPC_PRINCE_TALDARAM:
                    Prince_Taldaram = pCreature->GetGUID();
                    break;
                case NPC_JEDOGA_SHADOWSEEKER:
                    Jedoga_Shadowseeker = pCreature->GetGUID();
                    break;
                case NPC_HERALD_JOLAZJ:
                    Herald_Volazj = pCreature->GetGUID();
                    break;
                case NPC_AMANITAR:
                    Amanitar = pCreature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* pGo)
        {
            switch(pGo->GetEntry())
            {
                case 193564:     
                    Prince_TaldaramPlatform = pGo->GetGUID();
                    if (m_auiEncounter[1] == DONE) 
                        HandleGameObject(0,true,pGo); 
                    
                    break;
                case 193093:
                    if (spheres == DONE)
                    {
                        pGo->SetGoState(GO_STATE_ACTIVE);
                        pGo->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    }
                    else 
                        pGo->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    
                    break;
                case 193094:
                    if (spheres == DONE)
                    {
                        pGo->SetGoState(GO_STATE_ACTIVE);
                        pGo->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    }
                    else 
                        pGo->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    
                    break;
                case 192236:    
                    Prince_TaldaramGate = pGo->GetGUID(); // Web gate past Prince Taldaram
                    if (m_auiEncounter[1] == DONE)
                        HandleGameObject(0,true,pGo);
                    
                    break;
            }
        }

        uint64 GetData64(uint32 identifier) const
        {
            switch(identifier)
            {
                case DATA_ELDER_NADOX:                return Elder_Nadox;
                case DATA_PRINCE_TALDARAM:            return Prince_Taldaram;
                case DATA_JEDOGA_SHADOWSEEKER:        return Jedoga_Shadowseeker;
                case DATA_HERALD_VOLAZJ:              return Herald_Volazj;
                case DATA_AMANITAR:                   return Amanitar;
                case DATA_PRINCE_TALDARAM_PLATFORM:   return Prince_TaldaramPlatform;
            }

            return 0;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
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

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_HERALD_VOLAZJ_EVENT:
                case DATA_AMANITAR_EVENT:
                case DATA_ELDER_NADOX_EVENT: 
                case DATA_JEDOGA_SHADOWSEEKER_EVENT:
                    m_auiEncounter[type] = data;
                    break;
                case DATA_PRINCE_TALDARAM_EVENT:
                    if (data == DONE)
                        HandleGameObject(Prince_TaldaramGate, true);
                    
                    m_auiEncounter[type] = data;
                    break;
                case DATA_SPHERE_EVENT:
                    spheres = data;
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

        uint32 GetData(uint32 type) const
        {
            switch(type)
            {
                case DATA_ELDER_NADOX_EVENT:
                case DATA_PRINCE_TALDARAM_EVENT:
                case DATA_JEDOGA_SHADOWSEEKER_EVENT:
                case DATA_HERALD_VOLAZJ:
                case DATA_AMANITAR_EVENT:
                    return m_auiEncounter[type];

                case DATA_SPHERE_EVENT:                 
                    return spheres;
            }

            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "A K " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' '
                << m_auiEncounter[2] << ' ' << m_auiEncounter[3] << ' ' << m_auiEncounter[4] << ' '
                << spheres;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint32 data0, data1, data2, data3, data4, data5;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3 >> data4 >> data5;

            if (dataHead1 == 'A' && dataHead2 == 'K')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                m_auiEncounter[3] = data3;
                m_auiEncounter[4] = data4;

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;

                spheres = data5;

            } else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
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
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                        if (Player* player = itr->GetSource()->ToPlayer())
                            if (player->IsWithinDist(caster, 40.0f) && player->IsAlive()) // SPELL_SHADOW_SICKLE_H & SPELL_SHADOW_SICKLE range is 40 yards
                                PlayerList.push_back(player);

                    if (!PlayerList.empty())
                        caster->CastSpell(acore::Containers::SelectRandomContainerElement(PlayerList), caster->GetMap()->IsHeroic() ? SPELL_SHADOW_SICKLE_H : SPELL_SHADOW_SICKLE, true);

                }
            }

            void Register()
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
