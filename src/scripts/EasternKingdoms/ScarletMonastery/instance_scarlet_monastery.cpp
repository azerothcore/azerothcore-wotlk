/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL

REWRITTEN BY XINEF
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"

enum AshbringerEventMisc
{
    AURA_OF_ASHBRINGER = 28282,
    NPC_SCARLET_MYRIDON = 4295,
    NPC_SCARLET_DEFENDER = 4298,
    NPC_SCARLET_CENTURION = 4301,
    NPC_SCARLET_SORCERER = 4294,
    NPC_SCARLET_WIZARD = 4300,
    NPC_SCARLET_ABBOT = 4303,
    NPC_SCARLET_MONK = 4540,
    NPC_SCARLET_CHAMPION = 4302,
    NPC_SCARLET_CHAPLAIN = 4299,
    NPC_FAIRBANKS = 4542,
    NPC_COMMANDER_MOGRAINE = 3976,
    FACTION_FRIENDLY_TO_ALL = 35,
};

class instance_scarlet_monastery : public InstanceMapScript
{
public:
    instance_scarlet_monastery() : InstanceMapScript("instance_scarlet_monastery", 189) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_scarlet_monastery_InstanceMapScript(map);
    }

    struct instance_scarlet_monastery_InstanceMapScript : public InstanceScript
    {
        instance_scarlet_monastery_InstanceMapScript(Map* map) : InstanceScript(map) {}

        void OnPlayerEnter(Player* player)
        {
            if (player->HasAura(AURA_OF_ASHBRINGER))
            {
                std::list<Creature*> ScarletList;
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_MYRIDON, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_DEFENDER, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CENTURION, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_SORCERER, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_WIZARD, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_ABBOT, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_MONK, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CHAMPION, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CHAPLAIN, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_COMMANDER_MOGRAINE, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_FAIRBANKS, 4000.0f);
                if (!ScarletList.empty())
                    for (std::list<Creature*>::iterator itr = ScarletList.begin(); itr != ScarletList.end(); itr++)
                        (*itr)->setFaction(FACTION_FRIENDLY_TO_ALL);
            }
        }

        void OnPlayerAreaUpdate(Player* player, uint32 /*oldArea*/, uint32 /*newArea*/) 
        {
            if (player->HasAura(AURA_OF_ASHBRINGER))
            {
                std::list<Creature*> ScarletList;
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_MYRIDON, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_DEFENDER, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CENTURION, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_SORCERER, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_WIZARD, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_ABBOT, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_MONK, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CHAMPION, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CHAPLAIN, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_COMMANDER_MOGRAINE, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_FAIRBANKS, 4000.0f);
                if (!ScarletList.empty())
                    for (std::list<Creature*>::iterator itr = ScarletList.begin(); itr != ScarletList.end(); itr++)
                        (*itr)->setFaction(FACTION_FRIENDLY_TO_ALL);
            }
        }
    };
};

enum ScarletMonasteryTrashMisc
{
    SAY_WELCOME = 0,
    AURA_ASHBRINGER = 28282,
    //FACTION_FRIENDLY_TO_ALL = 35,
    NPC_HIGHLORD_MOGRAINE = 16440,
    SPELL_COSMETIC_CHAIN = 45537,
    SPELL_COSMETIC_EXPLODE = 45935,
    SPELL_FORGIVENESS = 28697,
};

class npc_scarlet_guard : public CreatureScript
{
public:
    npc_scarlet_guard() : CreatureScript("npc_scarlet_guard") { }

    struct npc_scarlet_guardAI : public SmartAI
    {
        npc_scarlet_guardAI(Creature* creature) : SmartAI(creature) { }

        void Reset()
        {
            SayAshbringer = false;
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who && who->GetDistance2d(me) < 12.0f)
            {
                if (Player* player = who->ToPlayer())
                {
                    if (player->HasAura(AURA_ASHBRINGER) && !SayAshbringer)
                    {
                        Talk(SAY_WELCOME);
                        me->setFaction(FACTION_FRIENDLY_TO_ALL);
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->SetFacingToObject(player);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->AddAura(SPELL_AURA_MOD_ROOT, me);
                        me->CastSpell(me, SPELL_AURA_MOD_ROOT, true);
                        SayAshbringer = true;
                    }
                }
            }

            SmartAI::MoveInLineOfSight(who);
        }
    private:
        bool SayAshbringer = false;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_scarlet_guardAI(creature);
    }
};

