/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "trial_of_the_champion.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"

enum EadricSpells
{
    //Eadric
    SPELL_EADRIC_ACHIEVEMENT            = 68197,
    ACHIEV_FACEROLLER                   = 3803,

    SPELL_RADIANCE                      = 66935,
    SPELL_VENGEANCE                     = 66865,
    SPELL_HAMMER_JUSTICE                = 66863,
    SPELL_HAMMER_RIGHTEOUS              = 66867,
    SPELL_HAMMER_RIGHTEOUS_DAMAGE       = 66903,
    SPELL_HAMMER_RIGHTEOUS_ACTION_BAR   = 66904,
    SPELL_HAMMER_RIGHTEOUS_THROW_BACK   = 66905,
};

enum EadricEvents
{
    EVENT_SPELL_RADIANCE = 1,
    EVENT_SPELL_HAMMER_RIGHTEOUS,
};

enum PaletressSpells
{
    SPELL_SMITE_N                       = 66536,
    SPELL_SMITE_H                       = 67674,
    SPELL_HOLY_FIRE_N                   = 66538,
    SPELL_HOLY_FIRE_H                   = 67676,
    SPELL_RENEW_N                       = 66537,
    SPELL_RENEW_H                       = 67675,

    SPELL_HOLY_NOVA                     = 66546,
    SPELL_SHIELD                        = 66515,
    SPELL_CONFESS                       = 66680,
    SPELL_SUMMON_MEMORY                 = 66545,

    //Memory
    SPELL_OLD_WOUNDS_N                  = 66620,
    SPELL_OLD_WOUNDS_H                  = 67679,
    SPELL_SHADOWS_PAST_N                = 66619,
    SPELL_SHADOWS_PAST_H                = 67678,
    SPELL_WAKING_NIGHTMARE_N            = 66552,
    SPELL_WAKING_NIGHTMARE_H            = 67677,
};

#define SPELL_SMITE                     DUNGEON_MODE(SPELL_SMITE_N, SPELL_SMITE_H)
#define SPELL_HOLY_FIRE                 DUNGEON_MODE(SPELL_HOLY_FIRE_N, SPELL_HOLY_FIRE_H)
#define SPELL_RENEW                     DUNGEON_MODE(SPELL_RENEW_N, SPELL_RENEW_H)
#define SPELL_OLD_WOUNDS                DUNGEON_MODE(SPELL_OLD_WOUNDS_N, SPELL_OLD_WOUNDS_H)
#define SPELL_SHADOWS_PAST              DUNGEON_MODE(SPELL_SHADOWS_PAST_N, SPELL_SHADOWS_PAST_H)
#define SPELL_WAKING_NIGHTMARE          DUNGEON_MODE(SPELL_WAKING_NIGHTMARE_N, SPELL_WAKING_NIGHTMARE_H)

enum PaletressEvents
{
    EVENT_SPELL_SMITE = 1,
    EVENT_SPELL_HOLY_FIRE,
    EVENT_SPELL_RENEW,

    EVENT_MEMORY_SCALE,
    EVENT_MEMORY_START_ATTACK,
    EVENT_SPELL_OLD_WOUNDS,
    EVENT_SPELL_SHADOWS_PAST,
    EVENT_SPELL_WAKING_NIGHTMARE,
};

#define TEXT_RADIATE                    "Eadric the Pure begins to radiate light. Shield your eyes!"

class boss_eadric : public CreatureScript
{
public:
    boss_eadric() : CreatureScript("boss_eadric") { }
    struct boss_eadricAI : public ScriptedAI
    {
        boss_eadricAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
            if( pInstance )
                pInstance->SetData(BOSS_ARGENT_CHALLENGE, NOT_STARTED);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if( type == POINT_MOTION_TYPE && id == 1 )
                me->SetFacingTo(3 * M_PI / 2);
        }

