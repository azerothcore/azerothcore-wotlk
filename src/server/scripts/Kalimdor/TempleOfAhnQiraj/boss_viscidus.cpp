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
#include "temple_of_ahnqiraj.h"

enum Spells
{
    // Viscidus - Glob of Viscidus
    SPELL_POISON_SHOCK          = 25993,
    SPELL_POISONBOLT_VOLLEY     = 25991,
    SPELL_SUMMON_TOXIN_SLIME    = 26584,
    SPELL_SUMMON_TOXIN_SLIME_2  = 26577,
    SPELL_VISCIDUS_SLOWED       = 26034,
    SPELL_VISCIDUS_SLOWED_MORE  = 26036,
    SPELL_VISCIDUS_FREEZE       = 25937,
    SPELL_REJOIN_VISCIDUS       = 25896,
    SPELL_EXPLODE_TRIGGER       = 25938,
    SPELL_VISCIDUS_SHRINKS      = 25893, // Server-side
    SPELL_INVIS_SELF            = 25905,
    SPELL_VISCIDUS_GROWS        = 25897,
    SPELL_STUN_SELF             = 25900,

    // Toxic slime
    SPELL_TOXIN                 = 26575,
};

enum Events
{
    EVENT_POISONBOLT_VOLLEY     = 1,
    EVENT_POISON_SHOCK          = 2,
    EVENT_TOXIN                 = 3,
    EVENT_RESET_PHASE           = 4
};

enum Phases
{
    PHASE_FROST                 = 1,
    PHASE_MELEE                 = 2,
    PHASE_GLOB                  = 3
};

enum Emotes
{
    EMOTE_SLOW                  = 0,
    EMOTE_FREEZE                = 1,
    EMOTE_FROZEN                = 2,

    EMOTE_CRACK                 = 3,
    EMOTE_SHATTER               = 4,
    EMOTE_EXPLODE               = 5
};

enum HitCounter
{
    HITCOUNTER_SLOW             = 100,
    HITCOUNTER_SLOW_MORE        = 150,
    HITCOUNTER_FREEZE           = 200,

    HITCOUNTER_CRACK            = 50,
    HITCOUNTER_SHATTER          = 100,
    HITCOUNTER_EXPLODE          = 150,
};

enum MovePoints
{
    ROOM_CENTER                 = 1
};

enum Misc
{
    MAX_GLOB_SPAWN             = 20,
};

Position const roomCenter = { -7992.36f, 908.19f, -52.62f, 1.68f };

Position const resetPoint = { -7992.0f, 1041.0f, -23.84f };

std::array<uint32, MAX_GLOB_SPAWN> const spawnGlobSpells = { 25865, 25866, 25867, 25868, 25869, 25870, 25871, 25872, 25873, 25874, 25875, 25876, 25877, 25878, 25879, 25880, 25881, 25882, 25883, 25884 };

struct boss_viscidus : public BossAI
{
    boss_viscidus(Creature* creature) : BossAI(creature, DATA_VISCIDUS)
    {
        me->LowerPlayerDamageReq(me->GetMaxHealth());
        me->m_CombatDistance = 60.f;
    }

    bool CheckInRoom() override
    {
        if (me->GetExactDist2d(resetPoint) <= 10.f)
        {
            EnterEvadeMode(EVADE_REASON_BOUNDARY);
            return false;
        }

        return true;
    }

    void Reset() override
    {
        BossAI::Reset();
        SoftReset();
        me->RemoveAurasDueToSpell(SPELL_VISCIDUS_SHRINKS);
    }

