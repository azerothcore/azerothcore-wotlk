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
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GossipDef.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "LFGMgr.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

///////////////////////////////////////
////// ITEMS FIXES, BASIC STUFF
///////////////////////////////////////

enum eTrickSpells
{
    SPELL_PIRATE_COSTUME_MALE           = 24708,
    SPELL_PIRATE_COSTUME_FEMALE         = 24709,
    SPELL_NINJA_COSTUME_MALE            = 24710,
    SPELL_NINJA_COSTUME_FEMALE          = 24711,
    SPELL_LEPER_GNOME_COSTUME_MALE      = 24712,
    SPELL_LEPER_GNOME_COSTUME_FEMALE    = 24713,
    SPELL_SKELETON_COSTUME              = 24723,
    SPELL_BAT_COSTUME                   = 24732,
    SPELL_GHOST_COSTUME_MALE            = 24735,
    SPELL_GHOST_COSTUME_FEMALE          = 24736,
    SPELL_WHISP_COSTUME                 = 24740,
    SPELL_TRICK_BUFF                    = 24753,
};

class spell_hallows_end_trick : public SpellScript
{
    PrepareSpellScript(spell_hallows_end_trick);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            uint8 gender = target->getGender();
            uint32 spellId = SPELL_TRICK_BUFF;
            switch (urand(0, 7))
            {
                case 1:
                    spellId = gender ? SPELL_LEPER_GNOME_COSTUME_FEMALE : SPELL_LEPER_GNOME_COSTUME_MALE;
                    break;
                case 2:
                    spellId = gender ? SPELL_PIRATE_COSTUME_FEMALE : SPELL_PIRATE_COSTUME_MALE;
                    break;
                case 3:
                    spellId = gender ? SPELL_GHOST_COSTUME_FEMALE : SPELL_GHOST_COSTUME_MALE;
                    break;
                case 4:
                    spellId = gender ? SPELL_NINJA_COSTUME_FEMALE : SPELL_NINJA_COSTUME_MALE;
                    break;
                case 5:
                    spellId = SPELL_SKELETON_COSTUME;
                    break;
                case 6:
                    spellId = SPELL_BAT_COSTUME;
                    break;
                case 7:
                    spellId = SPELL_WHISP_COSTUME;
                    break;
                default:
                    break;
            }

