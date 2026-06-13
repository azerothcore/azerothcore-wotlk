/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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
    SPELL_LEARN_SMELT                             = 14894,
};

enum Says
{
    SAY_START_FIGHT = 0
};

enum Gossip
{
    GOSSIP_GLOOMREL_CONTINUE_SMELT                = 1952,
    GOSSIP_GLOOMREL_CONTINUE_CHALICE              = 1953,
    GOSSIP_DOOMREL_CONTINUE                       = 1950,
};

struct boss_gloomrel : public ScriptedAI
{
    boss_gloomrel(Creature* creature) : ScriptedAI(creature) { }

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
    {
        if (gossipListId != 0)
            return;

        if (menuId == GOSSIP_GLOOMREL_CONTINUE_SMELT)
        {
            CloseGossipMenuFor(player);
            player->CastSpell(player, SPELL_LEARN_SMELT, false);
        }
        else if (menuId == GOSSIP_GLOOMREL_CONTINUE_CHALICE)
        {
            CloseGossipMenuFor(player);
            if (InstanceScript* instance = me->GetInstanceScript())
                //are 5 minutes expected? go template may have data to despawn when used at quest
                instance->DoRespawnGameObject(instance->GetGuidData(DATA_GO_CHALICE), MINUTE * 5);
        }
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

struct boss_doomrel : public ScriptedAI
{
    boss_doomrel(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;
    EventMap _events;
    bool Voidwalkers;

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
    {
        if (menuId == GOSSIP_DOOMREL_CONTINUE && gossipListId == 0)
        {
            CloseGossipMenuFor(player);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            // Start encounter
            if (instance)
                instance->SetData(TYPE_TOMB_OF_SEVEN, IN_PROGRESS);
            Talk(SAY_START_FIGHT);
        }
    }

    void Reset() override
    {
        Voidwalkers = false;
        me->SetFaction(FACTION_FRIENDLY);

        // was set before event start, so set again
        me->SetImmuneToPC(true);

        if (instance->GetData(TYPE_TOMB_OF_SEVEN) == DONE) // what is this trying to do? Probably some kind of crash recovery
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
        else
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP);
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

void AddSC_boss_tomb_of_seven()
{
    RegisterBlackrockDepthsCreatureAI(boss_gloomrel);
    RegisterBlackrockDepthsCreatureAI(boss_doomrel);
}
