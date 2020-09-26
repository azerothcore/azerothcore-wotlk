/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "AccountMgr.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "PassiveAI.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "SpellAuraEffects.h"
#include "SmartAI.h"
#include "Group.h"
#include "icecrown_citadel.h"

enum Texts
{
    // Highlord Tirion Fordring (at Light's Hammer)
    SAY_TIRION_INTRO_1              = 0,
    SAY_TIRION_INTRO_2              = 1,
    SAY_TIRION_INTRO_3              = 2,
    SAY_TIRION_INTRO_4              = 3,
    SAY_TIRION_INTRO_H_5            = 4,
    SAY_TIRION_INTRO_A_5            = 5,

    // The Lich King (at Light's Hammer)
    SAY_LK_INTRO_1                  = 0,
    SAY_LK_INTRO_2                  = 1,
    SAY_LK_INTRO_3                  = 2,
    SAY_LK_INTRO_4                  = 3,
    SAY_LK_INTRO_5                  = 4,

    // Highlord Bolvar Fordragon (at Light's Hammer)
    SAY_BOLVAR_INTRO_1              = 0,

    // High Overlord Saurfang (at Light's Hammer)
    SAY_SAURFANG_INTRO_1            = 15,
    SAY_SAURFANG_INTRO_2            = 16,
    SAY_SAURFANG_INTRO_3            = 17,
    SAY_SAURFANG_INTRO_4            = 18,

    // Muradin Bronzebeard (at Light's Hammer)
    SAY_MURADIN_INTRO_1             = 13,
    SAY_MURADIN_INTRO_2             = 14,
    SAY_MURADIN_INTRO_3             = 15,

    // Deathbound Ward
    SAY_TRAP_ACTIVATE               = 0,

    // Rotting Frost Giant
    EMOTE_DEATH_PLAGUE_WARNING      = 0,

    // Sister Svalna
    SAY_SVALNA_KILL_CAPTAIN         = 1, // happens when she kills a captain
    SAY_SVALNA_KILL                 = 4,
    SAY_SVALNA_CAPTAIN_DEATH        = 5, // happens when a captain resurrected by her dies
    SAY_SVALNA_DEATH                = 6,
    EMOTE_SVALNA_IMPALE             = 7,
    EMOTE_SVALNA_BROKEN_SHIELD      = 8,

    SAY_CROK_INTRO_1                = 0, // Ready your arms, my Argent Brothers. The Vrykul will protect the Frost Queen with their lives.
    SAY_ARNATH_INTRO_2              = 5, // Even dying here beats spending another day collecting reagents for that madman, Finklestein.
    SAY_CROK_INTRO_3                = 1, // Enough idle banter! Our champions have arrived - support them as we push our way through the hall!
    SAY_SVALNA_EVENT_START          = 0, // You may have once fought beside me, Crok, but now you are nothing more than a traitor. Come, your second death approaches!
    SAY_CROK_COMBAT_WP_0            = 2, // Draw them back to us, and we'll assist you.
    SAY_CROK_COMBAT_WP_1            = 3, // Quickly, push on!
    SAY_CROK_FINAL_WP               = 4, // Her reinforcements will arrive shortly, we must bring her down quickly!
    SAY_SVALNA_RESURRECT_CAPTAINS   = 2, // Foolish Crok. You brought my reinforcements with you. Arise, Argent Champions, and serve the Lich King in death!
    SAY_CROK_COMBAT_SVALNA          = 5, // I'll draw her attacks. Return our brothers to their graves, then help me bring her down!
    SAY_SVALNA_AGGRO                = 3, // Come, Scourgebane. I'll show the master which of us is truly worthy of the title of "Champion"!
    SAY_CAPTAIN_DEATH               = 0,
    SAY_CAPTAIN_RESURRECTED         = 1,
    SAY_CAPTAIN_KILL                = 2,
    SAY_CAPTAIN_SECOND_DEATH        = 3,
    SAY_CAPTAIN_SURVIVE_TALK        = 4,
    SAY_CROK_WEAKENING_GAUNTLET     = 6,
    SAY_CROK_WEAKENING_SVALNA       = 7,
    SAY_CROK_DEATH                  = 8,
};

enum Spells
{
    // Rotting Frost Giant
    SPELL_DEATH_PLAGUE              = 72879,
    SPELL_DEATH_PLAGUE_AURA         = 72865,
    SPELL_RECENTLY_INFECTED         = 72884,
    SPELL_DEATH_PLAGUE_KILL         = 72867,
    SPELL_STOMP                     = 64652,
    SPELL_ARCTIC_BREATH             = 72848,

    // Frost Freeze Trap
    SPELL_COLDFLAME_JETS            = 70460,

    // Alchemist Adrianna
    SPELL_HARVEST_BLIGHT_SPECIMEN   = 72155,
    SPELL_HARVEST_BLIGHT_SPECIMEN25 = 72162,

    // Crok Scourgebane
    SPELL_ICEBOUND_ARMOR            = 70714,
    SPELL_SCOURGE_STRIKE            = 71488,
    SPELL_DEATH_STRIKE              = 71489,

    // Sister Svalna
    SPELL_CARESS_OF_DEATH           = 70078,
    SPELL_IMPALING_SPEAR_KILL       = 70196,
    SPELL_REVIVE_CHAMPION           = 70053,
    SPELL_UNDEATH                   = 70089,
    SPELL_IMPALING_SPEAR            = 71443,
    SPELL_AETHER_SHIELD             = 71463,
    SPELL_HURL_SPEAR                = 71466,

    // Captain Arnath
    SPELL_DOMINATE_MIND             = 14515,
    SPELL_FLASH_HEAL_NORMAL         = 71595,
    SPELL_POWER_WORD_SHIELD_NORMAL  = 71548,
    SPELL_SMITE_NORMAL              = 71546,
    SPELL_FLASH_HEAL_UNDEAD         = 71782,
    SPELL_POWER_WORD_SHIELD_UNDEAD  = 71780,
    SPELL_SMITE_UNDEAD              = 71778,

    // Captain Brandon
    SPELL_CRUSADER_STRIKE           = 71549,
    SPELL_DIVINE_SHIELD             = 71550,
    SPELL_JUDGEMENT_OF_COMMAND      = 71551,
    SPELL_HAMMER_OF_BETRAYAL        = 71784,

    // Captain Grondel
    SPELL_CHARGE                    = 71553,
    SPELL_MORTAL_STRIKE             = 71552,
    SPELL_SUNDER_ARMOR              = 71554,
    SPELL_CONFLAGRATION             = 71785,

    // Captain Rupert
    SPELL_FEL_IRON_BOMB_NORMAL      = 71592,
    SPELL_MACHINE_GUN_NORMAL        = 71594,
    SPELL_ROCKET_LAUNCH_NORMAL      = 71590,
    SPELL_FEL_IRON_BOMB_UNDEAD      = 71787,
    SPELL_MACHINE_GUN_UNDEAD        = 71788,
    SPELL_ROCKET_LAUNCH_UNDEAD      = 71786,

    // Invisible Stalker (Float, Uninteractible, LargeAOI)
    SPELL_SOUL_MISSILE              = 72585,
};

// Helper defines
// Captain Arnath
#define SPELL_FLASH_HEAL        (IsUndead ? SPELL_FLASH_HEAL_UNDEAD : SPELL_FLASH_HEAL_NORMAL)
#define SPELL_POWER_WORD_SHIELD (IsUndead ? SPELL_POWER_WORD_SHIELD_UNDEAD : SPELL_POWER_WORD_SHIELD_NORMAL)
#define SPELL_SMITE             (IsUndead ? SPELL_SMITE_UNDEAD : SPELL_SMITE_NORMAL)

// Captain Rupert
#define SPELL_FEL_IRON_BOMB     (IsUndead ? SPELL_FEL_IRON_BOMB_UNDEAD : SPELL_FEL_IRON_BOMB_NORMAL)
#define SPELL_MACHINE_GUN       (IsUndead ? SPELL_MACHINE_GUN_UNDEAD : SPELL_MACHINE_GUN_NORMAL)
#define SPELL_ROCKET_LAUNCH     (IsUndead ? SPELL_ROCKET_LAUNCH_UNDEAD : SPELL_ROCKET_LAUNCH_NORMAL)

enum EventTypes
{
    // Highlord Tirion Fordring (at Light's Hammer)
    // The Lich King (at Light's Hammer)
    // Highlord Bolvar Fordragon (at Light's Hammer)
    // High Overlord Saurfang (at Light's Hammer)
    // Muradin Bronzebeard (at Light's Hammer)
    EVENT_TIRION_INTRO_2                = 1,
    EVENT_TIRION_INTRO_3                = 2,
    EVENT_TIRION_INTRO_4                = 3,
    EVENT_TIRION_INTRO_5                = 4,
    EVENT_LK_INTRO_1                    = 5,
    EVENT_TIRION_INTRO_6                = 6,
    EVENT_LK_INTRO_2                    = 7,
    EVENT_LK_INTRO_3                    = 8,
    EVENT_LK_INTRO_4                    = 9,
    EVENT_BOLVAR_INTRO_1                = 10,
    EVENT_LK_INTRO_5                    = 11,
    EVENT_SAURFANG_INTRO_1              = 12,
    EVENT_TIRION_INTRO_H_7              = 13,
    EVENT_SAURFANG_INTRO_2              = 14,
    EVENT_SAURFANG_INTRO_3              = 15,
    EVENT_SAURFANG_INTRO_4              = 16,
    EVENT_SAURFANG_RUN                  = 17,
    EVENT_MURADIN_INTRO_1               = 18,
    EVENT_MURADIN_INTRO_2               = 19,
    EVENT_MURADIN_INTRO_3               = 20,
    EVENT_TIRION_INTRO_A_7              = 21,
    EVENT_MURADIN_INTRO_4               = 22,
    EVENT_MURADIN_INTRO_5               = 23,
    EVENT_MURADIN_RUN                   = 24,

    // Rotting Frost Giant
    EVENT_DEATH_PLAGUE                  = 25,
    EVENT_STOMP                         = 26,
    EVENT_ARCTIC_BREATH                 = 27,

    // Frost Freeze Trap
    EVENT_ACTIVATE_TRAP                 = 28,

    // Crok Scourgebane
    EVENT_SCOURGE_STRIKE                = 29,
    EVENT_DEATH_STRIKE                  = 30,
    EVENT_HEALTH_CHECK                  = 31,
    EVENT_CROK_INTRO_3                  = 32,
    EVENT_START_PATHING                 = 33,

    // Sister Svalna
    EVENT_ARNATH_INTRO_2                = 34,
    EVENT_SVALNA_START                  = 35,
    EVENT_SVALNA_RESURRECT              = 36,
    EVENT_SVALNA_COMBAT                 = 37,
    EVENT_IMPALING_SPEAR                = 38,
    EVENT_AETHER_SHIELD                 = 39,

    // Captain Arnath
    EVENT_ARNATH_FLASH_HEAL             = 40,
    EVENT_ARNATH_PW_SHIELD              = 41,
    EVENT_ARNATH_SMITE                  = 42,
    EVENT_ARNATH_DOMINATE_MIND          = 43,

    // Captain Brandon
    EVENT_BRANDON_CRUSADER_STRIKE       = 44,
    EVENT_BRANDON_DIVINE_SHIELD         = 45,
    EVENT_BRANDON_JUDGEMENT_OF_COMMAND  = 46,
    EVENT_BRANDON_HAMMER_OF_BETRAYAL    = 47,

    // Captain Grondel
    EVENT_GRONDEL_CHARGE_CHECK          = 48,
    EVENT_GRONDEL_MORTAL_STRIKE         = 49,
    EVENT_GRONDEL_SUNDER_ARMOR          = 50,
    EVENT_GRONDEL_CONFLAGRATION         = 51,

    // Captain Rupert
    EVENT_RUPERT_FEL_IRON_BOMB          = 52,
    EVENT_RUPERT_MACHINE_GUN            = 53,
    EVENT_RUPERT_ROCKET_LAUNCH          = 54,

    // Invisible Stalker (Float, Uninteractible, LargeAOI)
    EVENT_SOUL_MISSILE                  = 55,
};

enum DataTypesICC
{
    DATA_DAMNED_KILLS       = 1,
};

enum Actions
{
    // Sister Svalna
    ACTION_KILL_CAPTAIN         = 1,
    ACTION_START_GAUNTLET       = 2,
    ACTION_RESURRECT_CAPTAINS   = 3,
    ACTION_CAPTAIN_DIES         = 4,
    ACTION_RESET_EVENT          = 5,
};

enum EventIds
{
    EVENT_AWAKEN_WARD_1 = 22900,
    EVENT_AWAKEN_WARD_2 = 22907,
    EVENT_AWAKEN_WARD_3 = 22908,
    EVENT_AWAKEN_WARD_4 = 22909,
};

enum MovementPoints
{
    POINT_LAND  = 1,
};

class FrostwingVrykulSearcher
{
    public:
        FrostwingVrykulSearcher(Creature const* source, float range) : _source(source), _range(range) {}

        bool operator()(Unit* unit)
        {
            if (!unit->IsAlive())
                return false;

            switch (unit->GetEntry())
            {
                case NPC_YMIRJAR_BATTLE_MAIDEN:
                case NPC_YMIRJAR_DEATHBRINGER:
                case NPC_YMIRJAR_FROSTBINDER:
                case NPC_YMIRJAR_HUNTRESS:
                case NPC_YMIRJAR_WARLORD:
                    break;
                default:
                    return false;
            }

            if (!unit->IsWithinDist(_source, _range, false))
                return false;

            return true;
        }

    private:
        Creature const* _source;
        float _range;
};

class FrostwingGauntletRespawner
{
    public:
        void operator()(Creature* creature)
        {
            switch (creature->GetOriginalEntry())
            {
                case NPC_YMIRJAR_BATTLE_MAIDEN:
                case NPC_YMIRJAR_DEATHBRINGER:
                case NPC_YMIRJAR_FROSTBINDER:
                case NPC_YMIRJAR_HUNTRESS:
                case NPC_YMIRJAR_WARLORD:
                    break;
                case NPC_CROK_SCOURGEBANE:
                case NPC_CAPTAIN_ARNATH:
                case NPC_CAPTAIN_BRANDON:
                case NPC_CAPTAIN_GRONDEL:
                case NPC_CAPTAIN_RUPERT:
                    creature->AI()->DoAction(ACTION_RESET_EVENT);
                    break;
                case NPC_SISTER_SVALNA: // she never dies or the event is over
                    creature->AI()->DoAction(ACTION_RESET_EVENT);
                    creature->AI()->EnterEvadeMode();
                    creature->AI()->Reset();
                    return;
                default:
                    return;
            }

            if (CreatureData const* data = creature->GetCreatureData())
                creature->SetPosition(data->posX, data->posY, data->posZ, data->orientation);
            creature->DespawnOrUnsummon();

            creature->SetRespawnTime(5);
        }
};

