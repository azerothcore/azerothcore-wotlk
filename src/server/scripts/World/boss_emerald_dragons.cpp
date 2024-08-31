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
#include "GridNotifiers.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"

//
//  Emerald Dragon NPCs and IDs (kept here for reference)
//

enum EmeraldDragonNPC
{
    NPC_DREAM_FOG                   = 15224,
    DRAGON_YSONDRE                  = 14887,
    DRAGON_LETHON                   = 14888,
    DRAGON_EMERISS                  = 14889,
    DRAGON_TAERAR                   = 14890,

    GUID_DRAGON                     = 1,
    GUID_FOG_TARGET                 = 2
};

//
// Emerald Dragon Spells (used for the dragons)
//

enum EmeraldDragonSpells
{
    SPELL_TAIL_SWEEP                = 15847,    // tail sweep - slap everything behind dragon (2 seconds interval)
    SPELL_SUMMON_PLAYER             = 24776,    // teleport highest threat player in front of dragon if wandering off
    SPELL_DREAM_FOG                 = 24777,    // auraspell for Dream Fog NPC (15224)
    SPELL_SLEEP                     = 24778,    // sleep triggerspell (used for Dream Fog)
    SPELL_SEEPING_FOG_LEFT          = 24813,    // dream fog - summon left
    SPELL_SEEPING_FOG_RIGHT         = 24814,    // dream fog - summon right
    SPELL_NOXIOUS_BREATH            = 24818,
    SPELL_MARK_OF_NATURE            = 25040,    // Mark of Nature trigger (applied on target death - 15 minutes of being suspectible to Aura Of Nature)
    SPELL_MARK_OF_NATURE_AURA       = 25041,    // Mark of Nature (passive marker-test, ticks every 10 seconds from boss, triggers spellID 25042 (scripted)
    SPELL_AURA_OF_NATURE            = 25043,    // Stun for 2 minutes (used when SPELL_MARK_OF_NATURE exists on the target)
};

//
// Emerald Dragon Eventlists (shared and specials)
//

enum Events
{
    // General events for all dragons
    EVENT_SEEPING_FOG = 1,
    EVENT_NOXIOUS_BREATH,
    EVENT_TAIL_SWEEP,
    EVENT_SUMMON_PLAYER,

    // Ysondre
    EVENT_LIGHTNING_WAVE,
    EVENT_SUMMON_DRUID_SPIRITS,

    // Lethon
    EVENT_SHADOW_BOLT_WHIRL,

    // Emeriss
    EVENT_VOLATILE_INFECTION,
    EVENT_CORRUPTION_OF_EARTH,

    // Taerar
    EVENT_ARCANE_BLAST,
    EVENT_BELLOWING_ROAR,
};

/*
 * ---
 * --- Emerald Dragons : Base AI-structure used for all the Emerald dragons
 * ---
 */

struct emerald_dragonAI : public WorldBossAI
{
    emerald_dragonAI(Creature* creature) : WorldBossAI(creature)
    {
    }

    void Reset() override
    {
        WorldBossAI::Reset();
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        me->SetReactState(REACT_AGGRESSIVE);
        DoCast(me, SPELL_MARK_OF_NATURE_AURA, true);
        events.ScheduleEvent(EVENT_TAIL_SWEEP, 4000);
        events.ScheduleEvent(EVENT_NOXIOUS_BREATH, urand(7500, 15000));
        events.ScheduleEvent(EVENT_SEEPING_FOG, urand(12500, 20000));
        events.ScheduleEvent(EVENT_SUMMON_PLAYER, 1s);
    }

