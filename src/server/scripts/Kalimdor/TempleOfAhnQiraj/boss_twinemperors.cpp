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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    // Both
    SPELL_TWIN_EMPATHY            = 1177,
    SPELL_TWIN_TELEPORT_1         = 800,
    SPELL_TWIN_TELEPORT_VISUAL    = 26638,
    SPELL_HEAL_BROTHER            = 7393,
    // Vek'lor
    SPELL_SHADOW_BOLT             = 26006,
    SPELL_BLIZZARD                = 26607,
    SPELL_FRENZY                  = 27897,
    SPELL_ARCANE_BURST            = 568,
    SPELL_EXPLODE_BUG             = 804,
    SPELL_TWIN_TELEPORT_0         = 799,
    // Vek'nilash
    SPELL_UPPERCUT                = 26007,
    SPELL_UNBALANCING_STRIKE      = 26613,
    SPELL_BERSERK                 = 27680,
    SPELL_MUTATE_BUG              = 802,
    // Bugs
    SPELL_VIRULENT_POISON_PROC    = 22413
};

enum Actions
{
    ACTION_START_INTRO            = 0,
    ACTION_CANCEL_INTRO           = 1,
    ACTION_AFTER_TELEPORT         = 2
};

enum Say
{
    SAY_INTRO_0                   = 0,
    SAY_INTRO_1                   = 1,
    SAY_INTRO_2                   = 2,
    SAY_KILL                      = 3,
    SAY_DEATH                     = 4,
    EMOTE_ENRAGE                  = 5,

    EMOTE_MASTERS_EYE_AT          = 0,
};

enum Sounds
{
    SOUND_VK_AGGRO                = 8657,
    SOUND_VN_AGGRO                = 8661
};

enum Misc
{
    GROUP_INTRO                   = 0,

    NPC_QIRAJI_SCARAB             = 15316,
    NPC_QIRAJI_SCORPION           = 15317,

    FACTION_HOSTILE               = 16
};

constexpr float veklorOrientationIntro    = 2.241519f;
constexpr float veknilashOrientationIntro = 1.144451f;

struct boss_twinemperorsAI : public BossAI
{
    boss_twinemperorsAI(Creature* creature): BossAI(creature, DATA_TWIN_EMPERORS), _introDone(false)
    {
        me->SetStandState(UNIT_STAND_STATE_KNEEL);
    }

    Creature* GetTwin()
    {
        return instance->GetCreature(IAmVeklor() ? DATA_VEKNILASH : DATA_VEKLOR);
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (attacker)
        {
            if (attacker->GetEntry() == NPC_VEKLOR || attacker->GetEntry() == NPC_VEKNILASH)
            {
                me->LowerPlayerDamageReq(damage);
                return;
            }

            if (Creature* twin = GetTwin())
            {
                float dmgPct = damage / (float)me->GetMaxHealth();
                int32 actualDmg = dmgPct * twin->GetMaxHealth();
                twin->CastCustomSpell(twin, SPELL_TWIN_EMPATHY, &actualDmg, nullptr, nullptr, true);
            }
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim && victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        BossAI::EnterEvadeMode(why);

        if (Creature* twin = GetTwin())
            if (!twin->IsInEvadeMode())
                twin->AI()->EnterEvadeMode(why);
    }

    void JustDied(Unit* killer) override
    {
        if (Creature* twin = GetTwin())
            if (twin->IsAlive())
                Unit::Kill(me, twin);

        Talk(SAY_DEATH);

        BossAI::JustDied(killer);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_CANCEL_INTRO)
        {
            _introDone = true;
            scheduler.CancelGroup(GROUP_INTRO);
            return;
        }

        if (action == ACTION_AFTER_TELEPORT)
        {
            DoResetThreatList();
            me->SetReactState(REACT_PASSIVE);
            DoCastSelf(SPELL_TWIN_TELEPORT_VISUAL, true);
            scheduler.DelayAll(2300ms);
            scheduler.Schedule(2s, [this](TaskContext /*context*/)
            {
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetControlled(false, UNIT_STATE_ROOT);
                if (Unit* victim = me->SelectNearestTarget())
                {
                    me->AddThreat(victim, 2000.f);
                    AttackStart(victim);
                }
            });
        }

        if (action != ACTION_START_INTRO)
            return;

        scheduler.Schedule(5s, [this](TaskContext /*context*/)
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->LoadEquipment(1, true);
        });

