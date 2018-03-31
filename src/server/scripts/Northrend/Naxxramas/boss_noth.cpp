/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_SUMMON                      = 1,
    SAY_SLAY                        = 2,
    SAY_DEATH                       = 3
};

enum Spells
{
    SPELL_CURSE_OF_THE_PLAGUEBRINGER_10     = 29213,
    SPELL_CURSE_OF_THE_PLAGUEBRINGER_25     = 54835,
    SPELL_CRIPPLE_10                        = 29212,
    SPELL_CRIPPLE_25                        = 54814,
    SPELL_SUMMON_PLAGUED_WARRIORS           = 29237,
    SPELL_TELEPORT                          = 29216,
    SPELL_BLINK                             = 29208,
};

enum Events
{
    EVENT_SPELL_CURSE                       = 1,
    EVENT_SPELL_CRIPPLE                     = 2,
    EVENT_SUMMON_PLAGUED_WARRIOR_ANNOUNCE   = 3,
    EVENT_MOVE_TO_BALCONY                   = 4,
    EVENT_SPELL_BLINK                       = 5,
    EVENT_MOVE_TO_GROUND                    = 6,
    EVENT_SUMMON_PLAGUED_WARRIOR_REAL       = 7,
    EVENT_BALCONY_SUMMON_ANNOUNCE           = 8,
    EVENT_BALCONY_SUMMON_REAL               = 9,
};

enum Misc
{
    NPC_PLAGUED_WARRIOR                     = 16984,
    NPC_PLAGUED_CHAMPION                    = 16983,
    NPC_PLAGUED_GUARDIAN                    = 16981,
};

const Position summoningPosition[5] =
{
    {2728.12f, -3544.43f, 261.91f, 6.04f},
    {2729.05f, -3544.47f, 261.91f, 5.58f},
    {2728.24f, -3465.08f, 264.20f, 3.56f},
    {2704.11f, -3456.81f, 265.53f, 4.51f},
    {2663.56f, -3464.43f, 262.66f, 5.20f},
};

const Position nothPosition = {2684.94f, -3502.53f, 261.31f, 4.7f};

