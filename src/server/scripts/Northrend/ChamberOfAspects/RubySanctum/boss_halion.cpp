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
#include "MapMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "ruby_sanctum.h"

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
    EMOTE_WARN_LASER                   = 5, // The orbiting spheres pulse with dark energy!
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
    SPELL_TWILIGHT_CUTTER_TRIGGERED     = 74769,
    SPELL_TWILIGHT_PULSE_PERIODIC       = 78861,
    SPELL_TRACK_ROTATION                = 74758,

    // Halion Controller
    SPELL_COSMETIC_FIRE_PILLAR          = 76006,
    SPELL_FIERY_EXPLOSION               = 76010,
    SPELL_CLEAR_DEBUFFS                 = 75396,

    // Misc
    SPELL_TWILIGHT_DIVISION             = 75063,
    SPELL_LEAVE_TWILIGHT_REALM          = 74812,
    SPELL_TWILIGHT_PHASING              = 74808,
    SPELL_SUMMON_TWILIGHT_PORTAL        = 74809,
    SPELL_SUMMON_EXIT_PORTALS_NORMAL    = 74804,
    SPELL_SUMMON_EXIT_PORTALS           = 74805,
    SPELL_TWILIGHT_MENDING              = 75509,
    SPELL_TWILIGHT_REALM                = 74807,
    SPELL_DUSK_SHROUD                   = 75476,
    SPELL_COPY_DAMAGE                   = 74810
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
    EVENT_KILL_TALK             = 8,
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

enum Misc
{
    ACTION_SHOOT                = 1,
    ACTION_CHECK_CORPOREALITY   = 2,
    ACTION_RESET_ENCOUNTER      = 3,

    DATA_TWILIGHT_DAMAGE_TAKEN  = 1,
    DATA_MATERIAL_DAMAGE_TAKEN  = 2,

    SEAT_NORTH                  = 0,
    SEAT_SOUTH                  = 1,
    SEAT_EAST                   = 2,
    SEAT_WEST                   = 3
};

enum CorporealityEvent
{
    CORPOREALITY_NONE               = 0,
    CORPOREALITY_TWILIGHT_MENDING   = 1,
    CORPOREALITY_INCREASE           = 2,
    CORPOREALITY_DECREASE           = 3,
    MAX_CORPOREALITY_STATE          = 11
};

