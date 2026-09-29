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

#include "Cell.h"
#include "CellImpl.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_dk_".
 */

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

enum DeathKnightSpells
{
    SPELL_DK_SUMMON_GARGOYLE_1      = 49206,
    SPELL_DK_SUMMON_GARGOYLE_2      = 50514,
    SPELL_DK_DISMISS_GARGOYLE       = 50515,
    SPELL_DK_SANCTUARY              = 54661,
    SPELL_DK_NIGHT_OF_THE_DEAD      = 62137,
    SPELL_DK_PET_SCALING            = 61017,
    // Risen Ally
    SPELL_DK_RAISE_ALLY             = 46619,
    SPELL_GHOUL_FRENZY              = 62218,
    // Gargoyle
    SPELL_GARGOYLE_STRIKE           = 51963,
};

enum GargoylePoints
{
    POINT_GARGOYLE_ARRIVAL = 1,
    POINT_GARGOYLE_DEPARTURE
};

struct npc_pet_dk_ebon_gargoyle : ScriptedAI
{
    npc_pet_dk_ebon_gargoyle(Creature* creature) : ScriptedAI(creature)
    {
        _despawnTimer = 36000; // 30 secs + 4 fly out + 2 initial attack timer
        _despawning = false;
        _arrivalPending = true;
        _arriving = true;
        _initialSelection = true;
        _pendingCommand = false;
        _commandState = COMMAND_ATTACK;
        _landingZ = creature->GetPositionZ();
        _selectionTimer = 0;
        _initialCastTimer = 0;
        _decisionTimer = 0;
        _targetGUID.Clear();
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type != EFFECT_MOTION_TYPE)
            return;

