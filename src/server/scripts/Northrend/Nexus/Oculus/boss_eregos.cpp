/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "oculus.h"

enum Spells
{
    SPELL_ARCANE_BARRAGE_N                      = 50804,
    SPELL_ARCANE_BARRAGE_H                      = 59381,
    SPELL_ARCANE_VOLLEY_N                       = 51153,
    SPELL_ARCANE_VOLLEY_H                       = 59382,
    SPELL_ENRAGED_ASSAULT                       = 51170,
    SPELL_PLANAR_ANOMALIES                      = 57959,
    SPELL_PLANAR_SHIFT                          = 51162,

    SPELL_PLANAR_AURA_DAMAGE                    = 59379,
    SPELL_PLANAR_AURA_VISUAL                    = 57971,
    SPELL_PLANAR_BLAST                          = 57976,
    SPELL_SUMMON_PLANAR_ANOMALY                 = 57963,

    SPELL_DRAKE_STOP_TIME                       = 49838,
};

#define SPELL_ARCANE_BARRAGE                    DUNGEON_MODE(SPELL_ARCANE_BARRAGE_N, SPELL_ARCANE_BARRAGE_H)
#define SPELL_ARCANE_VOLLEY                     DUNGEON_MODE(SPELL_ARCANE_VOLLEY_N, SPELL_ARCANE_VOLLEY_H)

enum VarosNPCs
{
    NPC_LEY_GUARDIAN_WHELP                      = 28276,
    NPC_PLANAR_ANOMALY                          = 30879,
};

enum Events
{
    EVENT_SPELL_ARCANE_BARRAGE                  = 1,
    EVENT_SPELL_ARCANE_VOLLEY                   = 2,
    EVENT_SPELL_ENRAGED_ASSAULT                 = 3,
    EVENT_SPELL_PLANAR_SHIFT                    = 4,
    EVENT_SUMMON_WHELPS                         = 5,
    EVENT_SUMMON_SINGLE_WHELP                   = 6,
};

enum Says
{
    SAY_SPAWN           = 0,
    SAY_AGGRO           = 1,
    SAY_ENRAGE          = 2,
    SAY_KILL            = 3,
    SAY_DEATH           = 4,
    SAY_SHIELD          = 5,
};

