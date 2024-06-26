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

#include "Creature.h"
#include "GameObject.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Map.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "karazhan.h"

const Position OptionalSpawn[] =
{
    { -10960.981445f, -1940.138428f, 46.178097f, 4.12f }, // Hyakiss the Lurker
    { -10945.769531f, -2040.153320f, 49.474438f, 0.077f }, // Shadikith the Glider
    { -10899.903320f, -2085.573730f, 49.474449f, 1.38f }  // Rokad the Ravager
};

ObjectData const creatureData[] =
{
    { NPC_ATTUMEN_THE_HUNTSMAN, DATA_ATTUMEN   },
    { NPC_SHADE_OF_ARAN,        DATA_ARAN      },
    { NPC_MIDNIGHT,             DATA_MIDNIGHT  },
    { NPC_DOROTHEE,             DATA_DOROTHEE  },
    { NPC_TITO,                 DATA_TITO      },
    { NPC_ROAR,                 DATA_ROAR      },
    { NPC_STRAWMAN,             DATA_STRAWMAN  },
    { NPC_TINHEAD,              DATA_TINHEAD   },
    { NPC_ROMULO,               DATA_ROMULO    },
    { NPC_JULIANNE,             DATA_JULIANNE  },
    { NPC_NIGHTBANE,            DATA_NIGHTBANE },
    { NPC_TERESTIAN_ILLHOOF,    DATA_TERESTIAN },
    { 0,                        0              }
};

ObjectData const gameObjectData[] =
{
    { GO_SIDE_ENTRANCE_DOOR, DATA_GO_SIDE_ENTRANCE_DOOR },
    { 0,                     0                          }
};

DoorData const doorData[] =
{
    { GO_MASTERS_TERRACE_DOOR,  DATA_NIGHTBANE, DOOR_TYPE_ROOM  },
    { GO_MASTERS_TERRACE_DOOR2, DATA_NIGHTBANE, DOOR_TYPE_ROOM  },
    { GO_NETHERSPACE_DOOR,      DATA_MALCHEZAAR, DOOR_TYPE_ROOM },
    { 0,                        0,              DOOR_TYPE_ROOM  }
};

