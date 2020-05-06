/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Sholazar_Basin
SD%Complete: 100
SDComment: Quest support: 12570, 12573, 12621.
SDCategory: Sholazar_Basin
EndScriptData */

/* ContentData
npc_injured_rainspeaker_oracle
npc_vekjik
avatar_of_freya
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "SpellAuras.h"
#include "Player.h"
#include "Vehicle.h"
#include "WaypointManager.h"
#include "PassiveAI.h"
#include "CombatAI.h"

// Ours
enum songOfWindandWater
{
    NPC_SOWAW_WATER_ELEMENTAL           = 28999,
    NPC_SOWAW_WIND_ELEMENTAL            = 28985,
    NPC_SOWAW_WIND_MODEL                = 14516,
    NPC_SOWAW_WATER_MODEL               = 20076,
};

class spell_q12726_song_of_wind_and_water : public SpellScriptLoader
{
    public:
        spell_q12726_song_of_wind_and_water() : SpellScriptLoader("spell_q12726_song_of_wind_and_water") { }

        class spell_q12726_song_of_wind_and_water_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12726_song_of_wind_and_water_SpellScript);

            void HandleHealPct(SpellEffIndex /*effIndex*/)
            {
                if (Creature* cr = GetHitCreature())
                {
                    //cr->UpdateEntry((cr->GetEntry() == NPC_SOWAW_WATER_ELEMENTAL ? NPC_SOWAW_WIND_ELEMENTAL : NPC_SOWAW_WATER_ELEMENTAL));
                    cr->SetDisplayId(cr->GetDisplayId() == NPC_SOWAW_WATER_MODEL ? NPC_SOWAW_WIND_MODEL : NPC_SOWAW_WATER_MODEL);
                    if (Player* player = cr->GetCharmerOrOwnerPlayerOrPlayerItself())
                    {
                        player->KilledMonsterCredit(cr->GetDisplayId() == NPC_SOWAW_WATER_MODEL ? 29008 : 29009, 0);
                        CreatureTemplate const* ct = sObjectMgr->GetCreatureTemplate(cr->GetDisplayId() == NPC_SOWAW_WIND_MODEL ? NPC_SOWAW_WIND_ELEMENTAL : NPC_SOWAW_WATER_ELEMENTAL);
                        for (uint8 i=0; i < CREATURE_MAX_SPELLS; ++i)
                            cr->m_spells[i] = ct->spells[i];

                        player->VehicleSpellInitialize();
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12726_song_of_wind_and_water_SpellScript::HandleHealPct, EFFECT_2, SPELL_EFFECT_HEAL_PCT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12726_song_of_wind_and_water_SpellScript();
        }
};

enum AHerosBurden
{
    SPELL_TOMB_OF_THE_HEARTLESS = 52182,
    SPELL_ARTRUIS_FROST_NOVA    = 11831,
    SPELL_ARTRUIS_FROSTBOLT     = 15530,
    SPELL_ARTRUIS_ICE_LANCE     = 54261,
    SPELL_ARTRUIS_ICY_VEINS     = 54792,
    SPELL_ARTRUIS_BINDING       = 52185,

    NPC_JALOOT                  = 28667,
    NPC_ZEPIK                   = 28668,

    EVENT_CAST_FROST_BOLT       = 1,
    EVENT_CAST_FROST_NOVA       = 2,
    EVENT_CAST_ICE_LANCE        = 3,
    EVENT_CAST_ICY_VEINS        = 4,
    EVENT_ARTRUIS_HP_CHECK      = 5,
    EVENT_ARTRUIS_TALK1         = 6,
    EVENT_ARTRUIS_TALK2         = 7,
    EVENT_ARTRUIS_TALK3         = 8,

    ACTION_BIND_MINIONS         = 1,
    ACTION_MAKE_FRIENDLY        = 2,

    GO_ARTRUIS_PHYLACTERY       = 190777,
};

class npc_artruis_the_hearthless : public CreatureScript
{
public:
    npc_artruis_the_hearthless() : CreatureScript("npc_artruis_the_hearthless") { }

    struct npc_artruis_the_hearthlessAI : public ScriptedAI
    {
        npc_artruis_the_hearthlessAI(Creature* creature) : ScriptedAI(creature), summons(me) { }

        EventMap events;
        SummonList summons;
        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            me->SetControlled(false, UNIT_STATE_STUNNED);

            Creature *cr;
            if ((cr = me->SummonCreature(NPC_JALOOT, 5616.91f, 3772.67f, -94.26f, 1.78f)))
            {
                summons.Summon(cr);
                cr->CastSpell(cr, SPELL_TOMB_OF_THE_HEARTLESS, true);
                cr->setFaction(me->getFaction());
            }
            if ((cr = me->SummonCreature(NPC_ZEPIK, 5631.63f, 3794.36f, -92.24f, 3.45f)))
            {
                summons.Summon(cr);
                cr->CastSpell(cr, SPELL_TOMB_OF_THE_HEARTLESS, true);
                cr->setFaction(me->getFaction());
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetEntry() == NPC_JALOOT || who->GetEntry() == NPC_ZEPIK)
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit*  /*who*/)
        {
            me->MonsterYell("Ah, the heroes. Your little friends said you would come. This certainly saves me the trouble of hunting you down myself.", LANG_UNIVERSAL, 0);
            me->CastSpell(me, SPELL_ARTRUIS_ICY_VEINS, true);
            events.RescheduleEvent(EVENT_CAST_FROST_BOLT, 4000);
            events.RescheduleEvent(EVENT_CAST_FROST_NOVA, 15000);
            events.RescheduleEvent(EVENT_CAST_ICE_LANCE, 8500);
            events.RescheduleEvent(EVENT_CAST_ICY_VEINS, 30000);
            events.RescheduleEvent(EVENT_ARTRUIS_HP_CHECK, 1000);
            events.RescheduleEvent(EVENT_ARTRUIS_TALK1, 6000);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (GameObject* go = me->SummonGameObject(GO_ARTRUIS_PHYLACTERY, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 600000))
                me->RemoveGameObject(go, false);
        }

        void SummonedCreatureDies(Creature* summon, Unit*)
        {
            SummonsAction(ACTION_MAKE_FRIENDLY);
            me->RemoveAurasDueToSpell(SPELL_ARTRUIS_BINDING);
            summon->DespawnOrUnsummon(60000);
            me->SetControlled(false, UNIT_STATE_STUNNED);
        }

        void SummonsAction(uint8 action)
        {
            if (!summons.empty())
            {
                if (action == ACTION_BIND_MINIONS)
                    me->CastSpell(me, SPELL_ARTRUIS_BINDING, true);

                for (std::list<uint64>::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                {
                    Creature *minion = ObjectAccessor::GetCreature(*me, *itr);
                    if (minion && minion->IsAlive())
                    {
                        if (action == ACTION_BIND_MINIONS)
                        {
                            minion->RemoveAurasDueToSpell(SPELL_TOMB_OF_THE_HEARTLESS);
                            if (me->GetVictim())
                                minion->AI()->AttackStart(me->GetVictim());
                        }
                        else if (action == ACTION_MAKE_FRIENDLY && me->GetVictim())
                        {
                            minion->MonsterSay("Now you not catch us with back turned! Now we hurt you bad undead. BAD!", LANG_UNIVERSAL, 0);
                            minion->RemoveAurasDueToSpell(SPELL_ARTRUIS_BINDING);
                            minion->setFaction(me->GetVictim()->getFaction());
                            minion->AddThreat(me, 100000.0f);
                            minion->AI()->AttackStart(me);
                            minion->DespawnOrUnsummon(900000);
                            events.RescheduleEvent(EVENT_ARTRUIS_TALK3, 5000);
                        }
                    }
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
                case EVENT_ARTRUIS_HP_CHECK:
                    if (me->GetHealthPct() <= 30)
                    {
                        me->SetControlled(true, UNIT_STATE_STUNNED);
                        me->MonsterTextEmote("Artruis is shielded. You must choose your side quickly to break his spell.", 0, true);
                        SummonsAction(ACTION_BIND_MINIONS);
                        events.PopEvent();
                        break;
                    }
                    events.RepeatEvent(1000);
                    break;
                case EVENT_ARTRUIS_TALK1:
                    me->MonsterYell("I have weathered a hundred years of war and suffering. Do you truly think it wise to pit your mortal bodies against a being that cannot die? I'd venture you have more to lose.", LANG_UNIVERSAL, 0);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_ARTRUIS_TALK2, 10000);
                    break;
                case EVENT_ARTRUIS_TALK2:
                    me->MonsterYell("Even shattered into countless pieces, the crystals all around weaken me... perhaps i should not have underestimated the titans so...", LANG_UNIVERSAL, 0);
                    events.PopEvent();
                    break;
                case EVENT_ARTRUIS_TALK3:
                    me->MonsterYell("Arthas once mustered strength... of the very same sort... perhaps he is the path that you will follow.", LANG_UNIVERSAL, 0);
                    events.PopEvent();
                    break;
                case EVENT_CAST_FROST_BOLT:
                    me->CastSpell(me->GetVictim(), SPELL_ARTRUIS_FROSTBOLT, false);
                    events.RepeatEvent(4000);
                    break;
                case EVENT_CAST_ICE_LANCE:
                    me->CastSpell(me->GetVictim(), SPELL_ARTRUIS_ICE_LANCE, false);
                    events.RepeatEvent(8500);
                    break;
                case EVENT_CAST_FROST_NOVA:
                    me->CastSpell(me, SPELL_ARTRUIS_FROST_NOVA, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_CAST_ICY_VEINS:
                    me->CastSpell(me, SPELL_ARTRUIS_ICY_VEINS, false);
                    events.RepeatEvent(30000);
                    break;
            }
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_artruis_the_hearthlessAI(creature);
    }
};


/******
quest Still At It (12644)
******/

#define MCM_TEXT_START "Beginning the distillation in 5 seconds."
#define MCM_TEXT_PRESSURE "Pressure's too high! Open the pressure valve!"
#define MCM_TEXT_HEAT "The still needs heat! Light the brazier!"
#define MCM_TEXT_BANANA "Add bananas!"
#define MCM_TEXT_ORANGE "Add another orange! Quickly!"
#define MCM_TEXT_PAPAYA "Put a papaya in the still!"
#define MCM_TEXT_CORRECT1 "Nicely handled! Stay on your toes!"
#define MCM_TEXT_CORRECT2 "That'll do. Never know what it'll need next..."
#define MCM_TEXT_CORRECT3 "Good job! Keep your eyes open, now."
#define MCM_TEXT_SUCCESS1 "Well done! Be ready for anything!"
#define MCM_TEXT_SUCCESS2 "We've done it! Come get the cask."
#define MCM_TEXT_FAILED "You have FAILED!!!"
#define ACTION_PRESSURE 1
#define ACTION_HEAT 2
#define ACTION_BANANA 3
#define ACTION_ORANGE 4
#define ACTION_PAPAYA 5
#define NPC_WANTS_BANANAS 28537

class npc_still_at_it_trigger : public CreatureScript
{
public:
    npc_still_at_it_trigger() : CreatureScript("npc_still_at_it_trigger") { }

    CreatureAI *GetAI(Creature *pCreature) const
    {
        return new npc_still_at_it_triggerAI(pCreature);
    }

    struct npc_still_at_it_triggerAI : public NullCreatureAI
    {
        bool running;
        bool success;
        uint64 playerGUID;
        uint64 thunderbrewGUID;
        int32 tensecstimer;
        int32 timer;
        uint8 stepcount;
        uint8 currentstep;
        uint8 expectedaction;
        uint8 playeraction;

        npc_still_at_it_triggerAI(Creature* pCreature) : NullCreatureAI(pCreature) {}

        void Reset()
        {
            running = false;
            success = false;
            playerGUID = 0;
            thunderbrewGUID = 0;
            tensecstimer = 0;
            timer = 0;
            stepcount = 0;
            currentstep = 0;
            expectedaction = 0;
            playeraction = 0;
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            damage = 0;
        }

        void Say(const char* text)
        {
            if (Creature* th = ObjectAccessor::GetCreature(*me, thunderbrewGUID))
                th->MonsterSay(text, LANG_UNIVERSAL, 0);
            else
                Reset();
        }

        void Start()
        {
            timer = 5000;
            running = true;
            stepcount = urand(5,10);
            Say(MCM_TEXT_START);
        }

        void CheckAction(uint8 a, uint64 guid)
        {
            if (guid != playerGUID)
                return;

            if (a == expectedaction)
            {
                currentstep++;
                uint8 s = urand(0,2);

                if (Creature* th = ObjectAccessor::GetCreature(*me, thunderbrewGUID))
                    th->HandleEmoteCommand(EMOTE_ONESHOT_CHEER_NO_SHEATHE);

                switch (s)
                {
                    case 0: Say(MCM_TEXT_CORRECT1); break;
                    case 1: Say(MCM_TEXT_CORRECT2); break;
                    default:Say(MCM_TEXT_CORRECT3); break;
                }

                if (currentstep >= stepcount)
                {
                    Say(MCM_TEXT_SUCCESS1);
                    success = true;
                    timer = 3000;
                }
                else
                {
                    expectedaction = 0;
                    timer = 3000;
                }
            }
            else
            {
                Say(MCM_TEXT_FAILED);
                Reset();
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spellInfo) // for banana(51932), orange(51931), papaya(51933)
        {
            if (running)
            {
                uint8 a = 0;
                switch (spellInfo->Id)
                {
                    case 51931: a = 4; break;
                    case 51932: a = 3; break;
                    case 51933: a = 5; break;
                }

                CheckAction(a, caster->GetGUID());
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (running)
            {
                if (timer)
                {
                    timer -= diff;
                    if( timer < 0 )
                        timer = 0;
                }
                else if ( success)
                {
                    Say(MCM_TEXT_SUCCESS2);
                    me->SummonGameObject(190643, 5546.55f, 5768.0f, -78.03f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 60000);
                    Reset();
                }
                else if (expectedaction != 0) // didn't make it in 10 seconds
                {
                    Say(MCM_TEXT_FAILED);
                    Reset();
                }
                else // it's time to rand next move
                {
                    expectedaction = urand(1,5);
                    switch (expectedaction)
                    {
                        case 1: Say(MCM_TEXT_PRESSURE); break;
                        case 2: Say(MCM_TEXT_HEAT); break;
                        case 3: Say(MCM_TEXT_BANANA); break;
                        case 4: Say(MCM_TEXT_ORANGE); break;
                        case 5: Say(MCM_TEXT_PAPAYA); break;
                    }
                    timer = 10000;
                }
            }
        }
    };
};

class npc_mcmanus : public CreatureScript
{
public:
    npc_mcmanus() : CreatureScript("npc_mcmanus") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!player)
            return true;

        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(12644) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "I'm ready to start the distillation, uh, Tipsy.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*uiSender*/, uint32 uiAction) override
    {
        if (!player)
            return true;

        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            Creature* trigger = creature->FindNearestCreature(NPC_WANTS_BANANAS, 20.0f, true);
            if (trigger && trigger->AI())
                if (!CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->running)
                {
                    CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->playerGUID = player->GetGUID();
                    CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->thunderbrewGUID = creature->GetGUID();
                    CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->Start();
                }
        }

        CloseGossipMenuFor(player);
        return true;
    }
};

class go_pressure_valve : public GameObjectScript
{
public:
    go_pressure_valve() : GameObjectScript("go_pressure_valve") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player)
            return true;

        Creature* trigger = go->FindNearestCreature(NPC_WANTS_BANANAS, 20.0f, true);
        if (trigger && trigger->AI())
            if (CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->running)
                CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->CheckAction(1, player->GetGUID());

        return false;
    }
};

class go_brazier : public GameObjectScript
{
public:
    go_brazier() : GameObjectScript("go_brazier") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player)
            return true;

        Creature* trigger = go->FindNearestCreature(NPC_WANTS_BANANAS, 20.0f, true);
        if (trigger && trigger->AI())
            if (CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->running)
                CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->CheckAction(2, player->GetGUID());

        return false;
    }
};


