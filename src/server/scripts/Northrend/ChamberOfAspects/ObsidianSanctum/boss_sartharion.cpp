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
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "obsidian_sanctum.h"

enum Says
{
    // SARTHARION
    SAY_SARTHARION_AGGRO                        = 0,
    SAY_SARTHARION_BERSERK                      = 1,
    SAY_SARTHARION_BREATH                       = 2,
    SAY_SARTHARION_CALL_SHADRON                 = 3,
    SAY_SARTHARION_CALL_TENEBRON                = 4,
    SAY_SARTHARION_CALL_VESPERON                = 5,
    SAY_SARTHARION_DEATH                        = 6,
    SAY_SARTHARION_SPECIAL                      = 7,
    SAY_SARTHARION_SLAY                         = 8,
    SAY_SARTHARION_SPECIAL_4                    = 10, // 9 is whisper

    // TENEBRON
    SAY_TENEBRON_AGGRO                          = 0,
    SAY_TENEBRON_SLAY                           = 1,
    SAY_TENEBRON_DEATH                          = 2,
    SAY_TENEBRON_BREATH                         = 3,
    SAY_TENEBRON_RESPOND                        = 4,
    SAY_TENEBRON_SPECIAL                        = 5,

    // SHADRON
    SAY_SHADRON_AGGRO                           = 0,
    SAY_SHADRON_SLAY                            = 1,
    SAY_SHADRON_DEATH                           = 2,
    SAY_SHADRON_BREATH                          = 3,
    SAY_SHADRON_RESPOND                         = 4,
    SAY_SHADRON_SPECIAL                         = 5,

    // VESPERON
    SAY_VESPERON_AGGRO                          = 0,
    SAY_VESPERON_SLAY                           = 1,
    SAY_VESPERON_DEATH                          = 2,
    SAY_VESPERON_BREATH                         = 3,
    SAY_VESPERON_RESPOND                        = 4,
    SAY_VESPERON_SPECIAL                        = 5,

    // MISC
    WHISPER_LAVA_CHURN                          = 9,
    WHISPER_OPEN_PORTAL                         = 6,
    WHISPER_HATCH_EGGS                          = 6,
    WHISPER_SUMMON_DICIPLE                      = 7,
};

// Uses spelldifficulty_dbc
enum Spells
{
    // Mini-boss shared
    SPELL_SHADOW_BREATH                         = 57570,
    SPELL_SHADOW_FISSURE                        = 57579,
    SPELL_SUMMON_TWILIGHT_WHELP                 = 58035,
    SPELL_GIFT_OF_TWILIGHT_SHADOW               = 57835,
    SPELL_TWILIGHT_TORMENT_VESPERON             = 57935,

    // Sartharion
    SPELL_SARTHARION_CLEAVE                     = 56909,
    SPELL_SARTHARION_FLAME_BREATH               = 56908,
    SPELL_SARTHARION_TAIL_LASH                  = 56910,
    SPELL_CYCLONE_AURA_PERIODIC                 = 57598,
    SPELL_LAVA_STRIKE_DUMMY                     = 57578,
    SPELL_LAVA_STRIKE_DUMMY_TRIGGER             = 57697,
    SPELL_LAVA_STRIKE_SUMMON                    = 57572,
    SPELL_SARTHARION_PYROBUFFET                 = 56916,
    SPELL_SARTHARION_BERSERK                    = 61632,
    SPELL_SARTHARION_TWILIGHT_REVENGE           = 60639,

    // Sartharion with drakes
    SPELL_WILL_OF_SARTHARION                    = 61254,
    SPELL_POWER_OF_TENEBRON                     = 61248,
    SPELL_POWER_OF_VESPERON                     = 61251,
    SPELL_POWER_OF_SHADRON                      = 58105,
    SPELL_GIFT_OF_TWILIGHT_FIRE                 = 58766,

    // Visuals
    SPELL_EGG_MARKER_VISUAL                     = 58547,
    SPELL_FLAME_TSUNAMI_VISUAL                  = 57494,

    // Misc
    SPELL_FADE_ARMOR                            = 60708,
    SPELL_FLAME_TSUNAMI_DAMAGE_AURA             = 57492,
    SPELL_FLAME_TSUNAMI_LEAP                    = 60241,
    SPELL_SARTHARION_PYROBUFFET_TRIGGER         = 57557,
};

enum NPCs
{
    NPC_TWILIGHT_EGG                            = 30882,
    NPC_TWILIGHT_WHELP                          = 30890,
    NPC_DISCIPLE_OF_SHADRON                     = 30688,
    NPC_DISCIPLE_OF_VESPERON                    = 30858,
    NPC_ACOLYTE_OF_SHADRON                      = 31218,
    NPC_ACOLYTE_OF_VESPERON                     = 31219,

    // Sartharion fight
    NPC_LAVA_BLAZE                              = 30643,
    NPC_FLAME_TSUNAMI                           = 30616,
    NPC_SAFE_AREA_TRIGGER                       = 30494,
};

enum Misc
{
    // Actions
    ACTION_SWITCH_PHASE                         = 1,
    ACTION_CALL_DRAGON                          = 2,
    ACTION_DRAKE_DIED                           = 3,

    // Movement points
    POINT_FINAL_TENEBRON                        = 8,
    POINT_FINAL_SHADRON                         = 4,
    POINT_FINAL_VESPERON                        = 4,

    // Lava directions. Its used to identify to which side lava was moving by last time
    LAVA_LEFT_SIDE                              = 0,
    LAVA_RIGHT_SIDE                             = 1,

    // Counters
    MAX_LEFT_LAVA_TSUNAMIS                      = 3,
    MAX_RIGHT_LAVA_TSUNAMIS                     = 2,
    MAX_DRAGONS                                 = 3,
    MAX_AREA_TRIGGER_COUNT                      = 2,
    MAX_CYCLONE_COUNT                           = 5,
    MAX_TENEBORN_EGGS_SUMMONS                   = 6,
    MAX_BOUNDARY_POSITIONS                      = 4,
};

