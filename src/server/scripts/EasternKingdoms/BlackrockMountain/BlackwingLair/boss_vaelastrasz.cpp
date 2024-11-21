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
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "blackwing_lair.h"

constexpr float aNefariusSpawnLoc[4] = { -7466.16f, -1040.80f, 412.053f, 2.14675f };

enum Says
{
   SAY_LINE1                         = 0,
   SAY_LINE2                         = 1,
   SAY_LINE3                         = 2,
   SAY_HALFLIFE                      = 3,
   SAY_KILLTARGET                    = 4
};

enum Gossip
{
   GOSSIP_ID                         = 21334,
};

enum Spells
{
   SPELL_ESSENCE_OF_THE_RED           = 23513,
   SPELL_FLAME_BREATH                 = 23461,
   SPELL_FIRE_NOVA                    = 23462,
   SPELL_TAIL_SWEEP                   = 15847,
   SPELL_CLEAVE                       = 19983,   //Chain cleave is most likely named something different and contains a dummy effect
   SPELL_NEFARIUS_CORRUPTION          = 23642,
   SPELL_RED_LIGHTNING                = 19484,

   SPELL_BURNING_ADRENALINE           = 18173,
   SPELL_BURNING_ADRENALINE_EXPLOSION = 23478, // AOE
   SPELL_BURNING_ADRENALINE_INSTAKILL = 23644 // instakill
};

enum Events
{
    EVENT_SPEECH_1                  = 1,
    EVENT_SPEECH_2                  = 2,
    EVENT_SPEECH_3                  = 3,
    EVENT_SPEECH_4                  = 4,
    EVENT_SPEECH_5                  = 5,
    EVENT_SPEECH_6                  = 6,
    EVENT_SPEECH_7                  = 7,
    EVENT_FLAME_BREATH              = 8,
    EVENT_FIRE_NOVA                 = 9,
    EVENT_TAIL_SWEEP                = 10,
    EVENT_CLEAVE                    = 11,
    EVENT_BURNING_ADRENALINE        = 12,
};

class boss_vaelastrasz : public CreatureScript
{
public:
    boss_vaelastrasz() : CreatureScript("boss_vaelastrasz") { }

    struct boss_vaelAI : public BossAI
    {
        boss_vaelAI(Creature* creature) : BossAI(creature, DATA_VAELASTRAZ_THE_CORRUPT)
        {
            Initialize();
        }

