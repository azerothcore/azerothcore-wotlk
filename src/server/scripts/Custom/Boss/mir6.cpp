#include "ScriptPCH.h"

 #define SPELL_1          29998     // Спелл Тяжелый шаг      
 #define SPELL_2          28796     // Спелл Свирепое бодание 
 #define SPELL_3          70853      // Спелл Вращение 
 #define SPELL_4          73070     // Спелл Могучее сокрушение 
 #define SPELL_5          69240    // Спелл Всплеск адреналина 

#define SPELL_SARONITE               633650
                
 #define SAY_AGGRO        "Смертные, Вам конец" 
 #define SAY_KILL         "Хахаха! Не приходите больше сюда, смертные слабаки !" 
 #define SAY_DEATH        "Этого не может быть! Как вы это сделали ? Неееет......." 
 #define SAY_SPS1         "Много на себя берёте, Смертные !" 
 #define SAY_SPS2         "На....." 
 #define SAY_SPS3         "Огненное дыхание !" 
 #define SAY_SPS4         "Не стоит меня недооценивать !" 
 #define SAY_SPS5         "Ахахахаха, зря вы меня разозлили, теперь получите по полной ! БЕГИТЕ ПОКА НЕ ПОЗДНО !" 

class Arzhara_Fun_boss_6 : public CreatureScript
{
public:
    Arzhara_Fun_boss_6() : CreatureScript("mir6") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new Arzhara_Fun_boss_6AI (pCreature);
    }
    struct Arzhara_Fun_boss_6AI : public ScriptedAI
    {
        Arzhara_Fun_boss_6AI(Creature *c) : ScriptedAI(c) {}

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
            me->Say(SAY_AGGRO, LANG_UNIVERSAL, 0); 
          }       

          void UpdateAI(const uint32 diff) 
          { 
			  DoCast(me, SPELL_SARONITE);
            if (!UpdateVictim())       
                  return;          

                
                          
              if(Timer1 <= diff){ 
                me->Say(SAY_SPS5, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_1);
                Timer1 = 35000; 
              }else Timer1 -= diff; 
                
                          
              if(Timer2 <= diff){ 
                DoCast(me->GetVictim(),SPELL_2);
                Timer2 = 30000; 
              }else Timer2 -= diff; 
                
                          
              if(Timer3 <= diff){ 
                DoCast(me->GetVictim(),SPELL_3);
                Timer3 = 20000; 
              }else Timer3 -= diff; 
                
                          
              if(Timer4 <= diff){ 
               me->Say(SAY_SPS4, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_4);
                Timer4 = 40000; 
              }else Timer4 -= diff; 
                
                          
              if(Timer5 <= diff)
			  { 
                me->Say(SAY_SPS5, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_5);
                Timer5 = 60000; 
              }else Timer5 -= diff; 
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

void AddSC_Arzhara_Fun_boss_6()
{
    new Arzhara_Fun_boss_6();
} 
 /* 
 -- SQL 
 UPDATE creature_template SET ScriptName="Arzhara_Fun_boss_1" WHERE entry=7777777; 
 */