    // Target killed during encounter, mark them as suspectible for Aura Of Nature
    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
            who->CastSpell(who, SPELL_MARK_OF_NATURE, true);
    }

    // Execute and reschedule base events shared between all Emerald Dragons
    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SEEPING_FOG:
                // Seeping Fog appears only as "pairs", and only ONE pair at any given time!
                // Despawntime is 2 minutes, so reschedule it for new cast after 2 minutes + a minor "random time" (30 seconds at max)
                DoCast(me, SPELL_SEEPING_FOG_LEFT, true);
                DoCast(me, SPELL_SEEPING_FOG_RIGHT, true);
                events.ScheduleEvent(EVENT_SEEPING_FOG, urand(120000, 150000));
                break;
            case EVENT_NOXIOUS_BREATH:
                // Noxious Breath is cast on random intervals, no less than 7.5 seconds between
                DoCast(me, SPELL_NOXIOUS_BREATH);
                events.ScheduleEvent(EVENT_NOXIOUS_BREATH, urand(7500, 15000));
                break;
            case EVENT_TAIL_SWEEP:
                // Tail Sweep is cast every two seconds, no matter what goes on in front of the dragon
                DoCast(me, SPELL_TAIL_SWEEP);
                events.ScheduleEvent(EVENT_TAIL_SWEEP, 2000);
                break;
            case EVENT_SUMMON_PLAYER:
                if (Unit* target = me->GetVictim())
                    if (!target->IsWithinRange(me, 50.f))
                        DoCast(target, SPELL_SUMMON_PLAYER);
                events.ScheduleEvent(EVENT_SUMMON_PLAYER, 500ms);
                break;
        }
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() == NPC_DREAM_FOG)
        {
            summon->AI()->SetGUID(me->GetGUID(), GUID_DRAGON);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
            ExecuteEvent(eventId);

        DoMeleeAttackIfReady();
    }
};

/*
 * --- NPC: Dream Fog
 */

class npc_dream_fog : public CreatureScript
{
public:
    npc_dream_fog() : CreatureScript("npc_dream_fog") { }

    struct npc_dream_fogAI : public ScriptedAI
    {
        npc_dream_fogAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            ScheduleEvents();
        }

        void ScheduleEvents()
        {
            scheduler.CancelAll();

            scheduler.Schedule(1s, [this](TaskContext context)
            {
                // Chase target, but don't attack - otherwise just roam around
                if (Unit* chaseTarget = GetRandomUnitFromDragonThreatList())
                {
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveFollow(chaseTarget, 0.02f, 0.0f);
                    _targetGUID = chaseTarget->GetGUID();
                    context.Repeat(15s, 30s);
                }
                else
                {
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveRandom(25.0f);
                    context.Repeat(2500ms);
                }

                // Seeping fog movement is slow enough for a player to be able to walk backwards and still outpace it
                me->SetWalk(true);
                me->SetSpeed(MOVE_WALK, 0.75f);
            });
        }

        void SetGUID(ObjectGuid guid, int32 type) override
        {
            if (type == GUID_DRAGON)
            {
                _dragonGUID = guid;
            }
            else if (type == GUID_FOG_TARGET)
            {
                if (guid == _targetGUID)
                {
                    ScheduleEvents();
                }
            }
        }

        Unit* GetRandomUnitFromDragonThreatList()
        {
            if (Creature* dragon = ObjectAccessor::GetCreature(*me, _dragonGUID))
            {
                if (dragon->GetAI())
                {
                    return dragon->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true);
                }
            }

            return nullptr;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            scheduler.Update(diff);
        }

    private:
        ObjectGuid _targetGUID;
        ObjectGuid _dragonGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_dream_fogAI(creature);
    }
};

/*
 * ---
 * --- Dragonspecific scripts and handling: YSONDRE
 * ---
 */

enum YsondreNPC
{
    NPC_DEMENTED_DRUID              = 15260,
};

enum YsondreTexts
{
    SAY_YSONDRE_AGGRO               = 0,
    SAY_YSONDRE_SUMMON_DRUIDS       = 1,
};

enum YsondreSpells
{
    SPELL_LIGHTNING_WAVE            = 24819,
    SPELL_SUMMON_DRUID_SPIRITS      = 24795,
};

class boss_ysondre : public CreatureScript
{
public:
    boss_ysondre() : CreatureScript("boss_ysondre") { }

    struct boss_ysondreAI : public emerald_dragonAI
    {
        boss_ysondreAI(Creature* creature) : emerald_dragonAI(creature)
        {
        }

        void Reset() override
        {
            _stage = 1;
            emerald_dragonAI::Reset();
            events.ScheduleEvent(EVENT_LIGHTNING_WAVE, 12000);
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_YSONDRE_AGGRO);
            WorldBossAI::JustEngagedWith(who);
        }

