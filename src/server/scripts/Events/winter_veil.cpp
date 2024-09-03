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
#include "GameEventMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

///////////////////////////////
// SPELLS
///////////////////////////////

enum Mistletoe
{
    SPELL_CREATE_MISTLETOE          = 26206,
    SPELL_CREATE_HOLLY              = 26207,
    SPELL_CREATE_SNOWFLAKES         = 45036
};

// 26218 - Mistletoe
class spell_winter_veil_mistletoe : public SpellScript
{
    PrepareSpellScript(spell_winter_veil_mistletoe);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_CREATE_MISTLETOE,
                SPELL_CREATE_HOLLY,
                SPELL_CREATE_SNOWFLAKES
            });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            uint32 spellId = RAND(SPELL_CREATE_HOLLY, SPELL_CREATE_MISTLETOE, SPELL_CREATE_SNOWFLAKES);
            GetCaster()->CastSpell(target, spellId, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_winter_veil_mistletoe::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum winterWondervoltTrap
{
    SPELL_WINTER_WONDERVOLT_GREEN_WOMEN     = 26272,
    SPELL_WINTER_WONDERVOLT_GREEN_MAN       = 26157,
    SPELL_WINTER_WONDERVOLT_RED_WOMEN       = 26274,
    SPELL_WINTER_WONDERVOLT_RED_MAN         = 26273,
};

// 26275 - PX-238 Winter Wondervolt TRAP
class spell_winter_wondervolt_trap : public SpellScript
{
    PrepareSpellScript(spell_winter_wondervolt_trap);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            // check presence
            if (target->HasAuraType(SPELL_AURA_TRANSFORM))
                return;

            uint32 spellId = 0;
            if (target->getGender() == GENDER_MALE)
            {
                spellId = target->GetTeamId() == TEAM_ALLIANCE ? SPELL_WINTER_WONDERVOLT_GREEN_MAN : SPELL_WINTER_WONDERVOLT_RED_MAN;
            }
            else
            {
                spellId = target->GetTeamId() == TEAM_ALLIANCE ? SPELL_WINTER_WONDERVOLT_GREEN_WOMEN : SPELL_WINTER_WONDERVOLT_RED_WOMEN;
            }

            // cast
            target->CastSpell(target, spellId, true);
            return;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_winter_wondervolt_trap::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum crashinTrashin
{
    SPELL_BLUE_CAR_VISUAL               = 75110,
    SPELL_RED_CAR_VISUAL                = 49384,
    NPC_RED_RACER                       = 27664,
    NPC_BLUE_RACER                      = 40281,

    SPELL_RACER_DEATH_VISUAL            = 49337,
    SPELL_RACER_CHARGE_TO_OBJECT        = 49302,
    SPELL_RACER_KILL_COUNTER            = 49444,
    SPELL_RACER_SLAM_HIT                = 49324,
    SPELL_RACER_FLAMES                  = 49328,

    RACER_ACHI_CRITERIA                 = 4090,
};

// 49297 - Racer Rocket Slam
class spell_winter_veil_racer_rocket_slam : public SpellScript
{
    PrepareSpellScript(spell_winter_veil_racer_rocket_slam);

    void HandleTriggerSpell(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        PreventHitEffect(EFFECT_0);
        PreventHitEffect(EFFECT_1);

        std::list<Creature*> unitList;
        Unit* target = nullptr;
        caster->GetCreaturesWithEntryInRange(unitList, 30.0f, NPC_BLUE_RACER);
        if (!unitList.empty())
            for (std::list<Creature*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                if (caster->HasInLine((*itr), 1.0f) && (*itr)->GetGUID() != caster->GetGUID())
                {
                    target = (*itr);
                    break;
                }
        if (!target)
        {
            unitList.clear();
            caster->GetCreaturesWithEntryInRange(unitList, 30.0f, NPC_RED_RACER);
            if (!unitList.empty())
                for (std::list<Creature*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                    if (caster->HasInLine((*itr), 1.0f) && (*itr)->GetGUID() != caster->GetGUID())
                    {
                        target = (*itr);
                        break;
                    }
        }

        if (target)
        {
            caster->CastSpell(target, SPELL_RACER_CHARGE_TO_OBJECT, true);
            caster->CastSpell(target, SPELL_RACER_SLAM_HIT, true);
        }
        else
        {
            Position pos;
            float x = caster->GetPositionX() + 30 * cos(caster->GetOrientation());
            float y = caster->GetPositionY() + 30 * std::sin(caster->GetOrientation());
            pos.Relocate(x, y, caster->GetMap()->GetHeight(x, y, MAX_HEIGHT) + 0.5f);
            //caster->GetFirstCollisionPosition(pos, 30.0f, caster->GetOrientation());
            caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_RACER_CHARGE_TO_OBJECT, true);
        }
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_winter_veil_racer_rocket_slam::HandleTriggerSpell, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

// 49325 - Racer Slam, resolve
class spell_winter_veil_racer_slam_hit : public SpellScript
{
    PrepareSpellScript(spell_winter_veil_racer_slam_hit);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Creature* target = GetHitCreature();
        if (!target || caster == target)
            return;

        target->CastSpell(target->GetPositionX() + irand(-10, 10), target->GetPositionY() + irand(-10, 10), target->GetPositionZ(), SPELL_RACER_DEATH_VISUAL, true);
        target->DespawnOrUnsummon(3000);
        target->CastSpell(target, SPELL_RACER_FLAMES, true);
        caster->CastSpell(caster, SPELL_RACER_KILL_COUNTER, true);

        if (Player* targetSummoner = target->GetCharmerOrOwnerPlayerOrPlayerItself())
        {
            //targetSummoner->RemoveCriteriaProgress(sAchievementCriteriaStore.LookupEntry(RACER_ACHI_CRITERIA)); !ZOMG, ADD ACCESSOR
            targetSummoner->RemoveAurasDueToSpell(SPELL_RACER_KILL_COUNTER);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_winter_veil_racer_slam_hit::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum airRifle
{
    SPELL_AIR_RIFLE_RIGHT_IN_THE_EYE        = 65577,
    SPELL_AIR_RIFLE_STARLED                 = 61862,
    SPELL_AIR_RIFLE_HIT                     = 61866,
    SPELL_AIR_RIFLE_HIT_TRIGGER             = 65576,
    SPELL_AIR_RIFLE_PELTED_DAMAGE           = 67531,
};

/* 65576 - Pelted!
   67533 - Shoot Air Rifle */
class spell_winter_veil_shoot_air_rifle : public SpellScript
{
    PrepareSpellScript(spell_winter_veil_shoot_air_rifle);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetOriginalCaster();
        Unit* target = GetHitUnit();
        if (!target)
            return;

        if (GetSpellInfo()->Id == SPELL_AIR_RIFLE_HIT_TRIGGER)
        {
            if (!caster->IsFriendlyTo(target))
                caster->CastSpell(target, SPELL_AIR_RIFLE_PELTED_DAMAGE, true, nullptr, nullptr, caster->GetGUID());
        }
        else
        {
            uint8 rand = urand(0, 99);
            if (rand < 15)
                caster->CastSpell(caster, SPELL_AIR_RIFLE_RIGHT_IN_THE_EYE, true, nullptr, nullptr, caster->GetGUID());
            else if (rand < 35)
                caster->CastSpell(target, SPELL_AIR_RIFLE_STARLED, true, nullptr, nullptr, caster->GetGUID());
            else
                caster->CastSpell(target, SPELL_AIR_RIFLE_HIT, true, nullptr, nullptr, caster->GetGUID());
        }
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_AIR_RIFLE_HIT_TRIGGER)
            OnEffectHitTarget += SpellEffectFn(spell_winter_veil_shoot_air_rifle::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        else
            OnEffectHitTarget += SpellEffectFn(spell_winter_veil_shoot_air_rifle::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_event_winter_veil_scripts()
{
    // Spells
    RegisterSpellScript(spell_winter_veil_mistletoe);
    RegisterSpellScript(spell_winter_wondervolt_trap);
    RegisterSpellScript(spell_winter_veil_racer_rocket_slam);
    RegisterSpellScript(spell_winter_veil_racer_slam_hit);
    RegisterSpellScript(spell_winter_veil_shoot_air_rifle);
}
