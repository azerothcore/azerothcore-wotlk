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

#include "CellImpl.h"
#include "Chat.h"
#include "CreatureScript.h"
#include "GameEventMgr.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GridNotifiersImpl.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Spell.h"
#include "WorldSession.h"

// Ours
/*######
## go_noblegarden_colored_egg
######*/
class go_noblegarden_colored_egg : public GameObjectScript
{
public:
    go_noblegarden_colored_egg() : GameObjectScript("go_noblegarden_colored_egg") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (roll_chance_i(5))
            player->CastSpell(player, 61734, true); // SPELL NOBLEGARDEN BUNNY
        return false;
    }
};

class go_seer_of_zebhalak : public GameObjectScript
{
public:
    go_seer_of_zebhalak() : GameObjectScript("go_seer_of_zebhalak") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (player->GetQuestStatus(12007) == QUEST_STATUS_INCOMPLETE)
            player->CastSpell(player, 47293, true);
        return true;
    }
};

class go_mistwhisper_treasure : public GameObjectScript
{
public:
    go_mistwhisper_treasure() : GameObjectScript("go_mistwhisper_treasure") { }

    bool OnGossipHello(Player* pPlayer, GameObject* go) override
    {
        if (!go->FindNearestCreature(28105, 30.0f)) // Tartek
        {
            if (Creature* cr = go->SummonCreature(28105, 6708.7f, 5115.45f, -18.3f, 0.7f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
            {
                cr->Yell("My treasure! You no steal from Tartek, dumb big-tongue traitor thing. Tartek and nasty dragon going to kill you! You so dumb.", LANG_UNIVERSAL);
                cr->AI()->AttackStart(pPlayer);
            }
        }
        return false;
    }
};

class go_witherbark_totem_bundle : public GameObjectScript
{
public:
    go_witherbark_totem_bundle() : GameObjectScript("go_witherbark_totem_bundle") { }

    struct go_witherbark_totem_bundleAI : public GameObjectAI
    {
        go_witherbark_totem_bundleAI(GameObject* gameObject) : GameObjectAI(gameObject)
        {
            _timer = 1;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_timer)
            {
                _timer += diff;
                if (_timer > 5000)
                {
                    me->CastSpell(nullptr, 9056);
                    me->DestroyForNearbyPlayers();
                    _timer = 0;
                }
            }
        }

        uint32 _timer;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_witherbark_totem_bundleAI(go);
    }
};

class go_arena_ready_marker : public GameObjectScript
{
public:
    go_arena_ready_marker() : GameObjectScript("go_arena_ready_marker") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (Battleground* bg = player->GetBattleground())
            bg->ReadyMarkerClicked(player);

        return false;
    }
};

/*######
## go_ethereum_prison
######*/

enum EthereumPrison
{
    SPELL_REP_LC        = 39456,
    SPELL_REP_SHAT      = 39457,
    SPELL_REP_CE        = 39460,
    SPELL_REP_CON       = 39474,
    SPELL_REP_KT        = 39475,
    SPELL_REP_SPOR      = 39476
};

const uint32 NpcPrisonEntry[] =
{
    22810, 22811, 22812, 22813, 22814, 22815,               //good guys
    20783, 20784, 20785, 20786, 20788, 20789, 20790         //bad guys
};

class go_ethereum_prison : public GameObjectScript
{
public:
    go_ethereum_prison() : GameObjectScript("go_ethereum_prison") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        int Random = rand() % (sizeof(NpcPrisonEntry) / sizeof(uint32));

        if (Creature* creature = player->SummonCreature(NpcPrisonEntry[Random], go->GetPositionX(), go->GetPositionY(), go->GetPositionZ(), go->GetAngle(player),
                                 TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
        {
            if (!creature->IsHostileTo(player))
            {
                uint32 Spell = 0;

                switch (creature->GetEntry())
                {
                    case 22811:
                        Spell = SPELL_REP_LC;
                        break;
                    case 22812:
                        Spell = SPELL_REP_SHAT;
                        break;
                    case 22810:
                        Spell = SPELL_REP_CE;
                        break;
                    case 22813:
                        Spell = SPELL_REP_CON;
                        break;
                    case 22815:
                        Spell = SPELL_REP_KT;
                        break;
                    case 22814:
                        Spell = SPELL_REP_SPOR;
                        break;
                }

                if (Spell)
                    creature->CastSpell(player, Spell, false);
            }
        }

        return false;
    }
};

/*######
## go_ethereum_stasis
######*/

const uint32 NpcStasisEntry[] =
{
    22825, 20888, 22827, 22826, 22828
};

class go_ethereum_stasis : public GameObjectScript
{
public:
    go_ethereum_stasis() : GameObjectScript("go_ethereum_stasis") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        int Random = rand() % (sizeof(NpcStasisEntry) / sizeof(uint32));

        player->SummonCreature(NpcStasisEntry[Random], go->GetPositionX(), go->GetPositionY(), go->GetPositionZ(), go->GetAngle(player),
                               TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);

        return false;
    }
};

/*######
## go_resonite_cask
######*/

enum ResoniteCask
{
    NPC_GOGGEROC    = 11920
};

class go_resonite_cask : public GameObjectScript
{
public:
    go_resonite_cask() : GameObjectScript("go_resonite_cask") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        // xinef: prevent spawning hundreds of them
        if (go->GetGoType() == GAMEOBJECT_TYPE_GOOBER && !go->FindNearestCreature(NPC_GOGGEROC, 20.0f))
            go->SummonCreature(NPC_GOGGEROC, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);

        return false;
    }
};

/*######
## Quest 11560: Oh Noes, the Tadpoles!
## go_tadpole_cage
######*/

enum Tadpoles
{
    QUEST_OH_NOES_THE_TADPOLES                    = 11560,
    NPC_WINTERFIN_TADPOLE                         = 25201
};

class go_tadpole_cage : public GameObjectScript
{
public:
    go_tadpole_cage() : GameObjectScript("go_tadpole_cage") { }

    struct go_tadpole_cageAI : public GameObjectAI
    {
        go_tadpole_cageAI(GameObject* gameObject) : GameObjectAI(gameObject)
        {
            requireSummon = 2;
        }

        uint8 requireSummon;

        void SummonTadpoles()
        {
            requireSummon = 0;
            int8 count = urand(1, 3);
            for (int8 i = 0; i < count; ++i)
                me->SummonCreature(NPC_WINTERFIN_TADPOLE, me->GetPositionX() + cos(2 * M_PI * i / 3.0f) * 0.60f, me->GetPositionY() + std::sin(2 * M_PI * i / 3.0f) * 0.60f, me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
        }

        void OnStateChanged(uint32 state, Unit*  /*unit*/) override
        {
            if (requireSummon == 1 && state == GO_READY)
                requireSummon = 2;
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (me->isSpawned() && requireSummon == 2)
                SummonTadpoles();
        }

        bool GossipHello(Player* player, bool  /*reportUse*/) override
        {
            if (requireSummon)
                return false;

            requireSummon = 1;
            if (player->GetQuestStatus(QUEST_OH_NOES_THE_TADPOLES) == QUEST_STATUS_INCOMPLETE)
            {
                std::list<Creature*> cList;
                GetCreatureListWithEntryInGrid(cList, me, NPC_WINTERFIN_TADPOLE, 5.0f);
                for (std::list<Creature*>::const_iterator itr = cList.begin(); itr != cList.end(); ++itr)
                {
                    player->KilledMonsterCredit(NPC_WINTERFIN_TADPOLE);
                    (*itr)->DespawnOrUnsummon(urand(45000, 60000));
                    (*itr)->GetMotionMaster()->MoveFollow(player, 1.0f, frand(0.0f, 2 * M_PI), MOTION_SLOT_CONTROLLED);
                }
            }
            return false;
        }
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_tadpole_cageAI(go);
    }
};

enum Flames
{
    SPELL_FLAMES = 7897
};

class go_flames : public GameObjectScript
{
public:
    go_flames() : GameObjectScript("go_flames") { }

