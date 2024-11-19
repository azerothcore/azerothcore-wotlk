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
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "MiscPackets.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "ruins_of_ahnqiraj.h"

enum Texts
{
    SAY_SUPREME                 = 0,
    SAY_INTRO                   = 1,
    SAY_AGGRO                   = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4
};

enum Spells
{
    SPELL_CURSE_OF_TONGUES              = 25195,
    SPELL_ENVELOPING_WINDS              = 25189,
    SPELL_WAR_STOMP                     = 25188,
    SPELL_STRENGTH_OF_OSSIRIAN          = 25176,
    SPELL_SAND_STORM                    = 25160,
    SPELL_SUMMON_CRYSTAL                = 25192,
    SPELL_SUMMON_SMALL_OBSIDIAN_CHUNK   = 27627, // Server-side
    SPELL_SPEED_BURST                   = 25184, // Server-side

    // Crystal
    SPELL_FIRE_WEAKNESS                 = 25177,
    SPELL_FROST_WEAKNESS                = 25178,
    SPELL_NATURE_WEAKNESS               = 25180,
    SPELL_ARCANE_WEAKNESS               = 25181,
    SPELL_SHADOW_WEAKNESS               = 25183
};

enum Actions
{
    ACTION_TRIGGER_WEAKNESS     = 1,
    ACTION_DESPAWN_TRIGGER      = 2
};

enum Events
{
    EVENT_SILENCE               = 1,
    EVENT_CYCLONE               = 2,
    EVENT_STOMP                 = 3,
    EVENT_SPEEDUP               = 4
};

enum Misc
{
    GUID_TRIGGER_PAIR = 1,
};

uint8 const NUM_CRYSTALS = 12;
Position CrystalCoordinates[NUM_CRYSTALS] =
{
    { -9407.7197265625f, 1960.20996093750f, 85.6390991210937f, 1.11700999736786f },
    { -9388.4404296875f, 1940.20996093750f, 85.6390991210937f, 3.17650008201599f },
    { -9357.8603515625f, 1929.07995605469f, 85.6390991210937f, 1.06465005874634f },
    { -9383.2900390625f, 2012.68005371094f, 85.6511001586914f, 2.93214988708496f },
    { -9248.4101562500f, 1974.82995605469f, 85.6390991210937f, 5.89920997619629f },
    { -9432.4003906250f, 1782.53002929687f, 85.6390991210937f, 5.86430978775024f },
    { -9299.7304687500f, 1748.44995117187f, 85.6390991210937f, 1.44861996173859f },
    { -9406.0996093750f, 1862.38000488281f, 85.6390991210937f, 6.23082017898560f },
    { -9506.1904296875f, 1865.56994628906f, 85.6390991210937f, 4.27606010437012f },
    { -9282.0800781250f, 1887.33996582031f, 85.6390991210937f, 2.00712990760803f },
    { -9244.4101562500f, 1808.97998046875f, 85.6390991210937f, 5.63741016387939f },
    { -9367.1699218750f, 1780.89001464844f, 85.6390991210937f, 1.90241003036499f }
};

Position VortexPositions[2] =
{
    { -9524.06f, 1881.9224f, 85.64029f, 0.0f },
    { -9228.479, 1925.3331f, 85.64147f, 0.0f }
};

uint8 const NUM_WEAKNESS = 5;
uint32 const spellWeakness[NUM_WEAKNESS] =
{ SPELL_FIRE_WEAKNESS, SPELL_FROST_WEAKNESS, SPELL_NATURE_WEAKNESS, SPELL_ARCANE_WEAKNESS, SPELL_SHADOW_WEAKNESS };

struct boss_ossirian : public BossAI
{
    boss_ossirian(Creature* creature) : BossAI(creature, DATA_OSSIRIAN)
    {
        _saidIntro = false;
    }

    void InitializeAI() override
    {
        Reset();
    }

    void Reset() override
    {
        BossAI::Reset();

        _crystalIterator = urand(1, NUM_CRYSTALS - 1);

        if (!ObjectAccessor::GetGameObject(*me, _firstCrystalGUID))
        {
            if (Creature* trigger = me->GetMap()->SummonCreature(NPC_OSSIRIAN_TRIGGER, CrystalCoordinates[0]))
            {
                if (GameObject* crystal = me->SummonGameObject(GO_OSSIRIAN_CRYSTAL,
                    CrystalCoordinates[0].GetPositionX(),
                    CrystalCoordinates[0].GetPositionY(),
                    CrystalCoordinates[0].GetPositionZ(),
                    0, 0, 0, 0, 0, uint32(-1)))
                {
                    _firstCrystalGUID = crystal->GetGUID();
                    crystal->SetOwnerGUID(ObjectGuid::Empty);
                    crystal->RemoveGameObjectFlag(GO_FLAG_IN_USE);
                    crystal->AI()->SetGUID(trigger->GetGUID(), GUID_TRIGGER_PAIR);
                }
            }
        }
    }

