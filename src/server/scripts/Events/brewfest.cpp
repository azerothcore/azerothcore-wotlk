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

#include "CellImpl.h"
#include "CreatureScript.h"
#include "GameEventMgr.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "LFGMgr.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"

///////////////////////////////////////
////// GOS
///////////////////////////////////////

///////////////////////////////////////
////// NPCS
///////////////////////////////////////
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
    SPELL_RAM_RACING_CROP                       = 44262,
    SPELL_COOLDOWN_CHECKER                      = 44689,
    NPC_RAM_MASTER_RAY                          = 24497,
    NPC_NEILL_RAMSTEIN                          = 23558,
    KEG_KILL_CREDIT                             = 24337,
    GOSSIP_NEIL                                 = 8953,
    GOSSIP_RAY                                  = 8973
};

struct npc_brewfest_keg_thrower : public ScriptedAI
{
    npc_brewfest_keg_thrower(Creature* creature) : ScriptedAI(creature)
    {
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (me->GetDistance(who) < 10.0f && who->IsPlayer() && who->GetMountID() == RAM_DISPLAY_ID)
        {
            if (!who->ToPlayer()->HasItemCount(ITEM_PORTABLE_BREWFEST_KEG)) // portable brewfest keg
                me->CastSpell(who, SPELL_THROW_KEG, true);          // throw keg
        }
    }

    bool CanBeSeen(Player const* player) override
    {
        if (player->GetMountID() == RAM_DISPLAY_ID)
            return true;

        return false;
    }
};

struct npc_brewfest_keg_reciver : public ScriptedAI
{
    npc_brewfest_keg_reciver(Creature* creature) : ScriptedAI(creature) { }

    void MoveInLineOfSight(Unit* who) override
    {
        if (me->GetDistance(who) < 10.0f && who->IsPlayer() && who->GetMountID() == RAM_DISPLAY_ID)
        {
            Player* player = who->ToPlayer();
            if (player->HasItemCount(ITEM_PORTABLE_BREWFEST_KEG)) // portable brewfest keg
            {
                player->KilledMonsterCredit(KEG_KILL_CREDIT);
                player->CastSpell(me, SPELL_THROW_KEG, true);          // throw keg
                player->DestroyItemCount(ITEM_PORTABLE_BREWFEST_KEG, 1, true);

                // Additional Work
                uint32 spellCooldown = player->GetSpellCooldownDelay(SPELL_COOLDOWN_CHECKER) / IN_MILLISECONDS;
                if (spellCooldown > (HOUR * 18 - 900)) // max aproximated time - 12 minutes
                {
                    if (Aura* aur = player->GetAura(SPELL_RAM_AURA))
                    {
                        int32 diff = aur->GetApplyTime() - (GameTime::GetGameTime().count() - (HOUR * 18) + spellCooldown);
                        if (diff > 10) // aura applied later
                            return;

                        aur->SetDuration(aur->GetDuration() + 30000);
                        player->CastSpell(player, SPELL_ADD_TOKENS, true);
                    }
                }
            }
        }
    }

    void sGossipSelect(Player* player, uint32 uiSender, uint32 uiAction) override
    {
        if (uiSender == GOSSIP_NEIL || uiSender == GOSSIP_RAY)
        {
            player->CastSpell(player, SPELL_COOLDOWN_CHECKER, true);
            player->AddSpellCooldown(SPELL_COOLDOWN_CHECKER, 0, 18 * HOUR * IN_MILLISECONDS);
        }

        if (uiAction != 4)
        {
            CloseGossipMenuFor(player);

            player->CastSpell(player, SPELL_RAM_AURA, true);
            player->CastSpell(player, SPELL_RAM_RACING_CROP, true);
        }
    }
};

enum barkTrigger
{
    QUEST_BARK_FOR_DROHN                = 11407,
    QUEST_BARK_FOR_VOODOO               = 11408,
    QUEST_BARK_FOR_BARLEY               = 11293,
    QUEST_BARK_FOR_THUNDERBREW          = 11294,
};

struct npc_brewfest_bark_trigger : public ScriptedAI
{
    npc_brewfest_bark_trigger(Creature* creature) : ScriptedAI(creature) { }

    void MoveInLineOfSight(Unit* who) override
    {
        if (me->GetDistance(who) < 10.0f && who->IsPlayer() && who->GetMountID() == RAM_DISPLAY_ID)
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

                QuestStatusData& q_status = itr->second;
                if (q_status.CreatureOrGOCount[me->GetEntry() - 24202] == 0)
                {
                    player->KilledMonsterCredit(me->GetEntry());
                    player->Say(GetTextFor(me->GetEntry(), quest).c_str(), LANG_UNIVERSAL, player);
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
                    switch (urand(0, 3))
                    {
                        case 0:
                            str = "Join with your brothers and sisters at " + std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") + " and drink for the horde!";
                            break;
                        case 1:
                            str = "If you think an orc can hit hard, check out their brew, it hits even harder! See for yourself at " + std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") + ", only at Brewfest!";
                            break;
                        case 2:
                            str = "Celebrate Brewfest with orcs that know what a good drink really is! Check out " + std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") + " at Brewfest!";
                            break;
                        case 3:
                            str = std::string(questId == QUEST_BARK_FOR_DROHN ? "Drohn's Distillery" : "T'chali's Voodoo Brewery") + "  knows how to party hard! Check them out at Brewfest!";
                            break;
                    }
                    break;
                }
            case QUEST_BARK_FOR_BARLEY:
            case QUEST_BARK_FOR_THUNDERBREW:
                {
                    switch (urand(0, 3))
                    {
                        case 0:
                            str = "Join with your brothers and sisters at " + std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") + " and drink for the alliance!";
                            break;
                        case 1:
                            str = "If you think an dwarf can hit hard, check out their brew, it hits even harder! See for yourself at " + std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") + ", only at Brewfest!";
                            break;
                        case 2:
                            str = "Celebrate Brewfest with dwarves that know what a good drink really is! Check out " + std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") + " at Brewfest!";
                            break;
                        case 3:
                            str = std::string(questId == QUEST_BARK_FOR_BARLEY ? "Barleybrews" : "Thunderbrews") + "  knows how to party hard! Check them out at Brewfest!";
                            break;
                    }
                    break;
                }
        }