uint32 const _corporealityReference[MAX_CORPOREALITY_STATE] =
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
        if (!instance || _owner->GetMapId() != 724)
            return true;

        if (instance->GetBossState(DATA_HALION) != IN_PROGRESS)
        {
            _owner->RemoveAurasDueToSpell(SPELL_TWILIGHT_REALM);
            return true;
        }

        WorldPacket data(SMSG_UPDATE_INSTANCE_ENCOUNTER_UNIT, 4);
        data << uint32(ENCOUNTER_FRAME_REFRESH_FRAMES);
        _owner->GetSession()->SendPacket(&data);
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
        boss_halionAI(Creature* creature) : BossAI(creature, DATA_HALION)
        {
        }

        void Reset() override
        {
            _livingEmberCount = 0;
            BossAI::Reset();
            me->RemoveAurasDueToSpell(SPELL_TWILIGHT_PHASING);
            me->CastSpell(me, SPELL_CLEAR_DEBUFFS, false);

            me->SetVisible(false);
            me->SetReactState(REACT_PASSIVE);
            _events2.Reset();
            _events2.RescheduleEvent(EVENT_HALION_VISIBILITY, 30s);
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
                        {
                            ember->SetVisible(false);
                        }
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
            }
        }

        bool CanAIAttack(Unit const* who) const override
        {
            return me->GetHomePosition().GetExactDist2d(who) < 52.0f;
        }

        bool IsAnyPlayerValid()
        {
            Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
            for(Map::PlayerList::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                if (Player* player = itr->GetSource())
                    if (!player->IsGameMaster() && player->IsAlive() && me->GetHomePosition().GetExactDist2d(player) < 52.0f && me->IsWithinLOSInMap(player) && !player->HasAuraType(SPELL_AURA_MOD_INVISIBILITY) && !player->HasAuraType(SPELL_AURA_MOD_STEALTH) && !player->HasAuraType(SPELL_AURA_MOD_UNATTACKABLE))
                        return true;
            return false;
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (IsAnyPlayerValid())
                return;

            instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            if (Creature* controller = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_HALION_CONTROLLER)))
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
            _events2.ScheduleEvent(EVENT_TRIGGER_BERSERK, 8min);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
            instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            me->CastSpell(me, SPELL_CLEAR_DEBUFFS, false);

            if (Creature* twilightHalion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_TWILIGHT_HALION)))
                if (twilightHalion->IsAlive())
                    Unit::Kill(twilightHalion, twilightHalion);

            if (Creature* controller = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_HALION_CONTROLLER)))
                if (controller->IsAlive())
                    Unit::Kill(controller, controller);
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (events.GetNextEventTime(EVENT_CHECK_HEALTH) != 0)
                return;

            if (!attacker || !me->InSamePhase(attacker))
                return;

            if (Creature* controller = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_HALION_CONTROLLER)))
                controller->AI()->SetData(DATA_MATERIAL_DAMAGE_TAKEN, damage);
        }

        void UpdateAI(uint32 diff) override
        {
            _events2.Update(diff);
            switch (_events2.ExecuteEvent())
            {
                case EVENT_HALION_VISIBILITY:
                    me->SetVisible(instance->GetBossState(DATA_HALION_INTRO_DONE) == DONE);
                    me->SetReactState(instance->GetBossState(DATA_HALION_INTRO_DONE) == DONE ? REACT_AGGRESSIVE : REACT_PASSIVE);
                    break;
                case EVENT_TRIGGER_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    if (Creature* twilightHalion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_TWILIGHT_HALION)))
                        twilightHalion->CastSpell(twilightHalion, SPELL_BERSERK, true);
                    break;
            }

            if (!UpdateVictim())
                return;

            // Xinef: halion is invisible (second phase)
            if (me->GetDisplayId() != me->GetNativeDisplayId())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.ScheduleEvent(EVENT_CLEAVE, 8s, 10s);
                    break;
                case EVENT_TAIL_LASH:
                    me->CastSpell(me, SPELL_TAIL_LASH, false);
                    events.ScheduleEvent(EVENT_TAIL_LASH, 10s);
                    break;
                case EVENT_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FLAME_BREATH, false);
                    events.ScheduleEvent(EVENT_BREATH, 10s, 12s);
                    break;
                case EVENT_ACTIVATE_FIREWALL:
                    instance->HandleGameObject(instance->GetGuidData(GO_FLAME_RING), false, nullptr);
                    instance->HandleGameObject(instance->GetGuidData(GO_TWILIGHT_FLAME_RING), false, nullptr);
                    break;
                case EVENT_METEOR_STRIKE:
                    _livingEmberCount = summons.GetEntryCount(NPC_LIVING_EMBER);
                    me->CastCustomSpell(SPELL_METEOR_STRIKE_TARGETING, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    Talk(SAY_METEOR_STRIKE);
                    events.ScheduleEvent(EVENT_METEOR_STRIKE, 40s);
                    break;
                case EVENT_FIERY_COMBUSTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true, true, -SPELL_TWILIGHT_REALM))
                        me->CastSpell(target, SPELL_FIERY_COMBUSTION, false);
                    events.ScheduleEvent(EVENT_FIERY_COMBUSTION, 25s);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(75))
                    {
                        Talk(SAY_PHASE_TWO);
                        me->CastSpell(me, SPELL_TWILIGHT_PHASING, false);
                        events.DelayEvents(10s);
                        return;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 1s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events2;
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
            Creature* halion = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_HALION));
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
            me->SetPhaseMask(0x21, true);
            me->SetInCombatWithZone();
            me->SetPhaseMask(0x20, true);
            me->SetReactState(REACT_DEFENSIVE);
        }

        void JustEngagedWith(Unit*  /*who*/) override
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

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && _events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                _events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

        void JustDied(Unit* killer) override
        {
            if (Creature* halion = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_HALION)))
            {
                // Ensure looting
                if (me->IsDamageEnoughForLootingAndReward())
                    halion->LowerPlayerDamageReq(halion->GetMaxHealth());

                if (killer && halion->IsAlive())
                    Unit::Kill(killer, halion);
            }

            if (Creature* controller = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_HALION_CONTROLLER)))
                if (controller->IsAlive())
                    Unit::Kill(controller, controller);

            _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            me->CastSpell(me, SPELL_CLEAR_DEBUFFS, false);
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!attacker || !me->InSamePhase(attacker))
                return;

            if (Creature* controller = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_HALION_CONTROLLER)))
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
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    _events.ScheduleEvent(EVENT_CLEAVE, 8s, 10s);
                    break;
                case EVENT_TAIL_LASH:
                    me->CastSpell(me, SPELL_TAIL_LASH, false);
                    _events.ScheduleEvent(EVENT_TAIL_LASH, 10s);
                    break;
                case EVENT_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_DARK_BREATH, false);
                    _events.ScheduleEvent(EVENT_BREATH, 10s, 12s);
                    break;
                case EVENT_SOUL_CONSUMPTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true, true, SPELL_TWILIGHT_REALM))
                        me->CastSpell(target, SPELL_SOUL_CONSUMPTION, false);
                    _events.ScheduleEvent(EVENT_SOUL_CONSUMPTION, 20s);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(50))
                    {
                        me->CastStop();
                        me->CastSpell(me, SPELL_TWILIGHT_DIVISION, false);
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
                    if (Creature* orbCarrier = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_ORB_CARRIER)))
                        orbCarrier->AI()->DoAction(ACTION_SHOOT);
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
        npc_halion_controllerAI(Creature* creature) : NullCreatureAI(creature), _instance(creature->GetInstanceScript())
        {
        }

        void Reset() override
        {
            _events.Reset();
        }

        void SetData(uint32 id, uint32 value) override
        {
            if (_events.GetNextEventTime(EVENT_CHECK_CORPOREALITY) == 0)
                return;

            if (id == DATA_MATERIAL_DAMAGE_TAKEN)
                _materialDamage += value;
            else
                _twilightDamage += value;
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_INTRO_HALION)
                _events.ScheduleEvent(EVENT_START_INTRO, 2s);
            else if (action == ACTION_CHECK_CORPOREALITY)
            {
                _materialDamage = 1;
                _twilightDamage = 1;
                _corporeality = 5;
                _events.ScheduleEvent(EVENT_CHECK_CORPOREALITY, 7s);
            }
            else if (action == ACTION_RESET_ENCOUNTER)
            {
                _events.Reset();
                _materialDamage = 1;
                _twilightDamage = 1;
                _corporeality = 5;
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
                    if (Creature* halion = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_HALION)))
                    {
                        halion->SetVisible(true);
                        halion->SetReactState(REACT_AGGRESSIVE);
                        halion->AI()->Talk(SAY_INTRO);
                    }
                    break;
                case EVENT_TWILIGHT_MENDING:
                    me->CastSpell((Unit*)nullptr, SPELL_TWILIGHT_MENDING, true);
                    break;
                case EVENT_CHECK_CORPOREALITY:
                    UpdateCorporeality();
                    _events.ScheduleEvent(EVENT_CHECK_CORPOREALITY, 10s);
                    break;
            }
        }

    private:
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

            CorporealityEvent action = CORPOREALITY_NONE;
            if (damageRatio < 0.98f)
                action = CORPOREALITY_INCREASE;
            else if (1.02f < damageRatio)
                action = CORPOREALITY_DECREASE;
            else
                return;

            switch (action)
            {
                case CORPOREALITY_INCREASE:
                    {
                        if (_corporeality == (MAX_CORPOREALITY_STATE - 1))
                            return;
                        ++_corporeality;
                        break;
                    }
                case CORPOREALITY_DECREASE:
                    {
                        if (_corporeality == 0)
                            return;
                        --_corporeality;
                        break;
                    }
                default:
                    break;
            }

            _instance->DoUpdateWorldState(WORLDSTATE_CORPOREALITY_MATERIAL, _corporeality * 10);
            _instance->DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TWILIGHT, 100 - _corporeality * 10);

            if (Creature* twilightHalion = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_TWILIGHT_HALION)))
            {
                twilightHalion->RemoveAurasDueToSpell(_corporealityReference[MAX_CORPOREALITY_STATE - 1 - oldValue]);
                twilightHalion->CastSpell(twilightHalion, _corporealityReference[MAX_CORPOREALITY_STATE - 1 - _corporeality], true);
                twilightHalion->AI()->Talk(oldValue < _corporeality ? EMOTE_CORPOREALITY_TOT : EMOTE_CORPOREALITY_TIT);
            }

            if (Creature* halion = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_HALION)))
            {
                halion->RemoveAurasDueToSpell(_corporealityReference[oldValue]);
                halion->CastSpell(halion, _corporealityReference[_corporeality], true);
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
                me->CastSpell((Unit*)nullptr, SPELL_TRACK_ROTATION, false);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_SHOOT)
            {
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

class spell_halion_meteor_strike_targeting : public SpellScriptLoader
{
public:
    spell_halion_meteor_strike_targeting() : SpellScriptLoader("spell_halion_meteor_strike_targeting") { }

    class spell_halion_meteor_strike_targeting_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_meteor_strike_targeting_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
                GetCaster()->CastSpell(target, SPELL_METEOR_STRIKE, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_halion_meteor_strike_targeting_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_meteor_strike_targeting_SpellScript();
    }
};

class spell_halion_meteor_strike_marker : public SpellScriptLoader
{
public:
    spell_halion_meteor_strike_marker() : SpellScriptLoader("spell_halion_meteor_strike_marker") { }

    class spell_halion_meteor_strike_marker_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_meteor_strike_marker_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            SetDuration(6500);
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster())
            {
                if (!caster->GetInstanceScript() || !caster->GetInstanceScript()->IsEncounterInProgress())
                    return;

                caster->CastSpell(caster, SPELL_METEOR_STRIKE_AOE_DAMAGE, true);
                caster->CastSpell(caster, SPELL_METEOR_STRIKE_FIRE_AURA_1, true);
                for (uint32 spellId = SPELL_SUMMON_METEOR_STRIKE1; spellId <= SPELL_SUMMON_METEOR_STRIKE4; ++spellId)
                    caster->CastSpell(caster, spellId, true);
            }
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_halion_meteor_strike_marker_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_halion_meteor_strike_marker_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_meteor_strike_marker_AuraScript();
    }
};

