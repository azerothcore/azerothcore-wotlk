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
#include "GameObject.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "karazhan.h"
#include "SpellMgr.h"

enum Texts
{
    SAY_AGGRO              = 0,
    SAY_FLAMEWREATH        = 1,
    SAY_BLIZZARD           = 2,
    SAY_EXPLOSION          = 3,
    SAY_DRINK              = 4,
    SAY_ELEMENTALS         = 5,
    SAY_KILL               = 6,
    SAY_TIMEOVER           = 7,
    SAY_DEATH              = 8,
    SAY_ATIESH             = 9,
    EMOTE_ARCANE_EXPLOSION = 10
};

enum Spells
{
    SPELL_FROSTBOLT              = 29954,
    SPELL_FIREBALL               = 29953,
    SPELL_ARCANE_MISSILE         = 29955,
    SPELL_CHAINSOFICE            = 29991,
    SPELL_DRAGONSBREATH          = 29964,
    SPELL_MASSSLOW               = 30035,
    SPELL_FLAME_WREATH           = 30004,
    SPELL_FLAME_WREATH_RING      = 29946,
    SPELL_FLAME_WREATH_RAN_THRU  = 29947, // You ran through the flames!
    SPELL_FLAME_WREATH_EXPLOSION = 29949,
    SPELL_AOE_CS                 = 29961,
    SPELL_PLAYERPULL             = 32265,
    SPELL_AEXPLOSION             = 29973,
    SPELL_MASS_POLY              = 29963,
    SPELL_BLINK_CENTER           = 29967,
    SPELL_CONJURE                = 29975,
    SPELL_DRINK                  = 30024,
    SPELL_POTION                 = 32453,
    SPELL_AOE_PYROBLAST          = 29978,

    SPELL_SUMMON_WELEMENTAL_1    = 29962,
    SPELL_SUMMON_WELEMENTAL_2    = 37051,
    SPELL_SUMMON_WELEMENTAL_3    = 37052,
    SPELL_SUMMON_WELEMENTAL_4    = 37053,

    SPELL_SUMMON_BLIZZARD        = 29969, // Activates the Blizzard NPC

    SPELL_SHADOW_PYRO            = 29978,

    SPELL_ATIESH_VISUAL          = 31796,

    SPELL_CURSE_OF_TONGUE_RANK1  = 1714,
    SPELL_CURSE_OF_TONGUE_RANK2  = 11719,
    SPELL_MIND_NUMBING_POISON    = 5760
};

enum Creatures
{
    NPC_SHADOW_OF_ARAN           = 18254
};

enum SuperSpell
{
    SUPER_FLAME                  = 0,
    SUPER_BLIZZARD,
    SUPER_AE,
};

enum Groups
{
    GROUP_DRINKING               = 0
};

enum Misc
{
    ACTION_ATIESH_REACT          = 1
};

Position const roomCenter = {-11158.f, -1920.f};

std::vector<uint32> immuneSpells = { SPELL_CURSE_OF_TONGUE_RANK1, SPELL_CURSE_OF_TONGUE_RANK2, SPELL_MIND_NUMBING_POISON };

struct boss_shade_of_aran : public BossAI
{
    boss_shade_of_aran(Creature* creature) : BossAI(creature, DATA_ARAN), _atieshReaction(false) { }

    void Reset() override
    {
        BossAI::Reset();
        // Reset the mana of the boss fully before resetting drinking
        // If this was omitted, the boss would start drinking on reset if the mana was low on a wipe
        me->SetPower(POWER_MANA, me->GetMaxPower(POWER_MANA));
        _drinkScheduler.CancelAll();

        _lastSuperSpell = 0;
        _currentNormalSpell = 0;

        _drinking = false;
        _hasDrunk = false;

        for (auto spell : immuneSpells)
            me->ApplySpellImmune(0, IMMUNITY_ID, spell, true);

        if (GameObject* libraryDoor = instance->instance->GetGameObject(instance->GetGuidData(DATA_GO_LIBRARY_DOOR)))
        {
            libraryDoor->SetGoState(GO_STATE_ACTIVE);
            libraryDoor->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
        }

        ScheduleHealthCheckEvent(40, [&]{
            Talk(SAY_ELEMENTALS);

            std::vector<uint32> elementalSpells = { SPELL_SUMMON_WELEMENTAL_1, SPELL_SUMMON_WELEMENTAL_2, SPELL_SUMMON_WELEMENTAL_3, SPELL_SUMMON_WELEMENTAL_4 };

            for (auto const& spell : elementalSpells)
            {
                DoCastAOE(spell, true);
            }
        });
    }

    bool CheckAranInRoom()
    {
        return me->GetDistance2d(roomCenter.GetPositionX(), roomCenter.GetPositionY()) < 45.0f;
    }

    void SetGUID(ObjectGuid guid, int32 id) override
    {
        if (id == ACTION_ATIESH_REACT && !_atieshReaction)
        {
            Talk(SAY_ATIESH);
            _atieshReaction = true;
            if (Unit* atieshOwner = ObjectAccessor::GetUnit(*me, guid))
            {
                me->PauseMovement(3000);
                me->SetFacingToObject(atieshOwner);
            }
        }
    }