enum Events
{
    // Solo drake abilities
    EVENT_MINIBOSS_SHADOW_FISSURE               = 1,
    EVENT_MINIBOSS_SHADOW_BREATH                = 2,
    EVENT_MINIBOSS_HATCH_EGGS                   = 3,
    EVENT_MINIBOSS_OPEN_PORTAL                  = 4,
    EVENT_MINIBOSS_SPAWN_HELPERS                = 5,
    EVENT_MINIBOSS_RESPOND                      = 6,

    // Sartharion abilities
    EVENT_SARTHARION_CAST_CLEAVE                = 10,
    EVENT_SARTHARION_CAST_FLAME_BREATH          = 11,
    EVENT_SARTHARION_CAST_TAIL_LASH             = 12,
    EVENT_SARTHARION_SUMMON_LAVA                = 13,
    EVENT_SARTHARION_START_LAVA                 = 14,
    EVENT_SARTHARION_FINISH_LAVA                = 15,
    EVENT_SARTHARION_LAVA_STRIKE                = 16,
    EVENT_SARTHARION_BERSERK                    = 17,

    // Drake abilities called by sartharion
    EVENT_SARTHARION_CALL_TENEBRON              = 30,
    EVENT_SARTHARION_CALL_SHADRON               = 31,
    EVENT_SARTHARION_CALL_VESPERON              = 32,

    EVENT_SARTHARION_BOUNDARY                   = 33,
    EVENT_MINIDRAKE_SPEECH                      = 34,
};

const Position portalPos[4] =
{
    { 3247.29f, 529.804f, 58.9595f, 0.0f },
    { 3248.62f, 646.739f, 85.2939f, 0.0f },
    { 3151.20f, 517.862f, 90.3389f, 0.0f },
    { 3351.78f, 517.138f, 99.1620f, 0.0f },
};

// 0 = Tenebron normal
// 1 = Tenebron was called by Sartharion
const Position TenebronEggsPos[2][MAX_TENEBORN_EGGS_SUMMONS] =
{
    // Teneborn normal
    {
        { 3253.09f, 657.439f, 86.9921f, 3.16334f },
        { 3247.76f, 662.413f, 87.7281f, 4.12938f },
        { 3246.01f, 656.606f, 86.8737f, 4.12938f },
        { 3246.7f, 649.558f, 85.8179f, 4.12938f },
        { 3238.72f, 650.386f, 85.9625f, 0.897469f },
        { 3257.89f, 651.323f, 85.9177f, 0.897469f },
    },
    // Tenebron eggs positions when he is called by Sartharion
    {
        { 3237.24f, 524.20f, 58.95f, 0.0f },
        { 3238.95f, 513.96f, 58.662f, 0.7f },
        { 3245.66f, 519.685f, 58.78f, 0.7f },
        { 3254.64f, 524.6f, 58.811f, 1.966f },
        { 3258.9f, 534.41f, 58.811f, 2.08f },
        { 3248.23f, 541.93f, 58.718f, 3.29f }
    }
};

const Position CycloneSummonPos[MAX_CYCLONE_COUNT] =
{
    { 3235.28f, 591.180f, 57.0833f, 0.59037f },
    { 3200.97f, 480.929f, 57.0833f, 5.86197f },
    { 3281.57f, 507.984f, 57.0833f, 5.54346f },
    { 3210.11f, 531.957f, 57.0833f, 3.76777f },
    { 3286.42f, 585.010f, 57.0833f, 4.10307f },
};

const Position AreaTriggerSummonPos[MAX_AREA_TRIGGER_COUNT] =
{
    { 3244.14f, 512.597f, 58.6534f, 0.0f },
    { 3242.84f, 553.979f, 58.8272f, 0.0f },
};

const float SartharionBoundary[MAX_BOUNDARY_POSITIONS] =
{
    3218.86f,   // South X
    3275.69f,   // North X
    484.68f,    // East Y
    572.4f      // West Y
};

const Position bigIslandMiddlePos = { 3242.822754f, 477.279816f, 57.430473f };

const uint32 dragons[MAX_DRAGONS] = { DATA_TENEBRON, DATA_VESPERON, DATA_SHADRON };

/////////////////////////////
// SARTHARION
/////////////////////////////

