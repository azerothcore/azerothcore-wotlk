#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Chat.h"

#define SAY_PHASE_ZERO "Вы не можете избежать своей судьбы, жалкие существа. Я владыка ночи и кошмаров, и я заберу ваши души!"
#define SAY_PHASE_ONE "Вы можете бороться, но ваши усилия бесполезны. Я жду ваших душ уже давно!"
#define SAY_PHASE_TWO "Ваше сопротивление слабо, ваше здоровье истощается. Приподнимите оружие, если можете, но это не изменит исхода битвы."
#define SAY_PHASE_THREE "Ваши души приближаются! Я буду контролировать их, и ваши тела будут моими слугами в мире кошмаров."
#define SAY_PHASE_FOUR "О, как вы медленно умираете. Я буду сохранять ваши души в моем мире кошмаров навсегда."
#define SAY_PHASE_FIVE "Неужели это конец? Я не могу поверить, что был побежден. Но мои души все еще ждут меня в мире кошмаров. Это не конец, это начало новой жизни."
#define SAY_KILL_PLAYER "Как прекрасно, еще одна душа для моего мира кошмаров. Ваше тело будет служить мне в вечности."

enum Spells{
	SPELL_FIRE = 41958,							// Жертвенный огонь (раз в 21 сек)
	SPELL_AOE_FEAR = 17928,						// Вой ужаса! (раз в 21 сек)
	SPELL_FLUCH_DER_PEIN = 65814,				// Проклятие агонии (раз в 24 сек)
	SPELL_SCHATTENWORT_SCHMERZ = 65541,			// Слово Тьмы: Боль (раз 15 в сек)
    SPELL_VERDERBNIS = 65810,					// Порча (раз в 18 сек)
    SPELL_FLEISCH_EINAESCHERN = 66237,			// Испепеление плоти (раз в 30 сек)
	SPELL_ZAUBERSCHILD = 33054,					// Щит заклятий 75% (раз в 2 минуты)
    SPELL_SPALTEN = 21077,						// Стрела Тьмы (раз в 10 сек)
	SPELL_WIRBELWIND = 68146,					// Адское Пламя (раз в 45 сек)
	SPELL_VERDERBENDE_SEUCHE = 60588,			// Разъедающая гниль (раз в 30 сек)
	SPELL_WUNDGIFT = 47825,						// Ожог души (раз в 18 сек)
	SPELL_HAMMER_DER_GERECHTIGKEIT = 47241,		// Метаморфоза (раз в 5 мин)
	SPELL_GOETTLICHER_STURM = 47860				// Лик смерти (раз в 30 сек)


};

enum Events{
	EVENT_HEALTH_BURN = 1,
	EVENT_FIRE ,
	EVENT_FLUCH_DER_PEIN,
	EVENT_SPALTEN,
	EVENT_SCHATTENWORT_SCHMERZ,
	EVENT_FROSTFIEBER,
	EVENT_VERDERBNIS,
	EVENT_FLEISCH_EINAESCHERN,
	EVENT_ZAUBERSCHILD,
	EVENT_WIRBELWIND,
	EVENT_VERDERBENDE_SEUCHE,
	EVENT_WUNDGIFT,
	EVENT_HAMMER_DER_GERECHTIGKEIT,
	EVENT_GOETTLICHER_STURM,
};

enum Phases{
	PHASE_ONE = 1,
	PHASE_TWO,
	PHASE_THREE,
	PHASE_FOUR,
	PHASE_FIVE,
};

class CustomBossAnna : public CreatureScript{
public:
	CustomBossAnna() : CreatureScript("CustomBossAnna") { }

	struct annaAI : public ScriptedAI {

		annaAI(Creature* c) : ScriptedAI(c) {
            InitialPosition = c->GetPosition();
            MaxDistance = 100.0f;
        }

		void Reset() override
		{
			_events.Reset();
		}

		void EnterCombat(Unit* /*who*/) override
		{
            me->Yell(SAY_PHASE_ZERO, LANG_UNIVERSAL);
			_events.SetPhase(PHASE_ONE);
			_events.ScheduleEvent(EVENT_FLUCH_DER_PEIN, 1000);
			_events.ScheduleEvent(EVENT_SPALTEN, 5000);
		}

