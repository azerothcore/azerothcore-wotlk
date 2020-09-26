/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* Script Data Start
SDName: Dalaran
SDAuthor: WarHead, MaXiMiUS
SD%Complete: 99%
SDComment: For what is 63990+63991? Same function but don't work correct...
SDCategory: Dalaran
Script Data End */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "WorldSession.h"
#include "ScriptedEscortAI.h"
#include "World.h"

// Ours
class npc_steam_powered_auctioneer : public CreatureScript
{
    public:
        npc_steam_powered_auctioneer() : CreatureScript("npc_steam_powered_auctioneer") { }

        struct npc_steam_powered_auctioneerAI : public ScriptedAI
        {
            npc_steam_powered_auctioneerAI(Creature* creature) : ScriptedAI(creature) {}

            bool CanBeSeen(Player const* player)
            {
                if (player->GetTeamId() == TEAM_ALLIANCE)
                    return me->GetEntry() == 35594;
                else
                    return me->GetEntry() == 35607;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_steam_powered_auctioneerAI(creature);
        }
};

class npc_mei_francis_mount : public CreatureScript
{
    public:
        npc_mei_francis_mount() : CreatureScript("npc_mei_francis_mount") { }

        struct npc_mei_francis_mountAI : public ScriptedAI
        {
            npc_mei_francis_mountAI(Creature* creature) : ScriptedAI(creature) {}

            bool CanBeSeen(Player const* player)
            {
                if (player->GetTeamId() == TEAM_ALLIANCE)
                    return me->GetEntry() == 32206 || me->GetEntry() == 32335 || me->GetEntry() == 31851;
                else
                    return me->GetEntry() == 32207 || me->GetEntry() == 32336 || me->GetEntry() == 31852;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_mei_francis_mountAI(creature);
        }
};

/******************************************
***** Shady Gnome - A Suitable Disguise **
****************************************/

enum DisguiseEvent
{
    ACTION_SHANDY_INTRO         = 0,
    ACTION_WATER                = 1,
    ACTION_SHIRTS               = 2,
    ACTION_PANTS                = 3,
    ACTION_UNMENTIONABLES       = 4,

    EVENT_INTRO_DH1             = 1,
    EVENT_INTRO_DH2             = 2,
    EVENT_INTRO_DH3             = 3,
    EVENT_INTRO_DH4             = 4,
    EVENT_INTRO_DH5             = 5,
    EVENT_INTRO_DH6             = 6,
    EVENT_OUTRO_DH              = 7,

    SAY_SHANDY1                 = 0,
    SAY_SHANDY2                 = 1,
    SAY_SHANDY3                 = 2,
    SAY_SHANDY_WATER            = 3, // shirts = 4, pants = 5, unmentionables = 6
    SAY_SHANDY4                 = 7,
    SAY_SHANDY5                 = 8,
    SAY_SHANDY6                 = 9,
};

enum DisguiseMisc
{
    QUEST_SUITABLE_DISGUISE_A       = 20438,
    QUEST_SUITABLE_DISGUISE_H       = 24556,

    SPELL_EVOCATION_VISUAL          = 69659,

    NPC_AQUANOS_ENTRY               = 36851,
};

enum spells
{
    // Sewers Warrior Spells
    SPELL_WARRIOR_BATTLESHOUT       = 9128,
    SPELL_WARRIOR_DISARM            = 6713,
    SPELL_WARRIOR_SHOUT             = 19134,
    SPELL_WARRIOR_HAMSTRING         = 9080,

    // Sewers Mage Spells
    SPELL_BLINK                     = 14514,
    SPELL_BLIZZARD                  = 44178,
    SPELL_COC                       = 12611,
    SPELL_FROST_NOVA                = 15532,
    SPELL_FROSTFIRE                 = 44614
};

class npc_shandy_dalaran : public CreatureScript
{
public:
    npc_shandy_dalaran() : CreatureScript("npc_shandy_dalaran") { }

