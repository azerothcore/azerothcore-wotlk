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

#include "AreaTriggerScript.h"
#include "Cell.h"
#include "CellImpl.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "GridNotifiers.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "blackrock_spire.h"

uint32 const DragonspireMobs[3] = { NPC_BLACKHAND_DREADWEAVER, NPC_BLACKHAND_SUMMONER, NPC_BLACKHAND_VETERAN };

enum EventIds
{
    EVENT_DRAGONSPIRE_ROOM_STORE           = 1,
    EVENT_DRAGONSPIRE_ROOM_CHECK           = 2,

    EVENT_SOLAKAR_WAVE                     = 3
};

enum Timers
{
    TIMER_SOLAKAR_WAVE = 30000
};

enum SolakarWaves
{
    MAX_WAVE_COUNT = 5
};

Position SolakarPosLeft  = Position(78.0f, -280.0f, 93.0f, 3.0f * M_PI / 2.0);
Position SolakarPosRight = Position(84.0f, -280.0f, 93.0f, 3.0f * M_PI / 2.0);
Position SolakarPosBoss  = Position(80.0f, -280.0f, 93.0f, 3.0f * M_PI / 2.0);

enum Texts
{
    SAY_NEFARIUS_REND_WIPE      = 11,
    SAY_SOLAKAR_FIRST_HATCHER   = 0,
    SAY_SCARSHIELD_INF_WHISPER  = 0
};

MinionData const minionData[] =
{
    { NPC_CHROMATIC_ELITE_GUARD, DATA_GENERAL_DRAKKISATH }
};

DoorData const doorData[] =
{
    { GO_GYTH_EXIT_DOOR,    DATA_WARCHIEF_REND_BLACKHAND,  DOOR_TYPE_PASSAGE },
    { GO_DRAKKISATH_DOOR_1, DATA_GENERAL_DRAKKISATH,       DOOR_TYPE_PASSAGE },
    { GO_DRAKKISATH_DOOR_2, DATA_GENERAL_DRAKKISATH,       DOOR_TYPE_PASSAGE },
    { 0,                 0,          DOOR_TYPE_ROOM,                         } // END
};

class instance_blackrock_spire : public InstanceMapScript
{
public:
    instance_blackrock_spire() : InstanceMapScript(BRSScriptName, 229) { }

    struct instance_blackrock_spireMapScript : public InstanceScript
    {
        uint32 CurrentSolakarWave = 0;
        uint32 SolakarState       = NOT_STARTED; // there should be a global instance encounter state, where is it?
        GuidVector SolakarSummons;
        uint32 VaelastraszState   = NOT_STARTED;

        instance_blackrock_spireMapScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadMinionData(minionData);
            LoadDoorData(doorData);
            CurrentSolakarWave = 0;
            SolakarState       = NOT_STARTED;
            SolakarSummons.clear();
            VaelastraszState   = NOT_STARTED;
        }

