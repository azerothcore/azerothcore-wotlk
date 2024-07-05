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
#include "ObjectMgr.h"
#include "TemporarySummon.h"
#include "molten_core.h"

MinionData const minionData[] =
{
    { NPC_FIRESWORN,                DATA_GARR },
    { NPC_FLAMEWALKER,              DATA_GEHENNAS },
    { NPC_FLAMEWALKER_PROTECTOR,    DATA_LUCIFRON },
    { NPC_FLAMEWALKER_PRIEST,       DATA_SULFURON },
    { NPC_FLAMEWALKER_HEALER,       DATA_MAJORDOMO_EXECUTUS },
    { NPC_FLAMEWALKER_ELITE,        DATA_MAJORDOMO_EXECUTUS },
    { 0, 0 } // END
};

struct MCBossObject
{
    uint32 bossId;
    uint32 runeId;
    uint32 circleId;
};

constexpr uint8 MAX_MC_LINKED_BOSS_OBJ = 7;
MCBossObject const linkedBossObjData[MAX_MC_LINKED_BOSS_OBJ]=
{
    { DATA_MAGMADAR,    GO_RUNE_KRESS,      GO_CIRCLE_MAGMADAR  },
    { DATA_GEHENNAS,    GO_RUNE_MOHN,       GO_CIRCLE_GEHENNAS  },
    { DATA_GARR,        GO_RUNE_BLAZ,       GO_CIRCLE_GARR      },
    { DATA_SHAZZRAH,    GO_RUNE_MAZJ,       GO_CIRCLE_SHAZZRAH  },
    { DATA_GEDDON,      GO_RUNE_ZETH,       GO_CIRCLE_GEDDON    },
    { DATA_GOLEMAGG,    GO_RUNE_THERI,      GO_CIRCLE_GOLEMAGG  },
    { DATA_SULFURON,    GO_RUNE_KORO,       GO_CIRCLE_SULFURON  },
};

constexpr uint8 SAY_SPAWN = 1;

class instance_molten_core : public InstanceMapScript
{
public:
    instance_molten_core() : InstanceMapScript(MCScriptName, 409) {}

    struct instance_molten_core_InstanceMapScript : public InstanceScript
    {
        instance_molten_core_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadMinionData(minionData);
        }

        void OnPlayerEnter(Player* /*player*/) override
        {
            if (CheckMajordomoExecutus())
            {
                SummonMajordomoExecutus();
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_GOLEMAGG_THE_INCINERATOR:
                {
                    _golemaggGUID = creature->GetGUID();
                    break;
                }
                case NPC_CORE_RAGER:
                {
                    _golemaggMinionsGUIDS.insert(creature->GetGUID());
                    break;
                }
                case NPC_MAJORDOMO_EXECUTUS:
                {
                    _majordomoExecutusGUID = creature->GetGUID();
                    break;
                }
                case NPC_GARR:
                {
                    _garrGUID = creature->GetGUID();
                    break;
                }
                case NPC_RAGNAROS:
                {
                    _ragnarosGUID = creature->GetGUID();
                    break;
                }
                case NPC_FIRESWORN:
                case NPC_FLAMEWALKER:
                case NPC_FLAMEWALKER_PROTECTOR:
                case NPC_FLAMEWALKER_PRIEST:
                case NPC_FLAMEWALKER_HEALER:
                case NPC_FLAMEWALKER_ELITE:
                {
                    AddMinion(creature);
                    break;
                }
            }
        }

