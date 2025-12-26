/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "WorldStateDefines.h"
#include "WorldStatePackets.h"
#include "culling_of_stratholme.h"

class instance_culling_of_stratholme : public InstanceMapScript
{
public:
    instance_culling_of_stratholme() : InstanceMapScript("instance_culling_of_stratholme", MAP_THE_CULLING_OF_STRATHOLME) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_culling_of_stratholme_InstanceMapScript(pMap);
    }

    struct instance_culling_of_stratholme_InstanceMapScript : public InstanceScript
    {
        instance_culling_of_stratholme_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            // Instance
            SetHeaders(DataHeader);
            _crateCount = 0;
            _showCrateTimer = 0;
            _guardianTimer = 0;
            _respawnAndReposition = false;
            _encounterState = COS_PROGRESS_NOT_STARTED;
            _loadTimer = 0;
        }

        bool IsEncounterInProgress() const override
        {
            return false;
        }

        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override
        {
            packet.Worldstates.reserve(5);
            packet.Worldstates.emplace_back(WORLD_STATE_CULLING_OF_STRATHOLME_SHOW_CRATES, 0);
            packet.Worldstates.emplace_back(WORLD_STATE_CULLING_OF_STRATHOLME_CRATES_REVEALED, _crateCount);
            packet.Worldstates.emplace_back(WORLD_STATE_CULLING_OF_STRATHOLME_WAVE_COUNT, 0);
            packet.Worldstates.emplace_back(WORLD_STATE_CULLING_OF_STRATHOLME_TIME_GUARDIAN, 25);
            packet.Worldstates.emplace_back(WORLD_STATE_CULLING_OF_STRATHOLME_TIME_GUARDIAN_SHOW, 0);
        }

        void OnPlayerEnter(Player* plr) override
        {
            if (instance->GetPlayersCountExceptGMs() == 1)
                SetData(DATA_ARTHAS_REPOSITION, 2);

            if (plr->getRace() != RACE_HUMAN && plr->getRace() != RACE_DWARF && plr->getRace() != RACE_GNOME)
                plr->CastSpell(plr, ((plr->getGender() == GENDER_MALE) ? SPELL_HUMAN_MALE : SPELL_HUMAN_FEMALE), true);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_ARTHAS:
                    _arthasGUID = creature->GetGUID();
                    if (_encounterState == COS_PROGRESS_FINISHED)
                        creature->SetVisible(false);
                    else
                        Reposition(creature);
                    break;
                case NPC_INFINITE:
                    _infiniteGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_SHKAF_GATE:
                    _shkafGateGUID = go->GetGUID();
                    if (_encounterState >= COS_PROGRESS_KILLED_EPOCH)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_EXIT_GATE:
                    _exitGateGUID = go->GetGUID();
                    if (_encounterState == COS_PROGRESS_FINISHED)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_SHOW_CRATES:
                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_SHOW_CRATES, data);
                    return;
                case DATA_SHOW_INFINITE_TIMER:
                    if (!instance->IsHeroic() || !_guardianTimer)
                        return;
                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_TIME_GUARDIAN_SHOW, data);
                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_TIME_GUARDIAN, uint32(_guardianTimer / (MINUTE * IN_MILLISECONDS)));
                    if (data == 0)
                    {
                        _guardianTimer = 0;
                        SaveToDB();
                    }
                    else if (!_infiniteGUID)
                        instance->SummonCreature(NPC_INFINITE, EventPos[EVENT_SRC_CORRUPTOR]);
                    return;
                case DATA_START_WAVES:
                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_WAVE_COUNT, 1);
                    if (instance->IsHeroic())
                    {
                        DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_TIME_GUARDIAN_SHOW, true);
                        _guardianTimer = 26 * MINUTE * IN_MILLISECONDS;
                        if (!_infiniteGUID)
                            instance->SummonCreature(NPC_INFINITE, EventPos[EVENT_SRC_CORRUPTOR]);
                    }
                    return;
                case DATA_CRATE_COUNT:
                    _crateCount++;
                    if (_crateCount == 5)
                    {
                        Map::PlayerList const& PlayerList = instance->GetPlayers();
                        if (!PlayerList.IsEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                i->GetSource()->KilledMonsterCredit(NPC_GRAIN_CREATE_TRIGGER);

                        _showCrateTimer++;
                        if (GetData(DATA_ARTHAS_EVENT) < COS_PROGRESS_CRATES_FOUND)
                            SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_CRATES_FOUND);
                    }

                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_CRATES_REVEALED, _crateCount);
                    return;
                case DATA_ARTHAS_EVENT:
                    // Start Event
                    _encounterState = data;
                    if (data == COS_PROGRESS_START_INTRO)
                    {
                        if (Creature* arthas = instance->GetCreature(_arthasGUID))
                            arthas->AI()->DoAction(ACTION_START_EVENT);
                    }
                    else if (data == COS_PROGRESS_KILLED_SALRAMM)
                    {
                        if (Creature* arthas = instance->GetCreature(_arthasGUID))
                            arthas->AI()->DoAction(ACTION_KILLED_SALRAMM);
                    }
                    break;
                case DATA_ARTHAS_REPOSITION:
                    if (data == 2)
                        _respawnAndReposition = true;
                    else if (Creature* arthas = instance->GetCreature(_arthasGUID))
                        Reposition(arthas);
                    return;
            }

            if (type == DATA_ARTHAS_EVENT)
                SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_ARTHAS_EVENT:
                    return _encounterState;
                case DATA_GUARDIANTIME_EVENT:
                    return _guardianTimer;
            }
            return 0;
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case DATA_SHKAF_GATE:
                    return _shkafGateGUID;
                case DATA_ARTHAS:
                    return _arthasGUID;
                case DATA_EXIT_GATE:
                    return _exitGateGUID;
            }

            return ObjectGuid::Empty;
        }

        void Update(uint32 diff) override
        {
            if (_loadTimer)
            {
                _loadTimer += diff;
                if (_loadTimer > 3000)
                {
                    UpdateEventState();
                    _loadTimer = 0;
                }
            }
            // Used when arthas dies
            if (_respawnAndReposition)
            {
                if (Creature* arthas = instance->GetCreature(_arthasGUID))
                {
                    if (!arthas->IsAlive())
                    {
                        arthas->setDeathState(DeathState::Dead);
                        arthas->Respawn();
                    }
                    else
                    {
                        arthas->AI()->Reset();
                        _respawnAndReposition = false;
                    }
                }
            }

            // Used after 5-th crates is revealed
            if (_showCrateTimer)
            {
                _showCrateTimer += diff;
                if (_showCrateTimer >= 20000)
                {
                    UpdateEventState();
                    _showCrateTimer = 0; // just to be sure
                }
            }

            // Used to display how much time players have
            if (_guardianTimer)
            {
                uint32 div = uint32(_guardianTimer / (MINUTE * IN_MILLISECONDS));
                _guardianTimer -= diff;
                uint32 divAfter = uint32(_guardianTimer / (MINUTE * IN_MILLISECONDS));

                if (divAfter == 0)
                {
                    _guardianTimer = 0;
                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_TIME_GUARDIAN_SHOW, 0);

                    // Inform infinite we run out of time
                    if (instance->IsHeroic() && _infiniteGUID)
                        if (Creature* cr = instance->GetCreature(_infiniteGUID))
                            cr->AI()->DoAction(ACTION_RUN_OUT_OF_TIME);
                }
                else if (div > divAfter)
                {
                    if (divAfter == 5)
                        ChromieWhisper(1);
                    else if (divAfter == 1)
                        ChromieWhisper(2);

                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_TIME_GUARDIAN, divAfter);
                    SaveToDB();
                }
            }
        }

        void UpdateEventState()
        {
            if (_encounterState > COS_PROGRESS_NOT_STARTED)
            {
                // Summon Chromie and global whisper
                instance->SummonCreature(NPC_CHROMIE_MIDDLE, EventPos[EVENT_POS_CHROMIE]);
                instance->SummonCreature(NPC_HOURGLASS, EventPos[EVENT_POS_HOURGLASS]);

                if (_encounterState == COS_PROGRESS_CRATES_FOUND ||
                        _encounterState == COS_PROGRESS_START_INTRO)
                {
                    ChromieWhisper(0);

                    // hide crates count
                    DoUpdateWorldState(WORLD_STATE_CULLING_OF_STRATHOLME_SHOW_CRATES, 0);
                    _showCrateTimer = 0;
                    _encounterState = COS_PROGRESS_CRATES_FOUND;
                }
            }
        }

        void ChromieWhisper(uint8 textId)
        {
            if (!instance->GetPlayers().IsEmpty())
                if (Player* player = instance->GetPlayers().getFirst()->GetSource())
                {
                    Position pos = player->GetPosition();
                    if (Creature* cr = instance->SummonCreature(NPC_CHROMIE_MIDDLE, pos))
                    {
                        cr->SetVisible(false);
                        cr->DespawnOrUnsummon(1s);
                        sCreatureTextMgr->SendChat(cr, textId, player, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_MAP);
                    }
                }
        }

        void Reposition(Creature* arthas)
        {
            switch (GetData(DATA_ARTHAS_EVENT))
            {
                case COS_PROGRESS_FINISHED_INTRO:
                    arthas->UpdatePosition(LeaderIntroPos2, true);
                    arthas->SetHomePosition(LeaderIntroPos2);
                    arthas->SetFacingTo(LeaderIntroPos2.GetOrientation());
                    break;
                case COS_PROGRESS_FINISHED_CITY_INTRO:
                case COS_PROGRESS_KILLED_MEATHOOK:
                case COS_PROGRESS_KILLED_SALRAMM:
                    arthas->UpdatePosition(LeaderIntroPos2special, true);
                    arthas->SetHomePosition(LeaderIntroPos2special);
                    arthas->SetFacingTo(LeaderIntroPos2special.GetOrientation());
                    break;
                case COS_PROGRESS_REACHED_TOWN_HALL:
                    arthas->UpdatePosition(LeaderIntroPos3, true);
                    arthas->SetHomePosition(LeaderIntroPos3);
                    arthas->SetFacingTo(LeaderIntroPos3.GetOrientation());
                    break;
                case COS_PROGRESS_KILLED_EPOCH:
                    arthas->UpdatePosition(LeaderIntroPos4, true);
                    arthas->SetHomePosition(LeaderIntroPos4);
                    arthas->SetFacingTo(LeaderIntroPos4.GetOrientation());
                    break;
                case COS_PROGRESS_LAST_CITY:
                    arthas->UpdatePosition(LeaderIntroPos5, true);
                    arthas->SetHomePosition(LeaderIntroPos5);
                    arthas->SetFacingTo(LeaderIntroPos5.GetOrientation());
                    break;
                case COS_PROGRESS_BEFORE_MALGANIS:
                    arthas->UpdatePosition(LeaderIntroPos6, true);
                    arthas->SetHomePosition(LeaderIntroPos6);
                    arthas->SetFacingTo(LeaderIntroPos6.GetOrientation());
                    break;
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "C S " << _encounterState << ' ' << _guardianTimer;

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
            uint32 data0, data1;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1;

            if (dataHead1 == 'C' && dataHead2 == 'S')
            {
                _encounterState = data0;
                _guardianTimer = data1;

                //UpdateEventState();
                _loadTimer++;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        // NPCs
        ObjectGuid _arthasGUID;
        ObjectGuid _infiniteGUID;

        // GOs
        ObjectGuid _shkafGateGUID;
        ObjectGuid _exitGateGUID;
        uint32 _encounterState;
        uint32 _crateCount;
        uint32 _showCrateTimer;
        uint32 _guardianTimer;

        bool _respawnAndReposition;
        uint32 _loadTimer;
    };
};

void AddSC_instance_culling_of_stratholme()
{
    new instance_culling_of_stratholme();
}