class CaptainSurviveTalk : public BasicEvent
{
    public:
        explicit CaptainSurviveTalk(Creature const& owner) : _owner(owner) { }

        bool Execute(uint64 /*currTime*/, uint32 /*diff*/)
        {
            _owner.AI()->Talk(SAY_CAPTAIN_SURVIVE_TALK);
            return true;
        }

    private:
        Creature const& _owner;
};

// at Light's Hammer
class npc_highlord_tirion_fordring_lh : public CreatureScript
{
    public:
        npc_highlord_tirion_fordring_lh() : CreatureScript("npc_highlord_tirion_fordring_lh") { }

        struct npc_highlord_tirion_fordringAI : public ScriptedAI
        {
            npc_highlord_tirion_fordringAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
            {
            }

            void Reset()
            {
                _events.Reset();
                _theLichKing = 0;
                _bolvarFordragon = 0;
                _factionNPC = 0;
                _damnedKills = 0;
            }

            // IMPORTANT NOTE: This is triggered from per-GUID scripts
            // of The Damned SAI
            void SetData(uint32 type, uint32 data)
            {
                if (type == DATA_DAMNED_KILLS && data == 1)
                {
                    if (++_damnedKills == 2)
                    {
                        if (Creature* theLichKing = me->FindNearestCreature(NPC_THE_LICH_KING_LH, 150.0f))
                        {
                            if (Creature* bolvarFordragon = me->FindNearestCreature(NPC_HIGHLORD_BOLVAR_FORDRAGON_LH, 150.0f))
                            {
                                if (Creature* factionNPC = me->FindNearestCreature(_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? NPC_HIGH_OVERLORD_SAURFANG_DUMMY : NPC_MURADIN_BRONZEBEARD_DUMMY, 50.0f))
                                {
                                    me->setActive(true);
                                    _theLichKing = theLichKing->GetGUID();
                                    theLichKing->setActive(true);
                                    _bolvarFordragon = bolvarFordragon->GetGUID();
                                    bolvarFordragon->setActive(true);
                                    _factionNPC = factionNPC->GetGUID();
                                    factionNPC->setActive(true);
                                }
                            }
                        }

                        if (!_bolvarFordragon || !_theLichKing || !_factionNPC)
                            return;

                        Talk(SAY_TIRION_INTRO_1);
                        _events.ScheduleEvent(EVENT_TIRION_INTRO_2, 4000);
                        _events.ScheduleEvent(EVENT_TIRION_INTRO_3, 14000);
                        _events.ScheduleEvent(EVENT_TIRION_INTRO_4, 18000);
                        _events.ScheduleEvent(EVENT_TIRION_INTRO_5, 31000);
                        _events.ScheduleEvent(EVENT_LK_INTRO_1, 35000);
                        _events.ScheduleEvent(EVENT_TIRION_INTRO_6, 51000);
                        _events.ScheduleEvent(EVENT_LK_INTRO_2, 58000);
                        _events.ScheduleEvent(EVENT_LK_INTRO_3, 74000);
                        _events.ScheduleEvent(EVENT_LK_INTRO_4, 86000); // sound last 21 seconds (five more)
                        _events.ScheduleEvent(EVENT_BOLVAR_INTRO_1, 105000);
                        _events.ScheduleEvent(EVENT_LK_INTRO_5, 113000);

                        if (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE)
                        {
                            _events.ScheduleEvent(EVENT_SAURFANG_INTRO_1, 125000);
                            _events.ScheduleEvent(EVENT_TIRION_INTRO_H_7, 134000);
                            _events.ScheduleEvent(EVENT_SAURFANG_INTRO_2, 144000);
                            _events.ScheduleEvent(EVENT_SAURFANG_INTRO_3, 155000);
                            _events.ScheduleEvent(EVENT_SAURFANG_INTRO_4, 167000);
                            _events.ScheduleEvent(EVENT_SAURFANG_RUN, 175000);
                        }
                        else
                        {
                            _events.ScheduleEvent(EVENT_MURADIN_INTRO_1, 125000);
                            _events.ScheduleEvent(EVENT_MURADIN_INTRO_2, 129000);
                            _events.ScheduleEvent(EVENT_MURADIN_INTRO_3, 132000);
                            _events.ScheduleEvent(EVENT_TIRION_INTRO_A_7, 141000);
                            _events.ScheduleEvent(EVENT_MURADIN_INTRO_4, 149000);
                            _events.ScheduleEvent(EVENT_MURADIN_INTRO_5, 156000);
                            _events.ScheduleEvent(EVENT_MURADIN_RUN, 162000);
                        }
                    }
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (_damnedKills != 2)
                    return;

                _events.Update(diff);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_TIRION_INTRO_2:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                            break;
                        case EVENT_TIRION_INTRO_3:
                            Talk(SAY_TIRION_INTRO_2);
                            break;
                        case EVENT_TIRION_INTRO_4:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                            break;
                        case EVENT_TIRION_INTRO_5:
                            Talk(SAY_TIRION_INTRO_3);
                            break;
                        case EVENT_LK_INTRO_1:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_POINT_NO_SHEATHE);
                            if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _theLichKing))
                                theLichKing->AI()->Talk(SAY_LK_INTRO_1);
                            break;
                        case EVENT_TIRION_INTRO_6:
                            Talk(SAY_TIRION_INTRO_4);
                            break;
                        case EVENT_LK_INTRO_2:
                            if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _theLichKing))
                                theLichKing->AI()->Talk(SAY_LK_INTRO_2);
                            break;
                        case EVENT_LK_INTRO_3:
                            if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _theLichKing))
                                theLichKing->AI()->Talk(SAY_LK_INTRO_3);
                            break;
                        case EVENT_LK_INTRO_4:
                            if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _theLichKing))
                                theLichKing->AI()->Talk(SAY_LK_INTRO_4);
                            break;
                        case EVENT_BOLVAR_INTRO_1:
                            if (Creature* bolvarFordragon = ObjectAccessor::GetCreature(*me, _bolvarFordragon))
                            {
                                bolvarFordragon->AI()->Talk(SAY_BOLVAR_INTRO_1);
                                bolvarFordragon->setActive(false);
                            }
                            break;
                        case EVENT_LK_INTRO_5:
                            if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _theLichKing))
                            {
                                theLichKing->AI()->Talk(SAY_LK_INTRO_5);
                                theLichKing->setActive(false);
                            }
                            break;
                        case EVENT_SAURFANG_INTRO_1:
                            if (Creature* saurfang = ObjectAccessor::GetCreature(*me, _factionNPC))
                                saurfang->AI()->Talk(SAY_SAURFANG_INTRO_1);
                            break;
                        case EVENT_TIRION_INTRO_H_7:
                            Talk(SAY_TIRION_INTRO_H_5);
                            break;
                        case EVENT_SAURFANG_INTRO_2:
                            if (Creature* saurfang = ObjectAccessor::GetCreature(*me, _factionNPC))
                                saurfang->AI()->Talk(SAY_SAURFANG_INTRO_2);
                            break;
                        case EVENT_SAURFANG_INTRO_3:
                            if (Creature* saurfang = ObjectAccessor::GetCreature(*me, _factionNPC))
                                saurfang->AI()->Talk(SAY_SAURFANG_INTRO_3);
                            break;
                        case EVENT_SAURFANG_INTRO_4:
                            if (Creature* saurfang = ObjectAccessor::GetCreature(*me, _factionNPC))
                                saurfang->AI()->Talk(SAY_SAURFANG_INTRO_4);
                            break;
                        case EVENT_MURADIN_RUN:
                        case EVENT_SAURFANG_RUN:
                            if (Creature* factionNPC = ObjectAccessor::GetCreature(*me, _factionNPC))
                            {
                                factionNPC->GetMotionMaster()->MovePath(factionNPC->GetDBTableGUIDLow() * 10, false);
                                factionNPC->DespawnOrUnsummon(46500);
                                std::list<Creature*> followers;
                                factionNPC->GetCreaturesWithEntryInRange(followers, 30, _instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? NPC_KOR_KRON_GENERAL : NPC_ALLIANCE_COMMANDER);
                                for (Creature* follower : followers)
                                {
                                    follower->DespawnOrUnsummon(46500);
                                }
                            }
                            me->setActive(false);
                            _damnedKills = 3;
                            break;
                        case EVENT_MURADIN_INTRO_1:
                            if (Creature* muradin = ObjectAccessor::GetCreature(*me, _factionNPC))
                                muradin->AI()->Talk(SAY_MURADIN_INTRO_1);
                            break;
                        case EVENT_MURADIN_INTRO_2:
                            if (Creature* muradin = ObjectAccessor::GetCreature(*me, _factionNPC))
                                muradin->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                            break;
                        case EVENT_MURADIN_INTRO_3:
                            if (Creature* muradin = ObjectAccessor::GetCreature(*me, _factionNPC))
                                muradin->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                            break;
                        case EVENT_TIRION_INTRO_A_7:
                            Talk(SAY_TIRION_INTRO_A_5);
                            break;
                        case EVENT_MURADIN_INTRO_4:
                            if (Creature* muradin = ObjectAccessor::GetCreature(*me, _factionNPC))
                                muradin->AI()->Talk(SAY_MURADIN_INTRO_2);
                            break;
                        case EVENT_MURADIN_INTRO_5:
                            if (Creature* muradin = ObjectAccessor::GetCreature(*me, _factionNPC))
                                muradin->AI()->Talk(SAY_MURADIN_INTRO_3);
                            break;
                        default:
                            break;
                    }
                }
            }

        private:
            EventMap _events;
            InstanceScript* const _instance;
            uint64 _theLichKing;
            uint64 _bolvarFordragon;
            uint64 _factionNPC;
            uint16 _damnedKills;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_highlord_tirion_fordringAI>(creature);
        }
};

class npc_rotting_frost_giant : public CreatureScript
{
    public:
        npc_rotting_frost_giant() : CreatureScript("npc_rotting_frost_giant") { }

        struct npc_rotting_frost_giantAI : public ScriptedAI
        {
            npc_rotting_frost_giantAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_DEATH_PLAGUE, 15000);
                _events.ScheduleEvent(EVENT_STOMP, urand(5000, 8000));
                _events.ScheduleEvent(EVENT_ARCTIC_BREATH, urand(10000, 15000));
            }

            void JustDied(Unit* /*killer*/)
            {
                _events.Reset();
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_DEATH_PLAGUE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true, -SPELL_RECENTLY_INFECTED))
                            {
                                Talk(EMOTE_DEATH_PLAGUE_WARNING, target);
                                DoCast(target, SPELL_DEATH_PLAGUE);
                            }
                            _events.ScheduleEvent(EVENT_DEATH_PLAGUE, 15000);
                            break;
                        case EVENT_STOMP:
                            DoCastVictim(SPELL_STOMP);
                            _events.ScheduleEvent(EVENT_STOMP, urand(15000, 18000));
                            break;
                        case EVENT_ARCTIC_BREATH:
                            DoCastVictim(SPELL_ARCTIC_BREATH);
                            _events.ScheduleEvent(EVENT_ARCTIC_BREATH, urand(26000, 33000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_rotting_frost_giantAI>(creature);
        }
};

class npc_frost_freeze_trap : public CreatureScript
{
    public:
        npc_frost_freeze_trap() : CreatureScript("npc_frost_freeze_trap") { }

        struct npc_frost_freeze_trapAI: public NullCreatureAI
        {
            npc_frost_freeze_trapAI(Creature* creature) : NullCreatureAI(creature)
            {
                me->SetReactState(REACT_PASSIVE);
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case 1000:
                    case 11000:
                        _events.ScheduleEvent(EVENT_ACTIVATE_TRAP, uint32(action));
                        break;
                    default:
                        break;
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (me->IsInCombat())
                    me->CombatStop(false);

                _events.Update(diff);

                if (_events.ExecuteEvent() == EVENT_ACTIVATE_TRAP)
                    if (InstanceScript* instance = me->GetInstanceScript())
                        if (instance->GetData(DATA_COLDFLAME_JETS) == IN_PROGRESS)
                        {
                            DoCast(me, SPELL_COLDFLAME_JETS);
                            _events.ScheduleEvent(EVENT_ACTIVATE_TRAP, 22000);
                        }
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_frost_freeze_trapAI>(creature);
        }
};

class npc_crok_scourgebane : public CreatureScript
{
    public:
        npc_crok_scourgebane() : CreatureScript("npc_crok_scourgebane") { }

        struct npc_crok_scourgebaneAI : public npc_escortAI
        {
            npc_crok_scourgebaneAI(Creature* creature) : npc_escortAI(creature), _instance(creature->GetInstanceScript())
            {
                SetDespawnAtEnd(false);
                SetDespawnAtFar(false);
                _isEventDone = _instance->GetBossState(DATA_SISTER_SVALNA) == DONE;
            }