        void CreatureLooted(Creature* creature, LootType loot) override
        {
            switch (creature->GetEntry())
            {
                case NPC_THE_BEAST:
                    if (loot == LOOT_SKINNING)
                    {
                        creature->CastSpell(creature, SPELL_FINKLE_IS_EINHORN, true);
                    }
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_UROK_MAGUS:
                    [[fallthrough]];
                case NPC_UROK_ENFORCER:
                    UrokMobs.push_back(creature->GetGUID());
                    break;
                case NPC_HIGHLORD_OMOKK:
                    HighlordOmokk = creature->GetGUID();
                    break;
                case NPC_SHADOW_HUNTER_VOSHGAJIN:
                    ShadowHunterVoshgajin = creature->GetGUID();
                    break;
                case NPC_WARMASTER_VOONE:
                    WarMasterVoone = creature->GetGUID();
                    break;
                case NPC_MOTHER_SMOLDERWEB:
                    MotherSmolderweb = creature->GetGUID();
                    break;
                case NPC_UROK_DOOMHOWL:
                    UrokDoomhowl = creature->GetGUID();
                    break;
                case NPC_QUARTERMASTER_ZIGRIS:
                    QuartermasterZigris = creature->GetGUID();
                    break;
                case NPC_GIZRUL_THE_SLAVENER:
                    GizrultheSlavener = creature->GetGUID();
                    break;
                case NPC_HALYCON:
                    Halycon = creature->GetGUID();
                    break;
                case NPC_OVERLORD_WYRMTHALAK:
                    OverlordWyrmthalak = creature->GetGUID();
                    break;
                case NPC_PYROGAURD_EMBERSEER:
                    PyroguardEmberseer = creature->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        creature->DisappearAndDie();
                    break;
                case NPC_WARCHIEF_REND_BLACKHAND:
                    if (GetBossState(DATA_GYTH) != IN_PROGRESS)
                    {
                        WarchiefRendBlackhand = creature->GetGUID();
                    }

                    if (GetBossState(DATA_GYTH) == DONE)
                        creature->DisappearAndDie();
                    break;
                case NPC_GYTH:
                    Gyth = creature->GetGUID();
                    break;
                case NPC_THE_BEAST:
                    TheBeast = creature->GetGUID();
                    break;
                case NPC_GENERAL_DRAKKISATH:
                    GeneralDrakkisath = creature->GetGUID();
                    break;
                case NPC_LORD_VICTOR_NEFARIUS:
                    LordVictorNefarius = creature->GetGUID();
                    if (GetBossState(DATA_GYTH) == DONE)
                        creature->DisappearAndDie();
                    break;
                case NPC_FINKLE_EINHORN:
                    creature->AI()->Talk(SAY_FINKLE_GANG);
                    break;
                case NPC_CHROMATIC_ELITE_GUARD:
                    AddMinion(creature);
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_EMBERSEER_IN:
                    go_emberseerin = go->GetGUID();
                    HandleGameObject(ObjectGuid::Empty, GetBossState(DATA_DRAGONSPIRE_ROOM) == DONE, go);
                    break;
                case GO_DOORS:
                    go_doors = go->GetGUID();
                    if (GetBossState(DATA_DRAGONSPIRE_ROOM) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_EMBERSEER_OUT:
                    go_emberseerout = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_HALL_RUNE_1:
                    go_roomrunes[0] = go->GetGUID();
                    if (GetBossState(DATA_HALL_RUNE_1) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_HALL_RUNE_2:
                    go_roomrunes[1] = go->GetGUID();
                    if (GetBossState(DATA_HALL_RUNE_2) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_HALL_RUNE_3:
                    go_roomrunes[2] = go->GetGUID();
                    if (GetBossState(DATA_HALL_RUNE_3) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_HALL_RUNE_4:
                    go_roomrunes[3] = go->GetGUID();
                    if (GetBossState(DATA_HALL_RUNE_4) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_HALL_RUNE_5:
                    go_roomrunes[4] = go->GetGUID();
                    if (GetBossState(DATA_HALL_RUNE_5) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_HALL_RUNE_6:
                    go_roomrunes[5] = go->GetGUID();
                    if (GetBossState(DATA_HALL_RUNE_6) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_HALL_RUNE_7:
                    go_roomrunes[6] = go->GetGUID();
                    if (GetBossState(DATA_HALL_RUNE_7) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_EMBERSEER_RUNE_1:
                    go_emberseerrunes[0] = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_EMBERSEER_RUNE_2:
                    go_emberseerrunes[1] = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_EMBERSEER_RUNE_3:
                    go_emberseerrunes[2] = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_EMBERSEER_RUNE_4:
                    go_emberseerrunes[3] = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_EMBERSEER_RUNE_5:
                    go_emberseerrunes[4] = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_EMBERSEER_RUNE_6:
                    go_emberseerrunes[5] = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_EMBERSEER_RUNE_7:
                    go_emberseerrunes[6] = go->GetGUID();
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_PORTCULLIS_ACTIVE:
                    go_portcullis_active = go->GetGUID();
                    if (GetBossState(DATA_GYTH) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_UROK_PILE:
                    go_urokPile = go->GetGUID();
                    break;
                case GO_UROK_CIRCLE:
                    go_urokOgreCirles.push_back(go->GetGUID());
                    break;
                case GO_UROK_CHALLENGE:
                    go_urokChallenge = go->GetGUID();
                    break;
                default:
                    break;
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_WARCHIEF_REND_BLACKHAND:
                    if (state == FAIL)
                    {
                        if (Creature* rend = instance->GetCreature(WarchiefRendBlackhand))
                        {
                            rend->Respawn(true);
                        }

                        if (Creature* nefarius = instance->GetCreature(LordVictorNefarius))
                        {
                            nefarius->AI()->Talk(SAY_NEFARIUS_REND_WIPE);
                        }
                    }
                    break;
                default:
                    break;
            }

            return true;
        }

        void ProcessEvent(WorldObject* /*obj*/, uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_PYROGUARD_EMBERSEER:
                    if (GetBossState(DATA_PYROGAURD_EMBERSEER) == NOT_STARTED)
                    {
                        if (Creature* Emberseer = instance->GetCreature(PyroguardEmberseer))
                            Emberseer->AI()->SetData(1, 1);
                    }
                    break;
                case EVENT_UROK_DOOMHOWL:
                    if (GetBossState(DATA_UROK_DOOMHOWL) == NOT_STARTED)
                    {
                        SetBossState(DATA_UROK_DOOMHOWL, IN_PROGRESS);
                        if (GameObject* pile = instance->GetGameObject(go_urokPile))
                        {
                            pile->SetLootState(GO_JUST_DEACTIVATED);
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case AREATRIGGER:
                    if (data == AREATRIGGER_DRAGONSPIRE_HALL)
                    {
                        if (GetBossState(DATA_DRAGONSPIRE_ROOM) != DONE)
                            Events.ScheduleEvent(EVENT_DRAGONSPIRE_ROOM_STORE, 1s);
                    }
                    break;
                case DATA_SOLAKAR_FLAMEWREATH:
                    switch(data)
                    {
                        case IN_PROGRESS:
                            if (SolakarState == NOT_STARTED)
                            {
                                Events.ScheduleEvent(EVENT_SOLAKAR_WAVE, 500ms);
                            }
                            break;
                        case FAIL:
                            for (ObjectGuid const& guid : SolakarSummons)
                            {
                                if (Creature* creature = instance->GetCreature(guid))
                                {
                                    creature->DespawnOrUnsummon();
                                }
                            }
                            SolakarSummons.clear();
                            CurrentSolakarWave = 0;
                            SetData(DATA_SOLAKAR_FLAMEWREATH, NOT_STARTED);
                            break;
                        case DONE:
                            break;
                    }
                    SolakarState = data;
                    break;
                case DATA_VAELASTRASZ:
                    VaelastraszState = data;
                    break;
                case DATA_UROK_DOOMHOWL:
                    if (data == FAIL)
                    {
                        if (GetBossState(DATA_UROK_DOOMHOWL) != NOT_STARTED)
                        {
                            SetBossState(DATA_UROK_DOOMHOWL, NOT_STARTED);
                            if (GameObject* challenge = instance->GetGameObject(go_urokChallenge))
                            {
                                challenge->Delete();
                            }
                            if (GameObject* pile = instance->GetGameObject(go_urokPile))
                            {
                                pile->SetLootState(GO_READY);
                                pile->Respawn();
                            }
                            for (const auto& circleGUID : go_urokOgreCirles)
                            {
                                if (GameObject* circle = instance->GetGameObject(circleGUID))
                                {
                                    circle->Delete();
                                }
                            }
                            for (const auto& mobGUID : UrokMobs)
                            {
                                if (Creature* mob = instance->GetCreature(mobGUID))
                                {
                                    mob->DespawnOrUnsummon();
                                }
                            }
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_SOLAKAR_FLAMEWREATH)
            {
                return SolakarState;
            }
            else if (type == DATA_VAELASTRASZ)
            {
                return VaelastraszState;
            }
            else
            {
                return InstanceScript::GetData(type);
            }
        }

        void SummonSolakarWave(uint8 number)
        {
            if (number < MAX_WAVE_COUNT)
            {
                if (Creature* summon = instance->SummonCreature(NPC_ROOKERY_GUARDIAN, SolakarPosLeft))
                {
                    SolakarSummons.push_back(summon->GetGUID());
                }

                if (Creature* summon = instance->SummonCreature(NPC_ROOKERY_HATCHER, SolakarPosRight))
                {
                    SolakarSummons.push_back(summon->GetGUID());
                }

                if (number == 0)
                {
                    if (Creature* FirstHatcher = instance->GetCreature(SolakarSummons.back())) // works because we spawned a hatcher second
                    {
                        FirstHatcher->AI()->Talk(SAY_SOLAKAR_FIRST_HATCHER);
                    }
                }
            }
            else if (number == MAX_WAVE_COUNT)
            {
                if (Creature* summon = instance->SummonCreature(NPC_SOLAKAR, SolakarPosBoss))
                {
                    SolakarSummons.push_back(summon->GetGUID());
                }
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_HIGHLORD_OMOKK:
                    return HighlordOmokk;
                case DATA_SHADOW_HUNTER_VOSHGAJIN:
                    return ShadowHunterVoshgajin;
                case DATA_WARMASTER_VOONE:
                    return WarMasterVoone;
                case DATA_MOTHER_SMOLDERWEB:
                    return MotherSmolderweb;
                case DATA_UROK_DOOMHOWL:
                    return UrokDoomhowl;
                case DATA_QUARTERMASTER_ZIGRIS:
                    return QuartermasterZigris;
                case DATA_GIZRUL_THE_SLAVENER:
                    return GizrultheSlavener;
                case DATA_HALYCON:
                    return Halycon;
                case DATA_OVERLORD_WYRMTHALAK:
                    return OverlordWyrmthalak;
                case DATA_PYROGAURD_EMBERSEER:
                    return PyroguardEmberseer;
                case DATA_WARCHIEF_REND_BLACKHAND:
                    return WarchiefRendBlackhand;
                case DATA_GYTH:
                    return Gyth;
                case DATA_THE_BEAST:
                    return TheBeast;
                case DATA_GENERAL_DRAKKISATH:
                    return GeneralDrakkisath;
                case GO_EMBERSEER_IN:
                    return go_emberseerin;
                case GO_DOORS:
                    return go_doors;
                case GO_EMBERSEER_OUT:
                    return go_emberseerout;
                case GO_HALL_RUNE_1:
                    return go_roomrunes[0];
                case GO_HALL_RUNE_2:
                    return go_roomrunes[1];
                case GO_HALL_RUNE_3:
                    return go_roomrunes[2];
                case GO_HALL_RUNE_4:
                    return go_roomrunes[3];
                case GO_HALL_RUNE_5:
                    return go_roomrunes[4];
                case GO_HALL_RUNE_6:
                    return go_roomrunes[5];
                case GO_HALL_RUNE_7:
                    return go_roomrunes[6];
                case GO_EMBERSEER_RUNE_1:
                    return go_emberseerrunes[0];
                case GO_EMBERSEER_RUNE_2:
                    return go_emberseerrunes[1];
                case GO_EMBERSEER_RUNE_3:
                    return go_emberseerrunes[2];
                case GO_EMBERSEER_RUNE_4:
                    return go_emberseerrunes[3];
                case GO_EMBERSEER_RUNE_5:
                    return go_emberseerrunes[4];
                case GO_EMBERSEER_RUNE_6:
                    return go_emberseerrunes[5];
                case GO_EMBERSEER_RUNE_7:
                    return go_emberseerrunes[6];
                case GO_PORTCULLIS_ACTIVE:
                    return go_portcullis_active;
                case GO_UROK_PILE:
                    return go_urokPile;
                case GO_UROK_CHALLENGE:
                    return go_urokChallenge;
                default:
                    break;
            }

            return ObjectGuid::Empty;
        }

        void Update(uint32 diff) override
        {
            Events.Update(diff);

            while (uint32 eventId = Events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_DRAGONSPIRE_ROOM_STORE:
                        Dragonspireroomstore();
                        Events.ScheduleEvent(EVENT_DRAGONSPIRE_ROOM_CHECK, 3s);
                        break;
                    case EVENT_DRAGONSPIRE_ROOM_CHECK:
                        Dragonspireroomcheck();
                        if ((GetBossState(DATA_DRAGONSPIRE_ROOM) != DONE))
                            Events.ScheduleEvent(EVENT_DRAGONSPIRE_ROOM_CHECK, 3s);
                        break;
                    case EVENT_SOLAKAR_WAVE:
                        SummonSolakarWave(CurrentSolakarWave);
                        if (CurrentSolakarWave < MAX_WAVE_COUNT)
                        {
                            Events.ScheduleEvent(EVENT_SOLAKAR_WAVE, TIMER_SOLAKAR_WAVE);
                            CurrentSolakarWave++;
                        }
                        break;
                    default:
                        break;
                }
            }
        }

        void Dragonspireroomstore()
        {

            for (uint8 i = 0; i < 7; ++i)
            {
                // Refresh the creature list
                runecreaturelist[i].clear();

                if (GameObject* rune = instance->GetGameObject(go_roomrunes[i]))
                {
                    for (uint8 j = 0; j < 3; ++j)
                    {
                        std::list<Creature*> creatureList;
                        GetCreatureListWithEntryInGrid(creatureList, rune, DragonspireMobs[j], 15.0f);
                        for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
                        {
                            if (Creature* creature = *itr)
                            {
                                runecreaturelist[i].push_back(creature->GetGUID());
                            }
                        }
                    }
                }
            }
        }

        void Dragonspireroomcheck()
        {
            Creature* mob = nullptr;
            GameObject* rune = nullptr;

            for (uint8 i = 0; i < 7; ++i)
            {
                bool _mobAlive = false;
                rune = instance->GetGameObject(go_roomrunes[i]);
                if (!rune)
                    continue;

                if (rune->GetGoState() == GO_STATE_ACTIVE)
                {
                    for (ObjectGuid const& guid : runecreaturelist[i])
                    {
                        mob = instance->GetCreature(guid);
                        if (mob && mob->IsAlive())
                            _mobAlive = true;
                    }
                }

                if (!_mobAlive && rune->GetGoState() == GO_STATE_ACTIVE)
                {
                    HandleGameObject(ObjectGuid::Empty, false, rune);

                    switch (rune->GetEntry())
                    {
                        case GO_HALL_RUNE_1:
                            SetBossState(DATA_HALL_RUNE_1, DONE);
                            break;
                        case GO_HALL_RUNE_2:
                            SetBossState(DATA_HALL_RUNE_2, DONE);
                            break;
                        case GO_HALL_RUNE_3:
                            SetBossState(DATA_HALL_RUNE_3, DONE);
                            break;
                        case GO_HALL_RUNE_4:
                            SetBossState(DATA_HALL_RUNE_4, DONE);
                            break;
                        case GO_HALL_RUNE_5:
                            SetBossState(DATA_HALL_RUNE_5, DONE);
                            break;
                        case GO_HALL_RUNE_6:
                            SetBossState(DATA_HALL_RUNE_6, DONE);
                            break;
                        case GO_HALL_RUNE_7:
                            SetBossState(DATA_HALL_RUNE_7, DONE);
                            break;
                        default:
                            break;
                    }
                }
            }

            if (GetBossState(DATA_HALL_RUNE_1) == DONE && GetBossState(DATA_HALL_RUNE_2) == DONE && GetBossState(DATA_HALL_RUNE_3) == DONE &&
                    GetBossState(DATA_HALL_RUNE_4) == DONE && GetBossState(DATA_HALL_RUNE_5) == DONE && GetBossState(DATA_HALL_RUNE_6) == DONE &&
                    GetBossState(DATA_HALL_RUNE_7) == DONE)
            {
                SetBossState(DATA_DRAGONSPIRE_ROOM, DONE);
                if (GameObject* door1 = instance->GetGameObject(go_emberseerin))
                    HandleGameObject(ObjectGuid::Empty, true, door1);
                if (GameObject* door2 = instance->GetGameObject(go_doors))
                    HandleGameObject(ObjectGuid::Empty, true, door2);
                if (GameObject* door3 = instance->GetGameObject(go_emberseerin))
                    HandleGameObject(ObjectGuid::Empty, true, door3);
            }
        }

    protected:
        EventMap Events;
        ObjectGuid HighlordOmokk;
        ObjectGuid ShadowHunterVoshgajin;
        ObjectGuid WarMasterVoone;
        ObjectGuid MotherSmolderweb;
        ObjectGuid UrokDoomhowl;
        ObjectGuid QuartermasterZigris;
        ObjectGuid GizrultheSlavener;
        ObjectGuid Halycon;
        ObjectGuid OverlordWyrmthalak;
        ObjectGuid PyroguardEmberseer;
        ObjectGuid WarchiefRendBlackhand;
        ObjectGuid Gyth;
        ObjectGuid LordVictorNefarius;
        ObjectGuid TheBeast;
        ObjectGuid GeneralDrakkisath;
        ObjectGuid go_emberseerin;
        ObjectGuid go_doors;
        ObjectGuid go_emberseerout;
        ObjectGuid go_blackrockaltar;
        ObjectGuid go_roomrunes[7];
        ObjectGuid go_emberseerrunes[7];
        GuidVector runecreaturelist[7];
        ObjectGuid go_portcullis_active;
        ObjectGuid go_urokPile;
        ObjectGuid go_urokChallenge;
        std::vector<ObjectGuid> go_urokOgreCirles;
        std::vector<ObjectGuid> UrokMobs;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_blackrock_spireMapScript(map);
    }
};

/*#####
# at_dragonspire_hall
#####*/

class at_dragonspire_hall : public AreaTriggerScript
{
public:
    at_dragonspire_hall() : AreaTriggerScript("at_dragonspire_hall") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (player && player->IsAlive())
        {
            if (InstanceScript* instance = player->GetInstanceScript())
            {
                instance->SetData(AREATRIGGER, AREATRIGGER_DRAGONSPIRE_HALL);
                return true;
            }
        }

        return false;
    }
};

/*#####
# at_blackrock_stadium
#####*/

class at_blackrock_stadium : public AreaTriggerScript
{
public:
    at_blackrock_stadium() : AreaTriggerScript("at_blackrock_stadium") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (player && player->IsAlive())
        {
            InstanceScript* instance = player->GetInstanceScript();
            if (!instance)
                return false;

            Creature* rend;
            if (instance->GetBossState(DATA_WARCHIEF_REND_BLACKHAND) == NOT_STARTED)
            {
                if ((rend = player->FindNearestCreature(NPC_WARCHIEF_REND_BLACKHAND, 100.0f, false)))
                    rend->Respawn(true);
            }

            if ((rend = player->FindNearestCreature(NPC_WARCHIEF_REND_BLACKHAND, 100.0f)))
            {
                rend->AI()->SetData(AREATRIGGER, AREATRIGGER_BLACKROCK_STADIUM);
                return true;
            }
        }

        return false;
    }
};

class go_father_flame : public GameObjectScript
{
public:
    go_father_flame() : GameObjectScript("go_father_flame") {}

    void OnLootStateChanged(GameObject* go, uint32 state, Unit* /*unit*/) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (state == GO_ACTIVATED)
            {
                if (instance->GetData(DATA_SOLAKAR_FLAMEWREATH) == IN_PROGRESS || instance->GetData(DATA_SOLAKAR_FLAMEWREATH) == DONE)
                {
                    return;
                }

                instance->SetData(DATA_SOLAKAR_FLAMEWREATH, IN_PROGRESS);
            }
        }
    }
};

class near_scarshield_infiltrator : public AreaTriggerScript
{
public:
    near_scarshield_infiltrator() : AreaTriggerScript("near_scarshield_infiltrator") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (player && player->IsAlive())
        {
            if (Creature* creature = player->FindNearestCreature(NPC_SCARSHIELD_INFILTRATOR, 100.0f, true))
            {
                bool transformHasStarted = creature->AI()->GetData(0) == 1;
                if ((player->GetLevel() < 57 || !player->HasItemCount(ITEM_UNADORNED_SEAL))  && !transformHasStarted)
                {
                    // Send whisper if not already sent
                    std::list<ObjectGuid>::iterator itr = std::find(whisperedTargets.begin(), whisperedTargets.end(), player->GetGUID());
                    if (itr == whisperedTargets.end())
                    {
                        creature->AI()->Talk(SAY_SCARSHIELD_INF_WHISPER, player);
                        whisperedTargets.push_back(player->GetGUID());
                        return true;
                    }
                }
            }
        }
        return false;
    }
    private:
        GuidList whisperedTargets;
};

class at_scarshield_infiltrator : public AreaTriggerScript
{
public:
    at_scarshield_infiltrator() : AreaTriggerScript("at_scarshield_infiltrator") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (player && player->IsAlive())
        {
            if (Creature* creature = player->FindNearestCreature(NPC_SCARSHIELD_INFILTRATOR, 100.0f, true))
            {
                if (player->GetLevel() >= 57 && player->HasItemCount(ITEM_UNADORNED_SEAL))
                {
                    creature->AI()->SetData(0, 1); // Start transform into Vaelan
                    return true;
                }
            }
        }
        return false;
    }
};

/*#####
# npc_vaelastrasz_the_red and Seal of Ascension event
#####*/

// Set fixed spawn points so there's enough room for the dragon model
Position VaelastraszTheRedPosNorth = Position(168.815506f, -420.311066f, 110.472298f, 3.141593f);
Position VaelastraszTheRedPosSouth = Position(134.369049f, -420.311066f, 110.472298f, 6.283184f);

// 16349 - Call of Vaelastrasz

class spell_blackrock_spire_call_of_vaelastrasz : public SpellScript
{
    PrepareSpellScript(spell_blackrock_spire_call_of_vaelastrasz);

    void OnEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (InstanceScript* instance = caster->GetInstanceScript())
            {
                instance->SetData(DATA_VAELASTRASZ, IN_PROGRESS);
                float distanceToNorthSpawn = caster->GetDistance2d(VaelastraszTheRedPosNorth.m_positionX, VaelastraszTheRedPosNorth.m_positionY);
                float distanceToSouthSpawn = caster->GetDistance2d(VaelastraszTheRedPosSouth.m_positionX, VaelastraszTheRedPosSouth.m_positionY);
                Position spawnPosition = distanceToNorthSpawn < distanceToSouthSpawn ? VaelastraszTheRedPosNorth : VaelastraszTheRedPosSouth;
                // despawn is called by the CreatureAI
                caster->SummonCreature(NPC_VAELASTRASZ_THE_RED, spawnPosition, TEMPSUMMON_TIMED_DESPAWN, 60 * IN_MILLISECONDS);
            }
        }
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_blackrock_spire_call_of_vaelastrasz::OnEffect, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

enum Spells
{
    // Vaelastrasz the Red
    SPELL_VAELAN_SPAWNS               = 16634, // Lightning Effect (Self cast)
    SPELL_TOUCH_OF_VAELASTRASZ        = 16319, // AoE heal (Self cast)
    // Vaelastrasz
    SPELL_FLAMEBREATH                 = 16396, // Combat (Self cast)
    SPELL_VAELASTRASZ_SPAWN           = 16354, // Self Cast Despawn (Self cast)
    // Victor Nefarius
    SPELL_NEFARIUS_CORRUPTION         = 23642,
};

enum ModelIds
{
    MODEL_VAELASTRASZ_UBRS    = 9909,
    MODEL_VAELASTRASZ_THE_RED = 9912,
};

enum Says
{
    // Vaelastrasz the Red
    SAY_RED_SUMMONED          = 0,
    SAY_RED_BEFORE_TRANSFORM  = 1,
    // Vaelastrasz
    SAY_VAEL_SUMMONED         = 0,
    SAY_VAEL_STOP_COMBAT      = 1,
    // Victor Nefarius
    SAY_NEFARIUS_15           = 15,
    SAY_NEFARIUS_16           = 16,
    SAY_NEFARIUS_17           = 17,
};

enum Events
{
    // Vaelastrasz the Red
    EVENT_RED_1_TALK_BEFORE_TRANSFORM = 1,
    EVENT_RED_2_TRANSFORM,
    // Vaelastrasz
    EVENT_VAEL_TALK_SUMMON,
    EVENT_VAEL_1_START_COMBAT,
    EVENT_NEFARIUS_TALK_1,
    EVENT_NEFARIUS_TALK_2,
    EVENT_NEFARIUS_TALK_3,
    EVENT_NEFARIUS_CORRUPTION,
    EVENT_VAEL_2_TRANSFORM,
    EVENT_VAEL_3_DESPAWN,
    EVENT_FLAME_BREATH,
};

class npc_vaelastrasz_the_red : public CreatureScript
{
public:
    npc_vaelastrasz_the_red() : CreatureScript("npc_vaelastrasz_the_red") { }

    struct npc_vaelastrasz_the_redAI : public CreatureAI
    {
        npc_vaelastrasz_the_redAI(Creature* creature) : CreatureAI(creature) { }

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
            {
                return;
            }
            _combatEnabled = false;
            me->CastSpell(me, SPELL_VAELAN_SPAWNS, false);
            me->SetFacingToObject(summoner);
            Talk(SAY_RED_SUMMONED);
            if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 100.0f))
            {
                _victorGUID = victor->GetGUID();
            }
            events.ScheduleEvent(EVENT_RED_1_TALK_BEFORE_TRANSFORM, 3s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_RED_1_TALK_BEFORE_TRANSFORM:
                        Talk(SAY_RED_BEFORE_TRANSFORM);
                        events.ScheduleEvent(EVENT_RED_2_TRANSFORM, 2s);
                        break;
                    case EVENT_RED_2_TRANSFORM:
                        me->CastSpell(me, SPELL_TOUCH_OF_VAELASTRASZ, false);
                        me->SetEntry(NPC_VAELASTRASZ_UBRS);
                        me->SetDisplayId(MODEL_VAELASTRASZ_UBRS);
                        events.ScheduleEvent(EVENT_VAEL_TALK_SUMMON, 1s);
                        events.ScheduleEvent(EVENT_VAEL_1_START_COMBAT, 5s);
                        break;
                    case EVENT_VAEL_TALK_SUMMON:
                        Talk(SAY_VAEL_SUMMONED);
                        break;
                    case EVENT_VAEL_1_START_COMBAT:
                        _combatEnabled = true;
                        me->SetImmuneToNPC(false);
                        if (Creature* gyth = me->FindNearestCreature(NPC_GYTH, 100.0f, true))
                        {
                            me->AddThreat(gyth, 1000000.f);
                            me->AI()->AttackStart(gyth);
                        }
                        if (Creature* rend = me->FindNearestCreature(NPC_WARCHIEF_REND_BLACKHAND, 100.0f, true))
                        {
                            if (!rend->IsImmuneToNPC() && rend->isTargetableForAttack())
                            {
                                me->AddThreat(rend, 100000.f);
                                if (!me->FindNearestCreature(NPC_GYTH, 100.0f, true))
                                {
                                    me->AI()->AttackStart(rend);
                                }
                            }
                        }
                        _events2.ScheduleEvent(EVENT_FLAME_BREATH, 5s);
                        events.ScheduleEvent(EVENT_NEFARIUS_TALK_1, 500ms);
                        break;
                    case EVENT_NEFARIUS_TALK_1:
                        if (Creature* victor = ObjectAccessor::GetCreature(*me, _victorGUID))
                        {
                            victor->GetMotionMaster()->Clear(); // stop pacing
                            victor->GetMotionMaster()->MoveIdle();
                            victor->StopMovingOnCurrentPos();
                            victor->SetFacingToObject(me);
                            victor->AI()->Talk(SAY_NEFARIUS_15);
                        }
                        events.ScheduleEvent(EVENT_NEFARIUS_TALK_2, 6s);
                        break;
                    case EVENT_NEFARIUS_TALK_2:
                        if (Creature* victor = ObjectAccessor::GetCreature(*me, _victorGUID))
                        {
                            victor->SetFacingToObject(me);
                            victor->AI()->Talk(SAY_NEFARIUS_16);
                        }
                        events.ScheduleEvent(EVENT_NEFARIUS_TALK_3, 5s);
                        break;
                    case EVENT_NEFARIUS_TALK_3:
                        if (Creature* victor = ObjectAccessor::GetCreature(*me, _victorGUID))
                        {
                            victor->SetFacingToObject(me);
                            victor->AI()->Talk(SAY_NEFARIUS_17);
                        }
                        events.ScheduleEvent(EVENT_NEFARIUS_CORRUPTION, 5s);
                        break;
                    case EVENT_NEFARIUS_CORRUPTION:
                        _combatEnabled = false;
                        me->AttackStop();
                        me->RemoveAllAuras();
                        me->StopMovingOnCurrentPos();
                        me->SetFaction(FACTION_FRIENDLY);
                        if (Creature* victor = ObjectAccessor::GetCreature(*me, _victorGUID))
                        {
                            victor->SetFacingToObject(me);
                            victor->CastSpell(me, SPELL_NEFARIUS_CORRUPTION, TRIGGERED_CAST_DIRECTLY);
                        }
                        events.ScheduleEvent(EVENT_VAEL_2_TRANSFORM, 1s);
                        break;
                    case EVENT_VAEL_2_TRANSFORM:
                        Talk(SAY_VAEL_STOP_COMBAT);
                        me->SetDisplayId(MODEL_VAELASTRASZ_THE_RED);
                        events.ScheduleEvent(EVENT_VAEL_3_DESPAWN, 500ms);
                        break;
                    case EVENT_VAEL_3_DESPAWN:
                        DoCast(me, SPELL_VAELASTRASZ_SPAWN);
                        me->DespawnOrUnsummon(1500);
                        break;
                    default:
                        break;
                }
            }

            if (!_combatEnabled || !UpdateVictim() || me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            _events2.Update(diff);

            switch (_events2.ExecuteEvent())
            {
                case EVENT_FLAME_BREATH:
                    me->CastSpell(me, SPELL_FLAMEBREATH, false);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
            return;
        }

    private:
        ObjectGuid _victorGUID;
        bool _combatEnabled;
        EventMap _events2;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<npc_vaelastrasz_the_redAI>(creature);
    }
};

void AddSC_instance_blackrock_spire()
{
    new instance_blackrock_spire();
    new at_dragonspire_hall();
    new at_blackrock_stadium();
    new go_father_flame();
    new near_scarshield_infiltrator();
    new at_scarshield_infiltrator();
    RegisterSpellScript(spell_blackrock_spire_call_of_vaelastrasz);
    new npc_vaelastrasz_the_red();
}
