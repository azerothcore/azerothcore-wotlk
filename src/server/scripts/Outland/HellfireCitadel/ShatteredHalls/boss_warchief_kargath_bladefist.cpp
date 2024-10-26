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
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "shattered_halls.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_SLAY                    = 1,
    SAY_DEATH                   = 2,
    SAY_EVADE                   = 5
};

enum Spells
{
    // Blade dance
    SPELL_BLADE_DANCE_TARGETING = 30738,
    SPELL_BLADE_DANCE_DMG       = 30739,
    SPELL_BLADE_DANCE_CHARGE    = 30751,

    // Warchief portal
    SPELL_SUMMON_HEATHEN        = 30737,
    SPELL_SUMMON_REAVER         = 30785,
    SPELL_SUMMON_SHARPSHOOTER   = 30786
};

enum Creatures
{
    NPC_SHATTERED_ASSASSIN      = 17695,
    NPC_BLADE_DANCE_TARGET      = 20709
};

enum PortalData
{
    DATA_START_FIGHT            = 1,
    DATA_RESET_FIGHT            = 2
};

std::array<uint32, 3> const summonSpells = { SPELL_SUMMON_HEATHEN, SPELL_SUMMON_REAVER, SPELL_SUMMON_SHARPSHOOTER };
std::vector<Position> const assassinsPos =
{
    { 172.68164f, -80.65692f, 2.0834563f, 5.4279f },
    { 167.8295f,  -86.55783f, 1.9949634f, 0.8118f },
    { 287.0375f,  -88.17879f, 2.0663502f, 3.2490f },
    { 292.1491f,  -82.25267f, 1.9973913f, 5.8568f }
};

Position const kargathRespawnPos = { 231.25f, -83.6449f, 5.02341f };

struct boss_warchief_kargath_bladefist : public BossAI
{
    boss_warchief_kargath_bladefist(Creature* creature) : BossAI(creature, DATA_KARGATH)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void InitializeAI() override
    {
        BossAI::InitializeAI();
        if (instance)
        {
            if (Creature* executioner = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EXECUTIONER)))
            {
                executioner->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (summon)
        {
            summon->SetVisible(false);
            scheduler.Schedule(20s, [summon](TaskContext /*context*/)
                {
                    if (summon)
                    {
                        summon->Respawn(true);
                        summon->SetVisible(true);
                    }
                });
        }
    }

    void RespawnAssassins()
    {
        for (Position const& summonPos : assassinsPos)
            me->SummonCreature(NPC_SHATTERED_ASSASSIN, summonPos);
    }

    void Reset() override
    {
        BossAI::Reset();
        if (Creature* warchiefPortal = instance->GetCreature(DATA_WARCHIEF_PORTAL))
            warchiefPortal->AI()->SetData(DATA_RESET_FIGHT, 0);
        _danceCount = 0;
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
        if (Creature* warchiefPortal = instance->GetCreature(DATA_WARCHIEF_PORTAL))
            warchiefPortal->AI()->SetData(DATA_RESET_FIGHT, 0);
        if (instance)
        {
            if (Creature* executioner = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EXECUTIONER)))
            {
                executioner->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        BossAI::JustEngagedWith(who);
        if (Creature* warchiefPortal = instance->GetCreature(DATA_WARCHIEF_PORTAL))
            warchiefPortal->AI()->SetData(DATA_START_FIGHT, 0);
        RespawnAssassins();
        scheduler
            .Schedule(30s, [this](TaskContext context)
                {
                    me->SetReactState(REACT_PASSIVE);
                    _danceCount = 0;
                    DoCastAOE(SPELL_BLADE_DANCE_TARGETING);
                    context.Repeat(32850ms, 41350ms);
                });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim && victim->IsPlayer())
            Talk(SAY_SLAY);
    }

    void MovementInform(uint32 type, uint32 /*id*/) override
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (_danceCount < 8)
        {
            _danceCount++;
            scheduler.Schedule(100ms, [this](TaskContext /*context*/)
                {
                    DoCastAOE(SPELL_BLADE_DANCE_TARGETING);
                });
        }
        else
            me->SetReactState(REACT_AGGRESSIVE);
    }

    bool IsInRoom()
    {
        if (me->GetExactDist2d(kargathRespawnPos) >= 42.f)
            return false;
        return true;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!IsInRoom())
        {
            Talk(SAY_EVADE);
            EnterEvadeMode();
            return;
        }

        if (!UpdateVictim())
            return;

        scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

    protected:
        uint8 _danceCount;
};

struct npc_warchief_portal : public ScriptedAI
{
public:
    npc_warchief_portal(Creature* creature) : ScriptedAI(creature) { }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

    void JustSummoned(Creature* creature) override
    {
        InstanceScript* instance = me->GetInstanceScript();
        if (!instance)
            return;

        if (Creature* kargath = instance->GetCreature(DATA_KARGATH))
            kargath->AI()->JustSummoned(creature);
    }

    void SetData(uint32 type, uint32 /*data*/) override
    {
        if (type == DATA_START_FIGHT)
        {
            _scheduler.Schedule(20600ms, [this](TaskContext context)
                {
                    DoCastSelf(summonSpells[context.GetRepeatCounter() % 3]);
                    context.Repeat();
                });
        }

        if (type == DATA_RESET_FIGHT)
        {
            _scheduler.CancelAll();
        }
    }

protected:
    TaskScheduler _scheduler;
};

class spell_blade_dance_targeting : public SpellScript
{
    PrepareSpellScript(spell_blade_dance_targeting);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLADE_DANCE_CHARGE, SPELL_BLADE_DANCE_DMG });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        targets.remove_if([&](WorldObject* target) -> bool
            {
                float dist = caster->GetDistance2d(target);
                // Do not target dummies that are too close or too far away
                if (dist < 5.f || dist > 16.f)
                    return true;
                // Do not target anything that is not a target dummy
                if (target->GetEntry() != NPC_BLADE_DANCE_TARGET)
                    return true;

                return false;
            });

        std::list<WorldObject*> targets2 = targets;

        targets.remove_if([&](WorldObject* target) -> bool
            {
                if (target->SelectNearestPlayer(15.f))
                    return false;
                return true;
            });

        Acore::Containers::RandomResize(targets2, 1);

        if (urand(0, 2))
        {
            if (targets.empty())
                targets = targets2;
            else
                Acore::Containers::RandomResize(targets, 1);
        }
        else
            targets = targets2;
    }

    void HandleOnHit()
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!caster || !target)
            return;

        caster->CastSpell(target, SPELL_BLADE_DANCE_CHARGE, true);
        caster->CastSpell(target, SPELL_BLADE_DANCE_DMG, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_blade_dance_targeting::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnHit += SpellHitFn(spell_blade_dance_targeting::HandleOnHit);
    }
};

void AddSC_boss_warchief_kargath_bladefist()
{
    RegisterShatteredHallsCreatureAI(boss_warchief_kargath_bladefist);
    RegisterShatteredHallsCreatureAI(npc_warchief_portal);
    RegisterSpellScript(spell_blade_dance_targeting);
}
