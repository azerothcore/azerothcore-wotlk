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
#include "GameObjectScript.h"
#include "Group.h"
#include "LFGMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "the_slave_pens.h"

#define GOSSIP_TEXT_ID          15864
#define QUEST_SUMMON_AHUNE      11691
#define ITEM_MAGMA_TOTEM        34953
#define AHUNE_DEFAULT_MODEL     23344

const Position AhuneSummonPos = {-97.3473f, -233.139f, -1.27587f, M_PI / 2};
const Position TotemPos[3] = { {-115.141f, -143.317f, -2.09467f, 4.92772f}, {-120.178f, -144.398f, -2.23786f, 4.92379f}, {-125.277f, -145.463f, -1.95209f, 4.97877f} };
const Position MinionSummonPos = {-97.154404f, -204.382675f, -1.19f, M_PI / 2};

enum Text
{
    EMOTE_RETREAT               = 0,
    EMOTE_RESURFACE             = 1,
};

enum EventSpells
{
    SPELL_STARTING_BEAM         = 46593,
    SPELL_MAKE_BONFIRE          = 45930,
    SPELL_TOTEM_BEAM            = 46363,
    SPELL_SELF_STUN             = 46416,
    SPELL_EMERGE_0              = 66947,
    SPELL_SUBMERGE_0            = 37550,
    SPELL_AHUNE_RESURFACES      = 46402,

    SPELL_AHUNES_SHIELD         = 45954,
    SPELL_COLD_SLAP             = 46198,
    SPELL_SUMMON_HAILSTONE      = 45951,
    SPELL_SUMMON_COLDWAVE       = 45952,
    SPELL_SUMMON_FROSTWIND      = 45953,

    SPELL_CHILLING_AURA         = 46542,

    /*
    SPELL_SUMMON_ICE_SPEAR_BUNNY= 46359, // any dest
    SPELL_ICE_SPEAR_KNOCKBACK   = 46360, // src caster
    SPELL_ICE_SPEAR_SUMMON_OBJ  = 46369,
    SPELL_ICE_SPEAR_CONTROL_AURA= 46371, // periodic dummy
    */
};

enum CreatureIds
{
    NPC_AHUNITE_HAILSTONE = 25755
};

enum eEvents
{
    EVENT_EMERGE = 1,
    EVENT_INVOKER_SAY_1,
    EVENT_INVOKER_SAY_2,
    EVENT_INVOKER_SAY_3,
    EVENT_SUMMON_TOTEMS,
    EVENT_ATTACK,
    EVENT_TOTEMS_ATTACK,
    EVENT_SUBMERGE,
    EVENT_COMBAT_EMERGE,
    EVENT_EMERGE_WARNING,

    EVENT_SPELL_COLD_SLAP,
    EVENT_SPELL_SUMMON_HAILSTONE,
    EVENT_SPELL_SUMMON_COLDWAVE,
};

enum Misc
{
    SET_GUID_INVOKER = 1
};

struct boss_ahune : public ScriptedAI
{
    boss_ahune(Creature* c) : ScriptedAI(c), summons(me)
    {
        me->SetCombatMovement(false);
        SetEquipmentSlots(false, 54806, EQUIP_UNEQUIP, EQUIP_UNEQUIP);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        InvokerGUID.Clear();
        events.Reset();
        events.RescheduleEvent(EVENT_EMERGE, 12000);
        events.RescheduleEvent(EVENT_INVOKER_SAY_1, 1000);
        events.RescheduleEvent(EVENT_SUMMON_TOTEMS, 4000);
    }

    EventMap events;
    SummonList summons;
    ObjectGuid InvokerGUID;

    void StartPhase1()
    {
        me->CastSpell(me, SPELL_AHUNES_SHIELD, true);
        events.RescheduleEvent(EVENT_TOTEMS_ATTACK, 80000);
        events.RescheduleEvent(EVENT_SPELL_COLD_SLAP, 1200);
        events.RescheduleEvent(EVENT_SPELL_SUMMON_HAILSTONE, 2000);
        events.RescheduleEvent(EVENT_SPELL_SUMMON_COLDWAVE, 5000);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoZoneInCombat();
        events.Reset();
        StartPhase1();
    }