            void Reset()
            {
                me->SetReactState(REACT_DEFENSIVE);
                _didUnderTenPercentText = false;
                _wipeCheckTimer = 3000;
                _handledWP4 = false;

                _events.Reset();
                _events.ScheduleEvent(EVENT_SCOURGE_STRIKE, urand(7500, 12500));
                _events.ScheduleEvent(EVENT_DEATH_STRIKE, urand(25000, 30000));
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_START_GAUNTLET)
                {
                    if (_isEventDone || me->isActiveObject() || !me->IsAlive())
                        return;

                    me->setActive(true);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
                    // Load Grid with Sister Svalna
                    me->GetMap()->LoadGrid(4356.71f, 2484.33f);
                    if (Creature* svalna = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_SISTER_SVALNA)))
                        svalna->AI()->DoAction(ACTION_START_GAUNTLET);
                    for (uint32 i = 0; i < 4; ++i)
                        if (Creature* crusader = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_CAPTAIN_ARNATH + i)))
                            crusader->AI()->DoAction(ACTION_START_GAUNTLET);

                    Talk(SAY_CROK_INTRO_1);
                    _events.ScheduleEvent(EVENT_ARNATH_INTRO_2, 7000);
                    _events.ScheduleEvent(EVENT_CROK_INTRO_3, 14000);
                    _events.ScheduleEvent(EVENT_START_PATHING, 37000);
                }
                else if (action == ACTION_RESET_EVENT)
                {
                    _isEventDone = _instance->GetBossState(DATA_SISTER_SVALNA) == DONE;
                    me->setActive(false);
                    _aliveTrash.clear();
                    _currentWPid = 0;
                    _handledWP4 = false;

                    me->CombatStop();
                    me->DeleteThreatList();
                }
            }

            void SetGUID(uint64 guid, int32 type/* = 0*/)
            {
                if (type == ACTION_VRYKUL_DEATH)
                {
                    _aliveTrash.erase(guid);
                    if (_aliveTrash.empty())
                    {
                        SetEscortPaused(false);
                        if (_currentWPid == 4 && !_handledWP4)
                        {
                            _handledWP4 = true;
                            Talk(SAY_CROK_FINAL_WP);
                            if (Creature* svalna = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_SISTER_SVALNA)))
                                svalna->AI()->DoAction(ACTION_RESURRECT_CAPTAINS);
                        }
                    }
                }
            }

            void WaypointReached(uint32 waypointId)
            {
                switch (waypointId)
                {
                    // pause pathing until trash pack is cleared
                    case 0:
                        Talk(SAY_CROK_COMBAT_WP_0);
                        if (!_aliveTrash.empty())
                            SetEscortPaused(true);
                        break;
                    case 1:
                        Talk(SAY_CROK_COMBAT_WP_1);
                        if (!_aliveTrash.empty())
                            SetEscortPaused(true);
                        break;
                    case 2:
                        if (!_aliveTrash.empty())
                            SetEscortPaused(true);
                        break;
                    case 4:
                        if (_aliveTrash.empty() && !_handledWP4)
                        {
                            _handledWP4 = true;
                            Talk(SAY_CROK_FINAL_WP);
                            if (Creature* svalna = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_SISTER_SVALNA)))
                                svalna->AI()->DoAction(ACTION_RESURRECT_CAPTAINS);
                        }
                        break;
                    default:
                        break;
                }
            }

            void WaypointStart(uint32 waypointId)
            {
                _currentWPid = waypointId;
                float minY = 0.0f;
                switch (waypointId)
                {
                    case 0:
                        minY = 2600.0f;
                        break;
                    case 1:
                        minY = 2550.0f;
                        if (Creature* svalna = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_SISTER_SVALNA)))
                            svalna->AI()->DoAction(ACTION_KILL_CAPTAIN);
                        break;
                    case 2:
                        minY = 2515.0f;
                        if (Creature* svalna = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_SISTER_SVALNA)))
                            svalna->AI()->DoAction(ACTION_KILL_CAPTAIN);
                        break;
                    case 4:
                        minY = 2475.0f;
                        break;
                    default:
                        break;
                }

                if (minY)
                {
                    // get all nearby vrykul
                    std::list<Creature*> temp;
                    FrostwingVrykulSearcher check(me, 150.0f);
                    acore::CreatureListSearcher<FrostwingVrykulSearcher> searcher(me, temp, check);
                    me->VisitNearbyGridObject(150.0f, searcher);

                    _aliveTrash.clear();
                    for (std::list<Creature*>::iterator itr = temp.begin(); itr != temp.end(); ++itr)
                        if ((*itr)->GetHomePosition().GetPositionY() > minY)
                            _aliveTrash.insert((*itr)->GetGUID());
                }
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (HealthBelowPct(10))
                {
                    if (!_didUnderTenPercentText)
                    {
                        _didUnderTenPercentText = true;
                        if (me->GetVictim() && me->GetVictim()->GetEntry() == NPC_SISTER_SVALNA)
                            Talk(SAY_CROK_WEAKENING_SVALNA);
                        else
                            Talk(SAY_CROK_WEAKENING_GAUNTLET);
                    }

                    damage = 0;
                    me->CastSpell(me, SPELL_ICEBOUND_ARMOR, true);
                    _events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
                }
            }

            void UpdateEscortAI(uint32  /*diff*/) {}

            void UpdateAI(uint32 diff)
            {
                npc_escortAI::UpdateAI(diff);

                //Position pos = me->GetHomePosition();
                if (!me->isActiveObject()/* && me->GetExactDist(&pos) < 5.0f*/) // during event
                    return;

                if (_wipeCheckTimer <= diff)
                {
                    _wipeCheckTimer = 3000;

                    Player* player = nullptr;
                    acore::AnyPlayerInObjectRangeCheck check(me, 140.0f);
                    acore::PlayerSearcher<acore::AnyPlayerInObjectRangeCheck> searcher(me, player, check);
                    me->VisitNearbyWorldObject(140.0f, searcher);
                    // wipe
                    if (!player || me->GetExactDist(4357.0f, 2606.0f, 350.0f) > 125.0f)
                    {
                        //Talk(SAY_CROK_DEATH);
                        FrostwingGauntletRespawner respawner;
                        acore::CreatureWorker<FrostwingGauntletRespawner> worker(me, respawner);
                        me->VisitNearbyGridObject(333.0f, worker);
                        return;
                    }
                }
                else
                    _wipeCheckTimer -= diff;

                UpdateVictim();

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_ARNATH_INTRO_2:
                        if (Creature* arnath = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_CAPTAIN_ARNATH)))
                            arnath->AI()->Talk(SAY_ARNATH_INTRO_2);
                        break;
                    case EVENT_CROK_INTRO_3:
                        Talk(SAY_CROK_INTRO_3);
                        break;
                    case EVENT_START_PATHING:
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
                        Start(true, true);
                        break;
                    case EVENT_SCOURGE_STRIKE:
                        DoCastVictim(SPELL_SCOURGE_STRIKE);
                        _events.ScheduleEvent(EVENT_SCOURGE_STRIKE, urand(10000, 14000));
                        break;
                    case EVENT_DEATH_STRIKE:
                        if (HealthBelowPct(20))
                            DoCastVictim(SPELL_DEATH_STRIKE);
                        _events.ScheduleEvent(EVENT_DEATH_STRIKE, urand(5000, 10000));
                        break;
                    case EVENT_HEALTH_CHECK:
                        if (HealthAbovePct(25))
                        {
                            me->RemoveAurasDueToSpell(SPELL_ICEBOUND_ARMOR);
                            _didUnderTenPercentText = false;
                        }
                        else
                        {
                            Unit::DealHeal(me, me, me->CountPctFromMaxHealth(3));
                            _events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
                        }
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

            bool CanAIAttack(Unit const* target) const
            {
                // do not see targets inside Frostwing Halls when we are not there
                return target->GetTypeId() != TYPEID_PLAYER && (me->GetPositionY() > 2660.0f) == (target->GetPositionY() > 2660.0f) && target->GetEntry() != NPC_SINDRAGOSA;
            }

        private:
            EventMap _events;
            std::set<uint64> _aliveTrash;
            InstanceScript* _instance;
            uint32 _currentWPid;
            uint32 _wipeCheckTimer;
            bool _handledWP4;
            bool _isEventDone;
            bool _didUnderTenPercentText;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_crok_scourgebaneAI>(creature);
        }
};

class boss_sister_svalna : public CreatureScript
{
    public:
        boss_sister_svalna() : CreatureScript("boss_sister_svalna") { }

        struct boss_sister_svalnaAI : public BossAI
        {
            boss_sister_svalnaAI(Creature* creature) : BossAI(creature, DATA_SISTER_SVALNA)
            {
            }

            void Reset()
            {
                _Reset();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetReactState(REACT_PASSIVE);
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->SetHover(true);
                me->SendMovementFlagUpdate();
            }

            void AttackStart(Unit* victim)
            {
                if (me->HasReactState(REACT_PASSIVE) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC))
                    return;
                BossAI::AttackStart(victim);
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
                Talk(SAY_SVALNA_DEATH);

                if (Creature* crok = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_CROK_SCOURGEBANE))) // _isEventDone = true, setActive(false)
                    crok->AI()->DoAction(ACTION_RESET_EVENT);

                uint64 delay = 6000;
                for (uint32 i = 0; i < 4; ++i)
                    if (Creature* crusader = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_CAPTAIN_ARNATH + i)))
                        if (crusader->IsAlive())
                        {
                            if (crusader->GetEntry() == crusader->GetCreatureData()->id)
                            {
                                crusader->m_Events.AddEvent(new CaptainSurviveTalk(*crusader), crusader->m_Events.CalculateTime(delay));
                                delay += 6000;
                            }
                            else
                                Unit::Kill(crusader, crusader);
                        }
            }

            void EnterCombat(Unit* /*attacker*/)
            {
                if (me->HasReactState(REACT_PASSIVE) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC))
                {
                    me->CombatStop(false);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetReactState(REACT_PASSIVE);
                    return;
                }
                _EnterCombat();
                me->LowerPlayerDamageReq(me->GetMaxHealth());
                if (Creature* crok = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_CROK_SCOURGEBANE)))
                {
                    crok->AI()->Talk(SAY_CROK_COMBAT_SVALNA);
                    crok->AI()->AttackStart(me);
                }
                events.ScheduleEvent(EVENT_SVALNA_COMBAT, 9000);
                events.ScheduleEvent(EVENT_IMPALING_SPEAR, urand(15000, 20000));
            }

            void KilledUnit(Unit* victim)
            {
                switch (victim->GetTypeId())
                {
                    case TYPEID_PLAYER:
                        Talk(SAY_SVALNA_KILL);
                        break;
                    /*case TYPEID_UNIT: // captains also say something on death and this causes spam
                        switch (victim->GetEntry())
                        {
                            case NPC_CAPTAIN_ARNATH:
                            case NPC_CAPTAIN_BRANDON:
                            case NPC_CAPTAIN_GRONDEL:
                            case NPC_CAPTAIN_RUPERT:
                                Talk(SAY_SVALNA_KILL_CAPTAIN);
                                break;
                            default:
                                break;
                        }
                        break;*/
                    default:
                        break;
                }
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_KILL_CAPTAIN:
                        if (me->IsAlive())
                            me->CastCustomSpell(SPELL_CARESS_OF_DEATH, SPELLVALUE_MAX_TARGETS, 1, me, true);
                        break;
                    case ACTION_START_GAUNTLET:
                        me->setActive(true);
                        events.ScheduleEvent(EVENT_SVALNA_START, 25000);
                        break;
                    case ACTION_RESURRECT_CAPTAINS:
                        events.RescheduleEvent(EVENT_SVALNA_RESURRECT, 7000);
                        break;
                    case ACTION_CAPTAIN_DIES:
                        Talk(SAY_SVALNA_CAPTAIN_DEATH);
                        break;
                    case ACTION_RESET_EVENT:
                        me->setActive(false);
                        Reset();
                        break;
                    default:
                        break;
                }
            }

            void SpellHit(Unit* caster, SpellInfo const* spell)
            {
                if (spell->Id == SPELL_HURL_SPEAR && me->HasAura(SPELL_AETHER_SHIELD))
                {
                    me->RemoveAurasDueToSpell(SPELL_AETHER_SHIELD);
                    Talk(EMOTE_SVALNA_BROKEN_SHIELD, caster);
                }
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != EFFECT_MOTION_TYPE || id != POINT_LAND)
                    return;

                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SetHover(false);
                me->SetReactState(REACT_AGGRESSIVE);
                DoZoneInCombat(nullptr, 150.0f);
            }

            void SpellHitTarget(Unit* target, SpellInfo const* spell)
            {
                switch (spell->Id)
                {
                    case SPELL_IMPALING_SPEAR_KILL:
                        Unit::Kill(me, target);
                        break;
                    case SPELL_IMPALING_SPEAR:
                        if (TempSummon* summon = target->SummonCreature(NPC_IMPALING_SPEAR, *target))
                        {
                            Talk(EMOTE_SVALNA_IMPALE, target);
                            summon->CastCustomSpell(VEHICLE_SPELL_RIDE_HARDCODED, SPELLVALUE_BASE_POINT0, 1, target, false);
                            summon->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_UNK1 | UNIT_FLAG2_ALLOW_ENEMY_INTERACT);
                        }
                        break;
                    default:
                        break;
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!me->isActiveObject())
                    return;

                UpdateVictim();

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SVALNA_START:
                        Talk(SAY_SVALNA_EVENT_START);
                        break;
                    case EVENT_SVALNA_RESURRECT:
                        Talk(SAY_SVALNA_RESURRECT_CAPTAINS);
                        me->CastSpell(me, SPELL_REVIVE_CHAMPION, false);
                        break;
                    case EVENT_SVALNA_COMBAT:
                        Talk(SAY_SVALNA_AGGRO);
                        break;
                    case EVENT_IMPALING_SPEAR:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true, -SPELL_IMPALING_SPEAR))
                        {
                            DoCast(me, SPELL_AETHER_SHIELD);
                            me->AddAura(70203, me);
                            DoCast(target, SPELL_IMPALING_SPEAR);
                        }
                        events.ScheduleEvent(EVENT_IMPALING_SPEAR, urand(20000, 25000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_sister_svalnaAI>(creature);
        }
};

struct npc_argent_captainAI : public ScriptedAI
{
    public:
        npc_argent_captainAI(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript())
        {
            FollowAngle = PET_FOLLOW_ANGLE;
            FollowDist = PET_FOLLOW_DIST;
        }

        void Reset()
        {
            me->SetCorpseDelay(DAY); // leave corpse for a long time so svalna can resurrect
            IsUndead = (me->GetCreatureData() && me->GetCreatureData()->id != me->GetEntry());
        }

