/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Dragonblight
SD%Complete: 100
SDComment:
SDCategory: Dragonblight
EndScriptData */

/* ContentData
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "Player.h"
#include "Vehicle.h"
#include "CreatureTextMgr.h"
#include "PassiveAI.h"
#include "CombatAI.h"
#include "SpellAuras.h"
#include "Chat.h"
#include "CellImpl.h"

// Ours
/********
QUEST Conversing With the Depths (12032)
********/
#define QUEST_CONVERSING_WITH_THE_DEPTHS 12032
#define DEEPDIVING_PEARL_BUFF 41273
#define NPC_OACHANOA 26648
#define NPC_CONVERSING_WITH_THE_DEPTHS_TRIGGER 70100
#define OACHANOA_T_1_1 "Little "
#define OACHANOA_T_1_2 ", why do you call me forth? Are you working with the trolls of this land? Have you come to kill me and take my power as your own?"
#define OACHANOA_T_2 "I sense uncertainty in you, and I do not trust it whether you are with them, or not. If you wish my augury for the Kalu'ak, you will have to prove yourself first."
#define OACHANOA_T_3 "I will lay a mild compulsion upon you. Jump into the depths before me so that you put yourself into my element and thereby display your submission."
#define OACHANOA_T_4_1 "Well done, "
#define OACHANOA_T_4_2 ". Your display of respect is duly noted. Now, I have information for you that you must convey to the Kalu'ak."
#define OACHANOA_T_5 "Simply put, you must tell the tuskarr that they cannot run. If they do so, their spirits will be destroyed by the evil rising within Northrend."
#define OACHANOA_T_6 "Tell the mystic that his people are to stand and fight alongside the Horde and Alliance against the forces of Malygos and the Lich King."
#define OACHANOA_T_7_1 "Now swim back with the knowledge I have granted you. Do what you can for them "

class npc_conversing_with_the_depths_trigger : public CreatureScript
{
public:
    npc_conversing_with_the_depths_trigger() : CreatureScript("npc_conversing_with_the_depths_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_conversing_with_the_depths_triggerAI (pCreature);
    }

    struct npc_conversing_with_the_depths_triggerAI : public ScriptedAI
    {
        npc_conversing_with_the_depths_triggerAI(Creature* c) : ScriptedAI(c) { }

        bool running;
        bool secondpart;
        int32 timer;
        uint8 step;
        uint64 pGUID;
        uint64 oachanoaGUID;

        void Reset()
        {
            running = false;
            secondpart = false;
            timer = 0;
            step = 0;
            pGUID = 0;
            oachanoaGUID = 0;
        }

        void NextStep(const uint32 time)
        {
            step++;
            timer = time;
        }

        void Say(std::string text, bool yell)
        {
            Creature* c = ObjectAccessor::GetCreature(*me, oachanoaGUID);
            Player* player = ObjectAccessor::GetPlayer(*me, pGUID);
            if (!c || !player)
            {
                Reset();
                return;
            }

            if (yell)
                c->MonsterYell(text.c_str(), LANG_UNIVERSAL, player);
            else
                c->MonsterWhisper(text.c_str(), player, false);
        }

        void DespawnOachanoa()
        {
            if (Creature* c = ObjectAccessor::GetCreature(*me, oachanoaGUID))
                c->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 diff)
        {
            if( running )
            {
                if( Player* p = ObjectAccessor::GetPlayer(*me, pGUID) )
                    if( p->GetPositionZ() < 1.0f && !secondpart )
                    {
                        if( p->HasAura(DEEPDIVING_PEARL_BUFF) )
                        {
                            NextStep(500);
                            secondpart = true;
                        }
                        else
                        {
                            DespawnOachanoa();
                            Reset();
                        }
                    }

                if( timer != 0 )
                {
                    timer -= diff;
                    if( timer < 0 )
                        timer = 0;
                }
                else
                    switch( step )
                    {
                        case 0:
                            NextStep(10000);
                            break;
                        case 1:
                        {
                            Creature* c = me->SummonCreature(NPC_OACHANOA, 2406.24f, 1701.98f, 0.1f, 0.3f, TEMPSUMMON_TIMED_DESPAWN, 90000, 0);
                            if( !c )
                            {
                                Reset();
                                return;
                            }
                            c->SetCanFly(true);
                            c->GetMotionMaster()->MovePoint(0, 2406.25f, 1701.98f, 0.1f);
                            oachanoaGUID = c->GetGUID();
                            NextStep(3000);
                            break;
                        }
                        case 2:
                        {
                            Player* p = ObjectAccessor::GetPlayer(*me, pGUID);
                            if( !p )
                            {
                                Reset();
                                return;
                            }
                            std::string text = (OACHANOA_T_1_1 + p->GetName() + OACHANOA_T_1_2);
                            Say(text, true);
                            NextStep(6000);
                            break;
                        }
                        case 3:
                            Say(OACHANOA_T_2, true);
                            NextStep(6000);
                            break;
                        case 4:
                        {
                            Say(OACHANOA_T_3, true);
                            Player* p = ObjectAccessor::GetPlayer(*me, pGUID);
                            if( !p )
                            {
                                Reset();
                                return;
                            }
                            p->CastSpell(p, DEEPDIVING_PEARL_BUFF, true);
                            NextStep(30000);
                            break;
                        }
                        case 5:
                            DespawnOachanoa();
                            Reset();
                            break;
                        case 6:
                        {
                            Player* p = ObjectAccessor::GetPlayer(*me, pGUID);
                            if( !p )
                            {
                                Reset();
                                return;
                            }

                            std::string text = (OACHANOA_T_4_1 + p->GetName() + OACHANOA_T_4_2);
                            Say(text, true);

                            NextStep(6000);
                            break;
                        }
                        case 7:
                            Say(OACHANOA_T_5, false);
                            NextStep(6000);
                            break;
                        case 8:
                            Say(OACHANOA_T_6, false);
                            NextStep(6000);
                            break;
                        case 9:
                        {
                            Player* p = ObjectAccessor::GetPlayer(*me, pGUID);
                            if( !p )
                            {
                                Reset();
                                return;
                            }
                            const char * name_races[RACE_DRAENEI] = {"human", "orc", "dwarf", "nightelf", "undead", "tauren", "gnome", "troll", "", "bloodelf", "draenei"};
                            if( p->getRace() > 11 )
                            {
                                Reset();
                                return;
                            }

                            std::string text = (OACHANOA_T_7_1 + std::string(name_races[p->getRace()-1]));
                            Say(text, true);

                            p->AreaExploredOrEventHappens(12032);

                            DespawnOachanoa();
                            Reset();
                        }
                    }
            }
        }

        void Start(uint64 g)
        {
            running = true;
            pGUID = g;
        }
    };
};

class go_the_pearl_of_the_depths : public GameObjectScript
{
public:
    go_the_pearl_of_the_depths() : GameObjectScript("go_the_pearl_of_the_depths") { }

    bool OnGossipHello(Player* pPlayer, GameObject* pGo)
    {
        if( !pPlayer || !pGo )
            return true;

        Creature* t = pPlayer->FindNearestCreature(NPC_CONVERSING_WITH_THE_DEPTHS_TRIGGER, 10.0f, true);
        if( t && t->AI() && CAST_AI(npc_conversing_with_the_depths_trigger::npc_conversing_with_the_depths_triggerAI, t->AI()) )
            if( !CAST_AI(npc_conversing_with_the_depths_trigger::npc_conversing_with_the_depths_triggerAI, t->AI())->running )
                CAST_AI(npc_conversing_with_the_depths_trigger::npc_conversing_with_the_depths_triggerAI, t->AI())->Start(pPlayer->GetGUID());

        return true;
    }
};


enum hourglass
{
    NPC_FUTURE_HOURGLASS            = 27840,
    NPC_FUTURE_YOU                  = 27899,

    NPC_PAST_HOURGLASS              = 32327,
    NPC_PAST_YOU                    = 32331,

    NPC_INFINITE_ASSAILANT          = 27896,
    NPC_INFINITE_CHRONO_MAGUS       = 27898,
    NPC_INFINITE_DESTROYER          = 27897,
    NPC_INFINITE_TIMERENDER         = 27900,

