/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "the_black_morass.h"
#include "Player.h"
#include "TemporarySummon.h"
#include "SpellInfo.h"
#include "ScriptedCreature.h"


const Position PortalLocation[4]=
{
    {-2041.06f, 7042.08f, 29.99f, 1.30f},
    {-1968.18f, 7042.11f, 21.93f, 2.12f},
    {-1885.82f, 7107.36f, 22.32f, 3.07f},
    {-1928.11f, 7175.95f, 22.11f, 3.44f}
};

class instance_the_black_morass : public InstanceMapScript
{
public:
    instance_the_black_morass() : InstanceMapScript("instance_the_black_morass", 269) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_the_black_morass_InstanceMapScript(map);
    }

    struct instance_the_black_morass_InstanceMapScript : public InstanceScript
    {
        instance_the_black_morass_InstanceMapScript(Map* map) : InstanceScript(map) { }

        std::set<uint64> encounterNPCs;
        uint32 encounters[MAX_ENCOUNTER];
        uint64 _medivhGUID;
        uint8  _currentRift;
        uint8  _shieldPercent;

        void Initialize()
        {
            memset(&encounters, 0, sizeof(encounters));
            _medivhGUID = 0;
            _currentRift = 0;
            _shieldPercent = 100;
            encounterNPCs.clear();
        }

        void CleanupInstance()
        {
            Events.Reset();
            _currentRift = 0;
            _shieldPercent = 100;

            instance->LoadGrid(-2023.0f, 7121.0f);
            if (Creature* medivh = instance->GetCreature(_medivhGUID))
            {
                medivh->DespawnOrUnsummon();
                medivh->SetRespawnTime(3);
            }

            std::set<uint64> eCopy = encounterNPCs;
            for (std::set<uint64>::const_iterator itr = eCopy.begin(); itr != eCopy.end(); ++itr)
                if (Creature* creature = instance->GetCreature(*itr))
                    creature->DespawnOrUnsummon();
        }

        bool IsEncounterInProgress() const
        {
            return false;
        }

        void OnPlayerEnter(Player* player)
        {
            if (instance->GetPlayersCountExceptGMs() <= 1 && GetData(TYPE_AEONUS) != DONE)
                CleanupInstance();

            player->SendUpdateWorldState(WORLD_STATE_BM, _currentRift > 0 ? 1 : 0);
            player->SendUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
            player->SendUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case NPC_MEDIVH:
                    _medivhGUID = creature->GetGUID();
                    break;
                case NPC_TIME_RIFT:
                case NPC_CHRONO_LORD_DEJA:
                case NPC_INFINITE_CHRONO_LORD:
                case NPC_TEMPORUS:
                case NPC_INFINITE_TIMEREAVER:
                case NPC_AEONUS:
                case NPC_RIFT_KEEPER_WARLOCK:
                case NPC_RIFT_KEEPER_MAGE:
                case NPC_RIFT_LORD:
                case NPC_RIFT_LORD_2:
                case NPC_INFINITE_ASSASIN:
                case NPC_INFINITE_WHELP:
                case NPC_INFINITE_CRONOMANCER:
                case NPC_INFINITE_EXECUTIONER:
                case NPC_INFINITE_VANQUISHER:
                    encounterNPCs.insert(creature->GetGUID());
                    break;
            }
        }

        void OnCreatureRemove(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case NPC_TIME_RIFT:
                case NPC_CHRONO_LORD_DEJA:
                case NPC_INFINITE_CHRONO_LORD:
                case NPC_TEMPORUS:
                case NPC_INFINITE_TIMEREAVER:
                case NPC_AEONUS:
                case NPC_RIFT_KEEPER_WARLOCK:
                case NPC_RIFT_KEEPER_MAGE:
                case NPC_RIFT_LORD:
                case NPC_RIFT_LORD_2:
                case NPC_INFINITE_ASSASIN:
                case NPC_INFINITE_WHELP:
                case NPC_INFINITE_CRONOMANCER:
                case NPC_INFINITE_EXECUTIONER:
                case NPC_INFINITE_VANQUISHER:
                    encounterNPCs.erase(creature->GetGUID());
                    break;
            }
        }

        void SetData(uint32 type, uint32  /*data*/)
        {
            switch (type)
            {
                case TYPE_AEONUS:
                {
                    encounters[type] = DONE;
                    SaveToDB();

                    if (Creature* medivh = instance->GetCreature(_medivhGUID))
                        medivh->AI()->DoAction(ACTION_OUTRO);

                    Map::PlayerList const& players = instance->GetPlayers();
                    if (!players.isEmpty())
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            if (Player* player = itr->GetSource())
                            {
                                if (player->GetQuestStatus(QUEST_OPENING_PORTAL) == QUEST_STATUS_INCOMPLETE)
                                    player->AreaExploredOrEventHappens(QUEST_OPENING_PORTAL);

                                if (player->GetQuestStatus(QUEST_MASTER_TOUCH) == QUEST_STATUS_INCOMPLETE)
                                    player->AreaExploredOrEventHappens(QUEST_MASTER_TOUCH);
                            }
                    break;
                }
                case TYPE_CHRONO_LORD_DEJA:
                case TYPE_TEMPORUS:
                    encounters[type] = DONE;
                    Events.RescheduleEvent(EVENT_NEXT_PORTAL, 60000);
                    Events.SetPhase(1);
                    SaveToDB();
                    break;
                case DATA_RIFT_KILLED:
                    if (!Events.IsInPhase(1))
                        Events.RescheduleEvent(EVENT_NEXT_PORTAL, 4000);
                    break;
                case DATA_MEDIVH:
                    DoUpdateWorldState(WORLD_STATE_BM, 1);
                    DoUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
                    DoUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
                    Events.RescheduleEvent(EVENT_NEXT_PORTAL, 3000);
                    break;
                case DATA_DAMAGE_SHIELD:
                    --_shieldPercent;
                    DoUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
                    if (!_shieldPercent)
                        if (Creature* medivh = instance->GetCreature(_medivhGUID))
                            if (medivh->IsAlive())
                            {
                                Unit::Kill(medivh, medivh);

                                // Xinef: delete all spawns
                                std::set<uint64> eCopy = encounterNPCs;
                                for (std::set<uint64>::iterator itr = eCopy.begin(); itr != eCopy.end(); ++itr)
                                    if (Creature* creature = instance->GetCreature(*itr))
                                        creature->DespawnOrUnsummon();
                            }
                    break;
            }
        }

        uint32 GetData(uint32 type) const
        {
            switch (type)
            {
                case TYPE_CHRONO_LORD_DEJA:
                case TYPE_TEMPORUS:
                case TYPE_AEONUS:
                    return encounters[type];
                case DATA_SHIELD_PERCENT:
                    return _shieldPercent;
                case DATA_RIFT_NUMBER:
                    return _currentRift;
            }
            return 0;
        }

        void SetData64(uint32 type, uint64 data)
        {
            if (type == DATA_SUMMONED_NPC)
                encounterNPCs.insert(data);
            else if (type == DATA_DELETED_NPC)
                encounterNPCs.erase(data);
        }

        uint64 GetData64(uint32 data) const
        {
            if (data == DATA_MEDIVH)
                return _medivhGUID;

            return 0;
        }

        void SummonPortalKeeper()
        {
            Creature* rift = nullptr;
            for (std::set<uint64>::const_iterator itr = encounterNPCs.begin(); itr != encounterNPCs.end(); ++itr)
                if (Creature* summon = instance->GetCreature(*itr))
                    if (summon->GetEntry() == NPC_TIME_RIFT)
                    {
                        rift = summon;
                        break;
                    }

            if (!rift)
                return;

            int32 entry = 0;
            switch (_currentRift)
            {
                case 6: entry = GetData(TYPE_CHRONO_LORD_DEJA) == DONE ? (instance->IsHeroic() ? NPC_INFINITE_CHRONO_LORD : -NPC_CHRONO_LORD_DEJA) : NPC_CHRONO_LORD_DEJA; break;
                case 12: entry = GetData(TYPE_TEMPORUS) == DONE ? (instance->IsHeroic() ? NPC_INFINITE_TIMEREAVER : -NPC_TEMPORUS) : NPC_TEMPORUS; break;
                case 18: entry = NPC_AEONUS; break;
                default: entry = RAND(NPC_RIFT_KEEPER_WARLOCK, NPC_RIFT_KEEPER_MAGE, NPC_RIFT_LORD, NPC_RIFT_LORD_2); break;
            }

            Position pos;
            rift->GetNearPosition(pos, 10.0f, 2*M_PI*rand_norm());

            if (TempSummon* summon = instance->SummonCreature(abs(entry), pos))
            {
                summon->SetTempSummonType(TEMPSUMMON_CORPSE_TIMED_DESPAWN);
                summon->SetTimer(3*MINUTE*IN_MILLISECONDS);

                if (entry < 0)
                    summon->SetLootMode(0);

                if (summon->GetEntry() != NPC_AEONUS)
                {
                    rift->AI()->SetGUID(summon->GetGUID());
                    rift->CastSpell(summon, SPELL_RIFT_CHANNEL, false);
                }
                else
                    summon->SetReactState(REACT_DEFENSIVE);
            }
        }

        void Update(uint32 diff)
        {
            Events.Update(diff);
            switch (Events.ExecuteEvent())
            {
                case EVENT_NEXT_PORTAL:
                    ++_currentRift;
                    DoUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
                    Events.ScheduleEvent(EVENT_SUMMON_KEEPER, 6000);
                    Events.SetPhase(0);

                    if (instance->GetCreature(_medivhGUID))
                    {
                        uint8 position = (_currentRift-1)%4;
                        instance->SummonCreature(NPC_TIME_RIFT, PortalLocation[position]);
                    }
                    break;
                case EVENT_SUMMON_KEEPER:
                    SummonPortalKeeper();
                    break;
            }
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "B M " << encounters[0] << ' ' << encounters[1] << ' ' << encounters[2];

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

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'B' && dataHead2 == 'M')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    loadStream >> encounters[i];
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        protected:
            EventMap Events;
    };

};

void AddSC_instance_the_black_morass()
{
    new instance_the_black_morass();
}