class instance_karazhan : public InstanceMapScript
{
public:
    instance_karazhan() : InstanceMapScript("instance_karazhan", 532) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_karazhan_InstanceMapScript(map);
    }

    struct instance_karazhan_InstanceMapScript : public InstanceScript
    {
        instance_karazhan_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadObjectData(creatureData, gameObjectData);
            LoadDoorData(doorData);

            // 1 - OZ, 2 - HOOD, 3 - RAJ, this never gets altered.
            OperaEvent = urand(EVENT_OZ, EVENT_RAJ);
            OzDeathCount = 0;
            OptionalBossCount = 0;

            _chessTeam = TEAM_NEUTRAL;
            _chessGamePhase = CHESS_PHASE_NOT_STARTED;
            _chessEvent = NOT_STARTED;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_KILREK:
                    m_uiKilrekGUID = creature->GetGUID();
                    break;
                case NPC_TERESTIAN_ILLHOOF:
                    m_uiTerestianGUID = creature->GetGUID();
                    break;
                case NPC_MOROES:
                    m_uiMoroesGUID = creature->GetGUID();
                    break;
                case NPC_NIGHTBANE:
                    m_uiNightBaneGUID = creature->GetGUID();
                    break;
                case NPC_RELAY:
                    m_uiRelayGUID = creature->GetGUID();
                    break;
                case NPC_BARNES:
                    _barnesGUID = creature->GetGUID();
                    if (GetBossState(DATA_OPERA_PERFORMANCE) != DONE && !creature->IsAlive())
                    {
                        creature->Respawn(true);
                    }
                    break;
                case NPC_PAWN_H:
                case NPC_KNIGHT_H:
                case NPC_QUEEN_H:
                case NPC_BISHOP_H:
                case NPC_ROOK_H:
                case NPC_KING_H:
                case NPC_PAWN_A:
                case NPC_KNIGHT_A:
                case NPC_QUEEN_A:
                case NPC_BISHOP_A:
                case NPC_ROOK_A:
                case NPC_KING_A:
                    _chessPiecesGUID.insert(creature->GetGUID());
                    creature->SetHealth(creature->GetMaxHealth());
                    break;
                case NPC_CHESS_EVENT_MEDIVH_CHEAT_FIRES:
                    _medivhCheatFiresGUID.insert(creature->GetGUID());
                    break;
                case NPC_ECHO_OF_MEDIVH:
                    _echoOfMedivhGUID = creature->GetGUID();
                    break;
                case NPC_FIENDISH_IMP:
                    if (Creature* terestrian = GetCreature(DATA_TERESTIAN))
                    {
                        if (terestrian->AI())
                        {
                            terestrian->AI()->JustSummoned(creature);
                            creature->SetInCombatWithZone();
                        }
                    }
                    break;
                default:
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnUnitDeath(Unit* unit) override
        {
            Creature* creature = unit->ToCreature();
            if (!creature)
                return;

            switch (creature->GetEntry())
            {
                case NPC_COLDMIST_WIDOW:
                case NPC_COLDMIST_STALKER:
                case NPC_SHADOWBAT:
                case NPC_VAMPIRIC_SHADOWBAT:
                case NPC_GREATER_SHADOWBAT:
                case NPC_PHASE_HOUND:
                case NPC_DREADBEAST:
                case NPC_SHADOWBEAST:
                    if (GetBossState(DATA_OPTIONAL_BOSS) == TO_BE_DECIDED)
                    {
                        ++OptionalBossCount;
                        if (OptionalBossCount == OPTIONAL_BOSS_REQUIRED_DEATH_COUNT)
                        {
                            switch (urand(NPC_HYAKISS_THE_LURKER, NPC_ROKAD_THE_RAVAGER))
                            {
                                case NPC_HYAKISS_THE_LURKER:
                                    instance->SummonCreature(NPC_HYAKISS_THE_LURKER, OptionalSpawn[0]);
                                    break;
                                case NPC_SHADIKITH_THE_GLIDER:
                                    instance->SummonCreature(NPC_SHADIKITH_THE_GLIDER, OptionalSpawn[1]);
                                    break;
                                case NPC_ROKAD_THE_RAVAGER:
                                    instance->SummonCreature(NPC_ROKAD_THE_RAVAGER, OptionalSpawn[2]);
                                    break;
                            }
                        }
                    }
                    break;
                case NPC_HYAKISS_THE_LURKER:
                case NPC_SHADIKITH_THE_GLIDER:
                case NPC_ROKAD_THE_RAVAGER:
                    SetBossState(DATA_OPTIONAL_BOSS, DONE);
                    instance->ToInstanceMap()->PermBindAllPlayers();
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_OPERA_OZ_DEATHCOUNT:
                    if (data == SPECIAL)
                        ++OzDeathCount;
                    else if (data == IN_PROGRESS)
                        OzDeathCount = 0;
                    break;
                case DATA_SPAWN_OPERA_DECORATIONS:
                {
                    for (ObjectGuid const& guid : _operaDecorations[data - 1])
                    {
                        DoRespawnGameObject(guid, DAY);
                    }

                    break;
                }
                case DATA_CHESS_EVENT:
                {
                    _chessEvent = data;

                    switch (data)
                    {
                        case IN_PROGRESS:
                        case SPECIAL:
                        {
                            DoCastSpellOnPlayers(SPELL_GAME_IN_SESSION);
                            for (ObjectGuid const& chessPieceGUID : _chessPiecesGUID)
                            {
                                if (Creature* piece = instance->GetCreature(chessPieceGUID))
                                {
                                    if (_chessTeam == TEAM_ALLIANCE)
                                    {
                                        if (piece->GetFaction() == CHESS_FACTION_ALLIANCE)
                                        {
                                            piece->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                                        }
                                    }
                                    else if (_chessTeam == TEAM_HORDE)
                                    {
                                        if (piece->GetFaction() == CHESS_FACTION_HORDE)
                                        {
                                            piece->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                                        }
                                    }
                                    else
                                    {
                                        piece->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                                    }
                                }
                            }
                            break;
                        case DONE:
                            HandleGameObject(m_uiGamesmansExitDoor, true);
                            instance->ToInstanceMap()->PermBindAllPlayers();
                            break;
                        }
                        default:
                            DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                            break;
                    }
                    break;
                }
                case CHESS_EVENT_TEAM:
                    _chessTeam = data;
                    break;
                case DATA_CHESS_REINIT_PIECES:
                    for (ObjectGuid const& chessPieceGUID : _chessPiecesGUID)
                    {
                        if (Creature* piece = instance->GetCreature(chessPieceGUID))
                        {
                            piece->RemoveAllAuras();
                            piece->setDeathState(DeathState::JustRespawned);
                            piece->SetHealth(piece->GetMaxHealth());
                            float x, y, z, o;
                            piece->GetHomePosition(x, y, z, o);
                            piece->NearTeleportTo(x, y, z, o);
                            piece->AI()->DoAction(ACTION_CHESS_PIECE_RESET_ORIENTATION);
                            piece->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            piece->AI()->Reset();
                        }
                    }

                    for (ObjectGuid const& medivhCheatFireGUID : _medivhCheatFiresGUID)
                    {
                        if (Creature* fire = instance->GetCreature(medivhCheatFireGUID))
                        {
                            fire->DespawnOrUnsummon();
                        }
                    }

                    _medivhCheatFiresGUID.clear();
                    break;
                case DATA_CHESS_GAME_PHASE:
                    _chessGamePhase = data;
                    break;
                default:
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_OPERA_PERFORMANCE:
                    if (state == DONE)
                    {
                        HandleGameObject(m_uiStageDoorLeftGUID, true);
                        HandleGameObject(m_uiStageDoorRightGUID, true);
                        instance->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, 16812, nullptr);
                    }
                    else if (state == FAIL)
                    {
                        HandleGameObject(m_uiStageDoorLeftGUID, true);
                        HandleGameObject(m_uiStageDoorRightGUID, false);
                        HandleGameObject(m_uiCurtainGUID, false);
                        DoRespawnCreature(_barnesGUID, true);
                    }
                    break;
                default:
                    break;
            }

            return true;
        }

        void SetGuidData(uint32 type, ObjectGuid data) override
        {
            if (type == DATA_IMAGE_OF_MEDIVH)
                ImageGUID = data;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_STAGE_CURTAIN:
                    m_uiCurtainGUID = go->GetGUID();
                    break;
                case GO_STAGE_DOOR_LEFT:
                    m_uiStageDoorLeftGUID = go->GetGUID();
                    if (GetBossState(DATA_OPERA_PERFORMANCE) == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_STAGE_DOOR_RIGHT:
                    m_uiStageDoorRightGUID = go->GetGUID();
                    if (GetBossState(DATA_OPERA_PERFORMANCE) == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_PRIVATE_LIBRARY_DOOR:
                    m_uiLibraryDoor = go->GetGUID();
                    break;
                case GO_MASSIVE_DOOR:
                    m_uiMassiveDoor = go->GetGUID();
                    if (GetBossState(DATA_ARAN) != IN_PROGRESS)
                        go->SetGameObjectFlag(GO_FLAG_LOCKED);
                    else
                        go->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                    break;
                case GO_GAMESMAN_HALL_DOOR:
                    m_uiGamesmansDoor = go->GetGUID();
                    break;
                case GO_GAMESMAN_HALL_EXIT_DOOR:
                    m_uiGamesmansExitDoor = go->GetGUID();
                    break;
                case GO_SIDE_ENTRANCE_DOOR:
                    if (GetBossState(DATA_OPERA_PERFORMANCE) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                    else
                        go->SetGameObjectFlag(GO_FLAG_LOCKED);
                    break;
                case GO_DUST_COVERED_CHEST:
                    DustCoveredChest = go->GetGUID();
                    break;
                case GO_OZ_BACKDROP:
                case GO_OZ_HAY:
                    _operaDecorations[EVENT_OZ - 1].push_back(go->GetGUID());
                    break;
                case GO_HOOD_BACKDROP:
                case GO_HOOD_TREE:
                case GO_HOOD_HOUSE:
                    _operaDecorations[EVENT_HOOD - 1].push_back(go->GetGUID());
                    break;
                case GO_RAJ_BACKDROP:
                case GO_RAJ_MOON:
                case GO_RAJ_BALCONY:
                    _operaDecorations[EVENT_RAJ - 1].push_back(go->GetGUID());
                    break;
                default:
                    break;
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_OPERA_PERFORMANCE:
                    return OperaEvent;
                case DATA_OPERA_OZ_DEATHCOUNT:
                    return OzDeathCount;
                case CHESS_EVENT_TEAM:
                    return _chessTeam;
                case DATA_CHESS_GAME_PHASE:
                    return _chessGamePhase;
                case DATA_CHESS_EVENT:
                    return _chessEvent;
            }

            return 0;
        }

        void DoAction(int32 actionId) override
        {
            if (actionId == ACTION_SCHEDULE_RAJ_CHECK)
            {
                scheduler.Schedule(10s, [this](TaskContext)
                {
                    Creature* julliane = GetCreature(DATA_JULIANNE);
                    Creature* romulo = GetCreature(DATA_ROMULO);

                    if (julliane && romulo)
                    {
                        if (julliane->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE)
                            && romulo->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                        {
                            julliane->KillSelf();
                            julliane->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            romulo->KillSelf();
                            romulo->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        }
                        else
                        {
                            if (romulo->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                            {
                                julliane->AI()->DoAction(ACTION_RESS_ROMULO);
                            }

                            if (julliane->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                            {
                                julliane->AI()->DoAction(ACTION_DO_RESURRECT);
                            }
                        }
                    }
                });
            }
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                case DATA_KILREK:
                    return m_uiKilrekGUID;
                case DATA_TERESTIAN:
                    return m_uiTerestianGUID;
                case DATA_MOROES:
                    return m_uiMoroesGUID;
                case DATA_GO_STAGEDOORLEFT:
                    return m_uiStageDoorLeftGUID;
                case DATA_GO_STAGEDOORRIGHT:
                    return m_uiStageDoorRightGUID;
                case DATA_GO_CURTAINS:
                    return m_uiCurtainGUID;
                case DATA_GO_LIBRARY_DOOR:
                    return m_uiLibraryDoor;
                case DATA_GO_MASSIVE_DOOR:
                    return m_uiMassiveDoor;
                case DATA_GO_GAME_DOOR:
                    return m_uiGamesmansDoor;
                case DATA_GO_GAME_EXIT_DOOR:
                    return m_uiGamesmansExitDoor;
                case DATA_IMAGE_OF_MEDIVH:
                    return ImageGUID;
                case DATA_NIGHTBANE:
                    return m_uiNightBaneGUID;
                case DATA_ECHO_OF_MEDIVH:
                    return _echoOfMedivhGUID;
                case DATA_DUST_COVERED_CHEST:
                    return DustCoveredChest;
            }

            return ObjectGuid::Empty;
        }

    private:
        uint32 OperaEvent;
        uint32 OzDeathCount;
        uint32 OptionalBossCount;
        uint32 _chessTeam;
        uint32 _chessGamePhase;
        uint32 _chessEvent;

        ObjectGuid m_uiCurtainGUID;
        ObjectGuid m_uiStageDoorLeftGUID;
        ObjectGuid m_uiStageDoorRightGUID;
        ObjectGuid m_uiKilrekGUID;
        ObjectGuid m_uiTerestianGUID;
        ObjectGuid m_uiMoroesGUID;
        ObjectGuid m_uiNightBaneGUID;
        ObjectGuid m_uiLibraryDoor;                                 // Door at Shade of Aran
        ObjectGuid m_uiMassiveDoor;                                 // Door at Netherspite
        ObjectGuid m_uiGamesmansDoor;                               // Door before Chess
        ObjectGuid m_uiGamesmansExitDoor;                           // Door after Chess
        ObjectGuid ImageGUID;
        ObjectGuid DustCoveredChest;
        ObjectGuid m_uiRelayGUID;
        ObjectGuid _barnesGUID;
        ObjectGuid _echoOfMedivhGUID;

        GuidVector _operaDecorations[EVENT_RAJ];
        GuidSet _chessPiecesGUID;
        GuidSet _medivhCheatFiresGUID;
    };
};

class spell_karazhan_brittle_bones_aura : public AuraScript
{
    PrepareAuraScript(spell_karazhan_brittle_bones_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RATTLED });
    }

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = 5000;
    }

    void Update(AuraEffect const*  /*effect*/)
    {
        PreventDefaultAction();
        if (roll_chance_i(35))
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_RATTLED, true);
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_karazhan_brittle_bones_aura::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_karazhan_brittle_bones_aura::Update, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_karazhan_overload_aura : public AuraScript
{
    PrepareAuraScript(spell_karazhan_overload_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_OVERLOAD });
    }

    void PeriodicTick(AuraEffect const* auraEffect)
    {
        PreventDefaultAction();
        //Should stop at 3200 damage, maybe check needed(?)
        GetUnitOwner()->CastCustomSpell(SPELL_OVERLOAD, SPELLVALUE_BASE_POINT0, int32(auraEffect->GetAmount() * pow(2.0, auraEffect->GetTickNumber())), GetUnitOwner(), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_karazhan_overload_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_karazhan_blink : public SpellScript
{
    PrepareSpellScript(spell_karazhan_blink);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLINK });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->GetThreatMgr().ResetAllThreat();
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_BLINK, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_karazhan_blink::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_instance_karazhan()
{
    new instance_karazhan();
    RegisterSpellScript(spell_karazhan_brittle_bones_aura);
    RegisterSpellScript(spell_karazhan_overload_aura);
    RegisterSpellScript(spell_karazhan_blink);
}

