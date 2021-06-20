/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "pit_of_saron.h"
#include "Vehicle.h"

enum Texts
{
    SAY_AGGRO                           = 53,
    SAY_SLAY_1                          = 54,
    SAY_SLAY_2                          = 55,
    SAY_DEATH                           = 56,
    SAY_MARK                            = 57,
    SAY_SMASH                           = 58,
    EMOTE_RIMEFANG_ICEBOLT              = 59,
    EMOTE_SMASH                         = 60,
};

enum Spells
{
    SPELL_OVERLORDS_BRAND               = 69172,
    SPELL_OVERLORDS_BRAND_HEAL          = 69190,
    SPELL_OVERLORDS_BRAND_DAMAGE        = 69189,
    SPELL_FORCEFUL_SMASH                = 69155,
    SPELL_UNHOLY_POWER                  = 69167,
    RIMEFANG_SPELL_ICY_BLAST            = 69232,
    SPELL_MARK_OF_RIMEFANG              = 69275,
    RIMEFANG_SPELL_HOARFROST            = 69246,
};

enum Events
{
    EVENT_SPELL_FORCEFUL_SMASH = 1,
    EVENT_SPELL_UNHOLY_POWER,
    EVENT_SPELL_OVERLORDS_BRAND,
    EVENT_RIMEFANG_SPELL_ICY_BLAST,
    EVENT_SPELL_MARK_OF_RIMEFANG,
};

class boss_tyrannus : public CreatureScript
{
public:
    boss_tyrannus() : CreatureScript("boss_tyrannus") { }

    struct boss_tyrannusAI : public ScriptedAI
    {
        boss_tyrannusAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = me->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_RIMEFANG_GUID)))
            {
                c->SetCanFly(true);
            }
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            events.Reset();
            if (me->HasReactState(REACT_AGGRESSIVE)) // Reset() called by EnterEvadeMode()
            {
                if (!pInstance)
                    return;
                if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_MARTIN_OR_GORKUN_GUID)))
                {
                    c->AI()->DoAction(1);
                    c->DespawnOrUnsummon();
                    pInstance->SetData64(DATA_MARTIN_OR_GORKUN_GUID, 0);
                }
                if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_RIMEFANG_GUID)))
                {
                    c->GetMotionMaster()->Clear();
                    c->GetMotionMaster()->MoveIdle();

                    c->RemoveAllAuras();
                    c->UpdatePosition(1017.3f, 168.974f, 642.926f, 5.2709f, true);
                    c->StopMovingOnCurrentPos();
                    if (Vehicle* v = c->GetVehicleKit())
                        v->InstallAllAccessories(false);
                }
            }
        }

        void DoAction(int32 param)
        {
            if (param == 1)
            {
                Position exitPos = {1023.46f, 159.12f, 628.2f, 5.23f};
                if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_RIMEFANG_GUID)))
                {
                    c->RemoveAura(46598);
                    c->GetMotionMaster()->Clear();
                    c->GetMotionMaster()->MovePath(PATH_BEGIN_VALUE+18, true);
                }
                me->SetHomePosition(exitPos);
                me->GetMotionMaster()->MoveJump(exitPos, 10.0f, 2.0f);

                // start real fight
                me->RemoveAllAuras();
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                DoZoneInCombat();
                me->CastSpell(me, 43979, true);
                Talk(SAY_AGGRO);
                events.Reset();
                events.RescheduleEvent(EVENT_SPELL_FORCEFUL_SMASH, urand(14000,16000));
                events.RescheduleEvent(EVENT_SPELL_OVERLORDS_BRAND, urand(4000,6000));
                events.RescheduleEvent(EVENT_RIMEFANG_SPELL_ICY_BLAST, 5000);
                events.RescheduleEvent(EVENT_SPELL_MARK_OF_RIMEFANG, 25000);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->GetVictim())
            {
                float x,y,z;
                me->GetVictim()->GetPosition(x, y, z);
                if (TSDistCheckPos.GetExactDist(x,y,z) > 100.0f || z > TSDistCheckPos.GetPositionZ()+20.0f || z < TSDistCheckPos.GetPositionZ()-20.0f)
                {
                    me->SetHealth(me->GetMaxHealth());
                    EnterEvadeMode();
                    return;
                }
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_FORCEFUL_SMASH:
                    if (me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FORCEFUL_SMASH, false);
                        events.PopEvent();
                        events.RescheduleEvent(EVENT_SPELL_UNHOLY_POWER, 1000);
                        break;
                    }
                    events.RepeatEvent(3000);
                    break;
                case EVENT_SPELL_UNHOLY_POWER:
                    Talk(SAY_SMASH);
                    Talk(EMOTE_SMASH);
                    me->CastSpell(me, SPELL_UNHOLY_POWER, false);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_SPELL_FORCEFUL_SMASH, urand(40000, 48000));
                    break;
                case EVENT_SPELL_OVERLORDS_BRAND:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 95.0f, true))
                        me->CastSpell(target, SPELL_OVERLORDS_BRAND, false);
                    events.RepeatEvent(urand(11000,12000));
                    break;
                case EVENT_RIMEFANG_SPELL_ICY_BLAST:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 190.0f, true))
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_RIMEFANG_GUID)))
                            c->CastSpell(target, RIMEFANG_SPELL_ICY_BLAST, false);
                    events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_MARK_OF_RIMEFANG:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 190.0f, true))
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_RIMEFANG_GUID)))
                        {
                            Talk(SAY_MARK);
                            c->AI()->Talk(EMOTE_RIMEFANG_ICEBOLT, target);
                            c->CastSpell(target, RIMEFANG_SPELL_HOARFROST, false);
                        }
                    events.RepeatEvent(25000);
                    events.RescheduleEvent(EVENT_RIMEFANG_SPELL_ICY_BLAST, 10000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_TYRANNUS, DONE);
            if (me->IsSummon())
                me->ToTempSummon()->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(RAND(SAY_SLAY_1,SAY_SLAY_2));
        }

        bool CanAIAttack(const Unit* who) const
        {
            switch (who->GetEntry())
            {
                case NPC_MARTIN_VICTUS_2:
                case NPC_GORKUN_IRONSKULL_2:
                case NPC_FREED_SLAVE_1_ALLIANCE:
                case NPC_FREED_SLAVE_2_ALLIANCE:
                case NPC_FREED_SLAVE_3_ALLIANCE:
                case NPC_FREED_SLAVE_1_HORDE:
                case NPC_FREED_SLAVE_2_HORDE:
                case NPC_FREED_SLAVE_3_HORDE:
                    return false;
                default:
                    return true;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_tyrannusAI(creature);
    }
};

void AddSC_boss_tyrannus()
{
    new boss_tyrannus();
}