        void KilledUnit(Unit* who)
        {
            if( who->GetTypeId() == TYPEID_PLAYER )
            {
                if( urand(0, 1) )
                    Talk(TEXT_EADRIC_SLAIN_1);
                else
                    Talk(TEXT_EADRIC_SLAIN_2);
            }
        }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_RADIANCE, 16000);
            events.ScheduleEvent(EVENT_SPELL_HAMMER_RIGHTEOUS, 25000);
            Talk(TEXT_EADRIC_AGGRO);
            me->CastSpell(me, SPELL_VENGEANCE, false);
            if( pInstance )
                pInstance->SetData(BOSS_ARGENT_CHALLENGE, IN_PROGRESS);
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spell)
        {
            if (spell->Id == 66905 && me->GetHealth() == 1) // hammer throw back damage (15k)
                me->CastSpell(me, 68197, true);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if( damage >= me->GetHealth() )
            {
                damage = me->GetHealth() - 1;
                if( me->getFaction() != 35 )
                {
                    me->CastSpell((Unit*)NULL, 68575, true); // achievements
                    me->GetMap()->UpdateEncounterState(ENCOUNTER_CREDIT_CAST_SPELL, 68574, me); // paletress' spell credits encounter, but shouldn't credit achievements
                    me->setFaction(35);
                    events.Reset();
                    Talk(TEXT_EADRIC_DEATH);
                    me->getThreatManager().clearReferences();
                    me->SetRegeneratingHealth(false);
                    _EnterEvadeMode();
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    if( pInstance )
                        pInstance->SetData(BOSS_ARGENT_CHALLENGE, DONE);
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_RADIANCE:
                    me->CastSpell((Unit*)NULL, SPELL_RADIANCE, false);
                    me->MonsterTextEmote(TEXT_RADIATE, 0, true);
                    events.RepeatEvent(16000);
                    break;
                case EVENT_SPELL_HAMMER_RIGHTEOUS:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 55.0f, true) )
                    {
                        char buffer[100];
                        sprintf(buffer, "Eadric the Pure targets %s with the Hammer of the Righteous!", target->GetName().c_str());
                        me->MonsterTextEmote(buffer, 0, true);
                        Talk(TEXT_EADRIC_HAMMER);
                        me->CastSpell(target, SPELL_HAMMER_JUSTICE, true);
                        me->CastSpell(target, SPELL_HAMMER_RIGHTEOUS, false);
                    }
                    events.RepeatEvent(25000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_eadricAI(pCreature);
    }
};

class boss_paletress : public CreatureScript
{
public:
    boss_paletress() : CreatureScript("boss_paletress") { }

    struct boss_paletressAI : public ScriptedAI
    {
        boss_paletressAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        bool summoned;
        uint64 MemoryGUID;

        void Reset()
        {
            events.Reset();
            summoned = false;
            if( MemoryGUID )
            {
                if( Creature* memory = ObjectAccessor::GetCreature(*me, MemoryGUID) )
                    memory->DespawnOrUnsummon();
                MemoryGUID = 0;
            }
            me->SetReactState(REACT_PASSIVE);
            if( pInstance )
                pInstance->SetData(BOSS_ARGENT_CHALLENGE, NOT_STARTED);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if( type == POINT_MOTION_TYPE && id == 1 )
                me->SetFacingTo(3 * M_PI / 2);
        }