		void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
		{
			if (me->HealthBelowPctDamaged(80, damage) && _events.IsInPhase(PHASE_ONE))
			{
                me->Yell(SAY_PHASE_ONE, LANG_UNIVERSAL);
				_events.SetPhase(PHASE_TWO);
				_events.ScheduleEvent(EVENT_FLUCH_DER_PEIN, 0);
				_events.ScheduleEvent(EVENT_SCHATTENWORT_SCHMERZ, 3000);
                _events.ScheduleEvent(EVENT_HEALTH_BURN, 5000);
                _events.ScheduleEvent(EVENT_SPALTEN, 10000);
			}

			if (me->HealthBelowPctDamaged(60, damage) && _events.IsInPhase(PHASE_TWO))
			{
                me->Yell(SAY_PHASE_TWO, LANG_UNIVERSAL);
				_events.SetPhase(PHASE_THREE);
				_events.ScheduleEvent(EVENT_VERDERBNIS, urand(500, 1000));
				_events.ScheduleEvent(EVENT_HEALTH_BURN, 2000);
				_events.ScheduleEvent(EVENT_FIRE, 7000);
				_events.ScheduleEvent(EVENT_HAMMER_DER_GERECHTIGKEIT, 12000);
				_events.ScheduleEvent(EVENT_WIRBELWIND, 17000);
			}

			if (me->HealthBelowPctDamaged(40, damage) && _events.IsInPhase(PHASE_THREE))
			{
                me->Yell(SAY_PHASE_THREE, LANG_UNIVERSAL);
				_events.SetPhase(PHASE_FOUR);
				_events.ScheduleEvent(EVENT_HAMMER_DER_GERECHTIGKEIT, 1000);
				_events.ScheduleEvent(EVENT_HEALTH_BURN, 2500);
				_events.ScheduleEvent(EVENT_FIRE, 3000);
				_events.ScheduleEvent(EVENT_FLEISCH_EINAESCHERN, 10000);
				_events.ScheduleEvent(EVENT_SCHATTENWORT_SCHMERZ, 12000);
				_events.ScheduleEvent(EVENT_WIRBELWIND, 17000);
			}

			if (me->HealthBelowPctDamaged(20, damage) && _events.IsInPhase(PHASE_FOUR))
			{
                me->Yell(SAY_PHASE_FOUR, LANG_UNIVERSAL);
				_events.SetPhase(PHASE_FIVE);
				_events.ScheduleEvent(EVENT_ZAUBERSCHILD, 0);
				_events.ScheduleEvent(EVENT_FLEISCH_EINAESCHERN, 2000);
				_events.ScheduleEvent(EVENT_VERDERBENDE_SEUCHE, 800);
				_events.ScheduleEvent(EVENT_WUNDGIFT, 2000);
				_events.ScheduleEvent(EVENT_GOETTLICHER_STURM, 10000);

			}
		}

		void JustDied(Unit* /*killer*/) override
		{
			me->Yell(SAY_PHASE_FIVE, LANG_UNIVERSAL);
		}

        void KilledUnit(Unit *victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                me->Yell(SAY_KILL_PLAYER, LANG_UNIVERSAL);
        }

        void EnterEvadeMode(EvadeReason pWhy) override
        {
            ScriptedAI::EnterEvadeMode(pWhy);
        }                

		void UpdateAI(uint32 diff) override
		{
			if (!UpdateVictim())
				return;

            if (me->GetDistance(InitialPosition) > MaxDistance) {
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }

			_events.Update(diff);

			while (uint32 eventId = _events.ExecuteEvent())
			{
				switch (eventId)
				{

				case EVENT_HEALTH_BURN:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 15, true)) {
						DoCast(target, SPELL_FIRE);
					}
					_events.ScheduleEvent(EVENT_HEALTH_BURN, 21000);
					break;

				case EVENT_FIRE:
					if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
						DoCast(target, SPELL_AOE_FEAR);
					}
					_events.ScheduleEvent(EVENT_FIRE, 21000);
					break;

				case EVENT_FLUCH_DER_PEIN:
					if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
						DoCast(target, SPELL_FLUCH_DER_PEIN);
					}
					_events.ScheduleEvent(EVENT_FLUCH_DER_PEIN, 24000);
					break;

				case EVENT_SPALTEN:
					DoCastVictim(SPELL_SPALTEN);
					_events.ScheduleEvent(EVENT_SPALTEN, 10000);
					break;

				case EVENT_SCHATTENWORT_SCHMERZ:
					DoCastToAllHostilePlayers(SPELL_SCHATTENWORT_SCHMERZ);
					_events.ScheduleEvent(EVENT_SCHATTENWORT_SCHMERZ, 15000);
					break;

				case EVENT_VERDERBNIS: // порча
					if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
						DoCast(target, SPELL_VERDERBNIS);
					}
					_events.ScheduleEvent(EVENT_VERDERBNIS, 18000);
					break;

				case EVENT_FLEISCH_EINAESCHERN:
					if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
						DoCast(target, SPELL_FLEISCH_EINAESCHERN);
					}
					_events.ScheduleEvent(EVENT_FLEISCH_EINAESCHERN, 30000);
					break;

				case EVENT_WIRBELWIND:
					if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
						DoCast(target, SPELL_WIRBELWIND);
					}
					_events.ScheduleEvent(EVENT_WIRBELWIND, 45000);
					break;

				case EVENT_VERDERBENDE_SEUCHE:
					if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
						DoCast(target, SPELL_VERDERBENDE_SEUCHE);
					}
					_events.ScheduleEvent(EVENT_VERDERBENDE_SEUCHE, 30000);
						break;

				case EVENT_WUNDGIFT:
					DoCastVictim(SPELL_WUNDGIFT);
					_events.ScheduleEvent(EVENT_WUNDGIFT, 18000);
					break;

				case EVENT_HAMMER_DER_GERECHTIGKEIT:
					if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
						DoCast(target, SPELL_HAMMER_DER_GERECHTIGKEIT);
					}
					_events.ScheduleEvent(EVENT_HAMMER_DER_GERECHTIGKEIT, 300000);
					break;

				case EVENT_GOETTLICHER_STURM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true)) {
                        DoCast(target, SPELL_GOETTLICHER_STURM);
                    }
					_events.ScheduleEvent(EVENT_GOETTLICHER_STURM, 30000);
					break;

				case EVENT_ZAUBERSCHILD:
					DoCast(me, SPELL_ZAUBERSCHILD);
					_events.ScheduleEvent(EVENT_ZAUBERSCHILD, 120000);
					break;

				default:
					break;
				}
			}

			DoMeleeAttackIfReady();
		}

	private:
		EventMap _events;
        Position InitialPosition;
        float MaxDistance;
	};

	CreatureAI* GetAI(Creature* creature) const override
	{
		return new annaAI(creature);
	}
};

void AddSC_CustomBossAnna()
{
	new CustomBossAnna();
}