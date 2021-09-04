/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellScript.h"

enum Spells
{
    // BASIC FIGHT
    SPELL_MIND_FLAY                         = 57941,
    SPELL_SHADOW_BOLT_VOLLEY                = 57942,
    SPELL_SHIVER                            = 57949,

    // INSANITY
    SPELL_INSANITY                          = 57496, //Dummy
    INSANITY_VISUAL                         = 57561,
    SPELL_INSANITY_TARGET                   = 57508,
    SPELL_CLONE_PLAYER                      = 57507, //casted on player during insanity
    SPELL_INSANITY_PHASING_1                = 57508,
    SPELL_INSANITY_PHASING_2                = 57509,
    SPELL_INSANITY_PHASING_3                = 57510,
    SPELL_INSANITY_PHASING_4                = 57511,
    SPELL_INSANITY_PHASING_5                = 57512,

    SPELL_WHISPER_AGGRO                     = 60291,
    SPELL_WHISPER_INSANITY                  = 60292,
    SPELL_WHISPER_SLAY_1                    = 60293,
    SPELL_WHISPER_SLAY_2                    = 60294,
    SPELL_WHISPER_SLAY_3                    = 60295,
    SPELL_WHISPER_DEATH_1                   = 60296,
    SPELL_WHISPER_DEATH_2                   = 60297
};

enum Texts
{
    SAY_AGGRO                               = 0,
    SAY_INSANITY                            = 1,
    SAY_SLAY_1                              = 2,
    SAY_SLAY_2                              = 3,
    SAY_SLAY_3                              = 4,
    SAY_DEATH_1                             = 5,
    SAY_DEATH_2                             = 6,

    WHISPER_AGGRO                           = 7,
    WHISPER_INSANITY                        = 8,
    WHISPER_SLAY_1                          = 9,
    WHISPER_SLAY_2                          = 10,
    WHISPER_SLAY_3                          = 11,
    WHISPER_DEATH_1                         = 12,
    WHISPER_DEATH_2                         = 13
};

enum Misc
{
    NPC_TWISTED_VISAGE                      = 30625,
    ACHIEV_QUICK_DEMISE_START_EVENT         = 20382,

    MAX_INSANITY_TARGETS                    = 5,
    DATA_SET_INSANITY_PHASE                 = 1,
};

enum Events
{
    EVENT_HERALD_MIND_FLAY                  = 1,
    EVENT_HERALD_SHADOW,
    EVENT_HERALD_SHIVER,
};

const std::array<uint32, MAX_INSANITY_TARGETS> InsanitySpells = { SPELL_INSANITY_PHASING_1, SPELL_INSANITY_PHASING_2, SPELL_INSANITY_PHASING_3, SPELL_INSANITY_PHASING_4, SPELL_INSANITY_PHASING_5 };

class boss_volazj : public CreatureScript
{
public:
    boss_volazj() : CreatureScript("boss_volazj") { }

    struct boss_volazjAI : public BossAI
    {
        boss_volazjAI(Creature* pCreature) : BossAI(pCreature, DATA_HERALD_VOLAZJ),
            insanityTimes(0),
            insanityPhase(false)
        {
        }

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            // Visible for all players in insanity
            me->SetPhaseMask((1 | 16 | 32 | 64 | 128 | 256), true);
        }

