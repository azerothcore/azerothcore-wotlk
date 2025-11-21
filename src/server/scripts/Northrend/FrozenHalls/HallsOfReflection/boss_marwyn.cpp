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
#include "SpellScriptLoader.h"
#include "halls_of_reflection.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Yells
{
    SAY_AGGRO                                     = 0,
    SAY_SLAY                                      = 1,
    SAY_DEATH                                     = 2,
    SAY_CORRUPTED_FLESH                           = 3,
    SAY_CORRUPTED_WELL                            = 4,
};

enum Spells
{
    SPELL_OBLITERATE                              = 72360,
    SPELL_WELL_OF_CORRUPTION                      = 72362,
    SPELL_CORRUPTED_FLESH                         = 72363,
    SPELL_SHARED_SUFFERING                        = 72368,
};

enum Events
{
    EVENT_NONE,
    EVENT_OBLITERATE,
    EVENT_WELL_OF_CORRUPTION,
    EVENT_CORRUPTED_FLESH,
    EVENT_SHARED_SUFFERING,
};

class boss_marwyn : public CreatureScript
{
public:
    boss_marwyn() : CreatureScript("boss_marwyn") { }

    struct boss_marwynAI : public ScriptedAI
    {
        boss_marwynAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint16 startFightTimer;

        void Reset() override
        {
            startFightTimer = 0;
            me->SetImmuneToAll(true);
            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_MARWYN, NOT_STARTED);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->SetImmuneToAll(false);

            events.ScheduleEvent(EVENT_OBLITERATE, 15s);
            events.ScheduleEvent(EVENT_WELL_OF_CORRUPTION, 13s);
            events.ScheduleEvent(EVENT_CORRUPTED_FLESH, 20s);
            events.ScheduleEvent(EVENT_SHARED_SUFFERING, 5s);
        }

        void DoAction(int32 a) override
        {
            if (a == 1)
            {
                Talk(SAY_AGGRO);
                startFightTimer = 8000;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (startFightTimer)
            {
                if (startFightTimer <= diff)
                {
                    startFightTimer = 0;
                    me->SetInCombatWithZone();
                }
                else
                    startFightTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_OBLITERATE:
                    if (me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_OBLITERATE, false);
                        events.ScheduleEvent(EVENT_OBLITERATE, 15s);
                    }
                    else
                        events.ScheduleEvent(EVENT_OBLITERATE, 3s);
                    break;
                case EVENT_WELL_OF_CORRUPTION:
                    Talk(SAY_CORRUPTED_WELL);
                    if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                        me->CastSpell(target, SPELL_WELL_OF_CORRUPTION, false);
                    events.ScheduleEvent(EVENT_WELL_OF_CORRUPTION, 13s);
                    break;
                case EVENT_CORRUPTED_FLESH:
                    Talk(SAY_CORRUPTED_FLESH);
                    me->CastSpell((Unit*)nullptr, SPELL_CORRUPTED_FLESH, false);
                    events.ScheduleEvent(EVENT_CORRUPTED_FLESH, 20s);
                    break;
                case EVENT_SHARED_SUFFERING:
                    if (Unit* target = SelectTargetFromPlayerList(200.0f, 0, true))
                        me->CastSpell(target, SPELL_SHARED_SUFFERING, true);
                    events.ScheduleEvent(EVENT_SHARED_SUFFERING, 15s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_MARWYN, DONE);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                Talk(SAY_SLAY);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);
            if (startFightTimer)
                Reset();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHallsOfReflectionAI<boss_marwynAI>(creature);
    }
};

enum SharedSufferingAura
{
    SPELL_SHARED_SUFFERING_DAMAGE = 72373
};

class spell_hor_shared_suffering_aura : public AuraScript
{
    PrepareAuraScript(spell_hor_shared_suffering_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHARED_SUFFERING_DAMAGE });
    }

    void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes  /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_ENEMY_SPELL) // dispelled
            if (Unit* caster = GetCaster())
                if (Map* map = caster->FindMap())
                    if (Aura* a = aurEff->GetBase())
                    {
                        uint32 count = 0;
                        uint32 ticks = 0;
                        uint32 dmgPerTick = a->GetSpellInfo()->Effects[0].BasePoints;
                        Map::PlayerList const& pl = map->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            if (Player* p = itr->GetSource())
                                if (p->IsAlive())
                                    ++count;
                        ticks = (a->GetDuration() / int32(a->GetSpellInfo()->Effects[0].Amplitude)) + 1;
                        int32 dmg = (ticks * dmgPerTick) / count;
                        caster->CastCustomSpell(GetTarget(), SPELL_SHARED_SUFFERING_DAMAGE, nullptr, &dmg, nullptr, true);
                    }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_hor_shared_suffering_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_marwyn()
{
    new boss_marwyn();
    RegisterSpellScript(spell_hor_shared_suffering_aura);
}