    void SetGUID(ObjectGuid guid, int32 id) override
    {
        if (id == SET_GUID_INVOKER)
        {
            InvokerGUID = guid;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() && !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
        case 0:
            break;
        case EVENT_EMERGE:
            me->SetVisible(true);
            me->CastSpell(me, SPELL_EMERGE_0, false);
            events.RescheduleEvent(EVENT_ATTACK, 2000);
            break;
        case EVENT_SUMMON_TOTEMS:
            for (uint8 i = 0; i < 3; ++i)
                DoSummon(NPC_TOTEM, TotemPos[i], 10 * 60 * 1000, TEMPSUMMON_TIMED_DESPAWN);
            break;
        case EVENT_INVOKER_SAY_1:
            if (Player* plr = ObjectAccessor::GetPlayer(*me, InvokerGUID))
            {
                plr->Say("The Ice Stone has melted!", LANG_UNIVERSAL);
                plr->CastSpell(plr, SPELL_MAKE_BONFIRE, true);
            }
            events.RescheduleEvent(EVENT_INVOKER_SAY_2, 2000);
            break;
        case EVENT_INVOKER_SAY_2:
            if (Player* plr = ObjectAccessor::GetPlayer(*me, InvokerGUID))
                plr->Say("Ahune, your strength grows no more!", LANG_UNIVERSAL);
            events.RescheduleEvent(EVENT_INVOKER_SAY_3, 2000);
            break;
        case EVENT_INVOKER_SAY_3:
            if (Player* plr = ObjectAccessor::GetPlayer(*me, InvokerGUID))
                plr->Say("Your frozen reign will not come to pass!", LANG_UNIVERSAL);
            break;
        case EVENT_ATTACK:
            events.Reset();
            if (Player* plr = ObjectAccessor::GetPlayer(*me, InvokerGUID))
                AttackStart(plr);
            me->SetInCombatWithZone();
            if (!me->IsInCombat())
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }
            else
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            break;
        case EVENT_TOTEMS_ATTACK:
            for (uint8 i = 0; i < 3; ++i)
                if (Creature* bunny = me->FindNearestCreature(NPC_TOTEM_BUNNY_1 + i, 150.0f, true))
                    bunny->CastSpell(me, SPELL_TOTEM_BEAM, false);
            events.RescheduleEvent(EVENT_SUBMERGE, 10000);
            break;
        case EVENT_SUBMERGE:
            Talk(EMOTE_RETREAT);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->CastSpell(me, SPELL_SUBMERGE_0, true);
            me->CastSpell(me, SPELL_SELF_STUN, true);
            if (Creature* c = DoSummon(NPC_FROZEN_CORE, *me, 24000, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN))
            {
                c->SetHealth(me->GetHealth());
            }
            events.Reset();
            events.RescheduleEvent(EVENT_COMBAT_EMERGE, 25000);
            events.RescheduleEvent(EVENT_EMERGE_WARNING, 20000);
            break;
        case EVENT_EMERGE_WARNING:
            Talk(EMOTE_RESURFACE);
            break;
        case EVENT_COMBAT_EMERGE:
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveAura(SPELL_SELF_STUN);
            me->CastSpell(me, SPELL_EMERGE_0, false);
            // me->CastSpell(me, SPELL_AHUNE_RESURFACES, true); // done in SummonedCreatureDespawn
            me->RemoveAura(SPELL_SUBMERGE_0);
            summons.DespawnEntry(NPC_FROZEN_CORE);
            StartPhase1();
            break;

        case EVENT_SPELL_COLD_SLAP:
            if (Unit* target = SelectTarget(SelectTargetMethod::MaxDistance, 0, 5.0f, true))
                if (target->GetPositionZ() < me->GetPositionZ() + 6.0f)
                {
                    int32 dmg = urand(5500, 6000);
                    me->CastCustomSpell(target, SPELL_COLD_SLAP, &dmg, nullptr, nullptr, false);
                    float x, y, z;
                    target->GetNearPoint(target, x, y, z, target->GetObjectSize(), 30.0f, target->GetAngle(me->GetPositionX(), me->GetPositionY()) + M_PI);
                    target->GetMotionMaster()->MoveJump(x, y, z + 20.0f, 10.0f, 20.0f);
                }
            events.RepeatEvent(1500);
            break;
        case EVENT_SPELL_SUMMON_HAILSTONE:
        {
            float dist = (float)urand(3, 10);
            float angle = rand_norm() * 2 * M_PI;
            me->CastSpell(MinionSummonPos.GetPositionX() + cos(angle) * dist, MinionSummonPos.GetPositionY() + std::sin(angle) * dist, MinionSummonPos.GetPositionZ(), SPELL_SUMMON_HAILSTONE, false);
        }
        break;
        case EVENT_SPELL_SUMMON_COLDWAVE:
            for (uint8 i = 0; i < 2; ++i)
            {
                float dist = (float)urand(3, 10);
                float angle = rand_norm() * 2 * M_PI;
                me->CastSpell(MinionSummonPos.GetPositionX() + cos(angle) * dist, MinionSummonPos.GetPositionY() + std::sin(angle) * dist, MinionSummonPos.GetPositionZ(), SPELL_SUMMON_COLDWAVE, false);
            }
            {
                float dist = (float)urand(3, 10);
                float angle = rand_norm() * 2 * M_PI;
                me->CastSpell(MinionSummonPos.GetPositionX() + cos(angle) * dist, MinionSummonPos.GetPositionY() + std::sin(angle) * dist, MinionSummonPos.GetPositionZ(), SPELL_SUMMON_FROSTWIND, false);
            }
            events.RepeatEvent(12000);
            break;

        default:
            break;
        }