        void JustDied(Unit* /*killer*/)
        {
            if (IsUndead)
                Talk(SAY_CAPTAIN_DEATH);
            else
                Talk(SAY_CAPTAIN_SECOND_DEATH);

            IsUndead = false;
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_CAPTAIN_KILL);
        }

        void DoAction(int32 action)
        {
            if (action == ACTION_START_GAUNTLET)
            {
                if (Creature* crok = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_CROK_SCOURGEBANE)))
                {
                    FollowAngle = me->GetAngle(crok) + me->GetOrientation();
                    FollowDist = me->GetDistance2d(crok);
                    me->GetMotionMaster()->MoveFollow(crok, FollowDist, FollowAngle, MOTION_SLOT_IDLE);
                }
            }
        }

        void EnterCombat(Unit* /*target*/)
        {
            if (IsUndead)
                DoZoneInCombat();
        }

        bool CanAIAttack(Unit const* target) const
        {
            // do not see targets inside Frostwing Halls when we are not there
            return (me->GetPositionY() > 2660.0f) == (target->GetPositionY() > 2660.0f) && (target->GetTypeId() == TYPEID_PLAYER || target->IsInCombat());
        }

        void EnterEvadeMode()
        {
            if (!_EnterEvadeMode())
                return;

            me->GetMotionMaster()->Clear(false);
            if (Creature* crok = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_CROK_SCOURGEBANE)))
                me->GetMotionMaster()->MoveFollow(crok, FollowDist, FollowAngle, MOTION_SLOT_IDLE);
            else
                me->GetMotionMaster()->MoveTargetedHome();

            Reset();
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_REVIVE_CHAMPION && !IsUndead)
            {
                me->setDeathState(JUST_RESPAWNED);
                uint32 newEntry = 0;
                switch (me->GetEntry())
                {
                    case NPC_CAPTAIN_ARNATH:
                        newEntry = NPC_CAPTAIN_ARNATH_UNDEAD;
                        break;
                    case NPC_CAPTAIN_BRANDON:
                        newEntry = NPC_CAPTAIN_BRANDON_UNDEAD;
                        break;
                    case NPC_CAPTAIN_GRONDEL:
                        newEntry = NPC_CAPTAIN_GRONDEL_UNDEAD;
                        break;
                    case NPC_CAPTAIN_RUPERT:
                        newEntry = NPC_CAPTAIN_RUPERT_UNDEAD;
                        break;
                    default:
                        return;
                }

                Talk(SAY_CAPTAIN_RESURRECTED);
                me->UpdateEntry(newEntry, me->GetCreatureData());
                IsUndead = true;
                DoCast(me, SPELL_UNDEATH, true);
                if (Player* p = me->SelectNearestPlayer(150.0f))
                    AttackStart(p);
                me->SetInCombatWithZone();
            }
        }

    protected:
        EventMap Events;
        InstanceScript* instance;
        float FollowAngle;
        float FollowDist;
        bool IsUndead;
};

class npc_captain_arnath : public CreatureScript
{
    public:
        npc_captain_arnath() : CreatureScript("npc_captain_arnath") { }

        struct npc_captain_arnathAI : public npc_argent_captainAI
        {
            npc_captain_arnathAI(Creature* creature) : npc_argent_captainAI(creature)
            {
            }

            void Reset()
            {
                npc_argent_captainAI::Reset();
                Events.Reset();
                Events.ScheduleEvent(EVENT_ARNATH_FLASH_HEAL, urand(4000, 7000));
                Events.ScheduleEvent(EVENT_ARNATH_PW_SHIELD, urand(8000, 14000));
                Events.ScheduleEvent(EVENT_ARNATH_SMITE, urand(3000, 6000));
                if (Is25ManRaid() && IsUndead)
                    Events.ScheduleEvent(EVENT_ARNATH_DOMINATE_MIND, urand(22000, 27000));
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                Events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (Events.ExecuteEvent())
                {
                    case EVENT_ARNATH_FLASH_HEAL:
                        if (Creature* target = FindFriendlyCreature())
                            DoCast(target, SPELL_FLASH_HEAL);
                        Events.ScheduleEvent(EVENT_ARNATH_FLASH_HEAL, urand(6000, 9000));
                        break;
                    case EVENT_ARNATH_PW_SHIELD:
                    {
                        std::list<Creature*> targets = DoFindFriendlyMissingBuff(40.0f, SPELL_POWER_WORD_SHIELD);
                        if (!targets.empty())
                            DoCast(acore::Containers::SelectRandomContainerElement(targets), SPELL_POWER_WORD_SHIELD);
                        Events.ScheduleEvent(EVENT_ARNATH_PW_SHIELD, urand(15000, 20000));
                        break;
                    }
                    case EVENT_ARNATH_SMITE:
                        DoCastVictim(SPELL_SMITE);
                        Events.ScheduleEvent(EVENT_ARNATH_SMITE, urand(4000, 7000));
                        break;
                    case EVENT_ARNATH_DOMINATE_MIND:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true, -SPELL_DOMINATE_MIND))
                            DoCast(target, SPELL_DOMINATE_MIND);
                        Events.ScheduleEvent(EVENT_ARNATH_DOMINATE_MIND, urand(28000, 37000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            Creature* FindFriendlyCreature() const
            {
                Creature* target = nullptr;
                acore::MostHPMissingInRange u_check(me, 60.0f, 0);
                acore::CreatureLastSearcher<acore::MostHPMissingInRange> searcher(me, target, u_check);
                me->VisitNearbyGridObject(60.0f, searcher);
                return target;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_captain_arnathAI>(creature);
        }
};

class npc_captain_brandon : public CreatureScript
{
    public:
        npc_captain_brandon() : CreatureScript("npc_captain_brandon") { }

        struct npc_captain_brandonAI : public npc_argent_captainAI
        {
            npc_captain_brandonAI(Creature* creature) : npc_argent_captainAI(creature)
            {
            }

            void Reset()
            {
                npc_argent_captainAI::Reset();
                Events.Reset();
                Events.ScheduleEvent(EVENT_BRANDON_CRUSADER_STRIKE, urand(6000, 10000));
                Events.ScheduleEvent(EVENT_BRANDON_DIVINE_SHIELD, 500);
                Events.ScheduleEvent(EVENT_BRANDON_JUDGEMENT_OF_COMMAND, urand(8000, 13000));
                if (IsUndead)
                    Events.ScheduleEvent(EVENT_BRANDON_HAMMER_OF_BETRAYAL, urand(25000, 30000));
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                Events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = Events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_BRANDON_CRUSADER_STRIKE:
                            DoCastVictim(SPELL_CRUSADER_STRIKE);
                            Events.ScheduleEvent(EVENT_BRANDON_CRUSADER_STRIKE, urand(6000, 12000));
                            break;
                        case EVENT_BRANDON_DIVINE_SHIELD:
                            if (HealthBelowPct(20))
                                DoCast(me, SPELL_DIVINE_SHIELD);
                            Events.ScheduleEvent(EVENT_BRANDON_DIVINE_SHIELD, 500);
                            break;
                        case EVENT_BRANDON_JUDGEMENT_OF_COMMAND:
                            DoCastVictim(SPELL_JUDGEMENT_OF_COMMAND);
                            Events.ScheduleEvent(EVENT_BRANDON_JUDGEMENT_OF_COMMAND, urand(8000, 13000));
                            break;
                        case EVENT_BRANDON_HAMMER_OF_BETRAYAL:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                                DoCast(target, SPELL_HAMMER_OF_BETRAYAL);
                            Events.ScheduleEvent(EVENT_BRANDON_HAMMER_OF_BETRAYAL, urand(45000, 60000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_captain_brandonAI>(creature);
        }
};

class npc_captain_grondel : public CreatureScript
{
    public:
        npc_captain_grondel() : CreatureScript("npc_captain_grondel") { }

        struct npc_captain_grondelAI : public npc_argent_captainAI
        {
            npc_captain_grondelAI(Creature* creature) : npc_argent_captainAI(creature)
            {
            }

            void Reset()
            {
                npc_argent_captainAI::Reset();
                Events.Reset();
                Events.ScheduleEvent(EVENT_GRONDEL_CHARGE_CHECK, 500);
                Events.ScheduleEvent(EVENT_GRONDEL_MORTAL_STRIKE, urand(8000, 14000));
                Events.ScheduleEvent(EVENT_GRONDEL_SUNDER_ARMOR, urand(3000, 12000));
                if (IsUndead)
                    Events.ScheduleEvent(EVENT_GRONDEL_CONFLAGRATION, urand(12000, 17000));
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                Events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = Events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_GRONDEL_CHARGE_CHECK:
                            DoCastVictim(SPELL_CHARGE);
                            Events.ScheduleEvent(EVENT_GRONDEL_CHARGE_CHECK, 500);
                            break;
                        case EVENT_GRONDEL_MORTAL_STRIKE:
                            DoCastVictim(SPELL_MORTAL_STRIKE);
                            Events.ScheduleEvent(EVENT_GRONDEL_MORTAL_STRIKE, urand(10000, 15000));
                            break;
                        case EVENT_GRONDEL_SUNDER_ARMOR:
                            DoCastVictim(SPELL_SUNDER_ARMOR);
                            Events.ScheduleEvent(EVENT_GRONDEL_SUNDER_ARMOR, urand(5000, 17000));
                            break;
                        case EVENT_GRONDEL_CONFLAGRATION:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                                DoCast(target, SPELL_CONFLAGRATION);
                            Events.ScheduleEvent(EVENT_GRONDEL_CONFLAGRATION, urand(10000, 15000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_captain_grondelAI>(creature);
        }
};

class npc_captain_rupert : public CreatureScript
{
    public:
        npc_captain_rupert() : CreatureScript("npc_captain_rupert") { }

        struct npc_captain_rupertAI : public npc_argent_captainAI
        {
            npc_captain_rupertAI(Creature* creature) : npc_argent_captainAI(creature)
            {
            }

            void Reset()
            {
                npc_argent_captainAI::Reset();
                Events.Reset();
                Events.ScheduleEvent(EVENT_RUPERT_FEL_IRON_BOMB, urand(15000, 20000));
                Events.ScheduleEvent(EVENT_RUPERT_MACHINE_GUN, urand(25000, 30000));
                Events.ScheduleEvent(EVENT_RUPERT_ROCKET_LAUNCH, urand(10000, 15000));
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                Events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = Events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_RUPERT_FEL_IRON_BOMB:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_FEL_IRON_BOMB);
                            Events.ScheduleEvent(EVENT_RUPERT_FEL_IRON_BOMB, urand(15000, 20000));
                            break;
                        case EVENT_RUPERT_MACHINE_GUN:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                                DoCast(target, SPELL_MACHINE_GUN);
                            Events.ScheduleEvent(EVENT_RUPERT_MACHINE_GUN, urand(25000, 30000));
                            break;
                        case EVENT_RUPERT_ROCKET_LAUNCH:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                                DoCast(target, SPELL_ROCKET_LAUNCH);
                            Events.ScheduleEvent(EVENT_RUPERT_ROCKET_LAUNCH, urand(10000, 15000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_captain_rupertAI>(creature);
        }
};

enum FrostwingVrykl
{
    SPELL_SPIRIT_STREAM                 = 69929,

    NPC_INVISIBLE_STALKER_3_0           = 38310
};

class npc_frostwing_vrykul : public CreatureScript
{
    public:
        npc_frostwing_vrykul() : CreatureScript("npc_frostwing_vrykul") { }

        struct npc_frostwing_vrykulAI : public ScriptedAI
        {
            npc_frostwing_vrykulAI(Creature* creature) : ScriptedAI(creature), summons(me)
            {
                if (me->GetEntry() == NPC_YMIRJAR_DEATHBRINGER || me->GetEntry() == NPC_YMIRJAR_FROSTBINDER || me->GetEntry() == NPC_YMIRJAR_HUNTRESS)
                    isRanged = true;
                else
                    isRanged = false;
            }

            EventMap events;
            EventMap events2;
            SummonList summons;
            bool isRanged;

            void AttackStart(Unit* victim)
            {
                if (me->GetEntry() == NPC_YMIRJAR_FROSTBINDER)
                    ScriptedAI::AttackStartNoMove(victim);
                else if (isRanged)
                    ScriptedAI::AttackStartCaster(victim, 16.0f);
                else
                    ScriptedAI::AttackStart(victim);
            }

            void EnterCombat(Unit* /*who*/)
            {
                me->InterruptNonMeleeSpells(false);
                me->CallForHelp(8.5f);
                if (me->GetEntry() == NPC_YMIRJAR_FROSTBINDER)
                    me->SetHover(true);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
            }

            void Reset()
            {
                summons.DespawnAll();
                events.Reset();
                events2.Reset();
                switch (me->GetEntry())
                {
                    case NPC_YMIRJAR_HUNTRESS:
                        events.ScheduleEvent(1, urand(10000, 15000)); // Ice Trap
                        events.ScheduleEvent(2, urand(8000, 12000)); // Rapid Shot
                        events.ScheduleEvent(3, urand(6000, 10000)); // Volley
                        if (me->GetMap()->Is25ManRaid())
                            events.ScheduleEvent(4, 5000); // Summon Warhawk
                        break;
                    case NPC_YMIRJAR_WARLORD:
                        events.ScheduleEvent(11, 6000); // Whirlwind
                        break;
                    case NPC_YMIRJAR_BATTLE_MAIDEN:
                        events.ScheduleEvent(21, 3000); // Barbaric Strike
                        events.ScheduleEvent(22, urand(8000, 12000)); // Adrenaline Rush
                        break;
                    case NPC_YMIRJAR_FROSTBINDER:
                        events.ScheduleEvent(31, 0); // Arctic Chill
                        events.ScheduleEvent(32, urand(15000, 25000)); // Frozen Orb
                        events.ScheduleEvent(33, urand(15000, 30000)); // Twisted Winds
                        events2.ScheduleEvent(100, 0); // Spirit Stream
                        me->SetHover(false);
                        break;
                    case NPC_YMIRJAR_DEATHBRINGER:
                        events.ScheduleEvent(41, 2500); // Empowered Shadow Bolt
                        events.ScheduleEvent(42, 5000); // Summon Undead
                        events2.ScheduleEvent(100, 0); // Spirit Stream
                        break;
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!me->IsInCombat())
                {
                    events2.Update(diff);
                    switch (events2.ExecuteEvent())
                    {
                        case 100:
                            if (Creature* stalker = me->FindNearestCreature(NPC_INVISIBLE_STALKER_3_0, 50.0f))
                                me->CastSpell(stalker, SPELL_SPIRIT_STREAM, false);
                            events2.ScheduleEvent(100, 33000);
                            break;
                    }
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED) || ((me->GetEntry() == NPC_YMIRJAR_DEATHBRINGER || me->GetEntry() == NPC_YMIRJAR_FROSTBINDER) && me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED)))
                    return;

                switch (events.GetEvent())
                {
                    case 0:
                        break;
                    case 1: // Ice Trap
                        me->CastSpell((Unit*)NULL, 71249, false);
                        events.RepeatEvent(urand(35000, 40000));
                        break;
                    case 2: // Rapid Shot
                        me->CastSpell(me->GetVictim(), 71251, false);
                        events.RepeatEvent(urand(25000, 30000));
                        break;
                    case 3: // Volley
                        {
                            Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 35.0f, true);
                            if (target && me->GetDistance(target) > 10.0f)
                            {
                                me->CastSpell(target, 71252, false);
                                events.RepeatEvent(urand(25000, 35000));
                            }
                            else
                                events.RepeatEvent(2500);
                        }
                        break;
                    case 4: // Summon Warhawk
                        me->CastSpell(me, 71705, false);
                        events.PopEvent();
                        break;
                    case 11: // Whirlwind
                        me->CastSpell(me->GetVictim(), 41056, false);
                        events.RepeatEvent(6000);
                        break;
                    case 21: // Barbaric Strike
                        me->CastSpell(me->GetVictim(), 71257, false);
                        events.RepeatEvent(3000);
                        break;
                    case 22: // Adrenaline Rush
                        me->CastSpell(me, 71258, false);
                        events.RepeatEvent(urand(15000, 25000));
                        break;
                    case 31: // Arctic Chill
                        me->CastSpell(me, 71270, true);
                        events.PopEvent();
                        break;
                    case 32: // Frozen Orb
                        if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 30.0f, true))
                            me->CastSpell(target, 71274, false);
                        events.RepeatEvent(urand(40000, 50000));
                        break;
                    case 33: // Twisted Winds
                        me->CastSpell((Unit*)NULL, 71306, false);
                        events.RepeatEvent(urand(35000, 50000));
                        break;
                    case 41: // Empowered Shadow Bolt
                        me->CastSpell(me->GetVictim(), 69528, false);
                        events.RepeatEvent(2500);
                        break;
                    case 42: // Summon Undead
                        me->CastSpell(me->GetVictim(), 69516, false);
                        events.RepeatEvent(45000);
                        break;
                    default:
                        events.PopEvent();
                        break;
                }

                if (me->GetEntry() == NPC_YMIRJAR_HUNTRESS && me->GetVictim() && me->GetDistance(me->GetVictim()) > 5.0f)
                    DoSpellAttackIfReady(71253); // Shoot
                else
                    DoMeleeAttackIfReady();
            }

            void SpellHitTarget(Unit* c, const SpellInfo* spell)
            {
                if (spell->Id == 71306 && c->GetTypeId() == TYPEID_UNIT) // Twisted Winds
                {
                    Position myPos;
                    me->GetPosition(&myPos);
                    me->NearTeleportTo(c->GetPositionX(), c->GetPositionY(), c->GetPositionZ(), c->GetOrientation());
                    c->NearTeleportTo(myPos.GetPositionX(), myPos.GetPositionY(), myPos.GetPositionZ(), myPos.GetOrientation());
                    const ThreatContainer::StorageType me_tl = me->getThreatManager().getThreatList();
                    const ThreatContainer::StorageType target_tl = c->getThreatManager().getThreatList();
                    DoResetThreat();
                    for (ThreatContainer::StorageType::const_iterator iter = target_tl.begin(); iter != target_tl.end(); ++iter)
                        me->getThreatManager().addThreat((*iter)->getTarget(), (*iter)->getThreat());

                    c->getThreatManager().resetAllAggro();
                    for (ThreatContainer::StorageType::const_iterator iter = me_tl.begin(); iter != me_tl.end(); ++iter)
                        c->getThreatManager().addThreat((*iter)->getTarget(), (*iter)->getThreat());

                }
            }

            bool CanAIAttack(Unit const* target) const
            {
                // do not see targets inside Frostwing Halls when we are not there
                return (me->GetPositionY() > 2660.0f) == (target->GetPositionY() > 2660.0f);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_frostwing_vrykulAI(creature);
        }
};

class npc_impaling_spear : public CreatureScript
{
    public:
        npc_impaling_spear() : CreatureScript("npc_impaling_spear") { }

        struct npc_impaling_spearAI : public NullCreatureAI
        {
            npc_impaling_spearAI(Creature* creature) : NullCreatureAI(creature)
            {
            }

            void Reset()
            {
                me->SetReactState(REACT_PASSIVE);
                _vehicleCheckTimer = 500;
            }

            void UpdateAI(uint32 diff)
            {
                if (_vehicleCheckTimer <= diff)
                {
                    _vehicleCheckTimer = 500;
                    if (!me->GetVehicle())
                        me->DespawnOrUnsummon(100);
                }
                else
                    _vehicleCheckTimer -= diff;
            }

            uint32 _vehicleCheckTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_impaling_spearAI(creature);
        }
};

class npc_alchemist_adrianna : public CreatureScript
{
    public:
        npc_alchemist_adrianna() : CreatureScript("npc_alchemist_adrianna") { }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (InstanceScript* instance = creature->GetInstanceScript())
                if (instance->GetBossState(DATA_ROTFACE) == DONE && instance->GetBossState(DATA_FESTERGUT) == DONE && !creature->FindCurrentSpellBySpellId(SPELL_HARVEST_BLIGHT_SPECIMEN) && !creature->FindCurrentSpellBySpellId(SPELL_HARVEST_BLIGHT_SPECIMEN25))
                    if (player->HasAura(SPELL_ORANGE_BLIGHT_RESIDUE) && player->HasAura(SPELL_GREEN_BLIGHT_RESIDUE))
                        creature->CastSpell(creature, SPELL_HARVEST_BLIGHT_SPECIMEN, false);
            return false;
        }
};

class npc_arthas_teleport_visual : public CreatureScript
{
    public:
        npc_arthas_teleport_visual() : CreatureScript("npc_arthas_teleport_visual") { }

        struct npc_arthas_teleport_visualAI : public NullCreatureAI
        {
            npc_arthas_teleport_visualAI(Creature* creature) : NullCreatureAI(creature), _instance(creature->GetInstanceScript())
            {
            }

            void Reset()
            {
                _events.Reset();
                if (_instance->GetBossState(DATA_PROFESSOR_PUTRICIDE) == DONE &&
                    _instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) == DONE &&
                    _instance->GetBossState(DATA_SINDRAGOSA) == DONE)
                    _events.ScheduleEvent(EVENT_SOUL_MISSILE, urand(1000, 6000));
            }

            void UpdateAI(uint32 diff)
            {
                if (_events.Empty())
                    return;

                _events.Update(diff);

                if (_events.ExecuteEvent() == EVENT_SOUL_MISSILE)
                {
                    DoCastAOE(SPELL_SOUL_MISSILE);
                    _events.ScheduleEvent(EVENT_SOUL_MISSILE, urand(5000, 7000));
                }
            }

        private:
            InstanceScript* _instance;
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            // Distance from the center of the spire
            if (creature->GetExactDist2d(4357.052f, 2769.421f) < 100.0f && creature->GetHomePosition().GetPositionZ() < 315.0f)
                return GetIcecrownCitadelAI<npc_arthas_teleport_visualAI>(creature);

            // Default to no script
            return nullptr;
        }
};

class spell_icc_stoneform : public SpellScriptLoader
{
    public:
        spell_icc_stoneform() : SpellScriptLoader("spell_icc_stoneform") { }

        class spell_icc_stoneform_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_icc_stoneform_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Creature* target = GetTarget()->ToCreature())
                {
                    target->SetReactState(REACT_PASSIVE);
                    target->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
                    target->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_CUSTOM_SPELL_02);
                }
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Creature* target = GetTarget()->ToCreature())
                {
                    target->SetReactState(REACT_AGGRESSIVE);
                    target->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
                    target->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                }
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_icc_stoneform_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_icc_stoneform_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_icc_stoneform_AuraScript();
        }
};

class spell_icc_sprit_alarm : public SpellScriptLoader
{
    public:
        spell_icc_sprit_alarm() : SpellScriptLoader("spell_icc_sprit_alarm") { }

