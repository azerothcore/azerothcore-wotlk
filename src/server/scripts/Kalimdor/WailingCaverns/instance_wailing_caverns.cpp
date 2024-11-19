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
#include "InstanceScript.h"
#include "wailing_caverns.h"

class instance_wailing_caverns : public InstanceMapScript
{
public:
    instance_wailing_caverns() : InstanceMapScript("instance_wailing_caverns", 43) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_wailing_caverns_InstanceMapScript(map);
    }

    struct instance_wailing_caverns_InstanceMapScript : public InstanceScript
    {
        instance_wailing_caverns_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            memset(&_encounters, 0, sizeof(_encounters));
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetEntry() == NPC_DISCIPLE_OF_NARALEX)
                DiscipleOfNaralexGUID = creature->GetGUID();
            else if (creature->GetEntry() == NPC_LORD_SERPENTIS)
                SerpentisGUID = creature->GetGUID();
        }

        void SetData(uint32 type, uint32 data) override
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

        uint32 GetData(uint32 type) const override
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

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounters[0];
            data >> _encounters[1];
            data >> _encounters[2];
            data >> _encounters[3];
            data >> _encounters[4];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounters[0] << ' '
                << _encounters[1] << ' '
                << _encounters[2] << ' '
                << _encounters[3] << ' '
                << _encounters[4] << ' ';
        }

    private:
        uint32 _encounters[MAX_ENCOUNTERS];
        ObjectGuid DiscipleOfNaralexGUID;
        ObjectGuid SerpentisGUID;
    };
};

void AddSC_instance_wailing_caverns()
{
    new instance_wailing_caverns();
}
