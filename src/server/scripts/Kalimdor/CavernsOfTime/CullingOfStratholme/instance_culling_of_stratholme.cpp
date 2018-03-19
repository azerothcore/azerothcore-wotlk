/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "CreatureTextMgr.h"
#include "culling_of_stratholme.h"
#include "Player.h"
#include "TemporarySummon.h"
#include "SpellInfo.h"

class instance_culling_of_stratholme : public InstanceMapScript
{
    public:
    instance_culling_of_stratholme() : InstanceMapScript("instance_culling_of_stratholme", 595) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_culling_of_stratholme_InstanceMapScript(pMap);
    }

    struct instance_culling_of_stratholme_InstanceMapScript : public InstanceScript
    {
        instance_culling_of_stratholme_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            // NPCs
            _arthasGUID = 0;
            _infiniteGUID = 0;

            // GOs
            _shkafGateGUID = 0;
            _exitGateGUID = 0;
            
            // Instance
            _crateCount = 0;
            _showCrateTimer = 0;
            _guardianTimer = 0;
            _respawnAndReposition = false;
            _encounterState = COS_PROGRESS_NOT_STARTED;
            _loadTimer = 0;
        }

        bool IsEncounterInProgress() const
        {
            return false;
        }

        void FillInitialWorldStates(WorldPacket& data)
        {
            data << uint32(WORLDSTATE_SHOW_CRATES) << uint32(0);
            data << uint32(WORLDSTATE_CRATES_REVEALED) << uint32(_crateCount);
            data << uint32(WORLDSTATE_WAVE_COUNT) << uint32(0);
            data << uint32(WORLDSTATE_TIME_GUARDIAN) << uint32(25);
            data << uint32(WORLDSTATE_TIME_GUARDIAN_SHOW) << uint32(0);
        }

        void OnPlayerEnter(Player* plr)
        {
            if (instance->GetPlayersCountExceptGMs() == 1)
                SetData(DATA_ARTHAS_REPOSITION, 2);

            EnsureGridLoaded();

            if (plr->getRace() != RACE_HUMAN && plr->getRace() != RACE_DWARF && plr->getRace() != RACE_GNOME)
                plr->CastSpell(plr, ((plr->getGender() == GENDER_MALE) ? SPELL_HUMAN_MALE : SPELL_HUMAN_FEMALE), true);
        }

        void OnCreatureCreate(Creature* creature)
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

        void OnGameObjectCreate(GameObject* go)
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

        void SetData(uint32 type, uint32 data)
        {
            switch (type)
            {
                case DATA_SHOW_CRATES:
                    DoUpdateWorldState(WORLDSTATE_SHOW_CRATES, data);
                    return;
                case DATA_SHOW_INFINITE_TIMER:
                    if (!instance->IsHeroic() || !_guardianTimer)
                        return;
                    DoUpdateWorldState(WORLDSTATE_TIME_GUARDIAN_SHOW, data);
                    DoUpdateWorldState(WORLDSTATE_TIME_GUARDIAN, uint32(_guardianTimer / (MINUTE*IN_MILLISECONDS)));
                    if (data == 0)
                    {
                        _guardianTimer = 0;
                        SaveToDB();
                    }
                    else if (!_infiniteGUID)
                        instance->SummonCreature(NPC_INFINITE, EventPos[EVENT_SRC_CORRUPTOR]);
                    return;
                case DATA_START_WAVES:
                    DoUpdateWorldState(WORLDSTATE_WAVE_COUNT, 1);
                    if (instance->IsHeroic())
                    {
                        DoUpdateWorldState(WORLDSTATE_TIME_GUARDIAN_SHOW, true);
                        _guardianTimer = 26*MINUTE*IN_MILLISECONDS;
                        if (!_infiniteGUID)
                            instance->SummonCreature(NPC_INFINITE, EventPos[EVENT_SRC_CORRUPTOR]);
                    }
                    return;
                case DATA_CRATE_COUNT:
                    _crateCount++;
                    if (_crateCount == 5)
                    {
                        Map::PlayerList const &PlayerList = instance->GetPlayers();
                        if (!PlayerList.isEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                i->GetSource()->KilledMonsterCredit(NPC_GRAIN_CREATE_TRIGGER, 0);

                        _showCrateTimer++;
                        if (GetData(DATA_ARTHAS_EVENT) < COS_PROGRESS_CRATES_FOUND)
                            SetData(DATA_ARTHAS_EVENT, COS_PROGRESS_CRATES_FOUND);
                    }

                    DoUpdateWorldState(WORLDSTATE_CRATES_REVEALED, _crateCount);
                    return;
                case DATA_ARTHAS_EVENT:
                    // Start Event
                    _encounterState = data;
                    if (data == COS_PROGRESS_START_INTRO)
                    {
                        if (Creature *arthas = instance->GetCreature(_arthasGUID))
                            arthas->AI()->DoAction(ACTION_START_EVENT);
                    }
                    else if (data == COS_PROGRESS_KILLED_SALRAMM)
                    {
                        if (Creature *arthas = instance->GetCreature(_arthasGUID))
                            arthas->AI()->DoAction(ACTION_KILLED_SALRAMM);
                    }
                    break;
                case DATA_ARTHAS_REPOSITION:
                    if (data == 2)
                        _respawnAndReposition = true;
                    else if (Creature *arthas = instance->GetCreature(_arthasGUID))
                        Reposition(arthas);
                    return;

            }

            if (type == DATA_ARTHAS_EVENT)
                SaveToDB();
        }

        uint32 GetData(uint32 type) const
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

        uint64 GetData64(uint32 identifier) const
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
            return 0;
        }

        void Update(uint32 diff)
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
                if (Creature *arthas = instance->GetCreature(_arthasGUID))
                {
                    if (!arthas->IsAlive())
                    {
                        EnsureGridLoaded();
                        arthas->setDeathState(DEAD);
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
                uint32 div = uint32(_guardianTimer / (MINUTE*IN_MILLISECONDS));
                _guardianTimer -= diff;
                uint32 divAfter = uint32(_guardianTimer / (MINUTE*IN_MILLISECONDS));
                
                if (divAfter == 0)
                {
                    _guardianTimer = 0;
                    DoUpdateWorldState(WORLDSTATE_TIME_GUARDIAN_SHOW, 0);

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

                    DoUpdateWorldState(WORLDSTATE_TIME_GUARDIAN, divAfter);
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
                    DoUpdateWorldState(WORLDSTATE_SHOW_CRATES, 0);
                    _showCrateTimer = 0;
                    _encounterState = COS_PROGRESS_CRATES_FOUND;
                }
            }
        }

        void ChromieWhisper(uint8 textId)
        {
            if (!instance->GetPlayers().isEmpty())
                if (Player* player = instance->GetPlayers().getFirst()->GetSource())
                {
                    Position pos;
                    player->GetPosition(&pos);
                    if (Creature* cr = instance->SummonCreature(NPC_CHROMIE_MIDDLE, pos))
                    {
                        cr->SetVisible(false);
                        cr->DespawnOrUnsummon(1000);
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

        void EnsureGridLoaded()
        {
            instance->LoadGrid(LeaderIntroPos1.GetPositionX(), LeaderIntroPos1.GetPositionY());
            instance->LoadGrid(LeaderIntroPos2.GetPositionX(), LeaderIntroPos2.GetPositionY());
            instance->LoadGrid(LeaderIntroPos3.GetPositionX(), LeaderIntroPos3.GetPositionY());
            instance->LoadGrid(LeaderIntroPos4.GetPositionX(), LeaderIntroPos4.GetPositionY());
            instance->LoadGrid(LeaderIntroPos5.GetPositionX(), LeaderIntroPos5.GetPositionY());
            instance->LoadGrid(LeaderIntroPos6.GetPositionX(), LeaderIntroPos6.GetPositionY());
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
                saveStream << "C S " << _encounterState << ' ' << _guardianTimer;

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
            uint64 _arthasGUID;
            uint64 _infiniteGUID;

            // GOs
            uint64 _shkafGateGUID;
            uint64 _exitGateGUID;
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