class boss_sartharion : public CreatureScript
{
public:
    boss_sartharion() : CreatureScript("boss_sartharion") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetObsidianSanctumAI<boss_sartharionAI> (pCreature);
    }

    struct boss_sartharionAI : public BossAI
    {
        boss_sartharionAI(Creature* pCreature) : BossAI(pCreature, DATA_SARTHARION),
            dragonsCount(0),
            lastLavaSide(LAVA_RIGHT_SIDE),
            usedBerserk(false),
            below11PctReached(false)
        {
        }

        void Reset() override
        {
            _Reset();
            extraEvents.Reset();
            RespawnDragons(false);
            SummonStartingTriggers();
            usedBerserk = false;
            below11PctReached = false;
            dragonsCount = 0;
            volcanoBlows.clear();
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_DRAKE_DIED)
            {
                DoCastSelf(SPELL_SARTHARION_TWILIGHT_REVENGE, true);
            }
        }

        void JustEngagedWith(Unit* pWho) override
        {
            if (pWho && !IsTargetInBounds(pWho))
            {
                EnterEvadeMode();
                return;
            }

            _JustEngagedWith();
            DoCastSelf(SPELL_SARTHARION_PYROBUFFET, true);
            Talk(SAY_SARTHARION_AGGRO);

            // Combat events
            events.ScheduleEvent(EVENT_SARTHARION_CAST_CLEAVE, 7s);
            events.ScheduleEvent(EVENT_SARTHARION_CAST_FLAME_BREATH, 15s);
            events.ScheduleEvent(EVENT_SARTHARION_CAST_TAIL_LASH, 11s);

            // Extra events
            extraEvents.ScheduleEvent(EVENT_SARTHARION_SUMMON_LAVA, 20s);
            extraEvents.ScheduleEvent(EVENT_SARTHARION_LAVA_STRIKE, 5s);
            extraEvents.ScheduleEvent(EVENT_SARTHARION_BERSERK, 15min);
            extraEvents.ScheduleEvent(EVENT_SARTHARION_BOUNDARY, 250ms);

            // Store dragons
            for (uint8 i = 0; i < MAX_DRAGONS; ++i)
            {
                Creature* dragon = ObjectAccessor::GetCreature(*me, instance->GetGuidData(dragons[i]));
                if (!dragon || !dragon->IsAlive() || instance->GetBossState(dragons[i]) == DONE)
                {
                    continue;
                }

                dragon->SetImmuneToNPC(true);
                dragon->SetFullHealth();

                ++dragonsCount;
                me->AddLootMode(1 << dragonsCount);

                switch (dragons[i])
                {
                    case DATA_TENEBRON:
                    {
                        dragon->CastSpell(dragon, SPELL_POWER_OF_TENEBRON, true);
                        extraEvents.ScheduleEvent(EVENT_SARTHARION_CALL_TENEBRON, 10s);
                        break;
                    }
                    case DATA_SHADRON:
                    {
                        dragon->CastSpell(dragon, SPELL_POWER_OF_SHADRON, true);
                        extraEvents.ScheduleEvent(EVENT_SARTHARION_CALL_SHADRON, 65s);
                        break;
                    }
                    case DATA_VESPERON:
                    {
                        dragon->CastSpell(dragon, SPELL_POWER_OF_VESPERON, true);
                        extraEvents.ScheduleEvent(EVENT_SARTHARION_CALL_VESPERON, 115s);
                        break;
                    }
                }
            }

            if (dragonsCount)
            {
                DoCastSelf(SPELL_WILL_OF_SARTHARION, true);
            }

            me->CallForHelp(500.0f);
        }

        void JustDied(Unit* /*killer*/) override
        {
            RespawnDragons(true);
            _JustDied();
            Talk(SAY_SARTHARION_DEATH);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_VOLCANO_BLOWS && data)
            {
                if (!volcanoBlows.empty() && std::find(volcanoBlows.begin(), volcanoBlows.end(), data) != volcanoBlows.end())
                {
                    return;
                }

                volcanoBlows.push_back(data);
            }
        }

        uint32 GetData(uint32 dataOrGuid) const override
        {
            // it means we want dragons count
            if (dataOrGuid == DATA_ACHIEVEMENT_DRAGONS_COUNT)
            {
                return dragonsCount;
            }

            // otherwise it is guid to check if player was hit by lava strike :)
            if (!volcanoBlows.empty() && std::find(volcanoBlows.begin(), volcanoBlows.end(), dataOrGuid) != volcanoBlows.end())
            {
                return 1;
            }

            return 0;
        }

        void KilledUnit(Unit* pVictim) override
        {
            if (!urand(0, 2) && pVictim->IsPlayer())
            {
                Talk(SAY_SARTHARION_SLAY);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            switch (summon->GetEntry())
            {
                case NPC_FLAME_TSUNAMI:
                {
                    summon->SetSpeed(MOVE_FLIGHT, 1.5f);
                    break;
                }
                case NPC_FIRE_CYCLONE:
                {
                    summon->GetMotionMaster()->MoveRandom(5.0f);
                    break;
                }
            }

            summons.Summon(summon);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            // Temporal hack, by some case some melee spells can bypass this aura damage reduction
            if (me->HasAura(SPELL_GIFT_OF_TWILIGHT_FIRE))
            {
                damage = 0;
                return;
            }

            if (!usedBerserk && me->HealthBelowPctDamaged(30, damage))
            {
                DoCastSelf(SPELL_SARTHARION_BERSERK, true);
                usedBerserk = true;
                return;
            }

            // Soft enrage
            if (!below11PctReached && me->HealthBelowPctDamaged(10, damage))
            {
                summons.RemoveNotExisting();
                if (!summons.empty())
                {
                    for (ObjectGuid const& summonGuid : summons)
                    {
                        Creature* summon = ObjectAccessor::GetCreature(*me, summonGuid);
                        if (summon && summon->GetEntry() == NPC_FIRE_CYCLONE)
                        {
                            summon->CastSpell(summon, SPELL_CYCLONE_AURA_PERIODIC, true);
                        }
                    }
                }
                Talk(SAY_SARTHARION_BERSERK);
                below11PctReached = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            extraEvents.Update(diff);

            // Special events which needs to be fired immidiately
            while (uint32 const eventId = extraEvents.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SARTHARION_BOUNDARY:
                    {
                        if (!IsTargetInBounds(me->GetVictim()))
                        {
                            EnterEvadeMode();
                        }
                        else
                        {
                            extraEvents.Repeat(250ms);
                        }
                        break;
                    }
                    case EVENT_SARTHARION_SUMMON_LAVA:
                    {
                        if (!urand(0, 3))
                        {
                            Talk(SAY_SARTHARION_SPECIAL);
                        }

                        SummonLavaWaves();
                        extraEvents.Repeat(25s);
                        return;
                    }
                    case EVENT_SARTHARION_START_LAVA:
                    {
                        SendLavaWaves(true);
                        return;
                    }
                    case EVENT_SARTHARION_FINISH_LAVA:
                    {
                        SendLavaWaves(false);
                        return;
                    }
                    // Handling of Drakes Events
                    // Dragon Calls
                    case EVENT_SARTHARION_CALL_TENEBRON:
                    {
                        Talk(SAY_SARTHARION_CALL_TENEBRON);
                        if (Creature* tenebron = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TENEBRON)))
                        {
                            tenebron->AI()->DoAction(ACTION_CALL_DRAGON);
                        }
                        break;
                    }
                    case EVENT_SARTHARION_CALL_SHADRON:
                    {
                        Talk(SAY_SARTHARION_CALL_SHADRON);
                        if (Creature* shadron = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SHADRON)))
                        {
                            shadron->AI()->DoAction(ACTION_CALL_DRAGON);
                        }
                        break;
                    }
                    case EVENT_SARTHARION_CALL_VESPERON:
                    {
                        Talk(SAY_SARTHARION_CALL_VESPERON);
                        if (Creature* vesperon = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_VESPERON)))
                        {
                            vesperon->AI()->DoAction(ACTION_CALL_DRAGON);
                        }

                        break;
                    }
                }
            }

            // Handle Sartharion combat abbilities
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SARTHARION_CAST_CLEAVE:
                    {
                        DoCastVictim(SPELL_SARTHARION_CLEAVE, false);
                        events.Repeat(10s);
                        break;
                    }
                    case EVENT_SARTHARION_CAST_FLAME_BREATH:
                    {
                        DoCastVictim(SPELL_SARTHARION_FLAME_BREATH, false);
                        events.Repeat(20s);
                        break;
                    }
                    case EVENT_SARTHARION_CAST_TAIL_LASH:
                    {
                        DoCastSelf(SPELL_SARTHARION_TAIL_LASH, false);
                        events.Repeat(18s);
                        break;
                    }
                    case EVENT_SARTHARION_LAVA_STRIKE:
                    {
                        if (!urand(0, 2))
                        {
                            Talk(SAY_SARTHARION_SPECIAL_4);
                        }

                        summons.RemoveNotExisting();
                        uint8 rand = urand(0, MAX_CYCLONE_COUNT - 1); // 5 - numer of cyclones
                        uint8 iter = 0;
                        if (!summons.empty())
                        {
                            for (ObjectGuid const& summonGuid : summons)
                            {
                                Creature* summon = ObjectAccessor::GetCreature(*me, summonGuid);
                                if (summon && summon->GetEntry() == NPC_FIRE_CYCLONE && iter == rand)
                                {
                                    summon->CastSpell(summon, SPELL_CYCLONE_AURA_PERIODIC, true);
                                    ++iter;
                                }
                            }
                        }

                        events.RepeatEvent((below11PctReached ? urand(1400, 2000) : urand(5000, 20000)));
                        break;
                    }
                    case EVENT_SARTHARION_BERSERK:
                    {
                        summons.DespawnEntry(NPC_SAFE_AREA_TRIGGER);
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        void SummonStartingTriggers()
        {
            for (uint8 i = 0; i < MAX_CYCLONE_COUNT; ++i)
            {
                me->SummonCreature(NPC_FIRE_CYCLONE, CycloneSummonPos[i]);
            }

            for (uint8 i = 0; i < MAX_AREA_TRIGGER_COUNT; ++i)
            {
                me->SummonCreature(NPC_SAFE_AREA_TRIGGER, AreaTriggerSummonPos[i]);
            }
        }

        void SummonLavaWaves()
        {
            summons.RemoveNotExisting();
            Talk(WHISPER_LAVA_CHURN);
            extraEvents.ScheduleEvent(EVENT_SARTHARION_START_LAVA, 2s);
            extraEvents.ScheduleEvent(EVENT_SARTHARION_FINISH_LAVA, 9s);

            // Send wave from left
            if (lastLavaSide == LAVA_RIGHT_SIDE)
            {
                for (uint8 i = 0; i < MAX_LEFT_LAVA_TSUNAMIS; ++i)
                {
                    me->SummonCreature(NPC_FLAME_TSUNAMI, 3208.44f, 580.0f - (i * 50.0f), 55.8f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 12000);
                }

                lastLavaSide = LAVA_LEFT_SIDE;
            }
            // from right
            else
            {
                for (uint8 i = 0; i < MAX_RIGHT_LAVA_TSUNAMIS; ++i)
                {
                    me->SummonCreature(NPC_FLAME_TSUNAMI, 3283.44f, 555.0f - (i * 50.0f), 55.8f, 3.14f, TEMPSUMMON_TIMED_DESPAWN, 12000);
                }

                lastLavaSide = LAVA_RIGHT_SIDE;
            }
        }

        void SendLavaWaves(bool start)
        {
            if (summons.empty())
            {
                return;
            }

            for (ObjectGuid const& guid : summons)
            {
                Creature* tsunami = ObjectAccessor::GetCreature(*me, guid);
                if (!tsunami || tsunami->GetEntry() != NPC_FLAME_TSUNAMI)
                {
                    continue;
                }

                if (start)
                {
                    tsunami->GetMotionMaster()->MovePoint(0, ((tsunami->GetPositionX() < 3250.0f) ? 3283.44f : 3208.44f), tsunami->GetPositionY(), tsunami->GetPositionZ());
                }
                else
                {
                    tsunami->SetObjectScale(0.1f);
                }
            }
        }

        void RespawnDragons(bool checkCombat)
        {
            for (uint8 i = 0; i < MAX_DRAGONS; ++i)
            {
                if (instance->GetBossState(dragons[i]) == DONE)
                {
                    continue;
                }

                if (Creature* dragon = ObjectAccessor::GetCreature(*me, instance->GetGuidData(dragons[i])))
                {
                    if (checkCombat && dragon->IsInCombat())
                    {
                        continue;
                    }

                    dragon->DespawnOrUnsummon();
                    dragon->SetRespawnTime(5);
                }
            }

            dragonsCount = 0;
        }

        bool IsTargetInBounds(Unit const* victim) const
        {
            if (!victim || victim->GetPositionX() < SartharionBoundary[0] || victim->GetPositionX() > SartharionBoundary[1] || victim->GetPositionY() > SartharionBoundary[3])
            {
                return false;
            }

            // Big island handling
            if (victim->GetPositionY() < SartharionBoundary[2])
            {
                return victim->GetDistance(bigIslandMiddlePos) <= 6.0f;
            }

            return true;
        }

        EventMap extraEvents;
        std::list<uint32> volcanoBlows;
        uint8 dragonsCount;
        uint8 lastLavaSide; // 0 = left, 1 = right
        bool usedBerserk;
        bool below11PctReached;
    };
};