        // Summon druid spirits on 75%, 50% and 25% health
        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_stage <= 3 && me->HealthBelowPctDamaged(100 - (25 * _stage), damage))
            {
                Talk(SAY_YSONDRE_SUMMON_DRUIDS);

                auto const& attackers = me->GetThreatMgr().GetThreatList();
                uint8 attackersCount = 0;

                for (const auto attacker : attackers)
                {
                    if ((*attacker)->ToPlayer() && (*attacker)->IsAlive())
                        ++attackersCount;
                }

                uint8 amount = attackersCount < 30 ? attackersCount * 0.5f : 15;
                amount = amount < 1 ? 1 : amount;

                for (uint8 i = 0; i < amount; ++i)
                    DoCast(me, SPELL_SUMMON_DRUID_SPIRITS, true);
                ++_stage;
            }
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_LIGHTNING_WAVE:
                    DoCastVictim(SPELL_LIGHTNING_WAVE);
                    events.ScheduleEvent(EVENT_LIGHTNING_WAVE, urand(10000, 20000));
                    break;
                default:
                    emerald_dragonAI::ExecuteEvent(eventId);
                    break;
            }
        }

    private:
        uint8 _stage;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_ysondreAI(creature);
    }
};

/*
 * ---
 * --- Dragonspecific scripts and handling: LETHON
 * ---
 */

enum LethonTexts
{
    SAY_LETHON_AGGRO                = 0,
    SAY_LETHON_DRAW_SPIRIT          = 1,
};

enum LethonSpells
{
    SPELL_DRAW_SPIRIT               = 24811,
    SPELL_SHADOW_BOLT_WHIRL         = 24834,
    SPELL_DARK_OFFERING             = 24804,
    SPELL_SHADOW_BOLT_WHIRL1        = 24820,
    SPELL_SHADOW_BOLT_WHIRL2        = 24821,
    SPELL_SHADOW_BOLT_WHIRL3        = 24822,
    SPELL_SHADOW_BOLT_WHIRL4        = 24823,
    SPELL_SHADOW_BOLT_WHIRL5        = 24835,
    SPELL_SHADOW_BOLT_WHIRL6        = 24836,
    SPELL_SHADOW_BOLT_WHIRL7        = 24837,
    SPELL_SHADOW_BOLT_WHIRL8        = 24838,
};

enum LethonCreatures
{
    NPC_SPIRIT_SHADE                = 15261,
};

class boss_lethon : public CreatureScript
{
public:
    boss_lethon() : CreatureScript("boss_lethon") { }

    struct boss_lethonAI : public emerald_dragonAI
    {
        boss_lethonAI(Creature* creature) : emerald_dragonAI(creature)
        {
        }

        void Reset() override
        {
            _stage = 1;
            emerald_dragonAI::Reset();
            me->RemoveAurasDueToSpell(SPELL_SHADOW_BOLT_WHIRL);
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_LETHON_AGGRO);
            WorldBossAI::JustEngagedWith(who);
            DoCastSelf(SPELL_SHADOW_BOLT_WHIRL, true);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_stage <= 3 && me->HealthBelowPctDamaged(100 - (25 * _stage), damage))
            {
                Talk(SAY_LETHON_DRAW_SPIRIT);
                DoCast(me, SPELL_DRAW_SPIRIT);
                ++_stage;
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_DRAW_SPIRIT && target->IsPlayer())
            {
                Position targetPos = target->GetPosition();
                me->SummonCreature(NPC_SPIRIT_SHADE, targetPos, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 50000);
            }
        }

    private:
        uint8 _stage;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_lethonAI(creature);
    }
};

class npc_spirit_shade : public CreatureScript
{
public:
    npc_spirit_shade() : CreatureScript("npc_spirit_shade") { }

    struct npc_spirit_shadeAI : public PassiveAI
    {
        npc_spirit_shadeAI(Creature* creature) : PassiveAI(creature)
        {
        }

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
                return;

            if (summoner->GetTypeId() != TYPEID_UNIT)
            {
                return;
            }

            _summonerGuid = summoner->GetGUID();
            me->GetMotionMaster()->MoveFollow(summoner->ToUnit(), 0.0f, 0.0f);
        }

        void MovementInform(uint32 moveType, uint32 data) override
        {
            if (moveType == FOLLOW_MOTION_TYPE && data == _summonerGuid.GetCounter())
            {
                me->CastSpell((Unit*)nullptr, SPELL_DARK_OFFERING, false);
                me->DespawnOrUnsummon(1000);
            }
        }

    private:
        ObjectGuid _summonerGuid;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_spirit_shadeAI(creature);
    }
};

/*
 * ---
 * --- Dragonspecific scripts and handling: EMERISS
 * ---
 */

enum EmerissTexts
{
    SAY_EMERISS_AGGRO               = 0,
    SAY_EMERISS_CAST_CORRUPTION     = 1,
};

enum EmerissSpells
{
    SPELL_PUTRID_MUSHROOM           = 24904,
    SPELL_CORRUPTION_OF_EARTH       = 24910,
    SPELL_VOLATILE_INFECTION        = 24928,
};

