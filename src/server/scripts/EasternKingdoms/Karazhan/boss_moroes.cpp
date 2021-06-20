/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "karazhan.h"
#include "SpellScript.h"

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_SPECIAL                 = 1,
    SAY_KILL                    = 2,
    SAY_DEATH                   = 3,
    SAY_OUT_OF_COMBAT           = 4,

    SAY_GUEST                   = 0
};

enum Spells
{
    SPELL_VANISH                = 29448,
    SPELL_GARROTE_DUMMY         = 29433,
    SPELL_GARROTE               = 37066,
    SPELL_BLIND                 = 34694,
    SPELL_GOUGE                 = 29425,
    SPELL_FRENZY                = 37023,
    SPELL_DUAL_WIELD            = 29651,
    SPELL_BERSERK               = 26662,
    SPELL_VANISH_TELEPORT       = 29431,
};

enum Misc
{
    EVENT_GUEST_TALK            = 1,
    EVENT_GUEST_TALK2           = 2,
    EVENT_SPELL_VANISH          = 3,
    EVENT_SPELL_GARROTE         = 4,
    EVENT_SPELL_BLIND           = 5,
    EVENT_SPELL_GOUGE           = 6,
    EVENT_CHECK_HEALTH          = 7,
    EVENT_SPELL_ENRAGE          = 8,
    EVENT_KILL_TALK             = 9,

    ACTIVE_GUEST_COUNT          = 4,
    MAX_GUEST_COUNT             = 6
};

const Position GuestsPosition[4] =
{
    {-10987.38f, -1883.38f, 81.73f, 1.50f},
    {-10989.60f, -1881.27f, 81.73f, 0.73f},
    {-10978.81f, -1884.08f, 81.73f, 1.50f},
    {-10976.38f, -1882.59f, 81.73f, 2.31f},
};

const uint32 GuestEntries[6]=
{
    17007,
    19872,
    19873,
    19874,
    19875,
    19876,
};

class boss_moroes : public CreatureScript
{
    public:
        boss_moroes() : CreatureScript("boss_moroes") { }

        struct boss_moroesAI : public BossAI
        {
            boss_moroesAI(Creature* creature) : BossAI(creature, DATA_MOROES)
            {
                _activeGuests = 0;
                instance = creature->GetInstanceScript();
            }

            InstanceScript* instance;

            void InitializeAI()
            {
                BossAI::InitializeAI();
                InitializeGuests();
            }

            void JustReachedHome()
            {
                BossAI::JustReachedHome();
                InitializeGuests();
            }

            void InitializeGuests()
            {
                if (!me->IsAlive())
                    return;

                if (_activeGuests == 0)
                {
                    _activeGuests |= 0x3F;
                    uint8 rand1 = RAND(0x01, 0x02, 0x04);
                    uint8 rand2 = RAND(0x08, 0x10, 0x20);
                    _activeGuests &= ~(rand1|rand2);
                }

                for (uint8 i = 0; i < MAX_GUEST_COUNT; ++i)
                    if ((1 << i) & _activeGuests)
                        me->SummonCreature(GuestEntries[i], GuestsPosition[summons.size()], TEMPSUMMON_MANUAL_DESPAWN);

                _events2.Reset();
                _events2.ScheduleEvent(EVENT_GUEST_TALK, 10000);
            }

            void Reset()
            {
                BossAI::Reset();
                me->CastSpell(me, SPELL_DUAL_WIELD, true);
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_SPELL_VANISH, 30000);
                events.ScheduleEvent(EVENT_SPELL_BLIND, 20000);
                events.ScheduleEvent(EVENT_SPELL_GOUGE, 13000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH, 5000);
                events.ScheduleEvent(EVENT_SPELL_ENRAGE, 600000);

                _events2.Reset();
                me->CallForHelp(20.0f);
                DoZoneInCombat();
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 5000);
                }
            }

            void JustDied(Unit* killer)
            {
                summons.clear();
                BossAI::JustDied(killer);
                Talk(SAY_DEATH);
                instance->SetBossState(DATA_MOROES, DONE);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GARROTE);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
            }

            Creature* GetRandomGuest()
            {
                std::list<Creature*> guestList;
                for (SummonList::const_iterator i = summons.begin(); i != summons.end(); ++i)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                        guestList.push_back(summon);

                return acore::Containers::SelectRandomContainerElement(guestList);
            }

            void UpdateAI(uint32 diff)
            {
                _events2.Update(diff);
                switch (_events2.ExecuteEvent())
                {
                    case EVENT_GUEST_TALK:
                        if (Creature* guest = GetRandomGuest())
                            guest->AI()->Talk(SAY_GUEST);
                        _events2.ScheduleEvent(EVENT_GUEST_TALK2, 5000);
                        break;
                    case EVENT_GUEST_TALK2:
                        Talk(SAY_OUT_OF_COMBAT);
                        _events2.ScheduleEvent(EVENT_GUEST_TALK, urand(60000, 120000));
                        break;
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_CHECK_HEALTH:
                        if (me->HealthBelowPct(31))
                        {
                            me->CastSpell(me, SPELL_FRENZY, true);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        break;
                    case EVENT_SPELL_ENRAGE:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                    case EVENT_SPELL_BLIND:
                        if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 10.0f, true))
                            me->CastSpell(target, SPELL_BLIND, false);
                        events.ScheduleEvent(EVENT_SPELL_BLIND, urand(25000, 40000));
                        break;
                    case EVENT_SPELL_GOUGE:
                        me->CastSpell(me->GetVictim(), SPELL_GOUGE, false);
                        events.ScheduleEvent(EVENT_SPELL_GOUGE, urand(25000, 40000));
                        return;
                    case EVENT_SPELL_VANISH:
                        events.DelayEvents(9000);
                        events.SetPhase(1);
                        me->CastSpell(me, SPELL_VANISH, false);
                        events.ScheduleEvent(EVENT_SPELL_VANISH, 30000);
                        events.ScheduleEvent(EVENT_SPELL_GARROTE, urand(5000, 7000));
                        return;
                    case EVENT_SPELL_GARROTE:
                        Talk(SAY_SPECIAL);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            target->CastSpell(target, SPELL_GARROTE, true);
                        me->CastSpell(me, SPELL_VANISH_TELEPORT, false);
                        events.SetPhase(0);
                        break;
                }

                // Xinef: not in vanish
                if (events.GetPhaseMask() == 0)
                    DoMeleeAttackIfReady();
            }

        private:
            EventMap _events2;
            uint8 _activeGuests;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_moroesAI>(creature);
        }
};

class spell_moroes_vanish : public SpellScriptLoader
{
    public:
        spell_moroes_vanish() : SpellScriptLoader("spell_moroes_vanish") { }

        class spell_moroes_vanish_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_moroes_vanish_SpellScript);

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                {
                    Position pos;
                    target->GetFirstCollisionPosition(pos, 5.0f, M_PI);
                    GetCaster()->CastSpell(target, SPELL_GARROTE_DUMMY, true);
                    GetCaster()->RemoveAurasDueToSpell(SPELL_VANISH);
                    GetCaster()->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), target->GetOrientation());
                }

            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_moroes_vanish_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_moroes_vanish_SpellScript();
        }
};

void AddSC_boss_moroes()
{
    new boss_moroes();
    new spell_moroes_vanish();
}