    SPELL_CLONE_CASTER              = 49889,
    SPELL_TELEPORT_EFFECT           = 52096,

    EVENT_START_EVENT               = 1,
    EVENT_FIGHT_1                   = 2,
    EVENT_FIGHT_2                   = 3,
    EVENT_CHECK_FINISH              = 4,
    EVENT_FINISH_EVENT              = 5,

    QUEST_MYSTERY_OF_THE_INFINITE   = 12470,
    QUEST_MYSTERY_OF_THE_INFINITE_REDUX = 13343,
};

class npc_hourglass_of_eternity : public CreatureScript
{
public:
    npc_hourglass_of_eternity() : CreatureScript("npc_hourglass_of_eternity") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_hourglass_of_eternityAI (pCreature);
    }

    struct npc_hourglass_of_eternityAI : public ScriptedAI
    {
        npc_hourglass_of_eternityAI(Creature* c) : ScriptedAI(c) {}

        uint64 summonerGUID;
        uint64 futureGUID;
        EventMap events;
        uint8 count[3];
        uint8 phase;

        bool IsFuture() { return me->GetEntry() == NPC_FUTURE_HOURGLASS; }
        void InitializeAI()
        {
            if (me->ToTempSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                {
                    summonerGUID = summoner->GetGUID();
                    float x,y,z;
                    me->GetNearPoint(summoner, x, y, z, me->GetCombatReach(), 0.0f, rand_norm()*2*M_PI);
                    if (Creature* cr = summoner->SummonCreature((IsFuture() ? NPC_FUTURE_YOU : NPC_PAST_YOU), x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 210000))
                    {
                        futureGUID = cr->GetGUID();
                        summoner->CastSpell(cr, SPELL_CLONE_CASTER, true);
                        cr->setFaction(summoner->getFaction());
                        cr->SetReactState(REACT_AGGRESSIVE);
                    }
                }

            count[0] = 2;
            count[1] = 2;
            count[2] = 3;

            phase = 0;
            events.Reset();
            events.ScheduleEvent(EVENT_START_EVENT, 4000);
        }

        Player* getSummoner() { return ObjectAccessor::GetPlayer(*me, summonerGUID); }
        Creature* getFuture() { return ObjectAccessor::GetCreature(*me, futureGUID); }


        uint32 randEntry()
        {
            return NPC_INFINITE_ASSAILANT+urand(0,2);
        }
        
        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_START_EVENT:
                    if (Creature* cr = getFuture())
                        cr->MonsterWhisper(IsFuture() ? "Hey there, $N, don't be alarmed. It's me... you... from the future. I'm here to help." : "Whoa! You're me, but from the future! Hey, my equipment got an upgrade! Cool!", getSummoner());
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_FIGHT_1, 7000);
                    break;
                case EVENT_FIGHT_1:
                    if (Creature* cr = getFuture())
                        cr->MonsterWhisper(IsFuture() ? "Heads up... here they come. I'll help as much as I can. Let's just keep them off the hourglass!" : "Here come the Infinites! I've got to keep the hourglass safe. Can you help?", getSummoner());
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_FIGHT_2, 6000);
                    break;
                case EVENT_FIGHT_2:
                {
                    if (phase)
                        randomWhisper();

                    Creature* cr = NULL;
                    float x, y, z;
                    if (phase < 3)
                    {
                        for (uint8 i = 0; i < count[phase]; ++i)
                        {
                            me->GetNearPoint(me, x, y, z, me->GetCombatReach(), 10.0f, rand_norm()*2*M_PI);
                            if ((cr = me->SummonCreature(randEntry(), x, y, z+2.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                            {
                                cr->CastSpell(cr, SPELL_TELEPORT_EFFECT, true);
                                cr->AI()->AttackStart(me);
                                cr->AddThreat(me, 100.0f);
                            }
                        }
                    }
                    else if (phase == 3)
                    {
                        me->GetNearPoint(me, x, y, z, me->GetCombatReach(), 20.0f, rand_norm()*2*M_PI);
                        if ((cr = me->SummonCreature(NPC_INFINITE_TIMERENDER, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                        {
                            cr->CastSpell(cr, SPELL_TELEPORT_EFFECT, true);
                            cr->AI()->AttackStart(me);
                        }

                        events.PopEvent();
                        events.ScheduleEvent(EVENT_CHECK_FINISH, 20000);
                        return;
                    }

                    phase++;
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_FIGHT_2, 35000);
                    break;
                }
                case EVENT_CHECK_FINISH:
                {
                    if (me->FindNearestCreature(NPC_INFINITE_TIMERENDER, 50.0f))
                    {
                        events.RepeatEvent(5000);
                        return;
                    }

                    if (Player* player = getSummoner())
                        player->GroupEventHappens(IsFuture() ? QUEST_MYSTERY_OF_THE_INFINITE : QUEST_MYSTERY_OF_THE_INFINITE_REDUX, me);

                    me->MonsterWhisper(IsFuture() ? "Look, $N, the hourglass has revealed Nozdormu!" : "What the heck? Nozdormu is up there!", getSummoner());
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_FINISH_EVENT, 6000);
                    break;
                }
                case EVENT_FINISH_EVENT:
                {
                    me->MonsterWhisper(IsFuture() ? "Farewell, $N. Keep us alive and get some better equipment!" : "I feel like I'm being pulled away through time. Thanks for the help....", getSummoner());
                    events.PopEvent();
                    me->DespawnOrUnsummon(500);
                    if (getFuture())
                        getFuture()->DespawnOrUnsummon(500);
                    break;
                }
            }
        }

        void randomWhisper()
        {
            std::string text = "";
            switch(urand(0, IsFuture() ? 7 : 5))
            {
                case 0: text = IsFuture() ? "What? Am I here alone. We both have a stake at this, you know!" : "This equipment looks cool and all, but couldn't we have done a little better? Are you even raiding?"; break;
                case 1: text = IsFuture() ? "No matter what, you can't die, because would mean that I would cease to exist, right? But, I was here before when I was you. I'm so confused!" : "Chromie said that if I don't do this just right, I might wink out of existence. If I go, then you go!"; break;
                case 2: text = IsFuture() ? "Sorry, but Chromie said that I couldn't reveal anything about your future to you. She said that if I did, I would cease to exist." : "I just want you to know that if we get through this alive, I'm making sure that we turn out better than you. No offense."; break;
                case 3: text = IsFuture() ? "Look at you fight; no wonder I turned to drinking." : "Looks like I'm an underachiever."; break;
                case 4: text = IsFuture() ? "Wow, I'd forgotten how inexperienced I used to be." : "Wait a minute! If you're here, then that means that in the not-so-distant future I'm going to be you helping me? Are we stuck in a time loop?!"; break;
                case 5: text = IsFuture() ? "I can't believe that I used to wear that." : "I think I'm going to turn to drinking after this."; break;
                case 6: text = "Listen. I'm not supposed to tell you this, but there's going to be this party that you're invited to. Whatever you do, DO NOT DRINK THE PUNCH!"; break;
                case 7: text = "Wish I could remember how many of the Infinite Dragonflight were going to try to stop you. This fight was so long ago."; break;
            }

            if (Creature* cr = getFuture())
                cr->MonsterWhisper(text.c_str(), getSummoner());
        }
    };
};

class npc_future_you : public CreatureScript
{
public:
    npc_future_you() : CreatureScript("npc_future_you") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_future_youAI (pCreature);
    }

    struct npc_future_youAI : public ScriptedAI
    {
        npc_future_youAI(Creature* c) : ScriptedAI(c) {}
        
        void EnterEvadeMode() 
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
            me->ClearUnitState(UNIT_STATE_EVADE);
        }

        void Reset() 
        { 
            if (me->ToTempSummon() && me->ToTempSummon()->GetSummoner())
                me->setFaction(me->ToTempSummon()->GetSummoner()->getFaction());
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!me->GetVictim() && who->GetEntry() >= NPC_INFINITE_ASSAILANT && who->GetEntry() <= NPC_INFINITE_TIMERENDER)
                AttackStart(who);
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

