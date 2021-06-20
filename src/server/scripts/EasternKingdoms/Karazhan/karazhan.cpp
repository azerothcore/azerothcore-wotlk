 /*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Karazhan
SD%Complete: 100
SDComment: Support for Barnes (Opera controller) and Berthold (Doorman), Support for Quest 9645.
SDCategory: Karazhan
EndScriptData */

/* ContentData
npc_barnes
npc_berthold
npc_image_of_medivh
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "karazhan.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

enum Spells
{
    // Barnes
    SPELL_SPOTLIGHT             = 25824,
    SPELL_TUXEDO                = 32616,

    // Berthold
    SPELL_TELEPORT              = 39567,

    // Image of Medivh
    SPELL_FIRE_BALL             = 30967,
    SPELL_UBER_FIREBALL         = 30971,
    SPELL_CONFLAGRATION_BLAST   = 30977,
    SPELL_MANA_SHIELD           = 31635
};

enum Creatures
{
    NPC_ARCANAGOS               = 17652,
    NPC_SPOTLIGHT               = 19525
};

/*######
# npc_barnesAI
######*/

#define GOSSIP_READY        "I'm not an actor."

#define SAY_READY           "Splendid, I'm going to get the audience ready. Break a leg!"
#define SAY_OZ_INTRO1       "Finally, everything is in place. Are you ready for your big stage debut?"
#define OZ_GOSSIP1          "I'm not an actor."
#define SAY_OZ_INTRO2       "Don't worry, you'll be fine. You look like a natural!"
#define OZ_GOSSIP2          "Ok, I'll give it a try, then."

#define SAY_RAJ_INTRO1      "The romantic plays are really tough, but you'll do better this time. You have TALENT. Ready?"
#define RAJ_GOSSIP1         "I've never been more ready."

#define OZ_GM_GOSSIP1       "[GM] Change event to EVENT_OZ"
#define OZ_GM_GOSSIP2       "[GM] Change event to EVENT_HOOD"
#define OZ_GM_GOSSIP3       "[GM] Change event to EVENT_RAJ"

struct Dialogue
{
    int32 textid;
    uint32 timer;
};

static Dialogue OzDialogue[]=
{
    {0, 6000},
    {1, 18000},
    {2, 9000},
    {3, 15000}
};

static Dialogue HoodDialogue[]=
{
    {4, 6000},
    {5, 10000},
    {6, 14000},
    {7, 15000}
};

static Dialogue RAJDialogue[]=
{
    {8, 5000},
    {9, 7000},
    {10, 14000},
    {11, 14000}
};

// Entries and spawn locations for creatures in Oz event
float Spawns[6][2]=
{
    {17535, -10896},                                        // Dorothee
    {17546, -10891},                                        // Roar
    {17547, -10884},                                        // Tinhead
    {17543, -10902},                                        // Strawman
    {17603, -10892},                                        // Grandmother
    {17534, -10900},                                        // Julianne
};

#define SPAWN_Z             90.5f
#define SPAWN_Y             -1758
#define SPAWN_O             4.738f

class npc_barnes : public CreatureScript
{
public:
    npc_barnes() : CreatureScript("npc_barnes") { }

    struct npc_barnesAI : public npc_escortAI
    {
        npc_barnesAI(Creature* creature) : npc_escortAI(creature)
        {
            RaidWiped = false;
            m_uiEventId = 0;
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        uint64 m_uiSpotlightGUID;

        uint32 TalkCount;
        uint32 TalkTimer;
        uint32 WipeTimer;
        uint32 m_uiEventId;

        bool PerformanceReady;
        bool RaidWiped;

        void Reset() override
        {
            m_uiSpotlightGUID = 0;

            TalkCount = 0;
            TalkTimer = 2000;
            WipeTimer = 5000;

            PerformanceReady = false;

            m_uiEventId = instance->GetData(DATA_OPERA_PERFORMANCE);
        }

        void StartEvent()
        {
            instance->SetBossState(DATA_OPERA_PERFORMANCE, IN_PROGRESS);

            //resets count for this event, in case earlier failed
            if (m_uiEventId == EVENT_OZ)
                instance->SetData(DATA_OPERA_OZ_DEATHCOUNT, IN_PROGRESS);

            Start(false, false);
        }

        void EnterCombat(Unit* /*who*/) override { }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 0:
                    DoCast(me, SPELL_TUXEDO, false);
                    instance->DoUseDoorOrButton(instance->GetData64(DATA_GO_STAGEDOORLEFT));
                    break;
                case 4:
                    TalkCount = 0;
                    SetEscortPaused(true);

                    if (Creature* spotlight = me->SummonCreature(NPC_SPOTLIGHT,
                        me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f,
                        TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000))
                    {
                        spotlight->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        spotlight->CastSpell(spotlight, SPELL_SPOTLIGHT, false);
                        m_uiSpotlightGUID = spotlight->GetGUID();
                    }
                    break;
                case 8:
                    instance->DoUseDoorOrButton(instance->GetData64(DATA_GO_STAGEDOORLEFT));
                    PerformanceReady = true;
                    break;
                case 9:
                    PrepareEncounter();
                    instance->DoUseDoorOrButton(instance->GetData64(DATA_GO_CURTAINS));
                    break;
            }
        }