// Theirs
/*######
## npc_vekjik
######*/

#define GOSSIP_VEKJIK_ITEM1 "Shaman Vekjik, I have spoken with the big-tongues and they desire peace. I have brought this offering on their behalf."
#define GOSSIP_VEKJIK_ITEM2 "No no... I had no intentions of betraying your people. I was only defending myself. it was all a misunderstanding."

enum Vekjik
{
    GOSSIP_TEXTID_VEKJIK1       = 13137,
    GOSSIP_TEXTID_VEKJIK2       = 13138,

    SAY_TEXTID_VEKJIK1          = 0,

    SPELL_FREANZYHEARTS_FURY    = 51469,

    QUEST_MAKING_PEACE          = 12573
};

class npc_vekjik : public CreatureScript
{
public:
    npc_vekjik() : CreatureScript("npc_vekjik") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_MAKING_PEACE) == QUEST_STATUS_INCOMPLETE)
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            SendGossipMenuFor(player, GOSSIP_TEXTID_VEKJIK1, creature->GetGUID());
            return true;
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                SendGossipMenuFor(player, GOSSIP_TEXTID_VEKJIK2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                CloseGossipMenuFor(player);
                creature->AI()->Talk(SAY_TEXTID_VEKJIK1, player);
                player->AreaExploredOrEventHappens(QUEST_MAKING_PEACE);
                //creature->CastSpell(player, SPELL_FREANZYHEARTS_FURY, true);
                player->KnockbackFrom(creature->GetPositionX(), creature->GetPositionY(), 30.0f, 18.0f);
                break;
        }

        return true;
    }
};