    void JustSummoned(Creature* creature) override
    {
        summons.Summon(creature);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        for (uint32 weakness : spellWeakness)
        {
            if (spell->Id == weakness)
            {
                me->RemoveAurasDueToSpell(SPELL_STRENGTH_OF_OSSIRIAN);
            }
        }
    }

    void SetGUID(ObjectGuid guid, int32 action) override
    {
        if (action == ACTION_TRIGGER_WEAKNESS && guid != _firstCrystalGUID)
        {
            SpawnNextCrystal();
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        events.Reset();
        events.ScheduleEvent(EVENT_SPEEDUP, 10s);
        events.ScheduleEvent(EVENT_SILENCE, 30s);
        events.ScheduleEvent(EVENT_CYCLONE, 20s);
        events.ScheduleEvent(EVENT_STOMP, 30s);
        DoCastSelf(SPELL_STRENGTH_OF_OSSIRIAN);
        Talk(SAY_AGGRO);

        Map* map = me->GetMap();
        if (!map->IsDungeon())
            return;

        WorldPackets::Misc::Weather weather(WEATHER_STATE_HEAVY_SANDSTORM, 1.0f);
        map->SendToPlayers(weather.Write());

        SpawnNextCrystal(3);

        std::list<uint32> pathIds = { 1446800, 1446790 };

        for (Position pos : VortexPositions)
        {
            if (Creature* vortex = me->SummonCreature(NPC_SAND_VORTEX, pos))
            {
                vortex->GetMotionMaster()->MovePath(pathIds.front(), true);
                pathIds.reverse();
            }
        }
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        summons.Despawn(summon);

        if (summon->GetEntry() == NPC_OSSIRIAN_TRIGGER)
        {
            if (GameObject* crystal = GetClosestGameObjectWithEntry(summon, GO_OSSIRIAN_CRYSTAL, 5.0f))
            {
                crystal->Delete();
            }
        }
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void SpawnNextCrystal(uint8 count = 1)
    {
        for (uint8 i = 0; i < count; ++i)
        {
            if (_crystalIterator == NUM_CRYSTALS)
                _crystalIterator = 1;

            if (Creature* trigger = me->SummonCreature(NPC_OSSIRIAN_TRIGGER, CrystalCoordinates[_crystalIterator]))
            {
                if (GameObject* crystal = trigger->SummonGameObject(GO_OSSIRIAN_CRYSTAL,
                    CrystalCoordinates[_crystalIterator].GetPositionX(),
                    CrystalCoordinates[_crystalIterator].GetPositionY(),
                    CrystalCoordinates[_crystalIterator].GetPositionZ(),
                    0, 0, 0, 0, 0, uint32(-1)))
                {
                    ++_crystalIterator;
                    crystal->SetOwnerGUID(ObjectGuid::Empty);
                    crystal->RemoveGameObjectFlag(GO_FLAG_IN_USE);
                    crystal->AI()->SetGUID(trigger->GetGUID(), GUID_TRIGGER_PAIR);
                }
            }
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_saidIntro)
        {
            Talk(SAY_INTRO);
            _saidIntro = true;
        }

        BossAI::MoveInLineOfSight(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        bool applySupreme = true;
        if (me->HasAura(SPELL_STRENGTH_OF_OSSIRIAN))
        {
            applySupreme = false;
        }
        else
        {
            for (uint32 weakness : spellWeakness)
            {
                if (me->HasAura(weakness))
                {
                    applySupreme = false;
                    break;
                }
            }
        }

        if (applySupreme)
        {
            DoCastSelf(SPELL_STRENGTH_OF_OSSIRIAN);
            Talk(SAY_SUPREME);
        }

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SPEEDUP:
                    DoCastSelf(SPELL_SPEED_BURST);
                    break;
                case EVENT_SILENCE:
                    DoCastAOE(SPELL_CURSE_OF_TONGUES);
                    events.ScheduleEvent(EVENT_SILENCE, 20s, 30s);
                    break;
                case EVENT_CYCLONE:
                    DoCastVictim(SPELL_ENVELOPING_WINDS);
                    events.ScheduleEvent(EVENT_CYCLONE, 20s);
                    break;
                case EVENT_STOMP:
                    DoCastAOE(SPELL_WAR_STOMP);
                    events.ScheduleEvent(EVENT_STOMP, 30s);
                    break;
                default:
                    break;
            }
        }
        DoMeleeAttackIfReady();
    }

protected:
    uint8 _crystalIterator;
    ObjectGuid _firstCrystalGUID;
    bool _saidIntro;
};

class go_ossirian_crystal : public GameObjectScript
{
public:
    go_ossirian_crystal() : GameObjectScript("go_ossirian_crystal") { }