        class spell_icc_sprit_alarm_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_icc_sprit_alarm_SpellScript);

            void HandleEvent(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                float range = 0.0f;
                switch (GetSpellInfo()->Effects[effIndex].MiscValue)
                {
                    case EVENT_AWAKEN_WARD_1:
                    case EVENT_AWAKEN_WARD_2:
                        range = 100.0f;
                        break;
                    case EVENT_AWAKEN_WARD_3:
                    case EVENT_AWAKEN_WARD_4:
                        range = 50.0f;
                        break;
                    default:
                        return;
                }

                std::list<Creature*> wards;
                GetCaster()->GetCreatureListWithEntryInGrid(wards, NPC_DEATHBOUND_WARD, range);
                wards.sort(acore::ObjectDistanceOrderPred(GetCaster()));
                for (std::list<Creature*>::iterator itr = wards.begin(); itr != wards.end(); ++itr)
                {
                    if ((*itr)->IsAlive() && (*itr)->HasAura(SPELL_STONEFORM))
                    {
                        if (Player* target = (*itr)->SelectNearestPlayer(150.0f))
                        {
                            (*itr)->AI()->Talk(SAY_TRAP_ACTIVATE);
                            (*itr)->RemoveAurasDueToSpell(SPELL_STONEFORM);
                            (*itr)->AI()->AttackStart(target);
                        }
                        break;
                    }
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_icc_sprit_alarm_SpellScript::HandleEvent, EFFECT_2, SPELL_EFFECT_SEND_EVENT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_icc_sprit_alarm_SpellScript();
        }
};

class spell_icc_geist_alarm : public SpellScriptLoader
{
    public:
        spell_icc_geist_alarm() : SpellScriptLoader("spell_icc_geist_alarm") { }

        class spell_icc_geist_alarm_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_icc_geist_alarm_SpellScript);

            void HandleEvent(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                {
                    Position p = {4356.77f, 2971.90f, 360.52f, M_PI/2};
                    if (Creature* l = instance->instance->SummonCreature(NPC_VENGEFUL_FLESHREAPER, p))
                    {
                        bool hasTarget = false;
                        Unit* target = nullptr;
                        if ((target = l->SelectNearestTarget(20.0f)))
                            hasTarget = true;
                        else
                        {
                            target = l->SelectNearestTarget(120.0f);
                            l->GetMotionMaster()->MoveJump(l->GetPositionX(), l->GetPositionY()+55.0f, l->GetPositionZ(), 20.0f, 6.0f);
                        }
                        l->AI()->Talk(0);
                        l->AI()->AttackStart(target);
                        l->AddThreat(target, 1.0f);
                        for (uint8 i = 0; i<5; ++i)
                        {
                            float dist = 2.0f + rand_norm()*4.0f;
                            float angle = rand_norm()*2*M_PI;
                            Position pos(p);
                            l->MovePosition(pos, dist, angle);
                            if (Creature* c = l->SummonCreature(NPC_VENGEFUL_FLESHREAPER, pos, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30*MINUTE*IN_MILLISECONDS))
                            {
                                c->AI()->AttackStart(l->GetVictim());
                                c->AddThreat(l->GetVictim(), 1.0f);
                                if (!hasTarget)
                                    c->GetMotionMaster()->MoveJump(c->GetPositionX(), c->GetPositionY()+55.0f, c->GetPositionZ(), 20.0f, 6.0f);
                            }
                        }
                    }
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_icc_geist_alarm_SpellScript::HandleEvent, EFFECT_2, SPELL_EFFECT_SEND_EVENT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_icc_geist_alarm_SpellScript();
        }
};

class spell_frost_giant_death_plague : public SpellScriptLoader
{
    public:
        spell_frost_giant_death_plague() : SpellScriptLoader("spell_frost_giant_death_plague") { }

        class spell_frost_giant_death_plague_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_frost_giant_death_plague_SpellScript);

            // First effect
            void CountTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
                targets.remove_if(acore::ObjectGUIDCheck(GetCaster()->GetGUID(), true));

                bool kill = true;
                for (std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    if (!(*itr)->ToUnit()->HasAura(SPELL_DEATH_PLAGUE_AURA))
                    {
                        kill = false;
                        break;
                    }
                if (kill)
                    GetCaster()->CastSpell(GetCaster(), SPELL_DEATH_PLAGUE_KILL, true);
                else
                {
                    GetCaster()->CastSpell(GetCaster(), SPELL_RECENTLY_INFECTED, true);
                    targets.push_back(GetCaster());
                }
            }

            void HandleScript(SpellEffIndex  /*effIndex*/)
            {
                if (!GetHitUnit()->HasAura(SPELL_RECENTLY_INFECTED) && !GetHitUnit()->HasAura(SPELL_DEATH_PLAGUE_AURA))
                    GetHitUnit()->CastSpell(GetHitUnit(), SPELL_DEATH_PLAGUE_AURA, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_frost_giant_death_plague_SpellScript::CountTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
                OnEffectHitTarget += SpellEffectFn(spell_frost_giant_death_plague_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_frost_giant_death_plague_SpellScript();
        }
};

class spell_icc_harvest_blight_specimen : public SpellScriptLoader
{
    public:
        spell_icc_harvest_blight_specimen() : SpellScriptLoader("spell_icc_harvest_blight_specimen") { }

        class spell_icc_harvest_blight_specimen_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_icc_harvest_blight_specimen_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetHitUnit()->RemoveAurasDueToSpell(uint32(GetEffectValue()));
            }

            void HandleQuestComplete(SpellEffIndex /*effIndex*/)
            {
                GetHitUnit()->RemoveAurasDueToSpell(uint32(GetEffectValue()));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_icc_harvest_blight_specimen_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
                OnEffectHitTarget += SpellEffectFn(spell_icc_harvest_blight_specimen_SpellScript::HandleQuestComplete, EFFECT_1, SPELL_EFFECT_QUEST_COMPLETE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_icc_harvest_blight_specimen_SpellScript();
        }
};

class AliveCheck
{
    public:
        bool operator()(WorldObject* object) const
        {
            if (Unit* unit = object->ToUnit())
                return unit->IsAlive();
            return true;
        }
};

class spell_svalna_revive_champion : public SpellScriptLoader
{
    public:
        spell_svalna_revive_champion() : SpellScriptLoader("spell_svalna_revive_champion") { }

        class spell_svalna_revive_champion_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_svalna_revive_champion_SpellScript);

            void RemoveAliveTarget(std::list<WorldObject*>& targets)
            {
                targets.remove_if(AliveCheck());
                acore::Containers::RandomResizeList(targets, 2);
            }

            void Land(SpellEffIndex /*effIndex*/)
            {
                Creature* caster = GetCaster()->ToCreature();
                if (!caster)
                    return;

                Position pos;
                caster->GetPosition(&pos);
                caster->GetNearPosition(pos, 5.0f, 0.0f);
                pos.m_positionZ = caster->GetBaseMap()->GetHeight(caster->GetPhaseMask(), pos.GetPositionX(), pos.GetPositionY(), caster->GetPositionZ(), true, 50.0f);
                pos.m_positionZ += 0.1f;
                caster->SendMeleeAttackStop(caster->GetVictim());
                caster->GetMotionMaster()->MoveLand(POINT_LAND, pos, 7.0f);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_svalna_revive_champion_SpellScript::RemoveAliveTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
                OnEffectHit += SpellEffectFn(spell_svalna_revive_champion_SpellScript::Land, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_svalna_revive_champion_SpellScript();
        }
};

class spell_svalna_remove_spear : public SpellScriptLoader
{
    public:
        spell_svalna_remove_spear() : SpellScriptLoader("spell_svalna_remove_spear") { }

        class spell_svalna_remove_spear_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_svalna_remove_spear_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Creature* target = GetHitCreature())
                {
                    if (Unit* vehicle = target->GetVehicleBase())
                        vehicle->RemoveAurasDueToSpell(SPELL_IMPALING_SPEAR);
                    target->DespawnOrUnsummon(1);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_svalna_remove_spear_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_svalna_remove_spear_SpellScript();
        }
};

class spell_icc_soul_missile : public SpellScriptLoader
{
    public:
        spell_icc_soul_missile() : SpellScriptLoader("spell_icc_soul_missile") { }

