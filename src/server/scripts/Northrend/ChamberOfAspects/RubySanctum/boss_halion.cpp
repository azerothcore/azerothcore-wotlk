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

#include "AreaDefines.h"
#include "CreatureScript.h"
#include "DBCStores.h"
#include "GameObject.h"
#include "Map.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "WorldPacket.h"
#include "WorldStateDefines.h"
#include "ruby_sanctum.h"
#include <array>

enum Texts
{
    // Shared
    SAY_REGENERATE                     = 0, // Without pressure in both realms, %s begins to regenerate.

    // Halion
    SAY_INTRO                          = 1, // Meddlesome insects! You are too late. The Ruby Sanctum is lost!
    SAY_AGGRO                          = 2, // Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!
    SAY_METEOR_STRIKE                  = 3, // The heavens burn!
    SAY_PHASE_TWO                      = 4, // You will find only suffering within the realm of twilight! Enter if you dare!
    SAY_DEATH                          = 5, // Relish this victory, mortals, for it will be your last! This world will burn with the master's return!
    SAY_KILL                           = 6, // Another "hero" falls.
    SAY_BERSERK                        = 7, // Not good enough.
    EMOTE_CORPOREALITY_POT             = 8, // Your efforts force %s further out of the physical realm!
    EMOTE_CORPOREALITY_PIP             = 9, // Your companions' efforts force %s further into the physical realm!

    // Twilight Halion
    SAY_SPHERE_PULSE                   = 1, // Beware the shadow!
    SAY_PHASE_THREE                    = 2, // I am the light and the darkness! Cower, mortals, before the herald of Deathwing!
    EMOTE_CORPOREALITY_TIT             = 3, // Your companions' efforts force %s further into the twilight realm!
    EMOTE_CORPOREALITY_TOT             = 4, // Your efforts force %s further out of the twilight realm!
    EMOTE_WARN_LASER                   = 5  // The orbiting spheres pulse with dark energy!
};

enum Spells
{
    // Halion
    SPELL_FLAME_BREATH                  = 74525,
    SPELL_CLEAVE                        = 74524,
    SPELL_METEOR_STRIKE_TARGETING       = 74638,
    SPELL_TAIL_LASH                     = 74531,

    // Living Inferno
    SPELL_BLAZING_AURA                  = 75885,

    // Combustion / Consumption
    SPELL_SCALE_AURA                    = 70507,
    SPELL_FIERY_COMBUSTION              = 74562,
    SPELL_MARK_OF_COMBUSTION            = 74567,
    SPELL_FIERY_COMBUSTION_EXPLOSION    = 74607,
    SPELL_FIERY_COMBUSTION_SUMMON       = 74610,
    SPELL_COMBUSTION_DAMAGE_AURA        = 74629,
    SPELL_SOUL_CONSUMPTION              = 74792,
    SPELL_MARK_OF_CONSUMPTION           = 74795,
    SPELL_SOUL_CONSUMPTION_EXPLOSION    = 74799,
    SPELL_SOUL_CONSUMPTION_SUMMON       = 74800,
    SPELL_CONSUMPTION_DAMAGE_AURA       = 74803,

    // Meteor Strike
    SPELL_METEOR_STRIKE                 = 74637,
    SPELL_SUMMON_METEOR_STRIKE1         = 74680,
    SPELL_SUMMON_METEOR_STRIKE2         = 74681,
    SPELL_SUMMON_METEOR_STRIKE3         = 74682,
    SPELL_SUMMON_METEOR_STRIKE4         = 74683,
    SPELL_SUMMON_METEOR_FLAME1          = 74687,
    SPELL_SUMMON_METEOR_FLAME2          = 74688,
    SPELL_SUMMON_METEOR_FLAME3          = 74689,
    SPELL_METEOR_STRIKE_SPREAD          = 74696,
    SPELL_METEOR_STRIKE_COUNTDOWN       = 74641,
    SPELL_METEOR_STRIKE_AOE_DAMAGE      = 74648,
    SPELL_METEOR_STRIKE_FIRE_AURA_1     = 74713,
    SPELL_METEOR_STRIKE_FIRE_AURA_2     = 74718,
    SPELL_BIRTH_NO_VISUAL               = 40031,

    // Twilight Halion
    SPELL_DARK_BREATH                   = 74806,

    // Shadow Orb
    SPELL_TWILIGHT_CUTTER               = 74768,
    SPELL_TWILIGHT_PULSE_PERIODIC       = 78861,
    SPELL_TRACK_ROTATION                = 74758,

    // Halion Controller
    SPELL_COSMETIC_FIRE_PILLAR          = 76006,
    SPELL_FIERY_EXPLOSION               = 76010,
    SPELL_CLEAR_DEBUFFS                 = 75396,

    // Misc
    SPELL_TWILIGHT_DIVISION             = 75063,
    SPELL_TWILIGHT_PHASING              = 74808,
    SPELL_SUMMON_TWILIGHT_PORTAL        = 74809,
    SPELL_SUMMON_EXIT_PORTALS_NORMAL    = 74804,
    SPELL_SUMMON_EXIT_PORTALS           = 74805,
    SPELL_TWILIGHT_MENDING              = 75509,
    SPELL_TWILIGHT_REALM                = 74807,
    SPELL_DUSK_SHROUD                   = 75476,
    SPELL_COPY_DAMAGE                   = 74810,
    SPELL_FEIGN_DEATH                   = 5384
};