class npc_mograine : public CreatureScript
{
public:
    npc_mograine() : CreatureScript("npc_scarlet_commander_mograine") { }

    struct npc_mograineAI : public SmartAI
    {
        npc_mograineAI(Creature* creature) : SmartAI(creature) { }

        uint32 AshbringerEvent(uint32 uiSteps)
        {
            Creature* mograine = me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 200.0f);

            switch (uiSteps)
            {
            case 1:
                me->GetMotionMaster()->MovePoint(0, 1152.039795f, 1398.405518f, 32.527878f);
                return 2 * IN_MILLISECONDS;
            case 2:
                me->SetSheath(SHEATH_STATE_UNARMED);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                return 2 * IN_MILLISECONDS;
            case 3:
                Talk(3);
                return 10 * IN_MILLISECONDS;
            case 4:
                me->SummonCreature(NPC_HIGHLORD_MOGRAINE, 1065.130737f, 1399.350586f, 30.763723f, 6.282961f, TEMPSUMMON_TIMED_DESPAWN, 400000)->SetName("Highlord Mograine");
                me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 200.0f)->setFaction(FACTION_FRIENDLY_TO_ALL);
                return 30 * IN_MILLISECONDS;
            case 5:
                mograine->StopMovingOnCurrentPos();
                mograine->AI()->Talk(0);
                mograine->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                return 4 * IN_MILLISECONDS;
            case 6:
                me->SetStandState(UNIT_STAND_STATE_STAND);
                return 2 * IN_MILLISECONDS;
            case 7:
                Talk(4);
                return 4 * IN_MILLISECONDS;
            case 8:
                mograine->AI()->Talk(1);
                return 11 * IN_MILLISECONDS;
            case 9:
                mograine->HandleEmoteCommand(EMOTE_ONESHOT_BATTLE_ROAR);
                return 4 * IN_MILLISECONDS;
            case 10:
                me->SetSheath(SHEATH_STATE_UNARMED);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                Talk(5);
                return 2 * IN_MILLISECONDS;
            case 11:
                mograine->CastSpell(me, SPELL_FORGIVENESS, false);
                return 1 * IN_MILLISECONDS;
            case 12:
                mograine->CastSpell(me, SPELL_COSMETIC_CHAIN, true);
                return 0.5 * IN_MILLISECONDS;
            case 13:
                mograine->AI()->Talk(2);
                mograine->DespawnOrUnsummon(3 * IN_MILLISECONDS);
                mograine->Kill(me, me, true);
                return 0;
            default:
                if(mograine)
                    mograine->DespawnOrUnsummon(0);
                return 0;
            }
        }

        void Reset()
        {
            SayAshbringer = false;
            timer = 0;
            step = 1;
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who && who->GetDistance2d(me) < 15.0f)
                if (Player* player = who->ToPlayer())
                    if (player->HasAura(AURA_ASHBRINGER) && !SayAshbringer)
                    {
                        me->setFaction(FACTION_FRIENDLY_TO_ALL);
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->SetFacingToObject(player);
                        me->MonsterYell("Bow down! Kneel before the Ashbringer! A new dawn approaches, brothers and sisters! Our message will be delivered to the filth of this world through the chosen one!", LANG_UNIVERSAL, player);
                        SayAshbringer = true;
                    }

            SmartAI::MoveInLineOfSight(who);
        }

        void UpdateAI(uint32 diff)
        {
            timer = timer - diff;
            if (SayAshbringer && step < 15)
            {
                if (timer <= 0)
                {
                    timer = AshbringerEvent(step);
                    step++;
                }
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        bool SayAshbringer = false;
        int timer = 0;
        int step = 1;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_mograineAI(creature);
    }
};
class npc_fairbanks : public CreatureScript
{
public:
    npc_fairbanks() : CreatureScript("npc_fairbanks") { }

