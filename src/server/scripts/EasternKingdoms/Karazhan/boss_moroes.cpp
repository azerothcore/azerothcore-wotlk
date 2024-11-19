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
#include "karazhan.h"

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_SPECIAL                 = 1,
    SAY_KILL                    = 2,
    SAY_DEATH                   = 3,
    SAY_OUT_OF_COMBAT           = 4,

    SAY_GUEST                   = 0
};

enum Spells
{
    SPELL_VANISH                = 29448,
    SPELL_GARROTE_DUMMY         = 29433,
    SPELL_GARROTE               = 37066,
    SPELL_BLIND                 = 34694,
    SPELL_GOUGE                 = 29425,
    SPELL_FRENZY                = 37023,
    SPELL_DUAL_WIELD            = 29651,
    SPELL_BERSERK               = 26662,
    SPELL_VANISH_TELEPORT       = 29431
};

enum Misc
{
    ACTIVE_GUEST_COUNT          = 4,
    MAX_GUEST_COUNT             = 6
};

enum Groups
{
    GROUP_PRECOMBAT_TALK        = 0
};

const Position GuestsPosition[4] =
{
    {-10987.38f, -1883.38f, 81.73f, 1.50f},
    {-10989.60f, -1881.27f, 81.73f, 0.73f},
    {-10978.81f, -1884.08f, 81.73f, 1.50f},
    {-10976.38f, -1882.59f, 81.73f, 2.31f}
};

const uint32 GuestEntries[6] =
{
    17007, 19872, 19873,
    19874, 19875, 19876
};

struct boss_moroes : public BossAI
{
    boss_moroes(Creature* creature) : BossAI(creature, DATA_MOROES)
    {
        _activeGuests = 0;
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void InitializeAI() override
    {
        BossAI::InitializeAI();
        InitializeGuests();
    }

    void JustReachedHome() override
    {
        BossAI::JustReachedHome();
        InitializeGuests();
    }

    void InitializeGuests()
    {
        if (!me->IsAlive())
            return;

        if (_activeGuests == 0)
        {
            _activeGuests |= 0x3F;
            uint8 rand1 = RAND(0x01, 0x02, 0x04);
            uint8 rand2 = RAND(0x08, 0x10, 0x20);
            _activeGuests &= ~(rand1 | rand2);
        }
        for (uint8 i = 0; i < MAX_GUEST_COUNT; ++i)
        {
            if ((1 << i) & _activeGuests)
            {
                me->SummonCreature(GuestEntries[i], GuestsPosition[summons.size()], TEMPSUMMON_MANUAL_DESPAWN);
            }
        }

        scheduler.Schedule(10s, GROUP_PRECOMBAT_TALK, [this](TaskContext context)
        {
            if (Creature* guest = GetRandomGuest())
            {
                guest->AI()->Talk(SAY_GUEST);
            }
            context.Repeat(5s);
        }).Schedule(1min, 2min, GROUP_PRECOMBAT_TALK, [this](TaskContext context)
        {
            Talk(SAY_OUT_OF_COMBAT);
            context.Repeat(1min, 2min);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        DoCastSelf(SPELL_DUAL_WIELD, true);
        _recentlySpoken = false;
        _vanished = false;

        ScheduleHealthCheckEvent(30, [&] {
            DoCastSelf(SPELL_FRENZY, true);
        });
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        me->CallForHelp(20.0f);
        DoZoneInCombat();
        scheduler.CancelGroup(GROUP_PRECOMBAT_TALK);

        scheduler.Schedule(30s, [this](TaskContext context)
        {
            scheduler.DelayAll(9s);
            _vanished = true;
            Talk(SAY_SPECIAL);
            DoCastSelf(SPELL_VANISH);
            me->SetImmuneToAll(true);
            scheduler.Schedule(5s, 7s, [this](TaskContext)
            {
                me->SetImmuneToAll(false);
                DoCastSelf(SPELL_VANISH_TELEPORT);
                _vanished = false;
            });

            context.Repeat(30s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastMaxThreat(SPELL_BLIND, 1, 10.0f, true);
            context.Repeat(25s, 40s);
        }).Schedule(13s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_GOUGE);
            context.Repeat(25s, 40s);
        }).Schedule(10min, [this](TaskContext)
        {
            DoCastSelf(SPELL_BERSERK, true);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (!_recentlySpoken && victim->IsPlayer())
        {
            Talk(SAY_KILL);
            _recentlySpoken = true;
            scheduler.Schedule(5s, [this](TaskContext)
            {
                _recentlySpoken = false;
            });
        }
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GARROTE);
    }

    Creature* GetRandomGuest()
    {
        std::list<Creature*> guestList;
        for (SummonList::const_iterator i = summons.begin(); i != summons.end(); ++i)
        {
            if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
            {
                guestList.push_back(summon);
            }
        }

        return Acore::Containers::SelectRandomContainerElement(guestList);
    }

    bool CheckGuestsInRoom()
    {
        bool guestsInRoom = true;
        summons.DoForAllSummons([&guestsInRoom](WorldObject* summon)
        {
            if ((summon->ToCreature()->GetPositionX()) < -11028.f || (summon->ToCreature()->GetPositionY()) < -1955.f) //boundaries of the two doors
            {
                guestsInRoom = false;
                return false;
            }
            return true;
        });

        return guestsInRoom;
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!CheckGuestsInRoom())
        {
            EnterEvadeMode();
            summons.DoForAllSummons([](WorldObject* summon)
            {
                summon->ToCreature()->DespawnOnEvade(5s);
            });
            return;
        }

        if (!UpdateVictim())
            return;

        if (_vanished == false)
        {
            DoMeleeAttackIfReady();
        }
    }

    private:
        EventMap _events2;
        uint8 _activeGuests;
        bool _recentlySpoken;
        bool _vanished;
};

class spell_moroes_vanish : public SpellScript
{
    PrepareSpellScript(spell_moroes_vanish);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            Position pos = target->GetFirstCollisionPosition(5.0f, M_PI);
            GetCaster()->CastSpell(target, SPELL_GARROTE_DUMMY, true);
            GetCaster()->RemoveAurasDueToSpell(SPELL_VANISH);
            GetCaster()->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), target->GetOrientation());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_moroes_vanish::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_moroes()
{
    RegisterKarazhanCreatureAI(boss_moroes);
    RegisterSpellScript(spell_moroes_vanish);
}