struct boss_sartharion_dragonAI : public BossAI
{
    boss_sartharion_dragonAI(Creature* pCreature, uint32 bossId) : BossAI(pCreature, bossId), isCalledBySartharion(false)
    {
    }

    void Reset() override
    {
        _Reset();
        events.Reset();
        ClearInstance();

        me->SetImmuneToNPC(false);
        me->SetSpeed(MOVE_FLIGHT, 1.0f);
        me->SetCanFly(false);
        me->ResetLootMode();
        portalGUID.Clear();
        isCalledBySartharion = false;
        instance->DoAction(ACTION_CLEAR_PORTAL);
    }

    void DoAction(int32 param) final
    {
        if (param == ACTION_CALL_DRAGON && !isCalledBySartharion)
        {
            isCalledBySartharion = true;
            extraEvents.RescheduleEvent(EVENT_MINIDRAKE_SPEECH, 4s);
        }
    }

    void MoveInLineOfSight(Unit* who) final
    {
        if (isCalledBySartharion)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void MovementInform(uint32 type, uint32 pointId) final
    {
        if (type != WAYPOINT_MOTION_TYPE)
        {
            return;
        }

        switch (me->GetEntry())
        {
            case NPC_TENEBRON:
            {
                if (pointId != POINT_FINAL_TENEBRON)
                {
                    return;
                }
                break;
            }
            case NPC_SHADRON:
            {
                if (pointId != POINT_FINAL_SHADRON)
                {
                    return;
                }
                break;
            }
            case NPC_VESPERON:
            {
                if (pointId != POINT_FINAL_VESPERON)
                {
                    return;
                }
                break;
            }
        }

        me->SetImmuneToNPC(false);
        me->SetInCombatWithZone();
    }

    void JustSummoned(Creature* summon) override
    {
        // Transfer summons to Sartharion
        if (isCalledBySartharion && instance->GetBossState(DATA_SARTHARION) == IN_PROGRESS)
        {
            if (Creature* sartharion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SARTHARION)))
            {
                sartharion->AI()->JustSummoned(summon);
            }
        }