        void Talk(uint32 count)
        {
            int32 text = 0;

            switch (m_uiEventId)
            {
                case EVENT_OZ:
                    if (OzDialogue[count].textid)
                         text = OzDialogue[count].textid;
                    if (OzDialogue[count].timer)
                        TalkTimer = OzDialogue[count].timer;
                    break;

                case EVENT_HOOD:
                    if (HoodDialogue[count].textid)
                        text = HoodDialogue[count].textid;
                    if (HoodDialogue[count].timer)
                        TalkTimer = HoodDialogue[count].timer;
                    break;

                case EVENT_RAJ:
                     if (RAJDialogue[count].textid)
                         text = RAJDialogue[count].textid;
                    if (RAJDialogue[count].timer)
                        TalkTimer = RAJDialogue[count].timer;
                    break;
            }

            if (text)
                 CreatureAI::Talk(text);
        }

        void PrepareEncounter()
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_TSCR, "TSCR: Barnes Opera Event - Introduction complete - preparing encounter %d", m_uiEventId);
#endif
            uint8 index = 0;
            uint8 count = 0;

            switch (m_uiEventId)
            {
                case EVENT_OZ:
                    index = 0;
                    count = 4;
                    break;
                case EVENT_HOOD:
                    index = 4;
                    count = index+1;
                    break;
                case EVENT_RAJ:
                    index = 5;
                    count = index+1;
                    break;
            }

            for (; index < count; ++index)
            {
                uint32 entry = ((uint32)Spawns[index][0]);
                float PosX = Spawns[index][1];

                if (Creature* creature = me->SummonCreature(entry, PosX, SPAWN_Y, SPAWN_Z, SPAWN_O, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, HOUR*2*IN_MILLISECONDS))
                {
                    // In case database has bad flags
                    creature->SetUInt32Value(UNIT_FIELD_FLAGS, 0);
                    creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                }
            }

            RaidWiped = false;
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (HasEscortState(STATE_ESCORT_PAUSED))
            {
                if (TalkTimer <= diff)
                {
                    if (TalkCount > 3)
                    {
                        if (Creature* pSpotlight = ObjectAccessor::GetCreature(*me, m_uiSpotlightGUID))
                            pSpotlight->DespawnOrUnsummon();

                        SetEscortPaused(false);
                        return;
                    }

                    Talk(TalkCount);
                    ++TalkCount;
                } else TalkTimer -= diff;
            }

            if (PerformanceReady)
            {
                if (!RaidWiped)
                {
                    if (WipeTimer <= diff)
                    {
                        Map* map = me->GetMap();
                        if (!map->IsDungeon())
                            return;

                        Map::PlayerList const &PlayerList = map->GetPlayers();
                        if (PlayerList.isEmpty())
                            return;

                        RaidWiped = true;
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                        {
                            if (i->GetSource()->IsAlive() && !i->GetSource()->IsGameMaster())
                            {
                                RaidWiped = false;
                                break;
                            }
                        }

                        if (RaidWiped)
                        {
                            RaidWiped = true;
                            EnterEvadeMode();
                            return;
                        }

                        WipeTimer = 15000;
                    } else WipeTimer -= diff;
                }
            }
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        npc_barnesAI* pBarnesAI = CAST_AI(npc_barnes::npc_barnesAI, creature->AI());

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, OZ_GOSSIP2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                SendGossipMenuFor(player, 8971, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                CloseGossipMenuFor(player);
                pBarnesAI->m_uiEventId = urand(EVENT_OZ, EVENT_RAJ);
                pBarnesAI->StartEvent();
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                CloseGossipMenuFor(player);
                pBarnesAI->m_uiEventId = EVENT_OZ;
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                CloseGossipMenuFor(player);
                pBarnesAI->m_uiEventId = EVENT_HOOD;
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                CloseGossipMenuFor(player);
                pBarnesAI->m_uiEventId = EVENT_RAJ;
                break;
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (InstanceScript* instance = creature->GetInstanceScript())
        {
            // Check for death of Moroes and if opera event is not done already
            if (instance->GetBossState(DATA_MOROES) == DONE &&  instance->GetBossState(DATA_OPERA_PERFORMANCE) != DONE)
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, OZ_GOSSIP1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

                if (player->IsGameMaster())
                {
                    AddGossipItemFor(player, GOSSIP_ICON_DOT, OZ_GM_GOSSIP1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    AddGossipItemFor(player, GOSSIP_ICON_DOT, OZ_GM_GOSSIP2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                    AddGossipItemFor(player, GOSSIP_ICON_DOT, OZ_GM_GOSSIP3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                }

                if (npc_barnesAI* pBarnesAI = CAST_AI(npc_barnes::npc_barnesAI, creature->AI()))
                {
                    if (!pBarnesAI->RaidWiped)
                        SendGossipMenuFor(player, 8970, creature->GetGUID());
                    else
                        SendGossipMenuFor(player, 8975, creature->GetGUID());

                    return true;
                }
            }
        }

        SendGossipMenuFor(player, 8978, creature->GetGUID());
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_barnesAI(creature);
    }
};

/*###
# npc_image_of_medivh
####*/

#define SAY_DIALOG_MEDIVH_1         "You've got my attention, dragon. You'll find I'm not as easily scared as the villagers below."
#define SAY_DIALOG_ARCANAGOS_2      "Your dabbling in the arcane has gone too far, Medivh. You've attracted the attention of powers beyond your understanding. You must leave Karazhan at once!"
#define SAY_DIALOG_MEDIVH_3         "You dare challenge me at my own dwelling? Your arrogance is astounding, even for a dragon!"
#define SAY_DIALOG_ARCANAGOS_4      "A dark power seeks to use you, Medivh! If you stay, dire days will follow. You must hurry, we don't have much time!"
#define SAY_DIALOG_MEDIVH_5         "I do not know what you speak of, dragon... but I will not be bullied by this display of insolence. I'll leave Karazhan when it suits me!"
#define SAY_DIALOG_ARCANAGOS_6      "You leave me no alternative. I will stop you by force if you won't listen to reason!"
#define EMOTE_DIALOG_MEDIVH_7       "begins to cast a spell of great power, weaving his own essence into the magic."
#define SAY_DIALOG_ARCANAGOS_8      "What have you done, wizard? This cannot be! I'm burning from... within!"
#define SAY_DIALOG_MEDIVH_9         "He should not have angered me. I must go... recover my strength now..."


//static float MedivPos[4] = {-11161.49f, -1902.24f, 91.48f, 1.94f};
static float ArcanagosPos[4] = {-11169.75f, -1881.48f, 107.39f, 4.83f};

class npc_image_of_medivh : public CreatureScript
{
public:
    npc_image_of_medivh() : CreatureScript("npc_image_of_medivh") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_image_of_medivhAI(creature);
    }

    struct npc_image_of_medivhAI : public ScriptedAI
    {
        npc_image_of_medivhAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            Step = 1;
            YellTimer = 5000;
        }

        InstanceScript* instance;

        uint64 ArcanagosGUID;

        uint32 YellTimer;
        uint8 Step;
        int32 MTimer;
        int32 ATimer;

        bool EventStarted;

        void Reset()
        {
            ArcanagosGUID = 0;
            MTimer = 0;
            ATimer = 0;

            if (instance && instance->GetData64(DATA_IMAGE_OF_MEDIVH) == 0)
            {
                Creature* Arcanagos = me->SummonCreature(NPC_ARCANAGOS, ArcanagosPos[0], ArcanagosPos[1], ArcanagosPos[2], 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                if (!Arcanagos)
                {
                    me->DespawnOrUnsummon();
                    return;
                }

                instance->SetData64(DATA_IMAGE_OF_MEDIVH, me->GetGUID());
                EventStarted = true;
                ArcanagosGUID = Arcanagos->GetGUID();

                Arcanagos->SetFacingToObject(me);
                me->SetFacingToObject(Arcanagos);

                Arcanagos->SetCanFly(true);
            }
            else
                me->DespawnOrUnsummon();
        }

        void EnterCombat(Unit* /*who*/) {}

        uint32 NextStep(uint32 Step)
        {
            switch(Step)
            {
            case 1:
                me->MonsterYell(SAY_DIALOG_MEDIVH_1, LANG_UNIVERSAL, 0);
                return 10000;
            case 2:
                if (Creature* arca = ObjectAccessor::GetCreature((*me), ArcanagosGUID))
                    arca->MonsterYell(SAY_DIALOG_ARCANAGOS_2, LANG_UNIVERSAL, 0);
                return 20000;
            case 3:
                me->MonsterYell(SAY_DIALOG_MEDIVH_3, LANG_UNIVERSAL, 0);
                return 10000;
            case 4:
                if (Creature* arca = ObjectAccessor::GetCreature((*me), ArcanagosGUID))
                    arca->MonsterYell(SAY_DIALOG_ARCANAGOS_4, LANG_UNIVERSAL, 0);
                return 20000;
            case 5:
                me->MonsterYell(SAY_DIALOG_MEDIVH_5, LANG_UNIVERSAL, 0);
                return 20000;
            case 6:
                if (Creature* arca = ObjectAccessor::GetCreature((*me), ArcanagosGUID))
                    arca->MonsterYell(SAY_DIALOG_ARCANAGOS_6, LANG_UNIVERSAL, 0);

                ATimer = 5500;
                MTimer = 6600;
                return 10000;
            case 7:
                return 1000;
            case 8:
                me->CastSpell(me, SPELL_MANA_SHIELD, true);
                return 5500;
            case 9:
                me->MonsterTextEmote(EMOTE_DIALOG_MEDIVH_7, 0, false);
                me->CastSpell(me, 30972, true);
                return 10000;
            case 10:
                me->RemoveAurasDueToSpell(30972);
                if (Creature* arca = ObjectAccessor::GetCreature((*me), ArcanagosGUID))
                    me->CastSpell(arca, SPELL_CONFLAGRATION_BLAST, false);
                return 1000;
            case 11:
                if (Creature* arca = ObjectAccessor::GetCreature((*me), ArcanagosGUID))
                    arca->MonsterYell(SAY_DIALOG_ARCANAGOS_8, LANG_UNIVERSAL, 0);
                return 5000;
            case 12:
                if (Creature* arca = ObjectAccessor::GetCreature((*me), ArcanagosGUID))
                {
                    arca->SetSpeed(MOVE_RUN, 2.0f);
                    arca->GetMotionMaster()->MovePoint(0, -11010.82f, -1761.18f, 156.47f);
                    arca->InterruptNonMeleeSpells(true);
                }
                return 10000;
            case 13:
                me->MonsterYell(SAY_DIALOG_MEDIVH_9, LANG_UNIVERSAL, 0);
                return 10000;
            case 14:
                if (me->GetMap()->IsDungeon())
                {
                    InstanceMap::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                    for (InstanceMap::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (i->GetSource()->GetQuestStatus(9645) == QUEST_STATUS_INCOMPLETE)
                        {
                            i->GetSource()->GroupEventHappens(9645, me);
                            break;
                        }
                    }
                }

                me->DespawnOrUnsummon(100);
                if (Creature* arca = ObjectAccessor::GetCreature((*me), ArcanagosGUID))
                    arca->DespawnOrUnsummon(100);

                return 5000;
            default:
                return 2000;
            }

        }

        void UpdateAI(uint32 diff)
        {

            if (YellTimer <= diff)
            {
                if (EventStarted)
                    YellTimer = NextStep(Step++);
            } else YellTimer -= diff;

            if (Step >= 7 && Step <= 8)
            {
                ATimer += diff;
                MTimer += diff;
                if (ATimer >= 6000)
                {
                    if (Unit* arca = ObjectAccessor::GetUnit((*me), ArcanagosGUID))
                        arca->CastSpell(me, SPELL_FIRE_BALL, false);
                    ATimer = 0;
                }
                if (MTimer >= 6000)
                {
                    if (Unit* arca = ObjectAccessor::GetUnit((*me), ArcanagosGUID))
                        me->CastSpell(arca, SPELL_FIRE_BALL, false);
                    MTimer = 0;
                }
            }
        }
    };

};

void AddSC_karazhan()
{
    new npc_barnes();
    new npc_image_of_medivh();
}
