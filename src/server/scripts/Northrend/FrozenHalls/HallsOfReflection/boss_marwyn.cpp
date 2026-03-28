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
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "halls_of_reflection.h"

enum Yells
{
    SAY_AGGRO          = 0,
    SAY_SLAY           = 1,
    SAY_DEATH          = 2,
    SAY_CORRUPTED_FLESH = 3,
    SAY_CORRUPTED_WELL = 4,
};

enum Spells
{
    SPELL_OBLITERATE         = 72360,
    SPELL_WELL_OF_CORRUPTION = 72362,
    SPELL_CORRUPTED_FLESH    = 72363,
    SPELL_SHARED_SUFFERING   = 72368,
};

enum Events
{
    EVENT_OBLITERATE = 1,
    EVENT_WELL_OF_CORRUPTION,
    EVENT_CORRUPTED_FLESH,
    EVENT_SHARED_SUFFERING,
};

struct boss_marwyn : public BossAI
{
    boss_marwyn(Creature* creature) : BossAI(creature, DATA_MARWYN) { }

    void Reset() override
    {
        BossAI::Reset();
        _startingFight = false;
        me->SetImmuneToAll(true);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        me->SetImmuneToAll(false);

        events.ScheduleEvent(EVENT_OBLITERATE, 15s);
        events.ScheduleEvent(EVENT_WELL_OF_CORRUPTION, 13s);
        events.ScheduleEvent(EVENT_CORRUPTED_FLESH, 20s);
        events.ScheduleEvent(EVENT_SHARED_SUFFERING, 5s);
    }

    void DoAction(int32 action) override
    {
        if (action == 1)
        {
            Talk(SAY_AGGRO);
            _startingFight = true;
            me->m_Events.AddEventAtOffset([this]()
            {
                _startingFight = false;
                me->SetInCombatWithZone();
            }, 8s);
        }
    }

    void UpdateAI(uint32 diff) override
    {
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
                    DoCastVictim(SPELL_OBLITERATE);
                    events.Repeat(15s);
                }
                else
                    events.Repeat(3s);
                break;
            case EVENT_WELL_OF_CORRUPTION:
                Talk(SAY_CORRUPTED_WELL);
                if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                    DoCast(target, SPELL_WELL_OF_CORRUPTION);
                events.Repeat(13s);
                break;
            case EVENT_CORRUPTED_FLESH:
                Talk(SAY_CORRUPTED_FLESH);
                DoCastAOE(SPELL_CORRUPTED_FLESH);
                events.Repeat(20s);
                break;
            case EVENT_SHARED_SUFFERING:
                if (Unit* target = SelectTargetFromPlayerList(200.0f, 0, true))
                    DoCast(target, SPELL_SHARED_SUFFERING, true);
                events.Repeat(15s);
                break;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
            Talk(SAY_SLAY);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        BossAI::EnterEvadeMode(why);
        if (_startingFight)
            Reset();
    }

private:
    bool _startingFight{};
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

    void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_ENEMY_SPELL)
            return;

        Unit* caster = GetCaster();
        if (!caster)
            return;

        Map* map = caster->FindMap();
        if (!map)
            return;

        Aura* aura = aurEff->GetBase();
        if (!aura)
            return;

        uint32 count = 0;
        uint32 dmgPerTick = aura->GetSpellInfo()->Effects[0].BasePoints;
        Map::PlayerList const& pl = map->GetPlayers();
        for (auto itr = pl.begin(); itr != pl.end(); ++itr)
            if (Player* p = itr->GetSource())
                if (p->IsAlive())
                    ++count;

        if (!count)
            return;

        uint32 ticks = (aura->GetDuration() / int32(aura->GetSpellInfo()->Effects[0].Amplitude)) + 1;
        int32 dmg = (ticks * dmgPerTick) / count;
        caster->CastCustomSpell(GetTarget(), SPELL_SHARED_SUFFERING_DAMAGE, nullptr, &dmg, nullptr, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_hor_shared_suffering_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_marwyn()
{
    RegisterHallsOfReflectionCreatureAI(boss_marwyn);
    RegisterSpellScript(spell_hor_shared_suffering_aura);
}
