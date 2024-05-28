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
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "hyjal.h"

enum Spells
{
    SPELL_RAIN_OF_FIRE          = 31340,
    SPELL_DOOM                  = 31347,
    SPELL_HOWL_OF_AZGALOR       = 31344,
    SPELL_CLEAVE                = 31345,
    SPELL_BERSERK               = 26662
};

enum Texts
{
    SAY_ONDEATH             = 0,
    SAY_ONSLAY              = 1,
    SAY_DOOM                = 2, // Not used?
    SAY_ONSPAWN             = 3,

    SAY_ARCHIMONDE_INTRO    = 8
};

struct boss_azgalor : public BossAI
{
public:
    boss_azgalor(Creature* creature) : BossAI(creature, DATA_AZGALOR)
    {
        _recentlySpoken = false;
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void JustEngagedWith(Unit * who) override
    {
        BossAI::JustEngagedWith(who);

        scheduler.Schedule(10s, 16s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(8s, 16s);
        }).Schedule(25s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_RAIN_OF_FIRE, 0, 40.f, false);
            context.Repeat(15s);
        }).Schedule(30s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_HOWL_OF_AZGALOR);
            context.Repeat(18s, 20s);
        }).Schedule(45s, 55s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_DOOM, 1, 100.f, true, false, false);
            Talk(SAY_DOOM);
            context.Repeat();
        }).Schedule(10min, [this](TaskContext context)
        {
            DoCastSelf(SPELL_BERSERK);
            context.Repeat(5min);
        });
    }

    void DoAction(int32 action) override
    {
        Talk(SAY_ONSPAWN, 1200ms);

        if (action == DATA_AZGALOR)
            me->GetMotionMaster()->MovePath(HORDE_BOSS_PATH, false);
    }

    void KilledUnit(Unit * victim) override
    {
        if (!_recentlySpoken && victim->IsPlayer())
        {
            Talk(SAY_ONSLAY);
            _recentlySpoken = true;

            scheduler.Schedule(6s, [this](TaskContext)
            {
                _recentlySpoken = false;
            });
        }
    }

    void JustDied(Unit * killer) override
    {
        Talk(SAY_ONDEATH);
        // If Archimonde has not yet been initialized, this won't trigger
        if (Creature* archi = instance->GetCreature(DATA_ARCHIMONDE))
        {
            archi->AI()->DoAction(ACTION_BECOME_ACTIVE_AND_CHANNEL);
            archi->AI()->Talk(SAY_ARCHIMONDE_INTRO, 25000ms);
        }
        BossAI::JustDied(killer);
    }

private:
    bool _recentlySpoken;

};

class spell_azgalor_doom : public AuraScript
{
    PrepareAuraScript(spell_azgalor_doom);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH && !IsExpired())
        {
            target->CastSpell(target, GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true);
        }
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_azgalor_doom::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_azgalor()
{
    RegisterHyjalAI(boss_azgalor);
    RegisterSpellScript(spell_azgalor_doom);
}
