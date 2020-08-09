// Scripted by Xinef

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "GridNotifiers.h"
#include "SpellScript.h"
#include "GameEventMgr.h"
#include "Group.h"
#include "LFGMgr.h"
#include "PassiveAI.h"
#include "CellImpl.h"

///////////////////////////////////////
////// GOS
///////////////////////////////////////

///////////////////////////////////////
////// NPCS
///////////////////////////////////////

class npc_brewfest_reveler : public CreatureScript
{
public:
    npc_brewfest_reveler() : CreatureScript("npc_brewfest_reveler") { }

    struct npc_brewfest_revelerAI : public ScriptedAI
    {
        npc_brewfest_revelerAI(Creature* c) : ScriptedAI(c) {}
        void ReceiveEmote(Player* player, uint32 emote)
        {
            if (!IsHolidayActive(HOLIDAY_BREWFEST))
                return;

            if (emote == TEXT_EMOTE_DANCE)
                me->CastSpell(player, 41586, false);
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_brewfest_revelerAI(creature);
    }
};

enum corenDirebrew
{
    FACTION_HOSTILE                 = 754,
    FACTION_FRIEND                  = 35,
    ITEM_DARK_BREW                  = 36748,
    ITEM_TREASURE_CHEST             = 54535,
    QUEST_COREN_DIREBREW            = 25483,
    ACTION_START_FIGHT              = 1,
    ACTION_RELEASE_LOOT             = 2,

    NPC_ILSA_DIREBREW               = 26764,
    NPC_URSULA_DIREBREW             = 26822,
    NPC_ANTAGONIST                  = 23795,

    // COREN
    SPELL_DIREBREW_DISARM           = 47310,
    SPELL_DISARM_VISUAL             = 47407,

    // SISTERS
    SPELL_BARRELED                  = 51413,
    SPELL_CHUCK_MUG                 = 50276,
    SPELL_DARK_STUN                 = 47340,
    SPELL_PURPLE_VISUAL             = 47651,

    EVENT_DIREBREW_DISARM           = 1,
    EVENT_DIREBREW_HEALTH           = 2,
    EVENT_SISTERS_BARREL            = 3,
    EVENT_SISTERS_CHUCK_MUG         = 4,
    EVENT_DIREBREW_RESPAWN1         = 5,
    EVENT_DIREBREW_RESPAWN2         = 6,
};

#define GOSSIP_ITEM_COREN1      "Insult Coren Direbrew's Brew."
#define GOSSIP_ITEM_COREN2      "Insult."

class npc_coren_direbrew : public CreatureScript
{
public:
    npc_coren_direbrew() : CreatureScript("npc_coren_direbrew") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_coren_direbrewAI (creature);
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_COREN2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                SendGossipMenuFor(player, 15859, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                CloseGossipMenuFor(player);
                creature->AI()->DoAction(ACTION_START_FIGHT);
                creature->MonsterSay("You'll pay for this insult, $C.", LANG_UNIVERSAL, player);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_COREN1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        SendGossipMenuFor(player, 15858, creature->GetGUID());

        return true;
    }

    struct npc_coren_direbrewAI : public ScriptedAI
    {
        npc_coren_direbrewAI(Creature* c) : ScriptedAI(c), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        uint8 phase;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            me->setFaction(FACTION_FRIEND);
            phase = 0;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_FIGHT)
            {
                Creature* cr = nullptr;

                for (int i = 0; i < 3; ++i)
                {
                    float o = rand_norm()*2*M_PI;
                    if ((cr = me->SummonCreature(NPC_ANTAGONIST, me->GetPositionX()+3*cos(o), me->GetPositionY()+3*sin(o), me->GetPositionZ(), me->GetOrientation())))
                    {
                        if (i == 0)
                            cr->MonsterSay("Time to die.", LANG_UNIVERSAL, 0);

                        summons.Summon(cr);
                        cr->SetInCombatWithZone();
                    }
                }

                me->CastSpell(me, SPELL_PURPLE_VISUAL , true);
                me->setFaction(FACTION_HOSTILE);
                me->SetInCombatWithZone();
                events.ScheduleEvent(EVENT_DIREBREW_DISARM, 10000);
                events.ScheduleEvent(EVENT_DIREBREW_HEALTH, 1000);
            }
            else if (param == NPC_ILSA_DIREBREW)
                events.ScheduleEvent(EVENT_DIREBREW_RESPAWN1, 10000);
            else if (param == NPC_URSULA_DIREBREW)
                events.ScheduleEvent(EVENT_DIREBREW_RESPAWN2, 10000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            summons.DespawnAll();
            summons.DoAction(ACTION_RELEASE_LOOT);

            // HACK FIX FOR TREASURE CHEST
            Quest const* qReward = sObjectMgr->GetQuestTemplate(QUEST_COREN_DIREBREW);
            if (!qReward)
                return;

            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                if (Player* player = itr->GetSource())
                {
                    if (player->CanRewardQuest(qReward, false))
                        player->RewardQuest(qReward, 0, NULL, false);
                }

            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            if (!players.isEmpty() && players.begin()->GetSource()->GetGroup())
                sLFGMgr->FinishDungeon(players.begin()->GetSource()->GetGroup()->GetGUID(), 287, me->FindMap());
        }