enum chainGun
{
    NPC_INJURED_7TH_LEGION_SOLDER               = 27788,
    SPELL_FEAR_AURA_WITH_COWER                  = 49774
};

class npc_mindless_ghoul : public CreatureScript
{
public:
    npc_mindless_ghoul() : CreatureScript("npc_mindless_ghoul") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_mindless_ghoulAI (pCreature);
    }

    struct npc_mindless_ghoulAI : public ScriptedAI
    {
        npc_mindless_ghoulAI(Creature* c) : ScriptedAI(c)
        {
            me->SetCorpseDelay(1);
        }

        bool CanAIAttack(const Unit* who) const
        {
            return who->GetEntry() == NPC_INJURED_7TH_LEGION_SOLDER;
        }

        void JustDied(Unit*)
        {
            me->SetCorpseDelay(1);
        }
    };
};

class npc_injured_7th_legion_soldier : public CreatureScript
{
public:
    npc_injured_7th_legion_soldier() : CreatureScript("npc_injured_7th_legion_soldier") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_injured_7th_legion_soldierAI (pCreature);
    }

    struct npc_injured_7th_legion_soldierAI : public NullCreatureAI
    {
        npc_injured_7th_legion_soldierAI(Creature* c) : NullCreatureAI(c) {}

        void Reset()
        {
            me->CastSpell(me, SPELL_FEAR_AURA_WITH_COWER, true);
            me->SetWalk(false);
            uint32 path = me->GetEntry()*10+urand(0,4);
            if (me->GetPositionY() > -1150.0f)
                path += 5;
            me->GetMotionMaster()->MovePath(path, false);
        }

        void MovementInform(uint32 type, uint32 point)
        {
            if (type != WAYPOINT_MOTION_TYPE)
                return;

            if (point == 8) // max-1
            {
                Talk(0);
                me->RemoveAllAuras();
                me->DespawnOrUnsummon(1000);
                if (TempSummon* summon = me->ToTempSummon())
                    if (Unit* owner = summon->GetSummoner())
                        if (Player* player = owner->ToPlayer())
                            player->KilledMonsterCredit(me->GetEntry(), 0);
            }
        }
    };
};

class npc_heated_battle : public CreatureScript
{
public:
    npc_heated_battle() : CreatureScript("npc_heated_battle") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_heated_battleAI (pCreature);
    }

    struct npc_heated_battleAI : public CombatAI
    {
        npc_heated_battleAI(Creature* c) : CombatAI(c) {}

        void Reset()
        {
            me->SetCorpseDelay(60);
            CombatAI::Reset();
            if (Unit* target = me->SelectNearestTarget(50.0f))
                AttackStart(target);
        }

        void DamageTaken(Unit* who, uint32&, DamageEffectType, SpellSchoolMask)
        {
            if (who && who->GetTypeId() == TYPEID_PLAYER)
            {
                me->SetLootRecipient(who);
                me->LowerPlayerDamageReq(me->GetMaxHealth());
            }
        }
    };
};

enum eFrostmourneCavern
{
    NPC_PRINCE_ARTHAS               = 27455,
};

class spell_q12478_frostmourne_cavern : public SpellScriptLoader
{
public:
    spell_q12478_frostmourne_cavern() : SpellScriptLoader("spell_q12478_frostmourne_cavern") { }

    class spell_q12478_frostmourne_cavern_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12478_frostmourne_cavern_SpellScript);

        void HandleSendEvent(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->SummonCreature(NPC_PRINCE_ARTHAS, 4821.3f ,-580.14f, 163.541f, 4.57f);
        }

        void Register()
        {
            OnEffectHit += SpellEffectFn(spell_q12478_frostmourne_cavern_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12478_frostmourne_cavern_SpellScript();
    }
};

class spell_q12243_fire_upon_the_waters : public SpellScriptLoader
{
    public:
        spell_q12243_fire_upon_the_waters() : SpellScriptLoader("spell_q12243_fire_upon_the_waters") { }

        class spell_q12243_fire_upon_the_waters_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q12243_fire_upon_the_waters_AuraScript);

            void HandleApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                std::list<Creature*> servants;
                GetTarget()->GetCreatureListWithEntryInGrid(servants, 27233 /*NPC_ONSLAUGHT_DECKHAND*/, 40.0f);
                for (std::list<Creature*>::const_iterator itr = servants.begin(); itr != servants.end(); ++itr)
                {
                    (*itr)->SetSpeed(MOVE_RUN, 0.7f, true);
                    (*itr)->GetMotionMaster()->MoveFleeing(GetTarget(), GetDuration());
                }
            }

            void HandleRemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                std::list<Creature*> servants;
                GetTarget()->GetCreatureListWithEntryInGrid(servants, 27233 /*NPC_ONSLAUGHT_DECKHAND*/, 100.0f);
                for (std::list<Creature*>::const_iterator itr = servants.begin(); itr != servants.end(); ++itr)
                    (*itr)->SetSpeed(MOVE_RUN, 1.1f, true);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_q12243_fire_upon_the_waters_AuraScript::HandleApplyEffect, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_q12243_fire_upon_the_waters_AuraScript::HandleRemoveEffect, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q12243_fire_upon_the_waters_AuraScript();
        }
};

// The Sacred and the Corrupt (24545)

enum eSandC
{
    QUEST_THE_SACRED_AND_THE_CORRUPT = 24545,
    NPC_SAC_LICH_KING = 37857,
    NPC_SAC_LIGHTS_VENGEANCE = 37826,
    NPC_SAC_LIGHTS_VENGEANCE_VEH_1 = 37827,
    NPC_SAC_LIGHTS_VENGEANCE_VEH_2 = 37952,
    NPC_SAC_LIGHTS_VENGEANCE_BUNNY = 38001,
    NPC_SAC_WRETCHED_GHOUL = 37881,
    NPC_SAC_VEGARD_1 = 37893,
    GO_SAC_LIGHTS_VENGEANCE_1 = 201844,
    GO_SAC_LIGHTS_VENGEANCE_2 = 201922,
    GO_SAC_LIGHTS_VENGEANCE_3 = 201937,
    SPELL_SAC_STUN = 70583,
    SPELL_SAC_REPEL_HAMMER = 70590,
    SPELL_SAC_HOLY_ZONE_AURA = 70571,
    SPELL_SAC_THROW_HAMMER = 70595,
    SPELL_SAC_SUMMON_GO_1 = 70603,
    SPELL_SAC_SUMMON_GHOULS_AURA = 70612,
    SPELL_SAC_EMERGE = 50142,
    SPELL_SAC_SHIELD_OF_THE_LICH_KING = 70692,
    SPELL_SAC_ZAP_PLAYER = 70653,
    SPELL_SAC_LK_DESPAWN_ANIM = 70673,
    SPELL_SAC_VEGARD_SUMMON_GHOULS_AURA = 70737,
    SPELL_SAC_GHOUL_AREA_AURA = 70782,
    SPELL_SAC_HOLY_BOMB_VISUAL = 70785,
    SPELL_SAC_HOLY_BOMB_EXPLOSION = 70786,
    SPELL_SAC_ZAP_GHOULS_AURA = 70789,
    SPELL_SAC_GHOUL_EXPLODE = 70787,
    SPELL_SAC_KILL_VEGARD = 70792,
    SPELL_SAC_SUMMON_GO_2 = 70894,
    SPELL_SAC_SUMMON_VEGARD_SKELETON = 70862,
    SPELL_SAC_HAMMER_SHIELD = 70970,
    SPELL_SAC_SUMMON_GO_3 = 70967,

    // Xinef:
    SPELL_SAC_BLUE_EXPLOSION = 70509,
    SPELL_SAC_VEHICLE_CONTROL_AURA = 70510,
};

class WretchedGhoulCleaner
{
    public:
        void operator()(Creature* creature)
        {
            if (creature->GetEntry() == NPC_SAC_WRETCHED_GHOUL && creature->GetDisplayId() != 11686 && creature->IsAlive())
                Unit::Kill(creature, creature);
        }
};