    void SoftReset()
    {
        _hitcounter = 0;
        me->RemoveAurasDueToSpell(SPELL_STUN_SELF);
        me->SetReactState(REACT_AGGRESSIVE);
        _phase = PHASE_FROST;
        me->RemoveAurasDueToSpell(SPELL_INVIS_SELF);
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType effType, SpellSchoolMask spellSchoolMask) override
    {
        if (me->HealthBelowPct(5))
            damage = 0;

        if (!attacker)
        {
            return;
        }

        if (_phase != PHASE_MELEE)
        {
            if (_phase == PHASE_FROST && effType == DIRECT_DAMAGE && (spellSchoolMask & SPELL_SCHOOL_MASK_FROST) != 0)
            {
                ++_hitcounter;
            }

            return;
        }

        if (effType == DIRECT_DAMAGE)
            ++_hitcounter;

        if (attacker->HasUnitState(UNIT_STATE_MELEE_ATTACKING) && _hitcounter >= HITCOUNTER_EXPLODE)
        {
            if (me->GetHealthPct() <= 5.f)
            {
                Unit::Kill(attacker, me);
                return;
            }

            Talk(EMOTE_EXPLODE);
            me->SetReactState(REACT_PASSIVE);
            events.Reset();
            _phase = PHASE_GLOB;
            me->RemoveAura(SPELL_VISCIDUS_FREEZE);
            DoCastSelf(SPELL_STUN_SELF, true);
            me->AttackStop();
            me->CastStop();
            me->HandleEmoteCommand(EMOTE_ONESHOT_FLYDEATH); // not found in sniff, this is the best one I found
            scheduler.Schedule(2500ms, [this](TaskContext /*context*/)
                {
                    DoCastSelf(SPELL_EXPLODE_TRIGGER, true);
                })
                .Schedule(3000ms, [this](TaskContext /*context*/)
                {
                    DoCastSelf(SPELL_INVIS_SELF, true);
                    me->SetAuraStack(SPELL_VISCIDUS_SHRINKS, me, 20);
                    me->LowerPlayerDamageReq(me->GetMaxHealth());
                    me->SetHealth(me->GetMaxHealth() * 0.01f); // set 1% health
                    DoResetThreatList();
                    me->NearTeleportTo(roomCenter.GetPositionX(),
                        roomCenter.GetPositionY(),
                        roomCenter.GetPositionZ(),
                        roomCenter.GetOrientation());
                });
        }
        else if (_hitcounter == HITCOUNTER_SHATTER)
            Talk(EMOTE_SHATTER);
        else if (_hitcounter == HITCOUNTER_CRACK)
            Talk(EMOTE_CRACK);
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_REJOIN_VISCIDUS)
        {
            me->RemoveAuraFromStack(SPELL_VISCIDUS_SHRINKS);
        }

        SpellSchoolMask spellSchoolMask = spellInfo->GetSchoolMask();
        if (spellInfo->EquippedItemClass == ITEM_CLASS_WEAPON && spellInfo->EquippedItemSubClassMask & (1 << ITEM_SUBCLASS_WEAPON_WAND))
        {
            //npcbot: get bot's wand
            if (caster->GetTypeId() == TYPEID_UNIT)
            {
                if (Item const* pItem = caster->ToCreature()->GetBotEquips(2/*BOT_SLOT_RANGED*/))
                    spellSchoolMask = SpellSchoolMask(uint32(spellSchoolMask) | (1ul << pItem->GetTemplate()->Damage[0].DamageType));
            }
            else
            //end npcbot
            if (Item* pItem = caster->ToPlayer()->GetWeaponForAttack(RANGED_ATTACK))
            {
                spellSchoolMask = SpellSchoolMask(1 << pItem->GetTemplate()->Damage[0].DamageType);
            }
        }

