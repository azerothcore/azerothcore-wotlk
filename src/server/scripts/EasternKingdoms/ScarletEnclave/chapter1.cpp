/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Vehicle.h"
#include "ObjectMgr.h"
#include "ScriptedEscortAI.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "Player.h"
#include "SpellInfo.h"
#include "CreatureTextMgr.h"
#include "PetAI.h"
#include "SpellScript.h"

// Ours
enum eyeOfAcherus
{
    EVENT_REMOVE_CONTROL            = 1,
    EVENT_SPEAK_1                   = 2,
    EVENT_LAUNCH                    = 3,
    EVENT_REGAIN_CONTROL            = 4,

    EYE_TEXT_LAUNCH                 = 0,
    EYE_TEXT_CONTROL                = 1,

    EYE_POINT_DESTINATION_1         = 0,
    EYE_POINT_DESTINATION_2         = 1,

    SPELL_EYE_OF_ACHERUS_VISUAL     = 51892,
};

class npc_eye_of_acherus : public CreatureScript
{
public:
    npc_eye_of_acherus() : CreatureScript("npc_eye_of_acherus") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_eye_of_acherusAI(creature);
    }

    struct npc_eye_of_acherusAI : public NullCreatureAI
    {
        npc_eye_of_acherusAI(Creature* creature) : NullCreatureAI(creature) { }

        EventMap events;

        void InitializeAI() override
        {
            events.Reset();

            events.ScheduleEvent(EVENT_REMOVE_CONTROL, 500);
            events.ScheduleEvent(EVENT_SPEAK_1, 4000);
            events.ScheduleEvent(EVENT_LAUNCH, 7000);

            me->CastSpell(me, SPELL_EYE_OF_ACHERUS_VISUAL, true);
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type == POINT_MOTION_TYPE && point == EYE_POINT_DESTINATION_2)
            {
                events.ScheduleEvent(EVENT_REGAIN_CONTROL, 1000);
            }
        }

        void SetControl(Player* player, bool on)
        {
            WorldPacket data(SMSG_CLIENT_CONTROL_UPDATE, me->GetPackGUID().size()+1);
            data.append(me->GetPackGUID());
            data << uint8(on ? 1 : 0);
            player->GetSession()->SendPacket(&data);
        }

        void JustSummoned(Creature* creature) override
        {
            if (Unit* target = creature->SelectNearbyTarget())
                creature->AI()->AttackStart(target);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_REMOVE_CONTROL:
                    if (Player* player = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                    {
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
                        SetControl(player, false);
                    }
                    break;
                case EVENT_SPEAK_1:
                    Talk(EYE_TEXT_LAUNCH, me->GetCharmerOrOwnerPlayerOrPlayerItself());
                    break;
                case EVENT_LAUNCH:
                {
                    me->SetSpeed(MOVE_FLIGHT, 5.0f, true);

                    const Position EYE_DESTINATION_1 = { me->GetPositionX()-40.0f, me->GetPositionY(), me->GetPositionZ()+10.0f, 0.0f };
                    const Position EYE_DESTINATION_2 = { 1768.0f, -5876.0f, 153.0f, 0.0f };

                    me->GetMotionMaster()->MovePoint(EYE_POINT_DESTINATION_1, EYE_DESTINATION_1);
                    me->GetMotionMaster()->MovePoint(EYE_POINT_DESTINATION_2, EYE_DESTINATION_2);
                    break;
                }
                case EVENT_REGAIN_CONTROL:
                    if (Player* player = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                    {
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
                        me->SetSpeed(MOVE_FLIGHT, 3.3f, true);

                        SetControl(player, true);
                        Talk(EYE_TEXT_CONTROL, player);
                    }
                    break;
            }
        }
    };
};

class spell_q12641_death_comes_from_on_high_summon_ghouls : public SpellScriptLoader
{
    public:
        spell_q12641_death_comes_from_on_high_summon_ghouls() : SpellScriptLoader("spell_q12641_death_comes_from_on_high_summon_ghouls") { }

