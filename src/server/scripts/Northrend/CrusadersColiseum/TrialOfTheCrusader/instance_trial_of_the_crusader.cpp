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

#include "GameTime.h"
#include "Group.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "trial_of_the_crusader.h"

std::map<uint32, bool> validDedicatedInsanityItems;

class instance_trial_of_the_crusader : public InstanceMapScript
{
public:
    instance_trial_of_the_crusader() : InstanceMapScript("instance_trial_of_the_crusader", 649) { }

    struct instance_trial_of_the_crusader_InstanceMapScript : public InstanceScript
    {
        instance_trial_of_the_crusader_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetHeaders(DataHeader);
            Initialize();
        }

        bool CLEANED;
        uint32 EncounterStatus;
        uint32 InstanceProgress;
        uint32 AttemptsLeft;
        TeamId TeamIdInInstance;
        uint8 Counter;
        uint8 northrendBeastsMask;
        uint32 AchievementTimer;
        bool bDedicatedInsanity;
        bool bSwitcher;
        bool bNooneDied;
        std::string str_data;
        EventMap events;

        ObjectGuid NPC_BarrettGUID;
        ObjectGuid NPC_TirionGUID;
        ObjectGuid NPC_FizzlebangGUID;
        ObjectGuid NPC_GarroshGUID;
        ObjectGuid NPC_VarianGUID;

        ObjectGuid NPC_GormokGUID;
        ObjectGuid NPC_DreadscaleGUID;
        ObjectGuid NPC_AcidmawGUID;
        ObjectGuid NPC_IcehowlGUID;
        ObjectGuid NPC_JaraxxusGUID;
        GuidVector NPC_ChampionGUIDs;
        ObjectGuid NPC_LightbaneGUID;
        ObjectGuid NPC_DarkbaneGUID;
        ObjectGuid NPC_LichKingGUID;
        ObjectGuid NPC_AnubarakGUID;

        ObjectGuid NPC_PurpleGroundGUID;
        ObjectGuid NPC_PortalGUID;

        ObjectGuid GO_MainGateGUID;
        ObjectGuid GO_EnterGateGUID;
        ObjectGuid GO_WebDoorGUID;
        ObjectGuid GO_FloorGUID;

        void SpawnAnubArak()
        {
            if (InstanceProgress == INSTANCE_PROGRESS_ANUB_ARAK)
            {
                if (Creature* barrett = instance->GetCreature(NPC_BarrettGUID))
                {
                    barrett->SetVisible(false);
                    if (AttemptsLeft)
                        if (!ObjectAccessor::GetCreature(*barrett, NPC_AnubarakGUID))
                            barrett->SummonCreature(NPC_ANUBARAK, Locs[LOC_ANUB].GetPositionX(), Locs[LOC_ANUB].GetPositionY(), Locs[LOC_ANUB].GetPositionZ(), Locs[LOC_ANUB].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000);
                }

                // move corpses
                const ObjectGuid npcs[4] = { NPC_IcehowlGUID, NPC_JaraxxusGUID, NPC_LightbaneGUID, NPC_DarkbaneGUID };
                for (ObjectGuid const& i : npcs)
                {
                    if (Creature* c = instance->GetCreature(i))
                    {
                        if (c->GetGUID() == NPC_IcehowlGUID)
                            c->UpdatePosition(626.57f, 162.8f, 140.25f, 4.44f, true);
                        else if (c->GetGUID() == NPC_JaraxxusGUID)
                            c->UpdatePosition(603.92f, 102.61f, 141.85f, 1.4f, true);
                        else if (c->GetGUID() == NPC_LightbaneGUID)
                            c->UpdatePosition(634.58f, 147.16f, 140.5f, 3.02f, true);
                        else if (c->GetGUID() == NPC_DarkbaneGUID)
                            c->UpdatePosition(630.88f, 131.39f, 140.8f, 3.02f, true);

                        c->StopMovingOnCurrentPos();
                        c->DestroyForNearbyPlayers();
                    }
                }
            }
        }

        bool IsValidDedicatedInsanityItem(ItemTemplate const* item)
        {
            if (!item) // should not happen, but checked in GetAverageItemLevel()
                return true;
            if (item->ItemLevel < 245)
                return true;
            if (item->ItemId == 46017) // Val'anyr, Hammer of Ancient Kings - exception, too powerful
                return false;
            if (item->ItemLevel == 245 && item->Bonding == BIND_WHEN_EQUIPED) // this also includes items crafted from patterns obtained in ToC 10 norm/hc
                return true;
            if (validDedicatedInsanityItems.find(item->ItemId) != validDedicatedInsanityItems.end()) // list of items dropping from ToC 10 norm/hc and also items ilevel 245 buyable for emblems of triumph
                return true;

            return false;
        }

        void DoCheckDedicatedInsanity()
        {
            if (!bDedicatedInsanity || AttemptsLeft < 50 || instance->GetDifficulty() != RAID_DIFFICULTY_10MAN_HEROIC)
                return;

            if (validDedicatedInsanityItems.empty())
            {
                for (uint32 i = 0; i < dIIc; ++i)
                    validDedicatedInsanityItems[dedicatedInsanityItems[i]] = true;
            }

            Map::PlayerList const& pl = instance->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                if (Player* plr = itr->GetSource())
                    if (!plr->IsGameMaster() && plr->IsInCombat() /*performance*/)
                    {
                        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i) // loop through equipped items
                            if (Item* item = plr->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                                if (!IsValidDedicatedInsanityItem(item->GetTemplate()))
                                {
                                    bDedicatedInsanity = false;
                                    SaveToDB();
                                    return;
                                }
                    }
        }

        void OnUnitDeath(Unit* u) override
        {
            if (bNooneDied && u->GetTypeId() == TYPEID_PLAYER)
            {
                bNooneDied = false;
                SaveToDB();
            }
        }

        void Initialize() override
        {
            CLEANED = false;
            EncounterStatus = NOT_STARTED;
            InstanceProgress = INSTANCE_PROGRESS_INITIAL;
            AttemptsLeft = 50;
            TeamIdInInstance = TEAM_NEUTRAL;
            Counter = 0;
            northrendBeastsMask = 0;
            AchievementTimer = 0;
            bDedicatedInsanity = true;
            bSwitcher = false;
            bNooneDied = true;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0);