    struct npc_shandy_dalaranAI : public ScriptedAI
    {
        npc_shandy_dalaranAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            _events.Reset();
            _aquanosGUID = 0;
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            switch(type)
            {
                case ACTION_SHANDY_INTRO:
                    if (Creature* aquanos = me->FindNearestCreature(NPC_AQUANOS_ENTRY, 30, true))
                        _aquanosGUID = aquanos->GetGUID();

                    _events.Reset();
                    _lCount = 0;
                    _lSource = 0;
                    _canWash = false;
                    Talk(SAY_SHANDY1);
                    _events.ScheduleEvent(EVENT_INTRO_DH1, 5000);
                    _events.ScheduleEvent(EVENT_OUTRO_DH, 10*MINUTE*IN_MILLISECONDS);
                    break;
                default:
                    if(_lSource == type && _canWash)
                    {
                        _canWash = false;
                        _events.ScheduleEvent(EVENT_INTRO_DH2, type == ACTION_UNMENTIONABLES ? 4000 : 10000);
                        Talk(SAY_SHANDY2);
                        if (Creature* aquanos = ObjectAccessor::GetCreature(*me, _aquanosGUID))
                            aquanos->CastSpell(aquanos, SPELL_EVOCATION_VISUAL, false);
                    }
                    break;
            }
        }

        void RollTask()
        {
            _lSource = urand(ACTION_SHIRTS, ACTION_UNMENTIONABLES);
            if (_lCount == 1 || _lCount == 4)
                _lSource = ACTION_WATER;

            Talk(SAY_SHANDY_WATER + _lSource - 1);
            _canWash = true;
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.GetEvent())
            {
                case EVENT_INTRO_DH1:
                    Talk(SAY_SHANDY3);
                    _events.ScheduleEvent(EVENT_INTRO_DH2, 15000);
                    _events.PopEvent();
                    break;
                case EVENT_INTRO_DH2:
                    if (_lCount++ > 6)
                        _events.ScheduleEvent(EVENT_INTRO_DH3, 6000);
                    else
                        RollTask();

                    _events.PopEvent();
                    break;
                case EVENT_INTRO_DH3:
                    Talk(SAY_SHANDY4);
                    _events.ScheduleEvent(EVENT_INTRO_DH4, 20000);
                    _events.PopEvent();
                    break;
                case EVENT_INTRO_DH4:
                    Talk(SAY_SHANDY5);
                    _events.ScheduleEvent(EVENT_INTRO_DH5, 3000);
                    _events.PopEvent();
                    break;
                case EVENT_INTRO_DH5:
                    me->SummonGameObject(201384, 5798.74f, 693.19f, 657.94f, 0.91f, 0, 0, 0, 0,90000000);
                    _events.ScheduleEvent(EVENT_INTRO_DH6, 1000);
                    _events.PopEvent();
                    break;
                case EVENT_INTRO_DH6:
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(0, 5797.55f, 691.97f, 657.94f);
                    _events.RescheduleEvent(EVENT_OUTRO_DH, 30000);
                    _events.PopEvent();
                    break;
                case EVENT_OUTRO_DH:
                    me->GetMotionMaster()->MoveTargetedHome();
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    _events.Reset();
                    break;
            }
        }

        private:
            EventMap _events;
            uint64 _aquanosGUID;
            uint8 _lCount;
            uint32 _lSource;