        class spell_q12641_death_comes_from_on_high_summon_ghouls_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12641_death_comes_from_on_high_summon_ghouls_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    GetCaster()->CastSpell(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 54522, true);
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12641_death_comes_from_on_high_summon_ghouls_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_q12641_death_comes_from_on_high_summon_ghouls_SpellScript();
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
    FACTION_HOSTILE             = 2068,

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

            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15);

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

            if (!creature->AI()->GetData(player->GetGUIDLow()))
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
        uint64 _duelGUID;
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
            _duelGUID = 0;
            me->RestoreFaction();
            CombatAI::Reset();

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15);
        }

        void SpellHit(Unit* caster, const SpellInfo* pSpell) override
        {
            if (!_duelInProgress && pSpell->Id == SPELL_DUEL)
            {
                playerGUIDs.insert(caster->GetGUIDLow());
                _duelGUID = caster->GetGUID();
                _duelInProgress = true;

                timer = 600000; // clear playerGUIDs after 10 minutes if no one initiates a duel
                me->GetMotionMaster()->MoveFollow(caster, 2.0f, 0.0f);

                events.ScheduleEvent(EVENT_SPEAK, 3000);
                events.ScheduleEvent(EVENT_SPEAK+1, 7000);
                events.ScheduleEvent(EVENT_SPEAK+2, 8000);
                events.ScheduleEvent(EVENT_SPEAK+3, 9000);
                events.ScheduleEvent(EVENT_SPEAK+4, 10000);
                events.ScheduleEvent(EVENT_SPEAK+5, 11000);
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
                    events.ScheduleEvent(EVENT_DUEL_LOST, 2000);
                    events.ScheduleEvent(EVENT_DUEL_LOST+1, 6000);
                    _duelGUID = 0;
                    _duelInProgress = 0;

                    attacker->RemoveGameObject(SPELL_DUEL_FLAG, true);
                    attacker->AttackStop();
                    me->CombatStop(false);
                    me->RemoveAllAuras();
                    me->CastSpell(attacker, SPELL_DUEL_VICTORY, true);
                    me->RestoreFaction();
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
                    Talk(SAY_DUEL+1, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+2:
                    Talk(SAY_DUEL+2, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+3:
                    Talk(SAY_DUEL+3, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+4:
                    Talk(SAY_DUEL+4, ObjectAccessor::GetPlayer(*me, _duelGUID));
                    break;
                case EVENT_SPEAK+5:
                    me->setFaction(FACTION_HOSTILE);
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

class spell_item_gift_of_the_harvester : public SpellScriptLoader
{
    public:
        spell_item_gift_of_the_harvester() : SpellScriptLoader("spell_item_gift_of_the_harvester") { }

        class spell_item_gift_of_the_harvester_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_gift_of_the_harvester_SpellScript);

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
                OnCheckCast += SpellCheckCastFn(spell_item_gift_of_the_harvester_SpellScript::CheckRequirement);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_item_gift_of_the_harvester_SpellScript();
        }
};

class spell_q12698_the_gift_that_keeps_on_giving : public SpellScriptLoader
{
    public:
        spell_q12698_the_gift_that_keeps_on_giving() : SpellScriptLoader("spell_q12698_the_gift_that_keeps_on_giving") { }

        class spell_q12698_the_gift_that_keeps_on_giving_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12698_the_gift_that_keeps_on_giving_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (GetOriginalCaster() && GetHitUnit())
                    GetOriginalCaster()->CastSpell(GetHitUnit(), urand(0, 1) ? GetEffectValue() : SPELL_SUMMON_SCARLET_GHOST, true);
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12698_the_gift_that_keeps_on_giving_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_q12698_the_gift_that_keeps_on_giving_SpellScript();
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
        uint64 gothikGUID;

        void InitializeAI() override
        {
            gothikGUID = 0;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::InitializeAI();
            me->SetReactState(REACT_PASSIVE);

            events.ScheduleEvent(EVENT_GHOUL_EMOTE, 1);
            events.ScheduleEvent(EVENT_GHOUL_RESTORE_STATE, 3500);
        }

        void OwnerAttackedBy(Unit* attacker) override
        {
            if (!me->IsInCombat() && me->GetReactState() == REACT_DEFENSIVE)
                AttackStart(attacker);
        }

        void SetGUID(uint64 guid, int32) override
        {
            gothikGUID = guid;
            events.ScheduleEvent(EVENT_GHOUL_MOVE_TO_PIT, 3000);
            me->GetMotionMaster()->Clear(false);
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type == POINT_MOTION_TYPE && point == 1)
            {
                me->DespawnOrUnsummon(1500);
                me->CastSpell(me, SPELL_GHOUL_SUBMERGE, true);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_GHOUL_MOVE_TO_PIT:
                    me->GetMotionMaster()->MovePoint(1, 2364.77f, -5776.14f, 151.36f);
                    if (Creature* gothik = ObjectAccessor::GetCreature(*me, gothikGUID))
                        gothik->AI()->DoAction(SAY_GOTHIK_PIT);
                    events.PopEvent();
                    break;
                case EVENT_GHOUL_EMOTE:
                    me->CastSpell(me, SPELL_GHOUL_EMERGE, true);
                    events.PopEvent();
                    break;
                case EVENT_GHOUL_RESTORE_STATE:
                    me->SetReactState(REACT_DEFENSIVE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                    if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                        me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, frand(0.0f, 2*M_PI));
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_GHOUL_CHECK_COMBAT, 1000);
                    return;
                case EVENT_GHOUL_CHECK_COMBAT:
                    if (!me->IsInCombat())
                        if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                            if (owner->GetVictim())
                                AttackStart(owner->GetVictim());

                    events.RepeatEvent(1000);
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

            if (!who->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC) && who->GetEntry() == NPC_GHOUL && me->IsWithinDistInMap(who, 10.0f))
                if (Unit* owner = who->GetOwner())
                    if (Player* player = owner->ToPlayer())
                    {
                        Creature* creature = who->ToCreature();
                        if (player->GetQuestStatus(12698) == QUEST_STATUS_INCOMPLETE)
                            creature->CastSpell(owner, 52517, true);

                        creature->AI()->SetGUID(me->GetGUID());
                        creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
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

class npc_scarlet_cannon : public CreatureScript
{
public:
    npc_scarlet_cannon() : CreatureScript("npc_scarlet_cannon") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_scarlet_cannonAI(creature);
    }

    struct npc_scarlet_cannonAI : public VehicleAI
    {
        npc_scarlet_cannonAI(Creature* creature) : VehicleAI(creature) { summonAttackers = 0; }

        uint32 summonAttackers;
        void PassengerBoarded(Unit* /*passenger*/, int8 /*seatId*/, bool apply) override
        {
            summonAttackers = apply ? 8000 : 0;
        }

        void UpdateAI(uint32 diff) override
        {
            VehicleAI::UpdateAI(diff);

            if (summonAttackers)
            {
                summonAttackers += diff;
                if (summonAttackers >= 15000)
                {
                    for (uint8 i = 0; i < 15; ++i)
                        if (Creature* summon = me->SummonCreature(28834 /*NPC_SCARLET_FLEET_DEFENDER*/, 2192.56f+irand(-10, 10), -6147.90f+irand(-10, 10), 5.2f, 4.7f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 45000))
                        {
                            summon->SetHomePosition(me->GetHomePosition());
                            summon->AI()->AttackStart(me);
                        }

                    summonAttackers = 1;
                }
            }
        }
    };
};


// Theirs
/*######
##Quest 12848
######*/

#define GCD_CAST    1

enum UnworthyInitiate
{
    SPELL_SOUL_PRISON_CHAIN_SELF    = 54612,
    SPELL_SOUL_PRISON_CHAIN         = 54613,
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

uint32 acherus_unworthy_initiate[5] =
{
    29519,
    29520,
    29565,
    29566,
    29567
};

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

        uint64 playerGUID;
        UnworthyInitiatePhase phase;
        uint32 wait_timer;
        float anchorX, anchorY;
        uint64 anchorGUID;

        EventMap events;

        void Reset() override
        {
            anchorGUID = 0;
            phase = PHASE_CHAINED;
            events.Reset();
            me->setFaction(7);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 8);
            me->LoadEquipment(0, true);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_ICY_TOUCH, 1000, GCD_CAST);
            events.ScheduleEvent(EVENT_PLAGUE_STRIKE, 3000, GCD_CAST);
            events.ScheduleEvent(EVENT_BLOOD_STRIKE, 2000, GCD_CAST);
            events.ScheduleEvent(EVENT_DEATH_COIL, 5000, GCD_CAST);
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
            me->RemoveAurasDueToSpell(SPELL_SOUL_PRISON_CHAIN_SELF);
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
                            if (temp_prison && me->IsWithinDist(temp_prison, dist, false))
                            {
                                dist = me->GetDistance2d(temp_prison);
                                prison = temp_prison;
                            }
                        }
                    }

                    if (prison)
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
                        //sLog->outDebug(LOG_FILTER_TSCR, "npc_unworthy_initiateAI: move to %f %f %f", anchorX, anchorY, me->GetPositionZ());
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
                        me->setFaction(14);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
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
                        events.DelayEvents(1000, GCD_CAST);
                        events.ScheduleEvent(EVENT_ICY_TOUCH, 5000, GCD_CAST);
                        break;
                    case EVENT_PLAGUE_STRIKE:
                        DoCastVictim(SPELL_PLAGUE_STRIKE);
                        events.DelayEvents(1000, GCD_CAST);
                        events.ScheduleEvent(EVENT_PLAGUE_STRIKE, 5000, GCD_CAST);
                        break;
                    case EVENT_BLOOD_STRIKE:
                        DoCastVictim(SPELL_BLOOD_STRIKE);
                        events.DelayEvents(1000, GCD_CAST);
                        events.ScheduleEvent(EVENT_BLOOD_STRIKE, 5000, GCD_CAST);
                        break;
                    case EVENT_DEATH_COIL:
                        DoCastVictim(SPELL_DEATH_COIL);
                        events.DelayEvents(1000, GCD_CAST);
                        events.ScheduleEvent(EVENT_DEATH_COIL, 5000, GCD_CAST);
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
        npc_unworthy_initiate_anchorAI(Creature* creature) : PassiveAI(creature), prisonerGUID(0) {}

        uint64 prisonerGUID;

        void SetGUID(uint64 guid, int32 /*id*/) override
        {
            if (!prisonerGUID)
                prisonerGUID = guid;
        }

        uint64 GetGUID(int32 /*id*/) const override
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
            if (uint64 prisonerGUID = anchor->AI()->GetGUID())
                if (Creature* prisoner = ObjectAccessor::GetCreature(*player, prisonerGUID))
                    CAST_AI(npc_unworthy_initiate::npc_unworthy_initiateAI, prisoner->AI())->EventStart(anchor, player);

        return false;
    }

};

