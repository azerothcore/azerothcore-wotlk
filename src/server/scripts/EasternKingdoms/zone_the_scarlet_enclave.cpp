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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "CombatAI.h"
#include "CreatureTextMgr.h"
#include "GameObjectScript.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ObjectAccessor.h"
#include "SpellAuras.h"
#include <limits>
#include "WorldStateDefines.h"

/*######
 ## Quest: Death Comes From High
 ## Note: Recall Eye of Acherus and Summon Ghouls On Scarlet Crusade (Spell Scripts)
 ######*/

enum DeathComesFromOnHigh
{
    SPELL_THE_EYE_OF_ACHERUS = 51852,
    SPELL_CALL_OF_THE_DEAD = 51900
};

// 51904 - Summon Ghouls On Scarlet Crusade
class spell_q12641_death_comes_from_on_high_summon_ghouls : public SpellScript
{
    PrepareSpellScript(spell_q12641_death_comes_from_on_high_summon_ghouls);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CALL_OF_THE_DEAD });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_CALL_OF_THE_DEAD, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12641_death_comes_from_on_high_summon_ghouls::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 52694 - Recall Eye of Acherus
class spell_q12641_death_comes_from_on_high_recall_eye : public SpellScript
{
    PrepareSpellScript(spell_q12641_death_comes_from_on_high_recall_eye);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_THE_EYE_OF_ACHERUS });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        Unit* caster = GetCaster();
        Unit* owner = caster->GetCharmerOrOwner();

        if (!caster || !owner)
            return;

        if (owner->HasAura(SPELL_THE_EYE_OF_ACHERUS))
            owner->RemoveAurasDueToSpell(SPELL_THE_EYE_OF_ACHERUS);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12641_death_comes_from_on_high_recall_eye::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Rain of Darkness
## Quest: If Chaos Drives, Let Suffering Hold The Reins.
## Note: Increase Rain of Darkness (Trigger) Z Axis Spawn Point.
######*/

// 51761 - Rain of Darkness
class spell_q12641_rain_of_darkness : public SpellScript
{
    PrepareSpellScript(spell_q12641_rain_of_darkness);

    void ModDestHeight(SpellDestination& dest)
    {
        Position const offset = { 0.0f, 0.0f, 15.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q12641_rain_of_darkness::ModDestHeight, EFFECT_0, TARGET_DEST_CASTER_BACK);
    }
};

/*######
 ## Quest: Gift Of The Harvester
 ######*/

enum GiftOfTheHarvester
{
    NPC_GHOUL                   = 28845,
    MAX_GHOULS                  = 5,

    SPELL_GHOUL_EMERGE          = 50142,
    SPELL_SUMMON_SCARLET_GHOST  = 52505,
    SPELL_GHOUL_SUBMERGE        = 26234,

    EVENT_GHOUL_RESTORE_STATE   = 1,
    EVENT_GHOUL_CHECK_COMBAT    = 2,
    EVENT_GHOUL_EMOTE           = 3,
    EVENT_GHOUL_MOVE_TO_PIT     = 4,

    SAY_GOTHIK_PIT              = 0,

    ACTION_DK_INITIATE_ASSAULT_ROAR = 15

};

class spell_item_gift_of_the_harvester : public SpellScript
{
    PrepareSpellScript(spell_item_gift_of_the_harvester);

    SpellCastResult CheckRequirement()
    {
        std::list<Creature*> ghouls;
        GetCaster()->GetAllMinionsByEntry(ghouls, NPC_GHOUL);
        if (ghouls.size() >= MAX_GHOULS)
        {
            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_TOO_MANY_GHOULS);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_gift_of_the_harvester::CheckRequirement);
    }
};