enum Events
{
    // Halion
    EVENT_ACTIVATE_FIREWALL     = 1,
    EVENT_CLEAVE                = 2,
    EVENT_BREATH                = 3,
    EVENT_METEOR_STRIKE         = 4,
    EVENT_FIERY_COMBUSTION      = 5,
    EVENT_TAIL_LASH             = 6,
    EVENT_CHECK_HEALTH          = 7,
    EVENT_TRIGGER_BERSERK       = 9,
    EVENT_HALION_VISIBILITY     = 10,

    // Twilight Halion
    EVENT_SOUL_CONSUMPTION      = 20,
    EVENT_SHADOW_PULSARS        = 21,
    EVENT_SHADOW_PULSARS_SHOOT  = 22,
    EVENT_CHECK_CORPOREALITY    = 23,
    EVENT_TWILIGHT_MENDING      = 24,
    EVENT_SEND_ENCOUNTER_UNIT   = 25,

    // Halion Controller
    EVENT_START_INTRO           = 40,
    EVENT_INTRO_PROGRESS_1      = 41,
    EVENT_INTRO_PROGRESS_2      = 42,
    EVENT_INTRO_PROGRESS_3      = 43,
    EVENT_INTRO_PROGRESS_4      = 44
};

enum Actions
{
    ACTION_SHOOT                = 1,
    ACTION_CHECK_CORPOREALITY   = 2,
    ACTION_RESET_ENCOUNTER      = 3
};

enum ControllerData
{
    DATA_TWILIGHT_DAMAGE_TAKEN  = 1,
    DATA_MATERIAL_DAMAGE_TAKEN  = 2
};

enum OrbCarrierSeats
{
    SEAT_NORTH                  = 0,
    SEAT_SOUTH                  = 1,
    SEAT_EAST                   = 2,
    SEAT_WEST                   = 3
};

constexpr uint32 PHASEMASK_TWILIGHT = 0x20;
constexpr uint8 MAX_CORPOREALITY_STATE = 11;
constexpr uint8 CORPOREALITY_NEUTRAL = 5;

// Ordered from the least to the most corporeal state of the unit wearing the aura
std::array<uint32, MAX_CORPOREALITY_STATE> const CorporealitySpells =
{
    74836, 74835, 74834, 74833, 74832, 74826, 74827, 74828, 74829, 74830, 74831
};

class SendEncounterUnit : public BasicEvent
{
public:
    SendEncounterUnit(Player* owner) : _owner(owner) { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        InstanceScript* instance = _owner->GetInstanceScript();
        if (!instance || _owner->GetMapId() != MAP_THE_RUBY_SANCTUM)
            return true;

        if (instance->GetBossState(DATA_HALION) != IN_PROGRESS)
        {
            _owner->RemoveAurasDueToSpell(SPELL_TWILIGHT_REALM);
            return true;
        }

        WorldPacket data(SMSG_UPDATE_INSTANCE_ENCOUNTER_UNIT, 4);
        data << uint32(ENCOUNTER_FRAME_REFRESH_FRAMES);
        _owner->SendDirectMessage(&data);
        return true;
    }

private:
    Player* _owner;
};

class boss_halion : public CreatureScript
{
public:
    boss_halion() : CreatureScript("boss_halion") { }

    struct boss_halionAI : public BossAI
    {
        boss_halionAI(Creature* creature) : BossAI(creature, DATA_HALION), _livingEmberCount(0) { }

        void Reset() override
        {
            _livingEmberCount = 0;
            BossAI::Reset();
            me->RemoveAurasDueToSpell(SPELL_TWILIGHT_PHASING);
            DoCastSelf(SPELL_CLEAR_DEBUFFS);

            me->SetVisible(false);
            me->SetReactState(REACT_PASSIVE);
            _backgroundEvents.Reset();
            _backgroundEvents.RescheduleEvent(EVENT_HALION_VISIBILITY, 30s);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            switch (summon->GetEntry())
            {
                case NPC_METEOR_STRIKE_MARK:
                    summon->CastSpell(summon, SPELL_METEOR_STRIKE_COUNTDOWN, false);
                    summon->CastSpell(summon, SPELL_BIRTH_NO_VISUAL, false);
                    break;
                case NPC_METEOR_STRIKE_FLAME:
                    if (Is25ManRaid() && IsHeroic() && roll_chance_i(90) && summons.GetEntryCount(NPC_LIVING_EMBER) < _livingEmberCount + 12)
                        if (Creature* ember = me->SummonCreature(NPC_LIVING_EMBER, *summon, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1000))
                            ember->SetVisible(false);

                    [[fallthrough]];
                case NPC_METEOR_STRIKE_NORTH:
                case NPC_METEOR_STRIKE_SOUTH:
                case NPC_METEOR_STRIKE_WEST:
                case NPC_METEOR_STRIKE_EAST:
                    summon->CastSpell(summon, SPELL_METEOR_STRIKE_FIRE_AURA_2, true);
                    if (summons.GetEntryCount(NPC_METEOR_STRIKE_FLAME) <= 16)
                        summon->CastSpell(summon, SPELL_METEOR_STRIKE_SPREAD, true);

                    if (Unit* summoner = summon->ToTempSummon()->GetSummonerUnit())
                        summon->SetOrientation(summoner->GetAngle(summon));
                    break;
                default:
                    break;
            }
        }

        bool CanAIAttack(Unit const* who) const override
        {
            return me->GetHomePosition().GetExactDist2d(who) < 52.0f;
        }