            NPC_ChampionGUIDs.clear();
        }

        bool IsEncounterInProgress() const override
        {
            Map::PlayerList const& pl = instance->GetPlayers();
            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                if( Player* plr = itr->GetSource() )
                    if( plr->IsAlive() && !plr->IsGameMaster() )
                        return EncounterStatus == IN_PROGRESS; // found alive player

            if( EncounterStatus != NOT_STARTED )
                *(const_cast<uint32*>(&EncounterStatus)) = NOT_STARTED;
            return false;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch( creature->GetEntry() )
            {
                case NPC_BARRENT:
                    NPC_BarrettGUID = creature->GetGUID();
                    break;
                case NPC_TIRION:
                    NPC_TirionGUID = creature->GetGUID();
                    break;
                case NPC_GARROSH:
                    NPC_GarroshGUID = creature->GetGUID();
                    break;
                case NPC_VARIAN:
                    NPC_VarianGUID = creature->GetGUID();
                    break;
                case NPC_FIZZLEBANG:
                    NPC_FizzlebangGUID = creature->GetGUID();
                    break;

                case NPC_GORMOK:
                    NPC_GormokGUID = creature->GetGUID();
                    break;
                case NPC_DREADSCALE:
                    NPC_DreadscaleGUID = creature->GetGUID();
                    break;
                case NPC_ACIDMAW:
                    NPC_AcidmawGUID = creature->GetGUID();
                    break;
                case NPC_ICEHOWL:
                    NPC_IcehowlGUID = creature->GetGUID();
                    break;
                case NPC_JARAXXUS:
                    NPC_JaraxxusGUID = creature->GetGUID();
                    break;
                case NPC_LIGHTBANE:
                    NPC_LightbaneGUID = creature->GetGUID();
                    break;
                case NPC_DARKBANE:
                    NPC_DarkbaneGUID = creature->GetGUID();
                    break;
                case NPC_LICH_KING:
                    NPC_LichKingGUID = creature->GetGUID();
                    break;
                case NPC_ANUBARAK:
                    NPC_AnubarakGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch( go->GetEntry() )
            {
                case GO_MAIN_GATE_DOOR:
                    GO_MainGateGUID = go->GetGUID();
                    HandleGameObject(GO_MainGateGUID, false, go);
                    break;
                case GO_WEB_DOOR:
                    GO_WebDoorGUID = go->GetGUID();
                    HandleGameObject(GO_WebDoorGUID, true, go);
                    break;
                case GO_ARGENT_COLISEUM_FLOOR:
                    GO_FloorGUID = go->GetGUID();
                    if (InstanceProgress == INSTANCE_PROGRESS_ANUB_ARAK)
                        go->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
                    break;
                case GO_SOUTH_PORTCULLIS:
                case GO_NORTH_PORTCULLIS:
                    HandleGameObject(go->GetGUID(), false, go);
                    break;
                case GO_EAST_PORTCULLIS:
                    HandleGameObject(go->GetGUID(), true, go);
                    GO_EnterGateGUID = go->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch( type )
            {
                case TYPE_FAILED:
                    // - some scene here?
                    if( instance->IsHeroic() && !CLEANED )
                    {
                        if( AttemptsLeft > 0 )
                            --AttemptsLeft;
                        Map::PlayerList const& pl = instance->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* plr = itr->GetSource() )
                                plr->SendUpdateWorldState(UPDATE_STATE_UI_COUNT, AttemptsLeft);
                    }
                    InstanceCleanup(true);
                    SaveToDB();
                    break;
                case TYPE_ANNOUNCER_GOSSIP_SELECT:
                    if( instance->IsHeroic() && AttemptsLeft == 0 )
                        break;
                    switch( InstanceProgress )
                    {
                        case INSTANCE_PROGRESS_INITIAL:
                            events.RescheduleEvent(EVENT_SCENE_001, 0);
                            break;
                        case INSTANCE_PROGRESS_INTRO_DONE:
                            events.RescheduleEvent(EVENT_SCENE_004, 0);
                            break;
                        case INSTANCE_PROGRESS_BEASTS_DEAD:
                            events.RescheduleEvent(EVENT_SCENE_101, 0);
                            break;
                        case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                            events.RescheduleEvent(EVENT_SCENE_201, 0);
                            break;
                        case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                            events.RescheduleEvent(EVENT_SCENE_301, 0);
                            break;
                        case INSTANCE_PROGRESS_VALKYR_DEAD:
                            events.RescheduleEvent(EVENT_SCENE_401, 0);
                            break;
                    }
                    break;
                case TYPE_GORMOK:
                    if( data == DONE )
                    {
                        if (Creature* trigger = instance->SummonCreature(WORLD_TRIGGER, Locs[LOC_CENTER], nullptr, 25000))
                        {
                            trigger->SetDisplayId(11686);
                            trigger->ReplaceAllUnitFlags(UNIT_FLAG_NOT_SELECTABLE);
                            trigger->SetFaction(FACTION_MONSTER);
                            trigger->SetInCombatWithZone();
                        }

                        EncounterStatus = IN_PROGRESS;

                        northrendBeastsMask |= 1;
                        if ((northrendBeastsMask & 7) == 7)
                            SetData(TYPE_NORTHREND_BEASTS_ALL, DONE);
                        else if ((northrendBeastsMask & 16) == 0)
                            events.RescheduleEvent(EVENT_SCENE_005, 2500);
                    }
                    break;
                case TYPE_JORMUNGAR:
                    if( data == DONE )
                    {
                        if( ++Counter == 2 )
                        {
                            if (Creature* trigger = instance->SummonCreature(WORLD_TRIGGER, Locs[LOC_CENTER], nullptr, 25000))
                            {
                                trigger->SetDisplayId(11686);
                                trigger->ReplaceAllUnitFlags(UNIT_FLAG_NOT_SELECTABLE);
                                trigger->SetFaction(FACTION_MONSTER);
                                trigger->SetInCombatWithZone();
                            }

                            if( Creature* c = instance->GetCreature(NPC_AcidmawGUID) )
                                c->DespawnOrUnsummon(10000);
                            if( Creature* c = instance->GetCreature(NPC_DreadscaleGUID) )
                                c->DespawnOrUnsummon(10000);
                            if( AchievementTimer + 10 >= GameTime::GetGameTime().count() )
                                DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_JORMUNGAR_ACHIEV);
                            AchievementTimer = 0;

                            EncounterStatus = IN_PROGRESS;

                            northrendBeastsMask |= 2;
                            if ((northrendBeastsMask & 7) == 7)
                                SetData(TYPE_NORTHREND_BEASTS_ALL, DONE);
                            else if ((northrendBeastsMask & 32) == 0)
                            {
                                Counter = 0;
                                events.RescheduleEvent(EVENT_SCENE_006, 2500);
                            }
                        }
                        else // first one died, start timer for achievement
                        {
                            AchievementTimer = GameTime::GetGameTime().count();
                        }
                    }
                    else
                        AchievementTimer = 0;
                    break;
                case TYPE_ICEHOWL:
                    if( data == DONE )
                    {
                        northrendBeastsMask |= 4;
                        if ((northrendBeastsMask & 7) == 7)
                            SetData(TYPE_NORTHREND_BEASTS_ALL, DONE);
                    }
                    break;
                case TYPE_NORTHREND_BEASTS_ALL:
                    if (data == DONE)
                    {
                        northrendBeastsMask = 0;
                        EncounterStatus = NOT_STARTED;
                        InstanceProgress = INSTANCE_PROGRESS_BEASTS_DEAD;
                        HandleGameObject(GO_EnterGateGUID, true);
                        events.CancelEvent(EVENT_NORTHREND_BEASTS_ENRAGE);
                        events.RescheduleEvent(EVENT_SCENE_BEASTS_DONE, 2500);
                        SaveToDB();
                    }
                    break;
                case TYPE_JARAXXUS:
                    EncounterStatus = data == IN_PROGRESS ? IN_PROGRESS : NOT_STARTED;
                    if( data == IN_PROGRESS )
                        HandleGameObject(GO_EnterGateGUID, false);
                    else if( data == DONE )
                    {
                        HandleGameObject(GO_EnterGateGUID, true);
                        InstanceProgress = INSTANCE_PROGRESS_JARAXXUS_DEAD;
                        events.RescheduleEvent(EVENT_SCENE_110, 2500);
                        SaveToDB();
                    }
                    break;
                case TYPE_FACTION_CHAMPIONS:
                    if( data == DONE )
                    {
                        if( ++Counter >= NPC_ChampionGUIDs.size() )
                        {
                            if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                                c->CastSpell(c, SPELL_FACTION_CHAMPIONS_KILL_CREDIT, true);
                            Counter = 0;
                            EncounterStatus = NOT_STARTED;
                            InstanceProgress = INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD;
                            events.RescheduleEvent(EVENT_SCENE_FACTION_CHAMPIONS_DEAD, 2500);

                            for (ObjectGuid const& guid : NPC_ChampionGUIDs)
                                if (Creature* c = instance->GetCreature(guid))
                                    c->DespawnOrUnsummon(15000);
                            NPC_ChampionGUIDs.clear();

                            if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            {
                                uint32 cacheEntry = 0;
                                switch( instance->GetDifficulty() )
                                {
                                    case RAID_DIFFICULTY_10MAN_NORMAL:
                                        cacheEntry = GO_CRUSADERS_CACHE_10;
                                        break;
                                    case RAID_DIFFICULTY_25MAN_NORMAL:
                                        cacheEntry = GO_CRUSADERS_CACHE_25;
                                        break;
                                    case RAID_DIFFICULTY_10MAN_HEROIC:
                                        cacheEntry = GO_CRUSADERS_CACHE_10_H;
                                        break;
                                    case RAID_DIFFICULTY_25MAN_HEROIC:
                                        cacheEntry = GO_CRUSADERS_CACHE_25_H;
                                        break;
                                }

                                if (GameObject* go = c->SummonGameObject(cacheEntry, Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY(), Locs[LOC_CENTER].GetPositionZ(), Locs[LOC_CENTER].GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 630000000))
                                {
                                    go->SetLootRecipient(instance);
                                }
                            }

                            HandleGameObject(GO_EnterGateGUID, true);

                            if( AchievementTimer + 60 >= GameTime::GetGameTime().count() )
                                DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_RESILIENCE_WILL_FIX_IT_CREDIT);
                            AchievementTimer = 0;

                            SaveToDB();
                        }
                        else if( Counter == 1 )
                            AchievementTimer = GameTime::GetGameTime().count();
                    }
                    break;
                case TYPE_FACTION_CHAMPIONS_START:
                    {
                        EncounterStatus = IN_PROGRESS;
                        AchievementTimer = 0;
                        for (ObjectGuid const& guid : NPC_ChampionGUIDs)
                            if (Creature* c = instance->GetCreature(guid))
                                if (!c->IsInCombat())
                                    if (Unit* target = c->SelectNearestTarget(200.0f))
                                        c->AI()->AttackStart(target);
                    }
                    break;
                case TYPE_FACTION_CHAMPIONS_PLAYER_DIED:
                    if( urand(0, 2) == 0 )
                    {
                        if( TeamIdInInstance == TEAM_HORDE )
                        {
                            if( Creature* pTemp = instance->GetCreature(NPC_VarianGUID) )
                                pTemp->AI()->Talk(SAY_VARIAN_KILL_HORDE_PLAYER_1);
                        }
                        else if( Creature* pTemp = instance->GetCreature(NPC_GarroshGUID) )
                            pTemp->AI()->Talk(SAY_GARROSH_KILL_ALLIANCE_PLAYER_1);
                    }
                    break;
                case TYPE_VALKYR:
                    if( data == DONE && ++Counter >= 2 )
                    {
                        Counter = 0;
                        EncounterStatus = NOT_STARTED;
                        InstanceProgress = INSTANCE_PROGRESS_VALKYR_DEAD;
                        DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, 34497, 1); // Lightbane
                        DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, 34496, 1); // Darkbane
                        events.RescheduleEvent(EVENT_SCENE_VALKYR_DEAD, 2500);
                        HandleGameObject(GO_EnterGateGUID, true);
                        SaveToDB();
                    }
                    break;
                case TYPE_ANUBARAK:
                    if( data == IN_PROGRESS )
                    {
                        EncounterStatus = IN_PROGRESS;
                        HandleGameObject(GO_WebDoorGUID, false);
                    }
                    else if( data == DONE )
                    {
                        Counter = 0;
                        EncounterStatus = NOT_STARTED;
                        InstanceProgress = INSTANCE_PROGRESS_DONE;
                        HandleGameObject(GO_EnterGateGUID, true);
                        HandleGameObject(GO_WebDoorGUID, true);
                        SaveToDB();

                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                        {
                            c->UpdatePosition(Locs[LOC_TIRION_FINAL], true);
                            c->StopMovingOnCurrentPos();
                            c->SetFacingTo(Locs[LOC_TIRION_FINAL].GetOrientation());
                            events.RescheduleEvent(EVENT_SCENE_501, 20000);
                        }
                        if( GameObject* floor = instance->GetGameObject(GO_FloorGUID) )
                            floor->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);
                    }
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch( type )
            {
                case TYPE_INSTANCE_PROGRESS:
                    return InstanceProgress;
            }
            return 0;
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch( type )
            {
                case TYPE_GORMOK:
                    return NPC_GormokGUID;
                case TYPE_DREADSCALE:
                    return NPC_DreadscaleGUID;
                case TYPE_ACIDMAW:
                    return NPC_AcidmawGUID;
                case NPC_DARKBANE:
                    return NPC_DarkbaneGUID;
                case NPC_LIGHTBANE:
                    return NPC_LightbaneGUID;
                case TYPE_ANUBARAK:
                    return NPC_AnubarakGUID;
            }

            return ObjectGuid::Empty;
        }

        void Update(uint32 diff) override
        {
            events.Update(diff);
            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_CHECK_PLAYERS:
                    {
                        if (bSwitcher) // used to double the check interval
                            DoCheckDedicatedInsanity();
                        bSwitcher = !bSwitcher;

                        if (DoNeedCleanup())
                        {
                            InstanceCleanup();
                        }
                        events.Repeat(5s);
                    }
                    break;
                case EVENT_OPEN_GATE:
                    {
                        HandleGameObject(GO_MainGateGUID, true);
                        break;
                    }
                case EVENT_CLOSE_GATE:
                    {
                        HandleGameObject(GO_MainGateGUID, false);
                    }
                    break;
                case EVENT_SCENE_001:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_0_01);

                        events.RescheduleEvent(EVENT_SCENE_002, 22000);
                    }
                    break;
                case EVENT_SCENE_002:
                    {
                        if( Creature* c = instance->GetCreature(NPC_VarianGUID) )
                            c->AI()->Talk(SAY_STAGE_0_03a);

                        events.RescheduleEvent(EVENT_SCENE_003, 5000);
                    }
                    break;
                case EVENT_SCENE_003:
                    {
                        if( Creature* c = instance->GetCreature(NPC_GarroshGUID) )
                            c->AI()->Talk(SAY_STAGE_0_03h);

                        events.RescheduleEvent(EVENT_SCENE_004, 8000);
                    }
                    break;
                case EVENT_SCENE_004:
                    {
                        InstanceProgress = INSTANCE_PROGRESS_INTRO_DONE;
                        EncounterStatus = IN_PROGRESS;

                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_0_02);
                        HandleGameObject(GO_MainGateGUID, true);
                        HandleGameObject(GO_EnterGateGUID, false);

                        events.RescheduleEvent(EVENT_SUMMON_GORMOK, 1000);
                        if (instance->IsHeroic())
                        {
                            events.RescheduleEvent(EVENT_SCENE_005, 150000);
                            events.RescheduleEvent(EVENT_SCENE_006, 340000);
                            events.RescheduleEvent(EVENT_NORTHREND_BEASTS_ENRAGE, 520000);
                        }
                    }
                    break;
                case EVENT_NORTHREND_BEASTS_ENRAGE:
                    if( Creature* c = instance->GetCreature(NPC_GormokGUID) )
                        if (c->IsAlive())
                            c->CastSpell(c, 26662, true);
                    if( Creature* c = instance->GetCreature(NPC_AcidmawGUID) )
                        if (c->IsAlive())
                            c->CastSpell(c, 26662, true);
                    if( Creature* c = instance->GetCreature(NPC_DreadscaleGUID) )
                        if (c->IsAlive())
                            c->CastSpell(c, 26662, true);
                    if( Creature* c = instance->GetCreature(NPC_IcehowlGUID) )
                        if (c->IsAlive())
                            c->CastSpell(c, 26662, true);

                    break;
                case EVENT_SUMMON_GORMOK:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            if( Creature* gormok = c->SummonCreature(NPC_GORMOK, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY(), Locs[LOC_BEHIND_GATE].GetPositionZ(), Locs[LOC_BEHIND_GATE].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000) )
                                gormok->GetMotionMaster()->MovePoint(0, Locs[LOC_GATE_FRONT].GetPositionX(), Locs[LOC_GATE_FRONT].GetPositionY(), Locs[LOC_GATE_FRONT].GetPositionZ());

                        events.RescheduleEvent(EVENT_GORMOK_ATTACK, 10000);
                        events.RescheduleEvent(EVENT_CLOSE_GATE, 6000);
                    }
                    break;
                case EVENT_GORMOK_ATTACK:
                    {
                        northrendBeastsMask = 0;
                        if( Creature* c = instance->GetCreature(NPC_GormokGUID) )
                        {
                            c->SetReactState(REACT_AGGRESSIVE);
                            c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            if( Unit* target = c->SelectNearestTarget(200.0f) )
                            {
                                c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        }
                        break;
                    }
                case EVENT_SCENE_005:
                    {
                        northrendBeastsMask |= 16;
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_0_04);

                        events.RescheduleEvent(EVENT_OPEN_GATE, 3000);
                        events.RescheduleEvent(EVENT_SUMMON_ACIDMAW_AND_DREADSCALE, 4000);
                        break;
                    }
                case EVENT_SUMMON_ACIDMAW_AND_DREADSCALE:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                        {
                            if( Creature* dreadscale = c->SummonCreature(NPC_DREADSCALE, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY(), Locs[LOC_BEHIND_GATE].GetPositionZ(), Locs[LOC_BEHIND_GATE].GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN) )
                                dreadscale->GetMotionMaster()->MovePoint(0, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY() - 25.0f, Locs[LOC_BEHIND_GATE].GetPositionZ());
                            if( Creature* acidmaw = c->SummonCreature(NPC_ACIDMAW, Locs[LOC_ACIDMAW].GetPositionX(), Locs[LOC_ACIDMAW].GetPositionY(), Locs[LOC_ACIDMAW].GetPositionZ(), Locs[LOC_ACIDMAW].GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN) )
                                acidmaw->AddAura(53421, acidmaw);
                        }

                        events.RescheduleEvent(EVENT_SCENE_005_2, 4000);
                        break;
                    }

                case EVENT_SCENE_005_2:
                    {
                        if( Creature* dreadscale = instance->GetCreature(NPC_DreadscaleGUID) )
                            dreadscale->GetMotionMaster()->MovePoint(0, Locs[LOC_DREADSCALE].GetPositionX(), Locs[LOC_DREADSCALE].GetPositionY(), Locs[LOC_DREADSCALE].GetPositionZ());

                        events.RescheduleEvent(EVENT_ACIDMAW_AND_DREADSCALE_ATTACK, 7000);
                        break;
                    }
                case EVENT_ACIDMAW_AND_DREADSCALE_ATTACK:
                    {
                        HandleGameObject(GO_MainGateGUID, false);
                        if( Creature* c = instance->GetCreature(NPC_DreadscaleGUID) )
                        {
                            c->SetReactState(REACT_AGGRESSIVE);
                            c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            if( Unit* target = c->SelectNearestTarget(200.0f) )
                            {
                                c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        }
                        if( Creature* c = instance->GetCreature(NPC_AcidmawGUID) )
                        {
                            c->SetReactState(REACT_AGGRESSIVE);
                            c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            if( Unit* target = c->SelectNearestTarget(200.0f) )
                            {
                                c->RemoveAura(53421);
                                c->CastSpell(c, 66947, false);
                                c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        }
                        break;
                    }
                case EVENT_SCENE_006:
                    {
                        northrendBeastsMask |= 32;
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_0_05);

                        events.RescheduleEvent(EVENT_OPEN_GATE, 2000);
                        events.RescheduleEvent(EVENT_SUMMON_ICEHOWL, 3000);
                        break;
                    }
                case EVENT_SUMMON_ICEHOWL:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            if( Creature* icehowl = c->SummonCreature(NPC_ICEHOWL, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY(), Locs[LOC_BEHIND_GATE].GetPositionZ(), Locs[LOC_BEHIND_GATE].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000) )
                                icehowl->GetMotionMaster()->MovePoint(0, Locs[LOC_GATE_FRONT].GetPositionX(), Locs[LOC_GATE_FRONT].GetPositionY(), Locs[LOC_GATE_FRONT].GetPositionZ());

                        events.RescheduleEvent(EVENT_ICEHOWL_ATTACK, 10000);
                        events.RescheduleEvent(EVENT_CLOSE_GATE, 6000);
                        break;
                    }
                case EVENT_ICEHOWL_ATTACK:
                    {
                        if( Creature* c = instance->GetCreature(NPC_IcehowlGUID) )
                        {
                            c->SetReactState(REACT_AGGRESSIVE);
                            c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            if( Unit* target = c->SelectNearestTarget(200.0f) )
                            {
                                c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        }
                        break;
                    }
                case EVENT_SCENE_BEASTS_DONE:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_0_06);
                        if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        break;
                    }
                case EVENT_SCENE_101:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                        {
                            HandleGameObject(GO_MainGateGUID, true);
                            c->AI()->Talk(SAY_STAGE_1_01);
                            if( Creature* fizzlebang = c->SummonCreature(NPC_FIZZLEBANG, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY(), Locs[LOC_BEHIND_GATE].GetPositionZ(), Locs[LOC_BEHIND_GATE].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 300000) )
                            {
                                fizzlebang->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                fizzlebang->GetMotionMaster()->MovePoint(0, Locs[LOC_BEHIND_GATE].GetPositionX(), Locs[LOC_BEHIND_GATE].GetPositionY() - 65.0f, Locs[LOC_BEHIND_GATE].GetPositionZ() - 1.0f);
                            }
                            events.RescheduleEvent(EVENT_SCENE_102, 20000);

                            // move Icehowl to side, can't remove corpse because of loot!
                            if( Creature* icehowl = instance->GetCreature(NPC_IcehowlGUID) )
                            {
                                icehowl->UpdatePosition(513.19f, 139.48f, 395.22f, 3 * M_PI / 2, true);
                                icehowl->StopMovingOnCurrentPos();
                                icehowl->DestroyForNearbyPlayers();
                            }
                        }
                        break;
                    }
                case EVENT_SCENE_102:
                    {
                        HandleGameObject(GO_MainGateGUID, false);
                        if( Creature* c = instance->GetCreature(NPC_FizzlebangGUID) )
                            c->AI()->Talk(SAY_STAGE_1_02);

                        events.RescheduleEvent(EVENT_SCENE_103, 11000);
                        break;
                    }
                case EVENT_SCENE_103:
                    {
                        if( Creature* c = instance->GetCreature(NPC_FizzlebangGUID) )
                        {
                            c->AI()->Talk(SAY_STAGE_1_03);
                            c->HandleEmoteCommand(EMOTE_STATE_SPELL_PRECAST);
                            if( Creature* trigger = c->SummonCreature(NPC_PURPLE_GROUND, Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY(), Locs[LOC_CENTER].GetPositionZ(), Locs[LOC_CENTER].GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN) )
                                NPC_PurpleGroundGUID = trigger->GetGUID();
                        }

                        events.RescheduleEvent(EVENT_SCENE_104, 5000);
                        break;
                    }
                case EVENT_SCENE_104:
                    {
                        if( Creature* c = instance->GetCreature(NPC_FizzlebangGUID) )
                        {
                            if( Creature* portal = c->SummonCreature(NPC_WORLD_TRIGGER, Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY(), Locs[LOC_CENTER].GetPositionZ(), Locs[LOC_CENTER].GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN) )
                            {
                                NPC_PortalGUID = portal->GetGUID();
                                portal->SetObjectScale(3.0f);
                                portal->SetReactState(REACT_PASSIVE);
                                portal->CastSpell(portal, SPELL_WILFRED_PORTAL, true);
                            }
                            c->HandleEmoteCommand(EMOTE_STATE_SPELL_PRECAST);
                        }

                        events.RescheduleEvent(EVENT_SUMMON_JARAXXUS, 5000);
                        break;
                    }
                case EVENT_SUMMON_JARAXXUS:
                    {
                        if( Creature* c = instance->GetCreature(NPC_FizzlebangGUID) )
                        {
                            if( Creature* jaraxxus = c->SummonCreature(NPC_JARAXXUS, Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY(), Locs[LOC_CENTER].GetPositionZ(), Locs[LOC_CENTER].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000) )
                                jaraxxus->GetMotionMaster()->MovePoint(0, Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY() - 10.0f, Locs[LOC_CENTER].GetPositionZ());
                            c->HandleEmoteCommand(EMOTE_STATE_NONE);
                            c->AI()->Talk(SAY_STAGE_1_04);
                        }

                        events.RescheduleEvent(EVENT_SCENE_105, 3000);
                        break;
                    }
                case EVENT_SCENE_105:
                    {
                        if( Creature* c = instance->GetCreature(NPC_JaraxxusGUID) )
                            c->SetFacingTo(M_PI / 2);
                        if( Creature* c = instance->GetCreature(NPC_PurpleGroundGUID) )
                            c->DespawnOrUnsummon();
                        NPC_PurpleGroundGUID.Clear();
                        if( Creature* c = instance->GetCreature(NPC_PortalGUID) )
                            c->DespawnOrUnsummon();
                        NPC_PortalGUID.Clear();

                        events.RescheduleEvent(EVENT_SCENE_106, 10000);
                        break;
                    }
                case EVENT_SCENE_106:
                    {
                        if( Creature* c = instance->GetCreature(NPC_JaraxxusGUID) )
                            c->AI()->Talk(SAY_STAGE_1_05);

                        events.RescheduleEvent(EVENT_SCENE_107, 5000);
                        break;
                    }
                case EVENT_SCENE_107:
                    {
                        if( Creature* c = instance->GetCreature(NPC_FizzlebangGUID) )
                            c->AI()->Talk(SAY_STAGE_1_06);

                        events.RescheduleEvent(EVENT_SCENE_108, 800);
                        break;
                    }
                case EVENT_SCENE_108:
                    {
                        if( Creature* c = instance->GetCreature(NPC_JaraxxusGUID) )
                        {
                            c->AI()->Talk(SAY_STAGE_1_06_1);
                            if( Creature* f = instance->GetCreature(NPC_FizzlebangGUID) )
                            {
                                c->CastSpell(f, 67888, true);
                                Unit::Kill(f, f);
                            }
                        }

                        events.RescheduleEvent(EVENT_SCENE_109, 5000);
                        break;
                    }
                case EVENT_SCENE_109:
                    {
                        if( Creature* c = instance->GetCreature(NPC_JaraxxusGUID) )
                            c->SetFacingTo(3 * M_PI / 2);
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_1_07);

                        events.RescheduleEvent(EVENT_JARAXXUS_ATTACK, 6000);
                        break;
                    }
                case EVENT_JARAXXUS_ATTACK:
                    {
                        InstanceProgress = INSTANCE_PROGRESS_JARAXXUS_INTRO_DONE;
                        if( Creature* c = instance->GetCreature(NPC_JaraxxusGUID) )
                        {
                            c->SetReactState(REACT_AGGRESSIVE);
                            c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            if( Unit* target = c->SelectNearestTarget(200.0f) )
                            {
                                c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        }
                        break;
                    }
                case EVENT_SCENE_110:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_1_08);

                        events.RescheduleEvent(EVENT_SCENE_111, 18000);
                        break;
                    }
                case EVENT_SCENE_111:
                    {
                        if( Creature* c = instance->GetCreature(NPC_GarroshGUID) )
                            c->AI()->Talk(SAY_STAGE_1_09);

                        events.RescheduleEvent(EVENT_SCENE_112, 9000);
                        break;
                    }
                case EVENT_SCENE_112:
                    {
                        if( Creature* c = instance->GetCreature(NPC_VarianGUID) )
                            c->AI()->Talk(SAY_STAGE_1_10);

                        events.RescheduleEvent(EVENT_SCENE_113, 5000);
                        break;
                    }
                case EVENT_SCENE_113:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_1_11);
                        if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        break;
                    }
                case EVENT_SCENE_201:
                    {
                        // move Jaraxxus to side, can't remove corpse because of loot!
                        if( Creature* jaraxxus = instance->GetCreature(NPC_JaraxxusGUID) )
                        {
                            jaraxxus->UpdatePosition(613.83f, 139.5f, 395.22f, 3 * M_PI / 2, true);
                            jaraxxus->StopMovingOnCurrentPos();
                            jaraxxus->DestroyForNearbyPlayers();
                        }

                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_2_01);

                        events.RescheduleEvent(EVENT_SCENE_202, 9000);
                        break;
                    }
                case EVENT_SCENE_202:
                    {
                        Map::PlayerList const& pl = instance->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* plr = itr->GetSource() )
                                if( !plr->IsGameMaster() )
                                {
                                    TeamIdInInstance = plr->GetTeamId();
                                    break;
                                }

                        if( TeamIdInInstance == TEAM_ALLIANCE )
                        {
                            if( Creature* c = instance->GetCreature(NPC_GarroshGUID) )
                                c->AI()->Talk(SAY_STAGE_2_02h);
                            events.RescheduleEvent(EVENT_SCENE_203, 15000);
                        }
                        else
                        {
                            if( Creature* c = instance->GetCreature(NPC_VarianGUID) )
                                c->AI()->Talk(SAY_STAGE_2_02a);
                            events.RescheduleEvent(EVENT_SCENE_203, 18000);
                        }
                        break;
                    }
                case EVENT_SCENE_203:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_2_03);

                        events.RescheduleEvent(EVENT_SCENE_204, 5000);
                        break;
                    }
                case EVENT_SCENE_204:
                    {
                        if( TeamIdInInstance == TEAM_ALLIANCE )
                        {
                            if( Creature* c = instance->GetCreature(NPC_GarroshGUID) )
                                c->AI()->Talk(SAY_STAGE_2_04h);
                            events.RescheduleEvent(EVENT_SCENE_205, 6000);
                        }
                        else
                        {
                            if( Creature* c = instance->GetCreature(NPC_VarianGUID) )
                                c->AI()->Talk(SAY_STAGE_2_04a);
                            events.RescheduleEvent(EVENT_SCENE_205, 5000);
                        }

                        events.RescheduleEvent(EVENT_SUMMON_CHAMPIONS, 2500);
                        break;
                    }
                case EVENT_SCENE_205:
                    {
                        if( Creature* c = instance->GetCreature(TeamIdInInstance == TEAM_ALLIANCE ? NPC_VarianGUID : NPC_GarroshGUID) )
                            c->AI()->Talk(TeamIdInInstance == TEAM_ALLIANCE ? SAY_STAGE_2_05a : SAY_STAGE_2_05h);

                        break;
                    }
                case EVENT_SUMMON_CHAMPIONS:
                    {
                        std::vector<uint32> vHealerEntries;
                        vHealerEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_DRUID_RESTORATION : NPC_ALLIANCE_DRUID_RESTORATION);
                        vHealerEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_PALADIN_HOLY : NPC_ALLIANCE_PALADIN_HOLY);
                        vHealerEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_PRIEST_DISCIPLINE : NPC_ALLIANCE_PRIEST_DISCIPLINE);
                        vHealerEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_SHAMAN_RESTORATION : NPC_ALLIANCE_SHAMAN_RESTORATION);

                        std::vector<uint32> vOtherEntries;
                        vOtherEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_DEATH_KNIGHT : NPC_ALLIANCE_DEATH_KNIGHT);
                        vOtherEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_HUNTER : NPC_ALLIANCE_HUNTER);
                        vOtherEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_MAGE : NPC_ALLIANCE_MAGE);
                        vOtherEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_ROGUE : NPC_ALLIANCE_ROGUE);
                        vOtherEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_WARLOCK : NPC_ALLIANCE_WARLOCK);
                        vOtherEntries.push_back(TeamIdInInstance == TEAM_ALLIANCE ? NPC_HORDE_WARRIOR : NPC_ALLIANCE_WARRIOR);

                        uint8 healersSubtracted = 2;
                        if( instance->GetSpawnMode() == RAID_DIFFICULTY_25MAN_NORMAL || instance->GetSpawnMode() == RAID_DIFFICULTY_25MAN_HEROIC )
                            healersSubtracted = 1;
                        for( uint8 i = 0; i < healersSubtracted; ++i )
                        {
                            uint8 pos = urand(0, vHealerEntries.size() - 1);
                            switch( vHealerEntries[pos] )
                            {
                                case NPC_ALLIANCE_DRUID_RESTORATION:
                                    vOtherEntries.push_back(NPC_ALLIANCE_DRUID_BALANCE);
                                    break;
                                case NPC_HORDE_DRUID_RESTORATION:
                                    vOtherEntries.push_back(NPC_HORDE_DRUID_BALANCE);
                                    break;
                                case NPC_ALLIANCE_PALADIN_HOLY:
                                    vOtherEntries.push_back(NPC_ALLIANCE_PALADIN_RETRIBUTION);
                                    break;
                                case NPC_HORDE_PALADIN_HOLY:
                                    vOtherEntries.push_back(NPC_HORDE_PALADIN_RETRIBUTION);
                                    break;
                                case NPC_ALLIANCE_PRIEST_DISCIPLINE:
                                    vOtherEntries.push_back(NPC_ALLIANCE_PRIEST_SHADOW);
                                    break;
                                case NPC_HORDE_PRIEST_DISCIPLINE:
                                    vOtherEntries.push_back(NPC_HORDE_PRIEST_SHADOW);
                                    break;
                                case NPC_ALLIANCE_SHAMAN_RESTORATION:
                                    vOtherEntries.push_back(NPC_ALLIANCE_SHAMAN_ENHANCEMENT);
                                    break;
                                case NPC_HORDE_SHAMAN_RESTORATION:
                                    vOtherEntries.push_back(NPC_HORDE_SHAMAN_ENHANCEMENT);
                                    break;
                            }
                            vHealerEntries.erase(vHealerEntries.begin() + pos);
                        }

                        if( instance->GetSpawnMode() == RAID_DIFFICULTY_10MAN_NORMAL || instance->GetSpawnMode() == RAID_DIFFICULTY_10MAN_HEROIC )
                            for( uint8 i = 0; i < 4; ++i )
                                vOtherEntries.erase(vOtherEntries.begin() + urand(0, vOtherEntries.size() - 1));

                        for( std::vector<uint32>::iterator itr = vHealerEntries.begin(); itr != vHealerEntries.end(); ++itr )
                            vOtherEntries.push_back(*itr);

                        uint8 pos2 = 10;
                        for( std::vector<uint32>::iterator itr = vOtherEntries.begin(); itr != vOtherEntries.end(); ++itr )
                        {
                            if( Creature* pTemp = instance->SummonCreature(*itr, FactionChampionLoc[urand(0, 4) + (TeamIdInInstance == TEAM_ALLIANCE ? 0 : 5)]) )
                            {
                                NPC_ChampionGUIDs.push_back(pTemp->GetGUID());
                                pTemp->SetHomePosition((TeamIdInInstance == TEAM_ALLIANCE ? FactionChampionLoc[pos2].GetPositionX() : (Locs[LOC_CENTER].GetPositionX() * 2 - FactionChampionLoc[pos2].GetPositionX())), FactionChampionLoc[pos2].GetPositionY(), FactionChampionLoc[pos2].GetPositionZ(), 0.0f);
                                pTemp->GetMotionMaster()->MoveJump((TeamIdInInstance == TEAM_ALLIANCE ? FactionChampionLoc[pos2].GetPositionX() : (Locs[LOC_CENTER].GetPositionX() * 2 - FactionChampionLoc[pos2].GetPositionX())), FactionChampionLoc[pos2].GetPositionY(), FactionChampionLoc[pos2].GetPositionZ(), 20.0f, 20.0f);
                            }
                            ++pos2;
                        }

                        HandleGameObject(GO_EnterGateGUID, false);
                        events.RescheduleEvent(EVENT_CHAMPIONS_ATTACK, 4000);
                        break;
                    }
                case EVENT_CHAMPIONS_ATTACK:
                    {
                        for (ObjectGuid const& guid : NPC_ChampionGUIDs)
                            if (Creature* c = instance->GetCreature(guid))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                //if( Unit* target = c->SelectNearestTarget(200.0f) )
                                //  c->AI()->AttackStart(target);
                            }
                        Map::PlayerList const& pl = instance->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            itr->GetSource()->AddToNotify(NOTIFY_AI_RELOCATION);
                        EncounterStatus = IN_PROGRESS;
                        break;
                    }
                case EVENT_SCENE_FACTION_CHAMPIONS_DEAD:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_2_06);
                        if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        break;
                    }
                case EVENT_SCENE_301:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_3_01);

                        events.RescheduleEvent(EVENT_SCENE_302, 13000);
                        break;
                    }
                case EVENT_SCENE_302:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_3_02);

                        events.RescheduleEvent(EVENT_SCENE_303, 3000);
                        break;
                    }
                case EVENT_SCENE_303:
                    {
                        HandleGameObject(GO_EnterGateGUID, false);
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                        {
                            HandleGameObject(GO_MainGateGUID, true);
                            if( Creature* t = c->SummonCreature(NPC_LIGHTBANE, Locs[LOC_VALKYR_RIGHT].GetPositionX(), Locs[LOC_VALKYR_RIGHT].GetPositionY(), Locs[LOC_VALKYR_RIGHT].GetPositionZ(), Locs[LOC_VALKYR_RIGHT].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000) )
                                t->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_RIGHT].GetPositionX(), Locs[LOC_VALKYR_DEST_RIGHT].GetPositionY(), Locs[LOC_VALKYR_DEST_RIGHT].GetPositionZ());
                            if( Creature* t = c->SummonCreature(NPC_DARKBANE, Locs[LOC_VALKYR_LEFT].GetPositionX(), Locs[LOC_VALKYR_LEFT].GetPositionY(), Locs[LOC_VALKYR_LEFT].GetPositionZ(), Locs[LOC_VALKYR_LEFT].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000) )
                                t->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_LEFT].GetPositionX(), Locs[LOC_VALKYR_DEST_LEFT].GetPositionY(), Locs[LOC_VALKYR_DEST_LEFT].GetPositionZ());
                        }

                        events.RescheduleEvent(EVENT_SCENE_304, 6250);
                        break;
                    }
                case EVENT_SCENE_304:
                    {
                        HandleGameObject(GO_MainGateGUID, false);
                        EncounterStatus = IN_PROGRESS;
                        if( Creature* c = instance->GetCreature(NPC_LightbaneGUID) )
                            c->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_2_RIGHT].GetPositionX(), Locs[LOC_VALKYR_DEST_2_RIGHT].GetPositionY(), Locs[LOC_VALKYR_DEST_2_RIGHT].GetPositionZ());
                        if( Creature* c = instance->GetCreature(NPC_DarkbaneGUID) )
                            c->GetMotionMaster()->MovePoint(0, Locs[LOC_VALKYR_DEST_2_LEFT].GetPositionX(), Locs[LOC_VALKYR_DEST_2_LEFT].GetPositionY(), Locs[LOC_VALKYR_DEST_2_LEFT].GetPositionZ());

                        events.RescheduleEvent(EVENT_VALKYRIES_ATTACK, 3250);
                        break;
                    }
                case EVENT_VALKYRIES_ATTACK:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LightbaneGUID) )
                        {
                            c->SetReactState(REACT_AGGRESSIVE);
                            c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            /*if( Unit* target = c->SelectNearestTarget(200.0f) )
                            {
                                c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }*/
                        }
                        if( Creature* c = instance->GetCreature(NPC_DarkbaneGUID) )
                        {
                            c->SetReactState(REACT_AGGRESSIVE);
                            c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            /*if( Unit* target = c->SelectNearestTarget(200.0f) )
                            {
                                c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }*/
                        }
                        break;
                    }
                case EVENT_SCENE_VALKYR_DEAD:
                    {
                        if (TeamIdInInstance == TEAM_NEUTRAL)
                        {
                            Map::PlayerList const& pl = instance->GetPlayers();
                            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                if( Player* plr = itr->GetSource() )
                                    if( !plr->IsGameMaster() )
                                    {
                                        TeamIdInInstance = plr->GetTeamId();
                                        break;
                                    }
                        }
                        if( Creature* c = instance->GetCreature(TeamIdInInstance == TEAM_ALLIANCE ? NPC_VarianGUID : NPC_GarroshGUID) )
                            c->AI()->Talk((TeamIdInInstance == TEAM_ALLIANCE ? SAY_STAGE_3_03a : SAY_STAGE_3_03h));

                        events.RescheduleEvent(EVENT_SCENE_401, 60000);
                        break;
                    }
                case EVENT_SCENE_401:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_4_01);

                        events.RescheduleEvent(EVENT_SCENE_402, 20000);
                        break;
                    }
                case EVENT_SCENE_402:
                    {
                        HandleGameObject(GO_EnterGateGUID, false);
                        EncounterStatus = IN_PROGRESS;
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            if( Creature* t = c->SummonCreature(NPC_LICH_KING, Locs[LOC_ARTHAS_PORTAL]) )
                            {
                                t->SetReactState(REACT_PASSIVE);
                                t->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                t->SetDisplayId(11686);
                                t->AI()->Talk(SAY_STAGE_4_02);
                                t->SetVisible(false);
                            }

                        events.RescheduleEvent(EVENT_SCENE_403, 2000);
                        break;
                    }
                case EVENT_SCENE_403:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            if( Creature* t = c->SummonCreature(NPC_WORLD_TRIGGER, Locs[LOC_ARTHAS_PORTAL], TEMPSUMMON_TIMED_DESPAWN, 60000) )
                            {
                                t->SetReactState(REACT_PASSIVE);
                                t->CastSpell(t, 51807, true);
                            }

                        events.RescheduleEvent(EVENT_SCENE_404, 2000);
                        break;
                    }
                case EVENT_SCENE_404:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                        {
                            c->SetDisplayId(c->GetNativeDisplayId());
                            c->SetVisible(true);
                            c->GetMotionMaster()->MovePoint(0, Locs[LOC_ARTHAS]);
                        }

                        events.RescheduleEvent(EVENT_SCENE_405, 3000);
                        break;
                    }
                case EVENT_SCENE_405:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                            c->AI()->Talk(SAY_STAGE_4_03);

                        events.RescheduleEvent(EVENT_SCENE_406, 7000);
                        break;
                    }
                case EVENT_SCENE_406:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                        {
                            c->AI()->Talk(SAY_STAGE_4_04);
                            c->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                        }

                        events.RescheduleEvent(EVENT_SCENE_406_2, 2500);
                        events.RescheduleEvent(EVENT_SCENE_407, 12000);
                        break;
                    }
                case EVENT_SCENE_406_2:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                        {
                            c->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                        }

                        break;
                    }

                case EVENT_SCENE_407:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                            c->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);

                        events.RescheduleEvent(EVENT_SCENE_408, 4000);
                        break;
                    }
                case EVENT_SCENE_408:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                        {
                            c->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                        }

                        events.RescheduleEvent(EVENT_SCENE_409, 1500);
                        break;
                    }
                case EVENT_SCENE_409:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                        {
                            if( GameObject* floor = instance->GetGameObject(GO_FloorGUID) )
                                floor->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);//floor->ModifyHealth(-10000000, c);
                            c->CastSpell((Unit*)nullptr, 68193, true);
                            c->SetVisible(false);
                            c->SetDisplayId(11686);
                            if( Creature* t = c->FindNearestCreature(NPC_WORLD_TRIGGER, 500.0f, true) )
                                t->DespawnOrUnsummon();

                            InstanceProgress = INSTANCE_PROGRESS_ANUB_ARAK;
                            SpawnAnubArak();
                        }

                        events.RescheduleEvent(EVENT_SCENE_410, 2000);
                        break;
                    }
                case EVENT_SCENE_410:
                    {
                        if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                        {
                            c->SetVisible(true);
                            c->AI()->Talk(SAY_STAGE_4_05);
                            c->DespawnOrUnsummon(0);
                        }

                        break;
                    }
                case EVENT_SCENE_501:
                    {
                        if( Creature* c = instance->GetCreature(NPC_TirionGUID) )
                        {
                            c->AI()->Talk(SAY_STAGE_4_06);
                            c->SummonCreature(NPC_ARGENT_MAGE, Locs[LOC_MAGE].GetPositionX(), Locs[LOC_MAGE].GetPositionY(), Locs[LOC_MAGE].GetPositionZ(), Locs[LOC_MAGE].GetOrientation());
                            c->SummonGameObject(195682, 668.15f, 134.57f, 142.12f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 630000000);
                        }

                        events.RescheduleEvent(EVENT_SCENE_502, 20000);
                        break;
                    }
                case EVENT_SCENE_502:
                    {
                        if( instance->IsHeroic() )
                        {
                            uint32 tributeChest = 0;
                            if( instance->GetSpawnMode() == RAID_DIFFICULTY_10MAN_HEROIC )
                            {
                                if (AttemptsLeft >= 50)
                                    tributeChest = GO_TRIBUTE_CHEST_10H_99;
                                else if (AttemptsLeft >= 45)
                                    tributeChest = GO_TRIBUTE_CHEST_10H_50;
                                else if (AttemptsLeft >= 25)
                                    tributeChest = GO_TRIBUTE_CHEST_10H_45;
                                else
                                    tributeChest = GO_TRIBUTE_CHEST_10H_25;
                            }
                            else if( instance->GetSpawnMode() == RAID_DIFFICULTY_25MAN_HEROIC )
                            {
                                if (AttemptsLeft >= 50)
                                    tributeChest = GO_TRIBUTE_CHEST_25H_99;
                                else if (AttemptsLeft >= 45)
                                    tributeChest = GO_TRIBUTE_CHEST_25H_50;
                                else if (AttemptsLeft >= 25)
                                    tributeChest = GO_TRIBUTE_CHEST_25H_45;
                                else
                                    tributeChest = GO_TRIBUTE_CHEST_25H_25;
                            }
                            if (tributeChest)
                                if (Creature* c = instance->GetCreature(NPC_TirionGUID))
                                {
                                    c->AI()->Talk(SAY_STAGE_4_07);
                                    if (GameObject* chest = c->SummonGameObject(tributeChest, 665.12f, 143.78f, 142.12f, 0.0f, 0, 0, 0, 0, 90000000))
                                    {
                                        chest->SetRespawnTime(chest->GetRespawnDelay());
                                        chest->SetLootRecipient(instance);
                                    }
                                }
                        }
                        break;
                    }
            }
        }

        void OnPlayerEnter(Player* plr) override
        {
            if( instance->IsHeroic() )
            {
                plr->SendUpdateWorldState(UPDATE_STATE_UI_SHOW, 1);
                plr->SendUpdateWorldState(UPDATE_STATE_UI_COUNT, AttemptsLeft);
            }
            else
                plr->SendUpdateWorldState(UPDATE_STATE_UI_SHOW, 0);

            if (DoNeedCleanup(plr))
            {
                InstanceCleanup();
            }

            // if missing spawn anub'arak
            SpawnAnubArak();

            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
        }

        bool DoNeedCleanup(Player* ignoredPlayer = nullptr)
        {
            uint8 aliveCount = 0;
            for (auto const& itr: instance->GetPlayers())
            {
                if (Player* plr = itr.GetSource())
                {
                    if (plr != ignoredPlayer && plr->IsAlive() && !plr->IsGameMaster())
                    {
                        ++aliveCount;
                    }
                }
            }

            bool need = aliveCount == 0;
            if (!need && CLEANED)
            {
                CLEANED = false;
            }

            return need;
        }

        void InstanceCleanup(bool fromFailed = false)
        {
            if( CLEANED )
                return;
            CLEANED = true;

            switch( InstanceProgress )
            {
                case INSTANCE_PROGRESS_INITIAL:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                        c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    break;
                case INSTANCE_PROGRESS_INTRO_DONE:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                        c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    if( Creature* c = instance->GetCreature(NPC_GormokGUID) )
                    {
                        c->AI()->DoAction(-1); // despawn summons
                        c->DespawnOrUnsummon();
                    }
                    NPC_GormokGUID.Clear();
                    if( Creature* c = instance->GetCreature(NPC_AcidmawGUID) )
                        c->DespawnOrUnsummon();
                    NPC_AcidmawGUID.Clear();
                    if( Creature* c = instance->GetCreature(NPC_DreadscaleGUID) )
                        c->DespawnOrUnsummon();
                    NPC_DreadscaleGUID.Clear();
                    if( Creature* c = instance->GetCreature(NPC_IcehowlGUID) )
                        c->DespawnOrUnsummon();
                    NPC_IcehowlGUID.Clear();
                    northrendBeastsMask = 0;
                    break;
                case INSTANCE_PROGRESS_BEASTS_DEAD:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                        c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    if( Creature* c = instance->GetCreature(NPC_FizzlebangGUID) )
                        c->DespawnOrUnsummon();
                    NPC_FizzlebangGUID.Clear();
                    if( Creature* c = instance->GetCreature(NPC_JaraxxusGUID) )
                        c->DespawnOrUnsummon();
                    NPC_JaraxxusGUID.Clear();
                    if( Creature* c = instance->GetCreature(NPC_PurpleGroundGUID) )
                        c->DespawnOrUnsummon();
                    NPC_PurpleGroundGUID.Clear();
                    if( Creature* c = instance->GetCreature(NPC_PortalGUID) )
                        c->DespawnOrUnsummon();
                    NPC_PortalGUID.Clear();
                    break;
                case INSTANCE_PROGRESS_JARAXXUS_INTRO_DONE:
                    if( Creature* c = instance->GetCreature(NPC_JaraxxusGUID) )
                        c->DespawnOrUnsummon();
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                    {
                        c->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        if( Creature* jaraxxus = c->SummonCreature(NPC_JARAXXUS, Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY(), Locs[LOC_CENTER].GetPositionZ(), Locs[LOC_CENTER].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 630000000) )
                        {
                            jaraxxus->CastSpell(jaraxxus, 67924, true);
                            jaraxxus->SetReactState(REACT_AGGRESSIVE);
                            jaraxxus->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            jaraxxus->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        }
                    }
                    break;
                case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                        c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    for (ObjectGuid const& guid : NPC_ChampionGUIDs)
                        if (Creature* c = instance->GetCreature(guid))
                            c->DespawnOrUnsummon();
                    NPC_ChampionGUIDs.clear();
                    break;
                case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                        c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    if( Creature* c = instance->GetCreature(NPC_DarkbaneGUID) )
                    {
                        c->AI()->DoAction(-1);
                        c->DespawnOrUnsummon();
                    }
                    NPC_DarkbaneGUID.Clear();
                    if( Creature* c = instance->GetCreature(NPC_LightbaneGUID) )
                    {
                        c->AI()->DoAction(-1);
                        c->DespawnOrUnsummon();
                    }
                    NPC_LightbaneGUID.Clear();
                    break;
                case INSTANCE_PROGRESS_VALKYR_DEAD:
                case INSTANCE_PROGRESS_ANUB_ARAK:
                    /*if( GameObject* floor = instance->GetGameObject(GO_FloorGUID) )
                        floor->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);*/
                    if (Creature* c = instance->GetCreature(NPC_BarrettGUID))
                    {
                        if (InstanceProgress == INSTANCE_PROGRESS_ANUB_ARAK)
                        {
                            c->SetVisible(false);
                            c->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        }
                        else
                        {
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                            c->SetVisible(true);
                            c->SetFacingTo(c->GetOrientation());
                        }
                        if (Creature* t = c->FindNearestCreature(NPC_WORLD_TRIGGER, 500.0f, true))
                            t->DespawnOrUnsummon();
                    }
                    if( Creature* c = instance->GetCreature(NPC_LichKingGUID) )
                        c->DespawnOrUnsummon();
                    NPC_LichKingGUID.Clear();

                    if( Creature* c = instance->GetCreature(NPC_AnubarakGUID) )
                    {
                        c->AI()->DoAction(-1);
                        c->DespawnOrUnsummon();
                    }
                    NPC_AnubarakGUID.Clear();

                    break;
                case INSTANCE_PROGRESS_DONE:
                    if( GameObject* floor = instance->GetGameObject(GO_FloorGUID) )
                        floor->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                    {
                        c->SetVisible(false);
                        c->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    }
                    break;
            }

            if (instance->IsHeroic() && AttemptsLeft > 0 && !fromFailed && EncounterStatus == IN_PROGRESS)
            {
                --AttemptsLeft;
                Map::PlayerList const& pl = instance->GetPlayers();
                for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                    if( Player* plr = itr->GetSource() )
                        plr->SendUpdateWorldState(UPDATE_STATE_UI_COUNT, AttemptsLeft);
            }

            if( instance->IsHeroic() && AttemptsLeft == 0 )
                if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                    c->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            HandleGameObject(GO_MainGateGUID, false);
            HandleGameObject(GO_EnterGateGUID, true);
            HandleGameObject(GO_WebDoorGUID, true);
            Counter = 0;
            EncounterStatus = NOT_STARTED;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> InstanceProgress;

            if (instance->IsHeroic())
            {
                data >> AttemptsLeft;
                uint32 temp = 0;
                data >> temp;
                bDedicatedInsanity = !!temp;
                data >> temp;
                bNooneDied = !!temp;
            }
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << InstanceProgress;

            if (instance->IsHeroic())
            {
                data << ' '
                    << AttemptsLeft << ' '
                    << (bDedicatedInsanity ? 1 : 0) << ' '
                    << (bNooneDied ? 1 : 0);
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                case ACHIEV_CRITERIA_UPPER_BACK_PAIN_10_N:
                case ACHIEV_CRITERIA_UPPER_BACK_PAIN_10_H:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                    {
                        std::list<Creature*> L;
                        uint8 count = 0;
                        c->GetCreaturesWithEntryInRange(L, 200.0f, 34800); // find all snobolds
                        for( std::list<Creature*>::const_iterator itr = L.begin(); itr != L.end(); ++itr )
                            if( (*itr)->GetVehicle() )
                                ++count;
                        return (count >= 2);
                    }
                    break;
                case ACHIEV_CRITERIA_UPPER_BACK_PAIN_25_N:
                case ACHIEV_CRITERIA_UPPER_BACK_PAIN_25_H:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                    {
                        std::list<Creature*> L;
                        uint8 count = 0;
                        c->GetCreaturesWithEntryInRange(L, 200.0f, 34800); // find all snobolds
                        for( std::list<Creature*>::const_iterator itr = L.begin(); itr != L.end(); ++itr )
                            if( (*itr)->GetVehicle() )
                                ++count;
                        return (count >= 4);
                    }
                    break;
                case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_10_N:
                case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_10_H:
                case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_25_N:
                case ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_25_H:
                    if( Creature* c = instance->GetCreature(NPC_BarrettGUID) )
                    {
                        std::list<Creature*> L;
                        uint8 count = 0;
                        c->GetCreaturesWithEntryInRange(L, 200.0f, 34826); // find all mistress of pain
                        for( std::list<Creature*>::const_iterator itr = L.begin(); itr != L.end(); ++itr )
                            if( (*itr)->IsAlive() )
                                ++count;
                        return (count >= 2);
                    }
                    break;
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_SKILL_10_PLAYER:
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_SKILL_25_PLAYER:
                    return AttemptsLeft >= 25;
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_MAD_SKILL_10_PLAYER:
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_MAD_SKILL_25_PLAYER:
                    return AttemptsLeft >= 45;
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_INSANITY_10_PLAYER:
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_INSANITY_25_PLAYER:
                case ACHIEV_CRITERIA_REALM_FIRST_GRAND_CRUSADER:
                    return AttemptsLeft == 50;
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_IMMORTALITY_HORDE:
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_IMMORTALITY_ALLIANCE:
                    return AttemptsLeft == 50 && bNooneDied;
                case ACHIEV_CRITERIA_A_TRIBUTE_TO_DEDICATED_INSANITY:
                    return AttemptsLeft == 50 && bDedicatedInsanity;
            }
            return false;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_trial_of_the_crusader_InstanceMapScript(map);
    }
};

void AddSC_instance_trial_of_the_crusader()
{
    new instance_trial_of_the_crusader();
}