    struct go_flamesAI : public GameObjectAI
    {
        go_flamesAI(GameObject* gameObject) : GameObjectAI(gameObject),
            timer { 0 }
        { }

        void UpdateAI(uint32  diff) override
        {
            timer += diff;
            if (timer > 3000)
            {
                timer = 0;
                std::list<Player*> players;
                Acore::AnyPlayerExactPositionInGameObjectRangeCheck checker(me, 0.3f);
                Acore::PlayerListSearcher<Acore::AnyPlayerExactPositionInGameObjectRangeCheck> searcher(me, players, checker);
                Cell::VisitWorldObjects(me, searcher, 0.3f);

                if (players.size() > 0)
                {
                    std::list<Player*>::iterator itr = players.begin();
                    std::advance(itr, urand(0, players.size() - 1));
                    if (Creature* trigger = me->SummonTrigger((*itr)->GetPositionX(), (*itr)->GetPositionY(), (*itr)->GetPositionZ(), 0, 2000, true))
                        trigger->CastSpell(trigger, SPELL_FLAMES);
                }
            }
        }

    private:
        uint32 timer;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_flamesAI(go);
    }
};

enum Heat
{
    SPELL_HEAT = 7902
};

class go_heat : public GameObjectScript
{
public:
    go_heat() : GameObjectScript("go_heat") { }

    struct go_heatAI : public GameObjectAI
    {
        go_heatAI(GameObject* gameObject) : GameObjectAI(gameObject),
            timer { 0 }
        { }

        void UpdateAI(uint32  diff) override
        {
            timer += diff;
            if (timer > 3000)
            {
                timer = 0;
                std::list<Player*> players;
                Acore::AnyPlayerExactPositionInGameObjectRangeCheck checker(me, 0.3f);
                Acore::PlayerListSearcher<Acore::AnyPlayerExactPositionInGameObjectRangeCheck> searcher(me, players, checker);
                Cell::VisitWorldObjects(me, searcher, 0.3f);

                if (players.size() > 0)
                {
                    std::list<Player*>::iterator itr = players.begin();
                    std::advance(itr, urand(0, players.size() - 1));
                    if (Creature* trigger = me->SummonTrigger((*itr)->GetPositionX(), (*itr)->GetPositionY(), (*itr)->GetPositionZ(), 0, 2000, true))
                        trigger->CastSpell(trigger, SPELL_HEAT);
                }
            }
        }

    private:
        uint32 timer;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_heatAI(go);
    }
};

enum eBearTrap
{
    EVENT_CHECK                     = 1,
    NPC_RABID_THISTLE_BEAR          = 2164,
    SPELL_BEAR_CAPTURED_IN_TRAP     = 9439
};

class go_bear_trap : public GameObjectScript
{
public:
    go_bear_trap() : GameObjectScript("go_bear_trap") {}

    struct go_bear_trapAI : public GameObjectAI
    {
        go_bear_trapAI(GameObject* gameObject) : GameObjectAI(gameObject)
        {
            Initialize();
        }

        void Initialize()
        {
            _events.ScheduleEvent(EVENT_CHECK, 1000);
        }

        void UpdateAI(uint32 const diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CHECK:
                    {
                        if (Creature* bear = me->FindNearestCreature(NPC_RABID_THISTLE_BEAR, 1.0f))
                        {
                            bear->CastSpell(bear, SPELL_BEAR_CAPTURED_IN_TRAP);
                            me->RemoveFromWorld();
                        }
                        else
                        {
                            _events.ScheduleEvent(EVENT_CHECK, 1000);
                        }
                        break;
                    }
                    default:
                        break;
                }
            }
        }
    private:
        EventMap _events;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_bear_trapAI(go);
    }
};

/*####
## go_l70_etc_music
####*/
enum L70ETCMusic
{
    MUSIC_L70_ETC_MUSIC = 11803
};

enum L70ETCMusicEvents
{
    EVENT_ETC_START_MUSIC = 1
};

class go_l70_etc_music : public GameObjectScript
{
public:
    go_l70_etc_music() : GameObjectScript("go_l70_etc_music") { }

    struct go_l70_etc_musicAI : public GameObjectAI
    {
        go_l70_etc_musicAI(GameObject* go) : GameObjectAI(go)
        {
            _events.ScheduleEvent(EVENT_ETC_START_MUSIC, 1600);
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_ETC_START_MUSIC:
                    me->PlayDirectMusic(MUSIC_L70_ETC_MUSIC);
                    _events.ScheduleEvent(EVENT_ETC_START_MUSIC, 1600);  // Every 1.6 seconds SMSG_PLAY_MUSIC packet (PlayDirectMusic) is pushed to the client (sniffed value)
                    break;
                default:
                    break;
                }
            }
        }
    private:
        EventMap _events;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_l70_etc_musicAI(go);
    }
};

// Theirs
/*####
## go_brewfest_music
####*/

enum BrewfestMusic
{
    EVENT_BREWFESTDWARF01 = 11810, // 1.35 min
    EVENT_BREWFESTDWARF02 = 11812, // 1.55 min
    EVENT_BREWFESTDWARF03 = 11813, // 0.23 min
    EVENT_BREWFESTGOBLIN01 = 11811, // 1.08 min
    EVENT_BREWFESTGOBLIN02 = 11814, // 1.33 min
    EVENT_BREWFESTGOBLIN03 = 11815 // 0.28 min
};

// These are in seconds
enum BrewfestMusicTime
{
    EVENT_BREWFESTDWARF01_TIME = 95000,
    EVENT_BREWFESTDWARF02_TIME = 155000,
    EVENT_BREWFESTDWARF03_TIME = 23000,
    EVENT_BREWFESTGOBLIN01_TIME = 68000,
    EVENT_BREWFESTGOBLIN02_TIME = 93000,
    EVENT_BREWFESTGOBLIN03_TIME = 28000
};

enum BrewfestMusicAreas
{
    SILVERMOON = 3430, // Horde
    UNDERCITY = 1497,
    ORGRIMMAR_1 = 1296,
    ORGRIMMAR_2 = 14,
    THUNDERBLUFF = 1638,
    IRONFORGE_1 = 809, // Alliance
    IRONFORGE_2 = 1,
    STORMWIND = 12,
    EXODAR = 3557,
    DARNASSUS = 1657,
    SHATTRATH = 3703 // General
};

enum BrewfestMusicEvents
{
    EVENT_BM_SELECT_MUSIC = 1,
    EVENT_BM_START_MUSIC = 2
};