            bool _canWash;
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_SUITABLE_DISGUISE_A) == QUEST_STATUS_INCOMPLETE ||
            player->GetQuestStatus(QUEST_SUITABLE_DISGUISE_H) == QUEST_STATUS_INCOMPLETE)
        {
            if(player->GetTeamId() == TEAM_ALLIANCE)
                AddGossipItemFor(player, 0, "Arcanist Tybalin said you might be able to lend me a certain tabard.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            else
                AddGossipItemFor(player, 0, "Magister Hathorel said you might be able to lend me a certain tabard.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                CloseGossipMenuFor(player);
                creature->SetUInt32Value(UNIT_NPC_FLAGS, 0);
                creature->AI()->SetData(ACTION_SHANDY_INTRO, 0);
                break;
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_shandy_dalaranAI(creature);
    }
};
enum ArchmageLandalockQuests
{
    QUEST_SARTHARION_MUST_DIE               = 24579,
    QUEST_ANUBREKHAN_MUST_DIE               = 24580,
    QUEST_NOTH_THE_PLAGUEBINGER_MUST_DIE    = 24581,
    QUEST_INSTRUCTOR_RAZUVIOUS_MUST_DIE     = 24582,
    QUEST_PATCHWERK_MUST_DIE                = 24583,
    QUEST_MALYGOS_MUST_DIE                  = 24584,
    QUEST_FLAME_LEVIATHAN_MUST_DIE          = 24585,
    QUEST_RAZORSCALE_MUST_DIE               = 24586,
    QUEST_IGNIS_THE_FURNACE_MASTER_MUST_DIE = 24587,
    QUEST_XT_002_DECONSTRUCTOR_MUST_DIE     = 24588,
    QUEST_LORD_JARAXXUS_MUST_DIE            = 24589,
    QUEST_LORD_MARROWGAR_MUST_DIE           = 24590
};

enum ArchmageLandalockImages
{
    NPC_SARTHARION_IMAGE                = 37849,
    NPC_ANUBREKHAN_IMAGE                = 37850,
    NPC_NOTH_THE_PLAGUEBINGER_IMAGE     = 37851,
    NPC_INSTRUCTOR_RAZUVIOUS_IMAGE      = 37853,
    NPC_PATCHWERK_IMAGE                 = 37854,
    NPC_MALYGOS_IMAGE                   = 37855,
    NPC_FLAME_LEVIATHAN_IMAGE           = 37856,
    NPC_RAZORSCALE_IMAGE                = 37858,
    NPC_IGNIS_THE_FURNACE_MASTER_IMAGE  = 37859,
    NPC_XT_002_DECONSTRUCTOR_IMAGE      = 37861,
    NPC_LORD_JARAXXUS_IMAGE             = 37862,
    NPC_LORD_MARROWGAR_IMAGE            = 37864
};

class npc_archmage_landalock : public CreatureScript
{
    public:
        npc_archmage_landalock() : CreatureScript("npc_archmage_landalock")
        {
        }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_archmage_landalockAI(creature);
        }

        struct npc_archmage_landalockAI : public ScriptedAI
        {
            npc_archmage_landalockAI(Creature* creature) : ScriptedAI(creature)
            {
                _switchImageTimer = MINUTE*IN_MILLISECONDS;
                _summonGUID = 0;
            }

            uint32 GetImageEntry(uint32 QuestId)
            {
                switch (QuestId)
                {
                    case QUEST_SARTHARION_MUST_DIE:
                        return NPC_SARTHARION_IMAGE;
                    case QUEST_ANUBREKHAN_MUST_DIE:
                        return NPC_ANUBREKHAN_IMAGE;
                    case QUEST_NOTH_THE_PLAGUEBINGER_MUST_DIE:
                        return NPC_NOTH_THE_PLAGUEBINGER_IMAGE;
                    case QUEST_INSTRUCTOR_RAZUVIOUS_MUST_DIE:
                        return NPC_INSTRUCTOR_RAZUVIOUS_IMAGE;
                    case QUEST_PATCHWERK_MUST_DIE:
                        return NPC_PATCHWERK_IMAGE;
                    case QUEST_MALYGOS_MUST_DIE:
                        return NPC_MALYGOS_IMAGE;
                    case QUEST_FLAME_LEVIATHAN_MUST_DIE:
                        return NPC_FLAME_LEVIATHAN_IMAGE;
                    case QUEST_RAZORSCALE_MUST_DIE:
                        return NPC_RAZORSCALE_IMAGE;
                    case QUEST_IGNIS_THE_FURNACE_MASTER_MUST_DIE:
                        return NPC_IGNIS_THE_FURNACE_MASTER_IMAGE;
                    case QUEST_XT_002_DECONSTRUCTOR_MUST_DIE:
                        return NPC_XT_002_DECONSTRUCTOR_IMAGE;
                    case QUEST_LORD_JARAXXUS_MUST_DIE:
                        return NPC_LORD_JARAXXUS_IMAGE;
                    default: //case QUEST_LORD_MARROWGAR_MUST_DIE:
                        return NPC_LORD_MARROWGAR_IMAGE;
                }
            }

            void JustSummoned(Creature* image)
            {
                // xinef: screams like a baby
                if (image->GetEntry() != NPC_ANUBREKHAN_IMAGE)
                    image->SetUnitMovementFlags(MOVEMENTFLAG_RIGHT);
                _summonGUID = image->GetGUID();
            }

            void UpdateAI(uint32 diff)
            {
                ScriptedAI::UpdateAI(diff);

                _switchImageTimer += diff;
                if (_switchImageTimer > MINUTE*IN_MILLISECONDS)
                {
                    _switchImageTimer = 0;
                    QuestRelationBounds objectQR = sObjectMgr->GetCreatureQuestRelationBounds(me->GetEntry());
                    for (QuestRelations::const_iterator i = objectQR.first; i != objectQR.second; ++i)
                    {
                        uint32 questId = i->second;
                        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
                        if (!quest || !quest->IsWeekly())
                            continue;

                        uint32 newEntry = GetImageEntry(questId);
                        if (GUID_ENPART(_summonGUID) != newEntry)
                        {
                            if (Creature* image = ObjectAccessor::GetCreature(*me, _summonGUID))
                                image->DespawnOrUnsummon();

                            float z = 653.622f;
                            if (newEntry == NPC_MALYGOS_IMAGE || newEntry == NPC_RAZORSCALE_IMAGE || newEntry == NPC_SARTHARION_IMAGE)
                                z += 3.0f;
                            me->SummonCreature(newEntry, 5703.077f, 583.9757f, z, 3.926991f);
                        }
                    }
                }
            }
        private:
            uint32 _switchImageTimer;
            uint64 _summonGUID;
        };
};