        void SummonSister(uint32 entry)
        {
            summons.DespawnEntry(entry);
            float o = rand_norm()*2*M_PI;
            if (Creature* cr = me->SummonCreature(entry, me->GetPositionX()+3*cos(o), me->GetPositionY()+3*sin(o), me->GetPositionZ(), me->GetOrientation()))
            {
                cr->CastSpell(cr, SPELL_PURPLE_VISUAL , true);
                cr->SetInCombatWithZone();
                summons.Summon(cr);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_DIREBREW_RESPAWN1:
                    SummonSister(NPC_ILSA_DIREBREW);
                    events.PopEvent();
                    break;
                case EVENT_DIREBREW_RESPAWN2:
                    SummonSister(NPC_URSULA_DIREBREW);
                    events.PopEvent();
                    break;
                case EVENT_DIREBREW_DISARM:
                    me->CastSpell(me->GetVictim(), SPELL_DIREBREW_DISARM, false);
                    me->CastSpell(me, SPELL_DISARM_VISUAL, true);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_DIREBREW_HEALTH:
                    if (me->GetHealthPct() < 66 && phase == 0)
                    {
                        phase++;
                        SummonSister(NPC_ILSA_DIREBREW);
                    }
                    if (me->GetHealthPct() < 35 && phase == 1)
                    {
                        events.PopEvent();
                        SummonSister(NPC_URSULA_DIREBREW);
                        return;
                    }

                    events.RepeatEvent(1000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_coren_direbrew_sisters : public CreatureScript
{
public:
    npc_coren_direbrew_sisters() : CreatureScript("npc_coren_direbrew_sisters") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_coren_direbrew_sistersAI (creature);
    }

    struct npc_coren_direbrew_sistersAI : public ScriptedAI
    {
        npc_coren_direbrew_sistersAI(Creature* c) : ScriptedAI(c)
        {
        }

        EventMap events;

        void Reset()
        {
            events.Reset();
            me->setFaction(FACTION_HOSTILE);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_RELEASE_LOOT && me->GetEntry() == NPC_ILSA_DIREBREW)
                me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        }

        Creature* GetSummoner()
        {
            if (me->IsSummon())
                if (Unit* coren = me->ToTempSummon()->GetSummoner())
                    return coren->ToCreature();

            return nullptr;
        }

        void JustDied(Unit*)
        {
            if (Creature* coren = GetSummoner())
            {
                if (coren->IsAlive())
                {
                    coren->AI()->DoAction(me->GetEntry());
                    me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                }
            }
        }


        void EnterCombat(Unit*  /*who*/)
        {
            if (me->GetEntry() == NPC_URSULA_DIREBREW)
                events.ScheduleEvent(EVENT_SISTERS_BARREL, 18000);

            events.ScheduleEvent(EVENT_SISTERS_CHUCK_MUG, 12000);
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_CHUCK_MUG)
                if (target->ToPlayer())
                    target->ToPlayer()->AddItem(ITEM_DARK_BREW, 1);
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
                case EVENT_SISTERS_BARREL:
                    me->CastSpell(me->GetVictim(), SPELL_BARRELED, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SISTERS_CHUCK_MUG:
                    Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                    for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                    {
                        if (Player* player = itr->GetSource())
                            if (player->HasItemCount(ITEM_DARK_BREW))
                            {
                                me->CastSpell(player, SPELL_DARK_STUN, true);
                                player->DestroyItemCount(ITEM_DARK_BREW, 1, true);
                            }
                    }

                    if (Player* player = SelectTargetFromPlayerList(50.0f, SPELL_DARK_STUN))
                        me->CastSpell(player, SPELL_CHUCK_MUG, false);

                    events.RepeatEvent(18000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};


enum kegThrowers
{
    QUEST_THERE_AND_BACK_AGAIN_A                = 11122,
    QUEST_THERE_AND_BACK_AGAIN_H                = 11412,
    RAM_DISPLAY_ID                              = 22630,
    NPC_FLYNN_FIREBREW                          = 24364,
    NPC_BOK_DROPCERTAIN                         = 24527,
    ITEM_PORTABLE_BREWFEST_KEG                  = 33797,
    SPELL_THROW_KEG                             = 43660,
    SPELL_RAM_AURA                              = 43883,
    SPELL_ADD_TOKENS                            = 44501,
    SPELL_COOLDOWN_CHECKER                      = 43755,
    NPC_RAM_MASTER_RAY                          = 24497,
    NPC_NEILL_RAMSTEIN                          = 23558,
    KEG_KILL_CREDIT                             = 24337,
};

class npc_brewfest_keg_thrower : public CreatureScript
{
public:
    npc_brewfest_keg_thrower() : CreatureScript("npc_brewfest_keg_thrower") { }

    struct npc_brewfest_keg_throwerAI : public ScriptedAI
    {
        npc_brewfest_keg_throwerAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (me->GetDistance(who) < 10.0f && who->GetTypeId() == TYPEID_PLAYER && who->GetMountID() == RAM_DISPLAY_ID)
            {
                if (!who->ToPlayer()->HasItemCount(ITEM_PORTABLE_BREWFEST_KEG)) // portable brewfest keg
                    me->CastSpell(who, SPELL_THROW_KEG, true);          // throw keg
            }
        }

        bool CanBeSeen(const Player* player)
        {
            if (player->GetMountID() == RAM_DISPLAY_ID)
                return true;

            return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_brewfest_keg_throwerAI(creature);
    }
};

class npc_brewfest_keg_reciver : public CreatureScript
{
public:
    npc_brewfest_keg_reciver() : CreatureScript("npc_brewfest_keg_reciver") { }

    struct npc_brewfest_keg_reciverAI : public ScriptedAI
    {
        npc_brewfest_keg_reciverAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (me->GetDistance(who) < 10.0f && who->GetTypeId() == TYPEID_PLAYER && who->GetMountID() == RAM_DISPLAY_ID)
            {
                Player* player = who->ToPlayer();
                if (player->HasItemCount(ITEM_PORTABLE_BREWFEST_KEG)) // portable brewfest keg
                {
                    player->KilledMonsterCredit(KEG_KILL_CREDIT, 0);
                    player->CastSpell(me, SPELL_THROW_KEG, true);          // throw keg
                    player->DestroyItemCount(ITEM_PORTABLE_BREWFEST_KEG, 1, true);

                    // Additional Work
                    uint32 spellCooldown = player->GetSpellCooldownDelay(SPELL_COOLDOWN_CHECKER)/IN_MILLISECONDS;
                    if (spellCooldown > (HOUR*18 - 900)) // max aproximated time - 12 minutes
                    {
                        if (Aura* aur = player->GetAura(SPELL_RAM_AURA))
                        {
                            int32 diff = aur->GetApplyTime() - (time(nullptr)-(HOUR*18)+spellCooldown);
                            if (diff > 10) // aura applied later
                                return;

                            aur->SetDuration(aur->GetDuration()+30000);
                            player->CastSpell(player, SPELL_ADD_TOKENS, true);
                        }
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_brewfest_keg_reciverAI(creature);
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*uiSender*/, uint32 uiAction) override
    {
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                CloseGossipMenuFor(player);
                player->AddSpellCooldown(SPELL_COOLDOWN_CHECKER, 0, 18*HOUR*IN_MILLISECONDS);
                player->CastSpell(player, 43883, true);
                player->CastSpell(player, 44262, true);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (!player->HasSpellCooldown(SPELL_COOLDOWN_CHECKER) && player->GetQuestRewardStatus(player->GetTeamId() == TEAM_ALLIANCE ? QUEST_THERE_AND_BACK_AGAIN_A : QUEST_THERE_AND_BACK_AGAIN_H))
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Do you have additional work?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        SendGossipMenuFor(player, (creature->GetEntry() == NPC_NEILL_RAMSTEIN ? 8934 : 8976), creature->GetGUID());
        return true;
    }
};

enum barkTrigger
{
    QUEST_BARK_FOR_DROHN                = 11407,
    QUEST_BARK_FOR_VOODOO               = 11408,
    QUEST_BARK_FOR_BARLEY               = 11293,
    QUEST_BARK_FOR_THUNDERBREW          = 11294,
};

class npc_brewfest_bark_trigger : public CreatureScript
{
    public:
        npc_brewfest_bark_trigger() : CreatureScript("npc_brewfest_bark_trigger") { }

        struct npc_brewfest_bark_triggerAI : public ScriptedAI
        {
            npc_brewfest_bark_triggerAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (me->GetDistance(who) < 10.0f && who->GetTypeId() == TYPEID_PLAYER && who->GetMountID() == RAM_DISPLAY_ID)
                {
                    bool allow = false;
                    uint32 quest = 0;
                    Player* player = who->ToPlayer();
                    // Kalimdor
                    if (me->GetMapId() == 1)
                    {
                        if (player->GetQuestStatus(QUEST_BARK_FOR_DROHN) == QUEST_STATUS_INCOMPLETE)
                        {
                            allow = true;
                            quest = QUEST_BARK_FOR_DROHN;
                        }
                        else if (player->GetQuestStatus(QUEST_BARK_FOR_VOODOO) == QUEST_STATUS_INCOMPLETE)
                        {
                            allow = true;
                            quest = QUEST_BARK_FOR_VOODOO;
                        }
                    }
                    else if (me->GetMapId() == 0)
                    {
                        if (player->GetQuestStatus(QUEST_BARK_FOR_BARLEY) == QUEST_STATUS_INCOMPLETE)
                        {
                            allow = true;
                            quest = QUEST_BARK_FOR_BARLEY;
                        }
                        else if (player->GetQuestStatus(QUEST_BARK_FOR_THUNDERBREW) == QUEST_STATUS_INCOMPLETE)
                        {
                            allow = true;
                            quest = QUEST_BARK_FOR_THUNDERBREW;
                        }
                    }

                    if (allow)
                    {
                        QuestStatusMap::iterator itr = player->getQuestStatusMap().find(quest);
                        if (itr == player->getQuestStatusMap().end())
                            return;

                        QuestStatusData &q_status = itr->second;
                        if (q_status.CreatureOrGOCount[me->GetEntry()-24202] == 0)
                        {
                            player->KilledMonsterCredit(me->GetEntry(), 0);
                            player->MonsterSay(GetTextFor(me->GetEntry(), quest).c_str(), LANG_UNIVERSAL, player);
                        }
                    }
                }
            }

            std::string GetTextFor(uint32  /*entry*/, uint32 questId)
            {
                std::string str = "";
                switch (questId)
                {
                    case QUEST_BARK_FOR_DROHN:
                    case QUEST_BARK_FOR_VOODOO:
                    {
                        switch (urand(0,3))
                        {
                            case 0:
                                str = "Join with your brothers and sisters at "+ std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") +" and drink for the horde!";
                                break;
                            case 1:
                                str = "If you think an orc can hit hard, check out their brew, it hits even harder! See for yourself at "+ std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") +", only at Brewfest!";
                                break;
                            case 2:
                                str = "Celebrate Brewfest with orcs that know what a good drink really is! Check out "+ std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") +" at Brewfest!";
                                break;
                            case 3:
                                str = std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") +"  knows how to party hard! Check them out at Brewfest!";
                                break;
                        }
                        break;
                    }
                    case QUEST_BARK_FOR_BARLEY:
                    case QUEST_BARK_FOR_THUNDERBREW:
                    {
                        switch (urand(0,3))
                        {
                            case 0:
                                str = "Join with your brothers and sisters at "+ std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") +" and drink for the alliance!";
                                break;
                            case 1:
                                str = "If you think an dwarf can hit hard, check out their brew, it hits even harder! See for yourself at "+ std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") +", only at Brewfest!";
                                break;
                            case 2:
                                str = "Celebrate Brewfest with dwarves that know what a good drink really is! Check out "+ std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") +" at Brewfest!";
                                break;
                            case 3:
                                str = std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") +"  knows how to party hard! Check them out at Brewfest!";
                                break;
                        }
                        break;
                    }
                }

                return str;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_brewfest_bark_triggerAI(creature);
        }
};

enum darkIronAttack
{
    // Gos
    GO_MOLE_MACHINE                     = 195305,

    // Npcs
    NPC_BARLEYBREW_KEG                  = 23700,
    NPC_THUNDERBREW_KEG                 = 23702,
    NPC_GORDOK_KEG                      = 23706,
    NPC_VOODOO_KEG                      = 24373,
    NPC_DROHN_KEG                       = 24372,
    NPC_MOLE_MACHINE_TRIGGER            = 23894,
    NPC_DARK_IRON_GUZZLER               = 23709,
    NPC_NORMAL_DROHN                    = 24492,
    NPC_NORMAL_VOODOO                   = 21349,
    NPC_NORMAL_BARLEYBREW               = 23683,
    NPC_NORMAL_THUNDERBREW              = 23684,
    NPC_NORMAL_GORDOK                   = 23685,
    NPC_EVENT_GENERATOR                 = 23703,
    NPC_SUPER_BREW_TRIGGER              = 23808,
    NPC_DARK_IRON_HERALD                = 24536,

    // Events
    EVENT_CHECK_HOUR                    = 1,
    EVENT_SPAWN_MOLE_MACHINE            = 2,
    EVENT_PRE_FINISH_ATTACK             = 3,
    EVENT_FINISH_ATTACK                 = 4,
    EVENT_BARTENDER_SAY                 = 5,

    // Spells
    SPELL_THROW_MUG_TO_PLAYER           = 42300,
    SPELL_ADD_MUG                       = 42518,
    SPELL_SPAWN_MOLE_MACHINE            = 43563,
    SPELL_KEG_MARKER                    = 42761,
    SPELL_PLAYER_MUG                    = 42436,
    SPELL_REPORT_DEATH                  = 42655,
    SPELL_CREATE_SUPER_BREW             = 42715,
    SPELL_DRUNKEN_MASTER                = 42696,
    SPELL_SUMMON_PLANS_A                = 48145,
    SPELL_SUMMON_PLANS_H                = 49318,

    // Dark Irons
    SPELL_ATTACK_KEG                    = 42393,
    SPELL_KNOCKBACK_AURA                = 42676,
    SPELL_MUG_BOUNCE_BACK               = 42522,
};

class npc_dark_iron_attack_generator : public CreatureScript
{
public:
    npc_dark_iron_attack_generator() : CreatureScript("npc_dark_iron_attack_generator") { }

    struct npc_dark_iron_attack_generatorAI : public ScriptedAI
    {
        npc_dark_iron_attack_generatorAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        uint32 kegCounter, guzzlerCounter;
        uint8 thrown;

        void Reset()
        {
            summons.DespawnAll();
            events.Reset();
            events.ScheduleEvent(EVENT_CHECK_HOUR, 2000);
            kegCounter = 0;
            guzzlerCounter = 0;
            thrown = 0;
        }

        // DARK IRON ATTACK EVENT
        void MoveInLineOfSight(Unit*  /*who*/) {}
        void EnterCombat(Unit*) {}

        void SpellHit(Unit* caster, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_REPORT_DEATH)
            {
                if (caster->GetEntry() == NPC_DARK_IRON_GUZZLER)
                    guzzlerCounter++;
                else
                {
                    kegCounter++;
                    if (kegCounter == 3)
                        FinishEventDueToLoss();
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_CHECK_HOUR:
                {
                    // determine hour
                    if (AllowStart())
                    {
                        PrepareEvent();
                        events.RepeatEvent(300000);
                        return;
                    }
                    events.RepeatEvent(2000);
                    break;
                }
                case EVENT_SPAWN_MOLE_MACHINE:
                {
                    if (me->GetMapId() == 1) // Kalimdor
                    {
                        float rand = 8+rand_norm()*12;
                        float angle = rand_norm()*2*M_PI;
                        float x = 1201.8f+rand*cos(angle);
                        float y = -4299.6f+rand*sin(angle);
                        if (Creature* cr = me->SummonCreature(NPC_MOLE_MACHINE_TRIGGER, x, y, 21.3f, 0.0f))
                            cr->CastSpell(cr, SPELL_SPAWN_MOLE_MACHINE, true);
                    }
                    else if (me->GetMapId() == 0) // EK
                    {
                        float rand = rand_norm()*20;
                        float angle = rand_norm()*2*M_PI;
                        float x = -5157.1f+rand*cos(angle);
                        float y = -598.98f+rand*sin(angle);
                        if (Creature* cr = me->SummonCreature(NPC_MOLE_MACHINE_TRIGGER, x, y, 398.11f, 0.0f))
                            cr->CastSpell(cr, SPELL_SPAWN_MOLE_MACHINE, true);
                    }
                    events.RepeatEvent(3000);
                    break;
                }
                case EVENT_PRE_FINISH_ATTACK:
                {
                    events.CancelEvent(EVENT_SPAWN_MOLE_MACHINE);
                    events.ScheduleEvent(EVENT_FINISH_ATTACK, 20000);
                    events.PopEvent();
                    break;
                }
                case EVENT_FINISH_ATTACK:
                {
                    FinishAttackDueToWin();
                    events.RescheduleEvent(EVENT_CHECK_HOUR, 60000);
                    break;
                }
                case EVENT_BARTENDER_SAY:
                {
                    events.RepeatEvent(12000);
                    Creature* sayer = GetRandomBartender();
                    if (!sayer)
                        return;

                    thrown++;
                    if (thrown == 3)
                    {
                        thrown = 0;
                        sayer->MonsterSay("SOMEONE TRY THIS SUPER BREW!", LANG_UNIVERSAL, 0);
                        //sayer->CastSpell(sayer, SPELL_CREATE_SUPER_BREW, true);
                        sayer->SummonCreature(NPC_SUPER_BREW_TRIGGER, sayer->GetPositionX()+15*cos(sayer->GetOrientation()), sayer->GetPositionY()+15*sin(sayer->GetOrientation()), sayer->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000);

                    }
                    else
                    {
                        if (urand(0,1))
                            sayer->MonsterSay("Chug and chuck! Chug and chuck!", LANG_UNIVERSAL, 0);
                        else
                            sayer->MonsterSay("Down the free brew and pelt the Guzzlers with your mug!", LANG_UNIVERSAL, 0);
                    }

                    break;
                }
            }
        }

        void FinishEventDueToLoss()
        {
            if (Creature* herald = me->FindNearestCreature(NPC_DARK_IRON_HERALD, 100.0f))
            {
                char amount[500];
                sprintf(amount, "We did it boys! Now back to the Grim Guzzler and we'll drink to the %u that were injured!", guzzlerCounter);
                herald->MonsterYell(amount, LANG_UNIVERSAL, 0);
            }

            Reset();
            events.RescheduleEvent(EVENT_CHECK_HOUR, 60000);
        }

        void FinishAttackDueToWin()
        {
            if (Creature* herald = me->FindNearestCreature(NPC_DARK_IRON_HERALD, 100.0f))
            {
                char amount[500];
                sprintf(amount, "RETREAT!! We've already lost %u and we can't afford to lose any more!!", guzzlerCounter);
                herald->MonsterYell(amount, LANG_UNIVERSAL, 0);
            }

            me->CastSpell(me, (me->GetMapId() == 1 ? SPELL_SUMMON_PLANS_H : SPELL_SUMMON_PLANS_A), true);
            Reset();
        }

        void PrepareEvent()
        {
            Creature* cr;
            if (me->GetMapId() == 1) // Kalimdor
            {
                if ((cr = me->SummonCreature(NPC_DROHN_KEG, 1183.69f, -4315.15f, 21.1875f, 0.750492f)))
                    summons.Summon(cr);
                if ((cr = me->SummonCreature(NPC_VOODOO_KEG, 1182.42f, -4272.45f, 21.1182f, -1.02974f)))
                    summons.Summon(cr);
                if ((cr = me->SummonCreature(NPC_GORDOK_KEG, 1223.78f, -4296.48f, 21.1707f, -2.86234f)))
                    summons.Summon(cr);
            }
            else if (me->GetMapId() == 0) // Eastern Kingdom
            {
                if ((cr = me->SummonCreature(NPC_BARLEYBREW_KEG, -5187.23f, -599.779f, 397.176f, 0.017453f)))
                    summons.Summon(cr);
                if ((cr = me->SummonCreature(NPC_THUNDERBREW_KEG, -5160.05f, -632.632f, 397.178f, 1.39626f)))
                    summons.Summon(cr);
                if ((cr = me->SummonCreature(NPC_GORDOK_KEG, -5145.75f, -575.667f, 397.176f, -2.28638f)))
                    summons.Summon(cr);
            }

            if ((cr = me->SummonCreature(NPC_DARK_IRON_HERALD, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 300000)))
                summons.Summon(cr);

            kegCounter = 0;
            guzzlerCounter = 0;
            thrown = 0;

            events.ScheduleEvent(EVENT_SPAWN_MOLE_MACHINE, 1500);
            events.ScheduleEvent(EVENT_PRE_FINISH_ATTACK, 280000);
            events.ScheduleEvent(EVENT_BARTENDER_SAY, 5000);
        }

        bool AllowStart()
        {
            time_t curtime = time(nullptr);
            tm strDate;
            ACE_OS::localtime_r(&curtime, &strDate);

            if (strDate.tm_min == 0 || strDate.tm_min == 30)
                return true;

            return false;
        }

        Creature* GetRandomBartender()
        {
            uint32 entry = 0;
            switch (urand(0,2))
            {
                case 0:
                    entry = (me->GetMapId() == 1 ? NPC_NORMAL_DROHN : NPC_NORMAL_THUNDERBREW);
                    break;
                case 1:
                    entry = (me->GetMapId() == 1 ? NPC_NORMAL_VOODOO : NPC_NORMAL_BARLEYBREW);
                    break;
                case 2:
                    entry = NPC_NORMAL_GORDOK;
                    break;
            }

            return me->FindNearestCreature(entry, 100.0f);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_dark_iron_attack_generatorAI(creature);
    }
};

class npc_dark_iron_attack_mole_machine : public CreatureScript
{
public:
    npc_dark_iron_attack_mole_machine() : CreatureScript("npc_dark_iron_attack_mole_machine") { }

    struct npc_dark_iron_attack_mole_machineAI : public ScriptedAI
    {
        npc_dark_iron_attack_mole_machineAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void EnterCombat(Unit*) {}
        void MoveInLineOfSight(Unit*) {}
        void AttackStart(Unit*) {}

        uint32 goTimer, summonTimer;
        void Reset()
        {
            goTimer = 1;
            summonTimer = 0;
        }

        void UpdateAI(uint32 diff)
        {
            if (goTimer)
            {
                goTimer += diff;
                if (goTimer >= 3000)
                {
                    goTimer = 0;
                    summonTimer++;
                    if (GameObject* drill = me->SummonGameObject(GO_MOLE_MACHINE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), M_PI/4, 0.0f, 0.0f, 0.0f, 0.0f, 8))
                    {
                        //drill->SetGoAnimProgress(0);
                        drill->SetLootState(GO_READY);
                        drill->UseDoorOrButton(8);
                    }
                }
            }
            if (summonTimer)
            {
                summonTimer += diff;
                if (summonTimer >= 2000 && summonTimer < 10000)
                {
                    me->SummonCreature(NPC_DARK_IRON_GUZZLER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 6000);
                    summonTimer = 10000;
                }
                if (summonTimer >= 13000 && summonTimer < 20000)
                {
                    me->SummonCreature(NPC_DARK_IRON_GUZZLER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 6000);
                    summonTimer = 0;
                    me->DespawnOrUnsummon(3000);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_dark_iron_attack_mole_machineAI(creature);
    }
};

class npc_dark_iron_guzzler : public CreatureScript
{
public:
    npc_dark_iron_guzzler() : CreatureScript("npc_dark_iron_guzzler") { }

    struct npc_dark_iron_guzzlerAI : public ScriptedAI
    {
        npc_dark_iron_guzzlerAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        uint32 timer;
        uint64 targetGUID;
        void EnterCombat(Unit*) {}
        void MoveInLineOfSight(Unit*) {}
        void AttackStart(Unit*) {}

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            damage = 0;
        }

        void FindNextKeg()
        {
            uint32 entry[3] = {0, 0, 0};
            uint32 shuffled[3] = {0, 0, 0};

            if (me->GetMapId() == 1) // Kalimdor
            {
                entry[0] = NPC_DROHN_KEG;
                entry[1] = NPC_VOODOO_KEG;
                entry[2] = NPC_GORDOK_KEG;
            }
            else// if (me->GetMapId() == 0) // EK
            {
                entry[0] = NPC_THUNDERBREW_KEG;
                entry[1] = NPC_BARLEYBREW_KEG;
                entry[2] = NPC_GORDOK_KEG;
            }

            for (uint8 i = 0; i < 3; ++i)
            {
                uint8 index=0;
                do
                    index = urand(0,2);
                while (shuffled[index]);

                shuffled[index] = entry[i];
            }

            for (uint8 i = 0; i < 3; ++i)
                if (Creature* cr = me->FindNearestCreature(shuffled[i], 100.0f))
                {
                    me->GetMotionMaster()->MoveFollow(cr, 1.0f, cr->GetAngle(me));
                    targetGUID = cr->GetGUID();
                    return;
                }

            // no kegs found
            me->DisappearAndDie();
        }

        Unit* GetTarget() { return ObjectAccessor::GetUnit(*me, targetGUID); }

        void Reset()
        {
            timer = 0;
            targetGUID = 0;
            me->SetWalk(true);
            FindNextKeg();
            me->ApplySpellImmune(SPELL_ATTACK_KEG, IMMUNITY_ID, SPELL_ATTACK_KEG, true);
            SayText();
            me->CastSpell(me, SPELL_KNOCKBACK_AURA, true);
        }

        void SayText()
        {
            if (!urand(0,20))
            {
                switch (urand(0,4))
                {
                    case 0:
                        me->MonsterSay("Drink it all boys!", LANG_UNIVERSAL, 0);
                        break;
                    case 1:
                        me->MonsterSay("DRINK! BRAWL! DRINK! BRAWL!", LANG_UNIVERSAL, 0);
                        break;
                    case 2:
                        me->MonsterSay("Did someone say, \"Free Brew\"?", LANG_UNIVERSAL, 0);
                        break;
                    case 3:
                        me->MonsterSay("No one expects the Dark Iron dwarves!", LANG_UNIVERSAL, 0);
                        break;
                    case 4:
                        me->MonsterSay("It's not a party without some crashers!", LANG_UNIVERSAL, 0);
                        break;
                }
            }
        }

        void KilledUnit(Unit* who)
        {
            who->CastSpell(who, SPELL_REPORT_DEATH, true);
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
        {
            if (me->IsAlive() && spellInfo->Id == SPELL_PLAYER_MUG)
            {
                me->CastSpell(me, SPELL_MUG_BOUNCE_BACK, true);
                Unit::Kill(me, me);
                me->CastSpell(me, SPELL_REPORT_DEATH, true);
            }
        }

        void UpdateAI(uint32 diff)
        {
            timer += diff;
            if (timer < 2000)
                return;

            timer = 0;
            if (targetGUID)
            {
                if (Unit* target = GetTarget())
                    me->CastSpell(target, SPELL_ATTACK_KEG, false);
                else
                    FindNextKeg();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_dark_iron_guzzlerAI(creature);
    }
};

class npc_brewfest_super_brew_trigger : public CreatureScript
{
public:
    npc_brewfest_super_brew_trigger() : CreatureScript("npc_brewfest_super_brew_trigger") { }

    struct npc_brewfest_super_brew_triggerAI : public ScriptedAI
    {
        npc_brewfest_super_brew_triggerAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        uint32 timer;
        void EnterCombat(Unit*) {}
        void MoveInLineOfSight(Unit*  /*who*/)
        {
        }

        void AttackStart(Unit*) {}

        void Reset()
        {
            timer = 0;
            me->SummonGameObject(186478, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 30000);
        }

        void UpdateAI(uint32 diff)
        {
            timer += diff;
            if (timer >= 500)
            {
                timer = 0;
                Player* player = nullptr;
                acore::AnyPlayerInObjectRangeCheck checker(me, 2.0f);
                acore::PlayerSearcher<acore::AnyPlayerInObjectRangeCheck> searcher(me, player, checker);
                me->VisitNearbyWorldObject(2.0f, searcher);
                if (player)
                {
                    player->CastSpell(player, SPELL_DRUNKEN_MASTER, true);
                    me->RemoveAllGameObjects();
                    Unit::Kill(me, me);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_brewfest_super_brew_triggerAI(creature);
    }
};


///////////////////////////////////////
////// SPELLS
///////////////////////////////////////

enum ramRacing
{
    SPELL_TROT              = 42992,
    SPELL_CANTER            = 42993,
    SPELL_GALLOP            = 42994,
    SPELL_RAM_FATIGUE       = 43052,
    SPELL_RAM_EXHAUSTED     = 43332,

    CREDIT_TROT             = 24263,
    CREDIT_CANTER           = 24264,
    CREDIT_GALLOP           = 24265,

    RACING_RAM_MODEL        = 22630,
};

class spell_brewfest_main_ram_buff : public SpellScriptLoader
{
public:
    spell_brewfest_main_ram_buff() : SpellScriptLoader("spell_brewfest_main_ram_buff") { }

    class spell_brewfest_main_ram_buff_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_brewfest_main_ram_buff_AuraScript)

        uint8 privateLevel;
        uint32 questTick;
        bool Load()
        {
            questTick = 0;
            privateLevel = 0;
            return true;
        }

        void HandleEffectPeriodic(AuraEffect const* aurEff)
        {
            Unit* caster = GetCaster();
            if (!caster || !caster->IsMounted() || !caster->ToPlayer())
                return;

            if (caster->GetMountID() != RACING_RAM_MODEL)
                return;

            Aura* aur = caster->GetAura(42924);
            if (!aur)
            {
                caster->CastSpell(caster, 42924, true);
                return;
            }

            // Check if exhausted
            if (caster->GetAura(SPELL_RAM_EXHAUSTED))
            {
                if (privateLevel)
                {
                    caster->RemoveAurasDueToSpell(SPELL_CANTER);
                    caster->RemoveAurasDueToSpell(SPELL_GALLOP);
                }

                aur->SetStackAmount(1);
                return;
            }

            uint32 stack = aur->GetStackAmount();
            uint8 mode = 0;
            switch (privateLevel)
            {
            case 0:
                if (stack > 1)
                {
                    questTick = 0;
                    caster->CastSpell(caster, SPELL_TROT, true);
                    privateLevel++;
                    mode = 1; // unapply
                    break;
                }
                // just walking, fatiuge handling
                if (Aura* aur = caster->GetAura(SPELL_RAM_FATIGUE))
                    aur->ModStackAmount(-4);
                break;
            case 1:
                // One click to maintain speed, more to increase
                if (stack < 2)
                {
                    caster->RemoveAurasDueToSpell(SPELL_TROT);
                    questTick = 0;
                    privateLevel--;
                    mode = 2; // apply
                }
                else if (stack > 2)
                {
                    questTick = 0;
                    caster->CastSpell(caster, SPELL_CANTER, true);
                    privateLevel++;
                }
                else if (questTick++ > 3)
                    caster->ToPlayer()->KilledMonsterCredit(CREDIT_TROT, 0);
                break;
            case 2:
                // Two - three clicks to maintains speed, less to decrease, more to increase
                if (stack < 3)
                {
                    caster->CastSpell(caster, SPELL_TROT, true);
                    privateLevel--;
                    questTick = 0;
                }
                else if (stack > 4)
                {
                    caster->CastSpell(caster, SPELL_GALLOP, true);
                    privateLevel++;
                    questTick = 0;
                }
                else if (questTick++ > 3)
                    caster->ToPlayer()->KilledMonsterCredit(CREDIT_CANTER, 0);
                break;
            case 3:
                // Four or more clicks to maintains speed, less to decrease
                if (stack < 5)
                {
                    caster->CastSpell(caster, SPELL_CANTER, true);
                    privateLevel--;
                    questTick = 0;
                }
                else if (questTick++ > 3)
                    caster->ToPlayer()->KilledMonsterCredit(CREDIT_GALLOP, 0);
                break;
            }

            // Set to base amount
            aur->SetStackAmount(1);

            // apply/unapply effect 1
            if (mode)
                if (Aura* base = aurEff->GetBase())
                    if (AuraEffect* aEff = base->GetEffect(EFFECT_0))
                    {
                        aEff->SetAmount(mode == 1 ? 0 : -50);
                        caster->UpdateSpeed(MOVE_RUN, true);
                    }
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
                target->RemoveAurasDueToSpell(SPELL_RAM_FATIGUE);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_brewfest_main_ram_buff_AuraScript::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            OnEffectRemove += AuraEffectRemoveFn(spell_brewfest_main_ram_buff_AuraScript::HandleEffectRemove, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_brewfest_main_ram_buff_AuraScript();
    }
};

class spell_brewfest_ram_fatigue : public SpellScriptLoader
{
public:
    spell_brewfest_ram_fatigue() : SpellScriptLoader("spell_brewfest_ram_fatigue") { }

    class spell_brewfest_ram_fatigue_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_brewfest_ram_fatigue_AuraScript)

        void HandleEffectPeriodic(AuraEffect const* aurEff)
        {
            int8 fatigue = 0;
            switch (aurEff->GetId())
            {
            case SPELL_TROT:
                fatigue = -2;
                break;
            case SPELL_CANTER:
                fatigue = 1;
                break;
            case SPELL_GALLOP:
                fatigue = 5;
                break;
            }
            if (Unit* target = GetTarget())
            {
                if (Aura* aur = target->GetAura(SPELL_RAM_FATIGUE))
                {
                    aur->ModStackAmount(fatigue);
                    if (aur->GetStackAmount() >= 100)
                        target->CastSpell(target, SPELL_RAM_EXHAUSTED, true);
                }
                else
                    target->CastSpell(target, SPELL_RAM_FATIGUE, true);
            }

        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
            {
                if (Aura* aur = target->GetAura(SPELL_RAM_FATIGUE))
                    aur->ModStackAmount(-15);
            }
        }

        void Register()
        {
            if (m_scriptSpellId != 43332)
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_brewfest_ram_fatigue_AuraScript::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            else
                OnEffectRemove += AuraEffectRemoveFn(spell_brewfest_ram_fatigue_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_brewfest_ram_fatigue_AuraScript();
    }
};

class spell_brewfest_apple_trap : public SpellScriptLoader
{
public:
    spell_brewfest_apple_trap() : SpellScriptLoader("spell_brewfest_apple_trap") { }

    class spell_brewfest_apple_trap_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_brewfest_apple_trap_SpellScript);

        void HandleDummyEffect(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
                if (Aura* aur = target->GetAura(SPELL_RAM_FATIGUE))
                    aur->Remove();
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_brewfest_apple_trap_SpellScript::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_brewfest_apple_trap_SpellScript();
    };
};

class spell_q11117_catch_the_wild_wolpertinger : public SpellScriptLoader
{
public:
    spell_q11117_catch_the_wild_wolpertinger() : SpellScriptLoader("spell_q11117_catch_the_wild_wolpertinger") { }

    class spell_q11117_catch_the_wild_wolpertinger_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q11117_catch_the_wild_wolpertinger_SpellScript);

        SpellCastResult CheckTarget()
        {
            if (Unit* caster = GetCaster())
                if (caster->ToPlayer())
                    if (Unit* target = caster->ToPlayer()->GetSelectedUnit())
                        if (target->GetEntry() == 23487 && target->IsAlive())
                            return SPELL_CAST_OK;

            return SPELL_FAILED_BAD_TARGETS;
        }

        void HandleDummyEffect(SpellEffIndex /*effIndex*/)
        {
            if (GetCaster() && GetCaster()->ToPlayer())
            {
                GetCaster()->ToPlayer()->AddItem(32906, 1);
                if (Unit* target = GetCaster()->ToPlayer()->GetSelectedUnit())
                    target->ToCreature()->DespawnOrUnsummon(500);
            }
        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_q11117_catch_the_wild_wolpertinger_SpellScript::CheckTarget);
            OnEffectHitTarget += SpellEffectFn(spell_q11117_catch_the_wild_wolpertinger_SpellScript::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q11117_catch_the_wild_wolpertinger_SpellScript();
    };
};

enum fillKeg
{
    GREEN_EMPTY_KEG             = 37892,
    BLUE_EMPTY_KEG              = 33016,
    YELLOW_EMPTY_KEG            = 32912,
};

class spell_brewfest_fill_keg : public SpellScriptLoader
{
public:
    spell_brewfest_fill_keg() : SpellScriptLoader("spell_brewfest_fill_keg") { }

    class spell_brewfest_fill_keg_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_brewfest_fill_keg_SpellScript);

        void HandleAfterHit()
        {
            if (GetCaster() && GetCaster()->ToPlayer())
            {
                if (Item* itemCaster = GetCastItem())
                {
                    Player* player = GetCaster()->ToPlayer();
                    uint32 item = 0;
                    switch (itemCaster->GetEntry())
                    {
                        case GREEN_EMPTY_KEG:
                        case BLUE_EMPTY_KEG:
                            item = itemCaster->GetEntry()+urand(1,5); // 5 items, id in range empty+1-5
                            break;
                        case YELLOW_EMPTY_KEG:
                            if (uint8 num = urand(0,4))
                                item = 32916+num;
                            else
                                item = 32915;
                            break;
                    }

                    if (item && player->AddItem(item, 1)) // ensure filled keg is stored
                    {
                        player->DestroyItemCount(itemCaster->GetEntry(), 1, true);
                        GetSpell()->m_CastItem = nullptr;
                        GetSpell()->m_castItemGUID = 0;
                    }
                }
            }
        }

        void Register()
        {
            AfterHit += SpellHitFn(spell_brewfest_fill_keg_SpellScript::HandleAfterHit);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_brewfest_fill_keg_SpellScript();
    };
};

class spell_brewfest_unfill_keg : public SpellScriptLoader
{
public:
    spell_brewfest_unfill_keg() : SpellScriptLoader("spell_brewfest_unfill_keg") { }

    class spell_brewfest_unfill_keg_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_brewfest_unfill_keg_SpellScript);

        uint32 GetEmptyEntry(uint32 baseEntry)
        {
            switch (baseEntry)
            {
                case 37893:
                case 37894:
                case 37895:
                case 37896:
                case 37897:
                    return GREEN_EMPTY_KEG;
                case 33017:
                case 33018:
                case 33019:
                case 33020:
                case 33021:
                    return BLUE_EMPTY_KEG;
                case 32915:
                case 32917:
                case 32918:
                case 32919:
                case 32920:
                    return YELLOW_EMPTY_KEG;
            }

            return 0;
        }

        void HandleAfterHit()
        {
            if (GetCaster() && GetCaster()->ToPlayer())
            {
                if (Item* itemCaster = GetCastItem())
                {
                    uint32 item = GetEmptyEntry(itemCaster->GetEntry());
                    Player* player = GetCaster()->ToPlayer();

                    if (item && player->AddItem(item, 1)) // ensure filled keg is stored
                    {
                        player->DestroyItemCount(itemCaster->GetEntry(), 1, true);
                        GetSpell()->m_CastItem = nullptr;
                        GetSpell()->m_castItemGUID = 0;
                    }
                }
            }
        }

        void Register()
        {
            AfterHit += SpellHitFn(spell_brewfest_unfill_keg_SpellScript::HandleAfterHit);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_brewfest_unfill_keg_SpellScript();
    };
};

class spell_brewfest_toss_mug : public SpellScriptLoader
{
public:
    spell_brewfest_toss_mug() : SpellScriptLoader("spell_brewfest_toss_mug") { }

    class spell_brewfest_toss_mug_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_brewfest_toss_mug_SpellScript);

        SpellCastResult CheckCast()
        {
            if (Unit* caster = GetCaster())
            {
                float z = caster->GetMap()->GetHeight(caster->GetPositionX()+14*cos(caster->GetOrientation()), caster->GetPositionY()+14*sin(caster->GetOrientation()), MAX_HEIGHT);
                WorldLocation pPosition = WorldLocation(caster->GetMapId(), caster->GetPositionX()+14*cos(caster->GetOrientation()), caster->GetPositionY()+14*sin(caster->GetOrientation()), z, caster->GetOrientation());
                SetExplTargetDest(pPosition);
            }

            return SPELL_CAST_OK;
        }

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            Unit* caster = GetCaster();
            if (!caster)
                return;

            WorldObject* target = nullptr;
            for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                if (caster->HasInLine((*itr), 2.0f))
                {
                    target = (*itr);
                    break;
                }

            targets.clear();
            if (target)
                targets.push_back(target);

            targets.push_back(caster);
        }

        void HandleBeforeHit()
        {
            if (Unit* target = GetHitUnit())
            {
                if (!GetCaster() || target->GetGUID() == GetCaster()->GetGUID())
                    return;

                WorldLocation pPosition = WorldLocation(target->GetMapId(), target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()+4.0f, target->GetOrientation());
                SetExplTargetDest(pPosition);
            }
        }

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            Creature* cr = nullptr;
            Unit* caster = GetCaster();
            if (!caster)
                return;

            if (!GetHitUnit() || GetHitUnit()->GetGUID() != caster->GetGUID())
                return;

            if (caster->GetMapId() == 1) // Kalimdor
            {
                if ((cr = caster->FindNearestCreature(NPC_NORMAL_VOODOO, 40.0f)))
                    cr->CastSpell(caster, SPELL_THROW_MUG_TO_PLAYER, true);
                else if ((cr = caster->FindNearestCreature(NPC_NORMAL_DROHN, 40.0f)))
                    cr->CastSpell(caster, SPELL_THROW_MUG_TO_PLAYER, true);
                else if ((cr = caster->FindNearestCreature(NPC_NORMAL_GORDOK, 40.0f)))
                    cr->CastSpell(caster, SPELL_THROW_MUG_TO_PLAYER, true);
            }
            else // EK
            {
                if ((cr = caster->FindNearestCreature(NPC_NORMAL_THUNDERBREW, 40.0f)))
                    cr->CastSpell(caster, SPELL_THROW_MUG_TO_PLAYER, true);
                else if ((cr = caster->FindNearestCreature(NPC_NORMAL_BARLEYBREW, 40.0f)))
                    cr->CastSpell(caster, SPELL_THROW_MUG_TO_PLAYER, true);
                else if ((cr = caster->FindNearestCreature(NPC_NORMAL_GORDOK, 40.0f)))
                    cr->CastSpell(caster, SPELL_THROW_MUG_TO_PLAYER, true);
            }

        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_brewfest_toss_mug_SpellScript::CheckCast);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_brewfest_toss_mug_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            BeforeHit += SpellHitFn(spell_brewfest_toss_mug_SpellScript::HandleBeforeHit);
            OnEffectHitTarget += SpellEffectFn(spell_brewfest_toss_mug_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_brewfest_toss_mug_SpellScript();
    };
};

class spell_brewfest_add_mug : public SpellScriptLoader
{
public:
    spell_brewfest_add_mug() : SpellScriptLoader("spell_brewfest_add_mug") { }

    class spell_brewfest_add_mug_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_brewfest_add_mug_SpellScript);

        void HandleDummyEffect(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
                target->CastSpell(target, SPELL_ADD_MUG, true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_brewfest_add_mug_SpellScript::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_brewfest_add_mug_SpellScript();
    };
};

//
enum brewBubble
{
    SPELL_BUBBLE_BUILD_UP           = 49828,
};

class npc_brew_bubble : public CreatureScript
{
public:
    npc_brew_bubble() : CreatureScript("npc_brew_bubble") { }

    struct npc_brew_bubbleAI : public NullCreatureAI
    {
        npc_brew_bubbleAI(Creature* creature) : NullCreatureAI(creature)
        {
        }

        uint32 timer;

        void Reset()
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->GetMotionMaster()->MoveRandom(15.0f);
            timer = 0;
        }

        void DoAction(int32)
        {
            timer = 0;
        }

        void MoveInLineOfSight(Unit* target)
        {
            if (target->GetEntry() == me->GetEntry())
                if (me->IsWithinDist(target, 1.0f))
                {
                    uint8 stacksMe = me->GetAuraCount(SPELL_BUBBLE_BUILD_UP);
                    uint8 stacksTarget = target->GetAuraCount(SPELL_BUBBLE_BUILD_UP);
                    if (stacksMe >= stacksTarget)
                    {
                        if (Aura* aura = me->GetAura(SPELL_BUBBLE_BUILD_UP))
                            aura->ModStackAmount(stacksTarget+1);
                        else
                            me->AddAura(SPELL_BUBBLE_BUILD_UP, me);

                        target->ToCreature()->DespawnOrUnsummon();
                        DoAction(0);
                    }
                    else if (Aura* aura = target->GetAura(SPELL_BUBBLE_BUILD_UP))
                    {
                        aura->ModStackAmount(stacksMe);

                        target->ToCreature()->AI()->DoAction(0);
                        me->DespawnOrUnsummon();
                    }
                }
        }

        void UpdateAI(uint32 diff)
        {
            timer += diff;
            if (timer >= 25000)
            {
                timer = 0;
                me->DespawnOrUnsummon();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_brew_bubbleAI(creature);
    }
};

void AddSC_event_brewfest_scripts()
{
    // Npcs
    new npc_brewfest_reveler();
    new npc_coren_direbrew();
    new npc_coren_direbrew_sisters();
    new npc_brewfest_keg_thrower();
    new npc_brewfest_keg_reciver();
    new npc_brewfest_bark_trigger();
    new npc_dark_iron_attack_generator();
    new npc_dark_iron_attack_mole_machine();
    new npc_dark_iron_guzzler();
    new npc_brewfest_super_brew_trigger();

    // Spells
    // ram
    new spell_brewfest_main_ram_buff();
    new spell_brewfest_ram_fatigue();
    new spell_brewfest_apple_trap();
    // other
    new spell_q11117_catch_the_wild_wolpertinger();
    new spell_brewfest_fill_keg();
    new spell_brewfest_unfill_keg();
    new spell_brewfest_toss_mug();
    new spell_brewfest_add_mug();

    // beer effect
    new npc_brew_bubble();
}
