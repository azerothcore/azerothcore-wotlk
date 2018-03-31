/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Instance_Temple_of_Ahnqiraj
SD%Complete: 80
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "temple_of_ahnqiraj.h"

class instance_temple_of_ahnqiraj : public InstanceMapScript
{
    public:
        instance_temple_of_ahnqiraj() : InstanceMapScript("instance_temple_of_ahnqiraj", 531) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_temple_of_ahnqiraj_InstanceMapScript(map);
        }

        struct instance_temple_of_ahnqiraj_InstanceMapScript : public InstanceScript
        {
            instance_temple_of_ahnqiraj_InstanceMapScript(Map* map) : InstanceScript(map) { }

            //If Vem is dead...
            bool IsBossDied[3];

            //Storing Skeram, Vem and Kri.
            uint64 SkeramGUID;
            uint64 VemGUID;
            uint64 KriGUID;
            uint64 VeklorGUID;
            uint64 VeknilashGUID;
            uint64 ViscidusGUID;

            uint32 BugTrioDeathCount;

            uint32 CthunPhase;

            void Initialize()
            {
                IsBossDied[0] = false;
                IsBossDied[1] = false;
                IsBossDied[2] = false;

                SkeramGUID = 0;
                VemGUID = 0;
                KriGUID = 0;
                VeklorGUID = 0;
                VeknilashGUID = 0;
                ViscidusGUID = 0;

                BugTrioDeathCount = 0;

                CthunPhase = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                case NPC_SKERAM:
                    SkeramGUID = creature->GetGUID();
                    break;
                case NPC_VEM:
                    VemGUID = creature->GetGUID();
                    break;
                case NPC_KRI:
                    KriGUID = creature->GetGUID();
                    break;
                case NPC_VEKLOR:
                    VeklorGUID = creature->GetGUID();
                    break;
                case NPC_VEKNILASH:
                    VeknilashGUID = creature->GetGUID();
                    break;
                case NPC_VISCIDUS:
                    ViscidusGUID = creature->GetGUID();
                    break;
                }
            }

            bool IsEncounterInProgress() const
            {
                //not active in AQ40
                return false;
            }

            uint32 GetData(uint32 type) const
            {
                switch (type)
                {
                case DATA_VEMISDEAD:
                    if (IsBossDied[0])
                        return 1;
                    break;

                case DATA_VEKLORISDEAD:
                    if (IsBossDied[1])
                        return 1;
                    break;

                case DATA_VEKNILASHISDEAD:
                    if (IsBossDied[2])
                        return 1;
                    break;

                case DATA_BUG_TRIO_DEATH:
                    return BugTrioDeathCount;

                case DATA_CTHUN_PHASE:
                    return CthunPhase;
                }
                return 0;
            }

            uint64 GetData64(uint32 identifier) const
            {
                switch (identifier)
                {
                case DATA_SKERAM:
                    return SkeramGUID;
                case DATA_VEM:
                    return VemGUID;
                case DATA_KRI:
                    return KriGUID;
                case DATA_VEKLOR:
                    return VeklorGUID;
                case DATA_VEKNILASH:
                    return VeknilashGUID;
                case DATA_VISCIDUS:
                    return ViscidusGUID;
                }
                return 0;
            }                                                       // end GetData64

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                case DATA_VEM_DEATH:
                    IsBossDied[0] = true;
                    break;

                case DATA_BUG_TRIO_DEATH:
                    ++BugTrioDeathCount;
                    break;

                case DATA_VEKLOR_DEATH:
                    IsBossDied[1] = true;
                    break;

                case DATA_VEKNILASH_DEATH:
                    IsBossDied[2] = true;
                    break;

                case DATA_CTHUN_PHASE:
                    CthunPhase = data;
                    break;
                }
            }
        };

};

void AddSC_instance_temple_of_ahnqiraj()
{
    new instance_temple_of_ahnqiraj();
}