        void OnCreatureRemove(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_FIRESWORN:
                {
                    RemoveMinion(creature);
                    break;
                }
                case NPC_FLAMEWALKER:
                case NPC_FLAMEWALKER_PROTECTOR:
                case NPC_FLAMEWALKER_PRIEST:
                case NPC_FLAMEWALKER_HEALER:
                case NPC_FLAMEWALKER_ELITE:
                {
                    RemoveMinion(creature);
                    break;
                }
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_CACHE_OF_THE_FIRELORD:
                {
                    _cacheOfTheFirelordGUID = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_GEDDON:
                case GO_CIRCLE_GARR:
                case GO_CIRCLE_GEHENNAS:
                case GO_CIRCLE_GOLEMAGG:
                case GO_CIRCLE_MAGMADAR:
                case GO_CIRCLE_SHAZZRAH:
                case GO_CIRCLE_SULFURON:
                {
                    for (uint8 i = 0; i < MAX_MC_LINKED_BOSS_OBJ; ++i)
                    {
                        if (linkedBossObjData[i].circleId != go->GetEntry())
                        {
                            continue;
                        }

                        if (GetBossState(linkedBossObjData[i].bossId) == DONE)
                        {
                            go->DespawnOrUnsummon(0ms, Seconds(WEEK));
                        }
                        else
                        {
                            _circlesGUIDs[linkedBossObjData[i].bossId] = go->GetGUID();
                        }
                    }

                    break;
                }
                case GO_RUNE_KRESS:
                case GO_RUNE_MOHN:
                case GO_RUNE_BLAZ:
                case GO_RUNE_MAZJ:
                case GO_RUNE_ZETH:
                case GO_RUNE_THERI:
                case GO_RUNE_KORO:
                {
                    for (uint8 i = 0; i < MAX_MC_LINKED_BOSS_OBJ; ++i)
                    {
                        if (linkedBossObjData[i].runeId != go->GetEntry())
                        {
                            continue;
                        }

                        if (GetBossState(linkedBossObjData[i].bossId) == DONE)
                        {
                            go->UseDoorOrButton(WEEK * IN_MILLISECONDS);
                        }
                        else
                        {
                            _runesGUIDs[linkedBossObjData[i].bossId] = go->GetGUID();
                        }
                    }
                    break;
                }
                case GO_LAVA_STEAM:
                {
                    _lavaSteamGUID = go->GetGUID();
                    break;
                }
                case GO_LAVA_SPLASH:
                {
                    _lavaSplashGUID = go->GetGUID();
                    break;
                }
                case GO_LAVA_BURST:
                {
                    if (Creature* ragnaros = instance->GetCreature(_ragnarosGUID))
                    {
                        ragnaros->AI()->SetGUID(go->GetGUID(), GO_LAVA_BURST);
                    }
                    break;
                }
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_GOLEMAGG:
                    return _golemaggGUID;
                case DATA_MAJORDOMO_EXECUTUS:
                    return _majordomoExecutusGUID;
                case DATA_GARR:
                    return _garrGUID;
                case DATA_LAVA_STEAM:
                    return _lavaSteamGUID;
                case DATA_LAVA_SPLASH:
                    return _lavaSplashGUID;
                case DATA_RAGNAROS:
                    return _ragnarosGUID;
            }

            return ObjectGuid::Empty;
        }

        bool SetBossState(uint32 bossId, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(bossId, state))
            {
                return false;
            }