class spell_halion_meteor_strike_spread : public SpellScriptLoader
{
public:
    spell_halion_meteor_strike_spread() : SpellScriptLoader("spell_halion_meteor_strike_spread") { }

    class spell_halion_meteor_strike_spread_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_meteor_strike_spread_AuraScript);

        void HandlePeriodic(AuraEffect const*  /*aurEff*/)
        {
            PreventDefaultAction(); // xinef: 3/5 straight, 2/5 turn
            if (!GetUnitOwner()->GetInstanceScript() || !GetUnitOwner()->GetInstanceScript()->IsEncounterInProgress())
                return;

            GetUnitOwner()->CastSpell(GetUnitOwner(), RAND(SPELL_SUMMON_METEOR_FLAME1, SPELL_SUMMON_METEOR_FLAME2, SPELL_SUMMON_METEOR_FLAME2, SPELL_SUMMON_METEOR_FLAME2, SPELL_SUMMON_METEOR_FLAME3), true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_halion_meteor_strike_spread_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_meteor_strike_spread_AuraScript();
    }
};

class spell_halion_blazing_aura : public SpellScriptLoader
{
public:
    spell_halion_blazing_aura() : SpellScriptLoader("spell_halion_blazing_aura") { }

    class spell_halion_blazing_aura_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_blazing_aura_SpellScript);

        void HandleForceCast(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
                target->CastSpell(target, GetSpellInfo()->Effects[effIndex].TriggerSpell, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_halion_blazing_aura_SpellScript::HandleForceCast, EFFECT_1, SPELL_EFFECT_FORCE_CAST);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_blazing_aura_SpellScript();
    }
};