        if (IAmVeklor())
        {
            scheduler.Schedule(12s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_0);
                })
                .Schedule(20s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_1);
                })
                .Schedule(28s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                })
                .Schedule(30s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    me->SetFacingTo(veklorOrientationIntro);
                    Talk(SAY_INTRO_2);
                })
                .Schedule(33s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    _introDone = true;
                });
        }
        else
        {
            scheduler.Schedule(17s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_0);
                })
                .Schedule(23s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_1);
                })
                .Schedule(28s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                })
                .Schedule(32s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    me->SetFacingTo(veknilashOrientationIntro);
                    Talk(SAY_INTRO_2);
                })
                .Schedule(33s, GROUP_INTRO, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    _introDone = true;
                });
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        if (!_introDone)
        {
            DoAction(ACTION_CANCEL_INTRO);
            if (Creature* twin = GetTwin())
                twin->AI()->DoAction(ACTION_CANCEL_INTRO);
        }

        if (Creature* twin = GetTwin())
            if (!twin->IsInCombat())
                twin->AI()->AttackStart(who);

        scheduler.Schedule(15min, [this](TaskContext /*context*/)
            {
                if (IAmVeklor())
                {
                    DoCastSelf(SPELL_FRENZY, true);
                    Talk(EMOTE_ENRAGE);
                }
                else
                    DoCastSelf(SPELL_BERSERK, true);
            })
            .Schedule(3600ms, [this](TaskContext context) // according to sniffs it should be casted by both emperors.
            {
                if (Creature* twin = GetTwin())
                {
                    if (me->IsWithinDist(twin, 60.f))
                        DoCast(twin, SPELL_HEAL_BROTHER, true);
                }

                context.Repeat();
            });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() && _introDone)
            return;

        scheduler.Update(diff, [this]
        {
            if (!IAmVeklor())
                DoMeleeAttackIfReady();
        });
    }

    virtual bool IAmVeklor() = 0;

protected:
    bool _introDone;
};

struct boss_veknilash : public boss_twinemperorsAI
{
    boss_veknilash(Creature* creature) : boss_twinemperorsAI(creature) { }

    bool IAmVeklor() override { return false; }

    void JustEngagedWith(Unit* who) override
    {
        boss_twinemperorsAI::JustEngagedWith(who);

        DoPlaySoundToSet(me, SOUND_VN_AGGRO);

        scheduler.Schedule(14s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_UPPERCUT, 0, me->GetMeleeReach(), true);
                context.Repeat(4s, 15s);
            })
            .Schedule(12s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_UNBALANCING_STRIKE);
                context.Repeat(8s, 20s);
            })
            .Schedule(16s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_MUTATE_BUG);
                context.Repeat(10s, 20s);
            });
    }
};

struct boss_veklor : public boss_twinemperorsAI
{
    boss_veklor(Creature* creature) : boss_twinemperorsAI(creature) { }

    bool IAmVeklor() override { return true; }

