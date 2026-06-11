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

#include "Group.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum GordunniTrapObjects
{
    GO_GORDUNNI_DIRT_MOUND_CHEST  = 144064,
    GO_GORDUNNI_DIRT_MOUND_JUNK   = 177681,
    GO_GORDUNNI_COBALT_VISUAL     = 177683
};

enum GordunniTrapMisc
{
    MOUND_DESPAWN_TIME = 120 // seconds, matches the summon spell duration (11756/19394)
};

// 19395 - Gordunni Trap, cast by the trap GameObject on the player who disturbs it
class spell_gordunni_trap : public SpellScript
{
    PrepareSpellScript(spell_gordunni_trap);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();

        // spawn the dug up mound at the trap itself, lying flush on the terrain
        WorldObject* anchor = GetGObjCaster();
        if (!anchor)
            anchor = target;

        G3D::Quat rot = anchor->GetTerrainAlignedRotation();

        bool chest = urand(0, 1) != 0;
        // detach the summons from the player so they outlive logout/death and expire on their own timer
        if (GameObject* mound = target->SummonGameObject(chest ? GO_GORDUNNI_DIRT_MOUND_CHEST : GO_GORDUNNI_DIRT_MOUND_JUNK,
            anchor->GetPositionX(), anchor->GetPositionY(), anchor->GetPositionZ(), anchor->GetOrientation(),
            rot.x, rot.y, rot.z, rot.w, MOUND_DESPAWN_TIME))
            target->RemoveGameObject(mound, false);
        if (chest)
            if (GameObject* visual = target->SummonGameObject(GO_GORDUNNI_COBALT_VISUAL,
                anchor->GetPositionX(), anchor->GetPositionY(), anchor->GetPositionZ(), anchor->GetOrientation(),
                rot.x, rot.y, rot.z, rot.w, MOUND_DESPAWN_TIME))
                target->RemoveGameObject(visual, false);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gordunni_trap::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_feralas()
{
    RegisterSpellScript(spell_gordunni_trap);
}