class spell_halion_combustion_consumption : public SpellScriptLoader
{
public:
    spell_halion_combustion_consumption(char const* scriptName, uint32 spell) : SpellScriptLoader(scriptName), _spellID(spell) { }

    class spell_halion_combustion_consumption_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_combustion_consumption_AuraScript);

    public:
        spell_halion_combustion_consumption_AuraScript(uint32 spellID) : AuraScript(), _markSpell(spellID) { }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetTarget()->RemoveAurasDueToSpell(_markSpell, ObjectGuid::Empty, 0, AURA_REMOVE_BY_EXPIRE);
        }

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetTarget()->CastSpell(GetTarget(), _markSpell, true);
        }

        void AddMarkStack(AuraEffect const* /*aurEff*/)
        {
            GetTarget()->CastSpell(GetTarget(), _markSpell, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_halion_combustion_consumption_AuraScript::AddMarkStack, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
            AfterEffectApply += AuraEffectApplyFn(spell_halion_combustion_consumption_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_halion_combustion_consumption_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }

        uint32 _markSpell;
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_combustion_consumption_AuraScript(_spellID);
    }

private:
    uint32 _spellID;
};

class spell_halion_marks : public SpellScriptLoader
{
public:
    spell_halion_marks(char const* scriptName, uint32 summonSpell, uint32 removeSpell) : SpellScriptLoader(scriptName), _summonSpell(summonSpell), _removeSpell(removeSpell) { }