class npc_q24545_lich_king : public CreatureScript
{
public:
    npc_q24545_lich_king() : CreatureScript("npc_q24545_lich_king") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_q24545_lich_kingAI (pCreature);
    }

    struct npc_q24545_lich_kingAI : public NullCreatureAI
    {
        npc_q24545_lich_kingAI(Creature* c) : NullCreatureAI(c), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        uint64 playerGUID;

        void CleanAll(bool fromReset = true)
        {
            if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_BUNNY, 150.0f, true))
                c->RemoveAllAuras();
            if (fromReset)
            {
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE, 150.0f, true))
                    c->DespawnOrUnsummon(1);
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                    c->RemoveAllAuras();
            }
            if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_2, 150.0f, true))
                c->DespawnOrUnsummon(1);
            if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_1, 150.0f))
                go->Delete();
            if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_2, 150.0f))
                go->Delete();
            WretchedGhoulCleaner cleaner;
            Trinity::CreatureWorker<WretchedGhoulCleaner> worker(me, cleaner);
            me->VisitNearbyGridObject(150.0f, worker);
        }

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(998, 10000);
            events.ScheduleEvent(999, 0);
            events.ScheduleEvent(1, 3000);
            summons.DespawnAll();
            playerGUID = 0;

            CleanAll();

            me->setActive(false);
            me->SetWalk(true);
            me->SetVisible(false);
            me->RemoveAllAuras();
            me->InterruptNonMeleeSpells(true);
            float x, y, z, o;
            me->GetHomePosition(x, y, z, o);
            me->UpdatePosition(x, y, z, o, true);
            me->StopMovingOnCurrentPos();
            me->GetMotionMaster()->Clear();
        }

        void SetGUID(uint64 guid, int32  /*id*/)
        {
            if (playerGUID || events.GetNextEventTime(998) || events.GetNextEventTime(2))
                return;
            me->setActive(true);
            playerGUID = guid;
            events.ScheduleEvent(2, 900000);
            events.ScheduleEvent(3, 0);
        }

        void SetData(uint32 type, uint32 data)
        {
            if (!playerGUID || type != data)
                return;
            if (data == 1)
                events.ScheduleEvent(15, 0);
            else if (data == 2)
            {
                if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_2, 150.0f))
                    go->Delete();
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                {
                    c->CastSpell(c, SPELL_SAC_HAMMER_SHIELD, true);
                    c->CastSpell(c, SPELL_SAC_SUMMON_GO_3, true);
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                        p->KnockbackFrom(c->GetPositionX(), c->GetPositionY(), 5.0f, 3.0f);
                }
                events.ScheduleEvent(18, 3000);
            }
            else if (data == 3)
            {
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                {
                    c->RemoveAllAuras();
                    c->CastSpell(c, SPELL_SAC_HOLY_ZONE_AURA, true);
                    if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_3, 150.0f))
                        go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    playerGUID = 0;
                    events.RescheduleEvent(2, 60000);
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case 998: // ensure everything is cleaned up
                    CleanAll(false);
                    break;
                case 999: // apply holy aura
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                        if (Creature* l = me->SummonCreature(NPC_SAC_LIGHTS_VENGEANCE, *c, TEMPSUMMON_MANUAL_DESPAWN))
                        {
                            l->CastSpell(c, SPELL_SAC_VEHICLE_CONTROL_AURA, true);
                            c->CastSpell(c, SPELL_SAC_HOLY_ZONE_AURA, true);
                        }
                    break;
                case 1: // check player
                    if (playerGUID)
                    {
                        bool valid = false;
                        if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                            if (p->IsAlive() && p->GetPhaseMask() & 2 && p->GetExactDistSq(me) < 100.0f*100.0f && !p->IsGameMaster())
                                valid = true;
                        if (!valid)
                        {
                            Reset();
                            return;
                        }
                    }
                    events.ScheduleEvent(1, 3000);
                    break;
                case 2: // reset timer
                    Reset();
                    break;
                case 3: // start event
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                    {
                        me->CastSpell(p, SPELL_SAC_STUN, true);
                        me->SetVisible(true);
                        Movement::PointsArray path;
                        path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                        path.push_back(G3D::Vector3(4825.35f, -582.99f, 164.83f));
                        path.push_back(G3D::Vector3(4813.38f, -580.94f, 162.62f));
                        me->GetMotionMaster()->MoveSplinePath(&path);
                        events.ScheduleEvent(4, 10000);
                    }
                    break;
                case 4: // talk 0
                    Talk(0);
                    events.ScheduleEvent(5, 6000);
                    break;
                case 5: // talk 1
                    Talk(1);
                    events.ScheduleEvent(6, 4000);
                    events.ScheduleEvent(7, 11000);
                    break;
                case 6: // repel hammer
                    me->CastSpell((Unit*)NULL, SPELL_SAC_REPEL_HAMMER, false);
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                        c->CastSpell(c, SPELL_SAC_BLUE_EXPLOSION, true);

                    events.ScheduleEvent(65, 3500);
                    break;
                case 65: // spawn hammer go
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_BUNNY, 150.0f, true))
                    {
                        c->CastSpell(c, SPELL_SAC_HOLY_ZONE_AURA, true);
                        c->CastSpell(c, SPELL_SAC_SUMMON_GO_1, true);
                    }
                    break;
                case 7: // talk 2
                    Talk(2);
                    events.ScheduleEvent(8, 8000);
                    events.ScheduleEvent(9, 11500);
                    break;
                case 8: // summon ghouls
                    me->CastSpell((Unit*)NULL, SPELL_SAC_SUMMON_GHOULS_AURA, false);
                    break;
                case 9: // talk 3
                    Talk(3);
                    events.ScheduleEvent(10, 10000);
                    break;
                case 10: // summon vegard
                    me->SummonCreature(NPC_SAC_VEGARD_1, 4812.12f, -586.08f, 162.49f, 3.14f, TEMPSUMMON_MANUAL_DESPAWN);
                    events.ScheduleEvent(11, 4000);
                    events.ScheduleEvent(12, 5000);
                    break;
                case 11: // vagard shield
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                        c->CastSpell(c, SPELL_SAC_SHIELD_OF_THE_LICH_KING, false);
                    break;
                case 12: // talk 4
                    Talk(4);
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                        me->CastSpell(p, SPELL_SAC_ZAP_PLAYER, false);
                    events.ScheduleEvent(13, 3500);
                    events.ScheduleEvent(14, 6000);
                    break;
                case 13: // despawn
                    me->CastSpell(me, SPELL_SAC_LK_DESPAWN_ANIM, false);
                    break;
                case 14: // vagard talk 0
                    me->SetVisible(false);
                    me->RemoveAllAuras();
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                    {
                        c->AI()->Talk(0);
                        c->CastSpell(c, SPELL_SAC_VEGARD_SUMMON_GHOULS_AURA, false);
                    }
                    if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_1, 150.0f))
                        go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    break;
                case 15: // remove light
                    if (Creature* x = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_2, 150.0f, true))
                        if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_BUNNY, 150.0f, true))
                        {
                            c->RemoveAurasDueToSpell(SPELL_SAC_HOLY_ZONE_AURA);
                            if (Creature* l = me->SummonCreature(NPC_SAC_LIGHTS_VENGEANCE, *c, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                x->SetCanFly(true);
                                x->SetDisableGravity(true);
                                x->SetHover(true);
                                x->NearTeleportTo(4812.09f, -585.55f, 172.03f, 3.75f);
                                l->EnterVehicle(x, 1);
                                //l->ClearUnitState(UNIT_STATE_ONVEHICLE);
                                l->CastSpell(l, SPELL_SAC_HOLY_BOMB_VISUAL, false);
                                l->AddAura(SPELL_SAC_HOLY_BOMB_VISUAL, l);
                                events.ScheduleEvent(16, 5000);
                            }
                        }
                    break;
                case 16: // add aura to kill ghouls
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE, 150.0f, true))
                        c->CastSpell(c, SPELL_SAC_ZAP_GHOULS_AURA, true);
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                        c->RemoveAurasDueToSpell(SPELL_SAC_VEGARD_SUMMON_GHOULS_AURA);
                    events.ScheduleEvent(17, 12000);
                    break;
                case 17: // kill vegard
                    {
                        WretchedGhoulCleaner cleaner;
                        Trinity::CreatureWorker<WretchedGhoulCleaner> worker(me, cleaner);
                        me->VisitNearbyGridObject(150.0f, worker);

                        if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE, 150.0f, true))
                            if (Creature* v = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                                if (Creature* b = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                                {
                                    c->CastSpell(v, SPELL_SAC_KILL_VEGARD, true);
                                    v->SetDisplayId(11686);
                                    v->DespawnOrUnsummon(1000);
                                    b->CastSpell(b, SPELL_SAC_HOLY_BOMB_EXPLOSION, true);
                                    b->CastSpell(b, SPELL_SAC_SUMMON_GO_2, true);
                                    if (Unit* vb = c->GetVehicleBase())
                                    {
                                        if (Unit* pass = vb->GetVehicleKit()->GetPassenger(0))
                                            if (pass->GetTypeId() == TYPEID_UNIT)
                                                pass->ToCreature()->DespawnOrUnsummon(1);
                                        vb->RemoveAllAuras();
                                        vb->ToCreature()->DespawnOrUnsummon(1);
                                    }
                                    c->ToCreature()->DespawnOrUnsummon(1);
                                }

                    }
                    break;
                case 18: // summon vegard
                    me->CastSpell(me, SPELL_SAC_SUMMON_VEGARD_SKELETON, true);
                    break;
            }
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon)
        {
            summons.Despawn(summon);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_SAC_REPEL_HAMMER && target->GetTypeId() == TYPEID_UNIT)
            {
                target->CastSpell((Unit*)NULL, SPELL_SAC_THROW_HAMMER, true);
                target->ToCreature()->DespawnOrUnsummon(1);
                if (Unit* c = target->GetVehicleBase())
                    c->RemoveAurasDueToSpell(SPELL_SAC_HOLY_ZONE_AURA);
            }
        }
    };
};