class boss_eregos : public CreatureScript
{
public:
    boss_eregos() : CreatureScript("boss_eregos") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_eregosAI (pCreature);
    }

    struct boss_eregosAI : public ScriptedAI
    {
        boss_eregosAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 shiftNumber;

        void Reset()
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_EREGOS, NOT_STARTED);
                if( pInstance->GetData(DATA_UROM) != DONE )
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                else
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            events.Reset();
        }

        void EnterCombat(Unit*  /*who*/)
        {
            Talk(SAY_AGGRO);

            if (pInstance)
            {
                pInstance->SetData(DATA_EREGOS, IN_PROGRESS);

                if( me->FindNearestCreature(NPC_AMBER_DRAKE, 750.0f, true) )
                    pInstance->SetData(DATA_AMBER_VOID, 0);
                else
                    pInstance->SetData(DATA_AMBER_VOID, 1);

                if( me->FindNearestCreature(NPC_EMERALD_DRAKE, 750.0f, true) )
                    pInstance->SetData(DATA_EMERALD_VOID, 0);
                else
                    pInstance->SetData(DATA_EMERALD_VOID, 1);

                if( me->FindNearestCreature(NPC_RUBY_DRAKE, 750.0f, true) )
                    pInstance->SetData(DATA_RUBY_VOID, 0);
                else
                    pInstance->SetData(DATA_RUBY_VOID, 1);
            }

            me->SetInCombatWithZone();

            shiftNumber = 0;

            events.RescheduleEvent(EVENT_SPELL_ARCANE_BARRAGE, 0);
            events.RescheduleEvent(EVENT_SPELL_ARCANE_VOLLEY, 5000);
            events.RescheduleEvent(EVENT_SPELL_ENRAGED_ASSAULT, 35000);
            events.RescheduleEvent(EVENT_SUMMON_WHELPS, 40000);
        }

        void JustDied(Unit*  /*killer*/)
        {
            Talk(SAY_DEATH);

            if (pInstance)
                pInstance->SetData(DATA_EREGOS, DONE);

            me->SummonGameObject(GO_SPOTLIGHT, 1018.06f, 1051.09f, 605.619019f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
        }

        void DamageTaken(Unit*, uint32 & /*damage*/, DamageEffectType, SpellSchoolMask)
        {
            if( !me->GetMap()->IsHeroic() )
                return;

            if( shiftNumber <= uint32(1) && uint32(me->GetHealth()*100/me->GetMaxHealth()) <= uint32(60-shiftNumber*40) )
            {
                ++shiftNumber;
                events.RescheduleEvent(EVENT_SPELL_PLANAR_SHIFT, 0);
            }
        }

        void KilledUnit(Unit * /*victim*/)
        {
            Talk(SAY_KILL);
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}

        void JustSummoned(Creature* pSummon)
        {
            if( pSummon->GetEntry() != NPC_LEY_GUARDIAN_WHELP )
                return;

            DoZoneInCombat(pSummon, 300.0f);
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            if( me->HasAura(SPELL_PLANAR_SHIFT) || me->HasAura(SPELL_DRAKE_STOP_TIME) )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            DoMeleeAttackIfReady();

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_ARCANE_BARRAGE:
                    if( Unit* v = me->GetVictim() )
                        me->CastSpell(v, SPELL_ARCANE_BARRAGE, false);
                    events.RepeatEvent(2500);
                    break;
                case EVENT_SPELL_ARCANE_VOLLEY:
                    me->CastSpell(me, SPELL_ARCANE_VOLLEY, false);
                    events.RepeatEvent(8000);
                    break;
                case EVENT_SPELL_ENRAGED_ASSAULT:
                    Talk(SAY_ENRAGE);
                    me->CastSpell(me, SPELL_ENRAGED_ASSAULT, false);
                    events.RepeatEvent(35000);
                    break;
                case EVENT_SUMMON_WHELPS:
                    for( uint8 i=0; i<5; ++i )
                        events.ScheduleEvent(EVENT_SUMMON_SINGLE_WHELP, urand(0, 8000));
                    events.RepeatEvent(40000);
                    break;
                case EVENT_SUMMON_SINGLE_WHELP:
                    {
                        float x = rand_norm()*50.0f-25.0f;
                        float y = rand_norm()*50.0f-25.0f;
                        float z = rand_norm()*50.0f-25.0f;
                        me->SummonCreature(NPC_LEY_GUARDIAN_WHELP, me->GetPositionX()+x, me->GetPositionY()+y, me->GetPositionZ()+z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_SPELL_PLANAR_SHIFT:
                    //me->MonsterYell(TEXT_PLANAR_SHIFT_SAY, LANG_UNIVERSAL, 0);
                    Talk(SAY_SHIELD);
                    me->CastSpell(me, SPELL_PLANAR_SHIFT, false);
                    for( uint8 i=0; i<3; ++i )
                        if( Unit* t = SelectTarget(SELECT_TARGET_RANDOM, 0, 300.0f, false) )
                            if( Creature* pa = me->SummonCreature(NPC_PLANAR_ANOMALY, *me, TEMPSUMMON_TIMED_DESPAWN, 17000) )
                            {
                                pa->SetCanFly(true);
                                pa->SetDisableGravity(true);
                                pa->SetHover(true);
                                pa->SendMovementFlagUpdate();
                                pa->CastSpell(pa, SPELL_PLANAR_AURA_VISUAL, true);
                                pa->CastSpell(pa, SPELL_PLANAR_AURA_DAMAGE, true);
                                if (Aura* a = pa->GetAura(SPELL_PLANAR_AURA_DAMAGE))
                                    a->SetDuration(15000);
                                if( pa->AI() )
                                {
                                    pa->AI()->AttackStart(t);
                                    pa->GetMotionMaster()->MoveChase(t, 0.01f);
                                }
                            }
                    events.PopEvent();
                    break;
            }
        }
    };
};

void AddSC_boss_eregos()
{
    new boss_eregos();
}