class boss_emeriss : public CreatureScript
{
public:
    boss_emeriss() : CreatureScript("boss_emeriss") { }

    struct boss_emerissAI : public emerald_dragonAI
    {
        boss_emerissAI(Creature* creature) : emerald_dragonAI(creature)
        {
        }

        void Reset() override
        {
            _stage = 1;
            emerald_dragonAI::Reset();
            events.ScheduleEvent(EVENT_VOLATILE_INFECTION, 12000);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
            {
                who->CastSpell(who, SPELL_PUTRID_MUSHROOM, true);
            }

            emerald_dragonAI::KilledUnit(who);
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_EMERISS_AGGRO);
            WorldBossAI::JustEngagedWith(who);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_stage <= 3 && me->HealthBelowPctDamaged(100 - (25 * _stage), damage))
            {
                Talk(SAY_EMERISS_CAST_CORRUPTION);
                DoCast(me, SPELL_CORRUPTION_OF_EARTH, true);
                ++_stage;
            }
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_VOLATILE_INFECTION:
                    DoCastVictim(SPELL_VOLATILE_INFECTION);
                    events.ScheduleEvent(EVENT_VOLATILE_INFECTION, 120000);
                    break;
                default:
                    emerald_dragonAI::ExecuteEvent(eventId);
                    break;
            }
        }

    private:
        uint8 _stage;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_emerissAI(creature);
    }
};

/*
 * ---
 * --- Dragonspecific scripts and handling: TAERAR
 * ---
 */

enum TaerarTexts
{
    SAY_TAERAR_AGGRO                = 0,
    SAY_TAERAR_SUMMON_SHADES        = 1,
};

enum TaerarSpells
{
    SPELL_BELLOWING_ROAR            = 22686,
    SPELL_SHADE                     = 24313,
    SPELL_SUMMON_SHADE_1            = 24841,
    SPELL_SUMMON_SHADE_2            = 24842,
    SPELL_SUMMON_SHADE_3            = 24843,
    SPELL_ARCANE_BLAST              = 24857,
};

uint32 const TaerarShadeSpells[] =
{
    SPELL_SUMMON_SHADE_1, SPELL_SUMMON_SHADE_2, SPELL_SUMMON_SHADE_3
};
class boss_taerar : public CreatureScript
{
public:
    boss_taerar() : CreatureScript("boss_taerar") { }

    struct boss_taerarAI : public emerald_dragonAI
    {
        boss_taerarAI(Creature* creature) : emerald_dragonAI(creature)
        {
        }

        void Reset() override
        {
            me->RemoveAurasDueToSpell(SPELL_SHADE);
            _stage = 1;

            _shades = 0;
            _banished = false;
            _banishedTimer = 0;

            emerald_dragonAI::Reset();
            events.ScheduleEvent(EVENT_ARCANE_BLAST, 12000);
            events.ScheduleEvent(EVENT_BELLOWING_ROAR, 30000);
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_TAERAR_AGGRO);
            emerald_dragonAI::JustEngagedWith(who);
        }

        void SummonedCreatureDies(Creature* /*summon*/, Unit*) override
        {
            --_shades;
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            // At 75, 50 or 25 percent health, we need to activate the shades and go "banished"
            // Note: _stage holds the amount of times they have been summoned
            if (_stage <= 3 && !_banished && me->HealthBelowPctDamaged(100 - (25 * _stage), damage))
            {
                _banished = true;
                _banishedTimer = 60000;

                me->InterruptNonMeleeSpells(false);
                DoStopAttack();

                Talk(SAY_TAERAR_SUMMON_SHADES);

                uint32 count = sizeof(TaerarShadeSpells) / sizeof(uint32);
                for (uint32 i = 0; i < count; ++i)
                    DoCast(TaerarShadeSpells[i]);
                _shades += count;
                DoCast(SPELL_SHADE);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_PASSIVE);

                ++_stage;
            }
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_ARCANE_BLAST:
                    DoCast(SPELL_ARCANE_BLAST);
                    events.ScheduleEvent(EVENT_ARCANE_BLAST, urand(7000, 12000));
                    break;
                case EVENT_BELLOWING_ROAR:
                    DoCast(SPELL_BELLOWING_ROAR);
                    events.ScheduleEvent(EVENT_BELLOWING_ROAR, urand(20000, 30000));
                    break;
                default:
                    emerald_dragonAI::ExecuteEvent(eventId);
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat())
                return;

            if (_banished)
            {
                // If all three shades are dead, OR it has taken too long, end the current event and get Taerar back into business
                if (_banishedTimer <= diff || !_shades)
                {
                    _banished = false;

                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                    me->RemoveAurasDueToSpell(SPELL_SHADE);
                    me->SetReactState(REACT_AGGRESSIVE);
                }
                // _banishtimer has not expired, and we still have active shades:
                else
                    _banishedTimer -= diff;

                // Update the events before we return (handled under emerald_dragonAI::UpdateAI(diff); if we're not inside this check)
                events.Update(diff);

                return;
            }
            emerald_dragonAI::UpdateAI(diff);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        }

    private:
        bool   _banished;                              // used for shades activation testing
        uint32 _banishedTimer;                         // counter for banishment timeout
        uint8  _shades;                                // keep track of how many shades are dead
        uint8  _stage;                                 // check which "shade phase" we're at (75-50-25 percentage counters)
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_taerarAI(creature);
    }
};

