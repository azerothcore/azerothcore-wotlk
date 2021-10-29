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

#include "ScriptMgr.h"
#include "Containers.h"
#include "ObjectAccessor.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "molten_core.h"

enum Texts
{
    EMOTE_MASS_ERRUPTION                = 0,
};

enum Spells
{
    // Garr
    SPELL_ANTIMAGIC_PULSE               = 19492,
    SPELL_MAGMA_SHACKLES                = 19496,
    SPELL_ENRAGE                        = 19516,
    SPELL_SEPARATION_ANXIETY            = 23487,    // Aura cast on himself by Garr, if adds move out of range, they will cast spell 23492 on themselves (server side)

    // Fireworn
    SPELL_SEPARATION_ANXIETY_MINION     = 23492,
    SPELL_ERUPTION                      = 19497,
    SPELL_MASSIVE_ERUPTION              = 20483,
    SPELL_ERUPTION_TRIGGER              = 20482,    // Removes banish auras and applied immunity to banish
};

enum Events
{
    EVENT_ANTIMAGIC_PULSE               = 1,
    EVENT_MAGMA_SHACKLES,
};

class boss_garr : public CreatureScript
{
public:
    boss_garr() : CreatureScript("boss_garr") {}

    struct boss_garrAI : public BossAI
    {
        boss_garrAI(Creature* creature) : BossAI(creature, DATA_GARR),
            massEruptionTimer(600000)
        {
        }

        void Reset() override
        {
            _Reset();
            massEruptionTimer = 600000;
        }

        void EnterCombat(Unit* /*attacker*/) override
        {
            _EnterCombat();
            DoCastSelf(SPELL_SEPARATION_ANXIETY, true);
            events.ScheduleEvent(EVENT_ANTIMAGIC_PULSE, 15000);
            events.ScheduleEvent(EVENT_MAGMA_SHACKLES, 10000);
            massEruptionTimer = 600000; // 10 mins
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (massEruptionTimer <= diff)
            {
                Talk(EMOTE_MASS_ERRUPTION, me);
                DoCastAOE(SPELL_ERUPTION_TRIGGER, true);
                massEruptionTimer = 20000;
            }
            else
            {
                massEruptionTimer -= diff;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ANTIMAGIC_PULSE:
                    {
                        DoCastSelf(SPELL_ANTIMAGIC_PULSE);
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_MAGMA_SHACKLES:
                    {
                        DoCastSelf(SPELL_MAGMA_SHACKLES);
                        events.RepeatEvent(15000);
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint32 massEruptionTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_garrAI>(creature);
    }
};

// 23487 Separation Anxiety (server side)
class spell_garr_separation_nexiety : public SpellScriptLoader
{
public:
    spell_garr_separation_nexiety() : SpellScriptLoader("spell_garr_separation_nexiety") {}

    class spell_garr_separation_nexiety_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_garr_separation_nexiety_AuraScript);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo({ SPELL_SEPARATION_ANXIETY_MINION });
        }

        void HandleAuraRemoval(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            AuraRemoveMode const removeMode = GetTargetApplication()->GetRemoveMode();
            if (removeMode == AURA_REMOVE_BY_DEATH || removeMode == AURA_REMOVE_BY_DEFAULT)
            {
                return;
            }

            if (Unit* target = GetTarget())
            {
                target->CastSpell(target, SPELL_SEPARATION_ANXIETY_MINION);
            }
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_garr_separation_nexiety_AuraScript::HandleAuraRemoval, EFFECT_0, SPELL_AURA_DUMMY, AuraEffectHandleModes::AURA_EFFECT_HANDLE_REAL);
        }
    };

    // Should return a fully valid AuraScript pointer.
    AuraScript* GetAuraScript() const override
    {
        return new spell_garr_separation_nexiety_AuraScript();
    }
};

void AddSC_boss_garr()
{
    new boss_garr();

    // Spells
    new spell_garr_separation_nexiety();
}