        void KilledUnit(Unit* who)
        {
            if( who->GetTypeId() == TYPEID_PLAYER )
            {
                if( urand(0, 1) )
                    Talk(TEXT_PALETRESS_SLAIN_1);
                else
                    Talk(TEXT_PALETRESS_SLAIN_2);
            }
        }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_HOLY_FIRE, urand(9000, 12000));
            events.ScheduleEvent(EVENT_SPELL_SMITE, urand(2000, 3000));
            me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            Talk(TEXT_PALETRESS_AGGRO);
            if( pInstance )
                pInstance->SetData(BOSS_ARGENT_CHALLENGE, IN_PROGRESS);
        }

        void DoAction(int32 param)
        {
            if( param == 1 )
            {
                MemoryGUID = 0;
                me->RemoveAura(SPELL_SHIELD);
                Talk(TEXT_PALETRESS_MEMORY_DEFEATED);
            }
            else if( param == (-1) )
            {
                if( MemoryGUID )
                    if( Creature* memory = ObjectAccessor::GetCreature(*me, MemoryGUID) )
                    {
                        memory->DespawnOrUnsummon();
                        MemoryGUID = 0;
                    }
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            //if( me->HasAura(SPELL_SHIELD) )
            //  return;

            if( damage >= me->GetHealth() )
            {
                damage = me->GetHealth() - 1;

                if( me->getFaction() != 35 )
                {
                    me->CastSpell((Unit*)NULL, 68574, true); // achievements
                    me->setFaction(35);
                    events.Reset();
                    Talk(TEXT_PALETRESS_DEATH);
                    me->getThreatManager().clearReferences();
                    me->SetRegeneratingHealth(false);
                    _EnterEvadeMode();
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    if( pInstance )
                    {
                        pInstance->SetData(BOSS_ARGENT_CHALLENGE, DONE);
                        pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 68206);
                    }
                }
            }
        }

        void JustSummoned(Creature* summon)
        {
            if( pInstance )
                pInstance->SetData(DATA_MEMORY_ENTRY, summon->GetEntry());
            MemoryGUID = summon->GetGUID();
        }

        void SummonMemory()
        {
            uint8 uiRandom = urand(0, 25);
            uint32 uiSpells[26] = {66704, 66705, 66706, 66707, 66709, 66710, 66711, 66712, 66713, 66714, 66715, 66708, 66708, 66691, 66692, 66694, 66695, 66696, 66697, 66698, 66699, 66700, 66701, 66702, 66703, 66543};
            me->CastSpell(me, uiSpells[uiRandom], true);
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !summoned && HealthBelowPct(25) )
            {
                me->InterruptNonMeleeSpells(true);
                Talk(TEXT_PALETRESS_MEMORY_SUMMON);
                me->CastSpell((Unit*)NULL, SPELL_HOLY_NOVA, false);
                me->CastSpell(me, SPELL_SHIELD, false);
                me->CastSpell((Unit*)NULL, SPELL_SUMMON_MEMORY, false);
                SummonMemory();
                me->CastSpell((Unit*)NULL, SPELL_CONFESS, false);
                events.ScheduleEvent(EVENT_SPELL_RENEW, urand(6000, 8000));
                summoned = true;
                return;
            }

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SMITE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true) )
                        me->CastSpell(target, SPELL_SMITE, false);
                    events.RepeatEvent(urand(3000, 4000));
                    break;
                case EVENT_SPELL_HOLY_FIRE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true) )
                        me->CastSpell(target, SPELL_HOLY_FIRE, false);
                    events.RepeatEvent(urand(9000, 12000));
                    break;
                case EVENT_SPELL_RENEW:
                    if( !MemoryGUID )
                    {
                        break;
                    }
                    if( urand(0, 1) )
                        me->CastSpell(me, SPELL_RENEW, false);
                    else if( Creature* memory = ObjectAccessor::GetCreature(*me, MemoryGUID) )
                        if( memory->IsAlive() )
                            me->CastSpell(memory, SPELL_RENEW, false);
                    events.RepeatEvent(urand(15000, 17000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_paletressAI(pCreature);
    }
};

class npc_memory : public CreatureScript
{
public:
    npc_memory() : CreatureScript("npc_memory") { }

    struct npc_memoryAI : public ScriptedAI
    {
        npc_memoryAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
            me->SetObjectScale(0.01f);
            events.ScheduleEvent(EVENT_MEMORY_SCALE, 500);
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() {}