    bool OnGossipHello(Player* plr, Creature* npc)
    {
        plr->ADD_GOSSIP_ITEM(0, "Curse? What's going on here, Fairbanks?", GOSSIP_SENDER_MAIN, 1);
        plr->SEND_GOSSIP_MENU(100100, npc->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* plr, Creature* npc, uint32 Sender, uint32 uiAction)
    {
        plr->PlayerTalkClass->ClearMenus();

        switch (uiAction)
        {
        case 1:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "Mograine?", GOSSIP_SENDER_MAIN, 2);
            plr->SEND_GOSSIP_MENU(100101, npc->GetGUID());
            return true;
        case 2:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "What do you mean?", GOSSIP_SENDER_MAIN, 3);
            plr->SEND_GOSSIP_MENU(100102, npc->GetGUID());
            return true;
        case 3:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "I still do not fully understand.", GOSSIP_SENDER_MAIN, 4);
            plr->SEND_GOSSIP_MENU(100103, npc->GetGUID());
            return true;
        case 4:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "Incredible story. So how did he die?", GOSSIP_SENDER_MAIN, 5);
            plr->SEND_GOSSIP_MENU(100104, npc->GetGUID());
            return true;
        case 5:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "You mean...", GOSSIP_SENDER_MAIN, 6);
            plr->SEND_GOSSIP_MENU(100105, npc->GetGUID());
            return true;
        case 6:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "How do you know all of this?", GOSSIP_SENDER_MAIN, 7);
            plr->SEND_GOSSIP_MENU(100106, npc->GetGUID());
            return true;
        case 7:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "A thousand? For one man?", GOSSIP_SENDER_MAIN, 8);
            plr->SEND_GOSSIP_MENU(100107, npc->GetGUID());
            return true;
        case 8:
            npc->HandleEmoteCommand(5);
            plr->ADD_GOSSIP_ITEM(0, "Yet? Yet what?", GOSSIP_SENDER_MAIN, 9);
            plr->SEND_GOSSIP_MENU(100108, npc->GetGUID());
            return true;
        case 9:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "And did he?", GOSSIP_SENDER_MAIN, 10);
            plr->SEND_GOSSIP_MENU(100109, npc->GetGUID());
            return true;
        case 10:
            npc->HandleEmoteCommand(274);
            plr->ADD_GOSSIP_ITEM(0, "Continue please, Fairbanks.", GOSSIP_SENDER_MAIN, 11);
            plr->SEND_GOSSIP_MENU(100110, npc->GetGUID());
            return true;
        case 11:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "You mean...", GOSSIP_SENDER_MAIN, 12);
            plr->SEND_GOSSIP_MENU(100111, npc->GetGUID());
            return true;
        case 12:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "You were right, Fairbanks. That is tragic.", GOSSIP_SENDER_MAIN, 13);
            plr->SEND_GOSSIP_MENU(100112, npc->GetGUID());
            return true;
        case 13:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "And you did...", GOSSIP_SENDER_MAIN, 14);
            plr->SEND_GOSSIP_MENU(100113, npc->GetGUID());
            return true;
        case 14:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "You tell an incredible tale, Fairbanks. What of the blade? Is it beyond redemption?", GOSSIP_SENDER_MAIN, 15);
            plr->SEND_GOSSIP_MENU(100114, npc->GetGUID());
            return true;
        case 15:
            npc->HandleEmoteCommand(1);
            plr->ADD_GOSSIP_ITEM(0, "But his son is dead.", GOSSIP_SENDER_MAIN, 16);
            plr->SEND_GOSSIP_MENU(100115, npc->GetGUID());
            return true;
        case 16:
            plr->SEND_GOSSIP_MENU(100116, npc->GetGUID());
            // todo: we need to play these 3 emote in sequence, we play only the last one right now.
            npc->HandleEmoteCommand(274);
            npc->HandleEmoteCommand(1);
            npc->HandleEmoteCommand(397);
            return true;
        }

        return true;
    }

    struct npc_fairbanksAI : public SmartAI
    {
        npc_fairbanksAI(Creature* creature) : SmartAI(creature) { }

        void Reset()
        {
            SayAshbringer = false;
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who && who->GetDistance2d(me) < 2.0f)
                if (Player* player = who->ToPlayer())
                    if (player->HasAura(AURA_ASHBRINGER) && !SayAshbringer)
                    {
                        me->setFaction(FACTION_FRIENDLY_TO_ALL);
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->CastSpell(me, 57767, true);
                        me->SetDisplayId(16179);
                        me->SetFacingToObject(player);
                        SayAshbringer = true;
                    }

            SmartAI::MoveInLineOfSight(who);
        }
    private:
        bool SayAshbringer = false;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_fairbanksAI(creature);
    }
};

void AddSC_instance_scarlet_monastery()
{
    new instance_scarlet_monastery();
    new npc_scarlet_guard();
    new npc_fairbanks();
    new npc_mograine();
}
