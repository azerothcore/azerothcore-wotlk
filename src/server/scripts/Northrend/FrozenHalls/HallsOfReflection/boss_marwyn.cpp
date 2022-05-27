/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "halls_of_reflection.h"

enum Yells
{
    SAY_AGGRO                                     = 60,
    SAY_SLAY_1                                    = 61,
    SAY_SLAY_2                                    = 62,
    SAY_DEATH                                     = 63,
    SAY_CORRUPTED_FLESH_1                         = 64,
    SAY_CORRUPTED_FLESH_2                         = 65,
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
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_MARWYN, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);

            events.ScheduleEvent(EVENT_OBLITERATE, 15000);
            events.ScheduleEvent(EVENT_WELL_OF_CORRUPTION, 13000);
            events.ScheduleEvent(EVENT_CORRUPTED_FLESH, 20000);
            events.ScheduleEvent(EVENT_SHARED_SUFFERING, 5000);
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
                        events.ScheduleEvent(EVENT_OBLITERATE, 15000);
                    }
                    else
                        events.ScheduleEvent(EVENT_OBLITERATE, 3000);
                    break;
                case EVENT_WELL_OF_CORRUPTION:
                    if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                        me->CastSpell(target, SPELL_WELL_OF_CORRUPTION, false);
                    events.ScheduleEvent(EVENT_WELL_OF_CORRUPTION, 13000);
                    break;
                case EVENT_CORRUPTED_FLESH:
                    Talk(RAND(SAY_CORRUPTED_FLESH_1, SAY_CORRUPTED_FLESH_2));
                    me->CastSpell((Unit*)nullptr, SPELL_CORRUPTED_FLESH, false);
                    events.ScheduleEvent(EVENT_CORRUPTED_FLESH, 20000);
                    break;
                case EVENT_SHARED_SUFFERING:
                    if (Unit* target = SelectTargetFromPlayerList(200.0f, 0, true))
                        me->CastSpell(target, SPELL_SHARED_SUFFERING, true);
                    events.ScheduleEvent(EVENT_SHARED_SUFFERING, 15000);
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
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(RAND(SAY_SLAY_1, SAY_SLAY_2));
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

class spell_hor_shared_suffering : public SpellScriptLoader
{
public:
    spell_hor_shared_suffering() : SpellScriptLoader("spell_hor_shared_suffering") { }

    class spell_hor_shared_sufferingAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hor_shared_sufferingAuraScript);

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
                            caster->CastCustomSpell(GetTarget(), 72373, nullptr, &dmg, nullptr, true);
                        }
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_hor_shared_sufferingAuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_hor_shared_sufferingAuraScript();
    }
};

void AddSC_boss_marwyn()
{
    new boss_marwyn();
    new spell_hor_shared_suffering();
}