        void JustDied(Unit* /*killer*/)
        {
            me->DespawnOrUnsummon(20000);
            if( pInstance )
                if( Creature* paletress = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_PALETRESS)) )
                    paletress->AI()->DoAction(1);
        }

        void UpdateAI(uint32 diff)
        {
            UpdateVictim();

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_MEMORY_SCALE:
                    me->SetObjectScale(1.0f);
                    events.ScheduleEvent(EVENT_MEMORY_START_ATTACK, 5000);
                    
                    break;
                case EVENT_MEMORY_START_ATTACK:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    if( Unit* target = me->SelectNearestTarget(200.0f) )
                    {
                        AttackStart(target);
                        DoZoneInCombat();
                    }
                    me->SetReactState(REACT_AGGRESSIVE);
                    events.ScheduleEvent(EVENT_SPELL_OLD_WOUNDS, 8000);
                    events.ScheduleEvent(EVENT_SPELL_SHADOWS_PAST, 4000);
                    events.ScheduleEvent(EVENT_SPELL_WAKING_NIGHTMARE, urand(20000, 30000));
                    break;
                case EVENT_SPELL_OLD_WOUNDS:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 10.0f, true) )
                        me->CastSpell(target, SPELL_OLD_WOUNDS, true);
                    events.RepeatEvent(12000);
                    break;
                case EVENT_SPELL_SHADOWS_PAST:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true) )
                        me->CastSpell(target, SPELL_SHADOWS_PAST, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                case EVENT_SPELL_WAKING_NIGHTMARE:
                    me->CastSpell(me, SPELL_WAKING_NIGHTMARE, false);
                    events.RepeatEvent(35000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_memoryAI(pCreature);
    }
};


enum ArgentSoldierSpells
{
    // monk
    SPELL_FLURRY_OF_BLOWS               = 67233,
    SPELL_PUMMEL                        = 67235,
    SPELL_DIVINE_SHIELD_H               = 67251,
    SPELL_FINAL_MEDITATION_H            = 67255,

    // priestess
    SPELL_HOLY_SMITE_N                  = 36176,
    SPELL_HOLY_SMITE_H                  = 67289,
    SPELL_FOUNTAIN_OF_LIGHT             = 67194,
    NPC_FOUNTAIN_OF_LIGHT               = 35311,
    SPELL_SHADOW_WORD_PAIN_N            = 34941,
    SPELL_SHADOW_WORD_PAIN_H            = 34942,
    SPELL_MIND_CONTROL_H                = 67229,

    // lightwielder
    SPELL_BLAZING_LIGHT_N               = 67247,
    SPELL_BLAZING_LIGHT_H               = 67290,
    SPELL_CLEAVE                        = 15284,
    SPELL_UNBALANCING_STRIKE_H          = 67237,
};

#define SPELL_HOLY_SMITE                DUNGEON_MODE(SPELL_HOLY_SMITE_N, SPELL_HOLY_SMITE_H)
#define SPELL_SHADOW_WORD_PAIN          DUNGEON_MODE(SPELL_SHADOW_WORD_PAIN_N, SPELL_SHADOW_WORD_PAIN_H)
#define SPELL_BLAZING_LIGHT             DUNGEON_MODE(SPELL_BLAZING_LIGHT_N, SPELL_BLAZING_LIGHT_H)

enum ArgentSoldierEvents
{
    EVENT_MONK_SPELL_FLURRY_OF_BLOWS = 1,
    EVENT_MONK_SPELL_PUMMEL,
    EVENT_PRIESTESS_SPELL_HOLY_SMITE,
    EVENT_PRIESTESS_SPELL_SHADOW_WORD_PAIN,
    EVENT_PRIESTESS_SPELL_FOUNTAIN_OF_LIGHT,
    EVENT_PRIESTESS_SPELL_MIND_CONTROL_H,
    EVENT_LIGHTWIELDER_SPELL_BLAZING_LIGHT,
    EVENT_LIGHTWIELDER_SPELL_CLEAVE,
    EVENT_LIGHTWIELDER_SPELL_UNBALANCING_STRIKE_H,
};

class npc_argent_soldier : public CreatureScript
{
public:
    npc_argent_soldier() : CreatureScript("npc_argent_soldier") { }

    struct npc_argent_soldierAI : public npc_escortAI
    {
        npc_argent_soldierAI(Creature* pCreature) : npc_escortAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            SetDespawnAtEnd(false);
            uiWaypoint = 0;
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 uiWaypoint;
        bool bCheck;

        void Reset()
        {
            events.Reset();
            bCheck = false;
        }

        void WaypointReached(uint32 uiPoint)
        {
            if( uiPoint == 1 )
            {
                switch( uiWaypoint )
                {
                    case 0:
                        me->SetFacingTo(5.4f);
                        break;
                    case 1:
                        me->SetFacingTo(4.6f);
                        break;
                    case 2:
                        me->SetFacingTo(4.0f);
                        break;
                }
            }
        }

