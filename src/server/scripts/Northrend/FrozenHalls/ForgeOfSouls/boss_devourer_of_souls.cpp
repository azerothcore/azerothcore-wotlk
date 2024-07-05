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
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "forge_of_souls.h"

enum eTexts
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

enum eSpells
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

enum eEvents
{
    EVENT_SPELL_PHANTOM_BLAST = 1,
    EVENT_SPELL_MIRRORED_SOUL,
    EVENT_SPELL_WELL_OF_SOULS,
    EVENT_SPELL_UNLEASHED_SOULS,
    EVENT_SPELL_WAILING_SOULS,
};

enum eDisplayIds
{
    DISPLAY_ANGER                       = 30148,
    DISPLAY_SORROW                      = 30149,
    DISPLAY_DESIRE                      = 30150,
};

enum eMisc
{
    NPC_CRUCIBLE_OF_SOULS               = 37094,
    QUEST_TEMPERING_THE_BLADE_A         = 24476,
    QUEST_TEMPERING_THE_BLADE_H         = 24560,
};

class boss_devourer_of_souls : public CreatureScript
{
public:
    boss_devourer_of_souls() : CreatureScript("boss_devourer_of_souls") { }

    struct boss_devourer_of_soulsAI : public ScriptedAI
    {
        boss_devourer_of_soulsAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        bool bAchiev;

        void Reset() override
        {
            bAchiev = true;
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            me->SetReactState(REACT_AGGRESSIVE);
            events.Reset();
            summons.DespawnAll();
            if (pInstance)
                pInstance->SetData(DATA_DEVOURER, NOT_STARTED);
        }

        uint32 GetData(uint32 id) const override
        {
            if (id == 1)
                return bAchiev;

            return 0;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_FACE_AGGRO);
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_PHANTOM_BLAST, 5s);
            events.RescheduleEvent(EVENT_SPELL_MIRRORED_SOUL, 9s);
            events.RescheduleEvent(EVENT_SPELL_WELL_OF_SOULS, 6s, 8s);
            events.RescheduleEvent(EVENT_SPELL_UNLEASHED_SOULS, 18s, 20s);
            events.RescheduleEvent(EVENT_SPELL_WAILING_SOULS, 65s);

            if (pInstance)
                pInstance->SetData(DATA_DEVOURER, IN_PROGRESS);

            // Suport for Quest Tempering the Blade
            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
            {
                Player* player = itr->GetSource();
                if ((player->GetTeamId() == TEAM_ALLIANCE && player->GetQuestStatus(QUEST_TEMPERING_THE_BLADE_A) == QUEST_STATUS_INCOMPLETE) ||
                        (player->GetTeamId() == TEAM_HORDE && player->GetQuestStatus(QUEST_TEMPERING_THE_BLADE_H) == QUEST_STATUS_INCOMPLETE))
                {
                    if (!me->FindNearestCreature(NPC_CRUCIBLE_OF_SOULS, 100.0f))
                        me->SummonCreature(NPC_CRUCIBLE_OF_SOULS, 5672.29f, 2520.69f, 713.44f, 0.96f);
                }
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_PHANTOM_BLAST_H)
                bAchiev = false;
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
                me->CastSpell(me, SPELL_WAILING_SOULS, false);
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
                        case 0:
                            break;
                        case EVENT_SPELL_PHANTOM_BLAST:
                            me->CastSpell(me->GetVictim(), SPELL_PHANTOM_BLAST, false);
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

            switch(events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_PHANTOM_BLAST:
                    me->CastSpell(me->GetVictim(), SPELL_PHANTOM_BLAST, false);
                    events.Repeat(5s);
                    break;
                case EVENT_SPELL_MIRRORED_SOUL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 90.0f, true))
                    {
                        me->CastSpell(target, SPELL_MIRRORED_SOUL, false);
                        me->setAttackTimer(BASE_ATTACK, 2500);
                        Talk(EMOTE_MIRRORED_SOUL);
                    }
                    events.Repeat(20s, 30s);
                    break;
                case EVENT_SPELL_WELL_OF_SOULS:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        me->CastSpell(target, SPELL_WELL_OF_SOULS, false);
                    events.Repeat(25s, 30s);
                    events.DelayEventsToMax(4000, 0);
                    break;
                case EVENT_SPELL_UNLEASHED_SOULS:
                    me->CastSpell(me, SPELL_UNLEASHED_SOULS, false);
                    Talk(SAY_FACE_UNLEASH_SOUL);
                    Talk(EMOTE_UNLEASH_SOUL);
                    events.Repeat(30s, 40s);
                    events.DelayEventsToMax(5000, 0);
                    me->setAttackTimer(BASE_ATTACK, 5500);
                    break;
                case EVENT_SPELL_WAILING_SOULS:
                    Talk(SAY_FACE_WAILING_SOUL);
                    Talk(EMOTE_WAILING_SOUL);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                        me->CastCustomSpell(SPELL_WAILING_SOULS_TARGETING, SPELLVALUE_MAX_TARGETS, 1, target, false);
                    events.Repeat(80s);
                    events.DelayEventsToMax(20000, 0);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_FACE_DEATH);
            summons.DespawnAll();
            if (pInstance)
                pInstance->SetData(DATA_DEVOURER, DONE);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            int32 textId = 0;
            switch (me->GetDisplayId())
            {
                case DISPLAY_ANGER:
                    textId =  SAY_FACE_ANGER_SLAY;
                    break;
                case DISPLAY_SORROW:
                    textId = SAY_FACE_SORROW_SLAY;
                    break;
                case DISPLAY_DESIRE:
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
                summons.Summon(summon);

            if (summon->GetEntry() == 36595)
                if (Player* plr = summon->SelectNearestPlayer(100.0f))
                {
                    summon->AddThreat(plr, 100000.0f);
                    summon->AI()->AttackStart(plr);
                }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode(why);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetForgeOfSoulsAI<boss_devourer_of_soulsAI>(creature);
    }
};

class spell_wailing_souls_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_wailing_souls_periodic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WAILING_SOULS_DMG_N });
    }

    int8 dir;

    bool Load() override
    {
        dir = urand(0, 1) ? 1 : -1;
        return true;
    }

    void HandlePeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* t = GetTarget())
        {
            if (aurEff->GetTickNumber() < 30)
            {
                // spinning, casting, etc.
                float diff = (2 * M_PI) / (4 * 30);
                float new_o = t->GetOrientation() + diff * dir;
                if (new_o >= 2 * M_PI)
                    new_o -= 2 * M_PI;
                else if (new_o < 0)
                    new_o += 2 * M_PI;
                t->UpdateOrientation(new_o);
                t->SetFacingTo(new_o);
                t->CastSpell(t, SPELL_WAILING_SOULS_DMG_N, true);
            }
            else if (aurEff->GetTickNumber() == 33)
            {
                t->SetControlled(false, UNIT_STATE_ROOT);
                t->DisableRotate(false);
                if (t->GetTypeId() == TYPEID_UNIT)
                    t->ToCreature()->SetReactState(REACT_AGGRESSIVE);
                if (t->GetVictim())
                {
                    t->SetGuidValue(UNIT_FIELD_TARGET, t->GetVictim()->GetGUID());
                    t->GetMotionMaster()->MoveChase(t->GetVictim());
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
    new boss_devourer_of_souls();
    RegisterSpellScript(spell_wailing_souls_periodic_aura);
}

