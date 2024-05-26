#ifndef BOSS_THADDIUS_H_
#define BOSS_THADDIUS_H_

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "naxxramas.h"

namespace Thaddius {

enum ThaddiusSays
{
    // Stalagg
    SAY_STAL_AGGRO                      = 0,
    SAY_STAL_SLAY                       = 1,
    SAY_STAL_DEATH                      = 2,
    EMOTE_STAL_DEATH                    = 3,
    EMOTE_STAL_REVIVE                   = 4,

    // Feugen
    SAY_FEUG_AGGRO                      = 0,
    SAY_FEUG_SLAY                       = 1,
    SAY_FEUG_DEATH                      = 2,
    EMOTE_FEUG_DEATH                    = 3,
    EMOTE_FEUG_REVIVE                   = 4,

    // Thaddius
    THADDIUS_SAY_GREET                           = 0,
    THADDIUS_SAY_AGGRO                           = 1,
    THADDIUS_SAY_SLAY                            = 2,
    THADDIUS_SAY_ELECT                           = 3,
    THADDIUS_SAY_DEATH                           = 4,
    EMOTE_POLARITY_SHIFTED              = 6,

    // Tesla Coil
    EMOTE_TESLA_LINK_BREAKS             = 0,
    EMOTE_TESLA_OVERLOAD                = 1
};

enum ThaddiusSpells
{
    SPELL_MAGNETIC_PULL                 = 28337,
    SPELL_TESLA_SHOCK                   = 28099,
    SPELL_SHOCK_VISUAL                  = 28159,

    // Stalagg
    SPELL_POWER_SURGE_10                = 54529,
    SPELL_POWER_SURGE_25                = 28134,
    SPELL_STALAGG_CHAIN                 = 28096,

    // Feugen
    SPELL_STATIC_FIELD_10               = 28135,
    SPELL_STATIC_FIELD_25               = 54528,
    SPELL_FEUGEN_CHAIN                  = 28111,

    // Thaddius
    SPELL_POLARITY_SHIFT                = 28089,
    SPELL_BALL_LIGHTNING                = 28299,
    SPELL_CHAIN_LIGHTNING_10            = 28167,
    SPELL_CHAIN_LIGHTNING_25            = 54531,
    THADDIUS_SPELL_BERSERK                       = 27680,
    SPELL_THADDIUS_VISUAL_LIGHTNING     = 28136,
    SPELL_THADDIUS_SPAWN_STUN           = 28160,

    SPELL_POSITIVE_CHARGE               = 28062,
    SPELL_POSITIVE_CHARGE_STACK         = 29659,
    SPELL_NEGATIVE_CHARGE               = 28085,
    SPELL_NEGATIVE_CHARGE_STACK         = 29660,
    SPELL_POSITIVE_POLARITY             = 28059,
    SPELL_NEGATIVE_POLARITY             = 28084
};

enum ThaddiusEvents
{
    EVENT_MINION_POWER_SURGE            = 1,
    EVENT_MINION_MAGNETIC_PULL          = 2,
    EVENT_MINION_CHECK_DISTANCE         = 3,
    EVENT_MINION_STATIC_FIELD           = 4,

    EVENT_THADDIUS_INIT                 = 5,
    EVENT_THADDIUS_ENTER_COMBAT         = 6,
    EVENT_THADDIUS_CHAIN_LIGHTNING      = 7,
    EVENT_THADDIUS_BERSERK              = 8,
    EVENT_THADDIUS_POLARITY_SHIFT       = 9,
    EVENT_ALLOW_BALL_LIGHTNING          = 10
};

enum ThaddiusMisc
{
    ACTION_MAGNETIC_PULL                = 1,
    ACTION_SUMMON_DIED                  = 2,
    ACTION_RESTORE                      = 3,
    GO_TESLA_COIL_LEFT                  = 181478,
    GO_TESLA_COIL_RIGHT                 = 181477,
    NPC_TESLA_COIL                      = 16218
};

class boss_thaddius : public CreatureScript
{
public:
    boss_thaddius() : CreatureScript("boss_thaddius") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_thaddiusAI>(pCreature);
    }

    struct boss_thaddiusAI : public BossAI
    {
        explicit boss_thaddiusAI(Creature* c) : BossAI(c, BOSS_THADDIUS), summons(me), ballLightningEnabled(false)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint32 summonTimer{};
        uint32 reviveTimer{};
        uint32 resetTimer{};
        bool ballLightningEnabled;