class go_brewfest_music : public GameObjectScript
{
public:
    go_brewfest_music() : GameObjectScript("go_brewfest_music") { }

    struct go_brewfest_musicAI : public GameObjectAI
    {
        go_brewfest_musicAI(GameObject* go) : GameObjectAI(go)
        {
            _events.ScheduleEvent(EVENT_BM_SELECT_MUSIC, 1000);
            _events.ScheduleEvent(EVENT_BM_START_MUSIC, 1500);
            _currentMusicEvent = EVENT_BREWFESTGOBLIN01;
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_BM_SELECT_MUSIC:
                        {
                            if (!IsHolidayActive(HOLIDAY_BREWFEST)) // Check if Brewfest is active
                                break;
                            // Select random music sample
                            uint32 rnd = urand(0, 2);
                            uint32 musicTime = 1000;
                            //Restart the current selected music
                            _currentMusicEvent = 0;
                            //Check zone to play correct music
                            if (me->GetAreaId() == SILVERMOON || me->GetAreaId() == UNDERCITY || me->GetAreaId() == ORGRIMMAR_1 || me->GetAreaId() == ORGRIMMAR_2 || me->GetAreaId() == THUNDERBLUFF)
                            {
                                switch (rnd)
                                {
                                    case 0:
                                        _currentMusicEvent = EVENT_BREWFESTGOBLIN01;
                                        musicTime = EVENT_BREWFESTGOBLIN01_TIME;
                                        break;
                                    case 1:
                                        _currentMusicEvent = EVENT_BREWFESTGOBLIN02;
                                        musicTime = EVENT_BREWFESTGOBLIN02_TIME;
                                        break;
                                    case 2:
                                        _currentMusicEvent = EVENT_BREWFESTGOBLIN03;
                                        musicTime = EVENT_BREWFESTGOBLIN03_TIME;
                                        break;
                                    default:
                                        break;
                                }
                            }
                            else if (me->GetAreaId() == IRONFORGE_1 || me->GetAreaId() == IRONFORGE_2 || me->GetAreaId() == STORMWIND || me->GetAreaId() == EXODAR || me->GetAreaId() == DARNASSUS)
                            {
                                switch (rnd)
                                {
                                    case 0:
                                        _currentMusicEvent = EVENT_BREWFESTDWARF01;
                                        musicTime = EVENT_BREWFESTDWARF01_TIME;
                                        break;
                                    case 1:
                                        _currentMusicEvent = EVENT_BREWFESTDWARF02;
                                        musicTime = EVENT_BREWFESTDWARF02_TIME;
                                        break;
                                    case 2:
                                        _currentMusicEvent = EVENT_BREWFESTDWARF03;
                                        musicTime = EVENT_BREWFESTDWARF03_TIME;
                                        break;
                                    default:
                                        break;
                                }
                            }
                            else if (me->GetAreaId() == SHATTRATH)
                            {
                                rnd = urand(0, 5);
                                switch (rnd)
                                {
                                    case 0:
                                        _currentMusicEvent = EVENT_BREWFESTGOBLIN01;
                                        musicTime = EVENT_BREWFESTGOBLIN01_TIME;
                                        break;
                                    case 1:
                                        _currentMusicEvent = EVENT_BREWFESTGOBLIN02;
                                        musicTime = EVENT_BREWFESTGOBLIN02_TIME;
                                        break;
                                    case 2:
                                        _currentMusicEvent = EVENT_BREWFESTGOBLIN03;
                                        musicTime = EVENT_BREWFESTGOBLIN03_TIME;
                                        break;
                                    case 3:
                                        _currentMusicEvent = EVENT_BREWFESTDWARF01;
                                        musicTime = EVENT_BREWFESTDWARF01_TIME;
                                        break;
                                    case 4:
                                        _currentMusicEvent = EVENT_BREWFESTDWARF02;
                                        musicTime = EVENT_BREWFESTDWARF02_TIME;
                                        break;
                                    case 5:
                                        _currentMusicEvent = EVENT_BREWFESTDWARF03;
                                        musicTime = EVENT_BREWFESTDWARF03_TIME;
                                        break;
                                    default:
                                        break;
                                }
                            }
                            _events.ScheduleEvent(EVENT_BM_SELECT_MUSIC, musicTime); // Select new song music after play time is over
                            break;
                        }
                    case EVENT_BM_START_MUSIC:
                        if (!IsHolidayActive(HOLIDAY_BREWFEST)) // Check if Brewfest is active
                            break;
                        // Play selected music
                        if (_currentMusicEvent != 0)
                        {
                            me->PlayDirectMusic(_currentMusicEvent);
                        }
                        _events.ScheduleEvent(EVENT_BM_START_MUSIC, 5000); // Every 5 second's SMSG_PLAY_MUSIC packet (PlayDirectMusic) is pushed to the client
                        break;
                    default:
                        break;
                }
            }
        }
    private:
        EventMap _events;
        uint32 _currentMusicEvent;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_brewfest_musicAI(go);
    }
};

/*####
## go_pirate_day_music
####*/

enum PirateDayMusic
{
    MUSIC_PIRATE_DAY_MUSIC = 12845
};

enum PirateDayMusicEvents
{
    EVENT_PDM_START_MUSIC = 1
};

class go_pirate_day_music : public GameObjectScript
{
public:
    go_pirate_day_music() : GameObjectScript("go_pirate_day_music") { }

    struct go_pirate_day_musicAI : public GameObjectAI
    {
        uint32 rnd;

        go_pirate_day_musicAI(GameObject* go) : GameObjectAI(go)
        {
            _events.ScheduleEvent(EVENT_PDM_START_MUSIC, 1000);
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_PDM_START_MUSIC:
                        if (!IsHolidayActive(HOLIDAY_PIRATES_DAY))
                            break;
                        me->PlayDirectMusic(MUSIC_PIRATE_DAY_MUSIC);
                        _events.ScheduleEvent(EVENT_PDM_START_MUSIC, 5000);  // Every 5 second's SMSG_PLAY_MUSIC packet (PlayDirectMusic) is pushed to the client (sniffed value)
                        break;
                    default:
                        break;
                }
            }
        }
    private:
        EventMap _events;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_pirate_day_musicAI(go);
    }
};

/*####
## go_darkmoon_faire_music
####*/
enum DarkmoonFaireMusic
{
    MUSIC_DARKMOON_FAIRE_MUSIC = 8440
};

enum DarkmoonFaireMusicEvents
{
    EVENT_DFM_START_MUSIC = 1
};

class go_darkmoon_faire_music : public GameObjectScript
{
public:
    go_darkmoon_faire_music() : GameObjectScript("go_darkmoon_faire_music") { }

    struct go_darkmoon_faire_musicAI : public GameObjectAI
    {
        uint32 rnd;