        BossAI::JustSummoned(summon);
    }

    void JustEngagedWith(Unit* /*who*/) final
    {
        me->setActive(true);
        DoZoneInCombat();
        Talk(SAY_TENEBRON_AGGRO);

        if (me->IsFlying())
        {
            me->SetSpeed(MOVE_FLIGHT, 1.0f);
            me->SetCanFly(false);
        }

        if (!isCalledBySartharion || instance->GetBossState(DATA_SARTHARION) != IN_PROGRESS)
        {
            switch (me->GetEntry())
            {
                case NPC_TENEBRON:
                {
                    instance->SetBossState(DATA_TENEBRON, IN_PROGRESS);
                    break;
                }
                case NPC_SHADRON:
                {
                    instance->SetBossState(DATA_SHADRON, IN_PROGRESS);
                    break;
                }
                case NPC_VESPERON:
                {
                    instance->SetBossState(DATA_VESPERON, IN_PROGRESS);
                    break;
                }
            }
        }

        if (isCalledBySartharion || instance->GetBossState(DATA_SARTHARION) == DONE)
        {
            me->SetLootMode(0);
        }

        if (isCalledBySartharion)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1, 500, true))
            {
                AttackStart(target);
            }
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        //_JustDied();
        events.Reset();

        // Despawn minions only if not called by Sartharion
        if (!isCalledBySartharion)
        {
            summons.DespawnAll();
        }

        switch (me->GetEntry())
        {
            case NPC_TENEBRON:
            {
                Talk(SAY_TENEBRON_DEATH);
                if (!isCalledBySartharion || instance->GetBossState(DATA_SARTHARION) != IN_PROGRESS)
                {
                    instance->SetBossState(DATA_TENEBRON, DONE);
                }
                break;
            }
            case NPC_SHADRON:
            {
                Talk(SAY_SHADRON_DEATH);
                if (isCalledBySartharion)
                {
                    if (Creature* sartharion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SARTHARION)))
                    {
                        sartharion->RemoveAura(SPELL_GIFT_OF_TWILIGHT_FIRE);
                    }
                }

                if (!isCalledBySartharion || instance->GetBossState(DATA_SARTHARION) != IN_PROGRESS)
                {
                    instance->SetBossState(DATA_SHADRON, DONE);
                }
                break;
            }
            case NPC_VESPERON:
            {
                Talk(SAY_VESPERON_DEATH);
                instance->DoAction(ACTION_CLEAR_PORTAL);
                if (!isCalledBySartharion || instance->GetBossState(DATA_SARTHARION) != IN_PROGRESS)
                {
                    instance->SetBossState(DATA_VESPERON, DONE);
                }
                break;
            }
        }

        if (!isCalledBySartharion)
        {
            ClearInstance();
        }
        else
        {
            if (Creature* sartharion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SARTHARION)))
            {
                sartharion->AI()->DoAction(ACTION_DRAKE_DIED);
            }
        }
    }

    void KilledUnit(Unit* victim) final
    {
        if (!victim->IsPlayer() || urand(0, 2))
        {
            return;
        }

        switch (me->GetEntry())
        {
            case NPC_TENEBRON:
            {
                Talk(SAY_TENEBRON_SLAY);
                break;
            }
            case NPC_SHADRON:
            {
                Talk(SAY_SHADRON_SLAY);
                break;
            }
            case NPC_VESPERON:
            {
                Talk(SAY_VESPERON_SLAY);
                break;
            }
        }
    }

    void UpdateAI(uint32 diff) final
    {
        extraEvents.Update(diff);
        while (uint32 const eventId = extraEvents.ExecuteEvent())
        {
            HandleExtraEvent(eventId);
        }

        if (!UpdateVictim())
        {
            return;
        }

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        while (uint32 const eventId = events.ExecuteEvent())
        {
            ExecuteEvent(eventId);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }
        }

        DoMeleeAttackIfReady();
    }

    virtual void ClearInstance()
    {
        events.Reset();
        summons.DespawnAll();
        // Remove phase shift
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
        RemoveTwilightPortal();
    }

    virtual void HandleExtraEvent(uint32 const /*eventId*/) { }