        bool IsAnyPlayerValid()
        {
            for (auto const& ref : me->GetMap()->GetPlayers())
            {
                if (Player* player = ref.GetSource())
                    if (!player->IsGameMaster() && player->IsAlive() && me->GetHomePosition().GetExactDist2d(player) < 52.0f && me->IsWithinLOSInMap(player) && !player->HasInvisibilityAura() && !player->HasStealthAura() && !player->HasUnattackableAura() && !player->HasAura(SPELL_FEIGN_DEATH))
                        return true;
            }

            return false;
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (IsAnyPlayerValid())
                return;

            instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            if (Creature* controller = instance->GetCreature(DATA_HALION_CONTROLLER))
                controller->AI()->DoAction(ACTION_RESET_ENCOUNTER);

            BossAI::EnterEvadeMode(why);
        }

        void AttackStart(Unit* who) override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            BossAI::AttackStart(who);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            Talk(SAY_AGGRO);
            instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me, 1);

            events.ScheduleEvent(EVENT_CLEAVE, 8s, 10s);
            events.ScheduleEvent(EVENT_TAIL_LASH, 10s);
            events.ScheduleEvent(EVENT_BREATH, 10s, 15s);
            events.ScheduleEvent(EVENT_ACTIVATE_FIREWALL, 5s);
            events.ScheduleEvent(EVENT_METEOR_STRIKE, 20s, 25s);
            events.ScheduleEvent(EVENT_FIERY_COMBUSTION, 15s, 18s);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1s);
            _backgroundEvents.ScheduleEvent(EVENT_TRIGGER_BERSERK, 8min);
        }

        void KilledUnit(Unit* victim) override
        {
            Talk(SAY_KILL, victim);
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
            instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            DoCastSelf(SPELL_CLEAR_DEBUFFS);

            if (Creature* twilightHalion = instance->GetCreature(DATA_TWILIGHT_HALION))
                if (twilightHalion->IsAlive())
                    Unit::Kill(twilightHalion, twilightHalion);

            if (Creature* controller = instance->GetCreature(DATA_HALION_CONTROLLER))
                if (controller->IsAlive())
                    Unit::Kill(controller, controller);
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            // The health check stays scheduled until phase two starts
            if (events.HasTimeUntilEvent(EVENT_CHECK_HEALTH))
                return;

            if (!attacker || !me->InSamePhase(attacker))
                return;

            if (Creature* controller = instance->GetCreature(DATA_HALION_CONTROLLER))
                controller->AI()->SetData(DATA_MATERIAL_DAMAGE_TAKEN, damage);
        }

        void UpdateAI(uint32 diff) override
        {
            _backgroundEvents.Update(diff);
            switch (_backgroundEvents.ExecuteEvent())
            {
                case EVENT_HALION_VISIBILITY:
                    me->SetVisible(instance->GetBossState(DATA_HALION_INTRO_DONE) == DONE);
                    me->SetReactState(instance->GetBossState(DATA_HALION_INTRO_DONE) == DONE ? REACT_AGGRESSIVE : REACT_PASSIVE);
                    break;
                case EVENT_TRIGGER_BERSERK:
                    DoCastSelf(SPELL_BERSERK, true);
                    if (Creature* twilightHalion = instance->GetCreature(DATA_TWILIGHT_HALION))
                        twilightHalion->CastSpell(twilightHalion, SPELL_BERSERK, true);

                    break;
                default:
                    break;
            }

            if (!UpdateVictim())
                return;

            // Twilight Phasing transforms Halion while the fight is in the twilight realm
            if (me->GetDisplayId() != me->GetNativeDisplayId())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_CLEAVE:
                    DoCastVictim(SPELL_CLEAVE);
                    events.ScheduleEvent(EVENT_CLEAVE, 8s, 10s);
                    break;
                case EVENT_TAIL_LASH:
                    DoCastSelf(SPELL_TAIL_LASH);
                    events.ScheduleEvent(EVENT_TAIL_LASH, 10s);
                    break;
                case EVENT_BREATH:
                    DoCastVictim(SPELL_FLAME_BREATH);
                    events.ScheduleEvent(EVENT_BREATH, 10s, 12s);
                    break;
                case EVENT_ACTIVATE_FIREWALL:
                    instance->HandleGameObject(DATA_FLAME_RING, false);
                    break;
                case EVENT_METEOR_STRIKE:
                    _livingEmberCount = summons.GetEntryCount(NPC_LIVING_EMBER);
                    me->CastCustomSpell(SPELL_METEOR_STRIKE_TARGETING, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    Talk(SAY_METEOR_STRIKE);
                    events.ScheduleEvent(EVENT_METEOR_STRIKE, 40s);
                    break;
                case EVENT_FIERY_COMBUSTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, false, -SPELL_TWILIGHT_REALM))
                        DoCast(target, SPELL_FIERY_COMBUSTION);

                    events.ScheduleEvent(EVENT_FIERY_COMBUSTION, 25s);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(75))
                    {
                        Talk(SAY_PHASE_TWO);
                        DoCastSelf(SPELL_TWILIGHT_PHASING);
                        events.DelayEvents(10s);
                        return;
                    }

                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 1s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _backgroundEvents;
        uint32 _livingEmberCount;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<boss_halionAI>(creature);
    }
};

class boss_twilight_halion : public CreatureScript
{
public:
    boss_twilight_halion() : CreatureScript("boss_twilight_halion") { }