class at_q24545_frostmourne_cavern : public AreaTriggerScript
{
    public:
        at_q24545_frostmourne_cavern() : AreaTriggerScript("at_q24545_frostmourne_cavern") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (player->GetPhaseMask() & 2)
                if (Creature* c = player->FindNearestCreature(NPC_SAC_LICH_KING, 60.0f, true))
                    c->AI()->SetGUID(player->GetGUID());

            return true;
        }
};

class SACActivateEvent : public BasicEvent
{
    public:
        SACActivateEvent(Creature* owner) : _owner(owner) {}

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            if (!_owner->IsAlive())
                return true;
            _owner->GetMotionMaster()->MoveRandom(5.0f);
            _owner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            _owner->SetReactState(REACT_AGGRESSIVE);
            _owner->CastSpell(_owner, SPELL_SAC_GHOUL_AREA_AURA, true);
            return true;
        }

    private:
        Creature* _owner;
};

class SACDeactivateEvent : public BasicEvent
{
    public:
        SACDeactivateEvent(Creature* owner) : _owner(owner) {}

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            _owner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            _owner->SetReactState(REACT_PASSIVE);
            _owner->SetDisplayId(11686);
            return true;
        }

    private:
        Creature* _owner;
};

class npc_q24545_wretched_ghoul : public CreatureScript
{
public:
    npc_q24545_wretched_ghoul() : CreatureScript("npc_q24545_wretched_ghoul") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_q24545_wretched_ghoulAI (pCreature);
    }

    struct npc_q24545_wretched_ghoulAI : public ScriptedAI
    {
        npc_q24545_wretched_ghoulAI(Creature* c) : ScriptedAI(c)
        {
            Deactivate();
        }

        void Reset()
        {
            me->SetCorpseDelay(3);
        }

        void DoAction(int32 a)
        {
            if (a == -1)
                Activate();
            else if (a == -2)
            {
                me->CastSpell(me, SPELL_SAC_GHOUL_EXPLODE, true);
                Unit::Kill(me, me);
                me->m_Events.KillAllEvents(true);
                Deactivate();
            }
        }

        void AttackStart(Unit* who)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;
            ScriptedAI::AttackStart(who);
        }

        bool CanAIAttack(const Unit* target) const
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) || target->HasUnitState(UNIT_STATE_STUNNED) || me->GetDisplayId() == 11686)
                return false;
            Position homePos = me->GetHomePosition();
            return target->GetExactDistSq(&homePos) < 30.0f*30.0f;
        }

        void Activate()
        {
            me->SetDisplayId(me->GetNativeDisplayId());
            me->CastSpell(me, SPELL_SAC_EMERGE, true);
            me->m_Events.AddEvent(new SACActivateEvent(me), me->m_Events.CalculateTime(4000));
        }

        void Deactivate()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_PASSIVE);
            me->SetDisplayId(11686);
        }

        void JustDied(Unit* /*killer*/)
        {
            me->RemoveAurasDueToSpell(SPELL_SAC_GHOUL_AREA_AURA);
            me->m_Events.AddEvent(new SACDeactivateEvent(me), me->m_Events.CalculateTime(4000));
        }

        void JustRespawned()
        {
            Deactivate();
        }
    };
};

class GhoulTargetCheck
{
    public:
        explicit GhoulTargetCheck(bool alive) : _alive(alive) {}
        bool operator()(WorldObject* object) const
        {
            return _alive ^ (object->GetTypeId() != TYPEID_UNIT || ((Unit*)object)->GetDisplayId() != 11686);
        }
    private:
        bool _alive;
};

class spell_q24545_aod_special : public SpellScriptLoader
{
    public:
        spell_q24545_aod_special() : SpellScriptLoader("spell_q24545_aod_special") { }

        class spell_q24545_aod_special_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q24545_aod_special_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(GhoulTargetCheck(GetSpellInfo()->Id == 70790));
                Trinity::Containers::RandomResizeList(targets, 2);
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    if (target->GetTypeId() == TYPEID_UNIT)
                        target->ToCreature()->AI()->DoAction(GetSpellInfo()->Id == 70790 ? -2 : -1);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_q24545_aod_special_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
                OnEffectHitTarget += SpellEffectFn(spell_q24545_aod_special_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q24545_aod_special_SpellScript();
        }
};

class npc_q24545_vegard_dummy : public CreatureScript
{
public:
    npc_q24545_vegard_dummy() : CreatureScript("npc_q24545_vegard_dummy") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_q24545_vegard_dummyAI (pCreature);
    }

    struct npc_q24545_vegard_dummyAI : public NullCreatureAI
    {
        npc_q24545_vegard_dummyAI(Creature* c) : NullCreatureAI(c)
        {
            done = false;
        }

        bool done;

        void UpdateAI(uint32  /*diff*/)
        {
            if (!done)
            {
                done = true;
                me->CastSpell(me, SPELL_SAC_EMERGE, true);
            }
        }

    };
};

