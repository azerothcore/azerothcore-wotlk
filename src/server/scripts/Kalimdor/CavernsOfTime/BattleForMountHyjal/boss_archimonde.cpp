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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "hyjal.h"

enum Texts
{
    SAY_AGGRO       = 1,
    SAY_DOOMFIRE    = 2,
    SAY_AIR_BURST   = 3,
    SAY_SLAY        = 4,
    SAY_ENRAGE      = 5,
    SAY_DEATH       = 6,
    SAY_SOUL_CHARGE = 7,
};

enum ArchiSpells
{
    SPELL_DENOUEMENT_WISP       = 32124,
    SPELL_ANCIENT_SPARK         = 39349,
    SPELL_PROTECTION_OF_ELUNE   = 38528,

    SPELL_DRAIN_WORLD_TREE      = 39140,
    SPELL_DRAIN_WORLD_TREE_2    = 39141,

    SPELL_FINGER_OF_DEATH       = 31984,
    SPELL_RED_SKY_EFFECT        = 32111,
    SPELL_HAND_OF_DEATH         = 35354,
    SPELL_AIR_BURST             = 32014,
    SPELL_GRIP_OF_THE_LEGION    = 31972,
    SPELL_DOOMFIRE_STRIKE       = 31903,    //summons two creatures
    SPELL_DOOMFIRE_SPAWN        = 32074,
    SPELL_DOOMFIRE              = 31945,
    SPELL_SOUL_CHARGE_YELLOW    = 32045,
    SPELL_SOUL_CHARGE_GREEN     = 32051,
    SPELL_SOUL_CHARGE_RED       = 32052,
    SPELL_UNLEASH_SOUL_YELLOW   = 32054,
    SPELL_UNLEASH_SOUL_GREEN    = 32057,
    SPELL_UNLEASH_SOUL_RED      = 32053,
    SPELL_FEAR                  = 31970,
};

enum Summons
{
    CREATURE_DOOMFIRE           = 18095,
    CREATURE_DOOMFIRE_SPIRIT    = 18104,
    CREATURE_ANCIENT_WISP       = 17946,
    CREATURE_CHANNEL_TARGET     = 22418,
};

enum Events
{
    EVENT_DRAIN_WORLD_TREE              = 1,
    EVENT_SPELL_FEAR                    = 2,
    EVENT_SPELL_AIR_BURST               = 3,
    EVENT_SPELL_GRIP_OF_THE_LEGION      = 4,
    EVENT_SPELL_UNLEASH_SOUL_CHARGES    = 5,
    EVENT_SPELL_DOOMFIRE                = 6,
    EVENT_SPELL_FINGER_OF_DEATH         = 7,
    EVENT_SPELL_HAND_OF_DEATH           = 8,
    EVENT_SPELL_PROTECTION_OF_ELUNE     = 9,
    EVENT_ENRAGE                        = 10,
    EVENT_CHECK_WORLD_TREE_DISTANCE     = 11,    // Enrage if too close to the tree
    EVENT_BELOW_10_PERCENT_HP           = 12,
    EVENT_SUMMON_WISPS                  = 13,
    EVENT_TOO_CLOSE_TO_WORLD_TREE       = 14,
    EVENT_ENRAGE_ROOT                   = 15,
    EVENT_SPELL_FINGER_OF_DEATH_PHASE_4 = 16
};

Position const NordrassilLoc = { 5503.713f, -3523.436f, 1608.781f, 0.0f };

struct npc_ancient_wisp : public ScriptedAI
{
    npc_ancient_wisp(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        ScheduleTimedEvent(1s, [&]
        {
            if (Creature* archimonde = _instance->GetCreature(DATA_ARCHIMONDE))
            {
                if (archimonde->HealthBelowPct(2) || !archimonde->IsAlive())
                {
                    DoCastSelf(SPELL_DENOUEMENT_WISP);
                }
                else
                {
                    DoCast(archimonde, SPELL_ANCIENT_SPARK);
                }
            }
        }, 1s);
    }

    void JustEngagedWith(Unit* /*who*/) override { }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

    }

private:
    InstanceScript* _instance;
};

//TODO: move to db?
struct npc_doomfire : public ScriptedAI
{
    npc_doomfire(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override { }

    void MoveInLineOfSight(Unit* /*who*/) override { }

    void JustEngagedWith(Unit* /*who*/) override { }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }
};

struct npc_doomfire_targetting : public ScriptedAI
{
    npc_doomfire_targetting(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _chaseTarget = nullptr;
        ScheduleTimedEvent(5s, [&]
        {
            if (_chaseTarget)
            {
                me->GetMotionMaster()->MoveFollow(_chaseTarget, 0.0f, 0.0f);
            }
            else
            {
                Position randomPosition = me->GetRandomNearPosition(40.0f);
                me->GetMotionMaster()->MovePoint(0, randomPosition);
            }
        }, 5s);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->IsPlayer())
        {
            _chaseTarget = who;
        }
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }
private:
    Unit* _chaseTarget;
};
struct boss_archimonde : public BossAI
{
    boss_archimonde(Creature* creature) : BossAI(creature, DATA_ARCHIMONDE)
    {
        scheduler.SetValidator([&]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        _wispCount = 0;
        _isChanneling = false;

        if (Map* map = me->GetMap())
        {
            map->DoForAllPlayers([&](Player* player)
            {
                player->ApplySpellImmune(SPELL_HAND_OF_DEATH, IMMUNITY_ID, SPELL_HAND_OF_DEATH, false);
                player->ApplySpellImmune(0, IMMUNITY_ID, SPELL_HAND_OF_DEATH, false);
            });
        }

        if (!_isChanneling)
        {
            if (Creature* nordrassil = me->SummonCreature(CREATURE_CHANNEL_TARGET, NordrassilLoc, TEMPSUMMON_TIMED_DESPAWN, 1200000))
            {
                nordrassil->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                nordrassil->SetDisplayId(11686); //TODO: make enum
                DoCast(nordrassil, SPELL_DRAIN_WORLD_TREE);
                _isChanneling = true;
                nordrassil->AI()->DoCast(me, SPELL_DRAIN_WORLD_TREE_2, true);
            }
        }
    }
private:
    uint8 _wispCount;
    bool _isChanneling;
};
class spell_red_sky_effect : public SpellScript
{
    PrepareSpellScript(spell_red_sky_effect);

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit())
            PreventHitDamage();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_red_sky_effect::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class spell_finger_of_death : public SpellScript
{
    PrepareSpellScript(spell_finger_of_death);

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit() && GetHitUnit()->GetAura(SPELL_PROTECTION_OF_ELUNE))
            PreventHitDamage();
        else
            GetHitUnit()->RemoveAurasByType(SPELL_AURA_EFFECT_IMMUNITY);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_finger_of_death::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class spell_hand_of_death : public SpellScript
{
    PrepareSpellScript(spell_hand_of_death);

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit() && GetHitUnit()->GetAura(SPELL_PROTECTION_OF_ELUNE))
            PreventHitDamage();
        else
            GetHitUnit()->RemoveAurasByType(SPELL_AURA_EFFECT_IMMUNITY);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hand_of_death::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};


void AddSC_boss_archimonde()
{
    RegisterSpellScript(spell_red_sky_effect);
    RegisterSpellScript(spell_hand_of_death);
    RegisterSpellScript(spell_finger_of_death);
    RegisterHyjalAI(boss_archimonde);
    RegisterHyjalAI(npc_doomfire);
    RegisterHyjalAI(npc_doomfire_targetting);
    RegisterHyjalAI(npc_ancient_wisp);
}