protected:
    void RemoveTwilightPortal()
    {
        if (portalGUID)
        {
            if (GameObject* gobj = me->GetMap()->GetGameObject(portalGUID))
            {
                gobj->Delete();
            }

            portalGUID.Clear();
        }
    }

    EventMap extraEvents;
    ObjectGuid portalGUID;
    bool isCalledBySartharion;
};

/////////////////////////////
// TENEBRON
/////////////////////////////

class boss_sartharion_tenebron : public CreatureScript
{
public:
    boss_sartharion_tenebron() : CreatureScript("boss_sartharion_tenebron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetObsidianSanctumAI<boss_sartharion_tenebronAI>(pCreature);
    }

    struct boss_sartharion_tenebronAI : public boss_sartharion_dragonAI
    {
        boss_sartharion_tenebronAI(Creature* pCreature) : boss_sartharion_dragonAI(pCreature, DATA_TENEBRON), summons2(pCreature)
        {
        }

        void Reset() override
        {
            boss_sartharion_dragonAI::Reset();
            if (!isCalledBySartharion)
            {
                summons2.DespawnAll();
            }

            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_FISSURE, 20s);
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_BREATH, 10s);
            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 15s);
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() != NPC_TWILIGHT_EGG)
            {
                summons.Summon(summon);
            }
            // Summons to Sartharion are linked manually
        }

        void JustDied(Unit* killer) override
        {
            if (!isCalledBySartharion)
            {
                summons2.DespawnAll();
            }

            boss_sartharion_dragonAI::JustDied(killer);
        }

        void HandleExtraEvent(uint32 const eventId) override
        {
            if (eventId == EVENT_MINIDRAKE_SPEECH)
            {
                Talk(SAY_TENEBRON_RESPOND);
                me->SetCanFly(true);
                me->SetSpeed(MOVE_FLIGHT, 3.0f);
                me->GetMotionMaster()->MovePath(me->GetEntry() * 10, false);
            }
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_MINIBOSS_SHADOW_BREATH:
                {
                    if (!urand(0, 10))
                    {
                        Talk(SAY_TENEBRON_BREATH);
                    }
                    DoCastVictim(SPELL_SHADOW_BREATH, false);
                    events.RepeatEvent(17500);
                    break;
                }
                case EVENT_MINIBOSS_SHADOW_FISSURE:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                    {
                        DoCast(target, SPELL_SHADOW_FISSURE, false);
                    }
                    events.RepeatEvent(22500);
                    break;
                }
                case EVENT_MINIBOSS_OPEN_PORTAL:
                {
                    Talk(WHISPER_OPEN_PORTAL);
                    Talk(SAY_TENEBRON_SPECIAL);

                    if (!isCalledBySartharion)
                    {
                        if (GameObject* Portal = me->GetVictim()->SummonGameObject(GO_TWILIGHT_PORTAL, portalPos[DATA_TENEBRON].GetPositionX(), portalPos[DATA_TENEBRON].GetPositionY(), portalPos[DATA_TENEBRON].GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                        {
                            portalGUID = Portal->GetGUID();
                        }
                    }
                    else
                    {
                        instance->DoAction(ACTION_ADD_PORTAL);
                    }

                    events.ScheduleEvent(EVENT_MINIBOSS_SPAWN_HELPERS, 2s);
                    events.Repeat(60s);
                    break;
                }
                case EVENT_MINIBOSS_SPAWN_HELPERS:
                {
                    Talk(WHISPER_HATCH_EGGS);
                    for (uint8 i = 0; i < MAX_TENEBORN_EGGS_SUMMONS; ++i)
                    {
                        if (Creature* egg = me->SummonCreature(NPC_TWILIGHT_EGG, TenebronEggsPos[isCalledBySartharion ? 1 : 0][i], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000))
                        {
                            summons.Summon(egg);
                            if (isCalledBySartharion && instance->GetBossState(DATA_SARTHARION) == IN_PROGRESS)
                            {
                                if (Creature* sartharion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SARTHARION)))
                                {
                                    sartharion->AI()->JustSummoned(egg);
                                }
                            }
                            egg->SetPhaseMask(16, true);
                        }
                    }

                    events.ScheduleEvent(EVENT_MINIBOSS_HATCH_EGGS, 25s);
                    break;
                }
                case EVENT_MINIBOSS_HATCH_EGGS:
                {
                    summons.RemoveNotExisting();
                    summons.DespawnEntry(NPC_TWILIGHT_WHELP);
                    for (ObjectGuid const& summonGuid : summons)
                    {
                        Creature const* summon = ObjectAccessor::GetCreature(*me, summonGuid);
                        if (!summon || !summon->IsAlive() || summon->GetEntry() != NPC_TWILIGHT_EGG)
                        {
                            continue;
                        }

                        if (Creature* whelp = me->SummonCreature(NPC_TWILIGHT_WHELP, summon->GetPosition(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000))
                        {
                            summons2.Summon(whelp);
                            if (isCalledBySartharion && instance->GetBossState(DATA_SARTHARION) == IN_PROGRESS)
                            {
                                if (Creature* sartharion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SARTHARION)))
                                {
                                    sartharion->AI()->JustSummoned(whelp);
                                }
                            }
                        }
                    }

                    if (!isCalledBySartharion)
                    {
                        // Remove phase shift
                        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
                        RemoveTwilightPortal();
                    }
                    else
                    {
                        instance->DoAction(ACTION_CLEAR_PORTAL);
                    }

                    EntryCheckPredicate pred(NPC_TWILIGHT_EGG);
                    summons.DoAction(ACTION_SWITCH_PHASE, pred);
                    break;
                }
            }
        }

        void ClearInstance() override
        {
            boss_sartharion_dragonAI::ClearInstance();
            summons2.DespawnAll();
        }

    private:
        SummonList summons2;
    };
};

/////////////////////////////
// SHADRON
/////////////////////////////