    struct boss_twilight_halionAI : public ScriptedAI
    {
        boss_twilight_halionAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
        {
            Creature* halion = _instance->GetCreature(DATA_HALION);
            if (!halion)
                return;

            halion->AddAura(SPELL_COPY_DAMAGE, me);
            me->AddAura(SPELL_COPY_DAMAGE, halion);
            me->AddAura(SPELL_DUSK_SHROUD, me);

            me->SetHealth(halion->GetHealth());
            me->setActive(true);
        }

        void Reset() override
        {
            _events.Reset();
            me->SetPhaseMask(PHASEMASK_NORMAL | PHASEMASK_TWILIGHT, true);
            me->SetInCombatWithZone();
            me->SetPhaseMask(PHASEMASK_TWILIGHT, true);
            me->SetReactState(REACT_DEFENSIVE);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_CLEAVE, 8s, 10s);
            _events.ScheduleEvent(EVENT_TAIL_LASH, 10s);
            _events.ScheduleEvent(EVENT_BREATH, 10s, 15s);
            _events.ScheduleEvent(EVENT_SOUL_CONSUMPTION, 20s);
            _events.ScheduleEvent(EVENT_SHADOW_PULSARS, 16s);
            _events.ScheduleEvent(EVENT_SEND_ENCOUNTER_UNIT, 2s);
            _events.ScheduleEvent(EVENT_CHECK_HEALTH, 1s);

            me->SetInCombatWithZone();
        }

        void EnterEvadeMode(EvadeReason /*why*/) override { }

        void KilledUnit(Unit* victim) override
        {
            Talk(SAY_KILL, victim);
        }

        void JustDied(Unit* killer) override
        {
            if (Creature* halion = _instance->GetCreature(DATA_HALION))
            {
                // Ensure looting
                if (me->IsDamageEnoughForLootingAndReward())
                    halion->LowerPlayerDamageReq(halion->GetMaxHealth());

                if (killer && halion->IsAlive())
                    Unit::Kill(killer, halion);
            }

            if (Creature* controller = _instance->GetCreature(DATA_HALION_CONTROLLER))
                if (controller->IsAlive())
                    Unit::Kill(controller, controller);

            _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            DoCastSelf(SPELL_CLEAR_DEBUFFS);
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (!attacker || !me->InSamePhase(attacker))
                return;

            if (Creature* controller = _instance->GetCreature(DATA_HALION_CONTROLLER))
                controller->AI()->SetData(DATA_TWILIGHT_DAMAGE_TAKEN, damage);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_SEND_ENCOUNTER_UNIT:
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me, 2);
                    break;
                case EVENT_CLEAVE:
                    DoCastVictim(SPELL_CLEAVE);
                    _events.ScheduleEvent(EVENT_CLEAVE, 8s, 10s);
                    break;
                case EVENT_TAIL_LASH:
                    DoCastSelf(SPELL_TAIL_LASH);
                    _events.ScheduleEvent(EVENT_TAIL_LASH, 10s);
                    break;
                case EVENT_BREATH:
                    DoCastVictim(SPELL_DARK_BREATH);
                    _events.ScheduleEvent(EVENT_BREATH, 10s, 12s);
                    break;
                case EVENT_SOUL_CONSUMPTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, false, SPELL_TWILIGHT_REALM))
                        DoCast(target, SPELL_SOUL_CONSUMPTION);

                    _events.ScheduleEvent(EVENT_SOUL_CONSUMPTION, 20s);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(50))
                    {
                        me->CastStop();
                        DoCastSelf(SPELL_TWILIGHT_DIVISION);
                        Talk(SAY_PHASE_THREE);
                        return;
                    }

                    _events.ScheduleEvent(EVENT_CHECK_HEALTH, 1s);
                    break;
                case EVENT_SHADOW_PULSARS:
                    Talk(SAY_SPHERE_PULSE);
                    Talk(EMOTE_WARN_LASER);
                    _events.ScheduleEvent(EVENT_SHADOW_PULSARS, 29s);
                    _events.ScheduleEvent(EVENT_SHADOW_PULSARS_SHOOT, 5s);
                    break;
                case EVENT_SHADOW_PULSARS_SHOOT:
                    if (Creature* orbCarrier = _instance->GetCreature(DATA_ORB_CARRIER))
                        orbCarrier->AI()->DoAction(ACTION_SHOOT);

                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<boss_twilight_halionAI>(creature);
    }
};

class npc_halion_controller : public CreatureScript
{
public:
    npc_halion_controller() : CreatureScript("npc_halion_controller") { }

    struct npc_halion_controllerAI : public NullCreatureAI
    {
        npc_halion_controllerAI(Creature* creature) : NullCreatureAI(creature), _instance(creature->GetInstanceScript()),
            _corporeality(CORPOREALITY_NEUTRAL), _materialDamage(1), _twilightDamage(1) { }

        void Reset() override
        {
            _events.Reset();
        }