class npc_q24545_vegard : public CreatureScript
{
public:
    npc_q24545_vegard() : CreatureScript("npc_q24545_vegard") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_q24545_vegardAI (pCreature);
    }

    struct npc_q24545_vegardAI : public ScriptedAI
    {
        npc_q24545_vegardAI(Creature* c) : ScriptedAI(c)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            events.Reset();
            events.ScheduleEvent(1, 7000);
            events.ScheduleEvent(2, urand(7000, 20000));
            events.ScheduleEvent(3, urand(7000, 20000));
            events.ScheduleEvent(4, urand(7000, 20000));
            events.ScheduleEvent(5, urand(7000, 20000));
            events.ScheduleEvent(6, 1);
        }

        EventMap events;

        void JustDied(Unit* /*killer*/)
        {
            Talk(1);
            me->DespawnOrUnsummon(10000);
            if (Creature* c = me->FindNearestCreature(NPC_SAC_LICH_KING, 200.0f, true))
                c->AI()->SetData(3, 3);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(2);
        }

        void UpdateAI(uint32 diff)
        {
            UpdateVictim();
            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    if (Unit* t = me->SelectNearestTarget(50.0f))
                        AttackStart(t);
                    events.PopEvent();
                    break;
                case 2:
                    me->CastSpell((Unit*)NULL, 70866, false);
                    events.RepeatEvent(urand(30000, 35000));
                    break;
                case 3:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), 70886, false);
                    events.RepeatEvent(urand(15000, 30000));
                    break;
                case 4:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), 71003, false);
                    events.RepeatEvent(urand(15000, 30000));
                    break;
                case 5:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), 70864, false);
                    events.RepeatEvent(urand(8000, 12000));
                    break;
                case 6:
                    Talk(0);
                    me->CastSpell(me, SPELL_SAC_EMERGE, true);
                    events.PopEvent();
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class npc_spiritual_insight : public CreatureScript
{
public:
    npc_spiritual_insight() : CreatureScript("npc_spiritual_insight") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_spiritual_insightAI (pCreature);
    }

    struct npc_spiritual_insightAI : public NullCreatureAI
    {
        npc_spiritual_insightAI(Creature* c) : NullCreatureAI(c) {}

        uint8 GetSpeachId()
        {
            if (me->GetDistance2d(2686, 934) < 2.0f)
                return 0;
            if (me->GetDistance2d(3097, 1037) < 2.0f)
                return 1;
            if (me->GetDistance2d(3014, 1321) < 2.0f)
                return 2;
            if (me->GetDistance2d(2854, 1514) < 2.0f)
                return 3;
            if (me->GetDistance2d(3129, 1556) < 2.0f)
                return 4;

            return 5;
        }

        void IsSummonedBy(Unit* summoner)
        {
            if (!summoner || summoner->GetTypeId() != TYPEID_PLAYER)
                return;

            uint8 id = GetSpeachId();
            std::string const& text = sCreatureTextMgr->GetLocalizedChatString(me->GetEntry(), 0, id, 0, LOCALE_enUS);
            WorldPacket data;
            ChatHandler::BuildChatPacket(data, CHAT_MSG_MONSTER_WHISPER, LANG_UNIVERSAL, me->GetGUID(), summoner->GetGUID(), text, CHAT_TAG_NONE, "Toalu'u the Mystic");
            summoner->ToPlayer()->SendDirectMessage(&data);

            if (id == 1)
                if (Aura* aura = summoner->GetAura(47189)) // Transform Aura
                    aura->SetDuration(aura->GetDuration()-MINUTE*IN_MILLISECONDS);
        }
    };
};



// Theirs

/*#####
# npc_commander_eligor_dawnbringer
#####*/

enum CommanderEligorDawnbringer
{
    MODEL_IMAGE_OF_KELTHUZAD           = 24787, // Image of Kel'Thuzad
    MODEL_IMAGE_OF_SAPPHIRON           = 24788, // Image of Sapphiron
    MODEL_IMAGE_OF_RAZUVIOUS           = 24799, // Image of Razuvious
    MODEL_IMAGE_OF_GOTHIK              = 24804, // Image of Gothik
    MODEL_IMAGE_OF_THANE               = 24802, // Image of Thane Korth'azz
    MODEL_IMAGE_OF_BLAUMEUX            = 24794, // Image of Lady Blaumeux
    MODEL_IMAGE_OF_ZELIEK              = 24800, // Image of Sir Zeliek
    MODEL_IMAGE_OF_PATCHWERK           = 24798, // Image of Patchwerk
    MODEL_IMAGE_OF_GROBBULUS           = 24792, // Image of Grobbulus
    MODEL_IMAGE_OF_THADDIUS            = 24801, // Image of Thaddius
    MODEL_IMAGE_OF_GLUTH               = 24803, // Image of Gluth
    MODEL_IMAGE_OF_ANUBREKHAN          = 24789, // Image of Anub'rekhan
    MODEL_IMAGE_OF_FAERLINA            = 24790, // Image of Faerlina
    MODEL_IMAGE_OF_MAEXXNA             = 24796, // Image of Maexxna
    MODEL_IMAGE_OF_NOTH                = 24797, // Image of Noth
    MODEL_IMAGE_OF_HEIGAN              = 24793, // Image of Heigan
    MODEL_IMAGE_OF_LOATHEB             = 24795, // Image of Loatheb

    NPC_IMAGE_OF_KELTHUZAD             = 27766, // Image of Kel'Thuzad
    NPC_IMAGE_OF_SAPPHIRON             = 27767, // Image of Sapphiron
    NPC_IMAGE_OF_RAZUVIOUS             = 27768, // Image of Razuvious
    NPC_IMAGE_OF_GOTHIK                = 27769, // Image of Gothik
    NPC_IMAGE_OF_THANE                 = 27770, // Image of Thane Korth'azz
    NPC_IMAGE_OF_BLAUMEUX              = 27771, // Image of Lady Blaumeux
    NPC_IMAGE_OF_ZELIEK                = 27772, // Image of Sir Zeliek
    NPC_IMAGE_OF_PATCHWERK             = 27773, // Image of Patchwerk
    NPC_IMAGE_OF_GROBBULUS             = 27774, // Image of Grobbulus
    NPC_IMAGE_OF_THADDIUS              = 27775, // Image of Thaddius
    NPC_IMAGE_OF_GLUTH                 = 27782, // Image of Gluth
    NPC_IMAGE_OF_ANUBREKHAN            = 27776, // Image of Anub'rekhan
    NPC_IMAGE_OF_FAERLINA              = 27777, // Image of Faerlina
    NPC_IMAGE_OF_MAEXXNA               = 27778, // Image of Maexxna
    NPC_IMAGE_OF_NOTH                  = 27779, // Image of Noth
    NPC_IMAGE_OF_HEIGAN                = 27780, // Image of Heigan
    NPC_IMAGE_OF_LOATHEB               = 27781, // Image of Loatheb

    NPC_INFANTRYMAN                    = 27160, // Add in case I randomize the spawning
    NPC_SENTINAL                       = 27162,
    NPC_BATTLE_MAGE                    = 27164,

    // Five platforms to choose from
    SAY_PINNACLE                       = 0,
    SAY_DEATH_KNIGHT_WING              = 1,
    SAY_ABOMINATION_WING               = 2,
    SAY_SPIDER_WING                    = 3,
    SAY_PLAGUE_WING                    = 4,
    // Used in all talks
    SAY_TALK_COMPLETE                  = 5,
    // Pinnacle of Naxxramas
    SAY_SAPPHIRON                      = 6,
    SAY_KELTHUZAD_1                    = 7,
    SAY_KELTHUZAD_2                    = 8,
    SAY_KELTHUZAD_3                    = 9,
    // Death knight wing of Naxxramas
    SAY_RAZUVIOUS                      = 10,
    SAY_GOTHIK                         = 11,
    SAY_DEATH_KNIGHTS_1                = 12,
    SAY_DEATH_KNIGHTS_2                = 13,
    SAY_DEATH_KNIGHTS_3                = 14,
    SAY_DEATH_KNIGHTS_4                = 15,
    // Blighted abomination wing of Naxxramas
    SAY_PATCHWERK                      = 16,
    SAY_GROBBULUS                      = 17,
    SAY_GLUTH                          = 18,
    SAY_THADDIUS                       = 19,
    // Accursed spider wing of Naxxramas
    SAY_ANUBREKHAN                     = 20,
    SAY_FAERLINA                       = 21,
    SAY_MAEXXNA                        = 22,
    // Dread plague wing of Naxxramas
    SAY_NOTH                           = 23,
    SAY_HEIGAN_1                       = 24,
    SAY_HEIGAN_2                       = 25,
    SAY_LOATHEB                        = 26,

    SPELL_HEROIC_IMAGE_CHANNEL         = 49519,

    EVENT_START_RANDOM                 = 1,
    EVENT_MOVE_TO_POINT                = 2,
    EVENT_TALK_COMPLETE                = 3,
    EVENT_GET_TARGETS                  = 4,
    EVENT_KELTHUZAD_2                  = 5,
    EVENT_KELTHUZAD_3                  = 6,
    EVENT_DEATH_KNIGHTS_2              = 7,
    EVENT_DEATH_KNIGHTS_3              = 8,
    EVENT_DEATH_KNIGHTS_4              = 9,
    EVENT_HEIGAN_2                     = 10
};