        go_darkmoon_faire_musicAI(GameObject* go) : GameObjectAI(go)
        {
            _events.ScheduleEvent(EVENT_DFM_START_MUSIC, 1000);
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_DFM_START_MUSIC:
                        if (!IsHolidayActive(HOLIDAY_DARKMOON_FAIRE_ELWYNN) || !IsHolidayActive(HOLIDAY_DARKMOON_FAIRE_THUNDER) || !IsHolidayActive(HOLIDAY_DARKMOON_FAIRE_SHATTRATH))
                            break;
                        me->PlayDirectMusic(MUSIC_DARKMOON_FAIRE_MUSIC);
                        _events.ScheduleEvent(EVENT_DFM_START_MUSIC, 5000);  // Every 5 second's SMSG_PLAY_MUSIC packet (PlayDirectMusic) is pushed to the client (sniffed value)
                        break;
                    default:
                        break;
                }
            }
        }
    private:
        EventMap _events;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_darkmoon_faire_musicAI(go);
    }
};

/*####
## go_midsummer_music
####*/

enum MidsummerMusic
{
    EVENTMIDSUMMERFIREFESTIVAL_A = 12319, // 1.08 min
    EVENTMIDSUMMERFIREFESTIVAL_H = 12325, // 1.12 min
};

enum MidsummerMusicEvents
{
    EVENT_MM_START_MUSIC = 1
};

class go_midsummer_music : public GameObjectScript
{
public:
    go_midsummer_music() : GameObjectScript("go_midsummer_music") { }

    struct go_midsummer_musicAI : public GameObjectAI
    {
        go_midsummer_musicAI(GameObject* go) : GameObjectAI(go)
        {
            _events.ScheduleEvent(EVENT_MM_START_MUSIC, 1000);
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_MM_START_MUSIC:
                        {
                            if (!IsHolidayActive(HOLIDAY_FIRE_FESTIVAL))
                                break;

                            std::list<Player*> targets;
                            Acore::AnyPlayerInObjectRangeCheck check(me, me->GetVisibilityRange(), false);
                            Acore::PlayerListSearcherWithSharedVision<Acore::AnyPlayerInObjectRangeCheck> searcher(me, targets, check);
                            Cell::VisitWorldObjects(me, searcher, me->GetVisibilityRange());
                            for (Player* player : targets)
                            {
                                if (player->GetTeamId() == TEAM_HORDE)
                                {
                                    me->PlayDirectMusic(EVENTMIDSUMMERFIREFESTIVAL_H, player);
                                }
                                else
                                {
                                    me->PlayDirectMusic(EVENTMIDSUMMERFIREFESTIVAL_A, player);
                                }
                            }

                            _events.ScheduleEvent(EVENT_MM_START_MUSIC, 5000); // Every 5 second's SMSG_PLAY_MUSIC packet (PlayDirectMusic) is pushed to the client (sniffed value)
                            break;
                        }
                    default:
                        break;
                }
            }
        }
    private:
        EventMap _events;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_midsummer_musicAI(go);
    }
};

/*######
## go_gilded_brazier (Paladin quest 9678 "The First Trial")
######*/

enum GildedBrazier
{
    EVENT_STILLBLADE_SPAWN = 1,
    EVENT_RESET_BRAZIER    = 2,
    NPC_STILLBLADE         = 17716,
    QUEST_THE_FIRST_TRIAL  = 9678
};

class go_gilded_brazier : public GameObjectScript
{
public:
    go_gilded_brazier() : GameObjectScript("go_gilded_brazier") { }

    struct go_gilded_brazierAI : public GameObjectAI
    {
        go_gilded_brazierAI(GameObject* go) : GameObjectAI(go)
        {
            Initialize();
        }

        void Initialize()
        {
            _playerGUID.Clear();
        }

        bool GossipHello(Player* player, bool reportUse) override
        {
            if (reportUse)
                return false;

            if (me->GetGoType() == GAMEOBJECT_TYPE_GOOBER)
            {
                if (player->GetQuestStatus(QUEST_THE_FIRST_TRIAL) == QUEST_STATUS_INCOMPLETE)
                {
                    _playerGUID = player->GetGUID();
                    me->SetGameObjectFlag((GameObjectFlags)1);
                    me->RemoveByteFlag(GAMEOBJECT_BYTES_1, 0, 1);
                    _events.ScheduleEvent(EVENT_STILLBLADE_SPAWN, 1000);
                }
            }
            return true;
        }

        void UpdateAI(uint32 const diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_STILLBLADE_SPAWN:
                {
                    if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                    {
                        player->SummonCreature(NPC_STILLBLADE, 8032.587f, -7524.518f, 149.68073f, 6.161012172698974609f, TEMPSUMMON_DEAD_DESPAWN, 60000);
                        _events.ScheduleEvent(EVENT_RESET_BRAZIER, 4000);
                    }
                    break;
                }
                case EVENT_RESET_BRAZIER:
                {
                    me->RemoveGameObjectFlag((GameObjectFlags)1);
                    me->SetByteFlag(GAMEOBJECT_BYTES_1, 0, 1);
                    break;
                }
                default:
                    break;
                }
            }
        }

    private:
        EventMap _events;
        ObjectGuid _playerGUID;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_gilded_brazierAI(go);
    }
};

/*######
## go_tablet_of_the_seven
######*/

class go_tablet_of_the_seven : public GameObjectScript
{
public:
    go_tablet_of_the_seven() : GameObjectScript("go_tablet_of_the_seven") { }

    //TODO: use gossip option ("Transcript the Tablet") instead, if Trinity adds support.
    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (go->GetGoType() != GAMEOBJECT_TYPE_QUESTGIVER)
            return true;

        if (player->GetQuestStatus(4296) == QUEST_STATUS_INCOMPLETE)
            player->CastSpell(player, 15065, false);

        return true;
    }
};

/*#####
## go_jump_a_tron
######*/

class go_jump_a_tron : public GameObjectScript
{
public:
    go_jump_a_tron() : GameObjectScript("go_jump_a_tron") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (player->GetQuestStatus(10111) == QUEST_STATUS_INCOMPLETE)
            player->CastSpell(player, 33382, true);

        return true;
    }
};

/*######
## go_sacred_fire_of_life
######*/

enum SacredFireOfLife
{
    NPC_ARIKARA     = 10882
};

class go_sacred_fire_of_life : public GameObjectScript
{
public:
    go_sacred_fire_of_life() : GameObjectScript("go_sacred_fire_of_life") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (go->GetGoType() == GAMEOBJECT_TYPE_GOOBER)
            player->SummonCreature(NPC_ARIKARA, -5008.338f, -2118.894f, 83.657f, 0.874f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);

        return true;
    }
};

/*######
## go_shrine_of_the_birds
######*/
/*
enum ShrineOfTheBirds
{
    NPC_HAWK_GUARD      = 22992,
    NPC_EAGLE_GUARD     = 22993,
    NPC_FALCON_GUARD    = 22994,
    GO_SHRINE_HAWK      = 185551,
    GO_SHRINE_EAGLE     = 185547,
    GO_SHRINE_FALCON    = 185553
};

class go_shrine_of_the_birds : public GameObjectScript
{
public:
    go_shrine_of_the_birds() : GameObjectScript("go_shrine_of_the_birds") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        uint32 BirdEntry = 0;

        float fX, fY, fZ;
        go->GetClosePoint(fX, fY, fZ, go->GetObjectSize(), INTERACTION_DISTANCE);

        switch (go->GetEntry())
        {
            case GO_SHRINE_HAWK:
                BirdEntry = NPC_HAWK_GUARD;
                break;
            case GO_SHRINE_EAGLE:
                BirdEntry = NPC_EAGLE_GUARD;
                break;
            case GO_SHRINE_FALCON:
                BirdEntry = NPC_FALCON_GUARD;
                break;
        }

        if (BirdEntry)
            player->SummonCreature(BirdEntry, fX, fY, fZ, go->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);

        return false;
    }
};
*/
/*######
## go_southfury_moonstone
######*/

