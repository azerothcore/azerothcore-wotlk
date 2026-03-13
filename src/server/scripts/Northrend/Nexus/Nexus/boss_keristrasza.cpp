
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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "MapReference.h"
#include "ScriptedCreature.h"
#include "nexus.h"
#include "Player.h"

enum eEnums
{
    SPELL_FROZEN_PRISON             = 47854,
    SPELL_TAIL_SWEEP                = 50155,
    SPELL_CRYSTAL_CHAINS            = 50997,
    SPELL_ENRAGE                    = 8599,
    SPELL_CRYSTALFIRE_BREATH        = 48096,
    SPELL_CRYSTALIZE                = 48179,
    SPELL_INTENSE_COLD              = 48094,
    SPELL_INTENSE_COLD_TRIGGER      = 48095,
};

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_ENRAGE                      = 2,
    SAY_DEATH                       = 3,
    SAY_CRYSTAL_NOVA                = 4,
    EMOTE_FRENZY                    = 5
};

enum Events
{
    EVENT_CRYSTALFIRE_BREATH        = 1,
    EVENT_CRYSTAL_CHAINS            = 2,
    EVENT_TAIL_SWEEP                = 3,
    EVENT_HEALTH_CHECK              = 4,
    EVENT_ACHIEVEMENT_CHECK         = 5,
    EVENT_KILL_TALK                 = 6
};

struct boss_keristrasza : public BossAI
{
    boss_keristrasza(Creature* creature) : BossAI(creature, DATA_KERISTRASZA_EVENT) {}

    std::set<uint32> aGuids;

    void Reset() override
    {
        BossAI::Reset();
        RemovePrison(CanRemovePrison());
        aGuids.clear();
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        BossAI::JustEngagedWith(who);

        me->CastSpell(me, SPELL_INTENSE_COLD, true);
        events.ScheduleEvent(EVENT_CRYSTALFIRE_BREATH, 14s);
        events.ScheduleEvent(EVENT_CRYSTAL_CHAINS, DUNGEON_MODE(20s, 11s));
        events.ScheduleEvent(EVENT_TAIL_SWEEP, 5s);
        events.ScheduleEvent(EVENT_HEALTH_CHECK, 1s);
        events.ScheduleEvent(EVENT_ACHIEVEMENT_CHECK, 1s);
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit*) override
    {
        if (!events.HasTimeUntilEvent(EVENT_KILL_TALK))
        {
            Talk(SAY_SLAY);
            events.ScheduleEvent(EVENT_KILL_TALK, 6s);
        }
    }

    void SetData(uint32 type, uint32) override
    {
        if (type == me->GetEntry() && CanRemovePrison())
            RemovePrison(true);
    }

    bool CanRemovePrison()
    {
        for (uint8 i = DATA_TELESTRA_ORB; i <= DATA_ORMOROK_ORB; ++i)
            if (instance->GetBossState(i) != DONE)
                return false;
        return true;
    }

    void RemovePrison(bool remove)
    {
        if (remove)
        {
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);
        }
        else
        {
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }
    }

    uint32 GetData(uint32 guid) const override
    {
        return aGuids.find(guid) == aGuids.end();
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
        case EVENT_HEALTH_CHECK:
            if (me->HealthBelowPct(26))
            {
                Talk(SAY_ENRAGE);
                Talk(EMOTE_FRENZY);
                me->CastSpell(me, SPELL_ENRAGE, true);
                break;
            }
            events.ScheduleEvent(EVENT_HEALTH_CHECK, 1s);
            break;
        case EVENT_ACHIEVEMENT_CHECK:
        {
            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                if (Aura* aur = itr->GetSource()->GetAura(SPELL_INTENSE_COLD_TRIGGER))
                    if (aur->GetStackAmount() > 2)
                        aGuids.insert(itr->GetSource()->GetGUID().GetCounter());
            events.ScheduleEvent(EVENT_ACHIEVEMENT_CHECK, 500ms);
            break;
        }
        case EVENT_CRYSTALFIRE_BREATH:
            me->CastSpell(me->GetVictim(), SPELL_CRYSTALFIRE_BREATH, false);
            events.ScheduleEvent(EVENT_CRYSTALFIRE_BREATH, 14s);
            break;
        case EVENT_TAIL_SWEEP:
            me->CastSpell(me, SPELL_TAIL_SWEEP, false);
            events.ScheduleEvent(EVENT_TAIL_SWEEP, 5s);
            break;
        case EVENT_CRYSTAL_CHAINS:
            Talk(SAY_CRYSTAL_NOVA);
            if (IsHeroic())
                me->CastSpell(me, SPELL_CRYSTALIZE, false);
            else if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                me->CastSpell(target, SPELL_CRYSTAL_CHAINS, false);
            events.ScheduleEvent(EVENT_CRYSTAL_CHAINS, DUNGEON_MODE(20s, 11s));
            break;
        }

        DoMeleeAttackIfReady();
    }
};

class achievement_intense_cold : public AchievementCriteriaScript
{
public:
    achievement_intense_cold() : AchievementCriteriaScript("achievement_intense_cold") { }

    bool OnCheck(Player* player, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(player->GetGUID().GetCounter());
    }
};

void AddSC_boss_keristrasza()
{
    RegisterNexusCreatureAI(boss_keristrasza);
    new achievement_intense_cold();
}