class boss_sartharion_shadron : public CreatureScript
{
public:
    boss_sartharion_shadron() : CreatureScript("boss_sartharion_shadron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetObsidianSanctumAI<boss_sartharion_shadronAI>(pCreature);
    }

    struct boss_sartharion_shadronAI : public boss_sartharion_dragonAI
    {
        boss_sartharion_shadronAI(Creature* pCreature) : boss_sartharion_dragonAI(pCreature, DATA_SHADRON)
        {
        }

        void Reset() override
        {
            boss_sartharion_dragonAI::Reset();
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_FISSURE, 20s);
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_BREATH, 10s);
            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 15s);
        }

        void SummonedCreatureDies(Creature* /*summon*/, Unit* /*summon*/) override
        {
            if (isCalledBySartharion)
            {
                // Acolytes are dead
                if (!summons.HasEntry(NPC_ACOLYTE_OF_SHADRON))
                {
                    instance->DoAction(ACTION_CLEAR_PORTAL);
                }

                if (Creature* sartharion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SARTHARION)))
                {
                    sartharion->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGHT_FIRE);
                }
            }
            else
            {
                ClearInstance();
                me->RemoveAura(SPELL_GIFT_OF_TWILIGHT_SHADOW);
            }

            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 30s);
        }

        void HandleExtraEvent(uint32 const eventId) override
        {
            if (eventId == EVENT_MINIDRAKE_SPEECH)
            {
                Talk(SAY_SHADRON_RESPOND);
                me->SetCanFly(true);
                me->SetSpeed(MOVE_FLIGHT, 3.0f);
                me->GetMotionMaster()->MovePath(me->GetEntry() * 10, false);
            }
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_MINIBOSS_SHADOW_BREATH:
                {
                    if (!urand(0, 10))
                    {
                        Talk(SAY_SHADRON_BREATH);
                    }

                    DoCastVictim(SPELL_SHADOW_BREATH, false);
                    events.RepeatEvent(17500);
                    break;
                }
                case EVENT_MINIBOSS_SHADOW_FISSURE:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                    {
                        DoCast(target, SPELL_SHADOW_FISSURE, false);
                    }
                    events.RepeatEvent(22500);
                    break;
                }
                case EVENT_MINIBOSS_OPEN_PORTAL:
                {
                    Talk(WHISPER_OPEN_PORTAL);
                    Talk(SAY_SHADRON_SPECIAL);
                    if (!isCalledBySartharion)
                    {
                        if (GameObject* Portal = me->GetVictim()->SummonGameObject(GO_TWILIGHT_PORTAL, portalPos[DATA_SHADRON].GetPositionX(), portalPos[DATA_SHADRON].GetPositionY(), portalPos[DATA_SHADRON].GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                        {
                            portalGUID = Portal->GetGUID();
                        }
                    }
                    else
                    {
                        instance->DoAction(ACTION_ADD_PORTAL);
                    }

                    events.ScheduleEvent(EVENT_MINIBOSS_SPAWN_HELPERS, 2s);
                    break;
                }
                case EVENT_MINIBOSS_SPAWN_HELPERS:
                {
                    Talk(WHISPER_SUMMON_DICIPLE);
                    DoCastAOE(static_cast<uint32>((isCalledBySartharion ? SPELL_GIFT_OF_TWILIGHT_FIRE : SPELL_GIFT_OF_TWILIGHT_SHADOW)), true);

                    if (Creature* acolyte = me->SummonCreature((isCalledBySartharion ? NPC_ACOLYTE_OF_SHADRON : NPC_DISCIPLE_OF_SHADRON), me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        /// @todo: inpect JustSummoned
                        summons.Summon(acolyte);
                        acolyte->SetPhaseMask(16, true);
                    }

                    break;
                }
            }
        }
    };
};

/////////////////////////////
// VESPERON
/////////////////////////////

class boss_sartharion_vesperon : public CreatureScript
{
public:
    boss_sartharion_vesperon() : CreatureScript("boss_sartharion_vesperon") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetObsidianSanctumAI<boss_sartharion_vesperonAI>(pCreature);
    }

    struct boss_sartharion_vesperonAI : public boss_sartharion_dragonAI
    {
        boss_sartharion_vesperonAI(Creature* pCreature) : boss_sartharion_dragonAI(pCreature, DATA_VESPERON)
        {
        }

        void Reset() override
        {
            boss_sartharion_dragonAI::Reset();
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_FISSURE, 20s);
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_BREATH, 10s);
            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 30s);
        }

        void SummonedCreatureDies(Creature* /*summon*/, Unit* /*killer*/) override
        {
            if (!isCalledBySartharion)
            {
                ClearInstance();
            }
            else
            {
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_TORMENT_SARTHARION);
                instance->DoAction(ACTION_CLEAR_PORTAL);
            }

            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 30s);
        }

        void HandleExtraEvent(uint32 const eventId) override
        {
            if (eventId == EVENT_MINIDRAKE_SPEECH)
            {
                Talk(SAY_SHADRON_RESPOND);
                me->SetCanFly(true);
                me->SetSpeed(MOVE_FLIGHT, 3.0f);
                me->GetMotionMaster()->MovePath(me->GetEntry() * 10, false);
            }
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_MINIBOSS_SHADOW_BREATH:
                {
                    if (!urand(0, 10))
                    {
                        Talk(SAY_SHADRON_BREATH);
                    }

                    DoCastVictim(SPELL_SHADOW_BREATH, false);
                    events.Repeat(17s + 500ms);
                    break;
                }
                case EVENT_MINIBOSS_SHADOW_FISSURE:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                    {
                        DoCast(target, SPELL_SHADOW_FISSURE, false);
                    }

                    events.Repeat(22s + 500ms);
                    break;
                }
                case EVENT_MINIBOSS_OPEN_PORTAL:
                {
                    Talk(WHISPER_OPEN_PORTAL);
                    Talk(SAY_VESPERON_SPECIAL);
                    if (!isCalledBySartharion)
                    {
                        if (GameObject* Portal = me->GetVictim()->SummonGameObject(GO_TWILIGHT_PORTAL, portalPos[DATA_VESPERON].GetPositionX(), portalPos[DATA_VESPERON].GetPositionY(), portalPos[DATA_VESPERON].GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                        {
                            portalGUID = Portal->GetGUID();
                        }
                    }
                    else
                    {
                        instance->DoAction(ACTION_ADD_PORTAL);
                    }

                    events.ScheduleEvent(EVENT_MINIBOSS_SPAWN_HELPERS, 2s);
                    break;
                }
                case EVENT_MINIBOSS_SPAWN_HELPERS:
                {
                    Talk(WHISPER_SUMMON_DICIPLE);
                    DoCastSelf(isCalledBySartharion ? static_cast<uint32>(SPELL_TWILIGHT_TORMENT_SARTHARION) : static_cast<uint32>(SPELL_TWILIGHT_TORMENT_VESPERON), true);
                    if (Creature* acolyte = me->SummonCreature((isCalledBySartharion ? NPC_ACOLYTE_OF_VESPERON : NPC_DISCIPLE_OF_VESPERON), me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        summons.Summon(acolyte);
                        acolyte->SetPhaseMask(16, true);
                    }

                    break;
                }
            }
        }

    private:
        void ClearInstance() override
        {
            boss_sartharion_dragonAI::ClearInstance();

            // Remove phase shift
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_TORMENT_VESPERON);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_TORMENT_SARTHARION);
        }
    };
};

