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
#include "blackrock_spire.h"

enum Spells
{
    SPELL_REND_MOUNTS                 = 16167, // Change model
    SPELL_CORROSIVE_ACID              = 16359, // Combat (self cast)
    SPELL_FLAMEBREATH                 = 16390, // Combat (Self cast)
    SPELL_FREEZE                      = 16350, // Combat (Self cast)
    SPELL_KNOCK_AWAY                  = 10101, // Combat
    SPELL_SUMMON_REND                 = 16328, // Summons Rend near death
    SPELL_CHROMATIC_PROTECTION_FIRE   = 16373,
    SPELL_CHROMATIC_PROTECTION_FROST  = 16392,
    SPELL_CHROMATIC_PROTECTION_NATURE = 16391,
};

enum Misc
{
    NEFARIUS_PATH_2                 = 1379671,
    NEFARIUS_PATH_3                 = 1379672,
    GYTH_PATH_1                     = 1379681,
};

enum Events
{
    EVENT_CORROSIVE_ACID            = 1,
    EVENT_FREEZE                    = 2,
    EVENT_FLAME_BREATH              = 3,
    EVENT_KNOCK_AWAY                = 4,
    EVENT_SUMMONED_1                = 5,
    EVENT_SUMMONED_2                = 6
};

class boss_gyth : public CreatureScript
{
public:
    boss_gyth() : CreatureScript("boss_gyth") { }

    struct boss_gythAI : public BossAI
    {
        boss_gythAI(Creature* creature) : BossAI(creature, DATA_GYTH) { }

        void Reset() override
        {
            _summonedRend = false;
            if (instance->GetBossState(DATA_GYTH) == IN_PROGRESS)
            {
                instance->SetBossState(DATA_GYTH, NOT_STARTED);
                summons.DespawnAll();
                me->DespawnOrUnsummon();
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();

            events.ScheduleEvent(EVENT_CORROSIVE_ACID, 8s, 16s);
            events.ScheduleEvent(EVENT_FREEZE, 8s, 16s);
            events.ScheduleEvent(EVENT_FLAME_BREATH, 8s, 16s);
            events.ScheduleEvent(EVENT_KNOCK_AWAY, 12s, 18s);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, FAIL);
            BossAI::EnterEvadeMode(why);
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            events.ScheduleEvent(EVENT_SUMMONED_1, 1000);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            summon->AI()->AttackStart(me->SelectVictim());
        }

        // Prevent clearing summon list, otherwise Rend despawns if the drake is killed first.
        void JustDied(Unit* /*killer*/) override
        {
            instance->SetBossState(DATA_GYTH, DONE);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
        {
            if (!_summonedRend && me->HealthBelowPctDamaged(25, damage))
            {
                if (damage >= me->GetHealth())
                {
                    // Let creature fall to 1 HP but prevent it from dying before boss is summoned.
                    damage = me->GetHealth() - 1;
                }
                DoCast(me, SPELL_SUMMON_REND, true);
                me->RemoveAura(SPELL_REND_MOUNTS);
                _summonedRend = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SUMMONED_1:
                            me->AddAura(SPELL_REND_MOUNTS, me);
                            if (GameObject* portcullis = me->FindNearestGameObject(GO_DR_PORTCULLIS, 40.0f))
                                portcullis->UseDoorOrButton();
                            events.ScheduleEvent(EVENT_SUMMONED_2, 2s);
                            break;
                        case EVENT_SUMMONED_2:
                            me->GetMotionMaster()->MovePath(GYTH_PATH_1, false);
                            break;
                        default:
                            break;
                    }
                }
                return;
            }

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CORROSIVE_ACID:
                        DoCast(me, SPELL_CORROSIVE_ACID);
                        events.ScheduleEvent(EVENT_CORROSIVE_ACID, 10s, 16s);
                        break;
                    case EVENT_FREEZE:
                        DoCast(me, SPELL_FREEZE);
                        events.ScheduleEvent(EVENT_FREEZE, 10s, 16s);
                        break;
                    case EVENT_FLAME_BREATH:
                        DoCast(me, SPELL_FLAMEBREATH);
                        events.ScheduleEvent(EVENT_FLAME_BREATH, 10s, 16s);
                        break;
                    case EVENT_KNOCK_AWAY:
                        DoCastVictim(SPELL_KNOCK_AWAY);
                        events.ScheduleEvent(EVENT_KNOCK_AWAY, 14s, 20s);
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

        private:
            bool _summonedRend;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_gythAI>(creature);
    }
};

// 16372 - Chromatic Protection
class spell_gyth_chromatic_protection : public AuraScript
{
    PrepareAuraScript(spell_gyth_chromatic_protection);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CORROSIVE_ACID, SPELL_FLAMEBREATH, SPELL_FREEZE });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (SpellInfo const* spellInfo = eventInfo.GetSpellInfo())
        {
            switch (spellInfo->Id)
            {
                case SPELL_CORROSIVE_ACID:
                case SPELL_FLAMEBREATH:
                case SPELL_FREEZE:
                    return true;
                    break;
                default:
                    break;
            }
        }
        return false;
    }

    void HandleProc(AuraEffect const* /* aurEff */, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (SpellInfo const* spellInfo = eventInfo.GetSpellInfo())
        {
            switch (spellInfo->Id)
            {
                case SPELL_CORROSIVE_ACID:
                    GetTarget()->CastSpell(GetTarget(), SPELL_CHROMATIC_PROTECTION_NATURE, true);
                    break;
                case SPELL_FLAMEBREATH:
                    GetTarget()->CastSpell(GetTarget(), SPELL_CHROMATIC_PROTECTION_FIRE, true);
                    break;
                case SPELL_FREEZE:
                    GetTarget()->CastSpell(GetTarget(), SPELL_CHROMATIC_PROTECTION_FROST, true);
                    break;
                default:
                    break;
            }
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_gyth_chromatic_protection::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

void AddSC_boss_gyth()
{
    new boss_gyth();
    RegisterSpellScript(spell_gyth_chromatic_protection);
}