        class spell_icc_soul_missile_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_icc_soul_missile_SpellScript);

            void RelocateDest()
            {
                static Position const offset = {0.0f, 0.0f, 200.0f, 0.0f};
                const_cast<WorldLocation*>(GetExplTargetDest())->RelocateOffset(offset);
            }

            void Register()
            {
                OnCast += SpellCastFn(spell_icc_soul_missile_SpellScript::RelocateDest);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_icc_soul_missile_SpellScript();
        }
};

class at_icc_saurfang_portal : public AreaTriggerScript
{
    public:
        at_icc_saurfang_portal() : AreaTriggerScript("at_icc_saurfang_portal") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            InstanceScript* instance = player->GetInstanceScript();
            if (!instance || instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != DONE)
                return true;

            Position destPos = {4126.35f, 2769.23f, 350.963f, 0.0f};

            if (instance->GetData(DATA_COLDFLAME_JETS) == NOT_STARTED)
            {
                // save original player position
                float x, y, z, o;
                player->GetPosition(x, y, z, o);

                // move player to preload grid and be able to select nearby npcs
                player->GetMap()->PlayerRelocation(player, destPos.GetPositionX(), destPos.GetPositionY(), destPos.GetPositionZ(), destPos.GetOrientation());

                instance->SetData(DATA_COLDFLAME_JETS, IN_PROGRESS);
                std::list<Creature*> traps;
                GetCreatureListWithEntryInGrid(traps, player, NPC_FROST_FREEZE_TRAP, 120.0f);
                traps.sort(acore::ObjectDistanceOrderPred(player));
                bool instant = false;
                for (std::list<Creature*>::iterator itr = traps.begin(); itr != traps.end(); ++itr)
                {
                    (*itr)->AI()->DoAction(instant ? 1000 : 11000);
                    instant = !instant;
                }

                // restore original position
                player->GetMap()->PlayerRelocation(player, x, y, z, o);
            }

            player->TeleportTo(631, destPos.GetPositionX(), destPos.GetPositionY(), destPos.GetPositionZ(), destPos.GetOrientation());

            return true;
        }
};

class at_icc_shutdown_traps : public AreaTriggerScript
{
    public:
        at_icc_shutdown_traps() : AreaTriggerScript("at_icc_shutdown_traps") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
                instance->SetData(DATA_COLDFLAME_JETS, DONE);
            return true;
        }
};

class at_icc_start_blood_quickening : public AreaTriggerScript
{
    public:
        at_icc_start_blood_quickening() : AreaTriggerScript("at_icc_start_blood_quickening") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
                instance->SetData(DATA_BLOOD_QUICKENING_STATE, IN_PROGRESS);
            return true;
        }
};

class at_icc_start_frostwing_gauntlet : public AreaTriggerScript
{
    public:
        at_icc_start_frostwing_gauntlet() : AreaTriggerScript("at_icc_start_frostwing_gauntlet") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
                if (instance->GetBossState(DATA_SISTER_SVALNA) != DONE)
                    if (Creature* crok = ObjectAccessor::GetCreature(*player, instance->GetData64(DATA_CROK_SCOURGEBANE)))
                    {
                        if (!crok->IsAlive())
                        {
                            FrostwingGauntletRespawner respawner;
                            acore::CreatureWorker<FrostwingGauntletRespawner> worker(crok, respawner);
                            crok->VisitNearbyGridObject(333.0f, worker);
                            return true;
                        }
                        else
                            crok->AI()->DoAction(ACTION_START_GAUNTLET);
                    }
            return true;
        }
};


// pussywizard below:

class spell_icc_web_wrap : public SpellScriptLoader
{
public:
    spell_icc_web_wrap() : SpellScriptLoader("spell_icc_web_wrap") { }

    class spell_icc_web_wrap_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_icc_web_wrap_AuraScript);

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (!target->HasAura(71010))
                target->CastSpell(target, 71010, true);
        }

        void Register()
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_icc_web_wrap_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_MOD_ROOT, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_icc_web_wrap_AuraScript();
    }
};

class spell_icc_dark_reckoning : public SpellScriptLoader
{
public:
    spell_icc_dark_reckoning() : SpellScriptLoader("spell_icc_dark_reckoning") { }

    class spell_icc_dark_reckoning_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_icc_dark_reckoning_AuraScript);

        void OnPeriodic(AuraEffect const* /*aurEff*/)
        {
            if (Unit* caster = GetCaster())
                caster->CastSpell(GetTarget(), 69482, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_icc_dark_reckoning_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_icc_dark_reckoning_AuraScript();
    }
};

class spell_stinky_precious_decimate : public SpellScriptLoader
{
    public:
        spell_stinky_precious_decimate() : SpellScriptLoader("spell_stinky_precious_decimate") { }

        class spell_stinky_precious_decimate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_stinky_precious_decimate_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                if (GetHitUnit()->GetHealthPct() > float(GetEffectValue()))
                {
                    uint32 newHealth = GetHitUnit()->GetMaxHealth() * uint32(GetEffectValue()) / 100;
                    GetHitUnit()->SetHealth(newHealth);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_stinky_precious_decimate_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_stinky_precious_decimate_SpellScript();
        }
};

class spell_icc_yf_frozen_orb : public SpellScriptLoader
{
public:
    spell_icc_yf_frozen_orb() : SpellScriptLoader("spell_icc_yf_frozen_orb") { }

    class spell_icc_yf_frozen_orb_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_icc_yf_frozen_orb_AuraScript)

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            PreventDefaultAction();
            if (Unit* c = GetCaster())
                if (Unit* t = GetTarget())
                    c->CastSpell(t->GetPositionX(), t->GetPositionY(), t->GetPositionZ(), 71285, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_icc_yf_frozen_orb_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_icc_yf_frozen_orb_AuraScript();
    }
};

class spell_icc_yh_volley : public SpellScriptLoader
{
public:
    spell_icc_yh_volley() : SpellScriptLoader("spell_icc_yh_volley") { }

    class spell_icc_yh_volley_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_icc_yh_volley_AuraScript)

        void HandleEffectPeriodic(AuraEffect const * aurEff)
        {
            PreventDefaultAction();
            if (Unit* c = GetCaster())
                if (Unit* t = GetTarget())
                {
                    if ((aurEff->GetTickNumber()%5) == 0)
                        c->SetFacingToObject(t);
                    int32 basepoints1 = aurEff->GetAmount();
                    c->CastCustomSpell(t, 41089, 0, &basepoints1, 0, true);
                }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_icc_yh_volley_AuraScript::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_icc_yh_volley_AuraScript();
    }
};

class spell_icc_yd_summon_undead : public SpellScriptLoader
{
    public:
        spell_icc_yd_summon_undead() : SpellScriptLoader("spell_icc_yd_summon_undead") { }

        class spell_icc_yd_summon_undead_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_icc_yd_summon_undead_SpellScript);

            void HandleDummyLaunch(SpellEffIndex /*effIndex*/)
            {
                if (Unit* c = GetCaster())
                    if (c->GetMapId() == 631)
                        for (uint8 i = 0; i < 5; ++i)
                            c->CastSpell(c, 71302, true);
            }

            void Register()
            {
                OnEffectLaunch += SpellEffectFn(spell_icc_yd_summon_undead_SpellScript::HandleDummyLaunch, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_icc_yd_summon_undead_SpellScript();
        }
};

class spell_icc_shattered_bones : public SpellScriptLoader
{
    public:
        spell_icc_shattered_bones() : SpellScriptLoader("spell_icc_shattered_bones") { }

        class spell_icc_shattered_bones_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_icc_shattered_bones_SpellScript);

            void HandleDummy()
            {
                for (uint8 i=0; i<10; ++i)
                    GetCaster()->CastSpell((Unit*)NULL, 70963, true);
            }

            void Register()
            {
                AfterCast += SpellCastFn(spell_icc_shattered_bones_SpellScript::HandleDummy);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_icc_shattered_bones_SpellScript();
        }
};

class npc_icc_skybreaker_hierophant : public CreatureScript
{
public:
    npc_icc_skybreaker_hierophant() : CreatureScript("npc_icc_skybreaker_hierophant") { }

    struct npc_icc_skybreaker_hierophantAI : public ScriptedAI
    {
        npc_icc_skybreaker_hierophantAI(Creature* creature) : ScriptedAI(creature) {}
        EventMap events;

        void Reset() { events.Reset(); }
        void AttackStart(Unit* who) { AttackStartCaster(who, 20.0f); }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(1, urand(5000,15000));
            events.ScheduleEvent(2, urand(5000,15000));
            events.ScheduleEvent(3, urand(5000,15000));
            events.ScheduleEvent(4, urand(1000,3000));
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69899, false);
                    events.RepeatEvent(urand(10000,20000));
                    break;
                case 2:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69882, false);
                    events.RepeatEvent(urand(10000,20000));
                    break;
                case 3:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69898, false);
                    events.RepeatEvent(urand(10000,20000));
                    break;
                case 4:
                    me->CastSpell(me->GetVictim(), 69968, false);
                    events.RepeatEvent(urand(2000,3000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_skybreaker_hierophantAI(creature);
    }
};

class npc_icc_skybreaker_marksman : public CreatureScript
{
public:
    npc_icc_skybreaker_marksman() : CreatureScript("npc_icc_skybreaker_marksman") { }

    struct npc_icc_skybreaker_marksmanAI : public ScriptedAI
    {
        npc_icc_skybreaker_marksmanAI(Creature* creature) : ScriptedAI(creature) {}
        EventMap events;

        void Reset() { events.Reset(); }
        void AttackStart(Unit* who) { AttackStartCaster(who, 20.0f); }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(1, urand(5000,10000));
            events.ScheduleEvent(2, urand(5000,15000));
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    me->CastSpell(me->GetVictim(), 69989, false);
                    events.RepeatEvent(urand(5000,10000));
                    break;
                case 2:
                    me->CastSpell(me->GetVictim(), 69975, false);
                    events.RepeatEvent(urand(10000,15000));
                    break;
            }

            DoSpellAttackIfReady(69974);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_skybreaker_marksmanAI(creature);
    }
};

class npc_icc_skybreaker_vicar : public CreatureScript
{
public:
    npc_icc_skybreaker_vicar() : CreatureScript("npc_icc_skybreaker_vicar") { }

    struct npc_icc_skybreaker_vicarAI : public ScriptedAI
    {
        npc_icc_skybreaker_vicarAI(Creature* creature) : ScriptedAI(creature) {}
        EventMap events;

        void Reset() { events.Reset(); }
        void AttackStart(Unit* who) { AttackStartCaster(who, 20.0f); }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(1, urand(5000,15000));
            events.ScheduleEvent(2, urand(5000,15000));
            events.ScheduleEvent(3, urand(1000,3000));
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69963, false);
                    events.RepeatEvent(urand(10000,20000));
                    break;
                case 2:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69910, false);
                    events.RepeatEvent(urand(10000,20000));
                    break;
                case 3:
                    me->CastSpell(me->GetVictim(), 69967, false);
                    events.RepeatEvent(urand(2000,3000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_skybreaker_vicarAI(creature);
    }
};

class npc_icc_skybreaker_luminary : public CreatureScript
{
public:
    npc_icc_skybreaker_luminary() : CreatureScript("npc_icc_skybreaker_luminary") { }

    struct npc_icc_skybreaker_luminaryAI : public ScriptedAI
    {
        npc_icc_skybreaker_luminaryAI(Creature* creature) : ScriptedAI(creature) {}
        EventMap events;

        void Reset() { events.Reset(); }
        void AttackStart(Unit* who) { AttackStartCaster(who, 20.0f); }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(1, urand(5000,15000));
            events.ScheduleEvent(2, urand(5000,15000));
            events.ScheduleEvent(3, urand(5000,15000));
            events.ScheduleEvent(4, urand(1000,3000));
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69923, false);
                    events.RepeatEvent(urand(10000,20000));
                    break;
                case 2:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69926, false);
                    events.RepeatEvent(urand(20000,30000));
                    break;
                case 3:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, 5000))
                        me->CastSpell(target, 69958, false);
                    events.RepeatEvent(urand(10000,20000));
                    break;
                case 4:
                    me->CastSpell(me->GetVictim(), 69970, false);
                    events.RepeatEvent(urand(3000,4000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_skybreaker_luminaryAI(creature);
    }
};

class npc_icc_valkyr_herald : public CreatureScript
{
public:
    npc_icc_valkyr_herald() : CreatureScript("npc_icc_valkyr_herald") { }

    struct npc_icc_valkyr_heraldAI : public ScriptedAI
    {
        npc_icc_valkyr_heraldAI(Creature* creature) : ScriptedAI(creature), summons(me) {}
        EventMap events;
        SummonList summons;

        void Reset() { events.Reset(); summons.DespawnAll(); }

        void EnterCombat(Unit* /*who*/)
        {
            events.Reset();
            summons.DespawnAll();
            me->setActive(true);
            events.ScheduleEvent(1, 10000);
            me->SetInCombatWithZone();
        }

        void JustReachedHome()
        {
            me->setActive(false);
        }

        void JustSummoned(Creature* s)
        {
            summons.Summon(s);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (me->IsAlive() && !me->IsInCombat() && who->GetTypeId() == TYPEID_PLAYER && who->GetExactDist2d(me) < 35.0f)
                AttackStart(who);
        }