            GetCaster()->CastSpell(target, spellId, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hallows_end_trick::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_hallows_end_put_costume : public SpellScript
{
public:
    spell_hallows_end_put_costume(uint32 maleSpell, uint32 femaleSpell) : _maleSpell(maleSpell), _femaleSpell(femaleSpell) { }

    PrepareSpellScript(spell_hallows_end_put_costume);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
            GetCaster()->CastSpell(target, target->getGender() ? _femaleSpell : _maleSpell, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hallows_end_put_costume::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }

private:
    uint32 _maleSpell;
    uint32 _femaleSpell;
};

// 24751 Trick or Treat
enum eTrickOrTreatSpells
{
    SPELL_TRICK                 = 24714,
    SPELL_TREAT                 = 24715,
    SPELL_TRICKED_OR_TREATED    = 24755
};

    class spell_hallows_end_trick_or_treat : public SpellScript
    {
        PrepareSpellScript(spell_hallows_end_trick_or_treat);

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            if (Player* target = GetHitPlayer())
            {
                GetCaster()->CastSpell(target, roll_chance_i(50) ? SPELL_TRICK : SPELL_TREAT, true, nullptr);
                GetCaster()->CastSpell(target, SPELL_TRICKED_OR_TREATED, true, nullptr);
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_hallows_end_trick_or_treat::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

enum eHallowsEndCandy
{
    SPELL_HALLOWS_END_CANDY_1               = 24924,
    SPELL_HALLOWS_END_CANDY_2               = 24925,
    SPELL_HALLOWS_END_CANDY_3               = 24926,
    SPELL_HALLOWS_END_CANDY_3_FEMALE        = 44742,
    SPELL_HALLOWS_END_CANDY_3_MALE          = 44743,
    SPELL_HALLOWS_END_CANDY_4               = 24927
};

class spell_hallows_end_candy : public SpellScript
{
    PrepareSpellScript(spell_hallows_end_candy);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            uint32 spellId = SPELL_HALLOWS_END_CANDY_1 + urand(0, 3);
            GetCaster()->CastSpell(target, spellId, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hallows_end_candy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_hallows_end_candy_pirate_costume : public AuraScript
{
    PrepareAuraScript(spell_hallows_end_candy_pirate_costume);

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            target->CastSpell(target, target->getGender() == GENDER_MALE ? SPELL_HALLOWS_END_CANDY_3_MALE : SPELL_HALLOWS_END_CANDY_3_FEMALE, true);
        }
    }

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            target->RemoveAurasDueToSpell(SPELL_HALLOWS_END_CANDY_3_MALE);
            target->RemoveAurasDueToSpell(SPELL_HALLOWS_END_CANDY_3_FEMALE);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_hallows_end_candy_pirate_costume::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_INCREASE_SWIM_SPEED, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_hallows_end_candy_pirate_costume::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_INCREASE_SWIM_SPEED, AURA_EFFECT_HANDLE_REAL);
    }
};

enum trickyTreat
{
    SPELL_UPSET_TUMMY               = 42966,
};

class spell_hallows_end_tricky_treat : public SpellScript
{
    PrepareSpellScript(spell_hallows_end_tricky_treat);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            if (roll_chance_i(20))
                target->CastSpell(target, SPELL_UPSET_TUMMY, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hallows_end_tricky_treat::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

///////////////////////////////////////
////// SHADE OF THE HORSEMAN EVENT
///////////////////////////////////////

enum costumedOrphan
{
    // Quests
    QUEST_LET_THE_FIRES_COME_A              = 12135,
    QUEST_LET_THE_FIRES_COME_H              = 12139,
    QUEST_STOP_THE_FIRES_A                  = 11131,
    QUEST_STOP_THE_FIRES_H                  = 11219,

    // Spells
    SPELL_HORSEMAN_MOUNT                    = 48025,
    SPELL_FIRE_AURA_BASE                    = 42074,
    SPELL_START_FIRE                        = 42132,
    SPELL_SPREAD_FIRE                       = 42079,
    SPELL_CREATE_BUCKET                     = 42349,
    SPELL_WATER_SPLASH                      = 42348,
    SPELL_SUMMON_LANTERN                    = 44255,
    SPELL_HORSEMAN_CONFLAGRATION            = 42380,
    SPELL_HORSEMAN_CONFLAGRATION_SOUND      = 48149,
    SPELL_HORSEMAN_CLEAVE                   = 42587,

    // NPCs
    NPC_SHADE_OF_HORSEMAN                   = 23543,
    NPC_FIRE_TRIGGER                        = 23686,
    NPC_ALLIANCE_MATRON                     = 24519,

    // Actions
    ACTION_START_EVENT                      = 1,

    // Talks
    TALK_SHADE_CONFLAGRATION                = 0,
    TALK_SHADE_PREPARE                      = 1,
    TALK_SHADE_START_EVENT                  = 2,
    TALK_SHADE_MORE_FIRES                   = 3,
    TALK_SHADE_FAILED                       = 4,
    TALK_SHADE_DEFEATED                     = 5,
    TALK_SHADE_DEATH                        = 6,
};

class spell_hallows_end_bucket_lands : public SpellScript
{
    PrepareSpellScript(spell_hallows_end_bucket_lands);

    bool handled;
    bool Load() override { handled = false; return true; }
    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (handled || !GetCaster())
            return;

        handled = true;
        if (Player* target = GetHitPlayer())
            GetCaster()->CastSpell(target, SPELL_CREATE_BUCKET, true);
        else if (Unit* tgt = GetHitUnit())
            GetCaster()->CastSpell(tgt, SPELL_WATER_SPLASH, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hallows_end_bucket_lands::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_hallows_end_base_fire : public AuraScript
{
    PrepareAuraScript(spell_hallows_end_base_fire);

    void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& /*isPeriodic*/, int32& amplitude)
    {
        if (Creature* creature = GetCaster()->ToCreature())
        {
            if (!(creature->AI()->GetData(0) % 3))
            {
                amplitude = static_cast<int32>(amplitude * 1.5f);
            }
        }
    }

    void HandleEffectPeriodicUpdate(AuraEffect* aurEff)
    {
        // can start from 0
        int32 amount = aurEff->GetAmount();

        if (amount < 3)
            amount++;
        else if (aurEff->GetTickNumber() % 3 != 2)
            return;

        aurEff->SetAmount(amount);
        if (Unit* owner = GetUnitOwner())
        {
            if (amount <= 3)
                owner->SetObjectScale(amount / 2.0f);
            if (amount >= 3)
                owner->CastSpell(owner, SPELL_SPREAD_FIRE, true);
        }
    }

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetObjectScale(1.0f);
        if (AuraEffect* aEff = GetEffect(EFFECT_0))
            aEff->SetAmount(1);
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_hallows_end_base_fire::CalcPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_hallows_end_base_fire::HandleEffectPeriodicUpdate, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectApply += AuraEffectApplyFn(spell_hallows_end_base_fire::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

struct npc_costumed_orphan_matron : public ScriptedAI
{
    npc_costumed_orphan_matron(Creature* c) : ScriptedAI(c) {}

    uint32 eventStarted;
    bool allowQuest;
    ObjectGuid horseGUID;

    void Reset() override
    {
        eventStarted = 0;
        allowQuest = false;
        horseGUID.Clear();
    }

    void GetInitXYZ(float& x, float& y, float& z, float& o, uint32& path)
    {
        switch (me->GetAreaId())
        {
        case 87: // Goldshire
            x = -9494.4f;
            y = 48.53f;
            z = 70.5f;
            o = 0.5f;
            path = 235431;
            break;
        case 131: // Kharanos
            x = -5558.34f;
            y = -499.46f;
            z = 414.12f;
            o = 2.08f;
            path = 235432;
            break;
        case 3576: // Azure Watch
            x = -4163.58f;
            y = -12460.30f;
            z = 63.02f;
            o = 4.31f;
            path = 235433;
            break;
        case 362: // Razor Hill
            x = 373.2f;
            y = -4723.4f;
            z = 31.2f;
            o = 3.2f;
            path = 235434;
            break;
        case 159: // Brill
            x = 2195.2f;
            y = 264.0f;
            z = 55.62f;
            o = 0.15f;
            path = 235435;
            break;
        case 3665: // Falcon Wing Square
            x = 9547.91f;
            y = -6809.9f;
            z = 27.96f;
            o = 3.4f;
            path = 235436;
            break;
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_START_EVENT)
        {
            allowQuest = true;
            eventStarted = 1;
            float x = 0, y = 0, z = 0, o = 0;
            uint32 path = 0;
            GetInitXYZ(x, y, z, o, path);
            if (Creature* cr = me->SummonCreature(NPC_SHADE_OF_HORSEMAN, x, y, z, o, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
            {
                cr->GetMotionMaster()->MovePath(path, true);
                cr->AI()->DoAction(path);
                horseGUID = cr->GetGUID();
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (eventStarted)
        {
            eventStarted += diff;
            if (eventStarted >= 400 * IN_MILLISECONDS)
            {
                allowQuest = false;
                eventStarted = 0;
            }
        }
    }

    void sGossipHello(Player* player) override
    {
        QuestRelationBounds pObjectQR = sObjectMgr->GetCreatureQuestRelationBounds(me->GetEntry());
        QuestRelationBounds pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(me->GetEntry());

        QuestMenu& qm = player->PlayerTalkClass->GetQuestMenu();
        qm.ClearMenu();

        for (QuestRelations::const_iterator i = pObjectQIR.first; i != pObjectQIR.second; ++i)
        {
            uint32 quest_id = i->second;
            QuestStatus status = player->GetQuestStatus(quest_id);
            if (status == QUEST_STATUS_COMPLETE)
            {
                qm.AddMenuItem(quest_id, 4);
            }
            else if (status == QUEST_STATUS_INCOMPLETE)
            {
                qm.AddMenuItem(quest_id, 4);
            }
        }

        for (QuestRelations::const_iterator i = pObjectQR.first; i != pObjectQR.second; ++i)
        {
            uint32 quest_id = i->second;
            Quest const* pQuest = sObjectMgr->GetQuestTemplate(quest_id);
            if (!pQuest)
            {
                continue;
            }

            if (!player->CanTakeQuest(pQuest, false))
            {
                continue;
            }
            else if (player->GetQuestStatus(quest_id) == QUEST_STATUS_NONE)
            {
                switch (quest_id)
                {
                    case QUEST_LET_THE_FIRES_COME_A:
                    case QUEST_LET_THE_FIRES_COME_H:
                        if (!allowQuest)
                        {
                            qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    case QUEST_STOP_THE_FIRES_A:
                    case QUEST_STOP_THE_FIRES_H:
                        if (allowQuest)
                        {
                            qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    default:
                        qm.AddMenuItem(quest_id, 2);
                        break;
                }
            }
        }

        player->SendPreparedQuest(me->GetGUID());
    }

    void sQuestAccept(Player*  /*player*/, Quest const* quest) override
    {
        if ((quest->GetQuestId() == QUEST_LET_THE_FIRES_COME_A || quest->GetQuestId() == QUEST_LET_THE_FIRES_COME_H) && !allowQuest)
        {
            DoAction(ACTION_START_EVENT);
        }
    }
};

struct npc_soh_fire_trigger : public NullCreatureAI
{
    npc_soh_fire_trigger(Creature* creature) : NullCreatureAI(creature) { }

    void Reset() override
    {
        me->SetDisableGravity(true);
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_START_FIRE)
        {
            me->CastSpell(me, SPELL_FIRE_AURA_BASE, true);
            if (AuraEffect* aurEff = me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
            {
                int32 amount = 1;
                if (Creature* creature = caster->ToCreature())
                {
                    if ((creature->AI()->GetData(0) % 3) > 0)
                    {
                        amount = 2;
                    }
                }

                me->SetObjectScale(0.5f + 0.5f * amount);
                aurEff->SetAmount(amount);
            }
        }
        else if (spellInfo->Id == SPELL_SPREAD_FIRE)
        {
            me->CastSpell(me, SPELL_FIRE_AURA_BASE, true);
            if (AuraEffect* aurEff = me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
            {
                int32 amount = 0;
                if (Creature* creature = caster->ToCreature())
                {
                    if ((creature->AI()->GetData(0) % 3) > 1)
                    {
                        amount = 1;
                    }
                }

                me->SetObjectScale(0.5f + 0.5f * amount);
                aurEff->SetAmount(amount);
            }
        }
        else if (spellInfo->Id == SPELL_WATER_SPLASH)
        {
            if (AuraEffect* aurEff = me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
            {
                int32 amt = aurEff->GetAmount();
                if (amt > 2)
                {
                    aurEff->ResetPeriodic(true);
                    aurEff->SetAmount(amt - 2);
                }
                else
                    me->RemoveAllAuras();
            }
        }
    }
};

struct npc_hallows_end_soh : public ScriptedAI
{
    npc_hallows_end_soh(Creature* creature) : ScriptedAI(creature)
    {
        pos = 0;
        counter = 0;
        unitList.clear();
        me->CastSpell(me, SPELL_HORSEMAN_MOUNT, true);
        me->SetSpeed(MOVE_WALK, 3.0f, true);
    }

    EventMap events;
    uint32 playerCount;
    uint32 counter;
    GuidList unitList;
    int32 pos;
    TaskScheduler scheduler;

    void JustEngagedWith(Unit*) override
    {
        scheduler.Schedule(6s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.f, true))
            {
                me->CastSpell(target, SPELL_HORSEMAN_CONFLAGRATION, false);
                target->CastSpell(target, SPELL_HORSEMAN_CONFLAGRATION_SOUND, true);
                Talk(TALK_SHADE_CONFLAGRATION);
            }

            context.Repeat(12s);
        })
        .Schedule(7s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_HORSEMAN_CLEAVE, true);

            context.Repeat(8s);
        });
    }

    void MoveInLineOfSight(Unit*  /*who*/) override {}

    void DoAction(int32 param) override
    {
        pos = param;
    }

    void GetPosToLand(float& x, float& y, float& z)
    {
        switch (pos)
        {
            case 235431:
                x = -9445.1f;
                y = 63.27f;
                z = 58.16f;
                break;
            case 235432:
                x = -5616.30f;
                y = -481.89f;
                z = 398.99f;
                break;
            case 235433:
                x = -4198.1f;
                y = -12509.13f;
                z = 46.6f;
                break;
            case 235434:
                x = 360.9f;
                y = -4735.5f;
                z = 11.773f;
                break;
            case 235435:
                x = 2229.4f;
                y = 263.1f;
                z = 36.13f;
                break;
            case 235436:
                x = 9532.9f;
                y = -6833.8f;
                z = 18.5f;
                break;
            default:
                x = 0;
                y = 0;
                z = 0;
                break;
        }
    }

    void Reset() override
    {
        playerCount = 0;
        unitList.clear();
        std::list<Creature*> temp;
        me->GetCreaturesWithEntryInRange(temp, 100.0f, NPC_FIRE_TRIGGER);
        for (std::list<Creature*>::const_iterator itr = temp.begin(); itr != temp.end(); ++itr)
        {
            unitList.push_back((*itr)->GetGUID());
        }

        events.ScheduleEvent(1, 3s);
        events.ScheduleEvent(2, 25s);
        events.ScheduleEvent(2, 43s);
        events.ScheduleEvent(3, 63s);

        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);

        me->SetCanFly(true);
        me->SetDisableGravity(true);
    }

    void EnterEvadeMode(EvadeReason /* why */) override
    {
        me->DespawnOrUnsummon(1);
    }

    uint32 GetData(uint32 /*type*/) const override
    {
        return playerCount;
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case 1:
                Talk(TALK_SHADE_PREPARE);
                break;
            case 2:
                {
                    CastFires(true);
                    break;
                }
            case 3:
                {
                    bool checkBurningTriggers = false;
                    for (ObjectGuid const& guid : unitList)
                        if (Unit* c = ObjectAccessor::GetUnit(*me, guid))
                            if (c->HasAuraType(SPELL_AURA_PERIODIC_DUMMY))
                            {
                                checkBurningTriggers = true;
                                break;
                            }

                    if (!checkBurningTriggers)
                    {
                        FinishEvent(false);
                        return;
                    }

                    counter++;
                    if (counter > 21)
                    {
                        bool failed = false;
                        for (ObjectGuid const& guid : unitList)
                            if (Unit* c = ObjectAccessor::GetUnit(*me, guid))
                                if (c->HasAuraType(SPELL_AURA_PERIODIC_DUMMY))
                                {
                                    failed = true;
                                    break;
                                }

                        FinishEvent(failed);
                        return;
                    }
                    if (counter == 5)
                    {
                        Talk(TALK_SHADE_START_EVENT);
                    }
                    else if (counter == 15)
                    {
                        Talk(TALK_SHADE_MORE_FIRES);
                    }

                    CastFires(false);
                    events.RepeatEvent(15000);
                    break;
                }
                case 4:
                {
                    me->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    if (Unit* target = me->SelectNearestPlayer(30.0f))
                        AttackStart(target);
                    break;
                }
        }

        if (!UpdateVictim())
            return;

        scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

    void CastFires(bool intial)
    {
        std::vector<Unit*> tmpList;
        for (ObjectGuid const& guid : unitList)
        {
            if (Unit* c = ObjectAccessor::GetUnit(*me, guid))
            {
                if (!c->HasAuraType(SPELL_AURA_PERIODIC_DUMMY))
                {
                    tmpList.push_back(c);
                }
            }
        }

        if (tmpList.empty())
        {
            return;
        }

        std::list<Player*> players;
        Acore::AnyPlayerInObjectRangeCheck checker(me, 60.f);
        Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(me, players, checker);
        Cell::VisitWorldObjects(me, searcher, 60.f);
        if (players.empty())
        {
            return;
        }

        playerCount = static_cast<uint32>(players.size()) - 1;

        if (!intial)
        {
            float playerRate = std::max(0.f, 0.5f - playerCount * 0.25f);

            // If there are more burning triggers than players, do not cast next fire
            if (tmpList.size() < unitList.size() * playerRate)
            {
                return;
            }
        }
        else
            playerCount += 1;

        uint32 sizeCount = (playerCount / 3) + 1;
        if (intial && playerCount > 0)
        {
            sizeCount += playerCount % 2;
        }

        Acore::Containers::RandomResize(tmpList, sizeCount);
        for (Unit* trigger : tmpList)
            me->CastSpell(trigger, SPELL_START_FIRE, true);
    }

    void FinishEvent(bool failed)
    {
        if (failed)
        {
            Talk(TALK_SHADE_FAILED);
            for (ObjectGuid const& guid : unitList)
                if (Unit* c = ObjectAccessor::GetUnit(*me, guid))
                    c->RemoveAllAuras();

            me->DespawnOrUnsummon(1);
        }
        else
        {
            Talk(TALK_SHADE_DEFEATED);
            float x, y, z;
            GetPosToLand(x, y, z);
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            me->GetMotionMaster()->MovePoint(8, x, y, z);
        }
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == POINT_MOTION_TYPE && point == 8)
        {
            me->RemoveAllAuras();
            me->SetCanFly(false);
            me->SetDisableGravity(false);
            events.ScheduleEvent(4, 2000);
        }
    }

    void JustDied(Unit*  /*killer*/) override
    {
        Talk(TALK_SHADE_DEATH);
        float x, y, z;
        GetPosToLand(x, y, z);
        me->CastSpell(x, y, z, SPELL_SUMMON_LANTERN, true);
        CompleteQuest();
    }

    void CompleteQuest()
    {
        float radius = 100.0f;
        std::list<Player*> players;
        Acore::AnyPlayerInObjectRangeCheck checker(me, radius);
        Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(me, players, checker);
        Cell::VisitWorldObjects(me, searcher, radius);

        for (Player* player : players)
        {
            player->AreaExploredOrEventHappens(QUEST_STOP_THE_FIRES_H);
            player->AreaExploredOrEventHappens(QUEST_STOP_THE_FIRES_A);
            player->AreaExploredOrEventHappens(QUEST_LET_THE_FIRES_COME_H);
            player->AreaExploredOrEventHappens(QUEST_LET_THE_FIRES_COME_A);
        }
    }
};

struct npc_hallows_end_train_fire : public NullCreatureAI
{
    npc_hallows_end_train_fire(Creature* creature) : NullCreatureAI(creature) { }

    uint32 timer;
    void Reset() override
    {
        timer = 0;
    }

    void UpdateAI(uint32 diff) override
    {
        timer += diff;
        if (timer >= 5000)
            if (!me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
                me->CastSpell(me, SPELL_FIRE_AURA_BASE, true);
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_WATER_SPLASH && caster->ToPlayer())
        {
            if (AuraEffect* aurEff = me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
            {
                int32 amt = aurEff->GetAmount();
                if (amt > 1)
                    aurEff->SetAmount(amt - 1);
                else
                    me->RemoveAllAuras();

                caster->ToPlayer()->KilledMonsterCredit(me->GetEntry());
            }
        }
    }
};

///////////////////////////////////////
////// HEADLESS HORSEMAN EVENT
///////////////////////////////////////

enum headlessHorseman
{
    // NPCs
    NPC_HEADLESS_HORSEMAN_MOUNTED                   = 23682,
    NPC_HORSEMAN_HEAD                               = 23775,
    NPC_PUMPKIN_FIEND                               = 23545,
    NPC_PUMPKIN                                     = 23694,

    // Spells
    SPELL_SHAKE_CAMERA_MEDIUM                       = 42909,
    SPELL_SHAKE_CAMERA_SMALL                        = 42910,
    SPELL_HORSEMAN_VISUAL                           = 42575,
    SPELL_SUMMONING_RHYME_TARGET                    = 42878,
    SPELL_HEAD_VISUAL                               = 42413,
    SPELL_EARTH_EXPLOSION                           = 42427,
    SPELL_HORSEMAN_BODY_REGEN                       = 42403,
    SPELL_HORSEMAN_BODY_REGEN_CONFUSE               = 43105,
    SPELL_HORSEMAN_IMMUNITY                         = 42556,
    SPELL_HEAD_DAMAGED_INFO                         = 43101,
    SPELL_BODY_RESTORED_INFO                        = 42405,
    SPELL_HEAD_VISUAL_LAND                          = 44241,
    SPELL_THROW_HEAD                                = 42399,
    SPELL_THROW_HEAD_BACK                           = 42401,
    SPELL_HORSEMAN_BODY_PHASE                       = 42547,
    SPELL_HORSEMAN_SPEAKS                           = 43129,
    SPELL_HORSEMAN_WHIRLWIND                        = 43116,
    SPELL_SUMMON_PUMPKIN                            = 42552,
    SPELL_PUMPKIN_VISUAL                            = 42280,
    SPELL_SQUASH_SOUL                               = 42514,
    SPELL_SPROUTING                                 = 42281,
    SPELL_PUMPKIN_AURA                              = 42294,
    SPELL_BURNING_BODY                              = 43184,

    // NP
    SPELL_HORSEMAN_SMOKE                            = 42355,
    SPELL_SPIRIT_PARTICLES_GREEN_CHEST              = 43161,
    SPELL_SPIRIT_PARTICLES_GREEN                    = 43167,

    // Events
    EVENT_HH_PLAYER_TALK                            = 1,
    EVENT_HORSEMAN_CLEAVE                           = 2,
    EVENT_HORSEMAN_WHIRLWIND                        = 3,
    EVENT_HORSEMAN_CHECK_HEALTH                     = 4,
    EVENT_HORSEMAN_CONFLAGRATION                    = 5,
    EVENT_SUMMON_PUMPKIN                            = 6,
    EVENT_HORSEMAN_FOLLOW                           = 7,

    // Headless Horseman
    TALK_ENTRANCE                                   = 0,
    TALK_REJOINED                                   = 1,
    TALK_CONFLAGRATION                              = 2,
    TALK_SPROUTING_PUMPKINS                         = 3,
    TALK_DEATH                                      = 4,
    TALK_PLAYER_DEATH                               = 5,

    // Head of the Horseman
    TALK_LAUGH                                      = 0,
    TALK_LOST_HEAD                                  = 1,

    // Player
    TALK_PLAYER_RISE                                = 22695,
    TALK_PLAYER_TIME_IS_NIGH                        = 22696,
    TALK_PLAYER_FELT_DEATH                          = 22720,
    TALK_PLAYER_KNOW_DEMISE                         = 22721,
};

enum hhMisc
{
    DATA_HORSEMAN_EVENT                             = 5,
};

struct boss_headless_horseman : public ScriptedAI
{
    boss_headless_horseman(Creature* creature) : ScriptedAI(creature), summons(me) { }

    EventMap events;
    SummonList summons;
    ObjectGuid playerGUID;
    uint8 talkCount;
    bool inFight;
    uint8 phase;
    uint32 health;

    void JustDied(Unit*  /*killer*/) override
    {
        summons.DespawnAll();
        Talk(TALK_DEATH);
        std::list<Creature*> unitList;
        me->GetCreaturesWithEntryInRange(unitList, 100.0f, NPC_PUMPKIN_FIEND);
        for (std::list<Creature*>::iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
            (*itr)->ToCreature()->DespawnOrUnsummon(500);

        Map::PlayerList const& players = me->GetMap()->GetPlayers();
        if (!players.IsEmpty() && players.begin()->GetSource() && players.begin()->GetSource()->GetGroup())
            sLFGMgr->FinishDungeon(players.begin()->GetSource()->GetGroup()->GetGUID(), lfg::LFG_DUNGEON_HEADLESS_HORSEMAN, me->FindMap());

        if (InstanceScript* instance = me->GetInstanceScript())
            instance->SetData(DATA_HORSEMAN_EVENT, DONE);
    }

    void KilledUnit(Unit*  /*who*/) override
    {
        Talk(TALK_PLAYER_DEATH);
    }

    void DoAction(int32 param) override
    {
        health = param;
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_SUMMONING_RHYME_TARGET)
        {
            playerGUID = target->GetGUID();
            events.ScheduleEvent(EVENT_HH_PLAYER_TALK, 2s);
        }
    }

    void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_THROW_HEAD_BACK)
        {
            me->SetHealth(me->GetMaxHealth());
            me->CastSpell(me, SPELL_HEAD_VISUAL, true);
            me->RemoveAura(SPELL_HORSEMAN_IMMUNITY);
            me->RemoveAura(SPELL_HORSEMAN_BODY_REGEN);
            me->RemoveAura(SPELL_HORSEMAN_BODY_REGEN_CONFUSE);
            me->RemoveAura(SPELL_HORSEMAN_WHIRLWIND);
            events.CancelEvent(EVENT_HORSEMAN_CHECK_HEALTH);
            events.CancelEvent(EVENT_HORSEMAN_WHIRLWIND);
            events.CancelEvent(EVENT_HORSEMAN_CONFLAGRATION);
            events.CancelEvent(EVENT_SUMMON_PUMPKIN);
            Talk(TALK_REJOINED);

            if (phase == 1)
                events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, 6s);
            else if (phase == 2)
                events.ScheduleEvent(EVENT_SUMMON_PUMPKIN, 6s);
        }
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == WAYPOINT_MOTION_TYPE)
        {
            if (point == 0)
                me->CastSpell(me, SPELL_HEAD_VISUAL, true);
            else if (point == 11)
            {
                me->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                me->StopMoving();

                me->SetDisableGravity(false);

                me->SetInCombatWithZone();
                inFight = true;
                events.ScheduleEvent(EVENT_HORSEMAN_FOLLOW, 500ms);
                events.ScheduleEvent(EVENT_HORSEMAN_CLEAVE, 7s);
            }
        }
    }

    Player* GetRhymePlayer() { return playerGUID ? ObjectAccessor::GetPlayer(*me, playerGUID) : nullptr; }

    void JustEngagedWith(Unit*) override { me->SetInCombatWithZone(); }
    void MoveInLineOfSight(Unit*  /*who*/) override {}

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        // We die... :(
        if (damage >= me->GetHealth())
        {
            damage = 0;
            me->RemoveAura(SPELL_HEAD_VISUAL);
            me->CastSpell(me, SPELL_HORSEMAN_IMMUNITY, true);
            me->CastSpell(me, SPELL_HORSEMAN_BODY_REGEN, true);
            me->CastSpell(me, SPELL_HORSEMAN_BODY_REGEN_CONFUSE, true);
            events.CancelEvent(EVENT_HORSEMAN_CLEAVE);

            // Summon Head
            Position pos = me->GetNearPosition(15.0f, rand_norm() * 2 * M_PI);
            if (Creature* cr = me->SummonCreature(NPC_HORSEMAN_HEAD, pos))
            {
                if (health)
                    cr->SetHealth(health);

                me->CastSpell(cr, SPELL_THROW_HEAD, true);
                cr->CastSpell(cr, SPELL_HORSEMAN_BODY_PHASE + phase, true);
                if (phase < 2)
                    phase++;

                events.ScheduleEvent(EVENT_HORSEMAN_WHIRLWIND, 6s);
                events.ScheduleEvent(EVENT_HORSEMAN_CHECK_HEALTH, 1s);
            }
        }
    }

    void JustSummoned(Creature* cr) override { summons.Summon(cr); }

    void Reset() override
    {
        events.Reset();
        summons.DespawnAll();
        playerGUID.Clear();
        talkCount = 0;
        phase = 0;
        inFight = false;
        health = 0;

        me->SetDisableGravity(true);
        me->SetSpeed(MOVE_WALK, 5.0f, true);
    }

    void JustReachedHome() override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->SetData(DATA_HORSEMAN_EVENT, FAIL);

        me->DespawnOrUnsummon();
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (inFight && !UpdateVictim())
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_HH_PLAYER_TALK:
                {
                    talkCount++;
                    Player* player = GetRhymePlayer();
                    if (!player)
                        return;

                    switch (talkCount)
                    {
                        case 1:
                            player->Say(TALK_PLAYER_RISE);
                            break;
                        case 2:
                            player->Say(TALK_PLAYER_TIME_IS_NIGH);
                            if (Creature* trigger = me->SummonTrigger(1765.28f, 1347.46f, 17.5514f, 0.0f, 15 * IN_MILLISECONDS))
                                trigger->CastSpell(trigger, SPELL_EARTH_EXPLOSION, true);
                            break;
                        case 3:
                            me->SetDisableGravity(true);
                            me->GetMotionMaster()->MovePath(236820, false);
                            me->CastSpell(me, SPELL_SHAKE_CAMERA_SMALL, true);
                            player->Say(TALK_PLAYER_FELT_DEATH);
                            Talk(TALK_ENTRANCE);
                            break;
                        case 4:
                            me->CastSpell(me, SPELL_SHAKE_CAMERA_MEDIUM, true);
                            player->Say(TALK_PLAYER_KNOW_DEMISE);
                            talkCount = 0;
                            return; // pop and return, skip repeat
                    }
                    events.RepeatEvent(2000);
                    break;
                }
            case EVENT_HORSEMAN_FOLLOW:
                {
                    if (Player* player = GetRhymePlayer())
                    {
                        me->GetMotionMaster()->MoveIdle();
                        AttackStart(player);
                        me->GetMotionMaster()->MoveChase(player);
                    }
                    break;
                }
            case EVENT_HORSEMAN_CLEAVE:
                {
                    me->CastSpell(me->GetVictim(), SPELL_HORSEMAN_CLEAVE, false);
                    events.RepeatEvent(8000);
                    break;
                }
            case EVENT_HORSEMAN_WHIRLWIND:
                {
                    if (me->HasAuraEffect(SPELL_HORSEMAN_WHIRLWIND, EFFECT_0))
                    {
                        me->RemoveAura(SPELL_HORSEMAN_WHIRLWIND);
                        events.RepeatEvent(15000);
                        break;
                    }
                    me->CastSpell(me, SPELL_HORSEMAN_WHIRLWIND, true);
                    events.RepeatEvent(6000);
                    break;
                }
            case EVENT_HORSEMAN_CHECK_HEALTH:
                {
                    if (me->GetHealth() == me->GetMaxHealth())
                    {
                        me->CastSpell(me, SPELL_BODY_RESTORED_INFO, true);
                        return;
                    }

                    events.RepeatEvent(1000);
                    break;
                }
            case EVENT_HORSEMAN_CONFLAGRATION:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        me->CastSpell(target, SPELL_HORSEMAN_CONFLAGRATION, false);
                        target->CastSpell(target, SPELL_HORSEMAN_CONFLAGRATION_SOUND, true);
                        Talk(TALK_CONFLAGRATION);
                    }

                    events.RepeatEvent(12500);
                    break;
                }
            case EVENT_SUMMON_PUMPKIN:
                {
                    if (talkCount < 4)
                    {
                        events.RepeatEvent(1);
                        talkCount++;
                        me->CastSpell(me, SPELL_SUMMON_PUMPKIN, false);
                    }
                    else
                    {
                        Talk(TALK_SPROUTING_PUMPKINS);
                        events.RepeatEvent(15000);
                        talkCount = 0;
                    }

                    break;
                }
        }

        if (inFight)
            DoMeleeAttackIfReady();
    }
};

