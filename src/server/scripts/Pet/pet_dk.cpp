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
};

class npc_pet_dk_ebon_gargoyle : public CreatureScript
{
public:
    npc_pet_dk_ebon_gargoyle() : CreatureScript("npc_pet_dk_ebon_gargoyle") { }

    struct npc_pet_dk_ebon_gargoyleAI : ScriptedAI
    {
        npc_pet_dk_ebon_gargoyleAI(Creature* creature) : ScriptedAI(creature)
        {
            _despawnTimer = 36000; // 30 secs + 4 fly out + 2 initial attack timer
            _despawning = false;
            _initialSelection = true;
            _targetGUID.Clear();
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type == POINT_MOTION_TYPE && point == 1)
            {
                me->SetCanFly(false);
                me->SetDisableGravity(false);
            }
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
                {
                    if (aur->GetEffect(0))
                    {
                        aur->GetEffect(0)->SetAmount(-aurEff->GetSpellInfo()->Effects[EFFECT_2].CalcValue());
                    }
                }

            me->SetCanFly(true);
            me->SetDisableGravity(true);

            float tz = me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), true, MAX_FALL_DISTANCE);
            me->GetMotionMaster()->MoveCharge(me->GetPositionX(), me->GetPositionY(), tz, 7.0f, 1);
            me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
            _selectionTimer = 2000;
            _initialCastTimer = 0;
        }

        void MySelectNextTarget()
        {
            Unit* owner = me->GetOwner();
            if (owner && owner->IsPlayer() && (!me->GetVictim() || me->GetVictim()->IsImmunedToSpell(sSpellMgr->GetSpellInfo(51963)) || !me->IsValidAttackTarget(me->GetVictim()) || !owner->CanSeeOrDetect(me->GetVictim())))
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
            ScriptedAI::AttackStart(who);
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

        // Fly away when dismissed
        void FlyAway()
        {
            RemoveTargetAura();

            // Stop Fighting
            me->CombatStop(true);
            me->ApplyModFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE, true);

            // Sanctuary
            me->CastSpell(me, SPELL_DK_SANCTUARY, true);
            me->SetReactState(REACT_PASSIVE);

            me->SetSpeed(MOVE_FLIGHT, 1.0f, true);
            me->SetSpeed(MOVE_RUN, 1.0f, true);
            float x = me->GetPositionX() + 20 * cos(me->GetOrientation());
            float y = me->GetPositionY() + 20 * std::sin(me->GetOrientation());
            float z = me->GetPositionZ() + 40;
            me->DisableSpline();
            me->GetMotionMaster()->Clear(false);

            me->GetMotionMaster()->MoveCharge(x, y, z, 7.0f, 1);
            me->SetCanFly(true);
            me->SetDisableGravity(true);

            _despawning = true;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_initialSelection)
            {
                _initialSelection = false;
                // Find victim of Summon Gargoyle spell
                std::list<Unit*> targets;
                Acore::AnyUnfriendlyUnitInObjectRangeCheck u_check(me, me, 50.0f);
                Acore::UnitListSearcher<Acore::AnyUnfriendlyUnitInObjectRangeCheck> searcher(me, targets, u_check);
                Cell::VisitAllObjects(me, searcher, 50.0f);
                for (std::list<Unit*>::const_iterator iter = targets.begin(); iter != targets.end(); ++iter)
                    if ((*iter)->GetAura(SPELL_DK_SUMMON_GARGOYLE_1, me->GetOwnerGUID()))
                    {
                        (*iter)->RemoveAura(SPELL_DK_SUMMON_GARGOYLE_1, me->GetOwnerGUID());
                        SetGazeOn(*iter);
                        _targetGUID = (*iter)->GetGUID();
                        break;
                    }
            }
            if (_despawnTimer > 4000)
            {
                _despawnTimer -= diff;
                if (!UpdateVictimWithGaze())
                {
                    MySelectNextTarget();
                    return;
                }

                _initialCastTimer += diff;
                _selectionTimer += diff;
                if (_selectionTimer >= 1000)
                {
                    MySelectNextTarget();
                    _selectionTimer = 0;
                }
                if (_initialCastTimer >= 2000 && !me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_LOST_CONTROL) && me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == NULL_MOTION_TYPE)
                    me->CastSpell(me->GetVictim(), 51963, false);
            }
            else
            {
                if (!_despawning)
                    FlyAway();

                if (_despawnTimer > diff)
                    _despawnTimer -= diff;
                else
                    me->DespawnOrUnsummon();
            }
        }

    private:
        ObjectGuid _targetGUID;
        uint32 _despawnTimer;
        uint32 _selectionTimer;
        uint32 _initialCastTimer;
        bool _despawning;
        bool _initialSelection;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pet_dk_ebon_gargoyleAI(creature);
    }
};