        void Initialize()
        {
            PlayerGUID.Clear();
            HasYelled = false;
            _introDone = false;
            _burningAdrenalineCast = 0;
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            me->SetFaction(FACTION_FRIENDLY);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        void Reset() override
        {
            _Reset();
            me->SetHealth(me->CountPctFromMaxHealth(30));

            if (!_introDone)
            {
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                me->SetReactState(REACT_PASSIVE);
                Initialize();
                _eventsIntro.Reset();
            }
            else
            {
                HasYelled = false;
                _burningAdrenalineCast = 0;
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);

            DoCastAOE(SPELL_ESSENCE_OF_THE_RED);
            // now drop damage requirement to be able to take loot
            me->ResetPlayerDamageReq();

            events.ScheduleEvent(EVENT_CLEAVE, 10s);
            events.ScheduleEvent(EVENT_FLAME_BREATH, 15s);
            events.ScheduleEvent(EVENT_FIRE_NOVA, 5s);
            events.ScheduleEvent(EVENT_TAIL_SWEEP, 11s);
            events.ScheduleEvent(EVENT_BURNING_ADRENALINE, 15s);
        }

        void BeginSpeech(Unit* target)
        {
            PlayerGUID = target->GetGUID();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            _eventsIntro.ScheduleEvent(EVENT_SPEECH_1, 1s);
        }

        void KilledUnit(Unit* victim) override
        {
            if (rand32() % 5)
                return;

            Talk(SAY_KILLTARGET, victim);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            _eventsIntro.Update(diff);

            // Speech
            if (!_introDone)
            {
                while (uint32 eventId = _eventsIntro.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SPEECH_1:
                            me->SetStandState(UNIT_STAND_STATE_STAND);
                            me->SummonCreature(NPC_VICTOR_NEFARIUS, aNefariusSpawnLoc[0], aNefariusSpawnLoc[1], aNefariusSpawnLoc[2], aNefariusSpawnLoc[3], TEMPSUMMON_TIMED_DESPAWN, 26000);
                            _eventsIntro.ScheduleEvent(EVENT_SPEECH_2, 1s);
                            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            break;
                        case EVENT_SPEECH_2:
                            if (Creature* nefarius = me->GetMap()->GetCreature(m_nefariusGuid))
                            {
                                nefarius->CastSpell(me, SPELL_NEFARIUS_CORRUPTION, TRIGGERED_CAST_DIRECTLY);
                                nefarius->Yell(SAY_NEFARIAN_VAEL_INTRO);
                                nefarius->SetStandState(UNIT_STAND_STATE_STAND);
                            }
                            _eventsIntro.ScheduleEvent(EVENT_SPEECH_3, 18s);
                            break;
                        case EVENT_SPEECH_3:
                            if (Creature* nefarius = me->GetMap()->GetCreature(m_nefariusGuid))
                                nefarius->CastSpell(me, SPELL_RED_LIGHTNING, TRIGGERED_NONE);
                            _eventsIntro.ScheduleEvent(EVENT_SPEECH_4, 2s);
                            break;
                        case EVENT_SPEECH_4:
                            Talk(SAY_LINE1);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                            _eventsIntro.ScheduleEvent(EVENT_SPEECH_5, 12s);
                            break;
                        case EVENT_SPEECH_5:
                            Talk(SAY_LINE2);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                            _eventsIntro.ScheduleEvent(EVENT_SPEECH_6, 12s);
                            break;
                        case EVENT_SPEECH_6:
                            Talk(SAY_LINE3);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                            _eventsIntro.ScheduleEvent(EVENT_SPEECH_7, 17s);
                            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            break;
                        case EVENT_SPEECH_7:
                            me->SetFaction(FACTION_DRAGONFLIGHT_BLACK);
                            if (PlayerGUID && ObjectAccessor::GetUnit(*me, PlayerGUID))
                                AttackStart(ObjectAccessor::GetUnit(*me, PlayerGUID));
                            me->SetReactState(REACT_AGGRESSIVE);
                            _introDone = true;
                            break;
                    }
                }
            }

            if (!UpdateVictim() || me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CLEAVE:
                        events.ScheduleEvent(EVENT_CLEAVE, 15s);
                        DoCastVictim(SPELL_CLEAVE);
                        break;
                    case EVENT_FLAME_BREATH:
                        DoCastVictim(SPELL_FLAME_BREATH);
                        events.ScheduleEvent(EVENT_FLAME_BREATH, 8s, 14s);
                        break;
                    case EVENT_FIRE_NOVA:
                        DoCastVictim(SPELL_FIRE_NOVA);
                        events.ScheduleEvent(EVENT_FIRE_NOVA, 3s, 5s);
                        break;
                    case EVENT_TAIL_SWEEP:
                        DoCastAOE(SPELL_TAIL_SWEEP);
                        events.ScheduleEvent(EVENT_TAIL_SWEEP, 15s);
                        break;
                    case EVENT_BURNING_ADRENALINE:
                    {
                        if (_burningAdrenalineCast < 2) // It's better to use TaskScheduler for this, but zzz
                        {
                            //selects a random target that isn't the current victim and is a mana user (selects mana users) but not pets
                            //it also ignores targets who have the aura. We don't want to place the debuff on the same target twice.
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [&](Unit* u) { return u && !u->IsPet() && u->getPowerType() == POWER_MANA && !u->HasAura(SPELL_BURNING_ADRENALINE) && u != me->GetVictim(); }))
                            {
                                me->CastSpell(target, SPELL_BURNING_ADRENALINE, true);
                            }

                            _burningAdrenalineCast++;
                        }
                        else
                        {
                            me->CastSpell(me->GetVictim(), SPELL_BURNING_ADRENALINE, true);
                            _burningAdrenalineCast = 0;
                        }
                        events.ScheduleEvent(EVENT_BURNING_ADRENALINE, 15s);
                        break;
                    }
                }
            }

            // Yell if hp lower than 15%
            if (HealthBelowPct(15) && !HasYelled)
            {
                Talk(SAY_HALFLIFE);
                HasYelled = true;
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summoned) override
        {
            if (summoned->GetEntry() == NPC_VICTOR_NEFARIUS)
            {
                // Set not selectable, so players won't interact with it
                summoned->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                m_nefariusGuid = summoned->GetGUID();
            }
        }

        void sGossipSelect(Player* player, uint32 sender, uint32 action) override
        {
            if (sender == GOSSIP_ID && action == 0)
            {
                CloseGossipMenuFor(player);
                BeginSpeech(player);
            }
        }

        private:
            ObjectGuid PlayerGUID;
            ObjectGuid m_nefariusGuid;
            bool HasYelled;
            bool _introDone;
            EventMap _eventsIntro;
            uint8 _burningAdrenalineCast;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackwingLairAI<boss_vaelAI>(creature);
    }
};

// 18173 - Burning Adrenaline
class spell_vael_burning_adrenaline : public AuraScript
{
    PrepareAuraScript(spell_vael_burning_adrenaline);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BURNING_ADRENALINE_EXPLOSION, SPELL_BURNING_ADRENALINE_INSTAKILL });
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (!GetTarget())
        {
            return;
        }

        // Do the explosion, then kill the target.
        GetTarget()->CastSpell(GetTarget(), SPELL_BURNING_ADRENALINE_EXPLOSION, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_BURNING_ADRENALINE_INSTAKILL, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_vael_burning_adrenaline::HandleRemove, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_vaelastrasz()
{
    new boss_vaelastrasz();
    RegisterSpellScript(spell_vael_burning_adrenaline);
}
