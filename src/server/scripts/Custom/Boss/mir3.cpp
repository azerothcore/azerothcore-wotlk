//Vyran, The Nature Caller by Mi'rael//

#include "ScriptPCH.h"
#include "Language.h"

enum Spells
{
	AHUNE = 45954,
	SPELL_FIREBOLT = 20801,
	SPELL_CHAINLIGHTNING = 39945,
	SPELL_ENGRAGE = 8599,
	SPELL_SCREAM = 13704,
	SPELL_ACID = 33551,
	SPELL_SOUL = 32057,
	SPELL_CLEAVE = 31345,
    SPELL_SARONITE = 633650
};

class boss_Custom_5 : public CreatureScript
{
public:

	boss_Custom_5()
		: CreatureScript("boss_Custom_5"){}

	struct boss_Custom_5AI : public ScriptedAI
	{
		boss_Custom_5AI(Creature * c) : ScriptedAI(c){}

		uint32 AHUNE_Timer;
		uint32 FIREBOLT_Timer;
		uint32 CHAINLIGHTNING_Timer;
		uint32 ENGRAGE_Timer;
		uint32 SCREAM_Timer;
		uint32 ACID_Timer;
		uint32 SOUL_Timer;
		uint32 CLEAVE_Timer;

		void Reset()
		{
			AHUNE_Timer = 4000;
			FIREBOLT_Timer = 12000;
			CHAINLIGHTNING_Timer = 18000;
			ENGRAGE_Timer = 180000;
			SCREAM_Timer = 20000;
			ACID_Timer = 30000;
			SOUL_Timer = 15000;
			CLEAVE_Timer = 9000;
		}

		void KilledUnit(Unit * /* killed */)
		{
			me->Say("The Power of Nature...is unlimited!", LANG_UNIVERSAL, 0);
		}

		void JustDied(Unit * /* killer */)
		{
			me->Yell("I can't...believe this...You won this time, but your journey is far from over!", LANG_UNIVERSAL, 0);
		}

		void EnterCombat(Unit* /* who */)
		{
			me->Yell("Who are you? You've made a terrible mistake. Now you will meet your DEATH!...", LANG_UNIVERSAL, 0);
		}

		void UpdateAI(uint32 diff)
		{
			DoCast(me, SPELL_SARONITE);
			if (!UpdateVictim())
				return;
			if (AHUNE_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_FIREBOLT);
				AHUNE_Timer = 4000;
			}

			if (FIREBOLT_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_FIREBOLT);
				FIREBOLT_Timer = 10000;
			}
			else
				FIREBOLT_Timer -= diff;

			if (CHAINLIGHTNING_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_CHAINLIGHTNING);
				CHAINLIGHTNING_Timer = 12000;
			}
			else
				CHAINLIGHTNING_Timer -= diff;

			if (ENGRAGE_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_ENGRAGE);
				ENGRAGE_Timer = 180000;
			}
			else
				ENGRAGE_Timer -= diff;

			if (SCREAM_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_SCREAM);
				SCREAM_Timer = 20000;
			}
			else
				SCREAM_Timer -= diff;

			if (ACID_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_ACID);
				ACID_Timer = 30000;
			}
			else
				ACID_Timer -= diff;

			if (SOUL_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_SOUL);
				SOUL_Timer = 15000;
			}
			else
				SOUL_Timer -= diff;

			if (CLEAVE_Timer < diff)
			{
				DoCast(me->GetVictim(), SPELL_CLEAVE);
				CLEAVE_Timer = 9000;
			}
			else
				CLEAVE_Timer -= diff;

			DoMeleeAttackIfReady();

		}
	};

	CreatureAI* GetAI(Creature* creature) const
	{
		return new boss_Custom_5AI(creature);
	}

};

void AddSC_boss_Custom_5()
{
	new boss_Custom_5();
}