enum Southfury
{
    NPC_RIZZLE                  = 23002,
    SPELL_BLACKJACK             = 39865, //stuns player
    SPELL_SUMMON_RIZZLE         = 39866
};

class go_southfury_moonstone : public GameObjectScript
{
public:
    go_southfury_moonstone() : GameObjectScript("go_southfury_moonstone") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        //implicitTarget=48 not implemented as of writing this code, and manual summon may be just ok for our purpose
        //player->CastSpell(player, SPELL_SUMMON_RIZZLE, false);

        if (Creature* creature = player->SummonCreature(NPC_RIZZLE, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 0))
        {
            // no need casting spell blackjack, it's casted by script npc_rizzle_sprysprocket.
            //creature->CastSpell(player, SPELL_BLACKJACK, false);
            creature->AI()->AttackStart(player);
        }

        return false;
    }
};

/*######
## go_tele_to_dalaran_crystal
######*/

enum DalaranCrystal
{
    QUEST_LEARN_LEAVE_RETURN    = 12790,
    QUEST_TELE_CRYSTAL_FLAG     = 12845
};

#define GO_TELE_TO_DALARAN_CRYSTAL_FAILED   "This teleport crystal cannot be used until the teleport crystal in Dalaran has been used at least once."

class go_tele_to_dalaran_crystal : public GameObjectScript
{
public:
    go_tele_to_dalaran_crystal() : GameObjectScript("go_tele_to_dalaran_crystal") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (player->GetQuestRewardStatus(QUEST_TELE_CRYSTAL_FLAG))
            return false;

        ChatHandler(player->GetSession()).SendNotification(GO_TELE_TO_DALARAN_CRYSTAL_FAILED);

        return true;
    }
};

/*######
## go_tele_to_violet_stand
######*/

class go_tele_to_violet_stand : public GameObjectScript
{
public:
    go_tele_to_violet_stand() : GameObjectScript("go_tele_to_violet_stand") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (player->GetQuestRewardStatus(QUEST_LEARN_LEAVE_RETURN) || player->GetQuestStatus(QUEST_LEARN_LEAVE_RETURN) == QUEST_STATUS_INCOMPLETE)
            return false;

        return true;
    }
};

/*######
## go_fel_crystalforge
######*/

#define GOSSIP_FEL_CRYSTALFORGE_TEXT 31000
#define GOSSIP_FEL_CRYSTALFORGE_ITEM_TEXT_RETURN 31001
#define GOSSIP_FEL_CRYSTALFORGE_ITEM_1 "Purchase 1 Unstable Flask of the Beast for the cost of 10 Apexis Shards"
#define GOSSIP_FEL_CRYSTALFORGE_ITEM_5 "Purchase 5 Unstable Flask of the Beast for the cost of 50 Apexis Shards"
#define GOSSIP_FEL_CRYSTALFORGE_ITEM_RETURN "Use the fel crystalforge to make another purchase."

enum FelCrystalforge
{
    SPELL_CREATE_1_FLASK_OF_BEAST   = 40964,
    SPELL_CREATE_5_FLASK_OF_BEAST   = 40965,
};

class go_fel_crystalforge : public GameObjectScript
{
public:
    go_fel_crystalforge() : GameObjectScript("go_fel_crystalforge") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (go->GetGoType() == GAMEOBJECT_TYPE_QUESTGIVER) /* != GAMEOBJECT_TYPE_QUESTGIVER) */
            player->PrepareQuestMenu(go->GetGUID()); /* return true*/

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_FEL_CRYSTALFORGE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_FEL_CRYSTALFORGE_ITEM_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, GOSSIP_FEL_CRYSTALFORGE_TEXT, go->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->CastSpell(player, SPELL_CREATE_1_FLASK_OF_BEAST, false);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_FEL_CRYSTALFORGE_ITEM_RETURN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GOSSIP_FEL_CRYSTALFORGE_ITEM_TEXT_RETURN, go->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->CastSpell(player, SPELL_CREATE_5_FLASK_OF_BEAST, false);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_FEL_CRYSTALFORGE_ITEM_RETURN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GOSSIP_FEL_CRYSTALFORGE_ITEM_TEXT_RETURN, go->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_FEL_CRYSTALFORGE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_FEL_CRYSTALFORGE_ITEM_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, GOSSIP_FEL_CRYSTALFORGE_TEXT, go->GetGUID());
                break;
        }
        return true;
    }
};

/*######
## go_bashir_crystalforge
######*/

#define GOSSIP_BASHIR_CRYSTALFORGE_TEXT 31100
#define GOSSIP_BASHIR_CRYSTALFORGE_ITEM_TEXT_RETURN 31101
#define GOSSIP_BASHIR_CRYSTALFORGE_ITEM_1 "Purchase 1 Unstable Flask of the Sorcerer for the cost of 10 Apexis Shards"
#define GOSSIP_BASHIR_CRYSTALFORGE_ITEM_5 "Purchase 5 Unstable Flask of the Sorcerer for the cost of 50 Apexis Shards"
#define GOSSIP_BASHIR_CRYSTALFORGE_ITEM_RETURN "Use the bashir crystalforge to make another purchase."

enum BashirCrystalforge
{
    SPELL_CREATE_1_FLASK_OF_SORCERER   = 40968,
    SPELL_CREATE_5_FLASK_OF_SORCERER   = 40970,
};

class go_bashir_crystalforge : public GameObjectScript
{
public:
    go_bashir_crystalforge() : GameObjectScript("go_bashir_crystalforge") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (go->GetGoType() == GAMEOBJECT_TYPE_QUESTGIVER) /* != GAMEOBJECT_TYPE_QUESTGIVER) */
            player->PrepareQuestMenu(go->GetGUID()); /* return true*/

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, GOSSIP_BASHIR_CRYSTALFORGE_TEXT, go->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->CastSpell(player, SPELL_CREATE_1_FLASK_OF_SORCERER, false);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_RETURN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_TEXT_RETURN, go->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->CastSpell(player, SPELL_CREATE_5_FLASK_OF_SORCERER, false);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_RETURN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_TEXT_RETURN, go->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BASHIR_CRYSTALFORGE_ITEM_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, GOSSIP_BASHIR_CRYSTALFORGE_TEXT, go->GetGUID());
                break;
        }
        return true;
    }
};

/*######
## go_scourge_cage
######*/

enum ScourgeCage
{
    NPC_SCOURGE_PRISONER = 25610
};

class go_scourge_cage : public GameObjectScript
{
public:
    go_scourge_cage() : GameObjectScript("go_scourge_cage") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->UseDoorOrButton();
        if (Creature* pNearestPrisoner = go->FindNearestCreature(NPC_SCOURGE_PRISONER, 5.0f, true))
        {
            player->KilledMonsterCredit(NPC_SCOURGE_PRISONER, pNearestPrisoner->GetGUID());
            pNearestPrisoner->DisappearAndDie();
        }