        void SetData(uint32 id, uint32 value) override
        {
            if (!_events.HasTimeUntilEvent(EVENT_CHECK_CORPOREALITY))
                return;

            if (id == DATA_MATERIAL_DAMAGE_TAKEN)
                _materialDamage += value;
            else
                _twilightDamage += value;
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_INTRO_HALION:
                    _events.ScheduleEvent(EVENT_START_INTRO, 2s);
                    break;
                case ACTION_CHECK_CORPOREALITY:
                    ResetCorporeality();
                    _events.ScheduleEvent(EVENT_CHECK_CORPOREALITY, 7s);
                    break;
                case ACTION_RESET_ENCOUNTER:
                    _events.Reset();
                    ResetCorporeality();
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                // Intro
                case EVENT_START_INTRO:
                    me->CastSpell(me, SPELL_COSMETIC_FIRE_PILLAR, false);
                    _events.ScheduleEvent(EVENT_INTRO_PROGRESS_1, 5s);
                    break;
                case EVENT_INTRO_PROGRESS_1:
                    _instance->SetBossState(DATA_HALION_INTRO1, NOT_STARTED);
                    _instance->SetBossState(DATA_HALION_INTRO1, DONE);
                    _events.ScheduleEvent(EVENT_INTRO_PROGRESS_2, 5s);
                    break;
                case EVENT_INTRO_PROGRESS_2:
                    _instance->SetBossState(DATA_HALION_INTRO2, NOT_STARTED);
                    _instance->SetBossState(DATA_HALION_INTRO2, DONE);
                    _events.ScheduleEvent(EVENT_INTRO_PROGRESS_3, 4s);
                    break;
                case EVENT_INTRO_PROGRESS_3:
                    _instance->SetBossState(DATA_HALION_INTRO_DONE, NOT_STARTED);
                    _instance->SetBossState(DATA_HALION_INTRO_DONE, DONE);
                    me->CastSpell(me, SPELL_FIERY_EXPLOSION, false);
                    _events.ScheduleEvent(EVENT_INTRO_PROGRESS_4, 500ms);
                    break;
                case EVENT_INTRO_PROGRESS_4:
                    if (Creature* halion = _instance->GetCreature(DATA_HALION))
                    {
                        halion->SetVisible(true);
                        halion->SetReactState(REACT_AGGRESSIVE);
                        halion->AI()->Talk(SAY_INTRO);
                    }
                    break;
                case EVENT_TWILIGHT_MENDING:
                    DoCastAOE(SPELL_TWILIGHT_MENDING, true);
                    break;
                case EVENT_CHECK_CORPOREALITY:
                    UpdateCorporeality();
                    _events.ScheduleEvent(EVENT_CHECK_CORPOREALITY, 10s);
                    break;
                default:
                    break;
            }
        }

    private:
        void ResetCorporeality()
        {
            _materialDamage = 1;
            _twilightDamage = 1;
            _corporeality = CORPOREALITY_NEUTRAL;
        }

        void UpdateCorporeality()
        {
            if (!_instance->IsEncounterInProgress())
            {
                DoAction(ACTION_RESET_ENCOUNTER);
                return;
            }

            uint8 oldValue = _corporeality;
            float damageRatio = float(_materialDamage) / float(_twilightDamage);

            if (_twilightDamage == 1 || _materialDamage == 1)
                _events.ScheduleEvent(EVENT_TWILIGHT_MENDING, 4s);

            _twilightDamage = 1;
            _materialDamage = 1;

            if (damageRatio < 0.98f)
            {
                if (_corporeality == MAX_CORPOREALITY_STATE - 1)
                    return;

                ++_corporeality;
            }
            else if (damageRatio > 1.02f)
            {
                if (!_corporeality)
                    return;

                --_corporeality;
            }
            else
                return;

            _instance->DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_MATERIAL, _corporeality * 10);
            _instance->DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_TWILIGHT, 100 - _corporeality * 10);

            if (Creature* twilightHalion = _instance->GetCreature(DATA_TWILIGHT_HALION))
            {
                twilightHalion->RemoveAurasDueToSpell(CorporealitySpells[MAX_CORPOREALITY_STATE - 1 - oldValue]);
                twilightHalion->CastSpell(twilightHalion, CorporealitySpells[MAX_CORPOREALITY_STATE - 1 - _corporeality], true);
                twilightHalion->AI()->Talk(oldValue < _corporeality ? EMOTE_CORPOREALITY_TOT : EMOTE_CORPOREALITY_TIT);
            }

            if (Creature* halion = _instance->GetCreature(DATA_HALION))
            {
                halion->RemoveAurasDueToSpell(CorporealitySpells[oldValue]);
                halion->CastSpell(halion, CorporealitySpells[_corporeality], true);
                halion->AI()->Talk(oldValue > _corporeality ? EMOTE_CORPOREALITY_POT : EMOTE_CORPOREALITY_PIP);
            }
        }

        EventMap _events;
        InstanceScript* _instance;
        uint8 _corporeality;
        uint32 _materialDamage;
        uint32 _twilightDamage;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<npc_halion_controllerAI>(creature);
    }
};

class npc_orb_carrier : public CreatureScript
{
public:
    npc_orb_carrier() : CreatureScript("npc_orb_carrier") { }

    struct npc_orb_carrierAI : public NullCreatureAI
    {
        npc_orb_carrierAI(Creature* creature) : NullCreatureAI(creature)
        {
            ASSERT(creature->GetVehicleKit());
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!me->HasUnitState(UNIT_STATE_CASTING))
                DoCastAOE(SPELL_TRACK_ROTATION);
        }

        void DoAction(int32 action) override
        {
            if (action != ACTION_SHOOT)
                return;

            Vehicle* vehicle = me->GetVehicleKit();
            Unit* southOrb = vehicle->GetPassenger(SEAT_SOUTH);
            Unit* northOrb = vehicle->GetPassenger(SEAT_NORTH);
            if (southOrb && northOrb)
                TriggerCutter(northOrb, southOrb);

            if (!me->GetMap()->IsHeroic())
                return;

            Unit* eastOrb = vehicle->GetPassenger(SEAT_EAST);
            Unit* westOrb = vehicle->GetPassenger(SEAT_WEST);
            if (eastOrb && westOrb)
                TriggerCutter(eastOrb, westOrb);
        }

