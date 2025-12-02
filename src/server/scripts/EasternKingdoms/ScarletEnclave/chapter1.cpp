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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "GameObjectScript.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

 /*######
 ## npc_eye_of_acherus
 ######*/

enum EyeOfAcherusMisc
{
    SPELL_THE_EYE_OF_ACHERUS = 51852,
};

enum DeathComesFromOnHigh
{
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

enum deathsChallenge
{
    SPELL_DUEL                  = 52996,
    //SPELL_DUEL_TRIGGERED        = 52990,
    SPELL_DUEL_VICTORY          = 52994,
    SPELL_DUEL_FLAG             = 52991,

    SAY_DUEL                    = 0,

    QUEST_DEATH_CHALLENGE       = 12733,

    DATA_IN_PROGRESS            = 0,

    EVENT_SPEAK                 = 1, // 1 - 6
    EVENT_DUEL_LOST             = 7, // 7 - 8
};

class npc_death_knight_initiate : public CreatureScript
{
public:
    npc_death_knight_initiate() : CreatureScript("npc_death_knight_initiate") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF)
        {
            CloseGossipMenuFor(player);

            if (player->IsInCombat() || creature->IsInCombat())
                return true;

            if (creature->AI()->GetData(DATA_IN_PROGRESS))
                return true;

            creature->RemoveUnitFlag(UNIT_FLAG_SWIMMING);

            player->CastSpell(creature, SPELL_DUEL, false);
            player->CastSpell(player, SPELL_DUEL_FLAG, true);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_DEATH_CHALLENGE) == QUEST_STATUS_INCOMPLETE && creature->IsFullHealth())
        {
            if (player->HealthBelowPct(10))
                return true;

            if (player->IsInCombat() || creature->IsInCombat())
                return true;

            if (!creature->AI()->GetGUID(player->GetGUID().GetCounter()))
                AddGossipItemFor(player, 9765, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_death_knight_initiateAI(creature);
    }

    struct npc_death_knight_initiateAI : public CombatAI
    {
        npc_death_knight_initiateAI(Creature* creature) : CombatAI(creature) { }

        bool _duelInProgress;
        ObjectGuid _duelGUID;
        EventMap events;
        std::set<uint32> playerGUIDs;
        uint32 timer = 0;

        uint32 GetData(uint32 data) const override
        {
            if (data == DATA_IN_PROGRESS)
                return _duelInProgress;

            return playerGUIDs.find(data) != playerGUIDs.end();
        }

        void Reset() override
        {
            _duelInProgress = false;
            _duelGUID.Clear();
            me->RestoreFaction();
            CombatAI::Reset();

            me->SetUnitFlag(UNIT_FLAG_SWIMMING);
        }

        void SpellHit(Unit* caster, SpellInfo const* pSpell) override
        {
            if (!_duelInProgress && pSpell->Id == SPELL_DUEL)
            {
                playerGUIDs.insert(caster->GetGUID().GetCounter());
                _duelGUID = caster->GetGUID();
                _duelInProgress = true;

                timer = 600000; // clear playerGUIDs after 10 minutes if no one initiates a duel
                me->SetFacingToObject(caster);

                events.ScheduleEvent(EVENT_SPEAK, 3s);
                events.ScheduleEvent(EVENT_SPEAK + 1, 7s);
                events.ScheduleEvent(EVENT_SPEAK + 2, 8s);
                events.ScheduleEvent(EVENT_SPEAK + 3, 9s);
                events.ScheduleEvent(EVENT_SPEAK + 4, 10s);
                events.ScheduleEvent(EVENT_SPEAK + 5, 11s);
            }
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (attacker && _duelInProgress && attacker->IsControlledByPlayer())
            {
                if (attacker->GetCharmerOrOwnerOrOwnGUID() != _duelGUID)
                    damage = 0;
                else if (damage >= me->GetHealth())
                {
                    damage = 0;
                    events.ScheduleEvent(EVENT_DUEL_LOST, 2s);
                    events.ScheduleEvent(EVENT_DUEL_LOST + 1, 6s);
                    _duelGUID.Clear();
                    _duelInProgress = 0;

                    attacker->RemoveGameObject(SPELL_DUEL_FLAG, true);
                    attacker->AttackStop();
                    me->CombatStop(false);
                    me->RemoveAllAuras();
                    me->CastSpell(attacker, SPELL_DUEL_VICTORY, true);
                    me->RestoreFaction();
                    me->DespawnOrUnsummon(10s);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (timer != 0)
            {
                if (timer <= diff)
                {
                    timer = 0;
                    playerGUIDs.clear();
                }
                else
                {
                    timer -= diff;
                }
            }

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_SPEAK:
                    Talk(SAY_DUEL, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+1:
                    Talk(SAY_DUEL + 1, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+2:
                    Talk(SAY_DUEL + 2, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+3:
                    Talk(SAY_DUEL + 3, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+4:
                    Talk(SAY_DUEL + 4, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+5:
                    me->SetFaction(FACTION_UNDEAD_SCOURGE_2);
                    if (Player* player = ObjectAccessor::GetPlayer(*me, _duelGUID))
                        AttackStart(player);
                    return;
                case EVENT_DUEL_LOST:
                    me->CastSpell(me, 7267, true);
                    break;
                case EVENT_DUEL_LOST+1:
                    EnterEvadeMode();
                    return;
            }

            if (!events.Empty() || !UpdateVictim())
                return;

            if (_duelInProgress)
            {
                if (me->GetVictim()->GetGUID() == _duelGUID && me->GetVictim()->HealthBelowPct(10))
                {
                    me->GetVictim()->CastSpell(me->GetVictim(), 7267, true); // beg
                    me->GetVictim()->RemoveGameObject(SPELL_DUEL_FLAG, true);
                    EnterEvadeMode();
                    return;
                }
            }

            CombatAI::UpdateAI(diff);
        }
    };
};

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

    SAY_GOTHIK_PIT              = 0
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

class npc_scarlet_ghoul : public CreatureScript
{
public:
    npc_scarlet_ghoul() : CreatureScript("npc_scarlet_ghoul") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_scarlet_ghoulAI(creature);
    }

    struct npc_scarlet_ghoulAI : public ScriptedAI
    {
        npc_scarlet_ghoulAI(Creature* creature) : ScriptedAI(creature)
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
};

class npc_dkc1_gothik : public CreatureScript
{
public:
    npc_dkc1_gothik() : CreatureScript("npc_dkc1_gothik") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_dkc1_gothikAI(creature);
    }

    struct npc_dkc1_gothikAI : public ScriptedAI
    {
        npc_dkc1_gothikAI(Creature* creature) : ScriptedAI(creature) { spoken = 0; }

        int32 spoken;

        void DoAction(int32 action) override
        {
            if (action == SAY_GOTHIK_PIT && spoken <= 0)
            {
                spoken = 5000;
                Talk(SAY_GOTHIK_PIT);
            }
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
};

/*######
##Quest 12848
######*/

#define GCD_CAST    1

enum UnworthyInitiate
{
    SPELL_SOUL_PRISON_CHAIN         = 54612,
    SPELL_DK_INITIATE_VISUAL        = 51519,

    SPELL_ICY_TOUCH                 = 52372,
    SPELL_PLAGUE_STRIKE             = 52373,
    SPELL_BLOOD_STRIKE              = 52374,
    SPELL_DEATH_COIL                = 52375,

    SAY_EVENT_START                 = 0,
    SAY_EVENT_ATTACK                = 1,

    EVENT_ICY_TOUCH                 = 1,
    EVENT_PLAGUE_STRIKE             = 2,
    EVENT_BLOOD_STRIKE              = 3,
    EVENT_DEATH_COIL                = 4
};

enum UnworthyInitiatePhase
{
    PHASE_CHAINED,
    PHASE_TO_EQUIP,
    PHASE_EQUIPING,
    PHASE_TO_ATTACK,
    PHASE_ATTACKING,
};

uint32 acherus_soul_prison[12] =
{
    191577,
    191580,
    191581,
    191582,
    191583,
    191584,
    191585,
    191586,
    191587,
    191588,
    191589,
    191590
};

//uint32 acherus_unworthy_initiate[5] =
//{
//    29519,
//    29520,
//    29565,
//    29566,
//    29567
//};

class npc_unworthy_initiate : public CreatureScript
{
public:
    npc_unworthy_initiate() : CreatureScript("npc_unworthy_initiate") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_unworthy_initiateAI(creature);
    }

    struct npc_unworthy_initiateAI : public ScriptedAI
    {
        npc_unworthy_initiateAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            if (!me->GetCurrentEquipmentId())
                me->SetCurrentEquipmentId(me->GetOriginalEquipmentId());
        }

        ObjectGuid playerGUID;
        UnworthyInitiatePhase phase;
        uint32 wait_timer;
        float anchorX, anchorY;
        ObjectGuid anchorGUID;

        EventMap events;

        void Reset() override
        {
            anchorGUID.Clear();
            phase = PHASE_CHAINED;
            events.Reset();
            me->SetFaction(FACTION_CREATURE);
            me->SetImmuneToPC(true);
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 8);
            me->LoadEquipment(0, true);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_ICY_TOUCH, 1s, GCD_CAST);
            events.ScheduleEvent(EVENT_PLAGUE_STRIKE, 3s, GCD_CAST);
            events.ScheduleEvent(EVENT_BLOOD_STRIKE, 2s, GCD_CAST);
            events.ScheduleEvent(EVENT_DEATH_COIL, 5s, GCD_CAST);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == 1)
            {
                wait_timer = 5000;
                me->LoadEquipment(1);
                me->CastSpell(me, SPELL_DK_INITIATE_VISUAL, true);

                if (Player* starter = ObjectAccessor::GetPlayer(*me, playerGUID))
                    Talk(SAY_EVENT_ATTACK, starter);

                phase = PHASE_TO_ATTACK;
            }
        }

        void EventStart(Creature* anchor, Player* target)
        {
            wait_timer = 5000;
            phase = PHASE_TO_EQUIP;

            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
            me->RemoveAurasDueToSpell(SPELL_SOUL_PRISON_CHAIN);

            float z;
            anchor->GetContactPoint(me, anchorX, anchorY, z, 1.0f);

            playerGUID = target->GetGUID();
            Talk(SAY_EVENT_START, target);
        }

        void UpdateAI(uint32 diff) override
        {
            switch (phase)
            {
                case PHASE_CHAINED:
                    if (!anchorGUID)
                    {
                        if (Creature* anchor = me->FindNearestCreature(29521, 30))
                        {
                            anchor->AI()->SetGUID(me->GetGUID());
                            anchor->CastSpell(me, SPELL_SOUL_PRISON_CHAIN, true);
                            anchorGUID = anchor->GetGUID();
                        }

                        float dist = 99.0f;
                        GameObject* prison = nullptr;

                        for (uint8 i = 0; i < 12; ++i)
                        {
                            if (GameObject* temp_prison = me->FindNearestGameObject(acherus_soul_prison[i], 100))
                            {
                                if (me->IsWithinDist(temp_prison, dist, false))
                                {
                                    dist = me->GetDistance2d(temp_prison);
                                    prison = temp_prison;
                                }
                            }
                        }
                        // Must check for loot state as out of order updates will reset
                        // the prison gameobject during spawn causing invalid state
                        if (prison && prison->getLootState() != GO_NOT_READY)
                            prison->ResetDoorOrButton();
                    }
                    break;
                case PHASE_TO_EQUIP:
                    if (wait_timer)
                    {
                        if (wait_timer > diff)
                            wait_timer -= diff;
                        else
                        {
                            me->GetMotionMaster()->MovePoint(1, anchorX, anchorY, me->GetPositionZ());
                            //LOG_DEBUG("scripts.ai", "npc_unworthy_initiateAI: move to {} {} {}", anchorX, anchorY, me->GetPositionZ());
                            phase = PHASE_EQUIPING;
                            wait_timer = 0;
                        }
                    }
                    break;
                case PHASE_TO_ATTACK:
                    if (wait_timer)
                    {
                        if (wait_timer > diff)
                            wait_timer -= diff;
                        else
                        {
                            me->SetFaction(FACTION_MONSTER);
                            me->SetImmuneToPC(false);
                            phase = PHASE_ATTACKING;

                            if (Player* target = ObjectAccessor::GetPlayer(*me, playerGUID))
                                AttackStart(target);
                            wait_timer = 0;
                        }
                    }
                    break;
                case PHASE_ATTACKING:
                    if (!UpdateVictim())
                        return;

                    events.Update(diff);

                    while (uint32 eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case EVENT_ICY_TOUCH:
                                DoCastVictim(SPELL_ICY_TOUCH);
                                events.DelayEvents(1s, GCD_CAST);
                                events.ScheduleEvent(EVENT_ICY_TOUCH, 5s, GCD_CAST);
                                break;
                            case EVENT_PLAGUE_STRIKE:
                                DoCastVictim(SPELL_PLAGUE_STRIKE);
                                events.DelayEvents(1s, GCD_CAST);
                                events.ScheduleEvent(EVENT_PLAGUE_STRIKE, 5s, GCD_CAST);
                                break;
                            case EVENT_BLOOD_STRIKE:
                                DoCastVictim(SPELL_BLOOD_STRIKE);
                                events.DelayEvents(1s, GCD_CAST);
                                events.ScheduleEvent(EVENT_BLOOD_STRIKE, 5s, GCD_CAST);
                                break;
                            case EVENT_DEATH_COIL:
                                DoCastVictim(SPELL_DEATH_COIL);
                                events.DelayEvents(1s, GCD_CAST);
                                events.ScheduleEvent(EVENT_DEATH_COIL, 5s, GCD_CAST);
                                break;
                        }
                    }

                    DoMeleeAttackIfReady();
                    break;
                default:
                    break;
            }
        }
    };
};

class npc_unworthy_initiate_anchor : public CreatureScript
{
public:
    npc_unworthy_initiate_anchor() : CreatureScript("npc_unworthy_initiate_anchor") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_unworthy_initiate_anchorAI(creature);
    }

    struct npc_unworthy_initiate_anchorAI : public PassiveAI
    {
        npc_unworthy_initiate_anchorAI(Creature* creature) : PassiveAI(creature) {}

        ObjectGuid prisonerGUID;

        void SetGUID(ObjectGuid const& guid, int32 /*id*/) override
        {
            if (!prisonerGUID)
                prisonerGUID = guid;
        }

        ObjectGuid GetGUID(int32 /*id*/) const override
        {
            return prisonerGUID;
        }
    };
};