        return true;
    }
};

/*######
## go_arcane_prison
######*/

enum ArcanePrison
{
    QUEST_PRISON_BREAK                  = 11587,
    SPELL_ARCANE_PRISONER_KILL_CREDIT   = 45456
};

class go_arcane_prison : public GameObjectScript
{
public:
    go_arcane_prison() : GameObjectScript("go_arcane_prison") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        // xinef: prevent spawning hundreds of them
        if (player->GetQuestStatus(QUEST_PRISON_BREAK) == QUEST_STATUS_INCOMPLETE && !go->FindNearestCreature(25318, 20.0f))
        {
            go->SummonCreature(25318, 3485.089844f, 6115.7422188f, 70.966812f, 0, TEMPSUMMON_TIMED_DESPAWN, 60000);
            player->CastSpell(player, SPELL_ARCANE_PRISONER_KILL_CREDIT, true);
            return true;
        }
        return false;
    }
};

/*######
## go_jotunheim_cage
######*/

enum JotunheimCage
{
    NPC_EBON_BLADE_PRISONER_HUMAN   = 30186,
    NPC_EBON_BLADE_PRISONER_NE      = 30194,
    NPC_EBON_BLADE_PRISONER_TROLL   = 30196,
    NPC_EBON_BLADE_PRISONER_ORC     = 30195,

    SPELL_SUMMON_BLADE_KNIGHT_H     = 56207,
    SPELL_SUMMON_BLADE_KNIGHT_NE    = 56209,
    SPELL_SUMMON_BLADE_KNIGHT_ORC   = 56212,
    SPELL_SUMMON_BLADE_KNIGHT_TROLL = 56214
};

class go_jotunheim_cage : public GameObjectScript
{
public:
    go_jotunheim_cage() : GameObjectScript("go_jotunheim_cage") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->UseDoorOrButton();
        Creature* pPrisoner = go->FindNearestCreature(NPC_EBON_BLADE_PRISONER_HUMAN, 5.0f, true);
        if (!pPrisoner)
        {
            pPrisoner = go->FindNearestCreature(NPC_EBON_BLADE_PRISONER_TROLL, 5.0f, true);
            if (!pPrisoner)
            {
                pPrisoner = go->FindNearestCreature(NPC_EBON_BLADE_PRISONER_ORC, 5.0f, true);
                if (!pPrisoner)
                    pPrisoner = go->FindNearestCreature(NPC_EBON_BLADE_PRISONER_NE, 5.0f, true);
            }
        }
        if (!pPrisoner || !pPrisoner->IsAlive())
            return false;

        pPrisoner->DespawnOrUnsummon();
        player->KilledMonsterCredit(NPC_EBON_BLADE_PRISONER_HUMAN);
        switch (pPrisoner->GetEntry())
        {
            case NPC_EBON_BLADE_PRISONER_HUMAN:
                player->CastSpell(player, SPELL_SUMMON_BLADE_KNIGHT_H, true);
                break;
            case NPC_EBON_BLADE_PRISONER_NE:
                player->CastSpell(player, SPELL_SUMMON_BLADE_KNIGHT_NE, true);
                break;
            case NPC_EBON_BLADE_PRISONER_TROLL:
                player->CastSpell(player, SPELL_SUMMON_BLADE_KNIGHT_TROLL, true);
                break;
            case NPC_EBON_BLADE_PRISONER_ORC:
                player->CastSpell(player, SPELL_SUMMON_BLADE_KNIGHT_ORC, true);
                break;
        }
        return true;
    }
};

enum TableTheka
{
    GOSSIP_TABLE_THEKA = 1653,

    QUEST_SPIDER_GOLD = 2936
};

class go_table_theka : public GameObjectScript
{
public:
    go_table_theka() : GameObjectScript("go_table_theka") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (player->GetQuestStatus(QUEST_SPIDER_GOLD) == QUEST_STATUS_INCOMPLETE)
            player->AreaExploredOrEventHappens(QUEST_SPIDER_GOLD);

        SendGossipMenuFor(player, GOSSIP_TABLE_THEKA, go->GetGUID());

        return true;
    }
};

/*######
## go_soulwell
######*/

enum SoulWellData
{
    GO_SOUL_WELL_R1                     = 181621,
    GO_SOUL_WELL_R2                     = 193169,

    SPELL_IMPROVED_HEALTH_STONE_R1      = 18692,
    SPELL_IMPROVED_HEALTH_STONE_R2      = 18693,

    SPELL_CREATE_MASTER_HEALTH_STONE_R0 = 34130,
    SPELL_CREATE_MASTER_HEALTH_STONE_R1 = 34149,
    SPELL_CREATE_MASTER_HEALTH_STONE_R2 = 34150,

    SPELL_CREATE_FEL_HEALTH_STONE_R0    = 58890,
    SPELL_CREATE_FEL_HEALTH_STONE_R1    = 58896,
    SPELL_CREATE_FEL_HEALTH_STONE_R2    = 58898,
};

class go_soulwell : public GameObjectScript
{
public:
    go_soulwell() : GameObjectScript("go_soulwell") { }

    struct go_soulwellAI : public GameObjectAI
    {
        go_soulwellAI(GameObject* go) : GameObjectAI(go)
        {
        }

        /// Due to the fact that this GameObject triggers CMSG_GAMEOBJECT_USE
        /// _and_ CMSG_GAMEOBJECT_REPORT_USE, this GossipHello hook is called
        /// twice. The script's handling is fine as it won't remove two charges
        /// on the well. We have to find how to segregate REPORT_USE and USE.
        bool GossipHello(Player* player, bool reportUse) override
        {
            if (reportUse)
                return false;

            Unit* owner = me->GetOwner();
            if (!owner)
                return true;

            uint32 stoneId = 0;
            uint32 stoneSpell = 0;
            switch (me->GetEntry())
            {
                case GO_SOUL_WELL_R1:
                    stoneSpell = SPELL_CREATE_MASTER_HEALTH_STONE_R0;
                    if (Unit* owner = me->GetOwner())
                    {
                        if (owner->HasAura(SPELL_IMPROVED_HEALTH_STONE_R1))
                        {
                            stoneSpell = SPELL_CREATE_MASTER_HEALTH_STONE_R1;
                        }
                        else if (owner->HasAura(SPELL_IMPROVED_HEALTH_STONE_R2))
                        {
                            stoneSpell = SPELL_CREATE_MASTER_HEALTH_STONE_R2;
                        }
                    }
                    break;
                case GO_SOUL_WELL_R2:
                    stoneSpell = SPELL_CREATE_FEL_HEALTH_STONE_R0;
                    if (Unit* owner = me->GetOwner())
                    {
                        if (owner->HasAura(SPELL_IMPROVED_HEALTH_STONE_R1))
                        {
                            stoneSpell = SPELL_CREATE_FEL_HEALTH_STONE_R1;
                        }
                        else if (owner->HasAura(SPELL_IMPROVED_HEALTH_STONE_R2))
                        {
                            stoneSpell = SPELL_CREATE_FEL_HEALTH_STONE_R2;
                        }
                    }
                    break;
            }

            if (!stoneSpell)
            {
                return true;
            }

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(stoneSpell);
            if (!spellInfo)
            {
                return true;
            }

            stoneId = spellInfo->Effects[EFFECT_0].ItemType;
            if (!stoneId)
            {
                if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(stoneSpell))
                {
                    Spell::SendCastResult(player, spell, 0, SPELL_FAILED_ERROR);
                }
                return true;
            }