class spell_q12698_the_gift_that_keeps_on_giving : public SpellScript
{
    PrepareSpellScript(spell_q12698_the_gift_that_keeps_on_giving);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_SCARLET_GHOST });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (GetOriginalCaster() && GetHitUnit())
            GetOriginalCaster()->CastSpell(GetHitUnit(), urand(0, 1) ? GetEffectValue() : SPELL_SUMMON_SCARLET_GHOST, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12698_the_gift_that_keeps_on_giving::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

struct npc_scarlet_ghoul : public ScriptedAI
{
    npc_scarlet_ghoul(Creature* creature) : ScriptedAI(creature)
    {
    }

    EventMap events;
    ObjectGuid gothikGUID;

    void InitializeAI() override
    {
        me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
        ScriptedAI::InitializeAI();
        me->SetReactState(REACT_PASSIVE);

        events.ScheduleEvent(EVENT_GHOUL_EMOTE, 1ms);
        events.ScheduleEvent(EVENT_GHOUL_RESTORE_STATE, 3500ms);
    }

    void OwnerAttackedBy(Unit* attacker) override
    {
        if (!me->IsInCombat() && me->GetReactState() == REACT_DEFENSIVE)
            AttackStart(attacker);
    }

    void SetGUID(ObjectGuid const& guid, int32) override
    {
        gothikGUID = guid;
        events.ScheduleEvent(EVENT_GHOUL_MOVE_TO_PIT, 3s);
        me->GetMotionMaster()->Clear(false);
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == POINT_MOTION_TYPE && point == 1)
        {
            me->DespawnOrUnsummon(1500ms);
            me->CastSpell(me, SPELL_GHOUL_SUBMERGE, true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (events.ExecuteEvent())
        {
            case EVENT_GHOUL_MOVE_TO_PIT:
                me->GetMotionMaster()->MovePoint(1, 2364.77f, -5776.14f, 151.36f);
                if (Creature* gothik = ObjectAccessor::GetCreature(*me, gothikGUID))
                    gothik->AI()->DoAction(SAY_GOTHIK_PIT);
                break;
            case EVENT_GHOUL_EMOTE:
                me->CastSpell(me, SPELL_GHOUL_EMERGE, true);
                break;
            case EVENT_GHOUL_RESTORE_STATE:
                me->SetReactState(REACT_DEFENSIVE);
                me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                    me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, frand(0.0f, 2 * M_PI));
                events.ScheduleEvent(EVENT_GHOUL_CHECK_COMBAT, 1s);
                return;
            case EVENT_GHOUL_CHECK_COMBAT:
                if (!me->IsInCombat())
                    if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                        if (owner->GetVictim())
                            AttackStart(owner->GetVictim());

                events.Repeat(1s);
                return;
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

struct npc_dkc1_gothik : public ScriptedAI
{
    npc_dkc1_gothik(Creature* creature) : ScriptedAI(creature) { spoken = 0; }

    int32 spoken;

    void DoAction(int32 action) override
    {
        if (action == SAY_GOTHIK_PIT && spoken <= 0)
        {
            spoken = 5000;
            Talk(SAY_GOTHIK_PIT);
        }

        if (action == ACTION_DK_INITIATE_ASSAULT_ROAR)
            me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        ScriptedAI::MoveInLineOfSight(who);

        if (!who->IsImmuneToNPC() && who->GetEntry() == NPC_GHOUL && me->IsWithinDistInMap(who, 10.0f))
            if (Unit* owner = who->GetOwner())
                if (Player* player = owner->ToPlayer())
                {
                    Creature* creature = who->ToCreature();
                    if (player->GetQuestStatus(12698) == QUEST_STATUS_INCOMPLETE)
                        creature->CastSpell(owner, 52517, true);

                    creature->AI()->SetGUID(me->GetGUID());
                    creature->SetImmuneToAll(true);
                }
    }

    void UpdateAI(uint32 diff) override
    {
        if (spoken > 0)
            spoken -= diff;

        ScriptedAI::UpdateAI(diff);
    }
};

/*######
## Death Knight Initiate Visual Spell
## Quest: The Endless Hunger
## Note: Trigger Based On Creature Race
######*/

#define GCD_CAST    1

enum UnworthyInitiate
{
    SPELL_DK_INITIATE_VISUAL        = 51519,
};

class spell_death_knight_initiate_visual : public SpellScript
{
    PrepareSpellScript(spell_death_knight_initiate_visual);

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        Creature* target = GetHitCreature();
        if (!target)
            return;

        uint32 spellId;
        switch (target->GetDisplayId())
        {
            case 25369: spellId = 51552; break; // bloodelf female
            case 25373: spellId = 51551; break; // bloodelf male
            case 25363: spellId = 51542; break; // draenei female
            case 25357: spellId = 51541; break; // draenei male
            case 25361: spellId = 51537; break; // dwarf female
            case 25356: spellId = 51538; break; // dwarf male
            case 25372: spellId = 51550; break; // forsaken female
            case 25367: spellId = 51549; break; // forsaken male
            case 25362: spellId = 51540; break; // gnome female
            case 25359: spellId = 51539; break; // gnome male
            case 25355: spellId = 51534; break; // human female
            case 25354: spellId = 51520; break; // human male
            case 25360: spellId = 51536; break; // nightelf female
            case 25358: spellId = 51535; break; // nightelf male
            case 25368: spellId = 51544; break; // orc female
            case 25364: spellId = 51543; break; // orc male
            case 25371: spellId = 51548; break; // tauren female
            case 25366: spellId = 51547; break; // tauren male
            case 25370: spellId = 51545; break; // troll female
            case 25365: spellId = 51546; break; // troll male
            default: return;
        }

        target->CastSpell(target, spellId, true);
        target->LoadEquipment();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_death_knight_initiate_visual::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Lich King Whisper
## Quest: If Chaos Drives, Let Suffering Hold The Reins.
######*/

enum spells_lich_king_whisper
{
    SPELL_LICH_KING_VO_BLOCKER = 58207,
    SPELL_LICHKINGDK001 = 58208,
    SPELL_LICHKINGDK002 = 58209,
    SPELL_LICHKINGDK003 = 58210,
    SPELL_LICHKINGDK004 = 58211,
    SPELL_LICHKINGDK005 = 58212,
    SPELL_LICHKINGDK006 = 58213,
    SPELL_LICHKINGDK007 = 58214,
    SPELL_LICHKINGDK008 = 58215,
    SPELL_LICHKINGDK009 = 58216,
    SPELL_LICHKINGDK010 = 58217,
    SPELL_LICHKINGDK011 = 58218,
    SPELL_LICHKINGDK012 = 58219,
    SPELL_LICHKINGDK013 = 58220,
    SPELL_LICHKINGDK014 = 58221,
    SPELL_LICHKINGDK015 = 58222,
    SPELL_LICHKINGDK016 = 58223
};

//spell 58207 rand Whisper
class spell_lich_king_vo_blocker : public AuraScript
{
    PrepareAuraScript(spell_lich_king_vo_blocker);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo
        ({
             SPELL_LICHKINGDK001, SPELL_LICHKINGDK002, SPELL_LICHKINGDK003, SPELL_LICHKINGDK004,
             SPELL_LICHKINGDK005, SPELL_LICHKINGDK006, SPELL_LICHKINGDK007, SPELL_LICHKINGDK008,
             SPELL_LICHKINGDK009, SPELL_LICHKINGDK010, SPELL_LICHKINGDK011, SPELL_LICHKINGDK012,
             SPELL_LICHKINGDK013, SPELL_LICHKINGDK014, SPELL_LICHKINGDK015, SPELL_LICHKINGDK016
        });
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* target = GetTarget()->ToPlayer())
        {
            //spell 58208-58223
            GetCaster()->CastSpell(target, urand(SPELL_LICHKINGDK001, SPELL_LICHKINGDK016), true);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_lich_king_vo_blocker::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 58208 - 58224 - Creature - The Lich King (28765)  Whisper
class spell_lich_king_whisper : public SpellScript
{
    PrepareSpellScript(spell_lich_king_whisper);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return sObjectMgr->GetBroadcastText(uint32(spellInfo->GetEffect(EFFECT_0).CalcValue())) &&
            sSoundEntriesStore.LookupEntry(uint32(spellInfo->GetEffect(EFFECT_1).CalcValue()));
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitPlayer())
            GetCaster()->Whisper(uint32(GetEffectValue()), player, false);
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitPlayer())
            player->PlayDistanceSound(uint32(GetEffectValue()), player);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_lich_king_whisper::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        OnEffectHitTarget += SpellEffectFn(spell_lich_king_whisper::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

/*######
## Npc Koltira Deathweaver
## Quest: Bloody Breakout
######*/

enum Koltira
{
    SAY_BREAKOUT0                   = 0,
    SAY_BREAKOUT1                   = 1,
    SAY_BREAKOUT2                   = 2,
    SAY_BREAKOUT3                   = 3,
    SAY_BREAKOUT4                   = 4,
    SAY_BREAKOUT5                   = 5,
    SAY_BREAKOUT6                   = 6,
    SAY_BREAKOUT7                   = 7,
    SAY_BREAKOUT8                   = 8,
    SAY_BREAKOUT9                   = 9,
    SAY_BREAKOUT10                  = 10,
    EMOTE_KOLTIRA_COLLAPSES         = 11,

    SAY_VALROTH_WAVE3               = 0,
    SAY_VALROTH_AGGRO               = 1,
    SAY_VALROTH_WAVE1               = 4,
    SAY_VALROTH_WAVE2               = 5,

    SPELL_KOLTIRA_TRANSFORM         = 52899,
    SPELL_ANTI_MAGIC_ZONE           = 52894,

    QUEST_BREAKOUT                  = 12727,

    NPC_CRIMSON_ACOLYTE             = 29007,
    NPC_HIGH_INQUISITOR_VALROTH     = 29001,

    //not sure about this id
    //NPC_DEATH_KNIGHT_MOUNT        = 29201,
    MODEL_DEATH_KNIGHT_MOUNT        = 25278,

    POINT_STAND_UP                  = 1,
    POINT_BOX                       = 2,
    POINT_ANTI_MAGIC_ZONE           = 3,

    POINT_MOUNT                     = 1,
    POINT_DESPAWN                   = 2
};

struct npc_koltira_deathweaver : public ScriptedAI
{
    npc_koltira_deathweaver(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        me->m_Events.KillAllEvents(false);
        me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
        me->setActive(false);
        SetEquipmentSlots(true);
    }

    void StartEvent()
    {
        if (!me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP)) // Already in progress
            return;

        me->SetStandState(UNIT_STAND_STATE_SIT);
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        me->setActive(true);

        Talk(SAY_BREAKOUT0);

        me->m_Events.AddEventAtOffset([&] {
            me->GetMotionMaster()->MoveWaypoint(me->GetEntry() * 10, false);
        }, 5s);
    }

    void sQuestAccept(Player* /*player*/, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_BREAKOUT)
            StartEvent();
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 /*gossipListId*/) override
    {
        if (player->GetQuestStatus(QUEST_BREAKOUT) == QUEST_STATUS_INCOMPLETE)
        {
            CloseGossipMenuFor(player);
            StartEvent();
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != WAYPOINT_MOTION_TYPE)
            return;

        if (!me->HasUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC))
        {
            if (id == POINT_MOUNT)
                me->Mount(MODEL_DEATH_KNIGHT_MOUNT);
            else if (id == POINT_DESPAWN)
            {
                me->Dismount();
                me->DespawnOrUnsummon();
            }

            return;
        }

        switch (id)
        {
            case POINT_STAND_UP:
                Talk(SAY_BREAKOUT1);
                break;
            case POINT_BOX:
                me->SetStandState(UNIT_STAND_STATE_KNEEL);

                scheduler.Schedule(5s, [this](TaskContext context)
                {
                    switch (context.GetRepeatCounter())
                    {
                    case 0:
                        Talk(SAY_BREAKOUT3);

                        // Shouldn't actually be spawned at this point, but no way to send his yells otherwise?
                        if (Creature* valroth = me->SummonCreature(NPC_HIGH_INQUISITOR_VALROTH, 1640.8596f, -6030.834f, 134.82211f, 4.606426715850830078f, TEMPSUMMON_MANUAL_DESPAWN))
                        {
                            _valrothGUID = valroth->GetGUID();
                            valroth->AI()->Talk(SAY_VALROTH_WAVE1);
                            valroth->SetReactState(REACT_PASSIVE);
                        }

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.6724f, -6032.0527f, 134.82213f, 4.654973506927490234f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint(NPC_CRIMSON_ACOLYTE * 10, false);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1641.0055f, -6031.893f, 134.82211f, 0.401425719261169433f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 1) * 10, false);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1639.7053f, -6031.7373f, 134.82213f, 2.443460941314697265f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 2) * 10, false);
                        break;
                    case 1:
                        Talk(SAY_BREAKOUT4);

                        if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                            valroth->AI()->Talk(SAY_VALROTH_WAVE2);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.7958f, -6030.307f, 134.82211f, 4.65355682373046875f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 3) * 10, false);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1641.7305f, -6030.751f, 134.82211f, 6.143558979034423828f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 4) * 10, false);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1639.4657f, -6030.404f, 134.82211f, 4.502949237823486328f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 5) * 10, false);
                        break;
                    case 2:
                        Talk(SAY_BREAKOUT5);

                        if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                            valroth->AI()->Talk(SAY_VALROTH_WAVE3);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1641.3405f, -6031.436f, 134.82211f, 4.612849712371826171f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 6) * 10, false);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1642.0404f, -6030.3843f, 134.82211f, 1.378810048103332519f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 7) * 10, false);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.1162f, -6029.7817f, 134.82211f, 5.707226753234863281f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 8) * 10, false);

                        if (Creature* acolyte = me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1640.9948f, -6029.8027f, 134.82211f, 1.605702877044677734f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                            acolyte->GetMotionMaster()->MoveWaypoint((NPC_CRIMSON_ACOLYTE + 9) * 10, false);
                        break;
                    case 3:
                        Talk(SAY_BREAKOUT6);
                        me->m_Events.AddEventAtOffset([this]
                        {
                            Talk(EMOTE_KOLTIRA_COLLAPSES, me);
                            me->KillSelf();

                            if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                                valroth->DespawnOrUnsummon();
                        }, 2min);

                        if (Creature* valroth = ObjectAccessor::GetCreature(*me, _valrothGUID))
                        {
                            valroth->AI()->Talk(SAY_VALROTH_AGGRO);
                            valroth->SetReactState(REACT_AGGRESSIVE);
                            valroth->GetMotionMaster()->MoveWaypoint(NPC_HIGH_INQUISITOR_VALROTH * 10, false);
                        }
                        return;
                    default:
                        break;
                    }

                    context.Repeat(20s);
                });

                scheduler.Schedule(3s, [this](TaskContext)
                {
                    DoCastSelf(SPELL_KOLTIRA_TRANSFORM);
                    me->LoadEquipment();
                });
                break;
            case POINT_ANTI_MAGIC_ZONE:
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                Talk(SAY_BREAKOUT2);
                DoCastSelf(SPELL_ANTI_MAGIC_ZONE);
                break;
            default:
                break;
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        if (summon->GetEntry() == NPC_HIGH_INQUISITOR_VALROTH)
        {
            me->m_Events.KillAllEvents(false);
            me->RemoveAurasDueToSpell(SPELL_ANTI_MAGIC_ZONE);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            Talk(SAY_BREAKOUT8, 3s);
            Talk(SAY_BREAKOUT9, 8s);
            scheduler.Schedule(11s, [this](TaskContext)
            {
                Talk(SAY_BREAKOUT10);
                SetInvincibility(true);
                me->SetReactState(REACT_PASSIVE);
                me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
                me->GetMotionMaster()->MoveWaypoint((me->GetEntry() + 1) * 10, false);
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    ObjectGuid _valrothGUID;
};

/*######
## Gothik the Harvester and Acherus Necromancer AI
## Phase 4 Internal Mechanics.
######*/

enum NecroSpells
{
    SPELL_SCARLET_GHOUL   = 52683,  // Raises a Scarlet Ghoul from a humanoid corpse
    SPELL_SCOURGE_GRYPHON = 52685,  // Raises a Scourge Gryphon from a gryphon corpse
    SPELL_GHOULPLOSION    = 52672   // Causes a Gluttonous Geist to explode (kill)
};

enum NecroNPCs
{
    NPC_GLUTTONOUS_GEIST            = 28905,
    NPC_DEAD_SCARLET_MEDIC          = 28895,
    NPC_DEAD_SCARLET_INFANTRYMAN    = 28896,
    NPC_DEAD_SCARLET_CAPTAIN        = 28898,
    NPC_DEAD_SCARLET_PEASANT        = 28892,
    NPC_DEAD_SCARLET_MINER          = 28891,
    NPC_DEAD_SCARLET_FLEET_DEFENDER = 28886,
    NPC_DEAD_SCARLET_GRYPHON        = 28893
};

struct npc_acherus_necromancer : public ScriptedAI
{
    npc_acherus_necromancer(Creature* creature) : ScriptedAI(creature) { }

    EventMap events;
    ObjectGuid targetCorpseGUID;
    ObjectGuid geistGUID;
    bool isOnRitual;

    // Event timers (IDs)
    enum Events
    {
        EVENT_START_RITUAL = 1,
        EVENT_GHOULPLOSION,
        EVENT_RAISE_GHOUL,
        EVENT_RESUME_WP
    };

    // Point ID for movement
    enum Points
    {
        POINT_CORPSE_REACHED = 1
    };

    void Reset() override
    {
        events.Reset();
        targetCorpseGUID.Clear();
        geistGUID.Clear();
        isOnRitual = false;
        // Start waypoint movement using WaypointMovementGenerator
        if (uint32 pathId = me->GetWaypointPath())
        {
            me->GetMotionMaster()->MoveWaypoint(pathId, true); // true = repeatable
        }
        // Schedule the first ritual after 20-30s
        events.ScheduleEvent(EVENT_START_RITUAL, 20s, 30s);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_START_RITUAL:
                {
                    if (isOnRitual) // Already performing ritual
                    {
                        events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                        break;
                    }

                    // Find nearest dead Scarlet humanoid (exclude gryphon)
                    Creature* nearestCorpse = nullptr;
                    float nearestDist = std::numeric_limits<float>::max();
                    static const uint32 corpseEntries[] = {
                        NPC_DEAD_SCARLET_MEDIC, NPC_DEAD_SCARLET_INFANTRYMAN, NPC_DEAD_SCARLET_CAPTAIN,
                        NPC_DEAD_SCARLET_PEASANT, NPC_DEAD_SCARLET_MINER, NPC_DEAD_SCARLET_FLEET_DEFENDER
                    };
                    for (uint32 entry : corpseEntries)
                    {
                        // Search up to 60 yards for each type
                        if (Creature* corpse = me->FindNearestCreature(entry, 60.0f, true))
                        {
                            float dist = me->GetDistance(corpse);
                            if (dist < nearestDist)
                            {
                                nearestDist = dist;
                                nearestCorpse = corpse;
                            }
                        }
                    }
                    if (!nearestCorpse)
                    {
                        // No corpse found nearby: try again later
                        events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                        break;
                    }
                    // Start ritual
                    isOnRitual = true;
                    targetCorpseGUID = nearestCorpse->GetGUID();
                    geistGUID.Clear();
                    // Pause waypoint movement and move to the corpse
                    me->PauseMovement();
                    float x, y, z;
                    // Keep it at a distance from the corpse
                    nearestCorpse->GetClosePoint(x, y, z, me->GetObjectSize());
                    me->GetMotionMaster()->MovePoint(POINT_CORPSE_REACHED, x, y, z);
                    break;
                }

                case EVENT_GHOULPLOSION:
                {
                    if (Creature* geist = ObjectAccessor::GetCreature(*me, geistGUID))
                    {
                        me->SetFacingToObject(geist);
                        DoCast(geist, SPELL_GHOULPLOSION);
                    }
                    break;
                }

                case EVENT_RAISE_GHOUL:
                {
                    if (Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID))
                    {
                        // Cast Scarlet Ghoul on the corpse (always a humanoid for necromancer)
                        me->SetFacingToObject(corpse);
                        DoCast(corpse, SPELL_SCARLET_GHOUL);
                    }
                    break;
                }

                case EVENT_RESUME_WP:
                {
                    // Resume waypoint movement
                    isOnRitual = false;

                    targetCorpseGUID.Clear();

                    // Resume paused waypoint movement
                    me->ResumeMovement();
                    // Schedule next ritual in 20-30s
                    events.ScheduleEvent(EVENT_START_RITUAL, 20s, 30s);
                    break;
                }
            }
        }

        // Necromancers are not expected to engage in combat; no melee UpdateAI needed beyond events.
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_CORPSE_REACHED)
        {
            // Reached the corpse
            // Check for nearby Gluttonous Geist within ~3 yards
            Creature* geist = me->FindNearestCreature(NPC_GLUTTONOUS_GEIST, 3.0f, true);
            if (geist)
            {
                me->SetFacingToObject(geist);
                geistGUID = geist->GetGUID();
                // Geist found: schedule Ghoulplosion at +3s, then raising at +6s, then resume at +9s
                events.ScheduleEvent(EVENT_GHOULPLOSION, 3s);
                events.ScheduleEvent(EVENT_RAISE_GHOUL, 6s);
                events.ScheduleEvent(EVENT_RESUME_WP, 9s);
            }
            else
            {
                // No Geist: just raise after 3s, resume 3s later

                Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID);
                if (corpse)
                {
                    me->SetFacingToObject(corpse);
                }

                events.ScheduleEvent(EVENT_RAISE_GHOUL, 3s);
                events.ScheduleEvent(EVENT_RESUME_WP, 6s);
            }
        }
    }
};