/*
 * --- Spell: Dream Fog
 */

class spell_dream_fog_sleep : public SpellScript
{
    PrepareSpellScript(spell_dream_fog_sleep);

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* target = GetHitUnit())
            {
                caster->GetAI()->SetGUID(target->GetGUID(), GUID_FOG_TARGET);
            }
        }
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_SLEEP));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dream_fog_sleep::HandleEffect, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dream_fog_sleep::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

/*
 * --- Spell: Mark of Nature
 */

class MarkOfNatureTargetSelector
{
public:
    MarkOfNatureTargetSelector() { }

    bool operator()(WorldObject* object)
    {
        // return those not tagged or already under the influence of Aura of Nature
        if (Unit* unit = object->ToUnit())
            return !(unit->HasAura(SPELL_MARK_OF_NATURE) && !unit->HasAura(SPELL_AURA_OF_NATURE));
        return true;
    }
};

class spell_shadow_bolt_whirl : public AuraScript
{
    PrepareAuraScript(spell_shadow_bolt_whirl);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOW_BOLT_WHIRL1, SPELL_SHADOW_BOLT_WHIRL2, SPELL_SHADOW_BOLT_WHIRL3, SPELL_SHADOW_BOLT_WHIRL4, SPELL_SHADOW_BOLT_WHIRL5, SPELL_SHADOW_BOLT_WHIRL6, SPELL_SHADOW_BOLT_WHIRL7, SPELL_SHADOW_BOLT_WHIRL8 });
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        Unit* caster = GetCaster();
        Unit* target = GetTarget();

        if (!caster || !target)
            return;
        std::array<uint32, 8> spellForTick = { SPELL_SHADOW_BOLT_WHIRL1, SPELL_SHADOW_BOLT_WHIRL2, SPELL_SHADOW_BOLT_WHIRL3, SPELL_SHADOW_BOLT_WHIRL4, SPELL_SHADOW_BOLT_WHIRL5, SPELL_SHADOW_BOLT_WHIRL6, SPELL_SHADOW_BOLT_WHIRL7, SPELL_SHADOW_BOLT_WHIRL8 };
        uint32 tick = (aurEff->GetTickNumber() + 7/*-1*/) % 8;

        // casted in left/right (but triggered spell have wide forward cone)
        float forward = target->GetOrientation();
        if (tick <= 3)
            target->SetOrientation(forward + 0.75f * M_PI - tick * M_PI / 8);       // Left
        else
            target->SetOrientation(forward - 0.75f * M_PI + (8 - tick) * M_PI / 8); // Right

        target->CastSpell(target, spellForTick[tick], true);
        target->SetOrientation(forward);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadow_bolt_whirl::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};
class spell_mark_of_nature : public SpellScript
{
    PrepareSpellScript(spell_mark_of_nature);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MARK_OF_NATURE, SPELL_AURA_OF_NATURE });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(MarkOfNatureTargetSelector());
    }

    void HandleEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_AURA_OF_NATURE, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mark_of_nature::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_mark_of_nature::HandleEffect, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

void AddSC_emerald_dragons()
{
    // helper NPC scripts
    new npc_dream_fog();
    new npc_spirit_shade();

    // dragons
    new boss_ysondre();
    new boss_taerar();
    new boss_emeriss();
    new boss_lethon();

    // dragon spellscripts
    RegisterSpellScript(spell_dream_fog_sleep);
    RegisterSpellScript(spell_mark_of_nature);
    RegisterSpellScript(spell_shadow_bolt_whirl);
};
