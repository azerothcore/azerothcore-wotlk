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
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "temple_of_ahnqiraj.h"

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_SLAY                    = 1,
    SAY_SPLIT                   = 2,
    SAY_DEATH                   = 3
};

enum Spells
{
    SPELL_ARCANE_EXPLOSION      = 26192,
    SPELL_EARTH_SHOCK           = 26194,
    SPELL_TRUE_FULFILLMENT      = 785,
    SPELL_INITIALIZE_IMAGE      = 3730,
    SPELL_SUMMON_IMAGES         = 747,
    SPELL_BIRTH                 = 34115
};

enum Events
{
    EVENT_ARCANE_EXPLOSION      = 1,
    EVENT_FULLFILMENT           = 2,
    EVENT_BLINK                 = 3,
    EVENT_EARTH_SHOCK           = 4,
    EVENT_TELEPORT              = 5,
    EVENT_INIT_IMAGE            = 6
};

uint32 const BlinkSpells[3] = { 4801, 8195, 20449 };

struct boss_skeram : public BossAI
{
    boss_skeram(Creature* creature) : BossAI(creature, DATA_SKERAM) { }

    void Reset() override
    {
        _Reset();
        _flag = 0;
        _hpct = 75.0f;
        me->SetReactState(REACT_AGGRESSIVE);
        me->SetImmuneToAll(false);
        me->SetControlled(false, UNIT_STATE_ROOT);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        ScriptedAI::EnterEvadeMode(why);
        if (me->IsSummon())
            ((TempSummon*)me)->UnSummon();
    }

    void JustSummoned(Creature* creature) override
    {
        BossAI::JustSummoned(creature);

        float ImageHealthPct = 0.f;
        if (me->GetHealthPct() < 25.0f)
            ImageHealthPct = 0.50f;
        else if (me->GetHealthPct() < 50.0f)
            ImageHealthPct = 0.20f;
        else
            ImageHealthPct = 0.10f;

        creature->SetMaxHealth(me->GetMaxHealth() * ImageHealthPct);
        creature->SetHealth(creature->GetMaxHealth() * (me->GetHealthPct() / 100.0f));

        creature->CastSpell(creature, SPELL_BIRTH, true);
        creature->SetControlled(true, UNIT_STATE_ROOT);
        creature->SetReactState(REACT_PASSIVE);
        creature->SetImmuneToAll(true);

        _copiesGUIDs.push_back(creature->GetGUID());
    }

    void DoTeleport(Creature* creature)
    {
        // Shift the boss and images (Get it? *Shift*?)
        uint8 rand = 0;
        if (_flag != 0)
        {
            while (_flag & (1 << rand))
                rand = urand(0, 2);
            DoCast(me, BlinkSpells[rand]);
            _flag |= (1 << rand);
            _flag |= (1 << 7);
        }

        while (_flag & (1 << rand))
            rand = urand(0, 2);

        creature->SetReactState(REACT_AGGRESSIVE);
        creature->SetImmuneToAll(false);
        creature->SetControlled(false, UNIT_STATE_ROOT);
        creature->CastSpell(creature, BlinkSpells[rand], true);

        _flag |= (1 << rand);

        if (_flag & (1 << 7))
            _flag = 0;

        events.ScheduleEvent(EVENT_INIT_IMAGE, 400ms);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (!me->IsSummon())
        {
            _JustDied();
            Talk(SAY_DEATH);
            if (me->GetMap() && me->GetMap()->ToInstanceMap())
                me->GetMap()->ToInstanceMap()->PermBindAllPlayers();
        }
        else
            me->RemoveCorpse();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        events.Reset();

        events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, 6s, 12s);
        events.ScheduleEvent(EVENT_FULLFILMENT, 15s);
        events.ScheduleEvent(EVENT_BLINK, 30s, 45s);
        events.ScheduleEvent(EVENT_EARTH_SHOCK, 1200ms);

        if (!me->IsSummon())
        {
            Talk(SAY_AGGRO);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ARCANE_EXPLOSION:
                    DoCastAOE(SPELL_ARCANE_EXPLOSION, false);
                    events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, 8s, 18s);
                    break;
                case EVENT_FULLFILMENT:
                    DoCast(SelectTarget(SelectTargetMethod::MinDistance, 1, 0.0f, true), SPELL_TRUE_FULFILLMENT, false);
                    events.ScheduleEvent(EVENT_FULLFILMENT, 20s, 30s);
                    break;
                case EVENT_BLINK:
                    DoCast(me, BlinkSpells[urand(0, 2)]);
                    DoResetThreatList();
                    events.ScheduleEvent(EVENT_BLINK, 10s, 30s);
                    break;
                case EVENT_EARTH_SHOCK:
                    DoCastVictim(SPELL_EARTH_SHOCK);
                    events.ScheduleEvent(EVENT_EARTH_SHOCK, 1200ms);
                    break;
                case EVENT_TELEPORT:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetImmuneToAll(false);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    for (ObjectGuid const& guid : _copiesGUIDs)
                    {
                        if (Creature* image = ObjectAccessor::GetCreature(*me, guid))
                        {
                            DoTeleport(image);
                        }
                    }
                    DoResetThreatList();
                    events.RescheduleEvent(EVENT_BLINK, 10s, 30s);
                    break;
                case EVENT_INIT_IMAGE:
                    me->CastSpell(me, SPELL_INITIALIZE_IMAGE, true);
                    break;
            }
        }

        if (!me->IsSummon() && me->GetHealthPct() < _hpct)
        {
            _copiesGUIDs.clear();
            DoCast(me, SPELL_SUMMON_IMAGES, true);
            me->SetReactState(REACT_PASSIVE);
            me->SetImmuneToAll(true);
            me->SetControlled(true, UNIT_STATE_ROOT);
            Talk(SAY_SPLIT);
            _hpct -= 25.0f;
            events.ScheduleEvent(EVENT_TELEPORT, 2s);
        }

        if (Unit* myVictim = me->GetVictim())
        {
            if (me->IsWithinMeleeRange(myVictim))
            {
                DoMeleeAttackIfReady();

                if (Unit* victimTarget = myVictim->GetVictim())
                {
                    if (victimTarget->GetGUID() == me->GetGUID())
                    {
                        events.RescheduleEvent(EVENT_EARTH_SHOCK, 1200ms);
                    }
                }
            }
        }
    }

private:
    float _hpct;
    uint8 _flag;
    GuidVector _copiesGUIDs;
};

class spell_skeram_arcane_explosion : public SpellScript
{
    PrepareSpellScript(spell_skeram_arcane_explosion);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(PlayerOrPetCheck());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_skeram_arcane_explosion::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_skeram()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_skeram);
    RegisterSpellScript(spell_skeram_arcane_explosion);
}