struct npc_gothik_the_harvester : public ScriptedAI
{
    npc_gothik_the_harvester(Creature* creature) : ScriptedAI(creature) { }

    EventMap events;
    ObjectGuid targetCorpseGUID;
    ObjectGuid geistGUID;
    bool isOnRitual;

    enum Events
    {
        EVENT_START_RITUAL = 1,
        EVENT_GHOULPLOSION,
        EVENT_RAISE_DEAD,
        EVENT_RESUME_WP
    };

    enum Points
    {
        POINT_CORPSE_REACHED = 1
    };

    // Text identifiers for creature_text (see SQL below)
    enum Says
    {
        SAY_GRYPHON = 0,  // "You will fly again, beast..."
        SAY_GHOUL   = 1,  // "Surprise, surprise! Another ghoul!"
        SAY_GEIST   = 2   // "Is Gothik the Harvester going to have to choke a geist?"
    };

    void Reset() override
    {
        events.Reset();
        targetCorpseGUID.Clear();
        geistGUID.Clear();
        isOnRitual = false;
        // Start waypoint movement using WaypointMovementGenerator
        if (uint32 pathId = me->GetWaypointPath())
        {
            me->GetMotionMaster()->MoveWaypoint(pathId, true); // true = repeatable
        }
        // Schedule the first ritual after 50-60s
        events.ScheduleEvent(EVENT_START_RITUAL, 50s, 60s);
    }
    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_START_RITUAL:
                {
                    if (isOnRitual) // Already performing ritual
                    {
                        events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                        break;
                    }

                    // Find nearest dead Scarlet NPC (including gryphon)
                    Creature* nearestCorpse = nullptr;
                    float nearestDist = std::numeric_limits<float>::max();
                    static const uint32 corpseEntries[] = {
                        NPC_DEAD_SCARLET_MEDIC, NPC_DEAD_SCARLET_INFANTRYMAN, NPC_DEAD_SCARLET_CAPTAIN,
                        NPC_DEAD_SCARLET_PEASANT, NPC_DEAD_SCARLET_MINER, NPC_DEAD_SCARLET_FLEET_DEFENDER,
                        NPC_DEAD_SCARLET_GRYPHON
                    };
                    for (uint32 entry : corpseEntries)
                    {
                        // Search up to 60 yards for each type
                        if (Creature* corpse = me->FindNearestCreature(entry, 60.0f, true))
                        {
                            float dist = me->GetDistance(corpse);
                            if (dist < nearestDist)
                            {
                                nearestDist = dist;
                                nearestCorpse = corpse;
                            }
                        }
                    }
                    if (!nearestCorpse)
                    {
                        events.ScheduleEvent(EVENT_START_RITUAL, 5s, 10s);
                        break;
                    }
                    // Start ritual
                    isOnRitual = true;
                    targetCorpseGUID = nearestCorpse->GetGUID();
                    geistGUID.Clear();
                    // Pause waypoint movement and move to the corpse
                    me->PauseMovement();
                    float x, y, z;
                    // Keep it at a distance from the corpse
                    nearestCorpse->GetClosePoint(x, y, z, me->GetObjectSize());
                    me->GetMotionMaster()->MovePoint(POINT_CORPSE_REACHED, x, y, z);
                    break;
                }
                case EVENT_GHOULPLOSION:
                {
                    // Cast Ghoulplosion on the Geist and say the Geist line
                    if (Creature* geist = ObjectAccessor::GetCreature(*me, geistGUID))
                    {
                        Talk(SAY_GEIST);
                        me->SetFacingToObject(geist);
                        DoCast(geist, SPELL_GHOULPLOSION);
                    }
                    break;
                }

                case EVENT_RAISE_DEAD:
                {
                    // Cast the appropriate raise spell on the corpse (griffon or ghoul)
                    if (Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID))
                    {
                        me->SetFacingToObject(corpse);
                        uint32 entry = corpse->GetEntry();
                        if (entry == NPC_DEAD_SCARLET_GRYPHON)
                        {
                            DoCast(corpse, SPELL_SCOURGE_GRYPHON);
                        }
                        else
                        {
                            DoCast(corpse, SPELL_SCARLET_GHOUL);
                        }
                    }
                    break;
                }
                case EVENT_RESUME_WP:
                {
                    // Resume waypoint movement
                    isOnRitual = false;
                    targetCorpseGUID.Clear();
                    // Resume paused waypoint movement
                    me->ResumeMovement();
                    // Schedule next ritual in 50-60s
                    events.ScheduleEvent(EVENT_START_RITUAL, 50s, 60s);
                    break;
                }
            }
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_CORPSE_REACHED)
        {
            // Reached the target corpse
            Creature* corpse = ObjectAccessor::GetCreature(*me, targetCorpseGUID);
            if (corpse)
            {
                me->SetFacingToObject(corpse);
                // Say line depending on corpse type (gryphon or humanoid)
                if (corpse->GetEntry() == NPC_DEAD_SCARLET_GRYPHON)
                    Talk(SAY_GRYPHON);
                else
                    Talk(SAY_GHOUL);
            }
            // Check for Geist nearby
            Creature* geist = me->FindNearestCreature(NPC_GLUTTONOUS_GEIST, 3.0f, true);
            if (geist)
            {
                me->SetFacingToObject(geist);
                geistGUID = geist->GetGUID();
                // Geist present: Ghoulplosion in 3s (with SAY_GEIST), raise in 6s, resume in 9s
                events.ScheduleEvent(EVENT_GHOULPLOSION, 3s);
                events.ScheduleEvent(EVENT_RAISE_DEAD, 6s);
                events.ScheduleEvent(EVENT_RESUME_WP, 9s);
            }
            else
            {
                // No Geist: raise in 3s, resume in 6s
                events.ScheduleEvent(EVENT_RAISE_DEAD, 3s);
                events.ScheduleEvent(EVENT_RESUME_WP, 6s);
            }
        }
    }
};

/*######
## Persuasive Strike (Spell Script)
## Quest: How To Win Friends And Influence Enemies
## Note: texts signed for creature 28939 but used for 28939, 28940, 28610
######*/

enum win_friends
{
    SAY_CRUSADER             = 1,
    SAY_PERSUADED1           = 2,
    SAY_PERSUADED2           = 3,
    SAY_PERSUADED3           = 4,
    SAY_PERSUADED4           = 5,
    SAY_PERSUADED5           = 6,
    SAY_PERSUADED6           = 7,
    SAY_PERSUADE_RAND        = 8,
    QUEST_HOW_TO_WIN_FRIENDS = 12720,

    NPC_SCARLET_PREACHER     = 28939,
    NPC_SCARLET_COMMANDER    = 28936,
    NPC_SCARLET_CRUSADER     = 28940,
    NPC_SCARLET_MARKSMAN     = 28610,
    NPC_SCARLET_LORD_MCCREE  = 28964
};

// 52781 - Persuasive Strike
class spell_chapter2_persuasive_strike : public SpellScript
{
    PrepareSpellScript(spell_chapter2_persuasive_strike);

    bool Load() override
    {
        return GetCaster() && GetCaster()->IsPlayer()
            && GetCaster()->ToPlayer()->GetQuestStatus(QUEST_HOW_TO_WIN_FRIENDS) == QUEST_STATUS_INCOMPLETE;
    }

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        Creature* creature = GetHitCreature();
        Player* player = GetCaster()->ToPlayer();

        if (!creature || !player)
            return;

        if (!creature->EntryEquals(NPC_SCARLET_PREACHER, NPC_SCARLET_COMMANDER, NPC_SCARLET_CRUSADER, NPC_SCARLET_MARKSMAN, NPC_SCARLET_LORD_MCCREE))
            return;

        sCreatureTextMgr->SendChat(creature, SAY_PERSUADE_RAND, nullptr, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, player);

