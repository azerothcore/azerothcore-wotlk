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

#include "forge_of_souls.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum Yells
{
    SAY_JAINA_INTRO_1                           = 0,
    SAY_JAINA_INTRO_2                           = 1,
    SAY_JAINA_INTRO_3                           = 2,
    SAY_JAINA_INTRO_4                           = 3,
    SAY_JAINA_INTRO_5                           = 4,
    SAY_JAINA_INTRO_6                           = 5,
    SAY_JAINA_INTRO_7                           = 6,
    SAY_JAINA_INTRO_8                           = 7,

    SAY_SYLVANAS_INTRO_1                        = 0,
    SAY_SYLVANAS_INTRO_2                        = 1,
    SAY_SYLVANAS_INTRO_3                        = 2,
    SAY_SYLVANAS_INTRO_4                        = 3,
    SAY_SYLVANAS_INTRO_5                        = 4,
    SAY_SYLVANAS_INTRO_6                        = 5,

    SAY_JAINA_OUTRO                             = 0,
    SAY_SYLVANAS_OUTRO                          = 0
};

enum FOS_Gossip
{
    GOSSIP_JAINA_INTRO = 10943,
    GOSSIP_SYLVANAS_INTRO = 10971
};

class npc_fos_leader : public CreatureScript
{
public:
    npc_fos_leader() : CreatureScript("npc_fos_leader") { }

    struct npc_fos_leaderAI: public ScriptedAI
    {
        npc_fos_leaderAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void DoAction(int32 a) override
        {
            if (a == 1)
                if (me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
                {
                    me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    events.Reset();
                    events.ScheduleEvent(1, 1s);
                }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case 1:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_1);
                        events.ScheduleEvent(2, 8s);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_1);
                        events.ScheduleEvent(2, 11s + 500ms);
                    }
                    break;
                case 2:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_2);
                        events.ScheduleEvent(3, 9s);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_2);
                        events.ScheduleEvent(3, 10s + 500ms);
                    }
                    break;
                case 3:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_3);
                        events.ScheduleEvent(4, 8s);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_3);
                        events.ScheduleEvent(4, 10s + 500ms);
                    }
                    break;
                case 4:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_4);
                        events.ScheduleEvent(5, 10s);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_4);
                        events.ScheduleEvent(5, 11s);
                    }
                    break;
                case 5:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_5);
                        events.ScheduleEvent(6, 8s);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_5);
                        events.ScheduleEvent(6, 9500ms);
                    }
                    break;
                case 6:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_6);
                        events.ScheduleEvent(7, 12s);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_6);
                    }
                    break;
                case 7:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_7);
                        events.ScheduleEvent(8, 8s);
                    }
                    break;
                case 8:

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_8);
                    }
                    break;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
        {
            if (creature->GetEntry() == NPC_JAINA_PART1)
                AddGossipItemFor(player, GOSSIP_JAINA_INTRO, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            else
                AddGossipItemFor(player, GOSSIP_SYLVANAS_INTRO, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        SendGossipMenuFor(player, 15207, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                CloseGossipMenuFor(player);
                if (creature->AI())
                    creature->AI()->DoAction(1);
                break;
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetForgeOfSoulsAI<npc_fos_leaderAI>(creature);
    }
};

class npc_fos_leader_second : public CreatureScript
{
public:
    npc_fos_leader_second() : CreatureScript("npc_fos_leader_second") { }

    struct npc_fos_leader_secondAI: public ScriptedAI
    {
        npc_fos_leader_secondAI(Creature* creature) : ScriptedAI(creature)
        {
            me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == 1)
            {
                me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                if (me->GetEntry() == NPC_JAINA_PART1)
                    Talk(SAY_JAINA_OUTRO);
                else
                    Talk(SAY_SYLVANAS_OUTRO);
                me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetForgeOfSoulsAI<npc_fos_leader_secondAI>(creature);
    }
};

enum ShieldOfBones
{
    SPELL_SHIELD_OF_BONES_DAMAGE = 69642
};

class spell_shield_of_bones_aura : public AuraScript
{
    PrepareAuraScript(spell_shield_of_bones_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHIELD_OF_BONES_DAMAGE });
    }

    int32 amount;
    bool fired;

    bool Load() override
    {
        fired = false;
        amount = 0;
        return true;
    }

    void HandleAfterEffectAbsorb(AuraEffect* /*aurEff*/, DamageInfo& /*dmgInfo*/, uint32& absorbAmount)
    {
        amount += absorbAmount;
        if (!fired && amount >= GetSpellInfo()->Effects[EFFECT_0].BasePoints + 1)
            if (Unit* caster = GetCaster())
            {
                fired = true;
                caster->CastSpell(caster, SPELL_SHIELD_OF_BONES_DAMAGE, true);
            }
    }

    void Register() override
    {
        AfterEffectAbsorb += AuraEffectAbsorbFn(spell_shield_of_bones_aura::HandleAfterEffectAbsorb, EFFECT_0);
    }
};

void AddSC_forge_of_souls()
{
    new npc_fos_leader();
    new npc_fos_leader_second();
    RegisterSpellScript(spell_shield_of_bones_aura);
}
