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

#include "CreatureScript.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum ZombieInfestationSpells
{
    SPELL_INFECT                = 48953,
    SPELL_YOURE_INFECTED        = 43958,
    SPELL_YOURE_A_ZOMBIE        = 43869,
};

enum ZombieInfestationTimers
{
    INFECTION_DURATION_MS        = 60 * IN_MILLISECONDS,
};

enum ZombieInfestationFactions
{
    FACTION_ZOMBIE              = 1945,
};

enum ZombieInfestationHealerSpells
{
    SPELL_CURE_DISEASE          = 528,
};

// 48953 - Infect!
// Script effect cast by Conspicuous Crates and plague sources.
// Applies the infection aura to living, non-zombie players.
class spell_zombie_infestation_infect : public SpellScript
{
    PrepareSpellScript(spell_zombie_infestation_infect);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_YOURE_INFECTED });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        if (!target || !target->IsPlayer())
            return;

        if (!target->IsAlive())
            return;

        if (target->HasAura(SPELL_YOURE_A_ZOMBIE) || target->HasAura(SPELL_YOURE_INFECTED))
            return;

        target->CastSpell(target, SPELL_YOURE_INFECTED, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_zombie_infestation_infect::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 43958 - You're Infected!
// DBC has no duration; OnApply sets a scripted countdown.
// Natural expiry transforms the player into a zombie.
// Dispel or manual removal does not transform.
class spell_zombie_infestation_infected : public AuraScript
{
    PrepareAuraScript(spell_zombie_infestation_infected);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_YOURE_A_ZOMBIE });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Aura* aura = GetAura())
        {
            aura->SetMaxDuration(INFECTION_DURATION_MS);
            aura->SetDuration(INFECTION_DURATION_MS);
        }
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        Unit* target = GetTarget();
        if (!target || !target->IsPlayer())
            return;

        if (!target->IsAlive())
            return;

        target->CastSpell(target, SPELL_YOURE_A_ZOMBIE, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_zombie_infestation_infected::OnApply, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_zombie_infestation_infected::AfterRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
    }
};

// 43869 - You're a Zombie!
// On apply: set zombie faction so the player becomes hostile to living players/NPCs.
// On remove: restore original faction.
class spell_zombie_infestation_zombie : public AuraScript
{
    PrepareAuraScript(spell_zombie_infestation_zombie);

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (!target || !target->IsPlayer())
            return;

        target->SetFaction(FACTION_ZOMBIE);
        target->SetUnitFlag2(UNIT_FLAG2_IGNORE_REPUTATION);
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (!target || !target->IsPlayer())
            return;

        target->RestoreFaction();
        target->RemoveUnitFlag2(UNIT_FLAG2_IGNORE_REPUTATION);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_zombie_infestation_zombie::AfterApply, EFFECT_1, SPELL_AURA_MOD_SHAPESHIFT, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_zombie_infestation_zombie::AfterRemove, EFFECT_1, SPELL_AURA_MOD_SHAPESHIFT, AURA_EFFECT_HANDLE_REAL);
    }
};

// 27305 - Argent Healer
// Scans for nearby infected or zombie players and cures them.
struct npc_argent_healer_zombie : public ScriptedAI
{
    npc_argent_healer_zombie(Creature* creature) : ScriptedAI(creature) { }

    static constexpr float SCAN_RANGE = 30.0f;
    static constexpr float CURE_RANGE = 6.0f;

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        me->SetReactState(REACT_PASSIVE);
        ScheduleScan();
    }

    void ScheduleScan()
    {
        scheduler.Schedule(2s, 4s, [this](TaskContext context)
        {
            ScanForTargets();
            context.Repeat(3s, 5s);
        });
    }

    void ScanForTargets()
    {
        Player* nearestInfected = nullptr;
        Player* nearestZombie = nullptr;
        float bestInfectedDist = SCAN_RANGE;
        float bestZombieDist = SCAN_RANGE;

        auto const& players = me->GetMap()->GetPlayers();
        for (auto const& ref : players)
        {
            Player* player = ref.GetSource();
            if (!player || !player->IsAlive() || player->IsGameMaster())
                continue;

            float dist = me->GetDistance(player);
            if (dist > SCAN_RANGE)
                continue;

            if (player->HasAura(SPELL_YOURE_A_ZOMBIE))
            {
                if (dist < bestZombieDist)
                {
                    bestZombieDist = dist;
                    nearestZombie = player;
                }
            }
            else if (player->HasAura(SPELL_YOURE_INFECTED))
            {
                if (dist < bestInfectedDist)
                {
                    bestInfectedDist = dist;
                    nearestInfected = player;
                }
            }
        }

        if (nearestInfected && bestInfectedDist <= CURE_RANGE)
        {
            me->SetFacingToObject(nearestInfected);
            me->CastSpell(nearestInfected, SPELL_CURE_DISEASE, false);
        }
        else if (nearestZombie && bestZombieDist <= CURE_RANGE)
        {
            me->SetFacingToObject(nearestZombie);
            nearestZombie->RemoveAurasDueToSpell(SPELL_YOURE_A_ZOMBIE);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    TaskScheduler scheduler;
};

// Safety net: clean up zombie state on login and logout.
// Handles edge cases where the player logs out or the server crashes while in zombie form.
class zombie_infestation_player_scripts : public PlayerScript
{
public:
    zombie_infestation_player_scripts() : PlayerScript("zombie_infestation_player_scripts",
        {PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_LOGOUT, PLAYERHOOK_ON_PLAYER_JUST_DIED})
    {
    }

    void OnPlayerLogin(Player* player) override
    {
        CleanupZombieState(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        CleanupZombieState(player);
    }

    void OnPlayerJustDied(Player* player) override
    {
        CleanupZombieState(player);
    }

private:
    static void CleanupZombieState(Player* player)
    {
        if (!player)
            return;

        bool hadZombieAura = player->HasAura(SPELL_YOURE_A_ZOMBIE);

        player->RemoveAurasDueToSpell(SPELL_YOURE_INFECTED);
        player->RemoveAurasDueToSpell(SPELL_YOURE_A_ZOMBIE);

        if (hadZombieAura)
        {
            player->RestoreFaction();
            player->RemoveUnitFlag2(UNIT_FLAG2_IGNORE_REPUTATION);
        }
    }
};

void AddSC_zombie_infestation()
{
    RegisterSpellScript(spell_zombie_infestation_infect);
    RegisterSpellScript(spell_zombie_infestation_infected);
    RegisterSpellScript(spell_zombie_infestation_zombie);
    RegisterCreatureAI(npc_argent_healer_zombie);
    new zombie_infestation_player_scripts();
}
