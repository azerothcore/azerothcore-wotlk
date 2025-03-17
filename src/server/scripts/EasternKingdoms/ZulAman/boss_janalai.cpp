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

#include "CellImpl.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "zulaman.h"

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_FIRE_BOMBS              = 1,
    SAY_SUMMON_HATCHER          = 2,
    SAY_ALL_EGGS                = 3,
    SAY_BERSERK                 = 4,
    SAY_SLAY                    = 5,
    SAY_DEATH                   = 6,
    SAY_EVENT_STRANGERS         = 7,
    SAY_EVENT_FRIENDS           = 8
};

enum Spells
{
    // Jan'alai
    SPELL_FLAME_BREATH          = 43140,
    SPELL_FIRE_WALL             = 43113,
    SPELL_ENRAGE                = 44779,
    SPELL_SUMMON_PLAYERS_DUMMY  = 43096,
    SPELL_SUMMON_PLAYERS        = 43097,
    SPELL_TELE_TO_CENTER        = 43098, // coord
    SPELL_HATCH_ALL             = 43144,
    SPELL_BERSERK               = 45078,

    // Fire Bob Spells
    SPELL_FIRE_BOMB_CHANNEL     = 42621, // last forever
    SPELL_FIRE_BOMB_THROW       = 42628, // throw visual
    SPELL_FIRE_BOMB_DUMMY       = 42629, // bomb visual
    SPELL_FIRE_BOMB_DAMAGE      = 42630,

    // Hatcher Spells
    SPELL_HATCH_EGG_ALL         = 42471,
    SPELL_HATCH_EGG_SINGULAR    = 43734,
    SPELL_SUMMON_HATCHLING      = 42493,

    // Hatchling Spells
    SPELL_FLAMEBUFFET           = 43299
};

enum Creatures
{
    NPC_AMANI_HATCHER           = 23818,
    NPC_EGG                     = 23817,
    NPC_FIRE_BOMB               = 23920
};

const int area_dx = 44;
const int area_dy = 51;

const Position janalainPos = {-33.93f, 1149.27f, 19.0f, 0.0f};

const Position fireWallCoords[4] =
{
    {-10.13f, 1149.27f, 19, 3.1415f},
    {-33.93f, 1123.90f, 19, 0.5f * 3.1415f},
    {-54.80f, 1150.08f, 19, 0.0f},
    {-33.93f, 1175.68f, 19, 1.5f * 3.1415f}
};

const Position hatcherway[2][5] =
{
    {
        {-87.46f, 1170.09f, 6.0f, 0.0f},
        {-74.41f, 1154.75f, 6.0f, 0.0f},
        {-52.74f, 1153.32f, 19.0f, 0.0f},
        {-33.37f, 1172.46f, 19.0f, 0.0f},
        {-33.09f, 1203.87f, 19.0f, 0.0f}
    },
    {
        {-86.57f, 1132.85f, 6.0f, 0.0f},
        {-73.94f, 1146.00f, 6.0f, 0.0f},
        {-52.29f, 1146.51f, 19.0f, 0.0f},
        {-33.57f, 1125.72f, 19.0f, 0.0f},
        {-34.29f, 1095.22f, 19.0f, 0.0f}
    }
};

enum HatchActions
{
    HATCH_RESET = 0,
    HATCH_ALL   = 1
};

enum Misc
{
    MAX_BOMB_COUNT              = 40,
    GROUP_ENRAGE                = 1,
    GROUP_HATCHING              = 2,
    DATA_ALL_EGGS_HATCHED       = 0
};

struct boss_janalai : public BossAI
{
    boss_janalai(Creature* creature) : BossAI(creature, DATA_JANALAI)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        HatchAllEggs(HATCH_RESET);
        _isBombing = false;
        _isFlameBreathing = false;

        ScheduleHealthCheckEvent(35, [&]{
            Talk(SAY_ALL_EGGS);
            me->AttackStop();
            me->GetMotionMaster()->Clear();
            me->SetPosition(janalainPos);
            me->StopMovingOnCurrentPos();
            DoCastAOE(SPELL_HATCH_ALL);
        });

        ScheduleHealthCheckEvent(20, [&] {
            if (!me->HasAura(SPELL_ENRAGE))
                DoCastSelf(SPELL_ENRAGE, true);
            me->m_Events.CancelEventGroup(GROUP_ENRAGE);
        });