// other
class npc_twilight_summon : public CreatureScript
{
public:
    npc_twilight_summon() : CreatureScript("npc_twilight_summon") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetObsidianSanctumAI<npc_twilight_summonAI>(pCreature);
    }

    struct npc_twilight_summonAI : public ScriptedAI
    {
        npc_twilight_summonAI(Creature* pCreature) : ScriptedAI(pCreature),
            fadeArmorTimer(urand(0, 15000))
        {
        }

        void Reset() override
        {
            fadeArmorTimer = urand(0, 15000);
            if (me->GetEntry() == NPC_TWILIGHT_EGG)
            {
                me->SetControlled(true, UNIT_STATE_STUNNED);
            }
            else
            {
                me->SetInCombatWithZone();
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_SWITCH_PHASE)
            {
                me->DespawnOrUnsummon(1);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || me->GetEntry() == NPC_TWILIGHT_EGG)
            {
                return;
            }

            fadeArmorTimer += diff;
            if (fadeArmorTimer >= 15000)
            {
                if (Aura* aur = me->GetVictim()->GetAura(SPELL_FADE_ARMOR))
                {
                    aur->ModStackAmount(1);
                }
                else
                {
                    DoCastVictim(SPELL_FADE_ARMOR, false);
                }

                fadeArmorTimer = 0;
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint32 fadeArmorTimer;
    };
};

class spell_sartharion_lava_strike : public SpellScript
{
    PrepareSpellScript(spell_sartharion_lava_strike);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LAVA_STRIKE_SUMMON, SPELL_LAVA_STRIKE_DUMMY_TRIGGER });
    }

    bool Load() override
    {
        _spawned = false;
        return true;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (!GetCaster() || !GetHitUnit())
        {
            return;
        }

        GetCaster()->CastSpell(GetHitUnit()->GetPositionX(), GetHitUnit()->GetPositionY(), GetHitUnit()->GetPositionZ(), SPELL_LAVA_STRIKE_DUMMY_TRIGGER, true);
    }

    void HandleSchoolDamage(SpellEffIndex /*effIndex*/)
    {
        if (!GetCaster() || !GetHitUnit() || _spawned)
        {
            return;
        }

        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
        {
            if (Creature* sarth = ObjectAccessor::GetCreature(*GetHitUnit(), instance->GetGuidData(DATA_SARTHARION)))
            {
                sarth->AI()->SetData(DATA_VOLCANO_BLOWS, GetHitUnit()->GetGUID().GetCounter());
                sarth->CastSpell(GetHitUnit(), SPELL_LAVA_STRIKE_SUMMON, true);
                _spawned = true;
            }
        }
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_LAVA_STRIKE_DUMMY)
        {
            OnEffectHitTarget += SpellEffectFn(spell_sartharion_lava_strike::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
        else
        {
            OnEffectHitTarget += SpellEffectFn(spell_sartharion_lava_strike::HandleSchoolDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    }

private:
    bool _spawned;
};

// 57491 - Flame Tsunami
class spell_obsidian_sanctum_flame_tsunami : public SpellScript
{
    PrepareSpellScript(spell_obsidian_sanctum_flame_tsunami);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLAME_TSUNAMI_LEAP });
    }

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            if (!target->HasAura(SPELL_FLAME_TSUNAMI_LEAP))
            {
                target->CastSpell(target, SPELL_FLAME_TSUNAMI_LEAP, true);
                bool isFacingSouth = std::fabs(GetCaster()->GetOrientation() - M_PI) < M_PI / 4;
                target->KnockbackFrom(isFacingSouth ? 3283.44f : 3208.44f , target->GetPositionY(), 12.5f, 9.0f);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_obsidian_sanctum_flame_tsunami::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 60241 - Flame Tsunami
class spell_obsidian_sanctum_flame_tsunami_leap : public SpellScript
{
    PrepareSpellScript(spell_obsidian_sanctum_flame_tsunami_leap);

    void HandleLeapBack(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_obsidian_sanctum_flame_tsunami_leap::HandleLeapBack, EFFECT_0, SPELL_EFFECT_LEAP_BACK);
    }
};

void AddSC_boss_sartharion()
{
    new boss_sartharion();
    new boss_sartharion_shadron();
    new boss_sartharion_tenebron();
    new boss_sartharion_vesperon();
    new npc_twilight_summon();
    RegisterSpellScript(spell_sartharion_lava_strike);
    RegisterSpellScript(spell_obsidian_sanctum_flame_tsunami);
    RegisterSpellScript(spell_obsidian_sanctum_flame_tsunami_leap);
}
