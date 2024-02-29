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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ahnkahet.h"

enum Spells
{
    SPELL_BASH                              = 57094,
    SPELL_ENTANGLING_ROOTS                  = 57095,
    SPELL_MINI                              = 57055,
    SPELL_VENOM_BOLT_VOLLEY                 = 57088,
    SPELL_REMOVE_MUSHROOM_POWER             = 57283,

    // Mushroom
    SPELL_HEALTHY_MUSHROOM_POTENT_FUNGUS    = 56648,
    SPELL_POISONOUS_MUSHROOM_POISON_CLOUD   = 57061,
    SPELL_POISONOUS_MUSHROOM_VISUAL_AURA    = 56741,
    SPELL_POISONOUS_MUSHROOM_VISUAL_AREA    = 61566, // Self
    SPELL_HEALTHY_MUSHROOM_VISUAL_AURA      = 56740,
    SPELL_PUTRID_MUSHROOM                   = 31690,
    SPELL_GROW                              = 57059,
    SPELL_SHRINK                            = 31691,
};

enum Creatures
{
    NPC_HEALTHY_MUSHROOM                    = 30391,
    NPC_POISONOUS_MUSHROOM                  = 30435
};

enum Events
{
    // Boss
    EVENT_RESPAWN                           = 1,
    EVENT_ROOTS,
    EVENT_BASH,
    EVENT_BOLT,
    EVENT_REMOVE_MUSHROOM_POWER,
    EVENT_MINI,

    // Mushroom
    EVENT_GROW,
    EVENT_CHECK_PLAYER,
    EVENT_KILLSELF,
};

constexpr uint8 MAX_MUSHROOMS_COUNT = 32;
Position const MushroomPositions[MAX_MUSHROOMS_COUNT] =
{
    { 373.4807f, -856.5301f, -74.30518f, 0.2094395f },
    { 358.4792f, -879.3193f, -75.9463f,  5.166174f  },
    { 356.5531f, -846.3022f, -72.1796f,  3.193953f  },
    { 332.369f,  -846.081f,  -74.30516f, 4.834562f  },
    { 360.2234f, -862.055f,  -75.22755f, 1.658063f  },
    { 351.7189f, -890.9619f, -76.54617f, 1.064651f  },
    { 345.8126f, -869.1772f, -77.17728f, 1.361357f  },
    { 367.5179f, -884.0129f, -77.32881f, 4.276057f  },
    { 370.6044f, -868.4305f, -74.19881f, 0.8901179f },
    { 381.3156f, -873.2377f, -74.82656f, 1.099557f  },
    { 371.5869f, -873.8141f, -74.72424f, 1.082104f  },
    { 340.4079f, -891.6375f, -74.99128f, 1.134464f  },
    { 368.21f,   -851.5953f, -73.99741f, 4.694936f  },
    { 328.7047f, -853.9812f, -75.51253f, 0.5759587f },
    { 366.4145f, -876.39f,   -75.52739f, 5.253441f  },
    { 380.1362f, -861.4344f, -73.45917f, 3.787364f  },
    { 373.3007f, -888.8057f, -79.03593f, 5.602507f  },
    { 348.3599f, -848.0839f, -73.54117f, 1.745329f  },
    { 352.5586f, -882.6624f, -75.68202f, 3.822271f  },
    { 357.8967f, -871.179f,  -75.77553f, 2.443461f  },
    { 360.1034f, -842.3351f, -71.08852f, 4.34587f   },
    { 348.1334f, -861.5244f, -74.61307f, 2.565634f  },
    { 401.4896f, -866.7059f, -73.22395f, 0.8901179f },
    { 360.1683f, -889.1515f, -76.74798f, 3.612832f  },
    { 350.1828f, -907.7313f, -74.94678f, 5.044002f  },
    { 340.6278f, -856.5973f, -74.23862f, 4.415683f  },
    { 366.4849f, -859.7621f, -74.82679f, 1.500983f  },
    { 359.1482f, -853.3346f, -74.47543f, 5.654867f  },
    { 374.9992f, -879.0921f, -75.56115f, 1.867502f  },
    { 339.5252f, -850.4612f, -74.45442f, 4.764749f  },
    { 337.0534f, -864.002f,  -75.72749f, 4.642576f  },
    { 398.2797f, -851.8694f, -68.84419f, 0.5759587f }
};

struct boss_amanitar : public BossAI
{
    boss_amanitar(Creature* creature) : BossAI(creature, DATA_AMANITAR), mushroomsSummoned(false)
    {
        creature->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
        creature->SetMeleeDamageSchool(SPELL_SCHOOL_NATURE);
    }

    void Reset() override
    {
        _Reset();
        _mushroomsDeque.clear();
        mushroomsSummoned = false;
    }