uint32 const AudienceMobs[3] = { NPC_INFANTRYMAN, NPC_SENTINAL, NPC_BATTLE_MAGE };

Position const PosTalkLocations[6] =
{
    { 3805.453f, -682.9075f, 222.2917f, 2.793398f }, // Pinnacle of Naxxramas
    { 3807.508f, -691.0882f, 221.9688f, 2.094395f }, // Death knight wing of Naxxramas
    { 3797.228f, -690.3555f, 222.5019f, 1.134464f }, // Blighted abomination wing of Naxxramas
    { 3804.038f, -672.3098f, 222.5019f, 4.578917f }, // Accursed spider wing of Naxxramas
    { 3815.097f, -680.2596f, 221.9777f, 2.86234f  }, // Dread plague wing of Naxxramas
    { 3798.05f,  -680.611f,  222.9825f, 6.038839f }, // Home
};

class npc_commander_eligor_dawnbringer : public CreatureScript
{
    public: npc_commander_eligor_dawnbringer() : CreatureScript("npc_commander_eligor_dawnbringer") {}

        struct npc_commander_eligor_dawnbringerAI : public ScriptedAI
        {
            npc_commander_eligor_dawnbringerAI(Creature* creature) : ScriptedAI(creature)
            {
                talkWing = 0;
            }

            void Reset()
            {
                talkWing = 0;
                memset(audienceList, 0, sizeof(audienceList));
                memset(imageList, 0, sizeof(imageList));
                _events.ScheduleEvent(EVENT_GET_TARGETS, 5000);
                _events.ScheduleEvent(EVENT_START_RANDOM, 20000);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type == POINT_MOTION_TYPE)
                {
                    if (id == 1)
                    {
                        me->SetFacingTo(PosTalkLocations[talkWing].m_orientation);
                        TurnAudience();

                        switch (talkWing)
                        {
                        case 0: // Pinnacle of Naxxramas
                            {
                                switch (urand (0, 1))
                                {
                                    case 0: ChangeImage(NPC_IMAGE_OF_KELTHUZAD, MODEL_IMAGE_OF_KELTHUZAD, SAY_KELTHUZAD_1);
                                            _events.ScheduleEvent(EVENT_KELTHUZAD_2, 8000); break;
                                    case 1: ChangeImage(NPC_IMAGE_OF_SAPPHIRON, MODEL_IMAGE_OF_SAPPHIRON, SAY_SAPPHIRON); break;
                                }
                            }
                            break;
                        case 1: // Death knight wing of Naxxramas
                            {
                                switch (urand (0, 2))
                                {
                                    case 0: ChangeImage(NPC_IMAGE_OF_RAZUVIOUS, MODEL_IMAGE_OF_RAZUVIOUS, SAY_RAZUVIOUS); break;
                                    case 1: ChangeImage(NPC_IMAGE_OF_GOTHIK, MODEL_IMAGE_OF_GOTHIK, SAY_GOTHIK); break;
                                    case 2: ChangeImage(NPC_IMAGE_OF_THANE, MODEL_IMAGE_OF_THANE, SAY_DEATH_KNIGHTS_1);
                                            _events.ScheduleEvent(EVENT_DEATH_KNIGHTS_2, 10000); break;
                                }
                            }
                            break;
                        case 2: // Blighted abomination wing of Naxxramas
                            {
                                switch (urand (0, 3))
                                {
                                    case 0: ChangeImage(NPC_IMAGE_OF_PATCHWERK, MODEL_IMAGE_OF_PATCHWERK, SAY_PATCHWERK); break;
                                    case 1: ChangeImage(NPC_IMAGE_OF_GROBBULUS, MODEL_IMAGE_OF_GROBBULUS, SAY_GROBBULUS); break;
                                    case 2: ChangeImage(NPC_IMAGE_OF_THADDIUS, MODEL_IMAGE_OF_THADDIUS, SAY_THADDIUS); break;
                                    case 3: ChangeImage(NPC_IMAGE_OF_GLUTH, MODEL_IMAGE_OF_GLUTH, SAY_GLUTH); break;
                                }
                            }
                            break;
                        case 3: // Accursed spider wing of Naxxramas
                            {
                                switch (urand (0, 2))
                                {
                                    case 0: ChangeImage(NPC_IMAGE_OF_ANUBREKHAN, MODEL_IMAGE_OF_ANUBREKHAN, SAY_ANUBREKHAN); break;
                                    case 1: ChangeImage(NPC_IMAGE_OF_FAERLINA, MODEL_IMAGE_OF_FAERLINA, SAY_FAERLINA); break;
                                    case 2: ChangeImage(NPC_IMAGE_OF_MAEXXNA, MODEL_IMAGE_OF_MAEXXNA, SAY_MAEXXNA); break;
                                }
                            }
                            break;
                        case 4: // Dread plague wing of Naxxramas
                            {
                                switch (urand (0, 2))
                                {
                                    case 0: ChangeImage(NPC_IMAGE_OF_NOTH, MODEL_IMAGE_OF_NOTH, SAY_NOTH); break;
                                    case 1: ChangeImage(NPC_IMAGE_OF_HEIGAN, MODEL_IMAGE_OF_HEIGAN, SAY_HEIGAN_1);
                                            _events.ScheduleEvent(EVENT_HEIGAN_2, 8000); break;
                                    case 2: ChangeImage(NPC_IMAGE_OF_LOATHEB, MODEL_IMAGE_OF_LOATHEB, SAY_LOATHEB); break;
                                }
                            }
                            break;
                        case 5: // Home
                            _events.ScheduleEvent(EVENT_START_RANDOM, 30000);
                            break;
                        }
                    }
                }
            }

            void StoreTargets()
            {
                uint8 creaturecount;

                creaturecount = 0;

                for (uint8 ii = 0; ii < 3; ++ii)
                {
                    std::list<Creature*> creatureList;
                    GetCreatureListWithEntryInGrid(creatureList, me, AudienceMobs[ii], 15.0f);
                    for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
                    {
                        if (Creature* creatureList = *itr)
                        {
                            audienceList[creaturecount] = creatureList->GetGUID();
                            ++creaturecount;
                        }
                    }
                }

                if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_KELTHUZAD, 20.0f, true))
                    imageList[0] = creature->GetGUID();
                if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_RAZUVIOUS, 20.0f, true))
                    imageList[1] = creature->GetGUID();
                if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_PATCHWERK, 20.0f, true))
                    imageList[2] = creature->GetGUID();
                if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_ANUBREKHAN, 20.0f, true))
                    imageList[3] = creature->GetGUID();
                if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_NOTH, 20.0f, true))
                    imageList[4] = creature->GetGUID();
            }

            void ChangeImage(uint32 entry, uint32 model, uint8 text)
            {
                if (Creature* creature = ObjectAccessor::GetCreature(*me, imageList[talkWing]))
                {
                    Talk(text);
                    creature->SetEntry(entry);
                    creature->SetDisplayId(model);
                    creature->CastSpell(creature, SPELL_HEROIC_IMAGE_CHANNEL);
                    _events.ScheduleEvent(EVENT_TALK_COMPLETE, 40000);
                }
            }

            void TurnAudience()
            {
                for (uint8 i = 0; i < 10; ++i)
                {
                    if (Creature* creature = ObjectAccessor::GetCreature(*me, audienceList[i]))
                        creature->SetFacingToObject(me);
                }
            }

            void UpdateAI(uint32 diff)
            {
               _events.Update(diff);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_START_RANDOM:
                            talkWing = urand (0, 4);
                            Talk(talkWing);
                            _events.ScheduleEvent(EVENT_MOVE_TO_POINT, 8000);
                            break;
                        case EVENT_MOVE_TO_POINT:
                            me->SetWalk(true);
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MovePoint(1, PosTalkLocations[talkWing].m_positionX, PosTalkLocations[talkWing].m_positionY, PosTalkLocations[talkWing].m_positionZ);
                            break;
                        case EVENT_TALK_COMPLETE:
                            talkWing = 5;
                            Talk(talkWing);
                            _events.ScheduleEvent(EVENT_MOVE_TO_POINT, 5000);
                            break;
                        case EVENT_GET_TARGETS:
                            StoreTargets();
                            break;
                        case EVENT_KELTHUZAD_2:
                            Talk(SAY_KELTHUZAD_2);
                            _events.ScheduleEvent(EVENT_KELTHUZAD_3, 8000);
                            break;
                        case EVENT_KELTHUZAD_3:
                            Talk(SAY_KELTHUZAD_3);
                            break;
                        case EVENT_DEATH_KNIGHTS_2:
                            Talk(SAY_DEATH_KNIGHTS_2);
                            if (Creature* creature = ObjectAccessor::GetCreature(*me, imageList[talkWing]))
                            {
                                creature->SetEntry(NPC_IMAGE_OF_BLAUMEUX);
                                creature->SetDisplayId(MODEL_IMAGE_OF_BLAUMEUX);
                            }
                            _events.ScheduleEvent(EVENT_DEATH_KNIGHTS_3, 10000);
                            break;
                        case EVENT_DEATH_KNIGHTS_3:
                            Talk(SAY_DEATH_KNIGHTS_3);
                            if (Creature* creature = ObjectAccessor::GetCreature(*me, imageList[talkWing]))
                            {
                                creature->SetEntry(NPC_IMAGE_OF_ZELIEK);
                                creature->SetDisplayId(MODEL_IMAGE_OF_ZELIEK);
                            }
                            _events.ScheduleEvent(EVENT_DEATH_KNIGHTS_4, 10000);
                            break;
                        case EVENT_DEATH_KNIGHTS_4:
                            Talk(SAY_DEATH_KNIGHTS_4);
                            break;
                        case EVENT_HEIGAN_2:
                            Talk(SAY_HEIGAN_2);
                            break;
                        default:
                            break;
                    }
                }
                DoMeleeAttackIfReady();
            }
            private:
                EventMap _events;
                uint64   audienceList[10];
                uint64   imageList[5];
                uint8    talkWing;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_commander_eligor_dawnbringerAI(creature);
        }
};

