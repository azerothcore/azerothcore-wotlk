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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "blood_furnace.h"

enum eEnums
{
    SAY_AGGRO               = 0,

    SPELL_SLIME_SPRAY       = 30913,
    SPELL_POISON_CLOUD      = 30916,
    SPELL_POISON_BOLT       = 30917,
    SPELL_POISON            = 30914,
};

struct boss_broggok : public BossAI
{
    boss_broggok(Creature* creature) : BossAI(creature, DATA_BROGGOK) { }

    void Reset() override
    {
        _Reset();
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToAll(true);
    }

    void EnterCombat(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _EnterCombat();
    }

<<<<<<< Updated upstream
    void JustSummoned(Creature* summoned) override
=======
        InstanceScript* instance;
        SummonList summons;
        bool canAttack;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();

            me->SetReactState(REACT_PASSIVE);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToAll(true);
            canAttack = false;

            if (instance)
                instance->SetData(DATA_BROGGOK, NOT_STARTED);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
        }

        void JustSummoned(Creature* summoned) override
        {
            summons.Summon(summoned);

            summoned->SetFaction(FACTION_MONSTER_2);
            summoned->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            summoned->CastSpell(summoned, SPELL_POISON, true, 0, 0, me->GetGUID());
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || !canAttack)
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_SLIME:
                    me->CastSpell(me->GetVictim(), SPELL_SLIME_SPRAY, false);
                    events.RepeatEvent(urand(7000, 12000));
                    break;
                case EVENT_SPELL_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_POISON_BOLT, false);
                    events.RepeatEvent(urand(6000, 11000));
                    break;
                case EVENT_SPELL_POISON:
                    me->CastSpell(me, SPELL_POISON_CLOUD, false);
                    events.RepeatEvent(20000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (instance)
            {
                instance->HandleGameObject(instance->GetGuidData(DATA_DOOR4), true);
                instance->HandleGameObject(instance->GetGuidData(DATA_DOOR5), true);
                instance->SetData(DATA_BROGGOK, DONE);
            }
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_PREPARE_BROGGOK:
                    me->SetInCombatWithZone();
                    break;
                case ACTION_ACTIVATE_BROGGOK:
                    events.ScheduleEvent(EVENT_SPELL_SLIME, 10000);
                    events.ScheduleEvent(EVENT_SPELL_POISON, 5000);
                    events.ScheduleEvent(EVENT_SPELL_BOLT, 7000);

                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetImmuneToAll(false);
                    canAttack = true;
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
>>>>>>> Stashed changes
    {
        summons.Summon(summoned);

        summoned->SetFaction(FACTION_MONSTER_2);
        summoned->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        summoned->CastSpell(summoned, SPELL_POISON, true, 0, 0, me->GetGUID());
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
            case ACTION_PREPARE_BROGGOK:
                me->SetInCombatWithZone();
                instance->SetBossState(DATA_BROGGOK, IN_PROGRESS);
                break;
            case ACTION_ACTIVATE_BROGGOK:
                scheduler.Schedule(10s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_SLIME_SPRAY);
                    context.Repeat(7s, 12s);
                }).Schedule(5s, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_POISON_BOLT);
                    context.Repeat(6s, 11s);
                }).Schedule(7s, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_POISON_CLOUD);
                    context.Repeat(20s);
                });

                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(false);
                break;
        }
    }
};

class go_broggok_lever : public GameObjectScript
{
public:
    go_broggok_lever() : GameObjectScript("go_broggok_lever") {}

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (instance->GetBossState(DATA_BROGGOK) == NOT_STARTED)
            {
                if (Creature* broggok = instance->GetCreature(DATA_BROGGOK))
                {
                    instance->SetData(DATA_BROGGOK, IN_PROGRESS);
                    broggok->AI()->DoAction(ACTION_PREPARE_BROGGOK);
                }
            }
        }

        go->UseDoorOrButton();
        return false;
    }
};

// 30914, 38462 - Poison (Broggok)
class spell_broggok_poison_cloud : public AuraScript
{
    PrepareAuraScript(spell_broggok_poison_cloud);

    bool Validate(SpellInfo const* spellInfo) override
    {
        if (!sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_0].TriggerSpell))
            return false;
        return true;
    }

    void PeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();

        uint32 triggerSpell = GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell;
        int32 mod = int32(((float(aurEff->GetTickNumber()) / aurEff->GetTotalTicks()) * 0.9f + 0.1f) * 10000 * 2 / 3);
        GetTarget()->CastCustomSpell(triggerSpell, SPELLVALUE_RADIUS_MOD, mod, (Unit*)nullptr, TRIGGERED_FULL_MASK, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_broggok_poison_cloud::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_broggok()
{
    RegisterBloodFurnaceCreatureAI(boss_broggok);
    new go_broggok_lever();
    RegisterSpellScript(spell_broggok_poison_cloud);
}
