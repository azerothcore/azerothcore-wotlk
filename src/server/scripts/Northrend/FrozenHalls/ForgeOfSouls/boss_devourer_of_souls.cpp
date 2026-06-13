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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "forge_of_souls.h"

enum Texts
{
    SAY_FACE_AGGRO                              = 0,
    SAY_FACE_ANGER_SLAY                         = 1,
    SAY_FACE_SORROW_SLAY                        = 2,
    SAY_FACE_DESIRE_SLAY                        = 3,
    SAY_FACE_DEATH                              = 4,
    EMOTE_MIRRORED_SOUL                         = 5,
    EMOTE_UNLEASH_SOUL                          = 6,
    SAY_FACE_UNLEASH_SOUL                       = 7,
    EMOTE_WAILING_SOUL                          = 8,
    SAY_FACE_WAILING_SOUL                       = 9,
};

enum Spells
{
    SPELL_PHANTOM_BLAST                 = 68982,
    SPELL_PHANTOM_BLAST_H               = 70322,
    SPELL_MIRRORED_SOUL                 = 69051,
    SPELL_WELL_OF_SOULS                 = 68820,
    //SPELL_WELL_OF_SOULS_SUMMON        = 68853,
    //SPELL_WELL_OF_SOULS_PERIODIC      = 68854,
    SPELL_UNLEASHED_SOULS               = 68939,

    SPELL_WAILING_SOULS                 = 68899, // target 1.0,1.0, change model, triggers 68871, cast time 3 secs
    SPELL_WAILING_SOULS_SCRIPT_EFFECT   = 68871, // target 1.0, script effect, instant
    SPELL_WAILING_SOULS_PERIODIC_DUMMY  = 68875, // target 1.0, aura 226, instant
    SPELL_WAILING_SOULS_PERIODIC_DUMMY_2 = 68876, // target 1.0, aura 226, instant
    SPELL_WAILING_SOULS_TARGETING       = 68912, // target 22.15, aura dummy, 50000yd, cast instant, duration 4 secs
    SPELL_WAILING_SOULS_DMG_N           = 68873, // 100yd, 104.0
    SPELL_WAILING_SOULS_DMG_H           = 70324, // 100yd, 104.0
};

enum Events
{
    EVENT_SPELL_PHANTOM_BLAST = 1,
    EVENT_SPELL_MIRRORED_SOUL,
    EVENT_SPELL_WELL_OF_SOULS,
    EVENT_SPELL_UNLEASHED_SOULS,
    EVENT_SPELL_WAILING_SOULS,
};

enum ModelIds
{
    MODEL_ANGER                       = 30148,
    MODEL_SORROW                      = 30149,
    MODEL_DESIRE                      = 30150,
};

enum Misc
{
    NPC_CRUCIBLE_OF_SOULS               = 37094,
    NPC_UNLEASHED_SOUL                  = 36595,
    QUEST_TEMPERING_THE_BLADE_A         = 24476,
    QUEST_TEMPERING_THE_BLADE_H         = 24560,
};

struct boss_devourer_of_souls : public BossAI
{
    boss_devourer_of_souls(Creature* creature) : BossAI(creature, DATA_DEVOURER) { }

    bool AchievementCompleted = true;