class npc_pet_dk_ghoul : public CreatureScript
{
public:
    npc_pet_dk_ghoul() : CreatureScript("npc_pet_dk_ghoul") { }

    struct npc_pet_dk_ghoulAI : public CombatAI
    {
        npc_pet_dk_ghoulAI(Creature* c) : CombatAI(c) { }

        void JustDied(Unit* /*who*/) override
        {
            if (me->IsGuardian() || me->IsSummon())
                me->ToTempSummon()->UnSummon();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_pet_dk_ghoulAI (pCreature);
    }
};

class npc_pet_dk_risen_ally : public CreatureScript
{
public:
    npc_pet_dk_risen_ally() : CreatureScript("npc_pet_dk_risen_ally") { }

    struct npc_pet_dk_risen_allyAI : public PossessedAI
    {
        npc_pet_dk_risen_allyAI(Creature* c) : PossessedAI(c) { }

        void OnCharmed(bool apply) override
        {
            if (!apply)
            {
                if (Unit* owner = me->GetCharmerOrOwner())
                {
                    if (Player* player = owner->ToPlayer())
                    {
                        player->RemoveAurasDueToSpell(SPELL_DK_RAISE_ALLY); // Remove Raise Ally aura
                        player->RemoveAurasDueToSpell(SPELL_GHOUL_FRENZY); // Remove Frenzy aura
                        //player->ClearResurrectRequestData();
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_pet_dk_risen_allyAI (pCreature);
    }
};

class npc_pet_dk_army_of_the_dead : public CreatureScript
{
public:
    npc_pet_dk_army_of_the_dead() : CreatureScript("npc_pet_dk_army_of_the_dead") { }

    struct npc_pet_dk_army_of_the_deadAI : public CombatAI
    {
        npc_pet_dk_army_of_the_deadAI(Creature* creature) : CombatAI(creature) { }

        void InitializeAI() override
        {
            CombatAI::InitializeAI();
            ((Minion*)me)->SetFollowAngle(rand_norm() * 2 * M_PI);

            // Heroism / Bloodlust immunity
            me->ApplySpellImmune(0, IMMUNITY_ID, 32182, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 2825, true);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pet_dk_army_of_the_deadAI (creature);
    }
};

class npc_pet_dk_dancing_rune_weapon : public CreatureScript
{
public:
    npc_pet_dk_dancing_rune_weapon() : CreatureScript("npc_pet_dk_dancing_rune_weapon") { }

    struct npc_pet_dk_dancing_rune_weaponAI : public NullCreatureAI
    {
        npc_pet_dk_dancing_rune_weaponAI(Creature* creature) : NullCreatureAI(creature) { }

        void InitializeAI() override
        {
            // Xinef: Hit / Expertise scaling
            me->AddAura(61017, me);
            if (Unit* owner = me->GetOwner())
                me->GetMotionMaster()->MoveFollow(owner, 0.01f, me->GetFollowAngle(), MOTION_SLOT_CONTROLLED);

            NullCreatureAI::InitializeAI();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pet_dk_dancing_rune_weaponAI (creature);
    }
};

class spell_pet_dk_gargoyle_strike : public SpellScript
{
    PrepareSpellScript(spell_pet_dk_gargoyle_strike);

    void HandleDamageCalc(SpellEffIndex /*effIndex*/)
    {
        int32 damage = 60;
        if (Unit* caster = GetCaster())
        {
            if (caster->GetLevel() >= 60)
            {
                damage += (caster->GetLevel() - 60) * 4;
            }
        }

        SetEffectValue(damage);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pet_dk_gargoyle_strike::HandleDamageCalc, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void AddSC_deathknight_pet_scripts()
{
    new npc_pet_dk_ebon_gargoyle();
    new npc_pet_dk_ghoul();
    new npc_pet_dk_risen_ally();
    new npc_pet_dk_army_of_the_dead();
    new npc_pet_dk_dancing_rune_weapon();
    RegisterSpellScript(spell_pet_dk_gargoyle_strike);
}