        void SetData(uint32 uiType, uint32 /*uiData*/)
        {
            AddWaypoint(0, me->GetPositionX(), 660.0f, 411.80f);
            switch( me->GetEntry() )
            {
                case NPC_ARGENT_LIGHTWIELDER:
                    switch( uiType )
                    {
                        case 0:
                            AddWaypoint(1, 716.321f, 647.047f, 411.93f);
                            break;
                        case 1:
                            AddWaypoint(1, 742.44f, 650.29f, 411.79f);
                            break;
                        case 2:
                            AddWaypoint(1, 772.6314f, 651.7f, 411.93f);
                            break;
                    }
                    break;
                case NPC_ARGENT_MONK:
                    switch( uiType )
                    {
                        case 0:
                            AddWaypoint(1, 717.86f, 649.0f, 411.923f);
                            break;
                        case 1:
                            AddWaypoint(1, 746.73f, 650.24f, 411.56f);
                            break;
                        case 2:
                            AddWaypoint(1, 775.567f, 648.26f, 411.93f);
                            break;
                    }
                    break;
                case NPC_PRIESTESS:
                    switch( uiType )
                    {
                        case 0:
                            AddWaypoint(1, 719.872f, 650.94f, 411.93f);
                            break;
                        case 1:
                            AddWaypoint(1, 750.72f, 650.20f, 411.77f);
                            break;
                        case 2:
                            AddWaypoint(1, 777.78f, 645.70f, 411.93f);
                            break;
                    }
                    break;
            }

            Start(false, true, 0);
            uiWaypoint = uiType;
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if( bCheck && damage >= me->GetHealth() )
            {
                bCheck = false;
                damage = me->GetHealth() - 1;
                events.DelayEvents(10000);
                me->CastSpell(me, SPELL_DIVINE_SHIELD_H, true);
                me->CastSpell((Unit*)NULL, SPELL_FINAL_MEDITATION_H, true);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            switch( me->GetEntry() )
            {
                case NPC_ARGENT_MONK:
                    events.RescheduleEvent(EVENT_MONK_SPELL_FLURRY_OF_BLOWS, 5000);
                    events.RescheduleEvent(EVENT_MONK_SPELL_PUMMEL, 7000);
                    if( IsHeroic() )
                        bCheck = true;
                    break;
                case NPC_PRIESTESS:
                    events.RescheduleEvent(EVENT_PRIESTESS_SPELL_HOLY_SMITE, urand(5000, 8000));
                    events.RescheduleEvent(EVENT_PRIESTESS_SPELL_SHADOW_WORD_PAIN, urand(3000, 6000));
                    events.RescheduleEvent(EVENT_PRIESTESS_SPELL_FOUNTAIN_OF_LIGHT, urand(8000, 15000));
                    if( IsHeroic() )
                        events.RescheduleEvent(EVENT_PRIESTESS_SPELL_MIND_CONTROL_H, 12000);
                    break;
                case NPC_ARGENT_LIGHTWIELDER:
                    events.RescheduleEvent(EVENT_LIGHTWIELDER_SPELL_BLAZING_LIGHT, urand(12000, 15000));
                    events.RescheduleEvent(EVENT_LIGHTWIELDER_SPELL_CLEAVE, urand(3000, 5000));
                    if( IsHeroic() )
                        events.RescheduleEvent(EVENT_LIGHTWIELDER_SPELL_UNBALANCING_STRIKE_H, urand(8000, 12000));
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;

                case EVENT_MONK_SPELL_FLURRY_OF_BLOWS:
                    me->CastSpell(me, SPELL_FLURRY_OF_BLOWS, false);
                    events.RepeatEvent(urand(12000, 18000));
                    break;
                case EVENT_MONK_SPELL_PUMMEL:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_PUMMEL, false);
                    events.RepeatEvent(urand(8000, 11000));
                    break;

                case EVENT_PRIESTESS_SPELL_HOLY_SMITE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_HOLY_SMITE, false);
                    events.RepeatEvent(urand(6000, 8000));
                    break;
                case EVENT_PRIESTESS_SPELL_SHADOW_WORD_PAIN:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_SHADOW_WORD_PAIN, false);
                    events.RepeatEvent(urand(12000, 15000));
                    break;
                case EVENT_PRIESTESS_SPELL_FOUNTAIN_OF_LIGHT:
                    me->CastSpell((Unit*)NULL, SPELL_FOUNTAIN_OF_LIGHT, false);
                    events.RepeatEvent(urand(35000, 45000));
                    break;
                case EVENT_PRIESTESS_SPELL_MIND_CONTROL_H:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true) )
                        me->CastSpell(target, SPELL_MIND_CONTROL_H, false);
                    events.RepeatEvent(urand(22000, 30000));
                    break;

                case EVENT_LIGHTWIELDER_SPELL_BLAZING_LIGHT:
                    {
                        Unit* target = DoSelectLowestHpFriendly(40.0f);
                        if( !target )
                            target = me;
                        me->CastSpell(target, SPELL_BLAZING_LIGHT, false);
                        events.RepeatEvent(urand(8000, 12000));
                    }
                    break;
                case EVENT_LIGHTWIELDER_SPELL_CLEAVE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.RepeatEvent(urand(6000, 8000));
                    break;
                case EVENT_LIGHTWIELDER_SPELL_UNBALANCING_STRIKE_H:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_UNBALANCING_STRIKE_H, false);
                    events.RepeatEvent(urand(12000, 15000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/)
        {
            me->DespawnOrUnsummon(10000);
            if( pInstance )
                pInstance->SetData(DATA_ARGENT_SOLDIER_DEFEATED, 0);
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_argent_soldierAI(pCreature);
    }
};