        DoMeleeAttackIfReady();
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        events.Reset();
        summons.DespawnAll();
        me->DespawnOrUnsummon(1);

        ScriptedAI::EnterEvadeMode(why);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        summon->SetInCombatWithZone();

        if (summon->GetEntry() == NPC_AHUNITE_HAILSTONE)
        {
            // Doesn't work when cast normally or when added to
            // creature template addon. Needs further investigation.
            if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_CHILLING_AURA))
            {
                Aura::TryRefreshStackOrCreate(spellInfo, MAX_EFFECT_MASK, summon, summon);
            }
        }
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        if (summon && summon->GetEntry() == NPC_FROZEN_CORE)
        {
            if (summon->GetHealth() > 0)
            {
                me->SetHealth(summon->GetHealth());
                summon->CastSpell(summon, SPELL_AHUNE_RESURFACES, true);
            }
            else
                Unit::Kill(me, me, false);
        }
    }

    void JustDied(Unit*  /*killer*/) override
    {
        summons.DespawnAll();
        me->DespawnOrUnsummon(15000);
        if (GameObject* chest = me->SummonGameObject(187892, MinionSummonPos.GetPositionX(), MinionSummonPos.GetPositionY(), MinionSummonPos.GetPositionZ(), M_PI / 2, 0.0f, 0.0f, 0.0f, 0.0f, 900000000)) // loot
            me->RemoveGameObject(chest, false);

        bool finished = false;

        me->GetMap()->DoForAllPlayers([&](Player* player)
        {
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, 25740, 1, me);

            if (player->GetGroup() && !finished)
            {
                finished = true;
                sLFGMgr->FinishDungeon(player->GetGroup()->GetGUID(), lfg::LFG_DUNGEON_FROST_LORD_AHUNE, me->FindMap());
            }
        });
    }
};

class go_ahune_ice_stone : public GameObjectScript
{
public:
    go_ahune_ice_stone() : GameObjectScript("go_ahune_ice_stone") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player || !go)
            return true;

        if (!player->IsGameMaster())
        {
            if (Group const* group = player->GetGroup())
            {
                if (sLFGMgr->GetDungeon(group->GetGUID()) != lfg::LFG_DUNGEON_FROST_LORD_AHUNE)
                {
                    return true;
                }
            }
        }

        if (go->FindNearestCreature(NPC_AHUNE, 200.0f, true))
            return true;

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Disturb the stone and summon Lord Ahune.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
        SendGossipMenuFor(player, GOSSIP_TEXT_ID, go->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 action) override
    {
        if (!player || !go)
            return true;

        if (!player->IsGameMaster())
        {
            if (Group const* group = player->GetGroup())
            {
                if (sLFGMgr->GetDungeon(group->GetGUID()) != lfg::LFG_DUNGEON_FROST_LORD_AHUNE)
                {
                    return true;
                }
            }
        }

        if (action != GOSSIP_ACTION_INFO_DEF + 1337)
            return true;
        if (go->FindNearestCreature(NPC_AHUNE, 200.0f, true))
            return true;

        if (Creature* c = go->SummonCreature(NPC_AHUNE, AhuneSummonPos, TEMPSUMMON_MANUAL_DESPAWN))
        {
            player->DestroyItemCount(ITEM_MAGMA_TOTEM, 1, true, false);
            player->AreaExploredOrEventHappens(QUEST_SUMMON_AHUNE); // auto rewarded

            c->SetVisible(false);
            c->SetDisplayId(AHUNE_DEFAULT_MODEL);
            c->SetFloatValue(UNIT_FIELD_COMBATREACH, 18.0f);
            if (c->AI())
            {
                c->AI()->SetGUID(player->GetGUID(), SET_GUID_INVOKER);
            }

            if (Creature* bunny = go->SummonCreature(NPC_AHUNE_SUMMON_LOC_BUNNY, AhuneSummonPos, TEMPSUMMON_TIMED_DESPAWN, 12000))
                if (Creature* crystal_trigger = go->SummonCreature(WORLD_TRIGGER, go->GetPositionX(), go->GetPositionY(), 5.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 12000))
                    crystal_trigger->CastSpell(bunny, SPELL_STARTING_BEAM, false);
        }

        CloseGossipMenuFor(player);
        return true;
    }
};

void AddSC_boss_ahune()
{
    new go_ahune_ice_stone();
    RegisterTheSlavePensCreatureAI(boss_ahune);
}