            if (owner->GetTypeId() != TYPEID_PLAYER || !player->IsInSameRaidWith(owner->ToPlayer()))
            {
                if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(stoneSpell))
                {
                    Spell::SendCastResult(player, spell, 0, SPELL_FAILED_TARGET_NOT_IN_RAID);
                }
                return true;
            }

            // Don't try to add a stone if we already have one.
            if (player->HasItemCount(stoneId))
            {
                if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(stoneSpell))
                {
                    Spell::SendCastResult(player, spell, 0, SPELL_FAILED_TOO_MANY_OF_ITEM);
                }
                return true;
            }

            player->CastSpell(player, stoneSpell, false);

            // Item has to actually be created to remove a charge on the well.
            if (player->HasItemCount(stoneId))
            {
                me->AddUse();
            }

            return true;
        }
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_soulwellAI(go);
    }
};

/*######
## Quest 11255: Prisoners of Wyrmskull
## go_dragonflayer_cage
######*/

enum PrisonersOfWyrmskull
{
    QUEST_PRISONERS_OF_WYRMSKULL                  = 11255,
    NPC_PRISONER_PRIEST                           = 24086,
    NPC_PRISONER_MAGE                             = 24088,
    NPC_PRISONER_WARRIOR                          = 24089,
    NPC_PRISONER_PALADIN                          = 24090
};

class go_dragonflayer_cage : public GameObjectScript
{
public:
    go_dragonflayer_cage() : GameObjectScript("go_dragonflayer_cage") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->UseDoorOrButton();
        if (player->GetQuestStatus(QUEST_PRISONERS_OF_WYRMSKULL) != QUEST_STATUS_INCOMPLETE)
            return true;

        Creature* pPrisoner = go->FindNearestCreature(NPC_PRISONER_PRIEST, 2.0f);
        if (!pPrisoner)
        {
            pPrisoner = go->FindNearestCreature(NPC_PRISONER_MAGE, 2.0f);
            if (!pPrisoner)
            {
                pPrisoner = go->FindNearestCreature(NPC_PRISONER_WARRIOR, 2.0f);
                if (!pPrisoner)
                    pPrisoner = go->FindNearestCreature(NPC_PRISONER_PALADIN, 2.0f);
            }
        }

        if (!pPrisoner || !pPrisoner->IsAlive())
            return true;

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(QUEST_PRISONERS_OF_WYRMSKULL);
        if (qInfo)
        {
            /// @todo prisoner should help player for a short period of time
            player->KilledMonsterCredit(qInfo->RequiredNpcOrGo[0]);
            pPrisoner->DisappearAndDie();
        }
        return true;
    }
};

/*######
## go_amberpine_outhouse
######*/

#define GO_ANDERHOLS_SLIDER_CIDER_NOT_FOUND "Quest item Anderhol's Slider Cider not found."

enum AmberpineOuthouse
{
    QUEST_DOING_YOUR_DUTY           = 12227,
    SPELL_INDISPOSED                = 53017,
    SPELL_INDISPOSED_II             = 48324,
    SPELL_INDISPOSED_III            = 48341,
    GOSSIP_OUTHOUSE_INUSE           = 12775,
    GOSSIP_OUTHOUSE_VACANT          = 12779,
    GOSSIP_USE_OUTHOUSE             = 9492,
};