        if (roll_chance_f(30.0f))
        {
            creature->CombatStop(true);
            creature->GetMotionMaster()->MoveIdle();
            creature->SetImmuneToPC(true);
            creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            creature->SetReactState(REACT_PASSIVE);

            creature->AI()->Talk(SAY_PERSUADED1, 8s);
            creature->AI()->Talk(SAY_PERSUADED2, 16s);
            creature->AI()->Talk(SAY_PERSUADED3, 24s);
            creature->AI()->Talk(SAY_PERSUADED4, 32s);

            ObjectGuid playerGuid = player->GetGUID();

            creature->m_Events.AddEventAtOffset([creature, playerGuid]
            {
                if (Player* caster = ObjectAccessor::GetPlayer(*creature, playerGuid))
                    sCreatureTextMgr->SendChat(creature, SAY_PERSUADED5, nullptr, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, caster);
            }, 40s);

            creature->m_Events.AddEventAtOffset([creature, playerGuid]
            {
                creature->AI()->Talk(SAY_PERSUADED6);

                if (Player* caster = ObjectAccessor::GetPlayer(*creature, playerGuid))
                {
                    Unit::Kill(caster, creature);
                    caster->GroupEventHappens(QUEST_HOW_TO_WIN_FRIENDS, creature);
                }
                else
                    creature->KillSelf();
            }, 48s);
        }
        else
            creature->AI()->Talk(SAY_CRUSADER, 1s);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_chapter2_persuasive_strike::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/*######
## Portal Effect: Acherus (Spell Script)
## Quest: Scarlet Armies Approach...
## Note: Casted by Orbaz Bloodbane
######*/

enum AcherusPortal
{
    SPELL_PORTAL_EFFECT_ACHERUS   = 53098,
    QUEST_SCARLET_ARMIES_APPROACH = 12757
};

class spell_portal_effect_acherus : public SpellScript
{
    PrepareSpellScript(spell_portal_effect_acherus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PORTAL_EFFECT_ACHERUS });
    }

    SpellCastResult CheckCast()
    {
        Unit* target = GetExplTargetUnit();
        if (target && target->IsPlayer() && target->ToPlayer()->HasQuest(QUEST_SCARLET_ARMIES_APPROACH))
            return SPELL_CAST_OK;

        return SPELL_FAILED_DONT_REPORT;
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (Player* player = GetHitPlayer())
                caster->CastSpell(player, GetEffectValue(), true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_portal_effect_acherus::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_portal_effect_acherus::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Devour Humanoid (Spell Script)
## Quest: An End To All Things...
## Note: Used by Frostbrood Vanquisher
######*/

enum DevourHumanoid
{
    NPC_HEARTHGLEN_CRUSADER = 29102,
    NPC_TIRISFAL_CRUSADER   = 29103
};

// 53110 - Devour Humanoid
class spell_q12779_an_end_to_all_things : public SpellScript
{
    PrepareSpellScript(spell_q12779_an_end_to_all_things);

    SpellCastResult CheckCast()
    {
        if (Unit* caster = GetCaster())
            if (caster->FindNearestCreature(NPC_HEARTHGLEN_CRUSADER, 15.0f, true) || caster->FindNearestCreature(NPC_TIRISFAL_CRUSADER, 15.0f, true))
                return SPELL_CAST_OK;

        return SPELL_FAILED_BAD_TARGETS;
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Creature* c = GetHitUnit()->ToCreature())
            if (Unit* caster = GetCaster())
            {
                c->AI()->AttackStart(caster);
                c->CastSpell(caster, GetEffectValue(), true); // 53111
            }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q12779_an_end_to_all_things::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_q12779_an_end_to_all_things::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 53111 - Devour Humanoid (casted by the devoured creature)
class spell_q12779_an_end_to_all_things_devour_aura : public AuraScript
{
    PrepareAuraScript(spell_q12779_an_end_to_all_things_devour_aura);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetTarget();
        if (!caster || !target)
            return;

        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
        {
            caster->SetDisableGravity(true);
            Unit::Kill(target, caster);
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_q12779_an_end_to_all_things_devour_aura::OnRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
    }
};

/*######
## The Light of Dawn Game Event
## Quest: The Light of Dawn
######*/

enum LightOfDawnSays
{
    SAY_LIGHT_OF_DAWN01               = 0, // pre text
    SAY_LIGHT_OF_DAWN02               = 1,
    SAY_LIGHT_OF_DAWN03               = 2,
    SAY_LIGHT_OF_DAWN04               = 3, // intro
    SAY_LIGHT_OF_DAWN05               = 4,
    SAY_LIGHT_OF_DAWN06               = 5,
    SAY_LIGHT_OF_DAWN07               = 6, // During the fight - Korfax, Champion of the Light
    SAY_LIGHT_OF_DAWN08               = 7, // Lord Maxwell Tyrosus
    SAY_LIGHT_OF_DAWN09               = 8, // Highlord Darion Mograine
    SAY_LIGHT_OF_DAWN25               = 24, // After the fight
    SAY_LIGHT_OF_DAWN26               = 25, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN27               = 26, // Highlord Darion Mograine
    SAY_LIGHT_OF_DAWN28               = 27, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN29               = 28, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN30               = 29, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN31               = 30, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN32               = 31, // Highlord Alexandros Mograine
    SAY_LIGHT_OF_DAWN33               = 32, // Highlord Darion Mograine
    SAY_LIGHT_OF_DAWN34               = 33, // Highlord Darion Mograine
    SAY_LIGHT_OF_DAWN35               = 34, // Darion Mograine
    SAY_LIGHT_OF_DAWN36               = 35, // Darion Mograine
    SAY_LIGHT_OF_DAWN37               = 36, // Highlord Alexandros Mograine
    SAY_LIGHT_OF_DAWN38               = 37, // Darion Mograine
    SAY_LIGHT_OF_DAWN39               = 38, // Highlord Alexandros Mograine
    SAY_LIGHT_OF_DAWN40               = 39, // Darion Mograine
    SAY_LIGHT_OF_DAWN41               = 40, // Highlord Alexandros Mograine
    SAY_LIGHT_OF_DAWN42               = 41, // Highlord Alexandros Mograine
    SAY_LIGHT_OF_DAWN43               = 42, // The Lich King
    SAY_LIGHT_OF_DAWN44               = 43, // Highlord Darion Mograine
    SAY_LIGHT_OF_DAWN45               = 44, // The Lich King
    SAY_LIGHT_OF_DAWN46               = 45, // The Lich King
    SAY_LIGHT_OF_DAWN47               = 46, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN48               = 47, // The Lich King
    SAY_LIGHT_OF_DAWN49               = 48, // The Lich King
    SAY_LIGHT_OF_DAWN50               = 49, // Lord Maxwell Tyrosus
    SAY_LIGHT_OF_DAWN51               = 50, // The Lich King
    SAY_LIGHT_OF_DAWN52               = 51, // Highlord Darion Mograine
    SAY_LIGHT_OF_DAWN53               = 52, // Highlord Darion Mograine
    SAY_LIGHT_OF_DAWN54               = 53, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN55               = 54, // The Lich King
    SAY_LIGHT_OF_DAWN56               = 55, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN57               = 56, // The Lich King
    SAY_LIGHT_OF_DAWN58               = 57, // The Lich King
    SAY_LIGHT_OF_DAWN59               = 58, // The Lich King
    SAY_LIGHT_OF_DAWN60               = 59, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN61               = 60, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN62               = 61, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN63               = 62, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN64               = 63, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN65               = 64, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN66               = 65, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN67               = 66, // Highlord Tirion Fordring
    SAY_LIGHT_OF_DAWN68               = 67, // Highlord Darion Mograine

    EMOTE_LIGHT_OF_DAWN01             = 68,  // Emotes
    EMOTE_LIGHT_OF_DAWN02             = 69,
    EMOTE_LIGHT_OF_DAWN03             = 70,
    EMOTE_LIGHT_OF_DAWN04             = 71,
    EMOTE_LIGHT_OF_DAWN05             = 72,
    EMOTE_LIGHT_OF_DAWN06             = 73,
    EMOTE_LIGHT_OF_DAWN07             = 74,
    EMOTE_LIGHT_OF_DAWN08             = 75,
    EMOTE_LIGHT_OF_DAWN09             = 76,
    EMOTE_LIGHT_OF_DAWN10             = 77,
    EMOTE_LIGHT_OF_DAWN11             = 78,
    EMOTE_LIGHT_OF_DAWN12             = 79,
    EMOTE_LIGHT_OF_DAWN13             = 80,
    EMOTE_LIGHT_OF_DAWN14             = 81,
    EMOTE_LIGHT_OF_DAWN15             = 82,
    EMOTE_LIGHT_OF_DAWN16             = 83,
    EMOTE_LIGHT_OF_DAWN17             = 84,
    EMOTE_LIGHT_OF_DAWN18             = 85
};

enum LightOfDawnEncounter
{
    // Intro Events
    EVENT_START_COUNTDOWN_1             = 1,
    EVENT_START_COUNTDOWN_2,
    EVENT_START_COUNTDOWN_3,
    EVENT_START_COUNTDOWN_4,
    EVENT_START_COUNTDOWN_5,
    EVENT_START_COUNTDOWN_6,
    EVENT_START_COUNTDOWN_7,
    EVENT_START_COUNTDOWN_8,
    EVENT_START_COUNTDOWN_9,
    EVENT_START_COUNTDOWN_10,
    EVENT_START_COUNTDOWN_11,
    EVENT_START_COUNTDOWN_12,
    EVENT_START_COUNTDOWN_13,
    EVENT_START_COUNTDOWN_14,
    // Fight Events
    EVENT_SPELL_ANTI_MAGIC_ZONE,
    EVENT_SPELL_DEATH_STRIKE,
    EVENT_SPELL_DEATH_EMBRACE,
    EVENT_SPELL_UNHOLY_BLIGHT,
    EVENT_SPELL_DARION_MOD_DAMAGE,
    // Positioning
    EVENT_FINISH_FIGHT_1,
    EVENT_FINISH_FIGHT_2,
    EVENT_FINISH_FIGHT_3,
    EVENT_FINISH_FIGHT_4,
    EVENT_FINISH_FIGHT_5,
    // Outro
    EVENT_OUTRO_SCENE_1,
    EVENT_OUTRO_SCENE_2,
    EVENT_OUTRO_SCENE_3,
    EVENT_OUTRO_SCENE_4,
    EVENT_OUTRO_SCENE_5,
    EVENT_OUTRO_SCENE_6,
    EVENT_OUTRO_SCENE_7,
    EVENT_OUTRO_SCENE_8,
    EVENT_OUTRO_SCENE_9,
    EVENT_OUTRO_SCENE_10,
    EVENT_OUTRO_SCENE_11,
    EVENT_OUTRO_SCENE_12,
    EVENT_OUTRO_SCENE_13,
    EVENT_OUTRO_SCENE_14,
    EVENT_OUTRO_SCENE_15,
    EVENT_OUTRO_SCENE_16,
    EVENT_OUTRO_SCENE_17,
    EVENT_OUTRO_SCENE_18,
    EVENT_OUTRO_SCENE_19,
    EVENT_OUTRO_SCENE_20,
    EVENT_OUTRO_SCENE_21,
    EVENT_OUTRO_SCENE_22,
    EVENT_OUTRO_SCENE_23,
    EVENT_OUTRO_SCENE_24,
    EVENT_OUTRO_SCENE_25,
    EVENT_OUTRO_SCENE_26,
    EVENT_OUTRO_SCENE_27,
    EVENT_OUTRO_SCENE_28,
    EVENT_OUTRO_SCENE_29,
    EVENT_OUTRO_SCENE_30,
    EVENT_OUTRO_SCENE_31,
    EVENT_OUTRO_SCENE_32,
    EVENT_OUTRO_SCENE_33,
    EVENT_OUTRO_SCENE_34,
    EVENT_OUTRO_SCENE_35,
    EVENT_OUTRO_SCENE_36,
    EVENT_OUTRO_SCENE_37,
    EVENT_OUTRO_SCENE_38,
    EVENT_OUTRO_SCENE_39,
    EVENT_OUTRO_SCENE_40,
    EVENT_OUTRO_SCENE_41,
    EVENT_OUTRO_SCENE_42,
    EVENT_OUTRO_SCENE_43,
    EVENT_OUTRO_SCENE_44,
    EVENT_OUTRO_SCENE_45,
    EVENT_OUTRO_SCENE_46,
    EVENT_OUTRO_SCENE_47,
    EVENT_OUTRO_SCENE_48,
    EVENT_OUTRO_SCENE_49,
    EVENT_OUTRO_SCENE_50,
    EVENT_OUTRO_SCENE_51,
    EVENT_OUTRO_SCENE_52,
    EVENT_OUTRO_SCENE_53,
    EVENT_OUTRO_SCENE_54,
    EVENT_OUTRO_SCENE_55,
    EVENT_OUTRO_SCENE_56,
    EVENT_OUTRO_SCENE_57,
    EVENT_OUTRO_SCENE_58,
    EVENT_OUTRO_SCENE_59,
    EVENT_OUTRO_SCENE_60,
    EVENT_OUTRO_SCENE_61,

    ACTION_START_EVENT                  = 1,
    ACTION_PLAY_EMOTE                   = 1,
    ACTION_POSITION_NPCS                = 2,

    ENCOUNTER_START_TIME                = 5,
    ENCOUNTER_TOTAL_DEFENDERS           = 300,
    ENCOUNTER_TOTAL_SCOURGE             = 10000,

    ENCOUNTER_STATE_NONE                = 0,
    ENCOUNTER_STATE_FIGHT               = 1,
    ENCOUNTER_STATE_OUTRO               = 2,
};

enum LightOfDawnNPCs
{
    // Defenders
    NPC_DEFENDER_OF_THE_LIGHT           = 29174,
    NPC_KORFAX_CHAMPION_OF_THE_LIGHT    = 29176,
    NPC_COMMANDER_ELIGOR_DAWNBRINGER    = 29177,
    NPC_LORD_MAXWELL_TYROSUS            = 29178,
    NPC_LEONID_BARTHALOMEW_THE_REVERED  = 29179,
    NPC_DUKE_NICHOLAS_ZVERENHOFF        = 29180,
    NPC_RAYNE                           = 29181,
    NPC_RIMBLAT_EARTHSHATTER            = 29182,

    // Scourge
    NPC_RAMPAGING_ABOMINATION           = 29186,
    NPC_ACHERUS_GHOUL                   = 29219,
    NPC_WARRIOR_OF_THE_FROZEN_WASTES    = 29206,
    NPC_FLESH_BEHEMOTH                  = 29190,

    NPC_HIGHLORD_DARION_MOGRAINE        = 29173,
    NPC_KOLTIRA_DEATHWEAVER             = 29199,
    NPC_ORBAZ_BLOODBANE                 = 29204,
    NPC_THASSARIAN                      = 29200,

    // Outro
    NPC_HIGHLORD_TIRION_FORDRING        = 29175,
    NPC_HIGHLORD_ALEXANDROS_MOGRAINE    = 29227, // ghost
    NPC_DARION_MOGRAINE                 = 29228, // ghost
    NPC_THE_LICH_KING                   = 29183,
};

enum LightOfDawnGOs
{
    GO_HOLY_LIGHTNING                   = 191301,
    GO_LIGHT_OF_DAWN                    = 191330
};

enum LightOfDawnSpells
{
    // Intro Spells
    SPELL_CAMERA_SHAKE_INIT             = 36455,
    SPELL_CAMERA_SHAKE                  = 39983,
    SPELL_THE_MIGHT_OF_MOGRAINE         = 53642,

    // Mograine Fight
    SPELL_ANTI_MAGIC_ZONE1              = 52893,
    SPELL_DEATH_STRIKE                  = 53639,
    SPELL_DEATH_EMBRACE                 = 53635,
    SPELL_ICY_TOUCH1                    = 49723,
    SPELL_UNHOLY_BLIGHT                 = 53640,
    SPELL_DARION_MOD_DAMAGE             = 53645,

    // Outro
    SPELL_THE_LIGHT_OF_DAWN             = 53658,
    SPELL_ALEXANDROS_MOGRAINE_SPAWN     = 53667,
    SPELL_ICEBOUND_VISAGE               = 53274,
    SPELL_SOUL_FEAST_ALEX               = 53677,
    SPELL_MOGRAINE_CHARGE               = 53679,
    SPELL_REBUKE                        = 53680,
    SPELL_SOUL_FEAST_TIRION             = 53685,
    SPELL_APOCALYPSE                    = 53210,
    SPELL_THROW_ASHBRINGER              = 53701,
    SPELL_REBIRTH_OF_THE_ASHBRINGER     = 53702,
    SPELL_TIRION_CHARGE                 = 53705,
    SPELL_EXIT_TELEPORT_VISUAL          = 61456,
    SPELL_LAY_ON_HANDS                  = 53778,
    SPELL_THE_LIGHT_OF_DAWN_Q           = 53606
};

const Position LightOfDawnPos[] =
{
    {2304.2f, -5290.7f, 82.01f, 4.56f},         // 0  First Home Pos
    {2253.5f, -5310.6f, 82.17f, 5.28f},         // 1  Second Home Pos
    {2169.1f, -5227.1f, 82.59f, 5.7f},          // 2  Orbaz Flee Pos
    {2289.259f, -5280.355f, 86.112f, 4.41f},    // 3  Koltira Loc1
    {2273.289f, -5273.675f, 86.701f, 5.01f},    // 4  Thassarian Loc1
    {2280.81f, -5284.09f, 86.608f, 4.76f},      // 5  Morgraine Loc1
    {2165.711f, -5266.1235f, 95.5025f, 0.13962634f },   // 6  Tirion Summon loc
    {2281.198f, -5257.397f, 80.224f, 4.66f},    // 7  Alexandros loc1
    {2281.156f, -5259.934f, 80.647f, 0},        // 8  Alexandros loc2
    {2281.294f, -5281.895f, 82.445f, 1.35f},    // 9  Darion loc1
    {2281.093f, -5263.013f, 81.125f, 0},        // 10 Darion loc2
    {2283.896f, -5287.914f, 83.066f, 1.55f},    // 11 Tirion Fordring loc2
    {2280.304f, -5257.205f, 80.09781f, 4.6251f },// 12 Lich King spawns
    {2280.687f, -5262.276f, 81.082634f, 0.0f   },// 13 Lich king moves forward
    {2264.27f, -5267.29f, 80.16f, 0},           // 14 Tirion Fordring loc3
    {2270.99f, -5278.00f, 81.89f, 0}            // 15 Tirion Fordring loc4
};

const Position LightOfDawnFightPos[] =
{
    {2279.68f, -5256.75f, 79.79f, 4.8f},
    {2280.40f, -5276.56f, 82.11f, 4.8f},
    {2256.43f, -5281.3f, 82.29f, 5.0f},
    {2251.87f, -5304.08f, 82.17f, 4.8f},
    {2244.88f, -5256.03f, 74.88f, 5.8f},
    {2294.29f, -5281.35f, 81.91f, 4.8f},
    {2314.2f, -5268.1f, 82.43f, 3.6f},
    {2289.72f, -5299.65f, 83.49f, 3.2f},
    {2274.02f, -5303.58f, 85.05f, 1.4f},
    {2258.42f, -5307.72f, 81.98f, 0.1f}
};

class DelayedSummonEvent : public BasicEvent
{
public:
    DelayedSummonEvent(Unit* owner, uint32 entry, Position pos) : _owner(owner), _entry(entry), _pos(pos) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner->SummonCreature(_entry, _pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
        return true;
    }

private:
    Unit* _owner;
    uint32 _entry;
    Position _pos;
};

struct npc_highlord_darion_mograine : public ScriptedAI
{
    npc_highlord_darion_mograine(Creature* creature) : ScriptedAI(creature), summons(me)
    {
        battleStarted = ENCOUNTER_STATE_NONE;
        me->SetCorpseDelay(3 * 60);
        me->SetRespawnTime(3 * 60);
        resetExecuted = false;
    }

    EventMap events;
    SummonList summons;
    uint32 startTimeRemaining;
    uint32 defendersRemaining;
    uint32 scourgeRemaining;
    uint8 battleStarted;
    bool resetExecuted;

    void sGossipHello(Player* player) override
    {
        ClearGossipMenuFor(player);

        if (me->IsQuestGiver())
            player->PrepareQuestMenu(me->GetGUID());

        if (player->GetQuestStatus(12801) == QUEST_STATUS_INCOMPLETE && !GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SOLDIERS_ENABLE))
            AddGossipItemFor(player, 9795, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        if (player->PlayerTalkClass->GetGossipOptionAction(gossipListId) == GOSSIP_ACTION_INFO_DEF + 1)
        {
            ClearGossipMenuFor(player);
            CloseGossipMenuFor(player);
            DoAction(ACTION_START_EVENT);
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_START_EVENT && !startTimeRemaining && events.Empty())
        {
            Talk(SAY_LIGHT_OF_DAWN01);

            startTimeRemaining = ENCOUNTER_START_TIME;
            defendersRemaining = ENCOUNTER_TOTAL_DEFENDERS;
            scourgeRemaining = ENCOUNTER_TOTAL_SCOURGE;

            SendInitialWorldStates();

            events.Reset();
            events.ScheduleEvent(EVENT_START_COUNTDOWN_1, 60s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_2, 120s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_3, 180s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_4, 240s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_5, 300s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_6, 308s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_7, 312s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_8, 316s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_9, 320s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_10, 324s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_11, 332s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_12, 335s);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_13, 337s + 500ms);
            events.ScheduleEvent(EVENT_START_COUNTDOWN_14, 345s);
        }
    }

    uint32 GetData(uint32 type) const override
    {
        switch (type)
        {
            case WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_DEFENDERS_COUNT:
                return defendersRemaining;
            case WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SCOURGE_COUNT:
                return scourgeRemaining;
            case WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SOLDIERS_ENABLE:
                return me->IsAlive() && (startTimeRemaining || battleStarted);
            case WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_ENABLE:
                return me->IsAlive() && startTimeRemaining;
            case WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME:
                return startTimeRemaining;
            case WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_EVENT_BEGIN_ENABLE:
                return me->IsAlive() && !startTimeRemaining && battleStarted;
        }
        return 0;
    }

    void SendUpdateWorldState(uint32 id, uint32 state)
    {
        Map::PlayerList const& players = me->GetMap()->GetPlayers();
        if (!players.IsEmpty())
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                if (Player* player = itr->GetSource())
                    if (player->GetPhaseMask() & 128) // Xinef: client skips players without chapter 5 aura anyway, speedup
                        player->SendUpdateWorldState(id, state);
    }

    void SendInitialWorldStates()
    {
        SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_DEFENDERS_COUNT, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_DEFENDERS_COUNT));
        SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SCOURGE_COUNT, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SCOURGE_COUNT));
        SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SOLDIERS_ENABLE, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SOLDIERS_ENABLE));
        SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_ENABLE, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_ENABLE));
        SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME));
        SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_EVENT_BEGIN_ENABLE, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_EVENT_BEGIN_ENABLE));
    }

    void JustSummoned(Creature* cr) override
    {
        summons.Summon(cr);

        if (me->IsInCombat() && cr->GetEntry() != NPC_HIGHLORD_TIRION_FORDRING && battleStarted == ENCOUNTER_STATE_FIGHT)
        {
            Position pos = LightOfDawnFightPos[urand(0, 9)];
            if (Unit* target = cr->SelectNearbyTarget(nullptr, 10.0f))
                if (target->IsCreature())
                    target->GetMotionMaster()->MoveCharge(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), me->GetSpeed(MOVE_RUN));
            cr->GetMotionMaster()->MoveCharge(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), me->GetSpeed(MOVE_RUN));
        }

        if (battleStarted == ENCOUNTER_STATE_OUTRO && cr->GetEntry() == NPC_DEFENDER_OF_THE_LIGHT)
        {
            cr->SetReactState(REACT_PASSIVE);
            cr->SetImmuneToAll(true);
            cr->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
            cr->HandleEmoteCommand(EMOTE_STATE_READY1H);
        }
    }

    void SummonedCreatureDies(Creature* creature, Unit*) override
    {
        // Refill Armies and update counters
        if (battleStarted != ENCOUNTER_STATE_FIGHT)
            return;

        me->m_Events.AddEventAtOffset(new DelayedSummonEvent(me, creature->GetEntry(), *creature), 3s);
        if (creature->GetEntry() >= NPC_RAMPAGING_ABOMINATION)
        {
            --scourgeRemaining;
            SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SCOURGE_COUNT, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_SCOURGE_COUNT));
        }
        else
        {
            --defendersRemaining;
            SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_DEFENDERS_COUNT, GetData(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_DEFENDERS_COUNT));

            if (defendersRemaining == 200)
                FinishFight();
        }
    }

    void JustDied(Unit*) override
    {
        summons.DespawnAll();
        me->SetCorpseDelay(3 * 60);
        me->SetRespawnTime(3 * 60);
    }

    void FinishFight()
    {
        if (Creature* tirion = me->SummonCreature(NPC_HIGHLORD_TIRION_FORDRING, LightOfDawnPos[6], TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000))
        {
            tirion->LoadEquipment(0, true);
            tirion->AI()->Talk(SAY_LIGHT_OF_DAWN25, 4s);

            tirion->m_Events.AddEventAtOffset([&, tirion] {
                tirion->GetMotionMaster()->MoveWaypoint(NPC_HIGHLORD_TIRION_FORDRING * 10, false);
            }, 14s);

            events.Reset();
            events.ScheduleEvent(EVENT_FINISH_FIGHT_1, 10s);
            events.ScheduleEvent(EVENT_FINISH_FIGHT_2, 20s);
            events.ScheduleEvent(EVENT_FINISH_FIGHT_3, 22s);
            events.ScheduleEvent(EVENT_FINISH_FIGHT_4, 23s);
            events.ScheduleEvent(EVENT_FINISH_FIGHT_5, 24s);

            tirion->SummonGameObject(GO_HOLY_LIGHTNING, 2254.84f, -5298.75f, 82.168f, 1.134f, 0, 0, 0.537102f, 0.843517f, 20);
            tirion->SummonGameObject(GO_HOLY_LIGHTNING, 2296.24f, -5296.44f, 81.9964f, 5.3398f, 0, 0, 0.454395f, -0.8908f, 20);
            tirion->SummonGameObject(GO_HOLY_LIGHTNING, 2314.29f, -5261.78f, 83.1349f, 3.05822f, 0, 0, 0.999131f, 0.0416735f, 20);
            tirion->SummonGameObject(GO_HOLY_LIGHTNING, 2278.43f, -5270.14f, 81.7247f, 0.70988f, 0, 0, 0.347534f, 0.937667f, 20);
        }
    }

    void JustEngagedWith(Unit*) override
    {
        if (battleStarted != ENCOUNTER_STATE_FIGHT)
            return;

        events.RescheduleEvent(EVENT_SPELL_ANTI_MAGIC_ZONE, 15s);
        events.RescheduleEvent(EVENT_SPELL_DEATH_STRIKE, 8s);
        events.RescheduleEvent(EVENT_SPELL_DEATH_EMBRACE, 5s);
        events.RescheduleEvent(EVENT_SPELL_UNHOLY_BLIGHT, 10s);
        events.RescheduleEvent(EVENT_SPELL_DARION_MOD_DAMAGE, 500ms);
    }

    void Reset() override
    {
        if (resetExecuted)
            return;

        resetExecuted = true;
        JustRespawned();
    }

    void JustRespawned() override
    {
        events.Reset();
        summons.DespawnAll();

        me->SetImmuneToAll(true);
        me->LoadEquipment(1, true);
        me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        me->SetStandState(UNIT_STAND_STATE_STAND);
        me->SetVisible(true);
        me->setActive(true);
        me->SetWalk(false);

        battleStarted = ENCOUNTER_STATE_NONE;
        startTimeRemaining = 0;
        defendersRemaining = 0;
        scourgeRemaining = 0;

        SendInitialWorldStates();
        me->SummonCreatureGroup(30);
    }

    Creature* GetEntryFromSummons(uint32 entry)
    {
        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
            if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                if (summon->GetEntry() == entry)
                    return summon;
        return nullptr;
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == POINT_MOTION_TYPE && point == 2)
        {
            me->RemoveAurasDueToSpell(SPELL_THE_LIGHT_OF_DAWN);
            Talk(EMOTE_LIGHT_OF_DAWN05);
            events.Reset();

            events.ScheduleEvent(EVENT_OUTRO_SCENE_1, 2s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_2, 19s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_3, 38s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_4, 50s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_5, 62s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_6, 68s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_7, 71s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_8, 72s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_9, 74s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_10, 77s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_11, 79s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_12, 82s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_13, 85s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_14, 92s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_15, 98s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_16, 105s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_17, 120s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_18, 131s);
            events.ScheduleEvent(EVENT_OUTRO_SCENE_19, 158s);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        uint32 eventId = events.ExecuteEvent();

        switch (eventId)
        {
            case EVENT_START_COUNTDOWN_1:
                SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME, 4);
                break;
            case EVENT_START_COUNTDOWN_2:
                SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME, 3);
                break;
            case EVENT_START_COUNTDOWN_3:
                SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME, 2);
                break;
            case EVENT_START_COUNTDOWN_4:
                Talk(SAY_LIGHT_OF_DAWN02);
                SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME, 1);
                break;
            case EVENT_START_COUNTDOWN_5:
                battleStarted = ENCOUNTER_STATE_FIGHT;
                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                Talk(SAY_LIGHT_OF_DAWN04); // Wrong order in DB!
                SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_TIME, 0);
                SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_COUNTDOWN_ENABLE, 0);
                SendUpdateWorldState(WORLD_STATE_BATTLE_FOR_LIGHTS_HOPE_EVENT_BEGIN_ENABLE, 1);
                break;
            case EVENT_START_COUNTDOWN_6:
            case EVENT_START_COUNTDOWN_7:
            case EVENT_START_COUNTDOWN_8:
            case EVENT_START_COUNTDOWN_9:
            case EVENT_START_COUNTDOWN_10:
                if (eventId == EVENT_START_COUNTDOWN_6)
                {
                    Talk(SAY_LIGHT_OF_DAWN05);
                    me->CastSpell(me, SPELL_CAMERA_SHAKE_INIT, true);
                }
                else
                    me->CastSpell(me, SPELL_CAMERA_SHAKE, true);
                me->SummonCreatureGroup(eventId - EVENT_START_COUNTDOWN_6);
                break;
            case EVENT_START_COUNTDOWN_11:
                Talk(SAY_LIGHT_OF_DAWN06);
                break;
            case EVENT_START_COUNTDOWN_12:
                summons.DoAction(ACTION_PLAY_EMOTE);
                break;
            case EVENT_START_COUNTDOWN_13:
                {
                    uint8 first = 1;
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    {
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                        {
                            Position pos = LightOfDawnPos[first];
                            summon->SetHomePosition(pos);
                            summon->GetMotionMaster()->MovePoint(1, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, true, false);
                        }
                        first = first == 0 ? 1 : 0;
                    }
                    Position pos = LightOfDawnPos[first];
                    me->SetHomePosition(pos);
                    me->SetWalk(false);
                    me->GetMotionMaster()->MovePoint(1, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, true, true);
                    DoCastSelf(SPELL_THE_MIGHT_OF_MOGRAINE, true);
                    break;
                }
            case EVENT_START_COUNTDOWN_14:
                me->SetImmuneToAll(false);
                me->SummonCreatureGroup(5);
                return;
            case EVENT_FINISH_FIGHT_1:
                summons.DespawnEntry(NPC_DEFENDER_OF_THE_LIGHT);
                battleStarted = ENCOUNTER_STATE_OUTRO;
                break;
            case EVENT_FINISH_FIGHT_2:
                {
                    summons.DespawnEntry(NPC_RAMPAGING_ABOMINATION);
                    summons.DespawnEntry(NPC_ACHERUS_GHOUL);
                    summons.DespawnEntry(NPC_WARRIOR_OF_THE_FROZEN_WASTES);
                    summons.DespawnEntry(NPC_FLESH_BEHEMOTH);
                    summons.DespawnEntry(NPC_DEFENDER_OF_THE_LIGHT);

                    if (Creature* orbaz = GetEntryFromSummons(NPC_ORBAZ_BLOODBANE))
                    {
                        orbaz->SetReactState(REACT_PASSIVE);
                        orbaz->AI()->Talk(EMOTE_LIGHT_OF_DAWN04);
                        orbaz->GetMotionMaster()->MovePoint(2, LightOfDawnPos[2], FORCED_MOVEMENT_NONE, 0.f, true, true);
                        orbaz->DespawnOrUnsummon(7s);
                    }

                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                        {
                            summon->CombatStop(true);
                            summon->GetThreatMgr().ClearAllThreat();
                            summon->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            summon->SetImmuneToAll(true);
                            summon->SetReactState(REACT_PASSIVE);
                            summon->GetMotionMaster()->Clear(false);
                        }
                    me->CombatStop(true);
                    me->GetThreatMgr().ClearAllThreat();
                    me->SetImmuneToAll(true);
                    me->SetReactState(REACT_PASSIVE);
                    me->GetMotionMaster()->Clear(false);

                    // Position main stars
                    summons.DoAction(ACTION_POSITION_NPCS);

                    me->SummonCreature(NPC_DEFENDER_OF_THE_LIGHT, 2276.66f, -5273.60f, 81.86f, 5.14f, TEMPSUMMON_CORPSE_DESPAWN);
                    me->SummonCreature(NPC_DEFENDER_OF_THE_LIGHT, 2272.11f, -5279.08f, 82.01f, 5.69f, TEMPSUMMON_CORPSE_DESPAWN);
                    me->SummonCreature(NPC_DEFENDER_OF_THE_LIGHT, 2285.11f, -5276.73f, 82.08f, 4.23f, TEMPSUMMON_CORPSE_DESPAWN);
                    me->SummonCreature(NPC_DEFENDER_OF_THE_LIGHT, 2290.06f, -5286.41f, 82.51f, 3.16f, TEMPSUMMON_CORPSE_DESPAWN);
                    break;
                }
            case EVENT_FINISH_FIGHT_3:
                if (Creature* koltira = GetEntryFromSummons(NPC_KOLTIRA_DEATHWEAVER))
                {
                    koltira->SetWalk(true);
                    koltira->SetHomePosition(*koltira);
                    koltira->CastSpell(koltira, SPELL_THE_LIGHT_OF_DAWN, false);
                    koltira->GetMotionMaster()->MoveCharge(LightOfDawnPos[3].GetPositionX(), LightOfDawnPos[3].GetPositionY(), LightOfDawnPos[3].GetPositionZ(), 4.0f, 2);
                }
                break;
            case EVENT_FINISH_FIGHT_4:
                if (Creature* thassarin = GetEntryFromSummons(NPC_THASSARIAN))
                {
                    thassarin->SetWalk(true);
                    thassarin->SetHomePosition(*thassarin);
                    thassarin->CastSpell(thassarin, SPELL_THE_LIGHT_OF_DAWN, false);
                    thassarin->GetMotionMaster()->MoveCharge(LightOfDawnPos[4].GetPositionX(), LightOfDawnPos[4].GetPositionY(), LightOfDawnPos[4].GetPositionZ(), 4.0f, 2);
                }
                break;
            case EVENT_FINISH_FIGHT_5:
                me->SetWalk(true);
                me->SetHomePosition(*me);
                me->RemoveAllAuras();
                me->CastSpell(me, SPELL_THE_LIGHT_OF_DAWN, false);
                me->GetMotionMaster()->MoveCharge(LightOfDawnPos[5].GetPositionX(), LightOfDawnPos[5].GetPositionY(), LightOfDawnPos[5].GetPositionZ(), 4.0f, 2);

                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN26);
                break;
            case EVENT_OUTRO_SCENE_1:
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                me->SetFacingTo(4.8f);
                Talk(SAY_LIGHT_OF_DAWN27);
                break;
            case EVENT_OUTRO_SCENE_2:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN28);
                break;
            case EVENT_OUTRO_SCENE_3:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN29);
                break;
            case EVENT_OUTRO_SCENE_4:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN30);
                break;
            case EVENT_OUTRO_SCENE_5:
                me->SetStandState(UNIT_STAND_STATE_STAND);
                Talk(SAY_LIGHT_OF_DAWN31);
                break;
            case EVENT_OUTRO_SCENE_6:
                if (Creature* alex = me->SummonCreature(NPC_HIGHLORD_ALEXANDROS_MOGRAINE, LightOfDawnPos[7].GetPositionX(), LightOfDawnPos[7].GetPositionY(), LightOfDawnPos[7].GetPositionZ(), LightOfDawnPos[7].GetOrientation(), TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 300000))
                {
                    alex->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    alex->GetMotionMaster()->MovePoint(0, LightOfDawnPos[8].GetPositionX(), LightOfDawnPos[8].GetPositionY(), LightOfDawnPos[8].GetPositionZ());
                    alex->CastSpell(alex, SPELL_ALEXANDROS_MOGRAINE_SPAWN, true);
                    //alex->AI()->Talk(EMOTE_LIGHT_OF_DAWN06);
                }
                break;
            case EVENT_OUTRO_SCENE_7:
                if (Creature* alex = GetEntryFromSummons(NPC_HIGHLORD_ALEXANDROS_MOGRAINE))
                {
                    alex->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    alex->AI()->Talk(SAY_LIGHT_OF_DAWN32);
                    me->SetFacingToObject(alex);
                }
                break;
            case EVENT_OUTRO_SCENE_8:
                Talk(SAY_LIGHT_OF_DAWN33);
                break;
            case EVENT_OUTRO_SCENE_9:
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                Talk(SAY_LIGHT_OF_DAWN34);
                break;
            case EVENT_OUTRO_SCENE_10:
                if (Creature* darion = me->SummonCreature(NPC_DARION_MOGRAINE, LightOfDawnPos[9].GetPositionX(), LightOfDawnPos[9].GetPositionY(), LightOfDawnPos[9].GetPositionZ(), LightOfDawnPos[9].GetOrientation(), TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 300000))
                {
                    darion->AI()->Talk(SAY_LIGHT_OF_DAWN35);
                    darion->SetWalk(false);
                }
                break;
            case EVENT_OUTRO_SCENE_11:
                if (Creature* darion = GetEntryFromSummons(NPC_DARION_MOGRAINE))
                {
                    //darion->AI()->Talk(EMOTE_LIGHT_OF_DAWN07);
                    darion->GetMotionMaster()->MovePoint(0, LightOfDawnPos[10].GetPositionX(), LightOfDawnPos[10].GetPositionY(), LightOfDawnPos[10].GetPositionZ());
                }
                break;
            case EVENT_OUTRO_SCENE_12:
                if (Creature* darion = GetEntryFromSummons(NPC_DARION_MOGRAINE))
                    darion->AI()->Talk(EMOTE_LIGHT_OF_DAWN08);
                break;
            case EVENT_OUTRO_SCENE_13:
                if (Creature* darion = GetEntryFromSummons(NPC_DARION_MOGRAINE))
                    darion->AI()->Talk(SAY_LIGHT_OF_DAWN36);
                break;
            case EVENT_OUTRO_SCENE_14:
                if (Creature* alex = GetEntryFromSummons(NPC_HIGHLORD_ALEXANDROS_MOGRAINE))
                    alex->AI()->Talk(SAY_LIGHT_OF_DAWN37);
                break;
            case EVENT_OUTRO_SCENE_15:
                if (Creature* darion = GetEntryFromSummons(NPC_DARION_MOGRAINE))
                    darion->AI()->Talk(SAY_LIGHT_OF_DAWN38);
                break;
            case EVENT_OUTRO_SCENE_16:
                if (Creature* alex = GetEntryFromSummons(NPC_HIGHLORD_ALEXANDROS_MOGRAINE))
                    alex->AI()->Talk(SAY_LIGHT_OF_DAWN39);

                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->GetMotionMaster()->MovePoint(0, LightOfDawnPos[11].GetPositionX(), LightOfDawnPos[11].GetPositionY(), LightOfDawnPos[11].GetPositionZ());
                break;
            case EVENT_OUTRO_SCENE_17:
                if (Creature* darion = GetEntryFromSummons(NPC_DARION_MOGRAINE))
                    darion->AI()->Talk(SAY_LIGHT_OF_DAWN40);
                break;
            case EVENT_OUTRO_SCENE_18:
                if (Creature* alex = GetEntryFromSummons(NPC_HIGHLORD_ALEXANDROS_MOGRAINE))
                    alex->AI()->Talk(SAY_LIGHT_OF_DAWN41);

                if (Creature* darion = GetEntryFromSummons(NPC_DARION_MOGRAINE))
                    darion->DespawnOrUnsummon(3s);
                break;
            case EVENT_OUTRO_SCENE_19:
                if (Creature* alex = GetEntryFromSummons(NPC_HIGHLORD_ALEXANDROS_MOGRAINE))
                    alex->AI()->Talk(SAY_LIGHT_OF_DAWN42);

                events.Reset();
                events.ScheduleEvent(EVENT_OUTRO_SCENE_20, 4s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_21, 4s + 500ms);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_22, 7s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_23, 9s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_24, 14s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_25, 21s + 200ms);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_26, 22s + 500ms);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_27, 24s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_28, 28s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_29, 34s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_30, 36s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_31, 51s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_32, 68s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_33, 73s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_34, 76s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_35, 77s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_36, 81s);
                break;
            case EVENT_OUTRO_SCENE_20:
                if (Creature* lk = me->SummonCreature(NPC_THE_LICH_KING, LightOfDawnPos[12].GetPositionX(), LightOfDawnPos[12].GetPositionY(), LightOfDawnPos[12].GetPositionZ(), LightOfDawnPos[12].GetOrientation(), TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 300000))
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN43);
                break;
            case EVENT_OUTRO_SCENE_21:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->CastSpell(lk, SPELL_ICEBOUND_VISAGE, true);
                break;
            case EVENT_OUTRO_SCENE_22:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                {
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN45);
                    if (Creature* alex = GetEntryFromSummons(NPC_HIGHLORD_ALEXANDROS_MOGRAINE))
                    {
                        alex->RemoveAllAuras();
                        lk->CastSpell(alex, SPELL_SOUL_FEAST_ALEX, false);
                    }
                }
                break;
            case EVENT_OUTRO_SCENE_23:
                if (Creature* alex = GetEntryFromSummons(NPC_HIGHLORD_ALEXANDROS_MOGRAINE))
                {
                    alex->DespawnOrUnsummon(5s);
                    alex->SetVisible(false);
                }
                break;
            case EVENT_OUTRO_SCENE_24:
                me->SetStandState(UNIT_STAND_STATE_STAND);
                Talk(SAY_LIGHT_OF_DAWN44);
                break;
            case EVENT_OUTRO_SCENE_25:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->GetMotionMaster()->MovePoint(0, LightOfDawnPos[13].GetPositionX(), LightOfDawnPos[13].GetPositionY(), LightOfDawnPos[13].GetPositionZ());
                break;
            case EVENT_OUTRO_SCENE_26:
                me->CastSpell(me, SPELL_MOGRAINE_CHARGE, false);
                break;
            case EVENT_OUTRO_SCENE_27:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                {
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN46);
                    // Mograine's charge puts him inside the Lich King's collision, so we need to teleport him out
                    // Otherwise, Rebuke will kick him the wrong direction
                    me->NearTeleportTo(2279.7493f, -5258.1f, 80.065f, 4.3419204f);
                    lk->m_Events.AddEventAtOffset([&, lk] {
                        lk->CastSpell(me, SPELL_REBUKE, false);
                    }, 1s);
                }
                break;
            case EVENT_OUTRO_SCENE_28:
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                {
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN47);
                    if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                        tirion->SetFacingToObject(lk);
                }
                break;
            case EVENT_OUTRO_SCENE_29:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                {
                    lk->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    lk->PlayDirectSound(14820);
                }
                break;
            case EVENT_OUTRO_SCENE_30:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN48);
                break;
            case EVENT_OUTRO_SCENE_31:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN49);
                break;
            case EVENT_OUTRO_SCENE_32:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                {
                    if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    {
                        lk->CastSpell(lk, SPELL_SOUL_FEAST_TIRION, false);
                        tirion->AI()->Talk(EMOTE_LIGHT_OF_DAWN12);
                    }

                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                            if (summon->GetEntry() <= NPC_RIMBLAT_EARTHSHATTER && summon->GetEntry() != NPC_HIGHLORD_TIRION_FORDRING)
                            {
                                float o = lk->GetAngle(summon);
                                summon->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                summon->GetMotionMaster()->MovePoint(3, lk->GetPositionX() + 2.0f * cos(o), lk->GetPositionY() + 2.0f * std::sin(o), lk->GetPositionZ());
                                summon->ToTempSummon()->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);
                            }
                }
                break;
            case EVENT_OUTRO_SCENE_33:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                {
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN51);
                    lk->CastSpell(lk, SPELL_APOCALYPSE, true);
                }
                break;
            case EVENT_OUTRO_SCENE_34:
                for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                        if (summon->GetEntry() <= NPC_RIMBLAT_EARTHSHATTER && summon->GetEntry() != NPC_HIGHLORD_TIRION_FORDRING)
                            Unit::Kill(summon, summon);
                break;
            case EVENT_OUTRO_SCENE_35:
                Talk(SAY_LIGHT_OF_DAWN52);
                break;
            case EVENT_OUTRO_SCENE_36:
                me->SetStandState(UNIT_STAND_STATE_STAND);
                Talk(SAY_LIGHT_OF_DAWN53);
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    me->SetFacingToObject(tirion);

                events.Reset();
                events.ScheduleEvent(EVENT_OUTRO_SCENE_37, 1s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_38, 5s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_39, 7s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_40, 9s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_41, 13s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_42, 16s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_43, 17s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_44, 19s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_45, 25s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_46, 32s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_47, 42s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_48, 52s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_49, 54s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_50, 58s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_51, 65s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_52, 70s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_53, 84s);
                break;
            case EVENT_OUTRO_SCENE_37:
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(EQUIP_UNEQUIP));
                me->CastSpell(me, SPELL_THROW_ASHBRINGER, true);
                break;
            case EVENT_OUTRO_SCENE_38:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                {
                    tirion->RemoveAllAuras();
                    tirion->CastSpell(me, SPELL_REBIRTH_OF_THE_ASHBRINGER, true);
                    tirion->SummonGameObject(GO_LIGHT_OF_DAWN, tirion->GetPositionX(), tirion->GetPositionY(), tirion->GetPositionZ(), tirion->GetOrientation(), 0, 0, 0, 0, 180);
                    tirion->LoadEquipment(1, true);
                }
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                break;
            case EVENT_OUTRO_SCENE_39:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                {
                    tirion->RemoveAllAuras();
                    tirion->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                }
                break;
            case EVENT_OUTRO_SCENE_40:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN54);
                break;
            case EVENT_OUTRO_SCENE_41:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN55);
                break;
            case EVENT_OUTRO_SCENE_42:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN56);
                break;
            case EVENT_OUTRO_SCENE_43:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                {
                    tirion->CastSpell(tirion, SPELL_TIRION_CHARGE, true);
                    tirion->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                    tirion->SetImmuneToAll(true);
                }
                break;
            case EVENT_OUTRO_SCENE_44:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN57);
                break;
            case EVENT_OUTRO_SCENE_45:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN58);
                break;
            case EVENT_OUTRO_SCENE_46:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                    lk->AI()->Talk(SAY_LIGHT_OF_DAWN59);
                break;
            case EVENT_OUTRO_SCENE_47:
                if (Creature* lk = GetEntryFromSummons(NPC_THE_LICH_KING))
                {
                    lk->CastSpell(lk, SPELL_EXIT_TELEPORT_VISUAL, true);
                    lk->DespawnOrUnsummon(1500ms);
                }

                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                {
                    float o = me->GetAngle(tirion);
                    tirion->GetMotionMaster()->MovePoint(4, me->GetPositionX() + 2.0f * cos(o), me->GetPositionY() + 2.0f * std::sin(o), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                    tirion->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                    tirion->SetFaction(FACTION_FRIENDLY);
                }
                break;
            case EVENT_OUTRO_SCENE_48:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->CastSpell(me, SPELL_LAY_ON_HANDS, false);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                break;
            case EVENT_OUTRO_SCENE_49:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                {
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN60);
                    tirion->SetWalk(true);
                }
                break;
            case EVENT_OUTRO_SCENE_50:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->GetMotionMaster()->MovePoint(4, LightOfDawnPos[14].GetPositionX(), LightOfDawnPos[14].GetPositionY(), LightOfDawnPos[14].GetPositionZ());
                break;
            case EVENT_OUTRO_SCENE_51:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->GetMotionMaster()->MovePoint(4, LightOfDawnPos[15].GetPositionX(), LightOfDawnPos[15].GetPositionY(), LightOfDawnPos[15].GetPositionZ());
                break;
            case EVENT_OUTRO_SCENE_52:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                {
                    tirion->SetFacingToObject(me);
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN61);
                }
                break;
            case EVENT_OUTRO_SCENE_53:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN62);

                events.Reset();
                events.ScheduleEvent(EVENT_OUTRO_SCENE_54, 6s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_55, 14s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_56, 27s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_57, 37s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_58, 44s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_59, 50s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_60, 63s);
                events.ScheduleEvent(EVENT_OUTRO_SCENE_61, 150s);
                break;
            case EVENT_OUTRO_SCENE_54:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN63);
                break;
            case EVENT_OUTRO_SCENE_55:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN64);
                break;
            case EVENT_OUTRO_SCENE_56:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN65);
                break;
            case EVENT_OUTRO_SCENE_57:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN66);
                break;
            case EVENT_OUTRO_SCENE_58:
                if (Creature* tirion = GetEntryFromSummons(NPC_HIGHLORD_TIRION_FORDRING))
                    tirion->AI()->Talk(SAY_LIGHT_OF_DAWN67);
                break;
            case EVENT_OUTRO_SCENE_59:
                Talk(SAY_LIGHT_OF_DAWN68);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                break;
            case EVENT_OUTRO_SCENE_60:
                {
                    Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
                    if (!PlayerList.IsEmpty())
                    {
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            if (i->GetSource()->IsAlive() && me->IsWithinDistInMap(i->GetSource(), 100))
                                i->GetSource()->CastSpell(i->GetSource(), SPELL_THE_LIGHT_OF_DAWN_Q, false);
                    }
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                    break;
                }
            case EVENT_OUTRO_SCENE_61:
                summons.DespawnAll();
                me->DespawnOrUnsummon(1ms);
                events.Reset();
                return;
        }

        if (battleStarted != ENCOUNTER_STATE_FIGHT)
            return;

        if (!UpdateVictim())
            return;

        switch (eventId)
        {
            case EVENT_SPELL_ANTI_MAGIC_ZONE:
                DoCast(me, SPELL_ANTI_MAGIC_ZONE1);
                events.RescheduleEvent(eventId, 30s, 45s);
                break;
            case EVENT_SPELL_DEATH_STRIKE:
                DoCastVictim(SPELL_DEATH_STRIKE);
                events.RescheduleEvent(eventId, 5s, 35s);
                break;
            case EVENT_SPELL_DEATH_EMBRACE:
                DoCastVictim(SPELL_DEATH_EMBRACE);
                events.RescheduleEvent(eventId, 45s, 60s);
                break;
            case EVENT_SPELL_UNHOLY_BLIGHT:
                DoCast(me, SPELL_UNHOLY_BLIGHT);
                events.RescheduleEvent(eventId, 60s);
                break;
            case EVENT_SPELL_DARION_MOD_DAMAGE:
                DoCast(me, SPELL_DARION_MOD_DAMAGE);
                Talk(SAY_LIGHT_OF_DAWN09);
                events.RescheduleEvent(eventId, 15s, 25s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

class spell_chapter5_light_of_dawn_aura : public AuraScript
{
    PrepareAuraScript(spell_chapter5_light_of_dawn_aura);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->Dismount();
        GetUnitOwner()->SetCanFly(true);
        GetUnitOwner()->SetDisableGravity(true);
        GetUnitOwner()->AddUnitMovementFlag(MOVEMENTFLAG_FLYING);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->SetCanFly(false);
        GetUnitOwner()->SetDisableGravity(false);
        GetUnitOwner()->RemoveUnitMovementFlag(MOVEMENTFLAG_FLYING);
        GetUnitOwner()->GetMotionMaster()->MoveFall();
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_chapter5_light_of_dawn_aura::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_chapter5_light_of_dawn_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

/*######
## Return to Capitals Npcs Behavior
Quest: 58552 - Return to Orgrimmar
Quest: 58533 - Return to Stormwind
######*/
enum ReturnToCapital
{
    SPELL_RETURN_TO_ORGRIMMAR_APPLE  = 58509,
    SPELL_RETURN_TO_ORGRIMMAR_BANANA = 58513,
    SPELL_RETURN_TO_ORGRIMMAR_SPIT   = 58520,

    EMOTE_THROW_APPLE    = 2,
    EMOTE_THROW_BANANA   = 3,
    EMOTE_THROW_SPIT     = 4,
    SAY_INSULT_TO_DK     = 5,

    NPC_SW_GUARD         = 68,
    NPC_ROYAL_GUARD      = 1756,
    NPC_CITY_PATROLLER   = 1976,
    NPC_OG_GUARD         = 3296,
    NPC_KOR_ELITE        = 14304,

    TEXT_BROADCAST_COWER = 31670 // "%s cowers in fear."
};

uint32 ReturnToCapitalSpells[3] =
{
    58509, // Apple
    58513, // Banana
    58520  // Spit
};

class spell_chapter5_return_to_capital : public SpellScript
{
    PrepareSpellScript(spell_chapter5_return_to_capital);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RETURN_TO_ORGRIMMAR_APPLE, SPELL_RETURN_TO_ORGRIMMAR_BANANA, SPELL_RETURN_TO_ORGRIMMAR_SPIT});
    }

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        Creature* creature = GetHitUnit()->ToCreature();
        Player* player = GetCaster()->ToPlayer();
        uint32 spellId = GetSpellInfo()->Id;

        if (!spellId || !creature || !player || player->IsGameMaster() || !player->IsAlive() || !creature->IsAlive() || creature->IsInCombat())
            return;

        if (creature->HasSpellCooldown(spellId))
            return;

        if (creature->GetEntry() == NPC_SW_GUARD || creature->GetEntry() == NPC_ROYAL_GUARD || creature->GetEntry() == NPC_CITY_PATROLLER || creature->GetEntry() == NPC_OG_GUARD || creature->GetEntry() == NPC_KOR_ELITE)
        {
            _emote = urand(2,4);
            if (creature)
            {
                creature->PauseMovement(5000);
                creature->SetFacingToObject(player, 30s);

                if (roll_chance_i(30))
                {
                    creature->AI()->Talk(_emote, player);
                    creature->CastSpell(player, ReturnToCapitalSpells[_emote - 2]);
                }
                else
                {
                    creature->AI()->Talk(SAY_INSULT_TO_DK, player);
                    creature->HandleEmoteCommand(RAND(EMOTE_ONESHOT_POINT,EMOTE_ONESHOT_RUDE));
                }
            }
        }
        /*/// @todo: This needs to be further investigated as there are some "guard" npcs, that have civilian flags and non guard npcs should also insult the dk.
        else
            if (creature->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_CIVILIAN)
            {
                creature->HandleEmoteCommand(EMOTE_STATE_COWER); // from sniff, emote 431 for a while, then reset (with "%s cowers in fear." text)
                creature->PlayDirectSound(14556); // from sniff
                if (player)
                {
                    LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
                        if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(TEXT_BROADCAST_COWER))
                            creature->TextEmote(bct->GetText(loc_idx, creature->getGender()), creature);
                }
            }
        */

        creature->AddSpellCooldown(spellId, 0, 30000);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_chapter5_return_to_capital::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
private:
    uint8 _emote;
};