    class spell_halion_marks_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_marks_AuraScript);

    public:
        spell_halion_marks_AuraScript(uint32 summonSpell, uint32 removeSpell) : AuraScript(), _summonSpellId(summonSpell), _removeSpellId(removeSpell) { }

        void BeforeDispel(DispelInfo* dispelData)
        {
            dispelData->SetRemovedCharges(0);

            if (Unit* dispelledUnit = GetUnitOwner())
                if (dispelledUnit->HasAura(_removeSpellId))
                    dispelledUnit->RemoveAurasDueToSpell(_removeSpellId, ObjectGuid::Empty, 0, AURA_REMOVE_BY_EXPIRE);
        }

        void OnRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
                return;

            if (!GetTarget()->GetInstanceScript() || !GetTarget()->GetInstanceScript()->IsEncounterInProgress() || GetTarget()->GetMapId() != 724)
                return;

            GetTarget()->CastCustomSpell(_summonSpellId, SPELLVALUE_BASE_POINT1, GetAura()->GetStackAmount(), GetTarget(), TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());
        }

        void Register() override
        {
            OnDispel += AuraDispelFn(spell_halion_marks_AuraScript::BeforeDispel);
            AfterEffectRemove += AuraEffectRemoveFn(spell_halion_marks_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }

        uint32 _summonSpellId;
        uint32 _removeSpellId;
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_marks_AuraScript(_summonSpell, _removeSpell);
    }

private:
    uint32 _summonSpell;
    uint32 _removeSpell;
};

class spell_halion_damage_aoe_summon : public SpellScriptLoader
{
public:
    spell_halion_damage_aoe_summon(char const* scriptName, uint32 explosionSpell, uint32 auraSpell) : SpellScriptLoader(scriptName), _explosionSpell(explosionSpell), _auraSpell(auraSpell) { }

    class spell_halion_damage_aoe_summon_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_damage_aoe_summon_SpellScript);

    public:
        spell_halion_damage_aoe_summon_SpellScript(uint32 explosionSpell, uint32 auraSpell) : SpellScript(), _explosionSpell(explosionSpell), _auraSpell(auraSpell) { }

        void HandleSummon(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            Unit* caster = GetCaster();
            uint32 entry = uint32(GetSpellInfo()->Effects[effIndex].MiscValue);
            SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(uint32(GetSpellInfo()->Effects[effIndex].MiscValueB));
            uint32 duration = uint32(GetSpellInfo()->GetDuration());

            Position pos = caster->GetPosition();
            if (Creature* summon = caster->GetMap()->SummonCreature(entry, pos, properties, duration, caster, GetSpellInfo()->Id))
            {
                bool heroic = summon->GetMap()->IsHeroic();
                bool raid = summon->GetMap()->Is25ManRaid();

                if (heroic)
                    summon->SetPhaseMask(0x01 | 0x20, true);
                else if (summon->GetEntry() == NPC_COMBUSTION)
                    summon->SetPhaseMask(0x01, true);
                else
                    summon->SetPhaseMask(0x20, true);

                summon->CastCustomSpell(SPELL_SCALE_AURA, SPELLVALUE_AURA_STACK, GetSpellValue()->EffectBasePoints[EFFECT_1], summon);
                summon->CastSpell(summon, _auraSpell, true);

                int32 damage = int32((1500 + (GetSpellValue()->EffectBasePoints[EFFECT_1] * 1250)) * (heroic ? 1.25f : 1.0f) * (raid ? 1.5f : 1.0f));
                caster->CastCustomSpell(_explosionSpell, SPELLVALUE_BASE_POINT0, damage, caster);
            }
        }

        void Register() override
        {
            OnEffectHit += SpellEffectFn(spell_halion_damage_aoe_summon_SpellScript::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
        }

        uint32 _explosionSpell;
        uint32 _auraSpell;
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_damage_aoe_summon_SpellScript(_explosionSpell, _auraSpell);
    }