        void DoAction(int32 param) override
        {
            if (param == ACTION_SUMMON_DIED)
            {
                if (summonTimer)
                {
                    summonTimer = 0;
                    reviveTimer = 1;
                    return;
                }
                summonTimer = 1;
            }
        }

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetControlled(true, UNIT_STATE_ROOT);
            summonTimer = 0;
            reviveTimer = 0;
            resetTimer = 1;
            me->SetPosition(me->GetHomePosition());
            ballLightningEnabled = false;

            me->SummonCreature(NPC_STALAGG, 3450.45f, -2931.42f, 312.091f, 5.49779f);
            me->SummonCreature(NPC_FEUGEN, 3508.14f, -2988.65f, 312.092f, 2.37365f);
            if (Creature* cr = me->SummonCreature(NPC_TESLA_COIL, 3527.34f, -2951.56f, 318.75f, 0.0f))
            {
                cr->RemoveAllAuras();
                cr->InterruptNonMeleeSpells(true);
                cr->CastSpell(cr, SPELL_FEUGEN_CHAIN, false);
                cr->SetDisableGravity(true);
                cr->SetImmuneToPC(false);
                cr->SetControlled(true, UNIT_STATE_ROOT);
            }
            if (Creature* cr = me->SummonCreature(NPC_TESLA_COIL, 3487.04f, -2911.68f, 318.75f, 0.0f))
            {
                cr->RemoveAllAuras();
                cr->InterruptNonMeleeSpells(true);
                cr->CastSpell(cr, SPELL_STALAGG_CHAIN, false);
                cr->SetDisableGravity(true);
                cr->SetImmuneToPC(false);
                cr->SetControlled(true, UNIT_STATE_ROOT);
            }

            if (GameObject* go = me->FindNearestGameObject(GO_TESLA_COIL_LEFT, 100.0f))
            {
                go->SetGoState(GO_STATE_ACTIVE);
            }
            if (GameObject* go = me->FindNearestGameObject(GO_TESLA_COIL_RIGHT, 100.0f))
            {
                go->SetGoState(GO_STATE_ACTIVE);
            }
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_THADDIUS_GATE)))
                {
                    if (pInstance->GetBossState(BOSS_GLUTH) == DONE)
                    {
                        go->SetGoState(GO_STATE_ACTIVE);
                    }
                }
            }

            pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_POLARITY);
            pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_CHARGE_STACK);
            pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_POLARITY);
            pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_CHARGE_STACK);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(THADDIUS_SAY_SLAY);
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(THADDIUS_SAY_DEATH);
            if (pInstance)
            {
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_POLARITY);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_CHARGE_STACK);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_POLARITY);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_CHARGE_STACK);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_THADDIUS_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->SetInCombatWithZone();
            summons.DoZoneInCombat(NPC_FEUGEN);
            summons.DoZoneInCombat(NPC_STALAGG);
        }

        void UpdateAI(uint32 diff) override
        {
            if (resetTimer)
            {
                resetTimer += diff;
                if (resetTimer > 1000)
                {
                    resetTimer = 0;
                    me->CastSpell(me, SPELL_THADDIUS_SPAWN_STUN, true);
                }
                return;
            }
            if (reviveTimer)
            {
                reviveTimer += diff;
                if (reviveTimer >= 12000)
                {
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    {
                        if (Creature* cr = ObjectAccessor::GetCreature(*me, (*itr)))
                        {
                            if (cr->GetEntry() == NPC_TESLA_COIL)
                            {
                                cr->AI()->Talk(EMOTE_TESLA_OVERLOAD);
                                cr->CastSpell(me, SPELL_SHOCK_VISUAL, true);
                            }
                        }
                    }
                    reviveTimer = 0;
                    events.ScheduleEvent(EVENT_THADDIUS_INIT, 750ms);
                }
                return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (summonTimer) // Revive
            {
                summonTimer += diff;
                if (summonTimer >= 5000)
                {
                    summons.DoAction(ACTION_RESTORE);
                    summonTimer = 0;
                }
            }

            switch (events.ExecuteEvent())
            {
                case EVENT_THADDIUS_INIT:
                {
                    me->RemoveAllAuras();
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    {
                        if (Creature* cr = ObjectAccessor::GetCreature(*me, (*itr)))
                        {
                            if (cr->GetEntry() == NPC_TESLA_COIL)
                            {
                                Unit::Kill(cr, cr);
                            }
                        }
                    }
                    if (GameObject* go = me->FindNearestGameObject(GO_TESLA_COIL_LEFT, 100.0f))
                    {
                        go->SetGoState(GO_STATE_READY);
                    }
                    if (GameObject* go = me->FindNearestGameObject(GO_TESLA_COIL_RIGHT, 100.0f))
                    {
                        go->SetGoState(GO_STATE_READY);
                    }
                    me->CastSpell(me, SPELL_THADDIUS_VISUAL_LIGHTNING, true);
                    events.ScheduleEvent(EVENT_THADDIUS_ENTER_COMBAT, 1s);
                    break;
                }
                case EVENT_THADDIUS_ENTER_COMBAT:
                    Talk(THADDIUS_SAY_AGGRO);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_THADDIUS_CHAIN_LIGHTNING, 14s);
                    events.ScheduleEvent(EVENT_THADDIUS_BERSERK, 6min);
                    events.ScheduleEvent(EVENT_THADDIUS_POLARITY_SHIFT, 30s);
                    events.ScheduleEvent(EVENT_ALLOW_BALL_LIGHTNING, 5s);
                    return;
                case EVENT_THADDIUS_BERSERK:
                    me->CastSpell(me, THADDIUS_SPELL_BERSERK, true);
                    break;
                case EVENT_THADDIUS_CHAIN_LIGHTNING:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_CHAIN_LIGHTNING_10, SPELL_CHAIN_LIGHTNING_25), false);
                    events.Repeat(15s);
                    break;
                case EVENT_THADDIUS_POLARITY_SHIFT:
                    me->CastSpell(me, SPELL_POLARITY_SHIFT, false);
                    events.Repeat(30s);
                    break;
                case EVENT_ALLOW_BALL_LIGHTNING:
                    ballLightningEnabled = true;
                    break;
            }

            if (me->IsWithinMeleeRange(me->GetVictim()))
            {
                DoMeleeAttackIfReady();
            }
            else if (ballLightningEnabled)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat))
                {
                    me->CastSpell(target, SPELL_BALL_LIGHTNING, false);
                }
            }
        }
    };
};