/*####
## Valkyr Battle Maiden AI
####*/

enum Spells_VBM
{
    SPELL_REVIVE                = 51918
};

enum Says_VBM
{
    WHISPER_REVIVE              = 0
};

struct npc_valkyr_battle_maiden : public PassiveAI
{
    npc_valkyr_battle_maiden(Creature* creature) : PassiveAI(creature) { }

    uint32 FlyBackTimer;
    float x, y, z;
    uint32 phase;

    void Reset() override
    {
        me->setActive(true);
        me->SetVisible(false);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetCanFly(true);
        FlyBackTimer = 500;
        phase = 0;

        me->GetPosition(x, y, z);
        z += 4.0f;
        x -= 3.5f;
        y -= 5.0f;
        me->GetMotionMaster()->Clear(false);
        me->SetPosition(x, y, z, 0.0f);
    }

    void UpdateAI(uint32 diff) override
    {
        if (FlyBackTimer <= diff)
        {
            Player* player = nullptr;
            if (me->IsSummon())
            {
                if (Unit * summoner = me->ToTempSummon()->GetSummonerUnit())
                {
                    player = summoner->ToPlayer();
                }
            }

            if (!player)
            {
                phase = 3;
            }

            switch (phase)
            {
                case 0:
                    me->SetWalk(false);
                    me->HandleEmoteCommand(EMOTE_STATE_FLYGRABCLOSED);
                    FlyBackTimer = 500;
                    break;
                case 1:
                    if (player)
                    {
                        player->GetClosePoint(x, y, z, me->GetObjectSize());
                    }
                    z += 2.5f;
                    x -= 2.0f;
                    y -= 1.5f;
                    me->GetMotionMaster()->MovePoint(0, x, y, z);
                    if (player)
                    {
                        me->SetTarget(player->GetGUID());
                    }
                    me->SetVisible(true);
                    FlyBackTimer = 4500;
                    break;
                case 2:
                    if (player && !player->isResurrectRequested())
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_CUSTOM_SPELL_01);
                        DoCast(player, SPELL_REVIVE, true);
                        Talk(WHISPER_REVIVE, player);
                    }
                    FlyBackTimer = 5000;
                    break;
                case 3:
                    me->SetVisible(false);
                    FlyBackTimer = 3000;
                    break;
                case 4:
                    me->DisappearAndDie();
                    break;
                default:
                    //Nothing To DO
                    break;
            }
            ++phase;
        }
        else FlyBackTimer -= diff;
    }
};