        return str;
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
    NPC_NORMAL_VOODOO                   = 24493,
    NPC_NORMAL_BARLEYBREW               = 23683,
    NPC_NORMAL_THUNDERBREW              = 23684,
    NPC_NORMAL_GORDOK                   = 23685,
    NPC_EVENT_GENERATOR                 = 23703,
    NPC_SUPER_BREW_TRIGGER              = 23808,
    NPC_DARK_IRON_HERALD                = 24536,
    NPC_BREWFEST_REVELER                = 24484,

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
    SPELL_WEAK_ALCOHOL                  = 42523,

    // Dark Irons
    SPELL_ATTACK_KEG                    = 42393,
    SPELL_KNOCKBACK_AURA                = 42676,
    SPELL_MUG_BOUNCE_BACK               = 42522,
};

struct npc_dark_iron_attack_generator : public ScriptedAI
{
    npc_dark_iron_attack_generator(Creature* creature) : ScriptedAI(creature), summons(me) { }

    EventMap events;
    SummonList summons;
    uint32 kegCounter, guzzlerCounter;
    uint8 thrown;
    GuidVector revelerGUIDs;

    void Reset() override
    {
        for (ObjectGuid const& guid : revelerGUIDs)
        {
            if (Creature* reveler = ObjectAccessor::GetCreature(*me, guid))
            {
                reveler->SetRespawnDelay(5 * MINUTE);
                reveler->Respawn();

                // It's here because SmartAI::JustRespawned restores original faction
                // So we need to delay a little bit reloading auras from creature_template_addon
                reveler->m_Events.AddEventAtOffset([reveler]()
                {
                    reveler->RemoveAllAuras();
                    reveler->LoadCreaturesAddon(true);
                }, 100ms);
            }
        }
        revelerGUIDs.clear();

        summons.DespawnAll();
        events.Reset();
        events.ScheduleEvent(EVENT_CHECK_HOUR, 2s);
        kegCounter = 0;
        guzzlerCounter = 0;
        thrown = 0;
    }