/*####
## npc_scarlet_miner_cart
####*/

enum Spells_SM
{
    SPELL_CART_CHECK       = 54173,
    SPELL_CART_DRAG        = 52465
};

class npc_scarlet_miner_cart : public CreatureScript
{
public:
    npc_scarlet_miner_cart() : CreatureScript("npc_scarlet_miner_cart") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_scarlet_miner_cartAI(creature);
    }

    struct npc_scarlet_miner_cartAI : public PassiveAI
    {
        npc_scarlet_miner_cartAI(Creature* creature) : PassiveAI(creature), minerGUID(0)
        {
            me->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
            me->setFaction(35);
            me->SetDisplayId(me->GetCreatureTemplate()->Modelid1); // Modelid2 is a horse.
        }

        uint64 minerGUID;

        void SetGUID(uint64 guid, int32 /*id*/) override
        {
            minerGUID = guid;
        }

        void DoAction(int32 /*param*/) override
        {
            if (Creature* miner = ObjectAccessor::GetCreature(*me, minerGUID))
            {
                me->SetWalk(false);

                //Not 100% correct, but movement is smooth. Sometimes miner walks faster
                //than normal, this speed is fast enough to keep up at those times.
                me->SetSpeed(MOVE_RUN, 1.25f);

                me->GetMotionMaster()->MoveFollow(miner, 1.0f, 0);
                me->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                me->setFaction(35);
            }
        }

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
        {
            who->SetVisible(!apply);
            if (!apply)
                if (Creature* miner = ObjectAccessor::GetCreature(*me, minerGUID))
                    miner->DisappearAndDie();
        }
    };

};