class boss_noth : public CreatureScript
{
public:
    boss_noth() : CreatureScript("boss_noth") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_nothAI (pCreature);
    }

    struct boss_nothAI : public BossAI
    {
        boss_nothAI(Creature *c) : BossAI(c, BOSS_NOTH), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void StartGroundPhase()
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
            me->SetControlled(false, UNIT_STATE_ROOT);
            events.SetPhase(0);

            events.Reset();
            events.ScheduleEvent(EVENT_MOVE_TO_BALCONY, 110000);
            events.ScheduleEvent(EVENT_SPELL_CURSE, 15000);
            events.ScheduleEvent(EVENT_SUMMON_PLAGUED_WARRIOR_ANNOUNCE, 25000);
            if (Is25ManRaid())
                events.ScheduleEvent(EVENT_SPELL_BLINK, 26000);
        }

        void StartBalconyPhase()
        {
            me->SetReactState(REACT_PASSIVE);
            me->AttackStop();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE |UNIT_FLAG_DISABLE_MOVE);
            me->SetControlled(true, UNIT_STATE_ROOT);
            events.SetPhase(1);
            events.Reset();
            events.ScheduleEvent(EVENT_BALCONY_SUMMON_ANNOUNCE, 4000);
            events.ScheduleEvent(EVENT_MOVE_TO_GROUND, 70000);
        }

        void SummonHelper(uint32 entry, uint32 count)
        {
            for (uint8 i = 0; i < count; ++i)
                me->SummonCreature(entry, summoningPosition[urand(0,4)]);
        }

        bool IsInRoom()
        {
            if (me->GetPositionX() > 2730 || me->GetPositionX() < 2614 || me->GetPositionY() > -3455 || me->GetPositionY() < -3553)
            {
                EnterEvadeMode();
                return false;
            }

            return true;
        }

        void Reset()
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->SetReactState(REACT_AGGRESSIVE);
            events.SetPhase(0);
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode();
        }

        void EnterCombat(Unit * who)
        {
            BossAI::EnterCombat(who);
            Talk(SAY_AGGRO);
            StartGroundPhase();
        }

        void JustSummoned(Creature *summon)
        {
            summons.Summon(summon);
            summon->SetInCombatWithZone();
        }

        void JustDied(Unit*  killer)
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (!urand(0,3))
                Talk(SAY_SLAY);

            if (pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void UpdateAI(uint32 diff)
        {
            if (!IsInRoom())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                // GROUND
                case EVENT_SPELL_CURSE:
                    if (events.GetPhaseMask() == 0)
                    me->CastCustomSpell(RAID_MODE(SPELL_CURSE_OF_THE_PLAGUEBRINGER_10, SPELL_CURSE_OF_THE_PLAGUEBRINGER_25), SPELLVALUE_MAX_TARGETS, RAID_MODE(3, 10), me, false);
                    events.RepeatEvent(25000);
                    break;
                case EVENT_SUMMON_PLAGUED_WARRIOR_ANNOUNCE:
                    me->MonsterTextEmote("Noth the Plaguebringer summons forth Skeletal Warriors!", 0, true);
                    Talk(SAY_SUMMON);
                    events.RepeatEvent(25000);
                    events.ScheduleEvent(EVENT_SUMMON_PLAGUED_WARRIOR_REAL, 4000);
                    break;
                case EVENT_SUMMON_PLAGUED_WARRIOR_REAL:
                    me->CastSpell(me, SPELL_SUMMON_PLAGUED_WARRIORS, true);
                    SummonHelper(NPC_PLAGUED_WARRIOR, RAID_MODE(2,3));
                    events.PopEvent();
                    break;
                case EVENT_MOVE_TO_BALCONY:
                    me->MonsterTextEmote("%s teleports to the balcony above!", 0, true);
                    me->CastSpell(me, SPELL_TELEPORT, true);
                    StartBalconyPhase();
                    //events.PopEvent(); events.Reset()!!
                    break;
                case EVENT_SPELL_BLINK:
                    DoResetThreat();
                    me->MonsterTextEmote("%s blinks away!", 0, true);
                    me->CastSpell(me, RAID_MODE(SPELL_CRIPPLE_10, SPELL_CRIPPLE_25), false);
                    me->CastSpell(me, SPELL_BLINK, true);
                    events.RepeatEvent(30000);
                    break;
                // BALCONY
                case EVENT_BALCONY_SUMMON_ANNOUNCE:
                    me->MonsterTextEmote("%s raises more skeletons!", 0, true);
                    events.RepeatEvent(25000);
                    events.ScheduleEvent(EVENT_BALCONY_SUMMON_REAL, 4000);
                    break;
                case EVENT_BALCONY_SUMMON_REAL:
                    me->CastSpell(me, SPELL_SUMMON_PLAGUED_WARRIORS, true); // visual only
                    if (events.GetPhaseMask() == 0)
                        SummonHelper(NPC_PLAGUED_CHAMPION, RAID_MODE(2,4));
                    else if (events.GetPhaseMask() == 1)
                    {
                        SummonHelper(NPC_PLAGUED_CHAMPION, RAID_MODE(1,2));
                        SummonHelper(NPC_PLAGUED_GUARDIAN, RAID_MODE(1,2));
                    }
                    else
                        SummonHelper(NPC_PLAGUED_GUARDIAN, RAID_MODE(2,4));
                    events.PopEvent();
                    break;
                case EVENT_MOVE_TO_GROUND:
                    me->MonsterTextEmote("%s teleports back into the battle!", 0, true);
                    StartGroundPhase();
                    me->NearTeleportTo(nothPosition.GetPositionX(), nothPosition.GetPositionY(), nothPosition.GetPositionZ(), nothPosition.GetOrientation(), true);
                    break;
            }

            if (me->HasReactState(REACT_AGGRESSIVE))
                DoMeleeAttackIfReady();
        }
    };  
};

void AddSC_boss_noth()
{
    new boss_noth();
}