class go_amberpine_outhouse : public GameObjectScript
{
public:
    go_amberpine_outhouse() : GameObjectScript("go_amberpine_outhouse") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        QuestStatus status = player->GetQuestStatus(QUEST_DOING_YOUR_DUTY);
        if (status == QUEST_STATUS_INCOMPLETE || status == QUEST_STATUS_COMPLETE || status == QUEST_STATUS_REWARDED)
        {
            AddGossipItemFor(player, GOSSIP_USE_OUTHOUSE, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            SendGossipMenuFor(player, GOSSIP_OUTHOUSE_VACANT, go->GetGUID());
        }
        else
            SendGossipMenuFor(player, GOSSIP_OUTHOUSE_INUSE, go->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* /*go*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            CloseGossipMenuFor(player);
            player->CastSpell(player, SPELL_INDISPOSED);
            player->CastSpell(player, SPELL_INDISPOSED_II);
            player->CastSpell(player, SPELL_INDISPOSED_III);
            return true;
        }
        else
        {
            CloseGossipMenuFor(player);
            ChatHandler(player->GetSession()).SendNotification(GO_ANDERHOLS_SLIDER_CIDER_NOT_FOUND);
            return false;
        }
    }
};

/*######
## Quest 1126: Hive in the Tower
## go_hive_pod
######*/

enum Hives
{
    QUEST_HIVE_IN_THE_TOWER                       = 9544,
    NPC_HIVE_AMBUSHER                             = 13301
};

class go_hive_pod : public GameObjectScript
{
public:
    go_hive_pod() : GameObjectScript("go_hive_pod") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        player->SendLoot(go->GetGUID(), LOOT_CORPSE);

        // xinef: prevent spawning hundreds of them
        if (go->FindNearestCreature(NPC_HIVE_AMBUSHER, 20.0f))
            return true;

        go->SummonCreature(NPC_HIVE_AMBUSHER, go->GetPositionX() + 1, go->GetPositionY(), go->GetPositionZ(), go->GetAngle(player), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
        go->SummonCreature(NPC_HIVE_AMBUSHER, go->GetPositionX(), go->GetPositionY() + 1, go->GetPositionZ(), go->GetAngle(player), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
        return true;
    }
};

class go_massive_seaforium_charge : public GameObjectScript
{
public:
    go_massive_seaforium_charge() : GameObjectScript("go_massive_seaforium_charge") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        go->SetLootState(GO_JUST_DEACTIVATED);
        return true;
    }
};

/*########
#### go_veil_skith_cage
#####*/

enum MissingFriends
{
    QUEST_MISSING_FRIENDS    = 10852,
    NPC_CAPTIVE_CHILD        = 22314,
    SAY_FREE_0               = 0,
};

class go_veil_skith_cage : public GameObjectScript
{
public:
    go_veil_skith_cage() : GameObjectScript("go_veil_skith_cage") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->UseDoorOrButton();
        if (player->GetQuestStatus(QUEST_MISSING_FRIENDS) == QUEST_STATUS_INCOMPLETE)
        {
            std::list<Creature*> childrenList;
            GetCreatureListWithEntryInGrid(childrenList, go, NPC_CAPTIVE_CHILD, INTERACTION_DISTANCE);
            for (std::list<Creature*>::const_iterator itr = childrenList.begin(); itr != childrenList.end(); ++itr)
            {
                player->KilledMonsterCredit(NPC_CAPTIVE_CHILD, (*itr)->GetGUID());
                (*itr)->DespawnOrUnsummon(5000);
                (*itr)->GetMotionMaster()->MovePoint(1, go->GetPositionX() + 5, go->GetPositionY(), go->GetPositionZ());
                (*itr)->AI()->Talk(SAY_FREE_0);
                (*itr)->GetMotionMaster()->Clear();
            }
        }
        return false;
    }
};

/*####
## go_bells
####*/

enum BellHourlySoundFX
{
    BELLTOLLHORDE      = 6595,
    BELLTOLLTRIBAL     = 6675,
    BELLTOLLALLIANCE   = 6594,
    BELLTOLLNIGHTELF   = 6674,
    BELLTOLLDWARFGNOME = 7234,
    BELLTOLLKHARAZHAN  = 9154,
    LIGHTHOUSEFOGHORN  = 7197
};

enum BellHourlySoundZones
{
    TIRISFAL_ZONE            = 85,
    UNDERCITY_ZONE           = 1497,
    DUN_MOROGH_ZONE          = 1,
    IRONFORGE_ZONE           = 1537,
    TELDRASSIL_ZONE          = 141,
    DARNASSUS_ZONE           = 1657,
    ASHENVALE_ZONE           = 331,
    HILLSBRAD_FOOTHILLS_ZONE = 267,
    DUSKWOOD_ZONE            = 10,
    WESTFALL_ZONE            = 40,
    DUSTWALLOW_MARSH_ZONE    = 15,
    SHATTRATH_ZONE           = 3703
};

enum LightHouseAreas
{
    AREA_ALCAZ_ISLAND        = 2079,
    AREA_WESTFALL_LIGHTHOUSE = 115
};

enum BellHourlyObjects
{
    GO_HORDE_BELL     = 175885,
    GO_ALLIANCE_BELL  = 176573,
    GO_KHARAZHAN_BELL = 182064
};

enum BellHourlyMisc
{
    GAME_EVENT_HOURLY_BELLS = 73,
    EVENT_RING_BELL         = 1,
    EVENT_TIME              = 2
};

class go_bells : public GameObjectScript
{
public:
    go_bells() : GameObjectScript("go_bells") {}

    struct go_bellsAI : public GameObjectAI
    {
        go_bellsAI(GameObject* go) : GameObjectAI(go), _soundId(0), once(true)
        {
            uint32 zoneId = go->GetZoneId();

            switch (go->GetEntry())
            {
            case GO_HORDE_BELL:
            {
                switch (zoneId)
                {
                case TIRISFAL_ZONE:
                case UNDERCITY_ZONE:
                case HILLSBRAD_FOOTHILLS_ZONE:
                case DUSKWOOD_ZONE:
                    _soundId = BELLTOLLHORDE;
                    break;
                default:
                    _soundId = BELLTOLLTRIBAL;
                    break;
                }
                break;
            }
            case GO_ALLIANCE_BELL:
            {
                switch (zoneId)
                {
                case IRONFORGE_ZONE:
                case DUN_MOROGH_ZONE:
                    _soundId = BELLTOLLDWARFGNOME;
                    break;
                case DARNASSUS_ZONE:
                case TELDRASSIL_ZONE:
                case ASHENVALE_ZONE:
                case SHATTRATH_ZONE:
                    _soundId = BELLTOLLNIGHTELF;
                    break;
                case WESTFALL_ZONE:
                    if (go->GetAreaId() == AREA_WESTFALL_LIGHTHOUSE)
                    {
                        _soundId = LIGHTHOUSEFOGHORN;
                    }
                    else
                    {
                        _soundId = BELLTOLLALLIANCE;
                    }
                    break;
                case DUSTWALLOW_MARSH_ZONE:
                    if (go->GetAreaId() == AREA_ALCAZ_ISLAND)
                    {
                        _soundId = LIGHTHOUSEFOGHORN;
                    }
                    else
                    {
                        _soundId = BELLTOLLALLIANCE;
                    }
                    break;
                default:
                    _soundId = BELLTOLLALLIANCE;
                    break;
                }
                break;
            }
            case GO_KHARAZHAN_BELL:
            {
                _soundId = BELLTOLLKHARAZHAN;
                break;
            }
            break;
            }
        }

        void UpdateAI(uint32 const diff) override
        {
            _events.Update(diff);

            if (sGameEventMgr->IsActiveEvent(GAME_EVENT_HOURLY_BELLS) && once)
            {
                // Reset
                once = false;
                _events.ScheduleEvent(EVENT_TIME, 1000);
            }

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_TIME:
                {
                    tzset(); // set timezone for localtime_r() -> fix issues due to daylight time
                    tm local_tm = Acore::Time::TimeBreakdown();
                    uint8 _rings = (local_tm.tm_hour) % 12;
                    _rings = (_rings == 0) ? 12 : _rings; // 00:00 and 12:00

                    // Dwarf hourly horn should only play a single time, each time the next hour begins.
                    if (_soundId == BELLTOLLDWARFGNOME)
                    {
                        _rings = 1;
                    }

                    // Schedule ring event
                    for (auto i = 0; i < _rings; ++i)
                    {
                        _events.ScheduleEvent(EVENT_RING_BELL, (i * 4 + 1) * 1000);
                    }
                    break;
                }
                case EVENT_RING_BELL:
                {
                    me->PlayDirectSound(_soundId);
                    break;
                }
                default:
                    break;
                }
            }
        }

    private:
        EventMap _events;
        uint32   _soundId;
        bool     once;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_bellsAI(go);
    }
};

/*########
#### go_duskwither_spire_power_source
#####*/

enum DuskwitherSpirePowersource
{
    NPC_POWER_SOURCE_INVISIBLE_BUNNY = 17984
};

class go_duskwither_spire_power_source : public GameObjectScript
{
public:
    go_duskwither_spire_power_source() : GameObjectScript("go_duskwither_spire_power_source") {}

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (Creature* bunny = go->FindNearestCreature(NPC_POWER_SOURCE_INVISIBLE_BUNNY, 1.0f))
        {
            bunny->DespawnOrUnsummon(0ms, 10s);
        }
        return false;
    }
};

void AddSC_go_scripts()
{
    // Ours
    new go_noblegarden_colored_egg();
    new go_seer_of_zebhalak();
    new go_mistwhisper_treasure();
    new go_witherbark_totem_bundle();
    new go_arena_ready_marker();
    new go_ethereum_prison();
    new go_ethereum_stasis();
    new go_resonite_cask();
    new go_tadpole_cage();
    new go_flames();
    new go_heat();
    new go_bear_trap();
    new go_duskwither_spire_power_source();
    new go_l70_etc_music();

    // Theirs
    new go_brewfest_music();
    new go_pirate_day_music();
    new go_darkmoon_faire_music();
    new go_midsummer_music();
    new go_gilded_brazier();
    //new go_shrine_of_the_birds();
    new go_southfury_moonstone();
    new go_tablet_of_the_seven();
    new go_jump_a_tron();
    new go_sacred_fire_of_life();
    new go_tele_to_dalaran_crystal();
    new go_tele_to_violet_stand();
    new go_fel_crystalforge();
    new go_bashir_crystalforge();
    new go_scourge_cage();
    new go_arcane_prison();
    new go_jotunheim_cage();
    new go_table_theka();
    new go_soulwell();
    new go_dragonflayer_cage();
    new go_amberpine_outhouse();
    new go_hive_pod();
    new go_massive_seaforium_charge();
    new go_veil_skith_cage();
    new go_bells();
}

