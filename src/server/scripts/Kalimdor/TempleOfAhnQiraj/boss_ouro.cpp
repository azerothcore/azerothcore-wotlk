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
#include "TaskScheduler.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    // Ouro
    SPELL_SWEEP                 = 26103,
    SPELL_SAND_BLAST            = 26102,
    SPELL_GROUND_RUPTURE        = 26100,
    SPELL_BERSERK               = 26615,
    SPELL_BOULDER               = 26616,

    // Misc - Mounds, Ouro Spawner
    SPELL_BIRTH                 = 26586,
    SPELL_DIRTMOUND_PASSIVE     = 26092,
    SPELL_SUMMON_OURO           = 26061,
    SPELL_SUMMON_OURO_MOUNDS    = 26058,
    SPELL_QUAKE                 = 26093,
    SPELL_SUMMON_SCARABS        = 26060
};

enum Misc
{
    GROUP_EMERGED               = 0,
    GROUP_PHASE_TRANSITION      = 1,
    GROUP_SUBMERGED             = 2,
};

struct npc_ouro_spawner : public ScriptedAI
{
    npc_ouro_spawner(Creature* creature) : ScriptedAI(creature)
    {
        Reset();
    }

    bool hasSummoned;

    void Reset() override
    {
        hasSummoned = false;
        DoCastSelf(SPELL_DIRTMOUND_PASSIVE);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        // Spawn Ouro on LoS check
        if (!hasSummoned && who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 40.0f) && !who->ToPlayer()->IsGameMaster())
        {
            DoCastSelf(SPELL_SUMMON_OURO);
            hasSummoned = true;
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustSummoned(Creature* creature) override
    {
        // Despawn when Ouro is spawned
        if (creature->GetEntry() == NPC_OURO)
        {
            creature->SetInCombatWithZone();
            creature->CastSpell(creature, SPELL_BIRTH, false);
            me->DespawnOrUnsummon();
        }
    }
};

struct boss_ouro : public BossAI
{
    boss_ouro(Creature* creature) : BossAI(creature, DATA_OURO)
    {
        SetCombatMovement(false);
        me->SetControlled(true, UNIT_STATE_ROOT);
        _scheduler.SetValidator([this] { return !me->HasUnitState(UNIT_STATE_CASTING); });
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->HealthBelowPctDamaged(20, damage) && !_enraged)
        {
            DoCastSelf(SPELL_BERSERK, true);
            _enraged = true;
            _scheduler.CancelGroup(GROUP_PHASE_TRANSITION);
        }
    }

    void Submerge()
    {
        me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        _scheduler.CancelGroup(GROUP_EMERGED);
        _scheduler.CancelGroup(GROUP_PHASE_TRANSITION);
        me->SetReactState(REACT_PASSIVE);
        me->AttackStop();
        _submergeMelee = 0;
        _submerged = true;

        _scheduler.Schedule(20s, [this](TaskContext /*context*/)
            {
                Emerge();
            });
    }

    void Emerge()
    {
        DoCastSelf(SPELL_BIRTH);
        me->SetReactState(REACT_AGGRESSIVE);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        DoCastVictim(SPELL_GROUND_RUPTURE);
        _submergeMelee = 0;
        _submerged = false;
        ScheduleEmerged();
    }

    void Reset() override
    {
        BossAI::Reset();
        _scheduler.CancelAll();
        _submergeMelee = 0;
        _submerged = false;
        _enraged = false;
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);
        me->DespawnOrUnsummon(1000);
        if (Creature* ouroSpawner = instance->GetCreature(DATA_OURO_SPAWNER))
            ouroSpawner->Respawn();
        BossAI::EnterEvadeMode(why);
    }

    void ScheduleEmerged()
    {
        _scheduler
            .Schedule(20s, GROUP_EMERGED, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_SAND_BLAST);
                    context.Repeat();
                })
            .Schedule(22s, GROUP_EMERGED, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_SWEEP);
                    context.Repeat();
                })
            .Schedule(3min, GROUP_PHASE_TRANSITION, [this](TaskContext /*context*/)
                {
                    Submerge();
                })
            .Schedule(1s, GROUP_PHASE_TRANSITION, [this](TaskContext context)
                {
                    if (!IsVictimWithinMeleeRange() && !_submerged)
                    {
                        if (_submergeMelee < 10)
                        {
                            _submergeMelee++;
                            DoSpellAttackToRandomTargetIfReady(SPELL_BOULDER);
                        }
                        else
                        {
                            Submerge();
                            _submergeMelee = 0;
                        }
                    }
                    else
                    {
                        _submergeMelee = 0;
                    }

                    if (!_submerged)
                        context.Repeat();
                });
    }

    void EnterCombat(Unit* who) override
    {
        ScheduleEmerged();

        BossAI::EnterCombat(who);
    }

    void UpdateAI(uint32 diff) override
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

protected:
    TaskScheduler _scheduler;
    bool _enraged;
    uint8 _submergeMelee;
    bool _submerged;

    bool IsVictimWithinMeleeRange() const
    {
        return me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim());
    }
};

void AddSC_boss_ouro()
{
    RegisterTempleOfAhnQirajCreatureAI(npc_ouro_spawner);
    RegisterTempleOfAhnQirajCreatureAI(boss_ouro);
}