/*####
## npc_scarlet_miner
####*/

enum Says_SM
{
    SAY_SCARLET_MINER_0         = 0,
    SAY_SCARLET_MINER_1         = 1
};

class npc_scarlet_miner : public CreatureScript
{
public:
    npc_scarlet_miner() : CreatureScript("npc_scarlet_miner") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_scarlet_minerAI(creature);
    }

    struct npc_scarlet_minerAI : public npc_escortAI
    {
        npc_scarlet_minerAI(Creature* creature) : npc_escortAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        uint32 IntroTimer;
        uint32 IntroPhase;
        uint64 carGUID;

        void Reset() override
        {
            carGUID = 0;
            IntroTimer = 0;
            IntroPhase = 0;
        }

        void InitWaypoint()
        {
            AddWaypoint(1, 2389.03f,     -5902.74f,     109.014f, 5000);
            AddWaypoint(2, 2341.812012f, -5900.484863f, 102.619743f);
            AddWaypoint(3, 2308.34f, -5904.2f, 91.1099f);
            AddWaypoint(4, 2300.69f, -5912.99f, 86.1572f);
            AddWaypoint(5, 2294.142090f, -5927.274414f, 75.316849f);
            AddWaypoint(6, 2286.984375f, -5944.955566f, 63.714966f);
            AddWaypoint(7, 2280.001709f, -5961.186035f, 54.228283f);
            AddWaypoint(8, 2259.389648f, -5974.197754f, 42.359348f);
            AddWaypoint(9, 2242.882812f, -5984.642578f, 32.827850f);
            AddWaypoint(10, 2239.79f, -5989.31f, 30.4453f);
            AddWaypoint(11, 2236.52f, -5994.28f, 27.4829f);
            AddWaypoint(12, 2232.61f, -6000.23f, 23.1281f);
            AddWaypoint(13, 2228.69f, -6006.46f, 17.6638f);
            AddWaypoint(14, 2225.2f, -6012.39f, 12.9487f);
            AddWaypoint(15, 2217.265625f, -6028.959473f, 7.675705f);
            AddWaypoint(16, 2202.595947f, -6061.325684f, 5.882018f);
            AddWaypoint(17, 2188.974609f, -6080.866699f, 3.370027f);

            if (urand(0, 1))
            {
                AddWaypoint(18, 2176.483887f, -6110.407227f, 1.855181f);
                AddWaypoint(19, 2172.516602f, -6146.752441f, 1.074235f);
                AddWaypoint(20, 2138.918457f, -6158.920898f, 1.342926f);
                AddWaypoint(21, 2129.866699f, -6174.107910f, 4.380779f);
                AddWaypoint(22, 2125.250001f, -6181.230001f, 9.91997f);
                AddWaypoint(23, 2117.709473f, -6193.830078f, 13.3542f, 10000);
            }
            else
            {
                AddWaypoint(18, 2184.190186f, -6166.447266f, 0.968877f);
                AddWaypoint(19, 2234.265625f, -6163.741211f, 0.916021f);
                AddWaypoint(20, 2268.071777f, -6158.750977f, 1.822252f);
                AddWaypoint(21, 2270.028320f, -6176.505859f, 6.340538f);
                AddWaypoint(22, 2270.350001f, -6182.410001f, 10.42431f);
                AddWaypoint(23, 2271.739014f, -6195.401855f, 13.3542f, 10000);
            }
        }

        void InitCartQuest(Player* who)
        {
            carGUID = who->GetVehicleBase()->GetGUID();
            InitWaypoint();
            Start(false, false, who->GetGUID());
            SetDespawnAtFar(false);
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 1:
                    if (Unit* car = ObjectAccessor::GetCreature(*me, carGUID))
                    {
                        me->SetFacingToObject(car);
                        // xinef: add some flags
                        car->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                        car->setFaction(35);
                    }
                    Talk(SAY_SCARLET_MINER_0);
                    SetRun(true);
                    IntroTimer = 4000;
                    IntroPhase = 1;
                    break;
                case 23:
                    if (Creature* car = ObjectAccessor::GetCreature(*me, carGUID))
                    {
                        car->SetPosition(car->GetPositionX(), car->GetPositionY(), me->GetPositionZ() + 1, car->GetOrientation());
                        car->StopMovingOnCurrentPos();
                        me->SetFacingToObject(car);
                        car->RemoveAura(SPELL_CART_DRAG);
                    }
                    Talk(SAY_SCARLET_MINER_1);
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (IntroPhase)
            {
                if (IntroTimer <= diff)
                {
                    if (IntroPhase == 1)
                    {
                        if (Creature* car = ObjectAccessor::GetCreature(*me, carGUID))
                            DoCast(car, SPELL_CART_DRAG);
                        IntroTimer = 800;
                        IntroPhase = 2;
                    }
                    else
                    {
                        if (Creature* car = ObjectAccessor::GetCreature(*me, carGUID))
                            car->AI()->DoAction(0);
                        IntroPhase = 0;
                    }
                } else IntroTimer-=diff;
            }
            npc_escortAI::UpdateAI(diff);
        }
    };

};