// Theirs
/*******************************************************
 * npc_mageguard_dalaran
 *******************************************************/

enum Spells
{
    SPELL_TRESPASSER_A                     = 54028,
    SPELL_TRESPASSER_H                     = 54029,

    SPELL_SUNREAVER_DISGUISE_FEMALE        = 70973,
    SPELL_SUNREAVER_DISGUISE_MALE          = 70974,
    SPELL_SILVER_COVENANT_DISGUISE_FEMALE  = 70971,
    SPELL_SILVER_COVENANT_DISGUISE_MALE    = 70972,
};

enum NPCs // All outdoor guards are within 35.0f of these NPCs
{
    NPC_APPLEBOUGH_A                       = 29547,
    NPC_SWEETBERRY_H                       = 29715,
    NPC_SILVER_COVENANT_GUARDIAN_MAGE      = 29254,
    NPC_SUNREAVER_GUARDIAN_MAGE            = 29255,
};

class npc_mageguard_dalaran : public CreatureScript
{
public:
    npc_mageguard_dalaran() : CreatureScript("npc_mageguard_dalaran") { }

    struct npc_mageguard_dalaranAI : public ScriptedAI
    {
        npc_mageguard_dalaranAI(Creature* creature) : ScriptedAI(creature)
        {
            creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            creature->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_NORMAL, true);
            creature->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_MAGIC, true);
        }

        void Reset(){}

        void EnterCombat(Unit* /*who*/){}

        void AttackStart(Unit* /*who*/){}

        void MoveInLineOfSight(Unit* who)
        {
            if (!who || !who->IsInWorld() || who->GetZoneId() != 4395)
                return;

            if (!me->IsWithinDist(who, 5.0f, false))
                return;

            Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself();

            if (!player || player->IsGameMaster() || player->IsBeingTeleported() || (player->GetPositionZ() > 670 && player->GetVehicle()) ||
                // If player has Disguise aura for quest A Meeting With The Magister or An Audience With The Arcanist, do not teleport it away but let it pass
                player->HasAura(SPELL_SUNREAVER_DISGUISE_FEMALE) || player->HasAura(SPELL_SUNREAVER_DISGUISE_MALE) ||
                player->HasAura(SPELL_SILVER_COVENANT_DISGUISE_FEMALE) || player->HasAura(SPELL_SILVER_COVENANT_DISGUISE_MALE))
                return;

            switch (me->GetEntry())
            {
                case NPC_SILVER_COVENANT_GUARDIAN_MAGE:
                    if (player->GetTeamId() == TEAM_HORDE)              // Horde unit found in Alliance area
                    {
                        if (GetClosestCreatureWithEntry(me, NPC_APPLEBOUGH_A, 32.0f))
                        {
                            if (me->isInBackInMap(who, 12.0f))   // In my line of sight, "outdoors", and behind me
                                DoCast(who, SPELL_TRESPASSER_A); // Teleport the Horde unit out
                        }
                        else                                      // In my line of sight, and "indoors"
                            DoCast(who, SPELL_TRESPASSER_A);     // Teleport the Horde unit out
                    }
                    break;
                case NPC_SUNREAVER_GUARDIAN_MAGE:
                    if (player->GetTeamId() == TEAM_ALLIANCE)           // Alliance unit found in Horde area
                    {
                        if (GetClosestCreatureWithEntry(me, NPC_SWEETBERRY_H, 32.0f))
                        {
                            if (me->isInBackInMap(who, 12.0f))   // In my line of sight, "outdoors", and behind me
                                DoCast(who, SPELL_TRESPASSER_H); // Teleport the Alliance unit out
                        }
                        else                                      // In my line of sight, and "indoors"
                            DoCast(who, SPELL_TRESPASSER_H);     // Teleport the Alliance unit out
                    }
                    break;
            }
            me->SetOrientation(me->GetHomePosition().GetOrientation());
            return;
        }

        void UpdateAI(uint32 /*diff*/){}
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_mageguard_dalaranAI(creature);
    }
};