class boss_thaddius_summon : public CreatureScript
{
public:
    boss_thaddius_summon() : CreatureScript("boss_thaddius_summon") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_thaddius_summonAI>(pCreature);
    }

    struct boss_thaddius_summonAI : public ScriptedAI
    {
        explicit boss_thaddius_summonAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = me->GetInstanceScript();
            overload = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        uint32 pullTimer{};
        uint32 visualTimer{};
        bool overload;
        ObjectGuid myCoil;

        void Reset() override
        {
            pullTimer = 0;
            visualTimer = 1;
            overload = false;
            events.Reset();
            me->SetControlled(false, UNIT_STATE_STUNNED);
            if (Creature* cr = me->FindNearestCreature(NPC_TESLA_COIL, 150.0f))
            {
                cr->CastSpell(cr, me->GetEntry() == NPC_STALAGG ? SPELL_STALAGG_CHAIN : SPELL_FEUGEN_CHAIN, false);
                cr->SetImmuneToPC(false);
                myCoil = cr->GetGUID();
            }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetControlled(false, UNIT_STATE_STUNNED);
            ScriptedAI::EnterEvadeMode(why);
        }

        void JustEngagedWith(Unit* pWho) override
        {
            me->SetInCombatWithZone();
            if (Creature* cr = me->FindNearestCreature(NPC_TESLA_COIL, 150.f, true))
            {
                myCoil = cr->GetGUID();
            }
            if (me->GetEntry() == NPC_STALAGG)
            {
                events.ScheduleEvent(EVENT_MINION_POWER_SURGE, 10s);
                Talk(SAY_STAL_AGGRO);
            }
            else
            {
                events.ScheduleEvent(EVENT_MINION_STATIC_FIELD, 5s);
                Talk(SAY_FEUG_AGGRO);
            }
            events.ScheduleEvent(EVENT_MINION_CHECK_DISTANCE, 5s);

            if (me->GetEntry() == NPC_STALAGG) // This event needs synchronisation, called for stalagg only
            {
                events.ScheduleEvent(EVENT_MINION_MAGNETIC_PULL, 20s);
            }
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_THADDIUS_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
                if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_THADDIUS_BOSS)))
                {
                    cr->AI()->AttackStart(pWho);
                    cr->AddThreat(pWho, 10.0f);
                }
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_MAGNETIC_PULL)
            {
                pullTimer = 1;
                me->SetControlled(true, UNIT_STATE_STUNNED);
            }
            else if (param == ACTION_RESTORE)
            {
                if (!me->IsAlive())
                {
                    me->Respawn();
                    me->SetInCombatWithZone();
                    Talk(me->GetEntry() == NPC_STALAGG ? EMOTE_STAL_REVIVE : EMOTE_FEUG_REVIVE);
                }
                else
                {
                    me->SetHealth(me->GetMaxHealth());
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(me->GetEntry() == NPC_STALAGG ? SAY_STAL_DEATH : SAY_FEUG_DEATH);
            Talk(me->GetEntry() == NPC_STALAGG ? EMOTE_STAL_DEATH : EMOTE_FEUG_DEATH);
            if (pInstance)
            {
                if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_THADDIUS_BOSS)))
                {
                    cr->AI()->DoAction(ACTION_SUMMON_DIED);
                }
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
            if (!urand(0, 2))
            {
                Talk(me->GetEntry() == NPC_STALAGG ? SAY_STAL_SLAY : SAY_FEUG_SLAY);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (visualTimer)
            {
                visualTimer += diff;
                if (visualTimer >= 3000)
                {
                    visualTimer = 0;
                    if (Creature* cr = me->FindNearestCreature(NPC_TESLA_COIL, 150.0f))
                    {
                        cr->CastSpell(cr, me->GetEntry() == NPC_STALAGG ? SPELL_STALAGG_CHAIN : SPELL_FEUGEN_CHAIN, false);
                    }
                }
            }

            if (!UpdateVictim())
                return;

            if (pullTimer) // Disable AI during pull
            {
                pullTimer += diff;
                if (pullTimer >= 3000)
                {
                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    pullTimer = 0;
                }
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_MINION_POWER_SURGE:
                    me->CastSpell(me, RAID_MODE(SPELL_POWER_SURGE_10, SPELL_POWER_SURGE_25), false);
                    events.Repeat(19s);
                    break;
                case EVENT_MINION_STATIC_FIELD:
                    me->CastSpell(me, RAID_MODE(SPELL_STATIC_FIELD_10, SPELL_STATIC_FIELD_25), false);
                    events.Repeat(3s);
                    break;
                case EVENT_MINION_MAGNETIC_PULL:
                    events.Repeat(20s);
                    if (pInstance)
                    {
                        if (Creature* feugen = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_FEUGEN_BOSS)))
                        {
                            if (!feugen->IsAlive() || !feugen->GetVictim() || !me->GetVictim())
                                return;

                            float threatFeugen = feugen->GetThreatMgr().GetThreat(feugen->GetVictim());
                            float threatStalagg = me->GetThreatMgr().GetThreat(me->GetVictim());
                            Unit* tankFeugen = feugen->GetVictim();
                            Unit* tankStalagg = me->GetVictim();

                            feugen->GetThreatMgr().ModifyThreatByPercent(tankFeugen, -100);
                            feugen->AddThreat(tankStalagg, threatFeugen);
                            feugen->CastSpell(tankStalagg, SPELL_MAGNETIC_PULL, true);
                            feugen->AI()->DoAction(ACTION_MAGNETIC_PULL);

                            me->GetThreatMgr().ModifyThreatByPercent(tankStalagg, -100);
                            me->AddThreat(tankFeugen, threatStalagg);
                            me->CastSpell(tankFeugen, SPELL_MAGNETIC_PULL, true);
                            DoAction(ACTION_MAGNETIC_PULL);
                        }
                    }
                    break;
                case EVENT_MINION_CHECK_DISTANCE:
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, myCoil))
                    {
                        if (!me->GetHomePosition().IsInDist(me, 28) && me->IsInCombat())
                        {
                            if (!overload)
                            {
                                overload = true;
                                cr->AI()->Talk(EMOTE_TESLA_LINK_BREAKS);
                                me->RemoveAurasDueToSpell(me->GetEntry() == NPC_STALAGG ? SPELL_STALAGG_CHAIN : SPELL_FEUGEN_CHAIN);
                                cr->InterruptNonMeleeSpells(true);
                            }
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 1000.f, true))
                            {
                                cr->CastStop(SPELL_TESLA_SHOCK);
                                cr->CastSpell(target, SPELL_TESLA_SHOCK, true);
                            }
                            events.Repeat(1500ms);
                            break;
                        }
                        else
                        {
                            overload = false;
                            cr->CastSpell(cr, me->GetEntry() == NPC_STALAGG ? SPELL_STALAGG_CHAIN : SPELL_FEUGEN_CHAIN, false);
                        }
                    }
                    events.Repeat(5s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class spell_thaddius_pos_neg_charge : public SpellScriptLoader
{
public:
    spell_thaddius_pos_neg_charge() : SpellScriptLoader("spell_thaddius_pos_neg_charge") { }

    class spell_thaddius_pos_neg_charge_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_thaddius_pos_neg_charge_SpellScript);

        void HandleTargets(std::list<WorldObject*>& targets)
        {
            uint8 count = 0;
            for (auto& ihit : targets)
            {
                if (ihit->GetGUID() != GetCaster()->GetGUID())
                {
                    if (Player* target = ihit->ToPlayer())
                    {
                        if (target->HasAura(GetTriggeringSpell()->Id))
                        {
                            ++count;
                        }
                    }
                }
            }

            if (count)
            {
                uint32 spellId = GetSpellInfo()->Id == SPELL_POSITIVE_CHARGE ? SPELL_POSITIVE_CHARGE_STACK : SPELL_NEGATIVE_CHARGE_STACK;
                GetCaster()->SetAuraStack(spellId, GetCaster(), count);
            }
        }

        void HandleDamage(SpellEffIndex /*effIndex*/)
        {
            if (!GetTriggeringSpell())
                return;

            Unit* target = GetHitUnit();
            if (!target)
                return;

            if (target->HasAura(GetTriggeringSpell()->Id) || target->GetTypeId() != TYPEID_PLAYER)
            {
                SetHitDamage(0);
            }
            else if (target->GetInstanceScript())
            {
                target->GetInstanceScript()->SetData(DATA_CHARGES_CROSSED, 0);
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_thaddius_pos_neg_charge_SpellScript::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_thaddius_pos_neg_charge_SpellScript::HandleTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_thaddius_pos_neg_charge_SpellScript();
    }
};

class spell_thaddius_polarity_shift : public SpellScriptLoader
{
public:
    spell_thaddius_polarity_shift() : SpellScriptLoader("spell_thaddius_polarity_shift") { }

    class spell_thaddius_polarity_shift_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_thaddius_polarity_shift_SpellScript);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo({ SPELL_POSITIVE_POLARITY, SPELL_NEGATIVE_POLARITY });
        }

        void HandleDummy(SpellEffIndex /* effIndex */)
        {
            Unit* caster = GetCaster();
            if (Unit* target = GetHitUnit())
            {
                target->RemoveAurasDueToSpell(SPELL_POSITIVE_CHARGE_STACK);
                target->RemoveAurasDueToSpell(SPELL_NEGATIVE_CHARGE_STACK);
                target->CastSpell(target, roll_chance_i(50) ? SPELL_POSITIVE_POLARITY : SPELL_NEGATIVE_POLARITY, true, nullptr, nullptr, caster->GetGUID());
            }
        }

        void HandleAfterCast()
        {
            if (GetCaster())
            {
                if (Creature* caster = GetCaster()->ToCreature())
                {
                    if (caster->GetEntry() == NPC_THADDIUS)
                    {
                        caster->AI()->Talk(THADDIUS_SAY_ELECT);
                        caster->AI()->Talk(EMOTE_POLARITY_SHIFTED);
                    }
                }
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_thaddius_polarity_shift_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            AfterCast += SpellCastFn(spell_thaddius_polarity_shift_SpellScript::HandleAfterCast);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_thaddius_polarity_shift_SpellScript();
    }
};

