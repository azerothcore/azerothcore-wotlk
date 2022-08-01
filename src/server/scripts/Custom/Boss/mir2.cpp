#include "ScriptPCH.h"

 #define SPELL_1          62661    // Удар хвостом     
 #define SPELL_2          25991    // Спелл Свирепое бодание 
 #define SPELL_3          37018    // Спелл Вращение 
 #define SPELL_4          30852    // Спелл Могучее сокрушение 
 #define SPELL_5          41545    // Спелл Всплеск адреналина
#define SPELL_SARONITE               63364
                
 #define SAY_AGGRO        "Вы зачем ко мне пришли ? Небось помереть захотели ? Ну тогда вперёд !" 
 #define SAY_KILL         "Я же вам сказал что вы суда умереть пришли, моё пророчество всегда сбывается !" 
 #define SAY_DEATH        "На этот раз моё пророчество ошиблось, нееееееет.............." 
 #define SAY_SPS1         "Слуги мои, Поднемитесь из глубин земли, помогите одалеть врага !" 
 #define SAY_SPS2         "Ледяное дыхание !" 
 #define SAY_SPS3         "Охотник, помоги мне, приди на помощь !" 
 #define SAY_SPS4         "Не стоит меня недооценивать !" 
 #define SAY_SPS5         "Ребята, я же сказал, ЧТО ПРОПРОЧЕСТВО МОЁ СБУДЕТCЯ ! БЕГИТЕ !" 

class Arzhara_Fun_boss_2 : public CreatureScript
{
public:
    Arzhara_Fun_boss_2() : CreatureScript("mir2") { }
	
    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new Arzhara_Fun_boss_2AI (pCreature);
    }
    struct Arzhara_Fun_boss_2AI : public ScriptedAI
    {
        Arzhara_Fun_boss_2AI(Creature *c) : ScriptedAI(c) {}
		
          uint32 Timer1; 
          uint32 Timer2; 
          uint32 Timer3; 
          uint32 Timer4; 
          uint32 Timer5; 
          void Reset() 
          { 
            Timer1 = 5000; 
            Timer2 = 10000; 
            Timer3 = 15000; 
            Timer4 = 30000; 
            Timer5 = 40000; 
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
               // me->Say(SAY_SPS1, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_1);
                Timer1 = 5000; 
              }else Timer1 -= diff; 
                
                          
              if(Timer2 <= diff){ 
               // me->Say(SAY_SPS2, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_2);
                Timer2 = 10000; 
              }else Timer2 -= diff; 
                
                          
              if(Timer3 <= diff){ 
                //me->Say(SAY_SPS3, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_3);
                Timer3 = 15000; 
              }else Timer3 -= diff; 
                
                          
              if(Timer4 <= diff){ 
               me->Say(SAY_SPS4, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_4);
                Timer4 = 30000; 
              }else Timer4 -= diff; 
                
                          
              if(Timer5 <= diff){ 
                me->Say(SAY_SPS5, LANG_UNIVERSAL, 0); 
                DoCast(me,SPELL_5); 
                Timer5 = 40000; 
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

void AddSC_Arzhara_Fun_boss_2()
{
    new Arzhara_Fun_boss_2();
} 
 /* 
 -- SQL 
 UPDATE creature_template SET ScriptName="Arzhara_Fun_boss_3" WHERE entry=7777777; 
 */