        void SummonedCreatureDespawn(Creature* s)
        {
            summons.Despawn(s);
        }

        bool CanAIAttack(Unit const* target) const
        {
            return target->GetExactDist(4357.0f, 2769.0f, 356.0f) < 170.0f;
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spell)
        {
            if (spell->Id == 71906 || spell->Id == 71942)
            {
                if (Creature* c = me->SummonCreature(38410, *target, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                {
                    c->AI()->AttackStart(target);
                    DoZoneInCombat(c);
                    uint8 Class = target->getClass();
                    if (Class != CLASS_DRUID)
                        if (Player* p = target->ToPlayer())
                        {
                            if (Item* i = p->GetWeaponForAttack(BASE_ATTACK))
                                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, i->GetEntry());
                            if (Item* i = p->GetWeaponForAttack(OFF_ATTACK))
                                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, i->GetEntry());
                            if (Item* i = p->GetWeaponForAttack(RANGED_ATTACK))
                                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2, i->GetEntry());

                            target->CastSpell(c, 60352, true); // Mirror Image, clone visual appearance
                        }
                    c->AI()->DoAction(Class);
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    {
                        uint8 count = me->GetMap()->Is25ManRaid() ? 4 : 2;
                        bool casted = false;
                        for (uint8 i=0; i<count; ++i)
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 37.5f, true))
                            {
                                casted = true;
                                me->CastSpell(target, 71906, true); // Severed Essence
                            }
                        events.RepeatEvent(casted ? 25000 : 5000);
                    }
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_valkyr_heraldAI(creature);
    }
};

class SeveredEssenceSpellInfo
{
public:
    uint8 Class;
    uint32 id;
    uint32 cooldown_ms;
    uint8 targetType;
    float range;
};

SeveredEssenceSpellInfo sesi_spells[] =
{
    {CLASS_SHAMAN, 71938, 5000, 1, 0.0f},
    {CLASS_PALADIN, 57767, 8000, 2, 30.0f},
    {CLASS_WARLOCK, 71937, 10000, 1, 0.0f},
    {CLASS_DEATH_KNIGHT, 49576, 15000, 1, 30.0f},
    {CLASS_ROGUE, 71933, 8000, 1, 0.0f},
    {CLASS_MAGE, 71928, 4000, 1, 40.0f},
    {CLASS_PALADIN, 71930, 5000, 2, 40.0f},
    {CLASS_ROGUE, 71955, 40000, 1, 30.0f},
    {CLASS_PRIEST, 71931, 5000, 2, 40.0f},
    {CLASS_SHAMAN, 71934, 7000, 1, 0.0f},
    {CLASS_DRUID, 71925, 5000, 1, 0.0f},
    {CLASS_DEATH_KNIGHT, 71951, 8000, 1, 0.0f},
    {CLASS_DEATH_KNIGHT, 71924, 8000, 1, 0.0f},
    {CLASS_WARLOCK, 71965, 20000, 0, 0.0f},
    {CLASS_PRIEST, 71932, 8000, 2, 40.0f},
    {CLASS_DRUID, 71926, 10000, 1, 0.0f},
    {CLASS_WARLOCK, 71936, 9000, 1, 0.0f},
    {CLASS_ROGUE, 57640, 3000, 1, 0.0f},
    {CLASS_WARRIOR, 71961, 5000, 1, 0.0f},
    {CLASS_MAGE, 71929, 10000, 1, 0.0f},
    {CLASS_WARRIOR, 53395, 5000, 1, 0.0f},
    {CLASS_WARRIOR, 71552, 5000, 1, 0.0f},
    {CLASS_HUNTER, 36984, 7000, 1, 0.0f},
    {CLASS_HUNTER, 29576, 5000, 1, 0.0f},
    {0, 0, 0, 0, 0.0f},
};

class npc_icc_severed_essence : public CreatureScript
{
public:
    npc_icc_severed_essence() : CreatureScript("npc_icc_severed_essence") { }

    struct npc_icc_severed_essenceAI : public ScriptedAI
    {
        npc_icc_severed_essenceAI(Creature* creature) : ScriptedAI(creature) {}
        EventMap events;
        uint8 Class;

        void DoAction(int32 a)
        {
            switch (a)
            {
                case CLASS_PALADIN:
                    me->CastSpell(me, 71953, true);
                    break;
                case CLASS_DRUID:
                    //me->CastSpell(me, 57655, true);
                    me->SetNativeDisplayId(1933);
                    me->SetDisplayId(1933);
                    break;
            }

            Class = a;

            for (uint8 i=0; ; ++i)
            {
                if (sesi_spells[i].id)
                {
                    if (Class == sesi_spells[i].Class)
                        events.ScheduleEvent(i+1, sesi_spells[i].cooldown_ms/4);
                }
                else
                    break;
            }

        }

        bool CanAIAttack(Unit const* target) const
        {
            return target->GetExactDist(4357.0f, 2769.0f, 356.0f) < 170.0f;
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uint32 e = events.GetEvent())
            {
                Unit* target = nullptr;
                if (sesi_spells[e-1].targetType == 1)
                    target = me->GetVictim();
                else
                    target = DoSelectLowestHpFriendly(sesi_spells[e-1].range-3.0f);

                if (target)
                    me->CastSpell(target, sesi_spells[e-1].id, TRIGGERED_IGNORE_SHAPESHIFT);

                events.RepeatEvent(sesi_spells[e-1].cooldown_ms);
            }

            if (Class == CLASS_HUNTER)
            {
                if (me->isAttackReady() && !me->HasUnitState(UNIT_STATE_CASTING))
                {
                    me->CastSpell(me->GetVictim(), 71927, true);
                    me->resetAttackTimer();
                }
            }
            else
                DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_severed_essenceAI(creature);
    }
};

class npc_icc_spire_frostwyrm : public CreatureScript
{
public:
    npc_icc_spire_frostwyrm() : CreatureScript("npc_icc_spire_frostwyrm") { }

    struct npc_icc_spire_frostwyrmAI : public ScriptedAI
    {
        npc_icc_spire_frostwyrmAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetDisableGravity(true);
            me->SetHover(true);
            me->SetCanFly(true);
        }