    void JustEngagedWith(Unit* /*attacker*/) override
    {
        events.ScheduleEvent(EVENT_ROOTS, 5s, 9s);
        events.ScheduleEvent(EVENT_BASH, 10s, 14s);
        events.ScheduleEvent(EVENT_BOLT, 15s, 20s);
        events.ScheduleEvent(EVENT_MINI, 1s);
        events.ScheduleEvent(EVENT_RESPAWN, 40s, 60s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MINI);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void SummonedCreatureDies(Creature* summon, Unit* killer) override
    {
        _mushroomsDeque.push_back(summon->GetPosition());
        BossAI::SummonedCreatureDies(summon, killer);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MINI);
        BossAI::EnterEvadeMode(why);
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_RESPAWN:
            {
                while (!_mushroomsDeque.empty())
                {
                    SummonMushroom(_mushroomsDeque.front());
                    _mushroomsDeque.pop_front();
                }

                events.Repeat(40s, 60s);
                break;
            }
            case EVENT_ROOTS:
            {
                if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                {
                    DoCast(pTarget, SPELL_ENTANGLING_ROOTS, false);
                }

                events.Repeat(10s, 15s);
                break;
            }
            case EVENT_BASH:
            {
                DoCastVictim(SPELL_BASH, false);
                events.Repeat(15s, 20s);
                break;
            }
            case EVENT_BOLT:
            {
                if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                {
                    DoCast(pTarget, SPELL_VENOM_BOLT_VOLLEY, false);
                }

                events.Repeat(15s, 20s);
                break;
            }
            case EVENT_REMOVE_MUSHROOM_POWER:
            {
                DoCastAOE(SPELL_REMOVE_MUSHROOM_POWER, true);
                events.RescheduleEvent(EVENT_MINI, 1s);
                break;
            }
            case EVENT_MINI:
            {
                if (!mushroomsSummoned)
                {
                    mushroomsSummoned = true;
                    for (uint8 i = 0; i < MAX_MUSHROOMS_COUNT; ++i)
                    {
                        SummonMushroom(MushroomPositions[i]);
                    }
                }

                if (SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true, -SPELL_MINI))
                {
                    DoCastSelf(SPELL_REMOVE_MUSHROOM_POWER, true);
                    DoCastAOE(SPELL_MINI);
                    events.RescheduleEvent(EVENT_REMOVE_MUSHROOM_POWER, 29s);
                }
                else
                {
                    events.RepeatEvent(1000);
                }

                break;
            }
        }
    }

private:
    std::deque<Position> _mushroomsDeque;
    bool mushroomsSummoned;

    void SummonMushroom(Position const& pos)
    {
        me->SummonCreature(roll_chance_i(40) ? NPC_HEALTHY_MUSHROOM : NPC_POISONOUS_MUSHROOM, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 4000);
    }
};

struct npc_amanitar_mushrooms : public ScriptedAI
{
    npc_amanitar_mushrooms(Creature* pCreature) : ScriptedAI(pCreature)
    {
        me->SetCombatMovement(false);

        //TODO: this prolly needs to be done in database
        pCreature->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        pCreature->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        pCreature->SetRegeneratingHealth(false);
    }

    // Disabled events
    void JustEngagedWith(Unit* /*who*/) override {}
    void AttackStart(Unit* /*victim*/) override {}
    void EnterEvadeMode(EvadeReason /*why*/) override {}

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);
        DoCastSelf(SPELL_PUTRID_MUSHROOM);

        if (me->GetEntry() == NPC_POISONOUS_MUSHROOM)
        {
            DoCastSelf(SPELL_POISONOUS_MUSHROOM_VISUAL_AURA, true);
        }
        else
        {
            DoCastSelf(SPELL_HEALTHY_MUSHROOM_VISUAL_AURA, true);
        }

        events.ScheduleEvent(EVENT_GROW, 800ms);

        if (me->GetEntry() == NPC_POISONOUS_MUSHROOM)
        {
            events.ScheduleEvent(EVENT_CHECK_PLAYER, 250ms);
        }
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (me->GetEntry() == NPC_HEALTHY_MUSHROOM && damage >= me->GetHealth())
        {
            DoCastSelf(SPELL_HEALTHY_MUSHROOM_POTENT_FUNGUS, true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (events.Empty())
            return;

        events.Update(diff);
        while (uint32 const eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_GROW:
                {
                    DoCastSelf(SPELL_GROW);
                    break;
                }
                case EVENT_CHECK_PLAYER:
                {
                    if (Player* plr = me->SelectNearestPlayer(2.0f))
                    {
                        plr->RemoveAurasDueToSpell(SPELL_HEALTHY_MUSHROOM_POTENT_FUNGUS);
                        DoCastSelf(SPELL_POISONOUS_MUSHROOM_VISUAL_AREA);
                        DoCastSelf(SPELL_POISONOUS_MUSHROOM_POISON_CLOUD);
                        DoCastSelf(SPELL_SHRINK);
                        events.ScheduleEvent(EVENT_KILLSELF, 4s);
                    }
                    else
                    {
                        events.Repeat(250ms);
                    }

                    break;
                }
                case EVENT_KILLSELF:
                {
                    me->DisappearAndDie();
                    break;
                }
            }
        }
    }

private:
    EventMap events;
};

// 57283 Remove Mushroom Power
class spell_amanitar_remove_mushroom_power : public AuraScript
{
    PrepareAuraScript(spell_amanitar_remove_mushroom_power);

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            target->RemoveAurasDueToSpell(SPELL_HEALTHY_MUSHROOM_POTENT_FUNGUS);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_amanitar_remove_mushroom_power::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_amanitar()
{
    RegisterAhnKahetCreatureAI(boss_amanitar);
    RegisterAhnKahetCreatureAI(npc_amanitar_mushrooms);

    // Spells
    RegisterSpellScript(spell_amanitar_remove_mushroom_power);
}

