/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "forge_of_souls.h"
#include "SpellScript.h"
#include "ScriptedGossip.h"
#include "Player.h"

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
                if (me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                {
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    events.Reset();
                    events.ScheduleEvent(1, 1000);
                }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch(events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    events.PopEvent();
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_1);
                        events.ScheduleEvent(2, 8000);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_1);
                        events.ScheduleEvent(2, 11500);
                    }
                    break;
                case 2:
                    events.PopEvent();
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_2);
                        events.ScheduleEvent(3, 9000);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_2);
                        events.ScheduleEvent(3, 10500);
                    }
                    break;
                case 3:
                    events.PopEvent();
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_3);
                        events.ScheduleEvent(4, 8000);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_3);
                        events.ScheduleEvent(4, 10500);
                    }
                    break;
                case 4:
                    events.PopEvent();
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_4);
                        events.ScheduleEvent(5, 10000);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_4);
                        events.ScheduleEvent(5, 11000);
                    }
                    break;
                case 5:
                    events.PopEvent();
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_5);
                        events.ScheduleEvent(6, 8000);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_5);
                        events.ScheduleEvent(6, 9500);
                    }
                    break;
                case 6:
                    events.PopEvent();
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_6);
                        events.ScheduleEvent(7, 12000);
                    }
                    else
                    {
                        Talk(SAY_SYLVANAS_INTRO_6);
                    }
                    break;
                case 7:
                    events.PopEvent();
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_7);
                        events.ScheduleEvent(8, 8000);
                    }
                    break;
                case 8:
                    events.PopEvent();
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

        if (creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
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
        switch(uiAction)
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
        return new npc_fos_leaderAI(creature);
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
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == POINT_MOTION_TYPE && id == 1)
            {
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                if (me->GetEntry() == NPC_JAINA_PART1)
                    Talk(SAY_JAINA_OUTRO);
                else
                    Talk(SAY_SYLVANAS_OUTRO);
                me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
            }
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_fos_leader_secondAI(creature);
    }
};


class spell_shield_of_bones : public SpellScriptLoader
{
public:
    spell_shield_of_bones() : SpellScriptLoader("spell_shield_of_bones") { }

    class spell_shield_of_bones_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_shield_of_bones_AuraScript);

        int32 amount;
        bool fired;

        bool Load()
        {
            fired = false;
            amount = 0;
            return true;
        }

        void HandleAfterEffectAbsorb(AuraEffect* /*aurEff*/, DamageInfo & /*dmgInfo*/, uint32 & absorbAmount)
        {
            amount += absorbAmount;
            if (!fired && amount >= GetSpellInfo()->Effects[EFFECT_0].BasePoints+1)
                if (Unit* caster = GetCaster())
                {
                    fired = true;
                    caster->CastSpell(caster, 69642, true);
                }
        }

        void Register()
        {
            AfterEffectAbsorb += AuraEffectAbsorbFn(spell_shield_of_bones_AuraScript::HandleAfterEffectAbsorb, EFFECT_0);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_shield_of_bones_AuraScript();
    }
};

void AddSC_forge_of_souls()
{
    new npc_fos_leader();
    new npc_fos_leader_second();
    new spell_shield_of_bones();
}