/*######
## avatar_of_freya
######*/

#define GOSSIP_ITEM_AOF1 "I want to stop the Scourge as much as you do. How can I help?"
#define GOSSIP_ITEM_AOF2 "You can trust me. I am no friend of the Lich King."
#define GOSSIP_ITEM_AOF3 "I will not fail."

enum Freya
{
    QUEST_FREYA_PACT         = 12621,

    SPELL_FREYA_CONVERSATION = 52045,

    GOSSIP_TEXTID_AVATAR1    = 13303,
    GOSSIP_TEXTID_AVATAR2    = 13304,
    GOSSIP_TEXTID_AVATAR3    = 13305
};

class npc_avatar_of_freya : public CreatureScript
{
public:
    npc_avatar_of_freya() : CreatureScript("npc_avatar_of_freya") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_FREYA_PACT) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        SendGossipMenuFor(player, GOSSIP_TEXTID_AVATAR1, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            SendGossipMenuFor(player, GOSSIP_TEXTID_AVATAR2, creature);
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            SendGossipMenuFor(player, GOSSIP_TEXTID_AVATAR3, creature);
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->CastSpell(player, SPELL_FREYA_CONVERSATION, true);
            CloseGossipMenuFor(player);
            break;
        }
        return true;
    }
};

/*######
## npc_bushwhacker
######*/

