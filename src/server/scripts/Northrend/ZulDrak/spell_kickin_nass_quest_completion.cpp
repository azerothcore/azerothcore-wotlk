/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright
 * information
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

#include "AreaDefines.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "Chat.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "Pet.h"
#include "ReputationMgr.h"
#include "SkillDiscovery.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Unit.h"
#include "Vehicle.h"
#include <array>
#include <cmath>

// 51910 - Kickin' Nass: Quest Completion
class spell_kickin_nass_quest_completion : public SpellScript {
  PrepareSpellScript(spell_kickin_nass_quest_completion);

  bool Load() override {
    Unit *caster = GetCaster();
    if (caster && caster->IsPlayer())
      return true;

    return false;
  }

  void DespawnNass(SpellEffIndex effIndex) {
    uint32 effect = GetSpellInfo()->Effects[effIndex].Effect;
    if (effect != SPELL_EFFECT_DUMMY && effect != SPELL_EFFECT_SCRIPT_EFFECT)
      return;

    Unit *caster = GetCaster();
    Creature *creature = GetHitCreature();
    if (!caster || !creature)
      return;

    if (creature->GetEntry() != 28521 ||
        creature->GetCharmerOrOwnerGUID() != caster->GetGUID())
      return;

    creature->DespawnOrUnsummon(1ms);
  }

  void Register() override {
    OnEffectHitTarget +=
        SpellEffectFn(spell_kickin_nass_quest_completion::DespawnNass,
                      EFFECT_ALL, SPELL_EFFECT_SCRIPT_EFFECT);
  }
};

void AddSC_spell_kickin_nass_quest_completion() {
  RegisterSpellScript(spell_kickin_nass_quest_completion);
}