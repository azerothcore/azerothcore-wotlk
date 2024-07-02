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

#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "CreatureScript.h"
#include "GameTime.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "vault_of_archavon.h"

/* Vault of Archavon encounters:
1 - Archavon the Stone Watcher event
2 - Emalon the Storm Watcher event
3 - Koralon the Flame Watcher event
4 - Toravon the Ice Watcher event
*/

class instance_vault_of_archavon : public InstanceMapScript
{
public:
    instance_vault_of_archavon() : InstanceMapScript("instance_vault_of_archavon", 624) { }

    struct instance_vault_of_archavon_InstanceMapScript : public InstanceScript
    {
        instance_vault_of_archavon_InstanceMapScript(Map* map) : InstanceScript(map)
        {
        }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            ArchavonDeath = 0;
            EmalonDeath = 0;
            KoralonDeath = 0;
            checkTimer = 0;
            stoned = false;
        }

        void OnPlayerEnter(Player* ) override
        {
            if (stoned)
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (Creature* cr = instance->GetCreature(bossGUIDs[i]))
                        if (!cr->IsInCombat())
                            cr->RemoveAllAuras();

                stoned = false;
            }
        }

        void Update(uint32 diff) override
        {
            checkTimer += diff;
            if (checkTimer >= 60000)
            {
                checkTimer -= 60000; // one minute
                if (Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG))
                {
                    if (!bf->IsWarTime())
                    {
                        if (bf->GetTimer() <= (16 * MINUTE * IN_MILLISECONDS) && bf->GetTimer() >= (15 * MINUTE * IN_MILLISECONDS))
                        {
                            Map::PlayerList const& PlayerList = instance->GetPlayers();
                            if (!PlayerList.IsEmpty())
                                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                    if (Player* player = i->GetSource())
                                        player->TextEmote("This instance will reset in 15 minutes.", nullptr, true);
                        }
                        else if (bf->GetTimer() <= (10 * MINUTE * IN_MILLISECONDS) && bf->GetTimer() >= (9 * MINUTE * IN_MILLISECONDS))
                        {
                            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                                if (Creature* cr = instance->GetCreature(bossGUIDs[i]))
                                    if (!cr->IsInCombat())
                                    {
                                        cr->RemoveAllAuras();
                                        if (Aura* aur = cr->AddAura(SPELL_STONED_AURA, cr))
                                        {
                                            aur->SetMaxDuration(60 * MINUTE * IN_MILLISECONDS);
                                            aur->SetDuration(60 * MINUTE * IN_MILLISECONDS);
                                        }
                                    }

                            stoned = true;
                        }
                        else if (bf->GetTimer() <= (2 * MINUTE * IN_MILLISECONDS) && bf->GetTimer() > (MINUTE * IN_MILLISECONDS))
                        {
                            Map::PlayerList const& PlayerList = instance->GetPlayers();
                            if (!PlayerList.IsEmpty())
                                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                    if (Player* player = i->GetSource())
                                        player->TextEmote("This instance is about to reset. Prepare to be removed.", nullptr, true);
                        }
                        else if (bf->GetTimer() <= MINUTE * IN_MILLISECONDS)
                        {
                            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                                if (Creature* cr = instance->GetCreature(bossGUIDs[i]))
                                    if (cr->IsInCombat() && cr->AI())
                                        cr->AI()->EnterEvadeMode();

                            Map::PlayerList const& PlayerList = instance->GetPlayers();
                            if (!PlayerList.IsEmpty())
                                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                    if (Player* player = i->GetSource())
                                        player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->GetOrientation());
                        }
                    }
                }
            }
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;

            Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
            if (!bf || bf->IsWarTime() || bf->GetTimer() <= 10 * MINUTE * IN_MILLISECONDS)
                return true;

            return false;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case CREATURE_TORAVON:
                    bossGUIDs[EVENT_TORAVON] = creature->GetGUID();
                    break;
                case CREATURE_ARCHAVON:
                    bossGUIDs[EVENT_ARCHAVON] = creature->GetGUID();
                    break;
                case CREATURE_KORALON:
                    bossGUIDs[EVENT_KORALON] = creature->GetGUID();
                    break;
                case CREATURE_EMALON:
                    bossGUIDs[EVENT_EMALON] = creature->GetGUID();
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            if (identifier < MAX_ENCOUNTER)
                return bossGUIDs[identifier];

            return ObjectGuid::Empty;
        }

        uint32 GetData(uint32 identifier) const override
        {
            if (identifier == DATA_STONED)
                return (uint32)stoned;
            return 0;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch(type)
            {
                case EVENT_ARCHAVON:
                case EVENT_EMALON:
                case EVENT_KORALON:
                case EVENT_TORAVON:
                    m_auiEncounter[type] = data;
                    break;
            }

            if (data == DONE)
            {
                SaveToDB();
                switch (type)
                {
                    case EVENT_ARCHAVON:
                        ArchavonDeath = GameTime::GetGameTime().count();
                        break;
                    case EVENT_EMALON:
                        EmalonDeath = GameTime::GetGameTime().count();
                        break;
                    case EVENT_KORALON:
                        KoralonDeath = GameTime::GetGameTime().count();
                        break;
                    default:
                        return;
                }

                // on every death of Archavon, Emalon and Koralon check our achievement
                DoCastSpellOnPlayers(SPELL_EARTH_WIND_FIRE_ACHIEVEMENT_CHECK);
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case CRITERIA_EARTH_WIND_FIRE_10:
                case CRITERIA_EARTH_WIND_FIRE_25:
                    if (ArchavonDeath && EmalonDeath && KoralonDeath)
                    {
                        // instance difficulty check is already done in db (achievement_criteria_data)
                        // int() for Visual Studio, compile errors with std::abs(time_t)
                        return (std::abs(int(ArchavonDeath - EmalonDeath)) < MINUTE && \
                                std::abs(int(EmalonDeath - KoralonDeath)) < MINUTE && \
                                std::abs(int(KoralonDeath - ArchavonDeath)) < MINUTE);
                    }
                    break;
                default:
                    break;
            }

            return false;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
            data >> m_auiEncounter[2];
            data >> m_auiEncounter[3];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' '
                << m_auiEncounter[1] << ' '
                << m_auiEncounter[2] << ' '
                << m_auiEncounter[3];
        }

    private:
        time_t ArchavonDeath;
        time_t EmalonDeath;
        time_t KoralonDeath;
        uint32 checkTimer;
        bool stoned;

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        ObjectGuid bossGUIDs[MAX_ENCOUNTER];
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_vault_of_archavon_InstanceMapScript(map);
    }
};

void AddSC_instance_vault_of_archavon()
{
    new instance_vault_of_archavon();
}