            if (bossId == DATA_MAJORDOMO_EXECUTUS && state == DONE)
            {
                if (GameObject* cache = instance->GetGameObject(_cacheOfTheFirelordGUID))
                {
                    cache->SetRespawnTime(7 * DAY);
                    cache->SetLootRecipient(instance);
                }
            }
            else if (bossId == DATA_GOLEMAGG)
            {
                switch (state)
                {
                    case NOT_STARTED:
                    case FAIL:
                    {
                        if (!_golemaggMinionsGUIDS.empty())
                        {
                            for (ObjectGuid const& minionGuid : _golemaggMinionsGUIDS)
                            {
                                Creature* minion = instance->GetCreature(minionGuid);
                                if (minion && minion->isDead())
                                {
                                    minion->Respawn();
                                }
                            }
                        }
                        break;
                    }
                    case IN_PROGRESS:
                    {
                        if (!_golemaggMinionsGUIDS.empty())
                        {
                            for (ObjectGuid const& minionGuid : _golemaggMinionsGUIDS)
                            {
                                if (Creature* minion = instance->GetCreature(minionGuid))
                                {
                                    minion->AI()->DoZoneInCombat(nullptr, 150.0f);
                                }
                            }
                        }
                        break;
                    }
                    case DONE:
                    {
                        if (!_golemaggMinionsGUIDS.empty())
                        {
                            for (ObjectGuid const& minionGuid : _golemaggMinionsGUIDS)
                            {
                                if (Creature* minion = instance->GetCreature(minionGuid))
                                {
                                    minion->CastSpell(minion, SPELL_CORE_RAGER_QUIET_SUICIDE, true);
                                }
                            }
                            _golemaggMinionsGUIDS.clear();
                        }
                        break;
                    }
                    default:
                        break;
                }
            }
            // Perform needed checks for Majordomu
            if (bossId < DATA_MAJORDOMO_EXECUTUS && state == DONE)
            {
                if (GameObject* circle = instance->GetGameObject(_circlesGUIDs[bossId]))
                {
                    circle->DespawnOrUnsummon(0ms, Seconds(WEEK));
                    _circlesGUIDs[bossId].Clear();
                }

                if (GameObject* rune = instance->GetGameObject(_runesGUIDs[bossId]))
                {
                    rune->UseDoorOrButton(WEEK * IN_MILLISECONDS);
                    _runesGUIDs[bossId].Clear();
                }

                if (CheckMajordomoExecutus())
                {
                    SummonMajordomoExecutus();
                }
            }

            return true;
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_RESET_GOLEMAGG_ENCOUNTER)
            {
                if (Creature* golemagg = instance->GetCreature(_golemaggGUID))
                {
                    golemagg->AI()->EnterEvadeMode();
                }

                if (!_golemaggMinionsGUIDS.empty())
                {
                    for (ObjectGuid const& minionGuid : _golemaggMinionsGUIDS)
                    {
                        if (Creature* minion = instance->GetCreature(minionGuid))
                        {
                            minion->AI()->EnterEvadeMode();
                        }
                    }
                }
            }
        }

        void SummonMajordomoExecutus()
        {
            if (instance->GetCreature(_majordomoExecutusGUID))
            {
                return;
            }

            if (GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE)
            {
                if (Creature* creature = instance->SummonCreature(NPC_MAJORDOMO_EXECUTUS, MajordomoSummonPos))
                {
                    creature->AI()->Talk(SAY_SPAWN);
                }
            }
            else
            {
                instance->SummonCreature(NPC_MAJORDOMO_EXECUTUS, MajordomoRagnaros);
            }
        }

        bool CheckMajordomoExecutus() const
        {
            if (GetBossState(DATA_RAGNAROS) == DONE)
            {
                return false;
            }

            for (uint8 i = 0; i < DATA_MAJORDOMO_EXECUTUS; ++i)
            {
                if (i == DATA_LUCIFRON)
                {
                    continue;
                }

                if (GetBossState(i) != DONE)
                {
                    return false;
                }
            }

            // Prevent spawning if Ragnaros is present
            if (instance->GetCreature(_ragnarosGUID))
            {
                return false;
            }

            return true;
        }

    private:
        std::unordered_map<uint32/*bossid*/, ObjectGuid/*circleGUID*/> _circlesGUIDs;
        std::unordered_map<uint32/*bossid*/, ObjectGuid/*runeGUID*/> _runesGUIDs;

        // Golemagg encounter related
        ObjectGuid _golemaggGUID;
        GuidSet _golemaggMinionsGUIDS;

        // Ragnaros encounter related
        ObjectGuid _ragnarosGUID;
        ObjectGuid _lavaSteamGUID;
        ObjectGuid _lavaSplashGUID;

        ObjectGuid _majordomoExecutusGUID;
        ObjectGuid _cacheOfTheFirelordGUID;
        ObjectGuid _garrGUID;
        ObjectGuid _magmadarGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_molten_core_InstanceMapScript(map);
    }
};

void AddSC_instance_molten_core()
{
    new instance_molten_core();
}