class go_acherus_soul_prison : public GameObjectScript
{
public:
    go_acherus_soul_prison() : GameObjectScript("go_acherus_soul_prison") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (Creature* anchor = go->FindNearestCreature(29521, 15))
            if (ObjectGuid prisonerGUID = anchor->AI()->GetGUID())
                if (Creature* prisoner = ObjectAccessor::GetCreature(*player, prisonerGUID))
                    CAST_AI(npc_unworthy_initiate::npc_unworthy_initiateAI, prisoner->AI())->EventStart(anchor, player);

        return false;
    }
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

void AddSC_the_scarlet_enclave_c1()
{
    RegisterSpellScript(spell_q12641_death_comes_from_on_high_summon_ghouls);
    RegisterSpellScript(spell_q12641_death_comes_from_on_high_recall_eye);
    new npc_death_knight_initiate();
    RegisterSpellScript(spell_item_gift_of_the_harvester);
    RegisterSpellScript(spell_q12698_the_gift_that_keeps_on_giving);
    new npc_scarlet_ghoul();
    new npc_dkc1_gothik();
    new npc_unworthy_initiate();
    new npc_unworthy_initiate_anchor();
    new go_acherus_soul_prison();
    RegisterSpellScript(spell_death_knight_initiate_visual);
    RegisterSpellScript(spell_lich_king_whisper);
    RegisterSpellScript(spell_lich_king_vo_blocker);
}