    struct go_ossirian_crystalAI : public GameObjectAI
    {
        go_ossirian_crystalAI(GameObject* go) : GameObjectAI(go), _instance(go->GetInstanceScript()) { }

        void SetGUID(ObjectGuid guid, int32 type) override
        {
            if (type == GUID_TRIGGER_PAIR)
            {
                _triggerGUID = guid;
            }
        }

        bool GossipHello(Player* /*player*/, bool reportUse) override
        {
            if (reportUse)
            {
                if (!_instance)
                    return true;

                Creature* ossirian = _instance->GetCreature(DATA_OSSIRIAN);
                if (!ossirian)
                    return true;

                if (Creature* trigger = ObjectAccessor::GetCreature(*me, _triggerGUID))
                {
                    if (!trigger->HasUnitState(UNIT_STATE_CASTING))
                    {
                        ossirian->AI()->SetGUID(me->GetGUID(), ACTION_TRIGGER_WEAKNESS);
                        trigger->CastSpell(trigger, spellWeakness[urand(0, 4)], false);
                    }
                }
            }

            return false;
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_DESPAWN_TRIGGER)
            {
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, _triggerGUID))
                {
                    trigger->DespawnOrUnsummon();
                }
            }
        }

        private:
            InstanceScript* _instance;
            ObjectGuid _triggerGUID;
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_ossirian_crystalAI(go);
    }
};

enum AnubisathGuardian
{
    SPELL_METEOR                 = 24340,
    SPELL_PLAGUE                 = 22997,
    SPELL_SHADOW_STORM           = 2148,
    SPELL_THUNDER_CLAP           = 2834,
    SPELL_REFLECT_ARCANE_FIRE    = 13022,
    SPELL_REFLECT_FROST_SHADOW   = 19595,
    SPELL_ENRAGE                 = 8599,
    SPELL_EXPLODE                = 25698,

    SPELL_SUMMON_ANUB_SWARMGUARD = 17430,
    SPELL_SUMMON_ANUB_WARRIOR    = 17431,
};

struct npc_anubisath_guardian : public ScriptedAI
{
    npc_anubisath_guardian(Creature* creature) : ScriptedAI(creature)
    {
        _spells[0] = RAND(SPELL_SHADOW_STORM, SPELL_THUNDER_CLAP);
        _spells[1] = RAND(SPELL_REFLECT_ARCANE_FIRE, SPELL_REFLECT_FROST_SHADOW);
    }

    void Reset() override
    {
        _enraged = false;

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoCastSelf(_spells[0]);
        DoCastSelf(_spells[1]);

        _scheduler.CancelAll();

        uint32 spell = RAND(SPELL_METEOR, SPELL_PLAGUE);
        _scheduler.Schedule(10s, [this, spell](TaskContext context) {
            DoCastRandomTarget(spell);
            context.Repeat(10s, 15s);
        });

        spell = RAND(SPELL_SUMMON_ANUB_SWARMGUARD, SPELL_SUMMON_ANUB_WARRIOR);
        _scheduler.Schedule(10s, [this, spell](TaskContext context) {
            DoCastAOE(spell);
            context.Repeat(10s, 15s);
        });
    }

    void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType /* damagetype */, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (!_enraged && me->HealthBelowPctDamaged(10, damage))
        {
            _enraged = true;
            DoCastSelf(RAND(SPELL_ENRAGE, SPELL_EXPLODE), true);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_SUMMON_SMALL_OBSIDIAN_CHUNK, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    bool _enraged;
    uint32 _spells[2];
    TaskScheduler _scheduler;
};

class spell_crystal_weakness : public SpellScript
{
    PrepareSpellScript(spell_crystal_weakness);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject const* target) -> bool
            {
                return target->GetEntry() != NPC_OSSIRIAN;
            });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_crystal_weakness::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENTRY);
    }
};

class spell_aq_shadow_storm : public SpellScript
{
    PrepareSpellScript(spell_aq_shadow_storm);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();
        targets.remove_if([caster](WorldObject const* obj)
        {
            return caster->GetExactDist2d(obj) < 25.0f;
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_aq_shadow_storm::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_ossirian()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_ossirian);
    new go_ossirian_crystal();
    RegisterCreatureAI(npc_anubisath_guardian);
    RegisterSpellScript(spell_crystal_weakness);
    RegisterSpellScript(spell_aq_shadow_storm);
}