private:
    uint32 _explosionSpell;
    uint32 _auraSpell;
};

class spell_halion_clear_debuffs : public SpellScriptLoader
{
public:
    spell_halion_clear_debuffs() : SpellScriptLoader("spell_halion_clear_debuffs") { }

    class spell_halion_clear_debuffs_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_clear_debuffs_SpellScript);

        void HandleScriptEffect(SpellEffIndex  /*effIndex*/)
        {
            if (GetHitUnit())
            {
                GetHitUnit()->RemoveAurasDueToSpell(GetSpellInfo()->Effects[EFFECT_0].CalcValue());
                GetHitUnit()->RemoveAurasDueToSpell(GetSpellInfo()->Effects[EFFECT_1].CalcValue());
                GetHitUnit()->RemoveAurasDueToSpell(SPELL_FIERY_COMBUSTION);
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_halion_clear_debuffs_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_clear_debuffs_SpellScript();
    }
};

class spell_halion_twilight_phasing : public SpellScriptLoader
{
public:
    spell_halion_twilight_phasing() : SpellScriptLoader("spell_halion_twilight_phasing") { }

    class spell_halion_twilight_phasing_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_twilight_phasing_SpellScript);

        bool Load() override
        {
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void Phase()
        {
            Unit* caster = GetCaster();
            caster->CastSpell(caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ(), SPELL_SUMMON_TWILIGHT_PORTAL, true);
            caster->GetMap()->SummonCreature(NPC_TWILIGHT_HALION, caster->ToCreature()->GetHomePosition(), nullptr, 0, caster);
        }

        void Register() override
        {
            OnHit += SpellHitFn(spell_halion_twilight_phasing_SpellScript::Phase);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_twilight_phasing_SpellScript();
    }

    class spell_halion_twilight_phasing_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_twilight_phasing_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*handle*/)
        {
            GetTarget()->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            GetTarget()->ToCreature()->SetReactState(REACT_DEFENSIVE);
            GetTarget()->GetMotionMaster()->Clear();
            GetTarget()->GetThreatMgr().clearReferences();
            GetTarget()->RemoveAllAttackers();
            GetTarget()->AttackStop();
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*handle*/)
        {
            GetTarget()->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            GetTarget()->ToCreature()->SetReactState(REACT_DEFENSIVE);
            GetTarget()->GetMotionMaster()->Clear();
            GetTarget()->GetThreatMgr().clearReferences();
            GetTarget()->RemoveAllAttackers();
            GetTarget()->AttackStop();
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_halion_twilight_phasing_AuraScript::OnApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_halion_twilight_phasing_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_twilight_phasing_AuraScript();
    }
};

class spell_halion_twilight_realm : public SpellScriptLoader
{
public:
    spell_halion_twilight_realm() : SpellScriptLoader("spell_halion_twilight_realm") { }