class npc_bushwhacker : public CreatureScript
{
public:
    npc_bushwhacker() : CreatureScript("npc_bushwhacker") { }

    struct npc_bushwhackerAI : public ScriptedAI
    {
        npc_bushwhackerAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void InitializeAI()
        {
            if (me->isDead())
                return;

            if (TempSummon* summ = me->ToTempSummon())
                if (Unit* summoner = summ->GetSummoner())
                    me->GetMotionMaster()->MovePoint(0, summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ());

            Reset();
        }

        void UpdateAI(uint32 /*uiDiff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bushwhackerAI(creature);
    }
};

/*######
## npc_engineer_helice
######*/

enum EngineerHelice
{
    // Spells
    SPELL_EXPLODE_CRYSTAL       = 62487,
    SPELL_FLAMES                = 64561,

    // Yells
    SAY_WP_1                    = 0,
    SAY_WP_2                    = 1,
    SAY_WP_3                    = 2,
    SAY_WP_4                    = 3,
    SAY_WP_5                    = 4,
    SAY_WP_6                    = 5,
    SAY_WP_7                    = 6,

    // Quests
    QUEST_DISASTER              = 12688
};

class npc_engineer_helice : public CreatureScript
{
public:
    npc_engineer_helice() : CreatureScript("npc_engineer_helice") { }

    struct npc_engineer_heliceAI : public npc_escortAI
    {
        npc_engineer_heliceAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 m_uiChatTimer;

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();

            switch (waypointId)
            {
                case 0:
                    Talk(SAY_WP_2);
                    break;
                case 1:
                    Talk(SAY_WP_3);
                    me->CastSpell(5918.33f, 5372.91f, -98.770f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5918.33f, 5372.91f, -98.770f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);     //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 2:
                    Talk(SAY_WP_4);
                    break;
                case 7:
                    Talk(SAY_WP_5);
                    break;
                case 8:
                    me->CastSpell(5887.37f, 5379.39f, -91.289f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5887.37f, 5379.39f, -91.289f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);      //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 9:
                    Talk(SAY_WP_6);
                    break;
                case 13:
                    if (player)
                    {
                        player->GroupEventHappens(QUEST_DISASTER, me);
                        Talk(SAY_WP_7);
                    }
                    break;
            }
        }

        void Reset()
        {
            m_uiChatTimer = 4000;
        }

        void JustDied(Unit* /*killer*/)
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (Player* player = GetPlayerForEscort())
                    player->FailQuest(QUEST_DISASTER);
            }
        }

