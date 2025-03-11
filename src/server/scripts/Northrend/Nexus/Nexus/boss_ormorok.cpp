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
#include "nexus.h"
#include "PassiveAI.h"

enum eEnums
{
    SPELL_CRYSTAL_SPIKES                    = 47958,
    SPELL_CRYSTAL_SPIKE_DAMAGE              = 47944,
    SPELL_CRYSTAL_SPIKE_PREVISUAL           = 50442,
    SPELL_SPELL_REFLECTION                  = 47981,
    SPELL_TRAMPLE                           = 48016,
    SPELL_FRENZY                            = 48017,
    SPELL_SUMMON_CRYSTALLINE_TANGLER        = 61564,
    SPELL_CRYSTAL_CHAINS                    = 47698,
};

enum Yells
{
    SAY_AGGRO                               = 1,
    SAY_DEATH                               = 2,
    SAY_REFLECT                             = 3,
    SAY_CRYSTAL_SPIKES                      = 4,
    SAY_KILL                                = 5,
    EMOTE_FRENZY                            = 6
};

enum Events
{
    EVENT_ORMOROK_CRYSTAL_SPIKES            = 1,
    EVENT_ORMOROK_TRAMPLE                   = 2,
    EVENT_ORMOROK_SPELL_REFLECTION          = 3,
    EVENT_ORMOROK_SUMMON                    = 4,
    EVENT_ORMOROK_HEALTH                    = 5,
    EVENT_ORMOROK_SUMMON_SPIKES             = 6,
    EVENT_KILL_TALK                         = 7
};

enum Misc
{
    NPC_CRYSTAL_SPIKE                       = 27099,
//    NPC_CRYSTALLINE_TANGLER                 = 32665,
    GO_CRYSTAL_SPIKE                        = 188537
};

struct boss_ormorok : public BossAI
{
    boss_ormorok(Creature* creature) : BossAI(creature, DATA_ORMOROK_EVENT) {}

    uint8 _spikesCount;

    void Reset() override
    {
        _spikesCount = 0;
        BossAI::Reset();
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        BossAI::JustEngagedWith(who);

        events.ScheduleEvent(EVENT_ORMOROK_CRYSTAL_SPIKES, 12s);
        events.ScheduleEvent(EVENT_ORMOROK_TRAMPLE, 10s);
        events.ScheduleEvent(EVENT_ORMOROK_SPELL_REFLECTION, 30s);
        events.ScheduleEvent(EVENT_ORMOROK_HEALTH, 1s);
        if (IsHeroic())
            events.ScheduleEvent(EVENT_ORMOROK_SUMMON, 17s);
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
        {
            Talk(SAY_KILL);
            events.ScheduleEvent(EVENT_KILL_TALK, 6s);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
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
        case EVENT_ORMOROK_HEALTH:
            if (me->HealthBelowPct(26))
            {
                me->CastSpell(me, SPELL_FRENZY, true);
                Talk(EMOTE_FRENZY);
                break;
            }
            events.ScheduleEvent(EVENT_ORMOROK_HEALTH, 1s);
            break;
        case EVENT_ORMOROK_TRAMPLE:
            me->CastSpell(me, SPELL_TRAMPLE, false);
            events.ScheduleEvent(EVENT_ORMOROK_TRAMPLE, 10s);
            break;
        case EVENT_ORMOROK_SPELL_REFLECTION:
            Talk(SAY_REFLECT);
            me->CastSpell(me, SPELL_SPELL_REFLECTION, false);
            events.ScheduleEvent(EVENT_ORMOROK_SPELL_REFLECTION, 30s);
            break;
        case EVENT_ORMOROK_SUMMON:
            if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, 50.0f, true))
                me->CastSpell(target, SPELL_SUMMON_CRYSTALLINE_TANGLER, true);
            events.ScheduleEvent(EVENT_ORMOROK_SUMMON, 17s);
            break;
        case EVENT_ORMOROK_CRYSTAL_SPIKES:
            Talk(SAY_CRYSTAL_SPIKES);
            me->CastSpell(me, SPELL_CRYSTAL_SPIKES, false);
            _spikesCount = 0;
            events.ScheduleEvent(EVENT_ORMOROK_SUMMON_SPIKES, 300ms);
            events.ScheduleEvent(EVENT_ORMOROK_CRYSTAL_SPIKES, 20s);
            break;
        case EVENT_ORMOROK_SUMMON_SPIKES:
            if (++_spikesCount > 9)
                break;
            for (uint8 i = 0; i < 4; ++i)
            {
                float o = rand_norm() * 2.0f * M_PI;
                float x = me->GetPositionX() + 5.0f * _spikesCount * cos(o);
                float y = me->GetPositionY() + 5.0f * _spikesCount * std::sin(o);
                float h = me->GetMapHeight(x, y, me->GetPositionZ());

                if (h != INVALID_HEIGHT)
                    me->SummonCreature(NPC_CRYSTAL_SPIKE, x, y, h, 0, TEMPSUMMON_TIMED_DESPAWN, 7000);
            }
            events.ScheduleEvent(EVENT_ORMOROK_SUMMON_SPIKES, 200ms);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

struct npc_crystal_spike : public NullCreatureAI
{
    npc_crystal_spike(Creature* c) : NullCreatureAI(c) { }

    int32 _damageTimer;
    ObjectGuid _gameObjectGUID;

    void Reset() override
    {
        if (GameObject* gameobject = me->SummonGameObject(GO_CRYSTAL_SPIKE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 3500))
            _gameObjectGUID = gameobject->GetGUID();

        _damageTimer = 1;
    }

    void UpdateAI(uint32 diff) override
    {
        if (_damageTimer)
        {
            _damageTimer += diff;
            if (_damageTimer >= 2000)
            {
                if (GameObject* gameobject = ObjectAccessor::GetGameObject(*me, _gameObjectGUID))
                    gameobject->SetGoState(GO_STATE_ACTIVE);

                me->CastSpell(me, SPELL_CRYSTAL_SPIKE_DAMAGE, false);
                _damageTimer = 0;
            }
        }
    }
};

void AddSC_boss_ormorok()
{
    RegisterNexusCreatureAI(boss_ormorok);
    RegisterNexusCreatureAI(npc_crystal_spike);
}