    class spell_halion_twilight_realm_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_twilight_realm_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*handle*/)
        {
            Unit* target = GetTarget();
            if (!target)
                return;

            target->RemoveAurasDueToSpell(SPELL_FIERY_COMBUSTION, ObjectGuid::Empty, 0, AURA_REMOVE_BY_ENEMY_SPELL);
            if (GetTarget()->GetTypeId() != TYPEID_PLAYER)
                return;
            GetTarget()->m_Events.AddEvent(new SendEncounterUnit(GetTarget()->ToPlayer()), GetTarget()->m_Events.CalculateTime(500));
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_halion_twilight_realm_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PHASE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_twilight_realm_AuraScript();
    }
};

class spell_halion_leave_twilight_realm : public SpellScriptLoader
{
public:
    spell_halion_leave_twilight_realm() : SpellScriptLoader("spell_halion_leave_twilight_realm") { }

    class spell_halion_leave_twilight_realm_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_leave_twilight_realm_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*handle*/)
        {
            Unit* target = GetTarget();
            if (!target)
                return;

            target->RemoveAurasDueToSpell(SPELL_SOUL_CONSUMPTION, ObjectGuid::Empty, 0, AURA_REMOVE_BY_ENEMY_SPELL);
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*handle*/)
        {
            GetTarget()->RemoveAurasDueToSpell(SPELL_TWILIGHT_REALM);

            if (GetTarget()->GetTypeId() != TYPEID_PLAYER)
                return;
            GetTarget()->m_Events.AddEvent(new SendEncounterUnit(GetTarget()->ToPlayer()), GetTarget()->m_Events.CalculateTime(500));
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_halion_leave_twilight_realm_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_halion_leave_twilight_realm_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_leave_twilight_realm_AuraScript();
    }
};

class spell_halion_twilight_cutter_periodic : public SpellScriptLoader
{
public:
    spell_halion_twilight_cutter_periodic() : SpellScriptLoader("spell_halion_twilight_cutter_periodic") { }

    class spell_halion_twilight_cutter_periodic_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_halion_twilight_cutter_periodic_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            GetUnitOwner()->CastSpell((Unit*)nullptr, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_halion_twilight_cutter_periodic_AuraScript::HandlePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_halion_twilight_cutter_periodic_AuraScript();
    }
};

class TwilightCutterSelector
{
public:
    TwilightCutterSelector(WorldObject* caster, WorldObject* cutterCaster) : _caster(caster), _cutterCaster(cutterCaster) {}

    bool operator()(WorldObject* unit)
    {
        return !unit->IsInBetween(_caster, _cutterCaster, 2.5f);
    }

private:
    WorldObject* _caster;
    WorldObject* _cutterCaster;
};

class spell_halion_twilight_cutter : public SpellScriptLoader
{
public:
    spell_halion_twilight_cutter() : SpellScriptLoader("spell_halion_twilight_cutter") { }

    class spell_halion_twilight_cutter_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_twilight_cutter_SpellScript);

        void RemoveNotBetween(std::list<WorldObject*>& unitList)
        {
            if (unitList.empty())
                return;

            if (Aura* cutter = GetCaster()->GetAura(SPELL_TWILIGHT_CUTTER))
                if (Unit* cutterCaster = cutter->GetCaster())
                {
                    unitList.remove_if(TwilightCutterSelector(GetCaster(), cutterCaster));
                    return;
                }

            unitList.clear();
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_halion_twilight_cutter_SpellScript::RemoveNotBetween, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_twilight_cutter_SpellScript();
    }
};

class spell_halion_summon_exit_portals : public SpellScriptLoader
{
public:
    spell_halion_summon_exit_portals() : SpellScriptLoader("spell_halion_summon_exit_portals") { }

    class spell_halion_summon_exit_portals_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_summon_exit_portals_SpellScript);

        void OnSummon(SpellEffIndex effIndex)
        {
            WorldLocation summonPos = *GetExplTargetDest();
            Position offset = {0.0f, 0.0f, 0.0f, 0.0f};
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
            OnEffectLaunch += SpellEffectFn(spell_halion_summon_exit_portals_SpellScript::OnSummon, EFFECT_0, SPELL_EFFECT_SUMMON_OBJECT_WILD);
            OnEffectLaunch += SpellEffectFn(spell_halion_summon_exit_portals_SpellScript::OnSummon, EFFECT_1, SPELL_EFFECT_SUMMON_OBJECT_WILD);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_summon_exit_portals_SpellScript();
    }
};