        void UpdateAI(uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (m_uiChatTimer <= uiDiff)
                {
                    m_uiChatTimer = 12000;
                }
                else
                    m_uiChatTimer -= uiDiff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_engineer_heliceAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_DISASTER)
        {
            if (npc_engineer_heliceAI* pEscortAI = CAST_AI(npc_engineer_helice::npc_engineer_heliceAI, creature->AI()))
            {
                creature->GetMotionMaster()->MoveJumpTo(0, 0.4f, 0.4f);
                creature->setFaction(113);

                pEscortAI->Start(false, false, player->GetGUID());
                creature->AI()->Talk(SAY_WP_1);
            }
        }
        return true;
    }
};

/*#####
## npc_jungle_punch_target
#####*/

enum JunglePunch
{
    SAY_OFFER                           = 28558,
    ITEM_TANKARD                        = 2705,

    NPC_HEMET                           = 27986,
    NPC_HADRIUS                         = 28047,

    SPELL_KNOCKDOWN                     = 42963,
    SPELL_OFFER                         = 51962,
    QUEST_TASTE_TEST                    = 12645,

    SAY_HEMET_HADRIUS_TAMARA_1          = 0,
    SAY_HEMET_HADRIUS_TAMARA_2          = 1,
    SAY_HEMET_HADRIUS_TAMARA_3          = 2,

    SAY_HEMET_4                         = 3, // unused
    SAY_HEMET_5                         = 4  // unused
};

enum NesingwaryChildrensWeek
{
    SPELL_ORPHAN_OUT                    = 58818,

    QUEST_THE_MIGHTY_HEMET_NESINGWARY   = 13957,

    ORPHAN_WOLVAR                       = 33532,

    TEXT_NESINGWARY_1                   = 5,

    TEXT_WOLVAR_ORPHAN_6                = 6,
    TEXT_WOLVAR_ORPHAN_7                = 7,
    TEXT_WOLVAR_ORPHAN_8                = 8,
    TEXT_WOLVAR_ORPHAN_9                = 9
};

class npc_jungle_punch_target : public CreatureScript
{
public:
    npc_jungle_punch_target() : CreatureScript("npc_jungle_punch_target") { }

    struct npc_jungle_punch_targetAI : public ScriptedAI
    {
        npc_jungle_punch_targetAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset()
        {
            sayTimer = 3500;
            sayStep = 0;
            timer = 0;
            phase = 0;
            playerGUID = 0;
            orphanGUID = 0;
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!phase && who && who->GetDistance2d(me) < 10.0f)
                if (Player* player = who->ToPlayer())
                    if (player->GetQuestStatus(QUEST_THE_MIGHTY_HEMET_NESINGWARY) == QUEST_STATUS_INCOMPLETE)
                    {
                        playerGUID = player->GetGUID();
                        if (Aura* orphanOut = player->GetAura(SPELL_ORPHAN_OUT))
                            if (orphanOut->GetCaster() && orphanOut->GetCaster()->GetEntry() == ORPHAN_WOLVAR)
                            {
                                orphanGUID = orphanOut->GetCaster()->GetGUID();
                                phase = 1;
                            }
                    }
        }

        void proceedCwEvent(const uint32 diff)
        {
            if (timer <= diff)
            {
                Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
                Creature* orphan = ObjectAccessor::GetCreature(*me, orphanGUID);

                if (!orphan || !player)
                {
                    Reset();
                    return;
                }

                switch (phase)
                {
                    case 1:
                        orphan->GetMotionMaster()->MovePoint(0, me->GetPositionX() + cos(me->GetOrientation()) * 5, me->GetPositionY() + sin(me->GetOrientation()) * 5, me->GetPositionZ());
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_6);
                        timer = 5000;
                        break;
                    case 2:
                        orphan->SetFacingToObject(me);
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_7);
                        timer = 5000;
                        break;
                    case 3:
                        Talk(TEXT_NESINGWARY_1);
                        timer = 5000;
                        break;
                    case 4:
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_8);
                        timer = 5000;
                        break;
                    case 5:
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_9);
                        timer = 5000;
                        break;
                    case 6:
                        orphan->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                        player->GroupEventHappens(QUEST_THE_MIGHTY_HEMET_NESINGWARY, me);
                        Reset();
                        return;
                }
                ++phase;
            }
            else
                timer -= diff;
        }

        void UpdateAI(uint32 diff)
        {
            if (phase)
                proceedCwEvent(diff);

            if (!sayStep)
                return;

            if (sayTimer < diff)
            {
                if (sayStep == 2)
                {
                    me->SetSheath(SHEATH_STATE_MELEE);
                    SetEquipmentSlots(false, ITEM_TANKARD, EQUIP_UNEQUIP, EQUIP_UNEQUIP);
                }
                else if (sayStep == 3)
                {
                    if (me->GetEntry() == NPC_HEMET)
                        me->SetSheath(SHEATH_STATE_RANGED);
                    else if (me->GetEntry() == NPC_HADRIUS)
                    {
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->CastSpell(me,SPELL_KNOCKDOWN,false);
                    }
                    SetEquipmentSlots(true);
                }

                Talk(SAY_HEMET_HADRIUS_TAMARA_1 + sayStep - 1);
                sayTimer = 6000;
                sayStep++;

                if (sayStep > 3) // end
                    sayStep = 0;
            }
            else
                sayTimer -= diff;
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo)
        {
            if (spellInfo->Id != SPELL_OFFER)
                return;

            Player* player = caster->ToPlayer();
            if (!player)
                return;

            Quest const* quest = sObjectMgr->GetQuestTemplate(QUEST_TASTE_TEST);
            if (!quest)
                return;

            QuestStatusMap::const_iterator itr = player->getQuestStatusMap().find(QUEST_TASTE_TEST);
            if (itr->second.Status != QUEST_STATUS_INCOMPLETE)
                return;

            for (uint8 i = 0; i < 3; ++i)
            {
                if (uint32(quest->RequiredNpcOrGo[i]) != me->GetEntry())
                    continue;

                if (itr->second.CreatureOrGOCount[i] != 0)
                    continue;

                player->KilledMonsterCredit(me->GetEntry(), 0);
                player->MonsterSay(SAY_OFFER, LANG_UNIVERSAL, me);
                sayStep = 1;
                break;
            }
        }

        private:
            uint16 sayTimer;
            uint8 sayStep;
            uint32 timer;
            int8 phase;
            uint64 playerGUID;
            uint64 orphanGUID;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_jungle_punch_targetAI(creature);
    }
};

