/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "wailing_caverns.h"

class instance_wailing_caverns : public InstanceMapScript
{
    public:
        instance_wailing_caverns() : InstanceMapScript("instance_wailing_caverns", 43) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_wailing_caverns_InstanceMapScript(map);
        }

        struct instance_wailing_caverns_InstanceMapScript : public InstanceScript
        {
            instance_wailing_caverns_InstanceMapScript(Map* map) : InstanceScript(map) { }

            void Initialize()
            {
                memset(&_encounters, 0, sizeof(_encounters));

                DiscipleOfNaralexGUID = 0;
                SerpentisGUID = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                if (creature->GetEntry() == NPC_DISCIPLE_OF_NARALEX)
                    DiscipleOfNaralexGUID = creature->GetGUID();
                else if (creature->GetEntry() == NPC_LORD_SERPENTIS)
                    SerpentisGUID = creature->GetGUID();
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case TYPE_LORD_COBRAHN:
                    case TYPE_LORD_PYTHAS:
                    case TYPE_LADY_ANACONDRA:
                    case TYPE_LORD_SERPENTIS:
                    case TYPE_MUTANUS:
                        _encounters[type] = data;
                        break;
                }

                if (data == DONE)
                    SaveToDB();

                if (type == TYPE_LORD_COBRAHN && _encounters[TYPE_LORD_SERPENTIS] != DONE)
                {
                    instance->LoadGrid(-120.163f, -24.624f);
                    if (Creature* serpentis = instance->GetCreature(SerpentisGUID))
                        serpentis->AI()->Talk(SAY_SERPENTIS);
                }

                if (type != TYPE_MUTANUS && _encounters[TYPE_LORD_COBRAHN] == DONE && _encounters[TYPE_LORD_PYTHAS] == DONE &&
                    _encounters[TYPE_LADY_ANACONDRA] == DONE && _encounters[TYPE_LORD_SERPENTIS] == DONE)
                {
                    instance->LoadGrid(-134.97f, 125.402f);
                    if (Creature* disciple = instance->GetCreature(DiscipleOfNaralexGUID))
                        disciple->AI()->Talk(SAY_DISCIPLE);
                }
            }

            uint32 GetData(uint32 type) const
            {
                switch (type)
                {
                    case TYPE_LORD_COBRAHN:
                    case TYPE_LORD_PYTHAS:
                    case TYPE_LADY_ANACONDRA:
                    case TYPE_LORD_SERPENTIS:
                        return _encounters[type];
                }
                return 0;
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "W C " << _encounters[0] << ' ' << _encounters[1] << ' ' << _encounters[2] << ' ' << _encounters[3] << ' ' << _encounters[4];
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'W' && dataHead2 == 'C')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        loadStream >> _encounters[i];
                        if (_encounters[i] == IN_PROGRESS)
                            _encounters[i] = NOT_STARTED;
                    }
                }
            }

        private:
            uint32 _encounters[MAX_ENCOUNTERS];
            uint64 DiscipleOfNaralexGUID;
            uint64 SerpentisGUID;
        };
};

void AddSC_instance_wailing_caverns()
{
    new instance_wailing_caverns();
}
