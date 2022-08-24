#include "ScriptPCH.h"
   
#define SPELL_2          45664     // Спелл Свирепое бодание 
#define SPELL_3          45741      // Спелл Вращение 
#define SPELL_4          45641     // Спелл Могучее сокрушение 
#define SPELL_5          45442    // Спелл Всплеск адреналина 
#define SPELL_6          45680    // Спелл Всплеск адреналина 
#define SPELL_7          45605    // Спелл Всплеск адреналина 
#define SPELL_8          46605    // Спелл Всплеск адреналина 
#define SPELL_SARONITE               63364

#define SAY_AGGRO        "Смертные, Вам конец" 
#define SAY_KILL         "Хахаха! Не приходите больше сюда, смертные слабаки !" 
#define SAY_DEATH        "Этого не может быть! Как вы это сделали ? Неееет......." 
#define SAY_SPS1         "Много на себя берёте, Смертные !" 
#define SAY_SPS2         "На....." 
#define SAY_SPS3         "Огненное дыхание !" 
#define SAY_SPS4         "Не стоит меня недооценивать !" 
#define SAY_SPS5         "Ахахахаха, зря вы меня разозлили, теперь получите по полной ! БЕГИТЕ ПОКА НЕ ПОЗДНО !" 

class Arzhara_Fun_boss_7 : public CreatureScript
{
public:
	Arzhara_Fun_boss_7() : CreatureScript("mir7") { }

	CreatureAI* GetAI(Creature* pCreature) const
	{
		return new Arzhara_Fun_boss_7AI(pCreature);
	}
	struct Arzhara_Fun_boss_7AI : public ScriptedAI
	{
		Arzhara_Fun_boss_7AI(Creature *c) : ScriptedAI(c) {}

		uint32 Timer1;
		uint32 Timer2;
		uint32 Timer3;
		uint32 Timer4;
		uint32 Timer5;
		void Reset()
		{
			Timer1 = 35000;
			Timer2 = 30000;
			Timer3 = 20000;
			Timer4 = 40000;
			Timer5 = 60000;
		}

		void EnterCombat(Unit* who)
		{

		}

		void UpdateAI(const uint32 diff)
		{
			DoCast(me, SPELL_SARONITE);
			if (!UpdateVictim())
				return;



			if (Timer1 <= diff){
				DoCast(me->GetVictim(), SPELL_6);
				Timer1 = 35000;
			}
			else Timer1 -= diff;


			if (Timer2 <= diff){
				DoCast(me->GetVictim(), SPELL_2);
				Timer2 = 30000;
			}
			else Timer2 -= diff;


			if (Timer3 <= diff){
				DoCast(me->GetVictim(), SPELL_3);
				DoCast(me->GetVictim(), SPELL_7);
				Timer3 = 20000;
			}
			else Timer3 -= diff;


			if (Timer4 <= diff){
				DoCast(me->GetVictim(), SPELL_4);
				DoCast(me->GetVictim(), SPELL_8);
				Timer4 = 40000;
			}
			else Timer4 -= diff;


			if (Timer5 <= diff){
				DoCast(me->GetVictim(), SPELL_5);
				Timer5 = 60000;
			}
			else Timer5 -= diff;
			DoMeleeAttackIfReady();
		}

		void KilledUnit(Unit *victim)
		{
			if (victim == me)
				return;

		}

		void JustDied(Unit* killer)
		{

		}
	};
};

void AddSC_Arzhara_Fun_boss_7()
{
	new Arzhara_Fun_boss_7();
}
/*
-- SQL
UPDATE creature_template SET ScriptName="Arzhara_Fun_boss_1" WHERE entry=7777777;
*/