        if ((spellSchoolMask & SPELL_SCHOOL_MASK_FROST) && _phase == PHASE_FROST)
        {
            ++_hitcounter;

            if (_hitcounter >= HITCOUNTER_FREEZE)
            {
                _hitcounter = 0;
                Talk(EMOTE_FROZEN);
                _phase = PHASE_MELEE;
                me->RemoveAura(SPELL_VISCIDUS_SLOWED_MORE);
                DoCastSelf(SPELL_VISCIDUS_FREEZE);
                events.ScheduleEvent(EVENT_RESET_PHASE, 15s);
            }
            else if (_hitcounter == HITCOUNTER_SLOW_MORE)
            {
                Talk(EMOTE_FREEZE);
                me->RemoveAura(SPELL_VISCIDUS_SLOWED);
                DoCastSelf(SPELL_VISCIDUS_SLOWED_MORE);
            }
            else if (_hitcounter == HITCOUNTER_SLOW)
            {
                Talk(EMOTE_SLOW);
                DoCastSelf(SPELL_VISCIDUS_SLOWED);
            }
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit* killer) override
    {
        if (summon->GetEntry() != NPC_GLOB_OF_VISCIDUS)
            return;

        if (killer && killer->GetEntry() == NPC_GLOB_OF_VISCIDUS)
        {
            if (_phase == PHASE_GLOB)
            {
                _phase = PHASE_FROST;
                me->RemoveAurasDueToSpell(SPELL_INVIS_SELF);
            }

            int32 heal = me->GetMaxHealth() * 0.05f;
            me->CastCustomSpell(me, SPELL_VISCIDUS_GROWS, &heal, nullptr, nullptr, true);
        }

        if (!summons.IsAnyCreatureWithEntryAlive(NPC_GLOB_OF_VISCIDUS)) // all globs were killed
        {
            SoftReset();
            InitSpells();
            me->LowerPlayerDamageReq(me->GetMaxHealth());
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        InitSpells();
    }

    void InitSpells()
    {
        events.ScheduleEvent(EVENT_TOXIN, 15s, 20s);
        events.ScheduleEvent(EVENT_POISONBOLT_VOLLEY, 10s, 15s);
        events.ScheduleEvent(EVENT_POISON_SHOCK, 7s, 12s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() || !CheckInRoom())
            return;

        events.Update(diff);
        scheduler.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_POISONBOLT_VOLLEY:
                    DoCastSelf(SPELL_POISONBOLT_VOLLEY);
                    events.ScheduleEvent(EVENT_POISONBOLT_VOLLEY, 10s, 15s);
                    break;
                case EVENT_POISON_SHOCK:
                    DoCastSelf(SPELL_POISON_SHOCK);
                    events.ScheduleEvent(EVENT_POISON_SHOCK, 7s, 12s);
                    break;
                case EVENT_TOXIN:
                    DoCastRandomTarget(SPELL_SUMMON_TOXIN_SLIME);
                    events.ScheduleEvent(EVENT_TOXIN, 15s, 20s);
                    break;
                case EVENT_RESET_PHASE:
                    _hitcounter = 0;
                    me->RemoveAura(SPELL_VISCIDUS_FREEZE);
                    _phase = PHASE_FROST;
                    break;
                default:
                    break;
            }
        }

        if (_phase != PHASE_GLOB && me->GetReactState() == REACT_AGGRESSIVE)
            DoMeleeAttackIfReady();
    }

private:
    uint8 _hitcounter;
    uint8 _phase;
};

struct boss_glob_of_viscidus : public ScriptedAI
{
    boss_glob_of_viscidus(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    void InitializeAI() override
    {
        me->SetInCombatWithZone();
        scheduler.CancelAll();
        scheduler.Schedule(2400ms, [this](TaskContext context)
            {
                me->GetMotionMaster()->MovePoint(ROOM_CENTER, roomCenter);
                float topSpeed = me->GetSpeedRate(MOVE_RUN) + 0.2142855f * 4;
                context.Schedule(1s, [this, topSpeed](TaskContext context)
                    {
                        float newSpeed = me->GetSpeedRate(MOVE_RUN) + 0.2142855f; // sniffed
                        me->SetSpeed(MOVE_RUN, newSpeed < topSpeed ? newSpeed : topSpeed);
                        context.Repeat();
                    });
            });
    }

    void MovementInform(uint32 /*type*/, uint32 id) override
    {
        if (id == ROOM_CENTER)
        {
            DoCastSelf(SPELL_REJOIN_VISCIDUS);
            me->KillSelf();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

struct npc_toxic_slime : public ScriptedAI
{
    npc_toxic_slime(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    void InitializeAI() override
    {
        me->SetCombatMovement(false);
        DoCastSelf(SPELL_TOXIN);

        InstanceScript* instance = me->GetInstanceScript();

        if (Creature* viscidus = instance->GetCreature(DATA_VISCIDUS))
            if (viscidus->AI())
                viscidus->AI()->JustSummoned(me);
    }
};

class spell_explode_trigger : public SpellScript
{
    PrepareSpellScript(spell_explode_trigger);

    void HandleOnHit()
    {
        Unit* caster = GetCaster();

        uint8 globsToSpawn = std::floor(caster->GetHealthPct() / 5.f);
        for (uint8 i = 0; i < globsToSpawn; i++)
            caster->CastSpell((Unit*)nullptr, spawnGlobSpells[i], true);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_explode_trigger::HandleOnHit);
    }
};

class spell_summon_toxin_slime : public SpellScript
{
    PrepareSpellScript(spell_summon_toxin_slime);

    void HandleOnHit()
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_SUMMON_TOXIN_SLIME_2, true);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_summon_toxin_slime::HandleOnHit);
    }
};

void AddSC_boss_viscidus()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_viscidus);
    RegisterTempleOfAhnQirajCreatureAI(boss_glob_of_viscidus);
    RegisterTempleOfAhnQirajCreatureAI(npc_toxic_slime);
    RegisterSpellScript(spell_explode_trigger);
    RegisterSpellScript(spell_summon_toxin_slime);
}
