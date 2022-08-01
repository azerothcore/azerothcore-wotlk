#include "ScriptPCH.h"

#define SPELL_1          70867    // Спелл Тяжелый шаг      
#define SPELL_2          19717    // Спелл Свирепое бодание 
#define SPELL_3          63317    // Спелл Вращение 
#define SPELL_4          64771    // Спелл Могучее сокрушение 
#define SPELL_5          62030    // Спелл Всплеск адреналина 
#define SPELL_6          66881    // Спелл Всплеск адреналина 
 #define SPELL_7          57949    // Спелл Всплеск адреналина 
 #define SPELL_8          53406    // Спелл Всплеск адреналина 
 #define SPELL_SARONITE               633650
                
 #define SAY_AGGRO        "Смертные, Вам конец" 
 #define SAY_KILL         "Хахаха! Не приходите больше суда, смертные слабаки !" 
 #define SAY_DEATH        "Этого не может быть! Как вы это сделали ? Неееет......." 
 #define SAY_SPS1         "Много на себя берёте, Смертные !" 
 #define SAY_SPS2         "На....." 
 #define SAY_SPS3         "Огненное дыхание !" 
 #define SAY_SPS4         "Не стоит меня недооценивать !" 
 #define SAY_SPS5         "Ахахахаха, зря вы меня разозлили, теперь получите по полной ! БЕГИТЕ ПОКА НЕ ПОЗДНО !" 

class Arzhara_Fun_boss_1 : public CreatureScript
{
public:
    Arzhara_Fun_boss_1() : CreatureScript("mir1") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new Arzhara_Fun_boss_1AI (pCreature);
    }
    struct Arzhara_Fun_boss_1AI : public ScriptedAI
    {
        Arzhara_Fun_boss_1AI(Creature *c) : ScriptedAI(c) {}

          uint32 Timer1; 
          uint32 Timer2; 
          uint32 Timer3; 
          uint32 Timer4; 
          uint32 Timer5; 
		  uint32 Timer6; 
		  uint32 Timer7; 
          void Reset() 
          { 
            Timer1 = 15000; 
            Timer2 = 32000; 
            Timer3 = 25000; 
            Timer4 = 60000; 
            Timer5 = 120000; 
			Timer6 = 40000; 
			Timer7 = 20000; 
          }       

          void EnterCombat(Unit* who) 
          { 
            me->Say(SAY_AGGRO, LANG_UNIVERSAL, 0); 
			
          }       

          void UpdateAI(const uint32 diff) 
          { 
			DoCast(me, SPELL_SARONITE);
            if (!UpdateVictim())       
                  return;          

                
                          
              if(Timer1 <= diff){ 
                me->Say(SAY_SPS1, LANG_UNIVERSAL, 0);
                DoCast(me->GetVictim(), SPELL_8);
				DoCast(me->GetVictim(), SPELL_5);
                Timer1 = 60000; 
              }else Timer1 -= diff; 
                
                          
              if(Timer2 <= diff){ 
                me->Say(SAY_SPS2, LANG_UNIVERSAL, 0);
                DoCast(me->GetVictim(),SPELL_2);
                Timer2 = 30000; 
              }else Timer2 -= diff; 
                
                          
              if(Timer3 <= diff){ 
                me->Say(SAY_SPS3, LANG_UNIVERSAL, 0);
                DoCast(me->GetVictim(),SPELL_3);
                Timer3 = 25000; 
              }else Timer3 -= diff; 
                
                          
              if(Timer4 <= diff){ 
               me->Say(SAY_SPS4, LANG_UNIVERSAL, 0);
                DoCast(me->GetVictim(),SPELL_4);
                Timer4 = 60000; 
              }else Timer4 -= diff; 
                
                          
              if(Timer5 <= diff){ 
                me->Say(SAY_SPS5, LANG_UNIVERSAL, 0);
				DoCast(me, SPELL_7);
                Timer5 = 120000; 
              }else Timer5 -= diff; 

			  if(Timer6 <= diff){ 
                DoCast(me,SPELL_6); 
                Timer6 = 40000; 
              }else Timer6 -= diff; 

			  if(Timer7 <= diff){ 
                DoCast(me,SPELL_7); 
                Timer7 = 20000; 
              }else Timer7 -= diff; 

            DoMeleeAttackIfReady(); 
          }       

          void KilledUnit(Unit *victim) 
          { 
            if (victim == me) 
                  return; 

             me->Say(SAY_KILL, LANG_UNIVERSAL, 0);
          } 

          void JustDied(Unit* killer) 
          { 
            me->Say(SAY_DEATH, LANG_UNIVERSAL, 0);
          } 
 }; 
};

void AddSC_Arzhara_Fun_boss_1()
{
    new Arzhara_Fun_boss_1();
} 
 /* 
 -- SQL 
 UPDATE creature_template SET ScriptName="Arzhara_Fun_boss_1" WHERE entry=7777777; 
 */