    // DARK IRON ATTACK EVENT
    void MoveInLineOfSight(Unit*  /*who*/) override {}
    void JustEngagedWith(Unit*) override {}

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
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

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (events.ExecuteEvent())
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
                        float rand = 8 + rand_norm() * 12;
                        float angle = rand_norm() * 2 * M_PI;
                        float x = 1201.8f + rand * cos(angle);
                        float y = -4299.6f + rand * std::sin(angle);
                        if (Creature* cr = me->SummonCreature(NPC_MOLE_MACHINE_TRIGGER, x, y, 21.3f, 0.0f))
                            cr->CastSpell(cr, SPELL_SPAWN_MOLE_MACHINE, true);
                    }
                    else if (me->GetMapId() == 0) // EK
                    {
                        float rand = rand_norm() * 20;
                        float angle = rand_norm() * 2 * M_PI;
                        float x = -5157.1f + rand * cos(angle);
                        float y = -598.98f + rand * std::sin(angle);
                        if (Creature* cr = me->SummonCreature(NPC_MOLE_MACHINE_TRIGGER, x, y, 398.11f, 0.0f))
                            cr->CastSpell(cr, SPELL_SPAWN_MOLE_MACHINE, true);
                    }
                    events.RepeatEvent(3000);
                    break;
                }
            case EVENT_PRE_FINISH_ATTACK:
                {
                    events.CancelEvent(EVENT_SPAWN_MOLE_MACHINE);
                    events.ScheduleEvent(EVENT_FINISH_ATTACK, 20s);
                    break;
                }
            case EVENT_FINISH_ATTACK:
                {
                    FinishAttackDueToWin();
                    events.RescheduleEvent(EVENT_CHECK_HOUR, 1min);
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
                        sayer->Say("SOMEONE TRY THIS SUPER BREW!", LANG_UNIVERSAL);
                        //sayer->CastSpell(sayer, SPELL_CREATE_SUPER_BREW, true);
                        sayer->SummonCreature(NPC_SUPER_BREW_TRIGGER, sayer->GetPositionX() + 15 * cos(sayer->GetOrientation()), sayer->GetPositionY() + 15 * std::sin(sayer->GetOrientation()), sayer->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000);
                    }
                    else
                    {
                        if (urand(0, 1))
                            sayer->Say("Chug and chuck! Chug and chuck!", LANG_UNIVERSAL);
                        else
                            sayer->Say("Down the free brew and pelt the Guzzlers with your mug!", LANG_UNIVERSAL);
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
            snprintf(amount, sizeof(amount), "We did it boys! Now back to the Grim Guzzler and we'll drink to the %u that were injured!", guzzlerCounter);
            herald->Yell(amount, LANG_UNIVERSAL);
        }

        Reset();
        events.RescheduleEvent(EVENT_CHECK_HOUR, 1min);
    }

    void FinishAttackDueToWin()
    {
        if (Creature* herald = me->FindNearestCreature(NPC_DARK_IRON_HERALD, 100.0f))
        {
            char amount[500];
            snprintf(amount, sizeof(amount), "RETREAT!! We've already lost %u and we can't afford to lose any more!!", guzzlerCounter);
            herald->Yell(amount, LANG_UNIVERSAL);
        }

        me->CastSpell(me, (me->GetMapId() == 1 ? SPELL_SUMMON_PLANS_H : SPELL_SUMMON_PLANS_A), true);
        Reset();
    }

    void PrepareEvent()
    {
        std::list<Creature*> revelers;
        GetCreatureListWithEntryInGrid(revelers, me, NPC_BREWFEST_REVELER, 100.f);
        for (Creature* reveler : revelers)
        {
            revelerGUIDs.push_back(reveler->GetGUID());
            reveler->SetRespawnDelay(MONTH);
            reveler->AI()->SetData(0, me->GetMapId());
        }

        Creature* cr;
        if (me->GetMapId() == 1) // Kalimdor
        {
            if ((cr = me->SummonCreature(NPC_DROHN_KEG, 1183.69f, -4315.15f, 21.1875f, 0.750492f)))
            {
                cr->SetReactState(REACT_PASSIVE);
                summons.Summon(cr);
                revelerGUIDs.push_back(cr->GetGUID());
            }
            if ((cr = me->SummonCreature(NPC_VOODOO_KEG, 1182.42f, -4272.45f, 21.1182f, -1.02974f)))
            {
                cr->SetReactState(REACT_PASSIVE);
                summons.Summon(cr);
                revelerGUIDs.push_back(cr->GetGUID());
            }
            if ((cr = me->SummonCreature(NPC_GORDOK_KEG, 1223.78f, -4296.48f, 21.1707f, -2.86234f)))
            {
                cr->SetReactState(REACT_PASSIVE);
                summons.Summon(cr);
                revelerGUIDs.push_back(cr->GetGUID());
            }
        }
        else if (me->GetMapId() == 0) // Eastern Kingdom
        {
            if ((cr = me->SummonCreature(NPC_BARLEYBREW_KEG, -5187.23f, -599.779f, 397.176f, 0.017453f)))
            {
                cr->SetReactState(REACT_PASSIVE);
                summons.Summon(cr);
                revelerGUIDs.push_back(cr->GetGUID());
            }
            if ((cr = me->SummonCreature(NPC_THUNDERBREW_KEG, -5160.05f, -632.632f, 397.178f, 1.39626f)))
            {
                cr->SetReactState(REACT_PASSIVE);
                summons.Summon(cr);
                revelerGUIDs.push_back(cr->GetGUID());
            }
            if ((cr = me->SummonCreature(NPC_GORDOK_KEG, -5145.75f, -575.667f, 397.176f, -2.28638f)))
            {
                cr->SetReactState(REACT_PASSIVE);
                summons.Summon(cr);
                revelerGUIDs.push_back(cr->GetGUID());
            }
        }

        if ((cr = me->SummonCreature(NPC_DARK_IRON_HERALD, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 300000)))
            summons.Summon(cr);

        kegCounter = 0;
        guzzlerCounter = 0;
        thrown = 0;

        events.ScheduleEvent(EVENT_SPAWN_MOLE_MACHINE, 1500ms);
        events.ScheduleEvent(EVENT_PRE_FINISH_ATTACK, 280s);
        events.ScheduleEvent(EVENT_BARTENDER_SAY, 5s);
    }

    bool AllowStart()
    {
        auto minutes = Acore::Time::GetMinutes();

        if (!minutes || minutes == 30)
            return true;

        return false;
    }

    Creature* GetRandomBartender()
    {
        uint32 entry = 0;
        switch (urand(0, 2))
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

struct npc_dark_iron_attack_mole_machine : public ScriptedAI
{
    npc_dark_iron_attack_mole_machine(Creature* creature) : ScriptedAI(creature) { }

    void JustEngagedWith(Unit*) override {}
    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}

    uint32 goTimer, summonTimer;
    void Reset() override
    {
        goTimer = 1;
        summonTimer = 0;
    }

    void UpdateAI(uint32 diff) override
    {
        if (goTimer)
        {
            goTimer += diff;
            if (goTimer >= 3000)
            {
                goTimer = 0;
                summonTimer++;
                if (GameObject* drill = me->SummonGameObject(GO_MOLE_MACHINE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), M_PI / 4, 0.0f, 0.0f, 0.0f, 0.0f, 8))
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

struct npc_dark_iron_guzzler : public ScriptedAI
{
    npc_dark_iron_guzzler(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
        attacking = false;
    }

    uint32 timer;
    ObjectGuid targetGUID;
    bool attacking;

    void JustEngagedWith(Unit*) override {}
    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }

    void MovementInform(uint32 type, uint32 /*id*/) override
    {
        if (type != FOLLOW_MOTION_TYPE)
        {
            return;
        }

        if (Unit* target = GetTarget())
        {
            timer = 0;
            attacking = true;
            me->CastSpell(target, SPELL_ATTACK_KEG, false);
        }
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
            uint8 index = 0;
            do
                index = urand(0, 2);
            while (shuffled[index]);

            shuffled[index] = entry[i];
        }

        attacking = false;

        for (uint8 i = 0; i < 3; ++i)
            if (Creature* cr = me->FindNearestCreature(shuffled[i], 100.0f))
            {
                cr->SetWalk(true);
                me->GetMotionMaster()->MoveFollow(cr, 1.0f, cr->GetAngle(me));
                targetGUID = cr->GetGUID();
                return;
            }

        // no kegs found
        me->DisappearAndDie();
    }

    Unit* GetTarget() { return ObjectAccessor::GetUnit(*me, targetGUID); }

    void Reset() override
    {
        timer = 0;
        targetGUID.Clear();
        me->SetWalk(true);
        FindNextKeg();
        me->ApplySpellImmune(SPELL_ATTACK_KEG, IMMUNITY_ID, SPELL_ATTACK_KEG, true);
        SayText();
        me->CastSpell(me, SPELL_KNOCKBACK_AURA, true);
    }

    void SayText()
    {
        if (!urand(0, 20))
        {
            switch (urand(0, 4))
            {
                case 0:
                    me->Say("Drink it all boys!", LANG_UNIVERSAL);
                    break;
                case 1:
                    me->Say("DRINK! BRAWL! DRINK! BRAWL!", LANG_UNIVERSAL);
                    break;
                case 2:
                    me->Say("Did someone say, \"Free Brew\"?", LANG_UNIVERSAL);
                    break;
                case 3:
                    me->Say("No one expects the Dark Iron dwarves!", LANG_UNIVERSAL);
                    break;
                case 4:
                    me->Say("It's not a party without some crashers!", LANG_UNIVERSAL);
                    break;
            }
        }
    }

    void KilledUnit(Unit* who) override
    {
        who->CastSpell(who, SPELL_REPORT_DEATH, true);
    }

    void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
    {
        if (me->IsAlive() && spellInfo->Id == SPELL_PLAYER_MUG)
        {
            me->CastSpell(me, SPELL_MUG_BOUNCE_BACK, true);
            me->KillSelf();
            me->CastSpell(me, SPELL_REPORT_DEATH, true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        timer += diff;
        if (timer < 2000)
            return;

        timer = 0;
        if (targetGUID)
        {
            Unit* target = GetTarget();
            if (target && target->IsAlive())
            {
                if (attacking)
                {
                    me->CastSpell(target, SPELL_ATTACK_KEG, false);
                }
            }
            else
            {
                FindNextKeg();
            }
        }
    }
};

struct npc_brewfest_super_brew_trigger : public ScriptedAI
{
    npc_brewfest_super_brew_trigger(Creature* creature) : ScriptedAI(creature) { }

    uint32 timer;
    void JustEngagedWith(Unit*) override {}
    void MoveInLineOfSight(Unit*  /*who*/) override
    {
    }

    void AttackStart(Unit*) override {}

    void Reset() override
    {
        timer = 0;
        me->SummonGameObject(186478, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 30000);
    }

    void UpdateAI(uint32 diff) override
    {
        timer += diff;
        if (timer >= 500)
        {
            timer = 0;
            Player* player = nullptr;
            Acore::AnyPlayerInObjectRangeCheck checker(me, 2.0f);
            Acore::PlayerSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(me, player, checker);
            Cell::VisitWorldObjects(me, searcher, 2.0f);
            if (player)
            {
                player->CastSpell(player, SPELL_DRUNKEN_MASTER, true);
                me->RemoveAllGameObjects();
                me->KillSelf();
            }
        }
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

class spell_brewfest_main_ram_buff : public AuraScript
{
    PrepareAuraScript(spell_brewfest_main_ram_buff)

    uint8 privateLevel;
    uint32 questTick;
    bool Load() override
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
                if (Aura* fatigueAura = caster->GetAura(SPELL_RAM_FATIGUE))
                {
                    fatigueAura->ModStackAmount(-4);
                }
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
                    caster->ToPlayer()->KilledMonsterCredit(CREDIT_TROT);
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
                    caster->ToPlayer()->KilledMonsterCredit(CREDIT_CANTER);
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
                    caster->ToPlayer()->KilledMonsterCredit(CREDIT_GALLOP);
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

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_brewfest_main_ram_buff::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectRemove += AuraEffectRemoveFn(spell_brewfest_main_ram_buff::HandleEffectRemove, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_brewfest_ram_fatigue : public AuraScript
{
    PrepareAuraScript(spell_brewfest_ram_fatigue)

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

    void Register() override
    {
        if (m_scriptSpellId != 43332)
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_brewfest_ram_fatigue::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        else
            OnEffectRemove += AuraEffectRemoveFn(spell_brewfest_ram_fatigue::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_brewfest_apple_trap : public SpellScript
{
    PrepareSpellScript(spell_brewfest_apple_trap);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(false, SPELL_RAM_FATIGUE));

        if (targets.empty())
            FinishCast(SPELL_FAILED_CASTER_AURASTATE);
    }

    void HandleDummyEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (Aura* aur = target->GetAura(SPELL_RAM_FATIGUE))
                aur->Remove();
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_brewfest_apple_trap::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_brewfest_apple_trap::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum Catch
{
    NPC_WILD_WOLPERTINGER = 23487,

    ITEM_STUNNED_WOLPERTINGER = 32906
};

class spell_catch_the_wild_wolpertinger : public AuraScript
{
    PrepareAuraScript(spell_catch_the_wild_wolpertinger);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* wild = GetTarget()->ToCreature())
        {
            if (wild->GetEntry() == NPC_WILD_WOLPERTINGER)
            {
                wild->ToCreature()->DespawnOrUnsummon(1s, 0s);
                GetCaster()->ToPlayer()->AddItem(ITEM_STUNNED_WOLPERTINGER, 1);
            }
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_catch_the_wild_wolpertinger::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_PACIFY_SILENCE, AURA_EFFECT_HANDLE_REAL);
    }
};

enum fillKeg
{
    GREEN_EMPTY_KEG             = 37892,
    BLUE_EMPTY_KEG              = 33016,
    YELLOW_EMPTY_KEG            = 32912,
};

class spell_brewfest_fill_keg : public SpellScript
{
    PrepareSpellScript(spell_brewfest_fill_keg);

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
                        item = itemCaster->GetEntry() + urand(1, 5); // 5 items, id in range empty+1-5
                        break;
                    case YELLOW_EMPTY_KEG:
                        if (uint8 num = urand(0, 4))
                            item = 32916 + num;
                        else
                            item = 32915;
                        break;
                }

                if (item && player->AddItem(item, 1)) // ensure filled keg is stored
                {
                    player->DestroyItemCount(itemCaster->GetEntry(), 1, true);
                    GetSpell()->m_CastItem = nullptr;
                    GetSpell()->m_castItemGUID.Clear();
                }
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_brewfest_fill_keg::HandleAfterHit);
    }
};

class spell_brewfest_unfill_keg : public SpellScript
{
    PrepareSpellScript(spell_brewfest_unfill_keg);

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
                    GetSpell()->m_castItemGUID.Clear();
                }
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_brewfest_unfill_keg::HandleAfterHit);
    }
};

class spell_brewfest_toss_mug : public SpellScript
{
    PrepareSpellScript(spell_brewfest_toss_mug);

    SpellCastResult CheckCast()
    {
        if (Unit* caster = GetCaster())
        {
            WorldLocation pPosition = WorldLocation(*caster);
            caster->MovePositionToFirstCollision(pPosition, 14.f, 0.f);
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

    void HandleBeforeHit(SpellMissInfo missInfo)
    {
        if (missInfo != SPELL_MISS_NONE)
        {
            return;
        }

        if (Unit* target = GetHitUnit())
        {
            if (!GetCaster() || target->GetGUID() == GetCaster()->GetGUID())
                return;

            WorldLocation pPosition = WorldLocation(target->GetMapId(), target->GetPositionX(), target->GetPositionY(), target->GetPositionZ() + 4.0f, target->GetOrientation());
            SetExplTargetDest(pPosition);
        }
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        if (!GetHitUnit() || GetHitUnit()->GetGUID() != caster->GetGUID())
            return;

        std::vector<Creature*> bakers;
        if (caster->GetMapId() == 1) // Kalimdor
        {
            if (Creature* creature = caster->FindNearestCreature(NPC_NORMAL_VOODOO, 40.0f))
            {
                bakers.push_back(creature);
            }

            if (Creature* creature = caster->FindNearestCreature(NPC_NORMAL_DROHN, 40.0f))
            {
                bakers.push_back(creature);
            }

            if (Creature* creature = caster->FindNearestCreature(NPC_NORMAL_GORDOK, 40.0f))
            {
                bakers.push_back(creature);
            }
        }
        else // EK
        {
            if (Creature* creature = caster->FindNearestCreature(NPC_NORMAL_THUNDERBREW, 40.0f))
            {
                bakers.push_back(creature);
            }

            if (Creature* creature = caster->FindNearestCreature(NPC_NORMAL_BARLEYBREW, 40.0f))
            {
                bakers.push_back(creature);
            }

            if (Creature* creature = caster->FindNearestCreature(NPC_NORMAL_GORDOK, 40.0f))
            {
                bakers.push_back(creature);
            }
        }

        if (!bakers.empty())
        {
            std::sort(bakers.begin(), bakers.end(), Acore::ObjectDistanceOrderPred(caster));
            if (Creature* creature = *bakers.begin())
            {
                creature->CastSpell(caster, SPELL_THROW_MUG_TO_PLAYER, true);
            }
        }

        caster->CastSpell(caster, SPELL_WEAK_ALCOHOL, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_brewfest_toss_mug::CheckCast);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_brewfest_toss_mug::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        BeforeHit += BeforeSpellHitFn(spell_brewfest_toss_mug::HandleBeforeHit);
        OnEffectHitTarget += SpellEffectFn(spell_brewfest_toss_mug::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_brewfest_add_mug : public SpellScript
{
    PrepareSpellScript(spell_brewfest_add_mug);

    void HandleDummyEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_ADD_MUG, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_brewfest_add_mug::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum brewBubble
{
    SPELL_BUBBLE_BUILD_UP           = 49828,
};

struct npc_brew_bubble : public NullCreatureAI
{
    npc_brew_bubble(Creature* creature) : NullCreatureAI(creature) { }

    uint32 timer;

    void Reset() override
    {
        me->SetReactState(REACT_AGGRESSIVE);
        me->GetMotionMaster()->MoveRandom(15.0f);
        timer = 0;
    }

    void DoAction(int32) override
    {
        timer = 0;
    }

    void MoveInLineOfSight(Unit* target) override
    {
        if (target->GetEntry() == me->GetEntry())
            if (me->IsWithinDist(target, 1.0f))
            {
                uint8 stacksMe = me->GetAuraCount(SPELL_BUBBLE_BUILD_UP);
                uint8 stacksTarget = target->GetAuraCount(SPELL_BUBBLE_BUILD_UP);
                if (stacksMe >= stacksTarget)
                {
                    if (Aura* aura = me->GetAura(SPELL_BUBBLE_BUILD_UP))
                        aura->ModStackAmount(stacksTarget + 1);
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

    void UpdateAI(uint32 diff) override
    {
        timer += diff;
        if (timer >= 25000)
        {
            timer = 0;
            me->DespawnOrUnsummon();
        }
    }
};

enum BrewfestRevelerEnum
{
    FACTION_ALLIANCE    = 1934,
    FACTION_HORDE       = 1935,

    SPELL_BREWFEST_REVELER_TRANSFORM_GOBLIN_MALE          = 44003,
    SPELL_BREWFEST_REVELER_TRANSFORM_GOBLIN_FEMALE        = 44004,
    SPELL_BREWFEST_REVELER_TRANSFORM_BE                   = 43907,
    SPELL_BREWFEST_REVELER_TRANSFORM_ORC                  = 43914,
    SPELL_BREWFEST_REVELER_TRANSFORM_TAUREN               = 43915,
    SPELL_BREWFEST_REVELER_TRANSFORM_TROLL                = 43916,
    SPELL_BREWFEST_REVELER_TRANSFORM_UNDEAD               = 43917,

    SPELL_DRUNKEN_BREWFEST_REVELER_TRANSFORM_GOBLIN_MALE  = 44096
};

class spell_brewfest_reveler_transform : public AuraScript
{
    PrepareAuraScript(spell_brewfest_reveler_transform);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        uint32 factionId = FACTION_ALLIANCE;
        switch (m_scriptSpellId)
        {
            case SPELL_BREWFEST_REVELER_TRANSFORM_BE:
            case SPELL_BREWFEST_REVELER_TRANSFORM_ORC:
            case SPELL_BREWFEST_REVELER_TRANSFORM_TAUREN:
            case SPELL_BREWFEST_REVELER_TRANSFORM_TROLL:
            case SPELL_BREWFEST_REVELER_TRANSFORM_UNDEAD:
                factionId = FACTION_HORDE;
                break;
            case SPELL_BREWFEST_REVELER_TRANSFORM_GOBLIN_MALE:
            case SPELL_BREWFEST_REVELER_TRANSFORM_GOBLIN_FEMALE:
            case SPELL_DRUNKEN_BREWFEST_REVELER_TRANSFORM_GOBLIN_MALE:
                factionId = FACTION_FRIENDLY;
                break;
            default:
                break;
        }

        GetTarget()->SetFaction(factionId);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_brewfest_reveler_transform::OnApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_brewfest_relay_race_force_cast : public SpellScript
{
    PrepareSpellScript(spell_brewfest_relay_race_force_cast);

    SpellCastResult CheckItem()
    {
        if (Unit* target = GetExplTargetUnit())
        {
            if (SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(GetSpellInfo()->Effects[EFFECT_0].TriggerSpell))
            {
                if (Player* player = target->ToPlayer())
                {
                    if (player->HasItemCount(triggeredSpellInfo->Reagent[0]))
                    {
                        return SPELL_CAST_OK;
                    }
                }
            }
        }

        return SPELL_FAILED_DONT_REPORT;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_brewfest_relay_race_force_cast::CheckItem);
    }
};

enum DirebrewSays
{
    SAY_INTRO                   = 0,
    SAY_INTRO1                  = 1,
    SAY_INTRO2                  = 2,
    SAY_INSULT                  = 3,
    SAY_ANTAGONIST_1            = 0,
    SAY_ANTAGONIST_2            = 1,
    SAY_ANTAGONIST_COMBAT       = 2
};

enum DirebrewActions
{
    ACTION_START_FIGHT          = -1,
    ACTION_ANTAGONIST_SAY_1     = -2,
    ACTION_ANTAGONIST_SAY_2     = -3,
    ACTION_ANTAGONIST_HOSTILE   = -4
};

enum DirebrewNpcs
{
    NPC_ILSA_DIREBREW           = 26764,
    NPC_URSULA_DIREBREW         = 26822,
    NPC_ANTAGONIST              = 23795
};

enum DirebrewSpells
{
    SPELL_MOLE_MACHINE_EMERGE           = 50313,
    SPELL_DIREBREW_DISARM_PRE_CAST      = 47407,
    SPELL_MOLE_MACHINE_TARGET_PICKER    = 47691,
    SPELL_MOLE_MACHINE_MINION_SUMMONER  = 47690,
    SPELL_DIREBREW_DISARM_GROW          = 47409,
    SPELL_DIREBREW_DISARM               = 47310,
    SPELL_CHUCK_MUG                     = 50276,
    SPELL_PORT_TO_COREN                 = 52850,
    SPELL_SEND_MUG_CONTROL_AURA         = 47369,
    SPELL_SEND_MUG_TARGET_PICKER        = 47370,
    SPELL_SEND_FIRST_MUG                = 47333,
    SPELL_SEND_SECOND_MUG               = 47339,
    SPELL_REQUEST_SECOND_MUG            = 47344,
    SPELL_HAS_DARK_BREWMAIDENS_BREW     = 47331,
    SPELL_BARRELED_CONTROL_AURA         = 50278,
    SPELL_BARRELED                      = 47442
};

enum DirebrewPhases
{
    PHASE_ALL = 1,
    PHASE_INTRO,
    PHASE_ONE,
    PHASE_TWO,
    PHASE_THREE
};

enum DirebrewEvents
{
    EVENT_INTRO_1 = 1,
    EVENT_INTRO_2,
    EVENT_INTRO_3,
    EVENT_DIREBREW_DISARM,
    EVENT_SUMMON_MOLE_MACHINE,
    EVENT_RESPAWN_ILSA,
    EVENT_RESPAWN_URSULA
};

enum DirebrewMisc
{
    GOSSIP_ID                           = 11388,
    GO_MOLE_MACHINE_TRAP                = 188509,
    GOSSIP_OPTION_FIGHT                 = 0,
    GOSSIP_OPTION_APOLOGIZE             = 1,
    DATA_TARGET_GUID                    = 1,
    MAX_ANTAGONISTS                     = 3,
    DATA_COREN                          = 33,
    GO_MACHINE_SUMMONER                 = 188508
};

Position const AntagonistPos[3] =
{
    { 895.3782f, -132.1722f, -49.66423f, 2.6529f   },
    { 893.9837f, -133.2879f, -49.66541f, 2.583087f },
    { 896.2667f, -130.483f,  -49.66249f, 2.600541f }
};

struct npc_coren_direbrew : public ScriptedAI
{
    npc_coren_direbrew(Creature* creature) : ScriptedAI(creature), _summons(me) {}

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
    {
        if (menuId != GOSSIP_ID)
        {
            return;
        }

        if (gossipListId == GOSSIP_OPTION_FIGHT)
        {
            Talk(SAY_INSULT, player);
            DoAction(ACTION_START_FIGHT);
        }
        else if (gossipListId == GOSSIP_OPTION_APOLOGIZE)
        {
            CloseGossipMenuFor(player);
        }
    }

    bool CanBeSeen(Player const* player) override
    {
        if (player->IsGameMaster())
        {
            return true;
        }

        Group const* group = player->GetGroup();
        return group && sLFGMgr->GetDungeon(group->GetGUID()) == lfg::LFG_DUNGEON_COREN_DIREBREW;
    }

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
        me->SetImmuneToPC(true);
        me->SetFaction(FACTION_FRIENDLY);
        _events.SetPhase(PHASE_ALL);

        for (uint8 i = 0; i < MAX_ANTAGONISTS; ++i)
        {
            me->SummonCreature(NPC_ANTAGONIST, AntagonistPos[i], TEMPSUMMON_DEAD_DESPAWN);
        }

        std::list<GameObject*> machines;
        GetGameObjectListWithEntryInGrid(machines, me, GO_MACHINE_SUMMONER, 60.f);
        for (GameObject* go : machines)
        {
            go->Delete();
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_events.IsInPhase(PHASE_ALL) || !who->IsPlayer())
        {
            return;
        }

        _events.SetPhase(PHASE_INTRO);
        _events.ScheduleEvent(EVENT_INTRO_1, 6s, 0, PHASE_INTRO);
        Talk(SAY_INTRO);
    }

    void JustSummoned(Creature* creature) override
    {
        _summons.Summon(creature);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_START_FIGHT)
        {
            _events.SetPhase(PHASE_ONE);
            me->SetImmuneToPC(false);
            me->SetFaction(FACTION_GOBLIN_DARK_IRON_BAR_PATRON);
            DoZoneInCombat();

            EntryCheckPredicate pred(NPC_ANTAGONIST);
            _summons.DoAction(ACTION_ANTAGONIST_HOSTILE, pred);

            _events.ScheduleEvent(EVENT_SUMMON_MOLE_MACHINE, 15s);
            _events.ScheduleEvent(EVENT_DIREBREW_DISARM, 20s);
        }
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (me->HealthBelowPctDamaged(66, damage) && _events.IsInPhase(PHASE_ONE))
        {
            _events.SetPhase(PHASE_TWO);
            SummonSister(NPC_ILSA_DIREBREW);
        }
        else if (me->HealthBelowPctDamaged(33, damage) && _events.IsInPhase(PHASE_TWO))
        {
            _events.SetPhase(PHASE_THREE);
            SummonSister(NPC_URSULA_DIREBREW);
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (summon->GetEntry() == NPC_ILSA_DIREBREW)
        {
            _events.ScheduleEvent(EVENT_RESPAWN_ILSA, 1s);
        }
        else if (summon->GetEntry() == NPC_URSULA_DIREBREW)
        {
            _events.ScheduleEvent(EVENT_RESPAWN_URSULA, 1s);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _events.Reset();
        _summons.DespawnAll();

        Map::PlayerList const& players = me->GetMap()->GetPlayers();
        if (!players.IsEmpty())
        {
            if (Group* group = players.begin()->GetSource()->GetGroup())
            {
                if (group->isLFGGroup())
                {
                    sLFGMgr->FinishDungeon(group->GetGUID(), 287, me->GetMap());
                }
            }
        }
    }

    void SummonSister(uint32 entry)
    {
        if (Creature* sister = me->SummonCreature(entry, me->GetPosition(), TEMPSUMMON_DEAD_DESPAWN))
        {
            DoZoneInCombat(sister);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() && !_events.IsInPhase(PHASE_INTRO))
        {
            return;
        }

        _events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_INTRO_1:
                    Talk(SAY_INTRO1);
                    _events.ScheduleEvent(EVENT_INTRO_2, 4s, 0, PHASE_INTRO);
                    break;
                case EVENT_INTRO_2:
                {
                    EntryCheckPredicate pred(NPC_ANTAGONIST);
                    _summons.DoAction(ACTION_ANTAGONIST_SAY_1, pred);
                    _events.ScheduleEvent(EVENT_INTRO_3, 3s, 0, PHASE_INTRO);
                    break;
                }
                case EVENT_INTRO_3:
                {
                    Talk(SAY_INTRO2);
                    EntryCheckPredicate pred(NPC_ANTAGONIST);
                    _summons.DoAction(ACTION_ANTAGONIST_SAY_2, pred);
                    break;
                }
                case EVENT_RESPAWN_ILSA:
                    SummonSister(NPC_ILSA_DIREBREW);
                    break;
                case EVENT_RESPAWN_URSULA:
                    SummonSister(NPC_URSULA_DIREBREW);
                    break;
                case EVENT_SUMMON_MOLE_MACHINE:
                {
                    me->CastCustomSpell(SPELL_MOLE_MACHINE_TARGET_PICKER, SPELLVALUE_MAX_TARGETS, 1, nullptr, true);
                    _events.RepeatEvent(15 * IN_MILLISECONDS);
                    break;
                }
                case EVENT_DIREBREW_DISARM:
                    DoCastSelf(SPELL_DIREBREW_DISARM_PRE_CAST, true);
                    _events.RepeatEvent(20 * IN_MILLISECONDS);
                    break;
                default:
                    break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    SummonList _summons;
};

struct npc_coren_direbrew_sisters : public ScriptedAI
{
    npc_coren_direbrew_sisters(Creature* creature) : ScriptedAI(creature) { }

    void SetGUID(ObjectGuid guid, int32 id) override
    {
        if (id == DATA_TARGET_GUID)
        {
            _targetGUID = guid;
        }
    }

    ObjectGuid GetGUID(int32 data) const override
    {
        if (data == DATA_TARGET_GUID)
        {
            return _targetGUID;
        }

        return ObjectGuid::Empty;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoCastSelf(SPELL_PORT_TO_COREN);

        if (me->GetEntry() == NPC_URSULA_DIREBREW)
        {
            DoCastSelf(SPELL_BARRELED_CONTROL_AURA);
        }
        else
        {
            DoCastSelf(SPELL_SEND_MUG_CONTROL_AURA);
        }

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        })
        .Schedule(Seconds(2), [this](TaskContext mugChuck)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, false, true, -SPELL_HAS_DARK_BREWMAIDENS_BREW))
            {
                DoCast(target, SPELL_CHUCK_MUG);
            }

            mugChuck.Repeat(Seconds(4));
        });
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

private:
    ObjectGuid _targetGUID;
    TaskScheduler _scheduler;
};

struct npc_direbrew_minion : public ScriptedAI
{
    npc_direbrew_minion(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

    void Reset() override
    {
        me->SetFaction(FACTION_GOBLIN_DARK_IRON_BAR_PATRON);
        DoZoneInCombat();
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        if (Creature* coren = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_COREN)))
        {
            coren->AI()->JustSummoned(me);
        }
    }

private:
    InstanceScript* _instance;
};

struct npc_direbrew_antagonist : public ScriptedAI
{
    npc_direbrew_antagonist(Creature* creature) : ScriptedAI(creature) {}

    void DoAction(int32 action) override
    {
        switch (action)
        {
            case ACTION_ANTAGONIST_SAY_1:
                Talk(SAY_ANTAGONIST_1);
                break;
            case ACTION_ANTAGONIST_SAY_2:
                Talk(SAY_ANTAGONIST_2);
                break;
            case ACTION_ANTAGONIST_HOSTILE:
                me->SetImmuneToPC(false);
                me->SetFaction(FACTION_GOBLIN_DARK_IRON_BAR_PATRON);
                DoZoneInCombat();
                break;
            default:
                break;
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_ANTAGONIST_COMBAT, who);
        ScriptedAI::JustEngagedWith(who);
    }
};

class go_direbrew_mole_machine : public GameObjectScript
{
public:
    go_direbrew_mole_machine() : GameObjectScript("go_direbrew_mole_machine") { }

    struct go_direbrew_mole_machineAI : public GameObjectAI
    {
        go_direbrew_mole_machineAI(GameObject* go) : GameObjectAI(go) { }

        void Reset() override
        {
            me->SetLootState(GO_READY);

            _scheduler.Schedule(Seconds(1), [this](TaskContext /*context*/)
            {
                me->UseDoorOrButton();
                me->CastSpell(nullptr, SPELL_MOLE_MACHINE_EMERGE);
            })
            .Schedule(Seconds(4), [this](TaskContext /*context*/)
            {
            if (GameObject* trap = me->GetLinkedTrap())
                {
                    trap->UseDoorOrButton();
                    trap->SetLootState(GO_READY);
                }
            });
        }

        void UpdateAI(uint32 diff) override
        {
            _scheduler.Update(diff);
        }

    private:
        TaskScheduler _scheduler;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_direbrew_mole_machineAI(go);
    }
};

// 47691 - Summon Mole Machine Target Picker
class spell_direbrew_summon_mole_machine_target_picker : public SpellScript
{
    PrepareSpellScript(spell_direbrew_summon_mole_machine_target_picker);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MOLE_MACHINE_MINION_SUMMONER });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), SPELL_MOLE_MACHINE_MINION_SUMMONER, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_direbrew_summon_mole_machine_target_picker::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 47370 - Send Mug Target Picker
class spell_send_mug_target_picker: public SpellScript
{
    PrepareSpellScript(spell_send_mug_target_picker);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();

        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_HAS_DARK_BREWMAIDENS_BREW));

        if (targets.size() > 1)
        {
            targets.remove_if([caster](WorldObject* obj)
            {
                if (obj->GetGUID() == caster->GetAI()->GetGUID(DATA_TARGET_GUID))
                {
                    return true;
                }

                return false;
            });
        }

        if (targets.empty())
        {
            return;
        }

        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        caster->GetAI()->SetGUID(GetHitUnit()->GetGUID(), DATA_TARGET_GUID);
        caster->CastSpell(GetHitUnit(), SPELL_SEND_FIRST_MUG, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_send_mug_target_picker::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_send_mug_target_picker::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 47344 - Request Second Mug
class spell_request_second_mug : public SpellScript
{
    PrepareSpellScript(spell_request_second_mug);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SEND_SECOND_MUG });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetCaster(), SPELL_SEND_SECOND_MUG, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_request_second_mug::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 47369 - Send Mug Control Aura
class spell_send_mug_control_aura : public AuraScript
{
    PrepareAuraScript(spell_send_mug_control_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SEND_MUG_TARGET_PICKER });
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_SEND_MUG_TARGET_PICKER, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_send_mug_control_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 50278 - Barreled Control Aura
    class spell_barreled_control_aura : public AuraScript
    {
        PrepareAuraScript(spell_barreled_control_aura);

        void PeriodicTick(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();
            GetTarget()->CastSpell(nullptr, SPELL_BARRELED);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_barreled_control_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

// 47407 - Direbrew's Disarm (precast)
class spell_direbrew_disarm : public AuraScript
{
    PrepareAuraScript(spell_direbrew_disarm);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DIREBREW_DISARM, SPELL_DIREBREW_DISARM_GROW });
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        if (Aura* aura = GetTarget()->GetAura(SPELL_DIREBREW_DISARM_GROW))
        {
            aura->SetStackAmount(aura->GetStackAmount() + 1);
            aura->SetDuration(aura->GetDuration() - 1500);
        }
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_DIREBREW_DISARM_GROW, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_DIREBREW_DISARM);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_direbrew_disarm::PeriodicTick, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectApply += AuraEffectRemoveFn(spell_direbrew_disarm::OnApply, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_event_brewfest_scripts()
{
    // Npcs
    RegisterCreatureAI(npc_brewfest_keg_thrower);
    RegisterCreatureAI(npc_brewfest_keg_reciver);
    RegisterCreatureAI(npc_brewfest_bark_trigger);
    RegisterCreatureAI(npc_dark_iron_attack_generator);
    RegisterCreatureAI(npc_dark_iron_attack_mole_machine);
    RegisterCreatureAI(npc_dark_iron_guzzler);
    RegisterCreatureAI(npc_brewfest_super_brew_trigger);

    // Spells
    // ram
    RegisterSpellScript(spell_brewfest_main_ram_buff);
    RegisterSpellScript(spell_brewfest_ram_fatigue);
    RegisterSpellScript(spell_brewfest_apple_trap);
    // other
    RegisterSpellScript(spell_catch_the_wild_wolpertinger);
    RegisterSpellScript(spell_brewfest_fill_keg);
    RegisterSpellScript(spell_brewfest_unfill_keg);
    RegisterSpellScript(spell_brewfest_toss_mug);
    RegisterSpellScript(spell_brewfest_add_mug);
    RegisterSpellScript(spell_brewfest_reveler_transform);
    RegisterSpellScript(spell_brewfest_relay_race_force_cast);

    // beer effect
    RegisterCreatureAI(npc_brew_bubble);

    // Coren Direbrew
    RegisterCreatureAI(npc_coren_direbrew);
    RegisterCreatureAI(npc_coren_direbrew_sisters);
    RegisterCreatureAI(npc_direbrew_minion);
    RegisterCreatureAI(npc_direbrew_antagonist);
    new go_direbrew_mole_machine();
    RegisterSpellScript(spell_direbrew_summon_mole_machine_target_picker);
    RegisterSpellScript(spell_send_mug_target_picker);
    RegisterSpellScript(spell_request_second_mug);
    RegisterSpellScript(spell_send_mug_control_aura);
    RegisterSpellScript(spell_barreled_control_aura);
    RegisterSpellScript(spell_direbrew_disarm);
}