        EventMap events;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(1, urand(15000, 25000)); // blizzard
            events.ScheduleEvent(2, 5000); // cleave
            events.ScheduleEvent(3, urand(10000, 15000)); // frost breath
        }

        void DoAction(int32 a)
        {
            if (a != -1)
                return;
            if (me->GetHomePosition().GetPositionZ() < 225.0f)
                return;
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), 191.26f, me->GetOrientation());
            me->GetMotionMaster()->MoveLand(1, me->GetPositionX(), me->GetPositionY(), 191.26f, 2.5f*7.0f);
            Talk(0);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == EFFECT_MOTION_TYPE && id == 1)
            {
                me->SetDisableGravity(false);
                me->SetHover(false);
                me->SetCanFly(false);

                if (Player* p = SelectTargetFromPlayerList(100.0f))
                {
                    Talk(p->GetTeamId() == TEAM_HORDE ? 1 : 2);
                    AttackStart(p);
                }
            }
        }

        bool CanAIAttack(Unit const* target) const
        {
            return me->GetPositionZ() < 225.0f && me->GetHomePosition().GetExactDist(target) < 200.0f;
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 1:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                        me->CastSpell(target, 70362, false);
                    events.RepeatEvent(urand(25000, 35000));
                    break;
                case 2:
                    me->CastSpell(me->GetVictim(), 70361, false);
                    events.RepeatEvent(5000);
                    break;
                case 3:
                    me->CastSpell(me->GetVictim(), 70116, false);
                    events.RepeatEvent(urand(10000, 15000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_spire_frostwyrmAI(creature);
    }
};

#define VENGEFUL_WP_COUNT 6
const Position VengefulWP[VENGEFUL_WP_COUNT] = {
    {4432.21f, 3041.5f, 372.783f, 0.0f},
    {4370.50f, 3042.00f, 372.80f, 0.0f},
    {4370.37f, 3059.16f, 371.69f, 0.0f},
    {4342.53f, 3058.97f, 371.68f, 0.0f},
    {4342.51f, 3041.24f, 372.80f, 0.0f},
    {4281.30f, 3041.77f, 372.78f, 0.0f},
};

class npc_icc_vengeful_fleshreaper : public CreatureScript
{
public:
    npc_icc_vengeful_fleshreaper() : CreatureScript("npc_icc_vengeful_fleshreaper") { }

    struct npc_icc_vengeful_fleshreaperAI : public ScriptedAI
    {
        npc_icc_vengeful_fleshreaperAI(Creature* creature) : ScriptedAI(creature)
        {
            currPipeWP = VENGEFUL_WP_COUNT;
            forward = true;
            needMove = false;
            Position homePos = me->GetHomePosition();
            if (homePos.GetPositionZ() > 365.0f)
            {
                currPipeWP = (homePos.GetPositionX() > 4400.0f ? 0 : 1);
                needMove = true;
            }
        }

        uint8 currPipeWP;
        bool forward;
        bool needMove;
        EventMap events;

        void Reset()
        {
            me->SetWalk(false);
            events.Reset();
            events.ScheduleEvent(1, urand(3000, 6000)); // leaping face maul
        }

        void JustReachedHome()
        {
            if (currPipeWP != VENGEFUL_WP_COUNT)
                needMove = true;
            me->SetWalk(false);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (currPipeWP != VENGEFUL_WP_COUNT && (type == POINT_MOTION_TYPE || type == EFFECT_MOTION_TYPE) && id)
                needMove = true;
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (currPipeWP == VENGEFUL_WP_COUNT)
                ScriptedAI::MoveInLineOfSight(who);
            else
            {
                if (!me->IsInCombat() && who->GetTypeId() == TYPEID_PLAYER && me->GetExactDist2dSq(who) < 25.0f*25.0f && me->CanSeeOrDetect(who) && me->IsValidAttackTarget(who))
                    AttackStart(who);
            }
        }

        void AttackStart(Unit* who)
        {
            ScriptedAI::AttackStart(who);

            if (currPipeWP != VENGEFUL_WP_COUNT)
            {
                Position pos;
                who->GetPosition(&pos);
                float angle = who->GetAngle(me);
                float dist = 3.0f;
                pos.m_positionX += cos(angle)*dist;
                pos.m_positionY += sin(angle)*dist;
                me->GetMotionMaster()->MoveJump(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), 10.0f, 6.0f, 0);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (needMove)
            {
                needMove = false;
                if (forward)
                {
                    if (currPipeWP == VENGEFUL_WP_COUNT-1)
                    {
                        forward = false;
                        --currPipeWP;
                    }
                    else
                        ++currPipeWP;
                }
                else
                {
                    if (currPipeWP == 0)
                    {
                        forward = true;
                        ++currPipeWP;
                    }
                    else
                        --currPipeWP;
                }
                me->SetHomePosition(VengefulWP[currPipeWP].GetPositionX(), VengefulWP[currPipeWP].GetPositionY(), VengefulWP[currPipeWP].GetPositionZ(), me->GetOrientation());
                if ((forward && currPipeWP == 3) || (!forward && currPipeWP == 2))
                    me->GetMotionMaster()->MoveJump(VengefulWP[currPipeWP].GetPositionX(), VengefulWP[currPipeWP].GetPositionY(), VengefulWP[currPipeWP].GetPositionZ(), 10.0f, 6.0f, 1);
                else
                    me->GetMotionMaster()->MovePoint(1, VengefulWP[currPipeWP].GetPositionX(), VengefulWP[currPipeWP].GetPositionY(), VengefulWP[currPipeWP].GetPositionZ());
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 1:
                    if (me->GetVictim() && !me->GetVictim()->HasAura(71163) && me->GetVictim()->GetDistance(me) > 5.0f && me->GetVictim()->GetDistance(me) < 30.0f)
                    {
                        me->CastSpell(me->GetVictim(), 71164, false);
                        events.RepeatEvent(urand(15000, 20000));
                    }
                    else
                        events.RepeatEvent(3000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_vengeful_fleshreaperAI(creature);
    }
};

class npc_icc_buff_switcher : public CreatureScript
{
public:
    npc_icc_buff_switcher() : CreatureScript("npc_icc_buff_switcher") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*sender*/, uint32  /*action*/) override
    {
        if ((creature->GetEntry() == NPC_GARROSH_HELLSCREAM && player->PlayerTalkClass->GetGossipMenu().GetMenuId() == 11206) || (creature->GetEntry() == NPC_KING_VARIAN_WRYNN && player->PlayerTalkClass->GetGossipMenu().GetMenuId() == 11204))
        {
            if (!player->GetGroup() || !player->GetGroup()->isRaidGroup() || !player->GetGroup()->IsLeader(player->GetGUID()))
            {
                CloseGossipMenuFor(player);
                ChatHandler(player->GetSession()).PSendSysMessage("Only the raid leader can turn off the buff.");
                return true;
            }
            if (InstanceScript* inst = creature->GetInstanceScript())
                if (inst->GetData(DATA_BUFF_AVAILABLE))
                    inst->SetData(DATA_BUFF_AVAILABLE, 0);
            if (creature->GetEntry() == NPC_GARROSH_HELLSCREAM)
            {
                CloseGossipMenuFor(player);
                return true;
            }
        }
        return false;
    }
};

class npc_icc_nerubar_broodkeeper : public CreatureScript
{
public:
    npc_icc_nerubar_broodkeeper() : CreatureScript("npc_icc_nerubar_broodkeeper") { }

    struct npc_icc_nerubar_broodkeeperAI : public ScriptedAI
    {
        npc_icc_nerubar_broodkeeperAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetDisableGravity(true);
            me->SetCanFly(true);
            me->SetHover(true);
            _didWebBeam = false;
            me->m_SightDistance = 100.0f; // for MoveInLineOfSight distance
        }

        EventMap events;
        bool _didWebBeam;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(1, urand(3000, 10000)); // Crypt Scarabs
            events.ScheduleEvent(2, urand(15000, 25000)); // Dark Mending
            events.ScheduleEvent(3, urand(8000, 15000)); // Web Wrap
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!_didWebBeam && who->GetTypeId() == TYPEID_PLAYER && me->GetExactDist2d(who) < 70.0f)
            {
                _didWebBeam = true;
                float nx = me->GetPositionX() + cos(me->GetOrientation())*2.0f;
                float ny = me->GetPositionY() + sin(me->GetOrientation())*2.0f;
                float nz = me->GetMap()->GetHeight(nx, ny, 50.0f);
                me->SetHomePosition(nx, ny, nz, me->GetOrientation());
                me->CastSpell(me, SPELL_WEB_BEAM, false);
                me->GetMotionMaster()->MovePoint(1, nx, ny, nz, false);
                return;
            }
            if (me->HasUnitMovementFlag(MOVEMENTFLAG_CAN_FLY))
                return;
            ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->CallForHelp(15.0f);
        }

        void JustReachedHome()
        {
            if (me->IsHovering())
            {
                me->SetDisableGravity(false);
                me->SetCanFly(false);
                me->SetHover(false);
                me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == POINT_MOTION_TYPE && id == 1)
            {
                if (me->IsHovering())
                {
                    me->SetDisableGravity(false);
                    me->SetCanFly(false);
                    me->SetHover(false);
                    me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                }
            }
        }

        bool CanAIAttack(const Unit*  /*target*/) const
        {
            return !me->HasUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    me->CastSpell(me->GetVictim(), 70965, false);
                    events.RepeatEvent(urand(20000, 30000));
                    break;
                case 2:
                    me->CastSpell(me->GetVictim(), 71020, false);
                    events.RepeatEvent(urand(20000, 30000));
                    break;
                case 3:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                        me->CastSpell(target, 70980, false);
                    events.RepeatEvent(urand(20000, 30000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_icc_nerubar_broodkeeperAI(creature);
    }
};

enum gauntletEvents
{
    SAY_INIT                    = 0,
    POINT_ENTER_COMBAT          = 1,

    EVENT_CHECK_FIGHT           = 1,
    EVENT_GAUNTLET_PHASE1       = 2,
    EVENT_GAUNTLET_PHASE2       = 3,
    EVENT_GAUNTLET_PHASE3       = 4,
    EVENT_SUMMON_BROODLING      = 5
};

class npc_icc_gauntlet_controller : public CreatureScript
{
    public:
        npc_icc_gauntlet_controller() : CreatureScript("npc_icc_gauntlet_controller") { }

        struct npc_icc_gauntlet_controllerAI : public NullCreatureAI
        {
            npc_icc_gauntlet_controllerAI(Creature* creature) : NullCreatureAI(creature), summons(me)
            {
                instance = creature->GetInstanceScript();
            }

            SummonList summons;
            InstanceScript* instance;
            EventMap events;

            void ScheduleBroodlings()
            {
                for (uint8 i = 0; i < 30; ++i)
                    events.ScheduleEvent(EVENT_SUMMON_BROODLING, 10000+i*350);
            }


            void SummonBroodling()
            {
                float dist = frand(18.0f, 39.0f);
                float o = rand_norm()*2*M_PI;
                if (Creature* broodling = me->SummonCreature(NPC_NERUBAR_BROODLING, me->GetPositionX()+cos(o)*dist, me->GetPositionY()+sin(o)*dist, 250.0f, Position::NormalizeOrientation(o-M_PI)))
                {
                    broodling->CastSpell(broodling, SPELL_WEB_BEAM2, false);
                    broodling->GetMotionMaster()->MovePoint(POINT_ENTER_COMBAT, broodling->GetPositionX(), broodling->GetPositionY(), 213.03f, false);
                }
            }

            void SummonFrostwardens()
            {
                for (uint8 i = 0; i < 3; ++i)
                {
                    me->SummonCreature(i == 1 ? NPC_FROSTWARDEN_SORCERESS : NPC_FROSTWARDEN_WARRIOR, 4173.94f+i*7.0f, 2409.15f, 211.033f, 1.56f);
                    me->SummonCreature(i == 1 ? NPC_FROSTWARDEN_SORCERESS : NPC_FROSTWARDEN_WARRIOR, 4173.94f+i*7.0f, 2556.71f, 211.033f, 4.712f);
                }
            }

            void SummonSpiders()
            {
                me->SummonCreature(NPC_NERUBAR_CHAMPION, 4207.30f, 2532.00f, 256.0, 4.253f);
                me->SummonCreature(NPC_NERUBAR_WEBWEAVER, 4228.79f, 2510.36f, 256.0f, 3.577f);
                me->SummonCreature(NPC_NERUBAR_CHAMPION, 4228.34f, 2458.20f, 256.0f, 2.642f);
                me->SummonCreature(NPC_NERUBAR_WEBWEAVER, 4207.54f, 2437.18f, 256.0f, 2.073f);
                me->SummonCreature(NPC_NERUBAR_CHAMPION, 4156.20f, 2436.80f, 256.0f, 1.083f);
                me->SummonCreature(NPC_NERUBAR_WEBWEAVER, 4133.50f, 2459.28f, 256.0f, 0.483f);
                me->SummonCreature(NPC_NERUBAR_CHAMPION, 4134.28f, 2509.71f, 256.0f, 5.788f);
                me->SummonCreature(NPC_NERUBAR_WEBWEAVER, 4156.29f, 2532.19f, 256.0f, 5.187f);
            }

            void SpidersMoveDown()
            {
                for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Creature* spider = ObjectAccessor::GetCreature(*me, *itr))
                        if (spider->GetPositionZ() > 220.0f)
                        {
                            spider->CastSpell(spider, SPELL_WEB_BEAM2, false);
                            spider->GetMotionMaster()->MovePoint(POINT_ENTER_COMBAT, spider->GetPositionX(), spider->GetPositionY(), 213.03f, false);
                        }
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_START_GAUNTLET)
                {
                    Talk(SAY_INIT);
                    me->setActive(true);
                    events.Reset();
                    events.SetPhase(0);
                    events.ScheduleEvent(EVENT_CHECK_FIGHT, 1000);
                    events.ScheduleEvent(EVENT_GAUNTLET_PHASE1, 0);
                    instance->SetBossState(DATA_SINDRAGOSA_GAUNTLET, IN_PROGRESS);
                }
            }

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                if (instance->GetBossState(DATA_SINDRAGOSA_GAUNTLET) != DONE)
                {
                    instance->SetBossState(DATA_SINDRAGOSA_GAUNTLET, NOT_STARTED);
                    SummonSpiders();
                }
            }

            void JustReachedHome()
            {
                me->setActive(false);
            }

            void JustDied(Unit*)
            {
                instance->SetBossState(DATA_SINDRAGOSA_GAUNTLET, DONE);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetPositionZ() > 220.0f)
                {
                    summon->SetDisableGravity(true);
                    summon->SetHover(true);
                    summon->SetWalk(true);
                }
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                summons.Despawn(summon);
                if (summon->GetEntry() != NPC_NERUBAR_BROODLING && summons.GetEntryCount(NPC_NERUBAR_BROODLING) == summons.size())
                {
                    if (events.GetPhaseMask() == 0)
                    {
                        events.SetPhase(1);
                        events.ScheduleEvent(EVENT_GAUNTLET_PHASE2, 0);
                    }
                    else if (events.GetPhaseMask() == 1)
                    {
                        events.SetPhase(2);
                        events.ScheduleEvent(EVENT_GAUNTLET_PHASE3, 0);
                    }
                    else
                        Unit::Kill(me, me);
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_CHECK_FIGHT:
                    {
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                        {
                            if (me->GetDistance(itr->GetSource()) > 100.0f || !itr->GetSource()->IsAlive() || itr->GetSource()->IsGameMaster())
                                continue;

                            events.ScheduleEvent(EVENT_CHECK_FIGHT, 1000);
                            return;
                        }

                        CreatureAI::EnterEvadeMode();
                        return;
                    }
                    case EVENT_GAUNTLET_PHASE1:
                        ScheduleBroodlings();
                        SpidersMoveDown();
                        break;
                    case EVENT_GAUNTLET_PHASE2:
                        ScheduleBroodlings();
                        SummonFrostwardens();
                        break;
                    case EVENT_GAUNTLET_PHASE3:
                        ScheduleBroodlings();
                        SummonSpiders();
                        SpidersMoveDown();
                        break;
                    case EVENT_SUMMON_BROODLING:
                        SummonBroodling();
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_icc_gauntlet_controllerAI>(creature);
        }
};

class npc_icc_putricades_trap : public CreatureScript
{
    public:
        npc_icc_putricades_trap() : CreatureScript("npc_icc_putricades_trap") { }

        struct npc_icc_putricades_trapAI : public NullCreatureAI
        {
            npc_icc_putricades_trapAI(Creature* creature) : NullCreatureAI(creature), summons(me)
            {
                instance = creature->GetInstanceScript();
            }

            SummonList summons;
            InstanceScript* instance;
            EventMap events;

            void DoAction(int32 param)
            {
                if (param == ACTION_START_GAUNTLET)
                {
                    me->setActive(true);
                    events.Reset();
                    events.ScheduleEvent(EVENT_CHECK_FIGHT, 1000);
                    instance->SetData(DATA_PUTRICIDE_TRAP_STATE, IN_PROGRESS);
                    me->CastSpell(me, SPELL_GIANT_INSECT_SWARM, true);

                    for (uint8 i = 0; i < 60; ++i)
                        events.ScheduleEvent(EVENT_GAUNTLET_PHASE1, i*1000);
                    events.ScheduleEvent(EVENT_GAUNTLET_PHASE2, 60000);
                }
            }

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                if (instance->GetData(DATA_PUTRICIDE_TRAP_STATE) != DONE)
                    instance->SetData(DATA_PUTRICIDE_TRAP_STATE, NOT_STARTED);
            }

            void JustReachedHome()
            {
                me->setActive(false);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                summon->CastSpell(summon, SPELL_LEAP_TO_A_RANDOM_LOCATION, true);
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                summons.Despawn(summon);
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_CHECK_FIGHT:
                    {
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                        {
                            if (me->GetDistance(itr->GetSource()) > 100.0f || !itr->GetSource()->IsAlive() || itr->GetSource()->IsGameMaster())
                                continue;

                            events.ScheduleEvent(EVENT_CHECK_FIGHT, 1000);
                            return;
                        }

                        CreatureAI::EnterEvadeMode();
                        return;
                    }
                    case EVENT_GAUNTLET_PHASE1:
                    {
                        std::list<Creature*> clist;
                        me->GetCreaturesWithEntryInRange(clist, 80.0f, NPC_INVISIBLE_STALKER);
                        // xinef: spell: 70484, some hack would be required, skip
                        for (std::list<Creature*>::const_iterator itr = clist.begin(); itr != clist.end(); ++itr)
                            me->SummonCreature(NPC_FLASH_EATING_INSECT, **itr, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                        break;
                    }
                    case EVENT_GAUNTLET_PHASE2:
                        instance->SetData(DATA_PUTRICIDE_TRAP_STATE, DONE);
                        me->RemoveAllAuras();
                        me->RemoveAllDynObjects();
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_icc_putricades_trapAI>(creature);
        }
};

class at_icc_gauntlet_event : public AreaTriggerScript
{
    public:
        at_icc_gauntlet_event() : AreaTriggerScript("at_icc_gauntlet_event") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
                if (instance->GetBossState(DATA_SINDRAGOSA_GAUNTLET) == NOT_STARTED && !player->IsGameMaster())
                    if (Creature* gauntlet = ObjectAccessor::GetCreature(*player, instance->GetData64(NPC_SINDRAGOSA_GAUNTLET)))
                        gauntlet->AI()->DoAction(ACTION_START_GAUNTLET);
            return true;
        }
};

class at_icc_putricide_trap : public AreaTriggerScript
{
    public:
        at_icc_putricide_trap() : AreaTriggerScript("at_icc_putricide_trap") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
                if (instance->GetData(DATA_PUTRICIDE_TRAP_STATE) == NOT_STARTED && !player->IsGameMaster())
                    if (Creature* trap = ObjectAccessor::GetCreature(*player, instance->GetData64(NPC_PUTRICADES_TRAP)))
                        trap->AI()->DoAction(ACTION_START_GAUNTLET);
            return true;
        }
};

class at_icc_spire_frostwyrm : public AreaTriggerScript
{
    public:
        at_icc_spire_frostwyrm() : AreaTriggerScript("at_icc_spire_frostwyrm") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (Creature* frostwyrm = player->FindNearestCreature(NPC_SPIRE_FROSTWYRM, 150.0f, true))
                if (frostwyrm->GetPositionZ() > 250.0f && frostwyrm->AI())
                    frostwyrm->AI()->DoAction(-1);
            return true;
        }
};

void AddSC_icecrown_citadel()
{
    new npc_highlord_tirion_fordring_lh();
    new npc_rotting_frost_giant();
    new npc_frost_freeze_trap();
    new npc_alchemist_adrianna();
    new boss_sister_svalna();
    new npc_crok_scourgebane();
    new npc_captain_arnath();
    new npc_captain_brandon();
    new npc_captain_grondel();
    new npc_captain_rupert();
    new npc_frostwing_vrykul();
    new npc_impaling_spear();
    new npc_arthas_teleport_visual();
    new spell_icc_stoneform();
    new spell_icc_sprit_alarm();
    new spell_icc_geist_alarm();
    new spell_frost_giant_death_plague();
    new spell_icc_harvest_blight_specimen();
    new spell_trigger_spell_from_caster("spell_svalna_caress_of_death", SPELL_IMPALING_SPEAR_KILL);
    new spell_svalna_revive_champion();
    new spell_svalna_remove_spear();
    new spell_icc_soul_missile();
    new at_icc_saurfang_portal();
    new at_icc_shutdown_traps();
    new at_icc_start_blood_quickening();
    new at_icc_start_frostwing_gauntlet();

    // pussywizard below:
    new spell_icc_web_wrap();
    new spell_icc_dark_reckoning();
    new spell_stinky_precious_decimate();
    new spell_icc_yf_frozen_orb();
    new spell_icc_yh_volley();
    new spell_icc_yd_summon_undead();
    new spell_icc_shattered_bones();
    new npc_icc_skybreaker_hierophant();
    new npc_icc_skybreaker_marksman();
    new npc_icc_skybreaker_vicar();
    new npc_icc_skybreaker_luminary();
    new npc_icc_valkyr_herald();
    new npc_icc_severed_essence();
    new npc_icc_spire_frostwyrm();
    new npc_icc_vengeful_fleshreaper();
    new npc_icc_buff_switcher();
    new npc_icc_nerubar_broodkeeper();
    new npc_icc_gauntlet_controller();
    new npc_icc_putricades_trap();
    new at_icc_gauntlet_event();
    new at_icc_putricide_trap();
    new at_icc_spire_frostwyrm();
}