        void TriggerCutter(Unit* caster, Unit* target)
        {
            caster->CastSpell(caster, SPELL_TWILIGHT_PULSE_PERIODIC, true);
            target->CastSpell(target, SPELL_TWILIGHT_PULSE_PERIODIC, true);
            caster->CastSpell(target, SPELL_TWILIGHT_CUTTER, false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<npc_orb_carrierAI>(creature);
    }
};

class spell_halion_meteor_strike_targeting : public SpellScript
{
    PrepareSpellScript(spell_halion_meteor_strike_targeting);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_METEOR_STRIKE });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_METEOR_STRIKE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_halion_meteor_strike_targeting::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_halion_meteor_strike_marker_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_meteor_strike_marker_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_METEOR_STRIKE_AOE_DAMAGE, SPELL_METEOR_STRIKE_FIRE_AURA_1 });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        SetDuration(6500);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        InstanceScript* instance = caster->GetInstanceScript();
        if (!instance || !instance->IsEncounterInProgress())
            return;

        caster->CastSpell(caster, SPELL_METEOR_STRIKE_AOE_DAMAGE, true);
        caster->CastSpell(caster, SPELL_METEOR_STRIKE_FIRE_AURA_1, true);
        for (uint32 spellId = SPELL_SUMMON_METEOR_STRIKE1; spellId <= SPELL_SUMMON_METEOR_STRIKE4; ++spellId)
            caster->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_halion_meteor_strike_marker_aura::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_halion_meteor_strike_marker_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_halion_meteor_strike_spread_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_meteor_strike_spread_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_METEOR_FLAME1, SPELL_SUMMON_METEOR_FLAME2, SPELL_SUMMON_METEOR_FLAME3 });
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        Unit* owner = GetUnitOwner();
        InstanceScript* instance = owner->GetInstanceScript();
        if (!instance || !instance->IsEncounterInProgress())
            return;

        // The flame spreads straight 3 times out of 5 and turns otherwise
        owner->CastSpell(owner, RAND(SPELL_SUMMON_METEOR_FLAME1, SPELL_SUMMON_METEOR_FLAME2, SPELL_SUMMON_METEOR_FLAME2, SPELL_SUMMON_METEOR_FLAME2, SPELL_SUMMON_METEOR_FLAME3), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_halion_meteor_strike_spread_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_halion_blazing_aura : public SpellScript
{
    PrepareSpellScript(spell_halion_blazing_aura);

    void HandleForceCast(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, GetSpellInfo()->Effects[effIndex].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_halion_blazing_aura::HandleForceCast, EFFECT_1, SPELL_EFFECT_FORCE_CAST);
    }
};

class spell_halion_combustion_consumption_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_combustion_consumption_aura);

public:
    spell_halion_combustion_consumption_aura(uint32 markSpellId) : _markSpellId(markSpellId) { }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(_markSpellId, ObjectGuid::Empty, 0, AURA_REMOVE_BY_EXPIRE);
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), _markSpellId, true);
    }

    void AddMarkStack(AuraEffect const* /*aurEff*/)
    {
        GetTarget()->CastSpell(GetTarget(), _markSpellId, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_halion_combustion_consumption_aura::AddMarkStack, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        AfterEffectApply += AuraEffectApplyFn(spell_halion_combustion_consumption_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_halion_combustion_consumption_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }

private:
    uint32 _markSpellId;
};

class spell_halion_marks_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_marks_aura);

public:
    spell_halion_marks_aura(uint32 summonSpellId, uint32 removeSpellId) : _summonSpellId(summonSpellId), _removeSpellId(removeSpellId) { }

    void BeforeDispel(DispelInfo* dispelData)
    {
        dispelData->SetRemovedCharges(0);

        if (Unit* dispelledUnit = GetUnitOwner())
            if (dispelledUnit->HasAura(_removeSpellId))
                dispelledUnit->RemoveAurasDueToSpell(_removeSpellId, ObjectGuid::Empty, 0, AURA_REMOVE_BY_EXPIRE);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        Unit* target = GetTarget();
        InstanceScript* instance = target->GetInstanceScript();
        if (!instance || !instance->IsEncounterInProgress() || target->GetMapId() != MAP_THE_RUBY_SANCTUM)
            return;

        target->CastCustomSpell(_summonSpellId, SPELLVALUE_BASE_POINT1, GetAura()->GetStackAmount(), target, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());
    }

    void Register() override
    {
        OnDispel += AuraDispelFn(spell_halion_marks_aura::BeforeDispel);
        AfterEffectRemove += AuraEffectRemoveFn(spell_halion_marks_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    uint32 _summonSpellId;
    uint32 _removeSpellId;
};

class spell_halion_damage_aoe_summon : public SpellScript
{
    PrepareSpellScript(spell_halion_damage_aoe_summon);

public:
    spell_halion_damage_aoe_summon(uint32 explosionSpellId, uint32 auraSpellId) : _explosionSpellId(explosionSpellId), _auraSpellId(auraSpellId) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SCALE_AURA });
    }

    void HandleSummon(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* caster = GetCaster();
        uint32 entry = uint32(GetSpellInfo()->Effects[effIndex].MiscValue);
        SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(uint32(GetSpellInfo()->Effects[effIndex].MiscValueB));
        uint32 duration = uint32(GetSpellInfo()->GetDuration());

        Creature* summon = caster->GetMap()->SummonCreature(entry, caster->GetPosition(), properties, duration, caster, GetSpellInfo()->Id);
        if (!summon)
            return;

        bool heroic = summon->GetMap()->IsHeroic();
        bool raid = summon->GetMap()->Is25ManRaid();

        if (heroic)
            summon->SetPhaseMask(PHASEMASK_NORMAL | PHASEMASK_TWILIGHT, true);
        else if (summon->GetEntry() == NPC_COMBUSTION)
            summon->SetPhaseMask(PHASEMASK_NORMAL, true);
        else
            summon->SetPhaseMask(PHASEMASK_TWILIGHT, true);

        summon->CastCustomSpell(SPELL_SCALE_AURA, SPELLVALUE_AURA_STACK, GetSpellValue()->EffectBasePoints[EFFECT_1], summon);
        summon->CastSpell(summon, _auraSpellId, true);

        int32 damage = int32((1500 + (GetSpellValue()->EffectBasePoints[EFFECT_1] * 1250)) * (heroic ? 1.25f : 1.0f) * (raid ? 1.5f : 1.0f));
        caster->CastCustomSpell(_explosionSpellId, SPELLVALUE_BASE_POINT0, damage, caster);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_halion_damage_aoe_summon::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
    }