    void AttackStart(Unit* who) override
    {
        if (who && who->isTargetableForAttack() && me->GetReactState() != REACT_PASSIVE)
        {
            if (me->Attack(who, false))
            {
                me->GetMotionMaster()->MoveChase(who, 45.0f, 0);
                me->AddThreat(who, 0.0f);
            }
        }
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_KILL);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();

        if (GameObject* libraryDoor = instance->instance->GetGameObject(instance->GetGuidData(DATA_GO_LIBRARY_DOOR)))
        {
            libraryDoor->SetGoState(GO_STATE_ACTIVE);
            libraryDoor->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
        }
    }

    void DamageTaken(Unit* doneBy, uint32& damage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override
    {
        BossAI::DamageTaken(doneBy, damage, damagetype, damageSchoolMask);

        if ((damagetype == DIRECT_DAMAGE || damagetype == SPELL_DIRECT_DAMAGE) && _drinking && me->GetReactState() == REACT_PASSIVE)
        {
            me->RemoveAurasDueToSpell(SPELL_DRINK);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetPower(POWER_MANA, me->GetMaxPower(POWER_MANA) - 32000);
            _drinkScheduler.CancelGroup(GROUP_DRINKING);
            _drinkScheduler.Schedule(1s, [this](TaskContext)
            {
                DoCastSelf(SPELL_AOE_PYROBLAST, false);
                _drinking = false;
            });
        }
    }

    void OnPowerUpdate(Powers /*power*/, int32 /*gain*/, int32 /*updateVal*/, uint32 currentPower) override
    {
        // Should drink at 10%, need 10% mana for mass polymorph
        if (!_hasDrunk && me->GetMaxPower(POWER_MANA) && (currentPower * 100 / me->GetMaxPower(POWER_MANA)) < 13.5)
        {
            _hasDrunk = true;
            me->SetReactState(REACT_PASSIVE);

            // Start drinking after conjuring drinks
            _drinkScheduler.Schedule(0s, GROUP_DRINKING, [this](TaskContext)
            {
                me->InterruptNonMeleeSpells(true);
                me->RemoveAurasDueToSpell(SPELL_ARCANE_MISSILE);
                Talk(SAY_DRINK);
                DoCastAOE(SPELL_MASS_POLY);
                // If we set drinking earlier it will break when someone attacks aran while casting poly
                _drinking = true;
            }).Schedule(3s, GROUP_DRINKING, [this](TaskContext)
            {
                DoCastSelf(SPELL_CONJURE);
            }).Schedule(6s, GROUP_DRINKING, [this](TaskContext)
            {
                me->SetStandState(UNIT_STAND_STATE_SIT);
                DoCastSelf(SPELL_DRINK);
            }).Schedule(12s, GROUP_DRINKING, [this](TaskContext)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetPower(POWER_MANA, me->GetMaxPower(POWER_MANA) - 32000);
                DoCastSelf(SPELL_AOE_PYROBLAST);
                _drinkScheduler.CancelGroup(GROUP_DRINKING);
                _drinking = false;
            });
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        //handle timed closing door
        scheduler.Schedule(15s, [this](TaskContext)
        {
            if (GameObject* libraryDoor = instance->instance->GetGameObject(instance->GetGuidData(DATA_GO_LIBRARY_DOOR)))
            {
                libraryDoor->SetGoState(GO_STATE_READY);
                libraryDoor->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
            }
        }).Schedule(1s, [this](TaskContext context)
        {
            if (!_drinking)
            {
                if (me->IsNonMeleeSpellCast(false))
                {
                    return;
                }

                std::list<uint32> normalSpells = { SPELL_ARCANE_MISSILE, SPELL_FIREBALL, SPELL_FROSTBOLT };
                normalSpells.remove_if([&](uint32 spell) -> bool { return !me->CanCastSpell(spell); });

                if (!normalSpells.empty())
                {
                    // If we are able to cast spells, cast them.
                    _currentNormalSpell = Acore::Containers::SelectRandomContainerElement(normalSpells);

                    DoCastRandomTarget(_currentNormalSpell, 0, 100.0f);
                    if (me->GetVictim())
                    {
                        me->GetMotionMaster()->MoveChase(me->GetVictim(), 45.0f);
                    }
                }
                else
                {
                    // Otherwise, chase in melee range for auto attacks (and drink mana potion, if needed).
                    me->SetWalk(false);
                    me->ResumeChasingVictim();

                    if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(_currentNormalSpell))
                    {
                        if (int32(me->GetPower(POWER_MANA)) < spellInfo->CalcPowerCost(me, (SpellSchoolMask)spellInfo->SchoolMask))
                        {
                            DoCastSelf(SPELL_POTION);
                        }
                    }
                }
            }
            context.Repeat(2s);
        }).Schedule(5s, [this](TaskContext context)
        {
            if (!_drinking)
            {
                urand(0, 1) ? DoCastSelf(SPELL_AOE_CS) : DoCastRandomTarget(SPELL_CHAINSOFICE);
            }
            context.Repeat(5s, 20s);
        }).Schedule(6s, [this](TaskContext context)
        {
            if (!_drinking)
            {
                me->ClearProhibitedSpellTimers();

                DoCastSelf(SPELL_BLINK_CENTER, true);

                std::vector<uint32> superSpells = { SPELL_SUMMON_BLIZZARD, SPELL_AEXPLOSION, SPELL_FLAME_WREATH };

                // Workaround for SelectRandomContainerElementIf
                std::vector<uint32> allowedSpells;
                std::copy_if(superSpells.begin(), superSpells.end(), std::back_inserter(allowedSpells), [&](uint32 superSpell) -> bool { return superSpell != _lastSuperSpell; });
                _lastSuperSpell = allowedSpells[urand(0, allowedSpells.size() - 1)];

                //  SelectRandomContainerElementIf produces unexpected output. Reintroduce when issue is resolved:
                //  Sample results:
                //       Selected Super Spell: 3722304989
                //       superSpells elements : 29969 29973 30004
                //  _lastSuperSpell = Acore::Containers::SelectRandomContainerElementIf(superSpells, [&](uint32 superSpell) -> bool { return superSpell != _lastSuperSpell; });

                me->InterruptNonMeleeSpells(true); // Super spell should have prio over normal spells

                switch (_lastSuperSpell)
                {
                    case SPELL_AEXPLOSION:
                        Talk(SAY_EXPLOSION);
                        Talk(EMOTE_ARCANE_EXPLOSION);
                        DoCastSelf(SPELL_PLAYERPULL, true);
                        DoCastSelf(SPELL_MASSSLOW, true);
                        break;
                    case SPELL_FLAME_WREATH:
                        Talk(SAY_FLAMEWREATH);
                        break;
                    case SPELL_SUMMON_BLIZZARD:
                        Talk(SAY_BLIZZARD);
                        break;
                }

                DoCastAOE(_lastSuperSpell);
            }
            context.Repeat(35s, 40s);
        }).Schedule(12min, [this](TaskContext context)
        {
            for (uint32 i = 0; i < 5; ++i)
            {
                if (Creature* unit = me->SummonCreature(NPC_SHADOW_OF_ARAN, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000))
                {
                    unit->Attack(me->GetVictim(), true);
                    unit->SetFaction(me->GetFaction());
                }
            }

            Talk(SAY_TIMEOVER);

            context.Repeat(1min);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
        _drinkScheduler.Update(diff);

        if (!UpdateVictim())
            return;

        if (!CheckAranInRoom())
        {
            EnterEvadeMode();
            return;
        }

        if (!_drinking)
            DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _drinkScheduler;

    uint32 _currentNormalSpell;
    uint32 _lastSuperSpell;

    bool _drinking;
    bool _hasDrunk;
    bool _atieshReaction;
};

// 30004 - Flame Wreath
class spell_flamewreath : public SpellScript
{
    PrepareSpellScript(spell_flamewreath);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_FLAME_WREATH_RING });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        uint8 maxSize = 3;

        if (targets.size() > maxSize)
        {
            Acore::Containers::RandomResize(targets, maxSize);
        }

        _targets = targets;
    }

    void HandleFinish()
    {
        for (auto const& target : _targets)
        {
            if (Unit* targetUnit = target->ToUnit())
            {
                GetCaster()->CastSpell(targetUnit, SPELL_FLAME_WREATH_RING, true);
            }
        }
    }