        if (point == POINT_GARGOYLE_ARRIVAL)
        {
            me->SetCanFly(false);
            me->SetDisableGravity(false);
            _arriving = false;
        }
        else if (point == POINT_GARGOYLE_DEPARTURE)
            me->DespawnOrUnsummon();
    }

    void JustExitedCombat() override
    {
        EngagementOver();
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        if (_despawning)
            return;

        if (!_EnterEvadeMode())
            return;

        me->ClearUnitState(UNIT_STATE_EVADE);
        me->GetMotionMaster()->Clear(false);

        if (_commandState == COMMAND_STAY)
            me->GetMotionMaster()->MoveIdle();
        else if (Unit* owner = me->GetOwner())
            me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);
    }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        Unit* owner = me->GetOwner();
        if (!owner)
            return;

        // Xinef: Night of the Dead avoidance
        if (Aura* aur = me->GetAura(SPELL_DK_NIGHT_OF_THE_DEAD))
            if (AuraEffect* aurEff = owner->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_DEATHKNIGHT, 2718, 0))
                if (aur->GetEffect(0))
                    aur->GetEffect(0)->SetAmount(-aurEff->GetSpellInfo()->Effects[EFFECT_2].CalcValue());

        me->SetCanFly(true);
        me->SetDisableGravity(true);

        _landingZ = me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), true, MAX_FALL_DISTANCE);
        me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
        _selectionTimer = 2000;
        _initialCastTimer = 0;
        _decisionTimer = 0;
    }

    void MySelectNextTarget()
    {
        if (_arriving || _commandState != COMMAND_ATTACK)
            return;

        Unit* owner = me->GetOwner();
        if (owner && owner->IsPlayer() && (!me->GetVictim() || me->GetVictim()->IsImmunedToSpell(sSpellMgr->GetSpellInfo(SPELL_GARGOYLE_STRIKE)) || !me->IsValidAttackTarget(me->GetVictim()) || !owner->CanSeeOrDetect(me->GetVictim())))
        {
            Unit* selection = owner->ToPlayer()->GetSelectedUnit();
            if (selection && selection != me->GetVictim() && me->IsValidAttackTarget(selection))
            {
                me->GetMotionMaster()->Clear(false);
                SetGazeOn(selection);
            }

            else if (!me->GetVictim() || !owner->CanSeeOrDetect(me->GetVictim()))
            {
                me->CombatStop(true);
                me->GetMotionMaster()->Clear(false);
                me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, 0.0f);
                RemoveTargetAura();
            }
        }
    }

    void AttackStart(Unit* who) override
    {
        RemoveTargetAura();
        _targetGUID = who->GetGUID();
        me->AddAura(SPELL_DK_SUMMON_GARGOYLE_1, who);
        ScriptedAI::AttackStartCaster(who, 40);
    }

    void RemoveTargetAura()
    {
        if (Unit* target = ObjectAccessor::GetUnit(*me, _targetGUID))
            target->RemoveAura(SPELL_DK_SUMMON_GARGOYLE_1, me->GetGUID());
    }

    void Reset() override
    {
        _selectionTimer = 0;
        me->SetReactState(REACT_PASSIVE);
        MySelectNextTarget();
    }

    void OwnerPetCommand(CommandStates command, Unit* target) override
    {
        if (_despawning || !me->IsAlive())
            return;

        if (_arriving)
        {
            if (command == COMMAND_ATTACK)
            {
                if (!target || !me->IsValidAttackTarget(target) || !me->CanCreatureAttack(target))
                    return;

                _commandTargetGUID = target->GetGUID();
            }
            else if (command != COMMAND_FOLLOW && command != COMMAND_STAY)
                return;

            _commandState = command;
            _pendingCommand = true;
            _initialSelection = false;
            return;
        }

        if (command == COMMAND_ATTACK)
        {
            if (!target || !me->IsValidAttackTarget(target) || !me->CanCreatureAttack(target))
                return;

            _commandState = command;
            _initialSelection = false;
            SetGazeOn(target);
        }
        else if (command == COMMAND_FOLLOW || command == COMMAND_STAY)
        {
            Unit* owner = me->GetOwner();
            if (!owner)
                return;

            _commandState = command;
            _initialSelection = false;
            RemoveTargetAura();
            _targetGUID.Clear();
            me->AttackStop();
            me->CombatStop(true);
            me->InterruptNonMeleeSpells(false);
            me->SetReactState(REACT_PASSIVE);
            me->GetMotionMaster()->Clear(false);
            if (command == COMMAND_FOLLOW)
                me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle());
            else
                me->GetMotionMaster()->MoveIdle();
        }
    }

    // Fly away when dismissed
    void FlyAway()
    {
        _despawning = true;
        RemoveTargetAura();

        // Stop Fighting
        me->CombatStop(true);
        me->InterruptNonMeleeSpells(false);
        me->ApplyModFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE, true);

        // Sanctuary
        me->CastSpell(me, SPELL_DK_SANCTUARY, true);
        me->SetReactState(REACT_PASSIVE);

        float angle = me->GetOrientation();
        if (Unit* owner = me->GetOwner())
            angle = owner->GetAngle(me);

        float x = me->GetPositionX() + 12.0f * std::cos(angle);
        float y = me->GetPositionY() + 12.0f * std::sin(angle);
        float z = me->GetPositionZ() + 18.0f;
        me->GetMotionMaster()->Clear(false);
        me->SetCanFly(true);
        me->SetDisableGravity(true);
        me->GetMotionMaster()->MoveTakeoff(POINT_GARGOYLE_DEPARTURE, x, y, z, 7.0f);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_despawning)
        {
            if (_despawnTimer > diff)
                _despawnTimer -= diff;
            else
                me->DespawnOrUnsummon();
            return;
        }

        if (_despawnTimer <= 4000 || diff >= _despawnTimer - 4000)
        {
            _despawnTimer = 4000;
            FlyAway();
            return;
        }

        _despawnTimer -= diff;
        _initialCastTimer += diff;

        if (_arrivalPending)
        {
            _arrivalPending = false;
            me->GetMotionMaster()->Clear(false);
            float x = me->GetPositionX() + 0.2f * std::cos(me->GetOrientation());
            float y = me->GetPositionY() + 0.2f * std::sin(me->GetOrientation());
            me->GetMotionMaster()->MoveLand(POINT_GARGOYLE_ARRIVAL, x, y, _landingZ, 7.0f);
            return;
        }

        if (_arriving)
            return;

        if (_pendingCommand)
        {
            _pendingCommand = false;
            Unit* target = ObjectAccessor::GetUnit(*me, _commandTargetGUID);
            if (_commandState == COMMAND_ATTACK && !target)
                _initialSelection = true;
            else
                OwnerPetCommand(_commandState, target);
            _commandTargetGUID.Clear();
        }

        if (_initialSelection)
        {
            _initialSelection = false;
            // Find victim of Summon Gargoyle spell
            std::list<Unit*> targets;
            Acore::AnyUnfriendlyUnitInObjectRangeCheck u_check(me, me, 50.0f);
            Acore::UnitListSearcher<Acore::AnyUnfriendlyUnitInObjectRangeCheck> searcher(me, targets, u_check);
            Cell::VisitObjects(me, searcher, 50.0f);
            for (auto const& target : targets)
                if (target->GetAura(SPELL_DK_SUMMON_GARGOYLE_1, me->GetOwnerGUID()))
                {
                    target->RemoveAura(SPELL_DK_SUMMON_GARGOYLE_1, me->GetOwnerGUID());
                    SetGazeOn(target);
                    _targetGUID = target->GetGUID();
                    break;
                }
        }

        _decisionTimer -= diff;
        if (!UpdateVictimWithGaze())
        {
            // Re-engage if we still have a valid victim but lost engagement
            // (e.g., PvP combat reference expired during CC like Cyclone)
            if (Unit* victim = me->GetVictim())
            {
                if (me->IsValidAttackTarget(victim))
                {
                    me->EngageWithTarget(victim);
                    return;
                }
            }
            MySelectNextTarget();
            return;
        }

        _selectionTimer += diff;
        if (_selectionTimer >= 1000)
        {
            MySelectNextTarget();
            _selectionTimer = 0;
        }

        if (_decisionTimer <= 0)
        {
            _decisionTimer += 400;
            if (_initialCastTimer >= 2000 && !me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_LOST_CONTROL) && me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == NULL_MOTION_TYPE && rand_chance() > 20.0f)
            {
                if (me->HasSilenceAura() || me->IsSpellProhibited(SPELL_SCHOOL_MASK_NATURE))
                {
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                }
                else
                {
                    me->GetMotionMaster()->MoveChase(me->GetVictim(), 40);
                    DoCastVictim(SPELL_GARGOYLE_STRIKE);
                }
            }
        }

        if (Unit* victim = me->GetVictim())
            if (me->IsWithinMeleeRange(victim))
            {
                me->Attack(victim, true);
                DoMeleeAttackIfReady();
            }
    }