private:
    uint32 _explosionSpellId;
    uint32 _auraSpellId;
};

class spell_halion_clear_debuffs : public SpellScript
{
    PrepareSpellScript(spell_halion_clear_debuffs);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FIERY_COMBUSTION });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        if (!target)
            return;

        target->RemoveAurasDueToSpell(GetSpellInfo()->Effects[EFFECT_0].CalcValue());
        target->RemoveAurasDueToSpell(GetSpellInfo()->Effects[EFFECT_1].CalcValue());
        target->RemoveAurasDueToSpell(SPELL_FIERY_COMBUSTION);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_halion_clear_debuffs::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_halion_twilight_phasing : public SpellScript
{
    PrepareSpellScript(spell_halion_twilight_phasing);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_TWILIGHT_PORTAL });
    }

    bool Load() override
    {
        return GetCaster()->IsCreature();
    }

    void Phase()
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ(), SPELL_SUMMON_TWILIGHT_PORTAL, true);
        caster->GetMap()->SummonCreature(NPC_TWILIGHT_HALION, caster->ToCreature()->GetHomePosition(), nullptr, 0, caster);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_halion_twilight_phasing::Phase);
    }
};

class spell_halion_twilight_phasing_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_twilight_phasing_aura);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        DropCombat();
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        DropCombat();
    }

    void DropCombat()
    {
        Unit* target = GetTarget();
        target->ToCreature()->SetReactState(REACT_DEFENSIVE);
        target->GetMotionMaster()->Clear();
        target->GetThreatMgr().ClearAllThreat();
        target->RemoveAllAttackers();
        target->AttackStop();
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_halion_twilight_phasing_aura::OnApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_halion_twilight_phasing_aura::OnRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_halion_twilight_realm_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_twilight_realm_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FIERY_COMBUSTION });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveAurasDueToSpell(SPELL_FIERY_COMBUSTION, ObjectGuid::Empty, 0, AURA_REMOVE_BY_ENEMY_SPELL);
        if (Player* player = target->ToPlayer())
            player->m_Events.AddEventAtOffset(new SendEncounterUnit(player), 500ms);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_halion_twilight_realm_aura::OnApply, EFFECT_0, SPELL_AURA_PHASE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_halion_leave_twilight_realm_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_leave_twilight_realm_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SOUL_CONSUMPTION, SPELL_TWILIGHT_REALM });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_SOUL_CONSUMPTION, ObjectGuid::Empty, 0, AURA_REMOVE_BY_ENEMY_SPELL);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveAurasDueToSpell(SPELL_TWILIGHT_REALM);
        if (Player* player = target->ToPlayer())
            player->m_Events.AddEventAtOffset(new SendEncounterUnit(player), 500ms);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_halion_leave_twilight_realm_aura::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_halion_leave_twilight_realm_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_halion_twilight_cutter_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_halion_twilight_cutter_periodic_aura);

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        GetUnitOwner()->CastSpell(static_cast<Unit*>(nullptr), GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_halion_twilight_cutter_periodic_aura::HandlePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_halion_twilight_cutter : public SpellScript
{
    PrepareSpellScript(spell_halion_twilight_cutter);

    void RemoveNotBetween(std::list<WorldObject*>& unitList)
    {
        if (unitList.empty())
            return;

        Unit* caster = GetCaster();
        Aura* cutter = caster->GetAura(SPELL_TWILIGHT_CUTTER);
        Unit* cutterCaster = cutter ? cutter->GetCaster() : nullptr;
        if (!cutterCaster)
        {
            unitList.clear();
            return;
        }

        unitList.remove_if([caster, cutterCaster](WorldObject* target)
        {
            return !target->IsInBetween(caster, cutterCaster, 2.5f);
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_halion_twilight_cutter::RemoveNotBetween, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_halion_summon_exit_portals : public SpellScript
{
    PrepareSpellScript(spell_halion_summon_exit_portals);

    void OnSummon(SpellEffIndex effIndex)
    {
        WorldLocation summonPos = *GetExplTargetDest();
        Position offset = { 0.0f, 0.0f, 0.0f, 0.0f };
        if (GetSpellInfo()->Id == SPELL_SUMMON_EXIT_PORTALS)
            offset.m_positionY = effIndex == EFFECT_1 ? -35.0f : 35.0f;
        else
            offset.m_positionX = effIndex == EFFECT_1 ? -35.0f : 35.0f;

        summonPos.RelocateOffset(offset);

        SetExplTargetDest(summonPos);
        GetHitDest()->RelocateOffset(offset);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_halion_summon_exit_portals::OnSummon, EFFECT_0, SPELL_EFFECT_SUMMON_OBJECT_WILD);
        OnEffectLaunch += SpellEffectFn(spell_halion_summon_exit_portals::OnSummon, EFFECT_1, SPELL_EFFECT_SUMMON_OBJECT_WILD);
    }
};

class spell_halion_twilight_division : public SpellScript
{
    PrepareSpellScript(spell_halion_twilight_division);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_EXIT_PORTALS_NORMAL, SPELL_SUMMON_EXIT_PORTALS, SPELL_TWILIGHT_PHASING });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        InstanceScript* instance = caster->GetInstanceScript();
        Creature* controller = instance->GetCreature(DATA_HALION_CONTROLLER);
        Creature* halion = instance->GetCreature(DATA_HALION);
        if (!controller || !halion)
            return;

        caster->CastSpell(caster, CorporealitySpells[CORPOREALITY_NEUTRAL], true);
        halion->CastSpell(halion, CorporealitySpells[CORPOREALITY_NEUTRAL], true);

        controller->CastSpell(controller, SPELL_SUMMON_EXIT_PORTALS_NORMAL, true);
        controller->CastSpell(controller, SPELL_SUMMON_EXIT_PORTALS, true);
        controller->AI()->DoAction(ACTION_CHECK_CORPOREALITY);

        halion->RemoveAurasDueToSpell(SPELL_TWILIGHT_PHASING);
        if (GameObject* go = halion->FindNearestGameObject(GO_HALION_PORTAL_1, 100.0f))
            go->Delete();

        instance->DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_TOGGLE, 1);
        instance->DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_MATERIAL, 50);
        instance->DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_TWILIGHT, 50);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_halion_twilight_division::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_halion_twilight_mending : public SpellScript
{
    PrepareSpellScript(spell_halion_twilight_mending);

    void HandleHealPct(SpellEffIndex /*effIndex*/)
    {
        if (Creature* target = GetHitCreature())
            target->AI()->Talk(SAY_REGENERATE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_halion_twilight_mending::HandleHealPct, EFFECT_ALL, SPELL_EFFECT_HEAL_PCT);
    }
};