    void JustEngagedWith(Unit* who) override
    {
        boss_twinemperorsAI::JustEngagedWith(who);

        DoPlaySoundToSet(me, SOUND_VK_AGGRO);

        scheduler.Schedule(4s, [this](TaskContext context)
            {
                if (me->GetVictim())
                {
                    if (!me->IsWithinDist(me->GetVictim(), 45.0f))
                    {
                        me->GetMotionMaster()->MoveChase(me->GetVictim(), 45.0f, 0);
                    }
                    else
                    {
                        me->StopMoving();
                        me->GetMotionMaster()->Clear();
                    }
                }

                DoCastVictim(SPELL_SHADOW_BOLT);
                context.Repeat(2500ms);
            })
            .Schedule(10s, 15s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_BLIZZARD, 0, 45.f);
                context.Repeat(10s, 24s);
            })
            .Schedule(1s, [this](TaskContext context)
            {
                if (me->SelectNearestPlayer(NOMINAL_MELEE_RANGE))
                    DoCastAOE(SPELL_ARCANE_BURST);
                context.Repeat(7s, 12s);
            })
            .Schedule(30s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_TWIN_TELEPORT_0);
                context.Repeat(30s, 40s);
            })
            .Schedule(5s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_EXPLODE_BUG);
                context.Repeat(4500ms, 10s);
            });
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_TWIN_TELEPORT_0)
        {
            if (Creature* veknilash = GetTwin())
            {
                DoCastSelf(SPELL_TWIN_TELEPORT_1, true);
                me->SetControlled(true, UNIT_STATE_ROOT);

                Position veklorPos = me->GetPosition();
                Position veknilashPos = veknilash->GetPosition();
                me->NearTeleportTo(veknilashPos);

                veknilash->CastSpell(veknilash, SPELL_TWIN_TELEPORT_1, true);
                veknilash->SetControlled(true, UNIT_STATE_ROOT);
                veknilash->NearTeleportTo(veklorPos);

                veknilash->AI()->DoAction(ACTION_AFTER_TELEPORT);
                DoAction(ACTION_AFTER_TELEPORT);
            }
        }
    }

    void AttackStart(Unit* who) override
    {
        if (who && who->isTargetableForAttack() && me->GetReactState() != REACT_PASSIVE)
        {
            // VL doesn't melee
            if (me->Attack(who, false))
            {
                me->GetMotionMaster()->MoveChase(who, 45.0f, 0);
                me->AddThreat(who, 0.0f);
            }
        }
    }
};

class at_twin_emperors : public OnlyOnceAreaTriggerScript
{
public:
    at_twin_emperors() : OnlyOnceAreaTriggerScript("at_twin_emperors") { }

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (instance->GetBossState(DATA_TWIN_EMPERORS) != DONE)
            {
                if (Creature* mastersEye = instance->GetCreature(DATA_MASTERS_EYE))
                {
                    mastersEye->AI()->Talk(EMOTE_MASTERS_EYE_AT, player);
                    mastersEye->DespawnOrUnsummon(11000);
                    mastersEye->m_Events.AddEventAtOffset([mastersEye, player]()
                        {
                            mastersEye->SetFacingToObject(player);
                        }, 3s);
                }

                if (Creature* veklor = instance->GetCreature(DATA_VEKLOR))
                    veklor->AI()->DoAction(ACTION_START_INTRO);

                if (Creature* veknilash = instance->GetCreature(DATA_VEKNILASH))
                    veknilash->AI()->DoAction(ACTION_START_INTRO);
            }
        }
        return false;
    }
};

class spell_mutate_explode_bug : public SpellScript
{
    PrepareSpellScript(spell_mutate_explode_bug);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject const* target) -> bool
            {
                if (target->GetEntry() != NPC_QIRAJI_SCARAB && target->GetEntry() != NPC_QIRAJI_SCORPION)
                    return true;
                if (Creature const* creature = target->ToCreature())
                    if (creature->HasAnyAuras(SPELL_EXPLODE_BUG, SPELL_MUTATE_BUG))
                        return true;

                return false;
            });

        Acore::Containers::RandomResize(targets, 1);
    }

    void HandleOnHit()
    {
        if (!GetHitUnit())
            return;

        Creature* target = GetHitUnit()->ToCreature();

        if (!target)
            return;

        if (m_scriptSpellId == SPELL_MUTATE_BUG)
            target->CastSpell(target, SPELL_VIRULENT_POISON_PROC, true);
        target->SetFaction(FACTION_HOSTILE);
        target->SetReactState(REACT_AGGRESSIVE);
        target->SetInCombatWithZone();
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mutate_explode_bug::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENTRY);
        OnHit += SpellHitFn(spell_mutate_explode_bug::HandleOnHit);
    }
};

void AddSC_boss_twinemperors()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_veknilash);
    RegisterTempleOfAhnQirajCreatureAI(boss_veklor);
    new at_twin_emperors();
    RegisterSpellScript(spell_mutate_explode_bug);
}