private:
    std::list<WorldObject*> _targets;

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_flamewreath::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
        AfterCast += SpellCastFn(spell_flamewreath::HandleFinish);
    }
};

// 29946 - Flame Wreath (visual effect)
class spell_flamewreath_aura : public AuraScript
{
    PrepareAuraScript(spell_flamewreath_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_FLAME_WREATH_RAN_THRU, SPELL_FLAME_WREATH_EXPLOSION });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEFAULT && GetDuration())
        {
            if (Unit* target = GetTarget())
            {
                if (target->IsPlayer())
                {
                    target->CastSpell(target, SPELL_FLAME_WREATH_RAN_THRU, true);

                    target->m_Events.AddEventAtOffset([target] {
                        target->RemoveAurasDueToSpell(SPELL_FLAME_WREATH_RAN_THRU);
                        target->CastSpell(target, SPELL_FLAME_WREATH_EXPLOSION, true);
                    }, 1s);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_flamewreath_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class at_karazhan_atiesh_aran : public AreaTriggerScript
{
public:
    at_karazhan_atiesh_aran() : AreaTriggerScript("at_karazhan_atiesh_aran") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (player->HasAura(SPELL_ATIESH_VISUAL))
            {
                if (Creature* aran = instance->GetCreature(DATA_ARAN))
                {
                    aran->AI()->SetGUID(player->GetGUID(), ACTION_ATIESH_REACT);
                }
            }
        }

        return true;
    }
};

void AddSC_boss_shade_of_aran()
{
    RegisterKarazhanCreatureAI(boss_shade_of_aran);
    RegisterSpellScript(spell_flamewreath);
    RegisterSpellScript(spell_flamewreath_aura);
    new at_karazhan_atiesh_aran();
}