        void Reset() override
        {
            _Reset();
            insanityTimes = 0;
            insanityPhase = false;

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_STUNNED);
            ResetPlayersPhaseMask();
            instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_QUICK_DEMISE_START_EVENT);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_HERALD_MIND_FLAY, 8000);
            events.ScheduleEvent(EVENT_HERALD_SHADOW, 5000);
            events.ScheduleEvent(EVENT_HERALD_SHIVER, 15000);
            Talk(SAY_AGGRO);
            DoCastSelf(SPELL_WHISPER_AGGRO);
            instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_QUICK_DEMISE_START_EVENT);
            me->SetInCombatWithZone();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_STUNNED);
            ResetPlayersPhaseMask();

            switch (urand(0, 1))
            {
                case 0:
                {
                    Talk(SAY_DEATH_1);
                    DoCastSelf(SPELL_WHISPER_DEATH_1, true);
                    break;
                }
                case 1:
                {
                    Talk(SAY_DEATH_2);
                    DoCastSelf(SPELL_WHISPER_DEATH_2, true);
                    break;
                }
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
            {
                switch (urand(0, 2))
                {
                    case 0:
                    {
                        Talk(SAY_SLAY_1);
                        DoCastSelf(SPELL_WHISPER_SLAY_1);
                        break;
                    }
                    case 1:
                    {
                        Talk(SAY_SLAY_2);
                        DoCastSelf(SPELL_WHISPER_SLAY_2);
                        break;
                    }
                    case 2:
                    {
                        Talk(SAY_SLAY_3);
                        DoCastSelf(SPELL_WHISPER_SLAY_3);
                        break;
                    }
                }
            }
        }

        void SetData(uint32 type, uint32 value) override
        {
            if (type == DATA_SET_INSANITY_PHASE)
            {
                insanityPhase = (value != 0);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            // Do not perform insanity recast if boss is casting Insanity already
            if (me->FindCurrentSpellBySpellId(SPELL_INSANITY))
            {
                return;
            }

            // First insanity
            if (insanityTimes == 0 && me->HealthBelowPctDamaged(66, damage))
            {
                DoCastSelf(SPELL_INSANITY, false);
                ++insanityTimes;
            }
            // Second insanity
            else if (insanityTimes == 1 && me->HealthBelowPctDamaged(33, damage))
            {
                me->InterruptNonMeleeSpells(false);
                DoCastSelf(SPELL_INSANITY, false);
                ++insanityTimes;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
            {
                return;
            }

            if (insanityPhase)
            {
                if (!CheckPhaseMinions())
                {
                    return;
                }

                insanityPhase = false;
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetControlled(false, UNIT_STATE_STUNNED);
                me->RemoveAurasDueToSpell(INSANITY_VISUAL);
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_HERALD_MIND_FLAY:
                    {
                        DoCastVictim(SPELL_MIND_FLAY, false);
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_HERALD_SHADOW:
                    {
                        DoCastVictim(SPELL_SHADOW_BOLT_VOLLEY, false);
                        events.RepeatEvent(5000);
                        break;
                    }
                    case EVENT_HERALD_SHIVER:
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        {
                            DoCast(pTarget, SPELL_SHIVER, false);
                        }

                        events.RepeatEvent(15000);
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
        uint8 insanityTimes;
        bool insanityPhase;     // Indicates if boss enter to insanity phase

        uint32 GetPlrInsanityAuraId(uint32 phaseMask) const
        {
            switch (phaseMask)
            {
                case 16:
                    return SPELL_INSANITY_PHASING_1;
                case 32:
                    return SPELL_INSANITY_PHASING_2;
                case 64:
                    return SPELL_INSANITY_PHASING_3;
                case 128:
                    return SPELL_INSANITY_PHASING_4;
                case 256:
                    return SPELL_INSANITY_PHASING_5;
            }

            return 0;
        }

        void ResetPlayersPhaseMask()
        {
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& i : players)
            {
                if (Player* pPlayer = i.GetSource())
                {
                    if (uint32 const insanityAura = GetPlrInsanityAuraId(pPlayer->GetPhaseMask()))
                    {
                        pPlayer->RemoveAurasDueToSpell(insanityAura);
                    }
                }
            }
        }

        bool CheckPhaseMinions()
        {
            summons.RemoveNotExisting();
            if (summons.empty())
            {
                ResetPlayersPhaseMask();
                return true;
            }

            uint32 phase = 1;
            for (ObjectGuid const& summonGUID : summons)
            {
                if (Creature* summon = ObjectAccessor::GetCreature(*me, summonGUID))
                {
                    phase |= summon->GetPhaseMask();
                }
            }

            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& i : players)
            {
                Player* pPlayer = i.GetSource();
                if (pPlayer && !(pPlayer->GetPhaseMask() & phase))
                {
                    pPlayer->RemoveAurasDueToSpell(GetPlrInsanityAuraId(pPlayer->GetPhaseMask()));
                }
            }

            return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetAhnkahetAI<boss_volazjAI>(creature);
    }
};

// 57496 Insanity
class spell_herald_volzaj_insanity : public SpellScriptLoader
{
public:
    spell_herald_volzaj_insanity() : SpellScriptLoader("spell_herald_volzaj_insanity") { }

    class spell_herald_volzaj_insanity_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_herald_volzaj_insanity_SpellScript);

        bool Load() override { return GetCaster()->GetTypeId() == TYPEID_UNIT; }

        void HandleDummyEffect(std::list<WorldObject*>& targets)
        {
            Unit* caster = GetCaster();
            if (!caster)
            {
                targets.clear();
                return;
            }

            if (!targets.empty())
            {
                targets.remove_if([this](WorldObject* targetObj) -> bool
                {
                    return !targetObj || targetObj->GetTypeId() != TYPEID_PLAYER || !targetObj->ToPlayer()->IsInCombatWith(GetCaster()) ||
                            targetObj->GetDistance(GetCaster()) >= (MAX_VISIBILITY_DISTANCE * 2);
                });
            }

            if (targets.empty())
            {
                return;
            }

            // Start channel visual and set self as unnattackable
            caster->ToCreature()->AI()->Talk(SAY_INSANITY);
            caster->CastSpell(caster, SPELL_WHISPER_INSANITY, true);
            caster->RemoveAllAuras();
            caster->CastSpell(caster, INSANITY_VISUAL, true);
            caster->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            caster->SetControlled(true, UNIT_STATE_STUNNED);

            // Handle phase effect
            uint32 insanityCounter = 0;
            std::list<WorldObject*>::const_iterator itr = targets.begin();
            while (itr != targets.end() && insanityCounter < MAX_INSANITY_TARGETS)
            {
                WorldObject* targetObj = *itr;
                if (!targetObj)
                {
                    continue;
                }

                Player* plrTarget = targetObj->ToPlayer();
                // This should never happen, spell has attribute SPELL_ATTR3_ONLY_TARGET_PLAYERS
                if (!plrTarget)
                {
                    continue;
                }

                // phase mask
                plrTarget->CastSpell(plrTarget, InsanitySpells.at(insanityCounter), true);

                // Summon clone
                for (std::list<WorldObject*>::const_iterator itr2 = targets.begin(); itr2 != targets.end(); ++itr2)
                {
                    // Should not make clone of current player target
                    Player const* plrClone = *itr2 ? (*itr2)->ToPlayer() : nullptr;
                    if (!plrClone || plrClone == plrTarget)
                    {
                        continue;
                    }

                    if (Unit* summon = caster->SummonCreature(NPC_TWISTED_VISAGE, plrClone->GetPosition(), TEMPSUMMON_CORPSE_DESPAWN, 0))
                    {
                        summon->AddThreat(plrTarget, 0.0f);
                        summon->SetInCombatWith(plrTarget);
                        plrTarget->SetInCombatWith(summon);

                        plrTarget->CastSpell(summon, SPELL_CLONE_PLAYER, true);
                        summon->SetPhaseMask(1 | (1 << (4 + insanityCounter)), true);
                        summon->SetUInt32Value(UNIT_FIELD_MINDAMAGE, plrClone->GetUInt32Value(UNIT_FIELD_MINDAMAGE));
                        summon->SetUInt32Value(UNIT_FIELD_MAXDAMAGE, plrClone->GetUInt32Value(UNIT_FIELD_MAXDAMAGE));
                    }
                }

                ++insanityCounter;
                ++itr;
            }
        }

        void HandleAfterCast()
        {
            GetCaster()->ToCreature()->AI()->SetData(DATA_SET_INSANITY_PHASE, 1);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_herald_volzaj_insanity_SpellScript::HandleDummyEffect, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            AfterCast += SpellCastFn(spell_herald_volzaj_insanity_SpellScript::HandleAfterCast);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_herald_volzaj_insanity_SpellScript();
    }
};

// 60291 Volazj Whisper: Aggro
// 60292 Volazj Whisper: Insanity
// 60293 Volazj Whisper: Slay 01
// 60294 Volazj Whisper: Slay 02
// 60295 Volazj Whisper: Slay 03
// 60296 Volazj Whisper: Death 01
// 60297 Volazj Whisper: Death 02
class spell_volazj_whisper : public SpellScriptLoader
{
public:
    spell_volazj_whisper() : SpellScriptLoader("spell_volazj_whisper") { }

    class spell_volazj_whisper_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_volazj_whisper_SpellScript);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo(
            {
                SPELL_WHISPER_AGGRO,
                SPELL_WHISPER_INSANITY,
                SPELL_WHISPER_SLAY_1,
                SPELL_WHISPER_SLAY_2,
                SPELL_WHISPER_SLAY_3,
                SPELL_WHISPER_DEATH_1,
                SPELL_WHISPER_DEATH_2
            });
        }

        bool Load() override { return GetCaster()->GetTypeId() == TYPEID_UNIT; }

        void HandleScriptEffect(SpellEffIndex /* effIndex */)
        {
            Unit* target = GetHitPlayer();
            Creature* caster = GetCaster()->ToCreature();
            if (!target || !caster)
            {
                return;
            }

            uint32 text = 0;
            switch (GetSpellInfo()->Id)
            {
                case SPELL_WHISPER_AGGRO:    text = WHISPER_AGGRO;    break;
                case SPELL_WHISPER_INSANITY: text = WHISPER_INSANITY; break;
                case SPELL_WHISPER_SLAY_1:   text = WHISPER_SLAY_1;   break;
                case SPELL_WHISPER_SLAY_2:   text = WHISPER_SLAY_2;   break;
                case SPELL_WHISPER_SLAY_3:   text = WHISPER_SLAY_3;   break;
                case SPELL_WHISPER_DEATH_1:  text = WHISPER_DEATH_1;  break;
                case SPELL_WHISPER_DEATH_2:  text = WHISPER_DEATH_2;  break;
                default: return;
            }
            caster->AI()->Talk(text, target);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_volazj_whisper_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_volazj_whisper_SpellScript();
    }
};

void AddSC_boss_volazj()
{
    new boss_volazj();
    new spell_herald_volzaj_insanity();
    new spell_volazj_whisper();
}