class npc_tesla : public CreatureScript
{
public:
    npc_tesla() : CreatureScript("npc_tesla") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetNaxxramasAI<npc_teslaAI>(creature);
    }

    struct npc_teslaAI : public ScriptedAI
    {
    public:
        npc_teslaAI(Creature* creature) : ScriptedAI(creature) { }
        void EnterEvadeMode(EvadeReason /*why*/) override { } // never stop casting due to evade
        void UpdateAI(uint32 /*diff*/) override { } // never do anything unless told
        void JustEngagedWith(Unit* /*who*/) override { }
        void DamageTaken(Unit* /*who*/, uint32& damage, DamageEffectType, SpellSchoolMask) override { damage = 0; } // no, you can't kill it
    };
};

class at_thaddius_entrance : public AreaTriggerScript
{
public:
    at_thaddius_entrance() : AreaTriggerScript("at_thaddius_entrance") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        InstanceScript* instance = player->GetInstanceScript();
        if (!instance || instance->GetData(DATA_HAD_THADDIUS_GREET) || instance->GetBossState(BOSS_THADDIUS) == DONE)
            return true;

        if (Creature* thaddius = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_THADDIUS_BOSS)))
        {
            thaddius->AI()->Talk(THADDIUS_SAY_GREET);
        }
        instance->SetData(DATA_HAD_THADDIUS_GREET, 1);

        return true;
    }
};

}

#endif