enum MinigobData
{
    ZONE_DALARAN            = 4395,

    SPELL_MANABONKED        = 61834,
    SPELL_TELEPORT_VISUAL   = 51347,
    SPELL_IMPROVED_BLINK    = 61995,

    EVENT_SELECT_TARGET     = 1,
    EVENT_BLINK             = 2,
    EVENT_DESPAWN_VISUAL    = 3,
    EVENT_DESPAWN           = 4,

    MAIL_MINIGOB_ENTRY      = 264,
    MAIL_DELIVER_DELAY_MIN  = 5*MINUTE,
    MAIL_DELIVER_DELAY_MAX  = 15*MINUTE
};

class npc_minigob_manabonk : public CreatureScript
{
    public:
        npc_minigob_manabonk() : CreatureScript("npc_minigob_manabonk") {}

        struct npc_minigob_manabonkAI : public ScriptedAI
        {
            npc_minigob_manabonkAI(Creature* creature) : ScriptedAI(creature)
            {
                me->setActive(true);
            }

            void Reset()
            {
                me->SetVisible(false);
                events.ScheduleEvent(EVENT_SELECT_TARGET, IN_MILLISECONDS);
            }

            Player* SelectTargetInDalaran()
            {
                std::list<Player*> PlayerInDalaranList;
                PlayerInDalaranList.clear();

                Map::PlayerList const &players = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if (Player* player = itr->GetSource()->ToPlayer())
                        if (player->GetZoneId() == ZONE_DALARAN && !player->IsFlying() && !player->IsMounted() && !player->IsGameMaster())
                            PlayerInDalaranList.push_back(player);

                if (PlayerInDalaranList.empty())
                    return nullptr;
                return acore::Containers::SelectRandomContainerElement(PlayerInDalaranList);
            }

            void SendMailToPlayer(Player* player)
            {
                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                int16 deliverDelay = irand(MAIL_DELIVER_DELAY_MIN, MAIL_DELIVER_DELAY_MAX);
                MailDraft(MAIL_MINIGOB_ENTRY, true).SendMailTo(trans, MailReceiver(player), MailSender(MAIL_CREATURE, me->GetEntry()), MAIL_CHECK_MASK_NONE, deliverDelay);
                CharacterDatabase.CommitTransaction(trans);
            }

            void UpdateAI(uint32 diff)
            {

                if (!sWorld->getBoolConfig(CONFIG_MINIGOB_MANABONK))
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SELECT_TARGET:
                            me->SetVisible(true);
                            DoCast(me, SPELL_TELEPORT_VISUAL);
                            if (Player* player = SelectTargetInDalaran())
                            {
                                me->NearTeleportTo(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0.0f);
                                DoCast(player, SPELL_MANABONKED);
                                SendMailToPlayer(player);
                            }
                            events.ScheduleEvent(EVENT_BLINK, 3*IN_MILLISECONDS);
                            break;
                        case EVENT_BLINK:
                        {
                            DoCast(me, SPELL_IMPROVED_BLINK);
                            Position pos;
                            me->GetRandomNearPosition(pos, (urand(15, 40)));
                            me->GetMotionMaster()->MovePoint(0, pos.m_positionX, pos.m_positionY, pos.m_positionZ);
                            events.ScheduleEvent(EVENT_DESPAWN, 3 * IN_MILLISECONDS);
                            events.ScheduleEvent(EVENT_DESPAWN_VISUAL, 2.5*IN_MILLISECONDS);
                            break;
                        }
                        case EVENT_DESPAWN_VISUAL:
                            DoCast(me, SPELL_TELEPORT_VISUAL);
                            break;
                        case EVENT_DESPAWN:
                            me->DespawnOrUnsummon();
                            break;
                        default:
                            break;
                    }
                }
            }

        private:
            EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_minigob_manabonkAI(creature);
    }
};