private:
    ObjectGuid _targetGUID;
    uint32 _despawnTimer;
    uint32 _selectionTimer;
    uint32 _initialCastTimer;
    int32 _decisionTimer;
    float _landingZ;
    bool _despawning;
    bool _arrivalPending;
    bool _arriving;
    bool _initialSelection;
    bool _pendingCommand;
    CommandStates _commandState;
    ObjectGuid _commandTargetGUID;
};

struct npc_pet_dk_ghoul : public CombatAI
{
    npc_pet_dk_ghoul(Creature* c) : CombatAI(c) { }

    void IsSummonedBy(WorldObject* summoner) override
    {
        if (!summoner || !summoner->IsPlayer())
            return;

        // Remember the owner's target so we can attack it after the rising stun expires.
        if (Unit* victim = summoner->ToPlayer()->GetVictim())
            _summonTargetGUID = victim->GetGUID();
    }

    void UpdateAI(uint32 diff) override
    {
        // While stunned (rising animation), don't run CombatAI - just wait.
        if (me->HasUnitState(UNIT_STATE_STUNNED))
            return;

        // Once the stun expires, attack the saved target from summon time.
        if (!_summonTargetGUID.IsEmpty())
        {
            if (Unit* target = ObjectAccessor::GetUnit(*me, _summonTargetGUID))
            {
                if (target->IsAlive() && me->IsValidAttackTarget(target))
                    AttackStart(target);
            }
            _summonTargetGUID.Clear();
        }

        CombatAI::UpdateAI(diff);
    }

