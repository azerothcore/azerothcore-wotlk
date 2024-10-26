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
#include "InstanceMapScript.h"
#include "ScriptedCreature.h"
#include "utgarde_pinnacle.h"

class instance_utgarde_pinnacle : public InstanceMapScript
{
public:
    instance_utgarde_pinnacle() : InstanceMapScript("instance_utgarde_pinnacle", 575) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_utgarde_pinnacle_InstanceMapScript(pMap);
    }

    struct instance_utgarde_pinnacle_InstanceMapScript : public InstanceScript
    {
        instance_utgarde_pinnacle_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {Initialize();};

        ObjectGuid SvalaSorrowgrave;
        ObjectGuid GortokPalehoof;
        ObjectGuid SkadiRuthless;
        ObjectGuid KingYmiron;
        ObjectGuid FrenziedWorgen;
        ObjectGuid RavenousFurbolg;
        ObjectGuid MassiveJormungar;
        ObjectGuid FerociousRhino;
        ObjectGuid Grauf;

        ObjectGuid SvalaMirrorGUID;
        ObjectGuid SkadiRuthlessDoor;
        ObjectGuid YmironDoor;
        ObjectGuid StatisGenerator;
        uint32 Encounters[MAX_ENCOUNTERS];
        uint8 SkadiHits;
        uint8 SkadiInRange;

        bool svalaAchievement;
        bool skadiAchievement;
        bool ymironAchievement;

        void Initialize() override
        {
            SetHeaders(DataHeader);
            SkadiHits        = 0;
            SkadiInRange     = 0;

            svalaAchievement = false;
            skadiAchievement = false;
            ymironAchievement = false;

            for(uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                Encounters[i] = NOT_STARTED;
        }

        bool IsEncounterInProgress() const override
        {
            for(uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                if (Encounters[i] == IN_PROGRESS)
                    return true;

            return false;
        }
        void OnCreatureCreate(Creature* pCreature) override
        {
            switch (pCreature->GetEntry())
            {
                case NPC_SVALA_SORROWGRAVE:
                    SvalaSorrowgrave = pCreature->GetGUID();
                    break;
                case NPC_GORTOK_PALEHOOF:
                    GortokPalehoof = pCreature->GetGUID();
                    break;
                case NPC_SKADI_THE_RUTHLESS:
                    SkadiRuthless = pCreature->GetGUID();
                    break;
                case NPC_KING_YMIRON:
                    KingYmiron = pCreature->GetGUID();
                    break;
                case NPC_FRENZIED_WORGEN:
                    FrenziedWorgen = pCreature->GetGUID();
                    break;
                case NPC_RAVENOUS_FURBOLG:
                    RavenousFurbolg = pCreature->GetGUID();
                    break;
                case NPC_MASSIVE_JORMUNGAR:
                    MassiveJormungar = pCreature->GetGUID();
                    break;
                case NPC_FEROCIOUS_RHINO:
                    FerociousRhino = pCreature->GetGUID();
                    break;
                case NPC_GARUF:
                    Grauf = pCreature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* pGo) override
        {
            switch (pGo->GetEntry())
            {
                case GO_SKADI_THE_RUTHLESS_DOOR:
                    SkadiRuthlessDoor = pGo->GetGUID();
                    if (Encounters[DATA_SKADI_THE_RUTHLESS] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, pGo);
                    break;
                case GO_KING_YMIRON_DOOR:
                    YmironDoor = pGo->GetGUID();
                    if (Encounters[DATA_KING_YMIRON] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, pGo);
                    break;
                case GO_GORK_PALEHOOF_SPHERE:
                    StatisGenerator = pGo->GetGUID();
                    break;
                case GO_SVALA_MIRROR:
                    SvalaMirrorGUID = pGo->GetGUID();
                    break;
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 7322: // The Incredible Hulk (2043)
                    return svalaAchievement;
                case 7595: // My Girl Loves to Skadi All the Time (2156)
                    return skadiAchievement;
                case 7598: // King's Bane (2157)
                    return ymironAchievement;
            }
            return false;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_SVALA_SORROWGRAVE:
                case DATA_GORTOK_PALEHOOF:
                    Encounters[type] = data;
                    break;
                case DATA_SKADI_THE_RUTHLESS:
                    if (data == DONE)
                    {
                        HandleGameObject(SkadiRuthlessDoor, true);
                        // Make ymiron attackable
                        if (Creature* cr = instance->GetCreature(KingYmiron))
                            cr->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    }
                    Encounters[type] = data;
                    break;
                case DATA_KING_YMIRON:
                    if (data == DONE)
                        HandleGameObject(YmironDoor, true);
                    Encounters[type] = data;
                    break;
                case SKADI_HITS:
                    SkadiHits = data;
                    break;
                case SKADI_IN_RANGE:
                    SkadiInRange = data;
                    break;
                case DATA_SVALA_ACHIEVEMENT:
                    svalaAchievement = (bool)data;
                    return;
                case DATA_SKADI_ACHIEVEMENT:
                    skadiAchievement = (bool)data;
                    return;
                case DATA_YMIRON_ACHIEVEMENT:
                    ymironAchievement = (bool)data;
                    return;
            }
            OUT_SAVE_INST_DATA;

            SaveToDB();
            OUT_SAVE_INST_DATA_COMPLETE;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> Encounters[0];
            data >> Encounters[1];
            data >> Encounters[2];
            data >> Encounters[3];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << Encounters[0] << ' '
                << Encounters[1] << ' '
                << Encounters[2] << ' '
                << Encounters[3];
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_SVALA_SORROWGRAVE:
                    return Encounters[0];
                case DATA_GORTOK_PALEHOOF:
                    return Encounters[1];
                case DATA_SKADI_THE_RUTHLESS:
                    return Encounters[2];
                case DATA_KING_YMIRON:
                    return Encounters[3];
                case SKADI_HITS:
                    return SkadiHits;
                case SKADI_IN_RANGE:
                    return SkadiInRange;
            }
            return 0;
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case DATA_SVALA_SORROWGRAVE:
                    return SvalaSorrowgrave;
                case DATA_GORTOK_PALEHOOF:
                    return GortokPalehoof;
                case DATA_SKADI_THE_RUTHLESS:
                    return SkadiRuthless;
                case DATA_KING_YMIRON:
                    return KingYmiron;
                case DATA_NPC_FRENZIED_WORGEN:
                    return FrenziedWorgen;
                case DATA_NPC_RAVENOUS_FURBOLG:
                    return RavenousFurbolg;
                case DATA_NPC_MASSIVE_JORMUNGAR:
                    return MassiveJormungar;
                case DATA_NPC_FEROCIOUS_RHINO:
                    return FerociousRhino;
                case YMIRON_DOOR:
                    return YmironDoor;
                case STATIS_GENERATOR:
                    return StatisGenerator;
                case SKADI_DOOR:
                    return SkadiRuthlessDoor;
                case DATA_GRAUF:
                    return Grauf;
                case GO_SVALA_MIRROR:
                    return SvalaMirrorGUID;
            }

            return ObjectGuid::Empty;
        }
    };
};

void AddSC_instance_utgarde_pinnacle()
{
    new instance_utgarde_pinnacle();
}