class spell_halion_twilight_division : public SpellScriptLoader
{
public:
    spell_halion_twilight_division() : SpellScriptLoader("spell_halion_twilight_division") { }

    class spell_halion_twilight_division_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_twilight_division_SpellScript);

        void HandleDummy(SpellEffIndex  /*effIndex*/)
        {
            InstanceScript* instance = GetCaster()->GetInstanceScript();
            Creature* controller = ObjectAccessor::GetCreature(*GetCaster(), instance->GetGuidData(NPC_HALION_CONTROLLER));
            Creature* halion = ObjectAccessor::GetCreature(*GetCaster(), instance->GetGuidData(NPC_HALION));

            if (!controller || !halion)
                return;

            GetCaster()->CastSpell(GetCaster(), _corporealityReference[5], true);
            halion->CastSpell(halion, _corporealityReference[5], true);

            controller->CastSpell(controller, SPELL_SUMMON_EXIT_PORTALS_NORMAL, true);
            controller->CastSpell(controller, SPELL_SUMMON_EXIT_PORTALS, true);
            controller->AI()->DoAction(ACTION_CHECK_CORPOREALITY);

            halion->RemoveAurasDueToSpell(SPELL_TWILIGHT_PHASING);
            if (GameObject* gobject = halion->FindNearestGameObject(GO_HALION_PORTAL_1, 100.0f))
                gobject->Delete();

            instance->DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TOGGLE, 1);
            instance->DoUpdateWorldState(WORLDSTATE_CORPOREALITY_MATERIAL, 50);
            instance->DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TWILIGHT, 50);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_halion_twilight_division_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_twilight_division_SpellScript();
    }
};

class spell_halion_twilight_mending : public SpellScriptLoader
{
public:
    spell_halion_twilight_mending() : SpellScriptLoader("spell_halion_twilight_mending") { }

    class spell_halion_twilight_mending_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halion_twilight_mending_SpellScript);

        void HandleHealPct(SpellEffIndex  /*effIndex*/)
        {
            if (Creature* target = GetHitCreature())
                target->AI()->Talk(SAY_REGENERATE);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_halion_twilight_mending_SpellScript::HandleHealPct, EFFECT_ALL, SPELL_EFFECT_HEAL_PCT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_halion_twilight_mending_SpellScript();
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
            me->CastSpell(me, SPELL_BLAZING_AURA, true);

            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* controller = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_HALION_CONTROLLER)))
                    controller->AI()->JustSummoned(me);
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->DespawnOrUnsummon(1);
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

    new spell_halion_meteor_strike_targeting();
    new spell_halion_meteor_strike_marker();
    new spell_halion_meteor_strike_spread();
    new spell_halion_blazing_aura();
    new spell_halion_combustion_consumption("spell_halion_soul_consumption", SPELL_MARK_OF_CONSUMPTION);
    new spell_halion_combustion_consumption("spell_halion_fiery_combustion", SPELL_MARK_OF_COMBUSTION);
    new spell_halion_marks("spell_halion_mark_of_combustion", SPELL_FIERY_COMBUSTION_SUMMON, SPELL_FIERY_COMBUSTION);
    new spell_halion_marks("spell_halion_mark_of_consumption", SPELL_SOUL_CONSUMPTION_SUMMON, SPELL_SOUL_CONSUMPTION);
    new spell_halion_damage_aoe_summon("spell_halion_combustion_summon", SPELL_FIERY_COMBUSTION_EXPLOSION, SPELL_COMBUSTION_DAMAGE_AURA);
    new spell_halion_damage_aoe_summon("spell_halion_consumption_summon", SPELL_SOUL_CONSUMPTION_EXPLOSION, SPELL_CONSUMPTION_DAMAGE_AURA);
    new spell_halion_clear_debuffs();
    new spell_halion_twilight_phasing();
    new spell_halion_twilight_realm();
    new spell_halion_leave_twilight_realm();
    new spell_halion_twilight_cutter_periodic();
    new spell_halion_twilight_cutter();
    new spell_halion_summon_exit_portals();
    new spell_halion_twilight_division();
    new spell_halion_twilight_mending();
}