struct boss_headless_horseman_head : public ScriptedAI
{
    boss_headless_horseman_head(Creature* creature) : ScriptedAI(creature) { }

    uint8 pct;
    uint32 timer;
    bool handled;

    void SpellHitTarget(Unit*  /*target*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_THROW_HEAD_BACK)
        {
            if (Unit* owner = GetOwner())
                owner->ToCreature()->AI()->DoAction(me->GetHealth());

            me->DespawnOrUnsummon();
        }
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        switch (spellInfo->Id)
        {
            case SPELL_BODY_RESTORED_INFO:
                me->RemoveAllAuras();
                if (Unit* owner = GetOwner())
                    owner->RemoveAura(SPELL_HORSEMAN_IMMUNITY);
                me->CastSpell(caster, SPELL_THROW_HEAD_BACK, true);
                break;
            case SPELL_THROW_HEAD:
                {
                    me->CastSpell(me, SPELL_HEAD_VISUAL_LAND, true);
                    if (Player* player = me->SelectNearestPlayer(50.0f))
                        me->GetMotionMaster()->MoveFleeing(player);

                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    timer = 26000;
                    break;
                }
            case SPELL_HORSEMAN_BODY_PHASE:
                pct = 67;
                break;
            case SPELL_HORSEMAN_BODY_PHASE+1:
                pct = 34;
                break;
            case SPELL_HORSEMAN_BODY_PHASE+2:
                pct = 0;
                break;
        }
    }

    Unit* GetOwner()
    {
        if (me->ToTempSummon())
            return me->ToTempSummon()->GetSummonerUnit();

        return nullptr;
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        // We die... :(
        if (damage >= me->GetHealth())
        {
            if (Unit* owner = GetOwner())
            {
                owner->CastSpell(owner, SPELL_BURNING_BODY, true);
                Unit::Kill(me, owner);
            }
            damage = 0;
            me->DespawnOrUnsummon();
            return;
        }

        if (me->HealthBelowPctDamaged(pct, damage) && !handled)
        {
            handled = true;
            damage = 0;
            me->RemoveAllAuras();
            me->CastSpell(me, SPELL_HEAD_DAMAGED_INFO, true);
            me->CastSpell(me, SPELL_THROW_HEAD_BACK, true);
            if (Unit* owner = GetOwner())
                owner->RemoveAura(SPELL_HORSEMAN_IMMUNITY);

            Talk(TALK_LOST_HEAD);
        }
    }

    void Reset() override
    {
        pct = 0;
        timer = 0;
        handled = false;
        me->SetInCombatWithZone();
    }

    void UpdateAI(uint32 diff) override
    {
        timer += diff;
        if (timer >= 30000)
        {
            timer = urand(0, 15000);
            me->CastSpell(me, SPELL_HORSEMAN_SPEAKS, true);
            Talk(TALK_LAUGH);
        }
    }
};

struct boss_headless_horseman_pumpkin : public ScriptedAI
{
    boss_headless_horseman_pumpkin(Creature* creature) : ScriptedAI(creature) { }

    uint32 timer;

    void AttackStart(Unit* ) override { }
    void MoveInLineOfSight(Unit* ) override { }

    void Reset() override
    {
        if (Player* player = me->SelectNearestPlayer(3.0f))
            me->CastSpell(player, SPELL_SQUASH_SOUL, true);
        timer = 1;
        me->CastSpell(me, SPELL_PUMPKIN_AURA, true);
        me->CastSpell(me, SPELL_PUMPKIN_VISUAL, true);
    }

    void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_SPROUTING)
        {
            if (Creature* cr = me->SummonCreature(NPC_PUMPKIN_FIEND, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                cr->SetInCombatWithZone();

            me->DespawnOrUnsummon();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (timer)
        {
            timer += diff;
            if (timer >= 3000)
            {
                me->CastSpell(me, SPELL_SPROUTING, false);
                timer = 0;
            }
        }
    }
};

class go_loosely_turned_soil : public GameObjectScript
{
public:
    go_loosely_turned_soil() : GameObjectScript("go_loosely_turned_soil") { }

    bool OnQuestReward(Player* player, GameObject* go, Quest const* /*quest*/, uint32 /*opt*/) override
    {
        if (player->FindNearestCreature(NPC_HEADLESS_HORSEMAN_MOUNTED, 100.0f))
            return true;

        if (Creature* horseman = go->SummonCreature(NPC_HEADLESS_HORSEMAN_MOUNTED, 1754.00f, 1346.00f, 17.50f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
            horseman->CastSpell(player, SPELL_SUMMONING_RHYME_TARGET, true);

        return true;
    }

    struct go_loosely_turned_soilAI : public GameObjectAI
    {
        go_loosely_turned_soilAI(GameObject* gameObject) : GameObjectAI(gameObject) { }

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
            {
                return true;
            }

            Group const* group = player->GetGroup();
            return group && sLFGMgr->GetDungeon(group->GetGUID()) == lfg::LFG_DUNGEON_HEADLESS_HORSEMAN;
        }
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_loosely_turned_soilAI(go);
    }
};

class go_pumpkin_shrine : public GameObjectScript
{
public:
    go_pumpkin_shrine() : GameObjectScript("go_pumpkin_shrine") {}

    bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);

        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (instance->GetData(DATA_HORSEMAN_EVENT) == IN_PROGRESS || instance->GetData(DATA_HORSEMAN_EVENT) == DONE)
                return true;

            if (player->FindNearestCreature(NPC_HEADLESS_HORSEMAN_MOUNTED, 100.0f))
                return true;

            if (Creature* horseman = go->SummonCreature(NPC_HEADLESS_HORSEMAN_MOUNTED, 1754.00f, 1346.00f, 17.50f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                horseman->CastSpell(player, SPELL_SUMMONING_RHYME_TARGET, true);

            instance->SetData(DATA_HORSEMAN_EVENT, IN_PROGRESS);
        }

        return true;
    }
};

void AddSC_event_hallows_end_scripts()
{
    // Spells
    RegisterSpellScript(spell_hallows_end_trick);
    RegisterSpellScript(spell_hallows_end_trick_or_treat);
    RegisterSpellScript(spell_hallows_end_candy);
    RegisterSpellScript(spell_hallows_end_candy_pirate_costume);
    RegisterSpellScript(spell_hallows_end_tricky_treat);
    RegisterSpellScriptWithArgs(spell_hallows_end_put_costume, "spell_hallows_end_pirate_costume", SPELL_PIRATE_COSTUME_MALE, SPELL_PIRATE_COSTUME_FEMALE);
    RegisterSpellScriptWithArgs(spell_hallows_end_put_costume, "spell_hallows_end_leper_costume", SPELL_LEPER_GNOME_COSTUME_MALE, SPELL_LEPER_GNOME_COSTUME_FEMALE);
    RegisterSpellScriptWithArgs(spell_hallows_end_put_costume, "spell_hallows_end_ghost_costume", SPELL_GHOST_COSTUME_MALE, SPELL_GHOST_COSTUME_FEMALE);
    RegisterSpellScriptWithArgs(spell_hallows_end_put_costume, "spell_hallows_end_ninja_costume", SPELL_NINJA_COSTUME_MALE, SPELL_NINJA_COSTUME_FEMALE);
    RegisterSpellScript(spell_hallows_end_base_fire);
    RegisterSpellScript(spell_hallows_end_bucket_lands);

    // Quests
    RegisterCreatureAI(npc_hallows_end_train_fire);

    // creatures
    RegisterCreatureAI(npc_costumed_orphan_matron);
    RegisterCreatureAI(npc_soh_fire_trigger);
    RegisterCreatureAI(npc_hallows_end_soh);

    // Headless Horseman
    new go_loosely_turned_soil();
    new go_pumpkin_shrine();
    RegisterCreatureAI(boss_headless_horseman);
    RegisterCreatureAI(boss_headless_horseman_head);
    RegisterCreatureAI(boss_headless_horseman_pumpkin);
}