/*######
## npc_adventurous_dwarf
######*/

#define GOSSIP_OPTION_ORANGE    "Can you spare an orange?"
#define GOSSIP_OPTION_BANANAS   "Have a spare bunch of bananas?"
#define GOSSIP_OPTION_PAPAYA    "I could really use a papaya."

enum AdventurousDwarf
{
    QUEST_12634         = 12634,

    ITEM_BANANAS        = 38653,
    ITEM_PAPAYA         = 38655,
    ITEM_ORANGE         = 38656,

    SPELL_ADD_ORANGE    = 52073,
    SPELL_ADD_BANANAS   = 52074,
    SPELL_ADD_PAPAYA    = 52076,

    GOSSIP_MENU_DWARF   = 13307,

    SAY_DWARF_OUCH      = 0,
    SAY_DWARF_HELP      = 1
};

class npc_adventurous_dwarf : public CreatureScript
{
public:
    npc_adventurous_dwarf() : CreatureScript("npc_adventurous_dwarf") { }

    struct npc_adventurous_dwarfAI : public ScriptedAI
    {
        npc_adventurous_dwarfAI(Creature* creature) : ScriptedAI(creature)
        {
            Talk(SAY_DWARF_OUCH);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_adventurous_dwarfAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_12634) != QUEST_STATUS_INCOMPLETE)
            return false;

        if (player->GetItemCount(ITEM_ORANGE) < 1)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_OPTION_ORANGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        if (player->GetItemCount(ITEM_BANANAS) < 2)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_OPTION_BANANAS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        if (player->GetItemCount(ITEM_PAPAYA) < 1)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_OPTION_PAPAYA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

        SendGossipMenuFor(player, GOSSIP_MENU_DWARF, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        uint32 spellId = 0;

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                spellId = SPELL_ADD_ORANGE;
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                spellId = SPELL_ADD_BANANAS;
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                spellId = SPELL_ADD_PAPAYA;
                break;
        }

        if (spellId)
            player->CastSpell(player, spellId, true);

        creature->AI()->Talk(SAY_DWARF_HELP);
        creature->DespawnOrUnsummon();
        return true;
    }
};

/*######
## Quest The Lifewarden's Wrath
######*/

enum MiscLifewarden
{
    NPC_PRESENCE = 28563, // Freya's Presence
    NPC_SABOTEUR = 28538, // Cultist Saboteur
    NPC_SERVANT = 28320, // Servant of Freya

    WHISPER_ACTIVATE = 0,

    SPELL_FREYA_DUMMY = 51318,
    SPELL_LIFEFORCE = 51395,
    SPELL_FREYA_DUMMY_TRIGGER = 51335,
    SPELL_LASHER_EMERGE = 48195,
    SPELL_WILD_GROWTH = 52948,
};

class spell_q12620_the_lifewarden_wrath : public SpellScriptLoader
{
public:
    spell_q12620_the_lifewarden_wrath() : SpellScriptLoader("spell_q12620_the_lifewarden_wrath") { }