void AddSC_the_scarlet_enclave()
{
    RegisterSpellScript(spell_q12641_death_comes_from_on_high_summon_ghouls);
    RegisterSpellScript(spell_q12641_death_comes_from_on_high_recall_eye);
    RegisterSpellScript(spell_q12641_rain_of_darkness);
    RegisterSpellScript(spell_item_gift_of_the_harvester);
    RegisterSpellScript(spell_q12698_the_gift_that_keeps_on_giving);
    RegisterSpellScript(spell_death_knight_initiate_visual);
    RegisterSpellScript(spell_lich_king_whisper);
    RegisterSpellScript(spell_lich_king_vo_blocker);
    RegisterSpellScript(spell_chapter2_persuasive_strike);
    RegisterSpellScript(spell_portal_effect_acherus);
    RegisterSpellScript(spell_q12779_an_end_to_all_things);
    RegisterSpellScript(spell_q12779_an_end_to_all_things_devour_aura);
    RegisterSpellScript(spell_chapter5_light_of_dawn_aura);
    RegisterSpellScript(spell_chapter5_return_to_capital);
    RegisterCreatureAI(npc_valkyr_battle_maiden);
    RegisterCreatureAI(npc_scarlet_ghoul);
    RegisterCreatureAI(npc_dkc1_gothik);
    RegisterCreatureAI(npc_koltira_deathweaver);
    RegisterCreatureAI(npc_acherus_necromancer);
    RegisterCreatureAI(npc_gothik_the_harvester);
    RegisterCreatureAI(npc_highlord_darion_mograine);
}
