/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "blackrock_depths.h"
#include "Player.h"

enum Spells
{
    SPELL_SMELT_DARK_IRON                         = 14891,
    SPELL_LEARN_SMELT                             = 14894,
};

enum Quests
{
    QUEST_SPECTRAL_CHALICE                        = 4083
};

enum Misc
{
    DATA_SKILLPOINT_MIN                           = 230
};

class boss_gloomrel : public CreatureScript
{
public:
    boss_gloomrel() : CreatureScript("boss_gloomrel") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, 1828, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                SendGossipMenuFor(player, 2606, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+11:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_LEARN_SMELT, false);
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                AddGossipItemFor(player, 1828, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
                SendGossipMenuFor(player, 2604, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+22:
                CloseGossipMenuFor(player);
                if (InstanceScript* instance = creature->GetInstanceScript())
                {
                    //are 5 minutes expected? go template may have data to despawn when used at quest
                    instance->DoRespawnGameObject(instance->GetData64(DATA_GO_CHALICE), MINUTE*5);
                }
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestRewardStatus(QUEST_SPECTRAL_CHALICE) == 1 && player->GetSkillValue(SKILL_MINING) >= DATA_SKILLPOINT_MIN && !player->HasSpell(SPELL_SMELT_DARK_IRON))
            AddGossipItemFor(player, 1945, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        if (player->GetQuestRewardStatus(QUEST_SPECTRAL_CHALICE) == 0 && player->GetSkillValue(SKILL_MINING) >= DATA_SKILLPOINT_MIN)
            AddGossipItemFor(player, 1945, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }
};

enum DoomrelSpells
{
    SPELL_SHADOWBOLTVOLLEY                                 = 15245,
    SPELL_IMMOLATE                                         = 12742,
    SPELL_CURSEOFWEAKNESS                                  = 12493,
    SPELL_DEMONARMOR                                       = 13787,
    SPELL_SUMMON_VOIDWALKERS                               = 15092
};
enum DoomrelEvents
{
    EVENT_SPELL_SHADOWBOLTVOLLEY    = 1,
    EVENT_SPELL_IMMOLATE            = 2,
    EVENT_SPELL_CURSEOFWEAKNESS     = 3,
    EVENT_SPELL_DEMONARMOR          = 4,
    EVENT_SPELL_SUMMON_VOIDWALKERS  = 5,
};

class boss_doomrel : public CreatureScript
{
public:
    boss_doomrel() : CreatureScript("boss_doomrel") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, 1828, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, 2605, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                CloseGossipMenuFor(player);
                creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                // Start encounter
                InstanceScript* instance = creature->GetInstanceScript();
                if (instance)
                    instance->SetData64(DATA_EVENSTARTER, player->GetGUID());
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, 1947, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, 2601, creature->GetGUID());

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<boss_doomrelAI>(creature);
    }

    struct boss_doomrelAI : public ScriptedAI
    {
        boss_doomrelAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap _events;
        bool Voidwalkers;

        void Reset() override
        {
            Voidwalkers = false;
            // Reset his gossip menu
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            me->setFaction(FACTION_FRIEND);

            // was set before event start, so set again
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);

            if (instance->GetData(DATA_GHOSTKILL) >= 7)
                me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
            else
                me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _events.ScheduleEvent(EVENT_SPELL_SHADOWBOLTVOLLEY, 10000);
            _events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 18000);
            _events.ScheduleEvent(EVENT_SPELL_CURSEOFWEAKNESS, 5000);
            _events.ScheduleEvent(EVENT_SPELL_DEMONARMOR, 16000);
            _events.ScheduleEvent(EVENT_SPELL_SUMMON_VOIDWALKERS, 1000);
        }

        void EnterEvadeMode() override
        {
            me->RemoveAllAuras();
            me->DeleteThreatList();
            me->CombatStop(true);
            me->LoadCreaturesAddon(true);
            if (me->IsAlive())
                me->GetMotionMaster()->MoveTargetedHome();
            me->SetLootRecipient(nullptr);
            instance->SetData64(DATA_EVENSTARTER, 0);
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetData(DATA_GHOSTKILL, 1);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);
            
            switch(_events.ExecuteEvent())
            {
                case EVENT_SPELL_SHADOWBOLTVOLLEY:
                    DoCastVictim(SPELL_SHADOWBOLTVOLLEY);
                    _events.ScheduleEvent(EVENT_SPELL_SHADOWBOLTVOLLEY, 12000);
                    break;
                case EVENT_SPELL_IMMOLATE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    {
                       DoCast(target, SPELL_IMMOLATE);
                       _events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 25000);
                    }
                    // Didn't get a target, try again in 1s
                    _events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 1000);
                    break;
                case EVENT_SPELL_CURSEOFWEAKNESS:
                    DoCastVictim(SPELL_CURSEOFWEAKNESS);
                    _events.ScheduleEvent(EVENT_SPELL_CURSEOFWEAKNESS, 45000);
                    break;
                case EVENT_SPELL_DEMONARMOR:
                    DoCast(me, SPELL_DEMONARMOR);
                    _events.ScheduleEvent(EVENT_SPELL_DEMONARMOR, 300000);
                    break;
                case EVENT_SPELL_SUMMON_VOIDWALKERS:
                    if (!Voidwalkers && HealthBelowPct(51))
                    {
                        DoCastVictim(SPELL_SUMMON_VOIDWALKERS, true);
                        Voidwalkers = true;
                    }
                    // Not ready yet, try again in 1s
                    _events.ScheduleEvent(EVENT_SPELL_SUMMON_VOIDWALKERS, 1000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_tomb_of_seven()
{
    new boss_gloomrel();
    new boss_doomrel();
}