class spell_eadric_radiance : public SpellScriptLoader
{
public:
    spell_eadric_radiance() : SpellScriptLoader("spell_eadric_radiance") { }

    class spell_eadric_radiance_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_eadric_radiance_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            std::list<WorldObject*> tmplist;
            for( std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                if( (*itr)->ToUnit()->HasInArc(M_PI, GetCaster()) )
                    tmplist.push_back(*itr);

            targets.clear();
            for( std::list<WorldObject*>::iterator itr = tmplist.begin(); itr != tmplist.end(); ++itr )
                targets.push_back(*itr);
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_eadric_radiance_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_eadric_radiance_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_eadric_radiance_SpellScript();
    }
};

class spell_toc5_light_rain : public SpellScriptLoader
{
public:
    spell_toc5_light_rain() : SpellScriptLoader("spell_toc5_light_rain") { }

    class spell_toc5_light_rain_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_toc5_light_rain_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            for( std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); )
            {
                if ((*itr)->GetTypeId() == TYPEID_UNIT)
                    if ((*itr)->ToCreature()->GetEntry() == NPC_FOUNTAIN_OF_LIGHT)
                    {
                        targets.erase(itr);
                        itr = targets.begin();
                        continue;
                    }
                ++itr;
            }
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_toc5_light_rain_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_toc5_light_rain_SpellScript();
    }
};

class spell_reflective_shield : public SpellScriptLoader
{
public:
    spell_reflective_shield() : SpellScriptLoader("spell_reflective_shield") { }

    class spell_reflective_shield_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_reflective_shield_AuraScript)

        void HandleAfterEffectAbsorb(AuraEffect*   /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
        {
            if( Unit* attacker = dmgInfo.GetAttacker() )
                if( GetOwner() && attacker->GetGUID() != GetOwner()->GetGUID() )
                {
                    int32 damage = (int32)(absorbAmount * 0.25f);
                    GetOwner()->ToUnit()->CastCustomSpell(attacker, 33619, &damage, nullptr, nullptr, true);
                }
        }

        void Register()
        {
            AfterEffectAbsorb += AuraEffectAbsorbFn(spell_reflective_shield_AuraScript::HandleAfterEffectAbsorb, EFFECT_0);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_reflective_shield_AuraScript();
    }
};

void AddSC_boss_argent_challenge()
{
    new boss_eadric();
    new boss_paletress();
    new npc_memory();
    new npc_argent_soldier();
    new spell_eadric_radiance();
    new spell_toc5_light_rain();
    new spell_reflective_shield();
}
