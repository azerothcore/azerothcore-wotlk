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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "blackrock_depths.h"

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

enum Says
{
    SAY_START_FIGHT = 0
};

enum Gossip
{
    GOSSIP_TEXT_CONTINUE                          = 1828, // Continue...
    GOSSIP_GROOMREL                               = 1945, // Option 1 : Before quest(4083) accepted, option 0 after quest(4083) accepted
    GOSSIP_DOOMREL_START_COMBAT                   = 1947, // Your bondage is at an end, Doom'rel.  I challenge you!
    SAY_DOOMREL_HELLO                             = 2601, // Our fate is the doom of all who face the Great Fire.
    SAY_QUEST_ACCEPTED                            = 2604, // You wish to learn the old craft?  You wish to smelt dark iron?$B$BAppease me, $r.  Show me a sacrifice and I will consider it!
    SAY_QUEST_COMPLETED                           = 2605, // Your will is strong, and your intent is clear.$B$BPerhaps you are worthy...
    SAY_QUEST_COMPLETED_END                       = 2606, // You have shown me your desire, and have payed with precious stone.  I will teach you...
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
                AddGossipItemFor(player, GOSSIP_TEXT_CONTINUE, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                SendGossipMenuFor(player, SAY_QUEST_COMPLETED_END, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+11:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_LEARN_SMELT, false);
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                AddGossipItemFor(player, GOSSIP_TEXT_CONTINUE, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
                SendGossipMenuFor(player, SAY_QUEST_ACCEPTED, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+22:
                CloseGossipMenuFor(player);
                if (InstanceScript* instance = creature->GetInstanceScript())
                {
                    //are 5 minutes expected? go template may have data to despawn when used at quest
                    instance->DoRespawnGameObject(instance->GetGuidData(DATA_GO_CHALICE), MINUTE * 5);
                }
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestRewardStatus(QUEST_SPECTRAL_CHALICE) == 1 && player->GetSkillValue(SKILL_MINING) >= DATA_SKILLPOINT_MIN && !player->HasSpell(SPELL_SMELT_DARK_IRON))
        {
            AddGossipItemFor(player, GOSSIP_GROOMREL, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            SendGossipMenuFor(player, SAY_QUEST_COMPLETED, creature->GetGUID());
        }

        if (player->GetQuestRewardStatus(QUEST_SPECTRAL_CHALICE) == 0 && player->GetSkillValue(SKILL_MINING) >= DATA_SKILLPOINT_MIN)
            AddGossipItemFor(player, GOSSIP_GROOMREL, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

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
                AddGossipItemFor(player, GOSSIP_TEXT_CONTINUE, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, SAY_QUEST_COMPLETED, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                CloseGossipMenuFor(player);
                creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                // Start encounter
                InstanceScript* instance = creature->GetInstanceScript();
                if (instance)
                {
                    instance->SetData(TYPE_TOMB_OF_SEVEN, IN_PROGRESS);
                }
                creature->AI()->Talk(SAY_START_FIGHT);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, GOSSIP_DOOMREL_START_COMBAT, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, SAY_DOOMREL_HELLO, creature->GetGUID());

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_doomrelAI>(creature);
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
            me->SetFaction(FACTION_FRIENDLY);

            // was set before event start, so set again
            me->SetImmuneToPC(true);

            if (instance->GetData(TYPE_TOMB_OF_SEVEN) == DONE) // what is this trying to do? Probably some kind of crash recovery
            {
                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            }
            else
            {
                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _events.ScheduleEvent(EVENT_SPELL_SHADOWBOLTVOLLEY, 10s);
            _events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 18s);
            _events.ScheduleEvent(EVENT_SPELL_CURSEOFWEAKNESS, 5s);
            _events.ScheduleEvent(EVENT_SPELL_DEMONARMOR, 16s);
            _events.ScheduleEvent(EVENT_SPELL_SUMMON_VOIDWALKERS, 1s);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->RemoveAllAuras();
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->LoadCreaturesAddon(true);
            if (me->IsAlive())
                me->GetMotionMaster()->MoveTargetedHome();
            me->SetLootRecipient(nullptr);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_SPELL_SHADOWBOLTVOLLEY:
                    DoCastVictim(SPELL_SHADOWBOLTVOLLEY);
                    _events.ScheduleEvent(EVENT_SPELL_SHADOWBOLTVOLLEY, 12s);
                    break;
                case EVENT_SPELL_IMMOLATE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(target, SPELL_IMMOLATE);
                        _events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 25s);
                    }
                    // Didn't get a target, try again in 1s
                    _events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 1s);
                    break;
                case EVENT_SPELL_CURSEOFWEAKNESS:
                    DoCastVictim(SPELL_CURSEOFWEAKNESS);
                    _events.ScheduleEvent(EVENT_SPELL_CURSEOFWEAKNESS, 45s);
                    break;
                case EVENT_SPELL_DEMONARMOR:
                    DoCast(me, SPELL_DEMONARMOR);
                    _events.ScheduleEvent(EVENT_SPELL_DEMONARMOR, 300s);
                    break;
                case EVENT_SPELL_SUMMON_VOIDWALKERS:
                    if (!Voidwalkers && HealthBelowPct(51))
                    {
                        DoCastVictim(SPELL_SUMMON_VOIDWALKERS, true);
                        Voidwalkers = true;
                    }
                    // Not ready yet, try again in 1s
                    _events.ScheduleEvent(EVENT_SPELL_SUMMON_VOIDWALKERS, 1s);
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