    void Reset() override
    {
        BossAI::Reset();
        AchievementCompleted = true;
        me->SetControlled(false, UNIT_STATE_ROOT);
        me->DisableRotate(false);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    uint32 GetData(uint32 id) const override
    {
        if (id == 1)
            return AchievementCompleted;

        return 0;
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_FACE_AGGRO);
        events.RescheduleEvent(EVENT_SPELL_PHANTOM_BLAST, 5s);
        events.RescheduleEvent(EVENT_SPELL_MIRRORED_SOUL, 9s);
        events.RescheduleEvent(EVENT_SPELL_WELL_OF_SOULS, 6s, 8s);
        events.RescheduleEvent(EVENT_SPELL_UNLEASHED_SOULS, 18s, 20s);
        events.RescheduleEvent(EVENT_SPELL_WAILING_SOULS, 65s);

        // Support for Quest Tempering the Blade
        me->GetMap()->DoForAllPlayers([this](Player* player)
        {
            if (me->FindNearestCreature(NPC_CRUCIBLE_OF_SOULS, 100.0f))
                return;

            uint32 questId = player->GetTeamId() == TEAM_ALLIANCE ? QUEST_TEMPERING_THE_BLADE_A : QUEST_TEMPERING_THE_BLADE_H;
            if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
                me->SummonCreature(NPC_CRUCIBLE_OF_SOULS, 5672.29f, 2520.69f, 713.44f, 0.96f);
        });
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_PHANTOM_BLAST_H)
            AchievementCompleted = false;
        else if (spell->Id == SPELL_WAILING_SOULS_TARGETING)
        {
            me->SetOrientation(me->GetAngle(target));
            me->SetControlled(true, UNIT_STATE_ROOT);
            me->DisableRotate(true);
            me->SetGuidValue(UNIT_FIELD_TARGET, ObjectGuid::Empty);
            me->SetReactState(REACT_PASSIVE);
            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MoveIdle();
            me->StopMovingOnCurrentPos();

            me->SetFacingToObject(target);
            me->SendMovementFlagUpdate();
            DoCastSelf(SPELL_WAILING_SOULS);
        }
    }

    bool CanAIAttack(Unit const* target) const override { return target->GetPositionZ() > 706.5f; }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (Spell* s = me->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            if (s->m_spellInfo->Id == SPELL_MIRRORED_SOUL)
            {
                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_PHANTOM_BLAST:
                        DoCastVictim(SPELL_PHANTOM_BLAST);
                        events.Repeat(5s);
                        break;
                    default:
                        events.Repeat(1s);
                        break;
                }

                if (!me->GetCurrentSpell(CURRENT_GENERIC_SPELL))
                {
                    me->ClearUnitState(UNIT_STATE_CASTING);
                    DoMeleeAttackIfReady();
                    me->AddUnitState(UNIT_STATE_CASTING);
                }

                return;
            }

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_SPELL_PHANTOM_BLAST:
                DoCastVictim(SPELL_PHANTOM_BLAST);
                events.Repeat(5s);
                break;
            case EVENT_SPELL_MIRRORED_SOUL:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 90.0f, true))
                {
                    DoCast(target, SPELL_MIRRORED_SOUL);
                    me->setAttackTimer(BASE_ATTACK, 2500);
                    Talk(EMOTE_MIRRORED_SOUL);
                }
                events.Repeat(20s, 30s);
                break;
            case EVENT_SPELL_WELL_OF_SOULS:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                    DoCast(target, SPELL_WELL_OF_SOULS);
                events.Repeat(25s, 30s);
                events.DelayEventsToMax(4s, 0);
                break;
            case EVENT_SPELL_UNLEASHED_SOULS:
                DoCastSelf(SPELL_UNLEASHED_SOULS);
                Talk(SAY_FACE_UNLEASH_SOUL);
                Talk(EMOTE_UNLEASH_SOUL);
                events.Repeat(30s, 40s);
                events.DelayEventsToMax(5s, 0);
                me->setAttackTimer(BASE_ATTACK, 5500);
                break;
            case EVENT_SPELL_WAILING_SOULS:
                Talk(SAY_FACE_WAILING_SOUL);
                Talk(EMOTE_WAILING_SOUL);
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    me->CastCustomSpell(SPELL_WAILING_SOULS_TARGETING, SPELLVALUE_MAX_TARGETS, 1, target);
                events.Repeat(80s);
                events.DelayEventsToMax(20s, 0);
                break;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_FACE_DEATH);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer())
            return;

        uint8 textId = 0;
        switch (me->GetDisplayId())
        {
            case MODEL_ANGER:
                textId = SAY_FACE_ANGER_SLAY;
                break;
            case MODEL_SORROW:
                textId = SAY_FACE_SORROW_SLAY;
                break;
            case MODEL_DESIRE:
                textId = SAY_FACE_DESIRE_SLAY;
                break;
            default:
                break;
        }

        if (textId)
            Talk(textId);
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() != NPC_CRUCIBLE_OF_SOULS)
            BossAI::JustSummoned(summon);

        if (summon->GetEntry() == NPC_UNLEASHED_SOUL)
            if (Player* player = summon->SelectNearestPlayer(100.0f))
            {
                summon->AddThreat(player, 100000.0f);
                summon->AI()->AttackStart(player);
            }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetControlled(false, UNIT_STATE_ROOT);
        me->DisableRotate(false);
        BossAI::EnterEvadeMode(why);
    }
};

class spell_wailing_souls_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_wailing_souls_periodic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WAILING_SOULS_DMG_N });
    }

    int8 dir = 0;

    bool Load() override
    {
        dir = urand(0, 1) ? 1 : -1;
        return true;
    }

    void HandlePeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* target = GetTarget())
        {
            if (aurEff->GetTickNumber() < 30)
            {
                float diff = (2 * M_PI) / (4 * 30);
                float newOrientation = target->GetOrientation() + diff * dir;
                if (newOrientation >= 2 * M_PI)
                    newOrientation -= 2 * M_PI;
                else if (newOrientation < 0)
                    newOrientation += 2 * M_PI;
                target->UpdateOrientation(newOrientation);
                target->SetFacingTo(newOrientation);
                target->CastSpell(target, SPELL_WAILING_SOULS_DMG_N, true);
            }
            else if (aurEff->GetTickNumber() == 33)
            {
                target->SetControlled(false, UNIT_STATE_ROOT);
                target->DisableRotate(false);
                if (target->IsCreature())
                    target->ToCreature()->SetReactState(REACT_AGGRESSIVE);
                if (target->GetVictim())
                {
                    target->SetGuidValue(UNIT_FIELD_TARGET, target->GetVictim()->GetGUID());
                    target->GetMotionMaster()->MoveChase(target->GetVictim());
                }
            }
            else if (aurEff->GetTickNumber() >= 34)
                Remove(AURA_REMOVE_BY_EXPIRE);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_wailing_souls_periodic_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

void AddSC_boss_devourer_of_souls()
{
    RegisterForgeOfSoulsCreatureAI(boss_devourer_of_souls);
    RegisterSpellScript(spell_wailing_souls_periodic_aura);
}