/*######
## go_inconspicuous_mine_car
######*/

enum Spells_Cart
{
    SPELL_CART_SUMM        = 52463
};

class go_inconspicuous_mine_car : public GameObjectScript
{
public:
    go_inconspicuous_mine_car() : GameObjectScript("go_inconspicuous_mine_car") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (player->GetQuestStatus(12701) == QUEST_STATUS_INCOMPLETE)
        {
            // Hack Why Trinity Dont Support Custom Summon Location
            if (Creature* miner = player->SummonCreature(28841, 2383.869629f, -5900.312500f, 107.996086f, player->GetOrientation(), TEMPSUMMON_DEAD_DESPAWN, 1))
            {
                player->CastSpell(player, SPELL_CART_SUMM, true);
                if (Creature* car = player->GetVehicleCreatureBase())
                {
                    if (car->GetEntry() == 28817)
                    {
                        car->AI()->SetGUID(miner->GetGUID());
                        CAST_AI(npc_scarlet_miner::npc_scarlet_minerAI, miner->AI())->InitCartQuest(player);
                    }
                }
            }
        }
        
        return true;
    }

};

void AddSC_the_scarlet_enclave_c1()
{
    // Ours
    new npc_eye_of_acherus();
    new spell_q12641_death_comes_from_on_high_summon_ghouls();
    new npc_death_knight_initiate();
    new spell_item_gift_of_the_harvester();
    new spell_q12698_the_gift_that_keeps_on_giving();
    new npc_scarlet_ghoul();
    new npc_dkc1_gothik();
    new npc_scarlet_cannon();

    // Theirs
    new npc_unworthy_initiate();
    new npc_unworthy_initiate_anchor();
    new go_acherus_soul_prison();

    new npc_scarlet_miner();
    new npc_scarlet_miner_cart();
    new go_inconspicuous_mine_car();
}