class npc_living_inferno : public CreatureScript
{
public:
    npc_living_inferno() : CreatureScript("npc_living_inferno") { }

    struct npc_living_infernoAI : public ScriptedAI
    {
        npc_living_infernoAI(Creature* creature) : ScriptedAI(creature) { }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            me->SetInCombatWithZone();
            DoCastSelf(SPELL_BLAZING_AURA, true);
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->DespawnOrUnsummon(1ms);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<npc_living_infernoAI>(creature);
    }
};

void AddSC_boss_halion()
{
    new boss_halion();
    new boss_twilight_halion();
    new npc_halion_controller();
    new npc_orb_carrier();
    new npc_living_inferno();

    RegisterSpellScript(spell_halion_meteor_strike_targeting);
    RegisterSpellScript(spell_halion_meteor_strike_marker_aura);
    RegisterSpellScript(spell_halion_meteor_strike_spread_aura);
    RegisterSpellScript(spell_halion_blazing_aura);
    RegisterSpellScriptWithArgs(spell_halion_combustion_consumption_aura, "spell_halion_soul_consumption_aura", SPELL_MARK_OF_CONSUMPTION);
    RegisterSpellScriptWithArgs(spell_halion_combustion_consumption_aura, "spell_halion_fiery_combustion_aura", SPELL_MARK_OF_COMBUSTION);
    RegisterSpellScriptWithArgs(spell_halion_marks_aura, "spell_halion_mark_of_combustion_aura", SPELL_FIERY_COMBUSTION_SUMMON, SPELL_FIERY_COMBUSTION);
    RegisterSpellScriptWithArgs(spell_halion_marks_aura, "spell_halion_mark_of_consumption_aura", SPELL_SOUL_CONSUMPTION_SUMMON, SPELL_SOUL_CONSUMPTION);
    RegisterSpellScriptWithArgs(spell_halion_damage_aoe_summon, "spell_halion_combustion_summon", SPELL_FIERY_COMBUSTION_EXPLOSION, SPELL_COMBUSTION_DAMAGE_AURA);
    RegisterSpellScriptWithArgs(spell_halion_damage_aoe_summon, "spell_halion_consumption_summon", SPELL_SOUL_CONSUMPTION_EXPLOSION, SPELL_CONSUMPTION_DAMAGE_AURA);
    RegisterSpellScript(spell_halion_clear_debuffs);
    RegisterSpellAndAuraScriptPair(spell_halion_twilight_phasing, spell_halion_twilight_phasing_aura);
    RegisterSpellScript(spell_halion_twilight_realm_aura);
    RegisterSpellScript(spell_halion_leave_twilight_realm_aura);
    RegisterSpellScript(spell_halion_twilight_cutter_periodic_aura);
    RegisterSpellScript(spell_halion_twilight_cutter);
    RegisterSpellScript(spell_halion_summon_exit_portals);
    RegisterSpellScript(spell_halion_twilight_division);
    RegisterSpellScript(spell_halion_twilight_mending);
}