    class spell_q12620_the_lifewarden_wrath_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12620_the_lifewarden_wrath_SpellScript);

        void HandleSendEvent(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);

            if (Unit* caster = GetCaster())
            {
                if (Creature* presence = caster->FindNearestCreature(NPC_PRESENCE, 50.0f))
                {
                    presence->AI()->Talk(WHISPER_ACTIVATE, caster);
                    presence->CastSpell(presence, SPELL_FREYA_DUMMY, true); // will target plants
                    // Freya Dummy could be scripted with the following code

                    // Revive plants
                    std::list<Creature*> servants;
                    GetCaster()->GetCreatureListWithEntryInGrid(servants, NPC_SERVANT, 200.0f);
                    for (std::list<Creature*>::iterator itr = servants.begin(); itr != servants.end(); ++itr)
                    {
                        // Couldn't find a spell that does this
                        if ((*itr)->isDead())
                            (*itr)->Respawn(true);

                        (*itr)->CastSpell(*itr, SPELL_FREYA_DUMMY_TRIGGER, true);
                        (*itr)->CastSpell(*itr, SPELL_LASHER_EMERGE, false);
                        (*itr)->CastSpell(*itr, SPELL_WILD_GROWTH, false);

                        if (Unit* target = (*itr)->SelectNearestTarget(150.0f))
                            (*itr)->AI()->AttackStart(target);
                    }

                    // Kill nearby enemies
                    std::list<Creature*> saboteurs;
                    caster->GetCreatureListWithEntryInGrid(saboteurs, NPC_SABOTEUR, 200.0f);
                    for (std::list<Creature*>::iterator itr = saboteurs.begin(); itr != saboteurs.end(); ++itr)
                        if ((*itr)->IsAlive())
                            // Lifeforce has a cast duration, it should be cast at all saboteurs one by one
                            presence->CastSpell((*itr), SPELL_LIFEFORCE, false);
                }
            }
        }

        void Register()
        {
            OnEffectHit += SpellEffectFn(spell_q12620_the_lifewarden_wrath_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12620_the_lifewarden_wrath_SpellScript();
    }
};

/*######
## Quest Kick, What Kick? (12589)
######*/

enum KickWhatKick
{
    NPC_LUCKY_WILHELM = 28054,
    NPC_APPLE = 28053,
    NPC_DROSTAN = 28328,
    NPC_CRUNCHY = 28346,
    NPC_THICKBIRD = 28093,

    SPELL_HIT_APPLE = 51331,
    SPELL_MISS_APPLE = 51332,
    SPELL_MISS_BIRD_APPLE = 51366,
    SPELL_APPLE_FALL = 51371,
    SPELL_BIRD_FALL = 51369,

    EVENT_MISS = 0,
    EVENT_HIT = 1,
    EVENT_MISS_BIRD = 2,

    SAY_WILHELM_MISS = 0,
    SAY_WILHELM_HIT = 1,
    SAY_DROSTAN_REPLY_MISS = 0,
};

class spell_q12589_shoot_rjr : public SpellScriptLoader
{
public:
    spell_q12589_shoot_rjr() : SpellScriptLoader("spell_q12589_shoot_rjr") { }

    class spell_q12589_shoot_rjr_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12589_shoot_rjr_SpellScript);

        SpellCastResult CheckCast()
        {
            if (Unit* target = GetExplTargetUnit())
                if (target->GetEntry() == NPC_LUCKY_WILHELM)
                    return SPELL_CAST_OK;

            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_TARGET_WILHELM);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            uint32 roll = urand(1, 100);

            uint8 ev;
            if (roll <= 50)
                ev = EVENT_MISS;
            else if (roll <= 83)
                ev = EVENT_HIT;
            else
                ev = EVENT_MISS_BIRD;

            Unit* shooter = GetCaster();
            Creature* wilhelm = GetHitUnit()->ToCreature();
            Creature* apple = shooter->FindNearestCreature(NPC_APPLE, 30);
            Creature* drostan = shooter->FindNearestCreature(NPC_DROSTAN, 30);

            if (!wilhelm || !apple || !drostan)
                return;

            switch (ev)
            {
                case EVENT_MISS_BIRD:
                {
                    Creature* crunchy = shooter->FindNearestCreature(NPC_CRUNCHY, 30);
                    Creature* bird = shooter->FindNearestCreature(NPC_THICKBIRD, 30);

                    if (!bird || !crunchy)
                        ; // fall to EVENT_MISS
                    else
                    {
                        shooter->CastSpell(bird, SPELL_MISS_BIRD_APPLE);
                        bird->CastSpell(bird, SPELL_BIRD_FALL);
                        wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                        drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);

                        Unit::Kill(bird, bird);
                        crunchy->GetMotionMaster()->MovePoint(0, bird->GetPositionX(), bird->GetPositionY(),
                            bird->GetMap()->GetWaterOrGroundLevel(bird->GetPhaseMask(), bird->GetPositionX(), bird->GetPositionY(), bird->GetPositionZ()));
                        /// @todo Make crunchy perform emote eat when he reaches the bird

                        break;
                    }
                }
                case EVENT_MISS:
                {
                    shooter->CastSpell(wilhelm, SPELL_MISS_APPLE);
                    wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                    drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);
                    break;
                }
                case EVENT_HIT:
                {
                    shooter->CastSpell(apple, SPELL_HIT_APPLE);
                    apple->CastSpell(apple, SPELL_APPLE_FALL);
                    wilhelm->AI()->Talk(SAY_WILHELM_HIT);
                    if (Player* player = shooter->ToPlayer())
                        player->KilledMonsterCredit(NPC_APPLE, 0);
                    //apple->DespawnOrUnsummon(); zomg!

                    break;
                }
            }
        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_q12589_shoot_rjr_SpellScript::CheckCast);
            OnEffectHitTarget += SpellEffectFn(spell_q12589_shoot_rjr_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12589_shoot_rjr_SpellScript();
    }
};