    void JustDied(Unit* /*who*/) override
    {
        if (me->IsGuardian() || me->IsSummon())
            me->ToTempSummon()->UnSummon();
    }

private:
    ObjectGuid _summonTargetGUID;
};

struct npc_pet_dk_risen_ally : public PossessedAI
{
    npc_pet_dk_risen_ally(Creature* c) : PossessedAI(c) { }

    void OnCharmed(bool apply) override
    {
        if (!apply)
            if (Unit* owner = me->GetCharmerOrOwner())
                if (Player* player = owner->ToPlayer())
                {
                    player->RemoveAurasDueToSpell(SPELL_DK_RAISE_ALLY); // Remove Raise Ally aura
                    player->RemoveAurasDueToSpell(SPELL_GHOUL_FRENZY); // Remove Frenzy aura
                    //player->ClearResurrectRequestData();
                }
    }
};

struct npc_pet_dk_army_of_the_dead : public AggressorAI
{
    npc_pet_dk_army_of_the_dead(Creature* creature) : AggressorAI(creature) { }

    // Restrict MoveInLineOfSight aggro to targets already fighting our owner,
    // so ghouls don't pull extra packs on their own.
    bool CanAIAttack(Unit const* target) const override
    {
        if (!target)
            return false;
        Unit* owner = me->GetOwner();
        if (owner && !target->IsInCombatWith(owner))
            return false;
        return AggressorAI::CanAIAttack(target);
    }

    // Owner started attacking a target — engage immediately.
    // We bypass OnOwnerCombatInteraction because CanStartAttack -> CanAIAttack
    // may reject the target before combat refs are established.
    void OwnerAttacked(Unit* target) override
    {
        if (!target || !me->IsAlive() || me->HasReactState(REACT_PASSIVE))
            return;
        if (me->IsValidAttackTarget(target))
            AttackStart(target);
    }

    // Owner was attacked — help defend.
    void OwnerAttackedBy(Unit* attacker) override
    {
        if (!attacker || !me->IsAlive() || me->HasReactState(REACT_PASSIVE))
            return;
        if (me->IsValidAttackTarget(attacker))
            AttackStart(attacker);
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (!UpdateVictim())
        {
            // Re-engage if we still have a valid victim but lost engagement
            // (e.g., combat reference expired during CC like knockback)
            if (Unit* victim = me->GetVictim())
            {
                if (me->IsValidAttackTarget(victim))
                {
                    me->EngageWithTarget(victim);
                    return;
                }
            }
            return;
        }

        DoMeleeAttackIfReady();
    }
};

struct npc_pet_dk_dancing_rune_weapon : public NullCreatureAI
{
    npc_pet_dk_dancing_rune_weapon(Creature* creature) : NullCreatureAI(creature) { }

    void InitializeAI() override
    {
        me->AddAura(SPELL_HUNTER_PET_SCALING_04, me);
        if (Unit* owner = me->GetOwner())
            me->GetMotionMaster()->MoveFollow(owner, 0.01f, me->GetFollowAngle(), MOTION_SLOT_CONTROLLED);

        NullCreatureAI::InitializeAI();
    }
};

class spell_pet_dk_gargoyle_strike : public SpellScript
{
    PrepareSpellScript(spell_pet_dk_gargoyle_strike);

    void HandleDamageCalc(SpellEffIndex /*effIndex*/)
    {
        int32 damage = GetEffectValue();
        if (Unit* caster = GetCaster())
            if (caster->GetLevel() >= 60)
                damage += (caster->GetLevel() - 60) * 3;

        SetEffectValue(damage);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_pet_dk_gargoyle_strike::HandleDamageCalc, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void AddSC_deathknight_pet_scripts()
{
    RegisterCreatureAI(npc_pet_dk_ebon_gargoyle);
    RegisterCreatureAI(npc_pet_dk_ghoul);
    RegisterCreatureAI(npc_pet_dk_risen_ally);
    RegisterCreatureAI(npc_pet_dk_army_of_the_dead);
    RegisterCreatureAI(npc_pet_dk_dancing_rune_weapon);
    RegisterSpellScript(spell_pet_dk_gargoyle_strike);
}