        me->m_Events.KillAllEvents(false);
        _sideHatched[0] = false;
        _sideHatched[1] = false;
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() == NPC_AMANI_HATCHLING)
        {
            if (summon->GetPositionY() > 1150)
                summon->GetMotionMaster()->MovePoint(0, hatcherway[0][3].GetPositionX() + rand() % 4 - 2, 1150.0f + rand() % 4 - 2, hatcherway[0][3].GetPositionY());
            else
                summon->GetMotionMaster()->MovePoint(0, hatcherway[1][3].GetPositionX() + rand() % 4 - 2, 1150.0f + rand() % 4 - 2, hatcherway[1][3].GetPositionY());
        }

        BossAI::JustSummoned(summon);
    }

    void DamageDealt(Unit* target, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (_isFlameBreathing)
        {
            if (!me->HasInArc(M_PI / 6, target))
                damage = 0;
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        //schedule abilities
        ScheduleTimedEvent(30s, [&]{
            StartBombing();
        }, 20s, 40s);

        scheduler.Schedule(10s, GROUP_HATCHING, [this](TaskContext context)
        {
            if (_sideHatched[0] && _sideHatched[1])
                return;

            Talk(SAY_SUMMON_HATCHER);

            if (_sideHatched[0] && !_sideHatched[1])
            {
                me->SummonCreature(NPC_AMANI_HATCHER, hatcherway[1][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                me->SummonCreature(NPC_AMANI_HATCHER, hatcherway[1][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
            }
            else if (!_sideHatched[0] && _sideHatched[1])
            {
                me->SummonCreature(NPC_AMANI_HATCHER, hatcherway[0][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                me->SummonCreature(NPC_AMANI_HATCHER, hatcherway[0][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
            }
            else
            {
                me->SummonCreature(NPC_AMANI_HATCHER, hatcherway[0][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                me->SummonCreature(NPC_AMANI_HATCHER, hatcherway[1][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
            }

            context.Repeat(90s);
        });

        ScheduleTimedEvent(8s, [&]{
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
            {
                me->AttackStop();
                me->GetMotionMaster()->Clear();
                DoCast(target, SPELL_FLAME_BREATH);
                me->StopMoving();
                _isFlameBreathing = true;
                // placeholder time idk yet
                scheduler.Schedule(2s, [this](TaskContext)
                {
                    _isFlameBreathing = false;
                });
            }
        }, 8s);

        me->m_Events.AddEventAtOffset([&] {
            DoCastSelf(SPELL_ENRAGE, true);
        }, 5min, 5min, GROUP_ENRAGE);

        me->m_Events.AddEventAtOffset([&] {
            Talk(SAY_BERSERK);
            DoCastSelf(SPELL_BERSERK);
        }, 10min);
    }

    void SetData(uint32 index, uint32 data) override
    {
        if (index == DATA_ALL_EGGS_HATCHED)
            _sideHatched[data] = true;
    }

    bool HatchAllEggs(uint32 hatchAction)
    {
        std::list<Creature* > eggList;
        me->GetCreaturesWithEntryInRange(eggList, 100.0f, NPC_EGG);
        if (eggList.empty())
            return false;

        if (hatchAction == HATCH_RESET)
        {
            for (Creature* egg : eggList)
                egg->Respawn();

            summons.DespawnEntry(NPC_AMANI_HATCHLING);
        }
        else if (hatchAction == HATCH_ALL)
            DoCastSelf(SPELL_HATCH_EGG_ALL);

        eggList.clear();
        return true;
    }

    void FireWall()
    {
        for (uint8 i = 0; i < 4; ++i)
        {
            uint8 wallNum = i == 0 || i == 2 ? 3 : 2;

            for (uint8 j = 0; j < wallNum; j++)
            {
                Creature* wall = wallNum == 3
                        ? me->SummonCreature(NPC_FIRE_BOMB, fireWallCoords[i].GetPositionX(), fireWallCoords[i].GetPositionY() + 5 * (j - 1), fireWallCoords[i].GetPositionZ(), fireWallCoords[i].GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 15000)
                        : me->SummonCreature(NPC_FIRE_BOMB, fireWallCoords[i].GetPositionX() - 2 + 4 * j, fireWallCoords[i].GetPositionY(), fireWallCoords[i].GetPositionZ(), fireWallCoords[i].GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 15000);

                if (wall)
                    wall->AI()->DoCastSelf(SPELL_FIRE_WALL, true);
            }
        }
    }

    void SpawnBombs()
    {
        float dx, dy;
        for (int i = 0; i < MAX_BOMB_COUNT; ++i)
        {
            dx = float(irand(-area_dx / 2, area_dx / 2));
            dy = float(irand(-area_dy / 2, area_dy / 2));
            DoSpawnCreature(NPC_FIRE_BOMB, dx, dy, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 15000);
        }
    }

    void Boom()
    {
        summons.DoForAllSummons([&](WorldObject* summon) {
            if (summon->GetEntry() == NPC_FIRE_BOMB)
            {
                if (Creature* bomb = summon->ToCreature())
                {
                    bomb->AI()->DoCastSelf(SPELL_FIRE_BOMB_DAMAGE, true);
                    bomb->RemoveAllAuras();
                }
            }
        });
    }

    void StartBombing()
    {
        Talk(SAY_FIRE_BOMBS);
        me->AttackStop();
        me->GetMotionMaster()->Clear();
        me->SetPosition(janalainPos);
        me->StopMovingOnCurrentPos();
        DoCastSelf(SPELL_FIRE_BOMB_CHANNEL);

        FireWall();
        SpawnBombs();
        _isBombing = true;

        DoCastSelf(SPELL_TELE_TO_CENTER);
        DoCastAOE(SPELL_SUMMON_PLAYERS_DUMMY, true);

        //DoCast(Temp, SPELL_SUMMON_PLAYERS, true) // core bug, spell does not work if too far
        ThrowBombs();

        scheduler.Schedule(11s, [this](TaskContext)
        {
            Boom();
            _isBombing = false;

            me->RemoveAurasDueToSpell(SPELL_FIRE_BOMB_CHANNEL);
        });
    }

    void ThrowBombs()
    {
        std::chrono::milliseconds bombTimer = 100ms;

        summons.DoForAllSummons([this, &bombTimer](WorldObject* summon) {
            if (summon->GetEntry() == NPC_FIRE_BOMB)
            {
                if (Creature* bomb = summon->ToCreature())
                {
                    bomb->m_Events.AddEventAtOffset([this, bomb] {
                        bomb->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        DoCast(bomb, SPELL_FIRE_BOMB_THROW, true);
                        bomb->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    }, bombTimer);
                }

                bombTimer += 100ms;
            }
        });
    }

    bool CheckEvadeIfOutOfCombatArea() const override
    {
        return me->GetPositionZ() <= 12.0f;
    }
private:
    bool _isBombing;
    bool _isFlameBreathing;
    bool _sideHatched[2];
};

struct npc_janalai_hatcher : public ScriptedAI
{
    npc_janalai_hatcher(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        ScriptedAI::Reset();
        scheduler.CancelAll();
        _side = (me->GetPositionY() < 1150);
        _waypoint = 0;
        _repeatCount = 1;
        _isHatching = false;
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MovePoint(0, hatcherway[_side][0]);
    }

    void MovementInform(uint32, uint32) override
    {
        if (_waypoint == 5)
        {
            _isHatching = true;

            scheduler.Schedule(1500ms, [this](TaskContext context)
            {
                me->CastCustomSpell(SPELL_HATCH_EGG_ALL, SPELLVALUE_MAX_TARGETS, _repeatCount);

                ++_repeatCount;

                if (me->FindNearestCreature(NPC_EGG, 100.0f))
                    context.Repeat(5s);
                else
                {
                    if (WorldObject* summoner = GetSummoner())
                        if (Creature* janalai = summoner->ToCreature())
                            janalai->AI()->SetData(DATA_ALL_EGGS_HATCHED, _side);

                    _side = _side ? 0 : 1;
                    _isHatching = false;
                    _waypoint = 3;
                    MoveToNewWaypoint(_waypoint);
                }
            });
        }
        else
        {
            MoveToNewWaypoint(_waypoint);
            ++_waypoint;
        }
    }

    void MoveToNewWaypoint(uint8 waypoint)
    {
        if (!_isHatching)
        {
            scheduler.Schedule(100ms, [this, waypoint](TaskContext)
            {
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, hatcherway[_side][waypoint]);
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

    void JustEngagedWith(Unit* /*who*/) override { }
    void AttackStart(Unit* /*who*/) override { }
    void MoveInLineOfSight(Unit* /*who*/) override { }

private:
    uint8 _side;
    uint8 _waypoint;
    uint32 _repeatCount;
    bool _isHatching;
};

class spell_summon_all_players_dummy: public SpellScript
{
    PrepareSpellScript(spell_summon_all_players_dummy);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_PLAYERS });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Position pos = GetCaster()->GetPosition();
        targets.remove_if([&, pos](WorldObject* target) -> bool
        {
            return target->IsWithinBox(pos, 22.0f, 28.0f, 28.0f);
        });
    }

    void OnHit(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), SPELL_SUMMON_PLAYERS, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_summon_all_players_dummy::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_summon_all_players_dummy::OnHit, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_janalai()
{
    RegisterZulAmanCreatureAI(boss_janalai);
    RegisterZulAmanCreatureAI(npc_janalai_hatcher);
    RegisterSpellScript(spell_summon_all_players_dummy);
}
