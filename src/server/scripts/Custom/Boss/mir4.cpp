#include "ScriptPCH.h"

 #define SPELL_1          65121         
 #define SPELL_2          63024     
 #define SPELL_3          62776    
 #define SPELL_4          64193    
 #define SPELL_5          62776    
#define SPELL_SARONITE               63364
                
 #define SAY_AGGRO        "Неужели кто то пришёл меня повеселить, ну давайте, попробуйте это сделать !" 
 #define SAY_KILL         "Хахаха! Не приходите больше сюда, смертные слабаки !" 
 #define SAY_DEATH        "Нееет........................... Вы за это ответите ..................." 
 #define SAY_SPS1         "Ахахахахаххаах, ребятки, вы же слышали про моего брата, неудачника Иллидана ? Раз слышали тогда узрите истенную форму моего существования" 
 //#define SAY_SPS2         "Умрите же вы наконец, вы не сможете противостоять такой силе, вы же СМЕРТНЫЕ !" 
 //#define SAY_SPS3         "Получайте Смертные !" 
 #define SAY_SPS4         "Не путайся у меня под ногами !" 
 #define SAY_DANCE        "Трололо :)"
//#define SAY_SPS5         //"Ахахахаха, зря вы меня разозлили, теперь получите по полной ! БЕГИТЕ ПОКА НЕ ПОЗДНО !" 

class Arzhara_Fun_boss_4 : public CreatureScript
{
public:
    Arzhara_Fun_boss_4() : CreatureScript("mir4") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new Arzhara_Fun_boss_4AI (pCreature);
    }
    struct Arzhara_Fun_boss_4AI : public ScriptedAI
    {
        Arzhara_Fun_boss_4AI(Creature *c) : ScriptedAI(c) {}

          uint32 Timer1; 
          uint32 Timer2; 
          uint32 Timer3; 
          uint32 Timer4; 
          uint32 Timer5; 
          void Reset() 
          { 
            Timer1 = 205000; 
            Timer2 = 205000; 
            Timer3 = 65000; 
            Timer4 = 350000; 
            Timer5 = 10000; 
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
                DoCast(me,SPELL_1); 
                Timer1 = 205000; 
              }else Timer1 -= diff; 
                
                          
              if(Timer2 <= diff){ 
              //  me->Say(SAY_SPS1, LANG_UNIVERSAL, 0); 
                DoCast(me,SPELL_2); 
                Timer2 = 205000; 
              }else Timer2 -= diff; 
                
                          
              if(Timer3 <= diff){ 
                //me->Say(SAY_SPS3, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_3);
                Timer3 = 65000; 
              }else Timer3 -= diff; 
                
                          
              if(Timer4 <= diff){ 
               me->Say(SAY_SPS4, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_4); 
                Timer4 = 35000; 
              }else Timer4 -= diff; 
                
                          
              if(Timer5 <= diff){ 
               // me->Say(SAY_SPS5, LANG_UNIVERSAL, 0); 
                DoCast(me->GetVictim(),SPELL_5);
                Timer5 = 10000; 
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

void AddSC_Arzhara_Fun_boss_4()
{
    new Arzhara_Fun_boss_4();
} 
