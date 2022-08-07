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

#include "MiscPackets.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "ruins_of_ahnqiraj.h"
#include "TaskScheduler.h"

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
    SPELL_CURSE_OF_TONGUES      = 25195,
    SPELL_ENVELOPING_WINDS      = 25189,
    SPELL_WAR_STOMP             = 25188,
    SPELL_STRENGHT_OF_OSSIRIAN  = 25176,
    SPELL_SAND_STORM            = 25160,
    SPELL_SUMMON_CRYSTAL        = 25192,

    // Crystal
    SPELL_FIRE_WEAKNESS         = 25177,
    SPELL_FROST_WEAKNESS        = 25178,
    SPELL_NATURE_WEAKNESS       = 25180,
    SPELL_ARCANE_WEAKNESS       = 25181,
    SPELL_SHADOW_WEAKNESS       = 25183
};

enum Actions
{
    ACTION_TRIGGER_WEAKNESS     = 1
};

enum Events
{
    EVENT_SILENCE               = 1,
    EVENT_CYCLONE               = 2,
    EVENT_STOMP                 = 3
};

uint8 const NUM_CRYSTALS = 9;
Position CrystalCoordinates[NUM_CRYSTALS] =
{
    { -9394.230469f, 1951.808594f, 85.97733f,  0.0f },
    { -9357.931641f, 1930.596802f, 85.556198f, 0.0f },
    { -9383.113281f, 2011.042725f, 85.556389f, 0.0f },
    { -9243.36f,     1979.04f,     85.556f,    0.0f },
    { -9281.68f,     1886.66f,     85.5558f,   0.0f },
    { -9241.8f,      1806.39f,     85.5557f,   0.0f },
    { -9366.78f,     1781.76f,     85.5561f,   0.0f },
    { -9430.37f,     1786.86f,     85.557f,    0.0f },
    { -9406.73f,     1863.13f,     85.5558f,   0.0f }
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

    void Reset() override
    {
        BossAI::Reset();
        _crystalIterator = 0;
        _triggerGUID.Clear();
        _crystalGUID.Clear();
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        for (uint32 weakness : spellWeakness)
        {
            if (spell->Id == weakness)
            {
                me->RemoveAurasDueToSpell(SPELL_STRENGHT_OF_OSSIRIAN);
                ((TempSummon*)caster)->UnSummon();
                SpawnNextCrystal();
            }
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_TRIGGER_WEAKNESS)
        {
            if (Creature* trigger = me->GetMap()->GetCreature(_triggerGUID))
            {
                if (!trigger->HasUnitState(UNIT_STATE_CASTING))
                {
                    trigger->CastSpell(trigger, spellWeakness[urand(0, 4)], false);
                }
            }
        }
    }

    void EnterCombat(Unit* who) override
    {
        BossAI::EnterCombat(who);
        events.Reset();
        events.ScheduleEvent(EVENT_SILENCE, 30s);
        events.ScheduleEvent(EVENT_CYCLONE, 20s);
        events.ScheduleEvent(EVENT_STOMP, 30s);
        DoCastSelf(SPELL_STRENGHT_OF_OSSIRIAN);
        Talk(SAY_AGGRO);

        Map* map = me->GetMap();
        if (!map->IsDungeon())
            return;

        WorldPackets::Misc::Weather weather(WEATHER_STATE_HEAVY_SANDSTORM, 1.0f);
        map->SendToPlayers(weather.Write());

        SpawnNextCrystal();
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        Cleanup();
        summons.DespawnAll();
        BossAI::EnterEvadeMode(why);
    }

    void JustDied(Unit* killer) override
    {
        Cleanup();
        BossAI::JustDied(killer);
    }

    void Cleanup()
    {
        if (GameObject* crystal = me->GetMap()->GetGameObject(_crystalGUID))
        {
            crystal->Use(me);
        }

        std::list<Creature*> vortexes;
        me->GetCreaturesWithEntryInRange(vortexes, 200.f, NPC_SAND_VORTEX);
        for (Creature* vortex : vortexes)
            vortex->DespawnOrUnsummon();
    }

    void SpawnNextCrystal()
    {
        if (_crystalIterator == NUM_CRYSTALS)
            _crystalIterator = 0;

        if (Creature* trigger = me->GetMap()->SummonCreature(NPC_OSSIRIAN_TRIGGER, CrystalCoordinates[_crystalIterator]))
        {
            _triggerGUID = trigger->GetGUID();
            if (GameObject* crystal = trigger->SummonGameObject(GO_OSSIRIAN_CRYSTAL,
                CrystalCoordinates[_crystalIterator].GetPositionX(),
                CrystalCoordinates[_crystalIterator].GetPositionY(),
                CrystalCoordinates[_crystalIterator].GetPositionZ(),
                0, 0, 0, 0, 0, uint32(-1)))
            {
                _crystalGUID = crystal->GetGUID();
                ++_crystalIterator;
                crystal->SetOwnerGUID(ObjectGuid::Empty);
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
        if (me->HasAura(SPELL_STRENGHT_OF_OSSIRIAN))
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
            DoCastSelf(SPELL_STRENGHT_OF_OSSIRIAN);
            Talk(SAY_SUPREME);
        }

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
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
    ObjectGuid _triggerGUID;
    ObjectGuid _crystalGUID;
    uint8 _crystalIterator;
    bool _saidIntro;
};

class go_ossirian_crystal : public GameObjectScript
{
public:
    go_ossirian_crystal() : GameObjectScript("go_ossirian_crystal") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        InstanceScript* instance = player->GetInstanceScript();
        if (!instance)
            return false;

        Creature* ossirian = instance->GetCreature(DATA_OSSIRIAN);
        if (!ossirian || instance->GetBossState(DATA_OSSIRIAN) != IN_PROGRESS)
            return false;

        ossirian->AI()->DoAction(ACTION_TRIGGER_WEAKNESS);
        return true;
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

    void EnterCombat(Unit* /*who*/) override
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

void AddSC_boss_ossirian()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_ossirian);
    new go_ossirian_crystal();
    RegisterCreatureAI(npc_anubisath_guardian);
    RegisterSpellScript(spell_crystal_weakness);
}