/*######
## Quest Strengthen the Ancients (12096|12092)
######*/

enum StrengthenAncientsMisc
{
    SAY_WALKER_FRIENDLY         = 0,
    SAY_WALKER_ENEMY            = 1,
    SAY_LOTHALOR                = 0,

    SPELL_CREATE_ITEM_BARK      = 47550,
    SPELL_CONFUSED              = 47044,

    NPC_LOTHALOR                = 26321,

    FACTION_WALKER_ENEMY        = 14,
};

class spell_q12096_q12092_dummy : public SpellScriptLoader // Strengthen the Ancients: On Interact Dummy to Woodlands Walker
{
public:
    spell_q12096_q12092_dummy() : SpellScriptLoader("spell_q12096_q12092_dummy") { }

    class spell_q12096_q12092_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12096_q12092_dummy_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            uint32 roll = rand() % 2;

            Creature* tree = GetHitCreature();
            Player* player = GetCaster()->ToPlayer();

            if (!tree || !player)
                return;

            tree->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);

            if (roll == 1) // friendly version
            {
                tree->CastSpell(player, SPELL_CREATE_ITEM_BARK);
                tree->AI()->Talk(SAY_WALKER_FRIENDLY, player);
                tree->DespawnOrUnsummon(1000);
            }
            else if (roll == 0) // enemy version
            {
                tree->AI()->Talk(SAY_WALKER_ENEMY, player);
                tree->setFaction(FACTION_WALKER_ENEMY);
                tree->Attack(player, true);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_dummy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12096_q12092_dummy_SpellScript();
    }
};

class spell_q12096_q12092_bark : public SpellScriptLoader // Bark of the Walkers
{
public:
    spell_q12096_q12092_bark() : SpellScriptLoader("spell_q12096_q12092_bark") { }

    class spell_q12096_q12092_bark_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12096_q12092_bark_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Creature* lothalor = GetHitCreature();
            if (!lothalor || lothalor->GetEntry() != NPC_LOTHALOR)
                return;

            lothalor->AI()->Talk(SAY_LOTHALOR);
            lothalor->RemoveAura(SPELL_CONFUSED);
            lothalor->DespawnOrUnsummon(4000);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_bark_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12096_q12092_bark_SpellScript();
    }
};

/*#####
# npc_torturer_lecraft
#####*/

enum TorturerLeCraft
{
    SPELL_HEMORRHAGE                   = 30478,
    SPELL_KIDNEY_SHOT                  = 30621,
    SPELL_HIGH_EXECUTORS_BRANDING_IRON = 48603,
    NPC_TORTURER_LECRAFT               = 27394,
    EVENT_HEMORRHAGE                   = 1,
    EVENT_KIDNEY_SHOT                  = 2,
    SAY_AGGRO                          = 0
};

class npc_torturer_lecraft : public CreatureScript
{
    public: npc_torturer_lecraft() : CreatureScript("npc_torturer_lecraft") {}

        struct npc_torturer_lecraftAI : public ScriptedAI
        {
            npc_torturer_lecraftAI(Creature* creature) : ScriptedAI(creature)
            {
                _playerGUID = 0;
            }

            void Reset()
            {
                _textCounter = 1;
                _playerGUID  = 0;
            }

            void EnterCombat(Unit* who)
            {
                _events.ScheduleEvent(EVENT_HEMORRHAGE, urand(5000, 8000));
                _events.ScheduleEvent(EVENT_KIDNEY_SHOT, urand(12000, 15000));

                if (Player* player = who->ToPlayer())
                    Talk (SAY_AGGRO, player);
            }

            void SpellHit(Unit* caster, const SpellInfo* spell)
            {
                if (spell->Id != SPELL_HIGH_EXECUTORS_BRANDING_IRON)
                    return;

                if (Player* player = caster->ToPlayer())
                {
                    if (_textCounter == 1)
                        _playerGUID = player->GetGUID();

                    if (_playerGUID != player->GetGUID())
                        return;

                    Talk(_textCounter, player);

                    if (_textCounter == 5)
                        player->KilledMonsterCredit(NPC_TORTURER_LECRAFT, 0);

                    ++_textCounter;

                    if (_textCounter == 13)
                        _textCounter = 6;
                }
            }

            void UpdateAI(uint32 diff)
            {
               if (!UpdateVictim())
                   return;

               _events.Update(diff);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_HEMORRHAGE:
                            DoCastVictim(SPELL_HEMORRHAGE);
                            _events.ScheduleEvent(EVENT_HEMORRHAGE, urand(12000, 168000));
                            break;
                        case EVENT_KIDNEY_SHOT:
                            DoCastVictim(SPELL_KIDNEY_SHOT);
                            _events.ScheduleEvent(EVENT_KIDNEY_SHOT, urand(20000, 26000));
                            break;
                        default:
                            break;
                    }
                }
                DoMeleeAttackIfReady();
            }
            private:
                EventMap _events;
                uint8    _textCounter;
                uint64   _playerGUID;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_torturer_lecraftAI(creature);
        }
};

void AddSC_dragonblight()
{
    // Ours
    new npc_conversing_with_the_depths_trigger();
    new go_the_pearl_of_the_depths();
    new npc_hourglass_of_eternity();
    new npc_future_you();
    new npc_mindless_ghoul();
    new npc_injured_7th_legion_soldier();
    new npc_heated_battle();
    new spell_q12478_frostmourne_cavern();
    new spell_q12243_fire_upon_the_waters();
    new npc_q24545_lich_king();
    new at_q24545_frostmourne_cavern();
    new npc_q24545_wretched_ghoul();
    new spell_q24545_aod_special();
    new npc_q24545_vegard_dummy();
    new npc_q24545_vegard();
    new npc_spiritual_insight();

    // Theirs
    new npc_commander_eligor_dawnbringer();
    new spell_q12096_q12092_dummy();
    new spell_q12096_q12092_bark();
    new npc_torturer_lecraft();
}