/*######
## Quest: Reconnaissance Flight (12671)
######*/
enum ReconnaissanceFlight
{
    NPC_PLANE       = 28710, // Vic's Flying Machine
    NPC_PILOT       = 28646,

    VIC_SAY_0       = 0,
    VIC_SAY_1       = 1,
    VIC_SAY_2       = 2,
    VIC_SAY_3       = 3,
    VIC_SAY_4       = 4,
    VIC_SAY_5       = 5,
    VIC_SAY_6       = 6,
    PLANE_EMOTE     = 0,

    AURA_ENGINE     = 52255, // Engine on Fire

    SPELL_LAND      = 52226, // Land Flying Machine
    SPELL_CREDIT    = 53328 // Land Flying Machine Credit
};

class npc_vics_flying_machine : public CreatureScript
{
public:
    npc_vics_flying_machine() : CreatureScript("npc_vics_flying_machine") { }

    struct npc_vics_flying_machineAI : public VehicleAI
    {
        npc_vics_flying_machineAI(Creature* creature) : VehicleAI(creature)
        {
            pointId = 0;
        }

        uint8 pointId;

        void PassengerBoarded(Unit* passenger, int8 /*seatId*/, bool apply)
        {
            if (apply && passenger->GetTypeId() == TYPEID_PLAYER)
            {
                Movement::PointsArray pathPoints;
                pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));

                WaypointPath const* i_path = sWaypointMgr->GetPath(NPC_PLANE);
                for (uint8 i = 0; i < i_path->size(); ++i)
                {
                    WaypointData const* node = i_path->at(i);
                    pathPoints.push_back(G3D::Vector3(node->x, node->y, node->z));
                }

                me->GetMotionMaster()->MoveSplinePath(&pathPoints);
            }
        }

        void MovementInform(uint32 type, uint32  /*id*/)
        {
            if (type != ESCORT_MOTION_TYPE)
                return;

            if (Vehicle* veh = me->GetVehicleKit())
                if (Unit* pilot = veh->GetPassenger(0))
                switch (pointId)
                {
                    case 5:
                        pilot->ToCreature()->AI()->Talk(VIC_SAY_0);
                        break;
                    case 11:
                        pilot->ToCreature()->AI()->Talk(VIC_SAY_1);
                        break;
                    case 12:
                        pilot->ToCreature()->AI()->Talk(VIC_SAY_2);
                        break;
                    case 14:
                        pilot->ToCreature()->AI()->Talk(VIC_SAY_3);
                        break;
                    case 15:
                        pilot->ToCreature()->ToCreature()->AI()->Talk(VIC_SAY_4);
                        break;
                    case 17:
                        pilot->ToCreature()->AI()->Talk(VIC_SAY_5);
                        break;
                    case 21:
                        pilot->ToCreature()->AI()->Talk(VIC_SAY_6);
                        break;
                    case 25:
                        Talk(PLANE_EMOTE);
                        DoCast(AURA_ENGINE);
                        me->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FORCE_MOVEMENT);
                        break;
                }
            pointId++;
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_LAND)
            {
                Unit* passenger = me->GetVehicleKit()->GetPassenger(1); // player should be on seat 1
                if (passenger && passenger->GetTypeId() == TYPEID_PLAYER)
                    passenger->CastSpell(passenger, SPELL_CREDIT, true);

                me->DespawnOrUnsummon();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_vics_flying_machineAI(creature);
    }
};

/*######
## Quest Dreadsaber Mastery: Stalking the Prey (12550)
######*/

enum ShangoTracks
{
    SPELL_CORRECT_TRACKS   = 52160,
    SPELL_INCORRECT_TRACKS = 52163,
    SAY_CORRECT_TRACKS     = 28634,
    SAY_INCORRECT_TRACKS   = 28635
};

class spell_shango_tracks : public SpellScriptLoader
{
public:
   spell_shango_tracks() : SpellScriptLoader("spell_shango_tracks") { }

    class spell_shango_tracks_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_shango_tracks_SpellScript);

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            if (Player* player = GetHitUnit()->ToPlayer())
            {
                switch (GetSpellInfo()->Id)
                {
                    case SPELL_CORRECT_TRACKS:
                        player->MonsterSay(sObjectMgr->GetAcoreStringForDBCLocale(SAY_CORRECT_TRACKS), LANG_UNIVERSAL, player);
                        break;
                    case SPELL_INCORRECT_TRACKS:
                        player->MonsterSay(sObjectMgr->GetAcoreStringForDBCLocale(SAY_INCORRECT_TRACKS), LANG_UNIVERSAL, player);
                        break;
                    default:
                        break;
                }
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_shango_tracks_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_shango_tracks_SpellScript();
    }
};

void AddSC_sholazar_basin()
{
    // Ours
    new spell_q12726_song_of_wind_and_water();
    new npc_artruis_the_hearthless();
    new npc_still_at_it_trigger();
    new npc_mcmanus();
    new go_pressure_valve();
    new go_brazier();

    // Theirs
    new npc_vekjik();
    new npc_avatar_of_freya();
    new npc_bushwhacker();
    new npc_engineer_helice();
    new npc_adventurous_dwarf();
    new npc_jungle_punch_target();
    new spell_q12620_the_lifewarden_wrath();
    new spell_q12589_shoot_rjr();
    new npc_vics_flying_machine();
    new spell_shango_tracks();
}