class npc_dalaran_mage : public CreatureScript
{
public:
    npc_dalaran_mage() : CreatureScript("npc_dalaran_mage") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_dalaran_mageAI(creature);
    }

    struct npc_dalaran_mageAI : public ScriptedAI
    {
        npc_dalaran_mageAI(Creature* creature) : ScriptedAI(creature)
        {

        }

        uint32 CoC_Timer;
        uint32 frostnova_timer;
        uint32 blink_timer;
        uint32 blizzard_timer;
        uint32 frostfire_timer;
        uint32 restoremana_timer;

        void Initialize()
        {
            CoC_Timer = 20000;
            frostnova_timer = 55000;
            blink_timer = 35000;
            blizzard_timer = 30000;
            frostfire_timer = 1000;
            restoremana_timer = 10000;
        }

        void Reset()
        {
            Initialize();
            me->AddAura(1908, me);
        }

        void EnterCombat(Unit* /*who*/)
        {
        }
        void UpdateAI(uint32 diff)
        {

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (restoremana_timer <= diff)
            {
                me->SetPower(POWER_MANA, (me->GetMaxPower(POWER_MANA)));
                restoremana_timer = 10000;
            }
            else
                restoremana_timer -= diff;

            if (frostfire_timer <= diff)
            {
                DoCast(SPELL_FROSTFIRE);
                frostfire_timer = urand(1000, 3000);
            }
            else
                frostfire_timer -= diff;

            if (CoC_Timer <= diff)
            {
                DoCast(SPELL_COC);
                CoC_Timer = urand(10000, 15000);
            }
            else
                CoC_Timer -= diff;

            if (blizzard_timer <= diff)
            {
                DoCast(SPELL_BLIZZARD);
                blizzard_timer = urand(20000, 30000);
            }
            else
                blizzard_timer -= diff;

            if (frostnova_timer <= diff)
            {
                DoCast(SPELL_FROST_NOVA);
                frostnova_timer = urand(30000, 40000);
            }
            else
                frostnova_timer -= diff;

            if (blink_timer <= diff)
            {
                DoCast(SPELL_BLINK);
                blink_timer = urand(20000, 25000);
            }
            else
                blink_timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};


    class npc_dalaran_warrior : public CreatureScript
    {
    public:
        npc_dalaran_warrior() : CreatureScript("npc_dalaran_warrior") {}

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_dalaran_warriorAI(creature);
        }

        struct npc_dalaran_warriorAI : public ScriptedAI
        {
            npc_dalaran_warriorAI(Creature* creature) : ScriptedAI(creature)
            {
                Battleshout_timer = 1000;
            }

            uint32 Battleshout_timer;
            uint32 hamstring_timer;
            uint32 disarm_timer;
            uint32 shout_timer;

            void Initialize()
            {
                Battleshout_timer = 120000;
                shout_timer = 60000;
                hamstring_timer = 30000;
                disarm_timer = 50000;
            }

            void Reset()
            {
                Initialize();
            }

            void EnterCombat(Unit* /*who*/)
            {
                me->AddAura(1908, me);
                Battleshout_timer = 1000;
            }
            void UpdateAI(uint32 diff)
            {

                if (!UpdateVictim())
                    return;

                if (Battleshout_timer <= diff)
                {
                    DoCast(SPELL_WARRIOR_SHOUT);
                    Battleshout_timer = 120000;
                }
                else
                    Battleshout_timer -= diff;

                if (shout_timer <= diff)
                {
                    DoCast(SPELL_WARRIOR_SHOUT);
                    shout_timer = 60000;
                }
                else
                    shout_timer -= diff;

                if (hamstring_timer <= diff)
                {
                    DoCast(SPELL_WARRIOR_HAMSTRING);
                    hamstring_timer = urand(20000, 25000);
                }
                else
                    hamstring_timer -= diff;

                if (disarm_timer <= diff)
                {
                    DoCast(SPELL_WARRIOR_DISARM);
                    disarm_timer = urand(50000, 60000);
                }
                else
                    disarm_timer -= diff;

                DoMeleeAttackIfReady();
            }
        };
    };

void AddSC_dalaran()
{
    // our
    new npc_steam_powered_auctioneer();
    new npc_mei_francis_mount();
    new npc_shandy_dalaran();
    new npc_archmage_landalock();
    new npc_dalaran_mage();
    new npc_dalaran_warrior();

    // theirs
    new npc_mageguard_dalaran();
    new npc_minigob_manabonk();
}
