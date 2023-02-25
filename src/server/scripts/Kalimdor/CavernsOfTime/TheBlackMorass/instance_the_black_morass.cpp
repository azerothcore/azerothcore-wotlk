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

#include "InstanceScript.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "the_black_morass.h"

#define MAX_PORTAL_LOCATIONS 4
const Position PortalLocation[MAX_PORTAL_LOCATIONS] =
{
    { -2030.8318f, 7024.9443f, 23.071817f, 3.14159f },
    { -1961.7335f, 7029.5280f, 21.811401f, 2.12931f },
    { -1887.6950f, 7106.5570f, 22.049500f, 4.95673f },
    { -1930.9106f, 7183.5970f, 23.007639f, 3.59537f }
};

class instance_the_black_morass : public InstanceMapScript
{
public:
    instance_the_black_morass() : InstanceMapScript("instance_the_black_morass", 269) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_the_black_morass_InstanceMapScript(map);
    }

    struct instance_the_black_morass_InstanceMapScript : public InstanceScript
    {
        instance_the_black_morass_InstanceMapScript(Map* map) : InstanceScript(map) { }

        GuidSet encounterNPCs;
        uint32 encounters[MAX_ENCOUNTER];
        ObjectGuid _medivhGUID;
        uint8 _currentRift;
        int8 _shieldPercent;

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&encounters, 0, sizeof(encounters));
            _currentRift = 0;
            _shieldPercent = 100;
            encounterNPCs.clear();
            _timerToNextBoss = 0;
        }

        void CleanupInstance()
        {
            Events.Reset();
            _currentRift = 0;
            _shieldPercent = 100;

            _usedRiftPostions.fill(ObjectGuid::Empty);

            instance->LoadGrid(-2023.0f, 7121.0f);
            if (Creature* medivh = instance->GetCreature(_medivhGUID))
            {
                medivh->DespawnOrUnsummon();
                medivh->SetRespawnTime(3);
            }

            GuidSet eCopy = encounterNPCs;
            for (ObjectGuid const& guid : eCopy)
                if (Creature* creature = instance->GetCreature(guid))
                    creature->DespawnOrUnsummon();
        }

        bool IsEncounterInProgress() const override
        {
            return false;
        }

        void OnPlayerEnter(Player* player) override
        {
            if (instance->GetPlayersCountExceptGMs() <= 1 && GetData(TYPE_AEONUS) != DONE)
                CleanupInstance();

            player->SendUpdateWorldState(WORLD_STATE_BM, _currentRift > 0 ? 1 : 0);
            player->SendUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
            player->SendUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
        }

        void OnCreatureCreate(Creature* creature) override
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
                case NPC_DP_BEAM_STALKER:
                    encounterNPCs.insert(creature->GetGUID());
                    break;
            }
        }

        void OnCreatureRemove(Creature* creature) override
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

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_AEONUS:
                {
                    encounters[type] = DONE;
                    SaveToDB();

                    if (Creature* medivh = instance->GetCreature(_medivhGUID))
                    {
                        medivh->AI()->DoAction(ACTION_OUTRO);
                    }

                    Map::PlayerList const& players = instance->GetPlayers();
                    if (!players.IsEmpty())
                    {
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                        {
                            if (Player* player = itr->GetSource())
                            {
                                if (player->GetQuestStatus(QUEST_OPENING_PORTAL) == QUEST_STATUS_INCOMPLETE)
                                {
                                    player->AreaExploredOrEventHappens(QUEST_OPENING_PORTAL);
                                }

                                if (player->GetQuestStatus(QUEST_MASTER_TOUCH) == QUEST_STATUS_INCOMPLETE)
                                {
                                    player->AreaExploredOrEventHappens(QUEST_MASTER_TOUCH);
                                }
                            }
                        }
                    }
                    break;
                }
                case TYPE_CHRONO_LORD_DEJA:
                case TYPE_TEMPORUS:
                {
                    GuidSet eCopy = encounterNPCs;
                    for (ObjectGuid const& guid : eCopy)
                    {
                        if (Creature* creature = instance->GetCreature(guid))
                        {
                            switch (creature->GetEntry())
                            {
                                case NPC_RIFT_KEEPER_WARLOCK:
                                case NPC_RIFT_KEEPER_MAGE:
                                case NPC_RIFT_LORD:
                                case NPC_RIFT_LORD_2:
                                case NPC_TIME_RIFT:
                                    creature->DespawnOrUnsummon();
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                    encounters[type] = DONE;

                    if (!_timerToNextBoss || _timerToNextBoss > 30 * IN_MILLISECONDS)
                    {
                        Events.RescheduleEvent(EVENT_NEXT_PORTAL, 30 * IN_MILLISECONDS);
                    }
                    else
                    {
                        Events.RescheduleEvent(EVENT_NEXT_PORTAL, _timerToNextBoss);
                    }
                    Events.SetPhase(1);
                    SaveToDB();
                    _timerToNextBoss = (instance->IsHeroic() ? 300 : 150) * IN_MILLISECONDS;
                    break;
                }
                case DATA_MEDIVH:
                {
                    DoUpdateWorldState(WORLD_STATE_BM, 1);
                    DoUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
                    DoUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
                    Events.RescheduleEvent(EVENT_NEXT_PORTAL, 3000);
                    _timerToNextBoss = (instance->IsHeroic() ? 300 : 150) * IN_MILLISECONDS;

                    for (ObjectGuid const& guid : encounterNPCs)
                    {
                        if (guid.GetEntry() == NPC_DP_BEAM_STALKER)
                        {
                            if (Creature* creature = instance->GetCreature(guid))
                            {
                                if (!creature->IsAlive())
                                {
                                    creature->Respawn(true);
                                }
                            }
                            break;
                        }
                    }

                    break;
                }
                case DATA_DAMAGE_SHIELD:
                {
                    if (_shieldPercent <= 0)
                    {
                        return;
                    }

                    _shieldPercent -= data;
                    if (_shieldPercent < 0)
                    {
                        _shieldPercent = 0;
                    }

                    DoUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);

                    if (!_shieldPercent)
                    {
                        if (Creature* medivh = instance->GetCreature(_medivhGUID))
                        {
                            if (medivh->IsAlive())
                            {
                                medivh->SetImmuneToNPC(true);

                                if (medivh->IsAIEnabled)
                                {
                                    medivh->AI()->Talk(SAY_MEDIVH_DEATH);
                                }

                                Events.ScheduleEvent(EVENT_WIPE_1, 4s);

                                for (ObjectGuid const& guid : encounterNPCs)
                                {
                                    if (Creature* creature = instance->GetCreature(guid))
                                    {
                                        creature->InterruptNonMeleeSpells(true);
                                    }
                                }
                            }
                        }
                    }
                    break;
                }
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
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

        void SetGuidData(uint32 type, ObjectGuid data) override
        {
            if (type == DATA_SUMMONED_NPC)
                encounterNPCs.insert(data);
            else if (type == DATA_DELETED_NPC)
                encounterNPCs.erase(data);
            else if (type == DATA_RIFT_KILLED)
            {
                if (!Events.IsInPhase(1))
                {
                    uint8 emptySpots = 0;
                    for (uint8 i = 0; i < MAX_PORTAL_LOCATIONS; ++i)
                    {
                        if (!_usedRiftPostions[i])
                        {
                            ++emptySpots;
                        }

                        if (_usedRiftPostions[i] == data)
                        {
                            _usedRiftPostions[i].Clear();
                        }
                    }

                    if (emptySpots >= MAX_PORTAL_LOCATIONS - 1)
                    {
                        Events.RescheduleEvent(EVENT_NEXT_PORTAL, 4000);
                    }
                    else if (!emptySpots)
                    {
                        Events.RescheduleEvent(EVENT_NEXT_PORTAL, (_currentRift >= 13 ? 120 : 90) * IN_MILLISECONDS);
                    }
                }
            }
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            if (data == DATA_MEDIVH)
                return _medivhGUID;

            return ObjectGuid::Empty;
        }

        void SummonPortalKeeper(uint32 eventId)
        {
            uint8 riftPosition = eventId - EVENT_SUMMON_KEEPER_1;
            ObjectGuid const& riftGUID = _usedRiftPostions[riftPosition];
            Creature* rift = instance->GetCreature(riftGUID);
            if (!rift)
                return;

            int32 entry = 0;
            switch (_currentRift)
            {
                case 6:
                    entry = GetData(TYPE_CHRONO_LORD_DEJA) == DONE ? (instance->IsHeroic() ? NPC_INFINITE_CHRONO_LORD : -NPC_CHRONO_LORD_DEJA) : NPC_CHRONO_LORD_DEJA;
                    break;
                case 12:
                    entry = GetData(TYPE_TEMPORUS) == DONE ? (instance->IsHeroic() ? NPC_INFINITE_TIMEREAVER : -NPC_TEMPORUS) : NPC_TEMPORUS;
                    break;
                case 18:
                    entry = NPC_AEONUS;
                    break;
                default:
                    entry = RAND(NPC_RIFT_KEEPER_WARLOCK, NPC_RIFT_KEEPER_MAGE, NPC_RIFT_LORD, NPC_RIFT_LORD_2);
                    break;
            }

            Position pos = rift->GetNearPosition(10.0f, 2 * M_PI * rand_norm());

            if (TempSummon* summon = instance->SummonCreature(std::abs(entry), pos))
            {
                summon->SetTempSummonType(TEMPSUMMON_CORPSE_TIMED_DESPAWN);
                summon->SetTimer(3 * MINUTE * IN_MILLISECONDS);

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

        void Update(uint32 diff) override
        {
            if (_timerToNextBoss)
            {
                if (_timerToNextBoss <= diff)
                {
                    _timerToNextBoss = 0;
                }
                else
                {
                    _timerToNextBoss -= diff;
                }
            }

            Events.Update(diff);

            uint32 eventId = Events.ExecuteEvent();
            switch (eventId)
            {
                case EVENT_NEXT_PORTAL:
                {
                    if (instance->GetCreature(_medivhGUID))
                    {
                        uint8 position = MAX_PORTAL_LOCATIONS;

                        std::vector<uint8> possibleSpots;
                        for (uint8 i = 0; i < MAX_PORTAL_LOCATIONS; ++i)
                        {
                            if (!_usedRiftPostions[i])
                            {
                                possibleSpots.push_back(i);
                            }
                        }

                        if (!possibleSpots.empty())
                        {
                            position = Acore::Containers::SelectRandomContainerElement(possibleSpots);
                        }

                        if (position < MAX_PORTAL_LOCATIONS)
                        {
                            ++_currentRift;
                            DoUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
                            Events.ScheduleEvent(EVENT_SUMMON_KEEPER_1 + position, 6000);
                            Events.SetPhase(0);

                            if (Creature* rift = instance->SummonCreature(NPC_TIME_RIFT, PortalLocation[position]))
                            {
                                _usedRiftPostions[position] = rift->GetGUID();

                                for (uint8 i = 0; i < MAX_PORTAL_LOCATIONS; ++i)
                                {
                                    if (!_usedRiftPostions[i])
                                    {
                                        Events.RescheduleEvent(EVENT_NEXT_PORTAL, (_currentRift >= 13 ? 120 : 90) * IN_MILLISECONDS);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    break;
                }
                case EVENT_SUMMON_KEEPER_1:
                case EVENT_SUMMON_KEEPER_2:
                case EVENT_SUMMON_KEEPER_3:
                case EVENT_SUMMON_KEEPER_4:
                    SummonPortalKeeper(eventId);
                    break;
                case EVENT_WIPE_1:
                    if (Creature* medivh = instance->GetCreature(_medivhGUID))
                    {
                        medivh->RemoveAllAuras();
                    }
                    Events.ScheduleEvent(EVENT_WIPE_2, 500ms);
                    break;
                case EVENT_WIPE_2:
                    if (Creature* medivh = instance->GetCreature(_medivhGUID))
                    {
                        medivh->KillSelf(false);

                        GuidSet encounterNPCSCopy = encounterNPCs;
                        for (ObjectGuid const& guid : encounterNPCSCopy)
                        {
                            switch (guid.GetEntry())
                            {
                                case NPC_TIME_RIFT:
                                case NPC_DP_EMITTER_STALKER:
                                case NPC_DP_CRYSTAL_STALKER:
                                case NPC_DP_BEAM_STALKER:
                                    if (Creature* creature = instance->GetCreature(guid))
                                    {
                                        creature->DespawnOrUnsummon();
                                    }
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                    Events.ScheduleEvent(EVENT_WIPE_3, 2s);
                    break;
                case EVENT_WIPE_3:
                {
                    GuidSet encounterNPCSCopy = encounterNPCs;
                    for (ObjectGuid const& guid : encounterNPCSCopy)
                    {
                        if (Creature* creature = instance->GetCreature(guid))
                        {
                            creature->CastSpell(creature, SPELL_TELEPORT_VISUAL, true);
                            creature->DespawnOrUnsummon(1200ms, 0s);
                        }
                    }
                    break;
                }
                default:
                    break;
            }
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> encounters[0];
            data >> encounters[1];
            data >> encounters[2];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << encounters[0] << ' '
                << encounters[1] << ' '
                << encounters[2] << ' ';
        }

    protected:
        EventMap Events;
        std::array<ObjectGuid, MAX_PORTAL_LOCATIONS> _usedRiftPostions;
        uint32 _timerToNextBoss;
    };
};

void AddSC_instance_the_black_morass()
{
    new instance_the_black_morass();
}
