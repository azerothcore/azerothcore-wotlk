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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_HEAL_BROTHER            = 7393,
    SPELL_TWIN_TELEPORT           = 800,
    SPELL_TWIN_TELEPORT_VISUAL    = 26638,
    SPELL_EXPLODEBUG              = 804,
    SPELL_MUTATE_BUG              = 802,
    SPELL_BERSERK                 = 26662,
    SPELL_UPPERCUT                = 26007,
    SPELL_UNBALANCING_STRIKE      = 26613,
    SPELL_SHADOW_BOLT             = 26006,
    SPELL_BLIZZARD                = 26607,
    SPELL_ARCANEBURST             = 568,
};

enum Actions
{
    ACTION_START_INTRO            = 0
};

enum Say
{
    SAY_INTRO_0                   = 0,
    SAY_INTRO_1                   = 1,
    SAY_INTRO_2                   = 2,

    EMOTE_MASTERS_EYE_AT          = 0
};

constexpr float veklorOrientationIntro = 2.241519f;
constexpr float veknilashOrientationIntro = 1.144451f;

struct boss_twinemperorsAI : public BossAI
{
    boss_twinemperorsAI(Creature* creature): BossAI(creature, DATA_TWIN_EMPERORS), _introDone(false) { }

    Creature* GetTwin()
    {
        return instance->GetCreature(IAmVeklor() ? DATA_VEKNILASH : DATA_VEKLOR);
    }

    void DoAction(int32 action) override
    {
        if (action != ACTION_START_INTRO)
            return;

        _scheduler.Schedule(5s, [this](TaskContext /*context*/)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->LoadEquipment(1, true);
            });

        if (IAmVeklor())
        {
            _scheduler
                .Schedule(12s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_0);
                })
                .Schedule(20s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_1);
                })
                .Schedule(28s, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                })
                .Schedule(30s, [this](TaskContext /*context*/)
                {
                    me->SetFacingTo(veklorOrientationIntro);
                    Talk(SAY_INTRO_2);
                    _introDone = true;
                })
                .Schedule(33s, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                });
        }
        else
        {
            _scheduler
                .Schedule(17s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_0);
                })
                .Schedule(23s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_1);
                })
                .Schedule(28s, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                })
                .Schedule(32s, [this](TaskContext /*context*/)
                {
                    me->SetFacingTo(veknilashOrientationIntro);
                    Talk(SAY_INTRO_2);
                    _introDone = true;
                })
                .Schedule(33s, [this](TaskContext /*context*/)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() && _introDone)
            return;

        _scheduler.Update(diff, [this]
            {
                if (!IAmVeklor())
                    DoMeleeAttackIfReady();
            });
    }

    virtual bool IAmVeklor() = 0;

protected:
    TaskScheduler _scheduler;
    bool _introDone;
};

struct boss_veknilash : public boss_twinemperorsAI
{
    boss_veknilash(Creature* creature) : boss_twinemperorsAI(creature) { }

    bool IAmVeklor() override { return false; }
};

struct boss_veklor : public boss_twinemperorsAI
{
    boss_veklor(Creature* creature) : boss_twinemperorsAI(creature) { }

    bool IAmVeklor() override { return true; }
};

class at_twin_emperors : public OnlyOnceAreaTriggerScript
{
public:
    at_twin_emperors() : OnlyOnceAreaTriggerScript("at_twin_emperors") { }

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* mastersEye = instance->GetCreature(DATA_MASTERS_EYE))
            {
                mastersEye->AI()->Talk(EMOTE_MASTERS_EYE_AT, player);
                mastersEye->DespawnOrUnsummon(11000);
                mastersEye->m_Events.AddEventAtOffset([mastersEye, player]()
                    {
                        mastersEye->SetFacingToObject(player);
                    }, 3s);
            }

            if (Creature* veklor = instance->GetCreature(DATA_VEKLOR))
                veklor->AI()->DoAction(ACTION_START_INTRO);

            if (Creature* veknilash = instance->GetCreature(DATA_VEKNILASH))
                veknilash->AI()->DoAction(ACTION_START_INTRO);
        }
        return false;
    }
};

void AddSC_boss_twinemperors()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_veknilash);
    RegisterTempleOfAhnQirajCreatureAI(boss_veklor);
    new at_twin_emperors();
}
